Return-Path: <linux-fsdevel+bounces-25692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F57B94F160
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 17:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E521F22D48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 15:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B0F18455D;
	Mon, 12 Aug 2024 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WbHWs7G/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D1E17E8E5;
	Mon, 12 Aug 2024 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475387; cv=none; b=WKaqa0CCpvKjqlO0lE7Q6E1E3T8bZxh1A79p//9CazCJEqQe/htqiC1NC45wWBiD731d4FVQvuoYV6XYvQA21YvP2r87urlah0gEiCZCi+z18Cl7HN5g1aG80spcXCs+UmqaK+tz1AQmhATNuh7OdaRDgGL9LftZZUznhOVroak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475387; c=relaxed/simple;
	bh=V8x/pE2N8gWaCLdAIfzjBYQw5lFTC3b43PDtgiinNg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K/mVpOR1N8to3F0YWqOxT7qHaePTWSGDXkrT3MXYF8iXqFxfdIzzrS2h1pHmJnvudiitDBvJi8vRzem4RigYQHW//qK47+a26rRDGas5GR4suo5dQjnUj/VSpMtLwOMKgexcEy0Ja+pmftkRBXQSq6YLEP+rDGSaC9sxQIRa7d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WbHWs7G/; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723475384; x=1755011384;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V8x/pE2N8gWaCLdAIfzjBYQw5lFTC3b43PDtgiinNg8=;
  b=WbHWs7G/Km0/rA3gpww6yJQArSM9Wk96nI3sF5xaOj+ZALHWKT4i03PQ
   i7+4t9yqsC6EmY/vqs23TSYbdG7teLgADDPho6BD2DUYSyZ/6IbJw9C3i
   ok87Ep3pnn1V1GDHYtxx8ZbDuGXnUm5GhEzJjlmGZ9LTwNbBcO7E2r+9i
   0E2xeO0qyf1erKsH7oPV8FpFWh8bq0gGbChEBkNFE5eJDfVwHtJdAUvnT
   hCPPD2nMuM/Hyn8S3zluUx4nJSMl1loWZm6JkFfsVrjf5hqE36bUz9415
   DUzAZjtz9WHJBeWwtr4XEXLiUMlBS7udDKCXO1fO5BRaCLliaY8nVS4DM
   g==;
X-CSE-ConnectionGUID: tOuzliylQeat8QBQkN61jA==
X-CSE-MsgGUID: iUNi6I3FQbWUPSJiC9moGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="32271048"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="32271048"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 08:09:43 -0700
X-CSE-ConnectionGUID: MKGquCtlSNiM7UzPf0sULw==
X-CSE-MsgGUID: qIGRkrvPQrKcqncW2uKNPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="63141138"
Received: from yma27-mobl.ccr.corp.intel.com (HELO [10.124.234.236]) ([10.124.234.236])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 08:09:40 -0700
Message-ID: <627b420c-ff43-439b-8485-1346215d45bc@intel.com>
Date: Mon, 12 Aug 2024 23:09:36 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] fs/file.c: optimize the critical section of
 file_lock in
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, jack@suse.cz, mjguzik@gmail.com,
 edumazet@google.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, pan.deng@intel.com, tianyou.li@intel.com,
 tim.c.chen@intel.com, tim.c.chen@linux.intel.com, yu.ma@intel.com
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240717145018.3972922-1-yu.ma@intel.com>
 <20240722-geliebt-feiern-9b2ab7126d85@brauner> <20240801191304.GR5334@ZenIV>
 <20240802-bewachsen-einpacken-343b843869f9@brauner>
 <20240802142248.GV5334@ZenIV>
 <20240805-gesaugt-crashtest-705884058a28@brauner>
 <5210f83c-d2d9-4df6-b3eb-3311da128dae@intel.com>
 <20240812024044.GF13701@ZenIV>
Content-Language: en-US
From: "Ma, Yu" <yu.ma@intel.com>
In-Reply-To: <20240812024044.GF13701@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/12/2024 10:40 AM, Al Viro wrote:
> On Mon, Aug 12, 2024 at 09:31:17AM +0800, Ma, Yu wrote:
>> On 8/5/2024 2:56 PM, Christian Brauner wrote:
>>> On Fri, Aug 02, 2024 at 03:22:48PM GMT, Al Viro wrote:
>>>> On Fri, Aug 02, 2024 at 01:04:44PM +0200, Christian Brauner wrote:
>>>>>> Hmm...   Something fishy's going on - those are not reachable by any branches.
>>>>> Hm, they probably got dropped when rebasing to v6.11-rc1 and I did have
>>>>> to play around with --onto.
>>>>>
>>>>>> I'm putting together (in viro/vfs.git) a branch for that area (#work.fdtable)
>>>>>> and I'm going to apply those 3 unless anyone objects.
>>>>> Fine since they aren't in that branch. Otherwise I generally prefer to
>>>>> just merge a common branch.
>>>> If it's going to be rebased anyway, I don't see much difference from cherry-pick,
>>>> TBH...
>>> Yeah, but I generally don't rebase after -rc1 anymore unles there's
>>> really annoying conflicts.
>> Thanks Christian and Al for your time and efforts. I'm not familiar with the
>> merging process, may i know about when these patches could be seen in master
> It's in work.fdtable in my tree, will post that series tonight and add to #for-next

Thanks Al for confirmation :)


