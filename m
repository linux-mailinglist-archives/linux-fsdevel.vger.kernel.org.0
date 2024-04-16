Return-Path: <linux-fsdevel+bounces-17049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F898A7039
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 17:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A7C1F2165F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 15:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D3313172A;
	Tue, 16 Apr 2024 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjqoT9wE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B505130492
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Apr 2024 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282769; cv=none; b=VpXOaNatAgEoOvve/X2cfP3eXAPTt8gBXFEkDnjfeX1vnFu18nF2p9UponKicCRs9ddPUsV7dyxcpPbkGiN0R3Aofqu8PEgkqgOFe+N3S/VEjg9lfe7eWOeiHUaciiGHSHXhPukieddtsesYc7xHInyVXefoGDHUWc3seEHR4Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282769; c=relaxed/simple;
	bh=ShDOZWzPeYGxxgwalKVmy9MK9olDk4sn9f5ukZ/S7AU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVWfBtLShrwtHRBUA+R7vc9oj1p//263zHC/nKae+dksIQKOmqBFPpIhIg6i4/3jYH36kbGNuZg878zyO8agiYuGZ9mO8uSkJzb7SOmvCkozPZ+ATV9AK2vkrmLOVV4De9zoosuTYMC2R2oqb/s0T/mEAAfIC8LonWrKOyGJeb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjqoT9wE; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-69b4e94ecd2so14519156d6.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Apr 2024 08:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713282767; x=1713887567; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nl74OMmDx14Hlt8+xvOuSL2zcQZ8P18OFdoz8ptVt+E=;
        b=XjqoT9wE8rsdjqm2fP0A7Ie1ofPIsLfpiuqtI3dkY3sAVFM6s0Y8CbX7YEGJTWN2lU
         NXHnpMy41kXAliQ1cB+tzGmxIMV9ButKbD6h4+5UMKxUzoUihO1iKu1hWE4ctbUcMCCs
         LL2g0kTAueYjjfSGSj4BHnlBTnDy0YyVqlhtc3ETgj8rwh2THwShwQ6fQmlasfHzYkft
         j1DJb8j54FpRuvZfJKJOixyzIEjDrV5koXLOyPziRjJas9mDJtscHiz+oL641Dw75KWC
         CGdzskCrORk7W7SyCLCildBB9zON+NVOX2g8AcQFqAgkx15FwFS0IPL62g1eGCwlaYi5
         n2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713282767; x=1713887567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nl74OMmDx14Hlt8+xvOuSL2zcQZ8P18OFdoz8ptVt+E=;
        b=FyA1mL7jdOUYHt+Yu1P+h5kixWH3OyERY2FWmi3ULEDCHt5nc2hMOOrW7MOFFlc3+a
         kL6cm7o9xVeTVzgM881tRCJljfbcoCYw0PQG/SmjfA5WPEpEFghbkNcfqj7QR38ESgxf
         QEiYl1UhjtzH8lIw0K6WI8jwfDJ4RHztwFsj1hW+S+0SkoufG2oc/vYDFE7joMnnbbYg
         MJiU+6WBkXshJWhhMyG/3bhUdIyjGy7i2mzNlKv3QnulxOfWMiJvZirZIHR3hlkHCk6D
         uLR2nJ9M3q1A5yvOGsFg5RvIWBNN2LjCzbJ7EIoHjfQcOx9qHAp2jNfrHaqsCCjFVAY5
         jNdA==
X-Forwarded-Encrypted: i=1; AJvYcCUClujlD+VKGtOrV0HBlglklCxVINN3UWTd3TMTuqn4H/jgoeG0O90HCx6hd6HKzPeKiM7dyN9ScFjT/lqpJ6q/u+riTxwBQFz6b9N4Pw==
X-Gm-Message-State: AOJu0Yyfn80oGXV/HUENtUaw8h96dK52jKQdDm3lWDGgVcG+mXg+2KwX
	EeYL6qDYXcDK6mRcN0eZTpH0kcSeJS1kCHikFLeHjB3sez4uVwW/chKRW7OM0KWcsLc561OFGBV
	U9FOxijdp8hT6PN45LxObf7pRXew=
X-Google-Smtp-Source: AGHT+IFiavGBrO4wCuS+R2fjMqvvh2ZFcgp1bhof+DCq9dz8M9vny/UC0o11rCSkrLIIyigBDoLVTyWAN6bUTL/mD40=
X-Received: by 2002:a05:6214:2b0f:b0:69b:693d:e3cb with SMTP id
 jx15-20020a0562142b0f00b0069b693de3cbmr10840610qvb.11.1713282766906; Tue, 16
 Apr 2024 08:52:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208183127.5onh65vyho4ds7o7@quack3> <CAOQ4uxiwpe2E3LZHweKB+HhkYaAKT5y_mYkxkL=0ybT+g5oUMA@mail.gmail.com>
 <20240212120157.y5d5h2dptgjvme5c@quack3> <CAOQ4uxi45Ci=3d62prFoKjNQanbUXiCP4ULtUOrQtFNqkLA8Hw@mail.gmail.com>
 <20240215115139.rq6resdfgqiezw4t@quack3> <CAOQ4uxh-zYN_gok2mp8jK6BysgDb+BModw+uixvwoHB6ZpiGww@mail.gmail.com>
 <20240219110121.moeds3khqgnghuj2@quack3> <CAOQ4uxizF_=PK9N9A8i8Q_QhpXe7MNrfUTRwR5jCVzgfSBm1dw@mail.gmail.com>
 <20240304103337.qdzkehmpj5gqrdcs@quack3> <CAOQ4uxh35YhMVfXHchYpgG_HoOmLY4civVpeVtz4GQmasHqWdw@mail.gmail.com>
 <20240416151552.rpjbbbb5lbdvjofe@quack3>
In-Reply-To: <20240416151552.rpjbbbb5lbdvjofe@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 16 Apr 2024 18:52:35 +0300
Message-ID: <CAOQ4uxiW6dxz8w3muHxogbPuNGa0cdubr_YSti1Jp97LLehaYg@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: allow to set errno in FAN_DENY permission response
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, 
	Sweet Tea Dorminy <thesweettea@meta.com>
Content-Type: text/plain; charset="UTF-8"

> > The Windows Cloud Sync Engine API:
> > https://learn.microsoft.com/en-us/windows/win32/cfapi/build-a-cloud-file-sync-engine
> > Does allow registring different "Storage namespace providers".
> > AFAICT, the persistence of "Place holder" files is based on NTFS
> > "Reparse points",
> > which are a long time native concept which allows registering a persistent
> > hook on a file to be handled by a specific Windows driver.
> >
> > So for example, a Dropbox place holder file, is a file with "reparse point"
> > that has some label to direct the read/write calls to the Windows
> > Cloud Sync Engine
> > driver and a sub-label to direct the handling of the upcall by the Dropbox
> > CloudSync Engine service.
>
> OK, so AFAIU they implement HSM directly in the filesystem which is somewhat
> different situation from what we are trying to do.
>

Technically, I think that Reparse points Win32 driver hooks are a
generic WIN32 API which NTFS implements, but that doesn't matter.
IIUC, it is equivalent to having support for xattr "security.hsm.dropbox"
that fanotify would know how to intercept as a persistent mark to
be handled by "dropbox" hsm group or return EPERM.

> > I do not want to deal with "persistent fanotify marks" at this time, so
> > maybe something like:
> >
> > fsconfig(ffd, FSCONFIG_SET_STRING, "hsmid", "dropbox", 0)
> > fsconfig(ffd, FSCONFIG_SET_STRING, "hsmver", "1", 0)
> >
> > Add support ioctls in fanotify_ioctl():
> > - FANOTIFY_IOC_HSMID
> > - FANOTIFY_IOC_HSMVER
>
> What would these do? Set HSMID & HSMVER for fsnotify_group identified by
> 'file'? BTW I'm not so convinced about the 'version' thing. I have hard
> time to remember an example where the versioning in the API actually ended
> up being useful. I also expect tight coupling between userspace mounting
> the filesystem and setting up HSM so it is hard to imagine some wrong
> version of HSM provider would be "accidentally" started for the
> filesystem.
>

ok. worse case, can alway switch to hsmid "dropboxv2"

> > And require that a group with matching hsmid and recent hsmver has a live
> > filesystem mark on the sb.
>
> I'm not quite following here. We'd require matching fsnotify group for
> what? For mounting the fs? For not returning EPERM from all pre-op
> handlers? Either way that doesn't make sense to me as its unclear how
> userspace would be able to place the mark... But there's a way around that
> - since the HSM app will have its private non-HSM mount for filling in
> contents, it can first create that mount, place filesystem marks though
> it and then remount the superblock with hsmid mount option and create the
> public mount. But I'm not sure if you meant this or something else...
>

I haven't thought of the mechanics yet just the definition:
- An sb with hsm="XXX" returns EPERM for pre-content events
  unless there is an sb mark from a group that is identified as hsm "XXX"

I don't see a problem with mounting the fs first and only then
setting up the sb mark on the root of the fs (which does not require
a pre-lookup event). When the hsm service is restarted, it is going to
need to re-set the sb mark on the hsm="XXX" sb anyway.

> > If this is an acceptable API for a single crash-safe HSM provider, then the
> > question becomes:
> > How would we extend this to multiple crash-safe HSM providers in the future?
>
> Something like:
>
> fsconfig(ffd, FSCONFIG_SET_STRING, "hsmid", "dropbox,cloudsync,httpfs", 0)
>
> means all of them are required to have a filesystem mark?
>

Yeh, it's an option.
I have a trauma from comma separated values in overlayfs
mount options, but maybe it's fine.
The main API question would be, regardless of single or multi hsm,
whether hsm="" value should be reconfigurable (probably yes).

> > Or maybe we do not need to support multiple HSM groups per sb?
> > Maybe in the future a generic service could be implemented to
> > delegate different HSM modules, e.g.:
> >
> > fsconfig(ffd, FSCONFIG_SET_STRING, "hsmid", "cloudsync", 0)
> > fsconfig(ffd, FSCONFIG_SET_STRING, "hsmver", "1", 0)
> >
> > And a generic "cloudsync" service could be in charge of
> > registration of "cloudsync" engines and dispatching the pre-content
> > event to the appropriate module based on path (i.e. under the dropbox folder).
> >
> > Once this gets passed NACKs from fs developers I'd like to pull in
> > some distro people to the discussion and maybe bring this up as
> > a topic discussion for LSFMM if we feel that there is something to discuss.
>
> I guess a short talk (lighting talk?) what we are planning to do would be
> interesting so that people are aware. At this point I don't think we have
> particular problems to discuss that would be interesting for the whole fs
> crowd for a full slot...

Agree.

Thanks,
Amir.

