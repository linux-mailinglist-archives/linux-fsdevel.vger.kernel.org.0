Return-Path: <linux-fsdevel+bounces-76960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MLtOAW4jGnlsQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 18:10:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 849F0126768
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 18:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE37D301E98D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 17:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91FD345CC9;
	Wed, 11 Feb 2026 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="NHoNp3TF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023074.outbound.protection.outlook.com [40.107.201.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E7933EAEC;
	Wed, 11 Feb 2026 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770829794; cv=fail; b=SlsX3/PGPP0tcVVOsRM7PZKyFby3Sy2AlqGIQqpCqz4wyl5aLwoTTmUcK6KCOCOS6+6akhcNz4KzHxwkOKa/Vm5C4O5X+GLeJ4RLhBrCRA89OCCf44HQqia/XiroQcF24mxLH1+dwWNlhMey9m1wBDCTG3hl6DTw3DiRvDV90MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770829794; c=relaxed/simple;
	bh=Hr5SHlJwRGaifSMW/to+FEc/PRGntIzHjh6t03z+Pzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SVQlIb7VcTgDjogbfkCWUyqfkyx1757NxcvcXS77a552AwwrulQzui81WHhNBlUyGj7NSxBFA1ZZAmk+vK1v/0yUsi1usVOOrJxCh6WwPnQBeWc/y6fP6xHFskzre5yinqY++Ae5+aK3DrOvVsHwnADQ+OVnMbc7tHDtsLjy3pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=NHoNp3TF; arc=fail smtp.client-ip=40.107.201.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=risuDXGhAc6CukRXyv6IuT+4K1zKp/FAUqdcmsZAb0Q/iaxaBMI6HNLdI2b0v/EY13SzBf+2ZCYIY/dcuBB1S8V21GaNx+c9wHIJtTWrWQe3quPmBlxU2rf6VSGU4GGbi+0ziIbERxQ98b0lTF/whVWvCLnRqEkZ/beasaTGjIbl0/wuL4CH7Oe4nsYZEHzHBq0W6LUCPjpMsvupC/yXx4Uf0spR2K5j/PpS8BJayqys+/T3x+2VKErmw8GrPC+vnBSoJCKDhKQgKGvUj1H7XlJT3rFAg977i1JWaR9gV2IqFU8w8jWIyYuAKUsYwDnxI1E03u0FIYOO3g+2J+QE6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejHoGetjk7V6VfNOkLt1YVqTozT3+TR0dYyxO3av0hI=;
 b=zOIpmDPqMS/6DlMOp63Izvx8LeYs6+vtxncGZfCOI2LoJ+8rxQffKCdRkFMYhZG2fOZfJ0ofMYGvtm1v0+NwMOYpwwz1UtfzLGHn41AX37VPdO/13jMFxfe+X7NOUkamO5kr6Q63vWJpK3Xjpyh5a+cpG8bgSdSl+10IO52MkhRBrFYVsrfGF2+gEghjnucx8Ett9t/GsKe0b04aL8tEPjIFdvihyTVzp90gAQxYxhUPmD+C6s1+zOXEphZCPTmGLefcTfz671ImrnKnWfkDPiz+bvJKrld0N6jbDuNoHSlKWJ3rfzspS/qysEkpvP3caC1A3G2k+0gqcIEWrzB67Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejHoGetjk7V6VfNOkLt1YVqTozT3+TR0dYyxO3av0hI=;
 b=NHoNp3TFq2pn4SrtBaRGHIW6h8hRJOYT3OrCIo8iQdiC2yob67TfMrmkkJ8jERpPM8tCyaVjHlUnP81CLdcsLcDEPw7ze52UDS1xrFRzya7NP97oY0ATU5O051/UETL3ujzpC5iPejqvDvAn4cyXQiVqkY3ZEBoDJ/86fFd8kaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 DS0PR13MB6252.namprd13.prod.outlook.com (2603:10b6:8:117::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.15; Wed, 11 Feb 2026 17:09:41 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 17:09:41 +0000
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
Subject: [PATCH v6 1/3] NFSD: Add a key for signing filehandles
Date: Wed, 11 Feb 2026 12:09:33 -0500
Message-ID: <add9277af86714de8ba1b848cdc3fdf61e114b5d.1770828956.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1770828956.git.bcodding@hammerspace.com>
References: <cover.1770828956.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0084.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::7) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|DS0PR13MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: 62d97b9a-3b29-4b53-3632-08de69905855
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DmN0ZQiDPaurTCulVAl+As7okIsGe1wJrne/AvhuKPoavqYIkojK02P+JsP5?=
 =?us-ascii?Q?OcptoSqPI0h95kzle+hZSZf9fWLniMS0CaL6QVPx8j9wybbkHOZnT65rEdse?=
 =?us-ascii?Q?VEtvmNRgY7ytQKnZfOnktTsXvym69iMB09X/Hzr8EAgrrnzE5CZ1oUvO4pQD?=
 =?us-ascii?Q?Q5rH0pyoEl/Ld49gwdi/+eOxlWMfMMT4PF+SrqTD7i3BRadwByQgvJYbZuPV?=
 =?us-ascii?Q?DFPU2KK5Z+K0g00sOvuhnFvx270lcLUf3/3QXIGKTl20l6IIwANXyLoxTtvX?=
 =?us-ascii?Q?n4BPf1/xiYYE8WcIcYPavodfmX0hn+FBPKLcwLNY3ws6/dfexsPsmRVeXvTx?=
 =?us-ascii?Q?vcrojYHUqRfA9oOcNAKiwr7VdnNQblh9Cd5hybbiuLIjvH+8lIW0okqcC2Ye?=
 =?us-ascii?Q?CYXMcU/QvFw4+dJ6eSoEnPOjuJKbZhLii2RuPvHuOe9dRLpgEKR3Bz/8sEmf?=
 =?us-ascii?Q?HdER/3J/KsjmRRLrRXQUMqDQIOVUsuUCbi0A9l3cw3/08D4YE49fb7sCgDrc?=
 =?us-ascii?Q?XETSPw6KKtijn9IIPU4F+7k0SS3wvk2CbzhL9vXRUEwUdDyGMdlenPzBKoWb?=
 =?us-ascii?Q?YEl7wPdKCv/bYGXn0SNVA53+g040+rz5VaS0Mgkq/B5dEyV6S84UWbfiTYrM?=
 =?us-ascii?Q?2BGZYxvmSYNmu3HaO5VBt8yFKQjRTswyDaND5hTKSHAP3WsPxG9XBrWuOch7?=
 =?us-ascii?Q?b4lLbpkeUU6rLznBMcswcrGio8fPVsIIAn0JHo7+k/iCn1Nm/kPLFS6L+2gF?=
 =?us-ascii?Q?T42OdS6qCdQP614pRRQr2q8eHPrbfJhZYlyNDBwxPg+SLH76fSAkgxT4Cl8C?=
 =?us-ascii?Q?CfskR3lbRqjlcolS4YCicHSIByMcH42sLx3/cPPIaSG9gplO/bretR+eVtvU?=
 =?us-ascii?Q?noY5aemPsdErUYIQkN2vLODHlx/UUj+kJiSLfolARAdgyowdFi4z4ulz1L+E?=
 =?us-ascii?Q?fStdto+BiI5qSqoqXmeUXVeQf2dosLLFkz5llmx9ofuBUcKhoWhjBOsa3mV1?=
 =?us-ascii?Q?7/BRevJmjGW1iMFKJEm9+UjfVVLRUx30Qve3Cj4OQMzDLZI4RvLjx+yWpZpP?=
 =?us-ascii?Q?ydpKijmENhxArXcGmy6kpXw5cvYvkk+urc34yB4pBhIXHZ9sR0QEq708o62G?=
 =?us-ascii?Q?QYeYx99JY+iZ+AvnZGQicNyz3j6Af06OYNB8mYMNcrocIdhIjN80Qg+CSnpZ?=
 =?us-ascii?Q?vNGvZK3w7u8k8kxJCKgwA0LD82LMVsdnkwdCNA3x0f1hXOvIGOM6Ogu6jNAy?=
 =?us-ascii?Q?PAwsKRPyGieEX3GCZwEgg/zHcuihS+PMl/UA0ewutdZzOKwrt9IkvGR3iBrS?=
 =?us-ascii?Q?yuEnopaprgOAf5kWoxRMlksGt1pj/hzifJAW9JW323RV/dyM7d4LgnRWif/o?=
 =?us-ascii?Q?9/OGydJliufFvFR/LpJRem1kK0+C41NjxT22QtZoWwn+NYNsSvxHc4A88R0P?=
 =?us-ascii?Q?jsupiMGdYQW5M3jhFpXq2nSZ5xmx18i91aVTp5gRhknXNHPyE+irV8bTSPV2?=
 =?us-ascii?Q?sq/uypVgp2PIVB3hLHp0N2bZUdzD4twSRxVUqG/2yjAMu8ZVSklD6UNzH9CH?=
 =?us-ascii?Q?9F6WEtm88suespgBsW0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XEj73g7+bosV1O6XuTxFG1BNeeLA7VMHoEtijPNILHrTMLVd9RGVPAQdljS/?=
 =?us-ascii?Q?yMbHl7lFYPOuHM4Ui6xvpM8s6+baeEP9+qQRA5u7lWuEMeFo6v5w5WPvjE4j?=
 =?us-ascii?Q?+F8bJmvsmbO47OJBbq57+sCfH10R62duOpl9U8siaedJb9Xy4+bopy2YGLeZ?=
 =?us-ascii?Q?dY8rOQ6msv1k0JKsMmAAKvrEKgcYCCgRZNEVLAZ0bffHRAehxFnKa8ELKzvW?=
 =?us-ascii?Q?ZFFc0xj6Vy3ZHFkAvxwQsFiDwpqlSKJT38VeEGPPf92IyOk4YHv7ItCyyykl?=
 =?us-ascii?Q?bvUX92de2GByvd70HXhQ4BFe5s8Xk3LLEseL7Fxil3saxPuqBLeD4Ek5XZar?=
 =?us-ascii?Q?JUus9z5TXbWvw2WtF2GMfViyjCepzPP3hYODTubdtSR6/Ek6UoZS7MlrIHyY?=
 =?us-ascii?Q?G3/17ZSlhLiOr6KGPbV1Mqf8i0hLhkuN9QLEOmedQ0oJ4A4jL9X6I9NzW9TW?=
 =?us-ascii?Q?5EwbdV7FJOQb1vzUkCY5pCyHrwbwZbKMB9AHr1pABeJpM7gxGLgLa6A6L9a9?=
 =?us-ascii?Q?WDssZLN3KROFm9g8WPsmStMGsTWbsM5N8YhJrFacNNrROV2HOjVW6RJdQURM?=
 =?us-ascii?Q?2rxfKeyVDp8vlyuTEWSCVei+/GubrqaIkrhiEaK4BoBoOFWFzfP6GRs4HqGV?=
 =?us-ascii?Q?qsm1NKCxk7zIFlygs/487fsgE42sQW6zU4oSPnzGTWxhEHrhfOG7G6qV33tu?=
 =?us-ascii?Q?exzmSUkgyxxR273lbVAsjvu+P93XpcRtgQEdxAXoktJb75wVmxJo48I+65SU?=
 =?us-ascii?Q?CokyW6LPgslzRJT+TiwZ3mAoHkg15LMnuxJ6IzIS7kYE88UkzhtFivLXch+A?=
 =?us-ascii?Q?IDCgU7y3dbQF3MbjVt5WuBI1AueTd6vPmSKo/u797aRtxUxD2H65sUuxwZ13?=
 =?us-ascii?Q?B8YF4Zj/3SpZ6Pi5RAjnqPmcQMegZ2xzYF9psJa96calWsEC/c+F6CkzzV4v?=
 =?us-ascii?Q?oX6EGFGju88cCPO0F+uV6stOdK/p24XEQ8xpLRSi/06m4bdt/5hDPBnODjlZ?=
 =?us-ascii?Q?i/t4xhCphplJJrjdMk313y5vPqJZyi5e/ZF3he0i7iFjE7OyG9mlEnAk/ATf?=
 =?us-ascii?Q?tvFjqYs+Z/420HN/2JSHiVAJ+GnOMz/uKotv7VHS1q5PWf0VsCf2Wngctqzq?=
 =?us-ascii?Q?GQyKEBG7WKsgy+r7PHQToEullV6ImUznmyQbAHPnkEHfjpP9jhTGrK8oIu5X?=
 =?us-ascii?Q?zAnqN8nAvbSLZHStvUscTYapKalZr8vTrLD8D0xjQErEmPlNreEOidzv4q91?=
 =?us-ascii?Q?4Dk3FGBs4rVfJXeT9/fA1QRLwEIgYJNwJKvJywBeI3OP9j3V/xVEHyXjwUAS?=
 =?us-ascii?Q?w0Y/3ExnCeIMPvr6g7OAdLIfUfxu2uLfSu/BRS13UYXfx6L5I7DozH5sNm5O?=
 =?us-ascii?Q?d7+lEhgx0F50KjV8sW4acilWjSZ87rk97zgWo2Z9T4xfRH7pXNDVU8F/VPjl?=
 =?us-ascii?Q?XgyUzAz2uq6v7BFyW8g8sUsnqwo0PnZlylZXTUN4aWmrNriYZsqOL4oSFSY7?=
 =?us-ascii?Q?MkJDLkkToS1d0rEGsipTLdYbZ+B+p8u/nbmbgABgu+PD5isuhTb5vC5kwyrB?=
 =?us-ascii?Q?xyTQhQywpbiMLCPvzWLpAv3xsVLZu/yzoXurcAvQuOenu/doo5hFBkI7PsNQ?=
 =?us-ascii?Q?9oJEUUsjFAR78eb6rc5ogbRHfTSHYBmpBg6rGsbU0zFqZWGzRLbMlK0Hb2ND?=
 =?us-ascii?Q?oDCYd/+dY7zMynjfoNzWFfEbcynv83cQ4PozqTBjcfV2gVzdE+6WymFBNXdD?=
 =?us-ascii?Q?0zTKXfIOi7wOU6V9F2lIY9dig2w5R9c=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d97b9a-3b29-4b53-3632-08de69905855
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 17:09:41.3154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HElnZVh3sQMYYOoVlibeIrgBEtFL2LcTdYInZ3ZdJc44nGvebx72TpIhRPMnvVypeG9P7ZzjLPGq1g5oDSg4/Mk6STCyChGxWWDdNz+ZGXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR13MB6252
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76960-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hammerspace.com:mid,hammerspace.com:dkim,hammerspace.com:email]
X-Rspamd-Queue-Id: 849F0126768
X-Rspamd-Action: no action

A future patch will enable NFSD to sign filehandles by appending a Message
Authentication Code(MAC).  To do this, NFSD requires a secret 128-bit key
that can persist across reboots.  A persisted key allows the server to
accept filehandles after a restart.  Enable NFSD to be configured with this
key the netlink interface.

Link: https://lore.kernel.org/linux-nfs/cover.1770828956.git.bcodding@hammerspace.com
Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/netlink/specs/nfsd.yaml |  6 ++++
 fs/nfsd/netlink.c                     |  5 ++--
 fs/nfsd/netns.h                       |  1 +
 fs/nfsd/nfsctl.c                      | 41 ++++++++++++++++++++++++++-
 fs/nfsd/trace.h                       | 22 ++++++++++++++
 include/uapi/linux/nfsd_netlink.h     |  1 +
 6 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index f87b5a05e5e9..8ab43c8253b2 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -81,6 +81,11 @@ attribute-sets:
       -
         name: min-threads
         type: u32
+      -
+        name: fh-key
+        type: binary
+        checks:
+            exact-len: 16
   -
     name: version
     attributes:
@@ -163,6 +168,7 @@ operations:
             - leasetime
             - scope
             - min-threads
+            - fh-key
     -
       name: threads-get
       doc: get the maximum number of running threads
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 887525964451..4e08c1a6b394 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -24,12 +24,13 @@ const struct nla_policy nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1] = {
 };
 
 /* NFSD_CMD_THREADS_SET - do */
-static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_MIN_THREADS + 1] = {
+static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_FH_KEY + 1] = {
 	[NFSD_A_SERVER_THREADS] = { .type = NLA_U32, },
 	[NFSD_A_SERVER_GRACETIME] = { .type = NLA_U32, },
 	[NFSD_A_SERVER_LEASETIME] = { .type = NLA_U32, },
 	[NFSD_A_SERVER_SCOPE] = { .type = NLA_NUL_STRING, },
 	[NFSD_A_SERVER_MIN_THREADS] = { .type = NLA_U32, },
+	[NFSD_A_SERVER_FH_KEY] = NLA_POLICY_EXACT_LEN(16),
 };
 
 /* NFSD_CMD_VERSION_SET - do */
@@ -58,7 +59,7 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.cmd		= NFSD_CMD_THREADS_SET,
 		.doit		= nfsd_nl_threads_set_doit,
 		.policy		= nfsd_threads_set_nl_policy,
-		.maxattr	= NFSD_A_SERVER_MIN_THREADS,
+		.maxattr	= NFSD_A_SERVER_MAX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 9fa600602658..0071cc25fbc2 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -224,6 +224,7 @@ struct nfsd_net {
 	spinlock_t              local_clients_lock;
 	struct list_head	local_clients;
 #endif
+	siphash_key_t		*fh_key;
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index a58eb1adac0f..bdf7311041d6 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1571,6 +1571,35 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 	return ret;
 }
 
+/**
+ * nfsd_nl_fh_key_set - helper to copy fh_key from userspace
+ * @attr: nlattr NFSD_A_SERVER_FH_KEY
+ * @nn: nfsd_net
+ *
+ * Callers should hold nfsd_mutex, returns 0 on success or negative errno.
+ * Callers must ensure the server is shut down (sv_nrthreads == 0),
+ * userspace documentation asserts the key may only be set when the server
+ * is not running.
+ */
+static int nfsd_nl_fh_key_set(const struct nlattr *attr, struct nfsd_net *nn)
+{
+	siphash_key_t *fh_key = nn->fh_key;
+
+	if (nla_len(attr) != sizeof(siphash_key_t))
+		return -EINVAL;
+
+	if (!fh_key) {
+		fh_key = kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
+		if (!fh_key)
+			return -ENOMEM;
+		nn->fh_key = fh_key;
+	}
+
+	fh_key->key[0] = get_unaligned_le64(nla_data(attr));
+	fh_key->key[1] = get_unaligned_le64(nla_data(attr) + 8);
+	return 0;
+}
+
 /**
  * nfsd_nl_threads_set_doit - set the number of running threads
  * @skb: reply buffer
@@ -1612,7 +1641,8 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 
 	if (info->attrs[NFSD_A_SERVER_GRACETIME] ||
 	    info->attrs[NFSD_A_SERVER_LEASETIME] ||
-	    info->attrs[NFSD_A_SERVER_SCOPE]) {
+	    info->attrs[NFSD_A_SERVER_SCOPE] ||
+	    info->attrs[NFSD_A_SERVER_FH_KEY]) {
 		ret = -EBUSY;
 		if (nn->nfsd_serv && nn->nfsd_serv->sv_nrthreads)
 			goto out_unlock;
@@ -1641,6 +1671,14 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 		attr = info->attrs[NFSD_A_SERVER_SCOPE];
 		if (attr)
 			scope = nla_data(attr);
+
+		attr = info->attrs[NFSD_A_SERVER_FH_KEY];
+		if (attr) {
+			ret = nfsd_nl_fh_key_set(attr, nn);
+			trace_nfsd_ctl_fh_key_set((const char *)nn->fh_key, ret);
+			if (ret)
+				goto out_unlock;
+		}
 	}
 
 	attr = info->attrs[NFSD_A_SERVER_MIN_THREADS];
@@ -2240,6 +2278,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
+	kfree_sensitive(nn->fh_key);
 	nfsd_proc_stat_shutdown(net);
 	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
 	nfsd_idmap_shutdown(net);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index d1d0b0dd0545..185a998996a0 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2240,6 +2240,28 @@ TRACE_EVENT(nfsd_end_grace,
 	)
 );
 
+TRACE_EVENT(nfsd_ctl_fh_key_set,
+	TP_PROTO(
+		const char *key,
+		int result
+	),
+	TP_ARGS(key, result),
+	TP_STRUCT__entry(
+		__field(u32, key_hash)
+		__field(int, result)
+	),
+	TP_fast_assign(
+		if (key)
+			__entry->key_hash = ~crc32_le(0xFFFFFFFF, key, 16);
+		else
+			__entry->key_hash = 0;
+		__entry->result = result;
+	),
+	TP_printk("key=0x%08x result=%d",
+		__entry->key_hash, __entry->result
+	)
+);
+
 DECLARE_EVENT_CLASS(nfsd_copy_class,
 	TP_PROTO(
 		const struct nfsd4_copy *copy
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index e9efbc9e63d8..97c7447f4d14 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -36,6 +36,7 @@ enum {
 	NFSD_A_SERVER_LEASETIME,
 	NFSD_A_SERVER_SCOPE,
 	NFSD_A_SERVER_MIN_THREADS,
+	NFSD_A_SERVER_FH_KEY,
 
 	__NFSD_A_SERVER_MAX,
 	NFSD_A_SERVER_MAX = (__NFSD_A_SERVER_MAX - 1)
-- 
2.50.1


