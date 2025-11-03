Return-Path: <linux-fsdevel+bounces-66715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28919C2A7F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 09:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43CB74F2432
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 08:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8196B2D838A;
	Mon,  3 Nov 2025 08:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IWvYky2k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HHHt24oT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IWvYky2k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HHHt24oT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FF62D7DEA
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 08:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762157157; cv=none; b=PsP4M5rduDlEKFsgGVD/YnbsiAoPsRyvy7XWTmlJ0NHu8SNGqJ8KJu16RdQfFLlKcf5mtUaEp8G0nsHUiUZdxNS7mCJvNg4g5H9nmlh5KTPBBlyezG18++By4+T4hXvv/OT4A6ID1feDpyo3jAEF1cwCmx2rfCBarfPdU/nqvfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762157157; c=relaxed/simple;
	bh=CYrRxmOpeFjXfHFVdQUrcZhG1Jb558XICy8oLDImpCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ik8g0qckU92M7pSeDCtN2B7yCxt1RXCkBdRYQ8/zOJjJL1Wqqx7z1xxqe7cxRoFSwmuF2uRR0UQvfZMoJK8XTBGLHB8HXmA9oBLxf33Na6Wo94fX8oeLSxeyQuuTzNUmg9y5QT4xdiAROKY2l0UXI1On5+0ZK0JL1AZFDF6P8GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IWvYky2k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HHHt24oT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IWvYky2k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HHHt24oT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5560221DC9;
	Mon,  3 Nov 2025 08:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762157154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1kCzcdMMVzQByO/M/ivTSIZeuG0QmSvpmFe9MpD4DCo=;
	b=IWvYky2kLUkMEsXXhqEKF5kEsYt1OyCo3AsbPk5xM3+rhuPs+1bb4mYbgWUYcG3N43mGZa
	F0mFRI89ho3xGrqd24PIv1xvM3Jope4EaqLzxRW7KjOev81xUkkfjZeAaKbCey4xDf/G8j
	0rh70YVcw1jC0x/qEgaF/Yk96lAvq7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762157154;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1kCzcdMMVzQByO/M/ivTSIZeuG0QmSvpmFe9MpD4DCo=;
	b=HHHt24oTqGd+KxfECCrzRHNwBpak63P6fATQzb6nA0+iGsJnZtHL87gBSXK/MPM4dhsZE+
	xoq6WcIz1MKBkMDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762157154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1kCzcdMMVzQByO/M/ivTSIZeuG0QmSvpmFe9MpD4DCo=;
	b=IWvYky2kLUkMEsXXhqEKF5kEsYt1OyCo3AsbPk5xM3+rhuPs+1bb4mYbgWUYcG3N43mGZa
	F0mFRI89ho3xGrqd24PIv1xvM3Jope4EaqLzxRW7KjOev81xUkkfjZeAaKbCey4xDf/G8j
	0rh70YVcw1jC0x/qEgaF/Yk96lAvq7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762157154;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1kCzcdMMVzQByO/M/ivTSIZeuG0QmSvpmFe9MpD4DCo=;
	b=HHHt24oTqGd+KxfECCrzRHNwBpak63P6fATQzb6nA0+iGsJnZtHL87gBSXK/MPM4dhsZE+
	xoq6WcIz1MKBkMDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A16F1364F;
	Mon,  3 Nov 2025 08:05:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H9VxAmJiCGlFWQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Nov 2025 08:05:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 22C5AA2A61; Mon,  3 Nov 2025 09:05:49 +0100 (CET)
Date: Mon, 3 Nov 2025 09:05:49 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com, 
	libaokun1@huawei.com
Subject: Re: [PATCH 04/25] ext4: make ext4_punch_hole() support large block
 size
Message-ID: <v55t7ujgvjf2wfrlbyiva4zuu6xv5pjl7lac5ykgzvgrgluipc@moyoiqdnyinl>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-5-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025032221.2905818-5-libaokun@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-0.30 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,huawei.com:email,suse.com:email,huaweicloud.com:email]
X-Spam-Flag: NO
X-Spam-Score: -0.30

On Sat 25-10-25 11:22:00, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Since the block size may be greater than the page size, when a hole
> extends beyond i_size, we need to align the hole's end upwards to the
> larger of PAGE_SIZE and blocksize.
> 
> This is to prevent the issues seen in commit 2be4751b21ae ("ext4: fix
> 2nd xfstests 127 punch hole failure") from reappearing after BS > PS
> is supported.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

When going for bs > ps support, I'm very suspicious of any code that keeps
using PAGE_SIZE because it doesn't make too much sense anymore. Usually that
should be either appropriate folio size or something like that. For example
in this case if we indeed rely on freeing some buffers then with 4k block
size in an order-2 folio things would be already broken.

As far as I'm checking truncate_inode_pages_range() already handles partial
folio invalidation fine so I think we should just use blocksize in the
rounding (to save pointless tail block zeroing) and be done with it.

> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 4c04af7e51c9..a63513a3db53 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4401,7 +4401,8 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  	 * the page that contains i_size.
>  	 */
>  	if (end > inode->i_size)

BTW I think here we should have >= (not your fault but we can fix it when
changing the code).

> -		end = round_up(inode->i_size, PAGE_SIZE);
> +		end = round_up(inode->i_size,
> +			       umax(PAGE_SIZE, sb->s_blocksize));
>  	if (end > max_end)
>  		end = max_end;
>  	length = end - offset;

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

