Return-Path: <linux-fsdevel+bounces-49853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7C6AC41AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 16:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5A33BA57E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 14:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC4F212FA0;
	Mon, 26 May 2025 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bemqJ1oe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="74lpXO/u";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Sp+5vaHz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FfYmqdEe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD2B211A15
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 May 2025 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748270604; cv=none; b=ej5APW1sNZqDiGHwqbliL564TPc+O/O8YNXb2j6PQOWzviH+++BZy2+OE/N3D8uv4CUe/b3dp0eXNPfcLwL6WYB6ydSQ1kLU5zsMVR5GgBE3MLit8imho6AJJB9CJIyNqYbShoowQmonYGu50GLnGPg9gxfCJbE8V+B878aI6lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748270604; c=relaxed/simple;
	bh=GMaIJgyrPjcbcc93q81XUSFkisTAw05O6u+Q6t9sLjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxwJ2Zrufwc4yCzdJA6vv99H1lI9Vtj9D+0N2SJhJ9bb1FquZF1l6XiO/+084BcLePV4Z73d/JW9qbzP4TdsD9M7X/1iWp8fZV9E3EQmbdPYr6BT1C5tmPRc+OVDvEm/AMO+Ek3b8IvODpAp4XzeSL5kfz8s4+wdJgaQjVCJI7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bemqJ1oe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=74lpXO/u; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Sp+5vaHz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FfYmqdEe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B709E21C46;
	Mon, 26 May 2025 14:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748270600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1uKS8UNPZ3JhbI2XYFdVQhp2m0ZjsoL3mwofOQaqEJ0=;
	b=bemqJ1oeMDcEdXubspkllQBcP0ih9JNMpLm0vOkgSVVfWJCpyLmAUlm8AZqxNwTrJGxhRy
	PsuKWMiK3mx++ZhT7qHuOSsT7F0u8cCIFD65HDCtBRLVuHqbieGaaH6OHX3HLymAihMCCM
	FsNAblqX+HYIXcGRxodPbAFSovjUErw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748270600;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1uKS8UNPZ3JhbI2XYFdVQhp2m0ZjsoL3mwofOQaqEJ0=;
	b=74lpXO/uc1CtzKImw0xOu8u25I4VrvQdkjcuyWZDBJM2wn9Z4TYJXCc053Bti2QZ1cfn44
	RNODT0uQ9DrbpnDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748270599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1uKS8UNPZ3JhbI2XYFdVQhp2m0ZjsoL3mwofOQaqEJ0=;
	b=Sp+5vaHz+ld4Y9WrGs08MEhr17SAmusgfYUCtDevsHYHTYJ44iiKNW8hf3mJqPV4Lfv88Y
	0oV85gmEo8Zl3Em3ZWhpNJbgBq1cKxIUvx1nq/cr+ZGWMj7xd9qVXkC5zDvC9nHofj4cjZ
	bWzY0Xd2/TXbo6bpgUS+vOAPlRZWZ20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748270599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1uKS8UNPZ3JhbI2XYFdVQhp2m0ZjsoL3mwofOQaqEJ0=;
	b=FfYmqdEeIikgclD0wVCrOLZwT5m/vtLeqQzpL4lpsbSzwwGEmv1CIEJunztSZ9qyJsWUyu
	8nQn8X989RQO7iAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98FF813964;
	Mon, 26 May 2025 14:43:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AllRJQd+NGhxUgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 May 2025 14:43:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 529DEA09B7; Mon, 26 May 2025 16:43:19 +0200 (CEST)
Date: Mon, 26 May 2025 16:43:19 +0200
From: Jan Kara <jack@suse.cz>
To: Alistair Popple <apopple@nvidia.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	nvdimm@lists.linux.dev, dan.j.williams@intel.com, willy@infradead.org, 
	linux-kernel@vger.kernel.org, Alison Schofield <alison.schofield@intel.com>, 
	Balbir Singh <balbirs@nvidia.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, Ted Ts'o <tytso@mit.edu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] fs/dax: Fix "don't skip locked entries when scanning
 entries"
Message-ID: <pj6yk4s25vyyosf3hevafrp7r23267rninns5jkaghlyfz5bc6@ag54j7hoy4sg>
References: <20250523043749.1460780-1-apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523043749.1460780-1-apopple@nvidia.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo,infradead.org:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Fri 23-05-25 14:37:49, Alistair Popple wrote:
> Commit 6be3e21d25ca ("fs/dax: don't skip locked entries when scanning
> entries") introduced a new function, wait_entry_unlocked_exclusive(),
> which waits for the current entry to become unlocked without advancing
> the XArray iterator state.
> 
> Waiting for the entry to become unlocked requires dropping the XArray
> lock. This requires calling xas_pause() prior to dropping the lock
> which leaves the xas in a suitable state for the next iteration. However
> this has the side-effect of advancing the xas state to the next index.
> Normally this isn't an issue because xas_for_each() contains code to
> detect this state and thus avoid advancing the index a second time on
> the next loop iteration.
> 
> However both callers of and wait_entry_unlocked_exclusive() itself
> subsequently use the xas state to reload the entry. As xas_pause()
> updated the state to the next index this will cause the current entry
> which is being waited on to be skipped. This caused the following
> warning to fire intermittently when running xftest generic/068 on an XFS
> filesystem with FS DAX enabled:
> 
> [   35.067397] ------------[ cut here ]------------
> [   35.068229] WARNING: CPU: 21 PID: 1640 at mm/truncate.c:89 truncate_folio_batch_exceptionals+0xd8/0x1e0
> [   35.069717] Modules linked in: nd_pmem dax_pmem nd_btt nd_e820 libnvdimm
> [   35.071006] CPU: 21 UID: 0 PID: 1640 Comm: fstest Not tainted 6.15.0-rc7+ #77 PREEMPT(voluntary)
> [   35.072613] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/204
> [   35.074845] RIP: 0010:truncate_folio_batch_exceptionals+0xd8/0x1e0
> [   35.075962] Code: a1 00 00 00 f6 47 0d 20 0f 84 97 00 00 00 4c 63 e8 41 39 c4 7f 0b eb 61 49 83 c5 01 45 39 ec 7e 58 42 f68
> [   35.079522] RSP: 0018:ffffb04e426c7850 EFLAGS: 00010202
> [   35.080359] RAX: 0000000000000000 RBX: ffff9d21e3481908 RCX: ffffb04e426c77f4
> [   35.081477] RDX: ffffb04e426c79e8 RSI: ffffb04e426c79e0 RDI: ffff9d21e34816e8
> [   35.082590] RBP: ffffb04e426c79e0 R08: 0000000000000001 R09: 0000000000000003
> [   35.083733] R10: 0000000000000000 R11: 822b53c0f7a49868 R12: 000000000000001f
> [   35.084850] R13: 0000000000000000 R14: ffffb04e426c78e8 R15: fffffffffffffffe
> [   35.085953] FS:  00007f9134c87740(0000) GS:ffff9d22abba0000(0000) knlGS:0000000000000000
> [   35.087346] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   35.088244] CR2: 00007f9134c86000 CR3: 000000040afff000 CR4: 00000000000006f0
> [   35.089354] Call Trace:
> [   35.089749]  <TASK>
> [   35.090168]  truncate_inode_pages_range+0xfc/0x4d0
> [   35.091078]  truncate_pagecache+0x47/0x60
> [   35.091735]  xfs_setattr_size+0xc7/0x3e0
> [   35.092648]  xfs_vn_setattr+0x1ea/0x270
> [   35.093437]  notify_change+0x1f4/0x510
> [   35.094219]  ? do_truncate+0x97/0xe0
> [   35.094879]  do_truncate+0x97/0xe0
> [   35.095640]  path_openat+0xabd/0xca0
> [   35.096278]  do_filp_open+0xd7/0x190
> [   35.096860]  do_sys_openat2+0x8a/0xe0
> [   35.097459]  __x64_sys_openat+0x6d/0xa0
> [   35.098076]  do_syscall_64+0xbb/0x1d0
> [   35.098647]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   35.099444] RIP: 0033:0x7f9134d81fc1
> [   35.100033] Code: 75 57 89 f0 25 00 00 41 00 3d 00 00 41 00 74 49 80 3d 2a 26 0e 00 00 74 6d 89 da 48 89 ee bf 9c ff ff ff5
> [   35.102993] RSP: 002b:00007ffcd41e0d10 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
> [   35.104263] RAX: ffffffffffffffda RBX: 0000000000000242 RCX: 00007f9134d81fc1
> [   35.105452] RDX: 0000000000000242 RSI: 00007ffcd41e1200 RDI: 00000000ffffff9c
> [   35.106663] RBP: 00007ffcd41e1200 R08: 0000000000000000 R09: 0000000000000064
> [   35.107923] R10: 00000000000001a4 R11: 0000000000000202 R12: 0000000000000066
> [   35.109112] R13: 0000000000100000 R14: 0000000000100000 R15: 0000000000000400
> [   35.110357]  </TASK>
> [   35.110769] irq event stamp: 8415587
> [   35.111486] hardirqs last  enabled at (8415599): [<ffffffff8d74b562>] __up_console_sem+0x52/0x60
> [   35.113067] hardirqs last disabled at (8415610): [<ffffffff8d74b547>] __up_console_sem+0x37/0x60
> [   35.114575] softirqs last  enabled at (8415300): [<ffffffff8d6ac625>] handle_softirqs+0x315/0x3f0
> [   35.115933] softirqs last disabled at (8415291): [<ffffffff8d6ac811>] __irq_exit_rcu+0xa1/0xc0
> [   35.117316] ---[ end trace 0000000000000000 ]---
> 
> Fix this by using xas_reset() instead, which is equivalent in
> implementation to xas_pause() but does not advance the XArray state.
> 
> Fixes: 6be3e21d25ca ("fs/dax: don't skip locked entries when scanning entries")
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Matthew Wilcow (Oracle) <willy@infradead.org>
> Cc: Balbir Singh <balbirs@nvidia.com>
> Cc: "Darrick J. Wong" <djwong@kernel.org>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Ted Ts'o <tytso@mit.edu>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> Hi Andrew,
> 
> Apologies for finding this so late in the cycle. This is a very
> intermittent issue for me, and it seems it was only exposed by a recent
> upgrade to my test machine/setup. The user visible impact is the same
> as for the original commit this fixes. That is possible file data
> corruption if a device has a FS DAX page pinned for DMA.
> 
> So in other words it means my original fix was not 100% effective.
> The issue that commit fixed has existed for a long time without being
> reported, so not sure if this is worth trying to get into v6.15 or not.
> 
> Either way I figured it would be best to send this ASAP, which means I
> am still waiting for a complete xfstest run to complete (although the
> failing test does now pass cleanly).
> ---
>  fs/dax.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 676303419e9e..f8d8b1afd232 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -257,7 +257,7 @@ static void *wait_entry_unlocked_exclusive(struct xa_state *xas, void *entry)
>  		wq = dax_entry_waitqueue(xas, entry, &ewait.key);
>  		prepare_to_wait_exclusive(wq, &ewait.wait,
>  					TASK_UNINTERRUPTIBLE);
> -		xas_pause(xas);
> +		xas_reset(xas);
>  		xas_unlock_irq(xas);
>  		schedule();
>  		finish_wait(wq, &ewait.wait);
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

