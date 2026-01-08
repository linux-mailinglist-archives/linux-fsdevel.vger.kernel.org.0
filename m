Return-Path: <linux-fsdevel+bounces-72787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D0CD01F9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 10:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F63E34533EC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 08:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A3937F116;
	Thu,  8 Jan 2026 07:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="R4OzD8sv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DCF37C0EA;
	Thu,  8 Jan 2026 07:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767858647; cv=none; b=MjMId6LX6znr80TdYRYAzNQyYD9mQjaIKf0XGrGxcz1vQ6vXE8h/eXtbGO1Vg5Z8ldtwsV18xRVhqVqToQ2XjbTKtO230WWWKFxdaUkDxOfJikLounFaDgnOXDVzfiFA/2P5NN/9hVz76J1CYmO7bpGT/cDkMKkSaXSSGzZTLdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767858647; c=relaxed/simple;
	bh=rfHZT9404eaU8nG9PXA0f9ytaTjUnDYBY8SrxdySRpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aR3pw4IXyrfZlWlXb+Es21bspwplFIrE+ShhznCS5/03eCcXXyRHmSegZjc+8Jc2mc8+NTyb1lMxusIGegoC8/1CNYortvPPAh/rIf/+B8PiJKC/VAcYysakVNLhOSe5Gbiimxt+045p0G5RhDauYaH0KIeO1c23EfrKaHrSamQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=R4OzD8sv; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=wd6pUirE51Jyz5Ivjwx97OdORTMjX3uKUwgkcmX3iBM=;
	b=R4OzD8sv1BPLSjU3Go6lNFBmQ7o5iAsvoJs0nZrBtKVylOSv2QL210ztY68MET
	JsieTaMNbPRXQseVbf6cPjzJjBdsvQjtLGNwoUoiMu5DcDhtum10SK9OBg0/yrVz
	ndsTxrA+SbbL+lPeJbG8M7pA42ROnbcP4EJ5xn169xJMY=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBH6+WpYV9pdSx_Eg--.889S2;
	Thu, 08 Jan 2026 15:50:04 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v2 00/13] Enable multi-cluster fetching for exfat_get_block.
Date: Thu,  8 Jan 2026 15:49:16 +0800
Message-ID: <20260108074929.356683-1-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBH6+WpYV9pdSx_Eg--.889S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw15ZFWktFyUuw17tr48Crg_yoW8ur4fpr
	W3KwsxJrn5Xwn3JrsxAw1ktr4furn3JF17X347Gw17Cr1DZF4I9rZrtFn5CFyDG3yIqFs0
	qr15Gw1j9r9xCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnzVbUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC2w21U2lfYa0AdgAA38

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


Changes:
- Cache the last dis-continuous cluster
- Continue collect clusters after cache hit
- Some cleanup.

V1:
https://lore.kernel.org/linux-fsdevel/20251226094440.455563-1-chizhiling@163.com/T/#u
rfc:
https://lore.kernel.org/linux-fsdevel/20251118082208.1034186-1-chizhiling@163.com/T/#u


Chi Zhiling (13):
  exfat: add cache option for __exfat_ent_get
  exfat: support reuse buffer head for exfat_ent_get
  exfat: improve exfat_count_num_clusters
  exfat: improve exfat_find_last_cluster
  exfat: remove the check for infinite cluster chain loop
  exfat: remove the unreachable warning for cache miss cases
  exfat: reduce the number of parameters for exfat_get_cluster()
  exfat: reuse cache to improve exfat_get_cluster
  exfat: remove handling of non-file types in exfat_map_cluster
  exfat: support multi-cluster for exfat_map_cluster
  exfat: tweak cluster cache to support zero offset
  exfat: return the start of next cache in exfat_cache_lookup
  exfat: support multi-cluster for exfat_get_cluster

 fs/exfat/cache.c    | 149 ++++++++++++++++++++++++++++----------------
 fs/exfat/exfat_fs.h |   7 +--
 fs/exfat/fatent.c   |  61 +++++++++++-------
 fs/exfat/inode.c    |  52 ++++++----------
 4 files changed, 157 insertions(+), 112 deletions(-)


base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
prerequisite-patch-id: e5f54b5b252924be0d139310a81d57eda55bead3
-- 
2.43.0


