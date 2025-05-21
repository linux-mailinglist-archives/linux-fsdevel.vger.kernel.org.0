Return-Path: <linux-fsdevel+bounces-49561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53ADABEC14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 08:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587D14A6C8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 06:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8024C233739;
	Wed, 21 May 2025 06:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="aO46L6vy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F23922B8C3;
	Wed, 21 May 2025 06:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747809910; cv=none; b=QuOm7QPB3YTwPVttbXRYjfSvtJ58Nu/ctI8vWAdPZDaBXWKjeKGslfoWF+C1UgWIAnZtWyEO/GLvsUHamBsO++3vGl9j+5loEOLiR6JIoWCW1dG/YcqCTZtxzSy3od7SGxhrt12GJ+YQcAH/3iNZCvAuJRnTgEAAn27knSox8uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747809910; c=relaxed/simple;
	bh=GHcnvXdMpAPuoIAioS/LOiLIKctVetFq3Kvs+ASYCC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IR6nKO0isgLW6dnPQytYwuGMz7h2+1hJQBIHdiZzbeisJuietWgJbd1bozVRJOsoFFvzpaqzlyjK4Gg1zRSCt9/uDIjbOnbeCMDUS+zCXhv5mIUD3aBDClUmUZcq91jeYgjVBdqU7r/QdmQ+4uqn7luZ0S+GdPRdgiX4WkNq/Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=aO46L6vy; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=gO9ux4v6hOKrbiuo9LJ6PvUt/EemhxLVVjtbv/Lzolk=; b=aO46L6vyxpVeQSzGfWeCh/j8zS
	HfWW4NYGZbFqS7eg7wtq923iPibVishJMvTIXlNN5jnhDHgCd4eNZhgMZIToIltSxGXz0LdAYa6np
	LK4PcD8k+CMvbv6+pVW8wHBPnjcmk1VbnRrd034CP7G3x2308yjYrPuef3WpbwTZRciPOZRlQ/Zo9
	24F7WAP1BNG77gVhZcwRNQOsn6EWcPPZ/Kuu//899Cfe93qc10DjbH/1ZG9HznZ5FyvkrwtC+q2IH
	5cMUWNkBBiohfSKY4IcprgpD5wNB/fJwfeTnxS6w9ei3fJEZJVQBwqhHqxq54wcuA/dI6bElTvk0l
	buTlZWKQ==;
Received: from [191.204.192.64] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uHdCK-00B4IH-Lk; Wed, 21 May 2025 08:45:04 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 21 May 2025 03:42:12 -0300
Subject: [PATCH] ovl: Allow mount options to be parsed on remount
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250521-ovl_ro-v1-1-2350b1493d94@igalia.com>
X-B4-Tracking: v=1; b=H4sIAMN1LWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDUyND3fyynPiifN0kY4tEU/MUI0sLkxQloOKCotS0zAqwQdGxtbUAU3i
 hAlgAAAA=
X-Change-ID: 20250521-ovl_ro-b38a57d2984d
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-dev@igalia.com, linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

Allow mount options to be parsed on remount when using the new mount(8)
API. This allows to give a precise error code to userspace when the
remount is using wrong arguments instead of a generic -EINVAL error.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Hi folks,

I was playing with xfstest with overlayfs and I got those fails:

$ sudo TEST_DIR=/tmp/dir1 TEST_DEV=/dev/vdb SCRATCH_DEV=/dev/vdc SCRATCH_MNT=/tmp/dir2 ./check -overlay
...
Failures: generic/294 generic/306 generic/452 generic/599 generic/623 overlay/035
Failed 6 of 859 tests

5 of those 6 fails were related to the same issue, where fsconfig
syscall returns EINVAL instead of EROFS:

-mount: cannot remount device read-write, is write-protected
+mount: /tmp/dir2/ovl-mnt: fsconfig() failed: overlay: No changes allowed in reconfigure

I tracked down the origin of this issue being commit ceecc2d87f00 ("ovl:
reserve ability to reconfigure mount options with new mount api"), where
ovl_parse_param() was modified to reject any reconfiguration when using
the new mount API, returning -EINVAL. This was done to avoid non-sense
parameters being accepted by the new API, as exemplified in the commit
message: 

	mount -t overlay overlay -o lowerdir=/mnt/a:/mnt/b,upperdir=/mnt/upper,workdir=/mnt/work /mnt/merged
    
    and then issue a remount via:
    
            # force mount(8) to use mount(2)
            export LIBMOUNT_FORCE_MOUNT2=always
            mount -t overlay overlay -o remount,WOOTWOOT,lowerdir=/DOESNT-EXIST /mnt/merged

    with completely nonsensical mount options whatsoever it will succeed
    nonetheless. 

However, after manually reverting such commit, I found out that
currently those nonsensical mount options are being reject by the
kernel:

$ mount -t overlay overlay -o remount,WOOTWOOT,lowerdir=/DOESNT-EXIST /mnt/merged
mount: /mnt/merged: fsconfig() failed: overlay: Unknown parameter 'WOOTWOOT'.

$ mount -t overlay overlay -o remount,lowerdir=/DOESNT-EXIST /mnt/merged
mount: /mnt/merged: special device overlay does not exist.
       dmesg(1) may have more information after failed mount system call

And now 5 tests are passing because the code can now returns EROFS:
Failures: generic/623
Failed 1 of 1 tests

So this patch basically allows for the parameters to be parsed and to
return an appropriated error message instead of a generic EINVAL one.

Please let me know if this looks like going in the right direction.

Thanks!
---
 fs/overlayfs/params.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index f42488c019572479d8fdcfc1efd62b21d2995875..f6b7acc0fee6174c48fcc8b87481fbcb60e6d421 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -600,15 +600,6 @@ static int ovl_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		 */
 		if (fc->oldapi)
 			return 0;
-
-		/*
-		 * Give us the freedom to allow changing mount options
-		 * with the new mount api in the future. So instead of
-		 * silently ignoring everything we report a proper
-		 * error. This is only visible for users of the new
-		 * mount api.
-		 */
-		return invalfc(fc, "No changes allowed in reconfigure");
 	}
 
 	opt = fs_parse(fc, ovl_parameter_spec, param, &result);

---
base-commit: b87e2318cdaa14024b62ab428b3471d81eafaf1a
change-id: 20250521-ovl_ro-b38a57d2984d

Best regards,
-- 
André Almeida <andrealmeid@igalia.com>


