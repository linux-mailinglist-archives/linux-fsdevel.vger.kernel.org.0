Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7A85ADBC6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 01:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbiIEXQ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 19:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiIEXQz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 19:16:55 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6085551411;
        Mon,  5 Sep 2022 16:16:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gri3N7kMGb05XQangrcRfk7+uyYU6S08t9x/v7dd0UKHV6kC9CJ6ujLzdKQwFgowQ+er45t0Sc+inet+Je6PBt+8tVa+lLUDJ4F0J2IYqkmeye2e1p6rrh97AX7S4aFO2zcd9ZZNT1hqakWAX9lfjXJ7MM3gVtlp52tDP7CVdbE74JQ8kJtPdmTNvPxUxjdRcWukeWL7TzTxQrLWZiL+k4gCWAST0UPumlsYAblGDeeXAA+PxhzbElXwC7YCJCgEthNrIDvaNzwkAoPQF2naV/+rUEgvGREnzvIcaA69o21Y4tMBKw8WshL1oc2xMlHQWaBaufwzlGw6ArlYTxd41A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+P33CyB1HlJc2Ww3QtZ/ZEHBMAw3vDPUQpnFlWijSM=;
 b=Wz3dTBISXxx2TciYMiZRpBoh8Izl2A9E2x3f1cWOcl/T/HNsxh8T/XCXQhy1xUlftN0rSD28g3eUZ/+9jSNQSXQbNX9OjOpN6Q8WQoYW4C7EmAEsXub6hM6zki53zVKar+IW2ZGaazyxMOanoCo3pLFjdIgb01VHkr5Zwa4TOf2Zogtf3PHX28W69slIJWcRkbQjKveS5owiIgT1YF+9efGVdT7xD7mgkBnUwyqoD/qw/UuRDn3KBUr82qmzZGnOcLZnBBAisteTBwNBkluWty+jVAb7ALGz0vNv+O8AEUHIJggaIWW3jL1WMgEORGDJvyXcjAGzloTeCzWUXmmXKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+P33CyB1HlJc2Ww3QtZ/ZEHBMAw3vDPUQpnFlWijSM=;
 b=KZOBe4YGdYthTsXHpml1ImuL3iqQX9lrL0uzh0dWSXfr9I+3KwyutQIFtjHidgDYDPFu8T0Sdq10o6RhSkAwYkYCPnSazCPccYV4QU9+SHptuaaYEcshZlEQxlCv50vr+1wlINFwxEYqK5u4rhCwzOVmj2HmmGwEy+l5+O8ggygwbA3NQl1Tp2AOjchu6iCTT7viv19E6HLtcFQFHr1lZPfOq222L3YbKk//aVcs/qosmEQUrL/vGc4P8jwH3+z8WUfEQiWzgdEpQgeqobyXHLV7IgdccdPK8uTzKj6OOhBnbKuZdIVFdNTmjhQZ30MOlA2oAKQP82zu1iesHGReow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BL3PR12MB6593.namprd12.prod.outlook.com (2603:10b6:208:38c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 23:16:52 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 23:16:52 +0000
Message-ID: <86266dcc-d475-7cd4-77dc-a8ba6f11620b@nvidia.com>
Date:   Mon, 5 Sep 2022 16:16:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
From:   John Hubbard <jhubbard@nvidia.com>
Subject: New topic branch for block + gup work?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0232.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::27) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 432c65dd-8af3-4819-a426-08da8f94b750
X-MS-TrafficTypeDiagnostic: BL3PR12MB6593:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kjU6yASqWqAu44NoY1WoyKWj4FSekq1zvdPGE8NFWH1UW0y9CiJaqgUmBNSDU1QxDgfAJhDIshZNBFMsR7bO5u5sJ6ZHbfueSJpq09pqWta3TZ3hi8b3JmRkSHT55gcUNfRfnTTyPqnQNvUn3/tEvKupx6Rslym0jdoUG9Dqv25e53HmCbzCJY+O9vb11onsETyikVQZvV/y+uw1E+hKx4CtdEJB5079g9FrP1eFr+l/meB6iEm7ogNrG5H+7+8UY6uemsva/F25HGFbD9jNVISfO1TvlDrPxvkAJ7j6PvCyqFrLk2Q5LUWp2ryaKIKeRKhdSwMLkq1yT/z4Mz78nXFV6jHY+17xAZk2K/eCFYggLkjJ/wyPJPuQ7QoG5xtXIbZ2QF/3yUgP+aawAv6gIjylYuUM+2hlah2D1e+p45QPliip6HSBo8AsTHs9kNIML9qYH9P/qgYu7eOy4j1YriZte+huEV1tB60984+BBLV9vCaNbK3gcYgDq7UDPDPUBWVxjuyDqOS5P8bgj4YCJeRSunHKLalOTIDJPgm+GzA5sTiyr3q0hdat9fSr7Go3y025Y+3iixOAxboSR6HzVlCiKVrpBnXKtaajVmNRdNpNNTRkDNZ3klwPc4ewB9AjlVaw8sjcKKP95qsARoLHNhuToOdRe9fXYAbhTXRuX5U246DJlfT26+CGRvlM2/Q5PpK2aHBPinH+Vla6aapu6W7gYZgPFn2UGAqODR2UlUa7C2JJamyxwXIWDmJMBtootul+UWT6jKefYl9m4bUchEIA0Yvt/cLaSKg8MLZVd8KJPevWTJeezKuJyK1ufRL4BmGy9WXF4eTlgIlZ7ld7agRkmUTZTJYMrbPk7pGE7ZLFBAn6iqP0OL/KduOAAbsEsuHBfdXBvGjMIDn8WQItCI+H645tA0NxnU+2eTF/sDI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(66476007)(66556008)(4326008)(66946007)(8676002)(38100700002)(6486002)(186003)(966005)(2616005)(41300700001)(6512007)(478600001)(110136005)(6666004)(26005)(6506007)(31686004)(83380400001)(8936002)(5660300002)(2906002)(86362001)(31696002)(7416002)(316002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDVzMkU5dkN1TGJ3TmJpTVFrOTFSWDd6bys5TkFPa3pBajBCK2M4OERmcVRX?=
 =?utf-8?B?TEFWNG5CZFlzam10NHBwMEg5dHNJOS9JQkY4c0RGeEhZNDl2L1dnNENJRDJi?=
 =?utf-8?B?c1NaWTJ5QVpROUtaV1R5OWNhQ3h2Sm15Q2VXMU5GT2pnSkZtNm5YTlh3aWtz?=
 =?utf-8?B?b282UWxHS1pxakFMV21xUUZSM3FFL0dxSytaOVBvbkw2UnVESU1xVlJJeFhq?=
 =?utf-8?B?VHpTVnVwaUFIY2I5UnNmOUtaT0VwR0srUWpHbzVYU0Z0WnhJcStlT2NzaXl3?=
 =?utf-8?B?V0RZT2lkSXAzcXhvNlJhaUZEMlc1ajVUT3RRVWVQWlpGcGNKZ2pxaGNIRWcy?=
 =?utf-8?B?NXJEYWN2NzA5a2J3djVIM0htS290WHFQd0grS2E0VkxJcHQzWUhaUlNMSytV?=
 =?utf-8?B?UTBYMTYvUkZUK09CRnBQdndidUVqTStwdHJReHpmMDBLMXdlOFk0WS9rYXdt?=
 =?utf-8?B?a09iTFRqK3pwcTVWUDBSWGVmZGYvWnQzZW5FNE5RdEZNcHhTWC9Zb0dnN2x2?=
 =?utf-8?B?SjJpM25vU1BvM0lwYlQ1dkJsT1hCK1RhZnc0Y0xXS3owaGJTZ05XK3YxYlNl?=
 =?utf-8?B?N28yT3Y3MWk5NDcrRW4wZ2gzcVZWSFRaajcyUzR2bFlxUWVTaWVxWUhyekph?=
 =?utf-8?B?eFpLNnJxbmZneFAzeVdmR05IeUpyUFRBQTQ3Um9xRHQ0NDRibkJVV0tqZmFD?=
 =?utf-8?B?ZGFkVlR2ajdqVVBsSllsWlRrY2FXMDc3bTYvcXN2N0tzdzIvSTU4SHV6QU4x?=
 =?utf-8?B?eTZncGdXbnlyT0JNOXF1amdRczhrMGpHZ1pTV255T0prbFQ4MW4xRkpBWkph?=
 =?utf-8?B?V1g3c0N6anRTQkt4ZURIazBOV3o4cXF6VTc3c1JhaUJYekdBS1Y1cElsY3BX?=
 =?utf-8?B?c2xJbWc4L1NCRDRiTExNYllUM25mK1U2cllYall6SHpnTXVLL3NuSVVEYnpD?=
 =?utf-8?B?c3JZcWRrQWRySldWMzZYZ2w4c0QydTFaTXRmWTZBdVFjdXErWmhZd2hnckgw?=
 =?utf-8?B?NmlQZG0zOEJJb25kVFhyNGtTcnBlWUswM2dTMzNGY2R0N0FWSnhPcE9OYVQ1?=
 =?utf-8?B?dGo1QVBXRVlsbUs1TllQdXNDNmx4c05vQmNSb3BIeUk4dGQyblFlTG54c1NW?=
 =?utf-8?B?VHBtY1NCNWVLTWp3K0RGVlNGeVJxN0VQVXducW5MZ1NxaHhCRmxCV2NxdjRr?=
 =?utf-8?B?dnlwWTZ6dGVGSGMxYzlXdUFjVTlmNFl5WFRtOGoycHpHWXJzNFZGWVVDS2s2?=
 =?utf-8?B?WUl3VjcydllLVE9MU2ZObWh1WWdXcXpsZXBxVWhaWG80bUlUZnk2L0dQZTVO?=
 =?utf-8?B?WmNRVWh2bTV0L3hXRVlTWGlXQ2w4UHovMTFvTUxtcjJEMzFuOGFqeG9iN3FH?=
 =?utf-8?B?ekc2R1dXMmhnRmtMeGo0ZUdNOG8xb0N5WCtEQkdiQ2RCY1Q5eXBqVmYxVXZo?=
 =?utf-8?B?RElMakhybXZSWkZIb25ieksxZ1VWeUFsZHZ5SGxKRUttNWJBQTZ4eUxhVllI?=
 =?utf-8?B?b295ekN6VGJmMnE5NmpKbmZlR3VRSDIvQzlJV1lwVDZxR1F0eUJMNTA1cjh0?=
 =?utf-8?B?MEZrSU9ZZWVaYm51Mjc1M2F5TE5obTlrYUk5NmtIanVOZmpMOVV5dDRvVWZI?=
 =?utf-8?B?OWRVRCt5UytLTXhBQ0Z5YlJEZThxZUQyVUhzNFdaWXQyZVRXL2JuL29tOTdy?=
 =?utf-8?B?dnJHNEpFN0FVMjZueHdVMGNHWUFPZ1U0eFVDdzQ2bGRwZm5Zdzgrb2pwNzVx?=
 =?utf-8?B?Q1BVa0h3T0lyR2tkSEM2TTVxTHp2Zm9DOTVaL25CK3MxQzE4Mm9VK0haenMv?=
 =?utf-8?B?Rko1RDhIZy9kUS9vbjhxWTF4ZWNRdUhsSUI0bjB5c0llRmhCMnhMU2FBQWxH?=
 =?utf-8?B?c01PcVhubGRRTmlVeXVpY1VvdFBkRmN5R2FrZ0VXTC91YWRHVkhGYjVhc0Y2?=
 =?utf-8?B?MUJ5TWdRUzVnNlB5cFFXbnR6WnhYQSswWFpxUGgybitLN1FDekxHU1ZneXVP?=
 =?utf-8?B?V2oxTHNPSktZZUtCbjBSdXVQa05xZzlCcVJCdE12RzRHekhtSU5qQnRtUGFU?=
 =?utf-8?B?WUxrWXNtSmZXUE1ReWJoTEMzWUlieWx5WkFvamREV084Y3FkaEw5aFY4Q0ZF?=
 =?utf-8?Q?ZhveSaiigSSqVapdRv2YqK0QF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 432c65dd-8af3-4819-a426-08da8f94b750
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 23:16:52.1043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+hqe5REKWPEuxBNE0eviLbFeSrB1A//IjTOZxro/VqHL4Aw+2+jI8R9BELNY91bpQ4jFvUIdVyeHYkVrVD12A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6593
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jens,

After you suggested a topic branch [1] as a way to address the recent
bio_map_user_iov() conflict in linux-next, I've reviewed a few more
patchsets in mm, and am now starting to suspect that a topic branch
would be ideal here.

Logan's "Userspace P2PDMA with O_DIRECT NVMe devices" series [2], my
"convert most filesystems to pin_user_pages_fast()" series [3], and the
block layer change from [1], all conflict in iov_iter*, and in
bio_map_user_iov().

Less of an issue but still worth considering, Dan's "Fix the DAX-gup
mistake" series [4] conflicts in gup.c, too.

Maybe:

    gup_bio

, or something like that, as a topic branch?

Everyone: thoughts, preferences here?


[1] https://lore.kernel.org/r/20220901161722.739d2013@canb.auug.org.au

[2] https://lore.kernel.org/r/20220825152425.6296-1-logang@deltatee.com

[3] https://lore.kernel.org/r/20220831041843.973026-1-jhubbard@nvidia.com

[4] https://lore.kernel.org/r/166225775968.2351842.11156458342486082012.stgit@dwillia2-xfh.jf.intel.com


thanks,

-- 
John Hubbard
NVIDIA

