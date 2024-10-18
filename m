Return-Path: <linux-fsdevel+bounces-32388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A54929A49E5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 01:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680B4283DB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 23:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3DC1917D8;
	Fri, 18 Oct 2024 23:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZaX8zxY/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86FF19046E
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 23:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293560; cv=none; b=ndc5KfQmFEWG8lolTw7DF49/zL+/xWu2qVg6AuH6zD83K30nbnr5+pSLOhqGRq41Pzck9HFZZUQLtAOCfeqVtd6pUQdHvPbnBuWyhuvey3PZK5A7ifczeKK/sxYdMRI1O4ZUfk8gbVYacDpiYh7yzlz0bCdK5/RPQXCKCBeEz04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293560; c=relaxed/simple;
	bh=ILu5roTMNLi30ZqlLLov+pkCcbdUgQBjejjHjQ6Y8AM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciSxW8JPlAMIY2tV6+XCB5TVsBi0xyT9EmPYTgtg9sOoEA2O9sw5ezCcI2QPUU+MOKu+jKFQ85GTGizHEfIfzSych16/Z8+w9soKpi5WXGyQ2P7VvWRkJ7vSgI+6vWZC867emJb1zgTKvJWsz95L//lCK9ctoYWZ6Twx63COioA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZaX8zxY/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=nEtg1G+606pABvYVMrrr0iQEdhjJjDd/e26fl/qwRTY=; b=ZaX8zxY/MG6/TH5t1E24UWgGJx
	FJAdUwo2JnE/Q03evyktRFPCpnhkTJ2w991a/U7evtgNnELwb/i/Y1WHkUzdP47ZNfJmPQEpZeMTY
	EbVBHGbnL7TiL242sn9d5HVxgZsCY8lExGdvzc27lbzhLYeHJ9i7+BGPRfTf1wDYTKCcb/BG03D4D
	QwNZlKxJxQhuGdyveBpbT5RgPKv5YUjV4HsN19h1HcQ8LoHIJeoNYpsFY5+D2E8kvK3NtuWgCs5rz
	pZcY0yWOpfAscHtgEfL3k2g9xXVussjqTLs6qRGqoCtytjraMiHU/hwHkOk/CpGZFRVs2eE0HDUL5
	b7aWFQHA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1wFZ-00000005E6r-2DVh;
	Fri, 18 Oct 2024 23:19:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Evgeniy Dushistov <dushistov@mail.ru>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 08/17] ufs_free_fragments(): fix the braino in sanity check
Date: Sat, 19 Oct 2024 00:19:07 +0100
Message-ID: <20241018231916.1245836-8-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018231916.1245836-1-viro@zeniv.linux.org.uk>
References: <20241018231428.GC1172273@ZenIV>
 <20241018231916.1245836-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

The function expects that all fragments it's been asked to free will
be within the same block.  And it even has a sanity check verifying
that - it takes the fragment number modulo the number of fragments
per block, adds the count and checks if that's too high.

Unfortunately, it misspells the upper limit - instead of ->s_fpb
(fragments per block) it says ->s_fpg (fragments per cylinder group).
So "too high" ends up being insanely lenient.

Had been that way since 2.1.112, when UFS write support had been
added.  27 years to spot a typo...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ufs/balloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ufs/balloc.c b/fs/ufs/balloc.c
index 1793ce48df0a..82f1a4a128a2 100644
--- a/fs/ufs/balloc.c
+++ b/fs/ufs/balloc.c
@@ -50,7 +50,7 @@ void ufs_free_fragments(struct inode *inode, u64 fragment, unsigned count)
 	UFSD("ENTER, fragment %llu, count %u\n",
 	     (unsigned long long)fragment, count);
 	
-	if (ufs_fragnum(fragment) + count > uspi->s_fpg)
+	if (ufs_fragnum(fragment) + count > uspi->s_fpb)
 		ufs_error (sb, "ufs_free_fragments", "internal error");
 
 	mutex_lock(&UFS_SB(sb)->s_lock);
-- 
2.39.5


