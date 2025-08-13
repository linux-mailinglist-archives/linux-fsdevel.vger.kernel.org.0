Return-Path: <linux-fsdevel+bounces-57733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32642B24D42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 17:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4CE7188CCD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB730220698;
	Wed, 13 Aug 2025 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQnUyM7/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B111F8BD6
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098426; cv=none; b=YsCC/fwP/Nf+UOBKuSbmQFMkwOm/FVIypLbIdwNUhWIR3QuMfRbkKmXl4VwzM5lCW7t/Q85bA8Wo3ElYRQQPrzMCUKzG4HxmHWHOuV7vULlhsrnaG9LAqvVeqiKycvinz3nO161foxQltcsB6SvZAyuqukgI813u35ydyhXip5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098426; c=relaxed/simple;
	bh=vKLf2q6s/s67F3VebGryQ81d68O5b5fXKLO7fOZNq6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEJyzKlOH9hfBBBTKddkF21d59o9baQL8ifBx2CVXvFqRKecXA7a5mZJHoxibd4R6FktSHfN2BZTbbetHAGsOM8px2L9qgXLLsv0sd1f6LPc8dVwbtFikSEos/a7FsVsADUuXcKIlPHBbL7/COXGR/la8fn2YGGI+dH0GI1zk/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZQnUyM7/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755098423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I7L10NW+pVVDVJZX0HIXypwG2qX9Nu46MpobfMhJU4g=;
	b=ZQnUyM7/DVw19SaWukErQtXEaWIbmNsDINKVgi3H4mSNgYySK9HEWO6UQwWjBE7unfvYt7
	veB6hrGN6YM0Hmi+zaYsebJM7g+tEhG/qw0w878ZMhvdKelGyFAPd8YFqhCzSPQC3aTrff
	0+LS0+7vXryl8/sqJZtMU1nGcJ+K+jU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-HRcrfQPnPD6aRmPL0ze-ig-1; Wed, 13 Aug 2025 11:20:22 -0400
X-MC-Unique: HRcrfQPnPD6aRmPL0ze-ig-1
X-Mimecast-MFC-AGG-ID: HRcrfQPnPD6aRmPL0ze-ig_1755098421
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-458f710f364so44293875e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 08:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755098421; x=1755703221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7L10NW+pVVDVJZX0HIXypwG2qX9Nu46MpobfMhJU4g=;
        b=Rw7oUMUcSh2MMrMk53wsclQPCC6mIol0dA/mcbvFWeDT42qEDnHfv064UQcXeNPdAp
         FjCwOy5fe1adZw34UxcsvWlfb0vEZz3u1SWagR3Jig/vB4nZ1LSoGmG3Dl//VrUNYYbX
         9SPig5WHCG6PVil9bNDTNWDT4i+jEVFHgN6/t8pwOSD8iV/GuPHWXoqlGY4cJSFJpCsP
         DgzhvaWsIlVqmw+xD/Qn9TtJm55iWtcOZ5A9mKj2r1A3KYc1fE0qCqaTMZTtH8CBPU+K
         gBQb1PqsJ6KtDAJ8jlPCu7oJaRL8xkcYecpOh/mszAhLP8jqqQYFe6XQlfM0xMd+ZFia
         ZRlA==
X-Gm-Message-State: AOJu0YwKsuc6UEPv5swiHqTI+ULyqYVxfHHpZ+ZXB4hx8lpr8rg7T/nI
	Z4Z5ZiutFy34tztGu8zlO9r0IxIvBLyEw5F47ona01d9045eFCoyXh3HinoLUfgRTtgIOM5UU9t
	S4SxTEx9GvvtIm5nguqCjxmF1Mt+gUb28XqjxAruLgHrEKZkQZIl1SQ2coBGujc5Z4N/FdUcHlC
	eeGwMzm2nRj40ySW14d1lAert7lPLmCUnC6VJBMRIPuoZGnWxIvoMWJw==
X-Gm-Gg: ASbGncvcA87FeJ1PLjHlLLiymPoYAZT0F0hjuprk+OQye1QCXqjI66cFjJrPCl7rZbM
	tuxEuvufZcNe8fq3KXBKXjPTJw6rjscxp3HgvXkm34BCbY0HPEMSyglvLnwU32jEhokZqwgDbtP
	KHES1Kmz1vw59R24rlzQS4FkIQpb0FS//outCJ9H2K9Ot+roveJb6GKSUW5vZaKmfExft1hGkQJ
	A2LdRYAcfCmo3Vql82KSW1Arv9G75AH1dqPNXWicJFAOnyqdPkrxHerGRc8pTU9aqzpCQDAUUq9
	ldEBvh1KnIzkq0ac1/8svp5cPWQLubgCLRsaOW8Vw1bIab+7jWrwv9dpnRehfP6J+k7Q/OxCOw3
	klvlSmJ0KVfvv
X-Received: by 2002:a05:600c:4f87:b0:458:a992:6f1e with SMTP id 5b1f17b1804b1-45a17258916mr25443475e9.5.1755098420689;
        Wed, 13 Aug 2025 08:20:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxV00m9K7KDhcyDU44xupLdJtFx8xZdPGFXKYD330/+jjuj2eefMzc60Rp5ZBk1tvuZzcV4A==
X-Received: by 2002:a05:600c:4f87:b0:458:a992:6f1e with SMTP id 5b1f17b1804b1-45a17258916mr25443085e9.5.1755098420152;
        Wed, 13 Aug 2025 08:20:20 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (94-21-53-46.pool.digikabel.hu. [94.21.53.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c489e81sm48584381f8f.68.2025.08.13.08.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:20:19 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Bernd Schubert <bschubert@ddn.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Chunsheng Luo <luochunsheng@ustc.edu>,
	Florian Weimer <fweimer@redhat.com>
Subject: [PATCH v2 3/3] fuse: add COPY_FILE_RANGE_64 that allows large copies
Date: Wed, 13 Aug 2025 17:20:13 +0200
Message-ID: <20250813152014.100048-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250813152014.100048-1-mszeredi@redhat.com>
References: <20250813152014.100048-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FUSE protocol uses struct fuse_write_out to convey the return value of
copy_file_range, which is restricted to uint32_t.  But the COPY_FILE_RANGE
interface supports a 64-bit size copies and there's no reason why copies
should be limited to 32-bit.

Introduce a new op COPY_FILE_RANGE_64, which is identical, except the
number of bytes copied is returned in a 64-bit value.

If the fuse server does not support COPY_FILE_RANGE_64, fall back to
COPY_FILE_RANGE.

Reported-by: Florian Weimer <fweimer@redhat.com>
Closes: https://lore.kernel.org/all/lhuh5ynl8z5.fsf@oldenburg.str.redhat.com/
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/file.c            | 44 ++++++++++++++++++++++++++++-----------
 fs/fuse/fuse_i.h          |  3 +++
 include/uapi/linux/fuse.h | 12 ++++++++++-
 3 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 4adcf09d4b01..867b5fde1237 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2960,10 +2960,12 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 		.nodeid_out = ff_out->nodeid,
 		.fh_out = ff_out->fh,
 		.off_out = pos_out,
-		.len = min_t(size_t, len, UINT_MAX & PAGE_MASK),
+		.len = len,
 		.flags = flags
 	};
 	struct fuse_write_out outarg;
+	struct fuse_copy_file_range_out outarg_64;
+	u64 bytes_copied;
 	ssize_t err;
 	/* mark unstable when write-back is not used, and file_out gets
 	 * extended */
@@ -3013,33 +3015,51 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (is_unstable)
 		set_bit(FUSE_I_SIZE_UNSTABLE, &fi_out->state);
 
-	args.opcode = FUSE_COPY_FILE_RANGE;
+	args.opcode = FUSE_COPY_FILE_RANGE_64;
 	args.nodeid = ff_in->nodeid;
 	args.in_numargs = 1;
 	args.in_args[0].size = sizeof(inarg);
 	args.in_args[0].value = &inarg;
 	args.out_numargs = 1;
-	args.out_args[0].size = sizeof(outarg);
-	args.out_args[0].value = &outarg;
+	args.out_args[0].size = sizeof(outarg_64);
+	args.out_args[0].value = &outarg_64;
+	if (fc->no_copy_file_range_64) {
+fallback:
+		/* Fall back to old op that can't handle large copy length */
+		args.opcode = FUSE_COPY_FILE_RANGE;
+		args.out_args[0].size = sizeof(outarg);
+		args.out_args[0].value = &outarg;
+		inarg.len = len = min_t(size_t, len, UINT_MAX & PAGE_MASK);
+	}
 	err = fuse_simple_request(fm, &args);
 	if (err == -ENOSYS) {
-		fc->no_copy_file_range = 1;
-		err = -EOPNOTSUPP;
+		if (fc->no_copy_file_range_64) {
+			fc->no_copy_file_range = 1;
+			err = -EOPNOTSUPP;
+		} else {
+			fc->no_copy_file_range_64 = 1;
+			goto fallback;
+		}
 	}
-	if (!err && outarg.size > len)
-		err = -EIO;
-
 	if (err)
 		goto out;
 
+	bytes_copied = fc->no_copy_file_range_64 ?
+		outarg.size : outarg_64.bytes_copied;
+
+	if (bytes_copied > len) {
+		err = -EIO;
+		goto out;
+	}
+
 	truncate_inode_pages_range(inode_out->i_mapping,
 				   ALIGN_DOWN(pos_out, PAGE_SIZE),
-				   ALIGN(pos_out + outarg.size, PAGE_SIZE) - 1);
+				   ALIGN(pos_out + bytes_copied, PAGE_SIZE) - 1);
 
 	file_update_time(file_out);
-	fuse_write_update_attr(inode_out, pos_out + outarg.size, outarg.size);
+	fuse_write_update_attr(inode_out, pos_out + bytes_copied, bytes_copied);
 
-	err = outarg.size;
+	err = bytes_copied;
 out:
 	if (is_unstable)
 		clear_bit(FUSE_I_SIZE_UNSTABLE, &fi_out->state);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index ec248d13c8bf..42f0aff83ce0 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -850,6 +850,9 @@ struct fuse_conn {
 	/** Does the filesystem support copy_file_range? */
 	unsigned no_copy_file_range:1;
 
+	/** Does the filesystem support copy_file_range_64? */
+	unsigned no_copy_file_range_64:1;
+
 	/* Send DESTROY request */
 	unsigned int destroy:1;
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 122d6586e8d4..94621f68a5cc 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -235,6 +235,10 @@
  *
  *  7.44
  *  - add FUSE_NOTIFY_INC_EPOCH
+ *
+ *  7.45
+ *  - add FUSE_COPY_FILE_RANGE_64
+ *  - add struct fuse_copy_file_range_out
  */
 
 #ifndef _LINUX_FUSE_H
@@ -270,7 +274,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 44
+#define FUSE_KERNEL_MINOR_VERSION 45
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -657,6 +661,7 @@ enum fuse_opcode {
 	FUSE_SYNCFS		= 50,
 	FUSE_TMPFILE		= 51,
 	FUSE_STATX		= 52,
+	FUSE_COPY_FILE_RANGE_64	= 53,
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
@@ -1148,6 +1153,11 @@ struct fuse_copy_file_range_in {
 	uint64_t	flags;
 };
 
+/* For FUSE_COPY_FILE_RANGE_64 */
+struct fuse_copy_file_range_out {
+	uint64_t	bytes_copied;
+};
+
 #define FUSE_SETUPMAPPING_FLAG_WRITE (1ull << 0)
 #define FUSE_SETUPMAPPING_FLAG_READ (1ull << 1)
 struct fuse_setupmapping_in {
-- 
2.49.0


