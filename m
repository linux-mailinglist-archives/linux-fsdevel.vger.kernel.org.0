Return-Path: <linux-fsdevel+bounces-32979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 080F99B10F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 22:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A731C1F21650
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 20:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F37188583;
	Fri, 25 Oct 2024 20:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3hXKSq3F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D89217F5A
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 20:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729889177; cv=none; b=YxKbfeLnSXmgi36BIJ4P6EQnRAYQTnTIkuiLKcW0CRIeJqr1ohtZoN1fAg0sdYLkPTPkmXRqJvw2DHndjeouQDuJB0hnGYeKzb3ymeWdCXN5ypl9eFbaN0kDOA97jkCDqG502+07rGX+8qlF88gqFqOHs5GdDTZiEU7n1qnQ51g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729889177; c=relaxed/simple;
	bh=7OjgxgcFpHb7JvddmlgxKTeqVqiDsG6PlfVaXdPijic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xh2/Q5loSIYu8MqZcFxTGgpFBceDAOO/XUu5AZNKVH/8Ms9Ipq9uA5SUlP7/ebaDSO980sBgZSLv0rhTsPHk4oFoIteXoMbl5Dp5DGhT+cw1E+fE9Jms5qut8xqUhLz8no1e1ysEskdl9G8V7Mn8mr3GPsanEP+b/1+RRM5xed0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3hXKSq3F; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c932b47552so39a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 13:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729889174; x=1730493974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgArj2sfdFB4qVbxBgOgR+jv4VFDljw4jij8q8rRVTc=;
        b=3hXKSq3F0h32Ck7E7IUfKnmRbyL8O5TV6YLvdHyo3ul+Ele1YQjd74bYszMPh3eWdx
         TOtW4VlLPN7mlDQWBdgoT5fnqtBWhqSaNt2p/QfFRzIWEENAscHxCYwBCqxLS1NP7+H7
         C2w5bgVt7qNjThLIGXzrLWA97UgOkx1PR+GWjG3ZxAk4OpRvWKedr5B9QsBck6drns/B
         WhWDlIEY86OAd5V1AU8rGO1Un0OXF7A54VTHA1c1ahrXcl6qDx321chsb6VavYPN9Itu
         2Vaooe8xjxMl//jE918qPX28T1wueM5I6Q52Ob0yXzk9A/sgVN2ys+1EEm4iwpWaBkll
         TUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729889174; x=1730493974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgArj2sfdFB4qVbxBgOgR+jv4VFDljw4jij8q8rRVTc=;
        b=tTYhgHNomFBDr2wZAyf4fQ9ycbtAJf6vIWMEe6n1AVyqH3/hO9WtOYFmzkB+/MrYMu
         acsZ5x0cCAFfVqtWuGwaWBKVrRj0AZVvtuj2sDYOjawwSV8KklR2vw32U4mtdlc1kENH
         cj222eo2jiyFjXvu0VfKKcazoZ7TvsqBgmvlTUOz9t/xXq39PQ0o3fS9mf4rk91rRzIS
         v6a9/vLfTNm2bBUXik2eXdnxm96+Rt5vwp6lzT7hlP35Oi4OXk7UzwJoUnQekbl0pwKA
         +NZTnVT08kBwvr4JqqlgQri6r00pLHvPaWG4ezj/0BVvu5wo966jSw+2Q6Y6Or4mKkdJ
         Y7Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXIoL1x4dsDV3gFac494Of/h4qx++bxcipGaO4A0bW566Ch/RvLbvdp7nSjcWklMOaCnvvT1lwcaXR/n6lG@vger.kernel.org
X-Gm-Message-State: AOJu0YzZjXB5Y0X9wPjv/lxggj6OrQ7ZVf6H3dhDUFosxmvmmMN7bC/r
	g1TrUG3yTkH/WEIGe9TtfZJjEYySVMrSVNqO5HIT31Caa+WUD9AnVjA07/9UT3EpRtyLyMUZYKQ
	bdLbkJjkxsmstVm3QCVC1xliuTBmlNIgmYMiZ
X-Google-Smtp-Source: AGHT+IGULzuuzOcRLsI6w7DPzBotsDb1OXf7TITCdCtdmDCP6Nnq1oMu2FocMJ2KwCC/1u8FSn21QOssEDmORUPM72k=
X-Received: by 2002:a05:6402:35c9:b0:5c8:a0fd:64f0 with SMTP id
 4fb4d7f45d1cf-5cbbfc222b5mr1118a12.2.1729889173133; Fri, 25 Oct 2024 13:46:13
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007-brauner-file-rcuref-v2-0-387e24dc9163@kernel.org> <20241007-brauner-file-rcuref-v2-3-387e24dc9163@kernel.org>
In-Reply-To: <20241007-brauner-file-rcuref-v2-3-387e24dc9163@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Fri, 25 Oct 2024 22:45:35 +0200
Message-ID: <CAG48ez045n46OdL5hNn0232moYz4kUNDmScB-1duKMFwKafM3g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fs: port files to file_ref
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 4:23=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
> Port files to rely on file_ref reference to improve scaling and gain
> overflow protection.
[...]
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 4b23eb7b79dd9d4ec779f4c01ba2e902988895dc..3f5dc4176b21ff82cc9440ed9=
2a0ad962fdb2046 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -178,7 +178,7 @@ static int init_file(struct file *f, int flags, const=
 struct cred *cred)
>          * fget-rcu pattern users need to be able to handle spurious
>          * refcount bumps we should reinitialize the reused file first.
>          */
> -       atomic_long_set(&f->f_count, 1);
> +       file_ref_init(&f->f_ref, 1);

It is good that you use file_ref_init() here to atomically initialize
the file_ref; however, I think it is problematic that before this,
alloc_empty_file() uses kmem_cache_zalloc(filp_cachep, GFP_KERNEL) to
allocate the file, because that sets __GFP_ZERO, which means that
slab_post_alloc_hook() will use memset() to zero the file object. That
causes trouble in two different ways:


1. After the memset() has changed the file ref to zero, I think
file_ref_get() can return true? Which means __get_file_rcu() could
believe that it acquired a reference, and we could race like this:

task A                          task B
                                __get_file_rcu()
                                  rcu_dereference_raw()
close()
  [frees file]
alloc_empty_file()
  kmem_cache_zalloc()
    [reallocates same file]
    memset(..., 0, ...)
                                  file_ref_get()
                                    [increments 0->1, returns true]
  init_file()
    file_ref_init(..., 1)
      [sets to 0]
                                  rcu_dereference_raw()
                                  fput()
                                    file_ref_put()
                                      [decrements 0->FILE_REF_NOREF, frees =
file]
  [UAF]


2. AFAIK the memset() is not guaranteed to atomically update an
"unsigned long", so you could see an entirely bogus torn counter
value.

The only reason this worked in the old code is that the refcount value
stored in freed files is 0.

So I think you need to stop using kmem_cache_zalloc() to allocate
files, and instead use a constructor function that zeroes the refcount
field, and manually memset() the rest of the "struct file" to 0 after
calling kmem_cache_alloc().

>         return 0;
>  }
>

