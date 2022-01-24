Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCB449925A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jan 2022 21:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381185AbiAXUTK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 15:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355350AbiAXUNa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:13:30 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2061d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::61d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DFDC01D7CB;
        Mon, 24 Jan 2022 11:34:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuTxYctZxXEBIOSp/JEKOH9A6EmI5RUHUj2Au4aevGirJYJHGZ6fXkhEMN6l1rkSYbjk1xiSfobO/wsn7d31Bk6vo1InKiFXZoO6l8iHkTkWDCr6Xwl9wkRI5ukfdaEJMzWHC41RHt57ugjPWgTCjxVM89NWcFl5d9zlDI+sztMyyBRC8KmTiJtYOFYo5Tv5zAl5hQOY2BnBLDxTiE8ceGTI9hXDPyqWDnqWM7SgEq4bOttSB3Z6g4vmFXl/pfpxi8NUV38UBJnmZaJqMtIyoqwGg6PHAZyrX6vWuSV+nFtN7Czvm2veAgwvI9Zvh5P5LlNf3VwflJZL02r7pUdmOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9/oFTQuHj33CHK/+z9pEQrtWs3bZJcsGN5zZb5fNd0=;
 b=VeYFKHyRE9Wv4UZPAruYzFDFO3wGH9XLNFcJfj2pEgprB5ydrn51ghBLt6xxhGPw1WSOCEB5GOgQVjzq5BPyNrC/U7mWg1H+Nk3Dwoc44fBC3bf1z8Y9nWAkrBLaQfhLHGdlVLreRyJ7x9bq32Cq8HRmgnccTL7pyIot0bs+rqQeZvsOLeBxADnR0RHYYLACbmHyzIfpEAHC7UgBC3WiBgyO29WUJN+zoa6KqtUN3AG6bkzMex6Sqrs03gwBaU1gyHolMgvW4nOB7aNwrSTqhjsgaOxbDQIWBnYVRE3dVDqGMCjM7/uTqDo3d7JFosqmeExKB2+P6DhxscJLvoSy4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9/oFTQuHj33CHK/+z9pEQrtWs3bZJcsGN5zZb5fNd0=;
 b=czvwvIrJ5uc5LlUV4RX9D7++jWekcnrG/AopK7iLHVAToRUdMpCeiSPwOtg4cTqIrMsUjxyPfI3wyCaKAG1lQS+V9i1PzjHfGbxC+m6x4RRTh7Hn8C2IYEFcobbP4sPh5Ce0psc6Qq3iMvtM8B7nTkcCMgZBamADyQhJQXVgRq1kBhlQwnA/cDNH2WjA4jXyXvOPF0q69PQvbHYVQfWGjoBxyfRGSInmcWk/kK6LOmXUkogiowphSh/U72odsdqwNWjizKNZhJk6+mqMT3A7UqT+/AFjczvMoz0Xzl3+iQHGz4CJQbVY15jquk2M2B+EDZRJv3vvcbhqdf7Sk6FBoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MN2PR12MB3869.namprd12.prod.outlook.com (2603:10b6:208:16f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Mon, 24 Jan
 2022 19:34:30 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99%7]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 19:34:29 +0000
Message-ID: <bdc63efb-5f5f-73ee-5785-ea28c576c52a@nvidia.com>
Date:   Mon, 24 Jan 2022 11:34:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: RFA (Request for Advice): block/bio: get_user_pages() -->
 pin_user_pages()
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <e83cd4fe-8606-f4de-41ad-33a40f251648@nvidia.com>
 <20220124100501.gwkaoohkm2b6h7xl@quack3.lan>
 <cde9acbb-ba1f-16ba-40a8-a5b4fdf2d2dc@nvidia.com>
 <20220124121903.fono7exjgqi22ify@quack3.lan>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220124121903.fono7exjgqi22ify@quack3.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::22) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f85230ae-c7e7-419b-1dca-08d9df708a24
X-MS-TrafficTypeDiagnostic: MN2PR12MB3869:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3869CCCBDF31094811321D3BA85E9@MN2PR12MB3869.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 12v3QU1bIxFWml7wFT0OXKtc0OBqCqYZ6h6e16wmwQ3n57EDdmSaLa0p9YIfAgmihDMh1WjJO/4m2evQr5fZwDdQq5M8x+rING87qHAdIPNpALQ0Y5YNTuEMxYSlWk7w/rF6Xd9PTUmFJzTMPhe0C7vrMjXePVdYT1K2Qnt/Zvf56M0tq9tFyw9so4LE1UYdMJ928VvPvu/LtDfs7epsktVz6pNQ0Ze1n3gWJKLS8CK60ydXn3rvXqqNnlpMPfqT9IIGFRA6bwUQ8ZOU0XJRC9hcjCvgq1iqs5dUtU1QmTHAeWcI+POw9Taw4ij//QAyLzMWGSWNfTVg0tagwz9yHoo8gQlBc6Z01jr5hpsRh9sVYUo2erKgShJcSm2INZp9SrSPgpVSDy6BhQr5EW9oFQacnvIsLHDeJK+p1HDuav5RJD3v4h+QKH9M4UDrj7v68zAKiAwdFTQXCfIkaqApAsbZzjFflr3pqlpkijApjE6wwSoDPibMifKtQjFTDX8l2LqvowzKobUB9PKjfbsh4ZK8PYLKN58iF4QUzneukYKEhwbkSb/VukFRxSCvX5exoghm3O54gMnfKImlm6j7YdGK3dmuZISyqRiJEAgqop6i2Eo/dZIj5iLHtrAp4COm6Brwnlmv8ulISpPmdr6A0NCyuZgY/sfIp9K6OSEcc1vdtlLHXqfyF0371B4nL6dRueuBvuHrykjx85P0GFPMMU/zVzhb9Swyyyg5FzzW7EBgQBqONwX9a3YvuqlY2d7w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(2906002)(6636002)(6666004)(66556008)(53546011)(66476007)(5660300002)(6486002)(110136005)(4326008)(316002)(2616005)(6506007)(6512007)(26005)(8676002)(8936002)(86362001)(83380400001)(508600001)(36756003)(186003)(38100700002)(31686004)(31696002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVl4c1N3QVpKeXU0N0VJRjJsVStBRTFsanV5R0cwZm5pL3JObmVDU1NtTE9z?=
 =?utf-8?B?V21YNHNSTXZYbEk5a1dQWDR2SGg3NGxtWUU3akQ3QTM3aW9tRG1ObmZqV2pq?=
 =?utf-8?B?a1JIbGY3OU9WcEpkZUVWWms3SVVoTXloQ2lRYnVsaEZqMEFFUWgwMmRiQXZI?=
 =?utf-8?B?eHpRWmhWUkRKd3lTQytsOTFuWDBjdzhXR3BXYURvNjFiUm5VSmRMR3FCK0ho?=
 =?utf-8?B?MHJLbEZGMXdyL2RSV0lwYzkwcDliWUJTUk91cHUwNVFYOEozWmdZYzlJWUll?=
 =?utf-8?B?ZWxvc0JRSHZNZmdoR1QvQjMwVVY3TkdIeTdBZzB2QTM2L1ZOcHUvelUzZmFE?=
 =?utf-8?B?STFKMkRlWXJEcklSVmNWVDRwV0VpYTR5OXVVaGVobzJ4dk05NW9jUnBIVzhE?=
 =?utf-8?B?TlNONUsySHN0N3FXTUdNaUtFN3cxa1A3bi9rbnpBU21mTmJxdDdhYWdvbDZ2?=
 =?utf-8?B?Z2xZTzR6cEkyc3I2SnNsOTBHcDJ4bjBZS1VTbXIrN243dWp5cGVnRitEQkxF?=
 =?utf-8?B?Q1oxUzA5ZG9nekNsZGg1ckZUbytUMWZ1Z0JrWHBxNDI5RDMyQUxmRlhrZlda?=
 =?utf-8?B?cnhOMGF6Y1RhRWZVcGV5K3BpVjRLdEVqOUY2YnJqaUVYOU5sMUY4bVh5QTd3?=
 =?utf-8?B?cmFDaHVsZGs5OVdDOXE0alhNS0JXN3hhTWdoTG5BS0JzODRPek9oc1VMNHlE?=
 =?utf-8?B?WncvcWNFL24weDJCdzM3ZlcxcnlKRTdOK21xSmdxMVdxSVZaVzNFQUdjOTVn?=
 =?utf-8?B?TWM1TThnVlYwdzcwNFJzY1AzNXhWeTlteWxYR2RJK1NiWEIwcHFaOHFoNWNt?=
 =?utf-8?B?azJxR0t1NFJJbmhudGhMNDZnS0xkNDA2eWVjajFmWDVYQS8rS3dQOVJFT2dx?=
 =?utf-8?B?M2ZDSkZVTmJPTTE4S2MyQlNQeWVCZzg0VTU0TlI5dnk2TmxXQWY3UTU1QWdS?=
 =?utf-8?B?a0pCQk9sdlFEOEdJQ25jRVRiekhCVzNqWSsyVXgvK1ZqRmo0aG11RWVvaFpu?=
 =?utf-8?B?bWs1Y1A1allkSXczWnFJZWZ1OUxIODNCbUQwUm93QmVZR2pBMkN3SzVWNzBv?=
 =?utf-8?B?TkhXSFphb1A2d0JOS3lTWnAyMm16dlJ3Y2FsZGJLcERRTmJKeVVNM05iTmdU?=
 =?utf-8?B?MGtybzFqcFZnOTdETWFzQU5yL3JkSmNsMjNobVE5L3dNSWFlQW50dDNPcmsy?=
 =?utf-8?B?WjlGYk1SOER6MUVJNUJpT0tYbThUQy9Jc1hhUG9zU2lCd05Ic05JL0JRZ3Ir?=
 =?utf-8?B?VzNZa3FOMStIeWNxbDVGaEtEWXlITExwcmVBWThpdzJ0Mzd3cW1CamVscGFY?=
 =?utf-8?B?eVRMdTd6eXJUSDRWVWkzQ3M2MzhOeWFlU1o1b3B5WUJNaTJEdmt2cEhkNHdh?=
 =?utf-8?B?REdnejZ1SStJQ09SbGtTVHNJM1RlSDBIYTk2cTJMZjBNczROZEF0SnIxSGVV?=
 =?utf-8?B?Umo0RDZLT3NEL21sNXg4NEtwK0E0Tk1iRHZzcDQ0citMVDVRZGVnUVNzbm9n?=
 =?utf-8?B?TWV2Unh4cUZrTWo0UFMyTFZJSEliNFdIREI0akhrSzBWeGY3Zys1aTM1ZE5v?=
 =?utf-8?B?a1ZNa0dXYXAxeGdYYThHd2dYR1J5Z1NkSnZrWlkrZ1pBb1JVQlhWajRKZGNH?=
 =?utf-8?B?OG9jSTgrTTA3VlpSMlNBc2Erak9ndFBnVXJUOGRUamZCN2NPekplMFNLL0tC?=
 =?utf-8?B?VXk5Z3BMb2lXY0srSlU3emIxdXNXMHU5blorMEpHK0ZOWDA1RFNxejJYcUdj?=
 =?utf-8?B?eVRuOXA0M3hvZmFiZjFleXdYeXFMNC9DSDh5ZmE1N1hEbUZQSWk1eHlkc3Nx?=
 =?utf-8?B?d3l0czRnN0t5OUZubDVocU1oeTFlWjU5MGE1NHF6b2ViZDJMaXRSYlRrRU80?=
 =?utf-8?B?dW1tUDUzWGZ6ZUtDUE5lYkVhcTlOQ3VhNnJkT1JFTzlQQlg5Q0JuT2M1aWJJ?=
 =?utf-8?B?VnVubTFTTkwvamxHYmZOYXZEVWZEMU4zcTlHTXE2MStaMnorSGY4WUhSUVI0?=
 =?utf-8?B?SUJEdmZRcThIM2lONTc0dEZzVHFtNlBhUXFKbmZkTGNCY3d2MnZVaEVMYS9W?=
 =?utf-8?B?V3ZrajdLdFpKN01ac2pBUnAvTEsxY3hpb0pNZHAxN3ZwWG1NQW5XU0JPMWFz?=
 =?utf-8?B?ZU5uMHVxM2lOcXRYbnl4NndKRmwzVXpzSzkveDJBL0dHRzFESUlpUkoyQ0Mv?=
 =?utf-8?Q?FjCVvM4viz4SPQhqJtj/L60=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85230ae-c7e7-419b-1dca-08d9df708a24
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 19:34:29.8464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j66K0m4xVQVHwTatQpfdDRQuZPquxdSevchYvumpNZ3dZhEXrYCD9bCYlPa38d+IlEC/UxgknoILbe5R4GWmvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3869
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/24/22 04:19, Jan Kara wrote:
...
>> this maybe wrong but thinking out loudly, have you consider adding a
>> ZERO_PAGE() address check since it should have a unique same

This crossed my mind, but I thought I might be missing something better
on the submission side, such as some way to do all of this without a
zero page.

>> address for each ZERO_PAGE() (unless I'm totally wrong here) and
>> using this check you can distinguish between ZERO_PAGE() and
>> non ZERO_PAGE() on the bio list in bio_release_pages().
> 
> Well, that is another option but it seems a bit ugly and also on some
> architectures (e.g. s390 AFAICS) there can be multiple zero pages (due to
> coloring) so the test for zero page is not completely trivial (probably we
> would have to grow some is_zero_page() checking function implemented
> separately for each arch).

Good point. And adding an is_zero_page() function would also make some
of these invocations correct across all architectures:

     is_zero_pfn(page_to_pfn(page))

...so it would also be a fix or at least an upgrade.

I had also wondered why there is no is_zero_page() wrapper function for
the above invocation. Maybe because there are only four call sites and
no one saw it as worthwhile yet.

Anyway, this looks viable, thanks for the quick responses!


thanks,
-- 
John Hubbard
NVIDIA
