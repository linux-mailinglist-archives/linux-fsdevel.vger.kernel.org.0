Return-Path: <linux-fsdevel+bounces-71492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D54CC513F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 21:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 549193039751
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 20:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC42268690;
	Tue, 16 Dec 2025 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Nu4teZE3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79F9212552
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 20:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765916181; cv=fail; b=PHeVdXQMsNxOn2T8Jj+rxhc6o5uT1pMxkW6xRANTm5m0a/LSuMWdcC9kRwXQS8shyFftO8T0MXK911iO5k3kA3/+bPA9IfcErbhXTuoP3s/7DXr5jozj3zgrow3jHcZTcIITxfIH/wiJAYYwkzytpEb6KWm+RPPDKSek4+x/8FA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765916181; c=relaxed/simple;
	bh=/Gcc9NnVc+tOu3vmSeXp74YrVIot99Tow6sCQ5Lw9Tw=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=qEXvaEZvL6+b8Bo1Uhi+oiI+Mv+PKI5IFJFFdEsdK74hpblr/0yjhez9lFtetaQuU+Q9Ht5RgKCe/oM03qUrpqoCHnRTUQb3bqmeyHx+AXghXlFteuZFmdM69M5cC6pDODl3Z/+uxRct1fm5B//XoTrKMrHALFhS0mE0Wk2zSyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Nu4teZE3; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGI1NSZ016906
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 20:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=YZjBaKlPfA4Z5Fga0bnlqux+frRrJ/G4fXtdZQ91G+I=; b=Nu4teZE3
	6a4YDU3z8UuTrgOfCN4v5Yl9iF5Bxytvx1HbZF2uAzsh7zVE9pzbDDthDlP7vUUl
	ioxw4GU4Y8aWpI/f6zLs7B5n4YXuYBmH/lX53Bkp/spzDX+vGi1cWUluCXNYAzKK
	7DN+0uC6MLibvDDG+bQtn2PsAa0X5JG/nOTNZOVW482dnsDEoQOKteikw0NgFc0a
	ZQdOsSxkgqnRTfHgzhqM2JrQy4h2XChZGpOz7d5LA3h5Duf6ldWNMBHzEYF2DPQj
	Hilg+WfIyk8MvyQwy9dVq59GDAYiYRX7PHNOjwDtmc+8IpXmDCRocEo84Jtx9PCv
	skphNoMG1tciew==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yt1gks4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 20:16:18 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BGKGIXQ013644
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 20:16:18 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013016.outbound.protection.outlook.com [40.93.201.16])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yt1gks1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 20:16:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2I8OAbj/EcFh66y4qGql9BKEEwRvxSsGGLbYBiIIlKqJmSEX20TilJ5pRwSHd7BPQIvSzOI1IkNowJlXnqQzPaV80Ask7g5+Gnw+rRhK/2w5ISz7/0stytvx4JH/2NiXBhUHK9HdGI30TbldoCjKf3h16IYjoyHGEPUUQU90k1tX+8ahUTrzjEAy0uKQ5LRwaNrcQVK+xY/p4tq4JGqpUjnmKKpvPIfdWLFxcxQ9Hx4BopHYytZxwhOknd38qA8qzDxhud6KEH5JFuVoIGlq2cQsP1MfRPivy4rpb3zSsRriTidpoBZKIrS9kSzy+DTHWbdpTWjm+rm06g2ebILqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jFUq1E1jDDsX9LaIM9I3uq/udd833kGs+5Ro50cw9U=;
 b=mClX7C0G35X9zaZN2znMq8ZWAEVQBGqqK1PxHwAjO00fzB4OuoSZedcAIYIWIopC9J0gMqsEKgB1AZBpuhrnjGpZ4O+P8SH0dngj0+9PwlLWylMk3YPlhdTcWZXZSbp91/LckbC0v1Pxo7nzqkQrgtcwzzq+f/ZMyLQd2xXc5l5Mj9ial4quER7Ge0PIBEgHIyJEKJjKjCXKZqZJ6cBXory4p5F8hvFkgRZuRNRwkCjCMn27JP0QReuMrPE7NxKScidasm6YRQ25GnFMRkRBFxlk5/1sjR7a2+xn+NOT21sETFyxTTd2Oa8Y56+fcxkTie2Uv2rJpTAmUu35eIYSGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB4784.namprd15.prod.outlook.com (2603:10b6:510:9b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 20:16:13 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 20:16:13 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "slava@dubeyko.com" <slava@dubeyko.com>,
        "jkoolstra@xs4all.nl"
	<jkoolstra@xs4all.nl>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>,
        "syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com"
	<syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] [PATCH v3] hfs: Replace BUG_ON with error handling
 for CNID count checks
Thread-Index: AQHcbqPmbaB7qWjPOkCjJs88UXuAi7UktF0A
Date: Tue, 16 Dec 2025 20:16:13 +0000
Message-ID: <2a39f49ff37654f10e9144d352b312fd652858f5.camel@ibm.com>
References: <20251216155030.1693622-1-jkoolstra@xs4all.nl>
In-Reply-To: <20251216155030.1693622-1-jkoolstra@xs4all.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB4784:EE_
x-ms-office365-filtering-correlation-id: 22a0ec87-8063-4f22-bc7f-08de3cdff5da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?c1NvWEJpelRpaFVYb3VWOFhsZFB1ckxjbzh6MnBSa3krVkc3djB4VFhqWWkr?=
 =?utf-8?B?U2xoQVZxWnkxUmJmdUxRVVB6cGlSVkRLNlU2Nk9DSlhDa1lBUnVwdEdsem1W?=
 =?utf-8?B?dm8yTWN0NUczUGtKcTY4SjRTNjJNeWN6V1o4OG5USTBMRUhFNDU1SjZxbkg4?=
 =?utf-8?B?SHRoVk9aeGtGRXA3QmJHSG91YUo0czZybTZub2ZTVVpZNkVkUG40MFVSYUd5?=
 =?utf-8?B?aGNMMG40VlVRUFl4TjhUVlViNHJnc0h6YllMWXVSTzlvWmswZDYzeTJ3SHIw?=
 =?utf-8?B?ZDFiNWF2L3Z1Z2V0ckZBd1hyVGlteXRzakZDZmNOTGFsYlg5azlickN2Wmc5?=
 =?utf-8?B?SUtoVDZHOW5iV0dZSnhENDQ0dTJwbzVMUnUvOU4vWEpVT3djZFVDZ3NDdS9o?=
 =?utf-8?B?WnU3SWNMcGJ0S1M5ektCek9xenJrUmpNamJWZmNjeWxDbUxsNUZMZEtTWFpn?=
 =?utf-8?B?THZjTHh0QnRVTmkvQWJLWlpLdzJoSjRuVlFVL0RaMnpRSWxOT3BuOHF4YVRL?=
 =?utf-8?B?NzduZWFjZGdwaytySHlrRm0wRENzY1VYbUhyMXArbjNVUzNDbEFFUis1ajVK?=
 =?utf-8?B?ZkJYczJhZEFxRGZTbVZSZW9rTUphY1d6U3U4QlJFSXhmSGtTcGtjUlFuR0p2?=
 =?utf-8?B?QktFR3FBUFhBdXoyeGhPNDdFZkwzR2MrVldEWmd5UE54T0xubDA0VXJtdyt1?=
 =?utf-8?B?Qk01TDZHcW5qZUptaFlCQTA1MDljYTVXS2Y2U2tZRWhhcXV0Q2hRZ3p2ckRk?=
 =?utf-8?B?amRvMEwyU0NPSHBscitDNUNoSm1NVmx3SU9aOVVzbXEzQlBwSXRNK0xLTUNu?=
 =?utf-8?B?OVFFaVdaUXhLVTRlRkwvS1RQZWd0YjlXZ0twMkNoUUVWNlp0eUUrUUFDbXlo?=
 =?utf-8?B?aGtiR3pUbStkRGJMWWpXYkpMaTZCaHlkVkVONjc4QTRCb2g0aTV5cWtqNG10?=
 =?utf-8?B?N1Z2SC80Wm5RYytEcElMTG1ZbkZWSVN6blhMN0JrMUE2M3NncnUrbS9RQURN?=
 =?utf-8?B?TmlrZHBveXdCdDEra1FKOFVXSWtxSnBlSyt1U2VhQVZXdUZ5L1RGazB1WWVS?=
 =?utf-8?B?NUhGRVV6aFMvc3BZbmNVT1YyZWpBOGFBck94WlBmVmlKY0ZmREFaRVJqdEtH?=
 =?utf-8?B?azNYUFFRU09kaEJqbitaZG9ObEZhbSs0UkFyN2NuZ2h4K1FIUEhuT0RJM1A5?=
 =?utf-8?B?RDA2THV3ZFVZc1lTVjBjd1NkQURGTjNwUDRkdXUrZ05CK05HU1gzN1k3UzJV?=
 =?utf-8?B?TzFSWDJqalVvbXFmSWg0VVRmRFNuL21LbkU0RS9XU2dRVFg4cGNBVnU2RFVG?=
 =?utf-8?B?alVhekhrZ1dOMXBWY1NVUTdXR2NsYTJPaVJpYU1ySUYvSHQzT1kra1VFUzd0?=
 =?utf-8?B?SFNXOG1NM0FsNktsZ0RiSkRkeThLL1JZREJTaWppZlM4eGJXNHE3akVpNzJq?=
 =?utf-8?B?d0gwb1hhS1pXcDR4c29NL0NNWUdxQ1BUeXd1RFVyN3VLSGp2V3FPaFF5ekN1?=
 =?utf-8?B?YVR6WlN5S3RMQWhmZmxQaG11dU9XWW5IQ1NzWmdmaWF4MFhySXp6SHN2Y0Fz?=
 =?utf-8?B?QXVDeEVTM3V1RmgydUdua2dxR25Sd0FxckFlRXJvT0dhOGJaWG5MOGZtdExN?=
 =?utf-8?B?a2E0RDY3K2s4ZEZzVVBVSnJwNUwyT1ZLdGZkbE1uZkJDV0FSdGNrWDJmWUJ4?=
 =?utf-8?B?cXBJZFlTalFKb0p2M1IrTVpUalVHUzB2dXBKeWtYVWFIckdlQ3E1LzdNRUtO?=
 =?utf-8?B?bVFyV3kxeHY3Y3BHZWVyb2wzVU5yTG9LZk9OWXIvOXdPNzJDdlB5eHluU2Nh?=
 =?utf-8?B?NGQzZ3dCTngxSWJsbTQyTjlLUW1jSCswVEdXTG9aK3FpdmxKM0ZqUXI1azVT?=
 =?utf-8?B?bDBaQTRoaUxiNzlMaUd6UEYyLzd6UENnZWpyWkZDTjkvL0xrSC9NeHhUcnhh?=
 =?utf-8?B?aWhhTXJjdHBUZ1B6QWVDYXdsVDR2TloxeWYyeGdGSG5ROHMwY0VKSEhQM0Ji?=
 =?utf-8?B?Y3U0a1Rxd2FRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VVNnUkxEWmRKcWZLSFJsc0F1alRmMkE4Z09SM0xvdklNSEdNRStsS2pxbjlm?=
 =?utf-8?B?NEVkRHgydloweTNWMFNla3J4ZUpwaDZ3K0lhRWVIeXZZVjlBaXVIM0lvNHF5?=
 =?utf-8?B?bEhuaW5Veks4U1M4Q0xlNFBORXduODN2cXBUUlpjZmUvS0xZR1lNQ2diVW56?=
 =?utf-8?B?YktXOHhuWWRuZVc4dTRqdHdCZEZBL3dHS3FaUDhFRkZWRFFjVEozTjYxenpj?=
 =?utf-8?B?bkIyUURGQWN6VnRLamlZTnFRYkhWK0JScmw1bVAvcEtuM2dlWFFDV256bW50?=
 =?utf-8?B?a29KZnduTm9Dc2pjOUxTeDYxZDNwaXpPQmo5M3RhTkhydUJuWDd1Wnl6Y3BZ?=
 =?utf-8?B?TEx1UzZZYk8xNVhhcjB4MnVBUm1ob1E2eE1RWFRHNVRxWkJ5VXMzTUdWODVy?=
 =?utf-8?B?dUhJOUFrYXBDdjRkbzhNT05KSWQ2bDBJd0xCdmJiQUU5L1lEZlN2VW5xN2ZB?=
 =?utf-8?B?ZTJZc3ZZQUw5M00yL1dyeXROanJRdm1vcFNLNVVoV3pnMWVJTWlkWEZLQmZE?=
 =?utf-8?B?alRNMXl3UFJLcklmb2U3YkdROEdnSGxNNXg4eG8ydkRiaHZIOXVSWWliSjEv?=
 =?utf-8?B?bS85ditIdTQyNXhIM25SYklEdnZYancwSkhOZ25DU3ovanRlV3BRV2RyQmo5?=
 =?utf-8?B?MmZkUkx3djhGLzg3UUN0WUdTUmJJbElDNzVUTnFzZ3FlRFA5eXFac2ZJZEVT?=
 =?utf-8?B?bFgvN3dLcmNxWnBnNWR4OTNqVVkyVGNhTjMvSXR3QU85Y25HNmpsRDN4TmRM?=
 =?utf-8?B?WCthdjhqb1RLMjd3clNHOTJTeWlzTnV3Tk9mZGl5RW5ZM3Y1b0VJcU1oM1lH?=
 =?utf-8?B?LytzQ3UrSFBjMjdnUlFuYUxpT2dIcGZPUW4rS2pYK2kwY0hJSWVQMzRybnh4?=
 =?utf-8?B?eVhmR0pZSjRBTFFUZU1KK0xVTmhneWY0SjNBaWcwcVJoY3dtb3plNGdKTWpz?=
 =?utf-8?B?L2d6bFhGOXQ1MWNhN3RLTGIwdlpyaEV2WHlMOGh2NU5oa1pha25DaDc2aFdm?=
 =?utf-8?B?TXNNbjVZRjJQdmplOE1kTjk4a1lvV3hSUW1CRURIaTA0cnUyYkYzUndmSE5l?=
 =?utf-8?B?bSt5Y1FETlFmUWhnZDFla01GVGhqNC9JWGFCd3ZwWEc0c1E1VmhMd3pkb1l5?=
 =?utf-8?B?NlhTMkxaK2sxdFdQMk94NzRLOU0yMnBaYmREdW56eWNKVEZreUdHRG1IaFdR?=
 =?utf-8?B?c0E0U2Vzcno0NEM0MUVsZzVNY0pBcjlUYjRLYXk1eDlUV3JFd0p3cnk0RnY2?=
 =?utf-8?B?N1FlcXlzeHhZZ2VTUVhvcFRVTUtwUVRvLzJCSUg5TlNqVHdGbEpvYzRjMVdJ?=
 =?utf-8?B?Z2pqMXBBd3I0V1c1VzQ5RkR6SXk5V2xTZVV4L0dqTjRRVnJsQ3dUT0EySjMw?=
 =?utf-8?B?U20xa3pGN2tUTVU1ZldOUjBKVG43TlZISDFYRFdPelc5ZmVPSjh4TGorWTdq?=
 =?utf-8?B?VXlqWFd6c3E2Q2tPWDFDLzhKSVRtUDBHcGZtOFJrMjVYeFBROUFlZWtVNVpS?=
 =?utf-8?B?bU9LREpiVmRMcHZMNkhFSWQ3QjZ6bUZuNmxzVkJCaXM0VGowM1R0QWdNb0sw?=
 =?utf-8?B?N3B3MEJ6c0piM3JUbVVHbm1wLzN3RTh1Y2ZDNjMrbm1ZNDZXR0tPNndVRXJ5?=
 =?utf-8?B?WmVuUTRhQ01OUitsaTB1Njhac0tKeFhZblBTRW5pVzdic2Zvc1VIOTZaN0F2?=
 =?utf-8?B?eUNoRmdHSmJWbUIvZkdYMGt0MWl0MXdueWxmWkM4T2hSbXVFR0NLUjRRQkl5?=
 =?utf-8?B?akFuSUdqVXVlSUpiTEN0NnRRcGNVazBpZlhFR29ENmZjVU5PbFVacFQ0OUE0?=
 =?utf-8?B?S1VRVkUzQWo0eWdIekNhb2h4dmZXc2VsQUNoaURSdnIwd1VnM1hXby9XbUpK?=
 =?utf-8?B?VUNhcXV5cE1vVDRTN3Q4bnVKOWhaeENlQmhPdERocEtYZUVPZllNY2lBNTBM?=
 =?utf-8?B?Slo2TnJxY2JVckJXSlV0cVZLc2VpcHlJamNpTmErVEoxK3pTeDVLUFY0Y3h5?=
 =?utf-8?B?clpPMFVlNlZ1cWJDQUlhcU5oTVhhaDhNczFTTmVZSzd6c1BOdlJGRGtwanRF?=
 =?utf-8?B?cHFBU2RTVFZ4OVViaDU2MnJONkdkaFdIQzJxMHhCU0JNWHVxRk1RWDYyaVFi?=
 =?utf-8?B?UzIvWlY2akV6Z05SNTduNjRnakRSNUh4L0ZFYVpGTWxTT2VtQTd3b0ppNkF1?=
 =?utf-8?Q?Sn+fOXHn4j0sHcz/B6LUdyc=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a0ec87-8063-4f22-bc7f-08de3cdff5da
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2025 20:16:13.2437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IyBRJmnzsopQGe2P8DXJYTaYfEjExlmQNzAwWX3UGg7zzYvdQTKH9ythxOMKEiF0lzzrRqH1PYMVTr35tKfNAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4784
X-Proofpoint-GUID: wrqafWyH9D9bUHhUJRbYoI0Rjz-woVq1
X-Proofpoint-ORIG-GUID: wrqafWyH9D9bUHhUJRbYoI0Rjz-woVq1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX8m2prM7N6FJt
 DNeKAw5/Caq6DEkX0GEYtN5M43hFN5RwwZHEMxjFLcWYA6n22xAiwTgFTgNfHr3CRG/lrYGk+sO
 kOYEPEWnA8vH6n71+2FP+8xAD5oqYrLQ2hr/HZHtMyp5Y5SxY35vJN6A7D8gLlakG+uPcrhtmE0
 8Nn61ZhX6Gad/ObixteQfEWNY3WdTEmJTXV8Wr3sGEXhGNd2R2Vp0O2/LsmFFUhhM0b7fj3V6cU
 4dmy8TEc51WwD9bnNBif1emi3Q1UZLOhK0sPOuFaHijvUrWBrBuRxKCpqh2r1iSIA62HRvq5HNw
 ptXorC38nfFggN1Q1LtK2siHf9cmrxVcsZZwO7UKD0iaTfTvE6TOZIbfRh2tL7THLBXohfTvSyV
 DrJRRhqEnkAfK1VBl7jNQpk3fa42bA==
X-Authority-Analysis: v=2.4 cv=L/MQguT8 c=1 sm=1 tr=0 ts=6941be11 cx=c_pps
 a=YOgfsySBG6Gh3lLixmEA+w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=-ibLmwfWAAAA:8 a=VwQbUJbxAAAA:8
 a=xOd6jRPJAAAA:8 a=hSkVLCK3AAAA:8 a=JQsh9KD8Qi4sJzCEmn4A:9 a=QEXdDO2ut3YA:10
 a=A6MkUVyZPcTV1i89ro0M:22 a=cQPPKAXgyycSBL8etih5:22
Content-Type: text/plain; charset="utf-8"
Content-ID: <62CF7C09281AB94BBC15A4760EEEE585@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [PATCH v3] hfs: Replace BUG_ON with error handling for CNID
 count checks
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2510240000 definitions=main-2512130023

On Tue, 2025-12-16 at 16:50 +0100, Jori Koolstra wrote:
> In a06ec283e125 next_id, folder_count, and file_count in the super block
> info were expanded to 64 bits, and BUG_ONs were added to detect
> overflow. This triggered an error reported by syzbot: if the MDB is
> corrupted, the BUG_ON is triggered. This patch replaces this mechanism
> with proper error handling and resolves the syzbot reported bug.
>=20
> Singed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> Reported-by: syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com
> Closes: https://syzbot.org/bug?extid=3D17cc9bb6d8d69b4139f0 =20
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
> This is a follow up on the v2 patch:
> 	https://lore.kernel.org/all/20251125211329.2835801-1-jkoolstra@xs4all.nl=
/ =20
>=20
> There is now a is_hfs_cnid_counts_valid() function that checks several
> CNID counts in the hfs super block info which can overflow. This check
> is performed in hfs_mdb_get(), when syncing, and when doing the
> mdb_flush(). Overall, effort is taken for the checks to be as
> non-intrusive as possible. So the mdb continues to flush, but warnings
> are printed, instead of stopping fully, so not to derail the fs
> operation too much.
>=20
> When loading the mdb from disk however, we can be sure there is disk
> corruption when is_hfs_cnid_counts_valid() is triggered. In that case we
> mount RO.
>=20
> Also, instead of returning EFSCORRUPTED, we return ERANGE.
> ---
>  fs/hfs/dir.c    | 15 +++++++++++----
>  fs/hfs/hfs_fs.h |  1 +
>  fs/hfs/inode.c  | 32 +++++++++++++++++++++++++-------
>  fs/hfs/mdb.c    | 31 +++++++++++++++++++++++++++----
>  fs/hfs/super.c  |  3 +++
>  5 files changed, 67 insertions(+), 15 deletions(-)
>=20
> diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
> index 86a6b317b474..329b69495e84 100644
> --- a/fs/hfs/dir.c
> +++ b/fs/hfs/dir.c
> @@ -196,8 +196,8 @@ static int hfs_create(struct mnt_idmap *idmap, struct=
 inode *dir,
>  	int res;
> =20
>  	inode =3D hfs_new_inode(dir, &dentry->d_name, mode);
> -	if (!inode)
> -		return -ENOMEM;
> +	if (IS_ERR(inode))
> +		return PTR_ERR(inode);
> =20
>  	res =3D hfs_cat_create(inode->i_ino, dir, &dentry->d_name, inode);
>  	if (res) {
> @@ -226,8 +226,8 @@ static struct dentry *hfs_mkdir(struct mnt_idmap *idm=
ap, struct inode *dir,
>  	int res;
> =20
>  	inode =3D hfs_new_inode(dir, &dentry->d_name, S_IFDIR | mode);
> -	if (!inode)
> -		return ERR_PTR(-ENOMEM);
> +	if (IS_ERR(inode))
> +		return ERR_CAST(inode);
> =20
>  	res =3D hfs_cat_create(inode->i_ino, dir, &dentry->d_name, inode);
>  	if (res) {
> @@ -254,11 +254,18 @@ static struct dentry *hfs_mkdir(struct mnt_idmap *i=
dmap, struct inode *dir,
>   */
>  static int hfs_remove(struct inode *dir, struct dentry *dentry)
>  {
> +	struct super_block *sb =3D dir->i_sb;
>  	struct inode *inode =3D d_inode(dentry);
>  	int res;
> =20
>  	if (S_ISDIR(inode->i_mode) && inode->i_size !=3D 2)
>  		return -ENOTEMPTY;
> +
> +	if (unlikely(!is_hfs_cnid_counts_valid(sb))) {
> +	    pr_err("cannot remove file/folder: some CNID counts exceed limit\n"=
);

The is_hfs_cnid_counts_valid() already shared which particular field(s) is
incorrect. So, phrase "some CNID counts exceed limit" sounds unnecessary he=
re.

> +	    return -ERANGE;
> +	}
> +
>  	res =3D hfs_cat_delete(inode->i_ino, dir, &dentry->d_name);
>  	if (res)
>  		return res;
> diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
> index e94dbc04a1e4..ac0e83f77a0f 100644
> --- a/fs/hfs/hfs_fs.h
> +++ b/fs/hfs/hfs_fs.h
> @@ -199,6 +199,7 @@ extern void hfs_delete_inode(struct inode *inode);
>  extern const struct xattr_handler * const hfs_xattr_handlers[];
> =20
>  /* mdb.c */
> +extern bool is_hfs_cnid_counts_valid(struct super_block *sb);
>  extern int hfs_mdb_get(struct super_block *sb);
>  extern void hfs_mdb_commit(struct super_block *sb);
>  extern void hfs_mdb_close(struct super_block *sb);
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index 524db1389737..754610d87f00 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -186,17 +186,24 @@ struct inode *hfs_new_inode(struct inode *dir, cons=
t struct qstr *name, umode_t
>  	struct inode *inode =3D new_inode(sb);
>  	s64 next_id;
>  	s64 file_count;
> -	s64 folder_count;
> +	s64 folder_count;;

This modification is useless. ;)

The rest of the patch looks good.

Thanks,
Slava.

> +	int err =3D -ENOMEM;
> =20
>  	if (!inode)
> -		return NULL;
> +		goto out_err;
> +
> +	err =3D -ERANGE;
> =20
>  	mutex_init(&HFS_I(inode)->extents_lock);
>  	INIT_LIST_HEAD(&HFS_I(inode)->open_dir_list);
>  	spin_lock_init(&HFS_I(inode)->open_dir_lock);
>  	hfs_cat_build_key(sb, (btree_key *)&HFS_I(inode)->cat_key, dir->i_ino, =
name);
>  	next_id =3D atomic64_inc_return(&HFS_SB(sb)->next_id);
> -	BUG_ON(next_id > U32_MAX);
> +	if (next_id > U32_MAX) {
> +		atomic64_dec(&HFS_SB(sb)->next_id);
> +		pr_err("cannot create new inode: next CNID exceeds limit\n");
> +		goto out_discard;
> +	}
>  	inode->i_ino =3D (u32)next_id;
>  	inode->i_mode =3D mode;
>  	inode->i_uid =3D current_fsuid();
> @@ -210,7 +217,11 @@ struct inode *hfs_new_inode(struct inode *dir, const=
 struct qstr *name, umode_t
>  	if (S_ISDIR(mode)) {
>  		inode->i_size =3D 2;
>  		folder_count =3D atomic64_inc_return(&HFS_SB(sb)->folder_count);
> -		BUG_ON(folder_count > U32_MAX);
> +		if (folder_count> U32_MAX) {
> +			atomic64_dec(&HFS_SB(sb)->folder_count);
> +			pr_err("cannot create new inode: folder count exceeds limit\n");
> +			goto out_discard;
> +		}
>  		if (dir->i_ino =3D=3D HFS_ROOT_CNID)
>  			HFS_SB(sb)->root_dirs++;
>  		inode->i_op =3D &hfs_dir_inode_operations;
> @@ -220,7 +231,11 @@ struct inode *hfs_new_inode(struct inode *dir, const=
 struct qstr *name, umode_t
>  	} else if (S_ISREG(mode)) {
>  		HFS_I(inode)->clump_blocks =3D HFS_SB(sb)->clumpablks;
>  		file_count =3D atomic64_inc_return(&HFS_SB(sb)->file_count);
> -		BUG_ON(file_count > U32_MAX);
> +		if (file_count > U32_MAX) {
> +			atomic64_dec(&HFS_SB(sb)->file_count);
> +			pr_err("cannot create new inode: file count exceeds limit\n");
> +			goto out_discard;
> +		}
>  		if (dir->i_ino =3D=3D HFS_ROOT_CNID)
>  			HFS_SB(sb)->root_files++;
>  		inode->i_op =3D &hfs_file_inode_operations;
> @@ -244,6 +259,11 @@ struct inode *hfs_new_inode(struct inode *dir, const=
 struct qstr *name, umode_t
>  	hfs_mark_mdb_dirty(sb);
> =20
>  	return inode;
> +
> +	out_discard:
> +		iput(inode);
> +	out_err:
> +		return ERR_PTR(err);
>  }
> =20
>  void hfs_delete_inode(struct inode *inode)
> @@ -252,7 +272,6 @@ void hfs_delete_inode(struct inode *inode)
> =20
>  	hfs_dbg("ino %lu\n", inode->i_ino);
>  	if (S_ISDIR(inode->i_mode)) {
> -		BUG_ON(atomic64_read(&HFS_SB(sb)->folder_count) > U32_MAX);
>  		atomic64_dec(&HFS_SB(sb)->folder_count);
>  		if (HFS_I(inode)->cat_key.ParID =3D=3D cpu_to_be32(HFS_ROOT_CNID))
>  			HFS_SB(sb)->root_dirs--;
> @@ -261,7 +280,6 @@ void hfs_delete_inode(struct inode *inode)
>  		return;
>  	}
> =20
> -	BUG_ON(atomic64_read(&HFS_SB(sb)->file_count) > U32_MAX);
>  	atomic64_dec(&HFS_SB(sb)->file_count);
>  	if (HFS_I(inode)->cat_key.ParID =3D=3D cpu_to_be32(HFS_ROOT_CNID))
>  		HFS_SB(sb)->root_files--;
> diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> index 53f3fae60217..e0150945cf13 100644
> --- a/fs/hfs/mdb.c
> +++ b/fs/hfs/mdb.c
> @@ -64,6 +64,27 @@ static int hfs_get_last_session(struct super_block *sb,
>  	return 0;
>  }
> =20
> +bool is_hfs_cnid_counts_valid(struct super_block *sb)
> +{
> +	struct hfs_sb_info *sbi =3D HFS_SB(sb);
> +	bool corrupted =3D false;
> +
> +	if (unlikely(atomic64_read(&sbi->next_id) > U32_MAX)) {
> +		pr_warn("next CNID exceeds limit\n");
> +		corrupted =3D true;
> +	}
> +	if (unlikely(atomic64_read(&sbi->file_count) > U32_MAX)) {
> +		pr_warn("file count exceeds limit\n");
> +		corrupted =3D true;
> +	}
> +	if (unlikely(atomic64_read(&sbi->folder_count) > U32_MAX)) {
> +		pr_warn("folder count exceeds limit\n");
> +		corrupted =3D true;
> +	}
> +
> +	return !corrupted;
> +}
> +
>  /*
>   * hfs_mdb_get()
>   *
> @@ -156,6 +177,11 @@ int hfs_mdb_get(struct super_block *sb)
>  	atomic64_set(&HFS_SB(sb)->file_count, be32_to_cpu(mdb->drFilCnt));
>  	atomic64_set(&HFS_SB(sb)->folder_count, be32_to_cpu(mdb->drDirCnt));
> =20
> +	if (!is_hfs_cnid_counts_valid(sb)) {
> +		pr_warn("filesystem possibly corrupted, running fsck.hfs is recommende=
d. Mounting read-only.\n");
> +		sb->s_flags |=3D SB_RDONLY;
> +	}
> +
>  	/* TRY to get the alternate (backup) MDB. */
>  	sect =3D part_start + part_size - 2;
>  	bh =3D sb_bread512(sb, sect, mdb2);
> @@ -209,7 +235,7 @@ int hfs_mdb_get(struct super_block *sb)
> =20
>  	attrib =3D mdb->drAtrb;
>  	if (!(attrib & cpu_to_be16(HFS_SB_ATTRIB_UNMNT))) {
> -		pr_warn("filesystem was not cleanly unmounted, running fsck.hfs is rec=
ommended.  mounting read-only.\n");
> +		pr_warn("filesystem was not cleanly unmounted, running fsck.hfs is rec=
ommended.	Mounting read-only.\n");
>  		sb->s_flags |=3D SB_RDONLY;
>  	}
>  	if ((attrib & cpu_to_be16(HFS_SB_ATTRIB_SLOCK))) {
> @@ -273,15 +299,12 @@ void hfs_mdb_commit(struct super_block *sb)
>  		/* These parameters may have been modified, so write them back */
>  		mdb->drLsMod =3D hfs_mtime();
>  		mdb->drFreeBks =3D cpu_to_be16(HFS_SB(sb)->free_ablocks);
> -		BUG_ON(atomic64_read(&HFS_SB(sb)->next_id) > U32_MAX);
>  		mdb->drNxtCNID =3D
>  			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->next_id));
>  		mdb->drNmFls =3D cpu_to_be16(HFS_SB(sb)->root_files);
>  		mdb->drNmRtDirs =3D cpu_to_be16(HFS_SB(sb)->root_dirs);
> -		BUG_ON(atomic64_read(&HFS_SB(sb)->file_count) > U32_MAX);
>  		mdb->drFilCnt =3D
>  			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->file_count));
> -		BUG_ON(atomic64_read(&HFS_SB(sb)->folder_count) > U32_MAX);
>  		mdb->drDirCnt =3D
>  			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->folder_count));
> =20
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index 47f50fa555a4..70e118c27e20 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -34,6 +34,7 @@ MODULE_LICENSE("GPL");
> =20
>  static int hfs_sync_fs(struct super_block *sb, int wait)
>  {
> +	is_hfs_cnid_counts_valid(sb);
>  	hfs_mdb_commit(sb);
>  	return 0;
>  }
> @@ -65,6 +66,8 @@ static void flush_mdb(struct work_struct *work)
>  	sbi->work_queued =3D 0;
>  	spin_unlock(&sbi->work_lock);
> =20
> +	is_hfs_cnid_counts_valid(sb);
> +
>  	hfs_mdb_commit(sb);
>  }
> =20

