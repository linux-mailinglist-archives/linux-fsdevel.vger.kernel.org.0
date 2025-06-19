Return-Path: <linux-fsdevel+bounces-52250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 124A3AE0B61
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 18:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD1B189A10D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 16:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E28F28C006;
	Thu, 19 Jun 2025 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BeGa7k9b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tub6wDde";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BeGa7k9b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tub6wDde"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858B528C000
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750350525; cv=none; b=VwE6R/z1gLCvB4Pvmxz13Xr0dMw27qvQ9m4U/I0LS7WhqQjH5OdYqtpvQ2gheClkIRUdMt0Id+nmdo6iRPFyg7vqVw0x1s+q502R9GYsb5+W8Kqw7pgNAU6HcphUxcBEA2ssMPi6PvAhKze2DE62wChrTUUDv3XcqCxY8l9Pg6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750350525; c=relaxed/simple;
	bh=zidJjhp4CtIdjYt9Zfq+jJWUL7rpncLQlS5a5aZqwzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TcNuVW6uw8IGKEYiBDEJ3WsbVMix6YEMNske864s7VIiJoe2pMR2PQmEYON/kq8Wc+JHx88uUHT6htPDLCn5u7D4EssCy9lPZYS/v+En7Oz01n/NMyxhNb8Id0SKopfu1+b4umZPp7JLYphs12EVmQI6Lld+bl7+f7I3n+8L3z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BeGa7k9b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tub6wDde; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BeGa7k9b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tub6wDde; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 30CB51F390;
	Thu, 19 Jun 2025 16:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750350521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L0XB80uY96nZSSx/hm/ejautkqzNKhDWxLnZPhTiV14=;
	b=BeGa7k9bpKf9lHVInMG4ggxuTGbyy2Na2s3wSdo43x9lsanIwhCtf4qa/Wacks6GnEZByK
	hamQIlvU5AYyj/ikzqT0qLBKXEMsW/Hf3YfYad6UDNgCIt4xevCWQY85+x36JxpNYh7L/6
	tTaFvucek97bHLbrbXPucnvaZ77lHKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750350521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L0XB80uY96nZSSx/hm/ejautkqzNKhDWxLnZPhTiV14=;
	b=Tub6wDdeT7HClESsmBZg0rMuHkyWXvR6/u5d4sU9cui2QsyjBJ0P61M/u9Ycm2GAWxWtCn
	QsRjPj+x3CzIsUAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BeGa7k9b;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Tub6wDde
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750350521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L0XB80uY96nZSSx/hm/ejautkqzNKhDWxLnZPhTiV14=;
	b=BeGa7k9bpKf9lHVInMG4ggxuTGbyy2Na2s3wSdo43x9lsanIwhCtf4qa/Wacks6GnEZByK
	hamQIlvU5AYyj/ikzqT0qLBKXEMsW/Hf3YfYad6UDNgCIt4xevCWQY85+x36JxpNYh7L/6
	tTaFvucek97bHLbrbXPucnvaZ77lHKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750350521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L0XB80uY96nZSSx/hm/ejautkqzNKhDWxLnZPhTiV14=;
	b=Tub6wDdeT7HClESsmBZg0rMuHkyWXvR6/u5d4sU9cui2QsyjBJ0P61M/u9Ycm2GAWxWtCn
	QsRjPj+x3CzIsUAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8D4E136CC;
	Thu, 19 Jun 2025 16:28:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TJacKLg6VGhBRQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 19 Jun 2025 16:28:40 +0000
Message-ID: <b62b287a-8c13-474b-96ab-a33cc06f1c54@suse.cz>
Date: Thu, 19 Jun 2025 18:28:40 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v8 4/7] mm/mempolicy: Export memory policy symbols
Content-Language: en-US
To: Shivank Garg <shivankg@amd.com>, Gregory Price <gourry@gourry.net>
Cc: seanjc@google.com, david@redhat.com, willy@infradead.org,
 akpm@linux-foundation.org, shuah@kernel.org, pbonzini@redhat.com,
 brauner@kernel.org, viro@zeniv.linux.org.uk, ackerleytng@google.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz,
 bfoster@redhat.com, tabba@google.com, vannapurve@google.com,
 chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com,
 yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com,
 peterx@redhat.com, jack@suse.cz, rppt@kernel.org, hch@infradead.org,
 cgzones@googlemail.com, ira.weiny@intel.com, rientjes@google.com,
 roypat@amazon.co.uk, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 kent.overstreet@linux.dev, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 chao.p.peng@intel.com, amit@infradead.org, ddutile@redhat.com,
 dan.j.williams@intel.com, ashish.kalra@amd.com, gshan@redhat.com,
 jgowans@amazon.com, pankaj.gupta@amd.com, papaluri@amd.com,
 yuzhao@google.com, suzuki.poulose@arm.com, quic_eberman@quicinc.com,
 aneeshkumar.kizhakeveetil@arm.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev
References: <20250618112935.7629-1-shivankg@amd.com>
 <20250618112935.7629-5-shivankg@amd.com>
 <aFLXRtCDfoNzQym6@gourry-fedora-PF4VCD3F>
 <4267108c-ac26-4528-97cc-0d160568baee@amd.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <4267108c-ac26-4528-97cc-0d160568baee@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 30CB51F390
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,redhat.com,infradead.org,linux-foundation.org,kernel.org,zeniv.linux.org.uk,paul-moore.com,namei.org,hallyn.com,suse.cz,intel.com,amd.com,nvidia.com,amazon.com,googlemail.com,amazon.co.uk,gmail.com,sk.com,linux.dev,linux.alibaba.com,arm.com,quicinc.com,vger.kernel.org,kvack.org,lists.linux.dev];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_GT_50(0.00)[65];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01
X-Spam-Level: 

On 6/19/25 13:13, Shivank Garg wrote:
> 
> 
> On 6/18/2025 8:42 PM, Gregory Price wrote:
>> On Wed, Jun 18, 2025 at 11:29:32AM +0000, Shivank Garg wrote:
>>> KVM guest_memfd wants to implement support for NUMA policies just like
>>> shmem already does using the shared policy infrastructure. As
>>> guest_memfd currently resides in KVM module code, we have to export the
>>> relevant symbols.
>>>
>>> In the future, guest_memfd might be moved to core-mm, at which point the
>>> symbols no longer would have to be exported. When/if that happens is
>>> still unclear.
>>>
>>> Acked-by: David Hildenbrand <david@redhat.com>
>>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>>> Signed-off-by: Shivank Garg <shivankg@amd.com>
>>> ---
>>>  mm/mempolicy.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>>> index 3b1dfd08338b..d98243cdf090 100644
>>> --- a/mm/mempolicy.c
>>> +++ b/mm/mempolicy.c
>>> @@ -354,6 +354,7 @@ struct mempolicy *get_task_policy(struct task_struct *p)
>>>  
>>>  	return &default_policy;
>>>  }
>>> +EXPORT_SYMBOL_GPL(get_task_policy);
>>>  
>>>  static const struct mempolicy_operations {
>>>  	int (*create)(struct mempolicy *pol, const nodemask_t *nodes);
>>> @@ -487,6 +488,7 @@ void __mpol_put(struct mempolicy *pol)
>>>  		return;
>>>  	kmem_cache_free(policy_cache, pol);
>>>  }
>>> +EXPORT_SYMBOL_GPL(__mpol_put);
>>>  
>> 
>> I'm concerned that get_task_policy doesn't actually increment the policy

Hm it might be a bit misnomer. But fixing that would be out of scope here.

>> refcount - and mpol_cond_put only decrements the refcount for shared
>> policies (vma policies) - while __mpol_put decrements it unconditionally.
>> 
>> If you look at how get_task_policy is used internally to mempolicy,
>> you'll find that it either completes the operation in the context of the
>> task lock (allocation time) or it calls mpol_get afterwards.
> 
> I agree. But the semantics of my usage isn't new. shmem use this in same way.

Yeah it's only used in the context of the allocation or the get_mempolicy()
syscall and the pointer is not retained somewhere indefinitely. In case of
task's mempolicy, the protection comes from only accessing current task's
policy, and also only the current task can replace it with the
sys_mempolicy() syscall.

> I think the alloc_frozen_pages_noprof(), alloc_pages_bulk_mempolicy_noprof()
> calls get_task_policy without task_lock or calling mpol_get.

Yes.

>> 
>> Exporting this as-is creates a triping hazard, if only because get/put
>> naming implies reference counting.

I don't think we in general consider the act of export a larger hazard for
misuse than misuse by internal code. For e.g. __mpol_put() we have to export
it due to combination of inlined and non-inlined code, but nobody would
really call it directly, but use mpol_put() and mpol_cond_put(). We'd need
to be able to "un-declare" it after the usage in the two inline wrappers to
prevent direct (mis)use by both modules and non-modules.

> Since KVM is the only user, we could consider newly added EXPORT_SYMBOL_GPL_FOR_MODULES(..., "kvm")
> to avoid wider exposure.

Yes that would be preferred now for all the guest_memfd related series in
flight adding exports anywhere.

> Does this solve your concern?
> Or should we rename these functions.
> What should be the preferred approach?
> 
> Thanks,
> Shivank


