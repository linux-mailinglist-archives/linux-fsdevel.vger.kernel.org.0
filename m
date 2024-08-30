Return-Path: <linux-fsdevel+bounces-28048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F979662E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE931283A75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893791AD9FC;
	Fri, 30 Aug 2024 13:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ev78sTor"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7248413635B;
	Fri, 30 Aug 2024 13:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725024470; cv=none; b=ZZTYxpaK3gtwRKMMhFQx8QAMXyRTUhjxEA5mc2nb1SEtuZlrIYwF4r1C4h4PokZcduSb9LsM2L7DTyg4Mmago4dOyu5ufrZBQ/xsrlZQd847qtoTuzmDfyy+Y1NycQWI6ljHBW/iQFrXipuHZBe2vbeDb3HHUlUXOmttNyJyptw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725024470; c=relaxed/simple;
	bh=JPKvEn8A70Iyu7bi/E5aTjPAzN9sDm4gTJXckhPhUmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pefr1jCcxo3Nma6yWkhIeampEodiSnuYlLHVm/0pXHwGL+O/DRA9mjFEJvHQBJpg14Jo7oWk8DnpOmn8aAv1X12sAj/Byu4kMrrT0g4R5MWFdEg4UZVWdGTfLXi2/feWwXFwXZOo6IKALZelgm//9ye3mt2/ISY1CEvMe6Spqok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ev78sTor; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a8160a710aso31036685a.1;
        Fri, 30 Aug 2024 06:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725024467; x=1725629267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0fQtEZ1ICLDkaWZ1T0pWo4aOASu1Svug97GOZieu4s=;
        b=ev78sTorUXpF8mBMG3gyjqNlqzklHFZ7u7+6ojIYY/Xt/j283CDRpDcx6V6+OmIHVY
         jwZB08vjJ5rhiOhtMqOhLKz++F8lwp8J1nSIx94uqR309jhIA8BxiFPM0HwrzmbzgNbn
         443ll7FdFAt/edPJJobjcTXe9kf3qNrQYp9Tcvjk+rh9yw9ZZWu0BSwm8nHehhZpbm9C
         0Trls8LME6f+FS1ajrl9RBMNKfBDu/v4zowCIfht9zNYbj7NX0orY+cbtKBP4S7w6IZp
         /3kL1rWV7fLygc/8haou60R7ZdgTwl5iTWTmSvJAZcsYGoImm04JA6/kEKHLgXMS4VRm
         9IUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725024467; x=1725629267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0fQtEZ1ICLDkaWZ1T0pWo4aOASu1Svug97GOZieu4s=;
        b=u/NOBdZm74I0gQX2ImYAOAomcm6dTfqbiAcue2DXa2Qu91V0un1rfu21E976Kn4fLQ
         E1bNJUVvnrzw5OcAPRFDYrKuZ79spAp7079/u5zzZPk7xtFHkOZmTWe60NblUr9XwTll
         ygdYrbjvpA4r8V6vUHTTYnBK6tFpIKV8YlH78liKcDvgg49ubCXxLCAyLomLIOR3K6zV
         qAPNjBErPzzh/bcKG5/UXPm1OEtn4O6SFusQUGiGUAu+Ir92YR0MMqtQtx5aqQQWtvdP
         204pvEKRQdCXFf7ldAgwdXlcdu6GAXix91mbLeYZUmNT6g9LdEtlDx5Db9GC+AZ3LSLO
         qosw==
X-Forwarded-Encrypted: i=1; AJvYcCV7Ah9siULzjgLCWqyuchyEr2r7X5h0bokYL5x0waglzoN5UOA9RgPFT8UdKQTl2evGMY8OKgbiUq9pjgPoVQ==@vger.kernel.org, AJvYcCVRW4q8Lub3C8YG0fRq7nfncyZsNUaAUo4wTXnVE8N5V+40Hl4qWOTzllh8ypcnDLeJm0jvieu8DL1UwlIciw==@vger.kernel.org, AJvYcCWMftL7fZACqy2Fg4xuQ+VqYDxn4Rs6bREe/uy0CBppUNIAaAjpaqtUbP0sVzW/KHbs2IJnkoGt@vger.kernel.org, AJvYcCXb7ezDyqsMVvGvjwdnJaIB6tNG0oxSftCzxJVEd6lShrNmFTFlYWBqIQz5t56xWufMAQfOsU5dOQQBcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZVTfZ8M0uFcdBpTyOwbMAkkYo4s/2gca+qMG/eyHZvlh6Jc/w
	JHRRcQ4BzTYzeddlepSMScoYtWLkjKRAu8eLNH4gXtG3YvLYehPSL+tYBIg8m9zGA2dZtRwqpCJ
	bKNeSGK2OSDcX94wDI7Ob4GvX7tw=
X-Google-Smtp-Source: AGHT+IFANmc9HYz2FBGxDDKmRA2mJlToD2j7J0B1RRXuJ3DslAPYNCOC3QzrqdAFLda7l6RK3XFqI2dgu7d6t36GX4E=
X-Received: by 2002:a05:620a:c4b:b0:79f:741:5d56 with SMTP id
 af79cd13be357-7a8041837fbmr668282685a.6.1725024466943; Fri, 30 Aug 2024
 06:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxi4B8JHYHF=yn6OrRZCdkoPUj3-+PuZTZy6iJR7RNWcbA@mail.gmail.com>
 <20240730042008.395716-1-haifeng.xu@shopee.com>
In-Reply-To: <20240730042008.395716-1-haifeng.xu@shopee.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 30 Aug 2024 15:27:35 +0200
Message-ID: <CAOQ4uxhs==_-EM+VyJRRCX_NPmYybPDBW2v7cXz33Qt2RMaPnQ@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: don't set the superblock's errseq_t manually
To: Haifeng Xu <haifeng.xu@shopee.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Theodore Tso <tytso@mit.edu>
Cc: miklos@szeredi.hu, linux-unionfs@vger.kernel.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Ext4 <linux-ext4@vger.kernel.org>, 
	fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 6:20=E2=80=AFAM Haifeng Xu <haifeng.xu@shopee.com> =
wrote:
>
> Since commit 5679897eb104 ("vfs: make sync_filesystem return errors from
> ->sync_fs"), the return value from sync_fs callback can be seen in
> sync_filesystem(). Thus the errseq_set opreation can be removed here.
>
> Depends-on: commit 5679897eb104 ("vfs: make sync_filesystem return errors=
 from ->sync_fs")
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> ---
> Changes since v1:
> - Add Depends-on and Reviewed-by tags.
> ---
>  fs/overlayfs/super.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 06a231970cb5..fe511192f83c 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -202,15 +202,9 @@ static int ovl_sync_fs(struct super_block *sb, int w=
ait)
>         int ret;
>
>         ret =3D ovl_sync_status(ofs);
> -       /*
> -        * We have to always set the err, because the return value isn't
> -        * checked in syncfs, and instead indirectly return an error via
> -        * the sb's writeback errseq, which VFS inspects after this call.
> -        */
> -       if (ret < 0) {
> -               errseq_set(&sb->s_wb_err, -EIO);
> +
> +       if (ret < 0)
>                 return -EIO;
> -       }
>
>         if (!ret)
>                 return ret;
> --
> 2.25.1
>

FYI, this change is queued in overlayfs-next.

However, I went to see if overlayfs has test coverage for this and it does =
not.

The test coverage added by Darrick to the mentioned vfs commit is test xfs/=
546,
so it does not run on other fs, although it is quite generic.

I fixed this test so it could run on overlayfs (like this):
# This command is complicated a bit because in the case of overlayfs the
# syncfs fd needs to be opened before shutdown and it is different from the
# shutdown fd, so we cannot use the _scratch_shutdown() helper.
# Filter out xfs_io output of active fds.
$XFS_IO_PROG -x -c "open $(_scratch_shutdown_handle)" -c 'shutdown -f
' -c close -c syncfs $SCRATCH_MNT | \
        grep -vF '[00'

and it passes on both xfs and overlayfs (over xfs), but if I try to
make it "generic"
it fails on ext4, which explicitly allows syncfs after shutdown:

        if (unlikely(ext4_forced_shutdown(sb)))
                return 0;

Ted, Darrick,

Do you have any insight as to why this ext4 behavior differs from xfs
or another idea how to exercise the syncfs error in a generic test?

I could fork an overlay/* test from the xfs/* test and require that
underlying fs is xfs, but that would be ugly.

Any ideas?

Thanks,
Amir.

