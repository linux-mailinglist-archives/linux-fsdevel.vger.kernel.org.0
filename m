Return-Path: <linux-fsdevel+bounces-59804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB5AB3E181
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 374B01A81B8E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD1931A041;
	Mon,  1 Sep 2025 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2t1xmKB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1BC1F3BBB
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726008; cv=none; b=aQKZeoH3w27zgqPndyQ/Hd+/IFQJ4SbOwJQpflHJglfF8xoFCShKcUasUuxxh9G9irdRbVtka+FcT2Ftl8h7zF1wMY34l02mPxOzf+vMpvVZTpkcNDS1Wgj3rQQMoWddS6WLWRaY4zJLDwcZUgA+Gf8qZthYL+pdhiTR2UJuqXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726008; c=relaxed/simple;
	bh=Y4Opc0k9mPTY/P1ujV8RZYVM9ylWa7Br+OP4dvI4DXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1EjKNqTHkErpHArVvihsNG4SkR0WLICuxvBTryO8RUblhktdfdzKrHXiFl4caAz2P1R1RA4OeX1uSQ//mD3x6ZqsB77BuFyvQVSjrOCRxmr4cBXux8+fx4sJ6MMb08b3OS9wI68Wi+R3eU+t+FwdAck8CSCk10szWBMo5ud0lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2t1xmKB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93746C4CEF0;
	Mon,  1 Sep 2025 11:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756726008;
	bh=Y4Opc0k9mPTY/P1ujV8RZYVM9ylWa7Br+OP4dvI4DXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i2t1xmKBWSIWSpWGlS2gCH82RMgLsMpaSGDGDX9CES/K3N3+dDJnwU3T9auFnRK7k
	 8N0fSPj+dllAa9NFmVD9jUI/gzCFu9/LyHiB3s1vVi1rLkR8fQuRayeSo33nkbdoWD
	 TvTQFf78/aFCdT1OhF+9dYlvDNVK/fa4mCQsYFc+e4QEVVsPnPSyZwQUqNsdiZU48m
	 tB3SREVEcWK7WhuPQFUzJ2PSLlDfBFa9bVkwaUosimXP7/PA6FooHOiO6dSqTWLuCX
	 +51mQ8yzIAoSBw8a2CNytsfgzgTCmO1bo7wZImEcTjUUcT/qjRGS6ncQ6zH6jRVf0Q
	 I7Bv1LzcT0ixw==
Date: Mon, 1 Sep 2025 13:26:45 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz
Subject: Re: [62/63] struct mount: relocate MNT_WRITE_HOLD bit
Message-ID: <20250901-vorsehen-hilft-a9d092e85546@brauner>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-61-viro@zeniv.linux.org.uk>
 <CAHk-=wgZEkSNKFe_=W=OcoMTQiwq8j017mh+TUR4AV9GiMPQLA@mail.gmail.com>
 <20250829001109.GB39973@ZenIV>
 <CAHk-=wg+wHJ6G0hF75tqM4e951rm7v3-B5E4G=ctK0auib-Auw@mail.gmail.com>
 <20250829060306.GC39973@ZenIV>
 <20250829060705.GD659926@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250829060705.GD659926@ZenIV>

On Fri, Aug 29, 2025 at 07:07:05AM +0100, Al Viro wrote:
> ... from ->mnt_flags to LSB of ->mnt_pprev_for_sb.
> 
> This is safe - we always set and clear it within the same mount_lock
> scope, so we won't interfere with list operations - traversals are
> always forward, so they don't even look at ->mnt_prev_for_sb and
> both insertions and removals are in mount_lock scopes of their own,
> so that bit will be clear in *all* mount instances during those.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/mount.h            | 25 ++++++++++++++++++++++++-
>  fs/namespace.c        | 34 +++++++++++++++++-----------------
>  include/linux/mount.h |  3 +--
>  3 files changed, 42 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/mount.h b/fs/mount.h
> index b208f69f69d7..40cf16544317 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -66,7 +66,8 @@ struct mount {
>  	struct list_head mnt_child;	/* and going through their mnt_child */
>  	struct mount *mnt_next_for_sb;	/* the next two fields are hlist_node, */
>  	struct mount * __aligned(1) *mnt_pprev_for_sb;
> -					/* except that LSB of pprev will be stolen */
> +					/* except that LSB of pprev is stolen */
> +#define WRITE_HOLD 1			/* ... for use by mnt_hold_writers() */
>  	const char *mnt_devname;	/* Name of device e.g. /dev/dsk/hda1 */
>  	struct list_head mnt_list;
>  	struct list_head mnt_expire;	/* link in fs-specific expiry list */
> @@ -244,4 +245,26 @@ static inline struct mount *topmost_overmount(struct mount *m)
>  	return m;
>  }
>  
> +static inline bool __test_write_hold(struct mount * __aligned(1) *val)
> +{
> +	return (unsigned long)val & WRITE_HOLD;
> +}
> +
> +static inline bool test_write_hold(const struct mount *m)
> +{
> +	return __test_write_hold(m->mnt_pprev_for_sb);
> +}
> +
> +static inline void set_write_hold(struct mount *m)
> +{
> +	m->mnt_pprev_for_sb = (void *)((unsigned long)m->mnt_pprev_for_sb
> +				       | WRITE_HOLD);
> +}
> +
> +static inline void clear_write_hold(struct mount *m)
> +{
> +	m->mnt_pprev_for_sb = (void *)((unsigned long)m->mnt_pprev_for_sb
> +				       & ~WRITE_HOLD);
> +}

I have to say that I find this really unpleasant but...
I've seen issues withe current MNT_WRITE_HOLD handling before when it
interacted with MNT_ONRB (I killed that a while ago),
Reviewed-by: Christian Brauner <brauner@kernel.org>

