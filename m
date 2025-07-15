Return-Path: <linux-fsdevel+bounces-54960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88649B05B75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 15:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46FA16D267
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 13:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8A52E3364;
	Tue, 15 Jul 2025 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KtufEJ6N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DF02E2EEE;
	Tue, 15 Jul 2025 13:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585614; cv=none; b=NRolAejtI9k/5aMLxhvr7fXmH9WKidIZ32ljRamRE18tQvAsc5bfntCQlIiq0vJqVoKPsjQANCz6Hj9zAjTyUZgUaMPdWGacNzNQxCPfodwg0oqdwBswpclt2yoE7ZkxFFMq4W/YlxRsllv7KRFBVst5WX9ZI8Bc8pq0imYqhKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585614; c=relaxed/simple;
	bh=GttpmwWLPpfA92yt7p/T9TwPaMcvB84SRYcfzZnep+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEp/kmY4rBrWb503iD8XBGRrIgeL0n7e0MH5tCiSJz4f6gfEyFfwfI/mZbGZgP/XJ418rSfXxNn2SKVOhbwHIh2yAUuIMoFR4IoToRHAqzDvQ4KhDgZR4RxMBBpRKVf4VGULzdRmJQfVy/EBOT35wTwlA+tTta8UKySzgD4+rv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KtufEJ6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C872C4CEE3;
	Tue, 15 Jul 2025 13:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752585614;
	bh=GttpmwWLPpfA92yt7p/T9TwPaMcvB84SRYcfzZnep+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KtufEJ6N/vpWkBvRT3ANTGQmUudH6HV1Orx+34Ose86XPyavHoR520C+qhFxRrhXo
	 T70CQL/R9aJXqMblfI7LmmLiJN0LoQJBm6gu15vEqPtY5l6Qlvl2E5nrUHNdT1s4UR
	 V4+4i2ir1xBB4FsDHjyIdjaXIGCcdlKlVuZWR79E=
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
Subject: [PATCH 6.12 106/163] netfs: Fix ref leak on inserted extra subreq in write retry
Date: Tue, 15 Jul 2025 15:12:54 +0200
Message-ID: <20250715130813.111931582@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130808.777350091@linuxfoundation.org>
References: <20250715130808.777350091@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

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
 fs/netfs/write_collect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 7cb21da40a0a4..a968688a73234 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -285,7 +285,7 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 			trace_netfs_sreq_ref(wreq->debug_id, subreq->debug_index,
 					     refcount_read(&subreq->ref),
 					     netfs_sreq_trace_new);
-			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
+			trace_netfs_sreq(subreq, netfs_sreq_trace_split);
 
 			list_add(&subreq->rreq_link, &to->rreq_link);
 			to = list_next_entry(to, rreq_link);
-- 
2.39.5




