Return-Path: <linux-fsdevel+bounces-9551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67F3842A1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 17:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F821C24387
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 16:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B87812C548;
	Tue, 30 Jan 2024 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="tq2gAYC6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E8D128367;
	Tue, 30 Jan 2024 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633592; cv=none; b=CKb6Szn3CB95sG3syAXpmMrQiLSOpx2hDJMFQPwXFJg2ADby8lSAC6oBHyAlYWl1eyC2+26cphR2CVzDfZuQMXfaM4fkkpvyQOi0HAe15XFncgQSwy+AzfXPoqSfAuK1nr5FFdSRO71VTtsIOwterHI+WSm0J9PX4r7kgvOJffQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633592; c=relaxed/simple;
	bh=x2kfVQnd3mtJ56l0EVkgCvgLcCn8XobB6WTDFgooC9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uuTqgZ0tenKUzIdHLnLucSlu9UY0rBV07llA1r0WnAOutS1qGIfJvKUA27Beh8xKmmMiQ8nA6W70sKoAUBxFiStOWByj2sIzCmDvxPFVq8OnEPdUKkVKAND3kE27HV+zedOmGbPqodLf+LcJUldTlsNTE1M7tdzWQKx7qQCZQ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=tq2gAYC6; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706633584;
	bh=x2kfVQnd3mtJ56l0EVkgCvgLcCn8XobB6WTDFgooC9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tq2gAYC66u0pgRQLdwQulg5tni9ICP4HQV5hNkD1Cq/9tUIG4HFmibZjHYT0d82Lp
	 cMicqUnPpJnkA5r9jAw2IGJZq1ai49+03rBKiMvJ7+EVVJ3fomY/mGR2UbdmuwD82g
	 4P1KAEd/fHlBxO4l/WrPaUDLeudpg4vY9nwVSw2A4WctYupqUoslr+z8KBr5VnR1kC
	 PZkebcd46BiUcXGPvLNjvaSeP0AjrYoRbx+QE9XFaoZGhkh7hav+ThwGlx6jS15Qp1
	 +KKuZLU3CDCOUFn6SKF6TtjyMsTWQ3wPrQ6S5XpGbBt0rNU6SjpdQh2odtFvPnz/1l
	 Gdx4KC/aBtZhQ==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TPWSb5HlgzVcs;
	Tue, 30 Jan 2024 11:53:03 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v2 4/8] ext4: Use dax_is_supported()
Date: Tue, 30 Jan 2024 11:52:51 -0500
Message-Id: <20240130165255.212591-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240130165255.212591-1-mathieu.desnoyers@efficios.com>
References: <20240130165255.212591-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use dax_is_supported() to validate whether the architecture has
virtually aliased data caches at mount time. Mount fails if dax=always
is requested as a mount option on an architecture which does not support
DAX.

This is relevant for architectures which require a dynamic check
to validate whether they have virtually aliased data caches.

Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
---
 fs/ext4/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c5fcf377ab1f..f2c11ae3ec29 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4743,7 +4743,10 @@ static int ext4_check_feature_compatibility(struct super_block *sb,
 	}
 
 	if (sbi->s_mount_opt & EXT4_MOUNT_DAX_ALWAYS) {
-		if (ext4_has_feature_inline_data(sb)) {
+		if (!dax_is_supported()) {
+			ext4_msg(sb, KERN_ERR, "DAX unsupported by architecture.");
+			return -EINVAL;
+		} else if (ext4_has_feature_inline_data(sb)) {
 			ext4_msg(sb, KERN_ERR, "Cannot use DAX on a filesystem"
 					" that may contain inline data");
 			return -EINVAL;
-- 
2.39.2


