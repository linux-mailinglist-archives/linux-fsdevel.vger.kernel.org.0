Return-Path: <linux-fsdevel+bounces-54295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B25AFD709
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 21:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9049617BC0F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 19:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522D42E54D5;
	Tue,  8 Jul 2025 19:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="ELgCtArV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9984D1DE2A7
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 19:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752002492; cv=none; b=QKaHbvgBvY1IXt5P/ebMeYUhz5+6DRQy580/CViU7m5M32IYAi7R9B446kZ1RC+zY7W5L/r/uaMYu40nvg3v+kFY5xRvxd7aogLtQg8iCDM3LsSnyW6f09iB90jZMfm1oovDDvreVrws3bWxp5qTYY3K0lCNjVs6ht+ehqYDCao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752002492; c=relaxed/simple;
	bh=s9dES1SadFRVh8gbf6CKstSv01tZBHoL1pYD5OXdkpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L+BlO5ZpMDzjUlVITG/5CT7x0agvcQbmziniARH3oTRdMCMQn6GpedkQ3xJNn69WaBhpZPajO5bmIetqT1uGjADDxfO5Pi76iTJqa9CNQ4POg1VqG5gKHfwlCX8H1JTQ3H8L1QTmxk6DWKPJCVmuop6bQgCfBL5qVDQ9rSOs2Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=ELgCtArV; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e8986a25cbfso3662557276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jul 2025 12:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1752002489; x=1752607289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mjBAXEwEn3Yd17V0j1d9yubI6pZTpgcYrR5ZsArYyiU=;
        b=ELgCtArVHxUV9ct6DQsW0RkTbFvWU4U37nVgFjrv1MH9CuF7rB+3H2414+p1e6Yh5u
         feHFCNlarWpff7AoBBCD97C5M7PIUVKoSn4hvCClLLbYgTT5aICgk0Gx/bpx/VD+RJWz
         Af9UFrVqDxKcv1rcQKuR8e8CvasuagANqKTBeNgKVUa8tPqjrZOuornVfbPJnsCjjLpm
         qNnlYFZ2qgagd+jD+WovH4ZjuToYxoWhotcpaQRK9837P9S7d2z40qcDx17QmMGpe87q
         i8ZRjRie8DpDrx/qq43RWvDcKPzNZKzjq0DaYN3JbI+7LZPxLrUUcsBIqSnT4rw3lVRJ
         WtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752002489; x=1752607289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mjBAXEwEn3Yd17V0j1d9yubI6pZTpgcYrR5ZsArYyiU=;
        b=EUEJJLN+2AZ8Kl3tX6wUr42gqtFMbiL+3ZSvYjrFcFzfrEvhOCnA3aglweZiKy5qAa
         qi+dXHWKtgm//jjfsGnb2eIhXkRV2/MPCQS9qQ1DIEcu52cj1/UHuk36V4NnjmWbOrn7
         WLwqb4gQbqoPQ0Xod6NM/rgxxdhOPFsKHXuEht1wOGejUjVoli4DvHhLWcDSYriRM3a5
         i1wt3uCm5M2GGDDYr/dAkxpmBFWUryydATKW70sfhCZ6zqL5vlgcWfqVcFvQfMGorPG3
         Eh7QHhlHdje1Qkbwmux4cfEPQhwD/UN9b0H1o+kjJQDvYK4Ryxu1y4EGEjBoXXrgC8mc
         IaFA==
X-Forwarded-Encrypted: i=1; AJvYcCUxVxMWdhL0rCV5id8kjHWZ2R1EbHEhGJqh1yOiW4EMDg7jc2o3jCxeZDhZKU4Sp6D3OV0K9QdSW5lZAnCT@vger.kernel.org
X-Gm-Message-State: AOJu0YzLXGiWRY5ORe6FnObvDXqB1ZoTZFmCC97cnNcUuJ2unkKLPAQA
	Ih1SfCeaiifxejSkptpfRPB7uCLZpTY0wHbEbOmyqZQsGBygY2nN+PJpOfbW24E3BLA=
X-Gm-Gg: ASbGncu/jKgmaMLNy+FI1bFm938Zw/KbZwfQdIsqyiTlik1Tw3LvL83+niJd6GlJ0CT
	efJ2A/SDeRmC1RX3FDe6D2l/kWCmaLkz8uJYHx7bRnUpxNwOfBshchl0RTfphHHNnVopX7YrVRm
	lUU1fVYs8mdvVdmYZOrVydi6EfX9pVBZ1AxiLzs7k13AzXKqRlLD7KDagQ1rE8SR7pTUSi3kQ3Z
	gVZlGjB2chqpQTV+l1uJIWHaGF9w3W+togNYwCLNw8dxTyl74fB/oHldpXQs+ts1Pwug0+ECOSC
	wnzV4npXbh6Tk4dKP8xUu4s0haU9rRBe2Ip58fngYsr5TnOJBZk1zW95LyEDhexn/QW4QE89yQS
	emrs=
X-Google-Smtp-Source: AGHT+IEpvtk93U3NBvDRwWL9tjsnZS//Ah0EE+U4I8e+DgSrWXkxapswO7CLjQdqxw5+ETvJEN+wAw==
X-Received: by 2002:a05:690c:f10:b0:70e:1771:c165 with SMTP id 00721157ae682-71668d47310mr249803697b3.29.1752002489019;
        Tue, 08 Jul 2025 12:21:29 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:219:90b0:c3f8:d38e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-716659a00c5sm22401407b3.33.2025.07.08.12.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 12:21:28 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	willy@infradead.org
Subject: [PATCH v2] ceph: refactor wake_up_bit() pattern of calling
Date: Tue,  8 Jul 2025 12:20:57 -0700
Message-ID: <20250708192057.539725-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

The wake_up_bit() is called in ceph_async_unlink_cb(),
wake_async_create_waiters(), and ceph_finish_async_create().
It makes sense to switch on clear_bit() function, because
it makes the code much cleaner and easier to understand.
More important rework is the adding of smp_mb__after_atomic()
memory barrier after the bit modification and before
wake_up_bit() call. It can prevent potential race condition
of accessing the modified bit in other threads. Luckily,
clear_and_wake_up_bit() already implements the required
functionality pattern:

static inline void clear_and_wake_up_bit(int bit, unsigned long *word)
{
	clear_bit_unlock(bit, word);
	/* See wake_up_bit() for which memory barrier you need to use. */
	smp_mb__after_atomic();
	wake_up_bit(word, bit);
}

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 fs/ceph/dir.c  | 3 +--
 fs/ceph/file.c | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index a321aa6d0ed2..1535b6540e9d 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1261,8 +1261,7 @@ static void ceph_async_unlink_cb(struct ceph_mds_client *mdsc,
 	spin_unlock(&fsc->async_unlink_conflict_lock);
 
 	spin_lock(&dentry->d_lock);
-	di->flags &= ~CEPH_DENTRY_ASYNC_UNLINK;
-	wake_up_bit(&di->flags, CEPH_DENTRY_ASYNC_UNLINK_BIT);
+	clear_and_wake_up_bit(CEPH_DENTRY_ASYNC_UNLINK_BIT, &di->flags);
 	spin_unlock(&dentry->d_lock);
 
 	synchronize_rcu();
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index a7254cab44cc..57451958624e 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -580,8 +580,7 @@ static void wake_async_create_waiters(struct inode *inode,
 
 	spin_lock(&ci->i_ceph_lock);
 	if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE) {
-		ci->i_ceph_flags &= ~CEPH_I_ASYNC_CREATE;
-		wake_up_bit(&ci->i_ceph_flags, CEPH_ASYNC_CREATE_BIT);
+		clear_and_wake_up_bit(CEPH_ASYNC_CREATE_BIT, &ci->i_ceph_flags);
 
 		if (ci->i_ceph_flags & CEPH_I_ASYNC_CHECK_CAPS) {
 			ci->i_ceph_flags &= ~CEPH_I_ASYNC_CHECK_CAPS;
@@ -765,8 +764,7 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
 	}
 
 	spin_lock(&dentry->d_lock);
-	di->flags &= ~CEPH_DENTRY_ASYNC_CREATE;
-	wake_up_bit(&di->flags, CEPH_DENTRY_ASYNC_CREATE_BIT);
+	clear_and_wake_up_bit(CEPH_DENTRY_ASYNC_CREATE_BIT, &di->flags);
 	spin_unlock(&dentry->d_lock);
 
 	return ret;
-- 
2.49.0


