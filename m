Return-Path: <linux-fsdevel+bounces-58064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75231B288E6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 01:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22231CE4EE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 23:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A7A2D8DAA;
	Fri, 15 Aug 2025 23:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="CJkZ6957";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hwPLoMui"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DC5285C8D;
	Fri, 15 Aug 2025 23:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755301201; cv=none; b=fIH9LdyggCHMKjDzIzX6gVYScqPecWBtOmNf0NRa/doP2pZJbWKRRW3wphw0Wksy/c7f4lYeoU5P165gZrpMJq6P0U+PGNvyL/UC0xC1cOrMcUEaUYdhCljgndiLN6qdA/Mz8k0Rn87s9PMhv7LWNua2CEBgUX7DFkzNZC6+J7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755301201; c=relaxed/simple;
	bh=rvwUzMzqyTQ5VqQQhXXaXcHAzc83y3ADtovBvbfznwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNclsO0NFx496Z0d553398gLPdo3YhIZ0o6COkXYLT1ex5TrI6pp4Z+Dk9tAn3peOcNVAkMq2geDOGGcg0HIhySZpVf5E6mrK62rbfPuu87LGpRoQJ66wLCpeU2B7i87ybQf34xWJTedh37Mfl3qbznui7ufz966Emqb4KE3ah4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=CJkZ6957; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hwPLoMui; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9FCA014000B7;
	Fri, 15 Aug 2025 19:39:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 15 Aug 2025 19:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1755301198; x=
	1755387598; bh=ysxGKdmacR1jImBbFNdapk+E8q3B6D5l8QdS9hmlj44=; b=C
	JkZ6957clUeSfKcNKxIGkBGQ//e2i+bc+P/MxsLr5TgDyoLhilpsWF/ZhD0Dbwbi
	iNVsVo5epgswE/znf0Z8LrLCqlw34SW+Q6FtWVzOeHJ8keIO+9LC/FCFfzCOPMCN
	U6dXoSB0s6oP+/sr8pV/h5UDUqKwYCoRTGRo2tlOJ6dq+NXkkyROYLqyn+K8MMBC
	f4MR1raMln12bS3DjgPPwDSX8vUr6CXfpVZxtZio5PKFk4MeRs9usCdauSyJ/671
	A+WEimWTYEznPU0SwxpvxgCtNEGnZsIyqjmH7SM2LPifSR+gPRobqwwV8XaUSEoP
	pGf4HAfMMCoEKDPA+mdag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1755301198; x=1755387598; bh=y
	sxGKdmacR1jImBbFNdapk+E8q3B6D5l8QdS9hmlj44=; b=hwPLoMuiQt07Dkkci
	eMtO2RMKbh+MxoV8lwzFYBK8zSzrpC0nUKZFH67jo/u4ZlSVKhjS8cBEWPLJt2Xm
	njLCmq3Fd8xpLEoVm8B42cSKiwcfSjHej31mmWa0MdNvwUpdapBzMDMYzgSMOzX+
	rGqus7cPI2839ELlqsnnApaVUri8ktmy99iyeyYXzuSuzFE6kU+7upvI4YsgKNFt
	oBRQgQ8nqpTHSbd4VJtX0mg2Gki5M4wBIyDVWMsQUWb17tZ2QXZePTxQfqB3C6T9
	iv1Fw1e3SwFP6YUB3q3v4SgX/E1mGXGQZeCWZy30loXVk/VeW4e5LiWVRppKIdu8
	6ZWOg==
X-ME-Sender: <xms:TsWfaIOXboGGrI9Uqfdww4PNgu4x6H0UOc9lbnXT6AYQ21bHjjm69A>
    <xme:TsWfaCwJrwb9Ha9W6bQ5ge27E_xAx6v1kF5mVZOnHc3yTFGmno59u5-rqczT9HUBq
    NNYLZMjs8zM93_iAic>
X-ME-Received: <xmr:TsWfaIXPoQnqLohrTuM6IEnHNBGo1quW9utkPCeg-ewAb-39cLNKisFKAR_AX8ha5OnopbYdwXY8jpNSYbd7EreJlAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgoufhorhhtvggutfgvtghiphdvucdlgedtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepgedute
    ffveeileetueejheevveeugfdttddvgfeijefhjeetjeduffehkeelkeehnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihhopdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhs
    uggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlh
    dqthgvrghmsehfsgdrtghomhdprhgtphhtthhopehshhgrkhgvvghlrdgsuhhttheslhhi
    nhhugidruggvvhdprhgtphhtthhopeifqhhusehsuhhsvgdrtghomhdprhgtphhtthhope
    ifihhllhihsehinhhfrhgruggvrggurdhorhhg
X-ME-Proxy: <xmx:TsWfaEM1zZLipvgxxCkwcntZP9DQ-zmWraG2bnXb9q7atu4CEbSFKg>
    <xmx:TsWfaKDaZqEf3d17c09rfc1jPtAJEnKorgRFfjMTYIAS5yvtLPy0pg>
    <xmx:TsWfaBeUQwA9ZcZR31MQ27FpM7s5XMfiwgSMSSJY4G_FvkAPsOZAnw>
    <xmx:TsWfaJPV778mxHNw7TrZUHgFv8tj8Xya7miniPhSuHD0vQ7DCeS1qg>
    <xmx:TsWfaLtneBBKie269hHhP6VQ_hgwEiGTdLj7TZpLV7U0V-B2tw__WhGR>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 19:39:58 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@fb.com
Cc: shakeel.butt@linux.dev,
	wqu@suse.com,
	willy@infradead.org
Subject: [PATCH v2 3/3] btrfs: set AS_UNCHARGED on the btree_inode
Date: Fri, 15 Aug 2025 16:40:33 -0700
Message-ID: <786282400115bf7701d7f9c6b00a9549f67e29f7.1755300815.git.boris@bur.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755300815.git.boris@bur.io>
References: <cover.1755300815.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

extent_buffers are global and shared so their pages should not belong to
any particular cgroup (currently whichever cgroups happens to allocate
the extent_buffer).

Btrfs tree operations should not arbitrarily block on cgroup reclaim or
have the shared extent_buffer pages on a cgroup's reclaim lists.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/disk-io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 123c397ca8f8..6a6ed8c1389c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1930,6 +1930,7 @@ static int btrfs_init_btree_inode(struct super_block *sb)
 	BTRFS_I(inode)->root = btrfs_grab_root(fs_info->tree_root);
 	set_bit(BTRFS_INODE_DUMMY, &BTRFS_I(inode)->runtime_flags);
 	__insert_inode_hash(inode, hash);
+	set_bit(AS_UNCHARGED, &inode->i_mapping->flags);
 	fs_info->btree_inode = inode;
 
 	return 0;
-- 
2.50.1


