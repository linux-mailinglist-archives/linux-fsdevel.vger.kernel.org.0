Return-Path: <linux-fsdevel+bounces-60259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE38DB43897
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 12:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98CFA163A7B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 10:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDE72F9C2C;
	Thu,  4 Sep 2025 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="oSb6y4CU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628992D3A6F
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756981261; cv=none; b=GsIRJ4GFYS+HBfqbSwpqBZ5LIdDyuZLQcd0mQzF9Qlkew3TFrqEwhuaLTFvNsXoGXmTcBCH/agnr6tQBNRme+upEd089vGB+j2FLbZEDOy+x48dEozkGURYO63l5vH5NcWOEORTmAq6HGc9CEyKCDMUOdIWGorCr4eM2AY1vP6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756981261; c=relaxed/simple;
	bh=b433aoBrXXG0R7nEjcSQoHgzIcrk4eN/p6CXl1NzDBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pl1tuqV5dJJa3jIlLDU5geEEGbyaBA/SnvsAhqATwoc0TJpa28N4LIcmjdp4JZj7xbfEXli29O/v9lzyLpIr6eUqSUiP/DP2bq/tFqbYBIxKvIkrmdj0BHDk3vbcSLUHljlD3zUK24t5Hz4BLuqpFX6RkAdbu0s6QBkepAO9VwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=oSb6y4CU; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b30f73ca19so6085581cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Sep 2025 03:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756981257; x=1757586057; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wrNLRmiDnO4mABfM5BV9dtyNJKhes76JJvMeNwzHogA=;
        b=oSb6y4CU5zo4Nzi+feGmJ+4/I3BBrlRvJGeiXlxKB8bP2p9ZsVQnWYdBl8jeJ5xydB
         tp+eszpppktPtsHnZXFb19mEUfz4Pd7v9QDEDLZ2vDBukLX5+vRQsYvlMFhymKllbO2/
         M71ckpY4LXsLnbGM7+RUXgTygAE/ZXDI2ybOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756981257; x=1757586057;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wrNLRmiDnO4mABfM5BV9dtyNJKhes76JJvMeNwzHogA=;
        b=KjpgMwkjK5wuHwKdlAhVKizVELK0KmTc/QmQeicXFPsnMqFhDsKQ1KBeCMy7JixB2H
         4CviXpzy/MMSQ8OXrItReROn1YCrqxr+O0AsDfBx5JMV/Eh/Y3YcH3iaOx5qrgmXOFFe
         XUOa0no9WXjLQ5kadVeQBRU+5e1q+0S126y0j9Y/BW7JpRhs/s6N88e1NQZRZCOp24nE
         c6POzgFiYiKzvdecX7zGXdtl8TQ7cxwyYRgjDTRPim3699y8VT5TjDHo/bv2fJPoLKo8
         B60S3k0Krb4Htlh6l2hIQ7Cx8x8NQ2wu+K+9JVq1AouxOFnCUx/sKXMUeyZd+jXOzuK6
         +ZiA==
X-Forwarded-Encrypted: i=1; AJvYcCUlUrUN/vV8dZuTWMVH8Jz3BpuUztsnLFx4l/DK66m7z/lkK8eqljG9bc5wdiTvwa0r3PfbZ4CgnOLLHKgV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0dgNRrKSeN7IXzK0LWvM36onlfp8QPsrqdfaWzzdScqMp4IeO
	NQrGRICiKDKZQABlmSIEOTNPussn5r5SetruhpbF5OmqZ7S0zFvqniEl/QUoYvDU3JqG9ELbx5d
	8j/Ez9jFE3tsHdGLdpkeSmI7GsMP4/Yxl1ihEDTcE7Q==
X-Gm-Gg: ASbGnctHuyK3swsb9N229O8ZMxmkdBqqKu8psfJ9NNggi4ALkqodBQbI2QMXmHplwmr
	5oUgphbQElEjAmHWEH5v1W8mQXJdb48V7cm8KFasa9M2v867fVaG4XMd1gpxGyMNH4uR5Zorur5
	X3Jz2YLwp2FPA20BZzKUkliKjAOsh3Tirh0f1eGCamckggGx0jnOKbPq54VmVlU5qk/Nr5i+8sl
	j0K79+aLA==
X-Google-Smtp-Source: AGHT+IFvOMZIRgJ+TVazW7GoCymN4V0KvZKfVgVdLI38f+SvKzLJ/WSHcsAsS+vWxAsbMSXzQ+EjriF5PvtEO6+mQx4=
X-Received: by 2002:a05:622a:420a:b0:4b1:22d4:16f3 with SMTP id
 d75a77b69052e-4b31d841e71mr232034561cf.29.1756981257154; Thu, 04 Sep 2025
 03:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828162951.60437-1-luis@igalia.com> <20250828162951.60437-2-luis@igalia.com>
In-Reply-To: <20250828162951.60437-2-luis@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 4 Sep 2025 12:20:46 +0200
X-Gm-Features: Ac12FXwyznJrcVc24jDjy8p_5uc5HeqRrPp3IHwAjIPUF5Vq8jX1Y-DYztiSzWQ
Message-ID: <CAJfpegtfeCJgzSLOYABTaZ7Hec6JDMHpQtxDzg61jAPJcRZQZA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 1/2] fuse: new work queue to periodically
 invalidate expired dentries
To: Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Laura Promberger <laura.promberger@cern.ch>, 
	Dave Chinner <david@fromorbit.com>, Matt Harvey <mharvey@jumptrading.com>, 
	linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 18:30, Luis Henriques <luis@igalia.com> wrote:

> +#define HASH_BITS      12

Definitely too large.  My gut feeling gives 5, but it obviously
depends on a lot of factors.

> +               schedule_delayed_work(&dentry_tree_work,
> +                                     secs_to_jiffies(num));

secs_to_jiffues() doesn't check overflow.  Perhaps simplest fix would
be to constrain parameter to unsigned short.

> +MODULE_PARM_DESC(inval_wq,
> +                "Dentries invalidation work queue period in secs (>= 5).");

__stringify(FUSE_DENTRY_INVAL_FREQ_MIN)

> +       if (!inval_wq && RB_EMPTY_NODE(&fd->node))
> +               return;

inval_wq can change to zero, which shouldn't prevent removing from the rbtree.

> +static void fuse_dentry_tree_work(struct work_struct *work)
> +{
> +       struct fuse_dentry *fd;
> +       struct rb_node *node;
> +       int i;
> +
> +       for (i = 0; i < HASH_SIZE; i++) {
> +               spin_lock(&dentry_hash[i].lock);
> +               node = rb_first(&dentry_hash[i].tree);
> +               while (node && !need_resched()) {

Wrong place.

> +                       fd = rb_entry(node, struct fuse_dentry, node);
> +                       if (time_after64(get_jiffies_64(), fd->time)) {
> +                               rb_erase(&fd->node, &dentry_hash[i].tree);
> +                               RB_CLEAR_NODE(&fd->node);
> +                               spin_unlock(&dentry_hash[i].lock);

cond_resched() here instead.

> +                               d_invalidate(fd->dentry);

Okay, so I understand the reasoning: the validity timeout for the
dentry expired, hence it's invalid.  The problem is, this is not quite
right.  The validity timeout says "this dentry is assumed valid for
this period", it doesn't say the dentry is invalid after the timeout.

Doing d_invalidate() means we "know the dentry is invalid", which will
get it off the hash tables, giving it a "(deleted)" tag in proc
strings, etc.  This would be wrong.

What we want here is just get rid of *unused* dentries, which don't
have any reference.  Referenced ones will get revalidated with
->d_revalidate() and if one turns out to be actually invalid, it will
then be invalidated with d_invalidate(), otherwise the timeout will
just be reset.

There doesn't seem to be a function that does this, so new
infrastructure will need to be added to fs/dcache.c.  Exporting
shrink_dentry_list() and to_shrink_list() would suffice, but I wonder
if the helpers should be a little higher level.


> +void fuse_dentry_tree_cleanup(void)
> +{
> +       struct rb_node *n;
> +       int i;
> +
> +       inval_wq = 0;
> +       cancel_delayed_work_sync(&dentry_tree_work);
> +
> +       for (i = 0; i < HASH_SIZE; i++) {

If we have anything in there at module remove, then something is
horribly broken.  A WARN_ON definitely suffices here.

> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -54,6 +54,12 @@
>  /** Frequency (in jiffies) of request timeout checks, if opted into */
>  extern const unsigned long fuse_timeout_timer_freq;
>
> +/*
> + * Dentries invalidation workqueue period, in seconds.  It shall be >= 5

If we have a definition of this constant, please refer to that
definition here too.

> @@ -2045,6 +2045,10 @@ void fuse_conn_destroy(struct fuse_mount *fm)
>
>         fuse_abort_conn(fc);
>         fuse_wait_aborted(fc);
> +       /*
> +        * XXX prune dentries:
> +        * fuse_dentry_tree_prune(fc);
> +        */

No need.

Thanks,
Miklos

