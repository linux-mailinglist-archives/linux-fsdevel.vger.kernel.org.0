Return-Path: <linux-fsdevel+bounces-19809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3E28C9E48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 15:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F9E31C216A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 13:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68CE136668;
	Mon, 20 May 2024 13:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vO6RcpVl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hb2yiBDt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vO6RcpVl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hb2yiBDt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04E554789;
	Mon, 20 May 2024 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716212404; cv=none; b=kk3Fbu/28tFz1sVwYlU0xu/oRNPYlP8eg0A9jFA5cE8Xkej2V4qw8ZCaEFtG6Ie4pG1PhLHgBoM4/4jEQnn/Ls06whljJKu1AwsPF6i9jcUGQ9bw7SWFH3Qil2lUAI3dE/MknoN+y2dqnbOf37kb6otLFg5ioQO82aipr7XFFWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716212404; c=relaxed/simple;
	bh=xGnNy6C+VuxFzaTjIUtQfStEGLc+yzaEXLRGSmulHMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7abbtdIWvvX24Ch4XAGsWz1wLY4EtK3gdffR2pVEEYVHnXLHEx2JR3SlnSzVPks8VB3ok07JnsBwSUKEpDCpcl3xF+YoX/aKP8X+XLpJW8+LKUqDGw7xVK1Hh0Dr3voEcNI080YX7gk6LcibYQZqnpMEUjwUyBsFZDwdiC0rvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vO6RcpVl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hb2yiBDt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vO6RcpVl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hb2yiBDt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B7B62340ED;
	Mon, 20 May 2024 13:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716212399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W89dySKmVBbpOGB/E6+FAz/cynethEl0aWd0NZzcw84=;
	b=vO6RcpVlH4RCnJiwhOa67aW79V6NgkK+/Asi/gnWXRt5tkCeKcM4u6r0ibysiO83SvYGXs
	nxHBROop75RPphEP/EskJPX0xR0kMCBPRYrwVKMaBrie6G1EKPUtqxXD2Hg1p2aRJKpPOz
	+dl/WGpCYoPLU00poyg7v/76WUUzjsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716212399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W89dySKmVBbpOGB/E6+FAz/cynethEl0aWd0NZzcw84=;
	b=Hb2yiBDtS5NGRVCBZTpjxmhiXMzADB7b8jxGbn9Zo5aQCi7pdoWuf4svyUtfZ7waqclDZc
	kxOks1LkDMDGqXCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vO6RcpVl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Hb2yiBDt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716212399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W89dySKmVBbpOGB/E6+FAz/cynethEl0aWd0NZzcw84=;
	b=vO6RcpVlH4RCnJiwhOa67aW79V6NgkK+/Asi/gnWXRt5tkCeKcM4u6r0ibysiO83SvYGXs
	nxHBROop75RPphEP/EskJPX0xR0kMCBPRYrwVKMaBrie6G1EKPUtqxXD2Hg1p2aRJKpPOz
	+dl/WGpCYoPLU00poyg7v/76WUUzjsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716212399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W89dySKmVBbpOGB/E6+FAz/cynethEl0aWd0NZzcw84=;
	b=Hb2yiBDtS5NGRVCBZTpjxmhiXMzADB7b8jxGbn9Zo5aQCi7pdoWuf4svyUtfZ7waqclDZc
	kxOks1LkDMDGqXCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA66013A6B;
	Mon, 20 May 2024 13:39:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /C6VKa9SS2a9PAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 May 2024 13:39:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5B952A08D8; Mon, 20 May 2024 15:39:59 +0200 (CEST)
Date: Mon, 20 May 2024 15:39:59 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2] jbd2: speed up jbd2_transaction_committed()
Message-ID: <20240520133959.7tmjhayv32nlmzj3@quack3>
References: <20240520131831.2910790-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520131831.2910790-1-yi.zhang@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B7B62340ED
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,suse.com:email,huawei.com:email]

On Mon 20-05-24 21:18:31, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> jbd2_transaction_committed() is used to check whether a transaction with
> the given tid has already committed, it holds j_state_lock in read mode
> and check the tid of current running transaction and committing
> transaction, but holding the j_state_lock is expensive.
> 
> We have already stored the sequence number of the most recently
> committed transaction in journal t->j_commit_sequence, we could do this
> check by comparing it with the given tid instead. If the given tid isn't
> smaller than j_commit_sequence, we can ensure that the given transaction
> has been committed. That way we could drop the expensive lock and
> achieve about 10% ~ 20% performance gains in concurrent DIOs on may
> virtual machine with 100G ramdisk.
> 
> fio -filename=/mnt/foo -direct=1 -iodepth=10 -rw=$rw -ioengine=libaio \
>     -bs=4k -size=10G -numjobs=10 -runtime=60 -overwrite=1 -name=test \
>     -group_reporting
> 
> Before:
>   overwrite       IOPS=88.2k, BW=344MiB/s
>   read            IOPS=95.7k, BW=374MiB/s
>   rand overwrite  IOPS=98.7k, BW=386MiB/s
>   randread        IOPS=102k, BW=397MiB/s
> 
> After:
>   overwrite       IOPS=105k, BW=410MiB/s
>   read            IOPS=112k, BW=436MiB/s
>   rand overwrite  IOPS=104k, BW=404MiB/s
>   randread        IOPS=111k, BW=432MiB/s
> 
> CC: Dave Chinner <david@fromorbit.com>
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Link: https://lore.kernel.org/linux-ext4/ZjILCPNZRHeazSqV@dread.disaster.area/
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Thanks! The patch looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v1->v2:
>  - Add READ_ONCE and WRITE_ONCE to access ->j_commit_sequence
>    concurrently.
>  - Keep the jbd2_transaction_committed() helper.
> 
>  fs/jbd2/commit.c  |  2 +-
>  fs/jbd2/journal.c | 12 +-----------
>  2 files changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 5e122586e06e..8244cab17688 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -1108,7 +1108,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  
>  	commit_transaction->t_state = T_COMMIT_CALLBACK;
>  	J_ASSERT(commit_transaction == journal->j_committing_transaction);
> -	journal->j_commit_sequence = commit_transaction->t_tid;
> +	WRITE_ONCE(journal->j_commit_sequence, commit_transaction->t_tid);
>  	journal->j_committing_transaction = NULL;
>  	commit_time = ktime_to_ns(ktime_sub(ktime_get(), start_time));
>  
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index b6c114c11b97..cc586e3c4ee1 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -789,17 +789,7 @@ EXPORT_SYMBOL(jbd2_fc_end_commit_fallback);
>  /* Return 1 when transaction with given tid has already committed. */
>  int jbd2_transaction_committed(journal_t *journal, tid_t tid)
>  {
> -	int ret = 1;
> -
> -	read_lock(&journal->j_state_lock);
> -	if (journal->j_running_transaction &&
> -	    journal->j_running_transaction->t_tid == tid)
> -		ret = 0;
> -	if (journal->j_committing_transaction &&
> -	    journal->j_committing_transaction->t_tid == tid)
> -		ret = 0;
> -	read_unlock(&journal->j_state_lock);
> -	return ret;
> +	return tid_geq(READ_ONCE(journal->j_commit_sequence), tid);
>  }
>  EXPORT_SYMBOL(jbd2_transaction_committed);
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

