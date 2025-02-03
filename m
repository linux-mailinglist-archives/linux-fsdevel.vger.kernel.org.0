Return-Path: <linux-fsdevel+bounces-40556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBEFA25111
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 02:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1883A4B74
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 01:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CBC1804A;
	Mon,  3 Feb 2025 01:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WcJKnUHW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655213C2F;
	Mon,  3 Feb 2025 01:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738546315; cv=none; b=Vw3pGhHG1SG8jrFX+qYYXGRIBaH/apo3TQNHgAaz6XmFGX3uBVvpwu5J3LHXO+edgnxiFh8PE3f10QeLZ6Pyj/Rvu8NfjKzh81IGXrDLarHDGaQswlp5XauDpKf18YJB3ybuwyQReGuWI0/nx+awQEC4lNXxcJSjFnuhpJlheJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738546315; c=relaxed/simple;
	bh=TGDXhA9VFUOBW0nUR/5s5rwPA+aY4v4jgiKejMQ3o/w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MKtQIlhutZ9EgwiM7EL/mGUcaE2RTVEFItpr4rd85D0DFf+EMSN3FNrZDqSAPwik1Blb1NImgaE5fwJSNO+g8c5s2TCgmY6O4nFxl7SJPKTwPnj6q5Z1z1vAnZvDJ9u9s2bq4n9P3QvrGjmKp9W/B9jUInA4uC8Ektz0PIHVcOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WcJKnUHW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 512Bt595015380;
	Mon, 3 Feb 2025 01:31:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kjxtf4
	7CKNtSchjNhx+lVCQZ7est2gEQwyCLkceGQhQ=; b=WcJKnUHWyMsH86R3gehVOc
	3YwRh0hayDnxFdDGo1bRMPfL4nveP9Er5tzc0TC426W+ypv4q4LiGkQDePQDEVsU
	6QQHB+SjFu3upkC9I8si3ioTuAh+9KbWhJWsrre/v/hQHw5mShyJZ+mMXjuukYhA
	bjKHBm1L0ZcnQXuH4m9NaNg66jHVsVtAEDxKhMfl+JUY6lIn7O48mXSo5WxWbm99
	HbHPuUD2BVLt8k2wZOaYRbW/vuLn7ZrjTQtPocqHCGWG5xYzyXoKpvmP2wpCO/zM
	yjF5GDugKHXfksFtbQUtnjmTqhzlm3asMIudYLDy22Spz50qH2yReV/N9siSoTJw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44j2h7b2nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 01:31:13 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5131VCk6026537;
	Mon, 3 Feb 2025 01:31:12 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44j2h7b2nj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 01:31:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51305aci005258;
	Mon, 3 Feb 2025 01:31:11 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j05jktxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 01:31:11 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5131VAKY21889644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Feb 2025 01:31:10 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC1E15804B;
	Mon,  3 Feb 2025 01:31:10 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22A3E58063;
	Mon,  3 Feb 2025 01:31:09 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.68.214])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Feb 2025 01:31:09 +0000 (GMT)
Message-ID: <e93596a3f7696bfe4912f6ec91152e8969bb1192.camel@linux.ibm.com>
Subject: Re: [PATCH v3 6/6] ima: Reset IMA_NONACTION_RULE_FLAGS after
 post_setattr
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Roberto Sassu
 <roberto.sassu@huawei.com>, stable@vger.kernel.org
Date: Sun, 02 Feb 2025 20:31:08 -0500
In-Reply-To: <20250122172432.3074180-7-roberto.sassu@huaweicloud.com>
References: <20250122172432.3074180-1-roberto.sassu@huaweicloud.com>
	 <20250122172432.3074180-7-roberto.sassu@huaweicloud.com>
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
X-Proofpoint-ORIG-GUID: t7kdbocf0x0rsMPmREaRiai9DjIdcEvh
X-Proofpoint-GUID: WIU-qrlO92XxGySXJmSX2cnXAh44zW33
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-02_11,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030011

On Wed, 2025-01-22 at 18:24 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Commit 11c60f23ed13 ("integrity: Remove unused macro
> IMA_ACTION_RULE_FLAGS") removed the IMA_ACTION_RULE_FLAGS mask, due to it
> not being used after commit 0d73a55208e9 ("ima: re-introduce own integrit=
y
> cache lock").
>=20
> However, it seems that the latter commit mistakenly used the wrong mask
> when moving the code from ima_inode_post_setattr() to process_measurement=
(). There
> is no mention in the commit message about this
> change and it looks quite important, since changing from IMA_ACTIONS_FLAG=
S
> (later renamed to IMA_NONACTION_FLAGS) to IMA_ACTION_RULE_FLAGS was done =
by
> commit 42a4c603198f0 ("ima: fix ima_inode_post_setattr").

Roberto, thank you for the detailed explanation.  Could we summarize the pr=
oblem as:=20

Commit 0d73a55208e9 ("ima: re-introduce own integrity cache lock") mistaken=
ly
reverted the performance improvement introduced in commit 42a4c603198f0 ("i=
ma: fix
ima_inode_post_setattr").  The unused bit mask was subsequently removed by =
commit
11c60f23ed13 ("integrity: Remove unused macro IMA_ACTION_RULE_FLAGS").

>=20
> Restore the original change of resetting only the policy-specific flags a=
nd
> not the new file status, but with new mask 0xfb000000 since the
> policy-specific flags changed meanwhile. Also rename IMA_ACTION_RULE_FLAG=
S
> to IMA_NONACTION_RULE_FLAGS, to be consistent with IMA_NONACTION_FLAGS.

Instead of restoring the bit mask that is used only once, consider inlining=
 the
correct bit mask (e.g. IMA_NONACTION_FLAGS & ~IMA_NEW_FILE) and expanding t=
he
existing comment.

>=20
> Cc: stable@vger.kernel.org=C2=A0# v4.16.x
> Fixes: 11c60f23ed13 ("integrity: Remove unused macro IMA_ACTION_RULE_FLAG=
S")

Please update the Fixes tag to refer to commit 0d73a55208e9.

> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

> ---
> =C2=A0security/integrity/ima/ima.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> =C2=A0security/integrity/ima/ima_main.c | 2 +-
> =C2=A02 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index e1a3d1239bee..615900d4150d 100644
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
> index 46adfd524dd8..7173dca20c23 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -275,7 +275,7 @@ static int process_measurement(struct file *file, con=
st struct
> cred *cred,
> =C2=A0		/* reset appraisal flags if ima_inode_post_setattr was called */

Update the comment based on the original commit 42a4c603198f ("ima: fix
ima_inode_post_setattr") patch description.

thanks,

Mimi

> =C2=A0		iint->flags &=3D ~(IMA_APPRAISE | IMA_APPRAISED |
> =C2=A0				 IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK |
> -				 IMA_NONACTION_FLAGS);
> +				 IMA_NONACTION_RULE_FLAGS);
> =C2=A0	/*
> =C2=A0	 * Re-evaulate the file if either the xattr has changed or the


