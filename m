Return-Path: <linux-fsdevel+bounces-22361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E729169E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 16:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDEEC1F2195C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 14:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B92D16A395;
	Tue, 25 Jun 2024 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8XJ8u7i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C83016A959
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719324631; cv=none; b=LPZmMUYJmpCZQj0gvT7mlgGbWoCC3JXCzNxOTwJ5tTqd75fvgb/o++UnYN6OfHSAafkCYQBqCV0ce1NqeBXtTTFaSN9f6xrR9ZXogKo3ExY1YWwFCO/yHLng/LixTzwSdMjsVtqAgeUQOI6Xfwh16/9rfN0hLiM4LTUDP2NhB/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719324631; c=relaxed/simple;
	bh=qKYq1mCIUgklYXTS1zV8zbRuaormofVFM58cb8g9KQA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aBbPMNcygtLGGlJBsiEKlCvRRks6iz1BjL7ptvik4tNt5cMn1450wo8W3cvlvHcUdxT2uJFexdDRubDICV6JzO3N/8LvNF8RiWtyNZ8rWZsPs0ohw0Ftpl61grvfg8uuyvpq8zUo3UwFVt8Qtx9t1TKMvZCmMttIBRqSJN23smU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8XJ8u7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEA8C4AF0A;
	Tue, 25 Jun 2024 14:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719324631;
	bh=qKYq1mCIUgklYXTS1zV8zbRuaormofVFM58cb8g9KQA=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=I8XJ8u7i8xEPUizJGJwc7n9YbsWhxJWB0Gn/pMuhR4/mjOfZneHVRgb7AIgI+qang
	 aiP2/pjh4DclxNLaZ5shBtEOgmwAyHUtJYaGt2tXvlojAURXo9r2gubpdBclwgWU1b
	 oLJoubJ3RuhV07nW3aw9opXmKlQG7/swTX4VZ9lt6NZRNSqDXcpz4+GzlyYjETnCs0
	 RN97egz+47j1ZL3fuLhpiUm7tCdyK1XXKhIWkyJmOcCfJvhs22MUzlEvfRRx4sijb1
	 Qcv1G5z+xvXPmxxv/mVgRrPopMMLV75q4naErpQJLVSiPLt/0D8RTKYlUaYgC49pbG
	 RfOVvEJXt1WTw==
Message-ID: <14330f15065f92a88c7c0364cba3e26c294293a4.camel@kernel.org>
Subject: Re: [PATCH 7/8] fs: add an ioctl to get the mnt ns id from nsfs
From: Jeff Layton <jlayton@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, kernel-team@fb.com
Date: Tue, 25 Jun 2024 10:10:29 -0400
In-Reply-To: <180449959d5a756af7306d6bda55f41b9d53e3cb.1719243756.git.josef@toxicpanda.com>
References: <cover.1719243756.git.josef@toxicpanda.com>
	 <180449959d5a756af7306d6bda55f41b9d53e3cb.1719243756.git.josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-24 at 11:49 -0400, Josef Bacik wrote:
> In order to utilize the listmount() and statmount() extensions that
> allow us to call them on different namespaces we need a way to get
> the
> mnt namespace id from user space.=C2=A0 Add an ioctl to nsfs that will
> allow
> us to extract the mnt namespace id in order to make these new
> extensions
> usable.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> =C2=A0fs/nsfs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 14 ++++++++++++++
> =C2=A0include/uapi/linux/nsfs.h |=C2=A0 2 ++
> =C2=A02 files changed, 16 insertions(+)
>=20
> diff --git a/fs/nsfs.c b/fs/nsfs.c
> index 07e22a15ef02..af352dadffe1 100644
> --- a/fs/nsfs.c
> +++ b/fs/nsfs.c
> @@ -12,6 +12,7 @@
> =C2=A0#include <linux/nsfs.h>
> =C2=A0#include <linux/uaccess.h>
> =C2=A0
> +#include "mount.h"
> =C2=A0#include "internal.h"
> =C2=A0
> =C2=A0static struct vfsmount *nsfs_mnt;
> @@ -143,6 +144,19 @@ static long ns_ioctl(struct file *filp, unsigned
> int ioctl,
> =C2=A0		argp =3D (uid_t __user *) arg;
> =C2=A0		uid =3D from_kuid_munged(current_user_ns(), user_ns-
> >owner);
> =C2=A0		return put_user(uid, argp);
> +	case NS_GET_MNTNS_ID: {
> +		struct mnt_namespace *mnt_ns;
> +		__u64 __user *idp;
> +		__u64 id;
> +
> +		if (ns->ops->type !=3D CLONE_NEWNS)
> +			return -EINVAL;
> +
> +		mnt_ns =3D container_of(ns, struct mnt_namespace, ns);
> +		idp =3D (__u64 __user *)arg;
> +		id =3D mnt_ns->seq;
> +		return put_user(id, idp);
> +	}
> =C2=A0	default:
> =C2=A0		return -ENOTTY;
> =C2=A0	}
> diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
> index a0c8552b64ee..56e8b1639b98 100644
> --- a/include/uapi/linux/nsfs.h
> +++ b/include/uapi/linux/nsfs.h
> @@ -15,5 +15,7 @@
> =C2=A0#define NS_GET_NSTYPE		_IO(NSIO, 0x3)
> =C2=A0/* Get owner UID (in the caller's user namespace) for a user
> namespace */
> =C2=A0#define NS_GET_OWNER_UID	_IO(NSIO, 0x4)
> +/* Get the id for a mount namespace */
> +#define NS_GET_MNTNS_ID		_IO(NSIO, 0x5)
> =C2=A0
> =C2=A0#endif /* __LINUX_NSFS_H */

Thinking about this more...

Would it also make sense to wire up a similar ioctl in pidfs? It seems
like it might be nice to just open a pidfd for pid and then issue the
above to get its mntns id, rather than having to grovel around in nsfs.
--=20
Jeff Layton <jlayton@kernel.org>

