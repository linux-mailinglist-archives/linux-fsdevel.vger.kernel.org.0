Return-Path: <linux-fsdevel+bounces-33966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B589C1012
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 21:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A1E1F24A17
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 20:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC0B218335;
	Thu,  7 Nov 2024 20:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVvisrl6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D58A21767A;
	Thu,  7 Nov 2024 20:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731012510; cv=none; b=BT+UnJ9FVMlfJGmGUW412JZaZlEqBPM1PZ1zfcpm0dvrXbB69ZpWuQ7g+9pE1DZMHaQb9kSDd4Bh1IiCK0qlrAamFbGDx3Ls+7DPWqNNZo4SdiNwDQeH9kKiggFZfJdX+OYzIi6KYKIfJ8409lBF//rfc6i1Z9kXuvviSEnyEoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731012510; c=relaxed/simple;
	bh=y9ltngknyXq1fz4Y7W2Ca75b+QbCA+GGQXGYjflLdMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dfNM7ozufwJSGdBphlfhLMqjwLqW1akywoanmvflMhL7IxSgp8RPDwkzzLgfWM9dZbM11Fk7WAHRv89odXn/fF4rlO7ph4jFZNBcS4kU+iNWLylMKYz/xCbyJFSpxzRU28gBLT1ZHuHtEd8/i1/ync3nB1yF5BlFrrNU2EnlU7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVvisrl6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F056C4CED5;
	Thu,  7 Nov 2024 20:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731012510;
	bh=y9ltngknyXq1fz4Y7W2Ca75b+QbCA+GGQXGYjflLdMs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lVvisrl6OQW4rjtbDuwJrRGYSGzueLcHl0o5fLJlG4becB776moohV1bSePD1nPHW
	 1IbKY6UG3mXwlnpjdYS6vHGmuhkbMue5hQQGt0bSzAK0FqcNcAXXMysqXxiwliqsiH
	 wYitf6lWrg/wZN5vZLzbIlQLlHySU5POGyPrqvszoXPBtJ+EN3/nF6Huwt4usSw99k
	 ElfUPcOYH8CeWp/3AO0YZgNhe8v/fQ+jHkELcSNv6MNUsULIaJJVZ2oH1qMrIiPjjI
	 x2nK2gVo6GZQU4jv5CPMpUZMjs7TB+padEwdHoZLQjx+qUaQMP8Vhc9ESq2dwH2FGZ
	 1UG1eYbnMM3zA==
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a4e5401636so5200805ab.3;
        Thu, 07 Nov 2024 12:48:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUd33DOz7GOW3yQehrk5BlEkd6IcVU4GMGhUJI8LJ3a/nzlcZxqPH1XnwmLdGterr0J8OQLBKuErrtWwh4yTg==@vger.kernel.org, AJvYcCVOpHAwEblzUSNUkHgESdSYOSu4BsrivDkgQKEkoKM7e+CksNoEIsilgQIFHoN6CtdbsIVOvR2IH7Qu+Kxq@vger.kernel.org, AJvYcCVlzW1WwVlMCAumUci5QFBArfNA+eQKWRO+ZkAn5xMDzFX8w6EovH7Ornr/bmN+v0tdFFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa9zzvXwY9otgqv37FZZ95pBn13i4k+VKoe1FzUzBFZ0Yc25ra
	OcxYJ2VrIb6G356CGD2TMcyCHD4ZeWYnbbl3araOnYaqVSduu5hgAO5r9evqy/hjgarSbYe1c0I
	C60q5CNn6SZjcNchE8Gz4a5AX6RI=
X-Google-Smtp-Source: AGHT+IHLFH4HkA2BX3jpkzky5zkNJnDwztWt7CrvKGXG2OltdSi2Wx3JazSli34TEm/RKHrljQ3LzBD8tb6hMEt81R4=
X-Received: by 2002:a05:6e02:178d:b0:3a0:92b1:ec4c with SMTP id
 e9e14a558f8ab-3a6f1a75af6mr6399555ab.23.1731012509550; Thu, 07 Nov 2024
 12:48:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029231244.2834368-1-song@kernel.org> <20241029231244.2834368-6-song@kernel.org>
 <CAOQ4uxjDudLwKuxXaFihdYJUv2yvwkETouP9zJtJ6bRSpmV-Kw@mail.gmail.com>
 <DAAF8ED0-42E2-4CC6-842D-589DF6162B90@fb.com> <CAOQ4uxgJiUfO4RL-xYmfRTz7f5m-niLG10xeCGazuk7nuiBhqw@mail.gmail.com>
In-Reply-To: <CAOQ4uxgJiUfO4RL-xYmfRTz7f5m-niLG10xeCGazuk7nuiBhqw@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Thu, 7 Nov 2024 12:48:16 -0800
X-Gmail-Original-Message-ID: <CAPhsuW71hKC1G9jayVqmAMFu+kPOibWC9xqdMj9tLmCcteQuEQ@mail.gmail.com>
Message-ID: <CAPhsuW71hKC1G9jayVqmAMFu+kPOibWC9xqdMj9tLmCcteQuEQ@mail.gmail.com>
Subject: Re: [RFC bpf-next fanotify 5/5] selftests/bpf: Add test for BPF based
 fanotify fastpath handler
To: Amir Goldstein <amir73il@gmail.com>
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

On Thu, Nov 7, 2024 at 12:34=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Thu, Nov 7, 2024 at 8:53=E2=80=AFPM Song Liu <songliubraving@meta.com>=
 wrote:
> >
> >
> >
> > > On Nov 7, 2024, at 3:10=E2=80=AFAM, Amir Goldstein <amir73il@gmail.co=
m> wrote:
> > >
> > > On Wed, Oct 30, 2024 at 12:13=E2=80=AFAM Song Liu <song@kernel.org> w=
rote:
> > >>
> > >> This test shows a simplified logic that monitors a subtree. This is
> > >> simplified as it doesn't handle all the scenarios, such as:
> > >>
> > >>  1) moving a subsubtree into/outof the being monitoring subtree;
> > >
> > > There is a solution for that (see below)
> > >
> > >>  2) mount point inside the being monitored subtree
> > >
> > > For that we will need to add the MOUNT/UNMOUNT/MOVE_MOUNT events,
> > > but those have been requested by userspace anyway.
> > >
> > >>
> > >> Therefore, this is not to show a way to reliably monitor a subtree.
> > >> Instead, this is to test the functionalities of bpf based fastpath.
> > >> To really monitor a subtree reliably, we will need more complex logi=
c.
> > >
> > > Actually, this example is the foundation of my vision for efficient a=
nd race
> > > free subtree filtering:
> > >
> > > 1. The inode map is to be treated as a cache for the is_subdir() quer=
y
> >
> > Using is_subdir() as the truth and managing the cache in inode map seem=
s
> > promising to me.
> >
> > > 2. Cache entries can also have a "distance from root" (i.e. depth) va=
lue
> > > 3. Each unknown queried path can call is_subdir() and populate the ca=
che
> > >    entries for all ancestors
> > > 4. The cache/map size should be limited and when limit is reached,
> > >    evicting entries by depth priority makes sense
> > > 5. A rename event for a directory whose inode is in the map and whose
> > >   new parent is not in the map or has a different value than old pare=
nt
> > >   needs to invalidate the entire map
> > > 6. fast_path also needs a hook from inode evict to clear cache entrie=
s
> >
> > The inode map is physically attached to the inode itself. So the evict
> > event is automatically handled. IOW, an inode's entry in the inode map
> > is automatically removed when the inode is freed. For the same reason,
> > we don't need to set a limit in map size and add evicting logic. Of
> > course, this works based on the assumption that we don't use too much
> > memory for each inode. I think this assumption is true.
>
> Oh no, it is definitely wrong each inode is around 1K and this was the
> main incentive to implement FAN_MARK_EVICTABLE and
> FAN_MARK_FILESYSTEK in the first place, because recursive
> pinning of all inodes in a large tree is not scalable to large trees.

The inode map does not pin the inode in memory. The inode will
still be evicted as normal. The entry associated with the being
evicted inode in the map will be freed together as the inoide is freed.
The overhead I mentioned was the extra few bytes (for the flag, etc.)
per inode. When an evicted inode is loaded again, we will use
is_subdir() to recreate the entry in the inode map.

Does this make sense and address the concern?

Thanks,
Song

