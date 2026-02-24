Return-Path: <linux-fsdevel+bounces-78279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMfvDYnDnWmsRwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 16:28:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0C0189013
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 16:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB2F03022059
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 15:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E68366839;
	Tue, 24 Feb 2026 15:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnwmKIVn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF74F3A1E88;
	Tue, 24 Feb 2026 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771946799; cv=none; b=JHk9qOWcK6Ya/bFwDa7AcoIrJjF7YyVvrAaSlEQmdz7KETXYWPNNaGKkSHRVITYcomiSetYMO0PnKK+XZQZk4ubPTvbu6zulEid3YcmlOvn/YXMhIY+KT5AWiOtt2dyIfmGgpXhvALrThSuSHOit28AaTtcvOB065+3VwjelTaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771946799; c=relaxed/simple;
	bh=4Th39xBi4pGBEkY6xjeAp1qF4Ojgqp5PYsC7X9RFjko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XbMZKozKPqEt5tQb8AIFLYHDjzE04pKQFe2MuXbYBGQUPCx1hfSXhHWqQFpVPl4cQAUmep4aD6Acu7+wvKyA9Wm10VZKGWQavM7x48Lhk6HH/C0f+hkuKwana9VohhP0O/BCJ+4KpaMWZvl35lyo/PUJGQHeObeA/IgSpDvC7tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnwmKIVn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661C7C116D0;
	Tue, 24 Feb 2026 15:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771946798;
	bh=4Th39xBi4pGBEkY6xjeAp1qF4Ojgqp5PYsC7X9RFjko=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LnwmKIVnzsI7rLd7YC5Q5wJDjtFGkTHUPVgiP6UX4ocMfBcTmtiRhSmQ7cIXQ7R4x
	 4AYDB+T6Sxt95Wcu3I4kscolUBJrq/tS2AFtEmZsADVJgcq46iPQvArrp5yD9BN73i
	 JDpIuT/Qo+Hf77HYVrklUc4ttOIjOWvTH5EVTYWNdD5wfoBuwTx8+ZUtMTZciMMYeK
	 mxOF8SeVGzs0g3nKqCbBlIrq0sm3qh1MvTY9pHy27hZWoVz98CoemjsdvnPijsiplp
	 75Y5qb3WT5U6fmoefNJDo0Pe0vZhLDkj2KojQEvQ+gZfxC16hrAI/z/hj61xmbr+Wv
	 0fVASmfxEXPxA==
Message-ID: <9ef9a0bd-4cff-4518-b7fb-e65c9b761a5a@kernel.org>
Date: Tue, 24 Feb 2026 16:26:30 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 00/10] guest_memfd: Track amount of memory
 allocated on inode
To: Ackerley Tng <ackerleytng@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, willy@infradead.org, pbonzini@redhat.com, shuah@kernel.org,
 seanjc@google.com, shivankg@amd.com, rick.p.edgecombe@intel.com,
 yan.y.zhao@intel.com, rientjes@google.com, fvdl@google.com,
 jthoughton@google.com, vannapurve@google.com, pratyush@kernel.org,
 pasha.tatashin@soleen.com, kalyazin@amazon.com, tabba@google.com,
 michael.roth@amd.com
References: <cover.1771826352.git.ackerleytng@google.com>
 <a97045a9-8866-40fe-aa15-d319cafa6f2c@kernel.org>
 <CAEvNRgFF0+g9pmp1yitX48ebK=fDpYKSOQDmRfOjzSHxM5UpeQ@mail.gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <CAEvNRgFF0+g9pmp1yitX48ebK=fDpYKSOQDmRfOjzSHxM5UpeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78279-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B0C0189013
X-Rspamd-Action: no action

On 2/24/26 00:42, Ackerley Tng wrote:
> "David Hildenbrand (Arm)" <david@kernel.org> writes:
> 
>> On 2/23/26 08:04, Ackerley Tng wrote:
>>> Hi,
>>>
>>> Currently, guest_memfd doesn't update inode's i_blocks or i_bytes at
>>> all. Hence, st_blocks in the struct populated by a userspace fstat()
>>> call on a guest_memfd will always be 0. This patch series makes
>>> guest_memfd track the amount of memory allocated on an inode, which
>>> allows fstat() to accurately report that on requests from userspace.
>>>
>>> The inode's i_blocks and i_bytes fields are updated when the folio is
>>> associated or disassociated from the guest_memfd inode, which are at
>>> allocation and truncation times respectively.
>>>
>>> To update inode fields at truncation time, this series implements a
>>> custom truncation function for guest_memfd. An alternative would be to
>>> update truncate_inode_pages_range() to return the number of bytes
>>> truncated or add/use some hook.
>>>
>>> Implementing a custom truncation function was chosen to provide
>>> flexibility for handling truncations in future when guest_memfd
>>> supports sources of pages other than the buddy allocator. This
>>> approach of a custom truncation function also aligns with shmem, which
>>> has a custom shmem_truncate_range().
>>
>> Just wondered how shmem does it: it's through
>> dquot_alloc_block_nodirty() / dquot_free_block_nodirty().
>>
>> It's a shame we can't just use folio_free().
> 
> Yup, Hugh pointed out that struct address_space *mapping (and inode) may already
> have been freed by the time .free_folio() is called [1].
> 
> [1] https://lore.kernel.org/all/7c2677e1-daf7-3b49-0a04-1efdf451379a@google.com/
> 
>> Could we maybe have a
>> different callback (when the mapping is still guaranteed to be around)
>> from where we could update i_blocks on the freeing path?
> 
> Do you mean that we should add a new callback to struct
> address_space_operations?

If that avoids having to implement truncation completely ourselves, that might be one
option we could discuss, yes.

Something like:

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 7c753148af88..94f8bb81f017 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -764,6 +764,7 @@ cache in your filesystem.  The following members are defined:
                sector_t (*bmap)(struct address_space *, sector_t);
                void (*invalidate_folio) (struct folio *, size_t start, size_t len);
                bool (*release_folio)(struct folio *, gfp_t);
+               void (*remove_folio)(struct folio *folio);
                void (*free_folio)(struct folio *);
                ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
                int (*migrate_folio)(struct mapping *, struct folio *dst,
@@ -922,6 +923,11 @@ cache in your filesystem.  The following members are defined:
        its release_folio will need to ensure this.  Possibly it can
        clear the uptodate flag if it cannot free private data yet.
 
+``remove_folio``
+       remove_folio is called just before the folio is removed from the
+       page cache in order to allow the cleanup of properties (e.g.,
+       accounting) that needs the address_space mapping.
+
 ``free_folio``
        free_folio is called once the folio is no longer visible in the
        page cache in order to allow the cleanup of any private data.
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8b3dd145b25e..f7f6930977a1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -422,6 +422,7 @@ struct address_space_operations {
        sector_t (*bmap)(struct address_space *, sector_t);
        void (*invalidate_folio) (struct folio *, size_t offset, size_t len);
        bool (*release_folio)(struct folio *, gfp_t);
+       void (*remove_folio)(struct folio *folio);
        void (*free_folio)(struct folio *folio);
        ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
        /*
diff --git a/mm/filemap.c b/mm/filemap.c
index 6cd7974d4ada..5a810eaacab2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -250,8 +250,14 @@ void filemap_free_folio(struct address_space *mapping, struct folio *folio)
 void filemap_remove_folio(struct folio *folio)
 {
        struct address_space *mapping = folio->mapping;
+       void (*remove_folio)(struct folio *);
 
        BUG_ON(!folio_test_locked(folio));
+
+       remove_folio = mapping->a_ops->remove_folio;
+       if (unlikely(remove_folio))
+               remove_folio(folio);
+
        spin_lock(&mapping->host->i_lock);
        xa_lock_irq(&mapping->i_pages);
        __filemap_remove_folio(folio, NULL);


Ideally we'd perform it under the lock just after clearing folio->mapping, but I guess that
might be more controversial.

For accounting you need the above might be good enough, but I am not sure for how many
other use cases there might be.

-- 
Cheers,

David

