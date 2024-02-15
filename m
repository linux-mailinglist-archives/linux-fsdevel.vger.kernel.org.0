Return-Path: <linux-fsdevel+bounces-11711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC77A856541
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 15:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D331C2401C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 14:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B281131E24;
	Thu, 15 Feb 2024 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KYf2HRwe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d4ja/xq9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K+vr4KtS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BXrZpsO8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB02712FF88;
	Thu, 15 Feb 2024 14:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005772; cv=none; b=XBPa6oeDKkVVVro/sEQTVjwLst+ahiRFqlBJf9lPh/Lj1M5X9rs5etnAIZ3IUr0BXt5WTMeTC2lqzFq67qf1Ai7nT3e/8OP5DPODt4V27bsjvRtjvEJK4s0htfRyj+1jelAmbpmBNG8RwtR43GLbCoyCbchOb/4I7HkQWWG1UVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005772; c=relaxed/simple;
	bh=1TTHEKevXmdVh51++1BPYu27cgcVjv651HAFiiIJx28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLYu0krQInmYPufrmbbxljGHyr9htOnm2CXoGwAiCyaChBLygjm3RyoU7f83UaqhA+nRhIUQMxlYgL+oEMbe2kx5GVW7t8+L55YtEmDJInjMJPmwhk0g6TUA67sKyPoy7cvsgtyG6umCEkgl6Rr0LZxv1Uycfi8UfL98DnoVFuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KYf2HRwe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d4ja/xq9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K+vr4KtS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BXrZpsO8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D22BF22219;
	Thu, 15 Feb 2024 14:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708005769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+usnLuQgIopfcd+tk9ECF+6CmkhAWjNe58jT5Yn3I4M=;
	b=KYf2HRweXaH6U7DUyxQzr9yV3tnZ8xJDeDFmk3ThE8hwV3MjbVIGObM//8ht/HW+FNP3zA
	yvfJjpp3K34LA7U8B39LlRJa1pahuTCz8EGoA2YF11fjF30fU4sIKeRzMEQu1ZelTv8o35
	HuC82eZ9Rh/qdWvpChOgqR42gDPtbxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708005769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+usnLuQgIopfcd+tk9ECF+6CmkhAWjNe58jT5Yn3I4M=;
	b=d4ja/xq9FH/CTdWU8n2zFUqV1U+ZHqUa+SJVjLTSWtOz5+id1PDy389mJtITZh//ne3GKk
	p/B7vG+mQGzMarAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708005768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+usnLuQgIopfcd+tk9ECF+6CmkhAWjNe58jT5Yn3I4M=;
	b=K+vr4KtSAP11iadW6esi0FmFl1KVp+MSxbYbhrevxWRLhh9BDOCG8Tzof3RIfZffsixPkh
	pmzqYT/DI2vLlpWWcXOmoQ5Sn+BtWXUtbmHJVvDVu2zHpKCm88yX62+ZAq8EsCL6p12cZZ
	dMW8cW+ELNTEfnpfmqW8q+fgUTCLfz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708005768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+usnLuQgIopfcd+tk9ECF+6CmkhAWjNe58jT5Yn3I4M=;
	b=BXrZpsO8nFOHBYsC48MTTeu2ZgnEm7XqUpvLEaMEwRSZbz0ipQd/O2j3HrybE2Y2yiJhzR
	P4BjJfwbv6LHMfAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C5C591346A;
	Thu, 15 Feb 2024 14:02:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id IxNHMIgZzmV2IgAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 15 Feb 2024 14:02:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6CACFA0809; Thu, 15 Feb 2024 15:02:44 +0100 (CET)
Date: Thu, 15 Feb 2024 15:02:44 +0100
From: Jan Kara <jack@suse.cz>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jan Kara <jack@suse.cz>, Chuck Lever <cel@kernel.org>,
	viro@zeniv.linux.org.uk, brauner@kernel.org, hughd@google.com,
	akpm@linux-foundation.org, Liam.Howlett@oracle.com,
	oliver.sang@intel.com, feng.tang@intel.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org, linux-mm@kvack.org, lkp@intel.com
Subject: Re: [PATCH RFC 6/7] libfs: Convert simple directory offsets to use a
 Maple Tree
Message-ID: <20240215140244.njd5emd6ikbjfj27@quack3>
References: <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
 <170786028128.11135.4581426129369576567.stgit@91.116.238.104.host.secureserver.net>
 <20240215130601.vmafdab57mqbaxrf@quack3>
 <Zc4VfZ4/ejBEOt6s@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc4VfZ4/ejBEOt6s@tissot.1015granger.net>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=K+vr4KtS;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BXrZpsO8
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,intel.com:email,infradead.org:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: D22BF22219
X-Spam-Flag: NO

On Thu 15-02-24 08:45:33, Chuck Lever wrote:
> On Thu, Feb 15, 2024 at 02:06:01PM +0100, Jan Kara wrote:
> > On Tue 13-02-24 16:38:01, Chuck Lever wrote:
> > > From: Chuck Lever <chuck.lever@oracle.com>
> > > 
> > > Test robot reports:
> > > > kernel test robot noticed a -19.0% regression of aim9.disk_src.ops_per_sec on:
> > > >
> > > > commit: a2e459555c5f9da3e619b7e47a63f98574dc75f1 ("shmem: stable directory offsets")
> > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > > Feng Tang further clarifies that:
> > > > ... the new simple_offset_add()
> > > > called by shmem_mknod() brings extra cost related with slab,
> > > > specifically the 'radix_tree_node', which cause the regression.
> > > 
> > > Willy's analysis is that, over time, the test workload causes
> > > xa_alloc_cyclic() to fragment the underlying SLAB cache.
> > > 
> > > This patch replaces the offset_ctx's xarray with a Maple Tree in the
> > > hope that Maple Tree's dense node mode will handle this scenario
> > > more scalably.
> > > 
> > > In addition, we can widen the directory offset to an unsigned long
> > > everywhere.
> > > 
> > > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Closes: https://lore.kernel.org/oe-lkp/202309081306.3ecb3734-oliver.sang@intel.com
> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > 
> > OK, but this will need the performance numbers.
> 
> Yes, I totally concur. The point of this posting was to get some
> early review and start the ball rolling.
> 
> Actually we expect roughly the same performance numbers now. "Dense
> node" support in Maple Tree is supposed to be the real win, but
> I'm not sure it's ready yet.
> 
> 
> > Otherwise we have no idea
> > whether this is worth it or not. Maybe you can ask Oliver Sang? Usually
> > 0-day guys are quite helpful.
> 
> Oliver and Feng were copied on this series.
> 
> 
> > > @@ -330,9 +329,9 @@ int simple_offset_empty(struct dentry *dentry)
> > >  	if (!inode || !S_ISDIR(inode->i_mode))
> > >  		return ret;
> > >  
> > > -	index = 2;
> > > +	index = DIR_OFFSET_MIN;
> > 
> > This bit should go into the simple_offset_empty() patch...
> > 
> > > @@ -434,15 +433,15 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
> > >  
> > >  	/* In this case, ->private_data is protected by f_pos_lock */
> > >  	file->private_data = NULL;
> > > -	return vfs_setpos(file, offset, U32_MAX);
> > > +	return vfs_setpos(file, offset, MAX_LFS_FILESIZE);
> > 					^^^
> > Why this? It is ULONG_MAX << PAGE_SHIFT on 32-bit so that doesn't seem
> > quite right? Why not use ULONG_MAX here directly?
> 
> I initially changed U32_MAX to ULONG_MAX, but for some reason, the
> length checking in vfs_setpos() fails. There is probably a sign
> extension thing happening here that I don't understand.

Right. loff_t is signed (long long). So I think you should make the
'offset' be long instead of unsigned long and allow values 0..LONG_MAX?
Then you can pass LONG_MAX here. You potentially loose half of the usable
offsets on 32-bit userspace with 64-bit file offsets but who cares I guess?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

