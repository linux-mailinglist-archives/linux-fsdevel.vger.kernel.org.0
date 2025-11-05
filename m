Return-Path: <linux-fsdevel+bounces-67100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA81C35560
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 12:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 368AA463740
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 11:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435403101A3;
	Wed,  5 Nov 2025 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1/nIRGNY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RxIYoaHQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EbT/iZfs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RVBBc9Tk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C697230DEDD
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 11:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341578; cv=none; b=qKM7zI1iIa2jkbq2Rm8Ian30L2NynKJo2w7K4qHHNkhLk+e438BDCL3ihA/95qLBvrLVSgwLkKVCQT5nRpjdiLcPzQPOMgdZT92kX1FvSnvT8aCzAgVGGTkCSalXWBWLcCF9Z0EOpeGNDe4FJZK1DAfPsRtlh8HrZZdHyM3LRSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341578; c=relaxed/simple;
	bh=/+ieWd367TTzMNcV+a1nG4cly/h8PssslGda10UnRfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKJ05VhdDhg8tStkBmwLoEFEH6zsBJ41m6+SJtD/fJbpsixhX3abGz3FphXdSfhIVAzWOGE+9aMCYOsW0Ohe+zlr5gzOGmIz2ww+3caTPJ8Zz+x8gN7I+OvID0vjIio2ZLyOrweRNxbkeulexOAQdnrl1B+sqnFEDNnZgJ339ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1/nIRGNY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RxIYoaHQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EbT/iZfs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RVBBc9Tk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E15FB1F44F;
	Wed,  5 Nov 2025 11:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762341574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3f2MJsRklEzpP+H/oicIRM4OZQTSQqFIr+xOpS0MieI=;
	b=1/nIRGNYgfxOBr72U6LdwDqyC7AGEztPesxlz81JfZcyFZGrRI4Z7InD6+j6O1cIwbT0VD
	0mffTH5X7plqnEvF4zFXLn1ceEE6JvFyB7eNEO3Hxe6VeeEjerQ03M2K1Ec4pLcrBYwjAy
	rjh9tK3gNF9ie98TYl1I1FVoV9mbe0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762341574;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3f2MJsRklEzpP+H/oicIRM4OZQTSQqFIr+xOpS0MieI=;
	b=RxIYoaHQSlucz2JqJTmBN5rXvisD+ND5bNIrc9MyKnZEI3XE92TgtNuATZl7xf0A0SmO3Q
	UrGdizsSUXq5g8CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762341572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3f2MJsRklEzpP+H/oicIRM4OZQTSQqFIr+xOpS0MieI=;
	b=EbT/iZfst4n31g2kJaXMD1Pw/oL2g6EG8QoeHuftOuyCHMAxxd2O3nvEZgrbQyE9z/UqXq
	N5N+De9RcI/X4En9kPgX1KbGro1chBIWE60D3LU6Eb1uFaG66shDVAU1ELnwW1xSB0Gd0n
	xhVJdy1LL1wvGOo6G/Lf/5XuaJc+C7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762341572;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3f2MJsRklEzpP+H/oicIRM4OZQTSQqFIr+xOpS0MieI=;
	b=RVBBc9TkjL88FOl9P7+EA9mAbLil8ayuR8Mdw8bEfqigz1EL3l+EMlKyweraKHEfFpeJL0
	B1Eay/nwaz7m67CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5E97132DD;
	Wed,  5 Nov 2025 11:19:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J3szNMQyC2n7CwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Nov 2025 11:19:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9A79EA28C2; Wed,  5 Nov 2025 12:19:32 +0100 (CET)
Date: Wed, 5 Nov 2025 12:19:32 +0100
From: Jan Kara <jack@suse.cz>
To: sunyongjian1@huawei.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	tytso@mit.edu, jack@suse.cz, yangerkun@huawei.com, yi.zhang@huawei.com, 
	libaokun1@huawei.com, chengzhihao1@huawei.com
Subject: Re: [PATCH 1/2] ext4: fix incorrect group number assertion in
 mb_check_buddy for exhausted preallocations
Message-ID: <v2ih4phv2qncxqstanziraevrru6i4bg7gbwdgu5poqke323tt@rj2mqgiiaxn3>
References: <20251105074250.3517687-1-sunyongjian@huaweicloud.com>
 <20251105074250.3517687-2-sunyongjian@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105074250.3517687-2-sunyongjian@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,huawei.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Wed 05-11-25 15:42:49, Yongjian Sun wrote:
> From: Yongjian Sun <sunyongjian1@huawei.com>
> 
> When the MB_CHECK_ASSERT macro is enabled, an assertion failure can
> occur in __mb_check_buddy when checking preallocated blocks (pa) in
> a block group:
> 
> Assertion failure in mb_free_blocks() : "groupnr == e4b->bd_group"
> 
> This happens when a pa at the very end of a block group (e.g.,
> pa_pstart=32765, pa_len=3 in a group of 32768 blocks) becomes
> exhausted - its pa_pstart is advanced by pa_len to 32768, which
> lies in the next block group. If this exhausted pa (with pa_len == 0)
> is still in the bb_prealloc_list during the buddy check, the assertion
> incorrectly flags it as belonging to the wrong group. A possible
> sequence is as follows:
> 
> ext4_mb_new_blocks
>   ext4_mb_release_context
>     pa->pa_pstart += EXT4_C2B(sbi, ac->ac_b_ex.fe_len)
>     pa->pa_len -= ac->ac_b_ex.fe_len
> 
> 	                 __mb_check_buddy
>                            for each pa in group
>                              ext4_get_group_no_and_offset
>                              MB_CHECK_ASSERT(groupnr == e4b->bd_group)
> 
> To fix this, we modify the check to skip block group validation for
> exhausted preallocations (where pa_len == 0). Such entries are in a
> transitional state and will be removed from the list soon, so they
> should not trigger an assertion. This change prevents the false
> positive while maintaining the integrity of the checks for active
> allocations.
> 
> Fixes: c9de560ded61f ("ext4: Add multi block allocator for ext4")
> Signed-off-by: Yongjian Sun <sunyongjian1@huawei.com>
> Reviewed-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 9087183602e4..194a9f995c36 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -768,6 +768,8 @@ static void __mb_check_buddy(struct ext4_buddy *e4b, char *file,
>  		ext4_group_t groupnr;
>  		struct ext4_prealloc_space *pa;
>  		pa = list_entry(cur, struct ext4_prealloc_space, pa_group_list);
> +		if (!pa->pa_len)
> +			continue;
>  		ext4_get_group_no_and_offset(sb, pa->pa_pstart, &groupnr, &k);
>  		MB_CHECK_ASSERT(groupnr == e4b->bd_group);
>  		for (i = 0; i < pa->pa_len; i++)
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

