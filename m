Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8716A128F5F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Dec 2019 19:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfLVSpi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Dec 2019 13:45:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44249 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfLVSpi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Dec 2019 13:45:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id q10so14341499wrm.11;
        Sun, 22 Dec 2019 10:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hMUvTejarQb83y3JWrmzDGdkHFq0cI3MO3u2f5COMPs=;
        b=qZ4+wZP1KWPxmPTInnjiQzXCf2ToHIRtlsma9sUBdV83M2TZmBmOFKRp6jS2C6iUvG
         imkEBOH5YXQVM8rcq4mQijOERJQQ8oHUfeGlKO9KvLe8QossMTCZxDyyHvfri2PKlJqY
         tHnbo3+uWKHv6jCpj/MyHV6VK2OgCtVU4VV/nEn3uE7NIUZFy8mUc9uCjGclsEJRvkJT
         d0RMA+JzoIocM9vfekKmrv/bYgkdqox1rkjvtBMHq90YMpqJT9gGzE7Ui3nobWQz3MJg
         /u3pbKTlhGkESZywK+GoH0i1QhQPYhAYtMw5IWiycACtMDDjd9RzvBQv356H1agm6N0w
         HnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hMUvTejarQb83y3JWrmzDGdkHFq0cI3MO3u2f5COMPs=;
        b=Q+limEoXNidGJNafYJgGfxEZOWZGA2B/i6J78MVrdWgxDExx15xUb3zGudDaSBM/KZ
         MAmZF0Dndm2RFFwyT49JiAlyxlYYb9IkFn8uCJw9qTP1mv2T/fTfEpgtT2dcN20xtKMd
         AANrJpGPXlAjc3FXE+40Ymq/34YYR/mkNCkKoL11Lx+vbsCq2o2ndGi2nZw4uBjQ7Yyl
         sNQEPSq6vUESXntA5jiXIiRpZAotEgACGRlnBoNzGkRrNTXjoKO/NhGRYvhZAYQ3+T0I
         xtMripGRKPE+KzV9CAVn6GZlI7iNDKkGVuHFUr+bBhkN4xvgR5caXssb6yhZYRKDjDHY
         1AiA==
X-Gm-Message-State: APjAAAVDRx31aDP9eIDInLDwk/WAv5H6nejw1QrdKe0puvEgMqemnscE
        TxP5sAzJtAsI0x+4tIew6h066Fcr
X-Google-Smtp-Source: APXvYqzd/3Ziq8/cGEjkf7pIF/NeiqyJi1JMCOXVTRjormXnuBfxpSh+FhIZlnQxZHx69MtLtxDphg==
X-Received: by 2002:a5d:4c85:: with SMTP id z5mr25574325wrs.42.1577040335758;
        Sun, 22 Dec 2019 10:45:35 -0800 (PST)
Received: from localhost.localdomain ([141.226.162.223])
        by smtp.gmail.com with ESMTPSA id y6sm17544054wrl.17.2019.12.22.10.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 10:45:34 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jeff Layton <jlayton@poochiereds.net>
Cc:     "J . Bruce Fields" <bfields@fieldses.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] locks: print unsigned ino in /proc/locks
Date:   Sun, 22 Dec 2019 20:45:28 +0200
Message-Id: <20191222184528.32687-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

An ino is unsigned so export it as such in /proc/locks.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi Jeff,

Ran into this while writing tests to verify i_ino == d_ino == st_ino on
overlayfs. In some configurations (xino=on) overlayfs sets MSB on i_ino,
so /proc/locks reports negative ino values.

BTW, the requirement for (i_ino == d_ino) came from nfsd v3 readdirplus.

Thanks,
Amir.

 fs/locks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/locks.c b/fs/locks.c
index 6970f55daf54..44b6da032842 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2853,7 +2853,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	}
 	if (inode) {
 		/* userspace relies on this representation of dev_t */
-		seq_printf(f, "%d %02x:%02x:%ld ", fl_pid,
+		seq_printf(f, "%d %02x:%02x:%lu ", fl_pid,
 				MAJOR(inode->i_sb->s_dev),
 				MINOR(inode->i_sb->s_dev), inode->i_ino);
 	} else {
-- 
2.17.1

