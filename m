Return-Path: <linux-fsdevel+bounces-6005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B94812127
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 23:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF5D6B21268
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 22:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9094A7FBCE;
	Wed, 13 Dec 2023 22:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mv8wyd2n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD7FAD;
	Wed, 13 Dec 2023 14:01:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJZU1ii1KJNOq6jLsPoAgd5VhdnhDglDJAo2lKljk/vZe1kB4VC0voNKgjQgABV5a4RaT5y/Oqzwgye6qQkuQRG4nMHxuOL7RFXRwhfixT986lVqaRBT0ED1SrjNQJYou7VBh0NBYHngRyvyzNZB0X8GRFWAvP91anFM9qZvR4nhKP/HU8k2iQmKAxPG+IikLYkG/k+UjFkAwHUXbaQ1PtPXa3qJN34ArpUDBjwsE475uHvV4AMJWceNqMRZx25wE77U9d/zvWXCTPXqcpgySKuERz/TyYzqL0TyHiwams+TEXEPxgImN1SGBHpBBpwwaHHFuTXNWcGs0svstk4ftQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/Ge0+N9rTWmHtwBtuVyIKn8PRq0Riq9nfTF9633LdQ=;
 b=GlBtOH7LHg4FkrItrqGuQXnTaSK5p2qEgjZMFUjPms7e79HU42+jnMXdvzCOXZmQaWS/qnUb9Ip1NuEa4lsgUmZH5UnPkUanAR5eGDHG82pDpJylkXl3BGKGc/RLAOgEpIDDgNuj+L76k/ZkAS7AtaTPvwjgPXG4jFlljZZRWc8w2jFSP1gK/vD7f1bFbNwev4On6MdWtap5u35iaVcxkvad1626FcqOf6AK0aWoHBj7cKFWGh+mOCFQPCnLT4Acg6weF42SNtfG8SoXf1VHFVlwqD3HxMhYcYJpG7F3/0Pw+UlgEAT+EfvMbipUxs0yxmKK+ogRasQISAUMWUWPQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/Ge0+N9rTWmHtwBtuVyIKn8PRq0Riq9nfTF9633LdQ=;
 b=mv8wyd2nOKP0gSlZpNlLIIVGdopIyPRvvs89+npq3oKO6M2moWtQk5MEU7wByxORMU1vg9q9vI6RmoezJBBa3LX48VZs6yHM1aljaHr53muzqvxuF/BlkJxRih9s1Wta6thEwkxFAnqZgsQ9M69I7CwM3xtIbnGI20SliUzUxQ+VINwWUtRTd3984Ebwnq+MAf3QzLcZeKSnoM/qLAHUx/pmlE7CYZ88phUIDXYB83Pd5mXPX4aQG3+YdjoP/qlvJe98TMHQ3e5Gcs4iC3wSKd43GkNINMLJNYEe6FSh6faRHBHBeHrkQ4oTvKy5vmoZx4s0pr783qtyNCJ9JKELxA==
Received: from MW4PR04CA0213.namprd04.prod.outlook.com (2603:10b6:303:87::8)
 by DM3PR12MB9351.namprd12.prod.outlook.com (2603:10b6:8:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 22:01:54 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:87:cafe::ac) by MW4PR04CA0213.outlook.office365.com
 (2603:10b6:303:87::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 22:01:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.8 via Frontend Transport; Wed, 13 Dec 2023 22:01:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 13 Dec
 2023 14:01:33 -0800
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 13 Dec
 2023 14:01:32 -0800
Message-ID: <ea6708ce-af4a-4f0a-ba37-a2cb38f60eca@nvidia.com>
Date: Wed, 13 Dec 2023 14:01:32 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, Muhammad Usama Anjum
	<usama.anjum@collabora.com>, Mark Brown <broonie@kernel.org>
CC: Suren Baghdasaryan <surenb@google.com>, <akpm@linux-foundation.org>,
	<viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <shuah@kernel.org>,
	<aarcange@redhat.com>, <lokeshgidra@google.com>, <peterx@redhat.com>,
	<ryan.roberts@arm.com>, <hughd@google.com>, <mhocko@suse.com>,
	<axelrasmussen@google.com>, <rppt@kernel.org>, <willy@infradead.org>,
	<Liam.Howlett@oracle.com>, <jannh@google.com>, <zhangpeng362@huawei.com>,
	<bgeffon@google.com>, <kaleshsingh@google.com>, <ngeoffray@google.com>,
	<jdduke@google.com>, <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<kernel-team@android.com>, Peter Zijlstra <peterz@infradead.org>
References: <CAJuCfpFbWeycjvjAFryuugXuiv5ggm=cXG+Y1jfaCD9kJ6KWqQ@mail.gmail.com>
 <CAJuCfpHRYi4S9c+KKQqtE6Faw1e0E0ENMMRE17zXsqv_CftTGw@mail.gmail.com>
 <b93b29e9-c176-4111-ae0e-d4922511f223@sirena.org.uk>
 <50385948-5eb4-47ea-87f8-add4265933d6@redhat.com>
 <6a34b0c9-e084-4928-b239-7af01c8d4479@sirena.org.uk>
 <CAJuCfpEcbcO0d5WPDHMqiEJws9k_5c30pE-J+E_VxO_fpTf_mw@mail.gmail.com>
 <3240f4b5-081b-4075-851a-7d1cd86f4333@redhat.com>
 <3eadd79c-c02a-495f-92c0-0315046ef59f@nvidia.com>
 <3d22f342-280f-4a44-87f4-8cca291cfce7@sirena.org.uk>
 <e3048458-726e-4b98-b2bf-908ea9066959@nvidia.com>
 <0f97db9c-5b86-4f56-8463-2520fe79f709@sirena.org.uk>
 <f1b0b80a-1cc6-48c4-8a53-0222b3e59c7f@nvidia.com>
 <2e4a719b-f2b3-48db-99db-d96040d78b12@collabora.com>
 <0d68fe7f-2a96-467d-87b0-52db36704e1d@nvidia.com>
 <926b42f9-3689-480f-8dd5-78fc0ee6088d@nvidia.com>
 <783a4178-1dec-4e30-989a-5174b8176b09@redhat.com>
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <783a4178-1dec-4e30-989a-5174b8176b09@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|DM3PR12MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: cd084870-346e-4498-b3bb-08dbfc271df3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9kIJFFjYJRvxQAbnRsMHnqjQGP+PZnNrxN3CtKAOUfN7s1z7nbZG+axexb7HL9RgMUgw/ZZ9qBm6gp9/Pu+XBll0UdOSu2ydCymYduhRe6GeZ8zW2Fmn4LVZs5CoiYX3/x8f7vJrJ59eSyo95izRNBCeqzRCok27sFCHLbzWJDRtkwboKmok/uNR11CmJNn8t7PKWrUEsAHcd++mEBF9Qejz1x26jaHXH6kaHeGb0GRwhRynSll4WmCkjOTebjojLwzpNeAAVFMI/LCgd0W471nL3PoL2aOUHITvYlCkroh7vxBJelBqwMb7D1JiwhRB3F9lmQe0lcN9MZ6wTql4/fjmOaSFb8oCMqBr0UBJH0WY0hHHZEPwUAUcXd7ld87nLRizIZIZ5bEGM8pxu0gT5qMFa+UAMYgImLwZJLpphTzy4kMGcTTwIJtPFyueUptDgXrkgVXCiAoxUFq3bPGO4S3hF/5I3JoQXOAoq89jl3wFJtrtS8NlAi1swFpDpXt7t/E64dycvJcJO7KOhoKIsE3sy2ZVFob1ya+Y7Lr2tXn7lQyr4Zso2+Eda0DWvYXxmsVcMK3N1JZ7oZ47VNVJiZzCZ0HbTkA3+NMbQucP9kU/TazjmXYDQBC8s0ViNlqwJI3LXVuz5MNSEPwq1/+4KXFMDTN9+bzryyYMDT0yAF0lPREW6A7u5UQPDccFaaAprq7O2Rp89ieYIlEgJWdxKxBghbnX7qALGOXFkmHX05WLkX4nNyrFyb53q5uuq0LmUDr4j8/lnvlKk7JVRKRMpg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799012)(40470700004)(36840700001)(46966006)(40480700001)(31686004)(426003)(26005)(16526019)(336012)(2616005)(40460700003)(86362001)(7636003)(31696002)(356005)(36756003)(82740400003)(7406005)(83380400001)(5660300002)(8936002)(7416002)(53546011)(47076005)(4326008)(36860700001)(8676002)(110136005)(966005)(70586007)(316002)(16576012)(54906003)(70206006)(2906002)(41300700001)(4744005)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 22:01:53.6991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd084870-346e-4498-b3bb-08dbfc271df3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9351

On 12/13/23 01:59, David Hildenbrand wrote:
...
>> Another variation though, would be to run "make headers", and snapshot
>> some of those files into tools/include.
> 
> ^ this is what I had in mind
> 
> If you're writing a test that needs some new fancy thing, update the relevant header.
> 

OK, and Mark Brown's nearby response [1] supports that, as well.

Thus fortified, I plan on doing the following steps:

Step 1: Do nothing about the revert patch that I sent earlier, thus
allowing it to continue in its journey (so far, Andrew has moved it into
mm-hotfixes-stable branch).

Step 2: Send out a patch for a modest part of selftests/mm, that uses
this latest approach, and see how it fares in reviews.

[1] https://lore.kernel.org/c0aa00a2-38a5-42da-9951-64131d936f7e@sirena.org.uk


thanks,
-- 
John Hubbard
NVIDIA


