Return-Path: <linux-fsdevel+bounces-620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0242C7CDA19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 13:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 335C61C20D21
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 11:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023F41A70C;
	Wed, 18 Oct 2023 11:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDx6kAC4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3755618C10
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 11:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E387BC433C7;
	Wed, 18 Oct 2023 11:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697627744;
	bh=eqnb/qNu51ZmgB//9K6h6NWc3AFRVlk3BSEB6pAXkJ8=;
	h=From:Date:Subject:To:Cc:From;
	b=CDx6kAC4XqX3kYRnRTuuUydj0qo9JpnZCSEtNIzTaMtJFPxa1GPjkX/IvRPXTCvwl
	 N3CY/Hmb4NWoPaZEtwk8ZFHkD7jmHd7mgOBM/Rx+xO3xblf74JO+arjs8HxadGlLnd
	 CQeuYj3sdm4/fis401LI6lYeiBmeLlOo8VFHO2UlucRMsnRcFfwIqeTfQ8UuVshmyE
	 Mlj60cqHThFagDSlEGcdsjN3vD4JdkXB5jTa6IDHoYv5zjW9CJ9wczI3J0wiMCrHZp
	 a50DbIuU42cSw0SsuVr7Na8mm1rqGFFySRuqhrpj0KEqhxj4gfqpK1T89b/IPifwsp
	 ZhK7YjfJ2awCg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 18 Oct 2023 07:15:40 -0400
Subject: [PATCH] fat: fix mtime handing in __fat_write_inode
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231018-amtime-v1-1-e066bae97285@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFu+L2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDA0ML3cTckszcVF0jkxSj1LS05GTLREsloOKCotS0zAqwQdGxtbUA9I1
 pHVgAAAA=
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
 Klara Modin <klarasmodin@gmail.com>, Christian Brauner <brauner@kernel.org>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1412; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=eqnb/qNu51ZmgB//9K6h6NWc3AFRVlk3BSEB6pAXkJ8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlL75fXmq2zfmW9Xdd8xNXSSW99pSGmhSQR6U+O
 hQcUHf+coKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZS++XwAKCRAADmhBGVaC
 FX6WEAC9nKhANczujf31/07xncKpeHmV409EfIwvIg1jL4PHEy18gcKqdqTpQ2egNKuac2M3cZv
 nAc06PMwTaGEPYqJCxkz/dEON5QGFwyPmsctCPUNcyPGO3vMalxYUaZWA2tkokAD0QTmVB7sZol
 5IqjybIKcdYk63ezrNb1RMlyYPh0iDoRVC3t4Mqjn6Jls9Fwd7b/htLJoXIwlCvY3dlmdi9vWmQ
 +29uYoLTx6Rxr1f0nQUYi0rWn7w6vHOqIe6o79rMngbhAEXbWqcZ5ed6s4wctGyNa5q+3m1vFfD
 A7iqYWAMSJ7XxTX9VEgAFlDEj6CGwfHrwy1YLGfjGIuNt4q1OQt0rZ5QfoMoOPizmnmTakDwVrB
 50Nc0tDj421CAdtk0k1YIusgMY5TH5s46EcoyZaUK2SEC/dBkvg64DLPz3gEtoPQl3RjUWYKbtG
 ZQOzh1Q3AEjf/aoM9HsdxiSh5l9WWAVxnkhF+VSrnXEAn7yNK4AM/IE48uf8ne6VJ86Al1rWXxQ
 0y8UVhM2jpG++mEpnrJPPed9tDqHJ/9b31w/zulnB3T01zGhJxetuxL4scm+Scb/h9on5JwNvaf
 vV2vrcEXCPBLZ8ET4WcWvPSU5FKdoTs+M0rPferF/vNc+rwi/KfiWOyRp7h9pPtcikoio/WGZ6m
 9JbdIyfGlBoM+YQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Klara reported seeing mangled mtimes when dealing with FAT. Fix the
braino in the FAT conversion to the new timestamp accessors.

Fixes: e57260ae3226 (fat: convert to new timestamp accessors)
Reported-by: Klara Modin <klarasmodin@gmail.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
This patch fixes the bug that Klara reported late yesterday. The issue
is a bad by-hand conversion of __fat_write_inode to the new timestamp
accessor functions.

Christian, this patch should probably be squashed into e57260ae3226.

Thanks!
Jeff
---
 fs/fat/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index aa87f323fd44..1fac3dabf130 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -888,9 +888,9 @@ static int __fat_write_inode(struct inode *inode, int wait)
 		raw_entry->size = cpu_to_le32(inode->i_size);
 	raw_entry->attr = fat_make_attrs(inode);
 	fat_set_start(raw_entry, MSDOS_I(inode)->i_logstart);
+	mtime = inode_get_mtime(inode);
 	fat_time_unix2fat(sbi, &mtime, &raw_entry->time,
 			  &raw_entry->date, NULL);
-	inode_set_mtime_to_ts(inode, mtime);
 	if (sbi->options.isvfat) {
 		struct timespec64 ts = inode_get_atime(inode);
 		__le16 atime;

---
base-commit: fea0e8fc7829dc85f82c8a1a8249630f6fb85553
change-id: 20231018-amtime-24d2effcc9a9

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


