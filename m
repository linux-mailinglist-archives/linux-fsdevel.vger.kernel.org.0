Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38396531442
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 18:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238420AbiEWQPX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 12:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbiEWQPR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 12:15:17 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56A965408
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 09:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Vc4OtJqyC159wZB5RGxu5AiLKIab3J4xdy+stVwOxKg=; b=R6u7bmEJ1AyyfUIAd/LkV2pHPF
        hqWYupWYEQ3HOEvYiAM+IooUGWbHJhkpWP+Vm/c7T3c0xjgJBLYaxAJRNzp1uzAETYNGdngnm1wD1
        8Jg936wALnOQ0++waXkpX/I+AF6hi45Hp46gMQEg5NMzrvTOZ39RkBTCJrKtqZKjTZnAzq0vvcwFO
        fYcuf5BAmvkPe3JAomhLGqoJ8asLipJj7eLtpK6ThIKOlzhmcBiikbQjg99DK3hBGov7UlxL67JBf
        uRK6lB1pe65i+U8lsKSvSJx1EIVtnzZbI5X0svlpPOfbjtR5I8cu2c8mkbS5EGzWyFU6/kGvYlfgG
        /hVYb+/w==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntAi9-00HWqd-Ai; Mon, 23 May 2022 16:15:13 +0000
Date:   Mon, 23 May 2022 16:15:13 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <YouzEUI5kBTq46C6@zeniv-ca.linux.org.uk>
References: <1b2cb369-2247-8c10-bd6e-405a8167f795@kernel.dk>
 <YorYeQpW9nBJEeSx@zeniv-ca.linux.org.uk>
 <290daf40-a5f6-01f8-0764-2f4eb96b9d40@kernel.dk>
 <22de2da8-7db0-68c5-2c85-d752a67f9604@kernel.dk>
 <9c3a6ad4-cdb5-8e0d-9b01-c2825ea891ad@kernel.dk>
 <6ea33ba8-c5a3-a1e7-92d2-da8744662ed9@kernel.dk>
 <YouYvxEl1rF2QO5K@zeniv-ca.linux.org.uk>
 <0343869c-c6d1-5e7c-3bcb-f8d6999a2e04@kernel.dk>
 <YoueZl4Zx0WUH3CS@zeniv-ca.linux.org.uk>
 <6594c360-0c7c-412f-29c9-377ddda16937@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6594c360-0c7c-412f-29c9-377ddda16937@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 23, 2022 at 09:12:32AM -0600, Jens Axboe wrote:
> > There's several more, AFAICS (cifs, ceph, fuse, gfs2)...  The check in
> > /dev/fuse turned out to be fine - it's only using primitives, so we
> > can pass ITER_UBUF ones there.  mm/shmem.c check... similar, but I
> > really wonder if x86 clear_user() really sucks worse than
> > copy_to_user() from zero page...
> 
> Yep, not surprised if it isn't complete, I just tackled the ones I
> found. I do like the idea of having a generic check for that rather
> than implicit knowledge about which iter types may contain user memory.
> 
> I haven't looked at clear_user() vs copy_to_user() from the zero page.
> But should be trivial to benchmark and profile. I'll try and do that
> when I find some time.

FWIW, having looked at __clear_user() in arch/x86/lib/usercopy_64.c...
I'm not at all surprised.  It should be parallel to memset_64.S;
as it is, we have
	loop with one 64bit store per iteration + loop with 8bit stores
for the tail, with no attempts to align anything
vs.
	rep stosb if CPU has optimized rep stosb; otherwise
	rep stosq + rep stosb on CPUs that don't suck at rep sto* in general;
	otherwise align, then do loop with 8*64bit stores, then loop with
	64bit stores, then loop with 8bit stores

Shouldn't be hard to do uaccess parallel for that.  Reads from /dev/zero,
if nothing else, would benefit...

Might be worth doing what sparc does, with shared asm for both - it's
an out-of-line code anyway, with most of the payload trivially shared...
