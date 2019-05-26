Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 181F62A8B7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2019 08:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfEZGL1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 May 2019 02:11:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39959 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbfEZGLZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 May 2019 02:11:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id 15so12692931wmg.5;
        Sat, 25 May 2019 23:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DGrN4rR5rYR4+AFEw/yxi4Y2DyPPMShooGDZpQ3nmN4=;
        b=rXjemcSygAWLxWoeAChSHdp5wXZOJhg09otgokpp8YocLyi4Qj/aKs7UVeIp5A86ET
         ZvJbU57lL/uqFpohmWXlv9g2IBR06+XoeONCKzLI6wCSA36/uq2u/hsg4jhUFSN0OigD
         sYxA5u1qstHS1D/9j5TC9iAHORGDnxCdfbzWu08e/JCt9F+6bpAruhF5NTEJrxAc2FIC
         nq9e5EIDdtsj0j+bVdJH2+DU718aYBg9CkACNAkmDlB6M1dm5PrjX/r9k/HR3VVKAaKj
         qIob7LAvdhUPaKWhBGxZIMLzLX0+F59yo1hjrnm0a+yCNJ4hoZEvY6fnJId/e3HIeLBn
         Pt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DGrN4rR5rYR4+AFEw/yxi4Y2DyPPMShooGDZpQ3nmN4=;
        b=D5IPb2/Ji78Y8h6eFF3LGyyb3gBu/HT2u0dhZlu9VafcYYDKZ1H4FgxaQ0ebK0aTyb
         J5a6Nm7klw273kaIWAKhMkI4viwBhm5OPMuxp+cwwWxOh+h1BNn13WKhgUSW9Ge+IwP9
         icXiNK2Y7x4RZy8Rcsvoc1f6zaTFV8iICvHby8PmNGiIEvcjc3gVDN11OprLUGRgdygG
         JkldFFw01o3u6DEja9hHSCv1pujjKNvRUpg3kMnuQmdhUAiwDwY5tcHQ2mR39ATeTdlL
         Envu8wVillIVd1B0T7hjXS06PaDZuHdVH4yeCY4po/NjJkP+MSq2uB4RTa1uxzm27GTR
         I7CA==
X-Gm-Message-State: APjAAAXODhFSa9cLkBiqS0PA4B5FCDri963igT7G5By/jAucn/lw4dgu
        M+yH3jFdkRChWez1aJ3z4Wc=
X-Google-Smtp-Source: APXvYqxL5/b/9xctfsqvUZOtVzu0KdbblnJ9WKr/Jni5zrHOSijuz9UupMuRNYntXRVoNGc0cSTr9g==
X-Received: by 2002:a1c:9dc7:: with SMTP id g190mr21200396wme.121.1558851083327;
        Sat, 25 May 2019 23:11:23 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id a124sm5302943wmh.3.2019.05.25.23.11.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 23:11:22 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-api@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v2 6/8] vfs: copy_file_range should update file timestamps
Date:   Sun, 26 May 2019 09:10:57 +0300
Message-Id: <20190526061100.21761-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190526061100.21761-1-amir73il@gmail.com>
References: <20190526061100.21761-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Timestamps are not updated right now, so programs looking for
timestamp updates for file modifications (like rsync) will not
detect that files have changed. We are also accessing the source
data when doing a copy (but not when cloning) so we need to update
atime on the source file as well.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/read_write.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index e16bcafc0da2..4b23a86aacd9 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1576,6 +1576,16 @@ int generic_copy_file_range_prep(struct file *file_in, struct file *file_out)
 
 	WARN_ON_ONCE(!inode_is_locked(file_inode(file_out)));
 
+	/* Update source timestamps, because we are accessing file data */
+	file_accessed(file_in);
+
+	/* Update destination timestamps, since we can alter file contents. */
+	if (!(file_out->f_mode & FMODE_NOCMTIME)) {
+		ret = file_update_time(file_out);
+		if (ret)
+			return ret;
+	}
+
 	/*
 	 * Clear the security bits if the process is not being run by root.
 	 * This keeps people from modifying setuid and setgid binaries.
-- 
2.17.1

