Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20FBEA126C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 09:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfH2HP7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 03:15:59 -0400
Received: from verein.lst.de ([213.95.11.211]:43710 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfH2HP7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 03:15:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8DD4268B20; Thu, 29 Aug 2019 09:15:55 +0200 (CEST)
Date:   Thu, 29 Aug 2019 09:15:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        adilger@dilger.ca, jaegeuk@kernel.org, darrick.wong@oracle.com,
        miklos@szeredi.hu, rpeterso@redhat.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 8/9] Use FIEMAP for FIBMAP calls
Message-ID: <20190829071555.GF11909@lst.de>
References: <20190808082744.31405-1-cmaiolino@redhat.com> <20190808082744.31405-9-cmaiolino@redhat.com> <20190814111837.GE1885@lst.de> <20190820130117.gcemlpfrkqlpaaiz@pegasus.maiolino.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820130117.gcemlpfrkqlpaaiz@pegasus.maiolino.io>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 20, 2019 at 03:01:18PM +0200, Carlos Maiolino wrote:
> On Wed, Aug 14, 2019 at 01:18:37PM +0200, Christoph Hellwig wrote:
> > The whole FIEMAP_KERNEL_FIBMAP thing looks very counter productive.
> > bmap() should be able to make the right decision based on the passed
> > in flags, no need to have a fake FIEMAP flag for that.
> 
> Using the FIEMAP_KERNEL_FIBMAP flag, is a way to tell filesystems from where the
> request came from, so filesystems can handle it differently. For example, we
> can't allow in XFS a FIBMAP request on a COW/RTIME inode, and we use the FIBMAP
> flag in such situations.

But the whole point is that the file system should not have to know
this.  It is not the file systems business in any way to now where the
call came from.  The file system just needs to provide enough information
so that the caller can make informed decisions.

And in this case that means if any of FIEMAP_EXTENT_DELALLOC,
FIEMAP_EXTENT_ENCODED, FIEMAP_EXTENT_DATA_ENCRYPTED,
FIEMAP_EXTENT_NOT_ALIGNED, FIEMAP_EXTENT_DATA_INLINE,
FIEMAP_EXTENT_DATA_TAIL, FIEMAP_EXTENT_UNWRITTEN or
FIEMAP_EXTENT_SHARED is present the caller should fail the
bmap request.
