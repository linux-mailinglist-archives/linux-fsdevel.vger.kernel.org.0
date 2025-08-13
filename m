Return-Path: <linux-fsdevel+bounces-57682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E57DB2472B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 12:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A56622E7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 10:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038AE2F2913;
	Wed, 13 Aug 2025 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="f8mVD5J9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613F12E7BA5;
	Wed, 13 Aug 2025 10:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755080806; cv=none; b=r1h5/Xj4dXmCKyf+p+Ey1TT8AQryrT4BkHdRZm7mkiL+X0gFpViX1yx1nLfnjPGzNzCrZdWS1IKQrzych5sE3bXc03yVvlilrCrOJFVwwf7T2NEV1W/oZUuDKGprtzUy5hMhu8WF7EPsGYjUkWalnBPfHtLOZqNrcaI7dxY+iR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755080806; c=relaxed/simple;
	bh=cxNTLaWlz+Z+DXUaU3TccjMca52ZIUFzpc6xyx86tzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C0qKuii1NxBIsElp2PtJUm7jdBgaZvuRLHH9MITb4fFCDO31hZZRt6pUMrU5HVbymRm4Jl3PR65oeyKnsv5Lpyi3UDwB0lsU5J7RSNoONMOoVEitwvSkRCGkihyaZe4s19OywfP03nLTmDPjDWjAOQ5PT5qFkixlikJSmIjjTEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=f8mVD5J9; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/igN/4vZBSgdq1C5WsUcG5wcK51bFeRFJTKMj+Q+1cU=; b=f8mVD5J9jFpgHazX+M4wRz6VTg
	06OffFNxGS9eeenKOyJDu31FyTLSF2oPFG2gYMRQUJFC/OhT+mcn8zZVDbPDMRomyhAe/YxPnL7Sf
	0W+HLYiwUdZielZbVU85KOVFRN2Aw/0QikGcAjSjaob3eSRynkVLYlAVEF8MsT30StEXktETyvJAM
	qQe6t/V5vt4x7WDanAkKUJ85fxPOuoMkUbnhaDWTI+rcIAW1fsM1nXyzYe1CEbTULhsFk7LB9/J9L
	69Y9/UAfnomA9vmLNzdyCj4qgMBSZK9z2CSlmPAyO20izELtwz/xtiDWNxPJ+tESbn2gu4t9yQqpR
	SYqxkeNw==;
Received: from [223.233.74.188] (helo=[192.168.1.12])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1um8gi-00Dcgg-50; Wed, 13 Aug 2025 12:26:32 +0200
Message-ID: <5d949644-6a4a-3b94-8794-27c2b5cfd976@igalia.com>
Date: Wed, 13 Aug 2025 15:56:22 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v7 3/4] treewide: Replace 'get_task_comm()' with
 'strscpy_pad()'
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: kernel test robot <lkp@intel.com>, Bhupesh <bhupesh@igalia.com>,
 akpm@linux-foundation.org, oe-kbuild-all@lists.linux.dev,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, oliver.sang@intel.com, laoar.shao@gmail.com,
 pmladek@suse.com, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 arnaldo.melo@gmail.com, alexei.starovoitov@gmail.com,
 andrii.nakryiko@gmail.com, mirq-linux@rere.qmqm.pl, peterz@infradead.org,
 willy@infradead.org, david@redhat.com, viro@zeniv.linux.org.uk,
 keescook@chromium.org, ebiederm@xmission.com, brauner@kernel.org,
 jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com,
 mgorman@suse.de
References: <20250811064609.918593-4-bhupesh@igalia.com>
 <202508111835.JFL8DgKY-lkp@intel.com>
 <6b5c92c4-2170-8ce9-3c9f-45c0e1893e03@igalia.com>
 <aJoE_tzAGE4krB5y@black.igk.intel.com>
From: Bhupesh Sharma <bhsharma@igalia.com>
In-Reply-To: <aJoE_tzAGE4krB5y@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/11/25 8:28 PM, Andy Shevchenko wrote:
> On Mon, Aug 11, 2025 at 08:19:08PM +0530, Bhupesh Sharma wrote:
>> On 8/11/25 4:55 PM, kernel test robot wrote:
>> As mentioned in the accompanying cover letter, this patchset is based on
>> 'linux-next/master' (the exact sha-id used for rebase is:
>> b1549501188cc9eba732c25b033df7a53ccc341f ).
> Instead of getting false positive reports and this rather unneeded reply from
> you, use --base parameter when formatting patch series. It will help all,
> including CIs and bots.
>

Sure, will include it in next version. Waiting for further reviews on 
this v7.

Thanks.

