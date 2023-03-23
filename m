Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416796C5D2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 04:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjCWD0x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 23:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCWD0v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 23:26:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F9B2595D;
        Wed, 22 Mar 2023 20:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PUObvHze7ahZs4YqVo863XKMZRFBTex2ma8xL3E1SBg=; b=UQdaznGs+lhoyIxI57a5NKI1FA
        8vGXVzusnjeKgdlRswl0gug/YXUxtHVB8dQQ2FgGic9Mh36NEHdYGouSeQy4XX2O98BwuPJHevXeJ
        hESZKTO6v+wPdAaKHwAJO/XqS1jDbH+OQZTZ2Bsw/SGT7oSdmEf6J6tkYMCEbjeyOenvnj+aPwSz0
        CuI2aM7rd4Y1f/88A5apulVmjX/CKvjErMkcvXbqKV9PtRB2hw58FSKdnD3oIbAxsbNijtcgqXglO
        WXrldsfouoiIBNLdbGa4aRmP5vwIikNQzvADP/ZLTJMF7d4JoxBxlLL81T5cB3YKWsTmlMqe2ieCN
        y/e1GpEg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfBb9-003dTO-Ke; Thu, 23 Mar 2023 03:26:43 +0000
Date:   Thu, 23 Mar 2023 03:26:43 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/31] ext4: Convert ext4_finish_bio() to use folios
Message-ID: <ZBvG8xbGHwQ+PPQa@casper.infradead.org>
References: <20230126202415.1682629-5-willy@infradead.org>
 <87ttyy1bz4.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttyy1bz4.fsf@doe.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 06, 2023 at 02:40:55PM +0530, Ritesh Harjani wrote:
> "Matthew Wilcox (Oracle)" <willy@infradead.org> writes:
> 
> > Prepare ext4 to support large folios in the page writeback path.
> 
> Sure. I am guessing for ext4 to completely support large folio
> requires more work like fscrypt bounce page handling doesn't
> yet support folios right?
> 
> Could you please give a little background on what all would be required
> to add large folio support in ext4 buffered I/O path?
> (I mean ofcourse other than saying move ext4 to iomap ;))
> 
> What I was interested in was, what other components in particular for
> e.g. fscrypt, fsverity, ext4's xyz component needs large folio support?
> 
> And how should one go about in adding this support? So can we move
> ext4's read path to have large folio support to get started?
> Have you already identified what all is missing from this path to
> convert it?

Honestly, I don't know what else needs to be done beyond this patch
series.  I can point at some stuff and say "This doesn't work", but in
general, you have to just enable it and see what breaks.  A lot of the
buffer_head code is not large-folio safe right now, so that's somewhere
to go and look.  Or maybe we "just" convert to iomap, and never bother
fixing the bufferhead code for large folios.

> > Also set the actual error in the mapping, not just -EIO.
> 
> Right. I looked at the history and I think it always just had EIO.
> I think setting the actual err in mapping_set_error() is the right thing
> to do here.
> 
> >
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> w.r.t this patch series. I reviewed the mechanical changes & error paths
> which converts ext4 ext4_finish_bio() to use folio.
> 
> The changes looks good to me from that perspective. Feel free to add -
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks!
