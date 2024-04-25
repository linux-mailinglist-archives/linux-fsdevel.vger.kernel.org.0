Return-Path: <linux-fsdevel+bounces-17789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 923268B236D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 16:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A401C21CEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 14:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE54149E05;
	Thu, 25 Apr 2024 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2yIIcr9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139431494BB;
	Thu, 25 Apr 2024 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053780; cv=none; b=Z4qBsXYDKwaGssh0WEMr7XfhIbs3srTL370AZyn9p0EybPUCQRZHHLgCXNXrd6dmacxf2/tbG8qtdZYT/L4/lhMy3wj/SeOSqX4brEtsKnETAhlSSc4z0IHCd/c7sMcsaKPA4V9ePcBjCrnlvuUY7CnbkUwuZlPnJvHlvcFRm04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053780; c=relaxed/simple;
	bh=ExEnrOrorNPeVUED4foxKZCvmX6BWkIu1dkDvKFwvVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUrNTq6w8G5S9pRbiB2Ib/T/HJvs0LTcb21tudnPrdJ+snG5Agfc+uy0nT2x3UM5vWVSbV1Y2ZoCTGVwCHB/E5a77UX9VqDCG+cGX571Y0Tf2+eRrokExj5t3fgc1hJ+WhxhgVPQ86l5YlYg7NBoZ/9VUTG5/heKq59BWghrmZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2yIIcr9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979EBC113CC;
	Thu, 25 Apr 2024 14:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714053779;
	bh=ExEnrOrorNPeVUED4foxKZCvmX6BWkIu1dkDvKFwvVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d2yIIcr9OPrSQ08qxRyXjKfdnsihdla9xCdtcuPKu0tmVd2k+JVdNtGK6zm66aNjy
	 ja95Tz6lAvmhrZkg5v6JTDkzjmJtl7hR9uyQDPX0w0A0WY/BVoztVOAdKNoB00KjxD
	 fgcdF2AA2LGc9n+9znTgDlBPE66vljUcuWCSjEg+6Nkx+eIhEYALjxnYv6wvdxFqtB
	 P675qaaUgkdPEsE+nYVTq32W9/pESDk9A2fMUJ4tmmc167WGgdxjy++C/oq7zMGjma
	 XUJ9YaCs9JdG49zIuJO+13ZDXWlTiJlOtLkmc5wY04S3VoWscJNTP31IgHKJGqh9Ul
	 5MhUG/GDQ2CYA==
Date: Thu, 25 Apr 2024 16:02:46 +0200
From: Christian Brauner <brauner@kernel.org>
To: Stas Sergeev <stsp2@yandex.ru>
Cc: linux-kernel@vger.kernel.org, Stefan Metzmacher <metze@samba.org>, 
	Eric Biederman <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andy Lutomirski <luto@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	David Laight <David.Laight@aculab.com>, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>
Subject: Re: [PATCH 2/2] openat2: add OA2_INHERIT_CRED flag
Message-ID: <20240425-akrobatisch-palmen-4c1e7a0f69d2@brauner>
References: <20240424105248.189032-1-stsp2@yandex.ru>
 <20240424105248.189032-3-stsp2@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240424105248.189032-3-stsp2@yandex.ru>

>  struct open_flags {
> -	int open_flag;
> +	u64 open_flag;

Btw, this change taken together with

> +#define VALID_OPENAT2_FLAGS (VALID_OPEN_FLAGS | OA2_INHERIT_CRED)

is also ripe to causes subtle bugs and security issues. This new
VALID_OPENAT2_FLAGS define bypasses

	BUILD_BUG_ON_MSG(upper_32_bits(VALID_OPEN_FLAGS),
			 "struct open_flags doesn't yet handle flags > 32 bits");

in build_open_flags(). And right now lookup_open(), open_last_lookups(),
and do_open() just do:

	int open_flag = op->open_flag;

Because op->open_flag was 32bit that was fine. But now ->open_flag is
64bit which means we truncate the upper 32bit including OA2_INHERIT_CRED
or any other new flag in the upper 32bits in those functions.

So as soon as there's an additional check in e.g., do_open() for
OA2_INHERIT_CRED or in any of the other helpers that's security relevant
we're fscked because that flag is never seen and no bot will help us
here. And it's super easy to miss during review...

