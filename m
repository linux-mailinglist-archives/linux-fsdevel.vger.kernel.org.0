Return-Path: <linux-fsdevel+bounces-41848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205C5A38247
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 12:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D970E167113
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 11:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CC6219A9F;
	Mon, 17 Feb 2025 11:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eryqCgRQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="laIGp8vW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ld9gZ4Tp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mg19ksoV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760AE21A421
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2025 11:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739793165; cv=none; b=iuuk/fv5uJLFkw79s4m4yCET0yGBIaPctL/3WW9XTAlrKCDtUh0D0jbsDpK2lPUuocSoHNbQhlw9EyNDUh7yl+krlyRmhIIbMFRfTUgrA6wSs/e2RPLags0FJqVOzU0SXSXzEtXfys/rDtNkP35numc5CqFaQyOOLDzhw7maIwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739793165; c=relaxed/simple;
	bh=DEdFGpsxrphAseea/kSBbkDecoXV7rNsjSO9Bg4cwd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2HKnKKDjf4o6SdryS/0wlWJHPekcmlojwgz6mMa924y/PSfu24tdaXuor32sLBBvsxhcG5d4GMrqnmZ+Hi2b4W0cxMsHj5e+u6UXD91mJUBqvbrjZ6YianAeILqL4+e1uX0r7T+oDQE4ZxWryHia1gkWXhz+vaytMKhdndRq/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eryqCgRQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=laIGp8vW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ld9gZ4Tp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mg19ksoV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6CBFB211A7;
	Mon, 17 Feb 2025 11:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739793161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=osMQhKZVU6kLbu8H2vhW2lAjHU+ow95PQyFWnAqYoMw=;
	b=eryqCgRQE2K29qWCaqtisNSJnBSIzDisnYNOPAH6rXCO0Qe4PZqyyC4f2iFb8UczYKUT+4
	nULkfNCIjFqAq/F7ZKs2JgSB5qfmHXh57A3MJ4PRjlsr+0caSSaFz2/7VoPeJZymmHu99D
	ljrqedYoBkNFVb7e5umMMeqwuZfoImI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739793161;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=osMQhKZVU6kLbu8H2vhW2lAjHU+ow95PQyFWnAqYoMw=;
	b=laIGp8vWbYlQfykLTiFvxgF62AR59pGqeihWzp7zX8hee/YmpkLA5ca9HwWH2la+BXqfIx
	XBIFlHtWVsrjlKCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ld9gZ4Tp;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mg19ksoV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739793160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=osMQhKZVU6kLbu8H2vhW2lAjHU+ow95PQyFWnAqYoMw=;
	b=Ld9gZ4Tp8H3YUaajtfqwbkyJzS/iJOAf+RZlzbimAjpCOdkJqgGPpBnrFMqSf46xZI23Bo
	U41OCcTG7tXi4LBwvOHSsP+B2GA1ji3VSd5omgm7DH6e2xAjH40zB2drPLu+w/JbrZfOyc
	bTMHUanytxWbhyKuszt5BD2XRd3haGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739793160;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=osMQhKZVU6kLbu8H2vhW2lAjHU+ow95PQyFWnAqYoMw=;
	b=mg19ksoV2ZNjBDlxNnVAZGocKYEmsF1LUuY+PdZq2PFYXEW6wQO/kjtPo0vc/awRLxiB9b
	5vEnh8pv0ddkTgDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45606133F9;
	Mon, 17 Feb 2025 11:52:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2q6iEAgjs2c/bQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 17 Feb 2025 11:52:40 +0000
Message-ID: <469ee330-7736-4059-9e59-ec7b9a6d3c8b@suse.cz>
Date: Mon, 17 Feb 2025 12:52:39 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 2/3] mm/mempolicy: export memory policy symbols
Content-Language: en-US
To: Shivank Garg <shivankg@amd.com>, akpm@linux-foundation.org,
 willy@infradead.org, pbonzini@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, chao.gao@intel.com, seanjc@google.com,
 ackerleytng@google.com, david@redhat.com, bharata@amd.com, nikunj@amd.com,
 michael.day@amd.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com,
 michael.roth@amd.com
References: <20250210063227.41125-1-shivankg@amd.com>
 <20250210063227.41125-3-shivankg@amd.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20250210063227.41125-3-shivankg@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6CBFB211A7
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid,amd.com:email];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 2/10/25 07:32, Shivank Garg wrote:
> Export memory policy related symbols needed by the KVM guest-memfd to
> implement NUMA policy support.
> 
> These symbols are required to implement per-memory region NUMA policies
> for guest memory, allowing VMMs to control guest memory placement across
> NUMA nodes.
> 
> Signed-off-by: Shivank Garg <shivankg@amd.com>

I think we should use EXPORT_SYMBOL_GPL() these days.

Wasn't there also some way to limit the exports to KVM?

> ---
>  mm/mempolicy.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index bbaadbeeb291..9c15780cfa63 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -214,6 +214,7 @@ struct mempolicy *get_task_policy(struct task_struct *p)
>  
>  	return &default_policy;
>  }
> +EXPORT_SYMBOL(get_task_policy);
>  
>  static const struct mempolicy_operations {
>  	int (*create)(struct mempolicy *pol, const nodemask_t *nodes);
> @@ -347,6 +348,7 @@ void __mpol_put(struct mempolicy *pol)
>  		return;
>  	kmem_cache_free(policy_cache, pol);
>  }
> +EXPORT_SYMBOL(__mpol_put);
>  
>  static void mpol_rebind_default(struct mempolicy *pol, const nodemask_t *nodes)
>  {
> @@ -2736,6 +2738,7 @@ struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
>  	read_unlock(&sp->lock);
>  	return pol;
>  }
> +EXPORT_SYMBOL(mpol_shared_policy_lookup);
>  
>  static void sp_free(struct sp_node *n)
>  {
> @@ -3021,6 +3024,7 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
>  		mpol_put(mpol);	/* drop our incoming ref on sb mpol */
>  	}
>  }
> +EXPORT_SYMBOL(mpol_shared_policy_init);
>  
>  int mpol_set_shared_policy(struct shared_policy *sp,
>  			struct vm_area_struct *vma, struct mempolicy *pol)
> @@ -3039,6 +3043,7 @@ int mpol_set_shared_policy(struct shared_policy *sp,
>  		sp_free(new);
>  	return err;
>  }
> +EXPORT_SYMBOL(mpol_set_shared_policy);
>  
>  /* Free a backing policy store on inode delete. */
>  void mpol_free_shared_policy(struct shared_policy *sp)
> @@ -3057,6 +3062,7 @@ void mpol_free_shared_policy(struct shared_policy *sp)
>  	}
>  	write_unlock(&sp->lock);
>  }
> +EXPORT_SYMBOL(mpol_free_shared_policy);
>  
>  #ifdef CONFIG_NUMA_BALANCING
>  static int __initdata numabalancing_override;


