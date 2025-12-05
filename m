Return-Path: <linux-fsdevel+bounces-70816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CB9CA7FAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 15:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFC1730E984E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 12:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E714F3126C7;
	Fri,  5 Dec 2025 12:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="CO7aRK8z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021124.outbound.protection.outlook.com [40.107.208.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82D630649D;
	Fri,  5 Dec 2025 12:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764938042; cv=fail; b=j0U+O589JAeQ9BZKk2RlxiKDRbdQ6LxbsBE/9SJRJ8wmoDYjUI88tzu5w1Sdr0o3nLTo1VQWRLDE1DmwSLfRD4qGGmR5pu0IkbPdLZ0LyVpuult62iORELHuVPQ+tcA+l19dL8edJ3lXDQ2g1i5GRv6H0rvU9X98kNG2LpmY0b8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764938042; c=relaxed/simple;
	bh=u8LhFc4pwTBe6Jt4D/nQOHinuWJi8cJ+CnN60qIjOp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cr38NrnY2nKFgbg2ZQDVBmxwbKs+dgb6c9dhDB0E26VjAQ2La4FuMWIeeb7Uu8B3TjA4eTrf/bjy/d/alomWy93geGUXjoVZsKYb/57G+EjcHhumsSHV2hk34+EL+k4KW+S+i6vDoIslvAKjrbRkX59n1takOyikFCQpOjTMM/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=CO7aRK8z; arc=fail smtp.client-ip=40.107.208.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOOCeb3FMS4rm1zdZGjowRdcjE8zKIatEC2jO50PLpVnL0jJx+9jrd1pIU96U1muMuw9uwjn62YnPczkrwRzgwzYLvIJsH9Aqnk8zC3b157f9YAUBQvHU92VYGYbvfadQg+n+Q7bBlHyAD6o6BMw2f1FHeJg9swbCXgQmp/Q81NnjK+IXBiELFg/PLGxma/hGavhSMILOrhbno31BVHk36AOQoQZWD2Dw6oJkRo5rLPYP3Rm28GfqMTxuQFGpCMj8R8VJjimtvME8y0+BR5rXx8J0hifnbFN/7lebOWtIUIlUvTmFneWik1HMILQRnuzy1/RIfdMCkjdgnXJrbjvWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYm16QTa1WxAIrXl8KtHyRALpJwQ3N2K/pRhbju6MCM=;
 b=XI8Jq0HYucSdQfUVRHO2IYfne9aveyFKtfkPqOUoRs5G+gxy8j11VmzX2BgG++aeZLii8437w6G1wk2IYMPdLjwiS6nGROMcLZGDFoJ0fTR3tEwsXsQW8E86UiX1IqerjUm+Hmd9PBE5hwaELnsF+d2tlWyxNV9Ybe3ZINrDGHvpE7/GQhr3Z46cHeE4GYNZJ1kF5wpbNvwgntmLwtykoN+zBRHN5O2TgJ2hYdy1GmgDGSmyU1YDACJzZaKJCp+q5swzbqFPwum2CVIdjvQy/t3PQxPQZv0djftna3BLCzEPbVhMxEHk8va3OqT2RHPAH0pFiklAwbNdKbK3oHWbmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYm16QTa1WxAIrXl8KtHyRALpJwQ3N2K/pRhbju6MCM=;
 b=CO7aRK8zLBIVxFa5+ojXLM0Tb8/bSFDe/r3dQrwfuxkaqICOb/MRwMbedkwAPChp4Q+ocKTyCAdML4p0NQHyD3WWGpw7Wh9jAkkngcJBWVLTktQnoSMAf5pzikcq23sraKX3Mrg2ZYhChogZco01xwP3czmtKcVHHTv7tjbGjMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SA1PR13MB6648.namprd13.prod.outlook.com (2603:10b6:806:3e7::10)
 by SA3PR13MB6466.namprd13.prod.outlook.com (2603:10b6:806:39b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 12:33:56 +0000
Received: from SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4]) by SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4%3]) with mapi id 15.20.9388.011; Fri, 5 Dec 2025
 12:33:56 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Allow knfsd to use atomic_open()
Date: Fri, 05 Dec 2025 07:33:53 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <EA4A0E76-B544-43B6-99BA-F38CDA688706@hammerspace.com>
In-Reply-To: <20251205-drucken-stutzen-bc27967b943b@brauner>
References: <cover.1764259052.git.bcodding@hammerspace.com>
 <DD342E0A-00F3-4DC2-851D-D74E89E20A20@hammerspace.com>
 <97b20dd9-aa11-4c9a-a0af-b98aa4ee4a71@oracle.com>
 <EF15582A-A753-46F0-8011-E4EBFAFB33C7@hammerspace.com>
 <20251205-drucken-stutzen-bc27967b943b@brauner>
Content-Type: text/plain
X-ClientProxiedBy: PH3PEPF000040AC.namprd05.prod.outlook.com
 (2603:10b6:518:1::5b) To SA1PR13MB6648.namprd13.prod.outlook.com
 (2603:10b6:806:3e7::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR13MB6648:EE_|SA3PR13MB6466:EE_
X-MS-Office365-Filtering-Correlation-Id: 359a6c5f-8a9f-49ff-e5a3-08de33fa8eea
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B1MPclq+yS3aoXWtyRoIU57Wlp2Ra8a7CBOK//tbyJ7K1E9OI1Z3k95VXr7x?=
 =?us-ascii?Q?t6FP1CswLS31iK3hEjbpZp7W7EAx5Owej3lryppbD2GtBhipWOTsM8oi8/Rm?=
 =?us-ascii?Q?Ck5meg/UYYY36+UsrG47Gs0z9Qz6vaN9oCeO7rbt22SHL7FYkTtvq/LJljNF?=
 =?us-ascii?Q?f2KNMrJ+fdWYFeA3zls18mpC+X11MNSO8d5ntp7dmNiuvJw0fqBIi6tioGv2?=
 =?us-ascii?Q?F7z545Ax9HmZ0UuPyir3OJ2fiW+Bjnw9fgLxEDST2uv10i7GTzbGs/oOduyh?=
 =?us-ascii?Q?VRoxm+PosCJKGOCLcM3lgCEKqIPsOLRkX/PqP5M+zskDhSPG0d9JUjuEs77c?=
 =?us-ascii?Q?WvYnj0VcyNUBzoSvHNvXNQbG6aqgnEzNTYsULqmdtMzmyoLlnBVGRb+6jbbW?=
 =?us-ascii?Q?/Z6zVqomRbjKvcqrWKEdQz0xz+xCBRyT5CHFWm/YJBZl6VwrlBRn7DnmZ7Yi?=
 =?us-ascii?Q?DCeknDdvi9P+LqnLdMYByArjwOMxKwhBG2VsicEC/afox+zYPI7+s3HSZxVo?=
 =?us-ascii?Q?UW7kJAmDpcmyB/qMAXapfKVx1TL3C7LwDOobj8w0Z8BS4Tc9++xI5KkjOU/V?=
 =?us-ascii?Q?uZSrC1V+mjZtJkP+27F09S79/djVXnWd/3z+BRMkockdAAU+siYXWR2nYRZY?=
 =?us-ascii?Q?vAwfkwB5TdEMZOI2Y8YGY1wO+bW/Nhb8hnKX7C4OH49fneybOt3WsP7frs4U?=
 =?us-ascii?Q?TKxzKkEzNPfNeKRphJ8Oz7Ne/AqYFcsDH2WHT5gqBSgSQdul9CSZdMg/jSzU?=
 =?us-ascii?Q?3JEwanbEY+tgF+W2be1m83AJCnebCa0r4lzrVGr0qU4xhqkgl8rQGOTgYueQ?=
 =?us-ascii?Q?0/1kEWxJ3/Qrcy3Njb5ttqpGELZgRSir4Fr7B9guHHXqd7/EGIe+MHpaFShy?=
 =?us-ascii?Q?MVAJV93UIGi5oV9tMadqI7Rlf+lbN/uFybSFdp1GDKRmTHJqnrSe6k7EYs9L?=
 =?us-ascii?Q?MSR1SVlGEFc7eUsGesbEak5Yg/FB4KzM64tZ5gXmW9UxsFsLkSf5Sqe3WHhK?=
 =?us-ascii?Q?9H7py0nZd/SOmEmuTOu/gpGzDajcju7jVjDusu/hKVRr1JBUzrCKfrcdzL79?=
 =?us-ascii?Q?FNPegolMygPKNyP985rdEdD7/gBFu0FyceslLBsLzDdOHj4zEEri1tsSCaP3?=
 =?us-ascii?Q?Ef1ouLWHnhWT3GFvgbmTx14HBv6oSwOoRi/zmO2rczKvcpuNjzLU0JJcS9WU?=
 =?us-ascii?Q?Vhu/z/73JncmzTEdQDauvyK0o3gzQgAoudlsLDRkPQ01VLE/pTrqaI0AK59o?=
 =?us-ascii?Q?82I4w7mS2iw93lfdEgfqIkknhdtUA+w4snPDjoLyrilGKwZSuK4dXprQqiXd?=
 =?us-ascii?Q?hXqadGx6ibnONbr1v6zqBUBN4sgIsusggweVYGDgJRrNbKwH1ex4PakL/KIQ?=
 =?us-ascii?Q?kQXvet6+8l9IcSMDI7wQXgn07mDuszrkQTvPTEwf0zNGuZA6dXdXKqG0OuBc?=
 =?us-ascii?Q?J6UEkbwf0wieLlZK8YkMhrRBzjn+0Lgc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR13MB6648.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GDkg1XWmRPnpPCZUrTVq27q9opowIzktm52mt3pGN2g2uEBjVQC86YS8+b6W?=
 =?us-ascii?Q?OCO14y/myAxomBk+Al9uq4ioMgZ76xk74+ANo72+gFqJPF3OUdlhKzbKGXA9?=
 =?us-ascii?Q?EHvJmVuKVmgXZFYdJJYKkbv0QkTnHvgyBQ5TWKpI7ymQPNShyISVCWyHHVnO?=
 =?us-ascii?Q?/jKdQUZAc1K6lsk8Kfzg7b0eBynxmqOjXNPs5HJ4LtffXTxncp5Khvlq+ght?=
 =?us-ascii?Q?S0Nrxuxc+eMc9qzIga+RzpReqlcbSdAAZLoSPw4qR7Ugwp2vCjfZDBdGDpY1?=
 =?us-ascii?Q?DVea74UtK2iz8awvrNTwS+mWL/afj4/mRxnhjl3PSBGTOtr9OmkvNOjst8ah?=
 =?us-ascii?Q?yScM2OpXwSIAy788FVOykfBLLzynp/Qzfzs9RmUm5/2F0dU2bAiVDM7k5wED?=
 =?us-ascii?Q?tXNGGcKqnz1eupf11x0k2t0mlHhqdFQzqZWH4Pa9EFcXGgQ1n08Nlis8PvLh?=
 =?us-ascii?Q?a7hZ7wVHR2LUTDG5cAp+1fKXeFys6uOzmcuX5cTF9hwsDpxoMHju57riW1rD?=
 =?us-ascii?Q?qZDoKSBQF885XN7p9f9cV1HqE2I4P7XBoP7V9cWDJ3aSsphzKkUxuqY+6iz8?=
 =?us-ascii?Q?d4ZvSLS0rOjRdZ3E+cba06Sylcs8czi8OXhcBs+G3feahtx0O54UqQLQp9jM?=
 =?us-ascii?Q?wDOEHJWjMsLsMy53sB3XaHW3Ku0CIqRRGkUkYZOy57VNs1XTmuC3W1FYj3Vb?=
 =?us-ascii?Q?xvuSfjx/hE4/ws27jLqOQlJHlIaclZwr6nydURuctYGqJuTOKRsIsBPu6wB6?=
 =?us-ascii?Q?yB1CgNehgkZpboII4InFXseU4M70P8UCUNQkwe5+Kf6j6VL4ORU3Wek/9cAa?=
 =?us-ascii?Q?1gbUOAAsk+e2W8flPOw323oddV4wmH74SWB0ZQh+bwfydQyvhG5mgeHJ93ca?=
 =?us-ascii?Q?x0dVPheiaPT8iMnBjDtVnK8tLyYiOUr4V2GEWMbDZq2I2w0e2/CHvSncZWrO?=
 =?us-ascii?Q?wKhSyGfYJjdiQmsGIzy/+IAX0E7W1SQxTnzVtiVNRIDC+gPEZQ0EjiosFf7U?=
 =?us-ascii?Q?L9lJo2VpdoaPX5bHbNXR1bcO11uBLzCH0xNimqY22fghzVyOLRR9/X2xa4aZ?=
 =?us-ascii?Q?q8MoArmRk9WHy1RIYPBptiH/p0FYt6ZA8uhGppc7SBvEmKIKCLZ6Bo8PHFp1?=
 =?us-ascii?Q?t2d5A/x6hELilkoWq+pRqhE/0nrXqmv168hliDK7oKYr8OfuT+yD4EvKOz2D?=
 =?us-ascii?Q?hd9JsmGRw0rOs5KSL/YfAVSRWb7YeW93XtbI9WTMw4v6oUoU+zZlZ+usOjQL?=
 =?us-ascii?Q?YBCDwbja2EAdmcj/XDgJAFcXWxrziZDH7wgcuap0MS38wJuyByqPKc8//47m?=
 =?us-ascii?Q?877zR7aT5Q+l3J7yeDVPDstqD+2fjv6ng7zr0npRDGdE6SHeCbmITdzfNq3Q?=
 =?us-ascii?Q?QC4i2FBjVAv/LcrMZ46Ay/uNqKlGaQa31sfqePX4Fpp6COInzXHfcmGVYAvr?=
 =?us-ascii?Q?rPYwwh2BW1uj+KDNzP7foH5sgfUIaM4/koGokI9wHVReDBx44sRVOYwWu0rE?=
 =?us-ascii?Q?dbFb6s1Es9ijQbXl3+yrZMBCWA5zKlaZprXBEoebhVI4D4Y+/a96wsAw+V0S?=
 =?us-ascii?Q?FIPe34KBlqFBdw7WFQJwfRhz3xpC7u+febBwBH4N8wJTW6n6/9FsmK5llOca?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 359a6c5f-8a9f-49ff-e5a3-08de33fa8eea
X-MS-Exchange-CrossTenant-AuthSource: SA1PR13MB6648.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 12:33:56.7122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlEZsGEjSP/k3Da5QqMr1iEDKn5IIm9wtIYTV5r0vRIeEiEJvtmSkwP+X0KcfbfC1EAfa6xp1gw5zvX/FvAfnvhMcriwueNwUhRbv43K7sY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR13MB6466

On 5 Dec 2025, at 4:31, Christian Brauner wrote:

> On Thu, Dec 04, 2025 at 12:36:31PM -0500, Benjamin Coddington wrote:
>> On 4 Dec 2025, at 12:33, Chuck Lever wrote:
>>
>>> On 12/4/25 10:05 AM, Benjamin Coddington wrote:
>>>> Hi Chuck, Christian, Al,
>>>>
>>>> Comments have died down.  I have some review on this one, and quite a lot of
>>>> testing in-house.  What else can I do to get this into linux-next on this
>>>> cycle?
>>> The merge window is open right now, so any new work like this will be
>>> targeted for the next kernel, not v6.19-rc.
>>
>> Yes indeed, too late for v6.19.
>
> I've taken it into vfs-6.20.atomic_open and rebased this onto current
> master and will do a final rebase after -rc1. Let me know if I messed
> something up. Thanks for pinging.

Thanks Christian!  Looks good, I'll put another eye on it after the rebase.

Ben

