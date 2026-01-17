Return-Path: <linux-fsdevel+bounces-74287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D12CD38E86
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 13:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E660830198ED
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 12:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9CF2E0B58;
	Sat, 17 Jan 2026 12:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="BEAASpi1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022089.outbound.protection.outlook.com [52.101.48.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F482DFA32;
	Sat, 17 Jan 2026 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768653016; cv=fail; b=CBqIVZhMJipJwwuEug4MhWw/eoJPufcswa+YgZK+0a/f4NJPXjyoD2pRMnRXGnUzER99sZWatd6cykp9nsIZbB8e0b/rf8VEs6oeOOZt8lJ1m6Grd+bxMZRGF/UuzP7u/m33CpmAq70eKj5r5FC/nyRvj/IxrmX8UE3sgsQwBCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768653016; c=relaxed/simple;
	bh=J1wysVEUBVrjjaL34d8Xb6bOWGK8M3Dys5cZSUC20ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jHifPvzU4fOCqpnHvRklLIL2X9J+JoFzIvAffro4UqMaf6uumQcG57QQGwUBAMTHATUv370TG1qZe+KuAuNlrYV0fDMkJZFCVOSLOXCVQsspOspCzDRa97Yek8aDiFlMUtqltuJsbeXaNiQGJbBMF9ApNcHZmvULzoyAmmONsN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=BEAASpi1; arc=fail smtp.client-ip=52.101.48.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkR8edC9cOBv//ojTIej2Zi4Dy/h8NZbeA3R5L79BDpCXBe8Rt2UPXVocuLvB1GmVnxgpJsCIlGyxt2zyISBGj0cikCxQ7BBeRvv2WvXrvr+91MEBYuqRGhBLFbm5j7lFohRSw1f2C9cmARBDjKcX7oR2FXHy+y8JP9M/XlzppzDTNLeG3ieVA1Q+btD2h4MM7yGkoYPuWt1mURxWEPAiR0OnxfZiwkKeQEVu2O4Pb0jiFyOeQf/FOP+Vv0FgDoPvnJsIcItlUULM1jgXZexuYFwIdAWoM7yx43k6olLkmIMce6XdRPnj8wr/89jq4FkfVk9F3KrnD/z9jLrakM3XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVsa4EqpdU0zQhBrqVfOjvZthS2RxEKaaZ7zjJfPEoY=;
 b=A0YRphU3mgQU2Gev/KxS/5V1JvUlBu/Q/6H68qZvG3kNQ6uweaEdablToeOnwXzNQgg+jhC9JDTubEJAPdwtwfHwaaKzSAMAZK9BANe4LUs8mPOlnnznTxrJxYGZt8NbFO7g03tB6wo8y2RJFuE1+1xFstL6jh7KLs9TfwXHdK0cT2kqlA0JGnlWt27wc/SBGlVTMhXSqnjddz3P2EIuoRm9eHAvW1nnc3JminWIj/GodAskH62R/uCSQHxBPtSQYurJaCHmgdf0iWlvQ7ns6k43+jIjJf7ylNwg8Ws89KZx6UF6t4slIzG1S0ENvVQz2bOruN+WdtHp+J3s5dg98Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVsa4EqpdU0zQhBrqVfOjvZthS2RxEKaaZ7zjJfPEoY=;
 b=BEAASpi13EMbv090kkIMvL41OeFr3gvAO2y3h2br6pfTbKIcM8QMRS1VNSe8yj4SexvIopMw5y8rY/Oht080517OnKbpNSd250xMN3aiqsfOIszgRO7d24UhZHvAvGS5koZRyeBtXr0SlZfb/1EMZAbBi9bLa9rQFFJ0bQc2snY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 IA3PR13MB7001.namprd13.prod.outlook.com (2603:10b6:208:539::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Sat, 17 Jan
 2026 12:30:12 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.005; Sat, 17 Jan 2026
 12:30:11 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: NeilBrown <neil@brown.name>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, Rick Macklem <rick.macklem@gmail.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH v1 0/4] kNFSD Signed Filehandles
Date: Sat, 17 Jan 2026 07:30:09 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <8C67F451-980D-4739-B044-F8562B2A8B74@hammerspace.com>
In-Reply-To: <176861309837.16766.10645274004289940807@noble.neil.brown.name>
References: <cover.1768573690.git.bcodding@hammerspace.com>
 <176861309837.16766.10645274004289940807@noble.neil.brown.name>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0070.namprd19.prod.outlook.com
 (2603:10b6:208:19b::47) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|IA3PR13MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b75b1e-b063-4d66-4b24-08de55c42888
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XbWcmnbNzBeESdkMKXHgA+fMZ/2Dn0OWwo5FUgEkzasoAqz+GFIxkGzturo5?=
 =?us-ascii?Q?AcgpbBRJjqvB1KOKF3h9XLDcj9XL63KADJlIcksY6fgtTQZxqyZ7PWo3FPRO?=
 =?us-ascii?Q?vrHNaj1ekbakABDkS33eXl/CIZZ33AQO7uiKrA6BSyB+DmXgsVFI05JB7qmv?=
 =?us-ascii?Q?VYJhckJv51cqFVF+1ioDrXSSpppZFr62B/2z1sKGynHQYkgu4wlluvR7y/zN?=
 =?us-ascii?Q?8yke21XCXJcu9skPBVgcLjaH23B64N1jU+paZB6W6h6/YGvw/1SjH9Abiyjz?=
 =?us-ascii?Q?qLLjIbS8GNt4xpRU0VUpBHaBl6Zrz1WHAxDA/EJ7o9PmUTJzF1tLsYlG6DIp?=
 =?us-ascii?Q?XYkpLYVAThwsNNMi4WLGeY2FJpY3dyfHCY8MdDMThBvCjbkSM1fkLV8MSzcT?=
 =?us-ascii?Q?WF/pApmgjkDfQKLEstUAWttl49QQuVRZmHbXsOsLSEIAp3qPIcJvlMZSuvpR?=
 =?us-ascii?Q?zZeUfMewCwdWHNaFkenLTSeEbzLk+XfN2ubd6ppz6svWKbrROSrT+zaAVSLg?=
 =?us-ascii?Q?j5/7q50dB1gnnbbtn4bK/W6zCv9TBD2MFBUPBtlzsmE5GekZAwxfBtAuN1Bb?=
 =?us-ascii?Q?hgLDhdS50ZUzde5l/UH1IHcpXzP9JUP6cNdhWB/TuBUsI/r70yU54nOqtl9Y?=
 =?us-ascii?Q?xaRjr1P6x3FjORKJZ/qa9jya5rSRtJgK4u8Tn7NiJuUMT5T397NHTgw2AZAm?=
 =?us-ascii?Q?imUSmbFERjY68vRcePbanGHN0LVIvgHNpGLqU5/uEMYtktu3bEaOM2gGjPwT?=
 =?us-ascii?Q?5y+ObUL4J5qgT0LymTAfF+6O4NWpyaaKeHOb/P8ulaxDLj4LKvbOJE53uuXc?=
 =?us-ascii?Q?7Fs/j987NHPgOOVvRIEhrqtMIKTWEl6SeUubNho5IfJdo/7Bh8NwQtjHxJ8m?=
 =?us-ascii?Q?D3ajz0wHUmwyDTXbXE0L/h2HknxGa2ERroxGFk914bh/rWfAOAuKRbhcW9vn?=
 =?us-ascii?Q?Y4LhQ6LBzaUAx6BXlJSQTJkrjfGT3+GN3NlWR/eXgCd44xcJK4syLjvTOnNe?=
 =?us-ascii?Q?wvE469K4zuMIsHfdatUqe8SgFqtGLTzdubTltVOh1eFrlRzEbOf+NceVZIaS?=
 =?us-ascii?Q?UQ4paLE0iEBGu+T9Gfcy4d+f7Gg3Pi0/EiZ/xX+d/qwO4zd/jPoE8Tv/Y4Yc?=
 =?us-ascii?Q?WfOIiEgAaMYm0UK6pKuFn9u3++UrqrLRSGP79wSz/pZ1ZWG8L2X1WfmEjl1O?=
 =?us-ascii?Q?4fLzqzFiGpzsZypOzPrB07duhEoewLwwfcX2yGfMmR6u4HhzTetDAWScenT7?=
 =?us-ascii?Q?2qmuACSWArTXyv2MaBhNAUlYWgbGa4T8oNqEanzcVufdv68WWWksnN/0/0xR?=
 =?us-ascii?Q?itsVLIeEf6mu/Pt1eSuNUkm5TSaKAXR/o3d6rLV46BCCjqWH9ZjyeLtZjlJd?=
 =?us-ascii?Q?b4cjVhKdZxdgvSHQYHwAwk65uUW1xL/DVjzwWd8RJrsMavavX03Uxf5kBB2D?=
 =?us-ascii?Q?YZdrUl1QuiPCb0IcY636l7xjNJFUkknp6f9iUOb7tOdCu9i0xBAStWK6R3Ze?=
 =?us-ascii?Q?0NzdHsy5ZXv+7PtUjzAHlRgsW2CPQ8HWopn6pB69vwEaVuJSltjt5mQT2gye?=
 =?us-ascii?Q?l5Fpi7rIgA6aqpz4P6o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mixMhx3LV6/55SDY/ld/VIGYhb28BZEURkugk5bgjyhC766GDuOgkO+MV4gX?=
 =?us-ascii?Q?Ls+OKgK/yjIvfW9kaqfMLYFXj38Jf0u6R3SeCMdDXHRlfDjfsvL3NNJoOJB+?=
 =?us-ascii?Q?9ZXs0juWQIcKGVkABiRdG6UtUkWalkW6PHpuXjNg9FF2Wf4/wJB0dotWFYuZ?=
 =?us-ascii?Q?63Eskslo13h1u5b0ZVY2rdWdUivPRRFcmFYq6hoi0jbLPwpDWEsfwbDZFUMA?=
 =?us-ascii?Q?RNxIz/YsK/9zmosgwzo8/jhSDPkUPWx+/T3w4DzdYnUhH6bOOFm2z3VLqVi0?=
 =?us-ascii?Q?W64GwFI4fwOJ6Wqwhgmhs8RqP2SzOtroBLfjwyHZ2cIT6quabzm2jTINv3PK?=
 =?us-ascii?Q?CLPdcL9k6mikifU+QaJ58oVRjoLgOhlJ8Y/ZOvgOY7OzAcRpHC2CSuO/T6pC?=
 =?us-ascii?Q?HGpCMQA7/U5czwtGJSWf/5zNiogJH9zuUUQVB0nnhJ3l2scxz97ZceueNtJh?=
 =?us-ascii?Q?MPDQ/qnSsArTQwGVWHmMaCGlWSksUsv4X4YdwgSUmChY0dwIC4j1v0UOtTin?=
 =?us-ascii?Q?CUzfBvA7mvFqqeLZoV7ul4u1JXuacJtFDj3ruC2+yOhqbLqTloPmhijjARqk?=
 =?us-ascii?Q?krzhezpck9Sjb/zaFtuoYkna2pnxUmlnH+c67e1u7MkkwxmYif8JHJYrhI9H?=
 =?us-ascii?Q?gGEk4C5loSe+svBfSJzmCUUXGM7AidEm6a8MUoeYOpuG7iQSqDn3QXOgo8vC?=
 =?us-ascii?Q?7Z/w8iozRRsw0T5pzhY3O47AxTg79ty70eeFAIXh84c5XverX/wn778YCgz8?=
 =?us-ascii?Q?fsrrQiJje+YidiyJ4Lev/jodcCD5eR5LuVPA7Q6CaC4y1AKP8J4ajX5859BE?=
 =?us-ascii?Q?kHASg9S2ukwse+d7YDTSnlpVatBYyb43k8q6CgYkYp5EmjYJR4vJf4wRty6G?=
 =?us-ascii?Q?mvZI1R6NgdrE6TFGkkO1sYqAQ6trXUeTk9piQtVFfZctGQBAwgj2F2JA3i9o?=
 =?us-ascii?Q?R1IopiLGnFLga6tOzi7Ue61eufZy2y31VHmZl3bhch6i0G1J24wQicWdhLWA?=
 =?us-ascii?Q?FLmr4f0hn70qn1E1qPz9YwCCS3sjMZuzIzTn10YZZzEYMhCwHiWVj/+wJeog?=
 =?us-ascii?Q?war8qR2M+3PrV5qFW1CCsxTf3NvwS8MAhrNYw67kq+lF+QFlcTSquC4mxX5x?=
 =?us-ascii?Q?WCuh9r07zprry85JyodfUmTJ+hm74T1hSHdA0lTB57iCyddT6eySF1ve6fU6?=
 =?us-ascii?Q?7att86A3il7Oe9jsJdmC7wRojB9cEasZsMwYU608O8oZucxhQ/aiQ63m9lMx?=
 =?us-ascii?Q?oKULZQmFCvFEU019e9Q2aLwXJ2vd4z31zqhMO97P0zjSYsLD2EsXzFkc7dcW?=
 =?us-ascii?Q?gNsbgdbZu6YzKGx5mdeSk0xXk7Ic1HNikQjRs+T8T28cc/1u7vN+ro0mkjhI?=
 =?us-ascii?Q?Av6c4T8xQiM0PYk4TYi+pPDWiccCYbJl7UOvvw2WrBH2ZCBSKpJddSDNP/mT?=
 =?us-ascii?Q?DtgDesyeHc9MwTWFrf3fjpOeCiI7nbBoOce7ixA6K0dV5lir6xB/VuqutWKQ?=
 =?us-ascii?Q?d3SAnT17NV8PMADp+MoNpEpFcgBml2eUXNVZ8IOB7VaWBuXtyFmE/5HmI7AD?=
 =?us-ascii?Q?Vpign9H5RUtr2pLffriH3W0WnflSwma6Xs8aaexXDTB0zgLkn9EV2AzdgN7N?=
 =?us-ascii?Q?50KejZOuT8C6q9JmVonhyCH+ENvf5U1BwgFGOX8YCSKJ7Tfg5dtaWsYoZo0K?=
 =?us-ascii?Q?+4lbdzhSsptFCyoVnnepbPTdlvvzeSgVJRrx+Nmh239804JiM4AJcFn+3/jX?=
 =?us-ascii?Q?bn+vFJkDcLVOOHJ53U40JB2/6Fu2cXs=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b75b1e-b063-4d66-4b24-08de55c42888
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2026 12:30:11.8118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+SvaOgNH8iVjrzSnnINBdzl8pETPk5tcuVHNOJ6ihAqkmSUV1080SnkLZ9EXI/lL8r/cHo+pa2uBOfyOPjHA3eZ7Il8qf71rN6KNQcq0rY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR13MB7001

On 16 Jan 2026, at 20:24, NeilBrown wrote:

> On Sat, 17 Jan 2026, Benjamin Coddington wrote:
>> The following series enables the linux NFS server to add a Message
>> Authentication Code (MAC) to the filehandles it gives to clients.  This
>> provides additional protection to the exported filesystem against filehandle
>> guessing attacks.
>>
>> Filesystems generate their own filehandles through the export_operation
>> "encode_fh" and a filehandle provides sufficient access to open a file
>> without needing to perform a lookup.  An NFS client holding a valid
>> filehandle can remotely open and read the contents of the file referred to
>> by the filehandle.
>
> A *trusted* NFS client holding a valid filehandle can remotely access
> the corresponding file without reference to access-path restrictions
> that might be imposed by the ancestor directories or the server exports.

Mind if I use your words next time?  I'm thinking that most of this
cover-letter should end up in the docs.

> I think that last part is key to understanding what you are trying to
> do.  You are trying to enforce path-based restriction in NFS.  And due
> to the various ways that a path and be traversed - e.g.  different
> principles for different components, or some traversal on server, some
> on client - this effectively means you need a capability framework.
>
> So you are enhancing the filehandle to act as a capability by adding a
> MAC.

Yes, that's a great way to think about it.

>> In order to acquire a filehandle, you must perform lookup operations on the
>> parent directory(ies), and the permissions on those directories may
>> prohibit you from walking into them to find the files within.  This would
>> normally be considered sufficient protection on a local filesystem to
>> prohibit users from accessing those files, however when the filesystem is
>> exported via NFS those files can still be accessed by guessing the correct,
>> valid filehandles.
>>
>> Filehandles are easy to guess because they are well-formed.  The
>> open_by_handle_at(2) man page contains an example C program
>> (t_name_to_handle_at.c) that can display a filehandle given a path.  Here's
>> an example filehandle from a fairly modern XFS:
>>
>> # ./t_name_to_handle_at /exports/foo
>> 57
>> 12 129    99 00 00 00 00 00 00 00 b4 10 0b 8c
>>
>>           ^---------  filehandle  ----------^
>>           ^------- inode -------^ ^-- gen --^
>>
>> This filehandle consists of a 64-bit inode number and 32-bit generation
>> number.  Because the handle is well-formed, its easy to fabricate
>> filehandles that match other files within the same filesystem.  You can
>> simply insert inode numbers and iterate on the generation number.
>> Eventually you'll be able to access the file using open_by_handle_at(2).
>> For a local system, open_by_handle_at(2) requires CAP_DAC_READ_SEARCH, which
>> protects against guessing attacks by unprivileged users.
>
> Iterating a 32 bit generation number would be expected to take a long
> time to succeed - except that they tend to cluster early.  Though in
> your example the msb is 1!

Trond posited that with a 1ms round-trip and 50 parallel GETATTRs it only
takes one day.

> Do you have exploit code which demonstrates unauthorised access to a
> given inode number?  What runtime?  Could attack-detection in the server
> be a simple effective counter-measure?  Should we do that anyway?

Yes, its a modification of t_open_by_handle_at.c example program in the
open_by_handle_at(2) man page.  On my single system NFS client and server
with a local mount, I averaged 16usec per open, and discovered my target
filehandle in less than an hour.  I didn't have any network latency to worry
about, but I think it still shows its possible and a determined attacker can
do it.

The server could be modified to notice elevated counts of error returns for
a client and then try to notify about it.   But, I don't think it will be
simple - I imagine it would need a lot of tunable (how many failed fh, at
what rate..  etc) because you need to tune the system to make a signal from
the noise of regular operations and returns.  That tuning can be worked
around by a very determined attacker.  You end up in a behavior
detection/modification feedback loop and the server's not guaranteed to
catch everything.  Still it would be another layer of defense-in-depth that
would have value.

> Supporting and encouraging the use of 64-bit generation numbers, and
> starting at a random offset would do a lot to make guessing harder.
> A crypto key could be part of making this number hard to guess.
>
>>
>> In contrast to a local user using open_by_handle(2), the NFS server must
>> permissively allow remote clients to open by filehandle without being able
>> to check or trust the remote caller's access.
>
> I find the above sufficiently vague and confusing that I cannot tell if
> I agree...
>
> open_by_handle_at(2) requires CAP_DAC_READ_SEARCH precisely because no
> path-based restrictions are imposed.
> The NFS server cannot require CAP_DAC_READ_SEARCH and assumes the trusted
> client performs the necessary path-based access checks.
> When the client cannot be completely trusted, and path-based access
> controls are depended on, extra support is needed for NFS.

Much better than mine, I'll use it.  Thanks for looking Neil.

Ben

>>                                                        Therefore additional
>> protection against this attack is needed for NFS case.  We propose to sign
>> filehandles by appending an 8-byte MAC which is the siphash of the
>> filehandle from a key set from the nfs-utilities.  NFS server can then
>> ensure that guessing a valid filehandle+MAC is practically impossible
>> without knowledge of the MAC's key.  The NFS server performs optional
>> signing by possessing a key set from userspace and having the "sign_fh"
>> export option.
>
>
> NeilBrown

