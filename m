Return-Path: <linux-fsdevel+bounces-75258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGVjLkFMc2lDugAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 11:24:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2A27448B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 11:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9306D3006461
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 10:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632CC37AA9C;
	Fri, 23 Jan 2026 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owIHmuiN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C5E21ABBB;
	Fri, 23 Jan 2026 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769163835; cv=none; b=j0EtrwddiQlTQOqcxIgCCYxFUPrAK6B/EPoe346laqwm92k8nEmt00lm7V4Ubidl1yzu85LDpMdcZ/RC6gBTa/7gTKlWLa4SMHv8DEPrSOK+mR1uHu04V6HdEid4AV+scQYRsjwGb/vXUibz7ye4cygdMw3Ttuf3SOItYBvwlEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769163835; c=relaxed/simple;
	bh=EHGi/yi88nJIt6UKAkgHIRx0Y1AOzHWxXOM0POlmDbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stHDXiLBseEI3ehLZ++3jgAY2GVSSUQgIpTD4wIvsdXtuDVsuqW/KnelrmDY/C/VchNDs6MNYyUC4wgX36OIov5B1JVWvs+10j/e0pqj85dFngJ94L1Dx8SgQEKmgTy0csXmgxG5RdU6YrzALexqEMf56ZBrqIOc69MGEjo+50U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owIHmuiN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EB9C4CEF1;
	Fri, 23 Jan 2026 10:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769163834;
	bh=EHGi/yi88nJIt6UKAkgHIRx0Y1AOzHWxXOM0POlmDbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=owIHmuiNnJn6LHl8oiUqHygfDSa6bV+gCvGGfscFbDPXXJnamr7kc99F49u7dqnTB
	 mz2ieEOLcIEm+2lb+SWg5ZY9WmpZ2zvFsmpfwEj09P+14gdzhL7pSaB/XiSY2uhUHr
	 zeAxux5Rm39+ruHliYMWB0Jb0qNo88k/0TtiD3kzIKdcYWKq/V9/KeDM4UszDznIdd
	 w1Zcaq/AacA3FEpb+lEVD0Fj67fFb5BvGIqlLo9C4lWNHQT4NqaK3Qa2WEM3ObijYp
	 WAxdIlthpVFMvzMYM02H+m0Y4+seYt3AfjKGFfo7Vakx/QhhAlUHvxArCBfABl1omB
	 9gbhSP4tNawFg==
Date: Fri, 23 Jan 2026 11:23:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Jeff Layton <jlayton@kernel.org>, Askar Safin <safinaskar@gmail.com>, 
	amir73il@gmail.com, cyphar@cyphar.com, jack@suse.cz, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	Lennart Poettering <mzxreary@0pointer.de>, David Howells <dhowells@redhat.com>, 
	Yunkai Zhang <zhang.yunkai@zte.com.cn>, cgel.zte@gmail.com, Menglong Dong <menglong8.dong@gmail.com>, 
	linux-kernel@vger.kernel.org, initramfs@vger.kernel.org, containers@lists.linux.dev, 
	linux-api@vger.kernel.org, news@phoronix.com, lwn@lwn.net, Jonathan Corbet <corbet@lwn.net>, 
	Rob Landley <rob@landley.net>, emily@redcoat.dev, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/2] mount: add OPEN_TREE_NAMESPACE
Message-ID: <20260123-autofrei-einspannen-7e65a6100e6e@brauner>
References: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
 <20260119171101.3215697-1-safinaskar@gmail.com>
 <CALCETrWs59ss3ZMdTH54p3=E_jiYXq2SWV1fmm+HSvZ1pnBiJw@mail.gmail.com>
 <acb859e1684122e1a73f30115f2389d2c9897251.camel@kernel.org>
 <CALCETrUZC+sdfpVqqjeC_pqmd+-W84Rq7ron8Vx9MaSSohhJ2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrUZC+sdfpVqqjeC_pqmd+-W84Rq7ron8Vx9MaSSohhJ2g@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75258-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,cyphar.com,suse.cz,toxicpanda.com,vger.kernel.org,zeniv.linux.org.uk,0pointer.de,redhat.com,zte.com.cn,lists.linux.dev,phoronix.com,lwn.net,landley.net,redcoat.dev,lst.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F2A27448B
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 10:00:19AM -0800, Andy Lutomirski wrote:
> > On Jan 19, 2026, at 2:21 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >
> > ﻿On Mon, 2026-01-19 at 11:05 -0800, Andy Lutomirski wrote:
> >>> On Mon, Jan 19, 2026 at 10:56 AM Askar Safin <safinaskar@gmail.com> wrote:
> >>>
> >>> Christian Brauner <brauner@kernel.org>:
> >>>> Extend open_tree() with a new OPEN_TREE_NAMESPACE flag. Similar to
> >>>> OPEN_TREE_CLONE only the indicated mount tree is copied. Instead of
> >>>> returning a file descriptor referring to that mount tree
> >>>> OPEN_TREE_NAMESPACE will cause open_tree() to return a file descriptor
> >>>> to a new mount namespace. In that new mount namespace the copied mount
> >>>> tree has been mounted on top of a copy of the real rootfs.
> >>>
> >>> I want to point at security benefits of this.
> >>>
> >>> [[ TL;DR: [1] and [2] are very big changes to how mount namespaces work.
> >>> I like them, and I think they should get wider exposure. ]]
> >>>
> >>> If this patchset ([1]) and [2] both land (they are both in "next" now and
> >>> likely will be submitted to mainline soon) and "nullfs_rootfs" is passed on
> >>> command line, then mount namespace created by open_tree(OPEN_TREE_NAMESPACE) will
> >>> usually contain exactly 2 mounts: nullfs and whatever was passed to
> >>> open_tree(OPEN_TREE_NAMESPACE).
> >>>
> >>> This means that even if attacker somehow is able to unmount its root and
> >>> get access to underlying mounts, then the only underlying thing they will
> >>> get is nullfs.
> >>>
> >>> Also this means that other mounts are not only hidden in new namespace, they
> >>> are fully absent. This prevents attacks discussed here: [3], [4].
> >>>
> >>> Also this means that (assuming we have both [1] and [2] and "nullfs_rootfs"
> >>> is passed), there is no anymore hidden writable mount shared by all containers,
> >>> potentially available to attackers. This is concern raised in [5]:
> >>>
> >>>> You want rootfs to be a NULLFS instead of ramfs. You don't seem to want it to
> >>>> actually _be_ a filesystem. Even with your "fix", containers could communicate
> >>>> with each _other_ through it if it becomes accessible. If a container can get
> >>>> access to an empty initramfs and write into it, it can ask/answer the question
> >>>> "Are there any other containers on this machine running stux24" and then coordinate.
> >>
> >> I think this new OPEN_TREE_NAMESPACE is nifty, but I don't think the
> >> path that gives it sensible behavior should be conditional like this.
> >> Either make it *always* mount on top of nullfs (regardless of boot
> >> options) or find some way to have it actually be the root.  I assume
> >> the latter is challenging for some reason.
> >>
> >
> > I think that's the plan. I suggested the same to Christian last week,
> > and he was amenable to removing the option and just always doing a
> > nullfs_rootfs mount.
> >
> > We think that older runtimes should still "just work" with this scheme.
> > Out of an abundance of caution, we _might_ want a command-line option
> > to make it go back to old way, in case we find some userland stuff that
> > doesn't like this for some reason, but hopefully we won't even need
> > that.
> 
> What I mean is: even if for some reason the kernel is running in a
> mode where the *initial* rootfs is a real fs, I think it would be nice
> for OPEN_TREE_NAMESPACE to use nullfs.

The current patchset makes nullfs unconditional. As each mount
namespaces creates a new copy of the namespace root of the namespace it
was created from all mount namespace have nullfs as namespace root.
So every OPEN_TREE_NAMESPACE/FSMOUNT_NAMESPACE will be mounted on top of
nullfs as we always take the namespace root. If we have to make nullfs
conditional then yes, we could still do that - althoug it would be ugly
in various ways.

I would love to keep nullfs unconditional because it means I can wipe a
whole class of MNT_LOCKED nonsense from the face of the earth
afterwards.

