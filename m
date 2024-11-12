Return-Path: <linux-fsdevel+bounces-34480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8879C5D5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 17:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F16531F22321
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 16:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C9C206067;
	Tue, 12 Nov 2024 16:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehkN2Dmd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF09205AC3;
	Tue, 12 Nov 2024 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429226; cv=none; b=F+9Ban/Zkn+pkxoAzErjFSoxz+sTfx/Azgf5ONNtar5o0mXpniO3Uwk/XCG/7Xb9mpAygc5uWMyh2ttG3fwwBNeF+3htzkcGXW6FKszwzS3R75HPorWGN9omUcUAtMpnENBHVeGdcW4zr6o9SBDRnRaZUR1z5W7bF/PTsc6oml8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429226; c=relaxed/simple;
	bh=WBOgIoUyc5WH2QU+QYCxp8Q1lARJRrF0Jr6rGSt+GQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/BNvKbxJSIMdQMpojISq9iICSQ2J7RBKpg+HNXvG2UG0njYPi+Vo/UFYHqvC4qTi/RYC5C5YEn33vo7qai7vaCiahvI96nXI2fC4BwXm6yxEdFskCfF+6CeS9clQfkHW8qQIb5H+eyD+YNye5YutNC8JArCE1tVJMHoynPm6is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehkN2Dmd; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46089a6849bso40849461cf.3;
        Tue, 12 Nov 2024 08:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731429223; x=1732034023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFfT48pUBvcSrQCu50oLrUydAI9K2tE/O7BShP437/E=;
        b=ehkN2DmdnAFaI7Ipddak4NlKu1Pt9v8gMcYCcS7zosq7+lOMFdE20U2PKgDGSTTF1V
         EM7GcR2PE9OJARmm5S1mITG2sxfJ9dc8ZrGMMa5748LNOc/6uDNj7mpeA73RCREKMbqY
         d4geXZvzGXdXWRJvOT3IJ6l9Aq0mofJnPvr495CeUqg6J8Hzbh9fPN7BvbPlrqkTdYRf
         CrRzSHoJNQTlPncsfwHvRcreVaW6ji0MzSJElpMbEX+6jJbhpdUCahxONtP8k950jSAS
         UlzvFcFBhZG8wui6vpdIqu+OogEC4q/fw+MPC9N3yN7kfWJO+ADQBTNFKuns9PNcdRx8
         l8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731429223; x=1732034023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFfT48pUBvcSrQCu50oLrUydAI9K2tE/O7BShP437/E=;
        b=eixWeKAppIeB4BILf80MbH+lJY7SSZt/AAmkAM+Cwl9vQ9F9d07Y9OwHD+0iZY5xPW
         SErWbof7ATE1luK4xZpQP98VEqsTqFKDCN3EWifuxbNGg4a/M2XhmGokACHzWCQFMQ+Z
         nxF1xng6lRzeyPHixx4k7PB+TtSRLFwqwyhZXhdUOS82Twi0ezVNRhhfz5Cdy8MrMOcD
         fAiFHfnC9htrowZNBBz3mPOPSo9BHE+rxYuUnm+7N8JjlX76Mbh8zCIVXsZghIb9Dp4D
         7OHofaJTH2qeWAvD50/myhTlGe526avY6EEZ4PBBx1YdykYUB56Nl0aO/3gLB1vRvIo6
         WfOw==
X-Forwarded-Encrypted: i=1; AJvYcCUZfoaUqwZBzrc/MqCHtdYCx2Yox586bwahFpyrdz7nTk2ahi2r+TfYZO0sN903Yiv72jcOYiP3Igwuw/dZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt/oARjCRhUizNV2hLOeHBDn8g22kFn9siSNEu87spq0U9CVZB
	JErDjQu3LwHPNOC/yGhtAaC4HjM+IiS7H9sPFegonKPc2bPTAhyLAqaXr4TwWGDYQofdocx71M1
	Jqs3yQz7KxNifPL9rNVBCfTU0sjs=
X-Google-Smtp-Source: AGHT+IF9I22x1jeyTGVvNuBsIVyLPtT39KVP+euJZ35DvpQFBo4krBTeHLIUrM5e0HN768qZ4dP1xBI+mwyE4WFkIG0=
X-Received: by 2002:ac8:690b:0:b0:462:b217:4e26 with SMTP id
 d75a77b69052e-46309412398mr274271591cf.48.1731429223601; Tue, 12 Nov 2024
 08:33:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101135452.19359-1-erin.shepherd@e43.eu> <20241101135452.19359-5-erin.shepherd@e43.eu>
In-Reply-To: <20241101135452.19359-5-erin.shepherd@e43.eu>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 12 Nov 2024 17:33:32 +0100
Message-ID: <CAOQ4uxgf7=p_p+4zBMv57-HWiiKHLRt0cFuuN3Nip+aT6F4_Ug@mail.gmail.com>
Subject: Re: [PATCH 4/4] pidfs: implement fh_to_dentry
To: Erin Shepherd <erin.shepherd@e43.eu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	christian@brauner.io, paul@paul-moore.com, bluca@debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 3:05=E2=80=AFPM Erin Shepherd <erin.shepherd@e43.eu>=
 wrote:
>
> This enables userspace to use name_to_handle_at to recover a pidfd
> to a process.
>
> We stash the process' PID in the root pid namespace inside the handle,
> and use that to recover the pid (validating that pid->ino matches the
> value in the handle, i.e. that the pid has not been reused).
>
> We use the root namespace in order to ensure that file handles can be
> moved across namespaces; however, we validate that the PID exists in
> the current namespace before returning the inode.
>
> Signed-off-by: Erin Shepherd <erin.shepherd@e43.eu>

Functionally, this looks correct to me, so you may add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

But I can't say that I am a good person to judge if this new functionality
can expose new information to unpriv users or allow them to get access
to processes that they could not get access to before.

Thanks,
Amir.

> ---
>  fs/pidfs.c | 50 +++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 43 insertions(+), 7 deletions(-)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index c8e7e9011550..2d66610ef385 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -348,23 +348,59 @@ static const struct dentry_operations pidfs_dentry_=
operations =3D {
>         .d_prune        =3D stashed_dentry_prune,
>  };
>
> -static int pidfs_encode_fh(struct inode *inode, __u32 *fh, int *max_len,
> +#define PIDFD_FID_LEN 3
> +
> +struct pidfd_fid {
> +       u64 ino;
> +       s32 pid;
> +} __packed;
> +
> +static int pidfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
>                            struct inode *parent)
>  {
>         struct pid *pid =3D inode->i_private;
> -
> -       if (*max_len < 2) {
> -               *max_len =3D 2;
> +       struct pidfd_fid *fid =3D (struct pidfd_fid *)fh;
> +
> +       if (*max_len < PIDFD_FID_LEN) {
> +               *max_len =3D PIDFD_FID_LEN;
>                 return FILEID_INVALID;
>         }
>
> -       *max_len =3D 2;
> -       *(u64 *)fh =3D pid->ino;
> -       return FILEID_KERNFS;
> +       fid->ino =3D pid->ino;
> +       fid->pid =3D pid_nr(pid);
> +       *max_len =3D PIDFD_FID_LEN;
> +       return FILEID_INO64_GEN;
> +}
> +
> +static struct dentry *pidfs_fh_to_dentry(struct super_block *sb,
> +                                        struct fid *gen_fid,
> +                                        int fh_len, int fh_type)
> +{
> +       int ret;
> +       struct path path;
> +       struct pidfd_fid *fid =3D (struct pidfd_fid *)gen_fid;
> +       struct pid *pid;
> +
> +       if (fh_type !=3D FILEID_INO64_GEN || fh_len < PIDFD_FID_LEN)
> +               return NULL;
> +
> +       pid =3D find_get_pid_ns(fid->pid, &init_pid_ns);
> +       if (!pid || pid->ino !=3D fid->ino || pid_vnr(pid) =3D=3D 0) {
> +               put_pid(pid);
> +               return NULL;
> +       }
> +
> +       ret =3D path_from_stashed(&pid->stashed, pidfs_mnt, pid, &path);
> +       if (ret < 0)
> +               return ERR_PTR(ret);
> +
> +       mntput(path.mnt);
> +       return path.dentry;
>  }
>
>  static const struct export_operations pidfs_export_operations =3D {
>         .encode_fh =3D pidfs_encode_fh,
> +       .fh_to_dentry =3D pidfs_fh_to_dentry,
>  };
>
>  static int pidfs_init_inode(struct inode *inode, void *data)
> --
> 2.46.1
>
>

