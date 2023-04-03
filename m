Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F9E6D460F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 15:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjDCNoz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 09:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbjDCNos (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:44:48 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2128.outbound.protection.outlook.com [40.107.255.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF31113F1;
        Mon,  3 Apr 2023 06:44:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLCxHuW0SRcc7kc66JPJcoADTi9E+ZkWbUrivz7Lhzgwrc1jinOocflzMw+T08VimP47tCxXZpkbkHV/SC2Zwx9xbc5dbI2sYIbEh53U7hVDnV1jegm8Z/xV9C5o0nu9iC9vQOnqlg3ogdLpYjIVF60jgHghQ7b0/vwqeAVIRpYq76oAVUBsJ9SMALHovlXlE0bmUEmu5yFal+VwUc+g4xkzQIhyFEVaY6eLnpcIp4PvUnlTrLGUDDUaer0aCJjZQ2ZLxD7OHzM+MSl1baSUlR7gvMIuN7J5OQKkkQxC5rroR6sQ5GVBhzUruaTv4cDtKwsxD4H9R36v4JzBQPIqWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NeAy+PDhv0YQ/+D+bjcRHF4M7hLVgrQJokMv4TAY2U=;
 b=XI0k5M0sSHnEwb8FyWLHnSUJpAaoHySla9/ZFlRS44Ko7NtVkugQ3Z4+FaPyg4Dgsl53IHNbb5uzcUEWEvb87ksSy5FOVEHCQ+sFT/vU4eSRmjGuPI6uv+i3qkdC+743ZAwFL4M3u8lY453WaUDmio7X6Y2o7/rqkQAXUtMFPpmlrpeKwAcX1hiwriSxIOumHJV1EmVmqpdvyBwqnSYz4gBot8hqNYzh9leLyJNNkFqqaQLE0ptZOC9Gi6rGzuTFLVC7rh7GCLojcHkEdCZDnDMnqlot6WQAmD7GPcv6cq75G67iyQ6gzO9Z1e5AB8CtqfyK2fSXPGdgTxb8hCk0Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NeAy+PDhv0YQ/+D+bjcRHF4M7hLVgrQJokMv4TAY2U=;
 b=WEXPQYGCYQtPtizyv5fIQsHFVrUX99p0UwGqYs2dhHfuorSg8SCLNNf5/tzxXjJRwalfas4e5bU0enQ8lW+RiUI1Dfv3balF43stNtsWSgTGR2LIk1b5wMr14CE7/Jex1+4Gd0tagEOSjx8dw1IRqZny8PWr7mYQ1Oj0hg7f01jx5WPIVVQ7MQiaaa1iGRyALgOODMI65pN6xrHyCqkFnW8BoEM0zb1ihe8nwsbADgyyKk3JDYAc/Rg9KoBuWXgHSZO7TXGFLRz3g49IvyxhtrTOb4G8+7Knwj1o1oj4sXUScs2bv7lMPhBK0pB3he0h9AxeH93BDGsAOjv3CdK+8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB6247.apcprd06.prod.outlook.com (2603:1096:301:111::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Mon, 3 Apr
 2023 13:44:42 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6254.028; Mon, 3 Apr 2023
 13:44:42 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     brauner@kernel.org, code@tyhicks.com
Cc:     ecryptfs@vger.kernel.org, frank.li@vivo.com,
        gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: mark ecryptfs as orphan state
Date:   Mon,  3 Apr 2023 21:44:32 +0800
Message-Id: <20230403134432.46726-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230403-frolic-constant-bc5d0fb13196@brauner>
References: <20230403-frolic-constant-bc5d0fb13196@brauner>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB6247:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f99486e-57a7-4f73-3531-08db344993eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1c/MlNOPc8909rZYkdXudvoHmF/ndTYV/MgzPjzl8XQY4+GMF8sYbdY5HR2f+VKfFa5yPKpnvlVhmyia56kPixgx0esbEFGBeJfIjyDoRRMwkT4lleRDd1jnpxYUMBRrUq5jmNCaSRyWxKA51bwpPLEvqHaSCekU0djbN3v/LF8MaXpwThsO7Ot7oySKUd6j1SiMVSbrfWoSNbrMR6CUyI/GBrtdZkfzOk7gCsRuVX/Za3DzQWm+KxhHwDsPsk03ry6h8T08vsY16kJCBesvcxrhymeXGFZALflv2V6K7m0ygpar0rWUNu+TenZlRsw+PoTegzk7ybgkGBk518pGRxrYUR0qV/d9S/36LZqj7o04dTiKIe42XbU8Nj0v4Pb9XvdpbsJ8cn197H+j9YKVk2GJvHRwdzZdLueVJNdM6TDnzBw7FEGv5kr6a8Kg6Su7nDhBRX5zNfNukzrEtXXW6BC1l+kag/+arHPh9QwzEyFkhkvc06qBZTgIW7C++TmlGYXGam1VjSf/XEhx2UgdZapUshXsNOoPDkKFOisrFdzpRBK48ftNc3dP4nXvHXmdNSsjBZ0jDsCHQGnU3KvS/Gai3mxWYFdiaWjCJs9uc2g4M1U74m/DjrCub5H7Gr9i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199021)(558084003)(86362001)(38100700002)(38350700002)(478600001)(6666004)(66556008)(4326008)(66476007)(41300700001)(6486002)(52116002)(66946007)(2906002)(316002)(36756003)(186003)(26005)(6506007)(1076003)(6512007)(8676002)(8936002)(2616005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?knpCFDdXceJD3Sdlk1Ad0B4sa8IUK9lbsArNCe+U8pECsK/Bra8y2RdE752+?=
 =?us-ascii?Q?LYrNpNT+QOUxueRTy1Y9T+5fy1drnRzDgvY6bgK16Ahr65BXpKYp1ChRkTz9?=
 =?us-ascii?Q?r+H8ozQ2DdQovoPHaDx090alyESZObjg3er6oU6DaK9IVI0rpqqEOK8Z2vX2?=
 =?us-ascii?Q?SXsAjM6I41MyrdwxWpLg3b9a/rGoFi+XQz1C76FpB2SUwelIOpMU/zJ7Ffv8?=
 =?us-ascii?Q?yflDgG0rZ2UgcbTaCge+SH8IU6Wm8Oo77/Cxe4g6rf4UgPYvWkbbzjuznQWh?=
 =?us-ascii?Q?fbsxPiyMrOYI3W+P5Z3HTA0JjFJjlN2tnj0bTweAznUqsJrGmDSKJWFD+NGN?=
 =?us-ascii?Q?fLwRiBtOQAJSyIAf4qrAaRq8nf1juGjj7KFwmx63gnQkU1lt0v50T2pu4TQ9?=
 =?us-ascii?Q?zx/5EQfo/2zadILD9DKk2I7ODusV1hWkyaDit2ZQn+/c8svw2HjEV5H5OD1P?=
 =?us-ascii?Q?xQbGMdlsb+PAl1q/FQRdTZ7g5l54Xy2tcTEqhYm+PaUAg8ryEwClj5Oe2j98?=
 =?us-ascii?Q?2A1Lad1yjBo03ce07EOQzQtLw8Iat5i5HhIcRx71Ccn8l9QUAG2XIlXVAw3l?=
 =?us-ascii?Q?fwxYOGUEFds/3TmFWx5gelsOd1dleAEv95I2f0oXkfgP1zdawAZILQ4uSuXO?=
 =?us-ascii?Q?60g+PZacCT9uH9n8DwmOw3H+5WsVyJdE0slMb0aJn72aYOkREldJOMh2bfge?=
 =?us-ascii?Q?KJUzpe5N53noomXF0GVwGanttSvcmsl6rJmYdsvdoFoBVkHVSD4YHZEvGMkV?=
 =?us-ascii?Q?iwPdGuc+5NfrnKrZFVrLcUFp0I90FlLfdAoEzqlGPlHmfd6sCqneoZ0L/+H0?=
 =?us-ascii?Q?s7Lb58b7bMTlcRi13lTSaIAfSy1uo4DROuciRehFYsC9cgKYmInUVKlfqMXQ?=
 =?us-ascii?Q?Sqya0y8UYSa8UXr2ASP14DJpLHoeggHja15Wowib3CjM5Il7ndXDm/BT3lTP?=
 =?us-ascii?Q?UsBhJU/OTowc4637BUhkdPUQZa9IR5Bb4uO1dN19OoQe55GselocRGm8KVWR?=
 =?us-ascii?Q?wOnfXOVTOm3+/xs1ffa9bMxeHz4j6lEx6brlyAeqtxBoESazJJTgfVFN3C0e?=
 =?us-ascii?Q?5OkH3aNnwHBVUdJuoO1zkFnuFBcJHptoIET4xyAmf/QxB23fBs9XeJRDQ+W2?=
 =?us-ascii?Q?x/Nf++EcryYvBGIX2wNn/bu2hSUJ2i5RoXreuhBUhK6rSmORB7WReErF7T73?=
 =?us-ascii?Q?7FO69/Ra1SCrFknNtrNhEtLzV91Ih//bMIVt0EXUOLjT0rnpGaMtxOCMNCvH?=
 =?us-ascii?Q?HhPzrl8Wqumvc5eKPitIabY91b/Oyr82Vh6DzMU65ES/lV2xkHW1PJLHnQ/0?=
 =?us-ascii?Q?sqpVlS6Oyz7PVXKkwiaXiXPfVvTlL2NOfMpxShfo8oRpDiTo2iRiMFudCL4k?=
 =?us-ascii?Q?E6J8PdPtNn6Kf7IA87ZhBIZM6LNKL73HQ+deXWL1GLboARBe1GL8z+TiwbQZ?=
 =?us-ascii?Q?1eAPtU+sdhZUkL7XhOoVoppsLDc8Pv1y0QC7ffZcD4/T634ekWu5Ma6IULM0?=
 =?us-ascii?Q?FaCkuGrzPL+4avjUG+tEjHsTbnRjeSrXynyPbKhc5Y0vYa61NvRAib/nGCHb?=
 =?us-ascii?Q?H1mibRRXJiwP313bnfbtKaLugrgmtsRo9zInr6km?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f99486e-57a7-4f73-3531-08db344993eb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 13:44:42.3978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GlGnvzwchWXT7T3PgtYCgbbf6IgTGPZkI8JX4xuRp+zz6dG4AXoxuu3IUo91OJ6IUoOwWKO4nyOANH626KhI3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6247
X-Spam-Status: No, score=2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> I can devote some time to limping it by until removal but would also 
> appreciate a hand if anyone has time/interest.

I have time and interest, if possible, I would like to be a reviewer
before ecryptfs is removed.

Thx,
Yangtao
