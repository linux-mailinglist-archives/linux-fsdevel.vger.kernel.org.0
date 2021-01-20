Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88352FD738
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 18:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732030AbhATRet (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 12:34:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:36582 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbhATR2B (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:28:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 031EDAC9B;
        Wed, 20 Jan 2021 17:27:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AE9351E0802; Wed, 20 Jan 2021 18:27:05 +0100 (CET)
Date:   Wed, 20 Jan 2021 18:27:05 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: Provide address_space operation for filling
 pages for read
Message-ID: <20210120172705.GC24063@quack2.suse.cz>
References: <20210120160611.26853-1-jack@suse.cz>
 <20210120160611.26853-3-jack@suse.cz>
 <20210120162001.GB3790454@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120162001.GB3790454@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 20-01-21 16:20:01, Christoph Hellwig wrote:
> On Wed, Jan 20, 2021 at 05:06:10PM +0100, Jan Kara wrote:
> > Provide an address_space operation for filling pages needed for read
> > into page cache. Filesystems can use this operation to seriealize
> > page cache filling with e.g. hole punching properly.
> 
> Besides the impending rewrite of the area - having another indirection
> here is just horrible for performance.  If we want locking in this area
> it should be in core code and common for multiple file systems.

This would mean pulling i_mmap_sem out from ext4/XFS/F2FS private inode
into the VFS inode. Which is fine by me but it would grow struct inode for
proc / tmpfs / btrfs (although for btrfs I'm not convinced it isn't
actually prone to the race and doesn't need similar protection as xfs /
ext4) so some people may object.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
