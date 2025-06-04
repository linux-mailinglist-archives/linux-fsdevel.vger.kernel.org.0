Return-Path: <linux-fsdevel+bounces-50592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A825ACD8AD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 09:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37F7C7A6153
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 07:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A9B1FF1A6;
	Wed,  4 Jun 2025 07:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYTNIVxA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9B916E863
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 07:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749022763; cv=none; b=s3hQmN+PIBUPyvXazxzLOR6vv77pm8snTQbyb7wNk0MuQCJaNPd5y07N48JTNLHP9owsjYIN2mPzteuoy+02yFm9q/2Dihu+fy6FH33chjvamrsQpM909f7pYQwJqLMb9oggH9DgRvKaywzwdbgqXf/Xb8kADmFJZZpB4b2WDXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749022763; c=relaxed/simple;
	bh=Y1m7a3p2eL4XKTYXe+Mwe3o1wVf4GE/A+6da8z5OHiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u35a+3ksk72hAHH9iqYjjhBttNX7ykfdqI00QBhXRrfUtDjm3OQACyAKID879TXPD3insvfahWbNRdDFvzx98s/yehegheCmv+mH21OakmBqVpsEdAEBUrM9TwLYyb6SoDVQjk3eTwIt0NufNBnFAyScoP0OX1FgNMhsB5eLY4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYTNIVxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0DEC4CEE7;
	Wed,  4 Jun 2025 07:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749022762;
	bh=Y1m7a3p2eL4XKTYXe+Mwe3o1wVf4GE/A+6da8z5OHiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HYTNIVxAeduWgUeFHIDXvHjwLrWsH4kjA702UKPZOjQeANGzjWFNVzfg5J8L2k0Kz
	 MjKdfoWElzMmZoV0rZiKMkTUqEpHu1CfQK+GVpRyMe6Mb//Y0OHvn/3RselZI8oEtg
	 zjGBKvhK4BC3RrxiVxcmOfu9mzodK+pK9YjlGwriU0Pkx0Ofkc2iQtDf4/a/TeU6NF
	 4BpQ5O1ve9rI8OVp7cfUjboJ3y2SiVRXSNmVloBg0rJyTNnpJe1n1Klg/CoNYojwmv
	 8w1wrkV+5jI6mdGhXZDuenDx1pS/jG32pVs/UtIvq+3ycqEllka6hsIWrv9ZuSS+rs
	 u6wblncYiLOnA==
Date: Wed, 4 Jun 2025 09:39:18 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>, 
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 3/5] finish_automount(): don't leak MNT_LOCKED from
 parent to child
Message-ID: <20250604-absitzen-notwehr-0eb68835d321@brauner>
References: <20250603231500.GC299672@ZenIV>
 <20250603231807.GC145532@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603231807.GC145532@ZenIV>

On Wed, Jun 04, 2025 at 12:18:07AM +0100, Al Viro wrote:
> Intention for MNT_LOCKED had always been to protect the internal
> mountpoints within a subtree that got copied across the userns boundary,
> not the mountpoint that tree got attached to - after all, it _was_
> exposed before the copying.
> 
> For roots of secondary copies that is enforced in attach_recursive_mnt() -
> MNT_LOCKED is explicitly stripped for those.  For the root of primary
> copy we are almost always guaranteed that MNT_LOCKED won't be there,
> so attach_recursive_mnt() doesn't bother.  Unfortunately, one call
> chain got overlooked - triggering e.g. NFS referral will have the
> submount inherit the public flags from parent; that's fine for such
> things as read-only, nosuid, etc., but not for MNT_LOCKED.
> 
> This is particularly pointless since the mount attached by finish_automount()
> is usually expirable, which makes any protection granted by MNT_LOCKED
> null and void; just wait for a while and that mount will go away on its own.
> 
> Include MNT_LOCKED into the set of flags to be ignored by do_add_mount() - it
> really is an internal flag.
> 
> Fixes: 5ff9d8a65ce8 ("vfs: Lock in place mounts from more privileged users")
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

