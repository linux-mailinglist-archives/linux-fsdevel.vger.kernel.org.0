Return-Path: <linux-fsdevel+bounces-77978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCaTBrSBnGnaIgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 17:35:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CEF179DED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 17:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C517309A41B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 16:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFBF311C22;
	Mon, 23 Feb 2026 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTtXnrul"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D93C30FC2E;
	Mon, 23 Feb 2026 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864052; cv=none; b=JqOgCqmYyjX8/w7Sjg0Z+6iMQgnZa/1Fb5RSHDDh4cZFxovGSodxonTrFxaQY83HjYHKG1ty6mBGdlI5jbV3zvzyTzWnswfx5FLCIgdvtAIhwwFJGSeMuWJWNo1ZCk/+2b2V6EJuz2Sgd3AhBDUil2qyToszR6MfAZgUO1wztmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864052; c=relaxed/simple;
	bh=lE9B6+H9HeJSppu/EN5YwZOLzN80IR/3aJG1alsniHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyn3OoiwG54VbnSI601CZaGT7LNghRs5la9bBaD62f9GZaNMX2G1QHj1rceViIKgDJwwl+2tlRVch/O3eVYJJl8Iw4Y19EbXV2WFGxPrbwsEucHi8B9Hy9EDKby42RKiuSeJPwkK+Ic7QuunZZ3RM7iJKRvqG6zVu8PoLJL/R+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTtXnrul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EBAC116C6;
	Mon, 23 Feb 2026 16:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771864052;
	bh=lE9B6+H9HeJSppu/EN5YwZOLzN80IR/3aJG1alsniHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZTtXnrulLOI8zAjoZ46Ozt1xST1Zn9e5Pu0lemviHRUGhPwJBJBDsdLaZG0Drf9ry
	 oaNXof1lbmtSzHF/0UdVFKILUr4xtPeJnAh0VmRfPaJrFPQDJIuFIUmLC/xrJdzAZ5
	 TDkN77sp8+8kdnF6qAjh/1hLiT0pTn3s5QamaK0uX/XZi+ClkhpPjEbMZtgxAGSh3Z
	 3oZQl1xN0vI0mxUbxevg/g6lqzMKtSC8zGUtpi2JM+tm0VuHspdH8vi/dFXL75HBny
	 vqCmbhCYblIPptQdi4ZsEJ8x/GyVPXFRZz/IuXNOFdHtc0s5VC0Kqafn9XiU62q7W2
	 XEQaCNDir2iIA==
Date: Mon, 23 Feb 2026 06:27:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: "T.J. Mercier" <tjmercier@google.com>, gregkh@linuxfoundation.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	jack@suse.cz, shuah@kernel.org, linux-kselftest@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 2/3] kernfs: Send IN_DELETE_SELF and IN_IGNORED
Message-ID: <aZx_8_rJNPF2EYgn@slm.duckdns.org>
References: <20260220055449.3073-1-tjmercier@google.com>
 <20260220055449.3073-3-tjmercier@google.com>
 <aZh-orwoaeAh52Bf@slm.duckdns.org>
 <CAOQ4uxjgXa1q-8-ajSBwza-Tkv91tFP-_wWzCQPW+PwJMehEWA@mail.gmail.com>
 <aZi6_K-pSRwAe7F5@slm.duckdns.org>
 <CAOQ4uxjZZSRBwZ2ZL31juAUu0-sAUnPrJWvQuJ2NDaWZMeq0Fg@mail.gmail.com>
 <aZju-GFHf8Eez-07@slm.duckdns.org>
 <CAOQ4uxgzuxaLt2xs5a5snu9CBA_4esQ_+t0Wb6CX4M5OqM5AOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgzuxaLt2xs5a5snu9CBA_4esQ_+t0Wb6CX4M5OqM5AOA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77978-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 34CEF179DED
X-Rspamd-Action: no action

(cc'ing Christian Brauner)

On Sat, Feb 21, 2026 at 06:11:28PM +0200, Amir Goldstein wrote:
> On Sat, Feb 21, 2026 at 12:32 AM Tejun Heo <tj@kernel.org> wrote:
> >
> > Hello, Amir.
> >
> > On Fri, Feb 20, 2026 at 10:11:15PM +0200, Amir Goldstein wrote:
> > > > Yeah, that can be useful. For cgroupfs, there would probably need to be a
> > > > way to scope it so that it can be used on delegation boundaries too (which
> > > > we can require to coincide with cgroup NS boundaries).
> > >
> > > I have no idea what the above means.
> > > I could ask Gemini or you and I prefer the latter ;)
> >
> > Ah, you chose wrong. :)
> >
> > > What are delegation boundaries and NFS boundaries in this context?
> >
> > cgroup delegation is giving control of a subtree to someone else:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/tree/Documentation/admin-guide/cgroup-v2.rst#n537
> >
> > There's an old way of doing it by changing perms on some files and new way
> > using cgroup namespace.
> >
> > > > Would it be possible to make FAN_MNT_ATTACH work for that?
> > >
> > > FAN_MNT_ATTACH is an event generated on a mntns object.
> > > If "cgroup NS boundaries" is referring to a mntns object and if
> > > this object is available in the context of cgroup create/destroy
> > > then it should be possible.
> >
> > Great, yes, cgroup namespace way should work then.
> >
> > > But FAN_MNT_ATTACH reports a mountid. Is there a mountid
> > > to report on cgroup create? Probably not?
> >
> > Sorry, I thought that was per-mount recursive file event monitoring.
> > FAN_MARK_MOUNT looks like the right thing if we want to allow monitoring
> > cgroup creations / destructions in a subtree without recursively watching
> > each cgroup.
> 
> The problem sounds very similar to subtree monitoring for mkdir/rmdir on
> a filesystem, which is a problem that we have not yet solved.
> 
> The problem with FAN_MARK_MOUNT is that it does not support the
> events CREATE/DELETE, because those events are currently

Ah, bummer.

> monitored in context where the mount is not available and anyway
> what users want to get notified on a deleted file/dir in a subtree
> regardless of the mount through which the create/delete was done.
> 
> Since commit 58f5fbeb367ff ("fanotify: support watching filesystems
> and mounts inside userns") and fnaotify groups can be associated
> with a userns.
> 
> I was thinking that we can have a model where events are delivered
> to a listener based on whether or not the uid/gid of the object are
> mappable to the userns of the group.

Given how different NSes can be used independently of each other, it'd
probably be cleaner if it doesn't have to depend on another NS.

> In a filesystem, this criteria cannot guarantee the subtree isolation.
> I imagine that for delegated cgroups this criteria could match what
> you need, but I am basing this on pure speculation.

There's a lot of flexibility in the mechanism, so it's difficult to tell.
e.g. There's nothing preventing somebody from creating two separate subtrees
delegated to the same user.

Christian was mentioning allowing separate super for different cgroup mounts
in another thread. cc'ing him for context.

Thanks.

-- 
tejun

