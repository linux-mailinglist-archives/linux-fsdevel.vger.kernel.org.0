Return-Path: <linux-fsdevel+bounces-46561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8444CA9054A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 16:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32D6D7AECDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 14:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3922054E5;
	Wed, 16 Apr 2025 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1UdN079"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2AE204F88
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 13:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811399; cv=none; b=C/Hxii8y92GNPd5+/3twdvwCTRXIjFVU0RAwxzLrQDHhP68KX4pw7SVLW3NV56Lz1Wa4lp7qOpnsO9zsXVzF4nSH8+yQ3hN84jLEqouqRmCrUzo0drz+Tykimxx4vMfQsC1FPR419WCsmVciGRrKHawX+SJ3VEDkjW2j8UgHPt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811399; c=relaxed/simple;
	bh=U2lYcjN4DcyhBeyPUHglEcT34gWDq8xG2RVXreDkj7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EI9Fn+XgQlfaTTHYTgFU/pFhe9+H2Mln6QjPK6e8xKu6jlOrrWAxJOvgiRDfcgPQOHI0kggtMMnAj0Blkf7Nz9i0LMoAi9Qjc7RieYO/bdLnMqqEeKdwjYZv67Ijb2bQIbnlif8/oMEotrk6MGuEwDPYjzauyBee4Rzo7DOvEJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1UdN079; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5ed43460d6bso10604634a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 06:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744811396; x=1745416196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KU4UQDxvbw9wsUZMGMkx2xCKrWwv8r5dO5qGBh3pIFw=;
        b=L1UdN079CF1VMMIuy7yZluk1ca2Pua7ZeJOL3VVMBbUKOmJQgBJDquDLI+xqnqWg0c
         RQ/Zikg9Iy43KQdyXb10sVCM7T+6hpXDg6eSVdiny+xU+ytVoGXOqtqamzMzIfOG2zvL
         Er0hv6uKI8WNL7Jeamsz+dKd9MHzFcngIDxTGNjT9flV0cLnLRaEMx+Q78dqfWnrGNL1
         dhavj9Twg/3q6410LCABE7uq/oETGlVN/BIsECLTpIwcEXEYhpJ2T6OwG6bImpoxfJ4u
         leawPhllVt93OXrnHGSN9KYR/XjG+Pmpud1EWrU9sy+PahuExECPSKNrNWRnh1QyuF6M
         j/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744811396; x=1745416196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KU4UQDxvbw9wsUZMGMkx2xCKrWwv8r5dO5qGBh3pIFw=;
        b=QYzfxjopdp1To4438yxmkOI8QinGxBJw26Dx+SJnjidv/thRrb7e/XkaBUXRorV+7L
         X16+iLdxKlr9Qbq5bhp0QEk5+89BO6NQx84FNBNXhK9kAqswYMmT8qqAyfLUv3maE225
         /LjI9AInGSMqTEgXRahtT9nHsQFJJVx2r/riphnvBg6qagpFxXx0mwD+NQXRFp9HTC4w
         g0OL7QuY0iq+l2dy3hqtzokPjOto0Lu3r+zkilQpJDNLgshVw88RPEIIZADh6bhRVyJ7
         6NXmCYr/XPm3Ivo+7oRmYPQvUTd7vYsZfgais0yrR4z/tpP1RAYTCg8H7BGlEn1AsMtZ
         7+tg==
X-Forwarded-Encrypted: i=1; AJvYcCUyHnSI3z7Z/hgqs9LcsHrSHJm0Gyr2PXcTIoaUlZmvdJGfmjjkUxaXwCKffA3bYVrHopeKtnUh0+RpvGjp@vger.kernel.org
X-Gm-Message-State: AOJu0YyI5/jQ9L0t+quGw4txa2sER6Et/7BlD8t/KzhU9XFzfDea1gTw
	a8LRuIcvUxBc4SiX9o1ZZmBHigzGR0c6XaxkhtYjPlQnKjgBW/Zb+298Dg3Tj+/aHR/LHzPZms0
	wTRTZC5tat7GwvStPRy6R6TTohAw=
X-Gm-Gg: ASbGnct8oOtKBHNUyDxWaWweug8W0jjwyKsEuWiozF2+38ZFPGGczPRGKskrDN7Zx2G
	WwUoAmTcvqqHNlWMzftLyfR0J4sMaBI68Liyuxd+9G3SIAcSOk8soTO26a+85vlA1yrLlrfTwGH
	vmSmmEI5sutM63Tw8Mc2pn+g==
X-Google-Smtp-Source: AGHT+IHOgcWeybRzWTGJ6NzFuhrpaoal06R6BRx3IJyJ8jWq3lbax5jRbEc+bRuSEYYflongomtbsuzWfL2BlyZ1mTA=
X-Received: by 2002:a17:907:7246:b0:acb:3a0d:852c with SMTP id
 a640c23a62f3a-acb42aee723mr150472666b.38.1744811395686; Wed, 16 Apr 2025
 06:49:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416-work-mnt_idmap-s_user_ns-v1-0-273bef3a61ec@kernel.org> <20250416-work-mnt_idmap-s_user_ns-v1-1-273bef3a61ec@kernel.org>
In-Reply-To: <20250416-work-mnt_idmap-s_user_ns-v1-1-273bef3a61ec@kernel.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 16 Apr 2025 15:49:43 +0200
X-Gm-Features: ATxdqUEprhJGtBdWtRRQ6kvIhIY_yDBAQLrtQCD8bPmhLECaw_cuwFCnZJBhQgY
Message-ID: <CAGudoHGQ=2B8F84YOzR1Xse3XjheYbWZnCfpLjfxYKabvceTtQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] inode: add fastpath for filesystem user namespace retrieval
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 3:17=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> We currently always chase a pointer inode->i_sb->s_user_ns whenever we
> need to map a uid/gid which is noticeable during path lookup as noticed
> by Linus in [1]. In the majority of cases we don't need to bother with
> that pointer chase because the inode won't be located on a filesystem
> that's mounted in a user namespace. The user namespace of the superblock
> cannot ever change once it's mounted. So introduce and raise IOP_USERNS
> on all inodes and check for that flag in i_user_ns() when we retrieve
> the user namespace.
>
> Link: https://lore.kernel.org/CAHk-=3DwhJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_P=
rPqPB6_KEQ@mail.gmail.com [1]
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/inode.c                    |  6 ++++++
>  fs/mnt_idmapping.c            | 14 --------------
>  include/linux/fs.h            |  5 ++++-
>  include/linux/mnt_idmapping.h | 14 ++++++++++++++
>  4 files changed, 24 insertions(+), 15 deletions(-)
>
> diff --git a/fs/inode.c b/fs/inode.c
> index 99318b157a9a..7335d05dd7d5 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -245,6 +245,8 @@ int inode_init_always_gfp(struct super_block *sb, str=
uct inode *inode, gfp_t gfp
>                 inode->i_opflags |=3D IOP_XATTR;
>         if (sb->s_type->fs_flags & FS_MGTIME)
>                 inode->i_opflags |=3D IOP_MGTIME;
> +       if (unlikely(!initial_idmapping(i_user_ns(inode))))
> +               inode->i_opflags |=3D IOP_USERNS;
>         i_uid_write(inode, 0);
>         i_gid_write(inode, 0);
>         atomic_set(&inode->i_writecount, 0);
> @@ -1864,6 +1866,10 @@ static void iput_final(struct inode *inode)
>
>         WARN_ON(inode->i_state & I_NEW);
>
> +       /* This is security sensitive so catch missing IOP_USERNS. */
> +       VFS_WARN_ON_ONCE(!initial_idmapping(i_user_ns(inode)) &&
> +                        !(inode->i_opflags & IOP_USERNS));
> +
>         if (op->drop_inode)
>                 drop =3D op->drop_inode(inode);
>         else
> diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
> index a37991fdb194..8f7ae908ea16 100644
> --- a/fs/mnt_idmapping.c
> +++ b/fs/mnt_idmapping.c
> @@ -42,20 +42,6 @@ struct mnt_idmap invalid_mnt_idmap =3D {
>  };
>  EXPORT_SYMBOL_GPL(invalid_mnt_idmap);
>
> -/**
> - * initial_idmapping - check whether this is the initial mapping
> - * @ns: idmapping to check
> - *
> - * Check whether this is the initial mapping, mapping 0 to 0, 1 to 1,
> - * [...], 1000 to 1000 [...].
> - *
> - * Return: true if this is the initial mapping, false if not.
> - */
> -static inline bool initial_idmapping(const struct user_namespace *ns)
> -{
> -       return ns =3D=3D &init_user_ns;
> -}
> -
>  /**
>   * make_vfsuid - map a filesystem kuid according to an idmapping
>   * @idmap: the mount's idmapping
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 016b0fe1536e..d28384d5b752 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -663,6 +663,7 @@ is_uncached_acl(struct posix_acl *acl)
>  #define IOP_DEFAULT_READLINK   0x0010
>  #define IOP_MGTIME     0x0020
>  #define IOP_CACHED_LINK        0x0040
> +#define IOP_USERNS     0x0080
>
>  /*
>   * Keep mostly read-only and often accessed (especially for
> @@ -1454,7 +1455,9 @@ struct super_block {
>
>  static inline struct user_namespace *i_user_ns(const struct inode *inode=
)
>  {
> -       return inode->i_sb->s_user_ns;
> +       if (unlikely(inode->i_opflags & IOP_USERNS))
> +               return inode->i_sb->s_user_ns;
> +       return &init_user_ns;
>  }
>
>  /* Helper functions so that in most cases filesystems will
> diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.=
h
> index e71a6070a8f8..85553b3a7904 100644
> --- a/include/linux/mnt_idmapping.h
> +++ b/include/linux/mnt_idmapping.h
> @@ -25,6 +25,20 @@ static_assert(sizeof(vfsgid_t) =3D=3D sizeof(kgid_t));
>  static_assert(offsetof(vfsuid_t, val) =3D=3D offsetof(kuid_t, val));
>  static_assert(offsetof(vfsgid_t, val) =3D=3D offsetof(kgid_t, val));
>
> +/**
> + * initial_idmapping - check whether this is the initial mapping
> + * @ns: idmapping to check
> + *
> + * Check whether this is the initial mapping, mapping 0 to 0, 1 to 1,
> + * [...], 1000 to 1000 [...].
> + *
> + * Return: true if this is the initial mapping, false if not.
> + */
> +static inline bool initial_idmapping(const struct user_namespace *ns)
> +{
> +       return ns =3D=3D &init_user_ns;
> +}
> +
>  static inline bool is_valid_mnt_idmap(const struct mnt_idmap *idmap)
>  {
>         return idmap !=3D &nop_mnt_idmap && idmap !=3D &invalid_mnt_idmap=
;
>
> --
> 2.47.2
>

I don't have an opinion.

But if going this way, i think you want the assert for correctly
applied flag when fetching the ns, not just iput_final.

--=20
Mateusz Guzik <mjguzik gmail.com>

