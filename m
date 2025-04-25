Return-Path: <linux-fsdevel+bounces-47336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69179A9C497
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 12:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6D79A7CA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 10:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644F723315E;
	Fri, 25 Apr 2025 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HADueul/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4611EA7CA;
	Fri, 25 Apr 2025 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745575404; cv=none; b=X3sPW0itr2hjnA/VZ4rxVe8W09CEyZuT7gG7GEZX9QEwTB8ovOWoTFketXxobtNqzHqcKAsYR/kp8Ohr+incngKltMsHRIJX2eeEF1o6qmAdq2sU0BxhPaeQbEHRofzVEFhhp4gg3MAZClSvsb7fyNNuNiiytoq5wgPwVgFCJCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745575404; c=relaxed/simple;
	bh=4kFE348Wzuz0aONETluNIRmXtHsilTTLgNF8cOgIVxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHNesZocvSijnaYf2aDaiaHVG0v1EpYARRnEXrS2KUNqv/kyS+C2PxGq+yc8YwnxYQJL8Bku8d2vJgyI3h9V/n1PLFAquH/l0v9pLLuauSzYsUHgP72aaDGZIyR4mHAupO/CEFZyZupy3RBvdoUxfkFabH+ohr9TgOuEjTSp244=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HADueul/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P9imrs004048;
	Fri, 25 Apr 2025 10:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=GwmIhPe1gG9Lbospo0jC1b8F8kiRME
	sFrN5jK5e0vWA=; b=HADueul/TKOMnCpOV7h8aKR5hFvBqfWl26qT+vZ0u5GVdZ
	pi0KrAxFLA4qshx6vKacTQXfwmfhSlTSHgu3Ox2MHdwA/fwl8pjZWckP+fH4GQ8a
	znhjBHorZHOHGXkry6LAwQSAyWA+3zWt+tx7481P6lYdf86wtsyeqNSGdkIUo8Ha
	Ue6nMnO4qv6AeRSsGyZjZbjcB+s+zX9ra202kYOBE/JzFh5FA+OqPY+CY8tKu7jL
	+036bCmYynAxZI2ypxAeV9A8WQY5/p3sgSF+zla2WN2lweMk8m9VJnXJ7hty/Cz7
	5A9NboBlcZ5RI2zCsH7qYa1CDXY/JetBncBjs0BA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467wew2j4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 10:03:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53P8MiFl005893;
	Fri, 25 Apr 2025 10:03:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxmp6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 10:03:08 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53PA36jj26870264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:03:06 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A3A020067;
	Fri, 25 Apr 2025 10:03:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAE4C20063;
	Fri, 25 Apr 2025 10:03:05 +0000 (GMT)
Received: from osiris (unknown [9.111.13.86])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 25 Apr 2025 10:03:05 +0000 (GMT)
Date: Fri, 25 Apr 2025 12:03:04 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
        brauner@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        Xiao Ni <xni@redhat.com>
Subject: Re: [PATCH] devtmpfs: don't use vfs_getattr_nosec to query i_mode
Message-ID: <20250425100304.7180Ea5-hca@linux.ibm.com>
References: <20250423045941.1667425-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423045941.1667425-1-hch@lst.de>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA2OSBTYWx0ZWRfXznCDRKWD1ksR FQ2FfJk2erLg/tEJIcbu9Jae/aLRETx9uLaQpd68C8SlAsJ9rN1a/E/lmzejOZXfLlwnm+cvXrU 4BLmvCZW6JplVWc8bwtyOpS6nE9Xl2d8GKUNm3Kdlz/bI7SnwCdBS1dNRCvf6A1OKhBL6whZT86
 QBdr9whZEFv7h4n/l3/dGtEdiLQ25Hxulqgo9UZOy+4ezgXDEIRGqZLmeaWcUQseczxXU4fWSsm hnwNoROCTl3KeJM2uEF+o9zs/Ioia/1pRrXJL/btq4giU7loKdBRq7as9Z3T9DOmFiOlQhe4IIO MCDWkjvBRscutyJZ1BW7M/BcJABQ/Ikxrhhgt/oSjPyot/z+gE9UTXsfbOiKxeFQQxo4ykkJyb2
 u6H317eGQJrvhS0pLNWqigJjpz12ex/go78I/zppdI2jfYvtT9bevrdUV8P+tUQ786Fhv8i2
X-Proofpoint-ORIG-GUID: K0p3muNkcqYvb7N11TP3OgVo7-4vBF9m
X-Authority-Analysis: v=2.4 cv=JLU7s9Kb c=1 sm=1 tr=0 ts=680b5ddc cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=JF9118EUAAAA:8 a=20KFwNOVAAAA:8 a=UC29wqCd6ki5ZiVo4UAA:9 a=CjuIK1q_8ugA:10
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: K0p3muNkcqYvb7N11TP3OgVo7-4vBF9m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=283 suspectscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250069

On Wed, Apr 23, 2025 at 06:59:41AM +0200, Christoph Hellwig wrote:
> The recent move of the bdev_statx call to the low-level vfs_getattr_nosec
> helper caused it being used by devtmpfs, which leads to deadlocks in
> md teardown due to the block device lookup and put interfering with the
> unusual lifetime rules in md.
> 
> But as handle_remove only works on inodes created and owned by devtmpfs
> itself there is no need to use vfs_getattr_nosec vs simply reading the
> mode from the inode directly.  Switch to that to avoid the bdev lookup
> or any other unintentional side effect.
> 
> Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Reported-by: Xiao Ni <xni@redhat.com>
> Fixes: 777d0961ff95 ("fs: move the bdex_statx call to vfs_getattr_nosec")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Tested-by: Xiao Ni <xni@redhat.com>
> ---
>  drivers/base/devtmpfs.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)

...

> @@ -330,11 +329,8 @@ static int handle_remove(const char *nodename, struct device *dev)
>  	if (IS_ERR(dentry))
>  		return PTR_ERR(dentry);
>  
> -	p.mnt = parent.mnt;
> -	p.dentry = dentry;
> -	err = vfs_getattr(&p, &stat, STATX_TYPE | STATX_MODE,
> -			  AT_STATX_SYNC_AS_STAT);
> -	if (!err && dev_mynode(dev, d_inode(dentry), &stat)) {
> +	inode = d_inode(dentry);
> +	if (dev_mynode(dev, inode)) {

clang rightfully complains:

    CC      drivers/base/devtmpfs.o
      drivers/base/devtmpfs.c:333:6: warning: variable 'err' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
        333 |         if (dev_mynode(dev, inode)) {
            |             ^~~~~~~~~~~~~~~~~~~~~~
      drivers/base/devtmpfs.c:358:9: note: uninitialized use occurs here
        358 |         return err;
            |                ^~~
      drivers/base/devtmpfs.c:333:2: note: remove the 'if' if its condition is always true
        333 |         if (dev_mynode(dev, inode)) {
            |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
      drivers/base/devtmpfs.c:326:9: note: initialize the variable 'err' to silence this warning
        326 |         int err;
            |                ^
            |                 = 0

That is: if dev_mynode(dev, inode) is not true some random value will be returned.

