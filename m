Return-Path: <linux-fsdevel+bounces-74288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38063D38E89
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 13:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6CF530215F8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 12:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C092FE581;
	Sat, 17 Jan 2026 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="ZaQYDE+A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022084.outbound.protection.outlook.com [40.93.195.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690654A3C;
	Sat, 17 Jan 2026 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768653045; cv=fail; b=ZWtPpeQE3FiiNRA+l8kJxADSY4C5CO0gUNvQXF+7rviDmp2y4FuYeJsf+REkHoRiXRR6bvwUbh1xeNos9poTDVOGn/TGRuCEIbMfepQKo0LEakdjeToBve0EZ8yUxcCbFxf/MoyMxZt3gCl1ISN65PAu9xY3/Z7KBp9vpDLbQCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768653045; c=relaxed/simple;
	bh=uRpaCQGezz79Mhfc6oi9msMjTNSxOfOAxEtulw4C1+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JRknaQXvMxC1sjbfZtC6xdMHjJdH/2Ow2GX4FV/HGYvxa2FtXKYvgcl9ydjid1WQlZIZ8vmk3MDnjA5Vo1bug7/WMn5+d0EF7ic600e0Y7EK2js4401GxPH6dIQtFdsl12wlWJ6xtB2NGSzhw7bbGBEEnj2cuEKdFHClMTuN3UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=ZaQYDE+A; arc=fail smtp.client-ip=40.93.195.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4t8jdA/iHCr4feMaf8w+K+kB+GO0Uro5mctQ5qJodI+Jep3nhGifwBACNfpLKdwUCTUOgL//baqBllmjuTfmW4Xo0G8fFugPlcv88FRciAN+UQqHnhk9ml6/w37CaWyz1NxtmelD+i27ry06n56kSw7dGqR02nJcsYL8rTyOEjEQujKrIoRm+guUShH4+PkJ897TdDwAMMKA7aXCU4+LvNejWGCcUgMoy1+7xuI6Bgy9rj/OetV6x418WuCHmu52yH6YZDo139fKB1l1jrcp/aO77V2HZLA9FiEIWtChH8k0W6vYpA8i76BgkJB+b3kIFWO5rvjRQlsbkjDjnEMLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VbLKpMnapqSblblCyRFzC6fLbTdpkNDViSyeU3uWew=;
 b=VJ/Qe6xhk8iNJNVA34uM2RTZOnZmtEh42UtTIWC3iL/DEXQ3a9gNK8ESHMVVm1ebrhJp1aiD9h/Z0Jq3u1x3l01kDrbc81/HIjBOoOKMcAYV3amXWHMYTpQgIKWwgYuKEg3axW5S2IolUuc1QK+rXoBvsWhP1sHsQae7vB0Eco1P5np9y7o9WX98BRZuP3sYSHPGqQdgjkaqE2N+918NoZi3z/9ZVAlWxQWWqBeZRspnGShItfmBUDY2AYgvnkm7+CO3w/VAFjjnb5JniYjk/SLmzCfIADGdLdIYFG1GZ7n5VjGe9IeWbmvJdvBQAlN3ntwBWu7prEzw6jqAPRF7xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VbLKpMnapqSblblCyRFzC6fLbTdpkNDViSyeU3uWew=;
 b=ZaQYDE+AmAUFfGbHkjIpE900ZrJCxHanKPKlJqnDyTcC5yK3A06L/7zH8LhJeIVjI9O1436kN2xRYTMDsWBKUuqa3xgHsMC946KSAUxsh8T2y3wFBJPxy5guzCWaQa/m8AUoa4VxVHsACKmfO8KPW0jdwtRtuvVqnenlnJkaKtQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 IA3PR13MB7001.namprd13.prod.outlook.com (2603:10b6:208:539::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Sat, 17 Jan
 2026 12:30:42 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.005; Sat, 17 Jan 2026
 12:30:42 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: NeilBrown <neil@brown.name>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, Rick Macklem <rick.macklem@gmail.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH v1 4/4] NFSD: Sign filehandles
Date: Sat, 17 Jan 2026 07:30:41 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <EE266593-BC82-4629-9277-6DF13F809FF8@hammerspace.com>
In-Reply-To: <176861129903.16766.18207157056062198907@noble.neil.brown.name>
References: <cover.1768573690.git.bcodding@hammerspace.com>
 <9c9cd6131574a45f2603c9248ba205a79b00fea3.1768573690.git.bcodding@hammerspace.com>
 <176861129903.16766.18207157056062198907@noble.neil.brown.name>
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
X-MS-Office365-Filtering-Correlation-Id: 98ded4c5-3c8a-4eec-13be-08de55c43afe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UKYszBnGhbR6FkkO/KHgRWnRrtyje4t+5ouJr98rbswcfLBvMV4Q7ranZ7pv?=
 =?us-ascii?Q?fXWa1jzlj9YZKo6bbODhADDWIjV9gKNFg+NsESeFJ4JOPgm2J9WcljLaPKvX?=
 =?us-ascii?Q?tjpxixmm8gg40jG2graf2PaqKz3IPHf7fDGuLgKcUCMdEXyUOaZfe8di6ClX?=
 =?us-ascii?Q?jHOIZQLB+DQsl9Jo9xppFnGucuoMdU5twzXjfXgZ+YtIhh+bhG80zaphvo2J?=
 =?us-ascii?Q?30v7whB5vOlOblEB3ayFE876drNzYHGzipS92a5rEh7XooPyvz9EEUaUJqiR?=
 =?us-ascii?Q?dJC7Ps4sJTRvc4FGSzt+BdJyx0Awv8TijmUbbnOhb3TVE5J9muYCq9rA1QhX?=
 =?us-ascii?Q?kN85WGyqPOh8+47o/Ym5BTVkmSIvGedSgSjtDUF0+5ihISkjXFGWHIkwpZ3I?=
 =?us-ascii?Q?CQLcAzTefNkDfELLSFRiGtfP91l986h4fyxOEomytvBdV2xdULTn262f6UBa?=
 =?us-ascii?Q?gtOjkjlUOssK79N7Bz90R7XdMswff7yxEXxnAYSk7Uszxp6v8MXikUxPfSoY?=
 =?us-ascii?Q?T6FcKITkcdzXOAF2owfeH6WT/b6dP5sdIvAVgoxb6zZdSaA0N2hPmAHXpPx1?=
 =?us-ascii?Q?kOI9l6yKQ6S5SOmsV+n98g1+umDngYPkFcMNGVGqMshgZb3+aBC67qHbjli9?=
 =?us-ascii?Q?gntur5xfm266A3SL3uWpLfv78k2/2bpORz7Akq576QT05rXnJ6ocr8sRopEx?=
 =?us-ascii?Q?GGuzkNojNV29dB5YWzdp/snbmLUPYVSt5oqffU7rkd+ikyHF+FhvV37ojep7?=
 =?us-ascii?Q?AIQjbDiFgvjRNTXEiz/5DvYwpUkPzsIb9gcVDg/jzSipWFWxBTDIy7X9Tegl?=
 =?us-ascii?Q?JxE6firMMINgWgNHBTKZM5JOrYToas8f/MXaPLObk3gbG8B6qCmae7uTw7xU?=
 =?us-ascii?Q?OMXQpLPwHi+d8WZVMxTZZsdDOgfJ/SaU7lsv/qsIHYz7jWtR3hkEcxSlVFaq?=
 =?us-ascii?Q?Vfpd+ch6T+3iLH0osVXjuT1gWXEGGRtIeR3qL39FbuFpMhKyqXiPHzSqC8DS?=
 =?us-ascii?Q?AgTAk+07w2grxawuLAupvGFO2pNdM/1DQATOniCQooC5rVEbaQz2gPI+++Wb?=
 =?us-ascii?Q?K9uLQlw1rBgJZW3WzvR0wlAOCXYGI5luT7Lxc6E3ed/i3S5OCedkI+D3QK/t?=
 =?us-ascii?Q?fLjTNMBEZbdRWfqNlFQeR/ZQf6IktlD+IRUYWUFOdKi37oiaGUwYgmaMVb5k?=
 =?us-ascii?Q?70j5hmdv0mCcMjrkUDBy4I4Z6MYHm+z/3s2i+Pl383QKedt1+oV9+Q+60xvc?=
 =?us-ascii?Q?xIyAiEd6JPhXx10dxUIUO2rlG2+/miSmwxZ2XDOB7koVZDk/BNCxxKhayfFN?=
 =?us-ascii?Q?WrD6jqU+Xi2sm6xBPl3YU+9qoxw3M0saPkc8XEOJ6ODGmn5Ob2sfmn8CE91y?=
 =?us-ascii?Q?khyseEPxdKkax3wehV1vE7walYulWak/+InbY9W3BrLI30DjH6r3MMLZSZ5l?=
 =?us-ascii?Q?gto1uEP0cJFdzIz6jJZjl3gBNNABk9SQ6KNAAnwRmcSEry4dhUDr2WQTYllL?=
 =?us-ascii?Q?1hxpGrg63UUyh83VIlG+a1CsA9532g2L4F24dcVkvbpazEVG9+tWAa5E8qiJ?=
 =?us-ascii?Q?VG7h0wTiGJao3p12rbs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1/ZcZwgqZMObk9ig+2eJXdtkv9syESbqyRa9ZdkYAkk08kA2kol8PNW9fUZ4?=
 =?us-ascii?Q?Et5i0UbReRPTacKgTRqvjcXKlOqDro0aMOxqORVCH0vxmwqg7Z5QeEQxzfnL?=
 =?us-ascii?Q?9s0o+gxs+0l8Y84nM65ZhLq0HW7tIvuQq61CP+vWvHyVGy8c8aMSCl4b4cp/?=
 =?us-ascii?Q?AiuUTszj1YtpZ5wYJoN0vGyabAMYYPYgtXctzb+TvOVhzRTHNuVNL7lYSMwH?=
 =?us-ascii?Q?hnLfJe80r6BinPpJS0p/kqN4Mz5/xrJ+nGHcsTiCiv+Z5jPZjQ61KYQPabqq?=
 =?us-ascii?Q?3IQN42DNoqvI+KmQW3EHIlLGuosW94iogTQjVjxc6JLU+TEJ66ZcCc4DzDOL?=
 =?us-ascii?Q?CG9ZZCafiLItjC0ZQ2pgDBFH9jvM+17dQEVOS9MDBt1pemAu083qutJpTGoL?=
 =?us-ascii?Q?M8oDHjDSxtClt/9Fh+2Ym9QaKqBqIpW2J0GCVvsAmSUiEFnSB0wmV+Xqgkfm?=
 =?us-ascii?Q?HIawTkJhPUxasZPa1/TvsD4pi3SXS7S7pr2beIONxCmtgrowJbnNZi7HXs8i?=
 =?us-ascii?Q?Nc5yW/jP6+jvGw2UZTJfCwKzremk/ftPsMyqkUZUi9vOBXfgO/tgvMaES2DD?=
 =?us-ascii?Q?0CtVWWcrrAiSH9HHKu0x07KY6Qd6JiOD1hhEKbNWCwA3foeyfwC1Ch8V2m6r?=
 =?us-ascii?Q?0XMPjyvtZqzIN6gmdSqXWjbKrHq2lARyOHQD/hNv1cDg11I57ZCAsp+kDx8i?=
 =?us-ascii?Q?8o1PuF+ZuON1qTqJLbmjebC+i2Z3EWlAomDLTCREfP718ydu8DRjAMopJpXA?=
 =?us-ascii?Q?jjCK5AbYNqQq82fthS3zIN8sHgqscwL9przS+VMr1D4eSfEEa/ma7iM+smXV?=
 =?us-ascii?Q?i8I08+hNJjg0htV9IdTFRFnQgQthCC0t/5qJZxr/X4sENwmoqGo7RP+qQsBf?=
 =?us-ascii?Q?fkzzubtinRFeFiCZ3xrEuIfTRO9poWj97ZCLpk0n6gOsYOM0ujzQgcvlGL8R?=
 =?us-ascii?Q?ptbFpniLc+XZZgHGEpyQPNDbslQY0w0trViT2WV/NM+KSybrWxWfsc0HkS0/?=
 =?us-ascii?Q?gn4FY3geRJP87m2BEM/rpozZf15JReX5ZIOK0iPTDTs1dL1OJbnScQn+0LP7?=
 =?us-ascii?Q?I4ZnMYT2PALec09iVqEizJjfo15kVmi0u5yCl4tYwpiIFrGgaJCaWYp5k23Q?=
 =?us-ascii?Q?5lEDwEHzJcHpFMAe4EpGLTtQPLzVmLAoRaUZ53HYaP25qYHwxituSdws7xqH?=
 =?us-ascii?Q?/NNgLMa/9vd1i2tUbbHBKlC+5vMvLlnof0CukngPRP3EktWtu/me14jigKyI?=
 =?us-ascii?Q?xPwtVeq17SK7+kKpauYDQpvWcPRgfyQIl2UxZvMO72enSiD5JGmpg5PFfOUR?=
 =?us-ascii?Q?rt6ncOAbHYOZqNpV2gDQllAZmjKANAtE98t0buq8dboR15RC2VnA3LeOQiXf?=
 =?us-ascii?Q?NWxlIY6u0fjCF8+gJIWUb01AVD6UF3febzbBmr/zmG7uLvmpKL0QbZSz6Y8b?=
 =?us-ascii?Q?SabObtPNG1divGu427E5Hjv2akVNy2yFTckeB+UxXnc36edzmROwROw1SUXb?=
 =?us-ascii?Q?jJZdlFVwqCEjNgbIr09BCiBqsZ6FQYawbAhVqyee0JNz7aTybRUSFOpE1Ffv?=
 =?us-ascii?Q?KpgmBM2heJPbwQOnCu58oeNWcysAFV9OIf+t2Pi4ZXKZwkVhJAx5NTbf5LWM?=
 =?us-ascii?Q?hC9wBtw6BZd/2iPe68wsnNatiT4b6eCcZtVxkyv2uPDZfc+1+fyvJ1JV7u5b?=
 =?us-ascii?Q?Q5LzR5fXgAuk8G3nIgnxQAZbOVEw19LcZ/VTC2TxKY5UtiLeqgYLd2BvfX2W?=
 =?us-ascii?Q?C+ZG2eBDwKDhR7/cK/17l3afQ41nU4M=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ded4c5-3c8a-4eec-13be-08de55c43afe
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2026 12:30:42.5848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJeukiUma68LpSWcsuiNGjTvd6b61N3Saa5dQxeAACMjlFxaaAzKpxVXJIei+q+eLjxwf/msnqs4PFhSdTVWlJrAkMi00dFQuLfxX7epftI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR13MB7001

On 16 Jan 2026, at 19:54, NeilBrown wrote:

> On Sat, 17 Jan 2026, Benjamin Coddington wrote:
>>
>> -	if (fileid_type == FILEID_ROOT)
>> +	if (fileid_type == FILEID_ROOT) {
>>  		dentry = dget(exp->ex_path.dentry);
>> -	else {
>> +	} else {
>> +		/* Root filehandle always unsigned because rpc.mountd has no key */
>
> I don't think this is correct.
> rpc.mountd always asks the kernel for a filehandle, so it doesn't need a
> key.
>
> However signing the root filehandle would be pointless as the client can
> "PUT_ROOTFH" without needing to provide a signature.
> So I'm happy with the root not being signed, I'm not happy with the
> justification.

ah yes - I will just drop the comment.

Ben

