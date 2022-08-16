Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9595B59605A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 18:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbiHPQc1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 12:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236528AbiHPQcO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 12:32:14 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F67804B4
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 09:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=33mlf84VeN3RMXDr4wbd7gccNqGp6bNVLWgscw/BVOo=; b=dT67gmR2osXhxvwGgRunD4uD/j
        ajLvsB4JYa0Ges0V+HMVA/fSd/Bj5Ediu1mErf3TpiScaZNya0eFX77M53ir3WoTLDxB7NusKfBxT
        CnsKosxYvpizuGGmHZokuYCz7mb4IMa5AO6e1CZB/us2/Evz3Q0Tkhn724wj76nWWPZ77kh32zbyT
        IDSlr2YxWZNLRxBp1zouTbXvnmP4ZygTniTLT/T4CZcXsh9jc88RTG+hpawHy6QTl63wTIgMJeW0M
        TJw7VlJpSb8i0ib3p9NbbiEZxg+cGtyukl75ZIe9Wthyjz7+LZqxMbNr+g2WHDY6Of7/sr0Nn6LjL
        bXn0ms3g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oNzU8-00577O-SC;
        Tue, 16 Aug 2022 16:32:08 +0000
Date:   Tue, 16 Aug 2022 17:32:08 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] Change calling conventions for filldir_t
Message-ID: <YvvGiLlrzXandedE@ZenIV>
References: <YvvBs+7YUcrzwV1a@ZenIV>
 <YvvEsGWvarSwW5kh@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvvEsGWvarSwW5kh@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 05:24:16PM +0100, Matthew Wilcox wrote:
> > The former tended to use 0/-E... conventions - -E<something> on failure.
> > The latter tended to use 0/1, 1 being "stop, we are done".
> > The callers treated anything non-zero as "stop", ignoring which
> > non-zero value did they get.
> > 
> > "true means stop" would be more natural for the second group; "true
> > means keep going" - for the first one.  I tried both variants and
> > the things like
> > 	if allocation failed
> > 		something = -ENOMEM;
> > 		return true;
> > just looked unnatural and asking for trouble.
> 
> I like it the way you have it.  My only suggestion is:
> 
> +++ b/include/linux/fs.h
> @@ -2039,6 +2039,7 @@ extern bool may_open_dev(const struct path *path);
>   * the kernel specify what kind of dirent layout it wants to have.
>   * This allows the kernel to read directories into kernel space or
>   * to have different dirent layouts depending on the binary type.
> + * Return 'true' to keep going and 'false' if there are no more entries.
>   */
>  struct dir_context;
>  typedef int (*filldir_t)(struct dir_context *, const char *, int, loff_t, u64,

OK...  FWIW, an additional argument is that ->iterate() instances are
not calling those directly - they are calling dir_emit(), which returns
true for "keep going" and false for "stop".  This makes the calling
conventions for callbacks match that...
