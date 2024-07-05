Return-Path: <linux-fsdevel+bounces-23185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3580992820A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 08:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63342862D3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 06:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFCB145346;
	Fri,  5 Jul 2024 06:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="tROV6jtp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C126D144317;
	Fri,  5 Jul 2024 06:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720160817; cv=none; b=nqhD5D+ZgMvMbuP2ZXzoYZ9HyP0ksdrnykRlPIhC032TajNZ+aiBJ/5T3jpxqIhFUYzvTlpgLH34FlqqFvAyjsQd4EVxzJTTu98KGdyY6u8fInD9W4km19Gu95lCAi0p19G16CcHNklXI4nWtmeHVaJ2CpzFJoRMkHtkPStEAUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720160817; c=relaxed/simple;
	bh=7qjRkxzynJKLuDNV6aHN6icqNqZXzMzBRW2u6EibQzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rifN20jiYpWQdhuTkEVapVuBnkW8XlpxAI/HnzK+9QKY5modawq6/ndi5Y7Lf/CU1Rxehc7ocM55c8oxYlftEE5KxFsB1dCHUELHABmG/wzDVwNzrCk0FEby4Qrw0G0CygAysMMSSaTqgTJ2JvTU4E4AUHGrITSDelTu8Hqr14M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=tROV6jtp; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720160814;
	bh=7qjRkxzynJKLuDNV6aHN6icqNqZXzMzBRW2u6EibQzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tROV6jtpqaq5vVcytA/0JyMgmmqXSnUD1nAH+xfyPFl3ezzznnAsz7zfswMQRQJh3
	 bA25UBr7pyiYkilIJ6oc1X/N5LwsvC7DrkAhpHq2vj/cDnkQNyzz/45wuPzfEzrWcf
	 JtqQDvb3IQM1WBptzZz/NzUBaxaUk815Pn+K6HjkDZncDdLNI1HgND03v79VBr6Vp0
	 SWzwj7WUhKpTuPZiogZlHOghc5N0dnx/mD6kzTelc33wSFI4h5BLEastlsHq6vftG3
	 jNBHSMGciwRE7+KO0mLbkkXnDHrM3eLhNRPw52VUgyUk7jK0ax1DOZ+naLI2EqqXZA
	 bGCydWIJmBhbw==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4E25837821F8;
	Fri,  5 Jul 2024 06:26:53 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	tytso@mit.edu,
	linux-ext4@vger.kernel.org
Cc: jack@suse.cz,
	adilger.kernel@dilger.ca,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	krisman@suse.de,
	kernel@collabora.com,
	shreeya.patel@collabora.com,
	Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH 2/2] ext4: in lookup call d_add_ci if there is a case mismatch
Date: Fri,  5 Jul 2024 09:26:21 +0300
Message-Id: <20240705062621.630604-3-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240705062621.630604-1-eugen.hristev@collabora.com>
References: <20240705062621.630604-1-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In lookup function, if we have a file match but not a case match in the
case-insensitive case, call d_add_ci to store the real filename into cache
instead of the case variant of the name that was looked up.
This avoids exposing into user space (e.g. /proc/self/cwd) internal cache
data.

Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 fs/ext4/namei.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index e6769b97a970..0676c21e1622 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1834,6 +1834,19 @@ static struct dentry *ext4_lookup(struct inode *dir, struct dentry *dentry, unsi
 		return NULL;
 	}
 
+	/* Create a case-insensitive cache entry with the real
+	 * name stored, in case our search pattern differs
+	 * in terms of case.
+	 */
+	if (inode && IS_CASEFOLDED(dir) &&
+	    memcmp(de->name, dentry->d_name.name, de->name_len)) {
+		struct qstr dname;
+
+		dname.len = de->name_len;
+		dname.name = de->name;
+		return d_add_ci(dentry, inode, &dname);
+	}
+
 	return d_splice_alias(inode, dentry);
 }
 
-- 
2.34.1


