Return-Path: <linux-fsdevel+bounces-63648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D791EBC8350
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 11:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 972564F72D0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 09:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CB22D7D2F;
	Thu,  9 Oct 2025 09:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQaa6tDj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7FB2D7DDF
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760000938; cv=none; b=KRD+v5bo4GR6VG1b3PxNPBuCy8JTW8WMxT91E0BewzYiZMdUWMHR9YLi0NqPHOJz04rPCVy840X1jTG+qHfADGnm5WiIrKxJaeKb0QmYb/zgEGU1V9RmOVKaRqaSdIP6wRU/FIcNSEWIepUK+NxQ/4gRcpewWoaacb5QjcbanuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760000938; c=relaxed/simple;
	bh=KcXa7KpDaur+uFmqn054xcHb7hsTcb+0GQs4M5FBSr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YWL8AzHftZcUVY8s9wAeIMcNWHgElvjEkJunW4/9czY+1+RIXeVqZalY6wM6NJVnvBwP/I5HMp37/lmKaus9+ejqm+8RJKY4PfS+8Gjx27bRF8TKsHpWbGv0Q9hOdj+clY5rZesjtQIX3mp47TndNj2mDt9t5feHo4Rfsj/Jujw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQaa6tDj; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-78f3bfe3f69so677087b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 02:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760000935; x=1760605735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C+uXX49aJSWydq7w+IBivpuqIIen5cjqVetpqZ6Ubl0=;
        b=UQaa6tDjDv/PU9cLO2WgehElAHghQMqjZ9PeqA+Hwq1E9B9mnvws8epQsJD0ivaohQ
         oWmEvqphVshRl2TYU7vAgn+sfF5L59OKGV3uD3w4STeBzccoWu5TjTogQOhy9WPuVimN
         vjnVU88DnP5OBBZc2GC7vbcDKZITHmhUnwBtoEs8tdOGjnTqG/Q/3DOUi9sxaGb1F91l
         emeZl/skxe0ZZMGeM9j0sLvHmxo4hJmsUCEnRCxLiuhqkz5Y9Q9mjSQdvDk4qD0/uN72
         DDu+VmWk/JWia2mrp/VOrnNBt0SmR1bV7mQ71c9gv8iwpIiYKgaVVnBF19Yqi9DcijPD
         6xQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760000935; x=1760605735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+uXX49aJSWydq7w+IBivpuqIIen5cjqVetpqZ6Ubl0=;
        b=CIfITkjrCxjX0TY6rE+8I+aJ96OJcffjvdIk7tt2j4MHsgdGMHk/hccgrzYRvOOY+a
         vc8veQ7gQT2h/MTje10NUufHj5dAvqX1ZSQg0N7P2e0FqaG9sbSzhhhhRHbQnqnvmSei
         mDhxoNtyuUroRhDwu4bRVq9rdiZgZbOsqfRzlHBFIywWoe/rvfhuSEdrjv3jTL7/EAoc
         YUJVKQIiOVU6JMdWak7YccD4Lb0jrsObu4E4fn52s/BS5BeidKqyaYJvryCDn8lvyPm5
         SCq/VtGqn0XRyniCxwthHEgIk/ilgDTMeqGusLgUbDCw/sjBKm1OuAt9/rovleY7ufhg
         QC0A==
X-Forwarded-Encrypted: i=1; AJvYcCX1Owka1Mf16jviGKEqsUFS8qgH02spLKi2ycUW1WsWNZD9fMisckQK+0j+qiXfVi0kCoNBPyRaV8skwbV7@vger.kernel.org
X-Gm-Message-State: AOJu0YzqXWJWtY61SVx2gG1MRTwS7U9A6QRFzlXOp2kQ77e3SVKBefrq
	T4H2UyP2MgfXD+nNKUTufEtXKhK7a0DHErZ2z87DD3Kz63FRCwzhHvGE
X-Gm-Gg: ASbGnctUMaNsHw6bncXq+FsBEjXR9bqMKNXFS8zLP8L/oPwQylOkXqO/zW544ROhrNr
	ti88lEKmsagnKK0UiYdGLAR+OF1dqz01cEUqslHepNrIU/4vaEofMjZpaYmVhz7OCEMsPWu1koe
	SY+kcqY5QjGDq5s76fRZi75VwrLZdAjDgCW+oifac8OQ0sGpAyT+gLPFZWFIXbbM1I889/uWa7i
	VX/eoAEfLqvs+9uSofWg0zMtGxPRpBl+GexzID4kB4kFXonL0rvGUsWFFgN3CD2t1u1H/POC3UU
	WJI3K1hr9NDDBrfrzS5Q4qUH+r/kn1AneqWv3gRLHZK9ZmX5pgLT+5v02BRNP2eHoHo4Swx1TLC
	aaEeMDIa3hZYIzWWTEpaQ7F52TOQfvPaLsam7z5SvtFZNR3L40TiuhKeogwbkBOM96bF1
X-Google-Smtp-Source: AGHT+IFGt4O/r0xFNJrXeC/igV78+a3q45ov1VJNkdOtbNUnCJ+CIdkFX31aFA1MGzKQAcgaH9fqOA==
X-Received: by 2002:a05:6a21:3285:b0:2b9:b64:5aae with SMTP id adf61e73a8af0-32da8462febmr8919546637.29.1760000935143;
        Thu, 09 Oct 2025 02:08:55 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f58ac2sm20209182a12.35.2025.10.09.02.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 02:08:54 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: djwong@kernel.org,
	brauner@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH] iomap: move prefaulting out of hot write path
Date: Thu,  9 Oct 2025 17:08:51 +0800
Message-ID: <20251009090851.2811395-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

Prefaulting the write source buffer incurs an extra userspace access
in the common fast path. Make iomap_write_iter() consistent with
generic_perform_write(): only touch userspace an extra time when
copy_folio_from_iter_atomic() has failed to make progress.

This patch is inspired by commit 665575cff098 ("filemap: move
prefaulting out of hot write path").

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/iomap/buffered-io.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8b847a1e27f1..6e6573fce78a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -972,21 +972,6 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 		if (bytes > iomap_length(iter))
 			bytes = iomap_length(iter);
 
-		/*
-		 * Bring in the user page that we'll copy from _first_.
-		 * Otherwise there's a nasty deadlock on copying from the
-		 * same page as we're writing to, without it being marked
-		 * up-to-date.
-		 *
-		 * For async buffered writes the assumption is that the user
-		 * page has already been faulted in. This can be optimized by
-		 * faulting the user page.
-		 */
-		if (unlikely(fault_in_iov_iter_readable(i, bytes) == bytes)) {
-			status = -EFAULT;
-			break;
-		}
-
 		status = iomap_write_begin(iter, write_ops, &folio, &offset,
 				&bytes);
 		if (unlikely(status)) {
@@ -1001,6 +986,12 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 		if (mapping_writably_mapped(mapping))
 			flush_dcache_folio(folio);
 
+		/*
+		 * Faults here on mmap()s can recurse into arbitrary
+		 * filesystem code. Lots of locks are held that can
+		 * deadlock. Use an atomic copy to avoid deadlocking
+		 * in page fault handling.
+		 */
 		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
 		written = iomap_write_end(iter, bytes, copied, folio) ?
 			  copied : 0;
@@ -1039,6 +1030,16 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 				bytes = copied;
 				goto retry;
 			}
+
+			/*
+			 * 'folio' is now unlocked and faults on it can be
+			 * handled. Ensure forward progress by trying to
+			 * fault it in now.
+			 */
+			if (fault_in_iov_iter_readable(i, bytes) == bytes) {
+				status = -EFAULT;
+				break;
+			}
 		} else {
 			total_written += written;
 			iomap_iter_advance(iter, &written);
-- 
2.49.0


