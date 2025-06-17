Return-Path: <linux-fsdevel+bounces-51962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33950ADDB98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 20:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5717F1763EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 18:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAF82EF9DC;
	Tue, 17 Jun 2025 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U09UY9+/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BFE2EF9C9;
	Tue, 17 Jun 2025 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750185774; cv=none; b=AbgUiAalRKnloAydCmVf8KreNJp2xtiv8zpM21aEQoLQu5quuQSdUeMBqtqFCYswASE3Mc//nFGl4e5z53BOzbtI/KpSfaa5AE8zfPkU0NegYzYDbdnUc2Jn2Zzrt8LpVElLOcqa4IUKBFwt9gqTQi8MAeWs2FMgyrFRK/U2ohs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750185774; c=relaxed/simple;
	bh=wRnq27DvdJJmr4o3QCr75jN7cw97aGi+WsicAN3qmro=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=b1tu7pCkPUs86V8439TUvrKU+yz6jVkl9pGv6lckYuHIsyuc7/WZBH5gCbzx3+jg4XcZc3SPwagPd5t+lxCik588nwk2CsClP73ftMBCq4ohBsVHrTbCPyvpCSxn3y/h3+qy1KeaO+L0+fj1PwRJfR2W6eP7W+DeY0IZSABTr5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U09UY9+/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HEIabb022181;
	Tue, 17 Jun 2025 18:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wRnq27
	DvdJJmr4o3QCr75jN7cw97aGi+WsicAN3qmro=; b=U09UY9+/VucYM6as2ZVgzQ
	VW4x+mW2gCjrqoWGZsccjRhbEhsM6/oymGQE5XzP62/X1x9Hyuo7sADkA4OsOM3H
	qXwOutOAWFem1pMahvRqUFVTPaWyMr9/jPQR+9Tm/AqEbOnhHN1HPauG7UNFrlJu
	D+yfgU7XikzCWbA2y4Y3ZFxoEBpWwoot8USQlBLs/DmpqAExqbyPTF4xjBGv3D6F
	l/x2bvO05TeNlWEosMsuVPSotpNwaJo94IyxOSlrtlIvuKVIu3Pf+XNnhgTz9q8+
	1LtJGXqQ6XLuFHTb7zwX38zrkHGmNaSkW6g2VIMMOIkMjjGYJiL6+wf+OYfA7P1Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790ktjdc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 18:42:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55HIee9k011233;
	Tue, 17 Jun 2025 18:42:51 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 479kdtd7t7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 18:42:50 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55HIgoJw26215086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 18:42:50 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDAAA58055;
	Tue, 17 Jun 2025 18:42:49 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C67258043;
	Tue, 17 Jun 2025 18:42:49 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Jun 2025 18:42:49 +0000 (GMT)
Message-ID: <b728d51489ee054ae6ea3d5cd8815504e4710845.camel@linux.ibm.com>
Subject: Re: [PATCH 07/10] ima_fs: get rid of lookup-by-dentry stuff
From: Mimi Zohar <zohar@linux.ibm.com>
To: Al Viro <viro@zeniv.linux.org.uk>, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
In-Reply-To: <20250612031154.2308915-7-viro@zeniv.linux.org.uk>
References: <20250612030951.GC1647736@ZenIV>
	 <20250612031154.2308915-1-viro@zeniv.linux.org.uk>
	 <20250612031154.2308915-7-viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jun 2025 14:42:49 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H0PNpZer1VRFDxsB29C856eSW1YMYN8K
X-Proofpoint-ORIG-GUID: H0PNpZer1VRFDxsB29C856eSW1YMYN8K
X-Authority-Analysis: v=2.4 cv=KaDSsRYD c=1 sm=1 tr=0 ts=6851b72b cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=drOt6m5kAAAA:8 a=VnNF1IyMAAAA:8 a=dk-Tlu5L4lk2KUxRMh0A:9 a=QEXdDO2ut3YA:10
 a=M91JV_wKSCcA:10 a=RMMjzBEyIzXRtoq5n5K6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE0NiBTYWx0ZWRfX1LqRbnLJoOg9 t6IAF+/tfwvZsPVQ1tDOcqffYPQ7BzzX0S19bkxYq5PgBvCG9eQo76oztXOWyUbwRTUOdtD/Y4Q mg5sWTywGgZOGS2u3WQf5i29vYoKHWYRydhnxggWm6tIVjYsY+gHnV0m1aePX2sD/mCASfWrYLr
 NUE8jS38bywEv3yUcVHRt9RP8qu2pvOpL3bFKrTbOd1OBJId0sL2Tb+gN3Q9qp/GCLZesK8XWYQ GxW1MCxW6EhpjPn+hD6ZNJxAuXKYqzQa5RchVJSWVD81fo9LRqHh9MgYalAzj4CGvfYJHCsj21P /L5fCc732hmR1rbXYLABVsXtiL9lJbgFY+6CZu8JjAdPjNcAx86iH6BDpOd1zLrDG1cvpVNJ746
 KrafqtYSadXEw/5JJCfgy0ZUPEiOJAJaygJimbCgPEx1KuTiOlRZS/aVZxRvbavGkU8TvvSJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=573 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170146

On Thu, 2025-06-12 at 04:11 +0100, Al Viro wrote:
> lookup_template_data_hash_algo() machinery is used to locate the
> matching ima_algo_array[] element at read time; securityfs
> allows to stash that into inode->i_private at object creation
> time, so there's no need to bother
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Really nice clean up.

thanks,

Acked-by: Mimi Zohar <zohar@linux.ibm.com>



