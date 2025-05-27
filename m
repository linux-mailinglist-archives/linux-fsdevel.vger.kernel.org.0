Return-Path: <linux-fsdevel+bounces-49877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7335AC45BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 02:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED161899012
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 00:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CAF2F852;
	Tue, 27 May 2025 00:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="db6KZeBS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2097.outbound.protection.outlook.com [40.107.95.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D9C2DCBF0
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 00:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748307087; cv=fail; b=IuTX9+UD9tHXR5+b5LXNiiXIRJkQmWORtatbm52aVxm0Fk01XHqKSVaft7/WPSntSZ7n9DX56gaD/NskHxy6bvY/a7xmf7vdx31NB0WkRWUEYXVOBVIe8A7EesH1NqmOpf7+OX+T4+ysRO5W+iIzYdIIUJhUgvd+oa1b3uU3npM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748307087; c=relaxed/simple;
	bh=XdPoSK5jshJfejsF/MmE0hytTVQdkKlJuXUj9H8DhE0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YgBftlcZnZDVX3IVas61pGioEeQYevFfA3YPJL7BnvD9XPV8IIFehUH3Lud/7T+v9OLjUlhQVcocEWx4XlvgI4KRskr9ihQpB7GGq00e6THf/dXyKwjVofWSLuFZBEIq4J/JHEpvw54xx8npzlvaVulGUh1MRFnZLOsavFfc4MU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=db6KZeBS; arc=fail smtp.client-ip=40.107.95.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hOVPABEXjzMFiyCrCnwD0JBu9uKTeQdnhwAuxHkyCCAy6SFBxubvJwgR3XqR1rM2WVyhQ5j0xWYeecBgTtALKEwK0Nc9G3cdgsreVLCwFMGw2IJRhU+voPSfIGDxB86CSCPvRQxdtoUe+twaYtnBDi4aZtfCaDIPEkq5vGzrAqsoAXkOsiGAjF++rRA1cjn0R0aHJBswoK7QOKhC9T+psKDcf2Hr1GuylazkD/INknsE6P7Kl55ibeGdodhyLVVMkkJRN5TGSTJm/H3qDjLrw33zGbfKzY5tX3LfvF06CSsXJoi+cJgEL5imjZs3kb3ogN+tvteThmzCRRzuCJ8YSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdPoSK5jshJfejsF/MmE0hytTVQdkKlJuXUj9H8DhE0=;
 b=ll/TyeKlbuNtvMJMsKtZalm+WOJjxotOIc1TFUYZ7MO0IgaL7kNc5IaA2bmMaCMnXGAo0yUTR09MR0cvEEqFa1OwkB0sQ2xlIqwkh0HcIowo8uYvHtMTqieOkKGlJZtwJ7NWT3QJi+wtl1occrb3CYa/HWupb1kbrU77V2oKzSuLpjA2wegOFdFwNfLLONq3rWCxpF2jNbnlglChVfcTto6rILEqha4klwEk+WDF8srqnx/668MEHr1jqnG/CpelRIvc5M6iiZoBXDRtZmp9zCEVVL0tyqj5NQ+/x6A7ZpTTCRJ4JRKC7blGCb/kjsirgr2C0KWhQTna9Ir12bUMiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdPoSK5jshJfejsF/MmE0hytTVQdkKlJuXUj9H8DhE0=;
 b=db6KZeBSPOGvYU9DKSvgP7GEnI1GlHHqHW5Hqdl4VD2GklOIHD+bA1/NtHvj4yk888L4YTxFrriXB9f3TzLEgnCAZgDaUNT6fwcAxRhYi9WxlhjK+4gKCaYW9FmsKox3WTDVfHj02//iifCsDu2rydRnMGB/xCpYTHzTg5QZudw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3688.namprd13.prod.outlook.com (2603:10b6:610:9b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Tue, 27 May
 2025 00:51:21 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%7]) with mapi id 15.20.8769.021; Tue, 27 May 2025
 00:51:20 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "willy@infradead.org" <willy@infradead.org>, "jack@suse.cz"
	<jack@suse.cz>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "vbabka@suse.cz"
	<vbabka@suse.cz>
CC: "hch@lst.de" <hch@lst.de>, "djwong@kernel.org" <djwong@kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "torvalds@linux-foundation.org"
	<torvalds@linux-foundation.org>
Subject: Re: [BUG] regression from 974c5e6139db "xfs: flag as supporting
 FOP_DONTCACHE" (double free on page?)
Thread-Topic: [BUG] regression from 974c5e6139db "xfs: flag as supporting
 FOP_DONTCACHE" (double free on page?)
Thread-Index: AQHbzqF21gvSN5vjOUy7ZMDQ4DxyVw==
Date: Tue, 27 May 2025 00:51:20 +0000
Message-ID: <ba8a9805331ce258a622feaca266b163db681a10.camel@hammerspace.com>
References: <20250525083209.GS2023217@ZenIV>	 <20250525180632.GU2023217@ZenIV>
	 <40eeba97-a298-4ae1-9691-b5911ad00095@suse.cz>
	 <431cb497-b1ad-40a0-86b1-228b0b7490b9@kernel.dk>
	 <6741c978-98b1-4d6f-af14-017b66d32574@kernel.dk>
	 <3d123216-c412-4779-8461-b6691d7cafc7@kernel.dk>
In-Reply-To: <3d123216-c412-4779-8461-b6691d7cafc7@kernel.dk>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CH2PR13MB3688:EE_
x-ms-office365-filtering-correlation-id: 3e67503a-a602-40e0-f685-08dd9cb898bb
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dk5HZXZ5Zm93SEdzalJ5UkRGcU1wY3RKNFdEL0tKRG5OSnNWcTU0UmpUaWJJ?=
 =?utf-8?B?ZXZYOG5ra3RiUGxsQ29Eb3BieXBlQzZ2U0dkOFhjYWxzTHVvQ1NYUGZzV1Fa?=
 =?utf-8?B?bXhxRXhXV00xUVozMndmYzlYeHhFQ2U2SjBSSzJVaXlwNjFERHFHVjBJRW53?=
 =?utf-8?B?Uy9nY2pBZEFRRkpINDVNay9TS3I4Nk0xUEFjVVJyWkp1ck4zWUhUeEEzTmxR?=
 =?utf-8?B?ZkRvQ0ZIMTEybmFIdjBCLzMxTGtUQURPWVRBWWVPSEdCQlU2L3k3V0NZZ3Nm?=
 =?utf-8?B?Z2cwOVIrbVF0YkMwS3ZvYjFnU3FMdzFRVUlMYUhZaThZcWF3S0dZdWdkZmRt?=
 =?utf-8?B?TEM4MEtPNUdmb2lxd1RwSTVvcHQyY0FNcWUwdS9iNzhvN3FGRHZIcllyYy9Z?=
 =?utf-8?B?QkRZczg1RGlDY0M4cXllZ2puT1lrSVdRdDM4T0U4Rk9rN1c0eHhicHZ4OXlw?=
 =?utf-8?B?Wk42V3M0MlN3WFV2MklOTXVTdmlBK1ZBQWlzNFdBb2EwZTZnYlZ2Y0hZWkJo?=
 =?utf-8?B?ZTZIeVpOK1RBeDZmRHNQT0tiWWZ0eGN5SS9oNFE2ejlmUVkxOTdoQ1FXbG56?=
 =?utf-8?B?M3lwc01vbXVQY2hZRzMrWGVnQ0JDNW55d3JlR3lUcnp6VVNTaU54bjRVVWx2?=
 =?utf-8?B?MHgrRnBjZllNeVlrL2NOa0FWcXFhbUt3UmR0QXRySGFzWkR5MGMyeVAyRVh5?=
 =?utf-8?B?RHd1M3R3TWh0TVdHTFRYMVBVRUhrM2RjUVZPb1doUEpZUnRzeFB1cHF1VVdE?=
 =?utf-8?B?OU9tUCsvekJLWTZBNUUvK3EzUnpOMkdmR2lvMlVVVC8vQjUvNTRGWXA4Wjh1?=
 =?utf-8?B?RXNGQkF4YUtrMHZvVnZUYWd5SUJYL21hM1RiZ1Z6eGtLYmZFbXF5ZzZDaGp3?=
 =?utf-8?B?ejhrZXJ4RUFWWmk5TkMxNDNrTXEvU0tMd3Rwd3ZaU3Bhb0c0N21uSE5IRGZj?=
 =?utf-8?B?T003RXhtUWZnOXhvWWt2UXBtRVlRVEdxbHdNL2E4OU54UDBGOHBrT005Wm9j?=
 =?utf-8?B?UHI1dDZ0SmovNFAxeEJxK2R3SWFLKzQ1OVdKNHlCWm1KVzFzZjh4MndyWldX?=
 =?utf-8?B?VUVkVjRQa1JTS1VXdC9qUDZ2cnJVcG40Y0pZL2ZjOFBwalFEVnZvSURXZ3Za?=
 =?utf-8?B?WTBYZHVBUTRjSEpEK0UrajQvanRQL3JHcGZGK2JuTjBQZjhpS3FjR0g2VCt3?=
 =?utf-8?B?NHlnbEVUVDV2bW43eXFLK1ZQRWE1Q2pvbUVyeHdZSC90bFBwdEhkOExEeklu?=
 =?utf-8?B?SkdvUzY2WUZOT1pFOU9RaVlvYnYxbWJsdGp6d1o1cGY2dmxZL3ZKQzVmbllE?=
 =?utf-8?B?R01tOUFYYjY3UURvby83a3hCeldLTTBJSk1nL05YSHNnMVFSMklpZ2lMZHFw?=
 =?utf-8?B?L3dWNjFNVnYxcnBzQW5yVXZiYjVhKzdUR1hUWGVyZnZSaXUzZnBPSHJxWTRh?=
 =?utf-8?B?eVNFYTV3MFRBcTRMNFJaZXIrN0V3NkVwc2svQ2phVUh1cHlrK3B4ZlExYWFH?=
 =?utf-8?B?eTQ4V0tpSVYxdGFtWm9BNjNaNVVnVUREeEFCVUpYZkJBMUVFS1ExZmVuNUxK?=
 =?utf-8?B?QUVpWTJBMTh0TmxuZXlhV0J5V3ZiTzVKWk8rWDdsdlM5c1Z2MmcrSXBRYjAz?=
 =?utf-8?B?NnRSSS95K0JvUjNuUmlOT0dRRjZrYVBmRE5GUGFxeWdkK3dLUHd4NThHdEZB?=
 =?utf-8?B?ZGhLNWZaYVJidEcvbnhJd3dQN1UxbzJpcWtzcFlweStRY2szYk9pL0lyMDVq?=
 =?utf-8?B?TE1udFFyeEUrUWdKWVgzYzFmYTRwVmdIQ0dFMy9zVUtTT1JoeHBNNWVkNGh1?=
 =?utf-8?B?VVE2RndqQmRlOVIrbFNpNmowMjdTOS9WV29zMWdUOFNzOGpGdk9IcVBINmhi?=
 =?utf-8?B?b25Lb3JwUXYrbFMwL2NabENCZm8wWDhRVTU4QWNDRXU5d1R2ZEhzemJLUW1D?=
 =?utf-8?B?SE5iR1dSRlJYQUtnOE1DUmhzUWlBWUhUNjkwaUdEY3llbjVTb0lkYThwVzRs?=
 =?utf-8?Q?vBeZu2OiKTzUZjHtM9cBUaNNx7xz0s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OEVUTVcrdjhKMnJzanlQbTFEMUtyclBXK1BUTCtka1NIQ0I1ZExRcTZvTll4?=
 =?utf-8?B?N2R0UVEwckpZTTVTN1BaVElET1pVcWlTVmV1RjBweVViNTIxdDlEVVpGNksw?=
 =?utf-8?B?N1UwUFNQM1NtcjVLNmNFUDJ1bFNtcWMySm9mdFlmR01mZllZQ0FOZmRwblhU?=
 =?utf-8?B?Uno0dXZPTmdZVDBGcWg2UlE1b2FKZ3VUZTBVaTBkMTV5UkNvMGNUQS9RUWI1?=
 =?utf-8?B?Rm9LZmlVeS9yVm1NWkRuK1g0M0taVDhHVHU2Mi84YzJreTBNZEoxb3FDMzBx?=
 =?utf-8?B?YldRcmJwK1ZYQkwzUG56UmxRTnEyN2xINmdYWGZSQVVCQWhQaTZ5TjgwNHZB?=
 =?utf-8?B?ZmM2NXlYaXFQZTcxNllmcDlLelgwU1lSM1JudGpldmVwOEJrb0NibjhiUWFl?=
 =?utf-8?B?QjJDZjFqU213Y2VpbUEvbTdQQmc1RzlsaUFXVG5SYWZxdXBrRnVhbzdNVjht?=
 =?utf-8?B?U2d2QVBNQmtTZGszTHByMFdZeG5aZnpJN011bFhjSHI0S2l5Ui9FRjdsa3RG?=
 =?utf-8?B?QUNqL0tHVFc0ZDBsaXJpeUU2QzY1K1lWVDNYL2ZiUkViVTVNRHRwVk91ZUsv?=
 =?utf-8?B?YWVDcm1za2d0R0hKTWpXOWsxN1lJbWFsU1V6ZTBMdzUvb3Y0VDRMQzZtb3NN?=
 =?utf-8?B?SWkzRE16dTY3TDY5TmpXWElvMUxnd1ZFdFBQbW1jYXZJRk4vSHNWMUpZWGdQ?=
 =?utf-8?B?TE5QcHdudmRzRW9UcnBhdVFZVnhSWEx5VjJZOWFuVFVVbW96eHYrSDMrckdq?=
 =?utf-8?B?QVp2YWF4cmhkVUtPQVk2V1drWkVsNW1URkIxZ05OMW56eFFnSGtNWGpWcHJV?=
 =?utf-8?B?ZmVyNEZlYXh2TURvNnlYUCtGUlo4TDZiTnFSUFFJUDFwZjh3N0M3Q0o0eWRY?=
 =?utf-8?B?enVFeEZNd0lKNWhYZWdkVndnMVNhYVlCNjJYVlVSbTNTOCt5SWhMSnV4UE9N?=
 =?utf-8?B?RmpwelJHK2hucDhSVUgzR0cwK3JZQm5CUU02UWhyZzY2eXgrSmFNdkVBUzIw?=
 =?utf-8?B?Nk5kd3NNL3AxT001S0IrYjlEZ3MrdmN4SUFidGw2OG5FUnNlbVpxcll5U0tm?=
 =?utf-8?B?TTVCZXRNeCtNWmdHKzlRVGM2c250eVVad0NobGhJUjZucmZHamdjYklCajVH?=
 =?utf-8?B?aC9Qa2xod3ZVeW5vdUFDa055YkhnRkRLMmdya0NDclM3T3I0VVdVYXd5R2hn?=
 =?utf-8?B?dXRlamFLUHhFdVQzNFlRdEM3U1d4R0VxZTZTYzRaVTNwaWpxdGdtYm9vektF?=
 =?utf-8?B?SGVlNFpWbmF2WnBFVlJxOFA0VVdRMmZ6OXlpeUw3T0xOT0FJKzdNUDVqc21B?=
 =?utf-8?B?RUQ5MG13UWVJNlBXT21hVWZyOXpHaEFlci9wTDBPQ0lyejZlNnZHaUU2cXhY?=
 =?utf-8?B?QmRJTUF2UEk2OW5IYjVWamJUOUZYMVVpTHVId1FFSVBXM3phRndvVFArSGtL?=
 =?utf-8?B?TlBUeDdrak82UjJrMStxR1pBSU1Tb0MzRzFYVmdYU3luZ0xLaWlITE5tbFpN?=
 =?utf-8?B?Q2VSc2EycFBHZTBKS1pMTnNCTkplNjZ3MEcyWkh1SlptTG9pSTljU0Z5Y2RG?=
 =?utf-8?B?TTZGUFJwZDZZOVRZd3pYOGdXZEZncCsyTzRmc3dkbWQyRk5jWlpxZDdTcEtH?=
 =?utf-8?B?bWc0MzdJaGRUSUY0cFhXdVhGamFrdG9Ja3h3QlBnaExqaSt5R1d6TGdFZEE1?=
 =?utf-8?B?aFpYUFVNSGZHUjFrdzZGejFzNmkyb2swc28zM3gvWHFSYUhCN3dUZTN2N0tM?=
 =?utf-8?B?a3g2K0RxYXk5S2xDYUdPeXRiNUkwQzVIK1lBM1htMmZzZnhBcm95RE13Q3Vo?=
 =?utf-8?B?Z3g5YmdsU040SmJFcEN6dFRJKzRFdUZ1a3pWWkQvb2RvUnhKdUY0QlczYkRq?=
 =?utf-8?B?NHZ3M0JTLzZFWnM0QU5TaGZFa2J6Um5wZWI2elBYQ3I4WUFSSU5LWmZQWEx3?=
 =?utf-8?B?eE9MbTUwanFGVFhhZ2plY0FEaFh4b2VpQ1VTcXdEb3dscUthRXpkcDdvdWhD?=
 =?utf-8?B?a0JwMFVqR0NEak1ORXZ0dDY5YXo2TXdkejYyeWpXL1JrVVZNK3BQMnh5Z1hF?=
 =?utf-8?B?YitLZTQ3YXBJNXZLcHZaVGNuWklNaUc5S2Q5UzhjSEUzL1BIdVJGL2Q4NTVB?=
 =?utf-8?B?TTZtdHR1TndHb1d0ZzZsY1FoUmJuMlNIMmIyYnIzN21QTG93WDN5V28ycUxl?=
 =?utf-8?B?cU5kM0tpazBQb05aMmExZUpUdWprWklVTDFaNU5lVkZVVE5vNDhqaHRzT0VB?=
 =?utf-8?B?cE4zYk9aWm9CR3Z5VDF2Z3drdVFBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <986755A2436560419CDF6B6C3547578A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e67503a-a602-40e0-f685-08dd9cb898bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 00:51:20.6729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kDYe4H2USj5MpyvqbxgqgcKsnHqpvmmSBF8OY76VcdDYvtC+KFYX1WUf0hmnMrzp8XsQai0+73pa941O/HYgLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3688

T24gTW9uLCAyMDI1LTA1LTI2IGF0IDExOjM4IC0wNjAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBP
biA1LzI2LzI1IDk6MDYgQU0sIEplbnMgQXhib2Ugd3JvdGU6DQo+ID4gT24gNS8yNi8yNSA3OjA1
IEFNLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiA+ID4gT24gNS8yNS8yNSAxOjEyIFBNLCBWbGFzdGlt
aWwgQmFia2Egd3JvdGU6DQo+ID4gPiA+IE9uIDUvMjUvMjUgODowNiBQTSwgQWwgVmlybyB3cm90
ZToNCj4gPiA+ID4gPiBPbiBTdW4sIE1heSAyNSwgMjAyNSBhdCAwOTozMjowOUFNICswMTAwLCBB
bCBWaXJvIHdyb3RlOg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gQnJlYWthZ2UgaXMgc3RpbGwg
cHJlc2VudCBpbiB0aGUgY3VycmVudCBtYWlubGluZSA7LS8NCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiBXaXRoIENPTkZJR19ERUJVR19WTSBvbiB0b3Agb2YgcGFnZWFsbG9jIGRlYnVnZ2luZzoNCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBbIDE0MzQuOTkyODE3XSBydW4gZnN0ZXN0cyBnZW5lcmljLzEy
NyBhdCAyMDI1LTA1LTI1DQo+ID4gPiA+ID4gMTE6NDY6MTFnDQo+ID4gPiA+ID4gWyAxNDQ4Ljk1
NjI0Ml0gQlVHOiBCYWQgcGFnZSBzdGF0ZSBpbiBwcm9jZXNzIGt3b3JrZXIvMjoxwqANCj4gPiA+
ID4gPiBwZm46MTEyY2IwZw0KPiA+ID4gPiA+IFsgMTQ0OC45NTY4NDZdIHBhZ2U6IHJlZmNvdW50
OjAgbWFwY291bnQ6MA0KPiA+ID4gPiA+IG1hcHBpbmc6MDAwMDAwMDAwMDAwMDAwMCBpbmRleDow
eDNlIHBmbjoweDExMmNiMGcNCj4gPiA+ID4gPiBbIDE0NDguOTU3NDUzXSBmbGFnczoNCj4gPiA+
ID4gPiAweDgwMDAwMDAwMDAwMDAwMGUocmVmZXJlbmNlZHx1cHRvZGF0ZXx3cml0ZWJhY2t8em9u
ZT0yKWcNCj4gPiA+ID4gDQo+ID4gPiA+IEl0IGRvZXNuJ3QgbGlrZSB0aGUgd3JpdGViYWNrIGZs
YWcuDQo+ID4gPiA+IA0KPiA+ID4gPiA+IFsgMTQ0OC45NTc4NjNdIHJhdzogODAwMDAwMDAwMDAw
MDAwZSBkZWFkMDAwMDAwMDAwMTAwDQo+ID4gPiA+ID4gZGVhZDAwMDAwMDAwMDEyMiAwMDAwMDAw
MDAwMDAwMDAwZw0KPiA+ID4gPiA+IFsgMTQ0OC45NTgzMDNdIHJhdzogMDAwMDAwMDAwMDAwMDAz
ZSAwMDAwMDAwMDAwMDAwMDAwDQo+ID4gPiA+ID4gMDAwMDAwMDBmZmZmZmZmZiAwMDAwMDAwMDAw
MDAwMDAwZw0KPiA+ID4gPiA+IFsgMTQ0OC45NTg4MzNdIHBhZ2UgZHVtcGVkIGJlY2F1c2U6IFBB
R0VfRkxBR1NfQ0hFQ0tfQVRfRlJFRQ0KPiA+ID4gPiA+IGZsYWcocykgc2V0Zw0KPiA+ID4gPiA+
IFsgMTQ0OC45NTkzMjBdIE1vZHVsZXMgbGlua2VkIGluOiB4ZnMgYXV0b2ZzNCBmdXNlIG5mc2QN
Cj4gPiA+ID4gPiBhdXRoX3JwY2dzcyBuZnNfYWNsIG5mcyBsb2NrZCBncmFjZSBzdW5ycGMgbG9v
cCBlY3J5cHRmcw0KPiA+ID4gPiA+IDlwbmV0X3ZpcnRpbyA5cG5ldCBuZXRmcyBldmRldiBwY3Nw
a3Igc2cgYnV0dG9uIGV4dDQgamJkMg0KPiA+ID4gPiA+IGJ0cmZzIGJsYWtlMmJfZ2VuZXJpYyB4
b3IgemxpYl9kZWZsYXRlIHJhaWQ2X3BxIHpzdGRfY29tcHJlc3MNCj4gPiA+ID4gPiBzcl9tb2Qg
Y2Ryb20gYXRhX2dlbmVyaWMgYXRhX3BpaXggcHNtb3VzZSBzZXJpb19yYXcgaTJjX3BpaXg0DQo+
ID4gPiA+ID4gaTJjX3NtYnVzIGxpYmF0YSBlMTAwMGcNCj4gPiA+ID4gPiBbIDE0NDguOTYwODc0
XSBDUFU6IDIgVUlEOiAwIFBJRDogMjYxNCBDb21tOiBrd29ya2VyLzI6MSBOb3QNCj4gPiA+ID4g
PiB0YWludGVkIDYuMTQuMC1yYzErICM3OGcNCj4gPiA+ID4gPiBbIDE0NDguOTYwODc4XSBIYXJk
d2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKw0KPiA+ID4gPiA+IFBJSVgsIDE5
OTYpLCBCSU9TIDEuMTYuMi1kZWJpYW4tMS4xNi4yLTEgMDQvMDEvMjAxNGcNCj4gPiA+ID4gPiBb
IDE0NDguOTYwODc5XSBXb3JrcXVldWU6IHhmcy1jb252L3NkYjEgeGZzX2VuZF9pbyBbeGZzXWcN
Cj4gPiA+ID4gPiBbIDE0NDguOTYwOTM4XSBDYWxsIFRyYWNlOmcNCj4gPiA+ID4gPiBbIDE0NDgu
OTYwOTM5XcKgIDxUQVNLPmcNCj4gPiA+ID4gPiBbIDE0NDguOTYwOTQwXcKgIGR1bXBfc3RhY2tf
bHZsKzB4NGYvMHg2MGcNCj4gPiA+ID4gPiBbIDE0NDguOTYwOTUzXcKgIGJhZF9wYWdlKzB4NmYv
MHgxMDBnDQo+ID4gPiA+ID4gWyAxNDQ4Ljk2MDk1N13CoCBmcmVlX2Zyb3plbl9wYWdlcysweDQ3
MS8weDY0MGcNCj4gPiA+ID4gPiBbIDE0NDguOTYwOTU4XcKgIGlvbWFwX2ZpbmlzaF9pb2VuZCsw
eDE5Ni8weDNjMGcNCj4gPiA+ID4gPiBbIDE0NDguOTYwOTYzXcKgIGlvbWFwX2ZpbmlzaF9pb2Vu
ZHMrMHg4My8weGMwZw0KPiA+ID4gPiA+IFsgMTQ0OC45NjA5NjRdwqAgeGZzX2VuZF9pb2VuZCsw
eDY0LzB4MTQwIFt4ZnNdZw0KPiA+ID4gPiA+IFsgMTQ0OC45NjEwMDNdwqAgeGZzX2VuZF9pbysw
eDkzLzB4YzAgW3hmc11nDQo+ID4gPiA+ID4gWyAxNDQ4Ljk2MTAzNl3CoCBwcm9jZXNzX29uZV93
b3JrKzB4MTUzLzB4MzkwZw0KPiA+ID4gPiA+IFsgMTQ0OC45NjEwNDRdwqAgd29ya2VyX3RocmVh
ZCsweDJhYi8weDNiMGcNCj4gPiA+ID4gPiBbIDE0NDguOTYxMDQ1XcKgID8gcmVzY3Vlcl90aHJl
YWQrMHg0NzAvMHg0NzBnDQo+ID4gPiA+ID4gWyAxNDQ4Ljk2MTA0N13CoCBrdGhyZWFkKzB4Zjcv
MHgyMDBnDQo+ID4gPiA+ID4gWyAxNDQ4Ljk2MTA0OF3CoCA/IGt0aHJlYWRfdXNlX21tKzB4YTAv
MHhhMGcNCj4gPiA+ID4gPiBbIDE0NDguOTYxMDQ5XcKgIHJldF9mcm9tX2ZvcmsrMHgyZC8weDUw
Zw0KPiA+ID4gPiA+IFsgMTQ0OC45NjEwNTNdwqAgPyBrdGhyZWFkX3VzZV9tbSsweGEwLzB4YTBn
DQo+ID4gPiA+ID4gWyAxNDQ4Ljk2MTA1NF3CoCByZXRfZnJvbV9mb3JrX2FzbSsweDExLzB4MjBn
DQo+ID4gPiA+ID4gWyAxNDQ4Ljk2MTA1OF3CoCA8L1RBU0s+Zw0KPiA+ID4gPiA+IFsgMTQ0OC45
NjExNTVdIERpc2FibGluZyBsb2NrIGRlYnVnZ2luZyBkdWUgdG8ga2VybmVsIHRhaW50Zw0KPiA+
ID4gPiA+IFsgMTQ0OC45Njk1NjldIHBhZ2U6IHJlZmNvdW50OjAgbWFwY291bnQ6MA0KPiA+ID4g
PiA+IG1hcHBpbmc6MDAwMDAwMDAwMDAwMDAwMCBpbmRleDoweDNlIHBmbjoweDExMmNiMGcNCj4g
PiA+ID4gDQo+ID4gPiA+IHNhbWUgcGZuLCBzYW1lIHN0cnVjdCBwYWdlDQo+ID4gPiA+IA0KPiA+
ID4gPiA+IFsgMTQ0OC45NzAwMjNdIGZsYWdzOg0KPiA+ID4gPiA+IDB4ODAwMDAwMDAwMDAwMDAw
ZShyZWZlcmVuY2VkfHVwdG9kYXRlfHdyaXRlYmFja3x6b25lPTIpZw0KPiA+ID4gPiA+IFsgMTQ0
OC45NzA2NTFdIHJhdzogODAwMDAwMDAwMDAwMDAwZSBkZWFkMDAwMDAwMDAwMTAwDQo+ID4gPiA+
ID4gZGVhZDAwMDAwMDAwMDEyMiAwMDAwMDAwMDAwMDAwMDAwZw0KPiA+ID4gPiA+IFsgMTQ0OC45
NzEyMjJdIHJhdzogMDAwMDAwMDAwMDAwMDAzZSAwMDAwMDAwMDAwMDAwMDAwDQo+ID4gPiA+ID4g
MDAwMDAwMDBmZmZmZmZmZiAwMDAwMDAwMDAwMDAwMDAwZw0KPiA+ID4gPiA+IFsgMTQ0OC45NzE4
MTJdIHBhZ2UgZHVtcGVkIGJlY2F1c2U6DQo+ID4gPiA+ID4gVk1fQlVHX09OX0ZPTElPKCgodW5z
aWduZWQgaW50KSBmb2xpb19yZWZfY291bnQoZm9saW8pICsgMTI3dQ0KPiA+ID4gPiA+IDw9IDEy
N3UpKWcNCj4gPiA+ID4gPiBbIDE0NDguOTcyNDkwXSAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0t
LS0tLS0tLS0tLS1nDQo+ID4gPiA+ID4gWyAxNDQ4Ljk3Mjg0MV0ga2VybmVsIEJVRyBhdCAuL2lu
Y2x1ZGUvbGludXgvbW0uaDoxNDU1IWcNCj4gPiA+ID4gDQo+ID4gPiA+IHRoaXMgaXMgZm9saW9f
Z2V0KCkgbm90aWNpbmcgcmVmY291bnQgaXMgMCwgc28gYSB1c2UtYWZ0ZXINCj4gPiA+ID4gZnJl
ZSwgYmVjYXVzZQ0KPiA+ID4gPiB3ZSBhbHJlYWR5IHRyaWVkIHRvIGZyZWUgdGhlIHBhZ2UgYWJv
dmUuDQo+ID4gPiA+IA0KPiA+ID4gPiBJJ20gbm90IGZhbWlsaWFyIHdpdGggdGhpcyBjb2RlIHRv
byBtdWNoLCBidXQgSSBzdXNwZWN0IHByb2JsZW0NCj4gPiA+ID4gd2FzDQo+ID4gPiA+IGludHJv
ZHVjZWQgYnkgY29tbWl0IGZiN2QzYmM0MTQ5MzkgKCJtbS9maWxlbWFwOiBkcm9wDQo+ID4gPiA+
IHN0cmVhbWluZy91bmNhY2hlZA0KPiA+ID4gPiBwYWdlcyB3aGVuIHdyaXRlYmFjayBjb21wbGV0
ZXMiKSBhbmQgb25seSAobW9yZSkgZXhwb3NlZCBoZXJlLg0KPiA+ID4gPiANCj4gPiA+ID4gc28g
aW4gZm9saW9fZW5kX3dyaXRlYmFjaygpIHdlIGhhdmUNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqAg
aWYgKF9fZm9saW9fZW5kX3dyaXRlYmFjayhmb2xpbykpDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBmb2xpb193YWtlX2JpdChmb2xpbywgUEdfd3JpdGViYWNrKTsNCj4g
PiA+ID4gDQo+ID4gPiA+IGJ1dCBjYWxsaW5nIHRoZSBmb2xpb19lbmRfZHJvcGJlaGluZF93cml0
ZSgpIGRvZXNuJ3QgZGVwZW5kIG9uDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiByZXN1bHQgb2YgX19m
b2xpb19lbmRfd3JpdGViYWNrKCkNCj4gPiA+ID4gdGhpcyBzZWVtcyByYXRoZXIgc3VzcGljaW91
cw0KPiA+ID4gPiANCj4gPiA+ID4gSSB0aGluayBpZiBfX2ZvbGlvX2VuZF93cml0ZWJhY2soKSB3
YXMgdHJ1ZSB0aGVuIFBHX3dyaXRlYmFjaw0KPiA+ID4gPiB3b3VsZCBiZQ0KPiA+ID4gPiBjbGVh
cmVkIGFuZCB0aHVzIHdlJ2Qgbm90IHNlZSB0aGUgUEFHRV9GTEFHU19DSEVDS19BVF9GUkVFDQo+
ID4gPiA+IGZhaWx1cmUuDQo+ID4gPiA+IEluc3RlYWQgd2UgZG8gYSBwcmVtYXR1cmUgZm9saW9f
ZW5kX2Ryb3BiZWhpbmRfd3JpdGUoKSBkcm9wcGluZw0KPiA+ID4gPiBhIHBhZ2UNCj4gPiA+ID4g
cmVmIGFuZCB0aGVuIHRoZSBmaW5hbCBmb2xpb19wdXQoKSBpbiBmb2xpb19lbmRfd3JpdGViYWNr
KCkNCj4gPiA+ID4gZnJlZXMgdGhlDQo+ID4gPiA+IHBhZ2UgYW5kIHNwbGF0cyBvbiB0aGUgUEdf
d3JpdGViYWNrLiBUaGVuIHRoZSBmb2xpbyBpcw0KPiA+ID4gPiBwcm9jZXNzZWQgYWdhaW4NCj4g
PiA+ID4gaW4gdGhlIGZvbGxvd2luZyBpdGVyYXRpb24gb2YgaW9tYXBfZmluaXNoX2lvZW5kKCkg
YW5kIHNwbGF0cw0KPiA+ID4gPiBvbiB0aGUNCj4gPiA+ID4gcmVmY291bnQtYWxyZWFkeS16ZXJv
Lg0KPiA+ID4gPiANCj4gPiA+ID4gU28gSSB0aGluayBmb2xpb19lbmRfZHJvcGJlaGluZF93cml0
ZSgpIHNob3VsZCBvbmx5IGJlIGRvbmUNCj4gPiA+ID4gd2hlbg0KPiA+ID4gPiBfX2ZvbGlvX2Vu
ZF93cml0ZWJhY2soKSB3YXMgdHJ1ZS4gTW9zdCBsaWtlbHkgZXZlbiB0aGUNCj4gPiA+ID4gZm9s
aW9fdGVzdF9jbGVhcl9kcm9wYmVoaW5kKCkgc2hvdWxkIGJlIHRpZWQgdG8gdGhhdCwgb3Igd2UN
Cj4gPiA+ID4gY2xlYXIgaXQgdG9vDQo+ID4gPiA+IGVhcmx5IGFuZCB0aGVuIG5ldmVyIGFjdCB1
cG9uIGl0IGxhdGVyPw0KPiA+ID4gDQo+ID4gPiBUaGFua3MgZm9yIHRha2luZyBhIGxvb2sgYXQg
dGhpcyEgSSB0cmllZCB0byByZXByb2R1Y2UgdGhpcyB0aGlzDQo+ID4gPiBtb3JuaW5nDQo+ID4g
PiBhbmQgZmFpbGVkIG1pc2VyYWJseS4gSSB0aGVuIGluamVjdGVkIGEgZGVsYXkgZm9yIHRoZSBh
Ym92ZSBjYXNlLA0KPiA+ID4gYW5kIGl0DQo+ID4gPiBkb2VzIGluZGVlZCB0aGVuIHRyaWdnZXIg
Zm9yIG1lLiBTbyBmYXIsIHNvIGdvb2QuDQo+ID4gPiANCj4gPiA+IEkgYWdyZWUgd2l0aCB5b3Vy
IGFuYWx5c2lzLCB3ZSBzaG91bGQgb25seSBiZSBkb2luZyB0aGUNCj4gPiA+IGRyb3BiZWhpbmQg
Zm9yIGENCj4gPiA+IG5vbi16ZXJvIHJldHVybiBmcm9tIF9fZm9saW9fZW5kX3dyaXRlYmFjaygp
LCBhbmQgdGhhdCBpbmNsdWRlcw0KPiA+ID4gdGhlDQo+ID4gPiB0ZXN0X2FuZF9jbGVhciB0byBh
dm9pZCBkcm9wcGluZyB0aGUgZHJvcC1iZWhpbmQgc3RhdGUuIEJ1dCB3ZQ0KPiA+ID4gYWxzbyBu
ZWVkDQo+ID4gPiB0byBjaGVjay9jbGVhciB0aGlzIHN0YXRlIHByZSBfX2ZvbGlvX2VuZF93cml0
ZWJhY2soKSwgd2hpY2ggdGhlbg0KPiA+ID4gcHV0cw0KPiA+ID4gdXMgaW4gYSBzcG90IHdoZXJl
IGl0IG5lZWRzIHRvIHBvdGVudGlhbGx5IGJlIHJlLXNldC4gV2hpY2ggZmFpbHMNCj4gPiA+IHBy
ZXR0eQ0KPiA+ID4gcmFjeS4uLg0KPiA+ID4gDQo+ID4gPiBJJ2xsIHBvbmRlciB0aGlzIGEgYml0
LiBHb29kIHRoaW5nIGZzeCBnb3QgUldGX0RPTlRDQUNIRSBzdXBwb3J0LA0KPiA+ID4gb3IgSQ0K
PiA+ID4gc3VzcGVjdCB0aGlzIHdvdWxkJ3ZlIHRha2VuIGEgd2hpbGUgdG8gcnVuIGludG8uDQo+
ID4gDQo+ID4gVG9vayBhIGNsb3NlciBsb29rLi4uIEkgbWF5IGJlIHNtb2tpbmcgc29tZXRoaW5n
IGdvb2QgaGVyZSwgYnV0IEkNCj4gPiBkb24ndA0KPiA+IHNlZSB3aGF0IHRoZSBfX2ZvbGlvX2Vu
ZF93cml0ZWJhY2soKSgpIHJldHVybiB2YWx1ZSBoYXMgdG8gZG8gd2l0aA0KPiA+IHRoaXMNCj4g
PiBhdCBhbGwuIFJlZ2FyZGxlc3Mgb2Ygd2hhdCBpdCByZXR1cm5zLCBpdCBzaG91bGQndmUgY2xl
YXJlZA0KPiA+IFBHX3dyaXRlYmFjaywgYW5kIGluIGZhY3QgdGhlIG9ubHkgdGhpbmcgaXQgcmV0
dXJucyBpcyB3aGV0aGVyIG9yDQo+ID4gbm90IHdlDQo+ID4gaGFkIGFueW9uZSB3YWl0aW5nIG9u
IGl0LiBXaGljaCBzaG91bGQgaGF2ZSBfemVyb18gYmVhcmluZyBvbg0KPiA+IHdoZXRoZXIgb3IN
Cj4gPiBub3Qgd2UgY2FuIGNsZWFyL2ludmFsaWRhdGUgdGhlIHJhbmdlLg0KPiA+IA0KPiA+IFRv
IG1lLCB0aGlzIHNtZWxscyBtb3JlIGxpa2UgYSByYWNlIG9mIHNvbWUgc29ydCwgYmV0d2VlbiBk
aXJ0eSBhbmQNCj4gPiBpbnZhbGlkYXRpb24uIGZzeCBkb2VzIGEgbG90IG9mIHN1Yi1wYWdlIHNp
emVkIG9wZXJhdGlvbnMuDQo+ID4gDQo+ID4gSSdsbCBwb2tlIGEgYml0IG1vcmUuLi4NCj4gDQo+
IEkgX3RoaW5rXyB3ZSdyZSByYWNpbmcgd2l0aCB0aGUgc2FtZSBmb2xpbyBiZWluZyBtYXJrZWQg
Zm9yIHdyaXRlYmFjaw0KPiBhZ2Fpbi4gQWwsIGNhbiB5b3UgdHJ5IHRoZSBiZWxvdz8NCj4gDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvbW0vZmlsZW1hcC5jIGIvbW0vZmlsZW1hcC5jDQo+IGluZGV4IDdi
OTBjYmViNGExYS4uZTk1YjE4NGEyNDU5IDEwMDY0NA0KPiAtLS0gYS9tbS9maWxlbWFwLmMNCj4g
KysrIGIvbW0vZmlsZW1hcC5jDQo+IEBAIC0xNjA0LDcgKzE2MDQsNyBAQCBzdGF0aWMgdm9pZCBm
b2xpb19lbmRfZHJvcGJlaGluZF93cml0ZShzdHJ1Y3QNCj4gZm9saW8gKmZvbGlvKQ0KPiDCoAkg
KiBpbnZhbGlkYXRpb24gaW4gdGhhdCBjYXNlLg0KPiDCoAkgKi8NCj4gwqAJaWYgKGluX3Rhc2so
KSAmJiBmb2xpb190cnlsb2NrKGZvbGlvKSkgew0KPiAtCQlpZiAoZm9saW8tPm1hcHBpbmcpDQo+
ICsJCWlmIChmb2xpby0+bWFwcGluZyAmJiAhZm9saW9fdGVzdF93cml0ZWJhY2soZm9saW8pKQ0K
PiDCoAkJCWZvbGlvX3VubWFwX2ludmFsaWRhdGUoZm9saW8tPm1hcHBpbmcsDQo+IGZvbGlvLCAw
KTsNCj4gwqAJCWZvbGlvX3VubG9jayhmb2xpbyk7DQo+IMKgCX0NCj4gDQoNCkkgdGhpbmsgd2Ug
bmVlZCB0byB0ZXN0IGZvciBQR19kaXJ0eSBhZnRlciByZXRha2luZyB0aGUgZm9saW8gbG9jayBh
cw0Kd2VsbC4gTm90aGluZyBzdG9wcyBhIHNlY29uZCB0aHJlYWQgZnJvbSByZWRpcnR5aW5nIHRo
ZSBwYWdlIG9uY2UgdGhlDQpmb2xpbyBsb2NrIGlzIGRyb3BwZWQsIGFuZCB3aGlsZSBzb21lIGZp
bGVzeXN0ZW1zIG1heSBpbnNpc3Qgb24gd2FpdGluZw0KZm9yIFBHX3dyaXRlYmFjayBiZWZvcmUg
YWxsb3dpbmcgcmVkaXJ0eWluZyB0byBjb21wbGV0ZSwgdGhhdCBzdGlsbA0KZW5kcyB1cCByYWNp
bmcgYmVjYXVzZSBmb2xpb19lbmRfZHJvcGJlaGluZF93cml0ZSgpIGlzIGNhbGxlZCBhZnRlciB0
aGUNCmNhbGwgdG8gX19mb2xpb19lbmRfd3JpdGViYWNrKCkuDQoNCk5vdGUgdGhhdCB0aGUgc2Ft
ZSBzZXQgb2YgcmFjZXMgY2FuIGhhcHBlbiBpbg0KZmlsZW1hcF9lbmRfZHJvcGJlaGluZF9yZWFk
KCksIHNvIHdlIG5lZWQgdGhlIHNhbWUgc2V0IG9mIGNoZWNrcyBhZnRlcg0KdGFraW5nIHRoZSBm
b2xpbyBsb2NrIHRoZXJlIHRvby4gVGhlIGV4aXN0aW5nIGNoZWNrcyBhcmUgaW5zdWZmaWNpZW50
LA0Kc2luY2UgdGhleSBvbmx5IGhhcHBlbiBiZWZvcmUgdGFraW5nIHRoZSBmb2xpbyBsb2NrLg0K
DQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1t
ZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0K

