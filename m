Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F1B1B17BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 22:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgDTU6e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 16:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbgDTU6U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:58:20 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4664CC061A0C;
        Mon, 20 Apr 2020 13:58:20 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id u13so13947701wrp.3;
        Mon, 20 Apr 2020 13:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rbAoCP52MeCYJlfngXJjvybzdgBDDy01LdpgvCAcisE=;
        b=JzZ5T8t4f9OST5eZKKWm/yOKPpyUjXWNLU6pGtTMjHfND/YjbqKuEzIIduSWTiR8Dk
         FiPjmJfBeFvcqvz/gn1zjzxT6h6DoZwtPOy9vXWEDphV5sqtRHbIDqe7UyN9e5YXlnpp
         SKCvjkwodR/znk9R37Ei5nWw6A9OEpmZVIWr35hZoEhwTjBefmbCUXgFoAOLJQsKklcW
         IUX4A3qwJG5gmcXIA4wFnHPhTzryk2AOrNbkSZjY3zeA+JS1zEgDBhlySP3dGWmn0U1I
         vmkNPcAarHXlaru2YcIt8egr2Y0YkuuTuPtKHJa/2x9CQp65wV6JatuQUXXZKjOa36zz
         rczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rbAoCP52MeCYJlfngXJjvybzdgBDDy01LdpgvCAcisE=;
        b=fgm8X2RzkMsAGr4ltjEvKg4NHidDmqj6bdxltXDrafxE6Ui9pz9PayFBBmhErW6Pal
         KE0ugjhLzq8tQgIRbaLTQsUKghzDGFnDo1vBBHhpUJ6UQbcggzCBe5BKzxOjEDmXZrn3
         XPE1sfHWmJ/vRPwf/BzRnGna1acF4qYfz/igqjXCWJ+YaWqKozHe2km2V34So7nZ19ou
         RHslEF/0h7nSepGcrWkzHyNzDRmzVymMWbKaTQSpd74f14cJVlNzwh7AXphsrB9K77Fu
         gpUuRhyxsezlc5Z/S0KQ8pXd65LJgECIZBswmcp+wndZknAxP6TUQUd4YFuEw+9KNbo5
         heEg==
X-Gm-Message-State: AGi0PuaBO9M9HWicRFEPi4WrOxWC8zBQ5nJdNdEHihsAoDQSTUsBr2ii
        ea3f31N+jIG+D8YAPJstYlZueM4=
X-Google-Smtp-Source: APiQypJD5Gts7e2cQFU736NA18aanHlMYyfFC1Peyq1wNGMbg6tcCOUM5gphXeBY+gQOnmhNAzYxKA==
X-Received: by 2002:a5d:4752:: with SMTP id o18mr20355680wrs.283.1587416299088;
        Mon, 20 Apr 2020 13:58:19 -0700 (PDT)
Received: from avx2.telecom.by ([46.53.249.74])
        by smtp.gmail.com with ESMTPSA id m8sm863069wrx.54.2020.04.20.13.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:58:18 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk
Subject: [PATCH 12/15] print_integer, proc: rewrite /proc/*/statm via print_integer()
Date:   Mon, 20 Apr 2020 23:57:40 +0300
Message-Id: <20200420205743.19964-12-adobriyan@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200420205743.19964-1-adobriyan@gmail.com>
References: <20200420205743.19964-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/array.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 6986f9f68ab7..16d66538fa61 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -695,24 +695,28 @@ int proc_pid_statm(struct seq_file *m, struct pid_namespace *ns,
 		unsigned long shared = 0;
 		unsigned long text = 0;
 		unsigned long data = 0;
+		char buf[5 * LEN_UL + 9];
+		char *p = buf + sizeof(buf);
 
 		size = task_statm(mm, &shared, &text, &data, &resident);
 		mmput(mm);
 
-		/*
-		 * For quick read, open code by putting numbers directly
-		 * expected format is
-		 * seq_printf(m, "%lu %lu %lu %lu 0 %lu 0\n",
-		 *               size, resident, shared, text, data);
-		 */
-		seq_put_decimal_ull(m, "", size);
-		seq_put_decimal_ull(m, " ", resident);
-		seq_put_decimal_ull(m, " ", shared);
-		seq_put_decimal_ull(m, " ", text);
-		seq_put_decimal_ull(m, " ", 0);
-		seq_put_decimal_ull(m, " ", data);
-		seq_put_decimal_ull(m, " ", 0);
-		seq_putc(m, '\n');
+		*--p = '\n';
+		*--p = '0';
+		*--p = ' ';
+		p = _print_integer_ul(p, data);
+		*--p = ' ';
+		*--p = '0';
+		*--p = ' ';
+		p = _print_integer_ul(p, text);
+		*--p = ' ';
+		p = _print_integer_ul(p, shared);
+		*--p = ' ';
+		p = _print_integer_ul(p, resident);
+		*--p = ' ';
+		p = _print_integer_ul(p, size);
+
+		seq_write(m, p, buf + sizeof(buf) - p);
 	} else {
 		seq_write(m, "0 0 0 0 0 0 0\n", 14);
 	}
-- 
2.24.1

