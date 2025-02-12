Return-Path: <linux-fsdevel+bounces-41564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC335A31F31
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 07:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D5583A11CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 06:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D511B1FCF4F;
	Wed, 12 Feb 2025 06:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="KxZ/XkjP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D451FBE8A
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 06:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739342288; cv=fail; b=skeRKG5ghIYQeCO9gxfwMm5MuU06p0rDgRNsoIU2EGrqvYVeea0BQ0vTflrkbnO3Zxm/BoCMmq5zDPqGY9I1DRFyupz/ZNTPhktgV1cK5lFg5pGpOhN58tMoB3GHv33kg3knvkldQlB7PKaSl6gldsPeO9Kc1MWx5MbIMtZXgi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739342288; c=relaxed/simple;
	bh=hUZNbyZRlBbymwatGJu2HZPjoG4/Ewa+ilU8rkug61E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cPTrvz1WZhUXhVuWLS1cfRF8hC4641nnBnO6kBDqxIWp7mjKG4cb5unn9OXIKQqUoHpRr2GWpvVYziM5aymvbw4wVOVAq5ScN65Z5MoPk39UFBps2473BK618VzqrC7BoDg7K6n7yD8EqHQx0kiSOzthfdBrUkMKl450xRXab3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=KxZ/XkjP; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C5uLLp032611;
	Wed, 12 Feb 2025 06:37:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=hUZNbyZ
	RlBbymwatGJu2HZPjoG4/Ewa+ilU8rkug61E=; b=KxZ/XkjPpHKIPCtgrjXBdJX
	B6KA36rHrDnIg+KUI4yvCCy2W5pa9MBQYDVsDEgvAOfH231vaP13WmsPDdMO5xRv
	M/TtHL1SFSN3LSIA9AQm54ALw6AHjtE8U86kvRsyth47L4+vCBSvTNr0KMt5Z2p8
	Qdk5dsFIwarrC+pLIxHhJqESjjnBQCmGF0xMR4X/ZvJoWOYEQWO0hKrukgib21lI
	pufnr1EqguVIxRfxyfNTt2T9iqz2W15agltevYCbU+SR1xUCJLpZ8dVpPZKTeOrV
	3jZHN3J3o+TTcs6fRh50m5VGb4CrA0LGLJcekSKfqj+tMGJHcStu/2jAvE7TkLA=
	=
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2041.outbound.protection.outlook.com [104.47.26.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 44p0jpuatw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 06:37:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAVntIOey6BzJl94nHuAAD1mENkekMz7kVZON2ImEV2IyjJH7SVGqLEy78ZDDScDJuuzPlu4sNxfqirX/o9UN9ckYaAaiXC/sZt1waot6azk5M689cKrPfU4QsFfdxYBNlYRvouW3MOTMfODYmqmQln8nughS9UpVfII1SeQMMske9LBcWfeffBeMG0Jf6V+dFvmg9BpFbM7BM5R1sWO6KIYNfvKSbZNH3D09uFdXtzXpc6DAYVJlwdZZ3BrYnoF5BPYVsCWLxWtx7GlXUYIvFHVhVyiIPgiv7Yh3w+Ezanp2zXXvBlkOMZw85W2z5pDtaA3U7y5YsWxsZbexfFzOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUZNbyZRlBbymwatGJu2HZPjoG4/Ewa+ilU8rkug61E=;
 b=KlCILXT1Oy1IfzNsxvTsohetdAAW8A5fVfFRZ34kH75U4Nk0oV3mQvjDnX+0pv/o2g9wKyNTUGU1+EDwqopCVXwCLAKG++tNdCqCw4YJSiBNeNZasu8Rcsnzv5O42bHc2B4bnkz80cUQLz198dB2Ca6SYJP0Wm2eual6bVCA+I85IOOy2KOeuhqLjqdB6jHHCGDSbMqNHx1JhdfSlvYGbW0X+jQQh3PG6btMQKSmQefXwOfYAo0kZP1UcpTh/V4WCrK1QfturHgn+soecjKy6kgKWY/jKL6nz398o/3/vh17HtASYqVozpVi9f3zGe81xm2eR4Bu+uKghftTWxziSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYSPR04MB8320.apcprd04.prod.outlook.com (2603:1096:405:c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 06:37:33 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 06:37:32 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Eric Sandeen <sandeen@sandeen.net>, Noah <kernel-org-10@maxgrass.eu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
CC: sj1557seo <sj1557.seo@samsung.com>,
        "linkinjeon@kernel.org"
	<linkinjeon@kernel.org>
Subject: RE: [PATCH] exfat: short-circuit zero-byte writes in
 exfat_file_write_iter
Thread-Topic: [PATCH] exfat: short-circuit zero-byte writes in
 exfat_file_write_iter
Thread-Index: AQHbfMGTsrgkM4EYaUiW8j7C+YeQBLNDNQHA
Date: Wed, 12 Feb 2025 06:37:32 +0000
Message-ID:
 <PUZPR04MB6316C15A42D10DFEC3F2F46181FC2@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <bug-219746-228826@https.bugzilla.kernel.org/>
 <bug-219746-228826-lg3LNttcRh@https.bugzilla.kernel.org/>
 <194cd33028e.d4f0541717222.3605915477419792562@maxgrass.eu>
 <PUZPR04MB631698672680CB6AC1529C0F81F62@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <7d880675-4aba-4081-84af-1cbacaef17ab@sandeen.net>
In-Reply-To: <7d880675-4aba-4081-84af-1cbacaef17ab@sandeen.net>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYSPR04MB8320:EE_
x-ms-office365-filtering-correlation-id: 0d9760d3-9f31-4c4a-54a3-08dd4b2fbaf9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dkJCNDR5UXczZkpPYzZnMXdnb3FhMk5VZGhXeWppSGdMMWlmVWVrYmlXeDgz?=
 =?utf-8?B?RG1BQlE0TGhoQ3puWnlnajQxTlNmRDJpR2F0L3pHNFVUanlpMWZUWnZHMEZH?=
 =?utf-8?B?bUNVcjNqWTBWTWpLdVNNT2t2RjE1NTRJYWJlY3NNS0RwV0ROY3ZiVTUrRURx?=
 =?utf-8?B?aFJ3MnBNM3NLeUw4U3BUU0JpVWNPTjdNR0U2YXVjWDM4em9MY04wakJmbmtq?=
 =?utf-8?B?Qml6SExoOGRmTmtwRU5NYWZNbFZiNXN3WGhXWjZCVWRrK3ptZFQ4dXRwME0w?=
 =?utf-8?B?WHh2ekNiRXI3K0lWY3ZOVWpkS3ZoUDd5MUk4ZVBpeStjRzVyVVA2SmQ5WDhi?=
 =?utf-8?B?MU1TZDYyclAxMm0rZjRWL3JmL1RDc0FObG5tN0NTRFl1NS9hVDJrS3VkRDRZ?=
 =?utf-8?B?LzFkOERwV0xOaUxmT3AwTXNWaUVySXFRN0tuelRyM1MxK29ySk1pVmhndzQw?=
 =?utf-8?B?c1l3RVBNalRjVXRTTUFFZDNwYU5IRURKRFhpZlpDVEJRQmx4QlNCMjVOTjlE?=
 =?utf-8?B?Q05XeHhSaGVWZGpMTE5ieXpkRnZYK1JIeE5YRUVyR2NHQ1UvTkhjWmRrTGxQ?=
 =?utf-8?B?ZW54RDZxZkdYaWt5RUFhZk82RjhGNTY1Rmo3WUZxeWJUQUZERWJqU2tKcHox?=
 =?utf-8?B?TVlOSlA1Q0tDWmhZazF3VytNeXRFZ2NYZmsvVGY2dGY0SThsYmlubWg5KzRa?=
 =?utf-8?B?WWgvNzZGaVdkOGtlcnRlTEVkN3JOLzljaXoraWpWdlZieTFFMXZvVmVxQlQr?=
 =?utf-8?B?Y1JXbEhmdGJDVmRtdEpEdEdzZm5DUDFtUVBzdWkzQXlSTkN3cFQ5bW5KUklu?=
 =?utf-8?B?dC80Q3NYL01ncE9LNkMyR1o4bzcyR0xlTUppTGdLeWc2azR3anI3VngrUE5t?=
 =?utf-8?B?aGRaS1RJM1ByVHR3Kzc4bFdVMkE4L2NoNnVFdkw0NHZDVFZpYVZKbmYzK281?=
 =?utf-8?B?NHJGY2tyTXVqU1J3M0FhdEcwYlpHNGRobWoyU0liOExaOE81OTVlSnJsZ3FP?=
 =?utf-8?B?TU9hc0c4eWx3cXJxaG5WekUrbHBQSVczWnIwVVZITmM1NTlpTGkxcWtyNFRy?=
 =?utf-8?B?bEtLNW9wMVFYNDRibGpUUHFLaW9qd1dhSUpocklsQllNQ3IvOWJBeTZXYjV1?=
 =?utf-8?B?QTVmRWdvSWd5U2hSUVdQVE5TNWgrQWxoajVmSlgvSUV4dDVZNWFORlJSV1Jx?=
 =?utf-8?B?c0ZXU0dCMHNHM0dFdVdIdkRyOVZHd2VvMkNZU3hwMVZBc0tWYW1rRkd4cGpV?=
 =?utf-8?B?aHhFZzNtbzhwdXJiRUtlYUhPeHJ2N29sWlpQZ2s5YlVFWGVzdlNXVUNSc29M?=
 =?utf-8?B?N1FKOXpFc2Q2Y3ZhTS9DWFNTd1I0RWtFaWxiSTNmSThQelZ3OFV3bU80dlRt?=
 =?utf-8?B?T1k0eG5JdmJoZGZod0xlTWVNUFBySVowbVBZWE1Ja1M0RVAyMFRFcFVOTWNB?=
 =?utf-8?B?amdUU1N3amZlcTRvaHBPTXFDSWJ0VE90dUJlS1BWRU1MOUNsNXlnZnNnVVc0?=
 =?utf-8?B?b3ZRM3RhbkxWdXBjVEwvcW1ac20zSXFuN0RGV0F4ckpETEpmRWs0TEpwRkdQ?=
 =?utf-8?B?NncvOE0xSktmK3dINlBXZ2tJU0QxQ05QTHZxMFJZc3ZzaDFWM2hFMTJiT01t?=
 =?utf-8?B?bTVNK3V1V3pLME9xWkQ2ejVqajYwNTZUbW1JV1pmdUI1Y1ByVmRUVXpaM051?=
 =?utf-8?B?eUJsR1FiUHJTU2RoZ2NlOUppWkVvdkczZHUvWUdoamJzK3BZb2NsZEV4Z1Y0?=
 =?utf-8?B?QUNwUi9oemVJMjNVUnQ0T1hpZldZbmtYcC8zN1pJTkRxcGoyU0VNY3AvQldy?=
 =?utf-8?B?TWd5bG5XT3hWcmkwME5JR1BuWXNSOW9RdnVKdXcvSGVheHltSHc4U0tEaDMw?=
 =?utf-8?B?aXVveFdYbEYweFFvQ2dsdk52MHZxYlBJUmZLeWIwZDMyaldFYitoM05OVWd1?=
 =?utf-8?Q?Srre9nLTuvBtHNE1OuDut5k7cQUvoKzW?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Kys0YTlWNEdxSzhJWDNtcEJpdGpOalRvaXcvZy9YNzM3dGJMUUc0NzI0U21U?=
 =?utf-8?B?dFJ1N1FnbnppaWhZanVkZnhXQk9Tell2RkEvNFhRMmo2WXRFbWhIaStvZ2N6?=
 =?utf-8?B?b3dBdGIxSTNiNFcvaGpJVWt5alhtZUNvQ2NIeWNtNmg1YzZJZ0txS3FWRGNl?=
 =?utf-8?B?TFhUejhoVGtrVXNsWFpabVhZeDVIYkExZThnMzQxRjRzNDh1NXBtNDF6aEgw?=
 =?utf-8?B?eGdxNWl3NlFBdlE0eFRJNDNGcTdkWUxWdTdqcG4rNkhtdGM2cE1QSVEyRHhq?=
 =?utf-8?B?RVlYbDlzem0vdDhzWmUyZzlTU0lrYmFsVHJoUnR0bTVJcWh6b0FYUU1MUmdo?=
 =?utf-8?B?MGErSzhuQmwvalFZYUEzbWNZMXkzNXFERk5OT05BWVFrUnhQLzNIN0lxblpI?=
 =?utf-8?B?a2cyS0Y1SjJLTzRMR2lrWmZTcGZiT09vbDFYaThoc0M2TGt5M2s5dmdyNW5B?=
 =?utf-8?B?TlVacU1MMzNyeXdQNHRIWUI4VnFHeUJtVjBqYzNGTkRUUVhnVExtVWlYeVZa?=
 =?utf-8?B?ZE5oc3lBMi8yUkxPMXZJYmh6UWVNWTVHM2hjSWxheUtRdGlYQUVlVnJYSmhL?=
 =?utf-8?B?ZnJtZ05FcUhVZHhHSUdZU2ZtN2JGa3F2ZnVZY0Vqa0pDOFk2VCtkUjV1MTBD?=
 =?utf-8?B?WklLVUFoZVlKM2VTdDZJakkreXFrOFc4cmppZzJ1b1dBMHVJeTVzUWc3Q2J0?=
 =?utf-8?B?RWtQdmtJQ1BjR0k1WFFhSEtHUktHbCtKV2VENDZEbi9LUkxKMnVxTTNVUjZo?=
 =?utf-8?B?QUhqZ3NKTlM4V0lwNmNkSjJudStIeTR0dmFqWXNEOXh4Wm84NzZ0TW1aU0FU?=
 =?utf-8?B?Q3UvckJELy9WZmlCamdqbEEvbEg1N2NhRHFodklzK3hyYzdDYWRhbFA5N2Z2?=
 =?utf-8?B?R0pyNzN2UWo2MUo5cDdYMndkYktBYnVnY1lEZWhZNVZPcjlmdllkWjc1YWRy?=
 =?utf-8?B?VVhVY0tGVVJEY3ZxQ2JNM1pwVHdrRmxHRS9vdnoxWTB3YTkyK1hJV2ZvcE9M?=
 =?utf-8?B?M0Z5dXVoMUtPRVMwK0FsUExmVDJVRVp4LzlOQzZORXo3dWYvcFN5ZWRseDRU?=
 =?utf-8?B?elNJUHI3clU3amluUkFEZXl1VlJkbndwZU9Oemp4R0N3OXpVZmNsYzZoc01Y?=
 =?utf-8?B?RWoyZkhHc2pjZ3BmT1I3eUl5NEpEODcveElSZUhYU2NCTkkxdmhzdWROSjRO?=
 =?utf-8?B?WXBVYmlzQ2tVNjlOM3FIbkV5d0tyWFA3L2F6T1ExR1BOQ0pCbUpUc0pVY3V5?=
 =?utf-8?B?cVY1R0ZHNEw0S1JuTGdSUjlHbmJPc0gvem5XelNlVkxleHJlOXp0MnNCT3gv?=
 =?utf-8?B?cW8yQjZ2WDM3NmVhT2kzZnpPSFRiTi9lR2I5VmpVVzBiaTVSV0NHWk4vV2NM?=
 =?utf-8?B?VHdGVHllblJ4bWFmL1FJbXl3S2M3T0RrS1NuRUdtQWNoY0txZ2VaWjVuSHJt?=
 =?utf-8?B?M3VkTW9tTDlnNUxnUVhEMWJ3aHJRYjlrb3BaR3V6ZDVoeGZLT0ZiR01BdGM4?=
 =?utf-8?B?bmFMdlJlL0hFcmpXRWxTeC9vOVU2NmVTNi9GZDJrZmc4enBpU3lqR0V6UlRt?=
 =?utf-8?B?cGVHc3lSbERQNDVVajZTS25JZTFVM2VGdVZuZkxVdVhxSDNuRm1xTkE2RWg1?=
 =?utf-8?B?WUhmemVZZGw3Zmk4TEJGMEQ4V05CckFIM05xeGJnOEJNdXdQd29NT2FRb2ht?=
 =?utf-8?B?RTY4dGdJN0VLeWE4UHAzUEJGT0IrbENTd3Z2b1ZWdGV5azBFeHl5Z3RBRzFz?=
 =?utf-8?B?c0ZmOUtCeFVkSUloVlNmaDg5VEE5aG1peldKN28zcHZmRm5MSWVjbTRienov?=
 =?utf-8?B?R1BENzhLUkRuN1crbkhjR1ZDNjAveGZvcTJwVWIzL1VXT0ZPYW8raUJLZkxt?=
 =?utf-8?B?UHQ5SnYxSGlmOGxHT2M2MW5zcDBTSFI3ZXE2OHVVUjIyeEtwV2pKQjNONnY1?=
 =?utf-8?B?c0ZFYWt0WDJ4cjRGdS9leVBuaUZYeGhaWW0xTHRLdHkyT3ZXcER5Vm5FWGpu?=
 =?utf-8?B?alk5UFJidExPTXVMSkVkVG9QUzd4SzNJWmVHeWp1QWtiY2JtM1lERU5BRmtP?=
 =?utf-8?B?VmNPOVBFN3prQ1QvNjNZOVAzbVB2dzF1MlF6UUNMbHZEd1QxakVJV2hOeHRs?=
 =?utf-8?Q?Qwfg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cDGuC5aIfwQuJxJNBjmqUxiMfUGQ8eGOmxvm/a/z+seKAM5cvZKg3l8rT0qEYnSiVu6Gsa04rCOZm2UmyEXHSxIQCmSw97/hLQRhTWHgmTwsFSZsehduwxo7mj+ooX8rspTShZjiMuijv4qDaMuuDi4kABySpVukas5f4EG4dCY6NZZXYZnrWHUGaFj7vUqwHdGE8qtM0AHZpBGemOVgopjPNmskRgH/5GcBn012SHY22Q0BTT65W4GyiuaPc6s92E9vCHA8z9xW6j3azWL0UHAJs628sXbM1JRiI0xlEi0KLKFZu7KDxQhffqTSVNEbNfiGN+lWP6sRshv6lEgT6PFnLW6VIoJqO1h9VH8rlpqB8l3Xhmif/cJOHrBss3evNEcJq3WAOqFjMlY+7SSpDO4CmeEYoP7sc0EpdXfw0xKA9lDlOQWfDkw1JZp6kTvjVbNZYgFKez8LV4VSl/OvuUvwzIQvXE90FceWh85fdn34leeFKLbAsv3xRwmFtZpzFd+2/OdyGN/t+CSgo6rvgJ9zIZF5/+DT537uTdxCdthxfFqjhI9VAgPVSoxnTWiFRrYDalyLgp95LiG4Id00YZRLlu/F46JaO7hUGtDg+ySpzC9nwFuXs89D3S5d65n4
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9760d3-9f31-4c4a-54a3-08dd4b2fbaf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 06:37:32.8347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZDP3R890SXppQUWCgibjfLKZpNSSc1sIYImR6aqUOJwNRXIaSKVta22Ru7Lr9yeDmkhwJ0ouE+k4eR4ISLMwwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB8320
X-Proofpoint-GUID: 5Li6iIqwXsmOmURLKAGkMcFHdumr3w1a
X-Proofpoint-ORIG-GUID: 5Li6iIqwXsmOmURLKAGkMcFHdumr3w1a
X-Sony-Outbound-GUID: 5Li6iIqwXsmOmURLKAGkMcFHdumr3w1a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_02,2025-02-11_01,2024-11-22_01

UGxlYXNlIGFkZCB0aGUgIkZpeGVzIiB0YWcuDQoNCkZpeGVzOiAxMWEzNDdmYjZjZWYgKCJleGZh
dDogY2hhbmdlIHRvIGdldCBmaWxlIHNpemUgZnJvbSBEYXRhTGVuZ3RoIikNCg==

