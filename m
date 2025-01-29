Return-Path: <linux-fsdevel+bounces-40300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C087A22007
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 16:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECC121885A1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 15:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A13191F95;
	Wed, 29 Jan 2025 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+VLH/FB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1068418F2EA
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738163580; cv=none; b=KVT1PDS3RUE+WDhLExRnPQY5DkXg6lMNH+nTAr+7gA4FOCOCvADx4FMy9tzLJAMczkwOcY6Zer5WPEf25QjDru237iMIGjYu+8DEmxUahvI4javn73HhskFtDtOfCw4qiVBna8ozP6tSY2c/mCtxPQMELhW2dVGsCbdXcJw4Kp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738163580; c=relaxed/simple;
	bh=Z9rKKIVZX1wMbqng6xDiHvcTLFZoAV7xesHEZrsg4mE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tthaPjh7dwjc/SN+gChxCWlUY5yN0LULRr+IEgFFT/feXxTNMjwY4NP+eD1tm8jN/6MOOhVpxlI2BwjjCMr+2ldFUBNOyK7R5pTvsZ2aMVtrxROxH4ze7Y2oaCbwueWr97GlTvZMGcmT34se0Tq2IJ61LNYCjgMNfsWNze/Nbsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P+VLH/FB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738163578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eYQ/lbZ9cZ4B91PK+ltYFjybvOyribsZchCWu1ti4xo=;
	b=P+VLH/FBdSyOS1Tb5ik3Yao60WaNGUHE6dS2fSS6tN7fD7VuwOVS4FF0jNuJqSnUMjowcr
	vjIPGEYTUSduy+86bIdZQ9RkjLlkEcAsn1SQC9U/Vb4PUlf5WQWwME6AqLeh9Csokt6hnn
	MaTiy2t+QFp5od4f0K5KIWG8EMJyt1E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-Jk53-nU4OYOPy3HgI1fLzw-1; Wed, 29 Jan 2025 10:12:56 -0500
X-MC-Unique: Jk53-nU4OYOPy3HgI1fLzw-1
X-Mimecast-MFC-AGG-ID: Jk53-nU4OYOPy3HgI1fLzw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-436248d1240so33059095e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 07:12:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738163575; x=1738768375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYQ/lbZ9cZ4B91PK+ltYFjybvOyribsZchCWu1ti4xo=;
        b=TJecHyHVvP7xcRjwvOS3nASn6CI5bdgWzzjQqSq84SJWETsO2x++5eBn5EsDJ/gT9n
         57V/JAuetaBt6stP1p8HMrIkQWu/YvfGXtbEubcQoPeB9874FymJDUZbKmAlVtlxv1YS
         q2rBqo+OWbMYR2c7akFt0+Beofq9nROZD43N9YdzCeVh/gn3QseoqJ0SR3/advHdsAuY
         Tiv9Oz1RjByiJh+8PxjF6J4faUAa1hqRboxZk1Wyl0sQxWxlTJQz20VQDlbmA6DjtZav
         2RY2davjEhB2TiBo/+cTPNKwf6XDEhOlbv3stZw2GPnStTSZfmj5j1oV0S0ozNYUd+aQ
         Bd/g==
X-Gm-Message-State: AOJu0YwQe4T2mgqZwME1a63eeZcNcORxS/pDNJuC5i1BKBFuV9v3JfRv
	1jmQ1kOKzhhaRZgdSS9db3+0KA1x7wxJBeMhkCP3HkT5TstFye6n+CMC7RYuNL4JbszkCK5h79T
	lcVUUB0jDHKdC8e+FUzvBdA33vCqaHXxws9cBHuf9Cs1DeT9mAnBikoe0OktcEnqJXGjtclYrc8
	sA6A4kEFDUUra9J/W3bZwnHZZ4DSAT8yv0nrn0dpH6dJfzfMqOiA==
X-Gm-Gg: ASbGncut+nNDKToXVysD6U8sCg7Ax+Wkf7Mo3Z8a05IfolLX23PviMCcPKTaEwgW5MQ
	EXpMdrXsPvix41U1FbByxohbnXuFQkTL3RMujwcNSkwEzAUBns7joIT1si13aJPY0j2ldVxAx0c
	DBfzP6ZjU7xxDJBlpXinZeS5XYc8jqqZhkI+3QGkoqew30n+8vxYdwud5+RNj+iTR+K58Q5CuF9
	ly2AUr0rS2AUB0y++NZJIiWWQdooXthN2S2o/lpjAvilmxCWB9DylToaagyYgbuXk0f4Tc254G6
	dkH0ldUqeGMsQC7WuTGKHp6mDiwNWuh6es4vEWWtjBR6Yyxbr5j2mwtM
X-Received: by 2002:a05:600c:4e87:b0:434:f0df:a14 with SMTP id 5b1f17b1804b1-438dc3abb93mr31522585e9.2.1738163575034;
        Wed, 29 Jan 2025 07:12:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4t49CPV6bC9T+Oagi2xeVe0ATh3Ubx6W2a1hP5ph8tmEs4kW1H8/uIxrzPrJIqLKf4O/t/w==
X-Received: by 2002:a05:600c:4e87:b0:434:f0df:a14 with SMTP id 5b1f17b1804b1-438dc3abb93mr31522295e9.2.1738163574656;
        Wed, 29 Jan 2025 07:12:54 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (91-82-183-41.pool.digikabel.hu. [91.82.183.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc2abeasm25934075e9.20.2025.01.29.07.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 07:12:54 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] fs: fix adding security options to statmount.mnt_opt
Date: Wed, 29 Jan 2025 16:12:53 +0100
Message-ID: <20250129151253.33241-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepending security options was made conditional on sb->s_op->show_options,
but security options are independent of sb options.

Fixes: 056d33137bf9 ("fs: prepend statmount.mnt_opts string with security_sb_mnt_opts()")
Fixes: f9af549d1fd3 ("fs: export mount options via statmount()")
Cc: <stable@vger.kernel.org> # v6.11
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namespace.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c11127c594c0..c44d264dcd4a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5199,30 +5199,29 @@ static int statmount_mnt_opts(struct kstatmount *s, struct seq_file *seq)
 {
 	struct vfsmount *mnt = s->mnt;
 	struct super_block *sb = mnt->mnt_sb;
+	size_t start = seq->count;
 	int err;
 
-	if (sb->s_op->show_options) {
-		size_t start = seq->count;
-
-		err = security_sb_show_options(seq, sb);
-		if (err)
-			return err;
+	err = security_sb_show_options(seq, sb);
+	if (err)
+		return err;
 
+	if (sb->s_op->show_options) {
 		err = sb->s_op->show_options(seq, mnt->mnt_root);
 		if (err)
 			return err;
+	}
 
-		if (unlikely(seq_has_overflowed(seq)))
-			return -EAGAIN;
+	if (unlikely(seq_has_overflowed(seq)))
+		return -EAGAIN;
 
-		if (seq->count == start)
-			return 0;
+	if (seq->count == start)
+		return 0;
 
-		/* skip leading comma */
-		memmove(seq->buf + start, seq->buf + start + 1,
-			seq->count - start - 1);
-		seq->count--;
-	}
+	/* skip leading comma */
+	memmove(seq->buf + start, seq->buf + start + 1,
+		seq->count - start - 1);
+	seq->count--;
 
 	return 0;
 }
-- 
2.48.1


