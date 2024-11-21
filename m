Return-Path: <linux-fsdevel+bounces-35381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B759D4705
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 05:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6641F22358
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 04:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10841B5ED6;
	Thu, 21 Nov 2024 04:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/F/h8kp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40BF849C;
	Thu, 21 Nov 2024 04:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732165089; cv=none; b=SfwP0BLx29a3cpOwSFpYKcSIuywEQflxIWQCTeGh/FCk+NEiHMbDuit65yH7K+pf1kbgFefu6Ul+rP1lfxJpBoYJmUB+UznO+B/cSfbdYNGE36o2DDaO3nPnQ4yFtpOp8e0w8f+oFatB/eSkc+DRG6svE8rkYV3FQTlQ4tLlpIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732165089; c=relaxed/simple;
	bh=c6rhhlX6C6sMwTixfQKzXMumtrvXwwsznHRKBDKr7Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrmBm8Ikbfj24/121+Y2tac/7i0H48w9H4CLo21o2NDZG7i+duA3zXZap2M8f8Bng7MRUyWmVr+GoxBsL9jnQA3FYncqCMWF37Q9RTemZa8wibHtVQDVsZkXTgaQVOCmJ0aDKysVe6Wvkt7bw70oSOrVoIRsDLt7pqIzqDHpUlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/F/h8kp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D2DC4CECC;
	Thu, 21 Nov 2024 04:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732165088;
	bh=c6rhhlX6C6sMwTixfQKzXMumtrvXwwsznHRKBDKr7Ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d/F/h8kpI5y0B4769xkdKZI2LxgM0Jw89F4MVGdHO6TXieDOYdmzkN6U24571GjP/
	 9H9nniomx9sYtTuqO2PYF7HfOzfDFrFT8NBo6oCkGT9ausiYJ9Cp9V63oJ5dyjzZ7e
	 yq/NK2BZDjQZ6lVnXcmZyEMeWYZyBxFfMT8xdRPJlb25KPFu/72V2MyQ7aLWmmBuwl
	 DTJgMraRNniSqErdLyhzfXOp9dQOljUwkvAtwZg0ByiuRcBdMVHHeQ96l7y0bYJRJO
	 ANthrsa/sYaTs85mVjfeCapW8UUId+0B1M7TWJI4kve3wX5c6u1TRDkRACS/cFNfw9
	 gWQepXlr3iNTg==
Date: Wed, 20 Nov 2024 20:58:04 -0800
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
	Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Steve Dower <steve.dower@python.org>,
	Steve Grubb <sgrubb@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
	Xiaoming Ni <nixiaoming@huawei.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v21 0/6] Script execution control (was O_MAYEXEC)
Message-ID: <202411202057.82850EDE@keescook>
References: <20241112191858.162021-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112191858.162021-1-mic@digikod.net>

On Tue, Nov 12, 2024 at 08:18:52PM +0100, Mickaël Salaün wrote:
> Kees, would you like to take this series in your tree?

Yeah, let's give it a shot for -next after the merge window is closed,
assuming review is clean.

-- 
Kees Cook

