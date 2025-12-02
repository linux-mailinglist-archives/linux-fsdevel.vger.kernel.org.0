Return-Path: <linux-fsdevel+bounces-70474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C4DC9CA10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 19:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 672AC349793
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 18:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C812A2D238D;
	Tue,  2 Dec 2025 18:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c35cG2vz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183C51DB356;
	Tue,  2 Dec 2025 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764700053; cv=none; b=Od8Qwa9BXLpIEBI12Cuw8pf32ZOxPwhdiw5RTmtY0symG2Na5ccIKmjfJSFf7+A/6fKQmvVCfiuU+mQSVWGRdUZlne2Mw1jR+3xfOQE5bOBjkU/7L4xPUgFGZ+QSATfyWhgG/ZqazdPTg8CJe6mnb2VnKlrAnFbpKizVbh0Cnag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764700053; c=relaxed/simple;
	bh=+Yva9T5yxN2cy7lAFCldOI6UpDj6gWTmtwhXcjX87TU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L7zzSGUOSOvbUSdwbX+DKTOBGmtGYatNYLgvntztYma8Z/SfTGrohE2SfyZQeShlhTcj6Ib3ISDC/RtvZEpyuVLlEFLPEdhsEx7vZhUL14th8UhuwdUsG3N/AgTK59Wu1DyUa+yKjqFtYBxEOUoSBVhJHHZalSI/mGZdc+pl0g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c35cG2vz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8643C4CEF1;
	Tue,  2 Dec 2025 18:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764700052;
	bh=+Yva9T5yxN2cy7lAFCldOI6UpDj6gWTmtwhXcjX87TU=;
	h=From:To:Cc:Subject:Date:From;
	b=c35cG2vz8uT4d794z19UaMjA+PZ+9Dgzz3VmU3Bbf0uc5VUQdcdzKjL/Nu5+ylegJ
	 i82iG2B2N9MGX2yl6X/Xe39n/iP2JO/1uwR02oC1qpaQYPFYehbJkkHEOv2K9IvX6i
	 +SLqbzt40SJAOjkZ6WI2pRZi/fMUpmZU0j2x1Y/mj0qxe/q4Vfq/aplRvHWmS6Arhy
	 GtKegoQRs5lRuGeWYw8TPhqdwtggIAh1DDg7TADPxpNmpISVYumAMvcl8QPRNT+JWU
	 YhgontKr4Wj6Jg3M00lp0RCmc2eV8kGNmtLabCuZE0sf1F/ufkfgRLe37LBQvzxoQH
	 XM/xANjs2QGmA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-fsdevel@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH v1] fs: PM: Fix reverse check in filesystems_freeze_callback()
Date: Tue, 02 Dec 2025 19:27:29 +0100
Message-ID: <12788397.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The freeze_all_ptr check in filesystems_freeze_callback() introduced by
commit a3f8f8662771 ("power: always freeze efivarfs") is reverse which
quite confusingly causes all file systems to be frozen when
filesystem_freeze_enabled is false.

On my systems it causes the WARN_ON_ONCE() in __set_task_frozen() to
trigger, most likely due to an attempt to freeze a file system that is
not ready for that.

Add a logical negation to the check in question to reverse it as
appropriate.

Fixes: a3f8f8662771 ("power: always freeze efivarfs")
Cc: 6.18+ <stable@vger.kernel.org> # 6.18+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 fs/super.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/super.c
+++ b/fs/super.c
@@ -1188,7 +1188,7 @@ static void filesystems_freeze_callback(
 	if (!sb->s_op->freeze_fs && !sb->s_op->freeze_super)
 		return;
 
-	if (freeze_all_ptr && !(sb->s_type->fs_flags & FS_POWER_FREEZE))
+	if (!freeze_all_ptr && !(sb->s_type->fs_flags & FS_POWER_FREEZE))
 		return;
 
 	if (!get_active_super(sb))




