Return-Path: <linux-fsdevel+bounces-42009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A5FA3A7EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 20:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FC51168C48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 19:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51DC1EB5CA;
	Tue, 18 Feb 2025 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zq1jB/zy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lgdcfhwh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zq1jB/zy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lgdcfhwh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A6621B9FE
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 19:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907930; cv=none; b=iAvkD1cG5ERyEi/K+oP/e7oq/dk1nl6VABDFb5bC/LR6cJ+XnX6h7Ap8FFoVBhByWOHqjxKpGXJ0xRjmWQbZnoMV1r7X+NVKdoEFdK8fTZFADF7j5xBKJE5mCMvvq6o+Ryn/CpVrQoqSJ2H0CazxgLSjnA6MNbDPfdEF5YjGoUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907930; c=relaxed/simple;
	bh=VL67vrhkNcuJ+bmsLxUn5Ns4a+VAZxxduzYfTTMHY08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qt7Kh9+WSYf6o9Lxtx4DunHx9Iq76ZCnTizF67ajljQ5EWfQ10xks/g7QVkywN2718JAkIeA7mhykWXADpECWw1JyLFG7xhD5zF2h0FwddNbLx46tbTmyCavSjEuYsGH9UDcBv/5K7khn2pYjC0bsHxuw125KD5ssGJbuBTz8Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zq1jB/zy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lgdcfhwh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zq1jB/zy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lgdcfhwh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 62D1E2115B;
	Tue, 18 Feb 2025 19:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739907926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XWzvQfV1p/CJsRj89ffaPQw19zOrjrV5Qb2XWNKOyo8=;
	b=Zq1jB/zySKVYZGy0xWt4cfFEsPU8U7PrZWuYvM6w/K+hcOU1BiT6RiT0Rx+pTvCTpajx4I
	SoMK9nw52K0rggAZ7tziHfw+oTR2jtGnn7GY+46kbi9KvT1Mjolos4szfvEar5rNMwzY2a
	1uK3a8zCQbZ0Y69Hf920Iv489BlCsMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739907926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XWzvQfV1p/CJsRj89ffaPQw19zOrjrV5Qb2XWNKOyo8=;
	b=Lgdcfhwh7krOXeufyNeBcylmHdihWt+AGM9Ts1p0spDpU5XTXCpoxz3XpHci/NOcrrsMbR
	I1xhCE2Ty2Qh3LCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Zq1jB/zy";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Lgdcfhwh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739907926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XWzvQfV1p/CJsRj89ffaPQw19zOrjrV5Qb2XWNKOyo8=;
	b=Zq1jB/zySKVYZGy0xWt4cfFEsPU8U7PrZWuYvM6w/K+hcOU1BiT6RiT0Rx+pTvCTpajx4I
	SoMK9nw52K0rggAZ7tziHfw+oTR2jtGnn7GY+46kbi9KvT1Mjolos4szfvEar5rNMwzY2a
	1uK3a8zCQbZ0Y69Hf920Iv489BlCsMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739907926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XWzvQfV1p/CJsRj89ffaPQw19zOrjrV5Qb2XWNKOyo8=;
	b=Lgdcfhwh7krOXeufyNeBcylmHdihWt+AGM9Ts1p0spDpU5XTXCpoxz3XpHci/NOcrrsMbR
	I1xhCE2Ty2Qh3LCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5352913A1D;
	Tue, 18 Feb 2025 19:45:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6f8ZFFbjtGdISAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 18 Feb 2025 19:45:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F35B4A08B5; Tue, 18 Feb 2025 20:45:25 +0100 (CET)
Date: Tue, 18 Feb 2025 20:45:25 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	leah.rumancik@gmail.com, yi.zhang@huawei.com, libaokun1@huawei.com, 
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] jbd2: fix off-by-one while erasing journal
Message-ID: <jfqvfixofvlwowm6fbxsndg3kvktbqg4gsl3y5z2cj5tjemk47@46stlum5yu32>
References: <20250217065955.3829229-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217065955.3829229-1-yi.zhang@huaweicloud.com>
X-Rspamd-Queue-Id: 62D1E2115B
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 17-02-25 14:59:55, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> In __jbd2_journal_erase(), the block_stop parameter includes the last
> block of a contiguous region; however, the calculation of byte_stop is
> incorrect, as it does not account for the bytes in that last block.
> Consequently, the page cache is not cleared properly, which occasionally
> causes the ext4/050 test to fail.
> 
> Since block_stop operates on inclusion semantics, it involves repeated
> increments and decrements by 1, significantly increasing the complexity
> of the calculations. Optimize the calculation and fix the incorrect
> byte_stop by make both block_stop and byte_stop to use exclusion
> semantics.
> 
> This fixes a failure in fstests ext4/050.
> 
> Fixes: 01d5d96542fd ("ext4: add discard/zeroout flags to journal flush")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index d8084b31b361..49a9e99cbc03 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1965,17 +1965,15 @@ static int __jbd2_journal_erase(journal_t *journal, unsigned int flags)
>  			return err;
>  		}
>  
> -		if (block_start == ~0ULL) {
> -			block_start = phys_block;
> -			block_stop = block_start - 1;
> -		}
> +		if (block_start == ~0ULL)
> +			block_stop = block_start = phys_block;
>  
>  		/*
>  		 * last block not contiguous with current block,
>  		 * process last contiguous region and return to this block on
>  		 * next loop
>  		 */
> -		if (phys_block != block_stop + 1) {
> +		if (phys_block != block_stop) {
>  			block--;
>  		} else {
>  			block_stop++;
> @@ -1994,11 +1992,10 @@ static int __jbd2_journal_erase(journal_t *journal, unsigned int flags)
>  		 */
>  		byte_start = block_start * journal->j_blocksize;
>  		byte_stop = block_stop * journal->j_blocksize;
> -		byte_count = (block_stop - block_start + 1) *
> -				journal->j_blocksize;
> +		byte_count = (block_stop - block_start) * journal->j_blocksize;
>  
>  		truncate_inode_pages_range(journal->j_dev->bd_mapping,
> -				byte_start, byte_stop);
> +				byte_start, byte_stop - 1);
>  
>  		if (flags & JBD2_JOURNAL_FLUSH_DISCARD) {
>  			err = blkdev_issue_discard(journal->j_dev,
> @@ -2013,7 +2010,7 @@ static int __jbd2_journal_erase(journal_t *journal, unsigned int flags)
>  		}
>  
>  		if (unlikely(err != 0)) {
> -			pr_err("JBD2: (error %d) unable to wipe journal at physical blocks %llu - %llu",
> +			pr_err("JBD2: (error %d) unable to wipe journal at physical blocks [%llu, %llu)",
>  					err, block_start, block_stop);
>  			return err;
>  		}
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

