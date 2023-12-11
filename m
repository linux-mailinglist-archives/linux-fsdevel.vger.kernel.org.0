Return-Path: <linux-fsdevel+bounces-5499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B8880CE9D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 15:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12E7A1F217C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 14:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9FE495D2;
	Mon, 11 Dec 2023 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pOzALweL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bkKbV/iW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SQyY9VWy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tOXVi2SH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104B4C3
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 06:45:34 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0F4B6223EE;
	Mon, 11 Dec 2023 14:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702305933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B9oOOncWM4VoPFmcwapRvr0+6D3NcdlVnul+t7scKrQ=;
	b=pOzALweLS1BYDD+FxMo5jKpZec+jkf/mJZegHtQ87VAl9If3h1iar5kP5OQeZm+PjFGEvc
	9iawozM3JqJIMk47U2MzCMCCb+05iluz0tnBJa0dLza6BEzL4z4rqH89ThWP/Yj9wXThup
	+la7oHNZMU4vfjEbK664SSk/H7g1w6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702305933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B9oOOncWM4VoPFmcwapRvr0+6D3NcdlVnul+t7scKrQ=;
	b=bkKbV/iWdL7jQorVZgYh4R3N6CD4k8WxGosJD+P0wytreShDMuzIgJAuseUNDifWPz/AX2
	Du80ehW+JYvVViDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702305932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B9oOOncWM4VoPFmcwapRvr0+6D3NcdlVnul+t7scKrQ=;
	b=SQyY9VWywMNJdHcTPmk7Z9YuIMNiGI+qUlqgtpPqua1Ai/GjvNhRMVfP3/Xf7NNetfs+ZS
	9r1JdPg5JgC4caiT4QGx44LniRtSBQGLesrfOZrrweG7plWzdGxMeWSjlLfGi41+9tfRYK
	0pRbIvq86GXPuwIrQaLzuesBBzBMVfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702305932;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B9oOOncWM4VoPFmcwapRvr0+6D3NcdlVnul+t7scKrQ=;
	b=tOXVi2SHXVJ4NS5pAUhdIvB0lq22znBf5FG5zoW7FaU0F9FtVlLC+u0KxRv6KJsdxKd9yp
	g5tJGecSBjvY9zDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EE2E5134B0;
	Mon, 11 Dec 2023 14:45:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id OTslOosgd2VNbQAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 11 Dec 2023 14:45:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4AC77A07E3; Mon, 11 Dec 2023 15:45:31 +0100 (CET)
Date: Mon, 11 Dec 2023 15:45:31 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] fs: use splice_copy_file_range() inline helper
Message-ID: <20231211144531.xthdf3iy7mcrnhjm@quack3>
References: <20231210141901.47092-1-amir73il@gmail.com>
 <20231210141901.47092-3-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231210141901.47092-3-amir73il@gmail.com>
X-Spam-Level: 
X-Spam-Score: -3.75
X-Spamd-Result: default: False [-3.65 / 50.00];
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.85)[99.37%]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.65
Authentication-Results: smtp-out1.suse.de;
	none

On Sun 10-12-23 16:18:58, Amir Goldstein wrote:
> generic_copy_file_range() is just a wrapper around splice_file_range(),
> which caps the maximum copy length.
> 
> The only caller of splice_file_range(), namely __ceph_copy_file_range()
> is already ready to cope with short copy.
> 
> Move the length capping into splice_file_range() and replace the exported
> symbol generic_copy_file_range() with a simple inline helper.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Link: https://lore.kernel.org/linux-fsdevel/20231204083849.GC32438@lst.de/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

