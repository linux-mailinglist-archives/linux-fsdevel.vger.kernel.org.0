Return-Path: <linux-fsdevel+bounces-57509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 862D4B22AA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 16:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391F3684679
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 14:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1FA2E7BA5;
	Tue, 12 Aug 2025 14:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gV16sq1x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2BB2E2F1B
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 14:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755008781; cv=none; b=RGNl4bKiUJh/A/aBl2/Tc5y4Y6XuG6BmJOpBZT7nK61NMpAHiBH8xm+mXt2Eh74PTNEaZp6GAPcaslSOgC0y29kqvVUF/rrnpPYcB8E0WY3jqabgqqD3rQ8OIF0LwuBaIaRczofag9xNqHIUUSwAkh2PMh2/PArT4x8a6ZRnYdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755008781; c=relaxed/simple;
	bh=BCzl/In8AhCPExTkm7oOiLGhOWvI0LbQdU3xbbH37ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fcy3g28zDjrnEDqUtDW6JCZ5R31SY9V90k6zKWl9p2ze8orQl0AvkQ+U5TwN4Lb21l6/2cy/pGpGO00kcLz/8j0k/uRDnc9MnGflQUy4GCqruEqWPWsNzVILIwxfeIKQV6W3ghQLNkHcd3Kds3UC2GZO8noXxRqC+oFQ9734ZvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gV16sq1x; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61557997574so7907988a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 07:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755008777; x=1755613577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOjDz4BYfzTbC9w5/VauPmNc/kQqhL4hipAPSmqI+4k=;
        b=gV16sq1xUsTDLUXOMJmvGSoasfvWzWV57a1Rtety0nZczEXUGUyRzMbCyrKUt2do3z
         KSL1AkmMPyCHLhFGQxBnn/3ESYy5QXjv/Ajgfn2lmMRV0dZctiuLjawA/vAsm4aKIJYp
         f+c+CjZqscNI6+96p7WaBbhmSEwf/oeeCt3UPo9XSivOCFUYckBdne1n6LZlw0wXP+EG
         sttqJZc1RPoLZOawtc0lK7MfmaDDLH8JZ7w4DFwZABxWDzV65Q3BKqBx9bBKiPp/3WL5
         Aiaw8vrl/k80g9VdpUmPKlLAE01RhZrf9iDnSyxMryguuB0mCuZ6O+MyPBPIudg05M8t
         qkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755008777; x=1755613577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOjDz4BYfzTbC9w5/VauPmNc/kQqhL4hipAPSmqI+4k=;
        b=ITg1jm8eb1TuKobw0312i8rYxLt6nbgljOFseiCRKClDG1AAbJ6ptVAyBydzli04SG
         lWozS8XcOisVgyEFv47nlE+9kFwROj0e/SnR8DMWtgRYr/YDZpiYs4dEHO5BERIECrH+
         LPbAMK/gLVNy5s8gtYi5yyhGEl2uVWGVuj/JVSpMMtG0bpeLVvf7Cma8CQI1cc1uRgH/
         RtrL/wZoRrPcJHMrNKP8AVolUKSpAwB72XJaA16ojuTevuDt6g1lYd/kVklTnSoRyFnN
         RjEGrHHg9zTdLOKXxlxK7PpZWcNEAhgdnunLpKDqcO95/plpzz0HoSX9YOEo2ts6p0ui
         9LGg==
X-Gm-Message-State: AOJu0Yzgvs6EFyvecPAlZi5vm5ATKePsy2snaWSk1PxBmcdWQXhPJJ9x
	s0aIoep7PnhLgf5PXA/5cZBEDd1Q+lZT2FsrD9KA09S9VtfhQ8Ju9ygZ0jv5r232xfmVLxnaXLr
	nQeODyw/jXmFkEPfcA5mUbLyECLRQ3eU=
X-Gm-Gg: ASbGncubBHPDlw8VCDQEWwwRGHDqGpzFG5c9+F5woFaSqYVKwzz2J0msqNvHy6NoxUc
	tnwYwWf9ciN8f+Q89y9aQ6Zzg0RBkM3Ogv62aTsfym0LTh0dNyt7ayajxMJa0gpl4dU/NA7dkcR
	Wq3bCE/UuaThoRfdk/NYowKg+3KZTOl593hrG6WqD8OVHepC/GvekfAi0I3O8C1QmfHNQpJYyaS
	UroqZU=
X-Google-Smtp-Source: AGHT+IGvcQ6+hss6KAC32l1MwZs9FRqdXdWjBMQAn8/ScTTUnYYec0W1yuTBgdHwVk4tf4ZALXk1FnfERlsxY9Bs21s=
X-Received: by 2002:a17:907:7e90:b0:ae3:6d27:5246 with SMTP id
 a640c23a62f3a-afa1e173579mr312456566b.48.1755008777194; Tue, 12 Aug 2025
 07:26:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805183017.4072973-1-mszeredi@redhat.com> <20250805183017.4072973-2-mszeredi@redhat.com>
In-Reply-To: <20250805183017.4072973-2-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 12 Aug 2025 16:26:06 +0200
X-Gm-Features: Ac12FXyyr1hGvAuJ6fWu_gvmKxYuyLFZf29t1lopg1Wl1ZXn04TMDRQzHakCAyY
Message-ID: <CAOQ4uxj4Naa_=fPTXT1n68xsPhtZLPYpe0rd4LhzFotkb+fk=A@mail.gmail.com>
Subject: Re: [PATCH 2/2] copy_file_range: limit size if in compat mode
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>, 
	Florian Weimer <fweimer@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 8:30=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.com>=
 wrote:
>
> If the process runs in 32-bit compat mode, copy_file_range results can be
> in the in-band error range.  In this case limit copy length to MAX_RW_COU=
NT
> to prevent a signed overflow.
>
> Reported-by: Florian Weimer <fweimer@redhat.com>
> Closes: https://lore.kernel.org/all/lhuh5ynl8z5.fsf@oldenburg.str.redhat.=
com/
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/read_write.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 0ef70e128c4a..e2ccc44d96e6 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1576,6 +1576,10 @@ ssize_t vfs_copy_file_range(struct file *file_in, =
loff_t pos_in,
>         if (len =3D=3D 0)
>                 return 0;
>
> +       /* Make sure return value doesn't overflow in 32bit compat mode *=
/
> +       if (in_compat_syscall() && len > MAX_RW_COUNT)
> +               len =3D MAX_RW_COUNT;
> +

1. Note that generic_copy_file_checks() can already shorten len,
    so maybe this should also be done there?? not sure..
2. Both ->remap_file_range() and splice cases already trim to MAX_RW_COUNT
    so the only remaining case for len > MAX_RW_COUNT are filesystems
    that implement ->copy_file_range() and actually support copying ranges
    larger than 2MB (don't know if they actually exist)

IOW, if we do:

if (splice || !file_out->f_op->copy_file_range || in_compat_syscall())
        len =3D min_t(loff_t, MAX_RW_COUNT, len);

We will not need to repeat the same trim of len in 3 different places
in this function.

Thanks,
Amir.

