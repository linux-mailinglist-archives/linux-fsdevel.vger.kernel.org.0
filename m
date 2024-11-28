Return-Path: <linux-fsdevel+bounces-36084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989BF9DB710
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 13:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A15163293
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 12:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C2119AD8B;
	Thu, 28 Nov 2024 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="U2uKo4hV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0KI9V9QJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="U2uKo4hV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0KI9V9QJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB89613A24D;
	Thu, 28 Nov 2024 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732795281; cv=none; b=LwNKVgFpw5+ylHIzaEoGc4w//fzTsMTh2kpenkKYcFHm4L372Ev9TlQp7XHg+H6KvdOMSrtW+o49Qx0QmBQEdrgX330m3mj+6kbLJUafZ+krzZkHWQogfJxdQGpzoPuRgBra8Nqi31ZRolAhSaNvJI2AnQLxCURRUH2jisTlNQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732795281; c=relaxed/simple;
	bh=N9G7XbjWuzyy0ti9Dedks0gvfHXQo0FyDp1+rr4Sr0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nE6LCliM05jZ+ePv9EdtspJo9IUhEhdNwoR4MTPDGRpVXuX063O/UxQkgpb4OrywIA/R74soF1KuJNRR2YLmg/y6LECDKzfrToOQECYtrWkDil2QQ8zm0rKMYCH+HsNbAyfQ/d3oCLSpJfsp0b3piCa1lUxiUzKp+avgyyBKP4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=U2uKo4hV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0KI9V9QJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=U2uKo4hV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0KI9V9QJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AB3FC21184;
	Thu, 28 Nov 2024 12:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732795276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QftfuheUNSN1biVSldepmhZTzTY8ZNax+YFipcKRWHw=;
	b=U2uKo4hVSpWGyzJMkQK0qqK7BNxs7mF5ExlMwRlHDZ752Gr/vZxQZs5NEblorDP4ELp6X0
	LkcPc9P9zkE3zFd+cze3ArAW/ASnaUuC7ad8TuqJZVvPOV0Ro9VL2Y2b+xggaQd65ytPQE
	OdlQIlgJO9huugEsEmc4+VyynRTh4n4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732795276;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QftfuheUNSN1biVSldepmhZTzTY8ZNax+YFipcKRWHw=;
	b=0KI9V9QJCzrQGb5gLrFYmWqXVY/8xG7R7fsUAlZ/h1RM5IXTucyqc0zDJgq4hs35Xft9f9
	lxjKC4AoKIVCL6Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=U2uKo4hV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0KI9V9QJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732795276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QftfuheUNSN1biVSldepmhZTzTY8ZNax+YFipcKRWHw=;
	b=U2uKo4hVSpWGyzJMkQK0qqK7BNxs7mF5ExlMwRlHDZ752Gr/vZxQZs5NEblorDP4ELp6X0
	LkcPc9P9zkE3zFd+cze3ArAW/ASnaUuC7ad8TuqJZVvPOV0Ro9VL2Y2b+xggaQd65ytPQE
	OdlQIlgJO9huugEsEmc4+VyynRTh4n4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732795276;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QftfuheUNSN1biVSldepmhZTzTY8ZNax+YFipcKRWHw=;
	b=0KI9V9QJCzrQGb5gLrFYmWqXVY/8xG7R7fsUAlZ/h1RM5IXTucyqc0zDJgq4hs35Xft9f9
	lxjKC4AoKIVCL6Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EABF13974;
	Thu, 28 Nov 2024 12:01:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D8W6JoxbSGeMYgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 28 Nov 2024 12:01:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 567F8A075D; Thu, 28 Nov 2024 13:01:08 +0100 (CET)
Date: Thu, 28 Nov 2024 13:01:08 +0100
From: Jan Kara <jack@suse.cz>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 2/2] ext4: protect ext4_release_dquot against freezing
Message-ID: <20241128120108.4cv23l6rcspzmtun@quack3>
References: <20241121123855.645335-1-ojaswin@linux.ibm.com>
 <20241121123855.645335-3-ojaswin@linux.ibm.com>
 <87serc2bu5.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87serc2bu5.fsf@gmail.com>
X-Rspamd-Queue-Id: AB3FC21184
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 28-11-24 10:28:58, Ritesh Harjani wrote:
> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
> 
> > Protect ext4_release_dquot against freezing so that we
> > don't try to start a transaction when FS is frozen, leading
> > to warnings.
> >
> > Further, avoid taking the freeze protection if a transaction
> > is already running so that we don't need end up in a deadlock
> > as described in
> >
> >   46e294efc355 ext4: fix deadlock with fs freezing and EA inodes
> >
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Sorry for being late on this. Ideally, shouldn't it be the
> responsibility of higher level FS (ext4) to make sure that
> FS never freezes while there is pending work for releasing dquot
> structures and that it should also prevent any context where such dquot 
> structures gets added for release/delayed release. 
> 
> e.g. this is what FS takes care during freeze path i.e.
>   freeze_super() -> sync_fs -> ext4_sync_fs()-> dquot_writeback_dquots() -> flush_delayed_work() (now fixed)
> 
> Now coming to iput() case which Jan mentioned [1] which could still
> be called after FS have frozen. As I see we have a protection from FS
> freeze in the ext4_evict_path() right? So ideally we should never see

We don't if we go through:

ext4_evict_inode()
  if (inode->i_nlink) {
    truncate_inode_pages_final(&inode->i_data);
    goto no_delete;
  }
no_delete:
  ext4_clear_inode(inode)
    ...
    dquot_drop()

> dquot_drop() w/o fs freeze protection. And say, if the FS freezing immediately
> happened after we scheduled this delayed work (but before the work gets
> scheduled), then that will be taken care in the freeze_super() chain,
> where we will flush all the delayed work no? - which is what Patch-1 is
> fixing.
> 
> (There still might be an error handling path in ext4_evict_inode() ->
> ext4_clear_inode() which we don't freeze protect. I still need to take a
> closer look at that though).

It isn't error handling. It is a standard inode eviction path if the inode
isn't being deleted.

> So.. isn't this patch trying to hide the problem where FS failed to
> freeze protect some code path?

Well, it is kind of self-inflicted damage of ext4_dquot_release() because
it starts a transaction even if there will be nothing to do. We could add
checks to ext4_dquot_release() to start a transaction only if dquot
structure will need to be deleted but that's a layering violation because
it would have to make assumptions about how quota format code is going to
behave.

							Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

