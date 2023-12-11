Return-Path: <linux-fsdevel+bounces-5497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC17E80CE87
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 15:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A057D1F2167B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 14:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7138F495C1;
	Mon, 11 Dec 2023 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cLokO5OB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Thd4ID/s";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cLokO5OB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Thd4ID/s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33D7B4
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 06:39:29 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 216572236B;
	Mon, 11 Dec 2023 14:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702305568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SK1bDTp6xG+vsLp/vxUhQPqSVgdvyoW7l9PasATyzzM=;
	b=cLokO5OBedR4wDTfU13jFOFy1S6SWvsf5WyLgEh81BV7IyrAsw70dvqJDF1FdMCiYaK2Mp
	uv9i95eZEHNALam+rOcyl4BCKWteJk5fniZnKwkAXKSmfh9H7fnrodvb25q+FUbaUYvTOD
	fF9LAGscqEUyMERJ0nKxpb87b7y++qM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702305568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SK1bDTp6xG+vsLp/vxUhQPqSVgdvyoW7l9PasATyzzM=;
	b=Thd4ID/stwOYG/CoMAGD23uwxp3G81VsOOQ7fnK/pU82huyK49xA47Jgcil8TZcMZXLLct
	g1YkzjADuGNuCmDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702305568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SK1bDTp6xG+vsLp/vxUhQPqSVgdvyoW7l9PasATyzzM=;
	b=cLokO5OBedR4wDTfU13jFOFy1S6SWvsf5WyLgEh81BV7IyrAsw70dvqJDF1FdMCiYaK2Mp
	uv9i95eZEHNALam+rOcyl4BCKWteJk5fniZnKwkAXKSmfh9H7fnrodvb25q+FUbaUYvTOD
	fF9LAGscqEUyMERJ0nKxpb87b7y++qM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702305568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SK1bDTp6xG+vsLp/vxUhQPqSVgdvyoW7l9PasATyzzM=;
	b=Thd4ID/stwOYG/CoMAGD23uwxp3G81VsOOQ7fnK/pU82huyK49xA47Jgcil8TZcMZXLLct
	g1YkzjADuGNuCmDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 081F1138FF;
	Mon, 11 Dec 2023 14:39:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 0fWzASAfd2V3awAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 11 Dec 2023 14:39:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 39EF1A07E3; Mon, 11 Dec 2023 15:39:23 +0100 (CET)
Date: Mon, 11 Dec 2023 15:39:23 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] splice: return type ssize_t from all helpers
Message-ID: <20231211143923.fviipywixaqm2es4@quack3>
References: <20231210141901.47092-1-amir73il@gmail.com>
 <20231210141901.47092-2-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231210141901.47092-2-amir73il@gmail.com>
X-Spam-Level: 
X-Spam-Score: -0.81
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.83
X-Spamd-Result: default: False [-0.83 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.03)[55.12%]
X-Spam-Flag: NO

On Sun 10-12-23 16:18:57, Amir Goldstein wrote:
> Not sure why some splice helpers return long, maybe historic reasons.
> Change them all to return ssize_t to conform to the splice methods and
> to the rest of the helpers.
> 
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Link: https://lore.kernel.org/r/20231208-horchen-helium-d3ec1535ede5@brauner/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

> @@ -955,9 +955,9 @@ static void do_splice_eof(struct splice_desc *sd)
>   * Callers already called rw_verify_area() on the entire range.
>   * No need to call it for sub ranges.
>   */
> -static long do_splice_read(struct file *in, loff_t *ppos,
> -			   struct pipe_inode_info *pipe, size_t len,
> -			   unsigned int flags)
> +static size_t do_splice_read(struct file *in, loff_t *ppos,
          ^^^ ssize_t here?

> +			     struct pipe_inode_info *pipe, size_t len,
> +			     unsigned int flags)
>  {
>  	unsigned int p_space;
>  
> @@ -1030,7 +1030,7 @@ ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
>  			       splice_direct_actor *actor)
>  {
>  	struct pipe_inode_info *pipe;
> -	long ret, bytes;
> +	size_t ret, bytes;
        ^^^^ ssize_t here?

>  	size_t len;
>  	int i, flags, more;
>  
...
> @@ -1962,7 +1962,7 @@ static int link_pipe(struct pipe_inode_info *ipipe,
>   * The 'flags' used are the SPLICE_F_* variants, currently the only
>   * applicable one is SPLICE_F_NONBLOCK.
>   */

Actually link_pipe() should also return ssize_t instead of int, shouldn't
it?

> -long do_tee(struct file *in, struct file *out, size_t len, unsigned int flags)
> +ssize_t do_tee(struct file *in, struct file *out, size_t len, unsigned int flags)
>  {
>  	struct pipe_inode_info *ipipe = get_pipe_info(in, true);
>  	struct pipe_inode_info *opipe = get_pipe_info(out, true);

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

