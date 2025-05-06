Return-Path: <linux-fsdevel+bounces-48169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D0CAABAD8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 889013A1B1B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 07:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1922922A4CD;
	Tue,  6 May 2025 04:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="F9WSzIdm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013044.outbound.protection.outlook.com [52.101.127.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93CD2505CE;
	Tue,  6 May 2025 04:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746506374; cv=fail; b=cGBjEOg73PuB3/kixRnnWYoV7FyH0EfA0d+da8gHakpIaMAylafwpT+dm82H7tUwpZzivH0QiOGGmeqDIY2fYs+tMqgdWvnMFDgatbNEPOmCEYymeAA2LaoFvDtFrgwk/zv0UU6pBnzaj9U2m91VOu+oASMJ7ZOtJuvegbpWXSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746506374; c=relaxed/simple;
	bh=gX4Wgft9usfSaXxspipyYfrhVmDQBwPa/yxvsVGrvmM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ae6eSXfO87rDLjnjn8XDNaYrZIFPCzodw0x3c2vsKz5zM37HaoOwB/IT1qbOiY4Sk97SOrr3TIK18pETU9QvKBlRCPWdqmsELxJeZswAgIthKmLJc4aK//d2VvYoUalFyiFU12C2yTsIvLIMSfH3MdHpruB7HwJgunllJ1fUkUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=F9WSzIdm; arc=fail smtp.client-ip=52.101.127.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v66arFDX3uI7znTtYGZMBAU3GRCwfRBdT+hMIPmp7SYPDT2cGi7MdnH7RRpWSkwfkHBZh8/XxOqRwWc+CXfW2+Q+ri+iwjHoFhWCEpGSzZacZBPeA+4Zji1Wm2zX/WEuSFgiDJC2SBYba7QtNfXXKvYTpRzjC73jBIbJUyJeET1Xbvsz0to20aPvPYmzhN6AN4AusOEYvVouYWIntWcpTLt85Q9gG4H3ZLLOkQcmSAoSrZLtKYHBjlv6HgCfQhdllxeT83+A8aXFCi9BNuywMMiZ4KguLbuQZzUHm5eOG/DJNdfjcV779GukXgjCUNZ+Tg4ViRsPT1KEqJWPaBgKuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gX4Wgft9usfSaXxspipyYfrhVmDQBwPa/yxvsVGrvmM=;
 b=tM9vrMROACThX2k4QV8HYR5kI2443V6QKsRTxcPAXB3w4TyHMpW8H77UgsAYAdXUex7Ou4WxKyo/kePMnBmapNg+WjNU9EP6SzCWo4FehQ5TQmxyvxNzaCP9jvDPxrqhzJrj8+Sj4rb+Zo3VxbN3BZ2boG+Puar3gbevq2EIPoh6RcD8hEO+hvUqVqx4RSACX18XkbzinwVsl/drQ/hS8YbKylcnWETxmPH6V4Fp+BKU5CrRbogFz7g7AQBhhZeG0PXko7fUYUWaWsz6hE//Z386woq/wyXJiSJDKTDX8IewPKXZCmCGA2wpB3SqQChdURfgsL+9yreTlLSuCOUXvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gX4Wgft9usfSaXxspipyYfrhVmDQBwPa/yxvsVGrvmM=;
 b=F9WSzIdmC3mtS4Rc6BN8/eb3Lkdka6Y9cUA9hCGrgHJGHvCivlGhMgff9mBZx0BoIFzGMXcw7Y7oIX+2nzs21fkHoxLpgHWZDgbtvl9fhCHSX+VO+vKHWwnKOQSxibyg0TsMusfbpdzCcBUlXB7oOVixSm/AFBGKcH6c/VVEAGBSa+fpF+SlGF35TGloFIcdwGFp9MyLvjjVgZJ/bdOyIihKXX+t8G//ARxOjsjam66nWXM4mbhVC3MFV5AA5nC7JxZNwBxmaX5S2PnfN8E1EVHzUus7FC/s9IRfOdl0lxIgNd/CJaJoFU+lyXwBKwCKXWgIua2ORxSoVv6Nkcpkjg==
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6139.apcprd06.prod.outlook.com (2603:1096:101:ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Tue, 6 May
 2025 04:39:26 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%4]) with mapi id 15.20.8699.021; Tue, 6 May 2025
 04:39:25 +0000
From: =?gb2312?B?wO7R7+i6?= <frank.li@vivo.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "Md. Haris
 Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>, Coly Li
	<colyli@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, Mike
 Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Chris
 Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, Andreas Gruenbacher <agruenba@redhat.com>, Carlos
 Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota
	<naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
	"slava@dubeyko.com" <slava@dubeyko.com>, "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>, "linux-bcache@vger.kernel.org"
	<linux-bcache@vger.kernel.org>, "dm-devel@lists.linux.dev"
	<dm-devel@lists.linux.dev>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "gfs2@lists.linux.dev" <gfs2@lists.linux.dev>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Johannes Thumshirn
	<johannes.thumshirn@wdc.com>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIDE5LzE5XSBoZnNwbHVzOiB1c2UgYmRldl9yd192aXJ0?=
 =?gb2312?B?IGluIGhmc3BsdXNfc3VibWl0X2Jpbw==?=
Thread-Topic: [PATCH 19/19] hfsplus: use bdev_rw_virt in hfsplus_submit_bio
Thread-Index: AQHbuhYRDNJlPWw5UECiKvCJdMfVCrPFCobQ
Date: Tue, 6 May 2025 04:39:25 +0000
Message-ID:
 <SEZPR06MB526957D0F35531E2D9B9EA2BE8892@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20250430212159.2865803-1-hch@lst.de>
 <20250430212159.2865803-20-hch@lst.de>
In-Reply-To: <20250430212159.2865803-20-hch@lst.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB5269:EE_|SEZPR06MB6139:EE_
x-ms-office365-filtering-correlation-id: 0367c651-41e7-459b-af18-08dd8c57fae2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?NGFTK2lKNUxLNkN4VTA1TG9HVlBTd3RnNnpsbkZEeWxJU1Vwdk9RNVVVek9T?=
 =?gb2312?B?ZzYvdk41YkVWNzM0WFZML1dRSExkODIvVFdIdVVzeHhIM1Fxa0paOEhTVDgy?=
 =?gb2312?B?Y3BVQ01RVVhSaEgzS1hRSzVhdDZpcnh5blFoMldYL0szeHhZTUFsaVhyQU1m?=
 =?gb2312?B?dlpSRkl5UlNmdFozcEdnL2RoREdVV0JoZ25EWUFiNUFIRjArbFRXQnRQRGxK?=
 =?gb2312?B?Y2ZpOUlXNFBNQ1BIUmpWWFRUc2poZHNneG85NjRVcDMzTG4yN1BqTTAyRkFV?=
 =?gb2312?B?RHRJT3E2d0QwZmtYaCswWUlGb2svK2FmWjl3L2RSeVplV21oV0tnQXcrMktP?=
 =?gb2312?B?S0UzTWNEZm5HYmVWUWszdyttaU1XU0lIRmVVcjRtSG5EVm5ycERDWkczUXM0?=
 =?gb2312?B?cWVoaGFFMjk4Z0hDMDJpT2I3MTVncVhqR2tOejdpTllxT1pPM1BhNVQ2cFNN?=
 =?gb2312?B?ZTlWSXJnNjlYUjdTMVJRRVNYajEwc0VuOGNWWW9WYWJPdWxlK3Jubm9pMWZx?=
 =?gb2312?B?bk5XT1B4N2dMMUhPRXYvR3J5eU9sNmJmeDdHQS9nelBFa05KWnk0ODNlZ3cr?=
 =?gb2312?B?N2dkSXJiN20wMnBjWENNSmViWW9nZ1FZTU1FWHNmcXRZUlY3dXdsNFBvaFQ5?=
 =?gb2312?B?K0w1Y0JpcWNkTVFBMmdpU2Nra3JlZWU1OHFvWVNGMTByU2pnUG0vNDBiL2tx?=
 =?gb2312?B?dHNXTmU5UFZqaEY3QWRXUTR3VHUzc0NmUEFuSzV0ak41T1ZKdGNQYStGM0hh?=
 =?gb2312?B?anFxTFFFdVZjOVZiWlhjektVTlRPSkV0Y2paUEJBMTBuNWxVM3R4R2N0SWsz?=
 =?gb2312?B?dkFKb3MvM2x6Rlh6VEk5ajJSWHBiR0twL3FsZ3FyUmQ3ZXFiK1hsaG10QkZw?=
 =?gb2312?B?U3ZWbTh6UzFycmZ3SjlGVlJxSU5lQW96RVAxZ2lRdXE2c2hkcDcyY053THg3?=
 =?gb2312?B?YnFXYWhZaktCUFV1S1p6TE8rWk5MTS9hU2p4K3JjMy9nSDQ3UUJnb202NkMr?=
 =?gb2312?B?SnowMDJtdE43Nlg0MS8wN0pra0R0T1Z4QmlHRGVJTjljZGc2eXhPNkNrMUZa?=
 =?gb2312?B?N2RKVzBPSFpwZ0dkbkkwVmV2L0MrTXVGOGYvUitwK01HTFdvVXpzUnppajAy?=
 =?gb2312?B?MW1Gck5BWDlodEZwUlEydU1rWHlyeGQ3OFZPM2FKZmFvUVRuaDZXRHorOWM2?=
 =?gb2312?B?Z2tNUXM1eEhiK1lJWFR4RGVKdlZ5MTk4cjBLZFRpa2wxRzlsRmg4YkR3cTY2?=
 =?gb2312?B?RzJWQ0FMSC84bS9UWlVjaGIwSGcwZ1I5VXlUYnRJdm9vRHdXcCtsaytxcWQw?=
 =?gb2312?B?YlRYUEFEWW9OVmNWYnRFeGtqV1UvRGVXQTg1VDVhbFBZMlJMbVQ2WEdrS0wy?=
 =?gb2312?B?dnk1N0loZTV3WXgyUVFXeTJjWFJtZmZPYTFNcS9NdlRUY3JnV2xhUGJLa2s3?=
 =?gb2312?B?YTQ3S1F3a01mS2xpSkxBS0orVmk0Yy9BWXVYK0MyY3U1RDRXMmljT1JBTzl4?=
 =?gb2312?B?blo2Y3N5elVWdXo2NkhuVmNIWmYyMmhxd3YyMTJicTFrMFRQVnBKNy9Ba201?=
 =?gb2312?B?NUc5S1pUTGg1MzJGRU9haUFHa29KOFNSanFRdU41bGpFSEtMdm1NUDNxYTlY?=
 =?gb2312?B?bXdiRkJqcW1kNUQwdUZnNkM2Ky9lTU53YUtlZis3SGY3bE5EUHpMNktQVkM2?=
 =?gb2312?B?Ulpya1p0TmJkR1NiSC83a2k0b0J1R0pMYWlFSkpSZ0N5SWRQUmd5anQ3YnVZ?=
 =?gb2312?B?NXZpY2k4d2dXdVRrN1F2aEJFYkdSckkvdHhhUEJ3em4vTHdFNmVyZVUrTWMw?=
 =?gb2312?B?bmxiYkFOdHZlNXB1NnA2Mm11STZIYWJnQnlWcjNkUWhuS3BOSWptcWQ4Q0Vj?=
 =?gb2312?B?ektScE56RXVFUVBzS09Oa0VMbVhMajdJTGN0eVh3Q0JtYVJDeTErSGh6Q1pB?=
 =?gb2312?B?Zm5YMnNmNlVKb3g2Z2ZraE9QSnZnaTAzclFlK294ZktJZ0Rid2gzbE9Cd0NP?=
 =?gb2312?B?WlNrdGozM3FRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?UmQvVUpJcCtZNnpjdlZtdkNFY1h4bStiTzFFbE5XWkpnUThUUmlrTms2M1NX?=
 =?gb2312?B?aUUxRDNJaWJaUTB0bGxpVjBobEFIZG9zaWNIemRHSTVhTE9maU04N1dSeDdl?=
 =?gb2312?B?Y1FiWjc2R3o2NDRMaWdaZ0lIejloSmViRitsUkxLYTRCRk8ydVdKS3RWaXZz?=
 =?gb2312?B?VEhlQkx3ejM1ZFFMQ2ppNzJHYlhLaGQrL0h3NEU2eEJ1RDZxZEFhNS9mQVBG?=
 =?gb2312?B?Z2k3eUszNi83cXREYnZPZTg4azBSdHNtK1V0NUxYWkxyT21kT0NsdlRxUUpL?=
 =?gb2312?B?YkNoYnRUR2huOHVKVjFVQnJNOVIxSmsveVRJVURqdFNCekhTc2YxTWxwWFY0?=
 =?gb2312?B?YWFWcE56SDY4L3lpRTJjRWpQalJOSjQrTEtOZDR3WlNvbGVQUE5TYjlrSWJF?=
 =?gb2312?B?bVlQcy84SkpzVnVIMGFZLzdHcFlud2V3Q1ltcDJGNmdCTU5BYXAvR1dUdkxy?=
 =?gb2312?B?SmNNMjd4UkxpOEF0eFAzTTBqVlNxTnF0VFYxbzRJU3RGYnFvdW4rNVEwQklU?=
 =?gb2312?B?b3FFVHJIUDNrNVZxR0xrMXY3SWhjbWpXdlFheHM4MHhvem5LR1gyUmUrQ3dO?=
 =?gb2312?B?dm84WlRaUk1TQUNMNFQ1Q0lnbXZwQkNaMnVxN0g0RHNlOWN1SHVUQ3k3U0Zy?=
 =?gb2312?B?VU92Ky9wTStSNFJ0TDY5TXFSejlyNjExdWM4VEwvM2pSU2dCaWFoYTJGRUxw?=
 =?gb2312?B?dVJFS1U3M09wYXhnMngzSVp0QXVBSFljWmFScnFETmw3SGtHdG90R3UrN1B2?=
 =?gb2312?B?UUhyUlVUcy9SUjEyNjFIRnlDMGxVTWhsVHV2Ulc1TW9RYXg3cG02dGlCQ1k3?=
 =?gb2312?B?UHN6bmVxMHIxQ01NUHNUaUhSUjdDOFRPRHRRNkdRZ1lhVnpkMklQbHlDOGhs?=
 =?gb2312?B?Mit6dzhZdnUrcmZtNFRvVy94eE92R3BBK0t2NndlZDBVb1FvYTB5UGRqWDZI?=
 =?gb2312?B?cnlmNlM1TkY0blRlZGdzcktGUEEvTVYwajJUY1hqT0g2UHgyMUVJdGdRUUZH?=
 =?gb2312?B?WXh4bGhCL2FGMDUvYS8xVFA5NmRSc040dTZWSTFVZENKQW92d2pBenVnS2d1?=
 =?gb2312?B?Q0hQMVBaQUlTMkQzczlaWEx3RjJBeXBHWThVeTJtSkdZSjJULy94blNMMFJK?=
 =?gb2312?B?V0lZb0d0NERVdUk2ZU1ud1pucCsyWVVCUHdYYisyUFhlU1c5L0FBSTUrbXY1?=
 =?gb2312?B?VWNXaDdJaEI4bmxWSlJ1aUhUZjRCNkY5YWFBY1BIS0kvQ09OVjhvekZ1Y0dD?=
 =?gb2312?B?dFNUTis4clZmQ0ZnaFpqUTBOT1BwaEVtcWZCMHhvYzZlWjV2eFM4ZnAyOFds?=
 =?gb2312?B?S3AwOWwzY0hFQ1hhQ2N5dnhMVDFvVVUzRzg2eDVjMXB4cjFpckdBZm9JK095?=
 =?gb2312?B?Sm5rckFPaGdTczZJd0JaMWlFcENqSUZPSG1waEhLbDJBYkc5bVJ3UERFWERu?=
 =?gb2312?B?amtoMmpud2xxY2ZzWlZXUlhGZ2tLb2RMWU5kNDVPSFdWYnJsdUVUbkk4T1dl?=
 =?gb2312?B?Yjh3cngxcWN0clk0MHoyL3dSbGwwZy9zamU3TVpQNzltQm9haXM4MnhDVDI4?=
 =?gb2312?B?QjV3cEpWYko3QWVzQk5rZkI2c3RYV2NpNitGcW00UnpvMkFuZ05peDdKalR4?=
 =?gb2312?B?SDBxc0NJOENTbzBadDFLYytzU3JZLytESFhyVkFJcXM5UC9EZ3JvWkhRTVA5?=
 =?gb2312?B?MFAwdSs1eW94QXlYVjlNSzdLVjJxNEVuNzNkeitCU3hwMHhzaExESms4dXkr?=
 =?gb2312?B?L0VGem5DTktMY0VUc3huNHBvTkZieVdJRDU3TFZDVSs1L0N4b0IxOUgzUkJ6?=
 =?gb2312?B?emRHUTB4US9SMlphQVdieUhoYWFQT1V5QWVBRTA1SGt4SENFNjg4citrQ3dI?=
 =?gb2312?B?cjExZFArL25VelpkSkRnKyt4RUNEMjltcmtiQURWTm1Ic2JrN2VQbjBPanU0?=
 =?gb2312?B?aE1GeHBwVnBlUDFvVVRJRUpsQkNiOUx0dGFTVHdLejRkUU9DMjBhNCtpM1pT?=
 =?gb2312?B?eDhQdEtNUEV6OG1YbVIrcWlDK1h4SFBaNjE0MWhNbW9WTTF4OGRUWlZ6dTdp?=
 =?gb2312?B?cStYQm9EWW9mazRrOGVIZjhYZitJd2NHQzR2eW82VnZpWm53WjlWbEpKcGgz?=
 =?gb2312?Q?LgRU=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0367c651-41e7-459b-af18-08dd8c57fae2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 04:39:25.5639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2d+AJjpXIAzIifOltkCoWJgZBtzp1MTw2wp/ELfBgSXv42k3IgA9E/IYKs/+pz1e9EMDSNaP3RQ67S9EyrxiRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6139

TEdUTSwNCg0KQWNrZWQtYnk6IFlhbmd0YW8gTGkgPGZyYW5rLmxpQHZpdm8uY29tPg0KDQpUaHgs
DQpZYW5ndGFvDQo=

