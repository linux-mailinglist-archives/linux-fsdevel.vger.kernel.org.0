Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF137401CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 19:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjF0RBI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 13:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjF0RBH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:01:07 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86751E5A;
        Tue, 27 Jun 2023 10:01:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUCUG5DGrAdR4w0KsZLnt7NTsR8vDkZpDq5uiJrkhaYu6rN8h0xoRc+ObHARJuvy2c7Zqdv1sqjSvUNo73dFTggeXsF5qEUBgME1nJL3XsnPCdSSgR6iJxAkdnRv9SEf1kbrJhVFMCzTLJLBrFff0fw13zBqTPzoDZwtmYY4E4VjI1S9Y47hWkV+57W1iLwdr9MZDuDgGO1JMwptLF/LiQ1YxNfUsFLDz29tbHw5t5iS/AWYZMTJkg7F4hz4DwxVT2tIMIojF4a+CYRmNo2odVEnnrV+GRwY2ksWxorYSCPnS1nn2HGUtveRHHAnW06Vyq69W792/QlIrV1Mum4sZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBJy0LpU1VuHa/VdbjhCRamFKFh23vKKUGeV4YuYxjo=;
 b=iI/GDFma4jkENPkv9fdeSCOjgLazxrN22ijO/REdXuE/voPt8rjxPKA/H8LIdyIplDK3RGP21uPQn129rieQBKgu/KpA240fXxrjF6sw/PRWMtqbWJbrYAHZELflm2ovtRbGlurtMUdOqaGHpUWztGAgSN0i44kBls+Im8yt3LvrIf9KHIRNIpxJ4+8KYOslfCCBEsUqyNaOk7usdNM2MHr2E0uSpBEsXORQhbx1GHVfrLiJ2ARCtRZY/DTAp1ynNqJfhe1kDMn23M7qygeGpsNCMBafvU6nQtfWUU+0Oqekt0LWe0cBhS2DTB6oAAyEqxQwNVQsGxkVnHUBlhKfhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBJy0LpU1VuHa/VdbjhCRamFKFh23vKKUGeV4YuYxjo=;
 b=ZwAGZfHU8Uytwdqld7IkFZ1cVpKg7rCAvJxLAOnBZIAc7jeMDnNVUbGp/SNn/g0ZA9dH0UnFnz4YF9OQAexyLWFNuhN5m2JRx0VBNgxVpKzgrcwyBi3OjTOpNDa7gVIsMh9SDZBXsmds+BwmuxCEztwePv4UB7iT6xsyAsCywDCl/vz8ZdqdtST592jRyzLSDMt7PeUceBCfASycvxT5fAgoWgG4q4zxkvIpcQ9Bqy3PYxb9G3+nSfkbBDjkhi8mfCL+lTBynAbysBPMH2/ghbmXl64svwAuE77N5PvdrY9TRKsAuN8mA0cMnZqoEgsh1FN7YzejRS44rpoXvHS7GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 17:00:58 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471%7]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 17:00:58 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Naresh Kamboju" <naresh.kamboju@linaro.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, lkft-triage@lists.linaro.org,
        linux-block <linux-block@vger.kernel.org>,
        "LTP List" <ltp@lists.linux.it>, linux-mm <linux-mm@kvack.org>,
        "Richard Cochran" <richardcochran@gmail.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Christian Brauner" <brauner@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Dan Carpenter" <dan.carpenter@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Maciek Machnikowski" <maciek@machnikowski.net>,
        "Shuah Khan" <shuah@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>
Subject: Re: next: ltp: fs: read_all: block sda: the capability attribute
 has been deprecated. - supervisor instruction fetch in kernel mode
References: <CA+G9fYtKCZeAUTtwe69iK8Xcz1mOKQzwcy49wd+imZrfj6ifXA@mail.gmail.com>
        <89dfc918-9757-4487-aa72-615f7029f6c1@app.fastmail.com>
Date:   Tue, 27 Jun 2023 10:00:51 -0700
In-Reply-To: <89dfc918-9757-4487-aa72-615f7029f6c1@app.fastmail.com> (Arnd
        Bergmann's message of "Wed, 21 Jun 2023 16:08:50 +0200")
Message-ID: <87y1k4suv0.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0072.prod.exchangelabs.com (2603:10b6:a03:94::49)
 To BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DM6PR12MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: acd871dc-4065-4066-29c9-08db77301454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uQR5bUEeDR8bRPE7iCeSDB2ii2Sdk9Yo+7KDB1Hh7wfPRWUvFkSDtDG9HQtlT33J49nvS3z2MC/e8DkLsvxQhK+Z+KkayfEV+65CN2a9n7qD8AKTFn485njtVYUj9ss4qYFlsxB9EQ+LsJFv4DYGSw7TkGBkuwhQ3WODMy1jONl4XGOuWx+YEAOPWL03bFRLzVlAqD0NTTfwr2sSpnha9h9/d1WmXIkkPx9ZxqoqD1R+J9dawvt54inkPkNwEI8SzJVt6vD3rR8bH0rOa+9eOgWBGvtVi/zC9kyFPT5GDF2/eu1XAiAbXlQs75nspeqBF5Wl3Qg7MX1wc+hP4XF4PwrHvu5WQgJEg7ilJczJOLOQ8mHL3VeRPVmPwBhjhNH1Fcm5k5u2chamXxLy3Bjml90F4RlfqS5TWualpJDhkCNqGl2hXed6RwW5mu2oZB4S4nVf0sYrQpBqiXy2ZI6PJuET0Yx6GhJjpppvrvqCaEmTImWT6KgKDSvgdRCq+Iuv2uXAIXD8lCM3jwBidKLDonbZ5nRDcL9rLEzpEJ7HOpf5thItOOmVqhRaDebqiUL4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199021)(316002)(66556008)(66946007)(6916009)(66476007)(4326008)(478600001)(36756003)(8936002)(8676002)(5660300002)(7416002)(86362001)(54906003)(41300700001)(6486002)(2906002)(186003)(6506007)(6512007)(6666004)(26005)(83380400001)(38100700002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EiJlR6CJwwgPeVljC+tYpsG6j3x5p6ElCcgHmOs2t/+VzHwa3hufnfD1I8j8?=
 =?us-ascii?Q?aXe75VWAHtbBhhUzmTvxNMimWSDH1SX2HTMERD6+nsqtcWrj2ZTzDbZ1DBIv?=
 =?us-ascii?Q?moieo5CQX29WymDnNO+4h7TAuY2Gk7O/+UCY8u0aUa5ctCrDL4GFzuHt4sCZ?=
 =?us-ascii?Q?1g5mtEs6FWs/7t14Os2d1eKoKcChU7CpZslpJZ/YzdAG4GoNOidjOJkEuXv5?=
 =?us-ascii?Q?45ehgH6RDCwfMV/IcN/yzP51db7ap/R1zx/1wQxzwTxLkMQ6YiIjVDrHc76N?=
 =?us-ascii?Q?AcdDGIOhYzPRVCFCjlmuokeuCJBSN86SEl5v7+kkR1JYuqbtBytQMISMNkQF?=
 =?us-ascii?Q?TRhal2o+K1JVb/MvAGcpdWGKsavPuclScdfvVPp6KN0GRM0CWBVOBwm4aMu+?=
 =?us-ascii?Q?DNPuOGFWAfblXta9GLUnd9ZOBKi2JCaDp0kvoEDICl1fd9O6Wv3bajflBk6+?=
 =?us-ascii?Q?QqncGDFWoH81ZlsWEci+2Cjwx3u70cYyFJnBgs8vvM1eUjlV8Dbu+k7q4yGd?=
 =?us-ascii?Q?iB1EkQc9ROchetUS4m1X/uYJoSKFIETzLi0UAIcaOAmtbBg/QkkYA6VIXZpJ?=
 =?us-ascii?Q?aTa364Ddam5cA1sU01G9cc0O4BY2v+JD1CbcWBALOeRICsEY6pWCImAY8TT/?=
 =?us-ascii?Q?AqjJbVtznIV3Q4JSX6P/zgNpgYEZ91Beb2RLQgCMK1PaDK/F0dGBTElrOmbt?=
 =?us-ascii?Q?FTM8xmTzZvjkOJyj1sDpjC5jxe95pnbf8YT8OMkeDzN/pV+pfghqaovBy2Ip?=
 =?us-ascii?Q?XqGRatuY4OKaWvSCEY6qLQGk+CAjzXDfK6qUpxRU9vyw5PdYBNQlovktYABr?=
 =?us-ascii?Q?o3V+WCGeF6iuqIrc4Q5X/F5F99UH4KkzzbryKzifYrm71kmkFPOieF4pvXwt?=
 =?us-ascii?Q?zNGi5AMX2D0Xpuj6LMIt6RVyF4yoBIJK067ao9LOhubsKdwdD9Yorqjdi0Iw?=
 =?us-ascii?Q?T3oJnp03/jHtLCVUAwVisPjyaT4T8guIArWGHwXRnMqylRupdcV48jIxH2Vf?=
 =?us-ascii?Q?ZmLy94LCqgIjtbWP5YP3fL76T11EWwEO88SykWFjhqa5QUWb+sd/YtjmX5lI?=
 =?us-ascii?Q?7FzJUuYCmZijLvtFC1LcPruLFymB7qmja1MFZyext45ZeuA+IHscKXOEc9/N?=
 =?us-ascii?Q?Q3+pCdXYPCyaNsFjba9CWEEEEU+aTeABjL8FBXlRxcIXfu8ApQdcKsjvS1lj?=
 =?us-ascii?Q?rSmNZWzt9OTMuD9wYaYlyFQYD9Opkzikpfe4774kNQLKU2nyIkGFGgnDfcNu?=
 =?us-ascii?Q?evRVDr9czF+HjXlpJa4JmN1KzaHTJj1b4KJmYkwXqMEZhXieHRf8AiwuAiul?=
 =?us-ascii?Q?cMlMBAQD4X1M9C012F5dyYLf5bSUwmi4qZEfm139NhKSZvz2n1TWsSqaQ3OH?=
 =?us-ascii?Q?ZTjP7289mCxUCGpBqjAnhbGSnqxpBDbSGpw51Dy6xVr5DD8BvxGg797K5jXD?=
 =?us-ascii?Q?xXSlj2G1CNtQoc6jcRH1COPDgwCdKJQGAIH78H12/JQqBJr/W668hCsXpGWj?=
 =?us-ascii?Q?gsQN7QSM5fgGdJVWNlHU6pYaqJOTgD1IDfM5AYHt8LLK9dUNs25fPPf1w7aQ?=
 =?us-ascii?Q?8qi9qnreuXB4mHHnqaxquK64+j2HW6LmBiXDUpxN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acd871dc-4065-4066-29c9-08db77301454
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 17:00:58.7888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJC5OKIHw49xlIGm9rHZrOcNsXcKDVubrjgKKUIA3ZROFaHICXD6Kdr/9gWGrP96HWGzHrf4Hm9pbs+Om3yg1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 21 Jun, 2023 16:08:50 +0200 "Arnd Bergmann" <arnd@arndb.de> wrote:
> On Wed, Jun 21, 2023, at 16:01, Naresh Kamboju wrote:
>> While running LTP fs testing on x86_64 device the following kernel BUG:
>> notice with Linux next-20230621.
>>
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>
>> Steps to reproduce:
>>
>> # cd /opt/ltp
>> # ./runltp -f fs
>>
>> Test log:
>> ======
>> read_all.c:687: TPASS: Finished reading files
>> Summary:
>> passed   1
>> failed   0
>> broken   0
>> skipped  0
>> warnings 0
>> tst_test.c:1558: TINFO: Timeout per run is 0h 06m 40s
>> read_all.c:568: TINFO: Worker timeout set to 10% of max_runtime: 1000ms
>> [ 1344.664349] block sda: the capability attribute has been deprecated.
>
> I think the oops is unrelated to the line above
>
>> [ 1344.679885] BUG: kernel NULL pointer dereference, address: 0000000000000000
>> [ 1344.686839] #PF: supervisor instruction fetch in kernel mode
>> [ 1344.692490] #PF: error_code(0x0010) - not-present page
>> [ 1344.697620] PGD 8000000105569067 P4D 8000000105569067 PUD 1056ed067 PMD 0
>> [ 1344.704494] Oops: 0010 [#1] PREEMPT SMP PTI
>> [ 1344.708680] CPU: 0 PID: 5649 Comm: read_all Not tainted
>> 6.4.0-rc7-next-20230621 #1
>> [ 1344.716245] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
>> 2.5 11/26/2020
>> [ 1344.723629] RIP: 0010:0x0
>> [ 1344.726257] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
>> [ 1344.732780] RSP: 0018:ffff98d38123bd38 EFLAGS: 00010286
>> [ 1344.737998] RAX: 0000000000000000 RBX: ffffffffbea38720 RCX: 0000000000000000
>> [ 1344.745123] RDX: ffff979e42e31000 RSI: ffffffffbea38720 RDI: ffff979e40371900
>> [ 1344.752246] RBP: ffff98d38123bd48 R08: ffff979e4080a0f0 R09: 0000000000000001
>> [ 1344.759371] R10: ffff979e42e31000 R11: 0000000000000000 R12: ffff979e42e31000
>> [ 1344.766495] R13: 0000000000000001 R14: ffff979e432dd2f8 R15: ffff979e432dd2d0
>> [ 1344.773621] FS:  00007ff745d4b740(0000) GS:ffff97a1a7a00000(0000)
>> knlGS:0000000000000000
>> [ 1344.781704] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 1344.787442] CR2: ffffffffffffffd6 CR3: 000000010563c004 CR4: 00000000003706f0
>> [ 1344.794587] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [ 1344.801733] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [ 1344.808857] Call Trace:
>> [ 1344.811301]  <TASK>
>> [ 1344.813399]  ? show_regs+0x6e/0x80
>> [ 1344.816804]  ? __die+0x29/0x70
>> [ 1344.819857]  ? page_fault_oops+0x154/0x470
>> [ 1344.823957]  ? do_user_addr_fault+0x355/0x6c0
>> [ 1344.828314]  ? exc_page_fault+0x6e/0x170
>> [ 1344.832239]  ? asm_exc_page_fault+0x2b/0x30
>> [ 1344.836420]  max_phase_adjustment_show+0x23/0x50
>
> The function is newly added by commit c3b60ab7a4dff ("ptp: Add 
> getmaxphase callback to ptp_clock_info"), adding everyone from
> that patch to Cc.
>
>      Arnd

The issue is that we introduce a new sysfs node that depends on a
hardware capability not all PTP devices support. On PTP devices that do
not support this capability, this leads to the NULL pointer dereference
since the driver callback for the functionality if not implemented. I
will submit a fix to the net mailing list along with the appropriate
recipients.

-- Rahul Rameshbabu
