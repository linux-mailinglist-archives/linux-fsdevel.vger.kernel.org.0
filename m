Return-Path: <linux-fsdevel+bounces-23328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E421F92A9FB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 21:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940C21F227C3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 19:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A45114EC40;
	Mon,  8 Jul 2024 19:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pBxDm61h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581361BC39;
	Mon,  8 Jul 2024 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720467736; cv=none; b=jLV8Dr4RuaWW/YFssnER4sYOz5TeCokzJsGFNuZh6oyuGV4xsoaQNKpeMGdL58UOGX+ap6Eljr7vQJ3Aa6i4LI2myWvQU+41hvHMYCiapTCi95uuMM8l0EPvYlunQ4f2/nJLVXr4zO8yCFufYa5DDJOzlWYGYkraJd99++l/Kiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720467736; c=relaxed/simple;
	bh=K7u+BIAt2irHXEQT9sA7vjegBx9jTVp26WkqeZJFuWM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=W+E9XaVESm9Oe4ISDer3m3WWVejxapzo3fdL7bfMVwCKNi9udmTjoZxUELT7alzKpWqTXW+46svHlBZxXMIhtalF72+zmGn0yUpNT3RZKsIQTa+uNrrU+bOQzZXqMkKyUBcntkSED/VShQhoQY2DSBxtPikElYjM0Kok+dmCHyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pBxDm61h; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468HTFap022414;
	Mon, 8 Jul 2024 19:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=pp1; bh=
	PI6ioTZxN04v0o4ledQDCL/DhPKUMfb+Yex2f/zaul8=; b=pBxDm61hkqLjxCJk
	JASTnWQtzszY0tjxylrO0PcfEt+PMQ5sSK+JqVvg5adHJQm5HkDYcCGubdZr34XZ
	5YO6B/LmRQ1WVrV1YAmkuTuGb+ud5nlso6xkVkpRQTB2WnHHB8wLMVcoVySFjW9f
	fw3sGNH7dfELCRvRaSsWlI8uv/BbX3Ket//XxVLZE37rvk6VjO3tvZS8DwMjTvI2
	ZhZNY6NLaqFzv+FBwbdIId99I28788IYOolAvnxD8Zhqtzi3o27xbvEn68yCKMn9
	HgarhQX4h11doRgEmLu3sy1Dqy/qSU0MYWhoI7PUa92iAJL2FRvt/yzcXTAAm5ZC
	b5ddxg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 408mhu89mf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 19:40:52 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 468JepVb023152;
	Mon, 8 Jul 2024 19:40:51 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 408mhu89mb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 19:40:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 468GxfYc025952;
	Mon, 8 Jul 2024 19:40:50 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407hrmghn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 19:40:50 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 468JelrQ27591248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jul 2024 19:40:49 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27EA058059;
	Mon,  8 Jul 2024 19:40:47 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A8DE5805B;
	Mon,  8 Jul 2024 19:40:43 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.72.224])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jul 2024 19:40:43 +0000 (GMT)
Message-ID: <968619d912ee5a57aed6c73218221ef445a0766e.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v19 5/5] samples/should-exec: Add set-should-exec
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
Date: Mon, 08 Jul 2024 15:40:42 -0400
In-Reply-To: <20240704190137.696169-6-mic@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
	 <20240704190137.696169-6-mic@digikod.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-26.el8_10) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VO5yoT2dlibPVoAEHzj2-jvwByEHNf3c
X-Proofpoint-GUID: EkD-14ayMXpWdF4pXXJN3yYQbzTtIXSW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_10,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1011
 adultscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 mlxlogscore=886
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407080146

Hi Mickaël,

On Thu, 2024-07-04 at 21:01 +0200, Mickaël Salaün wrote:
> Add a simple tool to set SECBIT_SHOULD_EXEC_CHECK,
> SECBIT_SHOULD_EXEC_RESTRICT, and their lock counterparts before
> executing a command.  This should be useful to easily test against
> script interpreters.

The print_usage() provides the calling syntax.  Could you provide an example of
how to use it and what to expect?

thanks,

Mimi


