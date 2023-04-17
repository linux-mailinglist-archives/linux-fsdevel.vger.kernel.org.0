Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAD96E4D6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 17:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjDQPkV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 11:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjDQPkU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:40:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A95C145;
        Mon, 17 Apr 2023 08:40:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C5DF62049;
        Mon, 17 Apr 2023 15:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A62CC433EF;
        Mon, 17 Apr 2023 15:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681746009;
        bh=Ct1SScPIzDNRIt4RDA3X/shUOw1Xw3+mqc/PCLpW23o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t07U6pldJ/amL9H0/1sY2jhYYH9ZkRIwH4n3OoG1oC65WpCQ7nwP3mwnumrAWd+jf
         8B/j4ORuXVj6/7D2n+/jC7NBrSM183DaBikNJT33HJCsCrSIGD1Q5d3dsAeaT576O7
         07fzfU1ZxOZXAxb+tA7YvT6/eUXisf/E76IjO1es+JnWao8Binyf/zl1Dx+GM6jURW
         n6XZDJq1DHVve+QzHv+gpoIgkdhS9Ab35XhHkOlpxbuLGqxo02VP5u61IgU4xO+vBn
         0N3/e+c935BTOr4APFDPEZtVsU3uvcSjCctgbCGtg+jrvE6DsEGNVuh5mohqSozsZq
         yapuFJT97D/Ew==
Date:   Mon, 17 Apr 2023 08:40:09 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Pankaj Raghav <p.raghav@samsung.com>,
        "kbus >> Keith Busch" <kbusch@kernel.org>, brauner@kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gost.dev@samsung.com
Subject: Re: [RFC 0/4] convert create_page_buffers to create_folio_buffers
Message-ID: <20230417154009.GC360881@frogsfrogsfrogs>
References: <ZDn3XPMA024t+C1x@bombadil.infradead.org>
 <ZDoMmtcwNTINAu3N@casper.infradead.org>
 <ZDoZCJHQXhVE2KZu@bombadil.infradead.org>
 <ZDodlnm2nvYxbvR4@casper.infradead.org>
 <31765c8c-e895-4207-2b8c-39f6c7c83ece@suse.de>
 <ZDraOHQHqeabyCvN@casper.infradead.org>
 <ZDtPK5Qdts19bKY2@bombadil.infradead.org>
 <ZDtuFux7FGlCMkC3@casper.infradead.org>
 <ZDuHEolre/saj8iZ@bombadil.infradead.org>
 <ZDwBJVmIN3tLFhXI@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDwBJVmIN3tLFhXI@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 16, 2023 at 03:07:33PM +0100, Matthew Wilcox wrote:
> On Sat, Apr 15, 2023 at 10:26:42PM -0700, Luis Chamberlain wrote:
> > On Sun, Apr 16, 2023 at 04:40:06AM +0100, Matthew Wilcox wrote:
> > > I don't think we
> > > should be overriding the aops, and if we narrow the scope of large folio
> > > support in blockdev t only supporting folio_size == LBA size, it becomes
> > > much more feasible.
> > 
> > I'm trying to think of the possible use cases where folio_size != LBA size
> > and I cannot immediately think of some. Yes there are cases where a
> > filesystem may use a different block for say meta data than data, but that
> > I believe is side issue, ie, read/writes for small metadata would have
> > to be accepted. At least for NVMe we have metadata size as part of the
> > LBA format, but from what I understand no Linux filesystem yet uses that.
> 
> NVMe metadata is per-block metadata -- a CRC or similar.  Filesystem
> metadata is things like directories, inode tables, free space bitmaps,
> etc.
> 
> > struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,   
> >                 bool retry)                                                     
> > { 
> [...]
> >         head = NULL;  
> >         offset = PAGE_SIZE;                                                     
> >         while ((offset -= size) >= 0) {                                         
> > 
> > I see now what you say about the buffer head being of the block size
> > bh->b_size = size above.
> 
> Yes, just changing that to 'offset = page_size(page);' will do the trick.
> 
> > > sb_bread() is used by most filesystems, and the buffer cache aliases
> > > into the page cache.
> > 
> > I see thanks. I checked what xfs does and its xfs_readsb() uses its own
> > xfs_buf_read_uncached(). It ends up calling xfs_buf_submit() and
> > xfs_buf_ioapply_map() does it's own submit_bio(). So I'm curious why
> > they did that.
> 
> IRIX didn't have an sb_bread() ;-)
> 
> > > In userspace, if I run 'dd if=blah of=/dev/sda1 bs=512 count=1 seek=N',
> > > I can overwrite the superblock.  Do we want filesystems to see that
> > > kind of vandalism, or do we want the mounted filesystem to have its
> > > own copy of the data and overwrite what userspace wrote the next time it
> > > updates the superblock?
> > 
> > Oh, what happens today?
> 
> Depends on the filesystem, I think?  Not really sure, to be honest.

The filesystem driver sees the vandalism, and can very well crash as a
result[1].  In that case it was corrupted journal contents being
replayed, but the same thing would happen if you wrote a malicious
userspace program to set the metadata_csum feature flag in the ondisk
superblock after mounting the fs.

https://bugzilla.kernel.org/show_bug.cgi?id=82201#c4

I've tried to prevent people from writing to mounted block devices in
the past, but did not succeed.  If you try to prevent programs from
opening such devices with O_RDWR/O_WRONLY you then break lvm tools which
require that ability even though they don't actually write anything to
the block device.  If you make the block device write_iter function
fail, then old e2fsprogs breaks and you get shouted at for breaking
userspace.

Hence I decided to let security researchers find these bugs and control
the design discussion via CVE.  That's not correct and it's not smart,
but it preserves some of my sanity.

--D
