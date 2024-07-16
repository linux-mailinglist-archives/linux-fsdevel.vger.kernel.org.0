Return-Path: <linux-fsdevel+bounces-23794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C0993347B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 01:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A13BF1C2243D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 23:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8C5143C61;
	Tue, 16 Jul 2024 23:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rhs3I/A5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ddJRBD++"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0316B13C693;
	Tue, 16 Jul 2024 23:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721171576; cv=fail; b=iPUtrqtLOfDwJsFfrpcbof2k7TCXDnBgyfJdassNczk0S8ofgilceCVQEeKgBjVZEjZWfJp83wkZxGRfMsNx5dtUK1mZYcGqDNCJwg0kshJSKLchHdbqDJP551K06obmpi6nhkNg0PwSsWMU8vRQk5LzKmmA4TOogGym7UXHtI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721171576; c=relaxed/simple;
	bh=86qTik8O1jFOodAmngULbyfW4WgcPYRSabxlzxJx78M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bof2euZ8vDwQDcyY+NwX2JiKYAZKtVFnDCQ5LB0uQioWJKyB7yQWQnDFB2jz8pnSAox/gqBshVMrIKGwq0PvBfYuTMt9WJEtUv/uEF0kfRjegMdJLbUxNG39yqKQdY1jz0Z0ODm+iA64N/9lRVPKkKWBouT/+4XI2esZMwuQftU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rhs3I/A5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ddJRBD++; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GHo9JD014580;
	Tue, 16 Jul 2024 23:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=86qTik8O1jFOodAmngULbyfW4WgcPYRSabxlzxJx7
	8M=; b=Rhs3I/A5V5/XA2uZ74hBt2xndTIJM9Mmjukic3oBsdhtEbPckZj3dR7Rd
	rwEREczKwKFNkZU5WqVZvgC1SuGI0eswR3inR5FZdcFGAdesle+wG8ftcjbIBRi7
	xr/kWmhDbeTy6q+jzSkwsZ1e3a6aet2C64Mr5lpC5rHCDk2RJTh1l8lv+vHWue7W
	Wsfk0Zo+6V2xhjij44ryZExuAI3wTF10fGmiw5JQOZI/J4XmOiKlnu/voN9dhNGw
	abFpk3rqimKWOhmq3L5MUGFewTuq6XOVEryf0EUH7KxT86wcGblkPujS++yeHFT8
	X/ZmkScvHyK8Rh17zdy4aluzvOlMw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40dwm20hjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jul 2024 23:12:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46GLPIu0031727;
	Tue, 16 Jul 2024 23:12:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40dwewjy5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jul 2024 23:12:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DywkjuGxUfgr+obVuXgdPy6hhhl6oDNAox75ZRrYHI/JrXbDlMUGZtJ8+TKfEJuBPnCxWsAyJCYnc6rjXSnNHXgaFnN5voMEsA0M9ynQv0WSCqXz78uC41Wvt/UHDVXJBFFh2l5zBN7qAHAh6p/CVQ8f/2VHnfWhYwWyUri8CA72ybTNRFll9pPr+1jzUR26Ih5t7VqVtihPggAO5mdi6MqOUfGPAw3Ja2cI83oeWfUVjhFzVqEgV9U5DAJJEdfrUOjZFpucs8+H7VXrRWDIwLexhNLNUNSIClSpRNXjeubx8B6jr060Us/wH6r07RJffda/xm1tsFQo4BaKlOVREA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86qTik8O1jFOodAmngULbyfW4WgcPYRSabxlzxJx78M=;
 b=axMIlal8KrdqOWvKOVXPv/A9Iwx99+NTMmEAGm5VLdddxTaLxf/5aP5H6mGQ2m2fasI5cS+HA+/wz6ClAiOGY/B1JgK1zPaAYS3AtFweaWLPt7gR150+oBng1nSyiJcmR1/1sDlFh8Laskj7a40GMzhf8LCI4XbkexB/rEjm/KMTrcSEtZZkmcIlUrbx5lPiH41iMaPQSVs2bY6s88SDZzjLwA+St92HiYxE2V3DRlkM2T7/TGgXIuLnHEzoHKKOjpQ4upQfAI/ddsZFk3voLdVD8zfzZV3FDUERuuEyzGqNkPBheMBzbQVK/1SJHyPoEcFEMydOr1giUptX/scveQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86qTik8O1jFOodAmngULbyfW4WgcPYRSabxlzxJx78M=;
 b=ddJRBD++QpgQ4JFp/hK632I5ySMgzYujLGK8O3OIF1Qvo3aMkrViDWKdQt3o3ChpoMjN6q3jkL5o7warE9wAhJH/a2/kp56NCsVQON5AZJXfBtbV1j/OqZEkslhjV1I/oPK1nrUJbSxIS5zhMCd3vgcSa+pEdzEu3KpeF4U6+e8=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by SJ0PR10MB4704.namprd10.prod.outlook.com (2603:10b6:a03:2db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 23:12:38 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 23:12:38 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Christian Brauner <brauner@kernel.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] vfs: ensure mount source is set to "none" if empty string
 specified
Thread-Topic: [PATCH] vfs: ensure mount source is set to "none" if empty
 string specified
Thread-Index: AQHa086IdW/ez7+AiEuJK3s7QfKT6bH3v2KAgAJEQIA=
Date: Tue, 16 Jul 2024 23:12:38 +0000
Message-ID: <3A273752-B947-4272-BA3D-6DA33253A4C4@oracle.com>
References: <1720729462-30935-1-git-send-email-prakash.sangappa@oracle.com>
 <20240715-abgibt-akkreditieren-7ac23ec2413c@brauner>
In-Reply-To: <20240715-abgibt-akkreditieren-7ac23ec2413c@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|SJ0PR10MB4704:EE_
x-ms-office365-filtering-correlation-id: 856a3b44-ac3d-4b3d-5283-08dca5ecc8e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?NWRhY09MNkNtYWdFb1dWVkhsSDAxV1FyUTFXWWNLNGVMUlUzZTBIOU90SVI4?=
 =?utf-8?B?aWp4dFB2cmdxWTcreWUzQWhveDNER3Vxcjk4U3RuQmVyTE1Da2hWT09UYUZT?=
 =?utf-8?B?RUJ5TEVMaytPeng0WStxTWpsVHFuUThTWE9OM1hrcUh0TXd4WTVjN2hGU0k0?=
 =?utf-8?B?Z1VLTFl4YmZWQU0yalZoWEhJYUMxajZJcXRGZFJoNEZFeWp5R3JReGtQODBC?=
 =?utf-8?B?bTZWY0lFQ1dBMEs1cVJFS1JidGxMT1Bnc1Jja2Rra1kzNTdFT0srTHdPWGFq?=
 =?utf-8?B?QXdITGMvOWdSZE44Y1hNaW9VSkhBc0RWa2RtbmF0OUQ0aTg4a3VuVXhkaWNK?=
 =?utf-8?B?aUpMVDlGQ2dMaCtmQ3hXWDQwcEdlNVh5NnlITHczemZMdmFoZ0FKNDNnODdN?=
 =?utf-8?B?Qi9LeUFZTnBtQkM1YjQ2Uzc5K0RhRUd1VkxQemduRHJRenJCZ1JIWW1TM3hs?=
 =?utf-8?B?ZG5Sd1BNZU93Yi9sL25OellBOFdtL0MvbmUyazJrdmR1Z3p6cnBtRFFJWitr?=
 =?utf-8?B?VGh4Uk9yUmNKd0EzRnNhVSsvQi9PZ1Z3UTlRd3EweWJod1dyWE9BVnZIZFdK?=
 =?utf-8?B?NzNBQ0RINkROT2R1c3oyT1g0RlZ0RjE0RTJpb0ZwaW5aSVVadnpNR0xtN0lL?=
 =?utf-8?B?MzZzUy9xVFNKYXdjc3VzdDUvZUQwWXhtVkNzRjNvMUYvMklSQ094QUN1NjN6?=
 =?utf-8?B?TzVWN1FScUNmVzFweHdkYWp0Q2xFNHZ5eVNlTGpKUWI2aFZlT2VZNDNCK1Bp?=
 =?utf-8?B?RStRWC9HcEhHN0tmbFpLK2tqV1FseFFJcUM3SE8vdHdKeXBMa2pFTTV0bW93?=
 =?utf-8?B?Snk1Y04rdFE1bXVoZlB2QlRZT0p4eGpvK2g4NkJNbHB3TDB2QWJQcEJkTnBa?=
 =?utf-8?B?UGR6dElrL1AxdnVneFJ3ajVvT0dQbFdSc2xrbHloem5ScGl6VFBSeFFhRU5M?=
 =?utf-8?B?OGJDbUdCZ2pDOTROMDcvSG1nWHBaNnpGRVp0T0JaRityOElUTUNsZG9DYlZU?=
 =?utf-8?B?ZlBGSXExaGtudWRjNjVKZUhRWWZ6YVA3cDFvb3RyK1JUdjJZUytxb09vLzRK?=
 =?utf-8?B?TTUyd1VyNEtwSDBGQU1PNDVQWnRIZEl2a05pUExiNXJKOWgwNkt3K3FnSDhq?=
 =?utf-8?B?Yy9IOHIrTDczNDRQKy9lOXZqNkY1NUFvam5VQzJUVGwyb1EzMlFyME1UdlZ1?=
 =?utf-8?B?ZEorZTkraW1pZ3lYWXdjZlJwWFYzL24wVExTWmt5VGdrM0krckx2bjA0TEp1?=
 =?utf-8?B?WTNER2NSYkIwUndCbnhHSEZXaVU4VUVHU2xZVlhFRlVhcGFqVlFsbjFTSE5u?=
 =?utf-8?B?S3FCUVViQ0lWckc4ZVRxODVVTy91TUZIb3dnalJSdGtnUVp3Ykk3SjNYaDdO?=
 =?utf-8?B?MkMybDBLZFcrNzdGZ3JBdmdUWSt1UVJabExUbjNTZ3JDRjZGOHlEUDVVcHJB?=
 =?utf-8?B?Z3ZCM0RISXdWTmUrOE9lZmE2SngyTlZlQVFuNkFYOHJKWDRmMXlmK29kNWJl?=
 =?utf-8?B?NnNYMkhqaGx0UzR6bkNNUEdVenlQWDIrOFdVU1BrSE1qdzBMam9raGtQckZw?=
 =?utf-8?B?aFRDWW9HUVd5SGhJcWd3ZWxZWDkzWDlsYmt6SjlCeHJveXhVNVJ6ckk1NWM5?=
 =?utf-8?B?ZHozWEF5MmZtNStMYmdveUlzNlp4b2ZvNHQ4TWw2VGNKbHRSVXpicUxCdGFJ?=
 =?utf-8?B?MGFmdVRkZ0dVZENLZjJkTkpEUURoRUxXOUdmMUswZm4vMVFNdVpnRFpuNUdk?=
 =?utf-8?B?TEdORFdRd3VxYjdWN3ZnQnVFQ0FWWFVhWUN5WG5iRVNlSGFCdE5paFZjUTJi?=
 =?utf-8?Q?cK9IhNZMTssIvN3UgWGDVVX+auU03JNmXj3Dk=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TnNoc0thb2x6YzhnM1NleFBFZjFDOHJrbDFyanlBWWpFNUl4OGROQVVaV3I4?=
 =?utf-8?B?S2hTTUFIbVVTVUlNaVdOWjZDbnBScFJJdWJCa29aK1NrSlhEbmhrNnVUdHE1?=
 =?utf-8?B?MmZISEdvb2tmbzdEbzRDS0ZhdVE1cmJFanZhVDl5ZUZidWt6N0dYb3MxYzZm?=
 =?utf-8?B?Vlg0T1FoNzRsQ04rTGRSK2thTGxOTjR1U1YwTCtCWE5scVRkVncwWVVLZGZ0?=
 =?utf-8?B?RElid1RMMC9ORHhTZlA2UTlwMlNQZU1oaUQzZWpKQjBkTmcrTk9VT1F0dVp2?=
 =?utf-8?B?MkVQcTNWUHpKVXFSR09wd2U5aG9sc2Z0ZlZCZ2ZrUVBzSmlnVnpBR0hQMXRL?=
 =?utf-8?B?S1c1UExsbGR2MnltcHc2OFJ4TXZwK0ZhU0RqZk1NRnc3aHRFR0ZPc3dZQWdG?=
 =?utf-8?B?SVZ4S055MUZoQlE5ZTYzaGFCeDVwSkNYdUFWNnN4dWFzZ3ZFVVdFcDRGLy9w?=
 =?utf-8?B?NHQrU1h4bXlaclF1c1ZZdm9XZXd3OE16L3U2VnNHMk5lUWN5ZHdwVExUT3JM?=
 =?utf-8?B?clVkMGJZakNIdWxOa2cyODJ5dXd3NWxteHpKK3ROUFZMNGpoc2J6QTNjZnNT?=
 =?utf-8?B?T2xKR2dEM3lZdWJ6MFpkT2c4djN1ZTMwdGNpaUVFNjE0dWNiZ010UytYazMr?=
 =?utf-8?B?bmt2dVUxNHpoOGphNlJVS3VDOUVWRWl1L2UwNlhCWDBVSThEYnFIZ0ppV28y?=
 =?utf-8?B?Tmk1T0dKNUtrenpJZVRNRTRJNk9iOVBRK0Y5bTFWNm94cEF2SUxaUGtBdnI0?=
 =?utf-8?B?NzVmSkFDc3cyYmxRbWxFK0M3VjVYalBGVXZub1FNSUd3VkpBT2xpR2RNNGpq?=
 =?utf-8?B?TFNsTXZTcG9ST3dta3pxUUJzdkJ5azNzREI2Y1RhMHVFb0lodnI0c0szckVP?=
 =?utf-8?B?dkVKcXNKVGdRS3AyNExzTGNaMUdLZjY2bWp2M3NKbE81VHhmcjZMNjZOcjZm?=
 =?utf-8?B?WGtXbWNpZG4vOXJMNHcrdWNCL3N4Y0ZJcGpSZ3pZaUZ5NHFOQ1Bsc1ZSUjNr?=
 =?utf-8?B?ZG5MalcveE41N2hFVmptSXJJY0crMloyKzRPc0thbHdvOHRyVVdGSS9ETGxN?=
 =?utf-8?B?K3BFcDludHZ0cUFvREZ5SHJxTGhuMVc4dzhNTklMOW5mWTE0Rjc5K0gwSFVq?=
 =?utf-8?B?a1oyTk5uRDhtTEZKU0lJS3NJOXZZMi9PeDNHV2o3WFphbm5NaktYQU9OZHky?=
 =?utf-8?B?QlViWEZUQng4OWlmVUVwN3gyOFZ0N2R6RmVJaElhWnlVSmIyTXN3RnZNRWE0?=
 =?utf-8?B?S05uVTVBb0RoRzBTMnRRSjJjK3FyU0gxa24rQUlURFFTNTZpKzVHZllMc25r?=
 =?utf-8?B?SC9Tb3lwYndkRkZlbDZ4cDFqS2dkR1dMa2dGUTNaY3FqakExYjlucjlUWkFT?=
 =?utf-8?B?bjdJK0FrVHVNODNMbDk1ODZLbWMrajBDQk1XYU5TU20wbFhaQlMwRFVLWlNi?=
 =?utf-8?B?MnRwcVlKZElJUHBMbGo2VUlwK3VZTlFsQVlEMDBDU0VoZnM5L2RNYkdDQnpJ?=
 =?utf-8?B?WHU1VHFMcU1OMGxuRkZ3aGN3bkFYOEc3bzBQeG1wdEZrd0JQcE9vUmJBRjNL?=
 =?utf-8?B?N2NESGU4MjZsWnZqMlFrblJCcW9IRis5ZVZQaE1lWU8yYityQkU0dHN3RVA1?=
 =?utf-8?B?TkNLSThPNGs4dkw3STJoa0ExWjM4NUo3UEgrUzM1RDNOWTBVb0tuUHdzVXNY?=
 =?utf-8?B?RlJsdTJVbmtPa2xBYzNVOGJKdG4vOXM4clJLVGdKQ1NQK1ppS3hqZkoxM0lv?=
 =?utf-8?B?dkhVTC9EajljUWl0TkY0OGIvZzFFd1VJUmhwMTlEYjN4bkk1RnVEZG1pNW8w?=
 =?utf-8?B?U2Q5RnkzMnBnWGQxQ3VkK3BHbHR2UHJnMjM3bnBJeUFJOG9GNDYvMWlCSUEw?=
 =?utf-8?B?ZVQ1dDhadFlHalYxUkRQUDR6OXdaaXNFUkY2WlpwY2RON0g5cWZBd2YvMFVm?=
 =?utf-8?B?QTBtcVRZVUI2S3l0UzJDOEJXbHVkNVdDMUpXQWdlYTg3dEtMZ2kxTGN2eThw?=
 =?utf-8?B?bWM0YUNYUDgzaDdCTE9Ib0oxbGJOSGlZN0VTVzBjTnlTWGV0QnZKdTVUa25F?=
 =?utf-8?B?ajJQSlY2aDZpUTlDc2dFdGJJNkV1c1BzODNBVnNnYmViSXNrNm9zU1pKM0xj?=
 =?utf-8?B?VUI3eE1BYlFyZHRpYnFrOWx4RXR3c1k4aERZbDVTZitGQVNFSVVJMjdoWnRt?=
 =?utf-8?Q?w3Ea2/8p29HhYKZwv6nIjIpbHRcNr0vN7yURxDCWRAlw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0EEB6BE5376034294D6A05A327D96D8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GOtvLFceLuQ1QIDJc9LxZF4dEMvwvbFGi/wnc9eGpbxDGZoLY9hPgko4wI5wqY6e9+CQmroBtXkWJ+Zhu5aErTdblldAaxcuPdzgYE1RoB3aw2KVnJ2YTnlxlPBR/vXsk6pbkN2aRwRHXw8zskypczs/Gu/BZpjFCU0DfHVerA7br05x6k8/zx69yHbUCejR1QBmh1NO9zSEdBqo1yifgXzCS3X1yedoh8d5SsCvH8HJFhewA+kCnqDweNKV4G3G2ITpbU4db5BeQML0YQZpX/cfMk7MRaXqHkF3IlQ06XaOd6UG1Ad1gdahhROSAdFV9g+TPzZ/LMG8ZJ4r3NLzCtCB+G9ToSvx3XTPuSn/CokFWhQwY8OgxDQKY1o8mIbn9xllY7S3YkXOYL6DKMFVXARkFPth6eDSr06vrR7q7LaMDRqNxGBKM6DrUuI705L7MDvwdwQq8QjCncSqNAMXazBc9lduawCoAy0UE26WRk66xwlPVcB8LA44xYoo5huuBEQ2fIACBQ5X749NPLVK3QWuwT4OooRy6GEIs11xMrssxcU0Rgy+R32vngHS07eW8wJsyc1UdxVPvx0QUJiaqbtqcefikZ3IwUegymF8RMI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 856a3b44-ac3d-4b3d-5283-08dca5ecc8e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 23:12:38.0784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PA2RrFdYauDU1a5sncNqkl4D/Cexz9NAW+t1GzIEJS9VDa7/YnZfFexbI0gww476n8UhWDaa5wUZJglBYX9sdFChJzudFbteHxyViYJA9zw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4704
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-16_02,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407160170
X-Proofpoint-GUID: x1EXDJ2tk5eGBgl3KIYz5UaxpNmQB4Dg
X-Proofpoint-ORIG-GUID: x1EXDJ2tk5eGBgl3KIYz5UaxpNmQB4Dg

DQoNCj4gT24gSnVsIDE1LCAyMDI0LCBhdCA1OjM14oCvQU0sIENocmlzdGlhbiBCcmF1bmVyIDxi
cmF1bmVyQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4+IFRoZSBpc3N1ZSBjYW4gYmUgZWFzaWx5
IHJlcHJvZHVjZWQuDQo+PiAjbW91bnQgLXQgdG1wZnMgIiIgL3RtcC90ZGlyDQo+PiAjZ3JlcCAi
L3RtcC90ZGlyIiAvcHJvYy8kJC9tb3VudGluZm8NCj4gDQo+IFRoZSBrZXJuZWwgaGFzIGFjY2Vw
dGVkICIiIGJlZm9yZSB0aGUgbmV3IG1vdW50IGFwaSB3YXMgaW50cm9kdWNlZC4gU28NCj4gdGhl
IHJlZ3Jlc3Npb24gd2FzIHNob3dpbmcgIm5vbmUiIHdoZW4gdXNlcnNwYWNlIHJlcXVlc3RlZCAi
IiB3aGljaCBnb3QNCj4gZml4ZWQuIFRoZSBwYXRjaCBwcm9wb3NlZCByaWdodCBoZXJlIHdvdWxk
IHJlaW50cm9kdWNlIHRoZSByZWdyZXNzaW9uOg0KDQpUaGUgY29tbWl0IG1lc3NhZ2VzIGRvIG5v
dCBpbmRpY2F0ZSB0aGF0IOKAmW5vbmXigJkgY2F1c2VkIGEgcmVncmVzc2lvbiBhbmQgd2FzIGNo
YW5nZWQgYmFjayB0byBiZWluZyBlbXB0eSBzdHJpbmcgYWdhaW4sIHVubGVzcyBJIG1pc3NlZCBp
dC4NCg0KSSB3YXMgdW5kZXIgdGhlIGltcHJlc3Npb24g4oCZbm9uZeKAmSB3YXMgYWRkZWQgdG8g
YWRkcmVzcyBpc3N1ZXMgd2l0aCBwYXJzaW5nIG1vdW50IGVudHJpZXMgaW4gL3Byb2MvPHBpZD5t
b3VudGluZm8uIA0KQmVsb3cgd2FzIGEgIHBhdGNoIHByb3Bvc2FsIGRlc2NyaWJpbmcgdGhlIHBh
cnNpbmcgaXNzdWVzIHdpdGggbGlibW91bnQgYW5kIG90aGVyIHNvZnR3YXJlIGJlY2F1c2UgdGhl
IG1vdW50IHNvdXJjZSBpcyBlbXB0eS4gIERvbuKAmXQgdGhpbmsgdGhpcyBwYXRjaCB3YXMgbWVy
Z2VkLg0KDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtZnNkZXZl
bC9wYXRjaC8xNTI0MTA5NjQxLTQ1NjE3LTEtZ2l0LXNlbmQtZW1haWwtY29meWMuamFja3NvbkBn
bWFpbC5jb20vDQoNCkR1ZSB0byBjaGFuZ2VzIGluIHY1LjQgdGltZWZyYW1lIHRoZSBtb3VudCBl
bnRyeSBzdGFydGVkIHNob3dpbmcg4oCZbm9uZeKAmSBmb3Igc291cmNlIG5hbWUuDQoNCk91ciBE
YXRhYmFzZSBhcHBsaWNhdGlvbiByYW4gaW50byBhbiBpc3N1ZSB3aXRoIGxpYm1vdW50ICB3aGVu
IG1vdmluZyBmcm9tIHJ1bm5pbmcgb24gIHY1LjQqIGtlcm5lbCB0byB2NS4xNSoga2VybmVsIHZl
cnNpb24uIA0KDQo+IA0KPiAoMSkgNC4xNQ0KPiAgICByb290QGIxOn4jIGNhdCAvcHJvYy9zZWxm
L21vdW50aW5mbyB8IGdyZXAgbW50DQo+ICAgIDM4NiAyOCAwOjUyIC8gL21udCBydyxyZWxhdGlt
ZSBzaGFyZWQ6MjIzIC0gdG1wZnMgIHJ3DQo+IA0KPiAoMikgNS40DQo+ICAgIHJvb3RAZjE6fiMg
Y2F0IC9wcm9jL3NlbGYvbW91bnRpbmZvIHwgZ3JlcCBtbnQNCj4gICAgNTg0IDMxIDA6NTUgLyAv
bW50IHJ3LHJlbGF0aW1lIHNoYXJlZDozMzYgLSB0bXBmcyBub25lIHJ3DQo+IA0KPiAoMykgNi4x
MC1yYzYNCj4gICAgcm9vdEBsb2NhbGhvc3Q6fiMgY2F0IC9wcm9jL3NlbGYvbW91bnRpbmZvIHwg
Z3JlcCBtbnQNCj4gICAgNjIgMTMwIDA6NjAgLyAvbW50IHJ3LHJlbGF0aW1lIHNoYXJlZDoxMzUg
LSB0bXBmcyAgcncsaW5vZGU2NA0KDQo=

