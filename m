Return-Path: <linux-fsdevel+bounces-37440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1329F2572
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 19:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CE54164608
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 18:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051341B87EA;
	Sun, 15 Dec 2024 18:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvySvrVg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6376026AD0
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Dec 2024 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734289100; cv=none; b=j8gOEtDwGO0R/tkZ+qrhpSDdnkaAVhaCCG8wPIKBFO7F63RRV2ev75SIbLMgp82w+dMxSdC/b0KqepYT+yrfMhozpi8ufFU2+w17LXuHH5ehwdlSSI1vRxMrH6+eU46s2b47hy+mse589RjlpuilEwwbuWNqq3ET59/NcPa+alY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734289100; c=relaxed/simple;
	bh=t7qr1lAnuyn5glnbksnk2e7/3hobBFT+J4jHlhyHKLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PT6oBVrjBT9HWney7tOeKdaUpjnLJ+8GI0ygyCNta1/wEsgvyRLYfbzrlEbP+lbq9PE7owf9IwOfVuqlUTRWJwzdoub7NkmnaaJ8mjQoBK6DCz4mx7ObObhNTP6xI6f6EKuO7PqX49++tM8gyWRmUgGXDXQ1VC6Ksd/AkrFW7Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvySvrVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33063C4CECE;
	Sun, 15 Dec 2024 18:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734289100;
	bh=t7qr1lAnuyn5glnbksnk2e7/3hobBFT+J4jHlhyHKLg=;
	h=From:To:Cc:Subject:Date:From;
	b=AvySvrVgjwhdXpDpeXgekyAUSuyilVxkR0ojRfy4gOOF9Rcrwmj7mU9L8TK2DwXZS
	 C3zXCA+ee2FOPcxYBZKFWYMgf32Zxb9CeE2+SzZlU6f2mRUpws14sfLdgNSvO/RIzG
	 0ldqCFplWmy5l+ja/SxPHU9sqYvU1YkIXCypQTSq1gBZlaSF7N8Qpcciu8NnIIbBI8
	 PknK3xwYcZjnWdTV3sxTCykULvtFg9CWAGpyjq4ISAC6jXechcj28Z8f0N7gHYs8Of
	 vP9UDo6N99Io9/0B8lVGmk4ajuKUTJ+57Vao8hwpF+sRCO61WjB1W0LNZmKqebNmnC
	 EM2MohvN4BRBw==
From: cel@kernel.org
To: Hugh Dickins <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 0/5] Improve simple directory offset wrap behavior
Date: Sun, 15 Dec 2024 13:58:11 -0500
Message-ID: <20241215185816.1826975-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The purpose of this series is to construct a set of upstream fixes
that can be backported to v6.6 to address CVE-2024-46701.

Changes since v4:
- Refactor and rename find_next_sibling_locked()

This series (against v6.13-rc2) has been pushed to:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=tmpfs-fixes

Chuck Lever (5):
  libfs: Return ENOSPC when the directory offset range is exhausted
  Revert "libfs: Add simple_offset_empty()"
  Revert "libfs: fix infinite directory reads for offset dir"
  libfs: Replace simple_offset end-of-directory detection
  libfs: Use d_children list to iterate simple_offset directories

 fs/libfs.c         | 163 ++++++++++++++++++++++-----------------------
 include/linux/fs.h |   1 -
 mm/shmem.c         |   4 +-
 3 files changed, 81 insertions(+), 87 deletions(-)

-- 
2.47.0


