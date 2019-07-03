Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5EE5E476
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 14:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfGCMsu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jul 2019 08:48:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37116 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfGCMr3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jul 2019 08:47:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id v14so2673509wrr.4;
        Wed, 03 Jul 2019 05:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RI/DgxnmV4iAu3TqAUK19hxYZSHJoXYPEmLHYgwhdLA=;
        b=c1Ga63pN8WYFieikwxkbf/j423IvTHFuSlIWFWoTlXzmbMyVCj/V5HPbjJtMtPaSox
         JXzV1xpnA4AnTfx3cbV1jhdJxv3GoEAGIgjDjWMgcRxVYSixIAVMwS+/Ll2dGBE68C5z
         V5wmptPuovuxeHUQr67RVFYN3PKyJPa8Sji8IOppBcNPREOfIsyEMuO6h9oIy+PMPdVK
         k4mmxwCWxy5Goxf7xawR/Ofg54YsNVCAeqOtEHHWQFkpZF2Zwn0ow8AtFLOtVKY7oOWF
         mJPnZH0Zs0Qi/DkPEry6e72WYwXmCXFq4q41ABJ+p/QbIYaBefQnUWQ2nBtgoUwdwUGX
         1rWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RI/DgxnmV4iAu3TqAUK19hxYZSHJoXYPEmLHYgwhdLA=;
        b=I1ulqwEmnWcyf/rP2+cMpc67JDPm4hWwcmyAuQKZMlrsZY+D3GDKqY9W8lGgFWKWWI
         y4wf5LRsQWZsDjD8DoU40ZNtPca8XfC6oHcLBDqrAgCMprHfSoVxnDpy+LKBzeFkrqBX
         qEqowL7dJQWTOosUMNUk4vRxPRgXE/2L43poNn7DRTEswSzbWHeFAp0Qs2dtMMBMjXqL
         GkeeABYQ8z8LzusA3eugoC/rwuTPPHIvBAGnGqW0JByEy+cGAEHT5htHVA+rvb3y27Zz
         BG6dTwzo0qoKNAivdvED22dauZCUA0mniYxT+cQAnGIGbBJXxlLFPIVh6oOGAHzZiBJQ
         aTtA==
X-Gm-Message-State: APjAAAVqo9HsCayU28TELDzoktxvPKjcp6Yz1hib2sQj+AgtAWJZ+ker
        V+o40bIx5sVEprQLC7tRvRIanGcOXSM=
X-Google-Smtp-Source: APXvYqyDSUVMJmoAuLKYvuPltd15RRJwej7+QPAsNgyn4lJ1V+obPuOOc/VMQzvYJYqt7biAFvJz/A==
X-Received: by 2002:adf:f591:: with SMTP id f17mr30262141wro.119.1562158047270;
        Wed, 03 Jul 2019 05:47:27 -0700 (PDT)
Received: from heron.blarg.de (p200300DC6F443A000000000000000FD2.dip0.t-ipconnect.de. [2003:dc:6f44:3a00::fd2])
        by smtp.gmail.com with ESMTPSA id o24sm5480588wmh.2.2019.07.03.05.47.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 05:47:26 -0700 (PDT)
From:   Max Kellermann <max.kellermann@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        trond.myklebust@hammerspace.com, bfields@redhat.com,
        gregkh@linuxfoundation.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, hughd@google.com,
        anna.schumaker@netapp.com
Cc:     linux-kernel@vger.kernel.org,
        Max Kellermann <max.kellermann@gmail.com>
Subject: [PATCH 1/4] fs/posix_acl: apply umask if superblock disables ACL support
Date:   Wed,  3 Jul 2019 14:47:12 +0200
Message-Id: <20190703124715.4319-1-max.kellermann@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The function posix_acl_create() applies the umask only if the inode
has no ACL (= NULL) or if ACLs are not supported by the filesystem
driver (= -EOPNOTSUPP).

However, this happens only after after the IS_POSIXACL() check
succeeeded.  If the superblock doesn't enable ACL support, umask will
never be applied.  A filesystem which has no ACL support will of
course not enable SB_POSIXACL, rendering the umask-applying code path
unreachable.

This fixes a bug which causes the umask to be ignored with O_TMPFILE
on tmpfs:

 https://github.com/MusicPlayerDaemon/MPD/issues/558
 https://bugs.gentoo.org/show_bug.cgi?id=686142#c3
 https://bugzilla.kernel.org/show_bug.cgi?id=203625

Signed-off-by: Max Kellermann <max.kellermann@gmail.com>
---
 fs/posix_acl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 2fd0fde16fe1..815f7b36ef94 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -588,9 +588,14 @@ posix_acl_create(struct inode *dir, umode_t *mode,
 	*acl = NULL;
 	*default_acl = NULL;
 
-	if (S_ISLNK(*mode) || !IS_POSIXACL(dir))
+	if (S_ISLNK(*mode))
 		return 0;
 
+	if (!IS_POSIXACL(dir)) {
+		*mode &= ~current_umask();
+		return 0;
+	}
+
 	p = get_acl(dir, ACL_TYPE_DEFAULT);
 	if (!p || p == ERR_PTR(-EOPNOTSUPP)) {
 		*mode &= ~current_umask();
-- 
2.20.1

