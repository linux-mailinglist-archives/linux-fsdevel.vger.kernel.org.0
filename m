Return-Path: <linux-fsdevel+bounces-46955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05628A96E2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 16:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE7CC188C102
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3062284B51;
	Tue, 22 Apr 2025 14:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NjfaHC82"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83732147F9;
	Tue, 22 Apr 2025 14:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745331494; cv=none; b=kNYNjEV326dRwtCHOJRDpuG2l4jxzx2+SH2Lum8aVvF9BFulf6bnqPvokgIGYrDnC9R6LUPyAqhItEdHmPo+YJISuB6lRFb7SVsvLkuJsJqQLs7olUB9ZypbdPA9trT2RjWINc7TwzAbrhKNmSvGDYbO/RmDIs2qB2QLkQfR7hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745331494; c=relaxed/simple;
	bh=gzHXyyvPdqokUSWEtJaxbHF/Iqlrfyd6Ei4drrmlu4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3CoPKHyUUfzsJkuZCeAhHChI7CfhT61Vzj1pDi3aPhWto8ADZOaI1yws4M2RRYhAPLkzlUgfETUyKZoD5UlsDXW/yMHMrwwSbfR+iNT4Fii5rbWFhd/4FJAqKmGKRsjVyys90N25n3pZe+GwVw8V6VGT3hIe421dSYeRYuAqiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NjfaHC82; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MAbWRa020829;
	Tue, 22 Apr 2025 14:18:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=BTEoSrOv+Dgz6HNRfznfZ5u9n3jpL/
	TFFdeLmZLnQ/I=; b=NjfaHC82CjOJjhl4b7mKbnUc4xFd9b9d+JKwzGBzqGKGCp
	Fo5Dg+PV40YNfs3gUo5GM4vh2+5XlwKhHSSn/AXQC3af0MtK8EmUyynCVDBotQwi
	Te5Dh3Ppx1pKLXGwV7GPwQcjA3/0LM0pEA84NGUruxZYRbywWJB7wSAhF0ySiI82
	iEKSk8m+1hUZeBwQJQcfDsrOfpQ6MOuHlMSzIMIANLv3M48md6xUjbj0vls6UoZM
	mKQG/okOLvQcSC+kI5CKPb3iV5bMaTF0maoY3fvX+REoVj4IKUggK2jJ5sv06Ygo
	uoMIJ3S8HdjpgMcAxsosIPIj0I8+7YO3LKvt5UnA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4669h1h2y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 14:18:05 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53MDusdw020425;
	Tue, 22 Apr 2025 14:18:05 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4669h1h2y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 14:18:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53MAJ1Ow032544;
	Tue, 22 Apr 2025 14:18:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 464phykbnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 14:18:03 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53MEI2q257016620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 14:18:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9EDF2004B;
	Tue, 22 Apr 2025 14:18:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86D9920043;
	Tue, 22 Apr 2025 14:18:01 +0000 (GMT)
Received: from osiris (unknown [9.87.146.239])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 22 Apr 2025 14:18:01 +0000 (GMT)
Date: Tue, 22 Apr 2025 16:18:00 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: hch <hch@lst.de>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] fs: move the bdex_statx call to vfs_getattr_nosec
Message-ID: <20250422141800.40615A23-hca@linux.ibm.com>
References: <20250417064042.712140-1-hch@lst.de>
 <xrvvwm7irr6dldsbfka3c4qjzyc4zizf3duqaroubd2msrbjf5@aiexg44ofiq3>
 <20250422055149.GB29356@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422055149.GB29356@lst.de>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XvP6OUF9 c=1 sm=1 tr=0 ts=6807a51d cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=lvXfNf97AKID-M7_zB8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: aRWJbqBrJB_sokzVdD5EBI-UFkJfW5A9
X-Proofpoint-ORIG-GUID: B5dYCGBhRGQwF8cLu-gb1eNcl1lnURSa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_07,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 suspectscore=0 spamscore=0
 malwarescore=0 impostorscore=0 adultscore=0 mlxlogscore=654 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220106

On Tue, Apr 22, 2025 at 07:51:49AM +0200, hch wrote:
> On Tue, Apr 22, 2025 at 05:03:19AM +0000, Shinichiro Kawasaki wrote:
> > I ran blktests with the kernel v6.15-rc3, and found the test case md/001 hangs.
> > The hang is recreated in stable manner. I bisected and found this patch as the
> > commit 777d0961ff95 is the trigger. When I revert the commit from v6.15-rc3
> > kernel, the hang disappeared.
> > 
> > Actions for fix will be appreciated.
> > 
> > FYI, the kernel INFO messages recorded functions relevant to the trigger commit,
> > such as bdev_statx or vfs_getattr_nosec [1].
> 
> This should fix it:

FWIW, I was also about to report the same problem. Any reboot with dm
targets hangs. Your patch fixes it also for me.

Tested-by: Heiko Carstens <hca@linux.ibm.com>

