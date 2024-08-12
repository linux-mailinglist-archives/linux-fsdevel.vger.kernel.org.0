Return-Path: <linux-fsdevel+bounces-25611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5AC94E47A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 03:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E221F21F85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 01:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167DA52F6F;
	Mon, 12 Aug 2024 01:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HsWNrf0K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E40D29CA;
	Mon, 12 Aug 2024 01:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723426286; cv=none; b=Ik/tz8iWO/nBS24hwz8GHF6VY6Q/ZbNImuBkXqVGEbd2GEDiwZ2LEbUtGtF0XU7c8YRfi1fznm7l8ccWamTuufXJhcB/hhaOLl+4BO36MhMbwzhy/xlA8W3IB+AtBJsVmbXm0QNlMYpJ2Pd3YovjEcaJnTWII9vZoRJmEpC6Y+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723426286; c=relaxed/simple;
	bh=ehyDXmakAbdGEtkM0FT6tuhjWESYyQrQ+XxI4bLdEUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nr9++1zGFS/XX/aaIxCztzxTUNTvlwCX5m+IYmaXQzRwqFYwYcd6E1nedenWWcNGcc7b4u2IQt6W7H4wOhk25w+I/n4YmH0p4iKKJHudZSiR3m69zsgc14u+lG0Nq+8X35L1dOfdD/xJ9RxEccFOr0m+mP7mAsLW0VzVoQbS/zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HsWNrf0K; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723426285; x=1754962285;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ehyDXmakAbdGEtkM0FT6tuhjWESYyQrQ+XxI4bLdEUI=;
  b=HsWNrf0KeS6ileS2HgdxqIpgeSGCx1tBm44KPZea8KoFQgcPgUwPcTyg
   C/iWspxLJRN1+ItnGYVorBL0tdfM1L31XJF0m8yFhgBIjjfNYzTniVZSw
   33cNwxyYLldz5PsNN9w87NxMJASGN8vOItXxj30bNvWSWs57gJ++ZKNzu
   IFSmx6Ba2aKc8iqlyblZ6uB3aDtt2lGTA3J2y2Sp8VG8hi5iO+GiZyeu8
   GWUTramXqRcY0TQFhhcjnGdOhFELNF+AZkogJu/cQeqz0QIthmbUWgifO
   QywL3APyzukBN0FScKy0nOwOjVBTo+xULJ67jafK5oJ4QR8XE67lx1iC9
   w==;
X-CSE-ConnectionGUID: e43ail/iQcCC+jmWIoTjBA==
X-CSE-MsgGUID: MBkQjBU+QHGqYelD8StWiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="44038081"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="44038081"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 18:31:23 -0700
X-CSE-ConnectionGUID: J3J1ZvqtS4i1Z1eq9YB6kA==
X-CSE-MsgGUID: wbpxlisNQDWHnYPRjs3Q6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="63043538"
Received: from yma27-mobl.ccr.corp.intel.com (HELO [10.124.229.129]) ([10.124.229.129])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 18:31:20 -0700
Message-ID: <5210f83c-d2d9-4df6-b3eb-3311da128dae@intel.com>
Date: Mon, 12 Aug 2024 09:31:17 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] fs/file.c: optimize the critical section of
 file_lock in
To: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: jack@suse.cz, mjguzik@gmail.com, edumazet@google.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 pan.deng@intel.com, tianyou.li@intel.com, tim.c.chen@intel.com,
 tim.c.chen@linux.intel.com, yu.ma@intel.com
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240717145018.3972922-1-yu.ma@intel.com>
 <20240722-geliebt-feiern-9b2ab7126d85@brauner> <20240801191304.GR5334@ZenIV>
 <20240802-bewachsen-einpacken-343b843869f9@brauner>
 <20240802142248.GV5334@ZenIV>
 <20240805-gesaugt-crashtest-705884058a28@brauner>
From: "Ma, Yu" <yu.ma@intel.com>
Content-Language: en-US
In-Reply-To: <20240805-gesaugt-crashtest-705884058a28@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/5/2024 2:56 PM, Christian Brauner wrote:
> On Fri, Aug 02, 2024 at 03:22:48PM GMT, Al Viro wrote:
>> On Fri, Aug 02, 2024 at 01:04:44PM +0200, Christian Brauner wrote:
>>>> Hmm...   Something fishy's going on - those are not reachable by any branches.
>>> Hm, they probably got dropped when rebasing to v6.11-rc1 and I did have
>>> to play around with --onto.
>>>
>>>> I'm putting together (in viro/vfs.git) a branch for that area (#work.fdtable)
>>>> and I'm going to apply those 3 unless anyone objects.
>>> Fine since they aren't in that branch. Otherwise I generally prefer to
>>> just merge a common branch.
>> If it's going to be rebased anyway, I don't see much difference from cherry-pick,
>> TBH...
> Yeah, but I generally don't rebase after -rc1 anymore unles there's
> really annoying conflicts.

Thanks Christian and Al for your time and efforts. I'm not familiar with 
the merging process, may i know about when these patches could be seen 
in master ?


Regards

Yu


