Return-Path: <linux-fsdevel+bounces-37817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA9C9F7ED0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F3816A651
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 16:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BBB22687E;
	Thu, 19 Dec 2024 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SlJy0QHS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545B43D3B8
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734624160; cv=fail; b=H8D5yUHZrAn//SqyYqYx7wDEN2//1F/FMlFQuq2smDwMbp+2KakiW7+JLQUoL8nqjXm086u5Gu7xZoPtNgEbbBXi2bcL+bwsYTd6OOCyUcx45RciWk7QRgvfszhb8XX56Rldm+YXLIZsr04uu/RoA0+0776kLzjRgLhfk/bSLzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734624160; c=relaxed/simple;
	bh=zdmWu0+8rdZ3V58NsofQfN9TpfrCBXOxoyIsvxONzjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t5VaTHCHg/qkNUahy413JUNy0YoBjE038/sASXfmv/1iOpQY7yBikWUhRHD+SQ7MwTD6Cpr+/kv8uf4zdPMtPlQdHqCpPxqEphHgaoKzuQnaKNsQtwKrbGUXcRU8+2S8Fd8AJABiBRdBQ9tmHuw6KkuHjVcar2DbOSpBHUOsPDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SlJy0QHS; arc=fail smtp.client-ip=40.107.96.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMSjDIfjMrQsdLa8Q0k58UO4/xCWnZbz3uF2GGJHspIqNnols4DC3rlyvpqvdBBMve4oIUpzr1SgfIZWVDdtpvEzuuO4Lh1I+fYmMFuLf6jbnXakWDy6TirZduUtFzS7ysW1O8LUtIcDYqu8NpQX5sDvQ8y/CIO88WVq0QTnw3dVgfT2ltVJTazTz1iqo8z77A4foWYxYJJGlKWI5IlSlMphWdaVjBzr1XcPGGvM9Q9mI58+DQ/9ZwKMffpqhvi9FQaYz2JiwWIYibgYdCYz2eYhi7kbR//hnbTDK14Z5Bc3Nlme+bMfNBpp5N0Bk+clgZ4cEcOZmgTPO9fB0yHMSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUKQgU55+q0z+QA6OsoYdH2GCEgHsZQWCHUMen/3Yyo=;
 b=SAwGJv510VZjoJ04WKNWjzlebQIdxA6VwFoUwIuvyYrrXubXrrMaEOsYRIuPeRCcWn1FdofMvNXQZWKrHNDmUTZbXuVEvgrnfSGZiFgUKHowBPJX/855kbNUMRQdm0uR2PJcah5UX+5zUZR1Vq/Qhmjy+K6k8rbZRh3zfoYnv7iezOk9+G4dTK/xT+u+ErZA3eBiGzu6ownDNqCP3icH8FQrSSbTm+vwk7wBrnOzOvybQMwBVGipxNTHZtalkQfR25yoyvwgxBFodi2R4svIgbxEDSujY5ciO1syzCmWysmOWLOn+RCuxrUB9FBCtmYGaJmrCQxy99t8pbQgDLpf/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUKQgU55+q0z+QA6OsoYdH2GCEgHsZQWCHUMen/3Yyo=;
 b=SlJy0QHSsRba+nXN5ZM6xi3krNUmno14jkSY4/DWcWsNXZZWF4JfNyOj574B9InT1jNNqtdtC5hPZijwgJerMTSDFPE+bWbGrOUUYIiMfGAlfqNS/MQWOYyic0MBmgNqkf/kwiUA9PWgnZHY4BLFA6VXFFvy6wfrb9NnaB6PWqn/hxz22XH0VHvcTpNP9kjbCGhM66Pm9ph8cHUXQH0mdwfESAWoOhVouoW2LC/X+dYfSV0Nt/a4gt/yGv1VOMQs5u8iDNWEgtHHnGfn2+dn1bVFNdeaiGL5rnq7WKlYVPFyejiB+T9jxCFeEPUrPrXaHFIZlcRxikDd8rq3NEch8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by BL1PR12MB5996.namprd12.prod.outlook.com (2603:10b6:208:39c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 16:02:34 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%6]) with mapi id 15.20.8272.013; Thu, 19 Dec 2024
 16:02:34 +0000
From: Zi Yan <ziy@nvidia.com>
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
 David Hildenbrand <david@redhat.com>, Joanne Koong <joannelkoong@gmail.com>,
 miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com,
 josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
Date: Thu, 19 Dec 2024 11:02:33 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <722A63E5-776E-4353-B3EE-DE202E4A4309@nvidia.com>
In-Reply-To: <0CF889CE-09ED-4398-88AC-920118D837A1@nvidia.com>
References: <20241122232359.429647-1-joannelkoong@gmail.com>
 <20241122232359.429647-5-joannelkoong@gmail.com>
 <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
 <hltxbiupl245ea7b4rzpcyz3d62mzs6igcx42g7zsksanbxqb3@sho3dzzht3rx>
 <f30fba5f-b2ca-4351-8c8f-3ac120b2d227@redhat.com>
 <gdu7kmz4nbnjqenj5vea4rjwj7v67kjw6ggoyq7ok4la2uosqa@i5gxpmoopuii>
 <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
 <ec27cb90-326a-40b8-98ac-c9d5f1661809@fastmail.fm>
 <0CF889CE-09ED-4398-88AC-920118D837A1@nvidia.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN0PR04CA0037.namprd04.prod.outlook.com
 (2603:10b6:408:e8::12) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|BL1PR12MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: c2af3429-5125-4b21-5247-08dd20468d24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4ERtYJtUNP7IILjFBsMWnmMCzJynaxkl6vXJp6m8OcdRYhQATSWkr5yDCAqA?=
 =?us-ascii?Q?OWUHPOboo5PHNNngo925wBS3U5vpkeTcllbZVL4d4iS5zlyBex2IDEkwuqVa?=
 =?us-ascii?Q?uyG/BE/R26l33KafCH7s4FsSvroeOoWoQkPMCWK5A5lPhvZZNj2X+Y/0LxLG?=
 =?us-ascii?Q?6tqCprOX1KA8VGh5cEVozpZdDwC00i9/Z4PsXMszN8YbvKu7XKZGHWVnJ1Sn?=
 =?us-ascii?Q?f8Wpk5pWrSX90EMHA34gRWTCB80YcePK/U42A61CmfYtJKWwjWXXX7jXvGzo?=
 =?us-ascii?Q?2TVKwdvA/7nJ5jNvSQ2Bn3qvLP/IdJqazD+5cz4XwjxSZeZ/s0USnVXEwB1M?=
 =?us-ascii?Q?WyDXnQGiBbidb8F6sVhlRahlxlr+oXjiJ+fSl6V8jQWHWqluihLn/MNSh2mA?=
 =?us-ascii?Q?pIBVf0Au4e6ZjHk7adaxFzmzQE58MGntiP6GjVmFeRO1lepD6qIPqqpJCNyK?=
 =?us-ascii?Q?jwC4YmkgsDm8/6VfcdPzXn89mkUdZSrVkS1US2vs1eDeiYnpSnirmtu1ZtGA?=
 =?us-ascii?Q?12/8JxaDYB1qj9JooI0prsBgPagD61/6FPuzTyZvQZ0CtCHulOLGLy7bPLVz?=
 =?us-ascii?Q?tLcLw1+Gw5Qja/HW9gwSJpurD/iEZZVIDccGTUwd0W7Pp30hcjRGaBVRctCK?=
 =?us-ascii?Q?ydxC7q9qkCxezgpgXC/BtFXE9srYkU+PefjGQG/XULunlv5ccRMfZnzz4WJg?=
 =?us-ascii?Q?ge2j5Z6aZWtE7UqJ9lwIpX+DSaUuDqfkyPjY910TTb9UXSVqiHXbjK2/Ui76?=
 =?us-ascii?Q?wODm3zuGmVmkTIEf5JI/UpKumCEbXA9bC3hGwWhJSU9Ue06hlS5WD6Cs1uVi?=
 =?us-ascii?Q?3SGsmWIq4tfdnExGIm+zbDrFb+QG+hPDqnkrkeYUMhkCFBRY/m889/gDHHwc?=
 =?us-ascii?Q?iyfhJb90aMaQoB25SAji8tmM//L5RGE7LP1cI21FqiUHPQJDPr9lMGuZ3Kya?=
 =?us-ascii?Q?8wvAIb6bIY96Evg3j6Cw89I0VJS9aV7SAMRoZYe/oJpysCRFNJoIiAR/0muN?=
 =?us-ascii?Q?D1Av3SF+UIDKsd+nclRmGnkKO/kEt3Q2n9T7UAs1mKZWiWCbx/R8Pvk+htXk?=
 =?us-ascii?Q?OWWe2IY5nQnm1gPQiJVFQ+1VXHirratg8GG0CP6MtKGsm++MwTd1MpI99sc9?=
 =?us-ascii?Q?26HWbo1MfGWL9vNY3WHOLCVxBHHaPl2kynfVV92vHP0HvgW2bhpnPtD5Q7MM?=
 =?us-ascii?Q?iGDqAJA6X3sSx37LljHXaSYkvNhJhxNOVQcBHzoYj4t38WHVUAnm+VH+O/iH?=
 =?us-ascii?Q?hziOUJ/QSK/5Td4cgNVXPDmW3T1/I28ohTjO04o64Pzwj0v1qbVp3iu9ytvS?=
 =?us-ascii?Q?TNDMJHYy8jqpI59VvvwfQa7ot5jA6YcqxD0sqq7lnn9hFE9clGc6pVRA2xAJ?=
 =?us-ascii?Q?T4b7HPFkq2bhgSTjKM0sYtqWC2rf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?48L2NhET3PopykLjNa9ieLn13B7ZL5SOVN9pux7smBQNllhAPwIRhEfSMZ/i?=
 =?us-ascii?Q?5iCgaSEEdGYUi4ObdFukF/t2cogPC5YjXOkTIRswRQLuWBa/ugleOybVvGxG?=
 =?us-ascii?Q?FYj5oRD4nRoySufzai4OAovVseBcDfs9RFYWr7U09w/Zyduuv9SCRIL0ZZwL?=
 =?us-ascii?Q?rUXQFX4pJLKQw7VUAnA0R17l6N0sthdneYI/laJgDCWkK4EqpG4YTp/f5EN3?=
 =?us-ascii?Q?7W8teVGT7cDXRSTkjP1/6Ev7yi6JtK/QUpLa7BaY+xrY5pTxzJxDSQF9Xu5J?=
 =?us-ascii?Q?5/W1GTRwCnwJ5qgRvUdYNgKti5UU4LIXt2fiAdcL4vHafDxE0KP3VTUcUKDv?=
 =?us-ascii?Q?96PuuWIvhdn+zPygjddBwB5ZLoH+/KlAzhPVZZR2zIdQlXeznqSt/mSu6Zj+?=
 =?us-ascii?Q?ljotpzO4GUQYog/JXzKVrU90DXHI3tJo7pLkvsL95jKAaVQxF/JN04LxUOfA?=
 =?us-ascii?Q?t1d9VghuvT3eD4poLTEQ5mf/ocIxihsLQo7WqoI/eeuTKGD37Vww8LajM44E?=
 =?us-ascii?Q?4mTgeXd4ZEWbmCQ097dMuxf5P+I5odUSNTwT1J8xDPgxygSHHFahNKgPnF53?=
 =?us-ascii?Q?SDo53MSHZmT/pcMQLQh/6rruqTd2OIy2kriqqt0X9bow+1LCZQmKUunU4LRf?=
 =?us-ascii?Q?xyMYtJHGFYGfcoGu0ZgTze1enGWTbe3bpvTW2Tj2lyTAWZgOlmMPYkMjLf/y?=
 =?us-ascii?Q?W96FlYs4Y37ZmKoE3HslZDoDHubVRPtqhQFW1x8FAAzlQBq2mgdLiQUf1nXG?=
 =?us-ascii?Q?0vYRqVIEadrr2Z1lB8s1trPWlBhc1s0EIvuqS/G2sUdpvrXektQ/oHDOitGs?=
 =?us-ascii?Q?Q1wWvxSNjB+PHPR+jbDqq5bcIBuFfGwc/L8UicYD9GHaitH+/KtSjdBVkqca?=
 =?us-ascii?Q?FezAkgxP9dYJxlUneDgyxYc3qaWmd25Z/YjpsgBhqbngzERAQHWARfSGFW4G?=
 =?us-ascii?Q?nbv5ftUJh82TvMwCCLGfdJntO7+eSuYEjFoMpxdunXyczS+ukCPV06tNfKMv?=
 =?us-ascii?Q?dejNGR6kGt0a/kjE7RUkBH06o5uO1ARmu0nTa+UIMbIXKQKmPdHjs3JEyBs5?=
 =?us-ascii?Q?8v0axAanpjdnAmdi3UWoJ0nRWML4CmjBlFA4heZUcZP1F9fvqgttltStQ3xI?=
 =?us-ascii?Q?0anJDl15EVGp2jrgc8owO1Slt7UJYsN8SEnOEsAESAU/SjopCXGIu3SXvF1r?=
 =?us-ascii?Q?2Nz7+tf0kVQYfpBb+XSUWTaoWzca55YJJ2bzW0W3JvIhvbW0AXPmNZVU5J1B?=
 =?us-ascii?Q?wYk6HAmVVMRpE4X2L2eKN98ID3/NsJJgVNq3byM/4Ed1oBfV+orY7snG48qX?=
 =?us-ascii?Q?cb8DKjkkxFoBx8MKSJFZmRhi1BSdWGQY5eHugF4JnW63mlvZLetZmlODhaMK?=
 =?us-ascii?Q?SLKND6yDjBCypTdKQlSWUhwfxSUj1LYYnHTamQwktb5e49TjBnAts5E8VIor?=
 =?us-ascii?Q?RBpBA3+0ZOjeeYKvvG6wddTg01CRWpAQqyOGLhwVf3vsejw79GhqncYbUsp8?=
 =?us-ascii?Q?4/hIsWwGc08/syNPZXUsdGSAdrw/a0kN24JT6Ch/Zums35G5QKe1/bOnhI59?=
 =?us-ascii?Q?wopIdeLWxXX68jGDAoKxIlm3VgamG1bqkZ98uizK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2af3429-5125-4b21-5247-08dd20468d24
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 16:02:34.5476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8PBBnAVn/EZLPH5abeJto3w0zkvXygQPaiqQbApowogl8OLibLkeDuYIrvs9mlK8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5996

On 19 Dec 2024, at 11:00, Zi Yan wrote:
> On 19 Dec 2024, at 10:56, Bernd Schubert wrote:
>
>> On 12/19/24 16:55, Zi Yan wrote:
>>> On 19 Dec 2024, at 10:53, Shakeel Butt wrote:
>>>
>>>> On Thu, Dec 19, 2024 at 04:47:18PM +0100, David Hildenbrand wrote:
>>>>> On 19.12.24 16:43, Shakeel Butt wrote:
>>>>>> On Thu, Dec 19, 2024 at 02:05:04PM +0100, David Hildenbrand wrote:=

>>>>>>> On 23.11.24 00:23, Joanne Koong wrote:
>>>>>>>> For migrations called in MIGRATE_SYNC mode, skip migrating the f=
olio if
>>>>>>>> it is under writeback and has the AS_WRITEBACK_INDETERMINATE fla=
g set on its
>>>>>>>> mapping. If the AS_WRITEBACK_INDETERMINATE flag is set on the ma=
pping, the
>>>>>>>> writeback may take an indeterminate amount of time to complete, =
and
>>>>>>>> waits may get stuck.
>>>>>>>>
>>>>>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>>>>>>> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
>>>>>>>> ---
>>>>>>>>    mm/migrate.c | 5 ++++-
>>>>>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>>>>>> index df91248755e4..fe73284e5246 100644
>>>>>>>> --- a/mm/migrate.c
>>>>>>>> +++ b/mm/migrate.c
>>>>>>>> @@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_folio_=
t get_new_folio,
>>>>>>>>    		 */
>>>>>>>>    		switch (mode) {
>>>>>>>>    		case MIGRATE_SYNC:
>>>>>>>> -			break;
>>>>>>>> +			if (!src->mapping ||
>>>>>>>> +			    !mapping_writeback_indeterminate(src->mapping))
>>>>>>>> +				break;
>>>>>>>> +			fallthrough;
>>>>>>>>    		default:
>>>>>>>>    			rc =3D -EBUSY;
>>>>>>>>    			goto out;
>>>>>>>
>>>>>>> Ehm, doesn't this mean that any fuse user can essentially complet=
ely block
>>>>>>> CMA allocations, memory compaction, memory hotunplug, memory pois=
oning... ?!
>>>>>>>
>>>>>>> That sounds very bad.
>>>>>>
>>>>>> The page under writeback are already unmovable while they are unde=
r
>>>>>> writeback. This patch is only making potentially unrelated tasks t=
o
>>>>>> synchronously wait on writeback completion for such pages which in=
 worst
>>>>>> case can be indefinite. This actually is solving an isolation issu=
e on a
>>>>>> multi-tenant machine.
>>>>>>
>>>>> Are you sure, because I read in the cover letter:
>>>>>
>>>>> "In the current FUSE writeback design (see commit 3be5a52b30aa ("fu=
se:
>>>>> support writable mmap"))), a temp page is allocated for every dirty=

>>>>> page to be written back, the contents of the dirty page are copied =
over to
>>>>> the temp page, and the temp page gets handed to the server to write=
 back.
>>>>> This is done so that writeback may be immediately cleared on the di=
rty
>>>>> page,"
>>>>>
>>>>> Which to me means that they are immediately movable again?
>>>>
>>>> Oh sorry, my mistake, yes this will become an isolation issue with t=
he
>>>> removal of the temp page in-between which this series is doing. I th=
ink
>>>> the tradeoff is between extra memory plus slow write performance ver=
sus
>>>> temporary unmovable memory.
>>>
>>> No, the tradeoff is slow FUSE performance vs whole system slowdown du=
e to
>>> memory fragmentation. AS_WRITEBACK_INDETERMINATE indicates it is not
>>> temporary.
>>
>> Is there is a difference between FUSE TMP page being unmovable and
>> AS_WRITEBACK_INDETERMINATE folios/pages being unmovable?

(Fix my response location)

Both are unmovable, but you can control where FUSE TMP page
can come from to avoid spread across the entire memory space. For example=
,
allocate a contiguous region as a TMP page pool.

--
Best Regards,
Yan, Zi

