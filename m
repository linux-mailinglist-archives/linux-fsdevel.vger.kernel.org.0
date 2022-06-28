Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFC255E790
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 18:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346541AbiF1O3T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 10:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbiF1O3S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:29:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35903122E;
        Tue, 28 Jun 2022 07:29:16 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25SABxFm014974;
        Tue, 28 Jun 2022 07:29:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=cjgKh6laBtXIdHJyCRsyBhI7XNiDml2QdVK9Ti4nKXI=;
 b=kyXRQAtmJ2yBT91u1/mBhxYkYcXg0+4PRmVXI5kQdUrezR+byp7ewioPsu2J9IJ/3z7i
 7UGg9L/i9pn8rkvAFiHwV6Ix0tRpJ0KFD8EKyu8Cn2vk6qXOHi4FvbWfwF+BFRHhDdJQ
 vEZEU2C2uix8iIfSU70GL+FpybxYxzrEmnU= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gyp23436x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 07:29:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVDyOk16eIShIcZ8uPgaqT9spTsb3wHjjv7hXvy2HJI65vsiGIb35QrcxdVzc4JlNAelw6aSSPf9ZxqIXwbPgPNR3VKcqhE+gjR2g8MyGu6kNyXuDg0d2+SHZFKqAZmWR+4DkqByBCwXgfjOmg4QJhX5IOMgmIArQ8ZtIJKBKWJWsZd+eEnFifA+9vQcnNoPy5a+vJMnmHgqqmBpS7RiUDC7xD0qb3XTn7hdU5zlOjU1NumGn9wHha0uLte5upX+5OkluEiV/h8K+29LRyADI5T4cnbPRs4y3IhryKgtj+2IJLb/BmcImKBzgv2pN24s7bLhh9chGij1LrE2EfSXHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjgKh6laBtXIdHJyCRsyBhI7XNiDml2QdVK9Ti4nKXI=;
 b=nQC6KLSSrZL+PhgNtxfQJyq99OIyBeOWs6n/rBCMIPY+szPkZb1vJ9dOrlr30fNATPCRGQXIZqpDosgrOXeQEXRb1QbfMLXF1ddrPsRzHOZRPXl5qNdKVjJBx8bWJjXdn3F83f03DDMoYHoK1Z047/t9qF7nv3z1FZhZuDCeNRm9pQVm+OfL+AAIwtFRp0pcIAFQG7jVV3YVFjcr/0kWbGX7pcSEz6cfdXz6V4o+2C1rT69grTpGTSYrKv7kYj2HCNfs+iFD1rW3VnUjmor2zeEt9wVqx3vcXGJpRNjzuoGj6J1DRRkFApalx9al3MGzFEHH5iaKfjjsNbe5OB0tEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by PH0PR15MB4702.namprd15.prod.outlook.com (2603:10b6:510:8c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 28 Jun
 2022 14:29:02 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::f0d7:b035:60c5:d07b]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::f0d7:b035:60c5:d07b%2]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 14:29:02 +0000
Message-ID: <c4af4c49-c537-bd6d-c27e-fe9ed71b9a8e@fb.com>
Date:   Tue, 28 Jun 2022 10:29:00 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH] btrfs: remove btrfs_writepage_cow_fixup
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220624122334.80603-1-hch@lst.de>
 <7c30b6a4-e628-baea-be83-6557750f995a@gmx.com> <20220624125118.GA789@lst.de>
 <20220624130750.cu26nnm6hjrru4zd@quack3.lan> <20220625091143.GA23118@lst.de>
From:   Chris Mason <clm@fb.com>
In-Reply-To: <20220625091143.GA23118@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0394.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::9) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51a245fb-fa17-4616-a046-08da59128c42
X-MS-TrafficTypeDiagnostic: PH0PR15MB4702:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XZqQQnOAmjj9PsowfvBkyIN9cdS7A/SMyIVFbumBYGtSsGAzC7eM0O23O/KhKJSRr1mb62PB5BI1VMacqpZ4OYMB4P9Qnl8piUWn/K/2w8tPdu9N7TjzeEl+E4/jSkJQek/1Lfo1gzkimbPue7k0DKeBPkBqt4D12Ux9FlAOr7YkwRJpCAwd6kG9Q9pNCiw0/lKQMtSnzxMMx3Vrm/XJlt/RAplFUrsPwqVx2EP+w54ZAIIQ6bNbo6c6oHM3Km4/YiTMwaigaybHMHJJfClPlUarj49DWARwWHXo2hVHilU4+fZf8pScAuaeYJbl8Wkw94+xq9Y1XVTWITPtzBfiredub47CadefWUFQw6x7pPZof8aYWErD3s3DWdn1XmkLbcWONGkGGehuWS8P0Ay5JqmaH2l7mcpsC6PRSyadTOz2qZcD6uYGsBTo0LwdMHyBsroUn/tMPYDJv+/HELX1tACwf10dx7WxNWU810HMKxC9uvzL6aRNHA4SIsbjqs6eACjLbqbjxNut6RhGWBwpvt5aUvzgpx6MeJS20qlipZf/c8Ef3CIpvKvVa+fSSdx0gut+y3M+ySJvHnmgqi37Sm5a1Tgx+VBBSUKBNU8JFJDWrngTjps5rnXy6it5GbB92hlXUjMCppeAIPn8iBTbGX0vpc+nGHWN0mz/S5icunabgM/mXQ7bgkGGXLzEPIBeRU+ZAZOeWhdrJqIvcBPWJ2Iyp63Jlpap45CneNx5sCQsAvpk+63lwveb5CratWHR4KK4V66uoyttJfCB5KY1bHbn8Io2xYOY85myJEKxyI2Ory1HXPiqaJ/AeU2ET6GTk1kQWr2VVGkIeOW0f0v0Rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(38100700002)(110136005)(6512007)(316002)(36756003)(31696002)(31686004)(41300700001)(6506007)(86362001)(53546011)(2616005)(6486002)(2906002)(478600001)(66946007)(66556008)(66476007)(8936002)(83380400001)(8676002)(4326008)(186003)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2VJdVphZ1k2cTJsR0dLbHIzYjRBaHBsRVlHcGhNZmtKOUVRZmpYTGlHVHdV?=
 =?utf-8?B?Qk5McGRDVFZaWHQxdlVySmVIdFpDTS9pU2U3Nmhrck9sQ25XK0ZDaXJGNDBh?=
 =?utf-8?B?K3pMRmUvb1Y5b0h5b2NqbjM0dlgrMWd2VHBWRDJ5REZrRVhlL0tCWUZhR0p2?=
 =?utf-8?B?SWkzNDZKbFQyNWtWOWlqRHRCR2kyUHdFYVErR1Z5Slo3bkdGamowNTFmaVBr?=
 =?utf-8?B?S3J3b3d0SUVhdC9ySXlhRm9FaytWTG1qVmY0QWJnVWtMOEFoMEs1YmFxSzd0?=
 =?utf-8?B?YTNnejJGWG5tWjUrS3FPbUhaVjRyMlJuUzdWeS9IUkM1NHpQTGZ1SEh6bE5q?=
 =?utf-8?B?MUJUQWsyTEVHODUwOGFUZ0I2WDZpbElPY2t2Y2svQkhVOGxCQ0VTKzduL3dh?=
 =?utf-8?B?MVBCd21EMmdJejFOSktIVGxQUnlQS1A1QmZ5VnEyZ2dsOGdQbHNqRExzV1N2?=
 =?utf-8?B?Qk1PNG5DNFJvRTBkMGJGb1kxSmphMW9uRU5XZEVLeFJBVmdnd2tGRXVtS094?=
 =?utf-8?B?QW9TbmFtb2trOXg3VTB5T0J6OFduTkJkK1c5UGxYWGVydHZISy9BVkUrRStx?=
 =?utf-8?B?aTZMVnZ6QVdodTYrRDBQbTJZcGZHejhVdWtYbXFXbzNxQ3QxYTFJZzcrMzU5?=
 =?utf-8?B?RjJGdTFnWGdPMC9NeFJmS3paa0RXWVJjeXowVHhBaksrbnBFcFgya3p1elcz?=
 =?utf-8?B?dDF0SVBOeGtrc1dJaGNCeVlFd0E5RGdlcnI4aFRrR3FnQjF1M2lYWW9UNFl0?=
 =?utf-8?B?RjBmdUlCSlE2WmVMamU3aFdYdmpDOFJsWkl0QW9uN0NrSFlLTDcyK0xpb25a?=
 =?utf-8?B?SDU5cEdKSlNxQmxDK25EeGl1RW1SdmZmR3liVndWNS9GVmhnZWx3ZkRNSEts?=
 =?utf-8?B?WTFKUmo4UVhKTXZ4ODd2QktBdlI2eEJIaXYvVldtMlNMQlVZUmE3RC9QbWJR?=
 =?utf-8?B?SU9hUXFlMklSejZYTWpneVFJU1pRancwaHNyaW9GTk1GcGw0SzRtZW5GZUl1?=
 =?utf-8?B?NzdMSzFBc1BvNzQ2Z21RZzQvUE9wVkl6WE5yaHVWK0VSSjl3eHVYVzd1UWpL?=
 =?utf-8?B?QUZPRHJkL3A2WkQ4bDZCYXBQdmVUNXgxZ2Y1UENjVXVWNmtFL25BbFVBMHRT?=
 =?utf-8?B?Q1lGeXM3bkIwOGxmY0dhUlhnWHUzTzRzV0tvcDRmb3F0WjNBYzkvQTBRMGVz?=
 =?utf-8?B?TmJvK2RncDdyeU1jUDNvNTVjaktCNXFRVFNtMVk0SUY1U3c2U0xucmtaKzZW?=
 =?utf-8?B?eUlTa1ZlTkxocDlnY3d2bWJkbnp5cDE3V05Wd3VzcG9yS0ZBbjZwYitqeUwz?=
 =?utf-8?B?T1QrQ0crZU1pZHo0dmY5bG9NckZGMnRlM1ZiOENxWTA3cFFPNlBxREExSGdT?=
 =?utf-8?B?dTRhTXcxNHBoVFJsYWUyOTNxRmgwajFsT1gwL1ZFS2hCc2M2UDZtMUVWUTIz?=
 =?utf-8?B?MEErL3V6enliL1RYWHVRdzVDRFc2dS96MU5tWE5QLzhCU2NENUorZUhYeGpY?=
 =?utf-8?B?NXRCNGJhRjJEdTREdndnYzhjVjlDcXBvZ3l0M0l2TVJ1c0pvMVNSYUtXSGdK?=
 =?utf-8?B?c3FDZE8rUE5aMTQ4Vnl5OFI5UmRlS1pKUnU2ZHk2TmQvM3daNkxjeUVEcVpn?=
 =?utf-8?B?VXNYSGpyQ0g0S3FLajBiRzhGOXFRSXNIUnVjeVBKdEpZemRHNEdvWnJiVHVq?=
 =?utf-8?B?ZlU5YzFQM3lJR1hYL3dnRU5udmwvcUdTUDdVN1lxM3ZITjZJOGx1cDNFMmM2?=
 =?utf-8?B?R0I0c2RTYmpHd0RnTUxWVUc4cFFxeG56dDVuYzNOUnNUem4zdGVBRU5YTGRh?=
 =?utf-8?B?eDRSQk95VVpXbGJsRjFSZklhNHBQVWhyVDI1VzNxcjRWRHVlK3doVjEzZkEw?=
 =?utf-8?B?SFNBN0Nzd2RXOFQxR2RvTXE0Y0lYczdaQVJiZVplaG16YXBXcXJqNE9NYmlw?=
 =?utf-8?B?Wmc3TytiOXc3bVduMDNQckc5eU43QzFaZ0pvbWNkdGZlSnVnY2Ric3lEMWZ1?=
 =?utf-8?B?ZTdNdjFPaVU0YzdTU3Y0OGl1V050Nmd2UlptL2V3M0RKQjdML1VscXEvc0pj?=
 =?utf-8?B?bHVzR3lLQ3JDeGtyWTNlWk5pZk1qalk2dXhXOWgwWGVwRjhhZEFEcERIQ1Uw?=
 =?utf-8?B?UkZManhWUDZaejg1UjhaNzl5N3phWm5FaGxDSzNjeTVMRTlBL1ZxRHQ1VU45?=
 =?utf-8?B?NHc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a245fb-fa17-4616-a046-08da59128c42
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 14:29:02.5681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWCVmc119HeZV3FfbvDG16s58wKoQZUx1eqH92u9oDSIq/xvjc87YiVv40eUruHe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4702
X-Proofpoint-ORIG-GUID: iNlGDxqLZKEPvPi6LQoSq-3bFaEZRmq8
X-Proofpoint-GUID: iNlGDxqLZKEPvPi6LQoSq-3bFaEZRmq8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-28_07,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/25/22 5:11 AM, Christoph Hellwig wrote:
> On Fri, Jun 24, 2022 at 03:07:50PM +0200, Jan Kara wrote:
>> I'm not sure I get the context 100% right but pages getting randomly dirty
>> behind filesystem's back can still happen - most commonly with RDMA and
>> similar stuff which calls set_page_dirty() on pages it has got from
>> pin_user_pages() once the transfer is done. page_maybe_dma_pinned() should
>> be usable within filesystems to detect such cases and protect the
>> filesystem but so far neither me nor John Hubbart has got to implement this
>> in the generic writeback infrastructure + some filesystem as a sample case
>> others could copy...
> 
> Well, so far the strategy elsewhere seems to be to just ignore pages
> only dirtied through get_user_pages.  E.g. iomap skips over pages
> reported as holes, and ext4_writepage complains about pages without
> buffers and then clears the dirty bit and continues.
> 
> I'm kinda surprised that btrfs wants to treat this so special
> especially as more of the btrfs page and sub-page status will be out
> of date as well.

As Sterba points out later in the thread, btrfs cares more because of 
stable page requirements to protect data during COW and to make sure the 
crcs we write to disk are correct.

The fixup worker path is pretty easy to trigger if you O_DIRECT reads 
into mmap'd pages.  You need some memory pressure to power through 
get_user_pages trying to do the right thing, but it does happen.

I'd love a proper fix for this on the *_user_pages() side where 
page_mkwrite() style notifications are used all the time.  It's just a 
huge change, and my answer so far has always been that using btrfs 
mmap'd memory for this kind of thing isn't a great choice either way.

-chris
