Return-Path: <linux-fsdevel+bounces-77208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGrQK0FukGmoZQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 13:44:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1348313BF3A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 13:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3090230214CA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 12:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D4A26D4CA;
	Sat, 14 Feb 2026 12:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CISp9c79"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243112E03F1
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771072983; cv=none; b=imsuGg/4vfaC4GjitH/BJdPPY7WcmOkJDS6k+7r71ibQPZNUiJoZwW3DjQfyhYxoK33Gw8kgjztiINxbtwmrXVsTjO06iArqzUHLvHPSUmOiWVPuEkCQYkWrxewwt/yUd7peCS/owZGdbgifuT+znHNR90VhkfyJBqGuoLdT2QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771072983; c=relaxed/simple;
	bh=U14FhlwA9MwteOPXwCz+0DsxBYkFIeznTvHo+gVGTjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbsNdik03ViJdzXRs/yyzssgdY/TgnLkyVFJrFKAG4/PU2ZfXfXyY/wv5TimtWuBvwXrexUncaYID4SCoCCUIL89+q9Ih0naan37MalsDZVTRsqPuH2ZBRbHciMNIL8ECMElGh701ZwyHbvA/vrC2cTTJAvLGY2TRdo2NonfTFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CISp9c79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B4BC16AAE;
	Sat, 14 Feb 2026 12:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771072982;
	bh=U14FhlwA9MwteOPXwCz+0DsxBYkFIeznTvHo+gVGTjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CISp9c79r9CDQ/f0iUJeISgz616fF1JafaOw+h0l0hFUOHoAxLgbsIACmv6D4GOT9
	 LIuYAjx56HKZZyd5tun0B5NOmasq2Lhldq/ZpzpO5lBQxv7nllZGe+ZukqQWCReWaR
	 LGGGh/aeJH9okLe3cB7A7px4Twn8t72QwCzlAWEhspJMcmUTzdJSZSLgi7Do2iflcA
	 OhtWEkDmJzzut2G3Mwwi8pGI/dylF0Wu6UPKq3UWVljeQaNfD3Yy0p/aHcOQijwhb+
	 mqzHiyrOpcherH8YYRcwkjUB/MB6IDc8MPHGDFmQuKfQG/nLG4+tIZ1UThGLFS8yg0
	 X9DlWVTS5EDtQ==
Date: Sat, 14 Feb 2026 13:42:32 +0100
From: Christian Brauner <brauner@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Askar Safin <safinaskar@gmail.com>, 
	christian@brauner.io, cyphar@cyphar.com, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	torvalds@linux-foundation.org, werner@almesberger.net
Subject: Re: [RFC] pivot_root(2) races
Message-ID: <20260214-unbekannt-ratifizieren-58de8ce30c18@brauner>
References: <1FC2FB1F-BDA5-472D-A7DB-D146F6F75B16@zytor.com>
 <20260213174721.132662-1-safinaskar@gmail.com>
 <1caf6a70-e49b-42c7-81d0-bd0d6f5027bf@zytor.com>
 <20260213222521.GQ3183987@ZenIV>
 <92837188-C667-4A2A-9D34-85E5F1A5D597@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <92837188-C667-4A2A-9D34-85E5F1A5D597@zytor.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77208-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1348313BF3A
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 03:00:49PM -0800, H. Peter Anvin wrote:
> On February 13, 2026 2:25:21 PM PST, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >On Fri, Feb 13, 2026 at 12:27:46PM -0800, H. Peter Anvin wrote:
> >> On 2026-02-13 09:47, Askar Safin wrote:
> >> > "H. Peter Anvin" <hpa@zytor.com>:
> >> >> It would be interesting to see how much would break if pivot_root() was restricted (with kernel threads parked in nullfs safely out of the way.)
> >> > 
> >> > As well as I understand, kernel threads need to follow real root directory,
> >> > because they sometimes load firmware from /lib/firmware and call
> >> > user mode helpers, such as modprobe.
> >> > 
> >> 
> >> If they are parked in nullfs, which is always overmounted by the global root,
> >> that should Just Work[TM]. Path resolution based on that directory should
> >> follow the mount point unless I am mistaken (which is possible, the Linux vfs
> >> has changed a lot since the last time I did a deep dive.)
> >
> >You are, and it had always been that way.  We do *not* follow mounts at
> >the starting point.  /../lib would work, /lib won't.  I'd love to deal with
> >that wart, but that would break early boot on unknown number of boxen and
> >breakage that early is really unpleasant to debug.
> 
> Well, it ought to be easy to make the kernel implicitly prefix /../ for kernel-upcall pathnames, which is more or less the same concept as, but should be a lot simpler than, looking up the init process root.

I don't think parking kernel threads unconditionally in nullfs is going
to work. This will not just break firmware loading it will also break
coredump handling and a bunch of other stuff that relies on root based
lookup.

I think introducing all this new machinery just to improve
pivot_root()'s broken semantics is pointless. Let's just let it die. We
have all the tools to avoid it ready. OPEN_TREE_NAMESPACE for containers
so pivot_root() isn't needed at all anymore for that case and
MOVE_MOUNT_BENEATH for the rootfs for v7.1 and then even if someone
wanted to replace the rootfs that whole chroot_fs_refs() dance is not
needed at all anymore.

The only reason to do it would be to make sure that no one accidently
pins the old rootfs anymore but that's not a strong argument anyway:

- If done during boot it's pointless because most of the times there's
  exactly one process running and CLONE_FS will guaratee that kernel
  threads pick up the rootfs change as well.

- If done during container setup it's especially useless because again
  only the process setting up the container will be around.

- It doesn't at all deal with file descriptors that pin the old rootfs
  which is the much more likely case.

If anyone actually does pivot_root() on a live system in the initial
user namespace with a full userspace running work without introducing
all kinds of breakage they should probably reexamine some design
decisions.

I don't think we need to fix it I think we need to make it unused and I
think that's possible as I tried to argue.

