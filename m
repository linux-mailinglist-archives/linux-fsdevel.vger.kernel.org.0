Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE74B3BAE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 19:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387773AbfFJR0S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 13:26:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46947 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387415AbfFJR0S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:26:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so9973611wrw.13;
        Mon, 10 Jun 2019 10:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=T2wOLlAZOy3qVuwvBdYnNU8FtvV+XZXW5B2+vkjvzz4=;
        b=gC3U/uassCcEoc68QCw7GSiYkAneEFa7J1H2dMA5k36Z2H99T8sFzyGqAntJVHBOm5
         00OEsj68IwdLBaF9QndWlLM2ASJucU4pTMp98fSeuev4Rekvs1vebV8r8S7bbvq5Cu9E
         e8SbhDceZvQHD2Pazf8XZ9fLpdy6DpoeBgD9OCKZ7yiJ+7WLKYymJlcWNxIW4y3NY8iN
         o2/DRWzVEpPn+TOrWoPSvgMa+t0MR13t8afnqhBIkOFJg1CtLs8+1FRCzJKmmVimu8I3
         zVmMNNDEcjDPnWtXm7QOMNxOMY9X6FCaGSiutrtNTsRlm1UAm1Pcu0u0spPI5KL/tF6P
         wxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T2wOLlAZOy3qVuwvBdYnNU8FtvV+XZXW5B2+vkjvzz4=;
        b=r10DsDbJ9Nz7iK1M9NkXWOju6W7pp64LqveiUI0/GOtAauSgfhN71Gq/5Qse7oMoxq
         AsQqnLoh5YGLm7Zq0ragwFgtYLpBWnm6xTL7YWrAuRWvie5Uv2hlt7mKhJWtWoG+ua59
         WifIV4yEMkqAw0CyOEpvBlXNjxqd8W9IHc1XXCMugOU1RuH+yfdMg+2QvTP0H5vtT3A/
         ulS7V0yyvGOhaPoxPu4xGklYmHYfoRPPzRu0oCIaI14jaOjzPnfMb6+uRuiMff8aDecx
         5/gO4H7fkNR5ljkn3zF0hpcJ7TozJlCoX3yWGcBILe9r7l8MI21P6agCuyO7fdYsEy4U
         gdMw==
X-Gm-Message-State: APjAAAWfktCZ+TX95TR4y1Mc3MhZxpdtOCFdgTp9u0X/ChAKNsHb52YR
        wq80etUpwYmhgzyUNaEZwPs=
X-Google-Smtp-Source: APXvYqwQAchO4xzDDFGFembG1wpHHtqDt0EBI1Uads7Uz0CM6SO0qeCbrz57U2YQ6cfCnMi2buFfEw==
X-Received: by 2002:adf:dd52:: with SMTP id u18mr7785778wrm.193.1560187575805;
        Mon, 10 Jun 2019 10:26:15 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id s10sm247626wmf.8.2019.06.10.10.26.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 10:26:15 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Theodore Ts'o <tytso@mit.edu>, linux-xfs@vger.kernel.org,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH] vfs: allow copy_file_range from a swapfile
Date:   Mon, 10 Jun 2019 20:26:06 +0300
Message-Id: <20190610172606.4119-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

read(2) is allowed from a swapfile, so copy_file_range(2) should
be allowed as well.

Reported-by: Theodore Ts'o <tytso@mit.edu>
Fixes: 96e6e8f4a68d ("vfs: add missing checks to copy_file_range")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Darrick,

This fixes the generic/554 issue reported by Ted.

I intend to remove the test case of copy from swap file from
generic/554, so test is expected to pass with or without this fix.
But if you wait for next week's xfstests update before applying
this fix, then at lease maintainer that run current xfstests master
could use current copy-file-range-fixes branch to pass the tests.

Thanks,
Amir.

 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index aac71aef4c61..f74e5ce7ca50 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3081,7 +3081,7 @@ int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 	if (IS_IMMUTABLE(inode_out))
 		return -EPERM;
 
-	if (IS_SWAPFILE(inode_in) || IS_SWAPFILE(inode_out))
+	if (IS_SWAPFILE(inode_out))
 		return -ETXTBSY;
 
 	/* Ensure offsets don't wrap. */
-- 
2.17.1

