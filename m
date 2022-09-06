Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45755AE0AF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 09:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238523AbiIFHMl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 03:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238842AbiIFHMg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:12:36 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCD9EE38;
        Tue,  6 Sep 2022 00:12:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJI3yNFdawpK9OkURrgxnOYAN5gF2ZIzOhly/w8dI6ogx2iJZIVKCTTu0DLzwYy1BChyCwZA9Wdd977FTaYPxoZDc7HvCI3oyhzKg4wLNsOT9dMfJcZj52TpFStpsrsnW07zU+voVA/xjNGaKKKZZRizRfuBQsAd32uPr0XktDEJLv3IC5+Eiy9Ht7ATjLMm3oh9yCpqdXn1/n6xjXqXue6MTmdCDvdHy16sQZOBrKHk1TkKRkTAf8POkEBwW5kZ0VaHgohP4roWw4yjdPS1ePdce6LaMqG2w8q02jtB0qmeoKRld+z4hAyf9EqJwtKxDQazaiVqfZuXPTmcGwYLXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fh4jEMCwsiTz4AfDX9hr+Z8KEmZhGlaQ41392WKNGcw=;
 b=QqTBPz6+lwEW9MBSvYE7Qckes46ID+VjoSm2XUVdmXE2wqJj0nn0+yA331P1OgsEP9U3J2DM49/8qWYu6dt88HDEEhdZzG3N8duAKz+d/YIamlKByGq5U9xw0IrjrbekYxd3vbI6jDivaWD16dHNHcMPlMxvC7FbY7JyAWVUNiZE0uuRI/EAur2R/YXvSJYEGM/HX5r7LbUgnB4uE5xIYvGwZlkLrDzjZwZ0CTy1N0+jV86QwfQ9n5wSUoD4t62xhne4t0kD0z+RJL2Bd1x0LQA/+Yvv18bJOYGAHj7nREe7cNSonlER1GYlI0RIXQs8pM7qGGxMJBxUnGdLEqBNkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fh4jEMCwsiTz4AfDX9hr+Z8KEmZhGlaQ41392WKNGcw=;
 b=CQGTmsQgyQAI6DlMJ/AAgTxfPq3hlXVKJU442AFYcCXP8OD3ClF8oAinKN+3IMPDbFgVTz0/Wv7VNfJkGA2oOQZ58MQWiJ7zdXWMLhRDK7M0dkiSEnziU28t7pFOEo1sE7if/lQfEHQ/nYCZjrsMKL2mRabBJj6lDegaWMIpMnWdmpDG9BQVNn+OWzk98t0hG5Bzr8LiTo5VOP/dG+oqWPxH6l0qeGvfEQvbJduHFLdAmwJD6mYAraQrDgy3QitCc9wrs+Vz0T5FUeWW7z6kBIpgN+ADPbzONfayQnaSGoDuBof667M2o0SuW4iNVSJycUiI2csEOwwFgKHr5prapw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by SJ1PR12MB6124.namprd12.prod.outlook.com (2603:10b6:a03:459::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Tue, 6 Sep
 2022 07:12:33 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::e0c5:bb15:a743:7ddb]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::e0c5:bb15:a743:7ddb%3]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 07:12:33 +0000
Message-ID: <2a0dbe25-f2a6-1aaa-8741-1956d06cde60@nvidia.com>
Date:   Tue, 6 Sep 2022 00:12:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 2/7] mm/gup: introduce pin_user_page()
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
References: <20220831041843.973026-1-jhubbard@nvidia.com>
 <20220831041843.973026-3-jhubbard@nvidia.com>
 <YxbquGs0QN3BRw4I@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YxbquGs0QN3BRw4I@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0100.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::41) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8f41250-2fdb-4886-fbd2-08da8fd72b1d
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6124:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I5/o8UisOxRf9r4Eu0pi5HVgOeZzHkZnJn5encTW+MpNdD8T95EpqiHEPg/g1US3CjEkm7FeIBLbBDWb3+XxWl20G1Xyl20hSriq1VEhE/peY2ACg3DThkULHgdk1Ks9j0uPwUCiLh4iIaVwSxR2dRVlaMIimm1Dg5Ck9ePGumDVa09wUUljU16qpis6mfYBAlCt4Xd/L3Hae19mmWOGUnEoKMUTws2wa1qW/AU12TtWqafdjpuuzu8rjVlmzxa+GW0K7IVdIbZfn/Fd0c0KmEjzOZCppxzJsmCMBU+cSZqWMtbat8eQs06veyxs5/l4VYu5efqHZ4Fru105pjiIVrqNiHV0S42sqB34EqIVxhpcKSDQwZ4nQbYt6Ms4nqrtCvg3GSrKOyYxZKEcUAttgJ4CYIJwP/2gkWXo6Owu9JGfWVTzWVcsvK3vI1b0VG3/AnyXUha3P+xHF+FGxUNvcAGPmGnwbg0bM2xtCtFNtbLTnBmfCJwvaXufsOXXrzVbm+4cnWpEqBdZSmoonLmzJQB0PPVmSzH9fUQ/1HQHpGDxLOAgGNZG/+CGHHHxpY6lwKt4RJrLhUZ7KegEpTpfzsmyKelWM2DSWeaJMD+b5SXujXYwRWIq83YRvjCE06HfBM0CjAqiq7Ml+vNRaWpIENYqHTlA+OSjf5ZTh13jIAU9RCo5R03SD39kJHGga2eKa412+eZIAJZoq/+32GSjhufSpFr6q4AECLUmopgha0zuRWBEAzNOj2M7pon9gVxMWJbc6CxnLNG3Wxz66P2yXzrfx/2y4tMCbDg0vJtCCEc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(86362001)(558084003)(83380400001)(66476007)(31696002)(4326008)(31686004)(8676002)(478600001)(66946007)(38100700002)(41300700001)(6486002)(5660300002)(6666004)(54906003)(8936002)(6916009)(2906002)(316002)(66556008)(26005)(53546011)(6512007)(36756003)(6506007)(186003)(7416002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnVmT2VjeFRuVXBtNGhSekJUKzB3TGxaTjVRK2I2VjVMU3RsMS84cVAvVjE5?=
 =?utf-8?B?TjE5amNJK2NGdDJNNTI0MitXTUVRQURJNmdDOStoNUFNSHV5Q0xwRXl3RHls?=
 =?utf-8?B?c0FRME1FdmljT1BpUWtsQXRjeE5BNmxDM0lUelRtb2cyaEFaRlhmTXQ5VnVw?=
 =?utf-8?B?aHZoUVVHaDBtdXRmdUFMM2JFaWJhZVVoVDhRdjdxbDNSbGFFdS9xYWNKYTR3?=
 =?utf-8?B?TllLU0s4Wlp2MmE2OGF5bldPRHlRZzBaUm9Vb0RXOGtManptMTBiTDVRVjRH?=
 =?utf-8?B?ZmtRdTJkRnRWcTBhbFRQWERtRk9pTzZSUHh0eXFISkZrckhPVVIyOS9wYW4r?=
 =?utf-8?B?emlPTE5RK1VLMzloWHNPMk5xOEg2Zk5BeFVqYVZDZWYzV01yZXU0NlhvdGZj?=
 =?utf-8?B?RDZMRW95c2ZVaytRVXR2YW5vWkdwKzlpdC8yTVlGdm55ZjI0ZFFYeUxReE5i?=
 =?utf-8?B?ZHVmcmFjZHVjMEsyYm8xZDJ1NVdVYnowOGdYM2pnaGJIM25rVVNtYUs2YWNQ?=
 =?utf-8?B?Z2NnWlJSTVhBSGQ2ZmJVR2hsMDE4WEZGcUR1c0grR0U4c3F4QWgxWVVqaTRW?=
 =?utf-8?B?QTdreThwRHlMY0pYTjlTZ3pLUGpFeW1jaCtUNXdpVE5Gb1RSSW9qKy8yWUdq?=
 =?utf-8?B?MHA2Q25kdElXVXFpMjA0M3l3ZWhXQkRqejgwdDdHRVFiUnVhZjk2Q21qaTg0?=
 =?utf-8?B?UmpyVkZUSnh2L3Vuem1yN2RyNFBSbHptMGNTUXZjWGdneHVKaDdMM2VodWV5?=
 =?utf-8?B?dFY5SUJUTCsxTG16V3EyWm1rMVA1eWtDTjFjcE95dUJxck1HWE1zeEpIQzJ6?=
 =?utf-8?B?dEYrTjdGTEsyQ1V5eG00RUpJRnVjdlJCd2NNL3BzK0J0Y0Qrb01yMDkzeStp?=
 =?utf-8?B?dWtkYWR6dmhNL0NVUkg0SVIrZk1QNWdlWVUzZGRvN2g2YzJEVDVnSkp6SU92?=
 =?utf-8?B?Rml1NmJaRkFrOTFmQ3AzQVdwOGFGZExWcnFzUENzRmIvUmF3MG1DTlpvMlh4?=
 =?utf-8?B?MElISkFISXhQMkdZcXhiZnVYRDMyVlRsZzBTdVRSS2lMZ1hNODdtTGVBSnk3?=
 =?utf-8?B?eFNDSVFoWHM5d25ONTJDcDlNanBCblp1ZnpHaDVWcHlFdHNnYkFqUzVQb3ln?=
 =?utf-8?B?YnpDT1lmaGNObThaOU1HaVVBUGtWQ01tYW1WNXJBT08vTHR1djBudHV4TGNx?=
 =?utf-8?B?SUJqbWk2N0pmNU0rYkxWOGZsbklFRzZNTyt0QnBjY2d2V0pKQnZhQ1JhVnEx?=
 =?utf-8?B?Y1RrL3N1V2pRWEk3OEJqSERxZ1JaMjluYWFVRXpNU21xNi9QUzhSQzR1ZHlO?=
 =?utf-8?B?S2hQbEdsem9POXVSN2QrY2Irc0pTZ0RDa1hJSlV1eU9BYm52VjZhcTd2amww?=
 =?utf-8?B?aElKTFB5M1I3WVZiQ1p6eUNoZzBZaTdLdVFtM2Y2YTRCeUxzZUVFSUQ0WDUz?=
 =?utf-8?B?djFpSGlMVGxqSmNFbkNiN2FxclNqTE1lamNCMktycHBQY2tEVWVXSlFXanhk?=
 =?utf-8?B?MGFUM3hDUmpBRFduTlhnblZyOEl1cVd4c0UrZzZDZzVPWkliYk1iMURDMFBP?=
 =?utf-8?B?Mk1GaTJBdlZ2S2RZdTQrWEkyL25vNFBYd2FZUDliRk12TVp5M01kemZtWE90?=
 =?utf-8?B?ZE0xTDdzeWpwcTRDRHZOMHlMRWppTkdTeFNFQ0VhaG4zVS9ic09DR0pkNkxs?=
 =?utf-8?B?RUlNdFRqZTgwK2tybHJrczEzQkl3S20veGxtVnFFSGxkYzY0OHZwV0dzMUxG?=
 =?utf-8?B?R3U3OEZzbEZWVHhIMG9CT1h6eDR5OHF3MDAvRVRUOVNNcHZRbUNNZG5rQ0Qy?=
 =?utf-8?B?eEhWUGJ1b1RqRERTZVMxNDlyRmwzRFZCNDAyNjg1azhhalBHVzc2KzNSY3ZN?=
 =?utf-8?B?NTE0U0R0WnhMNjhndy9xVUFwVlVIMUdQU1VoNjk3TUJOKytpNis5TjZES1JL?=
 =?utf-8?B?MUxWcnNEaiswVWRNdjRLTWdDeTk4NndsQmdWVDVwYkVSZWNtbVVZc3pKZ2JQ?=
 =?utf-8?B?aHdxSWhKTFpLQXh0SkN6S3J1akFtSytvR1UrOUp6bGdMY0plSjk3WHBzNUhj?=
 =?utf-8?B?emdZMnBHWWl6MjJFSnVWSi9zTllWNURZN1pMbDBoOXJjRkMveHZEMWVPdDcx?=
 =?utf-8?B?MEt4RFlTblpzbytmRVVpcXJLaWZabTJyUVo2MFNZaG10RG5vSTljVHZ6dFNk?=
 =?utf-8?B?VHc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f41250-2fdb-4886-fbd2-08da8fd72b1d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 07:12:33.2034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdr23n6G6hcMTBPdV6gD3BecIl1WTmtnf6uVphHwzLuGo38ImxGwit3QyIp7cZ2DygAXwSqITgp+GQKYyEONxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6124
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/5/22 23:37, Christoph Hellwig wrote:
> No need to export this, it really is an internal helper for
> the iov_iter code.

Agreed. I'd fallen into a bit of a habit, for gup APIs. But this
one has a much more limited and special role, yes.


thanks,

-- 
John Hubbard
NVIDIA

