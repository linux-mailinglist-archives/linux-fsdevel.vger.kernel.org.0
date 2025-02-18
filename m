Return-Path: <linux-fsdevel+bounces-41966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2B0A396DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 10:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8058B3B930B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 09:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E524C22E002;
	Tue, 18 Feb 2025 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="qmdWGDbL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B0922E3E1
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869635; cv=none; b=uUs+15K9tYaG1yw6P0ZpWvE6wYAsMOm2Mo8ReyhkRouKoCWV/0QQUHgzzhjBwLdMfhP4Bz80xBE8D9P+tX25qtNWA9I/av8wqL/b+XbVC3EyQt2mXkBacSZSSYRcaJqRBuV+DV3rrDi61dpsCM+LWc0x3sT7NdyJnbKzr3xktw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869635; c=relaxed/simple;
	bh=V6siWVB94BUBB6jBj3ebnaicEq3lFZHszgU93IMsniM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKl00hQxpo5b93zPZVzxx9//oPvVbSvVS95EkiI9mXpbH9y9+S73CbNuUQY+k7Dr21a0GDpkelfqMQCpeITmcFpJPh4hjZs+TdXQtLJDyk4RAV4VbdeIG600RWaiw8x8eKpYQgeA9WacAW3wRmZvm//jKsvHfQJEp8BRov7bZK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=qmdWGDbL; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-471dc990e18so27154391cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 01:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1739869631; x=1740474431; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fbFS7RZBcrA+GC03runhBHiC/eEvuCTkD7j7UDaMQRg=;
        b=qmdWGDbLpg515pSqkMBAgoLYGje5YL5YlHTHpJNke3HPqbon6Ua/1k1oxkGqjDG5Yy
         Gq96JSsuLgNvwda3lCxMLyEBFt1YRr/Naxr583McjRD6O/Udo0fON6jd5TmQxOOTkL/C
         7lyZOzfCNNI+7fmCkDso2ixKdqImiE+BGUFh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739869631; x=1740474431;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fbFS7RZBcrA+GC03runhBHiC/eEvuCTkD7j7UDaMQRg=;
        b=v+wLlUS46vkNxwgUIrJpAeEqsqCh7wwBWhntCJj8mFkM1jEp+4dKyRoPciLAZDIdio
         IzmiUi98VYuRewXZ+M5BogPQ7EK4TOoePSLcYvbxQn29WI3BhxEe7ylEL3cIT8i/Jhtq
         Mflm40H0sjhHx9nbslRqikfElyZ3ToR022RHP45Djs42YpF1BD5TErh1p91zxmxpSjJs
         ITrmohT5waMcLa/ZWF5fx9rnm0tfHgbHIYjLLXe4GPhHWpTuWuoVjLZpfBmBHSP0pMDn
         rld73PDLowVdsWJ/LUxbK/3XMQhXuZC8P5/QQfofJjG43tKv1dzJk35C1UISW7O+qipE
         gCpg==
X-Forwarded-Encrypted: i=1; AJvYcCWC9gaOfEHdbpBrr9Uz+Zr4afRssG5HbnS3lgsXf14wGMn6uKsl8aS+zdI2YmljthlEfwTvS2Tm/cl2eHQV@vger.kernel.org
X-Gm-Message-State: AOJu0YzNefYtNn7ijiXNYFZaHRFmHgTXIgHCbhqSkoB6jSfNvoDu1Y5+
	c4olqugL33BBF1ZU/e6E1qUTiq4QdpZs9uBsv8rpqpkZ8Veu4lXx33IuLFj2d+fq2rV0zZN/724
	UbCmIJKv6t9gh94v8IDN4VTHgo2MOItjTDrbUChcc1PQGGrTeO3E=
X-Gm-Gg: ASbGncu1USYC6d8k1qQWWxYh8DteeLXXImt2CHy8sKGU/Q5xzl+WIPomQafJWGSyBOU
	h/vOy0oAKAZHhZIUpz+z8mQwXTDrYMmZCP9HuuvDPL8ZskSnzEvDCJegsn/tkSxGbeh7UwtY=
X-Google-Smtp-Source: AGHT+IHO0WiXpE20jw5jR/lmxsoUW8V0GbKJCKSfHlrxnO3HrU7Vb3OjBwge4nQyHf3TtYN9kD68GyH92qM424tAcfE=
X-Received: by 2002:ac8:5e53:0:b0:471:87dd:fbee with SMTP id
 d75a77b69052e-471dbcde6b4mr174745411cf.4.1739869630962; Tue, 18 Feb 2025
 01:07:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217133228.24405-1-luis@igalia.com> <20250217133228.24405-3-luis@igalia.com>
In-Reply-To: <20250217133228.24405-3-luis@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 18 Feb 2025 10:07:00 +0100
X-Gm-Features: AWEUYZmgaspYOE0vmLhDJFrd6oAQWWOfcfAbI896UYiT11k8XCYR_jm9BKijtAU
Message-ID: <CAJfpegtJTUBa7zhY7S-vPCDc+QaJPCg+pH4NR4vN_GgwSAROGA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] fuse: add new function to invalidate cache for all inodes
To: Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Dave Chinner <david@fromorbit.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matt Harvey <mharvey@jumptrading.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Feb 2025 at 14:32, Luis Henriques <luis@igalia.com> wrote:
>
> Currently userspace is able to notify the kernel to invalidate the cache
> for an inode.  This means that, if all the inodes in a filesystem need to
> be invalidated, then userspace needs to iterate through all of them and do
> this kernel notification separately.
>
> This patch adds a new option that allows userspace to invalidate all the
> inodes with a single notification operation.  In addition to invalidate
> all the inodes, it also shrinks the sb dcache.

What is your use case for dropping all inodes?

There's a reason for doing cache shrinking that I know of, and that's
about resources held by the fuse server (e.g. open files) for each
cached inode.  In that case what's really needed is something that
tells the fuse client (the kernel or in case of virtiofs, the guest
kernel) to get rid of the N least recently used inodes.


> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
>  fs/fuse/inode.c           | 34 ++++++++++++++++++++++++++++++++++
>  include/uapi/linux/fuse.h |  3 +++
>  2 files changed, 37 insertions(+)
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index e9db2cb8c150..64fa0806e97d 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -547,6 +547,37 @@ struct inode *fuse_ilookup(struct fuse_conn *fc, u64 nodeid,
>         return NULL;
>  }
>
> +static int fuse_reverse_inval_all(struct fuse_conn *fc)
> +{
> +       struct fuse_mount *fm;
> +       struct inode *inode;
> +
> +       inode = fuse_ilookup(fc, FUSE_ROOT_ID, &fm);
> +       if (!inode || !fm)
> +               return -ENOENT;
> +       iput(inode);
> +
> +       /* Remove all possible active references to cached inodes */
> +       shrink_dcache_sb(fm->sb);
> +
> +       /* Remove all unreferenced inodes from cache */
> +       invalidate_inodes(fm->sb);

After a dcache shrink, this is unnecessary.  See " .drop_inode =
generic_delete_inode," in fs/fuse/inode.c

Thanks,
Miklos

