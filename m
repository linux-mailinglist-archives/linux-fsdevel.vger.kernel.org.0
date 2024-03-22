Return-Path: <linux-fsdevel+bounces-15044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 023588864D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 02:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E432B20D3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 01:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F11415D1;
	Fri, 22 Mar 2024 01:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vq5JwFE0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BAB10E3;
	Fri, 22 Mar 2024 01:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711071305; cv=fail; b=eSHSSUhbamZ55ncN5oGGrFiYaz79zSapRdxUV6W7Y/xTwbxFt/VKpSCO3O5LCdEiR1CBaUvUoMsgKscN7q4iEP474CEdaCQcSwT7mNVl0Vy0fHpPj5IdEPZeUGPFhFd6Nx5BtVa0HYbgXL2zegnvwisEDuC80HpabBCRvE4leso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711071305; c=relaxed/simple;
	bh=DmxL7o9l1i6Z6l5CIma5/mJwH8WuC+q1HsH5RAs+JjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MsUHYig705NOX5xHUzoZG6pIq5/SN8+mgqzYh1N38aS5vpzKkolykT7qwP1bTvuW74XDDcxZ5w4cbqV1WnycXk0fIWhYcr1eifGS1q1U5MQvqxloTeckgmRjuES1eOr7st/r/px083NIYcJsjvlPjumaozCGnKUbaTp50fmGhNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vq5JwFE0; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bG2M6DF/rgyLCLJ28iNQ/EET5lJmIENvk6jNubUpeBovYJ9Fp3HRTd7eXQmMsUjvmNicCgianE3DqTMMar/gpYK2apYgYPgx5gJikk8nZaiFBvpviYZmtk8WPE3ftfCn7ZOQmqS1diAF9I06QF4CE3CazRy1fJzf7vRYxJVqv1xIMikvwyOUkJZlrHuGIL2ilhDscieBjxmwu14Qxh7dQYDQzoxERhXEgKqIZVNjptRAJpdnS6cg/J29VzhSIqQiibqlM04FrGd5Q9UTohHHYvNhyglH6V9e2mVfxhcunT0ZwkWdptyQBnpgCWzhlUGxam0Ad/PTMStwoL9mAIH6GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Wm8PVzDrlqyLtsSZkAqVEIuy6fEBUFvKPGHNrrJhtI=;
 b=RmWAggTORLbDQIUHqtmAY/jo23K8a8jCvqP9wD7V69xtdI2YauXczaTFJeg15x/fMl/oHdocvLn1d5DBg5TuB/6c6J+KD3HGAzN9/Cnilf1/6XjoV70GVQlNGoxLTAuZU7Tei1OK6nVqMIrDgBS27LA86aI8VM3Q3MzJ+qK96Eo69mMJdT9UOu283YvitVJZ1uvWyKxJiY4zBYpIBLaC0YyBtfnu3/j4TxpJmAOSn1tiy6Dx0fHdOrSMZ/YJTehXqK5akRsqOO0qzygy6tzEa458kyteJ+dq9zukqJHvN284se0aJahMSJ/CvNAo9V0uvgwblLknN8gZXm5hRi6iCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Wm8PVzDrlqyLtsSZkAqVEIuy6fEBUFvKPGHNrrJhtI=;
 b=Vq5JwFE0xgGZkXpoabBVx8AnwcBpw3q88rQ01Rljse8PUvVpeHjw73kjvrFJXTFQf2udGypLObpX2HQlV1PAC6Lry9tw1dniNQuIUZzUgGbubyYwY+0brylDQAa+pkZD+oLOn61SSwLsAYo6a24FTIxdS9g1pFeoiH1oTmEvtVqNnz0IXQvb51DFGSrJ2xHbzdk5iBzF/YeVFyREnwYwAPG/xwFOOa/8b80mQ4xQiA9jFQHolRk7tYK1QPObYRMyugLr7i+4dVwNJzQWvPtN6UFSLO7pi4BmMR9D+bLS0jbHfBzifJbqXfy4pkDYtiuXbyZGoF+0cdEvXnEDw7Erng==
Received: from PH7P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::22)
 by DS0PR12MB8294.namprd12.prod.outlook.com (2603:10b6:8:f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Fri, 22 Mar
 2024 01:35:01 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::5f) by PH7P221CA0005.outlook.office365.com
 (2603:10b6:510:32a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Fri, 22 Mar 2024 01:35:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 01:35:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 21 Mar
 2024 18:34:37 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 21 Mar
 2024 18:34:37 -0700
Message-ID: <d9607a72-2d60-4985-9747-b79011d627d3@nvidia.com>
Date: Thu, 21 Mar 2024 18:34:36 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] rust: xarray: Add an abstraction for XArray
Content-Language: en-US
To: Boqun Feng <boqun.feng@gmail.com>
CC: Philipp Stanner <pstanner@redhat.com>, Alice Ryhl <aliceryhl@google.com>,
	=?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, Asahi Lina
	<lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
	<alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo
	<gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, "Andreas
 Hindborg" <a.hindborg@samsung.com>, Matthew Wilcox <willy@infradead.org>,
	<rust-for-linux@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<kernel-dev@igalia.com>
References: <20240309235927.168915-2-mcanal@igalia.com>
 <20240309235927.168915-4-mcanal@igalia.com>
 <CAH5fLgi9uaOOT=fHKWmXT7ETv+Nf6_TVttuWoyMtuYNguCGYtw@mail.gmail.com>
 <c8279ceb44cf430e039a66d67ac2aa1d75e7e285.camel@redhat.com>
 <f0b1ca50-dd0c-447e-bf21-6e6cac2d3afb@nvidia.com>
 <Zfzc09QY5IWKeeUB@Boquns-Mac-mini.home>
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Zfzc09QY5IWKeeUB@Boquns-Mac-mini.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DS0PR12MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7e6e8a-f9a9-4075-efe1-08dc4a104a8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gUH+FYYCiXs/ThPZLHoctk6p7ag2FhClW9AV1cKSPBo6oMkMMICTqmhH+ILb88en/8y5nSY20rc3ITK1+gjUzsOx8RPvczCVvtpW0oO3uUyYaVK27GLk1IpwqpeNQlJA2Z+lSYMAcGYvZdsbc586OiHcG7ubusjiPLvCH7/nDFewr3eXnqZihG4WY9on3WGqEWm+K3sYL/+xJy3UxM6MLOuQweJ3RiSm2EkASWDqSSnwKPz43/8R0NooMPIoqoRFxp5PKsRAw5U9H8Gulftm93wkIVoiFGRecSgP1QXX3/Z5ARlTEu9XhwZ+5mY/Zjpg1xIbr7nfZGkUzdKQHTR3hpnaA5jGFdKm52QfHfnVJvQZ/RV0tkOAb4oSC5AVkVkDE4yG//MFY3kLZgGQOecwK+Mj+9HlfTucdL+mtfPMwOzu3+ODIlK0mnBBtPUdFTfuuAu9I20WMZ5JenLf/CNgo7q/7erMbxLuM0KuEp4JEOqDxEccnZI4I0UuPaINoHgZMECM8EQ2uzQUMsXlfWJBYK6ZA4ud9GV9NHb761rkcVhiU9QIClH/Bu0UKENi+BKbQUvr/DVl0A5p371OpbdTTsvYL173UCIJuMEwPTAD/RY3xJdYtWr19x1kU4a4DqjZVk6fNDleKRadsD0qn8tzA+4OqSCUq5bNVPS6lTNRZ98PTDOyC9N/GOSLEYI6OSBxipNbL9uhLPLeRVu5aWjLEcZdm3N5vnAiaqLqSTH/WJugnGGJ/K7vQX5JqQ7Sr0Sq
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 01:35:00.9090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7e6e8a-f9a9-4075-efe1-08dc4a104a8d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8294

On 3/21/24 6:20 PM, Boqun Feng wrote:
> On Thu, Mar 21, 2024 at 05:22:11PM -0700, John Hubbard wrote:
>> On 3/19/24 2:32 AM, Philipp Stanner wrote:
>> ...
>>>>
>>>>> +        if ret < 0 {
>>>>> +            Err(Error::from_errno(ret))
>>>>> +        } else {
>>>>> +            guard.dismiss();
>>>>> +            Ok(id as usize)
>>>>> +        }
>>>>
>>>> You could make this easier to read using to_result.
>>>>
>>>> to_result(ret)?;
>>>> guard.dismiss();
>>>> Ok(id as usize)
>>>
>>> My 2 cents, I'd go for classic kernel style:
>>>
>>>
>>> if ret < 0 {
>>>       return Err(...);
>>> }
>>>
>>> guard.dismiss();
>>> Ok(id as usize)
>>>
>>
>> Yes.
>>
>> As a "standard" C-based kernel person who is trying to move into Rust
>> for Linux, I hereby invoke my Rust-newbie powers to confirm that the
>> "clasic kernel style" above goes into my head much faster and easier,
>> yes. :)
>>
> 
> Hope I'm still belong to a "standard C-based kernel person" ;-) My
> problem on "if ret < 0 { ... }" is: what's the type of "ret", and is it
> "negative means failure" or "non-zero means failure"? Now for this
> particular code, the assignment of "ret" and the use of "ret" is pretty
> close, so it doesn't matter. But in the code where "ret" is used for
> multiple function calls and there is code in-between, then I'd prefer we
> use `to_result` (i.e. `Result` type and question mark operator).

No argument there. I was more focused on the readability of: do a clean
check for failure, and returning directly in that case. And then
continuing on with non-failure-case code. The to_result() part makes
sense and can fit right into that.

  
>> I hope I'm not violating any "this is how Rust idioms must be"
>> conventions. But if not, then all other things being equal, it is of
>> course a nice touch to make the code more readable to the rest of the
>> kernel folks.
>>
> 
> One more extra point from myself only: if one is using Rust for drivers
> or subsystem they are going to take care of it in the future, it's
> totally fine for them to pick coding styles that they feel comfortable,
> I don't want to make people who do the real work feel frustrated because
> "this is how Rust idioms must be", also I don't believe tools should
> restrict people. But in the "kernel" crate (i.e. for core kernel part),
> I want to make it "Rusty" since it's the point of the experiement ("you
> asked for it ;-)).
>

OK, I understand that reasoning.
  
> Hope we can find a balanced point when we learn more and more ;-)

Yes. And to continue with the metaphor, I'm attempting here to put a
light thumb on the scale. :)


thanks,
-- 
John Hubbard
NVIDIA


