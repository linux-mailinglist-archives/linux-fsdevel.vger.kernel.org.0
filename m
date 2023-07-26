Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AAC76386F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbjGZOIO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbjGZOHP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:07:15 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593192688
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:07:02 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230726140700euoutp0190f585839cce18a22abbc7a703084b62~1cAltdPSW3221432214euoutp01L
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:07:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230726140700euoutp0190f585839cce18a22abbc7a703084b62~1cAltdPSW3221432214euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690380420;
        bh=O9C8cu+eriqJgnbO4v2Z8b/dkIKixZDljclAYTZ36o0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qwTrNETLohSqW5oINSHaiw+BRoLXW4UBmr3d7nZYjDQbWNshhhM8jurvzhIOtDK4c
         QP+4oq76T/f4lm04LTtjaXTcxTPSjF+Y/lwRpPwk9UGOPxfuGad/yyyFEwMqCO5bzD
         alhawVDXskp841YewpEBmrtaKgsKqo5LslWwJv+o=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230726140700eucas1p23c3d90dc8d83fc17d20e7181ad9cdf58~1cAlgA4qF3020930209eucas1p2T;
        Wed, 26 Jul 2023 14:07:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id BC.66.42423.48821C46; Wed, 26
        Jul 2023 15:07:00 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230726140700eucas1p1e6b16e884362ebec50f6712b3f11a533~1cAlMkQVf2040620406eucas1p1h;
        Wed, 26 Jul 2023 14:07:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230726140700eusmtrp23cb07803949101e69d6e6784132527b8~1cAlL-95p2014720147eusmtrp2g;
        Wed, 26 Jul 2023 14:07:00 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-79-64c1288491dd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 05.57.14344.48821C46; Wed, 26
        Jul 2023 15:07:00 +0100 (BST)
Received: from localhost (unknown [106.210.248.223]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230726140700eusmtip26639b8677aab72762d4dfdf7367693e1~1cAk7WVCu2007220072eusmtip2G;
        Wed, 26 Jul 2023 14:07:00 +0000 (GMT)
From:   Joel Granados <j.granados@samsung.com>
To:     mcgrof@kernel.org, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     willy@infradead.org, josh@joshtriplett.org,
        Joel Granados <j.granados@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/14] sysctl: Add size arg to __register_sysctl_init
Date:   Wed, 26 Jul 2023 16:06:27 +0200
Message-Id: <20230726140635.2059334-8-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230726140635.2059334-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djPc7otGgdTDHYsULFYuv8ho8X/BfkW
        Z7pzLfbsPclicXnXHDaLGxOeMlr8/gFkLdvp58DhMbvhIovHgk2lHptXaHncem3rsWlVJ5tH
        35ZVjB6fN8kFsEdx2aSk5mSWpRbp2yVwZXTvfsNS0ChYcepUG0sD4xq+LkZODgkBE4n/7T2s
        XYxcHEICKxglDsy6wgThfGGUWDv9AgtIlZDAZ0aJ3v3RMB2ff3+G6ljOKPFz5mNGCOclo8S0
        /g2MIFVsAjoS59/cYe5i5OAQEYiVWDwlBSTMLDCdUWLJHBkQW1jAVeJX63lmEJtFQFVi8cll
        LCDlvAK2Emumq0Lskpdouz4dbCKngJ3EyrXfWUFsXgFBiZMzn7BAjJSXaN46mxnkBAmBMxwS
        648eYoJodpHYdGEtlC0s8er4FnYIW0bi/875TBANkxkl9v/7wA7hrGaUWNb4FarDWqLlyhN2
        kIuYBTQl1u/SBzElBBwllh5SgjD5JG68FYS4gU9i0rbpzBBhXomONiGIGSoSfUunsEDYUhLX
        L+9kg7A9JN68fMY8gVFxFpJvZiH5ZhbC2gWMzKsYxVNLi3PTU4sN81LL9YoTc4tL89L1kvNz
        NzECE8/pf8c/7WCc++qj3iFGJg7GQ4wSHMxKIryGMftShHhTEiurUovy44tKc1KLDzFKc7Ao
        ifNq255MFhJITyxJzU5NLUgtgskycXBKNTBJFJibrlHuSYst+5zUvsjZ9nuNOcOh3Rbu0RMX
        MlxdxPj6Z7THn5wXeltEXb5vY7hwMkLdWe0rfwh/iM+Vj9u6AneJORupMFQ8Peb32CqVv+ju
        tY88mfL7Ju6tPtXfUa9vlsZ8PWCJp9Gp7grWy92hGtd9Xk66ltKv77Dt/efcs1ZLKnXDFs/8
        oh64+FO3i/xmJpaHW9yd+e6d2zJjTXqxWdp+tz0cVtEFrcfqLrn9CI+TDFS/49A0t8h5x7Fr
        +/3ucHDMy9n3of4Le2TXIYGvOqtU7/yvmrGz78zfGeEqzvsXzVRkLjvmqXTOy7B/5/VfF32y
        E303Jze4eOXGZ5ieCTsePm3iHin+h8VHfymxFGckGmoxFxUnAgAQeG4AqwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42I5/e/4Pd0WjYMpBgv+C1gs3f+Q0eL/gnyL
        M925Fnv2nmSxuLxrDpvFjQlPGS1+/wCylu30c+DwmN1wkcVjwaZSj80rtDxuvbb12LSqk82j
        b8sqRo/Pm+QC2KP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLL
        Uov07RL0Mrp3v2EpaBSsOHWqjaWBcQ1fFyMnh4SAicTn359Zuxi5OIQEljJK/Lz7j72LkQMo
        ISXxfRknRI2wxJ9rXWwQNc8ZJVau38AOkmAT0JE4/+YOM4gtIhAvMfPxfSaQImaB2YwSq08e
        AksIC7hK/Go9D2azCKhKLD65jAVkAa+ArcSa6aoQC+Ql2q5PZwSxOQXsJFau/c4KYgsBlfRM
        fQq2i1dAUOLkzCcsIDYzUH3z1tnMExgFZiFJzUKSWsDItIpRJLW0ODc9t9hIrzgxt7g0L10v
        OT93EyMwSrYd+7llB+PKVx/1DjEycTAeYpTgYFYS4TWM2ZcixJuSWFmVWpQfX1Sak1p8iNEU
        6OyJzFKiyfnAOM0riTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCUamBa
        wv5vmVce543wyHq5rhvfO278lvnwKOfW9FK9LY8bTvQ97j9TWK5QVcvR277nJcvTOQcuVl7b
        v2nGLmOZvMJNHQrVmRIuG/QeTY/edfzY4wtpn18I2asvXMmueHeFgv+aQyveLro38Q+TcsK/
        LN4VT79KdkgZTojbsNF9qrDdN6UFUVXLsxvfckU/8uaeEtuRIOEk8YXBoTIgufzllzSXKveC
        P6bbrebc/NR5UWODnpmXV0iKYsbpWxabm0/Gf/aeOm3T6mUXw67n2075N/mFcrUKc/k390OZ
        Z9acv2p4L4BZ42Je6m7H1bOmyGzuY/8UeeFk8/XVd09cUll5Sni19y87yb2uzzmbjQ6rrD7U
        ocRSnJFoqMVcVJwIAN5IOfYbAwAA
X-CMS-MailID: 20230726140700eucas1p1e6b16e884362ebec50f6712b3f11a533
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230726140700eucas1p1e6b16e884362ebec50f6712b3f11a533
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230726140700eucas1p1e6b16e884362ebec50f6712b3f11a533
References: <20230726140635.2059334-1-j.granados@samsung.com>
        <CGME20230726140700eucas1p1e6b16e884362ebec50f6712b3f11a533@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is part of the effort to remove the sentinel element from the
ctl_table array at register time. We add a size argument to
__register_sysctl_init and modify the register_sysctl_init macro to
calculate the array size with ARRAY_SIZE. The original callers do not
need to be updated as they will go through the new macro.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 fs/proc/proc_sysctl.c  | 11 ++---------
 include/linux/sysctl.h |  5 +++--
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index c04293911e7e..6c0721cd35f3 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1444,16 +1444,9 @@ EXPORT_SYMBOL(register_sysctl_sz);
  * Context: if your base directory does not exist it will be created for you.
  */
 void __init __register_sysctl_init(const char *path, struct ctl_table *table,
-				 const char *table_name)
+				 const char *table_name, size_t table_size)
 {
-	int count = 0;
-	struct ctl_table *entry;
-	struct ctl_table_header t_hdr, *hdr;
-
-	t_hdr.ctl_table = table;
-	list_for_each_table_entry(entry, (&t_hdr))
-		count++;
-	hdr = register_sysctl_sz(path, table, count);
+	struct ctl_table_header *hdr = register_sysctl_sz(path, table, table_size);
 
 	if (unlikely(!hdr)) {
 		pr_err("failed when register_sysctl_sz %s to %s\n", table_name, path);
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index b1168ae281c9..09d7429d67c0 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -236,8 +236,9 @@ void unregister_sysctl_table(struct ctl_table_header * table);
 
 extern int sysctl_init_bases(void);
 extern void __register_sysctl_init(const char *path, struct ctl_table *table,
-				 const char *table_name);
-#define register_sysctl_init(path, table) __register_sysctl_init(path, table, #table)
+				 const char *table_name, size_t table_size);
+#define register_sysctl_init(path, table)	\
+	__register_sysctl_init(path, table, #table, ARRAY_SIZE(table))
 extern struct ctl_table_header *register_sysctl_mount_point(const char *path);
 
 void do_sysctl_args(void);
-- 
2.30.2

