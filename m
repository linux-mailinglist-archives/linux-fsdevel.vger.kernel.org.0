Return-Path: <linux-fsdevel+bounces-12828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFA8867A98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 16:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1EA28AE01
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 15:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEEC12C553;
	Mon, 26 Feb 2024 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NOETsR1/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y1kEO+FP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q25SrPtC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PG2cmVLD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC5812B153;
	Mon, 26 Feb 2024 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962297; cv=none; b=fyKn8f7wLo+AU/m9XIvbHCGtrkdI6zS6GCfeAFk5xakA5fHnQL9n1hzcX2Zusjx1qLyiWYe2pI/jN7tY9ThI+dsakFOghGvJbtKaym3opEz9MBMgCrK+NQPzYDvKOW54ws3+4cJWgS/36al7E+JRCZ45lavLx9wOKdXQeVSfxe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962297; c=relaxed/simple;
	bh=RLBFNkzP9GqTjvndlIET/xlLk5CJRmEdNX0X75l4ank=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fii1U14fTLN6EdW5c0UVJtn0C9N1eoZg3qWXHhN4WsISIzxj0YluXfUKGayAeNDfx0Zk7CnMtRwHfblrulK6rXWlDn/xoi/9VHVHXzfetI6qTzPkEu7zKxUU6MoYs/Z5X1b7BNbeDSK6Wm6mvzI4S/7fcUxYIq4Yg49d2yRFp0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NOETsR1/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y1kEO+FP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q25SrPtC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PG2cmVLD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DB67A1FD17;
	Mon, 26 Feb 2024 15:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708962293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uO6nFRXFkR5BenyCu2zdHy6TynY7FaB2n2EEfF5vWuc=;
	b=NOETsR1/coQP/da0HBqaD0qjl4DgUf+en6xj+srfFF+1uXTOn4+58dhn2yprDpczaFiAQr
	2p7piU7RIh4Du1TBu8haQtMzsJDWm+HwEqQQDP6rAqmBMZpKbHd7OycRp1MVjfCZ/f1MPC
	geFKKe27a31O8OQPpjlMDlB9/6f+yWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708962293;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uO6nFRXFkR5BenyCu2zdHy6TynY7FaB2n2EEfF5vWuc=;
	b=y1kEO+FPjFYcUBvJzauKLGMk+sf/NPUgzw8djkI0nt/EWKAIW/8hiTzV37R/6gZlhB9sSS
	dN0FoMwSj4d4cDCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708962292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uO6nFRXFkR5BenyCu2zdHy6TynY7FaB2n2EEfF5vWuc=;
	b=Q25SrPtCCHf76Rh616VtmtaJKZ8H33R+tYn4wpxCU1VSWMijjvei5aC5qPuEV4uLfS/6F1
	TkD2vldaYqHVTh0wW3y2F45Bc53hkZd3ob2Tc1nWw1t+B2msiATKRtYg5stCDTzFlOnuVM
	S4clmKoEGWAto1Re5Obt6f4HxlU92E0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708962292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uO6nFRXFkR5BenyCu2zdHy6TynY7FaB2n2EEfF5vWuc=;
	b=PG2cmVLDF6FPZ1ud+0JyiNBt6cG/oYI4OaGXlS9u3C5MWNnPp+NYekSYA9fOaUxEM2Z2wZ
	2h9o/cDJcA8f2xAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E9C213A3A;
	Mon, 26 Feb 2024 15:44:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Da2gDvSx3GU+BAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 26 Feb 2024 15:44:52 +0000
Message-ID: <f68e7f17-c288-4dc9-9ae9-78015983f99c@suse.cz>
Date: Mon, 26 Feb 2024 16:44:51 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/36] fs: Convert alloc_inode_sb() to a macro
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
 willy@infradead.org, liam.howlett@oracle.com,
 penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com,
 peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com,
 will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
 david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev,
 rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
 yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
 hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
 ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org,
 ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
 elver@google.com, dvyukov@google.com, shakeelb@google.com,
 songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
 minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
 cgroups@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
References: <20240221194052.927623-1-surenb@google.com>
 <20240221194052.927623-6-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240221194052.927623-6-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.18
X-Spamd-Result: default: False [0.18 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-0.03)[55.68%];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_GT_50(0.00)[75];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux.dev,suse.com,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,i-love.sakura.ne.jp,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com,zeniv.linux.org.uk];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On 2/21/24 20:40, Suren Baghdasaryan wrote:
> From: Kent Overstreet <kent.overstreet@linux.dev>
> 
> We're introducing alloc tagging, which tracks memory allocations by
> callsite. Converting alloc_inode_sb() to a macro means allocations will
> be tracked by its caller, which is a bit more useful.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/fs.h | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 023f37c60709..08d8246399c3 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3010,11 +3010,7 @@ int setattr_should_drop_sgid(struct mnt_idmap *idmap,
>   * This must be used for allocating filesystems specific inodes to set
>   * up the inode reclaim context correctly.
>   */
> -static inline void *
> -alloc_inode_sb(struct super_block *sb, struct kmem_cache *cache, gfp_t gfp)

A __always_inline wouldn't have the same effect? Just wondering.

> -{
> -	return kmem_cache_alloc_lru(cache, &sb->s_inode_lru, gfp);
> -}
> +#define alloc_inode_sb(_sb, _cache, _gfp) kmem_cache_alloc_lru(_cache, &_sb->s_inode_lru, _gfp)
>  
>  extern void __insert_inode_hash(struct inode *, unsigned long hashval);
>  static inline void insert_inode_hash(struct inode *inode)


