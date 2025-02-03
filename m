Return-Path: <linux-fsdevel+bounces-40639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAC2A26185
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 18:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD7177A243D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 17:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8D920DD4D;
	Mon,  3 Feb 2025 17:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEuxFpZu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADB320408E;
	Mon,  3 Feb 2025 17:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738603931; cv=none; b=SG95j0zhL4SBHQFFL4/ZDh0OUJiijmua8eiAOaFwiLL9c272XcN013ZcrVZwqQzZIsYtEHFHJQsB4jEMckjltpJRfgg5/exZWpIgbuItetMti16DngYyAyp9U0FqCwUVRZI47ww07I29yS6dQ+/xW/MpPlBI1U5N2VHDjfoOACg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738603931; c=relaxed/simple;
	bh=O/v2UPuwuIOxdJKnodUUqsY71D0uXQbAqc3fLmbsNZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlaNr2VXZLrlYiAH77zyiz4TSc6jwZd1jVDbkuXFg8FDCR1FO5L7JfNYnb/6Bj/Rq9/ZWLlMmmZ0sM76T9uPiiv6GkHZJTVqTu6XIpgkk6MWgkzReokh7IyZ+hX4V9PwmTUVe2aSByBQzE0fur9kfJbivW+HzF+SwhwA9AzXYVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEuxFpZu; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-46fd4bf03cbso60050301cf.0;
        Mon, 03 Feb 2025 09:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738603929; x=1739208729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luYbob8sNp1YW82MPXcDnkycCGReS87UEfBlkVRw7W4=;
        b=SEuxFpZudiFm3utAj6i9hlHUz/CcRHiTxZboNC/8w0pBU3xXw+FpL/N4UsoAKucRAm
         HGwZwEkYLidkf50tImtErM8mCoc+A2VpvRCOARnt3U3MWs+V+L5CPSklELJhuLxmSNyX
         GHwt9R4bLOeRachmceaOjFVctz4EhBwxXmhgaBKMzPwbYwPWhvdXsoQrKuRW0SUvIp7q
         IIGK2DM5kDYfigBzyqrX0W1H/U7HzUIgU04Xf2xCfFZE4wFv0uLHLmAvb0TYrYESW0YZ
         zLeAQrlb8Rfx/y78u3c3UaR8K2KM47W0TeCCrMSIZcRLiLxzBqIvwSE0oyqhhNmySC8u
         ubug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738603929; x=1739208729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=luYbob8sNp1YW82MPXcDnkycCGReS87UEfBlkVRw7W4=;
        b=nulXT4PrW26JW5yh/TcgUlkahbyKkMwdlLGfpLNjfhOEtwjh5n+SOa7HFzUYUKrUnZ
         72EaFSWovtrih7KbORKUH/XppHeAu7NWZhkwFAtNlgVif9zjg8pUZTFP9sIpZnsdbTet
         oLF/shcu6UJcJJRkz6gFb4ZnOEzQ1I6bZiKlFx5OSUerdUjQRDqMaDgUQYsyxdumr8F+
         YlqhjwOLG/Y9WEegJm8vW8/5ghKzWMlwML3/MEMwLcAe+3i4SaxUpTpSQIY1z2wO/1mY
         S7zDSNEmXxjl4IL7zBOYoyLOy4CP/cgzz0TwZr5vnbgXwdnsdk2yo3LM+K/Bp2bpMQmU
         Z3MA==
X-Forwarded-Encrypted: i=1; AJvYcCUrqnHAd0d0+JWQYwTOmsLUprt3T023YxZUCSYPC35pqrknxXJGUChi+dbKS4eA4EdRR5C/DJMFsYsIVrSg@vger.kernel.org, AJvYcCWMP9Mw9HuaLdFgoib1X2BNAOSwi+b7vRv6hvjIf5QIxoOWe9CjyokmRIuAIQfmMsUCV2i2bfXRwP7izI00@vger.kernel.org
X-Gm-Message-State: AOJu0YzYpp33XomZY41yhexaJMLOF1KAj5fyuYIORZH+OaVedLYPy9x2
	9eB+aerFjBome4lT40nHRBzhjlCVZUCBLRvZyPmHdUQQFLwqijvGv9eQ5RjV4Sqfm/J/AlryHUq
	bZ3Uzpz+BYLEX/nLrVt5qDw9HE0c=
X-Gm-Gg: ASbGnctUnWItrMS/AMIOorfkOjHUGlgq1B6630MGk33ClnmbC2KUCzAGUpbtuIMt1rh
	FWBPRtaBJ5J02gocgbZy4mwPuh0xuMyxa8pcjKEZrk1omQTylVClUcbtE91bsTP6VwXkJXT4Ik8
	ldjivrhQBuix9S
X-Google-Smtp-Source: AGHT+IHtMBWY3KrFbyfIwV8ifWOlTlHE4LyxWTRpaFmzLHbhT3Ta7hTQFVqcEIVGnfvNLgUW5pWpF4j1YGf6YxLSJ/I=
X-Received: by 2002:ac8:5a95:0:b0:466:9018:c91f with SMTP id
 d75a77b69052e-46fd0a1d0ddmr357973571cf.1.1738603928534; Mon, 03 Feb 2025
 09:32:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203-fuse-sysfs-v1-1-36faa01f2338@kernel.org>
In-Reply-To: <20250203-fuse-sysfs-v1-1-36faa01f2338@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 3 Feb 2025 09:31:56 -0800
X-Gm-Features: AWEUYZkW2ivvftY_XY9vK0az08Gf2dloABDX_Wm6BYeVjPKgxg3QocShgKYj3Js
Message-ID: <CAJnrk1Zz+QHVctL61bXwaoY4b3DFVJ+PvKw6Qq6_D=MvBQoD+w@mail.gmail.com>
Subject: Re: [PATCH] fuse: add a new "connections" file to show longest
 waiting reqeust
To: Jeff Layton <jlayton@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 8:37=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> Add a new file to the "connections" directory that shows how long (in
> seconds) the oldest fuse_req in the processing hash or pending queue has
> been waiting.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> This is based on top of Joanne's work, as it requires the "create_time"
> field in fuse_req.  We have some internal detection of hung fuse server
> processes that relies on seeing elevated values in the "waiting" sysfs
> file. The problem with that method is that it can't detect when highly
> serialized workloads on a FUSE mount are hung. This adds another metric
> that we can use to detect when fuse mounts are hung.
> ---
>  fs/fuse/control.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/fuse/fuse_i.h  |  2 +-
>  2 files changed, 57 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> index 2a730d88cc3bdb50ea1f8a3185faad5f05fc6e74..b213db11a2d7d85c4403baa61=
f9f7850fed150a8 100644
> --- a/fs/fuse/control.c
> +++ b/fs/fuse/control.c
> @@ -180,6 +180,55 @@ static ssize_t fuse_conn_congestion_threshold_write(=
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
> +       unsigned long oldest =3D jiffies;
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
> +                               if (list_empty(&fpq->processing[i]))
> +                                       continue;
> +                               /*
> +                                * Only check the first request in the qu=
eue. The
> +                                * assumption is that the one at the head=
 of the list
> +                                * will always be the oldest.
> +                                */
> +                               req =3D list_first_entry(&fpq->processing=
[i], struct fuse_req, list);

This probably doesn't matter in actuality, but maybe
list_first_entry_or_null() on fpq->processing[i] would be more optimal
here than "list_empty()" and "list_first_entry()" since that'll
minimize the number of READ_ONCE() calls we'd need to do.

> +                               if (req->create_time < oldest)
> +                                       oldest =3D req->create_time;
> +                       }
> +                       spin_unlock(&fpq->lock);
> +               }
> +               if (!list_empty(&fiq->pending)) {

I think we'll need to grab the fiq->lock here first before checking fiq->pe=
nding

> +                       req =3D list_first_entry(&fiq->pending, struct fu=
se_req, list);
> +                       if (req->create_time < oldest)
> +                               oldest =3D req->create_time;
> +               }
> +               spin_unlock(&fc->lock);
> +               fuse_conn_put(fc);
> +       }
> +       size =3D sprintf(tmp, "%ld\n", (jiffies - oldest)/HZ);

If there are no requests, I think this will still return a non-zero
value since jiffies is a bit more than what the last "oldest =3D
jiffies" was, which might be confusing. Maybe we should just return 0
in this case?


Thanks,
Joanne

> +       return simple_read_from_buffer(buf, len, ppos, tmp, size);
> +}
> +
>  static const struct file_operations fuse_ctl_abort_ops =3D {
>         .open =3D nonseekable_open,
>         .write =3D fuse_conn_abort_write,
> @@ -202,6 +251,11 @@ static const struct file_operations fuse_conn_conges=
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
> @@ -264,6 +318,8 @@ int fuse_ctl_add_conn(struct fuse_conn *fc)
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
>

