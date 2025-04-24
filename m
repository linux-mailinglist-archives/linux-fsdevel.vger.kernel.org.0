Return-Path: <linux-fsdevel+bounces-47253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C82A9AFD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 15:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77158179B2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 13:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D92A19A2A3;
	Thu, 24 Apr 2025 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyWu7Yl5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DE8158858;
	Thu, 24 Apr 2025 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745502829; cv=none; b=mD3WDcBQ3Y+2qOC17XHMk2mU1AqIZDYtIA3bMH8hiJkpfXoKWdHu2B4S76cexfZUc5RZNimVmLlCj3p85Th8VuPv15jxVGxtU4HiVR5e/s5lISpGPYTd3s2hlaNBTmCGxGheDWrJCsH/0vgvu5dz2uo++OcRuX5hjKksVgyla4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745502829; c=relaxed/simple;
	bh=XCdDB8vyzVodNj24dGQS42DgtCQbWMXuCM3lTeB9QzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLVP8Btw+Dv3BBAkkfviyZVXc63evo2Iees/8LMZJrPWJT9Ms/gGvzyOvewft0r3yBNmPb4VMLsS9rglVa6if/t4alcEBrC4n0ch4ztRrrEOfrcfpIcS2MkUhqaRS8jNGMfXCpE+9Iu8gs7D3hOrGjyiWE0QwrlNbaGAs3NYVi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyWu7Yl5; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b061a06f127so645333a12.2;
        Thu, 24 Apr 2025 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745502827; x=1746107627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCdDB8vyzVodNj24dGQS42DgtCQbWMXuCM3lTeB9QzI=;
        b=KyWu7Yl5vxNqDfxlLBQhqbPkBtdAZOxvugvLEj1Ino3NXs6K78Df65OeSAew11lM69
         tgpp8fl0t5/2Rakc6606jTA5JWvOG2L9YQFy1SfUUtIF/WGRY3VH6rdzSgzDtfpClCxq
         ZjJHnxzCjHyzeK2bbFda9Bxc6QKgbUHLcMX6UbEnuwnoeo5eJkJvYIrYN/iSmFfwgEkU
         81tIFDPYfEFQq7Q4c/Uv771whg05yn6JIiyn5RMwLQZWCJ4DFSXRooctQ6EtH8j0UWEk
         deHgp+nJ1kbI0X0h4K2pp5nmffO/cn6c1MA6HLWTGzbi5PJ2yMQH3djwwA0nJnXiV3P8
         zRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745502827; x=1746107627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCdDB8vyzVodNj24dGQS42DgtCQbWMXuCM3lTeB9QzI=;
        b=wxnmbbBOnbP3uIVZWEEDSu2tohWpScUjQF7tRXFmtJ3iPTf36Uokmp39QxkMFnBnhg
         Wt+gtl0916ncZThwHUHv6vwYe05K7dI92p6JW2qrPep4F7AUo+xVhx57UBaZqf6RMVa8
         Tm3gacDawn2XdQwEc3aM6XPJDca4XRBi8BlVZ44uH2rF5haXXh76PnYo+r+//+v4sNoh
         9d3UagQDHoiH+oOQGF7X1hZ1RWj8iC9wA4MvDf+KDU24lfV0Kq2kOTY/lX7G9FKg9A4V
         +wQiP4cABvI99D+diwal6pD64EYK7KXZqkccwbY7+PEm/dOL4CgkhE1rP5sgBAuN76bZ
         qP3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9bWSIX0Oig02V5aKd2BgGadVEXxPMpOU3wG2eKHY8K+/U6JH2w12Ip0AfIGCDGH6l3lJZG2FTbH7zRm0jO1EpIzjPRNTe@vger.kernel.org, AJvYcCUd/4Wz/2oF03PCGcDG4kS3e4AKOvmBcOvg/CtAoOVHQfWQuXb62EpMSXFRPCrKJ9Y9cpssU8yvkj40W0cW@vger.kernel.org, AJvYcCVK8BBCUd3X5vdPGIRHp334Qp4pzk4o+6ZkPugD/Oza+MxBx0Q3zKFV4EUc1Kki8rsnABKhug2g3W9F9tHu@vger.kernel.org, AJvYcCVpJPrbZYIOBEPHe+UZq/AYltoeyFNQkO8VeARP2uCIythDOh6K1Muf/4vrnxWYG8xivmkv56jo/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXQrbO5C5pcWEgvMNdWRx35zTsasJy+60HEduXvflWjJtqUws0
	NXiHjdnms0RsyTLsXRX9cgpIQpcDz+W/7t3rhVLZoC7i+aWgU7I59TOSl8WvjLzTBtNgX5qZFXt
	cEHBjS6J+q+yrUHyMFO0rJrTnFiE=
X-Gm-Gg: ASbGncuRUHDAdq3eHVSHFixaO8czyElK3gsmcDSdM32xhJ98ENqKn5N7FOA5yAQxYyo
	BbSQeDdM6U7D4NdADYv+D/T/tEdkI5/NVPvVKlYvRd0MtmYHF/kVWyIESrApGrkFk+vWTxw7wqm
	emIvK7k0EQqjRCJvUTP82KFA==
X-Google-Smtp-Source: AGHT+IHmiV2rWP6yv3KQljQsE888DhuQ4aI9hOeNLvxVP5Y3ADd1TyB7LHDhH+1TrQbcBvhVAu6u5FeMtJmFNvogQgY=
X-Received: by 2002:a17:90b:5252:b0:2fa:228d:5b03 with SMTP id
 98e67ed59e1d1-309ed285c0dmr3563798a91.19.1745502827291; Thu, 24 Apr 2025
 06:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424124644.4413-1-stephen.smalley.work@gmail.com> <2025042427-hardship-captive-4d7b@gregkh>
In-Reply-To: <2025042427-hardship-captive-4d7b@gregkh>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 24 Apr 2025 09:53:36 -0400
X-Gm-Features: ATxdqUGgUngJcCmJc0s7SBLYKDMz9Vn2SWYGB2QfAAKIVQW0WWNLSTPolwBxgCU
Message-ID: <CAEjxPJ5LGH_Vyf2KCL0HNwa-U70GVAOVvyFMnhpnzi-CEKvC5w@mail.gmail.com>
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

On Thu, Apr 24, 2025 at 9:12=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Apr 24, 2025 at 08:46:43AM -0400, Stephen Smalley wrote:
> > The vfs has long had a fallback to obtain the security.* xattrs from th=
e
> > LSM when the filesystem does not implement its own listxattr, but
> > shmem/tmpfs and kernfs later gained their own xattr handlers to support
> > other xattrs. Unfortunately, as a side effect, tmpfs and kernfs-based
> > filesystems like sysfs no longer return the synthetic security.* xattr
> > names via listxattr unless they are explicitly set by userspace or
> > initially set upon inode creation after policy load. coreutils has
> > recently switched from unconditionally invoking getxattr for security.*
> > for ls -Z via libselinux to only doing so if listxattr returns the xatt=
r
> > name, breaking ls -Z of such inodes.
> >
> > Before:
> > $ getfattr -m.* /run/initramfs
> > <no output>
> > $ getfattr -m.* /sys/kernel/fscaps
> > <no output>
> >
> > After:
> > $ getfattr -m.* /run/initramfs
> > security.selinux
> > $ getfattr -m.* /sys/kernel/fscaps
> > security.selinux
> >
> > Link: https://lore.kernel.org/selinux/CAFqZXNtF8wDyQajPCdGn=3DiOawX4y77=
ph0EcfcqcUUj+T87FKyA@mail.gmail.com/
> > Link: https://lore.kernel.org/selinux/20250423175728.3185-2-stephen.sma=
lley.work@gmail.com/
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> As this "changed" in the past, shouldn't it have a "Fixes:" tag?

Yes, I'll add that on v2. Also appears that it doesn't quite correctly
handle the case where listxattr() is called with size =3D=3D 0 to probe
for the required size.

