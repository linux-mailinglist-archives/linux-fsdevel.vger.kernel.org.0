Return-Path: <linux-fsdevel+bounces-74517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB9AD3B538
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 19:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39666301EA38
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 18:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7362932D7FB;
	Mon, 19 Jan 2026 18:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zc/NBfGu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8471EE00A
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 18:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768846164; cv=fail; b=dZiMrXylppZqcB0hW5jSs2USOpX5KUCwnBDUE+SSXWPAI3dC2Ft0QP/yrIfpKQBD+plvYKID1C/JRJx9mlM2Uv1dut6Qa0gKa08SWs8c3DINehPelDaWyycpiBQFIOyB+CfWuNx7YhcpPcf04rSEbtBTvhXN90xgbkjAchTvnBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768846164; c=relaxed/simple;
	bh=bj1fG3YicjoHw07wVt5PlTu95a1vuTHjXQNaL1SC5Is=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=flUVODZCH4JtVfJwmG82LFXfvK5F0UK8kKNuCkUB/iS9jgmjbucV4IJ6ysJyqtRaz8OYh34K8D4cVQltnZAR31sDP7FmmpfcJDGX/lx8UC3IHMytRjC0+8m2SZfIp1vxSQZLkiYpDbx/aE0mObbImsJb1YpAh7dH1Cgz9FAZBtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zc/NBfGu; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60JDbeet027362
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 18:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=jVEapGOEX/Ux5jOvznqbQmKqU0Pl9REgaoYBpeqVfec=; b=Zc/NBfGu
	/iLkRgv+DA53ED3FwmyY24FO2tRctsEgQJPbATfEA2WhKiVCgQ4l4K1w18CgzxT3
	ucEfZKdzjkcLYQiMvAktrkHbUUVbByUtCZPq7JhGiDm7WPDSNfn3t/M7vcGkvzZP
	7Pw7MKjM2oWTNg8bbCuCO/17Q6LFK2+52RhVntdxvGrwvzbRswJbXmsfbjWaAtN9
	WkgYvoN+e95GMwRMajkZ5tTW5m9KUZqSN61bG0A3PZ7rk7wbnIsPZZi4qww9ggr8
	bYwnkOPaSNG+OXD88Y8D6mLdldvEkdpj23/1XmFs6KV+LBe53e+yKZDa4J8IRkpf
	RsIeTYkKxdKU9g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br0uf97kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 18:09:20 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60JI7jFc001614;
	Mon, 19 Jan 2026 18:09:19 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012052.outbound.protection.outlook.com [52.101.48.52])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br0uf97kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 18:09:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uilK2ynD9tEf9IZLDJFRjBV0ST17uT/sLJrrBOSr5oGYt3Y4WbxiqZgHsvhzKqECQe+i8/sELtlonmlSfaoCPkB68CoHH0ubk+LSnsg53U5gk8IjAOMI45stvE0pN0LtKVLe30R++T6CQkukqJhctxCi3b9lDEbUqse5bNYmevSQE9tM+5jhDWFe51unRl60opDG0vYyBudWuFKBo5j68ABmuug2lbn1FiQV8BAg5tQ9XGBuQ4Q2I7YIJW8EYFbtiDeIqmbKzvky3p+55zpVRQ+vpMXS9esht5ebRvEZC2OXxK4q5CTl4/8yRKVVUp+O3Drs8vuhObx6FXuURaDBIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2YZ9QD/7OWll9DgyWBXrhaCuz8iQdOiV4TPxlhshtk=;
 b=QFtuRO6m+3ndbi5d8Yzo34cTKP5/5jKlq5RvQf9CO+fl9Ai0Fkk9U7P50MSh+ex9jKCU/3Sx6woNU6s1OIXSOgtbMMjKA3F4WnS3Xzrp0p/ypOWpYttGLjMh6m6US7opncOBmcDIT5ZtV9FLdWFV1Y4qIFPwVCTz5HWSsswhgP2G14s+oddHpdqWJU2QAUCq8LydC8QQODX6h90wKzZxdtON2ccm0Ay4mr+tzo9fs3WsOMlkO6ImRrP/VJLnWThlMewgBo2tkH1ztDv4c9gM7SSWUwkJh4Y1gnDnc3bmUaIReNI1cz4MXPJ3ZZbbz+Vwg3msEf3st6W9NutsV9Q3+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ2PR15MB6370.namprd15.prod.outlook.com (2603:10b6:a03:56d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 18:09:16 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 18:09:16 +0000
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
Thread-Index: AQHchQJlsj80quEwJ0uCe1jfsMW4jLVSDkAAgACHcICAASexAIAAt7iAgAVeTwA=
Date: Mon, 19 Jan 2026 18:09:16 +0000
Message-ID: <0349430786e4553845c30490e19b08451c8b999f.camel@ibm.com>
References: <68b0240f.a00a0220.1337b0.0006.GAE@google.com>
	 <20260113081952.2431735-1-wangjinchao600@gmail.com>
	 <a2b8144a25206fba69e59e805d93c05444080132.camel@ibm.com>
	 <aWcHhTiUrDppotRg@ndev>
	 <d382b5c97a71d769598fd32bc22cae9f960fea70.camel@ibm.com>
	 <aWhgNujuXujxSg3E@ndev>
	 <b718505beca70f2a3c1e0e20c74e43ae558b29d5.camel@ibm.com>
	 <aWnybRfDcsUAtsol@ndev>
In-Reply-To: <aWnybRfDcsUAtsol@ndev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ2PR15MB6370:EE_
x-ms-office365-filtering-correlation-id: 6d3aeaa8-73cf-4210-6a83-08de5785dbd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?V1Q2TjF3NEpSOUdjVEEzRGhPb3NqYTJCSDIzdlBjSVNVZTZqMWthMGp6WWdp?=
 =?utf-8?B?ZzlnSmhqUzJXamkvVW1xK2N3bXQzcEo5aDNmdGowZDkwczNIZENhRmdaTnZ5?=
 =?utf-8?B?UUtyZzJaYVdrWU1adlpCTzlvKzkyS25XYnJtcFh0ZkZlRXJUVHpPbjJ0RC9H?=
 =?utf-8?B?aW5EYSt2UWhSTUwwRjVsU3JoRSt3ZjJGYmw1QWRLS0tqZzJjZGxLa3VhTDJ1?=
 =?utf-8?B?Nk5DWm1PTFhsVjdyK1A2VW9pUnp3REF1L1FlOHE5bW1qMVpYb3NyS1kyNFU2?=
 =?utf-8?B?QUpabFpyNDlmbEltck5wZXY5S01CYTFCeXVQYTVFUnk4SlRZV0IxRmo4cUQ1?=
 =?utf-8?B?U3M2WTRUZXFVRkVQNHdFRThGdU5GMis1bHhEZTdhd3pZTUE4aGlKdkh2cld2?=
 =?utf-8?B?VjliY3BKNmpHYzN4eTc4VzdybVNQa3c0V1Y4MmhadDBHOGNXTFRiUnlYZTJD?=
 =?utf-8?B?Ny9iOFRVMzAzenphWU9IblVHcEZuYUEvWlZVVytyYmJ4dnNlRzZTTytKaFRp?=
 =?utf-8?B?cWZaQlBiQVhYSTMxVnFLbnNjdlhHYTFOQWRrWXBKZkxNMFErUXBCVk94T0lI?=
 =?utf-8?B?ck1WVUd0SS9ialMxMGtCcnhXbmhhOUdyc1JEWHZEQW5wc3J4UzdLYVVpUXNv?=
 =?utf-8?B?YThRSmxJMHFMYW54OGNQaE9NQ0VFRTNETzBKTmRsa0FkQUlrSHhUejllQUZS?=
 =?utf-8?B?Q2k5cExZQ2xFenVwZjlSdVJKbHhvU2l4NWhaZVg4MkFUdmh5Z1o4ZUFDR0Iz?=
 =?utf-8?B?L2cyUVc0bHhKK25TZUdBWWovMnIzUHNhL256TXdLRUxtcXdQbWVWVjg0aVhq?=
 =?utf-8?B?S3AwTmFvNFNrSnRkL2pYZTdXK29xR0U5WUlwdnBJbk55UngySmxpcjlrNkFy?=
 =?utf-8?B?MGRoSXdtb1BTRzJHVmZxTmlxaGdQallNcVFFWkppV2JzZHRod0FHQWlHbFRq?=
 =?utf-8?B?cGhuZEZzbGdiSWwwU3JtQzVQbUdoN2gwZXZTVnZCU1BrVEM4NC9tOWxLbFFn?=
 =?utf-8?B?N1doZTVsRklScVUzQXNRQ3lvb3NhQXRnSjlwQ0RwOWRtTTRzVlZEbDA0WXZN?=
 =?utf-8?B?M3krM1I4UitDcE9Cb3JPMFRLRzQraWozNXpFUGJYUFZuZDlmdXE4N2YzWTN2?=
 =?utf-8?B?dlVGQkVkMEhKSmFPZ0V1ZHMzT3JnMDR3a0t0RXBob3BVakZ5b2tlbmVKcTNj?=
 =?utf-8?B?bTNnUnN0ZW1Td281OXk5TUpPaHZ3MFUwSllKRTRIWGFxTUhILzlWejRkODlC?=
 =?utf-8?B?N00vNUZFQk9MSGpoRVRYWUt1VUxLUjY3UDBXQmVqQWNTWTVzNFNyQ2NIZTNB?=
 =?utf-8?B?UUd1YmNrbGRaRG4rMS9BQloybzk1S29vWVRqYUxtcTVOWCs3SUFSTU1XQjUv?=
 =?utf-8?B?cWtCMll4UmliT0QxcThSbnJ6dVh3YWJtejBkSVNmTFNad0ROS2lXVm1sNWxk?=
 =?utf-8?B?a212R0Jra2xoUDRoYjZnZkJKSXpmSzFadW4rUmFmUGxRTWxodVVKNG9QcExW?=
 =?utf-8?B?QVdvbjRjd2RJT0lTdHo4Zlp2VWRwdTRBZDVjVjJtbUdYZHpyVnBiQlU5NmND?=
 =?utf-8?B?RWVIT2tBRzZWUHM5MEZaOVVqYiszcWdQVFh6YUp5Z2VqelR4STgwMVVzL1Ax?=
 =?utf-8?B?NlVQc0Jvd1hJUjdNY0ZSMXBlMTgyWWVNYXYzaFo0K2VSS1orNTRKbEw5ekRB?=
 =?utf-8?B?TXk4QmdZRkh6V1hCdWhsTFN4dkZHZ0pCVHV1cTBYMjk1aFZzb2NtUUpKQTg3?=
 =?utf-8?B?dzM3dU53Y09pbDE2VE9kVFlGNDZ6NHRwZDM5L2k4NjRsNDcxaHJmbFlYWHlZ?=
 =?utf-8?B?WDRFc0YzeGdLdkJTc09hWWNneWhaSEdZQThnUjZ2NDMveTRFRE5iOUNoT08y?=
 =?utf-8?B?VVExS05QWG9CWTdQY2U2eU9QOHd1RWM4Nmxsb3crZUZrb2ltenpVbm85SGFi?=
 =?utf-8?B?OUVkMFJKUEk3dmRIcVNkNGw0VHhqcXNFWmxZWVFSYW55akgrcHRMYzFvVmwx?=
 =?utf-8?B?ZUY3M29WTlQ1bnpXeVVVMW1GUWlrSGsvenFROFBRWG9HR0hoYmx4UGJadUhs?=
 =?utf-8?B?cFJLRUJsQlg4aFl6dUxsd3RaQk55RGtoZWx3MitoUkRpUG9LcEVZNmZBWjE0?=
 =?utf-8?Q?BxSyw0l3UnND8SMFNJMf0tMWX?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WExIbDVJNG05WnRyazZxSXVYeVVENXRiSlNtZzVQVVhEWGJMUUpHeHVMblVI?=
 =?utf-8?B?WE5yNVJERjVhVFlvSGpLYmJnNWxmK0QyUVJ2NkQrdG41RzEvUlBOTWV3aDlQ?=
 =?utf-8?B?NFRPSGsvekhJSjU3L2tOTUVQMW9YSUxobkVVTlhmU3ZuSkhUdFhKeThpSU9y?=
 =?utf-8?B?N3c1NEFFUmNmRlRIZzZKZ3pzLy9ONWdweFlxclV4K3o2QVIrZmlaSWxxRVhU?=
 =?utf-8?B?N1JKeE5ZV3dPWGJwRWc2bDE2WmI5d2NsQVJ5ak5JeWZFcFpnVHQrVjRaeE55?=
 =?utf-8?B?ay9VWVZyMU5oUWJQUUJ6ZFZyVHNucmxtS0lKNUcyczdHYVZGSFlwblBWSmNk?=
 =?utf-8?B?SlFwclRPZDdGY0FyQ2MxTFYycG5VY1dSV04yc05NUEtVa3FiSlRqWWJabS9T?=
 =?utf-8?B?aVdRQ1NOVUhBZlNkMENnckgvSWpSMlpYcEFhbFJ0clhGZUpSWDNHYy9RYTht?=
 =?utf-8?B?VHI2Y29ObGtwWDBobjZReE5QOGUwVm93MXZ5eWxiK1JQSGNwZThGOFhRWEpT?=
 =?utf-8?B?Uit0Smp1L3NvdmhTa1VEUU1Ec3kzYmFFKzlUbEpRV1lwOVQ1OUxjZ3UwOCtL?=
 =?utf-8?B?VHdGYjVudWR2US9JOXdiWm1mYjNnQjFTRERjUUEwUEpZSHNjUlZuTm1uOWtG?=
 =?utf-8?B?Z2h2dTZFUXNmQ3ZmQjJoWm5NdFhQd0VSSXBsUjZhdkNicno5QXk5ZEZyUkts?=
 =?utf-8?B?eS9BdDFSQ2xBU0s0a3dVem1iS1YybHUzWm5IM01MTkJKcG10KzhvNnFTMFA3?=
 =?utf-8?B?eng4SWdCTGhJemFVKzU1M2lHSDdXVzkwcjh0Y2Z2bTVVQUNiZXZHWGdtQSt2?=
 =?utf-8?B?U0FsYjgxd3ZNaTBRQzVlTkFjMkQvK3VGSkdlUXBOVmQzR1RBbFhBQnlvY2FW?=
 =?utf-8?B?WjdmaU5zdC80bEduNTFmRVdwelptNm1UV1VSMWY0ZngwMlpVaFpWR3dmZDFx?=
 =?utf-8?B?aTg4UzA3WjBmd2lDaDIrUGVDN1c3RFlMa2VHaldXYk5aWW1lV2JWaTlOSlZZ?=
 =?utf-8?B?TGdlV3J4aWhXMUswL3FLWUpkWjdqVmFVYm1XdGJGeVV5VzRCbFNRMXBrOW1W?=
 =?utf-8?B?ZGE4UzgzNnFiRWxOZ0w0K1NwS0Vad2xxbXFkTlk1Mi9NbVJuaWlJMG1RL1Z2?=
 =?utf-8?B?RUZjS2JRWm5YWURoTDlJTGZNdnBaakZrZXpZSjZiUkUrLzQxY3RJanF0S1Q2?=
 =?utf-8?B?WjQ1bVF0ZE5EUTBTR2FLL2dBVStLNy9oS25nVnBDK0I5Z3EyK3dESkp3TFJw?=
 =?utf-8?B?QnBFcTJPWVk2cGNSTXl2RDdVdkNnVkFPc2t4WXQraFVYMVBKOVY4bHd1T0JQ?=
 =?utf-8?B?STNtY3pHbHV1UVhYSFBaaFE5bEpoYjhBTkRaa01uV0JkSldlcjNFTlREOTNE?=
 =?utf-8?B?YXAvNWhxY0VvVUpCbXc1bElNWklodk1BWURBa1VmZEpvNzRLSEd0dk5pN2Zu?=
 =?utf-8?B?TTFqeWlnaWx6RFZwZG91dFVCOEJQLzJJZSt0dVFTRTk5ajl3N3orVHV3Y3li?=
 =?utf-8?B?NUNxZEVMbVFEOUFlVGlxWHN2TSt5UGdQUGxOQVZHWTZ0UzYyRkx0cXpmaXNF?=
 =?utf-8?B?Um1GOE8veHVUQjErUzd2QWRlbVZWQnNpeEpYWkZBSFlwY0kvVG8ya1AvUkpM?=
 =?utf-8?B?ZExJb0d0WEZCeGM1aHdZbUpvdG1LT2JSOTlMUFM0V0pKbkl4OGM2MjRUaU5w?=
 =?utf-8?B?VnRrY3RKZTVtQUVXaWZsRWEzcUhvVnZzeGVobW1iTHMxa2x1WE1ZeEtLMENh?=
 =?utf-8?B?RXU1KzZET3kzK0daUFhqSVJFM09lM0RxQURwaytkbDgrZGtCdkxrT3lJaWs4?=
 =?utf-8?B?T0hRZG03ZUE3NTVveXUvMzVrZE1ORmlqa1BUcTY0VUxVWmtlSmRtZjkxT283?=
 =?utf-8?B?cEcyRUVCZEZ4YURCZ2RqdXErR084WUpJUkN4VmpuT01UT3NPSUdFb2lRclVM?=
 =?utf-8?B?YUdBL1N6bnBkVkdPWGg5c3U0ZGc0S3NkQ1o3NmpvdEZ2QWZ6dm9IV3dzODYx?=
 =?utf-8?B?V09PTHFNSlJDa0t6QlpzeVArcUx4WlFSSnZ6MlZzM2ZNWVI5RklsSFJXRXhP?=
 =?utf-8?B?M3Zoc283RVd6NlNndlFZcUUxUlFHek9WeXFSRU9BOVlUVms5Ym42VHZLaGpV?=
 =?utf-8?B?STN6Mm9HNmtkb3BnWUwyVDBiYklZZ1MwZWdweUJZbTVmTGt3eSsvWitLS2Mx?=
 =?utf-8?B?QVA3NDFRU2NyTmUrU29WSkJlSnlBU3lxL2c3Q0FjYkhwUk15S0lHMkhHQ3E0?=
 =?utf-8?B?eE5hSmcyS0J4MW5SVk9GRjdCUHdrMWMrUVdDWGw2akZwdVMzVGhyKzZLV20z?=
 =?utf-8?B?U1pqZUI3bzB1cjMvU254SHlXcEFYOVlhdFpkWlo0QVA1dFQ3bTQyOGgwTVZs?=
 =?utf-8?Q?XsBxdTSVGAMtE+HHc8mKN4IC0KyedGHXIyKpl?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3aeaa8-73cf-4210-6a83-08de5785dbd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 18:09:16.3308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MIcFEveObIU/N6NoeXRs3SDnBfGPr6A243CThcyD74M/jooWR3AG9m2IKUhAavl2qM1O1BeyRkswQWLfqFC22w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB6370
X-Proofpoint-GUID: uhPYoN6oNMUWK9pPKbJgwnrf1WS8EcXJ
X-Proofpoint-ORIG-GUID: 177GbcumZAU6pCaqZLFx_MNV29qdZZpk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE0OCBTYWx0ZWRfXz3wBoxfIO7IQ
 lUfBijpe+I2JfyPOBCWjrPzMV589UkuiG9kVyxzc/KnTd2CUfUsHWN7Q7lueQkbynjkbrwY3r5g
 Pw3m9Xy285efLSiAOzcBnM6TOE1BwyroGMhYA6BLldFsbu2LDKDtj1wQjhXLKXjytFCsAly3s1J
 szG+bhJRK51j3fRnyC7B9vRd75c6WgZog7t4i8SR1ShB3RZmjuSnu9sYEIl2Kl0sGpn/MzTaVYG
 84gJqoxrVfUyTxdPEyHBKpMg3aXY6XZ8cZWkRVUpE01HkGtmRDbB2gn9IkHx2dXRoVjlYUNkxiQ
 d+8VSL/3rMiYucXaxY92RSC3RN2Lu02lqfV7NmML+08B5WKypeeucRIc3mnO8RGEiOnLAAG5SE5
 HzXcbl32fDPx3jZGZbFOnfEiH5WfKQ0Ye8bwnZDL7AYZSCOBCYX0p8zHTcrcU49Bjnsk2TyQFvc
 RUDZxCI6VE8Sj7vEmDQ==
X-Authority-Analysis: v=2.4 cv=bopBxUai c=1 sm=1 tr=0 ts=696e7350 cx=c_pps
 a=NkapyFR+xBWi1egQVwNhyQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=P-IC7800AAAA:8 a=edf1wS77AAAA:8
 a=nFi4t2O3ZH87ViCd92gA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
 a=DcSpbTIhAlouE1Uv7lRv:22
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AF86061F753D149831F2411E62CFD0B@namprd15.prod.outlook.com>
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
 definitions=2026-01-19_04,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601190148

On Fri, 2026-01-16 at 16:10 +0800, Jinchao Wang wrote:
> On Thu, Jan 15, 2026 at 09:12:49PM +0000, Viacheslav Dubeyko wrote:
> > On Thu, 2026-01-15 at 11:34 +0800, Jinchao Wang wrote:
> > > On Wed, Jan 14, 2026 at 07:29:45PM +0000, Viacheslav Dubeyko wrote:
> > > > On Wed, 2026-01-14 at 11:03 +0800, Jinchao Wang wrote:
> > > > > On Tue, Jan 13, 2026 at 08:52:45PM +0000, Viacheslav Dubeyko wrot=
e:
> > > > > > On Tue, 2026-01-13 at 16:19 +0800, Jinchao Wang wrote:
> > > > > > > syzbot reported a hung task in hfs_mdb_commit where a deadloc=
k occurs
> > > > > > > between the MDB buffer lock and the folio lock.
> > > > > > >=20
> > > > > > > The deadlock happens because hfs_mdb_commit() holds the mdb_bh
> > > > > > > lock while calling sb_bread(), which attempts to acquire the =
lock
> > > > > > > on the same folio.
> > > > > >=20
> > > > > > I don't quite to follow to your logic. We have only one sb_brea=
d() [1] in
> > > > > > hfs_mdb_commit(). This read is trying to extract the volume bit=
map. How is it
> > > > > > possible that superblock and volume bitmap is located at the sa=
me folio? Are you
> > > > > > sure? Which size of the folio do you imply here?
> > > > > >=20
> > > > > > Also, it your logic is correct, then we never could be able to =
mount/unmount or
> > > > > > run any operations on HFS volumes because of likewise deadlock.=
 However, I can
> > > > > > run xfstests on HFS volume.
> > > > > >=20
> > > > > > [1] https://elixir.bootlin.com/linux/v6.19-rc5/source/fs/hfs/md=
b.c#L324     =20
> > > > >=20
> > > > > Hi Viacheslav,
> > > > >=20
> > > > > After reviewing your feedback, I realized that my previous RFC wa=
s not in
> > > > > the correct format. It was not intended to be a final, merge-read=
y patch,
> > > > > but rather a record of the analysis and trial fixes conducted so =
far.
> > > > > I apologize for the confusion caused by my previous email.
> > > > >=20
> > > > > The details are reorganized as follows:
> > > > >=20
> > > > > - Observation
> > > > > - Analysis
> > > > > - Verification
> > > > > - Conclusion
> > > > >=20
> > > > > Observation
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >=20
> > > > > Syzbot report: https://syzkaller.appspot.com/bug?extid=3D1e3ff4b0=
7c16ca0f6fe2     =20
> > > > >=20
> > > > > For this version:
> > > > > > time             |  kernel    | Commit       | Syzkaller |
> > > > > > 2025/12/20 17:03 | linux-next | cc3aa43b44bd | d6526ea3  |
> > > > >=20
> > > > > Crash log: https://syzkaller.appspot.com/text?tag=3DCrashLog&x=3D=
12909b1a580000     =20
> > > > >=20
> > > > > The report indicates hung tasks within the hfs context.
> > > > >=20
> > > > > Analysis
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D
> > > > > In the crash log, the lockdep information requires adjustment bas=
ed on the call stack.
> > > > > After adjustment, a deadlock is identified:
> > > > >=20
> > > > > task syz.1.1902:8009
> > > > > - held &disk->open_mutex
> > > > > - held foio lock
> > > > > - wait lock_buffer(bh)
> > > > > Partial call trace:
> > > > > ->blkdev_writepages()
> > > > >         ->writeback_iter()
> > > > >                 ->writeback_get_folio()
> > > > >                         ->folio_lock(folio)
> > > > >         ->block_write_full_folio()
> > > > >                 __block_write_full_folio()
> > > > >                         ->lock_buffer(bh)
> > > > >=20
> > > > > task syz.0.1904:8010
> > > > > - held &type->s_umount_key#66 down_read
> > > > > - held lock_buffer(HFS_SB(sb)->mdb_bh);
> > > > > - wait folio
> > > > > Partial call trace:
> > > > > hfs_mdb_commit
> > > > >         ->lock_buffer(HFS_SB(sb)->mdb_bh);
> > > > >         ->bh =3D sb_bread(sb, block);
> > > > >                 ...->folio_lock(folio)
> > > > >=20
> > > > >=20
> > > > > Other hung tasks are secondary effects of this deadlock. The issue
> > > > > is reproducible in my local environment usuing the syz-reproducer.
> > > > >=20
> > > > > Verification
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >=20
> > > > > Two patches are verified against the syz-reproducer.
> > > > > Neither reproduce the deadlock.
> > > > >=20
> > > > > Option 1: Removing `un/lock_buffer(HFS_SB(sb)->mdb_bh)`
> > > > > ------------------------------------------------------
> > > > >=20
> > > > > diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> > > > > index 53f3fae60217..c641adb94e6f 100644
> > > > > --- a/fs/hfs/mdb.c
> > > > > +++ b/fs/hfs/mdb.c
> > > > > @@ -268,7 +268,6 @@ void hfs_mdb_commit(struct super_block *sb)
> > > > >         if (sb_rdonly(sb))
> > > > >                 return;
> > > > >=20
> > > > > -       lock_buffer(HFS_SB(sb)->mdb_bh);
> > > > >         if (test_and_clear_bit(HFS_FLG_MDB_DIRTY, &HFS_SB(sb)->fl=
ags)) {
> > > > >                 /* These parameters may have been modified, so wr=
ite them back */
> > > > >                 mdb->drLsMod =3D hfs_mtime();
> > > > > @@ -340,7 +339,6 @@ void hfs_mdb_commit(struct super_block *sb)
> > > > >                         size -=3D len;
> > > > >                 }
> > > > >         }
> > > > > -       unlock_buffer(HFS_SB(sb)->mdb_bh);
> > > > >  }
> > > > >=20
> > > > >=20
> > > > > Options 2: Moving `unlock_buffer(HFS_SB(sb)->mdb_bh)`
> > > > > --------------------------------------------------------
> > > > >=20
> > > > > diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> > > > > index 53f3fae60217..ec534c630c7e 100644
> > > > > --- a/fs/hfs/mdb.c
> > > > > +++ b/fs/hfs/mdb.c
> > > > > @@ -309,6 +309,7 @@ void hfs_mdb_commit(struct super_block *sb)
> > > > >                 sync_dirty_buffer(HFS_SB(sb)->alt_mdb_bh);
> > > > >         }
> > > > > =20
> > > > > +       unlock_buffer(HFS_SB(sb)->mdb_bh);
> > > > >         if (test_and_clear_bit(HFS_FLG_BITMAP_DIRTY, &HFS_SB(sb)-=
>flags)) {
> > > > >                 struct buffer_head *bh;
> > > > >                 sector_t block;
> > > > > @@ -340,7 +341,6 @@ void hfs_mdb_commit(struct super_block *sb)
> > > > >                         size -=3D len;
> > > > >                 }
> > > > >         }
> > > > > -       unlock_buffer(HFS_SB(sb)->mdb_bh);
> > > > >  }
> > > > >=20
> > > > > Conclusion
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >=20
> > > > > The analysis and verification confirms that the hung tasks are ca=
used by
> > > > > the deadlock between `lock_buffer(HFS_SB(sb)->mdb_bh)` and `sb_br=
ead(sb, block)`.
> > > >=20
> > > > First of all, we need to answer this question: How is it
> > > > possible that superblock and volume bitmap is located at the same f=
olio or
> > > > logical block? In normal case, the superblock and volume bitmap sho=
uld not be
> > > > located in the same logical block. It sounds to me that you have co=
rrupted
> > > > volume and this is why this logic [1] finally overlap with superblo=
ck location:
> > > >=20
> > > > block =3D be16_to_cpu(HFS_SB(sb)->mdb->drVBMSt) + HFS_SB(sb)->part_=
start;
> > > > off =3D (block << HFS_SECTOR_SIZE_BITS) & (sb->s_blocksize - 1);
> > > > block >>=3D sb->s_blocksize_bits - HFS_SECTOR_SIZE_BITS;
> > > >=20
> > > > I assume that superblock is corrupted and the mdb->drVBMSt [2] has =
incorrect
> > > > metadata. As a result, we have this deadlock situation. The fix sho=
uld be not
> > > > here but we need to add some sanity check of mdb->drVBMSt somewhere=
 in
> > > > hfs_fill_super() workflow.
> > > >=20
> > > > Could you please check my vision?
> > > >=20
> > > > Thanks,
> > > > Slava.
> > > >=20
> > > > [1] https://elixir.bootlin.com/linux/v6.19-rc5/source/fs/hfs/mdb.c#=
L318   =20
> > > > [2]
> > > > https://elixir.bootlin.com/linux/v6.19-rc5/source/include/linux/hfs=
_common.h#L196   =20
> > >=20
> > > Hi Slava,
> > >=20
> > > I have traced the values during the hang. Here are the values observe=
d:
> > >=20
> > > - MDB: blocknr=3D2
> > > - Volume Bitmap (drVBMSt): 3
> > > - s_blocksize: 512 bytes
> > >=20
> > > This confirms a circular dependency between the folio lock and
> > > the buffer lock. The writeback thread holds the 4KB folio lock and=20
> > > waits for the MDB buffer lock (block 2). Simultaneously, the HFS sync=
=20
> > > thread holds the MDB buffer lock and waits for the same folio lock=20
> > > to read the bitmap (block 3).
> > >=20
> > >=20
> > > Since block 2 and block 3 share the same folio, this locking=20
> > > inversion occurs. I would appreciate your thoughts on whether=20
> > > hfs_fill_super() should validate drVBMSt to ensure the bitmap=20
> > > does not reside in the same folio as the MDB.
> >=20
> >=20
> > As far as I can see, I can run xfstest on HFS volume (for example, gene=
ric/001
> > has been finished successfully):
> >=20
> > sudo ./check -g auto -E ./my_exclude.txt=20
> > FSTYP         -- hfs
> > PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.19.0-rc1+ #56 SMP
> > PREEMPT_DYNAMIC Thu Jan 15 12:55:22 PST 2026
> > MKFS_OPTIONS  -- /dev/loop51
> > MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch
> >=20
> > generic/001 36s ...  36s
> >=20
> > 2026-01-15T13:00:07.589868-08:00 hfsplus-testing-0001 kernel: run fstes=
ts
> > generic/001 at 2026-01-15 13:00:07
> > 2026-01-15T13:00:07.661605-08:00 hfsplus-testing-0001 systemd[1]: Start=
ed
> > fstests-generic-001.scope - /usr/bin/bash -c "test -w /proc/self/oom_sc=
ore_adj
> > && echo 250 > /proc/self/oom_score_adj; exec ./tests/generic/001".
> > 2026-01-15T13:00:13.355795-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():296 HFS_SB(sb)->mdb_bh buffer has been locked
> > 2026-01-15T13:00:13.355809-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():348 drVBMSt 3, part_start 0, off 0, block 3, size 8167
> > 2026-01-15T13:00:13.355810-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.355810-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.355811-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.355812-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.355812-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.355812-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.355813-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.355813-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.355813-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.355814-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.355814-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.355815-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.355815-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.355815-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.355816-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.355816-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.355816-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.355816-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.355817-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.355818-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.355818-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.355818-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.355819-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.355819-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.355819-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.355819-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.355820-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.355820-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.355821-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.355821-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.355821-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.355822-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.355822-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():383 HFS_SB(sb)->mdb_bh buffer has been unlocked
> > 2026-01-15T13:00:13.681527-08:00 hfsplus-testing-0001 systemd[1]: fstes=
ts-
> > generic-001.scope: Deactivated successfully.
> > 2026-01-15T13:00:13.681597-08:00 hfsplus-testing-0001 systemd[1]: fstes=
ts-
> > generic-001.scope: Consumed 5.928s CPU time.
> > 2026-01-15T13:00:13.714928-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():296 HFS_SB(sb)->mdb_bh buffer has been locked
> > 2026-01-15T13:00:13.714942-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():348 drVBMSt 3, part_start 0, off 0, block 3, size 8167
> > 2026-01-15T13:00:13.714943-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.714944-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.714944-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.714944-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.714945-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.714945-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.714946-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.714946-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.714947-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.714947-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.714947-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.714948-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.714948-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.714948-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.714949-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.714949-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.714950-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.714950-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.714950-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.714951-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.714951-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.714952-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.714952-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.714952-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.714953-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.714953-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.714953-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.714954-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.714954-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.714955-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.714955-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():356 start read volume bitmap block
> > 2026-01-15T13:00:13.714955-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > 2026-01-15T13:00:13.714956-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():383 HFS_SB(sb)->mdb_bh buffer has been unlocked
> > 2026-01-15T13:00:13.716742-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():296 HFS_SB(sb)->mdb_bh buffer has been locked
> > 2026-01-15T13:00:13.716754-08:00 hfsplus-testing-0001 kernel: hfs:
> > hfs_mdb_commit():383 HFS_SB(sb)->mdb_bh buffer has been unlocked
> > 2026-01-15T13:00:13.722184-08:00 hfsplus-testing-0001 systemd[1]: mnt-
> > test.mount: Deactivated successfully.
> >=20
> > And I don't see any issues with locking into the added debug output. I =
don't see
> > the reproduction of reported deadlock. And the logic of hfs_mdb_commit(=
) correct
> > enough.
> >=20
> > The main question is: how blkdev_writepages() can collide with hfs_mdb_=
commit()?
> > I assume that blkdev_writepages() is trying to flush the user data. So,=
 what is
> > the problem here? Is it allocation issue? Does it mean that some file w=
as not
> > properly allocated? Or does it mean that superblock commit somehow coll=
ided with
> > user data flush? But how does it possible? Which particular workload co=
uld have
> > such issue?
> >=20
> > Currently, your analysis doesn't show what problem is and how it is hap=
pened.=20
> >=20
> > Thanks,
> > Slava.
>=20
> Hi Slava,
>=20
> Thank you very much for your feedback and for taking the time to=20
> review this. I apologize if my previous analysis was not clear=20
> enough. As I am relatively new to this area, I truly appreciate=20
> your patience.
>=20
> After further tracing, I would like to share more details on how the=20
> collision between blkdev_writepages() and hfs_mdb_commit() occurs.=20
> It appears to be a timing-specific race condition.
>=20
> 1. Physical Overlap (The "How"):
> In my environment, the HFS block size is 512B and the MDB is located=20
> at block 2 (offset 1024). Since 1024 < 4096, the MDB resides=20
> within the block device's first folio (index 0).=20
> Consequently, both the filesystem layer (via mdb_bh) and the block=20
> layer (via bdev mapping) operate on the exact same folio at index 0.
>=20
> 2. The Race Window (The "Why"):
> The collision is triggered by the global nature of ksys_sync(). In=20
> a system with multiple mounted devices, there is a significant time=20
> gap between Stage 1 (iterate_supers) and Stage 2 (sync_bdevs). This=20
> window allows a concurrent task to dirty the MDB folio after one=20
> sync task has already passed its FS-sync stage.
>=20
> 3. Proposed Reproduction Timeline:
> - Task A: Starts ksys_sync() and finishes iterate_supers()=20
>   for the HFS device. It then moves on to sync other devices.
> - Task B: Creates a new file on HFS, then starts its=20
>   own ksys_sync().
> - Task B: Enters hfs_mdb_commit(), calls lock_buffer(mdb_bh) and=20
>   mark_buffer_dirty(mdb_bh). This makes folio 0 dirty.
> - Task A: Finally reaches sync_bdevs() for the HFS device. It sees=20
>   folio 0 is dirty, calls folio_lock(folio), and then attempts=20
>   to lock_buffer(mdb_bh) for I/O.
> - Task A: Blocks waiting for mdb_bh lock (held by Task B).
> - Task B: Continues hfs_mdb_commit() -> sb_bread(), which attempts=20
>   to lock folio 0 (held by Task A).
>=20
> This results in an AB-BA deadlock between the Folio Lock and the=20
> Buffer Lock.
>=20
> I hope this clarifies why the collision is possible even though=20
> hfs_mdb_commit() seems correct in isolation. It is the concurrent=20
> interleaving of FS-level and BDEV-level syncs that triggers the=20
> violation of the Folio -> Buffer locking order.
>=20
> I would be very grateful for your thoughts on this updated analysis.
>=20
>=20

Firs of all, I've tried to check the syzbot report that you are mentioning =
in
the patch. And I was confused because it was report for FAT. So, I don't se=
e the
way how I can reproduce the issue on my side.

Secondly, I need to see the real call trace of the issue. This discussion
doesn't make sense without the reproduction path and the call trace(s) of t=
he
issue.

Thanks,
Slava.

