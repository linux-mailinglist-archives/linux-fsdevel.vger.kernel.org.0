Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0008A64FC0E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Dec 2022 20:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiLQTS5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Dec 2022 14:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQTS4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Dec 2022 14:18:56 -0500
Received: from ms11p00im-qufo17291601.me.com (ms11p00im-qufo17291601.me.com [17.58.38.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9B8FD28
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Dec 2022 11:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1671303169;
        bh=0u7CleR3qq8AvpdUYPg91vFZVCJ99OPUJfM/02vLNlw=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=xQLX3oglvw9jj4LBkFQyp7PGYDCx++70+esWXDfKX5PabBmINnGfaKinPlLCrv6Hq
         3CcJ1eLN0gosGZCjVD4HAEm5jMTYwgAn3sJHTZTH49UZL2efdlUZg+dLlhWBlxe56y
         YK29+4Sd1zKeHGsNz26deqg9r6rGyLFMI/dK6UgwnklS7dUkOnWZaTXcGr7DgN9nzv
         DVfuuteo4h2sD6UAABzqrZigg1MdkESwUUN7UZgjahDVVgMV3R1+fPEFMYGlwclQJt
         c1KiH37Yx55siuTi2UPpuVg0K4RgFYVLCG2raojGKeFU1X591qA75ON3grbfiU0eAN
         qLouyAi6EiBng==
Received: from thundercleese.localdomain (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
        by ms11p00im-qufo17291601.me.com (Postfix) with ESMTPSA id 18CCE3A04FF;
        Sat, 17 Dec 2022 18:52:48 +0000 (UTC)
From:   Eric Van Hensbergen <evanhensbergen@icloud.com>
To:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux_oss@crudebyte.com,
        Eric Van Hensbergen <evanhensbergen@icloud.com>
Subject: [PATCH 2/6] Don't assume UID 0 attach
Date:   Sat, 17 Dec 2022 18:52:06 +0000
Message-Id: <20221217185210.1431478-3-evanhensbergen@icloud.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221217185210.1431478-1-evanhensbergen@icloud.com>
References: <20221217185210.1431478-1-evanhensbergen@icloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: J9qBR71ssgp32bkMQLDyUkQPVdEKomI3
X-Proofpoint-ORIG-GUID: J9qBR71ssgp32bkMQLDyUkQPVdEKomI3
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 adultscore=0
 mlxlogscore=377 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2212170174
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The writeback_fid fallback code assumes a root uid fallback which
breaks many server configurations (which don't run as root).  This
patch switches to generic lookup which will follow argument
guidence on access modes and default ids to use on failure.

There is a deeper underlying problem with writeback_fids in that
this fallback is too standard and not an exception due to the way
writeback mode works in the current implementation.  Subsequent
patches will try to associate writeback fids from the original user
either by flushing on close or by holding onto fid until writeback
completes.

Signed-off-by: Eric Van Hensbergen <evanhensbergen@icloud.com>
---
 fs/9p/fid.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index 805151114e96..1fbd12d581bb 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -304,7 +304,9 @@ struct p9_fid *v9fs_writeback_fid(struct dentry *dentry)
 	int err;
 	struct p9_fid *fid, *ofid;
 
-	ofid = v9fs_fid_lookup_with_uid(dentry, GLOBAL_ROOT_UID, 0);
+	/* pull default uid from dfltuid */
+
+	ofid = v9fs_fid_lookup(dentry);
 	fid = clone_fid(ofid);
 	if (IS_ERR(fid))
 		goto error_out;
-- 
2.37.2

