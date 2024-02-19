Return-Path: <linux-fsdevel+bounces-11984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0434859D55
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 08:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7D2283270
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 07:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF17B25569;
	Mon, 19 Feb 2024 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="A3Spoc6m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B242555D;
	Mon, 19 Feb 2024 07:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708328739; cv=none; b=TaPJy0e5CB58cAi4mRIFm6dpk89eR8O7uLKju2krtQ+dL/pI04jKL5T2BMJ3RMOXqfqIziod6xNBZTBn+9gXYehex9nTfC0MwbgzbHk7en2arJpiz8inyg8O1owMMcr46ok9S1r2tjuGcqmoga46+s1Maf1P6+1jfNpB9dloiiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708328739; c=relaxed/simple;
	bh=cVITJNZ35p97HDzRx3PUv0ugSW5S2fLqOWH88XqFex0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MXz83uAjZMAXf0XCCMJSFxq1r7FVrhKIl6EEaGY5s5wWmsQ7Yu3CA7ST9ZevsTnmLG529/KL6x5sNsLXNhrE4xZfrVyD11/oq7VSQOBifUKY4h2vvUxfo0KlrhP8kCZQ3+TlnX9MVzsYoQm5TjB7dCahLe1i+brFWGSZYVsMDZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=A3Spoc6m; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708328736;
	bh=cVITJNZ35p97HDzRx3PUv0ugSW5S2fLqOWH88XqFex0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A3Spoc6m3rIO/ZaFjo4xSa2Yz05An+usrXy+vgwSd2FERceXHyl6/CPF9AQ4stOn0
	 2h3yE9qfgQoF6MBIRH7o7MbI9g1ZTiGAImVt4ZBhEJRfXS6JR8TFuOTss+KWCZwa7B
	 j1zpSA3eQdjQ4oYEnq3YGjxoB4JKk4fX3gE0MUgWt/2ZM9iYaL2FtSi/ZRBJpYEhin
	 x7W2jI1bTE6Xi6PGKFjG6EifXf4v/2KTPG7qfdozJsKvlO20B+2ZW0YjskcCsN4Fxl
	 0WgWGBN59nx1ThA65xoJa7L3N1YdpC4XXmp+Bftt2Db1IHy5Q1cGKdIk/UsaCkHtK4
	 VPTgsjJIOOEQA==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 51F4D37820BC;
	Mon, 19 Feb 2024 07:45:32 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	eugen.hristev@collabora.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	krisman@suse.de,
	Gabriel Krisman Bertazi <krisman@collabora.com>,
	Eric Biggers <ebiggers@google.com>
Subject: [PATCH v11 6/8] ext4: Log error when lookup of encoded dentry fails
Date: Mon, 19 Feb 2024 09:44:55 +0200
Message-Id: <20240219074457.24578-7-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219074457.24578-1-eugen.hristev@collabora.com>
References: <20240219074457.24578-1-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gabriel Krisman Bertazi <krisman@collabora.com>

If the volume is in strict mode, ext4_ci_compare can report a broken
encoding name.  This will not trigger on a bad lookup, which is caught
earlier, only if the actual disk name is bad.

Reviewed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 fs/ext4/namei.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 6e7af8dc4dde..7d357c417475 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1477,6 +1477,9 @@ static bool ext4_match(struct inode *parent,
 			 * only case where it happens is on a disk
 			 * corruption or ENOMEM.
 			 */
+			if (ret == -EINVAL)
+				EXT4_ERROR_INODE(parent,
+					"Directory contains filename that is invalid UTF-8");
 			return false;
 		}
 		return ret;
-- 
2.34.1


