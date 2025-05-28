Return-Path: <linux-fsdevel+bounces-49988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679A2AC6E63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 18:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63F4E7AA08D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 16:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191CB28DEFD;
	Wed, 28 May 2025 16:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ofj6vnQw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013053.outbound.protection.outlook.com [40.107.44.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BFD1922F4;
	Wed, 28 May 2025 16:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748451041; cv=fail; b=iAzEtnrWMyj3fuo8mEftu5+nV6SIk+WkAj83kYLenenN9kyr2+1twF4cMHW+u0KvJgfKet6bIhjJwMaM0w8gWycsZxPFndbmBKJskSOSj9JJEKuU/Y5ANNCnPs+lNqnIvxZEyb/an38YaX//cRv4YJvwYZICHJq8wGimSTLhpUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748451041; c=relaxed/simple;
	bh=KX15dh+0zEQfDVraCBeL3uhBID1l1ZSCUBoitGDza80=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H/BFTCS1jI48JZ0K3lqRvrS/1i5xUg+F9+TBLPu4R3Moad/ytPysK+j9Bx12wZQsdlCvL2ykClg+9T9wczyFRByVFaEX9hct/wi1tE88muZB36g66nCqHyvoFDusIJ8o7FdHpX6JJYr162/KSU087QDhkYIOaKAPezzlC5zD6z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ofj6vnQw; arc=fail smtp.client-ip=40.107.44.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HllxO+7N+a93KuwHSaw7Q8gs2pipfv1jfIAhKbiJUEOfPhJdOE3sf5NZu90AOIRpQpbuf7Bc469e6UCl/XzXxvt9PbU0SSBqmA9ydLX2PQ38lkxQu5Y9feHeBTV425j3v8pOqFlNASTlpdHJdJ4WUbHAtdnySe1RqdcOPJxyrXWrOi5nr55y1But5Z4mRBYgBqz3JAY6U1mzqDpjDB2TZK/hazV+wyrKg5Y1dJBbO5iWReZYLSo5ozUhdRZHbq+qmYXomQcRuKUDBHxTpaoeNNE3/xzYlsg6HqDwyLF3Qdg0JuRwIa2GK//7mLqYNdKx/rLvFiqivwhI3MDgc/FdRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KX15dh+0zEQfDVraCBeL3uhBID1l1ZSCUBoitGDza80=;
 b=T4UuHHP8670Oais7a9m/WMJrZwgwcH9Tfn0nGTO+H5nmWc6oMn8bHrfhWyhl6LTeHZbvMmgPND+0KNoHR1cw5TnzZXI+a0+3M6UyNFziRAG59ZeqNRZhYJjk+oC+1DsTPZsUjgbXPHCjH7gB9+RooxffyDSS7WuvtA04TKW0FhsUlZDcDyNEXP/tanWAA6sqCkxrD4XQgKjhw3vj9KYlIcz1v5c5bpsFJiQ5OR4KMW3uaArOmPfjpdYU2OGmkEs9ZobzWNsayC35UM3d5uJp55xVHslGtTTuefRcuXPhAumYRtNmJtNngZwagYEfWRl66slvz3J9ceM7AwkVLZPHaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KX15dh+0zEQfDVraCBeL3uhBID1l1ZSCUBoitGDza80=;
 b=ofj6vnQwGt+xsdZfUGT5xyKaFfHCQJZW7iOuDgDVjNr012prH3NzmwQxgnz9UbKUAOjPZNbajU8VokFEuGiS8Ri1rlVYAqxONA/MaNYn9dO1Qbwqxcli3CvsyOl/NmOl9yIDhGatG23eliq3/oRsSLCOusDN37LG3D0UlkfoLQxUUaFtrcAc66Ej7Kch9hr8nJqouuSuCDwAdWeNEFUxYNMN/GQQeer34eGd1p9XeIwIhPSvM4SVTlUGWVvd6rNsXUjMF64hEseZywU+Cy6aZusidxJ3HttcFn9LPL39wjmnJu79wWXzE4NV180wqzI7PqP+ECMdFAg6W2N9+F6oyQ==
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5240.apcprd06.prod.outlook.com (2603:1096:4:1da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 16:50:34 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%5]) with mapi id 15.20.8769.022; Wed, 28 May 2025
 16:50:33 +0000
From: =?utf-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>, "slava@dubeyko.com" <slava@dubeyko.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMy8zXSBoZnM6IGZpeCB0byB1cGRhdGUgY3Rp?=
 =?utf-8?Q?me_after_rename?=
Thread-Topic: [PATCH v2 3/3] hfs: fix to update ctime after rename
Thread-Index: AQHbyNuK5sJaklI8KEyoCCG+xKS0irPnIKYAgAAv2YCAAP45gA==
Date: Wed, 28 May 2025 16:50:33 +0000
Message-ID:
 <SEZPR06MB5269FF7D1C758B1A6E260F23E867A@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20250519165214.1181931-1-frank.li@vivo.com>
		 <20250519165214.1181931-3-frank.li@vivo.com>
	 <3bbf9fe0b5e4b2fa26e472533e16a31c9d480903.camel@dubeyko.com>
 <ca759782695a9e2195d39730edf939cadbe7016d.camel@ibm.com>
In-Reply-To: <ca759782695a9e2195d39730edf939cadbe7016d.camel@ibm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB5269:EE_|SG2PR06MB5240:EE_
x-ms-office365-filtering-correlation-id: 0e59f968-e72b-4b1f-989a-08dd9e07c34c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NkV2dFpRT3d1a0hXUCthUDd2UnErNFRBOFM1MDZzRTFadWxYNTJodzk1R0Fr?=
 =?utf-8?B?SWVRZWR2QVBJbk82anBvRjA3VjFoeEVuTk9yMEVwN2lVeWM1aG5SWGxvN2FX?=
 =?utf-8?B?dFdkWkJ4TXBHV3FMMkNxNkhiMmF4T0sxK0VuWFZEcllUYUlia05adERoOVRi?=
 =?utf-8?B?YTZtdW5ZdE02YjFkU2xieXZIRThXb2ppMFhOcm9iY0hXWllVUHhOQXNoeXF3?=
 =?utf-8?B?UWdQTS9KZlhhaTFsWXk1N3p0VFZWKzN3Vk5mU3ZLNG96QkRQWm10dks5TVhk?=
 =?utf-8?B?RmR6SHExVVhIbzhoT002S0UvamErKzg3dk5Ma2RySzJiTktIUnZTeVhtZE5T?=
 =?utf-8?B?S2ZjYmZQUXZyNlptbmpwajZPUVg4eVBkVWF3SUdDVW5RL2t6RG9zY1AzY1ZD?=
 =?utf-8?B?dHRXZUVyc0NUam05emVzY0tnTXIvbmhBYjRFSEFTZDgyOVRCVmorcEdxR3Zv?=
 =?utf-8?B?UUE1SjJqY201WEE5NERmRzlkd1M5YVUvcWdDWlpUNmxDeFc2b2lWQmdBa2xv?=
 =?utf-8?B?SVJURTRNZDZTbHJBam1sVUI0aVZyV1ZveXZjM2VnMzVNbHNtd0M3M29TK1or?=
 =?utf-8?B?SlpVclJvNW04L1pUaFBUV3lqRkFuYVNvVDdvZTVINFhyRHRJNkE0eHJObnpH?=
 =?utf-8?B?T21abW9tejVUSjFDYXJ1VHV5MWlPQ2pROWZwWG5POUo0WlEvYW5qaHFzdUhE?=
 =?utf-8?B?NldlRldqb0lWSExoNFh3N1J6Y1dFYVh5Z3JVSEs3U3YyTFZxbUVsbmhEWC9C?=
 =?utf-8?B?UjIzYWM1T09TNnBOK01PTFhQMXdQak5vV0tTRUtpbFJscFlDOUFOdW1HTXk0?=
 =?utf-8?B?b0RhOVhOODdXNUhsYmYrWFdBMGdFWC85bDE1TWo4NXhMTjFUc0F6UGFEMnYy?=
 =?utf-8?B?aXM5SkVtQllyeHY0RUNoZEFybTdmS2N1TTU5a0xwVE40Nzhsbms1MFIvMXdn?=
 =?utf-8?B?bEZmM2tRTnlsRTMxUGUrN0c2cDZROFhEYkV3d3d3YzRZMGZvOEEvSTk1M2ZX?=
 =?utf-8?B?dE9nTFVESkRMMFo4djZBM3UzRUlaK1NkTkQ3amJhRWVZL3A4UVdFSkxjSmdK?=
 =?utf-8?B?d2hPVHIvd21peE54dUdwTzZEN0s4dHczdzNGMm1McDBJZ21oUVF3WkN6ZnJI?=
 =?utf-8?B?aDkvU2ltbCtIQjF3Y21JQkNwZlhSVGFXcUJuanI5d01QUnlKdzROd3RMcmgz?=
 =?utf-8?B?SnFCOW5UQkxtQTloYUtGZmFRb1pMNHZIQ0h2SnoyNkRRdFVwajF2SU84UjMx?=
 =?utf-8?B?cWZ4Q3BxSURDV2xVOHhOeHRuUnhNL2JadGZFVUIvNUJMQndYVFZUSlpnSjdF?=
 =?utf-8?B?M2JPbGV2dkIyNkpKN0J2TzBLYnJ3VmtxTy9WZnBWby9WSkh1RXBRZlVjUy9R?=
 =?utf-8?B?S1cydnpma1VOVDUxM0U5NmtGM2luemxpbFgvQWF6Rmo2VDFaeU1wR2JyWTBX?=
 =?utf-8?B?MVJKNEloTVpoM1paYlVjcHh6N1dWT2JJT2NqZ09ScVlDU294ZHRNY2MxK3ZG?=
 =?utf-8?B?YzFmdzludnBEMXRrRW1TNURHVEZwZlRxNWMzVnVqR1Y1U2hLRm9XaE9welhB?=
 =?utf-8?B?NFRoUlI0SjhnT051TGNvY0ZueDNnT1Nac3hXZVIvb0QwQ3ovTlpBdVZtaGQz?=
 =?utf-8?B?dFg0WTdqWlpmRmdCemFGeStmUTl3a3dDQ1ZJSDMzblRkdkp2K1B6Z2J2WjJn?=
 =?utf-8?B?RXQ1S29xWWhiSnNsRCt2UnF3eW5DQjVCNUdLa0xDWFJGUU5OSFk4QURRQjc1?=
 =?utf-8?B?SHJJNDU0czFwUEIvL3NyQ2R1anRXZ1VhOXRYVnplT2RNUXV2OGRWR0M4bzgy?=
 =?utf-8?B?bWRNOEFubzdUMGJ4VkZ4RURkZ2NVdmVWRlpyUDJzdnA0a3FUZW8xbVdDa1N5?=
 =?utf-8?B?MWMvY1lSL1o4VjUyREdheldEUEZFRTgxZ29JV1o4SXJBeTdsaGdwL2oySmNK?=
 =?utf-8?B?aGxTWXFtaVZMdkxsa1RwNGhWTHZYcjEwK2ZMVzI3TW0vOXBBa0l3MjEvTGdV?=
 =?utf-8?Q?NWxCLv7anAm+L+l72xoxqebWJfjIk8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VjBDNGdlRU84MnpoS29KdDVmNE9PZWJTaVpKMmJaQmdqcGk5bVlIL29oWWRq?=
 =?utf-8?B?Rm9hWWZqdHV3Q3NldlMveEgyUWhPdmJhYlBmRTRTc1czZ1d4Mjk1K0Vmd0Fp?=
 =?utf-8?B?L0VrQXR3NmwralJCYWRsQ1RDbWtza0I1SWd3NGQ5V3AzakRCSzBBVkMwTGZO?=
 =?utf-8?B?aXE0cUQ1b2YwZjJXclozYTlDanAxcDNSSjdBNEJwOE5UTWNtd0k2Mkg4d2tJ?=
 =?utf-8?B?U1NYWVBMTkt5S21KeER2cnlRRnZveEc4dFNNcXNZT3paa2VKbUVuRjExSmhj?=
 =?utf-8?B?QTBKSXVsR2lkQ1FDNlFXUzNwQ1NoMUFsS0lOZFFQYUtwNDcraVY4QmdJcUtL?=
 =?utf-8?B?amxDTFBZejFiOVhFN1Z1YldGSEEzM3RmRktGa2pUS1VCYTdBSmxqNDVjaXB0?=
 =?utf-8?B?NWJTdCtCMWFMS2NQYkZWTzFVby9mckFsdFVXL01na01ZQzJrUTJiMlVzRTB6?=
 =?utf-8?B?cWNzVWR6SWx2ZHZ1eGRrWEhCRmRUOTJDakdMNkJ2Rkw0akNMVmJ5ZEpqTmZx?=
 =?utf-8?B?ZWE0WklqQmUyMTlEWEJWSS80REUvc1pWYnNwOTJkTm5MT2JTdXR4TERWZ1Yr?=
 =?utf-8?B?c2tSQ1J4M3ZMWXZ1V0tyN0kvc0o3b0hRNTROeDhocEhkWFRFQk9JRzVzS3RH?=
 =?utf-8?B?YUxFOEw2NG95U0dOT21rY0R4UmpXZ1hFMHJ0UHlOVlZUUFVKYjlyV3R6d24x?=
 =?utf-8?B?cUVZN2RSWFROT2hlSENVS2lVMlFCd2pXekpmMEtoOWNKdmExb1JTSmhSSCtp?=
 =?utf-8?B?bmo5Y2E0LzJyRFNoZ2xSR1F3UjliM2dXaVJnK3BmQ2kwSXZSVWN4Q3ptNHJ3?=
 =?utf-8?B?OHpsMUV5LzlLM2tHRGxLTm9JbDRMa0VBVEVKWDlMZFdmZENodDFGNnFKUUR0?=
 =?utf-8?B?V2J5K085TTlDOE5SRnA3R0NVU2VEdkdFaGZzOGZUUnhMaGFJQVNNTHBWblor?=
 =?utf-8?B?STFVWEhBWEgwYmhCaXc0RzdkTGczR2IxUUx1L0kxT3k1ZThMUE9XampSamd0?=
 =?utf-8?B?Qkp0VDVwODQxUEdJdndXYWE4azM1aWZSQW9XeExObzJId3V0TjlEbmNQR2RX?=
 =?utf-8?B?QVRvODFsUzcwbVlQU29sQzdJYjZIbi9lUDdzeVdvZFFmRWNUblBxYzN3WWt5?=
 =?utf-8?B?TXBCdzNYcTNnNTR0cnR4TXRQZDRweGJBY3RNanYvaVhnQnFXbDh0Yld4Z05m?=
 =?utf-8?B?bTZWdWJGUFlBUUFnWEVxbHZ0bnZ3UjlLTlRabzJmWnJhNGZ5TmRXU0NDcEZU?=
 =?utf-8?B?L3l1T3ZwcTVtaHZXNUhTMTBHVkF5N0FnaXFKbXRSZDJVdjhSZXZEYkZES1p0?=
 =?utf-8?B?aDFjbDM2L3krNmo1eDdTYkpIYnlHTjBYczVadDZYclRZWFA0RmswM3BMK2g4?=
 =?utf-8?B?WFdrSVBQdk1wZ0crU0VmSFZFdkNsWEU3QUFiOFdtZkJSYUJvcHpYZHdlekNx?=
 =?utf-8?B?Y2NOeEZGbm5vZXA5eENOMldlaTIvclh6QTBmcFpMV1VLQ0tOcEtzbTNjTUxK?=
 =?utf-8?B?b3ZBdytLcW4veWdEMS90eENGUjljb3hza29BbkJkbjdqSlVSMUMyUnU3OWV1?=
 =?utf-8?B?dzdJcjBNTXBLd1l1WFZ5NzR0emtGRWFXSmp4aWNCcTdwQ2dsbkdKMTBteW1a?=
 =?utf-8?B?S3hLdXJ5a3c4Y0pQdFV2RGoxWnpsNVpRZUZUZ0ljbXpkYTZ3eUlCdkFvOHpE?=
 =?utf-8?B?ZlAxN2tUUER0aXFiQ2d5R0plcUMvaHh2WjJGYnRsNThuMnFlRzFFSVRQQkZ6?=
 =?utf-8?B?a1U0WE5BR3JrREJJQXhUeXhabjVWY1BnVkR1WTBHZjVsU2JsSEcwbFY1am1s?=
 =?utf-8?B?S3hONm5tRktjdnlSYWkwYTFVVTd0bjdEekI5ZWttK3VlVGd3bzBzdktsaDZp?=
 =?utf-8?B?d2tVK1hJUnUxSjZpUi91M1lMZjVIc1lqZjdoa3ZuZ2FzNmFqUmhyZE8rY1NR?=
 =?utf-8?B?eDkrcFZ4SGZuVFpkODcvc1NoSWZJZ2IrOTJ5QzN6YUFqbTNWTzVTbUNsWlJK?=
 =?utf-8?B?ZWc3cUtxNTBVODk0R2NsZHcxQUJ6dm4vbVB5Ykd2NWZBNWxIMy9Kb1VVL0F1?=
 =?utf-8?B?eW9Uc0xOSlpHSmRvRTk2Z201dEpCSW1Mdnk0OUwvTDlBcjByV3FYaE1kWlgr?=
 =?utf-8?Q?ge6E=3D?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e59f968-e72b-4b1f-989a-08dd9e07c34c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 16:50:33.4628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sNeQQJalhNDLV2xvZFSSAUf383KxEJq2qkDw2yVkIGo/mdseZl/jDSG4owdaii9dS33bu0qlC6uj2YH/HVVjeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5240

SGkgU2xhdmEsDQoNCj4gRnJhbmtseSBzcGVha2luZywgSSBkb24ndCBxdWl0ZSBmb2xsb3cgd2h5
IHNob3VsZCB3ZSB1cGRhdGUgY3RpbWUNCj4gZHVyaW5nIHRoZSByZW5hbWUgb3BlcmF0aW9uLiBX
aHkgZG8gd2UgbmVlZCB0byBkbyB0aGlzPyBXaGF0IGlzIHRoZQ0KPiBqdXN0aWZpY2F0aW9uIG9m
IHRoaXM/DQoNClRoaXMgaXMgbm90IGV4cGxpY2l0bHkgc3RhdGVkIGluIHRoZSBtYW4gcGFnZSBv
ciBhbnl0aGluZyBsaWtlIHRoYXQsIGJ1dCBpdCBzZWVtcyB0byBiZSBhIHJ1bGUgZ2VuZXJhbGx5
IGZvbGxvd2VkIGJ5IGZpbGUgc3lzdGVtcy4gDQpCeSB0aGUgd2F5LCBJIGRpZCB0aGlzIGV4cGVy
aW1lbnQgb24gYXBmcywgYW5kIGFmdGVyIHRoZSByZW5hbWUgb3BlcmF0aW9uLCB0aGUgY3RpbWUg
Y2hhbmdlZC4NCg0KPiBBbmQgd2Ugc3RpbGwgY29udGludWUgdG8gb3BlcmF0ZSBieSBhdGltZSBb
MS00XS4gU2hvdWxkIHdlIGRvIHNvbWV0aGluZw0KPiB3aXRoIGl0Pw0KDQpJIGxvb2tlZCBhdCBv
dGhlciBmaWxlc3lzdGVtcyBtYXJrZWQgYXMgTk9BVElNRSAoZS5nLiBqZmZzMiksIGFuZCBzaW1p
bGFyIGF0aW1lIG9wZXJhdGlvbnMgd2VyZSBzdGlsbCBwcmVzZXJ2ZWQuDQoNClRoeCwNCllhbmd0
YW8NCg==

