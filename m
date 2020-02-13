Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0457515BA0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 08:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbgBMH1Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 02:27:25 -0500
Received: from mout-p-201.mailbox.org ([80.241.56.171]:46068 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729862AbgBMH1Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 02:27:25 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 48J7Pk6qGvzQlBW;
        Thu, 13 Feb 2020 08:27:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id JdjAUVVYt7OR; Thu, 13 Feb 2020 08:27:20 +0100 (CET)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH] selftests: openat2: fix build error on newer glibc
Date:   Thu, 13 Feb 2020 18:26:56 +1100
Message-Id: <20200213072656.15611-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It appears that newer glibcs check that openat(O_CREAT) was provided a
fourth argument (rather than passing garbage), resulting in the
following build error:

> In file included from /usr/include/fcntl.h:301,
>                  from helpers.c:9:
> In function 'openat',
>     inlined from 'touchat' at helpers.c:49:11:
> /usr/include/x86_64-linux-gnu/bits/fcntl2.h:126:4: error: call to
> '__openat_missing_mode' declared with attribute error: openat with O_CREAT
> or O_TMPFILE in third argument needs 4 arguments
>   126 |    __openat_missing_mode ();
>       |    ^~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 tools/testing/selftests/openat2/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/openat2/helpers.c b/tools/testing/selftests/openat2/helpers.c
index e9a6557ab16f..5074681ffdc9 100644
--- a/tools/testing/selftests/openat2/helpers.c
+++ b/tools/testing/selftests/openat2/helpers.c
@@ -46,7 +46,7 @@ int sys_renameat2(int olddirfd, const char *oldpath,
 
 int touchat(int dfd, const char *path)
 {
-	int fd = openat(dfd, path, O_CREAT);
+	int fd = openat(dfd, path, O_CREAT, 0700);
 	if (fd >= 0)
 		close(fd);
 	return fd;
-- 
2.25.0

