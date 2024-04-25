Return-Path: <linux-fsdevel+bounces-17749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6843D8B215D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 14:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981831C21754
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 12:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E47912BF12;
	Thu, 25 Apr 2024 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOlIw5E4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8164712B159;
	Thu, 25 Apr 2024 12:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714046915; cv=none; b=QWqdNrGscKe2IglXrq23o3IRj64wOkFGP5ANY87zKCS93kGCYPj9iJWXlMcG5PwCiAu5+iY+IcJoawmoKU2VLTZSUMSejj15cQf+9rNNddz1n2AmexrFtqYVdrZXE2xCCAoJORuO+IiJt7QgGWkDYMeaQuPNmfXgf6PIKYO1ICI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714046915; c=relaxed/simple;
	bh=QJ/+TaI7LYFNkVXAUM2e6kETsZ4oE7E3AR7EDPAymsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/tobfTsLJfzLUqz6vvT7+5wW9Q1Mvf96a9j1y/CjzDpFOozgNd/mi3DDWPeSkgzMIvhXXua8d61F3rvLl1Zyn+dODRBvZLzXG+GW01JcS6/EalyZlCw5hLGOMASFe5yEAa1IMqEy+XYJRllugiU4ciKy0EVsBl3z4yiG+3Cydg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOlIw5E4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906E8C113CC;
	Thu, 25 Apr 2024 12:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714046915;
	bh=QJ/+TaI7LYFNkVXAUM2e6kETsZ4oE7E3AR7EDPAymsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bOlIw5E4WknFvh5vVANsGtX1zP9GNXAj6BdyeFZYv8CKMxB183hLztSJqBenWQ/BQ
	 VuHJIcAAWKPbrFGOKmH59x+jTcyKdR4pqdOgTjLulMKF0SxVx3SrTz1s3L1O1UTE4v
	 9sse07Qg4KSV1x/h+1dhdbZKaGCsltSz6MA16Ywe4tnbEYmmvQyD2uHpwHFzJ7jaKY
	 6D9GRcLCnD2PCnyrzC86OEdS6CJ+NQFUkkYeR2bjI1nT1q1QVBVP3BmLOpJpynYMGC
	 QG2x92cZrbHu+RASqcDR9fqkM7Z5j7LEwpYLQ3vrnOmUXOR6ErVKqVX63QDErb5ZBY
	 84HK+TIsDyZhA==
Date: Thu, 25 Apr 2024 14:08:24 +0200
From: Christian Brauner <brauner@kernel.org>
To: stsp <stsp2@yandex.ru>
Cc: linux-kernel@vger.kernel.org, Stefan Metzmacher <metze@samba.org>, 
	Eric Biederman <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andy Lutomirski <luto@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	David Laight <David.Laight@aculab.com>, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>
Subject: Re: [PATCH v4 0/2] implement OA2_INHERIT_CRED flag for openat2()
Message-ID: <20240425-loslassen-hexen-a1664a579ea1@brauner>
References: <20240424105248.189032-1-stsp2@yandex.ru>
 <20240424-schummeln-zitieren-9821df7cbd49@brauner>
 <6b46528a-965f-410a-9e6f-9654c5e9dba2@yandex.ru>
 <20240425-ausfiel-beabsichtigen-a2ef9126ebda@brauner>
 <df51f2fd-385a-47bf-a072-a8988a801d52@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df51f2fd-385a-47bf-a072-a8988a801d52@yandex.ru>

> But I am sure you still don't understand
> what exactly the patch does, so why not
> to ask instead of asserting?
> You say uid/gid can be stolen, but no,
> it can't: the creds are reverted. Only
> fsuid/fsgid (and caps in v2 of the patch)
> actually affect openat2(), but nothing is
> "leaked" after openat2() finished.

I say "stolen" because the original opener has no say in this. You're
taking their fsuid/fsgid and groups and overriding creds for the
duration of the lookup and open. Something the original opener never
consented to. But let's call it "borrowed" if you're hung up on
terminology here.

But ultimately it's the same complaint: the original opener has no way
of controlling this behavior. Once ignored in my first reply, and now
again conveniently cut off again. Let alone all the other objections.

And fwiw, the same way you somehow feel like I haven't read your patch
it seems you to consistently underestimate the implications of this
change. Which is really strange because it's pretty obvious. It's
effectively temporary setuid/setgid with some light limitations.

Leaking directory descriptors across security boundaries becomes a lot
more interesting with this patch applied. Something which has happened
multiple times already and heavily figures in container escapes. And the
RESOLVE_BENEATH/IN_ROOT restrictions only stave off symlink (and magic
link) attacks. If a directory fd is leaked a container can take the
fsuid/fsgid/groups from the original opener of that directory and write
to disk with whatever it resolves to in that namespace's idmapping. It's
basically a nice way to puzzle together arbitrary fsuid/fsgid and
idmapping pairs in whatever namespace the opener happens to be in.

And again it also messes with LSMs because you're changing credentials
behind their back.

And to the "unsuspecting userspace" point you dismissed earlier.
Providing a dirfd to a lesser privileged process isn't horrendously
dangerous right now. But with this change it sure is. For stuff like
libpathrs or systemd's fdstore this change has immediate security
implications.

