Return-Path: <linux-fsdevel+bounces-7072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC9E8218B6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 10:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7121C21738
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 09:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1371C8F5;
	Tue,  2 Jan 2024 09:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dgpv6VQH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAE15697;
	Tue,  2 Jan 2024 09:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704186724; x=1735722724;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ZUUp125/reT7Tq22vhlJmnu5Uponk8HjKBT4ndhBEac=;
  b=Dgpv6VQHu3RhxV2FCj+bDXw6/JYN7kFKFDMw0VLe/GyMXKXFjx37NFx7
   K9LSIovE6Kw0NbY45E3ewL/LVCkqSyc9vFtY1zRkrucuSevmp03Kc/Gx1
   BUskTf+QwAQ6jFEv6rLxIqVPtsHfb2FCSpEFmeVw4FpbaU9QBSO6fu8o7
   vJ4faPt4aPjLfcwkRYZQsHcs3dRTVN24NQnIjwBRKkLqXJwsDq+k6jmwp
   KeqHyEX9IxdYradK1IKV6CkTcDimj7gFxy9LrhNxQRe77zX/U0mjJI8rc
   ovixFAUDkMUn7cSwNt1lPuELuYUJAYBckThS03ByJ5n3gR3GoGmotY0ON
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="428020231"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="428020231"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 01:12:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="755861313"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="755861313"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 01:11:53 -0800
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
  <seungjun.ha@samsung.com>
Subject: Re: [PATCH v5 03/11] mm/mempolicy: refactor sanitize_mpol_flags for
 reuse
In-Reply-To: <ZYq9klTts4yg8RhG@memverge.com> (Gregory Price's message of "Tue,
	26 Dec 2023 06:48:34 -0500")
References: <20231223181101.1954-1-gregory.price@memverge.com>
	<20231223181101.1954-4-gregory.price@memverge.com>
	<87y1dgdoou.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZYp7P1fH8nvkr4o0@memverge.com> <ZYq9klTts4yg8RhG@memverge.com>
Date: Tue, 02 Jan 2024 17:09:55 +0800
Message-ID: <871qb0drto.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Tue, Dec 26, 2023 at 02:05:35AM -0500, Gregory Price wrote:
>> On Wed, Dec 27, 2023 at 04:39:29PM +0800, Huang, Ying wrote:
>> > Gregory Price <gourry.memverge@gmail.com> writes:
>> > 
>> > > +	unsigned short mode = (*mode_arg & ~MPOL_MODE_FLAGS);
>> > > +
>> > > +	*flags = *mode_arg & MPOL_MODE_FLAGS;
>> > > +	*mode_arg = mode;
>> > 
>> > It appears that it's unnecessary to introduce a local variable to split
>> > mode/flags.  Just reuse the original code?
>> > 
>
> Revisiting during fixes: Note the change from int to short.
>
> I chose to make this explicit because validate_mpol_flags takes a short.
>
> I'm fairly sure changing it back throws a truncation warning.

Why something like below doesn't work?

int sanitize_mpol_flags(int *mode, unsigned short *flags)
{
        *flags = *mode & MPOL_MODE_FLAGS;
        *mode &= ~MPOL_MODE_FLAGS;

        return validate_mpol_flags(*mode, flags);
}

--
Best Regards,
Huang, Ying

