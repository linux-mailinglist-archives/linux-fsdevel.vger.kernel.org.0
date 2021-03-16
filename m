Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3731633D61D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 15:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237607AbhCPOtF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 10:49:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32016 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237496AbhCPOs3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 10:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615906109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=18bJ2oP6ut9ntIweB+G7KlMqarDABiP1n988fIKNPr4=;
        b=gqSoihg6/2Gh0LTi8X7uiC8HIRqqkDPHtY5C8JDfmJi1oZ9J+8TsVEcZz1sV/uFMPp188b
        VDKSIWOclQ2UhzwnWgHp4LRPXUFfvBlWDIT8jBzZThscwL0EcGMuEkjzr2iiGtRkkPILor
        TcjkoMUAxaD9VRzQgvK4Rqa/y5JZY9w=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-TSqn1oaiPn-3ASlwf1wVgw-1; Tue, 16 Mar 2021 10:48:27 -0400
X-MC-Unique: TSqn1oaiPn-3ASlwf1wVgw-1
Received: by mail-ej1-f71.google.com with SMTP id rl7so13659746ejb.16
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 07:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=18bJ2oP6ut9ntIweB+G7KlMqarDABiP1n988fIKNPr4=;
        b=BI/vhFCov04JRHLBSXe8uAC/EGgbrusShZScZ1kuaUmJHp588E4An7pNGBLxuiOYZv
         MCTBsZkC6f8wD9IJPuMGYWHSEf8mxTOCGGOgdgs2hHWiAHS4K60p0XAF1wgccn4sgOVf
         x1cWG7/7t3EbsLogk8IYUJUPD1FJt2mjAPtcwWtli9DGSPmpQ4Uqbn7U2iCyR5FNZCg8
         bG27VwmEJvp/9g98vnFSkhFqCSDTPNILmtErjtzt5C2BDI2jwnLn+EmO3jj4kTRRw0XJ
         2EJuxJgoG9R8xgEe8wxcfsxeKPjj/CYudYn4b9tTsHbfm2UkfzoMp/bsDSBFWndFpWGd
         KZXA==
X-Gm-Message-State: AOAM533bxnei1GrmElFkOduBk59t/1sB0A9TGff4xHCPFVxemJNpcMlD
        7TmxhCHu6LSlcJkCEPCdRcQzWETOHOzrKylK/do8HAIdqlW/CZ41CYFjTOO4nwojWRjB84h07zV
        8kY6oyVKqQGqUHgdW9bcUnVDxX0t1FJm+XU+Y1TfS4ijzhTqd5koN58EPBCj/t8M0MMpSBgYiFr
        jvSA==
X-Received: by 2002:a17:906:fcc7:: with SMTP id qx7mr30132332ejb.486.1615906105902;
        Tue, 16 Mar 2021 07:48:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRxyi2aGWQMGTMwIg2cBuc0d3dZ9KGQ0zkgK50cJaZtP8nB4RkXgvNv/OVQnLFh7+3jBPTIw==
X-Received: by 2002:a17:906:fcc7:: with SMTP id qx7mr30132303ejb.486.1615906105639;
        Tue, 16 Mar 2021 07:48:25 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id q16sm3342227edv.61.2021.03.16.07.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 07:48:25 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH v2] vfs: fix fsconfig(2) LSM mount option handling for btrfs
Date:   Tue, 16 Mar 2021 15:48:23 +0100
Message-Id: <20210316144823.2188946-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When SELinux security options are passed to btrfs via fsconfig(2) rather
than via mount(2), the operation aborts with an error. What happens is
roughly this sequence:

1. vfs_parse_fs_param() eats away the LSM options and parses them into
   fc->security.
2. legacy_get_tree() finds nothing in ctx->legacy_data, passes this
   nothing to btrfs.
[here btrfs calls another layer of vfs_kern_mount(), but let's ignore
 that for simplicity]
3. btrfs calls security_sb_set_mnt_opts() with empty options.
4. vfs_get_tree() then calls its own security_sb_set_mnt_opts() with the
   options stashed in fc->security.
5. SELinux doesn't like that different options were used for the same
   superblock and returns -EINVAL.

In the case of mount(2), the options are parsed by
legacy_parse_monolithic(), which skips the eating away of security
opts because of the FS_BINARY_MOUNTDATA flag, so they are passed to the
FS via ctx->legacy_data. The second call to security_sb_set_mnt_opts()
(from vfs_get_tree()) now passes empty opts, but the non-empty -> empty
sequence is allowed by SELinux for the FS_BINARY_MOUNTDATA case.

It is a total mess, but the only sane fix for now seems to be to skip
processing the security opts in vfs_parse_fs_param() if the fc has
legacy opts set AND the fs specfies the FS_BINARY_MOUNTDATA flag. This
combination currently matches only btrfs and coda. For btrfs this fixes
the fsconfig(2) behavior, and for coda it makes setting security opts
via fsconfig(2) fail the same way as it would with mount(2) (because
FS_BINARY_MOUNTDATA filesystems are expected to call the mount opts LSM
hooks themselves, but coda never cared enough to do that). I believe
that is an acceptable state until both filesystems (or at least btrfs)
are converted to the new mount API (at which point btrfs won't need to
pretend it takes binary mount data any more and also won't need to call
the LSM hooks itself, assuming it will pass the fc->security information
properly).

Note that we can't skip LSM opts handling in vfs_parse_fs_param() solely
based on FS_BINARY_MOUNTDATA because that would break NFS.

See here for the original report and reproducer:
https://lore.kernel.org/selinux/c02674c970fa292610402aa866c4068772d9ad4e.camel@btinternet.com/

Reported-by: Richard Haines <richard_c_haines@btinternet.com>
Tested-by: Richard Haines <richard_c_haines@btinternet.com>
Fixes: 3e1aeb00e6d1 ("vfs: Implement a filesystem superblock creation/configuration context")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

Trying to revive this patch... Sending v2 with style tweaks as suggested
by David Sterba.

v2:
- split the if condition over two lines (David Sterba)
- fix comment style in the comment being reindented (David Sterba)

 fs/fs_context.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 2834d1afa6e8..e6575102bbbd 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -106,12 +106,30 @@ int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
 	if (ret != -ENOPARAM)
 		return ret;
 
-	ret = security_fs_context_parse_param(fc, param);
-	if (ret != -ENOPARAM)
-		/* Param belongs to the LSM or is disallowed by the LSM; so
-		 * don't pass to the FS.
-		 */
-		return ret;
+	/*
+	 * In the legacy+binary mode, skip the security_fs_context_parse_param()
+	 * call and let the legacy handler process also the security options.
+	 * It will format them into the monolithic string, where the FS can
+	 * process them (with FS_BINARY_MOUNTDATA it is expected to do it).
+	 *
+	 * Currently, this matches only btrfs and coda. Coda is broken with
+	 * fsconfig(2) anyway, because it does actually take binary data. Btrfs
+	 * only *pretends* to take binary data to work around the SELinux's
+	 * no-remount-with-different-options check, so this allows it to work
+	 * with fsconfig(2) properly.
+	 *
+	 * Once btrfs is ported to the new mount API, this hack can be reverted.
+	 */
+	if (fc->ops != &legacy_fs_context_ops ||
+	    !(fc->fs_type->fs_flags & FS_BINARY_MOUNTDATA)) {
+		ret = security_fs_context_parse_param(fc, param);
+		if (ret != -ENOPARAM)
+			/*
+			 * Param belongs to the LSM or is disallowed by the LSM;
+			 * so don't pass to the FS.
+			 */
+			return ret;
+	}
 
 	if (fc->ops->parse_param) {
 		ret = fc->ops->parse_param(fc, param);
-- 
2.30.2

