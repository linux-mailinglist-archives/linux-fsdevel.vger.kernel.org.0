Return-Path: <linux-fsdevel+bounces-59190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE860B35DE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 13:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F7F7C6DE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 11:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D6D8635C;
	Tue, 26 Aug 2025 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mKXP9Nzg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B53A284B5B;
	Tue, 26 Aug 2025 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208919; cv=none; b=ouLs+/g8/GR1q25xelaCrYjx6HaX35VezDqkRRXvO0Ln4IGTrg6UM5ialjY72vnOicwsYcwiQmgRFr7ISw79xQ9JEdU+3EM+koMYey2yBQZm/kRGu9qsCcYsXht67hjzztZjIH4/dvUeDjmtXBaDIW+GIZnU8Gp4BVSpYkjJU7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208919; c=relaxed/simple;
	bh=mgqUr5FCm8v0m8VuC5jqd29L3rQZyqOXb9+OdcGn2K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFc8tKH/KfxsFHXqR3f8RXAqhz5Og8DZJUBkSsQg5NcuRlUcsYh67I9UbpUMYN+DzmJ8RXl191HxG8Yz2XpOQbPbQyJfoXWgLg+f/psFMP506Rjo2z/8gMwbR9Y4lloMmDt9I3ISeqwzQIMRPu3DFVLCBzJGpa079QqWcP7LyYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mKXP9Nzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2BDC4CEF1;
	Tue, 26 Aug 2025 11:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208918;
	bh=mgqUr5FCm8v0m8VuC5jqd29L3rQZyqOXb9+OdcGn2K0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mKXP9NzgaGuS1r/EodzUTtOI9qyZec79gJfUwk273T82I+V7I23VoCaQccB0nRkES
	 SjPE6qo/1mblaWXDko7EaaxY8dMi7Z1yzZvzWoZEYl/dR2ZNQ0sDsOVF7SiUH9NA5n
	 d2HyPOR4dw91ud23ADfzaRBoEoCfnrIPz5uQNL6M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 295/322] cifs: Fix oops due to uninitialised variable
Date: Tue, 26 Aug 2025 13:11:50 +0200
Message-ID: <20250826110923.186345837@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
References: <20250826110915.169062587@linuxfoundation.org>
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

[ Upstream commit 453a6d2a68e54a483d67233c6e1e24c4095ee4be ]

Fix smb3_init_transform_rq() to initialise buffer to NULL before calling
netfs_alloc_folioq_buffer() as netfs assumes it can append to the buffer it
is given.  Setting it to NULL means it should start a fresh buffer, but the
value is currently undefined.

Fixes: a2906d3316fc ("cifs: Switch crypto buffer to use a folio_queue rather than an xarray")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 4bababee965a..ab911a967246 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4522,7 +4522,7 @@ smb3_init_transform_rq(struct TCP_Server_Info *server, int num_rqst,
 	for (int i = 1; i < num_rqst; i++) {
 		struct smb_rqst *old = &old_rq[i - 1];
 		struct smb_rqst *new = &new_rq[i];
-		struct folio_queue *buffer;
+		struct folio_queue *buffer = NULL;
 		size_t size = iov_iter_count(&old->rq_iter);
 
 		orig_len += smb_rqst_len(server, old);
-- 
2.50.1




