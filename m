Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2FF2B9EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2019 20:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfE0SLU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 May 2019 14:11:20 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.206]:13921 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726346AbfE0SLT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 May 2019 14:11:19 -0400
X-Greylist: delayed 1423 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 May 2019 14:11:19 EDT
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 207546311
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2019 12:47:36 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id VJihh1qokiQerVJiihcg5l; Mon, 27 May 2019 12:47:36 -0500
X-Authority-Reason: nr=8
Received: from [189.250.47.159] (port=36866 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hVJig-002gpt-Nl; Mon, 27 May 2019 12:47:34 -0500
Date:   Mon, 27 May 2019 12:47:33 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] unicode: replace strncpy() by strscpy()
Message-ID: <20190527174733.GA29547@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.47.159
X-Source-L: No
X-Exim-ID: 1hVJig-002gpt-Nl
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.47.159]:36866
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The strncpy() function is being deprecated. Replace it by the safer
strscpy() and fix the following Coverity warning:

"Calling strncpy with a maximum size argument of 12 bytes on destination
array version_string of size 12 bytes might leave the destination string
unterminated."

Notice that, unlike strncpy(), strscpy() always null-terminates the
destination string.

Addresses-Coverity-ID: 1445547 ("Buffer not null terminated")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/unicode/utf8-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index 6afab4fdce90..a367041468cf 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -131,7 +131,7 @@ static int utf8_parse_version(const char *version, unsigned int *maj,
 		{0, NULL}
 	};
 
-	strncpy(version_string, version, sizeof(version_string));
+	strscpy(version_string, version, sizeof(version_string));
 
 	if (match_token(version_string, token, args) != 1)
 		return -EINVAL;
-- 
2.21.0

