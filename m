Return-Path: <linux-fsdevel+bounces-33450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1DD9B8CFE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 09:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E00D41C2201A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 08:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEE7158553;
	Fri,  1 Nov 2024 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="ktN7mzhi";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="lH+Ja5dy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02330154C15;
	Fri,  1 Nov 2024 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730449590; cv=none; b=IkT9oIgxnGcJcpjUdKBMQjIhFiSdQu+p/ZXCROssXQ/bXDCq/GbnnYYhQkuq7+hXqzW9wUQP39oE9KO+j1BWJ/3FVYiOZpRJoqwyVhIbspgtit6D4TV2L49QjIwSGBozxOAL3BKJAoCcrV1mGArWWtC0o4u3ccc4pcl9ZZ4vBVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730449590; c=relaxed/simple;
	bh=U0RXtdPp1WscZLdHFhcN92IhEj/x6c1cGQUaWXoIPc0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nj86cezYfzhdt1Rdxt0b0hB8a7Q3rbttUlgZXa8hjv/bxI5JgTqDM8pgZV6GiwZRbFt2ltIxlsFpxBC+iYJkddbVFQzHCSbMim/0jmRJMBqQsN49BB2K/bUqmjaKAgOkSJvJv+ssjIIWCo4xURLdFOGzaO+u7YQhoB5XzqFmXRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=ktN7mzhi; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=lH+Ja5dy; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 457D5218E;
	Fri,  1 Nov 2024 08:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1730448623;
	bh=9wn86gsG6BMDjW/ovhKBk4LvQkb8iLktrVduNY8huFI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ktN7mzhi1mF3s/X6chPXtlsyQdd05eZDfS0Oiy/acDXugjUoCFTXJQB8mB6VEHqg2
	 dZt4uMyWNA93bFRc0Kn9+mvdGuz1JXTm0ixTNJdJA00r0lYldTleerkpw3ktsLK8kR
	 MQq38U//t8M4oQI1lTyia8+669Czila3iFStqM6M=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id CBCCD220E;
	Fri,  1 Nov 2024 08:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1730449086;
	bh=9wn86gsG6BMDjW/ovhKBk4LvQkb8iLktrVduNY8huFI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=lH+Ja5dyM6wi5O0y9xkT6Wln32qiTAPZ36UlmLa/ier+eRPMftS6bq2VCA5J1mNmC
	 meankEolfeRRymaf93W0faawPWhoaQ2MSjtDw+0xc987I8G1+Tdu3tOOUMU8yRfQ38
	 lN/vqPfjuEpsgQEmANlJHzQ3g1zmN8UdB5YN9Exo=
Received: from ntfs3vm.paragon-software.com (192.168.211.142) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 1 Nov 2024 11:18:06 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	<syzbot+7f3761b790fa41d0f3d5@syzkaller.appspotmail.com>
Subject: [PATCH 2/7] fs/ntfs3: Fix case when unmarked clusters intersect with zone
Date: Fri, 1 Nov 2024 11:17:48 +0300
Message-ID: <20241101081753.10585-3-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101081753.10585-1-almaz.alexandrovich@paragon-software.com>
References: <20241101081753.10585-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Reported-by: syzbot+7f3761b790fa41d0f3d5@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/run.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index 58e988cd8049..48566dff0dc9 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -1055,8 +1055,8 @@ int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 {
 	int ret, err;
 	CLST next_vcn, lcn, len;
-	size_t index;
-	bool ok;
+	size_t index, done;
+	bool ok, zone;
 	struct wnd_bitmap *wnd;
 
 	ret = run_unpack(run, sbi, ino, svcn, evcn, vcn, run_buf, run_buf_size);
@@ -1087,8 +1087,9 @@ int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 			continue;
 
 		down_read_nested(&wnd->rw_lock, BITMAP_MUTEX_CLUSTERS);
+		zone = max(wnd->zone_bit, lcn) < min(wnd->zone_end, lcn + len);
 		/* Check for free blocks. */
-		ok = wnd_is_used(wnd, lcn, len);
+		ok = !zone && wnd_is_used(wnd, lcn, len);
 		up_read(&wnd->rw_lock);
 		if (ok)
 			continue;
@@ -1096,14 +1097,33 @@ int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 		/* Looks like volume is corrupted. */
 		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
 
-		if (down_write_trylock(&wnd->rw_lock)) {
-			/* Mark all zero bits as used in range [lcn, lcn+len). */
-			size_t done;
-			err = wnd_set_used_safe(wnd, lcn, len, &done);
-			up_write(&wnd->rw_lock);
-			if (err)
-				return err;
+		if (!down_write_trylock(&wnd->rw_lock))
+			continue;
+
+		if (zone) {
+			/*
+			 * Range [lcn, lcn + len) intersects with zone.
+			 * To avoid complex with zone just turn it off.
+			 */
+			wnd_zone_set(wnd, 0, 0);
+		}
+
+		/* Mark all zero bits as used in range [lcn, lcn+len). */
+		err = wnd_set_used_safe(wnd, lcn, len, &done);
+		if (zone) {
+			/* Restore zone. Lock mft run. */
+			struct rw_semaphore *lock;
+			lock = is_mounted(sbi) ? &sbi->mft.ni->file.run_lock :
+						 NULL;
+			if (lock)
+				down_read(lock);
+			ntfs_refresh_zone(sbi);
+			if (lock)
+				up_read(lock);
 		}
+		up_write(&wnd->rw_lock);
+		if (err)
+			return err;
 	}
 
 	return ret;
-- 
2.34.1


