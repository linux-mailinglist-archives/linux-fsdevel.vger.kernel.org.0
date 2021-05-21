Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0ED38C0D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 09:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbhEUHhM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 03:37:12 -0400
Received: from verein.lst.de ([213.95.11.211]:46821 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230050AbhEUHhM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 03:37:12 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 17A246736F; Fri, 21 May 2021 09:35:47 +0200 (CEST)
Date:   Fri, 21 May 2021 09:35:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Brian Foster <bfoster@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: iomap: writeback ioend/bio allocation deadlock risk
Message-ID: <20210521073547.GA11955@lst.de>
References: <YKcouuVR/y/L4T58@T590> <20210521071727.GA11473@lst.de> <YKdhuUZBtKMxDpsr@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKdhuUZBtKMxDpsr@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 21, 2021 at 03:31:05PM +0800, Ming Lei wrote:
> > iomap_ioend_bioset is sized to make sure we can always complete up
> > to 4 pages, and the list is only used inside a page, so we're fine.
> 
> The number itself does not matter, because there isn't any limit on how
> many ioends can be allocated before submitting, for example, it can be
> observed that 64 ioends is allocated before submitting when writing
> 5GB file to ext4. So far the reserved pool size is 32.

How do you manage to allocate iomap ioends when writing to ext4?  ext4
doesn't use iomap for buffered I/O.

> > fs_bio_set always has two entries to allow exactly for the common
> > chain and submit pattern.
> 
> It is easy to trigger dozens of chained bios in one ioend when writing
> big file to XFS.

Yes, we can still have one chained bio per ioend, so we need a bioset
with the same size as iomap_ioend_bioset.  That still should not be
dozends for a common setup, though.
