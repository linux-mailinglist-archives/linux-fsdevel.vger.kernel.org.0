Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBC5678BCA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 00:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjAWXIN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 18:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjAWXIL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 18:08:11 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C448EC73;
        Mon, 23 Jan 2023 15:08:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgmO7e1K1VcG8FZ+YUntzpTCCCEkeeAZsKSMHsBR0s0U4w3Gw4kW9H3sTEWei32QFKqc+G0OVZZ80COJhSVODO+RtEJ+NklBv8txqPhUCldCkL1kUnIcTtx6v3J6hjXnlI4q/SyQBYGXz2XppD3jQBUCsyeEi7D4Tk6W6CKn68UChp3EXjhV0qD2Vss5ZnPkQS8a1LpN6mfNlZixY2Ec+noJOFdeoXjv8LZCyRiSGeqF2V3RENX1j/H7+xb9Sg0EokExUpa5wtIOEBLzQehjOUB098l7PidJlCcQEqFRx45zsxdIlqA3z/uLep8QOpAIK6h6c87He3ms4MI9BGlHbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyqAItdvtD0oUKdVMUJgMo3x1Pd5nfjwBtDNaMVaJHg=;
 b=TmJd801zvxMT6MOJdnzuYvWzAxmbKlWBOc0RfI55FojeJ9CoPoqTv62FjV7dHm4GH+P34N0Vk3hbwxE6JFmlUW1W13Ma0u7Mc0zpl5xBB44lPzZrRe0c+OAFdQoEmadiSXN3juKeuHzuAlUBiIxT5kBl2Trl1g/rvmsdYB8ZS9fW1Dr2B7HwoWPx7D7Cm7BEJsJrQiYRVAZOHCUBXHqMYJu8KYAYnndaF78UFdN30tFtMYWq8z5rTPwzuBcU7kW5OAeAq6Lj3r8s082BbJ25pkokICTv7RHqAgFj0+JqxZhBqLveE5AXdeRVUjT9kfpQM785ry9Jl2q2Tl6p4Jv8Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=suse.cz smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyqAItdvtD0oUKdVMUJgMo3x1Pd5nfjwBtDNaMVaJHg=;
 b=NSh5X4xdx7SjZUTOI8z9EdpSjW4QjOamVAw1fpwfK4hKyWdY6scFqToamqEXVPr4b/nl4v4ci7xubQPvnik6aLaNVrbt79oJF6yGNj37ICH+KlJ03Nzqtlve88Py2mdZyBVN4aytiQSweF05qljnApLYMD6jf2rkRFD2OpcsQFT2xHP1WyArGzxijhjrQVD0pN+YbuL9OJzKTtyyfHlYfHJBA35iB0k4zxzug5AnPewk3oaGoS8WUswFgjvvSosnht3Tuu7b2C7NSAwLOWTwg/0XKje5wEQDCD+VshxUS1P8KWi5Cc0y0kRkSP29gQRf1f0QNYYGOWh4CUT6ckAmiw==
Received: from BN0PR04CA0196.namprd04.prod.outlook.com (2603:10b6:408:e9::21)
 by DS7PR12MB5912.namprd12.prod.outlook.com (2603:10b6:8:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 23:08:08 +0000
Received: from BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::6e) by BN0PR04CA0196.outlook.office365.com
 (2603:10b6:408:e9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Mon, 23 Jan 2023 23:08:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT072.mail.protection.outlook.com (10.13.176.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6023.16 via Frontend Transport; Mon, 23 Jan 2023 23:08:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 23 Jan
 2023 15:07:49 -0800
Received: from [10.110.48.28] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 23 Jan
 2023 15:07:48 -0800
Message-ID: <c3e0b810-9f17-edb7-de6b-7849273381d0@nvidia.com>
Date:   Mon, 23 Jan 2023 15:07:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v7 2/8] iov_iter: Add a function to extract a page list
 from an iterator
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>
CC:     David Hildenbrand <david@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        "Logan Gunthorpe" <logang@deltatee.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "Christoph Hellwig" <hch@lst.de>,
        <linux-mm@kvack.org>
References: <c742e47b-dcc0-1fef-dc8c-3bf85d26b046@redhat.com>
 <7bbcccc9-6ebf-ffab-7425-2a12f217ba15@redhat.com>
 <246ba813-698b-8696-7f4d-400034a3380b@redhat.com>
 <20230120175556.3556978-1-dhowells@redhat.com>
 <20230120175556.3556978-3-dhowells@redhat.com>
 <3814749.1674474663@warthog.procyon.org.uk>
 <3903251.1674479992@warthog.procyon.org.uk>
 <3911637.1674481111@warthog.procyon.org.uk>
 <20230123161114.4jv6hnnbckqyrurs@quack3>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230123161114.4jv6hnnbckqyrurs@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT072:EE_|DS7PR12MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: 937ff662-3465-4b4b-b52a-08dafd96b0aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tCpwLCLGFR0Ba7TfooSLQYXsEy+wYRo/JaiEsFq0lvi6fyGlntVS6/dJItFLgbRYSlsWxSsWuSwFwvHcY8ZlQWcp/fHieHTj3Q10zO0IZcxHpDVs670mYHu4SRdyjQ99pus+1DG7bmoW/b2ZGLjgPeRUUpPMLCKcxHNRTn8cGcmHY2/OA8cjnTZjzO3bC/rEH92Mxks2WV11hjnJrAuS3OcswuZwiiFCtPyFHonjSX4VZTddutbyKjTMy73bCQSQhHsC9bQxn2FU254BC/jNV/hiNFwrzACGQZWIfwLU3p7aZQePj+nFIb/ZysMfikaRQnFIgB+UoV5g7zCWUkHaz3joRNfJkeJN+djCiAJhtRy/B84N03za2VGbNGK2dBCbDZuQRrqmL1OFIg7AkOqYqdH1m1nRjH9y/MDlZBsQEqOq5pQ4IgWsgIJ10TFr70Sbj4uoH2cBR8NxB5JY3VTBUSQ1Ko1oP6Suy8TsPevfSKcA+oIyzodFmRpQAydnWPcEnzRvacCRyWnz3pqhlvIVTNM47t7DKlQzRaPP7rsc6w0rNx5Uw+WNCMnHo5264+If/hs5ZwRPicUgQD/xAGMYR7gV2jzJr9R1tt7XnfPdtQQko022FiXqDjXYRlPc/iFzyYowYC09VWlrQ7q46sxonKhqwrvfAhs0M7VOD40lizpQNThcDpqp/QHCSAEo4PdbkQil6tDvD8AbZEnnDmHBkFZ9LHeiNXJVzstL7O9xw1g=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199015)(36840700001)(46966006)(40470700004)(36860700001)(36756003)(16576012)(316002)(4326008)(86362001)(70206006)(8676002)(70586007)(54906003)(110136005)(16526019)(186003)(26005)(53546011)(40480700001)(478600001)(356005)(336012)(2616005)(7636003)(31686004)(7416002)(4744005)(5660300002)(47076005)(40460700003)(8936002)(31696002)(41300700001)(2906002)(82740400003)(426003)(82310400005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 23:08:07.5058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 937ff662-3465-4b4b-b52a-08dafd96b0aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5912
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/23/23 08:11, Jan Kara wrote:
>> For cifs RDMA, do I need to make it pass in FOLL_LONGTERM?  And does that need
>> a special cleanup?
> 
> FOLL_LONGTERM doesn't need a special cleanup AFAIK. It should be used
> whenever there isn't reasonably bound time after which the page is
> unpinned. So in case CIFS sets up RDMA and then it is up to userspace how
> long the RDMA is going to be running it should be using FOLL_LONGTERM. The

Yes, we have been pretty consistently deciding that RDMA generally
implies FOLL_LONGTERM. (And furthermore, FOLL_LONGTERM implies
FOLL_PIN--that one is actually enforced by the gup/pup APIs.)


thanks,
-- 
John Hubbard
NVIDIA
