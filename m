Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6C2762FAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 10:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjGZIXQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 04:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjGZIWi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:22:38 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8C37280
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 01:10:30 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a5a7ebdd9fso2785378b6e.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 01:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690359029; x=1690963829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8uNs+P31bvWCjQDHXfNwA0J1eeKVpGhA2UwqZlpI48=;
        b=CrBUyHbKlHgI9bJ+PDdaaetEcpHr3E/W2ZfSeQBeKeVprTl52WIKA+JT3TW5+Ml/Vt
         ddWID0Zgv01crS6rbjypqKita+JfgnUG4tKAb+l2OFoy32E4s/A8cPZuepcKPkIfxCqK
         2Ve0brfKitPbiuM5fkRL7lSTRVdwqr/fwvAm0+bDvcAYv7+oX/fJ7rugbAx694yPbS8C
         y79T2h1uzsi7M/59p+ojtXI3BlaoZ2svHDneAsizA7/Q0qzjd2Tay0M7mOc+/5KMlRpf
         Wyv+4A63YfHdc49RtDmJ13nR93qde273z4c2bCDXtCk6qfm/zbcgPqnD0ZeDszcCz3JY
         T0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690359029; x=1690963829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8uNs+P31bvWCjQDHXfNwA0J1eeKVpGhA2UwqZlpI48=;
        b=lP9sDwbxZY40tMnZ2K0syokLekX97nyrNngAXD8t2fM7lDR/UrSTeOLzIFVkdnAIc7
         DOBFgb/famIOnTPjCxYhdJetFQcDA2KFOEfloU2LFfowRPUGY1Ar6z1W/vWYdILDA1uO
         2t3OqkEQjEpRV4Jd61G2/kdASuVDfnVzTuFYS9UGwjpCsi5sFYZ1cQKNaYL/50vapQL5
         cqg6Ynj0/seej7gGT4sW1wWOZoxny7PccbuUlmONzmWaA+7504rTE/0+I9fmyEpcoNro
         pizp+oE+dci/cy99BX8+fJrDNk7t1F0f94jYJ2BJ1ilmSLJ2sd+wzKJp3i9rQr91GALG
         nR2w==
X-Gm-Message-State: ABy/qLYgfuIKu7ffGIIXwAxRMcp1CtAvMwlGp5iRuw/q2sfiTXJqXSuX
        mlJwZlG0qgM1xAYYpTnHVDRfVQ==
X-Google-Smtp-Source: APBJJlGhAux4gsHuRlskWB+2hAoyUd2LMLZZMtlCIKrNxAMe0PgykyqeVppW19z8AHH0EfD4FyyaJQ==
X-Received: by 2002:a05:6808:1599:b0:3a1:e3ee:742a with SMTP id t25-20020a056808159900b003a1e3ee742amr1872990oiw.8.1690359029699;
        Wed, 26 Jul 2023 01:10:29 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id gc17-20020a17090b311100b002680b2d2ab6sm756540pjb.19.2023.07.26.01.10.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Jul 2023 01:10:29 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com, avagin@gmail.com
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 07/11] maple_tree: Update the documentation of maple tree
Date:   Wed, 26 Jul 2023 16:09:12 +0800
Message-Id: <20230726080916.17454-8-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduces the newly introduced mt_dup() and mas_replace_entry().

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 Documentation/core-api/maple_tree.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/core-api/maple_tree.rst b/Documentation/core-api/maple_tree.rst
index 45defcf15da7..a4fa991277c7 100644
--- a/Documentation/core-api/maple_tree.rst
+++ b/Documentation/core-api/maple_tree.rst
@@ -71,6 +71,11 @@ return -EEXIST if the range is not empty.
 
 You can search for an entry from an index upwards by using mt_find().
 
+If you want to duplicate a tree, you can use mt_dup(). It will build a new tree
+that is exactly the same as the source tree, and it uses an efficient
+implementation, so it is much faster than traversing the source tree and
+inserting into the new tree one by one.
+
 You can walk each entry within a range by calling mt_for_each().  You must
 provide a temporary variable to store a cursor.  If you want to walk each
 element of the tree then ``0`` and ``ULONG_MAX`` may be used as the range.  If
@@ -115,6 +120,7 @@ Takes ma_lock internally:
  * mtree_destroy()
  * mt_set_in_rcu()
  * mt_clear_in_rcu()
+ * mt_dup()
 
 If you want to take advantage of the internal lock to protect the data
 structures that you are storing in the Maple Tree, you can call mtree_lock()
@@ -155,6 +161,10 @@ You can set entries using mas_store().  mas_store() will overwrite any entry
 with the new entry and return the first existing entry that is overwritten.
 The range is passed in as members of the maple state: index and last.
 
+If you have located an entry using something like mas_find(), and want to
+replace this entry, you can use mas_replace_entry(), which is more efficient
+than mas_store*().
+
 You can use mas_erase() to erase an entire range by setting index and
 last of the maple state to the desired range to erase.  This will erase
 the first range that is found in that range, set the maple state index
-- 
2.20.1

