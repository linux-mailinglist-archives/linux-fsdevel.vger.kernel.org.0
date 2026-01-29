Return-Path: <linux-fsdevel+bounces-75847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AraIjowe2n2CAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 11:02:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94869AE552
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 11:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9907F3028C35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 10:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CAF374170;
	Thu, 29 Jan 2026 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj40/k3x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F22237E2EC
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769680938; cv=none; b=WEFpx0nn9160qExME0tnnUBmROPQsX+hNCvWOIaTdE7ZOiDwDsx8DFysNUsFuxQE8vCFRPp7EDVwZJrygPAflZTTjOy71dPzYLa8qbw5/EqzEGn1/HFamruKt3YYNOZ+5sn7MxLwsw7NkvhIUe0dE00KAkgyD/mpbWaUtYcQ+qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769680938; c=relaxed/simple;
	bh=N8CoUqnMYZ7QSAR/ducsKL3rx3I7wiUS+KVe3IW/pFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSncH8g2OLKw6iu+OfYQUBX2d9BAXDvsgJe+Z1luPvfO4G4A6MuLhnZOVIw2BlET3JPk46I7cyTIAZGDPWXiUZcHdL0OuHX+pBihgaW45ndkII6ERvV9Mf+cScZVzTx8s760AckR/H0rgzNOeSh3Y+1EJSgxA8pSr8yOClG5tj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yj40/k3x; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-658ad86082dso1489004a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 02:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769680935; x=1770285735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+A5PA2QuPZwYWlbPtFj9y2qIk4W2THrdGdKigGUGxc=;
        b=Yj40/k3xWyVigscQ28BvhsHjcDNgMMI0fN70Aq9w1Nv1aKw9n0MJRbGR/bQ+50iQRp
         1+/6IAgpKTg3yBsvkKJ2Bo6MF08spz72e9sNWtQoC2KjZrABMKjTBUo1EngNK4hBvtxN
         H1forTeO8AJ/4WDDrwdmGDyn6UtemzEJNSwGUAe646VgAvNUYQ1KM1hrZRoM9UVmejKX
         fQ5DW+X13+rJWB+M6nIgoaJkNVb2kUm/v6od7kC5IiEZCQyIPplW1pHgR2Ktff8naruz
         xxNHu9GmwXVBEZi0FJM29CExDym6bRLvKCb88S9+YNbPa1d99Dm+7hGHtU04FwSurBoL
         ZGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769680935; x=1770285735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1+A5PA2QuPZwYWlbPtFj9y2qIk4W2THrdGdKigGUGxc=;
        b=gcb5ShuGAKX5/ywaK52Nh+U9s9VWh7n9YSvQ/rCcjHOKHyAZLqezkmwRQ38Z/Tm+sw
         myi9gWryp4FVB4e69b5ehB4/9LHP6RCIP/62T4DWBMc7ydGeB5K2xZJQ/MqDDAB7++nu
         hFbMgnLMDt26hDok3HzBwqBUFI2aeSP5p8Ck9kT+bzoBdiILi8YDMhkBOhCd3DWT5A37
         ywxRSiUQI66K0q+BBZfZiwa1nnn13mnNf3rq1E17OOoxNyYft895UqNrscsx+mPCIGki
         IYI/paFQamLFcCwVHNl4ZqCjYmE8pqQfxaIOWNGj98DMiLXn+LMTlsH5OuoIQq9cp/tK
         RdYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAPFApBz7Ebg0pFx+fnMoTk4cvllLAxYqvKvg6HQo//hnL4GBp6qQwMhugXR12J3fileLLhVdOOjF8J4Yr@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl/w5NlxOnpXu5q2B6F3+hW5/bFxvmhKORwPBP6vGDbv4ju7Y6
	/Jx5ghO8lppkPLEV9kngIBSxjQbARlu/Q7Hwd6CNM7KRlhZDBkcDvzpd
X-Gm-Gg: AZuq6aKFLnIX64bvV0EDdbMkeFUy5W+3IDYN+CngPps0oCEPKZwrDaWSZmd4IbTrcDB
	JrT4zMsDg9QN/r8mo4y+EXX4JSCu0Pmn5v6WgAy5kusmlAhJa0wcvutXlUWD+QXO403PjYFp38d
	CmDCvNyhX+1CdKr/yuinXA4mHPuyz9jcrqQeYXp26tvgS2lIZpoxWAkuKwGUptTdERKDMlzgvNn
	3x9nhdy6PBiG7zgaAOyHBF8CKxf1EWJwbZDPL6ARi+XhB8u83GC15tPB7Z7svHCWR+UVtXZFdsX
	32Z3arl+zagFZWF5+pI0KFtqYVyi+X+mURO+Iytu9AIX8T5LUEPwYEJPCRqxd6N8GWLOEWJkbPS
	FTKDI0Rr/NTBsLorrKxmEYzK2hSBYiofvFEoBMg65jiy6oBmqHdm8hFIy3gDvmJJafatXhOp7KJ
	k7va4wyqjlThFWRAzo22fhuhpEne6Jm4OOyXO7WZSyE7iBsITNX15AXymxVvL/DjJZDfLJKrqEV
	E2ZfrCYY3IaEL+j
X-Received: by 2002:a05:6402:5213:b0:64b:58c0:a393 with SMTP id 4fb4d7f45d1cf-658a60c3da9mr5373004a12.30.1769680934810;
        Thu, 29 Jan 2026 02:02:14 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-983a-6411-8910-8120.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:983a:6411:8910:8120])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b4691db4sm2608438a12.22.2026.01.29.02.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 02:02:14 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Neil Brown <neil@brown.name>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v4 1/2] exportfs: clarify the documentation of open()/permission() expotrfs ops
Date: Thu, 29 Jan 2026 11:02:11 +0100
Message-ID: <20260129100212.49727-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129100212.49727-1-amir73il@gmail.com>
References: <20260129100212.49727-1-amir73il@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-75847-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 94869AE552
X-Rspamd-Action: no action

pidfs and nsfs recently gained support for encode/decode of file handles
via name_to_handle_at(2)/open_by_handle_at(2).

These special kernel filesystems have custom ->open() and ->permission()
export methods, which nfsd does not respect and it was never meant to be
used for exporting those filesystems by nfsd.

Update kernel-doc comments to express the fact the those methods are for
open_by_handle(2) system only and not compatible with nfsd.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/exportfs.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 262e24d833134..0660953c3fb76 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -200,6 +200,10 @@ struct handle_to_path_ctx {
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
@@ -244,10 +248,14 @@ struct handle_to_path_ctx {
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


