Return-Path: <linux-fsdevel+bounces-70697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02685CA50CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 20:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA39C3097D25
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 19:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CD634D398;
	Thu,  4 Dec 2025 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="U3TLS5wc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022106.outbound.protection.outlook.com [40.107.200.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA4934CFDF;
	Thu,  4 Dec 2025 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764869799; cv=fail; b=ndqiLeO/2OiHD3tE70pPKoqRKsheIC7O2V5GyrwBtyKTKY1pKs2uTMTsuV+eocLG6YaATtmwevNMVBSJW9e6MjVH6+rWl3cCtBFZGvQstf/gxGCA0qsvXuRxjFZpyY7PrXTi4D2WrBTf81fYZ3PH12KGODLkpXhwEL4RaiNDprM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764869799; c=relaxed/simple;
	bh=C8EZIbETKaxKvjJPCCRwCB8L/4UmCrq9mLMDjzioFEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u+Z7B1abfPmUyHGe2ZR0d/oVD2+iDCkL4QBnf/o8E+vCjBzuF92/PmXTmqgZvbty4e3TxzA+94k+kAQhf7d5mcZeJHBPrZVelJ02EDM5uJiiv/lcFHh3XX3ojAamIqbRUV3WBU4ZSRI7RQhOpqPNkBZhDJRJXR4A03QKRT1ijUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=U3TLS5wc; arc=fail smtp.client-ip=40.107.200.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojgFMBptZhyoAEAfzW6A+Df+yLbemotcrdg0SxNFpMNDo1cfaGvDHKXc6H10l7uGR8QdjMy/vdvQUDkTn3t5lk2D2flscTpNTeofX6sOobjXFawo1SGv7Zy0BSW3sneF4vOlHQRBnIKyO815c57OgYD5g4SH5JK9l512D/KZmcduBZ7d+814Em7cQ49Ga+4hAple4ZEXD1GEHPmLAF6w99AS3TvzAYXmzN0JbjiZ0rf6VylNeIF7ly20iwgWfyGf27j0Tz2UDVLpVV8/rm3ThiRJ/JSkXVWI7F8qFHZf53JSf6BUFf8Lv/SHGw5O++PsoY0V7pS3Z1QkESV0zsQoUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+9RV9MbwRJAtHRB+nEJ5rcgezaMxML+M5iHbenBlEQ=;
 b=pdVCWco2AGAW7aGdeFhbeucv/qFAkReS/eS09KDSMkTAqEhFaOl1J9fBSDHMSd+4hlKU5htba4UXBKzTqVTlrmvC3Vb04M6PKvN22xXT8FDyAT+qZuTPgdItkFVrPhbS4CBlwfAASbQ6vMWGD6O0capXicNVtSoKXyap5+0SDeWUF4xAHNPFleVVjbn2yQfF2yqimEeugwUir/Cw1lzFffHH9h/CKxiDCFKhz/WFCGIi5d5b27q9eHJKPDeTZ18pNKe4kAN66SFtdFmyLYR/q8/QO0HIBtplhv8hZAsHPeTP14dW8LIO7p6zExGziazID1adFBqDKBhNcCBDcTxnnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+9RV9MbwRJAtHRB+nEJ5rcgezaMxML+M5iHbenBlEQ=;
 b=U3TLS5wcD8F7rlFf4KZRpk6ingZDCoX5zCXHHSm3EpkdL0b6wq9yd6sGuy1zjY0JZZ0o4xVPJjFfgTHbnx9Kv9iLbNeebQeijghHKGakE2H8mRuOTrVYbZpInhS/zd8qQ5SOMWHx3J3t9e7msoMx6D3yzcxBTN91bQO2VH9I+Qg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by PH0PR13MB4971.namprd13.prod.outlook.com (2603:10b6:510:98::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 17:36:34 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 17:36:33 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Allow knfsd to use atomic_open()
Date: Thu, 04 Dec 2025 12:36:31 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <EF15582A-A753-46F0-8011-E4EBFAFB33C7@hammerspace.com>
In-Reply-To: <97b20dd9-aa11-4c9a-a0af-b98aa4ee4a71@oracle.com>
References: <cover.1764259052.git.bcodding@hammerspace.com>
 <DD342E0A-00F3-4DC2-851D-D74E89E20A20@hammerspace.com>
 <97b20dd9-aa11-4c9a-a0af-b98aa4ee4a71@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::30) To SN6PR13MB2365.namprd13.prod.outlook.com
 (2603:10b6:805:5a::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR13MB2365:EE_|PH0PR13MB4971:EE_
X-MS-Office365-Filtering-Correlation-Id: a498d7ed-24aa-4be4-5837-08de335bab11
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SfJFy+VM2ol5Usyn4PlGZkb9awHgcU/KCZezSIFZBD2TgdOX6Wkj63u1AweE?=
 =?us-ascii?Q?Lx4ZuCGyxbyvuxxBaE8+WwS9a3/SVZy5Zu5sk0Swu7EIGjKrvml2xswVWZks?=
 =?us-ascii?Q?sxgcAPB5KGC3KTP4eec9lKRxrFwvcV4BnOsvs8+WP+P2xk+NFv4zzdmh2PVA?=
 =?us-ascii?Q?ZAPzVdN66hF5EUYswHAJHq15AY2Krsh01EMD95RTkXaX3QTUrPNGKQ8VzW4C?=
 =?us-ascii?Q?lm/dLOv4LlGbxGUQBLdV0FXeqVcI8h5Fz/3aq9NoLWUNh5tXL8itLAWBSnVH?=
 =?us-ascii?Q?rHYSLJM6JjP44ouYiNC2BQE/7/6v1JNsfUzNXEgQipxRZMTUlu2slglX+Ahu?=
 =?us-ascii?Q?cIpSPd8rYFai3+U1dnnQGUqkJG8yvCFw4C+/MNqGybNMV09nsHNrz9HPUb2a?=
 =?us-ascii?Q?uWlDtvfrDcIYXfIB3bNMpWFWvf0C7bfkbRtPIitfTwqlGXWfXBsY/tmzr05A?=
 =?us-ascii?Q?VRoehmzAKi/4gMLdqIx5Vf9SOHlbLXRsCqKh5Ivw9lTSkFT5iaTeBebWEgT4?=
 =?us-ascii?Q?5mhYJuy3/8XF9NKe0vWBlZevDBWO+RYFyZ/YLF1Pao6cOgNcv4lUmSR0LBw2?=
 =?us-ascii?Q?1WAeWQEcEEdJx84PG0mfyEd6mQrZZGo1ZN4CUljkdXjbtZJeZjXaHuxbV3Er?=
 =?us-ascii?Q?iD3Q7p//c9f2kdu5Fg4HHKXIqsthq1V7UcjSVjQKOq3ZapMTvtJimykkQCDO?=
 =?us-ascii?Q?Oz36Pum8V5RkDk5wLATNwfz2ooDdVt2LZJJJ7zHU3nHHRkI6jSjsU53MEHEx?=
 =?us-ascii?Q?b+3TexvIyKKjDjFoQBLg6sa6nDHpoiq9pnBxULs9gyrDvMLLJ+2PNOBXp7ln?=
 =?us-ascii?Q?FUh6FoU5IKBp15aYOWyC7obt9LzV5+2MFt/ZNdWDG0TjC+3Ju00ufngH+Bn3?=
 =?us-ascii?Q?YHgH7BNT0kHOXCQMWFPhb31GiDeP9Xpa6QTb4yK1qSrCjezkIFDxztn6rXZA?=
 =?us-ascii?Q?W2Mk6b4mX3xtj1haclYlAhhHe7Ilmw/BKUGFF2rFnwZtFkdiW9NJbgnaBxOU?=
 =?us-ascii?Q?Ssdlsbbzd9lMYkOg4vROBNaWbecnpjbBYmwd6QXzIdMlBjN01uK9yfgmR9gR?=
 =?us-ascii?Q?NVHZaZHJTUD7k/I3duUe2cHv/Oxt1xZMcQdesxibrzpfl8h5qgjTH42iUxLy?=
 =?us-ascii?Q?bE2Es5Qiv55itcjluEPw3xABuThl63c5WGa0ZtmdLA5pMUqAB5qtRw6la/+v?=
 =?us-ascii?Q?2j9RAwAQBgxTGTYdxspdvYak+MuABhC09jwWQdEHOD/RtX8vbdkuH9b1NzQ1?=
 =?us-ascii?Q?7Ey7AFKaNWdhXnjK1yRP0bnkjV6Ke0lBcLPaGjoXs7jaom/so16RqcIy8jYH?=
 =?us-ascii?Q?/2e769dtlC8Qm6daydv9jeZsCJgNju/oVwQMBtfklv7l5s3s1CUg7mVX4iRZ?=
 =?us-ascii?Q?Y2E9rqot3gD20aoBF+D+nctPUrEUl8rQ1+YdzScu/exgWqcXGZzT2s6Bq2hV?=
 =?us-ascii?Q?vGCohmdITvGE5Ny4ya+CcNGp4iAiZ1HD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DtELxzU4UZAQkMYWSxfXwt1sXsZEe9OD7HBnnelHpTEQ3cjibS01xUbbl5H+?=
 =?us-ascii?Q?EgD+R6yKW0LLtcre7I4YJXBFbhjJhBsrbrwrmTahbpC+2p037WSavK4UxEfP?=
 =?us-ascii?Q?fmBVUCN/EZmjnLV18XebqBB0Rm9hubz5Sk5CY2ywYJekrXqGo3BTFMNbrmOG?=
 =?us-ascii?Q?zpk6laCtPPlJbE0N5wZzz178P/9OBww9oIemjeNywKPyR6jboHjxneupD8FE?=
 =?us-ascii?Q?HZtBBxGclykkZmbyX8ePnKBAlbcwHQISD7fW8qCZHrhf0UrdYCaHunO6elit?=
 =?us-ascii?Q?N6GUpe/bofkD00+UseHs3XotHjvQBWSd0UJmylULbAlN/Czsg/MBBd7h8fPD?=
 =?us-ascii?Q?xg5k5sahQi4VyTRZXuh3gH/vrXkpZgCiDNRjXoXqWZNgrdOq4UPeHVsoxJtq?=
 =?us-ascii?Q?SowIjew8lfsCJMBm8cxdm2aipXgKSchgWTEdleaSNKO2+FvHDSGna+eW0kl+?=
 =?us-ascii?Q?stX21eQxquU1MjR3W4jMmi5nsQ9fGuCk3OywV/xqgvXBsCM72Ms3Mtrn3vRG?=
 =?us-ascii?Q?hIqokcCUGJybi5TUFxcj2g5Oh6+QqoL7BiJwIQKhoLmLcVB9nm4t8ZA7cuwx?=
 =?us-ascii?Q?NHInBEbYBugxiaAAv4djgIdjrplGXUZQVXxa0gbICnOFVCdKxN3cPI56rDLT?=
 =?us-ascii?Q?D815H9qtUQFr86dIMsrQqH+01Pk/PQC/I7Kw1Juh9sHsvZD67xH1fKDsmq2+?=
 =?us-ascii?Q?o+aS25mb+X+WWvbzdUzZWfUzd05E8+H+ni4Ldzy5ryA1XGgxaUsHzMBXEkCk?=
 =?us-ascii?Q?wrMCIj1TQicxng8TNZNdS0v/IAzpZsMMwafy2fHlqS+MsQS2Pul8j+MnxSZM?=
 =?us-ascii?Q?704WSGijEgZmvKULGlA+wqEsQMHSRX92G6hYLSpgKZ2mJqebKx79kprdHPom?=
 =?us-ascii?Q?q+W4hA9tVRsPKhDCrN03RMOqaLEt81J8+4r/18ANAqxggJAxxMtAfqtG06jB?=
 =?us-ascii?Q?tFTtX+e7rGUYKaM/FdQCT/DtKWTLEYx1r24y/VxBC9Q0Vk4OXxzGWAxCljXv?=
 =?us-ascii?Q?5s2DjaMCLH3VA9CuHABz8Q9PFlquWdpoApg4e1ADKWtrf3R2P+3lU2Nmvhys?=
 =?us-ascii?Q?9eQRUTXZgX7Q4dlV9c+vTez6wuZ5KaUuuzlw1eqa2tms6dP9jayHMMi7vUMS?=
 =?us-ascii?Q?q10k8Dp8g5ZB2B2Uda13BRbF04um/SiNjbTDKHOH0ILk6DYBsLyn6teDqw0S?=
 =?us-ascii?Q?T6usu7O5zCt+SAWlmNw+yEgJcfrw1fGHfCsbTo+7z6iJ4psZwdoh1A2oj8cu?=
 =?us-ascii?Q?Lv5nnCXbX/lLTcstCbjDpC6X+O1R5PimJ+HwRiHeRKF/YgSUxf5dbhb7EBS5?=
 =?us-ascii?Q?2iqvkDYhkD5kpRuWb7WUeXvoBkldeidwK8kb2djnWp2DE+WWWY5u6vqt0imJ?=
 =?us-ascii?Q?hdP0brb0Nwd1ngvvouyJxZ1M6C2Mhm3kcyz+mQATWk3+PjXkuFMCWcAr/2ZK?=
 =?us-ascii?Q?FIRg9knNJ1JNFptjgDIy3ymCz1YfgZBRxLH+iP6lhGplq/+6ngvBvYk2Orfj?=
 =?us-ascii?Q?l7rGWhqJSUJdmi7bfAFcEPYVaFo3llOB6NvSSSOidRbY0xO9Q+vt+TK3qVQK?=
 =?us-ascii?Q?Myw7uFdoBWJ0Nygf6gsE0lX3GiHXVtV8hX9Ledxj0tZAa05L9SlD8ukj/bR4?=
 =?us-ascii?Q?RQ=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a498d7ed-24aa-4be4-5837-08de335bab11
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 17:36:33.9144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QlKhRbdovyH3gcdkZYaNeUNq+cr39w80OhYp57Fx3p9Pld6aCNdbvXIBHl2P3U/ZA511bvQJQjl0RZg0RPVyc/3+KAF653bXVpLHsvxG78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB4971

On 4 Dec 2025, at 12:33, Chuck Lever wrote:

> On 12/4/25 10:05 AM, Benjamin Coddington wrote:
>> Hi Chuck, Christian, Al,
>>
>> Comments have died down.  I have some review on this one, and quite a lot of
>> testing in-house.  What else can I do to get this into linux-next on this
>> cycle?
> The merge window is open right now, so any new work like this will be
> targeted for the next kernel, not v6.19-rc.

Yes indeed, too late for v6.19.

> I assume that since you sent To: Al/Christian, they would be taking this
> through one of the VFS trees; hence my R-b.

Thanks for that - usually there's some discussion on which tree would take
this which I didn't see yet.  Hope Al/Christian will pick it up.

> If you're going only for linux-next, you can open your own kernel.org
> account and set up a git repo there, then Stephen can pull from that
> repo into linux-next and fs-next.

I do need to get that done.

Ben

