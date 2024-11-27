Return-Path: <linux-fsdevel+bounces-36012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8129DAA96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 16:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78C2DB20D3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 15:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBEA1FF7D3;
	Wed, 27 Nov 2024 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iqIzHT3e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3695C3C488;
	Wed, 27 Nov 2024 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732720583; cv=none; b=BmsU6+xiVOoVRkJhig3Zfl8HYIG9jTdHruy45FgBQvKiQdm/MGim9sJWLNSrFJM+r3G2v6uMbxnI5PA1GE1FWC63xjtdv1NnlCJKycatk6At/a0ESYZ896TocytCeV/9tbCRp20RRNk8QPXR15kjkkVOw7RFck6zU4qGSTiMGqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732720583; c=relaxed/simple;
	bh=j56SidWTeMECEH9XnsnPDPElqnlb+sOERLEtwF5EoXg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WtAA6ZFzrYRH9Ev6xUrv36A2KDVaBDGJbwo/VDz4i4tkgoHBcgF/lv3m8glwysOaJ2ZvXvInMdvLf+oHzLNQfjrNdgNjSU171hgFshgF0sSfda1Dpfj7eieRgQB+qcDpvxjp3ABA5CxwS5gEJ19kdSn6zFE/bVoI8JqlKNZzsTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iqIzHT3e; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ARBeiAr029192;
	Wed, 27 Nov 2024 15:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GCS2DQ
	Uac3TMxyLYLwiZmv8x54wgn5Xk1pl4/F6v0m0=; b=iqIzHT3enT0CDH3A46gu9i
	EZdykzNoAwSOXOa8g6bp5tEcZ5ODbWqx/tvnX/bE62xurMdnL9iYj9BKi4sFZUyb
	bF++yjbC6KQqTbuw4Z9l017b3SqIYljh8Pg/4zb/FYOiRZWPC+O5eiiPxM+x5pi8
	SYULlPbc6i9CHHMtwogs56NIe2vgPimoh56yFuhzVuIVT2tYIDYmcljzldGnRmRj
	f7si3zFqf+YJI0YhqAdYXo87LRjEw/bYVEnwJtLzKB4vYQBe7wkOU5DtI9fCx1G0
	Q5euZ+ZkncA1NGmTxCpghOmr4S9XknE3vv7narDXXtcttxpFFowjef4YTd6YAB8A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386nmp2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 15:15:08 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4ARF0STW011828;
	Wed, 27 Nov 2024 15:15:07 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386nmp2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 15:15:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ARDbiiG026337;
	Wed, 27 Nov 2024 15:15:06 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 433v30xgw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 15:15:06 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ARFF5jj51118506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 15:15:05 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D3E45805C;
	Wed, 27 Nov 2024 15:15:05 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E2195805E;
	Wed, 27 Nov 2024 15:15:01 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.125.198])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Nov 2024 15:15:00 +0000 (GMT)
Message-ID: <a566be590766eac5811a1e44af5cfd731d503d7e.camel@linux.ibm.com>
Subject: Re: [PATCH v21 6/6] samples/check-exec: Add an enlighten "inc"
 interpreter and 28 tests
From: Mimi Zohar <zohar@linux.ibm.com>
To: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>, Paul Moore
 <paul@paul-moore.com>,
        Serge Hallyn <serge@hallyn.com>,
        Adhemerval Zanella
 Netto <adhemerval.zanella@linaro.org>,
        Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
        Andrew Morton
 <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Heimes <christian@python.org>,
        Dmitry Vyukov
 <dvyukov@google.com>, Elliott Hughes <enh@google.com>,
        Eric Biggers
 <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Fan Wu
 <wufan@linux.microsoft.com>,
        Florian Weimer <fweimer@redhat.com>,
        Geert
 Uytterhoeven <geert@linux-m68k.org>,
        James Morris
 <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>,
        Jann Horn
 <jannh@google.com>, Jeff Xu <jeffxu@google.com>,
        Jonathan Corbet
 <corbet@lwn.net>,
        Jordan R Abrahams <ajordanr@google.com>,
        Lakshmi
 Ramasubramanian <nramas@linux.microsoft.com>,
        Linus Torvalds
 <torvalds@linux-foundation.org>,
        Luca Boccassi <bluca@debian.org>,
        Luis
 Chamberlain <mcgrof@kernel.org>,
        "Madhavan T . Venkataraman"
 <madvenka@linux.microsoft.com>,
        Matt Bobrowski <mattbobrowski@google.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Wilcox
 <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas
 Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
        Scott Shell
 <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell
 <sfr@canb.auug.org.au>,
        Steve Dower <steve.dower@python.org>, Steve Grubb
 <sgrubb@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Thibaut Sautereau
 <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel
 <vincent.strubel@ssi.gouv.fr>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Yin
 Fengwei <fengwei.yin@intel.com>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Date: Wed, 27 Nov 2024 10:15:00 -0500
In-Reply-To: <20241127.Ob8DaeR9xaul@digikod.net>
References: <20241112191858.162021-1-mic@digikod.net>
	 <20241112191858.162021-7-mic@digikod.net>
	 <d115a20889d01bc7b12dbd8cf99aad0be58cbc97.camel@linux.ibm.com>
	 <20241122.ahY1pooz1ing@digikod.net>
	 <623f89b4de41ac14e0e48e106b846abc9e9d70cf.camel@linux.ibm.com>
	 <20241127.Ob8DaeR9xaul@digikod.net>
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
X-Proofpoint-GUID: Kd8WuLouAhuXRPFpDaVk4_8ACYrn9rDN
X-Proofpoint-ORIG-GUID: 0WhnWlE6pkwgsa_A3gcl6aVmeAxdV_mA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411270119

On Wed, 2024-11-27 at 13:10 +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> On Tue, Nov 26, 2024 at 12:41:45PM -0500, Mimi Zohar wrote:
> > On Fri, 2024-11-22 at 15:50 +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> > > On Thu, Nov 21, 2024 at 03:34:47PM -0500, Mimi Zohar wrote:
> > > > Hi Micka=C3=ABl,
> > > >=20
> > > > On Tue, 2024-11-12 at 20:18 +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> > > > >=20
> > > > > +
> > > > > +/* Returns 1 on error, 0 otherwise. */
> > > > > +static int interpret_stream(FILE *script, char *const script_nam=
e,
> > > > > +			    char *const *const envp, const bool restrict_stream)
> > > > > +{
> > > > > +	int err;
> > > > > +	char *const script_argv[] =3D { script_name, NULL };
> > > > > +	char buf[128] =3D {};
> > > > > +	size_t buf_size =3D sizeof(buf);
> > > > > +
> > > > > +	/*
> > > > > +	 * We pass a valid argv and envp to the kernel to emulate a nat=
ive
> > > > > +	 * script execution.  We must use the script file descriptor in=
stead of
> > > > > +	 * the script path name to avoid race conditions.
> > > > > +	 */
> > > > > +	err =3D execveat(fileno(script), "", script_argv, envp,
> > > > > +		       AT_EMPTY_PATH | AT_EXECVE_CHECK);
> > > >=20
> > > > At least with v20, the AT_CHECK always was being set, independent o=
f whether
> > > > set-exec.c set it.  I'll re-test with v21.
> > >=20
> > > AT_EXECVE_CEHCK should always be set, only the interpretation of the
> > > result should be relative to securebits.  This is highlighted in the
> > > documentation.
> >=20
> > Sure, that sounds correct.  With an IMA-appraisal policy, any unsigned =
script
> > with the is_check flag set now emits an "cause=3DIMA-signature-required=
" audit
> > message.  However since IMA-appraisal isn't enforcing file signatures, =
this
> > sounds wrong.
> >=20
> > New audit messages like "IMA-signature-required-by-interpreter" and "IM=
A-
> > signature-not-required-by-interpreter" would need to be defined based o=
n the
> > SECBIT_EXEC_RESTRICT_FILE.
>=20
> It makes sense.  Could you please send a patch for these
> IMA-*-interpreter changes?  I'll include it in the next series.

Sent as an RFC.  The audit message is only updated for the missing signatur=
e
case.  However, all of the audit messages in ima_appraise_measurement() sho=
uld
be updated.  The current method doesn't scale.

Mimi

> >=20
> >=20
> > > >=20
> > > > > +	if (err && restrict_stream) {
> > > > > +		perror("ERROR: Script execution check");
> > > > > +		return 1;
> > > > > +	}
> > > > > +
> > > > > +	/* Reads script. */
> > > > > +	buf_size =3D fread(buf, 1, buf_size - 1, script);
> > > > > +	return interpret_buffer(buf, buf_size);
> > > > > +}
> > > > > +
> > > >=20
> > > >=20
> > >=20
> >=20
> >=20
>=20


