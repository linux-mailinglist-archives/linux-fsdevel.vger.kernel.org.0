Return-Path: <linux-fsdevel+bounces-73688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2A0D1EABE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 13:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24D1E3014D7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 12:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066A2396D2B;
	Wed, 14 Jan 2026 12:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EoDHbyRT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA01C396B99;
	Wed, 14 Jan 2026 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768392837; cv=none; b=cUoDraBLUUX56y0VCQLE4DnZQtEerwH91IeMgMvJzyxBqd6zf8AkNiOOAKuiYXSJhneeQ7RSZQoQH+Aj4SxEOAQDuY9W5c6/g5ybclWngrFGTqllzD+9cnl9UB83lJGXQxMLx9clVkfScGUXMz1tLKXOHglYBTNHsy/A1R0mSLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768392837; c=relaxed/simple;
	bh=EFat5YKo0k3lYnWx1urjD2xJuJ6Ty40i98etoO8gKds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U25zsXpzRSucFxBlTI0dFg6ZPqV/0a5HsSoNO8ORqnkAABMw94qFDTaWgML4CwLIWykWrVFVbQmv+0TN0i6z4a2cAy0jhSxvpeGs2SFeSACL8S6hDW9FSqlaQVZYS9N6hJyLZXdy/LYgUQ0miLlyzZ6+0zJGK7pgPVSR0iyEO9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EoDHbyRT; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=Pb5Bt0KqNWoZvB4eYrZGjIFw3mGjN11gmVr7FeUwabI=;
	b=EoDHbyRTC96cAIszHLAyiPR1/j3WUSTDXWEzCdQ6ppoyBmGBXxsom6eocAcgh0
	9Mp1XgofNk6g5e5mbI0xGRiCn1WzN0cDX4nl4/yBbre5SkXZpioVndQjmc/orF8Y
	q8ivap2doKa+MhG190pWmoaqBdUpuJUNrxT6STVN8jFMs=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAXybtbiGdpFdouGQ--.5056S2;
	Wed, 14 Jan 2026 20:13:17 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v3 00/13] Enable multi-cluster fetching for exfat_get_block.
Date: Wed, 14 Jan 2026 20:12:36 +0800
Message-ID: <20260114121250.615064-1-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXybtbiGdpFdouGQ--.5056S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw15ZFWktFyUuw17tr48Crg_yoW8tr17pr
	W3KwsxJr18Xw13JFsxAw1ktw4rurn3JF1UXw17Gw17Crn0vF4I9rZrtFn5Ca4UW34IqF4q
	qr1UGw1j9r9xC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnF4iUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3B1tC2lniF23zQAA3G

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


Changes in v3:
- fix overflow in exfat_get_block, only patch 10 and 13 changed
- add review tag for all patches except patch 10 and 13

Changes in v2:
- Cache the last dis-continuous cluster
- Continue collect clusters after cache hit
- Some cleanup.

V2:
https://lore.kernel.org/linux-fsdevel/20260108074929.356683-1-chizhiling@163.com/T/#u
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

-- 
2.43.0


