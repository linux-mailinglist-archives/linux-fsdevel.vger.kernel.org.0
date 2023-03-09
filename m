Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD6A6B28A7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 16:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjCIPW0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 10:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjCIPWU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:22:20 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2100.outbound.protection.outlook.com [40.107.255.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABF5ED68D;
        Thu,  9 Mar 2023 07:22:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcE/kJOhXB5/1pcmhSTwMa833IWizB4BGSF1LfwQVo70NFrxvYYBuSEt4pyfvYG0TUtIz0sfJLaIjz6JsuI3fDM0AlX56wDcFqhPYKeR65U0ubfrhXfzKAyG7acBsnicfMjpAgu+ZrdQND+lHVaX0ygig8u1/RwAO1rJAwxkcXg70twWebrAhOc6NFzpQr+u4pzzygukujc5zHRLZ47PZUAOr5lFLUrJC2POc6Sf1iqd4d+9nrnOMxBs3naGiTCp2ufhi+xVX1cWnb1p1ZXtyx9iMTQUuNSXa8MgWGVLpryCaKTDp6ppq5/mpSZQj1s5E410JOdxZ/p6Pk8vTV++6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G74P5nAgOBnT3973GEAuaWOahRROTtd9l+A09L6rMFE=;
 b=P1X1yguHqbUjxZC3QWtYQ4aYSQCQieiQ4MH9oYVuT1iRnTsxUt3klB68e9qW7bSLx6sLHC8Kr5GlOUukPUMDKrXyuC6R5Q4m4I/H5+G7+p51nSBCSR58Sp2r6My0/ElIZC1e5/S1+fr5zQnTJEoBFiNlTOK0InHlpQAcq6UJjB2mUb+9ulAiZqQKf9ZA0gczBa03OZ17H0CpDH5nRa9CKEYe65ChhaZJCRKcQuiHUFKVw00RJeRKCVsampITeR8IZMg97MqXQSg7eJ2ZBTySKFIa2Azft9UNsxBgUU8VLvkn11s5OuvoHIEJgFSvdi7th67ozCMasEV81twc7a2Lkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G74P5nAgOBnT3973GEAuaWOahRROTtd9l+A09L6rMFE=;
 b=rAZE++Nip+T3xmn38Yj02pSeIhjtUtUNKbbaQq3fNVaeb7acz9fUbmqAtdWuGHhSCPNfciVwlP72UGZdUFIdEXPJydraUIgtjfVGeZTNEHs8Rk/y1atVqN+wC99w2am0WVnXyitLEQzQqR+XIO6E373/CUhKmkC2lTzquA66QtiMayyNRv8T+hrtjzG0j5eaFAtkyCa/SBmD1SVvtGZmYMI9M6IxjX+JHLToZM2XCLOGeG/WqPngz+hfKEDl1B3iE9/KZ41JaGqDwcre5R9BT4uru1YZRZC99h0LfunHdhFzfnYzK9WBeVv+XuwSLmROAUn1sKlJ+rKm6XuQIZkwwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4073.apcprd06.prod.outlook.com (2603:1096:4:f5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19; Thu, 9 Mar 2023 15:22:16 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 15:22:16 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
        mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v3 4/6] ext4: convert to use i_blockmask()
Date:   Thu,  9 Mar 2023 23:21:25 +0800
Message-Id: <20230309152127.41427-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230309152127.41427-1-frank.li@vivo.com>
References: <20230309152127.41427-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4073:EE_
X-MS-Office365-Filtering-Correlation-Id: 56a97193-f5e8-4681-cf1e-08db20b21104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: au3ShEGDkB+EJng6ExCV4irih+z00QukWDh7Spxuy8qWzB/QKoK+CueEysS5/nkcABEu97dp/Qs1ayTZzhXvAsz9S9kDnJ9o4/dHCcLL6dw9SPf5Hh4swt8uLkao+3K7S5wwcpy1DLk4a8xtZArks1bPI5ZMPJeW0haZ57YnTWB0rRqryMEVq6DbIVnurNfBzQ5icFtLdtShWGbEMV43vrusCNvgtnRmBgKF6hE3XyLcbLfKIsz37ZcF+EChLDwf4/OCehLxwb21SCfphgueLuG74tRWKFUvywa+oU7Eb2NTNexAR+jwYzyX6c2TgKlLPmcYXDhfrCPNyGCrLOKYBNV8vBQvl89aPYa11VAuphzsWWcAe+egWE0zTbt3mAlePpoWWA2I4ys5K53VJOnHNia/q3EEhKNoHwnkMvnJaeVvPZfvg67OqGMl6MW/k7DHEK1gKJCO1K3VpMU6myXOcx14YWnXy6dEDMHRGm5ZFsRO6qxOH68vNA9azbeqackX2YB5T3dDUXQXpt7zMIxD5dSwIr57AlU7zZOAkXqHSDFTkqplNXvSpouJkFeXEqKJKwxJTMDb9QxBnXUB5HpmxQ5vLnn0lKbzJEnhKhEDSf82myryXjrQACiQ8cK0HRXVJ/u6rOA3uUeChqurd2UW+Q/cDRvDtN80GGof5sWWSigsnvE1Dy9RKEZpexV8NKFBT+96mHy47d1TUq+CaobJj7utACDMN30INvL0eQEUUsM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199018)(316002)(36756003)(921005)(86362001)(38350700002)(38100700002)(1076003)(6506007)(26005)(107886003)(6512007)(83380400001)(6666004)(186003)(2616005)(8936002)(5660300002)(6486002)(478600001)(7416002)(52116002)(41300700001)(4744005)(66946007)(2906002)(66556008)(8676002)(4326008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J6UAysLpoBieQVl74u8AD7N6g9pZBKiK9aoHlx5UOs8MzLg5kLQAIpekTjxX?=
 =?us-ascii?Q?4lkJHJycoA2byXmMFtjX2TsjltV0IDzQrko1CniKcojXQZ+v2TrQmQysu0lt?=
 =?us-ascii?Q?zdXL8ljZdkocXRUHm/+ybfnnKpgETDprT1p9VBnwxemoD5uLM8RECM+N8sZ5?=
 =?us-ascii?Q?naSyUzw+A8oLwjmvMA/eiWRruB22HXVEjR3bTi/lcrIiNR5vtnJAZS5t2xsZ?=
 =?us-ascii?Q?g3Za3gWYHxwYvnRMG/yi3P1AhGdMqWpUPVzL0sGlRQ4vQ/PQBmT2GUlCRh+G?=
 =?us-ascii?Q?A+cL0oyZJbxlAAwYiDwhDCu0UafTHkL9xs7O8nZoHsl2QRl+jujqRUWVIG42?=
 =?us-ascii?Q?XRHOU9qKKNoKQZG5wVXDTzcqanWuFBB7raXymFm0c/OoJ3Kd6Z5p8XiPLHj9?=
 =?us-ascii?Q?LH9eaC2twO/OKmSW51mhB54DkGDeaWFLZqBj38Xx3TdzJb7Cn7tF5guYOAXM?=
 =?us-ascii?Q?IgvAhDov3z8cLHwf4CWji9dzPEQriP4nzkp1N95//+/jpPenjCkF1kSz1Mjx?=
 =?us-ascii?Q?sMATQ7yfA+EBdy8GkcMcCH3HMiOjJZccNIC5JpYxKHvq0PUVTcVcvfPytpPc?=
 =?us-ascii?Q?0HktKrFa7QZskRqQYW6g3bovglr2xxcyu6z0ICD6EldkLMCYdO4vAraojnLG?=
 =?us-ascii?Q?49+FLyfnDY/MevPee1VucvV8IyflvFHGBdzNExocAcVb8zsKQzmDSd6GECRF?=
 =?us-ascii?Q?+l7RwdXSKiJS3XBNs+5JpPU4Q6tQSboOCFBtrDsQs1YxmzNyh2lbHkmINO8q?=
 =?us-ascii?Q?zLygGxfx9I6LoOdHuSZS8zP15AiGVP+WAR+XunpUFlIGjOtR7O+9zXE8G/vC?=
 =?us-ascii?Q?GA/6/VN3h06M/c3SAbViv49673AZkrR+lz8s13DFp2wNNb1xKH2IFYdvoZsY?=
 =?us-ascii?Q?1aK8DODNZgrcyZ3OlQ8Ds6hL43wzmloQ8POFYZORU76s8qjE/BJxMXzU0FmA?=
 =?us-ascii?Q?ipxJ5xdsvp0BL5j5idevrrzlB8x6ECMKVY//n+MaxbJbsFm3b4bBYqYS570X?=
 =?us-ascii?Q?7nkjw6UB5+mwdst05L4wRyJb3NZdfLETRhPX+AeNQB6VtC12p9L/tbcFW3e9?=
 =?us-ascii?Q?6ZLl4BZUf5G5wtjAzEfcGXs8kof5NnwBllBj0eXjPZXYUk1RV56BD9RzUC+5?=
 =?us-ascii?Q?PBkY0fi6uZ7Iiis3nwEfZEfG1BynaQ58PRRALgKZZmaQ+IwMSO7ZRM8aBhR/?=
 =?us-ascii?Q?PVm3f11wFnYJXlkcP+SLUIMEZddiGZtu1R4noim9VD0i1NORnPcq40+XOzKI?=
 =?us-ascii?Q?Dox9R3kiUx1O/r49xPnUCBcnGjxlChXnd/NJLAxIizoHT+bFdVp+ZKBfc8Ks?=
 =?us-ascii?Q?Xg65Zui7vsYSmzn1rbWmPUgD21S1ab33ztL3fOsc88aUqYm/Z4V+A/DIjSyy?=
 =?us-ascii?Q?7fWgSrwQVmsVwItUsU6v5AOMTSHiiZPME3doyCBxlVFwF3/m8L905Shz1ViG?=
 =?us-ascii?Q?PUB9P6k7J85M6sYM++MuTYjzZd1nB2kfmRN+dL3OAwlAHyfPv3eSHnYzq+IU?=
 =?us-ascii?Q?KxfuPhjA0JMFnciEOGmmBvrX7K9AAf+3b12H6LUMdpFjVEiMj2gVyrZtvXG7?=
 =?us-ascii?Q?c0xlQiWx1yN5eil2jKEmXjrQY2L8XQIegV7cGVmF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a97193-f5e8-4681-cf1e-08db20b21104
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 15:22:16.7352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: faSx+15nOOVnxKx09cjuIr/fJZJg5x4PEYIAtclVHogsw9WqPzeR+hciF7EE/sTXuOlHCF7Jw70/lfFxIfKYDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4073
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use i_blockmask() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v3:
-none
v2:
-convert to i_blockmask()
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d251d705c276..eec36520e5e9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2218,7 +2218,7 @@ static int mpage_process_page_bufs(struct mpage_da_data *mpd,
 {
 	struct inode *inode = mpd->inode;
 	int err;
-	ext4_lblk_t blocks = (i_size_read(inode) + i_blocksize(inode) - 1)
+	ext4_lblk_t blocks = (i_size_read(inode) + i_blockmask(inode))
 							>> inode->i_blkbits;
 
 	if (ext4_verity_in_progress(inode))
-- 
2.25.1

