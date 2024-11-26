Return-Path: <linux-fsdevel+bounces-35933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE349D9CDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 18:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 792BC283B06
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 17:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C2F1DC184;
	Tue, 26 Nov 2024 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZJ4zlMdz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09732182BC;
	Tue, 26 Nov 2024 17:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732643367; cv=none; b=aHFjcLlBcnWYSvhxpfmwLPtgTJQcXJtUkPXVFhYV2CqunZu04nHYnVtHNTseiqs9+2subiVffhztRutvUVEHxNAMMZGCfKjNUMmWBZbJY0Bl0r8R2VqCnYrx5IIrpP8k4TUhirYfjP/uhtWIcKVeErdt5Dk3Bf8RwBhVEgxRpCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732643367; c=relaxed/simple;
	bh=F7FDeE/BUYT5S6TNc+6yiD5emwOFUBL+9TtRDrcmB6c=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 MIME-Version:Date; b=OYtKLPvKkAHIirBMSjsYqIO6tAyaKoNEuMcreFeJHMt3OPMg7eyOg9DvNfPzA/JEEwBguSpjzijMeQwgPuTeR7KxbkJ7K20Mm/4amrfYkrMViyrNOyFEWLaXZfQzJDeIpyuKV1oWsWRIWRGgWi8mg7mQtWxvbFb6hO9B7PYzd/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZJ4zlMdz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQAcOjP003594;
	Tue, 26 Nov 2024 17:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tNFAwQ
	Pf7JigwXLQ0UnmIgzsZn4TdCYwde4TNk3iD00=; b=ZJ4zlMdzYd29sRG62XA8O4
	K5ZSWU2vOtHpQ171myXV9sFIwXoCqCUDyqsq0geuQiTsIHoXsZ5mVrZk7XGzTA2M
	AMb5OVqXxfS/Hkk4A6x/rM5uuUprMGEgbUwUbIEIApRGE+CYJrGQzX//jShp5wrQ
	Vzs4MeUVsRW7rCe8TCskGb79eAbsDeTbukn6WJx6Lpq1yWAe5BUILPO2FBT4mtTJ
	4GUv1sBtLqmSDD6ZunV0iV3Dzu2SpAAKU85RgGAQI/Sfvr07OlKx33mDSZB89rbk
	J1v07zUhckJcw2vhfGmKxGJa5RmWgg63Zs1BVhP7ScXydN9Kjgg8EX0Sie+UX5aA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386jy20e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 17:48:06 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AQHm5su009038;
	Tue, 26 Nov 2024 17:48:05 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386jy209-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 17:48:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQEkcwx027220;
	Tue, 26 Nov 2024 17:48:04 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 433ukj4tjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 17:48:04 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AQHm40U55837170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 17:48:04 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB8C258059;
	Tue, 26 Nov 2024 17:48:03 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 822F358043;
	Tue, 26 Nov 2024 17:47:59 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.177.21])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Nov 2024 17:47:59 +0000 (GMT)
Message-ID: <623f89b4de41ac14e0e48e106b846abc9e9d70cf.camel@linux.ibm.com>
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
In-Reply-To: <20241122.ahY1pooz1ing@digikod.net>
References: <20241112191858.162021-1-mic@digikod.net>
	 <20241112191858.162021-7-mic@digikod.net>
	 <d115a20889d01bc7b12dbd8cf99aad0be58cbc97.camel@linux.ibm.com>
	 <20241122.ahY1pooz1ing@digikod.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 26 Nov 2024 12:41:45 -0500
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _b6UFancxFPo-Mc2udQhYrK2rs1bE-Zs
X-Proofpoint-GUID: 5BPxwchR-GJDXOm4zLUufwuqPvRYVmxk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxlogscore=940 spamscore=0 suspectscore=0 phishscore=0 clxscore=1011
 mlxscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411260139

On Fri, 2024-11-22 at 15:50 +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> On Thu, Nov 21, 2024 at 03:34:47PM -0500, Mimi Zohar wrote:
> > Hi Micka=C3=ABl,
> >=20
> > On Tue, 2024-11-12 at 20:18 +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> > >=20
> > > +
> > > +/* Returns 1 on error, 0 otherwise. */
> > > +static int interpret_stream(FILE *script, char *const script_name,
> > > +			    char *const *const envp, const bool restrict_stream)
> > > +{
> > > +	int err;
> > > +	char *const script_argv[] =3D { script_name, NULL };
> > > +	char buf[128] =3D {};
> > > +	size_t buf_size =3D sizeof(buf);
> > > +
> > > +	/*
> > > +	 * We pass a valid argv and envp to the kernel to emulate a native
> > > +	 * script execution.  We must use the script file descriptor instea=
d of
> > > +	 * the script path name to avoid race conditions.
> > > +	 */
> > > +	err =3D execveat(fileno(script), "", script_argv, envp,
> > > +		       AT_EMPTY_PATH | AT_EXECVE_CHECK);
> >=20
> > At least with v20, the AT_CHECK always was being set, independent of wh=
ether
> > set-exec.c set it.  I'll re-test with v21.
>=20
> AT_EXECVE_CEHCK should always be set, only the interpretation of the
> result should be relative to securebits.  This is highlighted in the
> documentation.

Sure, that sounds correct.  With an IMA-appraisal policy, any unsigned scri=
pt
with the is_check flag set now emits an "cause=3DIMA-signature-required" au=
dit
message.  However since IMA-appraisal isn't enforcing file signatures, this
sounds wrong.

New audit messages like "IMA-signature-required-by-interpreter" and "IMA-
signature-not-required-by-interpreter" would need to be defined based on th=
e
SECBIT_EXEC_RESTRICT_FILE.


> >=20
> > > +	if (err && restrict_stream) {
> > > +		perror("ERROR: Script execution check");
> > > +		return 1;
> > > +	}
> > > +
> > > +	/* Reads script. */
> > > +	buf_size =3D fread(buf, 1, buf_size - 1, script);
> > > +	return interpret_buffer(buf, buf_size);
> > > +}
> > > +
> >=20
> >=20
>=20


