Return-Path: <linux-fsdevel+bounces-40670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67125A2661D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 22:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0E1216455A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 21:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E71520F09A;
	Mon,  3 Feb 2025 21:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="On1YZa+D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AD878F54;
	Mon,  3 Feb 2025 21:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738619583; cv=none; b=pEKp41VoGkZybmSG5FqMe2kFNnL0abS5E4ZjJ9Jo0HcAciw/OdV9Crk1i8G+6lOGMbndL5Qw1u3cd3qU6d4SCMaM3iA15KHqyH1idCv53O9Cj2KiccnSM8rzrf62TDTGZRpPx9907vmHrBmASQz7dJCeZy45uphts/Ml8N90bVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738619583; c=relaxed/simple;
	bh=ts3Am3MFIlVAZc+F8SnnIKT2VjkhW2N/Uc9gnzZVBrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGaOCxqRmdPbobaTK2A7c7Kow5DsrBQZQHkvnHvQ3azw8lrHGAYpTc3PKLTSZs4LfiJ1035DM5E0jkqkec3nm8o6qs8o5R1bQSSzyHbqAWAKu/3ZGxUD9YMHQrw86RBrobm4wklTGKJzZ7A4Hn0Eb7rlgetcf5e4kk6RQHOWtvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=On1YZa+D; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-467a37a2a53so57844771cf.2;
        Mon, 03 Feb 2025 13:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738619581; x=1739224381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9DhNetOB50eff1LD6MIp+Ts6IWKJJixG6uMs77xim0=;
        b=On1YZa+DTHG0xSoIQJtrkZzio/RtxTgi67yK00T8Qw0gtcaCPM5BUGiv8ygfUb4x3S
         1fR73jtOpFSe6LJeylRV9rMH2u9tD5kH+ZI+3unpKTAubWUTm8YqWuXNXv9MMvVUOOp4
         8GPtsOExVbqfaKBsO4YuW/bi15DYstIqCMKqJOxrnMaFX9wDem5ax2Ne9cKNfMtyfqWO
         VcK5Ems7vvSUyhcTC0GEc/FnUSdzAECxgxT2AVjkBT2opKz05wLNwzmTBruGSThlFTqj
         g8oD2Ekd/DzHBlbRmhyS4lvbPtHl1+xjwOi0gUi0WUPurOuGPUTDpX8Tf73Og1uzHKLv
         GLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738619581; x=1739224381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9DhNetOB50eff1LD6MIp+Ts6IWKJJixG6uMs77xim0=;
        b=UYsVEnccimc/PMVPZ8Vs9UueSDDwhFvamdjCpbxJxhrx2YZNPxzeo9924nYMzIaI3m
         R0eG7lvBf5yxUg/6n8HvU8+xC/NP6TlaP3p/X5HdGp1f/qBTdOosshGkXegnfrusztun
         /r5eLzER6eG/WYl4XMtJl66pqJ492i5PKJ7t1l+/DcWtCH/ITqeS6TwQAGQ1Aw87/SAW
         G4KxnXC08SRT5FmXZAhCsNjRljv52bVPfHxCEjdm+udfhBHGVnGNHY0/BPsPs9/cqaSC
         H9ojtPkwrunLdMjen523MtMC8+O7+cl+0Abk8Z+0+4bPpxyPG84Ojm8oHC1kITRTuNML
         suOg==
X-Forwarded-Encrypted: i=1; AJvYcCV5xvdfJOyPLZDeb0OdtN1xxJ/5vow6nfctE7BkOzfPhtN1Ddk5vl338Ph1lOVoaaf/tECED2b60vgvNidS@vger.kernel.org, AJvYcCX1rHsxXs671FVwFMxufzdzVp7EAHjj8NPctyXoFVoa2e3dUgCd7akF7Ie6dGexzFceYLECZBk7qrVCZuL6@vger.kernel.org
X-Gm-Message-State: AOJu0YyuJov91KsY06NqTbL7GE0Ge+LGHmcQ00zkUBQ/HNMrnGo60haO
	xPOeZd5r9BbRNyQtknKVIbsHjX9VFM73unqxAZIQqqUS63HaeA3t0+byK4X8Q2k1JU5RvI8/tgR
	WIDbM7MyDlSKrcJQS5LAE9IK8cIgh2w==
X-Gm-Gg: ASbGncs/IQMdiYjYDCdebhXRanmamWcN0VSdABvfFbaml9LGG2IUSEuW7+cjDKcXFCb
	w0qL3yzRVO+zXmwBKwtOJYxABKHdLY/wDgTI5FYfgD5BZuc9jKine3r1dziJST1IdHWC2o5iCG5
	w0TArfebkjHKw4
X-Google-Smtp-Source: AGHT+IFuAHWnVV0JUm0t/TR1eXDK91WZcwzjgl+eQjbKgF1H4cUnB80gZfl2SpS6hfQ6645RQjH1B70x0ir2BNgbrXk=
X-Received: by 2002:a05:622a:510c:b0:467:68a3:4c44 with SMTP id
 d75a77b69052e-46fd0b890f4mr393625151cf.39.1738619580831; Mon, 03 Feb 2025
 13:53:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203-fuse-sysfs-v2-1-b94d199435a7@kernel.org>
In-Reply-To: <20250203-fuse-sysfs-v2-1-b94d199435a7@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 3 Feb 2025 13:52:49 -0800
X-Gm-Features: AWEUYZkd6VTC4lIKUs1CFHXJ01bfJsHrx0zcIayaXB57X50BHXDzaZ0lw356U_A
Message-ID: <CAJnrk1awwYfsX5EO6w07cM6FpYHC8WiKBQqfDw6ML7MR_nX3DQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: add a new "connections" file to show longest
 waiting reqeust
To: Jeff Layton <jlayton@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 11:57=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Add a new file to the "connections" directory that shows how long (in
> seconds) the oldest fuse_req in the processing hash or pending queue has
> been waiting.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> ---
> This is based on top of Joanne's timeout patches, as it requires the
> "create_time" field in fuse_req.  We have some internal detection of
> hung fuse server processes that relies on seeing elevated values in the
> "waiting" sysfs file. The problem with that method is that it can't
> detect when highly serialized workloads on a FUSE mount are hung. This
> adds another metric that we can use to detect this situation.
> ---
> Changes in v2:
> - use list_first_entry_or_null() when checking hash lists
> - take fiq->lock when checking pending list
> - ensure that if there are no waiting reqs, that the output will be 0
> - use time_before() to compare jiffies values
> - no need to hold fc->lock when walking pending queue
> - Link to v1: https://lore.kernel.org/r/20250203-fuse-sysfs-v1-1-36faa01f=
2338@kernel.org
> ---
>  fs/fuse/control.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/fuse/fuse_i.h  |  2 +-
>  2 files changed, 59 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> index 2a730d88cc3bdb50ea1f8a3185faad5f05fc6e74..b27f2120499826040af77d766=
2d2dad0e9f37ee6 100644
> --- a/fs/fuse/control.c
> +++ b/fs/fuse/control.c
> @@ -180,6 +180,57 @@ static ssize_t fuse_conn_congestion_threshold_write(=
struct file *file,
>         return ret;
>  }
>
> +/* Show how long (in s) the oldest request has been waiting */
> +static ssize_t fuse_conn_oldest_read(struct file *file, char __user *buf=
,
> +                                     size_t len, loff_t *ppos)
> +{
> +       char tmp[32];
> +       size_t size;
> +       unsigned long now =3D jiffies;
> +       unsigned long oldest =3D now;
> +
> +       if (!*ppos) {
> +               struct fuse_conn *fc =3D fuse_ctl_file_conn_get(file);
> +               struct fuse_iqueue *fiq =3D &fc->iq;
> +               struct fuse_dev *fud;
> +               struct fuse_req *req;
> +
> +               if (!fc)
> +                       return 0;
> +
> +               spin_lock(&fc->lock);
> +               list_for_each_entry(fud, &fc->devices, entry) {
> +                       struct fuse_pqueue *fpq =3D &fud->pq;
> +                       int i;
> +
> +                       spin_lock(&fpq->lock);
> +                       for (i =3D 0; i < FUSE_PQ_HASH_SIZE; i++) {
> +                               /*
> +                                * Only check the first request in the qu=
eue. The
> +                                * assumption is that the one at the head=
 of the list
> +                                * will always be the oldest.
> +                                */
> +                               req =3D list_first_entry_or_null(&fpq->pr=
ocessing[i],
> +                                                              struct fus=
e_req, list);
> +                               if (req && time_before(req->create_time, =
oldest))
> +                                       oldest =3D req->create_time;
> +                       }
> +                       spin_unlock(&fpq->lock);
> +               }
> +               spin_unlock(&fc->lock);
> +
> +               spin_lock(&fiq->lock);
> +               req =3D list_first_entry_or_null(&fiq->pending, struct fu=
se_req, list);
> +               if (req && time_before(req->create_time, oldest))
> +                       oldest =3D req->create_time;
> +               spin_unlock(&fiq->lock);
> +
> +               fuse_conn_put(fc);
> +       }
> +       size =3D sprintf(tmp, "%ld\n", (now - oldest)/HZ);
> +       return simple_read_from_buffer(buf, len, ppos, tmp, size);
> +}
> +
>  static const struct file_operations fuse_ctl_abort_ops =3D {
>         .open =3D nonseekable_open,
>         .write =3D fuse_conn_abort_write,
> @@ -202,6 +253,11 @@ static const struct file_operations fuse_conn_conges=
tion_threshold_ops =3D {
>         .write =3D fuse_conn_congestion_threshold_write,
>  };
>
> +static const struct file_operations fuse_ctl_oldest_ops =3D {
> +       .open =3D nonseekable_open,
> +       .read =3D fuse_conn_oldest_read,
> +};
> +
>  static struct dentry *fuse_ctl_add_dentry(struct dentry *parent,
>                                           struct fuse_conn *fc,
>                                           const char *name,
> @@ -264,6 +320,8 @@ int fuse_ctl_add_conn(struct fuse_conn *fc)
>
>         if (!fuse_ctl_add_dentry(parent, fc, "waiting", S_IFREG | 0400, 1=
,
>                                  NULL, &fuse_ctl_waiting_ops) ||
> +           !fuse_ctl_add_dentry(parent, fc, "oldest", S_IFREG | 0400, 1,
> +                                NULL, &fuse_ctl_oldest_ops) ||
>             !fuse_ctl_add_dentry(parent, fc, "abort", S_IFREG | 0200, 1,
>                                  NULL, &fuse_ctl_abort_ops) ||
>             !fuse_ctl_add_dentry(parent, fc, "max_background", S_IFREG | =
0600,
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index dcc1c327a0574b1fd1adda4b7ca047aa353b6a0a..b46c26bc977ad2d75d10fb306=
d3ecc4caf2c53bd 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -42,7 +42,7 @@
>  #define FUSE_NAME_MAX 1024
>
>  /** Number of dentries for each connection in the control filesystem */
> -#define FUSE_CTL_NUM_DENTRIES 5
> +#define FUSE_CTL_NUM_DENTRIES 6
>
>  /* Frequency (in seconds) of request timeout checks, if opted into */
>  #define FUSE_TIMEOUT_TIMER_FREQ 15
>
> ---
> base-commit: 9afd7336f3acbe5678cca3b3bc5baefb51ce9564
> change-id: 20250203-fuse-sysfs-ce351d105cf0
>
> Best regards,
> --
> Jeff Layton <jlayton@kernel.org>
>

