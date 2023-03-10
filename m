Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698E36B3635
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 06:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjCJFtj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 00:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjCJFt1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 00:49:27 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2113.outbound.protection.outlook.com [40.107.117.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940A1F9D23;
        Thu,  9 Mar 2023 21:49:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdkFNY/XYJcKghRY2azMNhTzYFWzHSnzaFIsNdTFBLQQhzJN9tjuc+F/fWDe+wh48KlSh8Uls++QqToEf50fqKjb4pSg/Ul23a5beNxD1WCifaf6MiFZ5j9dNeS7AzjESg0EquEBCranCbxArNWoD789hD+Z5zznHsNhub4PfNvRiqDhrSzvvsD/A9OKumgOi4356HsojUyx3cenhDu4uDXj/+YBI3dmtss2C5I8YOr5U4l9fNgPaQqM2Q8Mhb2HsQIPH/4LZFa837lY0Oo4s3kyhRSn7nCQx74wKK97mYKis+l69gdCCdOOB0e8QFp75gMG8NL0g7B6PNij9fumFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGyFWvLSoU+2mZB6+yv46/cKOs/G2aGN6o/I+8yE17w=;
 b=iGtqgDrMzl7O5m0Xexe/kTTUISrfCitBINU1t6ojl1pVsA9m19HVFofo19+kmTzo0ZRgN/bSNGTbNOPRhORddOFHiQgMUERJtkOrVJ62Klahy/8g3RAu9+manGj3cZfW0ZvhKpiVELA0Emlma+H1993AZbPFbPKiLIDr0+IUbcsxRs7fvswp3fp0VjKSxjgLY+PHvj8k3HMDD1mv4y3+2ErQ+J8w23p2cRdM05EJiQSnSPN3XWqM//RfgVE9gmnAHSDWXiv8V5302kyhL2Mc4b62Q34bFKKwvxnUwvYqmPXvBHnhkeoWIVpUMkbV0xBcCSo4j6OARzkj+APzx8jowA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGyFWvLSoU+2mZB6+yv46/cKOs/G2aGN6o/I+8yE17w=;
 b=WhrOhDUkEGXz0eez4sWpsC9X6VH7uZoLmOWJeQwPPNCTq8oM86Kkx1UAfiLd8HRsTanJNDiX5kdyICwkZW023WcDZhFYsNcrfBuSkayjJdVEWfIsbc03JsUFgZttCToOzDGNlQIFAGcTcmfak/SjulitZVfAJB6ytjLS6OHvxoBPqsaFZ56HHiySR4qjSbQD5uT2DlBkG8+JfZOVY8TfKSmQHMoxVUWyEJpttT9P/lStNXxwJwJyXBcPZWs1Ut6FPPCRtRQZeg/y5lhELEshdf0sQvsrMGXxJN5ccWuOxSocHvrVgzdD//rg7hcreBNaUPH1wTcdrnivxenTWjBsLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6023.apcprd06.prod.outlook.com (2603:1096:400:341::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Fri, 10 Mar
 2023 05:49:20 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 05:49:20 +0000
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
Subject: [PATCH v4 5/5] fs/remap_range: convert to use i_blockmask()
Date:   Fri, 10 Mar 2023 13:48:29 +0800
Message-Id: <20230310054829.4241-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230310054829.4241-1-frank.li@vivo.com>
References: <20230310054829.4241-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ebba1a-19b4-4abb-2515-08db212b31d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vmRIrTsdgNJOnv5mVw2IF7UBVhRCnXl+hUMJNlrvYSzjQ8VEi+it7z4kFy88i5XoTmTkRzfqiQUCXtTdHcnNN+qJ3JaJr7uL05YgA74UjsWH8BXCPlvfFtIo3o+CwXkdoU0P38ZVlBMOdTfiWNRRbcBSUCztVbfuQXUMmvy53tVzh9LNbkItLyqZwtEAE6RbA6PoBFLneqFw623EOMI4vs4ix75wapMVZLFc4RENEkzfB/0mtD+iR6HxD5Z8b3ttg1YVAjhHscjanrVGOSk61q0yCKGhDIkT6SyWF1pQ0W4zKURwWMF0dUJXhrhZQ1pDJNHFrbHPhsOVZH+ibj1BaU6IhtUp8pNmY5akE3byJJ6gVW29X5o4Mk42ENDBXWJU8p8uU7w25OguRk8J0owdS8JWgx++Lx6sQ9pRi43nIm9PXvIRgDR3cMb/4rK+hCJ4MLYBBf0WhvtTiRT+T+71xIj/KZ3GFME51Pkgg+f0d6B4QkYGXYhogTCyuwVZjbvjOImpfsBove6ppg2CzFcBOpV2wQpIMgcQSk48emJA+3Aw25YNeTIY5Q5YSq8n15xx2ep00q3fmRCPC5ZVZR+fxaoMTLWouzcBcPyeiHlPQUDG+RaSgOxCBA1fgOGVV9Qs68yaEddhSvEUTZE7b4CtVjqwXHiZx2KokXi9CsbEAF2EL4Au15MaAIjU/eSlUgfFVERcXs91ZEq6cXybLIREPyQzSZS83i5bog72qnGJbKY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39850400004)(136003)(396003)(366004)(451199018)(52116002)(6486002)(1076003)(26005)(6506007)(6512007)(107886003)(186003)(4744005)(41300700001)(66946007)(66476007)(66556008)(4326008)(8676002)(7416002)(8936002)(5660300002)(86362001)(2906002)(36756003)(316002)(478600001)(921005)(83380400001)(38100700002)(38350700002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hyrA2BzWy4XVaNurQ1LelnavYpstiVxqkOiPaiSJzaJfaUWaJ+VOKhLol/qs?=
 =?us-ascii?Q?Ct0lEIcZo7RSdeMDO129jUnFTawpQmjaPB9A1Ec/QyvtjLBwHJcReinsNyH0?=
 =?us-ascii?Q?F/AtgTMKk6la59HwJSFBI1TsmPeD/ywtO0y03+hQ65tYYtWLWMgpx49mXjdx?=
 =?us-ascii?Q?6h5/ik1V14N6GT8tf6ys+V7MBKIWqkXUB6MQ1tSJA/T/g9sv32yJho5q5X8M?=
 =?us-ascii?Q?PRuEjk2ZUsStBtw+v++dFlINpc5bfK8AMQkfeIwvJ2KDkdmbu5L26MV7FzU0?=
 =?us-ascii?Q?2iF7F8iER95h3+KHzfkSFN5dwYuXfA0rqBjUI2gMKQiUO/gHUt7rhdvOf3pP?=
 =?us-ascii?Q?UgF+o4jXdQbyjOrfUGAMbwwbmdOZHFA4dfOYp1Dhg1hNerFWDG4iPuzGErBd?=
 =?us-ascii?Q?uIIWtxBKYkVbTqHcduxOOKG5L+kOsGGn4PHcAa7mOm3C9LBaqlvDDcDoKbDm?=
 =?us-ascii?Q?Iq3/jY98jNR+Q+koTg6V6UoTcLo4/gpuXwQSV2r90q1aV9pq3hPjdXNha1gZ?=
 =?us-ascii?Q?GFYUH8Fw4jwuVQb9+0vl8fCVVewbb/P4nLEhtn3x2cfRY3Gz92kTn5KeG7Jm?=
 =?us-ascii?Q?llHqO9CJ0XDplMMyAEJPpH4ynHhA7EFE30B+jxxr3gGVMkA7D5fZPajs1er+?=
 =?us-ascii?Q?KrfcXyKWnYyeGigrRHtTMDXn7YSrCTxGDU+g6GBAoTFDsvJWUeeJc6+ORJdB?=
 =?us-ascii?Q?GQDCeej2xNHDKsxLnWwFYZLNVp7BWhINKYN4hhDd3Xte8DJGxsdpVEPeeUY6?=
 =?us-ascii?Q?lqqTKakcdoLf8wFfszRZCPabdM3Hd2OQxeqIxdFfQmVGaRiHedjxINp5IucQ?=
 =?us-ascii?Q?npDGR6fbBmo4SW4HNO0j4/i4rnheCuF5qX13D8gXI19ORBWiujRq77io0vSw?=
 =?us-ascii?Q?6JQ5CVZerBJTmp3+Uyx9grPZ1B3X6HvgIUUbcouVE91sQOG26wy5XPd1UYPD?=
 =?us-ascii?Q?7Qsa58UDkjJbRVeUdFip2RXGH5f7EOI3pZALe/FXAp0nRaYBI/fEwD+4kkdN?=
 =?us-ascii?Q?yBB+zfaY/bCsHD8c+GYwMNXqWmIAM5yJYx8dLPycjsHSpPveTszZHmukuLaD?=
 =?us-ascii?Q?tVEm6bxEH60N/+t+DFh0aBtcZtlnZHEgpy/JToE6634duhobof//OLCugL1P?=
 =?us-ascii?Q?dwe2mszM685QfMcTk8TZwVIaeglDyeek444mNltYonV2o0Mkbn0u0fFB0e4G?=
 =?us-ascii?Q?OHMGxMeBcTq0rtMCXEkvEcSVqLGoF5HSOXq//4CKecM6e6dnrftFdVnb2xbw?=
 =?us-ascii?Q?pTOWZg02XBJEBAKjVB9b8qgcN/m/jAxILZ6e4mqq33r1xwV4WG6QesZbGHeo?=
 =?us-ascii?Q?gFWZ1axSGGo+h589W/DR4+pksC3EN+r4vppPS8+nwpRDuz/rdK17FkDcnT1Q?=
 =?us-ascii?Q?uz2wnWnOr6gwZf3ZWRFEOsdvwgyorsV5PXzjormopI4+WWfqBzHG20rCKF0o?=
 =?us-ascii?Q?KA++6tCiBUpl8lRvdnLLRz2Ap96paB29XrjCoNuMflGYZVC2jtd2L3y9dvnA?=
 =?us-ascii?Q?Ki9xgF8lAW3QV/PZzq85nvMVJHJ/6Tr1lok1E3VXM9VE3d4QbahjIId1Bx73?=
 =?us-ascii?Q?IocA4f7MxcJGIr6zLs07mds1rjDaithpXeE4V6Nb?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ebba1a-19b4-4abb-2515-08db212b31d9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 05:49:20.8712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKizUUXD/PnoWJx1I+aESm8SLdwYYhBhPV69laPZaD6rM+/iSpNXIgeiSRn/DRUBnQh/W6cHvJhumEt8zADWdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6023
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use i_blockmask() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/remap_range.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index 1331a890f2f2..7a524b620e7d 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -127,7 +127,7 @@ static int generic_remap_check_len(struct inode *inode_in,
 				   loff_t *len,
 				   unsigned int remap_flags)
 {
-	u64 blkmask = i_blocksize(inode_in) - 1;
+	u64 blkmask = i_blockmask(inode_in);
 	loff_t new_len = *len;
 
 	if ((*len & blkmask) == 0)
-- 
2.25.1

