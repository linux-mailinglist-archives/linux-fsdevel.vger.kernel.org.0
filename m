Return-Path: <linux-fsdevel+bounces-37739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 917689F6B10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 17:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA8B163D33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 16:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049C31F5402;
	Wed, 18 Dec 2024 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSIS9Vx9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21F019D072;
	Wed, 18 Dec 2024 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734539190; cv=none; b=dIxnczX6kLKh3of1Pnda/Kyiw3aV69ghI3lrAGpWHQVQYZtB/fDUd8mOLlXuoGByYoQNMCYya1SnUJ7MW//yEVay9QUhsNJqa4Z5U9s0jgaRgcIphHjJRumGT2sYbApSULSqJzaQgDszdZoVJZCirnaRdcVuhsFJFrXLg6mAZKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734539190; c=relaxed/simple;
	bh=CH7HnXa+fuTs69+yycFd560LN3YLcatymBkxHovHDzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUy12wP/Jebz+pJTYGRjJtx3x8o1iXuWcwoxWXKZx8WJIvQM1WW+ZcwLHAPj0ykfpnNmgiJ9Soe/qslLzcxT9a6yD2XurJZEkP4VXb/fT0uAH7Gf1gte87BQTP+UD2kJfDCq/OVGRuQOTFj5rkJcSkWiMFpJ1/o1rc8ydP1dGSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSIS9Vx9; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d647d5df90so8367303a12.2;
        Wed, 18 Dec 2024 08:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734539187; x=1735143987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pmkt9XDQJzvMw0Pxsg6vMsTVZCgPm6T/hzLgsnUP44E=;
        b=jSIS9Vx9OEAgkRbSaqCHSCfGovbfsQnNb0bFbryS8dezlziHrt1ybZdhixJlspEuTF
         a3ND2PZFNLlQ2rXo1fs/xQD0mBeIafu1xjl7HzgHnY/rVgOJT799L9I2mLhQyYFdbazt
         hXcr/Nrlg3HCpj+e2e07UkVW6P3ZQVXw0Q304e/OTHRxbLdDnDLifMeNhAPfHi9DYopI
         S8RDfR7JUIXGmQFDttsQqJO8hmGXFI1y3X+o43D3ILJ3wX5kfmS/+n8OvMzaLfRXJraW
         DuWHelF8Aawn9l0nIxVzujLtNBHPd7grYa5SsFYR7+2s3K/bubBeE/t+zq4xOvkefu36
         FoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734539187; x=1735143987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pmkt9XDQJzvMw0Pxsg6vMsTVZCgPm6T/hzLgsnUP44E=;
        b=Wo4YPipODgWXnxrSrkQyYasAvEmCgnWHJU0cIf/TlNtfZ1adqzYsyEp0g5afEeq/93
         qyHrdfnEFCM3YliodOxgRrvipLUnOySIOCS57iKPm/oyvhbEmvzZQ1c6F6vFjxa+nW4M
         zBT2E+HijKtc0C6XSR4oUy8jT8RQHOgBbOpJlRm2z2iNcpM4f2QsIO/QUTzD61ZOHTtN
         UzH1jx7BLLIq908xH9Gz3kHkss57ljS7RMVp/eL+sf9Uoo4ShUXGSy/enVQ9mVJoGdQH
         zeMFzHfwrDLfanSvjbTsy6c74cDeUGzCMsJdmbM9O3sJj6S71EjR1wh30iYt8bMHqNNj
         8L+w==
X-Forwarded-Encrypted: i=1; AJvYcCVd6N2hYqsUVPqvtAH70scQH0yZVt0WBlLooQ5/GHzsiVbSGG40PVqcV6InGlRTHliLiJ9YiCalqeY+e2AL@vger.kernel.org, AJvYcCWudrbgk/JJ2llZ3C+3yjUZfaZpAvFtlOIdcXL0rVph2BjkTnJR8WAhRHh4LhHWjGsvX+1ep1y98FVPCIoI@vger.kernel.org, AJvYcCXBj+u+jpn1iXAKUo7f4ZqdGDQbJnnPwKyfyz8y0JaSaK7dm+/YzotPiqUp+pdLXBvBBfREMaXExAj7HpgTNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQfMxZ/KDcYsOgrEwLX+IeeSM1eoKJgE38CeK5pWNwPIwVHo/R
	M7z+49Q0d8emmtgjStmhaMI9ZSGxM3PkBBbw8Z9dJzsLvcozFzjVbmyN7lgGt8Ql8+iwpfDIs87
	W3y9cdHaZmMjAZC/nneyQW6gshElb0WG6ncw=
X-Gm-Gg: ASbGncvhWmsV5lHKAvzbFKPfxYvjVZcCIslMjQf64zv6s6h1Lc7fUO3ffFM1VUtQJxR
	V7GLTYzuGc/YZ22/EqgHhpYNwrjvIL98vn/8FDQ==
X-Google-Smtp-Source: AGHT+IESnxrG6R404Jw5OAKvVosjGdfsoo4IrN4TWS4lh187CtuM2wH4crULNRmul7lyoU5qQnfFbG2HzlF4afI/DMU=
X-Received: by 2002:a05:6402:530e:b0:5d3:cdb3:a60 with SMTP id
 4fb4d7f45d1cf-5d7ee4269d2mr3350074a12.34.1734539186587; Wed, 18 Dec 2024
 08:26:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGrbwDTLt6drB9eaUagnQVgdPBmhLfqqxAf3F+Juqy_o6oP8uw@mail.gmail.com>
 <CAOQ4uxibFVCGBEORDHjUuB_b6ELq8NdGaNv+Srz9rzQAdh=4OQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxibFVCGBEORDHjUuB_b6ELq8NdGaNv+Srz9rzQAdh=4OQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 18 Dec 2024 17:26:14 +0100
Message-ID: <CAOQ4uxiie81voLZZi2zXS1BziXZCM24nXqPAxbu8kxXCUWdwOg@mail.gmail.com>
Subject: Re: overlayfs: WARN_ONCE(Can't encode file handler for inotify: 255)
To: Dmitry Safonov <dima@arista.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, 
	Sahil Gupta <s.gupta@arista.com>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 1:10=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Wed, Dec 18, 2024 at 1:23=E2=80=AFAM Dmitry Safonov <dima@arista.com> =
wrote:
> >
> > Hi Amir and Miklos, linux-unionfs,
> >
> > On v6.9.0 kernel we stepped over the WARN_ON() in show_mark_fhandle():
> >
> > > ------------[ cut here ]------------
> > > Can't encode file handler for inotify: 255
> > > WARNING: CPU: 0 PID: 11136 at fs/notify/fdinfo.c:55 show_mark_fhandle=
+0xfa/0x110
> > > CPU: 0 PID: 11136 Comm: lsof Kdump: loaded Tainted: P        W  O    =
   6.9.0 #1
> > > RIP: 0010:show_mark_fhandle+0xfa/0x110
> > > Code: 00 00 00 5b 41 5c 5d e9 44 21 97 00 80 3d 0d af 99 01 00 75 d8 =
89 ce 48 c7 c7 68 ad 4a 82 c6 05 fb ae 99 01 01 e8 f6 98 cc ff <0f> 0b eb b=
f e8 4d        29 96 00 66 66 2e 0f 1f 84 00 00 00 00 00 66 90
> > ...
> > > Call Trace:
> > >  <TASK>
> > >  inotify_show_fdinfo+0x124/0x170
> > >  seq_show+0x188/0x1f0
> > >  seq_read_iter+0x115/0x4a0
> > >  seq_read+0xf9/0x130
> > >  vfs_read+0xb6/0x330
> > >  ksys_read+0x6b/0xf0
> > >  __do_fast_syscall_32+0x80/0x110
> > >  do_fast_syscall_32+0x37/0x80
> > >  entry_SYSCALL_compat_after_hwframe+0x75/0x75
> > > RIP: 0023:0xf7f93569
> >
> > it later reproduced on v6.12.0. With some debug, it was narrowed down
> > to the way overlayfs encodes file handlers in ovl_encode_fh(). It
> > seems that currently it calculates them with the help of dentries.
> > Straight away from that, the reproducer becomes an easy drop_caches +
> > lsof (which parses procfs and finds some pid(s) that utilize inotify,
> > reading their correspondent fdinfo(s)).
> >
> > So, my questions are: is a dentry actually needed for
> > ovl_dentry_to_fid()? Can't it just encode fh based on an inode? It
> > seems that the only reason it "needs" a dentry is to find the origin
> > layer in ovl_check_encode_origin(), is it so?
>
...

> However, I am concerned about the possibility of exportfs_encode_fid()
> failing in fanotify_encode_fh().
>
> Most fsnotify events are generated with a reference on the dentry, but
> fsnotify_inoderemove() is called from dentry_unlink_inode() after removin=
g
> the dentry from the inode aliases list, so does that mean that FAN_DELETE=
_SELF
> events from overlayfs are never reported with fid info and that we will
> always print pr_warn_ratelimited("fanotify: failed to encode fid ("...?
>
> I see that the LTP test to cover overlayfs fid events reporting (fanotify=
13)
> does not cover FAN_DELETE_SELF events, so I need to go check.

As predicted, I added a test case for FAN_DELETE_SELF over overlayfs
and it fails
to get the file handle of the deleted inode:

https://github.com/amir73il/ltp/commits/ovl_encode_fid/

fanotify13.c:174: TINFO: Test #6.4: FAN_REPORT_FID of delete events
with mark type FAN_MARK_INODE
[ 2967.311260] fanotify_encode_fh: 23 callbacks suppressed
[ 2967.311276] fanotify: failed to encode fid (type=3D0, len=3D0, err=3D-2)
[ 2967.317410] fanotify: failed to encode fid (type=3D0, len=3D0, err=3D-2)
[ 2967.320933] fanotify: failed to encode fid (type=3D0, len=3D0, err=3D-2)
fanotify13.c:268: TFAIL: handle_bytes (0) returned in event does not
equal to handle_bytes (24) returned in name_to_handle_at(2)
fanotify13.c:268: TFAIL: handle_bytes (0) returned in event does not
equal to handle_bytes (24) returned in name_to_handle_at(2)
fanotify13.c:268: TFAIL: handle_bytes (180003) returned in event does
not equal to handle_bytes (24) returned in name_to_handle_at(2)

Note that this is not a regression, because FAN_REPORT_FID was not supporte=
d on
overlayfs before 16aac5ad1fa9 ("ovl: support encoding non-decodable
file handles"),
so I do plan to fix ovl_dentry_to_fid(), but with the holidays coming
up, it could take
more time than usual.

If you have an urgency to fix the reported WARN_ONCE(), then do feel free
to post a patch to remove this assertion, because my fix to ovl_dentry_to_f=
id()
may be simplified to deal only with unlinked inodes, so it may not be enoug=
h
fix the use case that you reported.

Thanks,
Amir.

