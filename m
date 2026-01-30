Return-Path: <linux-fsdevel+bounces-75970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHV5E1I+fWmaRAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 00:27:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A44B8BF5C9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 00:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2538303E2C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 23:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A11637883C;
	Fri, 30 Jan 2026 23:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Fcv6BilL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022087.outbound.protection.outlook.com [52.101.43.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC222369998;
	Fri, 30 Jan 2026 23:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769815618; cv=fail; b=NLB7G6/eXcCtXrjdHiwekYHjdicfM8bgCmJaoXi5qYyhlJ5y/IPyMhRSxsXK24oMNmlzbS0bcLR0Om3yZq+gyQUIRxeDOqD9vXCIeFc9kSC81ls0ePvm8i4sp0KVldBKIRMGeXmaEz1HJXxvdNpVHL8aYZ2CPXIOVCpPX6HIPUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769815618; c=relaxed/simple;
	bh=L9fE8rIHm9FPEpqH23Q6Qh0b0T+En3x2Qw3GNZ2LpaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=szA91Dd4RUNMbjrfbswqdEnN+SbIOZfg4lOmZ+WiT4+pu+Fcg818/m791oLx2aCj507MFsDopkyWXGIWSnrZlWfxuNoMM5PL/RYNoVGDHpddP2gyPqboaFRLTyU/wPSXVtaEUhFYY/45UkExXhWM02WcGU12odGe/pvlukMmHa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Fcv6BilL; arc=fail smtp.client-ip=52.101.43.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rv3dJ8+bnuw0cvgT0Dirz8LsADOXGHeBkv+TmEcC/iTUbdhRLkyyMudTRraR5cUDgU4ccVKbPEVKFTR/HBlNkZkUYFuk4A7fodikZT49znbMwfAdYoM6ClOE3eSsQKHVZwcng5tkEC7fLO/ODFZt3UBs1P4UnfB2UwtZipIpVsGpvzjj23o6eO0kI4/YHjJLHDHBqMCGscfv3F/Fhnrv776N0cADQ37OVb/4LzdOs95R0gWln5XUGVb+WPoZniLppzpGEsPmOXwoClGuoclWdJ7cNJEp2NLNRzYfTV0Hn27B99IfupQeaxfYEUiEk2vD4lo5vJ6p6rURc22WdxnPzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clpv8Wun2eyAHiHLfsNX3Z2XYPeBAHnZXgw9Eb+y4MM=;
 b=BWYV1LgBYZFcfm9Y4MmmUiBCJdeu+ZM6ivgWhTUDIWwKjkGA7MWJbhxDMxPRq71nob9MEktk5BoClwpTBahi5RUb0qZno6bkmqo9sRSCQ6P8Bod+EV+qOyZOI10ej8s+awWAwhqOlyPsrnOtabf0kKYyzwQwKHG+LQ/UMuVSVToT3Qg7U19AKvS00TovVYpULDDTvPWTERcAGQKV5YEVpdp6dffOTN3Iw3k4G2qu7gC2w17jnBo9e92hOxtz3vmzIDFPdoUbYPkVZTA3cQdcNsO+6ajeZRrHqzeLs7MunhQ6tJkcdNk24XUzt5wNuhxMeWkqUvor2aY1rj6w+Tsltw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clpv8Wun2eyAHiHLfsNX3Z2XYPeBAHnZXgw9Eb+y4MM=;
 b=Fcv6BilLj0qMzyruKrejVXlOk7VVyJUF4JFsU1arnaAtU6fcABcENQcvD1Q0vi+/8liy2DQ+Hd5GKp9DtKMwCUxkLVtLqaY15XGoDzuTjFlluYGuGk7+jBHeUx1QTD8hVNoQl6eBlRfkRt1vIJRtrRPl8CdX9JomIZ/c0WfQe6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 MW3PR13MB3978.namprd13.prod.outlook.com (2603:10b6:303:5a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.11; Fri, 30 Jan 2026 23:26:53 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9542.010; Fri, 30 Jan 2026
 23:26:52 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>, Lionel Cons <lionelcons1972@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 3/3] NFSD: Sign filehandles
Date: Fri, 30 Jan 2026 18:26:48 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <9BAEC59C-126E-469A-A61B-2A9EF97DDB6C@hammerspace.com>
In-Reply-To: <556aa156-7453-4567-8e36-0edef995dcc6@app.fastmail.com>
References: <cover.1769026777.git.bcodding@hammerspace.com>
 <0aaa9ca4fd3edc7e0d25433ad472cb873560bf7d.1769026777.git.bcodding@hammerspace.com>
 <CAPJSo4XhEOGncxBRZcOL6KmyBRY+pERiCLUkWzN7Zw+8oUmXGg@mail.gmail.com>
 <97207D44-31EC-474F-8D68-CBA50CA324AE@hammerspace.com>
 <556aa156-7453-4567-8e36-0edef995dcc6@app.fastmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH7PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:510:23d::18) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|MW3PR13MB3978:EE_
X-MS-Office365-Filtering-Correlation-Id: 4856bac7-4558-49fd-8b06-08de60570c5f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ayU2VI6QD6aDV3qYuehyXW/XNh0MHxqB5CGIvtnnsyXFfYOahnspRIC3P0dv?=
 =?us-ascii?Q?/eLOPcyTE34qj9Nig4pWU4P3t1cnRcjv5GCUWO9gne+JVsYDBhMOR+mDJ/kj?=
 =?us-ascii?Q?WPqVVFj0fM6Wz1YPJABOHsGawUM+3HKycSFjUlAWYND3UG1SdgvdsYFXWxp0?=
 =?us-ascii?Q?Aai145PZuR8ODOPKl+QKXxukQmUFcy2dJ3gJrmQzXfNOiXkBvxnr8hTMY2JP?=
 =?us-ascii?Q?RHRH70ZOuQgN8XHedFnScvvd8adRUaaHUqBv/26PmF+o4a+S+8cAWZe3K0X/?=
 =?us-ascii?Q?1ig7l/i5Tx9eb54zJV9jTXLX3UcOOla7xUlqtwb8AX8fa4LKyydXA8C9Hncy?=
 =?us-ascii?Q?N9Y5HRfOKWD/aC4vp5PRdXdZ2Xv+2WOciAnBlPy8r2s4QGB8yUtwP51qS2ir?=
 =?us-ascii?Q?OjTu2rU5eojRyv2nWuUGSFV8WqDUSNcLwaBfGVcaV9EWaBt1s215rsU9nDyL?=
 =?us-ascii?Q?SaAz+ZZLgbsLwofyKF+nhf4yoeiiWXkU5reVk1aH7YeJh326SceXKv9EZCJT?=
 =?us-ascii?Q?/LvtR3El+c/WfhZDtVepE+R0v07xdin3eIyaNzEBQkU6BWrLKhciyMJssj2q?=
 =?us-ascii?Q?4+FkmqfoLwRkhq1aXc6kpyLm0tnpiG9MkB1gNhSIq9BasP/mvF9OEBN9txjS?=
 =?us-ascii?Q?GyUqHesJSmTLf4smlVDNjUo1yAzyhyDS0Hpu3Cxppj3c9K5F9i8SfufeI4eq?=
 =?us-ascii?Q?aqcUFcXtA4O/yUF97ILmqGK/6PMkQxOzcJnuSUO5D1PuAHTNMp+1NXBjnTvN?=
 =?us-ascii?Q?ZXcFyUUWMn7+UPnNzImA/sJhuiPkkDHlyA9uyggCXH5lZvABe3lT9JsEnD6E?=
 =?us-ascii?Q?n3JEinbeuxHOxwgFpf0/zmll3ywzZaqfZOpgfMKRi8FHQVH73nQ1E1xrTo4X?=
 =?us-ascii?Q?UNdwwxKnZrCdmbmZJWqBV7+st0lHGLh8NPSyKP2Knn002E3e242Ka9N0+5WJ?=
 =?us-ascii?Q?1b2ZDDU+nlZSEvpkowxvUtz9IYe4bj10Rvi89n4BeeecGIeqyqU5D3PjpKdq?=
 =?us-ascii?Q?NUG9JeHmHnntP3rtjtMlcPfz3bK7hjLS3JAND5At202OJh8riB5+DngW117T?=
 =?us-ascii?Q?pLCn32K65M8OpzqQh5Bj+XGvwRDwQiic5EYDNHGDPrkuHKrPw/JJJfNu5bat?=
 =?us-ascii?Q?cug0NUFfj8oPN/bGn+EKdd1BZXSbr47tbLY8xMxMn9wSgAcMtmUoqLXg+h7E?=
 =?us-ascii?Q?vSMFiSWrcuwUjY8bG/4JQEpHD9wmV60ka1NGo3fPXsrSfUFBoTJdOFezSOMA?=
 =?us-ascii?Q?mJWY6dzvdmMPWOFzlkTiFviYxp6iHo34fxtjlsiP7FFuIzUuc1CJa3jmJpf1?=
 =?us-ascii?Q?UTVR78YtAWJKmy+G+LDt6qeh5JcbGVodvxx315r/K3ftGmVi/oBIwD9w7O92?=
 =?us-ascii?Q?9/QVypLw+AENaCQx5GXjK6CuURke1bub0VdPT8ObV/0W4FKFg5XWzvUuR12y?=
 =?us-ascii?Q?gj3ua7azVdgHQC+GC12NwAD/vwBtejYEAFYvE9w8jMXgqY/pm05vfGbPnOMv?=
 =?us-ascii?Q?a7eZ2lkBqO+mvfIxpDi9bmjLkTHJ0d7ZzNyF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o2USnoOJj4iLdNTL1nPfX3NKIJjkEeH11/a6z6h8CsvELeFIc5EErA/+4JcY?=
 =?us-ascii?Q?jPA1MO2rd70AllxIwGrIkVV/qSvRqJ8OYqPNdwNEvDqM5qcWN0JQmRe0lypY?=
 =?us-ascii?Q?2daQzVNLmpMGiVsjMKKz2j9AEJsHI2luV5amfvQhpJ3UKyYdjQrQ2uSKkIfb?=
 =?us-ascii?Q?LuhTkeEwoW9jgwr6eaK5CtoHCDOqnf+lVa1Ax6zxypvcCgTk21HAiTCrUv4+?=
 =?us-ascii?Q?aLdFFVRWgrB3jWQkR9aBmH7Fd506v144iWqiyrXvvm1h5RiKrn+f3dP73Rgx?=
 =?us-ascii?Q?A6b/Hy/xA5p6HYoDL50uqX4Wk9BQreukxF9LkHfTcBsOYjMz/5t2OeeUxM8O?=
 =?us-ascii?Q?geOs5uPSNJqcrYU3wFl+itSwflfBDN9HR2znINlNsIR4X+yTqnbv+v64g1/4?=
 =?us-ascii?Q?iDGOL48kxAoZugn1mLanjPVkTOVURj8unTGd0YSGiWreQk3fCxYBPtZopqy1?=
 =?us-ascii?Q?YfcjWWmKjB4RYzTQ+sKThBYUfEIma1lC/MrQsqniB5dg8g+YJGVeG+YhQkml?=
 =?us-ascii?Q?OjvSbR2L2NGWWttGEpjmO9JAZ+0GOEkAyLB2M5Lyq5MVFmz71IKYF+k0vA3c?=
 =?us-ascii?Q?bdLNhfxg0vRsLjqNtnni4CCeU0SBQdDQnVb/DM78SIUXWPAs54X+hDo+0wet?=
 =?us-ascii?Q?TFuJ1fNZIAjz76P9ThaoPjDWo9a/b5s/pBO9do1UgDamHdJAjbmNtsnMG3eV?=
 =?us-ascii?Q?xNw0YgkDgL6mNzflZFYkD/bVzqUzBGF8f4C6h4MAFBRfa/xU2qAvF1vwTMDb?=
 =?us-ascii?Q?bRx5f+OL4E0VrKT9XmKY+7IFn9dy85Pbu5BWctPE5xO6Ejv3BH1R3DPpS0TL?=
 =?us-ascii?Q?S1HAjUK+VMbT4LXz8A7QSnyZoHpwLknxfjGr3cJhimQcmEOAk+TBud+axEgB?=
 =?us-ascii?Q?k4RVwDuIOXML/9l9CJrSK3lFz9qK/zXaCCJfILF16BnaY4Aur8yl8lPLvuK1?=
 =?us-ascii?Q?FPJFk+QqZwgpfZth8zXNxr6NvQF4ExsJLlHNt8ThKxhL46h3Uun8outBFUKp?=
 =?us-ascii?Q?bUmo8L748ZcYSKT7gnzbHhCuYH8yZSAl5D4wT+mB9R5xxja84jaRBLTtKBSI?=
 =?us-ascii?Q?yxh+59+vGDL3vICIaCbgA5iLJrrTvBhX/aoX54TbkwFSxLQ0k9zcGl3i0mba?=
 =?us-ascii?Q?JhbQUyxJ9oZCN+SEijc273OsNaayJ0sb5dhlTPxWWvfWUHGQFfeQVXcgLUGO?=
 =?us-ascii?Q?FUFDdI9RKn7WngAp6YbNyRr0ZocamYQCIlEc76Jbj7mv92KayOixWdMk4zkN?=
 =?us-ascii?Q?eE3xxew1mikYAPdLDftGv3qWsR8wPFBBpQ5UCDVIKeNYVsX6g56Ddd3wjp8v?=
 =?us-ascii?Q?iJhPL5gOS0CG+Yu1XhlzCyLSEdiB3WFq3y/JWcumVH2wIWSqz3Fww78Cg4KZ?=
 =?us-ascii?Q?FutYaeYSUXnFQrq5Te59GAKhtmWHjPDwHriA/yDRfRFtfmfdKlAjMhbVsWfd?=
 =?us-ascii?Q?wRp+b1AG3vYAVZB3Wcw7QBxtcqpLhDwlrJQIC90OC7VfZ+FyiI5G9plGjskY?=
 =?us-ascii?Q?gPY3wGvrudGSw9tXjrEAd7XOeSIq3wJatIF0qAP6djNQgL3VAJEWpI95flv5?=
 =?us-ascii?Q?kjyAet8D8yrwLwS5Iv5EQzN/ImVyHIYCLDv7y1atO71HgqVKqAnM5zPJ4gVG?=
 =?us-ascii?Q?oUf9W9xJ1aUoy6IOwk78B1gq0awP8scGRxbc9Z7IoP2Ci6sqnudrKmWYzoTq?=
 =?us-ascii?Q?rXvO8UxgR/covawL/suA33qgbkI53J47/1B07TqvVFVaHsMujWK3gkTZiqfM?=
 =?us-ascii?Q?hEEVpaolLPcD3o8Gtk0GxtwShWsGVy4=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4856bac7-4558-49fd-8b06-08de60570c5f
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 23:26:52.4518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSN9uEVej5yvpHb99mETxBdbXT2g5/9Ye3ZUuqlWRQoFNTKZFOJUhT93YS1+/sge6qqm9TK4CFtBPJYX1BLDSknUHees1JGM4MvY+5Rl+2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB3978
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-75970-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bcodding.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:mid,hammerspace.com:dkim]
X-Rspamd-Queue-Id: A44B8BF5C9
X-Rspamd-Action: no action

On 30 Jan 2026, at 9:47, Chuck Lever wrote:

> On Fri, Jan 30, 2026, at 8:25 AM, Benjamin Coddington wrote:
>> I could, if it pleases everyone, do a function profile for fh_append_m=
ac and
>> fh_verify_mac
>
> Trond or Mike can demonstrate for you how to capture flame graphs
> to very graphically illustrate how much CPU utilization is introduced
> when using this feature. It would be valuable to confirm our expectatio=
n
> that the additional CPU consumption will essentially be in the noise.

Here's a flame graph of a client doing 10 passes at a directory with 10k
files, looking them up and then doing GETATTR on each.  Each pass starts
with an empty cache.

https://bcodding.com/signfh_cpu_flame_graph/perf.svg

You'll want to look for fh_append_mac and fh_verify_mac.

Easier to find fh_append_mac by zooming to nfsd4_proc_compound:
https://bcodding.com/signfh_cpu_flame_graph/perf.svg?s=3Dfh_append_mac&x=3D=
65.2&y=3D757

Easier to find fh_verify_mac by zooming to nfsd4_putfh:
https://bcodding.com/signfh_cpu_flame_graph/perf.svg?s=3Dfh_verify_mac&x=3D=
537.9&y=3D741

This profile was filtered to only show events for the nfsd threads, and t=
he
two functions needed to be annotated to remove the compiler optimizations=
 in
order to show them in the profile.  This on a VM running in VMWare Fusion=
 on
an arm64 Macbook Pro.

Ben

