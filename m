Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9044A53C7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 01:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiBAAIL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 19:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiBAAIK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 19:08:10 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252A0C06173D
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jan 2022 16:08:10 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d18so13989156plg.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jan 2022 16:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e3ZZiAySqbprwvaDG1hs3CTP647cwZT0Jm9kr093E2Q=;
        b=SxiR2jAqx0RJdUj6gsKJ1LebXy+pOqEh08q6cYfYiO702h1SKnnV1x0ynw3JMlZecC
         JolizYnsCAPRLPwes8Bf7aXuxRI8Oz9bxryv1w5pzifcOfAbOy5YVqqeKNtXJVna3lL9
         srnpX4jhy0Goq+9glObT1FL7WDSNCNQcVwzaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e3ZZiAySqbprwvaDG1hs3CTP647cwZT0Jm9kr093E2Q=;
        b=ZIKFXSXlK7FtKW8Shz0613BQJErdmXeRUNZlHYmTWlVbaANzzHCkhM1/AB8TZFVXvb
         mGV8oxdhD0DmgtEkBCYJ84uxjcaOMrCFiSdjx3k3gGTkOimX5/YS0v1T9x1uEd3xNsFA
         iSWVPmAou2KInY5/YphbTxYH0uytsgqn4J3pYZU8XtmUkxo8N1BIxnRuc4QikeDo3/go
         njZJCep0P/ljuHrC0YP9T1H+8g+Eb9AUmERfOoBDRwizYsyj6KNa/BPEndhoAaBJQCHs
         uzlUqB5tlj7BJ+FStwp0DkZybuN1lgLwsdNLlYkiRitytf7TPJ+XdbF4bVNoPK/Whbgs
         A7Zg==
X-Gm-Message-State: AOAM533bN8KZz2o/6dypMs+d7RUWrPNBYmrPzo4YjU+mSp4iNWm6ooET
        aU1fMxN/KZjZ/lel+S47uLEBAw==
X-Google-Smtp-Source: ABdhPJxwYE9PC8R37lm+lBDVeiw1SZtmTs7c4tULNsg43zULgWEpHvM+K7Xyew2GTFG/Lxvgrwak3w==
X-Received: by 2002:a17:90a:17a5:: with SMTP id q34mr37012466pja.1.1643674089650;
        Mon, 31 Jan 2022 16:08:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c8sm13008520pfv.57.2022.01.31.16.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 16:08:09 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ariadne Conill <ariadne@dereferenced.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Rich Felker <dalias@libc.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] selftests/exec: Avoid future NULL argv execve warning
Date:   Mon, 31 Jan 2022 16:08:07 -0800
Message-Id: <20220201000807.2453486-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1671; h=from:subject; bh=kZ/95lJt1ZckoQR1fzytjDeCsJ6t+JUzBzL4AXqKzBw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh+HnnrFbzy50opMtbIN5Zhx1Vt1/4BuI9rimKtphI EOflI3KJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYfh55wAKCRCJcvTf3G3AJuNmD/ 4zEKZlGO0q21CWKrd8Pgq07v+XlK2pgyM5OURLUmezdnK6c52l5MOfne0FQzmVI82VAe3pbH9Xs3t+ onxh8VaeE98j6Piha+gWfzLdJbl9nfyEk31eFVmEc16LszHaZX17HTQOJp6YfGEZHKJ2TDf44yFm3h 91kFGjWCcukncS7qU1JGXMaAySbnBHIQoo0RU1yFybRmf7Py9K87qhnQpheBsNYSCnJxIytKdFq+4I 44DUOYLKG5GgCIr6pL5lRfgUVL61S4zyShmygXC7+1TIaCKbfJ4rFU3pBlildZzNCLgIh8Bbmu49Qz ZWZHwBR41kxe7yu28/UnISs/LFah8xlvgONHasmUfN5aXlhOhWxPmAaiyykEhskthNLTOcGnrBrquJ ID+KFH9vViv1dWu08C9L+vUhqicXSceHridIW1uaN9zw4eLE/3TJNiC5brlBzZD73TKLkbee3YGjSZ V1pzxgmT+k74qnautdNFJXCbZe3BK8U5+OAFD5xKKjLnz4MYCXIrLyS/x4xSp1LaPCkCTcyMGxmTVU BM5WCrB711+JxunG621R8KaVhugjS8yUA6XlZIB2yPbavj41Yo+n2rS5JbdkvwqHr48aLSS7f756bm MbQkSKWqGGGjIlt64oicdOWRocPvU+SlSkO36NXJcPgBfYhLAvOIas0uatFA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Build actual argv for launching recursion test to avoid future warning
about using an empty argv in execve().

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/exec/recursion-depth.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/exec/recursion-depth.c b/tools/testing/selftests/exec/recursion-depth.c
index 2dbd5bc45b3e..35348db00c52 100644
--- a/tools/testing/selftests/exec/recursion-depth.c
+++ b/tools/testing/selftests/exec/recursion-depth.c
@@ -24,8 +24,14 @@
 #include <sys/mount.h>
 #include <unistd.h>
 
+#define FILENAME "/tmp/1"
+#define HASHBANG "#!" FILENAME "\n"
+
 int main(void)
 {
+	char * const argv[] = { FILENAME, NULL };
+	int rv;
+
 	if (unshare(CLONE_NEWNS) == -1) {
 		if (errno == ENOSYS || errno == EPERM) {
 			fprintf(stderr, "error: unshare, errno %d\n", errno);
@@ -44,21 +50,19 @@ int main(void)
 		return 1;
 	}
 
-#define FILENAME "/tmp/1"
 
 	int fd = creat(FILENAME, 0700);
 	if (fd == -1) {
 		fprintf(stderr, "error: creat, errno %d\n", errno);
 		return 1;
 	}
-#define S "#!" FILENAME "\n"
-	if (write(fd, S, strlen(S)) != strlen(S)) {
+	if (write(fd, HASHBANG, strlen(HASHBANG)) != strlen(HASHBANG)) {
 		fprintf(stderr, "error: write, errno %d\n", errno);
 		return 1;
 	}
 	close(fd);
 
-	int rv = execve(FILENAME, NULL, NULL);
+	rv = execve(FILENAME, argv, NULL);
 	if (rv == -1 && errno == ELOOP) {
 		return 0;
 	}
-- 
2.30.2

