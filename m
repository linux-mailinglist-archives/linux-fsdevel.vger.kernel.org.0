Return-Path: <linux-fsdevel+bounces-74837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OGJFgrHcGkNZwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 13:31:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC2056CAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 13:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4B653626F73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 10:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2D7480948;
	Wed, 21 Jan 2026 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4ajDx7F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3906B47ECDB;
	Wed, 21 Jan 2026 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768990834; cv=none; b=hoyYihwuuIKG60EME0KrlbOjrHBr0JxgIdShYoxSrEO7MWc6e/5r1zPQ2mzVuOL37ijse4KQaq2wQ+rLWtWdimFHejhHgIpLtJ+cHCyVxv65ARPwf0K3ou8CbM52oTNr0v04VkIpzJidI/+c/xOtpFxfub77mD30j4zBsUBWdQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768990834; c=relaxed/simple;
	bh=U2Ev0TXaflj+aT1UBT+jIiZC2W5iTYJAHnyAlXRvbng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=baQUKe9nuFdw6vYTzlJqxRRBKgR6zDTQ0Vjm2+PB/jX5SfjxIVmupPOEQvybLrgUQtcP24P7zMT6xnML41eNc5geNy1hGxPn2E4Poojao3MaTndkJWWtEJpSTQt/zpu+eYCZ3uBkXMhlPznJR1Gw6wA0DqHFS6G4rWbKc7dJiUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4ajDx7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE659C116D0;
	Wed, 21 Jan 2026 10:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768990832;
	bh=U2Ev0TXaflj+aT1UBT+jIiZC2W5iTYJAHnyAlXRvbng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O4ajDx7FAwf7o9761xxky5kwWVDIQ5wl7zAXBFOIdTzDS//JCREyzB3fgnq0X/kNs
	 DpW4ELpLUT1UNtbxTGifQkoj2r1tmWwJtEdX5A5c4ZHyDkR0+d9Pg99HCGxN9aGNaa
	 QFcjNzAFN8GLfx7SZKyPgKJozILCG82EJFtvDutM7CHj+o4fMtji3CC/tgjOvVSNOe
	 phQpW6meYOO+rnwKPgiPqGblUJwEwyQGmiSHhP3+V3TlUObCVm6U/9gW0RJMMNV8EI
	 jIZVp8En/WDX/Q7rCcWnEUcHtDUG/zXsy+1NwGJbuvUs9Zv5zlAmmKWLNNB9z1UgvF
	 e3Ccs7OdTtRKg==
Date: Wed, 21 Jan 2026 11:20:23 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, 
	Askar Safin <safinaskar@gmail.com>, amir73il@gmail.com, cyphar@cyphar.com, jack@suse.cz, 
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	Lennart Poettering <mzxreary@0pointer.de>, David Howells <dhowells@redhat.com>, 
	Zhang Yunkai <zhang.yunkai@zte.com.cn>, cgel.zte@gmail.com, Menglong Dong <menglong8.dong@gmail.com>, 
	linux-kernel@vger.kernel.org, initramfs@vger.kernel.org, containers@lists.linux.dev, 
	linux-api@vger.kernel.org, news@phoronix.com, lwn@lwn.net, Jonathan Corbet <corbet@lwn.net>, 
	Rob Landley <rob@landley.net>, emily@redcoat.dev, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/2] mount: add OPEN_TREE_NAMESPACE
Message-ID: <20260121-eilverfahren-bohrung-dd89404fbe3b@brauner>
References: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
 <20260119171101.3215697-1-safinaskar@gmail.com>
 <CALCETrWs59ss3ZMdTH54p3=E_jiYXq2SWV1fmm+HSvZ1pnBiJw@mail.gmail.com>
 <acb859e1684122e1a73f30115f2389d2c9897251.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acb859e1684122e1a73f30115f2389d2c9897251.camel@kernel.org>
X-Spamd-Result: default: False [4.04 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74837-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[amacapital.net,gmail.com,cyphar.com,suse.cz,toxicpanda.com,vger.kernel.org,zeniv.linux.org.uk,0pointer.de,redhat.com,zte.com.cn,lists.linux.dev,phoronix.com,lwn.net,landley.net,redcoat.dev,lst.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 2BC2056CAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 19, 2026 at 05:21:30PM -0500, Jeff Layton wrote:
> On Mon, 2026-01-19 at 11:05 -0800, Andy Lutomirski wrote:
> > On Mon, Jan 19, 2026 at 10:56 AM Askar Safin <safinaskar@gmail.com> wrote:
> > > 
> > > Christian Brauner <brauner@kernel.org>:
> > > > Extend open_tree() with a new OPEN_TREE_NAMESPACE flag. Similar to
> > > > OPEN_TREE_CLONE only the indicated mount tree is copied. Instead of
> > > > returning a file descriptor referring to that mount tree
> > > > OPEN_TREE_NAMESPACE will cause open_tree() to return a file descriptor
> > > > to a new mount namespace. In that new mount namespace the copied mount
> > > > tree has been mounted on top of a copy of the real rootfs.
> > > 
> > > I want to point at security benefits of this.
> > > 
> > > [[ TL;DR: [1] and [2] are very big changes to how mount namespaces work.
> > > I like them, and I think they should get wider exposure. ]]
> > > 
> > > If this patchset ([1]) and [2] both land (they are both in "next" now and
> > > likely will be submitted to mainline soon) and "nullfs_rootfs" is passed on
> > > command line, then mount namespace created by open_tree(OPEN_TREE_NAMESPACE) will
> > > usually contain exactly 2 mounts: nullfs and whatever was passed to
> > > open_tree(OPEN_TREE_NAMESPACE).
> > > 
> > > This means that even if attacker somehow is able to unmount its root and
> > > get access to underlying mounts, then the only underlying thing they will
> > > get is nullfs.
> > > 
> > > Also this means that other mounts are not only hidden in new namespace, they
> > > are fully absent. This prevents attacks discussed here: [3], [4].
> > > 
> > > Also this means that (assuming we have both [1] and [2] and "nullfs_rootfs"
> > > is passed), there is no anymore hidden writable mount shared by all containers,
> > > potentially available to attackers. This is concern raised in [5]:
> > > 
> > > > You want rootfs to be a NULLFS instead of ramfs. You don't seem to want it to
> > > > actually _be_ a filesystem. Even with your "fix", containers could communicate
> > > > with each _other_ through it if it becomes accessible. If a container can get
> > > > access to an empty initramfs and write into it, it can ask/answer the question
> > > > "Are there any other containers on this machine running stux24" and then coordinate.
> > 
> > I think this new OPEN_TREE_NAMESPACE is nifty, but I don't think the
> > path that gives it sensible behavior should be conditional like this.
> > Either make it *always* mount on top of nullfs (regardless of boot
> > options) or find some way to have it actually be the root.  I assume
> > the latter is challenging for some reason.
> > 
> 
> I think that's the plan. I suggested the same to Christian last week,
> and he was amenable to removing the option and just always doing a
> nullfs_rootfs mount.

Whether or not the underlying mount is nullfs or not is irrelevant. If
it's not nullfs but a regular tmpfs it works just as well. If it has any
locked overmounts the new rootfs will become locked as well similarly if
it'll be owned by a new userns.

