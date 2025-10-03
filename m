Return-Path: <linux-fsdevel+bounces-63410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E38BB83B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 23:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74AFF19E1923
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 21:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D562701D8;
	Fri,  3 Oct 2025 21:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pzfoKx7G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61823227EA4;
	Fri,  3 Oct 2025 21:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759528060; cv=fail; b=ZwvFuFdRtu55It5uJaDBMap6hcFH0FWon9XM5zbDRW36dIXi7IIRFsee30xBZy0B0C1csNZQIp/NQDr8kUSJ89R3VEKgHtXmF16Lcsk5yRlub4JUtffAIjExZjHLASOsOr1l+2fkP5KDu/tByw8VHxvasQm560no8XQCb9OrTyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759528060; c=relaxed/simple;
	bh=XwDio7IQKqwsTgMKGV9iSybafGhzpp+BqyF5YV6MjNo=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=q5XTUTaMxOq/5p7CMv8kcm8IdpB7uJWjTNUrNLnvacoIuaa+3hAuTbDpMRc6NdS3jUj0/ksxn8iVEMYZotgMkYJDd+0uL7sPIZbduvZEP6/9myC9l5bj0oyMUVdBU/nWoU/HAqZYiVeEPNRIYfsDh/+spKk9PcWeUlKKFHbUtzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pzfoKx7G; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593C9WAH008419;
	Fri, 3 Oct 2025 21:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=XwDio7IQKqwsTgMKGV9iSybafGhzpp+BqyF5YV6MjNo=; b=pzfoKx7G
	NyZhUONzOhQy1MPVVaJs5dT2fIyGqz+mAyTbLkcSYvJQamDR5s2wY7fkwUDWpT1E
	/BXsw1ns0YDRNVKb2gFScjkSQBkqteKrFh8CArJTLb36TmVdFj4r65oQEj50FKsx
	mR+jHDJbtrkA6yxk0ldCJN8nfhj8qIUBfDg3GpHND4FErzXJSCZaIseXI7m0dx7k
	xnG8m5itG8+2ao48Y2QapyfcgnhdyPVNfVmbjyDBXxudWJJ6buwopk38uZyT5MXV
	uZWN1vifMFrKoPvsqN0ypB+SMFOYIIgiT4phHjHWcX+HMeQE5lcXBVmstOiMuEAc
	iiBUx+CFFj47WQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010009.outbound.protection.outlook.com [40.93.198.9])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7kuwyd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Oct 2025 21:47:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCjphoLOQGWxtaXd0zGIEW5uG26YOP34kreqW5n8vA9NEfm+jcKIQ1dl10wfp2CHRcS0MtpFpD7bhyaIZGxPraWJ9XwX6HIWHwLR3gdPRNO/gM0RMFkPeGZltINp68ATXsk/LWDLMsDUOfFZQuuTMzJ+gxHrUqvQR+EBEg0PfyMFdGbw0ES2FaEwJlurdkt1L2JyFREyKdtAwtXOtJ0BydS3A2N7KJkQQnA3TfXtRbrRkTSzdXBNDEhd8L51xP9Xw3YktPHeZrzMN2eaFnQcP005Xchpm3ZO7xbWzGKGvY4XH3bu8i0V9qyJNrGrldbFU1Ord6z7SAO4RDZImYHjBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwDio7IQKqwsTgMKGV9iSybafGhzpp+BqyF5YV6MjNo=;
 b=LKdXnJ450E0VG41H0VRide7Mr/oMJoLo/A4K3k+EM4cNvUgb7sLah73mVyDUvnv5AWm96dvOwq1TisHYk2yYa6FVtNASgeIVVuzHQLHgBnmV9ZxLrh3LWNldEYry5XhLQ53ey8osB+DmWXuOELAYFNNtj/i/HT2bysAl2RUnmohipNPXaLWMpx23rWabbbsLBCEJQAHItzNPBctYWHwS5YZn0KSRVF7yLtz1STv0GYZ7on5VCu1hJsF46+QpWbntbNgLlGUna6QVC2OdQ6HefY5NvgJJqvp4zRee9QgCJLSziBo+HuqsiqY67qnK9qmJREft4OZRJWGJjtg86W/H+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH7PR15MB5254.namprd15.prod.outlook.com (2603:10b6:510:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 21:47:26 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 21:47:26 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "slava@dubeyko.com" <slava@dubeyko.com>,
        "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] hfs: fix potential use after free in
 hfs_correct_next_unused_CNID()
Thread-Index: AQHcNEh5WMZuRcxMbU6gJmnIr8x26bSw9gwA
Date: Fri, 3 Oct 2025 21:47:26 +0000
Message-ID: <8894cbfbf360890f5f781035a345b0d70d0d3d3c.camel@ibm.com>
References: <aN-Xw8KnbSnuIcLk@stanley.mountain>
In-Reply-To: <aN-Xw8KnbSnuIcLk@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH7PR15MB5254:EE_
x-ms-office365-filtering-correlation-id: ede4079b-dc53-45b3-ea07-08de02c671af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SmJZakxzWVVRUkVpV2NrQjV0eEhiYklpVzFENkVsbzZybjAxWGpjWk9sUTlw?=
 =?utf-8?B?QW5nSXdwRkVxWHpJeEJ4d2lmMmM4WDRwdWFQK0xSRUN3emxXQktsSU05MWY0?=
 =?utf-8?B?ZkZ0TnRqRUxScU9TZGNsa0h0WnFZMFlCK1AvQURSSDQvY3RNOTJGVnRWazc0?=
 =?utf-8?B?TVhrbjNsU1YvMGYzcnd3b2YwYWh1MmhRMlNteGtaMGp2NkdJdmtockg5YUtM?=
 =?utf-8?B?Y0haVklSVEIyNDE3c2FOd3pEQmdzcmxsMlRZVm5RS1VUd3ZBbml3N0YxSXBp?=
 =?utf-8?B?RUlkQ0pmaC9MUU54KzB2bWtrZ044UnpVL0sxVnhSdnE0NFIxWERVK0F0OW9s?=
 =?utf-8?B?aERSWktUK2pRMlk3ditpRU1Zb0xhbDkrc1lDSjRlMThNZ2dUckpRRGtEYTRF?=
 =?utf-8?B?NUhORmdLZHNqNFJKSnNHZU1rTFJlM0VheTgvcTRraEtRU1R6ZFQyalAzaVpv?=
 =?utf-8?B?WkhsZk1YZVJ4aTZOSTVzOUtrcy8rS01adFp4WFFlcjkxamE2Sk9VOElldEFZ?=
 =?utf-8?B?Yml0NHR3cGVMVjJSVHIxN3JEV21qWGh0Q21BT2hVR3QwTXpNMUxNakNLTGRJ?=
 =?utf-8?B?VnZURldoN2k2Y1NZYS9mYU5NZXpsUzVkUzNiRGh1TFE1OHdIVXNlSktkeFd2?=
 =?utf-8?B?cEhKREJlZHBTUDRZdysvRWRPTTRwUjI5Yko3UWY2WmowaEhPcXByQ01SRGVl?=
 =?utf-8?B?a1BQdWR2aGpEeHlNQjN4U2V6NE8xTHRmUFZwMlRXS1NRSFZ1SWJUMjJNV0pr?=
 =?utf-8?B?a0xDbnlJRUFiQUN3dkxWajE3c0ZYa2JnTG4rSHJOVHJOMjVtYWlPWk5mbjJm?=
 =?utf-8?B?cmcyV1VsSGV1OTVXQmN2dzFjdEdXbGtHVWRqOTdIV1ZwOWFKMjRqcmFJOEJX?=
 =?utf-8?B?Q3A0dlNPY0dnUWpBd1Zya0l2dnBhYTd5Z3hCR2djVEY3QmRra3o2ZWZ4eTQw?=
 =?utf-8?B?Q0llMUtteDVMcmxRdjd3cVNWQ1REYWZkZ0pEb215RnZ6by9kaklrMzVUK1hN?=
 =?utf-8?B?eUxSa0Q0ZUZPS21OTEVUdWFVRjZGYzdqbVd6UjF1bW5uMkRGMDZEQlBjdlF1?=
 =?utf-8?B?dkFOY3VRcGxINENZaDJoRkpOeTk5VjhoV0RHM2hwRXZxdUNMMGlBZjVyMENB?=
 =?utf-8?B?YWhXSjJHSmpqOWpwOFF3N0UxQjlVY0hNWklRSFpvcTZWVmI1ejI1cURjT0pZ?=
 =?utf-8?B?Q0g3QzQ4YUdJT3Y4NkRkY3Q0NU9ldmhMQSt4RnFnZDNZazJrVklHNENIbFFF?=
 =?utf-8?B?S0tHd1hhYWJhbWZzcVNjcjhTR3luMGhpZ1FMYkw2UmJwbks2STE2cFY2VVJp?=
 =?utf-8?B?UEZZbi9xWTBvVG5hMC85d0RVUXNpbmVVankwZkV4TkhTeVErZzFpanM0OUZ0?=
 =?utf-8?B?Vkd0dFlhZ21DdEZrTkhoSW5qRW1jbGN5WG9tL1Y2bDQ3OGduSUhuRUVyL3A2?=
 =?utf-8?B?MERUVmNGeVNmSDA2ZmpnSGsrRXJydklHZWZ1SncyUWZmcXJUWllvajlWckZY?=
 =?utf-8?B?Zzk1emlzT1BVa0h5SW5QYkpWZWd0ZzNFODNDSC91cWpsSmpiYzhlcjRJVWNy?=
 =?utf-8?B?cHlrSEFwcTJ4Q3lYQVlNZXR5KzB6NTF3U2RBaitjTHR5UGJqODFyeDZqOUZP?=
 =?utf-8?B?bUY4c1VnN1pqbDY4b3IyU2hjaUVwVjY2RDgzVUJZY0hSNFY3T1BwK2o3Ry9B?=
 =?utf-8?B?ZVc4b1dzTzhTU3ZGL1dzRkMrem16ZEFoM1lTRjVYa0RnL1FNY3lkTGhCYThm?=
 =?utf-8?B?SDJ4Vml3WHZ1Nk9mMVBVUHFqdGJTaGxxRDdNcUtIbktnYzRERThEOEpwdVJO?=
 =?utf-8?B?NnRhYm5samR0K1JrWHZvSUgxd2l2azFLazBpbGsrN1VQL0laYndBUGtYZHFn?=
 =?utf-8?B?Q1pEU0ZwMUFZazF1aGUrYk9GMXpNcHZraGZBTmVCVytmZ0V3a2ZRak01K2Fx?=
 =?utf-8?B?dm5BZ2NLWXJZeWtqRnBucHU1cVJwc0ZrcDYxcFBRK2VmOHQ2cXFLUk1qS280?=
 =?utf-8?B?U2k4TWlHSG13bXBnRzgrc1ZabGpYNkJEL2lmRVU1Z2RWYUhRTXVnWlhKR0pL?=
 =?utf-8?Q?TrU2G5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VVVmSWhlYnlCOHBRVDJ5QUN3amVxby9DL3cyRjBsc1E1dGduRGlvazB2bGdP?=
 =?utf-8?B?dVE2WEwwYlhuYVBMcit5SURqWlFTWXNzMlJiVTNxVER4ajliTG9oODBUK3hQ?=
 =?utf-8?B?SW9ERVV4bndZVVp1cUxrUEx0d3VHN2xEY2VVZzROSENTbnF5VFc0Zk9NUkdk?=
 =?utf-8?B?UGtRdm5wYkhuTVM1dG95bE9lYjVrYTdJOUtmb0dUNDUzb2F1V2YyNy92OXJ0?=
 =?utf-8?B?WWhQRnFSYURoQjBnOFo1NGI5cGN2RkNJanB2NkFqdzBDNmFzMXI2OVNqbEZK?=
 =?utf-8?B?a2NQUkQ2V1dMWXh4bVdzZk0vSmJFcmVDbFIwdS8vYTgycVpSangxM2lsWmRH?=
 =?utf-8?B?a1ZOWDRYTG5vaG90K0I3ZnZIaFVoVE5BZHR3eGFoSUFLd0srNnUzTGRxVXh6?=
 =?utf-8?B?VWFYekFTYkJJS1ZIQWxmUGxzZTQ2cjNiZzdFOFV2S2M2dFhPVDVpQndqZi9X?=
 =?utf-8?B?MUlWdU01OFI1eVVkQ25DVkJZWTV3UGVKNk10QnkzamRXRUNQbFp3cDdud1k3?=
 =?utf-8?B?Qmx1YmtNempFZGJuMnZpa09jSy9iTHgzMEI1NHpiQTV0Qi85UnBGak4xdS9u?=
 =?utf-8?B?TGNsb0ZOQnZqSW1kRFNrcVJ6aEVQbkdrTE5SeFpkNUJJUlhHQzBnNVpCT2FK?=
 =?utf-8?B?MG9ZdmRISGJIbUNXQnpyUHBEYXI2bzFheVlMM3kzZ2h2dVdOYzBDMUZSQ24y?=
 =?utf-8?B?NFdOWUFPYWhaU0Z5N0ZrVkIvZUxNNjJDc05YSTl5TEtMNzFCTkU0NE9nZXNr?=
 =?utf-8?B?TUkza0dXK2VEdkZRbjBEUGlINWp2OUVZajhSL1duTEpjT2tpRkxNQ0FtYWVD?=
 =?utf-8?B?L1lmOExUVk5zYVpvVUg0UVNMSGtMK1ltRkp0L3p5RUtDVVhwUFhQYTJ1Z1Nz?=
 =?utf-8?B?bTZVOSs3M1FUMnluZU9CSHV6b25wSkNLaEFESzhaM0NiNjFEV1U4YThaZzVN?=
 =?utf-8?B?REMvb1E4ZGFQWVRUK2c1MFVwSVFmbUozNkVodzdySDN6eVhnbzBLU0FFTytQ?=
 =?utf-8?B?NGFYVTZkZ0FqKzhDL3MzU0EvVUpVV0pVVUluRzlkdFdGQWZRWnJMRnRFdHdY?=
 =?utf-8?B?bWxCZzU4eEF0K1RVcjYxS1lENkFEK0ptdHpwUFY3VG9SUnJOMXp3akx2TkZr?=
 =?utf-8?B?WnFMMkppdUhsdmtFWDNTNzNjVzhrMVdVeGNOTEZuYmVlSTB6UEkrallQTUpE?=
 =?utf-8?B?TDF5WmdXZGFGQnB4eVV0ZENaQkxSdXhuZXpnZnI4Ris3bW9TLy9lWDlGcnY5?=
 =?utf-8?B?NEQ5TkdWN1g4M1BpSG03SWVLRGlUM3JzcU9vUHJRT09KSkxsWWNmdysyNHFr?=
 =?utf-8?B?UTlkcTdDUm1rVnFQQy9nL0F1Y3E5OUxhRUQ0eWNrdnVpY0RjZTZWdThmM0Uw?=
 =?utf-8?B?YzBNL3ZBMno5MVIwakxsUmZaVzIrMm1sN0xocUQyUE01UTg4Y3VlM296YUVu?=
 =?utf-8?B?ekkrZDlGdE1RZTA5TDQyNlMxMXB1TWJNck5VNndaRmljNTF0MFExeFoxeTdj?=
 =?utf-8?B?ZEpWOEg0RHN5VW0yRXhKNmhzK3ZpajdSMjNEMWZwaXpHSzl0TTVsdE5Qc3dI?=
 =?utf-8?B?ZVdIMTlBM0xCSDlJNWthQis4QXdvTWpoVDY4aHk0UHRGYkk3dVNrRW54UWhK?=
 =?utf-8?B?SEV4MVJqK1cwZFlkckpZTWg5N3pZRFVQYnVMUjB3WWFkSFBYQnJ1UkZrT1ZH?=
 =?utf-8?B?U1RaNUU5aWUzdVVVZlU3YWZQbmlzdE41cXEzL2lpNmNoSkJtYTdlQkNEZFFU?=
 =?utf-8?B?Nk9xWElWZHloNno1SExEQ29xUFBRQ0NYa0tLU09UeUw5NGlabHZjVXlkZGFv?=
 =?utf-8?B?VWU5V3BYTFJ6aG1WZjhaMkFWZHpkSzk4SUYzYkI2bkxlcE93Q2ljYTNVWVB3?=
 =?utf-8?B?N1BlWWVOaXVBU2s1aDVsQmNJNmZLOWJ4M0wwTXJ4MkNITGhTVW5qZkRzazlD?=
 =?utf-8?B?Q3BLRTVvZWlDOWkyYzdVbGMrQmxob1BlMmg2MWowYThQT1U3K1BqZDdkMUc2?=
 =?utf-8?B?b093d0EzQlRocU9sR3FnTWZrdDJjTlFzMGFiZzk5TlVUMVNDcnJjNDVFNVBj?=
 =?utf-8?B?a25YWHd2cVZPSm56RHg5SzNtdk9OektoN0pkcjdCbXppZDhLY0Y5MzRVaW5z?=
 =?utf-8?B?bVNOdEFjalBJTldNMlRyNlJSbVBwYlNvb3VaTng4bEN1Y3diKzJteWhZTS9u?=
 =?utf-8?Q?4yYXpggPetnau4rr81ao6uU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52561E894F8E864DA27725389705D701@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ede4079b-dc53-45b3-ea07-08de02c671af
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 21:47:26.7277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cb/Xeq1NNbtUfzwrkfJj+BARL1xsMLw8onBA4uFJgrNtJ+uZSekeQXnH25hX8sm8pFicoYFZ+KY+k8P2lUrIJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5254
X-Authority-Analysis: v=2.4 cv=T7WBjvKQ c=1 sm=1 tr=0 ts=68e04475 cx=c_pps
 a=MYJxclL+TLfs1lE1Gew55Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=wCmvBT1CAAAA:8 a=F6dgG8FqWAxxCrQzhewA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=6z96SAwNL0f8klobD5od:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: QyhM7bTqXyp1VGIkEIIaOCkIpRq9JxW6
X-Proofpoint-ORIG-GUID: QyhM7bTqXyp1VGIkEIIaOCkIpRq9JxW6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX29Xt0MgyNF1M
 Jjx2D2S0xKhyNw4RxRIbwfEH4ppEZ9rt/9X+WajcwGMTUmWwAanHagmuKbNGLQsrT9zFFvwWva5
 SrrIBT0pNtnaJjHw4QjbhmGb7CHNfqgy/Ynde7WhpGQ62x2MRO5b4014zzePpmNU6das3T2h3qh
 FoPOQcK/ug0j05wlG3o7k/fwYDh40dioSrx6B/7Kbnofl+uXkVFQ6i2HSsDeDleHzWuqWvS+BfK
 vRBEHNmmHYqw/noXoD9T4bitkfL/P8Q1qObvK9zftVAtr033Sr8jp3J9rpS1z1KBfbrhgLTmooW
 qC4t1ArzjPv4M6enD6KUoOiusGsJOxSST/sNV7GgJGeGnqO2MK39HRSrPEiU+6CdMBEEcae3ifG
 sy3YT/N+Ei4PzZdPiGUel2x+gvoeKw==
Subject: Re:  [PATCH] hfs: fix potential use after free in
 hfs_correct_next_unused_CNID()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025

T24gRnJpLCAyMDI1LTEwLTAzIGF0IDEyOjMwICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0K
PiBUaGlzIGNvZGUgY2FsbHMgaGZzX2Jub2RlX3B1dChub2RlKSB3aGljaCBkcm9wcyB0aGUgcmVm
Y291bnQgYW5kIHRoZW4NCj4gZHJlZmVyZW5jZXMgIm5vZGUiIG9uIHRoZSBuZXh0IGxpbmUuICBJ
dCdzIG9ubHkgc2FmZSB0byB1c2UgIm5vZGUiDQo+IHdoZW4gd2UncmUgaG9sZGluZyBhIHJlZmVy
ZW5jZSBzbyBmbGlwIHRoZXNlIHR3byBsaW5lcyBhcm91bmQuDQo+IA0KPiBGaXhlczogYTA2ZWMy
ODNlMTI1ICgiaGZzOiBhZGQgbG9naWMgb2YgY29ycmVjdGluZyBhIG5leHQgdW51c2VkIENOSUQi
KQ0KPiBTaWduZWQtb2ZmLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQGxpbmFyby5v
cmc+DQo+IC0tLQ0KPiAgZnMvaGZzL2NhdGFsb2cuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2hm
cy9jYXRhbG9nLmMgYi9mcy9oZnMvY2F0YWxvZy5jDQo+IGluZGV4IGNhZWJhYmI2NjQyZi4uYjgw
YmE0MGUzODc3IDEwMDY0NA0KPiAtLS0gYS9mcy9oZnMvY2F0YWxvZy5jDQo+ICsrKyBiL2ZzL2hm
cy9jYXRhbG9nLmMNCj4gQEAgLTMyMiw5ICszMjIsOSBAQCBpbnQgaGZzX2NvcnJlY3RfbmV4dF91
bnVzZWRfQ05JRChzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCB1MzIgY25pZCkNCj4gIAkJCX0NCj4g
IAkJfQ0KPiAgDQo+ICsJCW5vZGVfaWQgPSBub2RlLT5wcmV2Ow0KPiAgCQloZnNfYm5vZGVfcHV0
KG5vZGUpOw0KPiAgDQo+IC0JCW5vZGVfaWQgPSBub2RlLT5wcmV2Ow0KPiAgCX0gd2hpbGUgKG5v
ZGVfaWQgPj0gbGVhZl9oZWFkKTsNCj4gIA0KPiAgCXJldHVybiAtRU5PRU5UOw0KDQpZZWFoLCBt
YWtlcyBzZW5zZS4gR29vZCBjYXRjaC4gOikgSSBtaXNzZWQgdGhpcy4gVGhhbmtzIGEgbG90IGZv
ciB0aGUgZml4Lg0KDQpSZXZpZXdlZC1ieTogVmlhY2hlc2xhdiBEdWJleWtvIDxzbGF2YUBkdWJl
eWtvLmNvbT4NCg0KVGhhbmtzLA0KU2xhdmEuDQo=

