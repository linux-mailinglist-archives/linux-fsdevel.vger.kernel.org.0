Return-Path: <linux-fsdevel+bounces-46050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9319A81F9B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 10:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D7F27B4AB2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 08:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD9225B692;
	Wed,  9 Apr 2025 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUxyQti9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A809B25B667;
	Wed,  9 Apr 2025 08:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744186798; cv=none; b=j3uxer97DF7cwyN76iCJVt80Lj4wYygTJ93sM0aXKZoOjn3aYXtt6WaVeZHz70MmAdPfTF8diPvhIPHvZ3tQE9inaGhx8tfxSM53MeJvuCGSUaUsTF2S0CUp7P4N1OlIUAtUTfcNSDTcmoQNjeMKd/maVoXUbBDXBaW/fAM+2pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744186798; c=relaxed/simple;
	bh=fTe0hhI0fBQiFBtDWwd392yYDUZHI1O6YilvDVmyYPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgscawjacTDg9ZZsS6n8NcSEoidv3Zx6WTLTlxPFU284X3jAgPiMaBC1iaA9xZeIItbbdV0GIC6RAfuj4eUQKtHDQHaaNstwrDzX0iulAJae6OoMuOwN0aII+MqqRh2kL10xBdCSr1d8GM0EG0GOwQPzgzspxWXO8lQs/SmbhQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUxyQti9; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5e63162a0so10132719a12.3;
        Wed, 09 Apr 2025 01:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744186795; x=1744791595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onEh1vXtzWmAcc40knx0PkKQCXNJ+i5/An428jCeSG4=;
        b=GUxyQti9tyJtfhZ7y7C4SgkdYW6wt89ZE3TkIgvsXWOBLzp9LMhLreM5q8dXNLV40q
         2bJI1gKDmohHSpmjNQ2zzdK/TnBAucN0vsSQyFyH6ufyoBivGknabiNBffT5C7ERBLrg
         RNwDaGvM6YDQ7iziuOGNQRSNWbczu1zvHxiTdg48te5Zx+CWfPaY1n2yu/LEUVz2RMRs
         NwUDOG1fL2LbXcYwtB0OOQ18cihEAVOTNs73PtdzYlL8f3+ijwknDLrVGyIenNb0av7J
         KblufU8oTBP4nbVKO2UPqw1OzOelmTiMkrMzRaACUvassLFL8uM7LM4lSJuhBU9sMk7d
         7jVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744186795; x=1744791595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onEh1vXtzWmAcc40knx0PkKQCXNJ+i5/An428jCeSG4=;
        b=XlKgu0mjHtJsc8Ta6dnW8LwhXEV6OymxE1e0cNvqdCpt2/3RgwkrWAF7EGzL8AmdAO
         j4m7L8HmPmGt44h3r2P4Fpoad+JnzGK69Eh2qi0hFGneM9Es4KiiN/wx3D2HqZwlmu0o
         LpLR4Jeqx2fMGeebZzMz897ywyw1gQRnCh7oA8BkvsJNZLZs5da6nsro3I8/w4IQnix3
         H87YvXv+9n+I82v4m0eN85vMyxaEzD1I9Esm7xoW/KLb2ZGGzjXtYO2u7dr17DqZTyID
         +J7NdWL9bU3NKowoFgAblJYr5vdNL7DKjsF8A8akCE/t8eZq0+KsgqWCXfaPWqYNmzU6
         Zoeg==
X-Forwarded-Encrypted: i=1; AJvYcCXaEbH39+J4Kd5zojPT3ECXK8gpTc2MdVcvlC5meYagCwSIT1hkXUhrI1/oPPQWgSfPcv3//nAa87v0TR04WA==@vger.kernel.org, AJvYcCXrLt5MhFWrtrSKwwfopRMOz+YAEXlSJeOqyeWnT4jK73AOFD0TC7aWq88rlDSW9mzl2qWjEwKsmv4QlLZb@vger.kernel.org
X-Gm-Message-State: AOJu0YyUaMp3hd3JmlKG44bEWbpRm92NfoSXRuEOPCzmZWcPlT8slTJz
	qedjtUt3isHUCKsh5pXEg8zy8lwULOk2ljeF4jhmF/H9FjLmtOL0UW/P+5vY5EDIKnBIJAHYLbz
	Fq5tp5IYG/VxQldb4YY/KaBIEtQZ1/4wnZRI=
X-Gm-Gg: ASbGncuYgRzTM6OteDJbzdwwtJJoeiOwkIeedKzd5usV2sx/Xiol8hafLxSkf5k1zU/
	tFpLGzzKHUVTjVRAna6OgXDjGh7p43fmnVQGnWmFtQmtgW3LGjNZ7DnEHhJ6OR7HEuUnL4b4AU3
	DUNIubvkskeUHELY903wU/iw==
X-Google-Smtp-Source: AGHT+IECxdRqM+TIETam97Lz4fnsImtOwfcMsB4TsfxzeWtioMP8nsrnSh2qSZbliqH3odD5xCEMRmB9PM0alv7aX0E=
X-Received: by 2002:a17:907:2da2:b0:ac6:e33e:9ef8 with SMTP id
 a640c23a62f3a-aca9b64d7edmr191692766b.2.1744186794464; Wed, 09 Apr 2025
 01:19:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408154509.674118-1-mszeredi@redhat.com>
In-Reply-To: <20250408154509.674118-1-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 9 Apr 2025 10:19:43 +0200
X-Gm-Features: ATxdqUH7-_iG0H2lxZQz-y0KtzQagIJQEb18ZkRPFQ03ooWVMqRyUlFkjt8vNOc
Message-ID: <CAOQ4uxhvm5Xi79vfdc_qmVV8WR-zaoUcQ8ruf6wrEZbQV7UggQ@mail.gmail.com>
Subject: Re: [PATCH] overlay/08[89]: add tests for data-only redirect with userxattr
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: fstests@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>, 
	Alexander Larsson <alexl@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 5:45=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.com>=
 wrote:
>
> New kernel feature (target release is v6.16) allows data-only redirect to
> be enabled without metacopy and redirect_dir turned on.  This works with =
or
> without verity enabled.
>
> Tests are done with the userxattr option, to verify that it will work in =
a
> user namespace.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

With some minor nits below fixed, you may add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  common/overlay        |  29 +++++
>  tests/overlay/088     | 296 ++++++++++++++++++++++++++++++++++++++++++
>  tests/overlay/088.out |  39 ++++++
>  tests/overlay/089     | 272 ++++++++++++++++++++++++++++++++++++++
>  tests/overlay/089.out |   5 +
>  5 files changed, 641 insertions(+)
>  create mode 100755 tests/overlay/088
>  create mode 100644 tests/overlay/088.out
>  create mode 100755 tests/overlay/089
>  create mode 100644 tests/overlay/089.out
>
...
> +test_common()
> +{
> +       local _lowerdir=3D$1 _datadir2=3D$2 _datadir=3D$3
> +       local _target=3D$4 _size=3D$5 _blocks=3D$6 _data=3D"$7"
> +       local _redirect=3D$8
> +
> +       echo "Mount ro"
> +       mount_ro_overlay $_lowerdir $_datadir2 $_datadir
> +
> +       # Check redirect xattr to lowerdata
> +       [ -n "$_redirect" ] && check_redirect $lowerdir/$_target "$_redir=
ect"
> +
> +       echo "check properties of metadata copied up file $_target"

Remove "metadata"

> +       check_file_size_contents $SCRATCH_MNT/$_target $_size "$_data"
> +       check_file_blocks $SCRATCH_MNT/$_target $_blocks
> +
> +       # Do a mount cycle and check size and contents again.
> +       echo "Unmount and Mount rw"
> +       umount_overlay
> +       mount_overlay $_lowerdir $_datadir2 $_datadir
> +       echo "check properties of metadata copied up file $_target"

Remove "metadata"

> +       check_file_size_contents $SCRATCH_MNT/$_target $_size "$_data"
> +       check_file_blocks $SCRATCH_MNT/$_target $_blocks
> +
> +       # Trigger metadata copy up and check absence of metacopy xattr.

Wrong description. maybe
       # Trigger copy up and check upper file properties.

> +       chmod 400 $SCRATCH_MNT/$_target
> +       umount_overlay
> +       check_file_size_contents $upperdir/$_target $_size "$_data"
> +}
> +
...
> diff --git a/tests/overlay/088.out b/tests/overlay/088.out
> new file mode 100644
> index 000000000000..c85c998d503a
> --- /dev/null
> +++ b/tests/overlay/088.out
> @@ -0,0 +1,39 @@
> +QA output created by 088
> +
...

> +
> +=3D=3D Check follow to lowerdata layer with absolute redirect =3D=3D
> +Mount ro
> +check properties of metadata copied up file datafile
> +Unmount and Mount rw
> +check properties of metadata copied up file datafile
> +Mount ro
> +check properties of metadata copied up file datafile2
> +Unmount and Mount rw
> +check properties of metadata copied up file datafile2
> +Mount ro
> +check properties of metadata copied up file shared
> +Unmount and Mount rw
> +check properties of metadata copied up file shared
> +

For all of the above - remove "metadata"

Thanks,
Amir.

