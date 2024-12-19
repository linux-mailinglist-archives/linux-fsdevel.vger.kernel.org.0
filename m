Return-Path: <linux-fsdevel+bounces-37770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B729F7134
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 01:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972BA1893E98
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 00:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936C52594;
	Thu, 19 Dec 2024 00:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="hkiJAlp9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A15479C0
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 00:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734566834; cv=none; b=dcsjHCu5bJh/7ht4bsViTeIBS/U6TBN/KqNBDeNP5z/Q9MYIJRahkaO/xyPyaxXT1ps3QhXfmZ4icZocCpvDrmu+auvDNj1c67k+qgmMyJTSdas7tmZ20tY7hmSHD8aPahv7Wy9ANVLY9NoocUOS/IzwFPtVhbR6X+5IOPWXR7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734566834; c=relaxed/simple;
	bh=WZjFe8wKOL9HwNoK06l8XbFhX7n71sn4plvP9/2iTjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WIHnJOgPO6E8ruAoxoQwBHC2rpYcitvsAUuRy8M1G/DFeG5laHGTNE8chUN+zn9PsuU0GpYGdfLKZxn8LF70BuszYDWTO+nLs/iF794NGN1c9efXqT5PJhEim9oC1UsK6xYbx66AMg+CCNxOWpEScdI8bhyRe5xXSO5MeNJLAhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=hkiJAlp9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2163b0c09afso2377715ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 16:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1734566832; x=1735171632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52jSfl4KCvUw98t3zaToufia/m4p+sDIn4ah9oFu/mE=;
        b=hkiJAlp9OSd+0qqWJGJE5AC1z6HxX8AEf4HJJvo/nZstoJnYL8C7fX9f6N1mvZnZT+
         xxYVNS7/lX0qr/BKr5+KXFVCkJYyryz7tFLLT4PNvm73kBzz1JQNoPrwLKCU/TDO5y5F
         9lWXabqUK2vYxF1CRnBogYYekwGnzunXH4ZwOCSzGw4IltjbEpiKyxcu3077C+FFT+F0
         dNqO1dIN87Ozp90+W1dbR07BDK6dTao7q0M/t7Y5cVVuCcEnILmeWCC5bUtedIx5exGi
         71A1Nqn0rs/zyy6UHRh3Rx08ICbvXuPpnfz8RFOs4o3xEL6+zj2vemqMJnmk/1u+cZdd
         kgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734566832; x=1735171632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52jSfl4KCvUw98t3zaToufia/m4p+sDIn4ah9oFu/mE=;
        b=M2ie4Jwxw825N/j82wouj7YISRlvSJsoOg8fXsBcQQFnHbFrWWGl+vZZhz1q01Z9d2
         SnT7/+dWAOFKLzsK914g4bsmQ11t0ybclP206aDAB0RlBrb3PXZZi0FIGOA+MgXgRkvi
         GEd0x57jcuc6QuqU4ozTCUd28bqJYQhsOkjtoQxuXmnLu50ytA9xSs3ua1elUMbGBkFm
         EfObZSebvTucOSUMHjyqPGVrBnGlacDeZQ1tMM6qXX1WnFDBJrCttqYqwfWZ2IvL432X
         aLFCjM5Y6VTftZ21+CN+La3Req/yMrSrMSjIHLIX0sOBptlBKi+iAp6b0kcdaRPshiSK
         XGuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6hpmdwtfaaA4uZZQqsHAGB33GKVumVF6EnzB1hPkkOH/QJT68HVnGfv68PNmVSU53vekzCMX4kT9FQdEN@vger.kernel.org
X-Gm-Message-State: AOJu0YyfsEz1YEY338fMmB57kQhCXrrzr4fIg9nOfzlxjLguGU6ArItB
	Gtl6DebNc/MVwnY5xu3NhcRK/bzIPcMHLI6b3ijnJU80XpJllyxVmim54W4NWxhLXH8eRnPevWm
	UJU6WP+adJiUlJo20qjSPsnuxCx9yOJDRXUVW
X-Gm-Gg: ASbGncselpokAVPQOEXPn/Ip+yFWa3LIJHU1hy8v3TlSdcA6zpSr6QSJaZvxgDxBmlU
	W0gAaAMvYYPKTBAIFGHYrI7Hr247WEJ3Z5tWzpG0=
X-Google-Smtp-Source: AGHT+IH27pDcSlJ/F9QtGxlBr64hIGr8CjwP89Du+IuSyaexLxIUAC6fi4ZA+ID+3TD8nm0/w2mtVIk8rsxRiigAxtg=
X-Received: by 2002:a17:90b:5202:b0:2ee:d63f:d8f with SMTP id
 98e67ed59e1d1-2f2e91efcb5mr6521474a91.13.1734566832471; Wed, 18 Dec 2024
 16:07:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGrbwDTLt6drB9eaUagnQVgdPBmhLfqqxAf3F+Juqy_o6oP8uw@mail.gmail.com>
 <CAOQ4uxibFVCGBEORDHjUuB_b6ELq8NdGaNv+Srz9rzQAdh=4OQ@mail.gmail.com> <CAOQ4uxiie81voLZZi2zXS1BziXZCM24nXqPAxbu8kxXCUWdwOg@mail.gmail.com>
In-Reply-To: <CAOQ4uxiie81voLZZi2zXS1BziXZCM24nXqPAxbu8kxXCUWdwOg@mail.gmail.com>
From: Dmitry Safonov <dima@arista.com>
Date: Thu, 19 Dec 2024 00:07:01 +0000
Message-ID: <CAGrbwDQUVEEh4wYDEuRaZvBDAzjn41h2DZLNzHYRAXKCJnaEkg@mail.gmail.com>
Subject: Re: overlayfs: WARN_ONCE(Can't encode file handler for inotify: 255)
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, 
	Sahil Gupta <s.gupta@arista.com>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Amir for all the detailed information,

On Wed, Dec 18, 2024 at 4:26=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Wed, Dec 18, 2024 at 1:10=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Wed, Dec 18, 2024 at 1:23=E2=80=AFAM Dmitry Safonov <dima@arista.com=
> wrote:
[..]
> > However, I am concerned about the possibility of exportfs_encode_fid()
> > failing in fanotify_encode_fh().
> >
> > Most fsnotify events are generated with a reference on the dentry, but
> > fsnotify_inoderemove() is called from dentry_unlink_inode() after remov=
ing
> > the dentry from the inode aliases list, so does that mean that FAN_DELE=
TE_SELF
> > events from overlayfs are never reported with fid info and that we will
> > always print pr_warn_ratelimited("fanotify: failed to encode fid ("...?
> >
> > I see that the LTP test to cover overlayfs fid events reporting (fanoti=
fy13)
> > does not cover FAN_DELETE_SELF events, so I need to go check.
>
> As predicted, I added a test case for FAN_DELETE_SELF over overlayfs
> and it fails
> to get the file handle of the deleted inode:
>
> https://github.com/amir73il/ltp/commits/ovl_encode_fid/
>
> fanotify13.c:174: TINFO: Test #6.4: FAN_REPORT_FID of delete events
> with mark type FAN_MARK_INODE
> [ 2967.311260] fanotify_encode_fh: 23 callbacks suppressed
> [ 2967.311276] fanotify: failed to encode fid (type=3D0, len=3D0, err=3D-=
2)
> [ 2967.317410] fanotify: failed to encode fid (type=3D0, len=3D0, err=3D-=
2)
> [ 2967.320933] fanotify: failed to encode fid (type=3D0, len=3D0, err=3D-=
2)
> fanotify13.c:268: TFAIL: handle_bytes (0) returned in event does not
> equal to handle_bytes (24) returned in name_to_handle_at(2)
> fanotify13.c:268: TFAIL: handle_bytes (0) returned in event does not
> equal to handle_bytes (24) returned in name_to_handle_at(2)
> fanotify13.c:268: TFAIL: handle_bytes (180003) returned in event does
> not equal to handle_bytes (24) returned in name_to_handle_at(2)
>
> Note that this is not a regression, because FAN_REPORT_FID was not suppor=
ted on
> overlayfs before 16aac5ad1fa9 ("ovl: support encoding non-decodable
> file handles"),
> so I do plan to fix ovl_dentry_to_fid(), but with the holidays coming
> up, it could take
> more time than usual.

This sounds good to me, there is no urgency in fixing it for us, we're
going to keep the revert in the kernel until there is a fix.

> If you have an urgency to fix the reported WARN_ONCE(), then do feel free
> to post a patch to remove this assertion, because my fix to ovl_dentry_to=
_fid()
> may be simplified to deal only with unlinked inodes, so it may not be eno=
ugh
> fix the use case that you reported.

I mostly wanted to make sure this issue is a known one, as WARN*()s
are considered actual issues with the code, rather than just warnings
to the user (and they leak kernel addresses). So, probably it's worth
fixing somewhere during the release. Also the report could save
someone elses time, who may observe the same issue.

Thanks again Amir,
            Dmitry

