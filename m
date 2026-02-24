Return-Path: <linux-fsdevel+bounces-78292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDV4CeHbnWmuSQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 18:12:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E16618A5C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 18:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 811B13054CA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 17:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4FA3A962E;
	Tue, 24 Feb 2026 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="h9zAcR4K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3454E267B89;
	Tue, 24 Feb 2026 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771953118; cv=none; b=tpPilPQ3+Ws9j5uV0PFEVWnBkTcVE6kMQ0ZwCnLzknjyOpWhDXB3Vn+Z/r1ZQD7wGSZdnCTF1GjhnV0t1LTwnTnMGuwc+zgEsLwHhY1oVZW+CmR5zl39a27T+YJk62lnTetfJovVbbbEk9qVj91NHRxvsnwYyj3iTO4LhdUUm/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771953118; c=relaxed/simple;
	bh=fHefDfdm0n6JimB8n6xsWaDVbDBmBtXkjCmtt0Tpcts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ej3i4OtKVDsctl31XtbPZWarNxgxJuT5qT55SqTkiMnk64T2zYMwwzFp7idak1Q7qLb5XYA11VDN1X0CgpLTrdb7JpHIIZS0g3MKxah9umjcg6RZg14Q90LyntizsaWhq4xnvekZcIvEmIW2wOC+ybPuydFZobp7MLXWW8wvJQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=h9zAcR4K; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IoWLUMxYdlJU6EkJ9Y0ZgFZ/YyvMOxBV0g8GlXWHBXY=; b=h9zAcR4KbHgBJXJSCMotZHbKvH
	x6wmXy5yb6U+f6Nb85Tcn36fPrf6PoqVyZ3MCk3widDxGuMDxyf9VIWTNQuuULWjumGBohwBEkM1y
	XednYRTr0LHci8m2L7ln1vzXonzKuTf0+eK0/z+fId6sgD7mzb664lu52KDtgfejo/I2JlBYE8lqP
	Ey+FvzbtBkR0QifQhx8kDIaYe08g+e4siR/ii2yTeJD8yiufESg2nsnxFh1zn+S+zZXYFK23Ew6nt
	d8Vbg2yLP12EpwG1/0nFiOlen/fpL+APt8HfMM/2HfcGjDqAzTIDHu+1d1ex/ZHFTvbkOnkyGzvJw
	Vl15qBfw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vuvzM-0000000BMZq-0EVm;
	Tue, 24 Feb 2026 17:14:24 +0000
Date: Tue, 24 Feb 2026 17:14:24 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neilb@ownmail.net>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 0/3] Automatic NFSv4 state revocation on filesystem
 unmount
Message-ID: <20260224171424.GC1762976@ZenIV>
References: <20260224163908.44060-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224163908.44060-1-cel@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78292-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 8E16618A5C3
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 11:39:05AM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> When an NFS server exports a filesystem and clients hold NFSv4 state
> (opens, locks, delegations), unmounting the underlying filesystem
> fails with EBUSY. The /proc/fs/nfsd/unlock_fs interface exists for
> administrators to manually revoke state before retrying the unmount,
> but this approach has significant operational drawbacks.
> 
> Manual intervention breaks automation workflows. Containerized NFS
> servers, orchestration systems, and unattended maintenance scripts
> cannot reliably unmount exported filesystems without implementing
> custom logic to detect the failure and invoke unlock_fs. System
> administrators managing many exports face tedious, error-prone
> procedures when decommissioning storage.
> 
> This series enables the NFS server to detect filesystem unmount
> events and automatically revoke associated state. The mechanism
> registers with a new SRCU notifier chain in VFS that fires during
> mount teardown, after processing stuck children but before
> fsnotify_vfsmount_delete(), while SB_ACTIVE is still set. When a
> filesystem is unmounted, all NFSv4 opens, locks, and delegations
> referencing it are revoked, async COPY operations are cancelled
> with NFS4ERR_ADMIN_REVOKED sent to clients, NLM locks are released,
> and cached file handles are closed.
> 
> With automatic revocation, unmount operations complete without
> administrator intervention once the brief state cleanup finishes.
> Clients receive immediate notification of state loss through
> standard NFSv4 error codes, allowing applications to handle the
> situation appropriately rather than encountering silent failures.

So anyone can force that just with unshare -U -m date?  Creates
a new namespace, populated by clones of all mounts you see, runs
date(1) in that, then exits, with namespace dissolved.  At that
point all cloned mounts are released, each triggering your notifier
chain...

