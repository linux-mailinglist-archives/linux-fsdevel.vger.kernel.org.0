Return-Path: <linux-fsdevel+bounces-39404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D36EA13A9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 14:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474EC1691ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 13:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C091F37C6;
	Thu, 16 Jan 2025 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A7eWZjmZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D74519CC39;
	Thu, 16 Jan 2025 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737033210; cv=none; b=kozCXg4o9ns1FcIfflSk1rkOb3Xkh8AUumIQluTw2LL04RWOVsT6GInMA7yc5wLSrE8FYyn4OTN8WLweyJnFQNFNiV4dkuCNqJ42woAiz8ouFL+TtqehiNp4iQifAzkjWTzcE4i44Vh1TfhIJkLvtwVDUZrr5WAGGWg6NM/rrQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737033210; c=relaxed/simple;
	bh=a4FelPve24hx2H541JYRkMU/NzufVucHC49QLg/Y6nI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N/THiKubvfZFNb2rasLgFYcyQnKF0GqhGaYN9hIQtymf55JIUniNa4m02BWxpFCSbKyxPzx7O10Ln9piRqK1RdmfGECRXjbOmtUhafFUkkxGOAN5y4eupiJCij0wPQfqknB0jDOhEyg8m80iLkcivEPc8+pz6xZoTZB5mGahV+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A7eWZjmZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50G78xVM019751;
	Thu, 16 Jan 2025 13:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BEbmGn
	qQf1/62KTsvyxoe5FQYiW9lG/p4Gib5T766i8=; b=A7eWZjmZKL9H8DuPQs0Xg4
	9tKBHhscO/XwQqEuPGZrcNj7RHAgVdxy3zBF+kGxNUvJSZDaNSNqdynbxA6QR5VE
	4+cuR/G6b2G3k3BX+DJCZVLIw7T0X/D33r0TNsVpoTdrSgVwdG4NeK7TOg5GrHUf
	CgubsLOQP4MCWkGVnBWDFL4olwodMMrJzqFXAo4kiGYXWDjEfwy2XEl5KdQ54u6Z
	9fuMm9rdY166X9OL+Wpk+lzFEpMigifrzrhNuRy0wqX47J8B7KoyjxzRIOb6ppjr
	55L0Gw6UD+o1ZVcP5Y2oE+ICYwe1EvaCenvH9N8XR8/Lxzp9wZ+w7SpkdCG+ZVJw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446eg5wrk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 13:13:03 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50GDAgM0011301;
	Thu, 16 Jan 2025 13:13:02 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446eg5wrk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 13:13:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50G9t5HB007385;
	Thu, 16 Jan 2025 13:13:01 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443yndykd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 13:13:01 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50GDD1iR29819634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 13:13:01 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11D1458065;
	Thu, 16 Jan 2025 13:13:01 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17A6558057;
	Thu, 16 Jan 2025 13:13:00 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.122.241])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jan 2025 13:13:00 +0000 (GMT)
Message-ID: <71ef0b0abbb5cb9cfff7b8287542308b9a0b88d4.camel@linux.ibm.com>
Subject: Re: [PATCH v2 7/7] ima: Reset IMA_NONACTION_RULE_FLAGS after
 post_setattr
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>, stable@vger.kernel.org
Date: Thu, 16 Jan 2025 08:12:59 -0500
In-Reply-To: <20241128100621.461743-8-roberto.sassu@huaweicloud.com>
References: <20241128100621.461743-1-roberto.sassu@huaweicloud.com>
	 <20241128100621.461743-8-roberto.sassu@huaweicloud.com>
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
X-Proofpoint-GUID: uDhFwdqcGNgLHe6QWTo2O8Z-H_B0tG1E
X-Proofpoint-ORIG-GUID: n32nTXmeXhDBCBbzNnUbIzeTg-g9H8XU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_05,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 adultscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501160098

On Thu, 2024-11-28 at 11:06 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Commit 11c60f23ed13 ("integrity: Remove unused macro
> IMA_ACTION_RULE_FLAGS") removed the IMA_ACTION_RULE_FLAGS mask, due to it
> not being used after commit 0d73a55208e9 ("ima: re-introduce own integrit=
y
> cache lock").
>=20
> However, it seems that the latter commit mistakenly used the wrong mask
> when moving the code from ima_inode_post_setattr() to
> process_measurement(). There is no mention in the commit message about th=
is
> change and it looks quite important, since changing from IMA_ACTIONS_FLAG=
S
> (later renamed to IMA_NONACTION_FLAGS) to IMA_ACTION_RULE_FLAGS was done =
by
> commit 42a4c603198f0 ("ima: fix ima_inode_post_setattr").
>=20
> Restore the original change, but with new mask 0xfb000000 since the
> policy-specific flags changed meanwhile, and rename IMA_ACTION_RULE_FLAGS
> to IMA_NONACTION_RULE_FLAGS, to be consistent with IMA_NONACTION_FLAGS.

Thanks, Roberto.  Please summarize the reason for reverting the change.  So=
mething
like:  Restore the original change to not reset the new file status after .=
..

>=20
> Cc: stable@vger.kernel.org=C2=A0# v4.16.x
> Fixes: 11c60f23ed13 ("integrity: Remove unused macro IMA_ACTION_RULE_FLAG=
S")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
> =C2=A0security/integrity/ima/ima.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> =C2=A0security/integrity/ima/ima_main.c | 2 +-
> =C2=A02 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 22c3b87cfcac..32ffef2cc92a 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -141,6 +141,7 @@ struct ima_kexec_hdr {
> =C2=A0
> =C2=A0/* IMA iint policy rule cache flags */
> =C2=A0#define IMA_NONACTION_FLAGS	0xff000000
> +#define IMA_NONACTION_RULE_FLAGS	0xfb000000
> =C2=A0#define IMA_DIGSIG_REQUIRED	0x01000000
> =C2=A0#define IMA_PERMIT_DIRECTIO	0x02000000
> =C2=A0#define IMA_NEW_FILE		0x04000000
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index 712c3a522e6c..83e467ad18d4 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -277,7 +277,7 @@ static int process_measurement(struct file *file, con=
st struct
> cred *cred,
> =C2=A0		/* reset appraisal flags if ima_inode_post_setattr was called */
> =C2=A0		iint->flags &=3D ~(IMA_APPRAISE | IMA_APPRAISED |
> =C2=A0				 IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK |
> -				 IMA_NONACTION_FLAGS);
> +				 IMA_NONACTION_RULE_FLAGS);
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * Re-evaulate the file if either the xattr has changed or the


