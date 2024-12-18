Return-Path: <linux-fsdevel+bounces-37729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB449F6595
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 13:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91021889A5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 12:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AFB1A23A2;
	Wed, 18 Dec 2024 12:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZXJGf3X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A445C15957D;
	Wed, 18 Dec 2024 12:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734523856; cv=none; b=kR/M7pagZeaOPvk5elB/82i83O2LO1PvGdqi47MKv6tfpkXPAZx7dxpbqzKeXvNgRaDIhyjdeiIXeZBdf/DNBxITbPIlw6+lSAe2+uOhacoUJt3iez8HDMB+Pn+aksVd7i16O6hgygC28+WZkGdAAqArCf/odmIQAOXxaPt/dn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734523856; c=relaxed/simple;
	bh=/VoEdV5r+ipXC2QmuDJ9T0Csb1PK9jT6vaRBqIwreC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ol0dr9qgMAQ3CCH8FXR0oDPzhUxJjK4MUg4TsUx2WMko7d1N+D0Evi3TX47IInEd7NVsOqGUm7OavKWlOYYlM6tInyD45nlsT7U9QceuRNi3kximjEDl2Hq92rKTRaw4R2QUTb3XRSNqaZjRTSe0gx6cHOapTQ6L/lTbCfW7RrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZXJGf3X; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3d14336f0so11477603a12.3;
        Wed, 18 Dec 2024 04:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734523853; x=1735128653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siD3G0ch51dvu8IMIC2cJn51PlRpF/Q4CtWOS78eMuI=;
        b=LZXJGf3XRLFnenyoOcgrDnAquE0aFhAF+SmGKysUu9koXOfmPfl5EDEULcmoUdnutP
         nWSfz7va4bB67FlXAZdF4hh1y6KrOGgeHmM9YfaGsNDBAabMc5pUXU5v5Ni/L/wRfJgo
         dpbsm9XWclZ6uWXKlwIpg6EPfhRTrHP+oYMALnzTyceeqO+zSNyuPwVylybgUy8k19GH
         Se88o6YnyGE3z8OL9EmmYUKM2z3cdHjUAfJodrT2z3xpJt7maxhuWMH73+sNofWFWPJ6
         xse3eAK4dHG6TAIJmOhZVDRBHWyoRlxh53ZZYNKyjyDUNTvXfnydcY/3PUkIriUNVCsK
         /dsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734523853; x=1735128653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=siD3G0ch51dvu8IMIC2cJn51PlRpF/Q4CtWOS78eMuI=;
        b=YSESPs0o2E/Z9y6jR54ynAbaTYVRQrdyTsuFdeOvK079Yqpg0BCGPBfrxEo5J3HFON
         IoEl7ppRpkzOrGf7crq2jPxfe6TygG8/ZvtnUhaRR/eochP6q3KdJKRw1bP2MtBeW4Zy
         XkPjmYJCajM3HOP368cre0mItHCsI7uSmGjft9wAGmP/Z1bO1gnyoeKuPNF+KV7UAeVI
         tCSMcjGtK0DEi2sVAFZVlQteKB2vNZToqXVyBU5xTqbm9MZFdEbDdfNm4z+gJEK5y9Va
         lhTBU7dKw9CTQxuoAtVoUpMo+U5cxHQqanj/8l20Yxlgyj0xPvh9mHWd4rhPibjIul3c
         L3YA==
X-Forwarded-Encrypted: i=1; AJvYcCUI3k47n7Pz2XKRaTTrm2lLibHVkDmTY+BtA2M2D5rhh9TllV0ANiRrrsGjiCg54+U6oWa9G8dDndKnBrlq@vger.kernel.org, AJvYcCWFO/DGRTvZoqngOvFM3dxE1dWrDIAXIm2w99MFDlPsdMoLaS2TihhUQOBr8HbnPGDEfzK3wGjYNp1OJ91i@vger.kernel.org, AJvYcCWfgNaNJ3q/qS+JqwTymsHVEKn5a+Vy3vzRJv8JzcsdeE0Ks5NgNkn79bUAUmmhE8CMydhqB83VWjPTTrS6dQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYxUaBjP9Po2ZzOW5iHWqXZQ1y79b9hjoBnn1X1ucFZSt0phsz
	2ZH7boM+uPVBa9AvxOt64XysKZ7IXbn1+f9+LPZkw2ts2uH8pBsATdGIdzJMGs7LpJfT7bHeOVr
	u3DQTa6mmBoHjSHdKLdm5SeeTDj8=
X-Gm-Gg: ASbGncuGqbX2aF6Rxemaim+iK+PWgr3rP6jrhFexd4TzDrQvY7pkPozAJRkHoDlkmYN
	S0O2RqxcWWAZ/msH6QqIRcuSoTSm64rFL4Ed2eQ==
X-Google-Smtp-Source: AGHT+IG7k4myzCPg6xyuiYLPFg9srq5FRV05gKiCo25fZp9FOW7Sa1xqYcw9LDRboDMURojNuMVjWMtREMNVl5UtVh4=
X-Received: by 2002:a05:6402:51c6:b0:5d0:d9e6:fea1 with SMTP id
 4fb4d7f45d1cf-5d7ee3b4004mr2068922a12.19.1734523852351; Wed, 18 Dec 2024
 04:10:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGrbwDTLt6drB9eaUagnQVgdPBmhLfqqxAf3F+Juqy_o6oP8uw@mail.gmail.com>
In-Reply-To: <CAGrbwDTLt6drB9eaUagnQVgdPBmhLfqqxAf3F+Juqy_o6oP8uw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 18 Dec 2024 13:10:41 +0100
Message-ID: <CAOQ4uxibFVCGBEORDHjUuB_b6ELq8NdGaNv+Srz9rzQAdh=4OQ@mail.gmail.com>
Subject: Re: overlayfs: WARN_ONCE(Can't encode file handler for inotify: 255)
To: Dmitry Safonov <dima@arista.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, 
	Sahil Gupta <s.gupta@arista.com>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 1:23=E2=80=AFAM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> Hi Amir and Miklos, linux-unionfs,
>
> On v6.9.0 kernel we stepped over the WARN_ON() in show_mark_fhandle():
>
> > ------------[ cut here ]------------
> > Can't encode file handler for inotify: 255
> > WARNING: CPU: 0 PID: 11136 at fs/notify/fdinfo.c:55 show_mark_fhandle+0=
xfa/0x110
> > CPU: 0 PID: 11136 Comm: lsof Kdump: loaded Tainted: P        W  O      =
 6.9.0 #1
> > RIP: 0010:show_mark_fhandle+0xfa/0x110
> > Code: 00 00 00 5b 41 5c 5d e9 44 21 97 00 80 3d 0d af 99 01 00 75 d8 89=
 ce 48 c7 c7 68 ad 4a 82 c6 05 fb ae 99 01 01 e8 f6 98 cc ff <0f> 0b eb bf =
e8 4d        29 96 00 66 66 2e 0f 1f 84 00 00 00 00 00 66 90
> ...
> > Call Trace:
> >  <TASK>
> >  inotify_show_fdinfo+0x124/0x170
> >  seq_show+0x188/0x1f0
> >  seq_read_iter+0x115/0x4a0
> >  seq_read+0xf9/0x130
> >  vfs_read+0xb6/0x330
> >  ksys_read+0x6b/0xf0
> >  __do_fast_syscall_32+0x80/0x110
> >  do_fast_syscall_32+0x37/0x80
> >  entry_SYSCALL_compat_after_hwframe+0x75/0x75
> > RIP: 0023:0xf7f93569
>
> it later reproduced on v6.12.0. With some debug, it was narrowed down
> to the way overlayfs encodes file handlers in ovl_encode_fh(). It
> seems that currently it calculates them with the help of dentries.
> Straight away from that, the reproducer becomes an easy drop_caches +
> lsof (which parses procfs and finds some pid(s) that utilize inotify,
> reading their correspondent fdinfo(s)).
>
> So, my questions are: is a dentry actually needed for
> ovl_dentry_to_fid()? Can't it just encode fh based on an inode? It
> seems that the only reason it "needs" a dentry is to find the origin
> layer in ovl_check_encode_origin(), is it so?

Well, the answer depends on the overlayfs export operations or on:
        bool decodable =3D ofs->config.nfs_export;

For decodable directory file handles, a dentry is surely needed for
ovl_connect_layer(), but this is not the common case, so the short answer i=
s
Yes, ovl_dentry_to_fid() could encode fh based on the inode, but it
will need some helpers refactoring as you can see and the question is
"Is it worth the effort?"

>
> I guess, the potential solution here would be either to populate the
> dentry back (likely racy and ugh) or just encode file handles based on
> the lower-inode? IIUC, old file handles will become stale anyway after
> dropping the caches?

They will not become stale.
file handles are usually persistent unless the underlying fs is volatile
by nature like tmpfs.

>
> As a rare visitor to fs code, not sure I described the problem or
> understood it well enough.

You understood the problem and explained it perfectly, only
we also need to ask why is show_mark_fhandle() needed and
what is the assertion for?

Because there is one more simple solution -
Remove the WARN_ONCE assertion from show_mark_fhandle().

AFAIK, show_mark_fhandle() was originally added so that CRIU
could restore inotify marks after resume, but if file handles are not decod=
able
(i.e. !exportfs_can_encode_fh()), then are useless to userspace, so perhaps
the assertion is not needed?

IOW, I am not so worried about show_mark_fhandle().
However, I am concerned about the possibility of exportfs_encode_fid()
failing in fanotify_encode_fh().

Most fsnotify events are generated with a reference on the dentry, but
fsnotify_inoderemove() is called from dentry_unlink_inode() after removing
the dentry from the inode aliases list, so does that mean that FAN_DELETE_S=
ELF
events from overlayfs are never reported with fid info and that we will
always print pr_warn_ratelimited("fanotify: failed to encode fid ("...?

I see that the LTP test to cover overlayfs fid events reporting (fanotify13=
)
does not cover FAN_DELETE_SELF events, so I need to go check.

Thanks,
Amir.

