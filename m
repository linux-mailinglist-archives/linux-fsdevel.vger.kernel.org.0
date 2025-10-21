Return-Path: <linux-fsdevel+bounces-64909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC98BF661B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D01D8505BBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2183314D9;
	Tue, 21 Oct 2025 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1At4+x7R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5zWlszzI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BxLuJ7ps";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sLWuz3DI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD94C32E754
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 12:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761048724; cv=none; b=R+58TzACe6NvIhWmrXLRJASl+6Qot5QX3q6hCPcrAbZm8h3mHa3DqApPK2Ea8a0EpV6+lue+i7kTMDbr0P8Vj+S//AM7hqgysMiyJfDNlhYKaAv8c4YeH50D/XJoeoio03neNjt6CaKh839GjmXny6iUxAScBU8TFB+iQqWTIPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761048724; c=relaxed/simple;
	bh=j2cX40cn6Yv2K2+uDsZW4eAcfe1Y23bjcEDu5ltrUIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dY8lBjL1r6N80BjiZ91pD4i30cG4rVUlgufs63nvcMa5PjXygylcXbw+zKpxqXv+aACStl5uNMDlHsqD9K5p4bnsNj7f2sWbXhY8GAszuEQE/p+k+gPlgVKmJrgmxeMo9on4G6q1P310iioiC4V/jroD+kr+vVKe9cR7mwIAW9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1At4+x7R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5zWlszzI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BxLuJ7ps; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sLWuz3DI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DFCB61F449;
	Tue, 21 Oct 2025 12:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761048716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RwFREZndxsLQgEOojxw0ePiYGHl5h5o9l6t4QJAq490=;
	b=1At4+x7RUQX3DhyB+qyxSOIRvgZOdQDNb7FGLNTIAPVEHvE16pzIodPz9SZb5n++keS4hC
	ETbw7DLdFE9/ZWUCZufVR68+CMYqESgc7VnA+PfTni1W6+P+y2MFUOR8eGpWy8XmXKbRRg
	sGgLNDoe+JWyCItjD1f5DC9ldUdkq0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761048716;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RwFREZndxsLQgEOojxw0ePiYGHl5h5o9l6t4QJAq490=;
	b=5zWlszzICLEmgZyDBbbLJfNDAG3GGDOTSvp3RGR9rZ3qNfZ+iwMKswINJWZ73qbk6aamz+
	kG5TvvaQGZGJBVDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761048711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RwFREZndxsLQgEOojxw0ePiYGHl5h5o9l6t4QJAq490=;
	b=BxLuJ7psEhbrdLUyRYzObCBehqf5I73VS69CwdWanYIV+F4T1CcQv2fTKB+m/0ryGctw8/
	G7rAwn50A+PF6Ci56o+PmZEWVDwANKAU2dJ/XnnmPQb91tQjKvUaLlcReW+dJY/st4uHY4
	QVWgtOqzbwkq0rqZRUwFpFIF2MChLXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761048711;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RwFREZndxsLQgEOojxw0ePiYGHl5h5o9l6t4QJAq490=;
	b=sLWuz3DITIDFEo2otIwSc54F2tb8TtJXbMNwWElucdMWEjlkuTF9VhSRmGK3Wr7g/OaS2J
	bJx2o3ShC4GOYPDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1658139D8;
	Tue, 21 Oct 2025 12:11:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ccUdM4d492iSaAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Oct 2025 12:11:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6211BA0990; Tue, 21 Oct 2025 14:11:47 +0200 (CEST)
Date: Tue, 21 Oct 2025 14:11:47 +0200
From: Jan Kara <jack@suse.cz>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: Dave Chinner <david@fromorbit.com>, jaegeuk@kernel.org, 
	chao@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	miklos@szeredi.hu, agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org, 
	akpm@linux-foundation.org, willy@infradead.org, mcgrof@kernel.org, clm@meta.com, 
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com, 
	djwong@kernel.org, dave@stgolabs.net, wangyufei@vivo.com, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com, anuj20.g@samsung.com, 
	vishak.g@samsung.com, joshi.k@samsung.com
Subject: Re: [PATCH v2 00/16] Parallelizing filesystem writeback
Message-ID: <bfpv6jrjo4avzk76ex77dwpzaejglu5gsf2pqpmmgwrmqdkkk3@imsbtnrcelee>
References: <CGME20251014120958epcas5p267c3c9f9dbe6ffc53c25755327de89f9@epcas5p2.samsung.com>
 <20251014120845.2361-1-kundan.kumar@samsung.com>
 <aPa7xozr7YbZX0W4@dread.disaster.area>
 <6fe26b74-beb9-4a6a-93af-86edcbde7b68@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fe26b74-beb9-4a6a-93af-86edcbde7b68@samsung.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RLkd9wktknm683nrx6wbi4qz63)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[fromorbit.com,kernel.org,zeniv.linux.org.uk,suse.cz,szeredi.hu,redhat.com,linux-foundation.org,infradead.org,meta.com,gmail.com,kernel.dk,lst.de,stgolabs.net,vivo.com,lists.sourceforge.net,vger.kernel.org,lists.linux.dev,kvack.org,samsung.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 

On Tue 21-10-25 16:06:22, Kundan Kumar wrote:
> Previous results of fragmentation were taken with randwrite. I took
> fresh data for sequential IO and here are the results.
> number of extents reduces a lot for seq IO:
>    A) Workload 6 files each 1G in single directory(AG)   - numjobs = 1
>          Base XFS                : 1
>          Parallel Writeback XFS  : 1
> 
>    B) Workload 12 files each of 1G to 12 directories(AGs)- numjobs = 12
>          Base XFS                : 4
>          Parallel Writeback XFS  : 3
> 
>    C) Workload 6 files each of 20G to 6 directories(AGs) - numjobs = 6
>          Base XFS                : 4
>          Parallel Writeback XFS  : 4

Thanks for sharing details! I'm curious: how big differences in throughput
did you see between normal and parallel writeback with sequential writes?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

