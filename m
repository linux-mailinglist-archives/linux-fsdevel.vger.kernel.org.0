Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E215DA6AE5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 16:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbfICOMl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 10:12:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:52476 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728679AbfICOMl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:12:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0AA4AACFE;
        Tue,  3 Sep 2019 14:12:40 +0000 (UTC)
Date:   Tue, 3 Sep 2019 09:12:38 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, david@fromorbit.com,
        riteshh@linux.ibm.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 02/15] iomap: Use a IOMAP_COW/srcmap for a
 read-modify-write I/O
Message-ID: <20190903141237.7qtppmbqg3eg22fl@fiona>
References: <20190901200836.14959-1-rgoldwyn@suse.de>
 <20190901200836.14959-3-rgoldwyn@suse.de>
 <20190902163104.GB6263@lst.de>
 <20190903031843.GC5340@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903031843.GC5340@magnolia>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20:18 02/09, Darrick J. Wong wrote:
> On Mon, Sep 02, 2019 at 06:31:04PM +0200, Christoph Hellwig wrote:
> > On Sun, Sep 01, 2019 at 03:08:23PM -0500, Goldwyn Rodrigues wrote:
> > > --- a/include/linux/iomap.h
> > > +++ b/include/linux/iomap.h
> > > @@ -37,6 +37,7 @@ struct vm_fault;
> > >  #define IOMAP_MAPPED	0x03	/* blocks allocated at @addr */
> > >  #define IOMAP_UNWRITTEN	0x04	/* blocks allocated at @addr in unwritten state */
> > >  #define IOMAP_INLINE	0x05	/* data inline in the inode */
> > > +#define IOMAP_COW	0x06	/* copy data from srcmap before writing */
> > 
> > I don't think IOMAP_COW can be a type - it is a flag given that we
> > can do COW operations that allocate normal written extents (e.g. for
> > direct I/O or DAX) and for delayed allocations.
> 
> If iomap_apply always zeros out @srcmap before calling ->iomap_begin, do
> we even need a flag/type code?  Or does it suffice to check that
> srcmap.length > 0 and use it appropriately?
> 

While I understand your idea, it would be more robust to use the flag.
Makes it clean and scalable for other aspects of two iomaps (like extent
comparisons).

-- 
Goldwyn
