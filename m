Return-Path: <linux-fsdevel+bounces-28296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7870D96902B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 00:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1141C21091
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 22:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5676188929;
	Mon,  2 Sep 2024 22:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="co2PdNaA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1BF187877;
	Mon,  2 Sep 2024 22:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725317750; cv=none; b=cnQQhFhgs5wyTxU2rklOnMNPAZ3bnlxfY0Tb00axlftbT+TTmOKyoM/UvaBNQai/ovgr4fVARBjyxcQxgDznHTIXLTp827tvbkeMS+Et6/DGqvuSAUjw1gOewafAxtQ9+8hYZ/ZGdFH1slDs05BMHimPMkkHVPul4HdrUhx/UXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725317750; c=relaxed/simple;
	bh=l30+gRG9WniuL4zakhw7ichn6tZUizjJnxqFeqXpegU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G9VKVZKQdWfVFoKko7crRyKCDunAbo1Ic9ygkBBaxAVIYXxIY0xgQ7pKNniXMKX5pPk/abfPmx0dc5j0/4jKYjGsbVdNWbDcClqzVwzMrJh9M3VHoO/jvfd6o0/ROb88mVijVxdMdHOX4S8vEfFCKt5CccOVWfpWjNZUolpZXkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=co2PdNaA; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=78SnBPaA8AMbufjsrTkG+60p1swE8SZ2JxVNDuChTVM=; b=co2PdNaAbIHqhBdYCbOVQvfiQj
	eqbK3sEbYyRP3Eu70TX6yDrX0S9XQRy/B/Nh/Rkvy5zetX1tSMwOGwyVTiYAOtw5Bqks8RrgWnDut
	PFRafJ8jC4JKCn3ga7iWiiU7g0ULzHwp/EBbz3OfvrUEuRlSOV/FCjTqwTqa7P0sfMlNP9l6UO0S1
	s43sWtqT1Tx3fF7JDtPuAP49wm2oRZJq5hdUajCOSl9ubwomaIRxqf+jbuWf4aPvF/7TKgk/1gfmz
	TZ0V1gBUkxu6hTqKSWeLaOSAVJ4RcCWr0v9v/yPiTtOVU0hdWCdXO6cnODl3YiOKPmAQmubQgoXi0
	8VZ7oPTg==;
Received: from [177.172.122.98] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1slFxI-008VrL-Cc; Tue, 03 Sep 2024 00:55:28 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	krisman@kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	Daniel Rosenberg <drosen@google.com>,
	smcv@collabora.com,
	Christoph Hellwig <hch@lst.de>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Gabriel Krisman Bertazi <gabriel@krisman.be>
Subject: [PATCH v2 2/8] unicode: Create utf8_check_strict_name
Date: Mon,  2 Sep 2024 19:55:04 -0300
Message-ID: <20240902225511.757831-3-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902225511.757831-1-andrealmeid@igalia.com>
References: <20240902225511.757831-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Create a helper function for filesystems do the checks required for
casefold directories and strict enconding.

Suggested-by: Gabriel Krisman Bertazi <gabriel@krisman.be>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 fs/unicode/utf8-core.c  | 26 ++++++++++++++++++++++++++
 include/linux/unicode.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index 0400824ef493..4966e175ed71 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -214,3 +214,29 @@ void utf8_unload(struct unicode_map *um)
 }
 EXPORT_SYMBOL(utf8_unload);
 
+/**
+ * utf8_check_strict_name - Check if a given name is suitable for a directory
+ *
+ * This functions checks if the proposed filename is suitable for the parent
+ * directory. That means that only valid UTF-8 filenames will be accepted for
+ * casefold directories from filesystems created with the strict enconding flags.
+ * That also means that any name will be accepted for directories that doesn't
+ * have casefold enabled, or aren't being strict with the enconding.
+ *
+ * @inode: inode of the directory where the new file will be created
+ * @d_name: name of the new file
+ *
+ * Returns:
+ *  * True if the filename is suitable for this directory. It can be true if a
+ *  given name is not suitable for a strict enconding directory, but the
+ *  directory being used isn't strict
+ *  * False if the filename isn't suitable for this directory. This only happens
+ *  when a directory is casefolded and is strict about its encoding.
+ */
+bool utf8_check_strict_name(struct inode *dir, struct qstr *d_name)
+{
+	return !(IS_CASEFOLDED(dir) && dir->i_sb->s_encoding &&
+	       sb_has_strict_encoding(dir->i_sb) &&
+	       utf8_validate(dir->i_sb->s_encoding, d_name));
+}
+EXPORT_SYMBOL(utf8_check_strict_name);
diff --git a/include/linux/unicode.h b/include/linux/unicode.h
index 4d39e6e11a95..fb56fb5e686c 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -76,4 +76,6 @@ int utf8_casefold_hash(const struct unicode_map *um, const void *salt,
 struct unicode_map *utf8_load(unsigned int version);
 void utf8_unload(struct unicode_map *um);
 
+bool utf8_check_strict_name(struct inode *dir, struct qstr *d_name);
+
 #endif /* _LINUX_UNICODE_H */
-- 
2.46.0


