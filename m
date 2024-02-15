Return-Path: <linux-fsdevel+bounces-11703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94810856401
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 14:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E12628914A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 13:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57BA12F58E;
	Thu, 15 Feb 2024 13:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wSKuannf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WCfKjUK6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wSKuannf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WCfKjUK6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908AC80604;
	Thu, 15 Feb 2024 13:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708002378; cv=none; b=cWmNRTf8+fopRGEm5gks1jPKdo8IzK0l9yXjkafjwV0JksP9qnLKh8BX1ViGINiG+w0e/bfhrVcfeSpbQSNBFJZpIxrmDZ6xzg5AFwlzqiO1bRechnMz3a07z9Bv3AyMQjDp5bev5zqCnobl4OO2P1yST4vxeYhrRmSZ6tOL3/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708002378; c=relaxed/simple;
	bh=ts0vpuGjnXe4RUSIeouNSZC64LJaLpqK0xeoxa5y7Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnTH5n8RZNfVNc6PHmN9cEegX9PWh6k19X7c33t/zgzmodXw0NNHZBEskrtCCbh8smBSLTP/I3gCOZovHCQDaw/M6YhZhTySHll1Abql9HalfS2pE9oZbrT95WfZWBdF8No98wxnOmzld00nDIB4A+jgi/k0Bx0xl/cc68WFe14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wSKuannf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WCfKjUK6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wSKuannf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WCfKjUK6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 66D68221F1;
	Thu, 15 Feb 2024 13:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708002370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wqqEnx+8NJeNx4uDHqfPp5HohmNv2zWkv9TXmYpGhMk=;
	b=wSKuannfMnE2Un+SV6gVG9snXmdpr2prZO87oxy7yyUZZA+AS4JYyyYo0KLFdf/y3Q9qR2
	LpbWMfl8DKRoYdUrnbpoBOFcHUUu1Iazdpc/xRny/ML8QM18gytBx1B94EkytOaSb+QUeR
	YobCLVCYBV0YXNJdx3UEIFIDsZ3C+EU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708002370;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wqqEnx+8NJeNx4uDHqfPp5HohmNv2zWkv9TXmYpGhMk=;
	b=WCfKjUK61HWdfZ6MCqqdy6GGwqxVG2rJ0aEm4irLhQC19wZNNFD/zawc8u9CSSUb3d2EyI
	L+RCu/+qzZKZsuCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708002370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wqqEnx+8NJeNx4uDHqfPp5HohmNv2zWkv9TXmYpGhMk=;
	b=wSKuannfMnE2Un+SV6gVG9snXmdpr2prZO87oxy7yyUZZA+AS4JYyyYo0KLFdf/y3Q9qR2
	LpbWMfl8DKRoYdUrnbpoBOFcHUUu1Iazdpc/xRny/ML8QM18gytBx1B94EkytOaSb+QUeR
	YobCLVCYBV0YXNJdx3UEIFIDsZ3C+EU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708002370;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wqqEnx+8NJeNx4uDHqfPp5HohmNv2zWkv9TXmYpGhMk=;
	b=WCfKjUK61HWdfZ6MCqqdy6GGwqxVG2rJ0aEm4irLhQC19wZNNFD/zawc8u9CSSUb3d2EyI
	L+RCu/+qzZKZsuCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 58F2B139D0;
	Thu, 15 Feb 2024 13:06:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 15GxFUIMzmWqFQAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 15 Feb 2024 13:06:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 04F1CA0809; Thu, 15 Feb 2024 14:06:01 +0100 (CET)
Date: Thu, 15 Feb 2024 14:06:01 +0100
From: Jan Kara <jack@suse.cz>
To: Chuck Lever <cel@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	hughd@google.com, akpm@linux-foundation.org,
	Liam.Howlett@oracle.com, oliver.sang@intel.com, feng.tang@intel.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org, linux-mm@kvack.org, lkp@intel.com
Subject: Re: [PATCH RFC 6/7] libfs: Convert simple directory offsets to use a
 Maple Tree
Message-ID: <20240215130601.vmafdab57mqbaxrf@quack3>
References: <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
 <170786028128.11135.4581426129369576567.stgit@91.116.238.104.host.secureserver.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170786028128.11135.4581426129369576567.stgit@91.116.238.104.host.secureserver.net>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wSKuannf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WCfKjUK6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.29 / 50.00];
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
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,oracle.com:email,suse.cz:dkim,suse.com:email,intel.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.28)[74.38%]
X-Spam-Score: -1.29
X-Rspamd-Queue-Id: 66D68221F1
X-Spam-Flag: NO

On Tue 13-02-24 16:38:01, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Test robot reports:
> > kernel test robot noticed a -19.0% regression of aim9.disk_src.ops_per_sec on:
> >
> > commit: a2e459555c5f9da3e619b7e47a63f98574dc75f1 ("shmem: stable directory offsets")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> Feng Tang further clarifies that:
> > ... the new simple_offset_add()
> > called by shmem_mknod() brings extra cost related with slab,
> > specifically the 'radix_tree_node', which cause the regression.
> 
> Willy's analysis is that, over time, the test workload causes
> xa_alloc_cyclic() to fragment the underlying SLAB cache.
> 
> This patch replaces the offset_ctx's xarray with a Maple Tree in the
> hope that Maple Tree's dense node mode will handle this scenario
> more scalably.
> 
> In addition, we can widen the directory offset to an unsigned long
> everywhere.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202309081306.3ecb3734-oliver.sang@intel.com
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

OK, but this will need the performance numbers. Otherwise we have no idea
whether this is worth it or not. Maybe you can ask Oliver Sang? Usually
0-day guys are quite helpful.

> @@ -330,9 +329,9 @@ int simple_offset_empty(struct dentry *dentry)
>  	if (!inode || !S_ISDIR(inode->i_mode))
>  		return ret;
>  
> -	index = 2;
> +	index = DIR_OFFSET_MIN;

This bit should go into the simple_offset_empty() patch...

> @@ -434,15 +433,15 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
>  
>  	/* In this case, ->private_data is protected by f_pos_lock */
>  	file->private_data = NULL;
> -	return vfs_setpos(file, offset, U32_MAX);
> +	return vfs_setpos(file, offset, MAX_LFS_FILESIZE);
					^^^
Why this? It is ULONG_MAX << PAGE_SHIFT on 32-bit so that doesn't seem
quite right? Why not use ULONG_MAX here directly?

Otherwise the patch looks good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

