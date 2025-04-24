Return-Path: <linux-fsdevel+bounces-47254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D6EA9AFF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 15:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3F11B60864
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 13:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336DB19AD8C;
	Thu, 24 Apr 2025 13:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5+9t6iY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9139A17A5BD;
	Thu, 24 Apr 2025 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745503130; cv=none; b=qCkkQI0o9eiAuLDzpa5t44ZZ7s7mxLXWge28ozCIhJNv7HHtE9kxcIHtDLx/9H/yL+E1i1nZ2YJi4+BqrNxgFEyhN7BHBjZ8EROiFf5E+puWdjnuqGrw8EzIvHwEQu1Gl1WgAkrgXbRvLDteBANHfsHHNPHC1ycV+JFZEcx85i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745503130; c=relaxed/simple;
	bh=roCOMASC61fxNjRvcG7X733qQAHVmY4p3oEH/tVUyNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hitoamtxQhAmzVsHAq0CDz5m9S/GQEH1bHaVvB0gWJ2O8i2lbALwNpguHgSVvGn9P1RgZ9HpQJ7LWTjYfSub+NxZxB1tgTT58nD1toWiPd0hwvXnm21fZ2umg/C3Vbblk5KEdV8NXYPznzWa1yreVfeD/PLQBtMN9TWHdhhhVbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5+9t6iY; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3106217268dso10645101fa.1;
        Thu, 24 Apr 2025 06:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745503126; x=1746107926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eW+q06tANeKFdz+pcASrKa+LjFcuDiO+bG3mrye8g0=;
        b=h5+9t6iYahKvyS1UVxxExVLNC+9QzU8oDHiFR9Ah0lP6InYj2K3YHQBrUg9xT1/PD+
         dE+MGz+g29WSbwCCL2X9L5jWSL1h+TDmnVUqgDM9CxfXN7hBTdTUgFV6buKdIBc7j3aA
         mrMiz1CdasLhEyhCJOp5JHEhnShrQJqCUqOWNRvTduZ2ei/XCmbXeVJo2kVELOYU+/CW
         JMQNpUJpRUu2qD9UeN1zC8afrtQHnCwT+sR6RKCpI4cXDo23aN1iux3iyxRcnO5+yN4l
         QCy/3OOdJr6Ft139b3iQ/6V0aSzzQP72lIw65ZOhLq0RVfdSZVcPQv8A40f1nIczLj++
         PTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745503126; x=1746107926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eW+q06tANeKFdz+pcASrKa+LjFcuDiO+bG3mrye8g0=;
        b=BLfFfUbqN0dZncfzFKHaAvfdzSzabxI7GmM0DuKi1EgqnUxmKBhg72L2n3A0j1REj8
         GvHp/yjQAUTVqurrVem4MEm5bepYlAfhrwUSnjdW8l8zl8bLRa/NK8IH0AcxR+CG/cFm
         oT6d53aOEUpCHmABjLUnqZQMcEFz+AUsGhDW6hO9J24osI4pUumv31AiEPycMxCV8Hi8
         tkDgJVvGqwyL0z1I30zPSoY3HfyEGMsFZKZBliLQc290fLvMjwaVUFeiXW1z7391iK9g
         4oIQPqf5OSjZ7C6VPGg+TcgJma55QWGUHSf9rUX4SXrl9eJHtIF5yUmgoYukB6jCa7L6
         mvAw==
X-Forwarded-Encrypted: i=1; AJvYcCUAmwNA5OiXWyKhNlSDnycnvinIO1WeFBiyNnl4y4yuAY1GGKpSNoWz1CN8c5Bat2jSqtPlgji8HWRY1GWRwg==@vger.kernel.org, AJvYcCUDcBEyrCSwj9u8VBcZwzhmjw74GqXbTwVZPZEyW8TrN+cPdy2eMc+An1FwSwhBSRb89nSeEfg4OXeJylyx@vger.kernel.org, AJvYcCUnr2ohJKcx/V2gSk+YipMZ88y1+A8Nhy8jZryI1q8xB+hN+SHA/6D6fOUhwsjOMxWpmyRR8B7Ou/SJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6U3ZLlwRsmoCfON+RT5DnXTK1/fsNdNjh6MeOGqVOGj1u74fg
	Cp8JvozLB+Agye55lCsVHAQx2whgONgqq9lh86f0dxocJdSxHn8xJnuyMUSEHNuFMNP7lW5JUqq
	97xUv19pczkBUWsq8WF3UXmATp6w=
X-Gm-Gg: ASbGncsbTEiANgk/ieJiwqnZG8i/Ztoi4lN+Xh0k0RuyVbqMZd0PYQVrIIWDAiN9Hda
	HqW/a8H55wVTYNminclxHpVSTSmXGxSOpABp0acNW/ohZe+iOt6OcCfTbJ4fblX7UU19CCd6iOb
	9aEIyGSdS6JbBj0ahCp36/F/2oiXzYNkO/jt8uCF7oCMeDL+rGHnYACBc=
X-Google-Smtp-Source: AGHT+IHQatD9nTP8KXdc1kwZYbPboXfH4OZgUxShzMlbYxWrOZEhE5LMHmRZXvq9po48Aoum0jrxdnORWl3K+/cCShs=
X-Received: by 2002:a2e:bc85:0:b0:30b:f15f:1c02 with SMTP id
 38308e7fff4ca-3179efe0102mr9535751fa.18.1745503126095; Thu, 24 Apr 2025
 06:58:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <10bec2430ed4df68bde10ed95295d093@3xo.fr> <35940e6c0ed86fd94468e175061faeac@3xo.fr>
 <Z-Z95ePf3KQZ2MnB@infradead.org> <48685a06c2608b182df3b7a767520c1d@3xo.fr>
 <F89FD4A3-FE54-4DB2-BA08-3BCC8843C60E@manguebit.com> <5087f9cb3dc1487423de34725352f57c@3xo.fr>
 <f12973bcf533a40ca7d7ed78846a0a10@manguebit.com> <e63e7c7ec32e3014eb758fd6f8679f93@3xo.fr>
 <53697288e2891aea51061c54a2e42595@manguebit.com> <bb5f1ed84df1686aebdba5d60ab0e162@3xo.fr>
 <af401afc7e32d9c0eeb6b36da70d2488@3xo.fr>
In-Reply-To: <af401afc7e32d9c0eeb6b36da70d2488@3xo.fr>
From: Steve French <smfrench@gmail.com>
Date: Thu, 24 Apr 2025 08:58:34 -0500
X-Gm-Features: ATxdqUEgjvtyeGM1mMPru1UeLSyG75lh6Xs5ECksiJXf13B4FoCddn4I1d1pkCI
Message-ID: <CAH2r5mvZWcf9N=r0S2sHU11cR_6cP1KyMA2k9fsOJY9GJ79nXQ@mail.gmail.com>
Subject: Re: [netfs/cifs - Linux 6.14] loop on file cat + file copy when files
 are on CIFS share
To: Nicolas Baranger <nicolas.baranger@3xo.fr>
Cc: Paulo Alcantara <pc@manguebit.com>, Christoph Hellwig <hch@infradead.org>, hch@lst.de, 
	David Howells <dhowells@redhat.com>, netfs@lists.linux.dev, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> when the CIFS share is mounted by
> systemd option x-systemd.automount (for example doing 'ls' in the mount
> point directory), negociated values are:
> rsize=3D65536,wsize=3D65536,bsize=3D16777216
> If I umount / remount manually, the negociated values are those defined
> in /etc/fstab !

That does seems broken (and obviously can hurt performance
significantly as most servers negotiate an rsize and wsize of at least
4MB).

It looks like it can be overridden by creating the file to configure
the smb3 systemd automounts in /etc/systemd/system but it is odd that
it overrides the default that would be used for normal mounts or
/etc/fstab automounts

On Thu, Apr 24, 2025 at 2:40=E2=80=AFAM Nicolas Baranger
<nicolas.baranger@3xo.fr> wrote:
>
> Hi Paolo
>
> Thanks again for help.
>
> I'm sorry, I made a mistake in my answer yesterday:
>
> > After a lot of testing, the mounts buffers values: rsize=3D65536,
> > wsize=3D65536, bsize=3D16777216,...
>
> The actual values in /etc/fstab are:
> rsize=3D4194304,wsize=3D4194304,bsize=3D16777216
>
> But negociated values in /proc/mounts are:
> rsize=3D65536,wsize=3D65536,bsize=3D16777216
>
> And don't know if it's related but I have:
> grep -i maxbuf /proc/fs/cifs/DebugData
> CIFSMaxBufSize: 16384
>
> I've just force a manual 'mount -o remount' and now I have in
> /proc/mounts the good values (SMB version is 3.1.1).
> Where does this behavior comes from ?
>
> After some search, it appears that when the CIFS share is mounted by
> systemd option x-systemd.automount (for example doing 'ls' in the mount
> point directory), negociated values are:
> rsize=3D65536,wsize=3D65536,bsize=3D16777216
> If I umount / remount manually, the negociated values are those defined
> in /etc/fstab !
>
> Don't know if it's a normal behavior but it is a source of errors /
> mistake and makes troubleshooting performance issues harder
>
> Kind regards
> Nicolas
>
>
>
> Le 2025-04-23 18:28, Nicolas Baranger a =C3=A9crit :
>
> > Hi Paolo
> >
> > Thanks for answer, all explanations and help
> >
> > I'm happy you found those 2 bugs and starting to patch them.
> > Reading your answer, I want to remember that I already found a bug in
> > cifs DIO starting from Linux 6.10 (when cifs statring to use netfs to
> > do its IO) and it was fixed by David and Christoph
> > full story here:
> > https://lore.kernel.org/all/14271ed82a5be7fcc5ceea5f68a10bbd@manguebit.=
com/T/
> >
> >> I've noticed that you disabled caching with 'cache=3Dnone', is there a=
ny
> >> particular reason for that?
> >
> > Yes, it's related with the precedent use case describes in the other
> > bug:
> > For backuping servers, I've got some KSMBD cifs share on which there
> > are some 4TB+ sparses files (back-files) which are LUKS + BTRFS
> > formatted.
> > The cifs share is mounted on servers and each server mount its own
> > back-file as a block device and make its backup inside this crypted
> > disk file
> > Due to performance issues, it is required that the disk files are using
> > 4KB block and are mounted in servers using losetup DIO option (+ 4K
> > block size options)
> > When I use something else than 'cache=3Dnone', sometimes the BTRFS
> > filesystem on the back file get corrupted and I also need to mount the
> > BTRFS filesystem with 'space_cache=3Dv2' to avoid filesystem corruption
> >
> >> Have you also set rsize, wsize and bsize mount options?  If so, why?
> >
> > After a lot of testing, the mounts buffers values: rsize=3D65536,
> > wsize=3D65536, bsize=3D16777216, are the one which provide the best
> > performances with no corruptions on the back-file filesystem and with
> > these options a ~2TB backup is possible in few hours during  timeframe
> > ~1 -> ~5 AM each night
> >
> > For me it's important that kernel async DIO on netfs continue to work
> > as it's used by all my production backup system (transfer speed ratio
> > compared with and without DIO is between 10 to 25)
> >
> > I will try the patch "[PATCH] netfs: Fix setting of transferred bytes
> > with short DIO reads", thanks
> >
> > Let me know if you need further explanations,
> >
> > Kind regards
> > Nicolas Baranger
> >
> > Le 2025-04-22 01:45, Paulo Alcantara a =C3=A9crit :
> >
> > Nicolas Baranger <nicolas.baranger@3xo.fr> writes:
> >
> > If you need more traces or details on (both?) issues :
> >
> > - 1) infinite loop issue during 'cat' or 'copy' since Linux 6.14.0
> >
> > - 2) (don't know if it's related) the very high number of several bytes
> > TCP packets transmitted in SMB transaction (more than a hundred) for a
> > 5
> > bytes file transfert under Linux 6.13.8
> > According to your mount options and network traces, cat(1) is
> > attempting
> > to read 16M from 'toto' file, in which case netfslib will create 256
> > subrequests to handle 64K (rsize=3D65536) reads from 'toto' file.
> >
> > The first 64K read at offset 0 succeeds and server returns 5 bytes, the
> > client then sets NETFS_SREQ_HIT_EOF to indicate that this subrequest
> > hit
> > the EOF.  The next subrequests will still be processed by netfslib and
> > sent to the server, but they all fail with STATUS_END_OF_FILE.
> >
> > So, the problem is with short DIO reads in netfslib that are not being
> > handled correctly.  It is returning a fixed number of bytes read to
> > every read(2) call in your cat command, 16711680 bytes which is the
> > offset of last subrequest.  This will make cat(1) retry forever as
> > netfslib is failing to return the correct number of bytes read,
> > including EOF.
> >
> > While testing a potential fix, I also found other problems with DIO in
> > cifs.ko, so I'm working with Dave to get the proper fixes for both
> > netfslib and cifs.ko.
> >
> > I've noticed that you disabled caching with 'cache=3Dnone', is there an=
y
> > particular reason for that?
> >
> > Have you also set rsize, wsize and bsize mount options?  If so, why?
> >
> > If you want to keep 'cache=3Dnone', then a possible workaround for you
> > would be making rsize and wsize always greater than bsize.  The default
> > values (rsize=3D4194304,wsize=3D4194304,bsize=3D1048576) would do it.



--=20
Thanks,

Steve

