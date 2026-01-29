Return-Path: <linux-fsdevel+bounces-75871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJDmMpmBe2mvFAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 16:49:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A092B19F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 16:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B650A30265B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 15:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41482F7449;
	Thu, 29 Jan 2026 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQzdGwJZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9C8218E91;
	Thu, 29 Jan 2026 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769701757; cv=none; b=Qs8QUzT6i9muNgcnYmBub0vBVSkmiC8AWDtWtEcow76xBCCDZowbQs77TS69bD98fRueEcaXd5Wfhq30kBNOObOtFzGAg63UbCVY/19hbYLIgGak/GInmCbbma8F1tRxoD6xFQ8YKCWPcZYeO5iclOczyUge/Qmmpa9FRrTgO2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769701757; c=relaxed/simple;
	bh=mNAdcd8Uug5E9TbgdvTMNslor1NXEZZ9HmmtiVPHXh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAWvPn4KRsRpnkO/ysxHKsDyloGWxPzZqKx8k+7Et4/b4ElGgF6NcjiYJau310GXgTzWEwawddZWc/DiRzJCvF/WlbZHsWp0IlzLLyv7N/jNExpo63ZWo/l9hUe7TQ7y9sxqdqh/+JAQOC6GUOX0T5llhBThCNRRq7EJ6mlUZEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQzdGwJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC22BC116D0;
	Thu, 29 Jan 2026 15:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769701757;
	bh=mNAdcd8Uug5E9TbgdvTMNslor1NXEZZ9HmmtiVPHXh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hQzdGwJZtSr0QTo8S3qI9F4gHLh2RPuVCxs7vSCUNFvIsvIGiJ1fLWVJNNxpKUrUe
	 PszPtgl7+U41M0bymKaRFW86CFYXjAkdfLc62L7fzV1eFj7svYBRDQSR8SQkelvtdl
	 FznGDQ2piYr7VYSmC89bopZRVyfAIgRAw4HIyy1KL/xmeItml9EDadQcOFd9u6yTo+
	 x8IyQ6Mv+xUsMy0hnSUg7462JV5GzhKnY2uOsyAU1p958TDLG0jADhc98QkcjYJtcY
	 6louAHlJdFZR/RKmlApn+tbAwtcfq05AdSj6N+PHjiFQ38EhN+O64+V5MFs2zsm35Q
	 G+PwMxZA4vwrQ==
Date: Thu, 29 Jan 2026 16:49:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] fs: don't allow non-init s_user_ns for filesystems
 without FS_USERNS_MOUNT
Message-ID: <20260129-zielgebiet-zutiefst-d9d9cb902f1b@brauner>
References: <20240724-s_user_ns-fix-v1-1-895d07c94701@kernel.org>
 <b02d93c9cd1ccda04127031155ec9b4c29ee69d5.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b02d93c9cd1ccda04127031155ec9b4c29ee69d5.camel@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75871-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,gmail.com,cyphar.com,mihalicyn.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A092B19F0
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 09:36:54AM -0500, Jeff Layton wrote:
> On Wed, 2024-07-24 at 09:53 -0500, Seth Forshee (DigitalOcean) wrote:
> > Christian noticed that it is possible for a privileged user to mount
> > most filesystems with a non-initial user namespace in sb->s_user_ns.
> > When fsopen() is called in a non-init namespace the caller's namespace
> > is recorded in fs_context->user_ns. If the returned file descriptor is
> > then passed to a process priviliged in init_user_ns, that process can
> > call fsconfig(fd_fs, FSCONFIG_CMD_CREATE), creating a new superblock
> > with sb->s_user_ns set to the namespace of the process which called
> > fsopen().
> > 
> > This is problematic. We cannot assume that any filesystem which does not
> > set FS_USERNS_MOUNT has been written with a non-initial s_user_ns in
> > mind, increasing the risk for bugs and security issues.
> > 
> > Prevent this by returning EPERM from sget_fc() when FS_USERNS_MOUNT is
> > not set for the filesystem and a non-initial user namespace will be
> > used. sget() does not need to be updated as it always uses the user
> > namespace of the current context, or the initial user namespace if
> > SB_SUBMOUNT is set.
> > 
> > Fixes: cb50b348c71f ("convenience helpers: vfs_get_super() and sget_fc()")
> > Reported-by: Christian Brauner <brauner@kernel.org>
> > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> > ---
> >  fs/super.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/fs/super.c b/fs/super.c
> > index 095ba793e10c..d681fb7698d8 100644
> > --- a/fs/super.c
> > +++ b/fs/super.c
> > @@ -736,6 +736,17 @@ struct super_block *sget_fc(struct fs_context *fc,
> >  	struct user_namespace *user_ns = fc->global ? &init_user_ns : fc->user_ns;
> >  	int err;
> >  
> > +	/*
> > +	 * Never allow s_user_ns != &init_user_ns when FS_USERNS_MOUNT is
> > +	 * not set, as the filesystem is likely unprepared to handle it.
> > +	 * This can happen when fsconfig() is called from init_user_ns with
> > +	 * an fs_fd opened in another user namespace.
> > +	 */
> > +	if (user_ns != &init_user_ns && !(fc->fs_type->fs_flags & FS_USERNS_MOUNT)) {
> > +		errorfc(fc, "mounting from non-initial user namespace is not allowed");
> > +		return ERR_PTR(-EPERM);
> > +	}
> > +
> >  retry:
> >  	spin_lock(&sb_lock);
> >  	if (test) {
> > 
> > ---
> > base-commit: 256abd8e550ce977b728be79a74e1729438b4948
> > change-id: 20240723-s_user_ns-fix-b00c31de1cb8
> > 
> > Best regards,
> 
> I sent an incorrect RFC patch for this yesterday, but this patch breaks

Oh? I did not see it.

> NFS mounting in containers for us, as the prohibited activity is
> exactly the process we use to do them.
> 
> We basically have a task in the container do an fsopen() and then pass
> the fd to a daemon in the init namespace via unix socket. The daemon
> vets the NFS mount parameters (ensuring that the mount options are
> sane, and that we trust the server), and then does the mount inside the
> container.

The mountfsd model - kinda.

> 
> We don't want to set FS_USERNS_MOUNT on NFS, because that would give
> the container carte blanche to mount anything it likes, even a
> malicious server. Do we need to split that flag into two? Maybe
> FS_USERNS_SAFE and FS_USERNS_MOUNT?

I think you can simply add FS_USERNS_DELEGATABLE and raise it for nfs.

