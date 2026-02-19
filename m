Return-Path: <linux-fsdevel+bounces-77697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0O8mD9zvlmngrAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 12:11:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BBF15E2FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 12:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA9EA30252B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 11:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFC333DEC7;
	Thu, 19 Feb 2026 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZMecZt7z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PflWQKYu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZMecZt7z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PflWQKYu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA532274B37
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 11:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771499471; cv=none; b=cZdUf+3PGXssWfgQVd5K2hwqyO1TRkQa1WLf6nuqMxq33MOHr3wFzqSWuFgn0QtHjIbKxijYZOpCXOZitiOUy5mvuG0ipnItB4lUphgIa2aSNC+h6GHS4+8eVu8ewmv1r/9y0gPxk7rRL6WDm2PZa6N8h32nF8QyGJ/E81j6hgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771499471; c=relaxed/simple;
	bh=6WDnAz66bo/O1ordGqi6qBsK10Ooldyb/tiGb4g2mfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxEa4wb94cyxCwc+4Awf+7/TltZzp+erkn9kkR0mP2BzukE8oX0mADk9WMRttDfGL5RoJ0Df5RzgeVj2ghu1x94hF7o9/0NCM1CzZmGHqmC/aHakQV4BR40TCeJVXLCIoHFX7Yc2D9rmXDsVJbkb8WzIl9vMqZqqJLjJJj+7X00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZMecZt7z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PflWQKYu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZMecZt7z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PflWQKYu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 841723E6ED;
	Thu, 19 Feb 2026 11:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771499155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6IGQwkyCepR+ER627ARO+1vTeTmTbf0/JsKE9/w7kY=;
	b=ZMecZt7zfM2JRMYaDbJS99z9n8l94zLcJXexqqjShkvemRP0axy428lCkZcRnapaHmy24w
	wrIQrPxgVYmoUw3OiwWjKEG+6+9HKeUyNXr/vLUbKLI69/urNbK36aBTUpW0NnYpcYs/fu
	OcHDlz3aOaafohsQw/TAUyYJZ7QhHXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771499155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6IGQwkyCepR+ER627ARO+1vTeTmTbf0/JsKE9/w7kY=;
	b=PflWQKYuYGi/3OnSbpyE4TaRwYYxgQ4JUByLgHAZA58MhDsI3qvbq9v+LY2/9Fi9+1X222
	vrQfSdoTO0eg/KCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZMecZt7z;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PflWQKYu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771499155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6IGQwkyCepR+ER627ARO+1vTeTmTbf0/JsKE9/w7kY=;
	b=ZMecZt7zfM2JRMYaDbJS99z9n8l94zLcJXexqqjShkvemRP0axy428lCkZcRnapaHmy24w
	wrIQrPxgVYmoUw3OiwWjKEG+6+9HKeUyNXr/vLUbKLI69/urNbK36aBTUpW0NnYpcYs/fu
	OcHDlz3aOaafohsQw/TAUyYJZ7QhHXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771499155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6IGQwkyCepR+ER627ARO+1vTeTmTbf0/JsKE9/w7kY=;
	b=PflWQKYuYGi/3OnSbpyE4TaRwYYxgQ4JUByLgHAZA58MhDsI3qvbq9v+LY2/9Fi9+1X222
	vrQfSdoTO0eg/KCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C9903EA65;
	Thu, 19 Feb 2026 11:05:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0i15GpPulmnRFgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 19 Feb 2026 11:05:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1D220A06FE; Thu, 19 Feb 2026 12:05:51 +0100 (CET)
Date: Thu, 19 Feb 2026 12:05:51 +0100
From: Jan Kara <jack@suse.cz>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Jan Kara <jack@suse.cz>, gregkh@linuxfoundation.org, tj@kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 2/3] kernfs: send IN_DELETE_SELF and IN_IGNORED on
 file deletion
Message-ID: <anwsdq5gxzeyfavxqvujbevozknyix6xo7leccqrbznfdgi4nz@hfuqqgtv7m4p>
References: <20260218032232.4049467-1-tjmercier@google.com>
 <20260218032232.4049467-3-tjmercier@google.com>
 <e7b4xiqvh76jvqukvcocblq5lrc5hldoiiexjlo5fmagbv3mgn@zhpzm4jwx3kg>
 <CABdmKX1S4wWFdsUOFOQ=_uVbmQVcQk0+VUVQjgAx_yqUcEd60A@mail.gmail.com>
 <s4vb5vshejyasdw2tkydhhk4m6p3ybexoi254qjiqexzgcxb5c@ctazolc3nh6f>
 <CABdmKX2cQCneFyZhTWmWYz-RTmAOQcEKh5ZQewz25E6Xfok1tQ@mail.gmail.com>
 <CABdmKX0BJcsv0TaPSsGN2a4nkQaKF=cX8rnnoL5kPTHNfuKL7Q@mail.gmail.com>
 <CABdmKX0DGP9=OOPwU8WjqHnmRDfPnxoAjm8Rvy-D2GYQX0GE0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX0DGP9=OOPwU8WjqHnmRDfPnxoAjm8Rvy-D2GYQX0GE0A@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.cz,linuxfoundation.org,kernel.org,lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-77697-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[memory.events:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C4BBF15E2FC
X-Rspamd-Action: no action

On Wed 18-02-26 14:10:42, T.J. Mercier wrote:
> On Wed, Feb 18, 2026 at 11:58 AM T.J. Mercier <tjmercier@google.com> wrote:
> > On Wed, Feb 18, 2026 at 11:15 AM T.J. Mercier <tjmercier@google.com> wrote:
> > > On Wed, Feb 18, 2026 at 10:37 AM Jan Kara <jack@suse.cz> wrote:
> > > > On Wed 18-02-26 10:06:35, T.J. Mercier wrote:
> > > > > On Wed, Feb 18, 2026 at 10:01 AM Jan Kara <jack@suse.cz> wrote:
> > > > > > On Tue 17-02-26 19:22:31, T.J. Mercier wrote:
> > > > > > > Currently some kernfs files (e.g. cgroup.events, memory.events) support
> > > > > > > inotify watches for IN_MODIFY, but unlike with regular filesystems, they
> > > > > > > do not receive IN_DELETE_SELF or IN_IGNORED events when they are
> > > > > > > removed.
> > > > > >
> > > > > > Please see my email:
> > > > > > https://lore.kernel.org/all/lc2jgt3yrvuvtdj2kk7q3rloie2c5mzyhfdy4zvxylx732voet@ol3kl4ackrpb
> > > > > >
> > > > > > I think this is actually a bug in kernfs...
> > > > > >
> > > > > >                                                                 Honza
> > > > >
> > > > > Thanks, I'm looking at this now. I've tried calling clear_nlink in
> > > > > kernfs_iop_rmdir, but I've found that when we get back to vfs_rmdir
> > > > > and shrink_dcache_parent is called, d_walk doesn't find any entries,
> > > > > so shrink_kill->__dentry_kill is not called. I'm investigating why
> > > > > that is...
> > > >
> > > > Strange because when I was experimenting with this in my VM I have seen
> > > > __dentry_kill being called (if the dentries were created by someone looking
> > > > up the names).
> > >
> > > Ahh yes, that's the difference. I was just doing mkdir
> > > /sys/fs/cgroup/foo immediately followed by rmdir /sys/fs/cgroup/foo.
> > > kernfs creates the dentries in kernfs_iop_lookup, so there were none
> > > when I did the rmdir because I didn't cause any lookups.
> > >
> > > If I actually have a program watching
> > > /sys/fs/cgroup/foo/memory.events, then I do see the __dentry_kill kill
> > > calls, but despite the prior clear_nlink call i_nlink is 1 so
> > > fsnotify_inoderemove is skipped. Something must be incrementing it.
> >
> > The issue was that kernfs_remove unlinks the kernfs nodes, but doesn't
> > clear_nlink when it does so. Adding that seems to work to generate
> > IN_DELETE_SELF and IN_IGNORED. I'll do some more testing and get a
> > patch ready.
> 
> This works for the rmdir case, because
> vfs_rmdir->shrink_dcache_parent->shrink_kill->__dentry_kill is invoked
> when the user runs rmdir.
> 
> However the case where a kernfs file is removed because a cgroup
> subsys is deactivated does not work, because it occurs when the user
> writes to cgroup.subtree_control. That is a vfs_write which calls
> fsnotify_modify for cgroup.subtree_control, but (very reasonably)
> there is no attempt made to clean up the dcache in VFS on writes.

OK, and is this mostly a theoretical concern or do you practically expect
someone to monitor subsystem files in a cgroup with inotify to learn that
the subsystem has been disabled? It doesn't look very probable to me...

> So I think kernfs still needs to generate fsnotify events manually for
> the cgroup_subtree_control_write->cgroup_apply_control_disable case.
> Those removals happen via kernfs_remove_by_name->__kernfs_remove, so
> that would look a lot like what I sent in this v3 patch, even if we
> also add clear_nlink calls for the rmdir case.

If there's a sensible usecase for monitoring of subsystem files being
deleted, we could also d_delete() the dentry from cgroup_rm_file(). But
maybe the performance overhead would be visible for some larger scale
removals so maybe just using fsnotify_inoderemove() to paper over the
problem would be easier if this case is really needed.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

