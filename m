Return-Path: <linux-fsdevel+bounces-8062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8557C82F0CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 15:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85C841C2351D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 14:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515381BF36;
	Tue, 16 Jan 2024 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lQqUXsnl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+fZaUTfd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lQqUXsnl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+fZaUTfd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202D91BF2A;
	Tue, 16 Jan 2024 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1E8ED2214A;
	Tue, 16 Jan 2024 14:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705416374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bT0MT3XlGoMwAzogIhvJc3mKg3ZimZEteCxcRZq5Wqo=;
	b=lQqUXsnlwlIzuC8UGxgLozYLz1jm1dPJwHYN8kiCZiDOXCyG6Rr5AjduysVMxA83i8ial0
	0Z/2XjnAfCzpvuBrPrcS7nNXkSqeypOUTYIC4FZ+1yePg4YY5cXsb0pWwBL3CLejGxKLvu
	D2mcj4D6Z3Y0j4y5pCsYbMvdAUKTuDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705416374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bT0MT3XlGoMwAzogIhvJc3mKg3ZimZEteCxcRZq5Wqo=;
	b=+fZaUTfd5wv9LnDNge6h6lAuuYhj+s32EZ25T3FtmpoEFvQvF4W3xs2Snc+Mm9bceLtoRo
	ETmpLzeh88uoFYDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705416374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bT0MT3XlGoMwAzogIhvJc3mKg3ZimZEteCxcRZq5Wqo=;
	b=lQqUXsnlwlIzuC8UGxgLozYLz1jm1dPJwHYN8kiCZiDOXCyG6Rr5AjduysVMxA83i8ial0
	0Z/2XjnAfCzpvuBrPrcS7nNXkSqeypOUTYIC4FZ+1yePg4YY5cXsb0pWwBL3CLejGxKLvu
	D2mcj4D6Z3Y0j4y5pCsYbMvdAUKTuDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705416374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bT0MT3XlGoMwAzogIhvJc3mKg3ZimZEteCxcRZq5Wqo=;
	b=+fZaUTfd5wv9LnDNge6h6lAuuYhj+s32EZ25T3FtmpoEFvQvF4W3xs2Snc+Mm9bceLtoRo
	ETmpLzeh88uoFYDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8F9E132FA;
	Tue, 16 Jan 2024 14:46:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V7pRMLWWpmXEdQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 16 Jan 2024 14:46:13 +0000
Message-ID: <74005ee1-b6d8-4ab5-ba97-92bec302cc4b@suse.cz>
Date: Tue, 16 Jan 2024 15:46:13 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] reading proc/pid/maps under RCU
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 dchinner@redhat.com, casey@schaufler-ca.com, ben.wolsieffer@hefring.com,
 paulmck@kernel.org, david@redhat.com, avagin@google.com,
 usama.anjum@collabora.com, peterx@redhat.com, hughd@google.com,
 ryan.roberts@arm.com, wangkefeng.wang@huawei.com, Liam.Howlett@Oracle.com,
 yuzhao@google.com, axelrasmussen@google.com, lstoakes@gmail.com,
 talumbau@google.com, willy@infradead.org, mgorman@techsingularity.net,
 jhubbard@nvidia.com, vishal.moola@gmail.com, mathieu.desnoyers@efficios.com,
 dhowells@redhat.com, jgg@ziepe.ca, sidhartha.kumar@oracle.com,
 andriy.shevchenko@linux.intel.com, yangxingui@huawei.com,
 keescook@chromium.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, kernel-team@android.com
References: <20240115183837.205694-1-surenb@google.com>
 <1bc8a5df-b413-4869-8931-98f5b9e82fe5@suse.cz>
In-Reply-To: <1bc8a5df-b413-4869-8931-98f5b9e82fe5@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.78
X-Spamd-Result: default: False [-2.78 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MID_RHS_MATCH_FROM(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLumbhs4xhzuuihrchnpuyb6qu)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.19)[-0.952];
	 BAYES_HAM(-3.00)[100.00%];
	 RCPT_COUNT_TWELVE(0.00)[36];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,redhat.com,schaufler-ca.com,hefring.com,google.com,collabora.com,arm.com,huawei.com,Oracle.com,gmail.com,infradead.org,techsingularity.net,nvidia.com,efficios.com,ziepe.ca,oracle.com,linux.intel.com,chromium.org,vger.kernel.org,kvack.org,android.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On 1/16/24 15:42, Vlastimil Babka wrote:
> On 1/15/24 19:38, Suren Baghdasaryan wrote:
> 
> Hi,
> 
>> The issue this patchset is trying to address is mmap_lock contention when
>> a low priority task (monitoring, data collecting, etc.) blocks a higher
>> priority task from making updated to the address space. The contention is
>> due to the mmap_lock being held for read when reading proc/pid/maps.
>> With maple_tree introduction, VMA tree traversals are RCU-safe and per-vma
>> locks make VMA access RCU-safe. this provides an opportunity for lock-less
>> reading of proc/pid/maps. We still need to overcome a couple obstacles:
>> 1. Make all VMA pointer fields used for proc/pid/maps content generation
>> RCU-safe;
>> 2. Ensure that proc/pid/maps data tearing, which is currently possible at
>> page boundaries only, does not get worse.
> 
> Hm I thought we were to only choose this more complicated in case additional
> tearing becomes a problem, and at first assume that if software can deal
> with page boundary tearing, it can deal with sub-page tearing too?
> 
>> The patchset deals with these issues but there is a downside which I would
>> like to get input on:
>> This change introduces unfairness towards the reader of proc/pid/maps,
>> which can be blocked by an overly active/malicious address space modifyer.
> 
> So this is a consequence of the validate() operation, right? We could avoid
> this if we allowed sub-page tearing.
> 
>> A couple of ways I though we can address this issue are:
>> 1. After several lock-less retries (or some time limit) to fall back to
>> taking mmap_lock.
>> 2. Employ lock-less reading only if the reader has low priority,
>> indicating that blocking it is not critical.
>> 3. Introducing a separate procfs file which publishes the same data in
>> lock-less manner.

Oh and if this option 3 becomes necessary, then such new file shouldn't
validate() either, and whoever wants to avoid the reader contention and
converts their monitoring to the new file will have to account for this
possible extra tearing from the start. So I would suggest trying to change
the existing file with no validate() first, and if existing userspace gets
broken, employ option 3. This would mean no validate() in either case?

>> I imagine a combination of these approaches can also be employed.
>> I would like to get feedback on this from the Linux community.
>> 
>> Note: mmap_read_lock/mmap_read_unlock sequence inside validate_map()
>> can be replaced with more efficiend rwsem_wait() proposed by Matthew
>> in [1].
>> 
>> [1] https://lore.kernel.org/all/ZZ1+ZicgN8dZ3zj3@casper.infradead.org/
>> 
>> Suren Baghdasaryan (3):
>>   mm: make vm_area_struct anon_name field RCU-safe
>>   seq_file: add validate() operation to seq_operations
>>   mm/maps: read proc/pid/maps under RCU
>> 
>>  fs/proc/internal.h        |   3 +
>>  fs/proc/task_mmu.c        | 130 ++++++++++++++++++++++++++++++++++----
>>  fs/seq_file.c             |  24 ++++++-
>>  include/linux/mm_inline.h |  10 ++-
>>  include/linux/mm_types.h  |   3 +-
>>  include/linux/seq_file.h  |   1 +
>>  mm/madvise.c              |  30 +++++++--
>>  7 files changed, 181 insertions(+), 20 deletions(-)
>> 
> 


