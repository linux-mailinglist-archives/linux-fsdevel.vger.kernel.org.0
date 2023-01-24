Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD1E678DD7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 03:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjAXCCc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 21:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjAXCCb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 21:02:31 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8769037;
        Mon, 23 Jan 2023 18:02:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6JVWJPVcEpJvx7ysuF1rZpb3pvJyQyuq+HQVbOG6nvA7nhMAnx3rNUuWflxR2IZ2dOmrQqk8IP7TGR/wC+foJeuVDIGimUyjPzBQJ9bIRNxwSfqV5+rf3LznLahPpG8PMovLOtb1zh9SNfa1Xh5ygCmE96VotVKeAg8jo4NBLCkP1iQ5oxhcfhhz4u9O/qZvRecGVtmngAwgnonk1k+DwfbozFUtMgeD2BgHLf3e4ZMnjlEx2K7YCrb/iQrzeFOMdJ1+SjrqidfAvYnO9fa2YeusON/M8mqzXrVEkgN86/Y7MD3ySeGYqEZLVaYomEcoWnudjbOXc/74mcXAhIsFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxAUNRE+g2XY8e2/Skjsg3235xTJbp/l8AuBGqDWT1E=;
 b=UEdiuT7oa0M2ouXk1I1R3GSIOEgPRH+Tcz2goR504o8XgIVpDLVS5jJivqFM49oHWah0CXWRYA3SSUS/eAeZIlU1aL5iRb9YpTTm0l/Bs+vOjXn1ctSPq9ZaZqlYu5z8W94mtEkqTzUVfsP8w3i7PkerskzbgZoYHFkkbkqLHoAbqO5YjZbleMaThFD1idzKnKxxPrxmIRAqHDsNUgsVCCadx+1b/Jf26nbfomyGHXsdpArMbwuFP/s4qbwo8KfUx2SwObdHou4zI1nQXHM2NDc+16ouf6V9KmDvYSxQfxMTL7loxj3nEunadTa8qrtFEq52sxngMG8ADl4cWgw5ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxAUNRE+g2XY8e2/Skjsg3235xTJbp/l8AuBGqDWT1E=;
 b=s8rC47I6H5Yg9817KZdqfAHfn1lApG5C6NNdAPyBU1oPjVHZRQfPuWNdy45YG1pm4toSeCywcfXiLNPAH9MAJYoN+nQtGCxVJ8UKcer8/6I6jNA02i8LbGx57HGL5RZ1yx1Osl+1QRAW8tbWFhjoH5Jn9tUArQ4aJCc9KqfP/KW6aJ1R9j1U3KxjA0h049LTlBArYUvAbD6xk1BOGmH04jpHTpqMNxAP/m0KB/Wkgp61K3olO9cVcdsJKq4olU45pbfYziyzszWds66HjMmr562uRXgJcuscRy+2NNaT/V7qSRKNXDlip6VlrB6JMDfCWGkO+m2G/FculsQodFacnw==
Received: from BN9PR03CA0316.namprd03.prod.outlook.com (2603:10b6:408:112::21)
 by CH0PR12MB5369.namprd12.prod.outlook.com (2603:10b6:610:d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 02:02:29 +0000
Received: from BN8NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::6e) by BN9PR03CA0316.outlook.office365.com
 (2603:10b6:408:112::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Tue, 24 Jan 2023 02:02:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT111.mail.protection.outlook.com (10.13.177.54) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6023.16 via Frontend Transport; Tue, 24 Jan 2023 02:02:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 23 Jan
 2023 18:02:20 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 23 Jan
 2023 18:02:19 -0800
Message-ID: <aff23352-9808-dd7c-e978-2049ca71321a@nvidia.com>
Date:   Mon, 23 Jan 2023 18:02:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v8 00/10] iov_iter: Improve page extraction (pin or just
 list)
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
CC:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        "Jan Kara" <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230123173007.325544-1-dhowells@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230123173007.325544-1-dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT111:EE_|CH0PR12MB5369:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f62da8b-f3c5-46ce-ce1d-08dafdaf0b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y9Q5Qoy4LoYBmnL/HZmCfMbpR+F9S6veuKQ165jRpW4bI1/xSOHbo85jPiwj9qcWhzEA9GRJPctsaGDkbk50TdZB2K5D4IhhCHV6tfjcG6IJQrCVf5v+D6okC0784U6e4Wy87cxOH4fDAeMaX9cFLqgmAtPrBJSiNe4EEi9xwiHTO05AnHtOFMU4sBafRWztL3Z/XYJEdG55M+NloEt3kCmjqZ5HIrW5N7FIILmZhWC7CDE4Z0tL0aE0DceEheAxcIpZtqn0yJ9YImwK/+r2Y6syrlkpgiau2E9iNuqDT0rVBq/T3GVwEOLtWBM450TZ1OxNjT3DT/agZhZNsrsrG5jQF922jTMwM6wNPfhsSGM8TDna67p4h3HlhCpvD/AKqLPqnmhaaoKbsSzhKbKEvKWEAIyXvU5c88dNsUynwiUXsx4MHPpv7c+Pzg1Rep5HG/EyFGKo8bhB7w1DBiTqjXCh/s+Vz4483PfaJqfu7bevqXKZ3iJdVT9lSaZNJbE/CXCXypGqXnNvTgCGh/5toN6pCppbiES62wvH4sFwkWYkc3gWmxrmqa1DO+Rbt4bC59nvo/O6hwqdih9g6HrQJldrxbTiuXbGJZEC90vQn6Q0o2DqF5Clw6RkEA7wpQldXQSsLveM2lRi+YEc00Cuku4Po0aiWPN7RRC2txwUFvhTOmzxPLRCyBgjy0rY6vBSFGqJbuXwrQ5cIDaZdsV8kCY2FRinVh0Z23Rh7R2Bwbo=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(40470700004)(36840700001)(46966006)(83380400001)(36860700001)(70206006)(86362001)(70586007)(8676002)(4326008)(316002)(53546011)(54906003)(36756003)(16576012)(40480700001)(16526019)(26005)(186003)(110136005)(478600001)(356005)(336012)(2616005)(7636003)(31686004)(47076005)(8936002)(4744005)(7416002)(5660300002)(40460700003)(426003)(31696002)(82740400003)(82310400005)(41300700001)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 02:02:27.6877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f62da8b-f3c5-46ce-ce1d-08dafdaf0b6b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5369
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/23/23 09:29, David Howells wrote:
> Hi Al, Christoph,
> 
> Here are patches to provide support for extracting pages from an iov_iter
> and to use this in the extraction functions in the block layer bio code.
> 

Hi David,

It's great to see this series. I attempted this a few times but got
caught in a loop of "don't quite see all the pieces, but it almost makes
sense...Al Viro has spotted major problems (again)...squirrel!"; and
repeat. :)

I saw your earlier versions go by and expected that they would end up
being an iov_iter prerequisite to getting Direct IO converted over to
FOLL_PIN. But now it looks like you are actually doing the conversion as
well! That's really excellent.

I've made a first pass through the series and have some minor notes
that I'll send out shortly, but it looks nice overall.

thanks,
-- 
John Hubbard
NVIDIA

