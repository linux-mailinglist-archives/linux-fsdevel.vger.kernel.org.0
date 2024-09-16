Return-Path: <linux-fsdevel+bounces-29502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293A897A39B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 16:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CD611C26788
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 14:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9631925A1;
	Mon, 16 Sep 2024 13:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="X4baUaJu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA7E1917EB;
	Mon, 16 Sep 2024 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495043; cv=none; b=O+bgP8dIjVlQbc0teHHtsZ+J+wq9UQwqlMk7HG5zfYcbY45jsKkjfkPZLtmU7W6awW6S1IEDD0KeYKP6/mVxHX0JJZEAlQ+C9pRDf7N71v6BmZD1kJNZlczhe44J+zY1tQStFIPCaw4x4iT7mnSTJvYyTdPIBqbiouzFG190W6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495043; c=relaxed/simple;
	bh=rNUlETDV+01prA4JBPSRw8P+VTclzz+be5rG2+iUEmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czlPTiBF0v8/WAe0VuCi531uPPbMlAF/p2aS8/qe5KnTQmxEap4QMLyfDxt06qbBvKUiI2LFzqO2qIrsPP8P0C95rVwaRy24ZsGqB5WwiLgXKrPK7xEKJpDReWhzSecCfQVQhGbywMD8YvhnASvy956ttssuvXo9/TJ7q72f5k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=X4baUaJu; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5407B69846;
	Mon, 16 Sep 2024 09:57:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495041; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=iVEpuQCRq5HfW1zEs0Xldj9thdzekA2PSp+UaBg4euk=;
	b=X4baUaJuu1m/SZcizjCUwjQXlm2cqf/Wsik3+r0ZAj0Dsx1wUrzzvdWixSm+HzNQVhpbBH
	7pEknBiEY52wUf/Ntn1D1CENrM44nH9qkHp//5Ehmwavc2rz41hCKJmzvvJu/EaCatnECd
	JLUHPJsylOQ+KaMJoiFUzPEuG0L7FP2pJpr7jWA3K5p+MXgtQZdtZSUPqswck7TEIiUNbw
	nkvJzl55CjR5pTO0hjZcoNxb5/ZWgGvAKIUvXmXdvkN5EmtaGUvIbS6FYAFK4fwgVTJDnA
	Vlr6mklfEGHUgfNmXRNtMVyexGCFFXHp20eM31T/GXzyy3MIxL/N+cG21fb/YA==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: linux-erofs@lists.ozlabs.org
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 22/24] erofs: add skippable iters in Rust
Date: Mon, 16 Sep 2024 21:56:32 +0800
Message-ID: <20240916135634.98554-23-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916135634.98554-1-toolmanp@tlmp.cc>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This patch introduce self-owned skippable data iterators in Rust.
This iterators will be used to access extended attributes later.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/rust/erofs_sys/data/raw_iters.rs | 121 ++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/fs/erofs/rust/erofs_sys/data/raw_iters.rs b/fs/erofs/rust/erofs_sys/data/raw_iters.rs
index 8f3bd250d252..f1ff0a251596 100644
--- a/fs/erofs/rust/erofs_sys/data/raw_iters.rs
+++ b/fs/erofs/rust/erofs_sys/data/raw_iters.rs
@@ -4,3 +4,124 @@
 pub(crate) mod ref_iter;
 mod traits;
 pub(crate) use traits::*;
+
+use super::*;
+use alloc::boxed::Box;
+
+/// Represents a skippable continuous buffer iterator. This is used primarily for reading the
+/// extended attributes. Since the key-value is flattened out in its original format.
+pub(crate) struct SkippableContinuousIter<'a> {
+    iter: Box<dyn ContinuousBufferIter<'a> + 'a>,
+    data: RefBuffer<'a>,
+    cur: usize,
+}
+
+fn cmp_with_cursor_move(
+    lhs: &[u8],
+    rhs: &[u8],
+    lhs_cur: &mut usize,
+    rhs_cur: &mut usize,
+    len: usize,
+) -> bool {
+    let result = lhs[*lhs_cur..(*lhs_cur + len)] == rhs[*rhs_cur..(*rhs_cur + len)];
+    *lhs_cur += len;
+    *rhs_cur += len;
+    result
+}
+
+#[derive(Debug, Clone, Copy, PartialEq)]
+pub(crate) enum SkipCmpError {
+    PosixError(Errno),
+    NotEqual(Off),
+}
+
+impl From<Errno> for SkipCmpError {
+    fn from(e: Errno) -> Self {
+        SkipCmpError::PosixError(e)
+    }
+}
+
+impl<'a> SkippableContinuousIter<'a> {
+    pub(crate) fn try_new(
+        mut iter: Box<dyn ContinuousBufferIter<'a> + 'a>,
+    ) -> PosixResult<Option<Self>> {
+        if iter.eof() {
+            return Ok(None);
+        }
+        let data = iter.next().unwrap()?;
+        Ok(Some(Self { iter, data, cur: 0 }))
+    }
+    pub(crate) fn skip(&mut self, offset: Off) -> PosixResult<()> {
+        let dlen = self.data.content().len() - self.cur;
+        if offset as usize <= dlen {
+            self.cur += offset as usize;
+        } else {
+            self.cur = 0;
+            self.iter.advance_off(dlen as Off);
+            self.data = self.iter.next().unwrap()?;
+        }
+        Ok(())
+    }
+
+    pub(crate) fn read(&mut self, buf: &mut [u8]) -> PosixResult<()> {
+        let mut dlen = self.data.content().len() - self.cur;
+        let mut bcur = 0_usize;
+        let blen = buf.len();
+        if dlen != 0 && dlen >= blen {
+            buf.clone_from_slice(&self.data.content()[self.cur..(self.cur + blen)]);
+            self.cur += blen;
+        } else {
+            buf[bcur..(bcur + dlen)].copy_from_slice(&self.data.content()[self.cur..]);
+            bcur += dlen;
+            while bcur < blen {
+                self.cur = 0;
+                self.data = self.iter.next().unwrap()?;
+                dlen = self.data.content().len();
+                if dlen >= blen - bcur {
+                    buf[bcur..].copy_from_slice(&self.data.content()[..(blen - bcur)]);
+                    self.cur = blen - bcur;
+                    return Ok(());
+                } else {
+                    buf[bcur..(bcur + dlen)].copy_from_slice(self.data.content());
+                    bcur += dlen;
+                }
+            }
+        }
+        Ok(())
+    }
+
+    pub(crate) fn try_cmp(&mut self, buf: &[u8]) -> Result<(), SkipCmpError> {
+        let dlen = self.data.content().len() - self.cur;
+        let blen = buf.len();
+        let mut bcur = 0_usize;
+
+        if dlen != 0 && dlen >= blen {
+            if cmp_with_cursor_move(self.data.content(), buf, &mut self.cur, &mut bcur, blen) {
+                Ok(())
+            } else {
+                Err(SkipCmpError::NotEqual(bcur as Off))
+            }
+        } else {
+            if dlen != 0 {
+                let clen = dlen.min(blen);
+                if !cmp_with_cursor_move(self.data.content(), buf, &mut self.cur, &mut bcur, clen) {
+                    return Err(SkipCmpError::NotEqual(bcur as Off));
+                }
+            }
+            while bcur < blen {
+                self.cur = 0;
+                self.data = self.iter.next().unwrap()?;
+                let dlen = self.data.content().len();
+                let clen = dlen.min(blen - bcur);
+                if !cmp_with_cursor_move(self.data.content(), buf, &mut self.cur, &mut bcur, clen) {
+                    return Err(SkipCmpError::NotEqual(bcur as Off));
+                }
+            }
+
+            Ok(())
+        }
+    }
+    pub(crate) fn eof(&self) -> bool {
+        self.data.content().len() - self.cur == 0 && self.iter.eof()
+    }
+}
-- 
2.46.0


