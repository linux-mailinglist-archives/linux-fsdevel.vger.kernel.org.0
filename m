Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4EC7312F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 18:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfEaQrn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 12:47:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40688 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfEaQrY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 12:47:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id u16so1107866wmc.5;
        Fri, 31 May 2019 09:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AoxRD2reTRu3UbtqGj5ISPmNh4fBERakEl1ic6Mj7VQ=;
        b=hZUB8BfixI6FKtOwYyF+FSnRfKr2MZ4wIS/cQvwhtnNQCb1qHeECQGh3BbI6we792p
         Dc/5aKNKNr1fLOSkH67ZHzHrHTF0Bi0xOIn4ONkwRvgesYmoHafemuJwuqNweOuNrPg7
         npQhL4lIaznHXmf0xQUXpgp0EE5PbK31m61CBosRlZqGc0ELjzfbCosv7k9T1cejiCHZ
         6wSK7t5qpfUSx8k4SJLTU/Y0wzJXsUkWrH2RyvlTcVP5esHqKA6YahGJeym5iPWx8oip
         xsdJA/uHHS9zBPWaUYkALGkuQ9XOqhCK0sILULAUY9ojLNCCrXhZ8fqPr+2Qaxy0ugeu
         LiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AoxRD2reTRu3UbtqGj5ISPmNh4fBERakEl1ic6Mj7VQ=;
        b=J/poo/edfIuckqoE+6k6vnemL4tqbuEcvTyldsBHpYvMvFXykaK06+Pd8PTE1SdUyj
         2YDcBRl5IideJC7rULggz+59qAHMMp0rArchIDAxA61WYMYrtlpc2LDj7dz946Wbn9mp
         hfM4Z9M/+xpU9e5Ptk0batrkR+R/k7QK5pX2v7uiWV/Php+z5kuxTcrIGvlt3hiHzzE1
         +OrqZXyfDiAiW866VolQv8YRH6D/D2tHRYT83Tzd33cM/yNOTOkQGOGbSlraGlsZ4m1L
         61Tdgdjvqk53HlwfC1Z7syZGGgZR6o7ohqa/81stcr11XOGduAG0SBuNDjZVWVRlI26T
         kmKw==
X-Gm-Message-State: APjAAAWWfqWheLF9IOpXRYlbcPP/mNiXlETl2DkZLdqZUnOubpQw//BY
        D6g8P/d3/s5OPFpUUNd+RP8=
X-Google-Smtp-Source: APXvYqwtkQxzoxWnfxYDSEJu7tBG9jmgGjQzb8U7LiEzTUjCh93ZAES7osPXOwBo4hmJn/Gr18ak4A==
X-Received: by 2002:a1c:cc02:: with SMTP id h2mr6323602wmb.13.1559321242531;
        Fri, 31 May 2019 09:47:22 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id n5sm7669593wrj.27.2019.05.31.09.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 09:47:21 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        linux-xfs@vger.kernel.org,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH v4 7/9] xfs: use file_modified() helper
Date:   Fri, 31 May 2019 19:46:59 +0300
Message-Id: <20190531164701.15112-8-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531164701.15112-1-amir73il@gmail.com>
References: <20190531164701.15112-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Note that by using the helper, the order of calling file_remove_privs()
after file_update_mtime() in xfs_file_aio_write_checks() has changed.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_file.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 76748255f843..916a35cae5e9 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -367,20 +367,7 @@ xfs_file_aio_write_checks(
 	 * lock above.  Eventually we should look into a way to avoid
 	 * the pointless lock roundtrip.
 	 */
-	if (likely(!(file->f_mode & FMODE_NOCMTIME))) {
-		error = file_update_time(file);
-		if (error)
-			return error;
-	}
-
-	/*
-	 * If we're writing the file then make sure to clear the setuid and
-	 * setgid bits if the process is not being run by root.  This keeps
-	 * people from modifying setuid and setgid binaries.
-	 */
-	if (!IS_NOSEC(inode))
-		return file_remove_privs(file);
-	return 0;
+	return file_modified(file);
 }
 
 static int
-- 
2.17.1

