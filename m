Return-Path: <linux-fsdevel+bounces-23329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F075F92AAAD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 22:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7214C1F21414
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 20:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9A514C5B8;
	Mon,  8 Jul 2024 20:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GJxdClp3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4323A29;
	Mon,  8 Jul 2024 20:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720471038; cv=none; b=fpUziBePc9yu3gDQl5B+956pBKlIInJNG1cC/nJUuxx3AVfd3LzHx+83TaEtVF0J+tADQ2esrLaW/N0vxx5Nu1OBbeOEH+s+R3gO8l/DoebXSSyjV7z0fQ3om7s0eDlQqHCiful7siEpaSuj3nbScPYWWWo5ZixnPRVBuiY6UgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720471038; c=relaxed/simple;
	bh=JTpsJ4BLsqwl1tMAbcghItB5dY+DDbryHsbxbYy99ew=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DOmAeS1Rg3f+37XRHouVOKtaqzRPauH84Lrp5+sPQu8XUHvVvVfDiK76b2bHFSHznUitvIPCKQ5NMGLfbix1+EvGZKgm4FlGYnSV1tA0Mw2iu/ShbcexDXy+yOeTz8lJzk0fJFbruSPKOEGTJmIJ2E0cFvIRZq5QKNdFB3bMNK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GJxdClp3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468GSgar022732;
	Mon, 8 Jul 2024 20:35:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	CxgxLsMfcgEUGG2AWRuuw2fi5FzNeGA6j6CPtR3F6bc=; b=GJxdClp3WxyMXnqE
	bBREpQh9CN6I51cP+LBGgngbCtNdpuo13librI+ftvNXrMdPGc75VePQ5Y3hlSGM
	sYJNjvaSz5CblUOF+jyeefhrB3UOaZWNLZznFo1Ym4hAodwaU2yFFB50VUOyeVMx
	SG8YeeTPwpoBaL1uA1rDZtrxp57/XGQFEkL+Wvx5VaW7sArZku7RsphqCEbZ+2Uj
	SoEWNlA73iM+/kwaFLfGT4a0dgayWX+liRqMp8bYHnGH/nKSHICTGOAHgOQBqtK5
	kofUhF9jTVpxBiCinq3Yox6wOYsYLHWROqqgjcVpIwHp9Md5V9FA5A4MLUbVXWdg
	XtzGwA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 408knm0jhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 20:35:49 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 468KZmVD010338;
	Mon, 8 Jul 2024 20:35:48 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 408knm0jhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 20:35:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 468JjYcX013901;
	Mon, 8 Jul 2024 20:35:46 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407gn0h1pd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 20:35:46 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 468KZhOE54133212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jul 2024 20:35:45 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73C7F5804B;
	Mon,  8 Jul 2024 20:35:43 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BA115805B;
	Mon,  8 Jul 2024 20:35:39 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.72.224])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jul 2024 20:35:39 +0000 (GMT)
Message-ID: <55b4f6291e8d83d420c7d08f4233b3d304ce683d.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v19 0/5] Script execution control (was O_MAYEXEC)
From: Mimi Zohar <zohar@linux.ibm.com>
To: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Al Viro
 <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Kees
 Cook <keescook@chromium.org>,
        Linus Torvalds
 <torvalds@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>, "Theodore Ts'o" <tytso@mit.edu>
Cc: Alejandro Colomar <alx.manpages@gmail.com>,
        Aleksa Sarai
 <cyphar@cyphar.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy
 Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Casey
 Schaufler <casey@schaufler-ca.com>,
        Christian Heimes
 <christian@python.org>,
        Dmitry Vyukov <dvyukov@google.com>,
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
        Luca Boccassi
 <bluca@debian.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Madhavan T .
 Venkataraman" <madvenka@linux.microsoft.com>,
        Matt Bobrowski
 <mattbobrowski@google.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew
 Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas
 Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
        Scott Shell
 <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell
 <sfr@canb.auug.org.au>,
        Steve Dower <steve.dower@python.org>, Steve Grubb
 <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Xiaoming Ni
 <nixiaoming@huawei.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Date: Mon, 08 Jul 2024 16:35:38 -0400
In-Reply-To: <20240704190137.696169-1-mic@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-26.el8_10) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xfgBL0ZavfhoiN98qDf8nNW4jFF4_Skx
X-Proofpoint-ORIG-GUID: 0zv7xLsYvghyVjWtpLVEhBOkEbPIHn4V
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_11,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407080151

Hi Mickaël,

On Thu, 2024-07-04 at 21:01 +0200, Mickaël Salaün wrote:
> Hi,
> 
> The ultimate goal of this patch series is to be able to ensure that
> direct file execution (e.g. ./script.sh) and indirect file execution
> (e.g. sh script.sh) lead to the same result, especially from a security
> point of view.
> 
> Overview
> --------
> 
> This patch series is a new approach of the initial O_MAYEXEC feature,
> and a revamp of the previous patch series.  Taking into account the last
> reviews [1], we now stick to the kernel semantic for file executability.
> One major change is the clear split between access check and policy
> management.
> 
> The first patch brings the AT_CHECK flag to execveat(2).  The goal is to
> enable user space to check if a file could be executed (by the kernel).
> Unlike stat(2) that only checks file permissions, execveat2(2) +
> AT_CHECK take into account the full context, including mount points
> (noexec), caller's limits, and all potential LSM extra checks (e.g.
> argv, envp, credentials).
> 
> The second patch brings two new securebits used to set or get a security
> policy for a set of processes.  For this to be meaningful, all
> executable code needs to be trusted.  In practice, this means that
> (malicious) users can be restricted to only run scripts provided (and
> trusted) by the system.
> 
> [1] https://lore.kernel.org/r/CAHk-=wjPGNLyzeBMWdQu+kUdQLHQugznwY7CvWjmvNW47D5sog@mail.gmail.com
> 
> Script execution
> ----------------
> 
> One important thing to keep in mind is that the goal of this patch
> series is to get the same security restrictions with these commands:
> * ./script.py
> * python script.py
> * python < script.py
> * python -m script.pyT

This is really needed, but is it the "only" purpose of this patch set or can it
be used to also monitor files the script opens (for read) with the intention of
executing.

> 
> However, on secure systems, we should be able to forbid these commands
> because there is no way to reliably identify the origin of the script:
> * xargs -a script.py -d '\r' -- python -c
> * cat script.py | python
> * python
> 
> Background
> ----------
> 
> Compared to the previous patch series, there is no more dedicated
> syscall nor sysctl configuration.  This new patch series only add new
> flags: one for execveat(2) and four for prctl(2).
> 
> This kind of script interpreter restriction may already be used in
> hardened systems, which may need to fork interpreters and install
> different versions of the binaries.  This mechanism should enable to
> avoid the use of duplicate binaries (and potential forked source code)
> for secure interpreters (e.g. secure Python [2]) by making it possible
> to dynamically enforce restrictions or not.
> 
> The ability to control script execution is also required to close a
> major IMA measurement/appraisal interpreter integrity [3].

Definitely.  But it isn't limited to controlling script execution, but also
measuring the script.  Will it be possible to measure and appraise the indirect
script calls with this patch set?

Mimi

> This new execveat + AT_CHECK should not be confused with the O_EXEC flag
> (for open) which is intended for execute-only, which obviously doesn't
> work for scripts.
> 
> I gave a talk about controlling script execution where I explain the
> previous approaches [4].  The design of the WIP RFC I talked about
> changed quite a bit since then.
> 
> [2] https://github.com/zooba/spython
> [3] https://lore.kernel.org/lkml/20211014130125.6991-1-zohar@linux.ibm.com/
> [4] https://lssna2023.sched.com/event/1K7bO
> 


