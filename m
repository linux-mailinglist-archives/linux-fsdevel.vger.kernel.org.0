Return-Path: <linux-fsdevel+bounces-41042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC51A2A3CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 10:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50BEF1884D4B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 09:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08020225A3F;
	Thu,  6 Feb 2025 09:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q2/7Fomp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pir/qj0/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q2/7Fomp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pir/qj0/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CFF20E032;
	Thu,  6 Feb 2025 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738832560; cv=none; b=RcaIDecsR87NQgTo58xBjz62Y9w8J0eR9us/usJbbGoOPRmIrxKYWwYY599bJFeAL0EmW8Lav+PC4A61KjKOkUgVIH6KyL/QrESwDfuUmLaBXMTqmAQoiY8iQg0jsm5BpveRGqhwjB8Lcyq5JPeEmz54FfXKpxyZv2/86fPsfq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738832560; c=relaxed/simple;
	bh=tkCI1kLUExHSS7JfbF9OB+d63f2Y0jbJBMMkHqhjSyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbdSqOYwzz1cL0c2wi9ilFbmWDuiqh27Ws8bHMCd2ntbJp+EIeuP50/Et+bf+LUoR9W/5DEb8ItRRpREqgN8/zqhJ4mdr2IQHEsQUoRpOW2GHoN2hOHHUk5HU8on32/5Dqa84goEYNvVkWF1XX48/CZtApXxtnYK0x9lVP2DKjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q2/7Fomp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pir/qj0/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q2/7Fomp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pir/qj0/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6A66121114;
	Thu,  6 Feb 2025 09:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738832556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9tGJNfaiKYVRYotbnHADnx3rwAsOF2lsftBqriomn/k=;
	b=Q2/7FompWbxErPXX2RXUy1wzVHoFXBfKz23hJX8AH2Iths1/47EjP0vaia6N1zA2Hnvqbc
	JQNvVunZkKr1isQKU693ML2IAcd/OZhMv1cPgui0M9z31YlkOr6pwvnPo+TRqHlWqgCzq6
	aW+soTgBHAVvG9/22DD8N0kd1oGgCpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738832556;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9tGJNfaiKYVRYotbnHADnx3rwAsOF2lsftBqriomn/k=;
	b=Pir/qj0/cXlvWmVFCcDe55yIZxAaSVo/uG2ar/sFVOjvIIiUCc8mOW1tcpBMAuAFjZ6/b5
	9PTozImR03UBfjAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738832556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9tGJNfaiKYVRYotbnHADnx3rwAsOF2lsftBqriomn/k=;
	b=Q2/7FompWbxErPXX2RXUy1wzVHoFXBfKz23hJX8AH2Iths1/47EjP0vaia6N1zA2Hnvqbc
	JQNvVunZkKr1isQKU693ML2IAcd/OZhMv1cPgui0M9z31YlkOr6pwvnPo+TRqHlWqgCzq6
	aW+soTgBHAVvG9/22DD8N0kd1oGgCpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738832556;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9tGJNfaiKYVRYotbnHADnx3rwAsOF2lsftBqriomn/k=;
	b=Pir/qj0/cXlvWmVFCcDe55yIZxAaSVo/uG2ar/sFVOjvIIiUCc8mOW1tcpBMAuAFjZ6/b5
	9PTozImR03UBfjAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EFC313694;
	Thu,  6 Feb 2025 09:02:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3v4qF6x6pGc4PgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 06 Feb 2025 09:02:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0A789A0889; Thu,  6 Feb 2025 10:02:36 +0100 (CET)
Date: Thu, 6 Feb 2025 10:02:35 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: inline getname()
Message-ID: <7exbpvo4svpmhk7n7sjq55wlaqhndk3qk2ijw7y4dvykqbhg3n@y5axd74zos5i>
References: <20250206000105.432528-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206000105.432528-1-mjguzik@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Thu 06-02-25 01:01:05, Mateusz Guzik wrote:
> It is merely a trivial wrapper around getname_flags which adds a zeroed
> argument, no point paying for an extra call.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Well, the "extra call" in your changelog is a bit overrated. Such wrappers
get compiled into a constant jump anyway - e.g. in my kernel:

Dump of assembler code for function getname:
   0xffffffff815edb80 <+0>:	endbr64 
   0xffffffff815edb84 <+4>:	call   0xffffffff8131cad0 <__fentry__>
   0xffffffff815edb89 <+9>:	xor    %esi,%esi
   0xffffffff815edb8b <+11>:	jmp    0xffffffff815ed750 <getname_flags>

And the jmp to constant is practically free on current CPUs.

Overall inline function for this is I guess a more common way how we do
things like this so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namei.c         | 5 -----
>  include/linux/fs.h | 5 ++++-
>  2 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 3ab9440c5b93..3a4039acdb3f 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -218,11 +218,6 @@ struct filename *getname_uflags(const char __user *filename, int uflags)
>  	return getname_flags(filename, flags);
>  }
>  
> -struct filename *getname(const char __user * filename)
> -{
> -	return getname_flags(filename, 0);
> -}
> -
>  struct filename *__getname_maybe_null(const char __user *pathname)
>  {
>  	struct filename *name;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e73d9b998780..85d88dd5ab6c 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2840,7 +2840,10 @@ extern int filp_close(struct file *, fl_owner_t id);
>  
>  extern struct filename *getname_flags(const char __user *, int);
>  extern struct filename *getname_uflags(const char __user *, int);
> -extern struct filename *getname(const char __user *);
> +static inline struct filename *getname(const char __user *name)
> +{
> +	return getname_flags(name, 0);
> +}
>  extern struct filename *getname_kernel(const char *);
>  extern struct filename *__getname_maybe_null(const char __user *);
>  static inline struct filename *getname_maybe_null(const char __user *name, int flags)
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

