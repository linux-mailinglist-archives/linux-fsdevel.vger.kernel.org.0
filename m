Return-Path: <linux-fsdevel+bounces-23715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E681931BA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 22:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00891C21B68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 20:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5B813AD2B;
	Mon, 15 Jul 2024 20:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="DA6RQIEo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7931758F;
	Mon, 15 Jul 2024 20:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721074605; cv=none; b=kByoMNdAeSmwDyQ3bIkwWpEGgiGKH+2Kos0B1TrqUfmAP/ngt0UETDnCprdL96/SQQiF1ql02S+FuWb9BWu1onVJlagSwo7oVnSWsFr045UhEBQDcN/bDa7iUqltfbbCvz0yfwiy2+wuHpM46RrY5yycE6h1tD5q1HcEA0tCVQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721074605; c=relaxed/simple;
	bh=qCiGfPB1gQ4jS9TNROTwe/253cFlMSCfdlMQaOpPpXM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dZG3j1ZGEOhODPYVz7LTQTFURdxw3/7tUYRqXXQTBdN22iGmAToRQ7v+x3HGlNTWY5zOHzRnLTGXcKLlmBfvzbErAqk5Z59RemCEt8FZs/mADtZ9MddcQbwHniZlYbvAiv/JYk9vHoCpYsL9O7qfllU0XsKwo8lvl0pCPiAbh1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=DA6RQIEo; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9853A418A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1721074602; bh=qCiGfPB1gQ4jS9TNROTwe/253cFlMSCfdlMQaOpPpXM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DA6RQIEoFFqTWCYbIUWlOKjxmMchd8JstjU1istskyz4wucCTn63QQ1d7WEP9c3N9
	 +uEJiE6NiSQkuIb7A3ybtn/rknSK6559U6x13uhxdkKJ1B40Q7W34CmCjLRNunemQo
	 a2Q6Ij+XN8nAooXYLvFjGy9eLfwOoNCiDakxWij2+n71YbXXa6SEFoI4G5d3kPVxRw
	 LoZgUcOz/BMK7U8TipaVGz7RLHFUB9TAruatbX18ydU7GbsFbC9yGzABG+Dm3+4wPf
	 zWNcR5eToI69Wtncggp6gkWWPGltQFDkucVVEExkDb4c6zJcyWD4zzxMWI/XXgxXBM
	 xtHjVPv2/osKQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9853A418A2;
	Mon, 15 Jul 2024 20:16:42 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, Al Viro
 <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Paul Moore
 <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, Alejandro
 Colomar
 <alx.manpages@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, Andrew Morton
 <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Casey Schaufler <casey@schaufler-ca.com>,
 Christian Heimes <christian@python.org>, Dmitry Vyukov
 <dvyukov@google.com>, Eric Biggers <ebiggers@kernel.org>, Eric Chiang
 <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, Florian
 Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, Jann
 Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jordan R Abrahams
 <ajordanr@google.com>, Lakshmi Ramasubramanian
 <nramas@linux.microsoft.com>, Luca Boccassi <bluca@debian.org>, Luis
 Chamberlain <mcgrof@kernel.org>, "Madhavan T . Venkataraman"
 <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>,
 Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox
 <willy@infradead.org>, Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar
 <zohar@linux.ibm.com>, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
 Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Steve Dower
 <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, Thibaut
 Sautereau <thibaut.sautereau@ssi.gouv.fr>, Vincent Strubel
 <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, Yin
 Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com,
 linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v19 0/5] Script execution control (was O_MAYEXEC)
In-Reply-To: <20240704190137.696169-1-mic@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
Date: Mon, 15 Jul 2024 14:16:41 -0600
Message-ID: <8734oawguu.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> writes:

FYI:

> User space patches can be found here:
> https://github.com/clipos-archive/clipos4_portage-overlay/search?q=3DO_MA=
YEXEC

That link appears to be broken.

Thanks,

jon

