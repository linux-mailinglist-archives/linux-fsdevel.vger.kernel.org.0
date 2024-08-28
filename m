Return-Path: <linux-fsdevel+bounces-27597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B00D9962B53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 17:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C2671F212DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 15:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09D51A08C0;
	Wed, 28 Aug 2024 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yMBMTH9x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KPF5HUVQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yMBMTH9x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KPF5HUVQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850BE1891AC;
	Wed, 28 Aug 2024 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724857737; cv=none; b=FVLhhcCeT9zzy071SJk6u7VVR5zmHBL53Zdjea8QG9HlHuiqPhgtKaZhQdlm17xYksdKZxC34Yzh+mP57Xv52OgsVmShDVdFRb9eAifujlXM0u2IZVhtWVsAnwRl7h2kLeIQ8eBb2vLB/GDo2S1oiqinbqVQHz9De9wKYHCGxBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724857737; c=relaxed/simple;
	bh=ciIOopRZXHm7bQh/XnKASgRdyGmpXfI3Nueagf8RVes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HryzrDKDZ0TZXb6UPy3NMwupm8zZ8K6aEMujh0PRYX77LdZsaXwop70V5lGcyDGbOSpI/hyjH2Ta4rtNMfr8+6SDg7GNJ1Fp99RVsIxjSsRqnzeCAfP6673KkH22aemXd6aHRJ5szsuM+Lzs0+/5yJSKA15OrLk0ngUmfot9Ykc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yMBMTH9x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KPF5HUVQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yMBMTH9x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KPF5HUVQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 93EA41FC31;
	Wed, 28 Aug 2024 15:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724857733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gi+mHETbmGdS5Vbarnv22fjKZVh2QakbYtc/GwWs6Y=;
	b=yMBMTH9xN/bkZ5Js6QlNKe1gd9CextjUYO6vKBcIQPAuWMP9mOpS1OFodeKHE1M3O6Y6Lp
	FvhFdGuoZ9kv7w8yZwBPtys2+HW+EsrC6aSgZLoz77xnx7cvXLIVhm3oww3sAWBPRIPZr6
	wm5Q8Po6SeNrNnNGtPusOu2fiKUI63o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724857733;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gi+mHETbmGdS5Vbarnv22fjKZVh2QakbYtc/GwWs6Y=;
	b=KPF5HUVQcFXcEahK/0m0DuUy8ZE5pQXJmRkp+6qTNxRy39Su80fsJvKXNdgzwlSRx833/n
	1chRkOxF+ymdPHBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724857733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gi+mHETbmGdS5Vbarnv22fjKZVh2QakbYtc/GwWs6Y=;
	b=yMBMTH9xN/bkZ5Js6QlNKe1gd9CextjUYO6vKBcIQPAuWMP9mOpS1OFodeKHE1M3O6Y6Lp
	FvhFdGuoZ9kv7w8yZwBPtys2+HW+EsrC6aSgZLoz77xnx7cvXLIVhm3oww3sAWBPRIPZr6
	wm5Q8Po6SeNrNnNGtPusOu2fiKUI63o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724857733;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gi+mHETbmGdS5Vbarnv22fjKZVh2QakbYtc/GwWs6Y=;
	b=KPF5HUVQcFXcEahK/0m0DuUy8ZE5pQXJmRkp+6qTNxRy39Su80fsJvKXNdgzwlSRx833/n
	1chRkOxF+ymdPHBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89394138D2;
	Wed, 28 Aug 2024 15:08:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K6V7IYU9z2ZFSgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 28 Aug 2024 15:08:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 39E7DA0968; Wed, 28 Aug 2024 17:08:53 +0200 (CEST)
Date: Wed, 28 Aug 2024 17:08:53 +0200
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	jack@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk,
	mhiramat@kernel.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v2] writeback: Refine the show_inode_state() macro
 definition
Message-ID: <20240828150853.st5s4q5bxz4wbgdd@quack3>
References: <20240828081359.62429-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240828081359.62429-1-sunjunchao2870@gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 28-08-24 16:13:59, Julian Sun wrote:
> Currently, the show_inode_state() macro only prints
> part of the state of inode->i_state. Let’s improve it
> to display more of its state.
> 
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/trace/events/writeback.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> index 54e353c9f919..a261e86e61fa 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -20,7 +20,15 @@
>  		{I_CLEAR,		"I_CLEAR"},		\
>  		{I_SYNC,		"I_SYNC"},		\
>  		{I_DIRTY_TIME,		"I_DIRTY_TIME"},	\
> -		{I_REFERENCED,		"I_REFERENCED"}		\
> +		{I_REFERENCED,		"I_REFERENCED"},	\
> +		{I_LINKABLE,		"I_LINKABLE"},		\
> +		{I_WB_SWITCH,		"I_WB_SWITCH"},		\
> +		{I_OVL_INUSE,		"I_OVL_INUSE"},		\
> +		{I_CREATING,		"I_CREATING"},		\
> +		{I_DONTCACHE,		"I_DONTCACHE"},		\
> +		{I_SYNC_QUEUED,		"I_SYNC_QUEUED"},	\
> +		{I_PINNING_NETFS_WB,	"I_PINNING_NETFS_WB"},	\
> +		{I_LRU_ISOLATING,	"I_LRU_ISOLATING"}	\
>  	)
>  
>  /* enums need to be exported to user space */
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

