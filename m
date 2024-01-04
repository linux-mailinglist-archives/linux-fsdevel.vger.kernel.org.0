Return-Path: <linux-fsdevel+bounces-7360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFEC82415F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 13:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C4C282DD9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 12:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FA2219FF;
	Thu,  4 Jan 2024 12:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e3sjw3qz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yQXb9LPj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e3sjw3qz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yQXb9LPj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0432136E;
	Thu,  4 Jan 2024 12:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1152E1F805;
	Thu,  4 Jan 2024 12:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704370311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ZeDUh4C7zA3YQ4fYm2i65EzKNR/mQAuN7BWkbo24yo=;
	b=e3sjw3qzaFj1bR2K3ph+SCgBs0W5KbKSkTDh6j9mOfMzcA4ll5T88VX7DvbyrfhjMaOgEU
	ULNk5uKyzCEeOrIlpEpgveioXn6k/trmuztnPHJGyuhf31ImQ2Y/fqDPmQvtkeijr8KG0S
	hbXlHYuGqhsgRPRLiscvp4MGINF5+lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704370311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ZeDUh4C7zA3YQ4fYm2i65EzKNR/mQAuN7BWkbo24yo=;
	b=yQXb9LPjRaWSg2B28C8A0dOdwxgSX7f2zAKDyWfCb78V8RXDAvfljmM2SO6fP/MQIajAvj
	t7RHhrFKNOkLHNCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704370311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ZeDUh4C7zA3YQ4fYm2i65EzKNR/mQAuN7BWkbo24yo=;
	b=e3sjw3qzaFj1bR2K3ph+SCgBs0W5KbKSkTDh6j9mOfMzcA4ll5T88VX7DvbyrfhjMaOgEU
	ULNk5uKyzCEeOrIlpEpgveioXn6k/trmuztnPHJGyuhf31ImQ2Y/fqDPmQvtkeijr8KG0S
	hbXlHYuGqhsgRPRLiscvp4MGINF5+lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704370311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ZeDUh4C7zA3YQ4fYm2i65EzKNR/mQAuN7BWkbo24yo=;
	b=yQXb9LPjRaWSg2B28C8A0dOdwxgSX7f2zAKDyWfCb78V8RXDAvfljmM2SO6fP/MQIajAvj
	t7RHhrFKNOkLHNCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4BA2137E8;
	Thu,  4 Jan 2024 12:11:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 63jMN4aglmWaEgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Jan 2024 12:11:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3F4B9A07EF; Thu,  4 Jan 2024 13:11:50 +0100 (CET)
Date: Thu, 4 Jan 2024 13:11:50 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, roger.pau@citrix.com, colyli@suse.de,
	kent.overstreet@gmail.com, joern@lazybastard.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	sth@linux.ibm.com, hoeppner@linux.ibm.com, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	nico@fluxnic.net, xiang@kernel.org, chao@kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.com, konishi.ryusuke@gmail.com,
	willy@infradead.org, akpm@linux-foundation.org, hare@suse.de,
	p.raghav@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, linux-nilfs@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH RFC v3 for-6.8/block 13/17] jbd2: use bdev apis
Message-ID: <20240104121150.cxrykpptpgnwkqge@quack3>
References: <20231221085712.1766333-1-yukuai1@huaweicloud.com>
 <20231221085846.1768977-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221085846.1768977-1-yukuai1@huaweicloud.com>
X-Spam-Score: 1.90
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 R_RATELIMIT(0.00)[to_ip_from(RLdan9jouj5dxnqx1npfmn4ucx)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[48];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kernel.dk,citrix.com,suse.de,gmail.com,lazybastard.org,bootlin.com,nod.at,ti.com,linux.ibm.com,oracle.com,fb.com,toxicpanda.com,suse.com,zeniv.linux.org.uk,kernel.org,fluxnic.net,mit.edu,dilger.ca,infradead.org,linux-foundation.org,samsung.com,vger.kernel.org,lists.xenproject.org,lists.infradead.org,lists.ozlabs.org,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: *
X-Spam-Flag: NO

On Thu 21-12-23 16:58:46, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Avoid to access bd_inode directly, prepare to remove bd_inode from
> block_device.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

But note there are changes pending to this code for the coming merge window
so you'll have to rebase...

								Honza

> ---
>  fs/jbd2/journal.c  | 3 +--
>  fs/jbd2/recovery.c | 6 ++----
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index ed53188472f9..f1b5ffeaf02a 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -2003,8 +2003,7 @@ static int __jbd2_journal_erase(journal_t *journal, unsigned int flags)
>  		byte_count = (block_stop - block_start + 1) *
>  				journal->j_blocksize;
>  
> -		truncate_inode_pages_range(journal->j_dev->bd_inode->i_mapping,
> -				byte_start, byte_stop);
> +		truncate_bdev_range(journal->j_dev, 0, byte_start, byte_stop);
>  
>  		if (flags & JBD2_JOURNAL_FLUSH_DISCARD) {
>  			err = blkdev_issue_discard(journal->j_dev,
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 01f744cb97a4..6b6a2c4585fa 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -290,7 +290,6 @@ int jbd2_journal_recover(journal_t *journal)
>  
>  	struct recovery_info	info;
>  	errseq_t		wb_err;
> -	struct address_space	*mapping;
>  
>  	memset(&info, 0, sizeof(info));
>  	sb = journal->j_superblock;
> @@ -309,8 +308,7 @@ int jbd2_journal_recover(journal_t *journal)
>  	}
>  
>  	wb_err = 0;
> -	mapping = journal->j_fs_dev->bd_inode->i_mapping;
> -	errseq_check_and_advance(&mapping->wb_err, &wb_err);
> +	bdev_wb_err_check_and_advance(journal->j_fs_dev, &wb_err);
>  	err = do_one_pass(journal, &info, PASS_SCAN);
>  	if (!err)
>  		err = do_one_pass(journal, &info, PASS_REVOKE);
> @@ -334,7 +332,7 @@ int jbd2_journal_recover(journal_t *journal)
>  	err2 = sync_blockdev(journal->j_fs_dev);
>  	if (!err)
>  		err = err2;
> -	err2 = errseq_check_and_advance(&mapping->wb_err, &wb_err);
> +	err2 = bdev_wb_err_check_and_advance(journal->j_fs_dev, &wb_err);
>  	if (!err)
>  		err = err2;
>  	/* Make sure all replayed data is on permanent storage */
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

