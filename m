Return-Path: <linux-fsdevel+bounces-13508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DF3870981
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243701F2675E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 18:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32370626B9;
	Mon,  4 Mar 2024 18:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i+PgpFr+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49AE6167A;
	Mon,  4 Mar 2024 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709576814; cv=fail; b=QHqEVKJG+bHuLm2zY6Lv0PWui0BLsXnb6VuEv0hzeCVdBTpjOV02v0fv9XCqeeNmbKa+EZvMB5V5hCQFDgz9nU7rk3gn5PHUCb6ORzkrgInV4oKDcfDMjEBbvF0DnqfOK4P/aVmZ2MugN4ousyNIc/CGW4yL/LB+gcjP/nppW8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709576814; c=relaxed/simple;
	bh=htn3LfeQuWPfGjfd6qik7gao/OgCkdRh0BMTsfmZB6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a8k2WOBHp4/ec+5c4M2MvhKmiJPK6yKZLz6XHbDu/l0n8FbJEn6s6hf+5nJCZM1JwziJcnAKtwWWET/PcDA6CgsrhXYtpbT0HFUk7j7LUZl8th8uJW6YLHbKoYT9Q6GRizAuqkqXzLXoM9IuVcDGJK7SkeaBUFwqKe3wan1gAos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i+PgpFr+; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZ/rRJuNHJbFd6LHt9vhA98rzmMVSCYiP8p4OV1mr1VpLkUJYLWBwxnr554rYhtK0Sr+oGoXYCixH63WN/3CWU8tyJ4rrv4SA9LRw4BcFRaYly1smVI68LLes2eSiJ+cgbLYXl3QpdMq775dCR56/04gNpiYW3Zd2+nqB/CQqsfNa7vmDwMbL0SqXpLMJFbGL1SHcwG06wVuTQMo0+MnVZvmWK1Bym1Wyl19cjm45dKYWH+QmYpmWH4ut1oLE0x3ijDqpT7xQFz3cTx9N/0+5cY5i55xtZFe09r0GjxeuVtasu8sRRi8bL7cutriTGQ5rP1mV0owxKCN0seimYuTdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h37fuqu/5whHe+oiisa2VjcWfgARURC8xc4uWLmzLGs=;
 b=aeFgUm/z9289cWf9ucH1wSUoeLlukgGQbrkQ7Ql7xztssn50dTY70aLN+5mO+c18K3rk3VYBTI6LpPiqKdqw047xTRbdWXBf/hAIN/ob1Hza51l3YbIYEFfVcjpFBemJZZWlmqRXY93g9HnYZIWWtYC4jnL6uD4EEDRFQj+24rp+yTc9UOSBAa/9xPvVm4SjOfPDfR1RKIHQpa9SM9fwoqj2fV22KcSYhdAKqHyAd84XZXWLuhseyDjmM76FMcNzJCdxPlwPj8+y7EZupLmlfUmxcQwlVrZinR49FmILc6cgF1ihB2XKN+Sxf/KykqM89BUZOWZAafc/X6BcutXp/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h37fuqu/5whHe+oiisa2VjcWfgARURC8xc4uWLmzLGs=;
 b=i+PgpFr+Yga/FneqLHmZ2JSs9XzSP48qjPrCQIrDF6FDWfUzTX2zV5YlD6xumhLJ8QqYxu/ZWdOPgIqzA2kiK0iiUkc0i+08uMkp1DmFrH+urlijrHQ2PUeZgscKlKCw0IXQXBqFUtnFgckd2Y3LS3vgK0L+C1q9sUAQC2acWe3VNcLogThI6fO1RRiTqu2vLaHqYzq1tjx9z2Zx/IRPN2pRnGtBwJi/gcFsIEsgkM6lgdg5j71yulBtomlNsjf39EvKIZLC/5Ex1eeo4/TZhvy03i+ty/htv4paGObT/jU2Du0P9+/zDmsxnMRrPksD5DmhVihZ22X6CzyIwLiFOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ0PR12MB6877.namprd12.prod.outlook.com (2603:10b6:a03:47f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 18:26:42 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 18:26:42 +0000
From: Zi Yan <ziy@nvidia.com>
To: Aishwarya TCV <aishwarya.tcv@arm.com>
Cc: "\"Pankaj Raghav (Samsung)\"" <kernel@pankajraghav.com>,
 linux-mm@kvack.org, "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>,
 Yu Zhao <yuzhao@google.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 =?utf-8?q?=22Michal_Koutn=C3=BD=22?= <mkoutny@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 "\"Zach O'Keefe\"" <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 8/8] mm: huge_memory: enable debugfs to split huge
 pages to any order.
Date: Mon, 04 Mar 2024 13:26:39 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <57259BE4-D4A1-4F57-8AEA-DE526C43DE44@nvidia.com>
In-Reply-To: <ade0aded-a0c8-42a4-8543-1affbaff3908@arm.com>
References: <20240226205534.1603748-1-zi.yan@sent.com>
 <20240226205534.1603748-9-zi.yan@sent.com>
 <082e48c8-71b7-4937-a5da-7a37b4be16ba@arm.com>
 <A111EB95-0AF5-4715-82A4-70B8AD900A93@nvidia.com>
 <7E498B77-6CC9-4FC6-B980-D79EEC548CD0@nvidia.com>
 <0685EC19-CDB8-4CD3-BC39-82DE59B5D10C@nvidia.com>
 <0be630f0-ce8e-4a80-b42f-697ea603cfc6@arm.com>
 <1829EABB-7966-4686-A5E0-F6B6D26C510E@nvidia.com>
 <bd51b366-60b3-4ca5-9634-95dfbc3d1829@arm.com>
 <262E4DAA-4A78-4328-B745-1355AE356A07@nvidia.com>
 <ade0aded-a0c8-42a4-8543-1affbaff3908@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_E5E5A8A4-7C92-4653-8D20-03BD63343251_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR18CA0016.namprd18.prod.outlook.com
 (2603:10b6:208:23c::21) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ0PR12MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: 2303673d-9cf0-4d40-2172-08dc3c78a3d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LwYNN7ECN/B/2PCJp3yQnh9vMRJTD9DpTksp2CnwqrBaUvhgm+j/k0uQhTyRN4M1h1a0YOwPLjSVsrJ+Xx69gM8dt8w7qCkMvV4IJT7ZqdTQvvI4BO1xoXijkLIxPMWul8uJfCOwADylHb8/2uVJZo1Il4qT8ETLn1Qeoh0+aqx4WBBv/YBVUaZa4RO8FUFrbYKRqXClzZzXezBsMwSlTj/82IPD+jTe8PH6vUxTnzexKj0xbfE6vZESwdDni2aUmBRzUemOPL7xo9QOOoz9Y+OeaDAAP9kh+qPB8tO+zAgXaQwiihfIxzscjJxpIRBzK1DkyC4OlTJ/pE7pC8TnHZSDNIX583PpX+u0vCRsZnYcbCl1aTEW7sN4BVjFm9RJv16NJXZ2hjWvlgnCJri9vrcl4iJ1Kc5WRDiQlPgFFSmwYzZZHhBP8LlfWQJue0jbag7lEsmL3WzUT79Jb0VkvRQ51D0yFIIrW7knfBkBU5CPP9sfu9popnIbNwUFl9cf62LITWu4Ot/EYK+7TDgHKswnOLxX48B9dfuBhRp3+ZCRDoX6/C2gTEVWTtmWVz+WqzwQc0oAqOe+j28gwSpk4qIa3ucWKvSZJ59G4QVKQUfXQ1NLzDIWLeOEsbR3XzUuBbtUhmR6o1BRXyYPYKcd8fPzR2Mr5MC6JWpBH1PjAxQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CMI6wBshyCewdRLLr7SStUuSlyQlityED7d+2i3SDQ7JQRN5szbPDh0XeOOu?=
 =?us-ascii?Q?lEGSePL9/t7fsMHFJ5J8jiXeATGttcczR00iuGlWBhg9Ks4N6rbGfekV7LH+?=
 =?us-ascii?Q?Laozk+PFqaxhQ1h5QztxXNQhSvdBdUCs8Sieq6BbvfxqZUv5PkHBA2mOfusc?=
 =?us-ascii?Q?GQl0CDgaSLnf280/Q9xwpof8x/4hfY6UTmFpWL/3T5maT39Zy3k3VX+Mv11A?=
 =?us-ascii?Q?nLG57JOtHdSLDiuSso9LCa+O9p3rpf2dvGHUsuwuoUx0i2Uwqkf96fSuQRSZ?=
 =?us-ascii?Q?vbkSPAYKyXqZ4ovhZskn9yH/8hwoQ3ShLVTQ1Yh/2b1gZ6U0U44Ic+HCjrfh?=
 =?us-ascii?Q?mSf6dn/ZcQVGGs3+z6TvQmu54EUl+uFh6Sl/5ILm7XkMEsgF1WekE4bJG1sq?=
 =?us-ascii?Q?KQZqo5VSWQVNpuM/NszeCSNI4EvP8xwTgf6pc/ju+AWJfVfqjaoJ2PqRKFYi?=
 =?us-ascii?Q?Y21SvgR30wZz4VplUvzGNQMdA7I4dHMwG1BuKCZgPp3wy8+thS1LvoMBwpYg?=
 =?us-ascii?Q?0VMDjbIzah9l1el0PbNsOTot1NBLljZIogvfLcRv78VnCmMYdx2P+tbm6+Gz?=
 =?us-ascii?Q?tDxu8h4shrc1n1t2XWBrIm9ceEwKjvxTIfAxuH3P0zYNxqHMEqNwlXKSWBgE?=
 =?us-ascii?Q?clEtHoMQlBT6yDa1MD8mKX2K/8NKUwUUuJtzeZGkHVGa8+6l/RW1JxwFv+uo?=
 =?us-ascii?Q?cXVB5eF5YtdSDvYTImT8xPF3NtFRe4qBl8eOjTXZkun1H8MZYaXgKSnk1CaN?=
 =?us-ascii?Q?PaRYdtkTuDgdNbkFaHfZG1bz8HlA9hG/yY40lJhNvQi6BnrwsUXJjzZ/z+aK?=
 =?us-ascii?Q?heUGL8xo1P8GMw62hn4szqLbbwZRWNV1S/yOLwDSmtiTs12pWP5+6vIjQN68?=
 =?us-ascii?Q?mjP1lFq0pRWrUy6q4pkBLZYz6KBA5RgRM9JYjlo4NI66xzkXBOpgkE66lN41?=
 =?us-ascii?Q?sYBY6fYD6ZaKB3LDPE96fN13Mvq3nBqy8oArgnwauzxyexQWeLkZnibJFrQ4?=
 =?us-ascii?Q?GdidETnhiYG7iKe/pEqePzO3dxlR5j8FZ4+pkrgpRnJbq+3NKAJxMMbNBFXk?=
 =?us-ascii?Q?17jKhDvWBgtBwi0hfqzU+y83nYL47DeyoBIIUb/jhK+2A3Amnt+fWkI7+Okc?=
 =?us-ascii?Q?Ay75V3MontnFZ+Nve/Yp/5UaCg6FFr9wvxitZXNHpif3MUNxaVaNoVFVu1/b?=
 =?us-ascii?Q?0fFVfkh7OIKTibgQSxpBXo6oHBTE5A8UW+Y3LUo6Sq80sgwhJIofZUtUi5m1?=
 =?us-ascii?Q?eH8udUYAGIVzf9vgEG32isFRk3xIyZcv3LiRbGHMiv+aFm7IVnxRIDxnXn10?=
 =?us-ascii?Q?YZBcB67c+P7WC2sshFGFd4UzXh4ed49ghXdkYFmR98SribKk3IRDaSG3/pO1?=
 =?us-ascii?Q?EOCOt5OZEmBuQ0Y/C9ZUVST7MnB7FGufxoZpixMDL50rEuUCRLc5KvDiWwTe?=
 =?us-ascii?Q?vrBTSwwYJPzhdI3jH7RXJEvG2Iaxw3ZHCNKFkkzuW0iKPEo3Zteh1osLlCmE?=
 =?us-ascii?Q?qkj/Xu1Xqj35N5BYMaQXwvCCKZU3gesq2wuPAoP/gC8KGCwEXrvMslYlOO9w?=
 =?us-ascii?Q?PFu9PS0Fgf9S5JOB30g=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2303673d-9cf0-4d40-2172-08dc3c78a3d9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 18:26:42.3756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6SMMn4+8JbqZC50STWUYADQAal59ialibydfqzMuADAEMQhOVp3EeuRoGzwUwiT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6877

--=_MailMate_E5E5A8A4-7C92-4653-8D20-03BD63343251_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 4 Mar 2024, at 13:25, Aishwarya TCV wrote:

> On 04/03/2024 15:57, Zi Yan wrote:
>> On 4 Mar 2024, at 10:44, Aishwarya TCV wrote:
>>
>>> On 04/03/2024 14:58, Zi Yan wrote:
>>>> On 4 Mar 2024, at 4:50, Aishwarya TCV wrote:
>>>>
>>>>> On 01/03/2024 21:10, Zi Yan wrote:
>>>>>> On 1 Mar 2024, at 15:02, Zi Yan wrote:
>>>>>>
>>>>>>> On 1 Mar 2024, at 14:37, Zi Yan wrote:
>>>>>>>
>>>>>>>> On 1 Mar 2024, at 4:51, Aishwarya TCV wrote:
>>>>>>>>
>>>>>>>>> On 26/02/2024 20:55, Zi Yan wrote:
>>>>>>>>>> From: Zi Yan <ziy@nvidia.com>
>>>>>>>>>>
>>>>>>>>>> It is used to test split_huge_page_to_list_to_order for pageca=
che THPs.
>>>>>>>>>> Also add test cases for split_huge_page_to_list_to_order via b=
oth
>>>>>>>>>> debugfs.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>>>>>>> ---
>>>>>>>>>>  mm/huge_memory.c                              |  34 ++++--
>>>>>>>>>>  .../selftests/mm/split_huge_page_test.c       | 115 +++++++++=
++++++++-
>>>>>>>>>>  2 files changed, 131 insertions(+), 18 deletions(-)
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Hi Zi,
>>>>>>>>>
>>>>>>>>> When booting the kernel against next-master(20240228)with Arm64=
 on
>>>>>>>>> Marvell Thunder X2 (TX2), the kselftest-mm test 'split_huge_pag=
e_test'
>>>>>>>>> is failing in our CI (with rootfs over NFS). I can send the ful=
l logs if
>>>>>>>>> required.
>>>>>>>>>
>>>>>>>>> A bisect (full log below) identified this patch as introducing =
the
>>>>>>>>> failure. Bisected it on the tag "next-20240228" at repo
>>>>>>>>> "https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-nex=
t.git".
>>>>>>>>>
>>>>>>>>> This works fine on  Linux version 6.8.0-rc6
>>>>>>>>
>>>>>>>> Hi Aishwarya,
>>>>>>>>
>>>>>>>> Can you try the attached patch and see if it fixes the failure? =
I changed
>>>>>>>> the test to accept XFS dev as input, mount XFS on a temp folder =
under /tmp,
>>>>>>>> and skip if no XFS is mounted.
>>>>>>>
>>>>>>> Please try this updated one. It allows you to specify a XFS devic=
e path
>>>>>>> in SPLIT_HUGE_PAGE_TEST_XFS_PATH env variable, which is passed to=

>>>>>>> split_huge_page_test in run_vmtests.sh. It at least allow CI/CD t=
o run
>>>>>>> the test without too much change.
>>>>>>
>>>>>> OK. This hopefully will be my last churn. Now split_huge_page_test=
 accepts
>>>>>> a path that is backed by XFS and run_vmtest.sh creates a XFS image=
 in /tmp,
>>>>>> mounts it in /tmp, and gives the path to split_huge_page_test. I t=
ested
>>>>>> it locally and it works. Let me know if you have any issue. Thanks=
=2E
>>>>>>
>>>>>> --
>>>>>> Best Regards,
>>>>>> Yan, Zi
>>>>>
>>>>> Hi Zi,
>>>>>
>>>>> Tested the patch by applying it on next-20240304. Logs from our CI =
with
>>>>> rootfs over nfs is attached below. "Bail out! cannot remove tmp dir=
:
>>>>> Directory not empty" is still observed.
>>>>
>>>> Hi Aishwarya,
>>>>
>>>> Do you have the config file for the CI kernel? And /tmp is also on n=
fs?
>>>> Any detailed information about CI machine environment? I cannot repr=
oduce
>>>> the error locally, either on bare metal or VM. Maybe because my /tmp=
 is
>>>> not NFS mounted?
>>>>
>>>
>>> Hi Zi,
>>>
>>> Please find the details below. Hope it helps.
>>>
>>> Do you have the config file for the CI kernel?
>>> - We are using:
>>> defconfig+https://github.com/torvalds/linux/blob/master/tools/testing=
/selftests/mm/config
>>>
>>> And /tmp is also on nfs?
>>> - Yes
>>>
>>> Any detailed information about CI machine environment?
>>> - We are running the test using LAVA device Cavium Thunder X2 (TX2),
>>> - We have very similar rootfs as - nfsrootfs:
>>> https://storage.kernelci.org/images/rootfs/debian/bullseye-kselftest/=
20240129.0/arm64/full.rootfs.tar.xz
>>> - We are using grub boot method over nfs
>>> - Additionally Ryan mentioned "Looks like it is failing because he is=

>>> trying to delete the temp dir with rmdir() but rmdir() requires the
>>> directory to be empty, which it is not."
>>
>> Hi Aishwarya,
>>
>> Thank you for the information and I am able to reproduce it on a NFS f=
older.
>> The error comes from that the opened test files are not munmapped and =
their
>> file descriptors are not closed in the skip path. NFS creates .nfsXXX =
files
>> for them, making the temp folder not empty.
>>
>> The attached patch cleans up properly and works on a NFS folder. Let m=
e know
>> if it works on your side. Thanks.
>>
>> --
>> Best Regards,
>> Yan, Zi
>
> Hi Zi,
>
> Tested the attached patch on next-20240304. Confirming that the test is=

> running fine. Test run log is attached below.
>
> Test run log:
> # # ------------------------------
> # # running ./split_huge_page_test
> # # ------------------------------
> # # TAP version 13
> # # 1..12
> # # ok 1 Split huge pages successful
> # # ok 2 Split PTE-mapped huge pages successful
> # # # Please enable pr_debug in split_huge_pages_in_file() for more inf=
o.
> # # # Please check dmesg for more information
> # # ok 3 File-backed THP split test done
> <6>[ 1769.710429] split_huge_page (111119): drop_caches: 3
> <6>[ 1769.710429] split_huge_page (111119): drop_caches: 3
> # # # No large pagecache folio generated, please provide a filesystem
> supporting large folio
> # # ok 4 # SKIP Pagecache folio split skipped
> <6>[ 1775.302315] split_huge_page (111119): drop_caches: 3
> <6>[ 1775.302315] split_huge_page (111119): drop_caches: 3
> # # # No large pagecache folio generated, please provide a filesystem
> supporting large folio
> # # ok 5 # SKIP Pagecache folio split skipped
> <6>[ 1780.924147] split_huge_page (111119): drop_caches: 3
> <6>[ 1780.924147] split_huge_page (111119): drop_caches: 3
> # # # No large pagecache folio generated, please provide a filesystem
> supporting large folio
> # # ok 6 # SKIP Pagecache folio split skipped
> <6>[ 1786.524931] split_huge_page (111119): drop_caches: 3
> <6>[ 1786.524931] split_huge_page (111119): drop_caches: 3
> # # # No large pagecache folio generated, please provide a filesystem
> supporting large folio
> # # ok 7 # SKIP Pagecache folio split skipped
> <6>[ 1792.112869] split_huge_page (111119): drop_caches: 3
> <6>[ 1792.112869] split_huge_page (111119): drop_caches: 3
> # # # No large pagecache folio generated, please provide a filesystem
> supporting large folio
> # # ok 8 # SKIP Pagecache folio split skipped
> <6>[ 1797.718863] split_huge_page (111119): drop_caches: 3
> <6>[ 1797.718863] split_huge_page (111119): drop_caches: 3
> # # # No large pagecache folio generated, please provide a filesystem
> supporting large folio
> # # ok 9 # SKIP Pagecache folio split skipped
> <6>[ 1803.332343] split_huge_page (111119): drop_caches: 3
> <6>[ 1803.332343] split_huge_page (111119): drop_caches: 3
> # # # No large pagecache folio generated, please provide a filesystem
> supporting large folio
> # # ok 10 # SKIP Pagecache folio split skipped
> <6>[ 1808.947913] split_huge_page (111119): drop_caches: 3
> <6>[ 1808.947913] split_huge_page (111119): drop_caches: 3
> # # # No large pagecache folio generated, please provide a filesystem
> supporting large folio
> # # ok 11 # SKIP Pagecache folio split skipped
> <6>[ 1814.537995] split_huge_page (111119): drop_caches: 3
> <6>[ 1814.537995] split_huge_page (111119): drop_caches: 3
> # # # No large pagecache folio generated, please provide a filesystem
> supporting large folio
> # # ok 12 # SKIP Pagecache folio split skipped
> # # # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:9 error:0
> # # [PASS]
> # ok 51 split_huge_page_test
> # # -------------------

Thanks a lot for testing.

--
Best Regards,
Yan, Zi

--=_MailMate_E5E5A8A4-7C92-4653-8D20-03BD63343251_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXmEmAPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUUrUP+wRRySJoDp0RdWRxzdPSlOHu+PC36VohfmsD
+VRkaxsAxmX/wGxARkBiMXShaQSHgF+ziMhSCi7HR/19dHBNF5GWPT3ZYdcVvFWa
WJ57+aUDWlmaFrk9kBa4xVol7DGHjU+Xcf/TfzEWsAqZ+kOf8yp+gJdt9ILeyXd9
b9ItKDpiyyxRF81zkuTj0ApHrJWyi/S6pCkm2BeB6hRHv/mc0YMVTnm7eMDV6Xva
pGOhXHKe4v4c0H/uPvjvZQKBDXwC/A12TMrRDAt0xdXB5OUSGt7I3jDCBtwYk/Gf
7IYTC+mG9JIhjDcB5wA9xEjNxYw7CJPSRn/SOoJ4iy7ttcprraZWefkwGeN+Ga0o
oVLqoinfjhEQdYBXCcz3lyzenh6dhh8K2LSZNdcqxbSWtxgdlu0vYJt6Isyu7rmh
qu8mxK+BwkQVe3/qi5D7GZe3C/jUtreXrrbcmVdloml86PiQAdsUAQTHf2sW0KvR
QSIbONWTI4lCzhxCXuSkHuYnw3iRVZka2OXbGC3TbC5ko0Sfym96B6di9r7AMQgb
OYLYbP1/lCOq+Td5Ii7LUbZCxTzGJ7dLe9BJf1+Tk2CtnHIkDg5MgEIUK2olNbSc
Nbl8lCSGIExGi0nWBI8NgcwtaxjbF8VjgKapCxCWrxPw5oaJiuKZfApXhX/8+e1X
VBQX2AfJ
=ve7o
-----END PGP SIGNATURE-----

--=_MailMate_E5E5A8A4-7C92-4653-8D20-03BD63343251_=--

