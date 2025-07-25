Return-Path: <linux-fsdevel+bounces-56017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B64BFB11D1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 13:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E396F3A2190
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 11:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEF52E62A6;
	Fri, 25 Jul 2025 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HoXMdMWr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZkKrH1St";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HoXMdMWr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZkKrH1St"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4D22E6103
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Jul 2025 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753441591; cv=none; b=ufwnP0eHWv8qsBCu6A2rCepj1zIY7q3O4jeewLQNmLw9DMiNWwO/lwyXnxF6XeJY35gqDI+vCmd19+oLFebde0ux1giwQfwdGIoS051+Jzv8+H5XdoyYfiv9kUQ0MS0tKoNt1uUdWFIKgYnFVQs1D4yRrEx3M9G2pz0GHaxbt+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753441591; c=relaxed/simple;
	bh=ptLRnfF3Xh5NbhcBs5N82s1lKj5n3Up3TTRTRt3/vvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hH1DR7qvaJIwOKBVHNLH7WD3eI0G0mm+/D329KkLNZ8Dq2+VBIKSgECEMyh2j1BI6kVL0B7apgOTH054/RY6/5k0ehqilCgsvRuLqgCBbUb4QWhPkQ5aAkf+DfYTVdZl7oEN/HIAZjUafGrBxyId0523xwIGRuT/5+HBPlF5NCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HoXMdMWr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZkKrH1St; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HoXMdMWr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZkKrH1St; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A19061F394;
	Fri, 25 Jul 2025 11:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753441582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3NbCoCyk6lItwvD4IjtOOkmF1xk6FvWdmI+TimjRgcA=;
	b=HoXMdMWrsCz02kQnarh7BYQuPZax2eIk0kENY5faRRo63k5Tgp19gJu8SqfiEYKGEaghEh
	Lzdg7p5ZASYWyUpXKD9BPRauTY4VkK9Aa9I3GqvgYpC/5QQjYDKO0R6hOoHSE6VbWpU+Tn
	cvl9erXbLPhsqYRfYl+wW3y+ve8+/44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753441582;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3NbCoCyk6lItwvD4IjtOOkmF1xk6FvWdmI+TimjRgcA=;
	b=ZkKrH1StTM931qZ9U7NiPaIsxccXrYqgg2TztypgEmiqzYEnqxWQCUlJUGl5DZ/TA7E/j3
	PemM+gZaD9uAIQDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753441582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3NbCoCyk6lItwvD4IjtOOkmF1xk6FvWdmI+TimjRgcA=;
	b=HoXMdMWrsCz02kQnarh7BYQuPZax2eIk0kENY5faRRo63k5Tgp19gJu8SqfiEYKGEaghEh
	Lzdg7p5ZASYWyUpXKD9BPRauTY4VkK9Aa9I3GqvgYpC/5QQjYDKO0R6hOoHSE6VbWpU+Tn
	cvl9erXbLPhsqYRfYl+wW3y+ve8+/44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753441582;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3NbCoCyk6lItwvD4IjtOOkmF1xk6FvWdmI+TimjRgcA=;
	b=ZkKrH1StTM931qZ9U7NiPaIsxccXrYqgg2TztypgEmiqzYEnqxWQCUlJUGl5DZ/TA7E/j3
	PemM+gZaD9uAIQDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EFF1134E8;
	Fri, 25 Jul 2025 11:06:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id s/jiIi5lg2jTEQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 25 Jul 2025 11:06:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 42AE2A29BE; Fri, 25 Jul 2025 13:06:18 +0200 (CEST)
Date: Fri, 25 Jul 2025 13:06:18 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	ojaswin@linux.ibm.com, linux@roeck-us.net, yi.zhang@huawei.com, libaokun1@huawei.com, 
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] ext4: fix crash on test_mb_mark_used kunit tests
Message-ID: <av5necgeitkiormvqsh75kvgq3arjwxxqxpqievulgz2rvi3dg@75hdi2ubarmr>
References: <20250725021654.3188798-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725021654.3188798-1-yi.zhang@huaweicloud.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Fri 25-07-25 10:16:54, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> mb_set_largest_free_order() requires the parameter bb_largest_free_order
> and the list bb_largest_free_order_node to be initialized, and
> mb_update_avg_fragment_size() requires the parameter
> bb_avg_fragment_size_order and bb_avg_fragment_size_node to be
> initialized too. But the test_mb_mark_used kunit tests do not init these
> parameters, and trigger the following crash issue.
> 
>  Pid: 35, comm: kunit_try_catch Tainted: G W N 6.16.0-rc4-00031-gbbe11dd13a3f-dirty
>  RIP: 0033:mb_set_largest_free_order+0x5c/0xc0
>  RSP: 00000000a0883d98  EFLAGS: 00010206
>  RAX: 0000000060aeaa28 RBX: 0000000060a2d400 RCX: 0000000000000008
>  RDX: 0000000060aea9c0 RSI: 0000000000000000 RDI: 0000000060864000
>  RBP: 0000000060aea9c0 R08: 0000000000000000 R09: 0000000060a2d400
>  R10: 0000000000000400 R11: 0000000060a9cc00 R12: 0000000000000006
>  R13: 0000000000000400 R14: 0000000000000305 R15: 0000000000000000
>  Kernel panic - not syncing: Segfault with no mm
>  CPU: 0 UID: 0 PID: 35 Comm: kunit_try_catch Tainted: G W N 6.16.0-rc4-00031-gbbe11dd13a3f-dirty #36 NONE
>  Tainted: [W]=WARN, [N]=TEST
>  Stack:
>   60210c60 00000200 60a9e400 00000400
>   40060300280 60864000 60a9cc00 60a2d400
>   00000400 60aea9c0 60a9cc00 60aea9c0
>  Call Trace:
>   [<60210c60>] ? ext4_mb_generate_buddy+0x1f0/0x230
>   [<60215c3b>] ? test_mb_mark_used+0x28b/0x4e0
>   [<601df5bc>] ? ext4_get_group_desc+0xbc/0x150
>   [<600bf1c0>] ? ktime_get_ts64+0x0/0x190
>   [<60086370>] ? to_kthread+0x0/0x40
>   [<602b559b>] ? kunit_try_run_case+0x7b/0x100
>   [<60086370>] ? to_kthread+0x0/0x40
>   [<602b7850>] ? kunit_generic_run_threadfn_adapter+0x0/0x30
>   [<602b7862>] ? kunit_generic_run_threadfn_adapter+0x12/0x30
>   [<60086a51>] ? kthread+0xf1/0x250
>   [<6004a541>] ? new_thread_handler+0x41/0x60
>  [ERROR] Test: test_mb_mark_used: 0 tests run!
> 
> Fixes: bbe11dd13a3f ("ext4: fix largest free orders lists corruption on mb_optimize_scan switch")
> Reported-by: Theodore Ts'o <tytso@mit.edu>
> Closes: https://lore.kernel.org/linux-ext4/20250724145437.GD80823@mit.edu/
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
> This patch applies to the kernel that has only merged bbe11dd13a3f
> ("ext4: fix largest free orders lists corruption on mb_optimize_scan
> switch"), but not merged 458bfb991155 ("ext4: convert free groups order
> lists to xarrays").

Hum, I think it would be best to just squash this into bbe11dd13a3f and
then just rebase & squash the other unittest fixup to the final commit when
we have to rebase anyway. Because otherwise backports to stable kernel will
quickly become rather messy.

								Honza

 
>  fs/ext4/mballoc-test.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
> index d634c12f1984..ba939be0ec55 100644
> --- a/fs/ext4/mballoc-test.c
> +++ b/fs/ext4/mballoc-test.c
> @@ -802,6 +802,10 @@ static void test_mb_mark_used(struct kunit *test)
>  	KUNIT_ASSERT_EQ(test, ret, 0);
>  
>  	grp->bb_free = EXT4_CLUSTERS_PER_GROUP(sb);
> +	grp->bb_largest_free_order = -1;
> +	grp->bb_avg_fragment_size_order = -1;
> +	INIT_LIST_HEAD(&grp->bb_largest_free_order_node);
> +	INIT_LIST_HEAD(&grp->bb_avg_fragment_size_node);
>  	mbt_generate_test_ranges(sb, ranges, TEST_RANGE_COUNT);
>  	for (i = 0; i < TEST_RANGE_COUNT; i++)
>  		test_mb_mark_used_range(test, &e4b, ranges[i].start,
> @@ -875,6 +879,10 @@ static void test_mb_free_blocks(struct kunit *test)
>  	ext4_unlock_group(sb, TEST_GOAL_GROUP);
>  
>  	grp->bb_free = 0;
> +	grp->bb_largest_free_order = -1;
> +	grp->bb_avg_fragment_size_order = -1;
> +	INIT_LIST_HEAD(&grp->bb_largest_free_order_node);
> +	INIT_LIST_HEAD(&grp->bb_avg_fragment_size_node);
>  	memset(bitmap, 0xff, sb->s_blocksize);
>  
>  	mbt_generate_test_ranges(sb, ranges, TEST_RANGE_COUNT);
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

