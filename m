Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3063467B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 19:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbhCWSdD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 14:33:03 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53220 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231380AbhCWScm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 14:32:42 -0400
Received: from localhost.localdomain (unknown [IPv6:2401:4900:5170:240f:f606:c194:2a1c:c147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 82FE31F44A66;
        Tue, 23 Mar 2021 18:32:32 +0000 (GMT)
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, krisman@collabora.com, ebiggers@google.com,
        drosen@google.com, ebiggers@kernel.org, yuchao0@huawei.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com, kernel test robot <lkp@intel.com>
Subject: [PATCH v3 1/5] fs: unicode: Use strscpy() instead of strncpy()
Date:   Wed, 24 Mar 2021 00:01:57 +0530
Message-Id: <20210323183201.812944-2-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210323183201.812944-1-shreeya.patel@collabora.com>
References: <20210323183201.812944-1-shreeya.patel@collabora.com>
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
Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
Reported-by: kernel test robot <lkp@intel.com>
---

Changes in v3
  - Return error if strscpy() returns value < 0

Changes in v2
  - Resolve warning of -Wstringop-truncation reported by
    kernel test robot.

 fs/unicode/utf8-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index dc25823bf..706f086bb 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -180,7 +180,10 @@ static int utf8_parse_version(const char *version, unsigned int *maj,
 		{0, NULL}
 	};
 
-	strncpy(version_string, version, sizeof(version_string));
+	int ret = strscpy(version_string, version, sizeof(version_string));
+
+	if (ret < 0)
+		return ret;
 
 	if (match_token(version_string, token, args) != 1)
 		return -EINVAL;
-- 
2.24.3 (Apple Git-128)

