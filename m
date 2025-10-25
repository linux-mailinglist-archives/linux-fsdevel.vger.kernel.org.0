Return-Path: <linux-fsdevel+bounces-65630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 71851C09923
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 18:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1896734E598
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 16:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44075306B3D;
	Sat, 25 Oct 2025 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f08v9eXN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDE72FB99A;
	Sat, 25 Oct 2025 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409666; cv=none; b=E/aPUSqv3JvDn6Z4ew+lemChToKghVHjsaH0Ayknc6nliRi+bTV1AMfL9XxCYT7Wdl8hRsjVmJ+g0BXcekRRzec8rmjW721pSU0EWtODMfOQl4VwhppDPntUDjWrNMnI5PLFO1UGhMzWqFKXea+zEZq50CpW/IbQqY+nDVdBBeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409666; c=relaxed/simple;
	bh=V3Ju5Ag8i4WkS8138BvjU6X3PT2JxrmorIOw+5wRt48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxHn9VMEMFvjeMhxqGyPRCIEeUV0JVcH5QG9phnH8+OWXtmkvoHXy+3SpmA5PDwLOUylJF9g7Mphc/YAzJ774hecl2CLP1NgrylsPomQdOe/sas9hUjVp1HwlQbc0k1XtVa9Nz6VN0qPdSefTJCcRE/t54gP8k6xevEYYvY5uC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f08v9eXN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC04BC113D0;
	Sat, 25 Oct 2025 16:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409666;
	bh=V3Ju5Ag8i4WkS8138BvjU6X3PT2JxrmorIOw+5wRt48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f08v9eXNeR+UqHyBs1LS446c+/K2fnRemo5A3heBP8TG+UJQzFGq/y/ybgP8Mz/Ik
	 qOvOVAelfV7zhltSvwf4MCEZC2HlnQWde4WEhF+2iBQyEytg3mWtGg8cgifMHQPuDL
	 nnRV+Q1Lwn1p6kBt2c5cTFCRuqyNhJ4DKuut8WcgPaEDd0pNYsDZERxFjs7kdQMBpn
	 Yx5UXN9xCjuUmIDQoopswS4jRWi8GfaRB3VVfUn3UDHkFI0umHVdk7L6oLfPMSwg3Z
	 OS/k8cawU6m65SdNy6VLp8NmDK2BaUL5d4cR6pEy2ljoo8E+y5y2ILE2eokHIYTVi8
	 gLk+Bq/QPcptQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Chi Zhiling <chizhiling@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sj1557.seo@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-5.10] exfat: limit log print for IO error
Date: Sat, 25 Oct 2025 12:00:43 -0400
Message-ID: <20251025160905.3857885-412-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chi Zhiling <chizhiling@kylinos.cn>

[ Upstream commit 6dfba108387bf4e71411b3da90b2d5cce48ba054 ]

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
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES. The change switches the hot error sites in `exfat_ent_get()` to the
already-available rate-limited logger (`fs/exfat/fatent.c:96`, `:104`,
`:112`, `:120`, `:128`), so the driver still returns the same `-EIO`
codes but no longer emits hundreds of thousands of synchronous
`exfat_fs_error()` messages that were stretching the failing read path
to ~150 s. Because `exfat_fs_error_ratelimit()` simply gates the printk
while preserving the remount/panic handling in `__exfat_fs_error()`
(`fs/exfat/exfat_fs.h:555-561`, `fs/exfat/misc.c:26-47`), correctness
isn’t touched. The rate limiter is already initialized per superblock
(`fs/exfat/super.c:803-808`) and used in other exFAT paths
(`fs/exfat/inode.c:288`), so the patch aligns this high-frequency error
path with existing practice. This is a contained fix for a user-visible
regression (extreme latency when media disappears), introduces no
architectural changes, and applies cleanly to stable trees that already
ship the same infrastructure.

 fs/exfat/fatent.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index 232cc7f8ab92f..825083634ba2d 100644
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
2.51.0


