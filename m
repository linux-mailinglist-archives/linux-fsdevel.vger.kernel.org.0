Return-Path: <linux-fsdevel+bounces-35445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1059D4D1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 13:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E631B257A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 12:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F44A1D799D;
	Thu, 21 Nov 2024 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="exRLNVMg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB621D04B9;
	Thu, 21 Nov 2024 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732193304; cv=none; b=YzkoIiigmUi9vfNPIdiNOy2/u25cpPghdq0F9ZQYIuzbQ+8L3JasoDWWxmKHn5a0lTipEy69mOqmkbVOXIC3Zyrf4IAcuCgAIvq7h+cLhLzv2H4e1wJwrZ5l7HSxBijaotqT7fLl4F3y0paIZmeCP9nnVYBxtP39N4p2smNT59Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732193304; c=relaxed/simple;
	bh=V6h68H8dHWhb99rXhqd+FgVURyJXDChT4nqQs+LWmwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gz3NwVIK38KA4LI1We2+icDoAppXw0WQFTIs9vnTJGoLP8gjYY7cwrqM/GjsxBuiXMqtJIBJeLdM1GHIFl9UnSj/sJ1UIMWnGBKIwyJChtDL+XLPU5YtPjNQk/pWCaB+CmywoccxGThRiL+CJslodw9mtb/M14SIwUi2vsPt8NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=exRLNVMg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL8eCQO010271;
	Thu, 21 Nov 2024 12:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=m9hVYClbCAMOmyugw63CMTQBhJJdSW
	5LuLjt4ZXI/pY=; b=exRLNVMgWxEaS7lU+yxaYTZg0qc61b4oCMgHFvzM+9TtDL
	MITh5+6nCIM7VmCcuzeKocpaPEiMYO5c4iGo8x5wC268PsUtXqVjJTjGHjE7CP27
	STpuLY7gh9EoMqYxHzK3ktjjJh5CNR80BwtHSSWPHHPH5pD73z7Au2E2VFEgweub
	D0235m/Mgpy4L91BRhjt1V2pGrZQCHuDeLz0R25pe/h5NygF3sRTM94OQdEtevFI
	WX9ot0lX4IjwIiyQaJYv04mNZS2Oo+tGhyT4RXx8FjhfP87JUnnjV6hQjACAzyH6
	YM+s3U2Q0TT0ohv5fMpTCqpWC5fqgjEBXBfeTByg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xyu21mrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 12:48:10 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4ALCaD7V004456;
	Thu, 21 Nov 2024 12:48:09 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xyu21mrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 12:48:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL7MbtV024610;
	Thu, 21 Nov 2024 12:48:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42y8e1gku8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 12:48:08 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ALCm7DP58720624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 12:48:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA65920043;
	Thu, 21 Nov 2024 12:48:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B05FE20040;
	Thu, 21 Nov 2024 12:48:05 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 21 Nov 2024 12:48:05 +0000 (GMT)
Date: Thu, 21 Nov 2024 18:18:03 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH v2 0/2] Fix generic/390 failure due to quota release
 after freeze
Message-ID: <Zz8sA7YavAg8+mqI@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20241121123855.645335-1-ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121123855.645335-1-ojaswin@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Om05031vx9cGbA3Ie5fxutlFcxWgbOF5
X-Proofpoint-ORIG-GUID: 275cugeP6hY2B4eTA0bJrGx6mmc6ywmB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411210098

On Thu, Nov 21, 2024 at 06:08:53PM +0530, Ojaswin Mujoo wrote:
> Changes since v1:

Forgot to link v1:

https://lore.kernel.org/linux-ext4/20241115183449.2058590-1-ojaswin@linux.ibm.com/T/#t

> 
>  * Patch 1: Move flush_delayed_work() to start of function
>  * Patch 2: Guard ext4_release_dquot against freeze
> 
> Regarding patch 2, as per my understanding of the journalling code,
> right now ext4_release_dquot() can only be called from the
> quota_realease_work workqueue and hence ideally should never have a
> journal open but to future-proof it we make sure the journal is not
> opened when calling sb_start_inwrite().
> 
> ** Original Cover **
> 
> Recently we noticed generic/390 failing on powerpc systems. This test
> basically does a freeze-unfreeze loop in parallel with fsstress on the
> FS to detect any races in the code paths.
> 
> We noticed that the test started failing due to kernel WARN_ONs because
> quota_release_work workqueue started executing while the FS was frozen
> which led to creating new transactions in ext4_release_quota. 
> 
> Most of the details are in the bug however I'd just like to add that
> I'm completely new to quota code so the patch, although fixing the
> issue, might be not be logically the right thing to do. So reviews and
> suggestions are welcome. 
> 
> Also, I can only replicate this race on one of my machines reliably and
> does not appear on others.  I've tested with with fstests -g quota and
> don't see any new failures.
> 
> Ojaswin Mujoo (2):
>   quota: flush quota_release_work upon quota writeback
>   ext4: protect ext4_release_dquot against freezing
> 
>  fs/ext4/super.c  | 17 +++++++++++++++++
>  fs/quota/dquot.c |  2 ++
>  2 files changed, 19 insertions(+)
> 
> -- 
> 2.43.5
> 

