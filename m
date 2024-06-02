Return-Path: <linux-fsdevel+bounces-20719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BFC8D7318
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 04:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 424FBB21260
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 02:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4448A8F5A;
	Sun,  2 Jun 2024 02:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPLjG9Kj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DAB8493;
	Sun,  2 Jun 2024 02:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717295902; cv=none; b=XbQtc6WuG34S94gI8QMCOuzYKzNPptxi5ZpTS9jxeDaBqBLZcsaRCM/WnoJgfeunxX4WJOMaRPu8eu+Py2veTOrgUwIlNDdLHyram4Fm2BqMRCuLFxc117q9IG89ZeWVwcuF/WCddIGFRcPfZvbD/s9RSnOhUUvJ/5+jQMi6vTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717295902; c=relaxed/simple;
	bh=Uc7Edc2gqqzAFg0A6B27qQSCOHHel9nDUozWmg73GOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OtTSHJA1BM6iZIKtIxq2ID+58ziQANF5x9mBa+RScDdJSw4MhWPBCLNQi6q2m8GB99fv9TdAL7w76rnb5r23+keCDVHn4ASTNwsZJt2BkBPl6WmqlZjYChMjwP3MfFiEbszj9rSGbQBwgMhklm7TsTXP0NHGHFVPTIk9jOS4m94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPLjG9Kj; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso1367912a12.2;
        Sat, 01 Jun 2024 19:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717295900; x=1717900700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDSXYBnkhoFlTFb/2ZctlhGfFi3vGVZVEbq0hz4eBkQ=;
        b=FPLjG9KjwQrD390Zrp3k0bmsKxmW6cktr5Ck657ujlOxL9pbihExOSlX2QF4SCFbEL
         aA8sN3O8Ga27BY35Dpt4pBwvQanZs2ZgKnY37f+GmiiLwY4pTm6vnVdluyKgyiazKjsl
         kVv9Uq5n8MdAF81s88sLHziqc9uSXjXwaTSKFpsDC1L8otD8gYZe1YpkUVmtjQEi5FRm
         DqidQ0FqYT5e2xcqLNpMXNa8jsxrpGwE1o51IPamighT0IdVpPAsvDwOdG1XTywoIts4
         sjrTHiePQoh8c31ZsVZ3HiJFzbYrlCvEiJgzTX8PgTYkK0nopb5saqPoPHOml6UShfo0
         Z7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717295900; x=1717900700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDSXYBnkhoFlTFb/2ZctlhGfFi3vGVZVEbq0hz4eBkQ=;
        b=ZQeDHPiXahueXNYOvIvP9CQfMDsQF7lefOfZhAsufZljkp72g7+65bfwC5ed045IWi
         JEsjkvSPy5R0EuStqIlzoQE/nVOtAKh2wFgQu2gwi21T7PygEsBlreJ0Y2ijf7G1W654
         Hbk0E7qJUojqx82+Cev9p0g6YV+2j3QGCh0b2NhC9IY/ii079i2UXJfwvwSr+B9PeV2M
         eE7zJVozyuvY1w7G5DjOcFyfidorZhvPGtC+YMepmP/LUUMbSjQ5jjcdq3RSpD5H5btT
         R+pTxlrnr0ApUkAndezWjjtqniEDhb+5YIDlHfgqz3kFY0vUePlWh0h5ftSbWz+XndaU
         4fqg==
X-Forwarded-Encrypted: i=1; AJvYcCX/X/fmV5cL6kvcabPvqLyJ9QY4PYqsGXPanizWMjH5dR1PsexchdL+O3Ruvrd1Aa2sWMAPG4srsrUAfm4EGqTQ2+Glr6ypo/0hMzOE5fw75KAGTVZQBMjnNIYIPZQJi6wLt/uFhlR7H476P4KRD1ZCxnJh6SJErX/aptPRUooiReiomf4P9fqLZdUyFZaH9TqnvGb203C17HkwkIJsjcKyyABbReld2RW0JYNnTdhJfY4SrqackDiRQYalH00SeLwnGRhwwy3OEq0gc/wiar8aGvSo/kEvHx5ntRTZog==
X-Gm-Message-State: AOJu0YxOyBPi7nMwf44BTSCi3Mb1nVdgeASBs8g4iUvq3GDitGW4bbo5
	oIMl5gGTk2rD36fBGN3JyflX4GD21n7+SEj5vaHeTzkTsO1vaBFG
X-Google-Smtp-Source: AGHT+IGSkiCT1T8H8uAL0usG+RhmGH5uSZT9xuU+RtiT09NgmrJQRFy+Yk6pxuNFE1Yrq524r9yvYw==
X-Received: by 2002:a17:903:30cd:b0:1f4:7d47:b889 with SMTP id d9443c01a7336-1f6370209femr47779675ad.30.1717295900374;
        Sat, 01 Jun 2024 19:38:20 -0700 (PDT)
Received: from localhost.localdomain ([39.144.45.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323ea21csm39379575ad.202.2024.06.01.19.38.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jun 2024 19:38:19 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	audit@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH 1/6] fs/exec: Drop task_lock() inside __get_task_comm()
Date: Sun,  2 Jun 2024 10:37:49 +0800
Message-Id: <20240602023754.25443-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240602023754.25443-1-laoar.shao@gmail.com>
References: <20240602023754.25443-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Quoted from Linus [0]:

  Since user space can randomly change their names anyway, using locking
  was always wrong for readers (for writers it probably does make sense
  to have some lock - although practically speaking nobody cares there
  either, but at least for a writer some kind of race could have
  long-term mixed results

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/all/CAHk-=wivfrF0_zvf+oj6==Sh=-npJooP8chLPEfaFV0oNYTTBA@mail.gmail.com [0]
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
---
 fs/exec.c             | 7 +++++--
 include/linux/sched.h | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index b3c40fbb325f..b43992d35a8a 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1227,12 +1227,15 @@ static int unshare_sighand(struct task_struct *me)
 	return 0;
 }
 
+/*
+ * User space can randomly change their names anyway, so locking for readers
+ * doesn't make sense. For writers, locking is probably necessary, as a race
+ * condition could lead to long-term mixed results.
+ */
 char *__get_task_comm(char *buf, size_t buf_size, struct task_struct *tsk)
 {
-	task_lock(tsk);
 	/* Always NUL terminated and zero-padded */
 	strscpy_pad(buf, tsk->comm, buf_size);
-	task_unlock(tsk);
 	return buf;
 }
 EXPORT_SYMBOL_GPL(__get_task_comm);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index c75fd46506df..56a927393a38 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1083,7 +1083,7 @@ struct task_struct {
 	 *
 	 * - normally initialized setup_new_exec()
 	 * - access it with [gs]et_task_comm()
-	 * - lock it with task_lock()
+	 * - lock it with task_lock() for writing
 	 */
 	char				comm[TASK_COMM_LEN];
 
-- 
2.39.1


