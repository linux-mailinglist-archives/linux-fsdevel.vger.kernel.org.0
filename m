Return-Path: <linux-fsdevel+bounces-57953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C84B26F6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 20:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC46C581BCD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 18:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8287423771E;
	Thu, 14 Aug 2025 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="al7M0XHS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3813C220680;
	Thu, 14 Aug 2025 18:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755197977; cv=none; b=nBdTCaVVKKsMKldXOA2D0UpvtHpT24tzhCfEQtsf9oz15/7S9Ra8lJjiZl+T72iLKiQOhdI79LZiF+o4HQGsuIt8V0rVUr5u7xhbWoFSem4mgd9xB5V+duIFHYSdXoI7rZ0bva5yn37ra4zPLBykiZcNpJz9gjd/JzXaFWFY7vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755197977; c=relaxed/simple;
	bh=pkIfohfxm8IYlLklkblO8xDPmkUkzE0V8xiDzFHvoC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=twl3ZDncRXbHPYJ/cncMEiyqizkYYYs+q0zExW6jTEnjZ4nU/E458zQ1yzVIewGBsIPYJNboHoLccuIPEpMlhHLe0fvCtvpA3mhnNvvyHTfIHtj2y47of+Zg8mOBmXD8l1cXUcVVs/k9+pRFYpJyLQkHmOfhmu1GlNCsL47xN/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=al7M0XHS; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6188b733bbaso2447030a12.3;
        Thu, 14 Aug 2025 11:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755197973; x=1755802773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdtiAIf8pj8ZZB0LoBheU6EI12xSSY44wDdcm1lvZdU=;
        b=al7M0XHSizSnHas+HZ2Z3w+f9NNEMCaQ0qPQw0OOfxUU+/M6qPwtsBmyCuA8j9prdm
         iTLuXuZRm0R3wTFztarif/XD2rMOKYO28DCNvBHvmIDKYHN+7P1N8L1ABFaM17Rfq9ht
         aiavYP1BPKXAAL7UKQz9c7HV3L/mmPCBjUtwcOpkhdEPBI3WS1YAhmM3uEqOJzXm3DT/
         uYlhQ51EA3f9c3JG8eELzoQeDShLZGY/mHQmhb9tZKWCJbfnav0Mg3Tx7tjRs6FhpuDs
         ZleMw4tYg0AEEHxjF3OLHZg5brOj4iX5hB1qLTUNcPp7YXRUrp5Dgso+KVku69PeoLkZ
         4Bjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755197973; x=1755802773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdtiAIf8pj8ZZB0LoBheU6EI12xSSY44wDdcm1lvZdU=;
        b=gFMowu7oGR+4cw5qSfAkFE+LQ6Jm5YPEXUv53ib4TdQh41zms4UyMV1dKc7nbmDvDU
         2DntShg9FaVStXjMZGeA8tTfa1PDi0EXhMZ3OtGttUg/7tNc+r3LcioEND/BaXcyHWxv
         axv/B6yxVEe07VtfTEtvIhgewGTT5CGs86JW7MpC2+ngfPbruygpPQBdjcw0icDMkboq
         m8IpDtquJVtScGLVFNVn042qL0or2CxyQsxaFv8gsqXrzafffD3pgOq9OHT/8J6wyUx+
         Jsf6bF+9nMKThqReg6N60GXVmMHmadIfDoDzuINfvWJZsy3EBKl8eh/Rq/S31hxWe+I4
         M3TA==
X-Forwarded-Encrypted: i=1; AJvYcCUgDtKU0nkudQzLZAtQFEP1XYamkm/tyI65FvNQJxWv5pNXcQQjAizy6Mcb9WNscppIWzBSqXbsUU1y3uJT@vger.kernel.org, AJvYcCUwGH/aBvL0523ba8VLaR67oRClkGiYhfkF23vA75akPUStLmY9qJOZRMIHV9RJ82c8vayk+gNZQD60mT5A@vger.kernel.org, AJvYcCVAGiudtT6vzR+ZWIKWXuBjJmBiLk+0ehCVFUu2EZ7S9D0Xm1h5FbF7qS9TL7G0aGSnUOK3sirYyfw1Np63kg==@vger.kernel.org
X-Gm-Message-State: AOJu0YybCR1bnhr8f/4DksF9qmJ6v6ZDKpcitVutgTQA5sLK+42UeLbU
	pg9WZpPAWBl6cQKbkhmtUSfMMSn8Jobuq6DWYKhJwFNm6jlA4Lq+3jpBnJqaQfWFnXW8sjv3vuG
	Nrdl6APdrxxYnRDuwFQStuU6cKxlRne4=
X-Gm-Gg: ASbGncuGa71NcTZ4dSDxMLCUurir38WQ6MxzM52nsBHgKjltGuPVbiuShgHRTcMZ99d
	p4OUPJnxyvh4PmVW/CAwfrwhCxQTPi4VGeJyZshZXCkIJwozvZPebOKB9Ihhcf1isBVwm1VVJrO
	6S8APwQ+JdVcfYlAYMaCtxXcH2Yq5Eu/9wut//rIM7dnARTuX3k8Mo7ULi/yvtCw5haFtyuOENE
	ixg308=
X-Google-Smtp-Source: AGHT+IES/kdPcUbiRPAAbRz4Tp4WOFZqsbkPu8uIMfLyN/k4ZJO/cKJ4TooLegpUoe67jpwWijiAAfjMGXSOSEO0/+A=
X-Received: by 2002:a05:6402:2694:b0:608:50ab:7e38 with SMTP id
 4fb4d7f45d1cf-6188b9a6127mr3432232a12.14.1755197973139; Thu, 14 Aug 2025
 11:59:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814-tonyk-overlayfs-v5-0-c5b80a909cbd@igalia.com> <20250814-tonyk-overlayfs-v5-4-c5b80a909cbd@igalia.com>
In-Reply-To: <20250814-tonyk-overlayfs-v5-4-c5b80a909cbd@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Aug 2025 20:59:21 +0200
X-Gm-Features: Ac12FXzEqpTy868WrZnYsgTzSINCWkuz4TbJK-lk8zLujrwkXc4ukyfSSKWFEKA
Message-ID: <CAOQ4uxg_cu7aLZA1_PTuncofSme0fid4RTYhUpMS9LL06mc3_Q@mail.gmail.com>
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
> @@ -145,13 +169,16 @@ static bool ovl_calc_d_ino(struct ovl_readdir_data =
*rdd,
>
>  static struct ovl_cache_entry *ovl_cache_entry_new(struct ovl_readdir_da=
ta *rdd,
>                                                    const char *name, int =
len,
> +                                                  const char *cf_name, i=
nt cf_len,
>                                                    u64 ino, unsigned int =
d_type)
>  {
>         struct ovl_cache_entry *p;
>
>         p =3D kmalloc(struct_size(p, name, len + 1), GFP_KERNEL);
> -       if (!p)
> +       if (!p) {
> +               kfree(cf_name);

Not needed.
Caller will get -ENOMEM and will free c_name

No need to repost just for this I can fix on commit.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

