Return-Path: <linux-fsdevel+bounces-5084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA77807D5E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 01:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BF791F2185D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 00:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11508101E5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 00:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SPwGi2pt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48181D46
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 16:37:04 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-db544987c79so438695276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Dec 2023 16:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701909423; x=1702514223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ku2sfUBBqRmjOusEjPPKSg3scPnZYVUEi+HsErMF7+A=;
        b=SPwGi2ptt35RjW8bl6Bv3xg1CBoMWvUAhzx1qCZRYVa7VZCKadoKF/GnxnJRqH2j4s
         wfQy9jtUvON7V9UMtzbf2vCyDrKW8xbfDFzbHr4DS+Cdw5g8VaBYJXJJB9q0VDAjbkQM
         m5N3OYdKvUNzpkK0LHVKhEgiW3Ukdcv4vjNOunDGjJJAod/A+u22uJIp2LUdXxOXJn9j
         s0FBXXoEVtSIRUwT4Gapu14HiW+ppghz+GeWt6cVuINXlBrSNi1FOZPGRvm6xCEJEqTj
         KeWjzRYgaHQK4DJAVvrvts9I5a/QrQ7DZHbz2R5+P6K4QTjSM8TKesEoWhT2op4l6VG8
         Pyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701909423; x=1702514223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ku2sfUBBqRmjOusEjPPKSg3scPnZYVUEi+HsErMF7+A=;
        b=gzygpcl9F6UTK6uYEAGnhifozfYtGOKwz7bAcX7/N13FnOXTAeliE6eqm1NY7Pj9uU
         AioLeoNqhiiWFsW+R9CHH6kSxX1a+/ugpEgMo35/pyTQ790wA00FO+oeO5GRbe01Yv39
         /g1OYeg2kG6iELpdOVuQr3ZEISTgK3RYt99T1Ya8gQbDEP9vMs9pqYZmzj+c5d1rymke
         ADSEeSqg5KdZ4phcURQwGr5GzXwsjNR0Xd92k1GikgIaquQS0L+3UCbWt+BMlkRE/cDC
         mhtDHIpX9VKHeZVaqxzqmsAecUu3oyS997yLGaU3V6fmP3BXDTKf4tKpZOd4iHvNL1IZ
         suLA==
X-Gm-Message-State: AOJu0YzAYhpLSpkXNjGyOgrZ/HefdpWQMpNdUkwA207G43KWDkATdwQh
	aTLBUikCQHAOlIcGIhh3WK1VCi8Y+iYaRuywwWwS
X-Google-Smtp-Source: AGHT+IG1iYIFG177+3bvYtnhfemiCuwpFKgg3syUJq0tO2kQMOa+CZIi7OJOUpuM/HHKxu3GBd4bnBcpq+XxZYKLOIM=
X-Received: by 2002:a25:7714:0:b0:db7:8141:e65b with SMTP id
 s20-20020a257714000000b00db78141e65bmr1716451ybc.64.1701909423446; Wed, 06
 Dec 2023 16:37:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206060629.2827226-1-david@fromorbit.com> <20231206060629.2827226-6-david@fromorbit.com>
 <CAHC9VhTP3hRAkmp7wOKGrEzY5OXXJpnuofTG_+KdXDku18vkeA@mail.gmail.com> <ZXD+F5N/3PPSGTya@dread.disaster.area>
In-Reply-To: <ZXD+F5N/3PPSGTya@dread.disaster.area>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 6 Dec 2023 19:36:52 -0500
Message-ID: <CAHC9VhRNS=DvbL_sY5Vi+7twd3uV+WhACaaeJMsBUTYmhjxjVA@mail.gmail.com>
Subject: Re: [PATCH 05/11] selinux: use dlist for isec inode list
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-cachefs@redhat.com, dhowells@redhat.com, gfs2@lists.linux.dev, 
	dm-devel@lists.linux.dev, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 6:04=E2=80=AFPM Dave Chinner <david@fromorbit.com> w=
rote:
> On Wed, Dec 06, 2023 at 04:52:42PM -0500, Paul Moore wrote:
> > On Wed, Dec 6, 2023 at 1:07=E2=80=AFAM Dave Chinner <david@fromorbit.co=
m> wrote:
> > >
> > > From: Dave Chinner <dchinner@redhat.com>
> > >
> > > Because it's a horrible point of lock contention under heavily
> > > concurrent directory traversals...
> > >
> > >   - 12.14% d_instantiate
> > >      - 12.06% security_d_instantiate
> > >         - 12.13% selinux_d_instantiate
> > >            - 12.16% inode_doinit_with_dentry
> > >               - 15.45% _raw_spin_lock
> > >                  - do_raw_spin_lock
> > >                       14.68% __pv_queued_spin_lock_slowpath
> > >
> > >
> > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > ---
> > >  include/linux/dlock-list.h        |  9 ++++
> > >  security/selinux/hooks.c          | 72 +++++++++++++++--------------=
--
> > >  security/selinux/include/objsec.h |  6 +--
> > >  3 files changed, 47 insertions(+), 40 deletions(-)
> >
> > In the cover letter you talk about testing, but I didn't see any
> > mention of testing with SELinux enabled.  Given the lock contention
> > stats in the description above I'm going to assume you did test this
> > and pass along my ACK, but if you haven't tested the changes below
> > please do before sending this anywhere important.
>
> AFAIA, I've been testing with selinux enabled - I'm trying to run
> these tests in an environment as close to typical production systems
> as possible and that means selinux needs to be enabled.
>
> As such, all the fstests and perf testing has been done with selinux
> in permissive mode using "-o context=3Dsystem_u:object_r:root_t:s0" as
> the default context for the mount.
>
> I see this sort of thing in the profiles:
>
> - 87.13% path_lookupat
>    - 86.46% walk_component
>       - 84.20% lookup_slow
>          - 84.05% __lookup_slow
>             - 80.81% xfs_vn_lookup
>                - 77.84% xfs_lookup
> ....
>                - 2.91% d_splice_alias
>                   - 1.52% security_d_instantiate
>                      - 1.50% selinux_d_instantiate
>                         - 1.47% inode_doinit_with_dentry
>                            - 0.83% inode_doinit_use_xattr
>                                 0.52% __vfs_getxattr
>
> Which tells me that selinux is definitely doing -something- on every
> inode being instantiated, so I'm pretty sure the security and
> selinux paths are getting exercised...

That's great, thanks for the confirmation.  FWIW, for these patches it
doesn't really matter if the system is in enforcing or permissive
mode, or what label you use, the important bit is that you've got a
system with SELinux enabled in the kernel and you have a reasonable
policy loaded.

--=20
paul-moore.com

