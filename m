Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1F37BD632
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 11:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345699AbjJIJEe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 05:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345719AbjJIJEZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:04:25 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2DEEA
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Oct 2023 02:04:23 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-692ada71d79so3205385b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Oct 2023 02:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696842263; x=1697447063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFyp/FJQdSo4OvDS2koRMpNI0AcMCWskpm09jBYSG+0=;
        b=Hpy2F+Mvb3W9VVAH4+ymsu3MU2Io7PMRqFcpwEOQ58cohJI7P0Bq1G8b11S6Vv9wW0
         lqq0/xvS7z9d9v3LPm1JVqrYKc7i+nddV7N10GtgKx1u+9zkY1jWX6uT3p9klUsmLmQ6
         gPS5QgGfPryWoCNK54rLo7dE793jnpjVzgVtPSbthcF70GC9/W43sD6gzMDlAc19jkJE
         jrr7l4jP69R9IU8zEDdRDPBfHmq/pD4xyqUfDFjL58M8bITMupPdUQRBRAKdpttB1qR4
         f7hFh5on7hJ45wdOCLsaFz1F8Xx9s9F3zwVUIyx4BeFfe4bo1miOY4d018SsXgpiqB5S
         yY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696842263; x=1697447063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFyp/FJQdSo4OvDS2koRMpNI0AcMCWskpm09jBYSG+0=;
        b=PRq/X3iuyAcOHZcoMTpd0v7PEa/0xrS4xqelvl4yjv5DDWMIw7Okuselduj49gPFQ8
         0t+CjVcP5KwlQLHX0zKdvs454HX7Z6kzbP2K2CehuZJam5n18/wQQMnbaWjbF4mdm5+W
         HUEdb1lOEC+T5gxxEXRfVX53b2ubUu5nG8KqMKBuiywbJK2bPks5gG3UVKaCCUPLxvG+
         LQtg74XrcqGP8NqIwBZnQxT/Q9y+YGr0aa87eCka1thDoG+voM67Oi74mbjnLnTAvoeq
         nkxxVVR6/+dZ+q5RdUIH2kjSxLxkzUd3i0JPnKCEVZPZT8y1MK7EV7wz2TZiKTbFEayp
         ZtlQ==
X-Gm-Message-State: AOJu0Yxj8FKUV9vPDv0Rfkhhs6HSQOGiJnJ2xBMM/UNG3i1KehPSap6A
        jKvVMRo0/FT3yRJgc9eR6lbvOw==
X-Google-Smtp-Source: AGHT+IFKCVVlKWApUakuntFkxtH4uqaJa47bxlvJGIvckq1RZ8mrs/tVEi1bx2puyhb/HtfMhfqyng==
X-Received: by 2002:a05:6a00:14d2:b0:693:3bed:e60b with SMTP id w18-20020a056a0014d200b006933bede60bmr13898154pfu.12.1696842262782;
        Mon, 09 Oct 2023 02:04:22 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id fk3-20020a056a003a8300b00690ca4356f1sm5884847pfb.198.2023.10.09.02.04.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Oct 2023 02:04:22 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com
Cc:     zhangpeng.00@bytedance.com, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 06/10] maple_tree: Update the documentation of maple tree
Date:   Mon,  9 Oct 2023 17:03:16 +0800
Message-Id: <20231009090320.64565-7-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20231009090320.64565-1-zhangpeng.00@bytedance.com>
References: <20231009090320.64565-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce the new interface mtree_dup() in the documentation.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 Documentation/core-api/maple_tree.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/core-api/maple_tree.rst b/Documentation/core-api/maple_tree.rst
index 45defcf15da7..285e2d2b21ae 100644
--- a/Documentation/core-api/maple_tree.rst
+++ b/Documentation/core-api/maple_tree.rst
@@ -81,6 +81,9 @@ section.
 Sometimes it is necessary to ensure the next call to store to a maple tree does
 not allocate memory, please see :ref:`maple-tree-advanced-api` for this use case.
 
+You can use mtree_dup() to duplicate an entire maple tree. It is a more
+efficient way than inserting all elements one by one into a new tree.
+
 Finally, you can remove all entries from a maple tree by calling
 mtree_destroy().  If the maple tree entries are pointers, you may wish to free
 the entries first.
@@ -112,6 +115,7 @@ Takes ma_lock internally:
  * mtree_insert()
  * mtree_insert_range()
  * mtree_erase()
+ * mtree_dup()
  * mtree_destroy()
  * mt_set_in_rcu()
  * mt_clear_in_rcu()
-- 
2.20.1

