Return-Path: <linux-fsdevel+bounces-50356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5682CACB113
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382173AE5ED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6240723ED5E;
	Mon,  2 Jun 2025 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7sY1J7U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A741723E329;
	Mon,  2 Jun 2025 14:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872999; cv=none; b=X8NugnmHjdAypIa4Ksxuc24NbVGrnZ6WZewWhdTgT1A4+tDvkOpViJKI+HOmInsTfpKqJjqKXdV4jGsk1EcEWTvPyQnyLehAgQkr0xO8HXYCnofUVLs4HeJwfRDQfvhe0dXT7WcDrtBXh/ntbcyOFB3Cgiqq5cKMzjAqPVvtwwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872999; c=relaxed/simple;
	bh=59lO1H0HFaeJYRaOFknHPnKwbcMhKqcR1RcYJk3zJp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e161TTreukv3rEN1LPT9iw8YYKShjmxiSsiA5TAGmS59uKG6DniclODbnfLWOtWuSUDe6Cy6H3lO/8iZbYtionWYeMFPgohRmS+zskOJXBc/DPJLyDQ/WbRmUuQwhpoWWQt23+zpIPCQV9T/Nkk0VDaMV4h67ef6QqpRDpA9c7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7sY1J7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FDEC4CEF3;
	Mon,  2 Jun 2025 14:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748872999;
	bh=59lO1H0HFaeJYRaOFknHPnKwbcMhKqcR1RcYJk3zJp8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E7sY1J7U36lAQIjOSujstSEN9p95d/5eGbViNZHlF7bmw4ugPeuLDAbyHwM99WPRw
	 AaCbTiGvz0rDx8VtndbetUPgJttSJsiGec0QCqzr/XhdHpVciZCv/oo6BDiDbLObwF
	 hU7Ud5Cff89h8Ys4ay/jCzEX1o87MzxbNv88OkXHycg220Clyjzn0BBSNKvmd2Ygrq
	 J4Tzxn/zxeVBfvX/CcfA9yXGqxdxcNjrXIH4yPhxqI35/zSfBIJTBtCrPb0EEsmHh+
	 SpxrkdwsKxUYrHV4u6siQz/bnlGzcZBgEHuG//3a9XKY1IGrVQWzZAALcHEH/Rn4O6
	 +6qBnypRG0z9g==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Jun 2025 10:02:10 -0400
Subject: [PATCH RFC v2 27/28] nfsd: add support for NOTIFY4_ADD_ENTRY
 events
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-dir-deleg-v2-27-a7919700de86@kernel.org>
References: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
In-Reply-To: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2234; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=59lO1H0HFaeJYRaOFknHPnKwbcMhKqcR1RcYJk3zJp8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPa7rIM5QBqdRTXsqVsis2QI9j4EVcJx+ejfPm
 Xe+c+6GkPqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD2u6wAKCRAADmhBGVaC
 Fel8EACuokS+qrJPqj8zBdVTDNgwG58ld1ZrqJbTMNMco5yHuFKVS5rQW/v0EkbXUkqcFd64fp3
 uq5ZMYMAzQTuC6bgdYLrK3aG3ugKSueTgHk3zEwH6xDuU8oFr4PnMqQMnmaowXbH3Wz0e3rah5w
 KkR8ogpK63qTrDooocrBySPFMGjdcUU4tPeiACQNEWOhRVh8X67oLTD/yV5N7GCOApF8FkdyXxI
 bw9Whr9pXzHaVK8Ee1YprvC5J/4m32/93f0bVcW7RNlbcckdi3PoB7oI9J0yfFuQ2X7nVFeQ9IP
 G8Ak9okfpKptMfiXGcecWZimnB2bz4uxIEX4NWMHXEyG7u5gEnwxd/Z5LIFvEvWuyVrwLd8NiS+
 RMiFXFD8T8JguzgmVMf4Ifssh57bIgXin9G4fSaUGQWQyTRMCZlCNqze79XBhpIDNQq4SrBe/gF
 WHlW1amr1/+2FRlJKs1Iv1dB1BkJEVl5PF4Pb9BTZR8xzU7EYvPNVN0MbWaTa+gpDv2xVwLE1NV
 5xLhejbXvczNk8Fnllw2eSjMELJUvtMbcm6LY4RWSqB6vNWUfp7YRxvml/mO4DoG9Yd8AACOY59
 R7aQ9QJ6mxpKqWV14vrkYJO2avqaBua2CwilDh5r20zqdSYV4FA+U0AYDbSnqSsorlIAOlrpff7
 qmh3/nYBPtqG+EA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add support for handling NOTIFY4_ADD_ENTRY events. When a notification
comes in, marshall the event to the notify_spool and kick off the
callback.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c  |  2 +-
 fs/nfsd/nfs4state.c | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 77b6d0363b9f4cfea96f3f1abd3e462fd2a77754..a2996343fa0db33e014731f62aaa4e7c72506a76 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2292,7 +2292,7 @@ nfsd4_verify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	return status == nfserr_same ? nfs_ok : status;
 }
 
-#define SUPPORTED_NOTIFY_MASK BIT(NOTIFY4_REMOVE_ENTRY)
+#define SUPPORTED_NOTIFY_MASK BIT(NOTIFY4_REMOVE_ENTRY|NOTIFY4_ADD_ENTRY)
 
 static __be32
 nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a610a90d119a771771cdb60ce3ee4ab3604cb8a3..9dc607e355d5839d80946d4983205c15ece6a71e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9697,6 +9697,31 @@ nfsd_handle_dir_event(u32 mask, const struct inode *dir, const void *data,
 			ent->notify_vals.data = p;
 			++nns->nns_idx;
 		}
+		if (mask & FS_CREATE) {
+			static uint32_t notify_add_bitmap = BIT(NOTIFY4_ADD_ENTRY);
+			struct notify4 *ent = &nns->nns_ent[nns->nns_idx];
+			struct notify_add4 na = { };
+			u8 *p = (u8 *)(stream->p);
+
+			if (!(flc->flc_flags & FL_IGN_DIR_CREATE))
+				continue;
+
+			na.nad_new_entry.ne_file.len = name->len;
+			na.nad_new_entry.ne_file.data = (char *)name->name;
+			na.nad_new_entry.ne_attrs.attrmask.count = 1;
+			na.nad_new_entry.ne_attrs.attrmask.element = &zerobm;
+			if (!xdrgen_encode_notify_add4(stream, &na)) {
+				pr_warn("nfsd: unable to marshal notify_add4 to xdr stream\n");
+				continue;
+			}
+
+			/* grab a notify4 in the buffer and set it up */
+			ent->notify_mask.count = 1;
+			ent->notify_mask.element = &notify_add_bitmap;
+			ent->notify_vals.len = (u8 *)stream->p - p;
+			ent->notify_vals.data = p;
+			++nns->nns_idx;
+		}
 
 		if (nns->nns_idx)
 			nfsd4_run_cb_notify(ncn);

-- 
2.49.0


