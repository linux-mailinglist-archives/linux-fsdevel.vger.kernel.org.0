Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6E36D9F45
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 19:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239335AbjDFRxh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 13:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240113AbjDFRx2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:53:28 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2093.outbound.protection.outlook.com [40.107.215.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B382AD03;
        Thu,  6 Apr 2023 10:53:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loAI7Syg3ij6yHw/FCU47KtDiv8zsq/BGqFExNSDvG4YUdainoFpXFHmTOtijSd5wUc9uom8YmpKgx//Bl7Rn/vWMzlwpUqmPbej5Y7/UOGE0J6KQsh4Y1GnBVZSGCIsFX8FBl+OSFwi8IfqTM+TjtR68cGv6lz6eXdj8Pp2YvE3F4/EHBeTERkIaANLEdUFsgT5i7Zzzk/8kQc9mKvayDEC9vL4kQTFIJzH89UWWtS1b9GbBwhYKkmsdfITjHSDRjjp3xqm7sYF8zxlg8i5wGVJOGyfVvCMm9XSbCxOC8ehy531IKX2aGODC66CczfjZ1pL4Vs2KupES1yPcLNEyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hvdgo3q2wtfhSX6j55NnXnxWVi567KxzvFAQDdxw0o4=;
 b=IG5qiYcnW4HYCcRZcj9CjKXYg5+Gsz10Y1BpKLK5yjN82bnXKGIJZolSzm6SQvbe51RlTxsHW9oiw4h/jeAsRcH8qC/1nYwFyvxDJ5fhlhhUoEZq6f26CEy1/vhdmc2RM+IzEsAy8xwXbFPNa8Ruhv2xR+73slXaiOg/5AaR/bRDWojvl1QsxdBpchWk80UMxnOKS8OSmjXPv/difnmE4xqgYGf07RN+IvRNPVHgn63oBP5VSvmgwNfb3rEcii1P7+0pGhC3wlmqD80lVvWTu5Lw+5yqpc0n/vKDOiqVuoADREYI2LIXEdm6QA5u+WCqp+JmglFA7Y/lC3ybm+fwuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hvdgo3q2wtfhSX6j55NnXnxWVi567KxzvFAQDdxw0o4=;
 b=QMV0CdKdWYIXCJFdyNmQcX0sPsJGYDg7ZX6epLiqllZdsw9UtsEJ11qevvJbBS7mh8tG1paHAaN2kL9Kqb1DeA/U0s4J1zrMV9Kt/qgRYu9NtR1BXWs7Q2HlQbL/G/1PAIQK/SfSvhRyoQFuptjLB9fl8wsMZ2cSzfkMypfQQCB0wyt1EBX9R1ciWO7ZupLeHpMl7jOmUh87ZBkROhHgcDpoM05g+d77mOFHLLAocm+fyXRPDr4jrbard8V4z/QyrxkBr+bkggs3jhYubdq07gM22LAc+BF2ePxHhTJ50NsAhu0FuULvcBy/UrY8XtIxeF7dLQQeS3VAI/wuFxZaSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4012.apcprd06.prod.outlook.com (2603:1096:4:f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.37; Thu, 6 Apr
 2023 17:53:10 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 17:53:10 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     gregkh@linuxfoundation.org
Cc:     chao@kernel.org, damien.lemoal@opensource.wdc.com,
        frank.li@vivo.com, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
        jth@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        naohiro.aota@wdc.com, rafael@kernel.org, xiang@kernel.org
Subject: Re: [PATCH 2/3] erofs: convert to use kobject_is_added()
Date:   Fri,  7 Apr 2023 01:52:59 +0800
Message-Id: <20230406175259.37978-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <2023040602-stack-overture-d418@gregkh>
References: <2023040602-stack-overture-d418@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4012:EE_
X-MS-Office365-Filtering-Correlation-Id: e5d01177-a988-4ebd-f7e8-08db36c7c889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +lgatNWkdv5Vl0LfZPks2lpSFBiO8IDpBLxG9MRpnxXF29YIb+8JND+KYjmEVi1PFDUDhv2M6vJGZb15MYJgoyRzMqsoydN6QQHexFO5Zf9smMymBy+dffONWa+xXosMbtVbWBBWR0aoOG/SoqylWquThJL0JnBv1eTVeqdKMjCzL5N7D3HSu50YIgQPkyxRK6WpLGVt3QYLNd6OFwhd2E2LQnN/C2sr7YFXnJ5e9lUGCRXABWL6vDOrkl0w9DPU1bQLD46GAZu4WS9XXRlfVd09OPQSrh8zcWYLF4kTk2nrFEhmX+V7sfKbj9Py6+vT47Zs3f5MNL29Z7IYiz7LCvt/dlxJxd3uRLs0cC6LjY7fd+xJ6uXv5IJX6rzRqaFzGXxGO1P9ERV7VdosT+nrLVeIBaOCtyMyUzt5yR3vqPymdfexm39A/rI+gGCC2x/gwY2q29S8WeMZc0az6Ynj/tLzsmU7r2x1zmI3Ged03lfdGraDh7OM7GKx6bLiLLEpYdmrHJtNoS/Xxc77PMZ0JTWSzfr7l4VOUysxkp459EfY8QKvtoQo7IULdnWETcGlXiUdGE/0fnWCfX0wGgo3C1DiA+w0pey3IPcNmwWLA0W3+YQTGKSxG26QNprSMO6e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199021)(83380400001)(38350700002)(36756003)(86362001)(38100700002)(478600001)(316002)(6486002)(4744005)(41300700001)(8936002)(5660300002)(52116002)(7416002)(6916009)(4326008)(8676002)(2906002)(66476007)(66946007)(66556008)(186003)(2616005)(26005)(1076003)(6666004)(6506007)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+HFSpdJbwX0JTjvK9VVVjMABFJd5TckprXlj8oyfZyxhjCNWzDkW3526CrPb?=
 =?us-ascii?Q?7oYSdCQAYRTHbnPMjAN7u0hYNHmxK48XQYx+tdNwk3w3SeQBFPXWR5IHadEC?=
 =?us-ascii?Q?pLlsT1lXRww6/89hk9H9ycIsT+GEG/uswlv/R+ZPlJWxHAriBHxgqjsh2r9n?=
 =?us-ascii?Q?vIdW0Z5Hlpcn5oMbCGyi3QtCXkkuWQMJ8fj6DhkBZshdUWkQpP82o/q+BTkn?=
 =?us-ascii?Q?9VJJFcLQk7qHtdNRxrLA9UFVgloTeimjOlsHpv1XfZx6Zqxc32LytP2ZRKFH?=
 =?us-ascii?Q?33BBVvT37XazUZYaP/FwiTSV6KWo+p7o67AsQekgKX8kkvUPJweW65jjY4Zv?=
 =?us-ascii?Q?531lFMRSUDTrNd47L28G4zpzAfePaX05RmzNSquajE5dJMVhmT3OpA/yJBDm?=
 =?us-ascii?Q?Fe1f92qZDxHw3FE/mv95I6t4BEJc7T2Vi/cpmtAppkIz+/2jI7q7vFP1I2pv?=
 =?us-ascii?Q?3GRAYM3BZT71vfmiyySOiA6DmMVE9CxFKaDql+mS0UHri8BmJFvfu66QDqCK?=
 =?us-ascii?Q?D7zmzr5JW22mf71JG8nz5+y+d7xMSP4dmlR/19B8tRNVj6Skl2MR4lDobEjk?=
 =?us-ascii?Q?ejdcLNOjlVaXzBxiVcQu6dsNqTzAlvrQtA5dgBehzp3aPiOdUc3qQrzUXYGd?=
 =?us-ascii?Q?A02yKkMW1FoV10FFZs77cyGmDlq3dXXJRNsjP3UVsYiWbRO0CRBMBLThQ4nr?=
 =?us-ascii?Q?nuFOvoiZK+zujDFiopHXqadWgfEHA2ODa21PZ9+VjlWjt/CKX+Hu++sj63Gw?=
 =?us-ascii?Q?8XIkayY0iUOeA0z70UalrbE134u4IX2uCxG/o2pV4TqmWkAbA5wmzvMyjPux?=
 =?us-ascii?Q?VXGx2BBGnL9/+Q2vUHF4W36er/3FDp13o50cb7hq68CTLfIMTORWNoOf3L6X?=
 =?us-ascii?Q?rH0FAt6Xkd+yEZYLDX8+3iRUdquwBWx8pK1zHDpCQIAWamQ0YhXShPsm1R+M?=
 =?us-ascii?Q?jDj5MO2thXcX7F+6t+1E3QA6UhGSYHyKk72dm7oCvLMWndFO7YilfEBuhyu5?=
 =?us-ascii?Q?hNxMgwqXRpQDbNPz8ThUp/yYM6H3PHjISOQ2MsN9kXxx7VSn7p7CJ2Z9uDOj?=
 =?us-ascii?Q?VfkTxM9UKTr0RKIaLuHyKaDBZaHUHAcrrQ4fM3I0Hp0TcZRBmAt3sPOS4SsX?=
 =?us-ascii?Q?CSIgggtdk8M2W1+WDzCvEYTUPOwQTQV3j5zeyMemXTHhbc/z2IdThjWxIpju?=
 =?us-ascii?Q?BYBPD8H0U1NUvmb3Eo9r8oSiBXRQjeg4pbp1JhGkYrwZ2sH2UIIQvcWNUPPz?=
 =?us-ascii?Q?aPHdSpO/aAcKW3dNf/AINH0/kXIzmqoSvyVZ7aGL1yDfvyQkNjIRRiT2PMQt?=
 =?us-ascii?Q?j6osEhqSE5XhregRz6D6ym2I0GJADQ/Y3qSl79GKQbIoRxvepNcIljmrh0RZ?=
 =?us-ascii?Q?dbvHLXs8ZHUQ5VH15Vk5VSmyc3LhxecsSxwzNDfyN3EDi7Pm6qZxXpohnfKJ?=
 =?us-ascii?Q?iP869LvT2pa6HaxZ8LchoqekZpAABM6KjEhkdpjtwFVnfaSmhSN+4bHNsQ59?=
 =?us-ascii?Q?SDPf+Lr/xwLmY77Iaqf/TmmBK4F1ouOufD43MPXlh/5dY7kgh1XVaarfPBna?=
 =?us-ascii?Q?St0dSg9b/Aupf/UaQmYvpNA1hDfYL8pnVq6Dv8vI?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d01177-a988-4ebd-f7e8-08db36c7c889
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 17:53:10.0122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kkDCxcZhhq4matg7v9OBhItQVLelhKXCv4plZQcyeOeQ/5SZQJQdUQ3Bd5WLeb8PINvhJctCJPDNIaWgXjRrNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4012
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Greg,

> That isn't going to work, and as proof of that, the release callback
> should be a simple call to kfree(), NOT as a completion notification
> which then something else will go off and free the memory here.  That
> implies that there are multiple reference counting structures happening
> on the same structure, which is not ok.

The release() function did nothing inside, but we need to wait asynchronously...

Can we directly export the kobject_cleanup(kobj) interface so that
kobj_type->release() doesn't have to do anything?

If do it, the use of init_completion, wait_for_completion, etc. will no longer be needed.

> OR we pull it out of the structure and just let it hang off as a separate
> structure (i.e. a pointer to something else.)

Make something like sbi->s_kobj a pointer instead of data embedded in sbi?
When kobject_init_and_add fails, call kobject_put(sbi->s_kobj), and assign
sbi->s_kobj = NULL at the same time?

Thx,
Yangtao
