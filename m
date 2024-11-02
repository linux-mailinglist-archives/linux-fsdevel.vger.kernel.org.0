Return-Path: <linux-fsdevel+bounces-33524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A289E9B9D01
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 06:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C621F22CE3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 05:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C9B189521;
	Sat,  2 Nov 2024 05:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="T1Jc9Cgg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E977914D2B9;
	Sat,  2 Nov 2024 05:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730524114; cv=none; b=YeLHQCmlE+F3sBQ4wRO75vHNvsQP+pAcdLw3Bgr7wnRqXaOxjPWr2hElmiB35W8U5wpQ36E4ghhe80m/VfdmHAzQq5OL3yGxjENuguwnH0iTmAsVVpThHUGQviTX0rgHrFqEuzCZhYNNmppOknfEYTSSgenUc5Drk684rTNZjmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730524114; c=relaxed/simple;
	bh=lWFUTpv/R92z2DpQmzUS6aoAOFMmwRusRgEc9ZssYFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAx5Jt9jX+ISmbQvgxqL4M4mGHTwzYkWC/t/IyOe3e9E8Am3u+Erc1pKVI339Nd/j3kCenjMHQBAnlUMILOvkWfnPz07SlLIVIUa5XeBWxqMobL6SD+hitBB8avvsbhY8e30FS7cDUEuRcADtpbf8UGSpREnHAnO/saAnnmAdqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=T1Jc9Cgg; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=y/4uGvmzz6QNy1xeeoayHDyD/ZJKK7+XnoEh0onLzBg=; b=T1Jc9CggkfbAqV2XeSxKThhqGv
	xBfwpSEYfCbOdmwEzxZi2mAKJ8+Rw9TOQNNeqa1p051lq6/Ic4ZNPgnkX/VaVZeATlrq9QbcVL+Ve
	iNHLqlz0P1D1BZEfIZaQcqxuGhv0alS/Q+YIH9PUZLThZKs4iy8YcG8czPAjIXMGhtX1Pe7AMOWUw
	qBN5hRxq5H/vILFbRi58mImRtcynAd/PwxOLhe/H5U7sIP1eZwsmDy3EtLcHBLZvfgRB4VvU3sIbq
	KYaw6Zja5HN32Fa+K7mrtwZONdHmfmpjRAEep4/av5+8RaANplGYM13cJJQXvxnEVIcyarjFq9MtL
	/Ythk5yg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t76NC-0000000AHo0-13OK;
	Sat, 02 Nov 2024 05:08:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v3 22/28] convert vfs_dedupe_file_range().
Date: Sat,  2 Nov 2024 05:08:20 +0000
Message-ID: <20241102050827.2451599-22-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
References: <20241102050219.GA2450028@ZenIV>
 <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

fdput() is followed by checking fatal_signal_pending() (and aborting
the loop in such case).  fdput() is transposable with that check.
Yes, it'll probably end up with slightly fatter code (call after the
check has returned false + call on the almost never taken out-of-line path
instead of one call before the check), but it's not worth bothering with
explicit extra scope there (or dragging the check into the loop condition,
for that matter).

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/remap_range.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index 017d0d1ea6c9..26afbbbfb10c 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -536,7 +536,7 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 	}
 
 	for (i = 0, info = same->info; i < count; i++, info++) {
-		struct fd dst_fd = fdget(info->dest_fd);
+		CLASS(fd, dst_fd)(info->dest_fd);
 
 		if (fd_empty(dst_fd)) {
 			info->status = -EBADF;
@@ -545,7 +545,7 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 
 		if (info->reserved) {
 			info->status = -EINVAL;
-			goto next_fdput;
+			goto next_loop;
 		}
 
 		deduped = vfs_dedupe_file_range_one(file, off, fd_file(dst_fd),
@@ -558,8 +558,6 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 		else
 			info->bytes_deduped = len;
 
-next_fdput:
-		fdput(dst_fd);
 next_loop:
 		if (fatal_signal_pending(current))
 			break;
-- 
2.39.5


