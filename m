Return-Path: <linux-fsdevel+bounces-75711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH2GCnnweWnT1AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 12:18:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7465DA02FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 12:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD43B300BE32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 11:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD46B342518;
	Wed, 28 Jan 2026 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrHKVg+s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969533346AF
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599012; cv=none; b=GHxNQCnhCfngO8gDZzpUOWpQzfJRFhX9XSFRO545Oua8ACR2Gy4cAqrQxW+JCPR0Kq9IWmbVFXlDe+6jxc65rxsc7Hc6GiAUr5Y5h1d+4jsJWn35Xq3c5JZxq3nAOB4KQfXrj2729Sn9RHGTtPupIo4F50zbTBMh3jJEc+uxdIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599012; c=relaxed/simple;
	bh=kHHrIi/9pFSZfFlOQ9x01UfFnZezIPNDPP0dXHKNkkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D53YXIEgoeX/VxoFT4vghQiDWd3kA30cFWUjvjq/A2oWwedcUUd59d7jRUkLo5FT1sfqCoPYcF/uWEK1axkPhF7pvQnv5zQcT4yY+L7Jp8sw1Xv85UhgZTUp7CdmMb7XD8EIwgnOhW9P1c+k2A/yJXIe2tyuhpUlmPAbS+Nbv24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrHKVg+s; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b884ad1026cso1092005766b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 03:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769599009; x=1770203809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBTmk/INQse9PvflQCUftCG1UKyoLWVpYz7UTDyNwNM=;
        b=KrHKVg+shOx0aC2zj9pXZpIC78CXsE3insRBcky64i7Vcm46YI2/1fZMYWcacZMtcS
         2JtS/gGWYs1GXH9tEJBJDa2UTQbbaETAH/+ymOtsTHE0E/cjPflR2V0x+TkT3FKY3zDH
         UPl+tbupIaE/EYcfYqgm3k4qDwfXTJb6ZH6y/xWuVWCfRJtoPEgg1UzK2d4kDAVuBpfc
         G0db/8K10GE/TAwNadRUtclJjlK4Iqp2pM64RcxzNYM9VhrTI3n6N8BSTpD0G2ArTP52
         sg+0RZ81P25YcT+Xw2ZNWXGNXReniF6aTDiWmE7K/LfFMO5mW6jpPG7Q6Z8Z/o7Q3htp
         BpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769599009; x=1770203809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mBTmk/INQse9PvflQCUftCG1UKyoLWVpYz7UTDyNwNM=;
        b=H4jmKOnXetyF1QDiGK02fAK8MyMKkpKbcdzoLlf3Js9IsxTX7ZMbh75traHjmU3BQS
         /Vi+WvGYl9h/4NB/WCwkMHJ+OagNmGb1SwUtw2gHXvtecQo3PLBYMgAwBiSZR+nwg/YI
         RdBwcYQ6WF7r/fMIpup97J00dDgsoUd37FqMnv75SQmFDmwNAck6cawasKdmQ885sAdS
         Fp4phYseSTu55xpziEtDzTC1T5rlg+dQ9GElAXfs75nzxQHmdIjPSwzAT6bcIU14vbPf
         AgjxbIX2gN6LUyiusJWm43x8BsbWQivgYL61lkWh1mrBkHBr7gHU5+q7OR8TKtEFxyP8
         8BDg==
X-Forwarded-Encrypted: i=1; AJvYcCXvVoRziTw6lz7980gCprUrNnbaUxdfa8Z3jL886v8NLJMSyvMgckc9Hr/gESBm+OsvXhte8NptMpg33RGv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7GWhuMn98QLQ4pHGSPMaUOjVNxVLjs0iUfak9n/dC9vmHaQuQ
	/l33ftaYHhB04nrGI3NWCbNuLx/ZaYAOc1dNS2bwHp3ZjprBKOFwbwch
X-Gm-Gg: AZuq6aLpoRBkSQumddJopBClY4mIVcEMtSqYpI32jqK6PAn8OdTyq+DWJ5JGIuMOVya
	q+/zh6FkVoCm3OmSH0uFyrXEw7kbGs4uWRGeHnXhzVGSnVKb2nqQ3G2YOcid9kndyZtgHVT8HSU
	5/lgM70hGe1nK+Qyg/cTfuduIUaVXxaovBzSL9K4HW0jfLHReq7BaN4a5+UQJcTIa8ta+qbMdFh
	PGjOWje7TfhcWauySYKEMsoJ33yAF1RbGBPQ04/qkhvgtX67p6sczX+fn6y7/7EgvIjFXXyu8Qy
	G7A++3RL3YQl+jR+7crHiI0pbsYbm36Y3zgOB8ngUvFqORBhiQEInMPWftByFmbLFzbSMg/89yk
	FjNeTvWll6FwClmGa0FaeecDNh3Izuv1jI7fXjAMySsO7sCDy5CDj/rkosjr5W55t33x4ioz2Aj
	NMEa5P7Qbnd0kbXNfffbBWrCjXUgXz8NoA23l6Bv8xvem3jq/mr83cdcMZDumH9gBN269FwY3g7
	jUpEPZA2hy1SDoU
X-Received: by 2002:a17:907:60cb:b0:b88:22f1:7697 with SMTP id a640c23a62f3a-b8dab19478amr340474966b.21.1769599008541;
        Wed, 28 Jan 2026 03:16:48 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-970d-2293-1f03-db81.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:970d:2293:1f03:db81])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b4691e5esm1399186a12.16.2026.01.28.03.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 03:16:47 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Neil Brown <neil@brown.name>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/2] exportfs: clarify the documentation of open()/permission() expotrfs ops
Date: Wed, 28 Jan 2026 12:16:44 +0100
Message-ID: <20260128111645.902932-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128111645.902932-1-amir73il@gmail.com>
References: <20260128111645.902932-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75711-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7465DA02FA
X-Rspamd-Action: no action

pidfs and nsfs recently gained support for encode/decode of file handles
via name_to_handle_at(2)/opan_by_handle_at(2).

These special kernel filesystems have custom ->open() and ->permission()
export methods, which nfsd does not respect and it was never meant to be
used for exporting those filesystems by nfsd.

Update kernel-doc comments to express the fact the those methods are for
open_by_handle(2) system only and not compatible with nfsd.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/exportfs.h | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 262e24d833134..fafd22ed4c648 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -192,7 +192,9 @@ struct handle_to_path_ctx {
 #define FILEID_VALID_USER_FLAGS	(FILEID_IS_CONNECTABLE | FILEID_IS_DIR)
 
 /**
- * struct export_operations - for nfsd to communicate with file systems
+ * struct export_operations
+ *
+ * Methods for nfsd to communicate with file systems:
  * @encode_fh:      encode a file handle fragment from a dentry
  * @fh_to_dentry:   find the implied object and get a dentry for it
  * @fh_to_parent:   find the implied object's parent and get a dentry for it
@@ -200,6 +202,10 @@ struct handle_to_path_ctx {
  * @get_parent:     find the parent of a given directory
  * @commit_metadata: commit metadata changes to stable storage
  *
+ * Methods for open_by_handle(2) syscall with special kernel file systems:
+ * @permission:     custom permission for opening a file by handle
+ * @open:           custom open routine for opening file by handle
+ *
  * See Documentation/filesystems/nfs/exporting.rst for details on how to use
  * this interface correctly and the definition of the flags.
  *
@@ -244,10 +250,14 @@ struct handle_to_path_ctx {
  *    space cannot be allocated, a %ERR_PTR should be returned.
  *
  * @permission:
- *    Allow filesystems to specify a custom permission function.
+ *    Allow filesystems to specify a custom permission function for the
+ *    open_by_handle_at(2) syscall instead of the default permission check.
+ *    This custom permission function is not respected by nfsd.
  *
  * @open:
- *    Allow filesystems to specify a custom open function.
+ *    Allow filesystems to specify a custom open function for the
+ *    open_by_handle_at(2) syscall instead of the default file_open_root().
+ *    This custom open function is not respected by nfsd.
  *
  * @commit_metadata:
  *    @commit_metadata should commit metadata changes to stable storage.
-- 
2.52.0


