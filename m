Return-Path: <linux-fsdevel+bounces-18296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1978B6925
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7F2281490
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEBA11187;
	Tue, 30 Apr 2024 03:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUQnIYLw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ED110799;
	Tue, 30 Apr 2024 03:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448480; cv=none; b=odBtZDndFOO0oy67yDedEr0+yLKHVss8QFo/SSFIht6b3683mdAHdQKQHL0g9LJy6Lj+oR7pvgzxzczL7KKfot5Gb3SER5r7qOEZ9Qd7sFeh+u9MGPXYGHsTRsqgt1g50ykbDX3gzYBnq+ea6Z6U6z7b/FssbudYBU0qOOpHMwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448480; c=relaxed/simple;
	bh=BNuhBfz8p90b3tugGpJQ21bYXxQIzLmERz5lJk6RXJg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jMqQSdG8kFjZyqP69Se1LnPUrMvGtjCIc6pZ5Q9WLEo9sRXmKzb2NiaFqesXyDwNc0gaNEHIqlAHuA8w3Ib1hxXaImjewzTqvCfivXa1f8wuloQiT5eGUmcOi+ZiMnj0FI6s58ZqnUKKhsloP1BELUVniMvTI3ewm5c1mW7Rb9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUQnIYLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8637BC116B1;
	Tue, 30 Apr 2024 03:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448479;
	bh=BNuhBfz8p90b3tugGpJQ21bYXxQIzLmERz5lJk6RXJg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=rUQnIYLwKct0DckLry7PuJAIYDpyBlLa1e+AjfgI/yGVH+B+7rUoxDsHcRt+iQ+ZH
	 JQQKpvI4kqDXkgWoTtJBPQ25sIsw/sztpG826CEwvqsHSj+W/JI2L1/IZOTzc1iNG1
	 eLg6yT9XqSo+Ep66L/IwEraaWUTjscxZ6oS9LiaEM1f7dL9NAieZWbAKhh7B6Mg3bA
	 y05jzxzAt/YDwzXoKcuFaTi6kipbMELHU9giksmqREmNIQLfg4zt3aBHdEPDDyD8CM
	 8T5rlE5ICVI+WuQFLG2iItGIwdpu6blqhUb4kAyfoV3F8QnbwtsG/+t4Q9qCUxcja3
	 lxRiMHGxU0Vlg==
Date: Mon, 29 Apr 2024 20:41:19 -0700
Subject: [PATCH 2/6] xfs/{021,122}: adapt to fsverity xattrs
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, zlang@redhat.com, ebiggers@kernel.org,
 djwong@kernel.org
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, guan@eryu.me,
 linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Message-ID: <171444688009.962488.1019465154475766682.stgit@frogsfrogsfrogs>
In-Reply-To: <171444687971.962488.18035230926224414854.stgit@frogsfrogsfrogs>
References: <171444687971.962488.18035230926224414854.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Adjust these tests to accomdate the use of xattrs to store fsverity
metadata.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 tests/xfs/021     |    3 +++
 tests/xfs/122.out |    1 +
 2 files changed, 4 insertions(+)


diff --git a/tests/xfs/021 b/tests/xfs/021
index ef307fc064..dcecf41958 100755
--- a/tests/xfs/021
+++ b/tests/xfs/021
@@ -118,6 +118,7 @@ _scratch_xfs_db -r -c "inode $inum_1" -c "print a.sfattr"  | \
 	perl -ne '
 /\.secure/ && next;
 /\.parent/ && next;
+/\.verity/ && next;
 	print unless /^\d+:\[.*/;'
 
 echo "*** dump attributes (2)"
@@ -128,6 +129,7 @@ _scratch_xfs_db -r -c "inode $inum_2" -c "a a.bmx[0].startblock" -c print  \
 	| perl -ne '
 s/,secure//;
 s/,parent//;
+s/,verity//;
 s/info.hdr/info/;
 /hdr.info.crc/ && next;
 /hdr.info.bno/ && next;
@@ -135,6 +137,7 @@ s/info.hdr/info/;
 /hdr.info.lsn/ && next;
 /hdr.info.owner/ && next;
 /\.parent/ && next;
+/\.verity/ && next;
 s/^(hdr.info.magic =) 0x3bee/\1 0xfbee/;
 s/^(hdr.firstused =) (\d+)/\1 FIRSTUSED/;
 s/^(hdr.freemap\[0-2] = \[base,size]).*/\1 [FREEMAP..]/;
diff --git a/tests/xfs/122.out b/tests/xfs/122.out
index abd82e7142..019fe7545f 100644
--- a/tests/xfs/122.out
+++ b/tests/xfs/122.out
@@ -142,6 +142,7 @@ sizeof(struct xfs_scrub_vec) = 16
 sizeof(struct xfs_scrub_vec_head) = 40
 sizeof(struct xfs_swap_extent) = 64
 sizeof(struct xfs_unmount_log_format) = 8
+sizeof(struct xfs_verity_merkle_key) = 8
 sizeof(struct xfs_xmd_log_format) = 16
 sizeof(struct xfs_xmi_log_format) = 88
 sizeof(union xfs_rtword_raw) = 4


