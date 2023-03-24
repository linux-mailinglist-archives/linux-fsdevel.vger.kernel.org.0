Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CB36C7F0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 14:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjCXNqs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 09:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCXNqr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:46:47 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671A41286A;
        Fri, 24 Mar 2023 06:46:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVoBliKGVMGGOlFcFB6akdceBtJwg8v3RY2TPGH+CcolFJo1niPQ8adxFtEQFNQ5zLC/iadELyDt9IQEIzo41aTHiI19qb6JDMVoV8S5UK+jr+D237/qQwWCYVMoX5B2ptmF+/91HLZISikMJ/x+qjBsNQl8bce/AAXXV8oQ/kdEFfn0W0NgmLmTXV5L0cj3GHdh9q328EZl0V3JZFhwQgHG4q7smIT06W4jFBJhflG2e9rMiJO/ksHDQXpFV+bC20DptT72LDrs0hBGSLQWw/8MMrAl00I8qMOS7udovz7ijwrsBSYYeLmSu5Lqfy75rVl+svi5SwJbOow7Cd0j+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBDiqo+ZtLOvXfwNlkuF9pt6K6qQgwI+7IlXVScemAI=;
 b=Chv8BXKXDV4Vb+1nfVUyqtHjAvtjYnMkhO+ur5FOgvW9lVtxT+K1LN7aQOEObZOpbCFmn8meK4BoqI1XW8zmxek+K8Zw7Z4emnp7Y6ZGxYKq8AVN7NT+ZjXpY2w4+dxj0VxxY8YT2X4ThY8b5ZxaP50DDTs9igEIy00RB15Wi3QN9nnGoRMbXEnTdphblWXPqQeRwvNxoks0JQRMyrbc27W9N77W/AiFWmDVZQrYcG540gnW5eldZKAZeVpyX0O+vMTS7eIkEha7EQ6ZplHy9hoDT6/VmNd48OemVm4Ak2u/OsZ06tY/ByPXynW8O7Zd437qi+HdEpa+nFyYu/1fLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBDiqo+ZtLOvXfwNlkuF9pt6K6qQgwI+7IlXVScemAI=;
 b=mEbfyvlg0q9Nn555ez5tOR6XaVYR4/+gG7Afk/nBOJnCRGOYXqzmMXdQt0TIDOHp7cAdniLLEBardCMws8JCFivwndqffwwxImsgBjicHxLnj08k4XO1i6aMfAN4KFZLINv8dIkosHCyxTDNM5Wj584KvQjoUijusg4Gg0shlxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by BY5PR17MB3857.namprd17.prod.outlook.com (2603:10b6:a03:239::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 13:46:39 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::12d5:2d24:8d15:1c05]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::12d5:2d24:8d15:1c05%8]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 13:46:39 +0000
Date:   Fri, 24 Mar 2023 09:46:34 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Kyungsan Kim <ks0204.kim@samsung.com>
Cc:     ying.huang@intel.com, lsf-pc@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-cxl@vger.kernel.org, a.manzanares@samsung.com,
        viacheslav.dubeyko@bytedance.com, dan.j.williams@intel.com
Subject: Re: RE(4): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Message-ID: <ZB2pugK9Vu+nINSV@memverge.com>
References: <87wn37q8v5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CGME20230324084808epcas2p354865d38dccddcb5cd46b17610345a5f@epcas2p3.samsung.com>
 <20230324084808.147885-1-ks0204.kim@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324084808.147885-1-ks0204.kim@samsung.com>
X-ClientProxiedBy: BY3PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::33) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|BY5PR17MB3857:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c67bac4-a244-49f2-d006-08db2c6e3142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LF+NDwotpAZ30Dab2tDplg60pGzFOFbeua/qZwE5catfHy1eCd706YmmXLempheQVuzZVzu03ZwHbKXx/WeZ9UPHclTzpPQwA5euxti5AsgfkkuJsWGdkZD57B1EG28sUqFISInTKnsJyuaHRNl6qAokwNQj8v5EChzBh+ZxpRcOuZPunx6h0NkkQ9nsQphfTSU3LSTaSGI7nKRJUwaSRJJ7kzX6jt1/0kSBDD+LfxW7TYVSIDH6PD32p9abGlvJF1shV+LtOqi5LcvWF5GFuYkVdNh4sFLJdt3xnR3VLpTf1S1NAOEllD6LEsos2h+fxFCZQwgjHEpahiCnQ6C8zXqQZzlo2jU22O0Krytgw2bcIEnMQpbZJGkyP1R8MH9PFaJwu3MhRg01xJNXjK+AXhvzBYdBwz4HaPN6NX/5r/yRufH1mjPvd+zcoRVatz7QHAzESzqIYET9jlYX9nqhI1SvUGnrtfFzqxL1I2RDknx7TPyTqns7yXQrVwhj5C3efLaokFhWEC6PkhgeA6Ow64/bysU7yRZUCecbyJSiOp3qN7xhNCj/+r9LWQ2ai+bi1evt/iZOgn9L9dv7Xr+IeorNjxQc0lGBVePkrv/0oa/O29MYvpSqk+lBTuUCnbtMZi5vx6QpD4fe5hmyidtMGTldoN84D1+fIQcnSXxvE+jzJenK/HLKbmwdflQUuDuX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(346002)(136003)(396003)(39830400003)(451199018)(38100700002)(2906002)(6486002)(83380400001)(478600001)(186003)(2616005)(86362001)(36756003)(66556008)(8676002)(4326008)(5660300002)(6916009)(66946007)(66476007)(8936002)(6506007)(26005)(6512007)(6666004)(316002)(41300700001)(44832011)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ENDJ2Dgn1Hv2r7ZsVd7Otxi+S12LroCQltv95ijLpotRndU/BvRUJu4UnV4W?=
 =?us-ascii?Q?LvGhJKjsU/hKpkac9+7qaYy8KeHTxwO7BzVmakwS/9eJ9HddvVQMQoTe0j8A?=
 =?us-ascii?Q?De0YrDkVeLYzyecxG8YwkhLO+X+PSO9ppn8wiSLS7OGwP9s5Q8xnOsHAIRM5?=
 =?us-ascii?Q?0XxLA0r5mUc69d5emheoeOoAYpWyyipbcTjPmJz8p9EYnMtjHLOK8rfZ+mD2?=
 =?us-ascii?Q?iRlYjZnNR/sb/NDrftkoPuWiqwhc1ans+CUnmPk/npUoPOepopwEXIE78FyF?=
 =?us-ascii?Q?+C4QNBcRf4zpDPJRSBy9ofTM0Ohc1jmJaKM6TxF1Cw0DUGpeE4Tp3rCy1fRd?=
 =?us-ascii?Q?cVIxpNpkJw9EiI6Ka38AxuYHSHGj+Uip679s28lNtJpbZP405do4UOd1wXJQ?=
 =?us-ascii?Q?0TB9JoWmMg18ZioHLRoFDsa3NaWvgDfj6cIA1A1+kDAZfFLCrMkplWTPIb7T?=
 =?us-ascii?Q?/ch+8ny6gUlzhVf59ykNvybv0W9+typVmmUEtTwUoy4ed1UuUWLjguj1qWn2?=
 =?us-ascii?Q?77Tst9wKH/v4NpbbFn5by9V/EB+zPDQxWVajHS2Xu/oU0cbfppQFsqMepWE3?=
 =?us-ascii?Q?+J+ZjVQpkIRShy8H9uvfd3JU0IPQW+fc+IRx8dwmBs+yOMqf6skyyEIma4uk?=
 =?us-ascii?Q?mQL+tALBbEgPpae9EVwcf7z00kQL3nhlcyxCf5JnFXAB0nsP6qwa0TXWGsFG?=
 =?us-ascii?Q?4EMi7EIjFUylROfH+UUEr9L3SJRSKmaln0TKkJJ+EunI1VF4LExibnbF3+pr?=
 =?us-ascii?Q?CwXMxIXbwtkQBWIc8aHTn5buPwTM8WXYIZQztW3LkMwyqGBdTPKDMqC9Xj51?=
 =?us-ascii?Q?vyPFrh1EKEybpyMFFu0eQIPll8D4sppt9xuc11t6pV63xZNdhaIk/9ujHJ3C?=
 =?us-ascii?Q?MOyb1zeAyeCV/qCe1TVAfv9LOx7CAgDIQYX4AcAxC3RZb7gjh6xGyGIKeEJW?=
 =?us-ascii?Q?Yt2ACue+G2P/mJGESM4gDLzLTbKs7VMeynt/1Ug8A1bO2I5RBBve7J+BpILA?=
 =?us-ascii?Q?AqzIuD9ODk1ObMBPv055Rio0LkG984vK/tSgGF8Rw2McmLgjAiR3ut+Z6azv?=
 =?us-ascii?Q?TQwJdeq6ujykSbskr4IMU17soEkz87yaQ84i3sc1puVO0uS5QgvzzKepU1th?=
 =?us-ascii?Q?pSk0oT7vO/Ty8RAMszaqkD8v0xi3GaYj7xJaYhopAjj2LKUMk7f2WGGfeDrp?=
 =?us-ascii?Q?IIA9Kn+3HCSYyIgiPKe0U89H+B1Wg6UaZRDvgu9bXLgSnodctJEYDa3eVxAu?=
 =?us-ascii?Q?HTghkvEFkD9cDbpWsmiDcgzrRhABFcHNIOpNCVb796Svvag3a5pYVL1sowSQ?=
 =?us-ascii?Q?0SMQw2p0SqcG3AuSX2U/aUlG39i6sP7DAOJgK+tSAB7ESiE7O1FpbIoXKLmG?=
 =?us-ascii?Q?lc6b8wTbAMPz2Sv0zXW5V0r8rl1n1yfLq+oETkqGjgMm62Eccl/GSdfBQFGo?=
 =?us-ascii?Q?dqbKkxQjZzA7/lYI9cVjfzpnkFoQRMgBMrV2VD/jioiZsdu9Ibjgy31EJLB1?=
 =?us-ascii?Q?bw1ri1LZEWGhs+ZiVuhTEfe1hihzEOzknyN0ouERtWRfFFopNZ896su+bDDj?=
 =?us-ascii?Q?MUJWcGHeh7fZv/3VkB59mjCHpfc/pLXna9pnznpkifJE8FqTOQT0lcdcnOnC?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c67bac4-a244-49f2-d006-08db2c6e3142
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 13:46:39.0512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yk1KVMEm5o84tK4QaDEUtu5SG3AeKofrMEsNxHVIFZeSToCbJhuf2gdrCT3/ENc4nYO8hOXCovF8lt13IxDa7gsVUe0jUgi2716MwhzGVA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR17MB3857
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 24, 2023 at 05:48:08PM +0900, Kyungsan Kim wrote:
> 
> Indeed, we tried the approach. It was able to allocate a kernel context from ZONE_MOVABLE using GFP_MOVABLE.
> However, we think it would be a bad practice for the 2 reasons.
> 1. It causes oops and system hang occasionally due to kernel page migration while swap or compaction. 
> 2. Literally, the design intention of ZONE_MOVABLE is to a page movable. So, we thought allocating a kernel context from the zone hurts the intention.
> 
> Allocating a kernel context out of ZONE_EXMEM is unmovable.
>   a kernel context -  alloc_pages(GFP_EXMEM,)

What is the specific use case of this?  If the answer is flexibility in
low-memory situations, why wouldn't the kernel simply change to free up
ZONE_NORMAL (swapping user memory, migrating user memory, etc) and
allocate as needed?

I could see allocating kernel memory from local memory expanders
(directly attached to local CXL port), but I can't think of a case where
it would be preferable for kernel resources to live on remote memory.
Since local memory expanders are static devices, there shouldn't be a
great need for hotplug, which means the memory could be mapped
ZONE_NORMAL without issue.

> Allocating a user context out of ZONE_EXMEM is movable.
>   a user context - mmap(,,MAP_EXMEM,) - syscall - alloc_pages(GFP_EXMEM | GFP_MOVABLE,)
> This is how ZONE_EXMEM supports the two cases.
> 

Is it intended for a user to explicitly request MAP_EXMEM for it to get
used at all?  As in, if i simply mmap() without MAP_EXMEM, will it
remain unutilized?

~Gregory
