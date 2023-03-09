Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38A96B2073
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 10:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjCIJo0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 04:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjCIJnz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:43:55 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2104.outbound.protection.outlook.com [40.107.117.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCB5E3CD5;
        Thu,  9 Mar 2023 01:43:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLyVhgFcZN/H8QaTyyUgMovYS3CoSVGE7uSfjQz/eCUx0aTRoSZvLBwDTs1Z1bhZzbPdZtr4WNisBmpEazb5qz8kwoPYNndWpWC9BZEmqbxqOuhMajJmAL0N6gM05VGshGrUWwZptpkE7Qh51+U1QEQ8hCEqVRsTtsiNAesFz+S1/z0Ne1zSAStNm82vfnFGgwvcGmpo82WQIpBFO2oIxhsoO4KnL8YtQmnqaI5ifmvvT/8+/9hny7yazMEsDPzCagoCDL9XYyawb3e0a5YHgsJGUP//ocdF9CmVnSxRwPdPJy6ZBaq4zCykeUwoIVzaHWrn5hYptwFL7/0UyXaJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxysiO7ajZ/V3IBHz9PgYX7dB+ccSu9ZXDYAdXCf31I=;
 b=LkuL9pVj6wgb6JZLwR+I1YbQWqcNm3KFeWfJRB71HU7mu/qXzobTzHKwLAgJSEGNUvTdvqb+4vKu8nHvJfwX5ex9acv7hYthAtNie53lu8KFhnwsC6uAMXbUgtd2de6QJ2/1aawq7c77Lm8JYROcRlwD9PbOScpzYoVX3UheNsvLTZAMHHwtFna8WtVq0CicR0KGSw9xEXytjrEZhdhA+GLREK4GY4J8vCWY3OrKyANqxKF8K4BbWsj/cV8sc1moFIghHKo4+tKTne7Nr/jdUD6yUUytsSwdLfOm6vL8lfNtFLALHyj6v4OVHm9iw0INr0m5B5i3Sq5euA59pBWkng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxysiO7ajZ/V3IBHz9PgYX7dB+ccSu9ZXDYAdXCf31I=;
 b=qVLkRYPxnscH8/tZ9Mcf/22D0DW3OvNwgvWJCqx+Z445TIsBxQLlxYORijv4Rtteu6NETeY5fYrOmL45lNfgaFp27DV0aDjtxXYxFh5mxPSJzVxUfC56Iz2VkiRjPCVSMFfhvjVRJXtcdAgRpp6x1rJNah9JjUcawdkiC0wviEzPi03qC4Ks0Yw0r4EtDV1SsjnFLdLSvOE1CtjEZ6WKy0VnWscav7tFoQCh51nGtoPhFMQKqY/FRk6iNK9BOt8Uuth+EQSpfkWuu6RLdnAbw962FIeKsgxNtJZ98F8pTBD8tCXf9jSCn1LpBAyfLtFCcyAKTUSMYyZkZwZ3/CPLKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
 by SI2PR06MB5412.apcprd06.prod.outlook.com (2603:1096:4:1ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Thu, 9 Mar
 2023 09:43:37 +0000
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190]) by TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190%2]) with mapi id 15.20.6156.028; Thu, 9 Mar 2023
 09:43:37 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 3/4] gfs2: convert to use i_blocksize_mask()
Date:   Thu,  9 Mar 2023 17:43:16 +0800
Message-Id: <20230309094317.69773-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230309094317.69773-1-frank.li@vivo.com>
References: <20230309094317.69773-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0035.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::22)
 To TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5275:EE_|SI2PR06MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb44c55-1250-4b6e-a1bd-08db2082c1c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZgK85Xs/qn79iTJ3559oP5DvbzxAaUrb0JNiAF5t8r4aAI5dmGXPu1AB/1k2sMa5e6YTeO6omL8zcB/QCBXdHRC4Lp9Ernpe62BXGj0ZF8TDFWygbVpOf+B6AquX4uAOeP5BMt8GROSLbY8kLPwT02uaI1VAFvT2zuK0lVQn0U0XZeFvzAjH2LfTbyFCaDElgQciLrre6faQnPl8lVwoqQf5p3KcSQ2yY2v+S7td2+qAqtf7qkFAXqbnTY7Nm1gNVMNesASgyo7dinkfzMNpJOHqgf3UUP+5kt7W5tRvWGaQywRIzZo0vQXAKHDkvqezjBM1pzGr2E9fBP5eKWVODfONHiPE9uf1hDCGct1kKLbUP1+4Y7AUQm+EGMe84yK/GRFDF6VNh4oa2cbChqo0S5ERj1p8RFv27OxIWrNS05x4/FtFHPDhUx7Ds6BW6YXvFRQNtHWZnADYGAnn1r11iLat3JB6xece/P7TELvqG42+cs5w4l9OBebxQz00MHybfBS/ByTEiLBDSuDEBMhq8Y3X/JdILNtSWI6FRJsGNfiURBULICt0MyYK9nDvVfhQUV52kATZu5ioBB5oNcSA/Kvl2NUjBK9TGhxywFZomIbMygadJEihN5PQaDrDqj16sdXRmg8NpF8oKvr1UP2KYrQ+nXe/sPRhT9z+0sLCx3JWzpDNG1vBUt1+igMYqru2Zh+L6EZSQVBsribsE1/fjeCy5QI3AiT05v6b73n9LGk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5275.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199018)(107886003)(6666004)(83380400001)(36756003)(478600001)(921005)(38350700002)(316002)(38100700002)(6486002)(2616005)(6512007)(52116002)(6506007)(186003)(26005)(1076003)(5660300002)(4744005)(7416002)(66476007)(66556008)(2906002)(8936002)(41300700001)(8676002)(4326008)(86362001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K+jLDIfmak5fUiEtamrAa133B3Ocl09F7d13JWK4V/bAgiMNIMVbTni8Tnnt?=
 =?us-ascii?Q?bPPwe620ISqLL01SP73yA0zkYuSMKWqE6UM+pa7Mnzv/rY1hXNYd+ZCkmqfF?=
 =?us-ascii?Q?jktIzCjQTLYpZZB2KpJNXDWGIjCmLDAjsedUZ9xDU0K8/uIwHmabM3H+Fcim?=
 =?us-ascii?Q?qsRnqQuVO9q3/kqoIPGKJpRICWYxcV+SjSQ1FX+SvcBarkSQwp1KIsG/g4gK?=
 =?us-ascii?Q?MFMe9BoTd4Z5/IJBayrZuLAhCXChuTpHw7qcPg9GYoIltsG51A6te1DlfFLa?=
 =?us-ascii?Q?UzGC+XYLG4AJfTY4rr/lex/WtPi4juXjjVZu8q7Na/cWXEj1TamuryGMRTDB?=
 =?us-ascii?Q?sehHyIBof0pK32VXoQN2aOeZBPw1aovktpOTSYpgnL8ncwa+3mefwAbzsuy+?=
 =?us-ascii?Q?tE91kXQdy/QnDISwsXYHG2Da6eRDX1Qajck9E7KWmzHJmqjXtmWKOKi6RhNh?=
 =?us-ascii?Q?TXfJASjd12mYkV4n/6QattnbzKjgEma3bYZKZ4MJefLD55ZEXdgoimHBaido?=
 =?us-ascii?Q?sqCy9QidJiIyCK722woDsEdUMWZ42t6y5ywe3uCSNM7bAVkN6Xcfncj1A7IX?=
 =?us-ascii?Q?dpy5oA185OHjWNbM27lkLB6SLcuVFIGG5WkmrP8FmTVrRXuBDXCVWiKJmdc7?=
 =?us-ascii?Q?++jql9Dnfu4KmrobL2orpbmIN97jQqZqs6qpv1s0GEEwlcCFctVQLFrn1PfW?=
 =?us-ascii?Q?5lblY8ivgqlzQXdyQxvbNJm8FyqE+7rFILEt+10rCBvpT0SCN3sYPkO5fXLD?=
 =?us-ascii?Q?KTkSZB1Eu9Cs99mUlU3z9dEGcWweq73wPp+sNyLcMTqHv7EQyP9jyTp9El4P?=
 =?us-ascii?Q?OOBdrdo+/n4ppqm0e5iVI8kXia268iDzSRp+CURQzIPBLHOBr9dqqM+Ydqj1?=
 =?us-ascii?Q?gbx4cxxUVXvMrKZIpd2Q+HqUPe7JQBMWIn4UYujxEsytLku3C8Uum5oBm4BQ?=
 =?us-ascii?Q?zjP4iHoFr9wxxQ/jaXLf+eufMSv2xUPoUA3KxZwms8zYKc5D8go4/iWQSWLX?=
 =?us-ascii?Q?jGoQPDlYmWWRZWzU6ik/qatfV9XQnSSZYg8yIVG29lnDovmKkL7+mn7zSvFT?=
 =?us-ascii?Q?1ffMKVCzGhZN0uJ3C47QurgSmjGVmIFTvhW32OVdqcWV81Xd5CeZTEvpnkBK?=
 =?us-ascii?Q?8CDoCu++kj8gcsmoLdniwQMxVtrKyzCfwCqLGLxiMPoRaWR+7M/JOqAhxuKX?=
 =?us-ascii?Q?4aYGVzAmY7ct1DnwW93jydLvcld5/OcZkMTGU9owEVJs6CxrVgeVInqIOoPU?=
 =?us-ascii?Q?RPnet1wLOF4GATJcoaUi2ZjjLIfApm35ueFhvUA9k7oz88+eFd5AIp8jeUoc?=
 =?us-ascii?Q?42Ir8s/HTXIx827Ww89VW/oDCJCtXi07PDSbA6DHnKCQ7pcTtramKQ5eS+QW?=
 =?us-ascii?Q?xWfHOPHdLvZqAno6DTYOD4edx2cf9bpnlKJP7K982HsP/d7roKQD16h+jE0y?=
 =?us-ascii?Q?+qr8VlJimixq0SUyFpsGvj9GehdvfGtmz1pCLjaKTnKz6a2vOWpHzHA9kld/?=
 =?us-ascii?Q?LdEAqorADv92j3C19Jj8VDpsYQR+wWifBRlMVC/wFbOQYbwy689JQcuutEpW?=
 =?us-ascii?Q?79x9v/bI9JvnzSHnBK1iIM1J//RyAwT2O4kRFCJr?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb44c55-1250-4b6e-a1bd-08db2082c1c5
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5275.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 09:43:37.3880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUbJMThK9/0Y5/1w0Kp2MLXdPUxUR6tNr8p6/f3tbF7DsJYvSdWaZxMVdqVNrfm9n6UgOd7C9+IU2L8H/inuxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5412
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use i_blocksize_mask() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/gfs2/bmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index eedf6926c652..d59f9b3f0b85 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -960,7 +960,7 @@ static struct folio *
 gfs2_iomap_get_folio(struct iomap_iter *iter, loff_t pos, unsigned len)
 {
 	struct inode *inode = iter->inode;
-	unsigned int blockmask = i_blocksize(inode) - 1;
+	unsigned int blockmask = i_blocksize_mask(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	unsigned int blocks;
 	struct folio *folio;
-- 
2.25.1

