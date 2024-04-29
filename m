Return-Path: <linux-fsdevel+bounces-18117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DD58B5EF5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 18:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E502812ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 16:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C86384D22;
	Mon, 29 Apr 2024 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Oa/2UJmv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pM8rDZ55";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Oa/2UJmv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pM8rDZ55"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F2084A30;
	Mon, 29 Apr 2024 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408050; cv=none; b=faZBGbo+hMd+9PdK58qqdYImgHwSGNkTKGsIbJ0854Yejk1jge3uCcJsHMJZflYotQrX+6nLdc879jQfjD55dHSpHUP0xpJhgZ52lg+PMlYBhTOFqCdfy13eyUwz9Iyjl5fGvCSMYpr3zUjZEaAG/wNk4RRAU7rlQNMlyJ+FA0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408050; c=relaxed/simple;
	bh=P9PlTcI0sAwPhQz/iv/gS1BiAKtJJIPZh4QaaugdsM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcMnhbrrSCuX/E/f8uq4A7vOuBuEqrb5cy76/aZz7LnHlLEmo+4TQPfK9J1PQm/MiPt4jGUVZlbIQJIvB/wAFdCrUPWsBlLW7cJvc6UFNLaIaONV03zhn6VrEK0OdrC027R4EV/6vuv0p4QdcyR1d7mLX0NaKRTR5krR9hYVqyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Oa/2UJmv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pM8rDZ55; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Oa/2UJmv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pM8rDZ55; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7FDBC33938;
	Mon, 29 Apr 2024 16:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714408046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DA0UakU/4/IzIxfK8LkcUEKuRjE5564S3GFhJSkZNCI=;
	b=Oa/2UJmvnUZV4aHfO8rPcxUWLGwR0jF8UPRGPbJmvbw5hdLvHekfa6imNlfft1DJV+6Er1
	Rm2LnaItDQ7KWDBHtnwTdsKrwijOLuHl3RaYGAmaHcIOlD1/cegDuRHhUpWuLcMeXmkQqr
	4Ckjyx6EEf65hwAsdKeIBMwbalpwIzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714408046;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DA0UakU/4/IzIxfK8LkcUEKuRjE5564S3GFhJSkZNCI=;
	b=pM8rDZ550zjK+fM4380W1eoh+8M9z1CqTS2Rnb0fyb47JAc3QC3thPcGHnqudgBgTh3OSx
	CKb3yuL+n0qxI/Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714408046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DA0UakU/4/IzIxfK8LkcUEKuRjE5564S3GFhJSkZNCI=;
	b=Oa/2UJmvnUZV4aHfO8rPcxUWLGwR0jF8UPRGPbJmvbw5hdLvHekfa6imNlfft1DJV+6Er1
	Rm2LnaItDQ7KWDBHtnwTdsKrwijOLuHl3RaYGAmaHcIOlD1/cegDuRHhUpWuLcMeXmkQqr
	4Ckjyx6EEf65hwAsdKeIBMwbalpwIzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714408046;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DA0UakU/4/IzIxfK8LkcUEKuRjE5564S3GFhJSkZNCI=;
	b=pM8rDZ550zjK+fM4380W1eoh+8M9z1CqTS2Rnb0fyb47JAc3QC3thPcGHnqudgBgTh3OSx
	CKb3yuL+n0qxI/Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6EA29139DE;
	Mon, 29 Apr 2024 16:27:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fmL+Gm7KL2aCMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 29 Apr 2024 16:27:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DF5B2A082F; Mon, 29 Apr 2024 18:27:25 +0200 (CEST)
Date: Mon, 29 Apr 2024 18:27:25 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 5/9] ext4: make ext4_es_insert_delayed_block() insert
 multi-blocks
Message-ID: <20240429162725.rzj43hscw6to7xed@quack3>
References: <20240410034203.2188357-1-yi.zhang@huaweicloud.com>
 <20240410034203.2188357-6-yi.zhang@huaweicloud.com>
 <20240429091638.bghtdkbufbmhlw3r@quack3>
 <cf125f2c-d2f0-57f8-ee6f-9a93b9f5828d@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf125f2c-d2f0-57f8-ee6f-9a93b9f5828d@huaweicloud.com>
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Mon 29-04-24 20:09:46, Zhang Yi wrote:
> On 2024/4/29 17:16, Jan Kara wrote:
> > On Wed 10-04-24 11:41:59, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> Rename ext4_es_insert_delayed_block() to ext4_es_insert_delayed_extent()
> >> and pass length parameter to make it insert multi delalloc blocks once a
> >> time. For the case of bigalloc, expand the allocated parameter to
> >> lclu_allocated and end_allocated. lclu_allocated indicates the allocate
> >> state of the cluster which containing the lblk, end_allocated represents
> >> the end, and the middle clusters must be unallocated.
> >>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
...
> >> @@ -2112,13 +2124,22 @@ void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
> >>  		es2 = NULL;
> >>  	}
> >>  
> >> -	if (allocated) {
> >> -		err3 = __insert_pending(inode, lblk, &pr);
> >> +	if (lclu_allocated) {
> >> +		err3 = __insert_pending(inode, lblk, &pr1);
> >>  		if (err3 != 0)
> >>  			goto error;
> >> -		if (pr) {
> >> -			__free_pending(pr);
> >> -			pr = NULL;
> >> +		if (pr1) {
> >> +			__free_pending(pr1);
> >> +			pr1 = NULL;
> >> +		}
> >> +	}
> >> +	if (end_allocated) {
> > 
> > So there's one unclear thing here: What if 'lblk' and 'end' are in the same
> > cluster? We don't want two pending reservation structures for the cluster.
> > __insert_pending() already handles this gracefully but perhaps we don't
> > need to allocate 'pr2' in that case and call __insert_pending() at all? I
> > think it could be easily handled by something like:
> > 
> > 	if (EXT4_B2C(lblk) == EXT4_B2C(end))
> > 		end_allocated = false;
> > 
> > at appropriate place in ext4_es_insert_delayed_extent().
> > 
> 
> I've done the check "EXT4_B2C(lblk) == EXT4_B2C(end)" in the caller
> ext4_insert_delayed_blocks() in patch 8, becasue there is no need to check
> the allocation state if they are in the same cluster, so it could make sure
> that end_allocated is always false when 'lblk' and 'end' are in the same
> cluster. So I suppose check and set it here again maybe redundant, how about
> add a wanging here in ext4_es_insert_delayed_extent(), like:
> 
> 	WARN_ON_ONCE((EXT4_B2C(sbi, lblk) == EXT4_B2C(sbi, end)) &&
> 		     end_allocated);
> 
> and modify the 'lclu_allocated/end_allocated' parameter comments, note that
> end_allocated should always be set to false if the extent is in one cluster.
> Is it fine?

Yes, that is a good solution as well!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

