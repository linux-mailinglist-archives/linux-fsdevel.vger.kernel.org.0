Return-Path: <linux-fsdevel+bounces-65595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80536C08987
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 05:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2E033352C57
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 03:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8372580F2;
	Sat, 25 Oct 2025 03:30:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE8C2586E8;
	Sat, 25 Oct 2025 03:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761363008; cv=none; b=PsdwySagitvq3xcjxanMmVKktvq2rPzID4f5EeG8iLBDbdQ5bmxHdy6zmvJUXo6dqDU7F2RRJgAkipZ8Wkt88JZNo5DZsLPPxQy1NMEo5ZwyzMTTv/aU27fiTulDD5AhVw3nModbctNnWqOrdwChqyari2DLoIfIZ8t4QktwAX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761363008; c=relaxed/simple;
	bh=2SHImZoJ2obw5+EaYGXBRsuMjz8VFs0jcJgay98MzVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gcaetKj9Sq1SNxFAABR9tTJDalyjZ6gobb6Ek0mbp2kzWp+SXme686JPSypLFs2tDXam2QPEKWuJQlFtcCLup5GszDfFQQlaNA/w0EOudGNze97WOAPlrHIMvk3AI9T1HkO7/8x/kR/ndkS6TZbZrmDxPMRA1TVQ+aQ6ib1+rxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ctlcK0mGXzYQtlp;
	Sat, 25 Oct 2025 11:29:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id B72951A17E2;
	Sat, 25 Oct 2025 11:30:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHnEQ6RPxox1YbBg--.45388S7;
	Sat, 25 Oct 2025 11:30:03 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	kernel@pankajraghav.com,
	mcgrof@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	libaokun1@huawei.com,
	libaokun@huaweicloud.com
Subject: [PATCH 03/25] ext4: remove PAGE_SIZE checks for rec_len conversion
Date: Sat, 25 Oct 2025 11:21:59 +0800
Message-Id: <20251025032221.2905818-4-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251025032221.2905818-1-libaokun@huaweicloud.com>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHnEQ6RPxox1YbBg--.45388S7
X-Coremail-Antispam: 1UD129KBjvJXoW7AFW3CFW8GFW5JFy8urykXwb_yoW8Ar1rpF
	43GryUGrWYvF1Uua9rXF45Ga4Skw13Kw1UJ39xW3yfWFy7Wr4fXr9aqFyFqFW0qrZ2vFWU
	ZFs8JFWftr1rCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQ014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUo6wZDUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAMBWj7Ua9I6QABsG

From: Baokun Li <libaokun1@huawei.com>

Previously, ext4_rec_len_(to|from)_disk only performed complex rec_len
conversions when PAGE_SIZE >= 65536 to reduce complexity.

However, we are soon to support file system block sizes greater than
page size, which makes these conditional checks unnecessary. Thus, these
checks are now removed.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 24c414605b08..93c2bf4d125a 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2464,28 +2464,19 @@ static inline unsigned int ext4_dir_rec_len(__u8 name_len,
 	return (rec_len & ~EXT4_DIR_ROUND);
 }
 
-/*
- * If we ever get support for fs block sizes > page_size, we'll need
- * to remove the #if statements in the next two functions...
- */
 static inline unsigned int
 ext4_rec_len_from_disk(__le16 dlen, unsigned blocksize)
 {
 	unsigned len = le16_to_cpu(dlen);
 
-#if (PAGE_SIZE >= 65536)
 	if (len == EXT4_MAX_REC_LEN || len == 0)
 		return blocksize;
 	return (len & 65532) | ((len & 3) << 16);
-#else
-	return len;
-#endif
 }
 
 static inline __le16 ext4_rec_len_to_disk(unsigned len, unsigned blocksize)
 {
 	BUG_ON((len > blocksize) || (blocksize > (1 << 18)) || (len & 3));
-#if (PAGE_SIZE >= 65536)
 	if (len < 65536)
 		return cpu_to_le16(len);
 	if (len == blocksize) {
@@ -2495,9 +2486,6 @@ static inline __le16 ext4_rec_len_to_disk(unsigned len, unsigned blocksize)
 			return cpu_to_le16(0);
 	}
 	return cpu_to_le16((len & 65532) | ((len >> 16) & 3));
-#else
-	return cpu_to_le16(len);
-#endif
 }
 
 /*
-- 
2.46.1


