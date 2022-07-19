Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E085557A8C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 23:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiGSVLE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 17:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiGSVLC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:11:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9998D59278;
        Tue, 19 Jul 2022 14:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ex8VLnkVRDH9VW8GedVb3fp8QXwrAT2+hk3e4CSkF+w=; b=jmFkHHE+Uajr6efIo7IAvxcAHL
        vAvWIjRz7we9eqNK9PC8JKhZA5bRGmlZK1BES6yzi3I+YQXF7KUKxZaPbhlbheInSyACezBl4RFRp
        fSiSvPGQfPhwRd9odsZFawwb9jr4WKt3pj2thhTxED0/Ko2kmQQ98vtz8MHBx1XjaBVBFsAI9xRh3
        xXntLOW9riZAs2j6zD2nMcIhXD9jftG3XnOQTKtPSFdQxv6XDXUtjS38Y7No40x4hhUkccHkh761j
        y77iborV1B9/g0LnsI1zbxMcouCq82s8HUF7TDLou+1RoeTTqhJ2RSCLuam/zRWTbUvpK3Y4/gwGV
        TiJ7T0xA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDuUT-00Dt4n-M8; Tue, 19 Jul 2022 21:10:49 +0000
Date:   Tue, 19 Jul 2022 22:10:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Anna Schumaker <anna@kernel.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v3 6/6] NFSD: Repeal and replace the READ_PLUS
 implementation
Message-ID: <Ytcd2a0RVCccWOmC@casper.infradead.org>
References: <20220715184433.838521-1-anna@kernel.org>
 <20220715184433.838521-7-anna@kernel.org>
 <EC97C20D-A317-49F9-8280-062D1AAEE49A@oracle.com>
 <20220718011552.GK3600936@dread.disaster.area>
 <5A400446-A6FD-436B-BDE2-DAD61239F98F@oracle.com>
 <CAFX2Jfmm6t8V1P3Lt9j2gE_GFpKo51Z8jKPvxdbFoJfVi=dn9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFX2Jfmm6t8V1P3Lt9j2gE_GFpKo51Z8jKPvxdbFoJfVi=dn9A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 19, 2022 at 04:24:18PM -0400, Anna Schumaker wrote:
> On Tue, Jul 19, 2022 at 1:21 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
> > But I also thought the purpose of READ_PLUS was to help clients
> > preserve unallocated extents in files during copy operations.
> > An unallocated extent is not the same as an allocated extent
> > that has zeroes written into it. IIUC this new logic does not
> > distinguish between those two cases at all. (And please correct
> > me if this is really not the goal of READ_PLUS).
> 
> I wasn't aware of this as a goal of READ_PLUS. As of right now, Linux
> doesn't really have a way to punch holes into pagecache data, so we
> and up needing to zero-fill on the client side during decoding.

I've proven myself unqualified to opine on how NFS should be doing
things in the past ... so let me see if I understand how NFS works
for this today.

Userspace issues a read(), the VFS allocates some pages to cache the
data and calls ->readahead() to get the filesystem to fill those pages.
NFS uses READ_PLUS to get the data and the server says "this is a hole,
no data for you", at which point NFS has to call memset() because the
page cache does not have the ability to represent holes?

If so, that pretty much matches how block filesystems work.  Except that
block filesystems know the "layout" of the file; whether they use iomap
or buffer_heads, they can know this without doing I/O (some filesystems
like ext2 delay knowing the layout of the file until an I/O happens,
but then they cache it).

So I think Linux is currently built on assuming the filesystem knows
where its holes are, rather than informing the page cache about its holes.
Could we do better?  Probably!  I'd be interested in seeing what happens
if we add support for "this page is in a hole" to the page cache.
I'd also be interested in seeing how things would change if we had
filesystems provide their extent information to the VFS and have the VFS
handle holes all by itself without troubling the filesystem.  It'd require
network filesystems to invalidate the VFS's knowledge of extents if
another client modifies the file.  I haven't thought about it deeply.

