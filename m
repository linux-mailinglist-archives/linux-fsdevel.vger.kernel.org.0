Return-Path: <linux-fsdevel+bounces-79581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOUqBJOhqmlLUgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 10:42:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD7B21E1E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 10:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FC063020FD6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 09:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E29833A9F3;
	Fri,  6 Mar 2026 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HH0dSpc/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D84346AE8;
	Fri,  6 Mar 2026 09:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772790131; cv=none; b=r6g2Aua1Hu4F1lyQvcxyszVjmmIunal5scxRTYLX1zXme1ZF+uSMQ2MI+sf/VTMfKeg7ukUtrcmK4zPly8qjFau+zrBZpwyX2ghj78d5ajoXC30MFij2eKX8LgaW/eSbgsEdquo+L1CpTOOOScOuPgK9NZLzIektXRu5io3pMjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772790131; c=relaxed/simple;
	bh=fFg7aWjPxphbulTb79Nt+ZDPqV4b3jllfkrmJmykajI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GE1Q2pAwymuqcA54dQSbWRgjeHGvmmSdnJbGHLBMijanWrvk60n7hlT/Vwj5SFUSfM7HFVIuBNWEcskVlBoDp7tOHWNbfNlMxP9CWEobVHUHN2yEY69h9Wf65K7tGSaQ186HUpSBVY/t3TuEfVcFK65+xtuccZ2EJWk4z2roPZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HH0dSpc/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42949C4CEF7;
	Fri,  6 Mar 2026 09:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772790130;
	bh=fFg7aWjPxphbulTb79Nt+ZDPqV4b3jllfkrmJmykajI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HH0dSpc/NY5W6vJribQ+0/VUib+ntzCMXwsF44TqYjP1DQJWwC4t2dC/dm+Mi9VCk
	 o33dauJ6s4cCsTKppZWf2FouzNEPL7RkNJM2sQRR0OWzENbwBdn2ID0ImWSfUdYA3d
	 G6Ycyw5KRr1tlQpXPgOg/TNKn/xLOUpRQJQZzub+CTcJdgW5iyjjUZtTDAAdL3bOoz
	 15PnfIMPjE5DIc5W/D+cnLdq1HvN4kM0cGlnEspFGoym/UwjmuTFDwMIkZgkeyX7o3
	 MH8iwSDfyPNa88MIts0uDSl97VM/yIsxUbTn60rD8OhRvxA6r4Zhu3gGkF95tj8S8t
	 F7xNzkhP59KAA==
Date: Fri, 6 Mar 2026 10:42:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, John Johansen <john.johansen@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v3 05/15] Apparmor: Use simple_start_creating() /
 simple_done_creating()
Message-ID: <20260306-fastnacht-kernig-3b350bd2fab0@brauner>
References: <20260224222542.3458677-1-neilb@ownmail.net>
 <20260224222542.3458677-6-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260224222542.3458677-6-neilb@ownmail.net>
X-Rspamd-Queue-Id: 0DD7B21E1E5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79581-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,kernel.org,szeredi.hu,gmail.com,canonical.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 09:16:50AM +1100, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> Instead of explicitly locking the parent and performing a look up in
> apparmor, use simple_start_creating(), and then simple_done_creating()
> to unlock and drop the dentry.
> 
> This removes the need to check for an existing entry (as
> simple_start_creating() acts like an exclusive create and can return
> -EEXIST), simplifies error paths, and keeps dir locking code
> centralised.
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---

Fwiw, I think this fixes a reference count leak:

The old aafs_create returned dentries with refcount=2 (one from
lookup_noperm, one from dget in __aafs_setup_d_inode). The cleanup path
aafs_remove puts one reference leaving one reference that didn't get
cleaned up.

After your changes this is now correct as simple_done_creating() puts
the lookup reference.

