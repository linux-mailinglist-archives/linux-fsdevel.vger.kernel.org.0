Return-Path: <linux-fsdevel+bounces-15297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D61C388BE7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 10:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F0BAB27C7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 09:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187056F07E;
	Tue, 26 Mar 2024 09:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X67Rp39H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8NstOqXY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X67Rp39H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8NstOqXY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3667A56757;
	Tue, 26 Mar 2024 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711446846; cv=none; b=g5oQDRf6GdJqUIAjaQLx3X72AwFEV3N8UcWs8tVX+kJHbm3CWngD5xPxqdtvXelkezFIv+D3HDtFZwVAqhIpAmmPCaDAhsBr1xRwnwBByxdnTPX+WVvNnpQdSqwRQDxDvE/89mj4/wOsuVJP/d7HiPfmV3rdrN7CudStPCFX5JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711446846; c=relaxed/simple;
	bh=EDdDtVa8zpFKLiXUwYaid9C7CijL8vV8TJ2knmO560Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uB3wguhlz+KbqGMSeOp3o8jQClnF0ciTeO7tyYxV5RnCpuzUrXkfAttybXNen5UQvYBDGmv6ilVJ+j7AOfCx0VCopklk8VKZizjs1k0izyoPiBT42+hAKmQnZExMARjgjRXntwf70dynsdSfq0Bke0VOWiqulhhaPbLdYvuRaho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X67Rp39H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8NstOqXY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X67Rp39H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8NstOqXY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 81FB2353A0;
	Tue, 26 Mar 2024 09:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711446841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AZdWoTycjyxZmxKXrCj0zVJl37+mzb3tmzUWtRx1AM4=;
	b=X67Rp39HWkdE1rUHyo2nSoYTwvk8SWeBDHuk8pong4sblUYNOf4rZMVdlZ6mBeOKXiQ93x
	5zelL5paqnwErw9EvB6WsAysYV2j4MKxEaCSJ19GoMNAI0D8m7NodSEOGhM3+19NQIRUFu
	TqW6+xixmQHfRRxL3uXPoTGVSyf9tFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711446841;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AZdWoTycjyxZmxKXrCj0zVJl37+mzb3tmzUWtRx1AM4=;
	b=8NstOqXYmLMekpDisOnB4Fhz3AS5Pmd9kbJ4y418Qh7Ns2ZBn+bxPhZvacIhgxwfIFe6ct
	c619yQg8+g1kV7CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711446841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AZdWoTycjyxZmxKXrCj0zVJl37+mzb3tmzUWtRx1AM4=;
	b=X67Rp39HWkdE1rUHyo2nSoYTwvk8SWeBDHuk8pong4sblUYNOf4rZMVdlZ6mBeOKXiQ93x
	5zelL5paqnwErw9EvB6WsAysYV2j4MKxEaCSJ19GoMNAI0D8m7NodSEOGhM3+19NQIRUFu
	TqW6+xixmQHfRRxL3uXPoTGVSyf9tFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711446841;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AZdWoTycjyxZmxKXrCj0zVJl37+mzb3tmzUWtRx1AM4=;
	b=8NstOqXYmLMekpDisOnB4Fhz3AS5Pmd9kbJ4y418Qh7Ns2ZBn+bxPhZvacIhgxwfIFe6ct
	c619yQg8+g1kV7CQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F3B213587;
	Tue, 26 Mar 2024 09:54:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id vMnMGjmbAmbzCgAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 26 Mar 2024 09:54:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 051DCA0812; Tue, 26 Mar 2024 10:53:56 +0100 (CET)
Date: Tue, 26 Mar 2024 10:53:56 +0100
From: Jan Kara <jack@suse.cz>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] fsnotify: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <20240326095356.sntn4xtroguimfow@quack3>
References: <ZgImguNzJBiis9Mj@neat>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgImguNzJBiis9Mj@neat>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=X67Rp39H;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8NstOqXY
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 81FB2353A0
X-Spam-Flag: NO

On Mon 25-03-24 19:36:02, Gustavo A. R. Silva wrote:
> Use the `DEFINE_FLEX()` helper for an on-stack definition of a
> flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warning:
> fs/notify/fdinfo.c:45:36: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Link: https://github.com/KSPP/linux/issues/202
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Nice! I've added the patch to my tree.

								Honza

> ---
> Changes in v2:
>  - Use DEFINE_FLEX() instead of struct_group_tagged().
> 
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/ZeeaRuTpuxInH6ZB@neat/
> 
>  fs/notify/fdinfo.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
> index 5c430736ec12..dec553034027 100644
> --- a/fs/notify/fdinfo.c
> +++ b/fs/notify/fdinfo.c
> @@ -41,29 +41,25 @@ static void show_fdinfo(struct seq_file *m, struct file *f,
>  #if defined(CONFIG_EXPORTFS)
>  static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
>  {
> -	struct {
> -		struct file_handle handle;
> -		u8 pad[MAX_HANDLE_SZ];
> -	} f;
> +	DEFINE_FLEX(struct file_handle, f, f_handle, handle_bytes, MAX_HANDLE_SZ);
>  	int size, ret, i;
>  
> -	f.handle.handle_bytes = sizeof(f.pad);
> -	size = f.handle.handle_bytes >> 2;
> +	size = f->handle_bytes >> 2;
>  
> -	ret = exportfs_encode_fid(inode, (struct fid *)f.handle.f_handle, &size);
> +	ret = exportfs_encode_fid(inode, (struct fid *)f->f_handle, &size);
>  	if ((ret == FILEID_INVALID) || (ret < 0)) {
>  		WARN_ONCE(1, "Can't encode file handler for inotify: %d\n", ret);
>  		return;
>  	}
>  
> -	f.handle.handle_type = ret;
> -	f.handle.handle_bytes = size * sizeof(u32);
> +	f->handle_type = ret;
> +	f->handle_bytes = size * sizeof(u32);
>  
>  	seq_printf(m, "fhandle-bytes:%x fhandle-type:%x f_handle:",
> -		   f.handle.handle_bytes, f.handle.handle_type);
> +		   f->handle_bytes, f->handle_type);
>  
> -	for (i = 0; i < f.handle.handle_bytes; i++)
> -		seq_printf(m, "%02x", (int)f.handle.f_handle[i]);
> +	for (i = 0; i < f->handle_bytes; i++)
> +		seq_printf(m, "%02x", (int)f->f_handle[i]);
>  }
>  #else
>  static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

