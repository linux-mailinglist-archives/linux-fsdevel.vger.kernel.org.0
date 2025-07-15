Return-Path: <linux-fsdevel+bounces-54925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1E8B05484
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 10:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BDF7562B72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 08:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41062749C3;
	Tue, 15 Jul 2025 08:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C8g3Sfl2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UPo4wR8H";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C8g3Sfl2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UPo4wR8H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27568230997
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 08:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567406; cv=none; b=IrD8xjmNWCf1fLcw2V0midV/G8OPI7OQwoV/yEWydcbGQavg++3NBoNizByhainLkKNU6mS4/5Wh7doRKuBBAm1GbxSQiISzxdLlrlo/jwF68h5hp5pPsSpZ4Ona7a4u5i9GemH5mWSJtkzY/lkxY9rlBE6dRAFUwOWsbx4B5KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567406; c=relaxed/simple;
	bh=Kc5Ck2YaJ/u+yCjsjcMZAxotpvBaW4P83qAee+003/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ex6eYWeg+B9INSbbaqwEU0qaHowMOMzE1WCZk2DStk25x0cgwj+M8rELkxJ0Pqu8ajT4z4UDnzVZ5JL4MzELtGyuYLDiP4Z+f2zy/0zt/UYaBEslcJK83QJ6IeAQ1KToBv78xLdMZdT2AwbywCPcw86aajk9Mo53sqY9w8uymmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C8g3Sfl2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UPo4wR8H; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C8g3Sfl2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UPo4wR8H; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 586861F38F;
	Tue, 15 Jul 2025 08:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752567402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zPfmNj0iCM8IvXmZLlLMYpTjRoB1uOjo4A9Jy09OjAs=;
	b=C8g3Sfl2DnDW83e+ItE0Hh/46Mfu2gVp2AtLV1O9gYk4z/qAbrDsMkEYcXfnOiG+P7aNnE
	dcy+1F1qeDwAWydzMU/M/n8zW2i5J4tGcijP0lpy1PYEzqV8M9WM3coFtE8Mz5rjWpveg7
	J0Zdu7cqb0q6vVMG0jlE5fLuh/KDkls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752567402;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zPfmNj0iCM8IvXmZLlLMYpTjRoB1uOjo4A9Jy09OjAs=;
	b=UPo4wR8HdpTGkjPTF74sBDvcmXAcFPt1is6XLIIwXSKeaCxj8vg3gDMdggPrYlcJAjLcLt
	4mgOpPOk0ZWKeFDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=C8g3Sfl2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UPo4wR8H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752567402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zPfmNj0iCM8IvXmZLlLMYpTjRoB1uOjo4A9Jy09OjAs=;
	b=C8g3Sfl2DnDW83e+ItE0Hh/46Mfu2gVp2AtLV1O9gYk4z/qAbrDsMkEYcXfnOiG+P7aNnE
	dcy+1F1qeDwAWydzMU/M/n8zW2i5J4tGcijP0lpy1PYEzqV8M9WM3coFtE8Mz5rjWpveg7
	J0Zdu7cqb0q6vVMG0jlE5fLuh/KDkls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752567402;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zPfmNj0iCM8IvXmZLlLMYpTjRoB1uOjo4A9Jy09OjAs=;
	b=UPo4wR8HdpTGkjPTF74sBDvcmXAcFPt1is6XLIIwXSKeaCxj8vg3gDMdggPrYlcJAjLcLt
	4mgOpPOk0ZWKeFDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 273E013306;
	Tue, 15 Jul 2025 08:16:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2OdBCWoOdmjbUAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 15 Jul 2025 08:16:42 +0000
Message-ID: <5ec10376-6a5f-4a94-9880-e59f1b6d425f@suse.cz>
Date: Tue, 15 Jul 2025 10:16:41 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under per-vma
 lock
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org,
 david@redhat.com, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org,
 mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org,
 adobriyan@gmail.com, brauner@kernel.org, josef@toxicpanda.com,
 yebin10@huawei.com, linux@weissschuh.net, willy@infradead.org,
 osalvador@suse.de, andrii@kernel.org, ryan.roberts@arm.com,
 christophe.leroy@csgroup.eu, tjmercier@google.com, kaleshsingh@google.com,
 aha310510@gmail.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
References: <20250704060727.724817-1-surenb@google.com>
 <20250704060727.724817-8-surenb@google.com>
 <f532558b-b19a-40ea-b594-94d1ba92188d@lucifer.local>
 <CAJuCfpGegZkgmnGd_kAsR8Wh5SRv_gtDxKbfHdjpG491u5U5fA@mail.gmail.com>
 <f60a932f-71c0-448f-9434-547caa630b72@suse.cz>
 <CAJuCfpE2H9-kRz6xSC43Ja0dmW+drcJa29hwQwQ53HRsuqRnwg@mail.gmail.com>
 <3b3521f6-30c8-419e-9615-9228f539251e@suse.cz>
 <CAJuCfpEgwdbEXKoMyMFiTHJMV15_g77-7N-m6ykReHLjD9rFLQ@mail.gmail.com>
 <bulkje7nsdfikukca4g6lqnwda6ll7eu2pcdn5bdhkqeyl7auh@yzzc6xkqqllm>
 <CAJuCfpFKNm6CEcfkuy+0o-Qu8xXppCFbOcYVXUFLeg10ztMFPw@mail.gmail.com>
 <CAJuCfpG_dRLVDv1DWveJWS5cQS0ADEVAeBxJ=5MaPQFNEvQ1+g@mail.gmail.com>
 <CAJuCfpH0HzM97exh92mpkuimxaen2Qh+tj_tZ=QBHQfi-3ejLQ@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <CAJuCfpH0HzM97exh92mpkuimxaen2Qh+tj_tZ=QBHQfi-3ejLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 586861F38F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[google.com,oracle.com,linux-foundation.org,redhat.com,cmpxchg.org,kernel.org,gmail.com,toxicpanda.com,huawei.com,weissschuh.net,infradead.org,suse.de,arm.com,csgroup.eu,vger.kernel.org,kvack.org];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLfsxmn1qwoupcjwdqfx65548p)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,bootlin.com:url,oracle.com:email,suse.cz:dkim,suse.cz:mid,suse.cz:email]
X-Spam-Score: -4.51

On 7/10/25 19:02, Suren Baghdasaryan wrote:
> On Thu, Jul 10, 2025 at 12:03 AM Suren Baghdasaryan <surenb@google.com> wrote:
>>
>> On Wed, Jul 9, 2025 at 10:47 AM Suren Baghdasaryan <surenb@google.com> wrote:
>> >
>> > On Wed, Jul 9, 2025 at 4:12 PM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
>> > >
>> > > * Suren Baghdasaryan <surenb@google.com> [250709 11:06]:
>> > > > On Wed, Jul 9, 2025 at 3:03 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>> > > > >
>> > > > > On 7/9/25 16:43, Suren Baghdasaryan wrote:
>> > > > > > On Wed, Jul 9, 2025 at 1:57 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>> > > > > >>
>> > > > > >> On 7/8/25 01:10, Suren Baghdasaryan wrote:
>> > > > > >> >>> +     rcu_read_unlock();
>> > > > > >> >>> +     vma = lock_vma_under_mmap_lock(mm, iter, address);
>> > > > > >> >>> +     rcu_read_lock();
>> > > > > >> >> OK I guess we hold the RCU lock the whole time as we traverse except when
>> > > > > >> >> we lock under mmap lock.
>> > > > > >> > Correct.
>> > > > > >>
>> > > > > >> I wonder if it's really necessary? Can't it be done just inside
>> > > > > >> lock_next_vma()? It would also avoid the unlock/lock dance quoted above.
>> > > > > >>
>> > > > > >> Even if we later manage to extend this approach to smaps and employ rcu
>> > > > > >> locking to traverse the page tables, I'd think it's best to separate and
>> > > > > >> fine-grain the rcu lock usage for vma iterator and page tables, if only to
>> > > > > >> avoid too long time under the lock.
>> > > > > >
>> > > > > > I thought we would need to be in the same rcu read section while
>> > > > > > traversing the maple tree using vma_next() but now looking at it,
>> > > > > > maybe we can indeed enter only while finding and locking the next
>> > > > > > vma...
>> > > > > > Liam, would that work? I see struct ma_state containing a node field.
>> > > > > > Can it be freed from under us if we find a vma, exit rcu read section
>> > > > > > then re-enter rcu and use the same iterator to find the next vma?
>> > > > >
>> > > > > If the rcu protection needs to be contigous, and patch 8 avoids the issue by
>> > > > > always doing vma_iter_init() after rcu_read_lock() (but does it really avoid
>> > > > > the issue or is it why we see the syzbot reports?) then I guess in the code
>> > > > > quoted above we also need a vma_iter_init() after the rcu_read_lock(),
>> > > > > because although the iterator was used briefly under mmap_lock protection,
>> > > > > that was then unlocked and there can be a race before the rcu_read_lock().
>> > > >
>> > > > Quite true. So, let's wait for Liam's confirmation and based on his
>> > > > answer I'll change the patch by either reducing the rcu read section
>> > > > or adding the missing vma_iter_init() after we switch to mmap_lock.
>> > >
>> > > You need to either be under rcu or mmap lock to ensure the node in the
>> > > maple state hasn't been freed (and potentially, reallocated).
>> > >
>> > > So in this case, in the higher level, we can hold the rcu read lock for
>> > > a series of walks and avoid re-walking the tree then the performance
>> > > would be better.
>> >
>> > Got it. Thanks for confirming!
>> >
>> > >
>> > > When we return to userspace, then we should drop the rcu read lock and
>> > > will need to vma_iter_set()/vma_iter_invalidate() on return.  I thought
>> > > this was being done (through vma_iter_init()), but syzbot seems to
>> > > indicate a path that was missed?
>> >
>> > We do that in m_start()/m_stop() by calling
>> > lock_vma_range()/unlock_vma_range() but I think I have two problems
>> > here:
>> > 1. As Vlastimil mentioned I do not reset the iterator when falling
>> > back to mmap_lock and exiting and then re-entering rcu read section;
>> > 2. I do not reset the iterator after exiting rcu read section in
>> > m_stop() and re-entering it in m_start(), so the later call to
>> > lock_next_vma() might be using an iterator with a node that was freed
>> > (and possibly reallocated).
>> >
>> > >
>> > > This is the same thing that needed to be done previously with the mmap
>> > > lock, but now under the rcu lock.
>> > >
>> > > I'm not sure how to mitigate the issue with the page table, maybe we
>> > > guess on the number of vmas that we were doing for 4k blocks of output
>> > > and just drop/reacquire then.  Probably a problem for another day
>> > > anyways.
>> > >
>> > > Also, I think you can also change the vma_iter_init() to vma_iter_set(),
>> > > which is slightly less code under the hood.  Vlastimil asked about this
>> > > and it's probably a better choice.
>> >
>> > Ack.
>> > I'll update my series with these fixes and all comments I received so
>> > far, will run the reproducers to confirm no issues and repost them
>> > later today.
>>
>> I have the patchset ready but would like to test it some more. Will
>> post it tomorrow.
> 
> Ok, I found a couple of issues using the syzbot reproducer [1] (which
> is awesome BTW!):
> 1. rwsem_acquire_read() inside vma_start_read() at [2] should be moved
> after the last check, otherwise the lock is considered taken on
> vma->vm_refcnt overflow;

I think it's fine because if the last check fails there's a
vma_refcount_put() that includes rwsem_release(), no?

> 2. query_matching_vma() is missing unlock_vma() call when it does
> "goto next_vma;" and re-issues query_vma_find_by_addr(). The previous
> vma is left locked;
> 
> [1] https://syzkaller.appspot.com/x/repro.c?x=101edf70580000
> [2] https://elixir.bootlin.com/linux/v6.15.5/source/include/linux/mm.h#L747
> 
> After these fixes it's much harder to fail but I still get one more
> error copied below. I will continue the investigation and will hold
> off reposting until this is fixed. That will be next week since I'll
> be out of town the rest of this week.
> 
> Andrew, could you please remove this patchset from mm-unstable for now
> until I fix the issue and re-post the new version?

Andrew can you do that please? We keep getting new syzbot reports.

> The error I got after these fixes is:

I suspect the root cause is the ioctls are not serialized against each other
(probably not even against read()) and yet we treat m->private as safe to
work on. Now we have various fields that are dangerous to race on - for
example locked_vma and iter races would explain a lot of this.

I suspect as long as we used purely seq_file workflow, it did the right
thing for us wrt serialization, but the ioctl addition violates that. We
should rather recheck even the code before this series, if dangerous ioctl
vs read() races are possible. And the ioctl implementation should be
refactored to use an own per-ioctl-call private context, not the seq_file's
per-file-open context.

