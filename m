Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4568636C983
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 18:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbhD0QfL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 12:35:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:7390 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236572AbhD0QfK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:35:10 -0400
IronPort-SDR: HYRBlxVa1vrEPy+SPu0HGOHo217i1v6Yl+w9Z2c+pbzQqNqfrYGNuYLQp2fZLNn0BS6irPJ2ld
 RKb0la7tLlTQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="257849526"
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="257849526"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 09:34:26 -0700
IronPort-SDR: 56D78GrkzT0gyka0rNNSqxAB64SKTQBfDo09R45Rx5juh+b57u47vkvt8mJ1A0sUvLEYL9+9Ep
 DD9gzPzKoa8w==
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="429877058"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 09:34:26 -0700
Date:   Tue, 27 Apr 2021 09:34:26 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] fsdax: Factor helpers to simplify dax fault code
Message-ID: <20210427163425.GW1904484@iweiny-DESK2.sc.intel.com>
References: <20210422134501.1596266-1-ruansy.fnst@fujitsu.com>
 <20210422134501.1596266-2-ruansy.fnst@fujitsu.com>
 <20210426233823.GT1904484@iweiny-DESK2.sc.intel.com>
 <OSBPR01MB292025E6E88319A902C980FEF4419@OSBPR01MB2920.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB292025E6E88319A902C980FEF4419@OSBPR01MB2920.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 27, 2021 at 02:44:33AM +0000, ruansy.fnst@fujitsu.com wrote:
> > -----Original Message-----
> > From: Ira Weiny <ira.weiny@intel.com>
> > Sent: Tuesday, April 27, 2021 7:38 AM
> > Subject: Re: [PATCH v3 1/3] fsdax: Factor helpers to simplify dax fault code
> > 
> > On Thu, Apr 22, 2021 at 09:44:59PM +0800, Shiyang Ruan wrote:
> > > The dax page fault code is too long and a bit difficult to read. And
> > > it is hard to understand when we trying to add new features. Some of
> > > the PTE/PMD codes have similar logic. So, factor them as helper
> > > functions to simplify the code.
> > >
> > > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > > ---
> > >  fs/dax.c | 153
> > > ++++++++++++++++++++++++++++++-------------------------
> > >  1 file changed, 84 insertions(+), 69 deletions(-)
> > >
> > > diff --git a/fs/dax.c b/fs/dax.c
> > > index b3d27fdc6775..f843fb8fbbf1 100644
> > > --- a/fs/dax.c
> > > +++ b/fs/dax.c
> > 
> > [snip]
> > 
> > > @@ -1355,19 +1379,8 @@ static vm_fault_t dax_iomap_pte_fault(struct
> > vm_fault *vmf, pfn_t *pfnp,
> > >  		entry = dax_insert_entry(&xas, mapping, vmf, entry, pfn,
> > >  						 0, write && !sync);
> > >
> > > -		/*
> > > -		 * If we are doing synchronous page fault and inode needs fsync,
> > > -		 * we can insert PTE into page tables only after that happens.
> > > -		 * Skip insertion for now and return the pfn so that caller can
> > > -		 * insert it after fsync is done.
> > > -		 */
> > >  		if (sync) {
> > > -			if (WARN_ON_ONCE(!pfnp)) {
> > > -				error = -EIO;
> > > -				goto error_finish_iomap;
> > > -			}
> > > -			*pfnp = pfn;
> > > -			ret = VM_FAULT_NEEDDSYNC | major;
> > > +			ret = dax_fault_synchronous_pfnp(pfnp, pfn);
> > 
> > I commented on the previous version...  So I'll ask here too.
> > 
> > Why is it ok to drop 'major' here?
> 
> This dax_iomap_pte_fault () finally returns 'ret | major', so I think the major here is not dropped.  The origin code seems OR the return value and major twice.
> 

Thanks I missed that!
Ira

