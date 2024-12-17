Return-Path: <linux-fsdevel+bounces-37571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAC79F3FED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 02:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966FB16AE34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 01:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D6C535B9;
	Tue, 17 Dec 2024 01:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aElMHr4s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A086D171A7;
	Tue, 17 Dec 2024 01:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734398643; cv=none; b=hIUtRZoxb1ghcDamTZpNe6Lt34fueT6rKugqrEePu2cKxzB6FHD6Wq7Kk6FPr98lx1Rr1ZJnC14RjCa+5WfRBGpnLM0Lr5yHhIVUtynYaPqdzgdvMMiYGtl5QELfMW339sgZAzvgM2jL7er3XKJwzkIfDOX5bBItjqd+0445HV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734398643; c=relaxed/simple;
	bh=ofhmVGShGNdwyjd7BpJc1AADRuJkY7WVdcPNtpQBsWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n4Ow6FpTE6x4UfFhjQs2XmbIPtzfPRTMj0+qLUlRvXGW6toGCTWJ2GnEYfvcBmoP3YdRRPT7Llu6qec4r08xzZ9HFXPbgetORXGmPg5BBwFfP94758oKA6OKWzbgz9n3Ml2isXxKw8qSYVNZOWC/niz+AdTmV9t6iZVkLTQMqO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aElMHr4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C82EC4CED3;
	Tue, 17 Dec 2024 01:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734398642;
	bh=ofhmVGShGNdwyjd7BpJc1AADRuJkY7WVdcPNtpQBsWM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aElMHr4sY66+bDiYoy/AjhpShj8J07925VNMdVaBqcx2C1V9HPSD2tVxJdVnRqe/W
	 LbexSiiVZSL/vLsQ5Vq4hwQmbWBDaOLa3XaUZfK/g32alk3j1uxN5bf6lLartaLd30
	 BMtFCYtGwPYGuwsKV1MszDuacpOilQJav22ds7SKByubAkN3nx+cVWTQlk07YhuT6k
	 6rARUR2FTI1plqjeM7MjnfJkwh001dzLzwvSV/+6qrFAjd4lhkA5e1QL3wI3rI6B4R
	 c9p+wAeqhWGUzlEl0V/aYejzFuU8PQ0lPZFBYHKTp98YdUc0R8Tnk2JUD6SKFBEU3a
	 at5l6+WifntNA==
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a777958043so16165185ab.2;
        Mon, 16 Dec 2024 17:24:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUvAdiGyp1VCbjvOW8hE/Kvq0UANlm/XOhsxDBxptmhSLx65xPPX3ldZk0/huGAyREihcW1OtBmINq5WZ6m6i83bKy0wrGp@vger.kernel.org, AJvYcCVHwggLi01lASFCbsPrODnh/KjvmZQk1J2nMQmVxnPHjnnOqbF+E3ZCtL0sBM4JAhN0QkPiqgY8E4SlsA==@vger.kernel.org, AJvYcCVJizqPwP1J0rgDbS4/Ei4VIL6/eiTzw2Qpimd9TVVu9nhMpe8hrPznM8A6NsAQB29hBLtr2/mkBWRChDEk@vger.kernel.org, AJvYcCWSPEzN0N4Wprxhby+H7WM0UXtFk6U08iYs7YjWj/HH+aXulxPDq9O7dpu4SWsa0e8iVNDNCag3bGke@vger.kernel.org, AJvYcCXYcL5qk8uZ9de+Hx4xPxRmvr1uPmnwpgMv7numxQvOTlwJPsW41nhvZEls/P3QJC0Kgkj3K8GKsjLr@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxf9vk8sNyQZyrJOdCtKcGfmkLNNnymxWhp1kHWIBq7nuTpDrN
	nQJQFaKVO5E9S2KEvX6hMmVwXrpRdsCsCIqRSubQbhRnzu4CeF8EGDvavLdTeT8wNGDelK0aKy7
	Mb9DoK8aOW5IWfkto6rOJntsUtik=
X-Google-Smtp-Source: AGHT+IEVYYJzLEubyEn453iO5+jgafEiNUZc7w0TILkZMunsWpJLLDZd/j9MTh/hBkZ9WmAQSXrGTKkjbVrDvxzVuyg=
X-Received: by 2002:a05:6e02:1aaf:b0:3a7:d792:d6ad with SMTP id
 e9e14a558f8ab-3aff8b9a6d8mr134441725ab.22.1734398641410; Mon, 16 Dec 2024
 17:24:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216234308.1326841-1-song@kernel.org> <CAHC9VhSu4gJYWgHqvt7a_C_rr3yaubDdvxtHdw0=3wPdP+QbbA@mail.gmail.com>
In-Reply-To: <CAHC9VhSu4gJYWgHqvt7a_C_rr3yaubDdvxtHdw0=3wPdP+QbbA@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 16 Dec 2024 17:23:50 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4e8xcmZj_qrONSsC8SDrtNaqjeFgPRo=NE9MDiApQkvw@mail.gmail.com>
Message-ID: <CAPhsuW4e8xcmZj_qrONSsC8SDrtNaqjeFgPRo=NE9MDiApQkvw@mail.gmail.com>
Subject: Re: [RFC] lsm: fs: Use i_callback to free i_security in RCU callback
To: Paul Moore <paul@paul-moore.com>
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	willy@infradead.org, corbet@lwn.net, clm@fb.com, josef@toxicpanda.com, 
	dsterba@suse.com, brauner@kernel.org, jack@suse.cz, cem@kernel.org, 
	djwong@kernel.org, jmorris@namei.org, serge@hallyn.com, fdmanana@suse.com, 
	johannes.thumshirn@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

Thanks for your quick review!

On Mon, Dec 16, 2024 at 4:22=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mon, Dec 16, 2024 at 6:43=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > inode->i_security needes to be freed from RCU callback. A rcu_head was
> > added to i_security to call the RCU callback. However, since struct ino=
de
> > already has i_rcu, the extra rcu_head is wasteful. Specifically, when a=
ny
> > LSM uses i_security, a rcu_head (two pointers) is allocated for each
> > inode.
> >
> > Add security_inode_free_rcu() to i_callback to free i_security so that
> > a rcu_head is saved for each inode. Special care are needed for file
> > systems that provide a destroy_inode() callback, but not a free_inode()
> > callback. Specifically, the following logic are added to handle such
> > cases:
> >
> >  - XFS recycles inode after destroy_inode. The inodes are freed from
> >    recycle logic. Let xfs_inode_free_callback() and xfs_inode_alloc()
> >    call security_inode_free_rcu() before freeing the inode.
> >  - Let pipe free inode from a RCU callback.
> >  - Let btrfs-test free inode from a RCU callback.
>
> If I recall correctly, historically the vfs devs have pushed back on
> filesystem specific changes such as this, requiring LSM hooks to
> operate at the VFS layer unless there was absolutely no other choice.
>
> From a LSM perspective I'm also a little concerned that this approach
> is too reliant on individual filesystems doing the right thing with
> respect to LSM hooks which I worry will result in some ugly bugs in
> the future.

Totally agree with the concerns. However, given the savings is quite
significant (saving two pointers per inode), I think the it may justify
the extra effort to maintain the logic. Note that, some LSMs are
enabled in most systems and cannot be easily disabled, so I am
assuming most systems will see the savings.

Thanks,
Song

