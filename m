Return-Path: <linux-fsdevel+bounces-69928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E5820C8C278
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 23:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0427234CAEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 22:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFCD342507;
	Wed, 26 Nov 2025 22:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="E+8p+tts"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020123.outbound.protection.outlook.com [52.101.46.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E860616DEB0;
	Wed, 26 Nov 2025 22:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764194844; cv=fail; b=ZnfwR4FrC8uUmAIzVcBL1qMQzwUU3Yf/J//RntkqquZ/CHe86A14qkhRZQR9G/WO5szCO8+/wz8cXsv2DZzjH/9WrmvbOWO6xnprVlKAU/iTcuINzXTFFYguHHfxd/1ivHb5X/IOJPLAoqgvpZ0ikJRuoG6MYazwz8HgkY+E0OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764194844; c=relaxed/simple;
	bh=tEjFkGoonShFPc0gAt8pn4Oq7dCz55nowlNuFvnAXgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nAQeWyQ3c3h/lNvA4syufqtG9SpCPy9ZBdGG+hCIwN9IEAZ92k4RqNC6zm0Sk5dzp7omrWigRFAUdi+vcJCqi+0ifldujR1PYg3j5rQup9WgGOmJ1vpmsjWO6a4New1a/MDhgK5PbpeX7UOwDvfa5TIavK58hqi/DKVRW+rqN+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=E+8p+tts; arc=fail smtp.client-ip=52.101.46.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3ZLF1RgLuCOMaH17Z0dbWr9NtNxqhHE5eCQN5Nt3XTrLIVZLpaZcip5/qXzru9VG/EFAX3S2BoolNa3x+wOfqL8IxGl/826CJUx7OQYVr3Alwd+mHeYgX8NHXOtOLYQOuWVti9nxCRrspIULi67bFryOapz7Wr22b/G4UTh+7BImKirfiwRgrpnHVWo6KYAlKUdN6+QVMFfKj4P5fxWlifGL516SRJDK5rimtSUgFWxBpcA2P4skPl278hEEpPwj2nBDJCd+JWMBN5vnR2zDzH9WKgEyWosoIeTHIJN4wKGY5QBBaBZJpuonLXPWhdV+jGoWHzmghQ/zC4i2Ju3DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hsz1hdi4uZFygFEaD35EieaNrQ2yyN3lfvHqO8O8sBI=;
 b=WZRePf1SZ6kQRIyV2ARlFR7B72K6GlUXkhPWlOTYYCSA+J9DL1mXP1aLOuohrWSZxEFg2SYqc7mYDAYgxsDWyfTOWsuI8pRtxBgPZcNtcfdeLuGlVkcjFFrzv2MGKNgcVcVi5tbkUIhGLHpwQbVHm1txeiP+6PUZyEeGZ7cNh50NHGkZRLSwFRTD+CDDViZCU5E8XBHd5WINptF9oV6FVm6TkQCD7mBvJW636OtZiOV/7mlVvnL8+SRsD5CCp+Bg1FY4RHpLapjLEd0gAw6z/KBM/lU6YpOh+wUIPIznBiS/snX+LyuxbEa9lkVt+lrdxd77n7WdL8umW8wvLrlbsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hsz1hdi4uZFygFEaD35EieaNrQ2yyN3lfvHqO8O8sBI=;
 b=E+8p+ttsRzrBJ+4lT9Y7QOXwR6sGoeboSF0UmpYXF7QNSEyeY8icRMRZNP4O+sBcI3/DxRaMUDh2Cm7vsZGMbefRHFtiz2mQ6OOrGzTl2nxsSm0VZ9kLrcuu3I3+Hd5G7gznNsDbeTwhu4wsZ8m5LGjkA5wyoKpg5e6Q6bTsGyI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by BN0PR13MB5182.namprd13.prod.outlook.com (2603:10b6:408:155::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Wed, 26 Nov
 2025 22:06:07 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 22:06:07 +0000
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
Date: Wed, 26 Nov 2025 17:06:02 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <9DF41F45-F6E6-4306-93BC-48BF63236BE4@hammerspace.com>
In-Reply-To: <176419077220.634289.8903814965587480932@noble.neil.brown.name>
References: <cover.1763483341.git.bcodding@hammerspace.com>
 <176351538077.634289.8846523947369398554@noble.neil.brown.name>
 <0C9008B1-2C70-43C4-8532-52D91D6B7ED1@hammerspace.com>
 <176367758664.634289.10094974539440300671@noble.neil.brown.name>
 <034A5D25-AAD3-4633-B90A-317762CED5D2@hammerspace.com>
 <176419077220.634289.8903814965587480932@noble.neil.brown.name>
Content-Type: text/plain
X-ClientProxiedBy: PH8P221CA0036.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::25) To SN6PR13MB2365.namprd13.prod.outlook.com
 (2603:10b6:805:5a::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR13MB2365:EE_|BN0PR13MB5182:EE_
X-MS-Office365-Filtering-Correlation-Id: 56343342-2628-44ec-fda9-08de2d37ffa0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5eiRyJoRUrViCsCs7fFl9ZCZjuG9xbTqxcF7aGsB9QcRKhzd7yXiagMd0fgq?=
 =?us-ascii?Q?o/0CXreH0wwue8xvhmy9tmwxiT3kJ620MORV0FKJzY+lt6rGcmt7+jBWq7tV?=
 =?us-ascii?Q?/JB+eh6cTrON6shM8+6/btgAObZXSJ3aVYMyz5RTrl7LXQ+K6W8YpvqH3B2p?=
 =?us-ascii?Q?qJ3OjJY/oE7pwbCWu7urZ+wvnIlQG/klahDawW/x7GnJaQ0V7q0ZlGY64WmG?=
 =?us-ascii?Q?0F6R7VOPKtpqxvn8nU1d3szzKj2Jdmumy/213cSHHUBv4j+sNL/KmxXv0/s8?=
 =?us-ascii?Q?fFaTYxtcCPeriC8Z6Cc4jH5UPk1Pw5jjd/jBUshexLrF1PjIBT7W8R1nL8y+?=
 =?us-ascii?Q?2qsILOkrNQ0TqB6Wz6+2HF4qDx7pToFMGs6g5a6G9QquZ8CHueAWykXs+ASC?=
 =?us-ascii?Q?8tIFhpJWJwRRWkYSsn0xcTyJC1rMEMYFj7Jt3fOw3yo8y7XKll5xnq3aBY75?=
 =?us-ascii?Q?VtOtpPw4nb6E2Mxs9UkriKIzlGwHgMGblleksjo24/H3A6jqEhFNzpocjA9V?=
 =?us-ascii?Q?Oq9ufDvUiEfGcXNSoNfLVebmBxAvfq3dV94CsItUyyBK9phbKqTPDjoxImpt?=
 =?us-ascii?Q?0XdJfY6vnpO3W66ipRlgGmwnF+m/WfIZaKBhrdmzGP8bCqH3BESTUaB2Bzuz?=
 =?us-ascii?Q?ndsXUVzSbRfbmpwKBnE1ynmNAcQ+bchI+FZyrv/Uh9iH/eoX1wb/45ZjVusA?=
 =?us-ascii?Q?QTAUGlmko/bFjMYWkzuHCApLCH336VknLayjbrWQegi45xcsDh/rxsEA1OpE?=
 =?us-ascii?Q?CtuxXhJKGzn+c1a+wjbzwKPC4QDf55L/LyHernNTeF51tBZ2b8sDfa/qBf7R?=
 =?us-ascii?Q?FGGDZJyo8NN7zAfJVN75+G1pBvW9tNvTs1SXYC4Do62f20SOz62B6s562Y6U?=
 =?us-ascii?Q?Qxs4UEdW0N6CaiCBSen54dhscwvhhPRrMBZna6IdtAX5olGH/7PNtvVfCv9/?=
 =?us-ascii?Q?nvN8Wp7DunlAo9P3OY5hJHPlQvb38dp10FDt9Hg3mV3zRk6jHpZEI9cCZJ8G?=
 =?us-ascii?Q?xa7cJUSEF53YsT2U7agCUfknhFozBX8NiVpeacqmQ+xYf5M3gsCKN0yqqAfP?=
 =?us-ascii?Q?maFbhrPi4szKvdCDsDbiFTuFKSR+eET+Sa1Xx9iWL7j/HM2SKvFamS6W31py?=
 =?us-ascii?Q?A5LyB/kUX7h1KNuF29TbAdF6okmxsFhhOc1gqK+2o8POxtrRSNcT2re70Hfi?=
 =?us-ascii?Q?WdhkVBW7HZOE7mGuSGEdfmLsvjnGEuETHH74qvZnBumFCYBMXYjjAHaccsXf?=
 =?us-ascii?Q?HIlMeWYT0qse9YE3C49HUpzlYtuqJxL8KR7CC7PfAIh0ZvK8kDuLqHXbn/Io?=
 =?us-ascii?Q?QKq44xlgRIuzj9FbYq5tOSAAvGb6Ux0LKmPhr8LDoc2+g93XWGtootfGc7kU?=
 =?us-ascii?Q?AV0c8Jp8p9hsbLmV2KOPU870AGCB4t4gnUMNT2QCqGAcT+nMoT93eIzb8JCB?=
 =?us-ascii?Q?TOXcxjdYN1/CR2dMQSUF4cEDa9cwARMX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vhQrsTZFE6YDHGqvO69cQa3nBmzjpqLfyyv3gwbtnGLz/aIf21+fBsLJNLXw?=
 =?us-ascii?Q?39NNDfK0RzDcUpdSJG806MpOOTosh47UBiQM27ExVC4TaqHO+oFXBhXPbPiM?=
 =?us-ascii?Q?jUTHwz96Dk6U9XG7uT301tUS0Ld2Bwspm7PsyFh4lFa+Keu8KP8CFBy0N/t2?=
 =?us-ascii?Q?SslnvU/f5AQy/O9745h4HKjYfm35JxSq48xv8gegX/7hKZCK5r+GucU1Dwzk?=
 =?us-ascii?Q?HLXwU4xPEemOUywp0fu51ES8ERV7/4oN+PAzcAFUWyJKTpdO5+Ttv4yHw9mZ?=
 =?us-ascii?Q?faCuPMln/AavLjRQy0UV45uH1LZyC8o7q2STIDNTLfXCVuZ0xsD1OsUK5F6p?=
 =?us-ascii?Q?HHOoE8oZ+ELKDKptC+tWov5sRGsVqvcvHLNw5qpOhIpSYqoMMaChsZHTmmV1?=
 =?us-ascii?Q?N1a6asENPbB4attkvnzdxXo1U0G2ZOvzI1tO/Lzaq/2lQRih1WeLQAgr5iZJ?=
 =?us-ascii?Q?iD2FqkBUB5MapI//E3N3hdLXZju4ji2OaonoZAfIlpwauMVIMBNsgiwhbAHB?=
 =?us-ascii?Q?rt2YBccELRVLw/tiProGx1tfsaUdQgDdHtj8//mf2lps0x0M0aMvTn3rG4D9?=
 =?us-ascii?Q?OfZJcxIfhaCYVK9nIKL9QztlI1r9TbiOSGw2sop9oRp1DshtgeGgw56dZE07?=
 =?us-ascii?Q?CCnT8emC/b7ebNPw9ayoPtp7oMiouMja0btlYjFONpPgndmAteEA/GKTODQe?=
 =?us-ascii?Q?s9bgu4I25NJtkylZC4gK7ORVSCg40d34+GXIHfN6V1XRSfeW2AOTzrK+OBV/?=
 =?us-ascii?Q?fbrWPIUg9ExCfxMcGvGeU+ckn1YRcvIfrKZmg3BKYv+7iauKHVl2SlGY12c1?=
 =?us-ascii?Q?91BV0GqWrywFEPaNaNmSGDqv0xWEkq4HHD3DD3eUjBYExbuSM1NALUrCTBfp?=
 =?us-ascii?Q?TY3jh0U82Q2OKH+NmtImIJeyXw2Mq/xMRGpw4/5XvqHZyv6p4zuOkLulFpel?=
 =?us-ascii?Q?WvSS4pJLWvun2h2FlMAhHxrdD5skntp7EK/4r2zi0aZTE6S5g5fZ+2lmpvJo?=
 =?us-ascii?Q?shL5b9NkPlelCJ0pd5P350NrGVFYOnVngXty32PKbDh0dlof66wU+vnc41BI?=
 =?us-ascii?Q?6frY4l7+mKuWbqW462o88kMjA8ed32mduasPTpVx26U2g0Pvdw5z9KSqZJ0B?=
 =?us-ascii?Q?sNUo0pYXt7ytP+3i7nDm8Dv2et2hmxuOB6/4ePPpzlo4MZ6zS3cKLAx3VnVC?=
 =?us-ascii?Q?8cqoSb1Mhb65rH1V8uwjMFDv7J0UYo4xdCdlLddpuuHqP16vC77SQfLy4XV1?=
 =?us-ascii?Q?N6rDJD3mNIcyjjEdhGpe13rWTLiRiznWDnEKfcqyHgrdEap6jxN3gU3Rn/3p?=
 =?us-ascii?Q?WsYEKmf+YwvOtQjJoBZu47pgXzuBmZAzb6wONAPsg9yrk62bdr4nQXCV4JM1?=
 =?us-ascii?Q?Pl13rklylENf+JmvEo9TJxKrJGE0+OCq4HWNyrtpUTsChpXWtR2HKXt9aU/M?=
 =?us-ascii?Q?sORjeX5F62CtY45xHWjwstsLCHRpVMr6Ay6ipRz1HIAozsAiVOgTSV3Iz6+h?=
 =?us-ascii?Q?iX4vCIzmViAaHZRQsoVtSep/kic2JBPvzuSXw+hPzadBvzHDpwEd35rXXKAf?=
 =?us-ascii?Q?zBVgU7e4GiqvorBrNZcfxRRMptMoQBHauY6XtMfsQPDm2WcTTxJD6Wluay8O?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56343342-2628-44ec-fda9-08de2d37ffa0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 22:06:07.0403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbNiUmjTpuCHVxlT68UZNxrxz8ZRxBKUNFUgIVpIgczVmlPLXuhzU+ngoqO83/Kv0q489eOQIqTIBM1vPipWfHDi0RA+Xv45eqOlyqgnRDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB5182

On 26 Nov 2025, at 15:59, NeilBrown wrote:

> On Fri, 21 Nov 2025, Benjamin Coddington wrote:
>> On 20 Nov 2025, at 17:26, NeilBrown wrote:
>>
>>> On Wed, 19 Nov 2025, Benjamin Coddington wrote:
>>>
>>>> Ah, it's true.  I did not validate knfsd's behaviors, only its interface with
>>>> VFS.  IIUC knfsd gets around needing to pass O_EXCL by holding the directory
>>>> inode lock over the create, and since it doesn't need to do lookup because
>>>> it already has a filehandle, I think O_EXCL is moot.
>>>
>>> Holding the directory lock is sufficient for providing O_EXCL for local
>>> filesystems which will be blocked from creating while that lock is held.
>>> It is *not* sufficient for remote filesystems which are precisely those
>>> which provide ->atomic_open.
>>>
>>> The fact that you are adding support for atomic_open means that O_EXCL
>>> isn't moot.
>>
>> I mean to say: knfsd doesn't need to pass O_EXCL because its already taking
>> care to produce an exclusive open via nfsv4 semantics.
>
> Huh?
>
> The interesting circumstance here is an NFS re-export of an NFS
> filesystem - is that right?

That's right.

> The only way that an exclusive create can be achieved on the target
> filesystem is if an NFS4_CREATE_EXCLUSIVE4_1 (or similar) create request
> is sent to the ultimate sever.  There is nothing knfsd can do to
> produce exclusive open semantics on a remote NFS serve except to
> explicitly request them.

True - but I haven't really been worried about that, so I think I see what
you're getting at now - you'd like kNFSD to start using O_EXCL when it
receives NFS4_CREATE_EXCLUSIVE4_1.

I think that's a whole different change on its own, but not necessary
here because these changes are targeting a very specific problem - the
problem where open(O_CREAT) is done in two operations on the remote
filesystem.  That problem is solved by this patchset, and I don't think the
solution is incomplete because we're not passing O_EXCL for the
NFS4_CREATE_EXCLUSIVE{4_1} case.  I think that's a new enhancement - one
that I haven't thought through (yet) or tested.

Up until now, kNFSD has not bothered fiddling with O_EXCL because of the
reasons I listed above - for local filesystems or remote.

Do you disagree that the changes here for the open(O_CREAT) problem is
incomplete without new O_EXCL passing to atomic_open()?  If so, do we also
need to consider passing O_EXCL when kNFSD does vfs_open() for the case when
the filesystem does not have atomic_open()?

Thanks for engaging with me,
Ben

