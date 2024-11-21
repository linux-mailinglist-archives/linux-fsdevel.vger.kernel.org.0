Return-Path: <linux-fsdevel+bounces-35480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A1B9D540B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 21:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44411F22FAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 20:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B1A1D0E10;
	Thu, 21 Nov 2024 20:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FLFIZr1r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABF33C47B;
	Thu, 21 Nov 2024 20:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732221369; cv=none; b=TvTeArzGxqDdHq2o2QKoEmzupryI76NF0ufuwtygPy1uI3RnSYBAkZgeVACbceJ05d7aAnKB8O28raZdCanfnX+8FOyzFRAJao81kYa4hYT7GedY4jzwhm7FQoZZPUoXEoQzQmcanQgFrAu4RbNhpge/rjQfnM47gP6Bd6bNjjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732221369; c=relaxed/simple;
	bh=7Vq/O7M/rpQ/XvxNyaS3o9CEOAPJiin0cbjFnC1hENc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hut4soXcwm7yWRFgY1m+3KvXbQp0gh0eSkXdFq+RePOLhe6tJ6xqKbMCrTfKL2oUrbf7fw/21lkG6PIGadbfhpT50O/RQK7wKLnl2khKtRmlE2xJE9faWrCONfSoazcE6oQi+kU70ZVXKXUVkwILThS4V5HpOQTH2rl4IorUUh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FLFIZr1r; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALGfAQH013558;
	Thu, 21 Nov 2024 20:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rlelLu
	NxaQbOjS+AkBlNiz3aAj7rJ3O71jw+IWqCHcY=; b=FLFIZr1rr1BmrgPgUxiG3g
	Sn9cNjYHRsSVYuOrafvD0Oas8M5sJR3icX2DR4H+Ij8pW1K/nJ1dQ80N/VTGAfJb
	gUzKG2pWPH6ZwcS7EP/V5A85Z803GnU1c+1Pj0XfDxOkcnQU020QCLahQT6i/1Ee
	anToxEuakKvgsE2qEjn6OwHJRSEGLWzplZjyqgcyR2KALhJ6iuST4Ap9niIrbXek
	lmSmFnHLYvZxf1hDcNh3nvmSH52GrdPBsfQ2FxMXHw5I/46RlnCZt2b3PBSYYnkh
	WU2kJJDaY/8gGcEnFFq9zO4Zjz7tEFINhYu22GZYGE5uf9G8uY71LM5QXTQvt1xw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4313gsufwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 20:34:53 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4ALKYqu6024816;
	Thu, 21 Nov 2024 20:34:52 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4313gsufwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 20:34:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALIpcBI000600;
	Thu, 21 Nov 2024 20:34:51 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y77mtd41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 20:34:51 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ALKYoDo57147782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 20:34:50 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FB2C58056;
	Thu, 21 Nov 2024 20:34:50 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C34A358052;
	Thu, 21 Nov 2024 20:34:47 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.103.152])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Nov 2024 20:34:47 +0000 (GMT)
Message-ID: <d115a20889d01bc7b12dbd8cf99aad0be58cbc97.camel@linux.ibm.com>
Subject: Re: [PATCH v21 6/6] samples/check-exec: Add an enlighten "inc"
 interpreter and 28 tests
From: Mimi Zohar <zohar@linux.ibm.com>
To: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Al Viro
 <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Kees
 Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>,
        Serge
 Hallyn <serge@hallyn.com>
Cc: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Alejandro
 Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
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
Date: Thu, 21 Nov 2024 15:34:47 -0500
In-Reply-To: <20241112191858.162021-7-mic@digikod.net>
References: <20241112191858.162021-1-mic@digikod.net>
	 <20241112191858.162021-7-mic@digikod.net>
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
X-Proofpoint-GUID: 5j4NljDjvOK_TMG_-0z2jGGIPzeoKdQE
X-Proofpoint-ORIG-GUID: y_4dWfxzFvg9Bphre9Ic1A5QOC1Kd_4I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 adultscore=0 mlxlogscore=977 mlxscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411210153

Hi Micka=C3=ABl,

On Tue, 2024-11-12 at 20:18 +0100, Micka=C3=ABl Sala=C3=BCn wrote:
>=20
> +
> +/* Returns 1 on error, 0 otherwise. */
> +static int interpret_stream(FILE *script, char *const script_name,
> +			    char *const *const envp, const bool restrict_stream)
> +{
> +	int err;
> +	char *const script_argv[] =3D { script_name, NULL };
> +	char buf[128] =3D {};
> +	size_t buf_size =3D sizeof(buf);
> +
> +	/*
> +	 * We pass a valid argv and envp to the kernel to emulate a native
> +	 * script execution.  We must use the script file descriptor instead of
> +	 * the script path name to avoid race conditions.
> +	 */
> +	err =3D execveat(fileno(script), "", script_argv, envp,
> +		       AT_EMPTY_PATH | AT_EXECVE_CHECK);

At least with v20, the AT_CHECK always was being set, independent of whethe=
r
set-exec.c set it.  I'll re-test with v21.

thanks,

Mimi

> +	if (err && restrict_stream) {
> +		perror("ERROR: Script execution check");
> +		return 1;
> +	}
> +
> +	/* Reads script. */
> +	buf_size =3D fread(buf, 1, buf_size - 1, script);
> +	return interpret_buffer(buf, buf_size);
> +}
> +


