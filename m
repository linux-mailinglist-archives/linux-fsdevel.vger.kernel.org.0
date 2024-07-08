Return-Path: <linux-fsdevel+bounces-23303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEE492A748
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 18:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A574C2830A8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 16:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3558E146A83;
	Mon,  8 Jul 2024 16:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDkjuOGh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E306F1459F1
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jul 2024 16:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720455995; cv=none; b=ablG7fbwSJC9DBOM61ZzSCeAQQoCiruc4UbBs9848K0pBrLhXmo91DEnGfYx6bLbF1FHmefKi3fu6F39FHTxL8P48BsbfXdyrNVkbd5al3pQ076KEX1jD3izYBu1WiSW2G11mkbXhg4kCNvsoFC9/H61J8OjzVnvwPxKSIhDJ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720455995; c=relaxed/simple;
	bh=5VqajPkX4cR7Nm9pwm7v4IUn0y7FY5jYA7jJc8omRXQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VOVfFaz1rA6M3XV6IA5p4lgvLplqbAq0JfB1G1dSPVal1JWUeXklGa9iLHJtofHpGLv922Ovj6eqdK5xIhe6WnvnXDfqkKnHdC48id7ckW+tXvNJSDGV5Lb17lpPqNK+11dO9PTRVGfRvV6t3wQevbdxcR/tlY1dxhNFQQ5rhx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fDkjuOGh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720455992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J8+nyKJPtmYL3Q1Jw+NMTU5s3BULPLom/3c1fVXHWAY=;
	b=fDkjuOGhGQF4zkT5cRQyWW+zT3ilhXmI9IS9Sdce9v8wnIvZ7OXn91VLIJTLxA7Nfm8u/3
	MUtAbqUmrhRg/7WLOeJ0A75JEaEoAGjAW3eNt/txGMmeaxRNIu7mSAzJOSbWF68Qfm2XDS
	PmxlEPcYc2f2GRPLNNsCmyHgFUdk85M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-PTESLuptN-miLqEs4oSOeA-1; Mon,
 08 Jul 2024 12:26:29 -0400
X-MC-Unique: PTESLuptN-miLqEs4oSOeA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A493197702C;
	Mon,  8 Jul 2024 16:26:20 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.45.224.113])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 388F41955F3B;
	Mon,  8 Jul 2024 16:26:01 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Jeff Xu <jeffxu@google.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,  Al Viro
 <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Kees Cook
 <keescook@chromium.org>,  Linus Torvalds <torvalds@linux-foundation.org>,
  Paul Moore <paul@paul-moore.com>,  "Theodore Ts'o" <tytso@mit.edu>,
  Alejandro Colomar <alx.manpages@gmail.com>,  Aleksa Sarai
 <cyphar@cyphar.com>,  Andrew Morton <akpm@linux-foundation.org>,  Andy
 Lutomirski <luto@kernel.org>,  Arnd Bergmann <arnd@arndb.de>,  Casey
 Schaufler <casey@schaufler-ca.com>,  Christian Heimes
 <christian@python.org>,  Dmitry Vyukov <dvyukov@google.com>,  Eric Biggers
 <ebiggers@kernel.org>,  Eric Chiang <ericchiang@google.com>,  Fan Wu
 <wufan@linux.microsoft.com>,  Geert Uytterhoeven <geert@linux-m68k.org>,
  James Morris <jamorris@linux.microsoft.com>,  Jan Kara <jack@suse.cz>,
  Jann Horn <jannh@google.com>,  Jonathan Corbet <corbet@lwn.net>,  Jordan
 R Abrahams <ajordanr@google.com>,  Lakshmi Ramasubramanian
 <nramas@linux.microsoft.com>,  Luca Boccassi <bluca@debian.org>,  Luis
 Chamberlain <mcgrof@kernel.org>,  "Madhavan T . Venkataraman"
 <madvenka@linux.microsoft.com>,  Matt Bobrowski
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
In-Reply-To: <CALmYWFu_JFyuwYhDtEDWxEob8JHFSoyx_SCcsRVKqSYyyw30Rg@mail.gmail.com>
	(Jeff Xu's message of "Mon, 8 Jul 2024 09:08:29 -0700")
References: <20240704190137.696169-1-mic@digikod.net>
	<20240704190137.696169-2-mic@digikod.net>
	<87bk3bvhr1.fsf@oldenburg.str.redhat.com>
	<CALmYWFu_JFyuwYhDtEDWxEob8JHFSoyx_SCcsRVKqSYyyw30Rg@mail.gmail.com>
Date: Mon, 08 Jul 2024 18:25:59 +0200
Message-ID: <87ed83etpk.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

* Jeff Xu:

> Will dynamic linkers use the execveat(AT_CHECK) to check shared
> libraries too ?  or just the main executable itself.

I expect that dynamic linkers will have to do this for everything they
map.  Usually, that does not include the maim program, but this can
happen with explicit loader invocations (=E2=80=9Cld.so /bin/true=E2=80=9D).

Thanks,
Florian


