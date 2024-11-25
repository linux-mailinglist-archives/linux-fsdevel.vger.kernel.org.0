Return-Path: <linux-fsdevel+bounces-35848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC00C9D8E42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 23:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695AC16A70F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 22:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979B01C3F1B;
	Mon, 25 Nov 2024 22:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyD9ik+z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F6C188724
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 22:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732572356; cv=none; b=p9Igaha2NysyMtyA5gSSyOkE8Us1QMwMNrtiLTHJkQEn7i+7mzljTHW82XER5O01Q1StYO+1JOpQcuG42ly573CBf0n2aiKZzVxAUe2Zg6xV5qURVtXAn+h7HjDMHrOlcMnW5r2sGT05pF1DmKIQBa0lcS87Dx2VFET9QrN36FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732572356; c=relaxed/simple;
	bh=V81XEOKsgntTC5oWT2DysQ3LXbryClkEbFa2ucXUg+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CIqvGicmScw6Cs9jaqsEk7wTjeYNTrfcFFqi+2FxJX5PP7W4Rmg32U7/zmkK5VXHcJPaDveLx+UqeKopCF9Ei+Knwp/561+nUsnmG6D1dQ4tGrt4jd4SOUWpeKLoMxd5HxEOyyvJSwOBiKqSJ3inMyPkgM9EwZkBOQTUBIxnBKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyD9ik+z; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ef15421050so14128727b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 14:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732572353; x=1733177153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nMBvbjxTX18bInMRKVl+thXrUjVBlRpJFHhF8z2v2pA=;
        b=gyD9ik+zz0nrLFf7V3Yli7cXUu2+QD4KpBNsvOXIU6chUW4UkE2AsJpnR6oZzevvNV
         FTWaPDshpvdmrEKMQk9RffJM3rjK54Eco1vMD+h69JiHLoDL9/Ir+ntFZmJFDBj9y/KO
         205M+GSljilClCJ39NEGVoGvYkV+llNJGFufzTr2lU8t2rzQ97Ae0ezy+cMmOd4LVTaF
         boRMlSJi2a5OcB7Ly/Wi93qejx6BNMOcuyP0a0O4iSgbuf23FOwSGhjivdEdN3KqFNCA
         7ZDhVIy18zY97CwWbkTrNJtFapYXl6rA2kFTqZUyVgiwCkF+lgt97wmVay8yLyoCzuds
         nimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732572353; x=1733177153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nMBvbjxTX18bInMRKVl+thXrUjVBlRpJFHhF8z2v2pA=;
        b=XGftqQn5M9Zy2cG2FspWYV591gbJfMSHwsuf4ThWQWviy0bljIAmFKSTDJOjX6v//e
         HCMQ5erp0fnOrCu4RYgYxY+4M4jZSYN6uv5c0bg7U/mKTpYUeX5WEr2sgToBAOUNPPXg
         4rDHBmguMuSycRH1YaOe/5KpN0jkWudml0+9dwRsFsciiIzZjZqgJH9JYNSSrkoEivdC
         7AJPdt9XAz3FqZPQf3cuYT1jrM1PjATXvYZhbq+rh6D/fo3a/cq41C8iWUcoly0LJZGS
         MA/LczxojMsGl9xvzqs7Va6HJeAdInAXyTIeqOclW1k3fAIMx0tb5jZmHzLyaZEwycYt
         O9Kw==
X-Forwarded-Encrypted: i=1; AJvYcCV3rmUizY/o+ZWl3Qh1pnDB9cqdthmIQ06nJ7x3Ibkxu3fLy4Nu1lDw+nfV23chTCNH7yoGQeKBmtBhRNfH@vger.kernel.org
X-Gm-Message-State: AOJu0YxkFcUAAxseDc/ozOlVbXQGbibghuWnccxOrc9xdjpYtXMtH8WS
	vE5DQob91sfilS7yW4REMZr1GsTgeX8ODe2euaSZtXy2D8qEuhzg
X-Gm-Gg: ASbGncsqIInvvFIAVOJJTf/nHB2eKzRMA7QU4P6netju7FxZb6kE55dJ933UmfPNxo8
	Lyo8XZqNADfX6o9IcVYkpHMIFGUuBDCfwimH9LluQ2AmPVkVWtVZ8fieD3ZLWaTmWhmQF4J8IEt
	xeLpYlXDK9L+p6mUuu834FXBz8xRopg8PX3IZEjoOqTXQekwdbGnUWOmm9/xByE9F8cxbqEHS7O
	EmaRc8lcz+fvB9X5+85XV4x3lDSsC3KiKAC1u/WPJ1cootB5texBTmWoMA4mn9xwLp6nyzWXLnh
	e/YHQsxN
X-Google-Smtp-Source: AGHT+IGhA76rv1rilr6XYuIqstcKnvWMFX1CVTcFr0rr/ZojcvYqD7lp83YcHKChSoqopPhOrBTRWA==
X-Received: by 2002:a05:690c:67c4:b0:6d3:be51:6d03 with SMTP id 00721157ae682-6eee08e8c33mr149474157b3.23.1732572353345;
        Mon, 25 Nov 2024 14:05:53 -0800 (PST)
Received: from localhost (fwdproxy-nha-010.fbsv.net. [2a03:2880:25ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eee0081c3esm19926837b3.90.2024.11.25.14.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 14:05:53 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: [PATCH v2 00/12] fuse: support large folios
Date: Mon, 25 Nov 2024 14:05:25 -0800
Message-ID: <20241125220537.3663725-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds support for folios larger than one page size in FUSE.

This patchset is rebased on top of the (unmerged) patchset that removes temp
folios in writeback [1]. (There is also a version of this patchset that is
independent from that change, but that version has two additional patches
needed to account for temp folios and temp folio copying, which may require
some debate to get the API right for as these two patches add generic
(non-FUSE) helpers. For simplicity's sake for now, I sent out this patchset
version rebased on top of the patchset that removes temp pages)

This patchset was tested by running it through fstests on passthrough_hp.

Benchmarks show roughly a ~45% improvement in read throughput.

Benchmark setup:

-- Set up server --
 ./libfuse/build/example/passthrough_hp --bypass-rw=1 ~/libfuse
~/mounts/fuse/ --nopassthrough
(using libfuse patched with https://github.com/libfuse/libfuse/pull/807)

-- Run fio --
 fio --name=read --ioengine=sync --rw=read --bs=1M --size=1G
--numjobs=2 --ramp_time=30 --group_reporting=1
--directory=mounts/fuse/

Machine 1:
    No large folios:     ~4400 MiB/s
    Large folios:        ~7100 MiB/s

Machine 2:
    No large folios:     ~3700 MiB/s
    Large folios:        ~6400 MiB/s

Writes are still effectively one page size. Benchmarks showed that trying to get
the largest folios possible from __filemap_get_folio() is an over-optimization
and ends up being significantly more expensive. Fine-tuning for the optimal
order size for the __filemap_get_folio() calls can be done in a future patchset.

[1] https://lore.kernel.org/linux-fsdevel/20241107235614.3637221-1-joannelkoong@gmail.com/

Changelog:
v1: https://lore.kernel.org/linux-fsdevel/20241109001258.2216604-1-joannelkoong@gmail.com/
v1 -> v2:
* Change naming from "non-writeback write" to "writethrough write"
* Fix deadlock for writethrough writes by calling fault_in_iov_iter_readable() first
  before __filemap_get_folio() (Josef)
* For readahead, retain original folio_size() for descs.length (Josef)
* Use folio_zero_range() api in fuse_copy_folio() (Josef)
* Add Josef's reviewed-bys

Joanne Koong (12):
  fuse: support copying large folios
  fuse: support large folios for retrieves
  fuse: refactor fuse_fill_write_pages()
  fuse: support large folios for writethrough writes
  fuse: support large folios for folio reads
  fuse: support large folios for symlinks
  fuse: support large folios for stores
  fuse: support large folios for queued writes
  fuse: support large folios for readahead
  fuse: support large folios for direct io
  fuse: support large folios for writeback
  fuse: enable large folios

 fs/fuse/dev.c  | 128 ++++++++++++++++++++++++-------------------------
 fs/fuse/dir.c  |   8 ++--
 fs/fuse/file.c | 126 +++++++++++++++++++++++++++++++-----------------
 3 files changed, 149 insertions(+), 113 deletions(-)

-- 
2.43.5


