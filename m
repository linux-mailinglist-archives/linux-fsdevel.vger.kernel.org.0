Return-Path: <linux-fsdevel+bounces-1036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E977D50FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24A21C20BBF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 13:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070D72AB3D;
	Tue, 24 Oct 2023 13:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+1R7stM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F542AB34
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 13:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CD5C433CB;
	Tue, 24 Oct 2023 13:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698152786;
	bh=FXSCh7bJ1nHc2Do09YWhMLAgS/mi2LTs07xOv53L2gs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E+1R7stMd+tLAzqSHC3ooOpBu2a0JtLDTKoyxGBBMAPdjAQcBv8Gibh1CHzMAw9Yk
	 FLAjTtPnE+Xa3Hg01z5+W3NndUi7i2rary/W0o1ItnqRJLVAV0mz29mpgekUavuz9V
	 S8y6NVh0gFNSzIMQVY9YAKen7ppK0cP9OI6poWoFkbDcue4Vm0umGWpn3yRzGRcrlA
	 Jgk+CvVRJM5ilUh2THXNzBjGY9VxIImPiHvH3c0HN77ljiCHNfvJ6wIaAg4RBthuLI
	 PUPZX4Z0LhPrbyQQ7/vGw8j9jppIL6mmWXWGHOBr6hZxmlqSqEQ1+ozYsFIITtfiwg
	 BykERz3pK0rGg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Oct 2023 15:01:15 +0200
Subject: [PATCH v2 09/10] porting: document block device freeze and thaw
 changes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-vfs-super-freeze-v2-9-599c19f4faac@kernel.org>
References: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
In-Reply-To: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1175; i=brauner@kernel.org;
 h=from:subject:message-id; bh=FXSCh7bJ1nHc2Do09YWhMLAgS/mi2LTs07xOv53L2gs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSaH3TcknLrcoV/cPX21d9jDTW2b0yIfHs+2enuujdhXloP
 5z7f0VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRZ68ZGe4f/sM7/bf65La+JyHFwd
 0JgW1fc1fPXND6uO1l4eF3k7Yw/DOP3b7Kfu4Fp/JWL8upPFtsxJN05WfOmsFqFXhnYuD3dj4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Link: https://lore.kernel.org/r/20230927-vfs-super-freeze-v1-7-ecc36d9ab4d9@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 Documentation/filesystems/porting.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index d69f59700a23..78fc854c9e41 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1052,3 +1052,15 @@ kill_anon_super(), or kill_block_super() helpers.
 
 Lock ordering has been changed so that s_umount ranks above open_mutex again.
 All places where s_umount was taken under open_mutex have been fixed up.
+
+---
+
+**recommended**
+
+Block device freezing and thawing have been moved to holder operations.
+
+Before this change, get_active_super() would only be able to find the
+superblock of the main block device, i.e., the one stored in sb->s_bdev. Block
+device freezing now works for any block device owned by a given superblock, not
+just the main block device. The get_active_super() helper is gone, so are
+bd_fsfreeze_sb, and bd_fsfreeze_mutex.

-- 
2.34.1


