Return-Path: <linux-fsdevel+bounces-42074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3075EA3C3F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 16:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0546A189C8F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 15:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3522D212FA8;
	Wed, 19 Feb 2025 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="HhPCt1z9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF86212D69
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979608; cv=none; b=g2AQTZuUgzTGTDyO4u9Ddvx4p7d5adCpTo74WQLpk2mMpWOMwF7owy1sPPBwNFzZ9mzZEu4Fwr862urXAxj7GUo0Wd/pC7zyR65jR8NbPBzhscyMaA0Xt7zzbf1GlMYUOhHZMysp2fNt9NpcqvnqFu4JIPj7f+HOEU9GR1dUkO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979608; c=relaxed/simple;
	bh=buTHsj2oaFq5Wqga1EBuGagDv+saNvOZR/UVtfuyT4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KetDOefBJ9jP0Ci/PUDvGpNXZ1+jgVEV3fN29+VVo5ZgJSeoHcMNrzg2gDuPi4cBaqvgZRFPN1v7AnlQkT+9X+hz/5NXCjvaOci/LlqcH56HHBqBbeozyLYbd+Z/G96KYb7g3XbQxHxokG1iMEL3ToobOVOeNzeVqM6KHO6pXa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=HhPCt1z9; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-472003f8c47so8875821cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 07:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1739979604; x=1740584404; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=92iIBWqK77Z7RcDzOrfe8c0bA9AELD7+jjJwAT/7JP0=;
        b=HhPCt1z96x0HkTwLe/IKTSeyx0/SOX03j11AitZXAifIeLfRbKtaTUf4FVqm0A9QW4
         aahVvQ2Wgrqs7Fga8Vic/BcH7HZ1nbhh1y4e/yKNBPmz7GkvT54cAyU+n5Tead6a7Coa
         vfI831sXwnkxlpZDxsDC2wtHQjHp2Up3fyxfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739979604; x=1740584404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=92iIBWqK77Z7RcDzOrfe8c0bA9AELD7+jjJwAT/7JP0=;
        b=qk7xqPJTfY9icmWI583kkhLtv7gq1io/vg/vB5tgAOX24BXjVhrCNqsrqXr/Skb1oQ
         EVGtivVufQj7/QeYpiT0xX+itxIcoEPAIO3SvzAsyiyZo/yzD+xhXln4MUbgKqc++G3y
         8u5BxJ15Xo1kHSeXfMjjlBK9oaqa+QFXWgdKpjrk8TlCmlOk+pA53OUU6oHfeWFVq8dr
         rtfPU70DhLAlW9hyqdRZMTbuk1Y0x8+solDwFLpvh+4p6vh9TV8QzWiL3Hg7iLfCFY9z
         sbl+asNV/kUeIUx2IfrlW4wlpjbjLuNBIiCxYbY3YjwuuZW5XJDU8VeDtGKJl6QwRsEb
         70XQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4t14owbSdQkdZlV3aOvcWy/79+/V6/WOEmD8W5OR08yLY0uui/fj+qLS2B0+O4fD5V7dcAzgBhAtqOxrt@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu9ib8VJR4L6eKn5xUCDl57Y4Wz/dlHk0JNfYGTuUeHM57LeT/
	jYyvKySfX3HpczffpRyVPSwmhPmxp0rQaCIA3rHiHc9r7gLkOpI0pmkxLInknfFkyEJgxQxjX1Q
	qC8UK7Pr6k41uSPNLCEWpYLS5gr/CbtsvKl0P0g==
X-Gm-Gg: ASbGncsGdOiTtL4irkrjzxLgWJxqRg6fsw9CLeEuJ9BjhwV+OPjdDkybtZkyXIS7+NK
	/XWMNhqBm7MYrGhItG0Ubwx/UcKLjCh8U31qYO+QaTv9Wv0XkN8XhfeQp4GxdHZ604CfjlRE=
X-Google-Smtp-Source: AGHT+IFAeU/+H+SJFluznNcKJQGWZ0dI8+j7igAo72ORVv+picT+17KaUR1+ksOwgZMe+UPUb+KJUxbhqcefENa7mOM=
X-Received: by 2002:a05:622a:250e:b0:472:2bc:8763 with SMTP id
 d75a77b69052e-472081120acmr72334071cf.17.1739979604016; Wed, 19 Feb 2025
 07:40:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217133228.24405-1-luis@igalia.com> <20250217133228.24405-3-luis@igalia.com>
 <Z7PaimnCjbGMi6EQ@dread.disaster.area> <CAJfpegszFjRFnnPbetBJrHiW_yCO1mFOpuzp30CCZUnDZWQxqg@mail.gmail.com>
 <87r03v8t72.fsf@igalia.com> <CAJfpegu51xNUKURj5rKSM5-SYZ6pn-+ZCH0d-g6PZ8vBQYsUSQ@mail.gmail.com>
 <87frkb8o94.fsf@igalia.com> <CAJfpegsThcFwhKb9XA3WWBXY_m=_0pRF+FZF+vxAxe3RbZ_c3A@mail.gmail.com>
 <87tt8r6s3e.fsf@igalia.com> <Z7UED8Gh7Uo-Yj6K@dread.disaster.area> <87eczu41r9.fsf@igalia.com>
In-Reply-To: <87eczu41r9.fsf@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 19 Feb 2025 16:39:53 +0100
X-Gm-Features: AWEUYZnsd8RmZK6RM-APkCg4E8uZetY9FeJcgcAmTH8on7mvgs9rhtwhdwChAuM
Message-ID: <CAJfpegs-_sFPnMBwEa-2OSiaNriH6ZvEnM73vNZBiwzrSWFraw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] fuse: add new function to invalidate cache for all inodes
To: Luis Henriques <luis@igalia.com>
Cc: Dave Chinner <david@fromorbit.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matt Harvey <mharvey@jumptrading.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Valentin Volkl <valentin.volkl@cern.ch>, 
	Laura Promberger <laura.promberger@cern.ch>
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Feb 2025 at 12:23, Luis Henriques <luis@igalia.com> wrote:

> +static int fuse_notify_update_epoch(struct fuse_conn *fc)
> +{
> +       struct fuse_mount *fm;
> +       struct inode *inode;
> +
> +       inode = fuse_ilookup(fc, FUSE_ROOT_ID, &fm);
> +       if (!inode) || !fm)
> +               return -ENOENT;
> +
> +       iput(inode);
> +       atomic_inc(&fc->epoch);
> +       shrink_dcache_sb(fm->sb);

This is just an optimization and could be racy, kicking out valid
cache (harmlessly of course).  I'd leave it out of the first version.

There could be more than one fuse_mount instance.  Wondering if epoch
should be per-fm not per-fc...

> @@ -204,6 +204,12 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
>         int ret;
>
>         inode = d_inode_rcu(entry);
> +       if (inode) {
> +               fm = get_fuse_mount(inode);
> +               if (entry->d_time < atomic_read(&fm->fc->epoch))
> +                       goto invalid;
> +       }

Negative dentries need to be invalidated too.

> @@ -446,6 +452,12 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
>                 goto out_err;
>
>         entry = newent ? newent : entry;
> +       if (inode) {
> +               struct fuse_mount *fm = get_fuse_mount(inode);
> +               entry->d_time = atomic_read(&fm->fc->epoch);
> +       } else {
> +               entry->d_time = 0;
> +       }

Again, should do the same for positive and negative dentries.

Need to read out fc->epoch before sending the request to the server,
otherwise might get a stale dentry with an updated epoch.

This also needs to be done in fuse_create_open(), create_new_entry()
and fuse_direntplus_link().

Thanks,
Miklos

