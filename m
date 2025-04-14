Return-Path: <linux-fsdevel+bounces-46382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607F5A884A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 16:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640F85638E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 14:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1A42957A4;
	Mon, 14 Apr 2025 13:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wzXiY1yE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jkmHq+hM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zSCtMWf+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5g0P9LPk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21B02951BC
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744638942; cv=none; b=oVdgz5ipCzEbU9orF0VZC+LsN1kWlhshSd1hAPYOSk62YcJlp4IvXRtb8W02J403vFe3vimtR2Ebf3XWOL5wBtdieIqPRHmxCs19131xvUepdQgWtPuCnNboP+mJxWzZxMNPcmM7hw+rPegFjLRhsruIhnAulqBMTTiysNrON2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744638942; c=relaxed/simple;
	bh=a4hlPrIYJB25n8qz1/wfGkCt/0deEqN0QH2FcphhDOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQcrNdChRoiocf9RBkSyWuTB0bYRkwwowlNZZSTmr1w4R1K6WLV75i7t7qFt6zlwD2/zPNsYxpr9Vj2FfL9dfkKAda5crvRburAD5OcWvZe/5ttBG/8EbCM+IXXqu0CsSjzD1w+Yzf7jzglQJX1UNUiH5hHbUvSJ/YAYQ53mvBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wzXiY1yE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jkmHq+hM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zSCtMWf+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5g0P9LPk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D03E621285;
	Mon, 14 Apr 2025 13:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744638938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wbd2u8etanLwCgjaIHVqyALGaQfIGhfcAWH4/UjSTEE=;
	b=wzXiY1yEB95AiDyYGkUPUatZ9ka1UIFfMtbMDujew0olVoBozXiZR3IXuiJaYyAvTjqlkc
	ffGO0f94WvOSs/xcQoqqwApb+2SFKirTk29CUyFmKop8kdxjcmc3pzRGesjisa0WgoxfaZ
	0rHYasaNyE+Uho7MFybleatnaoJMeIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744638938;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wbd2u8etanLwCgjaIHVqyALGaQfIGhfcAWH4/UjSTEE=;
	b=jkmHq+hMZAS6lbShgn5oI5j2rUY6ilru8Ar/+qf2J/hXF7S/O+HZ0feC98biWPQbQT+wK1
	fMAigSvixFRWXpCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zSCtMWf+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5g0P9LPk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744638937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wbd2u8etanLwCgjaIHVqyALGaQfIGhfcAWH4/UjSTEE=;
	b=zSCtMWf+wT1fhUG+omccUMiztbWCX65tCmfZiXn1TU+piEb0fdPM+SItvg8fOrkVI0Qq++
	Be0wOFSqxXG5UMI1MZngpKytcvPQh/1jx+xBIlQZ1ne6UCR9FAKpM9zEiu217v4Zm7gJ6Y
	ogSV1GoNG5p2rvylUQsyVrIv8323Wok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744638937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wbd2u8etanLwCgjaIHVqyALGaQfIGhfcAWH4/UjSTEE=;
	b=5g0P9LPkS3R44MdBt8w2sXAG2b9UySsrKbbDHxg+/Y0huVTFxkB/9YYICVCkJ9SnLorJps
	3UKyAVMmijCpgYCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C597B136A7;
	Mon, 14 Apr 2025 13:55:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Edo1MNkT/WcYBwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Apr 2025 13:55:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 67CC0A094B; Mon, 14 Apr 2025 15:55:37 +0200 (CEST)
Date: Mon, 14 Apr 2025 15:55:37 +0200
From: Jan Kara <jack@suse.cz>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cgroups@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Rafael Aquini <aquini@redhat.com>, gfs2@lists.linux.dev, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 2/2] writeback: Fix false warning in inode_to_wb()
Message-ID: <6k6kbrcw5bythxn7xu2u7xm4ssaiprnzr42qmf2oqyd6igdoy7@cyv67iatitvq>
References: <20250412163914.3773459-1-agruenba@redhat.com>
 <20250412163914.3773459-3-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412163914.3773459-3-agruenba@redhat.com>
X-Rspamd-Queue-Id: D03E621285
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
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi Andrew!

Can you please take this patch through MM tree? Thanks! Andreas is already
taking the first patch in the series through GFS2 tree.

								Honza

On Sat 12-04-25 18:39:12, Andreas Gruenbacher wrote:
> From: Jan Kara <jack@suse.cz>
> 
> inode_to_wb() is used also for filesystems that don't support cgroup
> writeback. For these filesystems inode->i_wb is stable during the
> lifetime of the inode (it points to bdi->wb) and there's no need to hold
> locks protecting the inode->i_wb dereference. Improve the warning in
> inode_to_wb() to not trigger for these filesystems.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  include/linux/backing-dev.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index 8e7af9a03b41..e721148c95d0 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -249,6 +249,7 @@ static inline struct bdi_writeback *inode_to_wb(const struct inode *inode)
>  {
>  #ifdef CONFIG_LOCKDEP
>  	WARN_ON_ONCE(debug_locks &&
> +		     (inode->i_sb->s_iflags & SB_I_CGROUPWB) &&
>  		     (!lockdep_is_held(&inode->i_lock) &&
>  		      !lockdep_is_held(&inode->i_mapping->i_pages.xa_lock) &&
>  		      !lockdep_is_held(&inode->i_wb->list_lock)));
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

