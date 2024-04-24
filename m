Return-Path: <linux-fsdevel+bounces-17651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7438B0F67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 18:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA66C1C20932
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 16:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14978161310;
	Wed, 24 Apr 2024 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOnJkNb7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC3015FCE1;
	Wed, 24 Apr 2024 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974992; cv=none; b=LYB8IBJldO5pJumsN+LW3gsOGWOcecb0Z1AG8fEyB1Idko09K/pfeuIiqy+77C1GY2vMvetGGkbxfnMzFmaV4OsA7U8vQk+fqLmw+WoALCHHnAUeN18seLog+fjudzgCJluhpgcbNCM/kdFWUTNUhM+/1x9N6Ynz6HAB4vIHBAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974992; c=relaxed/simple;
	bh=vtglwBCGL+0puqiFJlOQ5BXPiuyd/55Dv6QNeAzciuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwsMIt8aF2rZAvflGUxvnK9HXJWehKBHrRHTsnEGjH5ttYf6rORRtuubrC76GasmoI5H68/BPdmYf7+W5z/taNuuF73Sf3LR0Hn4u7kL7RDyGHcTP8KeCxm3xYsZK9CIbdtvddi7DtCV7KX+R2seaYMKiOzT6olgWEUEM7PaeI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOnJkNb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33ECBC113CD;
	Wed, 24 Apr 2024 16:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713974992;
	bh=vtglwBCGL+0puqiFJlOQ5BXPiuyd/55Dv6QNeAzciuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kOnJkNb7HRZwQKQUDqp82Gpcp6DepEa8SyImi/aVcGhdiW5Uw2KIIcVhv7slfFQp0
	 o3tvxjZ+916iwpJwU/J5ovQk6j8e3YM/XrS+9/x4sKbsprhSr+ftUpO+E+xLdylOYh
	 hDTzQEf4SIbhCQP8TAS8Aomi5HayO1SRZ/QwbAxTh08zqJIyBTUdCnAwBKROnPiYYU
	 5i/6tN+Uv9fHZ/W4ca5SkHll1ebX4LZ7BtqB1akPmKujnHrSpuWVF3ghcyVAkkEk66
	 Cepuw0UwhGsRDUCGgQZ5lAIMdnx7fxvSsaoak8LsJ1MzHCdUvjXXkt9xU8oASx7lMu
	 7qx8f9IxVdmkQ==
Date: Wed, 24 Apr 2024 18:09:43 +0200
From: Christian Brauner <brauner@kernel.org>
To: Stas Sergeev <stsp2@yandex.ru>
Cc: linux-kernel@vger.kernel.org, Stefan Metzmacher <metze@samba.org>, 
	Eric Biederman <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andy Lutomirski <luto@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	David Laight <David.Laight@aculab.com>, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>
Subject: Re: [PATCH v4 0/2] implement OA2_INHERIT_CRED flag for openat2()
Message-ID: <20240424-schummeln-zitieren-9821df7cbd49@brauner>
References: <20240424105248.189032-1-stsp2@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240424105248.189032-1-stsp2@yandex.ru>

On Wed, Apr 24, 2024 at 01:52:46PM +0300, Stas Sergeev wrote:
> This patch-set implements the OA2_INHERIT_CRED flag for openat2() syscall.
> It is needed to perform an open operation with the creds that were in
> effect when the dir_fd was opened. This allows the process to pre-open
> some dirs and switch eUID (and other UIDs/GIDs) to the less-privileged
> user, while still retaining the possibility to open/create files within
> the pre-opened directory set.
> 
> The sand-boxing is security-oriented: symlinks leading outside of a
> sand-box are rejected. /proc magic links are rejected.
> The more detailed description (including security considerations)
> is available in the log messages of individual patches.
> 
> Changes in v4:
> - add optimizations suggested by David Laight <David.Laight@ACULAB.COM>
> - move security checks to build_open_flags()
> - force RESOLVE_NO_MAGICLINKS as suggested by Andy Lutomirski <luto@kernel.org>
> 
> Changes in v3:
> - partially revert v2 changes to avoid overriding capabilities.
>   Only the bare minimum is overridden: fsuid, fsgid and group_info.
>   Document the fact the full cred override is unwanted, as it may
>   represent an unneeded security risk.
> 
> Changes in v2:
> - capture full struct cred instead of just fsuid/fsgid.
>   Suggested by Stefan Metzmacher <metze@samba.org>

This smells ripe enough to serve as an attack vector in non-obvious
ways. And in general this has the potential to confuse the hell out
unsuspecting userspace. They can now suddenly get sent such
special-sauce files such as this that they have no way of recognizing as
there's neither an FMODE_* flag nor is the OA2_* flag recorded so it's
not available in F_GETFL.

There's not even a way to restrict that new flag because no LSM ever
sees it. So that behavior might break LSM assumptions as well.

And it is effectively usable to steal credentials. If process A opens a
directory with uid/gid 0 then sends that directory fd via AF_UNIX or
something to process B then process B can inherit the uid/gid of process
A by specifying OA2_* with no way for process A to prevent this - not
even through an LSM.

The permission checking model that we have right now is already baroque.
I see zero reason to add more complexity for the sake of "lightweight
sandboxing". We have LSMs and namespaces for stuff like this.

NAK.

