Return-Path: <linux-fsdevel+bounces-53658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A50AF5AA5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 16:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770FB188AB76
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 14:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7A02BD5B5;
	Wed,  2 Jul 2025 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kzQa8lv5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cIRDrzBS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kzQa8lv5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cIRDrzBS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C15F2BCF51
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465463; cv=none; b=q3WN+S7DDGdYq8vysPW3ZQXn5TDImABfzSnV5iBUoc3jazrtLfdm/POb/UBVRcysyLBp/9dxSd8UiINX2bdMqqbDDgoTW+uHt2MZefyvOuYRDjGTPI9TzTbYlZw5Q+95xL+5Qylh9LIjOqP4QvmUgs+TDRIGSecbktBATlUQfz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465463; c=relaxed/simple;
	bh=XH9LIv5DjlEQvQUcxLjrQnIy5UoheiabMEDO0Yq4lQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=allvYH0ku/A/fEp4h2TCcb6nxXJbKNJp66piSrU5S7q3wPQTtFHYmaZX16zbZz+u+lT7+wlvCJ/iMnoqJqjK1j/Ls2XbWEvVPJrlZXStkc0hGNLPs0vejTRVb0KudCmZcpjArZXn8q0b6S5XbERs0ukH8X1HPDVYiyFl5JErqt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kzQa8lv5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cIRDrzBS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kzQa8lv5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cIRDrzBS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 502A32118C;
	Wed,  2 Jul 2025 14:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751465460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ec4lvPxD+Im5OIbkkiVJgxQ8vvdCpvany66SPb/hpS4=;
	b=kzQa8lv5lBQUYWHF9ifqwnq6aMlcduVzP03mFXQ+tUioxTxz8qXQtmTcPE7sSV/tenXq6z
	XVSqbMCJtHH1wgZbCZQzmhSWyj385W3HgUvNv7SZnpBjS7ans50VgPcUs/45B6Sznb39ds
	BG8ZeCLs8c8SFbxpajWbmGJ+AuFWO9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751465460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ec4lvPxD+Im5OIbkkiVJgxQ8vvdCpvany66SPb/hpS4=;
	b=cIRDrzBSuQju3UVyA+EqGnxxwKVCdf9Y//plPC83pYurqQn6ZoJ58mrG5X7d3Bdsj3yQVW
	GG2wYlZbRVvMyYBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kzQa8lv5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cIRDrzBS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751465460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ec4lvPxD+Im5OIbkkiVJgxQ8vvdCpvany66SPb/hpS4=;
	b=kzQa8lv5lBQUYWHF9ifqwnq6aMlcduVzP03mFXQ+tUioxTxz8qXQtmTcPE7sSV/tenXq6z
	XVSqbMCJtHH1wgZbCZQzmhSWyj385W3HgUvNv7SZnpBjS7ans50VgPcUs/45B6Sznb39ds
	BG8ZeCLs8c8SFbxpajWbmGJ+AuFWO9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751465460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ec4lvPxD+Im5OIbkkiVJgxQ8vvdCpvany66SPb/hpS4=;
	b=cIRDrzBSuQju3UVyA+EqGnxxwKVCdf9Y//plPC83pYurqQn6ZoJ58mrG5X7d3Bdsj3yQVW
	GG2wYlZbRVvMyYBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4687713A24;
	Wed,  2 Jul 2025 14:11:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V242EfQ9ZWgtQAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 02 Jul 2025 14:11:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 02AB7A0A55; Wed,  2 Jul 2025 16:10:59 +0200 (CEST)
Date: Wed, 2 Jul 2025 16:10:59 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	ojaswin@linux.ibm.com, sashal@kernel.org, yi.zhang@huawei.com, libaokun1@huawei.com, 
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 04/10] ext4: refactor the block allocation process of
 ext4_page_mkwrite()
Message-ID: <y66ier4j3kqxagrm4ztdls4iqxpggaj2bt4nwtsi2hen2bgnn3@ph3cev64ie6w>
References: <20250701130635.4079595-1-yi.zhang@huaweicloud.com>
 <20250701130635.4079595-5-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701130635.4079595-5-yi.zhang@huaweicloud.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,huawei.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 502A32118C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

On Tue 01-07-25 21:06:29, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The block allocation process and error handling in ext4_page_mkwrite()
> is complex now. Refactor it by introducing a new helper function,
> ext4_block_page_mkwrite(). It will call ext4_block_write_begin() to
> allocate blocks instead of directly calling block_page_mkwrite().
> Preparing to implement retry logic in a subsequent patch to address
> situations where the reserved journal credits are insufficient.
> Additionally, this modification will help prevent potential deadlocks
> that may occur when waiting for folio writeback while holding the
> transaction handle.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

One typo fix below:

> +	/* Start jorunal and allocate blocks */
		 ^^^ journal

> +	err = ext4_block_page_mkwrite(inode, folio, get_block);
>  	if (err == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
>  		goto retry_alloc;
>  out_ret:

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

