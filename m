Return-Path: <linux-fsdevel+bounces-74200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF66D38468
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 19:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F79730987B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 18:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2633A0B33;
	Fri, 16 Jan 2026 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="OGdSbia9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020095.outbound.protection.outlook.com [40.93.198.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083A8335573;
	Fri, 16 Jan 2026 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768588177; cv=fail; b=aAoTrWrrB+8DblgC5kPjfk3I8hnt1rlO+i9JhO3d/b7P0zIvqFMO8VeZGZ76xg2PP3bbnz26gToiQx2oCcT0W5LpmxNOKHUwciIW1SzZAvzuHMeiLZMxAXP9y6O4UGFHUm4iawMj+/IXKosyTf8FFJw+KtAZIdrOwP4u4Hx+AgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768588177; c=relaxed/simple;
	bh=B2lWIrtlhIIyk2kO8fKD7QVSpFohiWMu505o3+ahMZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tnxS3Eyk/b6OmwZpiSnjnNQxn+Q90ftF2FS2fIbUxjOAKCJoQsb/UmjAyyw1BIgOV6jOgcpt3gGzZnmoR7qsJf9J0/NcQJ5PN2EkSIeyH6zEQWzcSGqZxXko695xkepFJ05MgC5rFOxjGGArLK7Sk+shi+pifw3SN/O8xf2mUlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=OGdSbia9; arc=fail smtp.client-ip=40.93.198.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUPhkkWk4MsVlyhviCmnkk1SaPP5JgxgHCRQLRh1yxnzuGWl6GAT38tefqu1s+fisPandW7Yor/a+7ryTFmntox3p3vYZ622UTvGilf1PdKwonAWwhfrnFw5ukNS4DnwkMOBZJqnGntnj/xOLuhXHT16VxsvtYytrIM6w/CMKjZ5B3lhPW5JBA8T8J3GRxtgbpfxblOydYdpB/fKpEabfu+tBEeh/rvNraxF49TyHDKVbXwueTVxaTSC4qeUIBuA1K9aFR9Ybg7bgRud7Ga1m0QY4QTbl3kI1YoT3aKD1VJ1ENmSAuXT/CDH0lN7GG73F1QgisIRQ422YQhd/EyMaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wtpe6fF/hOLbVTOPmqiDG2Nm54x8feWoWx8gvtLIaqI=;
 b=vTY117UxjiDwWUX5heQqjmGsV6vGwb0RMzfulWNigdm6ILjv5P9z5gVI0qq1iXR7c0pgxiFmZGb9qZ+/xOx+M8oDwlb7t34+VULzFtQeJkvRiVdevlRhxWSkZde+omtLjY0i8KNOgKwTH5X3BLO4/aX2poLu4vJsTNk4lEm1A0aaEd8nLMf+OS6/ZxYymE6i9UUJuhz4k3F08YJpVwzYNgr7X+6+yvBeP4Kp1U8PpPsv2nt0nc4rlrvo3icc5dNte/0Wnuvh6LYzm2bUIA9q60ljXR1v5dciLjb2CbJB+4ndhBgrDoLtnnlzewKPYni/6OwYfoLnnvH+clm4TXlxOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wtpe6fF/hOLbVTOPmqiDG2Nm54x8feWoWx8gvtLIaqI=;
 b=OGdSbia9KqFRDULfHXkBwwgRn7tJ8Emk2pT81z+MfJ5BMBqseHIvynbmCkPjO/OY7hLVRzPC9Urs5XHRc1P+4IxR494F/npYl6ijXMZhcdZOLUHxe4ffUTv8WNjfkhyA1gtNAmrcIrFNEl5TeByBg4e/TFFYVab98aDnojMTqQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 CH3PR13MB6533.namprd13.prod.outlook.com (2603:10b6:610:1bc::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.5; Fri, 16 Jan 2026 18:29:28 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 18:29:28 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v1 4/4] NFSD: Sign filehandles
Date: Fri, 16 Jan 2026 13:29:25 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <FA695E2C-7563-4083-91CF-69DC0CF88F26@hammerspace.com>
In-Reply-To: <2b28af6e-a6da-4f10-a589-6dd20d2f2c6c@app.fastmail.com>
References: <cover.1768573690.git.bcodding@hammerspace.com>
 <9c9cd6131574a45f2603c9248ba205a79b00fea3.1768573690.git.bcodding@hammerspace.com>
 <2b28af6e-a6da-4f10-a589-6dd20d2f2c6c@app.fastmail.com>
Content-Type: text/plain
X-ClientProxiedBy: BL0PR01CA0036.prod.exchangelabs.com (2603:10b6:208:71::49)
 To DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|CH3PR13MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: 8899bf0b-b5fa-4fc5-c891-08de552d2eb7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kver8I+mStGM8QDVAHTwQlAMnNFrbYVNCsbZL7figCUqyAsCyOlJd7521pvW?=
 =?us-ascii?Q?ZD839n8Laz9c0EaHLBEFosuVCUnmyfumlLECrihQhJb6QrE3m1yuWXJFceDT?=
 =?us-ascii?Q?Zs4GcqwGNhooRI0QcM+IRHPg4h8a81pylf2M9tgDnszqNCnm5EHwwmniSLBW?=
 =?us-ascii?Q?njU0i4zyl6ohfhJUeHGpvkA7ifN3vqNWZlHHatOI2tiBxZB8AIE0HRe0ol6N?=
 =?us-ascii?Q?SVvajAb4dWKX8HPH2b3nvKaIo8Tbcvh5c7RJVSKCy917oR0OiWf2lghAg+rF?=
 =?us-ascii?Q?TVuLzd2R/4EC8YtjTaoBJyN4fXAL/qUZ3q1ctUS0nOREVQ5xtLkgvpoA2euc?=
 =?us-ascii?Q?EdYDsZR6kEbIcB0t0hfHv23QAfAmRFS8tXZYfOmCBs4aW4cTneTdjXLmhdY5?=
 =?us-ascii?Q?gGFVRHyopnUCbpkcxuiy7wbLXDoau835VKBKC95umKIS2CgKGPtwY4w81S8r?=
 =?us-ascii?Q?vcEmIYdb0Dwr43h3Qfk9QdVj1yf3Mp8EgHuD3eeT94GotzcSgGcSbWs8QLO5?=
 =?us-ascii?Q?g+9UBmswfJJJxx85CwAm1uUKcyBVo8iKtIvwLsdqTCmIktRoLqoj9WIICnH9?=
 =?us-ascii?Q?y8ADCb3OZB1D5EiZJNCQTaBsHo0eZ8yeqWton8MU6JrLR3A+SoMYWVdnOytI?=
 =?us-ascii?Q?HMzNV4BoLx8GbIf7YuIC34/Q73Tt9UtVh1Z+xJ99BAqz0dJIqKeCu4ttIUmo?=
 =?us-ascii?Q?ApiTJms30+Ig0zNxjOQCHV/qqOQ2hyZHtXW04VyRZvgUQMR3iKclXxX1uGZC?=
 =?us-ascii?Q?+fIhb/3Y1hXxyWyKRTbmLCDXt0jWddmvq7XLMlpObZX/S7RxfJle2jynomZg?=
 =?us-ascii?Q?TsCQHoOqN2k7iJqIuUpQkEJJpQCwJozziq8bS4AOdAHXuy4CJYxFbCbQEkzu?=
 =?us-ascii?Q?W2Wj3lEmkJV44UOITz47Cg7cui5E66Dk7TZWvxJLc9iz/BUTQp1Zrb5XKbCk?=
 =?us-ascii?Q?Z7SH2mxNxkItlxr8edLy7791WLlAzTSSxtNNpaLgk1aosPBDvkGnZD086Xe7?=
 =?us-ascii?Q?ZnI7UpUDyk6YR9OBXqRmBdCnTK7dhD7O1IXSc09PoedZwffPpYLJv69ovJ5a?=
 =?us-ascii?Q?UuTBiKWEc0rxsO1c6oEb+/7uFdVwRUolmw9GzaANhdIxLTxWx2+5W8DH7qK+?=
 =?us-ascii?Q?2uIJGB4dn7VtF6VBtZm9hxOk6kE6j3rZTKn5wmVXErzBLVNF43iXxlG2gIm1?=
 =?us-ascii?Q?BrYe6lP7ad84AXCPQzav3kBVA1SjrqBq9lUFP5D6EObzRPGSVDmls+CI5aCM?=
 =?us-ascii?Q?FOuwvaGP4sksUOf/cia2U4vjaUtYzZALpdrK8i4fWFzTsYgfSSBgYKykX5pa?=
 =?us-ascii?Q?z+yS1SjTTSc6JxqCLVL4noIEwcPnGka6CSIUfNz3f1GsI/deC5OWHM1KX+iY?=
 =?us-ascii?Q?sZy/j+60moL3MSTOTb882ahDfXI8JgPEKFFi4FsPKwr7mofahazLj9ag5H+7?=
 =?us-ascii?Q?c9e+0Q8bFibrWrXUwQoLDd4IRzU/VddcBWaAXNGEO0n6n+sMYwOl4QHZA+YH?=
 =?us-ascii?Q?94KCKG36Sjx6DAKbBGTiQpCfAyVv3htVrI0qX9w0tgo+bEtYB51L/fqgvXsd?=
 =?us-ascii?Q?bkqQ9OgFiTqewbmRpG4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YfZ6wCtyySWLdccntTvBzYPLFRk/Fr2uEBEs7RMJYttSGxRRQfdGAh6qJq+D?=
 =?us-ascii?Q?yGsdwjLj5PFGk2tJSjsLR8aZLq4YKpoOnO86t5/yDGdGnkDDO4DHDZRmXElD?=
 =?us-ascii?Q?bAK8v/IqSo3RhvqMjk9TdsNkbEkeQnVIzyAU9dCRZjYp6bokG7yU3L/NVtA9?=
 =?us-ascii?Q?c6+ZZTW51KPJwOqoQvGL0/x1uxtNFjhw49yLeCyeA3x/V9PyqCj4cgXUC5Ul?=
 =?us-ascii?Q?yQbf4UF1MWgbINOLZKsc7ryTSwBtzA42cCSAqw3z5vMVBmQEhvczXxuazNi6?=
 =?us-ascii?Q?kLwyIkdxO43wyXzh89UXkSSXx0xO4Ee3c25ODnCCkcMveO5aum5wFi0N2KIz?=
 =?us-ascii?Q?KfH+FgMlkCdfB2UP6GCeaSh0o+8qGpnZVNuwI4hcvznl75uyr+dMc8RpEVy0?=
 =?us-ascii?Q?PbRMXKyxBUfOouiGrExEe7a66s0kPt8qGddHFYKRAA8gXXWpN26CIloy/7P5?=
 =?us-ascii?Q?91YZET8j44hjRlCE7NW7sxPD9VIprxr6BdiPm7joLXsrOL5EvqSqJzvgPVTE?=
 =?us-ascii?Q?v3P8qTHw+TKCCMyRncLAkjLyH6AxnEwuYpRPivL9SJ8LOEmG+3louSNplIc1?=
 =?us-ascii?Q?86C1eDi5wZAsSOCEHJ551ocBeBJar1T9q1buWXGPMMxihPQjO9iu3aSLydqK?=
 =?us-ascii?Q?EYb3Lcw+UNUjDecsdeTZURnlEFPHQ5R17TGPQMgYVrQFhzi9snjDYBgZWBkv?=
 =?us-ascii?Q?6Hzn6AfNo6wAR3m4phFI4geqaKGrCmD9MMrhOrCY6Fws2uk+jE490QclbgNb?=
 =?us-ascii?Q?dCadcQCZ5WVNKkYlDnaS00Gg941xNrvWdzcWnltu6+3DjkEP8CfaMvxbu+jS?=
 =?us-ascii?Q?cpVJAq4HKZllhu9x9tKAvIveZqU6NW90gXk4dyXa8uNmdacwGla81O+w6x6O?=
 =?us-ascii?Q?ht5MIDHCsh+UK/zVmK7oAAWLam87v7P2V9FwSQRWMig3r0nf2JkhKkFyn/Vg?=
 =?us-ascii?Q?eIiWQvD5Lvo3qsd05U0TeAFcvD2o5aAkkNu/tDtt9jZxYvNyVu09onKmlefC?=
 =?us-ascii?Q?6yF4OXuy2pGT4BRctU2LH/4cTmc4RxHM3WBoWrmVfkCw8IBXwWkY+nISYjoH?=
 =?us-ascii?Q?F+xVoUjqMqTqil0SaLgpmArDJnnrDLcBTRi4yn+gJfooXoPnPKhRqTBs6WPY?=
 =?us-ascii?Q?/VOkzlWixYJlDLmOQG8m+oRPNunaJ+GBcjlN4Naq3+PSjLnkmEf0Tfpn3JAZ?=
 =?us-ascii?Q?prukwPX+lF4RA9KY17dh9WfXeCAydfPWuGbZ8q1X96oT4bRIVfLu31lb8/RZ?=
 =?us-ascii?Q?sADMKjOlKc60iNjU4Q4ic2D+n4+q0IxwJ3NZRH//52Ypg80fUNyLBK3worNf?=
 =?us-ascii?Q?UnNvSDU6wevPA1V6P3RAmyx1bxRceWrpQJCcEr+7lq1297qzrEBpbjAaDBoD?=
 =?us-ascii?Q?Et6FFTzgC5S/YRbtfmUNqiNFQJfutTDWzNArjg46Bq2k3O6M0AEZrZxOr8+E?=
 =?us-ascii?Q?RW9p1Pf77XmybowXc9/1+scazioSzjeeCLuDaTJAEULqWbcc0Mdvh/EYZQP4?=
 =?us-ascii?Q?nwyAUXGUSpL8Bqn9Qc2fu+obStpbQYRZx/cvSbXzzx9vix+uaVdhKz8bfwxV?=
 =?us-ascii?Q?C1rBFb/8QNymzEr7hj6J+CyHE7T1Uouere92PUgWIyW4vXD/p/4OZP73GkTL?=
 =?us-ascii?Q?GQU8wwok4DU+ZXye4hdOSQJt3lPtBmXRsSR12WAhSaMQBoyLGXOjMNbPKmML?=
 =?us-ascii?Q?ej/rzgEjj9FpdJofNFdjtOsgPlXMEa/6uDgb6XGXengVG3sumoAdVA3iY8tp?=
 =?us-ascii?Q?K9NPB1eXtlBxQVM5Edjibp0eNpxhvt8=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8899bf0b-b5fa-4fc5-c891-08de552d2eb7
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 18:29:28.0052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNbk2WoGEFC+JIVzLN/FBo7V4ietjpWE1bFAWh7kPN3+3bZsB5jForCkmyMoXE9SFtTLDWLs+BDgiUBlWYb74GLxoZu4dORNQ+y+14H6sEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR13MB6533

On 16 Jan 2026, at 12:12, Chuck Lever wrote:

> On Fri, Jan 16, 2026, at 9:32 AM, Benjamin Coddington wrote:
>> NFS clients may bypass restrictive directory permissions by using
>> open_by_handle() (or other available OS system call) to guess the
>> filehandles for files below that directory.
>>
>> In order to harden knfsd servers against this attack, create a method to
>> sign and verify filehandles using siphash as a MAC (Message Authentication
>> Code).  Filehandles that have been signed cannot be tampered with, nor can
>> clients reasonably guess correct filehandles and hashes that may exist in
>> parts of the filesystem they cannot access due to directory permissions.
>>
>> Append the 8 byte siphash to encoded filehandles for exports that have set
>> the "sign_fh" export option.  The filehandle's fh_auth_type is set to
>> FH_AT_MAC(1) to indicate the filehandle is signed.  Filehandles received from
>> clients are verified by comparing the appended hash to the expected hash.
>> If the MAC does not match the server responds with NFS error _BADHANDLE.
>> If unsigned filehandles are received for an export with "sign_fh" they are
>> rejected with NFS error _BADHANDLE.
>>
>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>> ---
>>  fs/nfsd/nfs3xdr.c          | 20 +++++++----
>>  fs/nfsd/nfs4xdr.c          | 12 ++++---
>>  fs/nfsd/nfsfh.c            | 72 ++++++++++++++++++++++++++++++++++++--
>>  fs/nfsd/nfsfh.h            | 22 ++++++++++++
>>  include/linux/sunrpc/svc.h |  1 +
>>  5 files changed, 113 insertions(+), 14 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
>> index ef4971d71ac4..f9d0c4892de7 100644
>> --- a/fs/nfsd/nfs3xdr.c
>> +++ b/fs/nfsd/nfs3xdr.c
>> @@ -120,11 +120,16 @@ svcxdr_encode_nfsstat3(struct xdr_stream *xdr,
>> __be32 status)
>>  }
>>
>>  static bool
>> -svcxdr_encode_nfs_fh3(struct xdr_stream *xdr, const struct svc_fh *fhp)
>> +svcxdr_encode_nfs_fh3(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>> +						struct svc_fh *fhp)
>>  {
>> -	u32 size = fhp->fh_handle.fh_size;
>> +	u32 size;
>>  	__be32 *p;
>>
>> +	if (fh_append_mac(fhp, SVC_NET(rqstp)))
>> +		return false;
>> +	size = fhp->fh_handle.fh_size;
>> +
>
> This is a layering violation. XDR encoding never alters the content
> in the local data structures, and this will be impossible to
> convert to xdrgen down the line. All of the NFS version-specific
> code should not know or care about FH signing, IMO.
>
> Why can't the new signing logic be contained in fh_compose()
> and fh_verify() ?

It can - I originally had it there.  I moved it after finding that
fh_compose() creates a partial handle requiring fh_update() to fill it in
after file creation, and IIRC there are a couple of other fh_match()
gotcha's buried in the server when you're not signing last thing before the
wire.  Totally doable to move it, I'll work on that for next version - but
I think it will mean that some other parts of the server will need to become
"signed filehandle"-aware.

>>  	p = xdr_reserve_space(xdr, XDR_UNIT + size);
>>  	if (!p)
>>  		return false;
>> @@ -137,11 +142,12 @@ svcxdr_encode_nfs_fh3(struct xdr_stream *xdr,
>> const struct svc_fh *fhp)
>>  }
>>
>>  static bool
>> -svcxdr_encode_post_op_fh3(struct xdr_stream *xdr, const struct svc_fh *fhp)
>> +svcxdr_encode_post_op_fh3(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>> +							struct svc_fh *fhp)
>>  {
>>  	if (xdr_stream_encode_item_present(xdr) < 0)
>>  		return false;
>> -	if (!svcxdr_encode_nfs_fh3(xdr, fhp))
>> +	if (!svcxdr_encode_nfs_fh3(rqstp, xdr, fhp))
>>  		return false;
>>
>>  	return true;
>> @@ -772,7 +778,7 @@ nfs3svc_encode_lookupres(struct svc_rqst *rqstp,
>> struct xdr_stream *xdr)
>>  		return false;
>>  	switch (resp->status) {
>>  	case nfs_ok:
>> -		if (!svcxdr_encode_nfs_fh3(xdr, &resp->fh))
>> +		if (!svcxdr_encode_nfs_fh3(rqstp, xdr, &resp->fh))
>>  			return false;
>>  		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
>>  			return false;
>> @@ -908,7 +914,7 @@ nfs3svc_encode_createres(struct svc_rqst *rqstp,
>> struct xdr_stream *xdr)
>>  		return false;
>>  	switch (resp->status) {
>>  	case nfs_ok:
>> -		if (!svcxdr_encode_post_op_fh3(xdr, &resp->fh))
>> +		if (!svcxdr_encode_post_op_fh3(rqstp, xdr, &resp->fh))
>>  			return false;
>>  		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
>>  			return false;
>> @@ -1117,7 +1123,7 @@ svcxdr_encode_entry3_plus(struct nfsd3_readdirres
>> *resp, const char *name,
>>
>>  	if (!svcxdr_encode_post_op_attr(resp->rqstp, xdr, fhp))
>>  		goto out;
>> -	if (!svcxdr_encode_post_op_fh3(xdr, fhp))
>> +	if (!svcxdr_encode_post_op_fh3(resp->rqstp, xdr, fhp))
>>  		goto out;
>>  	result = true;
>>
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index 884b792c95a3..f12981b989d1 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -2701,9 +2701,13 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
>>  }
>>
>>  static __be32 nfsd4_encode_nfs_fh4(struct xdr_stream *xdr,
>> -				   struct knfsd_fh *fh_handle)
>> +					struct svc_fh *fhp)
>>  {
>> -	return nfsd4_encode_opaque(xdr, fh_handle->fh_raw, fh_handle->fh_size);
>> +	if (fh_append_mac(fhp, SVC_NET(RESSTRM_RQST(xdr))))
>> +		return nfserr_resource;
>> +
>> +	return nfsd4_encode_opaque(xdr, fhp->fh_handle.fh_raw,
>> +		fhp->fh_handle.fh_size);
>>  }
>>
>>  /* This is a frequently-encoded type; open-coded for speed */
>> @@ -3359,7 +3363,7 @@ static __be32 nfsd4_encode_fattr4_acl(struct
>> xdr_stream *xdr,
>>  static __be32 nfsd4_encode_fattr4_filehandle(struct xdr_stream *xdr,
>>  					     const struct nfsd4_fattr_args *args)
>>  {
>> -	return nfsd4_encode_nfs_fh4(xdr, &args->fhp->fh_handle);
>> +	return nfsd4_encode_nfs_fh4(xdr, args->fhp);
>>  }
>>
>>  static __be32 nfsd4_encode_fattr4_fileid(struct xdr_stream *xdr,
>> @@ -4460,7 +4464,7 @@ nfsd4_encode_getfh(struct nfsd4_compoundres
>> *resp, __be32 nfserr,
>>  	struct svc_fh *fhp = u->getfh;
>>
>>  	/* object */
>> -	return nfsd4_encode_nfs_fh4(xdr, &fhp->fh_handle);
>> +	return nfsd4_encode_nfs_fh4(xdr, fhp);
>>  }
>>
>>  static __be32
>> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
>> index ed85dd43da18..b2fb16b7f3c9 100644
>> --- a/fs/nfsd/nfsfh.c
>> +++ b/fs/nfsd/nfsfh.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/exportfs.h>
>>
>>  #include <linux/sunrpc/svcauth_gss.h>
>> +#include <crypto/skcipher.h>
>
> Is this header still needed?

Nope.

>>  #include "nfsd.h"
>>  #include "vfs.h"
>>  #include "auth.h"
>> @@ -137,6 +138,62 @@ static inline __be32 check_pseudo_root(struct
>> dentry *dentry,
>>  	return nfs_ok;
>>  }
>>
>> +/*
>> + * Intended to be called when encoding, appends an 8-byte MAC
>> + * to the filehandle hashed from the server's fh_key:
>> + */
>> +int fh_append_mac(struct svc_fh *fhp, struct net *net)
>> +{
>> +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>> +	struct knfsd_fh *fh = &fhp->fh_handle;
>> +	siphash_key_t *fh_key = nn->fh_key;
>> +	u64 hash;
>> +
>> +	if (!(fhp->fh_export->ex_flags & NFSEXP_SIGN_FH))
>> +		return 0;
>> +
>> +	if (!fh_key) {
>> +		pr_warn("NFSD: unable to sign filehandles, fh_key not set.\n");
>
> Use pr_warn_ratelimited() instead

Yessir!

>> +		return -EINVAL;
>> +	}
>> +
>> +	if (fh->fh_size + sizeof(hash) > fhp->fh_maxsize) {
>> +		pr_warn("NFSD: unable to sign filehandles, fh_size %lu would be
>> greater"
>> +			" than fh_maxsize %d.\n", fh->fh_size + sizeof(hash),
>> fhp->fh_maxsize);
>> +		return -EINVAL;
>> +	}
>> +
>> +	fh->fh_auth_type = FH_AT_MAC;
>> +	hash = siphash(&fh->fh_raw, fh->fh_size, fh_key);
>> +	memcpy(&fh->fh_raw[fh->fh_size], &hash, sizeof(hash));
>> +	fh->fh_size += sizeof(hash);
>
> What prevents appending a MAC to the same FH multiple times?

The fact that it's the last thing that happens during encoding.  We're going
to change this now, so it will need to be guarded against.  Can use a check
of fh_auth_type.

>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Verify that the the filehandle's MAC was hashed from this filehandle
>> + * given the server's fh_key:
>> + */
>> +static int fh_verify_mac(struct svc_fh *fhp, struct net *net)
>> +{
>> +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>> +	struct knfsd_fh *fh = &fhp->fh_handle;
>> +	siphash_key_t *fh_key = nn->fh_key;
>> +	u64 hash;
>> +
>> +	if (fhp->fh_handle.fh_auth_type != FH_AT_MAC)
>> +		return -EINVAL;
>> +
>> +	if (!fh_key) {
>> +		pr_warn("NFSD: unable to verify signed filehandles, fh_key not
>> set.\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	hash = siphash(&fh->fh_raw, fh->fh_size - sizeof(hash),  fh_key);
>> +	return memcmp(&fh->fh_raw[fh->fh_size - sizeof(hash)], &hash,
>> sizeof(hash));
>
> Let's use crypto_memneq() for this purpose, to avoid timing attacks.

Ok.

>> +}
>> +
>>  /*
>>   * Use the given filehandle to look up the corresponding export and
>>   * dentry.  On success, the results are used to set fh_export and
>> @@ -166,8 +223,11 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst
>> *rqstp, struct net *net,
>>
>>  	if (--data_left < 0)
>>  		return error;
>> -	if (fh->fh_auth_type != 0)
>> +
>> +	/* either FH_AT_NONE or FH_AT_MAC */
>> +	if (fh->fh_auth_type > 1)
>>  		return error;
>> +
>>  	len = key_len(fh->fh_fsid_type) / 4;
>>  	if (len == 0)
>>  		return error;
>> @@ -237,9 +297,15 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst
>> *rqstp, struct net *net,
>>
>>  	fileid_type = fh->fh_fileid_type;
>>
>> -	if (fileid_type == FILEID_ROOT)
>> +	if (fileid_type == FILEID_ROOT) {
>>  		dentry = dget(exp->ex_path.dentry);
>> -	else {
>> +	} else {
>> +		/* Root filehandle always unsigned because rpc.mountd has no key */
>> +		if (exp->ex_flags & NFSEXP_SIGN_FH && fh_verify_mac(fhp, net)) {
>> +			trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp, -EKEYREJECTED);
>> +			goto out;
>> +		}
>> +
>>  		dentry = exportfs_decode_fh_raw(exp->ex_path.mnt, fid,
>>  						data_left, fileid_type, 0,
>>  						nfsd_acceptable, exp);
>> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
>> index 5ef7191f8ad8..d1ae272117f0 100644
>> --- a/fs/nfsd/nfsfh.h
>> +++ b/fs/nfsd/nfsfh.h
>> @@ -59,6 +59,9 @@ struct knfsd_fh {
>>  #define fh_fsid_type		fh_raw[2]
>>  #define fh_fileid_type		fh_raw[3]
>>
>> +#define FH_AT_NONE		0
>> +#define FH_AT_MAC		1
>> +
>>  static inline u32 *fh_fsid(const struct knfsd_fh *fh)
>>  {
>>  	return (u32 *)&fh->fh_raw[4];
>> @@ -226,6 +229,7 @@ __be32	fh_getattr(const struct svc_fh *fhp, struct
>> kstat *stat);
>>  __be32	fh_compose(struct svc_fh *, struct svc_export *, struct dentry
>> *, struct svc_fh *);
>>  __be32	fh_update(struct svc_fh *);
>>  void	fh_put(struct svc_fh *);
>> +int	fh_append_mac(struct svc_fh *, struct net *net);
>>
>>  static __inline__ struct svc_fh *
>>  fh_copy(struct svc_fh *dst, const struct svc_fh *src)
>> @@ -274,6 +278,24 @@ static inline bool fh_fsid_match(const struct
>> knfsd_fh *fh1,
>>  	return true;
>>  }
>>
>> +static inline size_t fh_fileid_offset(const struct knfsd_fh *fh)
>> +{
>> +	return key_len(fh->fh_fsid_type) + 4;
>> +}
>> +
>> +static inline size_t fh_fileid_len(const struct knfsd_fh *fh)
>> +{
>> +	switch (fh->fh_auth_type) {
>> +	case FH_AT_NONE:
>> +		return fh->fh_size - fh_fileid_offset(fh);
>> +		break;
>> +	case FH_AT_MAC:
>> +		return fh->fh_size - 8 - fh_fileid_offset(fh);
>
> Let's define/use symbolic constants here (8) and just above (4).

Actually, think I can drop this hunk now - its no longer used after a
refactor.

>> +		break;
>
> The break; statements are unreachable.

Yep.  Thanks Chuck!

Ben

