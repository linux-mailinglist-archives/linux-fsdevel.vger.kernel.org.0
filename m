Return-Path: <linux-fsdevel+bounces-67627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F8BC44984
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 23:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53FDE4E4E38
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 22:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1010426D4C4;
	Sun,  9 Nov 2025 22:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="YmAbICQw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp153-168.sina.com.cn (smtp153-168.sina.com.cn [61.135.153.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C5326D4CD
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 22:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762728987; cv=none; b=o+MNb29l1GRnthg+xV8vg9tzx0CDPSPEdMkIGGgg1FLHg4Sy0KS+nU3pOwuvzKaK9+zLFIWOKEqyVNiYcwNZVeCm9fdwPacqhfQAwgk6YaKBkqLjNRIZGcVjJcVvAcJts/+HZbRAVRgoSDuP68ouUPKk0h7BfogWu0pIWc3FHak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762728987; c=relaxed/simple;
	bh=zvM5L82UsovszDgGDQwBgPaonvekrGjz9aSleaGG4HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y35APcTaYo5A6ufDYJMX+pQesl9IfwMd00gb/VH/lGz4JLsiXUJiLsLDvJOJ+wS1ohwq3awwMWoLZIfRks6xJABkNc/k0Tm5gPmJtg6QEfjjifAt2iFtClVTEW/FdZEasLMIVdzvyp7e3qXIPrfIlf6B/mh0PDNYRvpz3FYYWMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=YmAbICQw; arc=none smtp.client-ip=61.135.153.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1762728977;
	bh=X3sgMONdGnK9HZSlZmsqzfDs/H21WbjKzGNdhC1T2Yo=;
	h=From:Subject:Date:Message-ID;
	b=YmAbICQwYaDco9zHZY3AXfJipcWXvATv9NeCaWyyrySjGo6pVGM44ZeGML06QbaTz
	 BSTWF0x1QiGS3K87ZoQuJGjU/ekWB2LNclbLIZ8t2hWFzhF3XCt5pVhjqGG7xhaOQ4
	 Ws/p5WpW4H0kTwyNyPReCb5O73C3EaHbXPEa+6tc=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.57.85])
	by sina.com (10.54.253.33) with ESMTP
	id 69111BE800007E0D; Sun, 10 Nov 2025 06:55:38 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7950016685186
X-SMAIL-UIID: 211698EDDDFC497485E9AE18BBA73E18-20251110-065538-1
From: Hillf Danton <hdanton@sina.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com
Subject: Re: [PATCH 0/8] ns: fixes for namespace iteration and active reference counting
Date: Mon, 10 Nov 2025 06:55:26 +0800
Message-ID: <20251109225528.9063-1-hdanton@sina.com>
In-Reply-To: <20251109-namespace-6-19-fixes-v1-0-ae8a4ad5a3b3@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 09 Nov 2025 22:11:21 +0100 Christian Brauner wrote:
> * Make sure to initialize the active reference count for the initial
>   network namespace and prevent __ns_common_init() from returning too
>   early.
> 
> * Make sure that passive reference counts are dropped outside of rcu
>   read locks as some namespaces such as the mount namespace do in fact
>   sleep when putting the last reference.
> 
> * The setns() system call supports:
> 
>   (1) namespace file descriptors (nsfd)
>   (2) process file descriptors (pidfd)
> 
>   When using nsfds the namespaces will remain active because they are
>   pinned by the vfs. However, when pidfds are used things are more
>   complicated.
> 
>   When the target task exits and passes through exit_nsproxy_namespaces()
>   or is reaped and thus also passes through exit_cred_namespaces() after
>   the setns()'ing task has called prepare_nsset() but before the active
>   reference count of the set of namespaces it wants to setns() to might
>   have been dropped already:
> 
>     P1                                                              P2
> 
>     pid_p1 = clone(CLONE_NEWUSER | CLONE_NEWNET | CLONE_NEWNS)
>                                                                     pidfd = pidfd_open(pid_p1)
>                                                                     setns(pidfd, CLONE_NEWUSER | CLONE_NEWNET | CLONE_NEWNS)
>                                                                     prepare_nsset()
> 
>     exit(0)
>     // ns->__ns_active_ref        == 1
>     // parent_ns->__ns_active_ref == 1
>     -> exit_nsproxy_namespaces()
>     -> exit_cred_namespaces()
> 
>     // ns_active_ref_put() will also put
>     // the reference on the owner of the
>     // namespace. If the only reason the
>     // owning namespace was alive was
>     // because it was a parent of @ns
>     // it's active reference count now goes
>     // to zero... --------------------------------
>     //                                           |
>     // ns->__ns_active_ref        == 0           |
>     // parent_ns->__ns_active_ref == 0           |
>                                                  |                  commit_nsset()
>                                                  -----------------> // If setns()
>                                                                     // now manages to install the namespaces
>                                                                     // it will call ns_active_ref_get()
>                                                                     // on them thus bumping the active reference
>                                                                     // count from zero again but without also
>                                                                     // taking the required reference on the owner.
>                                                                     // Thus we get:
>                                                                     //
>                                                                     // ns->__ns_active_ref        == 1
>                                                                     // parent_ns->__ns_active_ref == 0
> 
>     When later someone does ns_active_ref_put() on @ns it will underflow
>     parent_ns->__ns_active_ref leading to a splat from our asserts
>     thinking there are still active references when in fact the counter
>     just underflowed.
> 
>   So resurrect the ownership chain if necessary as well. If the caller
>   succeeded to grab passive references to the set of namespaces the
>   setns() should simply succeed even if the target task exists or gets
>   reaped in the meantime.
> 
>   The race is rare and can only be triggered when using pidfs to setns()
>   to namespaces. Also note that active reference on initial namespaces are
>   nops.
> 
>   Since we now always handle parent references directly we can drop
>   ns_ref_active_get_owner() when adding a namespace to a namespace tree.
>   This is now all handled uniformly in the places where the new namespaces
>   actually become active.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>
FYI namespace-6.19.fixes failed to survive the syzbot test [1].

[1] Subject: Re: [syzbot] [lsm?] WARNING in put_cred_rcu
https://lore.kernel.org/lkml/690eedba.a70a0220.22f260.0075.GAE@google.com/

