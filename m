Return-Path: <linux-fsdevel+bounces-33999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569CE9C17B5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 09:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 690271C22C7F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 08:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143751DE899;
	Fri,  8 Nov 2024 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLqBijBI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74701D9A47;
	Fri,  8 Nov 2024 08:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731053950; cv=none; b=B2XP7HRa5pJ01kmUs0Y/k0jFdMJaj8MWwRNSB8LEuxmjdTeEwQ4ZO6QAcNEfgz0IAJKLN5XRRpC+8JGiUFu07+o9SbAi2jjjfyLrGi1qC3oQs6gZehiWjWBGucuI7NigueH3Nwx8zK1LV7enVH2Z/0DutzKJxckV1w8HFUgQXlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731053950; c=relaxed/simple;
	bh=fcaxWAKwSggVINL7s4cOeCkGkdgYXwPQA6QqYZice6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cXL9jnLJcVA+//GKgEdlZesBaFekrIPzTkadGYnWBYnR8DE2JGLpiMVa+r6lXC1OOlcL5fOTaW7+XIJyxgfaXkxrFNgKjxb1oaLJpvN2waMWcsTBkTwwSyky6P+VrldgNLMldW8814/Rmh2kfqKr5da7X/Hy7P9U5JyFq3/PjlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLqBijBI; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cc03b649f2so10777696d6.3;
        Fri, 08 Nov 2024 00:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731053948; x=1731658748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYnPIcef+Gr4wVDS0pv9Hxfg4U8coSTCpeAYrCDBj1I=;
        b=bLqBijBINi07SqZJsstZdJol1gmGg25tPR4a2yHRqYl+GaT1SPcU/0WZErd/H4ujBn
         DEZFArvwH/W4HBt7hhhxcVuERo7L1/xj4YfgrBOnIxp6o0u38ELjdvBZQrZ3eb9D7eYL
         sJEaTTog3klkz32gNOp9WFlDjL1MPNwlFZssaR0ITp43/DnDggZnf+hWmteLHUdwnfK5
         FsyuF4o8weJi5XR7GeGoMthS0cmeuXXU0vvEfNJ+nGhXt/vI4zY4o7L7MJqKkM+SY27T
         YlLKCh2PrKVcU5L45+MmFInajL5AGhEjytXFIuUt3IyPev6ng5FjDyx5Dg7Tg25CT7w+
         Kd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731053948; x=1731658748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYnPIcef+Gr4wVDS0pv9Hxfg4U8coSTCpeAYrCDBj1I=;
        b=QH9mgOUsIfB6ewxtcN6QmTQW8o+Ylrsq/vq2IqTYulGZtDVXmtmeoyWp87Flr+/5Ca
         +DwxiFBGvQ7iNBoRpaMPT1dl0oN2jBnQ+R8vlPohqyTDO/iYSK9Wc0iYsJhTL9UDhZ4/
         jDmtcSY/V6Filu9xcTHVMNgyAzunWwjOykfPuZ4Se4PJtWQU5TM9b+GKTmC6pEf0aDym
         7KmBG5cJVqcCNezuRVCGkyEtxfmqV6p1+dFfmg5ZaaQ0yn0HkwnMTbYsOFow/bJOEhZ0
         556oC+5KnxANrLj+0CMS68Q91o/4TvuIZXWpKY7YVCb8fc3w9N/JvzMCu1X9f90FusF0
         C+eg==
X-Forwarded-Encrypted: i=1; AJvYcCUdn6pkkT9m1ktOjv3Dgc8sjA5jocd1nxQqaIi7Qg5eJifWpX3JUmusrRIfNAHUrlq4Sv9DujAkBySQUrTc@vger.kernel.org, AJvYcCVVavo5xNB+R9MSYfRCY49M4zxSwIeqAYSVRHMd4yhn5DYY+IigSg4JFno4QMe57XkZSaE=@vger.kernel.org, AJvYcCX15aIJyJWCfpc6u2KIEMb/pwSmozDhjai5qlMO0v0uoBFAHkrpdfYquHYjmb3iGM6QY3BZvVl6/AzNsEItRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMcm3wBlPJoSFqpg03y0kRBFPXyR+ToY2SYTkSG70cTomIUhJQ
	3jKajaRYL7ZiW2Pt+D9TuD8UzAo+b+i4PMnGfwN28JfM5i4u4HYL0MD2YtI+3bRblhilD2F+/Gv
	RMRV20E4KGwH0BaOXXpqTdO79sF7qen75
X-Google-Smtp-Source: AGHT+IFZv8PSsw2vzs5KyXgqh7Ek5bU7XBipV7biSuklfKmyZGD5sTjwUCdbD+p6EXhgBCBKspkSJbpvyMiTLlHl4zE=
X-Received: by 2002:a05:6214:4288:b0:6cb:e6b2:4a84 with SMTP id
 6a1803df08f44-6d39e17e6b6mr25724376d6.14.1731053947613; Fri, 08 Nov 2024
 00:19:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029231244.2834368-1-song@kernel.org> <20241029231244.2834368-6-song@kernel.org>
 <CAOQ4uxjDudLwKuxXaFihdYJUv2yvwkETouP9zJtJ6bRSpmV-Kw@mail.gmail.com>
 <DAAF8ED0-42E2-4CC6-842D-589DF6162B90@fb.com> <CAOQ4uxgJiUfO4RL-xYmfRTz7f5m-niLG10xeCGazuk7nuiBhqw@mail.gmail.com>
 <CAPhsuW71hKC1G9jayVqmAMFu+kPOibWC9xqdMj9tLmCcteQuEQ@mail.gmail.com>
In-Reply-To: <CAPhsuW71hKC1G9jayVqmAMFu+kPOibWC9xqdMj9tLmCcteQuEQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 8 Nov 2024 09:18:56 +0100
Message-ID: <CAOQ4uxjXjjkKMa1xcPyxE5vxh1U5oGZJWtofRCwp-3ikCA6cgg@mail.gmail.com>
Subject: Re: [RFC bpf-next fanotify 5/5] selftests/bpf: Add test for BPF based
 fanotify fastpath handler
To: Song Liu <song@kernel.org>
Cc: Song Liu <songliubraving@meta.com>, bpf <bpf@vger.kernel.org>, 
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

On Thu, Nov 7, 2024 at 9:48=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Thu, Nov 7, 2024 at 12:34=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Thu, Nov 7, 2024 at 8:53=E2=80=AFPM Song Liu <songliubraving@meta.co=
m> wrote:
> > >
> > >
> > >
> > > > On Nov 7, 2024, at 3:10=E2=80=AFAM, Amir Goldstein <amir73il@gmail.=
com> wrote:
> > > >
> > > > On Wed, Oct 30, 2024 at 12:13=E2=80=AFAM Song Liu <song@kernel.org>=
 wrote:
> > > >>
> > > >> This test shows a simplified logic that monitors a subtree. This i=
s
> > > >> simplified as it doesn't handle all the scenarios, such as:
> > > >>
> > > >>  1) moving a subsubtree into/outof the being monitoring subtree;
> > > >
> > > > There is a solution for that (see below)
> > > >
> > > >>  2) mount point inside the being monitored subtree
> > > >
> > > > For that we will need to add the MOUNT/UNMOUNT/MOVE_MOUNT events,
> > > > but those have been requested by userspace anyway.
> > > >
> > > >>
> > > >> Therefore, this is not to show a way to reliably monitor a subtree=
.
> > > >> Instead, this is to test the functionalities of bpf based fastpath=
.
> > > >> To really monitor a subtree reliably, we will need more complex lo=
gic.
> > > >
> > > > Actually, this example is the foundation of my vision for efficient=
 and race
> > > > free subtree filtering:
> > > >
> > > > 1. The inode map is to be treated as a cache for the is_subdir() qu=
ery
> > >
> > > Using is_subdir() as the truth and managing the cache in inode map se=
ems
> > > promising to me.
> > >
> > > > 2. Cache entries can also have a "distance from root" (i.e. depth) =
value
> > > > 3. Each unknown queried path can call is_subdir() and populate the =
cache
> > > >    entries for all ancestors
> > > > 4. The cache/map size should be limited and when limit is reached,
> > > >    evicting entries by depth priority makes sense
> > > > 5. A rename event for a directory whose inode is in the map and who=
se
> > > >   new parent is not in the map or has a different value than old pa=
rent
> > > >   needs to invalidate the entire map
> > > > 6. fast_path also needs a hook from inode evict to clear cache entr=
ies
> > >
> > > The inode map is physically attached to the inode itself. So the evic=
t
> > > event is automatically handled. IOW, an inode's entry in the inode ma=
p
> > > is automatically removed when the inode is freed. For the same reason=
,
> > > we don't need to set a limit in map size and add evicting logic. Of
> > > course, this works based on the assumption that we don't use too much
> > > memory for each inode. I think this assumption is true.
> >
> > Oh no, it is definitely wrong each inode is around 1K and this was the
> > main incentive to implement FAN_MARK_EVICTABLE and
> > FAN_MARK_FILESYSTEK in the first place, because recursive
> > pinning of all inodes in a large tree is not scalable to large trees.
>
> The inode map does not pin the inode in memory. The inode will
> still be evicted as normal. The entry associated with the being
> evicted inode in the map will be freed together as the inoide is freed.
> The overhead I mentioned was the extra few bytes (for the flag, etc.)
> per inode. When an evicted inode is loaded again, we will use
> is_subdir() to recreate the entry in the inode map.
>
> Does this make sense and address the concern?
>

Yes, that sounds good.

Thanks,
Amir.

