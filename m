Return-Path: <linux-fsdevel+bounces-11736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69638856AB9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 18:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2117828B6DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 17:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4DE136983;
	Thu, 15 Feb 2024 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="crXxaNt4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tw5zFj2V";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3aZQNKOD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rqsige/G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02411136672;
	Thu, 15 Feb 2024 17:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017390; cv=none; b=d7n7v0IgwxODJUyFs/h5MudHeeo6hwZKMMG29dDpiIixdm9QzBxOdGAO8SvS/f87sbvX9pvcPwG3Si0YUY4znRL8DYASZ2if9ojT6wmE7mW0w492gnWBCj1AwbV7nLDWR0uNYw5R2MgkYCzFGNf6d9YnoWIAqz7uizYjiGaZkiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017390; c=relaxed/simple;
	bh=FnWRM4ezUayH/+nfUHMLdLr9sMm6ZfP4bx8t1CPLEqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMZhPFU1Z4IJhfTNCdGdqjz/9ZRPKqAwXYYQYe25fUVVZVXOcKITh2cLIBk01MYjuur0Gl3VCsoYibwTtbbvTjFhO8cZ8lY7MYXLZrRqrAmjROkcWrfl2kildVwRg7BETIKihUneQHeGRnH/Ox0wIw9fRr+kk6+AdJgF429r4E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=crXxaNt4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tw5zFj2V; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3aZQNKOD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rqsige/G; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 53CFF1FD72;
	Thu, 15 Feb 2024 17:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708017384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mN7N6sR+6YLENx+tkwEFlJDkjcUq22eMFFhbhlDssyE=;
	b=crXxaNt4lz+6l+N1R7/8qInOvrZc42YDVwOgn7kmGjjKgGPBh08qU9C2tVz6gWWL/1c5/8
	GXr08GIve9b2Kij0ykGJdztHaTEXbZu8crqH377qaY63BT+dkl/QFxO7obovljjRvA00mQ
	GzdFHnUlI/7KlOtp/r6bz78eVOy4rwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708017384;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mN7N6sR+6YLENx+tkwEFlJDkjcUq22eMFFhbhlDssyE=;
	b=tw5zFj2V2oD3MPiFJMvYDH/qkPCwX9pSObaRuCoL8AaH2cSC6HH/onlR9PsN6KPIrxL/Lc
	nOL9N5eUyK2R/GCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708017383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mN7N6sR+6YLENx+tkwEFlJDkjcUq22eMFFhbhlDssyE=;
	b=3aZQNKODUKOoV8JVnld6mFSn3VKkr/j1RwTX53xoftbrWHoE1SUX720mKlEsfM99xJlQ8q
	/EX2kXq8WzII6GZaWu9tXxubeDE9aAieAYOc8XVDKsfgX7KhsKSM2pKcoIhbSrm9Ebr25Z
	1Z8vsp9Wp0YXiMQqdoR0nZYgz6QnML0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708017383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mN7N6sR+6YLENx+tkwEFlJDkjcUq22eMFFhbhlDssyE=;
	b=rqsige/GL0a+boAWmMzPwVHF8fyiQZ1F3UuvQ19UTSuX1g1/q7hrGjDdVIZ4UljyUXWR1b
	tfJI2RMdF+bSFvDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4087F139D0;
	Thu, 15 Feb 2024 17:16:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id sym6D+dGzmVzTAAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 15 Feb 2024 17:16:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A7C03A0809; Thu, 15 Feb 2024 18:16:22 +0100 (CET)
Date: Thu, 15 Feb 2024 18:16:22 +0100
From: Jan Kara <jack@suse.cz>
To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc: Jan Kara <jack@suse.cz>, Chuck Lever <cel@kernel.org>,
	viro@zeniv.linux.org.uk, brauner@kernel.org, hughd@google.com,
	akpm@linux-foundation.org, oliver.sang@intel.com,
	feng.tang@intel.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org,
	linux-mm@kvack.org, lkp@intel.com
Subject: Re: [PATCH RFC 7/7] libfs: Re-arrange locking in offset_iterate_dir()
Message-ID: <20240215171622.gsbjbjz6vau3emkh@quack3>
References: <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
 <170786028847.11135.14775608389430603086.stgit@91.116.238.104.host.secureserver.net>
 <20240215131638.cxipaxanhidb3pev@quack3>
 <20240215170008.22eisfyzumn5pw3f@revolver>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215170008.22eisfyzumn5pw3f@revolver>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.71
X-Spamd-Result: default: False [-3.71 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.11)[-0.569];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Thu 15-02-24 12:00:08, Liam R. Howlett wrote:
> * Jan Kara <jack@suse.cz> [240215 08:16]:
> > On Tue 13-02-24 16:38:08, Chuck Lever wrote:
> > > From: Chuck Lever <chuck.lever@oracle.com>
> > > 
> > > Liam says that, unlike with xarray, once the RCU read lock is
> > > released ma_state is not safe to re-use for the next mas_find() call.
> > > But the RCU read lock has to be released on each loop iteration so
> > > that dput() can be called safely.
> > > 
> > > Thus we are forced to walk the offset tree with fresh state for each
> > > directory entry. mt_find() can do this for us, though it might be a
> > > little less efficient than maintaining ma_state locally.
> > > 
> > > Since offset_iterate_dir() doesn't build ma_state locally any more,
> > > there's no longer a strong need for offset_find_next(). Clean up by
> > > rolling these two helpers together.
> > > 
> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > 
> > Well, in general I think even xas_next_entry() is not safe to use how
> > offset_find_next() was using it. Once you drop rcu_read_lock(),
> > xas->xa_node could go stale. But since you're holding inode->i_rwsem when
> > using offset_find_next() you should be protected from concurrent
> > modifications of the mapping (whatever the underlying data structure is) -
> > that's what makes xas_next_entry() safe AFAIU. Isn't that enough for the
> > maple tree? Am I missing something?
> 
> If you are stopping, you should be pausing the iteration.  Although this
> works today, it's not how it should be used because if we make changes
> (ie: compaction requires movement of data), then you may end up with a
> UAF issue.  We'd have no way of knowing you are depending on the tree
> structure to remain consistent.

I see. But we have versions of these structures that have locking external
to the structure itself, don't we? Then how do you imagine serializing the
background operations like compaction? As much as I agree your argument is
"theoretically clean", it seems a bit like a trap and there are definitely
xarray users that are going to be broken by this (e.g.
tag_pages_for_writeback())...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

