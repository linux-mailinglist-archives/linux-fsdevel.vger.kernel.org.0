Return-Path: <linux-fsdevel+bounces-70463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1C4C9C07D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 16:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7FE13A4EBD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 15:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A40D322C89;
	Tue,  2 Dec 2025 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhmpyZ2n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD351EB193
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764690750; cv=none; b=WfeU+K/iF8DlaX2/g7ktcUx3IZ61Suy7dmDN9uq/nYi4LzWFl0RuhMVEz1RG8rqNlRrKYOePZGjyNh02YiIwCRFNniQdITSagB+HafyM+lqS365fiOfZdBQUkRWwV0UIuyU0fkO80aXgvUbFXhFrCb1NnVVGg1bNyf+Lig/pDMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764690750; c=relaxed/simple;
	bh=GkBYoUW2qrN93TUysIlXM/ON6wKoM5tpeQF1AMakzqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YvqS+o0Mk9ZFZ56Q4l48m00YKqQBYXJxU9nKFw/hzYdX5eFMTOTdci0COTPCATcqyswCZiXRDB9E8ObpUOAT1YxQ1dIK+YyRsX5pGQ0hFZ5zCONlMizUSNeAXomfLmbl4efV/SO7Vib/yJYDyo5Sk4TENSUgzVd0DZb7YIRStss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhmpyZ2n; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c76f65feb5so4088546a34.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 07:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764690747; x=1765295547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feKc1u+4lQENkn8pYvf0cy6PA0Ii+7sQgsN0RQiueGQ=;
        b=DhmpyZ2n4u9nrLod70Z7T8ToHW8AXnv6nL4e2KQmxNrwtH64PeZOBQykjFZIUk3ABR
         BifUNxw0f1wI8ZCoBCnhwPF7pzPXnvMgN57G5/LLEj/Duhe2le78AwMYMNef+6qRe7+Q
         MXY04h6QBpiB+slSwiXcaPziRoFh0aumwqNLHbBuRLVmIQfYXUiCWpZm4zK7cN+y9E3Y
         4dZWyCgM6q/E6xjRawgl1RxIMvq15rr54zoe/hm5+a/2Ryg6sBGUTgLgSKX3OzD4M70i
         ZVKEr71RM13/Xb5f5PKPsvao3fYnagotlyP9bkUezgLhysdlM0HYQCrHk4XHRqcs/wsg
         P3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764690747; x=1765295547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=feKc1u+4lQENkn8pYvf0cy6PA0Ii+7sQgsN0RQiueGQ=;
        b=Vrp7hN0pYDsiK2sp24A5lIHw1KHkDvQqlzBpjw0Yuetp4hzOUCM1VjnDHgM4CK20Oz
         oPoDao4TKVvGQhPV1OOg+KBjF0l3uD+3wvSbCfkrG+SF7zAcHTN7QKjDrCq4DkN8gn3U
         B54r0fmkidKvlGRaHqIj2lslHvnW8Wm+HXfK51zK3o6C8NYMd/div6HAP8VSITD7E2zz
         qU9vJxev8bcimIDNGVVqhYwEEq7JuSHeq0Z1ovUgybZ3RdsnMr9YkmxwuEiS7krBOz1t
         OC04Nw9//356aQ+Ay7CrVrVhBk6xQNstefnEMe1GTyEUI3y7wg85uzWpaLBq/kZtCvFa
         jodA==
X-Forwarded-Encrypted: i=1; AJvYcCUxoYNcyvs1rq6Iw2OjusQDeIarRFYnGw+KkY3VXNooEnmkgasc7c2hnsiLoaxjBXrY61m2TwrdNBp4potl@vger.kernel.org
X-Gm-Message-State: AOJu0YwIZnb2wMtoaISUEm52VKkphHDlhpZr5mCpai2ace0v23rnbdoh
	u9zG4brGUpX3YKUkUSKHNvaM+pph8n2e+464eHSjNvlyIEWgLAXaHJvUKMVxm5dn28OfL2hY+Qt
	rImSPspFgpCrpi7C4es/BibvhepdGR70=
X-Gm-Gg: ASbGncuAOlTIn81ODqiPzJ/XOQJjKw3tYWAOXGjzHJGLXTQyDNdYUT4WXUCz3DpUkd6
	7tqn0fNxucC+gjwkTiP28iZBD31eaNkGY4NcY81UjAMkx/Ci/VdgARDIKo/Me2mj7ETrPn2nmq7
	Fd3pVkERbYewMkl4SkXvWOrJ+aJxvK5nSmuviq2FXkH+ZdFUl+wnMeHoQDwyVxaP9smLg/2Nl9I
	wOwnrPEdqiEEC4N1ZgOqC1u5MTIOCWcPQ0TUW8Sz7PP7PIlDu8p/bFSExF7R/DInWvAIEsF
X-Google-Smtp-Source: AGHT+IHp6tZtEWeFByJZk/vtVUTBda0yahAChbF25/FmOCHgyPwNW8b96ReF11OQ0plce80g1whgm2I9wT8MTG/sn5o=
X-Received: by 2002:a05:6830:440d:b0:7b2:aba7:f4e with SMTP id
 46e09a7af769-7c798be2dbfmr26198349a34.10.1764690746975; Tue, 02 Dec 2025
 07:52:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251129091455.757724-1-b.sachdev1904@gmail.com> <20251129091455.757724-3-b.sachdev1904@gmail.com>
In-Reply-To: <20251129091455.757724-3-b.sachdev1904@gmail.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Tue, 2 Dec 2025 07:52:15 -0800
X-Gm-Features: AWmQ_blWeFxHHcTZhTAqG8S6zqfjoT09D7pKTYe9CdzPUdirY1xoFo3obwNHy2I
Message-ID: <CANaxB-zRh1=Azkx3fO4tmUAwzjQVE=-0=PeTN9aM1MxK1UzM+Q@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] statmount: accept fd as a parameter
To: Bhavik Sachdev <b.sachdev1904@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	criu@lists.linux.dev, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	John Hubbard <jhubbard@nvidia.com>, Amir Goldstein <amir73il@gmail.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, Andrew Donnellan <ajd@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 1:15=E2=80=AFAM Bhavik Sachdev <b.sachdev1904@gmail=
.com> wrote:
>
> Extend `struct mnt_id_req` to take in a fd and introduce STATMOUNT_BY_FD
> flag. When a valid fd is provided and STATMOUNT_BY_FD is set, statmount
> will return mountinfo about the mount the fd is on.
>
> This even works for "unmounted" mounts (mounts that have been umounted
> using umount2(mnt, MNT_DETACH)), if you have access to a file descriptor
> on that mount. These "umounted" mounts will have no mountpoint and no
> valid mount namespace. Hence, we unset the STATMOUNT_MNT_POINT and
> STATMOUNT_MNT_NS_ID in statmount.mask for "unmounted" mounts.
>
> In case of STATMOUNT_BY_FD, given that we already have access to an fd
> on the mount, accessing mount information without a capability check
> seems fine because of the following reasons:
>
> - All fs related information is available via fstatfs() without any
>   capability check.
> - Mount information is also available via /proc/pid/mountinfo (without
>   any capability check).
> - Given that we have access to a fd on the mount which tells us that we
>   had access to the mount at some point (or someone that had access gave
>   us the fd). So, we should be able to access mount info.
>

Acked-by: Andrei Vagin <avagin@gmail.com>

> Co-developed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> Signed-off-by: Bhavik Sachdev <b.sachdev1904@gmail.com>
> ---
>  fs/namespace.c             | 102 ++++++++++++++++++++++++-------------
>  include/uapi/linux/mount.h |  10 +++-
>  2 files changed, 76 insertions(+), 36 deletions(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index ee36d67f1ac2..73ffa1fbdad7 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -5563,31 +5563,49 @@ static int grab_requested_root(struct mnt_namespa=
ce *ns, struct path *root)
>
>  /* locks: namespace_shared */
>  static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
> -                       struct mnt_namespace *ns)
> +                        struct file *mnt_file, struct mnt_namespace *ns)

no spaces at the start of a line, code indent should use tabs.

./scripts/checkpatch.pl can help to avoid this sort of typos.

Thanks,
Andrei

