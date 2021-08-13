Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0A13EBE1C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Aug 2021 00:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbhHMWCB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 18:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbhHMWCA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 18:02:00 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDB7C061756;
        Fri, 13 Aug 2021 15:01:33 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id bo18so17441573pjb.0;
        Fri, 13 Aug 2021 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TOBVJrjsgyyHnpcMAvT9Ogq8QQ7Hb9vvqmUruVxXN2o=;
        b=WpsQYA0E3J2TT9mQW6fdKOlZNQl/NE1m98+rQUoh9fdPBOCIxv8dVlFOyveBL/7gYK
         TDgEzV1GrWXVCANagZTxNWsqZ4qK6sKfkiVL6n2OpAUKQQ0lMx+gyfoq7Jhv3CrUdVlW
         FF0bKNNkDEJ8kSxKO6Xe9thMxclcINLm4INeoB5ANkYa8LqmFof2YZT5Ti8tNBo5d/Ig
         2G9GXjS/zVbcvB8KJqvU28T4lUfC/64t8yqT20Kh2d1nqqvDaId1hkh5FV7jsJFdpXBs
         fcyc6v1huWNqth+VHzKXsJlaCNx7aLgcLpbOU/xnUA/Xsk8i3EeuopWlVdVrJOT0XHqj
         /Znw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TOBVJrjsgyyHnpcMAvT9Ogq8QQ7Hb9vvqmUruVxXN2o=;
        b=ZlCnYU5ThZcWDXhRypxC1Vz+7pK/sZRH4pRgeJtgN2wptFMt+eFR3djOCl6HzlBdKJ
         v4yTF3fFthP1wf8qG9QdtbMSi2hyRW9lamBu3jgtUMAZFRwBK1SBUtCmLne4bBznXhCp
         AYzJT80w/iIK4ohrN2FHpA0GmHnAPT5FULaqSeJY6v6iv5FABWUhvJzqrBss3rJ5oRp2
         V5nK97hGbdsFZGu9DBwlkdL2byzmjXGzdoelN42i59EsROuvv7N1wVbqHmKyGGh6zoI6
         31IE6wAyWKv5niFdNrBmhmkuSz0XWMOsOWgncIrb1xcZf483HokMusghl39QMhO99D8j
         18uA==
X-Gm-Message-State: AOAM531PXQzEJdKwh6/KrANylDWT/6CruGRv0WgWaTh0NPMO9eHPzDjz
        L/IeuZk/3OsxXRuiOhi4gPA=
X-Google-Smtp-Source: ABdhPJz06GYCYcbTM9vb10baLeuZjhugn9W2fiof/+WqIneri+SIorNSFtGKGhEYsbS2WvXgkW+aJw==
X-Received: by 2002:a17:90a:4383:: with SMTP id r3mr4559762pjg.223.1628892092762;
        Fri, 13 Aug 2021 15:01:32 -0700 (PDT)
Received: from localhost.localdomain (122-61-176-117-fibre.sparkbb.co.nz. [122.61.176.117])
        by smtp.gmail.com with ESMTPSA id n32sm3804262pgl.69.2021.08.13.15.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 15:01:32 -0700 (PDT)
From:   Michael Kerrisk <mtk.manpages@gmail.com>
To:     ebiederm@xmission.com
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: [PATCHi, man-pages] mount_namespaces.7: More clearly explain "locked mounts"
Date:   Sat, 14 Aug 2021 00:01:20 +0200
Message-Id: <20210813220120.502058-1-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For a long time, this manual page has had a brief discussion of
"locked" mounts, without clearly saying what this concept is, or
why it exists. Expand the discussion with an explanation of what
locked mounts are, why mounts are locked, and some examples of the
effect of locking.

Thanks to Christian Brauner for a lot of help in understanding
these details.

Reported-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---

Hello Eric and others,

After some quite helpful info from Chrstian Brauner, I've expanded
the discussion of locked mounts (a concept I didn't really have a
good grasp on) in the mount_namespaces(7) manual page. I would be
grateful to receive review comments, acks, etc., on the patch below.
Could you take a look please?

Cheers,

Michael

 man7/mount_namespaces.7 | 73 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/man7/mount_namespaces.7 b/man7/mount_namespaces.7
index e3468bdb7..97427c9ea 100644
--- a/man7/mount_namespaces.7
+++ b/man7/mount_namespaces.7
@@ -107,6 +107,62 @@ operation brings across all of the mounts from the original
 mount namespace as a single unit,
 and recursive mounts that propagate between
 mount namespaces propagate as a single unit.)
+.IP
+In this context, "may not be separated" means that the mounts
+are locked so that they may not be individually unmounted.
+Consider the following example:
+.IP
+.RS
+.in +4n
+.EX
+$ \fBsudo mkdir /mnt/dir\fP
+$ \fBsudo sh \-c \(aqecho "aaaaaa" > /mnt/dir/a\(aq\fP
+$ \fBsudo mount \-\-bind -o ro /some/path /mnt/dir\fP
+$ \fBls /mnt/dir\fP   # Former contents of directory are invisible
+.EE
+.in
+.RE
+.IP
+The above steps, performed in a more privileged user namespace,
+have created a (read-only) bind mount that
+obscures the contents of the directory
+.IR /mnt/dir .
+For security reasons, it should not be possible to unmount
+that mount in a less privileged user namespace,
+since that would reveal the contents of the directory
+.IR /mnt/dir .
+.IP
+Suppose we now create a new mount namespace
+owned by a (new) subordinate user namespace.
+The new mount namespace will inherit copies of all of the mounts
+from the previous mount namespace.
+However, those mounts will be locked because the new mount namespace
+is owned by a less privileged user namespace.
+Consequently, an attempt to unmount the mount fails:
+.IP
+.RS
+.in +4n
+.EX
+$ \fBsudo unshare \-\-user \-\-map\-root\-user \-\-mount \e\fP
+               \fBstrace \-o /tmp/log \e\fP
+               \fBumount /mnt/dir\fP
+umount: /mnt/dir: not mounted.
+$ \fBgrep \(aq^umount\(aq /tmp/log\fP
+umount2("/mnt/dir", 0)     = \-1 EINVAL (Invalid argument)
+.EE
+.in
+.RE
+.IP
+The error message from
+.BR mount (8)
+is a little confusing, but the
+.BR strace (1)
+output reveals that the underlying
+.BR umount2 (2)
+system call failed with the error
+.BR EINVAL ,
+which is the error that the kernel returns to indicate that
+the mount is locked.
 .IP *
 The
 .BR mount (2)
@@ -128,6 +184,23 @@ settings become locked
 when propagated from a more privileged to
 a less privileged mount namespace,
 and may not be changed in the less privileged mount namespace.
+.IP
+This point can be illustrated by a continuation of the previous example.
+In that example, the bind mount was marked as read-only.
+For security reasons,
+it should not be possible to make the mount writable in
+a less privileged namespace, and indeed the kernel prevents this,
+as illustrated by the following:
+.IP
+.RS
+.in +4n
+.EX
+$ \fBsudo unshare \-\-user \-\-map\-root\-user \-\-mount \e\fP
+               \fBmount \-o remount,rw /mnt/dir\fP
+mount: /mnt/dir: permission denied.
+.EE
+.in
+.RE
 .IP *
 .\" (As of 3.18-rc1 (in Al Viro's 2014-08-30 vfs.git#for-next tree))
 A file or directory that is a mount point in one namespace that is not
-- 
2.31.1

