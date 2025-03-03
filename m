Return-Path: <linux-fsdevel+bounces-42920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2915A4BA21
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 09:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF083AB196
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 08:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB3D1F03EE;
	Mon,  3 Mar 2025 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B8CnYRgD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8rEpUTS9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B8CnYRgD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8rEpUTS9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E861F03DC
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740992335; cv=none; b=PSCmZKAjrsR7v8UH3DbQOB3IX30EiLM67TWO/u637+C2LEY2VZ3yMyhEzB98g84vNzMGQn/xKrK9gP8Z/vP1g9Zg32VfRojRhHMSCC6H25zGx+ngea/w3xiKxDOXCcNCSxNFt3qd+f0h8dsdMLzN2/+Nk/n9EeW88fX4nycXUk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740992335; c=relaxed/simple;
	bh=zAf1+BM44wP25cv6hyE2HCECIGSZwz/rO3r4AqVG9Z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qUF/Of090mqqtPStHlfS8+YgcsEY5kq5gNJHFvftJ6A+hKvKmt0235NP94G2Ygz0xi6BaHBQTbYJ9bcXsBvVb5opIDtwPZxSsH8/amr5PA/LYJAYBQiroKd+Xc4f4NRgbZVP5u2KVgbrIlOrH+Olqyu13UXXO30nm/040SPgAiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B8CnYRgD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8rEpUTS9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B8CnYRgD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8rEpUTS9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 40A462117A;
	Mon,  3 Mar 2025 08:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740992332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aSON7+XnjGfp+c6nCY9Q1Nyp8iCGTByScIrdxR+QXcU=;
	b=B8CnYRgDFesPnktfWJW3OZH+DNLlQUg2CuQ00iXZpbMajpG2B6/garfUkEbOFCfiflnKmQ
	A3+srEERN74fzyDoxhcoWqgestuE1o9MPwGpaUA+CQtjoZilWaHrPLVQtl3WrfoZfNM9yS
	nlDlPu7MeKKtkb9AmeiuqNB69h8Uj7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740992332;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aSON7+XnjGfp+c6nCY9Q1Nyp8iCGTByScIrdxR+QXcU=;
	b=8rEpUTS9caaL2Wrykctdl/I1wdPdVYVyRksK83SPToX2ti1iYIu9q/ccAw793D7E9potHg
	vbRbExkz2osvc3CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=B8CnYRgD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8rEpUTS9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740992332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aSON7+XnjGfp+c6nCY9Q1Nyp8iCGTByScIrdxR+QXcU=;
	b=B8CnYRgDFesPnktfWJW3OZH+DNLlQUg2CuQ00iXZpbMajpG2B6/garfUkEbOFCfiflnKmQ
	A3+srEERN74fzyDoxhcoWqgestuE1o9MPwGpaUA+CQtjoZilWaHrPLVQtl3WrfoZfNM9yS
	nlDlPu7MeKKtkb9AmeiuqNB69h8Uj7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740992332;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aSON7+XnjGfp+c6nCY9Q1Nyp8iCGTByScIrdxR+QXcU=;
	b=8rEpUTS9caaL2Wrykctdl/I1wdPdVYVyRksK83SPToX2ti1iYIu9q/ccAw793D7E9potHg
	vbRbExkz2osvc3CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B97913939;
	Mon,  3 Mar 2025 08:58:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nQCHAkxvxWdXeAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 03 Mar 2025 08:58:52 +0000
Message-ID: <b494af0e-3441-48d4-abc8-df3d5c006935@suse.cz>
Date: Mon, 3 Mar 2025 09:58:51 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] KVM: guest_memfd: Enforce NUMA mempolicy using
 shared policy
To: Ackerley Tng <ackerleytng@google.com>, Shivank Garg <shivankg@amd.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, pbonzini@redhat.com,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, chao.gao@intel.com, seanjc@google.com,
 david@redhat.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com,
 Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, michael.roth@amd.com,
 tabba@google.com
References: <diqzbjumm167.fsf@ackerleytng-ctop.c.googlers.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <diqzbjumm167.fsf@ackerleytng-ctop.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 40A462117A
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 2/28/25 18:25, Ackerley Tng wrote:
> Shivank Garg <shivankg@amd.com> writes:
> 
>> Previously, guest-memfd allocations followed local NUMA node id in absence
>> of process mempolicy, resulting in arbitrary memory allocation.
>> Moreover, mbind() couldn't be used since memory wasn't mapped to userspace
>> in the VMM.
>>
>> Enable NUMA policy support by implementing vm_ops for guest-memfd mmap
>> operation. This allows the VMM to map the memory and use mbind() to set
>> the desired NUMA policy. The policy is then retrieved via
>> mpol_shared_policy_lookup() and passed to filemap_grab_folio_mpol() to
>> ensure that allocations follow the specified memory policy.
>>
>> This enables the VMM to control guest memory NUMA placement by calling
>> mbind() on the mapped memory regions, providing fine-grained control over
>> guest memory allocation across NUMA nodes.
>>
>> The policy change only affect future allocations and does not migrate
>> existing memory. This matches mbind(2)'s default behavior which affects
>> only new allocations unless overridden with MPOL_MF_MOVE/MPOL_MF_MOVE_ALL
>> flags, which are not supported for guest_memfd as it is unmovable.
>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Shivank Garg <shivankg@amd.com>
>> ---
>>  virt/kvm/guest_memfd.c | 76 +++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 75 insertions(+), 1 deletion(-)
>>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index f18176976ae3..b3a8819117a0 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -2,6 +2,7 @@
>>  #include <linux/backing-dev.h>
>>  #include <linux/falloc.h>
>>  #include <linux/kvm_host.h>
>> +#include <linux/mempolicy.h>
>>  #include <linux/pagemap.h>
>>  #include <linux/anon_inodes.h>
>>
>> @@ -11,8 +12,12 @@ struct kvm_gmem {
>>  	struct kvm *kvm;
>>  	struct xarray bindings;
>>  	struct list_head entry;
>> +	struct shared_policy policy;
>>  };
>>
> 
> struct shared_policy should be stored on the inode rather than the file,
> since the memory policy is a property of the memory (struct inode),
> rather than a property of how the memory is used for a given VM (struct
> file).

That makes sense. AFAICS shmem also uses inodes to store policy.

> When the shared_policy is stored on the inode, intra-host migration [1]
> will work correctly, since the while the inode will be transferred from
> one VM (struct kvm) to another, the file (a VM's view/bindings of the
> memory) will be recreated for the new VM.
> 
> I'm thinking of having a patch like this [2] to introduce inodes.

shmem has it easier by already having inodes

> With this, we shouldn't need to pass file pointers instead of inode
> pointers.

Any downsides, besides more work needed? Or is it feasible to do it using
files now and convert to inodes later?

Feels like something that must have been discussed already, but I don't
recall specifics.


