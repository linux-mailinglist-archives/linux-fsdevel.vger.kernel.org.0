Return-Path: <linux-fsdevel+bounces-40101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B91A1C01A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 02:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDDEF18878CB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 01:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59F41E5716;
	Sat, 25 Jan 2025 01:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b="n2VRWLno"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.sws.net.au (smtp.sws.net.au [144.76.186.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EAECA4E;
	Sat, 25 Jan 2025 01:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.186.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737767841; cv=none; b=kicVWlyp/kQ7v1MY7r3M35Z8V+iMJGQuuEW3BNOuwj3IXLX9dmmJOkmiB6DnsBETjVK/OZj+FZn/UOJxc0Iiaq1baUdvSmLOCGpuBheQggFWe+vcpbBQNOykWxXE/mmmj+3SG73RsgR2waQyVpMWX6WDYQ/gGW0LNtGkru7Txo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737767841; c=relaxed/simple;
	bh=kXpTuQ5F0vOsnlvGLI1zKQozRagHI+eeno/zGFHRwEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aALeEsffsRSnJ/Kx5ixbNtwe3R3RLXr1gVgpwJdngEoyWgKq+t7YipmJY8SVt9WJrU90ISQgThRyhf9j9pXQ3BIDXgv+5zsq7L0+4o0qqAxEOPE8Pidc/Itb4BkPiQph2Ej8ucRCMQUqE3t3UGnuKml2Jtso6Tax1JZpCdd/5Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au; spf=pass smtp.mailfrom=coker.com.au; dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b=n2VRWLno; arc=none smtp.client-ip=144.76.186.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coker.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
	s=2008; t=1737767397;
	bh=4EICXaoy2GVo4Y1iuFRbi5Srk68cUI0pBzMP+ek9egg=; l=1616;
	h=From:To:Reply-To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n2VRWLnoTasd+u/FSBf2Q2Zqd8yKZXbCtXUp1+qcpwjHZ79FsQKgpboS3FQJM1YUm
	 We3PImEwedcLvkvdcYFEkLumBZCnm5GOBD42NL0u/xaDiH9v5TJIEhaG7IUO+/cAOH
	 tUQ89EHdTVnVDhLa3wqKph/En+Bzn+Hc59Wa4fI4=
Received: from xev.localnet (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.sws.net.au (Postfix) with ESMTPS id AD287F351;
	Sat, 25 Jan 2025 12:09:52 +1100 (AEDT)
From: Russell Coker <russell@coker.com.au>
To: Miklos Szeredi <mszeredi@redhat.com>, Paul Moore <paul@paul-moore.com>
Reply-To: russell@coker.com.au
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
 Karel Zak <kzak@redhat.com>, Lennart Poettering <lennart@poettering.net>,
 Ian Kent <raven@themaw.net>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 selinux-refpolicy@vger.kernel.org
Subject: Re: [PATCH v4 2/4] fanotify: notify on mount attach and detach
Date: Sat, 25 Jan 2025 12:09:32 +1100
Message-ID: <2041942.usQuhbGJ8B@xev>
In-Reply-To:
 <CAHC9VhRzRqhXxcrv3ROChToFf4xX2Tdo--q-eMAc=KcUb=xb_w@mail.gmail.com>
References:
 <20250123194108.1025273-1-mszeredi@redhat.com>
 <20250123194108.1025273-3-mszeredi@redhat.com>
 <CAHC9VhRzRqhXxcrv3ROChToFf4xX2Tdo--q-eMAc=KcUb=xb_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Saturday, 25 January 2025 06:38:45 AEDT Paul Moore wrote:
> My initial thinking is that if we limit ourselves to existing SELinux
> policy permissions, this is much more of FILE__WATCH_MOUNT operation
> rather than a FILE__WATCH operation as while the /proc/PID/ns/mnt file
> specified in @path is simply a file, it represents much more than
> that.  However, it we want to consider adding a new SELinux policy
> permission (which is easy to do), we may want to consider adding a new
> mount namespace specific permission, e.g. FILE__WATCH_MOUNTNS, this
> would make it easier for policy developers to distinguish between
> watching a traditional mount point and a mount namespace (although
> given the common approaches to labeling this may not be very
> significant).  I'd personally like to hear from the SELinux policy
> folks on this (the SELinux reference policy has also been CC'd).
> 
> If we reuse the file/watch_mount permission the policy rule would look
> something like below where <subject> is the SELinux domain of the
> process making the change, and <mntns_label> is the label of the
> /proc/PID/ns/mnt file:
> 
>   allow <subject> <mntns_label>:file { watch_mount };
> 
> If we add a new file/watch_mountns permission the policy rule would
> look like this:
> 
>   allow <subject> <mntns_label>:file { watch_mountns };

What's the benefit in watching mount being separate from watching a namespace 
mount?

In what situation could a process be permitted one of those but not the other?

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/




