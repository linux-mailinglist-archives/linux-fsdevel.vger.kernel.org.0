Return-Path: <linux-fsdevel+bounces-10547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD15C84C23F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 03:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6801F28492
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 02:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F57E55F;
	Wed,  7 Feb 2024 02:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DJiqYOmL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA72DDA1
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 02:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707271770; cv=none; b=FuWeDnN8yqFFeeScWAxEspzv0FOSLvWOvna6RZxMIVWDtnN8sSeP9etObX9tCteTINXt5riyl5aRWERm0EATdDdoUxPfJdYVpTrCuXX1dJL8ugGjoHqQSeIEAOGq3pbKMTY3cKSrUxe4ukKy0FJx23Yo90jxa8xW0jvAK2385ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707271770; c=relaxed/simple;
	bh=UAPXd7rOZbx98r8KvdfkNo0YYES+bEmSjU7lI2NGJUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afIdotY8Wi5s1GNg2YOJV3R0uaAe+l8cqvkfs/7/umyCjBO08YXb2q1Ca0KG/G6OyHSjBd0kjYqYzDXE/QbRkRxGSE+kfKFqvYnqQ0qrjK1QNvFVIevEZz9g85pwhzz4hM8L92nIGkC6xi9/qbYtcWrZWjrYR+UpJbeFBzi5G7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DJiqYOmL; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 6 Feb 2024 21:09:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707271766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=++I8ohVZqZsnkrpMTnNHgZjBWSSQ0NOqOxOVzrM8PVk=;
	b=DJiqYOmLpdyTuFwHjZGIxdLr7RGUBwG/wC09pcUKcfozeCSZEk7Nb0LM6Y87UNvvQ/A7UC
	8FtxY69z0sdUC0kdMZkKmQmyD9sUixGNUvgFE4OGF2kfuzg9mo/VOnLtVq9/3O2B6mC98/
	FutDEjfrB9X5v1tR61tTwZxrJ8VUFYo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Eric Biggers <ebiggers@kernel.org>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] filesystem visibililty ioctls
Message-ID: <uaap4vjc7bsbavyetc2nsxvdaepw5cem35pfqvu2uttmaczdpk@grzgraa473zv>
References: <20240206201858.952303-1-kent.overstreet@linux.dev>
 <20240207014729.GC35324@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207014729.GC35324@sol.localdomain>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 06, 2024 at 05:47:29PM -0800, Eric Biggers wrote:
> On Tue, Feb 06, 2024 at 03:18:48PM -0500, Kent Overstreet wrote:
> > 
> > Darrick also noticed that fscrypt (!) is using sb->s_uuid, which looks
> > busted - they want to be using the "this can never change" UUID, but
> > that is not an item for this patchset.
> > 
> 
> fscrypt only uses sb->s_uuid if FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64 or
> FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32 is being used in the encryption policy.
> These flags are only supported by ext4 and f2fs, and they are only useful when
> the file contents encryption is being done with inline encryption hardware that
> only allows 64-bits or less of the initialization vector to be specified and
> that has poor performance when switching keys.  This hardware is currently only
> known to be present on mobile and embedded systems that use eMMC or UFS storage.
> 
> Note that these settings assume the inode numbers are stable as well as the
> UUID.  So, when they are in use, filesystem shrinking is prohibited as well as
> changing the filesystem UUID.  (In ext4, both operations are forbidden using the
> stable_inodes feature flag.  f2fs doesn't support either operation regardless.)
> 
> These restrictions are unfortunate, but so far they haven't been a problem for
> the only known use case for these non-default settings.
> 
> In the case of s_uuid, for both ext4 and f2fs it's true that we could have used
> s_encrypt_pw_salt instead, or added a new general-purpose internal UUID field
> and used that.  Maybe we even should have, considering the precedent of ext4's
> metadata_csum migrating away from using the UUID to its own internal seed.  I do
> worry that relying on an internal UUID for these settings would make it easier
> for people to create insecure setups where they're using the same fscrypt key on
> multiple filesystems with the same internal UUID.  With the external UUID, such
> misconfigurations are obvious and will be noticed and fixed.  With the internal
> UUID, such vulnerabilities would not be noticed, as things will "just work".
> Which is better?  It's not entirely clear to me.  We do encourage the use of
> different fscrypt keys on different filesystems anyway, but this isn't required.

*nod* nonce reuse is a thorny issue - that makes using the changeable,
external UUID a bit more of a feature than a bug.

> Of course, even if the usability improvement outweighs that concern, switching
> these already-existing encryption settings over to use an internal UUID can't be
> done trivially; it would have to be controlled by a new filesystem feature flag.
> We probably shouldn't bother unless/until there's a clear use case for it.
> 
> If anyone does have any new use case for these weird and non-default encryption
> settings (and I hope you don't!), I'd be interested to hear...

I just wanted to make sure I wasn't breaking fscrypt by baking-in that
s_uuid is the user facing one - thanks for the info.

Can we get this documented in a code comment somewhere visible? It was
definitely a "wtf" moment when Darrick and I saw it, I want to make sure
people know what's going on later.

