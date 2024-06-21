Return-Path: <linux-fsdevel+bounces-22117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B2291276F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 16:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38ABC1F21991
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 14:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA6520DC8;
	Fri, 21 Jun 2024 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L/kGsDc0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819CC208A4;
	Fri, 21 Jun 2024 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718979540; cv=none; b=fzt9DOGiQHBQqAGJ5SBQJrxEvUai2VgAdQ49wFgi/vO5DmGS7DfYRSfk66O8+4iyum1A6/tf348M6Y8xJAKfeN28FKYiZP1ybS16sTvKwA+E5MAc/HcdMS3UZ3A2Dak/GIEh8gk0rYtp0QRGnrdYywNeb1zUlGFvQ8xHdac92PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718979540; c=relaxed/simple;
	bh=1c8Qc1Y5GCm2rehTE2RjE51jiJjppd4c+lxxUpnpk1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQ2C7vLD70uWs0ZRjEHfL1syynIOAlzOHqzSsrBxsh6hUL6igeUY10JGJawHqpCVjliYm5CaJIvnUwm9hOFTKd3awsWXVfB1dLctgIvHfeh2kPGTpPqNQpwD9wK+nW0pFmDWeX9eRKV42FqAdA9AYDtepqz6g0mpvsRvSVM3faQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L/kGsDc0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LDmh2Q002183;
	Fri, 21 Jun 2024 14:17:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=LF1s2xvSDPljT0oEHiEGquZZeto
	2SHuFoShwJ3ChVqM=; b=L/kGsDc0HEiswhQufYopyCdldOClTJuhdzH8JmGDxfz
	Lk6zfv7ZyAlKnlmxJRrrh4aH4Vo6AZ29JHrHYdzne6RrZ4VcWKqV2+MkkG5QRfhy
	0qSKEGCUNJuiNPU3fsTgezxRrE19zpuQPZuyJojvXd57h4Yj8KrPObmRu8KNTLke
	EUFZoNvo/uubNeebvEIH/6KQFdffHWduJsAL68+/zmvfOSbM3fvgFWlSvxrd10Us
	O0u6hG6qdpucSGkxfJgvRJWn+W4PbMfk8oRJ2Q7wUTAY+t7wJCsvfANxwea+5aMZ
	H9e98wxZ3Yopq6+ZaYKDwc/LvuNqTd9Eoqe7SGyTp4A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ywa0mr7fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 14:17:46 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45LEHjOc030057;
	Fri, 21 Jun 2024 14:17:45 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ywa0mr7fn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 14:17:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45LBuPa6031319;
	Fri, 21 Jun 2024 14:17:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yvrrq7k29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 14:17:44 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45LEHe7240436050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 14:17:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38C4E2004D;
	Fri, 21 Jun 2024 14:17:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1861F20040;
	Fri, 21 Jun 2024 14:17:39 +0000 (GMT)
Received: from osiris (unknown [9.171.32.192])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 21 Jun 2024 14:17:39 +0000 (GMT)
Date: Fri, 21 Jun 2024 16:17:37 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Helge Deller <deller@gmx.de>,
        linux-parisc@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Brian Cain <bcain@quicinc.com>,
        linux-hexagon@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org, linux-s390@vger.kernel.org,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
        libc-alpha@sourceware.org, musl@lists.openwall.com, ltp@lists.linux.it
Subject: Re: [PATCH 12/15] s390: remove native mmap2() syscall
Message-ID: <20240621141737.14882-B-hca@linux.ibm.com>
References: <20240620162316.3674955-1-arnd@kernel.org>
 <20240620162316.3674955-13-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620162316.3674955-13-arnd@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fSdaLowT_gOM0sMbXX9GJzu_e6RTRa0y
X-Proofpoint-ORIG-GUID: fxa5htH3kxDrqY5Kq65cIpVvdeHEdHtv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_06,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 mlxlogscore=341 priorityscore=1501 impostorscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210101

On Thu, Jun 20, 2024 at 06:23:13PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The mmap2() syscall has never been used on 64-bit s390x and should
> have been removed as part of 5a79859ae0f3 ("s390: remove 31 bit
> support").
> 
> Remove it now.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/kernel/syscall.c | 27 ---------------------------
>  1 file changed, 27 deletions(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com>

