Return-Path: <linux-fsdevel+bounces-35054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 799629D07B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 03:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39EEC281B65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 02:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5442D1E511;
	Mon, 18 Nov 2024 02:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="W5NF0ly9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33C41803A
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 02:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731895347; cv=fail; b=j53DHQpM2kZZx9ghhlB18RTqOExVTCabmUsaB1pNxii7SzF8FSll1ACIJN5cbGt8Zqwfhc61wmSzjihY+a7dqzueSZoz11Da9duxFHbFyoiFeSW4+K9kf+75jkQK8uW+V2D7z7cWlL4+fS05lIl/VE/uNaXaRWKr6d3XpZElKT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731895347; c=relaxed/simple;
	bh=PLl8M25aSQDsAJlAl4lHTZn3I21AGUq3A9ToxY+xuO0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=p2EutrZaVB9DA1KLBqd81xVRGe7L2rVxReMMWBui8HlGD+b8nrzuU58QOqTXmsU7BeawDU7/P5VNwGfGUB2BjMQIHHNMcsnStTau+byfW2rNFExkJFokl/hbHf0iHlj+pB8eunt8aVWsU30pE+F2TCahSnCqyKUGcAv4hC1rlA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=W5NF0ly9; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI0eEUX023960;
	Mon, 18 Nov 2024 02:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=PLl8M25aSQDsAJlAl4lHTZn3I21AG
	Uq3A9ToxY+xuO0=; b=W5NF0ly9g1UmuuUC28En09LsPC2OX6otb+BjQgscQLxCZ
	0VCbRIaniXMj5GnVaaT1XsWzpovzMQqpdwFvQXcYX9Z2rpwhD16Ah1dAmS3iuWqm
	jkFyk/gB+hjD4wvWH7TjhAO85wdv9ajJDN6uOiSPnWofQUaGZy5WKZbaBfH/H9qu
	BsvcJVl94ustywYaSXIp1EqIFsi5lauBmUzdPyzuH1NC5cnoA/ZInjgkluZMDbNK
	y3CFia1uyL0RQuE8gOSCuoXnpWOJeruZTi2yefCQVhCgmXw3FAW23RchsEepelQw
	YadvqJwX6fy+WbNIeelExBajecPVX/KEGbpRaHyzw==
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2047.outbound.protection.outlook.com [104.47.110.47])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 42xm8xh3t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 02:02:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfU9PPRy4GxJ7LN4rmlWGfyAlpMa2nIFN/uSLj5DH9829r9mrk7Helk9ynP5s0RkuqI/jjKMKZm+MGzP0vMDWixGKIqYVELaVo8G/BzVfJHsXumqNLdLBbRRK0cEw8rqnfyGsVnTgzMYVVdTzzFXX+X0RaiIE9YhVm2PHU1Fn+Qk9PdYQp/0YKrHW5qaSOZLTWhWpZrvvYdtmqhpMPIwld4Xu3qgt/EEp+zu5Qp+mOii7S+BbqFukGeKYyNJn2DMPAWT2NAZFILGlpRbArA2wAYMnZG5nQsxokCVObDeQ55iiPBYAlTZRUbymT3mvgszmeC+o/TGVdR0GKCEnCSp6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLl8M25aSQDsAJlAl4lHTZn3I21AGUq3A9ToxY+xuO0=;
 b=IBykZG9by2UvH8pUNDnQMGRrXbHuQuwEScyXhMDFz15Pr9u5cOXEq6IbpVwbdLQXAoZr5Lh7v9CQiATMi/y9T+6WiBibqZ5q8fKPrxYnhCSkJNHuxYdQU7zDGIzRqbW31equ96/hDienhvQEfyw7FEUlrFjZn5FkCM8C8PINpJjjZYqZRzKuzXhl0rWMHENXRMBR2sKqlncooUuGFgAuJO6PiH5QPxzyEG7PfsNFPXv4uK/5gZNlg8OvsADVQAD/0roK+AO18nJ3T25MYpTfQrOyjAHs0eikFCXRMltIiUwFo3RkPN9Okt3IeJTXOQNgj15Wbq1Mq2TDEQhBUwyh2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB6119.apcprd04.prod.outlook.com (2603:1096:400:258::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 02:02:10 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8158.013; Mon, 18 Nov 2024
 02:02:10 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v3 5/7] exfat: remove argument 'p_dir' from exfat_add_entry()
Thread-Topic: [PATCH v3 5/7] exfat: remove argument 'p_dir' from
 exfat_add_entry()
Thread-Index: AdsAKdCLRxbAMeyARRCBbIFV5KWhHg5MxSfg
Date: Mon, 18 Nov 2024 02:02:10 +0000
Message-ID:
 <PUZPR04MB6316BC8CAA73DA63A4647BD681272@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB6119:EE_
x-ms-office365-filtering-correlation-id: b77cc207-69c8-4ccc-cdc5-08dd07750366
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NjlmcjdlSHBpOGFLYWJCaTFaQU9YMTRjUlNNL0lBMnpxN0RhZHl0bnFkVm9p?=
 =?utf-8?B?aktFZlBMaUZLQmhMQ0lxVzFKaUxOcHJPSmxCdjA4R1dHWHE3YzlYUHZybVdH?=
 =?utf-8?B?bmJYYTVYVFFvdk5HY1JYNXRqNXdERXUrVk1DUS9KSEJXWE9FMXRWanhVTUhI?=
 =?utf-8?B?NVI1TzBtbGhEaTEwN2pLTjM5MjhvOGZNT2NaQkRkYWxnZm52YzNpd0lNNCtj?=
 =?utf-8?B?bWs3NEoxS1ZBM1g1aXdpNzA4ZHB0NlRvd0NhQ0tHb01yNW5KWFZZYytFZU9E?=
 =?utf-8?B?Wk9MVnpwd0c0OXIvT3M5L0F6MTFpSFp5QUlqQlFKN3dzRm93cnVYclZRa2l2?=
 =?utf-8?B?MktIeVN2VWJhUlFUZEJCOGVsSVNlUi9ySjdBMjdaM1hOU2JUelowcW1zTm1E?=
 =?utf-8?B?UDF5SG9sRy9LVUpza2tmdWtlMVkwN0YrWVB0a0VZNW12V0ZFYVRBTUZsakdj?=
 =?utf-8?B?Wlh1SGZGRVNEU2F5Zkg4RGlOL3U1THJMY2x2MDZ6QXJGM0d1bmdIT1IyWDhu?=
 =?utf-8?B?UGZFdCt1b1hWb21FVmRreU5TRGZYUkR3M3AwWEpxZWVuVnVHNG56M3oyR1E5?=
 =?utf-8?B?WnZlNEJ0eHJFWTBVQ29PQVpzNU1RTFYydU5PNU9zNkRxV1Z6UU8zbFJsbXZY?=
 =?utf-8?B?b1ZvWVBNdnVLNVRKeTRBN093T3JlaGd4SGd6M2F1cE1xV1Y2aE9kOGNObkI5?=
 =?utf-8?B?d2NnVkR3Zis5cm5OeEg0VFp5RTQ1SXQ2NDhlTlhtK0lvb0lxc2FoNFZWVWpp?=
 =?utf-8?B?TUMxRy9RZFNwc3dyblE3VVdVRmxuVVRjYW9RVkJaQmM2czI0ZWFtdFFmTEFx?=
 =?utf-8?B?ZzJkRmQ5OVBjZ1VmbWtrVmtjU2xhV2dvZ2dQVUFnenZHK2Y0RlhZR2ZoU0Fz?=
 =?utf-8?B?c0ZCYWRiNzZYM0lsdkE0aExJdjdhdG5CTjlqeHgvQ1lQN1N1UWI2TEFCQUE5?=
 =?utf-8?B?YUpnWTNYOWt2dGhvUFhGejgvbHhkVUoyTmdUcnlDRDFJdUVwMnNWRjRicWIy?=
 =?utf-8?B?bEJxRHIrK090Zk5QV0tvTXYySVJ3R1BtTFpqNzBIMmxSNDVKWjlUaGFuZlF0?=
 =?utf-8?B?a2RnQk5WSDNKRVBXc2Jac3pFbGNkWVlVaDdzK2pvT0hUQ2RuV3A0WDVpMnQw?=
 =?utf-8?B?L0dZdXhjcVBOTHNaNkdMc0g1ZDJTOGlzQkhvSG9wY2FPWFFIY3REQkxzMFVN?=
 =?utf-8?B?cFdkaTdYSUVrRWR0ckt0R3BwdXltV2VsUTNUNGhsR1ZNY0ZOT0UrRTNLNXoz?=
 =?utf-8?B?L0dEWGlVOEZEVU1NZWxUcHByNGRtZ0oyVUZOSStUVllsdk1BVVpjQjJIbE1Y?=
 =?utf-8?B?c1dJTVU0TE03dFVJS2k3S0tIbk1hZzRzakRzNFlLQmF2TGJNVm5YVlZ4dk5y?=
 =?utf-8?B?eE9KTnYwWE03ak8vbTM5cTdVVnZMNGYzN0FPRDlNRk1WMjlqbVg0ZnA3TERm?=
 =?utf-8?B?a20rMStyVHRVcjZoMnlWWmtzV2FjZXlTdVVJL1VrVEU5NXhwVHV3dXNCdGlV?=
 =?utf-8?B?cG9COUNKYlZwUUxWZ3BzWVNuOWU1Sm5UL3FpSUtmSTA1NXdJUmFTMHFZWXdr?=
 =?utf-8?B?ZmhjL0l0R3FlNzhZZHlRRDV6RTJlaFNQNTh1Y2dGRXI3MG1ZTzM4Zm1YdkdS?=
 =?utf-8?B?QS9wdFk0cnBIY0NOTzRWSVNBbDBOc05RT010WEl5RnNwS0lBK0pCWCtCbHg0?=
 =?utf-8?B?Q0FVZTRTRG1Qb21XM1dtQXpvaTdQdnBXT0tKTENmeFFiWFJhS1ZEQ1JZSHRC?=
 =?utf-8?B?eC9FNkxBSndlRFhNQ0dGTm9LRDdMNm9od0R4S2g2MGdkazAwT0V3WUQybjVu?=
 =?utf-8?Q?3NQOpk0UVf687Jjrl/JxqOQYkLyYH3s5Maz7w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dlRWcTBmbjQrdXdXNmVESlhlTmF4bjNpdGd5ckpFRTVoWHBHTGFDbWlCSTY5?=
 =?utf-8?B?c3laMjlyRlIrTURjZWdPYW16Q29yMHFqNHlCZjQ0cGhBOEkxYkJwOGtBY1g3?=
 =?utf-8?B?Ukc0NXhFNVNrRFdoWUc0RlZ1a3VZSkVVT0ttajl0TmtSWXhETnVtWkJkeGRl?=
 =?utf-8?B?Q2crdWYrSmZFekI2bE5EWnRFc3AyTmJGY2c3dWltUlBzNjVVT1BSZ2VPd3lN?=
 =?utf-8?B?elpKTnFQbEhmSzU3Qkk2WWlIdjBnYXZYK1dRM2llOVAvcWhDT3cxRnRqWlph?=
 =?utf-8?B?Sk11WUl5ZENmU1lCT2ZIazVvVUxvb0lCbEgrKzVnVGsxWFIyaWJWVk1PN1gv?=
 =?utf-8?B?cVVYSzdJeEx3NWtSTDhsdTdCMUN4NU1ISXo2OHNNTmtqbGFkQ2FJbXpRQXVl?=
 =?utf-8?B?MGNwR0VXSkZYZVFKQnkwcmIrS01zd3RSR3Q2bWViRUNUUnNETjVKdkUydnlC?=
 =?utf-8?B?QkVLZmh0OHowMlpIcjk0eUJyaTFpOHo1RWRkVkgwWVF2c0FnSEdYWDNEamRN?=
 =?utf-8?B?dXpVdEd0MUxXME1YZDhOTU52N1RJUURjV1BPQU13WFNrU0FuSVJrK0lobU5C?=
 =?utf-8?B?RHlmckN0VDNQeXlkNW9JZ1dQZExnd2ZWSWliRElPVjkvWWlRZW1XZlJrTlV1?=
 =?utf-8?B?eXNDSWx2b2hPZVFkaHEyblFWclpXdkdCK3lKNkM2SjBQVU11dXc2T3gzTHBm?=
 =?utf-8?B?YytFeWIvTkJyTFNPVG9WSUNsV3ZzU2ZaUkgzY21ldG95dXRlVXJHRzgrSmVt?=
 =?utf-8?B?dE4vRzhvOTc1Ymk5d0RqNlBjdnNYdzBLdUJKQkx0c3dBYTZJSkdENWZxMUZy?=
 =?utf-8?B?YmViV2VJOWhrY1RNM3FUb2FIaG9oQ1NMMzFacXNKaUtyS1BTUmpCK2ZiZ0Z6?=
 =?utf-8?B?YVAxT09sUVBMTlVPbFVPdHFnZTZWUzZZWmk1YUNkWDRyRHFRaEdVOEpFdXhL?=
 =?utf-8?B?MjRzaUJjVTVwY3VjOG53Vm9EajFLcGhGVTNOVW1uYjE1L201TnFDbmkrVjVm?=
 =?utf-8?B?Q0tnQlFxQVh4Q0tmaXlQc0Y3Sm9XRDBBRzNJRzJOblMwQzVwOU5XUEVLdklj?=
 =?utf-8?B?b3J1SGhHb0hPRlRtSFFjRTk5K1Fub1gxNkorRXArZ1JMTmloMlJ2cUs1cEdj?=
 =?utf-8?B?M0VWUHdyNXN1YlRGM01WNDZlcWsvT2xMMDJoTExMcG1NazNJUEd4aWlIRmNh?=
 =?utf-8?B?WmlRNTdXcWY0WWhRZFlmS0dPakpoSlVZb1AvTU9vUFd2TG9LTFYrS2I1UlNo?=
 =?utf-8?B?bDd2ZytMa2dpUmhwdWYrSmNtemUyVXd6bk1SN1ZNNkxBY3FPWXR3Y3VMOE5y?=
 =?utf-8?B?Q0o3bHJnVjNtT0JoVVo0a21jZ1RTQ3NBT3JtZUJBdnNFdkxJY2RkZ0tMR0x1?=
 =?utf-8?B?VDFhQUVYSTZ2Ynk5VU1IMUNLWU9TczB6cDF2aGJsWVdwejl1cVpxV1hreTZh?=
 =?utf-8?B?UnRFTjY5OUdXMlFybWoybS9ENU5za0tFSnV1UWpFS2ZNMFhFOUZWMTFnNlpN?=
 =?utf-8?B?eEx6WEozam50cXVZWjVTbFR5N09Qem1tM1EvSzVROHIxRk1Za2w3K0E5L3Er?=
 =?utf-8?B?Q3RDcmdsMmN4Rkp6Sjk1QlBsY2kzMGR0Z3hWZVVVekdOamJvZjRrSkIyODJB?=
 =?utf-8?B?WTliOEdIZ3FDZ0NyU2ViaEpsNFMxaFpjeFN3ZklhMVlxeW9LTzVmekdRZStE?=
 =?utf-8?B?b0JMcXJYL1Zaak9pUE8rSVlsYU51ZDRybWp1eU1McGV3ZEdpdUROMXB6NE9w?=
 =?utf-8?B?dVNESmcwdzJkQ2pVVG1VV0NKZ3h5cno3NzZOMkdDenFLcVBwMVZreE9UbDdO?=
 =?utf-8?B?WlhFdjFGQ1BZZ3dNNFd5cWRNN2kzOEZQZVZFVXJOdkxQTk5yT1dLZXd6V0x5?=
 =?utf-8?B?ckZqUzgwc05qM3lxY1pVQzZ0UWhVQmFHODlNb1Nyd3ZHS1ZmRUZhRUNyK09M?=
 =?utf-8?B?TzlmWXM2S1ZvWlV4WGRLazRES1NjTnROM2RqOHBUOUZMaVlDU2VlWENGZWxi?=
 =?utf-8?B?Qzc4MlUwbHdlNGx6RndMc1NzQ3NTclRNa3JhaW1rZlZJMm9MNENyaWJtUHE4?=
 =?utf-8?B?UFlrTXlOYjNKRVZ0UUxaaFZFTm5KWElKaDZuSDIwVThxd1o4ZjlZQ0tEeHgr?=
 =?utf-8?Q?C5mEROwADrnXR9RTewvsbdxOm?=
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
	2AaRp2dp3AnlCHSJksaDFomTQ08kCev4ZNJROQUMsCKGoZP2cs/aMKC9ZMjPXsMFuuMugirAtqUpRbqQVdhZP2BZrZ0FvK3H4PR8cLNOO+z37QzjP5UVNnJGtsdaO0D+o/B5clPKvHwifXYKlobaYogTgRf+NNDQL1cHJnpX3mlDXS41MdM37lv3U+JmH/6/NDrm2MJKeTlGHYFTIXHzIedpLXlcfymZ0SwFB+M7k+T1x56C7OF+TIskzXTtnfN3kx63rSDlCP6MsCBEoocaOMtA87wdie2uxn/FMRihkMvrt5sVDhZb3tKBquBBAijurC/d9q5rS2ENoDcu6GW0KFHP86oSZU7YfYnbQHZumUKn8OewsHPUR8tejvN4UgVXpkIIhpqe2U6gFP3x+g9hIcIouFmyPvyz7/DHSPhTQX/2N/BUOEnTtaDQ9d12OX9kt6fjJI4SecIkWVoppgGH6KvYEEuW+79UpNcN1wnWwPhSc5f8XUqoX12k1uV1tcMcdwFvs3WkGZl9pdFY9Phxn7xOKQsbNSCesQgJ+CHiw/TrlibVC6tNgniSQQSzE5oIyW4t8NkhDlkHwz4pZcQo6/q/P6uuFAdLFVqBiq8EUZwYRJhAifBwqQTGjDqYn1Tp
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b77cc207-69c8-4ccc-cdc5-08dd07750366
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 02:02:10.5751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kLHffXA29zCKtXN6fdwe4jIdH7KJWBZnDL2nBxbNZBhKTMTsD8yjCUhGmM2L6nDxj7LVwN1jKis7wDWxLunwbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6119
X-Proofpoint-GUID: Mp1RsHqlyR17NY25AC9NkdxEuANwdz_N
X-Proofpoint-ORIG-GUID: Mp1RsHqlyR17NY25AC9NkdxEuANwdz_N
X-Sony-Outbound-GUID: Mp1RsHqlyR17NY25AC9NkdxEuANwdz_N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-17_24,2024-11-14_01,2024-09-30_01

VGhlIG91dHB1dCBvZiBhcmd1bWVudCAncF9kaXInIG9mIGV4ZmF0X2FkZF9lbnRyeSgpIGlzIG5v
dCB1c2VkDQppbiBlaXRoZXIgZXhmYXRfbWtkaXIoKSBvciBleGZhdF9jcmVhdGUoKSwgcmVtb3Zl
IHRoZSBhcmd1bWVudC4NCg0KQ29kZSByZWZpbmVtZW50LCBubyBmdW5jdGlvbmFsIGNoYW5nZXMu
DQoNClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NClJl
dmlld2VkLWJ5OiBBb3lhbWEgV2F0YXJ1IDx3YXRhcnUuYW95YW1hQHNvbnkuY29tPg0KUmV2aWV3
ZWQtYnk6IERhbmllbCBQYWxtZXIgPGRhbmllbC5wYWxtZXJAc29ueS5jb20+DQotLS0NCiBmcy9l
eGZhdC9uYW1laS5jIHwgMTQgKysrKy0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L25hbWVp
LmMgYi9mcy9leGZhdC9uYW1laS5jDQppbmRleCBkNmFiNGZhMDA4YzQuLjgzNzg2OTM4ZjA2YyAx
MDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L25hbWVpLmMNCisrKyBiL2ZzL2V4ZmF0L25hbWVpLmMNCkBA
IC00NTIsOCArNDUyLDcgQEAgc3RhdGljIGlubGluZSBsb2ZmX3QgZXhmYXRfbWFrZV9pX3Bvcyhz
dHJ1Y3QgZXhmYXRfZGlyX2VudHJ5ICppbmZvKQ0KIH0NCiANCiBzdGF0aWMgaW50IGV4ZmF0X2Fk
ZF9lbnRyeShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBjb25zdCBjaGFyICpwYXRoLA0KLQkJc3RydWN0
IGV4ZmF0X2NoYWluICpwX2RpciwgdW5zaWduZWQgaW50IHR5cGUsDQotCQlzdHJ1Y3QgZXhmYXRf
ZGlyX2VudHJ5ICppbmZvKQ0KKwkJdW5zaWduZWQgaW50IHR5cGUsIHN0cnVjdCBleGZhdF9kaXJf
ZW50cnkgKmluZm8pDQogew0KIAlpbnQgcmV0LCBkZW50cnksIG51bV9lbnRyaWVzOw0KIAlzdHJ1
Y3Qgc3VwZXJfYmxvY2sgKnNiID0gaW5vZGUtPmlfc2I7DQpAQCAtNDc2LDcgKzQ3NSw3IEBAIHN0
YXRpYyBpbnQgZXhmYXRfYWRkX2VudHJ5KHN0cnVjdCBpbm9kZSAqaW5vZGUsIGNvbnN0IGNoYXIg
KnBhdGgsDQogCX0NCiANCiAJLyogZXhmYXRfZmluZF9lbXB0eV9lbnRyeSBtdXN0IGJlIGNhbGxl
ZCBiZWZvcmUgYWxsb2NfY2x1c3RlcigpICovDQotCWRlbnRyeSA9IGV4ZmF0X2ZpbmRfZW1wdHlf
ZW50cnkoaW5vZGUsIHBfZGlyLCBudW1fZW50cmllcywgJmVzKTsNCisJZGVudHJ5ID0gZXhmYXRf
ZmluZF9lbXB0eV9lbnRyeShpbm9kZSwgJmluZm8tPmRpciwgbnVtX2VudHJpZXMsICZlcyk7DQog
CWlmIChkZW50cnkgPCAwKSB7DQogCQlyZXQgPSBkZW50cnk7IC8qIC1FSU8gb3IgLUVOT1NQQyAq
Lw0KIAkJZ290byBvdXQ7DQpAQCAtNTAzLDcgKzUwMiw2IEBAIHN0YXRpYyBpbnQgZXhmYXRfYWRk
X2VudHJ5KHN0cnVjdCBpbm9kZSAqaW5vZGUsIGNvbnN0IGNoYXIgKnBhdGgsDQogCWlmIChyZXQp
DQogCQlnb3RvIG91dDsNCiANCi0JaW5mby0+ZGlyID0gKnBfZGlyOw0KIAlpbmZvLT5lbnRyeSA9
IGRlbnRyeTsNCiAJaW5mby0+ZmxhZ3MgPSBBTExPQ19OT19GQVRfQ0hBSU47DQogCWluZm8tPnR5
cGUgPSB0eXBlOw0KQEAgLTUzNiw3ICs1MzQsNiBAQCBzdGF0aWMgaW50IGV4ZmF0X2NyZWF0ZShz
dHJ1Y3QgbW50X2lkbWFwICppZG1hcCwgc3RydWN0IGlub2RlICpkaXIsDQogew0KIAlzdHJ1Y3Qg
c3VwZXJfYmxvY2sgKnNiID0gZGlyLT5pX3NiOw0KIAlzdHJ1Y3QgaW5vZGUgKmlub2RlOw0KLQlz
dHJ1Y3QgZXhmYXRfY2hhaW4gY2RpcjsNCiAJc3RydWN0IGV4ZmF0X2Rpcl9lbnRyeSBpbmZvOw0K
IAlsb2ZmX3QgaV9wb3M7DQogCWludCBlcnI7DQpAQCAtNTQ3LDggKzU0NCw3IEBAIHN0YXRpYyBp
bnQgZXhmYXRfY3JlYXRlKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLCBzdHJ1Y3QgaW5vZGUgKmRp
ciwNCiANCiAJbXV0ZXhfbG9jaygmRVhGQVRfU0Ioc2IpLT5zX2xvY2spOw0KIAlleGZhdF9zZXRf
dm9sdW1lX2RpcnR5KHNiKTsNCi0JZXJyID0gZXhmYXRfYWRkX2VudHJ5KGRpciwgZGVudHJ5LT5k
X25hbWUubmFtZSwgJmNkaXIsIFRZUEVfRklMRSwNCi0JCSZpbmZvKTsNCisJZXJyID0gZXhmYXRf
YWRkX2VudHJ5KGRpciwgZGVudHJ5LT5kX25hbWUubmFtZSwgVFlQRV9GSUxFLCAmaW5mbyk7DQog
CWlmIChlcnIpDQogCQlnb3RvIHVubG9jazsNCiANCkBAIC04MTksNyArODE1LDYgQEAgc3RhdGlj
IGludCBleGZhdF9ta2RpcihzdHJ1Y3QgbW50X2lkbWFwICppZG1hcCwgc3RydWN0IGlub2RlICpk
aXIsDQogCXN0cnVjdCBzdXBlcl9ibG9jayAqc2IgPSBkaXItPmlfc2I7DQogCXN0cnVjdCBpbm9k
ZSAqaW5vZGU7DQogCXN0cnVjdCBleGZhdF9kaXJfZW50cnkgaW5mbzsNCi0Jc3RydWN0IGV4ZmF0
X2NoYWluIGNkaXI7DQogCWxvZmZfdCBpX3BvczsNCiAJaW50IGVycjsNCiAJbG9mZl90IHNpemUg
PSBpX3NpemVfcmVhZChkaXIpOw0KQEAgLTgyOSw4ICs4MjQsNyBAQCBzdGF0aWMgaW50IGV4ZmF0
X21rZGlyKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLCBzdHJ1Y3QgaW5vZGUgKmRpciwNCiANCiAJ
bXV0ZXhfbG9jaygmRVhGQVRfU0Ioc2IpLT5zX2xvY2spOw0KIAlleGZhdF9zZXRfdm9sdW1lX2Rp
cnR5KHNiKTsNCi0JZXJyID0gZXhmYXRfYWRkX2VudHJ5KGRpciwgZGVudHJ5LT5kX25hbWUubmFt
ZSwgJmNkaXIsIFRZUEVfRElSLA0KLQkJJmluZm8pOw0KKwllcnIgPSBleGZhdF9hZGRfZW50cnko
ZGlyLCBkZW50cnktPmRfbmFtZS5uYW1lLCBUWVBFX0RJUiwgJmluZm8pOw0KIAlpZiAoZXJyKQ0K
IAkJZ290byB1bmxvY2s7DQogDQotLSANCjIuNDMuMA0KDQo=

