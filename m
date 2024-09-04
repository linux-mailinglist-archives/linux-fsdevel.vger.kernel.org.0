Return-Path: <linux-fsdevel+bounces-28536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7213E96B87C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EA841F210D7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5613E1CF7CD;
	Wed,  4 Sep 2024 10:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xjZLShX6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eeYmRmdz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xjZLShX6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eeYmRmdz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C21D3FE55;
	Wed,  4 Sep 2024 10:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445707; cv=none; b=abJzJgz35sfm9Xnhe09viKgXyfMfFvK8+fJDHHeelQGRhoqWWae5EShGa3RZ6SjWYBJyn/m2Eb9rrXX1M/T6phvNBPQQeMPabTncFiy+XZ3Ijv1cE/OSO0YBDH9B7QxeuRSJ76XSjnVQtqFVPh0VDkuwzVnv7188e60Bnq1YPHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445707; c=relaxed/simple;
	bh=umhxUpM+Zq6IHhv/x/708aecux8FbC2pcdJswZT+FP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAi8eFfXJPjw5WhqPL1v2cU9vhSB3zHmWd2d0ZEbnO3hHjtPoPM2Zlk5h2nyQ8PQIC1hdN/JnueAiXvcm7GcmkwcDSsKdjFM5H66c8LEq42S2bQo1/JnaiykN3q/tyDky29UL4Vo7II0Yv6UYnNG478oyGzu/BomFEv2BpFGRs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xjZLShX6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eeYmRmdz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xjZLShX6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eeYmRmdz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 27B9F219D2;
	Wed,  4 Sep 2024 10:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725445704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NnGA4N4BvKwpcdMqHB1IhGKFzGHeaY69yamcpuxJgF4=;
	b=xjZLShX6B6gQor0VVNG5J+x4E3OWPXYLu6U6bEzpEulb+wEOGq5WY7VYZxK/oRGitRcmKY
	mlzyqo29ObAFeno6Biqn/PDLU9UM6bFku3JbORMPv+tV+rx9TqIZ0NNArYv1S3Zhu62L4D
	h0nSGMJ/u/7SrQi7gcfqFNARL1vQdJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725445704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NnGA4N4BvKwpcdMqHB1IhGKFzGHeaY69yamcpuxJgF4=;
	b=eeYmRmdzwI4D2WtoUAFFQP8vjkS+9acYpcew7rR2NYdhxXgZY3SqM9R6fL4C01GYaDPPxY
	GOvQ+WsQBf3bhsDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725445704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NnGA4N4BvKwpcdMqHB1IhGKFzGHeaY69yamcpuxJgF4=;
	b=xjZLShX6B6gQor0VVNG5J+x4E3OWPXYLu6U6bEzpEulb+wEOGq5WY7VYZxK/oRGitRcmKY
	mlzyqo29ObAFeno6Biqn/PDLU9UM6bFku3JbORMPv+tV+rx9TqIZ0NNArYv1S3Zhu62L4D
	h0nSGMJ/u/7SrQi7gcfqFNARL1vQdJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725445704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NnGA4N4BvKwpcdMqHB1IhGKFzGHeaY69yamcpuxJgF4=;
	b=eeYmRmdzwI4D2WtoUAFFQP8vjkS+9acYpcew7rR2NYdhxXgZY3SqM9R6fL4C01GYaDPPxY
	GOvQ+WsQBf3bhsDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1ACB9139D2;
	Wed,  4 Sep 2024 10:28:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a9yJBkg22GZNKQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Sep 2024 10:28:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BA2B8A0968; Wed,  4 Sep 2024 12:28:19 +0200 (CEST)
Date: Wed, 4 Sep 2024 12:28:19 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 10/12] ext4: make extent status types exclusive
Message-ID: <20240904102819.b5ouynw6k5nj3yff@quack3>
References: <20240813123452.2824659-1-yi.zhang@huaweicloud.com>
 <20240813123452.2824659-11-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813123452.2824659-11-yi.zhang@huaweicloud.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,huawei.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 13-08-24 20:34:50, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Since we don't add delayed flag in unwritten extents, all of the four
> extent status types EXTENT_STATUS_WRITTEN, EXTENT_STATUS_UNWRITTEN,
> EXTENT_STATUS_DELAYED and EXTENT_STATUS_HOLE are exclusive now, add
> assertion when storing pblock before inserting extent into status tree
> and add comment to the status definition.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents_status.h | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
> index 3ca40f018994..7d7af642f7b2 100644
> --- a/fs/ext4/extents_status.h
> +++ b/fs/ext4/extents_status.h
> @@ -42,6 +42,10 @@ enum {
>  #define ES_SHIFT (sizeof(ext4_fsblk_t)*8 - ES_FLAGS)
>  #define ES_MASK (~((ext4_fsblk_t)0) << ES_SHIFT)
>  
> +/*
> + * Besides EXTENT_STATUS_REFERENCED, all these extent type masks
> + * are exclusive, only one type can be set at a time.
> + */
>  #define EXTENT_STATUS_WRITTEN	(1 << ES_WRITTEN_B)
>  #define EXTENT_STATUS_UNWRITTEN (1 << ES_UNWRITTEN_B)
>  #define EXTENT_STATUS_DELAYED	(1 << ES_DELAYED_B)
> @@ -51,7 +55,9 @@ enum {
>  #define ES_TYPE_MASK	((ext4_fsblk_t)(EXTENT_STATUS_WRITTEN | \
>  			  EXTENT_STATUS_UNWRITTEN | \
>  			  EXTENT_STATUS_DELAYED | \
> -			  EXTENT_STATUS_HOLE) << ES_SHIFT)
> +			  EXTENT_STATUS_HOLE))
> +
> +#define ES_TYPE_VALID(type)	((type) && !((type) & ((type) - 1)))
>  
>  struct ext4_sb_info;
>  struct ext4_extent;
> @@ -156,7 +162,7 @@ static inline unsigned int ext4_es_status(struct extent_status *es)
>  
>  static inline unsigned int ext4_es_type(struct extent_status *es)
>  {
> -	return (es->es_pblk & ES_TYPE_MASK) >> ES_SHIFT;
> +	return (es->es_pblk >> ES_SHIFT) & ES_TYPE_MASK;
>  }
>  
>  static inline int ext4_es_is_written(struct extent_status *es)
> @@ -228,6 +234,8 @@ static inline void ext4_es_store_pblock_status(struct extent_status *es,
>  					       ext4_fsblk_t pb,
>  					       unsigned int status)
>  {
> +	WARN_ON_ONCE(!ES_TYPE_VALID(status & ES_TYPE_MASK));
> +
>  	es->es_pblk = (((ext4_fsblk_t)status << ES_SHIFT) & ES_MASK) |
>  		      (pb & ~ES_MASK);
>  }
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

