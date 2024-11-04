Return-Path: <linux-fsdevel+bounces-33599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8670A9BB436
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 13:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4E2CB24BE5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 12:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD581B4F29;
	Mon,  4 Nov 2024 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DPzCxpt6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0rumSxfG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DPzCxpt6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0rumSxfG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0EA7C0BE;
	Mon,  4 Nov 2024 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730721979; cv=none; b=b2JJnuGg7PnwJCe0DVn7TkE2DI7Fuo30FUBEuklSou13Som2qnrzW+IvzhOTTeFTlvnz248Sk4h4YLVvT98qlsxETS7OFNuTzdNiHxMwSQN2ULT02WDAowlEbunPvU9WezFrudaAzeqtm8xggtMBD62st0b+M5u3ZHM5aMiyFC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730721979; c=relaxed/simple;
	bh=OCrSyLf9iXe0GZqTjsaGD1M8IGiZ8HqKoGI9OnH/vEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCUDKq5JL7tbG1J3vPNSklGe6+YZrFybrWP1rylukXOiOyrbyIkptdcatYJgzFatXzl+rsR8M20ViLlvetiE7RjnOWccxUcTHBrUwFHCCN0RjqDkYuque6u0evDb0iKLUNa9l+WObgVTDkpelXGGu2TH5aroE/ugUHQLtjHXgow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DPzCxpt6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0rumSxfG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DPzCxpt6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0rumSxfG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3A8FA21F47;
	Mon,  4 Nov 2024 12:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730721976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9fndFLhjzKyaOYEc14yr2sB6eNr80QRQIjaNtzCLkw0=;
	b=DPzCxpt6Xihrcls88xqVfgiNLWqvYrIQHPa9O1oyRWD5ZdDCVrl1/wr8/DrFs61hPJ7rbX
	BAs9bqQ/HONfnG9QbRtoW2+037M0sma8rLi4uy1e4tjT0a9CekpvexMUIKfn2z4gZZInBQ
	j06JmxYQt19kH00QfWnz3bnB6+BV+Bw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730721976;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9fndFLhjzKyaOYEc14yr2sB6eNr80QRQIjaNtzCLkw0=;
	b=0rumSxfGBDr2wbRmh/Ixr+RBMun02tPVqWFSCVBDtHoV0re88ppXAKiXmptBw0hworyL5S
	YAuE6NdRwcP5HsAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730721976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9fndFLhjzKyaOYEc14yr2sB6eNr80QRQIjaNtzCLkw0=;
	b=DPzCxpt6Xihrcls88xqVfgiNLWqvYrIQHPa9O1oyRWD5ZdDCVrl1/wr8/DrFs61hPJ7rbX
	BAs9bqQ/HONfnG9QbRtoW2+037M0sma8rLi4uy1e4tjT0a9CekpvexMUIKfn2z4gZZInBQ
	j06JmxYQt19kH00QfWnz3bnB6+BV+Bw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730721976;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9fndFLhjzKyaOYEc14yr2sB6eNr80QRQIjaNtzCLkw0=;
	b=0rumSxfGBDr2wbRmh/Ixr+RBMun02tPVqWFSCVBDtHoV0re88ppXAKiXmptBw0hworyL5S
	YAuE6NdRwcP5HsAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E7D51373E;
	Mon,  4 Nov 2024 12:06:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lOhSC7i4KGewUAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 04 Nov 2024 12:06:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CDB4FA0AFB; Mon,  4 Nov 2024 13:06:15 +0100 (CET)
Date: Mon, 4 Nov 2024 13:06:15 +0100
From: Jan Kara <jack@suse.cz>
To: Daniel Yang <danielyangkang@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com
Subject: Re: [PATCH] fix: general protection fault in iter_file_splice_write
Message-ID: <20241104120615.ggsn7g2gblw73c5l@quack3>
References: <20241104084240.301877-1-danielyangkang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104084240.301877-1-danielyangkang@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[d2125fcb6aa8c4276fd2];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Mon 04-11-24 00:42:39, Daniel Yang wrote:
> The function iter_file_splice_write() calls pipe_buf_release() which has
> a nullptr dereference in ops->release. Add check for buf->ops not null
> before calling pipe_buf_release().
> 
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> Reported-by: syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d2125fcb6aa8c4276fd2
> Fixes: 2df86547b23d ("netfs: Cut over to using new writeback code")
> ---
>  fs/splice.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/splice.c b/fs/splice.c
> index 06232d7e5..b8c503e47 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -756,7 +756,8 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
>  			if (ret >= buf->len) {
>  				ret -= buf->len;
>  				buf->len = 0;
> -				pipe_buf_release(pipe, buf);
> +				if (buf->ops)
> +					pipe_buf_release(pipe, buf);

Umm, already released pipe buf? How would it get here? We have filled the
buffers shortly before so IMHO it indicates some deeper problem. Can you
please explain a bit more?

								Honza


>  				tail++;
>  				pipe->tail = tail;
>  				if (pipe->files)
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

