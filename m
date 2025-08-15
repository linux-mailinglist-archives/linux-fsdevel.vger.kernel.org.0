Return-Path: <linux-fsdevel+bounces-57991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCB9B27D37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 11:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4A2585707
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 09:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E888E2D3225;
	Fri, 15 Aug 2025 09:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="psJnWpjN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53405191F91;
	Fri, 15 Aug 2025 09:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755250408; cv=none; b=isXZHdc32J7vHFw07GYKS+FZbvLyT0S+/+cMfTdlh5HakRTrFEXdw8X4XlRaC7NnErsDbNcvevhJmvB2I2yN2l0cHakW+/jJYr1m0hcuqq9bK0b7QJTZFrcfBRz2RxarDhltAAorEaKzWPBqSxEjur+TOSeRK7q0dFQgN1NX3DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755250408; c=relaxed/simple;
	bh=YUmvt8dZcGVA34BYz176vLdFqk0pNftEZjqEXj7iYtI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j2cbycrUk1vVrrPgdaB/RIY24YvRDMvEXaE+Fifixu7E1WTGK+uuLTzQoHDerBcVYaVO3PCbEMuqgwpLi1W0NLYaYBfxT59Tuti8ZRWM82ptzNMIIZaA0SiOj7cGiZ7dmWqwKXV3tZTBlo80YdZeukEAOcFAa2PkbexMCFhRwAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=psJnWpjN; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=78
	Sq94NcD/kEW4NP82Thy5eeBHqWMEXi7tScTnuMXw4=; b=psJnWpjNZBthozbJUj
	jNy2a1B80Fancd3xlqfGQI50m24T8+WqNpLnSFIT+qPo5wOSb94uE8yWPb2v+57E
	rVsADTfMXJmc4ppmKG2mZLXPm4iwJCCJc0nAmdKMGB3+Rn/JAkUxsej3/ELZRBLy
	Qm4WZJ2/eJ8aodj1v+mbEl8uw=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wB3BPDP_p5obn9ECA--.38398S2;
	Fri, 15 Aug 2025 17:33:04 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH] exfat: limit log print for IO error
Date: Fri, 15 Aug 2025 17:32:45 +0800
Message-ID: <20250815093245.118648-1-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3BPDP_p5obn9ECA--.38398S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGrW7KryrKF45JryUKF1Utrb_yoW5GrW8pr
	Z7WwnYkrW8t3WUZrykArW7A3W5u398XF4DGFn8CaykJryDJFs5uF1fJry0kay3K3Wvka1Y
	gryUKF17WFW7C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0nmiUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbBawConWicJLnsjwABsV

From: Chi Zhiling <chizhiling@kylinos.cn>

For exFAT filesystems with 4MB read_ahead_size, removing the storage device
when the read operation is in progress, which cause the last read syscall
spent 150s [1]. The main reason is that exFAT generates excessive log
messages [2].

After applying this patch, approximately 300,000 lines of log messages
were suppressed, and the delay of the last read() syscall was reduced
to about 4 seconds.

[1]:
write(5, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 131072) = 131072 <0.000120>
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 131072) = 131072 <0.000032>
write(5, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 131072) = 131072 <0.000119>
read(4, 0x7fccf28ae000, 131072)         = -1 EIO (Input/output error) <150.186215>

[2]:
[  333.696603] exFAT-fs (vdb): error, failed to access to FAT (entry 0x0000d780, err:-5)
[  333.697378] exFAT-fs (vdb): error, failed to access to FAT (entry 0x0000d780, err:-5)
[  333.698156] exFAT-fs (vdb): error, failed to access to FAT (entry 0x0000d780, err:-5)

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---

There is another solution, feel free to comment:
https://lore.kernel.org/all/20250812072225.181798-1-chizhiling@163.com/

 fs/exfat/fatent.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index 232cc7f8ab92..825083634ba2 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -89,35 +89,36 @@ int exfat_ent_get(struct super_block *sb, unsigned int loc,
 	int err;
 
 	if (!is_valid_cluster(sbi, loc)) {
-		exfat_fs_error(sb, "invalid access to FAT (entry 0x%08x)",
+		exfat_fs_error_ratelimit(sb,
+			"invalid access to FAT (entry 0x%08x)",
 			loc);
 		return -EIO;
 	}
 
 	err = __exfat_ent_get(sb, loc, content);
 	if (err) {
-		exfat_fs_error(sb,
+		exfat_fs_error_ratelimit(sb,
 			"failed to access to FAT (entry 0x%08x, err:%d)",
 			loc, err);
 		return err;
 	}
 
 	if (*content == EXFAT_FREE_CLUSTER) {
-		exfat_fs_error(sb,
+		exfat_fs_error_ratelimit(sb,
 			"invalid access to FAT free cluster (entry 0x%08x)",
 			loc);
 		return -EIO;
 	}
 
 	if (*content == EXFAT_BAD_CLUSTER) {
-		exfat_fs_error(sb,
+		exfat_fs_error_ratelimit(sb,
 			"invalid access to FAT bad cluster (entry 0x%08x)",
 			loc);
 		return -EIO;
 	}
 
 	if (*content != EXFAT_EOF_CLUSTER && !is_valid_cluster(sbi, *content)) {
-		exfat_fs_error(sb,
+		exfat_fs_error_ratelimit(sb,
 			"invalid access to FAT (entry 0x%08x) bogus content (0x%08x)",
 			loc, *content);
 		return -EIO;
-- 
2.43.0


