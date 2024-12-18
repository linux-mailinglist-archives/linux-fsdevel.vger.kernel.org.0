Return-Path: <linux-fsdevel+bounces-37725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3449F6440
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 12:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40ED91648D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 11:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486F719CC11;
	Wed, 18 Dec 2024 11:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fh6B0WGW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D3F27726;
	Wed, 18 Dec 2024 11:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734519806; cv=none; b=bjUyUyV4D+6s9Q5N3UzJYEkVQqTJt64eS92EXTCkW5q5qiAIJITWXcu8qOu/gcIZVfqMWHsJjFLGWWBSfxQUD5QU0OstmqxEW2xdYkmeYx2aLJEFumTb+X7CIQ2B27SlqniHRmtPKIJGq5JJhLSagW4AszkzP/R64m2hWbXZdas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734519806; c=relaxed/simple;
	bh=Bwr8wp1S7qTNpXMylQoXZz6n2G4oi79rMKip+WwaDJk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sHji4918zyN7Sfto+H0Ds0sKNFrodsfYRgEwg1QaKgJUoHkF7I0ZjhYQWIsiRX3HhSq5kV2cHuDb22f69cmIZZKnN9ghl7Zo6Bs6p9pHlmz1LkkAoLzdoJKtno1kR6wa9JgKgPVxXk86VMHgqu94HFk3LMyjh7RcZqwESGkaOqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fh6B0WGW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHNw8em032269;
	Wed, 18 Dec 2024 11:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=s97y+f
	eGJAPiLl7JqkNWOTJGCsnACWuH4V+doSwqn6o=; b=Fh6B0WGW1L32l6+5Bverhw
	4U7xZPRuE3Nx9uYWsO22pQBEAu/tUzc9TWXgbqIqyvp94w9EIr9Le6NLMvjlhcXM
	PAGMQ0c0Ycm1MjIHjwKvxXnkSUskZFpAwRBDA4Pc+iVaVNVBpZah6V7mA8L6GH/T
	mClC2VMnl4I07/e+xfuqwPrq9wdZOtzlrXLejtZmNz69/7WL/pM8sUtWeteiLPdd
	XgKJwswDj+gELiQP0VHqVp5otyAyeQHbklWua0ZeUKFFVQ6053B8yFjpxgHDChNf
	d1ulu9ZB/3fU7Yqsk6642KaX9L7fpXftZSkV87bFQ3F71BBJ519hwNdMcvlFZsGA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kkehagbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 11:02:59 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BIB2xSd029200;
	Wed, 18 Dec 2024 11:02:59 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kkehagb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 11:02:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI7id2a014344;
	Wed, 18 Dec 2024 11:02:57 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hmqy7mqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 11:02:57 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BIB2vQN30868116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 11:02:57 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3619658073;
	Wed, 18 Dec 2024 11:02:57 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EAD258077;
	Wed, 18 Dec 2024 11:02:55 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.145.1])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Dec 2024 11:02:55 +0000 (GMT)
Message-ID: <bd5a5029302bc05c2fbe3ee716abb644c568da48.camel@linux.ibm.com>
Subject: Re: [RFC 0/2] ima: evm: Add kernel cmdline options to disable
 IMA/EVM
From: Mimi Zohar <zohar@linux.ibm.com>
To: Casey Schaufler <casey@schaufler-ca.com>, Song Liu <song@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, kernel-team@meta.com, brauner@kernel.org,
        jack@suse.cz, viro@zeniv.linux.org.uk
Date: Wed, 18 Dec 2024 06:02:55 -0500
In-Reply-To: <fc60313a-67b3-4889-b1a6-ba2673b1a67d@schaufler-ca.com>
References: <20241217202525.1802109-1-song@kernel.org>
	 <fc60313a-67b3-4889-b1a6-ba2673b1a67d@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PR0_6VDIFxuKIqMRZxVmkcCSCK8bPD3N
X-Proofpoint-ORIG-GUID: Se6wyub2I67PDfXPzx-0XCsLmEvb-SN-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=883 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412180088

On Tue, 2024-12-17 at 13:29 -0800, Casey Schaufler wrote:
> On 12/17/2024 12:25 PM, Song Liu wrote:
> > While reading and testing LSM code, I found IMA/EVM consume per inode
> > storage even when they are not in use. Add options to diable them in
> > kernel command line. The logic and syntax is mostly borrowed from an
> > old serious [1].
>=20
> Why not omit ima and evm from the lsm=3D parameter?

Casey, Paul, always enabling IMA & EVM as the last LSMs, if configured, wer=
e the
conditions for making IMA and EVM LSMs.  Up to that point, only when an ino=
de
was in policy did it consume any memory (rbtree).  I'm pretty sure you reme=
mber
the rather heated discussion(s).

Mimi

>=20
> >=20
> > [1] https://lore.kernel.org/lkml/cover.1398259638.git.d.kasatkin@samsun=
g.com/
> >=20
> > Song Liu (2):
> >   ima: Add kernel parameter to disable IMA
> >   evm: Add kernel parameter to disable EVM
> >=20
> >  security/integrity/evm/evm.h       |  6 ++++++
> >  security/integrity/evm/evm_main.c  | 22 ++++++++++++++--------
> >  security/integrity/evm/evm_secfs.c |  3 ++-
> >  security/integrity/ima/ima_main.c  | 13 +++++++++++++
> >  4 files changed, 35 insertions(+), 9 deletions(-)
> >=20
> > --
> > 2.43.5
> >=20
>=20


