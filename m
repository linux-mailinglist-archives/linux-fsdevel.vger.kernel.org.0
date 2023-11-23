Return-Path: <linux-fsdevel+bounces-3581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5FA7F6B38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 05:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7181C20B02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 04:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842CB4416;
	Fri, 24 Nov 2023 04:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MDSLbvkf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mCvfccum"
X-Original-To: linux-fsdevel@vger.kernel.org
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Nov 2023 20:18:50 PST
Received: from smtp-out2.suse.de (unknown [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E782C1BE;
	Thu, 23 Nov 2023 20:18:49 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1AE8C1FCE9;
	Thu, 23 Nov 2023 15:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700753292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pJMwMKWmr3SgrVtJ54lNRuvm3w8HZfZBoP5f262t4oI=;
	b=MDSLbvkf1JnDLc3i1dEMAK6i2zLvMEV9a3SJ6X+uqYbEu9qNkI59+9YLrW4wAOpn9SV3OV
	wbxpKlHt4O5mUXmDqMJ9y5tQw+ATetNyKlfsCpAL6UI8pdEPrqc2svZEfONoNJapMVCqBT
	VsMudlCW5ro7xKZSSdUBCMYc22ynImU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700753292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pJMwMKWmr3SgrVtJ54lNRuvm3w8HZfZBoP5f262t4oI=;
	b=mCvfccumpgm/aV2RP40jKPZ2+GS4Uu18jpDTjZ87WAmRC4V3xH7Q3JIlBB0nNKewHisJxD
	1QeTBPsCD33vHUBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CB8A613AAC;
	Thu, 23 Nov 2023 11:52:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id j9hsMQA9X2U9ZgAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 23 Nov 2023 11:52:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0E322A07E3; Thu, 23 Nov 2023 11:36:22 +0100 (CET)
Date: Thu, 23 Nov 2023 11:36:22 +0100
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mo Zou <lostzoumo@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] rename(): avoid a deadlock in the case of parents
 having no common ancestor
Message-ID: <20231123103622.4mfjwrmxr4tl53hi@quack3>
References: <20231122193028.GE38156@ZenIV>
 <20231122193652.419091-1-viro@zeniv.linux.org.uk>
 <20231122193652.419091-9-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122193652.419091-9-viro@zeniv.linux.org.uk>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.36
X-Spamd-Result: default: False [-0.36 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(2.74)[0.912];
	 REPLY(-4.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,linux.org.uk:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,linux-foundation.org,gmail.com,suse.cz];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Wed 22-11-23 19:36:52, Al Viro wrote:
> ... and fix the directory locking documentation and proof of correctness.
> Holding ->s_vfs_rename_mutex *almost* prevents ->d_parent changes; the
> case where we really don't want it is splicing the root of disconnected
> tree to somewhere.
> 
> In other words, ->s_vfs_rename_mutex is sufficient to stabilize "X is an
> ancestor of Y" only if X and Y are already in the same tree.  Otherwise
> it can go from false to true, and one can construct a deadlock on that.
> 
> Make lock_two_directories() report an error in such case and update the
> callers of lock_rename()/lock_rename_child() to handle such errors.
> 
> And yes, such conditions are not impossible to create ;-/
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good to me. Just one nit below but whether you decide to address it
or not, feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> +// p1 != p2, both are on the same filesystem, ->s_vfs_rename_mutex is held
>  static struct dentry *lock_two_directories(struct dentry *p1, struct dentry *p2)
>  {
> -	struct dentry *p;
> +	struct dentry *p = p1, *q = p2, *r;
>  
> -	p = d_ancestor(p2, p1);
> -	if (p) {
> +	while ((r = p->d_parent) != p2 && r != p)
> +		p = r;
> +	if (r == p2) {
> +		// p is a child of p2 and an ancestor of p1 or p1 itself
>  		inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
>  		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT2);
>  		return p;
>  	}
> -
> -	p = d_ancestor(p1, p2);
> -	inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
> -	inode_lock_nested(p2->d_inode, I_MUTEX_PARENT2);
> -	return p;
> +	// p is the root of connected component that contains p1
> +	// p2 does not occur on the path from p to p1
> +	while ((r = q->d_parent) != p1 && r != p && r != q)
> +		q = r;
> +	if (r == p1) {
> +		// q is a child of p1 and an ancestor of p2 or p2 itself
> +		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
> +		inode_lock_nested(p2->d_inode, I_MUTEX_PARENT2);
> +		return q;
> +	} else if (likely(r == p)) {
> +		// both p2 and p1 are descendents of p
> +		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
> +		inode_lock_nested(p2->d_inode, I_MUTEX_PARENT2);
> +		return NULL;
> +	} else { // no common ancestor at the time we'd been called
> +		mutex_unlock(&p1->d_sb->s_vfs_rename_mutex);

It would look more natural to me if s_vfs_rename_mutex got dropped in the
callers (lock_rename(), lock_rename_child()) which have acquired the lock
instead of here. I agree it results in a bit more boiler plate code though.

> +		return ERR_PTR(-EXDEV);
> +	}
>  }

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

