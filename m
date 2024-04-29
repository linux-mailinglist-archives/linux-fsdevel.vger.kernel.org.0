Return-Path: <linux-fsdevel+bounces-18086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 293048B5488
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 11:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D375C282840
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 09:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4982E40E;
	Mon, 29 Apr 2024 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kg9UUvOf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B7CEAC2;
	Mon, 29 Apr 2024 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714384117; cv=none; b=et4LcncpJLClI7XZP4GAY+YrXhU0IHVny5ZndivIfXoSyUhm6Hkt/CUAfqnqm0Z6znZoV8X6zMD14tvTY8JTmiGBBFsHkd9UjrdvOjfynNrR/HOa5UV2IsdowUSPQ5dVQBGBU7Hq1wCfSa7hgDrvtKJA7Dza6oJ+7e0xCUPEQic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714384117; c=relaxed/simple;
	bh=eOQoFD2Q1RfOcsu5iO/K4iGBJCStR6G+ZsM+imLU3t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHlOSVCRZv8lmIgFhso1S12E/Dr61l2VU/aTPZf4gjg2fg+HXs0HnJQf/w1h9/a4dnOXS3tpyNZdknwiuh9Ggl2X/4VYA8IOnvWPl808vjn6iEsau1aV0ouD5tDMq/vTMpV5BZ9+HbJFmaUJl4ISFay+mBBHXH4aUdTwTQF6/Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kg9UUvOf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43T9WcRr023175;
	Mon, 29 Apr 2024 09:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=Kn2/uMMJ4m7IZDO8WlgsPqO7vUsAlVouDdMvBgTuG6Q=;
 b=Kg9UUvOfIY+q0ndE7ZECmZZUdA61ZCkJRFtD9wLCjYzo6fe8LGiqgmj/OaQd5I/iEeGT
 h1W12UFRvhBs0Ojrxq2EVahg4SwzhBVbMh+nl7Xnt0KphpPc+1K4uJnLB1ltR+O9/J8Y
 xH2aBPNbeoLf7rIVjTmAK85pN4JRaPC9PScCooRYa7ChiJY29YfixJaL//aFd9303wQR
 GZQxdsEVeB2nF62y0IT3RUjuxSeOIjIAGLlEpPQHiihzSala+ltUzs1I4eJF+yCxcsu9
 xwGFkZf6AwHS79UZe7yymFDc9jL+Zte2Za8lJWgzOlYfHYZrwUSEHHijG4bCs204Im4A kw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xt90jg0v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 09:47:55 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43T9ltmx016519;
	Mon, 29 Apr 2024 09:47:55 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xt90jg0v5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 09:47:54 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43T7DaXf001450;
	Mon, 29 Apr 2024 09:47:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xsbptppem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 09:47:53 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43T9loYx26542522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 09:47:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0556520040;
	Mon, 29 Apr 2024 09:47:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4E6220043;
	Mon, 29 Apr 2024 09:47:48 +0000 (GMT)
Received: from osiris (unknown [9.171.12.101])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 29 Apr 2024 09:47:48 +0000 (GMT)
Date: Mon, 29 Apr 2024 11:47:47 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
        Joel Granados <j.granados@samsung.com>,
        Kees Cook <keescook@chromium.org>, Eric Dumazet <edumazet@google.com>,
        Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-xfs@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        kexec@lists.infradead.org, linux-hardening@vger.kernel.org,
        bridge@lists.linux.dev, lvs-devel@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-sctp@vger.kernel.org, linux-nfs@vger.kernel.org,
        apparmor@lists.ubuntu.com
Subject: Re: [PATCH v3 11/11] sysctl: treewide: constify the ctl_table
 argument of handlers
Message-ID: <20240429094747.29046-G-hca@linux.ibm.com>
References: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
 <20240423-sysctl-const-handler-v3-11-e0beccb836e2@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423-sysctl-const-handler-v3-11-e0beccb836e2@weissschuh.net>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dsJabyKjD5wmo-a4UVf9qexuuOQkOoCK
X-Proofpoint-GUID: 7SlQVN0HjcUbQBl5eVSaH1VEy2oE_0-m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_07,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 clxscore=1011 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290061

On Tue, Apr 23, 2024 at 09:54:46AM +0200, Thomas Weiﬂschuh wrote:
> Adapt the proc_hander function signature to make it clear that handlers
> are not supposed to modify their ctl_table argument.
> 
> This is a prerequisite to moving the static ctl_table structs into
> rodata.
> By migrating all handlers at once a lengthy transition can be avoided.
> 
> The patch was mostly generated by coccinelle with the following script:
> 
>     @@
>     identifier func, ctl, write, buffer, lenp, ppos;
>     @@
> 
>     int func(
>     - struct ctl_table *ctl,
>     + const struct ctl_table *ctl,
>       int write, void *buffer, size_t *lenp, loff_t *ppos)
>     { ... }
> 
> In addition to the scripted changes some other changes are done:
> 
> * the typedef proc_handler is adapted
> 
> * the prototypes of non-static handler are adapted
> 
> * kernel/seccomp.c:{read,write}_actions_logged() and
>   kernel/watchdog.c:proc_watchdog_common() are adapted as they need to
>   adapted together with the handlers for type-consistency reasons
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

...

>  arch/s390/appldata/appldata_base.c        | 10 ++---
>  arch/s390/kernel/debug.c                  |  2 +-
>  arch/s390/kernel/topology.c               |  2 +-
>  arch/s390/mm/cmm.c                        |  6 +--

Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390

