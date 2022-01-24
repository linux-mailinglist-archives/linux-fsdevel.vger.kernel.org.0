Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34D849AA8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 05:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385196AbiAYDmZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 22:42:25 -0500
Received: from mail-bn7nam10on2058.outbound.protection.outlook.com ([40.107.92.58]:28900
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244870AbiAXTsj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 14:48:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLdA+ul4e675YQXRwdSU1lhmolzCuYftllzFKte4dG7oJM7Mp7nKBnfjZVZcBnHZQ4FUXLFuUOYMO/I3J3PYqWYnp84skw5fbXbMmQs9twnDAtIJRpVQnRKNLxcNaf1dHHnF7u35skqABUQZfv48zOky5gXiQCbyVlecgSivf6XVf8NIm166EechzRKpmuskUuZ7wEqHQ0KLskBPrFUCvUSpBNgCDzwjdf9tBEcKMnIcGsDXTAFplS6R45fJWndxZtRuZhRKg27VZEr0mZPr+8mLl0yxOkzdcRQnOBID6m3noENfn00qOdsi58hDU3N6sPLGlDPr7GdP9DcIHJTcMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/ilLSoCtyG9THihoCTYy54yReVFfA21dmi9ePBjous=;
 b=ik7GPuNCbZtT/VmlHXsgGrylDJZeu+XJv4RDJKne0CCuos/a7re1Lo1L3PLfoW5SPZH/uUD2YW5jlnjE+wm/Gaj4okOr3m4jKCRCTcpZgYxfjcZtwkaSn9vcgIe+ob/R11nRMAO2s+fOVCLgdhOvIcJOOiwDAWitZdSNCwbMahzOnE8Gj3oIjtxRuuNCL+RwPLi4NxZ5KTK8RkR2POXyZqQNTrVp6MhyERaropC+SClKHNIfIVH/RY9S0shuGDSPkhTjfLbh2uGWSCX5wUbhjAyrMJ8myN4C8jQyGzgCRxHYacYNOp/0YmSbJkGGLiHOXdmJmGMsTjvNR4Tv6UW21A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/ilLSoCtyG9THihoCTYy54yReVFfA21dmi9ePBjous=;
 b=iMCZYsuzeLOSpiihTDLLoZI6Y+bBv8VuH0qbA1ToSvpkGbj2MnKghpwD/yfrCK8UG0hJHdyehGK5lE75YLq2Y3ZA0l8F0bZtsMJZ4Zq7ckOD7D9cMe5/g8U/wsFvy/DIIsxqpsNXQavyCqDSTzf1SxgBgOJkW3EYcqsncVOzy5GJH+KFZuKRdsrki+JugWcHMDgz/D/bTLKrVxLo946Pjjcc5au6UDEwbVFCgjcrcCkQXcTzbT/xNEEFQKLcK9+wHpfNQnCbon8j4chft/61aDq+XXaHutH0veFQaWCHVsa9wAu2glnKH8EKVNGFNzbE96nQxCygQ5M7Xr8WKjnMIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM6PR12MB3963.namprd12.prod.outlook.com (2603:10b6:5:1cd::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Mon, 24 Jan
 2022 19:48:34 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99%7]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 19:48:34 +0000
Message-ID: <c01fde9d-53a8-fe34-3abe-bad1b680b1df@nvidia.com>
Date:   Mon, 24 Jan 2022 11:48:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: RFA (Request for Advice): block/bio: get_user_pages() -->
 pin_user_pages()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org
References: <e83cd4fe-8606-f4de-41ad-33a40f251648@nvidia.com>
 <Ye6nG6xvVG2xTQkZ@casper.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Ye6nG6xvVG2xTQkZ@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0157.namprd05.prod.outlook.com
 (2603:10b6:a03:339::12) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88d94116-d574-4225-9747-08d9df728173
X-MS-TrafficTypeDiagnostic: DM6PR12MB3963:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB396362FB23544E155EF780C3A85E9@DM6PR12MB3963.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +DodKhorCretGJhqOflmaJ8CEGPU8c8S45ieAPYkxf1uCvtJf2iwflA4UyCryamSoEfmGDSJI1ZVsfSEtxH8Mf5oog+b6Di91DDFUXeQLn+8I1zL0CBCYTCbS2kyMYxdLnvnds/vUj8yRnTMeHKQQkoDvovt9b4+ay+xcK/mspCfeOeU7TiaJcNeUTyQhm8p03fYun7EmjHglVtX2R+a6D0EC7vh5ass6KgMrG0Brti9CRWMDGSICs/3sUbk2zL1p5pvssWhQwihFZGtRRjF1/X+57b/9rBH4UMNryIhLhshtJdd8VWziDi6n2zuQ98GLxmaCxzWtqiZvbZuxctPoFqXtjATWmZgV1qlAP2veSNrt5YTS6HPfAZN+cxOzMHDhixDXSLTM7sLnByyUsq3txSYSu1fBxgEXDvZ9D+8vdFuL0GHrz29jLRUX1/n6ZlnO28r7R7Ec+aw4Y2poDBs3P0JWtAOBlHv28wjnCWC4361RB64bJXsUcyKMEDq3j6X7MBIe2On2eN9cEaB/jcSAm9jJOn6j/599eaPgJY7tM3HB/mZ2I8xqPAUC/K9wKPLoou8f4/Ym7H/SWoU9JdOEBPLO0CRr+iOwZVIR0bYSxAyDRkMtZyyozcmeAKC6Nhr85zKBKHpfhpoZtX2oB4CeP6nmmSxdNN02zXRZQfgXxWugk5F8UTsJ+rDf1DAGLTCj+Rn57Z0v9W6mZW+eBmKPwKLou2NgN85ujO+slbfNtoPZNAuHQsLLEZXJJLst7Rl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(508600001)(316002)(4744005)(83380400001)(5660300002)(6916009)(26005)(6512007)(6486002)(36756003)(6666004)(31696002)(31686004)(66946007)(2906002)(186003)(66556008)(66476007)(86362001)(53546011)(6506007)(2616005)(8936002)(38100700002)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekxQdEE3ckdHdFpXWFYybER5N3ZWaWNxaXo1TTRzZG5IYTY5dlJHandLRE0x?=
 =?utf-8?B?UlZPRDNvSGkvS1lrelo4eXFid1c5bUlmMFhERHFkaDErbHlkQzhqWmhVZktj?=
 =?utf-8?B?SzMwMUw5T05DV242cmhibVRlQzI4SjliNUpqQTk4cHdQQTFpTTdTNU1LSlhU?=
 =?utf-8?B?QmF3WUpqdHlYS3Fra3pvWUluYXA5alVYM1M0ZEF3a2x3ZWtLSUpaaGc3WUJL?=
 =?utf-8?B?bkVENk1WOEFuK2N4aW5vTzJPYlFCZDd3c243dzUraWw4dmxRVmNPMEQ0TXRw?=
 =?utf-8?B?T09ENjByTUF4UXhLVitwcmtjS2lRcFpvSll1d2tBbnY3UWl3OWU1aUdpUEtY?=
 =?utf-8?B?VEdGNlo2d2lPZHZZWmZpZkw5Tlc0YkFOeVZwQi9UVHkrZkcycW9UbUZNbkUy?=
 =?utf-8?B?RHF3S3U5cjVaM3UxZXpHUnV6cHBrV2U1WVlKeXA3dFNtS2VGNjBkUTlHR2N0?=
 =?utf-8?B?WmxaMjNIKzNXV1R3SHFSbE9McVNaU2huZVJnU2FlNjV0bjNHSDNoeEhPd1VV?=
 =?utf-8?B?b0c5UFJFeXdic0g1L1Q0TndYMHNmdHpBRmJOUHBqQTlrTjdaYVdMVERHakUz?=
 =?utf-8?B?YlJvUzI5QTJTZ1l4RW9OdVludkFJQjc2eWQ0WWsyNWZxSFRpbXNtU1pmYVNS?=
 =?utf-8?B?R0lrMnJwaXRFbTJ1Nks3YjhKYlExdmdrMXA1T0srTTVpcE9HZnl4N2ljMFV6?=
 =?utf-8?B?SzJZalRCaCt3dHVGQ3p4N0pQL293ZXFtOFkyL2J4L0tmb0ttSGh4TlBqNUFk?=
 =?utf-8?B?cXU3WWpLQk9peEw4Ym5XcS9xbkZwU0QvQktqcU0wcXBQWjZQbEsxcDcyN0hh?=
 =?utf-8?B?YkJLNWlFdFFqdDZsUHFLWm54VE85OUw1eEJISWpzOGpzTitkWXFncm8zazVS?=
 =?utf-8?B?dWtobjFqSVV2dzlHbXMzeTJ3RlRtM1RsNXlhUWZRN1ZPd0lHVXVpd0o0SUt1?=
 =?utf-8?B?L09SR1NBWnA3WDF3M2xlVlhxSnRtWGs4N3JPblc2T2pwY0VkZndpVGFlSXQ4?=
 =?utf-8?B?MTJ3bUpuaW9GWlNXSk54NnpReDc5SnhQUmxBL0RXOGtYcXprZDUxaC9Lc0Jm?=
 =?utf-8?B?aEp2L016bFczcGZiczJWam5CWk9jeE9Eb3NqeDYza2Zicmg3blhuQmFxRkZV?=
 =?utf-8?B?djJqT1c2RjdPNjZwSk8wSGVEVzI4UVR5MjR5Zi9lNlltZDlLYW1qMHExbTB5?=
 =?utf-8?B?UFdwUUpvVkNnWGJya1VkbDNEQWIyd2dFOWhVeFkyL0tySjFWSTU5czl4ak10?=
 =?utf-8?B?Qmt1OWVnUk9Qc1Q3eDBXVVI3dGZZRjBUOFp4eEtTdFlRZVpMNW1iRnppaHU0?=
 =?utf-8?B?L3pWRklaVHpsc0xWMnRLdWU0VndnK1VuTE9pWFlUV01OdzJVTUF3TGRDMUxv?=
 =?utf-8?B?WTRUb1M1TkJnTytUV0wxcU1LMGYzcmxnaVBFRVVUQitTSTFXdG9XOXlHbjNR?=
 =?utf-8?B?WDI3dzhscm1ySmhvNHRtRmtLdVlDc3JTdURiN2JNZWYwOTZhcHBnL2R5NU1v?=
 =?utf-8?B?SW1nZ1BoSUJnK1FQdFpYNU54NnlRTGUzRjR3NjBYdjZUd2k1YjNHa1J3bVlo?=
 =?utf-8?B?aGh1VzhSVkQrckRpaXNpbW95NmpzR3hpZjltaGtqbWhZSmtrNktLZ08wRHkx?=
 =?utf-8?B?ZWNQRWNweWhHN2VER2RoZnV0K0xEL0JxRnlMSGlsRDBrbVQ0QVJJM3ZGRnRH?=
 =?utf-8?B?Sm5xbU1kZ2ZBdERsQzU2VWRrSzUycnFNOXZuRnhEY21pcnVxYytDSmF1U3dk?=
 =?utf-8?B?ZTJ2ckpGaW13bU5PMmZXdHk2cDI5RjAvYTU4bFRoQkFxRUxvV1dqVUhRR0J0?=
 =?utf-8?B?U1BYRWh5OUhZU25Dby82dXNjR1lZOXFBcEUwdDNrMm9JeEkvMkQrQnVzOWFZ?=
 =?utf-8?B?SUZvNFRsV29vZVFQZkZDdk4vUWZmU1VhL0pzVXRmTXNWekJaQjlZNklFd3M3?=
 =?utf-8?B?UENFSXBaS1EvdzRCT2VpQVJqS2VzMnVydmNVL3dJcTk1T0kwVGxUamRIbU83?=
 =?utf-8?B?UXVZTGNxRU0wdjNwblU1cW9jd0FITy9zM0Q3dnNkL1dLU1dFVStIa001T3ZV?=
 =?utf-8?B?Rnpjbng2dTcxdlFTRWhTYU9UQkkxaDlKZ0RhVlNpckwyeWllVmJ0eUJaWGxt?=
 =?utf-8?B?QkFhdnZBRklCNWJKZ1JpZGM5WFR4UkZWcDY3QWN4aDU4N3pjcUFodEtTRGdS?=
 =?utf-8?Q?kB9q60hNDg1mdzy3x/u1NLw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d94116-d574-4225-9747-08d9df728173
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 19:48:34.1675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vE0B78H6tECt5p5qa3O+GXH/nvLQe2jV9+rfGjBg1S4Cyr/0ns0XqWBk0i+XA1bljm46O8nfV/nJ23Zrx6NutA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3963
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/24/22 05:18, Matthew Wilcox wrote:
> On Sun, Jan 23, 2022 at 11:52:07PM -0800, John Hubbard wrote:
>> To ground this in reality, one of the partial call stacks is:
>>
>> do_direct_IO()
>>      dio_zero_block()
>>          page = ZERO_PAGE(0); <-- This is a problem
>>
>> I'm not sure what to use, instead of that zero page! The zero page
>> doesn't need to be allocated nor tracked, and so any replacement
>> approaches would need either other storage, or some horrid scheme that I
>> won't go so far as to write on the screen. :)
> 
> I'm not really sure what the problem is.
> 
> include/linux/mm.h:             is_zero_pfn(page_to_pfn(page));
> 
> and release_pages() already contains:
>                  if (is_huge_zero_page(page))
>                          continue;
> 
> Why can't the BIO release function contain an is_zero_pfn() check?

"OK." (With potential modifications as noted in the other thread with
Jan Kara and Chaitanya, we'll see.)

Thanks for responding with that answer so quickly, much appreciated!


thanks,
-- 
John Hubbard
NVIDIA
