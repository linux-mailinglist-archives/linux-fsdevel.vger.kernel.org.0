Return-Path: <linux-fsdevel+bounces-23441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9CB92C4CC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 22:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA1728200B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 20:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C6E1534F9;
	Tue,  9 Jul 2024 20:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="qBhszl/J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C731527B6
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 20:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557762; cv=none; b=O8RQlw9QVvVwtXy3IbKQWUYMrW3gKqAJFB5igRDMkuUyMjAyOdDm/0fWGvtWMiI9QLYmDYerOiAqT7WaV0WNZ+0VeosAef4ud8D2kV9HB9lmnzgmKFnT0iv7xnsDXn8ArUa3jMjylkrht13DQihCYLGhXpgV6xnM9gQsaH4hn5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557762; c=relaxed/simple;
	bh=4E6D9pAiCi2RY9ka7qkuscXPvLR3w0RSeZF0twwnVeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iO+7tSYzLjcP2FL4D6JjrPaNzpFz8bxNfcaGkQhYZ44y57EEwoUWr4R4nC9EAP6JvlAkeBsrpB+fDFfIbCu8nOI0mLfZoqxktQDVncaHS4ZkBc0G3QJngEdzRmjVtxfYhfJkOP2DQIMtbo42NQ0Wt1Fv3OptuwGVslJb48AC5BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=qBhszl/J; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WJXx35Qyfz5QY;
	Tue,  9 Jul 2024 22:42:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720557751;
	bh=zJhS7of/CAzAVW6Q59+RaHwwypnLdu6BBXvJ+or8B1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qBhszl/JKbeRElfW9FNgl6e0YtKN0eXAABvDYpCkPxvHKO6FYUnOCU+NSyU5Vk/Bq
	 SKoFzFVP5RewPlBZEWP6/sCwGbLP4G82aZve9Pz856jfAr3qWb074ap4csT0oj6F8o
	 0B/tm4NzPlpNRodzi04GFH2QnJGO/DLLZ89Tjhng=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WJXx16BPRz22D;
	Tue,  9 Jul 2024 22:42:29 +0200 (CEST)
Date: Tue, 9 Jul 2024 22:42:26 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Florian Weimer <fweimer@redhat.com>
Cc: Jeff Xu <jeffxu@google.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Paul Moore <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>, 
	Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, James Morris <jamorris@linux.microsoft.com>, 
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Scott Shell <scottsh@microsoft.com>, 
	Shuah Khan <shuah@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, Vincent Strubel <vincent.strubel@ssi.gouv.fr>, 
	Xiaoming Ni <nixiaoming@huawei.com>, Yin Fengwei <fengwei.yin@intel.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
Message-ID: <20240709.aa5ahChoo7No@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-2-mic@digikod.net>
 <87bk3bvhr1.fsf@oldenburg.str.redhat.com>
 <CALmYWFu_JFyuwYhDtEDWxEob8JHFSoyx_SCcsRVKqSYyyw30Rg@mail.gmail.com>
 <87ed83etpk.fsf@oldenburg.str.redhat.com>
 <CALmYWFvkUnevm=npBeaZVkK_PXm=A8MjgxFXkASnERxoMyhYBg@mail.gmail.com>
 <87r0c3dc1c.fsf@oldenburg.str.redhat.com>
 <CALmYWFvA7VPz06Tg8E-R_Jqn2cxMiWPPC6Vhy+vgqnofT0GELg@mail.gmail.com>
 <20240709.gae4cu4Aiv6s@digikod.net>
 <87ed82283l.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ed82283l.fsf@oldenburg.str.redhat.com>
X-Infomaniak-Routing: alpha

On Tue, Jul 09, 2024 at 12:05:50PM +0200, Florian Weimer wrote:
> * Mickaël Salaün:
> 
> >> > If we want to avoid that, we could have an agreed-upon error code which
> >> > the LSM can signal that it'll never fail AT_CHECK checks, so we only
> >> > have to perform the extra system call once.
> >
> > I'm not sure to follow.  Either we check executable code or we don't,
> > but it doesn't make sense to only check some parts (except for migration
> > of user space code in a system, which is one purpose of the securebits
> > added with the next patch).
> >
> > The idea with AT_CHECK is to unconditionnaly check executable right the
> > same way it is checked when a file is executed.  User space can decide
> > to check that or not according to its policy (i.e. securebits).
> 
> I meant it purely as a performance optimization, to skip future system
> calls if we know they won't provide any useful information for this
> process.  In the grand scheme of things, the extra system call probably
> does not matter because we already have to do costly things like mmap.

Indeed, the performance impact of execveat+AT_CHECK should be negligible
compared to everything else needed to interpret a script or spawn a
process.  Moreover, these checks should only be performed when
SECBIT_SHOULD_EXEC_CHECK is set for the caller.

