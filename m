Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28C2678EDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 04:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjAXDL6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 22:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjAXDL5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 22:11:57 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01B725297;
        Mon, 23 Jan 2023 19:11:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jL4/DYgsjShsC2D1s5XCUcft6sN0Ox8X3n1NApbD2QjFkq2SJErFHt0XwmOqMllxyxZi41b9VE/Hb+eotAWPUvOOhrup3DIsqWApjjaQTbB+zS3CGvfDXzrkUttyzHKjb9vEWRdwJtoco/nELfOVhA8N4bEmxJe5VI+x3mvdkYR3gXytmfFNmOfgfEWLJdIe2mWlNy09eTJrsgBY93GGG7kj5YKndwGh+QKJM5LjSSkYFcU2n7+CsibYzuEswq0wpigNuP4i0Nru+bl0nlc5tIzX7Y4f7fEFYK/MGhSR59gRT+yWRJhpV3HS54NXMXNumOmKlNN3rrp/IQ477bJ5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUuA28hc8DRt2hNAadbDCsh652Ffi5eqAqVkZKCgxC0=;
 b=icSV/NXRUKZIgU+ucCOuMKo3UtpbxP07kq8Afecmx8T9Qq3oZOX1gc/MdyQD4lnfNxuX+uS4Xk9l91mRqleXW5LoZGuXwWPm8SQ6EOz6bj+07XUpwWUm6aptoud8LzofMR9iusba9fCVdYxLR4GGCcfub2DUmxRXRRVj+txv432CwMx8PE/Csc8XcKNOT1k8JcbDyLIQNrEn7LbhIHCviXM7yglJaXfe7PH7pgmSUIbVXPDHVQBKO9AqzkCWMpRsCXYNcZjO8pUfNgVYTRo/SZL4G/Kt42t3bIVi/INDqH5MF9faDaWopCcuirxwNBtaFm9rgZ2rcahhXLhoEs8aHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUuA28hc8DRt2hNAadbDCsh652Ffi5eqAqVkZKCgxC0=;
 b=KQQ3TwGVDxp56SmxJBSHgU7iTCv1rdx8Wp4fGDPukrmLfrHB3yZhfOd01EmJUC4Fl3pqRKBqGGwLUY/pPmq+8nWH65QF9WgzAdbnxf1Etklf4HhfvPRvTdVHrobjxHC6tW0DwAEzvhDUsvDfhDgp8jTt71BYzyJY8Ud6WqLGRrXJdTk2kWbMvRKpMqCvYfPk9jgtKCJuXvzYtbafj85hS2a6ptWCnHABOgVRx6wqp6j056Lu7zT+d2/KWPowwLrYAPcVegHps8OW0Mj4Rvh80ruscyZqERRlyqqlUHKUfCCqVcgvY+7iOhzij2Ai+7C73nGOEBitrItWg11VRVYyzg==
Received: from MW4PR03CA0176.namprd03.prod.outlook.com (2603:10b6:303:8d::31)
 by CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 03:11:53 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::19) by MW4PR03CA0176.outlook.office365.com
 (2603:10b6:303:8d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Tue, 24 Jan 2023 03:11:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.17 via Frontend Transport; Tue, 24 Jan 2023 03:11:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 23 Jan
 2023 19:11:43 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 23 Jan
 2023 19:11:42 -0800
Message-ID: <84721e8d-d40e-617c-b75e-ead51c3e1edf@nvidia.com>
Date:   Mon, 23 Jan 2023 19:11:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v8 10/10] mm: Renumber FOLL_PIN and FOLL_GET down
Content-Language: en-US
From:   John Hubbard <jhubbard@nvidia.com>
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        "Jan Kara" <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "Christoph Hellwig" <hch@lst.de>,
        <linux-mm@kvack.org>
References: <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-11-dhowells@redhat.com>
 <31f7d71d-0eb9-2250-78c0-2e8f31023c66@nvidia.com>
In-Reply-To: <31f7d71d-0eb9-2250-78c0-2e8f31023c66@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT055:EE_|CY8PR12MB8244:EE_
X-MS-Office365-Filtering-Correlation-Id: 453ee89a-92d1-42e7-1f07-08dafdb8be53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RlCI1DU7fxHRzIWFrY5OC8QoGWm2cwAaJNK8llD6F2aBhcrnQqUROyz0uYhzL5bQj4x3VsuRfzxuMYJ6An6srKvyvJumaUqVvuP1qrh3JwCNKBLneYo0PCs1tS1Xsh0Tful1veZQp9Dc3OPz2GWX/76dE7Lt8jd20ETdF/HreoWtVbycU0OM39byjEL6or4hwm7cmayyU2Z0XJexD7k6t5cAikcifRMQz/LXlvE0N516AnUQzxbRk47uw2ZMiAQok3aTukKOLNBZswgY6DM8TQ9w/2/QEtfBNfxDjnENnDGSp+oOGLZFaN8qUszlPl1m0SLRUUbDytliKyc7pKRWUHOkozcAm7lhRIwYkJZqXYqvEUTqSMVkhECHsqCgSZBD9hbbRsJ/f3k/sdp2pdlysPanZ5isj6t+LgzMA/ns9HpxRJ9yD/M8/j7wjCGESkPR1osInEYUMmG6OhgvRmvKiydsmG6FdpZyOj4e5j8Bt+iSRSJGIk726dXisNoqGqov90IuXdoLGg/f8DG2OU1d6jIMZJ7cxGYSnp24PI9k+xu/p5RsgqLRmGFUQgHYa/OdgEE/Aek7C6fY18A2C55GOETYqfKIDtoSm+xqdIwkcyOD3P+hiXWHFqS/4BbyfMS09lPIltLyR7d2ZVqG9DUI+tKE5R93shO57wX/GHgIaT017x7nFHhMdpM8eaPsesD3f+CQJDjsZ74q3fh2RtEJ2+hnoiMhq01X6BbSlKhghGkhfSQsU/LIL1mDgt0NbiTpicfvwKmzE5iKVRIedMUycXNZgnLF4KOUm6z4uO+83KhrKG2MMKEDWw/19V6LeZIx
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199015)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(86362001)(31696002)(36756003)(6636002)(316002)(54906003)(16576012)(110136005)(478600001)(966005)(5660300002)(2906002)(70206006)(4326008)(8676002)(8936002)(70586007)(41300700001)(7416002)(36860700001)(7636003)(356005)(82740400003)(82310400005)(2616005)(186003)(26005)(53546011)(16526019)(83380400001)(336012)(47076005)(426003)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 03:11:53.3556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 453ee89a-92d1-42e7-1f07-08dafdb8be53
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8244
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/23/23 19:08, John Hubbard wrote:
> On 1/23/23 09:30, David Howells wrote:
>> Renumber FOLL_PIN and FOLL_GET down to bit 0 and 1 respectively so that
>> they are coincidentally the same as BIO_PAGE_PINNED and BIO_PAGE_REFFED and
>> also so that they can be stored in the bottom two bits of a page pointer
>> (something I'm looking at for zerocopy socket fragments).
>>
>> (Note that BIO_PAGE_REFFED should probably be got rid of at some point,
>> hence why FOLL_PIN is at 0.)
>>
>> Also renumber down the other FOLL_* flags to close the gaps.
> 
> Should we also get these sorted into internal-to-mm and public sets?
> Because Jason (+Cc) again was about to split them apart into
> mm/internal.h [1] and that might make that a little cleaner.

I see that I omitted both Jason's Cc and the reference, so I'll resend.
Sorry for the extra noise.

[1] https://lore.kernel.org/all/fcdb3294-3740-a0e0-b115-12842eb0696d@nvidia.com/

> 
> Also, I don't think that there is any large readability difference
> either way between 0x and <<1, so whatever you and Christophe settle on
> there seems fine.
> 
> So either way with those points,
> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> 
> thanks,

thanks,
-- 
John Hubbard
NVIDIA
