Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE568740D70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 11:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjF1Jru (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 05:47:50 -0400
Received: from mail-sgaapc01on2097.outbound.protection.outlook.com ([40.107.215.97]:47553
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236097AbjF1Jhn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:37:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/r8+7mhTV0OQWmUToeNm5cHfYcLw2p5eNZepkxYALGGiarce9eV5AQNjIzWkFpl2tLWKCoq7XwMy7twyAgfp4oN979AA5wVFx+OARvSdoc5eC7/IOC2azFVSWhWtWAM75g6mXPAv80C//J26D1DgAa1NMRe6szIFqCmQ0eBpZCrsHQvdnDwTXWXP+KCswOpu62mf9LihN3f/m29kpYdSkpt4KtXzscaNDT9zdivNXhVlMnT1m+48k2DKUWCl3aiPfdGOI6+4bR50WacBq7EgXmCNv7fci2d3qACjwTgjCHVdfOhUve8iNZFuw/gqo10iCOVTMh7Kz9L6Rauobd5vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsL2UGvM+v2DmEyeq03rERsDBc1tSyqKLDxIerRuBTI=;
 b=T01/eCWiRYaJIYiXHPXAMm5DGfuD6uT02KJ2arCuiA9EX9u/88TAh0g33vZDG2/6lh/3kP52FlEI72wqmg8QvTBXN7kTe/Z+jv7A5b6+aNNGsVY0s1i8RGTYXznmh2vHk6153wgIenxwoc2n/Ql+D65Aam0eQ4mk/hTgqTbRmA9btunWACZKeuJyrQLXUIWabAZ0/vzLKNN/SO/21DHPZ2NS4dIbVqpNazySbFBUFvN7oCOMte8xQTZVQ5NFePLUWdRCpDf/Ljq+nPjGEqk8HzpslO/iMwyAfQ5oH18ToLDqCAAdJV9RVtrQLbeDeNW18x8+csZcJcvspNFArRxYWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsL2UGvM+v2DmEyeq03rERsDBc1tSyqKLDxIerRuBTI=;
 b=WfnlZPWs2DpE/88ZHduXwmEwngqB9t+5mX6gJP1tzKB2d3auxB83lkoRKclfY5MO78bF+GhfdCQ1V1v/ug7tlovv4XEoGmP6RLEonJE3RSYh+Fr2gbFM7mmCPWj4Gd69oRgNiF9QIT4UULx+YCwZv5cBHebq37aEtDmEg5uKWn2M7XcHuvBQfO9PZN3c3Pivtmy48zcjgUU+rYXkjToHP0Ex1ZJqK0BG12BzEDtHVBA0lA9isNrge7PIwbvNZF741SIUdAS6himb4g/eI32Lg1ba2j7yTsilnflgVh+Ak3Zqgx7SVnC6vQX0ryvhK5hlGmyqAL7k5DtjKVZgt92SYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6144.apcprd06.prod.outlook.com (2603:1096:400:341::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 09:35:37 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 09:35:37 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     axboe@kernel.dk, song@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com, hch@infradead.org,
        djwong@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org,
        Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 7/7] erofs: Convert to bdev_logical_block_mask()
Date:   Wed, 28 Jun 2023 17:35:00 +0800
Message-Id: <20230628093500.68779-7-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230628093500.68779-1-frank.li@vivo.com>
References: <20230628093500.68779-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: ad1bafaf-53e0-431b-6bbf-08db77bb0764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GUrSj9uGwKNuLk+cDNMGOs6EcgJe+4LGGZeuvPeJtu1fBHeGPfsLCCSCP+unFNSI9jfFMpGiNG7Vo0nOaxaCRNiSGfVLdC88EnMmxmWDOKQhKAs3feLhzDxIqxLye+U2KVQ6xH/KL7rzQt7TmVtXcvq5l0SKdvyrayqjLs5XkjrNKpL72a++JniCLHqSkYbWKcknFX8foL8NAWDAHWH6lYvWlCC06JXwlpD9T213Wh+50G1U79AaFtnnZOsE8Xm6hN1kiXiWRvuKr6ruLh7+KMVVy0rTf7W3fo4nT1BTQNZhjL27sAkV2bbQRjrJ7nqm38jnzL5r68n4LgGl779oeUfPUCKUQSe9qOtfEyf/lHkIvNZHs8uClkgFIMfMuIL4qQFQ05XGt/5hXuc7cLJovUnirryqWrxAvzrJ1JKzYrR59cTWCP4fl7iJVmJwyD73iBAdP49izWROPEEi8c0RDh0WioagUZbzYRbFBMK2oPKp/SBdjRVfvzr2BKMGFVuoNANgA8Dr4H53+532VlYnBv4xCa3XWIwQp5bAbn2w6u+VDfWn0qVE11AoGqOu62ZRmwFyhT6Jr56s3eQ0Fm3Mt+3T5jeOKRrPY3mg6UzyZg5CW5mtJXXkIUYHn9OoZ8Gx30i+9G51lE86cQ1BuVspxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39850400004)(376002)(366004)(136003)(451199021)(1076003)(6506007)(7416002)(5660300002)(66556008)(316002)(66946007)(36756003)(478600001)(4326008)(66476007)(8676002)(8936002)(86362001)(4744005)(2906002)(6512007)(26005)(41300700001)(6666004)(6486002)(52116002)(186003)(107886003)(38350700002)(38100700002)(921005)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cptW0/GIcoLqv+v1laDFgdSiMcYeUi82qxSJ42wyjYT4Fp0WAaaMTfBAjsBV?=
 =?us-ascii?Q?t94tSshPsoAR8Z8HiF+F2qefUCbualAs7u2YdFVgSyGELYc+6XjZl0St2hGs?=
 =?us-ascii?Q?hXNOQf1ndZ5bkmEYL6OjwtL394bKbaPibfyQnYpXLzpusN0kW6t1rZ1DLlzn?=
 =?us-ascii?Q?LxlBo4RTUMf176c66gBG4u4bNuP66ZL9LQeaSLyxRPUNF/imK1rQgw9vEQ5w?=
 =?us-ascii?Q?YA3uAT1uz78xfHLzx+XMcj2aSYhXjV1KYBVbD6FeArkyjCwYWbW+d1/aFV31?=
 =?us-ascii?Q?AymHLn6I8rJvHxkn1G/yMAM3QZAdoFwzDuaUx51smVL9f/0lpC7G8TSpjIXR?=
 =?us-ascii?Q?AOFPFg+MxDqiDQB+Umt7kdwoZUiN+1lc2SKS+quNaxb0RV4M7x5HdRkELAcs?=
 =?us-ascii?Q?HYab+nF5HpaHX2k8lobufdxFTyZx92zMlj7V0QxjrbrZDEBZkHmUA/iYh/W1?=
 =?us-ascii?Q?9gsB7RHkc8MN+q4cDFQhyQCdtcPR3pjjFsowEB1if/is3Jxk435npy8jEN3a?=
 =?us-ascii?Q?wxyCefYW6//OEJpufx7IK0Fu4VyLWcY7s+5MKlfpC6LJCNslkgmkGQQFHMI+?=
 =?us-ascii?Q?5iE/H1AoaMoQWdRNkHN5Jp0uINX8HdHm665JC1NeIXayXChWlQik1M7Posi1?=
 =?us-ascii?Q?3uN6PjUZutfiZHpqBrzokaeG0+HP0ZhUjNVIt6zW0lfBhnCBaS36YWawH+rV?=
 =?us-ascii?Q?Py6uw0IQc0Xr6ZdfAr2KuSMenoMaadAMOJyVM9O0RvpSEQLPpzHvraSO2MKx?=
 =?us-ascii?Q?0TG627ziaLnBIECw5HLSp2B2EErcg32beHJirysLbJ4I+W19IdioJciUPvCA?=
 =?us-ascii?Q?n/Otp3pnpbq5JycsgSRvt/VhK3lgCnhfLJHiLDqtWRTns6n9cj+VOt++cHnF?=
 =?us-ascii?Q?vlqan0OQmlFa4YwIj5yc+i6WahYkO3wSEqVBzOgLS1a7V6dv5DWaeMjdEGBK?=
 =?us-ascii?Q?UBtv5trrflHnDD3htHQYMu+SVfd/MjFtSObEu5rfVI1j2qn41+Lc6AmkpdLR?=
 =?us-ascii?Q?xokd7D23FMaGo5NvdfjsNRyPYKzOJ++DELaO0/C2zo8vRWmFB1FiKBXnpErB?=
 =?us-ascii?Q?D7gsirPkugK8NEimNHlbX4oV2ZJN0aUACR0XbCagShrr86DQpfHQtHtnkCIJ?=
 =?us-ascii?Q?NR+fSWmzYX+rksISfZSnGNoN3is71OoSQLXYPR36XBgYP8q833M7fMkfJuyG?=
 =?us-ascii?Q?1b240h+aQXK/eVUd1/4BD3XIk/t/gh0S0bXAucWdNTGJGlnFEGmAkVBBS4Ia?=
 =?us-ascii?Q?iUb91rCM8G8IkkxAErPByOc0PCIsuoR/u0OU/FZwmyiDZiXa+vPieetNIYGG?=
 =?us-ascii?Q?nUBJxfa+CWm/o915sT3Ghj9NCZQRRZQitPGm8/DGK6BKdZrMNzgLd1C/DDcf?=
 =?us-ascii?Q?bt4sKO4sTYYjucXHx0xSnKXXWZhwnr2c5xRj0Gv7ph/GZynpXWx9mdPh3k9z?=
 =?us-ascii?Q?7gC/O2Bs/IoTgrToUWzNA2vWJVGIaphipx3eP4v2e/VAQR3+ArtzK0B9gy+i?=
 =?us-ascii?Q?zs0OJ3DfJW84zJLvRlOlX+/CC3nvnjpQv4dxQBF0pNL1xIV4+eo4WzjdvRnT?=
 =?us-ascii?Q?jPe/qHSlJSL6cumuYIFFUYKb00bD21s5+RmxyU8J?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1bafaf-53e0-431b-6bbf-08db77bb0764
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 09:35:37.1790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qudxGvZDH1ZyDnTgVpJyEz4zF1KulO5WnE6Xk4ZXaFQ7UdxT28sOaq4WHgC1MkwO859g6LxJH37C3Epu70LKHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6144
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use bdev_logical_block_mask() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/erofs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index db5e4b7636ec..13bd185ef3b3 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -387,7 +387,7 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		unsigned int blksize_mask;
 
 		if (bdev)
-			blksize_mask = bdev_logical_block_size(bdev) - 1;
+			blksize_mask = bdev_logical_block_mask(bdev);
 		else
 			blksize_mask = i_blocksize(inode) - 1;
 
-- 
2.39.0

