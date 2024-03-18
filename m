Return-Path: <linux-fsdevel+bounces-14702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6423687E2F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 06:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B24DB21632
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 05:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8F920DE8;
	Mon, 18 Mar 2024 05:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="XqsnwV9h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8327F20B0F
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 05:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710739320; cv=fail; b=f2NBJMCeQG4NBFtMJHnWNt4gPGH/lvE8mhWLJKZY5y6LIlk5nq8wGeVLhYoavu2cXhcdJx9XFvJCj9uOjLnwYynp8i1M7RUzBjl27Y0B47qjfhSIBUROddSN1NGVrgHxPLR7NbUJz8dyefDxZK13AJZbA/KRFSmHXh2Xw2RHLX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710739320; c=relaxed/simple;
	bh=PnMJitd6KqA1dBq18vmCdBFleL6RXGlCR5nD6Zl5XfM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HpdLQdT3lknqKzk4J0zI0GsdJTuNTkFoJHAlPufxxG4ImOZkFwrsJzW8LdxjXOgvF/9nxNZXNXDnWss0HHkj6X4Yv682S8QCQj1TXbw5FzERs7iSPP3YGIAWPNMpgdbMB0zCqq3f6vgQwztOqLuyEjl1TF61aLJ1AGwTKnuT0dE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=XqsnwV9h; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209328.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42I1sKIr014434;
	Mon, 18 Mar 2024 05:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=PnMJitd6KqA1dBq18vmCdBFleL6RXGlCR5nD6Zl5XfM=;
 b=XqsnwV9h1LjrMagcubu7BisjE/iJYk1mAKraGjJcwo1XIRBD7kulvx53gLLXHzz/blbL
 OHpLYtY9HeZbNdAbn20e8wLTg6yUgt3YPFwMF8qTv07j3xxGgMI6KXB7NR54BtTaVQDZ
 Fb538Zq2x9ZOxtQpPnr+Ze8ORCc7FyzUay2PBdoXG/dXJTWnfyps6tMFkegwWZuK6H8Q
 DN4FLmj+FfZsFY1lH4635IzNMeftSK5BTq82jaJOWYU0cn5JxvdTHSMgRZQwPNKsRUSq
 wnuGy9qd47XEtAXnHbzH0+S+0ruQxZuj/hQ0BcpzTKRf33ozqKDWWt5V84njjCHiWld5 zg== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2041.outbound.protection.outlook.com [104.47.26.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3ww4km9n0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 05:21:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJHOjadUYZPhCEtrmPtL96B7wOhBiJhrzUX0APRz2RRfjkKJiAArC8lmkSsaSwhKuYj8Ti/Lk4hpg+oedi3psn72EsCCFw5JFKErzjKdvzZALknd+tON5sD+Ys7Wbe/PqQHbXoUeyeCx1RVfQMULLDMOHB4kjaCHcWx3dRIG3U+D3EArLpnX5rqQB4pPU/qZIH7YCGsinkBdpUJQ6uWYja8ds4crEl5Upye7hB2Er+lXXhTtnlUdbgh0BlUEKvoU0BSvHxbsMldpF0XiXJ0zL8VQKgdl0EJfm1gFmwZPXomiViX2Vyr0iWQzoJcUO0eFi+NijmcLt6ez9egOagHAOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnMJitd6KqA1dBq18vmCdBFleL6RXGlCR5nD6Zl5XfM=;
 b=n2BQkx2jOhE3R8FAojCoDU5ZO8wfETLgd8capOyUp+3OAYnFrsMXNhfLVndadYXmgUwIpb3xPp9ceaa6zsrm+SYJQa0g0jzFykEQIx3auYMJ8e/0j8EFjBV+mVwuiCG6+T4xPgvgE8pVXIm9LMZSS8x3gM6DbnwUsFtAh85/jNk9UK0v177mGunMEgOcmr42uU77NWYHADIT0vkyWjkOCMqgKMWl+Q0eEsj/M4m1WK7amAaX5KfZNy3wHW2H5kVAhFSCzUvnRRHji0opwNN3HFC44Ng6Z0iaj11W2t/4Hnb5YAwRmshRdXWeDMZQxZ4inWW/V7be5ujvWld8Jk2jaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SI2PR04MB5895.apcprd04.prod.outlook.com (2603:1096:4:1eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 05:21:40 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::7414:91e1:bb61:1c8d]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::7414:91e1:bb61:1c8d%7]) with mapi id 15.20.7386.022; Mon, 18 Mar 2024
 05:21:40 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v4 02/10] exfat: add exfat_get_empty_dentry_set() helper
Thread-Topic: [PATCH v4 02/10] exfat: add exfat_get_empty_dentry_set() helper
Thread-Index: AdoLEwb381t7blsHTr6+hyR/PEn/jRt3t2MQ
Date: Mon, 18 Mar 2024 05:21:40 +0000
Message-ID: 
 <PUZPR04MB6316A5E007FB6E09A145D9B4812D2@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SI2PR04MB5895:EE_
x-ms-office365-filtering-correlation-id: 3216dccd-49c8-49a6-8143-08dc470b4aee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 6pRgIrsGfstv4CXml3iBtaT78PbxnfD8mISdhirY13UyrSC/y0dh8TZ42RTUaSsymgNH3M7sjrF3iOc+IIMN12AevPWgA5oDroOqEdtzG2HPdV/6hDmDtRj4Hf5hS1G3T7vsnlneSEfZOPOiX02xwcIdh3jfSCBsU9pZ2+8Qlxvp/ZeVVizLoRKn1KaRXiims6Or/7Mf89B9pQiF5/TorMPGY+hq1oIrwGJPhRNbGrSraLVNXXJ7Zis15eeD7JBgGHnus1Ey4QUYocSi4UojgmmJ7P2TcEwfigaSrItkksdlYzvOKCN5SrvwLaSyyRZj2eNuin9LYfju8n5CDVqMHbJYxLPwiPuSxUNNrGRd06QvGIBjxyp9ab397bv+lHSVcpInVlgCTFQUYeU7U8iquEOBlHIJaOet/kwu4bds8qZd3UpE9UotbLG4FnqYwnhv3LDx4iGMMF6wJskvpXUGhmn8zdU5RYkafgP4+AqQMCb3sbjr+SAKmixrOGaobSvxt1+gpkeTH5irtLvxX2KsEpFSiF6YTTbG2myp7ZfLmB6d30RdX6Pf2jYNGvarVNv1ymC/e/3qGavVj7qXjLUn6OCzZxNwGMxclVkoKF6MkDTbToXaiOs45JeEcX9OvCVTml2+bAELf2H3dwWbZCNKse2XkCFDoijJg3ftSd6D0KLOq920cxsj0AesERg9AsB8JEsi3TLb1l/okS3dCv8tnLVNTUOR9qeMhSiG9NZSxBA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UUFWWWNFM3I2WXJadXRwLzRhdnRrNHVmQWhCQnpoaXpUY1N1cmtkVlI0YzZn?=
 =?utf-8?B?SCtnL21UQnFtMmh1VTNlN293RVlHZFowUkFIdXk4Zk1aOW5QTGw4ZkFSQVZC?=
 =?utf-8?B?OVY5UHFJdTltcVlzMTZySEhSMHJaWjhGOWI2cEhEalRoSE5JdnVZSXRVS0Zn?=
 =?utf-8?B?RTFYVXZGZ2wvRGZJOEtwQmVTNFR1VHdhTDF4TklPbW5YNTRYSEl6UksvdWJj?=
 =?utf-8?B?cVN5L3RWaDdxM29PekVRRnFsSGVuQ1hWMGk4Lzl3MGtBbGM4elFJWkJ2MGFV?=
 =?utf-8?B?ck9YeWVZRHQyek0vdkNkSDZyeW5TdU5HUWJuaXBqV3pZQ09hWDkzZ2pIN0xu?=
 =?utf-8?B?U1dEU3A3RTRzZm1kZEdQMnZJSEJGL0ZnbVd2RHIrY29KQ0t6cjE0MGZtVjZt?=
 =?utf-8?B?dk5KbWRLYmx3M1JxNE1FRmxBTjJHaTJaNlB4V3kzM3U2bzV1c0dNUTV5NUxv?=
 =?utf-8?B?bEtCYThqeXhjTlpuM082cGdWSkl3b0NVY0k4TkRYcFJML081ak1oUDNiZHVw?=
 =?utf-8?B?VzRoZFVQakN6bkIxWkZybHdtUXRaVG5tVDY5N3YvN3JDOTEwZGJnUzdiWXAr?=
 =?utf-8?B?UmZZbXZ6TCs2dDhHMk1DQWg1amZ6ay9aWS95Ym8zVzdMQnNia3E4NXo0SFZv?=
 =?utf-8?B?WjhwNk9TNkFKT3c3MnRSRWpCNDl6RGVlbk9pR2VzUC9FQWtoTEJqVzJHc2N1?=
 =?utf-8?B?OEtXWVdrVVU0bHNsNGlJejBYSmlTWFZuZFdlVW9jWW54WDZmV25NeDY2aEc5?=
 =?utf-8?B?YzgxaENDSlFvTVUzVncrTTlaM3A4NGxOcFdDTGFtL3lVVDF2eXg4OVZzV0lU?=
 =?utf-8?B?cDhNN0JTS1VDSjlYZzBRRFNBYzMzRTNQTXI1NkgwenF6c0E5aWd6bzAzNmls?=
 =?utf-8?B?MEhRYnEwNnJGR082bDRxVmxoQXNld2tXOUFJVWVuL0JucUZKdDUrbkErSmRh?=
 =?utf-8?B?UjdnT2ZmNnFTM0IzMHMrQlkyWlhpUDdPeDdyRk1DbEs5ZE0xV1ZsVlhrd2RG?=
 =?utf-8?B?NEhPWXR0VnZNZldBTlpXaXZVOHZwaFRJQ0NhVXJUWi95Zk8vSmZxUUZ1RnEv?=
 =?utf-8?B?UWFkd3J4SlM4VjJjUFdpMHVjeDB2YlFLZmJNcjRiZ0s0QzVBOHZmMWVROU9l?=
 =?utf-8?B?b1ZCaW10OEhialZLR2ZDYnVKbThOZE9CSERPKytQaHNnRnlCZkFkczhnT1ZX?=
 =?utf-8?B?Q1d0RUhaQ25yWERseURCSW50a09TMmducHQrcnpla0tSYWtxclhyL29UMnIw?=
 =?utf-8?B?VEd1K0tBMFhyZVE1VFc3TGFaNTdJYVBQMHJVZXZFRjZzOUZseHBYeXpuVUFN?=
 =?utf-8?B?cEV4VDZhdjlwbThzOHhYaWlQcWQ1dEV0MXUvL3NsTEJGQ3RGeWVlakg4eEFu?=
 =?utf-8?B?dk93RCtvRVI2UGROeHdhcTVQK0hvZHM3d2xrcFl6MkdqeGo3YU5LazNVS3Iv?=
 =?utf-8?B?eS9GNnZrYjQ5cU14bTdtZjJ3Tzhnb2FpNEFnKzBOdVZxTWxVVGFGQk1wY3pk?=
 =?utf-8?B?UHJTWkZyWTluMXpUZFdkL0ZRbW11OVlYMm9qQnJYdjhucjhFbTZ1ZjhNOHVW?=
 =?utf-8?B?M0lrRmdQTHZYQTl2SHA2TnVDUGZnUEw4RExWZHpBNDBxZUJtWmxONy91S21X?=
 =?utf-8?B?WE5XSEpBL2J5RjU0ZWppOEh5MThKV2F6QmFTRmNic3lFMW0raDJoVWNDYzI5?=
 =?utf-8?B?cWYvTFp5bjVSUTNsdHN5V3ZuN2l3YVdxbWJHdVNnWTJGZnU1MjlUeHd1YjM5?=
 =?utf-8?B?bGdHLzhvNFM1VGx5VnF6VXc2T3JZMTNwRnBlYW1QTEI0aDJmTHZzUVZlOXpW?=
 =?utf-8?B?UXpIMVZBOFBZWVh5SEN0L25LNUFRV3U1VzI2blErWjBNcUtDNWVOeVBJaC9t?=
 =?utf-8?B?SXNrNlpEZXgxSnIrTFlEekZsU0FUZGt3UHZDRWtqaklXbU0rU3RvODFzQnEv?=
 =?utf-8?B?R2tFK211WWZlUDFaWmhqMUhhR2gyZ3BxU3VRMkY4MUYySzFBZkJDQm8vbUIv?=
 =?utf-8?B?b3lpbnk1TWh4UlUya0JnbFNhOEJsdXhCdW5QNTFEbVVMNm5UL2FUZWJ3NVJn?=
 =?utf-8?B?SkZmMUpXRW5Uam9hRnhGR293a3Q3eVJsTTEzTkhwdW5RUTNsc2syRmR6Q3dW?=
 =?utf-8?Q?ohw8EFIzbI+5HRKc33qS4QQzu?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	usca9gYycQNTA7YFWFYaY+1B+2C/jzgHuvUCiMFXwYfiGLZqOk/JGqT0A2jQ1fFtqPtRiZyDo4VdF1JDOmyrJ968sIeafHTzXJhJGdKguG8FgjzaeJaWFb2AQZPchDELofS9ufmLzENlxK4ogAwCju8e0W5C0OHJSdU2nX95d8RGp7838dMc0WvCJmKRCqNqxbakP63LBUfrB2zd8qycx37FKab+1lWv2LPPe2A/ELGeh5qvt3sSqhq5QzP6hCzm0cw2KkkSNoRkPN8cW76wppII3SBFNzHlCNQB8G80u5SqmdROZjIlOkjxTsvXEBChj8UOMLMJLoX61CdWN0eDOOMOnKiTAir4mInFy/L4YDRNabiVc/8551MfAcuz1oQiv9y/lDbtD/dNREt5A3Ft/JPGnbNGdNoS3/QGXzHRX9y69zZUK2VzeX594rYg2ee3ExP3mePm5NSBdYakRgP0ARlEO7AbGIcF2sqxWIJmIZzOPLe9IYeaJ2BExIfLJAxYce9aOni6J2hbV1v9Uycl+NILpkZ9010ptjQuSg6icvC3QCW22HqxX6N5iey65Pp0SxEp6mXhpnEK76Zpxalys6suaXDz4lgpRoxhlTC8GFWVK+kwRsi1zrU8NHWPcBly
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3216dccd-49c8-49a6-8143-08dc470b4aee
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 05:21:40.6981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZEzaErxHnN2gBqRZT1A3h/XBJce1NbiZxjrmDLkCbRUxCmgDSYsXb8YmrrJgp37hzcR03Jqw/dnzqpCTZh2ZcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB5895
X-Proofpoint-GUID: aN6G09HUgux5632t1PD3E3vWwIeZd7UD
X-Proofpoint-ORIG-GUID: aN6G09HUgux5632t1PD3E3vWwIeZd7UD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: aN6G09HUgux5632t1PD3E3vWwIeZd7UD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-15_01,2023-05-22_02

VGhpcyBoZWxwZXIgaXMgdXNlZCB0byBsb29rdXAgZW1wdHkgZGVudHJ5IHNldC4gSWYgdGhlcmUg
YXJlDQpubyBlbm91Z2ggZW1wdHkgZGVudHJpZXMgYXQgdGhlIGlucHV0IGxvY2F0aW9uLCB0aGlz
IGhlbHBlciB3aWxsDQpyZXR1cm4gdGhlIG51bWJlciBvZiBkZW50cmllcyB0aGF0IG5lZWQgdG8g
YmUgc2tpcHBlZCBmb3IgdGhlDQpuZXh0IGxvb2t1cC4NCg0KU2lnbmVkLW9mZi1ieTogWXVlemhh
bmcgTW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IEFuZHkgV3UgPEFuZHku
V3VAc29ueS5jb20+DQpSZXZpZXdlZC1ieTogQW95YW1hIFdhdGFydSA8d2F0YXJ1LmFveWFtYUBz
b255LmNvbT4NClJldmlld2VkLWJ5OiBTdW5nam9uZyBTZW8gPHNqMTU1Ny5zZW9Ac2Ftc3VuZy5j
b20+DQpTaWduZWQtb2ZmLWJ5OiBOYW1qYWUgSmVvbiA8bGlua2luamVvbkBrZXJuZWwub3JnPg0K
LS0tDQogZnMvZXhmYXQvZGlyLmMgICAgICB8IDc5ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KIGZzL2V4ZmF0L2V4ZmF0X2ZzLmggfCAgMyArKw0KIDIgZmls
ZXMgY2hhbmdlZCwgODIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvZGly
LmMgYi9mcy9leGZhdC9kaXIuYw0KaW5kZXggNTQzYjAxYTU0NzllLi5lMjI4Y2RmY2M5YzkgMTAw
NjQ0DQotLS0gYS9mcy9leGZhdC9kaXIuYw0KKysrIGIvZnMvZXhmYXQvZGlyLmMNCkBAIC05NTIs
NiArOTUyLDg1IEBAIGludCBleGZhdF9nZXRfZGVudHJ5X3NldChzdHJ1Y3QgZXhmYXRfZW50cnlf
c2V0X2NhY2hlICplcywNCiAJcmV0dXJuIC1FSU87DQogfQ0KIA0KK3N0YXRpYyBpbnQgZXhmYXRf
dmFsaWRhdGVfZW1wdHlfZGVudHJ5X3NldChzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0X2NhY2hlICpl
cykNCit7DQorCXN0cnVjdCBleGZhdF9kZW50cnkgKmVwOw0KKwlzdHJ1Y3QgYnVmZmVyX2hlYWQg
KmJoOw0KKwlpbnQgaSwgb2ZmOw0KKwlib29sIHVudXNlZF9oaXQgPSBmYWxzZTsNCisNCisJLyoN
CisJICogT05MWSBVTlVTRUQgT1IgREVMRVRFRCBERU5UUklFUyBBUkUgQUxMT1dFRDoNCisJICog
QWx0aG91Z2ggaXQgdmlvbGF0ZXMgdGhlIHNwZWNpZmljYXRpb24gZm9yIGEgZGVsZXRlZCBlbnRy
eSB0bw0KKwkgKiBmb2xsb3cgYW4gdW51c2VkIGVudHJ5LCBzb21lIGV4RkFUIGltcGxlbWVudGF0
aW9ucyBjb3VsZCB3b3JrDQorCSAqIGxpa2UgdGhpcy4gVGhlcmVmb3JlLCB0byBpbXByb3ZlIGNv
bXBhdGliaWxpdHksIGxldCdzIGFsbG93IGl0Lg0KKwkgKi8NCisJZm9yIChpID0gMDsgaSA8IGVz
LT5udW1fZW50cmllczsgaSsrKSB7DQorCQllcCA9IGV4ZmF0X2dldF9kZW50cnlfY2FjaGVkKGVz
LCBpKTsNCisJCWlmIChlcC0+dHlwZSA9PSBFWEZBVF9VTlVTRUQpIHsNCisJCQl1bnVzZWRfaGl0
ID0gdHJ1ZTsNCisJCX0gZWxzZSBpZiAoIUlTX0VYRkFUX0RFTEVURUQoZXAtPnR5cGUpKSB7DQor
CQkJaWYgKHVudXNlZF9oaXQpDQorCQkJCWdvdG8gZXJyX3VzZWRfZm9sbG93X3VudXNlZDsNCisJ
CQlpKys7DQorCQkJZ290byBjb3VudF9za2lwX2VudHJpZXM7DQorCQl9DQorCX0NCisNCisJcmV0
dXJuIDA7DQorDQorZXJyX3VzZWRfZm9sbG93X3VudXNlZDoNCisJb2ZmID0gZXMtPnN0YXJ0X29m
ZiArIChpIDw8IERFTlRSWV9TSVpFX0JJVFMpOw0KKwliaCA9IGVzLT5iaFtFWEZBVF9CX1RPX0JM
SyhvZmYsIGVzLT5zYildOw0KKw0KKwlleGZhdF9mc19lcnJvcihlcy0+c2IsDQorCQkiaW4gc2Vj
dG9yICVsbGQsIGRlbnRyeSAlZCBzaG91bGQgYmUgdW51c2VkLCBidXQgMHgleCIsDQorCQliaC0+
Yl9ibG9ja25yLCBvZmYgPj4gREVOVFJZX1NJWkVfQklUUywgZXAtPnR5cGUpOw0KKw0KKwlyZXR1
cm4gLUVJTzsNCisNCitjb3VudF9za2lwX2VudHJpZXM6DQorCWVzLT5udW1fZW50cmllcyA9IEVY
RkFUX0JfVE9fREVOKEVYRkFUX0JMS19UT19CKGVzLT5udW1fYmgsIGVzLT5zYikgLSBlcy0+c3Rh
cnRfb2ZmKTsNCisJZm9yICg7IGkgPCBlcy0+bnVtX2VudHJpZXM7IGkrKykgew0KKwkJZXAgPSBl
eGZhdF9nZXRfZGVudHJ5X2NhY2hlZChlcywgaSk7DQorCQlpZiAoSVNfRVhGQVRfREVMRVRFRChl
cC0+dHlwZSkpDQorCQkJYnJlYWs7DQorCX0NCisNCisJcmV0dXJuIGk7DQorfQ0KKw0KKy8qDQor
ICogR2V0IGFuIGVtcHR5IGRlbnRyeSBzZXQuDQorICoNCisgKiBpbjoNCisgKiAgIHNiK3BfZGly
K2VudHJ5OiBpbmRpY2F0ZXMgdGhlIGVtcHR5IGRlbnRyeSBsb2NhdGlvbg0KKyAqICAgbnVtX2Vu
dHJpZXM6IHNwZWNpZmllcyBob3cgbWFueSBlbXB0eSBkZW50cmllcyBzaG91bGQgYmUgaW5jbHVk
ZWQuDQorICogb3V0Og0KKyAqICAgZXM6IHBvaW50ZXIgb2YgZW1wdHkgZGVudHJ5IHNldCBvbiBz
dWNjZXNzLg0KKyAqIHJldHVybjoNCisgKiAgIDAgIDogb24gc3VjY2Vzcw0KKyAqICAgPjAgOiB0
aGUgZGVudHJpZXMgYXJlIG5vdCBlbXB0eSwgdGhlIHJldHVybiB2YWx1ZSBpcyB0aGUgbnVtYmVy
IG9mDQorICogICAgICAgIGRlbnRyaWVzIHRvIGJlIHNraXBwZWQgZm9yIHRoZSBuZXh0IGxvb2t1
cC4NCisgKiAgIDwwIDogb24gZmFpbHVyZQ0KKyAqLw0KK2ludCBleGZhdF9nZXRfZW1wdHlfZGVu
dHJ5X3NldChzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0X2NhY2hlICplcywNCisJCXN0cnVjdCBzdXBl
cl9ibG9jayAqc2IsIHN0cnVjdCBleGZhdF9jaGFpbiAqcF9kaXIsDQorCQlpbnQgZW50cnksIHVu
c2lnbmVkIGludCBudW1fZW50cmllcykNCit7DQorCWludCByZXQ7DQorDQorCXJldCA9IF9fZXhm
YXRfZ2V0X2RlbnRyeV9zZXQoZXMsIHNiLCBwX2RpciwgZW50cnksIG51bV9lbnRyaWVzKTsNCisJ
aWYgKHJldCA8IDApDQorCQlyZXR1cm4gcmV0Ow0KKw0KKwlyZXQgPSBleGZhdF92YWxpZGF0ZV9l
bXB0eV9kZW50cnlfc2V0KGVzKTsNCisJaWYgKHJldCkNCisJCWV4ZmF0X3B1dF9kZW50cnlfc2V0
KGVzLCBmYWxzZSk7DQorDQorCXJldHVybiByZXQ7DQorfQ0KKw0KIHN0YXRpYyBpbmxpbmUgdm9p
ZCBleGZhdF9yZXNldF9lbXB0eV9oaW50KHN0cnVjdCBleGZhdF9oaW50X2ZlbXAgKmhpbnRfZmVt
cCkNCiB7DQogCWhpbnRfZmVtcC0+ZWlkeCA9IEVYRkFUX0hJTlRfTk9ORTsNCmRpZmYgLS1naXQg
YS9mcy9leGZhdC9leGZhdF9mcy5oIGIvZnMvZXhmYXQvZXhmYXRfZnMuaA0KaW5kZXggMDM3ZTg4
MjdhNTZmLi5jNmY2ODRiZjdiOTIgMTAwNjQ0DQotLS0gYS9mcy9leGZhdC9leGZhdF9mcy5oDQor
KysgYi9mcy9leGZhdC9leGZhdF9mcy5oDQpAQCAtNTAyLDYgKzUwMiw5IEBAIHN0cnVjdCBleGZh
dF9kZW50cnkgKmV4ZmF0X2dldF9kZW50cnlfY2FjaGVkKHN0cnVjdCBleGZhdF9lbnRyeV9zZXRf
Y2FjaGUgKmVzLA0KIGludCBleGZhdF9nZXRfZGVudHJ5X3NldChzdHJ1Y3QgZXhmYXRfZW50cnlf
c2V0X2NhY2hlICplcywNCiAJCXN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHN0cnVjdCBleGZhdF9j
aGFpbiAqcF9kaXIsIGludCBlbnRyeSwNCiAJCXVuc2lnbmVkIGludCBudW1fZW50cmllcyk7DQor
aW50IGV4ZmF0X2dldF9lbXB0eV9kZW50cnlfc2V0KHN0cnVjdCBleGZhdF9lbnRyeV9zZXRfY2Fj
aGUgKmVzLA0KKwkJc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgc3RydWN0IGV4ZmF0X2NoYWluICpw
X2RpciwgaW50IGVudHJ5LA0KKwkJdW5zaWduZWQgaW50IG51bV9lbnRyaWVzKTsNCiBpbnQgZXhm
YXRfcHV0X2RlbnRyeV9zZXQoc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsIGludCBz
eW5jKTsNCiBpbnQgZXhmYXRfY291bnRfZGlyX2VudHJpZXMoc3RydWN0IHN1cGVyX2Jsb2NrICpz
Yiwgc3RydWN0IGV4ZmF0X2NoYWluICpwX2Rpcik7DQogDQotLSANCjIuMzQuMQ0KDQo=

