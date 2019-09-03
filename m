Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 900FAA6AC2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 16:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbfICOFk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 10:05:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:44816 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725782AbfICOFk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:05:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AD7DCAE2C;
        Tue,  3 Sep 2019 14:05:38 +0000 (UTC)
Date:   Tue, 3 Sep 2019 09:05:36 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        darrick.wong@oracle.com, david@fromorbit.com,
        riteshh@linux.ibm.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 02/15] iomap: Use a IOMAP_COW/srcmap for a
 read-modify-write I/O
Message-ID: <20190903140536.5ak7phk5oydkqmx2@fiona>
References: <20190901200836.14959-1-rgoldwyn@suse.de>
 <20190901200836.14959-3-rgoldwyn@suse.de>
 <20190902163104.GB6263@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902163104.GB6263@lst.de>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 18:31 02/09, Christoph Hellwig wrote:
> On Sun, Sep 01, 2019 at 03:08:23PM -0500, Goldwyn Rodrigues wrote:
> > --- a/include/linux/iomap.h
> > +++ b/include/linux/iomap.h
> > @@ -37,6 +37,7 @@ struct vm_fault;
> >  #define IOMAP_MAPPED	0x03	/* blocks allocated at @addr */
> >  #define IOMAP_UNWRITTEN	0x04	/* blocks allocated at @addr in unwritten state */
> >  #define IOMAP_INLINE	0x05	/* data inline in the inode */
> > +#define IOMAP_COW	0x06	/* copy data from srcmap before writing */
> 
> I don't think IOMAP_COW can be a type - it is a flag given that we
> can do COW operations that allocate normal written extents (e.g. for
> direct I/O or DAX) and for delayed allocations.
> 

Ah.. we have come a full circle on this one. From going to a flag, to a type,
and now back to flag. Personally, I like COW to be a flag, because we are
doing a write, just doining extra steps which should be a flag.
From previous objections, using two iomaps should help the cause and we
can not worry about bloating.


-- 
Goldwyn
