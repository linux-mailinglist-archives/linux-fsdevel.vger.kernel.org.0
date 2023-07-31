Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F41768E5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 09:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjGaHUl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 03:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbjGaHT2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:19:28 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382F919B0;
        Mon, 31 Jul 2023 00:17:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31763b2c5a4so4351555f8f.3;
        Mon, 31 Jul 2023 00:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690787874; x=1691392674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLmPwUxElpGPIItGBie9qSPLiGC8xTssPnC4wjmH8Co=;
        b=IpykfJb7hcUQStL2f0jwevdksgcPlej76+9Dvlr1etAys3iM7VBIf1dA9mPPbAYwEb
         ovJ3JqI/719OJKxsZ6C+Z8AKuT8aGJ8b4PaOI4zBQOwthNmU3T7saorlPq0OFGxCpSve
         zgNuz5M+is0YyrITjMyHTZmRVk7n/qm4sjOgmkOO54OTjqAif6/SwiRsLOZuEL+B98qp
         GAICvEE8SmvklGodmsUNzWyuYtuSW1QtXfHA5t9EADp21BbKXmmGvog+lzyPMjWS0+o9
         YAQafxqNi3TE5xfJHhmTEkye+I77LFFqaIu/Xim5e2O7+IpfnM5rQvYU0EPtAIag7AvX
         7qPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690787874; x=1691392674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLmPwUxElpGPIItGBie9qSPLiGC8xTssPnC4wjmH8Co=;
        b=U7euX327XCUDFBvRqU7FRl+AFuZSBqtqYricR2K8UPJRWxFO52JX48UHhTKIeqpVAd
         gi2BuN7DZl9rB6nikm91qGQla15A5vtVqQwxNirDHfBf3WF1LQT606e5QptxE19teKDg
         hDnUAbpNOUJ6jCw2ea9sKycGijQ3JoCu7Ea1FlY8UcB7VRgD06KqY/EJxrs5P/rCJiAC
         xK4hWi1r177juHXa73PoEjcOToQD2UrBqkNSgnW9y/3Qf54bMET8VPczvhe0OAh693sF
         fb0I4EwiTOg45XKgsHwuxTzoVSEnq87pZ89eboR0qLcmnYno8aaQz4IJ/+5ys1W/95c0
         tUbA==
X-Gm-Message-State: ABy/qLaztbFjnkG3v1bBampAPdm5NFwR2iPdL3LyEDArp8WbyrwKpNEo
        i8OM9AbZOr/0igong0nXSKg=
X-Google-Smtp-Source: APBJJlEWJpIRsYgvvSuwbjUjC75DanD11Vxqj9Uy7oRYPl2tqIHO5CFVTD3oPksJ5zp8xbINTXCHDg==
X-Received: by 2002:a5d:474c:0:b0:317:52d2:d196 with SMTP id o12-20020a5d474c000000b0031752d2d196mr6971143wrs.33.1690787873675;
        Mon, 31 Jul 2023 00:17:53 -0700 (PDT)
Received: from localhost ([165.225.194.214])
        by smtp.gmail.com with ESMTPSA id r8-20020adfe688000000b0031434c08bb7sm12018523wrm.105.2023.07.31.00.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 00:17:53 -0700 (PDT)
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
Subject: [PATCH v2 12/14] vrf: Update to register_net_sysctl_sz
Date:   Mon, 31 Jul 2023 09:17:26 +0200
Message-Id: <20230731071728.3493794-13-j.granados@samsung.com>
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

Move from register_net_sysctl to register_net_sysctl_sz and pass the
ARRAY_SIZE of the ctl_table array that was used to create the table
variable. We need to move to the new function in preparation for when we
change SIZE_MAX to ARRAY_SIZE() in the register_net_sysctl macro.
Failing to do so would erroneously allow ARRAY_SIZE() to be called on a
pointer. The actual change from SIZE_MAX to ARRAY_SIZE will take place
in subsequent commits.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/net/vrf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index bdb3a76a352e..f4c3df15a0e5 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1979,7 +1979,8 @@ static int vrf_netns_init_sysctl(struct net *net, struct netns_vrf *nn_vrf)
 	/* init the extra1 parameter with the reference to current netns */
 	table[0].extra1 = net;
 
-	nn_vrf->ctl_hdr = register_net_sysctl(net, "net/vrf", table);
+	nn_vrf->ctl_hdr = register_net_sysctl_sz(net, "net/vrf", table,
+						 ARRAY_SIZE(vrf_table));
 	if (!nn_vrf->ctl_hdr) {
 		kfree(table);
 		return -ENOMEM;
-- 
2.30.2

