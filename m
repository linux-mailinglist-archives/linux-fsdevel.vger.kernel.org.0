Return-Path: <linux-fsdevel+bounces-68485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA4AC5D2A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 13:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD9B9340665
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 12:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5571F1C3C18;
	Fri, 14 Nov 2025 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="koBNVvwW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011017.outbound.protection.outlook.com [52.101.52.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70F4176ADE
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763124229; cv=fail; b=cB30pOfzojwizKFT38vLOOOZ75wGMhe0zd5W8I9KUZHFyU2YCUDWU3/987IlW0mrx0OFmoe4WEd3IpA9fJE/BFark4N/CvnpEjpdV+X61gjtxZ3hGZp8QqB7OotUamnilc3GIwzyg43xp1HfvHw7+HdH/iP02ah5lWtFa1iGfK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763124229; c=relaxed/simple;
	bh=QXW+3G0AlkaenNoCRSxdDX7mh27RkxvYKNN6Jma5/DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XswbCJqsHFC1Xl857KOVlUxb2IIEgGJODlkFcDJD2lKdpP3Xh5lHmQka7yXcSyRrWUdfXpSNgKZ1xinaEt5XzoTo1s4tG8Ec8RnRhIkhz/dQnQQHnIXijHHJadPq80Gh2MjAO+dMovuVxV5zBAVpdS+GL8lZYbL73SfdLzf0aBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=koBNVvwW; arc=fail smtp.client-ip=52.101.52.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7Es9Ibalw/ZKh0Pg0IRkUHUK4ble3N6gorG4u/iA+XpTVmgNLcDycvm9gCbVCqR1+UZZ3BdCV2g+G5Oup/rR7uqEKuNsN7UuoZvVUUu+wpvLA2grgv0TulfUGwA/xbQ7R+4WD1Ls1ZEQF3zJnPlSREUQn325YYn2gzL9Out3j6Ev6kaTYxO1FqAxAqlT51l0v7zjgY+h+2oFWOQzmwF6DcDQN2Hr86Uv/p+gFfhGrELUTeB7vX1kKN8S75wE3wqO7pX84/jaPNb3j83laQIWwnets1gW+phdB+xOdus2Wk8Ilr9kcXTeCJ+Hb8W3RJHebCjK51EqdGzrtJNQMLApQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5gBaDGWYK0KQmqhkwuY+4noGkZh3B9JWAdlNKNIj/I=;
 b=B8VEkaKv6C8sk4j0tbNSuJu9pYrf3nZh0X6yF+/PYY1uPnVRmCeQhFz5IAbsHFayahgAKVSFAHn2LmC88/fc8nMUhKxugO279xUDzU8bOPEjXn5uKHGMjjHzHBcvsP4nCA43l7XZ1jj6y60e6PuXH4wb9omMta9LBHlP0groVnJYI6xDVOLVpKkSSHWGXXZW4KxWQAH2fO2CiRK7DwBuVcrxwyg4HhjwasM9tbFTY+SNF/YX79rSHRJjvlDlI56NV9y1mKjzjXt8SDiAWDOB9yZPSLKmZunqCeLMkAGm11oTGTq6qmfpFpj6WgMb3dvWS0D5z3c4bkp0Z6tf9N6jVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5gBaDGWYK0KQmqhkwuY+4noGkZh3B9JWAdlNKNIj/I=;
 b=koBNVvwWIBhlhC43xO4BzD+JtwXjgybEfaJ76zOQ71rX3dAfzlcAwprlF4zK2wvLTmCKG5icwCZPQibJ67OSxwfuwyz4zOGvnp804NU7S9VytumQiIcL6cJVrL4YEoTXjqEahLEgQnNcj59sphrTGrY60aPUh5EcWxb7BKxoSmXB3525Fbn2Vl3Yo5GlHILModVXAPX1FDPqcC3jLxz8mtr+bjEwPJp9VbU+hi8Ns1Q17ILRSJe0kZWUmSkoLY+VxyxpHb95Fzb5yE7XhRYpZr44PQbEtVfhOBOwumA0E9Det8rRLkFS+7r8B1g+dt9rabiI04ooEN7d+/OyVek/Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.18; Fri, 14 Nov 2025 12:43:42 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 12:43:42 +0000
From: Zi Yan <ziy@nvidia.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>,
 Wei Yang <richard.weiyang@gmail.com>
Cc: willy@infradead.org, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/huge_memory: consolidate order-related checks into
 folio_split_supported()
Date: Fri, 14 Nov 2025 07:43:38 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <01FABE3A-AD4E-4A09-B971-C89503A848DF@nvidia.com>
In-Reply-To: <827fd8d8-c327-4867-9693-ec06cded55a9@kernel.org>
References: <20251114075703.10434-1-richard.weiyang@gmail.com>
 <827fd8d8-c327-4867-9693-ec06cded55a9@kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: IA4P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::6) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM6PR12MB4075:EE_
X-MS-Office365-Filtering-Correlation-Id: 646f7fe6-5451-4a88-2abc-08de237b712e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1SxxzyuZloIvdfW9bTEo6JnCl5cbNdqnnDM8LVavs+VjB8rny+DBI0BchwAB?=
 =?us-ascii?Q?CREw06TV7+MiDSFg7lJsH+oywHF7oSxbsKe3mOUrll1V2E9SpYC+mwPwjYKO?=
 =?us-ascii?Q?94J+PUZtSG9PXg+xpLU4BCTrJFHYJGVfEOTvz1T3vJ5yvBwtZ4cI2kePKRzX?=
 =?us-ascii?Q?5hZ8tyL0RstG92rctNzWrIgofbB9mjCKU4yydguoiq0DXbul0txGhRtfDMdb?=
 =?us-ascii?Q?Fostl4f4iRVXQUG00x8PBzjEJ2s+mV/Qb4ISoesuKZnwDtVkZoEQHdrYlSzR?=
 =?us-ascii?Q?u0A84AWahDmvo1pZa8yTGNuZpMP49MI26C02M6QKS/mH8JaVQFng0TnvsCPE?=
 =?us-ascii?Q?Am7J80Nv8jQDY6ZXeikTpAVAGnrDh83aHFz43Umbb/EE7nFoIFmTvA7uT4eW?=
 =?us-ascii?Q?Uzf0SAy+kUDpn3HSRt7QljXOGG5REWhZPEr3hTxRZ9Guy4gnBdXurq3m5P6Z?=
 =?us-ascii?Q?aZy7LT21uYKM/w+yX3N/iu41R5WSqjUAuID+aYPS505qVflxJW8rZghjRpLS?=
 =?us-ascii?Q?leirEYNr93onatcCvJ6tB/hFCKK5RgPHqCkW2oIZHdEfss7N5+A9yta/FYmO?=
 =?us-ascii?Q?wa+6LvWVTkcJsTH+BF0AeD7gBuoDecdYRWAJczv5hWh0c7LL6xnleoOBlusq?=
 =?us-ascii?Q?8OoqrOlGj77KpClW0xbzj8ZLx97pB1ZDGW7aqmWJ8eftpFxh3YRLZ5AG1qSF?=
 =?us-ascii?Q?SoCuua8Xrz2PBSI2CIIs9lTw+GLET83USRgrrQaOUp6jF2EG+6wl1lvslmQM?=
 =?us-ascii?Q?cmHh+bZ5xTp5PBuldIykb0WZx7XEwIXtww25tssbyQd81e/iWZ42pQ/rdD/N?=
 =?us-ascii?Q?WIipbQli1fb5WZu9D97zOzIQZFWd2krXKPDZ1zFhE0S44kkSbCfU+F/p0pjU?=
 =?us-ascii?Q?EyoDvFC/S9pMPB4yI6SfrbES62A8UqenRBhvsdQ2BQOAXGJiC6uy/V3CJkY0?=
 =?us-ascii?Q?/9bGPZ8UOppml0UJdhe07FLIMygAooycU+3AU0CqtFdDgsybG9rbHD84MMbk?=
 =?us-ascii?Q?rwIaCoBd/Memt2vmumZPqSr1JcskZeonQVz67r4JWONDLHY+0TsNsif0blE4?=
 =?us-ascii?Q?v1AsbobUIaJk7M+D14pvkP96PMliqjciHOO8jBMs/43Ii8SeDUbxE8ERTESr?=
 =?us-ascii?Q?pGVPlFChkIbEI1PlMArCxfWr7Xs0MGEELfAgPtQprP+iB89yxGpgljOeIxXh?=
 =?us-ascii?Q?uvk5PxlKmarfY2xYxbXCzsqK18umogz04wRwlUawzE/5VYl1qyECn7Y05ifD?=
 =?us-ascii?Q?3xpI9TlRByDO0ktwjnaOLwzx6Zib+SIIpN0fGYkcA+S7DK8QRHJWxI7Csm6T?=
 =?us-ascii?Q?wTrjRltS8kiPPlkdwoTpO7jQJ/1KBDOyJ6mdavm5qMg/grafkvu1x3FG8mwm?=
 =?us-ascii?Q?OBtnqRooBun7fw1r6F47JYS/Og9L7lg9BuCfRZrOKx3PiJB/wuf70IAb19Vo?=
 =?us-ascii?Q?GqPmeFPzhCR1B2XJmyiO+2WNDjd+3PyzrZsNfeF/uz+pifKFPKRhtQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZVtaoz4OUnz3J0i467ccX+oRqGR26uAzgzMW8mC5fitmpvdkSp5c8XR3+BSj?=
 =?us-ascii?Q?J2IOO0VeKrWXyZll9999SxMKOXpBDhBzVmlWAiOqsD5azCR/4lpg990UyF9g?=
 =?us-ascii?Q?fXN+NEvDVuC/gT4F0dz+HaRJf7mof6e+Pzt7KwdL4SkULX8ShRZv+tIW+ZHH?=
 =?us-ascii?Q?WJGLXDHMOoJ1yrxU81VHX1Xqk5pHwQB+ZDDyuRzvCpCg9knNUtpfjN2V0qIR?=
 =?us-ascii?Q?sEnNzjym8ZUtxN1ejEdQMlamlfcakqgclnNjQuLBmBI5ijK8aeA49HoO4BR2?=
 =?us-ascii?Q?WHoy2zazNrKlrE18dFg5i2MZgIQnw2gaQ5U4BJeverNK4uqCTfH0QDo3oqin?=
 =?us-ascii?Q?5O1B5sD0O4g4HROf9tRqI0/8/Auru+hTpT1xSdvhmQWL2+L6M2LYM1bXxx53?=
 =?us-ascii?Q?ZtB/Uox465sVbYENBmgX6RrE3OedINaFxPocNdJv19S5DmdR5E9g5LYXzEfB?=
 =?us-ascii?Q?Aaz6xCv6QYIYJHMd/9IqqayqTDH3tvKwwO9PCJH/Mpccd0depCUoLgwmI2QZ?=
 =?us-ascii?Q?qs0CbCQLZTz+wQUxTTv1RroeR4qEsB0VwcDI04zf3A61RTJ+jm2fmWU7ZRP1?=
 =?us-ascii?Q?Uf7lQPrfkqRNp752hPZd+Vwi43dlhYphuK2PNv9oiOIROvjbVr5S9QBUMJwW?=
 =?us-ascii?Q?XyZ2BKkaOdTcUE0uFvghnYCG0/JSP5XK7TnzhZJe5hHDyKpPZfq8lw3smNHq?=
 =?us-ascii?Q?03piZp/ew3MeYMnOMg7h/uRVUYZVdHZ+BY2wZgc3FgTNKqvhcjknp8w39Vva?=
 =?us-ascii?Q?YxHiCWyp/6KWdn3/4zyZOr9VqxW7DIu22FRH1JJEa67CL0wvjLQEuPMbfVHm?=
 =?us-ascii?Q?GV8Rig9Vmrm5bXQId8foP6JQlEBuorawu1QM1vUFEiVECjJwE16EDHU+G9jw?=
 =?us-ascii?Q?YTrEDxP/cMg6KLKkul9P8PG7oX/sfBMgrjJ2RGf1BIP9gOVqDGn/R7XxX14F?=
 =?us-ascii?Q?4WzT1Og6EY7oGmCDF7GczNZAWgdKGAc1yuPTAbyevmTy/C5Vq2Z4lw8n+UyF?=
 =?us-ascii?Q?HPC9BnRS3bGCApFMPLzFoG4XErDXGvav/XyYSQRFXqnpf5tF4/mwqEPAeJum?=
 =?us-ascii?Q?GHZNyJrZgRZBT7v/csnv0ydqoAoFNTkmAcnvww2WxyoUu2KGfVkiU5xy4Z6m?=
 =?us-ascii?Q?SCadHl8S7cJ/Y4QMz6rEkJm1yHqa4zmuKZRFY38HQdjURiP0bwRdH4U54KUD?=
 =?us-ascii?Q?L1kVWw3oPlNqpuzYv4zdH7mvXgeMqfVQ2xto1giiNi291cSNhmd+/gUuvB7H?=
 =?us-ascii?Q?qp6mttmlH8vJDt7Yc7yVy4K030herbXAVPIdZ2vpVeheS2W81Q4Dd+HMs0Vq?=
 =?us-ascii?Q?xmq4eEKGo6VO6FzUTyurIaRhSQ8Kw4MC6ap2zn3kebccNIyVdbY/BnP6c/FX?=
 =?us-ascii?Q?pA0AkBWVwwSCcZ9ospAZSSw3/kQ62sE1oB49Kz7hhoW6pRiU98tbBk6EgWfS?=
 =?us-ascii?Q?24XvWOnjN42khnGrLEjLmVh+0Et8Cfvpd0Xjpicty6UbPTQKi+ux8EMKMNhO?=
 =?us-ascii?Q?w737XmcKX9jbUoGazDQYfWj4hjJtYvtci4uX1ml9CXJQNVRYu6yZEZpDeQKl?=
 =?us-ascii?Q?xP6eBHLSGu/GkWjbg5EbhOIACuTH74eiyyrbqMt1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 646f7fe6-5451-4a88-2abc-08de237b712e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 12:43:42.1145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXmLx41lGO4ZQ6bmHnQXi0IpjSoUyq4YGCqUecZaYJ3/capNdfHq/SpyDdcrYfVc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075

On 14 Nov 2025, at 3:49, David Hildenbrand (Red Hat) wrote:

> On 14.11.25 08:57, Wei Yang wrote:
>> The primary goal of the folio_split_supported() function is to validat=
e
>> whether a folio is suitable for splitting and to bail out early if it =
is
>> not.
>>
>> Currently, some order-related checks are scattered throughout the
>> calling code rather than being centralized in folio_split_supported().=

>>
>> This commit moves all remaining order-related validation logic into
>> folio_split_supported(). This consolidation ensures that the function
>> serves its intended purpose as a single point of failure and improves
>> the clarity and maintainability of the surrounding code.
>
> Combining the EINVAL handling sounds reasonable.
>
>>
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> ---
>>   include/linux/pagemap.h |  6 +++
>>   mm/huge_memory.c        | 88 +++++++++++++++++++++------------------=
--
>>   2 files changed, 51 insertions(+), 43 deletions(-)
>>
>> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
>> index 09b581c1d878..d8c8df629b90 100644
>> --- a/include/linux/pagemap.h
>> +++ b/include/linux/pagemap.h
>> @@ -516,6 +516,12 @@ static inline bool mapping_large_folio_support(co=
nst struct address_space *mappi
>>   	return mapping_max_folio_order(mapping) > 0;
>>   }
>>  +static inline bool
>> +mapping_folio_order_supported(const struct address_space *mapping, un=
signed int order)
>> +{
>> +	return (order >=3D mapping_min_folio_order(mapping) && order <=3D ma=
pping_max_folio_order(mapping));
>> +}
>
> (unnecessary () and unnecessary long line)
>
> Style in the file seems to want:
>
> static inline bool mapping_folio_order_supported(const struct address_s=
pace *mapping,
> 						 unsigned int order)
> {
> 	return order >=3D mapping_min_folio_order(mapping) &&
> 	       order <=3D mapping_max_folio_order(mapping);
> }
>
>
> The mapping_max_folio_order() check is new now. What is the default val=
ue of that? Is it always initialized properly?
>
>> +
>>   /* Return the maximum folio size for this pagecache mapping, in byte=
s. */
>>   static inline size_t mapping_max_folio_size(const struct address_spa=
ce *mapping)
>>   {
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 0184cd915f44..68faac843527 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3690,34 +3690,58 @@ static int __split_unmapped_folio(struct folio=
 *folio, int new_order,
>>   bool folio_split_supported(struct folio *folio, unsigned int new_ord=
er,
>>   		enum split_type split_type, bool warns)
>>   {
>> +	const int old_order =3D folio_order(folio);
>
> While at it, make it "unsigned int" like new_order.
>
>> +
>> +	if (new_order >=3D old_order)
>> +		return -EINVAL;
>> +
>>   	if (folio_test_anon(folio)) {
>>   		/* order-1 is not supported for anonymous THP. */
>>   		VM_WARN_ONCE(warns && new_order =3D=3D 1,
>>   				"Cannot split to order-1 folio");
>>   		if (new_order =3D=3D 1)
>>   			return false;
>> -	} else if (split_type =3D=3D SPLIT_TYPE_NON_UNIFORM || new_order) {
>> -		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>> -		    !mapping_large_folio_support(folio->mapping)) {
>> -			/*
>> -			 * We can always split a folio down to a single page
>> -			 * (new_order =3D=3D 0) uniformly.
>> -			 *
>> -			 * For any other scenario
>> -			 *   a) uniform split targeting a large folio
>> -			 *      (new_order > 0)
>> -			 *   b) any non-uniform split
>> -			 * we must confirm that the file system supports large
>> -			 * folios.
>> -			 *
>> -			 * Note that we might still have THPs in such
>> -			 * mappings, which is created from khugepaged when
>> -			 * CONFIG_READ_ONLY_THP_FOR_FS is enabled. But in that
>> -			 * case, the mapping does not actually support large
>> -			 * folios properly.
>> -			 */
>> +	} else {
>> +		const struct address_space *mapping =3D NULL;
>> +
>> +		mapping =3D folio->mapping;
>
> const struct address_space *mapping =3D folio->mapping;
>
>> +
>> +		/* Truncated ? */
>> +		/*
>> +		 * TODO: add support for large shmem folio in swap cache.
>> +		 * When shmem is in swap cache, mapping is NULL and
>> +		 * folio_test_swapcache() is true.
>> +		 */
>> +		if (!mapping)
>> +			return false;
>> +
>> +		/*
>> +		 * We have two types of split:
>> +		 *
>> +		 *   a) uniform split: split folio directly to new_order.
>> +		 *   b) non-uniform split: create after-split folios with
>> +		 *      orders from (old_order - 1) to new_order.
>> +		 *
>> +		 * For file system, we encodes it supported folio order in
>> +		 * mapping->flags, which could be checked by
>> +		 * mapping_folio_order_supported().
>> +		 *
>> +		 * With these knowledge, we can know whether folio support
>> +		 * split to new_order by:
>> +		 *
>> +		 *   1. check new_order is supported first
>> +		 *   2. check (old_order - 1) is supported if
>> +		 *      SPLIT_TYPE_NON_UNIFORM
>> +		 */
>> +		if (!mapping_folio_order_supported(mapping, new_order)) {
>> +			VM_WARN_ONCE(warns,
>> +				"Cannot split file folio to unsupported order: %d", new_order);
>
> Is that really worth a VM_WARN_ONCE? We didn't have that previously IIU=
C, we would only return
> -EINVAL.

No, and it causes undesired warning when LBS folio is enabled. I explicit=
ly
removed this warning one month ago in the LBS related patch[1].

It is so frustrating to see this part of patch. Wei has RB in the aforeme=
ntioned
patch and still add this warning blindly. I am not sure if Wei understand=
s
what he is doing, since he threw the idea to me and I told him to just
move the code without changing the logic, but he insisted doing it in his=

own way and failed[2]. This retry is still wrong.

Wei, please make sure you understand the code before sending any patch.

[1] https://lore.kernel.org/linux-mm/20251017013630.139907-1-ziy@nvidia.c=
om/
[2] https://lore.kernel.org/linux-mm/20251114030301.hkestzrk534ik7q4@mast=
er/

Best Regards,
Yan, Zi

