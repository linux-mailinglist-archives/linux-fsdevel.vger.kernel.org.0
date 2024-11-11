Return-Path: <linux-fsdevel+bounces-34214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 100119C3C9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 12:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBF401F21DFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 11:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DB8158DD4;
	Mon, 11 Nov 2024 11:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P49p6Xb9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tkrmPWiL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P49p6Xb9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tkrmPWiL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D1B156C52;
	Mon, 11 Nov 2024 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731322927; cv=none; b=snShHvuMv7AQbt6/S+Ua7Vhy8cQpdTVdt5+fTL562tnFjzU8b9QhXFB5qWihc/QB5XUlo+B4HgO3WBSOxD1E9cZApcM1WEqfxa3jX0eLWj4fLR7xVeAIq9bB6k0elL572dAVrU3udKy7iNV33ksN7eojdGSffYf1tvsNJrs65gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731322927; c=relaxed/simple;
	bh=zKv3Vn3RngXApMuDLHQ3tdm8G0jfhbJLEdut14IqwrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rOl+jegiR34GfMvAWSLxj1DJwH8Bw19jLc1vN1zGNXEBOduQhyy5WtjngUfbk1zsY9hoRJU5PPEqv5DEY+nTpLNs/OLICWT0WDi5rVyREkvGVU4XXDKb+ZvvLqEYlQYiykUavYEXh06seFc1Ak+C8eGeUJ2DCzja49/G7LFeV0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P49p6Xb9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tkrmPWiL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P49p6Xb9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tkrmPWiL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9C1381F38E;
	Mon, 11 Nov 2024 11:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731322923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uXHVH0ccgWFcGpeM6HgeltmGCkaKDRVIsW9/gEoqXsg=;
	b=P49p6Xb9X9EU2crk2y1oMy2KeTCSI+7k6Cf4qmPXhaV50qDusoH3M+AMdTpVGy/6Sw6I3k
	fnrYtFYt4WdUKE7CGto1/WoVovedVCYShD6+l5IRSG7wNAYlv48lXRP3KaFSgszfEodJWJ
	sO/nDG7MsI1U1JfpVZOXgSTrqJ10mdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731322923;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uXHVH0ccgWFcGpeM6HgeltmGCkaKDRVIsW9/gEoqXsg=;
	b=tkrmPWiLNNj2qm3VuGpKD+E8ycRAHQNEVnHcYHSe5dia8bkPxhGQfF3p8F1nao0Gio6rFJ
	jN8zHuwwIRfhMYBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731322923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uXHVH0ccgWFcGpeM6HgeltmGCkaKDRVIsW9/gEoqXsg=;
	b=P49p6Xb9X9EU2crk2y1oMy2KeTCSI+7k6Cf4qmPXhaV50qDusoH3M+AMdTpVGy/6Sw6I3k
	fnrYtFYt4WdUKE7CGto1/WoVovedVCYShD6+l5IRSG7wNAYlv48lXRP3KaFSgszfEodJWJ
	sO/nDG7MsI1U1JfpVZOXgSTrqJ10mdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731322923;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uXHVH0ccgWFcGpeM6HgeltmGCkaKDRVIsW9/gEoqXsg=;
	b=tkrmPWiLNNj2qm3VuGpKD+E8ycRAHQNEVnHcYHSe5dia8bkPxhGQfF3p8F1nao0Gio6rFJ
	jN8zHuwwIRfhMYBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60442137FB;
	Mon, 11 Nov 2024 11:02:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ricQFyvkMWfuIwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 11 Nov 2024 11:02:03 +0000
Message-ID: <ff3174f8-c8b5-4fae-a9d9-87546d37c162@suse.cz>
Date: Mon, 11 Nov 2024 12:02:02 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Add fbind() and NUMA mempolicy support for KVM
 guest_memfd
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, Shivank Garg <shivankg@amd.com>
Cc: x86@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org,
 chao.gao@intel.com, pgonda@google.com, thomas.lendacky@amd.com,
 seanjc@google.com, luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, arnd@arndb.de, kees@kernel.org,
 bharata@amd.com, nikunj@amd.com, michael.day@amd.com,
 Neeraj.Upadhyay@amd.com, linux-coco@lists.linux.dev
References: <20241105164549.154700-1-shivankg@amd.com>
 <ZypqJ0e-J3C_K8LA@casper.infradead.org>
 <6004eaa4-934c-48f4-b502-cf7e436462fc@amd.com>
 <ZyzYUOX_r3uWin5f@casper.infradead.org>
 <10ffac79-0dba-4c30-991e-f3ca2b5ff639@redhat.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <10ffac79-0dba-4c30-991e-f3ca2b5ff639@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL81e5qggtdx371s8ik49ru6xr)];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 11/8/24 18:31, Paolo Bonzini wrote:
> On 11/7/24 16:10, Matthew Wilcox wrote:
>> On Thu, Nov 07, 2024 at 02:24:20PM +0530, Shivank Garg wrote:
>>> The folio allocation path from guest_memfd typically looks like this...
>>>
>>> kvm_gmem_get_folio
>>>    filemap_grab_folio
>>>      __filemap_get_folio
>>>        filemap_alloc_folio
>>>          __folio_alloc_node_noprof
>>>            -> goes to the buddy allocator
>>>
>>> Hence, I am trying to have a version of filemap_alloc_folio() that takes an mpol.
>> 
>> It only takes that path if cpuset_do_page_mem_spread() is true.  Is the
>> real problem that you're trying to solve that cpusets are being used
>> incorrectly?
> 
> If it's false it's not very different, it goes to alloc_pages_noprof(). 
> Then it respects the process's policy, but the policy is not 
> customizable without mucking with state that is global to the process.
> 
> Taking a step back: the problem is that a VM can be configured to have 
> multiple guest-side NUMA nodes, each of which will pick memory from the 
> right NUMA node in the host.  Without a per-file operation it's not 
> possible to do this on guest_memfd.  The discussion was whether to use 
> ioctl() or a new system call.  The discussion ended with the idea of 
> posting a *proposal* asking for *comments* as to whether the system call 
> would be useful in general beyond KVM.
> 
> Commenting on the system call itself I am not sure I like the 
> file_operations entry, though I understand that it's the simplest way to 
> implement this in an RFC series.  It's a bit surprising that fbind() is 
> a total no-op for everything except KVM's guest_memfd.
> 
> Maybe whatever you pass to fbind() could be stored in the struct file *, 
> and used as the default when creating VMAs; as if every mmap() was 
> followed by an mbind(), except that it also does the right thing with 
> MAP_POPULATE for example.  Or maybe that's a horrible idea?

mbind() manpage has this:

       The  specified  policy  will  be  ignored  for  any MAP_SHARED
mappings in the specified memory range.  Rather the pages will be allocated
according to the memory policy of the thread that caused the page to be
allocated. Again, this may not be the thread that called mbind().

So that seems like we're not very keen on having one user of a file set a
policy that would affect other users of the file?

Now the next paragraph of the manpage says that shmem is different, and
guest_memfd is more like shmem than a regular file.

My conclusion from that is that fbind() might be too broad and we don't want
this for actual filesystem-backed files? And if it's limited to guest_memfd,
it shouldn't be an fbind()?

> Adding linux-api to get input; original thread is at
> https://lore.kernel.org/kvm/20241105164549.154700-1-shivankg@amd.com/.
> 
> Paolo
> 
>> Backing up, it seems like you want to make a change to the page cache,
>> you've had a long discussion with people who aren't the page cache
>> maintainer, and you all understand the pros and cons of everything,
>> and here you are dumping a solution on me without talking to me, even
>> though I was at Plumbers, you didn't find me to tell me I needed to go
>> to your talk.
>> 
>> So you haven't explained a damned thing to me, and I'm annoyed at you.
>> Do better.  Starting with your cover letter.
>> 
> 
> 


