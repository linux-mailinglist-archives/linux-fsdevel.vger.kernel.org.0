Return-Path: <linux-fsdevel+bounces-62565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6144B999AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 13:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6741D1887248
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 11:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F12C2FD7C3;
	Wed, 24 Sep 2025 11:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="29ljAXQV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mv5a5lbN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k8UO8p93";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/cDgnNkc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA32242D99
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758713699; cv=none; b=k44kgKg5a9ryI4d5l6BdUoA1V8QACa5Jq9JOr/0dsDSU4jCfTzzQjOb+4+jWF0IjCNl/qjteHyoMCMWjBB65L1ldR6YWUWmjy7KAz21/kcYRy4kJJ7IXk+ykh6hROUY580ecNNQOHhK4w5AEvqeALyTX9udofqVcK1Z+CUcg4eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758713699; c=relaxed/simple;
	bh=6Xio59U2ZRM7usr9QrC8JmPWM8YoXa5LVsiKF6Ov/vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biEDJ9XI5qxRkGwAKUFjpveTFXvfQEF2ohSA8yQm3WoZkQO23rFLjMVWHEyLWOb2UuB7xP9jsJ4JxRb9isT70A4YG6OT2qJqI0OYzRYkLSNE+uz3zvKQL/ko2lCoNvs5bkPBkQm1Ef31v3/gMB7U1J1oLa0O3txpgXznNiTtmZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=29ljAXQV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mv5a5lbN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=k8UO8p93; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/cDgnNkc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC2DD5BDEA;
	Wed, 24 Sep 2025 11:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758713691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RXypTXsLYIROo/ehVigK8mkPN8zBGXcvFqZu4cEXIR4=;
	b=29ljAXQVmZHjw6F35+HMy/OSzfrSjWGYY0f3NkEgeBRcBHeOPHcBCN56lZF1n6N+qXgu4v
	YtqWUIDlVzpF240nfePhudqW+mSouRApF5N4fTOqztwgTJqIK1RN4io/I/ZTRKgJcJ1GKs
	z3hrJZXDtk5CXLa9P9IHMXQ5tS8pzLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758713691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RXypTXsLYIROo/ehVigK8mkPN8zBGXcvFqZu4cEXIR4=;
	b=mv5a5lbN/mldG4qI4v43KyIOt8HsibeLrXGPWiNAkiVgR2Qc8mx9IMHGazFwG/dvxOikBB
	dZITYsRiBdW/U+Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=k8UO8p93;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/cDgnNkc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758713690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RXypTXsLYIROo/ehVigK8mkPN8zBGXcvFqZu4cEXIR4=;
	b=k8UO8p932ANKDOZwjwLe/ZmtA71evVsuh3aBl/PmKVI/p06HNsniWLMw8DKL4zn1V3vrrs
	qmZc9S1x3fe62WlljUVjApngDG5bUSFEZXDJjbW1EMOuM9QG4semsXIWEU2CLLFFyehtZF
	Zazmz57MzK51y30hO1nXdih/c5sYj8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758713690;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RXypTXsLYIROo/ehVigK8mkPN8zBGXcvFqZu4cEXIR4=;
	b=/cDgnNkc0X8iMgtsCvfqQ9kRp1ojAWQHLilEjBqysA4ZbdpxTInoM8tATYYp8w4QAB750X
	wcKUi1+WLYFTSOBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A95D913A61;
	Wed, 24 Sep 2025 11:34:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rBLyKFrX02jJPwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Sep 2025 11:34:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2A7ECA0A9A; Wed, 24 Sep 2025 13:34:46 +0200 (CEST)
Date: Wed, 24 Sep 2025 13:34:46 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC PATCH 0/2] Defer evicting inodes to a workqueue
Message-ID: <wuel5bsbfa7t5s6g6hgifgvkhuwpwiapgepq3no3gjftodiojc@savimjoqup56>
References: <20250924091000.2987157-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924091000.2987157-1-willy@infradead.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: BC2DD5BDEA
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -4.01

On Wed 24-09-25 10:09:55, Matthew Wilcox (Oracle) wrote:
> Evicting an inode is a complex process which may require allocating
> memory, running a transaction, etc, etc.  Doing it as part of reclaim
> is a bad idea and leads to hard-to-reproduce bug reports.  This pair of
> patches defers it to a workqueue if we're in reclaim.
> 
> Bugs:
> https://lore.kernel.org/all/CALm_T+3j+dyK02UgPiv9z0f1oj-HM63oxhsB0JF9gVAjeVfm1Q@mail.gmail.com/
> https://lore.kernel.org/all/CALm_T+2cEDUJvjh6Lv+6Mg9QJxGBVAHu-CY+okQgh-emWa7-1A@mail.gmail.com/
> https://lore.kernel.org/all/20250326105914.3803197-1-matt@readmodwrite.com/
> 
> I don't know if this is a good idea, to be honest.  We're kind of lying
> to reclaim by pretending that we've freed N inodes when actually we've
> just queued them for eviction.  On the other hand, XFS has been doing
> it for years, so perhaps it's not important.

Well, I guess as soon as your page allocation forward progress depends on
inode cache eviction (or any other slab cache in fact), you are trashing
hard and you are generally in a very bad situation (TM). So I as long as
you can give dentry + inode cache a kick "hey, you're too big for the
workload" and we'll shrink it within some reasonable time, we should be
mostly OK. But also note that XFS inode reclaim has various throttling
mechanisms so that we don't queue unbounded amount of work - because some
workloads may generate insane amounts of inodes and you eventually want to
throttle inode allocation rate to the rate you can reclaim them and so far
there's no other mechanism for that than blocking reclaim.

> I think the real solution here is to convert the Linux VFS to use the
> same inode lifecycle as IRIX, but I don't fully understand the downsides
> of that approach.  One major pro of course is that XFS wouldn't have to
> work around the Linux VFS any more.
> 
> I do wonder if a better approach might be:
> 
> +++ b/fs/inode.c
> @@ -883,6 +883,10 @@ void evict_inodes(struct super_block *sb)

Why evict_inodes? I think you want prune_icache_sb() -> inode_lru_isolate()?

>                         spin_unlock(&inode->i_lock);
>                         continue;
>                 }
> +               if (in_reclaim() && (inode->i_state & I_DIRTY_ALL)) {

Also I_DIRTY_ALL is far from matching all reasons why fs may take long to
reclaim the inode. There may be block preallocation to trim or some
journalling machinery cleanup to do etc...

> +                       spin_unlock(&inode->i_lock);
> +                       continue;
> +               }
>  
>                 inode->i_state |= I_FREEING;
>                 inode_lru_list_del(inode);


								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

