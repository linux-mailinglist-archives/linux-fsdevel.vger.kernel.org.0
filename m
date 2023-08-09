Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C89775841
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 12:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjHIKu7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 06:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjHIKu1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:50:27 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D57B1FCE;
        Wed,  9 Aug 2023 03:50:16 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3178fa77b27so5451930f8f.2;
        Wed, 09 Aug 2023 03:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691578214; x=1692183014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akvTsUNH5BR7B9r/hWx35oPtJ0e++GeR0ZkfT+4F3fU=;
        b=DIpNAVvqJjecgmHxhh/MMRMB6JQ0cQ5/pMDaa7WYGiGSlLNo2GueNm8uCnf8c4bLIg
         Jh2/V9eDbEdRC729m+hu4ww5z5FaeN/b5Orkwci/i2SVrBx/prvWFJ+nUTp5TAka6ZWQ
         VdOImPhuX9gff7/faPKV7lUbtH5Wa6nzUdbat0ktYNe2z5jkuFWTIQveT6P6ug2Ozlg4
         m+3pGIbuZXaQv49t+IPpm6LcHq1/TfBEv4sUH9Kf2GTcYAwaLuI52sbUOA/8f8TWiE7g
         8uWZnDUw085zl7p2xGYwkNfV+fRHfDxGBsZSKhPQwpO/guRzFqg8/M9IkUWjaPTZxUpR
         WEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691578214; x=1692183014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=akvTsUNH5BR7B9r/hWx35oPtJ0e++GeR0ZkfT+4F3fU=;
        b=T05cckjamAn7XNx0ZtufeLyB/LSSkFG/pqZGhtju8pKqn6bWU7RRSEt37RCZ7la9aQ
         cLiV+ZzV84De3ulnYD+nrMof/sW8Ec4Y27DJj/aI0+9dgMaw1vwRTxiWHpnGOfjW2GAY
         ZemuzHzSrEoA/gL8ldc+hqWfyUt/gnexvbaY+jBWDtkcT6Bj+J666F9xuLQ1o+1x6zpI
         h8l/Ux0ygcm+8fWPhh3oiVQpxUgpp37hDVYM3SSnjvRmEXFgci9JDWtlUunADqT/A6Bg
         j2OifJyuoYcF1IjxJJDiwg0rV7Qhlecwb7mFg3UOtEDJvub1rE3meKDf6x/4KzX6pg2w
         JH3Q==
X-Gm-Message-State: AOJu0YwlDrOcZSE7NPWkjKXFJXQ6eigchIYWngq5+JJJQI3Wt9g+r+V4
        g0zmpg4u9Px470XN7Gjh6sI=
X-Google-Smtp-Source: AGHT+IFXthxR30RQgpx73Zfj1dpZ+KWe6tVohuHxQB14UCF1BcuOVclJYzFEHCpt2sceIQmz/La4Nw==
X-Received: by 2002:adf:ec85:0:b0:314:15b7:1fb5 with SMTP id z5-20020adfec85000000b0031415b71fb5mr1561622wrn.34.1691578214394;
        Wed, 09 Aug 2023 03:50:14 -0700 (PDT)
Received: from localhost ([165.225.194.193])
        by smtp.gmail.com with ESMTPSA id b12-20020a05600010cc00b0031432f1528csm16319804wrx.45.2023.08.09.03.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 03:50:13 -0700 (PDT)
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
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH v3 03/14] sysctl: Add ctl_table_size to ctl_table_header
Date:   Wed,  9 Aug 2023 12:49:55 +0200
Message-Id: <20230809105006.1198165-4-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230809105006.1198165-1-j.granados@samsung.com>
References: <20230809105006.1198165-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The new ctl_table_size element will hold the size of the ctl_table
arrays contained in the ctl_table_header. This value should eventually
be passed by the callers to the sysctl register infrastructure. And
while this commit introduces the variable, it does not set nor use it
because that requires case by case considerations for each caller.

It provides two important things: (1) A place to put the
result of the ctl_table array calculation when it gets introduced for
each caller. And (2) the size that will be used as the additional
stopping criteria in the list_for_each_table_entry macro (to be added
when all the callers are migrated)

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 include/linux/sysctl.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 59d451f455bf..33252ad58ebe 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -159,12 +159,22 @@ struct ctl_node {
 	struct ctl_table_header *header;
 };
 
-/* struct ctl_table_header is used to maintain dynamic lists of
-   struct ctl_table trees. */
+/**
+ * struct ctl_table_header - maintains dynamic lists of struct ctl_table trees
+ * @ctl_table: pointer to the first element in ctl_table array
+ * @ctl_table_size: number of elements pointed by @ctl_table
+ * @used: The entry will never be touched when equal to 0.
+ * @count: Upped every time something is added to @inodes and downed every time
+ *         something is removed from inodes
+ * @nreg: When nreg drops to 0 the ctl_table_header will be unregistered.
+ * @rcu: Delays the freeing of the inode. Introduced with "unfuck proc_sysctl ->d_compare()"
+ *
+ */
 struct ctl_table_header {
 	union {
 		struct {
 			struct ctl_table *ctl_table;
+			int ctl_table_size;
 			int used;
 			int count;
 			int nreg;
-- 
2.30.2

