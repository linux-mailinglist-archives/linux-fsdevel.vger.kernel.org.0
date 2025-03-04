Return-Path: <linux-fsdevel+bounces-43112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B8BA4E175
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 15:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3EC81881F80
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 14:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1176B276D3C;
	Tue,  4 Mar 2025 14:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EIrBXdyf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4lu1rqgU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2620yZ3G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WGQfANsK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74BB25DCFC
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098957; cv=none; b=tshSj6fDprRXdx8zIac7zRiFAfrLWj20Wf0aRDu/TnPw7CTRo2bIexVVr0wGSWxwt910XlojKembXhMhJ/wlh+nmPosunMgE5DzPjdOzydOS2p6QvQvQ+QCrPibuYiuyr+vIcK/Q36Ydw9pi0EOcHYDijk2oAK8xM6xQQsnZJ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098957; c=relaxed/simple;
	bh=h/Jv2Bg+zwrMEi6UloOZSsQCVI0CghmSdrAIUKv2TCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXb8INyuMOAQJF5yd/uAr9gEOSNkiwN5VwHxHiIK6abQQeMKG+epSt1u/r+bmXvj0fT+DLVSsRGTCrx9znLv2ltkOelv4YjZk1EY969vFb1FsttzDyk0NpXj1H5JhasBlFIw54zfryUXvGtaGcTTbIMvBtrz5KD0gX7cUbyLTH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EIrBXdyf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4lu1rqgU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2620yZ3G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WGQfANsK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E44781F74C;
	Tue,  4 Mar 2025 14:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741098954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r2GzlZuQCiYZqEHklmJ416V+7zdr1A6iSNiLyZDc1R4=;
	b=EIrBXdyf89Ms32ytqK+GRB1D2FNW/to7N3h1EtaSrJ8JtZx0yjutbmmJIR+e8FfBw0HJWc
	2kQH+M0yMIaS/kPpaJErTQb6luO3kGdJ+dbFKcpsEdqg4D28dcY0JaIdKdYuKQ/dhNykNF
	p04cL0UAovvoHlfxnTz64dbTwo20Bi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741098954;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r2GzlZuQCiYZqEHklmJ416V+7zdr1A6iSNiLyZDc1R4=;
	b=4lu1rqgUjx/Ps5rhwIOlXVbwKBg0UkZCpxYVdl1VwSD/C5enCLx8ENca5cKYRtY4LaK3N3
	wP9uJCXhJK0WXmCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2620yZ3G;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WGQfANsK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741098952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r2GzlZuQCiYZqEHklmJ416V+7zdr1A6iSNiLyZDc1R4=;
	b=2620yZ3G8GnJHwTkWcB34dTQH4Cn3ILl1dsqDMjSTFBdOVK6s+Ky0nyzvchnu5mQ1pXzjH
	KKVBCL8nLxXfP9ydGcEAZwRd0gR8BevdijPZc5THTwgM67nir2/Zc8TI9ZOESAbiN9IvhA
	XhvuN6qi1ExaHgqV5Pxq6j4UHz5iZQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741098952;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r2GzlZuQCiYZqEHklmJ416V+7zdr1A6iSNiLyZDc1R4=;
	b=WGQfANsKGzo4/axnvGNqT/KTsfNZooEIlTrzVRkUAQCDd9gEhxSgdEhgALtAWm+v1qyh1c
	hNWeuEtZAVJc0qDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE2AE1393C;
	Tue,  4 Mar 2025 14:35:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FvhPMsgPx2fqMwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 04 Mar 2025 14:35:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 879BFA087F; Tue,  4 Mar 2025 15:35:52 +0100 (CET)
Date: Tue, 4 Mar 2025 15:35:52 +0100
From: Jan Kara <jack@suse.cz>
To: Tang Yizhou <yizhou.tang@shopee.com>
Cc: tj@kernel.org, jack@suse.cz, brauner@kernel.org, willy@infradead.org, 
	akpm@linux-foundation.org, rostedt@goodmis.org, mhiramat@kernel.org, ast@kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 2/2] writeback: Fix calculations in
 trace_balance_dirty_pages() for cgwb
Message-ID: <rcfl3znyagtikvvzobic4hfuwzdjtrzwh3cuy4f6vbuq3emehl@2zx2bs75mszo>
References: <20250303100617.223677-1-yizhou.tang@shopee.com>
 <20250303100617.223677-3-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303100617.223677-3-yizhou.tang@shopee.com>
X-Rspamd-Queue-Id: E44781F74C
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,shopee.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Mon 03-03-25 18:06:17, Tang Yizhou wrote:
> From: Tang Yizhou <yizhou.tang@shopee.com>
> 
> In the commit dcc25ae76eb7 ("writeback: move global_dirty_limit into
> wb_domain") of the cgroup writeback backpressure propagation patchset,
> Tejun made some adaptations to trace_balance_dirty_pages() for cgroup
> writeback. However, this adaptation was incomplete and Tejun missed
> further adaptation in the subsequent patches.
> 
> In the cgroup writeback scenario, if sdtc in balance_dirty_pages() is
> assigned to mdtc, then upon entering trace_balance_dirty_pages(),
> __entry->limit should be assigned based on the dirty_limit of the
> corresponding memcg's wb_domain, rather than global_wb_domain.
> 
> To address this issue and simplify the implementation, introduce a 'limit'
> field in struct dirty_throttle_control to store the hard_limit value
> computed in wb_position_ratio() by calling hard_dirty_limit(). This field
> will then be used in trace_balance_dirty_pages() to assign the value to
> __entry->limit.
> 
> Fixes: dcc25ae76eb7 ("writeback: move global_dirty_limit into wb_domain")
> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>

In principle this looks fine but one nit below:

> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index 32095928365c..58bda3347914 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -326,6 +326,7 @@ struct dirty_throttle_control {
>  	unsigned long		dirty;		/* file_dirty + write + nfs */
>  	unsigned long		thresh;		/* dirty threshold */
>  	unsigned long		bg_thresh;	/* dirty background threshold */
> +	unsigned long		limit;		/* hard dirty limit */
				^^^ I'd call this dirty_limit to not invent
a new name for the same thing. I've noticed the tracepoint has 'limit' as
well but that is the outlier that should be modified if anything. Also I'd
modify the comment to /* smoothed dirty limit */ to better explain what
this is about.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

