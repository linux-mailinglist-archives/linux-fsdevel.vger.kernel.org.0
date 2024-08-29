Return-Path: <linux-fsdevel+bounces-27801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F839642C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468DD282B98
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 11:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1F31917E4;
	Thu, 29 Aug 2024 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VCSbS6ok";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iFTnNwyE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VCSbS6ok";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iFTnNwyE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE541917E1;
	Thu, 29 Aug 2024 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724929865; cv=none; b=puJ3Y2wAgPcvaqkM96b6AZH2Z95Y0EsUT7R+H/zauw5otC8lIhmYqYxLSIgnb0MsgaV2wCFijb8vLMolT0Bvtckv5e0k1saWgEKO21+olEBXOxyacRevRlo51wpQw6p8inkRWfYLqzsK84XQwcA56B21j3p7F1SwiNesP+dlC3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724929865; c=relaxed/simple;
	bh=L94uN3B/At7zLTkXVd08a4GdD0bXqLhFAbeMAu2J1Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9rAOo95ILdYvxNoC0iBhkUYraIOzD+8tmXvHWehwuEJM8QrvenVyNlMf2/xd6XcfMt83XG7QZv49aH5UNim26HiCA1feki19DwjtcU1erp4JxUS/pKeF3FnYWJ4PIjnJvkigaDV4MKAwTR6SGPQD6THhr9geVzsUJl+X5zOy5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VCSbS6ok; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iFTnNwyE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VCSbS6ok; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iFTnNwyE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8C44D21B60;
	Thu, 29 Aug 2024 11:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724929859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eej04jooKUE07vi4Um0DdcVAy0xheLF6MG1G83fEHPY=;
	b=VCSbS6okoaFTk0/pAVsfkSnZoVXRJabBork2ZPQ5pMeogqxEQgonWYgE1dzPPt1emF/1je
	4PnwaaZ+p8r1ikQ1q9hxA/gl0wWP0ePnx3XcLm9wMjlCNE4zsl75tp8IcWymO9FZbBMnoa
	KOfPuhJIQTHKchvwYAxJ9TgJ9ZUVNDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724929859;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eej04jooKUE07vi4Um0DdcVAy0xheLF6MG1G83fEHPY=;
	b=iFTnNwyEIQg+jfBfj/T4PdeBA+lApaa1XKuWE8yJggAzs4s+aCaeRJgm/8RNm0yJWled/c
	RvnGLnmZr0IdLsBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VCSbS6ok;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iFTnNwyE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724929859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eej04jooKUE07vi4Um0DdcVAy0xheLF6MG1G83fEHPY=;
	b=VCSbS6okoaFTk0/pAVsfkSnZoVXRJabBork2ZPQ5pMeogqxEQgonWYgE1dzPPt1emF/1je
	4PnwaaZ+p8r1ikQ1q9hxA/gl0wWP0ePnx3XcLm9wMjlCNE4zsl75tp8IcWymO9FZbBMnoa
	KOfPuhJIQTHKchvwYAxJ9TgJ9ZUVNDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724929859;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eej04jooKUE07vi4Um0DdcVAy0xheLF6MG1G83fEHPY=;
	b=iFTnNwyEIQg+jfBfj/T4PdeBA+lApaa1XKuWE8yJggAzs4s+aCaeRJgm/8RNm0yJWled/c
	RvnGLnmZr0IdLsBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DD9C139B0;
	Thu, 29 Aug 2024 11:10:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lhy0HkNX0GYgFAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 29 Aug 2024 11:10:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2FC6BA0965; Thu, 29 Aug 2024 13:10:55 +0200 (CEST)
Date: Thu, 29 Aug 2024 13:10:55 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-bcachefs@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH v4 14/16] bcachefs: add pre-content fsnotify hook to fault
Message-ID: <20240829111055.hyc4eke7a5e26z7r@quack3>
References: <cover.1723670362.git.josef@toxicpanda.com>
 <9627e80117638745c2f4341eb8ac94f63ea9acee.1723670362.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9627e80117638745c2f4341eb8ac94f63ea9acee.1723670362.git.josef@toxicpanda.com>
X-Rspamd-Queue-Id: 8C44D21B60
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
	RCPT_COUNT_SEVEN(0.00)[10];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,suse.cz,gmail.com,kernel.org,lists.linux.dev,linux.dev];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toxicpanda.com:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 14-08-24 17:25:32, Josef Bacik wrote:
> bcachefs has its own locking around filemap_fault, so we have to make
> sure we do the fsnotify hook before the locking.  Add the check to emit
> the event before the locking and return VM_FAULT_RETRY to retrigger the
> fault once the event has been emitted.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good to me. Would be nice to get ack from bcachefs guys. Kent?

								Honza

> ---
>  fs/bcachefs/fs-io-pagecache.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/bcachefs/fs-io-pagecache.c b/fs/bcachefs/fs-io-pagecache.c
> index a9cc5cad9cc9..1fa1f1ac48c8 100644
> --- a/fs/bcachefs/fs-io-pagecache.c
> +++ b/fs/bcachefs/fs-io-pagecache.c
> @@ -570,6 +570,10 @@ vm_fault_t bch2_page_fault(struct vm_fault *vmf)
>  	if (fdm == mapping)
>  		return VM_FAULT_SIGBUS;
>  
> +	ret = filemap_maybe_emit_fsnotify_event(vmf);
> +	if (unlikely(ret))
> +		return ret;
> +
>  	/* Lock ordering: */
>  	if (fdm > mapping) {
>  		struct bch_inode_info *fdm_host = to_bch_ei(fdm->host);
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

