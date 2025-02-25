Return-Path: <linux-fsdevel+bounces-42578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4071A43FF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 14:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4311C3BFFFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 13:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3E4268FC0;
	Tue, 25 Feb 2025 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="Fa4FmqVK";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="Fa4FmqVK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022110.outbound.protection.outlook.com [40.107.168.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9FB268C66
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.168.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740488498; cv=fail; b=O+tXDuzuhO9FSyFdsnReu3LyglHsVMAYaBXy5ln2qGGZFJ69CM2DU+2h9YQsnAqdv8Gqq7i5gQvkl30AjAADUGDPPKuvVWDbwVaXjoBQS/nuGruRe+bAmHvj+24eQglnclWwjaWByXhtoghSBINzVsNwhyO9V10CGewrTRvVHGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740488498; c=relaxed/simple;
	bh=MmbG58VGTuQQPesda8GElXkDPY16RAOFHd60fa45kzM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UNzPa3egsrOMqFv+itQYb04f7N8PelYH2GEpdScE4e48ec/+1Q8cAKe2SnsKezmOpvU4BFisJA+M5C4akAoVDOpiKVBwIWqjz1Leo+KAck1bEyGyK939Ce/bnQGnD2F2NgX4HSPku6OpP7XO+T5sO4zYns05afyqH9pZQtsgTGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=Fa4FmqVK; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=Fa4FmqVK; arc=fail smtp.client-ip=40.107.168.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wxt9c0YVVV0nWOKGmLySads8a8YgcmVlYV3juf6nxZ3sFQMhHSqdaMT7OsKGzNJ25WUs/TsSoPKn7L4G9Lzy8B7ihUsXbQ9S/3PVpejBV4MaJzRJasf6yePuKYnkbP7mGw2h2z9iu01Fg/YRCm3O7l/63c4Xu6aIQZlWyDzmOr1wwRd6YZw2Pd0+SAkfUShBNOijyOPkaI49m0FjQ77KWRCq5fDD53cvy2+fwPqEOTGXWcIzD9l9m4B2s8fynknDGfY1qRDyuOyXDNg6qTfOyOa3cMzj45DovSZ77qbPSJO284dFWweiAdYD42YYjXp/lh+5wexAZdm/I3jh8kqaPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXrRlYj8V1ut8RvslsKXkjE0Vsq8AcrxirburxBlVsI=;
 b=v4/iZSqNJe8gytgHU5aod/v1mAHOPpx6b3zRBsJ4xgvCHs0pUVf88s60dmGZDT8swvOMN75qw/G7emq1QSBaIkzuQf0cDtLfFArkCaapGWnKsZY2avX+d7coCB+G2EZlxZI8PeB62J9CXXPnEeJCxUOzlHGf3L71a9/qzgx7LBGU9AHPIsV3BbwcbjikL4Xh0EvUpQbpvE7b4U5Krgfp9R7nII1dAsQUPjFws0YYl4hVFVpB3CyylEjcCXf1akmakh4rq803Qf2N/fae4m3ILWLJuzSZ+Fcb/OcDpHKxMPpbZV3o+JSHtT7b5A2VxBTQJN45B8PAo8dhMtwGbxF0GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.208.138.155) smtp.rcpttodomain=fastmail.fm smtp.mailfrom=cern.ch;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=cern.ch;
 dkim=pass (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXrRlYj8V1ut8RvslsKXkjE0Vsq8AcrxirburxBlVsI=;
 b=Fa4FmqVKRfKo7mqmD4WqGiup8ubGDjgIJOC84FtcPGm13Rz0pbKseHj7eX/1MwsGG/nwOuOghYKKoYbJqHO3cAYljdu07Kc5UzD1DxU6T0ca8AbN+PYAcQ4CF3+3ttc1VwdJ+XU+1EMBKiFVCCRa3zgCYpUMqxTjZphWFjTCvA4=
Received: from AM0PR02CA0103.eurprd02.prod.outlook.com (2603:10a6:208:154::44)
 by ZRAP278MB0141.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:11::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 13:01:28 +0000
Received: from AMS0EPF000001B6.eurprd05.prod.outlook.com
 (2603:10a6:208:154:cafe::62) by AM0PR02CA0103.outlook.office365.com
 (2603:10a6:208:154::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Tue,
 25 Feb 2025 13:01:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.208.138.155)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 20.208.138.155 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.208.138.155; helo=mx3.crn.activeguard.cloud; pr=C
Received: from mx3.crn.activeguard.cloud (20.208.138.155) by
 AMS0EPF000001B6.mail.protection.outlook.com (10.167.16.170) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.16
 via Frontend Transport; Tue, 25 Feb 2025 13:01:27 +0000
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=Fa4FmqVK
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazlp17010001.outbound.protection.outlook.com [40.93.85.1])
	by mx3.crn.activeguard.cloud (Postfix) with ESMTPS id 5D7D9812AC;
	Tue, 25 Feb 2025 14:01:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXrRlYj8V1ut8RvslsKXkjE0Vsq8AcrxirburxBlVsI=;
 b=Fa4FmqVKRfKo7mqmD4WqGiup8ubGDjgIJOC84FtcPGm13Rz0pbKseHj7eX/1MwsGG/nwOuOghYKKoYbJqHO3cAYljdu07Kc5UzD1DxU6T0ca8AbN+PYAcQ4CF3+3ttc1VwdJ+XU+1EMBKiFVCCRa3zgCYpUMqxTjZphWFjTCvA4=
Received: from ZR0P278MB0714.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::7) by
 ZR3P278MB1281.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:71::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Tue, 25 Feb 2025 13:01:25 +0000
Received: from ZR0P278MB0714.CHEP278.PROD.OUTLOOK.COM
 ([fe80::b11d:2ed0:8ae5:febe]) by ZR0P278MB0714.CHEP278.PROD.OUTLOOK.COM
 ([fe80::b11d:2ed0:8ae5:febe%5]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 13:01:25 +0000
From: Laura Promberger <laura.promberger@cern.ch>
To: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <mszeredi@redhat.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Christian
 Brauner <brauner@kernel.org>, Bernd Schubert <bernd.schubert@fastmail.fm>,
	Sam Lewis <samclewis@google.com>
Subject: Re: [PATCH] fuse: don't truncate cached, mutated symlink
Thread-Topic: [PATCH] fuse: don't truncate cached, mutated symlink
Thread-Index: AQHbg36nyvzCL5gjh0KITq8X/PgHRrNUDLGAgAE6C4CAAAgVgIACtCvp
Date: Tue, 25 Feb 2025 13:01:25 +0000
Message-ID:
 <ZR0P278MB0714711C33809C1753D6696385C32@ZR0P278MB0714.CHEP278.PROD.OUTLOOK.COM>
References: <20250220100258.793363-1-mszeredi@redhat.com>
 <20250223002821.GR1977892@ZenIV>
 <CAJfpegv24BN_g3C0uNPZu_gM7GEy_3eSYyFSaeJZ7mLsfcNqJw@mail.gmail.com>
 <20250223194117.GS1977892@ZenIV>
In-Reply-To: <20250223194117.GS1977892@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
x-ms-traffictypediagnostic:
	ZR0P278MB0714:EE_|ZR3P278MB1281:EE_|AMS0EPF000001B6:EE_|ZRAP278MB0141:EE_
X-MS-Office365-Filtering-Correlation-Id: 7181bbfe-04ba-4c39-8463-08dd559c8456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?YAcjHuWp2FkrqhrLCbl9J5X8RMSM+k1sviolYJo44WD0waoWl8YkvMDHNi?=
 =?iso-8859-1?Q?rZLYOQa9wN95bMG9tigRWRbJawe3iWXZJPd+FUzKYqz1JV/miRRJTNEXKH?=
 =?iso-8859-1?Q?LE0MnYwUkKOFSWBOf5C++TX1/P1gx6AA6ew+qO/w0E6RMiA2LyhQ4E0dkS?=
 =?iso-8859-1?Q?+7jJGQrPxYdeIGW8FYxxt+/+CKYBIffyFROuuXvCv7mkbrfC1rU1UddVW5?=
 =?iso-8859-1?Q?GVqknzF00fTSvbEKHSeYz586WjRJraFoKyBrqiSlPLgmY26jXGG3PlpDLU?=
 =?iso-8859-1?Q?7U/3GFRS9qO7jJVS44yoDaoGLF7hd9nWShlsrg8e4S7zC5b3nIjTAJ0lwX?=
 =?iso-8859-1?Q?yyDBTMjskG8xDNdkpJSpsc8xVtECSbQEG1UmhKc+Hl0eXXo8dwnRkP8KVc?=
 =?iso-8859-1?Q?N5fWxkLkEbkblv/++LokaZzddsD+OZKVWzrKGKrclZCiIo6AszwQy7/xx5?=
 =?iso-8859-1?Q?Tl8a93/NP21Wj6+3+QtlXBqkZ20xN7MBkdxPI/16fPzmkAnc3ALkpua8Vf?=
 =?iso-8859-1?Q?QLn3gRzA7XAOOrn01xJFpjeMkFGo6UYHi0eK38Mqi8Ouxb3Fh2TvSbkR31?=
 =?iso-8859-1?Q?sID9C2lwhPAT3HxD7w9QOBQDB0cEeF7eyW/TQX0DSTltewyUt6XqQQpa9G?=
 =?iso-8859-1?Q?wEIiVnu+E6kOsJ8AXnfB5neChDQRadZAUk8Fjxr9b3j6XtqpO3Xvmlvvqx?=
 =?iso-8859-1?Q?wKp7TCBQMUXOm+L9Xp8iwjBySPXwQuL5H2Tgge3rM4/uANQYS3srUspyBX?=
 =?iso-8859-1?Q?ARJYT+xGTbd0ruhKf8+7vOAtKex1miI/Ekr/HIq4uhROlicGet4rWiXoc2?=
 =?iso-8859-1?Q?S0txaEnUeOTNNzrSJ2g0zL1TxKvsZIN+sky5xdHTRRdBfUwybDMyXFcshp?=
 =?iso-8859-1?Q?lAACB5kjjZRg9KfVeeauLY+atX48vTcvPuvHVw0F3rNOsj6Pz3cCO/mgw9?=
 =?iso-8859-1?Q?gRfbPyeDu+14/xjg0mgSg40k1RA2XUUmarhpO9Ob9B3wOYr8sTfFYBe9PP?=
 =?iso-8859-1?Q?aU7pmhA6WgIz0ABHUxRuy0ha904nryxy3DU2LMXMkwUJ4HeO15fHsKADKH?=
 =?iso-8859-1?Q?SVET+d9W0N8Fo/Nedqtr7yWF4coWVLCC2wqQRLcBBHqFY4K9twf8YkuxT3?=
 =?iso-8859-1?Q?+TCTketmM84aH/oqnrtuDAfQvILRH8UOeWXyOmc3tkFElJKLg6GAU4nLAQ?=
 =?iso-8859-1?Q?OaGupP7xqFQiRtk68lWydt5KwVg35LAuUBiI/DvJU8SQqMetoxnF3Z+wGx?=
 =?iso-8859-1?Q?C1lAbRoJSUys5SulUKhHy8m5t78jMG/qKiSY4JrsrtnmuNeFuwUs2qI3oK?=
 =?iso-8859-1?Q?nXUcGVV9lELVmqTUyMXoIfbgxa2dQDmO++VZS41efwyPvJ2tj9xyG6HX09?=
 =?iso-8859-1?Q?5/WC7TlDCbB8qRT5WTyMEjBRd9PWkm611pzEJhNGFZMnaQARqj41i0kFzl?=
 =?iso-8859-1?Q?p7FLqNlcvIJ0k7Pxt/TLOiwedZ1QvXAqvf6pCwAH7Vx91RhZG+Ed2OYTDH?=
 =?iso-8859-1?Q?0KGEKXQemTVh3wDTGJADBj?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0714.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1281
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B6.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ca8f03d3-2a69-4056-21f8-08dd559c82bb
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|35042699022|14060799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?TCBG7eT9o7vTEdv56v6yymOmc8luSx9kTR1MLuw70cB5fZIiQSvMSxO6xB?=
 =?iso-8859-1?Q?JvcUxFzFvTmfjGN/R0PWV7+8srsaitGdutgOxys/XP2Kv+w9yS+FfnCBtR?=
 =?iso-8859-1?Q?08lMSNY2FPxnM+6+rHp96UNGFq27w0SNCTcmnlxi10ujBWUEU4mP53FWSs?=
 =?iso-8859-1?Q?aOU+uDFRpftJDHhdfHt/B8L77zdacAl3hk6ZlT2/PCaw9WXKbM3LDEcZ9y?=
 =?iso-8859-1?Q?faS1hR/hlspUpJZjbtSnZDDZrAFGdv0lyQtKeTbXXXjqbvLX77BgMiTxfO?=
 =?iso-8859-1?Q?B2m7IHkFQvee5AUZLvRHxqVi8Y44BuozZaNR6+za33UV3QK8NRSJwENcvo?=
 =?iso-8859-1?Q?gQVVl82SXwDUvpY8V+pYNhbWFw+fHHh4Aw2RLJYFyl1V+tWQexLEpjcj3s?=
 =?iso-8859-1?Q?PkUuSLLQH/bd6clvPsS6QleLZDECTCIeOc9Ptu/2nRbk0wg4hcIG+BM1xR?=
 =?iso-8859-1?Q?8AKFEc1now+DESPaEG6CRfIdCMM7eG5mdi07SCsORoCDVbRVkkDGPeGp9a?=
 =?iso-8859-1?Q?sE/xCUiafS04SiSQkPeY/uJ1AB1PH+pvoMz/jJbRzohcS9CEoIQB+G1es2?=
 =?iso-8859-1?Q?o0Wd8tMZlcuiUa0SNLSQcYhkiH+++3XFp4aeCecmlU74ikxoy6urkdPRG6?=
 =?iso-8859-1?Q?JwIlHkhp5PEu94c0lL4IfimQzm/eEiLA6QDpvfbQJ9Qt/rdxw96iXxDBqr?=
 =?iso-8859-1?Q?f8Z42aJaX/7LuS8GhMjbxz/x8d00bv1Zzfg6vggwSmMfEzfDix8ik0ePk8?=
 =?iso-8859-1?Q?jPrpkOSNxxtNAIVcIp3gTlQG5ZLjetlTQxNNLb1+lMPR8p+NCjFI5GJCXK?=
 =?iso-8859-1?Q?qmwwMwX3Jhp+BWWpazCmmAxWpCgOKQMCSEW7kizG5fxTmOTVgzC93AKK3R?=
 =?iso-8859-1?Q?KF/BrCUNLPfScUYT2R/G1E0/csM+qzXchVEGhZhrGDTJja0Ga2ZHgb6nLC?=
 =?iso-8859-1?Q?Bu7IRfHl8PVgT6uA4q31vT/AUrSoEsWyZ9KhRfQvCCM49ai+lHJILAxI9X?=
 =?iso-8859-1?Q?7SfnQV5AC8XoEFa+ubvo7SRSxtkNs+QEk7HGrrewlJES4W83sUtjUErirQ?=
 =?iso-8859-1?Q?nwp7SglfPfGjAZ7iF+5j7UvkXWi693nk7SgtWEtI2v8bRbZDZPp7sTlDJo?=
 =?iso-8859-1?Q?U85Mp29XwFcGmbRfYYDsUWw/mgcNojh0xa8g3I1WWZyozjGcJvD6kEmHVx?=
 =?iso-8859-1?Q?ZLz/Z8zcXQtcIBuGQATyyZQK0eEVZI167WPbkjr9EpW6RwJWuLj8agZNOQ?=
 =?iso-8859-1?Q?kgD5H5cHhfqKQxBWKBtSFXWvwaqWHi1MDTstFHEkj4nxkAdqQLON9Wc16N?=
 =?iso-8859-1?Q?vCbDsem9W61BnJqZcIpP4YQfc39tVPlgX+ZtIaP2XyM2Zwmoo5cSCUWYKQ?=
 =?iso-8859-1?Q?x+PIiKTvgbZMwswEyHyCinpNugTXrCL+axwkddUSxQ12oVow5wUFu4UIFf?=
 =?iso-8859-1?Q?bx1qCrzH0yakp4Qpfhvg4GaR7treAIVB2NjFysLhnD4cwUoFTZxY9D83iq?=
 =?iso-8859-1?Q?adwU03Puq8+zMWvLypeiEe7oIQzUy5DR3pWwPRAFVLr8gLYoRjt0INM2cQ?=
 =?iso-8859-1?Q?QMzdSQE=3D?=
X-Forefront-Antispam-Report:
	CIP:20.208.138.155;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx3.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(35042699022)(14060799003)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 13:01:27.9218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7181bbfe-04ba-4c39-8463-08dd559c8456
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[20.208.138.155];Helo=[mx3.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0141

Hello Miklos,=0A=
=0A=
Thank you so much for the patch!=0A=
=0A=
I finally managed to build RHEL9 with your patch and I confirm that truncat=
ion of the symlinks is not happening anymore.=0A=
=0A=
However, I will need to do some further testing as I see that sometimes the=
 updating of symlinks is not propagated correctly.=0A=
This should not be a kernel problem.=0A=
I believe this is more a CVMFS problem, its revision-based update  process,=
 that there is no way to pause user interaction with the fuse mount, and th=
e asynchronous removal from inodes/dentries.=0A=
=0A=
Thanks again=0A=
Laura=0A=
=0A=
=0A=
________________________________________=0A=
From:=A0Al Viro <viro@ftp.linux.org.uk> on behalf of Al Viro <viro@zeniv.li=
nux.org.uk>=0A=
Sent:=A0Sunday, February 23, 2025 20:41=0A=
To:=A0Miklos Szeredi <miklos@szeredi.hu>=0A=
Cc:=A0Miklos Szeredi <mszeredi@redhat.com>; linux-fsdevel@vger.kernel.org <=
linux-fsdevel@vger.kernel.org>; Christian Brauner <brauner@kernel.org>; Ber=
nd Schubert <bernd.schubert@fastmail.fm>; Laura Promberger <laura.promberge=
r@cern.ch>; Sam Lewis <samclewis@google.com>=0A=
Subject:=A0Re: [PATCH] fuse: don't truncate cached, mutated symlink=0A=
=A0=0A=
On Sun, Feb 23, 2025 at 08:12:21PM +0100, Miklos Szeredi wrote:=0A=
> On Sun, 23 Feb 2025 at 01:28, Al Viro <viro@zeniv.linux.org.uk> wrote:=0A=
> >=0A=
> > On Thu, Feb 20, 2025 at 11:02:58AM +0100, Miklos Szeredi wrote:=0A=
> >=0A=
> > > The solution is to just remove this truncation.=A0 This can cause a=
=0A=
> > > regression in a filesystem that relies on supplying a symlink larger =
than=0A=
> > > the file size, but this is unlikely.=A0 If that happens we'd need to =
make=0A=
> > > this behavior conditional.=0A=
> >=0A=
> > Note, BTW, that page *contents* must not change at all, so truncation i=
s=0A=
> > only safe if we have ->i_size guaranteed to be stable.=0A=
> >=0A=
> > Core pathwalk really counts upon the string remaining immutable, and th=
at=0A=
> > does include the string returned by ->get_link().=0A=
>=0A=
> Page contents will not change after initial readlink, but page could=0A=
> get invalidated and a fresh page filled with new value for the same=0A=
> object.=0A=
=0A=
*nod*=0A=
=0A=
My point is that truncation of something that might be traversed by another=
=0A=
pathwalk is a hard bug - we only get away with doing that in page_get_link(=
)=0A=
because it's idempotent.=A0 If ->i_size can change, we are not allowed to=
=0A=
do that.=

