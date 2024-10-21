Return-Path: <linux-fsdevel+bounces-32479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8809A68FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 14:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E0B1F22A52
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 12:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684221F5854;
	Mon, 21 Oct 2024 12:47:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2F01EBA0C;
	Mon, 21 Oct 2024 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514873; cv=none; b=IzvBJSyK+yOdsJV5mIzygDqL318PgM8GmKKfkg8xtOneObvZBLCu+kyFOdw1GI0upSTWc54gDETuecOctuF9EepUsar84Amr9uKhgYmT0NIE5Ds+7CArgmTD5M81CGa/m7/YeIPaPIAYBWJJyL8LslpHu8hizPr2jaCvpGd+P9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514873; c=relaxed/simple;
	bh=1FAdfDt0b6kTld8gsii+fwwDIv8OQVKZ2kX2V/F2fSY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z58YKImZvUu7NnnH2wMqrXmVqF5QVh9VhCqTyBQehd/mFX3hudACgyl9pHMa/TaujJNg7iQEBPXR9oo/cWvJnqUF4nQDiTQHSyNocM/mSBXfM3AIE4RX8lmuik3Csbdr6OOmIQUHIHUbcUep7/R4PVfbr4Q4vejf9ZQYdjYOe+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XXFSv00Fhz4f3jMx;
	Mon, 21 Oct 2024 20:47:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 561781A0359;
	Mon, 21 Oct 2024 20:47:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAnXMhuTRZn+TzdEg--.6426S4;
	Mon, 21 Oct 2024 20:47:44 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-kernel@vger.kernel.org,
	houtao1@huawei.com
Subject: [PATCH] fuse: zero folio correctly in fuse_notify_store()
Date: Mon, 21 Oct 2024 20:59:55 +0800
Message-Id: <20241021125955.2443353-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAnXMhuTRZn+TzdEg--.6426S4
X-Coremail-Antispam: 1UD129KBjvdXoWrtF18ur1xXr4DKr4ftw1DJrb_yoWDKFX_ur
	48Z3Z5WF48Wrn29F15ZFn3Jryqq34rGF48uF48ZFWfAry5Zw4xuFyvvrn5uryrXrW3XFs8
	Ar1kAFZIkw1jgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb78YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF
	7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

The third argument of folio_zero_range() should be the length to be
zeroed, not the total length. Fix it by using folio_zero_segment()
instead in fuse_notify_store().

Reported-by: syzbot+65d101735df4bb19d2a3@syzkaller.appspotmail.com
Fixes: 5d9e1455630d ("fuse: convert fuse_notify_store to use folios")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/fuse/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 824e329b8fd7..eb89a301c406 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1668,7 +1668,7 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 		err = fuse_copy_page(cs, &page, offset, this_num, 0);
 		if (!folio_test_uptodate(folio) && !err && offset == 0 &&
 		    (this_num == folio_size(folio) || file_size == end)) {
-			folio_zero_range(folio, this_num, folio_size(folio));
+			folio_zero_segment(folio, this_num, folio_size(folio));
 			folio_mark_uptodate(folio);
 		}
 		folio_unlock(folio);
-- 
2.29.2


