Return-Path: <linux-fsdevel+bounces-74013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 686B3D28AD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 22:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7258C306AE5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 21:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A9332693E;
	Thu, 15 Jan 2026 21:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g5KSRU5c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB81F322B90
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 21:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768511582; cv=fail; b=E61FwcZGAzoapEPBES9HzC1ta94KGaZEBox+ICzVqOzZ1KIQA+e5lbG9APnAxrR9CSL76hTiRmnnJJ+ibSl19UAWvrCIeR0QESbpBxo3D1wPOCA3+0OC5OhqmLQP3zStLfdD29/Wu8k5LBjCs5spaspycOtWCr9/KaY2qB6Myvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768511582; c=relaxed/simple;
	bh=Eud2q0k/X4NfDNgkNzyJR+pAUN0ggm9S3D9uk/DyciE=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=MO68Yj2wECsasWLbIxPxs91SZ2J64qoaviUakivCpdew2iO2Lslx0P3LPk20GBbb40jSxq+dxfm8Os9L1WvJZuIQF4ogRJpZbxkfow60/+Iofu3A6NWwg0zcLjhLfJ9BKyuVLIyWK1Qq7K7tkXkf9RjxwoDw4q3HhNNtY0sntmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g5KSRU5c; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60FDifZZ026893
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 21:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=5WW65F3c+eqZLZecVHdCanoIWVeBhov9XaAaiikoTp8=; b=g5KSRU5c
	7bzSUcc/OjHiI91I5Tpbs5j/4pgM1mER/GcTb+ZzFr93MaGaVMQDu4+7Ao9US8gL
	R07xiAmwJvTF8C7Gpfh9mVwBKGbw7c2eMpQww5GYY9nD4lRazqAo/LBxUlPqUNyq
	Zlbsxda5St3K7tWgetj8UggW16ovOa7IAWFzF/f5SyT22KYvoq3cuTy64zPMPvLQ
	Cxfz4a879CfUBuMoUEKAgOuNnhFxMXtyAOcc6HAY7yB/nuGnF1djYoi/+X/7cVo9
	U5TO8tIaAaoAVu6/57aqqnzESf+tvaUVKnmN/gARXPAXtyCN+A5QRT/zRlgSkzrZ
	KWxM8nVMV0KurQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkc6hgep3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 21:12:57 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60FLCv5N022329
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 21:12:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkc6hgenv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Jan 2026 21:12:56 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60FLCJKX021915;
	Thu, 15 Jan 2026 21:12:56 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkc6hgenu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Jan 2026 21:12:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkWLQSd5dvvukF3q8cgz3GssDIXqjafez3v1RxpxlnvuC+H437enUrYJSIAJ2ZvT/k9Htd3BeZ3nY3sY0sqyWCl2nJr+u22urIiM4gWF9THZS8WJJxbn2h0LVbmqLQC8mr8G+ZioOx3odwg1bhu/aLpN0Egm1JKKaFgbiJrfE87r+VwaUA4lhIvIs655S0nQfbpHbWDnOEcfpd/KJK0GSa3X0xvAQRf1EH83KkBEtMr8XHig5jIe6BYh727+gECLNnRjcGm9JptNFezF5NzrcoKUKS4bszwOQjNkfFNBNsA8l3vFOS6uy+Kl0ySmsd2B0lxsKkkQD9NbD+yfnKL06w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xE5jiJHMUieMX27b94JQFmMHpe4NCZAB5r5dkM+ZsYE=;
 b=ufiOlW4J3Q4nexcuh9UE/UyO7Bz+Ixh5ztkLsR4Ghxyq3tALEcBq2chsJUqmH4gjals+HFs2dbTPgnzoW5czfi+LyQIxbzAP2qzHcHCJvAmGXHE3+h7wcB1WgWMRcZiw6rIjMCCDyUAGIQijo861eV+n+kPw9NeaIV7gUJVepmHGriBaIC4NsuzHi126pn8VpDJInHKMPHyDFLqD/g9wwtcWLogO/GwlSsFLXmITQXp5tqcwddMgGQHP6zR5lVAbCSdiq4KMQiK6QmvRC+wGuZtdG2w4NgVMl+LtQtmQVrjPDeEfA6vRCeihCtk4pf7g4LDnhoaaYaO+br5hHJ/kkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA3PR15MB6621.namprd15.prod.outlook.com (2603:10b6:208:51f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 21:12:52 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9520.003; Thu, 15 Jan 2026
 21:12:49 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "wangjinchao600@gmail.com" <wangjinchao600@gmail.com>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "syzbot+1e3ff4b07c16ca0f6fe2@syzkaller.appspotmail.com"
	<syzbot+1e3ff4b07c16ca0f6fe2@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] Re: [RFC PATCH] fs/hfs: fix ABBA deadlock in
 hfs_mdb_commit
Thread-Index: AQHchQJlsj80quEwJ0uCe1jfsMW4jLVSDkAAgACHcICAASexAA==
Date: Thu, 15 Jan 2026 21:12:49 +0000
Message-ID: <b718505beca70f2a3c1e0e20c74e43ae558b29d5.camel@ibm.com>
References: <68b0240f.a00a0220.1337b0.0006.GAE@google.com>
	 <20260113081952.2431735-1-wangjinchao600@gmail.com>
	 <a2b8144a25206fba69e59e805d93c05444080132.camel@ibm.com>
	 <aWcHhTiUrDppotRg@ndev>
	 <d382b5c97a71d769598fd32bc22cae9f960fea70.camel@ibm.com>
	 <aWhgNujuXujxSg3E@ndev>
In-Reply-To: <aWhgNujuXujxSg3E@ndev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA3PR15MB6621:EE_
x-ms-office365-filtering-correlation-id: 8948ab59-fd93-43db-18a9-08de547ad677
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cWVTWm5jRkp5eVhDaDRlNVc4R1RpNUlPUUlnUDJaMVNCSWlvN1VlazFBUDlj?=
 =?utf-8?B?a2wybmticEFPenZTZnV6KzJvMWV6ZHd2ck9GMnA0ZHFqQVFuRE9IRUc1RjBx?=
 =?utf-8?B?cE1mWXJ6bFkzbCtXNXZubU5KVEtuQVBGbHozYUNBYjk3SWs4bFB6SFVFQ0ZL?=
 =?utf-8?B?Q3loa0I2UkpoV2NzOXJDS3BqalducmdZMVZ6WU15UlgwTWRDTkN1elh0bmdB?=
 =?utf-8?B?R2N6Tk5jUGY4UU1ZakRndWxXSzBuT0ZXQ2Jkei9MVFpzK1BwZW5rTVFUa09J?=
 =?utf-8?B?Z1FJTk1JZTl4MUxtVnBlWHVyRFd2OTNmd09BdlVBY2FnSGNZTitWbnJYQ1RE?=
 =?utf-8?B?dGpnQ3prSnhTdUpUbkFOTk9rSWhveXFwY3NjV1R6WmwzQXZwaitZV0g0UWVm?=
 =?utf-8?B?MUxaN2FzbU1vbzEyK0JTM0MwMzNBZVU1Rzc4K3VrU0cyek9Ib000dW8vVFJZ?=
 =?utf-8?B?SW9zbTB6dUZaY216blhhRnJoMTNEOC8zcFhxaXR3V0lISTdMZnJkVlR4MDdy?=
 =?utf-8?B?U0kxOE0zNkxNT2J1a1N1TUpSb0lrNzdUN0VSSlVHWmowK0xJS21hYytGQWtH?=
 =?utf-8?B?NkpBN2ZpM3VCdFZBQjdWenp2N1BpMktybUV2VkoxME4xVk81Y3Z6VWNsb0l3?=
 =?utf-8?B?SW5IV2U5UzRxcGNRa2RoRm8wVldRM2F4RFMva0RWZm1neXVSQjJEZ1gvdWFG?=
 =?utf-8?B?TXE4bS92a2ZDWk9YWGk4TzJCWFoydlJENkxIVy9JNkVtZ1MybnJlOFZqTk4x?=
 =?utf-8?B?NDJ4My8rSFgxMEVWdnorRytPVm9tSjNpcXFjWnp4QkwxWk16cS9iVVB4TGhs?=
 =?utf-8?B?TTVkNi9nK2t4bmxTSndjbDU0NUcwVURocWFlRlV4UkFISDZyb3AzR05ZSmpK?=
 =?utf-8?B?ZWJBY0tNQ2NhWmVXWWQ5NC90YlpHangrbWdOci9reS90bGdnaWRYc053K05O?=
 =?utf-8?B?SDBjN3ljTVZ2TXMwYnZzeHBaeEtCMndxa2d4NGxlL3FMSUV4VHg3YzJYM25n?=
 =?utf-8?B?MWp6UGRCOVRDcktEU3pXcWw1RDd0VHlsWG5CQ1orUnV2SWo0OGFtSzhpZFJs?=
 =?utf-8?B?MEJUZzJ2WDZwN2NpRXVVWWFhbGNWeWpmY2UrdDZtbDBmOXNNbFVlSmJJQnFJ?=
 =?utf-8?B?cVBKSHFkSGRVSTNBUW5MN3NqWlRZb3lGZXBUbGY3SyszakxmTTNUeERicTJC?=
 =?utf-8?B?aWM3QUNBOFdsd1A4bkR0dXA1UXJFZEIyRk02WWVCWVR6Rm1WQUhlNEJmME1s?=
 =?utf-8?B?UFI0NHVyZEVDV3FkY0Q2a1JLUDRnSCtnNkY2YmR4UStBaGo1eWhpUnVLOHJ5?=
 =?utf-8?B?TWtEZ1ZiSnhMRkZDQ0FRL3BnbS9BR1U0SzVwZ2oyaDg1cFhrYW96ZFNkd1ZH?=
 =?utf-8?B?Tm1mYXZ3NGlYcm93a1dCL2RkcFVPRnNtMDFlVndHd2VhT0x0V29SeHdxNTZQ?=
 =?utf-8?B?Z3pUV1EvZ29zVXpmdFA5TGxlUmt0em01akNTaWg2dEdOcE94WXRCVjNOYjEx?=
 =?utf-8?B?eXBTaXJkL1d6bDM4bkIyK2c1Rm1veEtvNlZaN3l5elNNTTExeHhDWnRza2o1?=
 =?utf-8?B?WE15cG0wVklMRVRzM0RlNXhtWm85T0lTUkFEbndlK1lyZE5YNWxjMElDbUdT?=
 =?utf-8?B?U29JV2lGTnl0V25CWlJlM2tHRjVvSFp4cEE3MDAvMXR5UlY5OXJkQ1lac29E?=
 =?utf-8?B?bTV3QTVpMUo0ZWQwN1NzNTJzM3R1MjBGUVJBZUl4Y28rM0UyQ3pUQWt0b2x6?=
 =?utf-8?B?VGZ5Z0QxZmtoK2hYaHNaMnVGMGo2SGRmWXgxcmdYcitCY3dubFhpOG0yam5n?=
 =?utf-8?B?NXlVWjJzM05IWHRqQW9nWnpKZkVXSXRHU2VVMGc3RTRSL0prTFJ5R0U3VjZ5?=
 =?utf-8?B?MFRlbFU4aVBjV084ekhlNGx1SkJiZHM4azdTaVJOQmhzSVF0aGw4bVJ5TWpS?=
 =?utf-8?B?K1pEK3NDcHBvQnZQVTdXeHgzMDF3bGV3QzNJZDdmeGpQeVVMRmNGcmZpQ05j?=
 =?utf-8?B?ak5ERWJlNEdwYis0MFpvVm1GdUVKckxkY0NEWFNZUitHWUxmbnJ6OVh4MEpR?=
 =?utf-8?B?RXM4czM5cVFLK2l4b3JvamNzcy9hVWdYWGJTUlRjWGl6d2I4K2tTOU1BQlI1?=
 =?utf-8?Q?H5ExffRv6qvBRzW+H+o3DwO/U?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?blVUSU8vaW5EbEJMRUxQTFFrc1hENmFnbmlSUW9YWUh6QWpoYmIzN2RseHdy?=
 =?utf-8?B?OHk5WTZLMjNDTVo1RUNtN0ZSZVV0b25YZVFqTnRTa2ZhYnVQb1EyU20vUTI2?=
 =?utf-8?B?U2FCVGo5aytMZHBQR1NBaFU1YlBXUyt0aldCYUFjbkpQWC9Mb2JTT0lPTy9y?=
 =?utf-8?B?Si9qQlNVTkJWZkJLNTZZQS9ydFgraE0xVjU2R25LQnAvV2pib1M5NlFITTBJ?=
 =?utf-8?B?b2IyNHJZSk81ZzZCRllVeGFkZmFIQUl4RXk3ZlNnemdBNzJJbDFGY3RnckRG?=
 =?utf-8?B?cUdNUlV0RWgyVFI4U2dqNUh2N0h4enNVL0ZicDUvdjdKcVZySm1QSm5SNXZj?=
 =?utf-8?B?dWlEWFozUGJwVXpmeFhBWEVZV3hySi9oWTgrUCt2K2pJL1N5VGV1RlJaalJp?=
 =?utf-8?B?cS81OUlpRCttUGJGMWpJaDJJZGFwSEJueXF5ZUlUUXNpSGRuS1hOamVLRUds?=
 =?utf-8?B?SW1NL1IvUGhVSUVpNVA2V3dHaUZ0bGo3T1lwSjE3bWFSVE4rSjAvZmdudXRt?=
 =?utf-8?B?Z3NUSjNyYy9kUEtKb2E0d1MvTWthU3lTSjBTZlg2SEx5czlRSWFxWEhOV2dx?=
 =?utf-8?B?N21aMThmK0J6L3pMc0wvVngvaGhNaGVMVEtvTWRHdlZQVzRCN3NIUDhsVTJk?=
 =?utf-8?B?aVViYlViK1lmVU9USmthRG0rNDZKQ3BaNDBNYUVidVY2N3puaFZzdWxsSHZN?=
 =?utf-8?B?L0lQbmRTVnRxSWJxQVdCNFhXMExCalhrWW9DMVQ0OERpV3ZOblpzb1cyNGlv?=
 =?utf-8?B?TlhsWUpFWE0yS09QcjRsUUZKekE0YzQwWjN2NEZnZ1NjSmswWTV0STg4bDgw?=
 =?utf-8?B?V0s1dFFqMXFPbTFubHAvelBSVzRoZTJkbU80cmVXcFE2NWNBSGQ4L21TUkFv?=
 =?utf-8?B?N203eVJ2ZTBmZDEvNVZCZ2I5dFhpdWM2cVRNZHZUaG5uTEthQ0I4ajBoTU94?=
 =?utf-8?B?NUVybEk0emVHdWlHNGF4L0psa1JNOSsrUWdqekNvMUpnaWkwcjkrTi9qR0xY?=
 =?utf-8?B?Szc0YkszN2IzRlFXUjRua3BqS0YwZmZBd3BVTWFHLys4elNuNlBFVlF0bFhQ?=
 =?utf-8?B?d3cycmNJRDcrMUVDZ1RCWmJlTVNrL0s3Nlp0L0tKU3J3ZUhDaXBHTmdYTWhx?=
 =?utf-8?B?MnRsbStnSkZZeFBxSTNQd2w2c2tZNXZJdnkzdkVIa1ZGVzZSb3VhSU9XSVJk?=
 =?utf-8?B?TXQ4cTQ5UWNyY09jdmVEV2srdGVQUlZ5R0RtWTE5WDdVak9WVExzTjRHb2c5?=
 =?utf-8?B?MGsycG9sRVN3Q01SS0V1WGVKQlo2UXF0aytKUmxYaGJlSk5rMjJjSmhVRmNC?=
 =?utf-8?B?YzJCRnFIR2RjNXFCNVM4RnpSUVNuVzNlaU1rS2FoZkF2SWpkWXE1WmZYN2Zp?=
 =?utf-8?B?cDVlOVBybWg3TGJJQ3hlMmtrZjlrV25XOG1FL1Jtb2Q3NmdVYU5XVUZoeFVL?=
 =?utf-8?B?eVljOEdzVHVZMTZrVVI4Q21SUFBRQkJPTHdTWk1ibzQ2Y3o5ajYrYStFWURp?=
 =?utf-8?B?UWhKL3BQUlkxdXZIMlRRd3BBdU82aDQxMWRuS0xGdFIyUFJMdkszcjh1QWFX?=
 =?utf-8?B?Rmw0UjdiVEY1VEhyWFc3b05uVU4xSlRYd2puTE5iZlVGKzdkOVJXR0hBcWR2?=
 =?utf-8?B?Z1FCT0VZY29oYVhUcXAvdHFCU2QreXFyQml2TnRUTDd0K2VQUkRxdzhCMEtl?=
 =?utf-8?B?bW5uNEVLM2lpbUp1ZTZncEJOdndzM2R4Y0l5Zk84QU1KdVdSd3J2L0hkL3Fm?=
 =?utf-8?B?MTVSSTZ6MW9NK1Q3cTRGVFBhZUwwQytzMjd4VTNuZXRiSHVWUnJXSjEvUWU4?=
 =?utf-8?B?SXZCc0dsaC9wQlpKdDRqU0k0a2poeGxHTmk0ekRyemNmaXoxeXI4VkdpMHJQ?=
 =?utf-8?B?TDhPeklqai9MS2ZrUUVMdHlSTE84Tm5yUm9aaE5WMTZ5ZmlYK1FVdDhiWjgw?=
 =?utf-8?B?azhrMnpIcjZzVkdCb3dhR1NMZHcvSHZubnhuamRjRnRDeUVuUTg1N3llQ0dw?=
 =?utf-8?B?U0VRRVI0VTJqR1NXMVJZb3FTNDlPdDgzeXNSZ0wrMTNicFQzVVZQdlZNZXNF?=
 =?utf-8?B?bHhBNU5NMHVLcWJoa1NMbGNhVCtIMlBlamdQQlVFZmJkL2FBU1VaNVFsZnVx?=
 =?utf-8?B?MkxXOGNNTURCY2xtcGdsNGQyUWFNWjI0VmR0bWhZVGt2Tm9jMlo1SmNUU2dj?=
 =?utf-8?B?M1pZYjJRbEJhb3lmU0w0bGo1NjNjdGVoQmZaMEJHLzR1RzRnVFhxOVZIaTYw?=
 =?utf-8?B?bTV5T0Jydnl4ZXJvbzZFL01aOWtiNHcvQVJUdFB5eE1yQXFrd1M4blZhWUpS?=
 =?utf-8?B?YnpsRHZnbmlNa2dQSWpVc3VSQnhocG85ZlJyZko4ajZmRlZIVllnaGs5SFlS?=
 =?utf-8?Q?0jBqmlB7PyriMQjg=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8948ab59-fd93-43db-18a9-08de547ad677
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 21:12:49.3406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o3hwHvtd+HKJcZeUqKaoBG0wLTqd/z+lYVZDJtmhj7N2X3FxNhti7vecST2mc6A4rWTIzR935Qigu0KcvRoxlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR15MB6621
X-Proofpoint-GUID: KhlXhBSpwEuYUPY6QYdOKwuVgcCs25af
X-Proofpoint-ORIG-GUID: UF3okk3-lmhSxhr4AWOOrYuYRehy2IQb
X-Authority-Analysis: v=2.4 cv=TaibdBQh c=1 sm=1 tr=0 ts=69695858 cx=c_pps
 a=cMqFfNUV/FaVxlb8CdtUVQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=P-IC7800AAAA:8 a=edf1wS77AAAA:8
 a=DLixmDBlE5_WySwybdoA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
 a=DcSpbTIhAlouE1Uv7lRv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDE2MyBTYWx0ZWRfXwpTnryE0xhq1
 5qPtvB09EsqpUkk4B2DXZeu3G8eU28wkYT1nm4zZTnj1xDAHwUy69+5O8NVxxXgEHrTwEuYTb+E
 rldNGzNrhsacYTV2fV+Ao0R7mODSDUcSaFJCSQC1M7LQILttFLe6qvAc5bil2p0dvSWXm4Wy53+
 9STXV8cQHedki3KAR785cQcmDgodCVlyTORqFUEEE14zdVJRITjW2d8JWDoXDeraitEx/aJCgFb
 7zW0Gtab2LOrRbf/0pBmN2Ny4sG+HH+SjtmXb0Wi1iCj10a6rgytV2V/doJ/awmnaMfPT9gGvs1
 BJWu0uM3LMVTZlQPS9WGUfZ3D3zSLZwN11brdkvgAKLBHE8mYGHawoRzUIUR3UVTaxcrInbN+KL
 0DW42pgEa5GkCCuiHQvtRF8FQyK1DM/AllTvSV3XANDzQU3I9aALmslnVBqWUvhyekS4ocrtW7w
 yXTfTgmx5U+GTD4UnEg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C967BA96E9B9240B3FA578A8D9B2160@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [RFC PATCH] fs/hfs: fix ABBA deadlock in hfs_mdb_commit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_06,2026-01-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=2 engine=8.19.0-2512120000
 definitions=main-2601150163

On Thu, 2026-01-15 at 11:34 +0800, Jinchao Wang wrote:
> On Wed, Jan 14, 2026 at 07:29:45PM +0000, Viacheslav Dubeyko wrote:
> > On Wed, 2026-01-14 at 11:03 +0800, Jinchao Wang wrote:
> > > On Tue, Jan 13, 2026 at 08:52:45PM +0000, Viacheslav Dubeyko wrote:
> > > > On Tue, 2026-01-13 at 16:19 +0800, Jinchao Wang wrote:
> > > > > syzbot reported a hung task in hfs_mdb_commit where a deadlock oc=
curs
> > > > > between the MDB buffer lock and the folio lock.
> > > > >=20
> > > > > The deadlock happens because hfs_mdb_commit() holds the mdb_bh
> > > > > lock while calling sb_bread(), which attempts to acquire the lock
> > > > > on the same folio.
> > > >=20
> > > > I don't quite to follow to your logic. We have only one sb_bread() =
[1] in
> > > > hfs_mdb_commit(). This read is trying to extract the volume bitmap.=
 How is it
> > > > possible that superblock and volume bitmap is located at the same f=
olio? Are you
> > > > sure? Which size of the folio do you imply here?
> > > >=20
> > > > Also, it your logic is correct, then we never could be able to moun=
t/unmount or
> > > > run any operations on HFS volumes because of likewise deadlock. How=
ever, I can
> > > > run xfstests on HFS volume.
> > > >=20
> > > > [1] https://elixir.bootlin.com/linux/v6.19-rc5/source/fs/hfs/mdb.c#=
L324   =20
> > >=20
> > > Hi Viacheslav,
> > >=20
> > > After reviewing your feedback, I realized that my previous RFC was no=
t in
> > > the correct format. It was not intended to be a final, merge-ready pa=
tch,
> > > but rather a record of the analysis and trial fixes conducted so far.
> > > I apologize for the confusion caused by my previous email.
> > >=20
> > > The details are reorganized as follows:
> > >=20
> > > - Observation
> > > - Analysis
> > > - Verification
> > > - Conclusion
> > >=20
> > > Observation
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > > Syzbot report: https://syzkaller.appspot.com/bug?extid=3D1e3ff4b07c16=
ca0f6fe2   =20
> > >=20
> > > For this version:
> > > > time             |  kernel    | Commit       | Syzkaller |
> > > > 2025/12/20 17:03 | linux-next | cc3aa43b44bd | d6526ea3  |
> > >=20
> > > Crash log: https://syzkaller.appspot.com/text?tag=3DCrashLog&x=3D1290=
9b1a580000   =20
> > >=20
> > > The report indicates hung tasks within the hfs context.
> > >=20
> > > Analysis
> > > =3D=3D=3D=3D=3D=3D=3D=3D
> > > In the crash log, the lockdep information requires adjustment based o=
n the call stack.
> > > After adjustment, a deadlock is identified:
> > >=20
> > > task syz.1.1902:8009
> > > - held &disk->open_mutex
> > > - held foio lock
> > > - wait lock_buffer(bh)
> > > Partial call trace:
> > > ->blkdev_writepages()
> > >         ->writeback_iter()
> > >                 ->writeback_get_folio()
> > >                         ->folio_lock(folio)
> > >         ->block_write_full_folio()
> > >                 __block_write_full_folio()
> > >                         ->lock_buffer(bh)
> > >=20
> > > task syz.0.1904:8010
> > > - held &type->s_umount_key#66 down_read
> > > - held lock_buffer(HFS_SB(sb)->mdb_bh);
> > > - wait folio
> > > Partial call trace:
> > > hfs_mdb_commit
> > >         ->lock_buffer(HFS_SB(sb)->mdb_bh);
> > >         ->bh =3D sb_bread(sb, block);
> > >                 ...->folio_lock(folio)
> > >=20
> > >=20
> > > Other hung tasks are secondary effects of this deadlock. The issue
> > > is reproducible in my local environment usuing the syz-reproducer.
> > >=20
> > > Verification
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > > Two patches are verified against the syz-reproducer.
> > > Neither reproduce the deadlock.
> > >=20
> > > Option 1: Removing `un/lock_buffer(HFS_SB(sb)->mdb_bh)`
> > > ------------------------------------------------------
> > >=20
> > > diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> > > index 53f3fae60217..c641adb94e6f 100644
> > > --- a/fs/hfs/mdb.c
> > > +++ b/fs/hfs/mdb.c
> > > @@ -268,7 +268,6 @@ void hfs_mdb_commit(struct super_block *sb)
> > >         if (sb_rdonly(sb))
> > >                 return;
> > >=20
> > > -       lock_buffer(HFS_SB(sb)->mdb_bh);
> > >         if (test_and_clear_bit(HFS_FLG_MDB_DIRTY, &HFS_SB(sb)->flags)=
) {
> > >                 /* These parameters may have been modified, so write =
them back */
> > >                 mdb->drLsMod =3D hfs_mtime();
> > > @@ -340,7 +339,6 @@ void hfs_mdb_commit(struct super_block *sb)
> > >                         size -=3D len;
> > >                 }
> > >         }
> > > -       unlock_buffer(HFS_SB(sb)->mdb_bh);
> > >  }
> > >=20
> > >=20
> > > Options 2: Moving `unlock_buffer(HFS_SB(sb)->mdb_bh)`
> > > --------------------------------------------------------
> > >=20
> > > diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> > > index 53f3fae60217..ec534c630c7e 100644
> > > --- a/fs/hfs/mdb.c
> > > +++ b/fs/hfs/mdb.c
> > > @@ -309,6 +309,7 @@ void hfs_mdb_commit(struct super_block *sb)
> > >                 sync_dirty_buffer(HFS_SB(sb)->alt_mdb_bh);
> > >         }
> > > =20
> > > +       unlock_buffer(HFS_SB(sb)->mdb_bh);
> > >         if (test_and_clear_bit(HFS_FLG_BITMAP_DIRTY, &HFS_SB(sb)->fla=
gs)) {
> > >                 struct buffer_head *bh;
> > >                 sector_t block;
> > > @@ -340,7 +341,6 @@ void hfs_mdb_commit(struct super_block *sb)
> > >                         size -=3D len;
> > >                 }
> > >         }
> > > -       unlock_buffer(HFS_SB(sb)->mdb_bh);
> > >  }
> > >=20
> > > Conclusion
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > > The analysis and verification confirms that the hung tasks are caused=
 by
> > > the deadlock between `lock_buffer(HFS_SB(sb)->mdb_bh)` and `sb_bread(=
sb, block)`.
> >=20
> > First of all, we need to answer this question: How is it
> > possible that superblock and volume bitmap is located at the same folio=
 or
> > logical block? In normal case, the superblock and volume bitmap should =
not be
> > located in the same logical block. It sounds to me that you have corrup=
ted
> > volume and this is why this logic [1] finally overlap with superblock l=
ocation:
> >=20
> > block =3D be16_to_cpu(HFS_SB(sb)->mdb->drVBMSt) + HFS_SB(sb)->part_star=
t;
> > off =3D (block << HFS_SECTOR_SIZE_BITS) & (sb->s_blocksize - 1);
> > block >>=3D sb->s_blocksize_bits - HFS_SECTOR_SIZE_BITS;
> >=20
> > I assume that superblock is corrupted and the mdb->drVBMSt [2] has inco=
rrect
> > metadata. As a result, we have this deadlock situation. The fix should =
be not
> > here but we need to add some sanity check of mdb->drVBMSt somewhere in
> > hfs_fill_super() workflow.
> >=20
> > Could you please check my vision?
> >=20
> > Thanks,
> > Slava.
> >=20
> > [1] https://elixir.bootlin.com/linux/v6.19-rc5/source/fs/hfs/mdb.c#L318=
 =20
> > [2]
> > https://elixir.bootlin.com/linux/v6.19-rc5/source/include/linux/hfs_com=
mon.h#L196 =20
>=20
> Hi Slava,
>=20
> I have traced the values during the hang. Here are the values observed:
>=20
> - MDB: blocknr=3D2
> - Volume Bitmap (drVBMSt): 3
> - s_blocksize: 512 bytes
>=20
> This confirms a circular dependency between the folio lock and
> the buffer lock. The writeback thread holds the 4KB folio lock and=20
> waits for the MDB buffer lock (block 2). Simultaneously, the HFS sync=20
> thread holds the MDB buffer lock and waits for the same folio lock=20
> to read the bitmap (block 3).
>=20
>=20
> Since block 2 and block 3 share the same folio, this locking=20
> inversion occurs. I would appreciate your thoughts on whether=20
> hfs_fill_super() should validate drVBMSt to ensure the bitmap=20
> does not reside in the same folio as the MDB.


As far as I can see, I can run xfstest on HFS volume (for example, generic/=
001
has been finished successfully):

sudo ./check -g auto -E ./my_exclude.txt=20
FSTYP         -- hfs
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.19.0-rc1+ #56 SMP
PREEMPT_DYNAMIC Thu Jan 15 12:55:22 PST 2026
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/001 36s ...  36s

2026-01-15T13:00:07.589868-08:00 hfsplus-testing-0001 kernel: run fstests
generic/001 at 2026-01-15 13:00:07
2026-01-15T13:00:07.661605-08:00 hfsplus-testing-0001 systemd[1]: Started
fstests-generic-001.scope - /usr/bin/bash -c "test -w /proc/self/oom_score_=
adj
&& echo 250 > /proc/self/oom_score_adj; exec ./tests/generic/001".
2026-01-15T13:00:13.355795-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():296 HFS_SB(sb)->mdb_bh buffer has been locked
2026-01-15T13:00:13.355809-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():348 drVBMSt 3, part_start 0, off 0, block 3, size 8167
2026-01-15T13:00:13.355810-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.355810-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.355811-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.355812-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.355812-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.355812-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.355813-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.355813-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.355813-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.355814-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.355814-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.355815-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.355815-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.355815-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.355816-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.355816-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.355816-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.355816-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.355817-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.355818-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.355818-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.355818-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.355819-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.355819-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.355819-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.355819-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.355820-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.355820-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.355821-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.355821-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.355821-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.355822-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.355822-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():383 HFS_SB(sb)->mdb_bh buffer has been unlocked
2026-01-15T13:00:13.681527-08:00 hfsplus-testing-0001 systemd[1]: fstests-
generic-001.scope: Deactivated successfully.
2026-01-15T13:00:13.681597-08:00 hfsplus-testing-0001 systemd[1]: fstests-
generic-001.scope: Consumed 5.928s CPU time.
2026-01-15T13:00:13.714928-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():296 HFS_SB(sb)->mdb_bh buffer has been locked
2026-01-15T13:00:13.714942-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():348 drVBMSt 3, part_start 0, off 0, block 3, size 8167
2026-01-15T13:00:13.714943-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.714944-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.714944-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.714944-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.714945-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.714945-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.714946-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.714946-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.714947-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.714947-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.714947-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.714948-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.714948-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.714948-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.714949-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.714949-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.714950-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.714950-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.714950-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.714951-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.714951-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.714952-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.714952-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.714952-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.714953-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.714953-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.714953-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.714954-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.714954-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.714955-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.714955-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():356 start read volume bitmap block
2026-01-15T13:00:13.714955-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():370 volume bitmap block has been read and copied
2026-01-15T13:00:13.714956-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():383 HFS_SB(sb)->mdb_bh buffer has been unlocked
2026-01-15T13:00:13.716742-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():296 HFS_SB(sb)->mdb_bh buffer has been locked
2026-01-15T13:00:13.716754-08:00 hfsplus-testing-0001 kernel: hfs:
hfs_mdb_commit():383 HFS_SB(sb)->mdb_bh buffer has been unlocked
2026-01-15T13:00:13.722184-08:00 hfsplus-testing-0001 systemd[1]: mnt-
test.mount: Deactivated successfully.

And I don't see any issues with locking into the added debug output. I don'=
t see
the reproduction of reported deadlock. And the logic of hfs_mdb_commit() co=
rrect
enough.

The main question is: how blkdev_writepages() can collide with hfs_mdb_comm=
it()?
I assume that blkdev_writepages() is trying to flush the user data. So, wha=
t is
the problem here? Is it allocation issue? Does it mean that some file was n=
ot
properly allocated? Or does it mean that superblock commit somehow collided=
 with
user data flush? But how does it possible? Which particular workload could =
have
such issue?

Currently, your analysis doesn't show what problem is and how it is happene=
d.=20

Thanks,
Slava.

