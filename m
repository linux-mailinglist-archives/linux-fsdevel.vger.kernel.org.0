Return-Path: <linux-fsdevel+bounces-19580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A74F8C76B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 14:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209C42825E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 12:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FCF146018;
	Thu, 16 May 2024 12:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANsanT6n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2C2335B5;
	Thu, 16 May 2024 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715863337; cv=none; b=P8TFyJliYGT2ehOJ2NQOWXOu3pL0J71sBjM28QtyuMf527FQFwgPYppk4jUrDYW3TLMtTNHlwJgeLW0I3vtsWPe84dMpYmYfk+pCPPFgEVWK5Tu1PtXrZFrlr3pQUqqt4gyb0Kw3Xf3eZrbJQ/4ZwcBYl30cDEUO3GGoCXrg/6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715863337; c=relaxed/simple;
	bh=dZuc6aEkLxsStlqKWqRbYGaBpp818DtL48GR/YcgDws=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=etumGbeVDAwga1CInjBSl0hzs9k/n2YOC3bqCGauorHTVhp6rr6qdwP0NAbXioY+VgNLtOUzF7K/9V3d4FBi976dtx5e++fGQF1bVjjKW6f46Fd0XafKDZ/72aftAJ+Vz38c+4Ri3l95+bfToksPglx4JgVbybQh8RPgTNKa8R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANsanT6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3040C2BD11;
	Thu, 16 May 2024 12:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715863336;
	bh=dZuc6aEkLxsStlqKWqRbYGaBpp818DtL48GR/YcgDws=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=ANsanT6nZYIwvn7RXLoXPppfuchIVNZvA8h22fH680TVIxuzInBAS9F7+/g10GnBd
	 Wb3ALcWC4UFNXjQeAW0VXeiznDONGwjCvMtUsYPJbDow8QsH73paA3fynPyoROgrcC
	 VLGgouxeyvzOtAVP4zcTuAmK+45d2VssRgPzogb/FsDmn1sP5+z0WxzVVAhEoAeeO4
	 GdyXwSHp8Vh9gKRU0d33phVuo1nJ5OHH5Y74XhlfEMSm//q6YRGHnqcezqs0BjVtoQ
	 kwoWiKmDCT2LtTpxGV6JTq9mpHsmEG7hHC/8vd0RZ2yqWT4ZCYYIvyEGT9Y/y561N/
	 uVDdO2xmJgXZA==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 May 2024 15:42:11 +0300
Message-Id: <D1B2SCNE9LOV.EQJ3T08WUX9H@kernel.org>
Subject: Re: [PATCH 2/3] capabilities: add securebit for strict userns caps
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jonathan Calmels" <jcalmels@3xx0.net>, <brauner@kernel.org>,
 <ebiederm@xmission.com>, "Luis Chamberlain" <mcgrof@kernel.org>, "Kees
 Cook" <keescook@chromium.org>, "Joel Granados" <j.granados@samsung.com>,
 "Serge Hallyn" <serge@hallyn.com>, "Paul Moore" <paul@paul-moore.com>,
 "James Morris" <jmorris@namei.org>, "David Howells" <dhowells@redhat.com>
Cc: <containers@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <keyrings@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <20240516092213.6799-3-jcalmels@3xx0.net>
In-Reply-To: <20240516092213.6799-3-jcalmels@3xx0.net>

Maintainer dependent but at least on x86 patches people tend to prefer
capital letter in the short summary i.e. s/add/Add/

On Thu May 16, 2024 at 12:22 PM EEST, Jonathan Calmels wrote:
> This patch adds a new capability security bit designed to constrain a
> task=E2=80=99s userns capability set to its bounding set. The reason for =
this is
> twofold:
>
> - This serves as a quick and easy way to lock down a set of capabilities
>   for a task, thus ensuring that any namespace it creates will never be
>   more privileged than itself is.
> - This helps userspace transition to more secure defaults by not requirin=
g
>   specific logic for the userns capability set, or libcap support.
>
> Example:
>
>     # capsh --secbits=3D$((1 << 8)) --drop=3Dcap_sys_rawio -- \
>             -c 'unshare -r grep Cap /proc/self/status'
>     CapInh: 0000000000000000
>     CapPrm: 000001fffffdffff
>     CapEff: 000001fffffdffff
>     CapBnd: 000001fffffdffff
>     CapAmb: 0000000000000000
>     CapUNs: 000001fffffdffff
>
> Signed-off-by: Jonathan Calmels <jcalmels@3xx0.net>
> ---
>  include/linux/securebits.h      |  1 +
>  include/uapi/linux/securebits.h | 11 ++++++++++-
>  kernel/user_namespace.c         |  5 +++++
>  3 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/securebits.h b/include/linux/securebits.h
> index 656528673983..5f9d85cd69c3 100644
> --- a/include/linux/securebits.h
> +++ b/include/linux/securebits.h
> @@ -5,4 +5,5 @@
>  #include <uapi/linux/securebits.h>
> =20
>  #define issecure(X)		(issecure_mask(X) & current_cred_xxx(securebits))
> +#define iscredsecure(cred, X)	(issecure_mask(X) & cred->securebits)
>  #endif /* !_LINUX_SECUREBITS_H */
> diff --git a/include/uapi/linux/securebits.h b/include/uapi/linux/secureb=
its.h
> index d6d98877ff1a..2da3f4be4531 100644
> --- a/include/uapi/linux/securebits.h
> +++ b/include/uapi/linux/securebits.h
> @@ -52,10 +52,19 @@
>  #define SECBIT_NO_CAP_AMBIENT_RAISE_LOCKED \
>  			(issecure_mask(SECURE_NO_CAP_AMBIENT_RAISE_LOCKED))
> =20
> +/* When set, user namespace capabilities are restricted to their parent'=
s bounding set. */
> +#define SECURE_USERNS_STRICT_CAPS			8
> +#define SECURE_USERNS_STRICT_CAPS_LOCKED		9  /* make bit-8 immutable */
> +
> +#define SECBIT_USERNS_STRICT_CAPS (issecure_mask(SECURE_USERNS_STRICT_CA=
PS))
> +#define SECBIT_USERNS_STRICT_CAPS_LOCKED \
> +			(issecure_mask(SECURE_USERNS_STRICT_CAPS_LOCKED))
> +
>  #define SECURE_ALL_BITS		(issecure_mask(SECURE_NOROOT) | \
>  				 issecure_mask(SECURE_NO_SETUID_FIXUP) | \
>  				 issecure_mask(SECURE_KEEP_CAPS) | \
> -				 issecure_mask(SECURE_NO_CAP_AMBIENT_RAISE))
> +				 issecure_mask(SECURE_NO_CAP_AMBIENT_RAISE) | \
> +				 issecure_mask(SECURE_USERNS_STRICT_CAPS))
>  #define SECURE_ALL_LOCKS	(SECURE_ALL_BITS << 1)
> =20
>  #endif /* _UAPI_LINUX_SECUREBITS_H */
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 7e624607330b..53848e2b68cd 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -10,6 +10,7 @@
>  #include <linux/cred.h>
>  #include <linux/securebits.h>
>  #include <linux/security.h>
> +#include <linux/capability.h>
>  #include <linux/keyctl.h>
>  #include <linux/key-type.h>
>  #include <keys/user-type.h>
> @@ -42,6 +43,10 @@ static void dec_user_namespaces(struct ucounts *ucount=
s)
> =20
>  static void set_cred_user_ns(struct cred *cred, struct user_namespace *u=
ser_ns)
>  {
> +	/* Limit userns capabilities to our parent's bounding set. */
> +	if (iscredsecure(cred, SECURE_USERNS_STRICT_CAPS))
> +		cred->cap_userns =3D cap_intersect(cred->cap_userns, cred->cap_bset);
> +
>  	/* Start with the capabilities defined in the userns set. */
>  	cred->cap_bset =3D cred->cap_userns;
>  	cred->cap_permitted =3D cred->cap_userns;

BR, Jarkko

