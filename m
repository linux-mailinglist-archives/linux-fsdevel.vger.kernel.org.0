Return-Path: <linux-fsdevel+bounces-51614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45412AD95D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 21:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF2D67AE79D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 19:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9343E24676E;
	Fri, 13 Jun 2025 19:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UYraGh4N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ADE1A76AE;
	Fri, 13 Jun 2025 19:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749844336; cv=none; b=nzUlCyMFINbu2mHgqpq8iGGZEfwDM4hObISdQie3xAt0rHmRoWOis84BAnms0liTZHK13B5LSh/y9BVBwdf1djRlLVt91reVuZTD9LsHoUAh/OrjozFICDLgWx2DDwtREweCpqQNEGC/ZP7JYWscTWP46nFlkPtrRqwKae4jVuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749844336; c=relaxed/simple;
	bh=08CHcx7SGTe5PPGRhbl976RyFmVQu6WMI6cWqEnDC98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWjBdSJfND4FNt33SthzV3YydrBG7MsjxQ22J4/kqlqKD2bk1G7NOgSgKqFAL0tLNmXljN5oRqisoEAhyMpSLQRYeI221hQyg/8owNXgFy58L/L72CBcbXaJVhfGmFcULxxadTr8TB4m0tx2O/39+LQ53pyiHbryT3Xxb4PIHD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UYraGh4N; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749844334; x=1781380334;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=08CHcx7SGTe5PPGRhbl976RyFmVQu6WMI6cWqEnDC98=;
  b=UYraGh4NnXuYHi33/ol8k5vCtIloviw48+1P9Vb/OFujITGKytRUAUHC
   Qv/nGpV/fLL5Fup0+cRjMzgfDauw7nx2ZnSzZm8zN0kEsGXEIxcu3tXo5
   /d5fqCFFaSa+zAtn0ALcsYv/AkIlVMRdOSRG+r2Z226hHwVYwAa5yxIdR
   UQv9Q99KCHINPMIw7hvKnH42YOY/TC90cjeJQPnxoUDarV1YCHho+JigN
   dF7offUC+DYWSSptafg1LCQ5cHttnwKvN22oQDvR9b2d3IKQEVokwIpuB
   lLxE6eGcbMaztT5KyL76bK+747Leik2rysuFCdbTq+JL9dzjvrQRWewCe
   Q==;
X-CSE-ConnectionGUID: Nm6+zV+5Tj++nFU91jVbZw==
X-CSE-MsgGUID: gK6QY97GT/2v1pi/QCJKrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="77462397"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="77462397"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 12:52:13 -0700
X-CSE-ConnectionGUID: hQlxaq1MSIGdhKHtI0jOpQ==
X-CSE-MsgGUID: FWCOuF0USwCWd3fhkdxb3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="148379688"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 13 Jun 2025 12:52:11 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uQARd-000Cxm-0t;
	Fri, 13 Jun 2025 19:52:09 +0000
Date: Sat, 14 Jun 2025 03:51:47 +0800
From: kernel test robot <lkp@intel.com>
To: lirongqing <lirongqing@baidu.com>, vgoyal@redhat.com,
	stefanha@redhat.com, miklos@szeredi.hu, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH] virtio_fs: Remove redundant spinlock in
 virtio_fs_request_complete()
Message-ID: <202506140329.g0oJMDcD-lkp@intel.com>
References: <20250613055051.1873-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613055051.1873-1-lirongqing@baidu.com>

Hi lirongqing,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mszeredi-fuse/for-next]
[also build test WARNING on linus/master v6.16-rc1 next-20250613]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/lirongqing/virtio_fs-Remove-redundant-spinlock-in-virtio_fs_request_complete/20250613-135306
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next
patch link:    https://lore.kernel.org/r/20250613055051.1873-1-lirongqing%40baidu.com
patch subject: [PATCH] virtio_fs: Remove redundant spinlock in virtio_fs_request_complete()
config: i386-randconfig-003-20250614 (https://download.01.org/0day-ci/archive/20250614/202506140329.g0oJMDcD-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250614/202506140329.g0oJMDcD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506140329.g0oJMDcD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/fuse/virtio_fs.c: In function 'virtio_fs_request_complete':
>> fs/fuse/virtio_fs.c:765:29: warning: unused variable 'fpq' [-Wunused-variable]
     765 |         struct fuse_pqueue *fpq = &fsvq->fud->pq;
         |                             ^~~


vim +/fpq +765 fs/fuse/virtio_fs.c

a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  760  
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  761  /* Work function for request completion */
bb737bbe48bea9 Vivek Goyal     2020-04-20  762  static void virtio_fs_request_complete(struct fuse_req *req,
bb737bbe48bea9 Vivek Goyal     2020-04-20  763  				       struct virtio_fs_vq *fsvq)
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  764  {
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12 @765  	struct fuse_pqueue *fpq = &fsvq->fud->pq;
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  766  	struct fuse_args *args;
bb737bbe48bea9 Vivek Goyal     2020-04-20  767  	struct fuse_args_pages *ap;
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  768  	unsigned int len, i, thislen;
29279e1d4284a2 Joanne Koong    2024-10-24  769  	struct folio *folio;
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  770  
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  771  	/*
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  772  	 * TODO verify that server properly follows FUSE protocol
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  773  	 * (oh.uniq, oh.len)
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  774  	 */
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  775  	args = req->args;
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  776  	copy_args_from_argbuf(args, req);
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  777  
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  778  	if (args->out_pages && args->page_zeroing) {
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  779  		len = args->out_args[args->out_numargs - 1].size;
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  780  		ap = container_of(args, typeof(*ap), args);
29279e1d4284a2 Joanne Koong    2024-10-24  781  		for (i = 0; i < ap->num_folios; i++) {
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  782  			thislen = ap->descs[i].length;
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  783  			if (len < thislen) {
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  784  				WARN_ON(ap->descs[i].offset);
68bfb7eb7f7de3 Joanne Koong    2024-10-24  785  				folio = ap->folios[i];
68bfb7eb7f7de3 Joanne Koong    2024-10-24  786  				folio_zero_segment(folio, len, thislen);
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  787  				len = 0;
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  788  			} else {
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  789  				len -= thislen;
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  790  			}
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  791  		}
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  792  	}
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  793  
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  794  	clear_bit(FR_SENT, &req->flags);
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  795  
8f622e9497bbbd Max Reitz       2020-04-20  796  	fuse_request_end(req);
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  797  	spin_lock(&fsvq->lock);
c17ea009610366 Vivek Goyal     2019-10-15  798  	dec_in_flight_req(fsvq);
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  799  	spin_unlock(&fsvq->lock);
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  800  }
bb737bbe48bea9 Vivek Goyal     2020-04-20  801  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

