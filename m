Return-Path: <linux-fsdevel+bounces-36257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EDC9E0248
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 13:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91BDE168F9A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 12:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360281FECAC;
	Mon,  2 Dec 2024 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SIrplq34";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rl3GeRAh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SIrplq34";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rl3GeRAh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE42D1FC7FB;
	Mon,  2 Dec 2024 12:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733142811; cv=none; b=haVX8+HL8l9Zch+l3/CvQlVztXuayO4wxBSt6si1qQ+QwjrD1oU0JIJMRgOq0zOuX8nZDwUhiHfnhDxI/za4XgR5TRex/1SDLrxbHKIM1Q5mWhrpshC6NecjvVtw4bKGcuwD377M/iHKFKuV78u7uVEgPa/bjKKzk0RoeHaHyXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733142811; c=relaxed/simple;
	bh=tralFyhyUdpTJrYzmhqjcZ45WyYATGZKu1XnV247IyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzmPKd1jB9NlZzZ5b2vayLHE0bFU4ioGyh7sEogVSFMUwDkEsQGYIOk/PiijoRFoJ57rmgeYpJqadpceWJp4VclfR7XTQI1A3vxmeaKtRQ3AsVYHCT2fbC55Id7ytrGq54ivbOVsMM2jLKjidPZiCzvmmRanz/xYgcxWGpsb8MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SIrplq34; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rl3GeRAh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SIrplq34; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rl3GeRAh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1E3651F444;
	Mon,  2 Dec 2024 12:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733142808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wcFiL8b3DxnsZOU7aC58mndpthSUJ03sDwAvbRdp/o0=;
	b=SIrplq34S659YsZ7eOcMt5pTFOirMk7mgbspmlTxmGbtlhPqjhunhO6J1wykImFKa7xQ9R
	QCk8h5Rb9WnagtfZZCqml8p+k/a9saqDvvB5EGH4C5BsfiGf/f7p/U006dnau79qItltH4
	rgphbIyQXxfmvDmcVUg0fWmvviaV+Ik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733142808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wcFiL8b3DxnsZOU7aC58mndpthSUJ03sDwAvbRdp/o0=;
	b=rl3GeRAhkMWC2LmL1ix2bDu2Xc5PZcxe8SAxPJZIN7kQ8KcCGkLxkOqJEfG5XxfjgB+SlA
	8qNfPV9JN3YPG2AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733142808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wcFiL8b3DxnsZOU7aC58mndpthSUJ03sDwAvbRdp/o0=;
	b=SIrplq34S659YsZ7eOcMt5pTFOirMk7mgbspmlTxmGbtlhPqjhunhO6J1wykImFKa7xQ9R
	QCk8h5Rb9WnagtfZZCqml8p+k/a9saqDvvB5EGH4C5BsfiGf/f7p/U006dnau79qItltH4
	rgphbIyQXxfmvDmcVUg0fWmvviaV+Ik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733142808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wcFiL8b3DxnsZOU7aC58mndpthSUJ03sDwAvbRdp/o0=;
	b=rl3GeRAhkMWC2LmL1ix2bDu2Xc5PZcxe8SAxPJZIN7kQ8KcCGkLxkOqJEfG5XxfjgB+SlA
	8qNfPV9JN3YPG2AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FB9713A31;
	Mon,  2 Dec 2024 12:33:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PqXLAxipTWeIdwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Dec 2024 12:33:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B9F92A07B4; Mon,  2 Dec 2024 13:33:27 +0100 (CET)
Date: Mon, 2 Dec 2024 13:33:27 +0100
From: Jan Kara <jack@suse.cz>
To: Guo Weikang <guoweikang.kernel@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs:fc_log replace magic number 7 with ARRAY_SIZE()
Message-ID: <20241202123327.3cpmzegjaoh3rgrd@quack3>
References: <20241202081146.1031780-1-guoweikang.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202081146.1031780-1-guoweikang.kernel@gmail.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 02-12-24 16:11:45, Guo Weikang wrote:
> Replace the hardcoded value `7` in `put_fc_log()` with `ARRAY_SIZE`.
> This improves maintainability by ensuring the loop adapts to changes
> in the buffer size.
> 
> Signed-off-by: Guo Weikang <guoweikang.kernel@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs_context.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fs_context.c b/fs/fs_context.c
> index 98589aae5208..582d33e81117 100644
> --- a/fs/fs_context.c
> +++ b/fs/fs_context.c
> @@ -493,7 +493,7 @@ static void put_fc_log(struct fs_context *fc)
>  	if (log) {
>  		if (refcount_dec_and_test(&log->usage)) {
>  			fc->log.log = NULL;
> -			for (i = 0; i <= 7; i++)
> +			for (i = 0; i < ARRAY_SIZE(log->buffer) ; i++)
>  				if (log->need_free & (1 << i))
>  					kfree(log->buffer[i]);
>  			kfree(log);
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

