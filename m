Return-Path: <linux-fsdevel+bounces-48468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A69DAAF844
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 12:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603943A958B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 10:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5C42153E2;
	Thu,  8 May 2025 10:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJfRJiTw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F9B2144CF;
	Thu,  8 May 2025 10:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746701100; cv=none; b=RyaqbS4HRJPJclzEJ0Os1J41q2NWucMwAUx/cvkHlC/AUOrpBRANP3y5qHDcqdocyLq/+0WF8S1xhe/Q7cKfQpekjKlLX7X7nE1foUNjsAxylhLHcEzHR0wCJ8SKXIuM/TFW9Qfjc29G9pMclVobK9Cz0m66XGGLZy4Ud5GPqCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746701100; c=relaxed/simple;
	bh=3O4f7o+cdwSh7GkfSkWFzT4gqArOsohg7ON5dIaRPrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjbveU9ZlQwoDUmafTSh67RLh6mrhI4rvTorCZm4utMAPdoubiPw3PO04AEevV46C0OTMoKKY5QwQlTE6ExVxnreRRsjOabxNkpH0B+wxm6c7OancTJcob1taaqq9N/E/eQoUzMQRUKLGCDJVvIgzYe37trW0twRQj7oCsqnKso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJfRJiTw; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso145070466b.0;
        Thu, 08 May 2025 03:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746701097; x=1747305897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtJCJ1H+oBO5+I1jatloihWgA0mc4DVX8o/Pn2JcwS0=;
        b=ZJfRJiTwT0sGE3Ev//Gz31WIaoucE2RLgd9GLzOgiSnI7gbqpbOC32dUF6sb8epu2c
         BvF2Kds7U9MYO4WbtW29oGDh5AM8c8eyPQITc2q52/FffoR/86sYCKcu/vp2zlKLZLB0
         /2LuoRoP9PCn8fwovKZESF+mYdvHT1qwAJezC04UrCql4ksy8DZvXu+LtCmbpIypbTVp
         c8E9bcyWvuLJN0LamNp8YMY5/KLVWIKz9fG84QeZSKyAwvtyvm09/lfGme3iZPPFuQQc
         Pij2r3SoWL/Wf0NbXPZyhT5DGN7TNBD9eGu2DljtolQIG/xfyEO7+BlnUmsk77QSZUiG
         fyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746701097; x=1747305897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtJCJ1H+oBO5+I1jatloihWgA0mc4DVX8o/Pn2JcwS0=;
        b=JGt70vMn1GWM4Mp5xYE23OxVPh9avkDwgCQhqSTuI0DMrdRG235COdKh493Ocueabw
         oH2UIeTB31qSudINJqAWj9LFmOhyf07Y77Z1FtBJ2r1fQRkuVq6Dgd3l/XXthYOk/eFu
         tLRrLoqwlSs6whMbAiZEURtoRf/F2jIBOXpv7n7rKRLxDxkZDUUYazjabnXIPuLq3oQ5
         1qZAv20XQygynqpSoD7Wo2J4Mgw8fkaS47BeJEntCBgA4NwwYhWI7e0hzlBFBR26aHIW
         fIF9SGFbH6x7Rcjp/7lRMi72qwRo9KsurnjG5QHzq/IKjN7t0rtW9yQ5QSMuOusuody0
         VTrw==
X-Forwarded-Encrypted: i=1; AJvYcCV8Nld9PlOqc1Vq8+XUp72HoOclR+Lsmm1aNmYyFn8xQ+xkHhOJ78anVX9x3resor8SCbg6FcsTTDIqM19A@vger.kernel.org, AJvYcCXoccRxARO45bJ1aMQuuUd3IDEMLWpZQCTvnwmPzYT7L8/QvxytJzIssYAZ/7C3OjiygOTEtr3NA62qHEiz@vger.kernel.org
X-Gm-Message-State: AOJu0YxUJgsQGqjmbH4abZOOeU/cmdSTr2USr1yu2Rq2cSgl7nnpkXr/
	sVxP1jn+hHYmXs4Gk45RHJb+sBWMQCXsS4rL/09ctfI86isIOaKRMhmV6OfeSrxJbnZ7swLy1wq
	g9q22dAzRh+YkIK9wRgF8gKYbS+/vZ8rLJheLxg==
X-Gm-Gg: ASbGncsXAt2I/BMQIeAUmF0bROIMO7Lkc6oOlF1WH+45v+mw9XyGzOiYG9G1jzs2+AE
	eLiOFXP3AsO/6Bppxs/sHESsAse/sRs9k+bjwcdCR6Q+F93osjfmmOLBomP/Gm3aCvWgJj453Lj
	veGIgwZpdz6aTgIqsfAkwOQw==
X-Google-Smtp-Source: AGHT+IFeNjt+C+vzqzbxWit/mPEbNH5SMZ1tw08O7SI176FbLYKl1AD1zs1+FtbZWG/2rUAttNLNmfn2VoW8qT6KQNg=
X-Received: by 2002:a17:907:d2a:b0:ace:cbe0:2d67 with SMTP id
 a640c23a62f3a-ad1e8d0d4dfmr716108366b.55.1746701096129; Thu, 08 May 2025
 03:44:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508-fusectl-backing-files-v2-0-62f564e76984@uniontech.com> <20250508-fusectl-backing-files-v2-2-62f564e76984@uniontech.com>
In-Reply-To: <20250508-fusectl-backing-files-v2-2-62f564e76984@uniontech.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 8 May 2025 12:44:43 +0200
X-Gm-Features: ATxdqUFKt8_DRAgB1MJq2rrA-z669438lMdCHIvzykfiV2rftctx4Yvyisi2_v8
Message-ID: <CAOQ4uxjLkpUz2BPwVUtk6zHQtYmVww9qkUtGi5YA=Y-9XeiU9w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] fs: fuse: add backing_files control file
To: chenlinxuan@uniontech.com
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 10:54=E2=80=AFAM Chen Linxuan via B4 Relay
<devnull+chenlinxuan.uniontech.com@kernel.org> wrote:
>
> From: Chen Linxuan <chenlinxuan@uniontech.com>
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
> Some related discussions can be found at links below.
>
> Link: https://lore.kernel.org/all/4b64a41c-6167-4c02-8bae-3021270ca519@fa=
stmail.fm/T/#mc73e04df56b8830b1d7b06b5d9f22e594fba423e
> Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxhAY1m7ubJ3p-A3rSufw_53=
WuDRMT1Zqe_OC0bP_Fb3Zw@mail.gmail.com/
> Cc: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> ---
>  fs/fuse/control.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  fs/fuse/fuse_i.h  |   2 +-
>  2 files changed, 136 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> index f0874403b1f7c91571f38e4ae9f8cebe259f7dd1..d1ac934d7b8949577545ffd20=
535c68a9c4ef90f 100644
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
> @@ -180,6 +181,136 @@ static ssize_t fuse_conn_congestion_threshold_write=
(struct file *file,
>         return ret;
>  }
>
> +struct fuse_backing_files_seq_state {
> +       struct fuse_conn *fc;
> +       int backing_id;
> +};
> +
> +static void *fuse_backing_files_seq_start(struct seq_file *seq, loff_t *=
pos)
> +{
> +       struct fuse_backing *fb;
> +       struct fuse_backing_files_seq_state *state;
> +       struct fuse_conn *fc;
> +       int backing_id;
> +       void *ret;
> +
> +       if (*pos + 1 > INT_MAX)
> +               return ERR_PTR(-EINVAL);
> +
> +       backing_id =3D *pos + 1;

I am not sure if this +1 is correct.
Please make sure that you test reading in several chunks
not only from pos 0 to make sure this is right.
Assuming that is how the code gets to call start() with non zero pos?

I think that backing_id should always be in sync with *pos for that to
work correctly.
"The next() function should set ``*pos`` to a value that start() can use
to find the new location in the sequence."

That means that we do not really need the backing_id in the state.
We can just have a local backing_id var that reads from *pos and
*pos is set to it at the end of start/next.

> +
> +       fc =3D fuse_ctl_file_conn_get(seq->file);
> +       if (!fc)
> +               return ERR_PTR(-ENOTCONN);
> +
> +       rcu_read_lock();
> +
> +       fb =3D idr_get_next(&fc->backing_files_map, &backing_id);
> +
> +       rcu_read_unlock();
> +
> +       if (!fb) {
> +               ret =3D NULL;
> +               goto err;
> +       }
> +
> +       state =3D kmalloc(sizeof(*state), GFP_KERNEL);
> +       if (!state) {
> +               ret =3D ERR_PTR(-ENOMEM);
> +               goto err;
> +       }
> +
> +       state->fc =3D fc;
> +       state->backing_id =3D backing_id;
> +
> +       ret =3D state;
> +       return ret;
> +
> +err:
> +       fuse_conn_put(fc);
> +       return ret;
> +}
> +
> +static void *fuse_backing_files_seq_next(struct seq_file *seq, void *v,
> +                                        loff_t *pos)
> +{
> +       struct fuse_backing_files_seq_state *state =3D v;
> +       struct fuse_backing *fb;
> +
> +       (*pos)++;
> +       state->backing_id++;

Need to check for INT_MAX overflow?

> +
> +       rcu_read_lock();
> +
> +       fb =3D idr_get_next(&state->fc->backing_files_map, &state->backin=
g_id);
> +
> +       rcu_read_unlock();
> +
> +       if (!fb)
> +               return NULL;

I think that I gave you the wrong advice on v1 review.
IIUC, if you return NULL from next(), stop() will get a NULL v arg,
so I think you need to put fc and free state here as well.
Please verify that.

Perhaps a small helper fuse_backing_files_seq_state_free()
can help the code look cleaner, because you may also need it
in the int overflow case above?

> +
> +
> +       return state;
> +}
> +
> +static int fuse_backing_files_seq_show(struct seq_file *seq, void *v)
> +{
> +       struct fuse_backing_files_seq_state *state =3D v;
> +       struct fuse_conn *fc =3D state->fc;
> +       struct fuse_backing *fb;
> +
> +       rcu_read_lock();
> +
> +       fb =3D idr_find(&fc->backing_files_map, state->backing_id);
> +       fb =3D fuse_backing_get(fb);

rcu_read_unlock();

should be here.
After you get a ref on fb, it is safe to deref fb without RCU
so no need for the goto cleanup labels.

> +       if (!fb)
> +               goto out;
> +
> +       if (!fb->file)
> +               goto out_put_fb;
> +

This would be nicer as
      if (!fb->file) {

to avoid the goto.

> +       seq_printf(seq, "%5u: ", state->backing_id);
> +       seq_file_path(seq, fb->file, " \t\n\\");
> +       seq_puts(seq, "\n");
> +
> +out_put_fb:
> +       fuse_backing_put(fb);
> +out:
> +       rcu_read_unlock();
> +       return 0;
> +}
> +
> +static void fuse_backing_files_seq_stop(struct seq_file *seq, void *v)
> +{
> +       struct fuse_backing_files_seq_state *state;
> +
> +       if (!v)
> +               return;
> +
> +       state =3D v;
> +       fuse_conn_put(state->fc);
> +       kvfree(state);

That could become a helper
static void fuse_backing_files_seq_state_free(struct
fuse_backing_files_seq_state *state)

and seq_stop() could become:

if (v)
       fuse_backing_files_seq_state_free(v);


Thanks,
Amir.

