Return-Path: <linux-fsdevel+bounces-50890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1A5AD0B44
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 07:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3AA81891C81
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 05:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CD41CEACB;
	Sat,  7 Jun 2025 05:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nsx8AXTC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24B6A55
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Jun 2025 05:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749273653; cv=none; b=oVSaCj0qRZFpTddER/6Q4gbXIJctdBxzCodSF/U12sTLG+eFVfRcnkSdTBudabYWoi/u3aQMN1XWhIIMAJQ/2gnzXXR4CZMfTj5Gyh7IaHrucNCzicbMn+Wt7iFjhc5qjb530yJQ3KQ5FnN3iYFa5Y4gdvbZxuTtvFFeLmpeebk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749273653; c=relaxed/simple;
	bh=vtgdXbTw4KU7FaACdvS2GYPLKp8klMnXlwZyyS03+NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1gmNEXmpeWJWHGwmFia5oUaEgTSsca5YuKXGuTZbj/tDsHZONIC+iIAPHHCHATSu8Y+GC40DdcCMGLsuZvR5VsERfuchRqVUSzT3zLlaETQg3N49jIN41mn8x1VKQo55sNvskNXe7WNy2NMdCkdkW2Wv75Tj4h3vsc2BoVnkJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nsx8AXTC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wZelpZGLTzYNWGN5Ju594A7hkSUmcpw1wJmuochOtIQ=; b=nsx8AXTCPWrh+lI5Rd0uqNaclI
	8BrISZW7q47m2IQKyKaBfbMwvqTju3yKn+O+BnhOI2D1Ol9eyXSZg5/Yvcb8Qj2YWe00is21oknZm
	xArXpe+bRlr3E5dFOwHM5hoCkYg6kAgujc6bDwsscfOKNtr3/AoXxjZFMrEo72UZT1xGGjyDga7fA
	CxhVyj5vUTqtF9gefla6TlPIqP88xOIrnOgqZanPWs7LC840hIS05Uz6Ie7Z574YxNFF1zTkbwI3+
	lZ7jxJn5CI3LZr5/r3JzdHslUYBZdNPLguri8s8olDwR9ktER9Ycd8wBR+s7IEmP2Jgivs8+SW/yO
	xodVozzA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNlz6-00000005vBy-0R9c;
	Sat, 07 Jun 2025 05:20:48 +0000
Date: Sat, 7 Jun 2025 06:20:48 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>, Allison Karlitskaya <lis@redhat.com>
Subject: Re: [PATCH 1/2] mount: fix detached mount regression
Message-ID: <20250607052048.GZ299672@ZenIV>
References: <20250605-work-mount-regression-v1-0-60c89f4f4cf5@kernel.org>
 <20250605-work-mount-regression-v1-1-60c89f4f4cf5@kernel.org>
 <20250606045441.GS299672@ZenIV>
 <20250606051428.GT299672@ZenIV>
 <20250606070127.GU299672@ZenIV>
 <20250606-neuformulierung-flohmarkt-42efdaa4bac5@brauner>
 <20250606174502.GY299672@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606174502.GY299672@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jun 06, 2025 at 06:45:02PM +0100, Al Viro wrote:
> On Fri, Jun 06, 2025 at 09:58:26AM +0200, Christian Brauner wrote:
> 
> > Fwiw, check_mnt() is a useless name for this function that's been
> > bothering me forever.
> 
> Point, but let's keep the renaming (s/check_mnt/our_mount/, for
> example) separate.

Modified and force-pushed.

It does pass xfstests without regressions.  kselftests... AFAICS,
no regressions either, but the damn thing is a mess.  Example:

# # set_layers_via_fds.c:711:set_layers_via_detached_mount_fds:Expected layers_found[i] (0) == true (1)
# # set_layers_via_fds.c:39:set_layers_via_detached_mount_fds:Expected rmdir("/set_layers_via_fds") (-1) == 0 (0)
# # set_layers_via_detached_mount_fds: Test terminated by assertion
# #          FAIL  set_layers_via_fds.set_layers_via_detached_mount_fds

Not a regression, AFAICT; the underlying problem is that mount options
are shown incorrectly in the tested case.  Still present after overlayfs
merge.  mount does succeed, but... in options we see this:
rw,relatime,lowerdir+=/,lowerdir+=/,lowerdir+=/,lowerdir+=/,datadir+=/,datadir+=/,datadir+=/,upperdir=/upper,workdir=/work,redirect_dir=on,uuid=on,metacopy=on

And it's a perfectly expected result - you are giving fsconfig(2) empty
path on a detached tree, created with OPEN_TREE_CLONE.  I.e. it *is*
an empty path in the mount tree the sucker's in.  What could d_path()
produce other than "/"?

Note, BTW that it really does create set_layers_via_fds in root (WTF?) and
running that sucker again yields a predictable fun result - mkdir() failing
with EEXIST...

IMO that kind of stuff should be dealt with by creating a temporary directory
somewhere in /tmp, mounting tmpfs on it, then doing all creations, etc.
inside that.  Then umount -l /tmp/<whatever>; rmdir /tmp/<whatever> will
clean the things up.

