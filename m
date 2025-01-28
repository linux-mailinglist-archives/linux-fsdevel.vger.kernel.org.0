Return-Path: <linux-fsdevel+bounces-40255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9825CA2143D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 23:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607301885ED8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 22:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF741E1027;
	Tue, 28 Jan 2025 22:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y2j2GxSx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3897195B1A;
	Tue, 28 Jan 2025 22:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738103472; cv=fail; b=ZnVqs6m1BMuX7VkNoi+j1xSxhtQUCFXnj65C9FLkc87AQijcl5dop0Qyiiy41CQsZhrVR4bApVhVRZSLwrC0I73ZGxOPynYlDIRT1lSNHQbU72n3Q9nzoyKY+Ihz9GH7awE4xFTJshGyFHFYRi1taKo06NU/Os4hgYvEdBLlLN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738103472; c=relaxed/simple;
	bh=6ZDwj1FksmjF9u06oJ5cGpHfppCtruQnSXx3514spiY=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=lnSfd+qQYRQftm3T55EQaGbl3cEMi5IgZMLtgBdy7slVDQbfZ/8oD2P/sspubM6tddbK9fK4QLu2LxgwcVUEZyinEs+MLGX6u5S8nRCD6PmBtNSeiiKbIAgsDJRrJsf0JYuqBY97npVYiD+xonNPcpv3IoPNKvlwc1MmYfW8blM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y2j2GxSx; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SGfg7R023561;
	Tue, 28 Jan 2025 22:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=6ZDwj1FksmjF9u06oJ5cGpHfppCtruQnSXx3514spiY=; b=Y2j2GxSx
	riYhXHEtsdNP5njt7gNjC6nCBuVL6H6CotYbfa5eTurQOIpDq6XknVGWcbmrTY3X
	JnusBDeoNoz5yqTazdU5B83YOYB32xei1o+32EHvQxrPfvF61MS2epTV2sYK0PAz
	KiUR78y0vt6/z5junphOjy2R3NCFiWkp7/fzeBb2qhlVTbawWvRH5+R++4CA++s7
	UckMetT4t7ycDTNgEs6pG5ViBqW7IEyLqyu7/+mPCS/ZvPFRAML+kElAC0f4Zaka
	6x2Cwi+BlcCnc/Jrp3V3ZzQRZN5TNC9jyknY6gsYV3UwSSfCQE5UCtvnmuhZppzp
	KOmuDM+lBb60JQ==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44es27mnw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 22:30:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTXPcejM2utcYdrffgQmdS8vpFm/KC1KHcKsN7FfvSZ1p1s9pi06excNxjGAkRmx4tUn8gKfHKc0jnWcg5AayEftMN/j/Cq6Vs4BzzPpKTWcbuXFX8lDXszbk+WZqJYiYhlndClbDm+K5bo+Jv5D/I8tEYhW8rMEjTjbTMwCuvCRCUVVQiBtDiEWOXagsUqsx0OGD6FMn0+IysK4eNuENm23OCmeQI+nzekIE2uRGibq079uSp3W/IPC35ddYfKEW4IVgRmlvqgsYsMQwh6NehbMH7cJQyGkEJ8WoUGnESsU/P1hbjvnFxA5xZP/gjvCRBbHnk5zMrvux/IJKCgTwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZDwj1FksmjF9u06oJ5cGpHfppCtruQnSXx3514spiY=;
 b=Yf9UlphmIwMOwRKv8VBIRLu4spbqOumrHWsZvWzffYS9KPAJZyG+7n+EpOgKQIQpncEE1IojyaFkQQ8LP8gQyV9jNN3M6joyX9p1BRw3JuNlcSxkeukgqy6Dx71FeK/N/WYJjAj+LPepJma22ppOkXSqVIYGM8TSL/TybCdC1zm0dG+kNMduwb9PsA1yKVkV+PGkcaE4hProD8PoyshNEcPOTDY0a4fqyI6VhklCQ2a9En/1lQqtDDe5NwIisJV45WRgEy8gcZLSPLmkPHp5ZfD0sdn8AJnUV7KJhSPPfya/W6xfoBJoJKa4OALiFwEoRM4xy44L92BMl7JTwA3/Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH7PR15MB5428.namprd15.prod.outlook.com (2603:10b6:510:1fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 22:30:56 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 22:30:55 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "hans@owltronix.com" <hans@owltronix.com>
CC: "Johannes.Thumshirn@wdc.com" <Johannes.Thumshirn@wdc.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>,
        "javier.gonz@samsung.com"
	<javier.gonz@samsung.com>
Thread-Topic: [EXTERNAL] Re: [RFC PATCH] Introduce generalized data
 temperature estimation framework
Thread-Index: AQHbbjjHEmAPuPJvLUyENDU0Npkf+rMmalWAgARGDQCAAG+0AIAAxXAAgADmn4A=
Date: Tue, 28 Jan 2025 22:30:55 +0000
Message-ID: <a09665a84d11c3d184346b1f55515ac912b061c3.camel@ibm.com>
References: <20250123202455.11338-1-slava@dubeyko.com>
	 <fd012640-5107-4d44-9572-4dffb2fd4665@wdc.com>
	 <f44878932fd26bb273c7948710b23b0e2768852a.camel@ibm.com>
	 <CANr-nt2+Yk5fVVjU2zs+F1ZrLZGBBy3HwNOuYOK9smDeoZV9Rg@mail.gmail.com>
	 <063856b9c67289b1dd979a12c8cfe8d203786acc.camel@ibm.com>
	 <CANr-nt2bbienm=L48uEgjmuLqMnFBXUfHVZfEo3VBFwUsutE6A@mail.gmail.com>
In-Reply-To:
 <CANr-nt2bbienm=L48uEgjmuLqMnFBXUfHVZfEo3VBFwUsutE6A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH7PR15MB5428:EE_
x-ms-office365-filtering-correlation-id: 602e84e2-3ce9-4665-9c3f-08dd3feb6e63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V3MrRFFwbk5zL3FPbHN2QzYzNjhWRXpieW5LWkt1dHg2ZHM3Q1V4emQvMTcz?=
 =?utf-8?B?MGUwZUE3em43eWF3RWpMQjYxMW5FUzA2RDhvSW1ZUEJNZTNJWC9ST1Rzd0Nn?=
 =?utf-8?B?SW5GRVlOZFYzLzJEbUovNXAyQUJGbjN1RUgxTDRwamw3ajdncDRXSXNKb0w3?=
 =?utf-8?B?RTJDbTEvNDFWOUh1WjhVL3BNTm8yNXpzUVk4Q04yQjhtY3gxZ0gzS2tWdTVh?=
 =?utf-8?B?eFVZby9Hb25xaTduWXBQOVp5QXFWb0szNXY4S1lZQnRZSFlXcGVhZHNSbGxq?=
 =?utf-8?B?TzFZb3ZxYmwzejhZaUJYTGp0Vi9vMldHWDBKd0wvKzJydUdHK3hZcCtRRUUx?=
 =?utf-8?B?THJDdjlBaThGZkMzZk95dDBOUy9XVVpRa3VBTjRrTTdqdTM3UjZhbU1ETGwz?=
 =?utf-8?B?dytFckUwSnY1YU5IenNiS29jMW94djBPT09URXZYOGtKWlNVN0ZqUHpwQVFF?=
 =?utf-8?B?bWNHWXdrTStQYTB2QkhPaUdvYzhrNlFZMVNjNjRIU2J1M1BiSEkzTTNMN2Z4?=
 =?utf-8?B?SHp2WGd1ZG9mQ1pxamMzRHBKZU1Da0VWaUViYTh6SFZoWVlHYkJFL0JqRllR?=
 =?utf-8?B?aVFRaGVaYjc1blpDQllaS0VrWjNsTU9pcWYyRnVLakg2TEtqelJzRGZwa3dk?=
 =?utf-8?B?OEVaWGxtR0VlazQ4YTZzbTFHckpzOGhUOGcwQVhQM3JnN3laV2U1OGU0d1A3?=
 =?utf-8?B?aDB3dW1xdXhNUXBxN0ppK3lPSHAyZGJNVjEyVzlkVW1vZlF4VTZMZFZUREFi?=
 =?utf-8?B?MW9rbjBXQTR2K211aVJ5Y3ZMOUJjSjRNM0x4NnFlRTgzeXpKUVRHbHZGYjRK?=
 =?utf-8?B?bHVneUx3bktVakpnaEFJQk8xQlYvM3NmUDYvY09BR2owYzFraUFMc05aRTVi?=
 =?utf-8?B?SjVhSCtjd24rdmdQb2d4dVNHRVJOOC94MGJ1a2hUNEVjMW9YVFVwSTBIWUM4?=
 =?utf-8?B?dnZsR0FJNnJsa2hVaktkOXJWTVVXOVhjU0NLZi9GWG0reW96ZVlqRGh0TlE2?=
 =?utf-8?B?UGNwbmIxWUlVY2VxdVdrNnJkUDNVWHNNSUdtRFRjQmZTOWdHVGt3UWg5c0t0?=
 =?utf-8?B?Ny9laUg5Vk92L0VXcnVERUgvdk40TWFuSEorSDNjVFhBVUl1OGsvOWwrNVI1?=
 =?utf-8?B?dkVJZzhkQm5zYUdEV0xkU01aMC9zN3lDV1MvaDFDMWtzV2ptekIxeElZMlJF?=
 =?utf-8?B?VFppSjBuU3VEOWs1RWZTNXoxdVJUWlkveGMyV3VOZFFSa29teUQvRGVva3Zz?=
 =?utf-8?B?WmtFbEtJK2Q2Y2NzbERIbkx4VDlFVE1XbmczejZtWVhPSU9scnlZVXNGOWpv?=
 =?utf-8?B?TlVVYUZRMFAxNGxlcjNxeDVoandBNmllcTA0clcvU1RpVUJjYUxBcVN2a1Vj?=
 =?utf-8?B?bkVSSi9Xais0QU05NTYrZGxtVVVKSmkyTmJnSlBLWldlNGlaK21SZTRjdFNr?=
 =?utf-8?B?c2Vxa3RidG9EelBSNFBKbWpLdWlPS2RCekxXY0F0M2ZjdEYydGg3ZFVNanZt?=
 =?utf-8?B?OXlWSTJiMVk5WXZNdnV6N214YktMTW05MFcrM1BkT21QZUVGWThxc3A2Qnlx?=
 =?utf-8?B?WXVVSDJvY0l6Ny9QOGt1VCs2eisxMWtCMTR2ZStkYjFZR3hsODVRa2hyaWdk?=
 =?utf-8?B?SWY5NjB6U3pqRjhmT2V6SjJaaVlsYmsxSVdwUDF3aHhYY3BWcUR1b2lpY21L?=
 =?utf-8?B?MEFXakFJM3BhcWNtaTZNWGFBN0lsbVhzUSt4bGNTR2hEaTlWWFYvZ0FhNW9E?=
 =?utf-8?B?NnFuQnR5VWpjTlFuWnFUVzFYbDcySVIyQ01WV0E5em1MMS9GbDZuVjViRkVE?=
 =?utf-8?B?RnVUMGN5Mnk4QkNFZWl3QjhmcFZMRHRrcVAyeGU5YUpQOGhZWGkzVytFeUp4?=
 =?utf-8?B?VlFvRkU1cUF4S2hUN0FRV2RKVWVoSnAzQ00yQzIrandnWHRKNUJlY01YUFRy?=
 =?utf-8?Q?y2NFkVX/85DW2FjTYSTRdSzOvXZPoDnS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZmUyQlNUWmk0OUxsb0MvWDZyd1o1dFZWa0txOEZrQjJBNlVWYldRcW9LaHNw?=
 =?utf-8?B?L05pbFdNSUR6ZVdxZktQSjZkTDhjN0ZQSEYwRWxkdXdKM3E3cDVhNjFRQXAr?=
 =?utf-8?B?QmhkWW5hdXE2WnR0V2JmelFxblpsSjU0RHNna3dVQmNYeW5IVVlHMlpRaGtm?=
 =?utf-8?B?MkVtTWRFWHpCTjNhUENXR21MelMxa2loelpmSG9qT0dMQVJZc2JtdjUxbm9K?=
 =?utf-8?B?d0pTY1l5T3d4UmtPNHdocXFodmR5ZXl6RkdqaWdRQk1tdis2NFZjUERzWXV5?=
 =?utf-8?B?NDFPYS9HWnBTcUNTNFd6aXQreDJkUllqTFdQUEZva2crQnBtcm5ta1Jnc2lH?=
 =?utf-8?B?TGwrWERSZktrc1NMY2JlS2FUWnc5a0xoTkRLa3Vtdit6UDZWUHlEOXlKaHBQ?=
 =?utf-8?B?UVZmMmh6d1RkU0RrOW9Ma1BjMGZMTUFSay9BeFJKM2VDSndNRWhTaVBnUitx?=
 =?utf-8?B?VGMvMUFxQVhlZzhxMmd6R25nK0R4WFJKWi9vT3JpWFJQNTJCMGlOOXlzVU9R?=
 =?utf-8?B?cU4wMFRNRFhGMk5JYXRNNWVtWDZKb1lBL0xnNVk4ZVNvYmVERDkwVlNIeGk3?=
 =?utf-8?B?NVAzaDA0ZjNFMnVGcDhHNzNOb0VmWDV6L29yUzFRUThFRVRRSlZ2TjVORVpl?=
 =?utf-8?B?bFNvbnBLOGI4TEFGMmErbGFMdlJQTUNZVlBNZFE3Y3h3WlRqdWdwMG5sVEpO?=
 =?utf-8?B?QXJvWnlDQmZ2WGI1S0xKNndZOHNtL3Z2a05iVkF5SS9vcDN4bTRGUGcwcmFE?=
 =?utf-8?B?Rk56ejc2dEdNTUtGMDNMVUM3RkowWFZ3NTNReVEvbkJ6K0ovVHgxNllRTVo4?=
 =?utf-8?B?SmxmaWZ1QWlnR1kvQ0V4NHJXNTV1R0E4MGQwZVI4YThSOVZ4RGdCL2pVc1hh?=
 =?utf-8?B?VHhMMWhyMEZ0WDB3NXdwNHB3TEsrRDRVZG9pbi85emdYVlZPS1IrL21wWUV2?=
 =?utf-8?B?SVJyVlZXdU5YOHNLSFFNVHZwTStTM09vOTBPVUlNL09SSjBqSklGeXQ5OENL?=
 =?utf-8?B?aU9KNStiWCs3Um43UU9HYzhjTm1Mbjg0UlBRTTk4K1FGM3lDQnNUOGU0dHdx?=
 =?utf-8?B?NG5WMi9PSWhTWjY1bWd5Q0h0MDVVTHNPV0E2ZkNBbHRlcnlsTWFiRjlwaUJY?=
 =?utf-8?B?M3lyNm9IYlhKdCt4OGp6WXI2SWRFY1lqSVZkd1ZHQWdDcVlsWXVRVWZNMVNr?=
 =?utf-8?B?dXFaait2dTdoczV2QTZYMGhsMnlpQk5xZ3gwOUNvM09ZaWd0N2lFZUJ6WmRp?=
 =?utf-8?B?VWgweElqMUUvV05QYVRtaFNsNU5tL3JRTFo4eXJMZ2k0bkNYQ0I4OWpBaXdp?=
 =?utf-8?B?Qm5oVVBJY3RILy9PQjNtdnkvd3ZMa29DZ0J5UXlYQmx3YVozRDZzMkJUNmZV?=
 =?utf-8?B?dm9GTG9FMHI2RlpPLytvRFNhekJvdkREaktXUFVHSjJ1TkpSa0RhUWdsTVBS?=
 =?utf-8?B?Q3hHdnVwcnZHWExvem8rUXZhdE40R0dmVStDWE9XVFlGbFRDUEtjLzBEdFFx?=
 =?utf-8?B?L1ZaT2R5RmJnQ0ZuQ2dvd0ZNSnh2RXkzbDlrd1lidWdFNW5aRXhVcWh2bHBp?=
 =?utf-8?B?Z2F2dE1xN25CV21CdTVUeTROQmhuQTVEN1dJVUZYY2tVYXQyMThEZDZWcGdG?=
 =?utf-8?B?azNUN1VPbXFNVnpieUt3aDEwRXUrTTRqMFpVbS85QVJKZ2ZZR2QxclZIVGFp?=
 =?utf-8?B?a01hVzZmV3NicnNaWmw3TGViZHAvWGI2M0YzTnBwZ2Vob3VqYmtucTc4MFpO?=
 =?utf-8?B?M0w1bXpROFNBTzh1ZDRGdzZsRE9Ba2ludGw1WXpsWWlPc2drMEJRV1h4QkdL?=
 =?utf-8?B?Y0dIeTJsYmRwSzVZcmdycThxTzFYTnc0WmtDOWpTMTRmeDBUNERxZ1RzcE1n?=
 =?utf-8?B?OU11UE5pbGpwYmNLY1F6MmFLUHBGQ0lqdStaUU1PZkRjWTRBTnBMbHBBbkts?=
 =?utf-8?B?eThZQzB4dGhIM1BDRHgyUzZrRExvcXVnUW1GWWgzVFRQUDRMYS9Xb3BxQUho?=
 =?utf-8?B?eWZPL1NKam9mVEtkWEVzc3lpMGI0K3Y3M0dON0Q5MGdDT2FMc1NXcGlJL2lk?=
 =?utf-8?B?TFJuRjdkMDVLckRYelJZWDRwODExZ2ZhSlhneXR5N2o1Sm8xMDRmTGhDckYy?=
 =?utf-8?B?V25HeFY2a1lad0FHdzQxa3dtVFkxQXlCOEVGeGJSOWN0enNkQXBnREZDUDdM?=
 =?utf-8?Q?7it80bRYid1yu3Ot7c58vf0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <422EBA51F032AE4799745CFAFACC4B99@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 602e84e2-3ce9-4665-9c3f-08dd3feb6e63
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2025 22:30:55.8170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qSUfgsXewOE9YA7OgMmixU/r33hQO6CeRwlMf6L/ett1q9YDjCytE2XJ1yKRG6QCf9MAcei9JLHhgOjdELXGhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5428
X-Proofpoint-ORIG-GUID: UyadLC2uS8DrvJgchWkjgz-KVx7q1tLZ
X-Proofpoint-GUID: UyadLC2uS8DrvJgchWkjgz-KVx7q1tLZ
Subject: RE: [RFC PATCH] Introduce generalized data temperature estimation framework
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=874 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280165

T24gVHVlLCAyMDI1LTAxLTI4IGF0IDA5OjQ1ICswMTAwLCBIYW5zIEhvbG1iZXJnIHdyb3RlOg0K
PiBPbiBNb24sIEphbiAyNywgMjAyNSBhdCA5OjU54oCvUE0gVmlhY2hlc2xhdiBEdWJleWtvDQo+
IDxTbGF2YS5EdWJleWtvQGlibS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIE1vbiwgMjAyNS0w
MS0yNyBhdCAxNToxOSArMDEwMCwgSGFucyBIb2xtYmVyZyB3cm90ZToNCj4gPiA+IE9uIEZyaSwg
SmFuIDI0LCAyMDI1IGF0IDEwOjAz4oCvUE0gVmlhY2hlc2xhdiBEdWJleWtvDQo+ID4gPiA8U2xh
dmEuRHViZXlrb0BpYm0uY29tPiB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IA0KDQo8c2tpcHBl
ZD4NCg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBbSE9XIFRPIFVTRSBUSEUgQVBQUk9BQ0hd
DQo+ID4gPiA+ID4gPiBUaGUgbGlmZXRpbWUgb2YgZGF0YSAidGVtcGVyYXR1cmUiIHZhbHVlIGZv
ciBhIGZpbGUNCj4gPiA+ID4gPiA+IGNhbiBiZSBleHBsYWluZWQgYnkgc3RlcHM6ICgxKSBpZ2V0
KCkgbWV0aG9kIHNldHMNCj4gPiA+ID4gPiA+IHRoZSBkYXRhICJ0ZW1wZXJhdHVyZSIgb2JqZWN0
OyAoMikgZm9saW9fYWNjb3VudF9kaXJ0aWVkKCkNCj4gPiA+ID4gPiA+IG1ldGhvZCBhY2NvdW50
cyB0aGUgbnVtYmVyIG9mIGRpcnR5IG1lbW9yeSBwYWdlcyBhbmQNCj4gPiA+ID4gPiA+IHRyaWVz
IHRvIGVzdGltYXRlIHRoZSBjdXJyZW50IHRlbXBlcmF0dXJlIG9mIHRoZSBmaWxlOw0KPiA+ID4g
PiA+ID4gKDMpIGZvbGlvX2NsZWFyX2RpcnR5X2Zvcl9pbygpIGRlY3JlYXNlIG51bWJlciBvZiBk
aXJ0eQ0KPiA+ID4gPiA+ID4gbWVtb3J5IHBhZ2VzIGFuZCBpbmNyZWFzZXMgbnVtYmVyIG9mIHVw
ZGF0ZWQgcGFnZXM7DQo+ID4gPiA+ID4gPiAoNCkgZm9saW9fYWNjb3VudF9kaXJ0aWVkKCkgYWxz
byBkZWNyZWFzZXMgZmlsZSdzDQo+ID4gPiA+ID4gPiAidGVtcGVyYXR1cmUiIGlmIHVwZGF0ZXMg
aGFzbid0IGhhcHBlbmVkIHNvbWUgdGltZTsNCj4gPiA+ID4gPiA+ICg1KSBmaWxlIHN5c3RlbSBj
YW4gZ2V0IGZpbGUncyB0ZW1wZXJhdHVyZSBhbmQNCj4gPiA+ID4gPiA+IHRvIHNoYXJlIHRoZSBo
aW50IHdpdGggYmxvY2sgbGF5ZXI7ICg2KSBpbm9kZQ0KPiA+ID4gPiA+ID4gZXZpY3Rpb24gbWV0
aG9kIHJlbW92ZXMgYW5kIGZyZWUgdGhlIGRhdGEgInRlbXBlcmF0dXJlIg0KPiA+ID4gPiA+ID4g
b2JqZWN0Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEkgZG9uJ3Qgd2FudCB0byBwb3VyIGdhc29s
aW5lIG9uIG9sZCBmbGFtZSB3YXJzLCBidXQgd2hhdCBpcyB0aGUNCj4gPiA+ID4gPiBhZHZhbnRh
Z2Ugb2YgdGhpcyBhdXRvLW1hZ2ljIGRhdGEgdGVtcGVyYXR1cmUgZnJhbWV3b3JrIHZzIHRoZSBl
eGlzdGluZw0KPiA+ID4gPiA+IGZyYW1ld29yaz8NCj4gPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4g
PiA+IFRoZXJlIGlzIG5vIG1hZ2ljIGluIHRoaXMgZnJhbWV3b3JrLiA6KSBJdCdzIHNpbXBsZSBh
bmQgY29tcGFjdCBmcmFtZXdvcmsuDQo+ID4gPiA+IA0KPiA+ID4gPiA+ICAnZW51bSByd19oaW50
JyBoYXMgdGVtcGVyYXR1cmUgaW4gdGhlIHJhbmdlIG9mIG5vbmUsIHNob3J0LA0KPiA+ID4gPiA+
IG1lZGl1bSwgbG9uZyBhbmQgZXh0cmVtZSAod2hhdCBldmVyIHRoYXQgbWVhbnMpLCBjYW4gYmUg
c2V0IGJ5IGFuDQo+ID4gPiA+ID4gYXBwbGljYXRpb24gdmlhIGFuIGZjbnRsKCkgYW5kIGlzIHBs
dW1iZWQgZG93biBhbGwgdGhlIHdheSB0byB0aGUgYmlvDQo+ID4gPiA+ID4gbGV2ZWwgYnkgbW9z
dCBGU2VzIHRoYXQgY2FyZS4NCj4gPiA+ID4gDQo+ID4gPiA+IEkgc2VlIHlvdXIgcG9pbnQuIEJ1
dCB0aGUgJ2VudW0gcndfaGludCcgZGVmaW5lcyBxdWFsaXRhdGl2ZSBncmFkZXMgYWdhaW46DQo+
ID4gPiA+IA0KPiA+ID4gPiBlbnVtIHJ3X2hpbnQgew0KPiA+ID4gPiAgICAgICAgIFdSSVRFX0xJ
RkVfTk9UX1NFVCAgICAgID0gUldIX1dSSVRFX0xJRkVfTk9UX1NFVCwNCj4gPiA+ID4gICAgICAg
ICBXUklURV9MSUZFX05PTkUgICAgICAgICA9IFJXSF9XUklURV9MSUZFX05PTkUsDQo+ID4gPiA+
ICAgICAgICAgV1JJVEVfTElGRV9TSE9SVCAgICAgICAgPSBSV0hfV1JJVEVfTElGRV9TSE9SVCwg
IDwtLSBIT1QgZGF0YQ0KPiA+ID4gPiAgICAgICAgIFdSSVRFX0xJRkVfTUVESVVNICAgICAgID0g
UldIX1dSSVRFX0xJRkVfTUVESVVNLCA8LS0gV0FSTSBkYXRhDQo+ID4gPiA+ICAgICAgICAgV1JJ
VEVfTElGRV9MT05HICAgICAgICAgPSBSV0hfV1JJVEVfTElGRV9MT05HLCAgIDwtLSBDT0xEIGRh
dGENCj4gPiA+ID4gICAgICAgICBXUklURV9MSUZFX0VYVFJFTUUgICAgICA9IFJXSF9XUklURV9M
SUZFX0VYVFJFTUUsDQo+ID4gPiA+IH0gX19wYWNrZWQ7DQo+ID4gPiA+IA0KPiA+ID4gPiBGaXJz
dCBvZiBhbGwsIGFnYWluLCBpdCdzIGhhcmQgdG8gY29tcGFyZSB0aGUgaG90bmVzcyBvZiBkaWZm
ZXJlbnQgZmlsZXMNCj4gPiA+ID4gb24gc3VjaCBxdWFsaXRhdGl2ZSBiYXNpcy4gU2Vjb25kbHks
IHdobyBkZWNpZGVzIHdoYXQgaXMgaG90bmVzcyBvZiBhIHBhcnRpY3VsYXINCj4gPiA+ID4gZGF0
YT8gUGVvcGxlIGNhbiBvbmx5IGd1ZXNzIG9yIGFzc3VtZSB0aGUgbmF0dXJlIG9mIGRhdGEgYmFz
ZWQgb24NCj4gPiA+ID4gZXhwZXJpZW5jZSBpbiB0aGUgcGFzdC4gQnV0IHdvcmtsb2FkcyBhcmUg
Y2hhbmdpbmcgYW5kIGV2b2x2aW5nDQo+ID4gPiA+IGNvbnRpbnVvdXNseSBhbmQgaW4gcmVhbC10
aW1lIG1hbm5lci4gVGVjaG5pY2FsbHkgc3BlYWtpbmcsIGFwcGxpY2F0aW9uIGNhbg0KPiA+ID4g
PiB0cnkgdG8gZXN0aW1hdGUgdGhlIGhvdG5lc3Mgb2YgZGF0YSwgYnV0LCBhZ2FpbiwgZmlsZSBz
eXN0ZW0gY2FuIHJlY2VpdmUNCj4gPiA+ID4gcmVxdWVzdHMgZnJvbSBtdWx0aXBsZSB0aHJlYWRz
IGFuZCBtdWx0aXBsZSBhcHBsaWNhdGlvbnMuIFNvLCBhcHBsaWNhdGlvbg0KPiA+ID4gPiBjYW4g
Z3Vlc3MgYWJvdXQgcmVhbCBuYXR1cmUgb2YgZGF0YSB0b28uIEVzcGVjaWFsbHksIG5vYm9keSB3
b3VsZCBsaWtlDQo+ID4gPiA+IHRvIGltcGxlbWVudCBkZWRpY2F0ZWQgbG9naWMgaW4gYXBwbGlj
YXRpb24gZm9yIGRhdGEgaG90bmVzcyBlc3RpbWF0aW9uLg0KPiA+ID4gPiANCj4gPiA+ID4gVGhp
cyBmcmFtZXdvcmsgaXMgaW5vZGUgYmFzZWQgYW5kIGl0IHRyaWVzIHRvIGVzdGltYXRlIGZpbGUn
cw0KPiA+ID4gPiAidGVtcGVyYXR1cmUiIG9uIHF1YW50aXRhdGl2ZSBiYXNpcy4gQWR2YW50YWdl
cyBvZiB0aGlzIGZyYW1ld29yazoNCj4gPiA+ID4gKDEpIHdlIGRvbid0IG5lZWQgdG8gZ3Vlc3Mg
YWJvdXQgZGF0YSBob3RuZXNzLCB0ZW1wZXJhdHVyZSB3aWxsIGJlDQo+ID4gPiA+IGNhbGN1bGF0
ZWQgcXVhbnRpdGF0aXZlbHk7ICgyKSBxdWFudGl0YXRpdmUgYmFzaXMgZ2l2ZXMgb3Bwb3J0dW5p
dHkNCj4gPiA+ID4gZm9yIGZhaXIgY29tcGFyaXNvbiBvZiBkaWZmZXJlbnQgZmlsZXMnIHRlbXBl
cmF0dXJlOyAoMykgZmlsZSdzIHRlbXBlcmF0dXJlDQo+ID4gPiA+IHdpbGwgY2hhbmdlIHdpdGgg
d29ya2xvYWQocykgY2hhbmdpbmcgaW4gcmVhbC10aW1lOyAoNCkgZmlsZSdzDQo+ID4gPiA+IHRl
bXBlcmF0dXJlIHdpbGwgYmUgY29ycmVjdGx5IGFjY291bnRlZCB1bmRlciB0aGUgbG9hZCBmcm9t
IG11bHRpcGxlDQo+ID4gPiA+IGFwcGxpY2F0aW9ucy4gSSBiZWxpZXZlIHRoZXNlIGFyZSBhZHZh
bnRhZ2VzIG9mIHRoZSBzdWdnZXN0ZWQgZnJhbWV3b3JrLg0KPiA+ID4gPiANCj4gPiA+IA0KPiA+
ID4gV2hpbGUgSSB0aGluayB0aGUgZ2VuZXJhbCBpZGVhKHVzaW5nIGZpbGUtb3ZlcndyaXRlLXJh
dGVzIGFzIGENCj4gPiA+IHBhcmFtZXRlciB3aGVuIGRvaW5nIGRhdGEgcGxhY2VtZW50KSBjb3Vs
ZCBiZSB1c2VmdWwsIGl0IGNvdWxkIG5vdA0KPiA+ID4gcmVwbGFjZSB0aGUgdXNlciBzcGFjZSBo
aW50aW5nIHdlIGFscmVhZHkgaGF2ZS4NCj4gPiA+IA0KPiA+ID4gQXBwbGljYXRpb25zKGUuZy4g
Um9ja3NEQikgZG9pbmcgc2VxdWVudGlhbCB3cml0ZXMgdG8gZmlsZXMgdGhhdCBhcmUNCj4gPiA+
IGltbXV0YWJsZSB1bnRpbCBkZWxldGVkKG5vIG92ZXJ3cml0ZXMpIHdvdWxkIG5vdCBiZW5lZml0
LiBXZSBuZWVkIHVzZXINCj4gPiA+IHNwYWNlIGhlbHAgdG8gZXN0aW1hdGUgZGF0YSBsaWZldGlt
ZSBmb3IgdGhvc2Ugd29ya2xvYWRzIGFuZCB0aGUNCj4gPiA+IHJlbGF0aXZlIHdyaXRlIGxpZmV0
aW1lIGhpbnRzIGFyZSB1c2VmdWwgZm9yIHRoYXQuDQo+ID4gPiANCj4gPiANCj4gPiBJIGRvbid0
IHNlZSBhbnkgY29tcGV0aXRpb24gb3IgY29uZmxpY3QgaGVyZS4gU3VnZ2VzdGVkIGFwcHJvYWNo
IGFuZCB1c2VyLXNwYWNlDQo+ID4gaGludGluZyBjb3VsZCBiZSBjb21wbGVtZW50YXJ5IHRlY2hu
aXF1ZXMuIElmIHVzZXItc3BhY2UgbG9naWMgd291bGQgbGlrZSB0byB1c2UNCj4gPiBhIHNwZWNp
YWwgZGF0YSBwbGFjZW1lbnQgcG9saWN5LCB0aGVuIGl0IGNhbiBzaGFyZSBoaW50cyBpbiBpdHMg
b3duIHdheS4gQnV0LA0KPiA+IHBvdGVudGlhbGx5LCBzdWdnZXN0ZWQgYXBwcm9hY2ggb2YgdGVt
cGVyYXR1cmUgY2FsY3VsYXRpb24gY2FuIGJlIHVzZWQgdG8gY2hlY2sNCj4gPiB0aGUgZWZmZWN0
aXZlbmVzcyBvZiB0aGUgdXNlci1zcGFjZSBoaW50aW5nLCBhbmQsIG1heWJlLCBjb3JyZWN0aW5n
IGl0LiBTbywgSQ0KPiA+IGRvbid0IHNlZSBhbnkgY29uZmxpY3QgaGVyZS4NCj4gDQo+IEkgZG9u
J3Qgc2VlIGEgY29uZmxpY3QgaGVyZSBlaXRoZXIsIG15IHBvaW50IGlzIGp1c3QgdGhhdCB0aGlz
DQo+IGZyYW1ld29yayBjYW5ub3QgcmVwbGFjZSB0aGUgdXNlciBoaW50cy4NCj4gDQoNCkkgaGF2
ZSBubyBpbnRlbnRpb25zIHRvIHJlcGxhY2UgYW55IGV4aXN0aW5nIHRlY2huaXF1ZXMuIDopDQoN
Cj4gPiANCj4gPiA+IFNvIHdoYXQgSSBhbSBhc2tpbmcgbXlzZWxmIGlzIGlmIHRoaXMgZnJhbWV3
b3JrIGlzIGFkZGVkLCB3aG8gd291bGQNCj4gPiA+IGJlbmVmaXQ/IFdpdGhvdXQgYW55IGJlbmNo
bWFyayByZXN1bHRzIGl0J3MgYSBiaXQgaGFyZCB0byB0ZWxsIDopDQo+ID4gPiANCj4gPiANCj4g
PiBXaGljaCBiZW5lZml0cyB3b3VsZCB5b3UgbGlrZSB0byBzZWU/IEkgYXNzdW1lIHdlIHdvdWxk
IGxpa2U6ICgxKSBwcm9sb25nIGRldmljZQ0KPiA+IGxpZmV0aW1lLCAoMikgaW1wcm92ZSBwZXJm
b3JtYW5jZSwgKDMpIGRlY3JlYXNlIEdDIGJ1cmRlbi4gRG8geW91IG1lYW4gdGhlc2UNCj4gPiBi
ZW5lZml0cz8NCj4gDQo+IFllcCwgZGVjcmVhc2VkIHdyaXRlIGFtcGxpZmljYXRpb24gZXNzZW50
aWFsbHkuDQo+IA0KDQpUaGUgaW1wb3J0YW50IHBvaW50IGhlcmUgdGhhdCB0aGUgc3VnZ2VzdGVk
IGZyYW1ld29yayBvZmZlcnMgb25seSBtZWFucyB0bw0KZXN0aW1hdGUgdGVtcGVyYXR1cmUuIEJ1
dCBvbmx5IGZpbGUgc3lzdGVtIHRlY2huaXF1ZSBjYW4gZGVjcmVhc2Ugb3IgaW5jcmVhc2UNCndy
aXRlIGFtcGxpZmljYXRpb24uIFNvLCB3ZSBuZWVkIHRvIGNvbXBhcmUgYXBwbGVzIHdpdGggYXBw
bGVzLiBBcyBmYXIgYXMgSQ0Ka25vdywgRjJGUyBoYXMgYWxnb3JpdGhtIG9mIGVzdGltYXRpb24g
YW5kIGVtcGxveWluZyB0ZW1wZXJhdHVyZS4gRG8geW91IGltcGx5DQpGMkZTIG9yIGhvdyBkbyB5
b3Ugc2VlIHRoZSB3YXkgb2YgZXN0aW1hdGlvbiB0aGUgd3JpdGUgYW1wbGlmaWNhdGlvbiBkZWNy
ZWFzaW5nPw0KQmVjYXVzZSwgZXZlcnkgZmlsZSBzeXN0ZW0gc2hvdWxkIGhhdmUgb3duIHdheSB0
byBlbXBsb3kgdGVtcGVyYXR1cmUuDQoNCj4gPiANCj4gPiBBcyBmYXIgYXMgSSBjYW4gc2VlLCBk
aWZmZXJlbnQgZmlsZSBzeXN0ZW1zIGNhbiB1c2UgdGVtcGVyYXR1cmUgaW4gZGlmZmVyZW50DQo+
ID4gd2F5LiBBbmQgdGhpcyBpcyBzbGlnaHRseSBjb21wbGljYXRlcyB0aGUgYmVuY2htYXJraW5n
LiBTbywgaG93IGNhbiB3ZSBkZWZpbmUNCj4gPiB0aGUgZWZmZWN0aXZlbmVzcyBoZXJlIGFuZCBo
b3cgY2FuIHdlIG1lYXN1cmUgaXQ/IERvIHlvdSBoYXZlIGEgdmlzaW9uIGhlcmU/IEkNCj4gPiBh
bSBoYXBweSB0byBtYWtlIG1vcmUgYmVuY2htYXJraW5nLg0KPiA+IA0KPiA+IE15IHBvaW50IGlz
IHRoYXQgdGhlIGNhbGN1bGF0ZWQgZmlsZSdzIHRlbXBlcmF0dXJlIGdpdmVzIHRoZSBxdWFudGl0
YXRpdmUgd2F5IHRvDQo+ID4gZGlzdHJpYnV0ZSBldmVuIHVzZXIgZGF0YSBhbW9uZyBzZXZlcmFs
IHRlbXBlcmF0dXJlIGdyb3VwcyAoImJhc2tldHMiKS4gQW5kDQo+ID4gdGhlc2UgYmFza2V0cy9z
ZWdtZW50cy9hbnl0aGluZy1lbHNlIGdpdmVzIHRoZSB3YXkgdG8gcHJvcGVybHkgZ3JvdXAgZGF0
YS4gRmlsZQ0KPiA+IHN5c3RlbXMgY2FuIGVtcGxveSB0aGUgdGVtcGVyYXR1cmUgaW4gdmFyaW91
cyB3YXlzLCBidXQgaXQgY2FuIGRlZmluaXRlbHkgaGVscHMNCj4gPiB0byBlbGFib3JhdGUgcHJv
cGVyIGRhdGEgcGxhY2VtZW50IHBvbGljeS4gQXMgYSByZXN1bHQsIEdDIGJ1cmRlbiBjYW4gYmUN
Cj4gPiBkZWNyZWFzZWQsIHBlcmZvcm1hbmNlIGNhbiBiZSBpbXByb3ZlZCwgYW5kIGxpZmV0aW1l
IGRldmljZSBjYW4gYmUgcHJvbG9uZy4gU28sDQo+ID4gaG93IGNhbiB3ZSBiZW5jaG1hcmsgdGhl
c2UgcG9pbnRzPyBBbmQgd2hpY2ggYXBwcm9hY2hlcyBtYWtlIHNlbnNlIHRvIGNvbXBhcmU/DQo+
ID4gDQo+IA0KPiBUbyBzdGFydCBvZmYsIGl0IHdvdWxkIGJlIG5pY2UgdG8gZGVtb25zdHJhdGUg
dGhhdCB3cml0ZSBhbXBsaWZpY2F0aW9uDQo+IGRlY3JlYXNlcyBmb3Igc29tZSB3b3JrbG9hZCB3
aGVuIHRoZSB0ZW1wZXJhdHVyZSBpcyB0YWtlbiBpbnRvDQo+IGFjY291bnQuIEl0IHdvdWxkIGJl
IGdyZWF0IGlmIHRoZSB3b3JrbG9hZCB3b3VsZCBiZSBhbiBhY3R1YWwNCj4gYXBwbGljYXRpb24g
d29ya2xvYWQgb3IgYSBzeW50aGV0aWMgb25lIG1pbWlja2luZyBzb21lIHJlYWwtd29ybGQtbGlr
ZQ0KPiB1c2UgY2FzZS4NCj4gUnVuIHRoZSBzYW1lIHdvcmtsb2FkIHR3aWNlLCBtZWFzdXJlIHdy
aXRlIGFtcGxpZmljYXRpb24gYW5kIGNvbXBhcmUgcmVzdWx0cy4NCj4gDQoNCkFub3RoZXIgdHJv
dWJsZSBoZXJlLiBXaGF0IGlzIHRoZSB3YXkgdG8gbWVhc3VyZSB3cml0ZSBhbXBsaWZpY2F0aW9u
LCBmcm9tIHlvdXINCnBvaW50IG9mIHZpZXc/IFdoaWNoIGJlbmNobWFya2luZyB0b29sIG9yIGZy
YW1ld29yayBkbyB5b3Ugc3VnZ2VzdCBmb3Igd3JpdGUNCmFtcGxpZmljYXRpb24gZXN0aW1hdGlv
bj8NCg0KPiBXaGF0IHVzZXIgd29ya2xvYWRzIGRvIHlvdSBzZWUgYmVuZWZpdGluZyBmcm9tIHRo
aXMgZnJhbWV3b3JrPyBXaGljaCB3b3VsZCBub3Q/DQo+IA0KDQpXZSBuZWVkIHRvIHRhbGsgYXQg
Zmlyc3QgYWJvdXQgZmlsZSBzeXN0ZW0gbWVjaGFuaXNtIHRvIGVtcGxveSBkYXRhIHRlbXBlcmF0
dXJlDQppbiBlZmZpY2llbnQgd2F5LiBCZWNhdXNlIHRoZXJlIGlzIG5vIHVuaXZlcnNhbCB3YXkg
dG8gZW1wbG95IGRhdGEgdGVtcGVyYXR1cmUNCmFuZCBkaWZmZXJlbnQgZmlsZSBzeXN0ZW0gY2Fu
IGltcGxlbWVudCBjb21wbGV0ZWx5IGRpZmZlcmVudCB0ZWNobmlxdWVzLiBBbmQNCm9ubHkgdGhl
biBpdCB3aWxsIGJlIHBvc3NpYmxlIHRvIGVzdGltYXRlIHdoaWNoIGZpbGUgc3lzdGVtIGNhbiBw
cm92aWRlcw0KYmVuZWZpdHMgZm9yIGEgcGFydGljdWxhciB3b3JrbG9hZC4gU3VnZ2VzdGVkIGZy
YW1ld29yayBvbmx5IGVzdGltYXRlcyB0aGUNCnRlbXBlcmF0dXJlLg0KDQo+ID4gPiBBbHNvLCBp
cyB0aGVyZSBhIGdvb2QgcmVhc29uIGZvciBvbmx5IHN1cHBvcnRpbmcgYnVmZmVyZWQgaW8/IERp
cmVjdA0KPiA+ID4gSU8gY291bGQgYmVuZWZpdCBpbiB0aGUgc2FtZSB3YXksIHJpZ2h0Pw0KPiA+
ID4gDQo+ID4gDQo+ID4gSSB0aGluayB0aGF0IERpcmVjdCBJTyBjb3VsZCBiZW5lZml0IHRvby4g
VGhlIHF1ZXN0aW9uIGhlcmUgaG93IHRvIGFjY291bnQgZGlydHkNCj4gPiBtZW1vcnkgcGFnZXMg
YW5kIHVwZGF0ZWQgbWVtb3J5IHBhZ2VzLiBDdXJyZW50bHksIEkgYW0gdXNpbmcNCj4gPiBmb2xp
b19hY2NvdW50X2RpcnRpZWQoKSBhbmQgZm9saW9fY2xlYXJfZGlydHlfZm9yX2lvKCkgdG8gaW1w
bGVtZW50IHRoZQ0KPiA+IGNhbGN1bGF0aW9uIHRoZSB0ZW1wZXJhdHVyZS4gQXMgZmFyIGFzIEkg
Y2FuIHNlZSwgRGlyZWN0IElPIHJlcXVpcmVzIGFub3RoZXINCj4gPiBtZXRob2RzIG9mIGRvaW5n
IHRoaXMuIFRoZSByZXN0IGxvZ2ljIGNhbiBiZSB0aGUgc2FtZS4NCj4gDQo+IEl0J3MgcHJvYmFi
bHkgYSBnb29kIGlkZWEgdG8gY292ZXIgZGlyZWN0IElPIGFzIHdlbGwgdGhlbiBhcyB0aGlzIGlz
DQo+IGludGVuZGVkIHRvIGJlIGEgZ2VuZXJhbGl6ZWQgZnJhbWV3b3JrLg0KDQpUbyBjb3ZlciBE
aXJlY3QgSU8gaXMgYSBnb29kIHBvaW50LiBCdXQgZXZlbiBwYWdlIGNhY2hlIGJhc2VkIGFwcHJv
YWNoIG1ha2VzDQpzZW5zZSBiZWNhdXNlIExGUyBhbmQgR0MgYmFzZWQgZmlsZSBzeXN0ZW1zIG5l
ZWRzIHRvIG1hbmFnZSBkYXRhIGluIGVmZmljaWVudA0Kd2F5LiBCeSB0aGUgd2F5LCBkbyB5b3Ug
aGF2ZSBhIHZpc2lvbiB3aGljaCBtZXRob2RzIGNhbiBiZSB1c2VkIGZvciB0aGUgY2FzZSBvZg0K
RGlyZWN0IElPIHRvIGFjY291bnQgZGlydHkgYW5kIHVwZGF0ZWQgbWVtb3J5IHBhZ2VzPw0KDQpU
aGFua3MsDQpTbGF2YS4NCg0K

