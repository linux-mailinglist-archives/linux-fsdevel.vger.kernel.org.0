Return-Path: <linux-fsdevel+bounces-44796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5373CA6CC4C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 21:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC2C3ACB6E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 20:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D74F2356C0;
	Sat, 22 Mar 2025 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ym5YgecI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877128BF8;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742675715; cv=none; b=LjJAD12r2YZlm9S8UXtpKnb0RvwMpKwyeJHV05g5VfpUj7wagCrEDM8sSqO/SVpVsNfo5DlfFVZBYG+a48/cbllRMoVTOdMLsoQaQkaKpg5mDrjhOEqHtdCy5cZwi2LmFwuEFlrY1dAGilOMFoFDgBHHefrNTMrtnGRuRv2Q/pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742675715; c=relaxed/simple;
	bh=gINZ0Aw8Hylr726Wuv3Tb5zHE90wq70NebX4Kb1KIYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R/H1z7ohJVoMNsGxeTqoRnq3DbcywSI2zE6MgrIKX76ZSnN2zmmAQJCnODMhSNPR0OB1ix+hwN/nJQ+VPwiJzovutfu9SlQCcwVNngmAUwm3C30OQWXRd1AyAuYG3VSp81nePDQzaQN8mphXRrIDnIMcWsUMAj+mKEacE4Mcns8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ym5YgecI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED851C4CEE9;
	Sat, 22 Mar 2025 20:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742675715;
	bh=gINZ0Aw8Hylr726Wuv3Tb5zHE90wq70NebX4Kb1KIYg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ym5YgecIPYw5eJfx+kMkQLnilWlWcqki58e2BiXmYlEiKRuh5FYyoqddx6+kcQTac
	 OWxuTSsmGQqcR09FuuHnwDww4UJbOFl+K/GJbOTi6BQar/Itk5AaPsSVgeExEYGJML
	 yCC4BjGXgLijc1Fi91VfMQhbF6ndgZiGcBouG2r5DwpLcH+b1vkYs4/5dwiMc/5izA
	 pWUGB3uWI8yHodlIHxBlAWLfSnO3Nb0D6OtNwKbk+ZAJ1Tg++L99PGSqT01MRelcS9
	 hcTU9zo5+3saHvlsCIxRdmvn2XwCgXam6IXqCaIfi6Ux6oEAHnd+1T4Ct4t08cA3q0
	 y7lHKG7UIrCrg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EC7C36008;
	Sat, 22 Mar 2025 20:35:14 +0000 (UTC)
From: Julian Stecklina via B4 Relay <devnull+julian.stecklina.cyberus-technology.de@kernel.org>
Date: Sat, 22 Mar 2025 21:34:13 +0100
Subject: [PATCH v2 1/9] initrd: remove ASCII spinner
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-initrd-erofs-v2-1-d66ee4a2c756@cyberus-technology.de>
References: <20250322-initrd-erofs-v2-0-d66ee4a2c756@cyberus-technology.de>
In-Reply-To: <20250322-initrd-erofs-v2-0-d66ee4a2c756@cyberus-technology.de>
To: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Gao Xiang <xiang@kernel.org>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, 
 Julian Stecklina <julian.stecklina@cyberus-technology.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742675713; l=1419;
 i=julian.stecklina@cyberus-technology.de; s=20250320;
 h=from:subject:message-id;
 bh=xaOtsZSXLvGxcDVIZd0k1LuXf7yoO5wFbuBG8A93PMw=;
 b=Q/f0Rz5QFOyX0GFtzyWhjf7NZaw5DwLqmAK+UT+Lih/KQRXWu2ZWjHPR87PxJ073JhZ6qoeo1
 dSKgyuoEHDHC8bSj5x2zOKyRbhADY7Q0NrHhkpa8NkAZjxmafF66erV
X-Developer-Key: i=julian.stecklina@cyberus-technology.de; a=ed25519;
 pk=m051/8gQfs5AmkACfykwRcD6CUr2T7DQ9OA5eBgyy7c=
X-Endpoint-Received: by B4 Relay for
 julian.stecklina@cyberus-technology.de/20250320 with auth_id=363
X-Original-From: Julian Stecklina <julian.stecklina@cyberus-technology.de>
Reply-To: julian.stecklina@cyberus-technology.de

From: Julian Stecklina <julian.stecklina@cyberus-technology.de>

Writing the ASCII spinner probably costs more cycles than copying the
block of data on some output devices if you output to serial and in
all other cases it rotates at lightspeed in 2025.

Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
---
 init/do_mounts_rd.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index ac021ae6e6fa78c7b7828a78ab2fa3af3611bef3..473f4f9417e157118b9a6e582607435484d53d63 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -189,11 +189,7 @@ int __init rd_load_image(char *from)
 	unsigned long rd_blocks, devblocks;
 	int nblocks, i;
 	char *buf = NULL;
-	unsigned short rotate = 0;
 	decompress_fn decompressor = NULL;
-#if !defined(CONFIG_S390)
-	char rotator[4] = { '|' , '/' , '-' , '\\' };
-#endif
 
 	out_file = filp_open("/dev/ram", O_RDWR, 0);
 	if (IS_ERR(out_file))
@@ -249,18 +245,11 @@ int __init rd_load_image(char *from)
 	for (i = 0; i < nblocks; i++) {
 		if (i && (i % devblocks == 0)) {
 			pr_cont("done disk #1.\n");
-			rotate = 0;
 			fput(in_file);
 			break;
 		}
 		kernel_read(in_file, buf, BLOCK_SIZE, &in_pos);
 		kernel_write(out_file, buf, BLOCK_SIZE, &out_pos);
-#if !defined(CONFIG_S390)
-		if (!(i % 16)) {
-			pr_cont("%c\b", rotator[rotate & 0x3]);
-			rotate++;
-		}
-#endif
 	}
 	pr_cont("done.\n");
 

-- 
2.47.0



