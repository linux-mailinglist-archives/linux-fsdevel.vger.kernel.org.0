Return-Path: <linux-fsdevel+bounces-67475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAF1C41A91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 21:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76085189B702
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 20:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C4030E859;
	Fri,  7 Nov 2025 20:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bk4rFnQc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B17A18C2C
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 20:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548954; cv=none; b=GlxH9r835e/eSy4LuvZJeTB4ke8rlh+e+xHNjpQzPNhtXQnwKW2bZD1u7pa8tN+4ndhWRqZmSW70ytHFVDcTovNWLAllnHY9fMKgzv2MuriHPD361eyvHSflsV9G+nvxNTT4SLNIu/CudgFPzIDqynba2kH1SIwQz59rRGaBFIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548954; c=relaxed/simple;
	bh=UMO6ycD1cgWnF8R8KGIbhxQbGcfO55AKo71pC38XAXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUAWurhXWsSw4ixXLULC6I1Aq8ePlKXxyq/giZuqnQ5CbCBFxx16Heng2yyKcii19o0ohEenxyAtJNNPNbq2DkZxouW0aQcdaI4qLeO8pVbbZZRaNe4YbR6QxxzxpCdd3lPRG8FiLnUtPG4tsOVwPRCPVBGRd70zMRTwRzIrzvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bk4rFnQc; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4e89c433c00so11823191cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 12:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762548951; x=1763153751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoMzJO4VtHoyqxy4fHt/I9xUqvoQQ5zinC0+ZtdmI60=;
        b=bk4rFnQcnUYaX0vsoN6AqZEHADO7JfjmUatAEBKa+dt0e6lKyfwDEYvzpiGy96MrfZ
         OdwW//iEBliYxFTp1Mc2vpHJPbRFYIbdGhHhPy2SwbbyWR8n91k/ZiBJ4c064ovtEHoT
         G0TpdV/4JgbQbntvNYSA/be5fjHRD6rSZ45rGqh2cC71ubK3AM15z2s+MMPB5G8OYEcn
         cBV0kWqQtr+3DiqIHpJMWTxpmFuiV0Z/g0UaHyCpyybjcGjRUr8DAbQMcyVMXKlRMi3J
         9Zw7Ws5g6V9eCrwRbu7U6iYqeRvFZ923I3mdHALh7PWvRQYNS3X6QRS+DaGA+JHVAQeZ
         qt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762548951; x=1763153751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VoMzJO4VtHoyqxy4fHt/I9xUqvoQQ5zinC0+ZtdmI60=;
        b=IgkLndqtglHOYOaingooQL4r0NtqoGRBzV5bKtqrOdar7eDCwiRHeo57SmCJrzMC4p
         lXBsiM6h6O8+NPa2g3P3RVToKlgaMFvP7CK/F6EN90eRc0DDrKIc90Uog8sh0va4oYpy
         vg970reUF4lHf6deiFzpgW4LnXq9L6aGcQRLH0gt22aDfrz/z4BUDujM2oa8FDF7/QQ0
         EGmRZosPNbpl0UD6CP5g/GEBhOdFKGzRCrDB2ekNoqTNsUENM5naDeS4qJiaawPbPQo7
         c+5wkx9QXDRviciOS6NeoVmW9LLgmn3c9DAmrHAS0BL+n6jZZ33tlT8R/4mzY13B7t4O
         t6Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVBxka0cdcH9mq5mGhXpuyDwIIOj8gwM50PvBMAz2sMY/Z4K4S+/YbQZtkJhLEuglGbswMSZc+QadZjfo9K@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+IBxibR4j3rBe5jH1KugWLNNkogbbkB8GGmIINiZb0lu5uMaO
	yhbqaPcWYo6MsxZi5D6HOD7X4NwkNRBr/QxKN28eNcoA3kjIj276BF3vZFLmTHrXqyjBrqo/bhj
	JuOeY0akCbku3URpkShnLX8akagg1sFFKAwpI
X-Gm-Gg: ASbGncus/O3dc9XJ7Mq/hVzBdWPEAH2Q0HBAx7n9PfnzDvuYKx3QVucXhh+/TEx6Se1
	lyacY4EFYI8jlMMCpdkAqYUQkVt5JhQtPPp45uIhyAG4qbnuMDtCQQWYpzISgHeo5R7vXL8iPHw
	7orPNUJHe+a/RTnt/NpbsHMedPUWsEGetWjvvegUVnWBLuYWUCUK0/Ql43sHMMTeNwe2pQLHULS
	qSykXU6eikm3K2treaNGrA2g4bBKru9DedMBNGLDYoncGYUUvCeqpOMWCv0Gc7XiM9vRP6KZY3T
	9JvhUAq9k+878DUasUy5mMks3w==
X-Google-Smtp-Source: AGHT+IEuWGaM7OOt9q4DCJYeCgDx1zplDWcT1PAZMTC+hU6m5kmuW5xOUH9HfeUqKWxd0uEAxY0XQ9IlVf2CXMX1/oE=
X-Received: by 2002:ac8:7d0a:0:b0:4ed:1ccb:e609 with SMTP id
 d75a77b69052e-4eda4e7b0b6mr6888581cf.6.1762548951523; Fri, 07 Nov 2025
 12:55:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169809796.1424693.4820699158982303428.stgit@frogsfrogsfrogs> <176169809851.1424693.14006418302806790576.stgit@frogsfrogsfrogs>
In-Reply-To: <176169809851.1424693.14006418302806790576.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 7 Nov 2025 12:55:39 -0800
X-Gm-Features: AWmQ_bnBvVrLwoICHkOzPpLrlqc2Qxavt7gBfG3R7R1QTwvvjbcK4kK6Y-kvGgc
Message-ID: <CAJnrk1YJP9z2k7zy-NyirMV-Rs8md4WF1MSNJOAfKNaB-Lv_yg@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse_trace: move the passthrough-specific code back
 to passthrough.c
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 5:44=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Add tracepoints for the previous patch.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_trace.h |   35 +++++++++++++++++++++++++++++++++++
>  fs/fuse/backing.c    |    5 +++++
>  2 files changed, 40 insertions(+)
>
>
> diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
> index bbe9ddd8c71696..286a0845dc0898 100644
> --- a/fs/fuse/fuse_trace.h
> +++ b/fs/fuse/fuse_trace.h
> @@ -124,6 +124,41 @@ TRACE_EVENT(fuse_request_end,
>                   __entry->unique, __entry->len, __entry->error)
>  );
>
> +#ifdef CONFIG_FUSE_BACKING
> +TRACE_EVENT(fuse_backing_class,
> +       TP_PROTO(const struct fuse_conn *fc, unsigned int idx,
> +                const struct fuse_backing *fb),
> +
> +       TP_ARGS(fc, idx, fb),
> +
> +       TP_STRUCT__entry(
> +               __field(dev_t,                  connection)
> +               __field(unsigned int,           idx)
> +               __field(unsigned long,          ino)
> +       ),
> +
> +       TP_fast_assign(
> +               struct inode *inode =3D file_inode(fb->file);
> +
> +               __entry->connection     =3D       fc->dev;
> +               __entry->idx            =3D       idx;
> +               __entry->ino            =3D       inode->i_ino;
> +       ),
> +
> +       TP_printk("connection %u idx %u ino 0x%lx",
> +                 __entry->connection,
> +                 __entry->idx,
> +                 __entry->ino)
> +);
> +#define DEFINE_FUSE_BACKING_EVENT(name)                \
> +DEFINE_EVENT(fuse_backing_class, name,         \
> +       TP_PROTO(const struct fuse_conn *fc, unsigned int idx, \
> +                const struct fuse_backing *fb), \
> +       TP_ARGS(fc, idx, fb))
> +DEFINE_FUSE_BACKING_EVENT(fuse_backing_open);
> +DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
> +#endif /* CONFIG_FUSE_BACKING */
> +
>  #endif /* _TRACE_FUSE_H */
>
>  #undef TRACE_INCLUDE_PATH
> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> index f5efbffd0f456b..b83a3c1b2dff7a 100644
> --- a/fs/fuse/backing.c
> +++ b/fs/fuse/backing.c
> @@ -72,6 +72,7 @@ static int fuse_backing_id_free(int id, void *p, void *=
data)
>
>         WARN_ON_ONCE(refcount_read(&fb->count) !=3D 1);
>
> +       trace_fuse_backing_close((struct fuse_conn *)data, id, fb);
>         fuse_backing_free(fb);
>         return 0;
>  }
> @@ -145,6 +146,8 @@ int fuse_backing_open(struct fuse_conn *fc, struct fu=
se_backing_map *map)
>                 fb =3D NULL;
>                 goto out;
>         }
> +
> +       trace_fuse_backing_open(fc, res, fb);
>  out:
>         pr_debug("%s: fb=3D0x%p, ret=3D%i\n", __func__, fb, res);
>
> @@ -194,6 +197,8 @@ int fuse_backing_close(struct fuse_conn *fc, int back=
ing_id)
>         if (err)
>                 goto out_fb;
>
> +       trace_fuse_backing_close(fc, backing_id, fb);
> +

If I'm understanding it correctly, the lines above (added from the
previous patch) are

+ err =3D ops->may_admin ? ops->may_admin(fc, 0) : 0;
+ if (err)
+       goto out_fb;
+
+ err =3D ops->may_close ? ops->may_close(fc, fb->file) : 0;
+ if (err)
+        goto out_fb;

and will also do the close in the out_fb goto. So should the
trace_fuse_backing_close() be moved to before the "err =3D
ops->may_admin..." line so it doesn't get missed in the "if (err)..."
cases?

Thanks,
Joanne

>         err =3D -ENOENT;
>         test_fb =3D fuse_backing_id_remove(fc, backing_id);
>         if (!test_fb)
>

