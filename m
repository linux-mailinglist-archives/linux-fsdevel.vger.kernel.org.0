Return-Path: <linux-fsdevel+bounces-11789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FED385727F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 01:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72ADB1F215E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 00:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE818D271;
	Fri, 16 Feb 2024 00:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aHIYNU4s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2969228E8;
	Fri, 16 Feb 2024 00:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708043184; cv=none; b=lm/P+F9UDWnCJQLfgC1NqvsIX95A2S+YGv9IVj3P6qsT5PJ8fa+7O7kNgCN1W8gjrVSYE29zxxWGTE/upoin4gVzHRFXPnh/DjPJTzRyuFFtbve9KCGokvZ+59QJQzJq4wo9ZqKW6MQOJEovHTWOrztcI7idOcI7jlRJglV9RDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708043184; c=relaxed/simple;
	bh=oXtwZtSuO9glftnKm5bDsm0gbH6HrsEW0khA9h2R97U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=DQwaNu4Al00k96r/9VRXvq1JKGdUyXx1+UFYCiKxH6cyqB2RVDy5pdmGgq1XTObDeBXsxtg89SZTfoCY1s8UaXlaiwcGXElV3P1m8ApjwWxexPkU5hQ4lvF/OO12fxf8l/VSyLZjqa2dTd/Yk1XTAeMtK7lTG+5om08RkdpKIF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aHIYNU4s; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FMtnth028679;
	Fri, 16 Feb 2024 00:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Om9oyXgDiFyioTn4kHbDdu9jyc7RJhYiunD0WE9LJcY=;
 b=aHIYNU4sNfsa6W1Zi2SHNnYp5pAsdwkhgkxJcFYINTcs7hJVzXD1EVzqpEhsQw9vmW54
 1AUJMWoYDVuVJx6grRr+rbtVY2w8d2UjRvNHeiATyyb/V4Id7ll/q4t4K9kkWwbF76vf
 j2Cm+vKS7fWCcn05rSyIYpYOC3RHWwGIQl8vhUK2MQ5fwFRVl/O4wmtSfVPLFc1bI/4z
 WnInjoiLggCOIG2skURkMzY32fQ4Puohw0GxcsUOQKf4h2y33musZLxiyLV0Uu17uJ/O
 5yaUNhukbVWTLYDDZzJxo+gUPF+gWxMjEcxCYbSsCtxF1l3cj+kJNp6WNffJWAkLfWT5 Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9uucsfcr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 00:25:48 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41G0MkpP026872;
	Fri, 16 Feb 2024 00:25:47 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9uucsfc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 00:25:47 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41FLD05g009728;
	Fri, 16 Feb 2024 00:25:46 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6p637q1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 00:25:46 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41G0Ph1735258676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 00:25:45 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2A2B58061;
	Fri, 16 Feb 2024 00:25:43 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF01158058;
	Fri, 16 Feb 2024 00:25:41 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.113.219])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Feb 2024 00:25:41 +0000 (GMT)
Message-ID: <6154a26bb0efc2abbfc51df4bf1adc8279854f3c.camel@linux.ibm.com>
Subject: Re: [PATCH v10 19/25] integrity: Move
 integrity_kernel_module_request() to IMA
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, chuck.lever@oracle.com,
        jlayton@kernel.org, neilb@suse.de, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, omosnace@redhat.com,
        casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Roberto Sassu
	 <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Date: Thu, 15 Feb 2024 19:25:41 -0500
In-Reply-To: <09d6fa08e2d62720759f57237043a2dd9b5208ca.camel@huaweicloud.com>
References: <20240215103113.2369171-1-roberto.sassu@huaweicloud.com>
	 <20240215103113.2369171-20-roberto.sassu@huaweicloud.com>
	 <09d6fa08e2d62720759f57237043a2dd9b5208ca.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eVp6Z66UPLJF9IDvI4kibR2k_-D2yKlM
X-Proofpoint-GUID: 8F3OPV3UWb5PHaUQpiMgR3h1AV3Tc70q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_23,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160001

On Thu, 2024-02-15 at 17:09 +0100, Roberto Sassu wrote:
> On Thu, 2024-02-15 at 11:31 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > In preparation for removing the 'integrity' LSM, move
> > integrity_kernel_module_request() to IMA, and rename it to
> > ima_kernel_module_request(). Rewrite the function documentation, to explain
> > better what the problem is.
> > 
> > Compile it conditionally if CONFIG_INTEGRITY_ASYMMETRIC_KEYS is enabled,
> > and call it from security.c (removed afterwards with the move of IMA to the
> > LSM infrastructure).
> > 
> > Adding this hook cannot be avoided, since IMA has no control on the flags
> > passed to crypto_alloc_sig() in public_key_verify_signature(), and thus
> > cannot pass CRYPTO_NOLOAD, which solved the problem for EVM hashing with
> > commit e2861fa71641 ("evm: Don't deadlock if a crypto algorithm is
> > unavailable").
> > 
> > EVM alone does not need to implement this hook, first because there is no
> > mutex to deadlock, and second because even if it had it, there should be a
> > recursive call. However, since verification from EVM can be initiated only
> > by setting inode metadata, deadlock would occur if modprobe would do the
> > same while loading a kernel module (which is unlikely).
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Acked-by: Paul Moore <paul@paul-moore.com>
> > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > Acked-by: Mimi Zohar <zohar@linux.ibm.com>
> 
> I hope the change of the ima_kernel_module_request() documentation is
> fine for everyone.
> 
> If not, let me know.

Thanks, Roberto.  The updated kernel-doc looks good.

Mimi


