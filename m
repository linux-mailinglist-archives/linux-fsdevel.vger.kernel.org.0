Return-Path: <linux-fsdevel+bounces-17217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF3C8A9132
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 04:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0C44B21B4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 02:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A11F42053;
	Thu, 18 Apr 2024 02:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ASkoWHJF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5FB4F889
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Apr 2024 02:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713407496; cv=none; b=n72utYda6wXENapTKRJzqw6oUnIaWdLrOvg0jGyq7rviYjgBcB2GXt68UXz+u5uBK9Nprt33MhngEXpr1uNBqh63SISFGP3qflu5D4Im57L0QRpzLgh2UBGBPMC1PrhHAAN4FHTtVcn7LkAyOSWbvcYbDJJ5NaYqg/Ogo+FSYNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713407496; c=relaxed/simple;
	bh=ZzXqgNnkmorXkOsSEkRIKDuwf8NN6G+/uM7U/AMTiYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0ZjF7rvR2KSC3KmtyQluVFhJ12UlYH4In+r5NAOWJ0zbux14yn/kZmpCFVwsDuCFpEBmipFW1SrtWSqF+8PCD6nVDKSbuiamGbqHkXNkcfN9LFQuw8JBdDN+jNSmWfj5fyV7RaPB/VGicrKHGjBAaJnW/vv3bLO3LTyYcqK1os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ASkoWHJF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713407493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Awz2kTTfMqqBzH4TtUWNSORUe/UT2+kahfVjhpGyyTk=;
	b=ASkoWHJFoET7XZQVP85SBRTs1Zkk8k6vi+ksBlGaelui9dJeVYiSlvxBwt4Lb6xJ9tfj5E
	65BLknUMn1Knae1WFdmxMgI62wyrVFNDSd/QqV+yN1YYobi3FAQJPdmoatAG4E/gLXavt+
	k23svV1Yl//zecguASUOAZC+Ex+4SVY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-044rMaSuM3miUlb4rjnU8Q-1; Wed, 17 Apr 2024 22:31:31 -0400
X-MC-Unique: 044rMaSuM3miUlb4rjnU8Q-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2a5e1e7bab9so530710a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 19:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713407491; x=1714012291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Awz2kTTfMqqBzH4TtUWNSORUe/UT2+kahfVjhpGyyTk=;
        b=u2wr8zr8qeDGTGZgPk9H31gCF+BOqPk1BxNl09jwgGhVfjVX1CHONPjcVlw3Yfpq9I
         34iEH6D+DJRb1TkY5eqbRAfuq8mRgdZqOf/b2x9YvGIPYxGHOCrI8xEcNngoYkDyBtHr
         Seh9/VqgiW78LGnXzAS3R/tokad0cyZCZQDORJeXJwXvwN6mMl6+dBZ9BIymaRck+OIu
         jMrz4u/fBWbXC7eaKvxftQOz2YNDigx+BvVgJTCGpTqdRjh/3a2aLgTDlq3JZROC41tp
         SGYNukGD+Mw23Eyzuis8w9lJvEamZa0V3dHPdwCXIVI5LhYmuw5Jg6rUf8m96HmhLPDl
         NLFg==
X-Forwarded-Encrypted: i=1; AJvYcCXTgTkOSpct4f5Hhm+9vwk4JZGrSAzQwRLxV64vLTgyhecMcmuw3t+Mwu303q915hlQfSgaYqfEk1/s76guAeZuJFFYXTnQMd1bCQwyMA==
X-Gm-Message-State: AOJu0YwRGUet4IekkpFeeWjd69h8BY0bZRDQuri4ql43dGwQk8NHVchJ
	3sp3H/to90hUURjq3aQeMYRmMmsxGuWP0fRaegcXq5i0ev+hBnlEkhzcWjarsHbmHsSatU0CaYm
	yUNh0tdx5pCb6L/Ay32tdmBiv3rDcUOljgs3qGhWG0Qo5v6TCAcMBSux9txPEPR7wwgMsyynuz3
	CYLazbMBaOp9O3pK+LycCf8Gq6jmcxEIcznWo+eQ==
X-Received: by 2002:a17:90b:1bc6:b0:2a2:9464:f58 with SMTP id oa6-20020a17090b1bc600b002a294640f58mr1129959pjb.49.1713407490902;
        Wed, 17 Apr 2024 19:31:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnorOhtzN9DzmOb6hJ7LymsRXbDxRYLINkfCBWSe3RVMRVZM6kGOy3ngSC0BlmDvLVemNDuumh+7Wl3xj/YOs=
X-Received: by 2002:a17:90b:1bc6:b0:2a2:9464:f58 with SMTP id
 oa6-20020a17090b1bc600b002a294640f58mr1129947pjb.49.1713407490560; Wed, 17
 Apr 2024 19:31:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416005633.877153-1-ming.lei@redhat.com> <20240416152842.13933-1-snitzer@kernel.org>
In-Reply-To: <20240416152842.13933-1-snitzer@kernel.org>
From: Changhui Zhong <czhong@redhat.com>
Date: Thu, 18 Apr 2024 10:31:19 +0800
Message-ID: <CAGVVp+XDaZFEfhVz0XEN4oYQyN6W9_eX9H_E_1nshnsaweED2g@mail.gmail.com>
Subject: Re: [PATCH v2] dm: restore synchronous close of device mapper block device
To: Mike Snitzer <snitzer@kernel.org>
Cc: ming.lei@redhat.com, brauner@kernel.org, dm-devel@lists.linux.dev, 
	jack@suse.cz, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 11:29=E2=80=AFPM Mike Snitzer <snitzer@kernel.org> =
wrote:
>
> From: Ming Lei <ming.lei@redhat.com>
>
> 'dmsetup remove' and 'dmsetup remove_all' require synchronous bdev
> release. Otherwise dm_lock_for_deletion() may return -EBUSY if the open
> count is > 0, because the open count is dropped in dm_blk_close()
> which occurs after fput() completes.
>
> So if dm_blk_close() is delayed because of asynchronous fput(), this
> device mapper device is skipped during remove, which is a regression.
>
> Fix the issue by using __fput_sync().
>
> Also: DM device removal has long supported being made asynchronous by
> setting the DMF_DEFERRED_REMOVE flag on the DM device. So leverage
> using async fput() in close_table_device() if DMF_DEFERRED_REMOVE flag
> is set.
>
> Reported-by: Zhong Changhui <czhong@redhat.com>
> Fixes: a28d893eb327 ("md: port block device access to file")
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> [snitzer: editted commit header, use fput() if DMF_DEFERRED_REMOVE set]
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  drivers/md/dm.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 56aa2a8b9d71..7d0746b37c8e 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -765,7 +765,7 @@ static struct table_device *open_table_device(struct =
mapped_device *md,
>         return td;
>
>  out_blkdev_put:
> -       fput(bdev_file);
> +       __fput_sync(bdev_file);
>  out_free_td:
>         kfree(td);
>         return ERR_PTR(r);
> @@ -778,7 +778,13 @@ static void close_table_device(struct table_device *=
td, struct mapped_device *md
>  {
>         if (md->disk->slave_dir)
>                 bd_unlink_disk_holder(td->dm_dev.bdev, md->disk);
> -       fput(td->dm_dev.bdev_file);
> +
> +       /* Leverage async fput() if DMF_DEFERRED_REMOVE set */
> +       if (unlikely(test_bit(DMF_DEFERRED_REMOVE, &md->flags)))
> +               fput(td->dm_dev.bdev_file);
> +       else
> +               __fput_sync(td->dm_dev.bdev_file);
> +
>         put_dax(td->dm_dev.dax_dev);
>         list_del(&td->list);
>         kfree(td);
> --
> 2.40.0
>

I tried to apply this patch and looks this issue has solved by this patch


