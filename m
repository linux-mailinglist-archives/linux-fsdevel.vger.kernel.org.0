Return-Path: <linux-fsdevel+bounces-23314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D8592A88D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 20:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F7B1C2162F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 18:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1756149C64;
	Mon,  8 Jul 2024 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejsgE+8O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5B114372B
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jul 2024 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720461624; cv=none; b=BTAhZOUSHJRkhfZrkqO5Atjv8bL7iYWZtI6dPWvDAAhLqNHlma0Uk9dAw+8bv5tAy8nGLzaO4rMGsq1luEabXoggfafg/vEiKq4WoyTLM66dptm0nU34sRdoGBJih/svhcRCjOdawN0Lu89YPZd7k+1MpS72/wghn1Y7lyXhsnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720461624; c=relaxed/simple;
	bh=G2eT1PidgYA5S25gC19Hg0ZQz21aenhcmJENyToU1tw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P7UJlXHTdrE9Xcx0zMf4lsky57h1F6hWgKz/Z1Y/57DHWx7MzdNtGl0eIq2WqKiZ0AcMx4pr8pHQM3tPmQwRrLvEHMh27V6K+6gIeiOKNe7+4dPB2hd/4ynnLN0HSSwlVJ+d5hKktQ4xu6/nWq9BtooFnGdgba96a1G0TxIGQmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ejsgE+8O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720461621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ur8aidqR86eMlg5hVh3kQFIlHZgeTOY5AvM2A0WS6wI=;
	b=ejsgE+8OMHemnj+1hgQUswLn8SPzWIPj8P1r3/VUq14JN7jBMmLIVFYtUDsomlXx0LrVG0
	HIGQlA0ks3Nuj9+XLBqX5PW8MXegb9MoLUNPJUfDGZlG8ZtRrgtf8XRsn1nRye9uPqpoKn
	owCpk4S1ElxN6KG6E+cep+Yayrd4uX8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-BLTMqZN-MRiC1hCbXOT78Q-1; Mon,
 08 Jul 2024 14:00:17 -0400
X-MC-Unique: BLTMqZN-MRiC1hCbXOT78Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB5361956048;
	Mon,  8 Jul 2024 18:00:07 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.45.224.113])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A030B1955F40;
	Mon,  8 Jul 2024 17:59:48 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,  Al Viro
 <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Kees Cook
 <keescook@chromium.org>,  Linus Torvalds <torvalds@linux-foundation.org>,
  Paul Moore <paul@paul-moore.com>,  Theodore Ts'o <tytso@mit.edu>,
  Alejandro Colomar <alx@kernel.org>,  Aleksa Sarai <cyphar@cyphar.com>,
  Andrew Morton <akpm@linux-foundation.org>,  Andy Lutomirski
 <luto@kernel.org>,  Arnd Bergmann <arnd@arndb.de>,  Casey Schaufler
 <casey@schaufler-ca.com>,  Christian Heimes <christian@python.org>,
  Dmitry Vyukov <dvyukov@google.com>,  Eric Biggers <ebiggers@kernel.org>,
  Eric Chiang <ericchiang@google.com>,  Fan Wu <wufan@linux.microsoft.com>,
  Geert Uytterhoeven <geert@linux-m68k.org>,  James Morris
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
  linux-security-module@vger.kernel.org,  linux-mm@kvack.org
Subject: Re: [PATCH] binfmt_elf: Fail execution of shared objects with ELIBEXEC
In-Reply-To: <87cynn3hzv.fsf@email.froward.int.ebiederm.org> (Eric
	W. Biederman's message of "Mon, 08 Jul 2024 12:34:28 -0500")
References: <20240704190137.696169-1-mic@digikod.net>
	<20240704190137.696169-2-mic@digikod.net>
	<87bk3bvhr1.fsf@oldenburg.str.redhat.com>
	<20240706.poo9ahd3La9b@digikod.net>
	<871q46bkoz.fsf@oldenburg.str.redhat.com>
	<20240708.zooj9Miaties@digikod.net>
	<878qybet6t.fsf_-_@oldenburg.str.redhat.com>
	<87cynn3hzv.fsf@email.froward.int.ebiederm.org>
Date: Mon, 08 Jul 2024 19:59:45 +0200
Message-ID: <87msmrdasu.fsf@oldenburg.str.redhat.com>
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

* Eric W. Biederman:

> As written I find the logic of the patch confusing, and slightly wrong.
>
> The program header value e_entry is a virtual address, possibly adjusted
> by load_bias.  Which makes testing it against the file offset of a
> PT_LOAD segment wrong.  It needs to test against elf_ppnt->p_vaddr.

I think we need to test both against zero, or maybe invert the logic: if
something is mapped at virtual address zero that doesn't come from a
zero file offset, we disable the ELIBEXEC check.

> I think performing an early sanity check to avoid very confusing crashes
> seems sensible (as long as it is inexpensive).  This appears inexpensive
> enough that we don't care.  This code is also before begin_new_exec
> so it is early enough to be meaningful.

Yeah, it was quite confusing when it was after begin_new_exec because
the ELIBEXEC error is visible under strace, and then the SIGSEGV comes =E2=
=80=A6

> I think the check should simply test if e_entry is mapped.  So a range
> check please to see if e_entry falls in a PT_LOAD segment.

It's usually mapped even with e_entry =3D=3D0 because the ELF header is
loaded at virtual address zero for ET_DYN using the default linker flags
(and this is the case we care about).  With -z noseparate-code, it is
even mapped executable.

> Having code start at virtual address 0 is a perfectly fine semantically
> and might happen in embedded scenarios.

To keep supporting this case, we need to check that the ELF header is at
address zero, because we make a leap of faith and assume it's not really
executable even if it is mapped as such because due to its role in the
file format, it does not contain executable instructions.  That's why
the patch is focused on the ELF header.

I could remove all these checks and just return ELIBEXEC for a zero
entry point.  I think this is valid based on the ELF specification, but
it may have a backwards compatibility impact.

> The program header is not required to be mapped or be first, (AKA
> p_offset and p_vaddr can have a somewhat arbitrary relationship) so any
> mention of the program header in your logic seems confusing to me.

It's the ELF header.

> I think your basic structure will work.  Just the first check needs to
> check if e_entry is lands inside the virtual address of a PT_LOAD
> segment.  The second check should just be checking a variable to see if
> e_entry was inside any PT_LOAD segment, and there is no interpreter.

I think the range check doesn't help here.  Just checking p_vaddr for
zero in addition to p_offset should be sufficient.  If you agree, can
test and send an updated patch.

Thanks,
Florian


