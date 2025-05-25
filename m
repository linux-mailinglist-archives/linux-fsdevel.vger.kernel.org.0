Return-Path: <linux-fsdevel+bounces-49825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6B1AC3658
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 21:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86A718898E5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 19:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6457B259CBF;
	Sun, 25 May 2025 19:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t1WXA8Ng";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8C7nwvOw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AYCBuKBa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Xb+N4Qj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFD84CE08
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 May 2025 19:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748200304; cv=none; b=TATdJ0oDmg0dz26yK3CtXB0DyjZ5rKZOJJta/hXPft1tM+i4CCcFiJSQ8zhPBJ3Z5C26j8ZrvBYJifOn//cd5K13248BC4d21XZuXcqGKnlGujgWHfxtQR5MdCYT4J4y+AeR5jIJfSfa1Ofw1837CcygpzbNYCyhCnv6bIP23+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748200304; c=relaxed/simple;
	bh=07rfyvTwA2CAhFFGohvqUsKhLx1+C7JB5MVkZv7Zm+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYJei6L4EPE4+R8KiDfhhAc60Bm0sZRsw9jA34xXLnKweW9yjyindmJA66Nu+lrpMU0n8gC88w9EUCt5ZOAypy/Ya3LMqfx0aiLwNMWYAknh7z9Ox1tgjBGm6jS3fa2tmzZ1V3TissnDu6SL1fue17g8yfWhOwJsWSzhV3DM3ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t1WXA8Ng; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8C7nwvOw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AYCBuKBa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Xb+N4Qj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C6ED41F794;
	Sun, 25 May 2025 19:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748200301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5p5FuULDPNLzpd03YYXpvm35+K1sCc0tCAHjd/caKfo=;
	b=t1WXA8Ngq7jaBu5ZNhDByGlQZ5vYGpl35q3o5xdjjCng7r4XezuOVRNtQIbD0w6fXxQV+8
	Zp98zvZ6fmBGE9qyEeMS8MCPbL5w2FLBLWmeUHYoaUp+OvQ2KcSg34BcAoSeKoYyUfpWfm
	Ona1l7hAS541xIWwFyiw+FUBXpAbynY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748200301;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5p5FuULDPNLzpd03YYXpvm35+K1sCc0tCAHjd/caKfo=;
	b=8C7nwvOwDEtfRROX99F00E8ppc7ctEFNxPbEB2KxtjK/LaRVmcvJk2tyWYnAqjiv8CVLox
	0qqK5MXLIrNnTnCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AYCBuKBa;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1Xb+N4Qj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748200300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5p5FuULDPNLzpd03YYXpvm35+K1sCc0tCAHjd/caKfo=;
	b=AYCBuKBaQdk7DKRu5NZOkIHr5kp2O5AP57b25kK8VIwZha+DMA/4Wv9ERZ6WeVhtOYgFwu
	1AffTNDEptLznJFo6yR9/JsadxQ9MmZfAoWcyeZp9VjjMS44nTKFqvDWHDl2JsJMaaI8UT
	ryCoruwebS+cA5Gtm3mEozRPrwIznZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748200300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5p5FuULDPNLzpd03YYXpvm35+K1sCc0tCAHjd/caKfo=;
	b=1Xb+N4Qj778nxcEUTh9Wp1khBcPsBJyQNxIS88stR+lIW9xQYhddEAaQd4PT5YTjS6fhsn
	LJ0F9WcpWrd5lxDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAE1413A62;
	Sun, 25 May 2025 19:11:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lJQWKWxrM2gyAwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Sun, 25 May 2025 19:11:40 +0000
Message-ID: <40eeba97-a298-4ae1-9691-b5911ad00095@suse.cz>
Date: Sun, 25 May 2025 21:12:31 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] regression from 974c5e6139db "xfs: flag as supporting
 FOP_DONTCACHE" (double free on page?)
To: Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20250525083209.GS2023217@ZenIV> <20250525180632.GU2023217@ZenIV>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20250525180632.GU2023217@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spam-Level: 
X-Rspamd-Queue-Id: C6ED41F794
X-Spam-Score: -1.49
X-Spam-Flag: NO
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.49 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.18)[-0.924];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]

On 5/25/25 8:06 PM, Al Viro wrote:
> On Sun, May 25, 2025 at 09:32:09AM +0100, Al Viro wrote:
> 
>> Breakage is still present in the current mainline ;-/
> 
> With CONFIG_DEBUG_VM on top of pagealloc debugging:
> 
> [ 1434.992817] run fstests generic/127 at 2025-05-25 11:46:11g
> [ 1448.956242] BUG: Bad page state in process kworker/2:1  pfn:112cb0g
> [ 1448.956846] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x3e pfn:0x112cb0g
> [ 1448.957453] flags: 0x800000000000000e(referenced|uptodate|writeback|zone=2)g

It doesn't like the writeback flag.

> [ 1448.957863] raw: 800000000000000e dead000000000100 dead000000000122 0000000000000000g
> [ 1448.958303] raw: 000000000000003e 0000000000000000 00000000ffffffff 0000000000000000g
> [ 1448.958833] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) setg
> [ 1448.959320] Modules linked in: xfs autofs4 fuse nfsd auth_rpcgss nfs_acl nfs lockd grace sunrpc loop ecryptfs 9pnet_virtio 9pnet netfs evdev pcspkr sg button ext4 jbd2 btrfs blake2b_generic xor zlib_deflate raid6_pq zstd_compress sr_mod cdrom ata_generic ata_piix psmouse serio_raw i2c_piix4 i2c_smbus libata e1000g
> [ 1448.960874] CPU: 2 UID: 0 PID: 2614 Comm: kworker/2:1 Not tainted 6.14.0-rc1+ #78g
> [ 1448.960878] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014g
> [ 1448.960879] Workqueue: xfs-conv/sdb1 xfs_end_io [xfs]g
> [ 1448.960938] Call Trace:g
> [ 1448.960939]  <TASK>g
> [ 1448.960940]  dump_stack_lvl+0x4f/0x60g
> [ 1448.960953]  bad_page+0x6f/0x100g
> [ 1448.960957]  free_frozen_pages+0x471/0x640g
> [ 1448.960958]  iomap_finish_ioend+0x196/0x3c0g
> [ 1448.960963]  iomap_finish_ioends+0x83/0xc0g
> [ 1448.960964]  xfs_end_ioend+0x64/0x140 [xfs]g
> [ 1448.961003]  xfs_end_io+0x93/0xc0 [xfs]g
> [ 1448.961036]  process_one_work+0x153/0x390g
> [ 1448.961044]  worker_thread+0x2ab/0x3b0g
> [ 1448.961045]  ? rescuer_thread+0x470/0x470g
> [ 1448.961047]  kthread+0xf7/0x200g
> [ 1448.961048]  ? kthread_use_mm+0xa0/0xa0g
> [ 1448.961049]  ret_from_fork+0x2d/0x50g
> [ 1448.961053]  ? kthread_use_mm+0xa0/0xa0g
> [ 1448.961054]  ret_from_fork_asm+0x11/0x20g
> [ 1448.961058]  </TASK>g
> [ 1448.961155] Disabling lock debugging due to kernel taintg
> [ 1448.969569] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x3e pfn:0x112cb0g

same pfn, same struct page

> [ 1448.970023] flags: 0x800000000000000e(referenced|uptodate|writeback|zone=2)g
> [ 1448.970651] raw: 800000000000000e dead000000000100 dead000000000122 0000000000000000g
> [ 1448.971222] raw: 000000000000003e 0000000000000000 00000000ffffffff 0000000000000000g
> [ 1448.971812] page dumped because: VM_BUG_ON_FOLIO(((unsigned int) folio_ref_count(folio) + 127u <= 127u))g
> [ 1448.972490] ------------[ cut here ]------------g
> [ 1448.972841] kernel BUG at ./include/linux/mm.h:1455!g

this is folio_get() noticing refcount is 0, so a use-after free, because
we already tried to free the page above.

I'm not familiar with this code too much, but I suspect problem was
introduced by commit fb7d3bc414939 ("mm/filemap: drop streaming/uncached
pages when writeback completes") and only (more) exposed here.

so in folio_end_writeback() we have
        if (__folio_end_writeback(folio))
                folio_wake_bit(folio, PG_writeback);

but calling the folio_end_dropbehind_write() doesn't depend on the
result of __folio_end_writeback()
this seems rather suspicious

I think if __folio_end_writeback() was true then PG_writeback would be
cleared and thus we'd not see the PAGE_FLAGS_CHECK_AT_FREE failure.
Instead we do a premature folio_end_dropbehind_write() dropping a page
ref and then the final folio_put() in folio_end_writeback() frees the
page and splats on the PG_writeback. Then the folio is processed again
in the following iteration of iomap_finish_ioend() and splats on the
refcount-already-zero.

So I think folio_end_dropbehind_write() should only be done when
__folio_end_writeback() was true. Most likely even the
folio_test_clear_dropbehind() should be tied to that, or we clear it too
early and then never act upon it later?

