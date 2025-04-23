Return-Path: <linux-fsdevel+bounces-47044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEE3A97F82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 08:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD5C189B660
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 06:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3163267393;
	Wed, 23 Apr 2025 06:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rJWD1RGx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2D81B0F17;
	Wed, 23 Apr 2025 06:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745390734; cv=none; b=pnE2zzFLflehPGbQZ27o4shU8H89zPXZiFZjNXxXA+dVaMNFKlobg8CuyAdM0RuIAqgc+WrAnvS6cfGgvfhWEgSTm4GTe4E32mH7J9S9fBGVINOnR6H4HpWDn9H3YQwmAJ8BUlT2T4AeDrP2pRWPEWD5HJyUo2ZBCFM/Y8koKpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745390734; c=relaxed/simple;
	bh=eAZQohfiqTNuhy/qRZvsfQDG7jIiwf3DkhHIBHMlOMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgtaU4BtsIjEIfL6mV7ouHTNeKSZtaz7PRgpxdiTxrHG+CuTmw1Mc5JO21nh3YiqqfFVfxkvsGTFB4Gu1QV3WxEnjY0wlgXEBAtiZnrAnhIxU11tAvio1Y1AVLKNZZkmUcYYsz5gXdFQr1v96/eNGD64DKEZjyJz1ybHH/Q/y5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rJWD1RGx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6fkI6011228;
	Wed, 23 Apr 2025 06:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=HrLUjjBTROjldbtZdwwxXWZ8X9N0FO
	yBH2g5cq+SOnw=; b=rJWD1RGxkR/Njk1KZtnJFUBI8ksIN2gzvFSTs0G53V8tC2
	2PYQkHMMCOoVM2IyIJ69ItKxssfmf3eXOvxrLiPqzWPy/thmLNNsfAlJct+xPsgv
	+OmMIb779ybfbaITgzx90xt6WVmI/rAStiZnmROS39n1TDC1vib2t/weNBBwxUnt
	7QR5xqVjz8xa1hcaNXH07fiTU6/KDd6vGMMM55x+hg6R53Pkkrat5JFbCdhmW9HI
	h3Vn66vvcYtgkUhfCog43Lnwg3AmZP1KJbIC5n363HWcPU8b2YExs5e1qjjCugPV
	frqPvfZTmJNQHmQtg1rZBCL55OA1ThT6yUvcUMCw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466jpe1wv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 06:45:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6QJEf005884;
	Wed, 23 Apr 2025 06:45:21 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfx9st4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 06:45:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53N6jJEZ52560210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 06:45:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A232220043;
	Wed, 23 Apr 2025 06:45:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EABC20040;
	Wed, 23 Apr 2025 06:45:19 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 23 Apr 2025 06:45:19 +0000 (GMT)
Date: Wed, 23 Apr 2025 08:45:17 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
        brauner@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        Xiao Ni <xni@redhat.com>
Subject: Re: [PATCH] devtmpfs: don't use vfs_getattr_nosec to query i_mode
Message-ID: <20250423064517.8056Aa2-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: NvDXFq_rB7Cz4R7e4tulo_55oTKQWLw3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA0MyBTYWx0ZWRfXx74tVdqayq8f dGD/J1er7+3LXgD4pM5NqYWxFs/gDs73jslGZ8y1XodDF6ZS0cUNFW4XpJi4woRY8VjndN0Z1JZ lpG9axfLyRbd1qqWG8wTZoJJ4p1042i+uPXOEO+XdfhpZo3MuIpS/szBD53cxb/JFKncL8xQLRk
 HtgSaBGAOVrHuAOVfOrXMeuhLnb40kJ0qOlsL7QI8jKJkMcvnAw+kJGrhhStdEMktEqPLf4fl4l I0XdF7wN9dRzOd8Ncky27jkKj3tPIvoIDBBacNIPpa8pwFnASyewommYKJrNHlyRBCAoAPxCc8+ c2B8e356Ki1RPydhQVZ+zHOqogMi2QxmAKA/Ltvr8TdaQq1hkp3YwrZ8UaW6648WraCjxJ6ZRZZ
 Xz+pq9kct10jkBK5WmZvzp6DN30YF+CsEQ/JCI5ZWTND67BISf4tuMjfL2RENcn6MJWpGBD8
X-Proofpoint-GUID: NvDXFq_rB7Cz4R7e4tulo_55oTKQWLw3
X-Authority-Analysis: v=2.4 cv=IdWHWXqa c=1 sm=1 tr=0 ts=68088c82 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=JF9118EUAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=IDZ0-sv6maarBuPMgTYA:9
 a=CjuIK1q_8ugA:10 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_05,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=10 mlxscore=10
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=10 priorityscore=1501 suspectscore=0 adultscore=0 mlxlogscore=94
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230043

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

Tested-by: Heiko Carstens <hca@linux.ibm.com>

