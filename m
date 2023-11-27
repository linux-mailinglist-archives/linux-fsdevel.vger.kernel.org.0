Return-Path: <linux-fsdevel+bounces-3924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFA37F9EFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 12:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D88A1C20DC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 11:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DA91C2B3;
	Mon, 27 Nov 2023 11:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlzFvQg9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D091BDDC
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 11:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48922C433CA;
	Mon, 27 Nov 2023 11:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701085905;
	bh=+9K0V3JbVSEuWgKW0d9m6myqmsXvVV770EO6CfUoxm8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FlzFvQg9Fdo9VM7mzK01t9cJl3Lw4VYTXbbrErl+SsVHAPEwfznaOcVIrp4V6g9aJ
	 7ko19ibh/jS2KyPCLf4pNHlbRGsvLHM2JFRp6+R8VZvZW+UdulaX6VaQ/+k48p39dd
	 zcse1UbyEpykBfKjVbkUbBILy7wIVvXyT2NA7aLbRn5x37VsQGdPJYJGEs9LR7hhUu
	 tSLlqXP4/6maGEUpJxwmSqb/z0yFOFFek4odrJLUgsY4scJoo1jA3s7kTQyKTky1fa
	 j/TKMxzYUusH0uBl07UAj6euq4OB6iwH5zojDa1wWWNx+x1ENLthd0LaCNBHkL0YNj
	 XcQFIr/sjcTmQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 27 Nov 2023 12:51:31 +0100
Subject: [PATCH 2/2] super: don't bother with WARN_ON_ONCE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-vfs-super-massage-wait-v1-2-9ab277bfd01a@kernel.org>
References: <20231127-vfs-super-massage-wait-v1-0-9ab277bfd01a@kernel.org>
In-Reply-To: <20231127-vfs-super-massage-wait-v1-0-9ab277bfd01a@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-7edf1
X-Developer-Signature: v=1; a=openpgp-sha256; l=786; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+9K0V3JbVSEuWgKW0d9m6myqmsXvVV770EO6CfUoxm8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSmNJ3ZttVExOPj6g2mVkttF629bncqek4jT9xE77ny7
 tcbDJc4dpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEUYThf6zQijfToudJLrI/
 /eNc4pVPTyS/zBG8UbnV/VDwCWPzebMYGdoN6hq6W8Nm8rDuL36z6Nk3s78HmCpdzIvcs741njp
 9mg0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We hold our own active reference and we've checked it above.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index f3227b22879d..844ca13e9d93 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -2067,10 +2067,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 	/* Release s_umount to preserve sb_start_write -> s_umount ordering */
 	super_unlock_excl(sb);
 	sb_wait_write(sb, SB_FREEZE_WRITE);
-	if (!super_lock_excl(sb)) {
-		WARN_ON_ONCE("Dying superblock while freezing!");
-		return -EINVAL;
-	}
+	__super_lock_excl(sb);
 
 	/* Now we go and block page faults... */
 	sb->s_writers.frozen = SB_FREEZE_PAGEFAULT;

-- 
2.42.0


