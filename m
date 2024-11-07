Return-Path: <linux-fsdevel+bounces-33964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 780DE9C0FCF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 21:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03AAC1F23F43
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 20:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF8A217F4C;
	Thu,  7 Nov 2024 20:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3KVJA1v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F4F18F2C3;
	Thu,  7 Nov 2024 20:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731011650; cv=none; b=iwD1nbOdu63JzT/EDvso1kRAhag4gYg3xIp1nKsx349FGbkH/f4XL8LixJ+IQHGtaqW9PoNd8RgyGJYb/17ZcBVCfv5MYdBHskfji5jx4WBHG/kpoImsiISBCzdfitNlqYbPgj0BolygDpExNFHKwd4YOmk67nPRRtjs4Fqk6iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731011650; c=relaxed/simple;
	bh=V4UxAcM8BXHx1JRAZ6d59ysQSB7dHmJDtTpTVJnnY6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0heeMS7JRDBoumKjbYRcb+3I4V5DmxveHBsQF/EoTLSVpb0O8maMWfFIUh/k9AN+7E81lg0PZF4Hkf2+KXH4AYnqkkQMfk84RwMtgT4LklKev8HW1l1N2kM1/KWSYVBq2DJmW8OQy5ruVuh0AKOi05X7nPc/jr7lOOuYRXdHoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3KVJA1v; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cbcc2bd800so13273626d6.0;
        Thu, 07 Nov 2024 12:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731011647; x=1731616447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tp2LgPNW5d9VXqXY5UyuxrFVsPJIvcX/0ZS5kAa51YI=;
        b=U3KVJA1viPW/jE6ZRzOptnDwMeTKFFzS3yliTAM1YBMb7faG2s/qS6RwUDqNRgDEJL
         uJnGttwASnyAC8vu2hJiuqmbZzPJA3gcB12poZcI6NdRjGv1AJ4Xqq5yGO6CICNcfbfp
         9AoD4Lmr2pWcVBuDlKFR18BpghI8T30uyRVBMCKD7S2QI1qi9XkNvz0mHYeb5pEUywxz
         3zlhb0Xb5oB1HySCkH5SPVHOvUbZO8oI9b8opAU9X7YAYpQ1Rz6oDbjtGkbr+yNQqHSr
         jRjjx5ix4vQxGBjrEX0bnyLAWIRKnaT04PEcNUjRYlSKFbH7OSFia2OeklFGTp5SgpsG
         R1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731011647; x=1731616447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tp2LgPNW5d9VXqXY5UyuxrFVsPJIvcX/0ZS5kAa51YI=;
        b=CNzQXo3ke8wh3Prizvjk8gR1KgTeyLh7expAhp9NSTxd5PvC83xzPf6iUOqU5grR0h
         JZX3IVy3n54XBXe2IoHRTJ24faRn5VIZzZW//MKJz36bb+xgpNatW2jbK7u1gt0WFII2
         9BBtOSxCXwG8TrodmAGf7XTcHWqHqcWGBKYF9Eo6ifNJP1NhXROhCegkwCuP8MqhU9Hs
         HyMDtAYVxeyca89PS8GsBqd7Q9YPjxoFpElHpmmrHd+BPfQfN5pmnP2z/DrEo7w3GSi+
         leNtU8Rm3g1+TGCtdvttWG7AyceILDkwDGqQVDdgj/AsxvIqtFXCbztfbwo63phpWCz6
         zVGg==
X-Forwarded-Encrypted: i=1; AJvYcCULxH4S4Urp1rxmS8xFwaaE0xjfj0fdsMT1v+IDQDN26gCFpb3AZB7jfVsK1C7tefGK/e8=@vger.kernel.org, AJvYcCUN9SN64MoGyMoOTCQWa0LRJXFEmSI8vIW1s1hXE8TwRHgJhHoMXsY6Kect6QOGy7FfFY31wTPt5Q23nrBg@vger.kernel.org, AJvYcCVMKW9WtOV6lQy7xc7cG8xx3kuxdur7vAbiGxbpQwXwgXeQdIu/WF+XtVBhGS80rXo7AxVJqszpmjYRDUkeGA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk1rMitb9PNLny2HrbKiavKt4CUkhQxTrVkIcwCwuvxDKtTotB
	V5xeOxXWyn4b3fGUOA+eb1EMyL7GzKcXRnm1Ppamp/DfU/kImACKpE/FqpY0ZFMWOTjpw+N6lx3
	jDr9sRc19OfRtUbR2vpoZLSaKWCs=
X-Google-Smtp-Source: AGHT+IGs14H2HZowsTnEkyUp6ilMGsXSaYN7JFNpJWuejehF3aZWDTXJNbTBhcbYqxqmdkT+bppDeIc9oeaSYTSVTdc=
X-Received: by 2002:ad4:5d49:0:b0:6d3:5be3:e711 with SMTP id
 6a1803df08f44-6d39d57c179mr15848676d6.9.1731011647511; Thu, 07 Nov 2024
 12:34:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029231244.2834368-1-song@kernel.org> <20241029231244.2834368-6-song@kernel.org>
 <CAOQ4uxjDudLwKuxXaFihdYJUv2yvwkETouP9zJtJ6bRSpmV-Kw@mail.gmail.com> <DAAF8ED0-42E2-4CC6-842D-589DF6162B90@fb.com>
In-Reply-To: <DAAF8ED0-42E2-4CC6-842D-589DF6162B90@fb.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 7 Nov 2024 21:33:56 +0100
Message-ID: <CAOQ4uxgJiUfO4RL-xYmfRTz7f5m-niLG10xeCGazuk7nuiBhqw@mail.gmail.com>
Subject: Re: [RFC bpf-next fanotify 5/5] selftests/bpf: Add test for BPF based
 fanotify fastpath handler
To: Song Liu <songliubraving@meta.com>
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>, "andrii@kernel.org" <andrii@kernel.org>, 
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "brauner@kernel.org" <brauner@kernel.org>, 
	"jack@suse.cz" <jack@suse.cz>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"mattbobrowski@google.com" <mattbobrowski@google.com>, "repnop@google.com" <repnop@google.com>, 
	"jlayton@kernel.org" <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 8:53=E2=80=AFPM Song Liu <songliubraving@meta.com> w=
rote:
>
>
>
> > On Nov 7, 2024, at 3:10=E2=80=AFAM, Amir Goldstein <amir73il@gmail.com>=
 wrote:
> >
> > On Wed, Oct 30, 2024 at 12:13=E2=80=AFAM Song Liu <song@kernel.org> wro=
te:
> >>
> >> This test shows a simplified logic that monitors a subtree. This is
> >> simplified as it doesn't handle all the scenarios, such as:
> >>
> >>  1) moving a subsubtree into/outof the being monitoring subtree;
> >
> > There is a solution for that (see below)
> >
> >>  2) mount point inside the being monitored subtree
> >
> > For that we will need to add the MOUNT/UNMOUNT/MOVE_MOUNT events,
> > but those have been requested by userspace anyway.
> >
> >>
> >> Therefore, this is not to show a way to reliably monitor a subtree.
> >> Instead, this is to test the functionalities of bpf based fastpath.
> >> To really monitor a subtree reliably, we will need more complex logic.
> >
> > Actually, this example is the foundation of my vision for efficient and=
 race
> > free subtree filtering:
> >
> > 1. The inode map is to be treated as a cache for the is_subdir() query
>
> Using is_subdir() as the truth and managing the cache in inode map seems
> promising to me.
>
> > 2. Cache entries can also have a "distance from root" (i.e. depth) valu=
e
> > 3. Each unknown queried path can call is_subdir() and populate the cach=
e
> >    entries for all ancestors
> > 4. The cache/map size should be limited and when limit is reached,
> >    evicting entries by depth priority makes sense
> > 5. A rename event for a directory whose inode is in the map and whose
> >   new parent is not in the map or has a different value than old parent
> >   needs to invalidate the entire map
> > 6. fast_path also needs a hook from inode evict to clear cache entries
>
> The inode map is physically attached to the inode itself. So the evict
> event is automatically handled. IOW, an inode's entry in the inode map
> is automatically removed when the inode is freed. For the same reason,
> we don't need to set a limit in map size and add evicting logic. Of
> course, this works based on the assumption that we don't use too much
> memory for each inode. I think this assumption is true.

Oh no, it is definitely wrong each inode is around 1K and this was the
main incentive to implement FAN_MARK_EVICTABLE and
FAN_MARK_FILESYSTEK in the first place, because recursive
pinning of all inodes in a large tree is not scalable to large trees.

Thanks,
Amir.

