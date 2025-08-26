Return-Path: <linux-fsdevel+bounces-59186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B637B35C04
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 13:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DAC4362EC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 11:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C832BE7B2;
	Tue, 26 Aug 2025 11:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ZxBqKiQh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEF7284B5B
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207431; cv=none; b=W5hx3XpMm7u7b+7tFdLMKWeFmDHtn6hd+g4BBmuRKTX+001lu+KMqlQvdexDr+WY32iHthRcl3m1w6x95RLTEWiqHowoezmB9uiTDhQvxPTmwDM9ep7pj5eqCFoD6Lk0gGsK+3e8I7PRrkhl3l5c+SvT6rJnBPEngmqUj5RF1g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207431; c=relaxed/simple;
	bh=a3dONpQbijK8YoaZ/aqqUpqY1ZvBSwtSGl3/rVu/h0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDvqniflIRNOH8q5YTVHr1h6NjtWjf+7nNGY38fpPdXLh7VZbeffu8pvCeXEblNtrXohMx5m8dUMLiBzhnYMkYictCzw/UX+yq4D3KDOaOFV6HMGVbjRqW747aol8BtAeb2z8b4eL+QE7QxVtyanVddpUtMzz804xeCnu93nSk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ZxBqKiQh; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cB4zb5C65zhCD;
	Tue, 26 Aug 2025 13:23:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1756207419;
	bh=Rww2xVuKT9hbmIFkkD7HcWVeLL+qhFltg+bgWOSpLGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZxBqKiQhUv+Pvrrn1/2CQKD3XT1nzj3AUfxgSMhhQuZD50UOTb9HuJYeEW+zysahz
	 +B6JqT/YlnN76HwUPjid1Hasw1kpct8gdFLBml/o9qkdlCXMqGR5dSJkexYtSzgQgf
	 6aykxrpUeddHu6VCgD5BUhF6SSEa7sfB/s2j2q+w=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4cB4zX5hs0zYsS;
	Tue, 26 Aug 2025 13:23:36 +0200 (CEST)
Date: Tue, 26 Aug 2025 13:23:36 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>
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
Message-ID: <20250826.aig5aiShunga@digikod.net>
References: <20250822170800.2116980-1-mic@digikod.net>
 <20250826-skorpion-magma-141496988fdc@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250826-skorpion-magma-141496988fdc@brauner>
X-Infomaniak-Routing: alpha

On Tue, Aug 26, 2025 at 11:07:03AM +0200, Christian Brauner wrote:
> On Fri, Aug 22, 2025 at 07:07:58PM +0200, Mickaël Salaün wrote:
> > Hi,
> > 
> > Script interpreters can check if a file would be allowed to be executed
> > by the kernel using the new AT_EXECVE_CHECK flag. This approach works
> > well on systems with write-xor-execute policies, where scripts cannot
> > be modified by malicious processes. However, this protection may not be
> > available on more generic distributions.
> > 
> > The key difference between `./script.sh` and `sh script.sh` (when using
> > AT_EXECVE_CHECK) is that execve(2) prevents the script from being opened
> > for writing while it's being executed. To achieve parity, the kernel
> > should provide a mechanism for script interpreters to deny write access
> > during script interpretation. While interpreters can copy script content
> > into a buffer, a race condition remains possible after AT_EXECVE_CHECK.
> > 
> > This patch series introduces a new O_DENY_WRITE flag for use with
> > open*(2) and fcntl(2). Both interfaces are necessary since script
> > interpreters may receive either a file path or file descriptor. For
> > backward compatibility, open(2) with O_DENY_WRITE will not fail on
> > unsupported systems, while users requiring explicit support guarantees
> > can use openat2(2).
> 
> We've said no to abusing the O_* flag space for that AT_EXECVE_* stuff
> before and you've been told by Linus as well that this is a nogo.

Oh, please, don't mix up everything.  First, this is an RFC, and as I
explained, the goal is to start a discussion with something concrete.
Second, doing a one-time check on a file and providing guarantees for
the whole lifetime of an opened file requires different approaches,
hence this O_ *proposal*.

> 
> Nothing has changed in that regard and I'm not interested in stuffing
> the VFS APIs full of special-purpose behavior to work around the fact
> that this is work that needs to be done in userspace. Change the apps,
> stop pushing more and more cruft into the VFS that has no business
> there.

It would be interesting to know how to patch user space to get the same
guarantees...  Do you think I would propose a kernel patch otherwise?

> 
> That's before we get into all the issues that are introduced by this
> mechanism that magically makes arbitrary files unwritable. It's not just
> a DoS it's likely to cause breakage in userspace as well. I removed the
> deny-write from execve because it already breaks various use-cases or
> leads to spurious failures in e.g., go. We're not spreading this disease
> as a first-class VFS API.

Jann explained it very well, and the deny-write for execve is still
there, but let's keep it civil.  I already agreed that this is not a
good approach, but we could get interesting proposals.

