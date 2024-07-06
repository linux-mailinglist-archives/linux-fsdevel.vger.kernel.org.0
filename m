Return-Path: <linux-fsdevel+bounces-23261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA1B929495
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jul 2024 17:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A139E1C214C9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jul 2024 15:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C5613B588;
	Sat,  6 Jul 2024 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLccbOSA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E784C79
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jul 2024 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720279970; cv=none; b=WLnFkmFFsYxJdmVrICq+PdItY6lehtVYvoNJLDfHsxDmkFjg4xSQ+W4Yzl9I46cUQS+wB3yrRks07LZJ8S81ODcAML84JEcgZvAftRUwcpTcuzK8NER7O7GVrcP+tNkG6vkgjveOUu8M6OYi9III+h7km0a3uN6rQIemnjrfZMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720279970; c=relaxed/simple;
	bh=/7ENYiErekLpj6y4PtebCLgwC3sHbpeVxvHw0Fqh0GE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PpD/DWQRzDt0vV1nof3RNKJfVi8rBKoM5reJNVnx4vVjv+EU6+KBmGn05OM9Uk1yV6edgjJO7TytEL0J6R1MAYf+KB5Y+Z4Xh1s0e2ScCM68lUgC2v42JAMbA411HgE/5NvXzKNggqJQ87x8O4nQYzeEYf1TNfJeao5+W7EfbcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eLccbOSA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720279967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oBRFKUriB/1HZETMXeJgCSmmjgsoAHSm5ov/S8Qilac=;
	b=eLccbOSAc0Gcsx6Ay04RQDptufXWoViHfBv2yCCT+taQR/2V5npNIzbPekl2xvBVAMoa6F
	/rR/8wLlFkVxpC+Sr5D174mYbZe6LgfFhxZFy4JlpORIhDarC6Vydsl2VO0G2jF/23yMV3
	oiyUUOHPUm9w3MMb2j6LO4i2YLmW1FU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-QvlzTIlEODCCaBeRXTNIIQ-1; Sat,
 06 Jul 2024 11:32:44 -0400
X-MC-Unique: QvlzTIlEODCCaBeRXTNIIQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB3A8196CDEF;
	Sat,  6 Jul 2024 15:32:35 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.45.224.6])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD0E819560B2;
	Sat,  6 Jul 2024 15:32:15 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Kees Cook <keescook@chromium.org>,  Linus Torvalds
 <torvalds@linux-foundation.org>,  Paul Moore <paul@paul-moore.com>,
  Theodore Ts'o <tytso@mit.edu>,  Alejandro Colomar <alx@kernel.org>,
  Aleksa Sarai <cyphar@cyphar.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Andy Lutomirski <luto@kernel.org>,  Arnd
 Bergmann <arnd@arndb.de>,  Casey Schaufler <casey@schaufler-ca.com>,
  Christian Heimes <christian@python.org>,  Dmitry Vyukov
 <dvyukov@google.com>,  Eric Biggers <ebiggers@kernel.org>,  Eric Chiang
 <ericchiang@google.com>,  Fan Wu <wufan@linux.microsoft.com>,  Geert
 Uytterhoeven <geert@linux-m68k.org>,  James Morris
 <jamorris@linux.microsoft.com>,  Jan Kara <jack@suse.cz>,  Jann Horn
 <jannh@google.com>,  Jeff Xu <jeffxu@google.com>,  Jonathan Corbet
 <corbet@lwn.net>,  Jordan R Abrahams <ajordanr@google.com>,  Lakshmi
 Ramasubramanian <nramas@linux.microsoft.com>,  Luca Boccassi
 <bluca@debian.org>,  Luis Chamberlain <mcgrof@kernel.org>,  "Madhavan T .
 Venkataraman" <madvenka@linux.microsoft.com>,  Matt Bobrowski
 <mattbobrowski@google.com>,  Matthew Garrett <mjg59@srcf.ucam.org>,
  Matthew Wilcox <willy@infradead.org>,  Miklos Szeredi
 <mszeredi@redhat.com>,  Mimi Zohar <zohar@linux.ibm.com>,  Nicolas
 Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,  Scott Shell
 <scottsh@microsoft.com>,  Shuah Khan <shuah@kernel.org>,  Stephen Rothwell
 <sfr@canb.auug.org.au>,  Steve Dower <steve.dower@python.org>,  Steve
 Grubb <sgrubb@redhat.com>,  Thibaut Sautereau
 <thibaut.sautereau@ssi.gouv.fr>,  Vincent Strubel
 <vincent.strubel@ssi.gouv.fr>,  Xiaoming Ni <nixiaoming@huawei.com>,  Yin
 Fengwei <fengwei.yin@intel.com>,  kernel-hardening@lists.openwall.com,
  linux-api@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  linux-integrity@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
In-Reply-To: <20240706.poo9ahd3La9b@digikod.net> (=?utf-8?Q?=22Micka=C3=AB?=
 =?utf-8?Q?l_Sala=C3=BCn=22's?= message
	of "Sat, 6 Jul 2024 16:55:51 +0200")
References: <20240704190137.696169-1-mic@digikod.net>
	<20240704190137.696169-2-mic@digikod.net>
	<87bk3bvhr1.fsf@oldenburg.str.redhat.com>
	<20240706.poo9ahd3La9b@digikod.net>
Date: Sat, 06 Jul 2024 17:32:12 +0200
Message-ID: <871q46bkoz.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

* Micka=C3=ABl Sala=C3=BCn:

> On Fri, Jul 05, 2024 at 08:03:14PM +0200, Florian Weimer wrote:
>> * Micka=C3=ABl Sala=C3=BCn:
>>=20
>> > Add a new AT_CHECK flag to execveat(2) to check if a file would be
>> > allowed for execution.  The main use case is for script interpreters a=
nd
>> > dynamic linkers to check execution permission according to the kernel's
>> > security policy. Another use case is to add context to access logs e.g=
.,
>> > which script (instead of interpreter) accessed a file.  As any
>> > executable code, scripts could also use this check [1].
>>=20
>> Some distributions no longer set executable bits on most shared objects,
>> which I assume would interfere with AT_CHECK probing for shared objects.
>
> A file without the execute permission is not considered as executable by
> the kernel.  The AT_CHECK flag doesn't change this semantic.  Please
> note that this is just a check, not a restriction.  See the next patch
> for the optional policy enforcement.
>
> Anyway, we need to define the policy, and for Linux this is done with
> the file permission bits.  So for systems willing to have a consistent
> execution policy, we need to rely on the same bits.

Yes, that makes complete sense.  I just wanted to point out the odd
interaction with the old binutils bug and the (sadly still current)
kernel bug.

>> Removing the executable bit is attractive because of a combination of
>> two bugs: a binutils wart which until recently always set the entry
>> point address in the ELF header to zero, and the kernel not checking for
>> a zero entry point (maybe in combination with an absent program
>> interpreter) and failing the execve with ELIBEXEC, instead of doing the
>> execve and then faulting at virtual address zero.  Removing the
>> executable bit is currently the only way to avoid these confusing
>> crashes, so I understand the temptation.
>
> Interesting.  Can you please point to the bug report and the fix?  I
> don't see any ELIBEXEC in the kernel.

The kernel hasn't been fixed yet.  I do think this should be fixed, so
that distributions can bring back the executable bit.

Thanks,
Florian


