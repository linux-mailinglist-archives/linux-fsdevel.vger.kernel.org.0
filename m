Return-Path: <linux-fsdevel+bounces-77347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMIwLOAolGlGAQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 09:37:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E07A14A09E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 09:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30EE3302E85F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 08:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF02E223DD6;
	Tue, 17 Feb 2026 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8vdGNjG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3331B7F4
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771317447; cv=none; b=UG/g0hbE7WkxFLTLClpJLX1e4a1b9LhGEndPc4lhzTBdLCQ5QcAKk/VrZl4K3SIBYfT0moZaN7/urbzuLf4mL57PskjFNlkpNj28uMrBGfomNWkbZJ1vnyOwxu3kVWwn3RwmW2AUYuIfab6gp0AHNSbbVhUUVmBYgfuCU7dAspo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771317447; c=relaxed/simple;
	bh=dFFga2/IiRtc2VK8/n76dynZZMTujzywBoxu+Xp1MbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPlnIU5PJgSuyh5tHR1XhdlBqsEKkiTGLvUqwHvI1UpHegNEAvItOdO64BJac9S1qu3+iyV8IvPLvkHT0XwRME210dAWR7rs70PVjeVxQv6FhvJl+jt0lFOPlq90gFnUljllthfMKtdCemD6mLXBrxoQ+Y/jB6Zvq6LbjcT3FVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8vdGNjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA9AC19421;
	Tue, 17 Feb 2026 08:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771317447;
	bh=dFFga2/IiRtc2VK8/n76dynZZMTujzywBoxu+Xp1MbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I8vdGNjGBkH6zov5oC62JrBeAfRurmJbjTAhX1Mc/3RCN69RwMt9n+jGo48ZBDmk4
	 h2B+O4kJjiYCmf6Uf7ls44zSufIbujXH4PS5nyKvn5ESthyStXCXIeVOPsZmbNivdB
	 W/mUgYZjgmlXgXURD+BBeJ2FMweCr60YlyKGUbbsAeUwAocXPXLM4zDh5nDCxm27oD
	 /EIQvObQ90FO4aXj8wrOAQSYq1axGXePpvcJ5s50uNtQjuLNqyH7g4DRAYFWggV/L7
	 GmiLMbQqjUZxhJqEaHgaPYgWGlKciH8LTl0iYrqnt0/Av53CMgSkuCbHgb9eDvEAHF
	 26i9+URP51GJw==
Date: Tue, 17 Feb 2026 09:37:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Askar Safin <safinaskar@gmail.com>, 
	christian@brauner.io, cyphar@cyphar.com, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	torvalds@linux-foundation.org, werner@almesberger.net
Subject: Re: [RFC] pivot_root(2) races
Message-ID: <20260217-gepflanzt-preis-a5ac618e3c8c@brauner>
References: <1FC2FB1F-BDA5-472D-A7DB-D146F6F75B16@zytor.com>
 <20260213174721.132662-1-safinaskar@gmail.com>
 <1caf6a70-e49b-42c7-81d0-bd0d6f5027bf@zytor.com>
 <20260213222521.GQ3183987@ZenIV>
 <92837188-C667-4A2A-9D34-85E5F1A5D597@zytor.com>
 <20260214-unbekannt-ratifizieren-58de8ce30c18@brauner>
 <2B0076BB-56E3-4477-900A-E9A34F45264B@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2B0076BB-56E3-4477-900A-E9A34F45264B@zytor.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77347-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,gmail.com,brauner.io,cyphar.com,suse.cz,vger.kernel.org,linux-foundation.org,almesberger.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,zytor.com:email,linux.org.uk:email]
X-Rspamd-Queue-Id: 0E07A14A09E
X-Rspamd-Action: no action

On Sat, Feb 14, 2026 at 04:48:17PM -0800, H. Peter Anvin wrote:
> On February 14, 2026 4:42:32 AM PST, Christian Brauner <brauner@kernel.org> wrote:
> >On Fri, Feb 13, 2026 at 03:00:49PM -0800, H. Peter Anvin wrote:
> >> On February 13, 2026 2:25:21 PM PST, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >> >On Fri, Feb 13, 2026 at 12:27:46PM -0800, H. Peter Anvin wrote:
> >> >> On 2026-02-13 09:47, Askar Safin wrote:
> >> >> > "H. Peter Anvin" <hpa@zytor.com>:
> >> >> >> It would be interesting to see how much would break if pivot_root() was restricted (with kernel threads parked in nullfs safely out of the way.)
> >> >> > 
> >> >> > As well as I understand, kernel threads need to follow real root directory,
> >> >> > because they sometimes load firmware from /lib/firmware and call
> >> >> > user mode helpers, such as modprobe.
> >> >> > 
> >> >> 
> >> >> If they are parked in nullfs, which is always overmounted by the global root,
> >> >> that should Just Work[TM]. Path resolution based on that directory should
> >> >> follow the mount point unless I am mistaken (which is possible, the Linux vfs
> >> >> has changed a lot since the last time I did a deep dive.)
> >> >
> >> >You are, and it had always been that way.  We do *not* follow mounts at
> >> >the starting point.  /../lib would work, /lib won't.  I'd love to deal with
> >> >that wart, but that would break early boot on unknown number of boxen and
> >> >breakage that early is really unpleasant to debug.
> >> 
> >> Well, it ought to be easy to make the kernel implicitly prefix /../ for kernel-upcall pathnames, which is more or less the same concept as, but should be a lot simpler than, looking up the init process root.
> >
> >I don't think parking kernel threads unconditionally in nullfs is going
> >to work. This will not just break firmware loading it will also break
> >coredump handling and a bunch of other stuff that relies on root based
> >lookup.
> >
> >I think introducing all this new machinery just to improve
> >pivot_root()'s broken semantics is pointless. Let's just let it die. We
> >have all the tools to avoid it ready. OPEN_TREE_NAMESPACE for containers
> >so pivot_root() isn't needed at all anymore for that case and
> >MOVE_MOUNT_BENEATH for the rootfs for v7.1 and then even if someone
> >wanted to replace the rootfs that whole chroot_fs_refs() dance is not
> >needed at all anymore.
> >
> >The only reason to do it would be to make sure that no one accidently
> >pins the old rootfs anymore but that's not a strong argument anyway:
> >
> >- If done during boot it's pointless because most of the times there's
> >  exactly one process running and CLONE_FS will guaratee that kernel
> >  threads pick up the rootfs change as well.
> >
> >- If done during container setup it's especially useless because again
> >  only the process setting up the container will be around.
> >
> >- It doesn't at all deal with file descriptors that pin the old rootfs
> >  which is the much more likely case.
> >
> >If anyone actually does pivot_root() on a live system in the initial
> >user namespace with a full userspace running work without introducing
> >all kinds of breakage they should probably reexamine some design
> >decisions.
> >
> >I don't think we need to fix it I think we need to make it unused and I
> >think that's possible as I tried to argue.
> 
> You missed the bit that the kernel tasks would use /.. to get to the "real" root.

My point was rather just that I don't know if we want to have yet
another set of helpers just for this. Sure, we can do it but is
this something that's really urgent right now. I'm not so sure.

