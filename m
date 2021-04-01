Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F197352284
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 00:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbhDAWNv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 18:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236011AbhDAWNc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 18:13:32 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15F1C061794
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Apr 2021 15:13:31 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x126so2398138pfc.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Apr 2021 15:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ed7VreEWmipFlx5jenlD6GzJkKJrcT4I8s/OqzA0i0=;
        b=MVcoIZrQlvVcmQw6Q7zTf+TL+LvBevTMEQM/sQTCGQdJRCHkODdqFrhlGlyLtPQqO1
         MqHhedF01mipbWimf0tiEub58/KFZfgwlOONe0rNFLv51Kzf9OKCuFr4BVNfwnOa7TvX
         3RuK52nBjEPN4VfjR6vNPNYljfKr3XLRrUlBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ed7VreEWmipFlx5jenlD6GzJkKJrcT4I8s/OqzA0i0=;
        b=KHbIHuW6Faq4d+uYEYaIoGUVyu4xaZIQqHIFV50tKnxJYpOqjasH7ni/txJkq2yOuS
         g8h54QAGx2HWOXiWD6z4GozWzlrYQUOHj0FrVPRbt3bx6qQ1stPp7p6eS0Hvo9hVX+mK
         Oh1TG7qv5/kjCf13g0Ot7+4jch2AqqPah2TnQIRnRvaLPcXFrhZAdRvOJ46lnf7PvxBS
         z8iU4CKDXeAzauLZ8QGuw3DXd8amMoxuuocHMLMzQCnBq/OMhTiChw8z04D/6zBJeBkr
         WlLo8EGCVDZiX7f8iSJmIPmYCiJN9GvPurrx+vjWonU2AbreAvJHsoHw+IiArRv/i1a7
         Aueg==
X-Gm-Message-State: AOAM531aWssAsUwfWycCOg0fRNoADw1cliylTgsaLuInU6HzAxZpjrJS
        Mqa5r2c8c4UjA6IMrYWYT+4e6w==
X-Google-Smtp-Source: ABdhPJxDaz1NgY3bIH+fEiBGo3o6TaU33X/O5JkexlVAJgmY2Ch2FL5TNgz8/nDQIQChliOrxLoCEg==
X-Received: by 2002:a62:2742:0:b029:222:b711:3324 with SMTP id n63-20020a6227420000b0290222b7113324mr9372178pfn.7.1617315211421;
        Thu, 01 Apr 2021 15:13:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fr23sm6380245pjb.22.2021.04.01.15.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 15:13:29 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, Michal Hocko <mhocko@suse.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v4 2/3] seq_file: Fix clang warning for NULL pointer arithmetic
Date:   Thu,  1 Apr 2021 15:13:19 -0700
Message-Id: <20210401221320.2717732-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401221320.2717732-1-keescook@chromium.org>
References: <20210401221320.2717732-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=072ba8d0292080bbec63f540b8a7b8f4388d46e0; i=X28+TLSj6UAzyfUwM6ASBpL0O+6znj4kpkRLU6W477w=; m=BVZ7UGjppHc9pxpbNOtE+k2Mc/TPPXIP/bm3a5RPhjA=; p=bMQkNyH1GTm6eEjiE8Zl6RhCNwohxteBG+pqB7gCs1I=
X-Patch-Sig: m=pgp; i=arnd@arndb.de; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBmRX8ACgkQiXL039xtwCaLMg/+Lhx pOKAP38pEErrYMo+5DOvXlMaNUoctJ8O82UArlKz1tK0WnGh/2r6wsUb57mBRxiEm1Fqs4js4duAl kR7kxnB0PYJgEVpDX2mbErnsMYYEpTK2OPrFPfuXpogkv7ZzBTR8dfQwxETzu+yBfjnn1DmRNqIVF j9TrK2uBIE7lwsIWWyEuuEVYoZ68xhrJ9IrQ1ZLE5fA4VF/woqhbJKXQAUimIgUO6mvg9OJpISbWs CYQxi2njTOqAtu8mSsyhsuBuW8KV+G/PeM0oSqythjF6LKzULC86d3WEH6aEazn2znU7/frImFMxl UhkTHmOfkr/tMJyxO8jDuPjpXytP0fmIkpOSgNIh7PlQgLWXf5+OkbCoU/WSTY1jR27M7+HAvGd7Q C9hYO6odGUvbXgyGVaruHYEZfTQ/1Mym/duFmytroX4JG8bnj5gVv9L01vETRRa9WSeP6Fj8vzxoA ko6fy/Oq77nJ2SiA//Z1h3wNCzGagcTHRAh96xkDD1FzytY3Hjb8tbTwBZsYvlmvjQnyscKPBUPHc N8EC5Bc7vZPFKzPf53UMw/NirSq1etb50K5J7aWmAbmgJm+qryafE51E/Xvd/uaOrzjdypKRhuxGN uCHmvLBr6U1WaTio88kV78F55LIb9pgl0iVP+4UV7wscGidMpLzJGIVSeO8qaN5w=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Clang points out that adding something to NULL is not allowed in
standard C:

fs/kernfs/file.c:127:15: warning: performing pointer arithmetic on a
null pointer has undefined behavior [-Wnull-pointer-arithmetic]
                return NULL + !*ppos;
                       ~~~~ ^
fs/seq_file.c:529:14: warning: performing pointer arithmetic on a
null pointer has undefined behavior [-Wnull-pointer-arithmetic]
        return NULL + (*pos == 0);

Rephrase the code to be extra explicit about the valid, giving them
named SEQ_OPEN_EOF and SEQ_OPEN_SINGLE definitions.  The instance in
kernfs was copied from single_start, so fix both at once.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: c2b19daf6760 ("sysfs, kernfs: prepare read path for kernfs")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20201028151202.3074398-1-arnd@kernel.org
---
 fs/kernfs/file.c         | 9 ++++++---
 fs/seq_file.c            | 5 ++++-
 include/linux/seq_file.h | 6 ++++++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index c75719312147..721bcbc1d4d0 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -122,10 +122,13 @@ static void *kernfs_seq_start(struct seq_file *sf, loff_t *ppos)
 		return next;
 	} else {
 		/*
-		 * The same behavior and code as single_open().  Returns
-		 * !NULL if pos is at the beginning; otherwise, NULL.
+		 * The same behavior and code as single_open().  Continues
+		 * if pos is at the beginning; otherwise, NULL.
 		 */
-		return NULL + !*ppos;
+		if (*ppos)
+			return NULL;
+
+		return SEQ_OPEN_SINGLE;
 	}
 }
 
diff --git a/fs/seq_file.c b/fs/seq_file.c
index cb11a34fb871..1b5bd95d0a48 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -542,7 +542,10 @@ EXPORT_SYMBOL(seq_dentry);
 
 static void *single_start(struct seq_file *p, loff_t *pos)
 {
-	return NULL + (*pos == 0);
+	if (*pos)
+		return NULL;
+
+	return SEQ_OPEN_SINGLE;
 }
 
 static void *single_next(struct seq_file *p, void *v, loff_t *pos)
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index b83b3ae3c877..51c870765bfd 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -37,6 +37,12 @@ struct seq_operations {
 
 #define SEQ_SKIP 1
 
+/*
+ * op->start must return a non-NULL pointer for single_open(),
+ * this is used when we don't care about the specific value.
+ */
+#define SEQ_OPEN_SINGLE ((void *)1)
+
 /**
  * seq_has_overflowed - check if the buffer has overflowed
  * @m: the seq_file handle
-- 
2.25.1

