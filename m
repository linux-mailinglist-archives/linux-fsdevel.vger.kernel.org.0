Return-Path: <linux-fsdevel+bounces-45135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33388A7342D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 15:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CD0317DDEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 14:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFFD217727;
	Thu, 27 Mar 2025 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="uDGesOdd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9051021767D;
	Thu, 27 Mar 2025 14:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743084990; cv=none; b=jhmpCR21sVzUotJXCWXk4KMQs4B4+ggiPASMyJ2hknJubCtHHs+dvF7nxQ8ml3ZTHPDnKYDpzowMcXoW9x+UUBi56wg1p6fnDscXmYfT2LjHBmDdOH5g2PfnmbPyohb81hwEuNXlhq5QVCN64mZ6hvtCnubSyZvcYvXWgW1rZhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743084990; c=relaxed/simple;
	bh=EKnWR1cNbnttkTTkCD6l2485+E+pvLEWZlJfUMU3Ysc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONdTHZhieQJwZVOdMnIGVF0LjUuifEiJmer5zGGuhq1xBzkx0W+Eh1ali/6/xcwYSvSHzgFIlyCqnM6n9mRORdEFdh/gFhHiXOFk0iFsrBmQrlVTiluRqIeAOGzPdMOGGnTENvTYH3k/PRu3L+SV6GtXx43SC0Ym51XhAn8zALw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=uDGesOdd; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1743084987;
	bh=EKnWR1cNbnttkTTkCD6l2485+E+pvLEWZlJfUMU3Ysc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:From;
	b=uDGesOddWvKl2/NnfMSRx4I/Ntgt1v/NDKLi+9L75cc5iCdB3NtAxnAHMjqrVXbuc
	 JTo/9v+6S417x1XnLtEHWGOKTjednMmGZNf31RuhCUR85WxJTZQL0ztVTNgeK8leh7
	 jsOY83r3nM11NfwE/fbkojP7R9Q1gn6FGth8W6ow=
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by lamorak.hansenpartnership.com (Postfix) with ESMTP id 0C9DF1C0015;
	Thu, 27 Mar 2025 10:16:27 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mcgrof@kernel.org,
	jack@suse.cz,
	hch@infradead.org,
	david@fromorbit.com,
	rafael@kernel.org,
	djwong@kernel.org,
	pavel@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun.feng@gmail.com
Subject: [RFC PATCH 2/4] vfs: make sb_start_write freezable
Date: Thu, 27 Mar 2025 10:06:11 -0400
Message-ID: <20250327140613.25178-3-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327140613.25178-1-James.Bottomley@HansenPartnership.com>
References: <20250327140613.25178-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a write happens on a frozen filesystem, the s_writers.rw_sem gets
stuck in TASK_UNINTERRUPTIBLE and inhibits suspending or hibernating
the system.  Since we want to freeze filesystems first then tasks, we
need this condition not to inhibit suspend/hibernate, which means the
wait has to have the TASK_FREEZABLE flag as well.  Use the freezable
version of percpu-rwsem to ensure this.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 include/linux/fs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index dd84d1c3b8af..cbbb704eff74 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1782,7 +1782,8 @@ static inline void __sb_end_write(struct super_block *sb, int level)
 
 static inline void __sb_start_write(struct super_block *sb, int level)
 {
-	percpu_down_read(sb->s_writers.rw_sem + level - 1);
+	percpu_down_read_freezable(sb->s_writers.rw_sem + level - 1,
+				   level == SB_FREEZE_WRITE);
 }
 
 static inline bool __sb_start_write_trylock(struct super_block *sb, int level)
-- 
2.43.0


