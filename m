Return-Path: <linux-fsdevel+bounces-43681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36150A5B69E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 03:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9CD172FC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 02:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D89D1E4928;
	Tue, 11 Mar 2025 02:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="aZWc5b8h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KFYFjHDV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5851415820C;
	Tue, 11 Mar 2025 02:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741659609; cv=none; b=RIXztSuNAyCzqE2hjvD6aYVWKVs/X8svaerqqslNRCZF2C4uw/T9lwqAt/DPMDtU3iN+0rQgQFxngYxMFxRftAoDlVAtqan5KDeRNXquPgmuudxg902pvnnnt8dZVyToUT+59CXU6OnvlIlx/V1Tv0GNYrbYvb/GC32CgHQJpIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741659609; c=relaxed/simple;
	bh=loFPCxgkMRsEZysLq0xZq8E7JGuBldN57UxyaBpDYDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tw/ktJqPb5gmTBYj+z6lDKfZu6RYGLsbFp2eUfbWyf/DXOOqc4zARmTborIAegURo47h+f+XAdqw5IE4Qn1aI6VJG2XkCaqlD2POoublsxkAyNgmnlJKRVAyyRPJioG2lTSJ4MV8Al+qItX6il3fAe7GGbK46RQy4PiU3Bs85ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=aZWc5b8h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KFYFjHDV; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 1E705114022E;
	Mon, 10 Mar 2025 22:20:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 10 Mar 2025 22:20:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1741659605; x=1741746005; bh=llBkAvx2eSQp24qmvu9Qr
	u9PnVkiZ4JtbJIJNbPg8tM=; b=aZWc5b8hyYqBFElEkmeHdgyhHw5J7AbmvGFyH
	0nE8koXh8ZACe9Idc0eXA0Kw8bRLsPl87IEYr0x4sZmUO2x/XykH6r/tfE4f96Bc
	7OLtyvZvqs9pqW0HN6+ibx4GCwGFuAa2RjY/h4HokJuKwFehvbyvjtf6RELzOXXt
	XCadL+CWzi/So5HZSRGLaKkpw0ecpYXShFH964ixD64uCQXI5FHdHpi3YLqLwCmv
	yIPjcoJwH6UoohEYY6R3AteJYbHJp654qBHqwxAnKBV17vQnOzXlEsRsvG5eETM4
	1R6dyf3TmYo0VHuYeynJmKdf55FABJePMhna5l2WalogyIGSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741659605; x=1741746005; bh=l
	lBkAvx2eSQp24qmvu9Qru9PnVkiZ4JtbJIJNbPg8tM=; b=KFYFjHDVEThqjalMI
	94uTQQ9pstyutIy889v6rQHWFoN4Y2a7Q0wR8helSJ7lllTTrJo/pPNKCmd5H7HI
	8S9DBh+2tJv6zm7B8nk5gse1PzBkP/fHnuK7Uc1scGLdFE1RMCjW+f3kiSjYUDVj
	CUMfAruOY9uWyNEEwem/bHS1+Cuc/Sb5wXlC4r1y2xVZNhEBepGLIsCU377PE8Jt
	x+FEtBjC3Y7oUg9nAf42nnu6I9Yj5kRB2TR62GYNn1xTjo2p8/BnfuCz5N+Dz3pl
	c0t8bHbKpOxCPn23jXqV4JxOLJ3vIG8PPSUZnO7xOGNxAY6HzsB5bJPuzfiMyCsa
	KMpOw==
X-ME-Sender: <xms:1Z3PZyJS0Gkx9j1QY88IrnmDS9i8IToQK53pE0FXcrp9rbpwYv_0bQ>
    <xme:1Z3PZ6Kgy7LUYWpsZhG6Fh7QP8-u286s1F0SKW_5k3KgefBrtDcgZm6FAkGYPH_Hn
    kKdjI-SAmFMY8A>
X-ME-Received: <xmr:1Z3PZytJvZth9nPwK_VrUpsV8xulTzG34roOlamvtouRevFOMX56aNAqX-Do8PnXQM8W35pLLRWIJSi9h3haZtmCKSgKkHlAEDurdCz9rToK0vEh2FkbMdhSCk7f-stz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddutdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffvghmihcuofgrrhhivgcu
    qfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeejffejgffgueegudevvdejkefghefghffhffejteek
    leeufeffteffhfdtudehteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
    pdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
    grvhhiugesfhhrohhmohhrsghithdrtghomhdprhgtphhtthhopegtvhgvsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthht
    ohepkhgvnhhtrdhovhgvrhhsthhrvggvtheslhhinhhugidruggvvhdprhgtphhtthhope
    hlihhnuhigqdgstggrtghhvghfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvght
X-ME-Proxy: <xmx:1Z3PZ3Y13GGnFpFJCq67aVWhc5WzX4B7sOgtnK09l2TpmL3V8k0GTw>
    <xmx:1Z3PZ5aL1lskTxtpEVsxQKuE0mW4IZDUz4GfoLJhaa5ujsPku9SorA>
    <xmx:1Z3PZzDP8B5C-ePv3HlsUTyKqNdOy-yQGuFp19Y9ERUCQqTIu3xY4w>
    <xmx:1Z3PZ_boiplEEUgvNHNDHinykL2yYFkYaFxeDVU9BqDPn7v1TlnPiA>
    <xmx:1Z3PZ2Qv7w7CXIzZF1Jh3rxccyR7oafpKifDo_klKpycMpBPqZ_Zxd99>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 22:20:04 -0400 (EDT)
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: david@fromorbit.com
Cc: cve@kernel.org,
	gnoack@google.com,
	gregkh@linuxfoundation.org,
	kent.overstreet@linux.dev,
	linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	mic@digikod.net,
	Demi Marie Obenour <demiobenour@gmail.com>
Subject: Unprivileged filesystem mounts
Date: Mon, 10 Mar 2025 22:19:57 -0400
Message-ID: <20250311021957.2887-1-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <Z8948cR5aka4Cc5g@dread.disaster.area>
References: <Z8948cR5aka4Cc5g@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

People have stuff to get done.  If you disallow unprivileged filesystem
mounts, they will just use sudo (or equivalent) instead.  The problem is
not that users are mounting untrusted filesystems.  The problem is that
mounting untrusted filesystems is unsafe.

Making untrusted filesystems safe to mount is the only solution that
lets users do what they actually need to do.  That means either actually
fixing the filesystem code, or running it in a sufficiently tight
sandbox that vulnerabilities in it are of too low importance to matter.
libguestfs+FUSE is the most obvious way to do this, but the performance
might not be enough for distros to turn it on.

For ext4 and F2FS, if there is a vulnerability that can be exploited by
a malicious filesystem image, it is a verified boot bypass for Chrome OS
and Android, respectively.  Verified boot is a security boundary for
both of them, so just forward syzbot reports to their respective
security teams and let them do the jobs they are paid to do.

