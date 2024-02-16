Return-Path: <linux-fsdevel+bounces-11893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9157085876E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 21:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A131C20A9F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 20:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFB71487E7;
	Fri, 16 Feb 2024 20:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AuegnLAV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA2C1420DF;
	Fri, 16 Feb 2024 20:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115947; cv=fail; b=YPri84Y5ebUBCmgqfS2adqRx/WP7BSW+Dou5p0xoek8zngxWpOkMAsUb4qfHBaQDroOh6MAOmVZCbVplS4JGWJmYxiv/0HU0qaK5a3gmxdY9T36atpWPbK+JX3oFOicXbChuy4z4s+AKho9WWW5TGucXYOb56i+UoqZ8r8JE+RU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115947; c=relaxed/simple;
	bh=VMly1P57jXF0j9zOgG1E4Z6z7gH5bV3F/Vi6IZFxTNo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dd0xP3r9UVLdibRMplcs9N03lxE1YKg7ihBtxrC2/zV1Y2w3L10Qqn8ZECxapNHFPD+u6WQ0wpL/tRnJ4t7sWsWYDknJ7EOA03bgtXykwYYD4+C1JX2IjzmHLPjgqbQW5vbu0UdLuillypYTxwfacF5bOxRBn+tJ/NAwOwtmPqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AuegnLAV; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6cF5Ibr5TKQ6o+WRxrWWrnrCHYMGnBJkYMbGZEBCPMUSbEDiP9XRDzcPL6WhtgUXpLv2hnMUq2gQkjuHYbcDXxr6zlLDtgGwTUggdzNPGZEca+3kUerSHAAoWyHpONfOC6q6sYq2q6znpYlFtVnzLO3V2LRJRNz7510hb+xLS8iw2i8woJAuc4ENejog/46F/AW7A2HaxAhvjhlTaMZZvGJTnIkZ10Z4Z94fDnRHj7Q+oz/qrGFKS5RApc2D8fdCxaoZ6SbQSNdvRwuLhR2JXjB99rI/4qLZ3gctZFw7uuVBiQmA9Ht0y9melK4JywbKrEiMY4OiKcQiU/hE3KWNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RI1qCghe/4mGLFRnIbjJ5OrgvaPVuagdg5OMGKkD/4=;
 b=YKSHIlO/TQ8XJI6vXOYELDctXi2XJNhN71eIzDuQELl9UpOUifOZlOBI/7ZOXM90PGIZCpbla2bGYZVDb8NayFetuNztf+wEWo9lKVcVbTkarw6SPhUw/AWXkHMlrYMpIyBK5ZUlYQQIEhNKHiDkjWmhcdXwcVSlvW7WOMtkf64r2pgjQLuksjSZYk8u/JC7Uzep2XP1PU6+U3jUSA485MkB+D7OSZh04p0rBpwgL1M4JcAAh8ipVDxTVowNw9Bjjwl5aTFhl9PpvuIiqQwRiybwpfvxTFusGm51W4kwTeJK0d167g4vOVEAbQYMmKEHzCRsl7ijBwW2FwamzzG3zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RI1qCghe/4mGLFRnIbjJ5OrgvaPVuagdg5OMGKkD/4=;
 b=AuegnLAVEUwZz6zmwVaGidKN37Vg0Jxwx+S+akLi5mhj30Ez+Oj/9FuJjiusa97SohZCO5KcJZGxZeYDWEcm5dQDIDBRuA7iCpAluhAGJQe50aiYl0fdx7VIm1Xfs7UiHBpGCqtBNpVjXeDF0t/IdNm5CgDnHPJsDpJVfghUywGvtk3ibnL9OxYO+Vt5srnoDXYWkpwq9y60mstxDmxJyFY0XtRAk3I0RhEJjlCb4vg0vuEst/dHB9FTmYJYcIsHHc7vs2Bwo40m0TJfywlrxWNy2nOT3S8a+V3MM4PkhCiPPtDsF/erFNJhPiqISg8O6lOslynNPLEXYQ/DlJ/iTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MN0PR12MB6246.namprd12.prod.outlook.com (2603:10b6:208:3c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Fri, 16 Feb
 2024 20:38:58 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::90bb:c583:cc57:aa1a]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::90bb:c583:cc57:aa1a%4]) with mapi id 15.20.7316.012; Fri, 16 Feb 2024
 20:38:58 +0000
Message-ID: <edec0ef8-00f5-4457-a1aa-59fd6bc9f6bf@nvidia.com>
Date: Fri, 16 Feb 2024 12:38:00 -0800
User-Agent: Mozilla Thunderbird
Subject: init_on_alloc digression: [LSF/MM/BPF TOPIC] Dropping page cache of
 individual fs
Content-Language: en-US
To: Adrian Vovk <adrianvovk@gmail.com>, Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
 Christian Brauner <brauner@kernel.org>, lsf-pc@lists.linux-foundation.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
References: <20240116-tagelang-zugnummer-349edd1b5792@brauner>
 <20240116114519.jcktectmk2thgagw@quack3>
 <20240117-tupfen-unqualifiziert-173af9bc68c8@brauner>
 <20240117143528.idmyeadhf4yzs5ck@quack3>
 <ZafpsO3XakIekWXx@casper.infradead.org>
 <3107a023-3173-4b3d-9623-71812b1e7eb6@gmail.com>
 <20240215135709.4zmfb7qlerztbq6b@quack3>
 <da1e04bf-7dcc-46c8-af30-d1f92941740d@gmail.com>
 <Zc6biamtwBxICqWO@dread.disaster.area>
 <10c3b162-265b-442b-80e9-8563c0168a8b@gmail.com>
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <10c3b162-265b-442b-80e9-8563c0168a8b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::29) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|MN0PR12MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: 997ca2ee-f04b-429c-e319-08dc2f2f4d1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ghICbXmRM4Sg4JG8DX/WLiHguXitG9UrYtTWOQtqoKQY4c3C04/HmvMWYxL4HW6fn9N9qwOZ51EZtHjYs+oyOgt/TNte8x/SkhkNd5lrtyiGz0ltfNmx40nIckIo6wMEx4TFIBXdxYKZZAerTJH4iLTWENiNi6b9mut0jpa1Zg02rsl5YWORCLYo2JLfGgI/nI3BwJbgpkj3UkxqH3WH7+oKzyJS4GRjATrxw5nm7pczd+nFVoRkjU6eDVfI6ll7OWYcjRxPRnWb2uTpDKs9D19jBfl1PRIxwbLom1dRIdhHbwvRs7/7EoUZZ3teibsW9QikwwogsEGRpdc693/vM0OFRwlWz80Tyjx29mR3P7mtWK4PvMfgLTFxTOVx4bSzOE4ymXaYDysFcogFw32mIYLixuQzziYy3JczTtIhA4A3RTfnFKQkvXPe+3rQ8OkwIKl/v+6ymmW6Q2whOiVGf90sT7+UmAFwpR+jhW4yZKn1Zbb9Z9/PIdN9LpOiWbLF+62e051EEp6DhxiHLgOwmlCNF16WXtAm8O0H5dIxhenmZ0N+vePah2pUYScPSpmF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(136003)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(2906002)(8676002)(31696002)(5660300002)(7416002)(86362001)(6486002)(6506007)(53546011)(2616005)(36756003)(478600001)(83380400001)(38100700002)(8936002)(4326008)(6512007)(6666004)(66946007)(54906003)(66476007)(316002)(31686004)(110136005)(66556008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGthQjFQQWFaQmFIRUxZNE9vb3UrQ3B3dkxOU2kyZ3IxUUdqRTBLQUdVZHZn?=
 =?utf-8?B?VFJnZGZ2TDlMTkQwazJoTzI0MW9NQnVUQmRDaUFGeDJiVDhwMC8ybHBnZnRX?=
 =?utf-8?B?cWVVb1pCdFZvaXhYWDhadUlQL3VlSXdrckJmZDAzYWpRYVFUNmE5by84M0Q2?=
 =?utf-8?B?b2F3eXZDalpCT0RGbzhIRDVZdkIzRzQ5ZllWNlB1Z015ZkxnUFJwQ0N3b0Nr?=
 =?utf-8?B?Tk12UlZxQUNvRFJEdlJKamhQQ2ROM1laNGlTM2lYRmhadkxzMGxvTXYzSC8v?=
 =?utf-8?B?Z2NJUmppZ1VVTWRHMDAxNExaOU9xMUFiZVl4MHNIdTFDN21DSEtjdUJzMXRW?=
 =?utf-8?B?cWZiWEQweXNHbmxPcTBMUStRbml3NmtTV2JSWWg4L1JaT1Z3a1dQd2o4MlJQ?=
 =?utf-8?B?QWN0d2IyY250Z0k1cUtGTTR3cXdRcFpaemVRcGtIV0o1NEpYSDJCbW9NL3hr?=
 =?utf-8?B?d0gwdlVGOGFlbFlwSk1ldlV3aXl5MElqMGpXaWhkbVp1UGFqUXNPRmNZbnV6?=
 =?utf-8?B?TUxKSUdCUStSRnFIQnZqZ0kveTBzLy93WS8zeEFLRVJuMngrbElpaVNzcWFC?=
 =?utf-8?B?Y0dUMmhOYzNkd2M0aXU3N1dmLzRRejc5SnhjazZtOEVTY2lRc1FXTXpIUmdB?=
 =?utf-8?B?bk02MGVkcDJrRDZwNlVvamVuV3JXRU1QQ2xyM2N2SndaeklnMzFxbDBCZUV2?=
 =?utf-8?B?a3NZYlZCNnV3bVFFYVFHQUcxbXg3cU5NRUdXZmFlNkVnMitWbk5JUXd6Zyth?=
 =?utf-8?B?Q201KzVIMzduMzBHc1A5aStMWktKYUp3TGhBWHFKWVg5ZVcxV0FLektybm1N?=
 =?utf-8?B?bk0zNjJJUncyVTZXdzBLQmNtSWEwRk82ZkdTQVNNUTBLQjY4UG95TWM4dzF1?=
 =?utf-8?B?aEx0UWhQSWNIaHZ2MHA1MEk2b096NHVvYmZhT3BWTWd6UnpsVVJkTC9LQnE5?=
 =?utf-8?B?aTdlTzNwdjNMWGFucHdKckZxVlBKQ2gvQndDOThNaGsrZ1FTUktZQWx2dmw2?=
 =?utf-8?B?R1RvSUx4RkRyaGRTY3h6TERaVjB2YXExc2J2eUJmOEFFZ1pQU1d3a0NHYllD?=
 =?utf-8?B?Q3ZBSkVoRld2VVkzWjlaZ2xLbUc3a1R1a0EyQmhqUTF1YTgwbjBCQnVQOXhK?=
 =?utf-8?B?bkdPcXZsUmxPVGkwdUhhUys3dUZwSkNmNjBYNjM4M1haQmpNaXpjTTlUZ3pa?=
 =?utf-8?B?VVBCc1JFdjNWSGxpY3dtQVpZS2RnVTUxVzJWRjhFNndXanFoK1YxR3BGQnhh?=
 =?utf-8?B?VVBWZ1lLbFVZTXZEdVZrT2RJR0J4TzBDNFMwekdpMktYOEFhMlZrTkEzcmZH?=
 =?utf-8?B?NEpPaDdpYWJ1NkZtMG4vWEpBUlBqVWxSdlRhVU9iTXM3U3Q4WW5GTm9ZSnRW?=
 =?utf-8?B?TWs0R1NZMEdKUHlQNGRVSndocFNjTXM5QkMxNVN0eVp5U21KaVJRaFdUUndN?=
 =?utf-8?B?cnU1d25kL1psTmZTc1VmU0twTitqZ2JYU3hodkpjd2xOLzk3SU1EdkhYZVhH?=
 =?utf-8?B?MjduN2NCVUJDUEtCMml4YVZRQ2dYVUFKZ0hIelFacWtzVWUyWU4weDJvYURv?=
 =?utf-8?B?ZHg5MVpaRUw0YmYzakpLVXloS0xuMFhackpXNFMxd0JWSkRkTHZralBybWpK?=
 =?utf-8?B?SG1ZbVdIOXNzOERqR2Nqd1BUeTZaQW9RQzhSK2pYRUF1ckpFN1A4RFkraXUx?=
 =?utf-8?B?OGp1bExIVHlzZXF3eFRDOWxJdEhNYm1JQTBEV3FRdUw4NjRnNFl4dmJlc0hq?=
 =?utf-8?B?RjVpQk1YRDUvdWl1d0ZpUlRlUFF2T29LdnlPS0RjeFd0dkRCU2IyaER5SlFl?=
 =?utf-8?B?SXpFUVJTcnczYkJORFpoeWZGL29HWWhWNlBISkN1NmhrMytBdHFxWUsrUGln?=
 =?utf-8?B?VDZqUlQ3VHE3cXcxWnlvMG5QTEgxYmZWYnlCWHFLUFR4S0J5aGloTDRDMWVZ?=
 =?utf-8?B?UnZrLzcwdDNpY2JEOVZXTWR6bkZvT2VPaGJmNGJya0oydU1uZC93S2kwUHVU?=
 =?utf-8?B?UE4rb0p4YXk3ZWtZUWIxVnNFLzZvMGdVWG9CT1oxZVh2WmE4VTVFVjRWWUpt?=
 =?utf-8?B?ektHbHRRMDJ5bU5xSGJrMWZlZ1pnYVcvY29UdXpGMHdpek9rZ3FZK3MyenVk?=
 =?utf-8?B?ZUFQQ0RPcjJxZWxqVGlzVis5dTVLOFR1WnFMdEZxZTM4TlNhcEN3S1dxVWNp?=
 =?utf-8?B?MlE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 997ca2ee-f04b-429c-e319-08dc2f2f4d1a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 20:38:58.4363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: quGeQDJcOsLujIu1us7Z6AOUqAo0SWfPyYe6AqVxsiGReVq0tb6F9NZvZAVOx/Zb68dEiWr0aRxOaTcGExuHKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6246

On 2/15/24 17:14, Adrian Vovk wrote:
...
>> Typical distro configuration is:
>>
>> $ sudo dmesg |grep auto-init
>> [    0.018882] mem auto-init: stack:all(zero), heap alloc:on, heap 
>> free:off
>> $
>>
>> So this kernel zeroes all stack memory, page and heap memory on
>> allocation, and does nothing on free...
> 
> I see. Thank you for all the information.
> 
> So ~5% performance penalty isn't trivial, especially to protect against 

And it's more like 600% or more, on some systems. For example, imagine if
someone had a memory-coherent system that included both CPUs and GPUs,
each with their own NUMA memory nodes. The GPU has fast DMA engines that
can zero a lot of that memory very very quickly, order(s) of magnitude
faster than the CPU can clear it.

So, the GPU driver is going to clear that memory before handing it
out to user space, and all is well so far.

But init_on_alloc forces the CPU to clear the memory first, because of
the belief here that this is somehow required in order to get defense
in depth. (True, if you can convince yourself that some parts of the
kernel are in a different trust boundary than others. I lack faith
here and am not a believer in such make belief boundaries.)

Anyway, this situation has wasted much time, and at this point, I
wish I could delete the whole init_on_alloc feature.

Just in case you wanted an alt perspective. :)


thanks,
-- 
John Hubbard
NVIDIA


