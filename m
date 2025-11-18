Return-Path: <linux-fsdevel+bounces-68911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD78C68315
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 09:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 00F5D24286
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 08:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED7130C601;
	Tue, 18 Nov 2025 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZDPyw+n1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C46308F25;
	Tue, 18 Nov 2025 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763454405; cv=none; b=PKSuRo9qWxDZspjacR3ZAM1pFCcDk+Rlez1qFKMW3vLiDFNQ2dGkHG0Sk9MA5ue/7Om0VfpX1hKijmrOnvupOKttYs4+qElyxY9+DToOzOObR2+DnD/+Y62LH9xdCCWQarxytCNldPNMvRoDjpwe9QkaQdaHcB+2cox4CrBUXvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763454405; c=relaxed/simple;
	bh=xO3DdKtZm2GDO6q7bPI75O/Ok01ThLO7wRgQXObHvw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIIU/pXETzg2+5ZKPXjkEFVj9cu3dgkefC0tUWkHP68Jm2NROBVVISbR/gThxepXaB6OhJlpwjivIq03Wm0f4vImjp6MbgMNuoqGVqElY0dhxlzkxC0teVlx7KFMPw9pI53lLrTMJInYtar75Fn3m8XaLi10MyRZcyErFNasKcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZDPyw+n1; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=6a
	3Qr5pnCBxhdQPyLBRaNx2IzXP1rmnmnWeyJtAHnXA=; b=ZDPyw+n1h9kJ03b941
	cKLn55f5UafpBi+/MW/j5Dd7tZgVlF/phjbxjDG17oIMLlqjNVhN0guI6J0zxU31
	cXxlqpZxtmTtt448nTfTIZhp78lhOz5tP1buu1URVUD3XKuTK7+MvNChUOSIUoSs
	0C6DnoF+whbT+DvxhckzM8cG0=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAnu_KILRxpyC6zEQ--.29019S8;
	Tue, 18 Nov 2025 16:25:46 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [RFC PATCH 6/7] exfat: introduce exfat_count_contig_clusters
Date: Tue, 18 Nov 2025 16:22:07 +0800
Message-ID: <20251118082208.1034186-7-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118082208.1034186-1-chizhiling@163.com>
References: <20251118082208.1034186-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAnu_KILRxpyC6zEQ--.29019S8
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrykAryUCF4UKFWDGF45KFg_yoW8Cw1kpF
	4xJw4rJrW8X3Z7W3W3Jws5Z3W3Cwn7CFyDtayfA345trZIvrn5Cr9xK343tFWrtw1DGFy2
	q3WFgr1j9rsxGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UmQ6XUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbBgAYKnWkcJ5WpogAAsd

From: Chi Zhiling <chizhiling@kylinos.cn>

This patch introduces exfat_count_contig_clusters to obtain batch entries,
which is an infrastructure used to support iomap.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/exfat_fs.h |  2 ++
 fs/exfat/fatent.c   | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index d52893276e9a..421dd7c61cca 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -449,6 +449,8 @@ int exfat_find_last_cluster(struct super_block *sb, struct exfat_chain *p_chain,
 		unsigned int *ret_clu);
 int exfat_count_num_clusters(struct super_block *sb,
 		struct exfat_chain *p_chain, unsigned int *ret_count);
+int exfat_count_contig_clusters(struct super_block *sb,
+		struct exfat_chain *p_chain, unsigned int *ret_count);
 
 /* balloc.c */
 int exfat_load_bitmap(struct super_block *sb);
diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index d980d17176c2..9dcee9524155 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -524,3 +524,36 @@ int exfat_count_num_clusters(struct super_block *sb,
 
 	return 0;
 }
+
+int exfat_count_contig_clusters(struct super_block *sb,
+		struct exfat_chain *p_chain, unsigned int *ret_count)
+{
+	struct buffer_head *bh = NULL;
+	unsigned int clu, next_clu;
+	unsigned int count;
+
+	if (!p_chain->dir || p_chain->dir == EXFAT_EOF_CLUSTER) {
+		*ret_count = 0;
+		return 0;
+	}
+
+	if (p_chain->flags == ALLOC_NO_FAT_CHAIN) {
+		*ret_count = p_chain->size;
+		return 0;
+	}
+
+	clu = p_chain->dir;
+	for (count = 1; count < p_chain->size; count++) {
+		if (exfat_ent_get(sb, clu, &next_clu, &bh))
+			return -EIO;
+		if (++clu != next_clu)
+			break;
+	}
+
+	/* TODO: Update p_claim to help caller read ahead the next block */
+
+	brelse(bh);
+	*ret_count = count;
+
+	return 0;
+}
-- 
2.43.0


