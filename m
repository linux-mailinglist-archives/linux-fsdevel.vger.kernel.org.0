Return-Path: <linux-fsdevel+bounces-5692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501C380EE87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 15:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15EB3281635
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 14:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943D37317D;
	Tue, 12 Dec 2023 14:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y2pJuW65";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7hAEYWCD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wILLT6vG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qQ8NVrHW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4A3AC
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 06:19:41 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 34D1F1FB45;
	Tue, 12 Dec 2023 14:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702390779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sk2i51cRP8zX9dgR4WiL6mJsq1dozI9SBYrgO+GEeAE=;
	b=Y2pJuW65mgBBfS9gILKDpevU6cSkoMLfGgkDhFSy6CnC1SNXNz/AgxIDiXf6OZ7Vk0Ft/Q
	tYRrz22sZ2/uTc1WDDHBTMWlE0OkzRd+3M2V+roMb7tUm28ZcOJVdl9ov6rJaSrTS+ixoM
	o4fQr4GcbxsH1alkVnNa3qVnHstCn74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702390779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sk2i51cRP8zX9dgR4WiL6mJsq1dozI9SBYrgO+GEeAE=;
	b=7hAEYWCD3CfhsGoSWTV+dhEkdVritOEIT5Hd75mNiuYxhF7is+MI4AQQzoM1+I2CWEXQjt
	trMt+WD57CedB+AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702390778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sk2i51cRP8zX9dgR4WiL6mJsq1dozI9SBYrgO+GEeAE=;
	b=wILLT6vGghABd7DGkO9ZCZZHFCU+C8vDSh3dOSJFntiUKryBt5FeeudvRxn+vtIcdKwTxf
	zsS52LB3hG4EhbNBLj9mRiUllL5EVN+GKAX+KoDZhwj/0938+67ZIinYaIxhhzP+UZnzxP
	ZsQHWdfbkhE5ZgelCzB9WWBGXm5mpyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702390778;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sk2i51cRP8zX9dgR4WiL6mJsq1dozI9SBYrgO+GEeAE=;
	b=qQ8NVrHWJxjOO8ggC/yUzuThKBIwTABOQbFpAABRllb6X/qpt1hhjKJggMtk3zVzZF0AWc
	kWHOdOUzEdCHKJBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CB56139E9;
	Tue, 12 Dec 2023 14:19:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id nOe2BvpreGW1UAAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 12 Dec 2023 14:19:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 95158A06E5; Tue, 12 Dec 2023 15:19:37 +0100 (CET)
Date: Tue, 12 Dec 2023 15:19:37 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] splice: return type ssize_t from all helpers
Message-ID: <20231212141937.f4ihbex46ndhu3nt@quack3>
References: <20231212094440.250945-1-amir73il@gmail.com>
 <20231212094440.250945-2-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212094440.250945-2-amir73il@gmail.com>
X-Spam-Score: -2.16
X-Spamd-Bar: ++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wILLT6vG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qQ8NVrHW;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [2.33 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 NEURAL_HAM_SHORT(-0.20)[-0.982];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-2.49)[97.71%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(1.20)[suse.cz];
	 NEURAL_HAM_LONG(-0.97)[-0.968];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 2.33
X-Rspamd-Queue-Id: 34D1F1FB45
X-Spam-Flag: NO

On Tue 12-12-23 11:44:36, Amir Goldstein wrote:
> Not sure why some splice helpers return long, maybe historic reasons.
> Change them all to return ssize_t to conform to the splice methods and
> to the rest of the helpers.
> 
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Link: https://lore.kernel.org/r/20231208-horchen-helium-d3ec1535ede5@brauner/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good to me. Just one nit below. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> diff --git a/fs/splice.c b/fs/splice.c
> index 7cda013e5a1e..13030ce192d9 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -201,7 +201,7 @@ ssize_t splice_to_pipe(struct pipe_inode_info *pipe,
>  	unsigned int tail = pipe->tail;
>  	unsigned int head = pipe->head;
>  	unsigned int mask = pipe->ring_size - 1;
> -	int ret = 0, page_nr = 0;
> +	ssize_t ret = 0, page_nr = 0;

A nit but page_nr should stay to be 'int'.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

