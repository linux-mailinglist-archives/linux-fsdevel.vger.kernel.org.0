Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D0E34D937
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Mar 2021 22:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhC2UnQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 16:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhC2UnE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 16:43:04 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAE1C061574;
        Mon, 29 Mar 2021 13:43:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id D5AAC1F454FD
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, krisman@collabora.com, ebiggers@google.com,
        drosen@google.com, ebiggers@kernel.org, yuchao0@huawei.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com, kernel test robot <lkp@intel.com>
Subject: [PATCH v5 1/4] fs: unicode: Use strscpy() instead of strncpy()
Date:   Tue, 30 Mar 2021 02:12:37 +0530
Message-Id: <20210329204240.359184-2-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210329204240.359184-1-shreeya.patel@collabora.com>
References: <20210329204240.359184-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Following warning was reported by Kernel Test Robot.

In function 'utf8_parse_version',
inlined from 'utf8_load' at fs/unicode/utf8mod.c:195:7:
>> fs/unicode/utf8mod.c:175:2: warning: 'strncpy' specified bound 12 equals
destination size [-Wstringop-truncation]
175 |  strncpy(version_string, version, sizeof(version_string));
    |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The -Wstringop-truncation warning highlights the unintended
uses of the strncpy function that truncate the terminating NULL
character from the source string.
Unlike strncpy(), strscpy() always null-terminates the destination string,
hence use strscpy() instead of strncpy().

Fixes: 9d53690f0d4e5 (unicode: implement higher level API for string handling)
Acked-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 fs/unicode/utf8-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index dc25823bfed9..f9e6a2718aba 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -179,8 +179,10 @@ static int utf8_parse_version(const char *version, unsigned int *maj,
 		{1, "%d.%d.%d"},
 		{0, NULL}
 	};
+	int ret = strscpy(version_string, version, sizeof(version_string));
 
-	strncpy(version_string, version, sizeof(version_string));
+	if (ret < 0)
+		return ret;
 
 	if (match_token(version_string, token, args) != 1)
 		return -EINVAL;
-- 
2.30.1

