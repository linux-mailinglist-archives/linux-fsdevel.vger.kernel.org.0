Return-Path: <linux-fsdevel+bounces-39785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E411A18139
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 16:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D18E5188B4C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 15:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E0D1F470E;
	Tue, 21 Jan 2025 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b="S0LLOpIb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VpbSXK+c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF971F426C
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737473850; cv=none; b=ilVHiE+6RmsgYuIZAQqDTWNcqUBe4VRqSd+jzTOtNkDzSyVwjlzF7Dn8ozL9YQgX6dlfF0TanFQX6rBy1CiYVrbCdrLgBjK9s+hi4zzaNavW4Zg1i7YfGX82rVsyDCdVpnrEt1dQ+PsG0Zt8mEelBQXDCI02NJMkz8pYcPcMOHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737473850; c=relaxed/simple;
	bh=tX+YPpWoVX/BBx4WgU8lfjzyzvUv/qYN3udcBuBtUOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=osrUI6Fu5ywTrURmaeCBQ0qm8S2sYistUF5Vzh47Z61f/xIItdQZ8feuJjIfC6hFGreE/sxDJgLyHpCJO6OyiFYMcZIMaCZoipwjGYPMJesH4oVn+j8NacoFvZa3ekGoQutr17/x+Md6ISxzhWrnyn5dewcDkESymxTe0/oLWKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com; spf=pass smtp.mailfrom=davidreaver.com; dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b=S0LLOpIb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VpbSXK+c; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidreaver.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 611C0138028B;
	Tue, 21 Jan 2025 10:37:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 21 Jan 2025 10:37:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm1; t=1737473847; x=
	1737560247; bh=xbL9lsOWNyj+ZMZCvHUrP0+oYiKL45CTNakFaAo52wQ=; b=S
	0LLOpIb5WuM2RaNyiP7Zcc4SJkXsEIXHIQqRX9ITLAdfc5+Od0SwGhUsvm/pOhK+
	aotH6YW+epsIy0fwfyXmXxcTI8JBRlEm1RTVDsZ8EVeJjWsGodqesLjCPXC/HhLU
	ndN1sqXCuZViEjUBqDq8v3OH74auJHI3XIab4htqCqArHcKakdwkQ7LQRxXWCUIH
	Fx/euDcbguDfKTAekYzcIGrHz0zBYtvFOUCz4C3MOvR8/oIktFtJGm/01GwHVpPW
	hPbazQkonz7f10u1CXXno/7lVvY2rcQpUVB4glHz/DGXN2mA+BoyyPLvd8JrJnMS
	l5PMMTa0JKovRv1BTItrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1737473847; x=1737560247; bh=xbL9lsOWNyj+ZMZCvHUrP0+oYiKL
	45CTNakFaAo52wQ=; b=VpbSXK+cwzc9USPUz+g5OYJ4SBOWwZ3sumSNEkbnK2Ql
	GzNeWdQUHsBzlG9vXsCdXJNjtWXFK0+TtEecy8WXQ27thOMcz0FHrabC6rdyIGg1
	y572v9gLizwFTP37gWAI5KaIficBXVMtlBotHWQZ10cn0x5rBW6f5HwxBJu/niXD
	ziH+cFunMepLYAESfbGykwgdccgnLoyLQBMLvvSFm6YgIzF7f7Lbdks38iPg6CqZ
	jKVGTK/bd2pJqPSnXWBtzrVNLvqcoz3HhDwbpAAOBb02G12/QlZserFsZoHTwWvV
	H6G5M+IiVN63XIePq8NK7pWaA9AkEP1SuDRoE32P/w==
X-ME-Sender: <xms:Nr-PZ2QtcMPTNlv-TW-Qn7Gdf0IKJ1GCn_G6z8CATIhMCH-mOG27-w>
    <xme:Nr-PZ7xHsdf-RiYIlwoOmVHeAOjAQ7WbUhP25DKq_-wN03CPFtqpDjx8yVXXP3Vpe
    LjhvkWlUj8hU4Rs0Ys>
X-ME-Received: <xmr:Nr-PZz3Lnj3meMTjnsAqYD5d-LC48GfzpPrZ9X9N_4ijrZk_dFL3-kq7F0JVV210LEEfGfyJkFiLx0x-A0Kb9uY3zqgzl5_zSnDlEAP6mXD9Z0E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejvddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecu
    hfhrohhmpeffrghvihguucftvggrvhgvrhcuoehmvgesuggrvhhiughrvggrvhgvrhdrtg
    homheqnecuggftrfgrthhtvghrnhepieetueeivedvfefhuedthfdtveevffegveeuudfg
    leehhfegjeekueejvdffgeegnecuffhomhgrihhnpehlfihnrdhnvghtpdhkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehmvgesuggrvhhiughrvggrvhgvrhdrtghomhdpnhgspghrtghpthhtohepuddtpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgu
    rghtihhonhdrohhrghdprhgtphhtthhopehtjheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepmhgvsegurghvihgurhgvrghvvghrrdgtohhmpdhrtghpthhtoheprhhoshhtvggu
    thesghhoohgumhhishdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhk
    pdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepjhgrmhgvsh
    drsghothhtohhmlhgvhieshhgrnhhsvghnphgrrhhtnhgvrhhshhhiphdrtghomhdprhgt
    phhtthhopehkjhhlgiesthgvmhhplhgvohhfshhtuhhpihgurdgtohhm
X-ME-Proxy: <xmx:Nr-PZyDDVG4d34UtBWKVeuKoH1yrVkC_HuW7CA90T8hY-vl5p8Vuzg>
    <xmx:Nr-PZ_iYKf_PztgOID6rhj6zBNsJucsa9UVup8nwYVIk4sCqqBK21w>
    <xmx:Nr-PZ-qNq5nUynwqvaKVVDuL2VIC2U8P3pOZuxCNJ4uEE7_gSxmWZw>
    <xmx:Nr-PZyg64cEwGousYUERX2BCV92Kq0HhoA4S3G0TCqbB_WZn9hC8fw>
    <xmx:N7-PZ0ZZiP1PEymuU6AB85z5wBhItOWQUlrCUr6FNVkUUvRJSpcR49cC>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 10:37:25 -0500 (EST)
From: David Reaver <me@davidreaver.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>
Cc: David Reaver <me@davidreaver.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jonathan Corbet <corbet@lwn.net>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Krister Johansen <kjlx@templeofstupid.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/5] samples/kernfs: Add a pseudo-filesystem to demonstrate kernfs usage
Date: Tue, 21 Jan 2025 07:36:34 -0800
Message-ID: <20250121153646.37895-1-me@davidreaver.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series creates a toy pseudo-filesystem built on top of kernfs in
samples/kernfs/.

kernfs underpins the sysfs and cgroup filesystems. Many kernel developers have
considered kernfs for other pseudo-filesystems [1][2] and a draft patch was
proposed to investigate moving tracefs to kernfs [3]. One reason kernfs isn't
used more is it is almost entirely undocumented; I certainly had to read almost
all of the kernfs code to implement this toy filesystem. This sample aims to
improve kernfs documentation by way of an example.

The README.rst file in the first patch describes how sample_kernfs works from a
user's perspective. Summary: the filesystem automatically populates directories
with counter files that increment every time they are read. Users can adjust the
increment via inc files. Counter files can be reset by writing a new value to
them.

Subsequent patches build the rest of the filesystem. The commits are structured
to guide readers in learning kernfs components and adapting them to build their
own filesystems. If reviewers would prefer this all to be in one commit, I'm
happy to do that too. Initially, I included a more complex example where you
could read the sum of all child directory counters in a parent directory, but I
didn't want to complicate the sample too much and distract from kernfs. I’m
happy to remove the inc file if reviewers feel it's unnecessary. It is funny how
even a toy can suffer from feature creep :)

This is my first substantial kernel patch, so I welcome feedback on any trivial
errors. I tested this filesystem with all of the CONFIG_DEBUG_* and similar
options I could find and I ensured none of them report any issues. They were
particularly useful when debugging a deadlock that required replacing
kernfs_remove() with kernfs_remove_self(), and discovering a memory leak fixed
with kernfs_put().

In the future, I hope to contribute further by writing documentation for kernfs
and exploring the possibility of porting debugfs and/or tracefs to kernfs (like
completing the draft in [3]). I'm curious if the reviewers feel any of those
ideas are worth doing right now.

Link: https://lwn.net/Articles/960088/ [1]
Link: https://lwn.net/Articles/981155/ [2]
Link: https://lore.kernel.org/all/20240131-tracefs-kernfs-v1-0-f20e2e9a8d61@kernel.org/ [3]

David Reaver (5):
  samples/kernfs: Adds boilerplate/README for sample_kernfs
  samples/kernfs: Make filesystem mountable
  samples/kernfs: Add counter file to each directory
  samples/kernfs: Allow creating and removing directories
  samples/kernfs: Add inc file to allow changing counter increment

 MAINTAINERS                    |   1 +
 samples/Kconfig                |   6 +
 samples/Makefile               |   1 +
 samples/kernfs/Makefile        |   3 +
 samples/kernfs/README.rst      |  55 ++++++
 samples/kernfs/sample_kernfs.c | 321 +++++++++++++++++++++++++++++++++
 6 files changed, 387 insertions(+)
 create mode 100644 samples/kernfs/Makefile
 create mode 100644 samples/kernfs/README.rst
 create mode 100644 samples/kernfs/sample_kernfs.c


base-commit: fda5e3f284002ea55dac1c98c1498d6dd684046e

