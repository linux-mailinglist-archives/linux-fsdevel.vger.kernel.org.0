Return-Path: <linux-fsdevel+bounces-64906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6930CBF65D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 119CD5047EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E97535504D;
	Tue, 21 Oct 2025 12:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="stj/Mbe+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IKov9Km0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V3/CNZYa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="K9ZOwBEY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613A535504E
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761048349; cv=none; b=gHNIal/PGHGTvV4Hx8KT/76zpni6tDyphSdX5b8vhYkeVyYIEtHu6mtyWEOhY8L0KKyc4Zux/LiUJr+eYdlEe4Y1ZF9arlwEiyZQ0Ftjsuw970bAm+REJuIvYf+mHU98HoMUIA8K6hLayJt7S9+HzigoaSNbGsduIGc1Ii43xU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761048349; c=relaxed/simple;
	bh=hYqpwBdtGJz+BBsWcLCvh+E63wBpPBqGemhiKn7gdMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skwz9R3T6l194AtCzRvoEF9XdvGI4nc691ZQ66I5/N3b4bpo2+zuuD15DrvRjL7T8j/n80j5SNWjed7QFBJykZhOa3rP4kUFzd/GAer794kxebPo/4siAkGNDli1QhRn/S1yWhOb5lt3jz91f9UxHG0WHbzIiRDKMPVOr8rPC1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=stj/Mbe+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IKov9Km0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V3/CNZYa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=K9ZOwBEY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 74C1C1F78F;
	Tue, 21 Oct 2025 12:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761048341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ceJbKSzKfwLTY9oVjq75SsrcC00Yrx2qzu9C8Sz+9mY=;
	b=stj/Mbe+6r2rUr/tvdKO5hySyKd5RmpIXuQ7aXJ3HWP+U74Cb54fgwUdSV4bhkTy56aeoB
	D5NdbulzXUTgsTutzUf2OlLRFIZ8IqzC+LqHTmOYiJBot0Ofs6uzN/LWnGHPkksUD3KkSs
	kkqI4JuQJYvK81qUN3qYfoHs/WvQaZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761048341;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ceJbKSzKfwLTY9oVjq75SsrcC00Yrx2qzu9C8Sz+9mY=;
	b=IKov9Km0o1N1o3ILTPYyFXew/n/UtiynTAtvNDo0UFsb/cZwcNZk+JVFysx2s+AwTGJK0X
	z/2Q8F17ZSzaVRCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="V3/CNZYa";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=K9ZOwBEY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761048337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ceJbKSzKfwLTY9oVjq75SsrcC00Yrx2qzu9C8Sz+9mY=;
	b=V3/CNZYaxRAjiSulkmeeU8UEjq7b3lhR0d4F00ykyOjsMiiSnzYFC6mms2ojCl/Hd9hLbM
	coQfSRywd5tfOZEujy2jXCI6nkGt6UAGYLi72eX3mUVR4fQe1KMcLy8XiSWA2guRPl+2aG
	NVT2HlElAR06YOFbUNyIAlltGlLkJn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761048337;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ceJbKSzKfwLTY9oVjq75SsrcC00Yrx2qzu9C8Sz+9mY=;
	b=K9ZOwBEYR606q7TpYxTUVmas8J+sWi0rNh29oDd2kPYUJBgVHUP7w1CILoXhAeOQPNvReh
	PwYgJob5oFN462BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 671A0139B1;
	Tue, 21 Oct 2025 12:05:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aEsqGRF392hgYgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Oct 2025 12:05:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 25CF4A0990; Tue, 21 Oct 2025 14:05:33 +0200 (CEST)
Date: Tue, 21 Oct 2025 14:05:33 +0200
From: Jan Kara <jack@suse.cz>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org, willy@infradead.org, 
	mcgrof@kernel.org, clm@meta.com, david@fromorbit.com, amir73il@gmail.com, 
	axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com, djwong@kernel.org, 
	dave@stgolabs.net, wangyufei@vivo.com, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-mm@kvack.org, gost.dev@samsung.com, anuj20.g@samsung.com, vishak.g@samsung.com, 
	joshi.k@samsung.com
Subject: Re: [PATCH v2 05/16] writeback: modify bdi_writeback search logic to
 search across all wb ctxs
Message-ID: <64svwwe2zosyjibtzmhxj4fvffhzlmntrf2fsxlh7jhj33c5wl@h3vqsl74fihv>
References: <20251014120845.2361-1-kundan.kumar@samsung.com>
 <CGME20251014121036epcas5p17c607955db032d076daa2e5cfecfe8ea@epcas5p1.samsung.com>
 <20251014120845.2361-6-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014120845.2361-6-kundan.kumar@samsung.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 74C1C1F78F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLhzk8m8dynxu9bgo74bfqqdh9)];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,szeredi.hu,redhat.com,linux-foundation.org,infradead.org,meta.com,fromorbit.com,gmail.com,kernel.dk,lst.de,stgolabs.net,vivo.com,lists.sourceforge.net,vger.kernel.org,lists.linux.dev,kvack.org,samsung.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim]
X-Spam-Score: -2.51

On Tue 14-10-25 17:38:34, Kundan Kumar wrote:
> Since we have multiple cgwb per bdi, embedded in writeback_ctx now, we
> iterate over all of them to find the associated writeback.
> 
> Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>  fs/fs-writeback.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 56c048e22f72..93f8ea340247 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1090,7 +1090,8 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
>  {
>  	struct backing_dev_info *bdi;
>  	struct cgroup_subsys_state *memcg_css;
> -	struct bdi_writeback *wb;
> +	struct bdi_writeback *wb = NULL;
> +	struct bdi_writeback_ctx *bdi_wb_ctx;
>  	struct wb_writeback_work *work;
>  	unsigned long dirty;
>  	int ret;
> @@ -1114,7 +1115,11 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
>  	 * And find the associated wb.  If the wb isn't there already
>  	 * there's nothing to flush, don't create one.
>  	 */
> -	wb = wb_get_lookup(bdi->wb_ctx[0], memcg_css);
> +	for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
> +		wb = wb_get_lookup(bdi_wb_ctx, memcg_css);
> +		if (wb)
> +			break;
> +	}

This is wrong. We need to run writeback for all bdi_writeback structures
for given memcg_css. Not just for the one we found first. Otherwise
cgroup_writeback_by_id() wouldn't properly relieve the dirty pages pressure
from a foreign dirtying of a memcg (see the big comment before
mem_cgroup_track_foreign_dirty_slowpath() for more background on why
cgroup_writeback_by_id() exists).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

