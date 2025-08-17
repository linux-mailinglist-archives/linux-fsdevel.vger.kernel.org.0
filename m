Return-Path: <linux-fsdevel+bounces-58093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEE1B29388
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 16:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86392204181
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 14:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79952E973B;
	Sun, 17 Aug 2025 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwnEX+sj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4CD70813;
	Sun, 17 Aug 2025 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755441222; cv=none; b=RhoKNo7EFIk+ZYF2arkEysSLQ1yzhZ4pDmOR9pz1ioVrdhkmOmtAH31kUhuhhuE7Fec7POthKAZgB+auBKJpsBb/94PLeeTTPiJ6AARMauD27CymRY/JOgR8YaUIy1peesWbt7zSVcPgV9HNqYcDXftVWVbC2AXtQ9tNn2WdOjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755441222; c=relaxed/simple;
	bh=lu0wIjCuNDWeZ3lABows0LK6ft/oCFDZoN9L0RJPsfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h4kGbodma6lkd4Pla3Au1KSDKTijCd9zTvDw/62ldgtlY2Q0uY/yylWapeRs/+ndhszX99hfBp8I/IGRViTUGmGNNF/vUSxXRoIFZ2iPlfblL+kYDw4C3hYOCFz5AUwDJaR4Ij4JSWlDbn9pkXR1ha/CxCvKwyQwwxoVkLK0Lg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwnEX+sj; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6188b7949f6so6474124a12.3;
        Sun, 17 Aug 2025 07:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755441217; x=1756046017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUP0HAZH+qtseAswI+Acv4WgwF5oqRJ4X+wlIIk9SII=;
        b=QwnEX+sjfyM9vQbtM+/sb3ia/jCHK96YWywVOdqVy8/ifejhmARyqHmTC/uRrxPAtN
         bnKOW8ZrNqQlRHzOZg+5g3Mw367ANMdQu4K0NqdAMGoMFI4pWWellKAc2Inqu4MshNAY
         oZpTBAsffeaOOa0ALywP1WmTLOSGc2w7jETqjtl9ghxTLWvcbL4g07I8Ywps5zpfgEoo
         NOfIxeYK0wuD8mA9qVooUFJ6X310F1Fu+kK12YXNyPggASFcjdBK5nzyhp9p99UJ7IP/
         RvXU2AyDjZWT8h7fQh4ceFl6nVa+FGyrT41GhnbCHcRABDZe2rYcu+6mSEkUKXlhmqzH
         Hcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755441217; x=1756046017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUP0HAZH+qtseAswI+Acv4WgwF5oqRJ4X+wlIIk9SII=;
        b=mSh1FMgIeKBxyWxjsDwIzJLrkJ0Cs+nNxBFVrGT/xw2CG+v3wav8nNnkAlz6lGf+Bz
         aily814Zyq1MYaierx7ywiT7cqedyWkL9sxR9FRZruGcLwcJuzzRNzLFb1xDBAsbsjrn
         /h0PYdLpEU8Rz30Yf6SZsxzu9ewKKvIEx6k3cUuBfZHJjPTiLRDeaO5KHbtwAGEOdQ6F
         TOxzDrBizx9bCIpwrnQ3YFIDPlU7VGONN+V6A163osbYe4bFiPHN1o3U7z0Ya7Byz2E2
         FFQ8ta4NhEYjsqTV1Kfx6+Rb2VFBtz6gM6vGLvM4gqJvTzmL6PL2hO7k7yk69dHIOY/0
         iWXg==
X-Forwarded-Encrypted: i=1; AJvYcCU6g/MS4X2LPbaAwAEy8ewPthy/eEGaoIAAbexdEN2kwslX6K27tAZ+f5tNk21PXV+Bw2zZfemamJkxLhyb@vger.kernel.org, AJvYcCXM7M+/GBH2Nx5Ah3WzpJUgGeDxNtGqFOOhjEudZTd/mCprcDkx5as/GMl5sHAVsybYOLKmVf8rEZP2HpB8Eg==@vger.kernel.org, AJvYcCXTqhgrRsddnUCflIFH6NJUtzvKeD5MzodGFPDC2aWzzERi9csQ1oYQNT3wWzA1/vuRgt44DfoAjzJSR5Mv@vger.kernel.org
X-Gm-Message-State: AOJu0YxzHYWrWNKFGpq6lOaV49LkqNfT+WCw3j/S2xZSe0hZcoWvWSor
	mPFXcMfGIi8rZZOBh+gPWkiJrmdC7r8LS0yjm5xvldA9enlmRoenLPU/TJH7+9K8l+716nrhFcH
	khvxqBFLsQWmH0C/9XkFvjJBf82RFzBKcBFGk40M=
X-Gm-Gg: ASbGnct6hmjwwKU9FySCKa6+8AL6NkoixbjkxoFsnQGtqQfQrTm8UdI/0KAENydzUnv
	n/Z6zN3je/0PST9FVyxhS4WBjs7L/vI3x8OriXfe08jTd2xx7S7syPEkHnaYhoVhsVqkzdoNT62
	DJKOnL1uJ351f1JIUxW/o3B18IPiXffEO/B8hPxrGZmkIyxJwsyP8R4dHOExl1oBkh8GYFyxAbA
	7fsZuA=
X-Google-Smtp-Source: AGHT+IGazJ+u361OnaqF6poa/Jm6OemdeylMgyuO+DKzqA88bpXQXBLUuX4pTzv+1pcd4AHsQe6VahvBpH+cyf6w1iQ=
X-Received: by 2002:a05:6402:84d:b0:618:139d:3128 with SMTP id
 4fb4d7f45d1cf-618b054afe5mr7309510a12.17.1755441216406; Sun, 17 Aug 2025
 07:33:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814-tonyk-overlayfs-v5-0-c5b80a909cbd@igalia.com> <20250814-tonyk-overlayfs-v5-4-c5b80a909cbd@igalia.com>
In-Reply-To: <20250814-tonyk-overlayfs-v5-4-c5b80a909cbd@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 17 Aug 2025 16:33:23 +0200
X-Gm-Features: Ac12FXz2wMMcyuaPQm2cyZ9imzRCNhxhe4KOGPfCkKGChxQ971H_BL14FWzn8kY
Message-ID: <CAOQ4uxiX+ZURzvNdJw+UJw-2OTS5DRGr4LLr9YnHjjPKOv57TA@mail.gmail.com>
Subject: Re: [PATCH v5 4/9] ovl: Create ovl_casefold() to support casefolded strncmp()
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 7:22=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> To add overlayfs support casefold layers, create a new function
> ovl_casefold(), to be able to do case-insensitive strncmp().
>
> ovl_casefold() allocates a new buffer and stores the casefolded version
> of the string on it. If the allocation or the casefold operation fails,
> fallback to use the original string.
>
> The case-insentive name is then used in the rb-tree search/insertion
> operation. If the name is found in the rb-tree, the name can be
> discarded and the buffer is freed. If the name isn't found, it's then
> stored at struct ovl_cache_entry to be used later.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
> Changes from v4:
>  - Move the consumer/free buffer logic out to the caller
>  - s/aux/c_name
>
> Changes from v3:
>  - Improve commit message text
>  - s/OVL_NAME_LEN/NAME_MAX
>  - drop #ifdef in favor of if(IS_ENABLED)
>  - use new helper sb_encoding
>  - merged patch "Store casefold name..." and "Create ovl_casefold()..."
>  - Guard all the casefolding inside of IS_ENABLED(UNICODE)
>
> Changes from v2:
> - Refactor the patch to do a single kmalloc() per rb_tree operation
> - Instead of casefolding the cache entry name everytime per strncmp(),
>   casefold it once and reuse it for every strncmp().
> ---
>  fs/overlayfs/readdir.c | 115 +++++++++++++++++++++++++++++++++++++++++--=
------
>  1 file changed, 97 insertions(+), 18 deletions(-)
>
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index b65cdfce31ce27172d28d879559f1008b9c87320..803ac6a7516d0156ae7793ee1=
ff884dbbf2e20b0 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -27,6 +27,8 @@ struct ovl_cache_entry {
>         bool is_upper;
>         bool is_whiteout;
>         bool check_xwhiteout;
> +       const char *cf_name;
> +       int cf_len;

We should also change these member names to c_name
Because they are the "compare/canonicalized" name, which
may or may not be casefolded.

>         char name[];
>  };
>
> @@ -45,6 +47,7 @@ struct ovl_readdir_data {
>         struct list_head *list;
>         struct list_head middle;
>         struct ovl_cache_entry *first_maybe_whiteout;
> +       struct unicode_map *map;
>         int count;
>         int err;
>         bool is_upper;
> @@ -66,6 +69,27 @@ static struct ovl_cache_entry *ovl_cache_entry_from_no=
de(struct rb_node *n)
>         return rb_entry(n, struct ovl_cache_entry, node);
>  }
>
> +static int ovl_casefold(struct unicode_map *map, const char *str, int le=
n, char **dst)
> +{
> +       const struct qstr qstr =3D { .name =3D str, .len =3D len };
> +       int cf_len;
> +
> +       if (!IS_ENABLED(CONFIG_UNICODE) || !map || is_dot_dotdot(str, len=
))
> +               return 0;
> +
> +       *dst =3D kmalloc(NAME_MAX, GFP_KERNEL);
> +
> +       if (dst) {
> +               cf_len =3D utf8_casefold(map, &qstr, *dst, NAME_MAX);
> +
> +               if (cf_len > 0)
> +                       return cf_len;
> +       }
> +
> +       kfree(*dst);
> +       return 0;
> +}
> +
>  static bool ovl_cache_entry_find_link(const char *name, int len,
>                                       struct rb_node ***link,
>                                       struct rb_node **parent)
> @@ -79,7 +103,7 @@ static bool ovl_cache_entry_find_link(const char *name=
, int len,
>
>                 *parent =3D *newp;
>                 tmp =3D ovl_cache_entry_from_node(*newp);
> -               cmp =3D strncmp(name, tmp->name, len);
> +               cmp =3D strncmp(name, tmp->cf_name, tmp->cf_len);
>                 if (cmp > 0)
>                         newp =3D &tmp->node.rb_right;
>                 else if (cmp < 0 || len < tmp->len)

This looks like a bug - should be len < tmp->c_len

> @@ -101,7 +125,7 @@ static struct ovl_cache_entry *ovl_cache_entry_find(s=
truct rb_root *root,
>         while (node) {
>                 struct ovl_cache_entry *p =3D ovl_cache_entry_from_node(n=
ode);
>
> -               cmp =3D strncmp(name, p->name, len);
> +               cmp =3D strncmp(name, p->cf_name, p->cf_len);
>                 if (cmp > 0)
>                         node =3D p->node.rb_right;
>                 else if (cmp < 0 || len < p->len)

Same here.

But it's not the only bug, because this patch regresses 3 fstests without
enabling any casefolding:

overlay/038 12s ...  [14:16:39] [14:16:50]- output mismatch (see
/results/overlay/results-large/overlay/038.out.bad)
    --- tests/overlay/038.out 2025-05-25 08:52:54.000000000 +0000
    +++ /results/overlay/results-large/overlay/038.out.bad 2025-08-17
14:16:50.549367654 +0000
    @@ -1,2 +1,3 @@
     QA output created by 038
    +Merged dir: Invalid d_ino reported for ..
     Silence is golden

overlay/041 11s ...  [14:16:54] [14:17:05]- output mismatch (see
/results/overlay/results-large/overlay/041.out.bad)
    --- tests/overlay/041.out 2025-05-25 08:52:54.000000000 +0000
    +++ /results/overlay/results-large/overlay/041.out.bad 2025-08-17
14:17:05.275206922 +0000
    @@ -1,2 +1,3 @@
     QA output created by 041
    +Merged dir: Invalid d_ino reported for ..
     Silence is golden

overlay/077 19s ...  [14:17:08][  107.348626] WARNING: CPU: 3 PID:
5414 at fs/overlayfs/readdir.c:677 ovl_dir_read_impure+0x178/0x1c0
[  107.354647] ---[ end trace 0000000000000000 ]---
[  107.399525] WARNING: CPU: 2 PID: 5415 at fs/overlayfs/readdir.c:677
ovl_dir_read_impure+0x178/0x1c0
[  107.406826] ---[ end trace 0000000000000000 ]---
_check_dmesg: something found in dmesg (see
/results/overlay/results-large/overlay/077.dmesg)
 [14:17:28]- output mismatch (see
/results/overlay/results-large/overlay/077.out.bad)
    --- tests/overlay/077.out 2025-05-25 08:52:54.000000000 +0000
    +++ /results/overlay/results-large/overlay/077.out.bad 2025-08-17
14:17:28.762250671 +0000
    @@ -1,2 +1,6 @@
     QA output created by 077
    +getdents: Input/output error
    +Missing created file in impure upper dir (see
/results/overlay/results-large/overlay/077.full for details)
    +getdents: Input/output error
    +Found unlinked file in impure upper dir (see
/results/overlay/results-large/overlay/077.full for details)
     Silence is golden

Thanks,
Amir.

