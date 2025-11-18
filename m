Return-Path: <linux-fsdevel+bounces-68915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DF16DC6831B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 09:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id D0E4D2A401
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 08:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB3D3115AE;
	Tue, 18 Nov 2025 08:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="n7rbOXK/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B0430FC38;
	Tue, 18 Nov 2025 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763454413; cv=none; b=d/R8doOEpTxpnNe+ntos2LdVSD13OomYSqnQ+MAz65RCMUcsZ7Iz180nUtImCgp/1vGaWJ81tXpD9KBhs5kfaK1JuOn/xD3LNBPPEvHuQW6ASabtPpfv084CzpuAh0TUimTCXn0pSaOsERkLUyS7xOTVXltg6pq+QXZpB5fczyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763454413; c=relaxed/simple;
	bh=JtSKIjYRxkLxPt3bVyhZJhjENtR+ZEMLTrPiwr//Mn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MQ9oSBj3IZjSBwTwo7fPhpvq0TYY+/KNpizuYbsgsKStaDsdHtDUlYnKLTzDSRovmlR7MRM/8LeHAAGfCx6tnZIPB24jsnICOegVajILxyxqpnifDThkchbvauZmCbGmJHxwgAH57Cok6DXlY6DdTNOQXHnBN4GWTL7LRyddePE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=n7rbOXK/; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=hR
	6TGosybEGoZQNcg26Ap3acM698JDSFAMMSDG6kBw0=; b=n7rbOXK/UpjSGd+xuN
	GE9G90dhFd8j9XTYjGh7/cnUGMk67MkLr/Sg6YYSb7PhyxN2mVik0WTSt3fnmtbF
	AlAV5Z51kSMVD3kyHBwXM0M7HrRS6hDm2EFlEZhvxIHdIG+samjnMFhnNHtSByHc
	s7pHRrPqR4mIQRGK6FoE+vMx0=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAnu_KILRxpyC6zEQ--.29019S2;
	Tue, 18 Nov 2025 16:25:44 +0800 (CST)
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
Subject: [RFC PATCH 0/7] Enable exfat_get_block to support obtaining multiple clusters
Date: Tue, 18 Nov 2025 16:22:01 +0800
Message-ID: <20251118082208.1034186-1-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAnu_KILRxpyC6zEQ--.29019S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF15ur1rWw1fJF4rury3urg_yoW8Xr1rpr
	ZxKw4rtrWkJa43Gr13uw4kZryrur1rJFyUX3W7Jr18Crn0yF1Ivr4rtas8A3WDG3s7ZFs0
	qr18Kw18uasrCwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUTmhUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/1tbiFAMKnWkcJbehNgADsz

From: Chi Zhiling <chizhiling@kylinos.cn>

The purpose of this patchset is to prepare for adapting exfat to iomap
in the future. Currently, the main issue preventing exfat from supporting
iomap is its inability to fetch multiple contiguous clusters.

However, this patchset does not directly modify exfat_map_cluster and
exfat_get_cluster to support multi-clusters. Instead, after obtaining
the first cluster, it uses exfat_count_contig_clusters to retrieve the
subsequent contiguous clusters.

This approach is the one with the fewest changes among all the solutions
I have attempted, making the modifications easier to review.

This patchset includes two main changes: one reduces the number of sb_bread
calls when accessing adjacent clusters to save time, and the other enables
fetching multiple contiguous entries in exfat_get_blocks.

Chi Zhiling (7):
  exfat: add cache option for __exfat_ent_get
  exfat: support reuse buffer head for exfat_ent_get
  exfat: reuse cache to improve exfat_get_cluster
  exfat: improve exfat_count_num_clusters
  exfat: improve exfat_find_last_cluster
  exfat: introduce exfat_count_contig_clusters
  exfat: get mutil-clusters in exfat_get_block

 fs/exfat/cache.c    | 11 ++++--
 fs/exfat/exfat_fs.h |  6 ++-
 fs/exfat/fatent.c   | 90 ++++++++++++++++++++++++++++++++++++---------
 fs/exfat/inode.c    | 14 ++++++-
 4 files changed, 97 insertions(+), 24 deletions(-)

-- 
2.43.0


