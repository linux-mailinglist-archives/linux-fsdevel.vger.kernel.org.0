Return-Path: <linux-fsdevel+bounces-41249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F1AA2CC53
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 20:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B80D97A5A27
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 19:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF82D1A01D4;
	Fri,  7 Feb 2025 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GKim8lt4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432AA176AB5
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738955410; cv=none; b=S4BjFTpRbc4lbSO+W47BuxWejsk6kdgA0AN1Iq6MZWNJ29yEIXpaJx2mcC5gXTJbGWD1cFBW5n+o8Ol+Fr+ViXCbfAfi8/cFfqF/GGVa6vrQ4xs3HOzRv3E2DVSXq0yUFtR6Hxi+2S/q/rmybpUk8gIBf9HrwMr1TiC+ksQDVP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738955410; c=relaxed/simple;
	bh=L3hBF+iQrBKTRIa3wKiXJJ/OQyIh4KsyTMz0Xy+5S4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtKR52/rkp/CPfFCHSbuGeFUW+U8Lc9qyqold1xPbFK2w96n4AcItWT3t9ipkV3PGpPj41hFxULO+uMw7urse7BVe1Z2NkxiEBrxr7Q7aw6Zt6FQCgtdGwJvu2I43EVn0TYc37qW5U/IKdtqI9+o4kGFubJEdHb1/dJ22bCN63k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GKim8lt4; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6f6715734d9so22297107b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2025 11:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1738955406; x=1739560206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Om2VSE738EF+Gy11pRhlx9VqvfBmWOXzuPiTJvCwuz4=;
        b=GKim8lt4SXP5kCoh/4cTxGCOS0NFKc37s/H8tESJs+gNOMv7ToQFj9aCC6gXDOyZFW
         HLxSttUGftYuYAnyZLRg40Zjxvlf+AWJp8XZhkFbbWk1U2XHw2B6BMJCaOy4FE3fPdpW
         Unfpfmv2KhLrQ0n6jpymXy/CUq2x15XKxIBQ0mhxWAURjkNVKfJwfsEDRlZ88+bThbLy
         S7h6oS6qz2gkxd30lZv9rMUCNFRCH6fquC2+bZCWmiLNNARvDStxMgbCi1NfsA9chIbC
         +jyROlyUVDutZjFEJL45IVc2NMcmVq07hYptArEUCcGxbrzeWHvGJD2J5f1lTQrXqPxp
         7fhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738955406; x=1739560206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Om2VSE738EF+Gy11pRhlx9VqvfBmWOXzuPiTJvCwuz4=;
        b=pAAN0vLXWXUFBbx1HDdhR3Hfm/Vg0GgxlVhQZw82VXklrJ652yPy64vZbqUb5pUiwg
         SVUX+Zm+h2gMJ49wQ2gu5fa02euVcQQ0dyAYa/Ep4zjeC9CiOsbmWrGEmsVFsRZfFAwX
         LxcfL+vBktgZUyNoJkssB2zotpGM4ZQzPKxvdlZbp00xDoHYW/94QEY0YlVI5BW5GPlN
         jD/Td/OsRJ7bvX54SNUbvJ63SWVL/5QsDme4++MOhNAVjqrNoL+YebmYZY7M4w1DloCs
         0mDD/XXkbVCeyf/Q1J9ADAwxygo5MceF9HlEnk7+3snBT6Zfi+MHlmdtgdvAFqWWcOz1
         M56Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNXHpkJHm8a0iFtqPEaPlCwdO5Zf3OSp2JBQM5BO2Gp0E7E8FqXNTwcD1mQ1f6Vmy190CxeaB5wQ1dTrmM@vger.kernel.org
X-Gm-Message-State: AOJu0YypGg715vWsKjCoiadjbYa1uDVS6X4XANHDX9vPKuCJkW3Zu28Z
	27GNW9zHJkimKBcj8TT5mDoRPKm/I7U3MH+gLnZKTR5GzSfVplLOpVrUiPvxdlcAqOPrPGX5joM
	8mQ01FlNo4JqDayQngMfGM23k2XX9BYbGlUVg
X-Gm-Gg: ASbGncs3EA6vRyjard13q+s6fDUmim2pG98gszP+SOR9hYF1+hj1rQF6ZW4jfe7POWQ
	n/75TOPDStyHANpnKenfIE592U0MNFXIOEWVdcYYGBbwM7ggZCfgPfSb2pLUECdsfMegzh8E=
X-Google-Smtp-Source: AGHT+IGK+1YaMF/yB5tZ88LHxwIuQM3/Gj8AOscWWTmOeYR+q9GoKPuGwr2TcabPJS4LqujSyvfXsbiPIUAyuUzPzSo=
X-Received: by 2002:a05:690c:3804:b0:6f9:97bd:5a63 with SMTP id
 00721157ae682-6f9b2844e3cmr39923927b3.4.1738955406214; Fri, 07 Feb 2025
 11:10:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207034040.3402438-1-neilb@suse.de> <20250207034040.3402438-2-neilb@suse.de>
In-Reply-To: <20250207034040.3402438-2-neilb@suse.de>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 7 Feb 2025 14:09:55 -0500
X-Gm-Features: AWEUYZl_WdQaatK919wx4Q8t6Nn6ccb6OCvCp4tV_BELcL0JYxwXteOCsEvAF2g
Message-ID: <CAHC9VhTnVg-5C75qY8NkfKs4tjbVz62Vk=SVXS2mwH0f3ftLhQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] VFS: change kern_path_locked() and
 user_path_locked_at() to never return negative dentry
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Steve French <sfrench@samba.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 10:41=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
>
> No callers of kern_path_locked() or user_path_locked_at() want a
> negative dentry.  So change them to return -ENOENT instead.  This
> simplifies callers.
>
> This results in a subtle change to bcachefs in that an ioctl will now
> return -ENOENT in preference to -EXDEV.  I believe this restores the
> behaviour to what it was prior to
>  Commit bbe6a7c899e7 ("bch2_ioctl_subvolume_destroy(): fix locking")
>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  drivers/base/devtmpfs.c | 65 +++++++++++++++++++----------------------
>  fs/bcachefs/fs-ioctl.c  |  4 ---
>  fs/namei.c              |  4 +++
>  kernel/audit_watch.c    | 12 ++++----
>  4 files changed, 40 insertions(+), 45 deletions(-)

...

> diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
> index 7f358740e958..e3130675ee6b 100644
> --- a/kernel/audit_watch.c
> +++ b/kernel/audit_watch.c
> @@ -350,11 +350,10 @@ static int audit_get_nd(struct audit_watch *watch, =
struct path *parent)
>         struct dentry *d =3D kern_path_locked(watch->path, parent);
>         if (IS_ERR(d))
>                 return PTR_ERR(d);
> -       if (d_is_positive(d)) {
> -               /* update watch filter fields */
> -               watch->dev =3D d->d_sb->s_dev;
> -               watch->ino =3D d_backing_inode(d)->i_ino;
> -       }
> +       /* update watch filter fields */
> +       watch->dev =3D d->d_sb->s_dev;
> +       watch->ino =3D d_backing_inode(d)->i_ino;
> +
>         inode_unlock(d_backing_inode(parent->dentry));
>         dput(d);
>         return 0;
> @@ -419,7 +418,7 @@ int audit_add_watch(struct audit_krule *krule, struct=
 list_head **list)
>         /* caller expects mutex locked */
>         mutex_lock(&audit_filter_mutex);
>
> -       if (ret) {
> +       if (ret && ret !=3D -ENOENT) {
>                 audit_put_watch(watch);
>                 return ret;
>         }
> @@ -438,6 +437,7 @@ int audit_add_watch(struct audit_krule *krule, struct=
 list_head **list)
>
>         h =3D audit_hash_ino((u32)watch->ino);
>         *list =3D &audit_inode_hash[h];
> +       ret =3D 0;

If you have to respin this patch for any reason I'd prefer to move the
'ret =3D 0' up to just after the if block you're modifying in the chunk
above, but that's a trivial nitpick so please don't respin only for
that.  Otherwise it looks fine to me from an audit perspective.

Acked-by: Paul Moore <paul@paul-moore.com> (Audit)

>  error:
>         path_put(&parent_path);
>         audit_put_watch(watch);
> --
> 2.47.1

--=20
paul-moore.com

