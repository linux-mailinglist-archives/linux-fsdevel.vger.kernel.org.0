Return-Path: <linux-fsdevel+bounces-33879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEBB9C0110
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 10:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F461C215B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 09:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCAD1DEFCD;
	Thu,  7 Nov 2024 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TZztnxDp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o9yhmzlW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TZztnxDp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o9yhmzlW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E701DCB0C
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730971290; cv=none; b=E/VfybE1QzcfDhImgtFp3OzuKRWO27x3BzxAXQk+7I77S9dKAaOY2zy+qgN9mId8ax45BkWXQnOryIOATHyPQfq7B3Ksv1QojLMTr9R2TqZJ9b1KnZApi5/f0cEQO/qmR31tFJYXCBpgckh1PO+hWnLx2oK2OcjK51B4VwXELlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730971290; c=relaxed/simple;
	bh=5EPXVNHN4CXlVNZJUesPr2QPYDPaJSlggEeL3j6SUy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7qZltFrAZ4aFVgMYDDUJgL9MjJGgKTi6FtPk5LzWJuDmqlF1IvC1e6I+hCgnY7XZS5s1J6IxzdMi5edbhLb80h+Tj4d+vhjXzxiS4RkzmyVvdJbvGFkv1Y/iXP8P46i+ZHDDXLp/Go5QpwKzbUlbUHmhAvR+scnZizVUlhLW0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TZztnxDp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o9yhmzlW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TZztnxDp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o9yhmzlW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5E2D421B91;
	Thu,  7 Nov 2024 09:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730971281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yVxFif4uBW4/0sQS5ygnxojzEubRjKEJYObrh5RLC+A=;
	b=TZztnxDpfeb+SSuX6oHkM5Ei7ulFMYyVKw+tqZZy3ThomQimOVMtA0vEAmrtHUOl+3Wm8T
	RXqp7MUnnjrm1VsETOiRAWXx3OB9K8F8ULFV4EZhc4ec4UB2RK+Cd0bNOx3vmofdCslzqH
	T8QvqFZnRPrAgVswbdRd98urQCIZG20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730971281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yVxFif4uBW4/0sQS5ygnxojzEubRjKEJYObrh5RLC+A=;
	b=o9yhmzlWFjo00nV8wOrbug4TP1UcSa2fK/ophdFKqGCELkYRckPwdU55wFVdVcFz6ywsNn
	MQON1z94W68AlbDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730971281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yVxFif4uBW4/0sQS5ygnxojzEubRjKEJYObrh5RLC+A=;
	b=TZztnxDpfeb+SSuX6oHkM5Ei7ulFMYyVKw+tqZZy3ThomQimOVMtA0vEAmrtHUOl+3Wm8T
	RXqp7MUnnjrm1VsETOiRAWXx3OB9K8F8ULFV4EZhc4ec4UB2RK+Cd0bNOx3vmofdCslzqH
	T8QvqFZnRPrAgVswbdRd98urQCIZG20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730971281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yVxFif4uBW4/0sQS5ygnxojzEubRjKEJYObrh5RLC+A=;
	b=o9yhmzlWFjo00nV8wOrbug4TP1UcSa2fK/ophdFKqGCELkYRckPwdU55wFVdVcFz6ywsNn
	MQON1z94W68AlbDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55829139B3;
	Thu,  7 Nov 2024 09:21:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vSzYFJGGLGd1cgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 07 Nov 2024 09:21:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 04023A0AF4; Thu,  7 Nov 2024 10:21:12 +0100 (CET)
Date: Thu, 7 Nov 2024 10:21:12 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] writeback: add a __releases annoation to
 wbc_attach_and_unlock_inode
Message-ID: <20241107092112.w4qgmwo7fchl3imz@quack3>
References: <20241107072632.672795-1-hch@lst.de>
 <20241107072632.672795-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107072632.672795-2-hch@lst.de>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Thu 07-11-24 07:26:18, Christoph Hellwig wrote:
> This shuts up a sparse lock context tracking warning.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks! Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index d8bec3c1bb1f..3fb115ae44b1 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -733,6 +733,7 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
>   */
>  void wbc_attach_and_unlock_inode(struct writeback_control *wbc,
>  				 struct inode *inode)
> +	__releases(&inode->i_lock)
>  {
>  	if (!inode_cgwb_enabled(inode)) {
>  		spin_unlock(&inode->i_lock);
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

