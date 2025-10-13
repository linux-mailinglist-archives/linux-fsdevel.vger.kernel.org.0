Return-Path: <linux-fsdevel+bounces-63950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8748BBD2CC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 13:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAF0C189CF8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 11:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C1D264A7F;
	Mon, 13 Oct 2025 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VvBNMu31";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eIxwR+o+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VvBNMu31";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eIxwR+o+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431A825A2C8
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 11:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760355293; cv=none; b=WFg7FFMDDNO8+Q5S9pLgw1sbh655DW0i4vtMoF9OPNaqxy2f3rvJvcEwdXUC4QH1WwRZ7pEXizqh6EUXXRmaMJHCk0aG+iFSJEkKF/w1UzNbUg5vbABQgq22F4ZaZNApPGdkFt+PjzkvawBpBwFLUlHFv6uAogOLeS7pC7JLwkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760355293; c=relaxed/simple;
	bh=IPK5+g4OJiHIz59a98xtTy3KkJqMxFh29aL+Vuj2Esk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QL9bNExTNKRL4dr3nImxA5V9g+EUPuviplnL1qp7psJwxnMeSGxaSW/Etyr5I4wDdlmkU+iBHWePZd0VhLyzHrAcE0EScWyY2APn8Klkx9lwqd4m7+U9O5gnua7YF2/k4XxUSK+qSkZh5BDkswXSyRCIh3vIKcDzOiX1t/PhMIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VvBNMu31; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eIxwR+o+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VvBNMu31; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eIxwR+o+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8C39321A23;
	Mon, 13 Oct 2025 11:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760355289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZruJ2vBh/q3aJxQpIVa0GdVinSL6t74qWuGCsK+kFcE=;
	b=VvBNMu317BLFpyXxQhUXDUkOIY2f93s7yBDExd2dJ1Wip2HTbvnMxf2pDOtx1jG+WwGmNr
	NvkgEtj8LFuUQbg0FgsMPMO61RbFJLm5BSFIoUa1LeqiLgGucURHQ0DrD2mFIlVHY/Cqi2
	pXVFeiJmkQ6m8Mq4xjYyrTB0whJQge0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760355289;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZruJ2vBh/q3aJxQpIVa0GdVinSL6t74qWuGCsK+kFcE=;
	b=eIxwR+o+i99D6DbKhFQXkZC3sTtXrJ9ZPNH+LEnDSYsN/hrMWUAJh0H6bTqAE/+nRdMTEy
	GroDypH7K6FlH7Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760355289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZruJ2vBh/q3aJxQpIVa0GdVinSL6t74qWuGCsK+kFcE=;
	b=VvBNMu317BLFpyXxQhUXDUkOIY2f93s7yBDExd2dJ1Wip2HTbvnMxf2pDOtx1jG+WwGmNr
	NvkgEtj8LFuUQbg0FgsMPMO61RbFJLm5BSFIoUa1LeqiLgGucURHQ0DrD2mFIlVHY/Cqi2
	pXVFeiJmkQ6m8Mq4xjYyrTB0whJQge0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760355289;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZruJ2vBh/q3aJxQpIVa0GdVinSL6t74qWuGCsK+kFcE=;
	b=eIxwR+o+i99D6DbKhFQXkZC3sTtXrJ9ZPNH+LEnDSYsN/hrMWUAJh0H6bTqAE/+nRdMTEy
	GroDypH7K6FlH7Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7623C1374A;
	Mon, 13 Oct 2025 11:34:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FcPUHNnj7GjwaQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 Oct 2025 11:34:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F1018A0A58; Mon, 13 Oct 2025 13:34:48 +0200 (CEST)
Date: Mon, 13 Oct 2025 13:34:48 +0200
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
	ocfs2-devel@lists.linux.dev, linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 03/10] ocfs2: don't opencode filemap_fdatawrite_range in
 ocfs2_journal_submit_inode_data_buffers
Message-ID: <cqprjkby6ge4vvcxmmxrdhngsbigp2mms4oqxaspai63dkuvgg@3wtgz7qgxgbt>
References: <20251013025808.4111128-1-hch@lst.de>
 <20251013025808.4111128-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013025808.4111128-4-hch@lst.de>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo,lst.de:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Mon 13-10-25 11:57:58, Christoph Hellwig wrote:
> Use filemap_fdatawrite_range instead of opencoding the logic using
> filemap_fdatawrite_wbc.  There is a slight change in the conversion
> as nr_to_write is now set to LONG_MAX instead of double the number
> of the pages in the range.  LONG_MAX is the usual nr_to_write for
> WB_SYNC_ALL writeback, and the value expected by lower layers here.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ocfs2/journal.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
> index e5f58ff2175f..85239807dec7 100644
> --- a/fs/ocfs2/journal.c
> +++ b/fs/ocfs2/journal.c
> @@ -902,15 +902,8 @@ int ocfs2_journal_alloc(struct ocfs2_super *osb)
>  
>  static int ocfs2_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
>  {
> -	struct address_space *mapping = jinode->i_vfs_inode->i_mapping;
> -	struct writeback_control wbc = {
> -		.sync_mode =  WB_SYNC_ALL,
> -		.nr_to_write = mapping->nrpages * 2,
> -		.range_start = jinode->i_dirty_start,
> -		.range_end = jinode->i_dirty_end,
> -	};
> -
> -	return filemap_fdatawrite_wbc(mapping, &wbc);
> +	return filemap_fdatawrite_range(jinode->i_vfs_inode->i_mapping,
> +			jinode->i_dirty_start, jinode->i_dirty_end);
>  }
>  
>  int ocfs2_journal_init(struct ocfs2_super *osb, int *dirty)
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

