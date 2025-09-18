Return-Path: <linux-fsdevel+bounces-62085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4CFB83B6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 11:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BDF17B3BDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 09:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65C72FFDE9;
	Thu, 18 Sep 2025 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eJ6cs855";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cHbQhpUq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eJ6cs855";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cHbQhpUq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9019E2FE592
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186782; cv=none; b=lebFKG3E4g/KpccQgXSgqBEhBNl8iwU/8X+3TDXYG1w7z2UwcqmENrPaZ+8kvEC9dr4vJgg3SwN7+1ayDK8TYPPRbiirw9zl/cC5LvO9R4PveIXEkr8pTBDq3RHncp0Gc3S6OYEZaxLkluyZSKVeotY7YqFsqvYxOH9IyFInmtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186782; c=relaxed/simple;
	bh=zbo++j/cLReirz87fkiC5qaaXMU8Kvz0iSgyAEvzIYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyHzCjFQsu+VkvmF2lJgbwr6ihHr/csZOASDg5hooiKA2/voe1uqE79edjvmC9xE+Qtra6KGBLBnQGCmfTTzuU+7miag4Re4ZBcy+O66pguLFvKxUvEb6ER0TESeokm+PHL1EJdAK90x7s4FjiTbFg0eyRha90VRIWMvLSbn+TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eJ6cs855; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cHbQhpUq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eJ6cs855; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cHbQhpUq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B60181F393;
	Thu, 18 Sep 2025 09:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758186778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nbuNQzh1zuOzpwosC6YopwsJkbLDORVpCcTBnZD0pgM=;
	b=eJ6cs855rfNlLlnYxLi7hncmRUuip4vZhrbCXkWVUn/FRKPbSkFxudb1q8SdOHnUocRntK
	SyjDgXgJ7kaGhkQb3mfYOsBxP5JSlIgk2rX4nNtbVVA3PStbNeoD4WWCWMuH9ebIxFFxSI
	CJQrdJgyHjYw2vzwzUKRvfYNKeFx0C8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758186778;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nbuNQzh1zuOzpwosC6YopwsJkbLDORVpCcTBnZD0pgM=;
	b=cHbQhpUqjhDOcWrq+kIcyjyNsM9A15RNC/0EjCr9pQnJpfHJ8hxBckEkkbvNOnw2EOm/Rt
	HeW4/9CTLpOLkNAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758186778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nbuNQzh1zuOzpwosC6YopwsJkbLDORVpCcTBnZD0pgM=;
	b=eJ6cs855rfNlLlnYxLi7hncmRUuip4vZhrbCXkWVUn/FRKPbSkFxudb1q8SdOHnUocRntK
	SyjDgXgJ7kaGhkQb3mfYOsBxP5JSlIgk2rX4nNtbVVA3PStbNeoD4WWCWMuH9ebIxFFxSI
	CJQrdJgyHjYw2vzwzUKRvfYNKeFx0C8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758186778;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nbuNQzh1zuOzpwosC6YopwsJkbLDORVpCcTBnZD0pgM=;
	b=cHbQhpUqjhDOcWrq+kIcyjyNsM9A15RNC/0EjCr9pQnJpfHJ8hxBckEkkbvNOnw2EOm/Rt
	HeW4/9CTLpOLkNAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A474513A39;
	Thu, 18 Sep 2025 09:12:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gakiKBrNy2hxVQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 18 Sep 2025 09:12:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1697AA09B1; Thu, 18 Sep 2025 11:12:54 +0200 (CEST)
Date: Thu, 18 Sep 2025 11:12:54 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Jakub Kicinski <kuba@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 6/9] mnt: simplify ns_common_init() handling
Message-ID: <rmf52dxd73wrsdtvqgjoa7i4am42k6i4eesd7nbxvdq7j22xy7@r7jkm4ahv6s7>
References: <20250917-work-namespace-ns_common-v1-0-1b3bda8ef8f2@kernel.org>
 <20250917-work-namespace-ns_common-v1-6-1b3bda8ef8f2@kernel.org>
 <syskz2nr23sqc27swfxwbvlbnnf7tgglrbn52vjoxd2bn3ryyv@id7hurupxcuy>
 <20250918-quizfragen-deutung-82bd9d83c7ad@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918-quizfragen-deutung-82bd9d83c7ad@brauner>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,gmail.com,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,cmpxchg.org,suse.com,linutronix.de];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.30

On Thu 18-09-25 10:15:01, Christian Brauner wrote:
> On Wed, Sep 17, 2025 at 06:45:11PM +0200, Jan Kara wrote:
> > On Wed 17-09-25 12:28:05, Christian Brauner wrote:
> > > Assign the reserved MNT_NS_ANON_INO sentinel to anonymous mount
> > > namespaces and cleanup the initial mount ns allocation. This is just a
> > > preparatory patch and the ns->inum check in ns_common_init() will be
> > > dropped in the next patch.
> > > 
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > 
> > ...
> > > ---
> > >  fs/namespace.c    | 7 ++++---
> > >  kernel/nscommon.c | 2 +-
> > >  2 files changed, 5 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/fs/namespace.c b/fs/namespace.c
> > > index c8251545d57e..09e4ecd44972 100644
> > > --- a/fs/namespace.c
> > > +++ b/fs/namespace.c
> > > @@ -4104,6 +4104,8 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
> > >  		return ERR_PTR(-ENOMEM);
> > >  	}
> > >  
> > > +	if (anon)
> > > +		new_ns->ns.inum = MNT_NS_ANON_INO;
> > >  	ret = ns_common_init(&new_ns->ns, &mntns_operations, !anon);
> > >  	if (ret) {
> > >  		kfree(new_ns);
> > > @@ -6020,10 +6022,9 @@ static void __init init_mount_tree(void)
> > >  	if (IS_ERR(mnt))
> > >  		panic("Can't create rootfs");
> > >  
> > > -	ns = alloc_mnt_ns(&init_user_ns, true);
> > > +	ns = alloc_mnt_ns(&init_user_ns, false);
> > >  	if (IS_ERR(ns))
> > >  		panic("Can't allocate initial namespace");
> > > -	ns->ns.inum = PROC_MNT_INIT_INO;
> > >  	m = real_mount(mnt);
> > >  	ns->root = m;
> > >  	ns->nr_mounts = 1;
> > > @@ -6037,7 +6038,7 @@ static void __init init_mount_tree(void)
> > >  	set_fs_pwd(current->fs, &root);
> > >  	set_fs_root(current->fs, &root);
> > >  
> > > -	ns_tree_add(ns);
> > > +	ns_tree_add_raw(ns);
> > 
> > But we don't have ns->ns_id set by anything now? Or am I missing something?
> 
> It is set in alloc_mnt_ns() via ns_tree_gen_id(). :)
> Unless I'm missing something.

Ah, right. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

