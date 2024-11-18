Return-Path: <linux-fsdevel+bounces-35116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 760E09D17E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 19:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0C21B23C3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 18:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871011DED7B;
	Mon, 18 Nov 2024 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jSwXpjPJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="86ROUx0e";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ch4xaa8s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TBDhvAui"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35888199FBF;
	Mon, 18 Nov 2024 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731953680; cv=none; b=ReYajbQjwEhrg42WdpKhsNTdKOC58MIMA4DNhpjQ928n9ryZs34ZwW3omzYnamJxAhQ3vvb3YSx9W8Fa96oZmJOhHTnuAvTl2weGKiu5+QdfPXNNy7AXH2t1gU4+q7NCjeUbZQcH+gW06QCzC5tSh6XKXntKMSTL/LfNy60utqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731953680; c=relaxed/simple;
	bh=6DUb29KItG037LbAN08Kp8gw17BtqjN3QpEmPJudJLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxyOlKK+vbWJ9YkKsXVWEbz60x1gWSfdvt5mzKbCKUXa5FOktqkisn1sNO8ybXRv4IjwGkkLTdrrbMvoB7Fm122zo0nUiiA/wLApvcUR9VeTg82M9VlWbo7BSrhCbOwWpu7Y26HnrtKkfrmOqsqSdNkL1GLQAxiATymZCoEXvYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jSwXpjPJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=86ROUx0e; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ch4xaa8s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TBDhvAui; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 45FD61F365;
	Mon, 18 Nov 2024 18:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731953676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=md9G+/9cSr7JpPaP78XtOG3skD1kyowear2VacQB+is=;
	b=jSwXpjPJdyP3H9kg2vP6YVPy6sMElERXItbvv/fUYhTmq8g1QZ1MsmPPS1rM66VPUFsiuG
	DgSiLR/2k6hkqbUQALIoW6akd29RL6r4TKRNM31LEya2loOMax9+nrDVeTI1GyiyomK8Km
	55ZJ5cmjlZo0hV2bxZNAj2T7Gh91XOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731953676;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=md9G+/9cSr7JpPaP78XtOG3skD1kyowear2VacQB+is=;
	b=86ROUx0e0I30RVzHdIaRVEUbV4xjvw6UF+v1YTkUCd/zPtq5gPbd4ZY60/BgGf6j1EPT4U
	YIqyE0FG1oJmbeBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ch4xaa8s;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TBDhvAui
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731953675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=md9G+/9cSr7JpPaP78XtOG3skD1kyowear2VacQB+is=;
	b=ch4xaa8s317XGBtr2Ge9VfJFvlBX/S9XN4vXUSSS5WdtF6ZpUcPhj+J8or/csizv3pct83
	wE8++FlhQZG6od51OOfpRLzZ1gB19DJKnNmfEhfUwkIHXeD9hzumSoXP27EwSDIFGgUy6f
	jWB+fk83OpTtIQzxGH1AdOQ92t4WpQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731953675;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=md9G+/9cSr7JpPaP78XtOG3skD1kyowear2VacQB+is=;
	b=TBDhvAui+7AK/qG/gNQBM9MyLcvk2gO1AmzGWyykr4br2aEPuF4eZUGiytDJd91KlLHKyI
	ZIyKVXVcsKTdUTDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35A45134A0;
	Mon, 18 Nov 2024 18:14:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZF3RDAuEO2dIPwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 18 Nov 2024 18:14:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C3826A0984; Mon, 18 Nov 2024 19:14:34 +0100 (CET)
Date: Mon, 18 Nov 2024 19:14:34 +0100
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org,
	torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v8 01/19] fs: get rid of __FMODE_NONOTIFY kludge
Message-ID: <20241118181434.iwsu2yqlkjyw4wkw@quack3>
References: <cover.1731684329.git.josef@toxicpanda.com>
 <d1231137e7b661a382459e79a764259509a4115d.1731684329.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1231137e7b661a382459e79a764259509a4115d.1731684329.git.josef@toxicpanda.com>
X-Rspamd-Queue-Id: 45FD61F365
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,linux.org.uk:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,suse.cz,gmail.com,kernel.org,linux-foundation.org,zeniv.linux.org.uk,kvack.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 15-11-24 10:30:14, Josef Bacik wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> All it takes to get rid of the __FMODE_NONOTIFY kludge is switching
> fanotify from anon_inode_getfd() to anon_inode_getfile_fmode() and adding
> a dentry_open_fmode() helper to be used by fanotify on the other path.
    ^^^ this ended up being dentry_open_nonotify()

> That's it - no more weird shit in OPEN_FMODE(), etc.
> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Link: https://lore.kernel.org/linux-fsdevel/20241113043003.GH3387508@ZenIV/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

...

> @@ -3706,11 +3708,9 @@ struct ctl_table;
>  int __init list_bdev_fs_names(char *buf, size_t size);
>  
>  #define __FMODE_EXEC		((__force int) FMODE_EXEC)
> -#define __FMODE_NONOTIFY	((__force int) FMODE_NONOTIFY)
>  
>  #define ACC_MODE(x) ("\004\002\006\006"[(x)&O_ACCMODE])
> -#define OPEN_FMODE(flag) ((__force fmode_t)(((flag + 1) & O_ACCMODE) | \
> -					    (flag & __FMODE_NONOTIFY)))
> +#define OPEN_FMODE(flag) ((__force fmode_t)(((flag + 1) & O_ACCMODE)))
					       ^^^ one more level of braces
than necessary now

Otherwise looks good to me. Don't need to resend just because of this, I
can fix this up if there's nothing else.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

