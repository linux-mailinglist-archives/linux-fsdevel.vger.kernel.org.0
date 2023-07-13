Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6A37520C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 14:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbjGMMGT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 08:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjGMMGS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:06:18 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FE426BD;
        Thu, 13 Jul 2023 05:06:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXA/Ed4Nx+oaJvIvIQjir5fPv7c/wU+DzYkdRB81muD9ZJxogkaNCCLJkRbXvGJu4nVw+n3v2ex2/5eb1Ijuc+2mGbF7uFNQAujgfDg19SPzB/l6CTspeiJXj8p77xy1G9EK2QU4rJEsb/YY2AI3jtr/+wiFk8wo3uX0dO6lk3nxkWz+dZoyWDpVRp1o1k64s99ZtGjGs1lCwEfe1nsKZpqP+uZOW4YbdynkzsCBYYaSfFLzYh3PVolh6K9NcNGn05x8DeKX0Fx/LuAPtqJ7abDYRQSFirXvk3KhujQBGACHPIqnSXOl1z5+HHkLE38i9pq2eiz+l9r+Riy76EXMPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=So6+lTB/fAOjbsNEB9EV/2DMzP0pfEzsWHhiw7lCtQI=;
 b=YKh3YnWKxFfx2aJ8gjtdxvIwFV69a4rX9lvZGo473RuafsmU1Cya96col/n6g6UOIojXK5amzmWOLWyw2nBDeZNew/FkojggJQNbyafd0OGna/PD6ezRRp+uNn2kqjTYTbRMNt74QP7KQ7efJNCR0TGLuq0BRcdj0Bd2fly0AC1lmVgtb1JNowEnLroSkoviLuDg0mzI9VepV9qkFZ7hirzDHwENRiDBoKvNkDuYuy2Nt8dsf3ACSpMy0WAApw8TiJtuQpXDiFgNAjU3LgUwwI0XDoMd6p/9nZXdJEgzaAuaftUGznZpvdjP6pASPVcxTg23mZWS0MzU/0ccS8zlkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=So6+lTB/fAOjbsNEB9EV/2DMzP0pfEzsWHhiw7lCtQI=;
 b=SRF9kj7InEmHyYI+dWm0jB/uQl78ZGdtHD0ge9owVVjGSuwEeTDmglh/+pZSyfsxVEQ40gO43LkJjiUX0hb9DZRwkZOgQkSijvH5/hubmbo3Q/7nv5RMTC7zElczB6n1i0FZye4I5/IIl2bDQ/xPMlwegy1BPUlQj9ZLXZFFlss/MqAQj22500iXfwxnd61blevL9yElx2VJ1ExNv3iRls16MwoWGVG2PUdmN+vpEfU7Lqn1sOYsBjZvDDfiKE79+kMLDVTMoZRwFPCDg4rr7DB9lwac8N0i2UKN/uuMeN+H5PMQ74Gk/NSu2JGMv7hGPRY8IYugBi24GNySTAoKsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 KL1PR06MB6757.apcprd06.prod.outlook.com (2603:1096:820:102::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24; Thu, 13 Jul 2023 12:06:06 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 12:06:06 +0000
From:   Wang Ming <machel@vivo.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v1] fs: Fix error checking for d_hash_and_lookup()
Date:   Thu, 13 Jul 2023 20:05:42 +0800
Message-Id: <20230713120555.7025-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0077.apcprd02.prod.outlook.com
 (2603:1096:4:90::17) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|KL1PR06MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: ab212972-cbe5-44c2-5647-08db8399892a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nF+T2dPKh7+7UnyQSEwP5rcfj7zcSzpexuKEz2Dsk97hSWFRajd78T6sjtslrLfyM9MqAyje0QepUcNGlAuCTZzFb94gTXrDLkcwZ87f+CsZ3MY8iQH83c98bhWLae3XHzxdKxB706kcJLN7djWplZDmy7Lk4lIGG/06urPEX4kRaBGmj5draiRAw3Pntkuv6Vczer5cVM3BQdVvmtoaBP699b/Q1OJT/TLxkt6X9zWrstjO7YDZlC5OOGK0ufwWAFRm3HBdzcDEWN8twggymavC1OhuBk7ZpWqnhW4DhA0TvqgRgMAN2wibAO04xgjnrZFqKAe9K6XaQiQ4qayFAYRi/nFPqYTvt8diN7WkMfTuwzUgeXVjx1alCxwLMHN6uxZ+o6enkeHqEg0yYU6E5ZpZOqk5HOU4EQif9p25yLhAB6y4OAki8W27ksdtGLwgAdClP8+JofivPg1imu6hs2kIYDeH4urG2wM3+RBlz+JxC2g7N5Bt0eK2ggXtQiTcLpIB9IQ59VR6sGQcVhmw6CEfsVyBkdHSOcVhT/ufopovsPZ+L1qRARcgJow/3oJdGcPRhVQgugXinyBA6+OlGSyPRrLT5rdC/vP3XVbVBL2mwDqVfJ0tzig5ehNheqpP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199021)(110136005)(316002)(6666004)(52116002)(186003)(66946007)(4326008)(6486002)(66556008)(66476007)(478600001)(41300700001)(6512007)(107886003)(8676002)(8936002)(86362001)(1076003)(6506007)(26005)(5660300002)(83380400001)(2616005)(36756003)(2906002)(38350700002)(38100700002)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?unEIS/mH64WzGb09ObBlR0HDkC6h34okJMHQlNr0U9s4BzEMWNd0Fq4fjA33?=
 =?us-ascii?Q?YCHGO00Sqg75bjNGG+h/C+dMttedlAbS6Utctchq+7nNa1Pan/5seOxM35QV?=
 =?us-ascii?Q?hC5eTSk/gwrGVS/eJjZKyw27fbpRNhTr2KhMZzgyvO9+fusdXJ3+H2kMiLHq?=
 =?us-ascii?Q?imYSe5uU9XzZEXiQ7cxIo0Lb/rY7e6eWt5nQLACchMEjMchb1maCaKbV14oK?=
 =?us-ascii?Q?N9bxh5tqeSBKjx7+WdxzxRVp5SPdEHyJjXNjqVOgwLiMWIQb975jg71bcqEg?=
 =?us-ascii?Q?ye5lXEEjtqC8h0W7oX5bgVCiUr7b4ZAsJ9+hhHXtV8iJ7LIGT8UzcsjLNZXp?=
 =?us-ascii?Q?LALnU4rSj+lb9VWQRXHBMZmNKWIyiaDE1eTZGE+TZUVXAEj2MVWAVuVpNkXq?=
 =?us-ascii?Q?PtOREuixYdWDeMyi0lIvIKXWQKPjVZ+41QqEyZ9fnrDacxpAf+I8ZiJcNyZM?=
 =?us-ascii?Q?M6Vz504dBPcyEqi/kyK/f6nz4Kyb5NklVkN//xRAINOx9WFoDe6GfcR/j1Nv?=
 =?us-ascii?Q?BsYh1/OcxdQpK10qVoT6HVYUIzpILqByoAfn58jVRk9xub0xEf+UurBWH8G/?=
 =?us-ascii?Q?DZAgtQ6ARH1jlqZ0eLPemXp3Ztcv+O+VNKMF8I1SC++JVKApBOjp44DrRqIq?=
 =?us-ascii?Q?qeQvsQg7vlMhiNqOo14GWR+L/6wwaoLCXho8eqY7p9fWLrkenYhKQtg9nqD4?=
 =?us-ascii?Q?wivSocpYtoMAsN+CJhT5zabXZFA/WcDk80w2CiwNs+zX6fxpyUac8YMMLfNR?=
 =?us-ascii?Q?PA7PGOHuiP88kyDk9SCDk9yU7Kwy+J4xmCy3j4+im9vwrUIOK/eat8rF67Ap?=
 =?us-ascii?Q?jWX/Splq0g+kwUkBdmRNN4Md6lvf4q7PRZYHqZ/LtPJ15dubLRfc/C/bu9wn?=
 =?us-ascii?Q?/8d/GuTjLjDNe1yL2R0U3iGItF4jgZofgveHSCJrs5EfivmNUP8qJcYgNb3Q?=
 =?us-ascii?Q?Z58dhwqjihklHQPi2qNXosTwW/AB4WNXJKGdxcrEmsyg81+t48yLZ3ayzAHz?=
 =?us-ascii?Q?6Ub5ZJO+MnSEEDkeRqmVMMVaegcKlb+3HYdaLnOS9J21abvsuisRy/IgW3xa?=
 =?us-ascii?Q?BypJywrKBZt6LAzSYCxoAXko436bAMt8JVrX41o+blF74JstYwDixE2vOXe5?=
 =?us-ascii?Q?5P1Vewg4pt5B6yn4mFm8XqJAjvZgCpV5Zw3RFTUAlun0QGH1wwmmkwm7QRtl?=
 =?us-ascii?Q?xWtm8o8gE0K9Hmx+Q8Ekyprb6m6eojEOkRQ7rx7NZlAd0qeCZpEMRTR4kbWy?=
 =?us-ascii?Q?eRkZiVzef7uEMmTANDmmG5DHEzhn0xnspHJLBkCZSrN4fyZBxjo+xVwagr+H?=
 =?us-ascii?Q?mVGCfQfnA8DhKBLtw7p5w2Up7M6XCWiEM2sTCl9ssWGNWSHL2bndj38x8PNV?=
 =?us-ascii?Q?HfZc/Kl0GJVn/xk564QcfnHLVSYp9gyzyH9JI6512PpgZjcpDfy2Xxr3TO/r?=
 =?us-ascii?Q?eeATWr7ch4/creAMVENNY2Xx19iULp/UhbYf9Da1Hrd6vqPywqb0Eegl1Lif?=
 =?us-ascii?Q?nZZYMAMUgC4KbOQ4qegA4seutPcg2MvtTFdNhbUKl1rqDhhv+4kZyFsDBMVi?=
 =?us-ascii?Q?nqFBa1XdBI6bZq4o03o3roqYgfaWP3+mk3Nr6Cr2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab212972-cbe5-44c2-5647-08db8399892a
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 12:06:06.0462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esbRtmEFffytEfB2mooOXyk14DcdEW7gFYBXaajHQFOWjgCVM9f+Bt9cY1WnibvncDLKNn+jzn7Oz2CO6AF3eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6757
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The d_hash_and_lookup() function returns error pointers or NULL.
Most incorrect error checks were fixed, but the one in int path_pts()
was forgotten.

Fixes: eedf265aa003 ("devpts: Make each mount of devpts an independent filesystem.")
Signed-off-by: Wang Ming <machel@vivo.com>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index e56ff39a79bc..2bae29ea52ff 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2890,7 +2890,7 @@ int path_pts(struct path *path)
 	dput(path->dentry);
 	path->dentry = parent;
 	child = d_hash_and_lookup(parent, &this);
-	if (!child)
+	if (IS_ERR_OR_NULL(child))
 		return -ENOENT;
 
 	path->dentry = child;
-- 
2.25.1

