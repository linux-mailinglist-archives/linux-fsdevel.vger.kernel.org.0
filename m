Return-Path: <linux-fsdevel+bounces-56165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63110B14312
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 22:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C81F18C2C4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 20:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267EF27C152;
	Mon, 28 Jul 2025 20:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UFon0cRU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD8C2798F8
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 20:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734693; cv=none; b=kTWwtylR+qqEfLbXB4jZac/YxUqO4o0W0dedj/LE9gQApuvQ24mg4cqXdhIhmZdLEWicxfGNis1hJAp9PRHAAla5Hkr0hCOmXZNI8e/NKimMHt1AMy3ENWG+hYKpqXhjUHmSrAXcDx+kzwLmmxiGAypcqkzzRpEMucf7yCxdORE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734693; c=relaxed/simple;
	bh=1ZgkoljoMyvDKh0qVDwiY2DqikCPW5z+QRth2A0bo3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=lzP2Ff5WJeJZtMgH4laoyHCtHpP26yAZCFandHbQY3+NWZ+W2728QZ7DywB34cbMjRdwVsaHNKHFK2hlbZ1odcA8BGLjMuKKvRcm+ebkgnpUNUBj8swwjQS6I8lB0rf9rli1J1jE7MgVcDIwonrxa1z7VJUNKSReVRYgPaz4D5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UFon0cRU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753734690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ys5kqXzqz0yqP1LE9hKjn2TJIEFefSHs4ERdcC7rvZk=;
	b=UFon0cRUleoFZja8oEqyRnZFGn8GSl7Nm3z7f0Zxf7WuHzeDJh4N4pKoRmRX9D+H6gUvZs
	jDSCq5yR8B7LHYZhyiCjijyXCz0bUGs7UcviHydTLOA4BicQGzgfh+OmhLGVG8IT+GKeos
	jBTMTPX0lO2CkDEFPDzjnq4PksEQvro=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-XhXx2r44MV-Y2PJCCAkMxw-1; Mon, 28 Jul 2025 16:31:29 -0400
X-MC-Unique: XhXx2r44MV-Y2PJCCAkMxw-1
X-Mimecast-MFC-AGG-ID: XhXx2r44MV-Y2PJCCAkMxw_1753734688
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-613559d197dso4142735a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 13:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734688; x=1754339488;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ys5kqXzqz0yqP1LE9hKjn2TJIEFefSHs4ERdcC7rvZk=;
        b=XSL01kgftqxO9JT+7+aq854HtWXrGMi4+2ciEDp93993B1LKhw7S/PS9zIdSTAnraD
         2iCx5a+yy50z4kTDDnEtYZS5j1OIqu6OWT4V0lt5tOOD4MV22F8eGZiGIN1Qy6p8aAiZ
         LV/Q7NxAqIPrSaAO+TtpLhgjUdzSPCmAwAZMd7a3HFkqSt55ngkleDjNKmAyZgp1XR/0
         iObaDo3N+O0Z4+wqPdy2c8TIXBDlyGC2fUG/iZuOwa+5T+Tn+pmBtwwW+QHkvGi0Vs7w
         WJI2CqOcxwpTdNXwbWH7LBkXK4AUI2yicIcmVfAvpFs0tcahP0cDdfnHB3946d/1mejJ
         KOqA==
X-Forwarded-Encrypted: i=1; AJvYcCXwWWjoVh7oeOoCFr7t6YsmcVftJl9uPtiBFWlvmxsnC8OzATOUWE2S1XfWa+J4pi/Tk4VL2JIzqbIuoUxM@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx9xW0HIf5NPq+rQGW6+/zH5+Ibkxas9r+o6RzBGRxdQPU3LU9
	AfFU44zBdGgH+avgogPMN0+FVdF8C6pydhJQjY7LmSUG9z+T+Xpk+4oMt6onzZ1nH6Tf5A5j/Br
	GM53dHVQYjBZ92W2w4sR1DzvDqe+u3F6VHUPTBSA8KLjAkKA4J3xheXn2tKs5kldASfhpvlWQ2n
	Ze/wC6BIVrUz1Fa73WxFCzOZG18UDuHHpHP2j0YILZxtA0qVoZVQ==
X-Gm-Gg: ASbGnct2y2kRsn4qzAk1dcceFdyaKfaWCy2+4/fGQMXalHmHo5bbLzsXEuQWiTKJgaw
	AvU8AWcK+dfRjPBcSbye86SSuzPqNUSjAxTIh6AA3JFlt3g7xB+lhzyrhZy+qZNfIxlJKecX7BU
	Z5rSjmkfaLObwGcgNI3qHpYfeqIlgnH0uDfQ5Z5UL6jpXHkOK1nbon6Uqm98XV7VdAf3Jsu83nO
	6XovxX13E4Yh3fBXj9vAIfBAJEi65qJ2mzxl+DudoE6xhVIAMbgKawA40mdTQVxx7ueMyjO7Kea
	aNbRscC4lb6/vlkupIeeQG4LlR4mYcPugAYr/aO+QpNhkg==
X-Received: by 2002:a05:6402:27c9:b0:615:6917:872 with SMTP id 4fb4d7f45d1cf-615691715bcmr197223a12.31.1753734687750;
        Mon, 28 Jul 2025 13:31:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQv0t2GbQI8mCqWdvIBvXSTnn+jBYTuYa2WcL8ZqxxCZ10dzVrwYpHqc75lDBA2dEYhF/pMw==
X-Received: by 2002:a05:6402:27c9:b0:615:6917:872 with SMTP id 4fb4d7f45d1cf-615691715bcmr197185a12.31.1753734687248;
        Mon, 28 Jul 2025 13:31:27 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615226558d3sm2730656a12.45.2025.07.28.13.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:31:26 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 28 Jul 2025 22:30:10 +0200
Subject: [PATCH RFC 06/29] fsverity: report validation errors back to the
 filesystem
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-fsverity-v1-6-9e5443af0e34@kernel.org>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
In-Reply-To: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
To: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org, 
 ebiggers@kernel.org, hch@lst.de
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2734; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=xBUnAzy4V8YhALXwKbVZJNAFAkEy33DdXbkTKrTjLws=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtrviW99ZCN1NC3KQOKoqrfy8xoXZYvbHRsNTe6on
 FrC+IDT2LWjlIVBjItBVkyRZZ201tSkIqn8IwY18jBzWJlAhjBwcQrARGbaMfwPj1pyeO/7qG6r
 Q56G9yL/irZkrfuyY/XOfxr2H9WVFn82Yvjv3h17jNPbRe3pYraLS48s+3TF7vIW3STD4qd3rpT
 xe9znAACe9Uju
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: "Darrick J. Wong" <djwong@kernel.org>

Provide a new function call so that validation errors can be reported
back to the filesystem.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/verity/verify.c              |  4 ++++
 include/linux/fsverity.h        | 14 ++++++++++++++
 include/trace/events/fsverity.h | 19 +++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 580486168467..917a5fb5388f 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -243,6 +243,10 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		     data_pos, level - 1,
 		     params->hash_alg->name, hsize, want_hash,
 		     params->hash_alg->name, hsize, real_hash);
+	trace_fsverity_file_corrupt(inode, data_pos, params->block_size);
+	if (inode->i_sb->s_vop->file_corrupt)
+		inode->i_sb->s_vop->file_corrupt(inode, data_pos,
+						 params->block_size);
 error:
 	for (; level > 0; level--) {
 		kunmap_local(hblocks[level - 1].addr);
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 9b91bd54fb75..d263e988bec2 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -120,6 +120,20 @@ struct fsverity_operations {
 	 */
 	int (*write_merkle_tree_block)(struct inode *inode, const void *buf,
 				       u64 pos, unsigned int size);
+
+	/**
+	 * Notify the filesystem that file data is corrupt.
+	 *
+	 * @inode: the inode being validated
+	 * @pos: the file position of the invalid data
+	 * @len: the length of the invalid data
+	 *
+	 * This function is called when fs-verity detects that a portion of a
+	 * file's data is inconsistent with the Merkle tree, or a Merkle tree
+	 * block needed to validate the data is inconsistent with the level
+	 * above it.
+	 */
+	void (*file_corrupt)(struct inode *inode, loff_t pos, size_t len);
 };
 
 #ifdef CONFIG_FS_VERITY
diff --git a/include/trace/events/fsverity.h b/include/trace/events/fsverity.h
index dab220884b89..375fdddac6a9 100644
--- a/include/trace/events/fsverity.h
+++ b/include/trace/events/fsverity.h
@@ -137,6 +137,25 @@ TRACE_EVENT(fsverity_verify_merkle_block,
 		__entry->hidx)
 );
 
+TRACE_EVENT(fsverity_file_corrupt,
+	TP_PROTO(const struct inode *inode, loff_t pos, size_t len),
+	TP_ARGS(inode, pos, len),
+	TP_STRUCT__entry(
+		__field(ino_t, ino)
+		__field(loff_t, pos)
+		__field(size_t, len)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->pos = pos;
+		__entry->len = len;
+	),
+	TP_printk("ino %lu pos %llu len %zu",
+		(unsigned long) __entry->ino,
+		__entry->pos,
+		__entry->len)
+);
+
 #endif /* _TRACE_FSVERITY_H */
 
 /* This part must be outside protection */

-- 
2.50.0


