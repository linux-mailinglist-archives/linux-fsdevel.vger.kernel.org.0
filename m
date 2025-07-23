Return-Path: <linux-fsdevel+bounces-55810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E22FB0F097
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 12:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D1FAC0A99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 10:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E422877D2;
	Wed, 23 Jul 2025 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blKmsVB9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1382BE047;
	Wed, 23 Jul 2025 10:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268311; cv=none; b=Eiypkn+CJTiFIKNWf066kuth0WbSHI8QQNu5fQKf2/rFEGok19uGuPDSx2xPwibjNPdSnWxGEUYZbpzHML6J12y1Q+RvM/apX0uUoGI6DhBMiI39QrKbxX1b+NivTV9udQpa7QwSaaedg1Jcq2l1WCIlrxEgwbNtzDRgBZhrtf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268311; c=relaxed/simple;
	bh=vOfqxaE2JSHY14npVlQLXM6nFov59W1x0adchgs8hJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqCPhH1s2ncYmx96WMEcOFk8gsZuAhzh1ClVVsNq+0Hn15/OMnuSrZPnrgppYYRXFpxzqVWR+YEGSLp3NOkRKVnhHu/21eN+Kse8AIlWiMU1rySY7DqU3cpoSp/CsP1dDBkqkOzkAQN126t7KhtMWqxqN9l/bZM33ITN3h617zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blKmsVB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962EAC4CEF5;
	Wed, 23 Jul 2025 10:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753268311;
	bh=vOfqxaE2JSHY14npVlQLXM6nFov59W1x0adchgs8hJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=blKmsVB9yjxppjYa9eir4epnZwyCuGZkV/tJMxJgK0S5ZPimSpuev5E+trRvC+0vW
	 dYQsbGNaJ3WjF0xHwSi7CtcNw2n6EJL8S+bd3J4IUgJZfnnguvc9FMI6F3s9ZJFVJo
	 Qf50bHy9KPmIEbdO/POxJxw6rpdzxiex8Gg1/HLPyzhCH1a0J3JssLrNNzUJP9U1rT
	 feHZEPw0NB0N4sAhDjHaQgHDEM9KrYpdDUpCrzMC6SpmFy98feiAx40dYKsyX9LNAy
	 GpGY17/7oxfDRfvTUurmjcxNvePMWCyp/8iyT1y0qYHcqm3gRdr1Dptecmd5wNasFz
	 ojB1nq+JrMDsg==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	fsverity@lists.linux.dev
Subject: [PATCH v4 09/15] fs: add fsverity offset
Date: Wed, 23 Jul 2025 12:57:47 +0200
Message-ID: <20250723-work-inode-fscrypt-v4-9-c8e11488a0e6@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org>
References: <20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=890; i=brauner@kernel.org; h=from:subject:message-id; bh=vOfqxaE2JSHY14npVlQLXM6nFov59W1x0adchgs8hJk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0HNCal7UsXymQUe1WwSbn3WUZi5r+KhfL7b5/8fKTh TvzJwjd7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI2Y8M/2MPvq9WfXkwmfHz xNVVJ1fJcp3TmnWNOydykRKbg97UY68Z/id08t3ctbPKobalYZPv/Wy+u66eQQ8+9z04HiI/9Zx FKA8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Store the offset of the fsverity data pointer from struct inode in
struct super_operations. Both are embedded in the filesystem's private
inode.

This will allow us to drop the fsverity data pointer from struct inode
itself and move it into the filesystem's inode.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/fsverity.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 1eb7eae580be..85831f36e2f8 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -28,6 +28,11 @@
 
 /* Verity operations for filesystems */
 struct fsverity_operations {
+	/**
+	 * The offset of struct fsverity_info from struct inode embedded in
+	 * the filesystem's inode.
+	 */
+	ptrdiff_t inode_info_offs;
 
 	/**
 	 * Begin enabling verity on the given file.

-- 
2.47.2


