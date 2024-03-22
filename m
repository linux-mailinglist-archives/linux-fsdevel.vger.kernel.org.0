Return-Path: <linux-fsdevel+bounces-15039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17390886451
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 01:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA091F22F29
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 00:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3849865C;
	Fri, 22 Mar 2024 00:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="stLqwE4K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6739A48;
	Fri, 22 Mar 2024 00:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711066963; cv=fail; b=bthKSdXuzIrRIA1DUcpjlyFFHBGsoBVizSShrQ3y50UAOB+qomPjx7UY5rGvSwM2aaw9WErEfUmpjolCuPSfaQA1qUKHtJXDEVyiTOzo5+/f4etUwaVO4ufiBRtogr0j2K6xPeNbFcI6cToVbJmh9WhA0bi1ljnuzm+qHnb3cWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711066963; c=relaxed/simple;
	bh=YAwOcLIkBzTT+vyYTdM1oyGG5nhrg/JJEX50CplBY7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T7f6qUTtF/v7SI4D9LOMzGqfrWExPeUdBhryVG4VaWTyvrZGlLFdj7tSmLkNlqV1ItliRa2kckg5KqwlqoJavrqDVw365OiZwWgP7GHfCGBRi5f9VMVMlLExZHbCFcacVE7m455r0FGODkWEq8p+I+nL/8varX+nRX4B3a8rZPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=stLqwE4K; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4lrP2AvXtRGbNJ9TIE6gzHNOVT4mIU4lwsazgNNpRNcqvPl4DRhJW/HRBbnjDbrcoy4Tx5JYaCXgqaDjndskbN2B+mUZPwqLE4FZJGaVLpdova3qM98lt0ofeQBtS798q2rJ6yXeqmlf7M9WeTlniCwUmXpmpmDdO7tQrpLYS+nqr/AD0Uybei9Vj0d83Rfwp/PqFa3unjE5IzbjrllnsHd64gtvR057m5GyvmpuMgTM36bR00pQUaz+i1hUX8YIBoxVVNFS6vEUUjKbmAj7amEnjbYA6xNEPgz5nIb+atIPk+smBX7Aj2jnB6RQCZAUi1az1NJmMOeieIioDItpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gz0UPuhLvCWGxHyr2lQuOW+9/ZwBGcn2nZLNZrTPY3w=;
 b=Pv2l99YxLWsVTkmOY9YDIxsnZVb3p/LiFAw8H239/ikCiU9YK0hkuBeiWg42c589bc5kFPPkZDlpcEKO/V4Q1Br4wQvfC6iTSFajXPjYiEStai3+RJwRpEPUepS9QLv9O+WXRYjSA+s5n8BpvnNIqFUVl+0XKGvSKYNLl7Wzitfa2vfnWKlGuSUfMIujxUPpy1uKY5ho7zUo5sGr4JNeADscuR8I+dy1vwqUB+hIecza1hPPUgsF3M6HW10vpEhtdvVS1BSz+hNfRf0QEl1c+Wndk2gADvAjh1IsVlos008oTMCnld69HBb0Ijm07VSsCNYZInW/qzR4m8S2bb0aWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gz0UPuhLvCWGxHyr2lQuOW+9/ZwBGcn2nZLNZrTPY3w=;
 b=stLqwE4Kvf1/eiVPB1nCSueCo8v6Gtp23Mq5lW06FyV2Fx96Dc0NdiggEKq4UHCDsTMHwEhamoQud/LT0IcU0o6YQJ6pz1mjlzi/zFqfCNz/TRgmdDNz92+GMRH5+fUBCP7nEQJR7zMF9daeAFMijYyN9FpVN/fPqej3tB9HwrUhRNOVKxVohsd7NL3kV/2RS8gKzF/gCpEzL7lkmIstRUFG/t3ftTyEts7MXNmTe09RsudeDBbgY+eQFlT3mExJWf7j/ykhto0lPp9EVc8PAKGlcjgO60i9k3RYFp40tyea2IxfzpHFqcTH2UYaQ27zwzZ8n913NNwX0CpdSDqdsg==
Received: from BL1PR13CA0366.namprd13.prod.outlook.com (2603:10b6:208:2c0::11)
 by DS7PR12MB6359.namprd12.prod.outlook.com (2603:10b6:8:94::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Fri, 22 Mar
 2024 00:22:37 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::17) by BL1PR13CA0366.outlook.office365.com
 (2603:10b6:208:2c0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Fri, 22 Mar 2024 00:22:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 00:22:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 21 Mar
 2024 17:22:13 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 21 Mar
 2024 17:22:12 -0700
Message-ID: <f0b1ca50-dd0c-447e-bf21-6e6cac2d3afb@nvidia.com>
Date: Thu, 21 Mar 2024 17:22:11 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] rust: xarray: Add an abstraction for XArray
Content-Language: en-US
To: Philipp Stanner <pstanner@redhat.com>, Alice Ryhl <aliceryhl@google.com>,
	=?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
CC: Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, "Matthew
 Wilcox" <willy@infradead.org>, <rust-for-linux@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <kernel-dev@igalia.com>
References: <20240309235927.168915-2-mcanal@igalia.com>
 <20240309235927.168915-4-mcanal@igalia.com>
 <CAH5fLgi9uaOOT=fHKWmXT7ETv+Nf6_TVttuWoyMtuYNguCGYtw@mail.gmail.com>
 <c8279ceb44cf430e039a66d67ac2aa1d75e7e285.camel@redhat.com>
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <c8279ceb44cf430e039a66d67ac2aa1d75e7e285.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|DS7PR12MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: 162fe1cb-4ece-4ab1-8be0-08dc4a062d97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ei7LF/APK+6RfgWWljDSoxzG0VPzPftnXmY15kUfCGfFHZpLZ4uakMtNFGq/KFWlFqp3eHF8iL6vg2Jup0sRyU2b0yHFFBJvReil9YK4UmEFf7DUV2z6hJhASV9pqr8Zh1krUOYv3iEpBpN16Yj16EqFPMuXu0CvTjD2uzPamM0Ketx7dXrcKlRZkpgWAma713a0L3N6pmztT2Atjd3elfwZim1Xhm3ziTVL9GxpMb0QyzmmR8ydUOX7OQdvaDgnoPwiPvkITgGhe2BRsnAB3EKbnOx70hcl57KI+d//tUVaslCygYu6uYUvOhLPunLE1Rn9ZKhmC+DPeqJLGyTq56Is/mywlhVModHc9x7NHrWzKZTat0Gni4RmcCD3xuD1R4mVeUJ33zdZarcl4lo2avMQS3lNQuIaOk0vl00ipxV8LAiUtDbbnrQ4yiL8XUZn+2kFMx7ClRHO3huhqcQUm8AC7eGfwEAq1rhWhgp06BrYlpXREwRtx/oeOJd0Un6oGMv2s+IAhTlro3Th91HhmjwGzhAgZlw4MBlJ3BDdxPrW2aybjNmIj/aW+mUHEOWNovRCIYXHHsPT6aJ5MpGAiUtpS9sz+3g/iZDQHCOFg+ICsJWFp5jYigtotzoauXDqkyatpVEqj6jq+nHBC+HSlw4OK0tDdaHHb5PUgEZsRcq1CBdg8AWbREN8Pzr8wWD9zxRaE4tMWLqxlcYHAMsVK2AexSOXGjoqSKLVoBI6GjmgOyc05pBXXzbukb5WUFRN
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(7416005)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 00:22:37.2589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 162fe1cb-4ece-4ab1-8be0-08dc4a062d97
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6359

On 3/19/24 2:32 AM, Philipp Stanner wrote:
...
>>
>>> +        if ret < 0 {
>>> +            Err(Error::from_errno(ret))
>>> +        } else {
>>> +            guard.dismiss();
>>> +            Ok(id as usize)
>>> +        }
>>
>> You could make this easier to read using to_result.
>>
>> to_result(ret)?;
>> guard.dismiss();
>> Ok(id as usize)
> 
> My 2 cents, I'd go for classic kernel style:
> 
> 
> if ret < 0 {
>      return Err(...);
> }
> 
> guard.dismiss();
> Ok(id as usize)
> 

Yes.

As a "standard" C-based kernel person who is trying to move into Rust
for Linux, I hereby invoke my Rust-newbie powers to confirm that the
"clasic kernel style" above goes into my head much faster and easier,
yes. :)

I hope I'm not violating any "this is how Rust idioms must be"
conventions. But if not, then all other things being equal, it is of
course a nice touch to make the code more readable to the rest of the
kernel folks.


thanks,
-- 
John Hubbard
NVIDIA


