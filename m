Return-Path: <linux-fsdevel+bounces-59969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F42B3FCE4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 12:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707DD205293
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 10:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180422F39C2;
	Tue,  2 Sep 2025 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QRUmkwpA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TUsTzDZr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kGyDGDDi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gyxnb/K8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B2D2F3618
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 10:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809765; cv=none; b=l/FsgFmr6yLi8omfRakFQB3DzoUZwOw1gVw84JAM2M/exbsZv/U7ZQom57B4Y+JSGuFxCl4UNMwRufe+ADoQAlfAg2bfE2vaO3bLRRQ3eXmLpZT8JrqRwR4TBvpAI9BRmijZ5vY+p3d5rLnFhO3w3GZQoBBnPj2c8SjLG0VRhSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809765; c=relaxed/simple;
	bh=F6eAwz/5m4+tyz35hgcJKDY+nEXDCRTCv8gcsrfL870=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGKaefmiy33zCWLQ0YKJ71ZC6DMUfd6AahhZqRfdGNTPzMTMdoym02wOd2kHEAixm+ilwOQ0avrgPREEZPuFigXZhhXex+Dw0aVtNzvwMvaM3ybVOZilZLIy1t5iRIUSWcZ9bWzTQI4Myv2q57F7j5PGSbIaEDrpVJhj4WgQgR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QRUmkwpA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TUsTzDZr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kGyDGDDi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gyxnb/K8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E9A1E1F453;
	Tue,  2 Sep 2025 10:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756809762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k3zSePqDAkVqyg+t6w7RTiow9puJpMOh9QC/ozrDcc0=;
	b=QRUmkwpArdhTbNMW+Io/jMFV4GENVLwP5OHktiXSjl/Ix2NbYJ9TeSV5VyqEPd6TSXyj0P
	Bcc+H1TEvhq+wfhDIVWlzoBBwW97Alwbp1QJLDuqGihyYfWbRLDfjGJ4F44dQBjviGnP6z
	AcBQ5gaDyFoeif4IryqBICTRHB9CXDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756809762;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k3zSePqDAkVqyg+t6w7RTiow9puJpMOh9QC/ozrDcc0=;
	b=TUsTzDZrR69YtKKGNv1RU1qMGCsg4wLk1eA63bMaUlLDeDLntI7Mjg45Grtcmtws3qxrrK
	S1LON5SOoNptTrDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756809761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k3zSePqDAkVqyg+t6w7RTiow9puJpMOh9QC/ozrDcc0=;
	b=kGyDGDDiP05lJDLmtyi69PtDMbNE+Kd3vh76dgUH+c8oALJYaj4TlfqtEG5lcTlvNjDTUJ
	bh9uWraEvnMG1z5yGw3QiwbPybEJuk/t++v2WZ01Gpc9Ljq2/ZoF8SZGeqQ90yo6fFqQ8B
	igBA6sXj+xguQIHpiLao++P/lUTtuio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756809761;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k3zSePqDAkVqyg+t6w7RTiow9puJpMOh9QC/ozrDcc0=;
	b=gyxnb/K8sQWXU2NS6ZcuZPBsUksMD1bPeddgYsEo2pCSweSudePJn2vKYmIKLqP7ENJkGy
	GSMzfA0XnTC/a2DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAD3913888;
	Tue,  2 Sep 2025 10:42:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4o5nNSHKtmgcJQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 02 Sep 2025 10:42:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 956B3A0A9F; Tue,  2 Sep 2025 12:42:41 +0200 (CEST)
Date: Tue, 2 Sep 2025 12:42:41 +0200
From: Jan Kara <jack@suse.cz>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com, 
	yuanchu@google.com, willy@infradead.org, hughd@google.com, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	vishal.moola@gmail.com, linux@armlinux.org.uk, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, davem@davemloft.net, andreas@gaisler.com, 
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, chris@zankel.net, 
	jcmvbkbc@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	weixugc@google.com, baolin.wang@linux.alibaba.com, rientjes@google.com, 
	shakeel.butt@linux.dev, thuth@redhat.com, broonie@kernel.org, osalvador@suse.de, 
	jfalempe@redhat.com, mpe@ellerman.id.au, nysal@linux.ibm.com, 
	linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 04/12] fs: constify mapping related test functions for
 improved const-correctness
Message-ID: <xn6tybxhnrswd5wnhfkt4h2n7romogag2ls7ehzte4r2oxoe6u@4pa7726gzcgj>
References: <20250901205021.3573313-1-max.kellermann@ionos.com>
 <20250901205021.3573313-5-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901205021.3573313-5-max.kellermann@ionos.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,redhat.com,google.com,infradead.org,suse.com,vger.kernel.org,kvack.org,oracle.com,suse.cz,kernel.org,gmail.com,armlinux.org.uk,hansenpartnership.com,gmx.de,linux.ibm.com,davemloft.net,gaisler.com,linux.intel.com,linutronix.de,alien8.de,zytor.com,zankel.net,zeniv.linux.org.uk,linux.alibaba.com,linux.dev,suse.de,ellerman.id.au,lists.infradead.org];
	R_RATELIMIT(0.00)[to_ip_from(RLyerg7kx5bdf6cnfzf33td54o)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[55];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Mon 01-09-25 22:50:13, Max Kellermann wrote:
> We select certain test functions which either invoke each other,
> functions that are already const-ified, or no further functions.
> 
> It is therefore relatively trivial to const-ify them, which
> provides a basis for further const-ification further up the call
> stack.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3b9f54446db0..0b43edb33be2 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -537,7 +537,7 @@ struct address_space {
>  /*
>   * Returns true if any of the pages in the mapping are marked with the tag.
>   */
> -static inline bool mapping_tagged(struct address_space *mapping, xa_mark_t tag)
> +static inline bool mapping_tagged(const struct address_space *mapping, xa_mark_t tag)
>  {
>  	return xa_marked(&mapping->i_pages, tag);
>  }
> @@ -585,7 +585,7 @@ static inline void i_mmap_assert_write_locked(struct address_space *mapping)
>  /*
>   * Might pages of this file be mapped into userspace?
>   */
> -static inline int mapping_mapped(struct address_space *mapping)
> +static inline int mapping_mapped(const struct address_space *mapping)
>  {
>  	return	!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root);
>  }
> @@ -599,7 +599,7 @@ static inline int mapping_mapped(struct address_space *mapping)
>   * If i_mmap_writable is negative, no new writable mappings are allowed. You
>   * can only deny writable mappings, if none exists right now.
>   */
> -static inline int mapping_writably_mapped(struct address_space *mapping)
> +static inline int mapping_writably_mapped(const struct address_space *mapping)
>  {
>  	return atomic_read(&mapping->i_mmap_writable) > 0;
>  }
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

