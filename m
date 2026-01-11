Return-Path: <linux-fsdevel+bounces-73150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3862BD0E8C5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 11:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D443D300C6C7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 10:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9650330655;
	Sun, 11 Jan 2026 10:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Zq9crD9Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7583C29A2
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jan 2026 10:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768126374; cv=none; b=H4W/uel82DP9cIqPm5RbKVr7xh3d9d8MbhtM1j3mUJ5t0eKvaiP8k8uboJdw4E7sGzzKAhe+uBD+/CEaJ/IyXgKoX7pOoWtKEDLoBxFmAM7Mqe0AdYn85JC3O7N68Dcy5U4m/XpL3sUV4OekIxiYyWRcaYtqs+bY/WsO9vYH5/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768126374; c=relaxed/simple;
	bh=1Rx1bX5WlinanoQL+ISjTcqPAikznNx3Hqs+dxcnUNU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rw8wiLw8LufWh8kP80QgPkIPrnl3Fv6k0xstXFQefqvx/bIu1M0rz1kbgNDbs9E940KBz/TIjKAAyixdE3v7DYBKWv+/8AJ5b99syr9GEnP7jnyOuAY17D8d/VjaF4TeZuxvZ4swgeKrOPzAsPXaNAsfA4Ngg5gIGdLPa5kQn9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Zq9crD9Z; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=h3
	n8BopGg8GfN20IiZxGhwRxejoB1r3r9Qimx4vkLDU=; b=Zq9crD9ZS+yECE8TuK
	A6JCsIHHMyIGqVCoMpdA/wzY1qFnEQ2S4ZS4pybO9ulByKRqsMB6tmnIF4Ms214y
	x0QyBtvP4dMWx7MJFjYRWcVrNHZurMLuQDxJWkvHZVBSPZtmYGPpj9Hu2vN4Ie5N
	+1d0a6LCHd+oP8wsD8f7hu3ks=
Received: from YLLaptop.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3lx+Ad2Np0FddBg--.65279S2;
	Sun, 11 Jan 2026 18:12:17 +0800 (CST)
From: Nanzhe Zhao <nzzhao@126.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Nanzhe Zhao <nzzhao@126.com>
Subject: [f2fs-dev] [PATCH v2 0/2] f2fs: fix large folio read corner cases for immutable files
Date: Sun, 11 Jan 2026 18:09:39 +0800
Message-Id: <20260111100941.119765-1-nzzhao@126.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3lx+Ad2Np0FddBg--.65279S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrWF1kAw1DAw45Zr1UJF4ruFg_yoWxXFX_u3
	48ZrykA3yj9FZIkF429rW5XFWvgrW8Zr429F18JFs8C345trZ7Wws0qFy0kF17uF48Gr43
	A3y3Z3s3AryxujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRNTmh7UUUUU==
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBowExAWljd4G8bQAA3-

This is v2 of the bug fixes for corner cases in immutable file
large folio read. The first two fixes from v1 have already been
picked up, so this reroll only carries the remaining two fixes
from v1 (fixing the case where a folio had no BIO submission and
could be left locked, and advance the index and offset after zeroing).

Nanzhe Zhao (2):
  f2fs: add 'folio_in_bio' to handle readahead folios with no BIO
    submission
  f2fs: advance index and offset after zeroing in large folio read

 fs/f2fs/data.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)


base-commit: 2ff2a9420a8221dd4fb45d7e5f60e33f17914a30
--
2.34.1


