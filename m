Return-Path: <linux-fsdevel+bounces-61044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6D5B54B3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 13:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 841267BBBDB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 11:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D43301028;
	Fri, 12 Sep 2025 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHxWUjLp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330CC21A457
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757677295; cv=none; b=Jac5cAzE83lK1kscZB4RxhclAmoB3GGwhAGQE4U/v/9vfCrRvXBFMDMBvcUr7TooxuJkVx/+h3zfY9PPPmb1O2y0uBBPdnhwc57JFbgzE85nFH1MdBYpM6qYvIR8FGGLsw9Atqo14aQfjcK7Rj+ISbyejc3oXx5f0iLPvoX/7ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757677295; c=relaxed/simple;
	bh=qubTz5NccQylmMb5eGhEQxlCqsEwtuA4w4VK8zXpUhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZ4cyEH4NzKlhU6xp/NGBSQ6Nlcpub1DD/mBjIaIa2edYG/y8/mfUAz7I6aO/BUbeAX91B44yRAO59vxysQd596EMTOhSqMn2DDQvSZnGU6vt2+KxnE7oo3YAQPQY6ZQ0RcUp300Rb0O3okKqJtqphVKcpBc3XpwtkGUL+YpsdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHxWUjLp; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad681so2543157a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 04:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757677291; x=1758282091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhHoQcsUdIg61AwKHb7zq+yf4BOBAwDoM26hBqxnzm0=;
        b=KHxWUjLp3RlkqJpznurnNxsm0jPRUNVwhha0KpRvI7WrQO3368sFvpadgoTXlWf8TJ
         VjahfasgMSRR//hYxf072pCgn3SZuoH3EHVOGUkUVqMis4sou+BSSGEU7QAs1+TnX9kh
         DlEpsrtaSk/WUO8wyc5SiFlArdbchiAsP1Zl8oGpkSQBB0tKTJoRFkU6CR4UAeT0N6F7
         EnzIcEcc8yZLlez/2xbFqnKDrrpfCeCmO9mWbdM6fR24xXmqxB9RkypSi5tUt9+saJMR
         VqvJJhm0tdDfP8e5yTaurk9kr5Sejp7GwVO+sEqkhzGKJnBcDyk5pxjPwmm1XMp0eG03
         5g0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757677291; x=1758282091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhHoQcsUdIg61AwKHb7zq+yf4BOBAwDoM26hBqxnzm0=;
        b=XVx5WdPKxxXi9mhbXMO191PVAhJTHS3l2fiH+hNaYf49DioiHBOtcclMEJD6HJC5D2
         M1KjAhYHWahOQGpd2WGt5ZlemS2CvU7LQE4EjPeaDuh9S+rdDHJJwZCwxBLGb6X4DV6K
         GydhO7Z+d21Y3acwJ1gtjv6TRVrtuFDoqK4fl6m6q8OTyKookztaQ/dzMcDHiYUfUzpR
         bob6yrC1tZOf/eTCLyxLPw7GniYDVyx8weLWow1U/zCsJAKHMggXTqPKBQfRxC919FP7
         2nanz8EeJcbVHM0ayGQbTwHzCQhQj+8+hZEtcqxSTNmQfbfvdUjmsFRBDqE6rbvbXUTw
         Q+9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9O9AwFMO05N1TAY8D9GgnlTNb/v9O4+UGPJscX7IjjGWx1FXkjXhZA4EHNlm3uaMvF/b69uOOPmxfQfYG@vger.kernel.org
X-Gm-Message-State: AOJu0YypITcTwBaSd2CbmDGQHR96Og6kbTu/cpR4/EuHbxOSEYlwrjO2
	q+3rTIQcRk4yuxp/AFP8CVX/zHIS+z/pEf2FIyDEBv8TK/7CR02y2qWhIkFKQR5AHGoord2T/Cm
	HGWBhRLPmmPzyXf+pGlRD/oybK76VhUI=
X-Gm-Gg: ASbGncsE7VSY9Scvhrz4Iv5fq/N7JdTpT4of9QkKKCQIZTHGSfLTl8pzhHbmSbo9CZn
	ir7c5BHvXLJ6ck0znV7ay77qo2WpUYzAwHQOBQPOUCKJsVX6hQ/TPqwgjkJMnziYgRkf1Td2SO+
	2+UVB54IQTtR0TGwBJMI9QDi419w/Me5wo3BOmowML3ZLReq7uwmjqtarobyeho/pk59wwBWj3X
	kghkJplteWnvf4BOQ==
X-Google-Smtp-Source: AGHT+IFCX157Ka/Iz69jCoqTNuyf01bBoVnyqpL5tf/MmTv7L1D4o9MBDY6xT7cl3eRR3U0HJheMV5AGQH0ph9VTL4s=
X-Received: by 2002:a05:6402:44d2:b0:62c:75bf:651f with SMTP id
 4fb4d7f45d1cf-62ed81ff6f2mr2490531a12.7.1757677291315; Fri, 12 Sep 2025
 04:41:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8734afp0ct.fsf@igalia.com> <20250729233854.GV2672029@frogsfrogsfrogs>
 <20250731130458.GE273706@mit.edu> <20250731173858.GE2672029@frogsfrogsfrogs>
 <8734abgxfl.fsf@igalia.com> <39818613-c10b-4ed2-b596-23b70c749af1@bsbernd.com>
In-Reply-To: <39818613-c10b-4ed2-b596-23b70c749af1@bsbernd.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 12 Sep 2025 13:41:20 +0200
X-Gm-Features: Ac12FXyfcx1I1A6DzNI7vt2tGVPYgJjPcG1Xvt4gHuNmpuaiHvH8En0aZLVYcic
Message-ID: <CAOQ4uxg1zXPTB1_pFB=hyqjAGjk=AC34qP1k9C043otxcwqJGg@mail.gmail.com>
Subject: Re: [RFC] Another take at restarting FUSE servers
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Luis Henriques <luis@igalia.com>, "Darrick J. Wong" <djwong@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kevin Chen <kchen@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 12:31=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com>=
 wrote:
>
>
>
> On 8/1/25 12:15, Luis Henriques wrote:
> > On Thu, Jul 31 2025, Darrick J. Wong wrote:
> >
> >> On Thu, Jul 31, 2025 at 09:04:58AM -0400, Theodore Ts'o wrote:
> >>> On Tue, Jul 29, 2025 at 04:38:54PM -0700, Darrick J. Wong wrote:
> >>>>
> >>>> Just speaking for fuse2fs here -- that would be kinda nifty if libfu=
se
> >>>> could restart itself.  It's unclear if doing so will actually enable=
 us
> >>>> to clear the condition that caused the failure in the first place, b=
ut I
> >>>> suppose fuse2fs /does/ have e2fsck -fy at hand.  So maybe restarts
> >>>> aren't totally crazy.
> >>>
> >>> I'm trying to understand what the failure scenario is here.  Is this
> >>> if the userspace fuse server (i.e., fuse2fs) has crashed?  If so, wha=
t
> >>> is supposed to happen with respect to open files, metadata and data
> >>> modifications which were in transit, etc.?  Sure, fuse2fs could run
> >>> e2fsck -fy, but if there are dirty inode on the system, that's going
> >>> potentally to be out of sync, right?
> >>>
> >>> What are the recovery semantics that we hope to be able to provide?
> >>
> >> <echoing what we said on the ext4 call this morning>
> >>
> >> With iomap, most of the dirty state is in the kernel, so I think the n=
ew
> >> fuse2fs instance would poke the kernel with FUSE_NOTIFY_RESTARTED, whi=
ch
> >> would initiate GETATTR requests on all the cached inodes to validate
> >> that they still exist; and then resend all the unacknowledged requests
> >> that were pending at the time.  It might be the case that you have to
> >> that in the reverse order; I only know enough about the design of fuse
> >> to suspect that to be true.
> >>
> >> Anyhow once those are complete, I think we can resume operations with
> >> the surviving inodes.  The ones that fail the GETATTR revalidation are
> >> fuse_make_bad'd, which effectively revokes them.
> >
> > Ah! Interesting, I have been playing a bit with sending LOOKUP requests=
,
> > but probably GETATTR is a better option.
> >
> > So, are you currently working on any of this?  Are you implementing thi=
s
> > new NOTIFY_RESTARTED request?  I guess it's time for me to have a close=
r
> > look at fuse2fs too.
>
> Sorry for joining the discussion late, I was totally occupied, day and
> night. Added Kevin to CC, who is going to work on recovery on our
> DDN side.
>
> Issue with GETATTR and LOOKUP is that they need a path, but on fuse
> server restart we want kernel to recover inodes and their lookup count.
> Now inode recovery might be hard, because we currently only have a
> 64-bit node-id - which is used my most fuse application as memory
> pointer.
>
> As Luis wrote, my issue with FUSE_NOTIFY_RESEND is that it just re-sends
> outstanding requests. And that ends up in most cases in sending requests
> with invalid node-IDs, that are casted and might provoke random memory
> access on restart. Kind of the same issue why fuse nfs export or
> open_by_handle_at doesn't work well right now.
>
> So IMHO, what we really want is something like FUSE_LOOKUP_FH, which
> would not return a 64-bit node ID, but a max 128 byte file handle.
> And then FUSE_REVALIDATE_FH on server restart.
> The file handles could be stored into the fuse inode and also used for
> NFS export.
>
> I *think* Amir had a similar idea, but I don't find the link quickly.
> Adding Amir to CC.

Or maybe it was Miklos' idea. Hard to keep track of this rolling thread:
https://lore.kernel.org/linux-fsdevel/CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yU=
Y4L2JRAEKxEwOQ@mail.gmail.com/

>
> Our short term plan is to add something like FUSE_NOTIFY_RESTART, which
> will iterate over all superblock inodes and mark them with fuse_make_bad.
> Any objections against that?

IDK, it seems much more ugly than implementing LOOKUP_HANDLE
and I am not sure that LOOKUP_HANDLE is that hard to implement, when
comparing to this alternative.

I mean a restartable server is going to be a new implementation anyway, rig=
ht?
So it makes sense to start with a cleaner and more adequate protocol,
does it not?

Thanks,
Amir.

