Return-Path: <linux-fsdevel+bounces-44151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8159A6380A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 00:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD5B3A5529
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 23:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD711A23A5;
	Sun, 16 Mar 2025 23:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPtsxNEp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B671624E9;
	Sun, 16 Mar 2025 23:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742167645; cv=none; b=kEm9Gg/HUI9ihWG3XU8qYDIfD0rMts/PGloFyxioxC+ytO2p6pb/o7e0M7zLHbq4/X36YVS+vquN2hGPhbbf2ny0JQJ7uOwRlfjb2ckDK5gc62risqL/lX6W9dy2VhabPQhpnhIZmF2zRoeP8vP86NF4GkDq9FBVEoYYM4QjNL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742167645; c=relaxed/simple;
	bh=twOmPjp8ilCeZBg9Tm3485xw4BSQ+RnJ/JsEEeY7SiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fw4HCnbxvZXxcTAEIGlLq6nm+2AbTkpl9pEvwSVkKbKYl5usAwP/pTRNaCNxT7Jxlrxe3gPt1Ug5zvnLuod0eqMX7DQUvB/tHV85QiAWtPB0nbfFxK52Phlh/sKh4Q6H3uFeAGAKioIqkMI8ytdlkbems4Xzy9ZHkqFL+kfWC54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPtsxNEp; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e6167d0536so7087371a12.1;
        Sun, 16 Mar 2025 16:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742167642; x=1742772442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWPSKGjAfVrfT1ipdycZ9fBlNnI1+tgTL63vXBqWhME=;
        b=WPtsxNEpThMSmS9UjQGxq5RwH/P2VN2GDh0fsJXhMbM7Y9u+NYhYYIoglBY+sorpbl
         hWnjEbSlB50CITS+6IghK4etmGPOKkoB2tFrtDypv2T9cFmuJ97S/e34ox392/RebGwK
         ipwZvCI+zzmPJtLvZD9YxVo0zP0jW3zYPmqGdQRf/jjJvEFXrbtlvzE9TcF28nFENm/H
         v9IrCKdQNYKKBjDh5/FGzGHYyAPKaJumvhdXVjMS6KvMnKMiWMnX2f7Tr2U/Zs/Bh5kR
         8nEXjhzz0dCY5if4aQKRnhVnZ2rphlP7qYJCnzLfozDhUq6Wkd9UAJxDYXiQqJDeUHvm
         q7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742167642; x=1742772442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWPSKGjAfVrfT1ipdycZ9fBlNnI1+tgTL63vXBqWhME=;
        b=YYfBAcT5VssvtNjXxgRctKWkCMV3lMUFfWVHIbwICtCVLdy6dWaxeZ25CLCxeZ8RzR
         5JXIIUfib7MAK5PA7Eiy7dbUULJ/He+Y7sKSIXnbZDcrhC345smP6sMrrXM4i4dQcYF9
         4XI9m1hX/h6fkrwC80vnSg9CKjYUCPGX+UsXw2p8GKbbUhW7TlNKZDSwwHxfMeHji2qc
         MBl784CZmgDsDDoaW2ZiTG4qF04x5Nw9DqEA63EoiRj+bpWgQsauYkeaq8QMZ4mWPic4
         wE+dwax4f336uHQk0WMMSjppunbO4+JILK9jgIv0QcDSjXiB2B5mM8uTdCz9tt1qtid5
         YWwA==
X-Forwarded-Encrypted: i=1; AJvYcCVkh+5qdBV8CoAWhNFRfeOKjvGSavTeCZNUT0pmJT9xq0ww1fDPXvsvgiPPike3SBHMr+6ZmzvjafqFi7ro@vger.kernel.org, AJvYcCWZcYpMon+W0v2xIZJ20r1QSETS25t43xIonpeoKmGs5fvXFSJvSx1d9eJOKB7oGTElT1EFKx+Wu7nHVX4Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yx39Dk6RjkdiioN9hWzE5xnZUEdNqnIeGsvBJ+FCPruSpHo6vF/
	qi7YawPXVQml/5ecN9HNs2DSy1aKlHACiNOthvRP+z7Ii+stRwc2Zdw3YS5eKm2AuFfGjCHR2Ro
	MUcwbDIATdxX915ULC9vHuG8LGOM=
X-Gm-Gg: ASbGncsJ0HEzSZ1Z9CUmOZCkhQIDtKHY3sVqS5cYiPhGsHbLfJkMbxHLZDHOtDnG8D+
	giW5VfKezcFDvFr69+mHnr8Y4gB2WQhNqNmTd+5Zao13Xs8sK9abOXM+9WrmBDtNJzTSTo4uPne
	7xT+ugeV6z2w2KFwf6zTqT9K8thQ==
X-Google-Smtp-Source: AGHT+IHaKUv0NbWOy1eqkHfnNiVKas+OfE8EoFTFRBgoVQg9vYa5GRZ/l2hXZfpk09QwUbAMeKEfHbUh3wD/YmJtzoM=
X-Received: by 2002:a05:6402:1d53:b0:5e7:f728:5812 with SMTP id
 4fb4d7f45d1cf-5e89f646e18mr10742561a12.19.1742167642014; Sun, 16 Mar 2025
 16:27:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316232421.1642758-1-mjguzik@gmail.com>
In-Reply-To: <20250316232421.1642758-1-mjguzik@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 17 Mar 2025 00:27:09 +0100
X-Gm-Features: AQ5f1JqNHYNdTjcNcsJjZ2Z9Mdc2iY9PM62CQC097tOLduT_vPuy7aYmbTyk0Ow
Message-ID: <CAGudoHFOPkPGQzcuymrW17uf9NksfL2PLA_BDzfDezNoAyfnLQ@mail.gmail.com>
Subject: Re: [PATCH] fs: use wq_has_sleeper() in end_dir_add()
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 12:24=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
>
> The routine is used a lot, while the wakeup almost never has anyone to
> deal with.
>
> wake_up_all() takes an irq-protected spinlock, wq_has_sleeper() "only"
> contains a full fence -- not free by any means, but still cheaper.
>
> Sample result tracing waiters using a custom probe during -j 20 kernel
> build (0 - no waiters, 1 - waiters):
>
> @[
>     wakeprobe+5
>     __wake_up_common+63
>     __wake_up+54
>     __d_add+234
>     d_splice_alias+146
>     ext4_lookup+439
>     path_openat+1746
>     do_filp_open+195
>     do_sys_openat2+153
>     __x64_sys_openat+86
>     do_syscall_64+82
>     entry_SYSCALL_64_after_hwframe+118
> ]:
> [0, 1)             13999 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@|
> [1, ...)               1 |                                               =
     |
>
> So that 14000 calls in total from this backtrace, where only one time
> had a waiter.

I noticed unusually weird engrish after sending.

how about this sentence instead:
> Only 1 call out of 14000 with this backtrace had waiters.


>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  fs/dcache.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/dcache.c b/fs/dcache.c
> index df8833fe9986..bd5aa136153a 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -2497,7 +2497,8 @@ static inline void end_dir_add(struct inode *dir, u=
nsigned int n,
>  {
>         smp_store_release(&dir->i_dir_seq, n + 2);
>         preempt_enable_nested();
> -       wake_up_all(d_wait);
> +       if (wq_has_sleeper(d_wait))
> +               wake_up_all(d_wait);
>  }
>
>  static void d_wait_lookup(struct dentry *dentry)
> --
> 2.43.0
>


--=20
Mateusz Guzik <mjguzik gmail.com>

