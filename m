Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9F66EE847
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 21:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbjDYTck (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 15:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbjDYTcj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 15:32:39 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2137.outbound.protection.outlook.com [40.107.117.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56D149E1;
        Tue, 25 Apr 2023 12:32:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxrUiLaM1HWjbS5gG10UxJx5MzNXrs6gTAv5/I+1h81aQKEvUp9VJCKdYk8bHMGXoOnCMD50E1PBb08kI+Ol7XAtv6KiTKIOGLcV7C2vYfzKPmVHxG6SAr2NsHCYlpixYQ3YjIrEk/vHrco5EmiW8l+nOyweFdJPw3C/k36kLMRox5mBZp4Jps5pSGu+h2FDxAbO3Qq6FEej0mM2jSb9hC3H55j79iDYFzmEiPgdu9qdop50pG7boD8O0ktltB55ycThE+C51vPg7OSPkFhWWiLLlWPuytAmz5k+69MtdACJMUwvvwFcgTAn+FfZ5Y5hnotc8V2evUyHyzTY9ubiTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m45eZIywynwwdVTDPt5i5TYAFirhlhIwcQj53/ia0UA=;
 b=W/pSV/v05kQURIZxVGBpFE+sCnjupjnYiHxtXIYb7UKFvHq00esvqQVQwARYs5vDi7oHtymIXuAVTRGfdv+JNEBBs6nXPVx2Ck5UvjPVOqeWIjxp6LpA/OwfKC3XSZHxfN8zn8gAzbaK8mHc3SitAVHCYkIsLpOmDx2V3HgatAX0AOs1eIf4USj5jw4VT1XwRopzz1DdU0AtFj/+BL9272t+py6fmbZLgc2DdsSSiKqDRG+B+X7XEULnI6Es5pEM0NxWdaH7dep4RZTbLRbGUtQDBlOIy6FHhC3ogYmdetkaK7sL+50FeX2VvloE5OqsOyVRaiKC+/DQZLEBUfMUFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m45eZIywynwwdVTDPt5i5TYAFirhlhIwcQj53/ia0UA=;
 b=a3YkiXklyXO9sHcQrmJ5pCMRG9dppOTfEhby2SCUZLynmVGxe5/hmbozSu+isWHuyJdZ9CjCxohhIQUNKvBaHdEFl95UQ/6JF+y5+MtDJ6SYEtuYHIJ14XJkPxRBvGGtXGIeQOAbO2y/yPRJGcJFmuWJnbGVbJ1zoXEb1Ge9O7iH9M3JDgch47+8m5yI2p8hFVa68aA8KyM6gEVIWi8U6nnzmvOfk2tG9uqainsXix7O7SAoZjvM0Cbgkn18UPFphgQeiECVWcICnHTUxz3kCpoJWACxRfuFZmnhvr3CsfyukVkuuyZXnT2+/arWFu6g8I1wd0CdR94QTqK4xdB5QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6176.apcprd06.prod.outlook.com (2603:1096:400:351::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Tue, 25 Apr
 2023 19:32:34 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%7]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 19:32:34 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     frank.li@vivo.com
Cc:     linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com
Subject: Re: [PATCH] exfat: add sysfs interface
Date:   Wed, 26 Apr 2023 03:32:26 +0800
Message-Id: <20230425193226.37544-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230405084635.74680-1-frank.li@vivo.com>
References: <20230405084635.74680-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYUPR06MB6176:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b8fec55-04d8-40b4-5e1e-08db45c3d1b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2DaOkGM/nmWe4QK17mxs2n3dDXnTAbXPp3i+u8ihENwbd4Xf7FizXFAAo9VmHB7Ugg5SO1m9LDVthCxqOLJRp4O/XG/1VMXn0Fma4/cnAWHje6/LtyEpxeaCVR3l1UFPTj/YTi/AaKf5dcHl1YEiQfC8PgGCr7Fn6cm3FMwwpWCUkFGDXIyBMCVdIDsDOnFo2vLziD3PHBeGaDgWafw2XdaVM9KdJf5RrDORCYOIgvNPbQz0mOPKMHGE7zT296f4iGYR6vFx2/K11RCOmObh5XgR3VphiQClArYQfAY5iYFnT8oSaonsXrkNexypU5x4bdfUN0d2oYnNufUmpOT5H5CdJnuGuTXziASJ6N9cMLnMqtBym+NQsCLSUtnmhQNUUiAVHJFJHy5ZMyhmY+CP7JGtej2WIn9idtxrzcw0nhq3DONKyczv9BjKcdjIhhs2st2dljYrMMNil5ntdZOJ+cWe93hGMeDC1qonCJvL1lZ46mf07M1quhax9zAWOqn+QevLWGREo7kujlDfovhulde7IhljPVAUKR2HIL+TyGnr59lc3EiSUEYByaeJG5PrHC8eDXjabnhrWa8s7yHvRDs6lDYw1V/6xlNK5qb8K8LoJZBrtmPeC6E2+h2fxV8B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199021)(6506007)(558084003)(6512007)(26005)(1076003)(38100700002)(2616005)(86362001)(186003)(6486002)(52116002)(6666004)(478600001)(38350700002)(37006003)(36756003)(41300700001)(2906002)(8936002)(8676002)(34206002)(66476007)(66946007)(4326008)(66556008)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+zC8AFCRdwQpIX90uKSy35K/13GAiuE47aKKaCoIbV4uoUys3uS98eDu2ehw?=
 =?us-ascii?Q?mcIN5riFUMe1XoEeAr/8etcWM5CGGv8VQOvhjCJtppN1RI2jimp8v8kpbVub?=
 =?us-ascii?Q?pOMhwISQ0cXJo2x3m8nl42P7mM6UG5qCNe0D8emrI4+z+Gl69J0i46Cxv9t2?=
 =?us-ascii?Q?E2X5ebEQoyVnqLW4217NXvWBfnRmlwXqZEVp6o3z5tGdvdR5nDInAKASj0Oz?=
 =?us-ascii?Q?pypIp10NWDL8zZSqcn1RJy4QePdCmmytAWr40S1J3f4wH7sVGCrczPoOHCLp?=
 =?us-ascii?Q?fVD3zNw7CPJDcN3k7WZ23pMoKQ1erQrZmuPLuXuAVrqB27dnaGEyZ7ePO75j?=
 =?us-ascii?Q?Obf9eMygK0nlblBSuD9ZycWeCyW8jmb2OkgGQxezpu+8wfM0JdKPVCsgF/BQ?=
 =?us-ascii?Q?FpRKhVPT/aZ/9398wn2zvAke1maPk/1U7P0RekcOysFfO9+CUhBWDjF285YB?=
 =?us-ascii?Q?nss1n2IayORO5DRootajk867ZjxmUPwhaN5TmCROrUvc/gMK5w3wKWuI+m0s?=
 =?us-ascii?Q?rOgplQoPFXM1jw193moh1+K8Pfk9Hu7uE0kaQGwNRK5iSF0Y/4b1KjpOWwDw?=
 =?us-ascii?Q?LCd3gvmSDrNbJD5XNbBf8AYymO7VfdH9hK2H/iDVyeLFM9Yu3Xm48bJ9NDd2?=
 =?us-ascii?Q?Lq/eYoOaYzMHa1VqG/XKMMx537j5F/QFSDTNNO8QSmut+I7B3PlCQ06kcQPl?=
 =?us-ascii?Q?cR64GN7uZLRYvR3MWb5vhY8/dG3ASJKbshUF7+Szvrx2nIafPlw4ZSWgArs0?=
 =?us-ascii?Q?n0QqnCs81K5tH0m+ld58mY86G/lIOi0TGI58iMSRXNzDUhCow64TilEb1WQL?=
 =?us-ascii?Q?HoWd21FH+62yitNshl88TfYHm574PBVg5fGeiFgIp+1tzjyNPJ9yk951Y6Ic?=
 =?us-ascii?Q?zDDrieky30v8rWPYmwrI48hhYDZEC5kALhsMbNGCI9Ipa8WZDK9AGfvfttmw?=
 =?us-ascii?Q?kZJV7aVnF+WkZdOwaUQxjC8GrJrDLciYUHgMu7JLsxP7wVd9YwanaNQDtxHx?=
 =?us-ascii?Q?4IzC+XvYQqcb9u+0IAasw7dQcgU3N7fS2vnQ6nyQ/abRNPYfBUoYhn1C13mx?=
 =?us-ascii?Q?rbr/uRbG4erfG56iAIsasCXwMQkzcexSHXdkoStsp4m+SqYNETfbru4VIZmX?=
 =?us-ascii?Q?Nr956alW3zCjvECZbdGnpgMYzRbEo6SErEuIDRBwiCXoOlSt6tvuEZ6y1lj5?=
 =?us-ascii?Q?mtR3dOBx87CRWJmR2+B8+Ts0DRoh87uFRUks8ZasoFSGoU/YeCAXp54ZZQl+?=
 =?us-ascii?Q?larKyF66fGZ5NdjqxmF8tJmH4OIOQYy7vMv9NgPOV6/qs3lsB9JV6dnfHrRi?=
 =?us-ascii?Q?TDbCzHfex/DYsEBUlswkut7k9L2vT0NQRSjiComvWBUS6Z2gtfv9QiE7le4M?=
 =?us-ascii?Q?NAX5/m+4Gb1p8EHio3dfFbAAKoIaQvP3NznXDfne57ZRVCCyK86p4+0CDcG1?=
 =?us-ascii?Q?wfK4yOIBdWxVGjQW7gKm1In+kWfzHlhE1A0G+1MvVOzQpzKkA02bxHA7MguP?=
 =?us-ascii?Q?Cjr9AtoavcTGTWq5/ZhMnYJetPdGzpPRjDwVzesDs3pphlD/oPG3Tm3yVw3H?=
 =?us-ascii?Q?s25i5ALjJeqqkdi5h67nDRgK1EyrTIpdsOEA27W+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8fec55-04d8-40b4-5e1e-08db45c3d1b0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 19:32:34.4399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gb1Q43x0woDLnfC/ItSnmFU5QXkVleKrRdtZ3QQIHu3I6wMQe0VjNZyIjGIlgzjZXwyI8B/pg4BP2OoRBeIzHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6176
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping.....

Thx,
Yangtao
