Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7AF323113
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 19:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbhBWS7B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 13:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbhBWS66 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 13:58:58 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8D7C061574;
        Tue, 23 Feb 2021 10:58:17 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id h10so27059345edl.6;
        Tue, 23 Feb 2021 10:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c3Zp7Y8jEqsjl7S9sUTF85KS6ayS+qBC9fZSiiv4Ej8=;
        b=PfFv9nEYZoR1CN2KuzO+8+jiDsXhnhhHPGH6Y8dcmCuERip7fX4YQTqcJ+unH4lb3+
         Lc02NYbedkbOPFoJIU4KGskH6vYXmD2yB/6jgsZh8EpZGBUmlioaVmYB5ilhZlo2vQaU
         X6oLBqFKjANjNfkTHV3JYYEpTzZllwcXqHtk4Q40dWiF8RfF3TS7Nhf4k3hoq3iuzB1O
         x4KOErknk8kssJkDeoDhRti/jcm+BqRWWkvzzLxsPkrZStNv4y8I3MVhAxezgaQ0Z+aA
         Ee5GaxGbMOJ/rqmnzX3fv/C0nGL0lNakar0IUucAqqgPz8Lk8/9Hqo7MhK7pm8Efqi8Q
         zs3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c3Zp7Y8jEqsjl7S9sUTF85KS6ayS+qBC9fZSiiv4Ej8=;
        b=Edi5n9rw3d7a5ZJITI7eklJeBWVeKlbFXecfW81yz9vWKPk4unMUDF+Y7EY1eSJNGo
         pPwTgNXOS6I09gMe27uSjgreyelGJWtc0CI2P0Rj6SQ2s2bBA7fYSkAzjDU5XVN1KQo+
         +BcD6Dp0NJwp6J7z2PSk4zkoCuNdZbFTLwCNmt7VOQ34sHNt4xfVrDxEBb9RbDgEaxMq
         rhufFUmLDBrtXBfGWxhYMOrNE5Qb+RiwS/o5EB2eu2N+nnHbepaOx29wCAbFzJ7Y8wXd
         7jhQxDjZRREto6DvzITnKH1J3TyCY/wU64N8EPlzxuzyI+8cNqJoR2KKuBLZWBsy7noC
         UE2g==
X-Gm-Message-State: AOAM533WF9bkEGsiiRnO/ip1bUsXRhi5KiBoMbL6ECab7lYUuQHEW5uf
        dmtA1AiCSzInX6dgGr8hQ/lcm6YoFfwNm2byXw==
X-Google-Smtp-Source: ABdhPJxMV1bqwgvcwMgali0HJUbrzEGCN3F/c7rJKoFZk58xtdX+IBSUb2VNa2+arCTCLyCIcl4xV+nMAnTmhdp0qts=
X-Received: by 2002:a05:6402:1853:: with SMTP id v19mr7932160edy.10.1614106696386;
 Tue, 23 Feb 2021 10:58:16 -0800 (PST)
MIME-Version: 1.0
References: <20210223182726.31763-1-aaptel@suse.com>
In-Reply-To: <20210223182726.31763-1-aaptel@suse.com>
From:   Pavel Shilovsky <piastryyy@gmail.com>
Date:   Tue, 23 Feb 2021 10:58:05 -0800
Message-ID: <CAKywueSCbANjCzPMnWJx7CXQM4kWO4pHtAhgpwwchMqCOcV0Lg@mail.gmail.com>
Subject: Re: [PATCH] cifs: ignore FL_FLOCK locks in read/write
To:     =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>
Cc:     linux-cifs <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Steve French <smfrench@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a flock is emulated on the server side with mandatory locks (which
is what we only have for SMB2 without POSIX extensions) then we should
maintain the same logic on the client. Otherwise you get different
behavior depending on the caching policies currently in effect on the
client side. You may consider testing with both modes when
leases/oplocks are on and off.

--
Best regards,
Pavel Shilovsky

=D0=B2=D1=82, 23 =D1=84=D0=B5=D0=B2=D1=80. 2021 =D0=B3. =D0=B2 10:30, Aur=
=C3=A9lien Aptel <aaptel@suse.com>:

>
> From: Aurelien Aptel <aaptel@suse.com>
>
> flock(2)-type locks are advisory, they are not supposed to prevent IO
> if mode would otherwise allow it. From man page:
>
>    flock()  places  advisory  locks  only; given suitable permissions on =
a
>    file, a process is free to ignore the use of flock() and perform I/O o=
n
>    the file.
>
> Simple reproducer:
>
>         #include <stdlib.h>
>         #include <stdio.h>
>         #include <errno.h>
>         #include <sys/file.h>
>         #include <sys/types.h>
>         #include <sys/wait.h>
>         #include <unistd.h>
>
>         int main(int argc, char** argv)
>         {
>                 const char* fn =3D argv[1] ? argv[1] : "aaa";
>                 int fd, status, rc;
>                 pid_t pid;
>
>                 fd =3D open(fn, O_RDWR|O_CREAT, S_IRWXU);
>                 pid =3D fork();
>
>                 if (pid =3D=3D 0) {
>                         flock(fd, LOCK_SH);
>                         exit(0);
>                 }
>
>                 waitpid(pid, &status, 0);
>                 rc =3D write(fd, "xxx\n", 4);
>                 if (rc < 0) {
>                         perror("write");
>                         return 1;
>                 }
>
>                 puts("ok");
>                 return 0;
>         }
>
> If the locks are advisory the write() call is supposed to work
> otherwise we are trying to write with only a read lock (aka shared
> lock) so it fails.
>
> Signed-off-by: Aurelien Aptel <aaptel@suse.com>
> ---
>  fs/cifs/file.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index 6d001905c8e5..3e351a534720 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -3242,6 +3242,7 @@ cifs_writev(struct kiocb *iocb, struct iov_iter *fr=
om)
>         struct inode *inode =3D file->f_mapping->host;
>         struct cifsInodeInfo *cinode =3D CIFS_I(inode);
>         struct TCP_Server_Info *server =3D tlink_tcon(cfile->tlink)->ses-=
>server;
> +       struct cifsLockInfo *lock;
>         ssize_t rc;
>
>         inode_lock(inode);
> @@ -3257,7 +3258,7 @@ cifs_writev(struct kiocb *iocb, struct iov_iter *fr=
om)
>
>         if (!cifs_find_lock_conflict(cfile, iocb->ki_pos, iov_iter_count(=
from),
>                                      server->vals->exclusive_lock_type, 0=
,
> -                                    NULL, CIFS_WRITE_OP))
> +                                    &lock, CIFS_WRITE_OP) || (lock->flag=
s & FL_FLOCK))
>                 rc =3D __generic_file_write_iter(iocb, from);
>         else
>                 rc =3D -EACCES;
> @@ -3975,6 +3976,7 @@ cifs_strict_readv(struct kiocb *iocb, struct iov_it=
er *to)
>         struct cifsFileInfo *cfile =3D (struct cifsFileInfo *)
>                                                 iocb->ki_filp->private_da=
ta;
>         struct cifs_tcon *tcon =3D tlink_tcon(cfile->tlink);
> +       struct cifsLockInfo *lock;
>         int rc =3D -EACCES;
>
>         /*
> @@ -4000,7 +4002,7 @@ cifs_strict_readv(struct kiocb *iocb, struct iov_it=
er *to)
>         down_read(&cinode->lock_sem);
>         if (!cifs_find_lock_conflict(cfile, iocb->ki_pos, iov_iter_count(=
to),
>                                      tcon->ses->server->vals->shared_lock=
_type,
> -                                    0, NULL, CIFS_READ_OP))
> +                                    0, &lock, CIFS_READ_OP) || (lock->fl=
ags & FL_FLOCK))
>                 rc =3D generic_file_read_iter(iocb, to);
>         up_read(&cinode->lock_sem);
>         return rc;
> --
> 2.30.0
>
