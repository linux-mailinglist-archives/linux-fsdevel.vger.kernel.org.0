Return-Path: <linux-fsdevel+bounces-26029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F184C952B39
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 11:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01E951C20DD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 09:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64A11C8FB4;
	Thu, 15 Aug 2024 08:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lsEHAhpE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2903F19ADAC;
	Thu, 15 Aug 2024 08:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710869; cv=none; b=S1ogYG2XNg7vzn/gC2tdC3LY3Jmzs1A5KaKM9qppgbj5nO4y+hJSVvKlQtLFz8XpgxfXilaFwiqVim8TXKG3P/OISMtJ0ZYRD2iZA+kJV668W1XWoe7GJ5mc+0HF9LpI019gimAQj3BcNhZX4YYMQACUMdpgHRQu/T+p94Pfca4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710869; c=relaxed/simple;
	bh=l6uTOVpTy311OyJKRQhu+1tZlo91G64qnhb88hIjfGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Taf7n9aKQ2Amn15/MurzcrVKthHa93pVYovTmq+yjJ4UNwoYNKpP9/4MQS5umkXspSpxUMw8mv7wFTeHAiiFx3M0Iommh8I+fWOf8RBKSdf0uxQXgqlP3jNsMfgrU9uWih/0GimcGf4sHS+6SUqCax6RijvSKQGzoYtJdIMs6wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lsEHAhpE; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723710867; x=1755246867;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l6uTOVpTy311OyJKRQhu+1tZlo91G64qnhb88hIjfGA=;
  b=lsEHAhpExbtCPNVxmowOLIk2WxQ2k/wUPH/d3ddATpyJqJGFxfXg6Mvu
   OoI/1gjz2YDDAzCJZxqml027Lss3BmSQtVxhb4hTni7IYwGLeyDqAIUFJ
   mVNB2noWL+lUQYJlTuBsmhjmGTIaoR9LYRYS+P5fj8Yz2ce+8kZvO6I1p
   KUC0x6OveuWGQBoOHV82w+ARVrcymYKzoV+LfYIYWn+Kc2zgz0ueb6R9f
   j1TpQFPNNx1hCKlrGZgohAApmRBFbgQQg0KKofQKx1IPBvU5+oHVliPQu
   YBYPksPeksp+o/VnDP3z6WOGs1pm07fbGnJq+S2DAKeRD4+GW/wg50RlN
   Q==;
X-CSE-ConnectionGUID: 85GdVc+FTrm+BpXRsp4swQ==
X-CSE-MsgGUID: h/I88kunS8a74yg5PTBbPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="24862710"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="24862710"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 01:34:26 -0700
X-CSE-ConnectionGUID: POjt1XQ3RjmH4xlBOjeC5A==
X-CSE-MsgGUID: /MzwakUGQVOVO/xm2ozkTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="64223943"
Received: from yma27-mobl.ccr.corp.intel.com (HELO [10.124.248.81]) ([10.124.248.81])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 01:34:22 -0700
Message-ID: <3f9d30bf-df46-492a-a82b-7e2eb090ea69@intel.com>
Date: Thu, 15 Aug 2024 16:34:15 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] fs/file.c: remove sanity_check and add
 likely/unlikely in alloc_fd()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, mjguzik@gmail.com, edumazet@google.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 pan.deng@intel.com, tianyou.li@intel.com, tim.c.chen@intel.com,
 tim.c.chen@linux.intel.com, yu.ma@intel.com
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240717145018.3972922-1-yu.ma@intel.com>
 <20240717145018.3972922-2-yu.ma@intel.com> <20240814213835.GU13701@ZenIV>
 <d5c8edc6-68fc-44fd-90c6-5deb7c027566@intel.com>
 <20240815034517.GV13701@ZenIV>
Content-Language: en-US
From: "Ma, Yu" <yu.ma@intel.com>
In-Reply-To: <20240815034517.GV13701@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/15/2024 11:45 AM, Al Viro wrote:
> On Thu, Aug 15, 2024 at 10:49:40AM +0800, Ma, Yu wrote:
>
>> Yes, thanks Al, fully agree with you. The if (error) could be removed here
>> as the above unlikely would make sure no 0 return here. Should I submit
>> another version of patch set to update it, or you may help to update it
>> directly during merge? I'm not very familiar with the rules, please let me
>> know if I'd update and I'll take action soon. Thanks again for your careful
>> check here.
> See the current work.fdtable...
Saw it, thanks :)

