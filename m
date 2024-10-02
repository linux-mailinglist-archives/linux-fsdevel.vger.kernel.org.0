Return-Path: <linux-fsdevel+bounces-30799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BE298E54E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 23:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F101F21EE5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 21:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AACD21B42B;
	Wed,  2 Oct 2024 21:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="onbSexGJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C59217336;
	Wed,  2 Oct 2024 21:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727904584; cv=none; b=bcK2aEGpS4wktCLmnZeVDlEBtnYkecV7XPxkUYoHGogPuAVYvMvTmeNKOzpbZ57g2DGmye64GMVK+CGpuTKi4FtfYzzSEg6WQohJRamcGoPmPZwYpmX6cmI0G8AeuK7cZq5peVikp3Ip7T7g04BLRelJx2y1qZzBJF182f9TYlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727904584; c=relaxed/simple;
	bh=OoV7yqE3FGrBgjjOwRt50ehmiiNHVPg/GEjin9PLh0Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rMwwhaqFKKBLRmvhB6LQNJRAbRZPYDa9jcDy9fd0G8eOD/8mBVMe6mLahR30THBvAA1NOJwhS3jt0SkVE8zFpxN6ehZ8eCAHTpovt66fTVHS53cet2Js9oYv/pD5+FJEonMeCL1+iAUu0qZlNaz/wIy+vISJNGqRb+92Sbu52Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=onbSexGJ; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2688440002;
	Wed,  2 Oct 2024 21:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1727904573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HncRwIusYKLU1a073mDPta5phkAfT1syOg05rFDwoQs=;
	b=onbSexGJeEjE3hP6YPlRHUL5A36yM9CyJsX/NdT4QU8UK+9FQ6lT1rNLTNVDbHP1yPIUsA
	2ElZyD6CfFiTF5vni2SV87o12V/F2Xve0JH27U7ksguHlPOyUUoBwKaPYd0S+XdnDNA71W
	amD5yQFqC2Tjwr37RBKrNCiH9N7Q0SNa6E4EWkwFmUDLBcZJt2p2QjMLGFA/jaBXu0lg7f
	1lUbulrfVzFAyl4czGiB4Q0PoRRR06QFwX+/6z83eTQtxNQ19l/ZfHgxVhbxVOtBDNrE3e
	1pLDmWQlyeERljtbRmb5XiF9m6/EgOuQCndO4ful3QacW6xb1VPC+eBURkvtCw==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Gabriel Krisman Bertazi <gabriel@krisman.be>,  Hugh Dickins
 <hughd@google.com>,  Andrew Morton <akpm@linux-foundation.org>,  Alexander
 Viro <viro@zeniv.linux.org.uk>,  Christian Brauner <brauner@kernel.org>,
  Jan Kara <jack@suse.cz>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  kernel-dev@igalia.com,  Daniel Rosenberg <drosen@google.com>,
  smcv@collabora.com,  Christoph Hellwig <hch@lst.de>,  Theodore Ts'o
 <tytso@mit.edu>
Subject: Re: [PATCH v4 07/10] tmpfs: Add casefold lookup support
In-Reply-To: <c547e1aa-f894-409e-9033-f370c5c16171@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Tue, 1 Oct 2024 22:40:17 -0300")
References: <20240911144502.115260-1-andrealmeid@igalia.com>
	<20240911144502.115260-8-andrealmeid@igalia.com>
	<87ed5olmmc.fsf@mailhost.krisman.be>
	<c547e1aa-f894-409e-9033-f370c5c16171@igalia.com>
Date: Wed, 02 Oct 2024 17:29:29 -0400
Message-ID: <877caqw5vq.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gabriel@krisman.be

Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:

> Hey Krisman,
>
> Em 12/09/2024 16:04, Gabriel Krisman Bertazi escreveu:
>> Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:
>>=20
>
> [...]
>
>>> +#if IS_ENABLED(CONFIG_UNICODE)
>>> +	if (ctx->encoding) {
>>> +		sb->s_encoding =3D ctx->encoding;
>>> +		sb->s_d_op =3D &shmem_ci_dentry_ops;
>>> +		if (ctx->strict_encoding)
>>> +			sb->s_encoding_flags =3D SB_ENC_STRICT_MODE_FL;
>>> +	}
>>>   #else
>>> -	sb->s_flags |=3D SB_NOUSER;
>>> +	sb->s_d_op =3D &simple_dentry_operations;
>> Moving simple_dentry_operations to be set at s_d_op should be a
>> separate
>> patch.
>> It is a change that has non-obvious side effects (i.e. the way we
>> treat the root dentry) so it needs proper review by itself.  It is
>> also not related to the rest of the case-insensitive patch.
>>=20
>
> The idea of setting simple_dentry_operations come from my previous
> approach of having our own shmem_lookup(), replacing
> simple_lookup(). Now that we are settled to keep with simple_lookup()
> anyway (that already sets simple_dentry_operations), I think we don't
> need this change anymore, right?

Up to you, really. If you don't need it to support casefold lookup in
tmpfs, it doesn't need to be part of the same patchset.

> This will be set for every dentry that doesn't have a
> dentry->d_sb->s_d_op. Case-insensitive mount points will have this set,
> so we don't risk overwriting it.

I encourage you to send a new version with this.  makes sense to me.

--=20
Gabriel Krisman Bertazi

