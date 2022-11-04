Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3D1619FEA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 19:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbiKDSal (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 14:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbiKDSag (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:30:36 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA60AE64
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Nov 2022 11:30:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jiKwCDaDC4IW0RzeVk74fF+RYSdxviZISL8fAe2ncJTDMX5rN/4XQ3os9upWJH1t41mQ3UyTwXJPdMadaPizrmLkpIVrJOfCWY+EqiSOhbetPtQxdKYnw+6yRDiGLt3ZEJF1gcv1aJ54s1vTUWjgwwjpdQTf3L9PB9j0clIMQjvKghK0bbgaYelZrjdLTcmjKlbeodx0nVnWoGLku8SLrjSreS8K9KUwvBs/0cvJgVgvU8pVsmhLx80xl616ezR6wxTirnXglQKWbKvTxRgaWd2wN/9ZftYzz4oQnOYrncyF+MbjRhVFRl1im+XIudhGKOlJZTlMMrolPYs1eUwnoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahIeLQyg4hnekLPOi1U+qoeyrsHLpsQLyBCrCmVEX40=;
 b=i7imOs8ogD5WS35RY5AzB/Ujkhalc3HeG74G6j/mzulqnCc2NFLusWOWHn/+53ICsGNJvY6mXXQG0yt+bUzil1grYlXvw8xFiDtFYR0QNFoAA/9uXfkSN5y6YB4Wwa7du7ZkbOqRtFKpraf2k6l0dUqtQF3BxucG4r9V5bwYQRZbuyDAhPUVjiYf/XCR+qAxrQJooadXJZIAno6Xf49bwwLmegB9PWrAhilNWE6mg6sgN6vSLFrhAmpKu4GaTWmJYpsWPhk0TowAdk13lF+GrkPSuojVXBcCPsEZsHJO1G7HtFgV18/M8pwuayHA49HZxbXKnharxysmWdBZsFQd/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahIeLQyg4hnekLPOi1U+qoeyrsHLpsQLyBCrCmVEX40=;
 b=dSfIPDh+34gzCVuQX063YlhUjS1sF0dS77TNx4vRhHFBbsZ0Ie7430LVux5rHO118TioY1+D+DU+aD95wGv/iR+0tGqBz3fI1q0tXB/+KPk+zyeRKXVAPtR0PirV4zWCiBYRXagcezDS/RX6WYotjkvJqxflIjUnxWq9zOypi2lKvAYNmMZFoKW5NH3j7Ceuuyn/73EOOeh2XvaMP8J5a5HA25+vuhB6/f2d6/LvN80WGU4saybufKTtwWmTNBLEd8WHwwA17mMetf6wzzhdV1yzx0rGnevkaMPWZtlZruTIHCvAutYUnTKz5IaTngM6S99pgMGLT7vGOhc3HjF1uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6353.namprd12.prod.outlook.com (2603:10b6:208:3e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 18:30:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 4 Nov 2022
 18:30:34 +0000
Date:   Fri, 4 Nov 2022 15:30:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     zhengqi.arch@bytedance.com, Matthew Wilcox <willy@infradead.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: xarray, fault injection and syzkaller
Message-ID: <Y2VaSZcX7uqRvRf3@nvidia.com>
References: <Y2QR0EDvq7p9i1xw@nvidia.com>
 <Y2Qd2dBqpOXuJm22@casper.infradead.org>
 <Y2QfkszbNaI297nl@nvidia.com>
 <CACT4Y+YViHZh0xzy_=RU=vUrM145e9hsD09CyKShUbUmH=1Cdg@mail.gmail.com>
 <Y2RbCUdEY2syxRLW@nvidia.com>
 <CACT4Y+aENA5FouC3fkUHiYqo0hv9xdRoRS043ukJf+qPZU1gbQ@mail.gmail.com>
 <Y2VT6b/AgwddWxYj@nvidia.com>
 <CACT4Y+aog92JBEGqga1QxZ7w6iPsEvEKE=6v7m78pROGAQ7KEA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aog92JBEGqga1QxZ7w6iPsEvEKE=6v7m78pROGAQ7KEA@mail.gmail.com>
X-ClientProxiedBy: MN2PR15CA0001.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: 12edcefc-b054-4472-b0d6-08dabe92a96e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VM8E45qlP7uBKWlUeaw1TmIbBys6xQY8zKYrduOBnIiyJ5oYn+LdQvqdV7MFQLmCSZXub+8QOg5yEjsWAxkQyBiFPK3Qypvg1+9bVgUFvZnzomYo6qvrqJzQrWcjnmMAK8mO5Z6PNBxKM2N7NVof9Cw/o3zXNdCu//ZwaoCbvWOjP+GlAYzGltbZQT5372M9QFFtC8jkQ/As920T7Fhxl4AXGtX/tTW+oWBxCzGlxyJmz3M1kds6lXAPszLh11Gz80qo9DhKchQ4mnQLSphicYHq0fyaW9iUTiHNyo1/NUQmDl3hti9birC6RHr/Z22CYS1Y2S9t3cK+sxdDavbM42Py7A1lvs8WZoPHoCZ4VituLk50EbFV/0o1Z0h37+eMbHgwADuSMQ6Ej0B5mKTC+nk2nTz2fBaX69DTdKlR5fF9WG3BR5wa2NA3zV4I2+KoGwgW4DWZoQ0DjxBIIvxbnDnkCpWoUjvIVCYp3xVH+FZ8YfCTbjlEhVEOBKGz552FpNEg7zUqck7plh/vBSDOptOigWqg3Di/t2mqYleu3zhNtTeek7sj+pGxPL+91N6XQSi+cVWhFDN1/x2EM1VLJYj3N10NJz08CIe0SLBx0ClCjo3pj+WjUZsJ76E3xMKmNdDBI4OYF4mStFVF4fOn2mIKw7UXksjwEu/j21CbHeyG3gAqEwShvtT2n1EvCRPdMIb2K1o847A7AZ+bvM4pGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199015)(5660300002)(2906002)(316002)(8936002)(478600001)(6512007)(86362001)(41300700001)(66556008)(186003)(2616005)(66476007)(6506007)(66946007)(4326008)(8676002)(38100700002)(36756003)(83380400001)(6486002)(54906003)(4744005)(6916009)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6pUwygXk+BpoEBt6THPn1pl6JNHV5TWrXg8mz9eG/hMtmLFJfjAboXD7tInQ?=
 =?us-ascii?Q?gH51a+mQRbth5pA/Fjuivzz8qzEJi1C4OcMOgLdopUIgEBtlsPICsj11bCFp?=
 =?us-ascii?Q?HrR6u13AyfFozcLcwDcSv+kJ9KeD2AkeEQaDItMg4RzS6orJpeuOan88qpPR?=
 =?us-ascii?Q?eHya1NDDoZhWd7MPsLmYzVR4JIqB9lYwVFh3ZhSyrd2rERQUv9t7VqA9GWlh?=
 =?us-ascii?Q?QX7JANFmzw9vX7YkOXjf22DbRYMhLKaKRB13gH8DabZntKl4vwBMbfamciWr?=
 =?us-ascii?Q?ykimC2zPAZhaZn0CDdWVXJ0f5fsD3vAiuyEpb6CCWIU5ivVOVW6ceMA0T1/l?=
 =?us-ascii?Q?dN723kQUVAb0QXcesFEI5v/LukwFU49a915XNCo5x7Ty4T+jMRXcEC6BBrfN?=
 =?us-ascii?Q?Xlh//s/obRAdv+1y8FXRqcS4XDBSx4YmrDlnoepj4WHsN1DEDcqgcvrVgJxS?=
 =?us-ascii?Q?j14+RYy4qbBZGvilLLScRe8qli+6Q9b4hqP2SKCEUgubEy9zlJvk2GMTe+qR?=
 =?us-ascii?Q?xkALBOI/REoh65DTHuBrqkY1aqKzzxXUqez8qa8ETumHfti3KxcDGiVfZUNv?=
 =?us-ascii?Q?ANe7me+HesL6LsvAYzl7YmqbwbolNaa4jJd88uwsIXGR0cqdK2etBjn63JaK?=
 =?us-ascii?Q?BLcpz52jAsg+T8XVy+jsySTH/9IaCnxZdaun0yct959Bw0nVzC5jBFK4Byon?=
 =?us-ascii?Q?Wd1vN/X9WyFYXK1Qf5hxG2TnqqKdh8t5tPrd1SKStovI73aj2WzMLnlEgtmA?=
 =?us-ascii?Q?9sYEpc+Mi7zlzNrn0g9CSpjwluneC0Gg66gWVld0dnV4mpE1fZfxkwxVFI6R?=
 =?us-ascii?Q?6cOFr70z+o5KsuIp4LH59akM5kd2vf6w0SuzBMYmjmK4ag0iTFWsDqnZ3jaS?=
 =?us-ascii?Q?d1As3qoZhjwmqzrmnSBiu+vInFhzjv9Q49FpxVdkd4XZmmWT5+1NNC74ALvK?=
 =?us-ascii?Q?11+SmkgDxTy0LSbM5IAL6EC/3XpQTd5IjZRRIW/yu7iGuWE8i7OJwuRFkE8I?=
 =?us-ascii?Q?6KYDlxUFpPrDjp9bDUP3StLLrNLxp/C26UjoHr2YY71kodM4uftFYnwmmUEv?=
 =?us-ascii?Q?T/SETm6edPf4+L5rWMFtHPIY1goNvJ6Re9ZL4MPMNi1PQzkd79/yw8Qfy0K9?=
 =?us-ascii?Q?4w5u9xgf0LvNfIPidB9c5nb7KYuFkHv0tPjWnY0diUQP9D2v9TFkISgXRmeW?=
 =?us-ascii?Q?Dpp+kWZPAubTdxUlhtg5PV5WyU+iisjCDSiOdvcb0GjOkhjIt89N3vuQrx++?=
 =?us-ascii?Q?6p++jkWZK0wPDt/hElRFlHNrZ7bbUZ6drLqaGCPO8j/iJd3BkbSR9GlS8u5Q?=
 =?us-ascii?Q?96F540+On9bY89BYqy09UGQXRCmymn3Qq9QOgzZbFRspfoiYZm6cT53g1AtX?=
 =?us-ascii?Q?9s3LOhqFYc+FWJgtvjWtuaHCZvofBub/gIypEggAL2YaiBfFYYKGvFRO0tIx?=
 =?us-ascii?Q?r6dmOzUz5gX3vUQpfWulcy36ULKCRaCOI1yeJxf72dWrGF7bK0AvGUH+4VQb?=
 =?us-ascii?Q?I3q1IiYwG7qRmp3ulqyQFG4vmP1wLILZFI8OdAnlmGrRvU4XAl+83ClO1r0t?=
 =?us-ascii?Q?qfDuepFPZ0mhI10OfAs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12edcefc-b054-4472-b0d6-08dabe92a96e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 18:30:34.5015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0QVmOb2yVTb6ai2Y2WACMN/TZA8Dm7iTWeqvmdu7B6PntinDK+V9+GnQO3JLJUia
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6353
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 04, 2022 at 11:21:21AM -0700, Dmitry Vyukov wrote:

> But I am not sure if we really don't want to issue the fault injection
> stack in this case. It's not a WARNING, it's merely an information
> message. It looks useful in all cases, even with GFP_NOWARN. Why
> should it be suppressed?

I think it is fine to suppress it for *this call* but the bug turns it
off forever more

Jason
