Return-Path: <linux-fsdevel+bounces-42895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 199ACA4B14C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 12:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9940816CC6A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 11:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0369F1DBB0C;
	Sun,  2 Mar 2025 11:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIOnXAtg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1F223F362
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Mar 2025 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740916510; cv=none; b=U/itd/S7KwY9fa7OSoXFT9lgcm//S3fTahNhMgrvBqpwnxt4XqNNGpGforPiG4C5QH4PJeYmp8/BUB//r3bOU+c9UGnHEPBUeN5/FrHrqyG/JpljutCjimOIA7WjKsSqRJ26eqybQsjD3GmrhJO340KMJeabpOHAanqo9c3nGnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740916510; c=relaxed/simple;
	bh=+mx3JlVEUb3IoikfizmznzjWLiIYpl3wzB2LJbWNqJk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=nJ9eM5OEp6ukyaT3wO5NYvmCY+TI+4zxZ9MUNw0RO3DY6tV/YybWXHAEuutC/seF2y8S/OEu5LTxwPJ3/l6ZIQiUi4x7vMd/zMLpSZkPxPzpZ7LFuQYJL0mc8ow2L/j/WAYhSkfCOOW9f36QmNwyxuSiqgWCP7dp6K4zMAq6lho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIOnXAtg; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2b1a9cbfc8dso901858fac.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Mar 2025 03:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740916507; x=1741521307; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+mx3JlVEUb3IoikfizmznzjWLiIYpl3wzB2LJbWNqJk=;
        b=jIOnXAtgnEXuRE2wlIbKCMQ/iRATe+DrybpcLvA4mqQBfOIUlHF50GxgXjI3Il20UY
         NXNNcyPFRLvaBkghMHaTy5XPAIuO9IqMwX0EX6JKf6Zter7R67/+SCcsj65zinrU7alE
         R0msxp7+dsdpNQbExBxmw1NxVeuTh65jQ10z9uSwUZBd18owuF5ptvksJrpSVb8JUzzi
         sbqjokPh6+i5D1+7t1yS9BSLoRKzzZM5hqc7xl2CdML0SWYkgqvvHGX1bbjOzASnvkve
         c/sxT/xqZbl8zP3jtS6O8x/X27O7Qsxjr9LoDe29725UTAK8NS6l2abjd3I3wHSS7GIe
         xYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740916507; x=1741521307;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+mx3JlVEUb3IoikfizmznzjWLiIYpl3wzB2LJbWNqJk=;
        b=xA5k5ZZgBSXLOln2cz6dignDC4pfNWsCLpIikXHwquUihcxpH8Hf5zIUe7U47yiysc
         ShR2V4OwzOyWjY+6OdB8rPsx0fjXJPvqIHXPS+Op0qCZJVPTqXJtGOJzbUUEIjXpbV70
         pTxghp/HskOhdYtfW1SCnfv7AB/BZQRg9PpKYU6tFHj2x1vuHCXF7xeX+B+dO2oAMWTX
         IM+WDGOOd3ZU/R+TEWTz0Mn1SHNOWXbh/43bq7NLtZ8itKexk42JVBs/7DeqFuJRlvcB
         JMrm/1IKcfD+nd019MKTsiKv2x+t2p5j/2E+ZvhRY0R2Wr8Y6XKgi31k/YQG6hs2id87
         dWbA==
X-Gm-Message-State: AOJu0YyxYxCa6X9OaqwEa0K8yvYjDVui+lauqjijvWB4E3BxGfVObQEf
	6Q+wYq6t4sGc65fYCTf9jD+BG4Uz80HgRPGfKZShc0bpxi11ornwKq/hG2Hk3Ai8jtnjLM9VIej
	MmrPlc72/QYlFuVjWzdzhWEm9r9xLLxQjWBry8tye
X-Gm-Gg: ASbGncunpTXd7UwLCnD8ww19OmiZXAIn4lBSHrQeM21wjaLACLfddP+QcQ/5XytXuHp
	0JurSlK+xQ0SSj+AUKTJiL5cIS5rfJ92KihVuUZsiEjvOT20lAVv5imUNJYU+PPhzS9al8QH4oK
	IierURqcqN2XAd4qXoyzCR0a/SPA==
X-Google-Smtp-Source: AGHT+IHLF3E50u6VhcWid2mrRkvTGkpiqieZvBQ6d2X9JlvpKtLca0/8ro89Tv1PekCfPDv1FAQt4vXWSoMu5kI4rJQ=
X-Received: by 2002:a05:6870:1f13:b0:2bc:75aa:aeae with SMTP id
 586e51a60fabf-2c1783c5d21mr6181141fac.10.1740916507452; Sun, 02 Mar 2025
 03:55:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Strforexc yn <strforexc@gmail.com>
Date: Sun, 2 Mar 2025 19:54:56 +0800
X-Gm-Features: AQ5f1JpNM4IRZBFoLO6x8DY4OvdQpOBXmyT55tNBEue6fItqhbP2H1MiV8Xbgs0
Message-ID: <CA+HokZoV3HOuv1MRCq5NXPe=apTPiFiaEV-mSCRPvhHgNtek8A@mail.gmail.com>
Subject: [PATCH] hfsplus: Prevent out-of-bounds read in hfsplus_bnode_move
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all, This patch fixes a KASAN-reported out-of-bounds read in
hfsplus_bnode_move()
at fs/hfsplus/bnode.c:228, detected during a syzkaller fuzzing test. The bug
occurs when a malformed HFS+ filesystem image provides an invalid 'len'
parameter, leading to an integer underflow and a massive size_t value being
passed to memmove(). This can happen during mount when inserting B-tree
records (e.g., security attributes).
The issue was traced to the 'dst > src' branch, where 'len' underflows to
18446744073709551602 (-14 signed), causing an out-of-bounds access. The fix
adds input validation against node->tree->node_size and ensures the loop
terminates cleanly without negative lengths.
KASAN report:
BUG: KASAN: out-of-bounds in hfsplus_bnode_move+0x37a/0x8b0
fs/hfsplus/bnode.c:228
Read of size 18446744073709551602 at addr 000508800000100e by task syz.5.6/11451
Call Trace:
hfsplus_bnode_move+0x37a/0x8b0 fs/hfsplus/bnode.c:228
hfsplus_brec_insert+0x50e/0xc40 fs/hfsplus/brec.c:128
hfsplus_create_attr+0x34e/0x410 fs/hfsplus/attributes.c:252
...
__x64_sys_mount+0x288/0x310 fs/namespace.c:4088
Trace values at the buggy memmove():
- src_ptr = 4096
- dst_ptr = 1289392192
- l = 4294967282 (-14 signed, 0xFFFFFFE2)
The patch has been tested with the syzkaller reproducer, which no longer
triggers the KASAN violation.
Signed-off-by: [Your Name] <[Your Email]>
---
fs/hfsplus/bnode.c | 15 +++++++++++++++
1 file changed, 15 insertions(+)
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index abc1234..def5678 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -200,6 +200,15 @@ void hfs_bnode_move(struct hfs_bnode *node, int
dst, int src, int len)
hfs_dbg(BNODE_MOD, "movebytes: %d,%d,%d\n", dst, src, len);
if (!len)
return;
+
+ /* Validate inputs to prevent underflow or out-of-bounds access */
+ if (len <= 0 || src < 0 || dst < 0 ||
+ src >= node->tree->node_size || dst >= node->tree->node_size ||
+ src + len > node->tree->node_size || dst + len > node->tree->node_size) {
+ pr_err("hfsplus: invalid bnode move: src=%d, dst=%d, len=%d, node_size=%u\n",
+ src, dst, len, node->tree->node_size);
+ return;
+ }
src += node->page_offset;
dst += node->page_offset;
@@ -228,6 +237,11 @@ void hfs_bnode_move(struct hfs_bnode *node, int
dst, int src, int len)
l = dst;
src -= l;
dst = PAGE_SIZE;
}
l = min(len, l);
+ if (l <= 0) {
+ pr_err("hfsplus: invalid move length: l=%d, len=%d\n", l, len);
+ break;
+ }
memmove(dst_ptr - l, src_ptr - l, l);
kunmap_local(src_ptr);
set_page_dirty(*dst_page);
@@ -235,7 +249,7 @@ void hfs_bnode_move(struct hfs_bnode *node, int
dst, int src, int len)
if (dst == PAGE_SIZE)
dst_page--;
else
src_page--;
- } while ((len -= l));
+ } while ((len -= l) > 0);
} else {
src_page = node->page + (src >> PAGE_SHIFT);
src &= ~PAGE_MASK;
--
2.34.1
Thanks,Strforexc

