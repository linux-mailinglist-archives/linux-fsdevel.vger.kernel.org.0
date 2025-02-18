Return-Path: <linux-fsdevel+bounces-41985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F328BA39B8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 12:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32A5E1750AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 11:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF61224113E;
	Tue, 18 Feb 2025 11:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OExQXtbT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="deTj8HeH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OExQXtbT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="deTj8HeH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13617241112
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739879853; cv=none; b=CHOmRP7PPnHlFN9/YZfgqWWmbUdtC0JCXsMdoqaMs1lSVL1+wfLnzZSFoA9wWkw4R+uyhXLCT6DWwKw6UjwhFmsZI8EX6N/uEu+k55C5hdmzWeRz9P8BwFx1hh/F8qLl+fv8Nqjg3s9UkqR3jWUeEFgBfwguFjQjWZc8PPtWlwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739879853; c=relaxed/simple;
	bh=JsUzXQtperYwfR2NUgU/CPacXDUNe+HkgOFgNwlp+rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3vvp1BgQbSs6lTMBnWQQ/jyrhOR8z8zyS2I5wsE0PSuT+2yJPso37sH/QTErEU1RqBlXjLmjX9QmM47Znt5AWK5zniWxh3ZSD7Y8d3LeAOe4FeWnSl5ozl0VB34Tt+te3eYAVYfIcdY5y7cGE7A1SmEV4Dnz6E+Ae5Whj9mCqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OExQXtbT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=deTj8HeH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OExQXtbT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=deTj8HeH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3397C1F396;
	Tue, 18 Feb 2025 11:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739879849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PG8HU5nDKvBG7Z/6y0Ca/vlqWZgbtONpf4NbMOmA6Ig=;
	b=OExQXtbTUpkHmFwVjz87+qQMljj0PcRTrFuZlncW/9O2nSNp8NLh+HOlZwU4ivgA+TGobs
	ulpkOza/2rrzd/gVPNDsbQcEqTq+RsHxuomAz1WhJapJuBz9VfcxGR4UjZR7yYq9IrIW/9
	YOjdPbjmg2gqTS/At+6hxNsarOLEyAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739879849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PG8HU5nDKvBG7Z/6y0Ca/vlqWZgbtONpf4NbMOmA6Ig=;
	b=deTj8HeHUD04ecz/FMn0rYEfsO2ScOHhxcJ+zvuw/JMzlVThngV1nS3T2J2d0ZcnNKbcYC
	Iq5HjZEPA7hcJSBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739879849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PG8HU5nDKvBG7Z/6y0Ca/vlqWZgbtONpf4NbMOmA6Ig=;
	b=OExQXtbTUpkHmFwVjz87+qQMljj0PcRTrFuZlncW/9O2nSNp8NLh+HOlZwU4ivgA+TGobs
	ulpkOza/2rrzd/gVPNDsbQcEqTq+RsHxuomAz1WhJapJuBz9VfcxGR4UjZR7yYq9IrIW/9
	YOjdPbjmg2gqTS/At+6hxNsarOLEyAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739879849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PG8HU5nDKvBG7Z/6y0Ca/vlqWZgbtONpf4NbMOmA6Ig=;
	b=deTj8HeHUD04ecz/FMn0rYEfsO2ScOHhxcJ+zvuw/JMzlVThngV1nS3T2J2d0ZcnNKbcYC
	Iq5HjZEPA7hcJSBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 248C5132C7;
	Tue, 18 Feb 2025 11:57:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kKPiCKl1tGceKgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 18 Feb 2025 11:57:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C2FE1A08B5; Tue, 18 Feb 2025 12:57:28 +0100 (CET)
Date: Tue, 18 Feb 2025 12:57:28 +0100
From: Jan Kara <jack@suse.cz>
To: Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Dave Chinner <david@fromorbit.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matt Harvey <mharvey@jumptrading.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] fuse: add new function to invalidate cache for
 all inodes
Message-ID: <bpevrif4k5h2l4pscsnsj3flwmwdw6w5nge5n7ji2yshk5pz6z@tngefti6stld>
References: <20250216165008.6671-1-luis@igalia.com>
 <20250216165008.6671-3-luis@igalia.com>
 <3fac8c84-2c41-461d-92f1-255903fc62a9@ddn.com>
 <87r03wx4th.fsf@igalia.com>
 <847288fa-b66a-4f3d-9f50-52fa293a1189@ddn.com>
 <87ldu4x076.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldu4x076.fsf@igalia.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Mon 17-02-25 11:47:09, Luis Henriques wrote:
> On Mon, Feb 17 2025, Bernd Schubert wrote:
> > On 2/17/25 11:07, Luis Henriques wrote:
> >> On Mon, Feb 17 2025, Bernd Schubert wrote:
> >> 
> >>> On 2/16/25 17:50, Luis Henriques wrote:
> >>>> Currently userspace is able to notify the kernel to invalidate the cache
> >>>> for an inode.  This means that, if all the inodes in a filesystem need to
> >>>> be invalidated, then userspace needs to iterate through all of them and do
> >>>> this kernel notification separately.
> >>>>
> >>>> This patch adds a new option that allows userspace to invalidate all the
> >>>> inodes with a single notification operation.  In addition to invalidate
> >>>> all the inodes, it also shrinks the sb dcache.
> >>>>
> >>>> Signed-off-by: Luis Henriques <luis@igalia.com>
> >>>> ---
> >>>>  fs/fuse/inode.c           | 33 +++++++++++++++++++++++++++++++++
> >>>>  include/uapi/linux/fuse.h |  3 +++
> >>>>  2 files changed, 36 insertions(+)
> >>>>
> >>>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> >>>> index e9db2cb8c150..01a4dc5677ae 100644
> >>>> --- a/fs/fuse/inode.c
> >>>> +++ b/fs/fuse/inode.c
> >>>> @@ -547,6 +547,36 @@ struct inode *fuse_ilookup(struct fuse_conn *fc, u64 nodeid,
> >>>>  	return NULL;
> >>>>  }
> >>>>  
> >>>> +static int fuse_reverse_inval_all(struct fuse_conn *fc)
> >>>> +{
> >>>> +	struct fuse_mount *fm;
> >>>> +	struct inode *inode;
> >>>> +
> >>>> +	inode = fuse_ilookup(fc, FUSE_ROOT_ID, &fm);
> >>>> +	if (!inode || !fm)
> >>>> +		return -ENOENT;
> >>>> +
> >>>> +	/* Remove all possible active references to cached inodes */
> >>>> +	shrink_dcache_sb(fm->sb);
> >>>> +
> >>>> +	/* Remove all unreferenced inodes from cache */
> >>>> +	invalidate_inodes(fm->sb);
> >>>> +
> >>>> +	return 0;
> >>>> +}
> >>>> +
> >>>> +/*
> >>>> + * Notify to invalidate inodes cache.  It can be called with @nodeid set to
> >>>> + * either:
> >>>> + *
> >>>> + * - An inode number - Any pending writebacks within the rage [@offset @len]
> >>>> + *   will be triggered and the inode will be validated.  To invalidate the whole
> >>>> + *   cache @offset has to be set to '0' and @len needs to be <= '0'; if @offset
> >>>> + *   is negative, only the inode attributes are invalidated.
> >>>> + *
> >>>> + * - FUSE_INVAL_ALL_INODES - All the inodes in the superblock are invalidated
> >>>> + *   and the whole dcache is shrinked.
> >>>> + */
> >>>>  int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
> >>>>  			     loff_t offset, loff_t len)
> >>>>  {
> >>>> @@ -555,6 +585,9 @@ int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
> >>>>  	pgoff_t pg_start;
> >>>>  	pgoff_t pg_end;
> >>>>  
> >>>> +	if (nodeid == FUSE_INVAL_ALL_INODES)
> >>>> +		return fuse_reverse_inval_all(fc);
> >>>> +
> >>>>  	inode = fuse_ilookup(fc, nodeid, NULL);
> >>>>  	if (!inode)
> >>>>  		return -ENOENT;
> >>>> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> >>>> index 5e0eb41d967e..e5852b63f99f 100644
> >>>> --- a/include/uapi/linux/fuse.h
> >>>> +++ b/include/uapi/linux/fuse.h
> >>>> @@ -669,6 +669,9 @@ enum fuse_notify_code {
> >>>>  	FUSE_NOTIFY_CODE_MAX,
> >>>>  };
> >>>>  
> >>>> +/* The nodeid to request to invalidate all inodes */
> >>>> +#define FUSE_INVAL_ALL_INODES 0
> >>>> +
> >>>>  /* The read buffer is required to be at least 8k, but may be much larger */
> >>>>  #define FUSE_MIN_READ_BUFFER 8192
> >>>>  
> >>>
> >>>
> >>> I think this version might end up in 
> >>>
> >>> static void fuse_evict_inode(struct inode *inode)
> >>> {
> >>> 	struct fuse_inode *fi = get_fuse_inode(inode);
> >>>
> >>> 	/* Will write inode on close/munmap and in all other dirtiers */
> >>> 	WARN_ON(inode->i_state & I_DIRTY_INODE);
> >>>
> >>>
> >>> if the fuse connection has writeback cache enabled.
> >>>
> >>>
> >>> Without having it tested, reproducer would probably be to run
> >>> something like passthrough_hp (without --direct-io), opening
> >>> and writing to a file and then sending FUSE_INVAL_ALL_INODES.
> >> 
> >> Thanks, Bernd.  So far I couldn't trigger this warning.  But I just found
> >> that there's a stupid bug in the code: a missing iput() after doing the
> >> fuse_ilookup().
> >> 
> >> I'll spend some more time trying to understand how (or if) the warning you
> >> mentioned can triggered before sending a new revision.
> >> 
> >
> > Maybe I'm wrong, but it calls 
> >
> >    invalidate_inodes()
> >       dispose_list()
> >         evict(inode)
> >            fuse_evict_inode()
> >
> > and if at the same time something writes to inode page cache, the
> > warning would be triggered? 
> > There are some conditions in evict, like inode_wait_for_writeback()
> > that might protect us, but what is if it waited and then just
> > in the right time the another write comes and dirties the inode
> > again?
> 
> Right, I have looked into that too but my understanding is that this can
> not happen because, before doing that wait, the code does:
> 
> 	inode_sb_list_del(inode);
> 
> and the inode state will include I_FREEING.
> 
> Thus, before writing to it again, the inode will need to get added back to
> the sb list.  Also, reading the comments on evict(), if something writes
> into the inode at that point that's likely a bug.  But this is just my
> understanding, and I may be missing something.

Yes. invalidate_inodes() checks i_count == 0 and sets I_FREEING. Once
I_FREEING is set nobody can acquire inode reference until the inode is
fully destroyed. So nobody should be writing to the inode or anything like
that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

