Return-Path: <linux-fsdevel+bounces-59187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71420B35D68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 13:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0139846143C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 11:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5218E342CB5;
	Tue, 26 Aug 2025 11:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z2HnDyil"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A229A33439A;
	Tue, 26 Aug 2025 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208032; cv=none; b=orvRHnDGfQpfhBXrwFuKAH8CG2IUfVMZZExy4630sVhS0YBAl5cmxgsJ004HPCNqywoot6+2uWbn67v/OClNb8Xo0MaN6Dgb5nBk5ZBPF08cnSuttDIcdQx0hvsU34J4o+eArEx6FxQtIlTG3lGjZk6A7kmhc1uAfVPoibzwT/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208032; c=relaxed/simple;
	bh=FKqOrWnliYqiV8I14JogT9Wes6Hb+XGv+pTySbx8IRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYFvl+yyJwdBSnBBl2aLV1Mrg6v2/CudoXJJWYQNvsgng/ebra0GA06IE1TEDiyM3sGjcwGcFeMdk9nb1cHVtLD20oKkrZJHNPNtRbdtjWP1U5sQN4Oq0CaFSPluaheI+SXfCOQlJXyOwm8t5Fhg40mhB3ppUmOx1onyTMwp18k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z2HnDyil; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21829C113CF;
	Tue, 26 Aug 2025 11:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208032;
	bh=FKqOrWnliYqiV8I14JogT9Wes6Hb+XGv+pTySbx8IRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z2HnDyilHzZ4NXCba41vO/+cGSqOX7xvgJUi0QLTkAk5Z3UwDu2r6PcaAlWClHn7I
	 /0SZTeLAR+9zBlV+dJEShz14DKiFJdVsGHbBk38W9zqWqhrSUw4xlpivd8qZozDySl
	 zE0jzO5tFTqp/BE4QLxsQdQv5pk9vv0JfQkmloCM=
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
Subject: [PATCH 6.16 410/457] cifs: Fix oops due to uninitialised variable
Date: Tue, 26 Aug 2025 13:11:34 +0200
Message-ID: <20250826110947.427266640@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
References: <20250826110937.289866482@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

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
index 4bb065a6fbaa..d3e09b10dea4 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4496,7 +4496,7 @@ smb3_init_transform_rq(struct TCP_Server_Info *server, int num_rqst,
 	for (int i = 1; i < num_rqst; i++) {
 		struct smb_rqst *old = &old_rq[i - 1];
 		struct smb_rqst *new = &new_rq[i];
-		struct folio_queue *buffer;
+		struct folio_queue *buffer = NULL;
 		size_t size = iov_iter_count(&old->rq_iter);
 
 		orig_len += smb_rqst_len(server, old);
-- 
2.50.1




