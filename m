Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9927358BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 15:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjFSNh7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 09:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjFSNh6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:37:58 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2097.outbound.protection.outlook.com [40.107.215.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85756118;
        Mon, 19 Jun 2023 06:37:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYgSHuWruW//Zbp+iL+D79cmk/GSJ9lwyiDRz8PVqheDxbV/1VOfGa5qdWBvCOV0bHGsaZ0Kjr+sxZGjsDg6xvCtQ3LLILd9RN8Qv/jCmicpQT5TtgoKeu+Gk3D2RrUPOR4hp/T1/Q6h1jHtdtaGSLAoEuKC2sOB7oULSkSaOweNo5SNQeiwYXXIVufNZoWpcm4GOlGUo793Z+CWozvMa/t/tY5djrpleu7xLj8VXI2U/e0rdai1YcB1T0rCzPR+D3mGhoN70nx3Mtp59OM7Gg0O1pyl0NuX5cAUc6VZYiGS2OIStb7GEeUZFqjIU6xMRcjBje7Sj02wWKKjaqGGRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQDvB8/Rk+TUW5MttYSjQ9HK7/goa5L9c6Dn44J5pP8=;
 b=YfNhZVEgyKH27kQXVarT8VjGFw6U5RE3IwiZH+1zh4Wyf8NeDfH7Arpyqy+/GZFfTrPInbgB4wLcYmVqdx2qWTAtbOK4QDPvupKjorUmu5ojrYYF2r85PQqLhTwnyzfYyRWBSOH5jojLskJ0EHdo/dd/991K64zuR9PcncoYvGSrG54Z2hwvfkU2YIE4v+3b+yXCRz7z+RS7oEGZNfw/zRACLmGVPCqi04667eFXxItRUA/BBb6iUmjW0P3UQRnPcz3qGt7+rkZDI0ZPUzwLKxgpNxo3lpg72vPMS65gL7OCnS1atYLWhTBkIw+i9HBG6E2JZhFQdgiCXFVB+O5AUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQDvB8/Rk+TUW5MttYSjQ9HK7/goa5L9c6Dn44J5pP8=;
 b=ZrK9X58yeeguR1GY3A27xR1ojZMlgyXcD6ZsQhYTHSKbCbpM/DzGCTDM/iecZef9gsVXSkjE2bfK5ncfzlu+kxXx1mYiCDU7dCj8jP6pHyVMR/aF4iwcIr8NRNKNleH4LYwxz/dtTAkjCNGm/t5+OvU51C5eKnFt7roUDUsdzCC9AfUgaPnHw38PFjcp0HmgissL6poG/+tHG+pfkN3MOacALe0WHHUifxhmeH9xQ1jVk48G8pijNLgLA7pcZZaea7OUNEy3r1WsXhmNv/MgQol7s8zI020fmU0L4vHcFPonPNnBxTsOLqrGvNYVz1/KjbSnYc3B3cNEe7ItdRtacA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5022.apcprd06.prod.outlook.com (2603:1096:101:48::5)
 by SEYPR06MB5858.apcprd06.prod.outlook.com (2603:1096:101:c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Mon, 19 Jun
 2023 13:37:50 +0000
Received: from SEZPR06MB5022.apcprd06.prod.outlook.com
 ([fe80::37cd:b3a2:1fee:705c]) by SEZPR06MB5022.apcprd06.prod.outlook.com
 ([fe80::37cd:b3a2:1fee:705c%6]) with mapi id 15.20.6500.031; Mon, 19 Jun 2023
 13:37:49 +0000
From:   Li Dong <lidong@vivo.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)), linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, lidong@vivo.com
Subject: [PATCH] fs: Fix bug in lock_rename_child that can cause deadlock
Date:   Mon, 19 Jun 2023 21:37:14 +0800
Message-Id: <20230619133734.851-1-lidong@vivo.com>
X-Mailer: git-send-email 2.31.1.windows.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYWP286CA0004.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::6) To SEZPR06MB5022.apcprd06.prod.outlook.com
 (2603:1096:101:48::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5022:EE_|SEYPR06MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ce26c98-5523-4b5b-c0e0-08db70ca5f74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h25oeCYkVaIsl0Y85VQPpgvPjUbpL3TNALSEOiCLxULBFnXVXzNKUhjksuUkr999jHzV0lIZ0PcJAmG+YXszCVC1rH/BtnoE9/3YH0GIQLVKBIU0WnrPNgZxzVnCRdWlb1BKtsA+E/Rf6jXXR3ndJEdh5HWt1H4VqeIkQlpwEqVI3AeUVhjxJhviREbc3SPzZQEZn39yxw+PXyLhXri8/EmEDKYcnr4JmKmaWcsm186lwheqa455ug+4kK3YFl8OKKBMEwDk5DG5dToNToianw0DXCg9VjiLSmd/g//U499gbsV9/j2ufZqe0CMRx49hDMKdbKSM7+HdP3FgAHZuJULFkRh1ts33oZrNVMuLAQSIDdo2FkIHJKNoesxJe9sfnt3HyrtzRQweuryh/udfaxDvtckcBw+MEgTIb/Lv3vJI/5ulyz435D1NzwJM6em4XGLHTtr2pw7Ck3QC79GQpcfc3delDSMQnzD/QAclGDy4cAHQYKHzWao0tu3qNzv09cGJsLcolw+LFvb++2IjcOoTDsQuc2cQkekxwofNDH1e7bfm8NIwsfEYHE3pwqutkXnOkT4OE5yOfu04x18KzqdWCFlaFihoL4zuHJSnXHUS0bsTrnKNT4IwxoUeqBtG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5022.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199021)(478600001)(4326008)(110136005)(26005)(6512007)(186003)(36756003)(6506007)(1076003)(107886003)(6486002)(6666004)(52116002)(2906002)(4744005)(8936002)(8676002)(41300700001)(66946007)(66556008)(66476007)(316002)(5660300002)(86362001)(83380400001)(38350700002)(38100700002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emduYzJLTS9ybmdjYzBYZ3ZaQnVoQlNaS2FGRGVYVXRZbDVSVXMzTU9TTThr?=
 =?utf-8?B?UFVpK0N0eUlCWXhVM042RG5oZVB2c2xOOVpDMWZvWFZFWUticVQ2UXYvNjRE?=
 =?utf-8?B?TVdBbTZzN0s4MUdvY0pDQkZmaFNkMjdoQ20yNGxoZkhjNnZrMWpqNXcwSGY5?=
 =?utf-8?B?OG00RVVPL3lKNGVMOGo3enZUNXQySjUvM1V2SlFqK2Z2aDVjWUk2OGVBSFBR?=
 =?utf-8?B?YzZ5T0VDcktZUGZvYVdTZUlaRlZRQVM2L3BkSnFScWx3MUlVMmZpZFlUMkdn?=
 =?utf-8?B?eENQUlhtOHVNR0hLQ2tMSkpmVmJZd1BtU3ozS1Z3T29IczBMQXNMN1liL3Fo?=
 =?utf-8?B?M3pNZE5MRFJaZDd1WVRvdXJvQ3A3eTFnT0hrMnhOWU5KeFFnNnUvcVVhL3hO?=
 =?utf-8?B?ZDZhUVRZUmdzVGVQeWZWRy9jcFlPTVB5QTVEUzdUTEZTMjQvMWt4TkxqSFNP?=
 =?utf-8?B?VkxkK0E3RDBiR3lBYVJlaXJmZkIyTEZKb3RJVmYwZ3F1YmFpeXdDME14a2E4?=
 =?utf-8?B?QWpOOG44T1k4VUJmZjNQK0wyUlI5SVpieXRpSDBLbDMrSkhybVhhajNIMko4?=
 =?utf-8?B?VTREakJBb1dRalU0OVF5dnJHbWdzN3hCUXlQUGVUU3drcmx2dXNKZkZWWDVE?=
 =?utf-8?B?dHN0Y2NYbzA3YVFGMUErTkVQK0pNNmlxWWZrZDI2YmFUSkVKY3lYZ0FzaEZM?=
 =?utf-8?B?WjV3a0VCSjJDVlYzVTRMNnprRmRTVzNjdjYzNkZGaVpoOTJ4Q2FEZUZKT3hD?=
 =?utf-8?B?aVZFRWwxQzdtU25tNGJRZ3lXQzBYU1BSUWd2cTRPNEgzQ0tCbzNRR1RwbmxQ?=
 =?utf-8?B?MG0rS0Y0L3dKM1YxSGdDcG1HQWVzUm9ZRDhoWld2OHppSlByWmNJZmY0aHc1?=
 =?utf-8?B?MFlKWGhyRnBURGN3UDFoektxRkd6cUNZdFVqZjhlZVA3Y2ZTMFYzdWFTemx5?=
 =?utf-8?B?QUYrNU5ZK3B3NUxLZEc3TkJLR1pGenJrd09ZRGd5Nlh5Q0VSb09adk4xODc4?=
 =?utf-8?B?dTRraDZoZkF3QXBjaDhVd0tiazk5WG1hcER3VERBc3RVTUJYTUtDMElaRXoz?=
 =?utf-8?B?aWJmdVdBTTN6VVM5djFZaXRURUpHVi9rdWtiRWliME1vNjJ0NE8yTDlWbWp5?=
 =?utf-8?B?R3pvbmxZRyswc2RQTEphK1dtSHp6c1JoM0tIRFFXaDFOR01JbmxqVDMrb01o?=
 =?utf-8?B?QktUeGVEdUZnUmdSN0pvK0thUjg4MENEY0FtQThiVVFRSHYxMlZVTnRXRjA2?=
 =?utf-8?B?NnZmL1IwTXBGb05YYWVwNEV1ZDF2cUxXTVhxMDJNSXVoT04zR1MyYmFsWDI1?=
 =?utf-8?B?NEEzRkorQkZGNW1RaDdLWS94UWtXR0QzSG9IRURzT2l3VWJOTkw4WVplSFAx?=
 =?utf-8?B?WmIyeTFla1ZLM0NBYkRuTW5oYjVabkU4b2h5ZTBIOUJpVnFSNWFobGRzRVBY?=
 =?utf-8?B?WGVoTWhiNVNtN2U0SFhZMlBEd0haU3dURDJJb0FMcXk0YjFTSDRVYXFGTmJv?=
 =?utf-8?B?amJLZ3d2TWtjSE5hU0l2c2tRaFdYNWd4Q1krdFhNV3Bia0oxZ0hVb05hYVI2?=
 =?utf-8?B?NEFSb2xqZXVQUTZCMWtPdXRwSmE3bjNhbTd6b1VzOXN1WENlRVhvZ1h5OFhW?=
 =?utf-8?B?WEFUMVlzNHlPNTVTZmIwbFByckZQTC9BTFgrR3ZrK1Qrc3BGOEZJMEdQdEla?=
 =?utf-8?B?U0xmVnVQV01kWjJUQjlIcUJrRSswM2cxWmowVEEya1Rzc1g4ZjdXR0VHK1lq?=
 =?utf-8?B?N0FGT2ZSV0taOW1RTmpjaEFYM1FENjV1c3lHYXBONVJqeTdXRWpXMk10TzFY?=
 =?utf-8?B?TEoxS3psaWowVEI3U3VDQS9vc2pVQ2d0UWRPWU8xMStCWjJFM2Z0STRsUUpB?=
 =?utf-8?B?dFh5NFk4RUdqbVlLOWdleGM1Z3lneFkzcVZPRXA5Nlc5NU5PMWJweEFxSDRL?=
 =?utf-8?B?ZHQ2U2I5Umx1RGhreXN2bmlDN01BbGhqL0JjbVFYUFEzcWIyenhBdGMvazdZ?=
 =?utf-8?B?Z0tpVituMG5ZWVl3RmFJZnlBeU1wN0V2MENlcENPTGJTdUFLbzdVUGhtSDdK?=
 =?utf-8?B?VkxWOEpUS1RMWFlxWWtEc1NzQWRHM0I2L2FwSUdFZ1orM0JaV3dTNUk2RmYz?=
 =?utf-8?Q?vuipni577hT/4+T+HiV3Za3Mu?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce26c98-5523-4b5b-c0e0-08db70ca5f74
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5022.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 13:37:49.2945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xy9MUAx3PGO1YGPwI9aGo8QrZ9CmBpxDFJ4Oy+gO6FHT1jGsfBN+tobl2FZ+8j4VC3bh/N8ucUPArUD0nU03JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5858
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Function xx causes a deadlock，because s_vfs_rename_mutex was not released when return

Signed-off-by: Li Dong <lidong@vivo.com>
---
 fs/namei.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 91171da719c5..63b3fd05fef2 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3076,8 +3076,10 @@ struct dentry *lock_rename_child(struct dentry *c1, struct dentry *p2)
 	/*
 	 * nobody can move out of any directories on this fs.
 	 */
-	if (likely(c1->d_parent != p2))
+	if (likely(c1->d_parent != p2)) {
+		mutex_unlock(&c1->d_sb->s_vfs_rename_mutex);
 		return lock_two_directories(c1->d_parent, p2);
+	}
 
 	/*
 	 * c1 got moved into p2 while we were taking locks;
-- 
2.31.1.windows.1

