Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9981962E3A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 18:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbiKQR5l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 12:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiKQR5j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:57:39 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2118.outbound.protection.outlook.com [40.107.255.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D097FF21;
        Thu, 17 Nov 2022 09:57:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MExb9NUYOiLVtkvpgRL0jDXIZVUzKy13B6flGQJdJAOmC2FHFFjSEzps956oPT7zMDJLWRZupE1vkn1Wzs26QbZfKm6/dNWmEtqHCFruB/omjb03FpyPUdnhbWKfBM4YQWmnqZYEQ/FeFZps1ax/BCV3tRcDUlj9/CZhxc6CucZW9jHcQMeyI1zjmP7IDNxozaQMkXHLB/HJk/St93yquHzNbbQtZrBklNaP+e/veo+pOrKpNk+IVSvhvyVcyL682TeDtclzSiBF3JP6mBek0qDlmEkfvrcTN8sqoF7VnFiXprAxvBj9P7sVOmIrC/GrVywwMxE8hBAZ6qbVlrxFZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJpm3My5XEpsBT4vwPpvfDxy4C16oIzqdtmGMAXcu94=;
 b=FOrPBlXIckI7EAR7H87rOFpim9U8x93dTSW4z2cjbGWF2WN07gW5s99iGYNleXQuWM7hMbWiDENY+wwM+VwzngqmCSRW0fLHTsRReyPmWH7wYKKMJWXp/gtLG4ZqJa9tOR8sWVSljSm2vbaZ9BfDMScJcTHcQ5bRSs0viAHYqrrCEqglNogWJR2247TZQoCQcKlzKlMKO/95+R0y5qzdtVfq3mg51exdfXmLmXJb5r+m94E0Nhj97L/jgUgIdhc/hSTqRo/MMPodjOA2+VuZL9i9m+I+FYTt010MNqnHuzeQCQARCeSBLPG/tBne/D+lSNrWTHc3t61Z39NKF44nTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJpm3My5XEpsBT4vwPpvfDxy4C16oIzqdtmGMAXcu94=;
 b=Lgx01JA8XZbgEfQFhMCpLo9s5BsLNbP+LU5/f2/tWmd+WN051JeGfJLG40EV6r2igXy7MEeJ4Sd+4ui5lX2xdUrXVDiyReGxtv2fqr3839hgyw2iR0knLDpBHkY0EwAm7kKPeKU3ZTdtAg1KuWEE1zdeEh8MiOG9/i/VLJU+nCMy+BYMAGqgYcE/dpy1JUSyeNZ28YKITxsyzdiqD+E6HHAyy6WEjIdh9e+477dNWXRfqW8av3C9tSBmxHabafFUjrv+OlryyKEfOeZQewMBmrHIWxXMGRTr/fzvcSPRcR0scUa7ZlFvfPsNUS3kVaAa7rY7LMEqbNJdjh4zAKjySw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5278.apcprd06.prod.outlook.com (2603:1096:101:83::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Thu, 17 Nov
 2022 17:57:36 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::1230:5f04:fe98:d139]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::1230:5f04:fe98:d139%9]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 17:57:36 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     frank.li@vivo.com
Cc:     code@tyhicks.com, ecryptfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ecryptfs: make splice write available again
Date:   Fri, 18 Nov 2022 01:57:27 +0800
Message-Id: <20221117175727.40730-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220831033505.23178-1-frank.li@vivo.com>
References: <20220831033505.23178-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::30)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5278:EE_
X-MS-Office365-Filtering-Correlation-Id: c5ea9b31-b1f3-4839-bfeb-08dac8c535db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1rr18lErveFG6jN+M49A4gS8FdvUMMoCFwY8GYRoyxR99w9uodY6i6D9IKJR/lFtcnBqRIJhfbU9A/GdFDahxcSSEJoStPr842T+LZCcJ3T+f63NiOSHZuSpdfERmo+a7rGIJts7ISOe0yaym0O2BsLIZHoi2mAgE+49DA8YKn0/socUWwG+A9t/nHrW/hXDloFYifdx+y0+bQDuaqnfBZqSz6imqYU8QjiCjPZQgyEtYRdJrxE9m7D9qe+u1L7CLn88tZCuMjTkJpMJwfSoNuyKhXpojVoVpYfqHotJV8rQsIoCZt8DAkWFLlKscw8xWYv2Ufqjeg8AMsO7FP8R+56yU0sLvxfVDRP3bjBTpQxUt6X8Yxl24sQdaGWqJPHQVE6svmYIzPl8uflkST/ORTWwycvanYWzPhT9BcAUH1GgD7aQ8ksmDm5kML4PPgcvG86Rc0NpMDB42NKpyZR0LR9v/Ch9WEDBIz/u1WCMnLa4QFdobQkQjNyu46exOznXMYb+ivZP8QOw/UauTWjDC7ipRLdNjyc8bkbm6BT2yOqh7RiEcEIlH4MgS+NW6S9z5vFKy+U7N7rOaUj0RODMbb5mVVksxa5Sl2PQWfmXPA9/cTnpfjjcPBtCm2O3QeR4Lr9aHj42rf6DxP9YTHPD+hfbmTX7Rh63dPcEI3BTMUCv1sF4y3XM7HgxWeN84YiQVRYFRieHFtuA+0GSxdrdcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199015)(66556008)(6666004)(478600001)(6486002)(37006003)(34206002)(8936002)(5660300002)(316002)(66476007)(1076003)(6506007)(36756003)(41300700001)(52116002)(2616005)(2906002)(4326008)(26005)(6512007)(8676002)(66946007)(186003)(558084003)(38100700002)(38350700002)(86362001)(131093003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TZ7Ur3TbxqPjcEHLKeMSqlKtGktYanZj/oBb6GrBDuH45kZU+M32TlZTdaI0?=
 =?us-ascii?Q?XRS4JrxyUXh2xeUsgToeLIOPHJggz4ZySpeVVrW1EMsStwJQIhmQM8BNNB6F?=
 =?us-ascii?Q?qp/Xu8XgmzPw+OUlawcurRH/gwje368tDIR7d9DYCbOith6/4PE+Vb2mxUso?=
 =?us-ascii?Q?70YJ3Pxbdfc43AM7jlHU3FJXy2BV932NwBlo32k3gTss5W06VXVyQPT0niMg?=
 =?us-ascii?Q?7vtGvpVJ3TL9GlrT9zwp5wN/HL9hA4NXsw8g0mfH6KoYtO1CmmMRgrQ4nlBF?=
 =?us-ascii?Q?kSQQfJAMo6snOaPII9jvVfA96o4+2j7iRbqQvKgZZnNood4D9RMzJz/WYOWe?=
 =?us-ascii?Q?6xxKbsh5HLpJItB/BdcmFaQQjE5kYmt+3qnC2W8kDBt3i3vuADCoiEcZ7ZzH?=
 =?us-ascii?Q?cjFezjQIjMDeqNEjKelZ7HTyeIUulTwfB6TlEB1AkhOo01GatndYrz0lVIV3?=
 =?us-ascii?Q?Wy8XAwD/gFrly4OoFGhrj9zyBj9HxF5DXqB+2MSSNyLSS/MPN6Jv11SoTeV2?=
 =?us-ascii?Q?09aPVXAtEKUlbR/fgW2H3gNizgKvrr0uuMBpEdYHqC2uFpDBT6fCqCb6ZuYI?=
 =?us-ascii?Q?jIFA91anBUtsppERYVjDFyAI5lK7VjIrZAdE0TR6xFleSLk/N224WpPFw5LF?=
 =?us-ascii?Q?nkG9WPBwewJlCIZiXTP7sPhOeqqNjhql5O6YNqL/psufVvI6LGny6LXB0rHl?=
 =?us-ascii?Q?1STnR+mkqHr5VqXci0Dxt+ISXZuSzNp9rMe0ota5+9en2RczEUKl374t3g9k?=
 =?us-ascii?Q?r7jr1jrKC/xScORnQjNErXW7fRksiZ7ud4htAIDmFg+/BRf6M6FLUj4SYSZ8?=
 =?us-ascii?Q?mgOiJ03G6JtXZOzqgU9KjXv5fPOe6ef/wnTcf7aZ7uofN0oc0+pOtO7RVZmJ?=
 =?us-ascii?Q?9lMAqQ07nVN3Op553yfPRsjU0ddqN9dFP4uCvhZruv7giKySongoGd3T9RgT?=
 =?us-ascii?Q?mv8QXDrBf0tI+amVlXOgFTIio7r3okAtqS9V6j8YpbG+WEo6tp0KaEaMw0Bj?=
 =?us-ascii?Q?ZvCdkIkHXeqllzK0fvrCaHvmTlJQxjSS8h1ke+Ilu7Xxh7jK5qYqIwixcyEN?=
 =?us-ascii?Q?WG1Yi534ybXU9rWsyfd/mGXAxVwkn5MFJgeJ4m5nI5FVCmkCJRurgYY41zx2?=
 =?us-ascii?Q?7ro0tyJL1wFcaffWf1fftnO8iyqtGWfVLZ9BQ50cvCPw9DaZ3jwbPYa/Bwsk?=
 =?us-ascii?Q?8c4OXb0MZrmhuy4BaVhmP9nTVyDXC/D1icRi9NjhQEi0t2l0mSaxxpYdheFQ?=
 =?us-ascii?Q?YlNy868kQeuNX8m6PZDOOX3vUGuXNCCsSutSTYjvu5wRAnWKMdJhjeC7bGeR?=
 =?us-ascii?Q?KznEQgwRLcSrra/sfMdH0pd11W25AoRlffH0V4+HIJd4f7mAPrAprUpVByvu?=
 =?us-ascii?Q?lWRP0OsTr4EbDcwVjRGkGO5XjYuDSUFiGcYWx4dXRpTeffTH7epWP4aaYej+?=
 =?us-ascii?Q?I5GaEYY6sYK5GSbRyip2+F3RDy9lgSWxgdEH8TLBBhtHIpfH8JcE42th5BJm?=
 =?us-ascii?Q?Zne1spekc9B0/AXyU6ApCAo9J0KqHqLGSmL1WBsdnHs+8CeaOtiIKKXJS9dL?=
 =?us-ascii?Q?M4yhMosRMrLpYGdkMeObWj3PMjXshsOILwLvz2O7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ea9b31-b1f3-4839-bfeb-08dac8c535db
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 17:57:36.6409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lf8Gx6Jq9+LkD9KPmf9KIncwkXxGAsxtCKyZeCUj1Uq1lhCmUNsaKu/JCsgVx8P/x+k/x2qe/UCKwuV+TXCBqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5278
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping......

Does anyone maintain this file system?

Thx,
Yangtao
