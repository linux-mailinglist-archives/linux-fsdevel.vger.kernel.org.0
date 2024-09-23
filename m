Return-Path: <linux-fsdevel+bounces-29832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 515F697E790
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 10:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE0FA1F21A36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 08:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01DA193436;
	Mon, 23 Sep 2024 08:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CINSBdFV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z/k9AWx2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mIc4erIH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UlyPUC/p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B838B17C200;
	Mon, 23 Sep 2024 08:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727080290; cv=none; b=NIU4JOTLth1/+MsVyBJn26LjgYi54oE9ec5XHdlCXrdASy+MsfBJaVUYV9G+uCZZ8hzG8Jsez9cwK6XRZ/sihiImFAeKoEbBT4O2Pvq/RLdMcEOw/CECfzqKcY9J696RJcE9dAXoZUa74saQmZZJeW5kNNcf3n3aCpgkbhM2dSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727080290; c=relaxed/simple;
	bh=y04koVER5jdtM9RssDIGt07dzkNT1EZG2C6uSSWTuJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f64Gjhc8019LwG31qOjLAx0mdn1Wt2I1S3cKHif/MBglNc+jZN1VZcaRnulb8HwsUsr6ahyEbaHYZxwGYTVdg545bgFPMQToi5/OeFXk+BHtFFYbgCX92xcpHMgtyccq4xruWdOwxZ4ZbzTcp8+qWtTI5CITn9xRHzSu5wB7qXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CINSBdFV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z/k9AWx2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mIc4erIH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UlyPUC/p; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE1D321F09;
	Mon, 23 Sep 2024 08:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727080287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8oc7jvt3sPPf0SDXj1RzXgyo45zLIrZkxN+5PnWl08w=;
	b=CINSBdFVrSE0eyD4B8+o1ajmfAPOtu2WqtH2wUcnVBbVDC60qGEK7V9Y/4etp/q2xcDJ6l
	d/JfFcn3X2QHvaq92kuUBY+0m6++7F1BvuuPyMQbSkCJAPTwAmKE4husu5CqpkQ8QaCV4P
	vubbZHSYN1TWxItRnb0i6p6SzTp0q4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727080287;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8oc7jvt3sPPf0SDXj1RzXgyo45zLIrZkxN+5PnWl08w=;
	b=Z/k9AWx2sqgMajw44ebCn4kZwusYCg2s/Ca8VC3b2Qmfq+d8rasSR8b+3d9fLBqeOXE/jO
	4vsr8KfAYzGhdYBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727080286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8oc7jvt3sPPf0SDXj1RzXgyo45zLIrZkxN+5PnWl08w=;
	b=mIc4erIHMdvC4meTaS05h/TUMvvKz0dB8quKb2aAhhce6mY/3yXy+/N+xQPG3DchAmYfeK
	NZFQv5i75hgEgMlNrjjhlxNjNUNBQjj0Pl22P6TDJC/qjbH9N4iPTNd58SQMMUf6UW6Q3K
	9xHWj5gfRiUt7uZ1cZrGSzv5Y2IMVBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727080286;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8oc7jvt3sPPf0SDXj1RzXgyo45zLIrZkxN+5PnWl08w=;
	b=UlyPUC/p/L+Gh1aZg+jFA20bexIpJJ0BG3eidWnQDwSRCo1MmG39UOObBCwM60O0PlLDRX
	v0oY+TJiOv2mpEAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2B3813A64;
	Mon, 23 Sep 2024 08:31:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MNpWN14n8Wb7bwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Sep 2024 08:31:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9D84FA0ABF; Mon, 23 Sep 2024 10:31:22 +0200 (CEST)
Date: Mon, 23 Sep 2024 10:31:22 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 09/10] ext4: factor out the common checking part of
 all fallocate operations
Message-ID: <20240923083122.amqnlzxj53beqtwj@quack3>
References: <20240904062925.716856-1-yi.zhang@huaweicloud.com>
 <20240904062925.716856-10-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904062925.716856-10-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Wed 04-09-24 14:29:24, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Now the beginning of all the five functions in ext4_fallocate() (punch
> hole, zero range, insert range, collapse range and normal fallocate) are
> almost the same, they need to hold i_rwsem and check the validity of
> input parameters, so move the holding of i_rwsem to ext4_fallocate()
> and factor out a common helper to check the input parameters can make
> the code more clear.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
...
> +static int ext4_fallocate_check(struct inode *inode, int mode,
> +				loff_t offset, loff_t len)
> +{
> +	/* Currently except punch_hole, just for extent based files. */
> +	if (!(mode & FALLOC_FL_PUNCH_HOLE) &&
> +	    !ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * Insert range and collapse range works only on fs cluster size
> +	 * aligned regions.
> +	 */
> +	if (mode & (FALLOC_FL_INSERT_RANGE | FALLOC_FL_COLLAPSE_RANGE) &&
> +	    !IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(inode->i_sb)))
> +		return -EINVAL;
> +
> +	if (mode & FALLOC_FL_INSERT_RANGE) {
> +		/* Collapse range, offset must be less than i_size */
> +		if (offset >= inode->i_size)
> +			return -EINVAL;
> +		/* Check whether the maximum file size would be exceeded */
> +		if (len > inode->i_sb->s_maxbytes - inode->i_size)
> +			return -EFBIG;
> +	} else if (mode & FALLOC_FL_COLLAPSE_RANGE) {
> +		/*
> +		 * Insert range, there is no need to overlap collapse
> +		 * range with EOF, in which case it is effectively a
> +		 * truncate operation.
> +		 */
> +		if (offset + len >= inode->i_size)
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}

I don't think this helps. If the code is really shared, then the
factorization is good but here you have to do various checks what operation
we perform and in that case I don't think it really helps readability to
factor out checks into a common function.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

