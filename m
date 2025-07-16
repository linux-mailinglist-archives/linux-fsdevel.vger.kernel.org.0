Return-Path: <linux-fsdevel+bounces-55168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A172B07773
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 15:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BCE61C28127
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 13:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048DB1E572F;
	Wed, 16 Jul 2025 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dGOVqCn7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VzLCJMvA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dGOVqCn7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VzLCJMvA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBB31DB92C
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752674230; cv=none; b=mV9Tq/lw0DvCUCCjdvbNvxW+/5JnHc7CNE8R49igXqa4Ag7ACeqyNnzbqbMP14NqNBa4eHmpKXJJkomI8cGkY6+ji99nxrqKrnulD1sSH3dq5+mkA3Tx+YECieRY7kxy3cEMQkDy7B6QU+2zJdKPMflFLYkd+7t5uGM8FZnLYuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752674230; c=relaxed/simple;
	bh=nbScDiUVIO7f7kyiunHXDlEmH2bwUGV6+EFhjNaX7Iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uhbG8QIAwfIVvqW6T/bdn7G/KsKuH5MlHnZTrd4TNbit8fU/MudpZ8ymtnit3bf9dULUlLCN/GX8WZyyUSvmjwbwyq1aXhBjhe+pcl+yGRzHFSte9pLFC2l1GBEEsK7W58lbTmLlkdjmvmyFyvb2ySTzH/WVTTNFOBF6JobvjP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dGOVqCn7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VzLCJMvA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dGOVqCn7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VzLCJMvA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9E2C41F799;
	Wed, 16 Jul 2025 13:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752674226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rwnWGicdVAughpBbGHvo31mHshgZJT044k4Ot0D8V/I=;
	b=dGOVqCn7cVRM8lT200YvVonjbyIGQcrN6uXxx/b6iV2dHVTEFjjEesWMxRuDlpAQFVtnnn
	wnvWqLr87UucMJqiy/frxY8wTjrBIsxBqcApN3nnxAC3U0nEoIDbuxiS3bvMwFtUWl/SRV
	1afFmD5qhJLxnDH5liD4OCoO4ibLZDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752674226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rwnWGicdVAughpBbGHvo31mHshgZJT044k4Ot0D8V/I=;
	b=VzLCJMvA1iPjm6MbEUwvzW6+DUNJC9vlbmVaeT/4gv+HMy/vAlBdaZuPIt41KVi+L3kAhj
	zzK+iZH0xp04IbBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dGOVqCn7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VzLCJMvA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752674226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rwnWGicdVAughpBbGHvo31mHshgZJT044k4Ot0D8V/I=;
	b=dGOVqCn7cVRM8lT200YvVonjbyIGQcrN6uXxx/b6iV2dHVTEFjjEesWMxRuDlpAQFVtnnn
	wnvWqLr87UucMJqiy/frxY8wTjrBIsxBqcApN3nnxAC3U0nEoIDbuxiS3bvMwFtUWl/SRV
	1afFmD5qhJLxnDH5liD4OCoO4ibLZDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752674226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rwnWGicdVAughpBbGHvo31mHshgZJT044k4Ot0D8V/I=;
	b=VzLCJMvA1iPjm6MbEUwvzW6+DUNJC9vlbmVaeT/4gv+HMy/vAlBdaZuPIt41KVi+L3kAhj
	zzK+iZH0xp04IbBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E169138D2;
	Wed, 16 Jul 2025 13:57:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 81mRGrKvd2iDAwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 16 Jul 2025 13:57:06 +0000
Message-ID: <dd88b2fc-6963-454b-8cc0-7bd3360a562e@suse.cz>
Date: Wed, 16 Jul 2025 15:57:06 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/7] fs/proc/task_mmu: read proc/pid/maps under per-vma
 lock
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com,
 peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org,
 paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com,
 brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com,
 linux@weissschuh.net, willy@infradead.org, osalvador@suse.de,
 andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu,
 tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250716030557.1547501-1-surenb@google.com>
 <20250716030557.1547501-8-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250716030557.1547501-8-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 9E2C41F799
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,redhat.com,google.com,cmpxchg.org,kernel.org,gmail.com,toxicpanda.com,huawei.com,weissschuh.net,infradead.org,suse.de,arm.com,csgroup.eu,vger.kernel.org,kvack.org];
	R_RATELIMIT(0.00)[to_ip_from(RLfsxmn1qwoupcjwdqfx65548p)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51

On 7/16/25 05:05, Suren Baghdasaryan wrote:
> With maple_tree supporting vma tree traversal under RCU and per-vma
> locks, /proc/pid/maps can be read while holding individual vma locks
> instead of locking the entire address space.
> A completely lockless approach (walking vma tree under RCU) would be
> quite complex with the main issue being get_vma_name() using callbacks
> which might not work correctly with a stable vma copy, requiring
> original (unstable) vma - see special_mapping_name() for example.
> 
> When per-vma lock acquisition fails, we take the mmap_lock for reading,
> lock the vma, release the mmap_lock and continue. This fallback to mmap
> read lock guarantees the reader to make forward progress even during
> lock contention. This will interfere with the writer but for a very
> short time while we are acquiring the per-vma lock and only when there
> was contention on the vma reader is interested in.
> 
> We shouldn't see a repeated fallback to mmap read locks in practice, as
> this require a very unlikely series of lock contentions (for instance
> due to repeated vma split operations). However even if this did somehow
> happen, we would still progress.
> 
> One case requiring special handling is when a vma changes between the
> time it was found and the time it got locked. A problematic case would
> be if a vma got shrunk so that its vm_start moved higher in the address
> space and a new vma was installed at the beginning:
> 
> reader found:               |--------VMA A--------|
> VMA is modified:            |-VMA B-|----VMA A----|
> reader locks modified VMA A
> reader reports VMA A:       |  gap  |----VMA A----|
> 
> This would result in reporting a gap in the address space that does not
> exist. To prevent this we retry the lookup after locking the vma, however
> we do that only when we identify a gap and detect that the address space
> was changed after we found the vma.
> 
> This change is designed to reduce mmap_lock contention and prevent a
> process reading /proc/pid/maps files (often a low priority task, such
> as monitoring/data collection services) from blocking address space
> updates. Note that this change has a userspace visible disadvantage:
> it allows for sub-page data tearing as opposed to the previous mechanism
> where data tearing could happen only between pages of generated output
> data. Since current userspace considers data tearing between pages to be
> acceptable, we assume is will be able to handle sub-page data tearing
> as well.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Nit: the previous patch changed lines with e.g. -2UL to -2 and this seems
changing the same lines to add a comment e.g. *ppos = -2; /* -2 indicates
gate vma */

That comment could have been added in the previous patch already. Also if
you feel the need to add the comments, maybe it's time to just name those
special values with a #define or something :)


