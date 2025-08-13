Return-Path: <linux-fsdevel+bounces-57632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3CFB24010
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 07:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF4487A6223
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 05:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D2B2BE64F;
	Wed, 13 Aug 2025 05:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJ8kdtSm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8579322A;
	Wed, 13 Aug 2025 05:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755062200; cv=none; b=lEVFX6uF2deMs5mairvZ0xllAnIU0qp5rgS19gmHuEzrUvKgfO1IxepOSg5/i0r1g4qdKTrV7DQaI0rmkOkJoRKsvcEEe29AYeM9YnGCRLvhZ1w1B/TRS3K/f3FRscgMGDB0JzzQ7nXU1Uo0Rh7AOsObjUBGCXGQsWWF0K48yYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755062200; c=relaxed/simple;
	bh=QHGINcBtgZyN5lwSuC4ihOdgAfkWxrXCvNILJWMOBVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRAr/liuJBgbCWoTtOzh6VmszzSvvCVb84t4bQFInCSAfRN3xJWlvlwCx65xLqUc99E2Wij1b6A7Dq5v47XAabHwJwU1++GBl0Jg05enz9JR4+aN0HTZjlHMAO5NHdfEzCdQuQw9A9ZR3b4u12RX18X8qdaRXiDSJh/HWLTB5Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJ8kdtSm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6485C4CEEB;
	Wed, 13 Aug 2025 05:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755062199;
	bh=QHGINcBtgZyN5lwSuC4ihOdgAfkWxrXCvNILJWMOBVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NJ8kdtSmVYuDmZ9UTC9uyVZDWkHKpE44JmKlAUuCa7NZxop2ZK8q7CC++ZZVKGYqf
	 2FtFO5vBHtDjYhIFJTJjQSsJRbxUaf0a5k9GCO/vI0kEc2Amu0RlAFK5LI+90qUwE8
	 Wt/HmHsp350LKxT3V5edx5EIk5k5/dHroc1gWPsZBPQTy3e4Ep/IgKDgKWQmnFs0sw
	 6cqFtidy2jtFeD3RQfgLFaCCGVcqzgmOXefeTkU64Ioo3+VbGhOKm4ArnHUoBv87xd
	 3Pvm2U1X+nJMrmwtp/okmHBkuSQR3Yb1oCRfS+C3ip0SypefYd4i8fT0xp5j3V9lPt
	 9tySUkpa34FBg==
Date: Tue, 12 Aug 2025 22:16:33 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Dominique Martinet via B4 Relay <devnull+asmadeus.codewreck.org@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Maximilian Bosch <maximilian@mbosch.me>,
	Ryan Lahfa <ryan@lahfa.xyz>, Christian Theune <ct@flyingcircus.io>,
	Arnout Engelen <arnout@bzzt.net>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Dominique Martinet <asmadeus@codewreck.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] iov_iter: iterate_folioq: fix handling of offset >=
 folio size
Message-ID: <20250813051633.GA3895812@ax162>
References: <20250811-iot_iter_folio-v1-1-d9c223adf93c@codewreck.org>
 <202508120250.Eooq2ydr-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202508120250.Eooq2ydr-lkp@intel.com>

On Tue, Aug 12, 2025 at 02:55:55AM +0800, kernel test robot wrote:
> Hi Dominique,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 8f5ae30d69d7543eee0d70083daf4de8fe15d585]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Dominique-Martinet-via-B4-Relay/iov_iter-iterate_folioq-fix-handling-of-offset-folio-size/20250811-154319
> base:   8f5ae30d69d7543eee0d70083daf4de8fe15d585
> patch link:    https://lore.kernel.org/r/20250811-iot_iter_folio-v1-1-d9c223adf93c%40codewreck.org
> patch subject: [PATCH 1/2] iov_iter: iterate_folioq: fix handling of offset >= folio size
> config: i386-buildonly-randconfig-002-20250811 (https://download.01.org/0day-ci/archive/20250812/202508120250.Eooq2ydr-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250812/202508120250.Eooq2ydr-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202508120250.Eooq2ydr-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from lib/iov_iter.c:14:
> >> include/linux/iov_iter.h:171:7: warning: variable 'remain' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>      171 |                 if (skip >= fsize)
>          |                     ^~~~~~~~~~~~~
>    include/linux/iov_iter.h:190:7: note: uninitialized use occurs here
>      190 |                 if (remain)
>          |                     ^~~~~~
>    include/linux/iov_iter.h:171:3: note: remove the 'if' if its condition is always false
>      171 |                 if (skip >= fsize)
>          |                 ^~~~~~~~~~~~~~~~~~
>      172 |                         goto next;
>          |                         ~~~~~~~~~
>    include/linux/iov_iter.h:163:22: note: initialize the variable 'remain' to silence this warning
>      163 |                 size_t part, remain, consumed;
>          |                                    ^
>          |                                     = 0
>    1 warning generated.

I see this in -next now, should remain be zero initialized or is there
some other fix that is needed?

> vim +171 include/linux/iov_iter.h
> 
>    143	
>    144	/*
>    145	 * Handle ITER_FOLIOQ.
>    146	 */
>    147	static __always_inline
>    148	size_t iterate_folioq(struct iov_iter *iter, size_t len, void *priv, void *priv2,
>    149			      iov_step_f step)
>    150	{
>    151		const struct folio_queue *folioq = iter->folioq;
>    152		unsigned int slot = iter->folioq_slot;
>    153		size_t progress = 0, skip = iter->iov_offset;
>    154	
>    155		if (slot == folioq_nr_slots(folioq)) {
>    156			/* The iterator may have been extended. */
>    157			folioq = folioq->next;
>    158			slot = 0;
>    159		}
>    160	
>    161		do {
>    162			struct folio *folio = folioq_folio(folioq, slot);
>    163			size_t part, remain, consumed;
>    164			size_t fsize;
>    165			void *base;
>    166	
>    167			if (!folio)
>    168				break;
>    169	
>    170			fsize = folioq_folio_size(folioq, slot);
>  > 171			if (skip >= fsize)
>    172				goto next;
>    173			base = kmap_local_folio(folio, skip);
>    174			part = umin(len, PAGE_SIZE - skip % PAGE_SIZE);
>    175			remain = step(base, progress, part, priv, priv2);
>    176			kunmap_local(base);
>    177			consumed = part - remain;
>    178			len -= consumed;
>    179			progress += consumed;
>    180			skip += consumed;
>    181			if (skip >= fsize) {
>    182	next:
>    183				skip = 0;
>    184				slot++;
>    185				if (slot == folioq_nr_slots(folioq) && folioq->next) {
>    186					folioq = folioq->next;
>    187					slot = 0;
>    188				}
>    189			}
>    190			if (remain)
>    191				break;
>    192		} while (len);
>    193	
>    194		iter->folioq_slot = slot;
>    195		iter->folioq = folioq;
>    196		iter->iov_offset = skip;
>    197		iter->count -= progress;
>    198		return progress;
>    199	}
>    200	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

