Return-Path: <linux-fsdevel+bounces-77201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBw1C1lnkGkXZQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 13:15:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 985F313BD0D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 13:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66DAC3015D20
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 12:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C190F2DF6E9;
	Sat, 14 Feb 2026 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYXzVAoH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD192FF176
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 12:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771071315; cv=none; b=Q8BFMdNWbkI39thGlwsk3ZjnNy0I7lkEdMl0bnCCDmq2ruqGU3gE2gy4v0ZlQq4xYmeoT4prau3LgSWnasRYtKRHvUCR19BfHRNHBHs+3Xrti0i5BXuXUjki+OFFEQqC5x2gYbv183IrTQew99fEAZ6WbLuBnM6f5vU04tPsWSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771071315; c=relaxed/simple;
	bh=Ew4kMFZ8mIOA++qTf1YQSyFLGrzvyDAJXXaTKeMnLYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmrm5YHNB2zcoetVJzVTqF2nRxlFQXYQgpAp2nHrLzPd/Pyd0D4sEX1m+bJdKOKl8FYuV3DGETdxya1yCH0UnP/rjyY0o6divCym0iiXQUYvsKMzlRq9QJa5Cwu7vll3aBu+ssmrKwSCkbenOAMmwVIn54QBMxV09qZGi25pdPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYXzVAoH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B4BC16AAE;
	Sat, 14 Feb 2026 12:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771071314;
	bh=Ew4kMFZ8mIOA++qTf1YQSyFLGrzvyDAJXXaTKeMnLYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FYXzVAoHVmXzUfyxz/Z4q+tEmyVx6R+dHQIcP5ykBwavdZGiDFIqxyXhH1o1/FFwa
	 drYQnRr+id6z+ZFHIa294jWspskL283aSmnGzKT09EYUTAtoMQ0H5f8aXb3T8vN5Xi
	 EqhRHgMSP4SCH4A8OMz3TsLQ8C71QYu9My+C6sntKQwgmpVkn1nkTtYjF+b9oSE0ZY
	 8sy1JNZK886XLEmM5QKZg1pH/E04nmIZgBtbI5Uo7aRaS4XAFVahZNEsU+m51rnmHa
	 EvVheyKRNLrtSc1VFG57zpaThHbDe74Ul/QUbKziY8THoJktwqLTlKS9V/imYhvb4b
	 eePgfrxmU/t9w==
Date: Sat, 14 Feb 2026 13:15:09 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Askar Safin <safinaskar@gmail.com>, christian@brauner.io, 
	cyphar@cyphar.com, hpa@zytor.com, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, werner@almesberger.net
Subject: Re: [RFC] pivot_root(2) races
Message-ID: <20260214-duzen-inschrift-9382ae6a5c2b@brauner>
References: <CAHk-=wgQDOUff_F28xaTB-BvSHs9YC3bxXJa0HjpSTAUyPF-Ew@mail.gmail.com>
 <20260213182732.196792-1-safinaskar@gmail.com>
 <CAHk-=wiB7BN2BnBjk5y2Zim_vveYg7GAZA_N+XjrptY59Qnzzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiB7BN2BnBjk5y2Zim_vveYg7GAZA_N+XjrptY59Qnzzw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77201-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,brauner.io,cyphar.com,zytor.com,suse.cz,vger.kernel.org,zeniv.linux.org.uk,almesberger.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 985F313BD0D
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 10:39:58AM -0800, Linus Torvalds wrote:
> On Fri, 13 Feb 2026 at 10:27, Askar Safin <safinaskar@gmail.com> wrote:
> >
> > pivot_root was actively used by inits in classic initrd epoch, but
> > initrd is not used anymore.
> 
> Well, debian code search does find it being used in systemd, although
> I didn't then chase down how it is used.

I've explained that in my other mail. It's used to setup containers just
like any other container runtime does. Everytime you setup a container
pivot_root() is used. systemd also uses it to try and figure out whether
pivot_root() works in the initramfs and falls back to move_mount()
otherwise.

But my point has been: we don't need it anymore. As soon as we have
MOVE_MOUNT_BENEATH working with the rootfs we can just treat
pivot_root() as deprecated and point out that this should be used.

systemd/container just mounts the new rootfs beneath the old rootfs.
systemd/container fchdir()s into the new rootfs, unmounts the old one
then chroots into the new one and done. That also works in the initramfs
as CLONE_FS guarantees that every kernel thread will see the updated
rootfs. No pivot_root() needed.

> Of course, Dbian code search also pointed out to me that we have a
> "pivot_root" thing in util-linux, so apparently some older things used
> an external program and that "&init_task" check wouldn't work anyway.

