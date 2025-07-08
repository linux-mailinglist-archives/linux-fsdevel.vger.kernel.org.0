Return-Path: <linux-fsdevel+bounces-54281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7152AFD338
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 18:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 095403BB246
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 16:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB962E49A8;
	Tue,  8 Jul 2025 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mSZnhYnW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDEA2045B5;
	Tue,  8 Jul 2025 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993516; cv=none; b=EJREsyoCnbrB1Mpu85QlI4RiRQaUbJFwp10ZZ455Aygqs7quyVMmwDW+qpLahhs4uAlcbdyaVHzs6Ioc5taFA8dkZ6YBwIKzILzA0sxkaOYokEpgGDina6v4wYI9PJsVUNGc7qJxDmaBTAnL3Hm5nH7pMBYc5QJb+kN8Wg/ZetI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993516; c=relaxed/simple;
	bh=6ilEutLt/KzJnLoEJg7lOe4AAoCmAMLmdxd+QYxN2ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPPJm2TJZJnKCk+6qOlKy5eCSgQ2ekNODTzxYWwoOH/AZ2IarxWeJEU4PL6r3jfqPGV2bytjTS4qdcYVb7NWj/Qq4Pq5GmOZkrU0whfpgyRl3I4vK1l1smR3oYegIhq+Tu88ta7fP644MvzZjsOEbzJKBBfE4SO1N2ufzeVaXEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mSZnhYnW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B294C4CEED;
	Tue,  8 Jul 2025 16:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751993515;
	bh=6ilEutLt/KzJnLoEJg7lOe4AAoCmAMLmdxd+QYxN2ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mSZnhYnWdSLGxTjLsG1MN8qLuZnYgXEfTz8F4NjtSYteTnspAJzClOB2UfeNFjt2R
	 j4W7cEYZ8AIpJdyJkaQ/yQ9rrMsO/whxAHo0cz/Q5jzCPKmjn/9C/9E3YD9c0UGAkP
	 PxIgIj49lWy2jPieE0Kxu1g+W+wDLyNCDNnhjRJo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 099/178] netfs: Fix ref leak on inserted extra subreq in write retry
Date: Tue,  8 Jul 2025 18:22:16 +0200
Message-ID: <20250708162239.236123921@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162236.549307806@linuxfoundation.org>
References: <20250708162236.549307806@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 97d8e8e52cb8ab3d7675880a92626d9a4332f7a6 ]

The write-retry algorithm will insert extra subrequests into the list if it
can't get sufficient capacity to split the range that needs to be retried
into the sequence of subrequests it currently has (for instance, if the
cifs credit pool has fewer credits available than it did when the range was
originally divided).

However, the allocator furnishes each new subreq with 2 refs and then
another is added for resubmission, causing one to be leaked.

Fix this by replacing the ref-getting line with a neutral trace line.

Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/20250701163852.2171681-6-dhowells@redhat.com
Tested-by: Steve French <sfrench@samba.org>
Reviewed-by: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/write_retry.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/write_retry.c b/fs/netfs/write_retry.c
index 9d1d8a8bab726..7158657061e98 100644
--- a/fs/netfs/write_retry.c
+++ b/fs/netfs/write_retry.c
@@ -153,7 +153,7 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 			trace_netfs_sreq_ref(wreq->debug_id, subreq->debug_index,
 					     refcount_read(&subreq->ref),
 					     netfs_sreq_trace_new);
-			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
+			trace_netfs_sreq(subreq, netfs_sreq_trace_split);
 
 			list_add(&subreq->rreq_link, &to->rreq_link);
 			to = list_next_entry(to, rreq_link);
-- 
2.39.5




