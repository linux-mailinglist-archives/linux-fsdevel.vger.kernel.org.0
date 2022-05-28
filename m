Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB93536E25
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 May 2022 21:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiE1TIu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 May 2022 15:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiE1TIs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 May 2022 15:08:48 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C69F27B19
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 May 2022 12:08:42 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24SIxVPw001934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 May 2022 14:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1653764373; bh=WG/9y43YVTYUGGdg0XiluI1UzSrpDLWQtVRIcUa+30k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=NdEO1lcgtnv0yvpDMOSyvaWt5+liMNaVkEKCRAgoYm5+M7ALjaVQ05p0jWq4/PcpS
         cXry5ARpiDQ4wsAeAru3iiqOxOQh2KzLDsWtb5qSJZHLnJG3JQyG1DqfGwhztEXxCs
         z7M7huHxqFFWJqipqjLfHjKEr0VggBrMRx1tB4ABXt+ZoU1L+WVv/NDXJ6+eB7u8QZ
         J76f94DQoXK44mrZVuU/i+FKzEt4QzP/vN8BI9g1BueINpDStvrGPQxNg61iK9ZiUb
         w6+aOcemwdVjjPJYOVje8esW/wLnGGwtYBGmTm/Lzqo7Iu6tA55BSgFM2RWYs0Fm4m
         1FcFjvOqqanUQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 783FB15C009C; Sat, 28 May 2022 14:59:31 -0400 (EDT)
Date:   Sat, 28 May 2022 14:59:31 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "linux-ext4@vger.kernel.org Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [RFC PATCH 0/9] Convert JFS to use iomap
Message-ID: <YpJxEwl+t93pSKLk@mit.edu>
References: <20220526192910.357055-1-willy@infradead.org>
 <20220528000216.GG3923443@dread.disaster.area>
 <YpGF3ceSLt7J/UKn@casper.infradead.org>
 <20220528053639.GI3923443@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220528053639.GI3923443@dread.disaster.area>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+linux-ext4

On Sat, May 28, 2022 at 03:36:39PM +1000, Dave Chinner wrote:
> The other filesystem that uses nobh is the standalone ext2
> filesystem that nobody uses anymore as the ext4 module provides ext2
> functionality for distros these days. Hence there's an argument that
> can be made for removing fs/ext2 as well. In which case, the whole
> nobh problem goes away by deprecating and removing both the
> filesysetms that use that infrastructure in 2 years time....

This got brought up at this past week's ext4 video chat, where Willy
asked Jan (who has been maintaining ext2) whether he would be open to
converting ext2 to use iomap.  The answer was yes.  So once jfs and
ext2 are converted, we'll be able to nuke the nobh code.

From Willy's comments on the video chat, my understanding is that jfs
was even simpler to convert that ext2, and this allows us to remove
the nobh infrastructure without asking the question about whether it's
time to remove jfs.

> > We also need to convert more filesystems to use iomap.
> 
> We also need to deprecate and remove more largely unmaintained and
> unused filesystems. :)

Well, Dave Kleikamp is still around and sends jfs pull requests from
time to time, and so it's not as unmaintained as, say, fs/adfs,
fs/freevxs, fs/hpfs, fs/minix, and fs/sysv.

As regards to minixfs, I'd argue that ext2 is a better reference file
system than minixfs.  So..... are we ready to remove minixfs?  I could
easily see that some folks might still have sentimental attachment to
minixfs.  :-)

> Until ext4 is converted to use iomap, we realistically cannot ask
> anyone to use iomap....

That's something that we've been discussing on the ext4 video chats.
What we can probably do is to convert buffered I/O to use iomap in
stages, first starting with the easy case, and then progressing to the
more complex ones:

     * page_size == block_size, !fscrypt, !fsverity, !data=journal
     * page_size != block_size, !fscrypt, !fsverity, !data=journal
     * fsverity
     * fscrypt

At that point, the hard, remaining case is what to do with
data=journal.  data=journal is already barely maintained; we don't
support direct i/o, delayed allocation, etc., There have been some
specialized users for it, but it's probably more for interesting
research applications than anything else.

So the question is whether we keep it as a special case, and never
convert it over to iomap, or decide that it's time to deprecate and
rip out data=journal support.  We don't need to make that decision
right away, and so long as it remains a special case where it doesn't
burden the rest of the kernel, we might end up keeping it so long as
it remains a minimal maintenance burden for ext4.  I duuno....

In any case, rest assured that there have been quite a lot of
discussions about how to convert all (or 99.99%) of ext4 to use iomap.

Cheers,

						- Ted
