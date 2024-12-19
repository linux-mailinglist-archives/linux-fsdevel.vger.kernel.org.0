Return-Path: <linux-fsdevel+bounces-37870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BB09F8318
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 19:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1EC81886A98
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADCF1A239F;
	Thu, 19 Dec 2024 18:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I3Wu8QmV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F15197552;
	Thu, 19 Dec 2024 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734632341; cv=none; b=elgtW6+2ZrJ/nTwnnKPYTWHHZG2obaoHqATr7p7dAQATpON1CxrRDqXBHslBI1sdi6zsbtTH9cdC7D5f/PAxiWlxY9xI5QiCZZfrg/z94/++tg8lWdzSOSHvQNUCmQlB8VRSC1wSYywR3kjEdxZi8O/yoQoecG9jq1QyDyXQtYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734632341; c=relaxed/simple;
	bh=YEgEGk++Qawum4Tv6R4g7l33rhRuK+evDXcUWNrk0r4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=flxCDlvztmCORl3HYal3juivegIZmGVtJURUp5xX9wb2RdAbd3QgD1MZUrmSXMhlMjiCmJtXFn6WmU0LAopK4coGcLC0Zuten55CrVBm3dLBuGbs1xFNvGmghvbyRbk93ohYlCVxecUTvbxzesvmVovzTjGR12+mvn2mklSQALU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I3Wu8QmV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJB0K7t014132;
	Thu, 19 Dec 2024 18:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eDuTZs
	OioSGNDi5/aCCuLNZykanqrA+r2NggIOF7AxE=; b=I3Wu8QmVcPxbXmq9kBF+IH
	LUdzGRGsv6rA+GG7hCSnmDwyz+RlRUxbrO52cJIwDcjz0vD3XAZWcp9/upRBiKV3
	xvGBdMjKC18piBTDlQm/UamjO0JunnQgWOgs5p9rwuGojUnlaX1PAb7FHeGptzkt
	q4DpkpU/naFSBvvtRu9q/HDFpC7C9JROpVwi8hqGLinSmdm0n4jbMr6NCmow54Y7
	3G8Vo8RA+JHAiSihJ3Eh7qjVZhU4743BTsb72X3uevI5yPY9AuWQT6GOyfolqLs1
	VRyaj/zxJGiwRCZCQMN3HcODFOIu0r3/T987uQ60JsUnVm90LuRyS3v5otyQv0Kw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43mj80a4jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 18:18:21 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BJIIK4B021333;
	Thu, 19 Dec 2024 18:18:20 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43mj80a4js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 18:18:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJGmwgH005564;
	Thu, 19 Dec 2024 18:18:20 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnbneg0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 18:18:20 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BJIIJCp27656942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 18:18:19 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8FEA58059;
	Thu, 19 Dec 2024 18:18:19 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5EE058053;
	Thu, 19 Dec 2024 18:18:17 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.169.26])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Dec 2024 18:18:17 +0000 (GMT)
Message-ID: <b325441507555d7e9d1b1f0205da3b06ccaa2553.camel@linux.ibm.com>
Subject: Re: [RFC 0/2] ima: evm: Add kernel cmdline options to disable
 IMA/EVM
From: Mimi Zohar <zohar@linux.ibm.com>
To: Song Liu <songliubraving@meta.com>,
        Roberto Sassu
	 <roberto.sassu@huaweicloud.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, Song Liu <song@kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	 <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org"
	 <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	 <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>,
        "roberto.sassu@huawei.com"
	 <roberto.sassu@huawei.com>,
        "dmitry.kasatkin@gmail.com"
	 <dmitry.kasatkin@gmail.com>,
        "eric.snowberg@oracle.com"
	 <eric.snowberg@oracle.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org"
	 <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        Kernel Team
	 <kernel-team@meta.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "jack@suse.cz"
	 <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Date: Thu, 19 Dec 2024 13:18:17 -0500
In-Reply-To: <358F6A59-C8ED-4CD6-996C-C68B3034B3F7@fb.com>
References: <20241217202525.1802109-1-song@kernel.org>
	 <fc60313a-67b3-4889-b1a6-ba2673b1a67d@schaufler-ca.com>
	 <bd5a5029302bc05c2fbe3ee716abb644c568da48.camel@linux.ibm.com>
	 <C01F96FE-0E0F-46B1-A50C-42E83543B9E1@fb.com>
	 <ac0d0d8f3d40ec3f7279f3ece0e75d0b2ec32b4e.camel@huaweicloud.com>
	 <358F6A59-C8ED-4CD6-996C-C68B3034B3F7@fb.com>
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
X-Proofpoint-GUID: N4_Uh-vALOVenc9mVTaTNu5VSPUKeKy5
X-Proofpoint-ORIG-GUID: ZthzyLdI81sc0CSQ9yH0QT5Fje8TI9zv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 mlxlogscore=946 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1011
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190143

On Thu, 2024-12-19 at 17:46 +0000, Song Liu wrote:
> Hi Roberto,=20
>=20
> Thanks for sharing these information!
>=20
> > On Dec 19, 2024, at 7:40=E2=80=AFAM, Roberto Sassu <roberto.sassu@huawe=
icloud.com> wrote:
>=20
> [...]
>=20
> > > I didn't know about this history until today. I apologize if this=20
> > > RFC/PATCH is moving to the direction against the original agreement.=
=20
> > > I didn't mean to break any agreement.=20
> > >=20
> > > My motivation is actually the per inode memory consumption of IMA=20
> > > and EVM. Once enabled, EVM appends a whole struct evm_iint_cache to=
=20
> > > each inode via i_security. IMA is better on memory consumption, as=
=20
> > > it only adds a pointer to i_security.=20
> > >=20
> > > It appears to me that a way to disable IMA and EVM at boot time can=
=20
> > > be useful, especially for distro kernels. But I guess there are=20
> > > reasons to not allow this (thus the earlier agreement). Could you=20
> > > please share your thoughts on this?
> >=20
> > Hi Song
> >=20
> > IMA/EVM cannot be always disabled for two reasons: (1) for secure and
> > trusted boot, IMA is expected to enforce architecture-specific
> > policies; (2) accidentally disabling them will cause modified files to
> > be rejected when IMA/EVM are turned on again.
> >=20
> > If the requirements above are met, we are fine on disabling IMA/EVM.
>=20
> I probably missed something, but it appears to me IMA/EVM might be=20
> enabled in distro kernels, but the distro by default does not=20
> configure IMA/EVM, so they are not actually used. Did I misunderstand=20
> something?

If "CONFIG_IMA_ARCH_POLICY" is configured, then the architecture specific p=
olicy
is configured and loaded on boot.  For x86 and arm, the architecture specif=
ic
policy rules are defined in ima_efi.c.  On power, the rules are defined in
arch/powerpc/kernel/ima_arch.c.  On most systems, the currently enabled IMA
policy rules can be viewed by cat'ing <securityfs>/integrity/ima/policy.

For more information on IMA policies, refer to
https://ima-doc.readthedocs.io/en/latest/ima-policy.html#

Mimi

>=20
> > As for reserving space in the inode security blob, please refer to this
> > discussion, where we reached the agreement:
> >=20
> > https://lore.kernel.org/linux-integrity/CAHC9VhTTKac1o=3DRnQadu2xqdeKH8=
C_F+Wh4sY=3DHkGbCArwc8JQ@mail.gmail.com/
>=20
> AFAICT, the benefit of i_security storage is its ability to be=20
> configured at boot time. If IMA/EVM cannot be disabled, it is=20
> better to add them to struct inode within a "#ifdef CONFIG_"
> block.=20
>=20
> Thanks,
> Song
>=20


