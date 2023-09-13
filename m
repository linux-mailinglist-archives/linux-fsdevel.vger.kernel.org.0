Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C8779E79A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 14:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240249AbjIMMJo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 08:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjIMMJn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:09:43 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0593119A7;
        Wed, 13 Sep 2023 05:09:39 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7a86f1befb3so248346241.1;
        Wed, 13 Sep 2023 05:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694606978; x=1695211778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7PgrZebStsMLGLk3sMmCJDo+2TFRZ9yCLxlUf6YSSY=;
        b=j/5rkXRQjdNmzv1yCaU3I+f60aVndq1aUVCKWjbY6vOEjVnGUnUbn8rcsuSXgYA6jR
         Laj74QHHSyGc+5YRIizCT/PnhJsr38vBEXPOOo3Mmz5136XOzVjSbEksL+7ZpaBuTlgQ
         LtB0R46XGYU6ELlVWafu8WKLpHcYbDoFHSnrXS/3TsKPLCiA08gLaaUg83UUPGWk/R3O
         cNfuLKjO84Dv6n9WDRmd1z2RYJ5eHFnSuT7SKNDt8tkmi7ER0atxA1abLGBOOozLbAi8
         aiwNm1anO+2QxjZ2G44bYoel3N/wjEuR2yLyjEEVobLKWUIMKzp5zzeD/9IvaNcXz1L5
         sTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694606978; x=1695211778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7PgrZebStsMLGLk3sMmCJDo+2TFRZ9yCLxlUf6YSSY=;
        b=Q67idreGCsPhlsPnSDZa0yh3vJT2ziA9zyypnSxx3SAhQH1/IIOJmO8n1nR881QHcV
         fJvwbAx0c+N2IrlHM6HOcrFiwnDxzQwdELu7tmCVBQ4ZvhnQL7Ve683xpQY42Zct0unf
         Kx5BZC052C3Ih75JnwcIUJjlbYCN6j/lSy462PHoJLNUvRM+tlTwmORxob+A8VDBxNda
         Gi/CW7JVlXacwVkVKhgaPEXz3CUQJkpU0fcL2T1ephzHII76UOQ/aDz98oxhZQKDaqsO
         +kOY3Mr179l/V2aSqOzsEPq59GIa4mQtTO210FziFR7U9Sy1JcfY5f35CMVyK/rOXA5j
         HWpg==
X-Gm-Message-State: AOJu0YwhI3gmIpby43Y4KkSx5dpSIX2MI2chixrxFqULMQFZ39AFzVQT
        NrK2fWE0I+t+pRTQyk1WeFxjiuDGNmQysnCuqgXs73I1kAs=
X-Google-Smtp-Source: AGHT+IH1ZHzlcMOlVPi2YBSVN8/CoExSRwU869JxL3LDAlW9iSAvGDqBm5POPzdp6GCjY/ZcvhWHOMExEha9nzUwNHw=
X-Received: by 2002:a67:f24a:0:b0:44e:9614:39bf with SMTP id
 y10-20020a67f24a000000b0044e961439bfmr1915051vsm.6.1694606977746; Wed, 13 Sep
 2023 05:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230913073755.3489676-1-amir73il@gmail.com>
In-Reply-To: <20230913073755.3489676-1-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 13 Sep 2023 15:09:26 +0300
Message-ID: <CAOQ4uxiPREeTmkaxohaqbg_XvngNXdRAssupoo+EdBoDD-FBeg@mail.gmail.com>
Subject: Re: [PATCH] ima: fix wrong dereferences of file->f_path
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 13, 2023 at 10:38=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> When storing IMA xattr on an overlayfs inode, the xattr is actually
> stored in the inode of the underlying (a.k.a real) filesystem, so there
> is an ambiguity whether this IMA xattr describes the integrity of the
> overlayfs inode or the real inode.
>
> For this reason and other reasons, IMA is not supported on overlayfs,
> in the sense that integrity checking on the overlayfs inode/file/path
> do not work correctly and have undefined behavior and the IMA xattr
> always describes the integrity of the real inode.
>
> When a user operates on an overlayfs file, whose underlying real file
> has IMA enabled, IMA should always operate on the real path and not
> on the overlayfs path.
>
> IMA code already uses the helper file_dentry() to get the dentry
> of the real file. Dereferencing file->f_path directly means that IMA
> will operate on the overlayfs inode, which is wrong.
>
> Therefore, all dereferences to f_path were converted to use the
> file_real_path() helper.
>
> Reported-by: syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-unionfs/0000000000005bd097060530b75=
8@google.com/
> Fixes: db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_version")
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Mimi,
>
> Some of the wrong f_path dereferences are much older than the Fixes
> commit, but they did not have as big an impact as the wrong f_path
> dereference that the Fixes commit introduced.
>
> For example, commit a408e4a86b36 ("ima: open a new file instance if no
> read permissions") worked because reading the content of the overlayfs
> file has the same result as reading the content of the real file, but it
> is actually the real file integrity that we want to verify.
>
> Anyway, the real path information, that is now available via the
> file_real_path() helper, was not available in IMA integrity check context
> at the time that commit a408e4a86b36 was merged.
>

Only problem is that fix did not resolve the syzbot bug, which
seems to do the IMA integrity check on overlayfs file (not sure).

I am pretty sure that this patch fixes "a bug" when IMA is on the filesyste=
m
under overlayfs and this is a pretty important use case.

But I guess there are still issues with IMA over overlayfs and this is not
the only one.
Is this really a use case that needs to be supported?
Isn't the newly added SB_I_IMA_UNVERIFIABLE_SIGNATURE flag
a hint that IMA on overlayfs is not a good idea at all?

Thanks,
Amir.

>
>  security/integrity/ima/ima_api.c    |  4 ++--
>  security/integrity/ima/ima_crypto.c |  2 +-
>  security/integrity/ima/ima_main.c   | 10 +++++-----
>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/im=
a_api.c
> index 452e80b541e5..badf3784a1a0 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -268,8 +268,8 @@ int ima_collect_measurement(struct integrity_iint_cac=
he *iint,
>          * to an initial measurement/appraisal/audit, but was modified to
>          * assume the file changed.
>          */
> -       result =3D vfs_getattr_nosec(&file->f_path, &stat, STATX_CHANGE_C=
OOKIE,
> -                                  AT_STATX_SYNC_AS_STAT);
> +       result =3D vfs_getattr_nosec(file_real_path(file), &stat,
> +                                  STATX_CHANGE_COOKIE, AT_STATX_SYNC_AS_=
STAT);
>         if (!result && (stat.result_mask & STATX_CHANGE_COOKIE))
>                 i_version =3D stat.change_cookie;
>         hash.hdr.algo =3D algo;
> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima=
/ima_crypto.c
> index 51ad29940f05..e6c52f3c8f37 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -555,7 +555,7 @@ int ima_calc_file_hash(struct file *file, struct ima_=
digest_data *hash)
>                 int flags =3D file->f_flags & ~(O_WRONLY | O_APPEND |
>                                 O_TRUNC | O_CREAT | O_NOCTTY | O_EXCL);
>                 flags |=3D O_RDONLY;
> -               f =3D dentry_open(&file->f_path, flags, file->f_cred);
> +               f =3D dentry_open(file_real_path(file), flags, file->f_cr=
ed);
>                 if (IS_ERR(f))
>                         return PTR_ERR(f);
>
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index 365db0e43d7c..87c13effbdf4 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -94,7 +94,7 @@ static int mmap_violation_check(enum ima_hooks func, st=
ruct file *file,
>                 inode =3D file_inode(file);
>
>                 if (!*pathbuf)  /* ima_rdwr_violation possibly pre-fetche=
d */
> -                       *pathname =3D ima_d_path(&file->f_path, pathbuf,
> +                       *pathname =3D ima_d_path(file_real_path(file), pa=
thbuf,
>                                                filename);
>                 integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, *pathnam=
e,
>                                     "mmap_file", "mmapped_writers", rc, 0=
);
> @@ -142,7 +142,7 @@ static void ima_rdwr_violation_check(struct file *fil=
e,
>         if (!send_tomtou && !send_writers)
>                 return;
>
> -       *pathname =3D ima_d_path(&file->f_path, pathbuf, filename);
> +       *pathname =3D ima_d_path(file_real_path(file), pathbuf, filename)=
;
>
>         if (send_tomtou)
>                 ima_add_violation(file, *pathname, iint,
> @@ -168,7 +168,7 @@ static void ima_check_last_writer(struct integrity_ii=
nt_cache *iint,
>                 update =3D test_and_clear_bit(IMA_UPDATE_XATTR,
>                                             &iint->atomic_flags);
>                 if ((iint->flags & IMA_NEW_FILE) ||
> -                   vfs_getattr_nosec(&file->f_path, &stat,
> +                   vfs_getattr_nosec(file_real_path(file), &stat,
>                                       STATX_CHANGE_COOKIE,
>                                       AT_STATX_SYNC_AS_STAT) ||
>                     !(stat.result_mask & STATX_CHANGE_COOKIE) ||
> @@ -347,7 +347,7 @@ static int process_measurement(struct file *file, con=
st struct cred *cred,
>                 goto out_locked;
>
>         if (!pathbuf)   /* ima_rdwr_violation possibly pre-fetched */
> -               pathname =3D ima_d_path(&file->f_path, &pathbuf, filename=
);
> +               pathname =3D ima_d_path(file_real_path(file), &pathbuf, f=
ilename);
>
>         if (action & IMA_MEASURE)
>                 ima_store_measurement(iint, file, pathname,
> @@ -487,7 +487,7 @@ int ima_file_mprotect(struct vm_area_struct *vma, uns=
igned long prot)
>                 result =3D -EPERM;
>
>         file =3D vma->vm_file;
> -       pathname =3D ima_d_path(&file->f_path, &pathbuf, filename);
> +       pathname =3D ima_d_path(file_real_path(file), &pathbuf, filename)=
;
>         integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, pathname,
>                             "collect_data", "failed-mprotect", result, 0)=
;
>         if (pathbuf)
> --
> 2.34.1
>
