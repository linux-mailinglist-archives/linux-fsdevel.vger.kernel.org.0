Return-Path: <linux-fsdevel+bounces-26459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAB4959883
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 12:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E232CB23152
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 10:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D3E1CB15E;
	Wed, 21 Aug 2024 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=eugen.hristev@collabora.com header.b="aonqa8fi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0776F1E389B;
	Wed, 21 Aug 2024 09:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724231521; cv=pass; b=sCdlW2xNuAOIqlrKhwGpJV1at9ybNMRkUREnpfdLjOsQom7WTqkZBYHZPweVkAFifaVhJFjtYpremJtpIJlrRGMBFSduMTnfoEZs9SIdPrjM3FZaEU/bArKEjKbkvNjcFPRC/b5FE2EpbDLnLkD3hEsxtRQelWBET32QlIrO1qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724231521; c=relaxed/simple;
	bh=AE885sgZay/3ZiHVm8qDsP2iN+Ocp3A8SWfd+b0DnHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IBesVlQzAz3cl9VsiU/E444NRwLMywSBz76ui8ewmW0bKjFoH76c3/AiJ+rzqgoiPAjnaiy86VDqJ1Q9LpvSM2zNpdjHEhI+vI3SM/WAEy1Obi+cT/gfhPJyMdUAEqRDtfj80q8U4dtYg9kb74Z7Js7J5Vxk70h6z/aKtT3cdYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=eugen.hristev@collabora.com header.b=aonqa8fi; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724231463; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nNzK8LG3HiBzobKGwqnb3nFuSPgvKu8NycrKb9QqZbOpaY4YcnRBd2H7hK+11EPaPtXG/Abw0Nq224cDgx4NaOcJWq5ru95nBFfEaTzryzaBQDnyRuqvXhgNn51Oixv7gOFAY3DJTUC2Q3mO8qMVYIJHExdzRvrZ+RT9QQp8bBM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724231463; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gb71my/CkcxpqtTYRfl6w81FtlLDJsKpj9k7R6MykrA=; 
	b=IRlVGuHA92H5TLV2EPmKdsc8x0VrgaLVWAmUgY5SKI7vPRUzsTb8l3r8nj74KVhRJVMI0MVVNFphtfbstKAcxexoPUN1v53E7LEymsoyySCp0GXEfv/1WyzNL8QvXGxjxWa6hwmtoe97hjy/nralz5V1B9y8BRnz4j633IOWBJQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=eugen.hristev@collabora.com;
	dmarc=pass header.from=<eugen.hristev@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724231463;
	s=zohomail; d=collabora.com; i=eugen.hristev@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=gb71my/CkcxpqtTYRfl6w81FtlLDJsKpj9k7R6MykrA=;
	b=aonqa8fiCng+Jwf3YvS99LV2JqIVnTxPzvlWCL0djm0HhRryfOuroBPdDC8tLrsh
	eIBhcreB3ZvuITfTNMQ9XfYtp4w6FklvtV9q8AfyLua76Ee4wUUvYfcHoQ4x5DJvfrR
	eCZDi+/ky4CcIgo2QMU1Mm3M8O2GzNKnwEgTd3vk=
Received: by mx.zohomail.com with SMTPS id 1724231462364895.0511063892309;
	Wed, 21 Aug 2024 02:11:02 -0700 (PDT)
Message-ID: <2df894de-8fa9-40c2-ba2c-f9ae65520656@collabora.com>
Date: Wed, 21 Aug 2024 12:10:23 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fs/dcache: introduce d_alloc_parallel_check_existing
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
 linux-ext4@vger.kernel.org, jack@suse.cz, adilger.kernel@dilger.ca,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, shreeya.patel@collabora.com
References: <20240705062621.630604-1-eugen.hristev@collabora.com>
 <20240705062621.630604-2-eugen.hristev@collabora.com>
 <87zfp7rltx.fsf@mailhost.krisman.be>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <87zfp7rltx.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 8/20/24 23:16, Gabriel Krisman Bertazi wrote:
> Eugen Hristev <eugen.hristev@collabora.com> writes:
> 
>> d_alloc_parallel currently looks for entries that match the name being
>> added and return them if found.
>> However if d_alloc_parallel is being called during the process of adding
>> a new entry (that becomes in_lookup), the same entry is found by
>> d_alloc_parallel in the in_lookup_hash and d_alloc_parallel will wait
>> forever for it to stop being in lookup.
>> To avoid this, it makes sense to check for an entry being currently
>> added (e.g. by d_add_ci from a lookup func, like xfs is doing) and if this
>> exact match is found, return the entry.
>> This way, to add a new entry , as xfs is doing, is the following flow:
>> _lookup_slow -> d_alloc_parallel -> entry is being created -> xfs_lookup ->
>> d_add_ci -> d_alloc_parallel_check_existing(entry created before) ->
>> d_splice_alias.
> 
> Hi Eugen,

Hello Krisman,

> 
> I have a hard time understanding what xfs has anything to do with this.

It has because xfs has been given as an example a few times about how a FS
implementation should use d_add_ci.

> xfs already users d_add_ci without problems.  The issue is that
> ext4/f2fs have case-insensitive d_compare/d_hash functions, so they will
> find the dentry-under-lookup itself here. Xfs doesn't have that problem
> at all because it doesn't try to match case-inexact names in the dcache.

That's right. So xfs cannot be given as an example, as it does not make
case-inexact dentries and lookup.

> 
>> The initial entry stops being in_lookup after d_splice_alias finishes, and
>> it's returned to d_add_ci by d_alloc_parallel_check_existing.
>> Without d_alloc_parallel_check_existing, d_alloc_parallel would be called
>> instead and wait forever for the entry to stop being in lookup, as the
>> iteration through the in_lookup_hash matches the entry.
>> Currently XFS does not hang because it creates another entry in the second
>> call of d_alloc_parallel if the name differs by case as the hashing and
>> comparison functions used by XFS are not case insensitive.
>>
>> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
>> ---
>>  fs/dcache.c            | 29 +++++++++++++++++++++++------
>>  include/linux/dcache.h |  4 ++++
>>  2 files changed, 27 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/dcache.c b/fs/dcache.c
>> index a0a944fd3a1c..459a3d8b8bdb 100644
>> --- a/fs/dcache.c
>> +++ b/fs/dcache.c
>> @@ -2049,8 +2049,9 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
>>  		return found;
>>  	}
>>  	if (d_in_lookup(dentry)) {
>> -		found = d_alloc_parallel(dentry->d_parent, name,
>> -					dentry->d_wait);
>> +		found = d_alloc_parallel_check_existing(dentry,
>> +							dentry->d_parent, name,
>> +							dentry->d_wait);
>>  		if (IS_ERR(found) || !d_in_lookup(found)) {
>>  			iput(inode);
>>  			return found;
>> @@ -2452,9 +2453,10 @@ static void d_wait_lookup(struct dentry *dentry)
>>  	}
>>  }
>>  
>> -struct dentry *d_alloc_parallel(struct dentry *parent,
>> -				const struct qstr *name,
>> -				wait_queue_head_t *wq)
>> +struct dentry *d_alloc_parallel_check_existing(struct dentry *d_check,
>> +					       struct dentry *parent,
>> +					       const struct qstr *name,
>> +					       wait_queue_head_t *wq)
>>  {
>>  	unsigned int hash = name->hash;
>>  	struct hlist_bl_head *b = in_lookup_hash(parent, hash);
>> @@ -2523,6 +2525,14 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
>>  		}
>>  
>>  		rcu_read_unlock();
>> +
>> +		/* if the entry we found is the same as the original we
>> +		 * are checking against, then return it
>> +		 */
>> +		if (d_check == dentry) {
>> +			dput(new);
>> +			return dentry;
>> +		}
> 
> The point of the patchset is to install a dentry with the disk-name in
> the dcache if the name isn't an exact match to the name of the
> dentry-under-lookup.  But, since you return the same
> dentry-under-lookup, d_add_ci will just splice that dentry into the
> cache - which is exactly the same as just doing d_splice_alias(dentry) at
> the end of ->d_lookup() like we currently do, no?  Shreeya's idea in
> that original patchset was to return a new dentry with the new name.

Yes, but we cannot add another dentry for the same file with a different case.
That would break everything about dentry lookups, etc.
We need to have the one dentry in the cache which use the right case. Regardless of
the case of the lookup.

As Al Viro said here :
https://lore.kernel.org/lkml/YVmyYP25kgGq9uEy@zeniv-ca.linux.org.uk/
we cannot have parallel lookups for names that would compare as equals (two
different dentries for the same file with different case).

So yes, I return the same dentry-under-lookup, because that's the purpose of that
search, return it, have it use the right case, and then splice it to the cache.

In the end we will have the dentry use the right case and not the case that we used
for the search, namely, the original filename from the disk. That was the purpose
of the patch.

Eugen

> 
>>  		/*
>>  		 * somebody is likely to be still doing lookup for it;
>>  		 * wait for them to finish
>> @@ -2560,8 +2570,15 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
>>  	dput(dentry);
>>  	goto retry;
>>  }
>> -EXPORT_SYMBOL(d_alloc_parallel);
>> +EXPORT_SYMBOL(d_alloc_parallel_check_existing);
>>  
>> +struct dentry *d_alloc_parallel(struct dentry *parent,
>> +				const struct qstr *name,
>> +				wait_queue_head_t *wq)
>> +{
>> +	return d_alloc_parallel_check_existing(NULL, parent, name, wq);
>> +}
>> +EXPORT_SYMBOL(d_alloc_parallel);
>>  /*
>>   * - Unhash the dentry
>>   * - Retrieve and clear the waitqueue head in dentry
>> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
>> index bf53e3894aae..6eb21a518cb0 100644
>> --- a/include/linux/dcache.h
>> +++ b/include/linux/dcache.h
>> @@ -232,6 +232,10 @@ extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
>>  extern struct dentry * d_alloc_anon(struct super_block *);
>>  extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *,
>>  					wait_queue_head_t *);
>> +extern struct dentry * d_alloc_parallel_check_existing(struct dentry *,
>> +						       struct dentry *,
>> +						       const struct qstr *,
>> +						       wait_queue_head_t *);
>>  extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
>>  extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr *);
>>  extern bool d_same_name(const struct dentry *dentry, const struct dentry *parent,
> 


