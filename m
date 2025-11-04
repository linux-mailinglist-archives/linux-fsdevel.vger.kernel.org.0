Return-Path: <linux-fsdevel+bounces-66944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB22C30FFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 13:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45EE04EE4E2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 12:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F4D2F2600;
	Tue,  4 Nov 2025 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A2ti3fni";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rCHgtdYp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A2ti3fni";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rCHgtdYp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4034E2E9EA0
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762259546; cv=none; b=b+hckXn+d4omQILWVRKRuPDUs4ujHJPzNNbaU7GJg53LM29Dg7kaZneaNGGTW9qnnQ18DvSYcolYkZd1Jy0Bg5KRzfVt5xRAFDYafPHXXtunB1pv5xa6QwIrUvoQQmYMPY22UXpfI/+7fAPRWdZJJcGRzO1LSy63APFojeeZA1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762259546; c=relaxed/simple;
	bh=jR40zXS3oYV+Me8EfflpqgH2QsEbojoKg/+VEaKw1XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyorUZII/p8oktKamHu9EsvPIxT4kXT4AeKv0oQ9zWwfKUMbK8lgcgImeNrSSc7+nvBZAvhOpb0bVgm6ro3ctw1OWAwiqJdF/wGAALAhXaoQa5wIwx4fSQDrJ5M1NiIO1VNNEoxF9LIPUon7jb2yFvRe58ar0Rf8/8cm7VZIU+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A2ti3fni; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rCHgtdYp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A2ti3fni; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rCHgtdYp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 82E201F453;
	Tue,  4 Nov 2025 12:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762259542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QqobgCjn0Kw02cLfr2hbb0dsnNDNqPqZbl/VaSFUJ7c=;
	b=A2ti3fniWXclMPlDVbaH0q7gGvzgjRxeLuwU4lgB8nXcALkqzcM6QLNxgG3Rj5f4Gj5J+f
	KmvHiufUXK0mkO+SiVvhxxGyH6gt50IXUOsIA4FyoZEBbboyLu34HX4j3cHM45wEULaY5i
	Ay+ECZ7R/FaNByLwluLVhxTuWvcMyhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762259542;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QqobgCjn0Kw02cLfr2hbb0dsnNDNqPqZbl/VaSFUJ7c=;
	b=rCHgtdYpmmZttwO9fhvUbqWu4DPKvyu6EeSvJzaX4V/JVhObOq1E6hTteaST4BSz6bL9OP
	+LcIAH11VxNcfJBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762259542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QqobgCjn0Kw02cLfr2hbb0dsnNDNqPqZbl/VaSFUJ7c=;
	b=A2ti3fniWXclMPlDVbaH0q7gGvzgjRxeLuwU4lgB8nXcALkqzcM6QLNxgG3Rj5f4Gj5J+f
	KmvHiufUXK0mkO+SiVvhxxGyH6gt50IXUOsIA4FyoZEBbboyLu34HX4j3cHM45wEULaY5i
	Ay+ECZ7R/FaNByLwluLVhxTuWvcMyhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762259542;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QqobgCjn0Kw02cLfr2hbb0dsnNDNqPqZbl/VaSFUJ7c=;
	b=rCHgtdYpmmZttwO9fhvUbqWu4DPKvyu6EeSvJzaX4V/JVhObOq1E6hTteaST4BSz6bL9OP
	+LcIAH11VxNcfJBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78892136D1;
	Tue,  4 Nov 2025 12:32:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eAVrHVbyCWnhVQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 04 Nov 2025 12:32:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 41446A28E6; Tue,  4 Nov 2025 13:32:22 +0100 (CET)
Date: Tue, 4 Nov 2025 13:32:22 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH RFC 5/8] ext4: use super write guard in write_mmp_block()
Message-ID: <lc6hg6trbptznsbxmx3b4ayzz3v5wfs6dqntjz54ujap6j6crk@q7iq4gojfnnx>
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
 <20251104-work-guards-v1-5-5108ac78a171@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104-work-guards-v1-5-5108ac78a171@kernel.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Tue 04-11-25 13:12:34, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mmp.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> index ab1ff51302fb..6f57c181ff77 100644
> --- a/fs/ext4/mmp.c
> +++ b/fs/ext4/mmp.c
> @@ -57,16 +57,12 @@ static int write_mmp_block_thawed(struct super_block *sb,
>  
>  static int write_mmp_block(struct super_block *sb, struct buffer_head *bh)
>  {
> -	int err;
> -
>  	/*
>  	 * We protect against freezing so that we don't create dirty buffers
>  	 * on frozen filesystem.
>  	 */
> -	sb_start_write(sb);
> -	err = write_mmp_block_thawed(sb, bh);
> -	sb_end_write(sb);
> -	return err;
> +	scoped_guard(super_write, sb)
> +		return write_mmp_block_thawed(sb, bh);
>  }
>  
>  /*
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

