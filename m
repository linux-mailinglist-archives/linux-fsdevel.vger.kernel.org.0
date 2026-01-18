Return-Path: <linux-fsdevel+bounces-74303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26752D392DD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 06:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37F6A300C175
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 05:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58D8309EE2;
	Sun, 18 Jan 2026 05:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D79GxkMa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EB01A3179
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 05:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768712895; cv=none; b=rodsdtVpdB0cQefKx477uegcAJ+ihII+17xXH6zPNLC3ET6WJcUbwtETfrqbAX+nTKraJfnEfBqCGM79cQ5zXQMfn/cbO33NncZ4adWW+AZdhxaF6yqFfmBJlCj7520liiAsHpOdPxyRxsDJhTBaeSvWAWm/PB+q/5Ou/Z+a0n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768712895; c=relaxed/simple;
	bh=5iVKe7Eiaa//hc1Ta/DqQI5780X23iLDV5kzAvGnMG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7nFYcZoRCQE3fe3TOo5kbR2g6+GswizAHET0mLvKWt8+qzkv8JAjge8nawasFeot2vthvTVyZiEozD1RuAzZ8vkdscBeVsiummm23XzZnIcvRcNtIXnRvSx5RedlLZrPe/mlAYFMTUSFVpUcJEztGYkjuprTWQ2hkbpAsdRPZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D79GxkMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F27AC2BCC7
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 05:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768712895;
	bh=5iVKe7Eiaa//hc1Ta/DqQI5780X23iLDV5kzAvGnMG8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D79GxkMaw2BPRYGyXilGY0EI8Uqan+kEmXi6mBzfOd0DJgpBu+HFNWOujt0IifP5m
	 Bf5TTx1V25iSHfyJkBuR6d8B4Y1+Y0/87LTaoMxCDh+rBb+0ove655CRSqp0+8/4Tx
	 vAgN9XznhIarZ4EDcXN7hrmWc6DPM53uHwf8lFMIU0sdFIkGKD6WHMOgsP/NV18EUg
	 MhuQ8DO1NFBvKJ6DrWN07x+kN9mSn0YgdtnXvTUEmxBrxNnZhZhnxRVnGswfDtOQgc
	 BHepmn30a6PPC9LdsNod0GFwAeZB/6rd+VZJd69EOu/Nr3sKp6BMlFFwFIRPrXSz0v
	 CN6xpdEoGrFSg==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64bea6c5819so5527830a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jan 2026 21:08:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWtunDZQ9VCV0o3QVfyCW9i+dNypHgx6RIIRUZyckV2FER+sL563Y+OCrDEPHbQ8J6PayUQRHZg/E3aIyvA@vger.kernel.org
X-Gm-Message-State: AOJu0YyEpsjW2ypRsRU+JQ6nOeJ1AQ9eByPqWbQzks2NlUnj6fgx7ULx
	EW4rRxRnQ3ThQrJLo+HFFbkqZOT2EeX/u2/b4LH5I6LQSK5giozhZY2MGu9CVcZyM0zYYthZPAm
	co3L3pGnpofz/5ljR4Er1Us90Y6c+BsE=
X-Received: by 2002:a05:6402:3491:b0:64b:5562:c8f4 with SMTP id
 4fb4d7f45d1cf-654524cf27fmr5995270a12.7.1768712893417; Sat, 17 Jan 2026
 21:08:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260111140345.3866-14-linkinjeon@kernel.org>
 <20260116093025.GD21396@lst.de>
In-Reply-To: <20260116093025.GD21396@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 18 Jan 2026 14:08:01 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9dz_OBkMWcS5OtfU0BhEA1r4hMqtWJ_u+qWYK4Nwk+7Q@mail.gmail.com>
X-Gm-Features: AZwV_QhR0Dh5XftH4dvyYGRoMNovBiXS539HuYjzoTW9RoKODynVu7zRm4qtNsM
Message-ID: <CAKYAXd9dz_OBkMWcS5OtfU0BhEA1r4hMqtWJ_u+qWYK4Nwk+7Q@mail.gmail.com>
Subject: Re: [PATCH v5 13/14] ntfs: add Kconfig and Makefile
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu, 
	willy@infradead.org, jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com, 
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, 
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 6:30=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> > +config NTFS_FS_POSIX_ACL
> > +     bool "NTFS POSIX Access Control Lists"
> > +     depends on NTFS_FS
> > +     select FS_POSIX_ACL
> > +     help
> > +       POSIX Access Control Lists (ACLs) support additional access rig=
hts
> > +       for users and groups beyond the standard owner/group/world sche=
me,
> > +       and this option selects support for ACLs specifically for ntfs
> > +       filesystems.
> > +       NOTE: this is linux only feature. Windows will ignore these ACL=
s.
> > +
> > +       If you don't know what Access Control Lists are, say N.
>
> This looks like a new feature over the old driver.  What is the
> use case for it?
The POSIX ACLs support is intended to ensure functional parity and ABI
compatibility with the existing ntfs3 driver, which already supports
this feature. Since this ntfs aims to be a replacement for ntfs3,
providing the same mount options and permission model is essential for
a seamless user transition. Furthermore, By enabling this feature, we
can pass more xfstests test cases.
>
> > @@ -0,0 +1,13 @@
> > +# Makefile for the ntfs filesystem support.
> > +#
>
> I'd drop this, it's pretty obvious :)
Okay, I will drop it.
Thanks!
>

