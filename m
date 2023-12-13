Return-Path: <linux-fsdevel+bounces-5784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2443D810805
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 03:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBDEB28245F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 02:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EFC15A4;
	Wed, 13 Dec 2023 02:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eq64ppOC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3F7BC;
	Tue, 12 Dec 2023 18:14:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJ9f/44iY1+3MO/EoIviRDVp+wkgBpRat4LKnSrSwalOHX2phV7q236Ypn6Pgig6GFNy3hKkh9Lk92/MJ47nYgUhx+f/PuH+Qhdur1sXy8DOshBHhmtrtYgCCNHV01+/AY/tMx3Piwn1/+1UqQDkU7B+JMlQg40AxXCqNS9blgYFTczVxMX75twv8ZRlhRSVlZdaZ+WKRkwN6/tu4+Gt1JcupL5I6icq9CZNKIAwDpK3LCZpnvqNjJ+XnQ/Hq0qFHqIH4RHORJ7bR6DqaWNiwtLuWyVn1JY/EG6/WQyHF5ODGBE/uy3PBJ+ADS5cuejh52aq4ccccijptNZbpjSS8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEUAR/R1eD2OTQSMPCku3hB7cBIZxPvwyTh8bjt5XmM=;
 b=OWwzpDCbN+69t6cwmmdZ8iYTQuVJrHLW/Wos3/uuKeuGcnKXHXt4GER6Ukze48orF2oehx5Bgv8i7/icjDzUx1wO+TAmv4VoItykvEtruzGqpddzn4l4qKkXNLiUX5RPqysioZYUOvCEJKSy3J67dOX6G9ZGbVG8Dd4hMWPigcQ4rHgObp3tRQLUEdsiqf36O1bEgtuZjYUtevg4euzR0tCD9G2M/TkzNnjqCsEW3a5CArQw+1wUIKTJ88hXMGJt4HZNWr0Qn6WAoE7SQZAXqxVOsajPYar7O93nJcq6w3LGHC5vDlMu1HJDDbOYrin6lDNtRT515Aea6+ZGTj9Ymw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEUAR/R1eD2OTQSMPCku3hB7cBIZxPvwyTh8bjt5XmM=;
 b=eq64ppOC95QzON0WOKLYvB3sYOKHR+XsvGPcqG8pNkxtEsw82wdDstHtGPcTrgdWUNX82cDgLKpeuYYcuzgaMRTqLwh4eY0m5fbmjBFvWu75i0EqMsVA5yE6m1Pgwi7E73T4HTlcAX1Wpe7O8RjB0jZEP1uX07HJ3+xL6OPuYx+oJDkHb+wfwsgDlHHsF/e4b+zGgDZA/KSiPMIj+MbbILsXvdYDS0cZ4e4w37hnr79u4wtLgeLJAuPvpW4ly+6N73DmyD3RwWcRg/Lt6mVIulGIGU3KP5T3+KxACne2b4L49Qax9yaON9oZ9YadEP3rr64PT0HgcyEt/uOYslb2aw==
Received: from CH2PR07CA0034.namprd07.prod.outlook.com (2603:10b6:610:20::47)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 02:14:30 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:20:cafe::ff) by CH2PR07CA0034.outlook.office365.com
 (2603:10b6:610:20::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Wed, 13 Dec 2023 02:14:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 02:14:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 12 Dec
 2023 18:14:13 -0800
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 12 Dec
 2023 18:14:12 -0800
Message-ID: <f1b0b80a-1cc6-48c4-8a53-0222b3e59c7f@nvidia.com>
Date: Tue, 12 Dec 2023 18:14:12 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
CC: David Hildenbrand <david@redhat.com>, Suren Baghdasaryan
	<surenb@google.com>, <akpm@linux-foundation.org>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <shuah@kernel.org>, <aarcange@redhat.com>,
	<lokeshgidra@google.com>, <peterx@redhat.com>, <ryan.roberts@arm.com>,
	<hughd@google.com>, <mhocko@suse.com>, <axelrasmussen@google.com>,
	<rppt@kernel.org>, <willy@infradead.org>, <Liam.Howlett@oracle.com>,
	<jannh@google.com>, <zhangpeng362@huawei.com>, <bgeffon@google.com>,
	<kaleshsingh@google.com>, <ngeoffray@google.com>, <jdduke@google.com>,
	<linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<kernel-team@android.com>, Peter Zijlstra <peterz@infradead.org>, "Muhammad
 Usama Anjum" <usama.anjum@collabora.com>
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
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <0f97db9c-5b86-4f56-8463-2520fe79f709@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: 54919fed-33f2-4c68-3146-08dbfb813d57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b0ffl4x29HzecnMRawxjLlfI3HUHJVvQQzi+2saXku2HYc7DkNGtMd4dQHPsVSEY2rCbE2uOZMryP+BGuRK1Yt3jcRRg+QpiBmYdJPPjQOHVTMdE5ki10hUFOk2nWKPSmdP1TYLPRLRHCKsA94rqkLgnZiRdCcgUsCjkgShvWxK4ttWQpO4zINBwmL0dR2d05fneW4rfC6pStrgNm3hJSfREN4F1SD7NbGEXn2KcvuhP1fnTxIdfxUZ6OaPFHTZ0ZwFI0y4EUhS6/+nD7uSJFmHh5PGzEYCnkWJixMZFAJZHfj3BBc4D+sgA1VUPfi82pasZvG6aILNAnNj27j/aQDxOXpTJSejegKd6mhN1krdcVIYVjCX5ImfMU9SsiveG8go+BkQYKowTY79zMAp8GWk0QauIQ2tw5unDKg+9VcXHw8kAEdnASYTQrbpaRPG3C91Smt1ln/Nl2s+AFA26h6l9gaPtDngiie3DO97XIYBNR1rqS/3FG2zLseMV4ulsydjIbnkpkhSSL8J8QspBGUmKI73uP94g0+9WsqsTYqxkewoX7cqLKHAPjY1n/3w4henNcjlLf2PpX9mLFPtktWld+3OW9u2RBHWlXDdq4xaZMAHCfJcGWbTbfRyNeRrcL0HPyfEoLYT3NaiSPDbp1zGADReMQ6yvfglODsgS1gBLNBpSgA4s+tyUFxssNswz/pIRmlaJRC56VUMmcb3+upr80wyaJY48BAaQwoRrZhGzXeZlHeJoawjwv0IR9FLYighZmJ7ySDT2bf3nGzb5dA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799012)(36840700001)(46966006)(40470700004)(53546011)(31686004)(36756003)(478600001)(2616005)(70586007)(70206006)(26005)(16526019)(54906003)(6916009)(316002)(16576012)(336012)(426003)(40480700001)(36860700001)(47076005)(4326008)(8936002)(8676002)(2906002)(40460700003)(7636003)(5660300002)(7416002)(7406005)(82740400003)(356005)(41300700001)(86362001)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 02:14:30.0283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54919fed-33f2-4c68-3146-08dbfb813d57
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224

On 12/12/23 07:12, Mark Brown wrote:
> On Mon, Dec 11, 2023 at 12:29:58PM -0800, John Hubbard wrote:
>> On 12/11/23 12:21, Mark Brown wrote:
...
>> Or maybe there is an innovative way to do all of this, that we have
>> yet to think of.
> 
> We do copy files into tools/include at random times which makes sense
> for things that aren't uapi, and we are putting bits of uapi there
> already so we could just expand the set of files copied there.  AFAICT
> the only reason we're copying the uapi files at all is that they're
> directly in the same include/ directories as everything else and are
> always referenced with their uapi/ prefix.

Oh, this sounds like it would work nicely. No more "make headers"
required (hooray!). Instead, the new approach would be "selftests are
allowed to include from tools/include", and then we can just start
copying the files that we need to that location, and gradually fix up
all the selftests.

I really like this, at first reading anyway.

Muhammad, Shuah, others, what do you think?

+Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>


thanks,
-- 
John Hubbard
NVIDIA


