Return-Path: <linux-fsdevel+bounces-71169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC7FCB76FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 01:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF6F3301C97A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 00:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35458145FE0;
	Fri, 12 Dec 2025 00:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zcs1yJq3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B75C4F5E0;
	Fri, 12 Dec 2025 00:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765498500; cv=none; b=EvzZT3mVT8N1sJNnYno9uYvdK+tJH7s+4P8mfaOKHbfmdlmVVjAX5LTGZ7KyfDVCbmAxCH78KmOrGCEF/tBKNpAPD333thrQNqHTLida0c+4D0eb2cq+OBjaxnQVD6+HQPvuKYSGKGZzQGXRUkquRoXsxPQdxmDKgCpFGyUQQcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765498500; c=relaxed/simple;
	bh=kuQqKQkaE8GaEKgdJ1tHmUhedZmO3yLm5NEIZrBTN2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgAeOykhrQ0f0WjCDJ/wNATMKItuQ+pX40ytLiEi6xObQu6geItcDfHauqgMwasM8V+TWSHlXLM1FGDk72COAYwdMCxNfg898x3NmfqVQEUhUw+tM3bBege7WiXu77aq6YIME+yEX07ENjxntKPf+UkMbDF6alBA9cOKcAZODxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zcs1yJq3; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765498499; x=1797034499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kuQqKQkaE8GaEKgdJ1tHmUhedZmO3yLm5NEIZrBTN2k=;
  b=Zcs1yJq3DfnLIgvaqL4HWawLRFdqo/Yok0VE6JrwX6dWAdlm4FB+yDvi
   7/aMYhbDj1JpaO5iejry2gvjvIC+INpXXm+MIlAl1jBQfsokRVFP7xBOc
   FeGPKnMYZCxs6N3gU4nLAxjd+lDrcVtsw0Xl90fluhVX9F3Uix6g4Lq2G
   GLriBe2OpJRA7Zq1kqKTw3ZQvNYrQmUHrQ3ku8i0ULcaFhq8gVIj2Slgz
   7wblhSDYofXufR5T+Di01hWlS7CF1yWEKC2Bry8AquXE7h3qmKLi1PjiH
   6KP3LV1pYc727UEDYAuZuQ6bpQy2DlXgiIbWboob6KMSmgSYIMYJduIcX
   g==;
X-CSE-ConnectionGUID: rqsPa3OzRweN4dVoOX80TA==
X-CSE-MsgGUID: oNsIVphBRHOO4ifW8x/1zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="78954372"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="78954372"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 16:14:58 -0800
X-CSE-ConnectionGUID: xKzEw5dbRP6/L7p9ygBuaQ==
X-CSE-MsgGUID: 2tz2Szz4TvywrCnqCXsXsQ==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 11 Dec 2025 16:14:55 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vTqo9-000000005Dd-0aF5;
	Fri, 12 Dec 2025 00:14:53 +0000
Date: Fri, 12 Dec 2025 08:14:36 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org, amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: Re: [PATCH v3 4/4] ceph: adding CEPH_SUBVOLUME_ID_NONE
Message-ID: <202512120708.d8OjMmgQ-lkp@intel.com>
References: <20251203154625.2779153-5-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203154625.2779153-5-amarkuze@redhat.com>

Hi Alex,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ceph-client/for-linus]
[also build test WARNING on linus/master v6.18 next-20251211]
[cannot apply to ceph-client/testing]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alex-Markuze/ceph-handle-InodeStat-v8-versioned-field-in-reply-parsing/20251204-035756
base:   https://github.com/ceph/ceph-client.git for-linus
patch link:    https://lore.kernel.org/r/20251203154625.2779153-5-amarkuze%40redhat.com
patch subject: [PATCH v3 4/4] ceph: adding CEPH_SUBVOLUME_ID_NONE
config: x86_64-randconfig-101-20251210 (https://download.01.org/0day-ci/archive/20251212/202512120708.d8OjMmgQ-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251212/202512120708.d8OjMmgQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512120708.d8OjMmgQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/ceph/mds_client.c:123:22: warning: unused variable 'cl' [-Wunused-variable]
     123 |         struct ceph_client *cl = mdsc ? mdsc->fsc->client : NULL;
         |                             ^~
   1 warning generated.


vim +/cl +123 fs/ceph/mds_client.c

b37fe1f923fb4b Yan, Zheng       2019-01-09  113  
2f2dc053404feb Sage Weil        2009-10-06  114  static int parse_reply_info_in(void **p, void *end,
14303d20f3ae3e Sage Weil        2010-12-14  115  			       struct ceph_mds_reply_info_in *info,
48a90cabed1e21 Alex Markuze     2025-12-03  116  			       u64 features,
48a90cabed1e21 Alex Markuze     2025-12-03  117  			       struct ceph_mds_client *mdsc)
2f2dc053404feb Sage Weil        2009-10-06  118  {
b37fe1f923fb4b Yan, Zheng       2019-01-09  119  	int err = 0;
b37fe1f923fb4b Yan, Zheng       2019-01-09  120  	u8 struct_v = 0;
48a90cabed1e21 Alex Markuze     2025-12-03  121  	u8 struct_compat = 0;
48a90cabed1e21 Alex Markuze     2025-12-03  122  	u32 struct_len = 0;
48a90cabed1e21 Alex Markuze     2025-12-03 @123  	struct ceph_client *cl = mdsc ? mdsc->fsc->client : NULL;
48a90cabed1e21 Alex Markuze     2025-12-03  124  
b5cda3b778d7c2 Alex Markuze     2025-12-03  125  	info->subvolume_id = CEPH_SUBVOLUME_ID_NONE;
7361b2801d4572 Alex Markuze     2025-12-03  126  
b37fe1f923fb4b Yan, Zheng       2019-01-09  127  	if (features == (u64)-1) {
b37fe1f923fb4b Yan, Zheng       2019-01-09  128  		ceph_decode_8_safe(p, end, struct_v, bad);
b37fe1f923fb4b Yan, Zheng       2019-01-09  129  		ceph_decode_8_safe(p, end, struct_compat, bad);
b37fe1f923fb4b Yan, Zheng       2019-01-09  130  		/* struct_v is expected to be >= 1. we only understand
b37fe1f923fb4b Yan, Zheng       2019-01-09  131  		 * encoding with struct_compat == 1. */
b37fe1f923fb4b Yan, Zheng       2019-01-09  132  		if (!struct_v || struct_compat != 1)
b37fe1f923fb4b Yan, Zheng       2019-01-09  133  			goto bad;
b37fe1f923fb4b Yan, Zheng       2019-01-09  134  		ceph_decode_32_safe(p, end, struct_len, bad);
b37fe1f923fb4b Yan, Zheng       2019-01-09  135  		ceph_decode_need(p, end, struct_len, bad);
b37fe1f923fb4b Yan, Zheng       2019-01-09  136  		end = *p + struct_len;
b37fe1f923fb4b Yan, Zheng       2019-01-09  137  	}
2f2dc053404feb Sage Weil        2009-10-06  138  
b37fe1f923fb4b Yan, Zheng       2019-01-09  139  	ceph_decode_need(p, end, sizeof(struct ceph_mds_reply_inode), bad);
2f2dc053404feb Sage Weil        2009-10-06  140  	info->in = *p;
2f2dc053404feb Sage Weil        2009-10-06  141  	*p += sizeof(struct ceph_mds_reply_inode) +
2f2dc053404feb Sage Weil        2009-10-06  142  		sizeof(*info->in->fragtree.splits) *
2f2dc053404feb Sage Weil        2009-10-06  143  		le32_to_cpu(info->in->fragtree.nsplits);
2f2dc053404feb Sage Weil        2009-10-06  144  
2f2dc053404feb Sage Weil        2009-10-06  145  	ceph_decode_32_safe(p, end, info->symlink_len, bad);
2f2dc053404feb Sage Weil        2009-10-06  146  	ceph_decode_need(p, end, info->symlink_len, bad);
2f2dc053404feb Sage Weil        2009-10-06  147  	info->symlink = *p;
2f2dc053404feb Sage Weil        2009-10-06  148  	*p += info->symlink_len;
2f2dc053404feb Sage Weil        2009-10-06  149  
14303d20f3ae3e Sage Weil        2010-12-14  150  	ceph_decode_copy_safe(p, end, &info->dir_layout,
14303d20f3ae3e Sage Weil        2010-12-14  151  			      sizeof(info->dir_layout), bad);
2f2dc053404feb Sage Weil        2009-10-06  152  	ceph_decode_32_safe(p, end, info->xattr_len, bad);
2f2dc053404feb Sage Weil        2009-10-06  153  	ceph_decode_need(p, end, info->xattr_len, bad);
2f2dc053404feb Sage Weil        2009-10-06  154  	info->xattr_data = *p;
2f2dc053404feb Sage Weil        2009-10-06  155  	*p += info->xattr_len;
fb01d1f8b0343f Yan, Zheng       2014-11-14  156  
b37fe1f923fb4b Yan, Zheng       2019-01-09  157  	if (features == (u64)-1) {
b37fe1f923fb4b Yan, Zheng       2019-01-09  158  		/* inline data */
b37fe1f923fb4b Yan, Zheng       2019-01-09  159  		ceph_decode_64_safe(p, end, info->inline_version, bad);
b37fe1f923fb4b Yan, Zheng       2019-01-09  160  		ceph_decode_32_safe(p, end, info->inline_len, bad);
b37fe1f923fb4b Yan, Zheng       2019-01-09  161  		ceph_decode_need(p, end, info->inline_len, bad);
b37fe1f923fb4b Yan, Zheng       2019-01-09  162  		info->inline_data = *p;
b37fe1f923fb4b Yan, Zheng       2019-01-09  163  		*p += info->inline_len;
b37fe1f923fb4b Yan, Zheng       2019-01-09  164  		/* quota */
b37fe1f923fb4b Yan, Zheng       2019-01-09  165  		err = parse_reply_info_quota(p, end, info);
b37fe1f923fb4b Yan, Zheng       2019-01-09  166  		if (err < 0)
b37fe1f923fb4b Yan, Zheng       2019-01-09  167  			goto out_bad;
b37fe1f923fb4b Yan, Zheng       2019-01-09  168  		/* pool namespace */
b37fe1f923fb4b Yan, Zheng       2019-01-09  169  		ceph_decode_32_safe(p, end, info->pool_ns_len, bad);
b37fe1f923fb4b Yan, Zheng       2019-01-09  170  		if (info->pool_ns_len > 0) {
b37fe1f923fb4b Yan, Zheng       2019-01-09  171  			ceph_decode_need(p, end, info->pool_ns_len, bad);
b37fe1f923fb4b Yan, Zheng       2019-01-09  172  			info->pool_ns_data = *p;
b37fe1f923fb4b Yan, Zheng       2019-01-09  173  			*p += info->pool_ns_len;
b37fe1f923fb4b Yan, Zheng       2019-01-09  174  		}
245ce991cca55e Jeff Layton      2019-05-29  175  
245ce991cca55e Jeff Layton      2019-05-29  176  		/* btime */
245ce991cca55e Jeff Layton      2019-05-29  177  		ceph_decode_need(p, end, sizeof(info->btime), bad);
245ce991cca55e Jeff Layton      2019-05-29  178  		ceph_decode_copy(p, &info->btime, sizeof(info->btime));
245ce991cca55e Jeff Layton      2019-05-29  179  
245ce991cca55e Jeff Layton      2019-05-29  180  		/* change attribute */
a35ead314e0b92 Jeff Layton      2019-06-06  181  		ceph_decode_64_safe(p, end, info->change_attr, bad);
b37fe1f923fb4b Yan, Zheng       2019-01-09  182  
08796873a5183b Yan, Zheng       2019-01-09  183  		/* dir pin */
08796873a5183b Yan, Zheng       2019-01-09  184  		if (struct_v >= 2) {
08796873a5183b Yan, Zheng       2019-01-09  185  			ceph_decode_32_safe(p, end, info->dir_pin, bad);
08796873a5183b Yan, Zheng       2019-01-09  186  		} else {
08796873a5183b Yan, Zheng       2019-01-09  187  			info->dir_pin = -ENODATA;
08796873a5183b Yan, Zheng       2019-01-09  188  		}
08796873a5183b Yan, Zheng       2019-01-09  189  
193e7b37628e97 David Disseldorp 2019-04-18  190  		/* snapshot birth time, remains zero for v<=2 */
193e7b37628e97 David Disseldorp 2019-04-18  191  		if (struct_v >= 3) {
193e7b37628e97 David Disseldorp 2019-04-18  192  			ceph_decode_need(p, end, sizeof(info->snap_btime), bad);
193e7b37628e97 David Disseldorp 2019-04-18  193  			ceph_decode_copy(p, &info->snap_btime,
193e7b37628e97 David Disseldorp 2019-04-18  194  					 sizeof(info->snap_btime));
193e7b37628e97 David Disseldorp 2019-04-18  195  		} else {
193e7b37628e97 David Disseldorp 2019-04-18  196  			memset(&info->snap_btime, 0, sizeof(info->snap_btime));
193e7b37628e97 David Disseldorp 2019-04-18  197  		}
193e7b37628e97 David Disseldorp 2019-04-18  198  
e7f72952508ac4 Yanhu Cao        2020-08-28  199  		/* snapshot count, remains zero for v<=3 */
e7f72952508ac4 Yanhu Cao        2020-08-28  200  		if (struct_v >= 4) {
e7f72952508ac4 Yanhu Cao        2020-08-28  201  			ceph_decode_64_safe(p, end, info->rsnaps, bad);
e7f72952508ac4 Yanhu Cao        2020-08-28  202  		} else {
e7f72952508ac4 Yanhu Cao        2020-08-28  203  			info->rsnaps = 0;
e7f72952508ac4 Yanhu Cao        2020-08-28  204  		}
e7f72952508ac4 Yanhu Cao        2020-08-28  205  
2d332d5bc42440 Jeff Layton      2020-07-27  206  		if (struct_v >= 5) {
2d332d5bc42440 Jeff Layton      2020-07-27  207  			u32 alen;
2d332d5bc42440 Jeff Layton      2020-07-27  208  
2d332d5bc42440 Jeff Layton      2020-07-27  209  			ceph_decode_32_safe(p, end, alen, bad);
2d332d5bc42440 Jeff Layton      2020-07-27  210  
2d332d5bc42440 Jeff Layton      2020-07-27  211  			while (alen--) {
2d332d5bc42440 Jeff Layton      2020-07-27  212  				u32 len;
2d332d5bc42440 Jeff Layton      2020-07-27  213  
2d332d5bc42440 Jeff Layton      2020-07-27  214  				/* key */
2d332d5bc42440 Jeff Layton      2020-07-27  215  				ceph_decode_32_safe(p, end, len, bad);
2d332d5bc42440 Jeff Layton      2020-07-27  216  				ceph_decode_skip_n(p, end, len, bad);
2d332d5bc42440 Jeff Layton      2020-07-27  217  				/* value */
2d332d5bc42440 Jeff Layton      2020-07-27  218  				ceph_decode_32_safe(p, end, len, bad);
2d332d5bc42440 Jeff Layton      2020-07-27  219  				ceph_decode_skip_n(p, end, len, bad);
2d332d5bc42440 Jeff Layton      2020-07-27  220  			}
2d332d5bc42440 Jeff Layton      2020-07-27  221  		}
2d332d5bc42440 Jeff Layton      2020-07-27  222  
2d332d5bc42440 Jeff Layton      2020-07-27  223  		/* fscrypt flag -- ignore */
2d332d5bc42440 Jeff Layton      2020-07-27  224  		if (struct_v >= 6)
2d332d5bc42440 Jeff Layton      2020-07-27  225  			ceph_decode_skip_8(p, end, bad);
2d332d5bc42440 Jeff Layton      2020-07-27  226  
2d332d5bc42440 Jeff Layton      2020-07-27  227  		info->fscrypt_auth = NULL;
2d332d5bc42440 Jeff Layton      2020-07-27  228  		info->fscrypt_auth_len = 0;
2d332d5bc42440 Jeff Layton      2020-07-27  229  		info->fscrypt_file = NULL;
2d332d5bc42440 Jeff Layton      2020-07-27  230  		info->fscrypt_file_len = 0;
2d332d5bc42440 Jeff Layton      2020-07-27  231  		if (struct_v >= 7) {
2d332d5bc42440 Jeff Layton      2020-07-27  232  			ceph_decode_32_safe(p, end, info->fscrypt_auth_len, bad);
2d332d5bc42440 Jeff Layton      2020-07-27  233  			if (info->fscrypt_auth_len) {
2d332d5bc42440 Jeff Layton      2020-07-27  234  				info->fscrypt_auth = kmalloc(info->fscrypt_auth_len,
2d332d5bc42440 Jeff Layton      2020-07-27  235  							     GFP_KERNEL);
2d332d5bc42440 Jeff Layton      2020-07-27  236  				if (!info->fscrypt_auth)
2d332d5bc42440 Jeff Layton      2020-07-27  237  					return -ENOMEM;
2d332d5bc42440 Jeff Layton      2020-07-27  238  				ceph_decode_copy_safe(p, end, info->fscrypt_auth,
2d332d5bc42440 Jeff Layton      2020-07-27  239  						      info->fscrypt_auth_len, bad);
2d332d5bc42440 Jeff Layton      2020-07-27  240  			}
2d332d5bc42440 Jeff Layton      2020-07-27  241  			ceph_decode_32_safe(p, end, info->fscrypt_file_len, bad);
2d332d5bc42440 Jeff Layton      2020-07-27  242  			if (info->fscrypt_file_len) {
2d332d5bc42440 Jeff Layton      2020-07-27  243  				info->fscrypt_file = kmalloc(info->fscrypt_file_len,
2d332d5bc42440 Jeff Layton      2020-07-27  244  							     GFP_KERNEL);
2d332d5bc42440 Jeff Layton      2020-07-27  245  				if (!info->fscrypt_file)
2d332d5bc42440 Jeff Layton      2020-07-27  246  					return -ENOMEM;
2d332d5bc42440 Jeff Layton      2020-07-27  247  				ceph_decode_copy_safe(p, end, info->fscrypt_file,
2d332d5bc42440 Jeff Layton      2020-07-27  248  						      info->fscrypt_file_len, bad);
2d332d5bc42440 Jeff Layton      2020-07-27  249  			}
2d332d5bc42440 Jeff Layton      2020-07-27  250  		}
e3d0dedf78abdf Alex Markuze     2025-12-03  251  
e3d0dedf78abdf Alex Markuze     2025-12-03  252  		/*
e3d0dedf78abdf Alex Markuze     2025-12-03  253  		 * InodeStat encoding versions:
e3d0dedf78abdf Alex Markuze     2025-12-03  254  		 *   v1-v7: various fields added over time
e3d0dedf78abdf Alex Markuze     2025-12-03  255  		 *   v8: added optmetadata (versioned sub-structure containing
e3d0dedf78abdf Alex Markuze     2025-12-03  256  		 *       optional inode metadata like charmap for case-insensitive
e3d0dedf78abdf Alex Markuze     2025-12-03  257  		 *       filesystems). The kernel client doesn't support
e3d0dedf78abdf Alex Markuze     2025-12-03  258  		 *       case-insensitive lookups, so we skip this field.
e3d0dedf78abdf Alex Markuze     2025-12-03  259  		 *   v9: added subvolume_id (parsed below)
e3d0dedf78abdf Alex Markuze     2025-12-03  260  		 */
e3d0dedf78abdf Alex Markuze     2025-12-03  261  		if (struct_v >= 8) {
e3d0dedf78abdf Alex Markuze     2025-12-03  262  			u32 v8_struct_len;
e3d0dedf78abdf Alex Markuze     2025-12-03  263  
e3d0dedf78abdf Alex Markuze     2025-12-03  264  			/* skip optmetadata versioned sub-structure */
e3d0dedf78abdf Alex Markuze     2025-12-03  265  			ceph_decode_skip_8(p, end, bad);  /* struct_v */
e3d0dedf78abdf Alex Markuze     2025-12-03  266  			ceph_decode_skip_8(p, end, bad);  /* struct_compat */
e3d0dedf78abdf Alex Markuze     2025-12-03  267  			ceph_decode_32_safe(p, end, v8_struct_len, bad);
e3d0dedf78abdf Alex Markuze     2025-12-03  268  			ceph_decode_skip_n(p, end, v8_struct_len, bad);
e3d0dedf78abdf Alex Markuze     2025-12-03  269  		}
e3d0dedf78abdf Alex Markuze     2025-12-03  270  
7361b2801d4572 Alex Markuze     2025-12-03  271  		/* struct_v 9 added subvolume_id */
7361b2801d4572 Alex Markuze     2025-12-03  272  		if (struct_v >= 9)
7361b2801d4572 Alex Markuze     2025-12-03  273  			ceph_decode_64_safe(p, end, info->subvolume_id, bad);
7361b2801d4572 Alex Markuze     2025-12-03  274  
b37fe1f923fb4b Yan, Zheng       2019-01-09  275  		*p = end;
b37fe1f923fb4b Yan, Zheng       2019-01-09  276  	} else {
2d332d5bc42440 Jeff Layton      2020-07-27  277  		/* legacy (unversioned) struct */
fb01d1f8b0343f Yan, Zheng       2014-11-14  278  		if (features & CEPH_FEATURE_MDS_INLINE_DATA) {
fb01d1f8b0343f Yan, Zheng       2014-11-14  279  			ceph_decode_64_safe(p, end, info->inline_version, bad);
fb01d1f8b0343f Yan, Zheng       2014-11-14  280  			ceph_decode_32_safe(p, end, info->inline_len, bad);
fb01d1f8b0343f Yan, Zheng       2014-11-14  281  			ceph_decode_need(p, end, info->inline_len, bad);
fb01d1f8b0343f Yan, Zheng       2014-11-14  282  			info->inline_data = *p;
fb01d1f8b0343f Yan, Zheng       2014-11-14  283  			*p += info->inline_len;
fb01d1f8b0343f Yan, Zheng       2014-11-14  284  		} else
fb01d1f8b0343f Yan, Zheng       2014-11-14  285  			info->inline_version = CEPH_INLINE_NONE;
fb01d1f8b0343f Yan, Zheng       2014-11-14  286  
fb18a57568c2b8 Luis Henriques   2018-01-05  287  		if (features & CEPH_FEATURE_MDS_QUOTA) {
b37fe1f923fb4b Yan, Zheng       2019-01-09  288  			err = parse_reply_info_quota(p, end, info);
b37fe1f923fb4b Yan, Zheng       2019-01-09  289  			if (err < 0)
b37fe1f923fb4b Yan, Zheng       2019-01-09  290  				goto out_bad;
fb18a57568c2b8 Luis Henriques   2018-01-05  291  		} else {
fb18a57568c2b8 Luis Henriques   2018-01-05  292  			info->max_bytes = 0;
fb18a57568c2b8 Luis Henriques   2018-01-05  293  			info->max_files = 0;
fb18a57568c2b8 Luis Henriques   2018-01-05  294  		}
fb18a57568c2b8 Luis Henriques   2018-01-05  295  
779fe0fb8e1883 Yan, Zheng       2016-03-07  296  		info->pool_ns_len = 0;
779fe0fb8e1883 Yan, Zheng       2016-03-07  297  		info->pool_ns_data = NULL;
5ea5c5e0a7f70b Yan, Zheng       2016-02-14  298  		if (features & CEPH_FEATURE_FS_FILE_LAYOUT_V2) {
5ea5c5e0a7f70b Yan, Zheng       2016-02-14  299  			ceph_decode_32_safe(p, end, info->pool_ns_len, bad);
779fe0fb8e1883 Yan, Zheng       2016-03-07  300  			if (info->pool_ns_len > 0) {
5ea5c5e0a7f70b Yan, Zheng       2016-02-14  301  				ceph_decode_need(p, end, info->pool_ns_len, bad);
779fe0fb8e1883 Yan, Zheng       2016-03-07  302  				info->pool_ns_data = *p;
5ea5c5e0a7f70b Yan, Zheng       2016-02-14  303  				*p += info->pool_ns_len;
779fe0fb8e1883 Yan, Zheng       2016-03-07  304  			}
5ea5c5e0a7f70b Yan, Zheng       2016-02-14  305  		}
08796873a5183b Yan, Zheng       2019-01-09  306  
245ce991cca55e Jeff Layton      2019-05-29  307  		if (features & CEPH_FEATURE_FS_BTIME) {
245ce991cca55e Jeff Layton      2019-05-29  308  			ceph_decode_need(p, end, sizeof(info->btime), bad);
245ce991cca55e Jeff Layton      2019-05-29  309  			ceph_decode_copy(p, &info->btime, sizeof(info->btime));
a35ead314e0b92 Jeff Layton      2019-06-06  310  			ceph_decode_64_safe(p, end, info->change_attr, bad);
245ce991cca55e Jeff Layton      2019-05-29  311  		}
245ce991cca55e Jeff Layton      2019-05-29  312  
08796873a5183b Yan, Zheng       2019-01-09  313  		info->dir_pin = -ENODATA;
e7f72952508ac4 Yanhu Cao        2020-08-28  314  		/* info->snap_btime and info->rsnaps remain zero */
b37fe1f923fb4b Yan, Zheng       2019-01-09  315  	}
2f2dc053404feb Sage Weil        2009-10-06  316  	return 0;
2f2dc053404feb Sage Weil        2009-10-06  317  bad:
b37fe1f923fb4b Yan, Zheng       2019-01-09  318  	err = -EIO;
b37fe1f923fb4b Yan, Zheng       2019-01-09  319  out_bad:
2f2dc053404feb Sage Weil        2009-10-06  320  	return err;
2f2dc053404feb Sage Weil        2009-10-06  321  }
2f2dc053404feb Sage Weil        2009-10-06  322  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

