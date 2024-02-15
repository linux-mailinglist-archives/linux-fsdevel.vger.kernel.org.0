Return-Path: <linux-fsdevel+bounces-11702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E748563B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 13:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E60A1F26C6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 12:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A68C12EBD8;
	Thu, 15 Feb 2024 12:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GmXXW5Rd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2dO3YVA1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L0GlUkns";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="esUBYGy3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D5513FF5;
	Thu, 15 Feb 2024 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001619; cv=none; b=FPJoG6af9Pi5Yf/BSgMkRaLB0GhV3L9Zo1kY88/6wNnFSWi6kiSPDMqQP1s+otDRLYD5+ceekXMAFx0nKYJQRTl8AwZVJ+mRr5aUv056uDITW12cGsJDMGidT1pMqCS5ievlWbD9JojYvX4fTaZV1br2z8rUiD2mCPZHdXWvpWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001619; c=relaxed/simple;
	bh=zS58sXUP1J9E020doS0QPEEOsgsY/IqVOUewEiUxdPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQs04FKVh3qG/LJe3GOTFoVgR757nGNgKoTAVPf+/ZkhlGqCH+dp4tb7J5eVIaQlFTsfxTzycqtq2v4Cs3kTlBvuGbYn2atbA852KlzREAq5L9j5OXONul6fCRB365pIOzGJzBNBElufLggbY21P9w1vYQkWPpMmoF4J8YpihDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GmXXW5Rd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2dO3YVA1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L0GlUkns; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=esUBYGy3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B87361F8A3;
	Thu, 15 Feb 2024 12:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708001615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mEMZMJvKvn9rkIpj9WwfoRzOmeKRtveyYp+UWHhr5qA=;
	b=GmXXW5RdKmMxSxUDUnfp1gXZ/LocbGoUQRoaRYCBwzf+gXWKgSaELKDm+6oT9KcLwoolIo
	vd32+8Strs3ValdlTkeZEYcoJp9UcQ/KYUD6DzvApZq5gBK35ui12B4nQRWYvUkdz17d2T
	AYAKx68DYV1anUU5mDDrIgdLpLcGXUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708001615;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mEMZMJvKvn9rkIpj9WwfoRzOmeKRtveyYp+UWHhr5qA=;
	b=2dO3YVA1DVVG5g/iAWsBH31QQVv0uDXn+LtZ99240LqaDX50DR9mJSUyRLPmIkLNojWnMm
	72rv160JRWa0rLBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708001614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mEMZMJvKvn9rkIpj9WwfoRzOmeKRtveyYp+UWHhr5qA=;
	b=L0GlUkns5ZWHHtFjYDtZwqcyLek2VXjTJwXC9c3eCDPkjOdSnMEIsdO5dK78jw+DxXb9rF
	6m8RqaeY61DoS+r7MTJrFwqrCY8v3v5wm1+mkbf5evkb/v4ctPE1/umf5GRzLtMFVjUSd3
	3Lv6i0qMjNtMqi3UOqgSi5XgYmxji0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708001614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mEMZMJvKvn9rkIpj9WwfoRzOmeKRtveyYp+UWHhr5qA=;
	b=esUBYGy3ybEhWPAk6smUuJr7L7wdPCldJLfvsDUvht1Zks8FsY2LOUgD9gz6YeIWo6/uVJ
	UiaBgVJPN99HKMAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AADD5139D0;
	Thu, 15 Feb 2024 12:53:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id CRevKU4JzmXdEgAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 15 Feb 2024 12:53:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5CB18A0809; Thu, 15 Feb 2024 13:53:34 +0100 (CET)
Date: Thu, 15 Feb 2024 13:53:34 +0100
From: Jan Kara <jack@suse.cz>
To: Chuck Lever <cel@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	hughd@google.com, akpm@linux-foundation.org,
	Liam.Howlett@oracle.com, oliver.sang@intel.com, feng.tang@intel.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org, linux-mm@kvack.org, lkp@intel.com
Subject: Re: [PATCH RFC 3/7] libfs: Add simple_offset_empty()
Message-ID: <20240215125334.2buxkbd4d3ax2kpi@quack3>
References: <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
 <170786025969.11135.16880338029664682984.stgit@91.116.238.104.host.secureserver.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170786025969.11135.16880338029664682984.stgit@91.116.238.104.host.secureserver.net>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=L0GlUkns;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=esUBYGy3
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,oracle.com:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B87361F8A3
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Tue 13-02-24 16:37:39, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> For simple filesystems that use directory offset mapping, rely
> strictly on the directory offset map to tell when a directory has
> no children.
> 
> After this patch is applied, the emptiness test holds only the RCU
> read lock when the directory being tested has no children.
> 
> In addition, this adds another layer of confirmation that
> simple_offset_add/remove() are working as expected.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/libfs.c         |   32 ++++++++++++++++++++++++++++++++
>  include/linux/fs.h |    1 +
>  mm/shmem.c         |    4 ++--
>  3 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index a38af72f4719..3cf773950f93 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -313,6 +313,38 @@ void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry)
>  	offset_set(dentry, 0);
>  }
>  
> +/**
> + * simple_offset_empty - Check if a dentry can be unlinked
> + * @dentry: dentry to be tested
> + *
> + * Returns 0 if @dentry is a non-empty directory; otherwise returns 1.
> + */
> +int simple_offset_empty(struct dentry *dentry)
> +{
> +	struct inode *inode = d_inode(dentry);
> +	struct offset_ctx *octx;
> +	struct dentry *child;
> +	unsigned long index;
> +	int ret = 1;
> +
> +	if (!inode || !S_ISDIR(inode->i_mode))
> +		return ret;
> +
> +	index = 2;
> +	octx = inode->i_op->get_offset_ctx(inode);
> +	xa_for_each(&octx->xa, index, child) {
> +		spin_lock(&child->d_lock);
> +		if (simple_positive(child)) {
> +			spin_unlock(&child->d_lock);
> +			ret = 0;
> +			break;
> +		}
> +		spin_unlock(&child->d_lock);
> +	}
> +
> +	return ret;
> +}
> +
>  /**
>   * simple_offset_rename_exchange - exchange rename with directory offsets
>   * @old_dir: parent of dentry being moved
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index ed5966a70495..03d141809a2c 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3267,6 +3267,7 @@ struct offset_ctx {
>  void simple_offset_init(struct offset_ctx *octx);
>  int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry);
>  void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry);
> +int simple_offset_empty(struct dentry *dentry);
>  int simple_offset_rename_exchange(struct inode *old_dir,
>  				  struct dentry *old_dentry,
>  				  struct inode *new_dir,
> diff --git a/mm/shmem.c b/mm/shmem.c
> index d7c84ff62186..6fed524343cb 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3374,7 +3374,7 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
>  
>  static int shmem_rmdir(struct inode *dir, struct dentry *dentry)
>  {
> -	if (!simple_empty(dentry))
> +	if (!simple_offset_empty(dentry))
>  		return -ENOTEMPTY;
>  
>  	drop_nlink(d_inode(dentry));
> @@ -3431,7 +3431,7 @@ static int shmem_rename2(struct mnt_idmap *idmap,
>  		return simple_offset_rename_exchange(old_dir, old_dentry,
>  						     new_dir, new_dentry);
>  
> -	if (!simple_empty(new_dentry))
> +	if (!simple_offset_empty(new_dentry))
>  		return -ENOTEMPTY;
>  
>  	if (flags & RENAME_WHITEOUT) {
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

