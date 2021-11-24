Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EC045B4C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 07:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238750AbhKXHCv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 02:02:51 -0500
Received: from verein.lst.de ([213.95.11.211]:35904 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhKXHCu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 02:02:50 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2A62068AFE; Wed, 24 Nov 2021 07:59:38 +0100 (CET)
Date:   Wed, 24 Nov 2021 07:59:38 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 25/29] dax: return the partition offset from
 fs_dax_get_by_bdev
Message-ID: <20211124065938.GB7229@lst.de>
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-26-hch@lst.de> <CAPcyv4jtWzd3c_S1_4fYA1SXTJZfBzP_1xk_OwYkeNp0UhxwSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jtWzd3c_S1_4fYA1SXTJZfBzP_1xk_OwYkeNp0UhxwSg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 06:56:29PM -0800, Dan Williams wrote:
> On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Prepare from removing the block_device from the DAX I/O path by returning
> 
> s/from removing/for the removal of/

Fixed.

> >         td->dm_dev.bdev = bdev;
> > -       td->dm_dev.dax_dev = fs_dax_get_by_bdev(bdev);
> > +       td->dm_dev.dax_dev = fs_dax_get_by_bdev(bdev, &part_off);
> 
> Perhaps allow NULL as an argument for callers that do not care about
> the start offset?

All callers currently care, dm just has another way to get at the
information.  So for now I'd like to not add the NULL special case,
but we can reconsider that as needed if/when more callers show up.
