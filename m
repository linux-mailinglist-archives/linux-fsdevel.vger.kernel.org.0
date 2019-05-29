Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE70C2E3C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 19:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfE2Rnn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 13:43:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53585 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfE2Rnn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 13:43:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id d17so2249085wmb.3;
        Wed, 29 May 2019 10:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mWDe89ODCpcP6HYYy/yqf+cljHqldogh+/AgsrEHfwE=;
        b=cD+1CJrnj5cSe1wCIpAFwua2MN1kN1xNg3hIT6ATRPZEleePpBS6eGUWulB1qlMP1/
         Ddr+gyrC56II0jJ0mgCgLIHbYpIvw9Uaoe35riq+AN93RuLHGQu72fjZVk3oqne9Wl+a
         sFfqjNZWNIrSKacCT5jz5DzGMxohKbXopTtjeRxkeMfIWjQJexxCmL17wfht1kbQ0/kE
         u1NOszql8jNhqMOcQO8sYBy9Q68Pnu+PhxaKS7z/iWim9WlT01meShp9XkP3LSxieuyg
         pHfItlQiK/im4jO8Ue5CcjCo4tKicYkzQVAcyZ97HWBzBCNCpfC50cefJIS6Q8wCnxh8
         9bOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mWDe89ODCpcP6HYYy/yqf+cljHqldogh+/AgsrEHfwE=;
        b=aFtoHqoN44phN5OJUAEr2WAo7OkNAP780VnpnjkvMHeYFjTTb+cTVbTuN+P1JL7jKh
         ADPl5+01G+LAFREY6BCx5to2IX4shbif/lVhD4LErFp09acqMEzndnK+7lOCNTcI/MHc
         /12TEdkMXmCEgsxrezvy82Csqv7NrVwNL4s8qagbuxjwOSv/30C29S7mh6YaXyc7o3l7
         9lPV04LbECoP3neMVcrE80H++955zwVsGri57Rgi8NAg8iyhA32fY6JgAZRKMxPPtl5Z
         j392EDX4j4jxu4RWQPde1oL/VpKaW8cb35kpEZz7YJWT1Jr1dagrbWep99Rr43dkQDK4
         feGQ==
X-Gm-Message-State: APjAAAVtaPJkmcaQSEeerfPgN3eKU6EbN8T1pTBWZ7uJQro55q01FjLZ
        wX23RNxRfkwr0wOkxoDWKC0=
X-Google-Smtp-Source: APXvYqwIlp98ADVdrSYvWbdeg9HNHHdS9VwKtmNUodON5E/WEaVY9+Ztcp9OWHWCflaplsQIscHC1A==
X-Received: by 2002:a1c:cb49:: with SMTP id b70mr8135774wmg.80.1559151821622;
        Wed, 29 May 2019 10:43:41 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id k125sm31702wmb.34.2019.05.29.10.43.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 10:43:41 -0700 (PDT)
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
Subject: [PATCH v3 07/13] xfs: use file_modified() helper
Date:   Wed, 29 May 2019 20:43:11 +0300
Message-Id: <20190529174318.22424-8-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529174318.22424-1-amir73il@gmail.com>
References: <20190529174318.22424-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Note that by using the helper, the order of calling file_remove_privs()
after file_update_mtime() in xfs_file_aio_write_checks() has changed.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
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

