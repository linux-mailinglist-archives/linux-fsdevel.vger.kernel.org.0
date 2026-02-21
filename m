Return-Path: <linux-fsdevel+bounces-77838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QD7NGA75mGmoOgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 01:15:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F2816B87D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 01:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC7023036381
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 00:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91434A23;
	Sat, 21 Feb 2026 00:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gm1Xi3dv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E4DA55;
	Sat, 21 Feb 2026 00:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771632898; cv=none; b=Ox4wp08nfaGV8Iyx6BKHgvSqU8ECHSd6tJp1SU3mRa2aYHpNuUbRS/DaOsaVKCoL4gkfkr2AM+ReDaZz559c8eXoTrrN/NK5PmyK0PguoPBkbzfEZGQ6Mj3n2YsgWo1IG2OXYmkk7oGYWYdHl+Cpci1qx1Hiz3gckMPs05p4LVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771632898; c=relaxed/simple;
	bh=cPOXXeoMDDb6cE4js7btDJ4jN4yUD0fdZu49+gMi3ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIkXIRGhpwHa+OAcm12vUWxS5CC1pxZzpbmwMDUpnOLPPh3tLBEslZmk+1WJMVokExOmk9fZKpPX1JlOS8vbi5adHL9THeE77sHZ714600uXlIX4xI8RHmjpJV26gPItFQjETjGg9MYxmZvQYsPHDEKfp80jg0Iq6O+LG0qW0jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gm1Xi3dv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBCAC116C6;
	Sat, 21 Feb 2026 00:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771632898;
	bh=cPOXXeoMDDb6cE4js7btDJ4jN4yUD0fdZu49+gMi3ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gm1Xi3dvnq5YtpVfl8JZPdsvzTXmuk1XT3ncjNDt44oMBe4yZg+FDZPRwBfmp9Sjv
	 cv1Yr+UqCemI4ia6PBzyOHRi0++Z1Kq4oDpMuPS9YQH1gis6iaSJw6gIAP68HStvoe
	 OcBAsgmA7nb3AqMD+2rFEUT9VjI6rE0WRr3GtrGut91Amhcr5WcVXwwxr2FstBRtGI
	 dNOQ2tvoS9DHSk6RZJwsPyqSQpYK4hfzDHUBqIG1AfSb4eizZbIca91x7CH1UWFdFG
	 0P2o+/8TnoL7W6ofnLu1E6SawJYbif5Jo5k0/Jn0ZHY2k5k3FZwbWx+0MQsuTu4Y/q
	 7OGxSkv+jbZyA==
Date: Fri, 20 Feb 2026 16:14:57 -0800
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
Message-ID: <20260221001457.GC11076@frogsfrogsfrogs>
References: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
 <20260220004454.GR6467@frogsfrogsfrogs>
 <20260220-biobauer-beilhieb-2e792f9453cf@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220-biobauer-beilhieb-2e792f9453cf@brauner>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77838-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B6F2816B87D
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 10:23:55AM +0100, Christian Brauner wrote:
> On Thu, Feb 19, 2026 at 04:44:54PM -0800, Darrick J. Wong wrote:
> > On Mon, Feb 16, 2026 at 02:31:56PM +0100, Christian Brauner wrote:
> > > Hey,
> > > 
> > > This reworks the simple_xattr infrastructure and adds support for
> > > user.* extended attributes on sockets.
> > > 
> > > The simple_xattr subsystem currently uses an rbtree protected by a
> > > reader-writer spinlock. This series replaces the rbtree with an
> > > rhashtable giving O(1) average-case lookup with RCU-based lockless
> > > reads. This sped up concurrent access patterns on tmpfs quite a bit and
> > > it's an overall easy enough conversion to do and gets rid or rwlock_t.
> > > 
> > > The conversion is done incrementally: a new rhashtable path is added
> > > alongside the existing rbtree, consumers are migrated one at a time
> > > (shmem, kernfs, pidfs), and then the rbtree code is removed. All three
> > > consumers switch from embedded structs to pointer-based lazy allocation
> > > so the rhashtable overhead is only paid for inodes that actually use
> > > xattrs.
> > 
> > Patches 1-6 look ok to me, at least in the sense that nothing stood out
> > to me as obviously wrong, so
> > Acked-by: "Darrick J. Wong" <djwong@kernel.org>
> > 
> > > With this infrastructure in place the series adds support for user.*
> > > xattrs on sockets. Path-based AF_UNIX sockets inherit xattr support
> > > from the underlying filesystem (e.g. tmpfs) but sockets in sockfs -
> > > that is everything created via socket() including abstract namespace
> > > AF_UNIX sockets - had no xattr support at all.
> > > 
> > > The xattr_permission() checks are reworked to allow user.* xattrs on
> > > S_IFSOCK inodes. Sockfs sockets get per-inode limits of 128 xattrs and
> > > 128KB total value size matching the limits already in use for kernfs.
> > > 
> > > The practical motivation comes from several directions. systemd and
> > > GNOME are expanding their use of Varlink as an IPC mechanism. For D-Bus
> > > there are tools like dbus-monitor that can observe IPC traffic across
> > > the system but this only works because D-Bus has a central broker. For
> > > Varlink there is no broker and there is currently no way to identify
> > 
> > Hum.  I suppose there's never going to be a central varlink broker, is
> > there?  That doesn't sound great for discoverability, unless the plan is
> 
> Varlink was explicitly designed to avoid having to have a broker.
> Practically it would have been one option to have a a central registry
> maintained as a bpf socket map. My naive take had always been something
> like: systemd can have a global socket map. sockets are picked up
> whenver the appropriate xattr is set and deleted from the map once the
> socket goes away (or the xattr is unset). Right now this is something
> that would require capabilities. Once signed bpf is more common it is
> easy to load that on per-container basis. But...
> 
> > to try to concentrate them in (say) /run/varlink?  But even then, could
> 
> ... the future is already here :)
> 
>   https://github.com/systemd/systemd/pull/40590
> 
> All public varlink services that are supposed to be announced are now
> symlinked into:
> 
>   /run/varlink/registry
> 
> There are of-course non-public interfaces such as the interface
> between PID 1 and oomd. Such interfaces are not exposed.
> 
> It's also possible to have per user registries at e.g.:
> 
>   /run/user/1000/varlink/registry/
> 
> Such varlink services can now also be listed via:
> 
>   valinkctl list-services
> 
> This then ties very neatly into the varlink bridge we're currently
> building:
> 
>   https://github.com/mvo5/varlink-http-bridge
> 
> It takes a directory with varlink sockets (or symlinks to varlink
> sockets) like /run/varlink/registry as the argument and will serve
> whatever it finds in there. Sockets can be added or removed dynamically
> in the dir as needed:
> 
>   curl -s http://localhost:8080/sockets | jq
>   {
>     "sockets": [
>       "io.systemd.Login",
>       "io.systemd.Hostname",
>       "io.systemd.sysext",
>       "io.systemd.BootControl",
>       "io.systemd.Import",
>       "io.systemd.Repart",
>       "io.systemd.MuteConsole",
>       "io.systemd.FactoryReset",
>       "io.systemd.Credentials",
>       "io.systemd.AskPassword",
>       "io.systemd.Manager",
>       "io.systemd.ManagedOOM"
>     ]
>   }
> 
> The xattrs allow to have a completely global view of such services and
> the per-user sessions all have their own sub-view.
> 
> > you have N services that share the same otherwise private tmpfs in order
> > to talk to each other via a varlink socket?  I suppose in that case, the
> 
> Yeah sure that's one way.
> 
> > N services probably don't care/want others to discover their socket.
> > 
> > > which sockets speak Varlink. With user.* xattrs on sockets a service
> > > can label its socket with the IPC protocol it speaks (e.g.,
> > > user.varlink=1) and an eBPF program can then selectively capture
> > 
> > Who gets to set xattrs?  Can a malicious varlink socket user who has
> > connect() abilities also delete user.varlink to mess with everyone who
> > comes afterwards?
> 
> The main focus is AF_UNIX sockets of course so a varlink service does:
> 
>   fd = socket(AF_UNIX)
>   umask(0117);
>   bind(fd, "/run/foobar");
>   umask(original_umask);
>   chown("/run/foobar", -1, MYACCESSGID);
>   setxattr("/run/foobar", "user.varlink", "1");
> 
> For non-path based sockets the inodes for client and server are
> inherently distinct so they cannot interfer with each other. But even
> then a chmod() + chown(-1, MYACCESSGID) on the sockfs socket fd will
> protect this.
> 
> Thanks for the review. Please keep going. :)

The rest look fine too, modulo my comments about the fixed limits.

Acked-by: "Darrick J. Wong" <djwong@kernel.org>

--D

