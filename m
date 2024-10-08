Return-Path: <linux-fsdevel+bounces-31320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFF6994870
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 14:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77221F27455
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 12:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8F81DED60;
	Tue,  8 Oct 2024 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kN05klGi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60091DED4D;
	Tue,  8 Oct 2024 12:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389564; cv=none; b=dij4RrGt61fsmmWTby/VbhCmZSqmQ8V4IxGJ2UmKJykRGoUbJtxJ5IrgyBWDQnedfSyJqaw6dUbAZ2LfF0a3xKPGjnWhgGJRrjMNjZ6kDwDPcE/nZD3Qkppi/yG7Sa9yC2dwk2Xlu4/AZhg8YSiBILMb3hwugpP9lQZ7VbCBxGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389564; c=relaxed/simple;
	bh=9OZSG/DQ+vm/Wy4qKHJNMCqT64wOmS0vE+hgWFR3ShM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+XSQc+FXA5gkqzU9/EDmCfYmhEr7WoyNVwbOvI0RcMSCia9p13Trp2kimf0JbQlqb3t99fI8ICkQX0ltmVhPuZTj8gA0VSkr8JpigcBzv/IMb+n8MNb2XDL7npnS8GPZa4fX2BPFhrMIauLUi9BanfdbuqMhBO/5cSUR8FXO5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kN05klGi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48832C4CECC;
	Tue,  8 Oct 2024 12:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728389563;
	bh=9OZSG/DQ+vm/Wy4qKHJNMCqT64wOmS0vE+hgWFR3ShM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kN05klGikCdplj92XIAKpBJnamgi4qIjhXcRFwONa1AzAct8Tw96BkumSxkrNyAJr
	 MPAW8mm8QJEDni7qeQ+03PDyAXJUVAMtMMjsVKdipR7MTtTeePtPlQIff7olbaA4QQ
	 WDZand/G8tGqudEN8OHHHmJ8UdQdXclyG/9gLJ10=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-afs@lists.infradead.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 031/482] afs: Fix missing wire-up of afs_retry_request()
Date: Tue,  8 Oct 2024 14:01:34 +0200
Message-ID: <20241008115649.525603250@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 2cf36327ee1e47733aba96092d7bd082a4056ff5 ]

afs_retry_request() is supposed to be pointed to by the afs_req_ops netfs
operations table, but the pointer got lost somewhere.  The function is used
during writeback to rotate through the authentication keys that were in
force when the file was modified locally.

Fix this by adding the pointer to the function.

Fixes: 1ecb146f7cd8 ("netfs, afs: Use writeback retry to deal with alternate keys")
Reported-by: Dr. David Alan Gilbert <linux@treblig.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/1690847.1726346402@warthog.procyon.org.uk
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index c3f0c45ae9a9b..e0885cfeb72a7 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -403,6 +403,7 @@ const struct netfs_request_ops afs_req_ops = {
 	.begin_writeback	= afs_begin_writeback,
 	.prepare_write		= afs_prepare_write,
 	.issue_write		= afs_issue_write,
+	.retry_request		= afs_retry_request,
 };
 
 static void afs_add_open_mmap(struct afs_vnode *vnode)
-- 
2.43.0




