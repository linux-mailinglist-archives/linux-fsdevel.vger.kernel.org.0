Return-Path: <linux-fsdevel+bounces-76991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMFkG05kjWn01wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 06:25:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABD812A64E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 06:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF0653110C8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 05:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711D0284880;
	Thu, 12 Feb 2026 05:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="bVH5DztC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021142.outbound.protection.outlook.com [52.101.62.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9578F5464D;
	Thu, 12 Feb 2026 05:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770873923; cv=fail; b=e8TyDxYkCtDuKAYmYVhmGxcKHGIOq1L7Z8uPd4Ux0rxXbrf0IoUXanqpbglDcPO8JBXQbbD/XGWxCPM7Mw9Tbd5kWYQkspZmdguBkFg95ERKw6Zi3/WHJ0CsTdR853GNSEAUCpMZ91RWvwzbBsMsCcaN+4A5cmvYxmJKPblxcP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770873923; c=relaxed/simple;
	bh=Pfwv5bV87Am7Y59Qj23XjbMiiVNOAuO4/7EP9Vxqn5w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UaVG3z5DTb3EE2ZKjZF+nCriKlUQTxZQ6cDY4v/hY1nF1GjF2DFknD2fBTdBvjFrJIxVPyaoOu+rcyH1TMsn63QEMciiO0UlFWkYVg16A1I//nPnASH0/AsJbC/zz2gBUBRmXWZKgDaYquD3LOyVVaQHU1XcxrhMhFokNd2Y93M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=bVH5DztC; arc=fail smtp.client-ip=52.101.62.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYrYriQ7bsd3amXkgxy/PlH51IZvgVfgJNMTnr5v5kkGCaxtvWL14m5NZ84E8E+NShRa388OVAlPTYFOxTu43XBp7yE3HGHHUS8AcTcx90s1Y9My+C32AllHHD2+iZRC97CF7jMTcCV53AK9/KugYr9EkJGtQyyMIKtM6NfNOybiaDwqVPPz5Rt6Y0VMYvNxGUN2OcOLZxbRtsxSogdHUp3TnJU7wfLIQUspafiFLnACp+2GHFpaOsoFvTHcRVti9pYDWATbgYGLtVpz/qAzMv3gXPNK1f+gHLPsBEgVzfUOjLbxayleIReIlgWcMLQUTo/iTblIDzq5zVQNG1GH4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkeI5jkkFejz48yN6uYjWP3zvvkxC2bWqm+FfACFHyA=;
 b=P8oPCo+gmj45Skbw3PqZ7d+UZ7OkWIlao2t5gBqNogKA0BnExaOlMyzHcb8Xe/mTz6kZZK2B6v8f2zYiH2szD9+/wZYIfFFyqtfLahnmoCLNDt9SIPkX9m0GRESz9EDWIRUTzBI3ZLae6pptn/gvuvgfG9TaqCXu2ZuAfkNSP64uC2QP5nd2NJhs8WFQKC+mslEl2eHhr9+HznKq3Kpum61JptO1D6KplPGE9E4fqsT8uUc08TKUhqOdBZL0ipSp2lVK5InA2kPbwAsqUz4iGsonpr+xkSt1hKbugY+uPMw5BBaG5Q9AEWNi4YSCSHiQCURrO3V2r8F61tBCcJtnjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkeI5jkkFejz48yN6uYjWP3zvvkxC2bWqm+FfACFHyA=;
 b=bVH5DztC7Ag19XM+cVzydCDP/CNxOpU8pl3C6FL/pwH3v2ibVp9SD3KRjIbUI4MjB/OCtjKYV4weuy4dIvz8rM5evljM7WSTcXN32B350LP5SRcCYKe4Nm2dp/rd6IUwMFcvC7sh7NNQyJfkFgun5JQcbd1jnzgN+eptgqNZvl4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 BN0PR13MB4695.namprd13.prod.outlook.com (2603:10b6:408:125::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 05:25:19 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 05:25:19 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Benjamin Coddington <bcodding@hammerspace.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Rick Macklem <rick.macklem@gmail.com>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH RESEND v6 0/3] kNFSD Signed Filehandles
Date: Thu, 12 Feb 2026 00:25:13 -0500
Message-ID: <cover.1770873427.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P221CA0011.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::8) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|BN0PR13MB4695:EE_
X-MS-Office365-Filtering-Correlation-Id: 88063985-2b34-4d5c-d859-08de69f71c75
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2rn8Y+O0TDCZs/jHrEBzDXNE5/+N+uxlucvRqqAka2JE3bSlTOH+nctUo3NB?=
 =?us-ascii?Q?8km9NLIo+EuH01d4q6UKaJHYF53WxO5OXbQnkd61io3xWvqnyu4jk19XWpxZ?=
 =?us-ascii?Q?8OyykKQHFx+fbXwuBfPmowFOyJTW8BjGXFtiapjHia9xodtE/zYyOL5aAFng?=
 =?us-ascii?Q?tKK7v+DqSzAM+IJHsLPYQ+RN5pN6412wByOWnRToXBR7YNscKzySkXcPfsAl?=
 =?us-ascii?Q?3Sl5LRi4bRPvjodxCInr0123GLtxo8WaHrYzts21Ksxv7RyUEv5nER980SBP?=
 =?us-ascii?Q?cy0egVYcUtZdWX3JwyNNwP0oLsu5zDVSFkrCsS0hSfyyEKpNs2UkUmdThDme?=
 =?us-ascii?Q?IoigmtvwUHp2oEXPBYSWS1F21+0hDssof41G18Kyo6GFzyWq/FCSGjgSmOru?=
 =?us-ascii?Q?Hw7TejjPaZEOCmuVAOmu6/NVq6TPkXPxP4yF2bIdEPoZvypSthOnFbKSv0o0?=
 =?us-ascii?Q?tweqM5Ap0xOFSL1H2vNQHmwIj0DZOi41zKHknKLkr70Fzb13crES3N4okHgn?=
 =?us-ascii?Q?q0JgMU4J3rnQfcbsHIZnADv23tgK2ADBX1sjIfUYYrpQcA469hL+5oeJewHS?=
 =?us-ascii?Q?+WZ1ELxPkmKDH7F+m/YU3yAzyhaQIzpI1yaiBNBD0iXfm9wfg8sFHjg1h98T?=
 =?us-ascii?Q?IWGQ34fzAg/FMYfl2o/TFEU45bNwbJMc2OCwv4LDtMkrDyVY8dNQSQZUrhVb?=
 =?us-ascii?Q?Tjfw7So16kOMcUaEw2GNK+7AwLKgaQweP+hfjLmNxWbtAjx+r75Df2+cZeEx?=
 =?us-ascii?Q?QvtuwMosexjFmdxtE78GIh2n7kbRJErTr44nEj/XZfTfWLXhb9vHvtZIvx/z?=
 =?us-ascii?Q?bSHybZ3tbnocB33KNpQYUOl++DSQ4FZlrFTmxQL0x+fnO1ZHHO1h6R1FKiIX?=
 =?us-ascii?Q?s3vzxYzl2H3Om5bH4bxP3aw5+QE+Td2J67d7qSQDPcDP5hZu6KXVSew32il4?=
 =?us-ascii?Q?I7pmjvisY4/3WcxcFkLMVb6z93OV8YybDh/4M24CQwBrEkp2//OQMiLdTLxH?=
 =?us-ascii?Q?ryaQkHTeQ9yh1Sc7Kgrt753uS8zLMk6H3n4lY/HyFpVoshiu4TQb7noRwExe?=
 =?us-ascii?Q?IjlpfhjUIFT7W26RAPyzLH5EjsWvZ1A2tuPeVBrdhj+WloLnxjkr5G75u1XE?=
 =?us-ascii?Q?Gkg8x3343I6/DLFWqP1ffpxOgducODnDq3/No6wqeURUnBV4euYcbmYksc5t?=
 =?us-ascii?Q?kCsb2BDxSxETjVjN1sqBzphXq8h4sswzhjVAwqxwTPlfCoolzIVeABaNrFt+?=
 =?us-ascii?Q?G71eF196TcIlhDqDVpB7F6qj9PSlxLSN+FGGAnt7U41q77Ujy2gZnuNsaIwd?=
 =?us-ascii?Q?ol9EoJhiru4u8CZq3sUVjJ7QhC3yswvploPWDiPhnhFaMn2KTQqrA390/BAX?=
 =?us-ascii?Q?jW4q0no5cqYFNjN55PNtYxF2YWd5dnY45twvU8yp+LrYyAu47sM0vpg2pTk2?=
 =?us-ascii?Q?L4MEpB3T0o5GESsTchaWtxkGC/zDTO6wlFlhKoW69G/yl19fRYs++GAZNFo2?=
 =?us-ascii?Q?SHErXWpx1yIKJGqQKLFwZ0kkOd8fiiLQMPpfugJBznvwj3ucY9Y8BnBhr7lE?=
 =?us-ascii?Q?9mAQHK2CRPKgZZCTw24=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FNQW/QLrwn5rXaguv328WSwmDJOrA19l8uo673lrzNxGYRIhZchmfvQ9flSI?=
 =?us-ascii?Q?uOYrTmqGfatgWoDeOB2bxzjauMLK3fpnBi/F0dnYOwlm/vFMMu4rq/FjanX8?=
 =?us-ascii?Q?z4Wm8I4ng2h8f8OQ9vuMNofNO5ZLUk0UiknbOrRUjgNgn/KClDlvmMvCLVaL?=
 =?us-ascii?Q?tnbC/1U9jiW/D5tmzSkErONpPPk7zZbpMRAjZ3j7lVArADc1HDSPt6M26oq1?=
 =?us-ascii?Q?s4e60Gm8CwNpsv6D85DZmDI7eS8oqNyLt4DsA3XK7kYbJj3n5Y9xaid6A86n?=
 =?us-ascii?Q?kC0w31P+96WEiJ1c+BZrkzyRS9gBlxExf9BqAgnO8X3a/hTIlJ82Vp6g+h+L?=
 =?us-ascii?Q?2xy5ut8N6L0kH1q0Kis0TXYBtcWENUVnlgde93dW17h3y8Na6Z/6VDiQu29F?=
 =?us-ascii?Q?7z1aOLVSEOYwfcHhT2+46j7qleon3ZVywadZ2sJpPmlWM5z+o/Q9ApZwBpT9?=
 =?us-ascii?Q?doifdfXlMDzXzUyZi9LQOqM8LaCszN6EfGN+OdmxzPUJLNOmfxviHplrW7aY?=
 =?us-ascii?Q?9YrqIg2jtd0xHNHJ7vGk+TB4INoTyrOU33hMYtLLbpqxE4VnPSE3hVwM/NtU?=
 =?us-ascii?Q?iB5FW6bBhjFaqOCZbnWxgMGVOu/cYLyF/PktS7Mj33R9iZzxsByhVrBZvJQV?=
 =?us-ascii?Q?F0taLASXul6lr/FMfBNmsrW0OiA4wD5tjg3p7YxGK7PHm8/LE4RaQoxWbh7I?=
 =?us-ascii?Q?cbK6mu7ODtfT4AWw4vLym8BtzJKkc5azd7RgOUUiTKgX5fdqD/sWy51c2hM7?=
 =?us-ascii?Q?+F0CgzI2bwDN7Ry+rSxSz9NPs4VdroVooed0E6PuruXjzkopjCXUNrLbW3uP?=
 =?us-ascii?Q?kLz8BNd0GtiEN8jogb3689G2TLOg6tiDtb4Vh2DZVVPOoUS5ka/GkNn6Rxbq?=
 =?us-ascii?Q?ZvYLUkeAv+lzGVHbD2RbhgeMMf9GIGRLVgEKPcDszLItiBm92ZQbxpbElXdY?=
 =?us-ascii?Q?eVkjnFB2RlhF2awYTeejr2znVUexlKVq0qqPYfQGqMEWaF1EoNTSEZdEhmbX?=
 =?us-ascii?Q?vwIB7SO73rsxJCJsyqThjY4/iTWpuvpsZN/vl844eosorC6Xqj0OzJ8+jNsI?=
 =?us-ascii?Q?9+KsOjMZMpQzUY6qR00DUj+COMLGNRduv8lFAlSE1RFqfoVM22X1INoHPWkS?=
 =?us-ascii?Q?SQxf9H6QQf06AYkJgLSuuT4xayGq9bcYL8jTfmiSsTlFoGsvKonMPlptkDY1?=
 =?us-ascii?Q?O+LbtWoQTLzB57BtccDgSp2e1Bq2vipBypikbAYqnphvtq5sQxE1AnApin5m?=
 =?us-ascii?Q?W2yjRfWYLUV43jKKIV2RAx/g7pNNHYVJQdXtHSMYBgQ+GyPU89zWcDeBmYGW?=
 =?us-ascii?Q?uXFmjoKo7WzEo9ZjnS8AbuHe01fyc7i5S9Gg07dUGeO1C0PUA9HTibNoD1J0?=
 =?us-ascii?Q?pSWEr5S83LfjYqDYzRZ+nA+1Op0iO4dk5Dv36re10wKzZkcKZThkB9PHgbiT?=
 =?us-ascii?Q?euidOowCtc3mA6mvbTtsFVn3ec9pyQrKKTbd8nvlRpF2+SU1MhYcQ2e7wE/j?=
 =?us-ascii?Q?mTvQDDUHA5w4bUQXZB/zXcyh+fisNWRNSLJ3dL5QHnlj0E92RgnyhOSQoItU?=
 =?us-ascii?Q?tHCWjd/4qoIUPlxIkHAwgqEjN+txT5SmJrNwZHoKFhTHSYnBdVk0EL1y/q5T?=
 =?us-ascii?Q?LXg1MBKZL80bT/M4KO2kfyWiHcNk+SlJM+tSPbOFwL2QHoW6/qNkCj/2zaTL?=
 =?us-ascii?Q?VAJSeJrpxyVJSBp6z5m0dfmReR85znUkn6ltQm4sLCZsfD2ms6Uf7gSACtsV?=
 =?us-ascii?Q?+ryIclMg2vK1g7cWDJcl8RxsM3V6pIg=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88063985-2b34-4d5c-d859-08de69f71c75
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 05:25:18.9563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNuKgj1EtgIvcKBM6GRNj1Krt5Tqk1XtHxfBA5/f0rvN2RnVCapBCzhoAvCzH2SHH1Ey5kt9sIF+nHWlmCVATOCz9yPfC2huESJJnZ6YbXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB4695
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76991-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:mid,hammerspace.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0ABD812A64E
X-Rspamd-Action: no action

The following series enables the linux NFS server to add a Message
Authentication Code (MAC) to the filehandles it gives to clients.  This
provides additional protection to the exported filesystem against filehandle
guessing attacks.

Filesystems generate their own filehandles through the export_operation
"encode_fh" and a filehandle provides sufficient access to open a file
without needing to perform a lookup.  A trusted NFS client holding a valid
filehandle can remotely access the corresponding file without reference to
access-path restrictions that might be imposed by the ancestor directories
or the server exports.

In order to acquire a filehandle, you must perform lookup operations on the
parent directory(ies), and the permissions on those directories may prohibit
you from walking into them to find the files within.  This would normally be
considered sufficient protection on a local filesystem to prohibit users
from accessing those files, however when the filesystem is exported via NFS
an exported file can be accessed whenever the NFS server is presented with
the correct filehandle, which can be guessed or acquired by means other than
LOOKUP.

Filehandles are easy to guess because they are well-formed.  The
open_by_handle_at(2) man page contains an example C program
(t_name_to_handle_at.c) that can display a filehandle given a path.  Here's
an example filehandle from a fairly modern XFS:

# ./t_name_to_handle_at /exports/foo 
57
12 129    99 00 00 00 00 00 00 00 b4 10 0b 8c

          ^---------  filehandle  ----------^
          ^------- inode -------^ ^-- gen --^

This filehandle consists of a 64-bit inode number and 32-bit generation
number.  Because the handle is well-formed, its easy to fabricate
filehandles that match other files within the same filesystem.  You can
simply insert inode numbers and iterate on the generation number.
Eventually you'll be able to access the file using open_by_handle_at(2).
For a local system, open_by_handle_at(2) requires CAP_DAC_READ_SEARCH, which
protects against guessing attacks by unprivileged users.

Simple testing confirms that the correct generation number can be found
within ~1200 minutes using open_by_handle_at() over NFS on a local system
and it is estimated that adding network delay with genuine NFS calls may
only increase this to around 24 hours.

In contrast to a local user using open_by_handle(2), the NFS server must
permissively allow remote clients to open by filehandle without being able
to check or trust the remote caller's access. Therefore additional
protection against this attack is needed for NFS case.  We propose to sign
filehandles by appending an 8-byte MAC which is the siphash of the
filehandle from a key set from the nfs-utilities.  NFS server can then
ensure that guessing a valid filehandle+MAC is practically impossible
without knowledge of the MAC's key.  The NFS server performs optional
signing by possessing a key set from userspace and having the "sign_fh"
export option.

Because filehandles are long-lived, and there's no method for expiring them,
the server's key should be set once and not changed.  It also should be
persisted across restarts.  The methods to set the key allow only setting it
once, afterward it cannot be changed.  A separate patchset for nfs-utils
contains the userspace changes required to set the server's key.

I had planned on adding additional work to enable the server to check whether the
8-byte MAC will overflow maximum filehandle length for the protocol at
export time.  There could be some filesystems with 40-byte fileid and
24-byte fsid which would break NFSv3's 64-byte filehandle maximum with an
8-byte MAC appended.  The server should refuse to export those filesystems
when "sign_fh" is requested.  However, the way the export caches work (the
server may not even be running when a user sets up the export) its
impossible to do this check at export time.  Instead, the server will refuse
to give out filehandles at mount time and emit a pr_warn().

Thanks for any comments and critique.

Changes from encrypt_fh posting:
https://lore.kernel.org/linux-nfs/510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com
	- sign filehandles instead of encrypt them (Eric Biggers)
	- fix the NFSEXP_ macros, specifically NFSEXP_ALLFLAGS (NeilBrown)
	- rebase onto cel/nfsd-next (Chuck Lever)
	- condensed/clarified problem explantion (thanks Chuck Lever)
	- add nfsctl file "fh_key" for rpc.nfsd to also set the key

Changes from v1 posting:
https://lore.kernel.org/linux-nfs/cover.1768573690.git.bcodding@hammerspace.com
	- remove fh_fileid_offset() (Chuck Lever)
	- fix pr_warns, fix memcmp (Chuck Lever)
	- remove incorrect rootfh comment (NeilBrown)
	- make fh_key setting an optional attr to threads verb (Jeff Layton)
	- drop BIT() EXP_ flag conversion
	- cover-letter tune-ups (NeilBrown, Chuck Lever)
	- fix NFSEXP_ALLFLAGS on 2/3
	- cast fh->fh_size + sizeof(hash) result to int (avoid x86_64 WARNING)
	- move MAC signing into __fh_update() (Chuck Lever)

Changes from v2 posting:
https://lore.kernel.org/linux-nfs/cover.1769026777.git.bcodding@hammerspace.com
	- more cover-letter detail (NeilBrown)
	- Documentation/filesystems/nfs/exporting.rst section (Jeff Layton)
	- fix key copy (Eric Biggers)
	- use NFSD_A_SERVER_MAX (NeilBrown)
	- remove procfs fh_key interface (Chuck Lever)
	- remove FH_AT_MAC (Chuck Lever)
	- allow fh_key change when server is not running (Chuck/Jeff)
	- accept fh_key as netlink attribute instead of command (Jeff Layton)

Changes from v3 posting:
https://lore.kernel.org/linux-nfs/cover.1770046529.git.bcodding@hammerspace.com
	- /actually/ fix up endianness problems (Eric Biggers)
	- comment typo
	- fix Documentation underline warnings
	- fix possible uninitialized fh_key var

Changes from v4 posting:
https://lore.kernel.org/linux-nfs/cover.1770390036.git.bcodding@hammerspace.com
	- again (!!) fix endian copy from userspace (Chuck Lever)
	- fixup protocol return error for MAC verification failure (Chuck Lever)
	- fix filehandle size after MAC verification (Chuck Lever)
	- fix two sparse errors (LKP)

Changes from v5 posting:
https://lore.kernel.org/linux-nfs/cover.1770660136.git.bcodding@hammerspace.com
	- fixup 3/3 commit message to match code return _STALE (Chuck Lever)
	- convert fh sign functions to return bool (Chuck Lever)
	- comment for FILEID_ROOT always unsigned (Chuck Lever)
	- tracepoint error value match return -ESTALE (Chuck Lever)
	- fix a fh data_left bug (Chuck Lever)
	- symbolize size of signing value in words (Chuck Lever)
	- 3/3 add simple rational for choice of hash (Chuck Lever)
	- fix an incorrect error return leak introduced on v5
	- remove a duplicate include (Chuck Lever)
	- inform callers of nfsd_nl_fh_key_set of shutdown req (Chuck Lever)
	- hash key in tracepoint output (Chuck Lever)

Benjamin Coddington (3):
  NFSD: Add a key for signing filehandles
  NFSD/export: Add sign_fh export option
  NFSD: Sign filehandles

 Documentation/filesystems/nfs/exporting.rst | 85 +++++++++++++++++++++
 Documentation/netlink/specs/nfsd.yaml       |  6 ++
 fs/nfsd/export.c                            |  5 +-
 fs/nfsd/netlink.c                           |  5 +-
 fs/nfsd/netns.h                             |  1 +
 fs/nfsd/nfsctl.c                            | 41 +++++++++-
 fs/nfsd/nfsfh.c                             | 75 +++++++++++++++++-
 fs/nfsd/trace.h                             | 23 ++++++
 include/uapi/linux/nfsd/export.h            |  4 +-
 include/uapi/linux/nfsd_netlink.h           |  1 +
 10 files changed, 235 insertions(+), 11 deletions(-)


base-commit: e3934bbd57c73b3835a77562ca47b5fbc6f34287
-- 
2.50.1


