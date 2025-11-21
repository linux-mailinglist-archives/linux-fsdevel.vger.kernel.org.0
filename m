Return-Path: <linux-fsdevel+bounces-69335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5F5C76D74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 02:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 021134E29D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 01:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FD3274FCB;
	Fri, 21 Nov 2025 01:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="G4tZ1MGO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023120.outbound.protection.outlook.com [40.93.201.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2840E211290;
	Fri, 21 Nov 2025 01:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763687232; cv=fail; b=crZcyYy/DJ+u1lHLEvt/jrzZeoYrlwA9KwrPmujRl4i7ADEWGEbq4nH2kGUPEDIoew7RkzFmWx4eV9p5JIa7mW5wrdHOnn0ocK1m3o2rSNAfj1eZUOezQDfpil9lrKCIetW4/r+WSGNpHwlNIgj78LcuGnxJQN83vPYEabpvd6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763687232; c=relaxed/simple;
	bh=5W9vDWRUpK7/YpviKkO3iyPGu5glbWu/ObS3WJzrMbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qojGiujGmn+izx1Q0VPMFQj5o9bKCWVP7CIihJQuiK5bs0iw3W8SWXDS+EfDD34dz57XlFk77zH5BSrK+9mxGTWQtm9bJLPX+v6/PtbSD7fC6BBx1Lo+DHewl0E1/RkPkKu0HDO5Bgh2q+zEB8mnJCgcTaC1RLh9pfxeJRx46pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=G4tZ1MGO; arc=fail smtp.client-ip=40.93.201.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YfL1oED46yvPn4GVQ99Kk3BEjkheOYMBShVx9Di6NMu7r6SxvkstHEr5qhtLVeH8NJJDAomxQjwVAnoC/yaeRaiRC/mGcIE2ROTmL3ICS1UVXQx8uesH+RBpU4+JikG2PVxN9EzHv8KCLlZrtSwXMWtI7324Q/UlzItJKNukqK1Meu9YnzMQ51D3OKpZPatfzzxS4PxCk5XXuGd2kYNTMUCQuMc4VSQIYgW61gHfmi40ig0D79pjbgrCMy67MJugLlaMK+7WZsE2IgxiMydi7CYYyNS3dbDTHRQY/dJ3ftjbmlef3ZF5LhJRSIVjaCFmIS6qBEK/t2FGalyxdK87LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2BD1+MDS4c9XpdevGgKirO8jC/sMHyoPgKLI5iIDZM=;
 b=M6SigphxB0I8/QAnlrpKnyjot2hvQn/W9hbjX5M2iG1wh247MjVqajq8AJZma4C84OT5LqGC2zSkOYqsNcBmaWYi0Gn4rT/FIDkXrCiBw5GDBt/q8K2zGeORxoyvkp0PpQwMOSc1Ap+rXRiJdHckuw+irMJfraHf7sjKrMAIwbAMMMNC30Hcr11UU6oO1AqPr6mv9cPJCs63eEm6ud22wvvBfPI37oPJI9Y8Mk9IaFl2m23LP0YB8ahU+JD0NG5vym7HbNBRK/WJqc3/l9BhcI1Z5jTzoT4Oki5b2SVLyH68roJofaY16yyO9N/2YeJ3eYhXW71wTmzUJDuknsl7nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2BD1+MDS4c9XpdevGgKirO8jC/sMHyoPgKLI5iIDZM=;
 b=G4tZ1MGOXok7UwoHs51qTaTzCoQgxSRNhbpShGcasWrn8HL334cGyMx+15Kgc+XnLNkHf3HkUT6pdQ5s8erMynnHWrf2pW6XlawX6RUZpZf1GjwOstKTGbLTLEPvHHUfCGswu0ib7YDtj0lPRPx43+ovwaBexTaxdfCgU1kV+aQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by CH3PR13MB7070.namprd13.prod.outlook.com (2603:10b6:610:209::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Fri, 21 Nov
 2025 01:07:06 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 01:07:06 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 Trond Myklebust <trondmy@kernel.org>, Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v1 0/3] Allow knfsd to use atomic_open()
Date: Thu, 20 Nov 2025 20:07:02 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <034A5D25-AAD3-4633-B90A-317762CED5D2@hammerspace.com>
In-Reply-To: <176367758664.634289.10094974539440300671@noble.neil.brown.name>
References: <cover.1763483341.git.bcodding@hammerspace.com>
 <176351538077.634289.8846523947369398554@noble.neil.brown.name>
 <0C9008B1-2C70-43C4-8532-52D91D6B7ED1@hammerspace.com>
 <176367758664.634289.10094974539440300671@noble.neil.brown.name>
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0036.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::9) To SN6PR13MB2365.namprd13.prod.outlook.com
 (2603:10b6:805:5a::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR13MB2365:EE_|CH3PR13MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: caf01209-187e-47a5-61bc-08de289a49fb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GrFw++ZYOlH7E19ZMkgKn2+23sIlL03YJKv0G4yJsaJi8SIsprzrr6iIlJ3y?=
 =?us-ascii?Q?aO11VB5E3oU1Fg67mhIfCMnX1Ow2hEDZ4PMZ1eDOBasKdv4wZ1Vm7ydO9T+I?=
 =?us-ascii?Q?uQNNeVyddsar2mjh7zALk0Q0JePwWluKx9JLRbdYguqnJ606hb6zSBk6bVYN?=
 =?us-ascii?Q?ysT8m4YpGov9dYT18YhnLP/HINYRxStzE2bPGWKFAo7jgWVU5OB4RBhKxPS2?=
 =?us-ascii?Q?DV9enuLRtpYu/gwecEHzOFgwPw0JK5O5Pzzv6QpI9DZOycK1BYJ1Bp/rWkX/?=
 =?us-ascii?Q?Z0JpfqfPYTvK+AAymUNOXJxu1GmJPmm274IMlUDzZvIEy2umUbcbZIfX50vZ?=
 =?us-ascii?Q?Y5F5OySYHf4EL45R+Dl/9W5Xs2D5H5ETv2atR7zWBHNY72UIfZkkZ76Vg3a3?=
 =?us-ascii?Q?19nHLtxYUzANXlVEAYdzVh9zGC7x5xeO1DswSTncxpmC74B0BnLYsgcnEY0M?=
 =?us-ascii?Q?xQBA9JO/5eHuAq804bVP9bwmOgG9u7YEuyFlof+hPw2ee3LqYqqFigOB2Jyp?=
 =?us-ascii?Q?CqC1jtiW0lJAOIjMMCMQTzCzZqpP52MqLxL7nrKrxpzuxC1c67zD09v1OqiV?=
 =?us-ascii?Q?wTf4wBsjL22AfaGIRwZPcobHZ4jqrewecBrkvBs9aP1JgQfFuwY8HPVzwwIF?=
 =?us-ascii?Q?cj3XDVztUpE3U6YJeuPTmTp7riAN8scytrkvbEDpMZvX5Uf8EyiXmJRYp3Vf?=
 =?us-ascii?Q?x6XFM+vhIUIR/Rp3v+YGVA9WE1ioIGgFadTYD5aAekVYivBtNDvFrLYwljlw?=
 =?us-ascii?Q?k9btQxlqVKSRRIm/25PV/SC4I7kcQUk1Zpp9nOXxTgJU5XONLAG3LFQzDba9?=
 =?us-ascii?Q?/gSQRBKplAPyZzIqAiRHM7+sY79nN5Md2Z98WtpGmigEw1+VNUpNJDRh+1Z+?=
 =?us-ascii?Q?UmOwj2eospmYO4sstKA9i8+JyoNMWe9nKv5c1TQ7S/+ndGo/pEU7QR1/XjYh?=
 =?us-ascii?Q?ff4ku1WXver65CToK4wVVmxAUJfrS55QYSnhjDlgZuG2JsaOZqv8F6XnDC9Z?=
 =?us-ascii?Q?5+bF1PQrej4KZqLMg5uariJ/K0tiI6+FY3CvF5RdV8GBKmb/qf1BnG6d9The?=
 =?us-ascii?Q?ZSX+7MMWOJ803QyQE4ePpIhJikdydl/9w3QlySDdF6kn2EJVO9OfubRwpBYE?=
 =?us-ascii?Q?lCuEQC2jyx36/XTlAO9ukbGbYxcQoF1eN3MDRBX//j6DWowcg9mcLnA8Stsc?=
 =?us-ascii?Q?eBrh2eBlsSdUnaXCH04Ga3xSgmM5DcVeCZTQJepjiIwWI6Bma6Qo1kAhxQFw?=
 =?us-ascii?Q?PaG0xAin00l82yDtCFSQkvECGnxuWORZLF0OHH+0rltxlreBLMA/nDMGDiXP?=
 =?us-ascii?Q?fujMFatBM0j2ttXzWR/9MqestEtn4EQbWceKQ0EcE6NELo4nHqj7593xXnc5?=
 =?us-ascii?Q?i1d0F319oshM+wHg+Kg3+xZJC79a8lT4w79RvYIMTYBTAVdSId539gFl0NIM?=
 =?us-ascii?Q?csf1tbzI1WdvY2XmJ8bRUkhHefB0U+oD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9CE6YXh7b0uaw3sHfe68s7rwIyVXfPw0v1MDosc33XIyQ3slFElF2Yp7SXZE?=
 =?us-ascii?Q?enDZlBa4WKqGEqVdNBIz0xSx+g3G1LWoDouAyATx+O5OacEnrEQoaw/SUsAr?=
 =?us-ascii?Q?5eGf25HRrVbDYIiryPAAOJdqniwRKDeaFNtW6peoF55jc45BDPRUcxSAM3lY?=
 =?us-ascii?Q?zlk93zlhSHeuPlZjDAhGuZCGj0kzvBNbxTWowbZ+URg6VA2O23eGiyl3BtEo?=
 =?us-ascii?Q?D/MbJnYO6F0fHstXAR3XVXWGFZIsQCoHXLLp9BY86GWJQQTakRw3LqVqb9//?=
 =?us-ascii?Q?LXvitaafgnNk9P6bklCsJId34nc8jfCfuduPIs5AiykrdEwOWITiKxC8ZWiJ?=
 =?us-ascii?Q?Z+P6KjGipgSRwhp6oWOBqXWasfi+fHt5j+wMVYGP9Ul2w0wy/CZ5oP2cNzdo?=
 =?us-ascii?Q?SKNqxmjZUODdRt7jqUUhey+iMGmbx4A/Trrs3LL8lhHP8G3EO+J0bXozYUZh?=
 =?us-ascii?Q?CssG7JWkZkGrI8ReKYraNtnmHwAmJLYrQ3ICqdDqHdOpxWYWCUzmjau3m6Mt?=
 =?us-ascii?Q?OSfn6ewshnknAJGbLvprvcwlrhb1COJ7AxOogG1tuUScSqkc3DjlTFYRLOKb?=
 =?us-ascii?Q?QPJfHH1V3U6XN3uX896i+McPRv3BS8iWPzjgWtzTh4ZN+i0hxkZ8yv5xSd4A?=
 =?us-ascii?Q?JJDcWI//O/0nEiAImdglKsyczkNdgc4t0Cd8Yp8wdkAECmcZP7gWUZsFUVpD?=
 =?us-ascii?Q?qTa1nwYYteHGEez+pSJSuZSd5uXec1c2+gNCTVbak9QLwJLiKL/5iaS/R+4V?=
 =?us-ascii?Q?bg4/QdmdmxWH75honNH9+wdRw/5HFPxD9pQqlXC4rAgN3nK2lETWZFgLmkG6?=
 =?us-ascii?Q?kXlPz5fQiSbEv/WxpyWPUn6osonVe4cr2x9fNGcISTYykf/A0QtMUqa8bD0e?=
 =?us-ascii?Q?IyQywFZzAzWUH8hA/lJPuR8ehAi47GKU1tKVJxs31hS/Muv9VOKwAsvMtlQy?=
 =?us-ascii?Q?5N2wue1RwAzMPA0z4mpzT2ozcDNsL09YzMElYH5l4IHGW736lo3flpCv1eHl?=
 =?us-ascii?Q?PxtRDbKWhJ3m0c7khwDj3i1lYIzrmLcXgnCngWjM/BCVmZunYy8TbtWvDhHP?=
 =?us-ascii?Q?jKKieHgdZh7VENo5IMG9HLdYwjvt+/KBK/fSI0lWKLW4woOk9zb2nGLwkec1?=
 =?us-ascii?Q?Wbm8iJOOMcIBeHki/Larw/T5ARnBeNz97sxgBJTHntqy6TpUoEyJccCzQdHp?=
 =?us-ascii?Q?bXb/eQv7LZ5uPlaqOkvIf39ZtHZEpOTX6hHFp/KN0RFf+RKlKvh61pYtFYXW?=
 =?us-ascii?Q?UhS1s0lLgMVWWad8a223OpUVnqe0rQPG1n8vlGcRzq+66YIpKPplYbu5dhLL?=
 =?us-ascii?Q?smFltuDr4P4R49jDS0nLp6evWSCrdlo3glN2BL2qVmDRvEp13DupCMZuUlbW?=
 =?us-ascii?Q?zozKBmbV/cVb3NkjrbPTpmdnFToaEMnEfbSd0MwayVNMkSnY7WUjdcgIc9+u?=
 =?us-ascii?Q?9wyvw17h2otcmm/ESFuRxhU9W2AeyZ+4/TZaS5nkWkZHQxNHsRV5691QH78n?=
 =?us-ascii?Q?xCF8AFmjKm2Oji7gTlUV34kt4C/ZbjI4AqU7me5wstOLaaSp8aF8WZ/baG8r?=
 =?us-ascii?Q?RjKrpvYfb9iKgQtxT+AxT4tSHO5EMNt3hSGfLGa8ME89XYKmLZBSS2qLNNF+?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf01209-187e-47a5-61bc-08de289a49fb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 01:07:06.5774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tEKESjuTrdHZvm/duCN+gb6AKkePyDQSuGlwG2zKEMXuIcqEPlPWgXmirv0RbDMpZLqj4tudCmJWNRltdYuIXRktHAKGikABbPJJ7J7tt1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR13MB7070

On 20 Nov 2025, at 17:26, NeilBrown wrote:

> On Wed, 19 Nov 2025, Benjamin Coddington wrote:
>
>> Ah, it's true.  I did not validate knfsd's behaviors, only its interface with
>> VFS.  IIUC knfsd gets around needing to pass O_EXCL by holding the directory
>> inode lock over the create, and since it doesn't need to do lookup because
>> it already has a filehandle, I think O_EXCL is moot.
>
> Holding the directory lock is sufficient for providing O_EXCL for local
> filesystems which will be blocked from creating while that lock is held.
> It is *not* sufficient for remote filesystems which are precisely those
> which provide ->atomic_open.
>
> The fact that you are adding support for atomic_open means that O_EXCL
> isn't moot.

I mean to say: knfsd doesn't need to pass O_EXCL because its already taking
care to produce an exclusive open via nfsv4 semantics.

> I don't know what you mean by "since it doesn't need to do lookup because
> it already has a filehandle".  What filehandle does it already have?

The client has sent along the filehandle of the parent directory, and knfsd
has already done lookup_one() on the child name, and we pass along that
negative dentry thet we looked up while holding the directory's inode lock.

Ben

