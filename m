Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA4630D260
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 05:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhBCEMM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 23:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhBCEMG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 23:12:06 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED34C061573;
        Tue,  2 Feb 2021 20:11:25 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id u4so25216814ljh.6;
        Tue, 02 Feb 2021 20:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0bJbfKqkdKC41V9+M+ffkQ8uypn+q8BNjtK5tQpu9GY=;
        b=urbPdIWghoZ9BTE0VLI+9ed3/ecJQELmaST1oFf2L+c0mVNlYtOy/jo2buC9pwj2+2
         vULxCxSGLiBgDirGZi4fc5gge0L/i5HtCjoEO99c4JhSIKg65g3fF+PwbI0U3dkJ1AZ2
         eRgH8sz1ou9tJYyDArS3ZbarMjc3lHYlMIK8fMjB4oChf35bvtMy0hZR9voc2t/+HqTM
         09kfqXl5d/qE5nsWww2MyyVPiZyZMyxdupPZ/GT7vy0qIPpSeks7cDIF9AsPhwpGbZn3
         k0aj6rcXZHbaNxYHEDon4n+1McKM2aFuQ5P1ADxhc63z+zywWa9qEZJxDZRLv6Az2ZpI
         oWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0bJbfKqkdKC41V9+M+ffkQ8uypn+q8BNjtK5tQpu9GY=;
        b=CSAXv3zLDyhSrDDSkbujz83GLQXNXDx1ffVyg9XOlCXt2STOQxs4m4zNq1qZ7VJ3I9
         3Pj/Us3P1CdWorxY3cNc9hrwQuT45tPH/56iEFsZbDjxY/YxYxyiV7elFAnAN7X9ykCC
         UFO5zKP0G++oHjyf8kmw0sci/wwrEH5VN+ujJIw28D/0p83PkzVhMKAm819dLYpl9igW
         GlFdi1DKAvklRlSVl5DafX9U5cLcbK0Vj8ifdDkFQ6lhycS1crn7N4tLhmRLaUndaK2a
         w/YItqnNgIjeuTCT0TS1hkB9FPlitqe0KyDPC1MoJGcwUkeUehClnN693Xv0oi1R73UY
         MsCg==
X-Gm-Message-State: AOAM530A3WYg5seGq82tv9k6WmYrMfECCVI6Km4LLD+4Tjnb4TiRf7a/
        B309COxYYWYTc95S9B0GMSiHzyYPsnHjKuK1P2A=
X-Google-Smtp-Source: ABdhPJxaKx0yQPKF6W3Xc64QcKx6KwewO0NxZrnXws3VT0IyYzygWbJkmOyznGl27QpfpiaILD8y320Vm6CKOQRT0Fo=
X-Received: by 2002:a2e:1503:: with SMTP id s3mr610872ljd.218.1612325483712;
 Tue, 02 Feb 2021 20:11:23 -0800 (PST)
MIME-Version: 1.0
References: <CANT5p=pK3hQNTvsR-WUmtrQFuKngx+A1iYfd0JXyb0WHqpfKMA@mail.gmail.com>
 <20210202174255.4269-1-aaptel@suse.com>
In-Reply-To: <20210202174255.4269-1-aaptel@suse.com>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 2 Feb 2021 22:11:12 -0600
Message-ID: <CAH2r5mu0Yxt-mxb5mA5n2d0jGCpSkwE4yqc7MpBVHNf-JBEp8w@mail.gmail.com>
Subject: Re: [PATCH v3] cifs: report error instead of invalid when
 revalidating a dentry fails
To:     =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Shyam Prasad N <nspmangalore@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

tentatively merged into cifs-2.6.git for-next pending a little more
testing, and cc:stable

as a separate patch - would like to know if worth trying the test case
references in commit ecf3d1f1aa7  and adding the d_weak_revalidate
routine that three filesystems added in that patch of Jeff.


On Tue, Feb 2, 2021 at 11:43 AM Aur=C3=A9lien Aptel <aaptel@suse.com> wrote=
:
>
> From: Aurelien Aptel <aaptel@suse.com>
>
> Assuming
> - //HOST/a is mounted on /mnt
> - //HOST/b is mounted on /mnt/b
>
> On a slow connection, running 'df' and killing it while it's
> processing /mnt/b can make cifs_get_inode_info() returns -ERESTARTSYS.
>
> This triggers the following chain of events:
> =3D> the dentry revalidation fail
> =3D> dentry is put and released
> =3D> superblock associated with the dentry is put
> =3D> /mnt/b is unmounted
>
> This patch makes cifs_d_revalidate() return the error instead of
> 0 (invalid) when cifs_revalidate_dentry() fails, except for ENOENT
> where that error means the dentry is invalid.
>
> Signed-off-by: Aurelien Aptel <aaptel@suse.com>
> Suggested-by: Shyam Prasad N <nspmangalore@gmail.com>
> ---
>  fs/cifs/dir.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
> index 68900f1629bff..868c0b7263ec0 100644
> --- a/fs/cifs/dir.c
> +++ b/fs/cifs/dir.c
> @@ -737,6 +737,7 @@ static int
>  cifs_d_revalidate(struct dentry *direntry, unsigned int flags)
>  {
>         struct inode *inode;
> +       int rc;
>
>         if (flags & LOOKUP_RCU)
>                 return -ECHILD;
> @@ -746,8 +747,11 @@ cifs_d_revalidate(struct dentry *direntry, unsigned =
int flags)
>                 if ((flags & LOOKUP_REVAL) && !CIFS_CACHE_READ(CIFS_I(ino=
de)))
>                         CIFS_I(inode)->time =3D 0; /* force reval */
>
> -               if (cifs_revalidate_dentry(direntry))
> -                       return 0;
> +               rc =3D cifs_revalidate_dentry(direntry);
> +               if (rc) {
> +                       cifs_dbg(FYI, "cifs_revalidate_dentry failed with=
 rc=3D%d", rc);
> +                       return rc =3D=3D -ENOENT ? 0 : rc;
> +               }
>                 else {
>                         /*
>                          * If the inode wasn't known to be a dfs entry wh=
en
> --
> 2.29.2
>


--
Thanks,

Steve
