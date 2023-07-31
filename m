Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5B1768E3D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 09:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjGaHUp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 03:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjGaHT2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:19:28 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85F42D5D;
        Mon, 31 Jul 2023 00:17:37 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9bee2d320so61009651fa.1;
        Mon, 31 Jul 2023 00:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690787855; x=1691392655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akvTsUNH5BR7B9r/hWx35oPtJ0e++GeR0ZkfT+4F3fU=;
        b=ZKQeQX5TR6QzJyvC+jY3QinjsFbGR63r2icZC6hzaVo+s0UZo1N65kjwkZmKHZrkKE
         sSYOktpPLbGgM7aqBZ0b1rqN2BxrDUJEH2hSAwmCepD/Rnl20eMrMex+h6LkhwAlRRxP
         4VAezr+wMiqBBh/ks6rfYJ6F6OceClwfqnKIoljP8I2C/BrMALnLZe0aI9bB7s+wQLhQ
         ENxpNvWIYFyncIGwwtoPq84D6YspqNt05jaf84ECX5PKzi8xKkI+be3IbzdkaH1oKEeO
         oldlnFQnhBVNJ8w02YtPED3gSrPaCnL/RBpOScGa/8v4QhijcBrs6CpRh28yzNB0FWOB
         JOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690787855; x=1691392655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=akvTsUNH5BR7B9r/hWx35oPtJ0e++GeR0ZkfT+4F3fU=;
        b=WZIJ0xjA4uyeJT33Z7YgZm5yf9XghDhuoV2Hny835E62PSQOdoLxEfTsOeyGHpI9iW
         53ZwlExP+piRKGdaxO8P8CcI3K24KkvXUY1xyHbOrpDXprmzXlUeuOmWfbp0oiZ1VEwX
         bQJKyvHSYRezKFhk0x49qLg8qD0GhBdqrx9arkLpHpkHpfZDG/7YUZEihkI5ZRxDH2K4
         y4w6Fg1aHa21fRfoKnIb+bnnD3xdqs2fGJOZSd3t/EiQJrHdKr3Xi4VwreFCXEmjgOC6
         9SrYbP5OBAt1c/1tpY5tAnQIy+iaYnCpIP9yYoCoUrhmZhG5QK7bHAwFyHTe9fr7as+2
         Hf7w==
X-Gm-Message-State: ABy/qLaZi+jzZmE/QJ8GbBu88RXjKG0BFnrqNl7p69Dt5GDgzT1wE+En
        O6ojMLb08XHQrAGk3i58AmA=
X-Google-Smtp-Source: APBJJlFF4kKT7juN18QvvJPucpMXcrmLWnn3HtokESNRx9okAVLCBri/cLwdzx5mg4xeb7fvNIXGsQ==
X-Received: by 2002:a2e:7218:0:b0:2b9:b4eb:c39c with SMTP id n24-20020a2e7218000000b002b9b4ebc39cmr5234236ljc.8.1690787855231;
        Mon, 31 Jul 2023 00:17:35 -0700 (PDT)
Received: from localhost ([165.225.194.214])
        by smtp.gmail.com with ESMTPSA id n5-20020a7bc5c5000000b003fbe4cecc3bsm13472652wmk.16.2023.07.31.00.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 00:17:34 -0700 (PDT)
From:   Joel Granados <joel.granados@gmail.com>
X-Google-Original-From: Joel Granados <j.granados@samsung.com>
To:     mcgrof@kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Kees Cook <keescook@chromium.org>,
        "D. Wythe" <alibuda@linux.alibaba.com>, mptcp@lists.linux.dev,
        Jakub Kicinski <kuba@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Paolo Abeni <pabeni@redhat.com>, coreteam@netfilter.org,
        Jan Karcher <jaka@linux.ibm.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Will Deacon <will@kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        bridge@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        Joerg Reuter <jreuter@yaina.de>, Julian Anastasov <ja@ssi.bg>,
        David Ahern <dsahern@kernel.org>,
        netfilter-devel@vger.kernel.org, Wen Gu <guwen@linux.alibaba.com>,
        linux-kernel@vger.kernel.org,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        linux-wpan@vger.kernel.org, lvs-devel@vger.kernel.org,
        Karsten Graul <kgraul@linux.ibm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-sctp@vger.kernel.org, Tony Lu <tonylu@linux.alibaba.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Westphal <fw@strlen.de>, willy@infradead.org,
        Heiko Carstens <hca@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-rdma@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Simon Horman <horms@verge.net.au>,
        Mat Martineau <martineau@kernel.org>, josh@joshtriplett.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Dumazet <edumazet@google.com>, linux-hams@vger.kernel.org,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-s390@vger.kernel.org,
        Xin Long <lucien.xin@gmail.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        netdev@vger.kernel.org, rds-devel@oss.oracle.com,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH v2 03/14] sysctl: Add ctl_table_size to ctl_table_header
Date:   Mon, 31 Jul 2023 09:17:17 +0200
Message-Id: <20230731071728.3493794-4-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230731071728.3493794-1-j.granados@samsung.com>
References: <20230731071728.3493794-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

