Return-Path: <linux-fsdevel+bounces-60886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC8FB52800
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 07:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80BD31C2433D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 05:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AD925333F;
	Thu, 11 Sep 2025 05:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gXyaECvY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E723E21A44C;
	Thu, 11 Sep 2025 05:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757567139; cv=none; b=nUyGn4tzXEl3+3X55dvpMR1gpqa0Y2p+1ZeJAk08bH8M9v9pWAAG8qN4u6d99EJSgOi7vhfloWUYrsZlnk4/bTp3Hw5ut8xH36F3SVPmr47gZ3zFsugBFa0z0vT45GTOp+kXjWGFbi1wLjUVR9/Guws8eCt/4x852+u0wg9ZucQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757567139; c=relaxed/simple;
	bh=BzO7UduKHqPNy5QnzN/0UEzbNDHyeRykP1RBjmJbQCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbrj6cP6THBZkqErjf2mrwc4m58AXwpkdVmertrA5e2xmQfyWXiepBCQ5chkgakvzImJVM2Mk1Lc2D/AimB/qrvEu2yaLjRhxO9RmIXTqdLKN+UU5e4lP+z3ItpfDjeBU52edSBKK6Z8zKaX+c+RbueYfj2clpAY0Mm4wh2sHOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gXyaECvY; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=IhqV1U/WxPy1DF1aaAou7vHqrRXDTb+KWeD0D2KFlls=; b=gXyaECvY2QGmPnednI5Grrfy2U
	In6pCC0dkko5oHu0QLDlL/cR5dRPjrg3ijPH+gmr1eUVvM+ldbNWVjY7JZ3rhH/nG96PGpcNqzYdL
	JyoL3VBLxd6qi0jsd5467RKPQQcTzIphBnNQ9wyRHmcpDIg/UEvGbdK7AXd2DZMcDY08KsJRX6QLf
	z5uT3hNT7uZLEPrNFj5z/Y2fUPvF9NYFiyg53AkhZTT1m0f7XQce628XHAWAxUsNC2OdCwda3zWIy
	C6IdqFqqpkZiIuOTZrwjFZvmXFlhIontE4s2WvafAn3OoRXlCExvD86nABj5D30DiHg3sbPabgU/I
	y52zz7nQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwZV1-0000000D4kl-0zgW;
	Thu, 11 Sep 2025 05:05:35 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org,
	jack@suse.cz,
	neil@brown.name,
	linux-security-module@vger.kernel.org,
	dhowells@redhat.com,
	linkinjeon@kernel.org
Subject: [PATCH 5/6] generic_ci_validate_strict_name(): constify name argument
Date: Thu, 11 Sep 2025 06:05:33 +0100
Message-ID: <20250911050534.3116491-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250911050534.3116491-1-viro@zeniv.linux.org.uk>
References: <20250911050149.GW31600@ZenIV>
 <20250911050534.3116491-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/fs.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index d7ab4f96d705..6dcfc1c399ca 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3719,7 +3719,8 @@ int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
  *   happens when a directory is casefolded and the filesystem is strict
  *   about its encoding.
  */
-static inline bool generic_ci_validate_strict_name(struct inode *dir, struct qstr *name)
+static inline bool generic_ci_validate_strict_name(struct inode *dir,
+						   const struct qstr *name)
 {
 	if (!IS_CASEFOLDED(dir) || !sb_has_strict_encoding(dir->i_sb))
 		return true;
@@ -3734,7 +3735,8 @@ static inline bool generic_ci_validate_strict_name(struct inode *dir, struct qst
 	return !utf8_validate(dir->i_sb->s_encoding, name);
 }
 #else
-static inline bool generic_ci_validate_strict_name(struct inode *dir, struct qstr *name)
+static inline bool generic_ci_validate_strict_name(struct inode *dir,
+						   const struct qstr *name)
 {
 	return true;
 }
-- 
2.47.2


