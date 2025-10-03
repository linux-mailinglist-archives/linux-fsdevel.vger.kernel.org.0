Return-Path: <linux-fsdevel+bounces-63416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC7BBB8552
	for <lists+linux-fsdevel@lfdr.de>; Sat, 04 Oct 2025 00:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815B14C23D4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 22:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB6E272E5A;
	Fri,  3 Oct 2025 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cDX86SA7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFCE2727E3
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759531227; cv=fail; b=oXcG6KE7JX2HPQxLXph4qgqoBWBR2J4bpmetCVcTVTeEvtgLdJZjF5r4RZq/IfWh7KicOkFk/sKuv6SGF9ZhJLRKMDeDrUnz5QcETWBlKx5g9Uz0q1TnR6vKU1neZutVW9cb1sB185kzCFYyOOoA85/7iJBVwXU4XVX+A5RFbME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759531227; c=relaxed/simple;
	bh=4JaFxmoIz3IthZfiN0XLMsUCLWkYNN6tR7rRDktR1mc=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=dyvfIRXxIZxeoeRcejJ69gONbeKfBWcsfM2qsPdWcLAtaM4Hade2iNOfmg7MtqOprcEWil1Ltwr6QhZJoAF1CdA97d72On7MrrFisRKmQ8B1LIwMTnOkf5I0b9yxWwAUkrn86xzQci2epY4uwPaugqovv+NiuU2kaUl30I2vRPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cDX86SA7; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593DVJhj015793
	for <linux-fsdevel@vger.kernel.org>; Fri, 3 Oct 2025 22:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=wBG7wUv0edp5jHd1pjT0VlKBuIUX7DoonTw/M1wAUhI=; b=cDX86SA7
	84p5m4frVoecefV9EuNn1PspBi8shJ/9oShOhLLyl46cppYnSJz0wS/i5BGhgcq0
	3Co4iUEmWRUxxQeO2tqSYuyeJP6pKc8cx2xRXsS8npo4vFzXckLzNP+j/9XLDuD3
	K08Q6Hha2MQcNigb7BcWq9wtVv0oXtk4RciBxP1wVCntXH8FspGtY8pm4Gg/dbdY
	RNnVUqdOSYTZwg+y+twVKVZ6/eU0zWmfvEqIkyeGlQv+A5b7pPFwjmvZekAIi3cU
	lu5jW5N5607+YQzg9lceGGG36C5kjVhN8p8KzSvfs3Fpihtoue7gKzLvySaSVUWh
	TDSNQTQbjPlpZg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e5brctkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 03 Oct 2025 22:40:24 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 593MeOmM016623;
	Fri, 3 Oct 2025 22:40:24 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011035.outbound.protection.outlook.com [40.107.208.35])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e5brctkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Oct 2025 22:40:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/3LjWhh7yCAamxlB3MjxBfWUXWu9NTajhOSJIt2554vu+tutBxMrOhl/linAS5dZWuAyNVInutn1R9J+WY+j7dvHtAxaNWXgOJZiCpT0cQTWL+y2EymPV9nIn4VXY0Amn0QXmTXAdJDoF97uCrCcxOf53Y3v5VID7tzCz65+B7BYC187iAnXIta8rdrfdM62lnVGfdKH6yFnRxNQmX0s5Vt3nCD1Abiyjiasw7ckhFRD0JoxtWInM9yihJBJE+3AYfrDvQahmKE9gYvyALdp91MspEelFJx5X7ttGY7454gFJkpOEi97voMB/AbKLYE+DCvnwf9RGLHuNsl03spTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekRnwiBOTZox4BZw2lYWd38exrP1WOmwumMN6sw6wJ4=;
 b=fhZkHe+VJeYft5ZQMoMzVTIeVELRuNKCiR6fnEVUC4uZ79+IAhN1cdcp/kx+49oXBQL6QMiI5nITfoRsFM8kGyCALmXvpU9TL5mW+TH4FyiZhq57s18weQzM4+hVu2JAyVX69yx332v5XqV0hTn9b2A6HGsPuH48ULyYQGsjVJZSiJ2AWMgAZ8Cu3ZoGzWzYsdylGCOSIXAuOOE/KFRIB7MHuh4cKozbTvTkSZ/FXcb9MHk2tk1yMD8roHpmEnwoLcQUFFgi+fADl3eQoH+9b3KOQeo1eOo4Z8CW/kYoMiNk54nYxl2fkTypwqT9WM/WTB6XQXFiCsqnV31zXQG7NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA0PR15MB4016.namprd15.prod.outlook.com (2603:10b6:806:84::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.19; Fri, 3 Oct
 2025 22:40:17 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 22:40:16 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "contact@gvernon.com" <contact@gvernon.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: "linux-kernel-mentees@lists.linux.dev"
	<linux-kernel-mentees@lists.linux.dev>,
        "syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com"
	<syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] hfs: Validate CNIDs in hfs_read_inode
Thread-Index: AQHcNBABQS6C58hz6UKqNecmAmUpVbSxBUAA
Date: Fri, 3 Oct 2025 22:40:16 +0000
Message-ID: <405569eb2e0ec4ce2afa9c331eb791941d0cf726.camel@ibm.com>
References: <20251003024544.477462-1-contact@gvernon.com>
In-Reply-To: <20251003024544.477462-1-contact@gvernon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA0PR15MB4016:EE_
x-ms-office365-filtering-correlation-id: ba42262c-a93c-4093-c231-08de02cdd33f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VzNieUFuSS9TcS9NTG83aHNwNElmYWFKNjB6cldpWWllRjJSV3N6TGhXclpk?=
 =?utf-8?B?Y2NJR0grSFo1NXUwMWk0dE93a0w2d1dxeVBMMWNabDZ1RVFXRTY3TE9ONXB6?=
 =?utf-8?B?U0RhZkI3R0ZkVUVEam9DMW95VVNhOGhCSSt3OGVGYS8wMSszWkorSThwT2p5?=
 =?utf-8?B?OEpzZG5DUm1rRHZ4azRyUnpNeTV1eEZxcmJSWXdSaDRHMVBSU3F6OGFJSTU2?=
 =?utf-8?B?UnZuT0FOdUhMT0JlRTZSVTI2WFRpQVVOYy9mc25xZDZJdDhOVG1CVU1NVEQy?=
 =?utf-8?B?SllRK2JPRUFQeGdFZ2JiOGd6VC81ZmFSbVdKKzBKb2ZwY1k2b3RWRTFCb24r?=
 =?utf-8?B?dVVvSzVTU1MwbEdhU1FaYzBXenphc2pXR0pkNTNZUWpiUjIweGRLTW16dFlw?=
 =?utf-8?B?N2Z4SFFBSHpRVlJYQXRidEZTL1pVMVp4MnVJanBPY053U0pCZDI3a25Rai9V?=
 =?utf-8?B?T2gwR1A0cGNIL2d6WXNOL0szVEdNWFh6eHNZMy8xSnpZNUIwVEtEay9VQ1Fx?=
 =?utf-8?B?aFh1ZWhQbDdwMzUwd2l1aXdWUkp1K0IzVWlJa2pLbVh3dHlQVXNkSStFWmIv?=
 =?utf-8?B?R1MvVlhHVWUvUkZuNjE5SkFrMHU4RkZlSXRpRnRtRnhzUktIRjUxUVlxZnJY?=
 =?utf-8?B?QVBRN3J2SGlndVpMU3B0VXRhRmloMW9VRnptcUZ5Ymd2NG1mdEtUMlVvOGhN?=
 =?utf-8?B?K052YThKT0o1aXVITk9pK0drME1GSUhXbWRPZVhyRGRVZWF2dllCS1h2ZS93?=
 =?utf-8?B?UHpMZDVhSDNvbDdyN0dkUDY1bWtnQktuRFJ0RlozTEdLQzJEcG5jY3E3TDJM?=
 =?utf-8?B?Y1hjZFF4Yit0S3lud1ZUUVRiVWpReEpOSGVpazdVRVNIOThjSzdpYklDb29m?=
 =?utf-8?B?SFdoUFVQdEFEZ3JSWnB6TEJacVJ0ZXdRV01EVTZsRnVoZGhHdi93b3IvL2tF?=
 =?utf-8?B?Q2xLQ3NDTUE1bGg5Zk5wWHcxcHA2QXUwSGtkZ0VVcTY3TkF0aFVDdlZ6ZWtn?=
 =?utf-8?B?YVdGOElMeG9hMk9CZzBGYnE4a1QzZm5SZ25ZbUJYZUxmVmI2RzloUlhGNVg1?=
 =?utf-8?B?cjdGd2wzb0l3Z3dER041ODVTZk1Yb3UzSGJtSXpONlFmMWFtMFFEV1RHUkNI?=
 =?utf-8?B?K0tCWkJ2ZWJXc3doTnFETUp6Y2xqam5YLzREQmNQKzhZcFlGbU1PUllVS3ll?=
 =?utf-8?B?YlFPVGJuekRMdGUyWXpjbVJLbGJ3cUUyWDJxZjRiRnlWZnJHWlNGekVWaVY0?=
 =?utf-8?B?RDFtM3Q5enM2WmFkSEU1MTc1RlNHWjh5NjRzQ1Z4YzZEUkhZakxMRGZlVjMv?=
 =?utf-8?B?eG9ER1k0bVc3VHExMXJNWVFYK1ZNSUJPc2VsTjl4cmtVSlRIYUxka05RaDIy?=
 =?utf-8?B?UFFiUm5XMmp3QllpZjFLVm9UNThrdkpnekh6ZnErMWRPU2czOE1FZ3B6RFZm?=
 =?utf-8?B?NWc5Z1hqZDVJbHowY2ZGWXMwdWVMaEJjZXlSWE9IQTFWdE5rS1A1RWZDU2JH?=
 =?utf-8?B?L3pRREVMeUMybDBBRHdyTGZnL2toN2NIaVR3enNBSnJSbUFmekZDbzlDa2FK?=
 =?utf-8?B?TUJGQnNzK2hCaCtySE1rbmZuR0tOVDEwYWN5d0RzVjlrWG9WUFZlemVsRTZG?=
 =?utf-8?B?YjdRVG84RkQyNUlSc0Fid3NXamRlM3dmS2ovVEdjK1NIVmMzaVZRYkZla29Q?=
 =?utf-8?B?NFVoTUlYWDhhYllyQVAxU0xlUVVxOXVvOUl1T2ttbm9pNnNuY1VaYlZpR25F?=
 =?utf-8?B?MVorYkozeTBFM1diR2h2M04vY250dDgxaWY3SDRKTTJUOE4zTzRpL1JtY1hs?=
 =?utf-8?B?TXRxNWZSd2FFZlNHYVYrQXFyS3R4Uk9SZ0kvaE5BRTNBN0tHN28vRmEwdUlo?=
 =?utf-8?B?dlpucXhOTlpyZk9UTUpCUGt0S3M3a1Q3dGNodlFCS3laeUZrWU1vM2gvQmJM?=
 =?utf-8?B?WHkyM1FXN0JQaSswVjBrb2lrZ2VacDE1WGczMWNtOHZHRkFQanZMdVdsckhP?=
 =?utf-8?B?UmhYQktYNDh3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QjY5VThET3dsclJ3OExmWHlBTU5GVTdTbU1jVlVjQXd4Nm5NRVpZdjN3TDFM?=
 =?utf-8?B?K1FESE9Ya0xoNFZ5bWd5YWlEOXBzUEhSaGNjeGtNRFA2azJ6TW5jdm5DMjdR?=
 =?utf-8?B?eTUwVEdPNTF4OUJsYzF0NDE0anloTTBKd042ZHJsb3JPeE5xZXM5cnpBY21T?=
 =?utf-8?B?bXNBeXdYU3JhamFVRHUwdmdWQ1doN0Zub0dIWVFSYjVFNmVRMkwvT0w2YzBT?=
 =?utf-8?B?bDNNaUVEVVowRHE4M0ExMVJWS0lqSnBQVFZQZE9EWjVxTExiWGhrZS9pQzI0?=
 =?utf-8?B?K1hEOUJkOFY5NlFQSjR2NmFBWU9PMWZoNTh5eTFXZzE4Wnh0RjE4aElwWmY5?=
 =?utf-8?B?SmdnTFpBNXZoK3VvVVdneFRERnVPNXZBRURtOVBsRUU0RW1hVmJqVTA4RFFI?=
 =?utf-8?B?Y0x1L2JNV0xxbWpSRHBDdUNxblZadU9KWERVV1c5NWFJVFdaQzNrc0xZQ1Bk?=
 =?utf-8?B?SEN5WlovYVZ6SWhFbkx5TXNQY29UclFxc3pWUUcrY0ZsTHFsdWNZZG5FQUVh?=
 =?utf-8?B?QVZodFkrNUNtMDB6blVqcnBnRlVETUp3TTYvaUErZTZoVTAvM0IzNWJSdnJu?=
 =?utf-8?B?cmJDTjR6dHdscml6NUlBZlllV1luR1U3akE0dnRoaXpIVVdpejhzYk5lamxs?=
 =?utf-8?B?ZGhtZEl2clA5M0hCM2IvN0s3aXc0R3F3REVKS1hhWnlsMUFvVjRRU2VUaSt2?=
 =?utf-8?B?czZ5UE9TdzhTQ2hidVQzaE9tTXl0d1hMVG9wakwyajkrTHdJdzlRVldFN0RZ?=
 =?utf-8?B?ckwva2d5SGFSRUlQRjFIWHhSdHNZSnlQbW5lOTJJd005NzlZQ045Szc2K0lk?=
 =?utf-8?B?OStCdkViWUtrR0FtRzdlUWZSVlJzejFLVG5iUi9OcUpnSU1YVFMrSy9VNnZp?=
 =?utf-8?B?TUZIKzI1UWRRankyMllRSi8vMlJkNGJzdWZKa2RFVVQrSmVuZjZiUkdxWExD?=
 =?utf-8?B?UjlhMGpkRmhqSm00aXZaajIwMjhqejlMUXE5UFJuSmg1MmduT3dFcmlORnA4?=
 =?utf-8?B?T0dnRloxdFpNSWU5L2lBUFpwSUdVcjB6MVFGdEJHczJzSXMrRkJFcGQ5eGdB?=
 =?utf-8?B?Sm1wdUJWbFRocU5QQ3pnTXdST2piMTBGSDVXSWNKM2NraFl3MUFxMW04UFJF?=
 =?utf-8?B?TjJkaHQyTllOQXIvd3VqdzNmYVJ2ZVZyanIvSVNqVFRrcFE2YUJuY1VMSnlH?=
 =?utf-8?B?WElHWGVYWGhQTk5PMUhCWVNiMlkrVVUrdzAwOE52cTZtdmNsZGlUL0tRWlBn?=
 =?utf-8?B?VnpxT0gwVi83WVdLNmhNWW9OYTcySnVGYnl0Y0VrN3Eydzl5ckdXeUNiQWpL?=
 =?utf-8?B?TTBpTlB5UWRSdVNMcDUyZStmaGR6R1h6a0lLZmtSUitLUlpLdTRXaVN1elBL?=
 =?utf-8?B?U2IvT2t1QVJ2S0tUdWNjZXNDUmxTbGhFWjJvM1N5SUJJcFZCMGNFSXhibDlB?=
 =?utf-8?B?dlFCQnpQZWRRUysxa0s4RXlFVmlkcW1pZnNzMi92aWZ3L3JLUU9CRk1yYVJ0?=
 =?utf-8?B?UmxWMHdmbWxvWUQrNVhPN042NmdJejNFazhiRXRuSDJ6UmRKcFlnQlEwQ3hN?=
 =?utf-8?B?ZFJGbkx6RU0rN2dMeWlCSzBmTUcrQXlIYm1UZDdCbG8rZk55dCtZMWwyZURn?=
 =?utf-8?B?MU1wSEpRdHRDb0xpOHRYOGJXWjk2QnMxeWt5dUFpTkIvOFJZME5QV1dqMUpa?=
 =?utf-8?B?N2tlY0NXbUNGZXdNVXZNNlR6eDFDeTQ3R2lrc3ZqMjFDSGdnN0RlYmhaOUQw?=
 =?utf-8?B?RkNYaFZnSnArcUlxaXB6d3Z5Q29wSHVaUXJTblI1R2VnTXNVQ2wyWE9saGsx?=
 =?utf-8?B?Y1hBUTJjMDduS3Q3aW4zNW1uUVZ3ejlZUE5tNjhzQ1BnUmtodk1MM1oxelpN?=
 =?utf-8?B?TThCYndGZjBkTEp1cTBDVEFzeFh6bDd5RHYrRFNBb1h2dFR5ZWRpUUtnNTJr?=
 =?utf-8?B?K3Nsb205eVMvc28yNVpNRkRqUzhhNUFTRmZtakI2TmM4NVB0cHpkSFRyOXR5?=
 =?utf-8?B?dDB3V0VjS0R6ZmlNb2F2VEh5Q2FhUFIyK25CR3FJTUNOeW5GUG05VC9scDgw?=
 =?utf-8?B?TitYZVlleG9jT0I3Y0JPNEQyKzFGTnlOT3dROG1lbGUxc2VWTzlicGNybVlm?=
 =?utf-8?B?ZWdmRnlEVDRiZmFKZmhOQlBBVUE3SHhRelRabzdGRXc1VE1YNlNMRFh4Rmgx?=
 =?utf-8?Q?NrqQ8N4KqrUKnwSu78Ziyrs=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba42262c-a93c-4093-c231-08de02cdd33f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 22:40:16.7657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /7BJms3xYEUVKODRyGtB0i8bUA1OwHRhnPHXDo67QSIF53udkiKUXEEsIVbfXO96Ci9YtXhGfYRW0VILi5PKtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4016
X-Proofpoint-GUID: qIIiWRjk_YyP68R79JBKEOB5c-RcY-KY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDIxNCBTYWx0ZWRfXzB8mVVhpdvUj
 NyL/9Bb2Z4ONvyBiZ11B/f6ciRye5K7skhoU2OB5VS692dtE4NAg2AJ41zzSAE2aC7y/tDI6Ztb
 rGng/iRAGyi9M6l6p4H+5ozc3446kgLQ2nKWeNntcK/HIQ4y/ZtO9Mjjc9v+7ph4udsqRvyyOW1
 OgOzJoae5eh5aR9Q/ASrBY7AvrWqj2F895wDeXPqDLet3yNKCh9hE7Yvt3o35WByVTa1Mrhsl+l
 3Tq1ltZWCqBcSjcf8fQeq+u8jPC13wzPP5c9TNO0YijDlD6seX3Cvva7RAHJAawpHfmCvt6wEwn
 VIxM2lrwN+DVrRSGdWGaBK68qwOO30OAVniojhAPirNauMuUCpNlgYfa/G5oavOoemIaNcofjSJ
 2An2yvuqv1QufK5hWUnfV4LGl9bHKg==
X-Authority-Analysis: v=2.4 cv=LLZrgZW9 c=1 sm=1 tr=0 ts=68e050d7 cx=c_pps
 a=pKPYWX2mfyrwmcKrUbCwIA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8
 a=3HEcARKfAAAA:8 a=EsNrEehZB2DcdutS4ZAA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=fDn2Ip2BYFVysN9zRZLy:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=SsAZrZ5W_gNWK9tOzrEV:22
X-Proofpoint-ORIG-GUID: qIIiWRjk_YyP68R79JBKEOB5c-RcY-KY
Content-Type: text/plain; charset="utf-8"
Content-ID: <E16D357032C95C45BE14CC3C7B9CD35C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [PATCH] hfs: Validate CNIDs in hfs_read_inode
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 clxscore=1011 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2509150000 definitions=main-2509260214

On Fri, 2025-10-03 at 03:45 +0100, George Anthony Vernon wrote:
> hfs_read_inode previously did not validate CNIDs read from disk, thereby
> allowing inodes to be constructed with disallowed CNIDs and placed on
> the dirty list, eventually hitting a bug on writeback.
>=20
> Validate reserved CNIDs according to Apple technical note TN1150.
>=20
> This issue was discussed at length on LKML previously, the discussion
> is linked below.
>=20
> Syzbot tested this patch on mainline and the bug did not replicate.
> This patch was regression tested by issuing various system calls on a
> mounted HFS filesystem and validating that file creation, deletion,
> reads and writes all work.
>=20
> Link: https://lore.kernel.org/all/427fcb57-8424-4e52-9f21-7041b2c4ae5b@ =
=20
> I-love.SAKURA.ne.jp/T/
> Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D97e301b4b82ae803d21b =20
> Tested-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com

Let's pay respect to previous efforts. I am suggesting to add this line:

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Are you OK with it?

> Signed-off-by: George Anthony Vernon <contact@gvernon.com>
> ---
>  fs/hfs/inode.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>=20
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index 9cd449913dc8..6f893011492a 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -321,6 +321,30 @@ static int hfs_test_inode(struct inode *inode, void =
*data)
>  	}
>  }
> =20
> +/*
> + * is_valid_cnid
> + *
> + * Validate the CNID of a catalog record read from disk
> + */
> +static bool is_valid_cnid(unsigned long cnid, s8 type)

I think we can declare like this:

static inline
bool is_valid_cnid(unsigned long cnid, s8 type)

Why cnid has unsigned long type? The u32 is pretty enough.

Why type has signed type (s8)? We don't expect negative values here. Let's =
use
u8 type.

> +{
> +	if (likely(cnid >=3D HFS_FIRSTUSER_CNID))
> +		return true;
> +
> +	switch (cnid) {
> +	case HFS_POR_CNID:
> +	case HFS_ROOT_CNID:
> +		return type =3D=3D HFS_CDR_DIR;
> +	case HFS_EXT_CNID:
> +	case HFS_CAT_CNID:
> +	case HFS_BAD_CNID:
> +	case HFS_EXCH_CNID:
> +		return type =3D=3D HFS_CDR_FIL;
> +	default:
> +		return false;

We can simply have default that is doing nothing:

default:
    /* continue logic */
    break;

> +	}

I believe that it will be better to return false by default here (after swi=
tch).

> +}
> +
>  /*
>   * hfs_read_inode
>   */
> @@ -359,6 +383,11 @@ static int hfs_read_inode(struct inode *inode, void =
*data)
>  		}
> =20
>  		inode->i_ino =3D be32_to_cpu(rec->file.FlNum);
> +		if (!is_valid_cnid(inode->i_ino, HFS_CDR_FIL)) {
> +			pr_warn("rejected cnid %lu\n", inode->i_ino);

The syzbot reported the issue on specially corrupted volume. So, probably, =
it
will be better to mentioned that "volume is probably corrupted" and to advi=
ce to
run FSCK tool.

> +			make_bad_inode(inode);

We already have make_bad_inode(inode) under default case of switch. Let's j=
ump
there without replicating this call multiple times. It makes the code more
complicated.

> +			break;
> +		}
>  		inode->i_mode =3D S_IRUGO | S_IXUGO;
>  		if (!(rec->file.Flags & HFS_FIL_LOCK))
>  			inode->i_mode |=3D S_IWUGO;
> @@ -372,6 +401,11 @@ static int hfs_read_inode(struct inode *inode, void =
*data)
>  		break;
>  	case HFS_CDR_DIR:
>  		inode->i_ino =3D be32_to_cpu(rec->dir.DirID);
> +		if (!is_valid_cnid(inode->i_ino, HFS_CDR_DIR)) {
> +			pr_warn("rejected cnid %lu\n", inode->i_ino);

Ditto.

> +			make_bad_inode(inode);

Ditto.

> +			break;
> +		}
>  		inode->i_size =3D be16_to_cpu(rec->dir.Val) + 2;
>  		HFS_I(inode)->fs_blocks =3D 0;
>  		inode->i_mode =3D S_IFDIR | (S_IRWXUGO & ~hsb->s_dir_umask);

We have practically the same check for the case of hfs_write_inode():

int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
{
	struct inode *main_inode =3D inode;
	struct hfs_find_data fd;
	hfs_cat_rec rec;
	int res;

	hfs_dbg("ino %lu\n", inode->i_ino);
	res =3D hfs_ext_write_extent(inode);
	if (res)
		return res;

	if (inode->i_ino < HFS_FIRSTUSER_CNID) {
		switch (inode->i_ino) {
		case HFS_ROOT_CNID:
			break;
		case HFS_EXT_CNID:
			hfs_btree_write(HFS_SB(inode->i_sb)->ext_tree);
			return 0;
		case HFS_CAT_CNID:
			hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
			return 0;
		default:
			BUG();
			return -EIO;

I think we need to select something one here. :) I believe we need to remove
BUG() and return -EIO, finally. What do you think?=20

		}
	}

<skipped>
}

What's about to use your check here too?

Mostly, I like your approach but the patch needs some polishing yet. ;)

Thanks,
Slava.

