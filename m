Return-Path: <linux-fsdevel+bounces-7087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B03821B9C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 13:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7A8281400
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 12:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99D5F4F7;
	Tue,  2 Jan 2024 12:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DuwZbI3c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WXBC4wHn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DuwZbI3c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WXBC4wHn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6A1EED9;
	Tue,  2 Jan 2024 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B870721DD1;
	Tue,  2 Jan 2024 12:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704198518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WPWVB7Cf3yZ7BOAMwOoyFYC7qFfhnos/F5avdLiFXqQ=;
	b=DuwZbI3czPHGl/zI9EZ2OQKPhCYM/Jhx8tLP4lfwoGy1g/gR4p0lDBXI0fBnjtJaM4ORzz
	sXNqzCsPZDgxobykJgcQDWFF6wv1oNTuYwKykTlczRtnxvc0tX36PA5acbb7javPyaomY4
	Duy64tBAjl8s5kRslmZRGhstBGiaPNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704198518;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WPWVB7Cf3yZ7BOAMwOoyFYC7qFfhnos/F5avdLiFXqQ=;
	b=WXBC4wHn9+GV0tf/81mFj/oCszjyoYebaCnyvjwsgYrMXHHjkOXYXGNAl4Nsica847Lh9K
	xEzifbpQCYAgXzAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704198518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WPWVB7Cf3yZ7BOAMwOoyFYC7qFfhnos/F5avdLiFXqQ=;
	b=DuwZbI3czPHGl/zI9EZ2OQKPhCYM/Jhx8tLP4lfwoGy1g/gR4p0lDBXI0fBnjtJaM4ORzz
	sXNqzCsPZDgxobykJgcQDWFF6wv1oNTuYwKykTlczRtnxvc0tX36PA5acbb7javPyaomY4
	Duy64tBAjl8s5kRslmZRGhstBGiaPNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704198518;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WPWVB7Cf3yZ7BOAMwOoyFYC7qFfhnos/F5avdLiFXqQ=;
	b=WXBC4wHn9+GV0tf/81mFj/oCszjyoYebaCnyvjwsgYrMXHHjkOXYXGNAl4Nsica847Lh9K
	xEzifbpQCYAgXzAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD4491340C;
	Tue,  2 Jan 2024 12:28:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I79IKnYBlGVcQAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 02 Jan 2024 12:28:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 50F6DA07EF; Tue,  2 Jan 2024 13:28:30 +0100 (CET)
Date: Tue, 2 Jan 2024 13:28:30 +0100
From: Jan Kara <jack@suse.cz>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH -next] fs: fix __sb_write_started() kerneldoc formatting
Message-ID: <20240102122830.ksqym46ym2yjheyq@quack3>
References: <20231228100608.3123987-1-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228100608.3123987-1-vegard.nossum@oracle.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.31 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:106:10:150:64:167:received];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[42.87%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,gmail.com,toxicpanda.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DuwZbI3c;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WXBC4wHn
X-Spam-Score: -1.31
X-Rspamd-Queue-Id: B870721DD1

On Thu 28-12-23 11:06:08, Vegard Nossum wrote:
> When running 'make htmldocs', I see the following warning:
> 
>   Documentation/filesystems/api-summary:14: ./include/linux/fs.h:1659: WARNING: Definition list ends without a blank line; unexpected unindent.
> 
> The official guidance [1] seems to be to use lists, which will prevent
> both the "unexpected unindent" warning as well as ensure that each line
> is formatted on a separate line in the HTML output instead of being
> all considered a single paragraph.
> 
> [1]: https://docs.kernel.org/doc-guide/kernel-doc.html#return-values
> 
> Fixes: 8802e580ee64 ("fs: create __sb_write_started() helper")
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>

Thanks! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Applies to git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.rw
> 
>  include/linux/fs.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index db5d07e6e02e..473063f385e5 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1650,9 +1650,9 @@ static inline bool __sb_start_write_trylock(struct super_block *sb, int level)
>   * @sb: the super we write to
>   * @level: the freeze level
>   *
> - * > 0 sb freeze level is held
> - *   0 sb freeze level is not held
> - * < 0 !CONFIG_LOCKDEP/LOCK_STATE_UNKNOWN
> + * * > 0 - sb freeze level is held
> + * *   0 - sb freeze level is not held
> + * * < 0 - !CONFIG_LOCKDEP/LOCK_STATE_UNKNOWN
>   */
>  static inline int __sb_write_started(const struct super_block *sb, int level)
>  {
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

