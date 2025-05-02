Return-Path: <linux-fsdevel+bounces-47909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDA1AA718D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 14:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCDFC9C72C1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 12:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A955C26ACD;
	Fri,  2 May 2025 12:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="FurY7+Nu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011049.outbound.protection.outlook.com [52.101.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBB724C664
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 May 2025 12:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188338; cv=fail; b=Yllj5ZK+hQNPEtWFp462OO2dbCauxQBQWySR/E9TXhJ1sUHdGT0f1dmEPbHTCv5y8AUr5bngKcoOBrOfsZ1vnskiwYVnnOPWP2k55kBMvm+SydY6RABuSgembMQtQsJhgJVFDnMuMx0K449a923vn5G2qb65PsRXKCEJAM6SxXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188338; c=relaxed/simple;
	bh=oeTLNN/zZFF+6ypuXQ62q3DrefsCp/XyAlDtZyIAvX4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZQILCXs+JXJCcxUQedWcxlnTjNp0yP1b/UYk5uc76J1e3UCXjvOgSzDt+hYudCfzHtTbzd6fufTmwtX0BFUTNwzQEogSnXyzdOsQCYEmyYceSrSHQoarjpks5Xp+udOHn+h/acuz2NqdTGg7YfqxJ/4J0RUBnA1qa40FkuHvpbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=FurY7+Nu; arc=fail smtp.client-ip=52.101.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ikfht4SgMOUDVr0r8v3oOgCB28ljA4Bzp8kx9mPOnpow4FwOMOn6ckEbUdCHu99bfvPFHQbnGRzlduzENhVhiO4d/PACFx2hlPxcpwwnQDEQylEe/U49gnGDUMFsQ4kBOanocihUVeEiEHZXk9a1wckXAc2vPqfG6XJLePIpgJd3ZG731i/1vjEZyIpRgpy+kf6qkm7Tq2K5i73lPN+CT0OVrsDa2WQ0kqsLK/GOwZmGeIdgzFpWUANVe5TGQv6ZVJisGO378DRKF3dVtg3BeWXpOQ0JPqJWaKNKGrYXlsAWuskVa+JPE2EWQ1FwKwEyS8/fbZFzGvu0hPmCfH5a8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeTLNN/zZFF+6ypuXQ62q3DrefsCp/XyAlDtZyIAvX4=;
 b=E+B9w7/lZ+rjXv+sPvdjy2W0VJg+zehUy+/XFKzbCuJCDx4hbU9bAO/7JbrV8+6PI3j9JpcDDnr4xL8XTLlLhuRvZ61tHm0PAnmTJaAVQeWvbmoMhY9lcmdWCfDMrlNns+OT6udZsM8elsP/HYsMHn10RPIPnwKbsg6VY/Zfo/zQUO75Ie4fYli86Ksh5kMxK57RLUUYCNt/0LYJvoV5PK8yfEY5Me5RtakYzLqMHdYPDpsay2s9UvlfKRUAK6acJcekarWi67V7ZmLRYEV2MG2+OLEcYp+hlJK1JsJFe8/eDoIvNgNLTsOX+KEEbUnGDL7CU93XXfGONLUTErsh3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeTLNN/zZFF+6ypuXQ62q3DrefsCp/XyAlDtZyIAvX4=;
 b=FurY7+NuE8VeXKZzbm5SkaQwk9Ls1NiYoE1Q8r0WxzzLGiBbk40/pRNksBmAKarPIYQ9gv3coVQhHTXkZKueSUGScNAsiuwA4TVJ38jzNzOr1VBTn+CeNbM+Q6NPwAqKWBOBJFuuLzFyC33aU/vkCIvuQiYd8WHwECmFWO3x4u13jJ39r87ABlq95Lna6q2qVc41T+2QI7hcwZXpRwcWRQmOHh4/5nqRA4+4vCDT3+ElUrgcwwRn9UrVlIxEqgdOvg+hWHunx5i/7ekgqZ7RuVsONrJq+VxOrwlz4aDBWndul2u3Ksf+0rPMq0jB7BnxybH6+tPokPeZ55RF1F3TGQ==
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6476.apcprd06.prod.outlook.com (2603:1096:820:f0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Fri, 2 May
 2025 12:18:50 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%4]) with mapi id 15.20.8699.021; Fri, 2 May 2025
 12:18:50 +0000
From: =?gb2312?B?wO7R7+i6?= <frank.li@vivo.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>, "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>
CC: "Slava.Dubeyko@ibm.com" <Slava.Dubeyko@ibm.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"Johannes.Thumshirn@wdc.com" <Johannes.Thumshirn@wdc.com>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIHYyXSBoZnM6IGZpeCBub3QgZXJhc2luZyBkZWxldGVk?=
 =?gb2312?Q?_b-tree_node_issue?=
Thread-Topic: [PATCH v2] hfs: fix not erasing deleted b-tree node issue
Thread-Index: AQHbuWSLZohYluS6G0q/CM56WuIW3bO/Q/2w
Date: Fri, 2 May 2025 12:18:49 +0000
Message-ID:
 <SEZPR06MB52699CD3E9F2FBBF94E3435DE88D2@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20250430001211.1912533-1-slava@dubeyko.com>
In-Reply-To: <20250430001211.1912533-1-slava@dubeyko.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB5269:EE_|KL1PR06MB6476:EE_
x-ms-office365-filtering-correlation-id: a0561640-c6bc-41b8-4dcf-08dd89737ecf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?STRWZ0xhWWRMMS9Nc0UvL3didVB3VUQ0OUZJUXgwWHVxZlNIVm5tZ0JmWDFn?=
 =?gb2312?B?M28rTjQrRGdmZk9va0lVTkNHcDgwdm1Vdy8zVkRZT0VON0I1WFFSTzJNVFF0?=
 =?gb2312?B?cjhONGtnZUJ0eDNnYy9XMG5lWnhEVHlBTU5rRVNlVmljY2dzeGtwOXZQeWRJ?=
 =?gb2312?B?RWltWUNod2tRLy92emtuS1E1OG5renVEaVc1MnltUzlPZkVnYkZCZUJEZzFh?=
 =?gb2312?B?Q1RxeEI3ckdNNVBzN29jbU1TbitVRVp5N1dSY0JCYVNzNVlWZXd2YU9PcVZX?=
 =?gb2312?B?V3JGT0hSVW9hYWxXd1RsdHliS25PdTJJczRHSzBpejhmYjA0d3BnTVVrUlVW?=
 =?gb2312?B?T01HTlhHMFE5eTlpMG9EK21NZ3p6Mko4WmFTcWZmY3BoL2RselBOemZJdDdR?=
 =?gb2312?B?VC9SVXYrRHZPb1l0ZG91amlMRkF3dW5KTzRBYVdqNkhhbENQTkdUUFpscHVU?=
 =?gb2312?B?SlNpVXl6TnVnTm5IWjdTc2hiUXVtVExDR3BDeUN0SVpJTXNwbHFHTUV6VGU0?=
 =?gb2312?B?S2FTd2JocmNFajJqSkV3YTZ5clpnd2wzVVdnS1FNNVg4dENZT3JtNi9ZaU1o?=
 =?gb2312?B?YnZiUUlYUlozcDY1YXdTczdHbE1TaVRURkdLOU9oUWtOa2c0OFpBRWorNnc0?=
 =?gb2312?B?NmNGbjNsUnRxYm5lTmVweVpxbndXQVNTZHBoU0xuVzErNTQyQTYxeStXUWQ1?=
 =?gb2312?B?MEY2alBOcWVIU1doSnhIeDg0Wnh0Uk50U1l0YStXY2lXUm1sRWZDeXRPS3BV?=
 =?gb2312?B?V0NWMCtHN3VNVW5wWEFHam1yMFVSMFk1SWNvcmFLSm9OOUxTbE42ODBUVDI5?=
 =?gb2312?B?eEk5dDBZa052RHB2Ri9vRHY1clFkbDEyZlVvUEJ3NnZvWlIrVjBDS3FmaDFy?=
 =?gb2312?B?UXRXSkFtN2Z0NStBbWlmK2NUVzgvQlhNRUdiUlZ6cTVMV0I3NG1STVRGekQx?=
 =?gb2312?B?cTNJQUZleExTRllqRGN5elJKZ2VKUnd0YWNZa2hhSldJdnZ3dGhBN3YxMnd0?=
 =?gb2312?B?YmYxMTl3M1Brb0M3dk05aEVvdi8xTmcxZ1hBdkdiSDdRWmx2ZEhsWlVaMnc0?=
 =?gb2312?B?ckU0N0t4dElsNHRaSXB0RGRtNjRTdGpnTjJXOXVDeEN0VmJ0THpwYURVdm5H?=
 =?gb2312?B?bGt3enZEdldRSG1IdEVIclhwSzZPL0NYTVMvV1NVc2NFRncxM090d3RXVUVV?=
 =?gb2312?B?UXN1Mm90VXliRnFlZFhyNXo0QmR4SjE4eW1jS1BDbVhtcVZUTUczVk9jcGk1?=
 =?gb2312?B?dFpwcjNEeDQwOVoxWDlUSm1zR1JjU2kwZ3dsbTdOQ1RyRmkzUFpFME5XRVll?=
 =?gb2312?B?Z1JPZm9pekhVSDdyTEMrN29oS1I0U05yWFdiMEgxVk9OTHpNeFN4d1BQVHNt?=
 =?gb2312?B?U1NUQzlWb3NhTlZmcExzOTlWV3lBRXVPdnozSERTS2tOMHhQUUdBL1JUR3hx?=
 =?gb2312?B?MSt5STB2WlIwd2V3UHRoNWh6dFBIQ0c0dW9BTWV6aGUySTNlSmk0SWpSd3B6?=
 =?gb2312?B?MHRQbkpaV3RqdEdNV1JDRjNMNEUvcUFWQ3JLSlJhOWV5U0RIRWlnZEcrSEZV?=
 =?gb2312?B?N2ZzdHd0RHRjTXFXa3o2UVd1Z1kzN1NyM1M5dlp1TDd3MTB6cHNGdHhmVFRu?=
 =?gb2312?B?RjBVU1hMOG54cTlyWlpjT1ZOay9sMUxwN3lBT01VbXZEbzFSWERBRENiRmRQ?=
 =?gb2312?B?aVRLdGkrY3FkeElrVHVneExWMjVuekZySzJxcXJhTGJ1dTBTRW50SnZBL3Z1?=
 =?gb2312?B?SnBFN1M2ZFYyUytwT3RwWXU4b1d2RkFNUTEzb0dRVjBia291bWNVdk9YMlpO?=
 =?gb2312?B?QUJMQkdPUWZNTk04NGFSSUg1Qmx5UGdyOW1XenVaVFJFRjNxUEtaRmtnY0lP?=
 =?gb2312?B?YnViTEF1MHFtSmdiclJmSDgwYUJVaFQ5R2czUHRSQzIvQnFHc3VMbVhMKzdi?=
 =?gb2312?B?b2tTUWl1T25SMEc4TWxLVDhielR0NkdLZit6U1h2TFBKNEQzbTAwUyt4T1FY?=
 =?gb2312?B?R0RsMms1YmhBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?NUg2bDJFVXB1WEJFQnBXenFpbGp0QitYbG9VT2RHRlh1djZjaGIzaUJDNm96?=
 =?gb2312?B?Rm1Nb1U3ZkNUNHZUUlZjOVl6OTJ5YjBneHBWSXVBd0EzYm5pVDZ6c05IM25F?=
 =?gb2312?B?THd0OE54WFJYNVpzaVBqMWUwM0FBQ1F1OUFxT0FseC93b2VrL2Q0R3RTM1Y3?=
 =?gb2312?B?My9idm8wTVlpNlRLRlhIeEE0NVh4ZHVKS2hCa2h0QWM2ODc2blo4MkNVUWRt?=
 =?gb2312?B?STNIQytmMk00ZnE2ekF1cC9GOW54QXNwUGt3TXJMODk3aWVBbzNkTlpBcGQw?=
 =?gb2312?B?RGVTQ0hVTmN1SWkzU3ZFRVg3YlNhSjZueHRpRjNnbDN6cEE1clU4a2NKeXdv?=
 =?gb2312?B?d2IrZmsxVjZ0QUNZQ1NHdkpENTBsNkVCQXoram1paEQ0TDdmTEdhNWhqczZn?=
 =?gb2312?B?aDBBd3dnNHNsRGphY2daeVlxVHo3UHQ3K0VwNTlvcTBLMnVJczMzbDZvd2xq?=
 =?gb2312?B?TkJBRVNzS2RoK0pKOXFlLzJ5MzF2Zkxla0tHaGRwQldTa2JqWVZoODdFdUN1?=
 =?gb2312?B?NUNRRW9UWHMxVHNVYVdoVWhKazdjaGRPZzViQ216N0U2VW1ramFBWlhsaVo0?=
 =?gb2312?B?TURJREVIb1NzVk9HL1piVm5SL2xSVm1td21YTldBQjU0Q2dpc212bk9rWU5E?=
 =?gb2312?B?N0YwK2VGSDdqOFFUUk1iUWN6NnVCVWtKZG9IY1RlQ1pDQzg5YnpJcENFS2NS?=
 =?gb2312?B?ZzJIQi9BdFR4Q0JPc3hlRjdDbFdMcWs0dGxIUmQ3OUk5Ynh5eG1BOElkUmZV?=
 =?gb2312?B?RkV0eS84ZjRZdkVLdURwSXorN1ltY3VtV21SSHRMeWhBS0p0K3czREZ6L2Y3?=
 =?gb2312?B?bnBvM3pYbVlkUTBESEtFclQxSkN1eGVFbExueXJTaUdHb3dPZ05zMVVGS29a?=
 =?gb2312?B?a2ZPVFN4SG1kc3dZNktLM1RWVUYxQm96M0hNdDJlVE0xT2JjUzZUK0ZXdXNv?=
 =?gb2312?B?QmhKWkRya0ZmQXVTNS9TV205d016dkFURk1jMElVR3dqdVh2aHdTdXMzWEFq?=
 =?gb2312?B?aDB2RCtOVllWNTBURXkveE1WbUxTNGUreHRySkRuU2tkdk1DQUMrS3Fyd1NV?=
 =?gb2312?B?SSs3T0dFSE1weEFUSkIrZGxpOTlacFNzam50dEZpcW5lYjBqalg0UGIxZGhp?=
 =?gb2312?B?aU9ENHVRM096Ky9rVHhjS1lhSEM4VG01RmhuZGwzc0w5Um5NWXBUdlpWd25Q?=
 =?gb2312?B?K1NGcDBhd2RPdlRIZHRIdEtNSXQ0V0N6Vy9jU1BvQkNmTkk4aU5LQngxZGxX?=
 =?gb2312?B?L1VzS2U3bzdSeWlDcWFpWUcwQ0RHV2lRUm9rRjFZek9UM3NmbGNHK1JGRnJZ?=
 =?gb2312?B?OG15Q1ZZSndpa3pnbi9sZmp2OVcrQW81REZWWWNVTVk4Nng0bWw1MWU5c0s0?=
 =?gb2312?B?ZlhOdmg3ak1vUWtjYmJvd2wrY1FrVWtUMUFlSldmbXBDVmg1aE9KTnFQc201?=
 =?gb2312?B?Vkh5Y1dsV0srQldZdlhhSjVjeXpFLzVzb1hZTWpxRzFHaFFUVlgrS1hJWngw?=
 =?gb2312?B?cWRUVkJES0U2ZVF5dVlaQWZ3ckdhWklGcjRFRis3bkdLZWF2cUdhMDZxTEV2?=
 =?gb2312?B?dHdwSi9tU0VYNjh3d3hyL0FhQi9xb3FOTUR6NlN3M3RQdlVCYS9DYzRtdHla?=
 =?gb2312?B?ZWYyYmhQSjJuVUpLTkdjRzRrMTMzdTk1dGRpaVpzTFNJSUpKRmsyMW1JSEN3?=
 =?gb2312?B?ZFVZN0EvU2IzMnFmQ01CbFY3eFp4M1p6OE5RRVoyRklVSGwvSmpDR1BhZFlU?=
 =?gb2312?B?cEg1YThFc3hndk94WGVjaXVIeU1tQkhWV3hlajNWbHczUExtbTk4YnJGNEVs?=
 =?gb2312?B?UHV5SEtURlVBWGNaRUJSNEtkSUxsdVBzbnBXcTZHQU5weTc0TEVMZjFvK0NF?=
 =?gb2312?B?S1dqTURnQ2EyZWVzc2ZCVFNydkUzd1BvV1hVSG15NmM3YXdYSk04T3Y5R0NX?=
 =?gb2312?B?bDNyVERQODExd3ZDWnQ1RjFRcTVTSW1DY1owYWtnYTJXZEJZanYxaXFXMi9Q?=
 =?gb2312?B?WGQ3bEM1UXcwcDZFbTg3bUJqMG1ob0JLZ2ZDS0tNenFMUjZFOFZ4R2w5REs1?=
 =?gb2312?B?RTM4V0ZUMVJ0OXY5emFTdmE2dHJNS2Exa0VLc0VDNFNrajIra242MkVPbnpr?=
 =?gb2312?Q?3l1A=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a0561640-c6bc-41b8-4dcf-08dd89737ecf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2025 12:18:49.7763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U0HMMgPvwV4oU7vO7ecKBG9RatPprraRhWZtn8Q7gnv2AHdzo1+e16bS7ieLXujN8PGzRln8om97AXLjer5ByA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6476

SGkgU2xhdmEsDQoNCkluIGhmc3BsdXMsIHRoZXJlIGFyZToNCg0KICAgICAgICAgICAgICAgICAg
ICAgICAgaWYgKGhmc19ibm9kZV9uZWVkX3plcm9vdXQodHJlZSkpDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGhmc19ibm9kZV9jbGVhcihub2RlLCAwLCB0cmVlLT5ub2RlX3NpemUp
Ow0KDQpib29sIGhmc19ibm9kZV9uZWVkX3plcm9vdXQoc3RydWN0IGhmc19idHJlZSAqdHJlZSkN
CnsNCiAgICAgICAgc3RydWN0IHN1cGVyX2Jsb2NrICpzYiA9IHRyZWUtPmlub2RlLT5pX3NiOw0K
ICAgICAgICBzdHJ1Y3QgaGZzcGx1c19zYl9pbmZvICpzYmkgPSBIRlNQTFVTX1NCKHNiKTsNCiAg
ICAgICAgY29uc3QgdTMyIHZvbHVtZV9hdHRyID0gYmUzMl90b19jcHUoc2JpLT5zX3ZoZHItPmF0
dHJpYnV0ZXMpOw0KDQogICAgICAgIHJldHVybiB0cmVlLT5jbmlkID09IEhGU1BMVVNfQ0FUX0NO
SUQgJiYNCiAgICAgICAgICAgICAgICB2b2x1bWVfYXR0ciAmIEhGU1BMVVNfVk9MX1VOVVNFRF9O
T0RFX0ZJWDsNCn0gICAgICAgICAgICAgICAgICAgICAgICAgICAgDQoNClNvIGRvIHdlIG5lZWQg
dG8gY2hhbmdlIGl0IHRvDQogDQoJaWYgKHRyZWUtPmNuaWQgPT0gSEZTX0NBVF9DTklEKQ0KCQlo
ZnNfYm5vZGVfY2xlYXIobm9kZSwgMCwgdHJlZS0+bm9kZV9zaXplKTsNCg0Kb3Igc29tZXRoaW5n
IGVsc2U/DQoNClRoeCwNCllhbmd0YW8NCg==

