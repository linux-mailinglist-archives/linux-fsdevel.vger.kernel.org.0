Return-Path: <linux-fsdevel+bounces-76212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ElCH0klgmnPPgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 17:41:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCE1DC235
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 17:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B23D300BE13
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 16:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4583D301F;
	Tue,  3 Feb 2026 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjBobyeI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354F03D3301;
	Tue,  3 Feb 2026 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770136893; cv=none; b=J/Ub/arW/7v3ybC9KC7wHy/1UkW9FHFGA23/OicnWsUMUZxoH2Xx88NioUkGbgjb7Febjt/Kdk0hePYQHhHY33wHEZv9KRCsbwzPZt104AXfDtbiFPj7gxsNDpSPGFYvXndqKuLCNXBJr1l7ufk73xjt1poo4UyO3xoXyJKM7v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770136893; c=relaxed/simple;
	bh=tW1eYl+a9sW/JQZvQ2ON2oiBabyjKg0BQu60S3KbD7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEXW4JmewZk5McjCBFObnWAGFtU6HSEB+GpYiaPVPSHSgByrUW/ZXzzHrlqJMG5dctwo7xEsOAk/Bu5NA69xpJ2HJmPb57EUwz1OrZ45Wi6oXil3A5sW+ioSm53q0xPtD4DA4lfoTy9oGU8plQM9n1lXzHFC3cP/8asf6zjwM7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjBobyeI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E16DC116D0;
	Tue,  3 Feb 2026 16:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770136892;
	bh=tW1eYl+a9sW/JQZvQ2ON2oiBabyjKg0BQu60S3KbD7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QjBobyeIL9EpSMGxyl9aXb735hLJIj8ykH9ILNNZqcgsd5KyWWB7O/zo3WWF64p8a
	 qqc7LSAnovHAyeOMfF0EPeRMspnki4P5qnYsWi6uorM/xml4Vq72nQPxOEF8Bl4Ve6
	 FmV67DsFIzdGcE+iIh+4ENqgdBXhixAg9hi/DAERxq+p5DSAuHjh6xafd3BFlchYOF
	 aUflVPEeveYGNxkqr09iVXHJ4oniGjf/U1Qkdp4NJaU0x8hz6o0c1BxeBp1PLkZUox
	 3J5Q+utdZ5g2x/cYbrpkblIC2Mhg8G2AQxJdjChTdQ4PQ+JpbIziOr10omcSToG2lf
	 ekiMo2hDtyN5w==
Date: Tue, 3 Feb 2026 17:41:27 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	"Seth Forshee (DigitalOcean)" <sforshee@kernel.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: add FS_USERNS_DELEGATABLE flag and set it for NFS
Message-ID: <20260203-genehm-senden-f0375c2ca2b6@brauner>
References: <20260129-twmount-v1-1-4874ed2a15c4@kernel.org>
 <CAJqdLrphO1GnAZ2=n8wQAP7B+ZwFnD0wSLY7sAjacZTpLZrqBg@mail.gmail.com>
 <6dd181bf9f6371339a6c31f58f582a9aac3bc36a.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6dd181bf9f6371339a6c31f58f582a9aac3bc36a.camel@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-76212-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7CCE1DC235
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 11:21:25AM -0500, Jeff Layton wrote:
> On Tue, 2026-02-03 at 17:11 +0100, Alexander Mikhalitsyn wrote:
> > Am Do., 29. Jan. 2026 um 22:48 Uhr schrieb Jeff Layton <jlayton@kernel.org>:
> > > 
> > > Commit e1c5ae59c0f2 ("fs: don't allow non-init s_user_ns for filesystems
> > > without FS_USERNS_MOUNT") prevents the mount of any filesystem inside a
> > > container that doesn't have FS_USERNS_MOUNT set.
> > > 
> > 
> > Hi Jeff,
> > 
> > > This broke NFS mounts in our containerized environment. We have a daemon
> > > somewhat like systemd-mountfsd running in the init_ns. A process does a
> > > fsopen() inside the container and passes it to the daemon via unix
> > > socket.
> > > 
> > > The daemon then vets that the request is for an allowed NFS server and
> > > performs the mount. This now fails because the fc->user_ns is set to the
> > > value in the container and NFS doesn't set FS_USERNS_MOUNT.  We don't
> > > want to add FS_USERNS_MOUNT to NFS since that would allow the container
> > > to mount any NFS server (even malicious ones).
> > > 
> > > Add a new FS_USERNS_DELEGATABLE flag, and enable it on NFS.
> > 
> > Great idea, very similar to what we have with BPFFS/BPF Tokens.
> > 
> > Taking into account this patch, shouldn't we drop FS_USERNS_MOUNT and
> > replace it with
> > FS_USERNS_DELEGATABLE for bpffs too?
> > 
> > I mean something like:
> > 
> > ======================
> > $ git diff
> > diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > index 9f866a010dad..d8dfdc846bd0 100644
> > --- a/kernel/bpf/inode.c
> > +++ b/kernel/bpf/inode.c
> > @@ -1009,10 +1009,6 @@ static int bpf_fill_super(struct super_block
> > *sb, struct fs_context *fc)
> >         struct inode *inode;
> >         int ret;
> > 
> > -       /* Mounting an instance of BPF FS requires privileges */
> > -       if (fc->user_ns != &init_user_ns && !capable(CAP_SYS_ADMIN))
> > -               return -EPERM;
> > -
> >         ret = simple_fill_super(sb, BPF_FS_MAGIC, bpf_rfiles);
> >         if (ret)
> >                 return ret;
> > @@ -1085,7 +1081,7 @@ static struct file_system_type bpf_fs_type = {
> >         .init_fs_context = bpf_init_fs_context,
> >         .parameters     = bpf_fs_parameters,
> >         .kill_sb        = bpf_kill_super,
> > -       .fs_flags       = FS_USERNS_MOUNT,
> > +       .fs_flags       = FS_USERNS_DELEGATABLE,
> >  };
> > 
> >  static int __init bpf_init(void)
> > ======================
> > 
> > Because it feels like we were basically implementing this FS_USERNS_DELEGATABLE
> > flag implicitly for BPFFS before. I can submit a patch for BPFFS later
> > after testing.

Can you send that to the list, please?
Thanks!

