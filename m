Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D88596491
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 23:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbiHPVXb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 17:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237323AbiHPVXa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 17:23:30 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B9F4DB77
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 14:23:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+RWvoQoXAs7Vezj1g03g+NFGAeijeEL1zrMR6z1ZXml5qL1TuUQKzUAfAP7s5KFZz+G/P2h4655Ypbf551T3Mmdrq1aEmRk/IwRp7b703UfRUyUG1QCwfvbyG+gDDCR1SBIA0opFlCKUBcfLfxk6ftoL81OP4s9HdO0z44vyZkNBnxGzyU6uXx4uVYMXWfatJ2tXDryc/TGY10w3TkzBZnRLwsjAoXkQghQfzhWDOe2IJXcT7EJbZQV6EtdHjf4Z78Gocs6PxJ/V/y07tzWrO7FqJBniCQM9zHExA1bUmP2jcvLpBXxem7BHmzlC/7V9dlHdyF7BoxXEuYHnoRq2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAusdqqvQ2458L49m8JiZxRrajlNR2n3cThVbH6xdK8=;
 b=anoF8TWJP9MQLFd2ZlrLmKAKfa6Vw/4HzqBhGgvGs6oeo96USmirhE5JR22F+cz4oSrBHMLmIte/5p2uDYaLO+cMxW2F0JoHAYPWnh9stjzKU53RSxbVY5ZZIkf86EdSPnu0p6XxertsYaqkhTYA0GoqvW0y634N4J16Jmq1yFuYtPKTnDX9YgQOVwXzgxTJBPjCeHd1BZ9kjkkdsddYZMNqcGiIXLxiYi3iKxeGw8lHoKS7uyQZmXwIHlb4Q35VgKL00qniH09cLWLHGXofxq6GDXKsvB1tsHXT8QbA5aO5prakX1EM83ggkQJHzn86HVDDoQliZWKKXOUGfF2m7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAusdqqvQ2458L49m8JiZxRrajlNR2n3cThVbH6xdK8=;
 b=ln1VHs7aDgrDTld+r8qQSUl1Y63gvdsGPMGg4pYGbsf4NL+D9E3m7zoEytQTxX2iplJNEJ9RoeUN/XfeNFhSS4UKoYBDwe9hA3LrF0apa2eXe4itu5vKWAauZLdwlOGN57xEHKEJYW9SBqlxGdEa8TQeGS2yD+zjM0Blu6AkaJyjeO6I8AJ8DvGyQH0cdUXP/t+1RQhdMVKA27/YoiPC06XW375tOQjVhB1vtIpKYanb14IyJAsKEPC799UGVLug69+1a2YFt5ZNNas+4jybiU7zqn4dk7thd16ZLoPNCfji4uOO7KN8OodObsHoFefAHCGeaYU6mtN/LoTs4mhHrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM6PR12MB3692.namprd12.prod.outlook.com (2603:10b6:5:14a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 16 Aug
 2022 21:23:23 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 21:23:23 +0000
Message-ID: <cba64760-9cc0-d194-f42d-869ea777250d@nvidia.com>
Date:   Tue, 16 Aug 2022 14:23:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: folio_map
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Mark Hairgrove <mhairgrove@nvidia.com>
References: <YvvdFrtiW33UOkGr@casper.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YvvdFrtiW33UOkGr@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0202.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::27) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 165157be-8999-46b2-2a4b-08da7fcd8c79
X-MS-TrafficTypeDiagnostic: DM6PR12MB3692:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YcTG+TxUee+Bi0xWJT9WX06hq3ea3Zu8l53xD9miiqJ1sjxV78GqutEFDIjlgkJO2nqiioK1PlUhcKx8vvUUiZon2VG6n5ff9CVM6W02USo83QPta8596ADlDFL6tpL1DhCvQl6ImjtQcW4RMC4EJv6VD3B6Uxxl+1Q6mkvE4XbflkADt9FdMVCWI0oM7nGqvbGBXc3AuNAtIDY0uTRg3ZZn7XV4ugYVcacI5igxue1JV4bK0aXK191Qas+2L/zmqOZTI7Y1ZnyX2FZX75eySQ9LqP8EW9W0bIc8HL4IlRyUvKNibw6iC/IB0A51+toDlOH5JquFkHip2bq2UCPQA5Dgo6d9sTTCmEVS0T+SvPManp5ik6MeWD1mUzJi9b60mJY4ivKVB8GNRoreUuJV9rKq1Y/FPlTvyClfz2lU9XheTqyie66P2a+z3tm3uWXk8m2TndReWVj72lRGR8BPG+kNh72ye7oRW7vB8hiBGGXoOe1KJvREF+GJ0kEyMAnOU3l6IsWz4QoIeG/ysC96cUwSHFqTu+fRuPuZTdnVq95gHkKdBi7lp5DqHX6IOH83hm/OrCPdIMgpkQhhxdbdAFK39AsJZy2nR0VfTx7g6ceGVfO5D3FCCIoZyHLs/zmknN09bSlbqRiUIhTxc8HXhSzzMckQPm84n67sabnE3CxAPgEFMA13mEXsEEFsEKTApXeVUWlI7utbOK6cR1YdXvvKUxXW9El5kz49d91NEUEICTe0wh+Tcn7KtvY2fAKmzbBQQ1fmlLcHTHbSmYh6t0SXRyRvf6hu0tF/Bkbl/ec3xOjgELLAb2evkzit/zATzlAMwxA6kZiyaHFmrF0ISw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(2906002)(8676002)(66476007)(7116003)(110136005)(66946007)(316002)(66556008)(6636002)(8936002)(38100700002)(5660300002)(478600001)(31696002)(86362001)(41300700001)(53546011)(6506007)(36756003)(26005)(83380400001)(6486002)(6512007)(2616005)(186003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTlNUHltSzJvUGZwWVFjRGJaZmZQRWZSL1c3MU1LZ3FYWE90SW9QQ1VCNnJ5?=
 =?utf-8?B?UzF6MGNsNzVtcHBRd3hGR1NJMk9jMGlwNUc0ei8wUy9zYVgrV1hhK0NSWmwr?=
 =?utf-8?B?dnJMcCtWVVZpM2tGVjZyZitYZXZPa1lhOU5DdHZDbzZpelJFdzhHdzlabUd6?=
 =?utf-8?B?d3d1YW43Y0RBS0Y0ZjhTSzVqWlVvcmVZUHlET25tMVh6a0sxWnZPczNKb044?=
 =?utf-8?B?eGlwWEg3SlQwcVlwOFpESXAzcEs1dmVCa2RKVVNja01ZU0F4aGNuVGs0bzhs?=
 =?utf-8?B?UTA2VWNjejhwUlJabjE2ZWNjUjhJWU8wbGV1cU5GaiszdE4yZGJrWXJpWnVF?=
 =?utf-8?B?OFhZZ3RUVjhvQUFKazZLbDZ4d3NXWml1ZVBIS1hURTR2SFIxZ0paRjlOQXNG?=
 =?utf-8?B?SFhPTFBxMUFITEdWeWxUaDlLblVITDNENXVmR0xHemsrU2FNWTc2cU9UaDNL?=
 =?utf-8?B?c3ZrNnhwd2ZWWlA5U3AwY3h1elhvOU9jdlhLWHZya29RNjNGbGxxUHd5dWox?=
 =?utf-8?B?Um5xeHUvQzMrVHJsKy9jUytiamN6eWZDbktUZSsyWnlSclp2UklDWmRDN1Nq?=
 =?utf-8?B?Z0tpb2ovYmdXWlJNbnl1bS9INm02NFpGdTJ4SXJ3R0lTQ1dHUG8yRVRBQVZM?=
 =?utf-8?B?ekZhdzJhRmcvNGIrMkxFeVZBczZkT3lhNlFGZXhsUDBabTJ2U0laMC9XYnMz?=
 =?utf-8?B?ckdKY2hhZ3pFWWJNMGkwaVh2UXdKaE5vd2x5S1NVcDBacVVuYTh4bDNmc21D?=
 =?utf-8?B?WUVmM2E5djkwQ25sazl5blZ5UWdFdzVoQ0lqT21BODBrVEZ3MFBzVndzL2l2?=
 =?utf-8?B?SUZ0MWI5NGhQWXRFTnU2Zy9DUXhuV3ZIY3dTMkdqSWRDSmJLMGplMm5zQ0hD?=
 =?utf-8?B?MkpxeG9aMjVhdzl1dy9PT0hCTEgrMm9tckZvK2NGRGZqb0N2emZKNldtNitW?=
 =?utf-8?B?L05pMGJEVGlTV3NoTjVLbG5xMWxWbVZRaUdqN1JDREdKZ0lGZE9ZckR3RlJy?=
 =?utf-8?B?SDVYZW1IOC8ybmg1OHNRMVRodHZzMUMwNWlFYklsdDU2M3ZpU0p1TWtLaG8v?=
 =?utf-8?B?M085WjlaaGMwNWpGZnVUZFp4YTczYlV0azRaY1NnNmVoR2FubXkvM1Z2emRO?=
 =?utf-8?B?eHluN204Sk9WcjF4amg5Y1hVUS9qTHEvKzVCUVhMcUFsMzdWUUdPK0grZzA5?=
 =?utf-8?B?aktNaUxobW5yMEVub3JZRGFFWm41WXB1VG9Xb1NGemtnSWJ6bnd0UXdJMnRl?=
 =?utf-8?B?NjZlY0Frck9Ra0lBQWdWTTlLUkZybWtNbG9Jb1lRYkxvSm5ldGJ3M3NqWUx6?=
 =?utf-8?B?ckJYN0w2dWJZV04yRy92cTFCaXBKTEpDSWhDRjdWRVlVMGcydTNmOFBIeWJD?=
 =?utf-8?B?UC8xeGZTamIzaTF4SlZjS2VxTndzYks0M2pyZUJwc3o0TDJwcHRzTXJKalM3?=
 =?utf-8?B?UW1CSzhBSEdvVW5weVA2NXFGS0tXelVlaEZRNFhsbUcrUDVHa3hUUjBpbWhH?=
 =?utf-8?B?NGlndWZNZTA1Y0M2TzkvUmRYOXpYcWMxSVpzNytjdzFHUUZFTFdsWVduQTdJ?=
 =?utf-8?B?OW1KMTRjYmVTakVSbU9ZNlpBeDBkNmFUelZyY1pNeFE1YWJmRUZkVjJSV2gr?=
 =?utf-8?B?emVqTThHNWZtdkxLM01QZm5DMEtEblVKZk9GVWdEYVpXVXpnMG5uRHdyZFhO?=
 =?utf-8?B?djJQcDJueElnT1NLL2VRd2pPVHlOTUN1bm04cjZhNXdrMEs1MnVEK1JpcEhr?=
 =?utf-8?B?eU9RalZJSUlUdU9LdTBnWWpjdVFKa1FudXRVTTdDams5TWg0UWh1bit6aVUz?=
 =?utf-8?B?YW5BMzRGbWdhM29uTDlPcUdYMW9rc1NlQThUVXpKbTZRZmdFaXNoY09oejIz?=
 =?utf-8?B?bzZURWp4dHFmTEpvbHZEbC9kK2QzVS8yVWZYM0lUSzd2VGVFZnBtZ1JrUUdi?=
 =?utf-8?B?WC9xTitkRnFFa1JOZUc1dlptdlpxcTdCd1NCd085M0twL1dJQTJVSFNXQVRq?=
 =?utf-8?B?aUl5MnMwc2dYcUt6RlMxckl5WHVrQUpCa3paSitrWHlJQTRNZy9HSnlHbFFp?=
 =?utf-8?B?ZEl0NC9BZXQwK0lDRDB4d2UwUnNZejFabFdGTlRDOEw2bkRLcGYrd09JNW9F?=
 =?utf-8?Q?IY1O1LU2JT0XTAWZRIUOwasqF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 165157be-8999-46b2-2a4b-08da7fcd8c79
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 21:23:22.9526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PCgGYpl1wAcvuDKby8EUqNEbCfX2oroa/AABsyZvU/rco8aKS0OyyxB+BAP9UQgM1EKj1cXBDdjtK9yqjLaY7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3692
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/16/22 11:08, Matthew Wilcox wrote:
> Some of you will already know all this, but I'll go into a certain amount
> of detail for the peanut gallery.
> 
> One of the problems that people want to solve with multi-page folios
> is supporting filesystem block sizes > PAGE_SIZE.  Such filesystems
> already exist; you can happily create a 64kB block size filesystem on
> a PPC/ARM/... today, then fail to mount it on an x86 machine.
> 
> kmap_local_folio() only lets you map a single page from a folio.
> This works for the majority of cases (eg ->write_begin() works on a
> per-page basis *anyway*, so we can just map a single page from the folio).
> But this is somewhat hampering for ext2_get_page(), used for directory
> handling.  A directory record may cross a page boundary (because it
> wasn't a page boundary on the machine which created the filesystem),
> and juggling two pages being mapped at once is tricky with the stack
> model for kmap_local.
> 
> I don't particularly want to invest heavily in optimising for HIGHMEM.
> The number of machines which will use multi-page folios and HIGHMEM is
> not going to be large, one hopes, as 64-bit kernels are far more common.
> I'm happy for 32-bit to be slow, as long as it works.

Some of our kernel driver teams recently expressed precisely the same set
of requirements. And at first, I pointed them to folio_map_local(),
and then they schooled me by noting that, today, it only does a single
page. :)

> 
> For these reasons, I proposing the logical equivalent to this:
> 
> +void *folio_map_local(struct folio *folio)
> +{
> +       if (!IS_ENABLED(CONFIG_HIGHMEM))
> +               return folio_address(folio);
> +       if (!folio_test_large(folio))
> +               return kmap_local_page(&folio->page);
> +       return vmap_folio(folio);
> +}

...which led to a desire for code very much like the above: kmap(),
with a fallback to vmap(). Always better to have such things in the
kernel, rather than a zillion copies in drivers.

Adding Mark Hairgrove in case I've missed any fine points?

> +
> +void folio_unmap_local(const void *addr)
> +{
> +       if (!IS_ENABLED(CONFIG_HIGHMEM))
> +               return;
> +       if (is_vmalloc_addr(addr))
> +               vunmap(addr);
> +	else
> +       	kunmap_local(addr);
> +}
> 
> (where vmap_folio() is a new function that works a lot like vmap(),
> chunks of this get moved out-of-line, etc, etc., but this concept)
> 
> Does anyone have any better ideas?  If it'd be easy to map N pages
> locally, for example ... looks like we only support up to 16 pages
> mapped per CPU at any time, so mapping all of a 64kB folio would
> almost always fail, and even mapping a 32kB folio would be unlikely
> to succeed.
> 
> 

thanks,
-- 
John Hubbard
NVIDIA
