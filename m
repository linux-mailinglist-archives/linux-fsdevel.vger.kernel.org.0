Return-Path: <linux-fsdevel+bounces-42145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65962A3D154
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 07:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386AF1776DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 06:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A791DE4EF;
	Thu, 20 Feb 2025 06:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="pIGwQrh+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192461632DF
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 06:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740032533; cv=fail; b=PI6i3oJFuzBA980kBdxwlDsYp9osoZgWlJkGrACofUIVUsl50KqhpRhtLeljjEsznfjcopMV71SJQjN5kda1lIxu5VxRXK/3+LMg0Ne02rFieNaWFYpRCP7I5PBuY69YKGdUNjedRpffCZNiY43SHQw82QH+15hXR2B2GYVCGlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740032533; c=relaxed/simple;
	bh=pwS8kWzcDp5kQgh8ktz0b6goQA0wtGClHBYUKPnlyTw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gIBZSHFlBemsSES6RNGZ1gT2Wsyn/RPmNEl0AyXiC6nnfk1Cw07H7DiPJZJKXVvv25wfEJieXem1ig1d5xkmgQOKxZCbyvOJAia8eppRgYYNvW84ARowaqPqJ0BOCep0ZJX+2pnKZtSsn2dR/mQAfOlZf+87VVIGuN2kBExNq70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=pIGwQrh+; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K1g2jm026623;
	Thu, 20 Feb 2025 06:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=pwS8kWzcDp5kQgh8ktz0b6goQA0wt
	GClHBYUKPnlyTw=; b=pIGwQrh+kL2X3WbIk5q9m2pZXkRQpGVDXqBJuTNFMvUFg
	uG9WohAvF75TxfhiLvhLu6mooijnLYWf2+p6rUmobrrBIqKIMv7cdSxuv8I3B8pP
	FHtU6lSwx0bL9jKQW+jNwmBZoQ1fQUKiIhcAJcuzMmxptcwcnWobJUZ5+LgcMQxc
	SzDmm2HWpWuL6hSTxOFyt0RwyeCBtjiA2a5Geejy02xpdZu4odySsSJIcbXGwMMB
	xkh1h4uTsObRv1f/SVz1+Sftgt999D5BBF8eNECJUvZiTFrxfMYbjaTMScOVstf+
	z6nnfms5OiyeK4dSnXwiUYnl8L4vxN94jZJmaRqqw==
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sg2apc01lp2110.outbound.protection.outlook.com [104.47.26.110])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 44vyyesfj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 06:22:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQgJ34iSGDILWbSWScH/ZTRlHa+AX1+KqPfZU+YPEAuQUtQRViyYiw4EQH+i2Q2yfdSa/azSNRDKKrhZ8wcXFF0a9o5iLsaGLyR+GgGgO5Vlnpm7jBbvlSeZOKxbiZP9TYYt6wTf1XgRTG0YgFp1asmblT1u2uo9lODRCwd3CpNX74GdWtMwbTJRwfzK/F8d9ggsFr4vqxn8pAvtNT6LxvrAtCAGWld8/DAuWQGgSH6ilrZkEK1WZoYDDXZuRotToxLZiN9wOGyMLBFyda2H1yig8AqFWH7dGXlyMa9Wgvw3RrDL7LYoZPPs9sLrUC0LWOMfETlPalyeGAqVwcPMkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwS8kWzcDp5kQgh8ktz0b6goQA0wtGClHBYUKPnlyTw=;
 b=xkLbUArJlpDxxO8rj75dbHEbJWqTqmGn6p/qNuukNH7EP6gpfRpcvQoSsFqzjLy02jYtOVo5x0aTas1GMCdo5hwerarrHY7/hMWgv/bNMNfbs7M6lzSN6no4CM8xMskMGj0B6p+ydUqoFur3OrOoWL4ljdzd3vD7HamZrqp+U0mEF9QbBdK12k/TdWKElj4Ro0BT4fDffsATNta8EpeRsuaBA4ZOJhqV8r8FlQWK9qt5cD/gq0EST2tE530u/a7GT9vlwok/VvKAuX5Q8uaouLsjo58LBdPIkMxk3tQYQoEP8Sw/aNnd3VSnngenhqrzPY+J1+mmx2FJgIP240sNGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR04MB6782.apcprd04.prod.outlook.com (2603:1096:820:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 06:21:53 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 06:21:53 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v1] exfat: remove count used cluster from exfat_statfs()
Thread-Topic: [PATCH v1] exfat: remove count used cluster from exfat_statfs()
Thread-Index: AduDXg9112B+ywmMSyyu24ovdOFDFg==
Date: Thu, 20 Feb 2025 06:21:53 +0000
Message-ID:
 <PUZPR04MB6316639D72F6AA3028878F2781C42@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR04MB6782:EE_
x-ms-office365-filtering-correlation-id: 80704816-e813-4c4f-fa26-08dd5176de91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZXU0SE53MlhQUGJqTklkZHZOQWdoOUtNaHU5TkVXZkRJMGlvdXZMOW5yNmdp?=
 =?utf-8?B?bVIwYnkvNTc0UEFDWkpGVGRIU3AzSTNDT1RySGp5ZG05TkRzT3Z0ZStqei96?=
 =?utf-8?B?SHBDcUwzdXAwS21hY0E4bTdSTlVnZ3hxM3d6NXVDV1dmQjdzTi9OOEZFa3FN?=
 =?utf-8?B?RmpSdUJHLytiVCtVM0RZYSsxNFhZSlF4QlRLZ2RGa3FlMStlNFhxN0N5dnZi?=
 =?utf-8?B?aXpFUXFhV3NqMEZkMUFPemtNaEZZRzJ3am8vc1RZTEFKMFZtQTNuZFQ3N3hH?=
 =?utf-8?B?VmpzTmNPOVJDeGlkTldKMUR1eE8wd1F1OERhMXJvVmhScGE5UWRFVEJpeXdm?=
 =?utf-8?B?VitQYXdpeHRUMDR3NUpQMEs3Wm5XS0xkdm1YY1NpcUlFSVVyRS9FczZnRnE2?=
 =?utf-8?B?aDJ4ZTRYdXRzdUpHaGpPUEhNSHpzS3M4QWthNVNxV29HU2J5Mys3MnNVdWF2?=
 =?utf-8?B?ZXZGTllldFM0SitCSmlEVmNRY1ZNQS80K2hvcmJaY05QTVJFL2pEcTNHUmtt?=
 =?utf-8?B?MTh5bFlFOTZ0QlpXaXlrd09COGNlNytQMkZQeXJGMndVV0hZdUZnU1U2TU4w?=
 =?utf-8?B?K0VrUUlJWlZtYWl5YXEyTXllalo3Y0JVdnQrMWRxc1ljVWRleTYvZElSTW1p?=
 =?utf-8?B?TkhlWlZMcTl1aEZFOGtxUm8zRjczMXN4NU1ISnZTZUtaV1dOaEJ5a1dhL0xB?=
 =?utf-8?B?SDU0L2ROTVVxcFZLSU43MXF0L1QvVm9lSEhTZFdkSnNyUzBkWC9pRDRxS2Qy?=
 =?utf-8?B?MHJSUVArYUpZSG9GZnJzZFJPaVgraFhwbnBUQjVnWEZUVmcvMHdJOUJpUW9T?=
 =?utf-8?B?UDluMFc0NUhUQjJ1VldWOVBhTmViY0w0QTQxTVdMczFIV0kzY2FEWnZPU0RJ?=
 =?utf-8?B?Z083Q25YR0lnRFo5TVhUeVB2WDBnekk0MXJuSUViWThWNlBzdUtZWm53aDZW?=
 =?utf-8?B?bmhnME96KytNQjE2T3YyZFFiWVdKQ05lc3Nqckc5U2JJbWFzNWtRZE9NNWhU?=
 =?utf-8?B?Yk5tanJnNDJRc0ZmN0N5U1F2cnJxeGFTbnJGUWhUMHlWQ09ES3hEWU11ZEJx?=
 =?utf-8?B?bzd3LzdoYmxtczBROTJ2U3lDOFdCeUdnZVFudFMvTnlBcW1CMWpkZmJ5QlNn?=
 =?utf-8?B?TmdYNWtYWTFHUG5HajB0YTJRUktCYVZIKzd0OTZZUG1nR2FtSlVidS90U3RN?=
 =?utf-8?B?UE8rVG04OS8xc0V6Q3JUNml1OGdLWHhzN0MvZ1c1VVZmbFZ6Z1UwUXhHeHJs?=
 =?utf-8?B?WFRIOHhRTnNXc1k5VEY2RmVpNGhUUUdmSU80QlFPRkQwZ1JsYmpFWnZnNVN2?=
 =?utf-8?B?TjgvQU1kMEcxSjFUQ1NjNG5XRUlnbFIxRnZFRElyOG5HT2xvR2pDZjYzQ0JU?=
 =?utf-8?B?ZGdWWWoycXdSbHFIM3VYejZRU1ZLTjJSRzJNRG1zREhYUktMckZUQ0Z4WHN2?=
 =?utf-8?B?OEQ4eVUvWXgzV2dnNEJFeVRRQ1ljU0JYYnRHSGlLeGdhcE84QTBCeHJSem9B?=
 =?utf-8?B?NGNPenlPNU5LdXJsbW1ROWx2b0xIRmJoSkQzTlk1OTBVd05keHRINXZKaEEw?=
 =?utf-8?B?MTBEenF3aXpHdVpYRjFZaldrSllXVGdkYVR2R2VOWmwzazdwdGhLY2tmQzlH?=
 =?utf-8?B?cFVuaWZJS0NUdVFtaUVjMGRVSlJVM0F2ZU9IVFNpQ2pyd1ByOGVJRVdFeWVR?=
 =?utf-8?B?YzFraFNhd1dHczE1ODZnV1ZwNXZsT1dYNEtZdWZ2QmRybjUrSHdjU00vMnYx?=
 =?utf-8?B?VVR6cVh2OWRqajRCTkxHWDU2WjJZN0hTWVUyZnYwMndYV1hleGJZMHlKc3J4?=
 =?utf-8?B?c1lSdUdmdlVqWjJWcHBmbC9aYVQ0anFIMTRNandSeG5jTTUzSVFJL21ORTRU?=
 =?utf-8?B?RUQ3UUd4djdzdzZObmY1OEZaa3dFOG1tUjRkSzBweE5SZlpmVU9ETDlwN2Rx?=
 =?utf-8?Q?V62/SKdToKJRt68XZFOCCYV945wkrJF9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d1Q2VlNJMk1rMGV1QmZDMCtpVExRTXc5b3lWbWxKMGdhOXJreXRHR3BtVDBx?=
 =?utf-8?B?QXN5VFQ3TGVyYnhOS1BCMnNkcEJMMnNNTGQzVVAxYitGOE1Pd25VWmlTMHRF?=
 =?utf-8?B?RGpCcXBEWW9heDh6NklzUGxPcXE4L0xQY1hSYytjdDI5WEVoaXdQNWYxOVFS?=
 =?utf-8?B?Vnl1UFM5Tk1hdW95YzFrQWdxSWFOQUNteU5EQlFuYXZpVStTVGZpSXRpTGdH?=
 =?utf-8?B?U2Vyd0h1Rnd2SHByOTNOUWpMWlREWHlOampYMHo1YWFHd3I0NkF1c2FocUs0?=
 =?utf-8?B?c1NOckF6cjhZOVBTcW54MVFZUFoyS0l6Znc0aS9DUUdUY1dsbktENmp4MU5D?=
 =?utf-8?B?Wmt4ZitlY0Qxd0hsMXRPTDY4S3ZuODJhVEc5ZkZtQVMvdEp3d1BHNW11dkdZ?=
 =?utf-8?B?ZXVCNk5ua280OC84SjZSbTlWblJNMXdid0pGUjA0aVVJZTB2d3pYa21zVWtF?=
 =?utf-8?B?MWUweHlYTU9mdHJjTkY0Vzh0a2thOFRJaE9OU0puSlkxY0lOakZ5b2JTbDA0?=
 =?utf-8?B?REI4WW9lRFRIaDhBZ1R4MGd3a2VOMXdGRDhXWWNNTGRrL3pxazBzQUFFZzNR?=
 =?utf-8?B?enFuREFpRkFqK2tueEdYS3JhVm9iZElwRW1QcVNiUXhVWWN3a2pTenp6RU1R?=
 =?utf-8?B?MjNPWmdBMGJ4MGtmS1ZGa05CZFNzTUxrZHBnd2lEQ0tYMlVHZk9RNEFmL0ps?=
 =?utf-8?B?bFdNVEt1QllEbUVXME5NZXdRMGtwLzRNOCtvRDVlUWg1cHEwNHZudnFMUUtL?=
 =?utf-8?B?ZGpNeWZmT2hSaU84aUZnTnFMK2VQSzZXN1FZbGFFNkFOcGVEV0dzc1FWVUJE?=
 =?utf-8?B?SXFtbWxNMWU3YXZIOVNsWm0zYlR6eGM3VStBTWtNV2pmcW40K3FrNkM0bGl6?=
 =?utf-8?B?RFpzMU4wSGFORFNMNGl0YThwSWlYYUZLSkFvcmZ1S2FITGpkM2luRk5Kam44?=
 =?utf-8?B?UXpTczRsL0Fxc09NeHNsUUU2Nnl3SThhWUFGMTI0M1ZXeVpzbHVHUWF5NS9i?=
 =?utf-8?B?d0I4allzaWtUVXkzWXFvSUIySllpVFlyTURqeHNyb1hEcEl0SlR0Nyt5VlMx?=
 =?utf-8?B?aTJraHhzWGNHN1F0bDRSM2pnNGJobVdzTTB6QmlKeWJ3a1YwTVQ0T010MTNz?=
 =?utf-8?B?MEZERVpPS0RmVEord24rNFkvOWI4VXBOVmJVaUlBRTkyQ0pmK25DLytSQlNW?=
 =?utf-8?B?UkhTbGpEUlZ5bXNaWE5BTVoxQjlza0hNUUUrT05SQ3hrNW4vR2doZTN1WlpB?=
 =?utf-8?B?eTRHTFNJdlFkYWFscTZwQ1BhMUpRaTZaOUFNaXN4SmI3bEVDMlpsK3FhM2lF?=
 =?utf-8?B?akFlcGNRK3RPWHNrczU0TU1sc0sybWJtMXN6V3A0Q29zV0Jua3RlSUhtL1pj?=
 =?utf-8?B?MGRCZVZIUllwRlNLdHpoSU9RcGxSU3BpSXRlSWoxZHFyWWR3eGxvNjdwNnhQ?=
 =?utf-8?B?STNwUFJIRktoR1hieTZydVpreklTamxURVBUQzRpWkM3eXcva2J5SEJuZWMv?=
 =?utf-8?B?WU9ON0lRM0xUTm8vWk1obFVnOCtLb3hUeXoydk81RWN4cEEvOUpZNUxNaXhv?=
 =?utf-8?B?OFAxQ0ROeGdWd3llS0E4OEovSFg3WnVyMWdnbFd0VzY2VnppOXBVT2JZMnVN?=
 =?utf-8?B?MGRMRGU3K01wR2dKOG8yK3lDU3NheGRlVE4waW83aXUyNFBGdk5XMXFMbEda?=
 =?utf-8?B?QmlYRGF2Q3dNbDJuaXUvdkZJemREdlQwa01lSTZQYnBoNEkrdGlFWmVZdXJ5?=
 =?utf-8?B?Q2JpeUUyY0IweDNaTXBnUmMzNEl3TGV0VGMzdTY1UHN2cGRma1lkQjNjbHly?=
 =?utf-8?B?clYxejh1b0pYNUlVUHdUMklOSE9wK1ZVV3RQR3pvSEJVMlluZk84bm14eTFN?=
 =?utf-8?B?TS9WSU9STDBZWmVtRGl6ZmErWHNLVDFLTXB0RnAxWE5uWVdJemVPMlBhdVFn?=
 =?utf-8?B?cGxkNjRMRmRtRkdpeHFnZDRJRXFPUC84RTNlSjB2ZzFIY0xoYTFzNkgzcFFt?=
 =?utf-8?B?WjdSbEVDRjNZaGh5OVl5bENkbDB1YU81WGpFb2psYWtxWnc0bDc0WGpmWjlX?=
 =?utf-8?B?MDRob3dkNXBGYzRPYWdUUU84ZXBXTEhaK1NORGRiK2xDZHl2bDJoZmxQNjVV?=
 =?utf-8?Q?TVMiN1mPehkCZnoHK5HRmHx2x?=
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
	eH1hFdABXUZ1/HgaiW4JU36PNDvMtJO1VX1N+d1T9QPfCSKWFTfb0ULYs/st+PNpwrZkzgMLM1KlMQjg+QFd9v0f9JmECW4xYjbGOWe9xiqcvqR4pF8nCZdR1Tic8MP70r+CdQGaYok/jTUdmmQaHIxDhpLRtW8EfYdVsT3C+tpa9+N5SPkl9xUtFdzIWMSwyK+dFsbWYcynSPTajY4tnAaVmBgXfPH2TM4kkLqjMcLJRahX8uZPgGWyOvwiHMIdYsDr8XKDfukriAOBKHYESZzrB/6G8T1jgg4rCbPTjmpYNkUvsDAUMN0P4rvx7ZVUZePc3KLlWfGEWvI/Bh7molAlP8BvLDnbOidyfp7nhBIXKSLYj5Slod/8JUy5qT3zQ8Nst9fUcY5s0EYZt1lyuLBDsz8zfk6+BWWB43Hxh68i4vKJ5ITy/Dpx/3JKUTdZ/urzmJSZ3bV5us1Cu/tHyT+BjZM9cp2At0jWQiCDO3OmdGqm2XY/qSkY49uq3kZv8Mxx1NCCofYlh+Eu1lu7TPKJ6W1Ho7N74F7OVAOHDTysbvenYup6Rg2OY0koNaYnw3p8e9TVf4AgK60lS4bHiL3TWn3oIwd3hXdCqqJ9tqIj7SjgZQa0Lx9zWr81SRbV
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80704816-e813-4c4f-fa26-08dd5176de91
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 06:21:53.8294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z6+yKjwB9XemSjSPlztnLRi9LA/K/sMNsTWCfrWKjd1KFIYMqZG76/1frdEIhNG2/2kLzcYmKoldv+3OBs0H2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB6782
X-Proofpoint-GUID: MzOVIYA-JzmHMvD_payJf-AXTM5ilzgD
X-Proofpoint-ORIG-GUID: MzOVIYA-JzmHMvD_payJf-AXTM5ilzgD
X-Sony-Outbound-GUID: MzOVIYA-JzmHMvD_payJf-AXTM5ilzgD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_02,2025-02-20_02,2024-11-22_01

VGhlIGNhbGxiYWNrIGZ1bmN0aW9uIHN0YXRmcygpIGlzIGNhbGxlZCBvbmx5IGFmdGVyIHRoZSBm
aWxlDQpzeXN0ZW0gaXMgbW91bnRlZC4gRHVyaW5nIHRoZSBwcm9jZXNzIG9mIG1vdW50aW5nIHRo
ZSBleEZBVA0KZmlsZSBzeXN0ZW0sIHRoZSBudW1iZXIgb2YgdXNlZCBjbHVzdGVycyBoYXMgYmVl
biBjb3VudGVkLCBzbw0KdGhlIGNvbmRpdGlvbiAic2JpLT51c2VkX2NsdXN0ZXJzID09IEVYRkFU
X0NMVVNURVJTX1VOVFJBQ0tFRCINCmlzIGFsd2F5cyBmYWxzZSBhbmQgc2hvdWxkIGJlIGRlbGV0
ZWQuDQoNClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4N
Ci0tLQ0KIGZzL2V4ZmF0L2V4ZmF0X2ZzLmggfCAgMiAtLQ0KIGZzL2V4ZmF0L3N1cGVyLmMgICAg
fCAxMCAtLS0tLS0tLS0tDQogMiBmaWxlcyBjaGFuZ2VkLCAxMiBkZWxldGlvbnMoLSkNCg0KZGlm
ZiAtLWdpdCBhL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmggYi9mcy9leGZhdC9leGZhdF9mcy5oDQppbmRl
eCBkMzBjZTE4YTg4YjcuLmY4ZWFkNGQ0N2VmMCAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2V4ZmF0
X2ZzLmgNCisrKyBiL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgNCkBAIC0xNCw4ICsxNCw2IEBADQogDQog
I2RlZmluZSBFWEZBVF9ST09UX0lOTwkJMQ0KIA0KLSNkZWZpbmUgRVhGQVRfQ0xVU1RFUlNfVU5U
UkFDS0VEICh+MHUpDQotDQogLyoNCiAgKiBleGZhdCBlcnJvciBmbGFncw0KICAqLw0KZGlmZiAt
LWdpdCBhL2ZzL2V4ZmF0L3N1cGVyLmMgYi9mcy9leGZhdC9zdXBlci5jDQppbmRleCBiZDU3ODQ0
NDE0YWEuLjg0NjUwMzNhNmNmMCAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L3N1cGVyLmMNCisrKyBi
L2ZzL2V4ZmF0L3N1cGVyLmMNCkBAIC02NywxNSArNjcsNiBAQCBzdGF0aWMgaW50IGV4ZmF0X3N0
YXRmcyhzdHJ1Y3QgZGVudHJ5ICpkZW50cnksIHN0cnVjdCBrc3RhdGZzICpidWYpDQogCXN0cnVj
dCBleGZhdF9zYl9pbmZvICpzYmkgPSBFWEZBVF9TQihzYik7DQogCXVuc2lnbmVkIGxvbmcgbG9u
ZyBpZCA9IGh1Z2VfZW5jb2RlX2RldihzYi0+c19iZGV2LT5iZF9kZXYpOw0KIA0KLQlpZiAoc2Jp
LT51c2VkX2NsdXN0ZXJzID09IEVYRkFUX0NMVVNURVJTX1VOVFJBQ0tFRCkgew0KLQkJbXV0ZXhf
bG9jaygmc2JpLT5zX2xvY2spOw0KLQkJaWYgKGV4ZmF0X2NvdW50X3VzZWRfY2x1c3RlcnMoc2Is
ICZzYmktPnVzZWRfY2x1c3RlcnMpKSB7DQotCQkJbXV0ZXhfdW5sb2NrKCZzYmktPnNfbG9jayk7
DQotCQkJcmV0dXJuIC1FSU87DQotCQl9DQotCQltdXRleF91bmxvY2soJnNiaS0+c19sb2NrKTsN
Ci0JfQ0KLQ0KIAlidWYtPmZfdHlwZSA9IHNiLT5zX21hZ2ljOw0KIAlidWYtPmZfYnNpemUgPSBz
YmktPmNsdXN0ZXJfc2l6ZTsNCiAJYnVmLT5mX2Jsb2NrcyA9IHNiaS0+bnVtX2NsdXN0ZXJzIC0g
MjsgLyogY2x1IDAgJiAxICovDQpAQCAtNTMxLDcgKzUyMiw2IEBAIHN0YXRpYyBpbnQgZXhmYXRf
cmVhZF9ib290X3NlY3RvcihzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiKQ0KIAlzYmktPnZvbF9mbGFn
cyA9IGxlMTZfdG9fY3B1KHBfYm9vdC0+dm9sX2ZsYWdzKTsNCiAJc2JpLT52b2xfZmxhZ3NfcGVy
c2lzdGVudCA9IHNiaS0+dm9sX2ZsYWdzICYgKFZPTFVNRV9ESVJUWSB8IE1FRElBX0ZBSUxVUkUp
Ow0KIAlzYmktPmNsdV9zcmNoX3B0ciA9IEVYRkFUX0ZJUlNUX0NMVVNURVI7DQotCXNiaS0+dXNl
ZF9jbHVzdGVycyA9IEVYRkFUX0NMVVNURVJTX1VOVFJBQ0tFRDsNCiANCiAJLyogY2hlY2sgY29u
c2lzdGVuY2llcyAqLw0KIAlpZiAoKHU2NClzYmktPm51bV9GQVRfc2VjdG9ycyA8PCBwX2Jvb3Qt
PnNlY3Rfc2l6ZV9iaXRzIDwNCi0tIA0KMi40My4wDQoNCg==

