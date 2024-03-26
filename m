Return-Path: <linux-fsdevel+bounces-15319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEF688C211
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 13:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB57A1F3B18F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 12:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8BC71B5D;
	Tue, 26 Mar 2024 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D+o9bill";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZvTfHubG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D+o9bill";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZvTfHubG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091A270CDA;
	Tue, 26 Mar 2024 12:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456027; cv=none; b=dONurWusw9A+RnU2Uzt3r3GEKIrkyyfWz+F2VSBQMHkkcFlvLYxCzH2QMQ+koIzzPndYKNgNySlksQVWc66mMvqMnVvb+h7FZWnpRZIAB+nW10XB4Mqp8mO68rXoB9EcgRVHFpGplrRviJOm91LwDrYt4Ew4SyCSaoCA9d/VvYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456027; c=relaxed/simple;
	bh=P5Og5SVif/TazRx1gfTuoFOFWCG/IMdoSqQLR9EiIgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNoMBHlSJ1yvVMvc1xpGS3oFbvRquCrzGqq73ql2/Zr3sqpYgGSCHk+StnWcVTcTnaxVSrVgV6SKe2YGxzISEFeBF4ICOEwLjqf+HmPf1XFoDCRzDDO/AIGbS9w9MS8ulxHXsjaAHjRDVO/ZssPOIu1k/Va0zUmhidK7T0wP1GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D+o9bill; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZvTfHubG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D+o9bill; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZvTfHubG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 04A8037B8F;
	Tue, 26 Mar 2024 12:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711456022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o+FQk8Pfj6cNE8lfvdU6/qaSkPWg47A6HFY6eoUrykg=;
	b=D+o9billZjoMb/3DAYk8EBB31dPuuDphmyr2L+GWn7WHdwMKOVYPHni2IO1Rw3nWFgc8MP
	wUrfV6KU4HFYM8p785OVesLYyXLPXC+u5DsZCLnZZMpBEmCFDUkblIyKpu78m+j4yuh/CD
	x1RgJNHlAgTiXmCAFPnGl81QtTH8Mmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711456022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o+FQk8Pfj6cNE8lfvdU6/qaSkPWg47A6HFY6eoUrykg=;
	b=ZvTfHubGqrrgvVGEZTBZZycn4bhL8WQ4uuoiaUU2nuB2P7HV4ZZ6qR82ofs9HA9C2ZyelO
	z4ZrUUzG0RMHNeCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711456022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o+FQk8Pfj6cNE8lfvdU6/qaSkPWg47A6HFY6eoUrykg=;
	b=D+o9billZjoMb/3DAYk8EBB31dPuuDphmyr2L+GWn7WHdwMKOVYPHni2IO1Rw3nWFgc8MP
	wUrfV6KU4HFYM8p785OVesLYyXLPXC+u5DsZCLnZZMpBEmCFDUkblIyKpu78m+j4yuh/CD
	x1RgJNHlAgTiXmCAFPnGl81QtTH8Mmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711456022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o+FQk8Pfj6cNE8lfvdU6/qaSkPWg47A6HFY6eoUrykg=;
	b=ZvTfHubGqrrgvVGEZTBZZycn4bhL8WQ4uuoiaUU2nuB2P7HV4ZZ6qR82ofs9HA9C2ZyelO
	z4ZrUUzG0RMHNeCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EF6C113215;
	Tue, 26 Mar 2024 12:27:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id rT5yOhW/AmbDKgAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 26 Mar 2024 12:27:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B0080A0812; Tue, 26 Mar 2024 13:27:01 +0100 (CET)
Date: Tue, 26 Mar 2024 13:27:01 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	willy@infradead.org, bfoster@redhat.com, jack@suse.cz,
	dsterba@suse.com, mjguzik@gmail.com, dhowells@redhat.com,
	peterz@infradead.org
Subject: Re: [PATCH 5/6] writeback: rename nr_reclaimable to nr_dirty in
 balance_dirty_pages
Message-ID: <20240326122701.e32op43zxuowjvgj@quack3>
References: <20240320110222.6564-1-shikemeng@huaweicloud.com>
 <20240320110222.6564-6-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320110222.6564-6-shikemeng@huaweicloud.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.47
X-Spamd-Result: default: False [-0.47 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(0.33)[71.13%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,kvack.org,vger.kernel.org,infradead.org,redhat.com,suse.cz,suse.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On Wed 20-03-24 19:02:21, Kemeng Shi wrote:
> Commit 8d92890bd6b85 ("mm/writeback: discard NR_UNSTABLE_NFS, use
> NR_WRITEBACK instead") removed NR_UNSTABLE_NFS and nr_reclaimable
> only contains dirty page now.
> Rename nr_reclaimable to nr_dirty properly.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index ba1b6b5ae5d6..481b6bf34c21 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -1695,7 +1695,7 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
>  	struct dirty_throttle_control * const mdtc = mdtc_valid(&mdtc_stor) ?
>  						     &mdtc_stor : NULL;
>  	struct dirty_throttle_control *sdtc;
> -	unsigned long nr_reclaimable;	/* = file_dirty */
> +	unsigned long nr_dirty;
>  	long period;
>  	long pause;
>  	long max_pause;
> @@ -1716,9 +1716,9 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
>  		unsigned long m_thresh = 0;
>  		unsigned long m_bg_thresh = 0;
>  
> -		nr_reclaimable = global_node_page_state(NR_FILE_DIRTY);
> +		nr_dirty = global_node_page_state(NR_FILE_DIRTY);
>  		gdtc->avail = global_dirtyable_memory();
> -		gdtc->dirty = nr_reclaimable + global_node_page_state(NR_WRITEBACK);
> +		gdtc->dirty = nr_dirty + global_node_page_state(NR_WRITEBACK);
>  
>  		domain_dirty_limits(gdtc);
>  
> @@ -1769,7 +1769,7 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
>  		 * In normal mode, we start background writeout at the lower
>  		 * background_thresh, to keep the amount of dirty memory low.
>  		 */
> -		if (!laptop_mode && nr_reclaimable > gdtc->bg_thresh &&
> +		if (!laptop_mode && nr_dirty > gdtc->bg_thresh &&
>  		    !writeback_in_progress(wb))
>  			wb_start_background_writeback(wb);
>  
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

