Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F75768E39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 09:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjGaHUv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 03:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjGaHT3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:19:29 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909DC19B7;
        Mon, 31 Jul 2023 00:17:56 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbc54cab6fso38849145e9.0;
        Mon, 31 Jul 2023 00:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690787875; x=1691392675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5noSV5uL5R3dSrbr/R0oWH8ijMnn3jtlsPFspVagWKY=;
        b=SdrDkcAXByY0sJ7+rsAQdKfwmVG3c5WCPbN//BnCCScfOVUkasmGjo067IR+VtoRFo
         D6fwH8JniXv/Aup+rPGRbJrL8OTu9SbMmBiODdKPF8oMnV5nnhT5Dk8pAsrGnQ1wlSD+
         ZPSjKJj0Pl4FANdos20Y/es0ysWL5w8sQZmI+ZHUBkv+tuJ1lk6dlgDvkzs/df09zXrj
         ozr7xMnnfqrKvmouPpdXKljCbCEOiFQv0X/hWykCE2eIqIt79Ja2MJK+869pNwih6sKq
         TE5UeaBofIs4fRFHFLZTtsmqowO2I2B2j/4dl6w9Zz7MLeQMomK17YoLSMVAB2k5xiif
         a5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690787875; x=1691392675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5noSV5uL5R3dSrbr/R0oWH8ijMnn3jtlsPFspVagWKY=;
        b=N2ouy/r5GVUOQi+JrBf2ipL4gUAzxPLYM8mf2Rum2icnbKriJ2bfDR7vhLg2y1Rvz2
         nelKIQFqde7NzmUgDRFqtVs4gdhCHHwYXsoBudOFbgA7fvCfuxvoDv5v0FcbSTcXAfZr
         nYhO5ynRTSg8W6nn14WtLedoLiy/QyAnSUkTOW85JD3wh6kFRsYZ/txaueMLPQcf0FdK
         jraN1SGsFdrX5DIwjZffbHpAy6Vh6yY3i8gqZ/Dmp8NFcrrhXWv8tJPWx/KhYmX3DNS4
         imWTTyj2QeDTbrJQUGsrG0vpsNNRcPtxEtBg8Hy8y1zD7MmsSX37QwGmRD8pPKS9oJzW
         +TEQ==
X-Gm-Message-State: ABy/qLaWU8XN47XpcmrI3gNnL/OednKp9cqzM4bvwzqbeMIUoH70yE6i
        u16uKZStv4qVcjm1z7WCzdA=
X-Google-Smtp-Source: APBJJlHpAH3o3EDSC2u2zI8yHuEQrXycm/dtoKdWekhqyBYm7o6lNwNkDT7RDClIujTk2ibrxiYYXQ==
X-Received: by 2002:a7b:c4d0:0:b0:3fb:ac9c:e6f with SMTP id g16-20020a7bc4d0000000b003fbac9c0e6fmr6026875wmk.38.1690787875090;
        Mon, 31 Jul 2023 00:17:55 -0700 (PDT)
Received: from localhost ([165.225.194.214])
        by smtp.gmail.com with ESMTPSA id s10-20020a7bc38a000000b003fbfc61d36asm10570517wmj.5.2023.07.31.00.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 00:17:54 -0700 (PDT)
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
        Joel Granados <j.granados@samsung.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PATCH v2 13/14] sysctl: SIZE_MAX->ARRAY_SIZE in register_net_sysctl
Date:   Mon, 31 Jul 2023 09:17:27 +0200
Message-Id: <20230731071728.3493794-14-j.granados@samsung.com>
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

Replace SIZE_MAX with ARRAY_SIZE in the register_net_sysctl macro. Now
that all the callers to register_net_sysctl are actual arrays, we can
call ARRAY_SIZE() without any compilation warnings. By calculating the
actual array size, this commit is making sure that register_net_sysctl
and all its callers forward the table_size into sysctl backend for when
the sentinel elements in the ctl_table arrays (last empty markers) are
removed. Without it the removal would fail lacking a stopping criteria
for traversing the ctl_table arrays.

Stopping condition continues to be based on both table size and the
procname null test. This is needed in order to allow for the systematic
removal al the sentinel element in subsequent commits: Before removing
sentinel the stopping criteria will be the last null element. When the
sentinel is removed then the (correct) size will take over.

Signed-off-by: Joel Granados <j.granados@samsung.com>
Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
---
 include/net/net_namespace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index e4e5fe75a281..75dba309e043 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -470,7 +470,7 @@ void unregister_pernet_device(struct pernet_operations *);
 struct ctl_table;
 
 #define register_net_sysctl(net, path, table)	\
-	register_net_sysctl_sz(net, path, table, SIZE_MAX)
+	register_net_sysctl_sz(net, path, table, ARRAY_SIZE(table))
 #ifdef CONFIG_SYSCTL
 int net_sysctl_init(void);
 struct ctl_table_header *register_net_sysctl_sz(struct net *net, const char *path,
-- 
2.30.2

