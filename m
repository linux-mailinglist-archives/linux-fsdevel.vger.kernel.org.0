Return-Path: <linux-fsdevel+bounces-43165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9591A4EDC7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 20:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD3B3A507C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 19:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C06A1F7060;
	Tue,  4 Mar 2025 19:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="P0gB1Wla"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C55207DF9
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 19:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117725; cv=none; b=rlmVf4mnR81g+ayg9lprxYuKOnT09WKQ65aYgOcMa1vmoMd3pVrv/QFlYvp3QsNJaU5N9Ss3VlLai3PpIn4L8cwHh0iao8SY0wM0XLpQ+7muaoqJEfvdgD+ZzVL0ZdXCQbUbNoth46+Thd855c731FpwgTwHBcNmT6I7Gov/3nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117725; c=relaxed/simple;
	bh=fTKIBqE5U/ZRKszjyM9F6Av4VQOG++IdMyf7qtqJeR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U03vSwnjh1SN+vaf5eQICrXlnyiIHlrjCp9/iCSiRHUmE/a9l9479maE5hf2+QSPbERtGr/EnEfnVVxuvwr3jvSmwlX850+xdvNLwrZjQz2MoYVT1k+KedPrD2mFTqgVZKvF0GsOHgYlxYBWgH/1OgoAwrE+dxFLRoTLZNwZdcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=P0gB1Wla; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z6mSv0Bybzy5l;
	Tue,  4 Mar 2025 20:48:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741117710;
	bh=M9MGc4v2ysWsE8U4uMUf26RbzgZ8kq5cTTfztbXlDjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P0gB1WlaYgzysFqOoW+5d9zYtXM2+znSCdBVdm782TKPPQsdqhUO7h9uVKclXBEBu
	 COU80Dkpyjm+1lkmwdZPGtPzmMOYFVwl8VU0K3t7O68XQBnLArSNpWhJnWRPdxD7fU
	 a5xR1Ck5h7aN7d1ZvA/mRk3/5AdEyvfMk4JQ46lQ=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z6mSs6QQnzNJ6;
	Tue,  4 Mar 2025 20:48:29 +0100 (CET)
Date: Tue, 4 Mar 2025 20:48:29 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>, Jeff Xu <jeffxu@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Francis Laniel <flaniel@linux.microsoft.com>, 
	Matthieu Buffet <matthieu@buffet.re>
Subject: Re: [RFC PATCH 0/9] Landlock supervise: a mechanism for interactive
 permission requests
Message-ID: <20250304.Choo7foe2eoj@digikod.net>
References: <cover.1741047969.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1741047969.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

On Tue, Mar 04, 2025 at 01:12:56AM +0000, Tingmao Wang wrote:
> Landlock supervise: a mechanism for interactive permission requests
> 
> Hi,
> 
> I would like to propose an extension to Landlock to support a "supervisor"
> mode, which would enable a user program to sandbox applications (or
> itself) in a dynamic, fine-grained, and potentially temporary way.
> Practically, this makes it easy to give maximal control to the user,
> perhaps in the form of a "just in time" permission prompt.  Read on, or
> check the sandboxer program in the last patch for a "demo".

Thanks for this RFC, this is very promising!

> 
> To Jan Kara and other fanotify reviewers, I've included you in this patch
> as Mickaël suggested that we could potentially extend and re-use the
> fanotify uapi and code instead of creating an entirely new representation
> for permission requests and mechanism for passing it (as this patch
> currently does).  I've not really thought out how that would work (there
> will probably have to be some extension of the fanotify-fd uapi since
> landlock handles more than FS access), but I think it is a promising idea,
> hence I would like to hear your thoughts if you could spare a moment to
> look at this.  A good outcome could also be that we add the necessary
> hooks so that both this and fanotify (but really fsnotify?) can have _perm
> events for create/delete/rename etc.
> 
> FS mailing list - I've CC'd this patchset to you too - even though the
> patch doesn't currently touch any FS code, this is very FS related, and
> also, in order to address an inode lock related problem which I will
> mention in patch 6 of this series, future versions of this patch will
> likely need to add a few more LSM hooks.  Especially for that part, but
> also other bits of this project, a pair of eyes from the FS community
> would be very helpful.
> 
> To Tycho Andersen -- I'm CC'ing you as you've worked on the seccomp-unotify
> feature which is also quite related, so if you could spare some time for a
> quick review, or provide some suggestions, that would be very appreciated
> :)
> 
> I'm submitting this series as a non-production-ready, proof-of-concept
> RFC, and I would appreciate feedback on any aspects of the design or
> implementation.  Note that due to the PoC nature of this, I have not
> handled checkpatch.pl errors etc.  I also welcome suggestions for
> alternative names for this feature (e.g. landlock-unotify?
> landlock-perm?).  At this point I'm very keen to hear some initial
> feedback from the community before investing further into polishing this
> patch.
> 
> (I've briefly pitched the overall idea to Mickaël, but he has not reviewed
> the patch yet)
> 
> 
> Why extend landlock?
> --------------------
> 
> While this feature could be implemented as its own LSM, I feel like it is
> a natural extension to landlock -- landlock has already defined a set of
> fine-grained access requests with the intention to add more (and not just
> for FS alone), is designed to be an unprivileged, stackable,
> process-scoped, ad-hoc mechanism with no persistent state, which works
> well as a generic API to support a dynamic sandbox, and landlock is
> already doing the path traversal work to evaluate hierarchical filesystem
> rules, which would also be useful for a performant dynamic sandbox
> implementation.

I agree, that would be a great Landlock feature.

> 
> 
> Use cases
> ---------
> 
> I have several potential use cases in mind that will benefit from
> landlock-supervise, for example:
> 
> 1. A patch to firejail (I have not discussed with the firejail maintainers
> on this yet - wanted to see the reception of this kernel patch first)
> which can leverage landlock in a highly flexible way, prompting the user
> for permission to access "extra" files after the sandbox has started
> (without e.g. having to restart a very stateful GUI program).
> 
> This way of using landlock can potentially replace its current approach of
> using bind mounts (as it will allow implementing "blacklists"), allowing
> unprivileged sandbox creation (although need to check with firejail if
> there are other factors preventing this).  This also allows editing
> profiles "live" in a highly interactive way (i.e. the user can choose
> "allow and remember" on a permission request which will also add the newly
> allowed path to a local firejail profile, all automatically)
> 
> 2. A "protected" mode for common development environments (e.g. VSCode or
> a terminal can be launched "protected") that doesn't compromise on
> ease-of-use.  File access to $PWD at launch can be allowed, and access to
> other places can be allowed ad-hoc by the developer with hopefully one UI
> click.  Since landlock can also be used to restrict network access, such a
> protected mode can also restrict outgoing connections by default (but ask
> the user if they allow it for all or certain processes, on the first
> attempt to connect).
> 
> Recently there has been incidents of secret-stealing malware targeting
> developers (on Linux) by social engineering them to open and build/run a
> project. [1]  The hope is that landlock-supervise can drive adoption of
> sandboxes for developers and others by making them more user-friendly.
> 
> In addition to the above, I also hope that this would help with landlock
> adoption even in non-interaction-heavy scenarios, by allowing application
> developers the choice to gracefully recover from over-restrictive rulesets
> and collect failure metrics, until they are confident that actually
> blocking non-allowed accesses would not break their application or degrade
> the user experience.

Another interesting use case is to trace programs and get an
unprivileged "permissive" mode to quickly create sandbox policies.

> 
> I have more exploration to do regarding applying this to applications, but
> I do have a working proof of concept already (implemented as an
> enhancement to the sandboxer example). Here is a shortened output:
> 
>     bash # env LL_FS_RO=/usr:/lib:/bin:/etc:/dev:/proc LL_FS_RW= LL_SUPERVISE=1 ./sandboxer bash -i
>     bash # echo "Hi, $(whoami)!"
>     Hi, root!
>     bash # ls /
>     ------------- Sandboxer access request -------------
>     Process ls[166] (/usr/bin/ls) wants to read
>       /
>     (y)es/(a)lways/(n)o > y
>     ----------------------------------------------------
>     bin
>     boot
>     dev
>     ...
>     usr
>     var
>     bash # echo 'evil' >> /etc/profile
>     (a spurious create request due to current issue with dcache miss is omitted)
>     ------------- Sandboxer access request -------------
>     Process bash[163] (/usr/bin/bash) wants to read/write
>       /etc/profile
>     (y)es/(a)lways/(n)o > n
>     ----------------------------------------------------
>     bash: /etc/profile: Permission denied
>     bash #
> 
> 
> Alternatives
> ------------
> 
> I have looked for existing ways to implement the proposed use cases (at
> least for FS access), and three main approaches stand out to me:
> 
> 1. Fanotify: there is already FAM_OPEN_PERM which waits for an allow/deny
> response from a fanotify listener.  However, it does not currently have
> the equivalent _PERM for file creation, deletion, rename and linking, and
> it is also not designed for unprivileged, process-scoped use (unlike
> landlock).

As discussed, I was thinking about whether or not it would be possible
to use the fanotify interface (e.g. fanotify_init(), fanotify FD...),
but looking at your code, I think it would mostly increase complexity.
There are also the issue with the Landlock semantic (e.g. access rights)
which does not map 1:1 to the fanotify one.  A last thing is that
fanotify is deeply tied to the VFS.  So, unless someone has a better
idea, let's continue with your approach.

> 
> 2. Seccomp-unotify: this can be used to trap all syscalls and give the
> sandbox a chance to allow or deny any one of them. However, a correct,
> TOCTOU-proof implementation will likely require handling a large number of
> fs-related syscalls in user-space, with the sandboxer opening the file or
> carrying out the operation on behalf of the sandboxee.  This is probably
> going to be extremely complex and makes everything less performant.

We should get inspiration from the fanotify and seccomp-notify features
(while implementing the minimum for now) but also identify their design
issues and caveats.

Tycho, Christian, Kees, any suggestion?

> 
> 3. Using a FUSE filesystem which gates access.  This is actually an
> approach taken by an existing sandbox solution - flatpak [2], however it
> requires either tight integration with the application (and thus doesn't
> work well for the mentioned use cases), or if one wants to sandbox a
> program "transparently", SYS_ADMIN to chroot.

Android's SDCardFS is another example of such use.

> 
> 
> I've tested that what I have here works with the enhanced sandboxer, but
> have yet to write any self tests or do extensive testing or perf
> measurements.  I have also yet to implement support for supervising tcp
> rules as well as FS refer operations.

One of the main suggestion would be to align with the audit patch series
semantic and the defined "blockers":
https://lore.kernel.org/all/20250131163059.1139617-1-mic@digikod.net/
I'll send another series soon.

> 
> Base commit: 78332fdb956f18accfbca5993b10c5ed69f00a2c (tag:
> landlock-6.14-rc5, mic/next)
> 
> 
> [1]: https://cybersecuritynews.com/beware-of-lazarus-linkedin-recruiting-scam/
> [2]: https://flatpak.github.io/xdg-desktop-portal/docs/documents-and-fuse.html
> 
> 
> Tingmao Wang (9):
>   Define the supervisor and event structure
>   Refactor per-layer information in rulesets and rules
>   Adds a supervisor reference in the per-layer information
>   User-space API for creating a supervisor-fd
>   Define user structure for events and responses.
>   Creating supervisor events for filesystem operations
>   Implement fdinfo for ruleset and supervisor fd
>   Implement fops for supervisor-fd
>   Enhance the sandboxer example to support landlock-supervise
> 
>  include/uapi/linux/landlock.h | 119 ++++++
>  samples/landlock/sandboxer.c  | 759 +++++++++++++++++++++++++++++++++-
>  security/landlock/Makefile    |   2 +-
>  security/landlock/fs.c        | 134 +++++-
>  security/landlock/ruleset.c   |  49 ++-
>  security/landlock/ruleset.h   |  66 +--
>  security/landlock/supervise.c | 194 +++++++++
>  security/landlock/supervise.h | 171 ++++++++
>  security/landlock/syscalls.c  | 621 +++++++++++++++++++++++++++-
>  9 files changed, 2036 insertions(+), 79 deletions(-)
>  create mode 100644 security/landlock/supervise.c
>  create mode 100644 security/landlock/supervise.h
> 
> --
> 2.39.5
> 

