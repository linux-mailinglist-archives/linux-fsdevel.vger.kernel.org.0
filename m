Return-Path: <linux-fsdevel+bounces-43694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D241DA5BE6C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 12:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65F061897C61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 11:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244B8253B59;
	Tue, 11 Mar 2025 11:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ct8X7uw8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65F12505AC;
	Tue, 11 Mar 2025 11:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741690992; cv=none; b=XPRnXFGoNpYFnW5+tx9/ZBVSek/HAdBO3sYdRP5+UhY7FJTeFmKRC3eIC7J3zOqjX3SfxtziqB/ZMv1Ayz3fkWBNV21wVBNidXfNStUzXaMkAnHxyr7oqkAAorxYfibhu6xUH1o5HrHWskW5gU8WeIQj/oiTYTx2onxMxcpYOdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741690992; c=relaxed/simple;
	bh=qAoAEAm5amauGeRnu7bSr3vPpdizHeYfV+q57O0m6pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwYL/8R7q+7/LmKzu/R+KVxFDH/k9BuX8EPSOz9zngw4H+DPSI9QisLbyD/voKIvzvKdugX/AXpS4QBpdHLDzZfEq7+8cszjgppcc10eU2xDqq5CP5LXMDVeI/ED6JhSZnbbPxKnbLEmuhlMXwJwLkIOAIaOfVCJa3tNnbT5BoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ct8X7uw8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B93ZVX004497;
	Tue, 11 Mar 2025 11:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=xIPaMqGrsjATDI3COz82wtEWPVXld8
	ipZrTVOIdtc+s=; b=Ct8X7uw8PWloUFD0MWoLtbch0x8v7ZBHf4sghnsOPUgWIL
	4laCm8tkNral1P/z9pa2nZgA47oQRfKv0WakeNyyB8R9+Vh6Guw5jpCe+lYkjc9E
	bj1tlXHKycXEbwA92MaXqkgcxxxOUUrD+0SLU9/Js2h7D+seIhAt3DVxnnK2+m+M
	SnyXc8vAJyFHNNDHeTCQD7oaSV4hC/oLJUqp7OlFlDHv5ZRbtLJD4z9Jc5AwgRoc
	/tM4WLkcBDQSA5Xdjf0/2qKWFBR96zHjriFf3YMAmrtmTXRoQMHGolmkB2ovcko5
	8nhdu6grKgQd2Owr1x8xMpERkdmzu36UAYVwDP6Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a78qudaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 11:02:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52B9qE2P027631;
	Tue, 11 Mar 2025 11:02:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4591qkkqct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 11:02:53 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52BB2nWY50266594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 11:02:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CABD520040;
	Tue, 11 Mar 2025 11:02:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B658C20043;
	Tue, 11 Mar 2025 11:02:48 +0000 (GMT)
Received: from localhost (unknown [9.171.9.82])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 11 Mar 2025 11:02:48 +0000 (GMT)
Date: Tue, 11 Mar 2025 12:02:47 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Joel Granados <joel.granados@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Kees Cook <kees@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 6/6] s390: mv s390 sysctls into their own file under
 arch/s390 dir
Message-ID: <your-ad-here.call-01741690967-ext-1293@work.hours>
References: <20250306-jag-mv_ctltables-v2-0-71b243c8d3f8@kernel.org>
 <20250306-jag-mv_ctltables-v2-6-71b243c8d3f8@kernel.org>
 <20250307152620.9880F75-hca@linux.ibm.com>
 <r73ph4ht5ejeeuj65nxocmqp7pury2mekz2lz3r6fs264s24c4@ransymcrzk2h>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <r73ph4ht5ejeeuj65nxocmqp7pury2mekz2lz3r6fs264s24c4@ransymcrzk2h>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h9Mg2owPiLRPVj7MJrH8lEXpq9BsvLC-
X-Proofpoint-ORIG-GUID: h9Mg2owPiLRPVj7MJrH8lEXpq9BsvLC-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 spamscore=0 adultscore=0 mlxlogscore=856 phishscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110072

On Mon, Mar 10, 2025 at 02:41:59PM +0100, Joel Granados wrote:
> On Fri, Mar 07, 2025 at 04:26:20PM +0100, Heiko Carstens wrote:
> > On Thu, Mar 06, 2025 at 12:29:46PM +0100, joel granados wrote:
> > > Move s390 sysctls (spin_retry and userprocess_debug) into their own
> > > files under arch/s390. We create two new sysctl tables
> > > (2390_{fault,spin}_sysctl_table) which will be initialized with
> > > arch_initcall placing them after their original place in proc_root_init.
> > > 
> > > This is part of a greater effort to move ctl tables into their
> > > respective subsystems which will reduce the merge conflicts in
> > > kernel/sysctl.c.
> > > 
> > > Signed-off-by: joel granados <joel.granados@kernel.org>
> > > ---
> > >  arch/s390/lib/spinlock.c | 18 ++++++++++++++++++
> > >  arch/s390/mm/fault.c     | 17 +++++++++++++++++
> > >  kernel/sysctl.c          | 18 ------------------
> > >  3 files changed, 35 insertions(+), 18 deletions(-)
> > 
> > Acked-by: Heiko Carstens <hca@linux.ibm.com>
> > 
> > How should this go upstream? Will you take care of this, or should
> > this go via the s390 tree?
> 
> thx for the review
> 
> It would be great if you can push it through the s390 tree. However, if
> it is not possible to do so, please let me know and I'll add it to the
> sysctl-next changes.

I've slightly changed the commit message
s390: Move s390 sysctls into their own file under arch/s390

And applied, thank you!

