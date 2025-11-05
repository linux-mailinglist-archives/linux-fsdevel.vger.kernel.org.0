Return-Path: <linux-fsdevel+bounces-67052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D50AC3394B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 02:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84AB13AD6AB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 01:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4130C243956;
	Wed,  5 Nov 2025 01:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gwuH5C7J";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="D5IUcWc+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF75E28DC4;
	Wed,  5 Nov 2025 01:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762304479; cv=fail; b=t+IHgZK1UZEm0L/tOMU3CsUfF219a2MIaMVhCcFn6yqMQ4+nZzm40bm7/+gRIiw93xYASiLWFf+4ru9sKjQ2X41Pso15v1mXVzwnOF/JSeCNCr8q7p0u3lmiEityY+pzc1TsIv4a1vdn+uRW4fJO+sg4Ft8ego0fIVoDeiMdC74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762304479; c=relaxed/simple;
	bh=on6Kkrpy9o56/C/NxCACRS8ANTRgmQws449gikLEV5M=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ti1JU9CdfAYrujf0TZ6tacWmw3NYA26nnZSOcAHbVw3FhEc3AqkeVkw+/Puhbc3Q9Mdu4YZLzq9bep7h2wC/aZpcLRdNxPOTfwy9C/dhDB3Dc4M4wTtbIipl8LSP8IIqcOZG1tIkj25p/I+G9z5WuCmpnW+URa0BtbDFT0pxKP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gwuH5C7J; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=D5IUcWc+; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762304477; x=1793840477;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=on6Kkrpy9o56/C/NxCACRS8ANTRgmQws449gikLEV5M=;
  b=gwuH5C7Jm8wA1AtlG4riNt8A5OglVKGehi2ji3c1xh8DBahVLAawFTDJ
   g6MD/xNbTxGMQ/Jx5GMEBxOg+tdFZuYSpgaKCYx+R1odgmthWKr7lpd9z
   /je8hwbDHeUncM52wLp4R+xtg9a8ZSFlPGkrocIF9E1MilJNnESsdxB0q
   RHmSfurdisjmwtJFC5quFAXBnwcAVRNJQl1u14uQ/T43xNHEgRhgmbxHb
   AoFmxHDOs2YSwLuBZc1rVj0iNVgco0k/3eryTlTICpKPV40T9wf/A4oxK
   d1Ue945XrEXIgtgoyPXCUhfMad0CME8mJzfyRU3eSK2L3lrXQEqf3ENvG
   w==;
X-CSE-ConnectionGUID: TpbGFfuVR/GrX5sXY0B/mg==
X-CSE-MsgGUID: PiFwzTXRQ1Kf0BG5ojuFIQ==
X-IronPort-AV: E=Sophos;i="6.19,280,1754928000"; 
   d="scan'208";a="135449084"
Received: from mail-westus2azon11012059.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.59])
  by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2025 09:01:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLsq3PtpvvdtOA5+EZn1tJAtKdCZ+ROh6CeANXo1jIFiwtmcAJz3ymDOI7Mredj9DqJBcacWLiGorHsOHBn7lVm3mrirhELhYTRztphk6Aa+4Ua9I/oOXvIoBbtlVQZliglJPOqLbPjL8SgQIJk8suEqh4OKUiYKsQviwXAG5lhCA7Q/Keb7+7rb37QR7jDhRmayXAjyFefPomi+kUQ5mvyy2UUonOCOPHULvEKo8qM4qpGVqDeEDnt0KZPgGv/B0CVhwgkZsCHTi2rOu3+Imyw4lPfn23RxDNzyzODgWEV+Xr3kIBZVr6EACuL6e/Fi3UWZXXkRN/wHrqIoBgF6MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31QzlcaXsSADKqwxpDyKEO0XZmBLy8yov0hqWfxwjds=;
 b=KZLDSWY9QrC53sAjVrlC4Mm/Y6UF49VM2GJZls2Q1rm7xVcUlKvaLCV3nPh+lru+C0lxAhH7bQawlzcxTUn7NZcrPYDrsmzZzim5eOLL+7VXC8iEm8ZSolv6XnWGFK4opkgaNq5fJV8HDSuKUNzXdwP22SQMneVeaWBj/Irg+bqmmipXQz1cDhD8OxTh0RauWtWkUcZqBDDhQoIkFSG4rGCGmYEFpb7NEhZhvNgGfGnQ0uA2/hfQkaXS+Y+vb0GThqbMHKG6XA66r+0pNt3GQThfvnQ4Gi5pFdLHKWbrLp5iPaojbVNBGL4t1PURIPvEXojsS/1IksIisXzECEbWjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31QzlcaXsSADKqwxpDyKEO0XZmBLy8yov0hqWfxwjds=;
 b=D5IUcWc+/mXn9Gs+2UgKmfq4/mwLo62yEauoSZ6GUo32EEZwfTYAhgW9ax2xvdmIJ3UoB7NSQ5xZglzrF4Ldwl//7QNeedgByvlq4HfLUvqZTXIyxfeS9dWavCv/9Gw904UZi4VkSclarqCoj/jssQaqe40y2EMflX3jLlsCZ2Y=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SJ0PR04MB7598.namprd04.prod.outlook.com (2603:10b6:a03:32d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 01:01:12 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 01:01:11 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Nilay
 Shroff <nilay@linux.ibm.com>
Subject: [bug report] fstests generic/085 btrfs hang with use-after-free at
 bdev_super_lock
Thread-Topic: [bug report] fstests generic/085 btrfs hang with use-after-free
 at bdev_super_lock
Thread-Index: AQHcTe+tRrxDzMFh+keBXEzCSortcA==
Date: Wed, 5 Nov 2025 01:01:11 +0000
Message-ID: <asuxk7u6tlrjb5ruugshjvydiixo6vcvayu6yzfeu5fblkxdxh@3whdau6mprqv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SJ0PR04MB7598:EE_
x-ms-office365-filtering-correlation-id: 82474cfa-32f6-4c9b-0f5a-08de1c06cfbb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5zU1XJC+CN1cR99jORDvDUr1z7kKwnnJiT5xcYUu4XTidiD87d+mpPUEMRRu?=
 =?us-ascii?Q?24bqG5FdZTKEOzxvOUEJhhDnT9hoWB4N3cSg6HR1L/Maz1q0yrMlmw8V8fp9?=
 =?us-ascii?Q?ih3FGgp6r4LZhTKWUBp0mgY97urcUomsIkV+trZX9BPHE+YR8xO4AMT4iHie?=
 =?us-ascii?Q?4SA4R+MLMg18kbhn59AkQDtZT2Njwxcs2EBrTJEBCM0Ho1QGGefOhpf3xYB4?=
 =?us-ascii?Q?t55idA9orMChhlhHv10v5698WCb13+hImH1u9XTrK0zzCZaOlo2L/pKLf+XP?=
 =?us-ascii?Q?d8wtgtBPDXiaBMHVgYXiM5DbCchJxDea6EC24MoyoKrgkORSxFJZO5TDvdNn?=
 =?us-ascii?Q?3EJslOoUYRyeuw71Cuv5SbkZ8sai2LLrrUjnl8P3J7S9KXhzcPvIHcJFyjQc?=
 =?us-ascii?Q?Wl79RDf6TBEyaW8oikkhBzITMKhQ2VTB8c+wrfp672T8SDPWRI6+xkGsZo82?=
 =?us-ascii?Q?yXtp710iyycnoP0Q2w7rFrB4NLO+CDI6YAhcDfsJinenlbdQtkxQesGhYbXT?=
 =?us-ascii?Q?j3xZQh0/zE9/SLeTjdQubj0/EkvzYI3/dV0wraOKSYIlmXUcyL2JymEEKN7T?=
 =?us-ascii?Q?bSl8ruavWW+pAl00Uwt/TfI3kj2UPhE0FxXFFgko4u46N4qJVASbRcPdxoPF?=
 =?us-ascii?Q?P3CuIZBLioZo+XwovqTXjoyN+rmLhTzSy+9tkeeNLerYt5glm3aMtV7iMvA4?=
 =?us-ascii?Q?62P5LFuXYl2QDV8BkYP0wBkenJWEqij1qrZK9uRNm0FxTeiavbPs6tb43dco?=
 =?us-ascii?Q?LG+a4sOpBcIIxxRGtgYbVJ3KG2ZMltMcxpt1i0ot8Qv0cZmq/KO1YFHDN4ae?=
 =?us-ascii?Q?1BMv4cF+vAAFa9F8h9u6mxhmpHwWCq0Ux/EQnkRF0iEXcDV2n9fDpxaNTol/?=
 =?us-ascii?Q?1BwdNNGqkK+Nqm2YrAwqkmgFzEBxjW12ovxcPTWi8X31E0BHRHvNWcZLjGAw?=
 =?us-ascii?Q?YxuiYBJFkniAhCmoMq6oNT3rdGtA/wELQDEak0vVD0sJu58Al/e9PRm1qsbU?=
 =?us-ascii?Q?tGGYkq5Dl3UbRRz4f6xh6PIGwequPAhD7thRJqKRqLcO9ooYKWAzRU6kQvlC?=
 =?us-ascii?Q?LypvcFVHdF70BimUkWDx11vGQ76zr+meev6ef+BFlgsikVddMQJv8/Z7jZIm?=
 =?us-ascii?Q?BTmAXG9hUy/851nDacHG6a6qDi9ehzl2ae+jCsekolm/hdKsOugUhJ8lSqvk?=
 =?us-ascii?Q?XonjDFwH7qSF/XJDDr27xZ6teraq86SxfwWT6DhSfH8ZFdrh+Z13Ml+Sb4Eq?=
 =?us-ascii?Q?uT7re/2trfjrHi0JQGbhMen2yBZdaKEQajE7cn7LFP/ytJ8kzdRofuWxyqAn?=
 =?us-ascii?Q?PwUhAd4CCWSvbP+QXUIHtNTUKKcv+YBPgiB8+8F1xWCFoOfz24knQsJplvSf?=
 =?us-ascii?Q?lm3n3PoGuwMDQLNG+fhBrXu7zukGhVPD7wUqO/j82ofZC7Q5bSoIKH0UETlg?=
 =?us-ascii?Q?5WTeqzboc5UwRRcyu1bSEFGGqS7evQxz9SJ2IwOErwtEKEIrjHb2xoZwltK7?=
 =?us-ascii?Q?C3RjA6Al3ZL7tyNUEwp5PGw7LEhIs5X7MIAO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?O/gcAeaLEAsToygXL+Txxih1yIJr63Vvdjd3FhbGVV8fzt5nHN5NANoZn66X?=
 =?us-ascii?Q?QF3RbhSbHwXACEPyGVoqnIIHePBZYk6w9VToYII/f6tNLdY5aCiVV2v0btAd?=
 =?us-ascii?Q?xG6+Dbec2CF7F2ejy4f80gjiAudWQhXXjeOb0OhEwM8ll1WSN/929ncfLCMa?=
 =?us-ascii?Q?k+JgVlNWxLq8EknZwmJUFpoNhFcMWoD9MfNKiNbTBQb0Y1GSe2TSsCjWK3Hl?=
 =?us-ascii?Q?22G9TuVzKv4+0pV9wyevwdu+b1sp6EzxClD43gVt/SojrvcAxlZQ9NYgdf2R?=
 =?us-ascii?Q?lO9UMwwzdEOYxrWDcHAbqynw1mLFAuR0ahqxqdx7uhO3sHOvNDFCkyszG/0D?=
 =?us-ascii?Q?1GOvPWmItveSA7G7UVrmVW1FK0YzYVf8kEuzKuhXQZNZ/Bx66Jq+M+2gd0OZ?=
 =?us-ascii?Q?oB4NHwn1MIFPg2nPnLi/7+9RdnMRk0nfYOI5SiReJVodGzFmEpOI+PoYAJ0M?=
 =?us-ascii?Q?ZCWJYvQ+BAyR8SYyGBOggJpX8BN5PpNEWS2kjDMCpg/8/AlbJ1o76MC5EYNo?=
 =?us-ascii?Q?NVNBRujGMjsO7GL3DMgqFUtJVnXcGBJKHn9R1ndDapW/wed2QanZILI57J9c?=
 =?us-ascii?Q?+8KZ/vX/M9Vqv3n+u0BhqDtHZWZIBWkABhfTWyJd313GIX0c8OXw26ztREld?=
 =?us-ascii?Q?4bRPKzk17+2NfptHMblf6EjMIXlVaF8aPVOfJDYbXURjncXKFBOneOr9rMLV?=
 =?us-ascii?Q?w51UD8cxb/5j/OZa2lpd8vZifx//mlgtFrVwUTbnrrNGcguK23btvhvu8rUF?=
 =?us-ascii?Q?oUJKvrq1a0QuqMfWtOI6kJ6WO89C84Js84GFKtEUhA4orwgMh1fEj084esLd?=
 =?us-ascii?Q?FgE6dWpNii2COfTps2q34AauMBTBRq55Dy10bfAOZOl06V3ug87Q+GRp/2xH?=
 =?us-ascii?Q?QqGId206dQcy+DYzRjue7FoKBTcX1+c8KPmUpRHDK7fMfoDQ/uupu5VB8t23?=
 =?us-ascii?Q?bn0CzWAwaNXAhLqvwteRfQwzjd54ct547/KH2HAzo8x70UCcQD1Lvrv72KdL?=
 =?us-ascii?Q?txmZRTIaFA3yzrFHCFcbtUcx/Qfs67Bqeq1gyuntihrygWkcER9PZXOm5MBk?=
 =?us-ascii?Q?asi7COM1cS4IF5xQIUq+w++/dsppbQOGShox5A+5TA9ORZYFdcVyDGPD+EEM?=
 =?us-ascii?Q?agt4HzImXrrpraeeMjrmY97Si8h9uRWwgcKIUMs9j+DP3ZhaFV1pYa0rmoQs?=
 =?us-ascii?Q?Aks7CqEZkCrIJctgnEHtoPYzr8BlwgnzoLAuBw8meUzfEq5MAUKUgEEsptTY?=
 =?us-ascii?Q?Ib2EdfzqsNJ/Sk338dF5bRmJvEZ/fqfm9IKLeQKt6wWViQChaeGcDPUz+cOO?=
 =?us-ascii?Q?7uzX++7p3u45hUOhUdt1aia8Tsr9B9/OLDJJun0QbsWDgsGMrl0ociB4OeEC?=
 =?us-ascii?Q?zBNR8mgpQ8lggEYSmcjB2gFaLX1JxAQcoS2hySr36RAvwFhnW/ejvbR86SRJ?=
 =?us-ascii?Q?RN7OH6BT4da+P0Be0t2NMq5MPbvq35O5pzC+0GLvLzlLX7ycLk6/DZMga5Cy?=
 =?us-ascii?Q?s3S106JUbqXO9k4GsuxBGhinroAo3D7Rh55M2DB4AzYFCksqFWGMIq8hCB++?=
 =?us-ascii?Q?Bdm7lkVzzE6uLPzc66La5QMyo8/j88CBxTm3frFIf9LYjMcifkZK0P5CF6iT?=
 =?us-ascii?Q?5QHk7bbnygJlM0nXbjNRanI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6DDE37EA6F0DEE42B6E0AC8928AD0D50@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XtBbopKbk4ZQNGOrIhjsFpO3XqjxPYERgs4oju0yMA25NP/4LfNpmRVbl+dK/p7Ov2p87R7AvsCIN3sVC0+zybF69ZJB7+UPGbYvrFvW/gagtQXmXyWu7CU2iYtJp3alhpITyxdCGJ34fADg3rYNFhAyWNc11pIwGcefUFLObyRnMt/e4YwR+MZkLwd6DVAttWcAiXFpFTRl6F0wy9BH4W199NFTn7jnN//l8fUlpGycPRgG7j1tZ+d0JQYRLJY19PR6BgAiJ4CUAa1jdDN+1mO/Rj8LlflU9Zk6vdXNycrIBX64DPgqsRG8bZd2SBu3CXEjHvBIEJKX9Zaz7pbqRMMERAShasHdZvQp66R7GNyhF6+ja05R8dSUeked9WatkiWdaGHv+cMxv5TOpqUgVr6KGXWLtYirFw+dcDAosxcYI0HyIdlxO3R5+DKkZ+7CT84jQIE9yUb3atnN/ndXXJzqkrQSiHbyp80SQnTf2PMpWS0Sq2FtdnqtW3H4hAJRPTDo8lhOBLX3H6RfaJuSpVgTVJrslsRAIXBLE0qgIclDNhjh4hYX1wO/6ZQvViHYcxuCxO0qvIcdiZEOn5USZF4Abw7l83nJalOR7z/kVVKC7nZ1enD728s+QinsRoU1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82474cfa-32f6-4c9b-0f5a-08de1c06cfbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 01:01:11.2850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sge4i12S1rLOWvy7JpWqeEEQbeuMkWVDEZ1UazB+WPVF4R2iFVMDiX3HgyudamEkgtX+N9t/0k5IgY/uf//eMFLDXGAcweLjbpHxD59Yq3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7598

When I run fstests for btrfs on regular null_blk devices, I observe KASAN
slab-use-after-free in bdev_super_lock() followed by kernel hang. I observe=
d it
for the kernel v6.17-rc4 for the first time. And I still observe it for the
latest kernel v6.18-rc4.

The hang is recreated when I prepare eight of 5Gib size null_blk devices, a=
ssign
one for TEST_DEV, and assign the other seven for SCRATCH_DEV_POOl. The hang
happens at generic/085. It is sporadic. When I repeat the test case g085 on=
ly,
the hang is not recreated. But when I repeat the whole fstests a few times,=
 the
hang is recreated in stable manner. It takes several hours to recreate the =
hang.

I spent some weeks to bisect, and found the trigger commit is this:

  370ac285f23a ("block: avoid cpu_hotplug_lock depedency on freeze_lock")

The commit was included in the kernel tag v6.17-rc3. When I reverted the co=
mmit
from v6.17-rc3, the hang disappeared (I repeated the whole fstests 5 times =
on
two test nodes, and did not observe the hang). I'm not sure if the commit
created the problem cause or revealed the hidden problem.

Any actions or advice for fix will be appreciated. If test runs in my
environment helps, please let me know.

[1]

run fstests generic/085 at 2025-11-04 21:23:17
BTRFS: device fsid 1b24d69c-9ed9-4d19-844e-1ae84715e4a3 devid 1 transid 519=
 /dev/nullb0 (250:0) scanned by mount (859368)
BTRFS info (device nullb0): first mount of filesystem 1b24d69c-9ed9-4d19-84=
4e-1ae84715e4a3
BTRFS info (device nullb0): using crc32c (crc32c-lib) checksum algorithm
BTRFS info (device nullb0): enabling ssd optimizations
BTRFS info (device nullb0): enabling free space tree
BTRFS: device fsid 48ad7e3a-aa92-4748-a2be-0098bbc1a4f8 devid 1 transid 8 /=
dev/mapper/085-test (252:0) scanned by mount (859456)
BTRFS info (device dm-0): first mount of filesystem 48ad7e3a-aa92-4748-a2be=
-0098bbc1a4f8
BTRFS info (device dm-0): using crc32c (crc32c-lib) checksum algorithm
BTRFS info (device dm-0): checking UUID tree
BTRFS info (device dm-0): enabling ssd optimizations
BTRFS info (device dm-0): enabling free space tree
BTRFS info (device dm-0): last unmount of filesystem 48ad7e3a-aa92-4748-a2b=
e-0098bbc1a4f8
BTRFS: device fsid 48ad7e3a-aa92-4748-a2be-0098bbc1a4f8 devid 1 transid 9 /=
dev/mapper/085-test (252:0) scanned by mount (859487)
BTRFS info (device dm-0): first mount of filesystem 48ad7e3a-aa92-4748-a2be=
-0098bbc1a4f8
BTRFS info (device dm-0): using crc32c (crc32c-lib) checksum algorithm
BTRFS info (device dm-0): enabling ssd optimizations
BTRFS info (device dm-0): enabling free space tree
BTRFS info (device dm-0): last unmount of filesystem 48ad7e3a-aa92-4748-a2b=
e-0098bbc1a4f8
BTRFS: device fsid 48ad7e3a-aa92-4748-a2be-0098bbc1a4f8 devid 1 transid 9 /=
dev/mapper/085-test (252:0) scanned by mount (859516)
BTRFS info (device dm-0): first mount of filesystem 48ad7e3a-aa92-4748-a2be=
-0098bbc1a4f8
BTRFS info (device dm-0): using crc32c (crc32c-lib) checksum algorithm
BTRFS info (device dm-0): enabling ssd optimizations
BTRFS info (device dm-0): enabling free space tree
BTRFS info (device dm-0): last unmount of filesystem 48ad7e3a-aa92-4748-a2b=
e-0098bbc1a4f8
BTRFS info (device dm-0): first mount of filesystem 48ad7e3a-aa92-4748-a2be=
-0098bbc1a4f8
BTRFS info (device dm-0): using crc32c (crc32c-lib) checksum algorithm
BTRFS info (device dm-0): enabling ssd optimizations
BTRFS info (device dm-0): enabling free space tree
BTRFS info (device dm-0): last unmount of filesystem 48ad7e3a-aa92-4748-a2b=
e-0098bbc1a4f8
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in bdev_super_lock+0x2c7/0x320
Read of size 4 at addr ffff888395682108 by task dmsetup/859561

CPU: 7 UID: 0 PID: 859561 Comm: dmsetup Not tainted 6.18.0-rc4-kts-btrfs #6=
 PREEMPT(lazy)=20
Hardware name: Supermicro X10SLL-F/X10SLL-F, BIOS 3.0 04/24/2015
Call Trace:
 <TASK>
 ? bdev_super_lock+0x2c7/0x320
 dump_stack_lvl+0x6e/0xa0
 print_address_description.constprop.0+0x88/0x320
 ? bdev_super_lock+0x2c7/0x320
 print_report+0xfc/0x1ff
 ? __virt_addr_valid+0x25a/0x4e0
 ? bdev_super_lock+0x2c7/0x320
 kasan_report+0xe1/0x1a0
 ? bdev_super_lock+0x2c7/0x320
 bdev_super_lock+0x2c7/0x320
 get_bdev_super+0x11/0xa0
 fs_bdev_freeze+0x54/0x180
 bdev_freeze+0xbc/0x1f0
 __dm_suspend+0x115/0x490
 ? lock_is_held_type+0x9a/0x110
 dm_suspend+0x16d/0x230
 dev_suspend+0x128/0x170
 ctl_ioctl+0x397/0x760
 ? __pfx_ctl_ioctl+0x10/0x10
 ? __pfx_handle_pte_fault+0x10/0x10
 dm_ctl_ioctl+0xe/0x20
 __x64_sys_ioctl+0x13c/0x1c0
 do_syscall_64+0x94/0x7f0
 ? __lock_acquire+0x55d/0xbf0
 ? __pfx_css_rstat_updated+0x10/0x10
 ? lock_acquire.part.0+0xb8/0x230
 ? handle_mm_fault+0x485/0xa30
 ? find_held_lock+0x2b/0x80
 ? __lock_release.isra.0+0x59/0x170
 ? lock_release.part.0+0x1c/0x50
 ? find_held_lock+0x2b/0x80
 ? __lock_release.isra.0+0x59/0x170
 ? do_user_addr_fault+0x4cb/0xa40
 ? trace_hardirqs_on_prepare+0x101/0x150
 ? lockdep_hardirqs_on_prepare.part.0+0x9b/0x150
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f3dea2d20ed
Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 =
48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 f=
f ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
RSP: 002b:00007ffd151d6960 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f3dea3d6780 RCX: 00007f3dea2d20ed
RDX: 000055d6f1c61b10 RSI: 00000000c138fd06 RDI: 0000000000000003
RBP: 00007ffd151d69b0 R08: 00007f3dea422c38 R09: 00007ffd151d6810
R10: 00007f3dea41adec R11: 0000000000000246 R12: 000055d6f1c61bc0
R13: 0000000000000080 R14: 00007f3dea41adec R15: 00007f3dea41adec
 </TASK>

Allocated by task 859516:
 kasan_save_stack+0x30/0x50
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0x9a/0xb0
 alloc_super+0x9a/0xb40
 sget_fc+0xe8/0xb40
 btrfs_get_tree_super+0x45a/0xc70 [btrfs]
 btrfs_get_tree_subvol+0x238/0x640 [btrfs]
 vfs_get_tree+0x8b/0x2f0
 vfs_cmd_create+0xbd/0x280
 __do_sys_fsconfig+0x659/0xa40
 do_syscall_64+0x94/0x7f0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Freed by task 852689:
 kasan_save_stack+0x30/0x50
 kasan_save_track+0x14/0x30
 __kasan_save_free_info+0x3b/0x70
 __kasan_slab_free+0x6b/0x90
 kfree+0x14a/0x650
 process_one_work+0x86b/0x14c0
 worker_thread+0x5f2/0xfd0
 kthread+0x3a4/0x760
 ret_from_fork+0x2d6/0x3e0
 ret_from_fork_asm+0x1a/0x30

Last potentially related work creation:
 kasan_save_stack+0x30/0x50
 kasan_record_aux_stack+0xb0/0xc0
 __queue_work+0x8c2/0x1250
 queue_work_on+0xc1/0xd0
 rcu_do_batch+0x34a/0x1900
 rcu_core+0x62f/0x9f0
 handle_softirqs+0x1de/0x7e0
 __irq_exit_rcu+0x181/0x1d0
 irq_exit_rcu+0xe/0x20
 sysvec_apic_timer_interrupt+0x71/0x90
 asm_sysvec_apic_timer_interrupt+0x1a/0x20

Second to last potentially related work creation:
 kasan_save_stack+0x30/0x50
 kasan_record_aux_stack+0xb0/0xc0
 __call_rcu_common.constprop.0+0xc4/0x840
 deactivate_locked_super+0x12a/0x160
 fs_bdev_thaw+0xc2/0x150
 bdev_thaw+0x10a/0x1d0
 unlock_fs+0xa2/0xf0
 __dm_resume+0x92/0xf0
 dm_resume+0x159/0x1f0
 do_resume+0x421/0x5f0
 ctl_ioctl+0x397/0x760
 dm_ctl_ioctl+0xe/0x20
 __x64_sys_ioctl+0x13c/0x1c0
 do_syscall_64+0x94/0x7f0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

The buggy address belongs to the object at ffff888395682000
 which belongs to the cache kmalloc-rnd-12-4k of size 4096
The buggy address is located 264 bytes inside of
 freed 4096-byte region [ffff888395682000, ffff888395683000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x395680
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
ksm flags: 0x17ffffc0000040(head|node=3D0|zone=3D2|lastcpupid=3D0x1fffff)
page_type: f5(slab)
raw: 0017ffffc0000040 ffff8881000597c0 ffffea00053e8800 dead000000000003
raw: 0000000000000000 0000000080040004 00000000f5000000 0000000000000000
head: 0017ffffc0000040 ffff8881000597c0 ffffea00053e8800 dead000000000003
head: 0000000000000000 0000000080040004 00000000f5000000 0000000000000000
head: 0017ffffc0000003 ffffea000e55a001 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888395682000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888395682080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888395682100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff888395682180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888395682200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Disabling lock debugging due to kernel taint
Oops: general protection fault, probably for non-canonical address 0xe092bc=
00e001a05a: 0000 [#1] SMP KASAN PTI
KASAN: maybe wild-memory-access in range [0x04960007000d02d0-0x04960007000d=
02d7]
CPU: 3 UID: 0 PID: 859561 Comm: dmsetup Tainted: G    B               6.18.=
0-rc4-kts-btrfs #6 PREEMPT(lazy)=20
Tainted: [B]=3DBAD_PAGE
Hardware name: Supermicro X10SLL-F/X10SLL-F, BIOS 3.0 04/24/2015
RIP: 0010:__list_del_entry_valid_or_report+0x91/0x280
Code: de 48 39 c1 74 6e 48 b8 22 01 00 00 00 00 ad de 48 39 c2 0f 84 83 00 =
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 d7 48 c1 ef 03 <80> 3c 07 00 0f 8=
5 84 01 00 00 48 39 32 0f 85 87 00 00 00 48 ba 00
RSP: 0018:ffff88838ee77900 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff888395682000 RCX: ffff88827f8e5b00
RDX: 04960007000d02d1 RSI: ffff888395682000 RDI: 0092c000e001a05a
RBP: 0000000000000000 R08: ffffffff8c75dc08 R09: ffffed1071dcef1c
R10: 0000000000000003 R11: ffffffff90a75358 R12: ffff888395682108
R13: 0000000000000001 R14: ffff888115996000 R15: 0000000000000001
FS:  00007f3de9f91840(0000) GS:ffff88876b558000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f068a2d2c58 CR3: 000000029b4a8001 CR4: 00000000001726f0
Call Trace:
 <TASK>
 __put_super.part.0+0x12/0x240
 bdev_super_lock+0x275/0x320
 get_bdev_super+0x11/0xa0
 fs_bdev_freeze+0x54/0x180
 bdev_freeze+0xbc/0x1f0
 __dm_suspend+0x115/0x490
 ? lock_is_held_type+0x9a/0x110
 dm_suspend+0x16d/0x230
 dev_suspend+0x128/0x170
 ctl_ioctl+0x397/0x760
 ? __pfx_ctl_ioctl+0x10/0x10
 ? __pfx_handle_pte_fault+0x10/0x10
 dm_ctl_ioctl+0xe/0x20
 __x64_sys_ioctl+0x13c/0x1c0
 do_syscall_64+0x94/0x7f0
 ? __lock_acquire+0x55d/0xbf0
 ? __pfx_css_rstat_updated+0x10/0x10
 ? lock_acquire.part.0+0xb8/0x230
 ? handle_mm_fault+0x485/0xa30
 ? find_held_lock+0x2b/0x80
 ? __lock_release.isra.0+0x59/0x170
 ? lock_release.part.0+0x1c/0x50
 ? find_held_lock+0x2b/0x80
 ? __lock_release.isra.0+0x59/0x170
 ? do_user_addr_fault+0x4cb/0xa40
 ? trace_hardirqs_on_prepare+0x101/0x150
 ? lockdep_hardirqs_on_prepare.part.0+0x9b/0x150
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f3dea2d20ed
Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 =
48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 f=
f ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
RSP: 002b:00007ffd151d6960 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f3dea3d6780 RCX: 00007f3dea2d20ed
RDX: 000055d6f1c61b10 RSI: 00000000c138fd06 RDI: 0000000000000003
RBP: 00007ffd151d69b0 R08: 00007f3dea422c38 R09: 00007ffd151d6810
R10: 00007f3dea41adec R11: 0000000000000246 R12: 000055d6f1c61bc0
R13: 0000000000000080 R14: 00007f3dea41adec R15: 00007f3dea41adec
 </TASK>
Modules linked in: dm_flakey null_blk target_core_user target_core_mod rfki=
ll nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4=
 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 =
nf_tables qrtr sunrpc binfmt_misc intel_rapl_msr intel_rapl_common x86_pkg_=
temp_thermal intel_powerclamp coretemp kvm_intel jc42 iTCO_wdt kvm intel_pm=
c_bxt at24 iTCO_vendor_support irqbypass rapl intel_cstate btrfs intel_unco=
re i2c_i801 pcspkr i2c_smbus intel_pch_thermal igb ses xor enclosure dca lp=
c_ich raid6_pq e1000e joydev video ie31200_edac wmi loop dm_multipath nfnet=
link zram lz4hc_compress lz4_compress zstd_compress ast drm_client_lib i2c_=
algo_bit drm_shmem_helper drm_kms_helper drm polyval_clmulni ghash_clmulni_=
intel mpi3mr scsi_transport_sas scsi_dh_rdac scsi_dh_emc scsi_dh_alua fuse
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x91/0x280
Code: de 48 39 c1 74 6e 48 b8 22 01 00 00 00 00 ad de 48 39 c2 0f 84 83 00 =
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 d7 48 c1 ef 03 <80> 3c 07 00 0f 8=
5 84 01 00 00 48 39 32 0f 85 87 00 00 00 48 ba 00
RSP: 0018:ffff88838ee77900 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff888395682000 RCX: ffff88827f8e5b00
RDX: 04960007000d02d1 RSI: ffff888395682000 RDI: 0092c000e001a05a
RBP: 0000000000000000 R08: ffffffff8c75dc08 R09: ffffed1071dcef1c
R10: 0000000000000003 R11: ffffffff90a75358 R12: ffff888395682108
R13: 0000000000000001 R14: ffff888115996000 R15: 0000000000000001
FS:  00007f3de9f91840(0000) GS:ffff88876b558000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f068a2d2c58 CR3: 000000029b4a8001 CR4: 00000000001726f0
note: dmsetup[859561] exited with preempt_count 1
watchdog: BUG: soft lockup - CPU#4 stuck for 22s! [umount:859559]
CPU#4 Utilization every 4000ms during lockup:
	#1: 100% system,	  0% softirq,	  1% hardirq,	  0% idle
	#2: 100% system,	  0% softirq,	  1% hardirq,	  0% idle
	#3: 100% system,	  0% softirq,	  1% hardirq,	  0% idle
	#4: 100% system,	  0% softirq,	  1% hardirq,	  0% idle
	#5: 100% system,	  0% softirq,	  1% hardirq,	  0% idle
Modules linked in: dm_flakey null_blk target_core_user target_core_mod rfki=
ll nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4=
 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 =
nf_tables qrtr sunrpc binfmt_misc intel_rapl_msr intel_rapl_common x86_pkg_=
temp_thermal intel_powerclamp coretemp kvm_intel jc42 iTCO_wdt kvm intel_pm=
c_bxt at24 iTCO_vendor_support irqbypass rapl intel_cstate btrfs intel_unco=
re i2c_i801 pcspkr i2c_smbus intel_pch_thermal igb ses xor enclosure dca lp=
c_ich raid6_pq e1000e joydev video ie31200_edac wmi loop dm_multipath nfnet=
link zram lz4hc_compress lz4_compress zstd_compress ast drm_client_lib i2c_=
algo_bit drm_shmem_helper drm_kms_helper drm polyval_clmulni ghash_clmulni_=
intel mpi3mr scsi_transport_sas scsi_dh_rdac scsi_dh_emc scsi_dh_alua fuse
irq event stamp: 4676
hardirqs last  enabled at (4675): [<ffffffff8f3bcd44>] _raw_spin_unlock_irq=
restore+0x44/0x60
hardirqs last disabled at (4676): [<ffffffff8f39cabb>] __schedule+0xd1b/0x1=
ab0
softirqs last  enabled at (4672): [<ffffffff8ce75d91>] bdi_unregister+0x161=
/0x5b0
softirqs last disabled at (4670): [<ffffffff8ce75cc0>] bdi_unregister+0x90/=
0x5b0
CPU: 4 UID: 0 PID: 859559 Comm: umount Tainted: G    B D             6.18.0=
-rc4-kts-btrfs #6 PREEMPT(lazy)=20
Tainted: [B]=3DBAD_PAGE, [D]=3DDIE
Hardware name: Supermicro X10SLL-F/X10SLL-F, BIOS 3.0 04/24/2015
RIP: 0010:native_queued_spin_lock_slowpath+0x398/0xbe0
Code: 3d 0f b6 03 84 c0 74 36 48 b8 00 00 00 00 00 fc ff df 49 89 dc 49 89 =
dd 49 c1 ec 03 41 83 e5 07 49 01 c4 f3 90 41 0f b6 04 24 <44> 38 e8 7f 08 8=
4 c0 0f 85 9b 06 00 00 0f b6 03 84 c0 75 e5 48 b8
RSP: 0018:ffff888461417b00 EFLAGS: 00000202
RAX: 0000000000000000 RBX: ffffffff90a75340 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffff90a75340
RBP: 1ffff1108c282f62 R08: ffffffff8f3bd7a3 R09: fffffbfff214ea68
R10: fffffbfff214ea69 R11: ffffffff90a75358 R12: fffffbfff214ea68
R13: 0000000000000000 R14: ffffed109bb8c84f R15: 0000000000000000
FS:  00007fe027c4b380(0000) GS:ffff88876b5d8000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd3d77b3d90 CR3: 00000004c5318006 CR4: 00000000001726f0
Call Trace:
 <TASK>
 ? __pfx_native_queued_spin_lock_slowpath+0x10/0x10
 ? trace_hardirqs_on+0x18/0x150
 do_raw_spin_lock+0x1d9/0x270
 ? kfree+0x14a/0x650
 ? __pfx_do_raw_spin_lock+0x10/0x10
 ? generic_shutdown_super+0x225/0x320
 ? lock_acquire+0xf6/0x140
 kill_super_notify+0x86/0x230
 kill_anon_super+0x42/0x60
 btrfs_kill_super+0x3e/0x60 [btrfs]
 deactivate_locked_super+0xa8/0x160
 cleanup_mnt+0x1da/0x420
 task_work_run+0x116/0x200
 ? __pfx_task_work_run+0x10/0x10
 ? __x64_sys_umount+0x10c/0x140
 ? find_held_lock+0x2b/0x80
 ? __pfx___x64_sys_umount+0x10/0x10
 exit_to_user_mode_loop+0x133/0x170
 do_syscall_64+0x201/0x7f0
 ? lock_release.part.0+0x1c/0x50
 ? do_faccessat+0x1ed/0x9a0
 ? __pfx_do_faccessat+0x10/0x10
 ? __pfx_from_kgid_munged+0x10/0x10
 ? trace_hardirqs_on_prepare+0x101/0x150
 ? do_syscall_64+0x137/0x7f0
 ? do_syscall_64+0x137/0x7f0
 ? trace_hardirqs_on_prepare+0x101/0x150
 ? lockdep_hardirqs_on_prepare.part.0+0x9b/0x150
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7fe027d41e4b
Code: c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 31 f6 e9 05 =
00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff f=
f 77 05 c3 0f 1f 40 00 48 8b 15 81 1f 0f 00 f7 d8
RSP: 002b:00007fff6e76f488 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fe027d41e4b
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001c2f8c0
RBP: 00007fe027f29ffc R08: 0000000001c2fcd0 R09: 00007fe027e34ac0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000001c29528
R13: 0000000001c2f8c0 R14: 0000000001c29420 R15: 0000000001c29860
 </TASK>
watchdog: BUG: soft lockup - CPU#4 stuck for 48s! [umount:859559]
CPU#4 Utilization every 4000ms during lockup:
	#1: 100% system,	  0% softirq,	  1% hardirq,	  0% idle
	#2: 100% system,	  0% softirq,	  1% hardirq,	  0% idle
	#3: 100% system,	  0% softirq,	  1% hardirq,	  0% idle
	#4: 100% system,	  0% softirq,	  1% hardirq,	  0% idle
	#5: 100% system,	  0% softirq,	  1% hardirq,	  0% idle
Modules linked in: dm_flakey null_blk target_core_user target_core_mod rfki=
ll nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4=
 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 =
nf_tables qrtr sunrpc binfmt_misc intel_rapl_msr intel_rapl_common x86_pkg_=
temp_thermal intel_powerclamp coretemp kvm_intel jc42 iTCO_wdt kvm intel_pm=
c_bxt at24 iTCO_vendor_support irqbypass rapl intel_cstate btrfs intel_unco=
re i2c_i801 pcspkr i2c_smbus intel_pch_thermal igb ses xor enclosure dca lp=
c_ich raid6_pq e1000e joydev video ie31200_edac wmi loop dm_multipath nfnet=
link zram lz4hc_compress lz4_compress zstd_compress ast drm_client_lib i2c_=
algo_bit drm_shmem_helper drm_kms_helper drm polyval_clmulni ghash_clmulni_=
intel mpi3mr scsi_transport_sas scsi_dh_rdac scsi_dh_emc scsi_dh_alua fuse
irq event stamp: 4676
hardirqs last  enabled at (4675): [<ffffffff8f3bcd44>] _raw_spin_unlock_irq=
restore+0x44/0x60
hardirqs last disabled at (4676): [<ffffffff8f39cabb>] __schedule+0xd1b/0x1=
ab0
softirqs last  enabled at (4672): [<ffffffff8ce75d91>] bdi_unregister+0x161=
/0x5b0
softirqs last disabled at (4670): [<ffffffff8ce75cc0>] bdi_unregister+0x90/=
0x5b0
CPU: 4 UID: 0 PID: 859559 Comm: umount Tainted: G    B D      L      6.18.0=
-rc4-kts-btrfs #6 PREEMPT(lazy)=20
Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [L]=3DSOFTLOCKUP
Hardware name: Supermicro X10SLL-F/X10SLL-F, BIOS 3.0 04/24/2015
RIP: 0010:native_queued_spin_lock_slowpath+0x391/0xbe0
Code: f8 05 00 00 85 c0 74 3d 0f b6 03 84 c0 74 36 48 b8 00 00 00 00 00 fc =
ff df 49 89 dc 49 89 dd 49 c1 ec 03 41 83 e5 07 49 01 c4 <f3> 90 41 0f b6 0=
4 24 44 38 e8 7f 08 84 c0 0f 85 9b 06 00 00 0f b6
RSP: 0018:ffff888461417b00 EFLAGS: 00000202
RAX: 0000000000000001 RBX: ffffffff90a75340 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffff90a75340
RBP: 1ffff1108c282f62 R08: ffffffff8f3bd7a3 R09: fffffbfff214ea68
R10: fffffbfff214ea69 R11: ffffffff90a75358 R12: fffffbfff214ea68
R13: 0000000000000000 R14: ffffed109bb8c84f R15: 0000000000000000
FS:  00007fe027c4b380(0000) GS:ffff88876b5d8000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd3d77b3d90 CR3: 00000004c5318006 CR4: 00000000001726f0
Call Trace:
 <TASK>
 ? __pfx_native_queued_spin_lock_slowpath+0x10/0x10
 ? trace_hardirqs_on+0x18/0x150
 do_raw_spin_lock+0x1d9/0x270
 ? kfree+0x14a/0x650
 ? __pfx_do_raw_spin_lock+0x10/0x10
 ? generic_shutdown_super+0x225/0x320
 ? lock_acquire+0xf6/0x140
 kill_super_notify+0x86/0x230
 kill_anon_super+0x42/0x60
 btrfs_kill_super+0x3e/0x60 [btrfs]
 deactivate_locked_super+0xa8/0x160
 cleanup_mnt+0x1da/0x420
 task_work_run+0x116/0x200
 ? __pfx_task_work_run+0x10/0x10
 ? __x64_sys_umount+0x10c/0x140
 ? find_held_lock+0x2b/0x80
 ? __pfx___x64_sys_umount+0x10/0x10
 exit_to_user_mode_loop+0x133/0x170
 do_syscall_64+0x201/0x7f0
 ? lock_release.part.0+0x1c/0x50
 ? do_faccessat+0x1ed/0x9a0
 ? __pfx_do_faccessat+0x10/0x10
 ? __pfx_from_kgid_munged+0x10/0x10
 ? trace_hardirqs_on_prepare+0x101/0x150
 ? do_syscall_64+0x137/0x7f0
 ? do_syscall_64+0x137/0x7f0
 ? trace_hardirqs_on_prepare+0x101/0x150
 ? lockdep_hardirqs_on_prepare.part.0+0x9b/0x150
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7fe027d41e4b
Code: c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 31 f6 e9 05 =
00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff f=
f 77 05 c3 0f 1f 40 00 48 8b 15 81 1f 0f 00 f7 d8
RSP: 002b:00007fff6e76f488 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fe027d41e4b
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001c2f8c0
RBP: 00007fe027f29ffc R08: 0000000001c2fcd0 R09: 00007fe027e34ac0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000001c29528
R13: 0000000001c2f8c0 R14: 0000000001c29420 R15: 0000000001c29860
 </TASK>
rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	4-....: (63898 ticks this GP) idle=3Dbd74/1/0x4000000000000000 softir=
q=3D1419797/1419808 fqs=3D16248
rcu: 	(t=3D65019 jiffies g=3D2934629 q=3D15440 ncpus=3D8)
CPU: 4 UID: 0 PID: 859559 Comm: umount Tainted: G    B D      L      6.18.0=
-rc4-kts-btrfs #6 PREEMPT(lazy)=20
Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [L]=3DSOFTLOCKUP
Hardware name: Supermicro X10SLL-F/X10SLL-F, BIOS 3.0 04/24/2015
RIP: 0010:native_queued_spin_lock_slowpath+0x398/0xbe0
Code: 3d 0f b6 03 84 c0 74 36 48 b8 00 00 00 00 00 fc ff df 49 89 dc 49 89 =
dd 49 c1 ec 03 41 83 e5 07 49 01 c4 f3 90 41 0f b6 04 24 <44> 38 e8 7f 08 8=
4 c0 0f 85 9b 06 00 00 0f b6 03 84 c0 75 e5 48 b8
RSP: 0018:ffff888461417b00 EFLAGS: 00000202
RAX: 0000000000000000 RBX: ffffffff90a75340 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffff90a75340
RBP: 1ffff1108c282f62 R08: ffffffff8f3bd7a3 R09: fffffbfff214ea68
R10: fffffbfff214ea69 R11: ffffffff90a75358 R12: fffffbfff214ea68
R13: 0000000000000000 R14: ffffed109bb8c84f R15: 0000000000000000
FS:  00007fe027c4b380(0000) GS:ffff88876b5d8000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd3d77b3d90 CR3: 00000004c5318006 CR4: 00000000001726f0
Call Trace:
 <TASK>
 ? __pfx_native_queued_spin_lock_slowpath+0x10/0x10
 ? trace_hardirqs_on+0x18/0x150
 do_raw_spin_lock+0x1d9/0x270
 ? kfree+0x14a/0x650
 ? __pfx_do_raw_spin_lock+0x10/0x10
 ? generic_shutdown_super+0x225/0x320
 ? lock_acquire+0xf6/0x140
 kill_super_notify+0x86/0x230
 kill_anon_super+0x42/0x60
 btrfs_kill_super+0x3e/0x60 [btrfs]
 deactivate_locked_super+0xa8/0x160
 cleanup_mnt+0x1da/0x420
 task_work_run+0x116/0x200
 ? __pfx_task_work_run+0x10/0x10
 ? __x64_sys_umount+0x10c/0x140
 ? find_held_lock+0x2b/0x80
 ? __pfx___x64_sys_umount+0x10/0x10
 exit_to_user_mode_loop+0x133/0x170
 do_syscall_64+0x201/0x7f0
 ? lock_release.part.0+0x1c/0x50
 ? do_faccessat+0x1ed/0x9a0
 ? __pfx_do_faccessat+0x10/0x10
 ? __pfx_from_kgid_munged+0x10/0x10
 ? trace_hardirqs_on_prepare+0x101/0x150
 ? do_syscall_64+0x137/0x7f0
 ? do_syscall_64+0x137/0x7f0
 ? trace_hardirqs_on_prepare+0x101/0x150
 ? lockdep_hardirqs_on_prepare.part.0+0x9b/0x150
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7fe027d41e4b
Code: c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 31 f6 e9 05 =
00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff f=
f 77 05 c3 0f 1f 40 00 48 8b 15 81 1f 0f 00 f7 d8
RSP: 002b:00007fff6e76f488 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fe027d41e4b
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001c2f8c0
RBP: 00007fe027f29ffc R08: 0000000001c2fcd0 R09: 00007fe027e34ac0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000001c29528
R13: 0000000001c2f8c0 R14: 0000000001c29420 R15: 0000000001c29860
 </TASK>
rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 4-.... } =
84119 jiffies s: 105653 root: 0x10/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 6 to CPUs 4:
NMI backtrace for cpu 4
CPU: 4 UID: 0 PID: 859559 Comm: umount Tainted: G    B D      L      6.18.0=
-rc4-kts-btrfs #6 PREEMPT(lazy)=20
Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [L]=3DSOFTLOCKUP
Hardware name: Supermicro X10SLL-F/X10SLL-F, BIOS 3.0 04/24/2015
RIP: 0010:native_queued_spin_lock_slowpath+0x398/0xbe0
Code: 3d 0f b6 03 84 c0 74 36 48 b8 00 00 00 00 00 fc ff df 49 89 dc 49 89 =
dd 49 c1 ec 03 41 83 e5 07 49 01 c4 f3 90 41 0f b6 04 24 <44> 38 e8 7f 08 8=
4 c0 0f 85 9b 06 00 00 0f b6 03 84 c0 75 e5 48 b8
RSP: 0018:ffff888461417b00 EFLAGS: 00000202
RAX: 0000000000000000 RBX: ffffffff90a75340 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffff90a75340
RBP: 1ffff1108c282f62 R08: ffffffff8f3bd7a3 R09: fffffbfff214ea68
R10: fffffbfff214ea69 R11: ffffffff90a75358 R12: fffffbfff214ea68
R13: 0000000000000000 R14: ffffed109bb8c84f R15: 0000000000000000
FS:  00007fe027c4b380(0000) GS:ffff88876b5d8000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd3d77b3d90 CR3: 00000004c5318006 CR4: 00000000001726f0
Call Trace:
 <TASK>
 ? __pfx_native_queued_spin_lock_slowpath+0x10/0x10
 ? trace_hardirqs_on+0x18/0x150
 do_raw_spin_lock+0x1d9/0x270
 ? kfree+0x14a/0x650
 ? __pfx_do_raw_spin_lock+0x10/0x10
 ? generic_shutdown_super+0x225/0x320
 ? lock_acquire+0xf6/0x140
 kill_super_notify+0x86/0x230
 kill_anon_super+0x42/0x60
 btrfs_kill_super+0x3e/0x60 [btrfs]
 deactivate_locked_super+0xa8/0x160
 cleanup_mnt+0x1da/0x420
 task_work_run+0x116/0x200
 ? __pfx_task_work_run+0x10/0x10
 ? __x64_sys_umount+0x10c/0x140
 ? find_held_lock+0x2b/0x80
 ? __pfx___x64_sys_umount+0x10/0x10
 exit_to_user_mode_loop+0x133/0x170
 do_syscall_64+0x201/0x7f0
 ? lock_release.part.0+0x1c/0x50
 ? do_faccessat+0x1ed/0x9a0
 ? __pfx_do_faccessat+0x10/0x10
 ? __pfx_from_kgid_munged+0x10/0x10
 ? trace_hardirqs_on_prepare+0x101/0x150
 ? do_syscall_64+0x137/0x7f0
 ? do_syscall_64+0x137/0x7f0
 ? trace_hardirqs_on_prepare+0x101/0x150
 ? lockdep_hardirqs_on_prepare.part.0+0x9b/0x150
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7fe027d41e4b
Code: c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 31 f6 e9 05 =
00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff f=
f 77 05 c3 0f 1f 40 00 48 8b 15 81 1f 0f 00 f7 d8
RSP: 002b:00007fff6e76f488 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fe027d41e4b
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001c2f8c0
RBP: 00007fe027f29ffc R08: 0000000001c2fcd0 R09: 00007fe027e34ac0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000001c29528
R13: 0000000001c2f8c0 R14: 0000000001c29420 R15: 0000000001c29860
 </TASK>
watchdog: BUG: soft lockup - CPU#4 stuck for 104s! [umount:859559]
...=

