Return-Path: <linux-fsdevel+bounces-40129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86483A1CC7C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2025 17:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4983D1884B7F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2025 16:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAA9155333;
	Sun, 26 Jan 2025 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p18vDsCi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2701AD2D
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jan 2025 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737906920; cv=none; b=dBAsQMcGNiyCGOWUBQzMuZJZT5bw6E/ZBelFLhRp2sgPLbowjtK61a+ekLKH4sLaIojNTVDcqEeki+Sjpc24+wtbqQ0RtMIzeRLJCa4lToSwbqkkfwgWZmexSYhR4uTYz43gcv/edTjxXWx9Tn1FK1dloJO46qaEtbym6remZcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737906920; c=relaxed/simple;
	bh=DXMvft0O4XiJe+1oTSU9L29azZ1hAhAt34R4VfjFfN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0Qtr3iJuuxHMg4S09Gbv0PmxDlT7gCwHouBZIAwc0XTvMzwkwlUzSGrHGYkHjKJcSprENzOuiolCpqqyfk3Z+HLYYAN1/HM0DzJrHfl4MqKYipGyFzKrz6sNNgd+PVfpLtEjVR2WeSjDO+LtXq0xOAe66hPiVyZPQCs+n5RZuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p18vDsCi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50QFe5OT025921;
	Sun, 26 Jan 2025 15:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=0ExQz2LGkzGQ4zgyv7oTbKecX70H/y
	grKaGz4l2lz18=; b=p18vDsCiopjSKUwVGTopaeu6/RgrvpRBfugPpfEV81fyYw
	F+BMARTFwhlrnCQ0hxIkOhdpF0JRGxMGsNRo4DkjgG0nrGw0oiPmw0b8IhRCxSvl
	SKztuwD+0B8ZRlSO3XbznrtfwdUUcUuvcw+KEN1+XDw4f9RKGEzrgByhlGVTUTXL
	UwrgSmFDXaK+WxIwAL0YS5NnehOv0XXX3n/QaJGXW35few3MzUmCaz3p3JOxJutV
	TkHUpRikTh9Q/birv7SQGSyq2aMxd8sXkR7chR9j1fn/RWmWAHqdlVChVVkx71dl
	mpaiJ72RMY+Qd21y23N1Vnt3WeRIolFHljs37MSw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44dqvt01k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jan 2025 15:55:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50QCwEF7022538;
	Sun, 26 Jan 2025 15:55:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44dcgja93x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jan 2025 15:55:13 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50QFtCr123200010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jan 2025 15:55:12 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E756120090;
	Sun, 26 Jan 2025 15:55:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6B442008E;
	Sun, 26 Jan 2025 15:55:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 26 Jan 2025 15:55:01 +0000 (GMT)
Date: Sun, 26 Jan 2025 16:54:55 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
        "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
        "Saarinen, Jani" <jani.saarinen@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Regression on linux-next (next-20250120)
Message-ID: <Z5Zazwd0nto-v-RS@tuxmaker.boeblingen.de.ibm.com>
References: <SJ1PR11MB6129D7DA59A733AD38E081E3B9E02@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <20250123181853.GC1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123181853.GC1977892@ZenIV>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: J8jsyB_zQXgvmfCIN9qlOQBZY2rDRS7-
X-Proofpoint-GUID: J8jsyB_zQXgvmfCIN9qlOQBZY2rDRS7-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-26_06,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0
 clxscore=1011 malwarescore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501260125

On Thu, Jan 23, 2025 at 06:18:53PM +0000, Al Viro wrote:

Hi Al,

> On Thu, Jan 23, 2025 at 03:41:08PM +0000, Borah, Chaitanya Kumar wrote:
> > Hello Al,
> > 
> > Hope you are doing well. I am Chaitanya from the linux graphics team in Intel.
> > 
> > This mail is regarding a regression we are seeing in our CI runs[1] on linux-next repository.
> > 
> > Since the version next-20250120 [2], we are seeing the following regression
> 
> Ugh...  To narrow the things down, could you see if replacing
>                 fsd = kmalloc(sizeof(*fsd), GFP_KERNEL);
> with
>                 fsd = kzalloc(sizeof(*fsd), GFP_KERNEL);
> in fs/debugfs/file.c:__debugfs_file_get() affects the test?

This change fixes lots of the below failures in our CI. FWIW:

Tested-by: Alexander Gordeev <agordeev@linux.ibm.com>

Unable to handle kernel pointer dereference in virtual kernel address space
Failing address: 0000000000000000 TEID: 0000000000000000
Fault in primary space mode while using kernel ASCE.
AS:0000000243668007 R3:00000003fee58007 S:00000003fee57801 P:000000000000013d
Oops: 0004 ilc:1 [#1] SMP
Modules linked in: binfmt_misc mlx5_ib ib_uverbs ib_core dm_service_time nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables mlx5_core pkey_pckmo uvdevice s390_trng rng_core eadm_sch vfio_ccw mdev vfio_iommu_type1 vfio sch_fq_codel drm i2c_core loop dm_multipath drm_panel_orientation_quirks configfs nfnetlink lcs ctcm fsm zfcp scsi_transport_fc hmac_s390 ghash_s390 prng chacha_s390 libchacha aes_s390 des_s390 libdes sha3_512_s390 sha3_256_s390 sha512_s390 sha256_s390 sha1_s390 sha_common scsi_dh_rdac scsi_dh_emc scsi_dh_alua pkey autofs4 ecdsa_generic ecc
CPU: 3 UID: 0 PID: 19223 Comm: dump2tar Not tainted 6.14.0-20250123.rc0.git129.853d1f41ba73.300.fc41.s390x+next #1
Hardware name: IBM 9175 ME1 701 (LPAR)
Krnl PSW : 0704e00180000000 0000000000000000 (0x0)
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
Krnl GPRS: 0000000000000003 0000029253f7f100 00000000a9fa0600 000003ff84472010
           0000000000080000 00000212db803e68 00000212db803e68 0000000000080000
           00000000cf33c6c0 00000000be6d6a00 00000000a9fa0600 0000000000000000
           000003ff909acfa0 000003ff84472010 00000292d425da96 00000212db803c98
Krnl Code:>0000000000000000: 0000            illegal
           0000000000000002: 0000            illegal
           0000000000000004: 0000            illegal
           0000000000000006: 0000            illegal
           0000000000000008: 0000            illegal
           000000000000000a: 0000            illegal
           000000000000000c: 0000            illegal
           000000000000000e: 0000            illegal
Call Trace:
 [<0000000000000000>] 0x0
([<000001e12d421b6a>] full_proxy_read+0x4a/0xc0)
 [<000001e12d18ac16>] vfs_read+0x96/0x340
 [<000001e12d18b7b8>] ksys_read+0x78/0x100
 [<000001e12cdbf9d6>] do_syscall.constprop.0+0x116/0x140
 [<000001e12dba3ff4>] __do_syscall+0xd4/0x1c0
 [<000001e12dbaf404>] system_call+0x74/0x98

 Thanks!

