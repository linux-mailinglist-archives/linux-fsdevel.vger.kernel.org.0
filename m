Return-Path: <linux-fsdevel+bounces-37754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F979F6E3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 20:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 523047A43C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 19:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D151FBE92;
	Wed, 18 Dec 2024 19:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrS9GVbw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3122A15530B;
	Wed, 18 Dec 2024 19:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734550321; cv=none; b=Cforrb8yDOdoFqQeXDPCnKXKg490q6jFb49wF0n1TZanpBWG7c6UBcBbjpNUEyntdql+sBNYLU4k1ZtM7yTrkjKwW8MspRj4hBSETzjeeRWxEmWDYGlA1/xsa2M2TWNb5tsZrAAKSIjs/qlP0FPHbMph5vXC99fgLvu+1I3SVVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734550321; c=relaxed/simple;
	bh=5CeZ881/QIu/+tp8SeJw9/wQUlMEM3dpMz0QhDTzzbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVGveSB0mEWN3DwGGYJ8CKbmsFRXLJ09chSQvVonIPFwVaz0E7qXEFSspCleEKpZKPseTs3MuTjy37crSbygrhrxHdT8r41V43OTfwji6VkszumtkX4kJuQdQI9S57LENigVSNjAJu7Nk/cPLV/X1bBmsyGc6YGHB3slxEMn7nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrS9GVbw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7DDC4CECD;
	Wed, 18 Dec 2024 19:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734550320;
	bh=5CeZ881/QIu/+tp8SeJw9/wQUlMEM3dpMz0QhDTzzbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IrS9GVbwNUon6LVz7PQVy2IHNsx/yaWq3ExoFtfZCmzo2+tTrJbrzJ0kEG7G28igx
	 EvnmRf0JiMvi2daodZgIar0xr9Hy99ukA1UeGvmx9RHtDiknlyJhKWbErJgWqsdlEf
	 DpPVaCHvvp6BmLzSjN0dmVZLKeSLxreH0rwI1OIsO2AknWEB6/z5+eQu6JCGrM+4a4
	 GPxw4sn/rsokoKBsuNuyDCCiHWar8DOPaxz1dUBIIYcckHkrzJFgGccGpz4HO3+h4m
	 wl8LqkpxDvdKinEbpdhPmdUZI4IZPPuZSD0esdKiPA3wioYSgyF3cnrv3sHX7jYyTE
	 Kkeo3HFW1dlBg==
Date: Wed, 18 Dec 2024 11:31:57 -0800
From: Kees Cook <kees@kernel.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Alejandro Colomar <alx@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Christian Heimes <christian@python.org>,
	Dmitry Vyukov <dvyukov@google.com>, Elliott Hughes <enh@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Eric Chiang <ericchiang@google.com>,
	Fan Wu <wufan@linux.microsoft.com>,
	Florian Weimer <fweimer@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	James Morris <jamorris@linux.microsoft.com>,
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Jordan R Abrahams <ajordanr@google.com>,
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Luca Boccassi <bluca@debian.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Steve Dower <steve.dower@python.org>,
	Steve Grubb <sgrubb@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
	Xiaoming Ni <nixiaoming@huawei.com>,
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v23 0/8] Script execution control (was O_MAYEXEC)
Message-ID: <202412181130.84A2FCF2@keescook>
References: <20241212174223.389435-1-mic@digikod.net>
 <20241218.aBaituy0veK7@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241218.aBaituy0veK7@digikod.net>

On Wed, Dec 18, 2024 at 11:40:59AM +0100, Mickaël Salaün wrote:
> In the meantime I've pushed it in my tree, it should appear in -next
> tomorrow.  Please, let me know when you take it, I'll remove it from my
> tree.

Thanks! Yeah, I was just finally getting through my email after my
pre-holiday holiday. ;)

I'll get this into my -next tree now.

-Kees

-- 
Kees Cook

