Return-Path: <linux-fsdevel+bounces-59178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B8CB35842
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 11:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA66B3604EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 09:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA36306D48;
	Tue, 26 Aug 2025 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6iE5Y5F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD23279798;
	Tue, 26 Aug 2025 09:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199234; cv=none; b=aX5xZVQS0Tbfcq7wItsoxfJLroUuQrd8P8ROMTLInSYg4nRqaY5u4O7fTgF+twxIeIWMYz1VkDkykpyF8ZlsGaQEy4eZxxTiD4O8CiS1xNF19lyQsI+kz3z8YcelBXWSnvmQj82Rson5newDmBbRaZrHWYiosLL8H0Sz/dCKwpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199234; c=relaxed/simple;
	bh=v1CSBcWHPbCnidtHdXODW6dfbip1NV8JwzZFOpqYkck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTVnxgcnsdIZal7DaTHMwLgqbPWmM7PAb4Npa08+clNbXGItVAdHskXXIU92zxl9eIZlSi1QFt7xERcr49daad4vAkl1Up2ZraHXgd/TP/oPGDCm1pBhMT2bbkI9gBIrQ1l9sWwdBIiOdoaelh8XkWaUHD5ChJwwTkA8crISVnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6iE5Y5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14EB8C4CEF1;
	Tue, 26 Aug 2025 09:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756199234;
	bh=v1CSBcWHPbCnidtHdXODW6dfbip1NV8JwzZFOpqYkck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s6iE5Y5FkD/yXMMiE/ghxcC3Oi9Yjk1XRIAqRYCNYsanV38XhW0i9eYf/To0VJW2o
	 WYQ/ZuC/nsgerBNGvoSmbNWxd920UR2TtKpnCWfGJ0ya5JFfJedNtTwBQQPmb8U4h4
	 BseIkK0ylDIqzI7SCwbyNOd9sNya7tC+6HO9HPjMmmQbOnK+zruIPEca3JrwtTdrNe
	 oRTWtlPucmsV8c2at+UAsG81IyPSE2bfpHKs4HQe1qvcsLoiG+/mf1P9GeBoVj6YSx
	 uaWFXu4OYAr72+8s0T/DoofNbBohK7R7cRZZj7Z1UVMUlyI61q+NGofFGEoEaZ13OJ
	 F3tqSNVCLSKcg==
Date: Tue, 26 Aug 2025 11:07:03 +0200
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <keescook@chromium.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Elliott Hughes <enh@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jordan R Abrahams <ajordanr@google.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Luca Boccassi <bluca@debian.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Robert Waite <rowait@microsoft.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Scott Shell <scottsh@microsoft.com>, Steve Dower <steve.dower@python.org>, 
	Steve Grubb <sgrubb@redhat.com>, kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/2] Add O_DENY_WRITE (complement AT_EXECVE_CHECK)
Message-ID: <20250826-skorpion-magma-141496988fdc@brauner>
References: <20250822170800.2116980-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250822170800.2116980-1-mic@digikod.net>

On Fri, Aug 22, 2025 at 07:07:58PM +0200, Mickaël Salaün wrote:
> Hi,
> 
> Script interpreters can check if a file would be allowed to be executed
> by the kernel using the new AT_EXECVE_CHECK flag. This approach works
> well on systems with write-xor-execute policies, where scripts cannot
> be modified by malicious processes. However, this protection may not be
> available on more generic distributions.
> 
> The key difference between `./script.sh` and `sh script.sh` (when using
> AT_EXECVE_CHECK) is that execve(2) prevents the script from being opened
> for writing while it's being executed. To achieve parity, the kernel
> should provide a mechanism for script interpreters to deny write access
> during script interpretation. While interpreters can copy script content
> into a buffer, a race condition remains possible after AT_EXECVE_CHECK.
> 
> This patch series introduces a new O_DENY_WRITE flag for use with
> open*(2) and fcntl(2). Both interfaces are necessary since script
> interpreters may receive either a file path or file descriptor. For
> backward compatibility, open(2) with O_DENY_WRITE will not fail on
> unsupported systems, while users requiring explicit support guarantees
> can use openat2(2).

We've said no to abusing the O_* flag space for that AT_EXECVE_* stuff
before and you've been told by Linus as well that this is a nogo.

Nothing has changed in that regard and I'm not interested in stuffing
the VFS APIs full of special-purpose behavior to work around the fact
that this is work that needs to be done in userspace. Change the apps,
stop pushing more and more cruft into the VFS that has no business
there.

That's before we get into all the issues that are introduced by this
mechanism that magically makes arbitrary files unwritable. It's not just
a DoS it's likely to cause breakage in userspace as well. I removed the
deny-write from execve because it already breaks various use-cases or
leads to spurious failures in e.g., go. We're not spreading this disease
as a first-class VFS API.

