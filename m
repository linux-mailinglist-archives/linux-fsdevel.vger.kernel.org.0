Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7BE67D8C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 23:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjAZWtl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 17:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbjAZWtj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:49:39 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFAF577C4;
        Thu, 26 Jan 2023 14:49:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJ7JvpXsrwFjOt9+HpB6z9eH79sGY+0+PSzMcrTEcowNzgrWNuCj6C8ouyKqFJg5uGu8GjgYZRNpMIeOsZpcSXSYbanKZa412L1NQX35QMccyUrkwdv+ewLIctL1aiEA3V0DdR/CHL303cJgcHckG5wEi+cOcGBq53DsG1OYpQyMc40bdbr11lHQUSVxg2cKmE1NtoEF/XTtNN6vPDDfoZxnlFNWnNTnNpnZIh95jvSTthY0DOEVeEfo2O4mHqC4DMeuk9i0hmzz1Nn7rQjy7eVsKznyLbocXych8sk6UiJGfU2qBGPj81khNGhPQSrdHtFVTb9NWzVI2JyF5WAHVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72MlngrVJhO8vi22N2nyiNPWPhFojC+8hVnkjp9yON4=;
 b=EUoX8164jG5JoMsrzktbsbI5rSeQTWC1pIixo4tJ/7CCRsvQ2BLx2KXW3DPG/fG0dbbsO4nAmu1yhKgmX76h04B5F0+FDgc7g7lTzorLtq+AdmvgUKeUHOtfTT5B5rVupSRcXjyUDD4mz/zKHtpLu1G7vt1RoWXf9L9iaDtJwNZp/VGVWsFl+b6Qc80G8iM+u8DCezUGHnYgcXfy/B9SCpf1l0Y35p30JIGUzteMjY9B6YpaZLE4bW70bXkp5IYxBYKiKjUGLUUp46oN0YAF66qkWigBYqYoFKyy4/SNSCPl18saAFzG6SOztheq2imAdSceb/ms7MmUuS/5s+pbGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=zeniv.linux.org.uk
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72MlngrVJhO8vi22N2nyiNPWPhFojC+8hVnkjp9yON4=;
 b=RtyK/11kkuP1qrdWTvco3wocOCGASsIKXoDnEJQMN1xKj1kh10Am1CcGbHDB6Y7DMAer813Sfr/6+0cMi2y+6bF9oDLpjZ4dZA+7gOb+mkRGuZ0IsOMcKFkq2qRm7BXjzMfGibdVxFEaRIxW1Cf1fIQe2nGp03CVU9zUzr44syAshLOtYilBrb+e4glmIioSir4HSw6Kjifusu3bHcNzYu2en4iIcFYl+FwpCHYk1HH75EAcCZaSIexlQE+5gOg1no/go3N7kQ93GdjYep2qKtJefvIukfiA/bwO4HIh45wCtsZSW4mL12it3ApLpDuiH1YPk3lOvKDuNsvB18lJIw==
Received: from DM6PR13CA0032.namprd13.prod.outlook.com (2603:10b6:5:bc::45) by
 CY5PR12MB6370.namprd12.prod.outlook.com (2603:10b6:930:20::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.22; Thu, 26 Jan 2023 22:49:27 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::f4) by DM6PR13CA0032.outlook.office365.com
 (2603:10b6:5:bc::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22 via Frontend
 Transport; Thu, 26 Jan 2023 22:49:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.22 via Frontend Transport; Thu, 26 Jan 2023 22:49:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 26 Jan
 2023 14:49:18 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 26 Jan
 2023 14:49:18 -0800
Message-ID: <bf3edf11-02d1-128c-ebc0-11bb38404ac9@nvidia.com>
Date:   Thu, 26 Jan 2023 14:49:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v11 2/8] iov_iter: Add a function to extract a page list
 from an iterator
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Christoph Hellwig <hch@lst.de>
References: <20230126141626.2809643-1-dhowells@redhat.com>
 <20230126141626.2809643-3-dhowells@redhat.com> <Y9L3yA+B1rrnrGK8@ZenIV>
 <Y9MAbYt6DIRFm954@ZenIV>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Y9MAbYt6DIRFm954@ZenIV>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT009:EE_|CY5PR12MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f665809-61e2-4588-6374-08daffef9443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0lRFA3zuBlsjKiFn7am25PoK9oeD/TkumaWRLlZ/ZksQmzgLeaWf/Kp8NcfiPaYbLuw17OoVqQYtJResbHDIaVQzDppOX1k/rc8VlvknSNrxltv3VWDIBaUypDJlifR4DMKFhxLXAHIk9/eM1Zwrb50X7WYdxGNXxwM1pk75+sMu1fScuIwfRWNmkqH09ClgwEXjj2ErpJuMEjaD+16sLfdjCkqvtEVOK2C/vChR89d2mey1yJ0Rsw5LJPQUTHy1/y2QvEZUHDomD1vw9pZavZET6g+wCVO61jk5IGCMksPt182lc4sgTP+csfZaX7xiGsB101WhQ/0IL6/y+fgN5RjdmoaaH4bPDOpW3uEiAa6PtuF8P69IfMwEUknb7FaH0x178nbg40PdEzqdtC33W1uKBMoYCywarGVxQWZAfqzjWEGYIncZTRlBZJtwhAYDEEtT5NFZTsmNGytLve1Xa+RdsLBitSwjRhgo5IsOm4coRAnNiF4Hoa7ywACD/jhltboSJ4hkOCKutocSNCf9PCWe8XGMjuTC3C9cpttChKSr6kGTo+l2OFVjScDIfPhkQtW8FHm6v1kYl5fnHbvwWtGLAOL2KvcSkbn9hrE+LH7ep4wcBX2wmN1+z6NBSzFjTR1hZuJl3KVW0wXCb/0e9WWZ9XkHLTrGWSV2UUCsHCcIJzVGAkLIMquzxEZXWUxnmkIgvKfS3RwJaJXKsD5T1cXio55BDRoC3w8C4NlbdBobO4kIXMTqsCT54Q0mBKG9u4pPnpxBQPOIfdOlBz80jKaQjyKhGVItd1hf28pbsK6k4wMJmu8OrYGe3qtfV1/t
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(16526019)(186003)(31686004)(26005)(478600001)(966005)(47076005)(336012)(2616005)(82310400005)(426003)(83380400001)(316002)(54906003)(41300700001)(8676002)(7636003)(356005)(70206006)(53546011)(82740400003)(16576012)(110136005)(86362001)(36756003)(5660300002)(40460700003)(7416002)(8936002)(4326008)(70586007)(31696002)(40480700001)(2906002)(36860700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 22:49:27.4651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f665809-61e2-4588-6374-08daffef9443
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6370
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/26/23 14:36, Al Viro wrote:
...
>>> +static inline bool iov_iter_extract_will_pin(const struct iov_iter *iter)
>>> +{
>>> +	return user_backed_iter(iter);
>>> +}
>>> +
>>
>> Wait a sec; why would we want a pin for pages we won't be modifying?
>> A reference - sure, but...
> 
> After having looked through the earlier iterations of the patchset -
> sorry, but that won't fly for (at least) vmsplice().  There we can't
> pin those suckers; thankfully, we don't need to - they are used only
> for fetches, so FOLL_GET is sufficient.  With your "we'll just pin them,
> source or destination" you won't be able to convert at least that
> call of iov_iter_get_pages2().  And there might be other similar cases;
> I won't swear there's more, but ISTR running into more than one of
> the "pin won't be OK here, but fortunately it's a data source" places.

Assuming that "page is a data source" means that we are writing out from
the page to a block device (so, a WRITE operation, which of course
actually *reads* from the page), then...

...one thing I'm worried about now is whether Jan's original problem
report [1] can be fixed, because that involves page writeback. And it
seems like we need to mark the pages involved as "maybe dma-pinned" via
FOLL_PIN pins, in order to solve it.

Or am I missing a key point (I hope)?


[1] https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz/T/#u

thanks,
-- 
John Hubbard
NVIDIA
