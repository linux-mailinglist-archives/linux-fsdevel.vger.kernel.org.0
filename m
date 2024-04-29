Return-Path: <linux-fsdevel+bounces-18081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AF08B53E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 11:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA4791C21141
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 09:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6662A20B3D;
	Mon, 29 Apr 2024 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cp7ycruY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A5E17BCB;
	Mon, 29 Apr 2024 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381966; cv=none; b=Rd873q7qpj8g8jqmf82Cum2CQohOugnrzryK0Sv6jp1qj1d2T04F8tj6cYKAoQfA8qhw7wo2v3PfKij/15crYI16plLaa91OKD3+G18JpfEBfYR0maZaDDouLmu4LDDn+yiCqXgv8spBUvqSDu3H9zp7xaDu4PtfGpCApxN9IiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381966; c=relaxed/simple;
	bh=rsGj0P8emcKb8hKu9ORzTWwrGWwZ6ES5DkeLfKwLzQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNKnXpyoMwHy1rS1qjqF3qmogzr5umqgut3SJJNffuDOXZ9ffdszM7mEu065mvXpB8WCaVrds2JoR5Xn5/izgVvBgQ2I+FHRP+6vOR9Rl762MQh9lIp29Gks06OISaV5LK9TEBfSWRvTY9LS47u2qw2CTYGQl1ak9oSQRyqGLmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cp7ycruY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F57C113CD;
	Mon, 29 Apr 2024 09:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714381966;
	bh=rsGj0P8emcKb8hKu9ORzTWwrGWwZ6ES5DkeLfKwLzQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cp7ycruYXV7fRH86kj7Y1D1E71XzyLYhW96Mt5mpFGp/wKKJfCpS4Iq7+wyWRvWwC
	 +HEtCIvs8RAbkpwoZ5vM4kfmJPZbPhr8bSYqd0qO8An0qpq4LlxQtAFQ73FXnmZ+GA
	 Bb+8VZs/7w25/+f7SRxvfzauo5+Ox1LAbeliZssb99mOdHZkjrodD2gkceLydgwnAM
	 X7uKYEwOB7X0jVKIaS0IWaNpo6Vu0CMbjmxIwtxULZR6cmq63p/Yph00iAxC7RsUuA
	 GbP/Pc9koYev24eUXsnzFxcHCMJL7SorHZl2/bE7/AJBRtyuFjHkuvbmfaC46PCpqC
	 tFyxL9uRXRzug==
Date: Mon, 29 Apr 2024 11:12:39 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Stas Sergeev <stsp2@yandex.ru>, Aleksa Sarai <cyphar@cyphar.com>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	Stefan Metzmacher <metze@samba.org>, Eric Biederman <ebiederm@xmission.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, David Laight <David.Laight@aculab.com>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>
Subject: Re: [PATCH v5 0/3] implement OA2_CRED_INHERIT flag for openat2()
Message-ID: <20240429-donnerstag-behilflich-a083311d8e00@brauner>
References: <20240426133310.1159976-1-stsp2@yandex.ru>
 <CALCETrUL3zXAX94CpcQYwj1omwO+=-1Li+J7Bw2kpAw4d7nsyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrUL3zXAX94CpcQYwj1omwO+=-1Li+J7Bw2kpAw4d7nsyw@mail.gmail.com>

On Sun, Apr 28, 2024 at 09:41:20AM -0700, Andy Lutomirski wrote:
> > On Apr 26, 2024, at 6:39 AM, Stas Sergeev <stsp2@yandex.ru> wrote:
> > ﻿This patch-set implements the OA2_CRED_INHERIT flag for openat2() syscall.
> > It is needed to perform an open operation with the creds that were in
> > effect when the dir_fd was opened, if the dir was opened with O_CRED_ALLOW
> > flag. This allows the process to pre-open some dirs and switch eUID
> > (and other UIDs/GIDs) to the less-privileged user, while still retaining
> > the possibility to open/create files within the pre-opened directory set.
> >
> 
> I’ve been contemplating this, and I want to propose a different solution.
> 
> First, the problem Stas is solving is quite narrow and doesn’t
> actually need kernel support: if I want to write a user program that
> sandboxes itself, I have at least three solutions already.  I can make
> a userns and a mountns; I can use landlock; and I can have a separate
> process that brokers filesystem access using SCM_RIGHTS.
> 
> But what if I want to run a container, where the container can access
> a specific host directory, and the contained application is not aware
> of the exact technology being used?  I recently started using
> containers in anger in a production setting, and “anger” was
> definitely the right word: binding part of a filesystem in is
> *miserable*.  Getting the DAC rules right is nasty.  LSMs are worse.

Nowadays it's extremely simple due tue open_tree(OPEN_TREE_CLONE) and
move_mount(). I rewrote the bind-mount logic in systemd based on that
and util-linux uses that as well now.
https://brauner.io/2023/02/28/mounting-into-mount-namespaces.html

> Podman’s “bind,relabel” feature is IMO utterly disgusting.  I think I
> actually gave up on making one of my use cases work on a Fedora
> system.
> 
> Here’s what I wanted to do, logically, in production: pick a host
> directory, pick a host *principal* (UID, GID, label, etc), and have
> the *entire container* access the directory as that principal. This is
> what happens automatically if I run the whole container as a userns
> with only a single UID mapped, but I don’t really want to do that for
> a whole variety and of reasons.

You're describing idmapped mounts for the most part which are upstream
and are used in exactly that way by a lot of userspace.

> 
> So maybe reimagining Stas’ feature a bit can actually solve this
> problem.  Instead of a special dirfd, what if there was a special
> subtree (in the sense of open_tree) that captures a set of creds and
> does all opens inside the subtree using those creds?

That would mean override creds in the VFS layer when accessing a
specific subtree which is a terrible idea imho. Not just because it will
quickly become a potential dos when you do that with a lot of subtrees
it will also have complex interactions with overlayfs.

> 
> This isn’t a fully formed proposal, but I *think* it should be
> generally fairly safe for even an unprivileged user to clone a subtree
> with a specific flag set to do this. Maybe a capability would be
> needed (CAP_CAPTURE_CREDS?), but it would be nice to allow delegating
> this to a daemon if a privilege is needed, and getting the API right
> might be a bit tricky.
> 
> Then two different things could be done:
> 
> 1. The subtree could be used unmounted or via /proc magic links. This
> would be for programs that are aware of this interface.
> 
> 2. The subtree could be mounted, and accessed through the mount would
> use the captured creds.
> 
> (Hmm. What would a new open_tree() pointing at this special subtree do?)
> 
> 
> With all this done, if userspace wired it up, a container user could
> do something like:
> 
> —bind-capture-creds source=dest
> 
> And the contained program would access source *as the user who started
> the container*, and this would just work without relabeling or
> fiddling with owner uids or gids or ACLs, and it would continue to
> work even if the container has multiple dynamically allocated subuids
> mapped (e.g. one for “root” and one for the actual application).
> 
> Bonus points for the ability to revoke the creds in an already opened
> subtree. Or even for the creds to automatically revoke themselves when
> the opener exits (or maybe when a specific cred-pinning fd goes away).
> 
> (This should work for single files as well as for directories.)
> 
> New LSM hooks or extensions of existing hooks might be needed to make
> LSMs comfortable with this.
> 
> What do you all think?

I think the problem you're describing is already mostly solved.

