Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC2F775871
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 12:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjHIKvq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 06:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjHIKu4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:50:56 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8810C2137;
        Wed,  9 Aug 2023 03:50:39 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9aa1d3029so105875221fa.2;
        Wed, 09 Aug 2023 03:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691578238; x=1692183038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2sRNbI2azaNM3epQYqeDbNNvVsnx+uOoBBxcjhRKfE=;
        b=msEFSbObqY9s8LRvEW0pOyPiCoRYq2OqQ8aFjTaMZp66s9PhBKq77Y9e2V5RWAAEIM
         9A+oKL3bvIyOMFlQ1PZ1PsE7tBOe+XYywgriqm/pKlDN/VHQQ/ndQfefrtwA9BO7grMn
         rFSSwL9SpICl8gVA46h6X9EyQ/rbrDfAI1jrBkJ8T1/tFgYZWrqmCHJ9sfcyd34OgJJ1
         WWFu2ze9vFGpAYum+PC5KqqYb1cTAuOQnLGkolnnwiy1qkFAMphjl6o7RN7pc88mPW67
         wujo4SNe4ys2qn7qiSiGMeqcr1nqRJRiUNwnC53IV0uMhBehw2NSckriVPDdyv6wB1zr
         hR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691578238; x=1692183038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2sRNbI2azaNM3epQYqeDbNNvVsnx+uOoBBxcjhRKfE=;
        b=dI2oxWqvq2mFeMM0OD5nFwNSwu2VTzXxNl1wV03Yv2d0gNZwrntfsfAL5xvxaUG2oF
         6XhDilvwSNmiBgXQJr/Xyg4k2qkS0eT0skRergUm4PY58NTKhRt3nlgL8+5YspZEzXGW
         YevhJv8ostG8P4zJ3QSwA0xtoAQRknwwn/XeJjgAtT0M1CWHdwlJB1jJjXeu1T0cHSQ5
         nwfjI1+67DUWxmr4F+QUkB5L1dNeLdtWdG0v557bXpLFB4tWNHqgmdfmzF0LVk3uK9Ym
         AZDs0W66nRgMcBGEIFSL1E6wGsF1Zo8l7+lP2MDi7RLU3X2899PfzI21FuIGTIPBIzQK
         lVqg==
X-Gm-Message-State: AOJu0YxQ+/yoe715BCmDOP46PF/CH5hAjQDQrCfk2QDjk/+7CUONVZG0
        vPuszLSVBKWVKlF1JG5UjPc=
X-Google-Smtp-Source: AGHT+IEqxrPAYJZNCqWU257rXs5ZZv/+krpS60QQC5LVhJec2d7jEsNORJzb93LBbrFFUikrXvNUJQ==
X-Received: by 2002:a2e:8893:0:b0:2b9:44c5:ac15 with SMTP id k19-20020a2e8893000000b002b944c5ac15mr1510364lji.41.1691578237645;
        Wed, 09 Aug 2023 03:50:37 -0700 (PDT)
Received: from localhost ([165.225.194.193])
        by smtp.gmail.com with ESMTPSA id s13-20020a7bc38d000000b003fbb1a9586esm1620796wmj.15.2023.08.09.03.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 03:50:37 -0700 (PDT)
From:   Joel Granados <joel.granados@gmail.com>
X-Google-Original-From: Joel Granados <j.granados@samsung.com>
To:     mcgrof@kernel.org
Cc:     rds-devel@oss.oracle.com, "David S. Miller" <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>, willy@infradead.org,
        Jan Karcher <jaka@linux.ibm.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        Simon Horman <horms@verge.net.au>,
        Tony Lu <tonylu@linux.alibaba.com>, linux-wpan@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        mptcp@lists.linux.dev, Heiko Carstens <hca@linux.ibm.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Will Deacon <will@kernel.org>, Julian Anastasov <ja@ssi.bg>,
        netfilter-devel@vger.kernel.org, Joerg Reuter <jreuter@yaina.de>,
        linux-kernel@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-sctp@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-hams@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        coreteam@netfilter.org, Ralf Baechle <ralf@linux-mips.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        keescook@chromium.org, Roopa Prabhu <roopa@nvidia.com>,
        David Ahern <dsahern@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>, josh@joshtriplett.org,
        linux-fsdevel@vger.kernel.org,
        Alexander Aring <alex.aring@gmail.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        netdev@vger.kernel.org,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        linux-s390@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Eric Dumazet <edumazet@google.com>, lvs-devel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        bridge@lists.linux-foundation.org,
        Karsten Graul <kgraul@linux.ibm.com>,
        Mat Martineau <martineau@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Joel Granados <j.granados@samsung.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PATCH v3 14/14] sysctl: Use ctl_table_size as stopping criteria for list macro
Date:   Wed,  9 Aug 2023 12:50:06 +0200
Message-Id: <20230809105006.1198165-15-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230809105006.1198165-1-j.granados@samsung.com>
References: <20230809105006.1198165-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a preparation commit to make it easy to remove the sentinel
elements (empty end markers) from the ctl_table arrays. It both allows
the systematic removal of the sentinels and adds the ctl_table_size
variable to the stopping criteria of the list_for_each_table_entry macro
that traverses all ctl_table arrays. Once all the sentinels are removed
by subsequent commits, ctl_table_size will become the only stopping
criteria in the macro. We don't actually remove any elements in this
commit, but it sets things up to for the removal process to take place.

By adding header->ctl_table_size as an additional stopping criteria for
the list_for_each_table_entry macro, it will execute until it finds an
"empty" ->procname or until the size runs out. Therefore if a ctl_table
array with a sentinel is passed its size will be too big (by one
element) but it will stop on the sentinel. On the other hand, if the
ctl_table array without a sentinel is passed its size will be just write
and there will be no need for a sentinel.

Signed-off-by: Joel Granados <j.granados@samsung.com>
Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
---
 fs/proc/proc_sysctl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 817bc51c58d8..504e847c2a3a 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -19,8 +19,9 @@
 #include <linux/kmemleak.h>
 #include "internal.h"
 
-#define list_for_each_table_entry(entry, header) \
-	for ((entry) = (header->ctl_table); (entry)->procname; (entry)++)
+#define list_for_each_table_entry(entry, header)	\
+	entry = header->ctl_table;			\
+	for (size_t i = 0 ; i < header->ctl_table_size && entry->procname; ++i, entry++)
 
 static const struct dentry_operations proc_sys_dentry_operations;
 static const struct file_operations proc_sys_file_operations;
-- 
2.30.2

