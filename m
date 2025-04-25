Return-Path: <linux-fsdevel+bounces-47407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F26A9D075
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 20:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603AC17A808
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 18:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E8E21765B;
	Fri, 25 Apr 2025 18:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BfFPVqnf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB21A188733
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745605565; cv=fail; b=pyHXh47W3fjxuHPrldb0u/xsM7F7e2JxgvGO0KNQjWk0mMjumiK5omH/jFKjFx97v0znFJ9q7Wi31PIjR136XXCxr2VGdUeudrWDBY/2LNMC2gM/xwxEHlsbu5fCsENI9Kdl9+/Vp7QoCwilEaWQDtmhHr24IhD3dxE3gSINYVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745605565; c=relaxed/simple;
	bh=Z915DNyWfV+UsURdAKgS7TiQPNURgcxB8fCir+3aAjI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=bXgr6TZNuWblMpQXh6czwnnXw/WTc1Tg98ScAen75nXUGn74zj7iPylFM2HrcCqZrMMaZ2QiWpFb0HWRSebPQSJA2YNsez9xHaEIbzQwMBllKxlG2TTYUZ7jTmtJ5rLMEUbwGSl2UUKX7yY/q7tBucKGmLX8fPpjrSXnG4yojJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BfFPVqnf; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P9PbFr006508
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 18:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=0jrTyA149kFM1JPc2LhsZFwyVnpst5Of+IFTK27tO3I=; b=BfFPVqnf
	PKaxnUeg6fv3eo58qsEWz35gCu5aDxAHRJYtVKuD4AQgOK1ojWxvZVzJP2QO8q4w
	B3G/qsyRO/LlWi7jJ+nHMMJZn1/eD2/W/5Zx1N8yFDTw1v7nKVPxpNuIx5klr4ot
	CUdG+a5oh6tjnTyuncr+jumhzGe+9cvQQrMQNXlePuLtW6cZh++yaQNwNnrfx85Y
	xl0BJ15eFbEjHg9SElC/CZMh3mgyhFUnOljsNRE7bg+VTen+IsbmDNCsLEXjGDKK
	+ECG20zir5JaN5vptZush8QNntSON0Kf7f1djn2hIdfGcKG/m4RIRZwAsxKogHO4
	OcMBQ2BSWJe/Rg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467wd9myky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 18:26:02 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53PIBoDI017969
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 18:26:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467wd9mykq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 18:26:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IaIabpk5tLeUDl3r16rVAyok8331XZcvUnuUGD3qttYQgaduAefei7kcPiL/BuPgwXJWFSfLbYm0zmrUvG7SZlCEni+YaGRJBQjqlsZqIKP1b6GLrI1xWmNIiJkRxAPzaMjYEFW/Hwqrk/EbL88R1OykXf+CW6Sv1ufE6IziAwKgj/JKQdRwgHllA+qpTTifoDr60w0Z+dXYONKSTOTjwZwwB5aEKIFUumT9bqjLzYjWas0t9Cwy0E2VazDTHU/SQiK5/8bHkepCksVqX2gTeGT6p93xHJGreMrjeqQWzf6GKpKwvy+iDqGVZkdxQ/oVaB3nhvhURxEmvdZ/Ea+Iiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzqTSGh436QGoirOMAQOXCLcXZI2ZOacuBdu27DZqGk=;
 b=Qh/etKVUjBjNgwCHmXSizpS8LtmwMx8YsnZYXKY0rpZIzAkE7ODeU+G+t1l8DShmMopnB4fxy3azQn9p2lIVZPqFlbqcWzcVFgs7vfpG9hecZihM2rjUp08WIRUpZ1H2nBQbI/GkDPOE+69gCV6v1GNyKyXjimJqikLqytSrVJv74TE/JNWpCCOBkt+bSmf2ni5HA2nGft64cN/kGLsIVmPOkY0CklRxkvsaWXlZUHHFiHYu1ACz2gni1FvwEL0Yev5INHjTVtLt20EgP0BX7oIbG3VlVgPzNMQUcuwotuvksRfqCQeV+wLmtpUURQvxxMPKdC6h5po8UMbCwlb/PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ0PR15MB4359.namprd15.prod.outlook.com (2603:10b6:a03:358::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 18:25:58 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%3]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 18:25:58 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>
Thread-Topic:
 =?utf-8?B?W0VYVEVSTkFMXSDlm57lpI06IOWbnuWkjTogSEZTL0hGUysgbWFpbnRhaW5l?=
 =?utf-8?Q?rship_action_items?=
Thread-Index: AQHbtdbLEVVQEEwHz0WgstDqixH197O0s0uA
Date: Fri, 25 Apr 2025 18:25:58 +0000
Message-ID: <d35a7b6e8fce1e894e74133d7e2fbe0461c2d0a5.camel@ibm.com>
References: <f06f324d5e91eb25b42aea188d60def17093c2c7.camel@ibm.com>
						 <2a7218cdc136359c5315342cef5e3fa2a9bf0e69.camel@physik.fu-berlin.de>
					 <1d543ef5e5d925484179aca7a5aa1ebe2ff66b3e.camel@ibm.com>
				 <d4e0f37aa8d4daf83aa2eb352415cf110c846101.camel@physik.fu-berlin.de>
			 <7f81ec6af1c0f89596713e144abd89d486d9d986.camel@physik.fu-berlin.de>
		 <787a6449b3ba3dce8c163b6e5b9c3d1ec1b302e4.camel@ibm.com>
		 <TYZPR06MB527574C2A8265BF6912994E6E8842@TYZPR06MB5275.apcprd06.prod.outlook.com>
	 <84ebd3fb27957d926fc145a28b38c1ac737c5953.camel@physik.fu-berlin.de>
	 <SEZPR06MB5269CBE385E73704B368001AE8842@SEZPR06MB5269.apcprd06.prod.outlook.com>
In-Reply-To:
 <SEZPR06MB5269CBE385E73704B368001AE8842@SEZPR06MB5269.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ0PR15MB4359:EE_
x-ms-office365-filtering-correlation-id: 02e7b9fa-436a-4feb-d6b6-08dd8426a022
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?by9Qb3lDbTdIMXYyaWxiVGIrZUVscDhCeExtYkp4amw1MW4wQ3pwaGhhNlhL?=
 =?utf-8?B?d1ROWmV4VDB3ZjQ4bjFuK0VLT2hiY1FFK1ZNTk9NVFc5REdRZW9IVzJqdGNi?=
 =?utf-8?B?VG5VWG1aV1kwVzlnWUdGY01URnNDRDZVd2NqV09KOWs3bXUrSDVmSisxdzZ6?=
 =?utf-8?B?YmpyR2cvdXZCaytwdzVjbktHL0NEZGhzZ0RodXZuWXpZZkFPNFdmcWNsdngy?=
 =?utf-8?B?Wk5EcUFobVliU3B5N1NxRkFXcTFqVGZ5dHEvZ0YxUGo0VVVDMDRTMDZFa0NZ?=
 =?utf-8?B?UEFmWGQzVk1Ca0tqZU01TndNSVNyVFBuN2U3cmJOYzdYK3Y5T1VremxrNXBp?=
 =?utf-8?B?NnBQdFJwcjVubWRMbGdXczE2S2lFUDQwRnNmc2lsSHRsWDgrQStLazhxelo4?=
 =?utf-8?B?MXZMdlhsVS9NMFUvdUxWcTdLZ291cy9nWVdnWmFkL0dJNDFmS3VZR2hZUjdS?=
 =?utf-8?B?ZGpKTUpFUWRvSkNzWUNjQ0Y2K2F1K3lkR3dldk54V2Vxdy9KSHRTdUxlOHEw?=
 =?utf-8?B?TXBKYnVhdFJjRFZRSXdHUldIL2Z6QTBnV3FyUmlBUm5FNnVGSmg2dW5lRlFO?=
 =?utf-8?B?eXExd09MN2xVbUUxMU1Ib1dnY1VDVDVxSUdiNUMxSG53SkovdC9TN0J5NXFn?=
 =?utf-8?B?aDhqS0JWVHF1RFNDTjBIZlV6c0lqb0ErK2duakl4NXRMYkowVlNtMDYwUzBq?=
 =?utf-8?B?UGJnTnVEanpDY0MzelYvcmVSeDBDdEM1SGpmUy9YNE11OHJLWnlWOTh0TmhB?=
 =?utf-8?B?Z0dFTmFBa3RzNkxHTzJ1SmNTK3Yrb1l2YldWUUZVVEg3clNIdGVRaXRhR29m?=
 =?utf-8?B?c2tOV3Nia2NuRXpoVGhZRVRRZjh3VUFlRHNyTGpuS1lVNXY3OER5ZHk0dURG?=
 =?utf-8?B?U0dyQzJwYzVRT3hlMkh1UEE1a3I1NHRmZTRONW9YeTlNemgvSlpKSmdLSGs4?=
 =?utf-8?B?dmFvdHA2a20xbHV0RWZJWG5lZ3QzanM0YUF5eGJrSWtpMkRyTlU0YjZqS3Fm?=
 =?utf-8?B?MXZVaWMwMVNINUNLclhMWjJxNzFudklGN3RlY1Y4YVRwVEtWK0RBOUxtYi9T?=
 =?utf-8?B?cks5WUZuYVNvWUxkWmxnYTNRL09EQUh5UlhmblM0RXdBeWpkcjdNMFhZMjhD?=
 =?utf-8?B?L3U1NlRkL29JeEc4a0o4anBRMnVXa09ZNi9qOUJyNFR6MEJ6bDd6c1N0K0kv?=
 =?utf-8?B?ZUQwWUJ5ZHFES0xMNFZXblJUNWE0Y2FUcGUvcUtvbWRjRHJlOFpHbGNtZXZq?=
 =?utf-8?B?aVpaOXU5ckU2NldudnQyMkdsVWwzTUpPWjFHWUlubEZjaFQvTDF0SEhpSE5v?=
 =?utf-8?B?K2xGR0xjYUc3U1RRdzZUQzhxS1BYbkpkeGZHMlozeUxVbjdUTjVSSUg2TEFo?=
 =?utf-8?B?TWt5ZHNGZDROVDFEU0s2Q1dMWW5jd243RDVrY0NqNTNyazRENEdiNzBEbzIr?=
 =?utf-8?B?RlBFZCtiTnNEVFEyQmpFUTlIamE2NVRIWEpuMG8wcFRzSWU3dHJIa1oza1ZM?=
 =?utf-8?B?WVYxaHU4K1E2UHR5WGxvUlNqUlZJSzFBamIvM0RYbVNNb3RwLzVVb2xvcTYv?=
 =?utf-8?B?VUFvbkFlNlpoUzdJU0pDZmt5WG5uejJzQ1hGVDBtcElQWVNISmVQWVRhbW1M?=
 =?utf-8?B?ckM0QXZpTUJFZ3hYaXVvdnFhWWdPaENTTE13T0x2c0RGcUFvS2ZVbWxQMTZq?=
 =?utf-8?B?L0JZN3hyL1VFUXBhQ1dGTi9oQ1ZxK3VXb1ZzaXE1U2creVBlTmJDMzNkSzZR?=
 =?utf-8?B?RUY5STRHRnVrcEZHTXFWSGtoY1pHZ1BTMk1IdE1PMVA5cUo0WVpTVjlyay8y?=
 =?utf-8?B?eDFlT1pvZ2tJakp4bWxHY05PdUYvbnlGbGQrRS9UcVh6NWF0aUFOdmdDSml5?=
 =?utf-8?B?VlBsNlRJR0E1L0cwejVBOWZ3TWdPbW9sdi9RV3FqTjI5OGhvWEV5VHFFcWYy?=
 =?utf-8?B?NHRwTnBxOGxtMWcySWtQam1VdDArQ1h1ZEhkTXd4cG16bUZVSXBxRjVXaEFn?=
 =?utf-8?B?UWpaYnpCTm13PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WnlKU0NLdytSV1d3ZkY0SG1JblhlM240MGlYa01yVkpMSW9pYUlrTkI2RldU?=
 =?utf-8?B?b0IxQVVrSmdXODhKOVJnUWRYa2tpVE8wdURXdTAyN0lGZ1BRb2NxMG92cU5P?=
 =?utf-8?B?emgvN3ZtVDRrRlh2L09oS1ZCbjRla1pORXB0L0ZsNkllcVBpLzl0SjJ3YzIw?=
 =?utf-8?B?bGVPSU1KVFIzVzBTMzFNc25wbkhjY0hqaTdsM3pvL3JNTm1Kd01PRHBCWTJJ?=
 =?utf-8?B?UHhvdVdBVS9wekVTK0dQNkpJVWM1bnNzZ3daNXNGMmQ4czdYQlJKQjNjeHF3?=
 =?utf-8?B?TmF1dGlyNThNZWdwZ2VJOGxSVXRzbWpteTNoR01adUxxWTNGSGdVby84bXJO?=
 =?utf-8?B?SEtMQ2RKOEpUM3ZrUkc4NXNabU03NUZVRUVobzZaMDJnaXZrZmoxaEhnZDlX?=
 =?utf-8?B?RW9NVitnK1lxaEFHbEtWMVgrUFR6Ym4wWTRob3VzbkpRTFFxTE9iaFhQVFFC?=
 =?utf-8?B?S21LMWRCaHo3VnBjak40VjFpQUozMHdROXJ3Q3Q2NXpEOVpNTkkweVNPZTM2?=
 =?utf-8?B?TGtTVFJTNTJmL2YxTi9EclV0bXRDTW1QL1VLVWpvaHBITGZMcFZIYzc2MDV0?=
 =?utf-8?B?WndhYzFEajNaZ0VpcWg1VGRsbWp5andMb2hmWFY1SGQya3VPL3h5VEMzMmo5?=
 =?utf-8?B?QWFLR1c3clFjL3BQWXJJalBhUmxGa0t6OGE5UFVSQ24zcFRNcVRBWlBpNEVY?=
 =?utf-8?B?Q3E1RlNDRWRSOTBjSUFoM041ODhYMUxpMWpZVU9JbVNFMUdhWVc0aWRJNUpn?=
 =?utf-8?B?SUE2UlpiZ2lYdEp6aDBjcFU0VU1NZkY0cjRuRGV5S2U4Z3F5UnpLMk9kVVBs?=
 =?utf-8?B?ZVVtOXBRVTR5eHVNN1d5bVEvU0liUHRRSUs1aG9XUVdMMUdoMlVvM2ZmS1V6?=
 =?utf-8?B?cENha3NCRHVxVnpVb2d6SmF5V3dhUm9ZcFk4aVQ5N0FQelBuSUZwME0vNWNa?=
 =?utf-8?B?bURzaUlEQXQzQVRGUlRFWm1KN29FUWViQ21DbjFCWGVxQVdvL29YMmdZdGlS?=
 =?utf-8?B?OWhuekcrQnhlTjJkV1dDdkdtTFNxRmVHU2pnRlNvQ3lSLy95ODh1Q1p0R0Zi?=
 =?utf-8?B?Si93UFV1TnNnS1FMcmRzcWl4djhCSGFLd2UwR1ljTHMyaUtaR2FybXVKQ0Vi?=
 =?utf-8?B?MTE4TFJ2ZUFjVyt6REhEVFpCUThXdmxobUVtbXluWml5ZUlmT2RqT01UNHRp?=
 =?utf-8?B?Q3JsS3QvMUNFVEJDUzJaRWRzd0dSNmRtRzBMWmR4M3o5WFpIOHlQcjNtMzBu?=
 =?utf-8?B?d2ppTUF2WEJ1Z1g0SVdBL2JSbWhKd2JXd2ZqMUZqVkpIRFRnb3cya0V5RXpX?=
 =?utf-8?B?SkZ6cVBjY1hlVDBMaVE5UENFamd2Y1FxRUo2V2E4SDZRTzdWOHdXSEFXK0pw?=
 =?utf-8?B?TmtsTnVTYXF5NFl5VmhzWlAyek9HUHN2dE41a3hTakRGS1VxWjY5M09qRmFY?=
 =?utf-8?B?cG40akJZZkY0U1lMSEZXb2xlSjIzbmRBTThTaUJYa2tkUmpWcnhKNnllY0Vx?=
 =?utf-8?B?Rkg4cTBDaGkrTUN3UTEwVGNqNTZ2RWh3YWl0V1JKL2FLcDRDMmUzYmRjVTBa?=
 =?utf-8?B?em9NeGI0VE9qWnFzcEJ4SVNLNDgxSU9QcXBEN0d6VmtCTmUvOFJTY3dSZGQr?=
 =?utf-8?B?Z0d0U2tSUHIxMnZnRzhJRXJ5ZTg3cVdyMmpyKzhRVys2R3BhUDZ5K0xGUWJR?=
 =?utf-8?B?d0FFb0xHZU1rVytBRWZvWHg2MTNzL1VjNllOSjBvZURCVnB2R2tQdnRnekhq?=
 =?utf-8?B?T1RJTHRZKzFqMWlzNEpJdUVCTGRUbU5PZUtGeFJ2TExNQjNJYktPTCtJS29Z?=
 =?utf-8?B?RkNYakViYTJCenN5cW1UdThJNWV5OG9JTVZnQllDUXp1SUZ1ODBFY0hSdlBj?=
 =?utf-8?B?SG5OcERvaG5WUmdDbTd2RStrUk5DUE5mWjNid3NQWUV4RjdXK0RWa3ZVRUUx?=
 =?utf-8?B?NFM4S2pIYkJzTldUZC8zWTVzMEY3eWxqWFpxZm90ZzlTR2RIOTk3RElFeThB?=
 =?utf-8?B?Tzh4OG5MM3U4M0x0YWhVMUc5bUlvM1g3OUxVMXhXT29Cb2h2VE9MZVhQY0lj?=
 =?utf-8?B?b2xxMVM2bFl5czRPS053RndRSU5sR2EvS0lMMGUvM09KVGlLbk1NbEFZRWxO?=
 =?utf-8?B?UXBaVWlYMGl6c2t6UlNESGVzek1YT2pLRk1BQVgxL2drMldlUE83UWFNdTFv?=
 =?utf-8?B?M3c9PQ==?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e7b9fa-436a-4feb-d6b6-08dd8426a022
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 18:25:58.6541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zlRK3z3gCMChmq4eAB40ngXKKf2WKDHezs12lBpR5CX8OzIWwUOOKieRLufcEn+wonMvtVA5Q8wbEjJHkNB09A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4359
X-Proofpoint-ORIG-GUID: ggeNir4-XMrUORLWXUAmvs0DUHHCWsUf
X-Proofpoint-GUID: ggeNir4-XMrUORLWXUAmvs0DUHHCWsUf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDEyOCBTYWx0ZWRfXwEKkcpIU6APK gAl+NP7geHwHbQ9Vua5RYRNI1CgMHUxDzvyykiSIc7rI2Tni9t4lVMcRaCauUom4SBP5l4wHO/b /8IhqkkXjSPv2sjJQo7FfQVS0kIDotleC+N6l9XeQwSqB4uSDPvZ4xrhlrokkq1Qmv06s6crwiQ
 C35REzZTVViBk5QqTcPZhx9HjyCvzygm6OqF2448FsUYU8aeYJpvza9mmUS2PNjWbGTod7TN9PT eEuNaUjTKO49a+j0K7sIvd1cet3a/L+2SPo9mGeBlZlvAEgN3yvz73OQvmFYQXKJirgCga7v3Sb CcFScXNKA2f15FysjOOKS/bG0227Zegz1qeGsRZ72pnSx1jCWcps88lr8om5Nr44CL2aTWwc5Cn
 jilV2HduvkImt0tRZasIUFHnJ3ZFBgmqrFH3NjB9mcV8euGi84GqDQLBBlGLCRqX60DO0QKs
X-Authority-Analysis: v=2.4 cv=M5lNKzws c=1 sm=1 tr=0 ts=680bd3b9 cx=c_pps a=5b96o3JgDboJA9an2DnXiA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=5KLPUuaC_9wA:10 a=VwQbUJbxAAAA:8 a=eIjd4RAXcAp1cBmfUqwA:9 a=QEXdDO2ut3YA:10
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABB769EB007492418D85D478EE5624D4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: =?UTF-8?Q?Re:__=E5=9B=9E=E5=A4=8D:_=E5=9B=9E=E5=A4=8D:_HFS/HFS+_maintaine?=
 =?UTF-8?Q?rship_action_items?=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=2 engine=8.19.0-2504070000
 definitions=main-2504250128

On Fri, 2025-04-25 at 11:39 +0000, =E6=9D=8E=E6=89=AC=E9=9F=AC wrote:
> Hi Adrian,
>=20
> > Would you guys mind help me create an xfstest test environment as well?
>=20
> I am currently running arch linux on wsl 2 in a windows laptop.
>=20
> I'm following the README steps here (ing, not sure if I'll run into probl=
ems).
>=20
> https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/README?h=3Dfo=
r-next =20
> git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>=20
> Maybe slava and some other additions too?

Yes, I used this way to prepare the xfstests environment. So, the main step=
s:
(1)=C2=A0Clone git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
(2) Install all necessary packages + hfsprog tools. This step could depends=
 from
a particular environment.=20
(3) Do make and make install. Usually, it works well but last time I had so=
me
issues that I managed to resolve.
(4) Prepare the local.config file:

HFS case:

export TEST_DEV=3D/dev/sda1
export TEST_DIR=3D/mnt/test
export SCRATCH_DEV=3D/dev/sda2
export SCRATCH_MNT=3D/mnt/scratch

export FSTYP=3Dhfs

HFS+ case:

export TEST_DEV=3D/dev/sda1
export TEST_DIR=3D/mnt/test
export SCRATCH_DEV=3D/dev/sda2
export SCRATCH_MNT=3D/mnt/scratch

export FSTYP=3Dhfsplus

(5) Run the check command:

Group test (for example quick group):
sudo ./check -g quick

Particular test:
sudo ./check generic/001

Mostly, these steps should prepare the xfstests environment. Of course, it =
could
run on physical machine or inside of virtual machine. It needs to prepare t=
he
two  partitions or drives (test and scratch) for testing.

If you will have some troubles, please, let me know and I will try to help.=
 :)

Thanks,
Slava.


