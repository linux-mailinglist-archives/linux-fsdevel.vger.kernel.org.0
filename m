Return-Path: <linux-fsdevel+bounces-11895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 293548587F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 22:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71B5CB2D71E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 21:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F25145FF7;
	Fri, 16 Feb 2024 21:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KoJB++XF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A98135A64;
	Fri, 16 Feb 2024 21:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708118442; cv=fail; b=W6nb+913v1bMvI45I1F/74viIH4afRjP2TOqPY326RAuqyob1YOg/nmN0yVATkkeNp7hQR6a+GcoZ+7pzDg0ARnvcGbYMHtvE8PMxMHB+23K3uvbgEyLtv5N+2rbTQD0eFgktLsCcOL9dJY/SiX9hgv3K6lUe9QEV+i5UX0UGZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708118442; c=relaxed/simple;
	bh=BKNKrqG1VallLildcNkpO/brrGppq4pjnZ3DW3rNfNM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HyvdG1HjtuT5rhkBEHKcwdpp81OiwmXjHU627dy3qdmsPPUMWDvStTN2IYsHUH+rxlhLVgYqKv2jQisIhSAzcbnEvrVAnuoeI7uhnhylvmHkonbNDs7Z5CUZpBiTwyAAVpelAUYMY464wJ3nYbdAc8yJI87l8VgcvndS0ER3TZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KoJB++XF; arc=fail smtp.client-ip=40.107.94.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzpuWOdJLjvc7FEMwP0l2R+O1vsvfR31aTUj5Xem06AMTTI1w4Jakko0X0RRpLtG5PHyqvsXpPEb5P75xJUDjgFKKqT6iQW3kymBJ6kZ55g+gzUevaCTWL1vCmNPjyelQHLBAHrsu6PWsUfUP0nZnQri0GyyjFbUoZBrIChwtZU6fc3gSE6ujvxgVHGwcAR5nR3QDFe5WAWXwrprwv2z+bUkX5qDtkrwLdbz8aCx0w8LpSuU8a4O64rd7zDVOeR787V+BSWLDDhRGaSu6tjRCPbtCnqb+4qlCKL7fAKJJOAjE0yE3R3xdMOv6LJjuSIcGZZ21Yje8kLGTa7RC1ybTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLs69os7Y+vdBJQ7LjXqjrHBHMGZSzRj4PaMTs5DbYs=;
 b=S/Y5abdCTaAFbPvE1k3urjxYUAnU5ZihuCLVjMwYfOG/JkNsKdLJHoycdl9pVH0iyNwlrnuBUFFPhVXMGV5w/01EqPxyVzyU4xX3JKUh+R9P27R+pLhOT7T+wuCZFwE0a3OaerDrmqUomRsuEcdnjp0abK/0zMZULM2Dnebfj33n3/njxazri7CUY2I4RvxgG7/MJQQXDpd28qNzIzSuSnY8Y9kr7u4l5/pb1t84Yrb8594lBrvASnfivCyuqfXqTBvUbf0qRWZX6BgQfOgilusqi9IrsHEXR/WJaoNgSkZ02VCmIru//XGwxXVfG/olv9uDZ3rtIm2AEtYAl5Nktw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLs69os7Y+vdBJQ7LjXqjrHBHMGZSzRj4PaMTs5DbYs=;
 b=KoJB++XFCHyiMRQHOfJtVPFtAjclt1hMoHnZZc3jMMDup3alCZuVH0N4YvEq+ZIv9WmmxL88SLX0DLVq//u9mAtM0024qI03zTLzO/mo9gfRCS4LhsbzCtpX8ElsFwz5LZaAxt/FHGJfU2+LDZab02ZVhuDTBmx2jmWwxgw32gau/+vzmUnVEcQPxXPfhRnvonTjiII+xGTEcVlGjbP4RrptZ5THiak07WDC+hazAAAtf3TakRKkmlwacgawgq5K+hjnX/z1uz2f/c8LX0zB4+cfOIP0mOB+ZftdmusMKL5tkOrBsu3s01HPKxlGmaK1IJfzsd1jHO9YEDRAlQfsOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CY8PR12MB7610.namprd12.prod.outlook.com (2603:10b6:930:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Fri, 16 Feb
 2024 21:20:37 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::90bb:c583:cc57:aa1a]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::90bb:c583:cc57:aa1a%4]) with mapi id 15.20.7316.012; Fri, 16 Feb 2024
 21:20:37 +0000
Message-ID: <b6827a5f-ae28-4029-9e91-329e2a9503fc@nvidia.com>
Date: Fri, 16 Feb 2024 13:19:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: init_on_alloc digression: [LSF/MM/BPF TOPIC] Dropping page cache
 of individual fs
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
 <edec0ef8-00f5-4457-a1aa-59fd6bc9f6bf@nvidia.com>
 <67eef60c-b0fe-4034-a2e5-b09c7ef38a5a@gmail.com>
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <67eef60c-b0fe-4034-a2e5-b09c7ef38a5a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0205.namprd05.prod.outlook.com
 (2603:10b6:a03:330::30) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CY8PR12MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: e61ee36e-7742-47f1-7e0a-08dc2f351e9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pzBnmO4tPY+H+PX9ssCHIrK9Dcqr4MP2IBTNVcc9zetw6O1u1I1NeQAkuJKBAW2EbTdycCLG6OeonRVFDaLMzwXNf9K69GMn3zwlcwaTH7xjPyQb1MuL5fzVIKRH5s5uq4VNrQlP+GnkRKdlFavfaERxSKiz4cWeyqZABNghUBWwifOkARSilv0JRyFMuDxH8cvkPQU0oB//g74J7PFQR2w9agCl05B1mdoz1pHv9rsEeXPxcPhwvGgDNJ8t/Oj2ZNKkR6LL5WlIxogDCfX/u6o+cofXcBXszTtaxgZmoWa7wY6kVpF0HxirQGhfVVouiBwLY1AG087hORzUw7O+0OKLoMW3wJCmJQYoyaxB9BdAq9ljYF1B9Hhr05KOdnuvMtxolrFZ0dfg0+nSnFKhcilExdTCKLGF3nw3WpDnsbRXUCGVcEbr4KbqztTPvhXVdRMjZMf2cHZM/4gataGsWfE3LI9gbtTfzKoKHCzs0rSsmkzn8SnPS47Htdm+BOJOq2pKGJTg2vKfGK4qSylYYwAOJlK+3e44JX3AvOAVESg8C6V1QDRNEsK7i7aPz37Q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66946007)(36756003)(8936002)(8676002)(2906002)(4326008)(5660300002)(66556008)(66476007)(7416002)(6512007)(54906003)(41300700001)(2616005)(83380400001)(6486002)(316002)(6506007)(110136005)(6666004)(478600001)(53546011)(86362001)(38100700002)(31696002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZE1ZVUZlRDZodmVNQS9lSHY0clhtN3htZEtRSk82ajJ1b1FXeEFTbjUwMDFn?=
 =?utf-8?B?QUYzNjJsQVBOVm5jQmZORXFrdTNUMDFVM3dMek4rcUx0bHYzTnF3YytOK3ZM?=
 =?utf-8?B?eFl5ZjVzd3ZqaTMxTlluSTZyR2M2SEpJUUZzSUxRRis5SE4vK1AxVEk1aWdk?=
 =?utf-8?B?cFdXUzBaWStrcWpmdDBPQ3RYeGtjbm1XN1phMTdraEs1U2Mvc0VtSFVXTWZJ?=
 =?utf-8?B?eVh3dDQyK2g1a2VPYU4wUEVYRDZHbzVRRU1wT1Rob2pvWHRXNGt3a2c0Zkl0?=
 =?utf-8?B?eVJyRjhhajN1WDRvMDdhQ25RWXVudVhvREZBalQ2bjUvVHhqUDhtcmhPZUZN?=
 =?utf-8?B?VWl3Q0RRV1hOUGxNSzlha2txb3paMzUzdnN5bDFlZDNwalkvNDhiZVNMcUNu?=
 =?utf-8?B?bGVHTFJtaTJqOXdDM0hkUlFkaVcyczN1VVhWL0FHeklKSEl2MUFjd2RISEZM?=
 =?utf-8?B?WWZaZ2JTMTZHOWJaa0xQOWhWdEtsZnlXMGFFRTZCT3pZczVhZ3Fsa0ZDVnBm?=
 =?utf-8?B?TGFhd0RMbDBMbDdiazNHa3FYTGZHeHJ1NTV6djJ4SXAybFRyZW01cEczY2lB?=
 =?utf-8?B?TW1YSnpXTHN2TGtpa3JvRytuSmFySStUT2kyd3MraE8rbzI5dC9sY1NkVSsy?=
 =?utf-8?B?b2czQ0VLOFJobWdma0x3RXAwY2dLM05vdjh1Um9iVTNvUkVYWmRCMGF5Q0Yr?=
 =?utf-8?B?OHY2Q01SZTN6aXNiVWZaQ2lsWjJvK2VqRzUwQzk2NkxrMXVPakVjTWJiUzU4?=
 =?utf-8?B?Qm1CMmNFT2IwMFdGalNqQnF5WjZ1eUVCY0lOYjEzWkNTa2M4cml6NU15SmxR?=
 =?utf-8?B?OFMrS0UrYlVXN3dxVStYOEkrWXpIbTkyQmM5UkxtQW5neTVEN3hoWE9xQlhu?=
 =?utf-8?B?S1UyNlphU1FqVWpRZytXbHhibmFvc3pTdzRBYXVaTGpGV3EybE1TNDBoYis0?=
 =?utf-8?B?R2l5VFNLQXEwTFd5a1ZPQTBuYnQvd3pTUWo3NU90Y2R1Z2EyME84eHBOTCts?=
 =?utf-8?B?ZEpITEVkRUlERWl2cmVsMVJyakpqQUp5Y0FXWFNvbEdRTVRQL2hxY241U0xN?=
 =?utf-8?B?cVd1NG9jZFRxZXYxdFQzaWRTZ09vQklMOStxTVpBemtsL2x4aXpsYjZQQmxX?=
 =?utf-8?B?RnplemRnTXNicVJuWFFidVcvblYrRVhyb2pvdGx0NjU4Sm9jVUdhUUZSRFlx?=
 =?utf-8?B?ZHhrQVJpT2dSUDZ2VEg5TjFGYzg3SCtOc2Nud3RmWDdqR0tMYkxoaVZyY1ZF?=
 =?utf-8?B?azlrQWF2d21JWHBhbmtmSzNGeHVmVFplNXBsWW90K3Myai9ibGFuLzVWM1Zo?=
 =?utf-8?B?N09ERXZvSWZ3L005bSs0QXBLRTJMM3lNblNBYnl1bGRPY0hqSXBOOXpmSG12?=
 =?utf-8?B?UFRiaGVUL0RrRDBOd2tPTFRzRkNmTCs0VW15VUlCRjBZcEZVeWJsbllMNnBZ?=
 =?utf-8?B?M0NBYnpBMXRBRWNvaC81TEVEM2ROcFFsckU5bm53d09ocFdNY0EyeC9VK1o3?=
 =?utf-8?B?MjNiNXUvWEhMeFk0b3RJQnIvRi9jUHQ0Q2d4ZTg5cWpmN0JjTEZPakNyNndC?=
 =?utf-8?B?d05VVERoVXo1dUFWMU1GWGpiRmFLWFRvY0tTTlJsWkFhUXFtNmU5L2p6TUdl?=
 =?utf-8?B?NnljRnRUWG9vNkl4Z1lGSnFmb3Q4aEtlbFFJb3lYMG90MWNDQTJVS3M3V1Bi?=
 =?utf-8?B?TExwNmpRMk5tSXg0M1A4NXJnb2NiQWpSdWxyY1FobmNvR1p6VXdCbWZJZTJF?=
 =?utf-8?B?OGl0MkY0aEdmOVI0cFdjcTFRVVVxWjBnaDlMVDFvaGQvLzYxSml0R0h6TDhS?=
 =?utf-8?B?Z0E1bitpVHVkejFrZ1YzRWpKS1A0eG1ENGtrZlo1ZVFRd3VJdkJPd2R6Ukla?=
 =?utf-8?B?M2QzOExBMXdqVGdGUTBrNDIwTjBwT0dNb1ROcVdDbXBwbUJTUjhmRE5OUXNE?=
 =?utf-8?B?K1pGTUJqVjZPSGJRd1YvSnozSGJwb3NLdlpHSUMxRFdBL3EvQlFwZGJ6T1pW?=
 =?utf-8?B?Qmx5WC9FTWJYZjhEUzUvTGFtNE5hOFk4cnB4WXhWR21jMXlWMG9nZjZqUG9v?=
 =?utf-8?B?UjFhcmFYaU9ocHBUTjB2OXhPQWIxWHlqdmtWZHhzcWNhZTNpOUp0aFNMYzBE?=
 =?utf-8?B?cDlXRkw5Z2lhbWQxbmJUQzUrcHBBaDFURno5dm5sWjc4TWhPeGIzSHhFdEl4?=
 =?utf-8?B?WkE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e61ee36e-7742-47f1-7e0a-08dc2f351e9f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 21:20:37.4335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IUz2MWO3hlf8EgFY+EMVH8K3VpeTPO2pH21WUtlN3wBsG+zR9L3SoKvcM8iWx1xKOZ1awh8CDsvqEzuJyvd7CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7610

On 2/16/24 13:11, Adrian Vovk wrote:
...
>> But init_on_alloc forces the CPU to clear the memory first, because of
>> the belief here that this is somehow required in order to get defense
>> in depth. (True, if you can convince yourself that some parts of the
>> kernel are in a different trust boundary than others. I lack faith
>> here and am not a believer in such make belief boundaries.)
> 
> As far as I can tell init_on_alloc isn't about drawing a trust boundary 
> between parts of the kernel, but about hardening the kernel against 
> mistakes made by developers, i.e. if they forget to initialize some 

So this is writing code in order to protect against other code, in
the same kernel. So now we need some more code in case this new code
forgets to do something, or has a bug.

This will recurse into an infinite amount of code. :)

> memory. If the memory isn't zero'd and the developer forgets to 
> initialize it, then potentially memory under user control (from page 
> cache or so) can control flow of execution in the kernel. Thus, zeroing 
> out the memory provides a second layer of defense even in situations 
> where the first layer (not using uninitialized memory) failed. Thus, 
> defense in depth.

Why not initialize memory at the entry of every function that sees
the page, then, and call it defense-really-in-depth? It's hard to see
where the silliness ends.

> 
> Is this just an NVIDIA embedded thing (AFAIK your desktop/laptop cards 

Nope. Any system that has slow CPU access to fast accelerator memory
would suffer like this. And many are being built.

> don't share memory with the CPU), or would it affect something like 
> Intel/AMD APUs as well?
> 
> If the GPU is so much faster at zeroing out blocks of memory in these 
> systems, maybe the kernel should use the GPU's DMA engine whenever it 
> needs to zero out some blocks of memory (I'm joking, mostly; I can 
> imagine it's not quite so simple)

Yes, it's conceivable to put in a callback hook from the init_on_alloc
so that it could use a driver to fast-zero the memory. Except that
will never be accepted by anyone who accepts your first argument:
this is "protection" against those forgetful, silly driver writers.


thanks,
-- 
John Hubbard
NVIDIA


