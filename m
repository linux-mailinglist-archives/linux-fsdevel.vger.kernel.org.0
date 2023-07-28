Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA2E767847
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jul 2023 00:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjG1WA0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 18:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjG1WAZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 18:00:25 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D52DC;
        Fri, 28 Jul 2023 15:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfCR2+zQDxUNjERtmkFX5Y/1Gu/kqHV36/CJZ/p4B49HH1QAiCQU8DhlPoDjSbSW7FwpzNO5N/dZKkTS2Ki35vBGcstdg4B4Xo508bdlphV2CNahvl/ZlqEU/99lcMv108jyBFYfylBIqjb6tcky4G9ka1sE5n7blptnZFEABrtd5PNINpWEeoVQXOcXoqhVwk9xkjNLgaV10HOPmcCJ3EEKO8FQ/ZwZZstNaRCZ3rGiOnqng9yK7eGXaSH+CISE35SLboeHINdM9E0ZDqkpCOQvhWVw3d+g3MSxygUHrkZPVt4AtBCmKFxnHgOIlYY4W8Gp5/+Wynoi3cSB5nu40w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/2EoH2+Qr2sFLFCf42LTOLIG7hZWQHUXQLRlN766Mc=;
 b=R8zrLg7eZSTTbnNZKsHgMpe4w6NDfrJT+pcG1pLx0BpUS9KHMlqPel11VYRmyqgLg4iEzFOjngOlpCAxF0Ccym+x5MHuuE0nyja2AXSbeoGycUlKF0OVGC9cKN+t0d2wG/RxxpguschJloHHN++ne7hfInS0I1ZznmZ27Fe+bjDoxKm5CD/WK0hQEJjRuLkHYXjvxyKD7E+cG6I+DRBAv0BpS08ja0tCsd70VCI+5FP9vzd3fg7fNDOpBbXBZY4GObtvC1IvgAtqdM9zIbzBkns+OjvQ4aM4ih12SrPjp7VuAgVwGP/Gxn3fsi/xvzMvLwUHwKC10Gy9hnLNaKbHcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/2EoH2+Qr2sFLFCf42LTOLIG7hZWQHUXQLRlN766Mc=;
 b=BIjsPEmqpTeqhF7m3yHweJmUl8lZ/87a5gl79lpZ0SwJQdnFlL9XQM7KZgq/jDWPMRyDhuiHCkF2uNHEC2pd10mBYi+UH5/9TaQzIlQDJ6miktGYBX7rLUeqqYvow0yczvR1H6YqcSZnSGt9PxfEVbmOT8nW0zNrwz60jr2qSeQ5X6CZRYBKUvsLHpAYVfZO3vDlrQn/Tb07u6vMuDio5ARCPgseyu2qAu+ks5Dg/nuoBsNEX/Vg4nLXYcwipi1FI9Qp3Zb1mdnILoWMWss6B1TsN4iX6LC9s5Bc99i4XYDddvcCr2EeDoarykLWIl6Ggt7GNYRi2CmzpUXdW81Dkw==
Received: from BYAPR05CA0008.namprd05.prod.outlook.com (2603:10b6:a03:c0::21)
 by PH0PR12MB7958.namprd12.prod.outlook.com (2603:10b6:510:285::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 22:00:20 +0000
Received: from DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:c0:cafe::b0) by BYAPR05CA0008.outlook.office365.com
 (2603:10b6:a03:c0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.12 via Frontend
 Transport; Fri, 28 Jul 2023 22:00:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT073.mail.protection.outlook.com (10.13.173.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.35 via Frontend Transport; Fri, 28 Jul 2023 22:00:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 28 Jul 2023
 15:00:06 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 28 Jul
 2023 15:00:05 -0700
Message-ID: <118e571c-a79f-5020-b9fd-4c0a3722236d@nvidia.com>
Date:   Fri, 28 Jul 2023 15:00:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone
 fallout
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
CC:     David Hildenbrand <david@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20230727212845.135673-1-david@redhat.com>
 <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
 <ZMQZfn/hUURmfqWN@x1n>
 <CAHk-=wgRiP_9X0rRdZKT8nhemZGNateMtb366t37d8-x7VRs=g@mail.gmail.com>
 <e74b735e-56c8-8e62-976f-f448f7d4370c@redhat.com>
 <CAHk-=wgG1kfPR6vtA2W8DMFOSSVMOhKz1_w5bwUn4_QxyYHnTA@mail.gmail.com>
 <69a5f457-63b6-2d4f-e5c0-4b3de1e6c9f1@redhat.com> <ZMQxNzDcYTQRjWNh@x1n>
 <edd9b468-2d60-1df7-a515-22475fd94fe2@nvidia.com> <ZMQ32RRJlW/aDYAE@x1n>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZMQ32RRJlW/aDYAE@x1n>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT073:EE_|PH0PR12MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: e7b43cf1-eac2-47ea-9fd7-08db8fb608ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rmfw6FVXeorqXSwCIYI5wBxScMmz9huFWA0BZA8C6D3I6Vx09oriOM6HvWCs4uRsXJuN3P2BGsvx2Q95vZJFbkwrUDTK/99zljnS7ouwPp3aF2zVS2ZnnO4pJ+q/ytkyOQRSgteG33ffCsZnU6MaaJFnwMARbdPK4aPthoF2xgVjkSzTJgJixQfOR6ucbSU/hNj9gmPQESfrwT9hSn1QXWAWBSMGde1PNH32/MndWBqtYznYxRNgHsfNFwvCyBMpzXdtGaI0zEikGF2oOQ8BLSFfl/R2eHQqDGhWMRyG+uG7N0zvIl8rBPRbFtqx+oUTU7SgoFmrxjzh2K/secKYvpf7fbeyXAOXvCbunJR6jG/J9gP3Rhft8P+fy0Z41Qy90xKe4EXtU5uXDt5H1GWkU0IZXnAP/MsmUh2izLexwlwvsuAWWVwz0IcrtjwLCmrYqMdouYVZl56x1PDNdKBeciCOLj9BHSuuv0Cdzhlbv1qGNQtpwTgGXndkuH86Rlp0a6ulzXMWNtdq0agEglKmnH5VouPKtqIr9GaJc+4TL5vSFGBLgO2FuAv/CUV/ycqg9BGUIdpeg3PKxfXC2zSaHAB7xuptud08d6SwYCVUKOPDUzzz9ZsuOQYSpR6Pi/ly0I5vr27neZIJHfz0ByXzqeEVM7pkj/ifOriEi+w4lp7MpegY2/RwAcPCwkDfNNtFK73bREzMz7LQ5L5WRG/lyHxx3s1OYZ1GaK47vhfOCKNcMC+TnP+3x6kwvbXPr4kfz9617L70qWL7/UFy5nMmmA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(26005)(7636003)(356005)(54906003)(82740400003)(478600001)(53546011)(186003)(16526019)(336012)(426003)(47076005)(70586007)(4326008)(6916009)(2616005)(31686004)(36860700001)(70206006)(40460700003)(4744005)(5660300002)(7416002)(41300700001)(16576012)(316002)(2906002)(8936002)(8676002)(40480700001)(86362001)(31696002)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 22:00:19.5811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b43cf1-eac2-47ea-9fd7-08db8fb608ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7958
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/28/23 14:49, Peter Xu wrote:
>> The story of how FOLL_NUMA and FOLL_FORCE became entangled was enlightening,
>> by the way, and now that I've read it I don't want to go back. :)
> 
> Yeah I fully agree we should hopefully remove the NUMA / FORCE
> tangling.. even if we want to revert back to the FOLL_NUMA flag we may want
> to not revive that specific part.  I had a feeling that we're all on the
> same page there.
> 

Yes, I think so. :)

> It's more about the further step to make FOLL_NUMA opt-in for GUP.

Let's say "FOLL_HONOR_NUMA_FAULT" for this next discussion, but yes. So
given that our API allows passing in FOLL_ flags, I don't understand the
objection to letting different callers pass in, or not pass in, that
flag.

It's the perfect way to clean up the whole thing. As Linus suggested
slightly earlier here, there can be a comment at the call site,
explaining why KVM needs FOLL_HONOR_NUMA_FAULT, and you're good, right?


thanks,
-- 
John Hubbard
NVIDIA

