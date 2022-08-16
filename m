Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60C4596018
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 18:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbiHPQYW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 12:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236107AbiHPQYU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 12:24:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690B067140
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 09:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ej0EpEiQD92pwa8HGtIJilS29dEOyPL1dmLFrpRhAgQ=; b=DX5MttLPHTcXulIdPtNoANzgKR
        ovW3HHruGIywk07lUOKWUlDI0wEuf8jUk6NTcG00XpM+ZyCGHmnTJg5YyVA+cN30hFhAOftvF6LHr
        QC3PFQJ94yyxT3EhtB1cePz8odUWob4B3yurGS5b640iLV+9E8P2U3gdN/A+M/3TIAR0/70X0TA0i
        rGcRCz/jjo4QHM0DXjC5B088GYm3Sy5sBjE4XP/y1eSjkIw9Laf7ZnMZvwrkNm8yW8WH+9lB8hNSB
        8dQoCAEl4IjPC/P/usKQ1YolWU6bI4zMxYSDSO6fMEj1wEBGeAvhGQkbPnZPoPojMT1QsgDRlmaAU
        dQufd8Ng==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNzMW-0077is-OA; Tue, 16 Aug 2022 16:24:16 +0000
Date:   Tue, 16 Aug 2022 17:24:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] Change calling conventions for filldir_t
Message-ID: <YvvEsGWvarSwW5kh@casper.infradead.org>
References: <YvvBs+7YUcrzwV1a@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvvBs+7YUcrzwV1a@ZenIV>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 05:11:31PM +0100, Al Viro wrote:
> filldir_t instances (directory iterators callbacks) used to return 0 for
> "OK, keep going" or -E... for "stop".  Note that it's *NOT* how the
> error values are reported - the rules for those are callback-dependent
> and ->iterate{,_shared}() instances only care about zero vs. non-zero
> (look at emit_dir() and friends).
> 
> So let's just return bool ("should we keep going?") - it's less confusing
> that way.  The choice between "true means keep going" and "true means
> stop" is bikesheddable; we have two groups of callbacks -
>     do something for everything in directory, until we run into problem
> and
>     find an entry in directory and do something to it.
> 
> The former tended to use 0/-E... conventions - -E<something> on failure.
> The latter tended to use 0/1, 1 being "stop, we are done".
> The callers treated anything non-zero as "stop", ignoring which
> non-zero value did they get.
> 
> "true means stop" would be more natural for the second group; "true
> means keep going" - for the first one.  I tried both variants and
> the things like
> 	if allocation failed
> 		something = -ENOMEM;
> 		return true;
> just looked unnatural and asking for trouble.

I like it the way you have it.  My only suggestion is:

+++ b/include/linux/fs.h
@@ -2039,6 +2039,7 @@ extern bool may_open_dev(const struct path *path);
  * the kernel specify what kind of dirent layout it wants to have.
  * This allows the kernel to read directories into kernel space or
  * to have different dirent layouts depending on the binary type.
+ * Return 'true' to keep going and 'false' if there are no more entries.
  */
 struct dir_context;
 typedef int (*filldir_t)(struct dir_context *, const char *, int, loff_t, u64,

> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 9eced4cc286e..8b8c0c11afec 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2040,7 +2040,7 @@ umode_t mode_strip_sgid(struct user_namespace *mnt_userns,
>   * to have different dirent layouts depending on the binary type.
>   */
>  struct dir_context;
> -typedef int (*filldir_t)(struct dir_context *, const char *, int, loff_t, u64,
> +typedef bool (*filldir_t)(struct dir_context *, const char *, int, loff_t, u64,
>  			 unsigned);
>  
>  struct dir_context {
