Return-Path: <linux-fsdevel+bounces-10737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5667684DA44
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 07:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF334B21BD1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 06:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32939692F0;
	Thu,  8 Feb 2024 06:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YdLmn1bf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF04692EE;
	Thu,  8 Feb 2024 06:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707374709; cv=none; b=cXOMmWiTGUgbS3SgZh/bcm3WCGJUDA1WhiPBwTGg2WBs7cZLlunq+/j82hKPXhuXrwXNqqLq88Jtw7ymtqVPtHs6PmZ4ucwV8m+Z90VYZ7VKOMNmkW5V9Y6tx6skdP9I4B7zVJuWFVW9STTtXSxsiawdWMhXOzTbPHtc3plEGN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707374709; c=relaxed/simple;
	bh=g2xl39Fa4di9f+3GPmwdIPXkJ7s4ZyhPFbxxlwIu4U4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nuCtTHpEO8mUkY84XjR/0xKUAnTvkWbJZ6pNJSmdskpN9Zvr7LjeUfdpsZa8U2xI8y8uLlVIIyLiHuoLKIJKHzYm7EOGlvkDBj7d1t+4A7hsuOyGWkegknFcCFKJM+Bs79W7/DtNNeTKBE5BT3FcPZGUpBNQNhG4IQ3ud0RJDuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YdLmn1bf; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707374705;
	bh=g2xl39Fa4di9f+3GPmwdIPXkJ7s4ZyhPFbxxlwIu4U4=;
	h=From:To:Cc:Subject:Date:From;
	b=YdLmn1bfBfLUHw2MtKB7I1RRU6nmsLLkxjeiIjdUbpWZCnP6TDjYGRb85PHRPoV1s
	 V3SZb6bDJpB8TZcP6K08NrO1TQAXpt8wvRQxZ++/AYZxULaMQ+QayQ7/+d1SO431iL
	 oBw0GTjmvGuBN3/BgjxNDdNVoQ1huQISJrU6ahqhpd7AGo4oGIvnfTwIEzLJWCNWl/
	 ng7q1LzSNyo0vfPjFwB5cLwWoRzu7qLWSrfvV6SJDIZnUrfKOxKQF4uSd0VZf231dS
	 ld9F38ipankNIsTQn5zFFJ3w+FlrNI1FiwtBoWs2WD5IrGrye/SEWT6A47v88JWqvE
	 6CoUPLncVg/DA==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C4817378045F;
	Thu,  8 Feb 2024 06:45:00 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jaegeuk@kernel.org,
	chao@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel@collabora.com,
	eugen.hristev@collabora.com
Subject: [RESEND PATCH v9 0/3] Introduce case-insensitive string comparison helper
Date: Thu,  8 Feb 2024 08:43:31 +0200
Message-Id: <20240208064334.268216-1-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I am trying to respin the series here :
https://www.spinics.net/lists/linux-ext4/msg85081.html

To make it easier to apply I split it into smaller chunks which address
one single thing.
This series is based on top of the first series here:
https://marc.info/?l=linux-ext4&m=170728813912935&w=2

This series commonizes on the string comparison match for casefolded
strings.


Gabriel Krisman Bertazi (3):
  libfs: Introduce case-insensitive string comparison helper
  ext4: Reuse generic_ci_match for ci comparisons
  f2fs: Reuse generic_ci_match for ci comparisons

 fs/ext4/namei.c    | 91 ++++++++++++++--------------------------------
 fs/f2fs/dir.c      | 58 ++---------------------------
 fs/libfs.c         | 68 ++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  4 ++
 4 files changed, 103 insertions(+), 118 deletions(-)

-- 
2.34.1


