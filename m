Return-Path: <linux-fsdevel+bounces-54346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C169AFE5AD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 12:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08720485218
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 10:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD23C28CF6C;
	Wed,  9 Jul 2025 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BpF5Rk++"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFBD289E01;
	Wed,  9 Jul 2025 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752056662; cv=none; b=qMQpBLH5xRJYsILkvFsV2xQaZr2GGiSK81zRhG6mkSvZ/IloHb3JTZZ1ste/Xrs0+2UTC4J2QSyWrh50FMV4v+ZI+yZw0Jk44gzlSglylDv1InPNSvrKibHbnnfkv/ObgVbPrVP+rhmJUhqsUeJrx9GoL2jNkYxm4WEBSFAkMII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752056662; c=relaxed/simple;
	bh=eceDHLR9jfkyk8ah6iJSeORnmSddRn+V+ec4+M2xGQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9EGxHgvt8fz2d+sAz2VrHyclnBs9bpiR4UmUN6B3XLV4QnlZqVAephSPCdTrSbcFBwdpg+2FWMu3gR/LncxAzWuTgZXSngchm111QUtJMyZ3OuwN/N+lZVtMGReznWNqRUaJZex0Eh0aU5tPyBe3Odzl5btImEyMdOghVIosVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BpF5Rk++; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NJ2YU3x+ZI7uTsAkTW0WNQnC6o7r6JZlBGNIPTD2op0=; b=BpF5Rk++Aj382yTKz7Tg3d84o3
	kfPx/EtP/dkFLegkE7YqOAlGDhpxZCHvcMtcsjUtMLvTjJsLAwV1FeDez1mzkYhhQZzVDPNCJuIPt
	DOq6LnT+U3Z2l3RNZuw+c2YUEjLxth2uDSsA0zFDvvPrgckK8YyjsRS8iFY/TYwJjKq8XrVgcjUTX
	s/SH1kMJUTvnqK3Td601Hhm85Od9WD1Eoffps7UGsR19z3wY7gJfqrj1EBZs3u75AZvDOgsymfO6o
	vkyO5suUR/EnF4+RRUjZHa6LuKiYGfYtZZ+RE3iwnGvqt4QgehnZ//wFRDEVs1Cagcjw0g0F8NFlh
	XTPIG1Ag==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZRyE-0000000H4uh-3XNx;
	Wed, 09 Jul 2025 10:24:10 +0000
Date: Wed, 9 Jul 2025 11:24:10 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	apparmor@lists.ubuntu.com, selinux@vger.kernel.org,
	tomoyo-users_en@lists.sourceforge.net,
	tomoyo-users_ja@lists.sourceforge.net, kernel-team@meta.com,
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, brauner@kernel.org,
	jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com,
	amir73il@gmail.com, repnop@google.com, jlayton@kernel.org,
	josef@toxicpanda.com, mic@digikod.net, gnoack@google.com,
	m@maowtm.org, john.johansen@canonical.com, john@apparmor.net,
	stephen.smalley.work@gmail.com, omosnace@redhat.com,
	takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp,
	enlightened@chromium.org
Subject: Re: [RFC] vfs: security: Parse dev_name before calling
 security_sb_mount
Message-ID: <20250709102410.GU1880847@ZenIV>
References: <20250708230504.3994335-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708230504.3994335-1-song@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jul 08, 2025 at 04:05:04PM -0700, Song Liu wrote:
> security_sb_mount handles multiple types of mounts: new mount, bind
> mount, etc. When parameter dev_name is a path, it need to be parsed
> with kern_path.
> 
> Move the parsing of dev_name to path_mount, and pass the result to
> security_sb_mount, so that:
> 1. The LSMs do not need to call kern_path again;
> 2. For BPF LSM, we can use struct path dev_path, which is much easier to
>    use than a string.
> 3. We can now remove do_move_mount_old.
> 
> Also, move may_mount check to before security_sb_mount and potential
> kern_path, so that requests without proper capability will be rejected
> sooner.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> 
> ---
> The primary motivation of this change is to monitor bind mount and move
> mount in BPF LSM. There are a few options for this to work:
> 1. Introduce bpf_kern_path kfunc.
> 2. Add new hook(s), such as [1].
> 3. Something like this patch.
> 
> At this moment, I think this patch is the best solution.
> 
> New mount for filesystems with FS_REQUIRES_DEV also need kern_path for
> dev_name. apparmor and tomoyo still call kern_path in such cases.
> However, it is a bit tricky to move this kern_path call to path_mount,
> so new mount path is not changed in this version.

security_sb_mount() is and had always been a mind-boggling trash of an API.

It makes no sense in terms of operations being requested.  And any questions
regarding its semantics had been consistently met with blanket "piss off,
LSM gets to do whatever it wants to do, you are not to question the sanity
and you are not to request any kind of rules - give us the fucking syscall
arguments and let us at it".

Come up with a saner API.  We are done accomodating that idiocy.  The only
changes you get to make in fs/namespace.c are "here's our better-defined
hooks, please call <this hook> when you do <that>".

NAKed-by: Al Viro <viro@zeniv.linux.org.uk>

