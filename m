Return-Path: <linux-fsdevel+bounces-47263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 186A4A9B190
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 16:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533E34A3924
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 14:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290B31A2C27;
	Thu, 24 Apr 2025 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFFGk6oZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BAC27456;
	Thu, 24 Apr 2025 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745506570; cv=none; b=hi43qZ0A+nHwEMeJEHLVJ76Z2bCfUzJiTzKhkc7lvaOWhkfaMKsfW5GdlK062C2ZxwKbEZv55H0TvXbJFvTc0B61NxPUzbzi7EYNoREkpJFkGzjFdbCZSKyUYx+kjgpr1Q8LHN6/4bFegwCY1mzzR2+xK0miiOi93+P9Q/1ZRRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745506570; c=relaxed/simple;
	bh=XVQ6Vlt4NNJnu1Z1vtdE/XWsTaunsynSA+99ZYAMqk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iOZeJfoPN76oBKDTZ3vsTSIJJbwuUOSP7T5HRw0PG3n6FRNpOkjbvtEBWiFTYYNV3kI3YERajr503S+pzgFkQXMGjUD1GNDWuqvn+ja47VlGH0jTYtFHckiDws6NZmRKYmuZkfUm6H9/4J1h1SYybD5a0LC19XJKJgKDvJ9HUsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFFGk6oZ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-30384072398so1080571a91.0;
        Thu, 24 Apr 2025 07:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745506568; x=1746111368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVQ6Vlt4NNJnu1Z1vtdE/XWsTaunsynSA+99ZYAMqk8=;
        b=JFFGk6oZ/yusOYM5nsvQMNFT0RPrpeFmnd6IbMvfWBKKb4jIF50W7Ukx7DZj2ZC68I
         r8t/Wjc9TSPQ8rUIhVT9znL9/76jrL14L/MBCr0WEVTY6DtC6Ew0zxHO6dAw9YajOwOn
         HzB1sxraWG0ekdG/X4NIkjog93YmFQbTBKbs3TF6L9/qf80h/IYA6nGb5dtmMD6zK1mm
         SjuwrZDud3UXN7zqpLbCbCF2pAK35qosEOPScDLN7k8d+OBeAhCrYEdF6rM9zKPHoH+a
         ys9DJNq5Oe69xN9PVbBJeJq/7fIn3adAWOwbDEjHq+XsM5vieUZStI70FU9pwSD1S8Bg
         EQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745506568; x=1746111368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVQ6Vlt4NNJnu1Z1vtdE/XWsTaunsynSA+99ZYAMqk8=;
        b=q08gK8j8HXzGFAO5tutUTFQY5cmAi65O8lApflxbyfnSaBU74QmJmNNJQxJsYDYWOu
         9OnQ2r8HoCY9TqAudO5WiI3zR/gfTBlo0lvLcVALIhiorF2++qgUjyhdqErRQ1Dga4C/
         shQYN1XH5rjXl8OncEFG+tdZXHeW+zv8vPW8DR9O8c33joCUiDo2U//uDkQL6JUqA9cD
         nd74eLmXvXykBdLNbBNlNzDF771S1iNIvTHbQS41DBJCQ/sEkZfYJcckWsAKp0+/9TdY
         CxOra7OGIamxAtX1fr8ghJbL0f5cZouboqCLlWn+FjsLSeq5SWTsyZ8Or7u9pv8oNJQi
         ki0A==
X-Forwarded-Encrypted: i=1; AJvYcCV9j9FXjLWCDFPClSo8gZnaP3DImoUvGy5+73WS9CKyWxzTuN55azaqc8mdwtj5xducegC/8760IXcd1Ts3@vger.kernel.org, AJvYcCVChdttNW7AdH64E+ovBnD76zs8MQMrgGk+DXNMEKD2fgNnhrf7yG13aBOZjTjZlmLovFO0zaySQMr6vMHVZi75i3kKAAC5@vger.kernel.org, AJvYcCVSdKDVWOHkcHzMCIoHDo2s+Nwo7qPYwuQ78StylsdCVCpUcHz+Zd/mMWHm+iAIrKv+OX82tZkhHA==@vger.kernel.org, AJvYcCW40nNjeJCHL1K4GYgw/9Wy4+XJtc7FgkLzvzAywJHLjSYesc6j2XqZbGobcDs75GZQfDoK8fneigBWa43r@vger.kernel.org
X-Gm-Message-State: AOJu0YwW/ltkwV3kiVOBGOp8645Uqog3eBDnZ4CnP8Mr5rGJvDypZRKy
	I9cGX4nzK2jXvSk8gMQn/343ARzDEpbxJ0hVIurQyN+pSd2Rx3PO4cL5hqTC8AMg3dRWCzxEHw+
	zkCW4unYmnAqab3+pAFaWyHSfxls=
X-Gm-Gg: ASbGnctQ7w5HdCtkAnRvMjtWv9mTT9iRbbIyEX4zQmUrcLj6unUXG+HdqoOiLIu77Rz
	AFsK+7klE4N3v15hvWvd8RtcOP940ZIw8SSctYSYbzRgRh3QBQaMgkwJ9EAtL/YK3s4S9oJVdmP
	DzWnUe9cizvpHK2DVY48zNWA==
X-Google-Smtp-Source: AGHT+IEbFCGCJlB5vwHS30qkE4/L+5bhyu8cj/YTejcSzM6Yxuwz6SugUsZP/CZ0O2+4bpe4a837ytsYPYIeG9Uw/1Q=
X-Received: by 2002:a17:90b:2d4f:b0:2fa:e9b:33b8 with SMTP id
 98e67ed59e1d1-309ed2a3af4mr5112037a91.18.1745506568259; Thu, 24 Apr 2025
 07:56:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424124644.4413-1-stephen.smalley.work@gmail.com>
 <2025042427-hardship-captive-4d7b@gregkh> <CAEjxPJ5LGH_Vyf2KCL0HNwa-U70GVAOVvyFMnhpnzi-CEKvC5w@mail.gmail.com>
In-Reply-To: <CAEjxPJ5LGH_Vyf2KCL0HNwa-U70GVAOVvyFMnhpnzi-CEKvC5w@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 24 Apr 2025 10:55:56 -0400
X-Gm-Features: ATxdqUFne-6xhD2JUQrYbdPmY5HUdNSqZkJv09bxOacTWyu64a6h6ZIhT5E-DvE
Message-ID: <CAEjxPJ4C7ritSqF0mE+2rczKJHdUTNGs5_RDx3PHKcg_rQQV4w@mail.gmail.com>
Subject: Re: [PATCH] vfs,shmem,kernfs: fix listxattr to include security.* xattrs
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: paul@paul-moore.com, omosnace@redhat.com, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 9:53=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Apr 24, 2025 at 9:12=E2=80=AFAM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Apr 24, 2025 at 08:46:43AM -0400, Stephen Smalley wrote:
> > > The vfs has long had a fallback to obtain the security.* xattrs from =
the
> > > LSM when the filesystem does not implement its own listxattr, but
> > > shmem/tmpfs and kernfs later gained their own xattr handlers to suppo=
rt
> > > other xattrs. Unfortunately, as a side effect, tmpfs and kernfs-based
> > > filesystems like sysfs no longer return the synthetic security.* xatt=
r
> > > names via listxattr unless they are explicitly set by userspace or
> > > initially set upon inode creation after policy load. coreutils has
> > > recently switched from unconditionally invoking getxattr for security=
.*
> > > for ls -Z via libselinux to only doing so if listxattr returns the xa=
ttr
> > > name, breaking ls -Z of such inodes.
> > >
> > > Before:
> > > $ getfattr -m.* /run/initramfs
> > > <no output>
> > > $ getfattr -m.* /sys/kernel/fscaps
> > > <no output>
> > >
> > > After:
> > > $ getfattr -m.* /run/initramfs
> > > security.selinux
> > > $ getfattr -m.* /sys/kernel/fscaps
> > > security.selinux
> > >
> > > Link: https://lore.kernel.org/selinux/CAFqZXNtF8wDyQajPCdGn=3DiOawX4y=
77ph0EcfcqcUUj+T87FKyA@mail.gmail.com/
> > > Link: https://lore.kernel.org/selinux/20250423175728.3185-2-stephen.s=
malley.work@gmail.com/
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > As this "changed" in the past, shouldn't it have a "Fixes:" tag?
>
> Yes, I'll add that on v2. Also appears that it doesn't quite correctly
> handle the case where listxattr() is called with size =3D=3D 0 to probe
> for the required size.

And doesn't correctly handle the case where the list size exceeds the
original buffer size. On second look, this can be done more simply and
safely in simple_xattr_list() itself, avoiding the need to modify
shmem/tmpfs and kernfs. I'll submit an updated patch.

