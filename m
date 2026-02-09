Return-Path: <linux-fsdevel+bounces-76724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIVkIgkjimnLHQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 19:10:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB86113675
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 19:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FBDF3025E56
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 18:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0976038A720;
	Mon,  9 Feb 2026 18:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="eQRJq4Dp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020129.outbound.protection.outlook.com [52.101.85.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3201B43ABC;
	Mon,  9 Feb 2026 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770660596; cv=fail; b=bBjFSifmODo7WPN19r7W3QzY0pU9AhTsLY1+eD6S6kG1FAgboNOtEiMBaHJjuLLbb658A6qcIXPGZCXPjcBh8aTi/Elqx/l4r63bpxqjD9FBC8agYa5mMs0llZqLoboNHh5ZzZYeKlM6grAT0Nkc1jWIu0AYURLOhVLrIJiY28U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770660596; c=relaxed/simple;
	bh=OvKqGjWT2QTBbprAs8yHvvjjbPcpmBlpkQvfui2h+8I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sVXBimCdhqN/1cooYwu/jKEllKxVkmMLQTYaQgnSwg3M5HxccX7XImT2vjaQ8C7ND7c1HwLF7V2pav1+Al1aHA6S5xigAxYjIW796n6tUzVFRh3EaBzqb+630Mlbq+MbiKtpffw3afIsEt1dH9MF2DH7zi9xGUoA+Lv6hgqVc4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=eQRJq4Dp; arc=fail smtp.client-ip=52.101.85.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odGlwKikfhDUI7GimaQrPOlOLMWqkg+Gt+38a5IR4F9l3CtkHZ0HOMocCh5A04i5Md4QjP38+4ZvjliEhuCUZwF5LSzp5ch7xznX8Oj99Vg9ZDygwO22TZTZ+tl6V6R0Iy7VcKfHgdGVJXJ+FxOj/qGVRAiU1NYyYnxJTzyFBKN1sebT+EV0zqAIs+77fG279bufD5DOaTEPMT7+P4Ku5c/ksx6XBe7jcWmjei5Bdp9fqlBZu1P/i2UINq50gJrkmMeaTf7vQ0BvFKX/E2fm1Zkz9UqXCsPefZCOTml6IWMHWOXreha+9yzENaceyyrjmcmNsxYsCL4kwsXZwUJ2Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWJU2mkCbVf85cqbaVmmKsnN9P+Gw/o0rH6oIE3dJ3A=;
 b=dYaXVfoMaQgcHIOsFWb9SnuxPDJGErLwNPcw9GmCR4tp1V1U8c+IlFRl+NbZHA7Rpi5NNChLDKzpj18Ul0jhBNmzp/VSPcdH3ST7xFoZiVp9/T0NmPfqLok75ugXBORoyk1Nvw61se48xmmQivjM/tL6kWCMwsmCPVlb2knQAh0UrD+ruOs0prppkj6HPt7isExKQygE2VaenGRuA/n1OyzCj4pu6/H/eiKeDrilTfs/O8NhVLmixEGrxJpmzQQuQswOfCNPjN6+52Uowv8aD9fBE4Ip3Ww6PAx53qqihPsKbYjRN1DrV9YCujwWjSBcXHGlZ/Q3U9nTc5xiu4vUFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWJU2mkCbVf85cqbaVmmKsnN9P+Gw/o0rH6oIE3dJ3A=;
 b=eQRJq4Dp0DaF2g6D+Cip/s+2TUf+iPxUZuJwCnv0Jmc3fxYHU11Cg4OHy2etHubugsrtDTXzzO43OToucLWGkPep2YusQvUNpG2mJAN+kGtd0cU1FXdMcGveh3aE7ZDWaKNNAY6wVdMIuO/WdCsW+AZ4v2fnobv6tZPescWTwhk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 CH0PR13MB5170.namprd13.prod.outlook.com (2603:10b6:610:eb::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.16; Mon, 9 Feb 2026 18:09:53 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9587.016; Mon, 9 Feb 2026
 18:09:52 +0000
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
Subject: [PATCH v5 0/3] kNFSD Signed Filehandles
Date: Mon,  9 Feb 2026 13:09:46 -0500
Message-ID: <cover.1770660136.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0018.prod.exchangelabs.com (2603:10b6:208:10c::31)
 To DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|CH0PR13MB5170:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ca36d6-df7f-4c95-0b46-08de68066c0f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GHfi/aEm1FNvKCZ23CV8oDh+OK96WBxP7zbYfgec+LxLUoQfX7VM9td4P8bl?=
 =?us-ascii?Q?E/WbHYBM4tTbVUalel1Q3l/oN2X72eALaM/bJApCMjYjT9I58xH2SOX0RdSK?=
 =?us-ascii?Q?JOgWFUnfuwdk8dIGcD2r5wPWZPGbtNumfnyDmeoWZ4N03qt7dF1RazCje+sw?=
 =?us-ascii?Q?ZjWnuiFaAOHERz+1e/xvm5bJAsxO8CULNYP4Iz7Ha0qHh2wgKVw/1AN1+YKU?=
 =?us-ascii?Q?LUOuG9C2TOHar8leNBBmUeRFzdlkVLz6XO2B1ON7xkWzkDtvxD6ugwTMgxXm?=
 =?us-ascii?Q?qEcvr5iFs6Q9IeDQsfySdzJ4G/l2oe30O0mMpj2Q2xW9cqGWD3PHz1LB6Gup?=
 =?us-ascii?Q?Y60qNtk+uKLj/l74W3zNmGXphrLIRRqQJCzxpLe7RWEN84rXThyFel2Q3QkK?=
 =?us-ascii?Q?DrElsu4pqPbnLEtwf0UmtUG2YzOC8EK4jQX5gFLNG4xPxzEL5OfX7Z2wIG6z?=
 =?us-ascii?Q?oMR+bXs8bNoNfXSjVnkBTgcy9phDrCM2ratPZtuC1chXkgEsBVs8Rq76XRo+?=
 =?us-ascii?Q?p6BBKQrQAKevR8okfqNZz7LsM6PbflNayf9+lY6UHTlJqxiLLOAO7FPQgde0?=
 =?us-ascii?Q?JYpGH3qjlkjhZ/h56HPJOLMccFB1JI3hnZE0KUsIdUK0ilInwC+S7v3h3qop?=
 =?us-ascii?Q?NdC4+i0B4r9edmmRtQIKrRhGEmgM6487SRsDiMCPCkvzxLMxM+/t8q4ufdEn?=
 =?us-ascii?Q?uZXRc4dmuINJliUXw5jEEibVZWdrHrrOp9Y0z2J2feLbBHSOEDFndftysgnI?=
 =?us-ascii?Q?lZ4LwMYDyz86kQ/3LdzrtYE/ullD7ULDEOyr2saGIV8nDfq40A2ahm5bk8wb?=
 =?us-ascii?Q?gIJtbzUuqzhGKN/2lTU725lsJ1VAVJlE/zqJZU+HK1JDJmcrJ3oOsO+5l+VO?=
 =?us-ascii?Q?WFAz24O/434NW482+i5c9wnWCO174yOI1N8MjsKaQ1woIbE8LmPtG9++6/N6?=
 =?us-ascii?Q?9SwAHBx2Emgz+oOxOd9oWHEjSHWaqfJYyU0mGH7u54eXfpZmj9NFCp5YFPuQ?=
 =?us-ascii?Q?5bIQh10eB6PnSx+jmfkC89ZAl9znRg348/XVtjPv6/S0q5ylNtbYUXG66c23?=
 =?us-ascii?Q?L9ZPYL4J3j61UdxD6+h5MBie2wL5T4gc3okB2Y52jckgx/UMVr8ECx1mnl3K?=
 =?us-ascii?Q?uFUmnhhQRqsIlYkarjd2ZmAjXeAViHbM3w07FwuTzaNwzuA5ANTH1uO1CrW7?=
 =?us-ascii?Q?Jk1gKm0yrzOfH0Qv98I4l00y9j0lg7aBNJ/e7ytBObccNO2k7J82iMT2fzgK?=
 =?us-ascii?Q?zfBTjT9+yFvNdSlM5pdwDpbKUx8VSPNnsSKnH203562FEMXQVao/qqy8Fwyy?=
 =?us-ascii?Q?gdoDGG57UnXzRGPYNVfsOuwBbk09VwNjLXwyZkGs0oMGHpWTew7IX2TdKANR?=
 =?us-ascii?Q?g9wLRm00w9EQyaVxuGtx92TtSNbdKzDLdFRs8ExTIEqJTvuMKJxUZ1h4cVzd?=
 =?us-ascii?Q?+aos2VjQr4CMI0VX56FHdaUBoTaO7unruHTGoQdVjkC6qH1IFJyeA8IbCRhQ?=
 =?us-ascii?Q?VryKf/ZcgV1XZyCDYxJCA/ktnVIFpfDcnypHNziiWqHsPt85fy37nG0cReB2?=
 =?us-ascii?Q?SFGjMKGfh1AS7RUpUm0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7PTK22+JG4TRkGfE25HWLrMum7uf5C6juB/lEAAOuS9N3nJuckMMWH+ezXPu?=
 =?us-ascii?Q?3s2xPeffQzjXBDLDp7oW67eaipBqSiHPbGhJ9YmSC3/paY2lsW6jc4HcDolA?=
 =?us-ascii?Q?tPPi0oDPPVtgPpUsOQU+qz0FwsCt7mQlFsjvdOQGh03Grxy+hEoNfCChSDwN?=
 =?us-ascii?Q?2mWfutPreDAlxlnqAXuUG/u5FuoR25S+XgEbfImgs79esxzTFGTN2ND1tHGB?=
 =?us-ascii?Q?rULX1IPAIIPRFqMJE5eSrh9D23fY5NIAGoZ54w88LQCHjS6xfj3EQClZdFUj?=
 =?us-ascii?Q?WGpHFNL61ULKJiFYNOINOPjS2UL4x5OUQY7O/+hPsxu0N3CeCi7pwsHL4JMJ?=
 =?us-ascii?Q?0MlNwR5BR7tWx8UQ+yP8zqZVr4A+iZ5wBgZWLzdyILofUnl9UMz/NyGu4Yei?=
 =?us-ascii?Q?VcsO5HYEizDxXs03AqEGCI4fZflq1Wq8j3IF3z20iKjo8bJjCBQmL6PgMy6B?=
 =?us-ascii?Q?Wu5swLWHfsmE0EXS1JChl+y3NEgHt4Z2h6SRar9+4vNuXn6fGQBG/zKmJgho?=
 =?us-ascii?Q?56TWT0KpMtkA/oKipTFp9GnVIajpUldEqj+nlwCi6dRXvYlt4a9ya7AgbYBo?=
 =?us-ascii?Q?GNaI47uaXLr3M16b9yaxfzEQcWRsTwI6rIRaNsOSzUVk1z90HfJtHpCBoyRZ?=
 =?us-ascii?Q?61A5g1GwvV3Rxw7ChiCON7loZvsvNY81VXBtIIBzhErLbUnK3ZbJlw87dd2f?=
 =?us-ascii?Q?OvN038T4K0e1gl1MEKrdYLeSzUOhxXDqMencNSVO/czef5by3S+5X6SVaBWf?=
 =?us-ascii?Q?FHHHgMOOlSxGkUAY+uow5Yxuc46xKhw9zsEaQ7ftqYV6R/Ip4L/7JBUs18h/?=
 =?us-ascii?Q?/g0aht6O/xGBXTqaXmFvpPEIUQK9sbY8CqDEoEdJtQL8hv8mFuFnSzLIawo1?=
 =?us-ascii?Q?QOJIx0+U3kUDoFkqiA2b7ct42APFf7Nfw9V+VJLPyxHagwS9QbiAEQc9n47k?=
 =?us-ascii?Q?ez8loxBGWBXqlZP4Y9qbMFCHWlRRKFAj6z7vGc+jTrTODrqZqXALG18xDphn?=
 =?us-ascii?Q?GN02/zDZpvvK6vT9VDaFI0gn9cdkWuFdNmQFGds/oPZgdajRk2m2VRV0+LOR?=
 =?us-ascii?Q?KlYjl4KGRbq/n9NlX/znXOYK8VJ93lOE/t1eTRlDgZgiQQfgU0Qshy2D51Ru?=
 =?us-ascii?Q?VszXDk/ikWUCKDmMRJ7PX0IjZs0Nb+QgQo2AaYHbkNCMuR8tlMJDMm44a951?=
 =?us-ascii?Q?DzcvtaiHUS8VzUNZALaEw3XnZsR5Lc3iGyCiu3fn+oUhIFUdGfB0djeZSRkF?=
 =?us-ascii?Q?YzAGnB5j8eyyUK6t7BFiUjxMyqlSMoILbQ5/6IrigixuH/2hJd2fIpnfiu3O?=
 =?us-ascii?Q?t7/QFh1J5pALdm6wzD5j8Z1xTfdObbihKk/FW8+rn5pE6KHcl/9bE8C6h8x0?=
 =?us-ascii?Q?/2zDUEu18wzj5QAzlEypuLO5bgVQqkT/S/BFxIssnLh2QHBXFzpZAQy65GQl?=
 =?us-ascii?Q?lgkuSUNnD7UD98UehZLNEc1AkI9nZunIljJ55g/ihYSq0/+LZ1geqNNc5VpQ?=
 =?us-ascii?Q?jdCPMkdG2xGlJKXBqGjMoYC2KczCc5EdAorcd+kahOPNsj+LE95KSIl4RZfy?=
 =?us-ascii?Q?CxrzGh0GC9Gfohe8eE/2x4h9Dwked9qzY30gms7p31ohzHu7ioXDuMtp2isr?=
 =?us-ascii?Q?rHlOlGLSxxworDP3XHS5LaJWpYB2o/Vcp31zQJZP+SrrPLUbI0+bLaVNj+QZ?=
 =?us-ascii?Q?B+5I6OJx5x7JvyFu32hagwoRnehM6u3se83Y2LJJltDTjFG6uMRaUvknyugM?=
 =?us-ascii?Q?cVtEOdCO4osO/VONkDzcaFMgNwpd6yI=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ca36d6-df7f-4c95-0b46-08de68066c0f
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 18:09:52.7028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5WGAluO0YTfzoNc/4YHKq6Sw9LgGjrvbRoSBy8lR4w5GQr+rC+c4q0NHioWdzhcDjQL9axWnHP32ROPoSd2nTjSaJhTTIYmkNOjTCXspPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5170
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76724-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hammerspace.com:mid,hammerspace.com:dkim]
X-Rspamd-Queue-Id: 4AB86113675
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

Benjamin Coddington (3):
  NFSD: Add a key for signing filehandles
  NFSD/export: Add sign_fh export option
  NFSD: Sign filehandles

 Documentation/filesystems/nfs/exporting.rst | 85 +++++++++++++++++++++
 Documentation/netlink/specs/nfsd.yaml       |  6 ++
 fs/nfsd/export.c                            |  5 +-
 fs/nfsd/netlink.c                           |  5 +-
 fs/nfsd/netns.h                             |  2 +
 fs/nfsd/nfsctl.c                            | 38 ++++++++-
 fs/nfsd/nfsfh.c                             | 70 ++++++++++++++++-
 fs/nfsd/trace.h                             | 26 +++++++
 include/uapi/linux/nfsd/export.h            |  4 +-
 include/uapi/linux/nfsd_netlink.h           |  1 +
 10 files changed, 231 insertions(+), 11 deletions(-)


base-commit: e3934bbd57c73b3835a77562ca47b5fbc6f34287
-- 
2.50.1


