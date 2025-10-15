Return-Path: <linux-fsdevel+bounces-64227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18122BDE00F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 12:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12FF71926446
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 10:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929BF321441;
	Wed, 15 Oct 2025 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="US4TaYQk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460FF320A34
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 10:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524082; cv=fail; b=eDHVc9zhyfpAQr8H6hrGFjihwCI4zL+l6eklX3/Io4PMhiZ3R0PvinOjUY+66VLwMDUMZ0FcX/y8FEsuIMvsFHcfXbDfzhuhpNUHoavWtX8URkMxp7IEs9gzYzEA7+aEsA7siEwJ3OePEvu3wHB40zAWJHcjrOO0uuIYMgBWLvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524082; c=relaxed/simple;
	bh=8uMI4iWeaN9PHDZUL3e/FzgNHiS8dbGPNFemfcFZWUQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GLk+qvjgVsDlhV+NeEsgr9H1Z0wY7t6DEhBKz7H2Y4Y0B+25UDdzOK1sUBFtKH3cOOnT6/Mdib1nvlaVYni7KQ1Bd8DLrJpTVXnODFPN7OsOSEwjWNApRwDw8HxJylklqADJYg8RQFrR+NX2v+8cMB/EGCdTeYTfnh7xAnJtSKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=US4TaYQk; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020102.outbound.protection.outlook.com [52.101.46.102]) by mx-outbound41-47.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 15 Oct 2025 10:27:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVhaccE4vuLgUBrzoV18qdGcjO/joZ3F8M64Gzf+VLE3H1fu5lODKK55RrKD40fvr9ZrMQu6f/dXBhvQDFQZ+t+2S6aQgfc/pxnpWZIqXn0wa/5bYG25ER4ZTzyQPAujyxo+BTDXJLAaTD2LmrELQ+kgnpfDd7jDBKdWplKXFA6vsJZ7mI5fYLrA9Cgs9ZzRMkqIuj6Z8+82ieNFt23+wFM5SDkAB2Lf0P8pZkBKFdacKmRAtQ88PaQ8MqCVjBZtNlQ17wRFJIeClKzVYgE7Q6dRfdcZTCBc+ZmyJBzmULVoyOShPNtvBdyfnUE66xGGhmC4zU17fFZLqXn7x6Y6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uMI4iWeaN9PHDZUL3e/FzgNHiS8dbGPNFemfcFZWUQ=;
 b=vgInUDinLDKVYMncEzXpJHZzoc7oFoOvOkJxNalHP9IuAPT8xmAzlfm1L9gfefQedKxv7a4sPgLMVFlbdBU8hrKUuYbBl3MWA4OWw4Q0U+W69FYuEq2nB2WaPsFFl+lLUL+lTQb4HtUP6TewGrzU4GPXudKTQFPGBtedyUR2VpuPuRy1MfPE6G/sa7QQIGqXwpDg16GKzylFt3ons9nZe1k9ZMTzEVRjJPm6MkY8A1rBZsbaFE46PNOH9VPNoBfNELLHAsb5YmIorUk86pRWLMTlIV2T8tJyP4ecWz+UcJwT5arYqYp9+E5ory8tU8uswMq48oWtZS8FPC3B8gwEow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uMI4iWeaN9PHDZUL3e/FzgNHiS8dbGPNFemfcFZWUQ=;
 b=US4TaYQkKLyh1LtO4ZXZCyup4tzQRqTt332pQcbkj+4ha+kbRr1qfAgTbDCDpmQYBPmNLI0rcwSyu5TS+dS8qowXaiTGza/gqRTLO/JZT4k9eqOruc/kew3WSOiCJWB/KMnfrAlXpv9nxMNOnIBVuk5DgXSsRIOMHTpStC/tTvE=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by DM4PR19MB7953.namprd19.prod.outlook.com (2603:10b6:8:18a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 10:27:44 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%5]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 10:27:44 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Luis Henriques <luis@igalia.com>
CC: Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Gang He
	<dchg2000@gmail.com>
Subject: Re: [PATCH v3 6/6] fuse: {io-uring} Queue background requests on a
 different core
Thread-Topic: [PATCH v3 6/6] fuse: {io-uring} Queue background requests on a
 different core
Thread-Index: AQHcPGQ+VAGtbpprK0elpdTvQt8WbLTC+bKZgAAKNQA=
Date: Wed, 15 Oct 2025 10:27:44 +0000
Message-ID: <5e3b8848-2049-4321-82e7-2dec658d6936@ddn.com>
References: <20251013-reduced-nr-ring-queues_3-v3-0-6d87c8aa31ae@ddn.com>
 <20251013-reduced-nr-ring-queues_3-v3-6-6d87c8aa31ae@ddn.com>
 <87jz0w8pdp.fsf@igalia.com>
In-Reply-To: <87jz0w8pdp.fsf@igalia.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|DM4PR19MB7953:EE_
x-ms-office365-filtering-correlation-id: 99c9754a-d530-4563-eb15-08de0bd57aaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|19092799006|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?U01QOVNIWGtOZ3VWL1NGQ29xTUVtNUY3dE9vK0svU0U0N3pOMVFUSzdFZW12?=
 =?utf-8?B?TjdDWkhLR3ZlTWpzNHp6Q015dTBBekh4aFNjNEFVVW5KS3NZSjgrL3JVVmVX?=
 =?utf-8?B?cmY3YU9mdGU3NzFodkVNRGU1VU04a2pHVUNhdi92Smk4Q282eDl4VStnRlVp?=
 =?utf-8?B?emlZS1RxT0ZaSlFhNGxhd1JnTWY5WTNXY0NvbXVYL1FxeXVjRUVYTmdzZm5D?=
 =?utf-8?B?Q3pYN3NOOVcwenUrOU92a2FhcWNKZnVxcjNKUkIwM2xOaGtPVFBMVUJyaHVj?=
 =?utf-8?B?RWlSeTdjY2dtNkZhUVpNNEdtMi9pTGlPbmEzWTFkUXhoL1hJNDNMMW5nbHJK?=
 =?utf-8?B?bTAyN1pnZVRpZy9uWndsRlRhMlRPMC9udi8zc3BTQ0EralpaQm9TNk1DbFdo?=
 =?utf-8?B?RUtXK2s5VjVRNkNnTmZvb3ZtU1RYa2RNbjN4YkZ1ZUdsNWNyYjZNZ1FDeTdU?=
 =?utf-8?B?K081SjJHSXh5UWxXemRDTHFheVBleTVmK2hyTzBMZTBUNGEvLzNmWHJHaUpk?=
 =?utf-8?B?clIrRjlLMVdxNUJGZWlacXZFZHB0RTNUZEliWlRmWDdtUHNWcFdCdHJZOG4w?=
 =?utf-8?B?bEg3QXNvZUhzWEJ1NDdHOGpBK1V0TVFvREd3dUE0V2dTLzVnSGppaTZEWU05?=
 =?utf-8?B?VzJGT3hrVFJOSVRIUXJzM3RHSk9sZ2pMb3FUTysvdGQyaktldkdQbmF2ZXRS?=
 =?utf-8?B?UXArenFOL3kwTWttOUlFZktlL1hFQyt0ZDg3d1hQakZ0R0JmL3BiWE9OV25v?=
 =?utf-8?B?OENQWmM1Q09hUlBDVlRrd0RKbCtUQUllekl6YVBpSFJVOStXWHNLY3VGbEsw?=
 =?utf-8?B?WVlqMVA1bWJFSW00Zy9TYndRRWNmZTB3YnErMmpjYUcrRmJUNitOZGF2UjJi?=
 =?utf-8?B?ZTVpZkZ6eE1iN0wycHNUZ3Y1VEZBUzJsY05ZVjEyakRaRjVNWXFEbkI4WkRy?=
 =?utf-8?B?MDl2UkllMGhjNWE4ZHJXMVlnZHllUll2cXV6MW5wdjJhV1JRRlpHQXhqMUtF?=
 =?utf-8?B?b1VBeERZZm9uQ1VCZnppaWIvM1FFb2ZqSzFrYVFsM2N6UzJ1RVFrZE0zT05w?=
 =?utf-8?B?c3NEcE12UWU5b1dzMlBxYnRNZzd1WWVDSlp1eHBieW5DRDhkUWdNSnNZOE15?=
 =?utf-8?B?bkNWT2xhME9aTHNvZ2xYWDhXVFgrSWNINTAvS3VyNE1VSStIT29iczllU3lO?=
 =?utf-8?B?QjM5TzQvY3AvQWdkZlV5RnlLbzluRmo2clRobk85UEJKUHpSUmxRakJXdmdk?=
 =?utf-8?B?QjRRZHNYV3JTZXVyVHE5cXc4WEpoK0g5eDh1WHlxSTh2U21mRGdTeEhuN05a?=
 =?utf-8?B?cUNNSjdWSTRnM1UzUkVKSDhvT1RYb3lNNWVYRzhFVTQ2Z3BUczBlcjNXVzI0?=
 =?utf-8?B?OXFtRlFyWTFqSkxVOGQ2NjRNYTdwNDRsYVV6Tkc5YjVwNmFIaWVnYmlSVTc3?=
 =?utf-8?B?NDU4S2J3L0xHcFJ1cXBFdjU5aVRoOXl3d1ZZS0c1Yjh1S1NEOVJ2dnFhdVh0?=
 =?utf-8?B?WnhXQmxUT1lGVzZzNDRpSjJtMEFaU0dmMC9UZTRUV3FpdDJ1U3NCQ1hxWnN4?=
 =?utf-8?B?cGgwa3BaMVM3WDRzTmtBZU05WDJMMzdBQnR5a1pYWDdvWm1zdm1qOFVOc0Jj?=
 =?utf-8?B?aVRONTZkaXpEUlRMMitHbnNSeWhZbGVpRHk1SUJBbDhjc3lQOFkwUU93Q0tJ?=
 =?utf-8?B?NzFjMDhidWZIUE9wcW1ZR1o1aGJsbkVTTUM1WThzUzhqYlZEeWZEWlF1SEFB?=
 =?utf-8?B?TE9xYjdjMmlMVEp3QmpadVQybWhkSXFzL0hkNzJhRC9MQktwdEtWQmtGeUE4?=
 =?utf-8?B?ZmNaWnNodW00c3F4MzY1ekNVMU9udldKK3NHSmd6ZmRxMXE0clByQ0tuZGU2?=
 =?utf-8?B?dWNUdk90dW9kaXo3c2pHcW9RUnBkMlMzN1RMN1FMdXdDTWZTOEV0R1Q2d01k?=
 =?utf-8?B?eHp0MkZjVFlvUGtWM0xWSzhoS0srQjBDNzJjdnlyVC9CTEVQV2REMlF1emRU?=
 =?utf-8?B?bzFUbUFKb2ZnUVVybzhaVHNoVVdsaEVlMkcyU09rWTViUGRUYzAxbzZTN0oy?=
 =?utf-8?Q?1bbvAa?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aiszWEl1eDJFV1VpSUhnN3NISm1DT1czbkYzbUtVY25PaGdEYzNiWDlwdEVC?=
 =?utf-8?B?RFg4R2JRMFFuMXp3eVYwYytlbFhjaHJYQUVCQkJvc01icHVIU1ExSng0dTB1?=
 =?utf-8?B?dU1mSjhvYXJHYStJcHduNTJHdnlsQncrbmdrRzJ2aDNXUGJqSkUzd0gvRWNi?=
 =?utf-8?B?U1hyM0hGaENEZDFtU05YZGZVOWswYlFDQ3loeTh2N2p5eXdwaTRyVkdEcW1L?=
 =?utf-8?B?OU90bzMwZndyeHZqRU1YSlRMTnFkMmh4ZmdzUTNJRkYzeWVKYlRZVTJkcCtx?=
 =?utf-8?B?Vk5zdWZDSmZpZHNuOTJVaTFwS0hycDJkMFgvMTRGWXRTMzB1MG9JNFg0K1Vs?=
 =?utf-8?B?MlRrWmxibCtDeEduTVJaV3lVRDNwNjQ2UXpqSWx2T05VWGwwYU9ZclB5dHFK?=
 =?utf-8?B?ckpVeWpyQnNMeUE0bkkrS2pQSlVxdUppZmZEVGNlMVcvbnUwQVdyTjRzWmc1?=
 =?utf-8?B?RUVoaXpmTEtxdU0xTkdNS2U4ZCtqSnRuN2RMSE9BNG5GV08zOHhZeGNOMGVU?=
 =?utf-8?B?V2kyT0hhUjJFYWN5TS9keUlpbm9DUzkzZkdsMWEyLzRBMExWK2I3R01ZNlVD?=
 =?utf-8?B?Y3d5RU9QZVdyTkYrdnd3aXp6YnZ2NXVuNVFiUGNXMG03cmZVSUZZL1FIWXhN?=
 =?utf-8?B?LytJbjlXcnRydno0dndHZUMrVklTa0dZcnFDTUpIN05jUk0wNTk2Mm5yN0tG?=
 =?utf-8?B?Tktja0RxZ042RU5JK2VVek9VVElLNGZITEZhZkJmUUt0NWRQOXR1TXFxV25Q?=
 =?utf-8?B?UFp5K0dBSGZSWjFnM1VJYkhXbHlGamh5Rk9TRmFrdkMvTXNCdmRCU0dkbVdj?=
 =?utf-8?B?VjZoeHFMUS9GanRrYzFISGF0MW9TbWtLNXp1UVlWZTdTQTVFY3l5a05Xd2lY?=
 =?utf-8?B?cmVBVVNLTnE2Z3FJWUNIMElsRnFzckd4aFp5TjY2VS9wRWcrSEVpVDhvWnRT?=
 =?utf-8?B?MHhpZXZTM3lORUFEcVl0VjZtVno1NlAxc1lpOXJMRHdlREc2SHprK0RBbFVv?=
 =?utf-8?B?SmpLdkhrU0tPMnI4RWZsMnVjM3pLRlV5RzJ6VklMSS8xaWx0dHg0MDBKcHZu?=
 =?utf-8?B?aEJWWWNtbm1hKzUvRmdnYVd1ekdqRWd6emR4NEhOcWpONXRPNTVKTXhrMnZn?=
 =?utf-8?B?QTJhVlh0aFZYZENlai9MNTBKRGtXVzV6cTM0NkpKS3hDRC9FaGVNQ1hGVFNt?=
 =?utf-8?B?dXNHZW5kMGM1Q2xjdmREZ0RqaUpjY2dZQW5nT25mc1J5clNhZzFJcEFUN1NE?=
 =?utf-8?B?WmUyQk02eWJQN1RxRmcrU0M1dUZ2dmUyeEVQYitsUTZvUkZhM1B6eUNjNmlR?=
 =?utf-8?B?UW4xYS9xZVA4WHFROUY4YlBKT2dwTjV2TklIMjlVV0twWGxqV1YxVHlncFRj?=
 =?utf-8?B?UCtpTlRPWXZpRXhDSGRpVi84MjFQZFdEUW5IdHcydVlzQzlGWW9HSmFMYVJV?=
 =?utf-8?B?NXQ2UW45ZWFzb09pT0R5QTd4MzdvTnVTZWk1bkRKYUFpUy9pV0NrRCtnSldJ?=
 =?utf-8?B?NWpWUGJRNlhzdHZEVzFZQTVVUE01dDFFa1ZWV2JPVGdPUHlUbmN3YkNNN2pK?=
 =?utf-8?B?VEVoUHBUOTRpb1NEWXhHY2FhUmtLMFNyWHhkbDJ2dDI1eWNlVEtGVEdLRktF?=
 =?utf-8?B?Yk4wVmFieThsN1V6VGN3L0NSNUZNeTRSb1BCbUdLaXRDazQ5c3orZTZsTldM?=
 =?utf-8?B?UmljTXE1eXFiaTFFSHVWN2RiZ3JqZVY4d2tUVnZFWW9GbjlOa3JRWGM1S0JY?=
 =?utf-8?B?VVNvRlBWK05jZVh4LzlZOUw4YUZ1dG51N0dGSmR5UVd1QS9UY3BkR3gvMmVs?=
 =?utf-8?B?alJsM3VGaXJYU3VHcklmWlhXKzhVRTRydmNVbFhoR25haWlpMFVWNzAyUmM1?=
 =?utf-8?B?dmdzeTVyRzVqTmNOUkN1bmlOQ1Y5Yk9jdkpsUDFHU0NGNUUvaXh2UDZoUjdE?=
 =?utf-8?B?cDhscWE0STdZU1ZPaEgzRnlidFpTc0Y0OWVxMktRSTFvenZTTHZlZW53WVpF?=
 =?utf-8?B?R1liSjZPUHNieVp2RDErZGIzcjVQd3JVeTVlRFhFQXBXSUdPd1RxQUR1a2du?=
 =?utf-8?B?aUFwVlZpRFNYaWJZR0JSN2tGdXZjWWhQd3RSVFdIdzBFNVg3TzRGUlhhc0Vj?=
 =?utf-8?B?U3RER3NwajRQWjU2YUF4MWxjdnBTYlZzb1VOaE1SeExZbkVLZXlKNjJsd1JH?=
 =?utf-8?Q?fWh2da8JVfTrhVibfNn8uhA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE5D1857E47A1840BD8769221AF3469B@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mOgDCiPU4pz5Sh+Bazh8zzlB98wI5Oo7tBa/YECytFKP1BkIBA55sYK43KRPHYkMLy20wpNxxLCT9dEYLN89UrmKQtpA29P+IuQ7LyC2LEoj6oSOFb5AA4xObNbXnHwFKG2e0kX77z2j59kJy3GuU+MYvh0/QA0IiWD3AZ+CnPVh2cR5/PjY6t8Rb1HetJiTvMEAkHHAbUgzljPr3tpmGowAIQ0gDKnGEKLwgmXUlmLbCe+30cSxosyi6vDnvynurEuNhtCRiFK4f3FE4oVywGLjlh8U+Pwzgh/Atk6s2xeSSlnwOZ19NptHfG/6JPUOdGkkLyHCx8Jyh5mV2jvTgi+aefGwPbiKDhaMOtRG+TOBwghsgXBVUhHtDTIB2bwDXaMwft3raecSITzsHlha2cp2vkt0nnWHZg7hdoQQ6UXt4jVWxHiGQmd1RvhlXyOZJWLPBFhbyyLqEpYXF6HrrNtNT0MEmp6sxtizYUsQUQCuW/VyqB/dCt21d2oqKU2OVz0HNIFhOFQewHyHwl9P7nKlXxqBZcrzJJSYq2uvZZi44Plax5K4bGPpcP6drBijAsqS/Wukde9S1235/+RVtJim/2UJp9Qjhmn/MRaCAU/fQA1WXN+TNedT2bpOTmrlaajL9m3KXtagp5vEJ7FKbA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c9754a-d530-4563-eb15-08de0bd57aaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 10:27:44.7038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tYJzH/AYpwD5+zAaEu9rmVhxS9Yuk2cU9kBLXfa5lIJoqwRyG6GDKjx4sY85kLGcYtxcDWFdwvbnPvKNj5O5MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB7953
X-BESS-ID: 1760524067-110543-7659-44329-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.46.102
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVubGlkZAVgZQ0MzAxMDYJM3IxM
	TYzMTSLCklOck8zczUyDg11TjFJDVFqTYWAAHTwkxBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268223 [from 
	cloudscan8-32.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gMTAvMTUvMjUgMTE6NTAsIEx1aXMgSGVucmlxdWVzIHdyb3RlOg0KPiBPbiBNb24sIE9jdCAx
MyAyMDI1LCBCZXJuZCBTY2h1YmVydCB3cm90ZToNCj4gDQo+PiBSdW5uaW5nIGJhY2tncm91bmQg
SU8gb24gYSBkaWZmZXJlbnQgY29yZSBtYWtlcyBxdWl0ZSBhIGRpZmZlcmVuY2UuDQo+Pg0KPj4g
ZmlvIC0tZGlyZWN0b3J5PS90bXAvZGVzdCAtLW5hbWU9aW9wcy5cJGpvYm51bSAtLXJ3PXJhbmRy
ZWFkIFwNCj4+IC0tYnM9NGsgLS1zaXplPTFHIC0tbnVtam9icz0xIC0taW9kZXB0aD00IC0tdGlt
ZV9iYXNlZFwNCj4+IC0tcnVudGltZT0zMHMgLS1ncm91cF9yZXBvcnRpbmcgLS1pb2VuZ2luZT1p
b191cmluZ1wNCj4+ICAtLWRpcmVjdD0xDQo+Pg0KPj4gdW5wYXRjaGVkDQo+PiAgICBSRUFEOiBi
dz0yNzJNaUIvcyAoMjg1TUIvcyksIDI3Mk1pQi9zLTI3Mk1pQi9zIC4uLg0KPj4gcGF0Y2hlZA0K
Pj4gICAgUkVBRDogYnc9NzYwTWlCL3MgKDc5N01CL3MpLCA3NjBNaUIvcy03NjBNaUIvcyAuLi4N
Cj4+DQo+PiBXaXRoIC0taW9kZXB0aD04DQo+Pg0KPj4gdW5wYXRjaGVkDQo+PiAgICBSRUFEOiBi
dz00NjZNaUIvcyAoNDg5TUIvcyksIDQ2Nk1pQi9zLTQ2Nk1pQi9zIC4uLg0KPj4gcGF0Y2hlZA0K
Pj4gICAgUkVBRDogYnc9OTY2TWlCL3MgKDEwMTNNQi9zKSwgOTY2TWlCL3MtOTY2TWlCL3MgLi4u
DQo+PiAybmQgcnVuOg0KPj4gICAgUkVBRDogYnc9MTAxNE1pQi9zICgxMDY0TUIvcyksIDEwMTRN
aUIvcy0xMDE0TWlCL3MgLi4uDQo+Pg0KPj4gV2l0aG91dCBpby11cmluZyAoLS1pb2RlcHRoPTgp
DQo+PiAgICBSRUFEOiBidz03MjlNaUIvcyAoNzY0TUIvcyksIDcyOU1pQi9zLTcyOU1pQi9zIC4u
Lg0KPj4NCj4+IFdpdGhvdXQgZnVzZSAoLS1pb2RlcHRoPTgpDQo+PiAgICBSRUFEOiBidz0yMTk5
TWlCL3MgKDIzMDZNQi9zKSwgMjE5OU1pQi9zLTIxOTlNaUIvcyAuLi4NCj4+DQo+PiAoVGVzdCB3
ZXJlIGRvbmUgd2l0aA0KPj4gPGxpYmZ1c2U+L2V4YW1wbGUvcGFzc3Rocm91Z2hfaHAgLW8gYWxs
b3dfb3RoZXIgLS1ub3Bhc3N0aHJvdWdoICBcDQo+PiBbLW8gaW9fdXJpbmddIC90bXAvc291cmNl
IC90bXAvZGVzdA0KPj4gKQ0KPj4NCj4+IEFkZGl0aW9uYWwgbm90ZXM6DQo+Pg0KPj4gV2l0aCBG
VVJJTkdfTkVYVF9RVUVVRV9SRVRSSUVTPTAgKC0taW9kZXB0aD04KQ0KPj4gICAgUkVBRDogYnc9
OTAzTWlCL3MgKDk0Nk1CL3MpLCA5MDNNaUIvcy05MDNNaUIvcyAuLi4NCj4+DQo+PiBXaXRoIGp1
c3QgYSByYW5kb20gcWlkICgtLWlvZGVwdGg9OCkNCj4+ICAgIFJFQUQ6IGJ3PTQyOU1pQi9zICg0
NTBNQi9zKSwgNDI5TWlCL3MtNDI5TWlCL3MgLi4uDQo+Pg0KPj4gV2l0aCAtLWlvZGVwdGg9MQ0K
Pj4gdW5wYXRjaGVkDQo+PiAgICBSRUFEOiBidz0xOTVNaUIvcyAoMjA0TUIvcyksIDE5NU1pQi9z
LTE5NU1pQi9zIC4uLg0KPj4gcGF0Y2hlZA0KPj4gICAgUkVBRDogYnc9MjMyTWlCL3MgKDI0M01C
L3MpLCAyMzJNaUIvcy0yMzJNaUIvcyAuLi4NCj4+DQo+PiBXaXRoIC0taW9kZXB0aD0xIC0tbnVt
am9icz0yDQo+PiB1bnBhdGNoZWQNCj4+ICAgIFJFQUQ6IGJ3PTk2Nk1pQi9zICgxMDEzTUIvcyks
IDk2Nk1pQi9zLTk2Nk1pQi9zIC4uLg0KPj4gcGF0Y2hlZA0KPj4gICAgUkVBRDogYnc9MTgyMU1p
Qi9zICgxOTA5TUIvcyksIDE4MjFNaUIvcy0xODIxTWlCL3MgLi4uDQo+Pg0KPj4gV2l0aCAtLWlv
ZGVwdGg9MSAtLW51bWpvYnM9OA0KPj4gdW5wYXRjaGVkDQo+PiAgICBSRUFEOiBidz0xMTM4TWlC
L3MgKDExOTNNQi9zKSwgMTEzOE1pQi9zLTExMzhNaUIvcyAuLi4NCj4+IHBhdGNoZWQNCj4+ICAg
IFJFQUQ6IGJ3PTE2NTBNaUIvcyAoMTczME1CL3MpLCAxNjUwTWlCL3MtMTY1ME1pQi9zIC4uLg0K
Pj4gZnVzZSB3aXRob3V0IGlvLXVyaW5nDQo+PiAgICBSRUFEOiBidz0xMzE0TWlCL3MgKDEzNzhN
Qi9zKSwgMTMxNE1pQi9zLTEzMTRNaUIvcyAuLi4NCj4+IG5vLWZ1c2UNCj4+ICAgIFJFQUQ6IGJ3
PTI1NjZNaUIvcyAoMjY5ME1CL3MpLCAyNTY2TWlCL3MtMjU2Nk1pQi9zIC4uLg0KPj4NCj4+IElu
IHN1bW1hcnksIGZvciBhc3luYyByZXF1ZXN0cyB0aGUgY29yZSBkb2luZyBhcHBsaWNhdGlvbiBJ
TyBpcyBidXN5DQo+PiBzZW5kaW5nIHJlcXVlc3RzIGFuZCBwcm9jZXNzaW5nIElPcyBzaG91bGQg
YmUgZG9uZSBvbiBhIGRpZmZlcmVudCBjb3JlLg0KPj4gU3ByZWFkaW5nIHRoZSBsb2FkIG9uIHJh
bmRvbSBjb3JlcyBpcyBhbHNvIG5vdCBkZXNpcmFibGUsIGFzIHRoZSBjb3JlDQo+PiBtaWdodCBi
ZSBmcmVxdWVuY3kgc2NhbGVkIGRvd24gYW5kL29yIGluIEMxIHNsZWVwIHN0YXRlcy4gTm90IHNo
b3duIGhlcmUsDQo+PiBidXQgZGlmZmVybmNlcyBhcmUgbXVjaCBzbWFsbGVyIHdoZW4gdGhlIHN5
c3RlbSB1c2VzIHBlcmZvcm1hbmNlIGdvdmVub3INCj4+IGluc3RlYWQgb2Ygc2NoZWR1dGlsICh1
YnVudHUgZGVmYXVsdCkuIE9idmlvdXNseSBhdCB0aGUgY29zdCBvZiBoaWdoZXINCj4+IHN5c3Rl
bSBwb3dlciBjb25zdW1wdGlvbiBmb3IgcGVyZm9ybWFuY2UgZ292ZW5vciAtIG5vdCBkZXNpcmFi
bGUgZWl0aGVyLg0KPj4NCj4+IFJlc3VsdHMgd2l0aG91dCBpby11cmluZyAod2hpY2ggdXNlcyBm
aXhlZCBsaWJmdXNlIHRocmVhZHMgcGVyIHF1ZXVlKQ0KPj4gaGVhdmlseSBkZXBlbmQgb24gdGhl
IGN1cnJlbnQgbnVtYmVyIG9mIGFjdGl2ZSB0aHJlYWRzLiBMaWJmdXNlIHVzZXMNCj4+IGRlZmF1
bHQgb2YgbWF4IDEwIHRocmVhZHMsIGJ1dCBhY3R1YWwgbnIgbWF4IHRocmVhZHMgaXMgYSBwYXJh
bWV0ZXIuDQo+PiBBbHNvLCBuby1mdXNlLWlvLXVyaW5nIHJlc3VsdHMgaGVhdmlseSBkZXBlbmQg
b24sIGlmIHRoZXJlIHdhcyBhbHJlYWR5DQo+PiBydW5uaW5nIGFub3RoZXIgd29ya2xvYWQgYmVm
b3JlLCBhcyBsaWJmdXNlIHN0YXJ0cyB0aGVzZSB0aHJlYWRzDQo+PiBkeW5hbWljYWxseSAtIGku
ZS4gdGhlIG1vcmUgdGhyZWFkcyBhcmUgYWN0aXZlLCB0aGUgd29yc2UgdGhlDQo+PiBwZXJmb3Jt
YW5jZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBCZXJuZCBTY2h1YmVydCA8YnNjaHViZXJ0QGRk
bi5jb20+DQo+PiAtLS0NCj4+ICBmcy9mdXNlL2Rldl91cmluZy5jIHwgNTMgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4+ICAxIGZpbGUgY2hh
bmdlZCwgNDYgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvZnMvZnVzZS9kZXZfdXJpbmcuYyBiL2ZzL2Z1c2UvZGV2X3VyaW5nLmMNCj4+IGluZGV4IGFj
YTcxY2U1NjMyZWZkMWQ4MGUzYWMwYWQ0ZTgxYWMxNTM2ZGJjNDcuLmYzNWRkOThhYmZlNjQwNzg0
OWZlYzU1ODQ3YzZiM2QxODYzODM4MDMgMTAwNjQ0DQo+PiAtLS0gYS9mcy9mdXNlL2Rldl91cmlu
Zy5jDQo+PiArKysgYi9mcy9mdXNlL2Rldl91cmluZy5jDQo+PiBAQCAtMjMsNiArMjMsNyBAQCBN
T0RVTEVfUEFSTV9ERVNDKGVuYWJsZV91cmluZywNCj4+ICAjZGVmaW5lIEZVUklOR19RX0xPQ0FM
X1RIUkVTSE9MRCAyDQo+PiAgI2RlZmluZSBGVVJJTkdfUV9OVU1BX1RIUkVTSE9MRCAoRlVSSU5H
X1FfTE9DQUxfVEhSRVNIT0xEICsgMSkNCj4+ICAjZGVmaW5lIEZVUklOR19RX0dMT0JBTF9USFJF
U0hPTEQgKEZVUklOR19RX0xPQ0FMX1RIUkVTSE9MRCAqIDIpDQo+PiArI2RlZmluZSBGVVJJTkdf
TkVYVF9RVUVVRV9SRVRSSUVTIDINCj4gDQo+IFNvbWUgYmlrZXNoZWRkaW5nOg0KPiANCj4gTWF5
YmUgdGhhdCdzIGp1c3QgbWUsIGJ1dCBJIGFzc29jaWF0ZSB0aGUgbmFtZXMgYWJvdmUgKEZVUklO
R18qKSB0byAnZnVyJw0KPiAtLSB0aGUgYWN0aW9uIG9mIG1ha2luZyAnZnVyJy4gIEknbSBub3Qg
c3VyZSB0aGF0IHZlcmIgZXZlbiBleGlzdHMsIGJ1dCBteQ0KPiBicmFpbiBtYWtlcyBtZSBkaXNs
aWtlIHRob3NlIG5hbWVzIDotKQ0KPiANCj4gQnV0IEknbSBub3QgYSBuYXRpdmUgc3BlYWtlciwg
YW5kIEkgZG9uJ3QgaGF2ZSBhbnkgb3RoZXIgb2JqZWN0aW9uIHRvDQo+IHRob3NlIG5hbWVzIHJh
dGhlciB0aGFuICJJIGRvbid0IGxpa2UgZnVyISIgc28gZmVlbCBmcmVlIHRvIGlnbm9yZSBtZS4g
Oi0pDQoNCkkgaGFkIGluaXRpYWxseSBjYWxsZWQgaXQgIkZVU0VfVVJJTkciLCBidXQgaXQgc2Vl
bWVkIHRvIGJlIGEgYml0IGxvbmcuDQpJIGNhbiBjaGFuZ2UgYmFjayB0byB0aGF0IG9yIG1heWJl
IHlvdSBoYXZlIGEgYmV0dGVyIHNob3J0IG5hbWUgaW4geW91cg0KbWluZCAoYXMgdXN1YWwgdGhl
IGhhcmRlc3QgcGFydCBpcyB0byBmaW5kIGdvb2QgdmFyaWFibGUgbmFtZXMpPw0KDQo+IA0KPj4g
IA0KPj4gIGJvb2wgZnVzZV91cmluZ19lbmFibGVkKHZvaWQpDQo+PiAgew0KPj4gQEAgLTEzMDIs
MTIgKzEzMDMsMTUgQEAgc3RhdGljIHN0cnVjdCBmdXNlX3JpbmdfcXVldWUgKmZ1c2VfdXJpbmdf
YmVzdF9xdWV1ZShjb25zdCBzdHJ1Y3QgY3B1bWFzayAqbWFzaywNCj4+ICAvKg0KPj4gICAqIEdl
dCB0aGUgYmVzdCBxdWV1ZSBmb3IgdGhlIGN1cnJlbnQgQ1BVDQo+PiAgICovDQo+PiAtc3RhdGlj
IHN0cnVjdCBmdXNlX3JpbmdfcXVldWUgKmZ1c2VfdXJpbmdfZ2V0X3F1ZXVlKHN0cnVjdCBmdXNl
X3JpbmcgKnJpbmcpDQo+PiArc3RhdGljIHN0cnVjdCBmdXNlX3JpbmdfcXVldWUgKmZ1c2VfdXJp
bmdfZ2V0X3F1ZXVlKHN0cnVjdCBmdXNlX3JpbmcgKnJpbmcsDQo+PiArCQkJCQkJICAgIGJvb2wg
YmFja2dyb3VuZCkNCj4+ICB7DQo+PiAgCXVuc2lnbmVkIGludCBxaWQ7DQo+PiAgCXN0cnVjdCBm
dXNlX3JpbmdfcXVldWUgKmxvY2FsX3F1ZXVlLCAqYmVzdF9udW1hLCAqYmVzdF9nbG9iYWw7DQo+
PiAgCWludCBsb2NhbF9ub2RlOw0KPj4gIAljb25zdCBzdHJ1Y3QgY3B1bWFzayAqbnVtYV9tYXNr
LCAqZ2xvYmFsX21hc2s7DQo+PiArCWludCByZXRyaWVzID0gMDsNCj4+ICsJaW50IHdlaWdodCA9
IC0xOw0KPj4gIA0KPj4gIAlxaWQgPSB0YXNrX2NwdShjdXJyZW50KTsNCj4+ICAJaWYgKFdBUk5f
T05DRShxaWQgPj0gcmluZy0+bWF4X25yX3F1ZXVlcywNCj4+IEBAIC0xMzE1LDE2ICsxMzE5LDUw
IEBAIHN0YXRpYyBzdHJ1Y3QgZnVzZV9yaW5nX3F1ZXVlICpmdXNlX3VyaW5nX2dldF9xdWV1ZShz
dHJ1Y3QgZnVzZV9yaW5nICpyaW5nKQ0KPj4gIAkJICAgICAgcmluZy0+bWF4X25yX3F1ZXVlcykp
DQo+PiAgCQlxaWQgPSAwOw0KPj4gIA0KPj4gLQlsb2NhbF9xdWV1ZSA9IFJFQURfT05DRShyaW5n
LT5xdWV1ZXNbcWlkXSk7DQo+PiAgCWxvY2FsX25vZGUgPSBjcHVfdG9fbm9kZShxaWQpOw0KPj4g
IAlpZiAoV0FSTl9PTl9PTkNFKGxvY2FsX25vZGUgPiByaW5nLT5ucl9udW1hX25vZGVzKSkNCj4+
ICAJCWxvY2FsX25vZGUgPSAwOw0KPj4gIA0KPj4gLQkvKiBGYXN0IHBhdGg6IGlmIGxvY2FsIHF1
ZXVlIGV4aXN0cyBhbmQgaXMgbm90IG92ZXJsb2FkZWQsIHVzZSBpdCAqLw0KPj4gLQlpZiAobG9j
YWxfcXVldWUgJiYNCj4+IC0JICAgIFJFQURfT05DRShsb2NhbF9xdWV1ZS0+bnJfcmVxcykgPD0g
RlVSSU5HX1FfTE9DQUxfVEhSRVNIT0xEKQ0KPj4gKwlsb2NhbF9xdWV1ZSA9IFJFQURfT05DRShy
aW5nLT5xdWV1ZXNbcWlkXSk7DQo+PiArDQo+PiArcmV0cnk6DQo+PiArCS8qDQo+PiArCSAqIEZv
ciBiYWNrZ3JvdW5kIHJlcXVlc3RzLCB0cnkgbmV4dCBDUFUgaW4gc2FtZSBOVU1BIGRvbWFpbi4N
Cj4+ICsJICogSS5lLiBjcHUtMCBjcmVhdGVzIGFzeW5jIHJlcXVlc3RzLCBjcHUtMSBpbyBwcm9j
ZXNzZXMuDQo+PiArCSAqIFNpbWlsYXIgZm9yIGZvcmVncm91bmQgcmVxdWVzdHMsIHdoZW4gdGhl
IGxvY2FsIHF1ZXVlIGRvZXMgbm90DQo+PiArCSAqIGV4aXN0IC0gc3RpbGwgYmV0dGVyIHRvIGFs
d2F5cyB3YWtlIHRoZSBzYW1lIGNwdSBpZC4NCj4+ICsJICovDQo+PiArCWlmIChiYWNrZ3JvdW5k
IHx8ICFsb2NhbF9xdWV1ZSkgew0KPj4gKwkJbnVtYV9tYXNrID0gcmluZy0+bnVtYV9yZWdpc3Rl
cmVkX3FfbWFza1tsb2NhbF9ub2RlXTsNCj4+ICsNCj4+ICsJCWlmICh3ZWlnaHQgPT0gLTEpDQo+
PiArCQkJd2VpZ2h0ID0gY3B1bWFza193ZWlnaHQobnVtYV9tYXNrKTsNCj4+ICsNCj4+ICsJCWlm
ICh3ZWlnaHQgPT0gMCkNCj4+ICsJCQlnb3RvIGdsb2JhbDsNCj4+ICsNCj4+ICsJCWlmICh3ZWln
aHQgPiAxKSB7DQo+PiArCQkJaW50IGlkeCA9IChxaWQgKyAxKSAlIHdlaWdodDsNCj4+ICsNCj4+
ICsJCQlxaWQgPSBjcHVtYXNrX250aChpZHgsIG51bWFfbWFzayk7DQo+PiArCQl9IGVsc2Ugew0K
Pj4gKwkJCXFpZCA9IGNwdW1hc2tfZmlyc3QobnVtYV9tYXNrKTsNCj4+ICsJCX0NCj4+ICsNCj4+
ICsJCWxvY2FsX3F1ZXVlID0gUkVBRF9PTkNFKHJpbmctPnF1ZXVlc1txaWRdKTsNCj4+ICsJCWlm
IChXQVJOX09OX09OQ0UoIWxvY2FsX3F1ZXVlKSkNCj4+ICsJCQlyZXR1cm4gTlVMTDsNCj4+ICsJ
fQ0KPj4gKw0KPj4gKwlpZiAoUkVBRF9PTkNFKGxvY2FsX3F1ZXVlLT5ucl9yZXFzKSA8PSBGVVJJ
TkdfUV9OVU1BX1RIUkVTSE9MRCkNCj4+ICAJCXJldHVybiBsb2NhbF9xdWV1ZTsNCj4+ICANCj4+
ICsJaWYgKHJldHJpZXMgPCBGVVJJTkdfTkVYVF9RVUVVRV9SRVRSSUVTICYmIHdlaWdodCA+IHJl
dHJpZXMgKyAxKSB7DQo+PiArCQlyZXRyaWVzKys7DQo+PiArCQlsb2NhbF9xdWV1ZSA9IE5VTEw7
DQo+PiArCQlnb3RvIHJldHJ5Ow0KPj4gKwl9DQo+PiArDQo+IA0KPiBJIHdvbmRlciBpZiB0aGlz
IHJldHJ5IGxvb3AgaXMgcmVhbGx5IHVzZWZ1bC4gIElmIEkgdW5kZXJzdGFuZCB0aGlzDQo+IGNv
cnJlY3RseSwgd2UncmUgZG9pbmcgYSBidXN5IGxvb3AsIGhvcGluZyBmb3IgYSBiZXR0ZXIgcXVl
dWUgdG8gYmVjb21lDQo+IGF2YWlsYWJsZS4gIEJ1dCBpZiB0aGUgc3lzdGVtIGlzIHJlYWxseSBi
dXN5IGRvaW5nIElPIHRoaXMgcmV0cnkgbG9vcCB3aWxsDQo+IG1vc3Qgb2YgdGhlIHRpbWVzIGZh
aWwgYW5kIHdpbGwgZmFsbCBiYWNrIHRvIHRoZSBuZXh0IG9wdGlvbiAtLSBvbmx5IG9uY2UNCj4g
aW4gYSB3aGlsZSB3ZSB3aWxsIGdldCBhIGJldHRlciBvbmUuDQo+IA0KPiBEbyB5b3UgaGF2ZSBl
dmlkZW5jZSB0aGF0IHRoaXMgY291bGQgYmUgaGVscGZ1bD8gIE9yIGFtIEkgbWlzdW5kZXJzdGFu
ZGluZw0KPiB0aGUgcHVycG9zZSBvZiB0aGlzIHJldHJ5IGxvb3A/DQoNClllYWgsIEkgZ290IGJl
dHRlciByZXN1bHRzIHdpdGggdGhlIHJldHJ5LCBiZWNhdXNlIHVzaW5nIHJhbmRvbSBxdWV1ZXMN
CnJlYWxseSBkb2Vzbid0IHdvcmsgd2VsbCAtIHdha2VzIHVwIGNvcmVzIG9uIHJhbmRvbSBxdWV1
ZXMgYW5kIHdha2VzIGFuZA0KZG9lc24ndCBhY2N1bXVsYXRlIG9uIHRoZSBzYW1lIHF1ZXVlIC0g
ZG9lc24ndCBtYWtlIHVzZSBvZiB0aGUgcmluZw0KYWR2YW50YWdlLiBTbyByYW5kb20gc2hvdWxk
IGJlIGF2b2lkZWQsIGlmIHBvc3NpYmxlLiBBbHNvLCB0aGUgbW9yZQ0KcXVldWVzIHRoZSBzeXN0
ZW0gaGFzLCB0aGUgd29yc2UgdGhlIHJlc3VsdHMgd2l0aCB0aGUgcGxhaW4gcmFuZG9tDQpmYWxs
YmFjay4gSSBjYW4gcHJvdmlkZSBzb21lIG51bWJlcnMgbGF0ZXIgb24gdG9kYXkuDQoNCg0KVGhh
bmtzLA0KQmVybmQNCg==

