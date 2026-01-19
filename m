Return-Path: <linux-fsdevel+bounces-74464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCB7D3B036
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A044D30051AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680402DF719;
	Mon, 19 Jan 2026 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="aF1UkJMg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021108.outbound.protection.outlook.com [40.93.194.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653BF285060;
	Mon, 19 Jan 2026 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768839359; cv=fail; b=rAjc9vCX9+Mo4sh7CcAPuBWsDI2xaONrRp7uNPRvvxSS1d7OWycBjw4Kq6+0iyFRfwzaRYBeszZuOVOcpXZqJBqdVQ4A+uCqJcDtXJw3QOspMbaGNNsYvIRXkftAmPAV5HMppNTbtD1speOVJfNtU3/qUl48rn1ZpuP7YEZboTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768839359; c=relaxed/simple;
	bh=oehecxQvLpl3f/KdGBcbRtNpYLhmlyGsWD0jsF+XZz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YuqQYt58mf6Nqn6kDpvcrBnp+ZFmHf+vG1snDwmC73q+B9ZEpsWJlbhlTj7objLO0IneZnf66/it/hQU+z5hq6bgDP4/f+wcacqkxIaZTzyrWJTrkIlzUfpB/yr7KowXUrNn9ij6ERRfW3sLpW8hvjucpl1dyOtwMywX2SfBPhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=aF1UkJMg; arc=fail smtp.client-ip=40.93.194.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSvaDQ3xnRI9PheWxH1eMBJOuA3gZ1nfZ/c/cxuo7LZcLNvvpRDLIGQKxxcqa4mS9lRAAdQK/eIVo2vVnm/NnNsUjwBv3A4lveD5cxrInwOYUZuO2s2taxA3GGwSuRoau21ls3Eb2H+6vvhI2UlYpYItoULR+YTQwLJ7Wisyc6NC8UMCcBp5Ovu3j79FvBOq6ngl93LpmWeFbDi9MC0LEggnKFjLZQk+xVfi+4q2nhE+jxsOK4OPosQ2Hh3kWN2X96nP4uVXsIogCJDZaxZbb699cCiMWs2ZoTQ+6xejCsTmIUbQd4sHT6SvHNCg/0NF6miWBjAgNPyaZTvnUtECNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QSlCX6kX0+Wi2IyA4CdSlQRDsbjLjBbUW+Aj3QwIow=;
 b=M7IzkMUGJBEpjFJ9q272WsCOolxwvdBXmsaabwKbxGO1g7TyZQk/NWBIrzPI9l98fIszVTFad6uy9kSFWt0KcwB5Yv4a1dfkncTbxL2BGw8hAUCtvDZhxPjXTdKJkuP24vmM/hvrLx6uPNDEmfadXkowY8XBcjk6wWRWmI73JtmIf0JTA6/WFCqeyzVz/jxAXRKW1gj59asZC3CkKIA+uwbcN7LB9gsNmN8RDjHHUVfExJelxX7nuYkUSEjyxGpBVHhZXqlk9UFJME8kPngn7tu8bSJw+FLiEd03bluvLEMgDH9UfKDUwTjUXwruM5E9bDCWgxi7ctQcuLMT+WwRjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QSlCX6kX0+Wi2IyA4CdSlQRDsbjLjBbUW+Aj3QwIow=;
 b=aF1UkJMge8AS8pzqbu9vzsthJWGLqbj6N1IJifs/ivq6PziIrRfT8vZhEaAPJG3mZunpTQTVq148hN+l7d6swTIg92U+K80S5EnRsQVcC10NBeO5KDeqRfO3/NDZ9bzy4Nxf9+UzaJuwksPfcToTuD2IFTz+SA/TkgvsAsPKDfY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 PH7PR13MB6220.namprd13.prod.outlook.com (2603:10b6:510:24b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 16:15:55 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 16:15:55 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, Rick Macklem <rick.macklem@gmail.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH v1 2/4] nfsd: Add a key for signing filehandles
Date: Mon, 19 Jan 2026 11:15:52 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <5E2A23BF-83A8-4991-9014-99389BFCE237@hammerspace.com>
In-Reply-To: <3db40beb64cb3663d9e8c83f498557bf8fbc0924.camel@kernel.org>
References: <cover.1768573690.git.bcodding@hammerspace.com>
 <c49d28aade36c044f0533d03b564ff65e00d9e05.1768573690.git.bcodding@hammerspace.com>
 <3db40beb64cb3663d9e8c83f498557bf8fbc0924.camel@kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0347.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::22) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|PH7PR13MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e1e2a21-1c18-482b-79e2-08de577605d7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1UrOUXxgXIiF/R1YKKTSPJMB+05pOXV15Bojz4N8BmDV5JeK17KmAFLZ2QGL?=
 =?us-ascii?Q?KqyCMeTwR75VfocCO70dkxhJgK+NRwgm+ynLXH3cFXaxXXwdQTg2u7tk3Eru?=
 =?us-ascii?Q?7wcrD26Nhr9/LIlncdoLu4ZJcaAhR3ATYS4RD3G9xuD8klZhF1IhKAnRpK4I?=
 =?us-ascii?Q?GMT/SOE+5sUVFvym8F0fEySAOWNAKK0Pl0SqYtsA7huzsbbOwFyH59Zp0J8t?=
 =?us-ascii?Q?RilwBvjtNwUPpSF9/ET6N1yGwii3A7/rQiFY6pmcDXtMZRND6RmELLJsbzU/?=
 =?us-ascii?Q?JP0G3dVf7pzV+0dXu6y+ZTjYKaf9J3MCCYxTIZcKZB7AU36FoEWe05GcJzP7?=
 =?us-ascii?Q?Y+rUu+Cftvub0aWDZv1NbdZkSdtpNkyTiW9R3VSeXh+btPC2+7xsIH9/mjfF?=
 =?us-ascii?Q?QvGTB4jfWG39/j3HMGOVpXaAgUKztaMzvxSfDCQBKS1Gb/4kpguk7T1Wwbf4?=
 =?us-ascii?Q?yeex9E3BRK1Z+OtQRUV6np3uNIBmCLWD2fX8K1b1BaUsZgBqlQbdEMZHTYiZ?=
 =?us-ascii?Q?hRUW4KpwDoj/pyAVeGpICAzMyQ8GRkR2D+Ewr6Z+E8v5BKKARiD/Z8Cg5BHt?=
 =?us-ascii?Q?c5xPdmz6usEfCOuqlsVvipXBWtJFwvrT63M7Srsbn77kzC7jw1zBN+v5hoD0?=
 =?us-ascii?Q?c1KVZOZ2UcIkPiDKwlpuKJwC+oYDN8HQV5t5P4qy6nJFVw9ZkJOk3UypFFmt?=
 =?us-ascii?Q?mB9WX6SyWxyObxZo3gIXhb6gEfTNqM+oUkefwRncB3AriBkJ2yiTyyWtIRoJ?=
 =?us-ascii?Q?6wY41lVh7Rdc7gMKPqRcQr38q6QAXFPYgmVlAHIMm7S24EY8VuGPUKzIJZUn?=
 =?us-ascii?Q?2yt85JzXRnwEr2TpdyUO32xCWKnmSR2+t33AInHyqkSwfeEKBoc3gdbTwfgH?=
 =?us-ascii?Q?oocwJ24PnQvsxqEm160AjaBx3L4/T3Z2ORF1a7LlrPfPmnp+tUrkjirarUfA?=
 =?us-ascii?Q?Qafxfp24NVYE0rr4DW8w6bQ6GlgYuBzNCerDdIhPN6yMD04YEuCtnW3UOobB?=
 =?us-ascii?Q?k11SBILD9bdLw4iz48g3Vmy8uicnmhDLkpFvmXOgyf2CpQIysfQHPAyhvZy4?=
 =?us-ascii?Q?GNDXPz8IbVPP/r6NfLp1HB9BpPoDpU1uXciGM9ZzZ3kq2Ju6DlGbExh3HRsM?=
 =?us-ascii?Q?dNxT8Qa3Z6MAlh3uQse+TiYnXZQNEfEoYLgAV/fuLf8WKYc1f+PARHKOnpH8?=
 =?us-ascii?Q?giTA2tsNu0BqhonNCAS01AtVYtiuvDygosnE+4HisBqhsmUQj5QxSWXDBRZl?=
 =?us-ascii?Q?bRTem7FiqjsKZk5AMYHBuOzsGHiiDxbVJxYIhfLslqM43JBw4b8S0rcDaUgf?=
 =?us-ascii?Q?YEqCtbRELPRD1K/iMj49vnf8ahCllcWKdwmLNnDIgzHWa75CW1kHag1KUmch?=
 =?us-ascii?Q?KU5Jx0vfLh2xZZ17Hhei+UCC/rxQXav3HvI56f2bcswGf/u3m6WUsHxq3ixL?=
 =?us-ascii?Q?u2K/gQq5G18qZV8BwSDH3oSjT7dg8fL+YPfdDgQWwcv8FolrwZUE9Rszn7K9?=
 =?us-ascii?Q?fCucVgx2KD9Xwr2Bg0uYX9hKDFRcnuKz7hb3mI2VHC5jHU3UkgCsyjrLSpgN?=
 =?us-ascii?Q?4bWEW1clIHXYG7gJRwU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PnYztAnZz0fMCpFb+9QjAqTx+Gn+DoYEj4aM5+CioWxRqwaUSK6wunrdzAGj?=
 =?us-ascii?Q?suY2w0hEyjn7jYNW60aPPxt2MLdp2JuVuhQotbzqiWPzBh13CgxZF0mKjrh1?=
 =?us-ascii?Q?EEDi5EAVHSmPdneNPoFVCds8IE7SNzSU3C2QeHVvm7BPk5QL/rV+yRTgg/GR?=
 =?us-ascii?Q?qXB4zDWIsEJt6XhLGnokXrQ+2bL/MOtwL9RRPtrEBO/WvFgnJf42iFpUT/n3?=
 =?us-ascii?Q?i0lOigOYElh0YI4zN4up6ai8IHyotWmkFLCflNTQko3q3eUR3XN5PSF9rtPN?=
 =?us-ascii?Q?BzEesOnXmrztS1kyts0wmLVefmPXFCQgnxy3+uRMAbzCqOnysUPCtVxbFq+S?=
 =?us-ascii?Q?V8xVFwiH3pKWYVPCCAProisvX0WsraCq/Nm4PpJM1iyzZzospY1fsOpZ17Wm?=
 =?us-ascii?Q?ljryObdtjGFfRo/rX0LZ0gTtEOQZugIrPJ4gQs8oW2cmTdJg/bEyFF+2xcFM?=
 =?us-ascii?Q?tp+BSsEzM6famunvpjVoxCByemUev+HcoYqzTeNN/EOxey25ZipZcIv4LFlB?=
 =?us-ascii?Q?UYyD/1R0w9G5RRkQHhali+/mEKS4fhjMRBOGJEL0EnwGGvctko4C7nzgVIbS?=
 =?us-ascii?Q?kHRIGHfs0byUoAmrNyy59Nmz+q3qc3ms+/t0JZdfGT3q+n68/vBz73vgpTA/?=
 =?us-ascii?Q?MAsdD5WWJ+3x7VOi7DZhVJViZ7AAr9j9DOEtMglYrDbBhYoWc6upT6Gf899R?=
 =?us-ascii?Q?SorMb/zTxzADGLrPDbE76MEwiRUvZFseY0Pcw4eGybQNtc4KbxwDsQHxH4uZ?=
 =?us-ascii?Q?ulHqeeKzz2JP7Q3htjbpFfjK01fJ+v+mATUMiFyBbDgJnPmeH5CZ4XigHh2v?=
 =?us-ascii?Q?7ZO1HM5FakWxMvx2kfuhuKFnZl9EuyNXk4V41OrwSbVMkcpoSV54TtBm6iNf?=
 =?us-ascii?Q?o7xXD7XIgpQKy94o2YjjQjyEAa7SF4BMaOx4SYYBIa9LhfQIl2UtVUSB2RAu?=
 =?us-ascii?Q?7CGwlyI29FVoto/itIMw6ic5Hbu5uIcURTWWJssnsIbhYeXHfBK/bhruQuEB?=
 =?us-ascii?Q?10PBOffxKK5LugDvXrRu9RpStGPxEeLDUzSSbax3TWVvo3feWq0FMSQklhJU?=
 =?us-ascii?Q?1Sa5UUT9sawrnj6AtOFe1vW0bReCbHNUdsdhqAwj3h7Tq9fSqBqUSX84/hMh?=
 =?us-ascii?Q?iPzYklZNHbT+WCxnGBiIn6ioqWmvP5aqf6rpLsHGFT9eSvDwM6e36aQBMerb?=
 =?us-ascii?Q?JXqAACnNcL43habrVVDYisywEBhN6/H3wok6fVOI9VEw9eRNgvqdEpyKy/TZ?=
 =?us-ascii?Q?r2zWqEo0inTsvOtzmJA71yt2jXwx7tbtm8L/Qq1dVFIa8SdYAm31q88Eiv10?=
 =?us-ascii?Q?haSAP/LUlTEImLTURTRaWH31147YKVnD7R5P+YJLH7hOKu1/puL58AcxcqFY?=
 =?us-ascii?Q?UuEyyAxkKRo25UP+7Npj4ZiM+n8Cq3+B3PoHHju6FDQFXXdmH7BKrCRIQhq9?=
 =?us-ascii?Q?j0aPDhqd0hkZyclS1ulcHHDSrcIXiyFYU8aBDSaI2RYImq4Vn8TEvsFlVInS?=
 =?us-ascii?Q?hPr7zI6mAWd55PguCX27sx3W8j0xkEjkaNciPiW7ccBpU9xfEmJzBxtArsAP?=
 =?us-ascii?Q?EmoCTxPB1lAxGtGIDhIp5eWsHbGSGYzfEA2QjSf+JS1nn4cpXrH53zFR+kfn?=
 =?us-ascii?Q?4bpuVKHcw8prwY3nEKVMsKS8+q+8kTf6bmMB1Mu76YTa17V7fFF8w20f1fpp?=
 =?us-ascii?Q?C5B/feUq93CZsujwiS1KSst1m2/JQd3vEmrLaTsXhyHnEke1RuGEnL20tz0m?=
 =?us-ascii?Q?eaYRFydfWdyCksqDtMG0z2mvz929uSk=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1e2a21-1c18-482b-79e2-08de577605d7
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 16:15:55.0526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUedTLZEpH0hQG5gh+OlfoVO5ctp4AtV5EJzhgbYBOIES0e1NX3TpHZgE5gr7yCYaKfiPUPG3dDBBkyKi5Uh3AJSpj+Toxw1kBQehfJM88g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB6220

On 16 Jan 2026, at 9:59, Jeff Layton wrote:

> On Fri, 2026-01-16 at 09:32 -0500, Benjamin Coddington wrote:
>> Expand the nfsd_net to hold a siphash_key_t value "fh_key".
>>
>> Expand the netlink server interface to allow the setting of the 128-bi=
t
>> fh_key value to be used as a signing key for filehandles.
>>
>> Add a file to the nfsd filesystem to set and read the 128-bit key,
>> formatted as a uuid.
>>
>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>> ---
>>  Documentation/netlink/specs/nfsd.yaml | 12 ++++
>>  fs/nfsd/netlink.c                     | 15 +++++
>>  fs/nfsd/netlink.h                     |  1 +
>>  fs/nfsd/netns.h                       |  2 +
>>  fs/nfsd/nfsctl.c                      | 85 ++++++++++++++++++++++++++=
+
>>  fs/nfsd/trace.h                       | 19 ++++++
>>  include/uapi/linux/nfsd_netlink.h     |  2 +
>>  7 files changed, 136 insertions(+)
>>
>> diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/net=
link/specs/nfsd.yaml
>> index badb2fe57c98..a467888cfa62 100644
>> --- a/Documentation/netlink/specs/nfsd.yaml
>> +++ b/Documentation/netlink/specs/nfsd.yaml
>> @@ -81,6 +81,9 @@ attribute-sets:
>>        -
>>          name: min-threads
>>          type: u32
>> +      -
>> +        name: fh-key
>> +        type: binary
>>    -
>>      name: version
>>      attributes:
>> @@ -227,3 +230,12 @@ operations:
>>            attributes:
>>              - mode
>>              - npools
>> +    -
>> +      name: fh-key-set
>> +      doc: set encryption key for filehandles
>> +      attribute-set: server
>> +      flags: [admin-perm]
>> +      do:
>> +        request:
>> +          attributes:
>> +            - fh-key
>
> Rather than a new netlink operation, I think we might be better served
> with just sending the fh-key down as an optional attribute in the
> "threads" op. It's a per-netns attribute anyway, and the threads
> setting is handled similarly.

Ok - will do on v2.

Ben

