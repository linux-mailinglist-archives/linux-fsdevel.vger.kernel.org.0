Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227A976779A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 23:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjG1Vc2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 17:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjG1Vc0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 17:32:26 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AE13AB4;
        Fri, 28 Jul 2023 14:32:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXy5uj0BckxNvfLabk+icdzPsDG56Rr5e9uC3SvgOwD/c7cR6zhPyrO8CKg6hhrPt6w/oo1SD5gi1aUjNCn/AlrS6M2oaWEWvbX2aOjg5Cqh/48Hpa5T9+904+VOZv7ReMLZG6UcNVliJYBsgLEs/QdIwhGBldT4QeKmrtrT+O3D5fArXlBc4FXCdigWJb6n2WWUKzuJX7k0VUaplTULarcRCrzfSDUk4oHiaTtW/2BxaW2kS2jYdOWXFHtfCeteJRWCIMLgsWv6Q+K9c7wZ5stKLkPXtT0zeG9JlXorZla0O6FKFWRSIG39uxvBwsKujLVOTUO4KOFENFOrYiVJxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JbgucUtFLpHI6+tgIMTnQ+fGuz4wcImjGzs5Co5dUw=;
 b=Q6eYSiEm16gMZolknn7XupAJNYw1bBZl4+HULEMTdIcXyO5bb+UJk/qoPsP95z1n47VPzetD7auxQbsxpVGm6um08UuePJDa3X/+KtBHaRShHp0O7MCBNze8ETFMO3bafQKsOx09XSAF/Pgvj6frw2hRyVstsXOmW/q5JQrbWiRH4a3ilsmXGIjYqOfnYD/SyPf1NkE+O9ZWnWhCzUDr1MCSSDFiZfCnfRtNTy07m3bRph/f2yuaEukEeHUAUZE3koI+4hte5vmDSSlf/v/Q1wBtyBQAz72oPHmDKb27XWmvxn2DB5184odI4wvucBT8nbhXUucxYDpYaGAhjPsJEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JbgucUtFLpHI6+tgIMTnQ+fGuz4wcImjGzs5Co5dUw=;
 b=SYtpeCc/zDbslIOSE5SD7aBdd3f33idyBGf7hNblbekZQppapT2CkApKBlL7txnIDGLfj78s9QMxW4Ruw/GeSUtz2Wf7CvBcnFDuxp3siId5kC7m8nW6qnhRmYUG7jmv9IUB+wsHRFSuNRdVIK8BFBNlsSGM9yAz3jMxaNJVx9NOoRE++M3/G76385H9Ah/t8LNTaHvp2H+TO8fAmHhKs75WAf9pmIk0j2ue4qWPe3nSLkVx+NTkwLkD/6MRgkEVZORLJnxHdv8XJdSyDaIxDq0q8zoYMy+GV7brzfMP6v7BjbIIfaEU1Xc5m03iosR7+fohOvxhq1KGZcU2k7wRCw==
Received: from MW4P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::15)
 by DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 21:32:23 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:8b:cafe::73) by MW4P221CA0010.outlook.office365.com
 (2603:10b6:303:8b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 21:32:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.5 via Frontend Transport; Fri, 28 Jul 2023 21:32:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 28 Jul 2023
 14:32:14 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 28 Jul
 2023 14:32:13 -0700
Message-ID: <edd9b468-2d60-1df7-a515-22475fd94fe2@nvidia.com>
Date:   Fri, 28 Jul 2023 14:32:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone
 fallout
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Hugh Dickins" <hughd@google.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20230727212845.135673-1-david@redhat.com>
 <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
 <ZMQZfn/hUURmfqWN@x1n>
 <CAHk-=wgRiP_9X0rRdZKT8nhemZGNateMtb366t37d8-x7VRs=g@mail.gmail.com>
 <e74b735e-56c8-8e62-976f-f448f7d4370c@redhat.com>
 <CAHk-=wgG1kfPR6vtA2W8DMFOSSVMOhKz1_w5bwUn4_QxyYHnTA@mail.gmail.com>
 <69a5f457-63b6-2d4f-e5c0-4b3de1e6c9f1@redhat.com> <ZMQxNzDcYTQRjWNh@x1n>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZMQxNzDcYTQRjWNh@x1n>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|DS7PR12MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e791ca-62cd-4e04-515e-08db8fb221c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0e373dXPtfdF4p8TldnGB5hARgb7fx+mFuKiGlfuhbSUaHpLGqmNb4BTFhl+aCgnq+v6haBT0luN7KXa8VyA1ChRC+n74iocXjM84/FBMjCMi5+Lbr91ftA4B2vBb8CqbzxT0sMgAq/tmljMCyeg50eDAFSpDkwtvWxU+peeK4YmI/NuFaiR0GRy++20waUqX1uC58e0a3Cf9kUb43/C/w6U7WOB5BQZggFF9JYrUvSEHMBP1JoFp+Guf20vfFn7XiJPNO3BAZ/HhZ/Kf0gpNME4JeWNzz7cGtxb+TDRpwRSpPPQ/nPI2zPvtlRhfZvWEUtE1AfoINZDIf89zXIkXm5eg/h7rdWbR+8bGaFxYKJE0UHP1oXpWF1MWMWnNq9v/M9t8wSvPbUnIxGA8II6f4ZjD09/HzLwwC3/ZUMhZtO+3zmC0TlWFHt+YR3ojv21GwMOu0AfnTW0edHGKFgKWwzqOX5PfgMO3s4qrY98lZf5z3rxXCrWs6m4Lo0V8vmZXHr4D0XqQUN5V3tXZYEUDc4OVLX08Oip2I9HcJAoD8R35SiueYl/Z3PBx8/14WxcFc/bHN55jU38dSAE8pWfsTy7emzc9KKosC6wSz2ovXe7U967mwse5ogQub+krt1XFEE2ULYapJB9eilso7CaZ6rpCa3IXoaeSYD9CgWSq9BzMqq45kg2sHg3yDEWMv+dPXRnlveXj3WqbsoZcYS+h3os5sQnyHcDwxu+PJxeycOG8hcYFPAmyv5SLBkCk330fFATCCRFDtIvRYq0tlQ4Hg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(86362001)(7636003)(356005)(31696002)(36756003)(66899021)(31686004)(40460700003)(2906002)(40480700001)(478600001)(110136005)(54906003)(82740400003)(336012)(36860700001)(26005)(186003)(53546011)(2616005)(426003)(47076005)(16526019)(41300700001)(8676002)(316002)(70206006)(16576012)(70586007)(4326008)(83380400001)(7416002)(5660300002)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 21:32:23.4828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e791ca-62cd-4e04-515e-08db8fb221c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/28/23 14:20, Peter Xu wrote:
> On Fri, Jul 28, 2023 at 11:02:46PM +0200, David Hildenbrand wrote:
>> Can we get a simple revert in first (without that FOLL_FORCE special casing
>> and ideally with a better name) to handle stable backports, and I'll
>> follow-up with more documentation and letting GUP callers pass in that flag
>> instead?
>>
>> That would help a lot. Then we also have more time to let that "move it to
>> GUP callers" mature a bit in -next, to see if we find any surprises?
> 
> As I raised my concern over the other thread, I still worry numa users can
> be affected by this change. After all, numa isn't so uncommon to me, at
> least fedora / rhel as CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y. I highly
> suspect that's also true to major distros.  Meanwhile all kernel modules
> use gup..
> 
> I'd say we can go ahead and try if we want, but I really don't know why
> that helps in any form to move it to the callers.. with the risk of
> breaking someone.

It's worth the trouble, in order to clear up this historical mess. It's
helping *future* callers of the API, and future maintenance efforts. Yes
there is some risk, but it seems very manageable.

The story of how FOLL_NUMA and FOLL_FORCE became entangled was enlightening,
by the way, and now that I've read it I don't want to go back. :)


thanks,
-- 
John Hubbard
NVIDIA

