Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E91433404F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 15:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbhCJO1T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 09:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhCJO0v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 09:26:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29023C061760;
        Wed, 10 Mar 2021 06:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fMRcAUQViDFbKSMCzio+nZwR3R7d5z+5tJ4oYqUVAyM=; b=DX3yw+7jm8vk9+eflfEViPntiM
        iSRvWHzc9BxqlUmr+6/Vkm+qr6xjowBVUFsKtF0EEGRn5WNMMNKA79ysVFg64GdBFelo3aUDgyq7p
        cGt+Z/bf01+Wl4HA0Bk1VjCX/q3YZs3OAVLSWY3XSqWG2a7L34LbeaMH3hHvdwodIvUfKxym4i9l7
        umdcaXJUac96k4gdNzC2XXyI8murWFW7EfACp9WA3JFUGr+iogourTMBlCtmFEh7Uutlb6qXjRXlW
        vw2UZ/8FJ1hREoKp3KcvS6Z7hici2aTs/J5tJ6YKg1N8rongRZND9sgpPrZbkQDxKnX+sxE29HOrw
        9PoWbUvg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lJznP-003gjI-VB; Wed, 10 Mar 2021 14:26:45 +0000
Date:   Wed, 10 Mar 2021 14:26:43 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Neal Gompa <ngompa13@gmail.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        darrick.wong@oracle.com, dan.j.williams@intel.com, jack@suse.cz,
        viro@zeniv.linux.org.uk, Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
Message-ID: <20210310142643.GQ3479805@casper.infradead.org>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <CAEg-Je-OLidbfzHCJvY55x+-cOfiUxX8CJ1AeN8VxXAVuVyxKQ@mail.gmail.com>
 <20210310130227.GN3479805@casper.infradead.org>
 <20210310142159.kudk7q2ogp4yqn36@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310142159.kudk7q2ogp4yqn36@fiona>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 10, 2021 at 08:21:59AM -0600, Goldwyn Rodrigues wrote:
> On 13:02 10/03, Matthew Wilcox wrote:
> > On Wed, Mar 10, 2021 at 07:30:41AM -0500, Neal Gompa wrote:
> > > Forgive my ignorance, but is there a reason why this isn't wired up to
> > > Btrfs at the same time? It seems weird to me that adding a feature
> > 
> > btrfs doesn't support DAX.  only ext2, ext4, XFS and FUSE have DAX support.
> > 
> > If you think about it, btrfs and DAX are diametrically opposite things.
> > DAX is about giving raw access to the hardware.  btrfs is about offering
> > extra value (RAID, checksums, ...), none of which can be done if the
> > filesystem isn't in the read/write path.
> > 
> > That's why there's no DAX support in btrfs.  If you want DAX, you have
> > to give up all the features you like in btrfs.  So you may as well use
> > a different filesystem.
> 
> DAX on btrfs has been attempted[1]. Of course, we could not

But why?  A completeness fetish?  I don't understand why you decided
to do this work.

> have checksums or multi-device with it. However, got stuck on
> associating a shared extent on the same page mapping: basically the
> TODO above dax_associate_entry().
> 
> Shiyang has proposed a way to disassociate existing mapping, but I
> don't think that is the best solution. DAX for CoW will not work until
> we have a way of mapping a page to multiple inodes (page->mapping),
> which will convert a 1-N inode-page mapping to M-N inode-page mapping.

If you're still thinking in terms of pages, you're doing DAX wrong.
DAX should work without a struct page.
