Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD45478AB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Dec 2021 12:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhLQL7t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Dec 2021 06:59:49 -0500
Received: from mail-eopbgr80130.outbound.protection.outlook.com ([40.107.8.130]:14073
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230463AbhLQL7s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:59:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9I+soY0vT/pAc2vSrnQ0VQsIwdp8wMIiHoipJrsLMA35REbk7hNihswDwpKd7sa7+PMwRnXBVkq08pifdHAApQJUMpWya7NAYQ/RudXLBTDbxoUWl6Fse8Pz2tEaD/GePW3ZwISWYUaBNU/bIi2JUgvUjMiMUUlIjvrjXkT3LtvKY6lum3kOJrx+V2n4Zi6H2OCrwOBdQKTvm1aUIJYL9k2LE3TcBUEMkfxKlhyhy9MaqU2m+i9y9SY0kIKY+8oGt0rrVN0DNY5T3WivoRJLeQEP1AnO0tn9bDKpARByBzGhl4SfpZKHHCWskmmh5nuDBDt9jT7RXoIt2P77IUK3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8v031afYEdEE1GOIpntHt5nB8C6tAvMLLjS2az0lHNg=;
 b=C7zajwdlrZTtozxDSifU3jqC9UTXYkPQcrvqkS76FsyBo/brv0BRQfME0seWeWBTHqpgKxFX1N5cKKzCTURaYBUc5iVj/bPL/kiBQVTKQWeRNw7V1BlYdRtbRswRyC09vKvjMAQvFqfnFrvxkfU8u+/mu6ZgtcRrnKayQBL5kidf2HEYb63vxUyFlpRcq2b18Xx8VT46MHOW/5ZAyCxiXNeCAe5PNxYsFuxjtPw30bHhehvoyiQjT5J4CqNCoVfZxvF43sjuBRFeQrxfiH2zBQ8Bl/NYDtpQgvv7mu69cxF7I+7ZXdJE10HHZjwNBkvVsEYKCu7p1UCB8uIjQ9ThNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8v031afYEdEE1GOIpntHt5nB8C6tAvMLLjS2az0lHNg=;
 b=DbbA6gdO2cejt6pzCEM/cSfzsit91wUDY5mRAXmmHB3msg1fsR8IN20KpYVyVyBDAEfgnqMNUPWhTvyl3FoJ4UXlh6ZvhLyeVJXx54qk4JBJHYDdkcslKzUfyjt9T8/EviqvLtd3zj6YFAsbr1ofgeKqP9DUTEqnsYe/xPBnAjg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com (2603:10a6:10:257::21)
 by DB6PR0802MB2181.eurprd08.prod.outlook.com (2603:10a6:4:82::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 11:59:46 +0000
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa]) by DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa%7]) with mapi id 15.20.4801.015; Fri, 17 Dec 2021
 11:59:46 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] fuse: drop obsoleted lockd restriction in fuse_setlk
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Bruce Fields <bfields@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <b18d7be1-393a-1fce-685f-9ede560f70d1@virtuozzo.com>
Date:   Fri, 17 Dec 2021 14:59:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::10) To DB9PR08MB6619.eurprd08.prod.outlook.com
 (2603:10a6:10:257::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4e13cda-d916-4f9f-d3d3-08d9c154b86c
X-MS-TrafficTypeDiagnostic: DB6PR0802MB2181:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0802MB218137804F712CD3AB3C8AC0AA789@DB6PR0802MB2181.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UkRnJsOkeQ0HVS6Mfk8wYoJ5+hjkpwmydIX67B9Zs4BXWIy4WGkthpmwHbkkwU9r4hz/lkHoatAGG4TnBM2EITLIIoW/cMaQnhMgnPJSW+IEKbbfKw/k3RF/3AXOeu/kZ4eKFenwk20vU3izUYgBn90hBRLul2W6fLFTgoRsCMQKZMPnRWlm1gxuho4+hBbje0S6yzS5/kjIjTIkZIygZhdWQdjpayanCOvKh43FO8ZDnd3YT9g5CQJUe+jfP0lfWkVlBNE1qE0RtMy9mDxA9NngE7wy3o/ggyPmfpLpbmAxwrBN3bTMGS130tkNwydKOnOeD4nIkOx7WUDISWblC3Tv7OlGNpb0BWqssTwB1bcCbdATFIFUVbD2KtrJ322qEl5nlXB0XFEasuCf/CP9Anw5c4/KdhAppNyEYTG2u2AeQPW1z6kCjP690FN+bErr61Jq3RPP4NO6LwG00FxQFtr7BC7/+5x/g68kfNE/NFjVLqP1PdfCcLA4OvlTkKrd9xZnWgntdDjb0CnC4tqO+z2pY2egkdjzv3jZEz0F+1fhvCQstfUNVKWwtKARlhytCC2DAbNrpizCvAUWbkeg/Gywpiejsqd5GhAMSZYjX8J3ujEpR7ZC5QU+6sISxFdn9iYCTY/Kqi3en75qFdvPkcYehUhu90FL80JPSN1xRl5flgsyDe0tcrLPlnjEAyCCdQ0Nz/2z5GiwbM9kTe8JUTThDVwsM0nHtYKZNj0/CiN4G7YMOrJ49Y7uht82E2qkLPyMSNfKpNtSCeSP01wrEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6619.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(6512007)(54906003)(5660300002)(6916009)(8676002)(31696002)(38350700002)(38100700002)(8936002)(508600001)(4326008)(66476007)(31686004)(66556008)(2616005)(6506007)(36756003)(66946007)(26005)(52116002)(86362001)(83380400001)(186003)(316002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3FoYWRvN05zaWpxbXM5VXpjbTAvYmxKV3VvOGxOaXlWT1p1NE5LK01ZMXEx?=
 =?utf-8?B?bGptRnVxaXBWaHhxelllaERQSjlDd1cxdTdETFVsWmJ5eDE1cDJ5em1RT3Q0?=
 =?utf-8?B?V1huS1d2MnZrd2loWTZWSTlCN2pKT296ZFA0aE9yZlBCYWtOR3Y0STFwQUUz?=
 =?utf-8?B?dk1mR1BSb0tJRlpkMy8vc2lXUEhBTUdHYVhlTW4xa1hlck5aREpFK2szV0dt?=
 =?utf-8?B?WTgyK1BNUnJlQXdvSnN0a3dmZUpCUW9Pd2xlbjQ0ZFR0RkI0ZitpY3VJdkRK?=
 =?utf-8?B?SUxwVFNVTXIzQmoyb0JDdFdMaEl2QS93RExReC9QVzVOcWd4S3RKVTNkc0Zo?=
 =?utf-8?B?Qit6OUtEZlp1K0JTMzRLRG8wTzNabDVzdjUyY3hYKzhDeU9YdDZtUXcwRENL?=
 =?utf-8?B?eCtIRnNEcis0WVJNT0JVZmwwN0Q3OW5KN200TTlVUkZTY0cyeHVaSEZFc0FR?=
 =?utf-8?B?OGVCUmJDZVVtRXBJbEx3YTZuc1dkdm9KTVN0bTN1Y09WbzBJb1RFRm5waTJU?=
 =?utf-8?B?WUlENG5FRVNWdFBQeFNIL1hQN1V3RHFXMTJKbXdLMTE4REFtRUE3dmUwRHh0?=
 =?utf-8?B?VERFdERnQXV2TnNTbGZWNkNIZGtXSi8xMk9xSGxWS0J3MXhTN0hhZ2sydGFO?=
 =?utf-8?B?TmYyZVlMUTNXdjU2NEU1WERLYkVtZkNUYitqcEFVT2h0c0RWVGNWRjBSd25U?=
 =?utf-8?B?QWVPZldJNktjTjNLV1BkYUd6WWV0U2o5U2tJY2xJbm0xMVRrQng4VHpJazFq?=
 =?utf-8?B?RUp5b082Q0t4ZTFTNjBmU3liNXVEZ25oSU5oMXdHMVBEWVV2YzBUcXUvMzF0?=
 =?utf-8?B?TVpxWVZNbmdScGV0Y055ZzVlNE5yOS9haWdVc0YzdHVEd2YxY0VWeXR2ZEZY?=
 =?utf-8?B?NmRMVHhQMm1pNUU2MnB5RVdHajJWNlptQWhMcGJJV3ZOVTZFcC9IeTU3SVpq?=
 =?utf-8?B?c3hTaEd0ckREQXlrSDN3aEFkY0Z3aVFnaVNJYVh3S3pYaEhrS3pqVUNZYkR1?=
 =?utf-8?B?YWI4SGVzQnhrZE5Xb2xCMzEyM3kvb3BtQ1c5dVdpbVBXb3R0VW9hY05VUGE3?=
 =?utf-8?B?V2owYlRKaGFOSHI2TWxEQUFNTVAyZS9wekdZbkdqYzk2QUFNK3pjNnNWOWQv?=
 =?utf-8?B?TGZaU1NCRmpsRXBlNnFTakloeDNMbGNJTFVsaHIxZnA4bTNZdEE5Z1RtdzdN?=
 =?utf-8?B?SHVEbFFSS1RYTHJ3RlRmcFFjMWJVM2QvbGxmN25nYkY1ZC9CNDkzcWphenJG?=
 =?utf-8?B?TktUdkV4NjRwSitobDhuam8rTm9VdUk4cnRBNzZ5Zm1EK09RRHdrWXFoa2t0?=
 =?utf-8?B?OHdhRHNjbXRLZG5QUXNSSmJCNEZWaVpqS2ROK3FYaTdKSFBPamZxajlRT29M?=
 =?utf-8?B?T096SFFZL3oyOG9adUcwRTY3UStUOUdCRUVPVHhRSHhpM0UxUFpHZmxWdHZs?=
 =?utf-8?B?cGNrclVLZnhnZlN6R1lpMnJSOU0vMCt3SmNrZmRVcjNwKzk0aElLMFg1Ujc0?=
 =?utf-8?B?N3BCNkRrdjdhdE5WcXJDM2dIVUJyTGVRWEwwV0ZNaWszQ1YrbEdtUE9VbXdn?=
 =?utf-8?B?WGJPNE5Ca2pMcThUS2hGUTRPS2VXUEMwWW1XRUdYMzNTUHhsOEpTbGl1YlNL?=
 =?utf-8?B?S2hoc2QxdVFNVHA3WndpR0g0U3gySlpFMkpMbi9zU3VpamRvSHZJR3FzNTc4?=
 =?utf-8?B?alJmaVZnYnJuU2huZ0hnb3pMTXFZb3M3NXRlQnZaWjdJVml6TkxnVlhFZ2M2?=
 =?utf-8?B?d1Q2NXEya1JmNFZnejFoZ3doaGlhcWMxNU10eDA1dkRQYmpzcTI4WjhVVU5J?=
 =?utf-8?B?QkJFYmdkKzNIV0tlVmxVZkNScnVMM0pKN1ExYjc4ejA3b1FNL2pxNGx2bmt6?=
 =?utf-8?B?UEJlWExrQmR6bUtVcWtzczdpTU9iYlZEQjFxMGMvWk1KUGJEYTVzbEVjN3dW?=
 =?utf-8?B?amxZUXVoeWtNRFJ0VGtCVlRTQjhNeG0vMU5ZNVVCanlyWDJrM1UyZG1VR2Ry?=
 =?utf-8?B?UWdkM2ZCMzZza3dORXlIK2MxVUMzM1plZDd2QWVoN1p0KzRSQURHbXloNGpS?=
 =?utf-8?B?Um8xZEN0N3dUWDdPUXJ4RzJiRS8rUi9zWDVnZkFUZTdZdEdsOVo1NWFHRWN2?=
 =?utf-8?B?T0JTMDJpTDRpUXcvVm1ZVTZGR3hlME1lYmNyZFFxc1dvVElIeFNJQS9BNER4?=
 =?utf-8?Q?eFqeKewKlmn6Ps/SK9b/sa0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e13cda-d916-4f9f-d3d3-08d9c154b86c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6619.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 11:59:46.6792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 869qIHj6p4/vqoxF9ssTXAB6bh+QNcV1ddVmwfsk8LZnXMkAy9+OXw5hlMyFHs4dH1i3f7Ze1L88XrOKhuXj9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2181
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kernel export threads like nfsd, lockd and ksmbd can deadlock if
exported file system does not support asynchronous processing of
blocking locks.

Some time ago this problem was work arounded in fuse by commit
48e90761b570 ("fuse: lockd support"), however it was not fully
correct because of all locking requests was disables including
non-blocking (i.e. w/o FL_SLEEP in fl_flags) locks.

Now this check is incomplete: nfs v4 does not use lockd and handles
locking request via nfsd directly, recently added ksmbd uses
vfs_lock_file() too. However both these servers does not have
fl->fl_lmops->lm_grant defined.

Original problem was noticed again, and now it will be fixed on the
server side: all affected kernel threads will not use FL_SLEEP if
exported file system does not support asynchronous processing of
blocking locks.

According patches was submitted but not merged yet
[PATCH] nfs: block notification on fs with its own ->lock
[PATCH] ksmbd: force "fail immediately" flag on fs with its own ->lock

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/fuse/file.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 9d6c5f6361f7..06e0d7fa86f3 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2509,11 +2509,6 @@ static int fuse_setlk(struct file *file, struct file_lock *fl, int flock)
 	pid_t pid_nr = pid_nr_ns(pid, fm->fc->pid_ns);
 	int err;
 
-	if (fl->fl_lmops && fl->fl_lmops->lm_grant) {
-		/* NLM needs asynchronous locks, which we don't support yet */
-		return -ENOLCK;
-	}
-
 	/* Unlock on close is handled by the flush method */
 	if ((fl->fl_flags & FL_CLOSE_POSIX) == FL_CLOSE_POSIX)
 		return 0;
-- 
2.25.1

