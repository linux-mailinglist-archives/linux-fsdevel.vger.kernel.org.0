Return-Path: <linux-fsdevel+bounces-51974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E033BADDCAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 21:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE563B58CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 19:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3482EAB6F;
	Tue, 17 Jun 2025 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bUxwQMJs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3522DE1EC;
	Tue, 17 Jun 2025 19:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750189747; cv=none; b=TWFEY4qotH5UhaScgPcFxzgnC2ZbCNIrU1Sb9MCYJV5ILIV/JqehcL+PbUsoq/ru2jDVD04pWELv6fOEaAVj618zcWgNCIXbcbht0Rbz0S5B5zm0xEjgJW8rmCQcipTm7NBq/yxkUnNcolgzaSbprg77yr6FK3U6pOz1z98dbvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750189747; c=relaxed/simple;
	bh=aagMmVjoFGIYooU76+oJ4BsIIRerzvH88d8vqyRVSxg=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=gojZIAvXf2KaoJrsystXJA78lxilYVU9ShYcNHfvtmy2xMknxlKosSddFCR+ZfmcFvxFRAHTX+tLHyxV/qX5VfyJYbyhtkAA2hEmpamPyMEsCIUbx9SWBCdXighoiuCa8ti4wov30RzNGImmOlGhvBz/ol16wAwyfDV88300+Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bUxwQMJs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HBWqBu012534;
	Tue, 17 Jun 2025 19:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aagMmV
	joFGIYooU76+oJ4BsIIRerzvH88d8vqyRVSxg=; b=bUxwQMJs9bBkX/CC6y6b7g
	hrdWresNEA+W4sey5Td8TmO9E4o3qEugXseC6Saap7461sXVq1JbV4wj6eG1GMDK
	GUdAh9843UYXER6nv2jzH1cvYs1k3YPiZDkHzeVtY06+uR7lKfmbuoHdGVTO35X0
	ITDGmqYeXRFvDwONg1aBwnxMJ5IL/kS0si0eDT7gm8q0S2MO0uYxZ3A8o4oPkfvY
	OZEHFzn4rjNS3tvaEGxLx+5PXC+ONeYZfv3rhzXHGagkUr4bhr0BGw3XDucEYFx4
	bhZLAjIf5MriePgWbSBbsxyR13WQB52Kysibz/rjhCRqJPbpHVLEy8W5OG3P9rPg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4794qp9enm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 19:49:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55HJC7r4027480;
	Tue, 17 Jun 2025 19:49:03 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479ksywcyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 19:49:03 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55HJn2PB25952840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 19:49:02 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 906265805D;
	Tue, 17 Jun 2025 19:49:02 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1148E58059;
	Tue, 17 Jun 2025 19:49:02 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Jun 2025 19:49:01 +0000 (GMT)
Message-ID: <f2435646f262ee5eee432b9f5d54d90621db2faa.camel@linux.ibm.com>
Subject: Re: [PATCH 08/10] evm_secfs: clear securityfs interactions
From: Mimi Zohar <zohar@linux.ibm.com>
To: Al Viro <viro@zeniv.linux.org.uk>, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
In-Reply-To: <20250612031154.2308915-8-viro@zeniv.linux.org.uk>
References: <20250612030951.GC1647736@ZenIV>
	 <20250612031154.2308915-1-viro@zeniv.linux.org.uk>
	 <20250612031154.2308915-8-viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jun 2025 15:49:01 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I_PmAo-WNvMFCXcNnn9TCabVadsk26zH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE1OSBTYWx0ZWRfX//hO8t3KiPXG QdQFiJM3IdJYr48EgjJWOF8ARxoDfJSCeyHBGCZI1ibZhyo9ridafBAQp7l6XntzgYyA4gr1abk Xf37xK5RmnO89ABA7gwtqj5lbHTv5o5nRQalOJR60QYCaSakBboOF18zf3WTh6ix6wZH2KPAv+6
 atkQuZ/MJf3f3xeFHhB4mIth4swyNHMpSs9/AFXOWW/um8RuQ1E3qA3UpZ9u7NLI+zJUeBEfdNK cPUJ8hNb2Tzpw55JHh4ifXIw4Tycyxqn/Ig2q0YN5UOoeqV1h9RO9cWiThhiPXFABpFe3++bFVu SrTWdl5mQAnKkBq2C2nwaoi3VTLfYlXY1TN5v3WVVgb/qqf6DNYP9ZtqTHKCr/XH6cgQDJgoYKF
 sN8w7NOxLwYNftuAgxr0TT5EbAtYHrkT6/qVdb5h9jVyqA11BGryxx5v/4SfNCA89aPkKXgf
X-Authority-Analysis: v=2.4 cv=NYfm13D4 c=1 sm=1 tr=0 ts=6851c6b0 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=drOt6m5kAAAA:8 a=VnNF1IyMAAAA:8 a=nJUR2TE5ViME3R_j7e8A:9 a=QEXdDO2ut3YA:10
 a=RMMjzBEyIzXRtoq5n5K6:22
X-Proofpoint-ORIG-GUID: I_PmAo-WNvMFCXcNnn9TCabVadsk26zH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=512 mlxscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170159

On Thu, 2025-06-12 at 04:11 +0100, Al Viro wrote:
> 1) creation never returns NULL; error is reported as ERR_PTR()
> 2) no need to remove file before removing its parent
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Nice cleanup.

Acked-by: Mimi Zohar <zohar@linux.ibm.com>


