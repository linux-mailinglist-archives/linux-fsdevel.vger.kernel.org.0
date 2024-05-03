Return-Path: <linux-fsdevel+bounces-18582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C468BA9E6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 11:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C612A1C20DDC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 09:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA6514F13C;
	Fri,  3 May 2024 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cbzLyPgo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XgIjjsSu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cbzLyPgo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XgIjjsSu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EED14D71C;
	Fri,  3 May 2024 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714728667; cv=none; b=rppCBpCr1569TuC5Vmqp7jhCNPTb1Y0FrQNPOGWN6ddZV0bOuZbxOusly878s0NU98GkLnZYEdLtdHJ2AJwWuJHQEWIabMzZsI7sCAuCBJnpmuDhykOt7nzVeiQK9hbqKryoudl1H9H6vK3upiMssjCH0E+UjO9S/1YnrzmNk9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714728667; c=relaxed/simple;
	bh=wJIZh83rMzueHumkKe/YrmO3iYYtY+7wMMt4A5jr+hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrRhQiuoNYUP5vjw4YOvFieZB+Z7isJVNZHslCslI+GdAjuB/LeDfoqsvF5I4+uU5mMayvVdVY5D5IiH9d9w8tj0cZ+JsiCNroyhzKdNQwbMgrFD7dWsUl4QLvziYi3QGbdQ7xjhW09g0hIWFy4PU3uKhfDupxNRX7wa6qMk/2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cbzLyPgo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XgIjjsSu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cbzLyPgo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XgIjjsSu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC78E22398;
	Fri,  3 May 2024 09:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714728660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dJxohtrBKRpaNpkwWLIS75cauTsED9rnDxgq1rWa2Lk=;
	b=cbzLyPgotGC1W52Cn5O3pysHF04zQu6T3npjdTiGxIFx/VNjIVy1/ZfE9PUzWRV2Xsz6yF
	B8l4g+iyjZ27ntIR1TzeO2UWub+XWSdFEI7dbi/j1yrsxVGG2AYcoHxwMfd0exeCfHFFMl
	H7PPrNQfdZo+qHVct8CYYkDlQkTRct4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714728660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dJxohtrBKRpaNpkwWLIS75cauTsED9rnDxgq1rWa2Lk=;
	b=XgIjjsSuyVQISQJwsdTcl1u28ed6TKdUp+FFcAMmIDc2SlN6gGIGDP7CPzQMVAdevr/VYn
	Yjv0Wom/CuLUB7Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714728660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dJxohtrBKRpaNpkwWLIS75cauTsED9rnDxgq1rWa2Lk=;
	b=cbzLyPgotGC1W52Cn5O3pysHF04zQu6T3npjdTiGxIFx/VNjIVy1/ZfE9PUzWRV2Xsz6yF
	B8l4g+iyjZ27ntIR1TzeO2UWub+XWSdFEI7dbi/j1yrsxVGG2AYcoHxwMfd0exeCfHFFMl
	H7PPrNQfdZo+qHVct8CYYkDlQkTRct4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714728660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dJxohtrBKRpaNpkwWLIS75cauTsED9rnDxgq1rWa2Lk=;
	b=XgIjjsSuyVQISQJwsdTcl1u28ed6TKdUp+FFcAMmIDc2SlN6gGIGDP7CPzQMVAdevr/VYn
	Yjv0Wom/CuLUB7Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C5E0139CB;
	Fri,  3 May 2024 09:31:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y+LrJdSuNGaDMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 03 May 2024 09:31:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 41951A0A12; Fri,  3 May 2024 11:30:56 +0200 (CEST)
Date: Fri, 3 May 2024 11:30:56 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, tj@kernel.org,
	jack@suse.cz, hcochran@kernelspring.com, axboe@kernel.dk,
	mszeredi@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] mm: correct calculation of wb's bg_thresh in
 cgroup domain
Message-ID: <20240503093056.6povgn2shvqzpedj@quack3>
References: <20240425131724.36778-1-shikemeng@huaweicloud.com>
 <20240425131724.36778-3-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425131724.36778-3-shikemeng@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Thu 25-04-24 21:17:22, Kemeng Shi wrote:
> The wb_calc_thresh is supposed to calculate wb's share of bg_thresh in
> global domain. To calculate wb's share of bg_thresh in cgroup domain,
> it's more reasonable to use __wb_calc_thresh in which way we calculate
> dirty_thresh in cgroup domain in balance_dirty_pages().
> 
> Consider following domain hierarchy:
>                 global domain (> 20G)
>                 /                 \
>         cgroup domain1(10G)     cgroup domain2(10G)
>                 |                 |
> bdi            wb1               wb2
> Assume wb1 and wb2 has the same bandwidth.
> We have global domain bg_thresh > 2G, cgroup domain bg_thresh 1G.
> Then we have:
> wb's thresh in global domain = 2G * (wb bandwidth) / (system bandwidth)
> = 2G * 1/2 = 1G
> wb's thresh in cgroup domain = 1G * (wb bandwidth) / (system bandwidth)
> = 1G * 1/2 = 0.5G
> At last, wb1 and wb2 will be limited at 0.5G, the system will be limited
> at 1G which is less than global domain bg_thresh 2G.

This was a bit hard to understand for me so I'd rephrase it as:

wb_calc_thresh() is calculating wb's share of bg_thresh in the global
domain. However in case of cgroup writeback this is not the right thing to
do. Consider the following domain hierarchy:

                global domain (> 20G)
                /                 \
          cgroup1 (10G)     cgroup2 (10G)
                |                 |
bdi            wb1               wb2

and assume wb1 and wb2 have the same bandwidth and the background threshold
is set at 10%. The bg_thresh of cgroup1 and cgroup2 is going to be 1G. Now
because wb_calc_thresh(mdtc->wb, mdtc->bg_thresh) calculates per-wb
threshold in the global domain as (wb bandwidth) / (domain bandwidth) it
returns bg_thresh for wb1 as 0.5G although it has nobody to compete against
in cgroup1.

Fix the problem by calculating wb's share of bg_thresh in the cgroup
domain.

> Test as following:
> /* make it easier to observe the issue */
> echo 300000 > /proc/sys/vm/dirty_expire_centisecs
> echo 100 > /proc/sys/vm/dirty_writeback_centisecs
> 
> /* run fio in wb1 */
> cd /sys/fs/cgroup
> echo "+memory +io" > cgroup.subtree_control
> mkdir group1
> cd group1
> echo 10G > memory.high
> echo 10G > memory.max
> echo $$ > cgroup.procs
> mkfs.ext4 -F /dev/vdb
> mount /dev/vdb /bdi1/
> fio -name test -filename=/bdi1/file -size=600M -ioengine=libaio -bs=4K \
> -iodepth=1 -rw=write -direct=0 --time_based -runtime=600 -invalidate=0
> 
> /* run fio in wb2 with a new shell */
> cd /sys/fs/cgroup
> mkdir group2
> cd group2
> echo 10G > memory.high
> echo 10G > memory.max
> echo $$ > cgroup.procs
> mkfs.ext4 -F /dev/vdc
> mount /dev/vdc /bdi2/
> fio -name test -filename=/bdi2/file -size=600M -ioengine=libaio -bs=4K \
> -iodepth=1 -rw=write -direct=0 --time_based -runtime=600 -invalidate=0
> 
> Before fix, the wrttien pages of wb1 and wb2 reported from
> toos/writeback/wb_monitor.py keep growing. After fix, rare written pages
> are accumulated.
> There is no obvious change in fio result.
> 
> Fixes: 74d369443325 ("writeback: Fix performance regression in wb_over_bg_thresh()")
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Besides the changelog rephrasing the change looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 2a3b68aae336..14893b20d38c 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2137,7 +2137,7 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
>  		if (mdtc->dirty > mdtc->bg_thresh)
>  			return true;
>  
> -		thresh = wb_calc_thresh(mdtc->wb, mdtc->bg_thresh);
> +		thresh = __wb_calc_thresh(mdtc, mdtc->bg_thresh);
>  		if (thresh < 2 * wb_stat_error())
>  			reclaimable = wb_stat_sum(wb, WB_RECLAIMABLE);
>  		else
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

