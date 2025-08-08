Return-Path: <linux-fsdevel+bounces-57117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9A6B1EDC1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 19:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C3C5857E1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 17:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC07228751D;
	Fri,  8 Aug 2025 17:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K5J2AzAJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E40B18871F;
	Fri,  8 Aug 2025 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754673699; cv=none; b=lv4Rx4c93BPWxtYsdg7aRy4059kE2x7B9Oufucy21gXTzW5aaBp6nGTsExTVziQcwMF9Ep5vctTj+OxoI2NVxG5crSD3ZOWegULQFPWdT7oL/j1kNgedZZrVEcatroScsJA6VQXj3xe9Cr62Q50RB70iWlz3hT7oDgb8ghVPm10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754673699; c=relaxed/simple;
	bh=DBKFYTu5tPuGX9ybLDozeJ5i82kOtDjidng1iB4g6xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JccXSBRoTO9Av7KiD/d3S0BiO2ayZOIwKIm87f7wC/Hj76Ds1c03LdCEdoO4bE0MWoNGRdKm5JkWv4mXIiS6458LqdiZ7J2fHIBWrPqpKwJME0TX1PUFXhfTQ6X8XaacBt7+6FJeIS8l72cvjvwbUE/u7ZSOx3Z+GLSk0wEvET4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K5J2AzAJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578EVqe4022753;
	Fri, 8 Aug 2025 17:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ke2ysD
	bRl8q6joTUOu+MU16x2yWgmGXvnQxWBgQqMZ8=; b=K5J2AzAJbr6j1wVE7r2WCZ
	eqTkH+QNahoaI/wn8Psq6tEemu90x0/gr1RPOD9AM8Rxf2Jj8ookp5kbaMaTwQeS
	o2Hhy7fZvogZNoVib1gjYnWX4xKl3knSGj0ed0LJRPPFh9AXl5klylFvexrIn5bE
	tfRZ4vdxMWnbJhCIrwFy5gxez8wqKSdFTwsu/HEGz5RN7KqEDXWiqb7jndIdTZzb
	UPYGESswg1VN3vfF9yk4KrRqBbVCRFtjIH71BLlKsif2L7NJ6zlOzfVdtyQAjfHM
	Smu8S2pLHLC+9j01rXBmkp5SFM8Wl0nkGazzKnXw7l0/YtGz/Uhg/YA2Z9yrq56g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dk2n8tua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 17:21:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 578EvZbt031326;
	Fri, 8 Aug 2025 17:21:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwnpka9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 17:21:13 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 578HLB2j22085908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Aug 2025 17:21:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D36920040;
	Fri,  8 Aug 2025 17:21:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B8902004D;
	Fri,  8 Aug 2025 17:21:09 +0000 (GMT)
Received: from li-e7e2bd4c-2dae-11b2-a85c-bfd29497117c.ibm.com (unknown [9.39.29.218])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  8 Aug 2025 17:21:08 +0000 (GMT)
Date: Fri, 8 Aug 2025 22:51:06 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex.williamson@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>,
        Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v4] vfio/pci: print vfio-device syspath to fdinfo
Message-ID: <20250808224806.09f6d858-1d-amachhiw@linux.ibm.com>
Mail-Followup-To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, 
	Alex Mastro <amastro@fb.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>, Keith Busch <kbusch@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org
References: <20250804-show-fdinfo-v4-1-96b14c5691b3@fb.com>
 <20250807144938.e0abc7bb-a4-amachhiw@linux.ibm.com>
 <dd0b8e6f-1673-49c3-8018-974d1e7f1a54@kaod.org>
 <20250808205338.dc652e3e-61-amachhiw@linux.ibm.com>
 <bc7e754f-f414-4c43-8f25-03314b894b34@kaod.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc7e754f-f414-4c43-8f25-03314b894b34@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDE0MSBTYWx0ZWRfX+LTZsfDCvdAS
 zgJH5N24m4p3Hd0TMlHdhraDi2L6J4fMXCjO17EiVdWhz9L5farTcSVt51IlhCDnEkO3A0liE+l
 gxX1QcqTVv+AQtkU6oZTlxBaWl7yEy3ipqCmrLDRaNr1n1PvJpQJadBTnLP0pMmOjqhTjUAH1uM
 T4DGk6SJsmPXYCMyv7xJBz1/onhyDuoleA2i2fCk+cnkSue7oDg4AKgJAbMt/J9PZMtD3IzszgQ
 8UGSXM0MIrBkDaVSALNMBWjKc9PLDQuCAc3xM+5bE3dT1JOHRnSi7GV4hTrGm/tUjtcA/tIKoA2
 7oAeFuBEklmOCEr/GI4C+OEVwgGPs7e4l/NzdRyaG+dxBMcCUIT1VcKCCSi6pg4L0hRvOdNvl2f
 1cMq6blohiFwylb3WPBTvt0yaPslRtECXn+uvQoLu5P8BqWpEHa/5Lfs1tiQQiw+vvTFaCwZ
X-Proofpoint-GUID: A3HiGeHw8cjSeUofRyC2D-HKmq29oXh6
X-Proofpoint-ORIG-GUID: A3HiGeHw8cjSeUofRyC2D-HKmq29oXh6
X-Authority-Analysis: v=2.4 cv=BNWzrEQG c=1 sm=1 tr=0 ts=6896320a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=2OwXVqhp2XgA:10 a=FOH2dFAWAAAA:8 a=1rDcQM-rTn2rXFAQwpAA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound
 score=100 suspectscore=0 lowpriorityscore=0 spamscore=100 bulkscore=0
 impostorscore=0 phishscore=0 mlxscore=100 clxscore=1015 malwarescore=0
 priorityscore=1501 adultscore=0 mlxlogscore=-999 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508080141

On 2025/08/08 06:44 PM, Cédric Le Goater wrote:
> On 8/8/25 17:45, Amit Machhiwal wrote:
> > Hi Cédric,
> > 
> > Please find my comments inline:
> > 
> > On 2025/08/08 03:49 PM, Cédric Le Goater wrote:
> > > Hello Amit,
> > > 
> > > On 8/7/25 11:34, Amit Machhiwal wrote:
> > > > Hello,
> > > > 
> > > > On 2025/08/04 12:44 PM, Alex Mastro wrote:
> > > > > Print the PCI device syspath to a vfio device's fdinfo. This enables tools
> > > > > to query which device is associated with a given vfio device fd.
> > > > > 
> > > > > This results in output like below:
> > > > > 
> > > > > $ cat /proc/"$SOME_PID"/fdinfo/"$VFIO_FD" | grep vfio
> > > > > vfio-device-syspath: /sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/0000:e2:05.0/0000:e8:00.0
> > > > > 
> > > > > Signed-off-by: Alex Mastro <amastro@fb.com>
> > > > 
> > > > I tested this patch on a POWER9 bare metal system with a VFIO PCI device and
> > > > could see the VFIO device syspath in fdinfo.
> > > 
> > > POWER9 running on OPAL FW : I am curious about the software stack.
> > > 
> > > I suppose this is the latest upstream kernel ?
> > 
> > Yes, I used the latest upstream kernel and applied this patch on top of commit
> > cca7a0aae895.
> > 
> > > Are you using an upstream QEMU to test too ?
> > 
> > No, I had used the Fedora 42 distro qemu. The version details are as below:
> > 
> >    [root@localhost ~]# qemu-system-ppc64 --version
> >    QEMU emulator version 9.2.4 (qemu-9.2.4-1.fc42)
> >    Copyright (c) 2003-2024 Fabrice Bellard and the QEMU Project developers
> > 
> > I gave the upstream qemu (HEAD pointing to cd21ee5b27) a try and I see the same
> > behavior with that too.
> > 
> >    [root@localhost ~]# ./qemu-system-ppc64 --version
> >    QEMU emulator version 10.0.92 (v10.1.0-rc2-4-gcd21ee5b27-dirty)
> >    Copyright (c) 2003-2025 Fabrice Bellard and the QEMU Project developers
> > 
> >    [root@localhost ~]# cat /proc/52807/fdinfo/191
> >    pos:    0
> >    flags:  02000002
> >    mnt_id: 17
> >    ino:    1125
> >    vfio-device-syspath: /sys/devices/pci0031:00/0031:00:00.0/0031:01:00.0
> > 
> > > 
> > > and which device ?
> > 
> > I'm using a Broadcom NetXtreme network card (4-port) and passing through its
> > fn0.
> > 
> >    [root@guest ~]# lspci
> >    [...]
> >    0001:00:01.0 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
> > 
> > Please let me know if I may help you with any additional information.
> 
> It is good to know that device pass-through still works with upstream on
> OpenPower servers.
> 
> Have you tried VFs ?

I didn't get a chance to try VFs yet, Cédric.

> 
> Thanks Amit,

No problem. :)

Thanks,
Amit

> 
> C.
> 

