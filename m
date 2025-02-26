Return-Path: <linux-fsdevel+bounces-42629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A474EA4531B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 03:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7D53AB6A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 02:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442C921C9EC;
	Wed, 26 Feb 2025 02:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="bFmarA13"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2120.outbound.protection.outlook.com [40.107.243.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC16A42070;
	Wed, 26 Feb 2025 02:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740537295; cv=fail; b=WS6rXDHlMGLusnAo0pLMJ3658jCPT3u3ZrOXEPB7Qd/V511hHJfHgUeGOb88Dgub8+FmWbhGz3e2H4pYzrMlL+Dzq3P/ZIzM/6SwtEg6lcDXSvqJrkYz7krtPhNDMsJTvt7x8SGVo2bvMpRDSyuqhTS5dybXwT/4BwC7GnsolWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740537295; c=relaxed/simple;
	bh=bby9qkRWg0ZQJdq19LSHBsnB+6Ft5nzN32PD4bCVDaU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XG7yhRYHjKCXuWbxiNMZB1XvznSaGFIand5QyPHIyItDYU7A35t7llO6/pjUbRaZn9jt5AzNRiUVQ1+1ZB/o9uCDoS03vS6Q3MM7kzOqbRQN+h5ipxsF7Ze73s5RhkvEVJ9RM48btLma41d8Sq7rbk6eWgYEWA3f5WBDtDXtXuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=bFmarA13; arc=fail smtp.client-ip=40.107.243.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TsiZ6wsdOLEuRoHK+iuk6D7QQX32PtSTp1lbC/L2vkGyXWt9/PblGR5p7JQ4uIgMvuGueWiKk1wS254WyfyszRgcEQXFW0dcF5Tbg0Lri5YjQm1uVYfyqceKYW6avQZxhuqIYLjBHqsWJEk5EUs9UG8xhQ8HnSiBwh1CMn3asQ7MWRiSNYw/I5hEMGSSmP2IX9pBC7MdjOeMQknCwlX8Wtt6MUglNKR+Gz7Ym+qhIHRN7cxid0TvaziKt68om7c+AG+7PXC0PrGScyK0Ry0O1ePbY2yJ4whHA8NCu5TtOhnju07UqaLWe+mo1vp2v2Oom5C6XW2q849Bt0AOFnQPAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bby9qkRWg0ZQJdq19LSHBsnB+6Ft5nzN32PD4bCVDaU=;
 b=rXpxd8vuMSn/7MjMAM9EKIn/Zhi+fQ7fMPUp9mDfgbu0bYlTSIb2BWjAlpNr17bT5c3czEEh8D/zeh7ejNg043AESbrKdbUwjfzyHNcIfNomFWHLd0KK4rTP1ogKFAUBDwfoGOCY+Mcfgxjt1ld/mlIV2GX11d4DFKrBKJ84rR/JQiV/XOqJ5z6fDWhJ2aUexBWdsfVUPsuEHQNG2k7CCz8L12e93jOQFmgYPY3ce9IyxOqQ6VDvhTD8EOFPzOU5eb/sxyuHrHhBzY3MiwpPRO3noyDqHUObHsf+Cv0hDyDMBKg6UpXib93BAtpA7/f4CYem6JYSc9mLLChxaOrw+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bby9qkRWg0ZQJdq19LSHBsnB+6Ft5nzN32PD4bCVDaU=;
 b=bFmarA13S1hvQnSzlCgFXmN3nlVZfwNFy+wMsrIIH3CKNsjF6QAZaggzWQYS0ZccS4IAGg5IzJUvjv3NrG8LnNsVNPXLX5FXMshDioENofmtvbhMiZIYxzi9h14NbBDKbRFyv6VYUiVeAECi+CG6ntFiVMjPgdsTswMMGQaAcOY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH3PR13MB6700.namprd13.prod.outlook.com (2603:10b6:610:1e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 02:34:49 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 02:34:49 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "neilb@suse.de" <neilb@suse.de>
CC: "xiubli@redhat.com" <xiubli@redhat.com>, "brauner@kernel.org"
	<brauner@kernel.org>, "idryomov@gmail.com" <idryomov@gmail.com>,
	"okorniev@redhat.com" <okorniev@redhat.com>, "linux-cifs@vger.kernel.org"
	<linux-cifs@vger.kernel.org>, "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>, "jlayton@kernel.org"
	<jlayton@kernel.org>, "anna@kernel.org" <anna@kernel.org>,
	"miklos@szeredi.hu" <miklos@szeredi.hu>, "anton.ivanov@cambridgegreys.com"
	<anton.ivanov@cambridgegreys.com>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "jack@suse.cz" <jack@suse.cz>, "tom@talpey.com"
	<tom@talpey.com>, "richard@nod.at" <richard@nod.at>,
	"linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"netfs@lists.linux.dev" <netfs@lists.linux.dev>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>, "senozhatsky@chromium.org"
	<senozhatsky@chromium.org>
Subject: Re: [PATCH 1/6] Change inode_operations.mkdir to return struct dentry
 *
Thread-Topic: [PATCH 1/6] Change inode_operations.mkdir to return struct
 dentry *
Thread-Index:
 AQHbg/HWjnUIOhUrC0KpyLDtBmJdLLNSuhOAgAL2awCAAAnogIAAENUAgADWF4CAAj2tgIAABx8A
Date: Wed, 26 Feb 2025 02:34:49 +0000
Message-ID: <50e6b21c644b050a29e159c9484a5e01061434f6.camel@hammerspace.com>
References: <>	,
 <d4aaba8c09f68d8a8264474ce81b9e818eaa60d7.camel@hammerspace.com>
	 <174053575968.102979.1033896985966452059@noble.neil.brown.name>
In-Reply-To: <174053575968.102979.1033896985966452059@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CH3PR13MB6700:EE_
x-ms-office365-filtering-correlation-id: ba2e7ad8-988e-4561-a222-08dd560e2426
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bXVLVmdaRVRHbEh3UjN0WDBlMm5pd1hOUWkyU0ZwUWJjT3duNUNJZFV0a3Jt?=
 =?utf-8?B?TXlGSnZOeVFjWnN5bllqNTBLN2JBVWEwQnV5Z3RkYWNaUUIwcFdvOUhRRU9z?=
 =?utf-8?B?ejlDcnBUa3MwdXZYYWZMOEZtVUcyNU9xbDNIZ0NUSjlXZHpLNjFIQkJZYUFn?=
 =?utf-8?B?bnpKdFE2M0NzYXBsWmNnbE10RDlmQ0ZpYjZGT1lPanJJbkVsUnNTaUhLc1RZ?=
 =?utf-8?B?Y3ZGRzZ4TFhHTDlCQks3Mi9iWU9ESnk5QWJPRlp0em40Qlg1STVMU3lHbER4?=
 =?utf-8?B?WG5VRng0Z0xCSVF0dm5paWtDV1hMUjEzdmI3YlZMR3hBRU1QdVFCUThLQTBT?=
 =?utf-8?B?bEhmWVpISytETVA3YUdSSFNuZVZKUStuRUxhdmZqb2hJVGpTY0xDZTVBVkJu?=
 =?utf-8?B?UHp5T3RpdkxoaVp2c0RUQ21mMUd1WmRvY1E4bUFoa1M0Q3d4RFZ1SWp3VUtD?=
 =?utf-8?B?TGtjZnZJOHo0SC9uWk5MUFZ0MnVRL2xMNDNtVWphMk5Kb1Zvc1g0dXBRTm9W?=
 =?utf-8?B?akhMbWZGVURXMGlub2dLaXBOSmdrOVZ3V0dLSFNHcHZRQ1ZCVkVBYzhOaW1v?=
 =?utf-8?B?WG1odFNpbGZNRG91WHFVTi9pazlCR0I4dFI5RVI1NVFwdDcxdCtqOXVFcno0?=
 =?utf-8?B?NEw0bXN1RGplVk1QYnVwc1prNG9VWlZwai8xdlExQ3lhcC9vVkkyeHNIa0w3?=
 =?utf-8?B?YitvKzdJdjlhV0VZOHNnays3YmI4djVWS2JWZStWZWJIR3NMeGxmWVcyayt0?=
 =?utf-8?B?Z3cxNXZWRE5hQjdxN05MVXFqUlp5ZVpmZ0twLytUZHpmbDgyNUQrOGhuLzE2?=
 =?utf-8?B?ZmM3eXJkMzJ2V1V1ZnNaQTBUNVQwUTlRc0pmMjJ2eXBaOGJCWWNIQXp5RjdB?=
 =?utf-8?B?NVRFM0tIT3FXRGdlVmwyRUJYcUNNV05GQjJpYVJDYjFkNlE2VTltUWVHNVMy?=
 =?utf-8?B?Z1U4RzlmRkQzRUtKMUcwQ2orMWNNQ1VUWHl4Z1ZpRHdNd0taemVqcWQvbjRj?=
 =?utf-8?B?d0Z1enJYY3J1ZDRqREpLMUQzWkFPSXptTng3eklCcUJWa0tob0xiUEN6b3Va?=
 =?utf-8?B?dzcrYnRtSk9RMTF6Tk1reXVRZmlpdGtRcTNDWkFMOWRCZlQ2QnBMUXJ4SWJR?=
 =?utf-8?B?YXVJdVkrWjNUQkY1RG9vem5ZMFR4OFAwbHl5NnczREs3R0pXM1NFcWlNbndi?=
 =?utf-8?B?ZkVNc0gyRjIyeG5kdnMzanlyVWJUdnRjVEtrVVBnSldRZXphUGNPaklabFZp?=
 =?utf-8?B?b3h5dHRNQWlvMThWWDRzT1BXOXVaMmRQQjlCY1RNbDljUFphSFgrK3R5d0V1?=
 =?utf-8?B?MnpiV2VsVXdzbEtPV2trcTE1elN3N2tST0c3Mm5nUFhVdXAyd0NiRms1eko0?=
 =?utf-8?B?dTdiazhMbUNuWG5EV3JhcFRwbnNxTThDbWIrd0pUaVN6bmpkT091cXNPb0ZY?=
 =?utf-8?B?Nm5NSG9HZmE5UEJNWWN1Y1U5eFJRaVdsNmxVK1I3c0pYaE1CLzhCRGREakpY?=
 =?utf-8?B?VEE0WXpzYmh4ZDhiQlFuRjdwNU5FOUpOTjNYZVlGTjZFYnlqMWJlNVhLRGM2?=
 =?utf-8?B?VWVuczhiNTM0bkRiVG1GTDBmY1hRdEpJQWV1YzFPZCtkWENFTUIxemw5MXhk?=
 =?utf-8?B?dXMyeUZObVByeWg3YVpFTTI0VkJVdDlVSFMva0YrS0ZjUTdNSy94c1lWU01n?=
 =?utf-8?B?Zm5NQVZoSFVGdXNoVmg3dmh6ZnBJKzJPa3hvSWE1V3JRMUpncjVTRHJwSFZQ?=
 =?utf-8?B?cHM0MWswNEZGUDV3cHE2ZkdacklzWDNrb29WOTFORmFVNWl1WFRZR3ZnWTBP?=
 =?utf-8?B?dm1ieGU4U0pUazlYbEI3RlFuZFlJU2R1K091MVcyUUVJMXRwZlZ6V08zZjIx?=
 =?utf-8?B?dVNpaTlud3Y1a0xZNHZ3d0NCV0ZkYWtMd2ZObVJmSmg0RVlpNWJBbTNUV3pp?=
 =?utf-8?Q?goJeUt5oe/UdsGdyH4fuf6y9ipVtsGT2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bXI0OTA3ZUJVYTZrQ3U0V1RHUFVVOFd2eHVqRFFPa3dJNXNOVUNUc3VraFRL?=
 =?utf-8?B?YjZZd0ltMEJvYVJzY2NPdUM5cjFPdGpCdFo4V2pYWmxsNjRzakp4TjlVbkcr?=
 =?utf-8?B?S2doMTM3aUx5RkR4cWNEb0JBYUZHWTh5U1VzbXNpRVM5UFBLRklCVnRaenZx?=
 =?utf-8?B?QStWR1lEa21sam03VThJVW5OQ1VYS2JlYmpGZnAzNHF6TW5sOFFOREJPcDkr?=
 =?utf-8?B?OXh2Zk9Ya0dCLzlDZEtuSnBBbWU4MEsyVFJmcWJjSHF6OGRtMTNTNWl0K3pP?=
 =?utf-8?B?UXpCS014UjJ1STh2ZDQ5Njl3a3EzRmcwQ3dyeTUxYU1yc1A4cjdxeS82STBo?=
 =?utf-8?B?VUZUSnBmTEVUQm9RMVdrSWNWelZwN3pSOXc3bWZGL0dsNUovcTkyZVJvbDJm?=
 =?utf-8?B?TThEWEhJTUladDhkeDNGQ3dyR1RoR05UN0pQdEVObFRGYVhzMmU2TnVOell6?=
 =?utf-8?B?UldMSGtuY3VscVpVMmRKdmJzNDNsWDZydnBYRjNtd2QydHJLS2ZNc0g3K0tD?=
 =?utf-8?B?NXNHdlZlclVBaVh5OHU4TGhLWGdNZzBMRkZvdmJBYitKY0NvTlVnZU1zaHJG?=
 =?utf-8?B?QWRaMkxoVUNoQWlNeXZGYW4yNEgzRlpWTS94cmlsK3Ztc1BwZ0pGNjVTSFdr?=
 =?utf-8?B?MC9Najg0akVYM1pBaHpLMytjOWdkL3E4RkxJQUtnM3VUd1hDWFBaKzc5SlNJ?=
 =?utf-8?B?eEhSL3hXbzVvdE54MWI1ZXNDeC9wRXNmVUxlaUNFdTBNbDJiM0k4TjhUMk1p?=
 =?utf-8?B?Q0dLb3hJWDh1L05CeXAxdzBVWHdML3I3amNPNHVHQ3JXVCs4ajVPamFIQndw?=
 =?utf-8?B?SnYwS2ZyYVRydHY4bHNOS25qVVJYdlB2dGpvbFRKTGdxQlhveHVuQkgrTTRO?=
 =?utf-8?B?WnYxeHVibnlSQ2hXTE4vMll3dDlYM2dtRzFIU3VCVDFENlZGN1pXN0tvNmNS?=
 =?utf-8?B?MjV2Tm52cVhIOVlEUkhkd2k4Qks2SkhoSnhYb25OMGFVNWt5N0YrREVuMHFE?=
 =?utf-8?B?bDdpU3NpNXdxVkVQVm1QcklDOEJTL3FhazNaN1d3QjFBWmpXSjVkdG5GUDJz?=
 =?utf-8?B?WDFKTVBSSXpWQXpjQ0d3SVBRaGFvUWx2eEdBdnBuaDZ1WGVmZU01c3ZwSTFo?=
 =?utf-8?B?S2NKblpVS3lzNWlld2MvMjEyb2ZxRHB3cm1QOWZuMVlaUkFsQ1orWVBYWjhP?=
 =?utf-8?B?NlJhTXlxNjl1TXhESWo5cEJKM0RJZmRhL2NkbUxlTzVSWGp6elFNQ3NQYVFP?=
 =?utf-8?B?VFRqMjFWN3FRZVRQYTNsbEFoYnlESmdFNjkzUy9qb2lDYkV6NzhiQi9GSEFv?=
 =?utf-8?B?Q0FndHhQR1JFMi85VXZSS2FucCsxL2dYZ1lYaldLUnRDalJoUS80WjlLVG9U?=
 =?utf-8?B?MVFmRElxSmd1OE0zSUg0Vmo0VGszL0thQld3cDVYVkFiZi85NDRMRC9lZXc2?=
 =?utf-8?B?MzZ3b3FieUNlUlpzbWV1amRTMXcvZFlhV3lmSkhkTkRIcU40aTNaY1RYWDE2?=
 =?utf-8?B?RGJDakFVL1RIUVpBZ21BRTM3OWprTWp5ZlFWUUw1YlRrL0NmeUM1UEJ5cktw?=
 =?utf-8?B?MGZNR05YZDFibkdJa05ObnZEUjlmZEt2cTV4NXJmTml1TVptWDdGeEFQZ2VG?=
 =?utf-8?B?S0kydER3RnNJYkRmMWRUcFVtbXVOWHN5SzRERnlha3pNRzVsOVlwRlpwemg1?=
 =?utf-8?B?WDVZN2htTDd1UWdYYmowSEl6WXc2akhVcTJyM09hcTk4YUd5dGZXRjZUZGgw?=
 =?utf-8?B?N1cvRUhENXhscVVuczNsNVNNRGRIMDBKb1pCejN6YVpyaE55aVpEN3paRWFP?=
 =?utf-8?B?eEJxSGtFMnhuek9sVVl6Ri9jUTBjOFY3aXgwbENEQm5ha3lFNy8zV3pySHNq?=
 =?utf-8?B?bExQUnY0RjVVcmx5U00yL3cvSEl0Y29RKzE4bWRCTFJVeUxBY29tenB5a1or?=
 =?utf-8?B?N0dYUlVLN3VRa0pPdSs0citrbTcwUVFoekNoWUwxVmkyMitYeUFEa2QzQ2hL?=
 =?utf-8?B?akVtOEp2K1B5elpzN3hUQ2ZsdEViZUU4anA2RUtlZG5lcmtpZ2xSUUIrOE5R?=
 =?utf-8?B?WkdGOGNleVhLUGhkK1hIM25CRG9ybEp0eW1BcEY0aktxV2kzb29Pb3Y5a3Rh?=
 =?utf-8?B?UTB6TXBlTUQwM1liYXhscnpScG5Xa0ZBRFI5NTErMVhaSkp4Y0NZYTdrb093?=
 =?utf-8?B?ZHd2Q0FFaDROOFdhT3RlU2JxOWc3SmY4QmNnemxtTS9makFnQkI2eDlSTFR3?=
 =?utf-8?B?dGx2QUdLS1FodHpBSGFOcmVyOE1BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9865405B03B55449ECE93B9E91FEDE6@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2e7ad8-988e-4561-a222-08dd560e2426
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 02:34:49.2507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9BPoL2iiGNBancCWnuHWD6sNs2k4f/uQD0/6dyq6hdtiixE9xmM0F1z5llecDnpbsnQhIgol0kVd7Xx4kDS7nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR13MB6700

T24gV2VkLCAyMDI1LTAyLTI2IGF0IDEzOjA5ICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFR1ZSwgMjUgRmViIDIwMjUsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiBPbiBNb24sIDIw
MjUtMDItMjQgYXQgMTQ6MDkgKzExMDAsIE5laWxCcm93biB3cm90ZToNCj4gPiA+IE9uIE1vbiwg
MjQgRmViIDIwMjUsIEFsIFZpcm8gd3JvdGU6DQo+ID4gPiA+IE9uIE1vbiwgRmViIDI0LCAyMDI1
IGF0IDEyOjM0OjA2UE0gKzExMDAsIE5laWxCcm93biB3cm90ZToNCj4gPiA+ID4gPiBPbiBTYXQs
IDIyIEZlYiAyMDI1LCBBbCBWaXJvIHdyb3RlOg0KPiA+ID4gPiA+ID4gT24gRnJpLCBGZWIgMjEs
IDIwMjUgYXQgMTA6MzY6MzBBTSArMTEwMCwgTmVpbEJyb3duIHdyb3RlOg0KPiA+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gPiA+ICtJbiBnZW5lcmFsLCBmaWxlc3lzdGVtcyB3aGljaCB1c2UgZF9pbnN0
YW50aWF0ZV9uZXcoKSB0bw0KPiA+ID4gPiA+ID4gPiBpbnN0YWxsIHRoZSBuZXcNCj4gPiA+ID4g
PiA+ID4gK2lub2RlIGNhbiBzYWZlbHkgcmV0dXJuIE5VTEwuwqAgRmlsZXN5c3RlbXMgd2hpY2gg
bWF5IG5vdA0KPiA+ID4gPiA+ID4gPiBoYXZlIGFuIElfTkVXIGlub2RlDQo+ID4gPiA+ID4gPiA+
ICtzaG91bGQgdXNlIGRfZHJvcCgpO2Rfc3BsaWNlX2FsaWFzKCkgYW5kIHJldHVybiB0aGUNCj4g
PiA+ID4gPiA+ID4gcmVzdWx0DQo+ID4gPiA+ID4gPiA+IG9mIHRoZSBsYXR0ZXIuDQo+ID4gPiA+
ID4gPiANCj4gPiA+ID4gPiA+IElNTyB0aGF0J3MgYSBiYWQgcGF0dGVybiwgX2VzcGVjaWFsbHlf
IGlmIHlvdSB3YW50IHRvIGdvDQo+ID4gPiA+ID4gPiBmb3INCj4gPiA+ID4gPiA+ICJpbi11cGRh
dGUiDQo+ID4gPiA+ID4gPiBraW5kIG9mIHN0dWZmIGxhdGVyLg0KPiA+ID4gPiA+IA0KPiA+ID4g
PiA+IEFncmVlZC7CoCBJIGhhdmUgYSBkcmFmdCBwYXRjaCB0byBjaGFuZ2UgZF9zcGxpY2VfYWxp
YXMoKSBhbmQNCj4gPiA+ID4gPiBkX2V4YWN0X2FsaWFzKCkgdG8gd29yayBvbiBoYXNoZWQgZGVu
dHJ5cy7CoCBJIHRob3VnaHQgaXQNCj4gPiA+ID4gPiBzaG91bGQNCj4gPiA+ID4gPiBnbyBhZnRl
cg0KPiA+ID4gPiA+IHRoZXNlIG1rZGlyIHBhdGNoZXMgcmF0aGVyIHRoYW4gYmVmb3JlLg0KPiA+
ID4gPiANCj4gPiA+ID4gQ291bGQgeW91IGdpdmUgYSBicmFpbmR1bXAgb24gdGhlIHRoaW5ncyBk
X2V4YWN0X2FsaWFzKCkgaXMNCj4gPiA+ID4gbmVlZGVkDQo+ID4gPiA+IGZvcj8NCj4gPiA+ID4g
SXQncyBhIHJlY3VycmluZyBoZWFkYWNoZSB3aGVuIGRvaW5nIC0+ZF9uYW1lLy0+ZF9wYXJlbnQN
Cj4gPiA+ID4gYXVkaXRzOw0KPiA+ID4gPiBzZWUgZS5nLg0KPiA+ID4gPiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9hbGwvMjAyNDEyMTMwODAwMjMuR0kzMzg3NTA4QFplbklWL8KgZm9yDQo+ID4g
PiA+IHJlbGF0ZWQNCj4gPiA+ID4gbWluaS1yYW50IGZyb20gdGhlIGxhdGVzdCBpdGVyYXRpb24u
DQo+ID4gPiA+IA0KPiA+ID4gPiBQcm9vZiBvZiBjb3JyZWN0bmVzcyBpcyBibG9vZHkgYXdmdWw7
IGl0IGZlZWxzIGxpa2UgdGhlDQo+ID4gPiA+IHByaW1pdGl2ZQ0KPiA+ID4gPiBpdHNlbGYNCj4g
PiA+ID4gaXMgd3JvbmcsIGJ1dCBJJ2QgbmV2ZXIgYmVlbiBhYmxlIHRvIHdyaXRlIGFueXRoaW5n
IGNvbmNpc2UNCj4gPiA+ID4gcmVnYXJkaW5nDQo+ID4gPiA+IHRoZSB0aGluZ3Mgd2UgcmVhbGx5
IHdhbnQgdGhlcmUgOy0vDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBBcyBJIHVuZGVyc3RhbmQg
aXQsIGl0IGlzIG5lZWRlZCAob3Igd2FudGVkKSB0byBoYW5kbGUgdGhlDQo+ID4gPiBwb3NzaWJp
bGl0eQ0KPiA+ID4gb2YgYW4gaW5vZGUgYmVjb21pbmcgInN0YWxlIiBhbmQgdGhlbiByZWNvdmVy
aW5nLsKgIFRoaXMgY291bGQNCj4gPiA+IGhhcHBlbiwNCj4gPiA+IGZvciBleGFtcGxlLCB3aXRo
IGEgdGVtcG9yYXJpbHkgbWlzY29uZmlndXJlZCBORlMgc2VydmVyLg0KPiA+ID4gDQo+ID4gPiBJ
ZiAtPmRfcmV2YWxpZGF0ZSBnZXRzIGEgTkZTRVJSX1NUQUxFIGZyb20gdGhlIHNlcnZlciBpdCB3
aWxsDQo+ID4gPiByZXR1cm4NCj4gPiA+ICcwJw0KPiA+ID4gc28gbG9va3VwX2Zhc3QoKSBhbmQg
b3RoZXJzIHdpbGwgY2FsbCBkX2ludmFsaWRhdGUoKSB3aGljaCB3aWxsDQo+ID4gPiBkX2Ryb3Ao
KQ0KPiA+ID4gdGhlIGRlbnRyeS7CoCBUaGVyZSBhcmUgb3RoZXIgcGF0aHMgb24gd2hpY2ggLUVT
VEFMRSBjYW4gcmVzdWx0IGluDQo+ID4gPiBkX2Ryb3AoKS4NCj4gPiA+IA0KPiA+ID4gSWYgYSBz
dWJzZXF1ZW50IGF0dGVtcHQgdG8gIm9wZW4iIHRoZSBuYW1lIHN1Y2Nlc3NmdWxseSBmaW5kcyB0
aGUNCj4gPiA+IHNhbWUNCj4gPiA+IGlub2RlIHdlIHdhbnQgdG8gcmV1c2UgdGhlIG9sZCBkZW50
cnkgcmF0aGVyIHRoYW4gY3JlYXRlIGEgbmV3DQo+ID4gPiBvbmUuDQo+ID4gPiANCj4gPiA+IEkg
ZG9uJ3QgcmVhbGx5IHVuZGVyc3RhbmQgd2h5LsKgIFRoaXMgY29kZSB3YXMgYWRkZWQgMjAgeWVh
cnMgYWdvDQo+ID4gPiBiZWZvcmUNCj4gPiA+IGdpdC4NCj4gPiA+IEl0IHdhcyBpbnRyb2R1Y2Vk
IGJ5DQo+ID4gPiANCj4gPiA+IGNvbW1pdCA4OWE0NTE3NGI2YjMyNTk2ZWE5OGZhM2Y4OWEyNDNl
MmMxMTg4YTAxDQo+ID4gPiBBdXRob3I6IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0
QGZ5cy51aW8ubm8+DQo+ID4gPiBEYXRlOsKgwqAgVHVlIEphbiA0IDIxOjQxOjM3IDIwMDUgKzAx
MDANCj4gPiA+IA0KPiA+ID4gwqDCoMKgwqAgVkZTOiBBdm9pZCBkZW50cnkgYWxpYXNpbmcgcHJv
YmxlbXMgaW4gZmlsZXN5c3RlbXMgbGlrZSBORlMsDQo+ID4gPiB3aGVyZQ0KPiA+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgIGlub2RlcyBtYXkgYmUgbWFya2VkIGFzIHN0YWxlIGluIG9uZSBpbnN0YW5j
ZSAoY2F1c2luZw0KPiA+ID4gdGhlDQo+ID4gPiBkZW50cnkNCj4gPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoCB0byBiZSBkcm9wcGVkKSB0aGVuIHJlLWVuYWJsZWQgaW4gdGhlIG5leHQgaW5zdGFuY2Uu
DQo+ID4gPiDCoMKgwqAgDQo+ID4gPiDCoMKgwqDCoCBTaWduZWQtb2ZmLWJ5OiBUcm9uZCBNeWts
ZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBmeXMudWlvLm5vPg0KPiA+ID4gDQo+ID4gPiBpbiBoaXN0
b3J5LmdpdA0KPiA+ID4gDQo+ID4gPiBUcm9uZDogZG8geW91IGhhdmUgYW55IG1lbW9yeSBvZiB0
aGlzP8KgIENhbiB5b3UgZXhwbGFpbiB3aGF0IHRoZQ0KPiA+ID4gc3ltcHRvbQ0KPiA+ID4gd2Fz
IHRoYXQgeW91IHdhbnRlZCB0byBmaXg/DQo+ID4gPiANCj4gPiA+IFRoZSBvcmlnaW5hbCBwYXRj
aCB1c2VkIGRfYWRkX3VuaXF1ZSgpIGZvciBsb29rdXAgYW5kIGF0b21pY19vcGVuDQo+ID4gPiBh
bmQNCj4gPiA+IHJlYWRkaXIgcHJpbWUtZGNhY2hlLsKgIFdlIG5vdyBvbmx5IHVzZSBpdCBmb3Ig
djQgYXRvbWljX29wZW4uwqANCj4gPiA+IE1heWJlDQo+ID4gPiB3ZQ0KPiA+ID4gZG9uJ3QgbmVl
ZCBpdCBhdCBhbGw/wqAgT3IgbWF5YmUgd2UgbmVlZCB0byByZXN0b3JlIGl0IHRvIHRob3NlDQo+
ID4gPiBvdGhlcg0KPiA+ID4gY2FsbGVycz8gDQo+ID4gPiANCj4gPiANCj4gPiAyMDA1PyBUaGF0
IGxvb2tzIGxpa2UgaXQgd2FzIHRyeWluZyB0byBkZWFsIHdpdGggdGhlIHVzZXJzcGFjZSBORlMN
Cj4gPiBzZXJ2ZXIuIEkgY2FuJ3QgcmVtZW1iZXIgd2hlbiBpdCB3YXMgZ2l2ZW4gdGhlIGFiaWxp
dHkgdG8gdXNlIHRoZQ0KPiA+IGlub2RlDQo+ID4gZ2VuZXJhdGlvbiBjb3VudGVyLCBidXQgSSdt
IHByZXR0eSBzdXJlIHRoYXQgaW4gMjAwNSB0aGVyZSB3ZXJlDQo+ID4gcGxlbnR5DQo+ID4gb2Yg
c2V0dXBzIG91dCB0aGVyZSB0aGF0IGhhZCB0aGUgb2xkZXIgdmVyc2lvbiB0aGF0IHJldXNlZA0K
PiA+IGZpbGVoYW5kbGVzDQo+ID4gKGR1ZSB0byBpbm9kZSBudW1iZXIgcmV1c2UpLiBTbyB5b3Ug
d291bGQgZ2V0IHNwdXJpb3VzIEVTVEFMRQ0KPiA+IGVycm9ycw0KPiA+IHNvbWV0aW1lcyBkdWUg
dG8gaW5vZGUgbnVtYmVyIHJldXNlLCBzb21ldGltZXMgYmVjYXVzZSB0aGUNCj4gPiBmaWxlaGFu
ZGxlDQo+ID4gZmVsbCBvdXQgb2YgdGhlIHVzZXJzcGFjZSBORlMgc2VydmVyJ3MgY2FjaGUuDQo+
IA0KPiBTbyB0aGlzIHdhcyBsaWtlbHkgZG9uZSB0byB3b3JrLWFyb3VuZCBrbm93biB3ZWFrbmVz
c2VzIGluIE5GUw0KPiBzZXJ2ZXJzDQo+IGF0IHRoZSB0aW1lLg0KPiANCj4gVGhlIG9yaWdpbmFs
IGRfYWRkX3VuaXF1ZSgpIHdhcyB1c2VkIGluIG5mc19sb29rdXAoKQ0KPiBuZnNfYXRvbWljX2xv
b2t1cCgpDQo+IGFuZCBuZnNfcmVhZGRpcl9sb29rdXAoKSBidXQgdGhlIGN1cnJlbnQgZGVzY2Vu
ZGVudCBkX2V4YWN0X2FsaWFzKCkNCj4gaXMNCj4gb25seSB1c2VkIGluIF9uZnM0X29wZW5fYW5k
X2dldF9zdGF0ZSgpIGNhbGxlZCBvbmx5IGJ5IG5mczRfZG9fb3BlbigpDQo+IHdoaWNoIGlzIG9u
bHkgdXNlZCBpbiBuZnM0X2F0b21pY19vcGVuKCkgYW5kIG5mczRfcHJvY19jcmVhdGUoKS4NCj4g
DQo+IFNvIHRoZSB1c2FnZSBpbiAnbG9va3VwJyBhbmQgJ3JlYWRkaXInIGhhdmUgZmFsbGVuIGJ5
IHRoZSB3YXlzaWRlDQo+IHdpdGgNCj4gbm8gYXBwYXJlbnQgbmVnYXRpdmUgY29uc2VxdWVuY2Vz
LsKgIA0KPiBUaGUgb2xkIE5GUyBzZXJ2ZXJzIGhhdmUgcHJvYmFibHkgYmVlbiBmaXhlZC4NCj4g
DQo+IFNvIGRvIHlvdSBoYXZlIGFueSBjb25jZXJucyB3aXRoIHVzIGRpc2NhcmRpbmcgZF9leGFj
dF9hbGlhcygpIGFuZA0KPiBvbmx5DQo+IHVzaW5nIGRfc3BsaWNlX2FsaWFzKCkgaW4gX25mczRf
b3Blbl9nZXRfc3RhdGUoKSA/Pw0KPiANCg0KQUZBSUssIHRoZXJlIHdlcmUgbmV2ZXIgYW55IE5G
U3Y0IHNlcnZlcnMgaW4gcHVibGljIHVzZSB0aGF0IG1pbWlja2VkDQp0aGUgcXVpcmtzIG9mIHRo
ZSB1c2Vyc3BhY2UgTkZTdjIvTkZTdjMgc2VydmVyLiBTbyBJJ20gdGhpbmtpbmcgaXQNCnNob3Vs
ZCBiZSBzYWZlIHRvIHJldGlyZSBkX2V4YWN0X2FsaWFzLg0KDQotLSANClRyb25kIE15a2xlYnVz
dA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVi
dXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

