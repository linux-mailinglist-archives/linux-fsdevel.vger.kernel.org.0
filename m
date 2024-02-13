Return-Path: <linux-fsdevel+bounces-11354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210DA852EFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 12:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57A8DB22B60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 11:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB24B37168;
	Tue, 13 Feb 2024 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZZEg/ZnC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB14E33CFC;
	Tue, 13 Feb 2024 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707823163; cv=none; b=P5HWe+HAZtaEzB7MP5UduBL12fCj7ovmG/7oe/LO5aM6kIpRXSAvQZf5zUsX2vcs5CuC7AbU2cdmPLF3apVjINWHyGKpq/52GBF4fyG/VArFJAS7RJU0qYjfoeDh9oSAgK12DPW7POAKEHjRSASSnJ4CD6rlL+C7U1oKJt0SyYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707823163; c=relaxed/simple;
	bh=U7WN3EXjdjDY+WOk1krQTvyOnm0+62Jv90SPNEBQJN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqNbBaSbLvDe9ahW9FsMtV4RD4+epPL3xLvkbY87LLLoL0RBwjU9jVUpBTMDJlUlQqcz18h6ZGKcDE4zwt1ThCuPQARR9eKjT0VsSynJoK0LxlKTIHukEqhOHkTWILNFd9zQwnPDw8zs0D3IScGtCLPjVkbzptM6H5QObPEE7Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZZEg/ZnC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DAI2V3018656;
	Tue, 13 Feb 2024 11:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=kRixhbN6Ym1Zmusnenh11GI105dw0bqQnIm1JeLCSK8=;
 b=ZZEg/ZnCZtXf+0rAXEh14DIZ8Sye5Nhv5T7O/GHGqhe/UlUBxyyIjoPTy+kciAagGdPa
 GN5A8rXGjLKKzQq5azUSEepMOhG1uAfv2MPHyLvkEPgkJVSEpKyMUoV+o6akZPot8bgZ
 rQxFMy5cJURaY3EA+zCymd6cySK6yRVWgj83u6aX9PqjCXSbHQSP+a3F9lVtAQU03W7Z
 cNVAbaZ5MibgX3c9/TPRO+DvscRxn4PXsP2cu6rx6BmYvr6JcXO2Kf3VfGBOeM6ixewH
 ViLcLfXfoS/DiZeOOHY7DyW3aHWKQk7MwYu4CJoSHcMD61K/mv1ztVb85syzviIuF7VA cw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w86hts9w4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 11:18:56 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41DB1fNm022081;
	Tue, 13 Feb 2024 11:18:55 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w86hts9vm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 11:18:55 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41D8P7Jh016479;
	Tue, 13 Feb 2024 11:18:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mymeuwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 11:18:54 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41DBIpXF45809942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 11:18:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A7F120040;
	Tue, 13 Feb 2024 11:18:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9C362004D;
	Tue, 13 Feb 2024 11:18:50 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 13 Feb 2024 11:18:50 +0000 (GMT)
Date: Tue, 13 Feb 2024 12:18:49 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Russell King <linux@armlinux.org.uk>, linux-arch@vger.kernel.org,
        linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        dm-devel@lists.linux.dev, nvdimm@lists.linux.dev,
        linux-s390@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH v5 4/8] dcssblk: Handle alloc_dax() -EOPNOTSUPP failure
Message-ID: <20240213111849.6534-A-hca@linux.ibm.com>
References: <20240212163101.19614-1-mathieu.desnoyers@efficios.com>
 <20240212163101.19614-5-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212163101.19614-5-mathieu.desnoyers@efficios.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: v7etkd58sOZye-tw7r45w1hzzfW55uLg
X-Proofpoint-GUID: ex2g2pAdh4h8FGNj8JP3P_9xuvlIPkmS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_06,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=800 malwarescore=0
 priorityscore=1501 spamscore=0 clxscore=1011 bulkscore=0 impostorscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402130089

On Mon, Feb 12, 2024 at 11:30:57AM -0500, Mathieu Desnoyers wrote:
> In preparation for checking whether the architecture has data cache
> aliasing within alloc_dax(), modify the error handling of dcssblk
> dcssblk_add_store() to handle alloc_dax() -EOPNOTSUPP failures.
> 
> Considering that s390 is not a data cache aliasing architecture,
> and considering that DCSSBLK selects DAX, a return value of -EOPNOTSUPP
> from alloc_dax() should make dcssblk_add_store() fail.
> 
> Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
...
> ---
>  drivers/s390/block/dcssblk.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com>

