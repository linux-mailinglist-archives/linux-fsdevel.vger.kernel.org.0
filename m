Return-Path: <linux-fsdevel+bounces-65586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6016DC0838A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 23:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDEB6401491
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 21:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D1431327E;
	Fri, 24 Oct 2025 21:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKmn90F3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ECF30C35E
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 21:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761343146; cv=none; b=ZDzsHwS9qp+ecrV0TWWViWusA25uoM+kBUi2WrXTgv7CWEgocCiSawIArXSk1h2qkrnG3rqn7D0Ro6SBWMNWzNsUYeq3EHZU9A7Ya9XNbq4rNJafRO81PpueBjOn4+VvCcjwlUfq779pEZ7FOewvkFn0vYw4qr1B3rb+08Ohh+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761343146; c=relaxed/simple;
	bh=mxdDRl5f6ypVZFwxoiySjpzvSm/XaHmi9pbQ4jbflIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/PjDwEkLCIBvMY2sbzr8C/wiRsTWfCyuucglaLAfPAwyEVYrTEm9eJzzopX+PAEPZjU9V6zET5dhdZcaTTjTs2aHoO8Dj76Juk4BER2sr6JWvxCnH2BklVYwifVmwpvdca0iHnGsnLn0H8/qZFjCwt0ZhIwKwhFekALubJwq7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKmn90F3; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4e89e689ec7so15982061cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 14:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761343142; x=1761947942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JSu4wYR7dGj9hekjT0Scgo7oK7p56khXcsyVLerwhg=;
        b=QKmn90F3xbYBk9WfK+osCC7TbkFMGWeGuYB9idqjQJemxKN9IqaeBRdDGM5DhnA8/T
         5fRu4lc7X68u7KXNBHgHx6zWled4MJ5GWQOYMoSihuV2ol8Bo/HN/d+AGkvBGBbSaeZx
         lqapDG/FeFxIOM34ggwhwYRQLOLTqJjmhVCBMp79sIBqjl12hR/EfPDMDjWZutFiJGdR
         BTkuB9X/aX+A8BO4M9YRWfKPqqo2bzcOiZ/2G+dixUD4wZT4+q/PhJSvVvLIveHN3LkL
         9VV0pY4neIJqsNBJB2UZjLj51CUg7LF0bxbJrK3LPqbPc3brCnsirhZAsyJ6u+U1Vs97
         C0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761343142; x=1761947942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JSu4wYR7dGj9hekjT0Scgo7oK7p56khXcsyVLerwhg=;
        b=K20hN3+Ka9KeAjwYOx9y9NiKeJlM9VlB29rIPbawo7TLr39HLYa8Bn20CkyBTNZB38
         QVsRKqJ88ENOfiicDfagDOzYHiJprPLOzkjViH2b3AX9cgUPyr7ukeWy3iCM1bxF1LkJ
         ti/4PUqStHfn3XHMHmMAN2Oiy5BjO2vv3W+MMhLwyy4Ezrej8dcTPWRoO1PX4kqpi1AF
         xPlEAB2QywvH8UR+LVLG/l/C8mJEIalQGa9ZgYjveISVoJajboJNWRHuFCCmF+efkBYR
         5WPcip27UBsM0igpCsjNK44x3yBgwde/f/5yNpQcs5rVpLau9QyA+ZGa/EwWQ/UcFMBl
         N0VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX+OXYNufVS3StXVYf8JWa22XO2lqcxIayLYA0NTnNZX3kFm8V23/rdliMV/SQS61AbjnO5qgR11tSlRWf@vger.kernel.org
X-Gm-Message-State: AOJu0YzmOS7PUhljpTxAYZdNsteWZkzrYg/JIsvLg6TflBHkkxTFIcYH
	N2QbEKo8EkKnhQU45MkpYfDvAJom19c3XUL2cbmSmpbT5fBxniuALzLGEly6s9e7o00ohpYKFh8
	eUQ0mHH+vVFalUS6lfMWVPce5HdWBw28=
X-Gm-Gg: ASbGncsA+rijpnfPdbUrbA2E1gDcqxbJ+Y1SYVcQDd2tHLEQm4dKHMwxnuStpSmvg6p
	9SyONBLqYerrzezm8XyEXy+7Wu9gPu6hF8rRlqq4L5W0lzQSpjiyKLgkwJxy8UFI+pHLsHj6u8m
	lE22cuHQFCA3zG364oSstvysXt5R2SWqLD6XAXeewoB4RKvw01jbdYsu0wbX7yDSUNc8IAts7o9
	SLr3k9h4mfAOiyclJ21C8+2uM4ZcZ+XPV/vXo3pcAgIXDT3zgSXJRthuCDqkaJJdkBVgHlNsDWG
	AihH3l/QMtCif3k=
X-Google-Smtp-Source: AGHT+IEbBcSwdHcN87CM+xJKbvHNa6uFwmLTJi2BasWFhru45dH++MGND3s6/74r0tI8E8W9g7oqhkLME3Y3cb4B/Bg=
X-Received: by 2002:a05:622a:180a:b0:4e8:bbd4:99d8 with SMTP id
 d75a77b69052e-4e8bbd49fd5mr247392271cf.37.1761343142321; Fri, 24 Oct 2025
 14:59:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926002609.1302233-1-joannelkoong@gmail.com>
 <20250926002609.1302233-8-joannelkoong@gmail.com> <aPqDPjnIaR3EF5Lt@bfoster>
 <CAJnrk1aNrARYRS+_b0v8yckR5bO4vyJkGKZHB2788vLKOY7xPw@mail.gmail.com>
 <CAJnrk1b3bHYhbW9q0r4A0NjnMNEbtCFExosAL_rUoBupr1mO3Q@mail.gmail.com>
 <aPu1ilw6Tq6tKPrf@casper.infradead.org> <CAJnrk1az+8iFnN4+bViR0USRHzQ8OejhQNNgUT+yr+g+X4nFEA@mail.gmail.com>
 <aPvolbqCAr1Tx0Pw@casper.infradead.org>
In-Reply-To: <aPvolbqCAr1Tx0Pw@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 24 Oct 2025 14:58:51 -0700
X-Gm-Features: AS18NWApxbcNiaK6JJ1--DN9zMQLqfqvI7dAP8Den9ypsz9jSVcP9ZxOIt1Gw7w
Message-ID: <CAJnrk1YZoFSMGHRK0M_=ND1RyXPgc6Ts4hh+UMOkrGqO5G884w@mail.gmail.com>
Subject: Re: [PATCH v5 07/14] iomap: track pending read bytes more optimally
To: Matthew Wilcox <willy@infradead.org>
Cc: Brian Foster <bfoster@redhat.com>, brauner@kernel.org, miklos@szeredi.hu, 
	djwong@kernel.org, hch@infradead.org, hsiangkao@linux.alibaba.com, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 1:59=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Oct 24, 2025 at 12:22:32PM -0700, Joanne Koong wrote:
> > > Feels like more filesystem people should be enabling CONFIG_DEBUG_VM
> > > when testing (excluding performance testing of course; it'll do ugly
> > > things to your performance numbers).
> >
> > Point taken. It looks like there's a bunch of other memory debugging
> > configs as well. Do you recommend enabling all of these when testing?
> > Do you have a particular .config you use for when you run tests?
>
> Our Kconfig is far too ornate.  We could do with a "recommended for
> kernel developers" profile.  Here's what I'm currently using, though I
> know it's changed over time:
>
> CONFIG_X86_DEBUGCTLMSR=3Dy
> CONFIG_PM_DEBUG=3Dy
> CONFIG_PM_SLEEP_DEBUG=3Dy
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
> CONFIG_BLK_DEBUG_FS=3Dy
> CONFIG_PNP_DEBUG_MESSAGES=3Dy
> CONFIG_SCSI_DEBUG=3Dm
> CONFIG_EXT4_DEBUG=3Dy
> CONFIG_JFS_DEBUG=3Dy
> CONFIG_XFS_DEBUG=3Dy
> CONFIG_BTRFS_DEBUG=3Dy
> CONFIG_UFS_DEBUG=3Dy
> CONFIG_DEBUG_BUGVERBOSE=3Dy
> CONFIG_DEBUG_KERNEL=3Dy
> CONFIG_DEBUG_MISC=3Dy
> CONFIG_DEBUG_INFO=3Dy
> CONFIG_DEBUG_INFO_DWARF4=3Dy
> CONFIG_DEBUG_INFO_COMPRESSED_NONE=3Dy
> CONFIG_DEBUG_FS=3Dy
> CONFIG_DEBUG_FS_ALLOW_ALL=3Dy
> CONFIG_ARCH_HAS_EARLY_DEBUG=3Dy
> CONFIG_SLUB_DEBUG=3Dy
> CONFIG_ARCH_HAS_DEBUG_WX=3Dy
> CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
> CONFIG_SHRINKER_DEBUG=3Dy
> CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=3Dy
> CONFIG_DEBUG_VM_IRQSOFF=3Dy
> CONFIG_DEBUG_VM=3Dy
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=3Dy
> CONFIG_DEBUG_MEMORY_INIT=3Dy
> CONFIG_LOCK_DEBUGGING_SUPPORT=3Dy
> CONFIG_DEBUG_RT_MUTEXES=3Dy
> CONFIG_DEBUG_SPINLOCK=3Dy
> CONFIG_DEBUG_MUTEXES=3Dy
> CONFIG_DEBUG_WW_MUTEX_SLOWPATH=3Dy
> CONFIG_DEBUG_RWSEMS=3Dy
> CONFIG_DEBUG_LOCK_ALLOC=3Dy
> CONFIG_DEBUG_LIST=3Dy
> CONFIG_X86_DEBUG_FPU=3Dy
> CONFIG_FAULT_INJECTION_DEBUG_FS=3Dy
>
> (output from grep DEBUG .build/.config |grep -v ^#)

Thank you, I'll copy this.
>

