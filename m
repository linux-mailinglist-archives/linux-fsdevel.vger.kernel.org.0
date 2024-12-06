Return-Path: <linux-fsdevel+bounces-36638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1BA9E721A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 16:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC92328686A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 15:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFA8206F0F;
	Fri,  6 Dec 2024 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NYHiOjMf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="c07/TGQl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KIobXyBB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3FVFMlA4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF581537D4;
	Fri,  6 Dec 2024 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497473; cv=none; b=N5RmbLksIhgpPADM93ZphTG22l3r45Y4DAtE7fav6s7RcJg5Wg4OUIk0JRGCDlSso37I7v0ltIAspmbNCaLlDZltqBmvD/9G7VZLxdclwbSb9k5PqUqfU5iQKz5rfqY8bUrD5DgLX0bNS5CMMJ0O+a9dOzN/iacxr5YKKLveLyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497473; c=relaxed/simple;
	bh=7UmVTncpApXnhcfwKAyt2WWJNj/LD4BxtJQC8oJwcd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFQbnvBUBrFdwiv6dGy7zGJHZNJUbWUpkgFEr0tgkYzHB5kF9kdpp2GDz0tD30tzev9i2kyoHAlaV545YEqMvpCtqWPEv4hywzJv3iEOobOoCu/vTMJbB3/Q6vvRRilhfXd1q/tgJgj2JTO3gkFyvOdbnppIyIZ/UGL/ucFhMZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NYHiOjMf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=c07/TGQl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KIobXyBB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3FVFMlA4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 44B3721151;
	Fri,  6 Dec 2024 15:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733497469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K2PfM4ar4aZOvFXqOzp0ywwZZ2Ae6bv0KEHZcP9bkXg=;
	b=NYHiOjMficVrF6HKI6zVQt+kICBpgyDBBSbdd5snwU7EXeKa7IMagO+xwZRHXCqzoBeSeK
	YV0L53EcHTvkbWNCd9t0PVU3MUYB0SAfrUf4XFyuFNQIJmfxhaebUqxhB6NmvUnczDe0Jc
	MZOEauy24/3iBTO3pYkfOpTvPzcR16g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733497469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K2PfM4ar4aZOvFXqOzp0ywwZZ2Ae6bv0KEHZcP9bkXg=;
	b=c07/TGQlOzAvXcq+6bzmw4UpFKF/IWqfkjpD3GVWieuqjpozHoH9tRvf1RP125F4KqSKbS
	Y5OKdpeW7YhBRgBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733497468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K2PfM4ar4aZOvFXqOzp0ywwZZ2Ae6bv0KEHZcP9bkXg=;
	b=KIobXyBBagDbw+5WNkmC9zXL+tWU2CxiKhRGGWuiFb4bVaGV3HWj46gzKXcyI9lX7koXKo
	ed3zzkfI6yDwJnDGMaWXbDL+ZOZVxf7Ml9MJd7TuvpnAg2QwGFj+DLWvsi+R1AFg330gqM
	jmNmD1Iz+TOJGM2A2DaSRyj52mplLCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733497468;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K2PfM4ar4aZOvFXqOzp0ywwZZ2Ae6bv0KEHZcP9bkXg=;
	b=3FVFMlA41+MmHUA2+inkIrhvtWxQ8aDXe/iEX3KijN+qP+qRaqmgsGuOty6VRugYHnAE2E
	nShQDVHDkH9jwwAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 353C413647;
	Fri,  6 Dec 2024 15:04:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JaH2DHwSU2c3dAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 06 Dec 2024 15:04:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CEAB0A08CD; Fri,  6 Dec 2024 16:04:27 +0100 (CET)
Date: Fri, 6 Dec 2024 16:04:27 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] jbd2: add a missing data flush during file and fs
 synchronization
Message-ID: <20241206150427.fdqnme4kqpt3ohdl@quack3>
References: <20241206111327.4171337-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206111327.4171337-1-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 06-12-24 19:13:27, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When the filesystem performs file or filesystem synchronization (e.g.,
> ext4_sync_file()), it queries the journal to determine whether to flush
> the file device through jbd2_trans_will_send_data_barrier(). If the
> target transaction has not started committing, it assumes that the
> journal will submit the flush command, allowing the filesystem to bypass
> a redundant flush command. However, this assumption is not always valid.
> If the journal is not located on the filesystem device, the journal
> commit thread will not submit the flush command unless the variable
> ->t_need_data_flush is set to 1. Consequently, the flush may be missed,
> and data may be lost following a power failure or system crash, even if
> the synchronization appears to succeed.
> 
> Unfortunately, we cannot determine with certainty whether the target
> transaction will flush to the filesystem device before it commits.
> However, if it has not started committing, it must be the running
> transaction. Therefore, fix it by always set its t_need_data_flush to 1,
> ensuring that the committing thread will flush the filesystem device.
> 
> Fixes: bbd2be369107 ("jbd2: Add function jbd2_trans_will_send_data_barrier()")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 97f487c3d8fc..37632ae18a4e 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -609,7 +609,7 @@ int jbd2_journal_start_commit(journal_t *journal, tid_t *ptid)
>  int jbd2_trans_will_send_data_barrier(journal_t *journal, tid_t tid)
>  {
>  	int ret = 0;
> -	transaction_t *commit_trans;
> +	transaction_t *commit_trans, *running_trans;
>  
>  	if (!(journal->j_flags & JBD2_BARRIER))
>  		return 0;
> @@ -619,6 +619,16 @@ int jbd2_trans_will_send_data_barrier(journal_t *journal, tid_t tid)
>  		goto out;
>  	commit_trans = journal->j_committing_transaction;
>  	if (!commit_trans || commit_trans->t_tid != tid) {
> +		running_trans = journal->j_running_transaction;
> +		/*
> +		 * The query transaction hasn't started committing,
> +		 * it must still be running.
> +		 */
> +		if (WARN_ON_ONCE(!running_trans ||
> +				 running_trans->t_tid != tid))
> +			goto out;
> +
> +		running_trans->t_need_data_flush = 1;
>  		ret = 1;
>  		goto out;
>  	}
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

