Return-Path: <linux-fsdevel+bounces-48941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6B6AB6641
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 10:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F1B3B9E3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 08:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD9C21D3F8;
	Wed, 14 May 2025 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EM817J41";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S2RHoIpf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EM817J41";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S2RHoIpf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E01D1F4198
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747212177; cv=none; b=lwLwPYJTMpPLP84283q8wSA6+pWQgvxgDbC6cmEVehM4TDxZ/ggOHoYmLMemZrUHLL2A2TviatsZzcY3CiRWfVHZ4iG2CGHdcvLZ5wfvvzxNFjjw761zwKBT65PRVSWTuAL89nKyvdrMKl0FmuGLb3XDuH5sDRPmLmqcTvpJA+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747212177; c=relaxed/simple;
	bh=bqjgnHUyakl14wf4lZ73PvGY30zk4UGw4WxbAl6/FJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l3eGrSlyS3PIez+zUUMI79QxSObUxj4PdUEBkzsyJFHPGzYHjGgQS7OMzJnqy9JZ8eohWxhrGd0EVeDwdOb2dkt7uUn0EleTiYksDQkdoLSUP14dJhKN1Q3Nb+XhzF0hD2tViR+3p/trWvKb+m5X8rOP5Kpbae72SDPDVHRvx5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EM817J41; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S2RHoIpf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EM817J41; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S2RHoIpf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0A3491F455;
	Wed, 14 May 2025 08:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747212174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1FbF+Wu5BwPi1Q4aa0n9TwfSaL1ITYGfgENgvKSYJA=;
	b=EM817J41l5zCpjziTvzKgAMz50LMPCs5af/ZZ0XFYGwCxpUJ2Mn7pDiLUe0QF+8ObVGLpt
	IHRm/mVeMX7jDdQlwr72W/WIT4WTlRF0oeyPnG6urIBYMAlK2a5E9ftu3NJRbs4yYOMad8
	XYh8GjH0hziI4ppeDzBwmko93HRCvz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747212174;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1FbF+Wu5BwPi1Q4aa0n9TwfSaL1ITYGfgENgvKSYJA=;
	b=S2RHoIpf+Ys0M9rSxNq/GblIqvxe4I++lFrQ1jdKmwWuvcxulv4DkNj4fLWg0z6sWZ+IUZ
	PpRV8kWh0b8lqeDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EM817J41;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=S2RHoIpf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747212174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1FbF+Wu5BwPi1Q4aa0n9TwfSaL1ITYGfgENgvKSYJA=;
	b=EM817J41l5zCpjziTvzKgAMz50LMPCs5af/ZZ0XFYGwCxpUJ2Mn7pDiLUe0QF+8ObVGLpt
	IHRm/mVeMX7jDdQlwr72W/WIT4WTlRF0oeyPnG6urIBYMAlK2a5E9ftu3NJRbs4yYOMad8
	XYh8GjH0hziI4ppeDzBwmko93HRCvz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747212174;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1FbF+Wu5BwPi1Q4aa0n9TwfSaL1ITYGfgENgvKSYJA=;
	b=S2RHoIpf+Ys0M9rSxNq/GblIqvxe4I++lFrQ1jdKmwWuvcxulv4DkNj4fLWg0z6sWZ+IUZ
	PpRV8kWh0b8lqeDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD0C1137E8;
	Wed, 14 May 2025 08:42:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OPOlNY1XJGiIGQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 14 May 2025 08:42:53 +0000
Message-ID: <9b5d232e-7579-42a9-bcbe-a4674bf76fe4@suse.cz>
Date: Wed, 14 May 2025 10:42:53 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: remove WARN_ON_ONCE() in file_has_valid_mmap_hooks()
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>
References: <20250514084024.29148-1-lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250514084024.29148-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 0A3491F455
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,oracle.com:email,intel.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51

On 5/14/25 10:40, Lorenzo Stoakes wrote:
> Having encountered a trinity report in linux-next (Linked in the 'Closes'
> tag) it appears that there are legitimate situations where a file-backed
> mapping can be acquired but no file->f_op->mmap or file->f_op->mmap_prepare
> is set, at which point do_mmap() should simply error out with -ENODEV.
> 
> Since previously we did not warn in this scenario and it appears we rely
> upon this, restore this situation, while retaining a WARN_ON_ONCE() for the
> case where both are set, which is absolutely incorrect and must be
> addressed and thus always requires a warning.
> 
> If further work is required to chase down precisely what is causing this,
> then we can later restore this, but it makes no sense to hold up this
> series to do so, as this is existing and apparently expected behaviour.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202505141434.96ce5e5d-lkp@intel.com
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
> 
> Andrew -
> 
> Since this series is in mm-stable we should take this fix there asap (and
> certainly get it to -next to fix any further error reports). I didn't know
> whether it was best for it to be a fix-patch or not, so have sent
> separately so you can best determine what to do with it :)
> 
> Thanks, Lorenzo
> 
>  include/linux/fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e2721a1ff13d..09c8495dacdb 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2248,7 +2248,7 @@ static inline bool file_has_valid_mmap_hooks(struct file *file)
>  	/* Hooks are mutually exclusive. */
>  	if (WARN_ON_ONCE(has_mmap && has_mmap_prepare))
>  		return false;
> -	if (WARN_ON_ONCE(!has_mmap && !has_mmap_prepare))
> +	if (!has_mmap && !has_mmap_prepare)
>  		return false;
> 
>  	return true;
> --
> 2.49.0


