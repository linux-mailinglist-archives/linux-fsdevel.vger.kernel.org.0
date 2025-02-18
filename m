Return-Path: <linux-fsdevel+bounces-41988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDE3A39BB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 13:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3399217675E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 12:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B802417FA;
	Tue, 18 Feb 2025 12:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OM7ZIjXs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC032417D0;
	Tue, 18 Feb 2025 12:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880141; cv=none; b=WwgsqtlVjdCgltdldWt7wrrc8M2K/I9qzq2PwZD5DdMCsxzUXtkHn9K7BRx65qTHmetPLLxrEPLKE5vkk/+SKhInSA5CiEcddh36uDJv4D1yYOGYFjqfLssXQEfK547/uAm2ZJJGyOqNxmu2AFQb1KMgbopJshOpa6F7iLT0QU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880141; c=relaxed/simple;
	bh=fLenMmdULILtge4BQOFeuVpQMX8KYl0ISZjjASCYR1A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pfrl0gpXxotX7WQh63aN3qNaZx2vF/k8v3SWQJrSSVVRTb+SCGUciyCVXB9vTz/ASDEVcKd8LHsFLR2Hq2xE7uAipKEJehKpGATYyfjTVUh1l85q3yIrDD8MIj1GmCAY2U/eQEaAHFCF3XBRoaeRcP+jWTEnq4uBYXoWnj8Xr0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OM7ZIjXs; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739880130; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=M6y3zGkESqoUJF5CDeLNQCaTMRRV4huoMUwe0DAHtgc=;
	b=OM7ZIjXsOjDKEVJQOwi8bc8saLjyCUQA6A0rBDqI68RKyURKnzC4Vb1tCBrvQ4HSnv6mYPnz/qhtxjHIdUBdmhLe1ImxLYK8VgC6xp30cjhDYWzwaWWVCUjjSszYtBu8d8KE806hL1ELz6uT+pIEi5Ea6zYLXP87MgY0tt0rGu0=
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WPlpQxF_1739880129 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 18 Feb 2025 20:02:10 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Cc: brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH 0/2] fixes for uncached IO
Date: Tue, 18 Feb 2025 20:02:07 +0800
Message-Id: <20250218120209.88093-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jingbo Xu (2):
  mm/filemap: fix miscalculated file range for
    filemap_fdatawrite_range_kick()
  mm/truncate: don't skip dirty page in folio_unmap_invalidate()

 include/linux/fs.h | 4 ++--
 mm/filemap.c       | 2 +-
 mm/truncate.c      | 2 --
 3 files changed, 3 insertions(+), 5 deletions(-)

-- 
2.19.1.6.gb485710b


