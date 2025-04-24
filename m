Return-Path: <linux-fsdevel+bounces-47273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2723AA9B2C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 17:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04F11775BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 15:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A4627F4CB;
	Thu, 24 Apr 2025 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTerlyrt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBF91552FD;
	Thu, 24 Apr 2025 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509450; cv=none; b=a5pZPRTwBzplhYc4u4HeGs4gga5Ly6GZt/34JgdkBVR6+b+Rp6hzkIi6TbmTCnzInDChInJpWsJt+vESip1iknpHf688mUQ0DFiQNcr0y/AYYvIcoDkFDd9s2Hszm0dlNONgi2wlp7I9a0AsrhRFfgaCc+6+xkOdgBTwlvlZqQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509450; c=relaxed/simple;
	bh=NKYBJGRW3NLditWJHCd6B3AWhUotnr3wjlWIP9wQJYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFu9XKtvUykS2uPnr920C7Lr6NtHv53hvC7NzlURoOx0pz58z93K9GeAXuHf9X+mN8XkYNALO3whOHeYllAmiR/G1+DHDgJeQ5Mqj9/I11zTqxxYfuIGgV/lQNwnWAV16vMQeeHpJqU6c/XLRGD/OGGJjjV//ssms7fkew09HBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTerlyrt; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3015001f862so1070224a91.3;
        Thu, 24 Apr 2025 08:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745509448; x=1746114248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKYBJGRW3NLditWJHCd6B3AWhUotnr3wjlWIP9wQJYg=;
        b=DTerlyrtWRQ5hYGtlySTEqR9HwevJDDbtp3vKshLcJT8wdp1i88GMQUQVTz4+lpoxR
         nMvJQJhQu9lxgXizHjc3fzE5oGJG7jsUkiA3R5StaKQS3nVn51ahxldwRdyEyW/5HiYg
         VF4k0F5aWpv1pyjMAAuvRxHUhF5xzs0EuwzbJCj8twsWoKzbqce5a57tndR/Pim7lAmy
         IVQH6k4GbLXYXH5grjKysgR2TwZCQb2a4PDqcXub9KLe5Iemh9Dd7BsstSmko74oPZTH
         EkmY9KnCUd0Jk/bmcaNJzS8XbZ7fOn3dinvQ3ZUxnu88YvCbTrJbAIDsROz4TPYS4Gwr
         AjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745509448; x=1746114248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKYBJGRW3NLditWJHCd6B3AWhUotnr3wjlWIP9wQJYg=;
        b=v9q+nde9IUa6+WrA5cT2RmsxtTA3ylBTn1qDEsPJZC8B35QtlvzpHRPmqVURlar+gr
         HWbJV2Ibu2RAsZpGjmVo44LJX12Tv4Xr41CTARTstAXAqbS6UsTp8ZnD6cPfxGIknXXI
         aZRfPlGAV9ILoJX+eTg+9LjE3uB1koPcedgxMvikbGf4O56anJUoLbs75i3oWJFzWJn5
         WxrsCpd2EjHZUjAj6ZXXlwzhGNsupt3NU1JqkW3ht6ulSuIIhuP8s5UuSK66Z8MgtXL4
         Iskv07yjjVHOkaW8Ka2qInaI41kBhV5Mc8MiiTFe+sLPscJzCYq37L5lhrFDgueYzstY
         Y2NA==
X-Forwarded-Encrypted: i=1; AJvYcCUXgAHQad9PtPqZaMg7MR9iecQB9Qb+AsA4wFzM1aAFsZJsZGBoQSyfATz+yO0KHQDvwXTaLMibBsTXYm/p@vger.kernel.org, AJvYcCUa356jozzhqTwrcJrreYeu0Ot0Awygdr7Dsl+h60nVTTk23W/7dcXxbl0y67WqC6sZ1HWmdJWdjw==@vger.kernel.org, AJvYcCUfOnLd/4BUtI5jjgqMtnsQSY2pFRQNAFLjQho77+5bz8rjrZOFYxix4798dBx2mw//TXTC7ElLrHWZQWVI@vger.kernel.org, AJvYcCVoh51co39Vr0S78Q3+uUkoxynHkewFMOIuOArVOW14ITNpZfrBOmJY9t8lkZIV54B1AaYXGw1M0FMIK5wnpU96H+fyxPRx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0+42pRZBY6AEX2pvcpF8sDhy4TvUewxi2H9nx9kJKwGBKltu+
	mDaKDk5gYzFzUDJYh4P4FsRha8s/2+Iwl+CHbvPwB482eq8mzhimlZBVwq8V/bFEgOoWi7DmISN
	lhjgnnlHVgWtjN5gPYJd1JJLj0c0rVawj2Qo=
X-Gm-Gg: ASbGncucVVDLhuIpRxIk4XjOrIqtkep+DNayIQTMdhAoG0C7g2SP5SvmucLjX/SeR8D
	cIN+bpQ+qjHCIUTyRM1d4iDekD2B5Tewmo/L51ITvCyCA7NhXMwCJXcpRI3r2c0qi8A9ptitnvn
	3VW0hxE2HBPLuVZZhLSmI4p+xv0SaQ36Zy
X-Google-Smtp-Source: AGHT+IExkOfI5k5BNcG7WP0dv3ff3ZjZnNG+ANJn4rp1JjEbkTgLNnWinqdWCZ12YxP21dwWCmISmEhEEildeIz1PSs=
X-Received: by 2002:a17:90b:1f90:b0:2ee:aed2:c15c with SMTP id
 98e67ed59e1d1-309ed3521b0mr4687662a91.28.1745509448048; Thu, 24 Apr 2025
 08:44:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424124644.4413-1-stephen.smalley.work@gmail.com>
 <2025042427-hardship-captive-4d7b@gregkh> <CAEjxPJ5LGH_Vyf2KCL0HNwa-U70GVAOVvyFMnhpnzi-CEKvC5w@mail.gmail.com>
 <CAEjxPJ4C7ritSqF0mE+2rczKJHdUTNGs5_RDx3PHKcg_rQQV4w@mail.gmail.com>
In-Reply-To: <CAEjxPJ4C7ritSqF0mE+2rczKJHdUTNGs5_RDx3PHKcg_rQQV4w@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 24 Apr 2025 11:43:57 -0400
X-Gm-Features: ATxdqUFYwUVwbOLgKuPMj0VkvJRIPCYIatOOHAVWcZMu6tTjFJjA7nGJQgros6k
Message-ID: <CAEjxPJ4i3fN8qtuY2TRiWRqy+sY3-nV_FYc4uzD-h2ZxAF-M2A@mail.gmail.com>
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

On Thu, Apr 24, 2025 at 10:55=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Apr 24, 2025 at 9:53=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Apr 24, 2025 at 9:12=E2=80=AFAM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Apr 24, 2025 at 08:46:43AM -0400, Stephen Smalley wrote:
> > > > The vfs has long had a fallback to obtain the security.* xattrs fro=
m the
> > > > LSM when the filesystem does not implement its own listxattr, but
> > > > shmem/tmpfs and kernfs later gained their own xattr handlers to sup=
port
> > > > other xattrs. Unfortunately, as a side effect, tmpfs and kernfs-bas=
ed
> > > > filesystems like sysfs no longer return the synthetic security.* xa=
ttr
> > > > names via listxattr unless they are explicitly set by userspace or
> > > > initially set upon inode creation after policy load. coreutils has
> > > > recently switched from unconditionally invoking getxattr for securi=
ty.*
> > > > for ls -Z via libselinux to only doing so if listxattr returns the =
xattr
> > > > name, breaking ls -Z of such inodes.
> > > >
> > > > Before:
> > > > $ getfattr -m.* /run/initramfs
> > > > <no output>
> > > > $ getfattr -m.* /sys/kernel/fscaps
> > > > <no output>
> > > >
> > > > After:
> > > > $ getfattr -m.* /run/initramfs
> > > > security.selinux
> > > > $ getfattr -m.* /sys/kernel/fscaps
> > > > security.selinux
> > > >
> > > > Link: https://lore.kernel.org/selinux/CAFqZXNtF8wDyQajPCdGn=3DiOawX=
4y77ph0EcfcqcUUj+T87FKyA@mail.gmail.com/
> > > > Link: https://lore.kernel.org/selinux/20250423175728.3185-2-stephen=
.smalley.work@gmail.com/
> > > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > >
> > > As this "changed" in the past, shouldn't it have a "Fixes:" tag?
> >
> > Yes, I'll add that on v2. Also appears that it doesn't quite correctly
> > handle the case where listxattr() is called with size =3D=3D 0 to probe
> > for the required size.
>
> And doesn't correctly handle the case where the list size exceeds the
> original buffer size. On second look, this can be done more simply and
> safely in simple_xattr_list() itself, avoiding the need to modify
> shmem/tmpfs and kernfs. I'll submit an updated patch.

Submitted here,
https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.smalley.work@=
gmail.com/

Sorry I forgot the Fixes tag again but added it in a reply.

