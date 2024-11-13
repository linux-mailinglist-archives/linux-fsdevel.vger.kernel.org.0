Return-Path: <linux-fsdevel+bounces-34657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122AF9C737A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 15:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9492833E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 14:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0561DF75C;
	Wed, 13 Nov 2024 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TkaTiAij";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="da9WukP5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TkaTiAij";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="da9WukP5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F18F7081F
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507937; cv=none; b=qg9/2Io5ypCnW/OLrgRj408eDs/t24KDRMiDWcFe8TMqnVAgDyJZImkVKK5y8vyZScKcmyR5FUYNS6e7xya3E8Qh1PCPALwkEQf7KV/TkheVuOxiz3H1Ph2F8tDAgImPyFX0C0JAudpS6FUMAhZ1RO2yDTh9lC1u/O7xfMM6SOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507937; c=relaxed/simple;
	bh=6g86xiCFWv9Q7jJbI8vFdPIX4ZA609d8K5xJ5VhWWxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H41BaVSzqI+MECZrhzBm2CYoNNZ+db/cJq9ge+++DOnYJB1403SzPx1otDYQDtFqPIvL8okG63Iyp1xl7eMJctS2i6aUizruxAw5ilwk6fB+aEYlhyS6GjpLXNscRGYVaNkEolXnXvTf59JQOskpiWl0M60G0sqyQL3ic3XY5GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TkaTiAij; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=da9WukP5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TkaTiAij; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=da9WukP5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5FED91F38C;
	Wed, 13 Nov 2024 14:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731507933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EKDVmJlOErPgu251KpVAZ2QW/65QFBuZTPKr81GDhv4=;
	b=TkaTiAijupDpXyBM399xWMWkrcVe3pXky6rDaH+8X9VFDNPdZJzArJHvG1HUmTIqdMJ8uF
	nSCoEO44kxmDcl3o0zVmWNCE/MDcQ48SiTZ7YLprSvefw7a27d2PNtzevKskQe0y21PS4u
	E3YNJ+RqjL4CVd3TECfXDSIaP0X3Xm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731507933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EKDVmJlOErPgu251KpVAZ2QW/65QFBuZTPKr81GDhv4=;
	b=da9WukP5rXwhNAHB2pYXZ3bkxZyVoxYEFlGN7KcOyG2LFemZD+4Sy1ZC0McbPo7MIi52dy
	eSi5QFAsa5LcHyDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TkaTiAij;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=da9WukP5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731507933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EKDVmJlOErPgu251KpVAZ2QW/65QFBuZTPKr81GDhv4=;
	b=TkaTiAijupDpXyBM399xWMWkrcVe3pXky6rDaH+8X9VFDNPdZJzArJHvG1HUmTIqdMJ8uF
	nSCoEO44kxmDcl3o0zVmWNCE/MDcQ48SiTZ7YLprSvefw7a27d2PNtzevKskQe0y21PS4u
	E3YNJ+RqjL4CVd3TECfXDSIaP0X3Xm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731507933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EKDVmJlOErPgu251KpVAZ2QW/65QFBuZTPKr81GDhv4=;
	b=da9WukP5rXwhNAHB2pYXZ3bkxZyVoxYEFlGN7KcOyG2LFemZD+4Sy1ZC0McbPo7MIi52dy
	eSi5QFAsa5LcHyDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52E4813A6E;
	Wed, 13 Nov 2024 14:25:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JLbzE922NGebcwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 13 Nov 2024 14:25:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F3132A08D0; Wed, 13 Nov 2024 15:25:28 +0100 (CET)
Date: Wed, 13 Nov 2024 15:25:28 +0100
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>
Subject: Re: [PATCH] dquot.c: get rid of include ../internal.h
Message-ID: <20241113142528.ztchsg7dz6xzw4z5@quack3>
References: <20241112213842.GC3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112213842.GC3387508@ZenIV>
X-Rspamd-Queue-Id: 5FED91F38C
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.com:email];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 12-11-24 21:38:42, Al Viro wrote:
> 	Ugh, indeed - and not needed nearly a decade.  It had been
> added for the sake of inode_sb_list_lock and that spinlock had become
> a per-superblock (->s_inode_list_lock) in March 2015...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Thanks! Added to my tree.

								Honza

> ---
>  fs/quota/dquot.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index b40410cd39af..3dd8d6f27725 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -80,7 +80,6 @@
>  #include <linux/quotaops.h>
>  #include <linux/blkdev.h>
>  #include <linux/sched/mm.h>
> -#include "../internal.h" /* ugh */
>  
>  #include <linux/uaccess.h>
>  
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

