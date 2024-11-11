Return-Path: <linux-fsdevel+bounces-34242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487C39C40F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 15:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8DE0B21D56
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 14:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623541A072A;
	Mon, 11 Nov 2024 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="e4lRltPZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05821E4A4
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731335476; cv=none; b=Rh+OG41uNxokK4FKY6o2tRfo8oJiM7KA3a3BmAhTuPObHcFaZBxIXXQxMfnKyG++SbWDMlsl8yd3jFpXgcNgSjxtS5dr4ANcSTDMb9LrGyLtDVLykAdBqtnH90Vig2HIZaeToM8O84A6avU9MpDzyXwVvKbcVyqaiJtTV65Pe2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731335476; c=relaxed/simple;
	bh=XG5CRUkTbt5WTQ85dK7AB2Vi2VrUURBKyYaPqbFSJsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ezI+Gw17CxGOXsnxNURRGA08XAK+i0lNnuZ0a/wWEmTQ9GkmtzcQuavW8/2BiLfyNo2tspvD9VpD1nWbZqzHER1q4SyYWbiUQnCcVvD3rKzEVy6P0dtgKJq2mujP57ocT4G0r1SABHkEUdDqAenxHtBBStayUKd7U9TxVJDFr+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=e4lRltPZ; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-460e6d331d6so28438071cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 06:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731335473; x=1731940273; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bjQEvgWBp2B3femAyiEE2sDZdOd4LPyc39EnesXrraI=;
        b=e4lRltPZTRMcRopYCSZ5K4E5GjNBPRaQYkQeb5myivIgE6hPKRiWritJKsHWqUekba
         qRFfs3qLroyjcT7G5AA4PKkylisQUiqu3uQ9GvgRbl/wfQh+XY8Gytj5cAytC7bInR6S
         BpXM8/UjE+R1rrbM7ktRkO7nc9/p/JYoWYwwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731335473; x=1731940273;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjQEvgWBp2B3femAyiEE2sDZdOd4LPyc39EnesXrraI=;
        b=Wh30vMwEVHUdmNsbv+wVX+RtVNjWBQgW+pIDfxJ8ooT/6zQqItIxM1xL9D17T4UqrZ
         rR8FsX7ds4Qw9M4V54il4xrix4c7u1u5hEzVQh6rkSrW/1OkW+Uo3gNv+RV/qHIn05lW
         cP4qTcIu5YzBX6yP60J+IDN7N7yYXjb3xvHq3m8+AXWwp6MIPrW3xolMvXerLMNm9QQd
         T4icotoUpDRS6pZVR9Qd2afFNmGOt+HY65+6S4hjFuDZ3WVKDZbQqaYKklS4t9vwbSBf
         dD2YeMFmn5M2BKk6rMb9WiasiKEo9l+cf0P4Xzysa6aanc9erh81OEXvY0y+/9Kas5c2
         v/iA==
X-Forwarded-Encrypted: i=1; AJvYcCVgPV1JhHLwNKFCDVMHLT4vmxh8AS0OfyCkHxqcZpq8kFAARmbQVtPvYm0FXs/JDqrKnjQ8W3z+s5DXbstC@vger.kernel.org
X-Gm-Message-State: AOJu0YyppT8dZ9j8bYIZRHGv0OHM212r2FX0amn8MO4yuwBopjhx3c9y
	L5BV18nt9Rm8t5MMWoH0VRlOZ06UkzdhagcY9JdnEfb9qKj8U0nuZ8AURYZO4BKJLhDn79PUTIy
	T58xcf3oQBYE3iZQxGbyhkX5gTDXKHN6Gh7VVzg==
X-Google-Smtp-Source: AGHT+IFwjfVAdGvSWbVD01pjbiSg9CpPS5Fc1yt3FmFrR38tF8H5FoVF5ez+II/L5JrvR2ee4KQG3Qf9gFrr1WpImC4=
X-Received: by 2002:a05:622a:4e85:b0:45f:8ee:1859 with SMTP id
 d75a77b69052e-46309209d1cmr172053631cf.0.1731335472760; Mon, 11 Nov 2024
 06:31:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107-statmount-v3-0-da5b9744c121@kernel.org> <20241107-statmount-v3-2-da5b9744c121@kernel.org>
In-Reply-To: <20241107-statmount-v3-2-da5b9744c121@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 11 Nov 2024 15:31:02 +0100
Message-ID: <CAJfpegs9ntOf-nZchBgx3DnxY-gYzBM0atOBQuXQse-9pinLSQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] fs: add the ability for statmount() to report the mnt_devname
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Ian Kent <raven@themaw.net>, Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Nov 2024 at 22:00, Jeff Layton <jlayton@kernel.org> wrote:

> diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
> index 2e939dddf9cbabe574dafdb6cff9ad4cf9298a74..3de1b0231b639fb8ed739d65b5b5406021f74196 100644
> --- a/include/uapi/linux/mount.h
> +++ b/include/uapi/linux/mount.h
> @@ -174,7 +174,7 @@ struct statmount {
>         __u32 mnt_point;        /* [str] Mountpoint relative to current root */
>         __u64 mnt_ns_id;        /* ID of the mount namespace */
>         __u32 fs_subtype;       /* [str] Subtype of fs_type (if any) */
> -       __u32 __spare1[1];
> +       __u32 mnt_devname;      /* [str] Device string for the mount */

One more point:  this is called source in both the old mount(2) API
and in new the fsconfig(2) API, where it's handled just like a plain
option (i.e. "-osource=/dev/foo").

Also this is a sb property, not a mount property, so the naming is confusing.

So I'd call this "sb_source" for consistency.

Thanks,
Miklos

