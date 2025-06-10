Return-Path: <linux-fsdevel+bounces-51198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E0FAD443E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 22:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5718417815A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 20:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D7E267B74;
	Tue, 10 Jun 2025 20:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2Deui9l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1215F4685;
	Tue, 10 Jun 2025 20:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749589064; cv=none; b=uuMGjVOvSo5d3bOPNDsnvA4feXNhDZUdX2+uTWgeUgOTKZdigAHvqU+1aIFbBMZINgp2wiErqmCTgUgKHyGcmPx1loRSGwAVLq/+2kuWwRBIHJz6xIzwBozwMbbRlQOJPI8CUOO32sq1spbyK230mHqc6BccMQUw/KJpptaDKnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749589064; c=relaxed/simple;
	bh=YrX5W4fyXADtJqbBfoorMT+C62SB7fYbc9N1wmMXa6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+vxkFL04lEdtczHsLU0aL+L8xBXkBzecMkKhPPVFRCCgguCHUL1NPWLZ3pv0mMTueRL6AuyDdB/73YecHQWwfL2Y2F2wPfrpJRaBmcklqNWGYFzQFDoexBLVblWZqbwLDFOTtuNlTILAwBnrD4QQnLSC/h2Lche6f1+KT95fLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2Deui9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7164C4CEF2;
	Tue, 10 Jun 2025 20:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749589063;
	bh=YrX5W4fyXADtJqbBfoorMT+C62SB7fYbc9N1wmMXa6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J2Deui9lMwu4AZIZXYIvQFnQqcyWvAKu28vRbAZldCqmv9I/EXaeUWLkyi5QSo2pc
	 MDANIrJLuelwnXQugmPsS3Uvpfarppk7QMBexQ6irSLJ6JBJgya0JDKf8BPa5CLUmp
	 bKGKx+Rbl9WLEILusRMfhQniIOevsDKKjZ2u6X/ArxJn4/MUBsGdbrUALDJtH1lFQR
	 nJaejOdjXpYYl6AiPsOIRYhdlt3p1dnoesZEMv+iNdytqoXOi6sPLlsmv2KYhWeIZZ
	 S/wzxfVGvDE0wKaEC21h0FxwXPWLZruOLiJUtQkJw2PLAmkAKZ8+0mD4zh7xVZCdt/
	 6kUXSv0PCI8RA==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/6] fs: introduce RWF_DIRECT to allow using O_DIRECT on a per-IO basis
Date: Tue, 10 Jun 2025 16:57:35 -0400
Message-ID: <20250610205737.63343-5-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250610205737.63343-1-snitzer@kernel.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoids the need to open code do_iter_readv_writev() purely to request
that a sync iocb make use of IOCB_DIRECT.

Care was taken to preserve the long-established value for IOCB_DIRECT
(1 << 17) when introducing RWF_DIRECT.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 include/linux/fs.h      | 2 +-
 include/uapi/linux/fs.h | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index ed025959d1bd..9bf5543926f8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -324,7 +324,7 @@ struct readahead_control;
 
 /* non-RWF related bits - start at 16 */
 #define IOCB_EVENTFD		(1 << 16)
-#define IOCB_DIRECT		(1 << 17)
+#define IOCB_DIRECT		(__force int) RWF_DIRECT
 #define IOCB_WRITE		(1 << 18)
 /* iocb->ki_waitq is valid */
 #define IOCB_WAITQ		(1 << 19)
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 56a4f93a08f4..e0d00a7c336a 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -335,10 +335,13 @@ typedef int __bitwise __kernel_rwf_t;
 /* buffered IO that drops the cache after reading or writing data */
 #define RWF_DONTCACHE	((__force __kernel_rwf_t)0x00000080)
 
+/* per-IO O_DIRECT, using (1 << 17) or 0x00020000 for compat with IOCB_DIRECT */
+#define RWF_DIRECT	((__force __kernel_rwf_t)(1 << 17))
+
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
 			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC |\
-			 RWF_DONTCACHE)
+			 RWF_DONTCACHE | RWF_DIRECT)
 
 #define PROCFS_IOCTL_MAGIC 'f'
 
-- 
2.44.0


