Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1CA6DA209
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 21:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238521AbjDFT4c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 15:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjDFT4b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:56:31 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2117.outbound.protection.outlook.com [40.107.255.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA9559DA;
        Thu,  6 Apr 2023 12:56:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKkmi+o8MqEiMj1X1raIGMnqXyMydzsRzVZWyv2VICJ9C8mThvskQmjnF1TyxA7oJ6SZisIwEm3n7FYQZ+XIyiTpiY8jV/aAo7ldVQN50/9S9/42A1JBndnCybaYKPQK98KioYJ5NYHX5oGHfeLMjhCXuIz+Vh49pyopjeKs+h0tsB9njy9QEmNYV3yKMAXlgvtlzAEfb1ObwgRpyz8DylNj7Uh3zKeKZM1D5Q3DRRjjbN5eDza4wZMkpJLBZXJSY8Wry5kAlFFnvaqWL3pSsfNYr9em41g7lWujl6sMVN4Zsaf71JYpVCqRyJq49Mu/QuM7Yx3TJ5YgitV3AO7IyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXmQxOot3aCL7XsLFjpzed5PqSudv0GqRFmxBrKacLE=;
 b=hPzzeeBdRcTC1SQKPmyb+2E30xZOCt4Qtvksj/wjDtMdtt5o7ujyYNQUwPg3KWSJqZJxepUkSrL3QDbZtq03EH7+CBztHwgnFVd8Y9CAOxajVKUWealUojl68n4TbG00rc4KHSuSkL5DwDw2adDGWD51ZNy3GUH4z2pHJDFOT+DXfDCMLHMc6cUUNrJJYSS3unW1leILHPG9WGVAGInwlY4N/b+4YRQo6qeUq+XPQRYOZoe0j4HG+cLNPIQ4KEdD9eCfMvfsQnV9lMWNUeEsAH/Kl2kvCA1KjObdaxTjKSZmXFc2KAn5z6lNAjVTIoB6HikmMThPciPcdycz5sFDYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXmQxOot3aCL7XsLFjpzed5PqSudv0GqRFmxBrKacLE=;
 b=aysE9ek0AiRPHRI7fopj5dOPKs1Rro66fj4Vr/D91rej6LUUbPLrKsHVIalbc1c/v2jHlf+o2dFvpzS1O6e+dHjESpqlMI+/TllVidqoulmStIfQzxuGPHoXympxMDlVkhXa66DWttH5SJBCD7zAY3hu8TlaM9e04BurWDZGqrdEr38iswfdJItD4kck2Stg+cMEA5SDOMFXa/daOnORcDJa6Zujz0pgUoYAxXEIs9G2kghp9z2NTucrhdNyExaszTDSbsaaKnCyD42r3DD0r4VULWbddWBNlNoDmt+wkmrkvOne+tneL/DKdIUqjtzGjx72QTLqOEv95N6gx6+3tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4096.apcprd06.prod.outlook.com (2603:1096:400:2e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 19:56:24 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 19:56:24 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: remove unnecessary goto
Date:   Fri,  7 Apr 2023 03:56:14 +0800
Message-Id: <20230406195615.80078-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:4:186::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB4096:EE_
X-MS-Office365-Filtering-Correlation-Id: 960a1e1f-7d99-4868-e70e-08db36d90018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1JGCY2PynznpqEU0ugIa7Pit/VYF7y9b+PgoKJrs+bqlMwMsH2N9kEpJJGrIA44SC+nGOp6MDdppnGrIwX5+glDsSYeSBCXcGSuZBif1QErttjtyTZbpKiJHX1JhipgRFdpriEYO0gk9z1liP8ICg1kItCWxhlsgMbEGDKU5ZRFUf1AlN6V4+FxIorwq6ksgWgZ883Mb1nnb7+VHFlpt8viIU3w7d8oVyXrzH3E6yWyqfcI7k5IAeRnZhJ70RrzB99d0sRHxiks6H/ziStrEucfJNYZaBybTtP3adhQtoutz7zCFcAIM7VSKkQYLOixOGtUdfwDsfsVGvEgvYO2GyfHfQOkVPQjSIv29KqecexHQ/M8+O1HZ9e+z57MJZ3LLDIyjgicqm51CpmWnvD6zq3Foj5cua7i3kqZSoRGGMKeCFTo1+Rv1RN1dCxOa/3QNcLbO6frW2KeCkWEHtAcKSexfa0SzQluVd7fgHHfrQsnh8eV6k9PzmxeBkAvE3MqNla+ECEL1W6n2n+1qWBo1MbB2s1bM8zYzHFBqXBTZ3aJWoAZAWNE7I6uNgvip+9yu4ZcTu8KKtEtnA/KKkmgWnzWzTLZ727szTbmzryffJVkC4WqbjoJc0AQD2s0Ornbg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(4326008)(6916009)(66946007)(66476007)(66556008)(8676002)(41300700001)(38100700002)(5660300002)(316002)(38350700002)(8936002)(186003)(83380400001)(6486002)(478600001)(6666004)(52116002)(26005)(6506007)(1076003)(6512007)(2616005)(86362001)(2906002)(36756003)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8YyNchpEqatLT4+jyWcILgGs/BXnpIEjbXTemiCKEEjcoXkbCuTdHOEGOpZv?=
 =?us-ascii?Q?RUR3950+AzTNRVBPcxCDbwHRlO0vtzj4DThuUAgMHDscT/gKwJZCMWlEAKf7?=
 =?us-ascii?Q?n0DmRwn1xipjPXoe7hXaP09rb0GSxsZyvOkaq8hPhvCnLB5nvuqANYX7x2KI?=
 =?us-ascii?Q?mt8xubrWnCMPP8JNNfVf+6giwBzWxQ3StjL/DEJ37SUX88TP101jDXT79dwB?=
 =?us-ascii?Q?nZ03wmb8xdyTVZj7v0IYGUBwu2GkLrX9+jpozrP7fvy2Z4oZe37BgTff8Xnz?=
 =?us-ascii?Q?88ced9OstmX/vISG1dJpV3lpLNttMQuV6Ebrpvm+5jX8kP3Ef87lA6zq3opT?=
 =?us-ascii?Q?RSp5oFBW2LcEH6GsgQx6VC+LjyDeDPfvl482b3l+z/UyuxAPiEzxUYOCzkAz?=
 =?us-ascii?Q?/2Q/eHELfqacwvPrWcVqeq+1ugcvZmh0yNX66SYdMqhafnmxMNheIEsGIwaM?=
 =?us-ascii?Q?ujE78JH5Amr8eRBvXh6Nm3Fae0XAEY+IUr/zWmfnIk9N/1CPto2AAPwWR2wY?=
 =?us-ascii?Q?mG5wIIymrB7pz0j/XAsicbEvfoQU4zzZuOibRL1WRi/E3QjAj2pqiXXe+wey?=
 =?us-ascii?Q?2tvLyzDZUa+/cUShLgB7sQxknPgta4Pj6DNLhn6TH7/swF2gdDLvcLkiP1na?=
 =?us-ascii?Q?jW4l11Wc9RcWHBxfRH530IrWE9fSJ5zJuRRo4E7x3Mvaa04rM/uUWXFqrtJJ?=
 =?us-ascii?Q?ENyr7bm7eS1IJ1Amv8e1nivQKSJavXraTzYrDZM7vrE4M/A8on5LFxqWD2BU?=
 =?us-ascii?Q?nuGcSozRg3myv6oGKM215YCZvMki5Dt3i/dEMZxB+bnVGHxQkfCRGo8rK2w/?=
 =?us-ascii?Q?LMndaRxomf16DkcWIX3KzS6zxWf+bfFxXK/yfZTIVMqcKFqQqgqdSGRyn3Ft?=
 =?us-ascii?Q?/4e+Nn6PAl6NdXzpkjDs0zojyVmhuhRaZ/mrURRJ5prZalbp6b+qhtvQj8JO?=
 =?us-ascii?Q?ZRD+Cw6YHq243ExtKB8xoptp2SiM3by7N0C/WWMN62UkDatuwV+BgpjrldEd?=
 =?us-ascii?Q?uXUECsLbdWt+4V9W2GhPB04WLzcAi5sji//jmMSAq1jX7b21BINfbwWRK1B2?=
 =?us-ascii?Q?o/+3/6AEKSQYZZQ6t7cC4ieSLOwd//ZTdQyvJbrPc9VWRL4HPTNi7S+4iY4/?=
 =?us-ascii?Q?44xOMpkBXdBpxfvFVdq1ygV8TEmYnFQEEX+FXaiIDApBv1/qtdhOR5t6bzFs?=
 =?us-ascii?Q?q9WW1QDGzTSh/d/czD4K4DbRpjXeT5SZLQjcITa+y5WY99lkI1kPluQsFb/z?=
 =?us-ascii?Q?Nv5jlP3Z/b4l/Vj65chhDIFO6LCpVnBaMZ+nhe6GF9F+lmdoltjeSWhOlETj?=
 =?us-ascii?Q?tDKjW0u+iVdB9giqsQ0bw+D63FLSIYCM5qfOoIoIcTUYrhLHBvylwNzoeX58?=
 =?us-ascii?Q?v0jdI2XY3Re6PYDbPqd/34p7FIL9UK3UVAJcj/vXAiq1A4NbGqKmx1YwvFSK?=
 =?us-ascii?Q?NZXNdUVu2RJaExbuHn5Wrh2UUk4odGTpoRIP4EyTrceZE2kbQQW5z6VliMLb?=
 =?us-ascii?Q?NfdHWrQt+3XkrubScio/cbeN/uC+/16DgLGs/fs1HWN7HIPlcx98n6rhwbLL?=
 =?us-ascii?Q?BDh1Ei9tgb7NsF1GFeEAWpxrSQT/omo6Ryf4emHt?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 960a1e1f-7d99-4868-e70e-08db36d90018
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 19:56:24.2454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: caNJ41wheWruP/HYN7YTjdRt5ycbBLiygHbpycYiZVTfjD4iAHMDiYUNv/nSkTeUbTQporybWHj9tjWuKsDFaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4096
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In this case, the error code can be returned directly.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/fuse/inode.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d66070af145d..56efcf160513 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1921,10 +1921,8 @@ static int fuse_sysfs_init(void)
 	int err;
 
 	fuse_kobj = kobject_create_and_add("fuse", fs_kobj);
-	if (!fuse_kobj) {
-		err = -ENOMEM;
-		goto out_err;
-	}
+	if (!fuse_kobj)
+		return -ENOMEM;
 
 	err = sysfs_create_mount_point(fuse_kobj, "connections");
 	if (err)
@@ -1934,7 +1932,6 @@ static int fuse_sysfs_init(void)
 
  out_fuse_unregister:
 	kobject_put(fuse_kobj);
- out_err:
 	return err;
 }
 
-- 
2.35.1

