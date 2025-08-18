Return-Path: <linux-fsdevel+bounces-58198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AE4B2AFDD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 20:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45BAD4E53F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 17:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33392320CBF;
	Mon, 18 Aug 2025 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E4GzY1U4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8BB28850B;
	Mon, 18 Aug 2025 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755539953; cv=fail; b=MvwLnnReh3ZqB7bBCcnli+PBP2QU6iNwfICjdj0JKaTgbQ3/dCP6Mgs8wU0wjqXPHoNH5uhfUIJO5DcUz0L4pNlgO34SMyV6LXX5vmBVCBc64tWtsqiGwp1uYLgfkCiiXBUnfwGPhjM5/C276zsfbgkeTAku4r6qO5DmIKZbrnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755539953; c=relaxed/simple;
	bh=UFn1tAbtLPPTrEkJb4jeI27iWunUS0Nmz0utJ3nH7LU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=RXSCpJx8mRdDcN8SmwyZrckjSv2LVO4DpT43O5rmNNcEaWTsk34r4nmJrzQ3zAYdKbQpbxCqcy5Uw5q1BQK0xeUV8HCEDJo01WsxgCwb7sCR3+86G8/F4GyES80echfnCP4t0mLvccCbs1p0SsCbCMhz6zHnLLfFi0GMj5eXNdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E4GzY1U4; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IBbJnx009937;
	Mon, 18 Aug 2025 17:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=UFn1tAbtLPPTrEkJb4jeI27iWunUS0Nmz0utJ3nH7LU=; b=E4GzY1U4
	/HeVayF+hGuiDCMpymhehto22irjyHY/IsoK1C6wBo9tGF/whow++Es0ucSckfhF
	d+1zxXnkvCvg05KJadUkbMBbmsPQmCYdvcMxfOCOETFDTOA7Jk6yGE6gQ9TtOhZ/
	3RJMANPf3TbEpX6FxqvgyeqO+BPTDwd64HyUNmMhO2jyYGP0NcbmV06JB0t9w8l+
	iM+2yJVjiQYUAn+Jfi1R+EB4mYxu4xmvwIcVgV1NZUOTWNORz4NCTGac1D9gsPei
	e+cd/7gtfzi5OyI/574XZkYfhQ22r6wQwZyqNRSJEGZYp2Nd/0iLXFwi5g6soQk8
	ESqLu0Wo3KVc6w==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhny2n4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 17:59:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwkELLv6f71N8sh9DlM91IybMi7F3h6Sc0GFNxraWA/qZleF3AAnv/PX5BymV0Pteb25pQ2l1cEh3E2AjV7d7/Xp+KB9jAwi5ZKotK1IjFRGPSpu3L0jnw7httqm5LldPdlhLNVglTb6xDPBKTGKiIOV7G/PAJ41EPdWF9UD1KmCHjfXS+2ywIAP2kZxLuvi9V0wIbRhPaluse71+CFSIIcOgb6SzVRPIfp4ECELiKMSDJDhN2HFP/kUhBIB05yOyLp7M8qRsiyc502vDHrHBOmj+Dgn7abJzK9m8iJRs4RAu4geeer8MQq5YOt7s/I1A1FSbJ2BbpSB1OWvcDkGlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFn1tAbtLPPTrEkJb4jeI27iWunUS0Nmz0utJ3nH7LU=;
 b=zSgbZROS+kHQKRs0SDDMXy/i2D13PBSA2qmg5s1tRWimOiaZuA1p1IRS2yAAxkmP863VMzH0QMTEARHsNxxjXkicCN9x9v2x74VlBgBz5OPqdl+Zs+26RV94yP325tWmvVjk1NL+11U140KQX5oHviGnbP15hLjL/ptILlYzMKNumgp/Nznh0FBId3fMXat5vzCzpyZoIvTJeqYaXAyN6co/PshRN9FdBYF8d3djLhfCu3NiSAbsPqJYlmbXy93Ycw/pf8kDl9K/JpiMJARrIY+KU8twHy7oTJr2psJAx0oVi1Z3BIe3oFb6iucLMzczUT0326iKZCsyCdFjFK8Hfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com (2603:10b6:a03:4e4::8)
 by DS7PR15MB5910.namprd15.prod.outlook.com (2603:10b6:8:eb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Mon, 18 Aug 2025 17:59:03 +0000
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::266c:f4fd:cac5:f611]) by SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::266c:f4fd:cac5:f611%4]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 17:59:03 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "yang.chenzhi@vivo.com" <yang.chenzhi@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "frank.li@vivo.com" <frank.li@vivo.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH 0/1] hfs: discuss to add offset/length
 validation in hfs_brec_lenoff
Thread-Index: AQHcEE3ThoOX8IuRrEyIw1JezF5suLRosvMA
Date: Mon, 18 Aug 2025 17:59:03 +0000
Message-ID: <ee40295987f48507fd1a0621f91d952a3ee2f9a4.camel@ibm.com>
References: <20250818141734.8559-1-yang.chenzhi@vivo.com>
In-Reply-To: <20250818141734.8559-1-yang.chenzhi@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB5821:EE_|DS7PR15MB5910:EE_
x-ms-office365-filtering-correlation-id: 05aa922a-6ae8-4daf-ef6e-08ddde80ead9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WEd1VzllbVNKTDFEbkJMYUYvNGU1T2IyVkRWdm5jbVA4R0x6RnNmRWEyTWYw?=
 =?utf-8?B?THpWY2NCVEZSWTdaS2pMRU5nMzlEbHlXWHdVR1VnVWJmTm0zZjJTNUF1UlNp?=
 =?utf-8?B?ZEdIdVlqTjRPbk82WXk2VVJqVW0zMm50NDFjd2ZoeHFacU1PT3VmeTdWZWp5?=
 =?utf-8?B?OHNKOVN3VndHQS9JWjZtS0FDUTdQelBPemtKSDh5VFUvaGlaczQ0QXpsY09u?=
 =?utf-8?B?Tms3NngzZDl2S3lGa29lVEZ6WFdPS1c4azBINXR5YlNYbUgwNGpHdnUyRWR1?=
 =?utf-8?B?M3d0cnpEM1RwUHFmMCtYZXo2S1VwWEZOQVNRbnZYS3NoL1pIY2YzcnJZdUgw?=
 =?utf-8?B?QVIvSEpCOEFJK1g4NjlKck9sazBjYks0Tmk4YTZyN0lLa1JPVHpnUllqWEZu?=
 =?utf-8?B?SithVkZZd01DVllOVzUwWjdRYzFmaUhHTjM1azJXK0FtTzhjd2NDbGR4clpD?=
 =?utf-8?B?UFk1S283WWd4RnovZ21hOUhEZVlOUVdRRTFwTVpVdFNwbXEwTTJNNGUyaTJm?=
 =?utf-8?B?YlF0UXg2M203cWcrUFVCd3FSMzlyWmMwOVBOM3ZEZXlUdkRQd2xubkpvYkVm?=
 =?utf-8?B?K2l2V1N3bm0za1Y1cGl1R2k3cmtOZ3BWY0xRT2E1YlYwM1JvN1RFRUFzUyt5?=
 =?utf-8?B?YWRiU1diL0ZKR0NiQkVBR1JnV1poZUxaMHVaK1U3Z0hUWjl1NlBzYVRJLzVM?=
 =?utf-8?B?ZHZ2VTVablhoejkwV04yRGplZVdwUXlPcEZwODh3VjRHUDBsMGpyaGFlTTZO?=
 =?utf-8?B?Z2c1Y0pNTmE4enpzQ094U1B0MGh5VnZ6dStrSS9NRjNxRFBFUGlsWjVIbTdO?=
 =?utf-8?B?aWhNUkNiM0dxQ3AweUZTcUphYU5vU0pZay9PRjh6VEZQcXF0TjFPbytPQmNj?=
 =?utf-8?B?TlhyYTVnaXQwWllaZGxtRHdwb1dMdkZNZGZDNm1wd2VIUXZCNnczMHAvS1Nx?=
 =?utf-8?B?TTN4QTRpaGlwbVZXY0RnZlJib2krUGdPdzJqVW00RzNrdjlHcHd4Tzh3N05Z?=
 =?utf-8?B?anFqOHNCNzFWZWJRVEpYQ1NveDc0ZlJjczNaK1BldmNVdXFWQ2xqQlRkSVlB?=
 =?utf-8?B?YkdCNExOMFpRR1lwWFk5S3Nsb01IbkY1QkpxelJUVWdCcDY0ZjVlNi9ST2lx?=
 =?utf-8?B?alhwcWhLM0RWZFM3ZFI0bGhMS3lzTkxIRHJrdzVMRUxhUW9HZC84UFJIZ0li?=
 =?utf-8?B?SHArekVLN0VtUGdFUXFoTzVTRWQ5VFA4VFV4aWJPTURKbUVlT3JnRCtZNm1B?=
 =?utf-8?B?aXoycGlla1U3VjY1WFk3ZUk0UVJHd01kM2IzdTNXdW16ZzlpbEdUR0xMaUVF?=
 =?utf-8?B?YnJmRitYZC9LN0htbDlQQ0x1d3BrSVRmV3VxS1ArVVU5RFlCd0ZIUG1SdkQv?=
 =?utf-8?B?QjM1blN6WG5ScEVoK2ltWVNYYkNndnhqMEREN09pdWtUYlFzOXNWZ0Z6cnd2?=
 =?utf-8?B?c0dXaVdwRDNOQldtL2xtdUU5Tm1tN1JrV1NROXlMRWdJU2tnR0tYWUkrdmRR?=
 =?utf-8?B?UVZkdnNhM1NGQWFuSldEMWlmMEkyUU1BSnJYSlhZV2lUcDArazI1ZmxIM3lM?=
 =?utf-8?B?YUF6OXdtVU40RnhDd3VOU3pzOGRCMjZHKzkvNHdxSllTQzM2Y3FURnZOQ0xo?=
 =?utf-8?B?NGxvRThVYUVGSG14UTRab2w3NEhZQUpySC9ZRG4vYzdvUjhzaURXYk45V29Z?=
 =?utf-8?B?NkRKZ3JhT0xxTkRSM0QxakQ1UmM5SGZYR0J2YU8zY3dFZmkwVXRTZ0VZRzRi?=
 =?utf-8?B?UHpSVitzNnhPN0ZGdEpkSFkrcENGRFVrc1FSTkpCODBsV3didWpEN3RiUm83?=
 =?utf-8?B?WjBkenROVVJSUGFGcTRvMDRvSytteDFOYkVpTGI2SDd2YWh6Sy82UGdaN2tr?=
 =?utf-8?B?QkFvOTdGKzcwOFB1elhtQTRReWl3ZTB0aERCdjJLS28zd3VnUnp1THFiWTh3?=
 =?utf-8?B?aHNoZEt0UzdxYVdSNzI4Z0VWbWo0QWxpQ2Vnajd0RmlMU0JrU3EzbFFmTWRp?=
 =?utf-8?B?NHdxMTdqdExBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5821.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UERjK0dBMXRZR1lib0l5Z3dTc3c1T0NxLzZkQXhOZ2p5WVorMlpaYnI1YzdH?=
 =?utf-8?B?a09RbjljeFFYWWZlNG44UjU0Znhhc0FiZ1NqeWJackEwZUVPVnJoYmNkSGhv?=
 =?utf-8?B?b2V2NEtGMEg2NUVseXpnUlNvWXdjVEVtTjVVWE93TlVEYXJta1JFRFpmM1Y2?=
 =?utf-8?B?emFzdHhBeUNPS3pFRTZCaXpXd1d1ZncyVS9HdUNzSlgrd3c4S2ttazhWRVlX?=
 =?utf-8?B?SUpPV0JlOG9sS1BNcFRRZ2RxUnhxU254d2RDVXBrQ1RaWU5UUzd4MVZXbGRG?=
 =?utf-8?B?OW1tZGs1T0UyTDRCc3RXQ250M2xPV21XeUljVjVhQkpmV3BTSlViZnFPMTVD?=
 =?utf-8?B?b3Mrcks0cE1qSkpWNU0yRVZBd3o2dUlxOVVad2NHWGNybkFRbjNwRnRGQk14?=
 =?utf-8?B?QlJWS0xmWHNBQjhmc0JPNFhpMXhDNWphbGFJYmRZMzZMeDZzZlI5anM1dU1U?=
 =?utf-8?B?enpsZnhZYThGek9oSGRRNG1SeEZKNHhheGhVaVZ6aUM2YXdHbDlzNk5jUG91?=
 =?utf-8?B?dWRZMzlHK0FuWW1xQzlKNnJPTWpadEY0Vm9mY3hHNHpZOGNkWEVpYTd4UGls?=
 =?utf-8?B?b21vd0NpVGxaTU5OR09JckZKWWtNeUd1c3FTUFYwcTRWOWR5R1JSM1ExQ2lB?=
 =?utf-8?B?d1lTSVJHTldTTmNvUzV2cFl0Q2t6RUphRytxMEhQZHU5bnZNZVI4Wkdkd2Mx?=
 =?utf-8?B?RzExdkk1djFObnFMT0p2SUY4d2poTjV4T3VjY3ZJeEd6RCt0cnBkYS8xaTYy?=
 =?utf-8?B?QnhxWFpSNTNRaWoxeVFtbUlZUTBHRUVkSXVzRkRZVGd2RkZ3dzJHQi84UWdX?=
 =?utf-8?B?SFVmTjhndnJyZXVucjNGUnNLWFVScGF1M1RiZjFYTXpkenlWa1JmLzJnSVd5?=
 =?utf-8?B?K0FVOW5kcVkrTk1KTDZ0aEt5b0wrNjROTjZ4N2JuaE54STJITG5BVFc1bXZH?=
 =?utf-8?B?T2U3emNLNFdqcFd3L2dYMDJLTDlsRHc3S3MrSEVuYy90WUlSS3JiQXc0NDZM?=
 =?utf-8?B?aTYrbGxyTnBnRUU2aVVycitOdGxKUmZCbEFUK210R1prcEdxb2FHL0pDUDJ5?=
 =?utf-8?B?K0praWVQUVRRWTh6VnJwRzdKQk9KeVFRZ3pMbC9pMXgyMHVGTmFKWWI2Sy93?=
 =?utf-8?B?ZThmaDhHREo2VVYrMGR6MGlSeXlkN3RkMlpDQnRudVd2c1RRZzhpRUVzOWNz?=
 =?utf-8?B?alVZL3l3cUpEWWNrQlVkV2d2UVRPMDhEQlQ5cVg0bXlGbGJmay91emtVdTFC?=
 =?utf-8?B?S1NwUzJDYzBPU0tZS291cUMwWnZ1bVZRZ0N0anRwdm1qOVc1WEhMNmhQMlo2?=
 =?utf-8?B?U3RtbzZ1aUhqSHVUVEk3M1ZGKzJnc0M5eDVmZWdpNndWRUUzY1AxeXVBTWdm?=
 =?utf-8?B?WWtIaEFVdFd3RXg2Z01QZnVzVmI4S1F4U0tFOGwvYzRFaUtYY2p3OVdMY2Vp?=
 =?utf-8?B?U0JzbmY3VUtDYnlGcWYvSlFKaWNkazlvQ3RjaGF0Q081QU83TjM4L2RDNjQ5?=
 =?utf-8?B?VW15eXoyODJ2TS92WkRVbDA0T3JNUmNmb1d4MTFySCtPaEU1dktrMXFzU3ph?=
 =?utf-8?B?N3gwQVpOVlpaZ3NTNTlDQm5TTHpEZGxJNDBsVVlLOGNiQ3d3S01RRXB2Y0hp?=
 =?utf-8?B?eWRhQWttZGY3YjdHTXpGN0VjdTlTTUx0UWJIS1phQTFlMWhjeDZ1MG9YeVdI?=
 =?utf-8?B?NXVHdlZWUDU2c1BXcWxzZHpVbTJGQm80Vmt5QUR0ZTZpdFMrSlZmUE9Mczd5?=
 =?utf-8?B?YlNWeUN3blVVL3pkYkJhRTlIVitJOW9ZQVJ5YjliTDRydHdBbHV6elg3WFZ2?=
 =?utf-8?B?cGNqQStyQU9ZdzQ0akxMTG5ZOEJVVTRseSs2cWtCZkpHbzdYM2JGVUVsb2E2?=
 =?utf-8?B?ZUhiYjE4NlB0Uk9KMjdOcGpBS0lsbm54bVZ6Tm4vNmFxSC84VTRyN0NKMEJF?=
 =?utf-8?B?b1oxaE9GWHBsbWVyZW9aSFBtVTI2RzVDOStiZCtXTXN1ckcweGF0RTBTbHNu?=
 =?utf-8?B?cmdQcXNOM2J6ZWcxUTdmTDVpMDdMUjV0SWk0M1BxRnh2VTB3cDdZYVBPV1N3?=
 =?utf-8?B?YzJNelpEWlFQKzJnd012RkJiVkhSWnQxdFZDckx6YXNINnNlVjlYYy9IODFl?=
 =?utf-8?B?ZUdON0N0MzkzT0cvelArU2FCbVJZV3h6SHdwM216bkFHWVplWUZ2UWhWbE5J?=
 =?utf-8?Q?9sKScOhXaEpIqDNMnz65shE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <645A7A5D63FF814589D8F9438117AA3A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5821.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05aa922a-6ae8-4daf-ef6e-08ddde80ead9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 17:59:03.3667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RwabITA5QigWrbu05jiJC4ZgcH6MTRjwsjGst1O+szcKmiBlszeEdMoBwjwBXgl7KinTKkQOfNWAe5kCf8cSKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR15MB5910
X-Authority-Analysis: v=2.4 cv=XbqJzJ55 c=1 sm=1 tr=0 ts=68a369ea cx=c_pps
 a=rktla+E3bJZWaxI4NRrvhQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=1WtWmnkvAAAA:8 a=m7KjSEB-O15sjLPxDncA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9hYFe2uZbxPq_Avhg8fU2DhFyllhPA2b
X-Proofpoint-GUID: 9hYFe2uZbxPq_Avhg8fU2DhFyllhPA2b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNyBTYWx0ZWRfX1Vki4gl5zLwK
 j0H9W0U98k/GJ04VMl8VPhKr7AtpbiYk7kPrPBSDHv1KlrLWibPgDcRu/TJ7Tj1XtZ2vGms2fKO
 o/Evoci9SjeEyNqr0V2FOSHw6AC880aYJdAonxszo1HbH7Z8ZK2RToGR5lV+ipSrlYZmh5SU8Gj
 YzZG/yAhLrOX2CSBB4pypUQeXJAWh2qRppgPMbso5b13j2Qxg6dXmaDywgnuCNu3cdvtlu2Q4jK
 4uetltCx6ZhazGXLHn2LnRenm8ceOjPzrswcJPm7BR25JGE7jDfaai4ylAlmMeqqD1LWAG0Jp1J
 q+OGvqksqwwctsrCEnQjmyglIYlSfZ5YiXerT6xyqu/dYeJipeb+J2ElWZMm7ZN8+W6/oWZXkH4
 /g+dw3BW
Subject: Re:  [PATCH 0/1] hfs: discuss to add offset/length validation in
 hfs_brec_lenoff
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160027

T24gTW9uLCAyMDI1LTA4LTE4IGF0IDIyOjE3ICswODAwLCBDaGVuemhpIFlhbmcgd3JvdGU6DQo+
IEZyb206IFlhbmcgQ2hlbnpoaSA8eWFuZy5jaGVuemhpQHZpdm8uY29tPg0KPiANCj4gV2hlbiBy
dW5uaW5nIHN5emJvdCB3aXRoIGEgY3JhZnRlZCBIRlMvSEZTKyBkaXNrIGltYWdlIGNvbnRhaW5p
bmcNCj4gaW52YWxpZCByZWNvcmQgb2Zmc2V0cyBvciBsZW5ndGhzLCB0aGUgZmlsZXN5c3RlbSBt
YXkgaGFuZy4gRm9yDQo+IGV4YW1wbGUsIGluIHRoaXMgY2FzZSBzeXpib3Qgc2V0IHRoZSBoZWFk
ZXLigJlzIHNlY29uZCByZWNvcmQgb2Zmc2V0DQo+IHRvIDB4N2YwMCB3aGlsZSBub2RlX3NpemUg
aXMgNDA5Ni4gSEZTL0hGUysgZmFpbGVkIHRvIGRldGVjdCB0aGlzDQo+IGZhdWx0LCB3aGljaCBl
dmVudHVhbGx5IGxlZCB0byBhIGNyYXNoLg0KPiANCg0KSEZTIGhhcyA1MTIgYnl0ZXMgYi10cmVl
IG5vZGUgc2l6ZS4NCg0KPiBTaW5jZSBIRlMvSEZTKyBtYWtlcyBoZWF2eSB1c2Ugb2YgaGZzX2Jy
ZWNfbGVub2ZmLCBhZGRpbmcgbWFudWFsDQo+IG9mZnNldC9sZW5ndGggY2hlY2tzIGF0IGV2ZXJ5
IGNhbGwgc2l0ZSB3b3VsZCBiZSB0ZWRpb3VzIGFuZA0KPiBlcnJvci1wcm9uZS4NCj4gDQoNCllv
dSBhcmUgbWVudGlvbmluZyBIRlMgaGVyZS4gQnV0IHlvdSd2ZSBzaGFyZWQgZml4IG9ubHkgZm9y
IEhGUysuIEFyZSB5b3UNCnBsYW5uaW5nIHRvIHNoYXJlIHRoZSBmaXggZm9yIEhGUyB0b28/DQoN
ClRoYW5rcywNClNsYXZhLg0KDQo+IEluc3RlYWQsIGl0IG1heSBiZSBtb3JlIHJvYnVzdCB0byBp
bnRyb2R1Y2UgdmFsaWRhdGlvbiBkaXJlY3RseQ0KPiBpbnNpZGUgaGZzX2JyZWNfbGVub2ZmIChv
ciBhdCBhIHNpbWlsYXIgY2VudHJhbCBwb2ludCksIGVuc3VyaW5nDQo+IHRoYXQgYWxsIGNhbGxl
cnMgY2FuIHNhZmVseSByZWx5IG9uIHRoZSByZXR1cm5lZCBvZmZzZXQgYW5kIGxlbmd0aA0KPiB3
aXRob3V0IGFkZGl0aW9uYWwgY2hlY2tzLg0KPiANCj4gWWFuZyBDaGVuemhpICgxKToNCj4gICBo
ZnM6IHZhbGlkYXRlIHJlY29yZCBvZmZzZXQgaW4gaGZzcGx1c19ibWFwX2FsbG9jDQo+IA0KPiAg
ZnMvaGZzcGx1cy9ibm9kZS5jICAgICAgfCA0MSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQo+ICBmcy9oZnNwbHVzL2J0cmVlLmMgICAgICB8ICA2ICsrKysrKw0KPiAg
ZnMvaGZzcGx1cy9oZnNwbHVzX2ZzLmggfCA0MiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspLCA0MSBk
ZWxldGlvbnMoLSkNCg==

