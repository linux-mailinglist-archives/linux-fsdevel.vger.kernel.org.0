Return-Path: <linux-fsdevel+bounces-12557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B579860F10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 11:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B7C41F25AFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 10:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383915D463;
	Fri, 23 Feb 2024 10:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TM9X/uSg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609965CDDD
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 10:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708683528; cv=none; b=SHlVBaNW1f9CWEvKUB3xeRF0xU7+AQv3LoXIjg05d4KKQypJPGRbBqBzZpaCczbBR2PgEm09rTk0OyYJ+MlDwbNdF6YiMU9nJBkEoyk15bmZbenk+9ofL6kQHbQ377yy7N/o9Nn9TIWRpxhSU2DikFP970BZJf/E7PWg/ZZdEzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708683528; c=relaxed/simple;
	bh=0GdUJI1qUFBTGlkGG9IryBDBIKuMqPyr11FLeRpUazA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkwvTBOWXIy0PsYRPaK0rmxCPhohb/oS8j273hICFvqz9BW3vV2v67KWj1HD5vqBP194xOWhZi0Ez51PycpcjWlcmCmv/iyeOPOg8B4cGmrmyv1+Rl5pgyYJdVqTgVAD6QeO1HXLr8wQfiAcBKCDWhMgAeL96U8ksCqly7PDlNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TM9X/uSg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41N9WN1r019795;
	Fri, 23 Feb 2024 10:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=FCzPuDyxweq1sYgpZ6R1/j0JLIZcyJoRU/YwYIm9dfo=;
 b=TM9X/uSg8mOh4VwffvknrRPQP1wuBdsVIBAkcidm9IVAn4cjk0UPdCsGQtcPnPbmZNS4
 iuB1yLBCnaUWhLgFxu6Kft2RW5swiw9wBP9Y+KDEXHN2gt5oogJoPa2whyMkE0QBjVvD
 jX9YJ+scuLE2GipN1Ui5jxblypj7FdEQJDqVrrRE0/0a0FNdShgEoirAZxbKw95eG9Mb
 wZ85HCQ22IzdVRgmHkl2YM2HkgnY+u/SFGM0Fv84DGcV9NCKCkmVbJWP7rT38AdAYQZS
 vkH64Zk4lAzdvX2LytJDXSQGLJ6lDT1bEzkXwXyZ8QVX0Wjfd8TBEow34ha8Zb889r5M 1g== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3werth14y0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 10:18:40 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41N7dHoW003620;
	Fri, 23 Feb 2024 10:18:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74u4x89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 10:18:39 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NAIZhF26608252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 10:18:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 723B320076;
	Fri, 23 Feb 2024 10:18:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFE5B20073;
	Fri, 23 Feb 2024 10:18:34 +0000 (GMT)
Received: from osiris (unknown [9.171.74.183])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 23 Feb 2024 10:18:34 +0000 (GMT)
Date: Fri, 23 Feb 2024 11:18:33 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240223101833.16153-A-hca@linux.ibm.com>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
 <20240222190334.GA412503@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222190334.GA412503@dev-arch.thelio-3990X>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q4r2ODhCJ-a44CMfAVBQeGwT1AS_-oxI
X-Proofpoint-GUID: Q4r2ODhCJ-a44CMfAVBQeGwT1AS_-oxI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 mlxlogscore=482
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230072

On Thu, Feb 22, 2024 at 12:03:34PM -0700, Nathan Chancellor wrote:
> Apologies if this has already been reported or fixed but I did not see
> anything on the mailing list.
> 
> On next-20240221 and next-20240222, with CONFIG_FS_PID=y, some of my
> services such as abrtd, dbus, and polkit fail to start on my Fedora
> machines, which causes further isssues like failing to start network
> interfaces with NetworkManager. I can easily reproduce this in a Fedora
> 39 QEMU virtual machine, which has:

Same here with Fedora 39 on s390 and next-20240223: network does not
come up.

Disabling CONFIG_FS_PID "fixes" the problem.

