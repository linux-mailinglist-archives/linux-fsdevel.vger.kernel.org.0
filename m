Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189346786E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 20:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjAWT4t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 14:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbjAWT4r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:56:47 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25A826591;
        Mon, 23 Jan 2023 11:56:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CP6aROuh50CDVPQLnnWn0FnlK0OZZDt0QPyrwjGJ/u1AP2Zt2a8B/btSDY/+LMklEh93e7eEEw/y7N7V9EAPxWihhGbQ+l93N8TYTgbREYB+1FgvxDfAi9SG+HZwLpBkPnCmfbI7/E+3l+0oklxUlLSEH7JxRWyf2gP98RUy7+yIxs60opC2JPI1IgPVX7tbUlcFXzI4zdw0TPMKMzTjuIstdvQT6LOno6+ZDQs4XqM60CMt6BNdMaYZ17UYv7YxU6/tvDiR59rv9XnIj0M4/VB+ciTqBettEeAWlM/A+NS2tOQBF3wbuoyQkpsxOUcQjGodHzk/xBzt4xy6ZFoduw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rrqwi1HifJ5m36QMVzGBFYRvAAQinMGixt0SmqY2OzM=;
 b=jbVSoDdyEBfMxlZqof2M7gSi0G4hhHL48TAmvdz14W7k56XSbJ2kr7/fBvUghYz/5jcwN8szly16eM+Rg2URHn3cA080gYrHhOJruyw+rzC0mB66M4JCe8VyWe5beSc3DRoNHOD67CgnWLfptntLcloLmQXDB8VWInNzpQWc8LlaQ8OhKgbJgx/7zrrwJ1+kCIzisRhtwgezGzRsf4+6D2TVlA6wRQQbkhumfbaXd/BaOwnvuZfHV3SHgxR0DThPinlUkEkNqlr0z/HvK4Z8hOVUIgSaT6+Hw8eY5G2Q0z1aDIgTS7D0OJxXhn9MmvfjA+e8mga8k4to/jfSlUBvew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rrqwi1HifJ5m36QMVzGBFYRvAAQinMGixt0SmqY2OzM=;
 b=tupywpy0xl05Qi/Cpeged7JJsCapQvUJuncUW9atFZyE7wAG8P9WyGgxv1fuWZTn/fWz1zUiqlZNXYPdALpF0bRfs/Mh/P8bI1NN07K3/tNgKHiZbO5Csec+nbMavyksJMfLcNwvmwUkNwXuemAhwT5tryz7ux7lhHGJD9zZXDwVqqrS5sF2E7pJbytAJ+0yR0LGN0mhUq0IS3Kp6ytvSGQnLC77Z8+afVcynpdJkMG8FmCQOTSq3Cf7/gOVuL5y1joHUcrRzpm3m8l54CgdQtU1pct1jJTMBL+e6PL94MFbwpeARxLn/m/5zS9JESNX2IL2z/b8tmuKawmXQUXwLw==
Received: from BN8PR16CA0022.namprd16.prod.outlook.com (2603:10b6:408:4c::35)
 by CH3PR12MB8257.namprd12.prod.outlook.com (2603:10b6:610:121::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 19:56:45 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::55) by BN8PR16CA0022.outlook.office365.com
 (2603:10b6:408:4c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Mon, 23 Jan 2023 19:56:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6023.16 via Frontend Transport; Mon, 23 Jan 2023 19:56:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 23 Jan
 2023 11:56:33 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 23 Jan
 2023 11:56:32 -0800
Message-ID: <5f1764fa-0252-9de5-9522-294a0749103f@nvidia.com>
Date:   Mon, 23 Jan 2023 11:56:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v7 2/8] iov_iter: Add a function to extract a page list
 from an iterator
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        David Howells <dhowells@redhat.com>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "Christoph Hellwig" <hch@lst.de>,
        <linux-mm@kvack.org>
References: <7bbcccc9-6ebf-ffab-7425-2a12f217ba15@redhat.com>
 <246ba813-698b-8696-7f4d-400034a3380b@redhat.com>
 <20230120175556.3556978-1-dhowells@redhat.com>
 <20230120175556.3556978-3-dhowells@redhat.com>
 <3814749.1674474663@warthog.procyon.org.uk>
 <3903251.1674479992@warthog.procyon.org.uk>
 <c742e47b-dcc0-1fef-dc8c-3bf85d26b046@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <c742e47b-dcc0-1fef-dc8c-3bf85d26b046@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|CH3PR12MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: 80cfc41a-a387-4c27-7864-08dafd7bf485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hJKUus55wDzvnSzPSWlz8PVNHM750N2wKLWpfTG1WT7Q5wKtDFe/OGD6L9985O/mSHTDa0G5G1nNfwJaf67cy4j5hoHdon1Dg0oMs9djhzvReHf5bPuuagGaxBjWvNUYUTx8VHv3NPOhFZ38j/MmJYpbkH9QghAdj34fcv/3le9O+McqKPcz1li9/VsVBBotuz/Z59thLLsS0B5PHL/uh+Z4JqklfR5xMKvMxQKbaEGFfGP25+QHmaxqXlyPqXPWVK510doaah+YD+p0VGyx73E8WC/79GRVK1m7CGCR51v6G4/JflSHeMy1ar5f0G9+FjQ7obq75QkOeAMDdJ2tU9pmmlotVDoRBZEJTDLkBkcGmJq/thI1Dm77vhNxv0TkiBh4Upds4s6DETwIuR+osY+8QqW2YhGzyCFywfj07wroVx5yViX6QI+SPzwjSqGqjJuxZejqy2uB4RAPcridr3kgj4+0/vcyXPz1H3RzWo64AAwC9n0J62RGgp9EXQx7EJgYLQzQ67LPnOmLrZHSiwjOz1PQD4Lsk/zdLa2zC98K8dpTFEtngTrnmMF5nXVDvhLxW+fPaDQ9G/VEdy2ccvn7x54xJQFPVT9s4TCDoGDHPFd5m/rj3emCA3OD5r5WVp0VT+LoQEZOfE7o7lmZJWrpvvVvtykkTNu/oXxc8DpSW6Kav61h5/rbZsvuwlhO9lR5/b1c4tUubryGp/SIF40dAV6U7cBroRAhMi3Gh+8=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199015)(46966006)(36840700001)(40470700004)(31696002)(66899015)(36756003)(41300700001)(86362001)(356005)(7636003)(7416002)(82740400003)(5660300002)(8936002)(82310400005)(4326008)(2906002)(83380400001)(36860700001)(478600001)(110136005)(31686004)(16526019)(26005)(8676002)(53546011)(186003)(40460700003)(40480700001)(16576012)(70206006)(316002)(70586007)(2616005)(54906003)(426003)(336012)(47076005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 19:56:44.9507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80cfc41a-a387-4c27-7864-08dafd7bf485
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8257
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/23/23 05:24, David Hildenbrand wrote:
> On 23.01.23 14:19, David Howells wrote:
>> David Hildenbrand <david@redhat.com> wrote:
>>
>>> Switching from FOLL_GET to FOLL_PIN was in the works by John H. Not sure what
>>> the status is. Interestingly, Documentation/core-api/pin_user_pages.rst
>>> already documents that "CASE 1: Direct IO (DIO)" uses FOLL_PIN ... which does,
>>> unfortunately, no reflect reality yet.
>>

Yes, that part of the documentation is...aspirational. :) But this
series is taking us there, so good. Let me go review v8 of the series in
actual detail to verify but it sounds very promising.

>> Yeah - I just came across that.
>>
>> Should iov_iter.c then switch entirely to using pin_user_pages(), rather than
>> get_user_pages()?  In which case my patches only need keep track of
>> pinned/not-pinned and never "got".
> 
> That would be the ideal case: whenever intending to access page content, use FOLL_PIN instead of FOLL_GET.
> 
> The issue that John was trying to sort out was that there are plenty of callsites that do a simple put_page() instead of calling unpin_user_page(). IIRC, handling that correctly in existing code -- what was pinned must be released via unpin_user_page() -- was the biggest workitem.
> 
> Not sure how that relates to your work here (that's why I was asking): if you could avoid FOLL_GET, that would be great :)
> 

The largest part of this problem has been: __iov_iter_get_pages_alloc()
calls get_user_pages_fast() (so, FOLL_GET), as part of the Direct IO
path. And that __iov_iter_get_pages_alloc() is also called by a wide
variety of things that are not Direct IO: networking, crytpo, RDS.

So splitting out a variant that only Direct IO uses is a great move and
should allow conversion of Direct IO to FOLL_PIN. Again, let me go do an
actual review to check on that.

thanks,
-- 
John Hubbard
NVIDIA
