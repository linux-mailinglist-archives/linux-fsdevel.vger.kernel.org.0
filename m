Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495AE678B14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 23:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbjAWWyD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 17:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbjAWWyB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:54:01 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7618711147;
        Mon, 23 Jan 2023 14:54:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FiAzD6u1TCU0Q43Kh17k4KXVBd/EiaWNiD4ctkE7cWexYX+McTdIjiupnq+opt2eg49N9sytsqMOm3e3rsKcP1W2mUCNjWRow0dhaA5guLCxkljuKvFN/5ZAaTMKafey77HkokkFaTNQEMJseONiogv+a4QbcmeXAv9N4AtTZMM8M1+nU0d1Ka/m5HK7SOSM6e5dmYVJ2a7HnZlI+hB3Ki3eRLyQvu4AWQBNAH9JSMfu/2WG0guGJ92qV8HLI94MpPrpsDPa0ngLvtjHBotQKkmDv/BvInM9FaTKw3uz7KC6uqbabfp2aB5nI3Wzbi0yP1RNYRJkX5wcJDqo8gdHpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMH1VEJYyZm5yalnQbq3yECH0HnvwpRSCa8iY8uq77o=;
 b=gc1sE83NizqlaOzCnaMYoUoPR3A968+r6Ig4WVJktkouEktnBMFy5d8VczHw4bKaCRBPKU7QlGcRRhYTRahpY5XKYkPkQLa56Mew2xdEnVVLQEdhcihdzmPlRmpXrwHKT2T1NY2zWcnqFTh61Q+Oph5mrjovCM6XhmlbCPwdhN3Hq0DUIaVteAMNKIz6AIWd6tSp3A70uiLhCnsBBmeDMrDDbGaeemRwLtUvxq/DsFGSdlrtt+Iu74m9Pqs7A94jYm47w4NbussJmVgBLfrxjNM0KrmS7FWiy5MIUqs/jxvBn0fTQd79WTBSDlpuabWKzP5saFqiUacGdQo8w2Kfgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMH1VEJYyZm5yalnQbq3yECH0HnvwpRSCa8iY8uq77o=;
 b=mkvSwSAIV1ynXycyLYV2z+O+rGl4uzoSDz0UGxFFR69l3zjsauvmbbMz/98h/vz5EYJQ5Xp2uEWjKx8vOIpSjjv0D4JRABVtGZkrEnjK3cpMSix+J7+2iBOvHPMLvIzKj4RNfOpzZA+PEw4K1kwKi2L/6jHc3Qaeep3bMxyb/kClVdckQIpocHILYRFavq42ZyJupJrzgsPcvY+96SbkuXL5A78kHVjd6SxxFO4mnyK17uIe8i9EuOh1hyRaQqtIFgGx0YuHZRJTeRxcD8b1Hh9e60RtihS1bu2rSUDtLShcS3+POlnSocTlLzCVFMg1SNS+0RKnvJhd5irPD2N1wg==
Received: from BN9PR03CA0363.namprd03.prod.outlook.com (2603:10b6:408:f7::8)
 by MN6PR12MB8566.namprd12.prod.outlook.com (2603:10b6:208:47c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 22:53:58 +0000
Received: from BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::33) by BN9PR03CA0363.outlook.office365.com
 (2603:10b6:408:f7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Mon, 23 Jan 2023 22:53:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT094.mail.protection.outlook.com (10.13.176.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6023.16 via Frontend Transport; Mon, 23 Jan 2023 22:53:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 23 Jan
 2023 14:53:45 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 23 Jan
 2023 14:53:44 -0800
Message-ID: <3ec34f77-9299-153c-59e2-5c1f129e9415@nvidia.com>
Date:   Mon, 23 Jan 2023 14:53:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v7 0/8] iov_iter: Improve page extraction (ref, pin or
 just list)
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
CC:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Jeff Layton" <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230120175556.3556978-1-dhowells@redhat.com>
 <Y862ZL5umO30Vu/D@casper.infradead.org>
 <20230123164218.qaqqg3ggbymtlwjx@quack3>
 <Y87E5HAo7ZoHyrbE@casper.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Y87E5HAo7ZoHyrbE@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT094:EE_|MN6PR12MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c6b356c-21b3-494c-00ae-08dafd94b642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uKGrWh8gMY4bqqFskL6qOAnKT45JT1sec5MCQd7YBIe/nqkv0vtUTPAcgCK0Nk1R2J+ELjXyI5JCi0JlWq5t41SGDQCvmOVzrIqNAF6TEUQK4Y9ifH5SvpsTXp5babiNNeMQ1Op8FPac6zqrSh0N84s3itqg8VLiNzl/q0yKlMCjIXlRnNwCL9cxZAhgb1Bq5JxzX8X5PpJSuPtRG1GHjVAwISRsUJsfrFu2QjIFlcwVIGsrOhPSgYtxDDHyd/C8xLzXnF/izzjKzUk0WWIU4sifW+vNPA0Sj1m7IM9PFn0q64W4aY/YWQmdpejklJ2ETUSmDVtP4ItMHroB8YgwB0JmrTxu9PgC1tP3qK17b/erYfH52PnKphHZSJkRNx1sSQZ9ArtgMbDCeEb3cuwXPnmeD4cJd4TTR3/z26Yo0WNTwuud7kZwUo7lTfc/FL9yBulXcChi3eku/YWGx1WbTh32KTvJz9FmvuhRCmfx4jeq+LGDyFQ4vrvXiMmaFyiAcpLHEedkdS1VrnLeO0acmZJSpu9Qud1c9W95gb77Eic+N1gD6IvVfd7XKo83McYsoSbtafreru859anPHOi/c5/9kWajROE88Z/1TELnrehIHZ+Iekz3ZS+NnfYNBNa5xGdlGvC6wc6Ce+fAkrALgtad4zyDP5e47JoGNE8DSzZN9Qmdh3BeOeN4LAbIZofKuLY80if6cJjiRjV8gyL3pAAfbKltUl4c2Co+fy+AGGo=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(36756003)(86362001)(356005)(7636003)(2906002)(82740400003)(7416002)(4326008)(82310400005)(5660300002)(8936002)(41300700001)(83380400001)(36860700001)(31696002)(478600001)(110136005)(31686004)(53546011)(8676002)(26005)(40460700003)(186003)(16526019)(40480700001)(16576012)(70206006)(70586007)(54906003)(2616005)(316002)(426003)(336012)(47076005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 22:53:57.9237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6b356c-21b3-494c-00ae-08dafd94b642
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8566
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/23/23 09:33, Matthew Wilcox wrote:
...
> Bleh, I'd forgotten about that problem.  We really do need to keep
> track of which pages are under I/O for this case, because we need to
> tell the filesystem that they are now available for writeback.
> 
> That said, I don't know that we need to keep track of it in the
> pages themselves.  Can't we have something similar to rmap which
> keeps track of a range of pinned pages, and have it taken care of
> at a higher level (ie unpin the pages in the dio_iodone_t rather
> than in the BIO completion handler)?
> 
> I'm not even sure why pinned pagecache pages remain on the LRU.
> They should probably go onto the unevictable list with the mlocked

This is an intriguing idea, but...

> pages, then on unpin get marked dirty and placed on the active list.
> There's no point in writing back a pinned page since it can be
> written to at any instant without any part of the kernel knowing.
> 

There have been filesystems discussions about this: if a page goes
unwritten for "too long", it's not good. To address that, bounce buffers
were proposed for periodic writeback of pinned pages. The idea with
bounce buffers is: even though the page is never guaranteed up to date
(because DMA can instantly make it effectively dirty), it is at least
much less out of date after a periodic writeback, then it was before.

And that is important for some file system use cases.


thanks,
-- 
John Hubbard
NVIDIA
