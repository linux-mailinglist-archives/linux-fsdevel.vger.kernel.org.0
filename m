Return-Path: <linux-fsdevel+bounces-77841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id F26mCb8AmWnROwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 01:47:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9DF16B988
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 01:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6383D3013725
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 00:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87002848A1;
	Sat, 21 Feb 2026 00:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CydDG2bn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B909476
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Feb 2026 00:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771634873; cv=none; b=peykY9lAhPA+qujVVq7IbBowr7MifZQMQeFdL0L2/P5Mcm/cMYi0JgCNvwLO+GJPQZTNPpqcRSHVrHavV0w0mQTqTXFgk+TfEsZY7llFkxBnPxhLh5nkqS7SfywfiN0lOiFyocfIF4/KT5cZIhrgObNOedCrpczFgeMNekdYz2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771634873; c=relaxed/simple;
	bh=S/tFKxd6oYoVbB31wRvkN9RVlUMWo6lhxnLo8I7xNdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+fRtwoRZSGboxtwQhu0v7ipZ4Dyzj1O+pKTlYl2thiS3QmtxPnl3JSpgex6TIc0kOfNEQWXsxOoD21vV0CmYqlfp1Xgj864kk30OY84huhAa7ceYE7G1rbg5Xc4vqmk6OAM+q3eOXa5RCX0VFm0EsZP0zFhXPhBF9CgtVOJcjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CydDG2bn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E06DC116C6;
	Sat, 21 Feb 2026 00:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771634873;
	bh=S/tFKxd6oYoVbB31wRvkN9RVlUMWo6lhxnLo8I7xNdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CydDG2bnR89Dm03HFaFZwc4zMtaCI1SDf6FIcOvhlzyffpYMP7qiMbrsWh0FONe1k
	 0V4+FIZUHviLejJ8wa/ch5vAuZaOQGOPJj3IBIDF6RRHNOHxOUBc4mzy+tkiTfGyoV
	 xgGnZDIzydrQgOGn3AIvJqPhAMBZDPU6F29Q0Gxhj56+lQnzNj0eML0nSskIWpLEMX
	 asg0+BPOJoZHubFVWyvNOXgvBkYSyYhS2twxRv+2KJFjwyEPrxdef+zC+VBeM/WwRm
	 2ZvX/gAYKFIP0yytecWWpv8o2N4fajEuqcnHHMZukQwAJiJCZHYSiwnJD/Rr8zFu3f
	 Mop2P4Ls6lDcA==
Date: Fri, 20 Feb 2026 16:47:52 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, f-pc@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	Joanne Koong <joannelkoong@gmail.com>,
	John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Luis Henriques <luis@igalia.com>,
	Horst Birthelmer <horst@birthelmer.de>
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
Message-ID: <20260221004752.GE11076@frogsfrogsfrogs>
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <20260204190649.GB7693@frogsfrogsfrogs>
 <ce74079f-1e0a-4fee-9259-48f08c6989aa@linux.alibaba.com>
 <20260206053835.GD7693@frogsfrogsfrogs>
 <cf44fe77-4616-45c8-975a-08dafaecad47@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf44fe77-4616-45c8-975a-08dafaecad47@linux.alibaba.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77841-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[szeredi.hu,lists.linux-foundation.org,vger.kernel.org,gmail.com,groves.net,bsbernd.com,igalia.com,birthelmer.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 8E9DF16B988
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 02:15:12PM +0800, Gao Xiang wrote:
> Hi Darrick,
> 
> On 2026/2/6 13:38, Darrick J. Wong wrote:
> > On Thu, Feb 05, 2026 at 06:50:28AM +0800, Gao Xiang wrote:
> > > 
> > > 
> > > On 2026/2/5 03:06, Darrick J. Wong wrote:
> > > > On Mon, Feb 02, 2026 at 02:51:04PM +0100, Miklos Szeredi wrote:
> > > 
> > > ...
> > > 
> > > > 
> > > >    4 For defaults situations, where do we make policy about when to use
> > > >      f-s-c and when do we allow use of the kernel driver?  I would guess
> > > >      that anything in /etc/fstab could use the kernel driver, and
> > > >      everything else should use a fuse container if possible.  For
> > > >      unprivileged non-root-ns mounts I think we'd only allow the
> > > >      container?
> > > 
> > > Just a side note: As a filesystem for containers, I have to say here
> > > again one of the goal of EROFS is to allow unprivileged non-root-ns
> > > mounts for container users because again I've seen no on-disk layout
> > > security risk especially for the uncompressed layout format and
> > > container users have already request this, but as Christoph said,
> > > I will finish security model first before I post some code for pure
> > > untrusted images.  But first allow dm-verity/fs-verity signed images
> > > as the first step.
> > 
> > <nod> I haven't forgotten.  For readonly root fses erofs is probably the
> > best we're going to get, and it's less clunky than fuse.  There's less
> > of a firewall due to !microkernel but I'd wager that most immutable
> > distros will find erofs a good enough balance between performance and
> > isolation.
> 
> Thanks, but I can't make decisions for every individual end user.
> However, in my view, this approach is valuable for all container
> users if they don't mind to try this approach (I'm building this
> capabilities with several communities and people): they can achieve
> nearly native performance on read-write workloads with a trusted
> fs as well as the remote data source is completely isolated using
> an immutable secure filesystem.
> 
> I will make signed images work first, but as the next step, I'll
> definitely work on defining a clear on-disk boundary (very
> likely excluding per-inode compression layouts in the beginning)
> to enable most users to leverage untrusted data directly in
> a totally isolated user/mount namespace.

<nod> I hope you succeed!

> > 
> > Fuse, otoh, is for all the other weird users -- you found an old
> > cupboard full of wide scsi disks; or management decided that letting
> > container customers bring their own prepopulated data partitions(!) is a
> > good idea; or the default when someone plugs in a device that the system
> > knows nothing about.
> 
> Honestly, I've checked what Ted, Dave, and you said previously.
> For generic COW filesystems, it's surely hard to guarantee
> filesystem consistency at all times, mainly because of those
> on-disk formats by design (lots of duplicated metadata for
> different purposes, which can cause extra inconsistency compared
> to archive fses.) Of course, it's not entirely impossible, but
> as Ted pointed out, it becomes a matter of
> 
> 1) human resources;
> 2) enforcing such strict consistency checks harms performance
>    in general use cases which just use trusted filesystem /
>    media directly like databases.
> 
> I'm not against FUSE further improvements because they are seperated
> stories, I do think those items are useful for new Linux innovation,
> but as for the topic of allowing "root" in non-root-user-ns to mount,
> I still insist that it should be a per-filesystem policy, because
> filesystems are designed for different targeted use cases:
> 
>  - either you face and address the issue (by design or by
>    enginneering), or
>  - find another alternative way to serve users.
> 
> But I do hope we shouldn't force some arbitary policy without any
> technical reason, the feature is indeed useful for container users.

Oh yes, the policy question is a very large one; for a specific given
filesystem, you need to trust:

A> whatever user is asking to do the mount

B> the quality of the kernel or userspace drivers

C> the provenance of the filesystem image

This is a hugely personal (or institutional) question, all we can do is
provide mechanisms for kernel and userspace drivers, a sensible default
policy, and a reasonable way to relate all three properties to action.

Or just go with IT policy, which is deny, delete, destroy. :P

> > 
> > > On the other side, my objective thought of that is FUSE is becoming
> > > complex either from its protocol and implementations (even from the
> > 
> > It already is.
> > 
> > > TODO lists here) and leak of security design too, it's hard to say
> > > from the attack surface which is better and Linux kernel is never
> > > regarded as a microkernel model. In order to phase out "legacy and
> > > problematic flags", FUSE have to wait until all current users don't
> > > use them anymore.
> > > 
> > > I really think it should be a per-filesystem policy rather than the
> > > current arbitary policy just out of fragment words, but I will
> > > prepare more materials and bring this for more formal discussion
> > > until the whole goal is finished.
> > 
> > Well yes, the transition from kernel to kernel-or-fuse would be
> > decided on a per-filesystem basis.  When the fuse driver reaches par
> > with the kernel driver on functionality and stability then it becomes a
> > candidate for secure container usage.  Not before.
> 
> I respect this path, but just from my own perspective, userspace
> malicious problems are usually much harder to defence since the
> trusted boundary is weaker, in order to allow unpriviledged
> daemons, you have to monitor if page cache or any metadata cache
> or any potential/undiscovered deadlock vectors can be abused
> by those malicious daemons, so that you have to find more harden
> ways to limit such abused usage naturally since you never trust
> those unpriviledged daemons (which is arbitary executable code
> rather than a binary source) instead, which is opposed to
> performance cases in principle without detailed analysis.

I'm well aware that going to userspace opens a whole floodgate of weird
dynamic behavior possibilities.  Though obviously my experiences with
kernel XFS has shown me that those challenges exist there too. :/

The kernel does have the nice property that you can set NOFS and ignore
SIGSTOP/KILL if necessary to get things done.

--D

> Just my two cents.
> 
> Thanks,
> Gao Xiang
> 
> > 
> > --D
> > 
> > > Thanks,
> > > Gao Xiang
> > > 
> > > 
> 
> 

