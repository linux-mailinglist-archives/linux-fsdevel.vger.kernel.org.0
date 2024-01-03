Return-Path: <linux-fsdevel+bounces-7155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F83822787
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 04:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E941C22E0B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 03:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2F117748;
	Wed,  3 Jan 2024 03:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XNOdzEAc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C7C156E3;
	Wed,  3 Jan 2024 03:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704251834; x=1735787834;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=IYl8ewQ4V4H2LKmJOnjAX1mXhwVOE3zgKgzzaM0O4jg=;
  b=XNOdzEAczL+1nrraXDOtIYd9qGEEHxEFmnI2C2UQm5OPhO2PuHkNfXjy
   vPYAZP1wIEUrDR+uTT+ixM6fCi/OxeZnL1g8DCsQfPoYLcSOXN5F2c6aV
   PMcuXVhR6ck1ZrSeDHZQahOKCZ3lRuGLKq3l4g6XlBgx1e87vLNJmZf8T
   1zVpUzzpgjhDPUSDAoRNnwIS2RQ7d7YZdXsa5yM2u8NrHw5yg/VfhhMcg
   Am4inq2LyXmWyH3aUJoIVq4bM3H/Mw/UZ5tnCnahr4vayPnS0AalxbG+v
   DJ6MaO9LCd2uO7kuVbZOfzvYtg2d7RwNeCA37upT5JcXOIw//hu7CvvCM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="483135463"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="483135463"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 19:17:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="783381442"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="783381442"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 19:17:04 -0800
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
  <seungjun.ha@samsung.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Hasan
 Al Maruf <hasanalmaruf@fb.com>,  Hao Wang <haowang3@fb.com>,  Dan Williams
 <dan.j.williams@intel.com>,  "Michal Hocko" <mhocko@suse.com>,  Zhongkun
 He <hezhongkun.hzk@bytedance.com>,  "Frank van der Linden"
 <fvdl@google.com>,  John Groves <john@jagalactic.com>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 00/11] mempolicy2, mbind2, and weighted interleave
In-Reply-To: <ZZRepTEFNFC17fjT@memverge.com> (Gregory Price's message of "Tue,
	2 Jan 2024 14:06:13 -0500")
References: <20231223181101.1954-1-gregory.price@memverge.com>
	<87frzqg1jp.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZYqEjsaqseI68EyJ@memverge.com>
	<87le98e4w1.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZZRepTEFNFC17fjT@memverge.com>
Date: Wed, 03 Jan 2024 11:15:06 +0800
Message-ID: <87sf3fcdl1.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

>> >> > struct mpol_args {
>> >> >         /* Basic mempolicy settings */
>> >> >         __u16 mode;
>> >> >         __u16 mode_flags;
>> >> >         __s32 home_node;
>> >> >         __u64 pol_maxnodes;
>> >> 
>> >> I understand that we want to avoid hole in struct.  But I still feel
>> >> uncomfortable to use __u64 for a small.  But I don't have solution too.
>> >> Anyone else has some idea?
>> >>
>> >
>> > maxnode has been an `unsigned long` in every other interface for quite
>> > some time.  Seems better to keep this consistent rather than it suddenly
>> > become `unsigned long` over here and `unsigned short` over there.
>> 
>> I don't think that it matters.  The actual maximum node number will be
>> less than maximum `unsigned short`.
>> 
>
> the structure will end up being
>
> struct mpol_args {
> 	__u16 mode;
> 	__u16 mode_flags;
> 	__s32 home_node;
> 	__u16 pol_maxnodes;
> 	__u8  rsv[6];
> 	__aligned_u64 pol_nodes;
> 	__aligned_u64 il_weights;
> }
>
> If you're fine with that, i'll make the change.

This looks OK for me.  But, I don't know whether others think this is
better.

--
Best Regards,
Huang, Ying

