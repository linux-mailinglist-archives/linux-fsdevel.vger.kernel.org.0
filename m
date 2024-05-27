Return-Path: <linux-fsdevel+bounces-20249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB288D0779
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 18:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7831DB27EF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 15:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A6C535A4;
	Mon, 27 May 2024 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="aEGgUda3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2127.outbound.protection.outlook.com [40.107.223.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928EC61FC0;
	Mon, 27 May 2024 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716824327; cv=fail; b=K6aoxPECx9bEt3dZMgtx34D+z6mjhArzJo/Yt6FbGAufTRWteftDPCfvmjETYZCyrNldEGnl/HaLwcPlfqRYZ2Vm/yUrQ1/xXPTOm8dL1UdAYZqDvuJKiK5f0Ds163slPFAjpXp8dMNekhZhfSym2cVpCHec9iix4uIg4642VgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716824327; c=relaxed/simple;
	bh=EO88UrOMAa9PhQZgj8BlHMBFiYAm7YASy4LLKzVG/kE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AebxhBMGptE/K+HgHWziqkJsv5fkmqK068HPYHZeK+6ei0ga0qDmmtDM00z8l8qmPZuforLH9aFQJNwwn/qMX4u6nEbberOHYCcwpCUc0MYPIydvp3QrQCFhiG/lkFrifBAJOWCtJmGEwHDEqUImUwsDI4Anc3zsA3hoX/9iDTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=aEGgUda3; arc=fail smtp.client-ip=40.107.223.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYIqy/4Ytq4qcMRcpezFJHcoGkEeSwoshm8zm/QvLXzhDafUxWKuLsKRpNZBlb3fyxWAF548tZEUl/74v4/XIn8zl1Ix/fHVy8YfQiOgL6tOHFT6wzpAqrrM8iY/09MOkXg0Z1B8sHAQYzkb5N2031Fr22ROi71x/zXnZTt3P+Lfpfw8/FmSDiYfqkOWr8HKue243pWbUHyFwVWPbnt5x473+1cGcloPRsVig+BLh0VX5tcCVm1elPP+RCDj2RRWKqhM92YXY54/5wB8mlKKEgzkb5uD1U0oqL8x8lUWl00hCYn8WpWCF4z5vkFqS2+OEB/c8Sw9guC+k8kt3jNx7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EO88UrOMAa9PhQZgj8BlHMBFiYAm7YASy4LLKzVG/kE=;
 b=BZHJh7jk9Bbm5HNslndDimP/cvQSBdvYKCRT4Z/Z+PspQ4prrqHqxtm+HgbbaJl3paGoZo93xmoGNQ/HUdYLOkD7rVuo9wa0CWUgnd+2ou8XFRx8kqvjpR2dX1kYG+KG0i5MKDUpUki5l6f1sKGvskQGQ8xBFnxbQVia4cNN+wggES7UGpN+XFTOq6z214UfXY1w9hy0FGBlkJlWuZhI4SOwhXGc6vbMXpSJ2j9OzgKydmk5ex3gqEHxZx/VRHzxSaMNcYx1kbWoWIzg3pwHC0HahsZiLKwL+nz/c3zz+IlzR/kgUNQkyTb4IXHVCI+NEIyHNHjNqSEihN/eGC4zKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EO88UrOMAa9PhQZgj8BlHMBFiYAm7YASy4LLKzVG/kE=;
 b=aEGgUda3umH2pXSkrc+z8dHzjGjhvT3iIDPMM5Klz74g+z6QUa49R4CxlO5/iQGBWClCKTda0h1qofFMy6ci1SXVoGCaAFBWKxBcl8lnrwU/l3e4QLwqOdOqRolwjl4e3Y6yZRvHF8JRulsb1cy9vFW62X/nYaq96fWF5oJ85q0=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 SN4PR13MB5294.namprd13.prod.outlook.com (2603:10b6:806:205::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.17; Mon, 27 May 2024 15:38:41 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871%6]) with mapi id 15.20.7633.001; Mon, 27 May 2024
 15:38:40 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "hch@infradead.org" <hch@infradead.org>
CC: "jack@suse.cz" <jack@suse.cz>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "brauner@kernel.org" <brauner@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alex.aring@gmail.com" <alex.aring@gmail.com>, "cyphar@cyphar.com"
	<cyphar@cyphar.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"jlayton@kernel.org" <jlayton@kernel.org>, "amir73il@gmail.com"
	<amir73il@gmail.com>, "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Thread-Topic: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Thread-Index: AQHarVPtSe6qdv/lgk2vl1eWJoqLMLGpQqoAgADb5wCAAN6NAIAAQB6A
Date: Mon, 27 May 2024 15:38:40 +0000
Message-ID: <86065f6a4f3d2f3d78f39e7a276a2d6e25bfbc9d.camel@hammerspace.com>
References: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
	 <ZlMADupKkN0ITgG5@infradead.org>
	 <30137c868039a3ae17f4ae74d07383099bfa4db8.camel@hammerspace.com>
	 <ZlRzNquWNalhYtux@infradead.org>
In-Reply-To: <ZlRzNquWNalhYtux@infradead.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|SN4PR13MB5294:EE_
x-ms-office365-filtering-correlation-id: 259e8b4e-8f68-4d33-a9a4-08dc7e631590
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|7416005|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?bkpoVGViN29EL3JKT0pjMDBXdnJtVWhwU2xHZjliMFpuWHBHMVVlWHRrS0xF?=
 =?utf-8?B?WE1MeGRJZU1ZZ2xTd0dqNkVQZWI1cFFKVWJDQkhTdTdFVkhGeGlGVXZzZmFw?=
 =?utf-8?B?eGYvWmZqVlZxUDFwMFJHMUNUSnM2eXM3cUw2YTI3MlVjck5IQkJScTZZcmUv?=
 =?utf-8?B?VThRYkdiR1BEMXZmUjR0UkZtc2FnNEs5UU0zdGJ2M21Cc0xRdjhmclA2ZkU3?=
 =?utf-8?B?d3JQaFZBR0Z2YXRsQ3EzR1pzbnpjaUtHS0R1MXdvT2tGd0JoY3lwZXk2NUc4?=
 =?utf-8?B?SUxhN3J6M2gzV1htdEhEREZWQlRyWld5RDhBa01BdHpobnU0bmxROFVnUllJ?=
 =?utf-8?B?ZWN0akpQMDFpMllpY0w2ZkNTcHd5NTNIV3NoUkg3MzlHYkJOak5JRUpFSnJO?=
 =?utf-8?B?d25mTlptVGNCR2I2ckdWYTNWRDVaS0REM0h4RzNpMGZEazFweFlJMTBGMWtE?=
 =?utf-8?B?ZGF5dVNiTWJnSk91NVM4NU1OYjVMMUJZMGZFS29ueFVwRjhBNnF3QjJ0K0pH?=
 =?utf-8?B?ekFLdzBJVjNEck0zb1ZoWlg0ZHNpQ2FOanRCRWhUWFJGY3ZlNksrS3dudlFr?=
 =?utf-8?B?Ykx4cHhjOFVxRTJQUnYrREplL203STB6aDg3eWZ2NXhITmlndE9hOUhWOXpD?=
 =?utf-8?B?Z201UFhXWlFZN2dkYVJmY1NQbDUwWjg0R21rdm1TdlRzbnNEc2d4UzhwZFJm?=
 =?utf-8?B?SXhxZTFDL2lqL3JEVlRuVStqNTNsTHNEQVpJbURwTW85Mkl1NklCNjBmbXBk?=
 =?utf-8?B?V2Fqd3Z1SWgxb3FrZk1jclpXODZNQW5FNmZiazFZSlE1K2J6VVNvMHNUNGpQ?=
 =?utf-8?B?akJLQVlqMFNWcy9PejcrRVNPVnUzalJFNTBLWmZ2WmpqUEhTS2UwUGFiUDB6?=
 =?utf-8?B?c0IyZ0dCWkMyZEFMTUFJVFR1dmpuMkhnR1hldmd3aG5ZN3UwMEVQWTVNZC8w?=
 =?utf-8?B?UkpNWFNwTlVhaVhFT3VZamZqM1ZQWVc5UGJKeUFrRnhqNjdDdU9ZUGU3YU9B?=
 =?utf-8?B?TWZIdy9xaGpGbysyay9DWEdmMjNHTXB3aURMeFVxRTMvOW9yZVVpMmFlWEtz?=
 =?utf-8?B?WmgyUlp2akpjWUZYQ004bFlYUG5mdmJqQzNlckd4TkxobFc1T0crd0FKazdu?=
 =?utf-8?B?RmQvUm1CZGt6anZNUFplZm1rbVdyM0NmVmNsWHV4T0VCdmwzdmxZZTREZlFz?=
 =?utf-8?B?cWN0L3ZENG52VVkyeFlIdjljME5LbU1hMVVndUZSQnk2cXM5VXBIZmpBTi90?=
 =?utf-8?B?ZlRvOVorVXlhOVZWNTZJcGJXWlRRQ2dIVmsyenJYazltcEpmNDdoanZRSWNl?=
 =?utf-8?B?Nzl3cEtJajBPcHVjcDVqY1h4eHAxazd1OXd3QU5xcmNzdzdBZFhqTEVROHN6?=
 =?utf-8?B?T3ZoYm9ndEp2MU8yazlaTXF3YytQY3c1bERKckRwaVNmUGdqOTBPSmJOdk1v?=
 =?utf-8?B?RVpZeUc4LzlERExieGtYUnUyYTBBeXBmUDdaK2NSZ2FwcjVRWUl2R2ErL2FY?=
 =?utf-8?B?RDdNek5YV25taXRuYVlSMzRpNksxYkh0cnpVaHgwNU9uUjJZNzJ0ZGJWQm5Z?=
 =?utf-8?B?SExXRDBJQUxVQ0o2bUd1aHRJWTF1TC8vaXBHeTZqY1hzVkMvWUlSOEM1Sjgv?=
 =?utf-8?B?MHlFWXhhUzJUZkhrZkVsM3gwRDQ1U3lOT2YvamNsWDJPWUJKMTYxQ3NmdnNv?=
 =?utf-8?B?Y0tFOUVQQW9tb3BLdlFNNXpsbzhiT3hDRG1Hc2FmeUxGSkU5RVBLVUt0KzBq?=
 =?utf-8?B?L2s2RzFNSzBOYnZWOGxzdXRWQ2JkTVBGclZLaGk4Y3BQUXRBalJyODZQS3Aw?=
 =?utf-8?B?b1puVmxNUjNrbDlHZU1CZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TG9uaXg3Vk5BaGtwN2Jqc0RINno0TVk5Z2tKS0hsTTZ6Nk1UdXNobmJaSGR5?=
 =?utf-8?B?Sms4UStlbWdGUnBoMk5sMDZmekRiOURYYmNlQ2wyL3lIYUtQYkZTSXZEcnRh?=
 =?utf-8?B?OXRyMGkwajV5OFdEbzh3VldTOEhPMlUrY2hMeFBLWGZUN3JIZ3MzakpZOGdu?=
 =?utf-8?B?Vm9xUy9rMHljMk1WQWFmayt0UXRBcTVYa28rb2lGVzRxZ2ROSnZGYStnZGEz?=
 =?utf-8?B?TVJ4eitHZ3Rnd0JnS1kwVkNtQVhhWlBVN0tnTERwaHRQQ0Q0bDYwWk9jWlNv?=
 =?utf-8?B?U0xkRnhoc2g1a3Vndk5VT1JCN1JtOTlpWlFpYzFPRmdCdVhKS1UzNG13elE0?=
 =?utf-8?B?QjlsTDZFbEFDRHZsazY2elRzTmxqQXcwY3Ezb1didVN0aXRGbzYzQjA0NHY3?=
 =?utf-8?B?REY0Z2FORFpibkVUS2hRdkg5ZjNRcmorR2ZFUEp2bEpHR2ZsWDVTd05DcS9G?=
 =?utf-8?B?Vm9JUFNCYXJCS1JOMHpBVC9ZZUs5aVZCdEFHRC9maVFMdlFWb010dnRvRHkv?=
 =?utf-8?B?TzhMaHBmMlJyT1Zac0xMMDNjT3d4aW5SUnNrL3paM2VIb1J4VzNiY21ZN0Qr?=
 =?utf-8?B?UFFFTHdQeHRZSG9waXJhL013bTZWUWRaRERSZVp4ZDhRdWxrOWhHUkxXQVRn?=
 =?utf-8?B?OEN6QVc0OFNsOFRETzNjOU9tSWxZVUJwVEN4WmlkUmovLzlUODVZU200cWNw?=
 =?utf-8?B?YkZzSEVLR29mNG4wTHVrVFN5UVpTY1Rpazl6KzYzZjNFVXFkb0RTWFg4YVg3?=
 =?utf-8?B?WTlrc2YxT2diQ2pSdGpxWG9YV3V3UmJTSnVwLzY3UlhiUFp6TXQ0V05ia01p?=
 =?utf-8?B?ZFpvd2hNUURLRVJFYzdjek8zbmt0alo3dEUxdlBLMHIwSXBXOEJ5NzY2UGU5?=
 =?utf-8?B?MnBPUDBEV0I3ODhVYUV2NnErYWdseVZiM0JVVk1acFR5alhFZGlyNi9JN0pG?=
 =?utf-8?B?K3o4d1R1clhvcWdhNVREMXNCL3J6R0p2b3lqNjMwK2EyS011cU55UWt4bUpX?=
 =?utf-8?B?bjFtdENHbnBVbEwrYTllRnhueUJBbVZ4UjIrM3FaTE9TZ3IyaEM2OXdNSHBv?=
 =?utf-8?B?ckFjNFNoeVp6ZHVkV0xSRnhoc0o1cXR5ZkQybHJjalNWblJHVWxMbTc0eGR0?=
 =?utf-8?B?L2dFbWxQeXBpL01aWnhpVDRRaVJUcjBLOU12S2J3YmErVTZtYlpaVUhpWnBC?=
 =?utf-8?B?bHkyc2RRekFNdnBHdkZqMjlMRFR3dDJUSnFDMkRZZlhrcHRNb1JFMVp3VHRC?=
 =?utf-8?B?ckJUUWdHRXNObFZmN3B5SlpjT0hlc2J0UHR0ZGg2Z3dXQ0N4SGtMMWxtdlk1?=
 =?utf-8?B?RDBhUThrQ2JrcS9ONzFQMkF1SjRROU5NTmtSc0NBVDVYL1llcXI0aU85Q3NY?=
 =?utf-8?B?NVZRZGdpNDlNUUhyL28wMEdmbStSQzZleTNpd1lCMExIQU5Udkw0WkRFVWZo?=
 =?utf-8?B?bVp6bTdUYjY2enEwcW9tU1lycmlYYUZsaE8rZTdVV0h3NFpaRVYrUXI3bG1Y?=
 =?utf-8?B?OGtkUzZWZ3A4TnNZTWh5ZWpWK3d2bzRMMlRwTU5BZWJGVHY2SlZBNndJZkJE?=
 =?utf-8?B?YzhjbStzb2RHU2owcVhHaUhUNjNrMTFYdHhiMkprdFBSRkJ1d1N0OFdLUWtG?=
 =?utf-8?B?WmdJNkY1d1NESXFWbFBMcXdjQ0dmRUh0MmV4ai9FR2xFcWVySG03NlNuTHVv?=
 =?utf-8?B?Y25SNXBCZVloRE52RFBnQVBSYnZMK2d6MjVQWGw4aEJFWGFQcWtuWlBtQkRP?=
 =?utf-8?B?TWVUT294UmJYTmhRKzZZTkRpejlSRldGVWlZNUhYSXdJVXVNcmY5cnFGNDl3?=
 =?utf-8?B?MlQxL3VSWXhXM3JqM0xBWUdXOVhIRU4yNytadnpYZUNqSWV0cjZydWs5Unly?=
 =?utf-8?B?dCtTUzV1OTZ3QnI2amhuVnlUSm1DUDJ0am8wMitpVnByTU9HQWNnUjJPdUx6?=
 =?utf-8?B?ZmE1NXVqZDNWZW9ubENMUmpscmRnb2ZaSm41THUrcS9PSElqeHE0N3JrNnI3?=
 =?utf-8?B?bnR2TFdPYWV6MlY3NVhIU0k3TStNM1NDOWNuejdwM3J0WlFvSE9nb3A4bTdE?=
 =?utf-8?B?SXIxYlUwcE1kZWEvZnhhU1k3TE1HUUxlNVdYT0I0a09UVzJoa01IbXM0RlZC?=
 =?utf-8?B?Q09YTSt2YVhBeWhtUHF2M2tuZjFmU041SDVITEVxejkzSkNBaUJCZVFrRmJG?=
 =?utf-8?B?M0Judll4empoVnAxQ0RVcW5FcjQrVWw1N3QwSXdCcXBab0Q3OG9jYWx2dGt3?=
 =?utf-8?B?SmlIcVZPT1d0S2RJei81QmEyMXRRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D4372EBFD71EF429CDE0D2B08EA8307@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 259e8b4e-8f68-4d33-a9a4-08dc7e631590
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 15:38:40.8162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4wVSQFRqBiBzcamGpnGjQwo4Ak/QMZ4hFFK7LItjZDq4HrDuwENHqXgA6k5KMi9LwAuJwttkcpWWU5r8yRzmhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5294

T24gTW9uLCAyMDI0LTA1LTI3IGF0IDA0OjQ5IC0wNzAwLCBoY2hAaW5mcmFkZWFkLm9yZyB3cm90
ZToNCj4gT24gU3VuLCBNYXkgMjYsIDIwMjQgYXQgMTA6MzI6MzlQTSArMDAwMCwgVHJvbmQgTXlr
bGVidXN0IHdyb3RlOg0KPiA+IEkgYXNzdW1lIHRoZSByZWFzb24gaXMgdG8gZ2l2ZSB0aGUgY2Fs
bGVyIGEgcmFjZSBmcmVlIHdheSB0byBmaWd1cmUNCj4gPiBvdXQNCj4gPiB3aGljaCBzdWJtb3Vu
dCB0aGUgcGF0aCByZXNvbHZlcyB0by4NCj4gDQo+IEJ1dCB0aGUgaGFuZGxlIG9wIGFyZSBnbG9i
YWwgdG8gdGhlIGZpbGUgc3lzdGVtcyAoYWthIHN1cGVyX2Jsb2NrKS7CoA0KPiBJdA0KPiBkb2Vz
IG5vdCBtYXR0ZXIgd2hhdCBtb3VudCB5b3UgdXNlIHRvIGFjY2VzcyBpdC4NCg0KU3VyZS4gSG93
ZXZlciBpZiB5b3UgYXJlIHByb3ZpZGluZyBhIHBhdGggYXJndW1lbnQsIHRoZW4gcHJlc3VtYWJs
eSB5b3UNCm5lZWQgdG8ga25vdyB3aGljaCBmaWxlIHN5c3RlbSAoYWthIHN1cGVyX2Jsb2NrKSBp
dCBldmVudHVhbGx5IHJlc29sdmVzDQp0by4NCg0KPiANCj4gU25pcCByYW5kb20gdGhpbmdzIGFi
b3V0IHVzZXJsYW5kIE5GUyBzZXJ2ZXJzIEkgY291bGRuJ3QgY2FyZSBsZXNzDQo+IGFib3V0Li4N
Cj4gDQoNCk15IHBvaW50IHdhcyB0aGF0IGF0IGxlYXN0IGZvciB0aGF0IGNhc2UsIHlvdSBhcmUg
YmV0dGVyIG9mZiB1c2luZyBhDQpmaWxlIGRlc2NyaXB0b3IgYW5kIG5vdCBoYXZpbmcgdG8gY2Fy
ZSBhYm91dCB0aGUgbW91bnQgaWQuDQoNCklmIHlvdXIgdXNlIGNhc2UgaXNuJ3QgTkZTIHNlcnZl
cnMsIHRoZW4gd2hhdCB1c2UgY2FzZSBhcmUgeW91DQp0YXJnZXRpbmcsIGFuZCBob3cgZG8geW91
IGV4cGVjdCB0aG9zZSBhcHBsaWNhdGlvbnMgdG8gdXNlIHRoaXMgQVBJPw0KDQotLSANClRyb25k
IE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

