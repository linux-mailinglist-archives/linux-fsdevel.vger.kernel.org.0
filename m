Return-Path: <linux-fsdevel+bounces-71091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 605A6CB54AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 10:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10D9C3028FF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 09:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8362F5A3D;
	Thu, 11 Dec 2025 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wLFZxyQT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bZuzX1wF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A2Hr2ots";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GABhwmgB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662892F12BD
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765443653; cv=none; b=PCGcAyPES/n9hf7UpgCStuUgzPqMOp+jZ6p9VgQuvxYKPinwXnjD3oJsY0UfTAPuBHQhg6MghMW4TPrqDmaXztdl9SFJfc4qArCqa1roJpNytpJM8cny0YSnAT+8iYGMucj2hYq2tdP1te/nNzrrnSe/jA0QmX9S1tngs7ZgoqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765443653; c=relaxed/simple;
	bh=icoW+zKJUi8DVFn9kknuZXO9/pphNDRX3q+u77ogAsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjdRZ3BrPdXh93m7RPBU066yxQBEtYDLcish+HAuMh3NWgjcwmj65OBQoXctgtSHsJvSC/h6RIaNOsKNrFIdbA/AN7/IASg5Ip8/kGFwXxKz3fxj9Ybb+rBwDYqc/C/5gIVl/A0iGVMs4PxtJNVLYUx+FBPcfFlxWoZzUxrSMCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wLFZxyQT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bZuzX1wF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A2Hr2ots; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GABhwmgB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 864AB337E7;
	Thu, 11 Dec 2025 09:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765443644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8iYLS7sZO8q+tS7aamHvFDMq7WdCi0zhLn18HFY2py4=;
	b=wLFZxyQTs3xCxYqQsNOD0VjKdg+P9RowtQal+/8XmmL2+xm+B7ptfZD1hRg8SYmphJ5dSu
	E2BanDkYnUOWzghpQkntn5NlcsdYWUyW/rdnsGJrfrco2ytcTuzv5kXLJ5oYUfC7kw89VX
	oS+mXutBbIuJzEqvyXYTF6TBSjJswfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765443644;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8iYLS7sZO8q+tS7aamHvFDMq7WdCi0zhLn18HFY2py4=;
	b=bZuzX1wFssA8kdrfqbwIuJXq9no9gzBBV0TQik+sZ9kuiqr6YWuTeiftoIsKT+27eoYYjn
	J2epufbExUfYIeDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=A2Hr2ots;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GABhwmgB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765443640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8iYLS7sZO8q+tS7aamHvFDMq7WdCi0zhLn18HFY2py4=;
	b=A2Hr2otsyVZv0iiYsP13uQy3CpC9q2dq1A2Wmm2c461lGjWJeQuEbcBJ8h9TyZKK5q8E0n
	rPJrS0Vbc0x2pMOVQ5At06B5JY9ILbvR72JDWFFC+FDHtxRrAVoZl0Z9+6dFuuhJwzY3Iy
	ymhR3RnY6iaWrYwFGG5lML/+pQ/74wQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765443640;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8iYLS7sZO8q+tS7aamHvFDMq7WdCi0zhLn18HFY2py4=;
	b=GABhwmgBxwq/IsrLj+7X4u/6P/FzOQ7r8WdbLKigazQY8e4h1p8FDEU2RQlEgz8Gnmb5qO
	XnoIy173+ssOKsBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 750263EA63;
	Thu, 11 Dec 2025 09:00:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KAaJHDiIOmnBYAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 11 Dec 2025 09:00:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1DF43A0A04; Thu, 11 Dec 2025 10:00:40 +0100 (CET)
Date: Thu, 11 Dec 2025 10:00:40 +0100
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Mateusz Guzik <mjguzik@gmail.com>, 
	syzbot <syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com>, brauner@kernel.org, jack@suse.cz, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
	Ahmet Eray Karadag <eraykrdg1@gmail.com>, Albin Babu Varghese <albinbabuvarghese20@gmail.com>, 
	Heming Zhao <heming.zhao@suse.com>
Subject: Re: [syzbot] [exfat?] [ocfs2?] kernel BUG in link_path_walk
Message-ID: <5idkf5nyzgfzj5y7t27um7j27hpmt7seae47oztekbm2ggdeby@wxhvvmtvihxw>
References: <6930d0bf.a70a0220.2ea503.00d4.GAE@google.com>
 <ff7k3zlpiueyyykotdpfcaoxn2tukceoqcbmfdwjfolndy4sen@3f5r362sg67g>
 <20251210214730.GC1712166@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210214730.GC1712166@ZenIV>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,syzkaller.appspotmail.com,kernel.org,suse.cz,evilplan.org,linux.alibaba.com,vger.kernel.org,fasheh.com,lists.linux.dev,samsung.com,googlegroups.com,suse.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,linux.org.uk:email,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[d222f4b7129379c3d5bc];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 864AB337E7
X-Spam-Flag: NO
X-Spam-Score: -2.51

On Wed 10-12-25 21:47:30, Al Viro wrote:
> #syz test
>  
> commit 9c7d3d572d0a67484e9cbe178184cfd9a89aa430
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Wed Dec 10 16:44:53 2025 -0500
> 
>     Revert "ocfs2: mark inode bad upon validation failure during read"
>     
>     This reverts commit 58b6fcd2ab34399258dc509f701d0986a8e0bcaa.
>     
>     You can't use make_bad_inode() on live inodes.

At first I was confused because ocfs2_read_inode_block_full() gets called
when loading new inode into memory and that's a place for which
make_bad_inode() is safe. But then I've noticed ocfs2 does reread the inode
in many places through ocfs2_read_inode_block() and that could be marking
fully alive inode as bad. So this commit is indeed buggy. Adding relevant
people to CC.

Guys, maybe I'm misunderstanding the changelog of 58b6fcd2ab34 but the
justification:

    The VFS open(O_DIRECT) operation appears to incorrectly clear the inode's
    I_DIRTY flag without ensuring the dirty metadata (reflecting the earlier
    buffered write, e.g., an updated i_size) is flushed to disk.

looks bogus. Combinations of direct and buffered IO work perfectly fine for
other filesystems (definitely not corrupting them). VFS definitely does not
clear dirty flags without writing back the inode. 

The particular syzbot reproducers mentioned in 58b6fcd2ab34 are likely
confusing ocfs2 by calling LOOP_SET_STATUS(64) on the loopback device with
mounted ocfs2 filesystem which may effectively corrupt the filesystem
underneath. So I suspect proper fix for your issues is actually
https://lore.kernel.org/all/20251114144204.2402336-2-rpthibeault@gmail.com/.

Perhaps we should ping Jens to pick it up.

								Honza

> 
> diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> index 8340525e5589..53d649436017 100644
> --- a/fs/ocfs2/inode.c
> +++ b/fs/ocfs2/inode.c
> @@ -1708,8 +1708,6 @@ int ocfs2_read_inode_block_full(struct inode *inode, struct buffer_head **bh,
>  	rc = ocfs2_read_blocks(INODE_CACHE(inode), OCFS2_I(inode)->ip_blkno,
>  			       1, &tmp, flags, ocfs2_validate_inode_block);
>  
> -	if (rc < 0)
> -		make_bad_inode(inode);
>  	/* If ocfs2_read_blocks() got us a new bh, pass it up. */
>  	if (!rc && !*bh)
>  		*bh = tmp;
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

