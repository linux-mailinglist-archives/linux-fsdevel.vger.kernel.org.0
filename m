Return-Path: <linux-fsdevel+bounces-35539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D479D58A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 04:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6850C2834C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 03:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEF216133C;
	Fri, 22 Nov 2024 03:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X+7xeZSQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C9613C3D6;
	Fri, 22 Nov 2024 03:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732246753; cv=fail; b=nj5UB4jHDI2hwax/vin4hPa93Y2qnfOHL7uMGgts0hl2+ZntRWeskADzvaUogX3MtWYKOzVm0DIBmm2nBnq2LOyC7DihAfKIAMLoWS4RFNRyJP9WtvOgno9nV/cBUw1V/U00wH5l2i1T0oE7MHHSPl9xsd66lFNEIGt1e2V+3xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732246753; c=relaxed/simple;
	bh=ygn/fMifzS1cxoGUeUrY7u6W+UC9cj7bh4yGUtwmfWY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=Di/rtOM4x5ssGaFeRYSsj/PCpxcwLXwfHkpUy3h6zY9YSB7SN0FO+7eru5sS0fHmvzchMrUc9MqITH+KGwZWpw846i6iRzjXotsojX/CZ8GO++8pw0T/hXGTj4dqssA24LTBgHGr8XcHDMExaecMlJoFmi4igOcMZE3QLEIzB3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X+7xeZSQ; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTerYBT0FX2MwyXGFGZP9G6fc2RcADWmYTPx49WxiUzMcW/Ro+JSljte9PwjXHlxCbFz15C2kkDo1eyrcGxJz99kJHywmNQlS2JnLC/Z0W0RiSY1FQWm6sIzSRU4TzEeTovc+Swb6GbNNtX5JqWqd1jtLaF8UNEV5AEmhhPRI/nVw3dqMKOXcViO0b0lz6iFTVbVRUWHZCUxcBNeQJUigNDiHCYmC49A5F4vtCbEX6T5r7ciV5PdKPSk0ApiYdP7PKsRnYYwoqM+djcRti68NDGxDC1i0udchdzVEL9yz6SrnodKQtA6YjKPdpPjbinOJ10tJ9qAg30ohDe6vvC2lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dt1cg9OqNCsmKJkrdhWXJZVHDZ7PeN36Gk9BkXNzrro=;
 b=iz6t2Mgcq8AcZXdu9gAW7U8LsX+kMFEdtdNq53OiHXpMBtR6sEjGzSYf8aZuCfWblay+Ns8/e1D8+0TQTgCLiLCdx3EFHOop6LfzWTrsOW4Z2DhDCYpx24LmcrxQMjz+DnfL7hDFHeHrbjppkcqkl1OtvGJORU2H8yfyrVZm89PIeLhMt1fq4b61SFEHJcsQgq12/f9HbKF3IDEw3Vc+fud9PXQ648XYYsxWVADDpYEpwdrtY9e4rggECxDQS4Qjg7Of8K0IOGbTm2RycVygu7+QBFTaQJPfrVAx99satVo5NRLrcPTGQLDBuokYNApRQZ06Ld0G8yCbQDND6K8lrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dt1cg9OqNCsmKJkrdhWXJZVHDZ7PeN36Gk9BkXNzrro=;
 b=X+7xeZSQ7zdVMKjJBOJsF82G7HKQFIkBEKhqgKkuhs5WqPlhwU7ntAxhn/STzYnGWRa5u1atw5Raa/03AQqawrc44aNx4lZRMxv+ZAGYt8QculfeQH82ViDENqxfM2T198nT4gtNNEAYIqX0+Q7W2fAUZ0CvjSbHbYGMjnW00tMwtZ0wBmz81A22hrUh9AbZ9s6CLnJH/aGP4u/ioWN8T8RrJxCFuRrTI5q+QzCArmzSUkUD9rlpULqdkMY6VtLIsNqON5oXT+CJIu+rGFLmRWZ33bkB/uDWPJCEmLuBtrjqfLaW0j39aYfQ/xv3AsyQyisyiYbl9exEjaEQE2KcqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SN7PR12MB7856.namprd12.prod.outlook.com (2603:10b6:806:340::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Fri, 22 Nov
 2024 03:39:07 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 03:39:07 +0000
References: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
 <31b18e4f813bf9e661d5d98d928c79556c8c2c57.1732239628.git-series.apopple@nvidia.com>
 <61ff7fe6-9a79-4dd3-8076-7106fe08be5c@nvidia.com>
User-agent: mu4e 1.10.8; emacs 29.4
From: Alistair Popple <apopple@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: dan.j.williams@intel.com, linux-mm@kvack.org, lina@asahilina.net,
 zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com,
 vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
 bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
 will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org,
 djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, david@redhat.com,
 peterx@redhat.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, hch@lst.de,
 david@fromorbit.com
Subject: Re: [PATCH v3 05/25] fs/dax: Create a common implementation to
 break DAX layouts
Date: Fri, 22 Nov 2024 14:37:40 +1100
In-reply-to: <61ff7fe6-9a79-4dd3-8076-7106fe08be5c@nvidia.com>
Message-ID: <87plmodjjc.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0053.ausprd01.prod.outlook.com
 (2603:10c6:10:1fc::8) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SN7PR12MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: 926c8c02-eae2-4e42-cdce-08dd0aa7382e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YoC1fQGTOhcQCTvLGUAczmSXiNUO7g928g198n1LfPZv9rMoMP+8SiDwvu/6?=
 =?us-ascii?Q?b6MBcFm8Y1Ru4druTW8Kbbx2zKVQRj/20c/CEgjB080ptu1UcB5Ktz/XG6Uz?=
 =?us-ascii?Q?ovlfPiWJc7ed6vL6YGOdnwCcb4jmVf5CufEf+Fsw1UPzHTsoQSANNVbyGo6n?=
 =?us-ascii?Q?5HceR9ZQdKrbcd3mbMv7JMmqxhxAIBwq1GUOz60CNcmn3t+RqpRi6iYSgMlZ?=
 =?us-ascii?Q?kXW4VQpt9HssPhGxOfLxKvS9EgV7DFqVwd39Uk4aOqvdIt86xGbG+kSKpBh4?=
 =?us-ascii?Q?GoT7xxtLIN3hMi8s6/y9kInU6AnkOUURn2aMrw7RgfDb7q5fThUIKXNdJwYc?=
 =?us-ascii?Q?YtHAUVaDbJOPO67RH0yjvUB74x+ObjpVqLNvOzIBsP3d8L6hwpteksGYIlZJ?=
 =?us-ascii?Q?H8TrmVJn+32HRAaE19cNlotjd/FijZD8XZ7Np1GxAhOvFm0qtMYG41YcpcRI?=
 =?us-ascii?Q?ttvzgjnJGqFQQEASiTxc7gI9bHFCmKHl3z4iyKxECbzRXv7E+yyZxGupCxny?=
 =?us-ascii?Q?gH2dOaRDrjc2LdBgxBw46xXvOOEb/a+n+I09mc/Kw40QJhv8bTeoqEauHfUZ?=
 =?us-ascii?Q?9L5KXaznBv1Ng9JOhMOdv9saOVSJ7n9hmnk3IPh3nb0ORWDIVp1UbxLYq+kO?=
 =?us-ascii?Q?C+rEZojG3zQ/X8xDj87h7pr14aeWnmZnJUiBpcDXQkVsIqD9PbKybqWsJXRT?=
 =?us-ascii?Q?j1ktJ1jjRPiOVLFG4R9HguTbFYgbAaiUPT4kdgpfKvV+eH/M0nXA67GHG64q?=
 =?us-ascii?Q?M+t9rfmG+du5CUgO9ndLCrZXyB7On8j20q2yktf58Cr7Smkj5o9YPhB7rNVl?=
 =?us-ascii?Q?6VWqvTXBz3SMPmiNQk4P2irI8km4NXwxW0xhCShr63nwvxgSCsux8nhNoAQS?=
 =?us-ascii?Q?YIqeARJ3b6l7aIOScPYTtKMXuUCdFP/cHBvYjov1g+9JB14llS6bRAZQBA+D?=
 =?us-ascii?Q?IU3jHaoHf42C/p1tz/tcGo3bllNnjcZcI9fGUqj/V/5aXyL0HEY4/WhOwYTt?=
 =?us-ascii?Q?CfC4HNh1lP+ZlY6gSxSm3S0v8PYIs4ciTkcSnZds4GsZH2CNB9T7dhor2x6U?=
 =?us-ascii?Q?840aXAqToPcW+jsoDcJEW71ebs8qWq/GzFLZPynoCCLs8ijEEQRkbAVKIOas?=
 =?us-ascii?Q?EXBga9rkfi/mQfZerekXl97lTmUSqXl+e146s5QHe+6/ZCnINo6JTbEB1IPX?=
 =?us-ascii?Q?oB+6R+JbmTKGhDQBELf6orLOcX3Xyxc3SizOCBvETEuU8isJhoJPtGOkhJZq?=
 =?us-ascii?Q?YYLaG7VB7y2712OI4lnzwDy3bSMcAogHnpGAEhEh6Mfis0aXWUdzYtbThcsY?=
 =?us-ascii?Q?1GUg8oaEOa2kI/rxuCnufOeB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?52MhAmfLqk+Q/q853yhrABtGh/JmOahuj+7NMG2IIHijzCqZLzGSvsQ90uCE?=
 =?us-ascii?Q?xu71URhDGnlGkQ5rNRWZ9OdeqZVIJc3VvjLH2lK9NsK//3wqZS7G4ndmD7em?=
 =?us-ascii?Q?ueqHsTIH/em+oihYz8JLU5obFdmsLZbi7HPR1tDHFfj3wYBPVhjVxATQLVnB?=
 =?us-ascii?Q?XTlGwm5UmvVh6nlcJfjaOISvEpGLOS6+Tdm40+SumWcXLk7kwQHrYo6hoxTm?=
 =?us-ascii?Q?bqDC7iJWaFRWbsuT4gm7UbdkU3BM7yFIhnRH3NPSENs5XB3YB9tGl9EFFcjC?=
 =?us-ascii?Q?ckFZSlSicdYZjmg996vJ/tXLaQT+2kWGpqP7xMlyJhk/Q/sKE0EzGtyfjg1s?=
 =?us-ascii?Q?QWVLcyQ2l4BAXAVm2zlcOPc8NSa06gRc2dtJiPcVQHGKid4ut0rBLuoBIsfw?=
 =?us-ascii?Q?0tZz2QphKC//F/454GTakd9Lhm3siiQOauvi6MLKji89K+2bBbuaMhOrdhX3?=
 =?us-ascii?Q?uZzNhRU9HA4DEdm8vKKpF/2hhUNw/60p7neu9lwKDyqGDFHCucj+RvYmRfE5?=
 =?us-ascii?Q?kkeZL2rbpwN18pwqoszt/wB6dGgGZRDPlJk2FCkhlrXBriork6vbX34COLct?=
 =?us-ascii?Q?8JDh03zBRC2ZsFIn4N9eFaWjACY5k0QpOSe79N+Dd+3/1H7iwT4avxcP0p3x?=
 =?us-ascii?Q?QHjSFomv/pxeZiVekuNL2wos5De5tTlZnt+tBQvwWZ/UTPw8wyb4q3yIIU5Z?=
 =?us-ascii?Q?xqiIoePSmv771NwwsHJ6KwYmdRDXGZGd6FMEIcxmKA4UwYhbb+7VkDejb9Kf?=
 =?us-ascii?Q?fyGKdJnETGcBfeicIpTgQHBXtzpMtUu/EZ+IXrusIncAqNC2fh2FH3iZKfp1?=
 =?us-ascii?Q?s5E6OhOv19GhuuJ9uIStCkIFhbuKNsTzb9Ugo5fSuRFqndWv22IIefaGI0P/?=
 =?us-ascii?Q?oejt3tfA5uW7OLfDUGKHwyEpYv04qyfM0Fh/Nxh8mOUSQX+x99DulO0pqJhD?=
 =?us-ascii?Q?8Kz+yZ4FwsZWpJpIgBesbT4nMYCa/Aws7iH4G3tMS3EL3vqZZ5tq3W28OpfA?=
 =?us-ascii?Q?XZd6c2WOdjxL+BFsSLbGVpsZPG3cNMSF7EiyXvITIVwpFrYkjplZw5UgbQbE?=
 =?us-ascii?Q?KTKGf1QyxPiaT3FjBdtnh4EzntQOvHYU11HWYErfhu4HK+7bfk72Lcd3lvUj?=
 =?us-ascii?Q?YZZS4QJXKOQtkmt7gtbCPg6Boyu/fRxJdyEE2Uee5CLZ0onJ6GHNrDzifiWW?=
 =?us-ascii?Q?iKBCqQ8BLApXJtzPplUdRqn6UF2c4ifvePSk9LMUBJMIY+p9cu82oJsxiV2s?=
 =?us-ascii?Q?paRQE5pk5RVzJWPPJBElx0ANEhdD28BAM7KfvKpWsWSq6QGXdAg6vetOtuYR?=
 =?us-ascii?Q?ch4YPPUG4/RglgbRwnGmghsYbVCwLZ6loUGQWvYW2ps9QjqbS6HeBHvmhKl7?=
 =?us-ascii?Q?Ec3njeX8Nn50N+s+y8NtYCCC/3mGWwuo2hzza+koq9UCKIP9yGzS5+RLVmki?=
 =?us-ascii?Q?GwcBi5NthB+r9D6TA7i4+fIeqGEAgUnA2OMm9aOcCszEgsJqpw3Ec0D0MQSQ?=
 =?us-ascii?Q?Su1moCPNsjxtynFuE5n9WRmQEgL1BKoUVITxURdcvIjOxPhN/I8alrqnOOz7?=
 =?us-ascii?Q?PFFF32y3RVaorWXcbOmrE+vhOEMyIBueH60E9jm+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 926c8c02-eae2-4e42-cdce-08dd0aa7382e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 03:39:07.6267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvF1dFoPv3desQMS9zOZdww2wSerOi9WNl7kp9iYI4HgvPf8gLOh1MFcKVqTtVdNOmuKC+mjMS0R+OCOG59EHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7856


John Hubbard <jhubbard@nvidia.com> writes:

> On 11/21/24 5:40 PM, Alistair Popple wrote:
>> Prior to freeing a block file systems supporting FS DAX must check
>> that the associated pages are both unmapped from user-space and not
>> undergoing DMA or other access from eg. get_user_pages(). This is
>> achieved by unmapping the file range and scanning the FS DAX
>> page-cache to see if any pages within the mapping have an elevated
>> refcount.
>> This is done using two functions - dax_layout_busy_page_range()
>> which
>> returns a page to wait for the refcount to become idle on. Rather than
>> open-code this introduce a common implementation to both unmap and
>> wait for the page to become idle.
>> Signed-off-by: Alistair Popple <apopple@nvidia.com>
>> ---
>>   fs/dax.c            | 29 +++++++++++++++++++++++++++++
>>   fs/ext4/inode.c     | 10 +---------
>>   fs/fuse/dax.c       | 29 +++++------------------------
>>   fs/xfs/xfs_inode.c  | 23 +++++------------------
>>   fs/xfs/xfs_inode.h  |  2 +-
>>   include/linux/dax.h |  7 +++++++
>>   6 files changed, 48 insertions(+), 52 deletions(-)
>> diff --git a/fs/dax.c b/fs/dax.c
>> index efc1d56..b1ad813 100644
>> --- a/fs/dax.c
>> +++ b/fs/dax.c
>> @@ -845,6 +845,35 @@ int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index)
>>   	return ret;
>>   }
>>   +static int wait_page_idle(struct page *page,
>> +			void (cb)(struct inode *),
>> +			struct inode *inode)
>> +{
>> +	return ___wait_var_event(page, page_ref_count(page) == 1,
>> +				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
>> +}
>> +
>> +/*
>> + * Unmaps the inode and waits for any DMA to complete prior to deleting the
>> + * DAX mapping entries for the range.
>> + */
>> +int dax_break_mapping(struct inode *inode, loff_t start, loff_t end,
>> +		void (cb)(struct inode *))
>> +{
>> +	struct page *page;
>> +	int error;
>> +
>> +	do {
>> +		page = dax_layout_busy_page_range(inode->i_mapping, start, end);
>> +		if (!page)
>> +			break;
>> +
>> +		error = wait_page_idle(page, cb, inode);
>> +	} while (error == 0);
>> +
>> +	return error;
>> +}
>
> Hi Alistair!
>
> This needs to be EXPORT'ed. In fact so do two others, but I thought I'd
> reply at the exact point that the first fix needs to be inserted, which
> is here. And let you sprinkle the remaining two into the right patches.

Argh, thanks. I guess one of the kernel build bots will yell at me soon
enough... :-)

 - Alistair

> The overall diff required for me to build the kernel with this series is:
>
> diff --git a/fs/dax.c b/fs/dax.c
> index 0169b356b975..35e3c41eb517 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -921,6 +921,7 @@ void dax_delete_mapping_range(struct address_space *mapping,
>  	}
>  	xas_unlock_irq(&xas);
>  }
> +EXPORT_SYMBOL_GPL(dax_delete_mapping_range);
>    static int wait_page_idle(struct page *page,
>  			void (cb)(struct inode *),
> @@ -961,6 +962,7 @@ int dax_break_mapping(struct inode *inode, loff_t start, loff_t end,
>    	return error;
>  }
> +EXPORT_SYMBOL_GPL(dax_break_mapping);
>    void dax_break_mapping_uninterruptible(struct inode *inode,
>  				void (cb)(struct inode *))
> @@ -979,6 +981,7 @@ void dax_break_mapping_uninterruptible(struct inode *inode,
>  	if (!page)
>  		dax_delete_mapping_range(inode->i_mapping, 0, LLONG_MAX);
>  }
> +EXPORT_SYMBOL_GPL(dax_break_mapping_uninterruptible);
>    /*
>   * Invalidate DAX entry if it is clean.
>
>
> thanks,
> John Hubbard
>
>
>> +
>>   /*
>>    * Invalidate DAX entry if it is clean.
>>    */
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index cf87c5b..d42c011 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -3885,15 +3885,7 @@ int ext4_break_layouts(struct inode *inode)
>>   	if (WARN_ON_ONCE(!rwsem_is_locked(&inode->i_mapping->invalidate_lock)))
>>   		return -EINVAL;
>>   -	do {
>> -		page = dax_layout_busy_page(inode->i_mapping);
>> -		if (!page)
>> -			return 0;
>> -
>> -		error = dax_wait_page_idle(page, ext4_wait_dax_page, inode);
>> -	} while (error == 0);
>> -
>> -	return error;
>> +	return dax_break_mapping_inode(inode, ext4_wait_dax_page);
>>   }
>>     /*
>> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
>> index af436b5..2493f9c 100644
>> --- a/fs/fuse/dax.c
>> +++ b/fs/fuse/dax.c
>> @@ -665,38 +665,19 @@ static void fuse_wait_dax_page(struct inode *inode)
>>   	filemap_invalidate_lock(inode->i_mapping);
>>   }
>>   -/* Should be called with mapping->invalidate_lock held
>> exclusively */
>> -static int __fuse_dax_break_layouts(struct inode *inode, bool *retry,
>> -				    loff_t start, loff_t end)
>> -{
>> -	struct page *page;
>> -
>> -	page = dax_layout_busy_page_range(inode->i_mapping, start, end);
>> -	if (!page)
>> -		return 0;
>> -
>> -	*retry = true;
>> -	return dax_wait_page_idle(page, fuse_wait_dax_page, inode);
>> -}
>> -
>> -/* dmap_end == 0 leads to unmapping of whole file */
>> +/* Should be called with mapping->invalidate_lock held exclusively.
>> + * dmap_end == 0 leads to unmapping of whole file.
>> + */
>>   int fuse_dax_break_layouts(struct inode *inode, u64 dmap_start,
>>   				  u64 dmap_end)
>>   {
>> -	bool	retry;
>> -	int	ret;
>> -
>> -	do {
>> -		retry = false;
>> -		ret = __fuse_dax_break_layouts(inode, &retry, dmap_start,
>> -					       dmap_end);
>> -	} while (ret == 0 && retry);
>>   	if (!dmap_end) {
>>   		dmap_start = 0;
>>   		dmap_end = LLONG_MAX;
>>   	}
>>   -	return ret;
>> +	return dax_break_mapping(inode, dmap_start, dmap_end,
>> +				fuse_wait_dax_page);
>>   }
>>     ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter
>> *to)
>> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
>> index eb12123..120597a 100644
>> --- a/fs/xfs/xfs_inode.c
>> +++ b/fs/xfs/xfs_inode.c
>> @@ -2704,21 +2704,17 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
>>   	struct xfs_inode	*ip2)
>>   {
>>   	int			error;
>> -	bool			retry;
>>   	struct page		*page;
>>     	if (ip1->i_ino > ip2->i_ino)
>>   		swap(ip1, ip2);
>>     again:
>> -	retry = false;
>>   	/* Lock the first inode */
>>   	xfs_ilock(ip1, XFS_MMAPLOCK_EXCL);
>> -	error = xfs_break_dax_layouts(VFS_I(ip1), &retry);
>> -	if (error || retry) {
>> +	error = xfs_break_dax_layouts(VFS_I(ip1));
>> +	if (error) {
>>   		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
>> -		if (error == 0 && retry)
>> -			goto again;
>>   		return error;
>>   	}
>>   @@ -2977,19 +2973,11 @@ xfs_wait_dax_page(
>>     int
>>   xfs_break_dax_layouts(
>> -	struct inode		*inode,
>> -	bool			*retry)
>> +	struct inode		*inode)
>>   {
>> -	struct page		*page;
>> -
>>   	xfs_assert_ilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL);
>>   -	page = dax_layout_busy_page(inode->i_mapping);
>> -	if (!page)
>> -		return 0;
>> -
>> -	*retry = true;
>> -	return dax_wait_page_idle(page, xfs_wait_dax_page, inode);
>> +	return dax_break_mapping_inode(inode, xfs_wait_dax_page);
>>   }
>>     int
>> @@ -3007,8 +2995,7 @@ xfs_break_layouts(
>>   		retry = false;
>>   		switch (reason) {
>>   		case BREAK_UNMAP:
>> -			error = xfs_break_dax_layouts(inode, &retry);
>> -			if (error || retry)
>> +			if (xfs_break_dax_layouts(inode))
>>   				break;
>>   			fallthrough;
>>   		case BREAK_WRITE:
>> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
>> index 97ed912..0db27ba 100644
>> --- a/fs/xfs/xfs_inode.h
>> +++ b/fs/xfs/xfs_inode.h
>> @@ -564,7 +564,7 @@ xfs_itruncate_extents(
>>   	return xfs_itruncate_extents_flags(tpp, ip, whichfork, new_size, 0);
>>   }
>>   -int	xfs_break_dax_layouts(struct inode *inode, bool
>> *retry);
>> +int	xfs_break_dax_layouts(struct inode *inode);
>>   int	xfs_break_layouts(struct inode *inode, uint *iolock,
>>   		enum layout_break_reason reason);
>>   diff --git a/include/linux/dax.h b/include/linux/dax.h
>> index 773dfc4..7419c88 100644
>> --- a/include/linux/dax.h
>> +++ b/include/linux/dax.h
>> @@ -257,6 +257,13 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
>>   int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
>>   int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
>>   				      pgoff_t index);
>> +int __must_check dax_break_mapping(struct inode *inode, loff_t start,
>> +				loff_t end, void (cb)(struct inode *));
>> +static inline int __must_check dax_break_mapping_inode(struct inode *inode,
>> +						void (cb)(struct inode *))
>> +{
>> +	return dax_break_mapping(inode, 0, LLONG_MAX, cb);
>> +}
>>   int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
>>   				  struct inode *dest, loff_t destoff,
>>   				  loff_t len, bool *is_same,


