Return-Path: <linux-fsdevel+bounces-42683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D75A46176
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 14:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273B8166233
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 13:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3B722172F;
	Wed, 26 Feb 2025 13:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f6aC9r7h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kWvAXcYU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f6aC9r7h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kWvAXcYU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524EB22154E
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578270; cv=none; b=HxTlYALPk56w8DL69NNtmQsby16DPPXs1FeRFyyIkdUf3StoBdugXx8pmedCgJXhhM1LXNIerFVh0YuJ12v77qUUPBA5Vkw/KYdgAALj8K7v3K0RVShEvmKF28SPSUMBTjeDsSpAp3rkQj9pU5RAWRpqf6NyuDwD7Cmnp2S8BgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578270; c=relaxed/simple;
	bh=sOsAhVl3Pth7b6HVc96vFlxzXU6gEn4y6aryJYUr7r8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDj7k2ZYLhV6fMEtdOVRKVTEs3xvSUlRmNy1eU2JN+t50n69eAji7MRdqo1wcy59YO4bzVBk3DhSP36jBrEG/jvhvVs+P/Xvc0rsB1UX1V67df8+mOE3OMlIJJKiC5aJZXednTXf8J76ul6pMLcjqiF2EUi671cUgIK0B5jM1mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f6aC9r7h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kWvAXcYU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f6aC9r7h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kWvAXcYU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 77A8C1F388;
	Wed, 26 Feb 2025 13:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740578266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4IhlMQLU7O+/3cgB5SqnTRbXuJ/IQuGdZmOILhsLwm0=;
	b=f6aC9r7hbfE5be4MYPaoQ3QEKQLeMGfx1A8Jq0wP9B0QUYVmlSQOkyKbJV8dTM9hmO0rgp
	JSh9+W7ZcPSOuAtnVDIsXkjLDL/KN78VsMxOs3ICguiRLRV4Bf8PPo02qQlWJQGJgiwtm9
	5TOgz69VrOYYvfDZyQWox44rwWSoT5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740578266;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4IhlMQLU7O+/3cgB5SqnTRbXuJ/IQuGdZmOILhsLwm0=;
	b=kWvAXcYUdWO7rp5uJCpRO10JpeXohnZ7b05tEUtJqzgb9/jQDs1tWc3wlEIhh9NzthI/T1
	TukaERVLfsFzvnAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=f6aC9r7h;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kWvAXcYU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740578266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4IhlMQLU7O+/3cgB5SqnTRbXuJ/IQuGdZmOILhsLwm0=;
	b=f6aC9r7hbfE5be4MYPaoQ3QEKQLeMGfx1A8Jq0wP9B0QUYVmlSQOkyKbJV8dTM9hmO0rgp
	JSh9+W7ZcPSOuAtnVDIsXkjLDL/KN78VsMxOs3ICguiRLRV4Bf8PPo02qQlWJQGJgiwtm9
	5TOgz69VrOYYvfDZyQWox44rwWSoT5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740578266;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4IhlMQLU7O+/3cgB5SqnTRbXuJ/IQuGdZmOILhsLwm0=;
	b=kWvAXcYUdWO7rp5uJCpRO10JpeXohnZ7b05tEUtJqzgb9/jQDs1tWc3wlEIhh9NzthI/T1
	TukaERVLfsFzvnAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BC9B13A53;
	Wed, 26 Feb 2025 13:57:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id inElFtodv2drOQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 26 Feb 2025 13:57:46 +0000
Message-ID: <6e9d4d95-a132-46a0-89c3-e39ace6bcb2a@suse.cz>
Date: Wed, 26 Feb 2025 14:59:29 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] mm/mempolicy: export memory policy symbols
To: Shivank Garg <shivankg@amd.com>, akpm@linux-foundation.org,
 willy@infradead.org, pbonzini@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, chao.gao@intel.com, seanjc@google.com,
 ackerleytng@google.com, david@redhat.com, bharata@amd.com, nikunj@amd.com,
 michael.day@amd.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, tabba@google.com
References: <20250226082549.6034-1-shivankg@amd.com>
 <20250226082549.6034-3-shivankg@amd.com>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20250226082549.6034-3-shivankg@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 77A8C1F388
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO



On 2/26/25 9:25 AM, Shivank Garg wrote:
> KVM guest_memfd wants to implement support for NUMA policies just like
> shmem already does using the shared policy infrastructure. As
> guest_memfd currently resides in KVM module code, we have to export the
> relevant symbols.
> 
> In the future, guest_memfd might be moved to core-mm, at which point the
> symbols no longer would have to be exported. When/if that happens is
> still unclear.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Shivank Garg <shivankg@amd.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/mempolicy.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index bbaadbeeb291..d9c5dcdadcd0 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -214,6 +214,7 @@ struct mempolicy *get_task_policy(struct task_struct *p)
>  
>  	return &default_policy;
>  }
> +EXPORT_SYMBOL_GPL(get_task_policy);
>  
>  static const struct mempolicy_operations {
>  	int (*create)(struct mempolicy *pol, const nodemask_t *nodes);
> @@ -347,6 +348,7 @@ void __mpol_put(struct mempolicy *pol)
>  		return;
>  	kmem_cache_free(policy_cache, pol);
>  }
> +EXPORT_SYMBOL_GPL(__mpol_put);
>  
>  static void mpol_rebind_default(struct mempolicy *pol, const nodemask_t *nodes)
>  {
> @@ -2736,6 +2738,7 @@ struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
>  	read_unlock(&sp->lock);
>  	return pol;
>  }
> +EXPORT_SYMBOL_GPL(mpol_shared_policy_lookup);
>  
>  static void sp_free(struct sp_node *n)
>  {
> @@ -3021,6 +3024,7 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
>  		mpol_put(mpol);	/* drop our incoming ref on sb mpol */
>  	}
>  }
> +EXPORT_SYMBOL_GPL(mpol_shared_policy_init);
>  
>  int mpol_set_shared_policy(struct shared_policy *sp,
>  			struct vm_area_struct *vma, struct mempolicy *pol)
> @@ -3039,6 +3043,7 @@ int mpol_set_shared_policy(struct shared_policy *sp,
>  		sp_free(new);
>  	return err;
>  }
> +EXPORT_SYMBOL_GPL(mpol_set_shared_policy);
>  
>  /* Free a backing policy store on inode delete. */
>  void mpol_free_shared_policy(struct shared_policy *sp)
> @@ -3057,6 +3062,7 @@ void mpol_free_shared_policy(struct shared_policy *sp)
>  	}
>  	write_unlock(&sp->lock);
>  }
> +EXPORT_SYMBOL_GPL(mpol_free_shared_policy);
>  
>  #ifdef CONFIG_NUMA_BALANCING
>  static int __initdata numabalancing_override;


