Return-Path: <linux-fsdevel+bounces-77757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLagLIyul2nO5QIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 01:45:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A91D163F48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 01:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D00DB300DF51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 00:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BC921B9F6;
	Fri, 20 Feb 2026 00:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNgrOn2F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84F91F5825;
	Fri, 20 Feb 2026 00:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771548295; cv=none; b=Gtfg3LLZfVfUnU2ND3gBJZMuFV/2axE5B0LAjR12ttIFMPfJMx/vssw0D+cIvbQjHogZeYxFvhq5ypaQ1g8amuWkzJfxI5qd/3OyOMi7oSMMfPE9By+lTO1daYFtdNUZ0n23tPPkHyqAZjMn8lbe3FmL7+vvrYuLCUtXlILfTE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771548295; c=relaxed/simple;
	bh=kagJ+UlIdLhqkqspgrp0oS3pZa0ipNhQ034OQlfEeFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEWdGua1S3LW9FjZMFF/VlyRj06+zbvncYDMYg/GG3ZhWmY5GvtK+bNqY3pRljdhZ7fF2lpjpTwQlswN+Yv+ictA8PF+vtF14BIByDb+PqTgLDHwPPIXjvw6OyquJBUtNYi99U5a2+1qB7i7r89vb+7wZSga6v2L34+prv7V2no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNgrOn2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847DCC4CEF7;
	Fri, 20 Feb 2026 00:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771548295;
	bh=kagJ+UlIdLhqkqspgrp0oS3pZa0ipNhQ034OQlfEeFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iNgrOn2FjR7+xFM/Tus8NkYomQ/mZXHDMoEg2Ks1LLulQRPBoVawVhUJLwQjt36Po
	 YyrJsb863cKScPUVC9qF3gpeYWh+eTIs0jNcVwrl0A/zcWKRrKQXwS0vbmbTLjdqW1
	 wlZAw/+Sj7fVU+aC73t335JuSCkVltl/wUxzo4oq2oiig4DsYbQ7IhD8tncmYsH+XS
	 OqklRFg5TRKLiMOK3S1IyBB7AMBMDhc7kgSiKRBGFKZMbZxhdmaY/tNAmw1uB0Vu8f
	 AQqsqtBQ+VS8i6HkYSrzjPX0RKcxkA9Nt/eFkvZZKrtV6PfcuJayphZ7c2SVGLXTRn
	 RMUZQXkbI5mHA==
Date: Thu, 19 Feb 2026 16:44:54 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
	linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jann Horn <jannh@google.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 00/14] xattr: rework simple xattrs and support user.*
 xattrs on sockets
Message-ID: <20260220004454.GR6467@frogsfrogsfrogs>
References: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77757-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A91D163F48
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 02:31:56PM +0100, Christian Brauner wrote:
> Hey,
> 
> This reworks the simple_xattr infrastructure and adds support for
> user.* extended attributes on sockets.
> 
> The simple_xattr subsystem currently uses an rbtree protected by a
> reader-writer spinlock. This series replaces the rbtree with an
> rhashtable giving O(1) average-case lookup with RCU-based lockless
> reads. This sped up concurrent access patterns on tmpfs quite a bit and
> it's an overall easy enough conversion to do and gets rid or rwlock_t.
> 
> The conversion is done incrementally: a new rhashtable path is added
> alongside the existing rbtree, consumers are migrated one at a time
> (shmem, kernfs, pidfs), and then the rbtree code is removed. All three
> consumers switch from embedded structs to pointer-based lazy allocation
> so the rhashtable overhead is only paid for inodes that actually use
> xattrs.

Patches 1-6 look ok to me, at least in the sense that nothing stood out
to me as obviously wrong, so
Acked-by: "Darrick J. Wong" <djwong@kernel.org>

> With this infrastructure in place the series adds support for user.*
> xattrs on sockets. Path-based AF_UNIX sockets inherit xattr support
> from the underlying filesystem (e.g. tmpfs) but sockets in sockfs -
> that is everything created via socket() including abstract namespace
> AF_UNIX sockets - had no xattr support at all.
> 
> The xattr_permission() checks are reworked to allow user.* xattrs on
> S_IFSOCK inodes. Sockfs sockets get per-inode limits of 128 xattrs and
> 128KB total value size matching the limits already in use for kernfs.
> 
> The practical motivation comes from several directions. systemd and
> GNOME are expanding their use of Varlink as an IPC mechanism. For D-Bus
> there are tools like dbus-monitor that can observe IPC traffic across
> the system but this only works because D-Bus has a central broker. For
> Varlink there is no broker and there is currently no way to identify

Hum.  I suppose there's never going to be a central varlink broker, is
there?  That doesn't sound great for discoverability, unless the plan is
to try to concentrate them in (say) /run/varlink?  But even then, could
you have N services that share the same otherwise private tmpfs in order
to talk to each other via a varlink socket?  I suppose in that case, the
N services probably don't care/want others to discover their socket.

> which sockets speak Varlink. With user.* xattrs on sockets a service
> can label its socket with the IPC protocol it speaks (e.g.,
> user.varlink=1) and an eBPF program can then selectively capture

Who gets to set xattrs?  Can a malicious varlink socket user who has
connect() abilities also delete user.varlink to mess with everyone who
comes afterwards?

--D

> traffic on those sockets. Enumerating bound sockets via netlink combined
> with these xattr labels gives a way to discover all Varlink IPC
> entrypoints for debugging and introspection.
> 
> Similarly, systemd-journald wants to use xattrs on the /dev/log socket
> for protocol negotiation to indicate whether RFC 5424 structured syslog
> is supported or whether only the legacy RFC 3164 format should be used.
> 
> In containers these labels are particularly useful as high-privilege or
> more complicated solutions for socket identification aren't available.
> 
> The series comes with comprehensive selftests covering path-based
> AF_UNIX sockets, sockfs socket operations, per-inode limit enforcement,
> and xattr operations across multiple address families (AF_INET,
> AF_INET6, AF_NETLINK, AF_PACKET).
> 
> Christian
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> Christian Brauner (14):
>       xattr: add rcu_head and rhash_head to struct simple_xattr
>       xattr: add rhashtable-based simple_xattr infrastructure
>       shmem: adapt to rhashtable-based simple_xattrs with lazy allocation
>       kernfs: adapt to rhashtable-based simple_xattrs with lazy allocation
>       pidfs: adapt to rhashtable-based simple_xattrs
>       xattr: remove rbtree-based simple_xattr infrastructure
>       xattr: add xattr_permission_error()
>       xattr: switch xattr_permission() to switch statement
>       xattr: move user limits for xattrs to generic infra
>       xattr,net: support limited amount of extended attributes on sockfs sockets
>       xattr: support extended attributes on sockets
>       selftests/xattr: path-based AF_UNIX socket xattr tests
>       selftests/xattr: sockfs socket xattr tests
>       selftests/xattr: test xattrs on various socket families
> 
>  fs/kernfs/dir.c                                    |  15 +-
>  fs/kernfs/inode.c                                  |  99 +----
>  fs/kernfs/kernfs-internal.h                        |   5 +-
>  fs/pidfs.c                                         |  65 +--
>  fs/xattr.c                                         | 423 +++++++++++++------
>  include/linux/kernfs.h                             |   2 -
>  include/linux/shmem_fs.h                           |   2 +-
>  include/linux/xattr.h                              |  47 ++-
>  mm/shmem.c                                         |  46 +-
>  net/socket.c                                       | 119 ++++--
>  .../testing/selftests/filesystems/xattr/.gitignore |   3 +
>  tools/testing/selftests/filesystems/xattr/Makefile |   6 +
>  .../filesystems/xattr/xattr_socket_test.c          | 470 +++++++++++++++++++++
>  .../filesystems/xattr/xattr_socket_types_test.c    | 177 ++++++++
>  .../filesystems/xattr/xattr_sockfs_test.c          | 363 ++++++++++++++++
>  15 files changed, 1547 insertions(+), 295 deletions(-)
> ---
> base-commit: 72c395024dac5e215136cbff793455f065603b06
> change-id: 20260211-work-xattr-socket-c85f4d3b8847
> 
> 

