Return-Path: <linux-fsdevel+bounces-11637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A498559D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 05:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9B2DB2A696
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 04:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831F11755E;
	Thu, 15 Feb 2024 04:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iZwnhjtD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705EA17586;
	Thu, 15 Feb 2024 04:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707971267; cv=none; b=Vj2mEZpoVfKUUTNTgfHB0CxjwhsrdESRgNhWX32Xmay+vHIUGusbizrKhrTOSRs0S2r4pO2LArvZw7I5Safu/0H86lf7Tli+o+BJdevBatoep/+cGGjP87yxS9NqJrrCNHq0oZw+SSGUBZnv8a1T174fXDg9JQSbvY4cDnoptKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707971267; c=relaxed/simple;
	bh=cVITJNZ35p97HDzRx3PUv0ugSW5S2fLqOWH88XqFex0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iz0kkrpGv4hvo30a7pGtcip0e6hCQCJIgvCxiGZwX7Vsk9d0yQ0RfX3UQ0rsn8JJoqGmFNTwS3WXimFmbJkENY0bX7rBpsohoxeVVeuYzZD6BHAU/caoNel+r3HfkA4SxYFKg8uYy3sLrC236zfsukv2rG2ZX1o3pHCpX8f2vsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iZwnhjtD; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707971265;
	bh=cVITJNZ35p97HDzRx3PUv0ugSW5S2fLqOWH88XqFex0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iZwnhjtD3ErUfbmTLbOTNncaq2pEk2ej3TWecor+LbfGW1B2bkNxfbvmuP019bVjm
	 e5rbzMu5QzfkWi20kcRUYQX2kXf20g7uQP2UlXCERQMWfBioYff1+7VJ6EX8MAL+vr
	 LeDf9LirL+vm/RalrRGZSO14devm7KAfjLs1Ed8+EYgi9tBT0RdoEXWRPIHzA6WYf/
	 RjZdAK8x986WAPjgqKjGdxHEV9f3FaLHW5EQ9iku/tGTXcMGzHbjN7Ck+zlxXsjPBi
	 l/19w5zatSLYpz2HFnQtDaLzOeXvtvoRez7vqyyK/nfSrfNnpjGYvfVdOM14znu/4H
	 y4nVjvaqcsTpw==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3D14A3782098;
	Thu, 15 Feb 2024 04:27:39 +0000 (UTC)
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
Subject: [PATCH v10 6/8] ext4: Log error when lookup of encoded dentry fails
Date: Thu, 15 Feb 2024 06:26:52 +0200
Message-Id: <20240215042654.359210-7-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215042654.359210-1-eugen.hristev@collabora.com>
References: <20240215042654.359210-1-eugen.hristev@collabora.com>
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


