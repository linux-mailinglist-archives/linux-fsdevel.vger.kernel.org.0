Return-Path: <linux-fsdevel+bounces-30090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 598D4986126
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 16:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 894C81C2145B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 14:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B237F18F2DA;
	Wed, 25 Sep 2024 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="dIUEdKsi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EEF17E00C;
	Wed, 25 Sep 2024 13:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727272698; cv=none; b=ZOeImoPlHZ17vrBOuy+2bO/XDOFIQL2zqr9k4IOL0HfZcLer58zvdSmrUxHZLbzPMs6LclPoT9vVXqzqSitLJerSKqfzs72b5LRwB+3qnjmrEsFju4QZYtCboScJxDxKTQUvWOGX4CPLOBs6FcZ4DJQADEGbYBILSprNkTWVQfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727272698; c=relaxed/simple;
	bh=24MQxyf9XU7dt8p5pJ4zrnOq+YqSfpDo/gZcai/d4jo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=DsIYWP1IXnohejJpWznYcEPTBWBtiNPPWF01UxnuQKYMBkGBi17sWifl1ZM/hFVSxyhndeMb6EwrU9Htu6GXlIyPPCzgAsJRdAu6fq/P30OlaiRNYwqPIDUyd5CZTQJG3+xDwsbhPZwLJGTyhktjv+/nABe3baCc90xDOrpL1fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=dIUEdKsi; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1727272384; bh=xDQ/047YH46qDRI7w0LS7iGSEzIWbAIopOEzW3KNye8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dIUEdKsibdJ9eB6mwGiMepFV+OHk5tdw69lrvlVAIY59UO9kMKFsqmajSpNh/ScC9
	 KLXq6Dl6cM7gl08G3UUCNI3J1l9rp33ObVUMzuOjISnkwB7kOBQgt57uiWxJam4oNK
	 j/z7MB4p/nLhR2AquYRvBwex8IdhRJHxNOlpZdyc=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id D402DE7B; Wed, 25 Sep 2024 21:53:00 +0800
X-QQ-mid: xmsmtpt1727272380tbx63wbr1
Message-ID: <tencent_4A8FBB4133EA9E461B0C4B2C1B2425FFBA08@qq.com>
X-QQ-XMAILINFO: NY3HYYTs4gYSCD4BjJa3oLj2wgetdTniRHGpPBJX6dm2difxmsv/fwTkOwmJY5
	 jt6PpNTqYy5rI38TJLLAuCSkY9gVU7Q9eiFK6tOPRHW+31HToo0IeL9lZyo0XXXcimsazmvxSkDU
	 XsppQQ+lej3dGDsGYjcz9Z08yBJUjda5SL4rMt1d1cXVHFgfCSPofoHQAMIwwua3bZgglf/2fTJw
	 xuva/rW5nYj7cLej6f+agYfo1K4Jd8lmwlDaz90B6FatPhiCWahiQQMk5syEUo1GtcCAtBSS7Rgw
	 rBSa8TEPCMvN1MavC1SapZm9spMn/wQqFM033aokDKbrrPktRBuHT8AZSPSkSDRVgWboMxmvBxMX
	 ekLHmFDkJEeDNKscbmtad1u3WHrP5TcGft0y06HnSDNW+y0AYGL1b49jWnDtiZRdJW50hntyYd0N
	 sOpUrOaR0n9yKJc+YykZIdNC2gl1yL0noZWUlgWkw0cQ0etXcVT6NUlA8JOPM6UlmYJjkaLdq85R
	 x4lcUzbzuewh0jinBtzNh19RyTs282HQ1RIFzFor4QViHsDAf/WtbTzR1bpk5X9s7k/HcWIDy185
	 lygJYt2/BZCw0Cf9LlNZVdop+HbUSXAXbduPEy3s53lwUdYzELuE72EXJkYfrS7DYoWz48HEz5Jc
	 IN6eB9GzQO/fjMGyo0ejV53kUdAU35ydnwuYV0FH3Ve3siXTDuqhGJMD5J5VHTjj814m3n7Hkbx7
	 fdfR+id0RUI/Dg5gA35pOZHciygL2fMkXpUGuCIIYuZM3UhXsdEKMA4W9VdxgJSh4OcGqUUPBFUB
	 vKYjJ1FNJFlQ9ShemPz6QYdIPX4C4dxThAuTeQe7gceAyVgGfkcE4XwNJQqGYNGjPJ5Jr9aJh9RN
	 K1BcHgb5UrMqPm28AnpE8Z1NLhhBjFLGC/rI9hrf8e6BDFb31tb9YjGQ2In0U8WL2M9OS/fwlG+L
	 Fr9Wtq65s=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c0360e8367d6d8d04a66@syzkaller.appspotmail.com
Cc: brauner@kernel.org,
	jack@suse.cz,
	jfs-discussion@lists.sourceforge.net,
	kent.overstreet@linux.dev,
	linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH] bcachefs: return the error code instead of the return value of IS_ERR_OR_NULL
Date: Wed, 25 Sep 2024 21:53:00 +0800
X-OQ-MSGID: <20240925135259.1575815-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <66f33aad.050a0220.457fc.0030.GAE@google.com>
References: <66f33aad.050a0220.457fc.0030.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot report a kernel BUG in vfs_get_tree.
The root cause is that read_btree_nodes() returned 1 and returned -EINTR
due to kthread_run() execution failure.

The -EINTR needs to be returnned to bch2_fs_recovery(), not return to
"ret = IS_ERR_OR_NULL(t)".

Reported-and-tested-by: syzbot+c0360e8367d6d8d04a66@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c0360e8367d6d8d04a66
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/bcachefs/btree_node_scan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/bcachefs/btree_node_scan.c b/fs/bcachefs/btree_node_scan.c
index b28c649c6838..df7090ca1e81 100644
--- a/fs/bcachefs/btree_node_scan.c
+++ b/fs/bcachefs/btree_node_scan.c
@@ -281,6 +281,10 @@ static int read_btree_nodes(struct find_btree_nodes *f)
 			closure_put(&cl);
 			f->ret = ret;
 			bch_err(c, "error starting kthread: %i", ret);
+			if (IS_ERR(t)) {
+				closure_sync(&cl);
+				return PTR_ERR(t);
+			}
 			break;
 		}
 	}
-- 
2.43.0


