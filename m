Return-Path: <linux-fsdevel+bounces-48542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E17F0AB0BE0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 09:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7B41BC2ECC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 07:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1463C2701AC;
	Fri,  9 May 2025 07:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Uzqgyb4v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AAC238C29;
	Fri,  9 May 2025 07:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746776400; cv=none; b=BF100ZJM3OihQI6b33fkwJpW+8ExTqftxOs/YKr+NmavhVx5mnIIkIkEWMbKO7uPqOgdpDA9u4WswhrSlNmdF56g8HooR+KSRk0U8HT8LBAa8V7BvytTRw592AQHc7y6YOPXnrKzZgdCuCDh3JlVZzkUOojRwkbSg3Fs19fUhvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746776400; c=relaxed/simple;
	bh=pMOL31BNFaEAsCEtI+6K78JXiZuLob2sKmBV2v22gi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=moPYMX1ef8BYSX9vvLud/gfu8vJTyDup8s8Q8HHYYq2kDMt+D6pRtETvXK+tUqTWvlkdGt2bg8w4WAQZnvN8ZcFeIkKi5WOCGLoNAvjEbnLgOHZUn7iFmqaDhE6cXyAYzwz42KmqwgyNWI+0trFQIcwvqzI2OhrJTPEs9cQVGR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Uzqgyb4v; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1746776382;
	bh=woe28cub85HQB1DXe4N55M//ris67Oe8smNrY8G3w2s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=Uzqgyb4v8fPvZGPie2RTalVnPxPS3kxBBN8v1SpdqX5LHiKKF/xS5TpDxlnQNqqFM
	 wCOyWaNCetPGRKcCqh2Lhn1ViqkaJazx+C+CqMYL1agVQUCSziG1CgomAbMEAm6V1R
	 9uaOoEbswNlxeSKWQlc07R3klKwLsfUuAGDvrxvA=
X-QQ-mid: zesmtpgz7t1746776380t28e22692
X-QQ-Originating-IP: coAEFlfINhoRYavyMIHhXOtDCHc8I4LQ/REGfssGD5I=
Received: from mail-yb1-f177.google.com ( [209.85.219.177])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 09 May 2025 15:39:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9085993867488165330
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e732386e4b7so1884739276.1;
        Fri, 09 May 2025 00:39:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVleVDlEg84926YsM1/pAbylJEQs0YVxMGLZHLpVHnlq0QJ5h6sCu948PHndpYIrbrEWzm4fOsVnq4PWuTr@vger.kernel.org, AJvYcCVqUTKGXtUCPgKdrwjeX/iPGpiln8PSUU97xkmOF9n/LcbKY0UdCVOuZeDt8zuIj+WpYNLUdrr9IhHT0Baj@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7k07xHIVlWy8s2lXySN3q0hi3CRcsKrfNSGP648xDl8/WU0zn
	oIaL/Hx2m1J7i0tXCT9Db1Nky3c/1fIgjaUn62uqqNac8Y7KwjZxaRXK6RRg6qn/CgjbFunVhZN
	waWtxosIjPvh9wcjSPvkd+d3Cnxw=
X-Google-Smtp-Source: AGHT+IG3b6igDGo2aBK8UQzjxo+58zAaMfPJMOUYLBHY3oPwvrpvzD6wpnXjNP3aZTn3oPP+5lIirlmBmLhBxtmQ9pI=
X-Received: by 2002:a05:6902:a91:b0:e75:bcba:aae2 with SMTP id
 3f1490d57ef6-e78fdd2f77emr3114677276.34.1746776377717; Fri, 09 May 2025
 00:39:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com> <20250509-fusectl-backing-files-v3-2-393761f9b683@uniontech.com>
In-Reply-To: <20250509-fusectl-backing-files-v3-2-393761f9b683@uniontech.com>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Fri, 9 May 2025 15:39:26 +0800
X-Gmail-Original-Message-ID: <801E914207457591+CAC1kPDM5cN9p-Ri1WUEWt6JNiTZukekJyihYRT=qTwawVT3bFA@mail.gmail.com>
X-Gm-Features: ATxdqUE9Pp0fNZXCROpyVbJpIz9JyK0rd5B_B9vJELc3h1vNHpV6CnuzEUw5jwc
Message-ID: <CAC1kPDM5cN9p-Ri1WUEWt6JNiTZukekJyihYRT=qTwawVT3bFA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fs: fuse: add backing_files control file
To: chenlinxuan@uniontech.com
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: N3KkLQaYkl97eEUkF+UfJEXnYPgJlzptMasEvX/TKI+3+OKgvbkKLOco
	gD5y0S2cJg1nT2Yul2yMbztzOdjp0CaGuyIpGfgtvgRDrRejqMDKHulwL7fYknxlnVDdo+N
	OVH8s+FnVo2Ik702xYqV02+wfu70R1M+esujunV4Vg68dYui6YLYw7MhS0gAOYJnrCpMRZo
	9spQF75/IyXhtWymQiaxS+wIU2PRg0C+AMTvTtC+n8YpYwvqBZnGzT4Zv6ImE2r2CZJXXf2
	LCbQXnxqcvEjBUkZdLBMircYxttMao6r7Lz+gJNCxejhIAyUGgySlWnGrbNy65stTSjBSW2
	qFT1IeezxhAJERSv5uG2aRxu32M9pZMkxIO9EyXgeVZH/gWAHvVU7liByIzW38hA792IV43
	Sy7r6KBc0UKbf0qYDOUJnfSKUe6ysQn7MJzcRd9OkcznFGjivQl//cnhrV8tjMZagRS9BV8
	I4uacsfCFLtkd8gwpZOGH9P/EqmmqT4VZ0poAmNwbANfuB90pp6u5Bw72ioZCFgSha0HylJ
	pWq7Lsa0nvYpzau2RKOKWOt+2uAvEi6b3Cg3Cg1AVhr4JzFtY2XXZBnfi5LWESzUB5jNwMm
	Muq8zYxhUFF1FB1nZboynjNqkMDh8qi67I+99xM/bRJhwa0lDlEz8ynS8oblgBWBE+RNK9U
	qSSN92355+nuInsl1d/mo6Mppob53n8DrAEWhnRYlVRcW8Ad1hB9oFyEpW485QV7XWkor7i
	GUg47hc/8GKwwZFKEDaeGmUziuvKdBLxKObphpjeRLZtb8E0K0P46pTY+Q6yuRPSMwsloN8
	5bGHP/y36lNi809Retfxd4m7RbZfdvvHZe8CWnM4okax2x0DeLUk+2Xm7hyjZUA2Pjr2hbf
	an/TrlBAAU5UR2JteTIJFSEezNM09msT8zH5GFFBfWBTIB8mSiO7h2iKZKyivW3POoJUq2d
	kJ0BUsg6Be/8e0ZcNuf4m9fQFi1nZq6WNNsVASERDvJ/NhSLinmyw3u4lk3fCnSuMvl4cIN
	CjfC13IH30Ne1+QG0+KAoOiDbj2vx1/BnGLdC79iYrNqkUIwFIn4qhlld8R+grwqsbcSqrH
	Wz6jY8crziNFflH4gH5xAjwEDks9JlOXL+q3VPQUIzGHwjtj7d2fo4=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Fri, May 9, 2025 at 2:34=E2=80=AFPM Chen Linxuan via B4 Relay
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
>  fs/fuse/control.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++++=
+-----
>  fs/fuse/fuse_i.h  |   2 +-
>  2 files changed, 144 insertions(+), 13 deletions(-)
>
> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> index f0874403b1f7c91571f38e4ae9f8cebe259f7dd1..6333fffec85bd562dc9e86ba7=
cbf88b8bc2d68ce 100644
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
> @@ -180,6 +181,135 @@ static ssize_t fuse_conn_congestion_threshold_write=
(struct file *file,
>         return ret;
>  }
>
> +struct fuse_backing_files_seq_state {
> +       struct fuse_conn *fc;
> +       int backing_id;
> +};

As mentioned in the previous v2 related discussion
backing_id is maintained in state because
show() of seq_file doesn't accept the pos parameter.
But actually we can get the pos in the show() function
via the index field of struct seq_file.
The softnet_seq_show() function in net-procfs.c are doing this.
I'm not really sure if it would be better to implement it this way.

> +
> +static void fuse_backing_files_seq_state_free(struct fuse_backing_files_=
seq_state *state)
> +{
> +       fuse_conn_put(state->fc);
> +       kvfree(state);
> +}
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
> +       fc =3D fuse_ctl_file_conn_get(seq->file);

I'm not sure if I should get fc in fuse_backing_files_seq_start here
and handle fc as (part of) the seq_file iterator.
Or should I get the fc in fuse_backing_files_seq_open
and store the fc in the private field of the seq_file more appropriately.
I guess the difference isn't that big?

> +       if (!fc)
> +               return ERR_PTR(-ENOTCONN);
> +
> +       backing_id =3D *pos;
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
> +       *pos =3D backing_id;
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
> +       state->backing_id++;
> +
> +       rcu_read_lock();
> +
> +       fb =3D idr_get_next(&state->fc->backing_files_map, &state->backin=
g_id);
> +
> +       rcu_read_unlock();
> +
> +       if (!fb) {
> +               fuse_backing_files_seq_state_free(state);
> +               return NULL;
> +       }
> +
> +       *pos =3D state->backing_id;
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
> +
> +       rcu_read_unlock();
> +
> +       if (!fb)
> +               return 0;
> +
> +       if (fb->file) {
> +               seq_printf(seq, "%5u: ", state->backing_id);
> +               seq_file_path(seq, fb->file, " \t\n\\");
> +               seq_puts(seq, "\n");
> +       }
> +
> +       fuse_backing_put(fb);
> +       return 0;
> +}
> +
> +static void fuse_backing_files_seq_stop(struct seq_file *seq, void *v)
> +{
> +       if (v)
> +               fuse_backing_files_seq_state_free(v);
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
> +       return seq_open(file, &fuse_backing_files_seq_ops);
> +}
> +
> +static const struct file_operations fuse_conn_backing_files_ops =3D {
> +       .open =3D fuse_backing_files_seq_open,
> +       .read =3D seq_read,
> +       .llseek =3D seq_lseek,
> +       .release =3D seq_release,
> +};
> +

