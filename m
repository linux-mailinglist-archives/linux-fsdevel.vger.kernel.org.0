Return-Path: <linux-fsdevel+bounces-73171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1ACD0F4D7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 16:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C016C3050CE6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 15:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7153134B438;
	Sun, 11 Jan 2026 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="tQgHsCa9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l7VrpYmm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB1C134CF;
	Sun, 11 Jan 2026 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768145546; cv=none; b=bLKjSB9Lr3+AnZHoiYxNXWPz2a1o68mLrHPeb22+HH7u24vfzOjGqW+ql2Fm6XBD1wX/yxxwmeUF7uSFsOlSy5CTO8mgmVG3+tj9gBIuByWXFcLJdewJ0159fhOExXQ5+QOX9efHCshfY8AfKefnsUVLwoVAzkITVdowsJoJq/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768145546; c=relaxed/simple;
	bh=L3JOnxL6G0ryHsbILnAIAJYBz0cO3yGOi8X1CtSHXu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=srmrYWTzHqjRZShF8l7MYUjU3rfqp17Y+BBEUg2zF0LQnGTcE8EGw99/htg7LifORe6DXT7LqpTi28tqzypU/7vFrimPsEAAhgRDRGkRX3d4l9tmITKtsCxEXVruDavG8fLREaB8LT/cVj46AVBEqD7JNN4ZgdpZhG3YgR+TFxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=tQgHsCa9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l7VrpYmm; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id BD2F3EC00C1;
	Sun, 11 Jan 2026 10:32:23 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 11 Jan 2026 10:32:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768145543;
	 x=1768231943; bh=bHh/pIWfzoQnVQxk1CCKxTEbT/E9Z/M8dSasu7RI1n4=; b=
	tQgHsCa9xivtREZ0MR2gATeWQQpXq5KjhucY5czOIaYconJGXCz8yIuupo7MhNhb
	Yb6CuCCrDZyown4PEdLF06AHbMFA11AXp5RMwv4cTKCRtKhkdxftLGUJq4+6VDjy
	NIomH3sLbmFQTEVow9yXX8Fq2GqVYGkHxx947Vec3LTpcHmacBolqu1t2kvn29MO
	DA9MGTOA+t2JkKXndUciPUk+LhCa/TDjo2k0civVPmRp6l5OF1ciUA0oYsqp+oB0
	e724usvmhj4a4uo7ihhZjmcSkIQZpGtEUjrVNI8UBhxT0yfDfX1tym+opJKC3crn
	XJNgpsjyKSiK4lJSeaXzLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768145543; x=
	1768231943; bh=bHh/pIWfzoQnVQxk1CCKxTEbT/E9Z/M8dSasu7RI1n4=; b=l
	7VrpYmmwJF3ds+OU+biDmiguOm9GRdnJSPg28pBj74tfNfUUh81UTPv6HwMPjRJb
	ADV4QcFbzGgIiVwmXr4BW+4VLHksKKaulFe2ZlGCRUt3HmXxVEJeveda5g2C7F7S
	8B4P7HyxJP2Bfi8yKDnw2HqBEpVijG5wy98a8P5SVUPaQVhMEAWpNMDCynreoWKE
	uF5uezF1/iLPaT6ygq2TGvP5870kI9gVBRy6m+ZpNzaML9k997fKp82tGErvUbxw
	/E0ed50wixGPDn+Zlq5ZHOa/CPSEFKbrZ+HIY2fXEi34PFdQBAJmVTNmLtGMwcVL
	sfCPCrP3B0CvGvztdeDPQ==
X-ME-Sender: <xms:h8JjaQQugdvYEYlOt35hr7R1Kgj5FdfpcQAV3qD3Rv2vQyk53_KhkA>
    <xme:h8JjaX2PVbuFEtDRpzEoUPRStHYKw5Z2qIkpGhlIjr0z1pWXU4qdywynK7okEPAcU
    wIY2NAQEveWxDbxrZdZBGdbOxy7dLatGygwlLBeiOAXi44bRzd4>
X-ME-Received: <xmr:h8JjadvBbsPb2tKAB_HGaHYueIXYFORycNYDl1OSasL9Hb1MEmpPginSnos_E9pz8ChRgHBenpqWPsiGWKVh3EQVaahmZy5l6ITU421-e7ocmwC7IQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudegleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehlihhnuhigsehlvggvmhhhuhhishdrihhnfhhopd
    hrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehrvghg
    rhgvshhsihhonhhssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhi
    nhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:h8JjaVhHoOYdUXPjKXYDFch_LoCRp6dBOd36hCUR2QWdtSaWRCGJQw>
    <xmx:h8JjaW8uBNvR3fz5KXnpwvZhb80Ye6rI8V1pDKzCZXeH4EhoTRO-ZQ>
    <xmx:h8JjaQudvIeQ8rFMJPdzHM-ShxuUHOTViQPmbw7yK5cdI67EQSk_CA>
    <xmx:h8JjaSpOybiyNKEx5svWJNvaDM536GIJ--ZEqC_nspt85vKNteqZgg>
    <xmx:h8JjaT-pRbu3yKhISeKw-eUhUxwLXpse6MY_EcW1K6VRSUPFRuqoyf-B>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Jan 2026 10:32:22 -0500 (EST)
Message-ID: <ff46166e-6795-4cab-bfef-d0724200bc62@bsbernd.com>
Date: Sun, 11 Jan 2026 16:32:20 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] fuse: xdg-document-portal gets stuck and causes
 suspend to fail in mainline
To: Thorsten Leemhuis <linux@leemhuis.info>,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux-fsdevel <linux-fsdevel@vger.kernel.org>, NeilBrown <neil@brown.name>,
 Christian Brauner <brauner@kernel.org>
References: <7d4ac21f-491f-4f0a-bc50-7601cd1140ca@leemhuis.info>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <7d4ac21f-491f-4f0a-bc50-7601cd1140ca@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/11/26 12:37, Thorsten Leemhuis wrote:
> Lo! I can reliably get xdg-document-portal stuck on latest -mainline
> (and -next, too; 6.18.4. works fine) trough the Signal flatpak, which
> then causes suspend to fail:
> 
> """
>> [  194.439381] PM: suspend entry (s2idle)
>> [  194.454708] Filesystems sync: 0.015 seconds
>> [  194.696767] Freezing user space processes
>> [  214.700978] Freezing user space processes failed after 20.004 seconds (1 tasks refusing to freeze, wq_busy=0):
>> [  214.701143] task:xdg-document-po state:D stack:0     pid:2651  tgid:2651  ppid:1939   task_flags:0x400000 flags:0x00080002
>> [  214.701151] Call Trace:
>> [  214.701154]  <TASK>
>> [  214.701167]  __schedule+0x2b8/0x5e0
>> [  214.701181]  schedule+0x27/0x80
>> [  214.701188]  request_wait_answer+0xce/0x260 [fuse]
>> [  214.701202]  ? __pfx_autoremove_wake_function+0x10/0x10
>> [  214.701212]  __fuse_simple_request+0x120/0x340 [fuse]
>> [  214.701219]  fuse_lookup_name+0xc3/0x210 [fuse]
>> [  214.701235]  fuse_lookup+0x99/0x1c0 [fuse]
>> [  214.701242]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [  214.701247]  ? fuse_dentry_init+0x23/0x50 [fuse]
>> [  214.701257]  lookup_one_qstr_excl+0xa8/0xf0

Introduced by c9ba789dad15 ("VFS: introduce start_creating_noperm() and
start_removing_noperm()")?

Why is the new code doing a lookup on an entry that is about to be
invalidated?


In order to handle this at least one fuse server process needs to be
available, but for this specific case the lookup still doesn't make sense.

We could do something like this

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 4b6b3d2758ff..7edbace7eddc 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1599,6 +1599,15 @@ int fuse_reverse_inval_entry(struct fuse_conn
*fc, u64 parent_nodeid,
        if (!dir)
                goto put_parent;

+       /* Check dcache first - if not cached, nothing to invalidate */
+       name->hash = full_name_hash(dir, name->name, name->len);
+       entry = d_lookup(dir, name);
+       if (!entry) {
+               err = 0;
+               dput(dir);
+               goto put_parent;
+       }
+
        entry = start_removing_noperm(dir, name);
        dput(dir);
        if (IS_ERR(entry))


But let's assume the dentry exists - start_removing_noperm() will now
trigger a revalidate and get the same issue. From my point of view the
above commit should be reverted for fuse.


>> [  214.701264]  start_removing_noperm+0x59/0x80
>> [  214.701268]  ? d_find_alias+0x82/0xd0
>> [  214.701273]  fuse_reverse_inval_entry+0x7d/0x1f0 [fuse]
>> [  214.701280]  ? fuse_copy_do+0x5f/0xa0 [fuse]
>> [  214.701287]  fuse_notify+0x4a1/0x750 [fuse]
>> [  214.701295]  ? iov_iter_get_pages2+0x1d/0x40
>> [  214.701301]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [  214.701305]  fuse_dev_do_write+0x2e4/0x440 [fuse]
>> [  214.701313]  fuse_dev_write+0x6b/0xa0 [fuse]
>> [  214.701320]  do_iter_readv_writev+0x161/0x260
>> [  214.701327]  vfs_writev+0x168/0x3c0
>> [  214.701334]  ? ksys_write+0xcd/0xf0
>> [  214.701338]  ? do_writev+0x7f/0x110
>> [  214.701341]  do_writev+0x7f/0x110
>> [  214.701344]  do_syscall_64+0x7e/0x6b0
>> [  214.701350]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [  214.701352]  ? __handle_mm_fault+0x445/0x690
>> [  214.701359]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [  214.701363]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [  214.701365]  ? count_memcg_events+0xd6/0x210
>> [  214.701371]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [  214.701373]  ? handle_mm_fault+0x212/0x340
>> [  214.701377]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [  214.701379]  ? do_user_addr_fault+0x2b4/0x7b0
>> [  214.701387]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [  214.701389]  ? irqentry_exit+0x6d/0x540
>> [  214.701393]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [  214.701395]  ? exc_page_fault+0x7e/0x1a0
>> [  214.701398]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [  214.701402] RIP: 0033:0x7f3c144f9982
>> [  214.701467] RSP: 002b:00007fff80e2f388 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
>> [  214.701470] RAX: ffffffffffffffda RBX: 00007f3bec000cf0 RCX: 00007f3c144f9982
>> [  214.701472] RDX: 0000000000000003 RSI: 00007fff80e2f460 RDI: 0000000000000007
>> [  214.701474] RBP: 00007fff80e2f3b0 R08: 0000000000000000 R09: 0000000000000000
>> [  214.701475] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>> [  214.701477] R13: 00007f3bec000cf0 R14: 00007f3c14bb8280 R15: 00007f3be8001200
>> [  214.701481]  </TASK>
> """
> 
> Killing the mentioned process using "kill -9" doesn't help. I can
> reliably trigger this in -mainline and -next using the Signal flatpak on
> Fedora 43 by trying to send a picture (which gets xdg-document-portal
> involved). It works the first time, but trying again won't and will
> cause Signal to get stuck for a few seconds. Works fine in 6.18.4.
> 
> Is this maybe known already or does anybody have an idea what's wrong?
> If not I guess I'll have to bisect this.
> 
> Ciao, Thorsten
> 
> #regzbot introduced: v6.18..
> #regzbot title: fuse: xdg-document-portal gets stuck and causes suspend
> to fail
> 
> 

Thanks,
Bernd

