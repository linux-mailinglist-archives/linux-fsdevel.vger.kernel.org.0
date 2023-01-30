Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81636681D96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 23:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjA3WDK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 17:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjA3WDJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:03:09 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A872765A2;
        Mon, 30 Jan 2023 14:03:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+Kwljf2WCSKEeosc+sOTA/5z4ly+9BqjVzPD82PVf5bq0amoY8Jk2FcupFA7tRB8TvmgN6zhxWNokas5k8EWwE7MuwH4DcfUuWvM67GaD83QZvGraPa7Ew/OJ0E2X/baKoo2m7lQvfh8va0p3x25fn0eQpMVMRDH0mdymZmHQAR3cHK5EBRyLLJZSDf25iBQDpO8bK+D3Sl/Np6C1al4USovUu37iIVTtqXTQ/Q2pJqsu5PfTrQn9dUa5eT7CUGliaQIrcu4yhYp1bzrr8TqXz73/3XC94kXMR6wyM1GduhFOvXR+TgDDrSE48lyNGjcs40zXyAWtdp0P+xG3KbAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXAm94rFtUuWhRp2cGRoX1FTQ2ITp12frpJsJrwhaTc=;
 b=fJxEfe2h0vyghw9e0Ucbqa6gkPXOjDOuj4+lSrZFDU4wpXf2q6+Aj0Lzmw2RumOK+fDq3WTa2+V+OrLkCDUK6CufI8NXkLylTGVEB6ZqdGQ/IZP22hEFq+rUs1xTaUWsl34ffbGAyPWBxCr/+EmYvzNQ7+3s3VW2wPHSxL/su7pzs9IP0wcLdf/tokgsWzlrAhYqsVmprPHP7a5G09zek7+rwBz9EiIk7V27BwYwUEn1x5vQU9mN8AffmNp7AlgAeX8fEy+8FLevWchPxodFYV0AAIeyMl9mn6k5fXzoaqIQ+NmabVSYgxhRzSIdAXiWS8R2RKw9tuZiUuU5f+ZiAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.dk smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXAm94rFtUuWhRp2cGRoX1FTQ2ITp12frpJsJrwhaTc=;
 b=Mt44U1LjBkVMmR1OxIsyQxsrIKNSf1WgU1wZlRCPG6y4m7D5z5+ymQNMOoPLEdqmMfzHMaURXjWNeCTZwDwQPeBKdyVbQZk8WBUjXQkFuaoR08Kiu7WsQZC2u2WHcJiLXnCG01EVX0Jcez0SRpKadeuxeT8G3nmgXYUYQdbSece5l6fnCOU+QSVY5qMher7MGKJgdaP4f2iTOz8+JJEAONIx6GMHuqrU0O4tKSJKnyW+1l8T4ACapDGjUKJ89fo4K2IHOduJn9ZLe7ysuNntf90xro2vMa7yQbX+4i2O0pCAXv7FqSoTWAzBm1vSFz/OlCG4FQFpFTfZ5brKeVjOzA==
Received: from MW4P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::10)
 by BY5PR12MB4870.namprd12.prod.outlook.com (2603:10b6:a03:1de::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 22:03:06 +0000
Received: from CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::4b) by MW4P222CA0005.outlook.office365.com
 (2603:10b6:303:114::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 22:03:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT100.mail.protection.outlook.com (10.13.175.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.36 via Frontend Transport; Mon, 30 Jan 2023 22:03:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 14:02:53 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 14:02:53 -0800
Message-ID: <e68c5cab-c3a6-1872-98fa-9f909f23be79@nvidia.com>
Date:   Mon, 30 Jan 2023 14:02:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [GIT PULL] iov_iter: Improve page extraction (pin or just list)
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "David Hildenbrand" <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Logan Gunthorpe" <logang@deltatee.com>,
        Jeff Layton <jlayton@kernel.org>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <3351099.1675077249@warthog.procyon.org.uk>
 <fd0003a0-a133-3daf-891c-ba7deafad768@kernel.dk>
 <f57ee72f-38e9-6afa-182f-2794638eadcb@kernel.dk>
 <e8480b18-08af-d101-a721-50d213893492@kernel.dk>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <e8480b18-08af-d101-a721-50d213893492@kernel.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT100:EE_|BY5PR12MB4870:EE_
X-MS-Office365-Filtering-Correlation-Id: f44794c7-033e-4685-b9d7-08db030dc462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6akK+Y1w1567USTqZjaYtz7OZJN2fBpkiRIG5MMHbi0U+0Yl9G0YskCiM42J2K0TnclRltu304qiHnAITbGc9B7e9yqKkR5TCM0AxFk9uN1tll4RMkiLEa7+tOlTBNUdqK5LgGP3EPNArK/hJd/kiCJSBzyKCs3bdIimtI5I15sCSzYtpVo9vjanSF8ExZjAkpyZ+x1c6I9M3qiomm6IBsx4JZ3kCuI12G38t462P+x9D0TIwzukzIiCPOn2aWizyuFarnO5LRNtuC9pfB/PS8EFEaY8d/TjhX0dXgJp/LRZGhWTFfMw/I5fFPWAfhJCcvcwJ98Cog729r8XraXn4eG/ezKP0tcqvtEMiarmy4c+/GcnAjtjxEgEqPkvl93+7sQUz6VqxKaHnD100okcsAZnzstxYlx1aJf4NAN0gyHdl1+ilOCNi8TPyUXM0DQ/le9qVrdSWytws/ZcuubLH+Bd7a1j5yhNpk2OKeRvPy0/KExWaQ5p9t3LZUPr4zqdMyqwkGG/kHP4fSG7m2KGY1ptQX3fWQYV17GmCKYStxr8ZvkF052Jw/kUkKdq9KTLvtD/Zl1QyM6pJgtHCemNkwje5kLIZOMVKAbtnj2h8jfbIM03QLEUx3pZ2QBly7u8S/lHCuVdzEY5YvlCH1HADGWe5h5/YJodnrKY8FIzh6H5H8uqIsqHRGRPLuwDd1867lOcm4BGoVrTofIIvSP8ibAOwtwJtkprhQxNWKP6gUk=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199018)(36840700001)(40470700004)(46966006)(82310400005)(31686004)(2906002)(5660300002)(86362001)(47076005)(336012)(426003)(7416002)(83380400001)(8936002)(40460700003)(41300700001)(31696002)(356005)(36756003)(478600001)(26005)(186003)(53546011)(82740400003)(2616005)(36860700001)(7636003)(110136005)(54906003)(4326008)(70206006)(8676002)(40480700001)(70586007)(16576012)(316002)(16526019)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 22:03:06.5757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f44794c7-033e-4685-b9d7-08db030dc462
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4870
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/30/23 13:57, Jens Axboe wrote:
>> This does cause about a 2.7% regression for me, using O_DIRECT on a raw
>> block device. Looking at a perf diff, here's the top:
>>
>>                 +2.71%  [kernel.vmlinux]  [k] mod_node_page_state
>>                 +2.22%  [kernel.vmlinux]  [k] iov_iter_extract_pages
>>
>> and these two are gone:
>>
>>       2.14%             [kernel.vmlinux]  [k] __iov_iter_get_pages_alloc
>>       1.53%             [kernel.vmlinux]  [k] iov_iter_get_pages
>>
>> rest is mostly in the noise, but mod_node_page_state() sticks out like
>> a sore thumb. They seem to be caused by the node stat accounting done
>> in gup.c for FOLL_PIN.
> 
> Confirmed just disabling the node_stat bits in mm/gup.c and now the
> performance is back to the same levels as before.
> 
> An almost 3% regression is a bit hard to swallow...

This is something that we say when adding pin_user_pages_fast(),
yes. I doubt that I can quickly find the email thread, but we
measured it and weren't immediately able to come up with a way
to make it faster.

At this point, it's a good time to consider if there is any
way to speed it up. But I wanted to confirm that you're absolutely
right: the measurement sounds about right, and that's also the
hotspot that we say, too.
  

thanks,
-- 
John Hubbard
NVIDIA
