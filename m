Return-Path: <linux-fsdevel+bounces-10879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 796C284F0A9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 08:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5F01C21B2D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 07:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5830A657C5;
	Fri,  9 Feb 2024 07:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FPJtZ90m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135B5657B6;
	Fri,  9 Feb 2024 07:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707462921; cv=none; b=mutJmeIhn6JiaJUDc1HYH10fuJtsH/8muVpZjPTx4zGFvAE18fCfZeOzfg7vmmRYdKkOACH+AS6Akob4iAUeHCASAPVcouQ27hiRp2V1pqr45nQZak9yOKB8IsPpfW+7rva0Y86LE2rxMz5CgPfrqDhJA8/ot2U9/b33tWOdCH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707462921; c=relaxed/simple;
	bh=SsACAYr0WLs84wyRPCGBPmrdamG2JsarkOqlVOkUGPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zgp+D/4v6/rGOJP9Rd2N3A7xnOpeGNdKVk2Pp2eoT9iCOr4q0oHnIiMtWXt6FlWW8ncirA2qM2o78zRC8cPiXqrRQTn5/h9ZzHPDfE6cHTMHV650tZdyO5Sk5ssEjPKaf+x4snrVfKqc1a1qLZDhYfoKYj3aHdp797Qul+rPDtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FPJtZ90m; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41972Lf1014051;
	Fri, 9 Feb 2024 07:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=6uEUkSqsBPdEejGxM3M5CA/XkPf07LNpr+fq0kqwRvQ=;
 b=FPJtZ90mLXop9YsX2qdwEvrGfveCuQnhyshF2ZvDnlbl6CD2/1hNdG0mMoM6k1YnXrN0
 dTIQoEnljd1ZB4azzVgBwOXHZ+M5KtZmqwf7og4SiR5/VunuEYsIi2Jcz0YYYrKDf9CL
 NqoPgv/O7NPyJ0iQTgW6/YyeGieg23ewN2BgPeSW0nKc9zWQ7iUwWaLQ2ncWhX/LOrz0
 PL4OL4XOKLFq8s/lb2zP+QLm1e6EeL1NBv4DRFkPllPmoIx2UV0WqTctaoOzcyWszxta
 BvcA8iUTQ6HiKGSNOg5eRrqT6Qc/h12SgUcgKXZumYDCAQS8eC5Dodg32P/a3N5KGUCA hw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w5fabga8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 07:15:08 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 419746BD020459;
	Fri, 9 Feb 2024 07:15:08 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w5fabga8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 07:15:08 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4196LUrO008818;
	Fri, 9 Feb 2024 07:15:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w20701u4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 07:15:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4197F4dh18023094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Feb 2024 07:15:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9F2920043;
	Fri,  9 Feb 2024 07:15:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A4C020040;
	Fri,  9 Feb 2024 07:15:02 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.98.150])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  9 Feb 2024 07:15:01 +0000 (GMT)
Date: Fri, 9 Feb 2024 12:44:59 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com
Subject: Re: [PATCH 0/6] block atomic writes for XFS
Message-ID: <ZcXQ879zXGFOfDaL@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240124142645.9334-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124142645.9334-1-john.g.garry@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9Z0CLsJy3gXKMWD_95NZWXTjFBXM7XXW
X-Proofpoint-GUID: f6P1CVQwjDT3E8wBLngat6hatCdQFL3G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_04,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 mlxscore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 mlxlogscore=929 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402090050

On Wed, Jan 24, 2024 at 02:26:39PM +0000, John Garry wrote:
> This series expands atomic write support to filesystems, specifically
> XFS. Since XFS rtvol supports extent alignment already, support will
> initially be added there. When XFS forcealign feature is merged, then we
> can similarly support atomic writes for a non-rtvol filesystem.

Hi John,

Along with rtvol check, we can also have a simple check to see if the 
FS blocksize itself is big enough to satisfy the atomic requirements.
For eg on machines with 64K page, we can have say 16k or 64k block sizes
which should be able to provide required allocation behavior for atomic
writes. In such cases we don't need rtvol.

Regards,
ojaswin

