Return-Path: <linux-fsdevel+bounces-37654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6969F55B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 19:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B797B1885AAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 18:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8A11F8926;
	Tue, 17 Dec 2024 18:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfkamHIt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D5A13EFF3;
	Tue, 17 Dec 2024 18:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734458961; cv=none; b=fyO8o2kMYPmaDJLhZDopUOCTAwcXo6C+df7V1r3Z8h0QA11Xfv6cRqQzB3MpBXZgphxxDNkviw3mKZtSLoLNlkUdYlg+rpZh7l7HECQH9zzIC7MOm+BY+bIJQanWT/SONSZD8FxpQcTIltHmt6ClFr4o9gyDbIj/q29ULXRKoJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734458961; c=relaxed/simple;
	bh=a0hlx5/pHxIzM2xHkTzHsnN+2QIObRRbFkXEgYCKa/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPXlcHEIwhqmITjm2ASbcejBKa8I2vmhDQ6sgKQs+D16+Qkb0gxz3Z0yWh3z2hxytEdkdLxT/GXvzCClxFMsQIZqlo6nHd4HmBZ0IKNQNYdLLGjW5CgjYECyFQJr0k6LMjhI2Z0XWaFIWpWfrUk46TygrKquC4nkUC+jceOuyns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfkamHIt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4206DC4CEDE;
	Tue, 17 Dec 2024 18:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734458961;
	bh=a0hlx5/pHxIzM2xHkTzHsnN+2QIObRRbFkXEgYCKa/Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AfkamHItEv2Kv4B47kjICPEFxA8LMnxFzXGzY0y4a8Vnd2zJFlhZ+6LxpvLezSTCW
	 mDUEMYFOLLDxU4YpPfRQp6C1qGEy/3FQh3oJhEIIKc4iJvtruQzFrak3vmyW2qPvAG
	 PQTxSvO+4uHpznpbUGWDObHik+N1dEzLaNNGA7f96nA6A3VKpobqGYQyLIy92zNcir
	 TJDxIREO975BfCjxJ+krxVVtFwRMxa8TJyOOcEAAfcxhb+Q+b7ZFvoE2DG9ShoZqST
	 zKDCSTuNxXGdFQwEsE2g29ulogVmG8fsp4ZqQLfTwSmtMfB4jeBLrKWRG0jSPF7usn
	 bcyd3nXVjeE3A==
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a9caa3726fso18452485ab.1;
        Tue, 17 Dec 2024 10:09:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUgYBmOlfPAuBFyFnawDxVHYMn9PD9KMEkYgHzNX+CgwHpTIxaK4bPAPmQdlC0tx+/vhgZZlZBv3lTIUky+vYgLuUD5eBhB@vger.kernel.org, AJvYcCVH+8+cZlbpPRbsLfct6JOYMTkd6IlpvnOY/U4O+QdxkQppaTIXsHJb8vdU6QHXuaxRD5gmqg8qCAa4ew==@vger.kernel.org, AJvYcCVXL2xVYESaEGmnnEj2lQTkb5UWlL7t0UDYWJbiWTmA5fc5BGVCheyqqXVn3ukv0ney02sQpiPdfqzO76UT@vger.kernel.org, AJvYcCWzPVkjaIkoYoEv5m6lpkJVx1IiNZQqvBQU5IdUbvRW9dx9gNpN5y4j24H13pqOFE4s2IGLm5BSIAMq@vger.kernel.org, AJvYcCXhJvZJJ58ue4xonoDcgyYH7IbFmZGH9G1f/F7EQ2P7axY5PzEcxmDBVKIjkT5UguazzBotd7xo3Agw@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/T5Giap+D3tdegWYaKlV7gQPXQa3lMzEqOKkIF/kMJS8f7l7u
	grBYEhRTrnCBQSHteAYhwqdmZNrBtooZdmlrSX+xRUPbVdAmwqAdHkTcUSrljv8sGX581Ho/n5i
	GJVS548SU2gdjoOTGnfZZJLnfhaM=
X-Google-Smtp-Source: AGHT+IH4W+1qLYUv3RvMLLz4Rx3+PmbSk6FECj6Mjc1///iWLUROmvsJBNQ/+N1FqaQqBL2aHE0lswGQnxFBZ28aMoQ=
X-Received: by 2002:a05:6e02:1a0a:b0:3a7:e956:13fc with SMTP id
 e9e14a558f8ab-3bb0884d912mr37251375ab.5.1734458960607; Tue, 17 Dec 2024
 10:09:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216234308.1326841-1-song@kernel.org> <CAHC9VhSu4gJYWgHqvt7a_C_rr3yaubDdvxtHdw0=3wPdP+QbbA@mail.gmail.com>
 <CAPhsuW4e8xcmZj_qrONSsC8SDrtNaqjeFgPRo=NE9MDiApQkvw@mail.gmail.com> <CAHC9VhQgS1n5RJxFmVxohng9UL_Wi6x_0MOaPAeiFTFsUxZd0A@mail.gmail.com>
In-Reply-To: <CAHC9VhQgS1n5RJxFmVxohng9UL_Wi6x_0MOaPAeiFTFsUxZd0A@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 17 Dec 2024 10:09:09 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6h4c-kkXaRYiVuhx20ZVM0z2LC7+x66=mEG-wc8xDugA@mail.gmail.com>
Message-ID: <CAPhsuW6h4c-kkXaRYiVuhx20ZVM0z2LC7+x66=mEG-wc8xDugA@mail.gmail.com>
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

On Tue, Dec 17, 2024 at 8:44=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mon, Dec 16, 2024 at 8:24=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> > On Mon, Dec 16, 2024 at 4:22=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > On Mon, Dec 16, 2024 at 6:43=E2=80=AFPM Song Liu <song@kernel.org> wr=
ote:
> > > >
> > > > inode->i_security needes to be freed from RCU callback. A rcu_head =
was
> > > > added to i_security to call the RCU callback. However, since struct=
 inode
> > > > already has i_rcu, the extra rcu_head is wasteful. Specifically, wh=
en any
> > > > LSM uses i_security, a rcu_head (two pointers) is allocated for eac=
h
> > > > inode.
> > > >
> > > > Add security_inode_free_rcu() to i_callback to free i_security so t=
hat
> > > > a rcu_head is saved for each inode. Special care are needed for fil=
e
> > > > systems that provide a destroy_inode() callback, but not a free_ino=
de()
> > > > callback. Specifically, the following logic are added to handle suc=
h
> > > > cases:
> > > >
> > > >  - XFS recycles inode after destroy_inode. The inodes are freed fro=
m
> > > >    recycle logic. Let xfs_inode_free_callback() and xfs_inode_alloc=
()
> > > >    call security_inode_free_rcu() before freeing the inode.
> > > >  - Let pipe free inode from a RCU callback.
> > > >  - Let btrfs-test free inode from a RCU callback.
> > >
> > > If I recall correctly, historically the vfs devs have pushed back on
> > > filesystem specific changes such as this, requiring LSM hooks to
> > > operate at the VFS layer unless there was absolutely no other choice.
> > >
> > > From a LSM perspective I'm also a little concerned that this approach
> > > is too reliant on individual filesystems doing the right thing with
> > > respect to LSM hooks which I worry will result in some ugly bugs in
> > > the future.
> >
> > Totally agree with the concerns. However, given the savings is quite
> > significant (saving two pointers per inode), I think the it may justify
> > the extra effort to maintain the logic. Note that, some LSMs are
> > enabled in most systems and cannot be easily disabled, so I am
> > assuming most systems will see the savings.
>
> I suggest trying to find a solution that is not as fragile in the face
> of cross subsystem changes and ideally also limits the number of times
> the LSM calls must be made in individual filesystems.

There are three (groups of) subsystems here: VFS, file systems, and
LSM. It is not really possible to do this without crossing subsystem
boundaries. Specifically, since VFS allow a file system to have
destroy_inode callback, but not free_inode callback, we will need
such file systems to handle rcu callback. Does this make sense?

Suggestions on how we can solve this better are always appreciated.

Thanks,
Song

