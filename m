Return-Path: <linux-fsdevel+bounces-43450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC03A56BFA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 16:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7307116D3A0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 15:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F14821CC7C;
	Fri,  7 Mar 2025 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B7XQCfn1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0027621A92F;
	Fri,  7 Mar 2025 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361230; cv=none; b=sbM0NvBuKRNAWuV5yTTq595tIKQc9BAdD33pzSn5WrdWdPtsSlTDfqh3954wSVcxVmlqbfhbG/05k2o4V5lPS5xmpAt+w4D12ys4i1UA0l52nCjyHyEYFtecbpQEB018hb90atYVC/QMS1oN8wWttXQpNKUpF9vTkcd+si5DuS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361230; c=relaxed/simple;
	bh=d14TcBCq8tNskRbNOhfQ4KQb7u5Ht3zbufS2FqRKCYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQ25Gd76JxzPHxTvCrC/C4xfCkVttIQjwEkFoRhaZWD4w8SvG7HpIyqn18K6PHdL4ZulJPT2GvWJwXm3pMQUl4T/+zIJeux6WAA5vU+Hm/LouVkIDxlOYNAh47duIEwbRvjt1cwcQhTZqMWwuqGlhLRV5NNVaPPxDeWcNwMwMnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B7XQCfn1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5279O6GO011752;
	Fri, 7 Mar 2025 15:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=6l1/6flwEbafhd438qBLncqgyqXINz
	D2I0nhn9LVcRs=; b=B7XQCfn1B56XyQ7LV9aQk7AlSHBaQAX26Kkef0jwV3Io3+
	7O4BCwGbLOBTk7fQ6QoXGOGxXFsnkLPB3N1LXRN+aXkP6maBrzZ6GxhxWnedQ9Oo
	wb0a4iZTQ2g7ATo8dtTXYc2r2sOjUd9pskzU9gbVuaHEd4nF/xFp800+JEVOPWhQ
	GKjt5kJ1JPDJ72EXv4zqi6PNOFl4dq8BSV4HYb7v8OudjPsxC1x2JjAMpqgWN+io
	pnF/i80BgO5P9FHPQ1ngXhQbOKSmoenJmyqPMQPM3TSekIiVgy4mvsEnTJrpTgLX
	UdnMP6AKZL+jh07ZxCrl8/tTF/vT/81mfmT/7h7w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 457k45cm2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 15:26:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 527E0kgY020873;
	Fri, 7 Mar 2025 15:26:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 454eskf5yk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 15:26:26 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 527FQNxn56426840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Mar 2025 15:26:23 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA59820043;
	Fri,  7 Mar 2025 15:26:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EBFE20040;
	Fri,  7 Mar 2025 15:26:22 +0000 (GMT)
Received: from osiris (unknown [9.171.2.237])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  7 Mar 2025 15:26:21 +0000 (GMT)
Date: Fri, 7 Mar 2025 16:26:20 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: joel granados <joel.granados@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 6/6] s390: mv s390 sysctls into their own file under
 arch/s390 dir
Message-ID: <20250307152620.9880F75-hca@linux.ibm.com>
References: <20250306-jag-mv_ctltables-v2-0-71b243c8d3f8@kernel.org>
 <20250306-jag-mv_ctltables-v2-6-71b243c8d3f8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-jag-mv_ctltables-v2-6-71b243c8d3f8@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CHnHREwPD5LzuGyc-xIZcJW8tFFRpzdB
X-Proofpoint-GUID: CHnHREwPD5LzuGyc-xIZcJW8tFFRpzdB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_06,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxlogscore=686 mlxscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503070111

On Thu, Mar 06, 2025 at 12:29:46PM +0100, joel granados wrote:
> Move s390 sysctls (spin_retry and userprocess_debug) into their own
> files under arch/s390. We create two new sysctl tables
> (2390_{fault,spin}_sysctl_table) which will be initialized with
> arch_initcall placing them after their original place in proc_root_init.
> 
> This is part of a greater effort to move ctl tables into their
> respective subsystems which will reduce the merge conflicts in
> kernel/sysctl.c.
> 
> Signed-off-by: joel granados <joel.granados@kernel.org>
> ---
>  arch/s390/lib/spinlock.c | 18 ++++++++++++++++++
>  arch/s390/mm/fault.c     | 17 +++++++++++++++++
>  kernel/sysctl.c          | 18 ------------------
>  3 files changed, 35 insertions(+), 18 deletions(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com>

How should this go upstream? Will you take care of this, or should
this go via the s390 tree?

