Return-Path: <linux-fsdevel+bounces-44640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96641A6AED9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 20:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17BEE3AFA1E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 19:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E13229B32;
	Thu, 20 Mar 2025 19:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJLYJm0h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E2E339A1;
	Thu, 20 Mar 2025 19:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499984; cv=none; b=unrCsswwSYS5GCUBARWR9bx+RKz2Vt6eWCTtK/s3asztsOMO41QjLJIOC9R0WfKLmAf8mt9rn3BpWY/bvgLqeJMBkIXvoB2LHqJzP65qn3CSlXkf6iTPGbFnfu6lAeOC0F7qvkb11Nudc9nwG+cbBp3dYtWd0u4T0xDox15X2k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499984; c=relaxed/simple;
	bh=DEBRvZYrH0JfYADSrP884+yCkESKunslfy4DNnZqOt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FjOBHSzIxw92o5qpuEOSx/toW5l+TLyCj2sB9UeIEBebwCScdfpohREqbDnT5xpixfwNl7i9K7+grsWDR9It1sPPkpXSEcz7GEpGpm8SRt3wQzD1d3Rk7BGCYFoWDmipy+yXGBtUYY222ik6XhSVXg16tImDx6I8mkw8gpku23c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJLYJm0h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAE59C4CEE8;
	Thu, 20 Mar 2025 19:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742499983;
	bh=DEBRvZYrH0JfYADSrP884+yCkESKunslfy4DNnZqOt8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=GJLYJm0h6Z08SDPupchhLRkbmHepqmLEUUP+2Kqbsdf0DmPBNzrLrBJCea/d2m1qb
	 nT3qXG5d3auyLe2p93QMGxvv/IJWw8oKvFAdcwiJXjKoaNbI+yhzvzD1N55wWuyDqp
	 633+QQYepZe4rwUByJYYf7HkCR3eL/Wu8c1UV+t7QEUnnc1JSRLalTO6g2Orc/+sK6
	 AikZNK+YHRxy4XJHsCCx2e8trI2xg9iCL1ihLdq92X6jkIschNG1X1BEh2Nh7b5SNb
	 AN/poTWqKJjaa7ov4U1UoVO+G2fAS8e7ppKvDElc/gcvHoErYL5+OpqNCSGSqpq2hG
	 NZGDZelhw/6NA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FB2C28B30;
	Thu, 20 Mar 2025 19:46:23 +0000 (UTC)
From: Julian Stecklina via B4 Relay <devnull+julian.stecklina.cyberus-technology.de@kernel.org>
Date: Thu, 20 Mar 2025 20:46:14 +0100
Subject: [PATCH RFC] initrd: resize /dev/ram as needed
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-initrd-autoresize-v1-1-a9a5930205f8@cyberus-technology.de>
X-B4-Tracking: v=1; b=H4sIAIVw3GcC/x3MsQ5AMBCA4VeRmzWpSkmsEg9gFQN15ZaSa4lov
 LvG+A3/H8EjE3posgiMF3naXUKRZ2C2ya0oaEkGJZWWpZKCHAVexHSGndHTg2Iu0Bpja11WFaT
 uYLR0/88B+q6F8X0/7g1A+2gAAAA=
X-Change-ID: 20250320-initrd-autoresize-b1efccf75366
To: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Julian Stecklina <julian.stecklina@cyberus-technology.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742499982; l=2280;
 i=julian.stecklina@cyberus-technology.de; s=20250320;
 h=from:subject:message-id;
 bh=cCiCLxLx2A0Zi6Phf6RkFbbe0h/GF0wXaGlOEKWI1pc=;
 b=A5zvzV3RRP1qqWNVLxRfbNCd+jmPdkg+qMjcYwPg+vFGUuxp2TZmghC5IsNUpN0u2CttjgQWo
 jXXURgvuFv5ANNIQracW2wlNBxkunZKTVfndUD1+NdgNfAbQLfp1Ei/
X-Developer-Key: i=julian.stecklina@cyberus-technology.de; a=ed25519;
 pk=m051/8gQfs5AmkACfykwRcD6CUr2T7DQ9OA5eBgyy7c=
X-Endpoint-Received: by B4 Relay for
 julian.stecklina@cyberus-technology.de/20250320 with auth_id=363
X-Original-From: Julian Stecklina <julian.stecklina@cyberus-technology.de>
Reply-To: julian.stecklina@cyberus-technology.de

From: Julian Stecklina <julian.stecklina@cyberus-technology.de>

When the initrd doesn't fit into the RAM disk, we currently just die.
This is unfortunate, because users have to manually configure the RAM
disk size for no good reason. It also means that the kernel command
line needs to be changed for different initrds, which is sometimes
cumbersome.

Attempt resizing /dev/ram to fit the RAM disk size instead. This makes
initrd images work a bit more like initramfs images in that they just
work.

Of course, this only works, because we know that /dev/ram is a RAM
disk and we can resize it freely. I'm not sure whether I've used the
blockdev APIs here in a sane way. If not, please advise!

Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
---
 init/do_mounts_rd.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index ac021ae6e6fa78c7b7828a78ab2fa3af3611bef3..5ae3639765199294a07a9b9025b7b43265370896 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -183,6 +183,24 @@ static unsigned long nr_blocks(struct file *file)
 	return i_size_read(inode) >> 10;
 }
 
+static int resize_ramdisk(const char *devname, u64 new_size_blocks)
+{
+	struct block_device *bdev;
+	struct file *bdev_file;
+
+	bdev_file = bdev_file_open_by_path(devname, BLK_OPEN_READ, NULL, NULL);
+	if (IS_ERR(bdev_file))
+		goto err;
+
+	bdev = file_bdev(bdev_file);
+	set_capacity(bdev->bd_disk, (new_size_blocks * BLOCK_SIZE) / SECTOR_SIZE);
+
+	fput(bdev_file);
+	return 0;
+err:
+	return -1;
+}
+
 int __init rd_load_image(char *from)
 {
 	int res = 0;
@@ -219,9 +237,10 @@ int __init rd_load_image(char *from)
 	 * the number of kibibytes of data to load into a ramdisk.
 	 */
 	rd_blocks = nr_blocks(out_file);
-	if (nblocks > rd_blocks) {
-		printk("RAMDISK: image too big! (%dKiB/%ldKiB)\n",
+	if (nblocks > rd_blocks && resize_ramdisk("/dev/ram", nblocks)) {
+		printk("RAMDISK: image too big and couldn't resize! (%dKiB/%ldKiB)\n",
 		       nblocks, rd_blocks);
+
 		goto done;
 	}
 

---
base-commit: 5fc31936081919a8572a3d644f3fbb258038f337
change-id: 20250320-initrd-autoresize-b1efccf75366

Best regards,
-- 
Julian Stecklina <julian.stecklina@cyberus-technology.de>



