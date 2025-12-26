Return-Path: <linux-fsdevel+bounces-72099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA513CDE8D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 10:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2354A3007FE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 09:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71C52877F7;
	Fri, 26 Dec 2025 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QoIKdPrS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F59800;
	Fri, 26 Dec 2025 09:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766742332; cv=none; b=G/DCukyWA0aancbsSo5yIbCHNapWqJT1xUtlR/05x788uRp6ZNZi/IN/ggpQUbCHeLBX2QIKiGzVcaDDNYIcZWdqrF/CrPPkkbamMVWJySTMw0BQuEq6X5/rQVJLvbkRxKD0phQRATous3HF5g3NznjPvwCOLU8GtbC4hhoyGR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766742332; c=relaxed/simple;
	bh=QqZ0kbBxgfSJID8H3zOV+/wE7nsdMuRSIrOgdDCu4hU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lXSMUL8ZEsRUrwW69dxV5TGgPzxlaldM4Wv49EEbKjAUXJOMt+FBB5jC8VmXygVgsyiBoVsa4eb75AUeXSbwUb+GUTYFm6/SwZjvXkpFH6226FbcmGquMOYZFtyjX8IdnkjKH1KGVcUIlLfxA431mb+5bhYupGyXY/q8VuTYnrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QoIKdPrS; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=mX
	ap7fTl+OZyDxL5yoap/6iAe3Yyacl+PzXdpdoE5vA=; b=QoIKdPrS/QGV9St+EU
	XcSpV2m1TYT/Ftwy+f1pn78de3vVRovmxaD7BvplKOawCPKhHT452gL2s4UbwC6q
	Mq4jJdHuTg03tJSswQLP0VBiUxHstG4JcbWNbisqB0qaJCenp6/E9FOI/buuHPWQ
	75Lyb5W6i2ZLwInhv4NmbPOb0=
Received: from chi-Redmi-Book.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCnlXIPWU5p9JFCJA--.53S2;
	Fri, 26 Dec 2025 17:44:50 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v1 0/9] Enable exfat_get_block to support obtaining multiple clusters
Date: Fri, 26 Dec 2025 17:44:31 +0800
Message-ID: <20251226094440.455563-1-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCnlXIPWU5p9JFCJA--.53S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw15ZFWktFyUuw17tr48Crg_yoW8GF13pr
	W3KwnxJryfJ343Wr43Aw1ktr4rurn5JF13Xa47Gr47Crn0yF1S9rsrtFn5Ca4DW34IqFs0
	gr15Gw1j9r9xCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUqXdUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9xJI5WlOWRKHBQAA3m

From: Chi Zhiling <chizhiling@kylinos.cn>

This patch series significantly improves exFAT read performance
by adding multi-cluster mapping support.
The changes reduce get_block calls during sequential reads,
particularly benefiting small cluster sizes.

- Extends exfat_get_cluster() and exfat_map_cluster() to handle multiple contiguous clusters
- Adds buffer head caching for FAT table reads

Performance results show ~10% improvement for 512-byte clusters (454->511 MB/s)
and reduced get_block overhead from 10.8% to 0.02% for NO_FAT_CHAIN files.

All criticism and suggestions are welcome :)

Chi Zhiling (9):
  exfat: add cache option for __exfat_ent_get
  exfat: support reuse buffer head for exfat_ent_get
  exfat: reuse cache to improve exfat_get_cluster
  exfat: improve exfat_count_num_clusters
  exfat: improve exfat_find_last_cluster
  exfat: remove unused parameters from exfat_get_cluster
  exfat: tweak exfat_cache_lookup to support zero offset cluster
  exfat: support multi-cluster for exfat_map_cluster
  exfat: support multi-cluster for exfat_get_cluster

 fs/exfat/cache.c    | 108 ++++++++++++++++++++++++++++----------------
 fs/exfat/exfat_fs.h |   7 ++-
 fs/exfat/fatent.c   |  61 ++++++++++++++++---------
 fs/exfat/inode.c    |  46 +++++++++++--------
 4 files changed, 137 insertions(+), 85 deletions(-)

-- 
2.43.0


