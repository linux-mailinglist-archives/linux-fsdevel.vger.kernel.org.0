Return-Path: <linux-fsdevel+bounces-15318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CD088C204
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 13:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0DC29BF7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 12:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B644671B40;
	Tue, 26 Mar 2024 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ERuFtmQQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9LI5XNpv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ce56UmHG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DBH4hFPy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E2B12B6C;
	Tue, 26 Mar 2024 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455872; cv=none; b=i2y537571gWA4TC57UAAzeXr4w0sFR7xLiljrUuhtFQYlVOcDc+ta4jjycnsXMs3Hsf+GzCGWUklXKICnTqTBl7IXZcJ2FFMy4dKs+e59qqEA0xKFQ0eMkozSxZ6+Z29X4i5Y0z0Iq0nIwGxmkFOxg2CqUt02ia2c4h3ETVGnxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455872; c=relaxed/simple;
	bh=I1ZiL/hInL+ghSma0LT89xOBCTtxfBLfKBSp53FTii0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWVXnkNm+f2L2xFIi1VPnhxZhWGxqxFqby/nXjcKUzZmwqzlQfCVmIvcWEiJkvHP5oDg2u0tmucgMlKF5d0KC5GMrBHPxs+n7NqCRdJ3nkYGL00wlZ9aA01CQaCfzIEl5ak78SSI4+zJcQBvnBpwuKKrCVklhH/6Gpvil0kj7QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ERuFtmQQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9LI5XNpv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ce56UmHG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DBH4hFPy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ECA415D588;
	Tue, 26 Mar 2024 12:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711455866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=klBdcsaCF0MeM1RozflWzamTx/k4KEI7GZvYP/2DRRU=;
	b=ERuFtmQQZvi6FYnPRp+1QGAias/5wPP5CGDZbCJZYjIqhllnVXtIaPzbEldhME9fUMA2Fz
	F0GDuZioRQX079tlQ1I9Q+FlRtW//cXDwNekp+BcdtjJWs9bSRAzOhyilKD681xo+eu9yg
	QBsqfeVlc1i4Fje/3yI7TPYkWWi/8Kk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711455866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=klBdcsaCF0MeM1RozflWzamTx/k4KEI7GZvYP/2DRRU=;
	b=9LI5XNpv3YexlfZZb2Oi5AkiKETAIQBWlqa3l6QmHJQ5xTQnbl3frmLMIYme5aGCyUYdAZ
	Ao7ikofaO2oV8yBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711455865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=klBdcsaCF0MeM1RozflWzamTx/k4KEI7GZvYP/2DRRU=;
	b=ce56UmHGTJ8B91Z86yv1n9IVbL/izh3/GacrHy+GKIHsNJ3JHEF/poLw81VH6ZBRrZ9MS6
	Stli8MRGdTyrK8h0WbHJdeWVfdBo4VQGRepfbeNAxM1Mg6k4BkxN+ed0CrK7PlOWENvjvG
	GalrnONrvEGo5yNhItZFbsqmq0TMxXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711455865;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=klBdcsaCF0MeM1RozflWzamTx/k4KEI7GZvYP/2DRRU=;
	b=DBH4hFPyCiRqgG/D7x7eopyTIwjkszYl8XO7pygIkgJKuJh0CcOg/tVQxmhtT8mpg3eY8l
	ILpVhuaWuXzSvoCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D63BB13215;
	Tue, 26 Mar 2024 12:24:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id MhYLNHm+AmY/KgAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 26 Mar 2024 12:24:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6EAE4A0812; Tue, 26 Mar 2024 13:24:21 +0100 (CET)
Date: Tue, 26 Mar 2024 13:24:21 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	willy@infradead.org, bfoster@redhat.com, jack@suse.cz,
	dsterba@suse.com, mjguzik@gmail.com, dhowells@redhat.com,
	peterz@infradead.org
Subject: Re: [PATCH 2/6] writeback: support retrieving per group debug
 writeback stats of bdi
Message-ID: <20240326122421.dofl35cdtgaojt26@quack3>
References: <20240320110222.6564-1-shikemeng@huaweicloud.com>
 <20240320110222.6564-3-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320110222.6564-3-shikemeng@huaweicloud.com>
X-Spam-Score: -1.01
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,kvack.org,vger.kernel.org,infradead.org,redhat.com,suse.cz,suse.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ce56UmHG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DBH4hFPy
X-Rspamd-Queue-Id: ECA415D588

On Wed 20-03-24 19:02:18, Kemeng Shi wrote:
> Add /sys/kernel/debug/bdi/xxx/wb_stats to show per group writeback stats
> of bdi.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

...

> +unsigned long wb_calc_cg_thresh(struct bdi_writeback *wb)
> +{
> +	struct dirty_throttle_control gdtc = { GDTC_INIT_NO_WB };
> +	struct dirty_throttle_control mdtc = { MDTC_INIT(wb, &gdtc) };
> +	unsigned long filepages, headroom, writeback;
> +
> +	gdtc.avail = global_dirtyable_memory();
> +	gdtc.dirty = global_node_page_state(NR_FILE_DIRTY) +
> +		     global_node_page_state(NR_WRITEBACK);
> +
> +	mem_cgroup_wb_stats(wb, &filepages, &headroom,
> +			    &mdtc.dirty, &writeback);
> +	mdtc.dirty += writeback;
> +	mdtc_calc_avail(&mdtc, filepages, headroom);
> +	domain_dirty_limits(&mdtc);
> +
> +	return __wb_calc_thresh(&mdtc, mdtc.thresh);
> +}

I kind of wish we didn't replicate this logic from balance_dirty_pages()
and wb_over_bg_thresh() into yet another place. But the refactoring would
be kind of difficult. So OK.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

