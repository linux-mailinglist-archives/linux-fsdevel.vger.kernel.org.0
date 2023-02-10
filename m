Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C01B691686
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 03:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjBJCKm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 21:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjBJCKk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 21:10:40 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5496E9AC;
        Thu,  9 Feb 2023 18:10:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJIn9ZU7PZ7etdIOd+zNOIQPDD7+2EAFJ22TOCxCgShYJZAm5mHFty39vybG0DGsaQeTG8ZqBnRb5prwafPdMy7xpBtQa/GZi7WzErJ8qMR64RY0ufNPMK0+15EJnb60vuPtxjpp2mPxug8J8DQIn4xdXyOz8JT3GjKwjVrlYv4mf9mFyBZVqFrH0RdHcayPqf3OEF3kbZzq2RwTeCgCTcqdre/RtYoZKmPe3+sfwhLnWz3wnfQa+T12MZb7sB/PgqhcWCQ78JPAf1hPiJAzWAmkr/90xLQ+QAFFJw9c4cn2i7QhMJHniRcj2Zx10VhGxtV282yQT4mQKglyOUE0rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gw30FNRnuT/3IOLTpvOzD4yIWwEhfvsC73MRHoWUZWA=;
 b=XHYh0xSDKVBV0ELBm4d0fa9HLwWvNol0VETwCpSoF6OYUnJex02IVh/7I0s0eceT03Bctl5f2PJjktajnHvC7tSDv4+OHvTLiNXHNdZ5/UUYC+VsuOurSfND5OGk9cv044VE3ibSp3bvGwGhLxPUba+xhKjPkYg7FKYf2E1PYk5CwIvUz2uHrEvL5/3EJn27kGxahWSEak6CZeMoFpcTD/RDToYvzElagElH2tv/kqjfF5RQgwRz5NurgMSdteET8UuYd4/B3sM0G8fY0OZQnPvgIxbApHsH8Zwlv9VhZNQulV8ezv8Dlzpue5vHEOGRcjdV6/2feBMnzcm7YMqsQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=suse.cz smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gw30FNRnuT/3IOLTpvOzD4yIWwEhfvsC73MRHoWUZWA=;
 b=dyiBHccmyZLrwVVgjsVESINlYqItFYwQTUYG8xxy6ecsh24oDgbpGZ6JzXsMJ1dHreHd8TC2B49Enzdhic9AMsuITl/io+/pZIjMh5C6l6zmyIXkxnlk1wviwh0ztbem7lRQ8zBA3l/5yCqQV+4JjgNs+GHtaT9S2BM6nHTHoMLLTTYM6AMh/3ro/G5Qut+NZbq3pktSR0f8rQJ7BcJ7z/eWPjFzHsgzVpK5UvaRQBcsxTXBBbuMHf3bRlnnfV+/aEuCFdySfc8+F+2ChvTUbxiHHcru2VvQn1CoGluy2xVk4mRQb81IqheGF8czB9pvO4uTAHGJZ4pD83OnJVHYqw==
Received: from BN9PR03CA0460.namprd03.prod.outlook.com (2603:10b6:408:139::15)
 by MW4PR12MB7359.namprd12.prod.outlook.com (2603:10b6:303:219::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Fri, 10 Feb
 2023 02:10:36 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::40) by BN9PR03CA0460.outlook.office365.com
 (2603:10b6:408:139::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.18 via Frontend
 Transport; Fri, 10 Feb 2023 02:10:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.19 via Frontend Transport; Fri, 10 Feb 2023 02:10:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 18:10:24 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 18:10:24 -0800
Message-ID: <175bbfce-a947-1dcd-1e5f-91a9b8ccfc25@nvidia.com>
Date:   Thu, 9 Feb 2023 18:10:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 3/5] mm: Do not try to write pinned folio during memory
 cleaning writeback
Content-Language: en-US
From:   John Hubbard <jhubbard@nvidia.com>
To:     Jan Kara <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>
CC:     <linux-block@vger.kernel.org>, <linux-mm@kvack.org>,
        David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>
References: <20230209121046.25360-1-jack@suse.cz>
 <20230209123206.3548-3-jack@suse.cz>
 <4961eb2d-c36b-d6a5-6a43-0c35d24606c0@nvidia.com>
In-Reply-To: <4961eb2d-c36b-d6a5-6a43-0c35d24606c0@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT039:EE_|MW4PR12MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: 5328e3d9-d4db-4f26-e3c7-08db0b0bff6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9MYKQEKsi5Eih/MvpWu5hgEV9yEpt1bNZV8dn9wPGBVRQ2AaMLZxdeyfLmTVvyQUgjCAooTRBOntYW2pKf2uqteVvt7NHApUQJqMpOO/URtfkN68E0HJtRzlwi5HUS2rk5aenEv8FSyq2A0zOy0btIbDo76rXGBlzV/TAwltbbc3LxWhaZ2ty5hZOCmYO/pGtmV0u5+bHLKMIeu+SLjLTEF/OoZVnzOGe86xy1V+aVCpegNyY9gxfRmzXb/jnEAYuC2RVUR/VaXvaqHvfaMBbib7/mtnFdeyq+AE2akFSibR2JkTMY0WFi0qZPMpFkk8xG7XCBve3CRByCGXGIVW5KFDnsowx1bXRicnqcIwXLAd8y/VooJpqrX4VHxkth3hZ47382ahODf9OInWqnDVXzIzFayD5nZPC8XVvttzHAsoVmhpGhB4fAANZasXbjWAlnCzY30h/vpeNq6d92xE5A6pB91Kje01xi0iknKhFS7rCCMp86W2XDGegiDCTUDPzfMRqmfH5rqZKVp9/YFtJQeJEJL10HhXbFSFikW+JciEmRKAMu4Lzs4rW07j+ze5jsqTn5CZVYF3Gmd2I5aouSdZAtyDgq4DdzgnrDVJz18ZAueOydykJueLc5otYCe8Kefa3ZJ4Xn7C0880SbFeZMcUBOtzWzHyzHBMYk6D6I/V50l5Bk8/N4hZe7kwWZSskuey2RhVhwCHfq0U6FVBE1nRs8VQP9eKqHO590TETsa+rCFMBFGXryIMU917g5GxF2s2CLwHqIwKNRyj2WfCXcDuaE+gfala8MrnlrH1yGg=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199018)(46966006)(40470700004)(36840700001)(478600001)(186003)(47076005)(426003)(26005)(336012)(40460700003)(16526019)(316002)(83380400001)(16576012)(54906003)(2616005)(66899018)(53546011)(31686004)(110136005)(70586007)(70206006)(4326008)(41300700001)(7636003)(5660300002)(36860700001)(8936002)(82740400003)(8676002)(31696002)(356005)(86362001)(40480700001)(82310400005)(36756003)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 02:10:35.9029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5328e3d9-d4db-4f26-e3c7-08db0b0bff6e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7359
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/9/23 17:54, John Hubbard wrote:
> On 2/9/23 04:31, Jan Kara wrote:
>> When a folio is pinned, there is no point in trying to write it during
>> memory cleaning writeback. We cannot reclaim the folio until it is
>> unpinned anyway and we cannot even be sure the folio is really clean.
>> On top of that writeback of such folio may be problematic as the data
>> can change while the writeback is running thus causing checksum or
>> DIF/DIX failures. So just don't bother doing memory cleaning writeback
>> for pinned folios.
>>
>> Signed-off-by: Jan Kara <jack@suse.cz>
>> ---
>>   fs/9p/vfs_addr.c            |  2 +-
>>   fs/afs/file.c               |  2 +-
>>   fs/afs/write.c              |  6 +++---
>>   fs/btrfs/extent_io.c        | 14 +++++++-------
>>   fs/btrfs/free-space-cache.c |  2 +-
>>   fs/btrfs/inode.c            |  2 +-
>>   fs/btrfs/subpage.c          |  2 +-
> 

Oh, and one more fix, below, is required in order to build with my local
test config. Assuming that it is reasonable to deal with pinned pages
here, which I think it is:

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index 9c759df700ca..c3279fb0edc8 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -313,7 +313,7 @@ void __shmem_writeback(size_t size, struct address_space *mapping)
  		if (!page)
  			continue;
  
-		if (!page_mapped(page) && clear_page_dirty_for_io(page)) {
+		if (!page_mapped(page) && clear_page_dirty_for_io(&wbc, page)) {
  			int ret;
  
  			SetPageReclaim(page);

thanks,
-- 
John Hubbard
NVIDIA
