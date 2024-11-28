Return-Path: <linux-fsdevel+bounces-36070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBFE9DB6A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 12:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2E51B214EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 11:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3B31991BB;
	Thu, 28 Nov 2024 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VtcfijAv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UyE81BWO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gpiUwq8J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OoQDM4xx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E52146D59;
	Thu, 28 Nov 2024 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732794070; cv=none; b=P1ZKiYfJ+lkQOfKEHSGOtnNkzX8UQbO1Su68OCF+p1fSnD+IzB7+R3QmNy8nMeUdpFNVcj6Nf1OqjU6JP3/mMnx22L0KK9zQgxg093kinfEDCUjtIamsu72FDlqaW/egKnPM1BrVoKz+YWKLjrhogNQpSGH86L2aduP8Hq5bE+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732794070; c=relaxed/simple;
	bh=ZWIIqYyDhuL728nx6ReoXHmdImRIsMk1OsVWjEHbEoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsnfRfzPlRksi/uPmjoYQmj0TJVuhId00EP7SRbnz1rP8hQawosMulQjZJfJWk5v6BL7Lp9OyQk9U7jt7KZdpbAq5VpJWrDCazQJJEj2nluY4wSop34zGlx+U+Ejos4az7w4LuQ1ho/IEM0HavzODM1zulGAD0R1RpO4Mz/eVK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VtcfijAv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UyE81BWO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gpiUwq8J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OoQDM4xx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E90791F44F;
	Thu, 28 Nov 2024 11:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732794061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HDELWx5e4BPDkKEzJ5NHPLUmmn86kQjKXEDm63IGgqc=;
	b=VtcfijAvLAHSI3ioyxuNxDfrIkujf5PDlZ+hg8nkL+A/Q3Mr2XjWeiXhtwd5Ucc6DUEYyh
	aIDm88mUFI1qAqK4mnyu77kBno2rL3ZUQBVtc8tFy+egj6aeJE37dt2NO0TXyAyNmfXgDi
	yuo9jgtEXlDkMjlTfthco9CqflOpj+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732794061;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HDELWx5e4BPDkKEzJ5NHPLUmmn86kQjKXEDm63IGgqc=;
	b=UyE81BWOpaKucIJun0gDbPVvMrIEB9dsLJ/JFBq/uZbVuHCsnmpvk6fEYECjuSWRX9B8pE
	cM91uclXL9dnPAAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732794059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HDELWx5e4BPDkKEzJ5NHPLUmmn86kQjKXEDm63IGgqc=;
	b=gpiUwq8JWXfq6QRDsOe8iiCuZ1o3nh9o15WwvCaZpONRA/pewfxitnUjHd2vDddA2RZrzT
	t+Ev/zv15lL6WMA2NDpoeyY09d2+VEUsqoFJ1j+UaGvQ1MfBJDwa/apg8YzKBP2lzAat1K
	HAvyvm+oSLqWJzmYbOLvkAWyHJH7Ibg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732794059;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HDELWx5e4BPDkKEzJ5NHPLUmmn86kQjKXEDm63IGgqc=;
	b=OoQDM4xxUUtWt0ksP/tN3Fo47xB1iLmvC92u2dt/AtffASc6iWlWK307+69VbQl8dQJaWe
	w7omCLfVAUUdqiBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3AB913690;
	Thu, 28 Nov 2024 11:40:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OLOpM8tWSGd3XAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 28 Nov 2024 11:40:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 898FAA075D; Thu, 28 Nov 2024 12:40:59 +0100 (CET)
Date: Thu, 28 Nov 2024 12:40:59 +0100
From: Jan Kara <jack@suse.cz>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Shu Han <ebpqwerty472123@gmail.com>
Subject: Re: [PATCH v2 1/7] fs: ima: Remove S_IMA and IS_IMA()
Message-ID: <20241128114059.h7hrq6sma2ckyrjn@quack3>
References: <20241128100621.461743-1-roberto.sassu@huaweicloud.com>
 <20241128100621.461743-2-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128100621.461743-2-roberto.sassu@huaweicloud.com>
X-Spam-Score: -2.30
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
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,huawei.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,huawei.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 28-11-24 11:06:14, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Commit 196f518128d2e ("IMA: explicit IMA i_flag to remove global lock on
> inode_delete") introduced the new S_IMA inode flag to determine whether or
> not an inode was processed by IMA. In that way, it was not necessary to
> take the global lock on inode delete.
> 
> Since commit 4de2f084fbff ("ima: Make it independent from 'integrity'
> LSM"), the pointer of the inode integrity metadata managed by IMA has been
> moved to the inode security blob, from the rb-tree. The pointer is not NULL
> only if the inode has been processed by IMA, i.e. ima_inode_get() has been
> called for that inode.
> 
> Thus, since the IS_IMA() check can be now implemented by trivially testing
> whether or not the pointer of inode integrity metadata is NULL, remove the
> S_IMA definition in include/linux/fs.h and also the IS_IMA() macro.
> 
> Remove also the IS_IMA() invocation in ima_rdwr_violation_check(), since
> whether the inode was processed by IMA will be anyway detected by a
> subsequent call to ima_iint_find(). It does not have an additional overhead
> since the decision can be made in constant time, as opposed to logarithm
> when the inode integrity metadata was stored in the rb-tree.
> 
> Suggested-by: Shu Han <ebpqwerty472123@gmail.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/fs.h                | 3 +--
>  security/integrity/ima/ima_iint.c | 5 -----
>  security/integrity/ima/ima_main.c | 2 +-
>  3 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3559446279c1..b33363becbdd 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2261,7 +2261,7 @@ struct super_operations {
>  #define S_NOCMTIME	(1 << 7)  /* Do not update file c/mtime */
>  #define S_SWAPFILE	(1 << 8)  /* Do not truncate: swapon got its bmaps */
>  #define S_PRIVATE	(1 << 9)  /* Inode is fs-internal */
> -#define S_IMA		(1 << 10) /* Inode has an associated IMA struct */
> +/* #define S_IMA	(1 << 10) Inode has an associated IMA struct (unused) */

Well, I guess you can just delete this line. These are internal kernel
flags so we can do whatever we want with them. Otherwise the patch looks
good. Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

>  #define S_AUTOMOUNT	(1 << 11) /* Automount/referral quasi-directory */
>  #define S_NOSEC		(1 << 12) /* no suid or xattr security attributes */
>  #ifdef CONFIG_FS_DAX
> @@ -2319,7 +2319,6 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
>  #endif
>  
>  #define IS_PRIVATE(inode)	((inode)->i_flags & S_PRIVATE)
> -#define IS_IMA(inode)		((inode)->i_flags & S_IMA)
>  #define IS_AUTOMOUNT(inode)	((inode)->i_flags & S_AUTOMOUNT)
>  #define IS_NOSEC(inode)		((inode)->i_flags & S_NOSEC)
>  #define IS_DAX(inode)		((inode)->i_flags & S_DAX)
> diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/ima_iint.c
> index 00b249101f98..9d9fc7a911ad 100644
> --- a/security/integrity/ima/ima_iint.c
> +++ b/security/integrity/ima/ima_iint.c
> @@ -26,9 +26,6 @@ static struct kmem_cache *ima_iint_cache __ro_after_init;
>   */
>  struct ima_iint_cache *ima_iint_find(struct inode *inode)
>  {
> -	if (!IS_IMA(inode))
> -		return NULL;
> -
>  	return ima_inode_get_iint(inode);
>  }
>  
> @@ -102,7 +99,6 @@ struct ima_iint_cache *ima_inode_get(struct inode *inode)
>  
>  	ima_iint_init_always(iint, inode);
>  
> -	inode->i_flags |= S_IMA;
>  	ima_inode_set_iint(inode, iint);
>  
>  	return iint;
> @@ -118,7 +114,6 @@ void ima_inode_free_rcu(void *inode_security)
>  {
>  	struct ima_iint_cache **iint_p = inode_security + ima_blob_sizes.lbs_inode;
>  
> -	/* *iint_p should be NULL if !IS_IMA(inode) */
>  	if (*iint_p)
>  		ima_iint_free(*iint_p);
>  }
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 06132cf47016..cea0afbbc28d 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -126,7 +126,7 @@ static void ima_rdwr_violation_check(struct file *file,
>  	bool send_tomtou = false, send_writers = false;
>  
>  	if (mode & FMODE_WRITE) {
> -		if (atomic_read(&inode->i_readcount) && IS_IMA(inode)) {
> +		if (atomic_read(&inode->i_readcount)) {
>  			if (!iint)
>  				iint = ima_iint_find(inode);
>  			/* IMA_MEASURE is set from reader side */
> -- 
> 2.47.0.118.gfd3785337b
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

