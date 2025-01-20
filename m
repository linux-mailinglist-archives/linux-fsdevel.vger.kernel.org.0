Return-Path: <linux-fsdevel+bounces-39708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E3BA171EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 18:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7BA71881BAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 17:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332011EE010;
	Mon, 20 Jan 2025 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="gXepaEP9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2136.outbound.protection.outlook.com [40.107.102.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C216A15575C;
	Mon, 20 Jan 2025 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737394103; cv=fail; b=aEjJlqu8c9F0+SsuN2PP4tN2cNMyMFlqYc6FhWMMQbxFXGOGHaa51//UOzyhBAAoTl74OQUOzywLGbm+97Ct+SVyq4jJICX6ae0V3SuAxCdG+5Ckc3Mcl3Juz862hcUDSECuxJyQoTvtVK0OW2HgExuU5OdphLRiqMNueB2uNIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737394103; c=relaxed/simple;
	bh=JhHyGrhO3fGFVwJ3xdez+N/gUrBdtAZtfKsums4YDuM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YmC1wzDhtPdtCSGJLd2QgjIMjDtlbwUUw7eZcvgZIThcCWdnXAXK0/aWGclps0iHgYszf66lZ2QW4t7xtyrrlnBpxydk/S7ZeUi73W9bNL1sWtdCtcbQzz++dMFlKUq4q1ToR/QqzkMROESMOC4PW6DmrDsxZa0Hwf7otvlDuAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=gXepaEP9; arc=fail smtp.client-ip=40.107.102.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWbi3pwIxFU5ASp+SzOrA7A2poFJCDhZzkivpJuuCc/P/W0QkBHz9boXzqKvaYCn4KoGVHaztGuB2nv3B8h9t7+sFvGBk06o4yZMXNasvLLzE5WDJ2xqYAw26h8rR4NEmFZ2ijvxvmok0GryTHLqgi74YwPOrSzpPzmrRuOnAC87QTJcRVoKzXxMIneK8dMKuEP0jgdj6RFm0PgVl8eGCc92b3Y8m/XnJlH55reLCqij4gYvGk3R838IsmWSZ5k8gnYbwhTQ047CxTZFcQsgNE8AoxKFttiNzv/9+qwit3CtTRwYG7uedUMm8cdQvTFEDk3HzeeV5labwcEQsRWwvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhHyGrhO3fGFVwJ3xdez+N/gUrBdtAZtfKsums4YDuM=;
 b=XCDcVsK76EO9nsTmD6PhT6JKEiZkB+n96HQYWaLysRr6AnO/iO+bm/ktGEl42P0nM2wiPv84ZITLDnePjsu67kCfMwQPvmrzBUhw2nGWMohZtz0ieF8BSRSOxwgmGvJrxnkr+yQId1vqGCu1BAMVOlL8H4xo2NzyeoeTqboJHMu1YG03cwK4UbNSaFRB+BJe/5Z18EIicDb0VDI3uz1luiv/yaoPhldeh6Jxw41T0qn6NAOcP/rxIfLQ4VuF3joBVEhD6pHAuA15RPhY9vXpQxz/6FN0t91zJzcZYY0XncS6jTq4YpXBZ85xXj5tq88dhTuD+08gm/kG7/Qd9RzjhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhHyGrhO3fGFVwJ3xdez+N/gUrBdtAZtfKsums4YDuM=;
 b=gXepaEP9fhgmAF1dfx9UqaycqSagpOj9Ua90NNIRWzegsq4gaA8V1qmkp8wfKVXslZJjJCcJYd+TCpiL6iugz/semNkSlsl1iydiniziYBzXun1g83MRmy9v1fqPGVFdJCErDdetzDJEbyVqngYIVfDr1ARS2Lg4j8QcDrQbN2I=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA0PR13MB4061.namprd13.prod.outlook.com (2603:10b6:806:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 17:28:18 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 17:28:18 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "amir73il@gmail.com" <amir73il@gmail.com>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] nfsd: map EBUSY for all operations
Thread-Topic: [PATCH] nfsd: map EBUSY for all operations
Thread-Index: AQHba1+fzw+WkJ1joUqohuwhSceLX7Mf6qKA
Date: Mon, 20 Jan 2025 17:28:18 +0000
Message-ID: <c47d74711fc88bda03ef06c390ef342d00ca4cba.camel@hammerspace.com>
References: <20250120172016.397916-1-amir73il@gmail.com>
In-Reply-To: <20250120172016.397916-1-amir73il@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SA0PR13MB4061:EE_
x-ms-office365-filtering-correlation-id: cd064ab0-4f91-427b-57d9-08dd3977d48a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dFV0N0xIaXdtNk9Kb1dLOTd3NUI3WXVXRlJGZ1ZVUEF5NndycmMwbWhPWFdW?=
 =?utf-8?B?SzdsZWxKUHdVUS9DVEJLMzQ1Ry8zYTFCcUx2OW9KNk1DSEtCb3pmeTRUZWtL?=
 =?utf-8?B?RWNMMm9NZE9QRVlGL0ZKT0MzN09RNVhZVFlBOFpFMFZtYm5hSllsYW1HTzNk?=
 =?utf-8?B?ZEpidEJVQkQ1UGt3R2NsMXU1ZTBtejZXM1JXVE9WNFRvL2c0RE1rei82TUVp?=
 =?utf-8?B?VCtpMmgwWnNSU0dQV1A2Szh5Vm9VZ3RQMkNzTkFvUHdUUWVrcXlVVXU4ZERI?=
 =?utf-8?B?ai9tOWcvMjNkNHRreXRFa1dXTVk2bEtiTktyVEoyd3kwczVaZkxFZ3hNWi9x?=
 =?utf-8?B?bytuRXNoZFNxdnEzaWtEUlE3bHRYakVad2FjWU1pR1lBN01lUDBmWWVpVUlj?=
 =?utf-8?B?ek9pQkVIV3JhdXFFUy9PenhCaGwzbXF2SlJxMDQwNzUxOUZkYW5wL2VQTFlW?=
 =?utf-8?B?eHZ3a29aQ29jc3VjLzlVZ0hPUytEcDdVbU51bnR0ckI3Y0l1WHZHMWprcWhx?=
 =?utf-8?B?Q3I5WmJydzZNR0FlUzYxaFkrRVV0YU9HUDJ3NHM0RkxxOW5lbnhVMGpEQjhw?=
 =?utf-8?B?bXRSWHVBb0dzNVdLUll3cE1uZFdETnhiM3pydHVhZlNZNTlmc1FIbWVPNWFE?=
 =?utf-8?B?VzNUWjU1blFKckxyUjY0UnVJUkdvVmcxOGRnZXVvc29aeGRrYjVvbDZQNlJo?=
 =?utf-8?B?NmtyMFZjbTlQRXN1eTNpVi9UUlU5RnNLMkhvMEE2OGlwUjJLTFgyQTdDaWh6?=
 =?utf-8?B?eVQ4dStmdU1lOEFpRGh5N01HNEVCQ0tWQzdrWlZJNm4wRGd1THF5Vjdobk5o?=
 =?utf-8?B?bG5yeTFJa2I4QjZ6eHdCeTB3bXZ4RkdLZlhJYno3TkVDZ2ppSUxPK0ZMek10?=
 =?utf-8?B?VXBTWU5QQnJVN3NMdEFiS21oVFV2VWhOa1JGOWM4ZkhrWUVyVmZXK05CblY2?=
 =?utf-8?B?TmV5MEM0bllMekcydWRGbWdyQkxxT0NRQit1ZFVTYURCSzZweDM3eEY4d3Ba?=
 =?utf-8?B?VWxaSk5sOEZvaXREbDFDZkhhK2h2YThJMGtTK3E3UjZCb0VGS1NIOUdSQi9Z?=
 =?utf-8?B?TW5pODMxRDMyQ1RTcEZSSTIvMlNURkVIZTdOY3VqL1RqVGJZblBaK1JXd1RS?=
 =?utf-8?B?cGFlZUJkUkJsRlhRdVd0OURuY00rQ2pGRHVQV1VnMTBmM0xNWnpVSG15TlJl?=
 =?utf-8?B?bjd4ek1oek44aHF4NFpBN0N1QVhRSG1wNmhSVnBqN0VDTXhuOW4zdmROU0pz?=
 =?utf-8?B?ZmdaSWNGK0JhaXdFblBTMEZLMTY5bEZaRjk3QTVFT1E3aHAvQ2hibTFhTHFC?=
 =?utf-8?B?a1lLRGMrUGhzU2xENEJMcHQ0Mk15QkFnWnlUSlAycFhBem02dTIvcHdaQVln?=
 =?utf-8?B?b2lZai9pb2krMFRFMURkVTJrcThPRW5PQTJqYnp5UzM1RzNMSUo5YUtYK003?=
 =?utf-8?B?a1B5ZnVyMFlBVVlTdWZPTkhENjB1bUlPY2EzNE1iVU9MK3F0aHdadXJrbUdz?=
 =?utf-8?B?Um13bHpESCtXZlpvY1QzYzAreWRsa1NMOWdRVnNSWHEvc1k2dFVhc3QvdVpO?=
 =?utf-8?B?WXZkbG1kTCtRb0RTUXhWTS9pNDhzSFdsMHNyQmhvRlNBK2ZuU09SOFFVTkYx?=
 =?utf-8?B?SlRMRjRDTGFldlJmUy9nbjlaRGxxL28rR1ZlRzdJZG41cU85UVRzYWxqQU9R?=
 =?utf-8?B?dGpBSXQ1RDJSUmhsSGxYY3I4RllTUFhyd2YycXJmZ0F0V1Q5OXRYUFFyS0dH?=
 =?utf-8?B?QWxia2NJWmt1OWlhOXByTDhrNnRtUUF5U3BUQkhudDFDaU9rR0tGdEhjTE8y?=
 =?utf-8?B?Vy9MVVRLSkU0endTZ2dIcjFhMUQvVkw4RU9pYnFJbkluRkhUMjg2eEg4NE9J?=
 =?utf-8?B?S2UwN0lpVlpaeGNocXlEeGxHZmhhQlFMN3QxZTZFTktaQ2YxZ1RlSmFaclJW?=
 =?utf-8?Q?AGRE4VbFbIKr1ioynhdDX3N20IlcqIAK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Tkx2M2pTR0JwOGtLOVc2aEhaOXZBREpyOUtSSjlCL0pQQk9peXlYTk40Yk40?=
 =?utf-8?B?UlpVMDlDUmhlV1dHWGVDejdtOTM0TkZVQndCNmZ0eXo5MDd3cmNYbzFrb2lu?=
 =?utf-8?B?NHFLMEFDdFJ2VmlrbnBRdnI3ZjlQOFNoVTNwQ1JMV2RmTXdDVHZLY1JheHZX?=
 =?utf-8?B?b093bFlhU1VjSm1oaXFqSmpKeEJjaXAwTjc1OEdqZ1JEbEsrbW8vTjQ0TnRP?=
 =?utf-8?B?SUluazZkMkxEM0kySGoyTWpCTEhBTFBFczJHVGc0ZXdOd3k5L3ptdWFEUm1k?=
 =?utf-8?B?aitPS1hQTjhzWmQ3M1FqcGZ0SDVHWkxvTkdXd21qeW5FbEl3TmF1L2J6YWVY?=
 =?utf-8?B?RW5XQXVrdkM2VUphSDZ6QzRYS1dJd3VlK1h0K2tsTXI2VTl6OFYzTjFNcDA4?=
 =?utf-8?B?SmNBNDVGM2xweDFYR2xIWkZXcUQ3Q0RJN2xSK3RSeEx5a3AwUzZ4UUJaS1Jp?=
 =?utf-8?B?eWhCMVNCNkR0VjVUZi9iZjRJZ2FTT1UxNHdrUEJqaWwzbHlPZkpaRW95WFQ5?=
 =?utf-8?B?YmNsWTlDSC93RHIvZURIRCtnQ3ZKazByNlczQmVqR1Z5dUIzQmljRTZORTQr?=
 =?utf-8?B?YmZzVGZyYWJBR3cyeXlHYU5nM3MzcFgvdTE3alBlSzkxRm5YRlVXZHhETW5p?=
 =?utf-8?B?dHR3blRocVMvajU5WlJnTE4ydndOZWMzOUYrTk8zL3U4ZjNaQm1Ta2JUbnZK?=
 =?utf-8?B?VGZVOGJTQzlrdXFYVmhRR0QxMlEwTEYvWjBITUNUWTErRElsVDNUVjFSM0p3?=
 =?utf-8?B?V2ZHS1Y3TUZjdnJlcnpMUVhZL1N3WFFISHByaFFlZytja3oyVm1iZnNGdWkw?=
 =?utf-8?B?Q2ZhSkdGUHZoQ3RuUDJYUmhscEJpcDB1N2x6WFJISkFqa1I0RXFQWXNNM0lm?=
 =?utf-8?B?ZHpkbkVpTGxBcmRkdW5SeVROT3FGVkVjY2c2MklKRUxjVGJnU3RTaGQwYW5U?=
 =?utf-8?B?OFF0OS8wQlkvRHJQeGFRSktGMml2ak1aRllJY2dLVm5ENUQySXIzcmw1WUVX?=
 =?utf-8?B?dUFSL0JEYXRMc2JmV1FhMFVvL28xeUpKTEZtam8wSzRucnBLSTV1VmZzeHhi?=
 =?utf-8?B?aUt6SHFLajJTZFZaTHkvdjA3a0I5cTBzZVdOR2MxcEVuUUVIOWQ5bWtEV2lm?=
 =?utf-8?B?LzFsNWhBVzV5WGlLTUo2TGlyWGMvUHVWZzdwRmUrMEJwS2laTWNaS1ZNYmpM?=
 =?utf-8?B?SmhTWm9jVGpHOGU1YlpLMmRMeHdiYXZYdWNOakZRMkw1eFR0NDQrbmI5V3BS?=
 =?utf-8?B?RXJRTEtMbVFwTVVsTEJNcW9Nc3U2NWR4bFNYb0IvWW5DK0FJdHFSMzFJRElC?=
 =?utf-8?B?ck1kRkJTb29EOHBMS3dCZVhmWFBEODg5OWhwYWkyUnE1KytUTHF0Q2tXZm1M?=
 =?utf-8?B?Yy9PcXhQY252YndiNGttVEdUMW8xTE5ReVVxSVovOU84elVaUjF1SGlPOGFP?=
 =?utf-8?B?N0JKcXQ4ZXEyZk5qVi9BSE0rOHNKdDZIV2t1RnpzTkpMVkEzcUw5bVhGUTZm?=
 =?utf-8?B?aSsyMnU4dmU5SDhJYlFHR0lyVWQ2NkVrc2VQcG04bWpTaUE5R3BXSTc4RGla?=
 =?utf-8?B?dTgyTnZjSzl0bTB4RlZrZmk2a29uYmRYMnRwZzI5OGtVbHlXWW90NXl3TUNF?=
 =?utf-8?B?enYrTTByUzhRZXY5WWZEZ2JTY2dQcHZETXZqMUloZzFVTHNpeFNoV1hRTEpD?=
 =?utf-8?B?WGQ2UjRBUTNkNFVNUTF6cUVIL21SSkYzTmZZdldDYlVZaDZBMUh5aldmSDdT?=
 =?utf-8?B?ajFoVVBqY2lyWHU2czA1bExWYlVUVnFyNUQvb3hrWlhDbmZUUk1TWW8xV3Bn?=
 =?utf-8?B?T0xESXk2SWdyZjlXQXBlNFFmMFZqRy9rK3gvakN4eDhGS09KMHZaNEpRdHBY?=
 =?utf-8?B?Q1cyZkxSeGIvRlBpMEhBRjJWZVErU1dDbExhclJXaWpDMFUxZjdqdXRWUXBC?=
 =?utf-8?B?YlFxYjVoM21QVFk1UjNMSXRZWVJqNFJjS0RFa2Zaa3dEc3hLTGtENzd3RkFE?=
 =?utf-8?B?NWc2bW44Z3FQK3JpZnFuV2g3Q3huTkNkT2U0bno1emdXK01JelBQQ05SdndV?=
 =?utf-8?B?dTBDaC9LTkVsSTFwR2xCK2ZDcFVDNGdaN3l1UEVNTVcwcU9LSGdSWElPc2xM?=
 =?utf-8?B?TVJRQ0dIY2dVS01aTFoyb0JWcHlRblRvMEVhaG05UzZDQUNOTDRZdWdPQ2w2?=
 =?utf-8?B?bnovNDdiTDhpT1JwVldrYmFYK2xKck9WbnhJT1BaM2Qwd1E5UXFOYTVLQTI5?=
 =?utf-8?B?dExVaU40a1llaDJOb3FwM096azF3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FEADF6F4CAA3F64492605CAD7DB8FD7E@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cd064ab0-4f91-427b-57d9-08dd3977d48a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 17:28:18.6156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +KHTM0KHihSHEYaMBRqhDqN9nZUoNPqp9sqVPNS2Mr+UWfLZEjNOrnrjeVVwG7uxcC75zhmLX9/OrRs0UURsfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB4061

T24gTW9uLCAyMDI1LTAxLTIwIGF0IDE4OjIwICswMTAwLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToN
Cj4gdjQgY2xpZW50IG1hcHMgTkZTNEVSUl9GSUxFX09QRU4gPT4gRUJVU1kgZm9yIGFsbCBvcGVy
YXRpb25zLg0KPiANCj4gdjQgc2VydmVyIG9ubHkgbWFwcyBFQlVTWSA9PiBORlM0RVJSX0ZJTEVf
T1BFTiBmb3Igcm1kaXIoKS91bmxpbmsoKQ0KPiBhbHRob3VnaCBpdCBpcyBhbHNvIHBvc3NpYmxl
IHRvIGdldCBFQlVTWSBmcm9tIHJlbmFtZSgpIGZvciB0aGUgc2FtZQ0KPiByZWFzb24gKHZpY3Rp
bSBpcyBhIGxvY2FsIG1vdW50IHBvaW50KS4NCj4gDQo+IEZpbGVzeXN0ZW1zIGNvdWxkIHJldHVy
biBFQlVTWSBmb3Igb3RoZXIgb3BlcmF0aW9ucywgc28ganVzdCBtYXAgaXQNCj4gaW4gc2VydmVy
IGZvciBhbGwgb3BlcmF0aW9ucy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFtaXIgR29sZHN0ZWlu
IDxhbWlyNzNpbEBnbWFpbC5jb20+DQo+IC0tLQ0KPiANCj4gQ2h1Y2ssDQo+IA0KPiBJIHJhbiBp
bnRvIHRoaXMgZXJyb3Igd2l0aCBhIEZVU0UgZmlsZXN5c3RlbSBhbmQgcmV0dXJucyAtRUJVU1kg
b24NCj4gb3BlbiwNCj4gYnV0IEkgbm90aWNlZCB0aGF0IHZmcyBjYW4gYWxzbyByZXR1cm4gRUJV
U1kgYXQgbGVhc3QgZm9yIHJlbmFtZSgpLg0KPiANCj4gVGhhbmtzLA0KPiBBbWlyLg0KPiANCj4g
wqBmcy9uZnNkL3Zmcy5jIHwgMTAgKystLS0tLS0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzZC92
ZnMuYyBiL2ZzL25mc2QvdmZzLmMNCj4gaW5kZXggMjljYjdiODEyZDcxMy4uYTYxZjk5YzA4MTg5
NCAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzZC92ZnMuYw0KPiArKysgYi9mcy9uZnNkL3Zmcy5jDQo+
IEBAIC0xMDAsNiArMTAwLDcgQEAgbmZzZXJybm8gKGludCBlcnJubykNCj4gwqAJCXsgbmZzZXJy
X3Blcm0sIC1FTk9LRVkgfSwNCj4gwqAJCXsgbmZzZXJyX25vX2dyYWNlLCAtRU5PR1JBQ0V9LA0K
PiDCoAkJeyBuZnNlcnJfaW8sIC1FQkFETVNHIH0sDQo+ICsJCXsgbmZzZXJyX2ZpbGVfb3Blbiwg
LUVCVVNZfSwNCj4gwqAJfTsNCj4gwqAJaW50CWk7DQo+IMKgDQo+IEBAIC0yMDA2LDE0ICsyMDA3
LDcgQEAgbmZzZF91bmxpbmsoc3RydWN0IHN2Y19ycXN0ICpycXN0cCwgc3RydWN0DQo+IHN2Y19m
aCAqZmhwLCBpbnQgdHlwZSwNCj4gwqBvdXRfZHJvcF93cml0ZToNCj4gwqAJZmhfZHJvcF93cml0
ZShmaHApOw0KPiDCoG91dF9uZnNlcnI6DQo+IC0JaWYgKGhvc3RfZXJyID09IC1FQlVTWSkgew0K
PiAtCQkvKiBuYW1lIGlzIG1vdW50ZWQtb24uIFRoZXJlIGlzIG5vIHBlcmZlY3QNCj4gLQkJICog
ZXJyb3Igc3RhdHVzLg0KPiAtCQkgKi8NCj4gLQkJZXJyID0gbmZzZXJyX2ZpbGVfb3BlbjsNCj4g
LQl9IGVsc2Ugew0KPiAtCQllcnIgPSBuZnNlcnJubyhob3N0X2Vycik7DQo+IC0JfQ0KPiArCWVy
ciA9IG5mc2Vycm5vKGhvc3RfZXJyKTsNCj4gwqBvdXQ6DQo+IMKgCXJldHVybiBlcnI7DQo+IMKg
b3V0X3VubG9jazoNCg0KSWYgdGhpcyBpcyBhIHRyYW5zaWVudCBlcnJvciwgdGhlbiBpdCB3b3Vs
ZCBzZWVtIHRoYXQgTkZTNEVSUl9ERUxBWQ0Kd291bGQgYmUgbW9yZSBhcHByb3ByaWF0ZS4gTkZT
NEVSUl9GSUxFX09QRU4gaXMgbm90IHN1cHBvc2VkIHRvIGFwcGx5DQp0byBkaXJlY3Rvcmllcywg
YW5kIHNvIGNsaWVudHMgd291bGQgYmUgdmVyeSBjb25mdXNlZCBhYm91dCBob3cgdG8NCnJlY292
ZXIgaWYgeW91IHdlcmUgdG8gcmV0dXJuIGl0IGluIHRoaXMgc2l0dWF0aW9uLg0KDQotLSANClRy
b25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0K
dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

