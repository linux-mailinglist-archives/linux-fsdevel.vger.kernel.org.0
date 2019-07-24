Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 206FF734F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2019 19:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfGXRQ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jul 2019 13:16:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52827 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbfGXRQ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:16:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so42516427wms.2;
        Wed, 24 Jul 2019 10:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tFaTqUdBSzB8R4SmwVYkKYMxu10gvhixEpWzdUiL5RA=;
        b=GbQtZPpmr7Z4yMvQnxNd+wONzoC6q1HW4srQROtZieW5QAjxXNh3WaW/vT12jLnJms
         pjvr+VU843f5VOziLR68Xn7wa5uWpTDXQyVGS5ABjnn3Agws2YL8hwdLTEAQifgL/2Op
         vW4lbVUlZffBDOGkEpHnayK8hYkRHjnNKepV3vFe6LmZowb2oRyTVjRNASemRvvKJ1Hi
         PJ2TZP9sEoJZj86R7lfwRUCE2tZWHP66nKN+vIjrxCT83sNz5bUEsh5jN6kJ0+lPifq1
         qQemrNo6Kul/DTRChxyHsgMjzsuEt6WCHUauPXiO4zCYsPOy1KyhWcNQ1/WpTHEYUT0y
         n5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tFaTqUdBSzB8R4SmwVYkKYMxu10gvhixEpWzdUiL5RA=;
        b=jFoGaQC+wI4dRVIgEbu7nWXV/ZwGCOcMs+NUkWAV6qrEPZWabA/33s9cqwN7gZPAIG
         0emxO/S4vulEn5L/Awoo0LiICWmKNbIXCzwGSJJdKbVxcfeC+537+OM4ULomyXpFLHB/
         hjOWU4eVtCGTGsH7YN2Hrhd1a9HX2mqTiXT5AncOIj1f28Belocehs1dR2N77s39SBip
         sQpXHR9+aKa1iqZqx39rAkJbmpRlN38K5lnjcx759NEgY49hFgusjcMJoIHc0sfw3/tN
         OKmCsu8EYQHbM8YAJ7qLyALd4Vkx6MZa4+EDVWwp+ITiCU3zZT8fGBW+a0UJxMUHwFQq
         jrLA==
X-Gm-Message-State: APjAAAWASJcTF3e9h7anTLeyneGd8IBhkF7w3qmKlAcdBaCvz9mZX1kH
        aXXIGi4CKLXtCUwMwYezFqhLakuD5Jo=
X-Google-Smtp-Source: APXvYqwNGYGdsXoSsoWVMsqpiFqsPByMx5twgEVxz1Qstui53GCAqPW2amhUPifjO4sV+cstIDkyEg==
X-Received: by 2002:a1c:9dc5:: with SMTP id g188mr77103884wme.93.1563988614716;
        Wed, 24 Jul 2019 10:16:54 -0700 (PDT)
Received: from localhost.localdomain ([109.126.147.168])
        by smtp.gmail.com with ESMTPSA id e7sm43753256wmd.0.2019.07.24.10.16.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 10:16:54 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 1/1] locks: Fix procfs output for file leases
Date:   Wed, 24 Jul 2019 20:16:31 +0300
Message-Id: <68a58eb885e32c1d7be0b4a531709ba2f33a758e.1563988369.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

Since commit 778fc546f749c588aa2f ("locks: fix tracking of inprogress
lease breaks"), leases break don't change @fl_type but modifies
@fl_flags. However, procfs's part haven't been updated.

Previously, for a breaking lease the target type was printed (see
target_leasetype()), as returns fcntl(F_GETLEASE). But now it's always
"READ", as F_UNLCK no longer means "breaking". Unlike the previous
one, this behaviour don't provide a complete description of the lease.

There are /proc/pid/fdinfo/ outputs for a lease (the same for READ and
WRITE) breaked by O_WRONLY.
-- before:
lock:   1: LEASE  BREAKING  READ  2558 08:03:815793 0 EOF
-- after:
lock:   1: LEASE  BREAKING  UNLCK  2558 08:03:815793 0 EOF

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/locks.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 686eae21daf6..24d1db632f6c 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2784,10 +2784,10 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 			       ? (fl->fl_type & LOCK_WRITE) ? "RW   " : "READ "
 			       : (fl->fl_type & LOCK_WRITE) ? "WRITE" : "NONE ");
 	} else {
-		seq_printf(f, "%s ",
-			       (lease_breaking(fl))
-			       ? (fl->fl_type == F_UNLCK) ? "UNLCK" : "READ "
-			       : (fl->fl_type == F_WRLCK) ? "WRITE" : "READ ");
+		int type = IS_LEASE(fl) ? target_leasetype(fl) : fl->fl_type;
+
+		seq_printf(f, "%s ", (type == F_WRLCK) ? "WRITE" :
+				     (type == F_RDLCK) ? "READ" : "UNLCK");
 	}
 	if (inode) {
 		/* userspace relies on this representation of dev_t */
-- 
2.22.0

