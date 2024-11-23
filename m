Return-Path: <linux-fsdevel+bounces-35633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CD59D6884
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 10:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032EA16118E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 09:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABFF183CB0;
	Sat, 23 Nov 2024 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="OnQMoOIZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D02E15FD01
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 Nov 2024 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732355556; cv=none; b=Yaoc4e5w0UKVt0TbxbYAFoG+1N3RjUapbO6CQr/7DZVTvb2P+wjZJzBNTsrL7PV6pZQqlVj2lWjRxRZbuLq+xhlgfDIxv8R3EDsLhdOgPXLydhu9nZ34KYFbG57Vx4C4Qpy7+qvbGAB2Noo9/+oTv7mscFaLBvHJLpYHayWVp44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732355556; c=relaxed/simple;
	bh=JsftFFy6Awj8SNiG5+p8xm/w1vLK2OFmElvQj1EPZDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=faXgRVvm1eWAZ+379z04D65GVLNlK8uTvuDS8MeeXZsgG1cOLe68FgYZQKM+p++7FB6MqNPvVz12bzE9fHM+1sd5v3TtZsdARvMWzKR898sORFd7XSJw4qv4F8beOd5398RDUoZLHEa82/smiP9eQNAsLF2M4GFwlSg1RHEdMqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=OnQMoOIZ; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-460ab1bc2aeso19118921cf.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Nov 2024 01:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1732355553; x=1732960353; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pfuwWH6s9WheFli8owZJ40a4CslfDCyeDxz9fgZYQFc=;
        b=OnQMoOIZPhy9Oe5gBN2IQLsRXHRH/UE0GNhI8ojzoR9qNeH5JIWqaOQ0HK6aU3WmDw
         N6iw8R6uLj61Le34SykIYG0f02/UbBPejKEWwSwrfP8vBJ2+863qwmDAYhIBL0WE5BPz
         BQMK/DRwCujqHTf4IWuHJfmWXiEWAn0/CbD1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732355553; x=1732960353;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfuwWH6s9WheFli8owZJ40a4CslfDCyeDxz9fgZYQFc=;
        b=eRWHBMy5l5xqBn9bcF3XaGg4Ufn6CgHHrAUHHiaZpYBewzUx//iiZ/NU2XCLYrrafq
         DAQ808otZSm7DYDXU9+502FpgJYCcWB4XPLSL+ylahx0Q1A/uCU2RT4dmGktXcxhfw5L
         AZWmh8rnhzBgCNqKAQdxIpiGVCoe+QIOygKCds1QNDN9YUqeKQA266VYJcW0ksXHjx3T
         fH4gZDotFiTHo941QqyMkvGDlxfmGZIA1B7nLT8v4u/KM8aecGey9VpbTtRzwwngEftv
         2r3FT8Gr3LT+KDQR0kUSKJUgjqC94eiiFoGHZiWxYUiSP7kBQj/PsAMKDzoQScs3XDKH
         Wrzg==
X-Forwarded-Encrypted: i=1; AJvYcCXSHjaWHJcA4TczLEFvjxBrJq2mKC6xE/3Wx3Z+ToSqf2NWSKNnyTZSEWGX71blrHKx7+lwJ8+XjTEbqPNS@vger.kernel.org
X-Gm-Message-State: AOJu0YwLOWYbTxnz+TMAfvMhkNUmDdircsHUogjAhqNM9cWQ996Anf4S
	MTvnFGIxNQkRXhQKyjBiNUUElkswX00WghlKeaqkBC9KomapgCUN+3/a8orKKVKm1UkyJPEADOi
	2L+tUZ1UJ/hHUxASwRmgjKWyjPwr0OT9A5XP2qw==
X-Gm-Gg: ASbGncsCnz+L50FqKxz1Gr/6xzdSz2rIdBvtJVHvwXqwFKC1iwd77Oy4DYAiSBd7Yux
	/eXa2MZBue1zacyMEahYkwI8DXYu3Qze8VA==
X-Google-Smtp-Source: AGHT+IE7Cdtq1dglVEIsBM11JPHkABoLeUdp8yGp5PTxuThy3hmuvowcYbrEvtHDUYqVfRNXdhwHQW32MvJkS4f6z7s=
X-Received: by 2002:a05:622a:452:b0:461:333a:46c with SMTP id
 d75a77b69052e-4653d5a4927mr79042581cf.27.1732355553365; Sat, 23 Nov 2024
 01:52:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-fuse-uring-for-6-10-rfc4-v6-0-28e6cdd0e914@ddn.com> <20241122-fuse-uring-for-6-10-rfc4-v6-6-28e6cdd0e914@ddn.com>
In-Reply-To: <20241122-fuse-uring-for-6-10-rfc4-v6-6-28e6cdd0e914@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 23 Nov 2024 10:52:22 +0100
Message-ID: <CAJfpegtih77CpuSQAOkUaKRMPj44ua65+_MUMa3LqgYjLFofqg@mail.gmail.com>
Subject: Re: [PATCH RFC v6 06/16] fuse: {uring} Handle SQEs - register commands
To: Bernd Schubert <bschubert@ddn.com>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Amir Goldstein <amir73il@gmail.com>, Ming Lei <tom.leiming@gmail.com>, David Wei <dw@davidwei.uk>, 
	bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Nov 2024 at 00:44, Bernd Schubert <bschubert@ddn.com> wrote:

> +static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
> +{
> +       struct fuse_ring *ring = NULL;
> +       size_t nr_queues = num_possible_cpus();
> +       struct fuse_ring *res = NULL;
> +
> +       ring = kzalloc(sizeof(*fc->ring) +
> +                              nr_queues * sizeof(struct fuse_ring_queue),

Left over from a previous version?

> +static void fuse_uring_ent_avail(struct fuse_ring_ent *ring_ent,
> +                                struct fuse_ring_queue *queue)
> +       __must_hold(&queue->lock)
> +{
> +       struct fuse_ring *ring = queue->ring;
> +
> +       lockdep_assert_held(&queue->lock);
> +
> +       /* unsets all previous flags - basically resets */
> +       pr_devel("%s ring=%p qid=%d state=%d\n", __func__, ring,
> +                ring_ent->queue->qid, ring_ent->state);
> +
> +       if (WARN_ON(ring_ent->state != FRRS_COMMIT)) {
> +               pr_warn("%s qid=%d state=%d\n", __func__, ring_ent->queue->qid,
> +                       ring_ent->state);
> +               return;
> +       }
> +
> +       list_move(&ring_ent->list, &queue->ent_avail_queue);
> +
> +       ring_ent->state = FRRS_WAIT;
> +}

AFAICS this function is essentially just one line, the rest is
debugging.   While it's good for initial development it's bad for
review because the of the bad signal to noise ratio (the debugging
part is irrelevant for code review).

Would it make sense to post the non-RFC version without most of the
pr_debug()/pr_warn() stuff and just keep the simple WARN_ON() lines
that signal if something has gone wrong.

Long term we could get rid of some of that too.   E.g ring_ent->state
seems to be there just for debugging, but if the code is clean enough
we don't need to have a separate state.

> +#if 0
> +       /* Does not work as sending over io-uring is async */
> +       err = -ETXTBSY;
> +       if (fc->initialized) {
> +               pr_info_ratelimited(
> +                       "Received FUSE_URING_REQ_FETCH after connection is initialized\n");
> +               return err;
> +       }
> +#endif

I fail to remember what's up with this.  Why is it important that
FETCH is sent before INIT reply?

> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> index 6c506f040d5fb57dae746880c657a95637ac50ce..e82cbf9c569af4f271ba0456cb49e0a5116bf36b 100644
> --- a/fs/fuse/fuse_dev_i.h
> +++ b/fs/fuse/fuse_dev_i.h
> @@ -8,6 +8,7 @@
>
>  #include <linux/types.h>
>
> +

Unneeded extra line.

Thanks,
Miklos

