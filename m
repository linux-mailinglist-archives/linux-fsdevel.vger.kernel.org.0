Return-Path: <linux-fsdevel+bounces-48282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A0FAACD58
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 20:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3324B1C010F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 18:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA13286882;
	Tue,  6 May 2025 18:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MD5laKra"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A063328642D;
	Tue,  6 May 2025 18:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746556472; cv=none; b=nXqLg2DR4qUKsSfCVjUM0kDmKC1a47BWW7vtADtFj3LlUMzJIzBtS1Tl2IK4LF0+E2x8KVHOZavo5xwe/J/B5yrggFrKFee9B4zqOeHZqvuh0McLZ6nIPNmQtTl5uUOyug9CUJe6iNzeS6/3dY9/W5/UgtSSGayFEfvaWpg7RkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746556472; c=relaxed/simple;
	bh=9Ivr2ypTuYgHE/vR8yOGIvtcanoRu1K1Cws851i7cY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmAsg6Dgj2YpEnrCouQ7rZi2edDF63Up152t7GINIFxQi/LHiLhT04B6BjvLo/+dx4HbV+5plQTuD9qbMqLclf8lgeGVe3QgBdbdzsnHBKNdPPtAWHOIH6mWZ/7TZ97CPhxdIoIWNZfwWba2JK5nOR01dpW/PeJ6odzagMcqbwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MD5laKra; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30effbfaf4aso61018571fa.3;
        Tue, 06 May 2025 11:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746556469; x=1747161269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NyzuXvWP7l6BPkiM+NFUwAiq5d8SCX4v4+FTKp6Fj+g=;
        b=MD5laKrap5gz6o93/luRgZfO74kjWv79QqDvPSFoJspHUHIUo9bRSTtYM4D4antxiM
         //yLbS3RJHILci5MEYOwr+OYfbLRUwDGe0WabSAeaKKnY4QREwTO/XTGlIUowTUKy/sv
         iebILgMD6HB61stwF/E3fvt4Fkt81p+HbOqnU5Gx7n+ojVbSi+5ZovCrCXw3OclRUUYn
         UgP4LDg6JwLWA/KI3mAEXcsTHm4FtT+wER11JZwggj7kbM0vxB3ccLr/KfvYaJLWOrhq
         aK/qGIMewu57cRtY/73nzelFnPgOTlhzXmONr58ZBy7AB5T/YuDI/NsfoCQEjn8+hAZd
         560w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746556469; x=1747161269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyzuXvWP7l6BPkiM+NFUwAiq5d8SCX4v4+FTKp6Fj+g=;
        b=kQD6PzMSo+QT+FnqTmVrjqquUtES3tu+JVXhgUsWq4mn/5IJoxyZ89OzI8DgsHPWuM
         dL+JWl3nOYuBDJDsZb/cdO842NAUH9p0SjB9TbF+kQtpO3dkxJRl0uIcfp0+530eFYS9
         Sf5OTxhyNHT6KisaDCP1QiYpKRMUYtjnWgcwxqrD16keHBRvMEnCPjFo2pGUmc3qEZJw
         P2guZM0BfyKHc0/wQSk4fOU9u7wgHGWPtnJJWCyutkWw1xxalAoHaLOjMWYVAY9XkvfM
         me206CLZUS9Agg1CNt6I1sv6LMeA8hq/rcFAvjfV307AmwAbcjGt8Vb0JhaYD8j/f84Y
         B/YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZYQgHO3JWmhiyjsnNx2vrfvZaTpY6zKttaphoI5/KgtrqWiRAc3Zi6kMspkThvOUb1/TO2VewXVBoTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzckRh6l06RVOYPBKbThZlkQ+2WxbMY9OCuWJ3DIh3pnfKAN8LX
	qpQNakPgRnr+O9f8MzN78ylJOwkVSD1bwz5BCabulyuOnn3sb7nVZxqeTw==
X-Gm-Gg: ASbGncur7LVsMv92Vl3L91Beo/J20z4E7g08nngNH13YtX529Qb1Rksa/AS8Jg81fX2
	ZBOfRr0yub5edfIyvzOrLhY06adAhbRaKHog8KURlx49KGM4d3kFp6949vrEJs5pG2TwKPGwNAX
	NSTkNrafgtPXoU4uXQbpxNCeKKCodP9an1LosIcdr5u0gFhx5zadX8m4fLUIDhu9QCKY/pm5ZUO
	f29nzBbBBQcz09NShWtWPq8Q0l+HQfs82pmPQEGLNBHgSnwCZ2YNb6BluT0YO+wMRzPfpiXMFnb
	il9RLYVbqhfI7Oq1cAy2pXyqBuOj0Ak0/2cplzrG6d0nhoW3wKJC83U=
X-Google-Smtp-Source: AGHT+IFhFgwaYJRttjcre5OCeTLiJv6uPpuNXReQJArZmO9kKVHs5FpvaxcM4FDqzMeVBjxZWkPdrw==
X-Received: by 2002:a05:651c:2125:b0:30b:b908:ce1e with SMTP id 38308e7fff4ca-326ad33bbe6mr291311fa.29.1746556468387;
        Tue, 06 May 2025 11:34:28 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-320290176b3sm21851811fa.33.2025.05.06.11.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 11:34:28 -0700 (PDT)
Date: Tue, 6 May 2025 20:34:27 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [RFC][PATCH] btrfs_get_tree_subvol(): switch from fc_mount() to
 vfs_create_mount()
Message-ID: <juv6ldm6i53onsz355znrhcivf6bmog25spdkvnlvydhansmao@bpzxifunwl2n>
References: <20250505030345.GD2023217@ZenIV>
 <3qdz7ntes5ufac7ldgfsrnvotk4izalmtdf7opqox5mk3kpxus@gabtxt27uwah>
 <20250506172539.GN2023217@ZenIV>
 <j2tom2y6562wa7r6wjsxwgc25t3uoine45ills367o4y2booxr@3jdyomwkvt6w>
 <20250506175104.GO2023217@ZenIV>
 <4pg5rjsoxzxjgcx2wzucw2wr7uvaxws423stdlv75t2udfkash@jff3ci54z35u>
 <20250506181604.GP2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506181604.GP2023217@ZenIV>

On 2025-05-06 19:16:04 +0100, Al Viro wrote:
> On Tue, May 06, 2025 at 07:54:32PM +0200, Klara Modin wrote:
> 
> > > > Though now I hit another issue which I don't know if it's related or
> > > > not. I'm using an overlay mount with squashfs as lower and btrfs as
> > > > upper. The mount fails with invalid argument and I see this in the log:
> > > > 
> > > > overlayfs: failed to clone upperpath
> > > 
> > > Seeing that you already have a kernel with that thing reverted, could
> > > you check if the problem exists there?
> > 
> > Yeah, it works fine with the revert instead.
> 
> Interesting...  That message means that you've got clone_private_mount()
> returning an error; the thing is, mount passed to it has come from
> pathname lookup - it is *not* the mount created by that fc_mount() of
> vfs_create_mount() in the modified code.  That one gets passed to
> mount_subvol() and consumed there (by mount_subtree()).  All that is returned
> is root dentry; the mount passed to clone_private_mount() is created
> from scratch using dentry left by btrfs_get_tree_subvol() in its fc->root -
> see
>         dentry = mount_subvol(ctx->subvol_name, ctx->subvol_objectid, mnt);
>         ctx->subvol_name = NULL;
>         if (IS_ERR(dentry))
>                 return PTR_ERR(dentry);
> 
>         fc->root = dentry;
>         return 0;
> in the end of btrfs_get_tree_subvol().
> 
> What's more, on the overlayfs side we managed to get to
>         upper_mnt = clone_private_mount(upperpath);
>         err = PTR_ERR(upper_mnt);
>         if (IS_ERR(upper_mnt)) {
>                 pr_err("failed to clone upperpath\n");
>                 goto out;
> so the upper path had been resolved...
> 
> OK, let's try to see what clone_private_mount() is unhappy about...
> Could you try the following on top of -next + braino fix and see
> what shows up?  Another interesting thing, assuming you can get
> to shell after overlayfs mount failure, would be /proc/self/mountinfo
> contents and stat(1) output for upper path of your overlayfs mount...

It looks like the mount never succeded in the first place? It doesn't
appear in /proc/self/mountinfo at all:

2 2 0:2 / / rw - rootfs rootfs rw
24 2 0:22 / /proc rw,relatime - proc proc rw
25 2 0:23 / /sys rw,relatime - sysfs sys rw
26 2 0:6 / /dev rw,relatime - devtmpfs dev rw,size=481992k,nr_inodes=120498,mode=755
27 2 259:1 / /mnt/root-ro ro,relatime - squashfs /dev/nvme0n1 ro,errors=continue

I get the "kern_mount?" message.

