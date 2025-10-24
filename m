Return-Path: <linux-fsdevel+bounces-65513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EB5C062DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 14:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 75CB235C7E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 12:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9652C17A0;
	Fri, 24 Oct 2025 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gw12pWJ4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b2hgw/mR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gw12pWJ4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b2hgw/mR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1DF1DB127
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761307877; cv=none; b=EqRBICobrIDCFNF28yFam3efObE1F1eL5hMfvdtFrxZRdxausdnw3SNx+Fk2ZRWdxholqEBuvI8GhbP8LDGFnDLH3qUXXeUyIqCWBRviSRcW80Ff2sSVZrQ32hxUA2ZyOldP7MJT0WVEfDi7VkY7WSYDNNHV5uXCC/LUmk6bfMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761307877; c=relaxed/simple;
	bh=klNmf2GiP3FNjNSQuyVQSDep3qVCAZZ5iIEWKF5l+ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvAgH5urzAY74jxqqzoevamNCJlnJyMvP87kILK8ujWLo3IgeehRV2HCBDbMKbXyL1ZoC8bpTHjGhuM0uhtVN6jF/loO1hZh4Kzwg8xeL+ySYs+nFFV8ChHc2ujLTwO+FK1UzMn1J5eU+ClkuorFCbDobYzhmjkfJi2PMHvD+wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gw12pWJ4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b2hgw/mR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gw12pWJ4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b2hgw/mR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 47B581F38D;
	Fri, 24 Oct 2025 12:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761307872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NenQ2Wom+07dIl2jW8BeU68cV0chgqY+KBmPwDVWLbw=;
	b=gw12pWJ4dBervOkm4c1wdpprEpUqlQeWPArxYlUpX+1wjQaYgBlWw9o1llMEE7NqtHZ00v
	Xwu5paU0pUZgqU7j4Y44qNPMavuA+1pvb4L6prQKH89bIn60BpNivnCVRYVnb+NV/td2lB
	+uPdROXqPLp7tKETWM5DKokgMabTyEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761307872;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NenQ2Wom+07dIl2jW8BeU68cV0chgqY+KBmPwDVWLbw=;
	b=b2hgw/mRbq2JF7vAhHufNUG/FiOVZulsx+5sZnxygRLE3d2wabKfCkXCLqn+k97//SK6wt
	jbZRwwG/DEKPw0Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761307872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NenQ2Wom+07dIl2jW8BeU68cV0chgqY+KBmPwDVWLbw=;
	b=gw12pWJ4dBervOkm4c1wdpprEpUqlQeWPArxYlUpX+1wjQaYgBlWw9o1llMEE7NqtHZ00v
	Xwu5paU0pUZgqU7j4Y44qNPMavuA+1pvb4L6prQKH89bIn60BpNivnCVRYVnb+NV/td2lB
	+uPdROXqPLp7tKETWM5DKokgMabTyEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761307872;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NenQ2Wom+07dIl2jW8BeU68cV0chgqY+KBmPwDVWLbw=;
	b=b2hgw/mRbq2JF7vAhHufNUG/FiOVZulsx+5sZnxygRLE3d2wabKfCkXCLqn+k97//SK6wt
	jbZRwwG/DEKPw0Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 207C413693;
	Fri, 24 Oct 2025 12:11:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S0znB+Bs+2iwNwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 24 Oct 2025 12:11:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7DA6CA28AB; Fri, 24 Oct 2025 14:11:07 +0200 (CEST)
Date: Fri, 24 Oct 2025 14:11:07 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	ocfs2-devel@lists.linux.dev, linux-xfs@vger.kernel.org, linux-mm@kvack.org, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 07/10] mm: remove __filemap_fdatawrite
Message-ID: <kxl45u4l5u6vrecxj4ib7uxmptv6x6heksachfymh3ffu7xl3d@bza4durxfmhp>
References: <20251024080431.324236-1-hch@lst.de>
 <20251024080431.324236-8-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024080431.324236-8-hch@lst.de>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Fri 24-10-25 10:04:18, Christoph Hellwig wrote:
> And rewrite filemap_fdatawrite to use filemap_fdatawrite_range instead
> to have a simpler call chain.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/filemap.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index e344b79a012d..3d4c4a96c586 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -422,25 +422,19 @@ int __filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
>  	return filemap_fdatawrite_wbc(mapping, &wbc);
>  }
>  
> -static inline int __filemap_fdatawrite(struct address_space *mapping,
> -	int sync_mode)
> +int filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
> +		loff_t end)
>  {
> -	return __filemap_fdatawrite_range(mapping, 0, LLONG_MAX, sync_mode);
> +	return __filemap_fdatawrite_range(mapping, start, end, WB_SYNC_ALL);
>  }
> +EXPORT_SYMBOL(filemap_fdatawrite_range);
>  
>  int filemap_fdatawrite(struct address_space *mapping)
>  {
> -	return __filemap_fdatawrite(mapping, WB_SYNC_ALL);
> +	return filemap_fdatawrite_range(mapping, 0, LLONG_MAX);
>  }
>  EXPORT_SYMBOL(filemap_fdatawrite);
>  
> -int filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
> -				loff_t end)
> -{
> -	return __filemap_fdatawrite_range(mapping, start, end, WB_SYNC_ALL);
> -}
> -EXPORT_SYMBOL(filemap_fdatawrite_range);
> -
>  /**
>   * filemap_fdatawrite_range_kick - start writeback on a range
>   * @mapping:	target address_space
> @@ -470,7 +464,7 @@ EXPORT_SYMBOL_GPL(filemap_fdatawrite_range_kick);
>   */
>  int filemap_flush(struct address_space *mapping)
>  {
> -	return __filemap_fdatawrite(mapping, WB_SYNC_NONE);
> +	return filemap_fdatawrite_range_kick(mapping, 0, LLONG_MAX);
>  }
>  EXPORT_SYMBOL(filemap_flush);
>  
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

