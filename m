Return-Path: <linux-fsdevel+bounces-78241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBkcJ5qFnWmVQQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 12:03:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB2E185D6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 12:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5B703094FA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 11:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CD837AA9E;
	Tue, 24 Feb 2026 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIOs8VFh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64620366DD7;
	Tue, 24 Feb 2026 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931027; cv=none; b=g1A8p70XnIM38rP+ZGlj+9fzBQrXs00Ter+lRkgt8jIiQRnTzzwztjduWhUoMsqRZ5e4g3Ig6tuE/1gxiKKyKXjSUr4WNY7mnDr6krlJmSaFPrqeMPIHZ2TY/EaYOviaJwXus4pRBMeRcwCEGhlp01w2l58FxP+lvpoePYvMtzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931027; c=relaxed/simple;
	bh=xc9tOHEoBqnEbHQXyEIaPNc/6FOE58Pin4eiMfQKIyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfuTQkWizZj0x0kE2D2AgsfOCmlH4SbhVoqdiiX7pW9Q6Zi8Rzf2EIjbSiIUDkXEQ122eZJkoNtg6tZOsVimWmkK92V8bEhCfDK0tGHVZTSUEBWHNmxa84EMWRl3j3LxVnanQh6vDStTJL9fmpZB1bvY2dKDOl0bi4oc/vwxnoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIOs8VFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA79FC116D0;
	Tue, 24 Feb 2026 11:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771931026;
	bh=xc9tOHEoBqnEbHQXyEIaPNc/6FOE58Pin4eiMfQKIyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PIOs8VFhoIgMEJEk3EHm4P20aNj8DxI9RIUHqvvs0pcgpnTcIBFZildQe2kk/l+wO
	 GBObBm54Eug6jMLQZAj+45b5t8AHFD5skbrNG6+57cWnkygTxPDDgmOeMHMpOLT1T4
	 I5xvrMmG1AkVZ/00WI6OWZkLTvFdwPegt0ZW8AlppHR5G1uHffYOnsxztD2kGg4XnV
	 RVZUkxFNDRnbXDd0AsdgMmWy6yiVbnSYZicCNNyRmvcL884ysRjQT6a/W7g5Qeowrb
	 37w68c0msP0L+IZy8XYOy8YfN2zqDKa7UxTvxXNsBolWPST/5+AJPG6slp5znPzNKD
	 SYY12SOI0f91w==
Date: Tue, 24 Feb 2026 12:03:41 +0100
From: Christian Brauner <brauner@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	"T.J. Mercier" <tjmercier@google.com>, gregkh@linuxfoundation.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 2/3] kernfs: Send IN_DELETE_SELF and IN_IGNORED
Message-ID: <20260224-hetzen-zeitnah-a3e1e08367cc@brauner>
References: <20260220055449.3073-1-tjmercier@google.com>
 <20260220055449.3073-3-tjmercier@google.com>
 <aZh-orwoaeAh52Bf@slm.duckdns.org>
 <CAOQ4uxjgXa1q-8-ajSBwza-Tkv91tFP-_wWzCQPW+PwJMehEWA@mail.gmail.com>
 <aZi6_K-pSRwAe7F5@slm.duckdns.org>
 <CAOQ4uxjZZSRBwZ2ZL31juAUu0-sAUnPrJWvQuJ2NDaWZMeq0Fg@mail.gmail.com>
 <aZju-GFHf8Eez-07@slm.duckdns.org>
 <CAOQ4uxgzuxaLt2xs5a5snu9CBA_4esQ_+t0Wb6CX4M5OqM5AOA@mail.gmail.com>
 <aZx_8_rJNPF2EYgn@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZx_8_rJNPF2EYgn@slm.duckdns.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78241-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,google.com,linuxfoundation.org,lists.linux.dev,vger.kernel.org,suse.cz,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5DB2E185D6E
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 06:27:31AM -1000, Tejun Heo wrote:
> (cc'ing Christian Brauner)
> 
> On Sat, Feb 21, 2026 at 06:11:28PM +0200, Amir Goldstein wrote:
> > On Sat, Feb 21, 2026 at 12:32 AM Tejun Heo <tj@kernel.org> wrote:
> > >
> > > Hello, Amir.
> > >
> > > On Fri, Feb 20, 2026 at 10:11:15PM +0200, Amir Goldstein wrote:
> > > > > Yeah, that can be useful. For cgroupfs, there would probably need to be a
> > > > > way to scope it so that it can be used on delegation boundaries too (which
> > > > > we can require to coincide with cgroup NS boundaries).
> > > >
> > > > I have no idea what the above means.
> > > > I could ask Gemini or you and I prefer the latter ;)
> > >
> > > Ah, you chose wrong. :)
> > >
> > > > What are delegation boundaries and NFS boundaries in this context?
> > >
> > > cgroup delegation is giving control of a subtree to someone else:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/tree/Documentation/admin-guide/cgroup-v2.rst#n537
> > >
> > > There's an old way of doing it by changing perms on some files and new way
> > > using cgroup namespace.
> > >
> > > > > Would it be possible to make FAN_MNT_ATTACH work for that?
> > > >
> > > > FAN_MNT_ATTACH is an event generated on a mntns object.
> > > > If "cgroup NS boundaries" is referring to a mntns object and if
> > > > this object is available in the context of cgroup create/destroy
> > > > then it should be possible.
> > >
> > > Great, yes, cgroup namespace way should work then.
> > >
> > > > But FAN_MNT_ATTACH reports a mountid. Is there a mountid
> > > > to report on cgroup create? Probably not?
> > >
> > > Sorry, I thought that was per-mount recursive file event monitoring.
> > > FAN_MARK_MOUNT looks like the right thing if we want to allow monitoring
> > > cgroup creations / destructions in a subtree without recursively watching
> > > each cgroup.
> > 
> > The problem sounds very similar to subtree monitoring for mkdir/rmdir on
> > a filesystem, which is a problem that we have not yet solved.
> > 
> > The problem with FAN_MARK_MOUNT is that it does not support the
> > events CREATE/DELETE, because those events are currently
> 
> Ah, bummer.
> 
> > monitored in context where the mount is not available and anyway
> > what users want to get notified on a deleted file/dir in a subtree
> > regardless of the mount through which the create/delete was done.
> > 
> > Since commit 58f5fbeb367ff ("fanotify: support watching filesystems
> > and mounts inside userns") and fnaotify groups can be associated
> > with a userns.
> > 
> > I was thinking that we can have a model where events are delivered
> > to a listener based on whether or not the uid/gid of the object are
> > mappable to the userns of the group.
> 
> Given how different NSes can be used independently of each other, it'd
> probably be cleaner if it doesn't have to depend on another NS.
> 
> > In a filesystem, this criteria cannot guarantee the subtree isolation.
> > I imagine that for delegated cgroups this criteria could match what
> > you need, but I am basing this on pure speculation.
> 
> There's a lot of flexibility in the mechanism, so it's difficult to tell.
> e.g. There's nothing preventing somebody from creating two separate subtrees
> delegated to the same user.

Delegation is based on inode ownership I'm not sure how well this will
fit into the fanotify model. Maybe the group logic for userns that
fanotify added works. I'm not super sure.

> Christian was mentioning allowing separate super for different cgroup mounts
> in another thread. cc'ing him for context.

If cgroupfs changes to tmpfs semantics where each mount gives you a new
superblock then it's possible to give each container its own superblock.
That in turn would make it possible to place fanotify watches on the
superblock itself. I think you'd roughly need something like the
following permission model:

* Cgroupfs mounted on the host -> would require global CAP_SYS_ADMIN as
  you'd get notified about all tree changes ofc.
* If cgroupfs is mounted in user namespace with a cgroup namespace then
  allow the container to monitor the whole superblock.

I think kernfs currently has logic to gate mounting of sysfs in a
container on the network namespace. We would need similar logic to gate
creation of a new superblock for cgroupfs behind the cgroup namespace
(that's the kernfs tagging mechanism iirc).

There's some more annoyance ofc: the current model has one superblock
for the whole system. As such each cgroup is associated with exactly one
inode. So any ownership changes to a given inode are visible _system
wide_. That leads to problems such as an unpriv user having a hard time
deleting cgroups that were delegated to an unprivileged container that
it owns - at least not without setting up a helper userns and running rm
-rf in it.

Note, if we allow separate cgroup superblocks then this automatically
entails that multiple inodes from different superblocks refer to the
same underlying cgroup - like separate procfs instances have different
inodes that refere to the same task struct or whatever. This should be
fine locking wise because you serialize on locks associated with the
underlying cgroup - which would be referenced by all inodes.

With this possible cgroupfs will be able to be mounted inside of a
container with a separate inode/dentry tree where each
inode->i_{uid,gid} can be set according to the containers user
namespace.

That also gets rid of the aforementioned problem where an unprivileged
container user on the host cannot remove cgroups that were delegated to
the container.

It also introduces a change in the delegation model that is worth
considering:

Right now if you delegate ownership it means chown()ing a bunch of files
to the relevant user. With separate superblocks mountable in containers
you could technically delegate write access to multiple containers at
the same time even though they might have completely distinct user
namespaces with isolated idmappings (iow, they're global uid/gid ranges
don't overlap and so they can't meaningfully interact with each other).

If container A mounts a new cgroupfs instance and container B mounts a
new cgroupfs instance and someone was crazy enough to let both A and B
share the same cgroup they could both write around in it. It would also
mean that all files in a given cgroup change ownership _within the
superblock that was mounted_ - other superblocks are ofc unaffected:

  mkdir /sys/fs/cgroup/lets/go/deeper/

delegate the cgroup

  echo 1234 > /sys/fs/cgroup/lets/go/deeper

Now the container payload running as 1234 does:

  unshare(CLONE_NEWUSER | CLONE_NEWNS | CLONE_NEWCGROUP);

Set ups the rootfs and chroots into it and then mounts cgroupfs within
its namespaces:

  mount("cgroup", "/sys/fs/cgroup", "cgroup2", 0, NULL);

This would create a new cgroupfs superblock with "deeper" being the
root dentry - similar to how "remounting" changes the visibility. Then
the idmapping associated with the user namespace is taken into account
and all files under "deeper" will be owned by the container root making
it all writable for the container (That is different from today where
you need to chown around.).

TL;DR:

* multi-instance cgroupfs implies multiple inodes for the same cgroup
  with custom ownership for each inode
* multi-instance cgroupfs means per-container superblock fanotify
  watches
* multi-instance cgroupfs means per-container superblock mount options

