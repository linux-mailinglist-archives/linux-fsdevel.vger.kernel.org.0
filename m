Return-Path: <linux-fsdevel+bounces-48343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF36AADCD5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 13:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 257847BE26E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 11:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716E6215F49;
	Wed,  7 May 2025 11:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQopF+6R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87AF20B1F4;
	Wed,  7 May 2025 11:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746615781; cv=none; b=qf8ie8QansAO0lMjyOyesqamTRjUqqOdB91BHbrOPK7tIht6kcAawRY9ml11xh6C7xtLB2/2xzcPTzG/9DfV1QUm6oS/haWgwmX1Url8UhlJQPICF9vzWrekMkJjQxGu5ppVCKhQpgkJtpbDRWUQhduir64OYaKVlAWd1NlrB0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746615781; c=relaxed/simple;
	bh=co+3odHbt1zWjccEgbz6zjoHKiJ+hnJ1gCjdF7eOJXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bu86qorGbRp4WtGYDnTKEmQaVnSxrFPNkdZr4UA/RnDv2fCw7WaR+SiYTPlmFnqs7R9FrXIQUz5aFiGygZfwKCamsi89sorAKh+/fp2saUFwu48D/SSywtfqb7JXi60iA5gUJI3sifKCebRO0KfNEuAByUrMyRir+4yxbI3fhKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQopF+6R; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac29fd22163so1132258366b.3;
        Wed, 07 May 2025 04:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746615778; x=1747220578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wA1RCs9R0+wjorugvs8gPuBKuJdfVEv7Kl8WM15CE3I=;
        b=NQopF+6RARY+FGEcQjHlYWqn2PAL1+OAsbgKB3LLjTC6SfCw2b2Z/uoibhloYiPcIc
         gH5i6VVTWmC/9qKaDYkWnsec6bnMUTHmw+jABJlhLTOiiUOpow+3BDLtnTzmA1dXZ6e4
         rwwJMgI+4KgcwIRCFlU3GEdTFW4Xmg/f/atSnVHfJuqDJYCLA7SVy/+/3U8AW5UYB4cu
         SaO1SSDGwOs62I2U05AZGNATzEYT3Ny1Rz5hn5OhdDmcOwqRTCymbi+mdDBv6EKS/hsf
         Hp7bJDqWNPOHRy+rhG5mdZk7DTtnnR4OgizY6X5085zdc3tzSZu8/OGpiVoMQs75dxci
         sQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746615778; x=1747220578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wA1RCs9R0+wjorugvs8gPuBKuJdfVEv7Kl8WM15CE3I=;
        b=Ndz0ZcxryJhpGjExl78QbLVKvQfs63CynoKy6vAMuVXNWiDmHtLihyAB8R9o3IWWo+
         JHeGSnaiWRlTbk/veFhq1DL8oPc7dRZLGkSO2aqdoMIpQnLIHGtw7fLAPE4kx2wf8rKy
         EeX3s6pF/BDdRGyIOZXcz9Twr+VweZvaaMIlfmaC+kzNsBsdgUICfJtGRoG5aBiCYlPv
         5yRxPc38AF+ISj6t72yUyzp56i+blRjafLxctnD38Ttzyi1yZkt7xCuDscmsiJSTFWTH
         MIXc+qLNwwUqSS0qRaeb0y4beQqFm3rPpSfl1gWbkNVzeacjhlBQI3lNHuxHlB+Fo6U8
         QM/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWegopoWlO7Hv5rvr1FMVmbrasoQJ6h57JHB3BgqL7aqx/YukOhLQs1CGBOed2y0V7tQRCoqSO1ng9e7OB7@vger.kernel.org, AJvYcCWt0WU9j6AVtzphEIdCmB4W7kFcedALrcNzbIROusOE3OXU88kVfB46PukhYzc8CXdImh67ou+faq/GQRiT@vger.kernel.org
X-Gm-Message-State: AOJu0YxKM3yheZFdByXgs7J552KnpWy0b2NuxI1h09HHccXg6scKzgyf
	oXO4S17vkTkoHFnHLUXD+IhK+byt7RF8B+yP6FcqXP8mIiYRjl4/VOAj6LLXeD2dTI6we/6v4zL
	Gc7uDxpVB0JeKqPzjLwDVopORz54=
X-Gm-Gg: ASbGnctGBo+sScpaq+CJIg5+nlyWqaYgYWZntJV7VtsIhzXhHIbgOmReJs8jWbC2Ua7
	UaLR88pWui5fET3UVLykKYp2fW9PuxOg8PfIB0Ag+ytoaZtjywn7kgsGVzaL6Lqt72GQcMwFub0
	tp/VOm4jBTIU9jc9YqAkHxSg==
X-Google-Smtp-Source: AGHT+IGmJOcljDg0qVKwGACkmSUln0pLwi7bS9k+5ZtNAzBUFtBbohM4Qbz0zcYTxJcsS9avGrCQ8ecueXjEzNrT8G8=
X-Received: by 2002:a17:907:7b8d:b0:aca:d6f2:c39e with SMTP id
 a640c23a62f3a-ad1e8c14806mr257565166b.23.1746615777361; Wed, 07 May 2025
 04:02:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507032926.377076-2-chenlinxuan@uniontech.com>
In-Reply-To: <20250507032926.377076-2-chenlinxuan@uniontech.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 7 May 2025 13:02:45 +0200
X-Gm-Features: ATxdqUFCvpNsMtuCuTXY_Dfsfcttlem-5BEXzZXnYCBOxHIphLZbzSLrdptFOIg
Message-ID: <CAOQ4uxjKFXOKQxPpxtS6G_nR0tpw95w0GiO68UcWg_OBhmSY=Q@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: fuse: add backing_files control file
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 5:29=E2=80=AFAM Chen Linxuan <chenlinxuan@uniontech.=
com> wrote:
>
> Add a new FUSE control file "/sys/fs/fuse/connections/*/backing_files"
> that exposes the paths of all backing files currently being used in
> FUSE mount points. This is particularly valuable for tracking and
> debugging files used in FUSE passthrough mode.
>
> This approach is similar to how fixed files in io_uring expose their
> status through fdinfo, providing administrators with visibility into
> backing file usage. By making backing files visible through the FUSE
> control filesystem, administrators can monitor which files are being
> used for passthrough operations and can force-close them if needed by
> aborting the connection.
>
> This exposure of backing files information is an important step towards
> potentially relaxing CAP_SYS_ADMIN requirements for certain passthrough
> operations in the future, allowing for better security analysis of
> passthrough usage patterns.
>
> The control file is implemented using the seq_file interface for
> efficient handling of potentially large numbers of backing files.
> Access permissions are set to read-only (0400) as this is an
> informational interface.
>
> FUSE_CTL_NUM_DENTRIES has been increased from 5 to 6 to accommodate the
> additional control file.
>
> Some related discussions can be found at:
>
> Link: https://lore.kernel.org/all/4b64a41c-6167-4c02-8bae-3021270ca519@fa=
stmail.fm/T/#mc73e04df56b8830b1d7b06b5d9f22e594fba423e
> Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxhAY1m7ubJ3p-A3rSufw_53=
WuDRMT1Zqe_OC0bP_Fb3Zw@mail.gmail.com/
>

remove newline

> Cc: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
>
> ---
> Please review this patch carefully. I am new to kernel development and
> I am not quite sure if I have followed the best practices, especially
> in terms of seq_file, error handling and locking. I would appreciate
> any feedback.

Very nice work!

>
> I have do some simply testing using libfuse example [1]. It seems to
> work well.

It would be great if you could add basic sanity tests to libfuse
maybe in test_passthrough_hp(), but I do not see any tests for
/sys/fs/fuse/connections.

I also see that there is one kernel selftest that mounts a fuse fs
tools/testing/selftests/memfd
maybe that is an easier way to write a simple test to verify the
/sys/fs/fuse/connections functionally.

Anyway, I do not require that you do that as a condition for merging this p=
atch,
but I may require that for removing CAP_SYS_ADMIN ;)

>
> [1]: https://github.com/libfuse/libfuse/blob/master/example/passthrough_h=
p.cc
> ---
>  fs/fuse/control.c | 129 +++++++++++++++++++++++++++++++++++++++++++++-
>  fs/fuse/fuse_i.h  |   2 +-
>  2 files changed, 129 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> index 2a730d88cc3bd..4d1e0acc5030f 100644
> --- a/fs/fuse/control.c
> +++ b/fs/fuse/control.c
> @@ -11,6 +11,7 @@
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/fs_context.h>
> +#include <linux/seq_file.h>
>
>  #define FUSE_CTL_SUPER_MAGIC 0x65735543
>
> @@ -180,6 +181,129 @@ static ssize_t fuse_conn_congestion_threshold_write=
(struct file *file,
>         return ret;
>  }
>
> +struct fuse_backing_files_seq_state {
> +       struct fuse_conn *fc;
> +       int pos;

It will be more clear to call this 'backing_id'.
It is more than an abstract pos in this context.

> +};
> +
> +static void *fuse_backing_files_seq_start(struct seq_file *seq, loff_t *=
pos)
> +{
> +       struct fuse_backing_files_seq_state *state =3D seq->private;
> +       struct fuse_conn *fc =3D state->fc;
> +
> +       if (!fc)
> +               return NULL;
> +
> +       spin_lock(&fc->lock);
> +
> +       if (*pos > idr_get_cursor(&fc->backing_files_map)) {

This won't do after the ida allocator has wrapped up back to 1,
it will not iterate the high ids.

Please look at using idr_get_next() iteration, like bpf_prog_seq_ops.

With that change, I don't think that you need to take the spin lock
for iteration.
I think that you can use rcu_read_lock() for the scope of each
start(). next(), show()
because we do not need to promise a "snapshot" of the backing_file at a spe=
cific
time. If backing files are added/removed while iterating it is undefined if=
 they
are listed or not, just like readdir.

> +               spin_unlock(&fc->lock);
> +               return NULL;

Not critical, but if you end up needing a "scoped" unlock for the
entire iteration, you can use
the unlock in stop() if you return ERR_PTR(ENOENT) instead of NULL in
those error conditions.

> +       }
> +
> +       state->pos =3D *pos;
> +       return state;
> +}
> +
> +static void *fuse_backing_files_seq_next(struct seq_file *seq, void *v,
> +                                        loff_t *pos)
> +{
> +       struct fuse_backing_files_seq_state *state =3D seq->private;
> +
> +       (*pos)++;
> +       state->pos =3D *pos;
> +
> +       if (state->pos > idr_get_cursor(&state->fc->backing_files_map)) {
> +               spin_unlock(&state->fc->lock);
> +               return NULL;
> +       }
> +
> +       return state;
> +}
> +
> +static int fuse_backing_files_seq_show(struct seq_file *seq, void *v)
> +{
> +       struct fuse_backing_files_seq_state *state =3D seq->private;
> +       struct fuse_conn *fc =3D state->fc;
> +       struct fuse_backing *fb;
> +
> +       fb =3D idr_find(&fc->backing_files_map, state->pos);

You must fuse_backing_get/put(fb) around dereferencing fb->file
if not holding the fc->lock.
See fuse_passthrough_open().

> +       if (!fb || !fb->file)
> +               return 0;
> +
> +       seq_file_path(seq, fb->file, " \t\n\\");

Pls print the backing id that is associated with the open file.

I wonder out loud if we should also augment the backing fd
information in fdinfo of specific open fuse FOPEN_PASSTHROUGH files?

I am not requiring that you do that, but if you want to take a look
I think that it could be cool to display this info, along with open_flags
and other useful fuse_file information.

Thanks,
Amir.

> +       seq_puts(seq, "\n");
> +
> +       return 0;
> +}
> +
> +static void fuse_backing_files_seq_stop(struct seq_file *seq, void *v)
> +{
> +       struct fuse_backing_files_seq_state *state =3D seq->private;
> +
> +       if (v)
> +               spin_unlock(&state->fc->lock);
> +}
> +
> +static const struct seq_operations fuse_backing_files_seq_ops =3D {
> +       .start =3D fuse_backing_files_seq_start,
> +       .next =3D fuse_backing_files_seq_next,
> +       .stop =3D fuse_backing_files_seq_stop,
> +       .show =3D fuse_backing_files_seq_show,
> +};
> +
> +static int fuse_backing_files_seq_open(struct inode *inode, struct file =
*file)
> +{
> +       struct fuse_conn *fc;
> +       struct fuse_backing_files_seq_state *state;
> +       int err;
> +
> +       fc =3D fuse_ctl_file_conn_get(file);
> +       if (!fc)
> +               return -ENOTCONN;
> +
> +       err =3D seq_open(file, &fuse_backing_files_seq_ops);
> +       if (err) {
> +               fuse_conn_put(fc);
> +               return err;
> +       }
> +
> +       state =3D kmalloc(sizeof(*state), GFP_KERNEL);
> +       if (!state) {
> +               seq_release(file->f_inode, file);
> +               fuse_conn_put(fc);
> +               return -ENOMEM;
> +       }
> +
> +       state->fc =3D fc;
> +       state->pos =3D 0;
> +       ((struct seq_file *)file->private_data)->private =3D state;
> +
> +       return 0;
> +}
> +
> +static int fuse_backing_files_seq_release(struct inode *inode,
> +                                         struct file *file)
> +{
> +       struct seq_file *seq =3D file->private_data;
> +       struct fuse_backing_files_seq_state *state =3D seq->private;
> +
> +       if (state) {
> +               fuse_conn_put(state->fc);
> +               kfree(state);
> +               seq->private =3D NULL;
> +       }
> +
> +       return seq_release(inode, file);
> +}
> +
> +static const struct file_operations fuse_conn_passthrough_backing_files_=
ops =3D {
> +       .open =3D fuse_backing_files_seq_open,
> +       .read =3D seq_read,
> +       .llseek =3D seq_lseek,
> +       .release =3D fuse_backing_files_seq_release,
> +};
> +
>  static const struct file_operations fuse_ctl_abort_ops =3D {
>         .open =3D nonseekable_open,
>         .write =3D fuse_conn_abort_write,
> @@ -270,7 +394,10 @@ int fuse_ctl_add_conn(struct fuse_conn *fc)
>                                  1, NULL, &fuse_conn_max_background_ops) =
||
>             !fuse_ctl_add_dentry(parent, fc, "congestion_threshold",
>                                  S_IFREG | 0600, 1, NULL,
> -                                &fuse_conn_congestion_threshold_ops))
> +                                &fuse_conn_congestion_threshold_ops) ||
> +           !fuse_ctl_add_dentry(parent, fc, "backing_files", S_IFREG | 0=
400, 1,
> +                                NULL,
> +                                &fuse_conn_passthrough_backing_files_ops=
))
>                 goto err;
>
>         return 0;
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index d56d4fd956db9..2830b05bb0928 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -46,7 +46,7 @@
>  #define FUSE_NAME_MAX (PATH_MAX - 1)
>
>  /** Number of dentries for each connection in the control filesystem */
> -#define FUSE_CTL_NUM_DENTRIES 5
> +#define FUSE_CTL_NUM_DENTRIES 6
>
>  /* Frequency (in seconds) of request timeout checks, if opted into */
>  #define FUSE_TIMEOUT_TIMER_FREQ 15
> --
> 2.43.0
>

