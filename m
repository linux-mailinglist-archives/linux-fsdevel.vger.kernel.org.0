Return-Path: <linux-fsdevel+bounces-34381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CFF9C4D8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 05:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA03A1F21554
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 04:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9379519D881;
	Tue, 12 Nov 2024 04:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="aREIocvM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9B91F81AF
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 04:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731384016; cv=fail; b=Rtp11CoR6DW0YFUn6fWskn2pszZpSzMGl1Y3cbA1I/wfGwElC944JdysiV/2NX6yHSxkIL241DF2vbwW2fxBfmfEoTGVcASVd8DFvSP32lYFOl1CLk90PDYLqtl9FeSS73idyaGTZukGw0RozGSAk4wompKLLs9l0fBMzloObNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731384016; c=relaxed/simple;
	bh=/OirdAcR8uSFDJQdXWxYv1vrjzaLx3Yd9pKyiJVSX6A=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gRbcecBgTev888nfnenSknAzfS+KKTZCF8eSXXcHfJEYHfyrpMLpKjhQHRtg3HMCQfxKkX9h5jT3GdsObJRCKKPzAdPf7yMLcxwLdj76x9ZKDwvCxLf0Ag+TTDwNf+oMMEKQX2HFv9TDsP2eAWjMMaT0yzLXduKbxiobtOuyCZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=aREIocvM; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABNNcJq006120;
	Tue, 12 Nov 2024 03:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=/OirdAcR8uSFDJQdXWxYv1vrjzaLx
	3Yd9pKyiJVSX6A=; b=aREIocvMH9HlDMjzMOVVeuLdZJMe+TsSXdDwhSwP7a2J7
	PoX/SeQ7sNthazxMovj+k3gN8TNS64wmPCdE3Ivyz+GEvsJNKsFulwF1IxgmL7A7
	G9bGncDdy9doaViQNfe0veaoc2B4ohzkO2eKx8jYjGK25IADihYFO0sc/OBsEtOs
	ABaGxevolnz2RH9VU97NS4KqO79u+4+vIRSLDQuJYT6jyvjLQ1juTodpR+DallGu
	u7xwGjgRGZgeC0Fl+mOm09BSV7wscJhv24xbX1MAi6R1XfPApCvg9DboIBqlCTkk
	uoeLHrR0XWPqlQqQXVRvfHZJkgR/ZODgMdotRezxw==
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2042.outbound.protection.outlook.com [104.47.110.42])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 42t0jft552-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 03:59:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDpnznjlelE1ONQRj8WeTKgC9xjNKsVpYvfs3Wtpg9HfddbpCNWhZ+6pshPMTB0c7SbDAjFES48sk6o67g/pgoc4JQdvGh/1XZX+bpbSCGS5o7JP2YB4D6f02J7rsarmWeCllwuADWsy3GAlCRy58e0n+uB2/lxMkbnXV2mw2ohcDyaAbAO3l2deO+4J4+2nYNZxD2dBkjumoOgiCxifNfWWoao4DG488LU533xII0pr1EZqNhNgYFXQMgjQShN+jNDMNgiGPlcc2vMMo+yLBdYHeetZ8GJVMZtUlOhvn1mTKC1KqQOrLgfFWfMSO7A2oEF5Be+SJU/26bXgwAoXcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OirdAcR8uSFDJQdXWxYv1vrjzaLx3Yd9pKyiJVSX6A=;
 b=RjC7YOXsAA9si4rEWCOlT/6PwFs4KrwHmF6SwXj6KQEkIm1qCJi5LHxeg93kaMkXmxVpQI+3nhXvOaW7TZOOiLhpykeVgqcpnJEOjzlCgnennuL4Uv0WS7EJ2NqIow1OlKLbY2pGuHVKKu0lFk+6harFd4zNXRskEhasLTag5ff8LS9hhTLuBlL+njL7Bdi4NA6X3Yu9uWnutEqresq+S7Kqw3pVdQ5cCBushT8FpU9TxyabwoymucToLY6ojveYsTSIF4vfcmXwBZs0IgDzuGvyIxXM2MYoA3UxQY4RsT5DiM1gdU9t+NrkfejDCSo1mKGvSBINSJgmx0KZCSL5Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB7970.apcprd04.prod.outlook.com (2603:1096:405:ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 03:59:49 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 03:59:49 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v2] exfat: fix file being changed by unaligned direct write
Thread-Topic: [PATCH v2] exfat: fix file being changed by unaligned direct
 write
Thread-Index: AdsgM2W/jtVKm234R8yZ0P6GDnagywUg6Y+Q
Date: Tue, 12 Nov 2024 03:59:49 +0000
Message-ID:
 <PUZPR04MB631627C059803D3D4609D1C581592@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB7970:EE_
x-ms-office365-filtering-correlation-id: 31b2d81e-b6b2-4ca8-62df-08dd02ce741d
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NW1TcUl4OGkxZ25qUUJFU3lGV1p2Ynl1VTN2RlRQZW1wMy9tOHdUVkx4Qmxi?=
 =?utf-8?B?WDJPbG5ZdHFjVzUvbERWWFBQdUlZaUp2Wmp3WjBwREJDNWNTRG9LU3FtbE1I?=
 =?utf-8?B?cUdGRzNPOU9pYUhiM29hdTg0cjdqbmVlRSt6QU04cUx0TWZGR1AyYmRlTElJ?=
 =?utf-8?B?WGlrbCswVHBLYzh0cUV6MncwT1YvSUhWaFhyemFGQ1Y5WThFMEJSMkozUlNG?=
 =?utf-8?B?VUxPK0tCd2xWMm5UaVNZbXRPOWYrcmRwV2xNTUg4UXY3Wjd1TmovSjd5elht?=
 =?utf-8?B?Tlh1RDE3V2FYeG13YVJBQTJhbThEQS9aTzlmZ25FY0VkSC9yczhDb3BmMkdj?=
 =?utf-8?B?bnVwaytFVFVPRU85Tnk1cUV6VEVXS09WZ1F4d3NBci9HanFvRW5vbG9LcnlU?=
 =?utf-8?B?U1ZiTUo5T3ZWcUxRSTRrTllwOWRPeTZnaDZOV0ZuR2NFaS96M0tQR3dzV012?=
 =?utf-8?B?NnkrNmZiSUc4a1FOQmV5aGdzUFBKL3l0ZVljSXovYjFSL2x4UUhrOU51N3hW?=
 =?utf-8?B?eHNYeUVCMWFqblM2dnZRRFI2eElkaUhQUnRWUFpPR05yMEVlYzBOeTFTdXVo?=
 =?utf-8?B?K3FrQmVFUEVYdkswSHFhWUNVWUJidnU0TnhKdXNRc2NJd2lpZ2tYQ2VubVlw?=
 =?utf-8?B?WkFkcDJuSTNDVnBYYmN0c1lqeUhiZ2VmUDJpUTlLZ3lHTHpua1E4Y2gvY2JH?=
 =?utf-8?B?cWw0ZWplV2g2V2VIR2xUR0paU2I3U0N3VjR2SW9yNnp5dTNDWlBFZGJtZGMx?=
 =?utf-8?B?MEJnSFBpMnV5bCtUTWlYb1dxd29aZWlCNCtqa0h6NzFBYnJRZlVkd29VVG1Z?=
 =?utf-8?B?T2JWQ1V1dGVaMS8yYktMNFNpNTlTbThseFFrczV6d0FjajBmdWdvYk1tT0RT?=
 =?utf-8?B?c2pMUU51RU12S2x3cWhBYS80RE91V3RQdXFkeHEzaUxBc21uSC8zaTROaVNl?=
 =?utf-8?B?ZTJPTHAwQUtDcWUycFA5ZHBVK3dqTFI1ZWhObkhjMkM3TGhHQlk0UjkzUnR3?=
 =?utf-8?B?aE8ybGNoRGRRTkpGdUlxQzlXL3VaVHVDaDFzSXM4UGhIRnZPQXN3RDRpdm9p?=
 =?utf-8?B?VnZHd0JNdzBibzZWeFVIQ0tSSGtzM0ZPV1Y1TEk0bnVMeFJyVFp2cDNnZDNR?=
 =?utf-8?B?bHhWV3NYai9EeXR4VUNVWEdtQ2drd1dESUdBUmVySStsUUpaaURDYTJGcVha?=
 =?utf-8?B?VE4vU2x1ZFFMd2ZpVXc2UmVkK1hTMVN1dzV0MmlsRmx3UHZzOUIxcHJsS09y?=
 =?utf-8?B?dkNkbjRLVFJjMWh1cWFCSVdNekFzNlVqT0Y1STE0SXprRitERTNtWW8yRUhv?=
 =?utf-8?B?aUpRYXNheXMzVys0TWl1K21sMzI2YTJZNXZMM0JUTTJycnJxMUc0NVk4L2t1?=
 =?utf-8?B?MU1IM21MUlhEOWs0VlFMWDRMdHlqekRGeE03d0E4bTBxeml2MnlYRWlXdFB1?=
 =?utf-8?B?NE9CNkI2S3VTQ0pYcnlkUG15SXNiaGYxUithcDFFa1d5TVByTDRLbTVQYlpo?=
 =?utf-8?B?MDNXZWdSTkVsblNoT3VvUGs0YVBnQ3BaZmJYV3ZFbjRrQi84ZkloV3U4KzhQ?=
 =?utf-8?B?bEtTbFkwTkNpRGJFNkRoVUZqL05OeTV1Z0VYcHh1RkZrZWxpOUNzbTE4SnMw?=
 =?utf-8?B?Ui9LOU05R1FBOUFwazU1ZmZ3SUZ5OHdURjVNTUp3a2ExZTJhemJFcXQwZkVx?=
 =?utf-8?B?VlY2NEFqQXFkR1lIK2JFc1VpdVdUNTRwa0pNSzR2Q2NnUzVrZndES2doOVA1?=
 =?utf-8?B?WTlyajZRTU1jT0tRUnk3Z1I3REV2MjNFdjU0MURtdnlPdEFKZE5SQTVEYkR4?=
 =?utf-8?Q?4fc/Pb8GF74aTO+BjLBXXrn1uqqDul1ujSfrM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NDJJTkFJdkw4U2hoWVA0S1gvRzZROStOcXhWRStCMjZ6U3dtOWVSWVBxU3lm?=
 =?utf-8?B?MTBaTElNQjNUalk2SnIvMG1INXBTU0hSVU9LeWtzdDBQb3BaYjBCRnNZMnhW?=
 =?utf-8?B?cU4vVmNzVTZFRVZDckw4UWZNeUFJaG9DR2UwUW5kNmwzNk0wQVNvTlZxNDNF?=
 =?utf-8?B?UmQ3NElVb2wvbVJTbnl6THNBWXozejR6SGltV2tEZW1wMG5SS09uTnVXaWV6?=
 =?utf-8?B?WjJxVjRjQzRUdUNIVGtoZjRnUExnWkFCZXM1b1B1WTNRSVZKWjRGMGx2MEsv?=
 =?utf-8?B?czROSURLNG9CUmtCVlRvQXVKazd2TlhyakN4N1gwUGJScktoY2E1Q0oyOUZt?=
 =?utf-8?B?ZlNSaEdFNjFPYzdEYTJOQnVzMk81V0pyR3JDbFkycytuS2FnN3BzNzM3YVZp?=
 =?utf-8?B?bVVZQWtGZG5iTk56RjFSTWphZ1hZbHpTcGRRTlQ4TDVGSmsrcFJnbnhadGdN?=
 =?utf-8?B?Vkc4VDBhUXhWd2NIWUMrOUtpM0RLY1JRaDJUa1pENitEblBFK1JVMGM5NXY3?=
 =?utf-8?B?T3VLMkxwWFYvUzdoejAzYTdCOHpKMGg4a2h1WWdDRG9PK2xLNTBsdlN0OVBB?=
 =?utf-8?B?SE5TM2JBZG1vcmdqWmNob25YVEdjdjlJblJBTW9jemh6SnA5SVJMMkRlWFlh?=
 =?utf-8?B?bUVXWmU2L0VtYzEway9vY1pETE9nV3V4aG9aSXc3RnJsOEFJbG9JY1BkN3J3?=
 =?utf-8?B?eTR3UDM5WXEwNG15NDIrOWMzZnJBZUJOdVZnSHhBeXpETGVKMFE4ZjBGMmdZ?=
 =?utf-8?B?dTA0VUZpQ1FXMjZMVHVsaTdpZ2tnNTBGUkNkdGgwelNkMlJ1OThxUGVtSU0w?=
 =?utf-8?B?dyt1RGJBVXpudXI0QnVJaSt0d3d6TzdETERQOVFSaUk3eWtvZTR0QVlYM0hy?=
 =?utf-8?B?aFdqQnV3VTJwUWhhdFJsYmY1bmZ5VjI2SUloMnFmOWNKMXJ2ZWdjUER0aFQy?=
 =?utf-8?B?Y09qMUZQT09ZbkR0c0pUbnR4dlcybkRNZmdVUXk5OGtRaFZOd0x2dzhURGhr?=
 =?utf-8?B?S0hBR25SazhycGQ0dHlNWS9VaUFMUmNveU5vUHhmcTYrVkE1Z2tFQTZPdVgr?=
 =?utf-8?B?aHNJUWwwbmIwK2tyY2ZTVHh4WmpOd3ZpU1o0L1prbWxlU0R1WWNpbDUxODN3?=
 =?utf-8?B?czV0SitxSktGRmZRMmtnN21ZS01RSnIxektpMnZRWDlRTFdxYWh4STArQ3M2?=
 =?utf-8?B?OUtKY2pHd3JIbENDUkdlOS9mNlhUWGdCRjBtMnAzeEdKV1RoYm5iOXJaVVB1?=
 =?utf-8?B?OURRNWx3cFRadzltMlFPV2FiZmFpdDE2KzE4YVFtTTQyWDBIS05tTlR1eWgv?=
 =?utf-8?B?amliOU9PazJoTEw5ZFVVNWpuT0pxQm0vbUU1RVR4bHdmZjBYWVFpUG10bU0y?=
 =?utf-8?B?R3V1U0ZmaC9zUDBJeEQxZEpxdkJkTVhMM01NVlptdUpPNmJ1T0RHQTNhTkZC?=
 =?utf-8?B?ZklvSTY5QnJDUVFPWkd3ZHgxUk5hNkIweXBFMDVvb2lqNnRGNVRXdllDVU5T?=
 =?utf-8?B?cDFpZjlUSEJCb0JiZ3JWT0lmWURKaGl4ZEltYkVvdkdQck1kNHFtN0RiR25B?=
 =?utf-8?B?ZXZLenk4K243dXk0aUJ6L0dTS1NET2VYeTBXUGUvMTRKRUR5TnRUamxqSUpt?=
 =?utf-8?B?UnFsYVJqbEpUbmJPVVJCZG5kai9Ka0J1VU1HOG9YZHVVSWVZcSs2dVJCQ3hB?=
 =?utf-8?B?ZjRza3NYSGI3NEtUdjJ0UG5rUkZnNnYrMkdtWkI3eHRaMHRGeXNCTWh3RW9i?=
 =?utf-8?B?czd2bHhISmhrQlVPbCt3QnFlUEQrcFplY1k4THRiS3F2MmdneWpIRWdzcERr?=
 =?utf-8?B?SFRaQ0l5RXJYOU9MZS9jWmhnNCtRZ1E5aC9vdGc1UFk0UXZqOWJKSG5BSzNM?=
 =?utf-8?B?djJqcDg4WjZySXhxTjdvOEVFSkVsTkwxRkwxK25oSkM0Z2h3VXVaVGhvM2Fl?=
 =?utf-8?B?ZDdZbGJBc1lZOXl4V1FQZU9SVUJBWWFQOUtjdTNjUFFtRjE3dG1aMU03bU5D?=
 =?utf-8?B?RkJ5TWxVTytIanR0emZxSHNRbFVRaWplY3N1dkpWL3FrK1F4QUZDcUVKYXNU?=
 =?utf-8?B?bFJRUUR6TzMzMjJTc0lrV1FXZ05ZOW5sZm5tcXI4elN4Y1BUZlhRRThYRDZ4?=
 =?utf-8?Q?b6REBxj55426r4nsyYAlvAfTl?=
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
	vczMvJvSFpoux3Vrj+cVbiWNA31kqPf+d400+xDlUu8UIRxYXvR7W54oPyOcwwHQE0pFncHxaIyTFwhd9GrVSz6s9yaNabrze8la1lDpizB7rTpu8J/AJvDG9dOXH03TsNodbhSmK8AOdpD7kQIyhTtdoiHxZGwMPIXCNoyzaGvcYT5tGvMG1LjglT/Jy+QiIVVjJ1Vwr3pOY2wAgKElwKWRRoD1hJXiTbdyQI0BQlQGTUnxP6fv2aorjwhhukxqC1cnvfUYIzSRsAwzP8i/7Myw7nAONU8RNzjJS2EktJ+mU6k9aCcUkTyU8hdlyOLAJAgf4ASfemXNyaDR6mzQPN6la1yRjybf7dy5afyLGzEHjAX+0WkfS8hUtpFkG7uiEprpooTOYfixeIVUM58okkcRJ8NkBNAF9Mi4UfTnuy7i3WzaADLKityHg6e12ny2knChFnLKf4h3xTLnFWi5y6o7WxgvWm4S8wniuiYANxbah+bU97h7y/uRwY0MEB0D2dgPn4WFYoq7uvP3J411isRhlnGw0jkdRw+nvjpqV52Xj47TjsbbzJP7NYjNlsOp98huDrYGAskg8JYT1K2Zd1rnK9AsBMe2BTVdGb0UJ7yQD968yjCo/gO1T03QDFiP
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b2d81e-b6b2-4ca8-62df-08dd02ce741d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 03:59:49.0574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /yHgEzZgoXDGtjHF57RDViTqRyV8Ty6LMglry/A3ndjAUbjGGCz0PKk1+tHUg/Q5+g9tkPO7fIeO5zWzqP5W5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7970
X-Proofpoint-GUID: zM5rnDw0bEj1mzGaIhvQLdqR72TLym2_
X-Proofpoint-ORIG-GUID: zM5rnDw0bEj1mzGaIhvQLdqR72TLym2_
X-Sony-Outbound-GUID: zM5rnDw0bEj1mzGaIhvQLdqR72TLym2_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-11_08,2024-11-08_01,2024-09-30_01

VW5hbGlnbmVkIGRpcmVjdCB3cml0ZXMgYXJlIGludmFsaWQgYW5kIHNob3VsZCByZXR1cm4gYW4g
ZXJyb3INCndpdGhvdXQgbWFraW5nIGFueSBjaGFuZ2VzLCByYXRoZXIgdGhhbiBleHRlbmRpbmcg
LT52YWxpZF9zaXplDQphbmQgdGhlbiByZXR1cm5pbmcgYW4gZXJyb3IuIFRoZXJlZm9yZSwgYWxp
Z25tZW50IGNoZWNraW5nIGlzDQpyZXF1aXJlZCBiZWZvcmUgZXh0ZW5kaW5nIC0+dmFsaWRfc2l6
ZS4NCg0KRml4ZXM6IDExYTM0N2ZiNmNlZiAoImV4ZmF0OiBjaGFuZ2UgdG8gZ2V0IGZpbGUgc2l6
ZSBmcm9tIERhdGFMZW5ndGgiKQ0KU2lnbmVkLW9mZi1ieTogWXVlemhhbmcgTW8gPFl1ZXpoYW5n
Lk1vQHNvbnkuY29tPg0KQ28tZGV2ZWxvcGVkLWJ5OiBOYW1qYWUgSmVvbiA8bGlua2luamVvbkBr
ZXJuZWwub3JnPg0KU2lnbmVkLW9mZi1ieTogTmFtamFlIEplb24gPGxpbmtpbmplb25Aa2VybmVs
Lm9yZz4NCi0tLQ0KDQp2MiBjaGFuZ2VzOg0KICAtIEZpeCBhbGlnbm1lbnQgY2hlY2tpbmcgZm9y
IGRldmljZXMgd2l0aCBsb2dpY2FsIHNlY3RvciBzaXplDQogICAgc21hbGxlciB0aGFuIHBoeXNp
Y2FsIHNlY3RvciBzaXplLg0KDQogZnMvZXhmYXQvZmlsZS5jIHwgMTAgKysrKysrKysrKw0KIDEg
ZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9mcy9leGZhdC9m
aWxlLmMgYi9mcy9leGZhdC9maWxlLmMNCmluZGV4IGEyNWQ3ZWI3ODlmNC4uZmIzODc2OWMzZTM5
IDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvZmlsZS5jDQorKysgYi9mcy9leGZhdC9maWxlLmMNCkBA
IC01ODQsNiArNTg0LDE2IEBAIHN0YXRpYyBzc2l6ZV90IGV4ZmF0X2ZpbGVfd3JpdGVfaXRlcihz
dHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3ZfaXRlciAqaXRlcikNCiAJaWYgKHJldCA8IDAp
DQogCQlnb3RvIHVubG9jazsNCiANCisJaWYgKGlvY2ItPmtpX2ZsYWdzICYgSU9DQl9ESVJFQ1Qp
IHsNCisJCXVuc2lnbmVkIGxvbmcgYWxpZ24gPSBwb3MgfCBpb3ZfaXRlcl9hbGlnbm1lbnQoaXRl
cik7DQorDQorCQlpZiAoIUlTX0FMSUdORUQoYWxpZ24sIGlfYmxvY2tzaXplKGlub2RlKSkgJiYN
CisJCSAgICAhSVNfQUxJR05FRChhbGlnbiwgYmRldl9sb2dpY2FsX2Jsb2NrX3NpemUoaW5vZGUt
Pmlfc2ItPnNfYmRldikpKSB7DQorCQkJcmV0ID0gLUVJTlZBTDsNCisJCQlnb3RvIHVubG9jazsN
CisJCX0NCisJfQ0KKw0KIAlpZiAocG9zID4gdmFsaWRfc2l6ZSkgew0KIAkJcmV0ID0gZXhmYXRf
ZXh0ZW5kX3ZhbGlkX3NpemUoZmlsZSwgcG9zKTsNCiAJCWlmIChyZXQgPCAwICYmIHJldCAhPSAt
RU5PU1BDKSB7DQotLSANCjIuNDMuMA0KDQo=

