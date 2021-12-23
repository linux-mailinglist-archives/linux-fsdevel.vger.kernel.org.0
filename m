Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EFF47E24C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 12:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347959AbhLWLb4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 06:31:56 -0500
Received: from mail-eopbgr60123.outbound.protection.outlook.com ([40.107.6.123]:60903
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347908AbhLWLbz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 06:31:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQ2XtozOXxxcRy7531iVkIZ9VULLgCf58WJnflPqP8pTQ+lhzedhoduFlwiQ4ftWpPzBFoQZKyEzCf3oW6J/bU7xA1xnP/67FAkBAaBEXOU3cgcN284V3XAnngYrzP2tu5J25OayvgS7c/0ZC5VDJnMn4qxBsFsvmQGkOFgkipiAAsGt5nHvKtHMS4KfKi4GxSMFnNroZoS7fiau94npDtrglT1B2Dg4uBQFBB/RFSBFSdzugQcv0RCjc1mGaNMaoiX4JG6P9KNjDRt5DmrwBZ4tlRLUXKB0WpjB1je/w874FBFNS5e+g9xZOTzLC2t6U4HNJkSMwu9RlifuTR8RkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLavwZwQ+HAhoCQ2TUbdK7ygx8UNz/tX52UXmGV13qc=;
 b=UjAzqfJhtmSe9HwHYspCUGEDlEC9+Z7EYUwxXraUAsjJfrC1iq77HwOOF0XYdPTOLP3Trc4LjmAYoxf4NOtlOeXPAq4p6o0Tk77+7g1S4SchwK6SbFErnAfcDzvaBPWQnJplnI8lWH0A2ABY6rwsVa7khvCmnUhNsatURVKe8PFduPOQhIwF4SlKKBkyfFVou52P6SMh4sws+V923vA0eSEKqHax5+TO1DAHd/SNSj6jehHL9uLpMB0uW3WZGr1zLDQJ4rr1AxzaB9vpx2V8+U2pRMCpX308a+TjJglLRv0m9UId4rxn6LPKQoIgXEsvdMr+m2zYyA1pce9v0V9Auw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLavwZwQ+HAhoCQ2TUbdK7ygx8UNz/tX52UXmGV13qc=;
 b=VE+b2fOI9VamYPYtHS2mAGImOPMMbPWgeGaOicxCsNoWucUffhkpqkfkdmhSbwzflGeG4tEjyuRcpR5JfaQZCaLseDMlC/cBSRlwyXtDG9QuzADee3LUbkr7/hcHFiT89O0DezHBD3PfsZVdlQx2tt9JSmRc+FZby1LRb5FkcAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com (2603:10a6:10:257::21)
 by DB7PR08MB3147.eurprd08.prod.outlook.com (2603:10a6:5:1d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Thu, 23 Dec
 2021 11:31:53 +0000
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa]) by DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa%7]) with mapi id 15.20.4823.019; Thu, 23 Dec 2021
 11:31:53 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] fuse: async processing of F_SETLK with FL_SLEEP flag
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     kernel@openvz.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <f0b7b363-2820-d184-52ea-c67bb3e4054d@virtuozzo.com>
Date:   Thu, 23 Dec 2021 14:31:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P194CA0015.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:90::28) To DB9PR08MB6619.eurprd08.prod.outlook.com
 (2603:10a6:10:257::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 672017f4-2d69-4284-5196-08d9c607d19f
X-MS-TrafficTypeDiagnostic: DB7PR08MB3147:EE_
X-Microsoft-Antispam-PRVS: <DB7PR08MB3147F9DBACE8990E94B9F2E7AA7E9@DB7PR08MB3147.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zdT/V9p3oHthwmZ+ymq72S3f0UGE7AsRSIiPtGI90s6rs76FLaI0CuARNEZE9Y+cNgeS0/l/6PFs/345PRMyu1EQNFpMYqGvd2jjpmmWnNwoXKx1ItANs2O5v8r24dk540E90DNvSzGG5hLkrJAPul9NP6D50asMQj0AKLOTqCKUAUpKk9wnmUQtsS3VTrG8Jz3XFgSOeGinjvw8+/5iZEbq+QFnmvhA8piwElJ04id8pg0pofy60p9rAC6cPmJf0PBJa+bkNTkeH6vsDGG/rctCeti9v67Q3d7GBemo4jl1BAuHnfwVCiEKI6Iws3ZSqs75oy8lrUmYElJTwDjebyo8wu1DbjKZLYcDKd8pt70Tnpeh8S0dhc3zinb4pMJddkBRlFypHRM1PEgnWTc13PnnOPPug9fxoE3qz60TXCwBjRiQBRJH7QeLV1T87W8QpO5L0r591TGOl6KEpliZQAEimHb0SWR7OP2BZJIZEEwOWwjH5NdkYypeVi3daZWxrTiclTslSTHXIWEpciXwquYQlYP6gFHS30DYgQztGWHZyvoKbfYeB1QVavSfcIjeKarHrXOHy1xqbQVOSLljMGlh3ODL2wdxIqzWWYycQC0E+cczBnnCtybCwH5QxGSuNTT5DJ+XA070XVFQ5cUlzKD91kLFzagndDcUKrx5U2NOehTgJrI7NO3fBVgm0A/dMpDmL1SRN0qbcXOM6hNBIJlP6B/mn/VdYdnvDGMD8vcRHRo2Jt44DouL/4vhJbzwOjHrZ7YvXse4e6pMKNCAFvgAix8Oysme67Fowf7K8Bx4Umy7ajJxP+C17TgM+mA9sIxKcoM/+KwvTYr0TRsZJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6619.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(4326008)(6916009)(26005)(36756003)(8676002)(86362001)(38350700002)(52116002)(316002)(186003)(8936002)(508600001)(966005)(66476007)(66556008)(2906002)(6486002)(6506007)(2616005)(31696002)(5660300002)(83380400001)(66946007)(6512007)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0lTcUh1SUxSRSt5bnh0RlVlN01rTzRIMWZNUjVRL0FPNXRqa2ZsRGJwRUQ2?=
 =?utf-8?B?TzZUWks3NkJrU2FUZnpIeVVsN2pxWXRsMEZJdjlXcWxwQlUwdlI1MisyYlBI?=
 =?utf-8?B?S1JNREhYc0tPYjBnVXJlRGZsbDdtQXdZM204bGxFelhJYzFaK1BKREVMMzk3?=
 =?utf-8?B?MmVvN3FsZS8zNUdEL0krQjZ2U0xwQ0psNUlvbXhYdW9WWVNrQlhYYklEVUZ0?=
 =?utf-8?B?UjlQVGxsT2lJd1RxUzVUOEU1M0UxN2FWdk5jQXV3YlB5L3l4M2dHYUlvYVJi?=
 =?utf-8?B?VGQvdWFmZWkwQnIwNW1IcW5GWTY0WU9xb1hzbWJFVzhpbWVmZ29pNGwrMWl1?=
 =?utf-8?B?WDZ4Zi9NdTRndVRUMVNjd1NKa0NvV0ZoYUcxSGJ0bjEzTWFLbi94NVpxcHQz?=
 =?utf-8?B?Qmd6OGErOXZFdUdrbDFtamVyNVdQaHlxY0ZoZVN0bU5ab0lxblVIUGVFUGMx?=
 =?utf-8?B?NW90UTNhdE1ZVUI2NDkvUXh6NEx0b00zbll3cktGYXBIM3ZDWUlidnBPbkU5?=
 =?utf-8?B?cGlOZ0JiZmU5Wmt3bUk5c0NRU0dva01YV1lpRGZqcEREN0J1WmRIM2I5KzhM?=
 =?utf-8?B?czJacGQyb1VlSHZqaHdCMUNDSEJPLzU1Yk5idCt0NkhzWFJTeFgwVlJqczV2?=
 =?utf-8?B?Z0lQOVd0UWlyNHpCRENZSEJidmxpQzFVS0pHS0prcFN2QUI3OHdUYnVLNjJO?=
 =?utf-8?B?UGRVdDFGY00wK2tFWXFYTWZHeUhQL3dvcWVXKzZRV3A3VzhqS3pZU0VUOFpD?=
 =?utf-8?B?ZEFieDNmZnhocnZxbXVWN044c05SRWhDWDJKblNuamVIM1VtOUNJZkVyUG85?=
 =?utf-8?B?WU5KVDNiYis1QktpeTZtcVRMWVVmYk1uL0ZsaWNEUk1Gb2htMG1yWUZxNlgy?=
 =?utf-8?B?TmlSTWV3T3BRL1g0UDg3RHZ2TWdpazlBTnBFeG4yMHlZMUdUWFhNN0RUV3Rj?=
 =?utf-8?B?di84TWpMMGE5azVoN1dIM0xtRWtVc2gzZ1JkRE05RUJvNFloM216dG5QbEln?=
 =?utf-8?B?aFFPelhVUGdkMXFVSnJsWFdpZzlsdXU1OFVFVU1KM2RCMUFTZXZCU1VpRjRB?=
 =?utf-8?B?MjJCODFmaWE5MG91Vm9md0R4djZDeGFKc0N4UjJVcHNRbmRwNEhEMWNBUnNk?=
 =?utf-8?B?MWtNdmtieVZRYjEwNmlBcTZmS21yaXhWdUtJU3lCMTBjMExhaG5DSVQ3VHgy?=
 =?utf-8?B?TlpnWUxka0lYR2k5amZKU3lsdm1hUW9pS3N6ekFKdC9iNTVyZ08wREpmQ1Rn?=
 =?utf-8?B?WkhJOHprWGVWZ0lUQ094TFVtL2pzakFWbHZobXhQMnZsV3R5bHVKeFloTGUr?=
 =?utf-8?B?V1NvY1dKdlFrdDAzdTBBQ1RqaWM4OFlNNGJMbXlYMEFqWXRJSjlldFAwYjhi?=
 =?utf-8?B?SFhBZ3RMa3NTaHlQaVd2cGowMG9KblZmRktIWGhuWGs5cU1vM2lWMXVNTmhj?=
 =?utf-8?B?YUxvUHJnTjZOQXV3aDd0U2E5N05IaGxFZzMrOTlvNTE5Zm9HRmV1dllIbGFz?=
 =?utf-8?B?SXBCSTBTK2JMVk9Mc2I2L2F1eTZPL0N3Z25XQWdXRzRPR0IzTjRvSWVoNnZm?=
 =?utf-8?B?Q01pMHZtQVFqcTFReXFXclhFL3Z1N05sTU5Yb25FazR2NUxMcmRNU2hZb2tY?=
 =?utf-8?B?Qm55RjNiemRDYTcxOUpRQ1QzWEZqb2VyTFU4SEVCcnJqN25NaWhxcTFqZ3Mx?=
 =?utf-8?B?VkRLTndVdWt4ZVRmM3h3a1B0TUp1Sjh2QlZOUXVjQ3k3bStwaUhaWmRWZGla?=
 =?utf-8?B?d1VIYjEvM2QyOTRmUW5TZTNxQXowdnEzVTlHdlUyQ1RnQ0JDVGhXNzJLcTFX?=
 =?utf-8?B?aERBOHVZYzgzZmszc2ZKek5XWERkYXRDeEJ3OEhoOUhGWExvczRHYmM2RE5E?=
 =?utf-8?B?b0lrUi9YQU40ZGVPVk8rV1dRcXpjbXhvdDVlTDNzUTU3U29JYzNvNFIyaWIv?=
 =?utf-8?B?cTJJOEFOLzdhb0twakRXQ2VhdVFaTGtnWWlYWnloWnN5MTF6QjlQb3BpSTlE?=
 =?utf-8?B?eDF6eUlhUEVEd3QyVXlpRHY1U2dUOWdLT084RkErbUxvbEV2QUZHbVIxMlFY?=
 =?utf-8?B?bjhoWFdQQXNzTmFMY0RkR3A2cmozSlczZjlISGl2U1lzWTkzRmx0MEcvYTNs?=
 =?utf-8?B?WjJLUFlXd0JzZTdidS94QjZvYnYyOW12dVdtaUF0dU1FZFEzcmFjNEt5L3Mx?=
 =?utf-8?Q?XKy0SkRPPpCwadhvU729SFU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 672017f4-2d69-4284-5196-08d9c607d19f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6619.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 11:31:53.5109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWSq2MoTM2Dm7voD3reeweTlY5PtdnnQH/1DIUe9CCz5Ij1/V2ww83YBOfX6J29rV/h6QmAamMvETVyOaL9zgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3147
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kernel export thread (nfsd/lockd/ksmbd) use F_SETLK cmd with set FL_SLEEP
flag to request asynchronous processing of blocking locks.
Fuse does not support async processing and should drop FL_SLEEP flag
to avoid execution of blocking FUSE_SETLKW request.
Dropped FL_SLEEP flag should be restored back, because it can be used
in caller, at least in nfsd4_lock() does it actually.

https://bugzilla.kernel.org/show_bug.cgi?id=215383
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/fuse/file.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 06e0d7fa86f3..54a9a5d660a6 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2540,8 +2540,17 @@ static int fuse_file_lock(struct file *file, int cmd, struct file_lock *fl)
 	} else {
 		if (fc->no_lock)
 			err = posix_lock_file(file, fl, NULL);
-		else
+		else {
+			bool async = (fl->fl_flags & FL_SLEEP) && IS_SETLK(cmd);
+
+			if (async)
+				fl->fl_flags &= ~FL_SLEEP;
+
 			err = fuse_setlk(file, fl, 0);
+
+			if (async)
+				fl->fl_flags |= FL_SLEEP;
+		}
 	}
 	return err;
 }
-- 
2.25.1

