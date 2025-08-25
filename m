Return-Path: <linux-fsdevel+bounces-58990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90645B33B45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 11:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E6A1767F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 09:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B557F2C325B;
	Mon, 25 Aug 2025 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXDywxRy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A230A26C3BF
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756114779; cv=none; b=o07CppVtky0/TSsAxcuH1YNMOjO6rBrBj5a9o49bz2dqQ7KbycVyTrqLDJRqcOtgXphnQA1lvyMjMcuUToydE8X5coV32mOcSOlxHZiPMBa10+x7VhdeW8rn22MHDj97d/2AxDOEvpbUNhLO4avMF1F5r/EVDjaZSdqJRaen/Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756114779; c=relaxed/simple;
	bh=YGZk/doqSOcdaAjiIfjwSjHMKZj2laCWPqcCdAbOjKw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r3ZnX8baZ1VeNJilSpgJ2GfdypxjgTmpEqq2VgAJyPBhT4em7Xu3xsTm1dTkkUbO6STYDINaRHJagcp9bX6UswGswfXc4gclGunNuEZCZUdzUI6F6raN04kO0jrD/lAs+chW63G/FA8HKwPNhHWZtVqKXEG1/BVn14Uqw95BxYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JXDywxRy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756114776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SEwlDpD+C/EtRZv27QcaLtBUwUyBdktuJKWqODYJttI=;
	b=JXDywxRywGznF1GQrDvy9gQ7DKQj/wTHOoPYxu7GNVycp84+IKCe3tWITHlhBXnRK2soqU
	59Mrs9PETFiDmKxPGlwddj2STMga27wm1uUUVFQx9J0R50w1V+zlYRHg1iRkRSnAWpJ4iO
	lwhzSdR1WWokeiU2G9PySAxCyySXmJ0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-mnd5_XyLMPSzPB5s5xNMDA-1; Mon,
 25 Aug 2025 05:39:31 -0400
X-MC-Unique: mnd5_XyLMPSzPB5s5xNMDA-1
X-Mimecast-MFC-AGG-ID: mnd5_XyLMPSzPB5s5xNMDA_1756114767
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B2091800342;
	Mon, 25 Aug 2025 09:39:26 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.136])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D31AF1955F24;
	Mon, 25 Aug 2025 09:39:14 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Andy Lutomirski <luto@amacapital.net>,  Jann Horn <jannh@google.com>,
  Al Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Kees Cook <keescook@chromium.org>,  Paul Moore
 <paul@paul-moore.com>,  Serge Hallyn <serge@hallyn.com>,  Andy Lutomirski
 <luto@kernel.org>,  Arnd Bergmann <arnd@arndb.de>,  Christian Heimes
 <christian@python.org>,  Dmitry Vyukov <dvyukov@google.com>,  Elliott
 Hughes <enh@google.com>,  Fan Wu <wufan@linux.microsoft.com>,  Jeff Xu
 <jeffxu@google.com>,  Jonathan Corbet <corbet@lwn.net>,  Jordan R Abrahams
 <ajordanr@google.com>,  Lakshmi Ramasubramanian
 <nramas@linux.microsoft.com>,  Luca Boccassi <bluca@debian.org>,  Matt
 Bobrowski <mattbobrowski@google.com>,  Miklos Szeredi
 <mszeredi@redhat.com>,  Mimi Zohar <zohar@linux.ibm.com>,  Nicolas
 Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,  Robert Waite
 <rowait@microsoft.com>,  Roberto Sassu <roberto.sassu@huawei.com>,  Scott
 Shell <scottsh@microsoft.com>,  Steve Dower <steve.dower@python.org>,
  Steve Grubb <sgrubb@redhat.com>,  kernel-hardening@lists.openwall.com,
  linux-api@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  linux-integrity@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-security-module@vger.kernel.org,  Jeff Xu <jeffxu@chromium.org>
Subject: Re: [RFC PATCH v1 1/2] fs: Add O_DENY_WRITE
In-Reply-To: <20250825.mahNeel0dohz@digikod.net> (=?utf-8?Q?=22Micka=C3=AB?=
 =?utf-8?Q?l_Sala=C3=BCn=22's?= message
	of "Mon, 25 Aug 2025 11:31:42 +0200")
References: <20250822170800.2116980-1-mic@digikod.net>
	<20250822170800.2116980-2-mic@digikod.net>
	<CAG48ez1XjUdcFztc_pF2qcoLi7xvfpJ224Ypc=FoGi-Px-qyZw@mail.gmail.com>
	<20250824.Ujoh8unahy5a@digikod.net>
	<CALCETrWwd90qQ3U2nZg9Fhye6CMQ6ZF20oQ4ME6BoyrFd0t88Q@mail.gmail.com>
	<20250825.mahNeel0dohz@digikod.net>
Date: Mon, 25 Aug 2025 11:39:11 +0200
Message-ID: <lhuikibbv0g.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

* Micka=C3=ABl Sala=C3=BCn:

> The order of checks would be:
> 1. open script with O_DENY_WRITE
> 2. check executability with AT_EXECVE_CHECK
> 3. read the content and interpret it
>
> The deny-write feature was to guarantee that there is no race condition
> between step 2 and 3.  All these checks are supposed to be done by a
> trusted interpreter (which is allowed to be executed).  The
> AT_EXECVE_CHECK call enables the caller to know if the kernel (and
> associated security policies) allowed the *current* content of the file
> to be executed.  Whatever happen before or after that (wrt.
> O_DENY_WRITE) should be covered by the security policy.

Why isn't it an improper system configuration if the script file is
writable?

In the past, the argument was that making a file (writable and)
executable was an auditable even, and that provided enough coverage for
those people who are interested in this.

Thanks,
Florian


