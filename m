Return-Path: <linux-fsdevel+bounces-10327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 028FB849D9A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 16:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA5E6285912
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 15:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C7A2DF9F;
	Mon,  5 Feb 2024 14:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P9RQfw9P";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="loSHq1L0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P9RQfw9P";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="loSHq1L0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BBF2D022
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 14:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707145135; cv=none; b=uR4mg+Vu+ZP3MVRxp27CcWLZwld5hAAP7KExPaLZx/Pw18xFGBXpm1knPMmNSLV1LcghOoUWHwxcGO0I1YMuiCFw3bVkMqX0jhmeOH/e/ElXQZRSiITiWI69Ps5MOHRk1G7eI2PqwD4ThvnliMbLAA/wyqEZ/4fzBWtql/oYhZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707145135; c=relaxed/simple;
	bh=1CqUb7zfXNEiflMVEsMvG6lMIMdgir0w4sy7NhMa0IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsZ/u13ft1nEoRR7I5AuFrGGv9eB3sY0YfBBVa/fDgBHGIugYQbuse83t2kpjW+XgTREhPToa3pbjSjMuSvt9DDVviEdD9lbAAK3JOF3ejS8+SuVbWF/z6TVkb3QNp7uPjoia6Nt/+AnUdEossc7V4vGFeOb7FVK4Jmc8Lz4ps4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P9RQfw9P; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=loSHq1L0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P9RQfw9P; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=loSHq1L0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 49A6A222AF;
	Mon,  5 Feb 2024 14:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707145131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZSQdZpd/chJ9yjlP3bEeDujtHm6IhJ2GsfL/WNjOho=;
	b=P9RQfw9P9gBHpVbo8KHmkQrMThWP2ewlFXbDA5uz9UWG40QWql/58krZgJNgDi9fI2c5Ek
	nrky3NEXPXd/wavamad++CQIk5rLMQbvL1be2G1IyyxTB8Fqi+2YzNnn5NLfAp3/ZEjaq3
	y1BgCOERfr9pyDfQOSNNqekpLQUMALo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707145131;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZSQdZpd/chJ9yjlP3bEeDujtHm6IhJ2GsfL/WNjOho=;
	b=loSHq1L0dLsgNIsgJ3g6qvAm7w3Rui2zPtW5dque/U6juuCLnZ2bLlxSxt1/7OJ4GEIiQM
	ZiEupEZ06MNJIHBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707145131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZSQdZpd/chJ9yjlP3bEeDujtHm6IhJ2GsfL/WNjOho=;
	b=P9RQfw9P9gBHpVbo8KHmkQrMThWP2ewlFXbDA5uz9UWG40QWql/58krZgJNgDi9fI2c5Ek
	nrky3NEXPXd/wavamad++CQIk5rLMQbvL1be2G1IyyxTB8Fqi+2YzNnn5NLfAp3/ZEjaq3
	y1BgCOERfr9pyDfQOSNNqekpLQUMALo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707145131;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZSQdZpd/chJ9yjlP3bEeDujtHm6IhJ2GsfL/WNjOho=;
	b=loSHq1L0dLsgNIsgJ3g6qvAm7w3Rui2zPtW5dque/U6juuCLnZ2bLlxSxt1/7OJ4GEIiQM
	ZiEupEZ06MNJIHBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E17013707;
	Mon,  5 Feb 2024 14:58:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u/4lD6v3wGWcdwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 Feb 2024 14:58:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C9226A0809; Mon,  5 Feb 2024 15:58:50 +0100 (CET)
Date: Mon, 5 Feb 2024 15:58:50 +0100
From: Jan Kara <jack@suse.cz>
To: Wang Jianjian <wangjianjian3@huawei.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, zhangzhikang1@huawei.com,
	liujie1@huawei.com, yunlanying@huawei.com, gudehe@huawei.com
Subject: Re: [PATCH v2] quota: Fix potential NULL pointer dereference
Message-ID: <20240205145850.lt6vahssi3sa2kht@quack3>
References: <20240202081852.2514092-1-wangjianjian3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202081852.2514092-1-wangjianjian3@huawei.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [5.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: *****
X-Spam-Score: 5.50
X-Spam-Flag: NO

On Fri 02-02-24 16:18:52, Wang Jianjian wrote:
> Below race may cause NULL pointer dereference
> 
> P1					P2
> dquot_free_inode			quota_off
> 					  drop_dquot_ref
> 					   remove_dquot_ref
> 					   dquots = i_dquot(inode)
>   dquots = i_dquot(inode)
>   srcu_read_lock
>   dquots[cnt]) != NULL (1)
> 					     dquots[type] = NULL (2)
>   spin_lock(&dquots[cnt]->dq_dqb_lock) (3)
>    ....
> 
> If dquot_free_inode(or other routines) checks inode's quota pointers (1)
> before quota_off sets it to NULL(2) and use it (3) after that, NULL pointer
> dereference will be triggered.
> 
> So let's fix it by using a temporary pointer to avoid this issue.
> 
> Signed-off-by: Wang Jianjian <wangjianjian3@huawei.com>

Thanks! Added to my tree.

								Honza

> ---
>  fs/quota/dquot.c | 92 +++++++++++++++++++++++++++---------------------
>  1 file changed, 52 insertions(+), 40 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 1f0c754416b6..929a720c72fc 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -402,12 +402,14 @@ EXPORT_SYMBOL(dquot_mark_dquot_dirty);
>  static inline int mark_all_dquot_dirty(struct dquot * const *dquot)
>  {
>  	int ret, err, cnt;
> +	struct dquot *dq;
>  
>  	ret = err = 0;
>  	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
> -		if (dquot[cnt])
> +		dq = srcu_dereference(dquot[cnt], &dquot_srcu);
> +		if (dq)
>  			/* Even in case of error we have to continue */
> -			ret = mark_dquot_dirty(dquot[cnt]);
> +			ret = mark_dquot_dirty(dq);
>  		if (!err)
>  			err = ret;
>  	}
> @@ -1678,6 +1680,7 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
>  	struct dquot_warn warn[MAXQUOTAS];
>  	int reserve = flags & DQUOT_SPACE_RESERVE;
>  	struct dquot **dquots;
> +	struct dquot *dquot;
>  
>  	if (!inode_quota_active(inode)) {
>  		if (reserve) {
> @@ -1697,27 +1700,26 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
>  	index = srcu_read_lock(&dquot_srcu);
>  	spin_lock(&inode->i_lock);
>  	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
> -		if (!dquots[cnt])
> +		dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
> +		if (!dquot)
>  			continue;
>  		if (reserve) {
> -			ret = dquot_add_space(dquots[cnt], 0, number, flags,
> -					      &warn[cnt]);
> +			ret = dquot_add_space(dquot, 0, number, flags, &warn[cnt]);
>  		} else {
> -			ret = dquot_add_space(dquots[cnt], number, 0, flags,
> -					      &warn[cnt]);
> +			ret = dquot_add_space(dquot, number, 0, flags, &warn[cnt]);
>  		}
>  		if (ret) {
>  			/* Back out changes we already did */
>  			for (cnt--; cnt >= 0; cnt--) {
> -				if (!dquots[cnt])
> +				dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
> +				if (!dquot)
>  					continue;
> -				spin_lock(&dquots[cnt]->dq_dqb_lock);
> +				spin_lock(&dquot->dq_dqb_lock);
>  				if (reserve)
> -					dquot_free_reserved_space(dquots[cnt],
> -								  number);
> +					dquot_free_reserved_space(dquot, number);
>  				else
> -					dquot_decr_space(dquots[cnt], number);
> -				spin_unlock(&dquots[cnt]->dq_dqb_lock);
> +					dquot_decr_space(dquot, number);
> +				spin_unlock(&dquot->dq_dqb_lock);
>  			}
>  			spin_unlock(&inode->i_lock);
>  			goto out_flush_warn;
> @@ -1748,6 +1750,7 @@ int dquot_alloc_inode(struct inode *inode)
>  	int cnt, ret = 0, index;
>  	struct dquot_warn warn[MAXQUOTAS];
>  	struct dquot * const *dquots;
> +	struct dquot *dquot;
>  
>  	if (!inode_quota_active(inode))
>  		return 0;
> @@ -1758,17 +1761,19 @@ int dquot_alloc_inode(struct inode *inode)
>  	index = srcu_read_lock(&dquot_srcu);
>  	spin_lock(&inode->i_lock);
>  	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
> -		if (!dquots[cnt])
> +		dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
> +		if (!dquot)
>  			continue;
> -		ret = dquot_add_inodes(dquots[cnt], 1, &warn[cnt]);
> +		ret = dquot_add_inodes(dquot, 1, &warn[cnt]);
>  		if (ret) {
>  			for (cnt--; cnt >= 0; cnt--) {
> -				if (!dquots[cnt])
> +				dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
> +				if (!dquot)
>  					continue;
>  				/* Back out changes we already did */
> -				spin_lock(&dquots[cnt]->dq_dqb_lock);
> -				dquot_decr_inodes(dquots[cnt], 1);
> -				spin_unlock(&dquots[cnt]->dq_dqb_lock);
> +				spin_lock(&dquot->dq_dqb_lock);
> +				dquot_decr_inodes(dquot, 1);
> +				spin_unlock(&dquot->dq_dqb_lock);
>  			}
>  			goto warn_put_all;
>  		}
> @@ -1790,6 +1795,7 @@ EXPORT_SYMBOL(dquot_alloc_inode);
>  void dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
>  {
>  	struct dquot **dquots;
> +	struct dquot *dquot;
>  	int cnt, index;
>  
>  	if (!inode_quota_active(inode)) {
> @@ -1805,9 +1811,8 @@ void dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
>  	spin_lock(&inode->i_lock);
>  	/* Claim reserved quotas to allocated quotas */
>  	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
> -		if (dquots[cnt]) {
> -			struct dquot *dquot = dquots[cnt];
> -
> +		dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
> +		if (dquot) {
>  			spin_lock(&dquot->dq_dqb_lock);
>  			if (WARN_ON_ONCE(dquot->dq_dqb.dqb_rsvspace < number))
>  				number = dquot->dq_dqb.dqb_rsvspace;
> @@ -1832,6 +1837,7 @@ EXPORT_SYMBOL(dquot_claim_space_nodirty);
>  void dquot_reclaim_space_nodirty(struct inode *inode, qsize_t number)
>  {
>  	struct dquot **dquots;
> +	struct dquot *dquot;
>  	int cnt, index;
>  
>  	if (!inode_quota_active(inode)) {
> @@ -1847,9 +1853,8 @@ void dquot_reclaim_space_nodirty(struct inode *inode, qsize_t number)
>  	spin_lock(&inode->i_lock);
>  	/* Claim reserved quotas to allocated quotas */
>  	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
> -		if (dquots[cnt]) {
> -			struct dquot *dquot = dquots[cnt];
> -
> +		dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
> +		if (dquot) {
>  			spin_lock(&dquot->dq_dqb_lock);
>  			if (WARN_ON_ONCE(dquot->dq_dqb.dqb_curspace < number))
>  				number = dquot->dq_dqb.dqb_curspace;
> @@ -1876,6 +1881,7 @@ void __dquot_free_space(struct inode *inode, qsize_t number, int flags)
>  	unsigned int cnt;
>  	struct dquot_warn warn[MAXQUOTAS];
>  	struct dquot **dquots;
> +	struct dquot *dquot;
>  	int reserve = flags & DQUOT_SPACE_RESERVE, index;
>  
>  	if (!inode_quota_active(inode)) {
> @@ -1896,17 +1902,18 @@ void __dquot_free_space(struct inode *inode, qsize_t number, int flags)
>  		int wtype;
>  
>  		warn[cnt].w_type = QUOTA_NL_NOWARN;
> -		if (!dquots[cnt])
> +		dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
> +		if (!dquot)
>  			continue;
> -		spin_lock(&dquots[cnt]->dq_dqb_lock);
> -		wtype = info_bdq_free(dquots[cnt], number);
> +		spin_lock(&dquot->dq_dqb_lock);
> +		wtype = info_bdq_free(dquot, number);
>  		if (wtype != QUOTA_NL_NOWARN)
> -			prepare_warning(&warn[cnt], dquots[cnt], wtype);
> +			prepare_warning(&warn[cnt], dquot, wtype);
>  		if (reserve)
> -			dquot_free_reserved_space(dquots[cnt], number);
> +			dquot_free_reserved_space(dquot, number);
>  		else
> -			dquot_decr_space(dquots[cnt], number);
> -		spin_unlock(&dquots[cnt]->dq_dqb_lock);
> +			dquot_decr_space(dquot, number);
> +		spin_unlock(&dquot->dq_dqb_lock);
>  	}
>  	if (reserve)
>  		*inode_reserved_space(inode) -= number;
> @@ -1931,6 +1938,7 @@ void dquot_free_inode(struct inode *inode)
>  	unsigned int cnt;
>  	struct dquot_warn warn[MAXQUOTAS];
>  	struct dquot * const *dquots;
> +	struct dquot *dquot;
>  	int index;
>  
>  	if (!inode_quota_active(inode))
> @@ -1941,16 +1949,16 @@ void dquot_free_inode(struct inode *inode)
>  	spin_lock(&inode->i_lock);
>  	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
>  		int wtype;
> -
>  		warn[cnt].w_type = QUOTA_NL_NOWARN;
> -		if (!dquots[cnt])
> +		dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
> +		if (!dquot)
>  			continue;
> -		spin_lock(&dquots[cnt]->dq_dqb_lock);
> -		wtype = info_idq_free(dquots[cnt], 1);
> +		spin_lock(&dquot->dq_dqb_lock);
> +		wtype = info_idq_free(dquot, 1);
>  		if (wtype != QUOTA_NL_NOWARN)
> -			prepare_warning(&warn[cnt], dquots[cnt], wtype);
> -		dquot_decr_inodes(dquots[cnt], 1);
> -		spin_unlock(&dquots[cnt]->dq_dqb_lock);
> +			prepare_warning(&warn[cnt], dquot, wtype);
> +		dquot_decr_inodes(dquot, 1);
> +		spin_unlock(&dquot->dq_dqb_lock);
>  	}
>  	spin_unlock(&inode->i_lock);
>  	mark_all_dquot_dirty(dquots);
> @@ -1977,7 +1985,7 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
>  	qsize_t rsv_space = 0;
>  	qsize_t inode_usage = 1;
>  	struct dquot *transfer_from[MAXQUOTAS] = {};
> -	int cnt, ret = 0;
> +	int cnt, index, ret = 0;
>  	char is_valid[MAXQUOTAS] = {};
>  	struct dquot_warn warn_to[MAXQUOTAS];
>  	struct dquot_warn warn_from_inodes[MAXQUOTAS];
> @@ -2066,8 +2074,12 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
>  	spin_unlock(&inode->i_lock);
>  	spin_unlock(&dq_data_lock);
>  
> +	/* acquire rcu lock to avoid assertion check warning */
> +	index = srcu_read_lock(&dquot_srcu);
>  	mark_all_dquot_dirty(transfer_from);
>  	mark_all_dquot_dirty(transfer_to);
> +	srcu_read_unlock(&dquot_srcu, index);
> +
>  	flush_warnings(warn_to);
>  	flush_warnings(warn_from_inodes);
>  	flush_warnings(warn_from_space);
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

