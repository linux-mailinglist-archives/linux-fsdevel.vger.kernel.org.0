Return-Path: <linux-fsdevel+bounces-61952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A2DB8093E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 17:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12A34A00E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE8D2EAD16;
	Wed, 17 Sep 2025 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8WxUzFD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C8D333AB0
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123041; cv=none; b=t1f9p6sohqxhPGNarPGRowpv3jX6xvHqIV06NPIl9/GRJstHQiApdWkKbgocdjj5TLqPurXzRnCYCCi3YHsD2zK4ofQu36NK+bx2d8OS2YorTJhnvSpPvt5ua650cgIkXBQy7S/QSFM7OEyjgJeU/GHumPlu3xZYvPHy5qbtiYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123041; c=relaxed/simple;
	bh=qGRIys5JF7wKv1JZniMpEOjjbs/U5vyKXyFpJyPZHzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C9601LlpABykbrRDo7XYkZVaZ7xnLixZSKkTEsnzZOpVdl8m6e9gjzpDOcw9vfCpRdlawqrIxYq9ofyLqYen2ghDBXCbawdM9trcMyR+U9t7GCMiZNQRj6/ecnRSxmYsIIMecI6P9Q9NbF5fHCcUB78NXzSoa6MBcruriylhKGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L8WxUzFD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758123038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+wZBRbhCfIcILOq32sHnsWiJJky+CAvNGRjo6J6IWn0=;
	b=L8WxUzFDb5LLpkYHJ8CAHZZyJY0B/IlPyq5y1XRWDbyfVH0ajHlvVYWSMDvA4okySDL8i8
	y9MPeS5oM9m0VAxH9YQWckNZfocrFoLLSyRuwjZdlFhJ7GFk4bBszbfZ1bkzJsYQPOtUOT
	XF0WSBUQtKUQFrFPZG3b7qrhcNVtRJg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-Xn0zX0k9O0qPAZOH6O2IMg-1; Wed, 17 Sep 2025 11:30:35 -0400
X-MC-Unique: Xn0zX0k9O0qPAZOH6O2IMg-1
X-Mimecast-MFC-AGG-ID: Xn0zX0k9O0qPAZOH6O2IMg_1758123034
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45ddbdb92dfso34974025e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 08:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758123033; x=1758727833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wZBRbhCfIcILOq32sHnsWiJJky+CAvNGRjo6J6IWn0=;
        b=gMw9zKxcsVIUsxarciGPPaaSa6EMR1hCjUcQFImvTwBW2O4+cT8erTtzubw3Bp3P81
         NdMz5Ugizr4mGIdpQCy02QFrSpmOLVPpwizF6mQaNNRkgWh0drpVIGdaF2gTEfkU294T
         MlNQCCgf9Bhp0Y+v6dvCOdSZyBNpQ5y/5jTJVrZH4hDiG+zHr5iagbELOSrGN/B7uX/a
         9+SH1XM+oEGeEOJGVQgAZT0eM5k8oH1kphZTPb1eXVwIhK5XvZUDfkFN37Waa6jmrNno
         /pRsrivqQAQSzCVXhUy8f4VnJUOiSSjIM5mbq93XDrLqmYIgZodplpNGqz4cVVzRv8p4
         XcJg==
X-Gm-Message-State: AOJu0YwdBWpeHUNqRu9AWXjMqZjtZPRKARCf2HtHDG7mQSgfdQF98wkA
	X6jYfBqoWTzak4v2OyVzSqjNafWsaPrBCF+zigTVKWp8i+sMDCYA0z8Ot3lk4TVIHywhlrUs+m1
	kL/KqDlukH8YT+eorZI/O78nXIzJ3S1mm7pJy5UyZJpzcQBbiX0DxNlWhFoGOYE54NwI9xyA+vc
	DxC5nUPUpYW0l0jhnc4wrL/A3WR7lYsuIXuRUTm1zN2JsdVtdD73o=
X-Gm-Gg: ASbGncsQtpBdOKJsuG2NjWmpQhxaQ3LmFNwF8tiRJTsgnBtHOJ7QlRRSw6GRp2Hlvct
	Cdx2m0YswHVAL8U92diu5D99l8+AeZ7lZCKZ1EwkMgIzHK/SeZjDLjduyeYiAPS/HKZGb+ng/Zc
	zjYmIZqotOdvYlcDb4/Z5pG/jo8XjUnMV172gy92j6gNgJSxgUchDBJHT/l75qrsW8w6ErGJBTu
	QqyXaBZtSRNXvXBmFR9NwawG5HTjmT3/AuIWEKO394MeCMBT4A6svCWfqE51oNv1htS7veE9Xnq
	MNSQXF36hY+DASm/xBJI9XmChxJbFkw/92yf+UCf9J8vocAtwIC8ClC6Vrw9vIvw8aUx48IXP1C
	0k85txyFEpRPF1oIw7BX3Rw==
X-Received: by 2002:a05:6000:290b:b0:3e9:9282:cfdc with SMTP id ffacd0b85a97d-3ecdf9f44famr2370856f8f.12.1758123033538;
        Wed, 17 Sep 2025 08:30:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE10SIsuAAxKwrMnQs3f0QGXdbrEYT9DkVrxChgBsNftQ5KW+fmqs6BKcxBXD6V3sfp4EyfxA==
X-Received: by 2002:a05:6000:290b:b0:3e9:9282:cfdc with SMTP id ffacd0b85a97d-3ecdf9f44famr2370826f8f.12.1758123032993;
        Wed, 17 Sep 2025 08:30:32 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (176-241-40-109.pool.digikabel.hu. [176.241.40.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e84de17f9bsm19665691f8f.49.2025.09.17.08.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:30:32 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	NeilBrown <neil@brown.name>
Subject: [PATCH] fuse: prevent exchange/revalidate races
Date: Wed, 17 Sep 2025 17:30:24 +0200
Message-ID: <20250917153031.371581-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a path component is revalidated while taking part in a
rename(RENAME_EXCHANGE) request, userspace might find the already exchanged
files, while the kernel still has the old ones in dcache.  This mismatch
will cause the dentry to be invalidated (unhashed), resulting in
"(deleted)" being appended to proc paths.

Prevent this by taking the inode lock shared for the dentry being
revalidated.

Another race introduced by commit 5be1fa8abd7b ("Pass parent directory
inode and expected name to ->d_revalidate()") is that the name passed to
revalidate can be stale (rename succeeded after the dentry was looked up in
the dcache).

By checking the name and the parent while the inode is locked, this issue
can also be solved.

This doesn't deal with revalidate/d_splice_alias() races, which happens if
a directory (which is cached) is moved on the server and the new location
discovered by a lookup.  In this case the inode is not locked during the
new lookup.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dir.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 5c569c3cb53f..7148b2a7611a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -235,9 +235,18 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
 
 		attr_version = fuse_get_attr_version(fm->fc);
 
+		inode_lock_shared(inode);
+		if (entry->d_parent->d_inode != dir ||
+		    !d_same_name(entry, entry, name)) {
+			/* raced with rename, assume revalidated */
+			inode_unlock_shared(inode);
+			return 1;
+		}
+
 		fuse_lookup_init(fm->fc, &args, get_node_id(dir),
 				 name, &outarg);
 		ret = fuse_simple_request(fm, &args);
+		inode_unlock_shared(inode);
 		/* Zero nodeid is same as -ENOENT */
 		if (!ret && !outarg.nodeid)
 			ret = -ENOENT;
-- 
2.51.0


