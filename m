Return-Path: <linux-fsdevel+bounces-36348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2416E9E28BE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 18:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4706DB82381
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 14:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD1A1F7060;
	Tue,  3 Dec 2024 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d2JXT4XX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x+SEXQlw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d2JXT4XX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x+SEXQlw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F64E17BB16;
	Tue,  3 Dec 2024 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236853; cv=none; b=C8n6sTET0ob87V2AJBOekYrabHSgclgWd72eS7w8o9o1pOaNIaZOGzbZJTd42HRCsw+emhfWy1yK+Zm6jlm1FlAebQW7t9VyucbE3E5c+cGEKG731LlOKk7fDt2EFFNkYKnZ5URraHHe/PsVSohpwlvQLPcL77cgVHFRoTaok0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236853; c=relaxed/simple;
	bh=4+aGEKSrVaMPxF1C89RaFhoY0T4nLEDvKtShVRuHdHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAf/aVG4AXSX6i1lCLLP/2VYuRwnzb2O09rp42NSZiuC6ybB39IHZvPaQ9FN0Lw88f61WndXF41cxkVTeQlnEHy/hSqHy8nZd0ZeXz/v1iaskbfk3tKY1PSSG6pwOSJ/rLBojJsROkjHzVVXTrMWrId2NweuPs2QAAQoaT0nv1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d2JXT4XX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x+SEXQlw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d2JXT4XX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x+SEXQlw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C33541F451;
	Tue,  3 Dec 2024 14:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733236849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xUSjXoR43kykeHb/MWOTc71pIdCt7+UHoSOfASdQLSI=;
	b=d2JXT4XXSpoiZXeDtExHPHA4wWg/x7bRk5STHO3J7FYf+9Jxx0sCXshL0nnkCkHs3nxSz3
	n3/19n+vsyUKqQQGzzweqGUoL3owrTeLQLPjqNKA7/iYMGQj8gMYiAm1c2b6t+xS72Z9Sz
	5ZP8vyr8mTIKqlUbzwUvVc0+LShM2aY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733236849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xUSjXoR43kykeHb/MWOTc71pIdCt7+UHoSOfASdQLSI=;
	b=x+SEXQlwhxxHk9FoblSKK0dK9Ujh56jDHqnS6dt1Ya2q+bXMU2Hto6ajIKkva6ymoV+w1v
	DzgzJB+c5Tsa3hDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733236849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xUSjXoR43kykeHb/MWOTc71pIdCt7+UHoSOfASdQLSI=;
	b=d2JXT4XXSpoiZXeDtExHPHA4wWg/x7bRk5STHO3J7FYf+9Jxx0sCXshL0nnkCkHs3nxSz3
	n3/19n+vsyUKqQQGzzweqGUoL3owrTeLQLPjqNKA7/iYMGQj8gMYiAm1c2b6t+xS72Z9Sz
	5ZP8vyr8mTIKqlUbzwUvVc0+LShM2aY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733236849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xUSjXoR43kykeHb/MWOTc71pIdCt7+UHoSOfASdQLSI=;
	b=x+SEXQlwhxxHk9FoblSKK0dK9Ujh56jDHqnS6dt1Ya2q+bXMU2Hto6ajIKkva6ymoV+w1v
	DzgzJB+c5Tsa3hDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B611E139C2;
	Tue,  3 Dec 2024 14:40:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dFhrLHEYT2fYNwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Dec 2024 14:40:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 549AAA08FB; Tue,  3 Dec 2024 15:40:41 +0100 (CET)
Date: Tue, 3 Dec 2024 15:40:41 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 1/2] jbd2: increase IO priority for writing revoke records
Message-ID: <20241203144041.bygbhwhootsyyhsu@quack3>
References: <20241203014407.805916-1-yi.zhang@huaweicloud.com>
 <20241203014407.805916-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203014407.805916-2-yi.zhang@huaweicloud.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Tue 03-12-24 09:44:06, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Commit '6a3afb6ac6df ("jbd2: increase the journal IO's priority")'
> increases the priority of journal I/O by marking I/O with the
> JBD2_JOURNAL_REQ_FLAGS. However, that commit missed the revoke buffers,
> so also addresses that kind of I/Os.
> 
> Fixes: 6a3afb6ac6df ("jbd2: increase the journal IO's priority")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/revoke.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
> index 4556e4689024..ce63d5fde9c3 100644
> --- a/fs/jbd2/revoke.c
> +++ b/fs/jbd2/revoke.c
> @@ -654,7 +654,7 @@ static void flush_descriptor(journal_t *journal,
>  	set_buffer_jwrite(descriptor);
>  	BUFFER_TRACE(descriptor, "write");
>  	set_buffer_dirty(descriptor);
> -	write_dirty_buffer(descriptor, REQ_SYNC);
> +	write_dirty_buffer(descriptor, JBD2_JOURNAL_REQ_FLAGS);
>  }
>  #endif
>  
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

