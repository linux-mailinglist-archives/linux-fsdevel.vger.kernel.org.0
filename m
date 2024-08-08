Return-Path: <linux-fsdevel+bounces-25407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 263F994B9DC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 11:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE73D1F226BA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 09:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC3F189B9A;
	Thu,  8 Aug 2024 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tiljeset.com header.i=@tiljeset.com header.b="oxWJLtkR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OtySI8uu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCA7183CCB;
	Thu,  8 Aug 2024 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723110031; cv=none; b=bQOSM5isF6nosgdInvkPpRLcHqOgHhAJ26Xx/J0A/y6/boihWcetDUM9Zhbr9MGkoQtdHuC/mOlRlTXuTOu/BvgEFatfC+9wH09sZ8hGYzOpQkAhtwyUifmwlZXvAotN7N1JlhnVNDxR0kHr34XjWcQQJyWodCCMHwYW9eL6KkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723110031; c=relaxed/simple;
	bh=X+KquVa3koj2ADVtTCLhQoWxbvl7I7D0BeTiP6jqaik=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=rWepnJzeT7QX0fRXYs58RQoREW/37VydqI53q/2iu4woMaBvvFpcaBVozoyY87C/1J2JoMheoWbxbX2vJZLAgi0aLPIgodSoaBug6b0zLV8jQu6jCNYVxF21K12qsY7YTXIABbcbSbcJS3kgUolSGBm8lytpgMBkjbx1t5RVor4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiljeset.com; spf=pass smtp.mailfrom=tiljeset.com; dkim=pass (2048-bit key) header.d=tiljeset.com header.i=@tiljeset.com header.b=oxWJLtkR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OtySI8uu; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiljeset.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tiljeset.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A13AE1151BFF;
	Thu,  8 Aug 2024 05:40:27 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 08 Aug 2024 05:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiljeset.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1723110027; x=1723196427; bh=2m
	ktVrb4AtcSCveP2iOMkVACkQE2zZ9TugZEJjftHjI=; b=oxWJLtkRmSg446oa0M
	JjwHIV6y3MxdI+3lnY2nLld5rx9mytCfCFWwhZwnvyHYyrcYuTtoI3hy5Er77H1d
	6yS47iqhgK+nUX/piMykx6k8nLxsF749G8hFQDJcHiqfEHcpoZjfjh8u5Ou6Ruwy
	F5aE73R/Vf56DSelVlA5TEhUTiJNisGc+0psf1+2L+liocWptjW3J5ZFTL1L1536
	I09EmjDI5UmXbRTmKg2fFts4nXnx2OEgmUxKKGlSLRSlSCiefDzAr+JWJvecERmP
	gNq1ol1F9eNCu/uIruPk4nrX+wkZq3P+6oz265EeWb2EAVQeYIPLGGVGOXdqUhTP
	b6iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1723110027; x=1723196427; bh=2mktVrb4AtcSC
	veP2iOMkVACkQE2zZ9TugZEJjftHjI=; b=OtySI8uuBDkEnc9jHkh5liGmbu2UL
	39GBDNtpHYlRmpZlg3RYAbEvPpwWPn+DI5tESDkWV2ZTKLE8a1cWRiScLqELvd7H
	XBmOCPwx7le/nh/fP4H08d5M/MwUgwH/Za5Eb5sKr0cQVTVTQbqQpYc9XclLXXX7
	6KBBlwQretDg9JfkdG3uMaIJCfWNT7ABeil7D3bVW8MFlmSEB0R3+Nae7D10pF2x
	+iz+0GcUsrNuXm5JrANaHYOYM4G5tVKrz8NVY08kvmrxNK0EK+NVVFz3jyX1cpZR
	I6Deh5eB+jB2d6BVXDAYtRyoOEauHXyWH3dmgXACdCYuHuOlw/Ng8fHHw==
X-ME-Sender: <xms:i5K0Zh9nCahYBNTUrSBHjOV5n2z9w2yoCS4MHmzJK8s5TNz0TTJbHQ>
    <xme:i5K0ZlveMDnz5iJm1VkFe8v68zbC-AW4PSifmFyixg-GHaRzYvEJmq9glpVN4Lumh
    jlPF9MTP11c7mGZ3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggfffhvf
    evkffutgfgsehtjeertdertddtnecuhfhrohhmpedfofhorhhtvghnucfjvghinhcuvfhi
    lhhjvghsvghtfdcuoehmohhrthgvnhesthhilhhjvghsvghtrdgtohhmqeenucggtffrrg
    htthgvrhhnpeduuedvjeduhfefueejudeuleejheetgfeihfffveffheetuefhveefgfdt
    veekheenucffohhmrghinheprhgvrgguthhhvgguohgtshdrihhonecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhorhhtvghnsehtihhljhgv
    shgvthdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:i5K0ZvDG2B5BGR6G7q7GNFW_mZ6igF6cCVkXHnKnmLZl3809zHOy2Q>
    <xmx:i5K0ZlfAK6_66zJ-gZti6iPEV4OCC5RUx3zKlh9OiHqn5Sjqc4KnCQ>
    <xmx:i5K0ZmPT5uLWANHulyT-MMc6n3uCjpRElE6qnHQHFKxXk7XtQZ8U8g>
    <xmx:i5K0ZnmPXTg-ndfEGShe6iWJZ8bvoBL-2k-WFO0RkuM-CYCgg0caRw>
    <xmx:i5K0Zo3fA7IY4vJaQKmSM3hI13bQpDRIlnJxM5WirLeqMB__Yu-Y_g7w>
Feedback-ID: i7bd0432c:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 78DF1B6008D; Thu,  8 Aug 2024 05:40:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 08 Aug 2024 11:40:07 +0200
From: "Morten Hein Tiljeset" <morten@tiljeset.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Message-Id: <22578d44-b822-40ff-87fb-e50b961fab15@app.fastmail.com>
Subject: Debugging stuck mount
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi folks,

I'm trying to debug an issue that occurs sporadically in production where the
ext4 filesystem on a device, say dm-1, is never fully closed. This is visible
from userspace only via the existence of /sys/fs/ext4/dm-1 which cryptsetup
uses to determine that the device is still mounted.

My initial thought was that it was mounted in some mount namespace, but this is
not the case. I've used a debugger (drgn) on /proc/kcore to find the
superblock. I can see that this is kept alive by a single mount which looks
like this (leaving out all fields that are NULL/empty lists):

*(struct mount *)0xffff888af92c5cc0 = {
	.mnt_parent = (struct mount *)0xffff888af92c5cc0,
	.mnt_mountpoint = (struct dentry *)0xffff888850331980,  // an application defined path
	.mnt = (struct vfsmount){
		.mnt_root = (struct dentry *)0xffff888850331980,    // note: same path as path as mnt_mountpoint
		.mnt_sb = (struct super_block *)0xffff88a89f7bc800, // points to the superblock I want cleaned up
		.mnt_flags = (int)134217760,                        // 0x8000020 = MNT_UMOUNT | MNT_RELATIME
		.mnt_userns = (struct user_namespace *)init_user_ns+0x0 = 0xffffffffb384b400,
	},
	.mnt_pcp = (struct mnt_pcp *)0x37dfbfa2c338,
	.mnt_instance = (struct list_head){
		.next = (struct list_head *)0xffff88a89f7bc8d0,
		.prev = (struct list_head *)0xffff88a89f7bc8d0,
	},
	.mnt_devname = (const char *)0xffff88a7d0fe7cc0 = "/dev/mapper/<my device>_crypt", // maps to /dev/dm-1
	.mnt_id = (int)3605,
}

In particular I notice that the mount namespace is NULL. As far as I understand
the only way to get this state is through a lazy unmount (MNT_DETACH). I can at
least manage to create a similar state by lazily unmounting but keeping the
mount alive with a shell with CWD inside the mountpoint.

I've tried to search for the superblock pointer on cwd/root of all tasks, which
works in my synthetic example but not for the real case. I've had similar
results searching for the superblock pointer using drgn's fsrefs.py script[1]
which has support for searching additional kernel data structures.

Is there any good way of detecting why this mount is kept alive? Where am I not
looking? Any pointers would be greatly appreciated!

[1] https://drgn.readthedocs.io/en/latest/release_highlights/0.0.26.html

