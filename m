Return-Path: <linux-fsdevel+bounces-12676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7DC8626D9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 19:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA161C20B89
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 18:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A1347A6C;
	Sat, 24 Feb 2024 18:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OyEjQYUJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97E34502E
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 18:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708800513; cv=none; b=iurHUzYntgpDnqfiS3fmsGtuHjWiAiJ+fb/0vVmX8I9+kWODvIEchDTnFVEj+L26IlkotLyIA5WFKFBc+d9H287EPFEOglXzB4rnuABV1urujdUwESXAAIODzkiGTW0kBgG5IYif1/h7XV/ojWvTyy35IBdU2oVN5LhtLK5Vmkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708800513; c=relaxed/simple;
	bh=11RUM0mNVeHDT9V3Lyo/l+4uCjLtsvv/SjSNWMqiBUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CG7P2hX5N7VmT0TW0avos+/i5oppjJ3NFKrb4qFCc06xbXL/nBNpFZAFHUrqsBZkD9uf00MwHRMM4O1vFjCuGtmYB0GtRvPkGNS2/zxhij3lo9Sa7I6acQASPd3tUqGVWpt103LQ1dScoJeRZY6zR38Z8P0vhHoY7e95XMVx4qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OyEjQYUJ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-563c595f968so2393160a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 10:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708800510; x=1709405310; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DumfDvGSo1Pp4ow5R7tPptL9W3CgIRy8zeR3wUKQ8ko=;
        b=OyEjQYUJyN0ghpMt5UMT8/3oNM5MSse6+zn2Xg00IvfL012deG13IEDGkJV7aACiOe
         8IdGObdwTk9Hrjf+QVd9vVzFa7kbngB9zilyY06wo0yQaiPlRn3RdyP4VjMX0CjM5dT1
         LT4LYkR0L470CAUSFchppQs6zTQoORhLgYDLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708800510; x=1709405310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DumfDvGSo1Pp4ow5R7tPptL9W3CgIRy8zeR3wUKQ8ko=;
        b=bi1xhB5tWNCQMSzaV6insbRIG74ebCdnxkqGJ444oD/mA1JDLMTU9zk86aSZXhZxg7
         HmprDYz7Azjwzbi1L9eL1lV6xyzKGMqTPDmyd2jA8jIxrhULQS0dzrCW+pf0JziuEBpB
         WcLq9W3GtvZ7Lb4RjfH0vC1cXyYYwxkXeoQvWXOQ42ESPsuKcKvAo1ZVOWO6w2rySSyK
         Wnz5PUuirStdg7q37E1O21Gafs/8YNe9KCxSrWZWzAbtAx61hlSqD4OTn6whyCkX/gI6
         yYzccOV1U+oO5a5Oa+EPWCPrF9rRDfyvRFKgRKVFRn3xPAyN659CKbKpfK11D+q1Frj/
         pxyg==
X-Forwarded-Encrypted: i=1; AJvYcCWyhDaqOJVH8MiSWrck4rkcgVJ7Ih+tBxM2TQ7dx0zg1BCs37bNP7sgMvceUdIN8Vrnu8r0caHF148SZrgBtA899Q+NUaQzyPXbUhfJkg==
X-Gm-Message-State: AOJu0Yxa3vgBsYJAS5c/mg6P7RRLQs6pq3wlP50WdMdqS6O6Q1Nnfxvq
	4iqnIYUUyuGChj4MzoxYNNxdx2ZluuqpFpBv9Rp8trPM8DVWtzG637WvOXL84LiprJEfky4xOO4
	Pf/s=
X-Google-Smtp-Source: AGHT+IHn+xxBuiG/A0F7a3JAkWIkloHLjv3V/NDeW1oJaIjW8ASmQewEBAVJ6b+sA0iRYK+mhLv+eA==
X-Received: by 2002:a17:906:3510:b0:a3e:7453:8b24 with SMTP id r16-20020a170906351000b00a3e74538b24mr1311405eja.3.1708800509979;
        Sat, 24 Feb 2024 10:48:29 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id n21-20020a170906089500b00a3d83cff358sm801563eje.70.2024.02.24.10.48.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 10:48:28 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55f50cf2021so2743887a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 10:48:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXdXi6qwa60rggyq9ureKGNsrLSPV0X8yALOlR2dM7LxVpcpFcyv9kO5QQ6xfg0/KNnfv20423PaGw8ynXD6a9KqPUxT528SIV5kUsQYw==
X-Received: by 2002:a17:906:a44d:b0:a3d:9a28:52e6 with SMTP id
 cb13-20020a170906a44d00b00a3d9a2852e6mr1939257ejb.50.1708800508274; Sat, 24
 Feb 2024 10:48:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org> <20240222190334.GA412503@dev-arch.thelio-3990X>
 <20240223-delfin-achtlos-e03fd4276a34@brauner> <20240223-schusselig-windschatten-a108c9034c5b@brauner>
 <CAHk-=wg0D8g_97_pakX-tC2DnANE-=6ZNY5bz=-hP+uHYyh4=g@mail.gmail.com> <20240224-westseite-haftzeit-721640a8700b@brauner>
In-Reply-To: <20240224-westseite-haftzeit-721640a8700b@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 24 Feb 2024 10:48:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wguw2UsVREQ8uR7gA1KF4satf2d+J9S1J6jJFngxM30rw@mail.gmail.com>
Message-ID: <CAHk-=wguw2UsVREQ8uR7gA1KF4satf2d+J9S1J6jJFngxM30rw@mail.gmail.com>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
To: Christian Brauner <brauner@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>, 
	Heiko Carstens <hca@linux.ibm.com>, Al Viro <viro@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Feb 2024 at 21:52, Christian Brauner <brauner@kernel.org> wrote:
>
> This is selinux. So I think this is a misunderstanding. This isn't
> something we can fix in the kernel.

Sure it is. SELinux just goes by what the kernel tells it anyway.

Presumably this is purely about the fact that the inode in question
*used* to be that magical 'anon_inode_inode' that is shared when you
don't want or need a separate inode allocation. I assume it doesn't
even look at that, it just looks at the 'anon_inode_fs_type' thing (or
maybe at the anon_inode_mnt->mnt_sb that is created by kern_mount in
anon_inode_init?)

IOW, isn't the *only* difference that selinux can actually see just
the inode allocation? It used to be that

       inode = anon_inode_getfile();

now it is

        inode = new_inode_pseudo(pidfdfs_sb);

and instead of sharing one single inode (like anon_inode_getfile()
does unless you ask for separate inodes), it now shares the dentry
instead (for the same pid).

Would selinux be happy if the inode allocation just used the
anon_inode superblock instead of pidfdfs_sb?

               Linus

