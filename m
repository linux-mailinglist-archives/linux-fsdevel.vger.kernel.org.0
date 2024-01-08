Return-Path: <linux-fsdevel+bounces-7523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA69A826870
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 08:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08C3C1C21944
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 07:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15B88BFC;
	Mon,  8 Jan 2024 07:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L6xXP0lk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2FF8825;
	Mon,  8 Jan 2024 07:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704697810; x=1736233810;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=q3BRi1LuTFgEqMrhuwxfEP3vKCswFiyIHpRV1gihFhM=;
  b=L6xXP0lk3qlMzh2n87B5S0umzzUebvtP4mFRjweSiJ5zB/BjlXwDzeBD
   AWkbMoisywCcpnZ8AEmI2rHsvMyO3pX3RfEvCZd1NbIYLESVd+eVZ4pP9
   yQYlZivorQ7iPdmmJWc2s9D3mHk+hOlFdw/j+IfNYXP7fFiywsiy2ofFg
   5kzoZPR9mi+l4b6Ft5Y5MJP3XJjqqLw0GIWYpwjYwFz6hdpABj3J7x5Dy
   sfzeZjLioP2msP85n/aFo5Anzn7herBrtTjekP8DAqKpDrgLeytro2xpb
   0OFxBPh731jxK+Pa8Re08rIwsMLpd+7V2xb62E1eEzo5gRE2Gqfm9lm/K
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="4570333"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="4570333"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 23:10:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="1028315259"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="1028315259"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 23:10:03 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gregory.price@memverge.com>
Cc: Gregory Price <gourry.memverge@gmail.com>,  <linux-mm@kvack.org>,
  <linux-doc@vger.kernel.org>,  <linux-fsdevel@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-api@vger.kernel.org>,
  <x86@kernel.org>,  <akpm@linux-foundation.org>,  <arnd@arndb.de>,
  <tglx@linutronix.de>,  <luto@kernel.org>,  <mingo@redhat.com>,
  <bp@alien8.de>,  <dave.hansen@linux.intel.com>,  <hpa@zytor.com>,
  <mhocko@kernel.org>,  <tj@kernel.org>,  <corbet@lwn.net>,
  <rakie.kim@sk.com>,  <hyeongtak.ji@sk.com>,  <honggyu.kim@sk.com>,
  <vtavarespetr@micron.com>,  <peterz@infradead.org>,
  <jgroves@micron.com>,  <ravis.opensrc@micron.com>,
  <sthanneeru@micron.com>,  <emirakhur@micron.com>,  <Hasan.Maruf@amd.com>,
  <seungjun.ha@samsung.com>,  Srinivasulu Thanneeru
 <sthanneeru.opensrc@micron.com>
Subject: Re: [PATCH v5 02/11] mm/mempolicy: introduce
 MPOL_WEIGHTED_INTERLEAVE for weighted interleaving
In-Reply-To: <ZZeu6DwVt6o0fl14@memverge.com> (Gregory Price's message of "Fri,
	5 Jan 2024 02:25:28 -0500")
References: <20231223181101.1954-3-gregory.price@memverge.com>
	<8734vof3kq.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZYp6ZRLZQVtTHest@memverge.com>
	<878r58dt31.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZZRybDPSoLme8Ldh@memverge.com>
	<87mstnc6jz.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZZXbN4+2nVbE/lRe@memverge.com>
	<875y09d5d8.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZZcAF4zIpsVN3dLd@memverge.com>
	<87cyugb7cz.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZZeu6DwVt6o0fl14@memverge.com>
Date: Mon, 08 Jan 2024 15:08:05 +0800
Message-ID: <87mstg9uay.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Fri, Jan 05, 2024 at 02:51:40PM +0800, Huang, Ying wrote:
>> >
>> > So we're talking ~1MB for 1024 threads with mempolicies to avoid error
>> > conditions mid-page-allocation and to reduce the cost associated with
>> > applying weighted interleave.
>> 
>> Think about this again.  Why do we need weights array on stack?  I think
>> this is used to keep weights consistent.  If so, we don't need weights
>> array on stack.  Just use RCU to access global weights array.
>> 
>
> From the bulk allocation code:
>
> __alloc_pages_bulk(gfp, node, NULL, node_pages, NULL, page_array);
>
> This function can block. You cannot block during an RCU read context.

Yes.  You are right.  For __alloc_pages_bulk(), it should be OK to
allocate the weights array.  For weighted_interleave_nid(), we can use
RCU to avoid memory allocation in relative fast code path.

BTW, we can use nr_node_ids instead of MAX_NUMNODES if applicable.

--
Best Regards,
Huang, Ying

