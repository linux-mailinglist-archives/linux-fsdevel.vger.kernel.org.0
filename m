Return-Path: <linux-fsdevel+bounces-28346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9B5969A31
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 12:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D501F2400E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 10:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CC81C7684;
	Tue,  3 Sep 2024 10:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AEHwKPS7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aeDNE2/p";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AEHwKPS7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aeDNE2/p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E3F1B9857
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359452; cv=none; b=LVEKfQVW7posyn5CAM73uDwXEUX5+fkQwe1qGM4tza26fSds82GzFBkEHnIz/CdK0/6aljXUkVfS6Eqmq8yxJUdkQSol0mel4E2ZiCosafxm/EmnaWIzimi2d32YgnjveudXDpuyjpEtk5MUeiHW/gZ6nKS+p1hs6BDLr7a0uGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359452; c=relaxed/simple;
	bh=yv9Josv2XzaLR2P81sMFJdQ/gdYXvPQwMkLGXrpvhw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1P6MR6mayZCPUIat/Mg8Xv2NiGo4W3Y9e2Hcv0YLyvmIg6LNNFZkCgBkQqkhYftvcGOsVpO/VOYyfu/0FgCS7nehLXdTlnnulvBIJTkToCk1yJ8eWs6q3mgL7kXihVzJNJBauICjuFrZHPYYyUVhsENi+dTZpxUh+eAOJVMSsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AEHwKPS7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aeDNE2/p; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AEHwKPS7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aeDNE2/p; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B372E21C0E;
	Tue,  3 Sep 2024 10:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725359448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7b+IbwgXPg1EXhiubq/tsAYR65t1O8GGzvgHHNZfD0=;
	b=AEHwKPS7X+HjeLm7LfQYe0FJ1tWKLQjrt6N+isHofaWsJ7Fp0d1vDhL/J2I6PstpBEuFNc
	XPR2B5aPglc9t+yeiAeC7OkRPm4bgmhmzmcYEIW2/R/vecxKeyxgi6uCHIf/SnktRDpko4
	6DrgtV18bbb/HfsvThwdqS1JprYwn+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725359448;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7b+IbwgXPg1EXhiubq/tsAYR65t1O8GGzvgHHNZfD0=;
	b=aeDNE2/pvT/XrNBjRkmzIUBKdQ8bP8h6vsfbvAuxcPNjFKFMwP/is5o0IbQRSlp+704Dx9
	bQ7Dsf1OLlHy9VDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AEHwKPS7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="aeDNE2/p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725359448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7b+IbwgXPg1EXhiubq/tsAYR65t1O8GGzvgHHNZfD0=;
	b=AEHwKPS7X+HjeLm7LfQYe0FJ1tWKLQjrt6N+isHofaWsJ7Fp0d1vDhL/J2I6PstpBEuFNc
	XPR2B5aPglc9t+yeiAeC7OkRPm4bgmhmzmcYEIW2/R/vecxKeyxgi6uCHIf/SnktRDpko4
	6DrgtV18bbb/HfsvThwdqS1JprYwn+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725359448;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7b+IbwgXPg1EXhiubq/tsAYR65t1O8GGzvgHHNZfD0=;
	b=aeDNE2/pvT/XrNBjRkmzIUBKdQ8bP8h6vsfbvAuxcPNjFKFMwP/is5o0IbQRSlp+704Dx9
	bQ7Dsf1OLlHy9VDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9920913A80;
	Tue,  3 Sep 2024 10:30:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hh1fJVjl1maoDgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Sep 2024 10:30:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 59EF5A096C; Tue,  3 Sep 2024 12:30:44 +0200 (CEST)
Date: Tue, 3 Sep 2024 12:30:44 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 03/20] ceph: remove unused f_version
Message-ID: <20240903103044.4ipwhcyiqewcxhg2@quack3>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-3-6d3e4816aa7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830-vfs-file-f_version-v1-3-6d3e4816aa7b@kernel.org>
X-Rspamd-Queue-Id: B372E21C0E
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
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,suse.com:email];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 30-08-24 15:04:44, Christian Brauner wrote:
> It's not used for ceph so don't bother with it at all.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ceph/dir.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 18c72b305858..ddec8c9244ee 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -707,7 +707,6 @@ static loff_t ceph_dir_llseek(struct file *file, loff_t offset, int whence)
>  
>  		if (offset != file->f_pos) {
>  			file->f_pos = offset;
> -			file->f_version = 0;
>  			dfi->file_info.flags &= ~CEPH_F_ATEND;
>  		}
>  		retval = offset;
> 
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

