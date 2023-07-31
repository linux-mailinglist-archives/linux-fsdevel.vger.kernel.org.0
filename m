Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4222768E7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 09:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjGaHVL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 03:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjGaHT3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:19:29 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A572D5F;
        Mon, 31 Jul 2023 00:17:39 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe110de3b6so16678805e9.1;
        Mon, 31 Jul 2023 00:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690787858; x=1691392658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OpnfSbwwoibW9M83Wu6OD32YzFt1sk3ke/j1mk6tNI=;
        b=GIJG9yEArom+8MZN4OTa76Anl/Tx5phujQ///06BHq/HllfyGKtY5aYv4Votpuaf5Y
         160T9sAfvdE8SF4noBBkQgx/9NpAN5GxOOk/fFOa2PaWR/dmrCdzxaIhemN+P3t8lmZA
         9WDpkn1KuqRSTEWikhlNRs9i3IOyfV6U0hgzbNqOYLtcrba155gRuo8a6maOiP4WdbeY
         Jie57pFfoPa9i6bo5+50ZVQyb8fnGEz4Zts8S/2s0MrGRUrGLAzwYN1HkiIxFrbTdaDh
         1HKwRuxUNuWcBZVpyARac7O72UFDDUhM8HTjB8asFaPK6HIB9XcOalV8hxPVCb1IluOg
         bOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690787858; x=1691392658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OpnfSbwwoibW9M83Wu6OD32YzFt1sk3ke/j1mk6tNI=;
        b=VlCduGHaDwQ3F1eOd1BWoaPUO/PY/B0h9dgzIjaBXIlmQ8pfhBK9fgI6pAhHtlzCEe
         KdnMbN1Lr5aUr1nt/6YsJLqc11Cf0F5tE92xdR12yiK+qKenXKQxUMfBCgAidiyk87bN
         fUpozKImr19MXJCDwBtB0ZHzh0Z7uihdkWJwSmxxfMMGbF2gY1wZb01VwJISsfhCReOy
         oYkqbifEXh7M+aMsSIQG0ofywE1Cjnu0beluK65oQSzcUTklWLAd6bojcy3QXitDxHPy
         Aw6F+2vI3ROc+pkQ2AUU2TBpjrekESkQ1aQQqANoU8TehoFHrRxFs99lcXtZNuWcekoc
         eNTA==
X-Gm-Message-State: ABy/qLYIpWo3WdX3sqg3LS/sHkT+yy7sAm3Vd5kLWoBlQPRmbzckqvW0
        doTHEoFyabGcOth1GzHWik5T2+c2voL3YAec
X-Google-Smtp-Source: APBJJlEsuWaXgM85723d4gu/HLXH0eqHwOdiMX957anFT3hC8fOsR/W4vSMzGFe1WH35i1zVah1nhQ==
X-Received: by 2002:a1c:7404:0:b0:3fe:163e:d6a5 with SMTP id p4-20020a1c7404000000b003fe163ed6a5mr4223220wmc.4.1690787857708;
        Mon, 31 Jul 2023 00:17:37 -0700 (PDT)
Received: from localhost ([165.225.194.214])
        by smtp.gmail.com with ESMTPSA id n6-20020a7bcbc6000000b003fe1e3937aesm3158234wmi.20.2023.07.31.00.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 00:17:37 -0700 (PDT)
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
Subject: [PATCH v2 04/14] sysctl: Add size argument to init_header
Date:   Mon, 31 Jul 2023 09:17:18 +0200
Message-Id: <20230731071728.3493794-5-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230731071728.3493794-1-j.granados@samsung.com>
References: <20230731071728.3493794-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In this commit, we add a table_size argument to the init_header function
in order to initialize the ctl_table_size variable in ctl_table_header.
Even though the size is not yet used, it is now initialized within the
sysctl subsys. We need this commit for when we start adding the
table_size arguments to the sysctl functions (e.g. register_sysctl,
__register_sysctl_table and __register_sysctl_init).

Note that in __register_sysctl_table we temporarily use a calculated
size until we add the size argument to that function in subsequent
commits.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 fs/proc/proc_sysctl.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 884460b0385b..fa1438f1a355 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -188,9 +188,10 @@ static void erase_entry(struct ctl_table_header *head, struct ctl_table *entry)
 
 static void init_header(struct ctl_table_header *head,
 	struct ctl_table_root *root, struct ctl_table_set *set,
-	struct ctl_node *node, struct ctl_table *table)
+	struct ctl_node *node, struct ctl_table *table, size_t table_size)
 {
 	head->ctl_table = table;
+	head->ctl_table_size = table_size;
 	head->ctl_table_arg = table;
 	head->used = 0;
 	head->count = 1;
@@ -973,7 +974,7 @@ static struct ctl_dir *new_dir(struct ctl_table_set *set,
 	memcpy(new_name, name, namelen);
 	table[0].procname = new_name;
 	table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
-	init_header(&new->header, set->dir.header.root, set, node, table);
+	init_header(&new->header, set->dir.header.root, set, node, table, 1);
 
 	return new;
 }
@@ -1197,7 +1198,8 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table_
 		link_name += len;
 		link++;
 	}
-	init_header(links, dir->header.root, dir->header.set, node, link_table);
+	init_header(links, dir->header.root, dir->header.set, node, link_table,
+		    head->ctl_table_size);
 	links->nreg = nr_entries;
 
 	return links;
@@ -1372,7 +1374,7 @@ struct ctl_table_header *__register_sysctl_table(
 		return NULL;
 
 	node = (struct ctl_node *)(header + 1);
-	init_header(header, root, set, node, table);
+	init_header(header, root, set, node, table, nr_entries);
 	if (sysctl_check_table(path, header))
 		goto fail;
 
@@ -1537,7 +1539,7 @@ void setup_sysctl_set(struct ctl_table_set *set,
 {
 	memset(set, 0, sizeof(*set));
 	set->is_seen = is_seen;
-	init_header(&set->dir.header, root, set, NULL, root_table);
+	init_header(&set->dir.header, root, set, NULL, root_table, 1);
 }
 
 void retire_sysctl_set(struct ctl_table_set *set)
-- 
2.30.2

