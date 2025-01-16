Return-Path: <linux-fsdevel+bounces-39398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D90CDA13982
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 12:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282C23A6AD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 11:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374C51DE4DF;
	Thu, 16 Jan 2025 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YLPGhTQ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BA71DE4EF;
	Thu, 16 Jan 2025 11:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737028368; cv=none; b=hZgFsbqZshxCAdBk1NW2j6eJ4mLwQKcxZx0qSmkXzOpNfeVauF5rcR6VHiWLeo75Ur9eh/JaIUX/zlcmBafsTGCivTmv+c3OoksZRWDh/NIPsvsKpi2yWXCPWWC49SjGJrwJcBQMp9YzV0gLyixKIS9Esx2RjxEEoss/vy3XXR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737028368; c=relaxed/simple;
	bh=IIkgJW5uzFF+glFM/tgQ5XQXHbpkGyOEDF+vsD1oDY0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OWVObqkrNvukbQz/K5v/uo6cXLgthWbb9/1F81QZ5jX1noaHK+CpafMS2GXpKKNEL91lc7VaqViiIRevfZhxRy7tHFhsDvn/MaYEcokBlRMqi2nxDUU9bY7WC9MQ+vxhygjzwPbxDdwwjHMyf1clMoMeO1rxU9u2kQeeQZTQSls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YLPGhTQ/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50G85g94020410;
	Thu, 16 Jan 2025 11:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8N2eoZ
	3YvYb/SFAyhdNqcY8Vat04k3vLluJ3ZnnVVm4=; b=YLPGhTQ/onE5PqfR+SwDxA
	DfLdixm+6D0nsa5LrWiA28HY1aJ3ycqvsuzPQjC4DvGHKjYLSqKIbgxlT0V4B4BV
	BNLdDluszzLAI0EMvhjFYd7W95JB+z3MecvgVqXYhZbs0JcCSqVPwkOzepKjT2rr
	KTEX3E10yPngKBGDVIn8AXXlhO+4a+lEMbLv6YSgVUAlv+u22XV88joGBdGYco7p
	07aeaqj7Zv5sV1VaOiplpECKMIvyjebBgqqyPoGy2uIFoEy0qtV74eOGDbYi5oJ2
	bBJTv98ylPjvx563LvSWXkrw6nLB4QZ2zGnVD8YxQLrJHJXYDCPADLiH/rf5/3tg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446xa391bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 11:52:13 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50GBkD7g028253;
	Thu, 16 Jan 2025 11:52:13 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446xa391bj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 11:52:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GAk3J8001089;
	Thu, 16 Jan 2025 11:52:12 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44456k5cyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 11:52:12 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50GBqBtm29098512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 11:52:11 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 802F45806D;
	Thu, 16 Jan 2025 11:52:11 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00BD658080;
	Thu, 16 Jan 2025 11:52:10 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.131.6])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jan 2025 11:52:09 +0000 (GMT)
Message-ID: <906089e5f4e24182dc776488959dc595c92a616c.camel@linux.ibm.com>
Subject: Re: [PATCH v2 6/7] ima: Discard files opened with O_PATH
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>, stable@vger.kernel.org
Date: Thu, 16 Jan 2025 06:52:09 -0500
In-Reply-To: <20241128100621.461743-7-roberto.sassu@huaweicloud.com>
References: <20241128100621.461743-1-roberto.sassu@huaweicloud.com>
	 <20241128100621.461743-7-roberto.sassu@huaweicloud.com>
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
X-Proofpoint-GUID: 1QLzUOACWmiCUstkNHBoWu8bxOFAwfe1
X-Proofpoint-ORIG-GUID: tlsjCwY0L238jXouCxhTav_tXU-wJYhA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_05,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 adultscore=0 mlxlogscore=861 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501160086

On Thu, 2024-11-28 at 11:06 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> According to man open.2, files opened with O_PATH are not really opened. =
The
> obtained file descriptor is used to indicate a location in the filesystem
> tree and to perform operations that act purely at the file descriptor
> level.
>=20
> Thus, ignore open() syscalls with O_PATH, since IMA cares about file data=
.
>=20
> Cc: stable@vger.kernel.org=C2=A0# v2.6.39.x
> Fixes: 1abf0c718f15a ("New kind of open files - "location only".")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks, Roberto.

Note: Ignoring open() with O_PATH impacts policies containing "func=3DFILE_=
CHECK"
rules.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
> =C2=A0security/integrity/ima/ima_main.c | 6 ++++--
> =C2=A01 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index 50b37420ea2c..712c3a522e6c 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -202,7 +202,8 @@ static void ima_file_free(struct file *file)
> =C2=A0	struct inode *inode =3D file_inode(file);
> =C2=A0	struct ima_iint_cache *iint;
> =C2=A0
> -	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
> +	if (!ima_policy_flag || !S_ISREG(inode->i_mode) ||
> +	=C2=A0=C2=A0=C2=A0 (file->f_flags & O_PATH))
> =C2=A0		return;
> =C2=A0
> =C2=A0	iint =3D ima_iint_find(inode);
> @@ -232,7 +233,8 @@ static int process_measurement(struct file *file, con=
st struct
> cred *cred,
> =C2=A0	enum hash_algo hash_algo;
> =C2=A0	unsigned int allowed_algos =3D 0;
> =C2=A0
> -	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
> +	if (!ima_policy_flag || !S_ISREG(inode->i_mode) ||
> +	=C2=A0=C2=A0=C2=A0 (file->f_flags & O_PATH))
> =C2=A0		return 0;
> =C2=A0
> =C2=A0	/* Return an IMA_MEASURE, IMA_APPRAISE, IMA_AUDIT action


