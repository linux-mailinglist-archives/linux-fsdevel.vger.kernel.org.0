Return-Path: <linux-fsdevel+bounces-35453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A869D4E8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 15:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6E5FB21B5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 14:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBE71D90DC;
	Thu, 21 Nov 2024 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9b5+Yox"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA35F1D63FD;
	Thu, 21 Nov 2024 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732198731; cv=none; b=CJKYLG/w8g6AhOvkV6H3NbiEOeeHGeLViiGfqQwxRHmAE3OxK+APufrGyQ+/mFcQ7I3AI7HJTJNkMsBCUwgLxe366SWI71yrfxUmZB5ZwgJso+ePXf7Pucfe574h/63gKsiSDun4Zulu5qddlSCcFRjxlOrpjejy0igVEw7f9LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732198731; c=relaxed/simple;
	bh=bNvc0py64DAf3/4lI8U9CHFwkfOTtYkeLHfMBzYWgL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=laxbt52zaRamPTskvndM1cnoJkI5SpukVtTU4etGvmSrwPthSX8QNkagkpUNMaGO25/FPDc3OyOkMZGHtd7GeF/toI3+MZjobk1RUWPr3KxoXzmMY9Md0ONl07Drv+uhMTHpbGvV262+/m9UT2xX8i6guey+oLoDkLewGGVJJrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9b5+Yox; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so17819901fa.0;
        Thu, 21 Nov 2024 06:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732198728; x=1732803528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pO8DokmCbNTYcYBfKWRaeP/dEwanubQ3Z/RPc3+IoOQ=;
        b=C9b5+YoxQTsg22CtxdHmQ+C/UgBNpLrp4SWsE50vJkVtO7GH6k0/VL71mGSFjinVYO
         nsvWfCUJEhpKB/god6w7lDyunqtQzJ0FT17WFq43nym4fLJJI/FNR5Qb3HtlIuYLCBo0
         fLjIB+p8ogntOxbEhVxaV4W0n7dxpmC167o/CscEQsLwk0dAJbwHaRZ02VLrpfB1LHQG
         8X2RecRpiMbq6XtbhmmEbguecXZXH0Y6qdvYgHrYXi8Fzj25zIz9JqAmrVrdvOX7y9wg
         JgMlsZh4ZwewEEII2EbEffATIfTApSdbyPL9afwGvETPV05ZDeD71D+TUH4v5S8hwnMJ
         LzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732198728; x=1732803528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pO8DokmCbNTYcYBfKWRaeP/dEwanubQ3Z/RPc3+IoOQ=;
        b=hIaeuUZCH0M4r5N5PxGDEmkUvAKdpwAU4lc/f7ZN8v/Bm0vmeR4yMygcmi2Veqt3sB
         G+rw0Mf2UM6jEf0p3cVJf1yCPhXvk0qBxEOEq+IBXhzJHC0CcTxy0x4ee5Nscdm09YO2
         gBOMBSMLDwOigdJgpDW0sHO+T61Z/IuUvgXF3dAVoJbvLfvOzkysnejDw6jr6lCj3ENE
         /S40xf78ypL88oiJ8zBXEIfghblmlr6XkmR+owyrcv6DfuH5x+vjFEzCHraXZPbbxJt5
         go14NGL7ntBBO2aaeDGH5DYwmX7P5NgH6yqUxx2f8gGM2vG5EVEFIsr8jsW4CJAAEeY3
         onGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVRDzeOXdIq3k1/ek6OA4xS/OvNrKx2pmY6axGo1rQlG6i5mROf5OyuEHK2M/hnLr4hTbEMyVjDZSN5w==@vger.kernel.org, AJvYcCUp53BwGoJ4WZC9YRWAOe9iXJlncIwf/eYolXIVOyda8CY3OR6dcQX8zyQsGfutAhFyGGf/9C7ZMQ2Y@vger.kernel.org, AJvYcCW3L+MkSiNS1mssbLbV9u516veyTB9A4aXFYSGK7jnOpQCLI6s6zeRuYn9zlf6noSf0qf5Cld9Bdh7YF/Cxrg==@vger.kernel.org, AJvYcCXzBD1nSm3gJoY5vbxG+ScBR9h7g9b9CYtn9hKt+IE6bGPvrkqqFeX8Tl2DmuqPn+SGyfhSMiNKHMwv3A==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbu/fLB1wDxhamDxujh5sRvf4mXNTgpsO+4+LLmEihrEPU75rW
	dsqJcbJB5mfUBY6oFEOtPwSR1sar0f3NUOXLAh+McrJ/921k4p7facNXGe3/zCaDfytleeK6hrZ
	8OVJcaO6wNgcCxmn1Jt+kkJriJjlYcclCP4I=
X-Gm-Gg: ASbGnctnyCR0Ht11o8GcMSpkMUpevrJZvyI9bo7WuKJx2JPt2Nz8Hs/RpecoAQDfd+z
	FLsQx85AtFE+Gb2kQk9OXQcsoro0oepg=
X-Google-Smtp-Source: AGHT+IEE9uu1LLPFKTWP8pimZf7yZgaRdrUeWk2IUF2LLnQpNe7uZnVbznEcE/8soKYRUUWZb2SAtbqxpd+Sov4cXAQ=
X-Received: by 2002:a05:651c:221b:b0:2fb:6362:284e with SMTP id
 38308e7fff4ca-2ff8db165bdmr58987841fa.8.1732198727467; Thu, 21 Nov 2024
 06:18:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731684329.git.josef@toxicpanda.com> <b80986f8d5b860acea2c9a73c0acd93587be5fe4.1731684329.git.josef@toxicpanda.com>
 <20241121104428.wtlrfhadcvipkjia@quack3>
In-Reply-To: <20241121104428.wtlrfhadcvipkjia@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 21 Nov 2024 15:18:36 +0100
Message-ID: <CAOQ4uxhTiR8eHaf4q0_gLC62CWi9KdaQ05GSeqFkKFkXCH++PA@mail.gmail.com>
Subject: Re: [PATCH v8 10/19] fanotify: introduce FAN_PRE_ACCESS permission event
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 11:44=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 15-11-24 10:30:23, Josef Bacik wrote:
> > From: Amir Goldstein <amir73il@gmail.com>
> >
> > Similar to FAN_ACCESS_PERM permission event, but it is only allowed wit=
h
> > class FAN_CLASS_PRE_CONTENT and only allowed on regular files and dirs.
> >
> > Unlike FAN_ACCESS_PERM, it is safe to write to the file being accessed
> > in the context of the event handler.
> >
> > This pre-content event is meant to be used by hierarchical storage
> > managers that want to fill the content of files on first read access.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Here I was wondering about one thing:
>
> > +     /*
> > +      * Filesystems need to opt-into pre-content evnets (a.k.a HSM)
> > +      * and they are only supported on regular files and directories.
> > +      */
> > +     if (mask & FANOTIFY_PRE_CONTENT_EVENTS) {
> > +             if (!(path->mnt->mnt_sb->s_iflags & SB_I_ALLOW_HSM))
> > +                     return -EINVAL;
> > +             if (!is_dir && !d_is_reg(path->dentry))
> > +                     return -EINVAL;
> > +     }
>
> AFAICS, currently no pre-content events are generated for directories. So
> perhaps we should refuse directories here as well for now? I'd like to

readdir() does emit PRE_ACCESS (without a range) and also always
emitted ACCESS_PERM. my POC is using that PRE_ACCESS to populate
directories on-demand, although the functionality is incomplete without the
"populate on lookup" event.

> avoid the mistake of original fanotify which had some events available on
> directories but they did nothing and then you have to ponder hard whether
> you're going to break userspace if you actually start emitting them...

But in any case, the FAN_ONDIR built-in filter is applicable to PRE_ACCESS.

Thanks,
Amir.

