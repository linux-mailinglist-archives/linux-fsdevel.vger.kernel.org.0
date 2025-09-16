Return-Path: <linux-fsdevel+bounces-61501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DB1B5893E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764D8189D716
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4318B1E832E;
	Tue, 16 Sep 2025 00:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdwfRVsz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF931A5B8F;
	Tue, 16 Sep 2025 00:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982385; cv=none; b=KLC3fGARNJ3YivkV1O1MgdpLTGH6HwI13CoWC4CM5sJ9+0GqMgqI2lzHLO1bX/SeB8H/iGRiBBoafZNcd+NGdh4nGzzzlMgzy9bW/HUnpd7zXgS0V2W4gmmMCxnvQ9jFXo+9Rkxc5r3iPpz/lwB22vr0y5PeRac+owziC5pBY64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982385; c=relaxed/simple;
	bh=RLzedDQ5IK8mLU4WXaO6D3vKVUlc3JP2v1ef3Y1aT04=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SEKNaUBlcJYsYHUSB4G8rbk/+T9PEV9WiPhRPWkqqxpjklM1uVOcj3Xdxon0a/98pksMAnleIQ9GN8qYlfRfDzutifTRJm51jXPmX/9wCR3o3z+ASMJIQDwdrqnTDumJG8pR7zNhCyiYRVjsR3tjnYBgyDoCnPlglg/PYvbLfQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdwfRVsz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C97C4CEF1;
	Tue, 16 Sep 2025 00:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982385;
	bh=RLzedDQ5IK8mLU4WXaO6D3vKVUlc3JP2v1ef3Y1aT04=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=bdwfRVszu4C3130Yr1tA3/TdQ/DBVdIeLTQthTXi9SZR94lpB6AM0mtQZlvq4I4+B
	 TpTJxZNm40uu0NJcDgIl1GiGz5/obgEJt6SGAUzS4qnqumLOLm3upHKNgHyE7L1Nu8
	 4vbwHKrsWdaAVAnJDi3G60jl3jt5OYlcv4A+zCe5xhFVICnj1IAd2VNXVOaf0QNb/r
	 Pwkh8vUpEpoZhnXoJHj1T4ITuKBGowClGJzZ8+b5uhGhJndAHS3Q2slvTsoPIC1nHp
	 fu0rfO7yKCoLX9Z7Ef6mZOU9RK28TP4zkZfUK45Wo2v2xwlUCM+SJ3tMVDalBs7W64
	 rvfJ+WVnTWh+g==
Date: Mon, 15 Sep 2025 17:26:24 -0700
Subject: [PATCH 1/2] iomap: trace iomap_zero_iter zeroing activities
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798150439.382342.16301331727277357575.stgit@frogsfrogsfrogs>
In-Reply-To: <175798150409.382342.12419127054800541532.stgit@frogsfrogsfrogs>
References: <175798150409.382342.12419127054800541532.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Trace which bytes actually get zeroed.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/trace.h       |    1 +
 fs/iomap/buffered-io.c |    3 +++
 2 files changed, 4 insertions(+)


diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 6ad66e6ba653e8..a61c1dae474270 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -84,6 +84,7 @@ DEFINE_RANGE_EVENT(iomap_release_folio);
 DEFINE_RANGE_EVENT(iomap_invalidate_folio);
 DEFINE_RANGE_EVENT(iomap_dio_invalidate_fail);
 DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
+DEFINE_RANGE_EVENT(iomap_zero_iter);
 
 #define IOMAP_TYPE_STRINGS \
 	{ IOMAP_HOLE,		"HOLE" }, \
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 1e95a331a682e2..741f1f6001e1ff 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1415,6 +1415,9 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
 		/* warn about zeroing folios beyond eof that won't write back */
 		WARN_ON_ONCE(folio_pos(folio) > iter->inode->i_size);
 
+		trace_iomap_zero_iter(iter->inode, folio_pos(folio) + offset,
+				bytes);
+
 		folio_zero_range(folio, offset, bytes);
 		folio_mark_accessed(folio);
 


