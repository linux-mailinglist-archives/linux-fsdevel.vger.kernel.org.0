Return-Path: <linux-fsdevel+bounces-56016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6E5B11D11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 13:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28100173404
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 11:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3FF2E5B14;
	Fri, 25 Jul 2025 11:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1qVVbg0c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IQ7Yl7TB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1qVVbg0c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IQ7Yl7TB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6534B20E023
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Jul 2025 11:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753441400; cv=none; b=PDQUm0lkkET2LVSfL3CtSG/PuBFkeC99bC2Vi5d9mtWxd5Cvos3sOSXnqf8WUuqrOdrZfis+TIhK3Nd9R+ErmH5MrXY8WG2X86MbY9s7F+oZL3fiGBulx0UbZZmgsGuohdnD4jr2rmYuBQa0xCaq8aD6OsCnL9Dz9zBkGPab4AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753441400; c=relaxed/simple;
	bh=1HCvhM8/v368sv2XSQGYflcTmPxz0g2pAwskIND6A2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqVAU0u2dkgBNLRgrNx7Inr364HYs22xofdcLOKoI2WBNaJO9fzUaFtVKzrims/7s7ZEioWH7FKz0fT6ta/QOaG+BUxCh8GoyZi9ORpZONaPlQ5I9UCef7MNvUGHkThbu3drMV6PKIuUq1mPfS5spTr9hVGRCya+fbCr8MnF+08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1qVVbg0c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IQ7Yl7TB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1qVVbg0c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IQ7Yl7TB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B5057219CB;
	Fri, 25 Jul 2025 11:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753441389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LHv7p69bBmFvHqmkqskBjy3X9D31Qb3k5Zh7mzlK8+s=;
	b=1qVVbg0cvj4BaRFNBGjQFrV6a78xB53lGA6/iBWmQwzcnVYoiUGMyBeK2pI9jV2veylS0Q
	7sHYQf1fe9m1m7hHGLm/XSr4x4RmX5fTAA9hpra8jdDVP6zvCwhHHcdBCTbwU3kmr8I79g
	vAlo2l0WHdxl1VCr7SydoeHjb3TyU/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753441389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LHv7p69bBmFvHqmkqskBjy3X9D31Qb3k5Zh7mzlK8+s=;
	b=IQ7Yl7TB/BqjjzGARP1pbWCHEQcT2waBUWLuwfqUqaRlIEgjl1fSU9lxWUeLgiXmLQ9gCM
	CZ3HM117djSEpiDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753441389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LHv7p69bBmFvHqmkqskBjy3X9D31Qb3k5Zh7mzlK8+s=;
	b=1qVVbg0cvj4BaRFNBGjQFrV6a78xB53lGA6/iBWmQwzcnVYoiUGMyBeK2pI9jV2veylS0Q
	7sHYQf1fe9m1m7hHGLm/XSr4x4RmX5fTAA9hpra8jdDVP6zvCwhHHcdBCTbwU3kmr8I79g
	vAlo2l0WHdxl1VCr7SydoeHjb3TyU/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753441389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LHv7p69bBmFvHqmkqskBjy3X9D31Qb3k5Zh7mzlK8+s=;
	b=IQ7Yl7TB/BqjjzGARP1pbWCHEQcT2waBUWLuwfqUqaRlIEgjl1fSU9lxWUeLgiXmLQ9gCM
	CZ3HM117djSEpiDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6E4213A8D;
	Fri, 25 Jul 2025 11:03:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fY+7KG1kg2jQEAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 25 Jul 2025 11:03:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BE13EA29BE; Fri, 25 Jul 2025 13:02:32 +0200 (CEST)
Date: Fri, 25 Jul 2025 13:02:32 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	ojaswin@linux.ibm.com, linux@roeck-us.net, yi.zhang@huawei.com, libaokun1@huawei.com, 
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next] ext4: fix crash on test_new_blocks_simple kunit
 tests
Message-ID: <7jucepiybalo2ddlrlphn4v7hpfp427l3upp5tqfzmsxpq32cg@y4zwyunursjp>
References: <20250725021550.3177573-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725021550.3177573-1-yi.zhang@huaweicloud.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,roeck-us.net:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Fri 25-07-25 10:15:50, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> ext4_mb_avg_fragment_size_destroy() requires a valid sbi->s_sb,
> mb_set_largest_free_order() requires the parameter bb_largest_free_order
> to be initialized, and mb_update_avg_fragment_size() requires the
> parameter bb_avg_fragment_size_order to be initialized. But the
> test_new_blocks_simple kunit tests do not init these parameters, and
> trigger the following crash issue.
> 
>  Pid: 20, comm: kunit_try_catch Tainted: G W N  6.16.0-rc4-ga8a47fa84cc2
>  RIP: 0033:ext4_mb_release+0x1fc/0x400
>  RSP: 00000000a0883ed0  EFLAGS: 00010202
>  RAX: 0000000000000000 RBX: 0000000060a1e400 RCX: 0000000000000002
>  RDX: 0000000060058fa0 RSI: 0000000000000002 RDI: 0000000000000001
>  RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000002
>  R10: 00000000a0883e68 R11: 0000000060374bb0 R12: 000000006012eff0
>  R13: 00000000603763e0 R14: 0000000060ad92d8 R15: 0000000060c051c0
>  Kernel panic - not syncing: Segfault with no mm
>  CPU: 0 UID: 0 PID: 20 Comm: kunit_try_catch Tainted: G W N 6.16.0-rc4-ga8a47fa84cc2 #47 NONE
>  Tainted: [W]=WARN, [N]=TEST
>  Stack:
>   60134c30 400000004 60864000 6092a3c0
>   00000001 a0803d40 a0803b28 6012eff0
>   605990e8 60085be0 60864000 602167aa
>  Call Trace:
>   [<60134c30>] ? kmem_cache_free+0x0/0x3d0
>   [<6012eff0>] ? kfree+0x0/0x290
>   [<60085be0>] ? to_kthread+0x0/0x40
>   [<602167aa>] ? mbt_kunit_exit+0x2a/0xe0
>   [<60085be0>] ? to_kthread+0x0/0x40
>   [<602acd50>] ? kunit_generic_run_threadfn_adapter+0x0/0x30
>   [<60085be0>] ? to_kthread+0x0/0x40
>   [<602aaa8a>] ? kunit_try_run_case_cleanup+0x2a/0x40
>   [<602acd62>] ? kunit_generic_run_threadfn_adapter+0x12/0x30
>   [<600862c1>] ? kthread+0xf1/0x250
>   [<6004a521>] ? new_thread_handler+0x41/0x60
> 
> Fixes: bbe11dd13a3f ("ext4: fix largest free orders lists corruption on mb_optimize_scan switch")
> Fixes: 458bfb991155 ("ext4: convert free groups order lists to xarrays")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/linux-ext4/b0635ad0-7ebf-4152-a69b-58e7e87d5085@roeck-us.net/
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc-test.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
> index d634c12f1984..a9416b20ff64 100644
> --- a/fs/ext4/mballoc-test.c
> +++ b/fs/ext4/mballoc-test.c
> @@ -155,6 +155,7 @@ static struct super_block *mbt_ext4_alloc_super_block(void)
>  	bgl_lock_init(sbi->s_blockgroup_lock);
>  
>  	sbi->s_es = &fsb->es;
> +	sbi->s_sb = sb;
>  	sb->s_fs_info = sbi;
>  
>  	up_write(&sb->s_umount);
> @@ -802,6 +803,8 @@ static void test_mb_mark_used(struct kunit *test)
>  	KUNIT_ASSERT_EQ(test, ret, 0);
>  
>  	grp->bb_free = EXT4_CLUSTERS_PER_GROUP(sb);
> +	grp->bb_largest_free_order = -1;
> +	grp->bb_avg_fragment_size_order = -1;
>  	mbt_generate_test_ranges(sb, ranges, TEST_RANGE_COUNT);
>  	for (i = 0; i < TEST_RANGE_COUNT; i++)
>  		test_mb_mark_used_range(test, &e4b, ranges[i].start,
> @@ -875,6 +878,8 @@ static void test_mb_free_blocks(struct kunit *test)
>  	ext4_unlock_group(sb, TEST_GOAL_GROUP);
>  
>  	grp->bb_free = 0;
> +	grp->bb_largest_free_order = -1;
> +	grp->bb_avg_fragment_size_order = -1;
>  	memset(bitmap, 0xff, sb->s_blocksize);
>  
>  	mbt_generate_test_ranges(sb, ranges, TEST_RANGE_COUNT);
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

