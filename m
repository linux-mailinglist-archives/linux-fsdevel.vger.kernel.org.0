Return-Path: <linux-fsdevel+bounces-30877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2A898EFD5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 14:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8E81F23BDB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 12:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571DE19922A;
	Thu,  3 Oct 2024 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FbSPJOOe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0kGkmGl2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FbSPJOOe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0kGkmGl2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AA21990AA;
	Thu,  3 Oct 2024 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727960218; cv=none; b=c99FcwQ9+VR+HTFsUh/o2SpnRlh3GSYSgPNH1CCl6olkVcyqZfn0WaKTiXygbTox8biajyznKHcX/8wdqHNk+pAohubW0QaVcRoJAEHAGXL9nl00NDZAs9TNeq5M3F1QB7xRxYKnM0ZU02dNyOjP2FpYRBhFoaBK/RwGCuHZ3Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727960218; c=relaxed/simple;
	bh=dEZHhcRNHJtuOhkSpO6M3dhjaBz4/Tpq4sVRICVXuOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkG828ClLTyvnb85p2Ln3Iv+rxwC2uIHt1h5dUumTCtIk9jKMm2oQh/Xs5IeRUF/s93Ym/fKw/xKpj96UwXS2jwASTXHxagNzMYPReROiMwOYFjOx5pUdKnnthTOfSvpaJKtxsSzWA2K6QCKPygY9H0xqkpbnbaahZ0Qz38NMaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FbSPJOOe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0kGkmGl2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FbSPJOOe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0kGkmGl2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4AEBC21C9D;
	Thu,  3 Oct 2024 12:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727960215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0dGDk1/DJLFq+x5VU+voSc3Ss2+GN3kBk9KS/GGlynY=;
	b=FbSPJOOeij35aJIjFMvpWcHvY0J6DaXjUTwe32eHbNbjN09KBZXUGhqu6luFuK7kmPK+IU
	uMgD7ZdBBCzWAQ81qbjOSVrjOoWpm5ctLaDNvWAd3IiXPx30481VI1kY6Y4UDiZqf2c+cf
	AcpIcT0m3rIQD8TDV+8FgQG3nN/4zVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727960215;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0dGDk1/DJLFq+x5VU+voSc3Ss2+GN3kBk9KS/GGlynY=;
	b=0kGkmGl2gsRpceSfQWu2fBd7sd3Jgq/uaWTEyOryxrDebUIsw3FuyaPeE5lX96K5vSTjpw
	4xO1mnSNx8tK2DCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727960215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0dGDk1/DJLFq+x5VU+voSc3Ss2+GN3kBk9KS/GGlynY=;
	b=FbSPJOOeij35aJIjFMvpWcHvY0J6DaXjUTwe32eHbNbjN09KBZXUGhqu6luFuK7kmPK+IU
	uMgD7ZdBBCzWAQ81qbjOSVrjOoWpm5ctLaDNvWAd3IiXPx30481VI1kY6Y4UDiZqf2c+cf
	AcpIcT0m3rIQD8TDV+8FgQG3nN/4zVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727960215;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0dGDk1/DJLFq+x5VU+voSc3Ss2+GN3kBk9KS/GGlynY=;
	b=0kGkmGl2gsRpceSfQWu2fBd7sd3Jgq/uaWTEyOryxrDebUIsw3FuyaPeE5lX96K5vSTjpw
	4xO1mnSNx8tK2DCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C68D13882;
	Thu,  3 Oct 2024 12:56:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id USa2DpeU/mbbMAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 03 Oct 2024 12:56:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E9745A086F; Thu,  3 Oct 2024 14:56:50 +0200 (CEST)
Date: Thu, 3 Oct 2024 14:56:50 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev,
	torvalds@linux-foundation.org,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@linux.microsoft.com>,
	Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>,
	Kees Cook <keescook@chromium.org>,
	linux-security-module@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert
 sb->s_inodes iteration to super_iter_inodes()
Message-ID: <20241003125650.jtkqezmtnzfoysb2@quack3>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002014017.3801899-5-david@fromorbit.com>
 <Zv5GfY1WS_aaczZM@infradead.org>
 <Zv5J3VTGqdjUAu1J@infradead.org>
 <20241003115721.kg2caqgj2xxinnth@quack3>
 <Zv6J34fwj3vNOrIH@infradead.org>
 <20241003122657.mrqwyc5tzeggrzbt@quack3>
 <Zv6Qe-9O44g6qnSu@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv6Qe-9O44g6qnSu@infradead.org>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,fromorbit.com,vger.kernel.org,linux.dev,linux-foundation.org,linux.microsoft.com,google.com,hallyn.com,chromium.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 03-10-24 05:39:23, Christoph Hellwig wrote:
> On Thu, Oct 03, 2024 at 02:26:57PM +0200, Jan Kara wrote:
> > On Thu 03-10-24 05:11:11, Christoph Hellwig wrote:
> > > On Thu, Oct 03, 2024 at 01:57:21PM +0200, Jan Kara wrote:
> > > > Fair enough. If we go with the iterator variant I've suggested to Dave in
> > > > [1], we could combine the evict_inodes(), fsnotify_unmount_inodes() and
> > > > Landlocks hook_sb_delete() into a single iteration relatively easily. But
> > > > I'd wait with that convertion until this series lands.
> > > 
> > > I don't see how that has anything to do with iterators or not.
> > 
> > Well, the patches would obviously conflict
> 
> Conflict with what?

I thought you wanted the interations to be unified in current state of
code. If you meant after Dave's series, then we are in agreement.

> > which seems pointless if we
> > could live with three iterations for a few years until somebody noticed :).
> > And with current Dave's version of iterators it will not be possible to
> > integrate evict_inodes() iteration with the other two without a layering
> > violation. Still we could go from 3 to 2 iterations.
> 
> What layering violation?
> 
> Below is quick compile tested part to do the fsnotify side and
> get rid of the fsnotify iteration, which looks easily worth it.

...

> @@ -789,11 +789,23 @@ static bool dispose_list(struct list_head *head)
>   */
>  static int evict_inode_fn(struct inode *inode, void *data)
>  {
> +	struct super_block *sb = inode->i_sb;
>  	struct list_head *dispose = data;
> +	bool post_unmount = !(sb->s_flags & SB_ACTIVE);
>  
>  	spin_lock(&inode->i_lock);
> -	if (atomic_read(&inode->i_count) ||
> -	    (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE))) {
> +	if (atomic_read(&inode->i_count)) {
> +		spin_unlock(&inode->i_lock);
> +
> +		/* for each watch, send FS_UNMOUNT and then remove it */
> +		if (post_unmount && fsnotify_sb_info(sb)) {
> +			fsnotify_inode(inode, FS_UNMOUNT);
> +			fsnotify_inode_delete(inode);
> +		}

This will not work because you are in unsafe iterator holding
sb->s_inode_list_lock. To be able to call into fsnotify, you need to do the
iget / iput dance and releasing of s_inode_list_lock which does not work
when a filesystem has its own inodes iterator AFAICT... That's why I've
called it a layering violation.

									Honza

> +		return INO_ITER_DONE;
> +	}
> +
> +	if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
>  		spin_unlock(&inode->i_lock);
>  		return INO_ITER_DONE;
>  	}
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

