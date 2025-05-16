Return-Path: <linux-fsdevel+bounces-49267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF351AB9E94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 16:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D561BC06F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 14:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A77019066D;
	Fri, 16 May 2025 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hhc/9xcx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E07153BED
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747405615; cv=none; b=Wn35lFvgaWjTHVzfElQN4pN9iwbeiq9C2MCM2X+WJalSRogef+uZvoZVevtkjDlb5D4X6hxNKMTRmgyUd1WTSPjp1oBvftu/CMWa6cUthE8LGKMmQlDrZcx1K9XYg5b7pH7+YGhfoseJXsNdqu+k3Lk9mJvzi6sQEIiN0H+mq7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747405615; c=relaxed/simple;
	bh=Eh5c2xr0pu/hCxt33C2EDeEgENtBc+GEy++6jWlMI28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YhuLhBjgtJk8boJ24BdXNfl4R+KJ4NlxWkYHl4tDNVP4Pb9x18xVPzK5e7J/x4PNI0ToNkUeWrVCQ6EMnXMuErSg6IvL8Ab0OOkglWQfIqTml9o4vcCioErY1dAEHEatgJY0gvSs4fPuvISot0Gwhs3InfPaK7t0U4p0BgXODyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hhc/9xcx; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso9579a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 07:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747405612; x=1748010412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TW2usedpCNxwKQj9PAnce7ll5JLOZm+QyDbRJAliss=;
        b=Hhc/9xcxSSbx3GDgNc9dneOmlYSkIg8xeF6VxNQYbe/3Dseg1+DICB+/K+6LbroeYN
         Jwlxe2TiiAjauMAotU4ATWTbeRB27dPzYRU7hrgrwcNGKfYLSk2v/2AqiOP0wlgQLH1l
         isblp4E8GcaIKn6v3EphrefmrrAfzSvNE9H42rS9M+MhBINpP6oqlQ5V0AUsLi6oeg+5
         ia9HuO4luTBX6ePpDywjK/rlW34g5+c6lPLS2BoDtrUqqfDjmrBFfFC77g1sV5K6M7qK
         YRmuCqOkpjxGDvLFe+YKDDK2ZBslRhhOi2QhIGt0xNWAcBrkbDpSjjIvRv9LjmNThhtE
         QIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747405612; x=1748010412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TW2usedpCNxwKQj9PAnce7ll5JLOZm+QyDbRJAliss=;
        b=r77kL8EGPyQpzec0VT065mbFfbPErMustNsJl6G6SwXUC9/chgvM6FUcJaCO8uGs7R
         HlzIKgn6oF1ole8Qul987XCI27Us4LzrTwS6FYzcJZf/LsDnbMifhBiGndY+4EqWx+Fu
         71B16INz4kr9si/6LQMgQfbOn7dN9xjkQTHMDE75U5bU+w+zzZQ/Duv/F8KLHJcG0APi
         XSDPFwH/8lNUxj98l8zLtUI9Dw0UlFFWHvTzb9Jf7f1Gd/p1JVDkI2j5rd1Wlt9m2EJ+
         ZBDCuw30tG3PCzatb0OiitsKqt/rNY7vut+NQhzp7ocOdxflYCj9hM4jSvuqxoEURszn
         6lpw==
X-Gm-Message-State: AOJu0Ywsdi4w3Uo6wiSDoihPeuq+IjDDY0bw0MhzS49/kqqImZ2GRnAQ
	62DLpiW4+olhsNSBMtENgF3dPY/Ged3WOl1lOnxKmYioTSbSPn4lutzwkeOK0ecAb6wcOyFsF3Q
	RjnWbHB2tIbMDXI8zIBHrpx22jDKkmNm1wJcDQh1Z
X-Gm-Gg: ASbGncv0EVIMTcqOyixPRpvYjioExEX70dO5Jf8JJ046jJyasnWurqo+8xXSQf+00GK
	CRlXGQTHV5et32SAtdRSLSful+JgFBwGL114wC3P+Qvs/GpIyQf0nURyFfQa0bAcXUgy1vLVPzZ
	qF2mOWt2KO+uww6/sAwZfr8+sP8kYUWhF9Ywx1ZSMuDISEKs7hlNPvI8JxKgK3Y7XG0iUt29g=
X-Google-Smtp-Source: AGHT+IEoixv1nvj/joKDjJhlioT6X26vzlEa04kXEcwn2gFbmDxDKWuYmqehfw7+lEN8BOykH+BXZgwX0xoGd6DK8jM=
X-Received: by 2002:a50:fa8e:0:b0:600:77b:5a5a with SMTP id
 4fb4d7f45d1cf-600077b6b0dmr174931a12.1.1747405611676; Fri, 16 May 2025
 07:26:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org>
 <20250515-work-coredump-socket-v7-5-0a1329496c31@kernel.org>
 <CAG48ez3-=B1aTftz0srNjV7_t6QqGuk41LFAe6_qeXtXWL3+PA@mail.gmail.com> <20250516-anfliegen-mausklick-adf097dad304@brauner>
In-Reply-To: <20250516-anfliegen-mausklick-adf097dad304@brauner>
From: Jann Horn <jannh@google.com>
Date: Fri, 16 May 2025 16:26:15 +0200
X-Gm-Features: AX0GCFuYL6R9fj9izViFlrORHz9TS4NOydZZFRJC1vcmieDqi7P8IRY8nJotD-E
Message-ID: <CAG48ez3i-QGb_b_Mo50rN-kROPh1vrZhr06sGkb1BYzmRDvffw@mail.gmail.com>
Subject: Re: [PATCH v7 5/9] pidfs, coredump: add PIDFD_INFO_COREDUMP
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 12:34=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
> On Thu, May 15, 2025 at 10:56:26PM +0200, Jann Horn wrote:
> > Why can we safely put the pidfs reference now but couldn't do it
> > before the kernel_connect()? Does the kernel_connect() look up this
> > pidfs entry by calling something like pidfs_alloc_file()? Or does that
> > only happen later on, when the peer does getsockopt(SO_PEERPIDFD)?
>
> AF_UNIX sockets support SO_PEERPIDFD as you know. Users such as dbus or
> systemd want to be able to retrieve a pidfd for the peer even if the
> peer has already been reaped. To support this AF_UNIX ensures that when
> the peer credentials are set up (connect(), listen()) the corresponding
> @pid will also be registered in pidfs. This ensures that exit
> information is stored in the inode if we hand out a pidfd for a reaped
> task. IOW, we only hand out pidfds for reaped task if at the time of
> reaping a pidfs entry existed for it.
>
> Since we're setting coredump information on the pidfd here we're calling
> pidfs_register_pid() even before connect() sets up the peer credentials
> so we're sure that the coredump information is stored in the inode.
>
> Then we delay our pidfs_put_pid() call until the connect() took it's own
> reference and thus continues pinning the inode. IOW, connect() will also
> call pidfs_register_pid() but it will ofc just increment the reference
> count ensuring that our pidfs_put_pid() doesn't drop the inode.

Aah, so the call graph looks like this:

unix_stream_connect
  prepare_peercred
    pidfs_register_pid
      [pidfs reference taken]
  [point of no return]
  init_peercred
    [copies creds to socket, moving ref ownership]
  copy_peercred
    [copies creds from socket to peer socket, taking refs]

Thanks for explaining!

