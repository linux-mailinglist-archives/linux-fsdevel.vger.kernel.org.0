Return-Path: <linux-fsdevel+bounces-62790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B498BA0FFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 20:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3595A1BC6FD4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 18:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15A4314B9F;
	Thu, 25 Sep 2025 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l6ecPzgM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2AC23B0
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758824599; cv=fail; b=coCTWSmhEf4GfTS6vsbdYhC86669dv2KXRGp0P6LZ9mVO9dVBHWdhb8L31uMtxCmt8XHRI0qxGN+2WhiHY55BlSvq6xeieSyDqjRcIj+cFLtvXRjhwNdt5/w0zIV3r6RLFaXuOMeXpGNvkt2eHVG0uaxablSSzWeTihp3eZFPiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758824599; c=relaxed/simple;
	bh=Q1w0qmKzZp+mO33nQW7FdINppdWW3J+6eEyd0ULHIpk=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=VNFZo8OY3uBF6EsrGyqLLuazd+uViDz11domgmmtg3X4dNvsv7cUTuyUDBQQWXSXHCLk6Z5MMl0Ux4a+JQzxahuyhbpIMUuLZjj54VMk5i2PbYreCqV4D49VdPvywN9wrCmJ6CzZ6gP1HoMnBVVrss6A6JHu7ZatlbygTE4rveE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l6ecPzgM; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PD8gY1013607;
	Thu, 25 Sep 2025 18:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=Q1w0qmKzZp+mO33nQW7FdINppdWW3J+6eEyd0ULHIpk=; b=l6ecPzgM
	K5UJH6B3oI43MFyFmmplyU9aWyvieGS5YTSOPDyszZg3lsn/F9zig1zMR9ZN1EG4
	KIkDz9luNrakGn5Ul3JhbLDZKrkoDQDdvpJLq1sAHASKEP6gLCLUtiFi3DfIQ/Hv
	mSKgephfa545k5iIE6MOY3hyHBJ1Fs2Ruzegxw8njvDweWsAKsQlYpOt3xnadCE2
	ZpV5aH7VuM6U+cAhrxZ3ktsdtc8pzU64ouGCj0YoOYHUihzv8jM/o1TkfrNL8kHb
	k8WDWVXXT9TFXLuudY7Yr87N2jJvFWN/cuJ8Hnf6vgMOv56kzBmJDYXBxKY5mRQn
	4kpBP+ZVdLnnvw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499hpqq24c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 18:23:04 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58PIDOkS023424;
	Thu, 25 Sep 2025 18:23:04 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010013.outbound.protection.outlook.com [52.101.85.13])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499hpqq24a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 18:23:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOoMrJn277N5gOi+O4cLfMo9zzHbdXzEwcRwzBpAVIXxkA5C2ecG/5WtXqLeCsRYTVjRTvl2NiUBXvNYXMO/52ukJ95uAP9wQ3IiCI7XwwMTPmlNjOZvGVQgtkCnmclVblBRrthJXSIPTaGgeaPSifhtn3V+TOonxQp6emS+yto2ELjtEE/h56gTvYa5EkhHY2aQoMD2zyn9GwSZH1L67sm4QFGkUk+l3QssQYOtMDWJ0zHEbw3AlMowLpKPDDWC0slpCii2CqJVd4Exw7MJA/f2s3qXLTFFh1S8JNwkVywz8vXSflweHS41o7nkohb0H4FTWivEfDjcXoMPJtKymg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1w0qmKzZp+mO33nQW7FdINppdWW3J+6eEyd0ULHIpk=;
 b=XLfwnxsczSD9y6+zmajT3NElUm5AcmnBBPOPgf/MgMRoeyZZ3CFk1P0vVFTeeO3lrULXUBnb9Is86F6KR/WSj7aYHYdkRrx7V+Y8e39ud3J4kw56+ne/CeLLNOktt2RS4e/HpoYFlCizowVnIs78F/W4W1ZQ8Tmi6f1bg2oCC4xrwlQ8XKDK9PR1F4ZUOraLQTHNchyBMcxAx/eSu20EBWgLXphlkZ66Oh6ZjFpTLNDd48LzaDJRta+ErlXFRyMQfASnbn0J2K80rpm17HTfD26AcK9Ux4y5y4GMfAmtkLGLtjbV+zXgjaayE6DPDezdY04dfnI2qjzVUOWgrBzcpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CH0PR15MB6293.namprd15.prod.outlook.com (2603:10b6:610:185::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Thu, 25 Sep
 2025 18:22:59 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9137.017; Thu, 25 Sep 2025
 18:22:59 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        "simon.buttgereit@tu-ilmenau.de" <simon.buttgereit@tu-ilmenau.de>
CC: Xiubo Li <xiubli@redhat.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        Pavan Rallabhandi
	<Pavan.Rallabhandi@ibm.com>
Thread-Topic: [EXTERNAL] [PATCH v1 0/1] ceph: Fix log output race condition in
 osd client
Thread-Index: AQHcLfIZdmtRVdfTjkaYS3SsCjO5C7SkNvIA
Date: Thu, 25 Sep 2025 18:22:59 +0000
Message-ID: <e6c49bab89d86831f546ca146ca2e67716e348f7.camel@ibm.com>
References: <20250925075726.670469-1-simon.buttgereit@tu-ilmenau.de>
In-Reply-To: <20250925075726.670469-1-simon.buttgereit@tu-ilmenau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CH0PR15MB6293:EE_
x-ms-office365-filtering-correlation-id: 3728f8c6-6f1c-4bd2-6e03-08ddfc608e83
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dzRFUkw4K1ZCV1ZKQTZFZXNuUk15TFViaTlsNGVDWHJNSUF0OEs1cm1XUmJK?=
 =?utf-8?B?Zm9Bei9oVGdMdzMvczRtOUtLRGtKVFh3WUdJNGlWSVpPT1hBMTFpY2Z1NDVQ?=
 =?utf-8?B?bkkvWm1wRVllMWE5cWsxeXZ6OVBCWUVydDgrR3JnK1lIeDdGKzBLc3JOaEJ6?=
 =?utf-8?B?SzNxZkdqakQxR1pVMG9PRGZEUHhDbUhaVWIvbGtSWG0zcDI1TmFIcHRUaDVZ?=
 =?utf-8?B?M2lLemF4eHRMbmk4NUd1T1VUZXgzRjM5S09QNTg2TS8vS1luRlJTOTFVYmNP?=
 =?utf-8?B?UlhHbEVVRHhkT2JCaFVSZjFGRHl6VWtaNFNUckM3eDdTOVhid0UzdWFoZXJ0?=
 =?utf-8?B?OXFWN1dzdDF2VWlvVU9lekVUT3hIaG02SVhvamVsODUyMEpTOHE2Vjh4U0NG?=
 =?utf-8?B?dkVNamRFMkkxZUZ1bjFReDdsRm13UnlFZ2NjMG9nMDRzYUVja3UrWWFNQWRZ?=
 =?utf-8?B?ODlycCtEbDNXUWd5K2RadlZHTTdmNzhyQU5ybmdBUW1CaWtZTS8vblVlbk05?=
 =?utf-8?B?Unp2cDhpZ3JBK0c4OHBNVXpuazQzOC80N1p5aXExWTIvdWRjRFdSa080cHB0?=
 =?utf-8?B?OG9TRHNMRE5tdVJYZFZ5dzNsVU5scCsrZUxuVjBHekV4UE1kRGtTUkNqOHBa?=
 =?utf-8?B?ckdzQmxqY25jSG5CcDF6NmdZd2l0Q0IvRXFJNHFRbEc3djhPWEtkd25UNzJz?=
 =?utf-8?B?eng1b3BXa2M0VG5uTG9XczhmWEVtVDhDTnBGdW9SK3NoSTJJU2RPY1EvNGtG?=
 =?utf-8?B?aXhBK1pFK1Q5YTJpL3NLYkwyMkorN1JPU0pnU1I3dVNMaVFmNFJEbHlsZ1RC?=
 =?utf-8?B?Uk1MckQ2NXVNeklzeVluUlBQT2xxdHFnT0UralJVODRudzduM1l4eUJud3Mr?=
 =?utf-8?B?U1FKSlZyeVVhbGNrVG1xdzJ6TEJuN0NYWllRODJvRjF0VDk5VU5rSmhBNHRI?=
 =?utf-8?B?cG1Jd21PWXhGVzlwcWJGNEJUdGliRi8zYlZkLzFLQkZKRzU1ZUw4SXpmSU5s?=
 =?utf-8?B?bFZHUEFWTFd2S2dOeHZzWlp1L09XbmdaTDNaTHJ1dVF4eFJkVkVDK3hsTmlT?=
 =?utf-8?B?c2MzeU13ZEdDYnNjY0lLbjMzVFBNejdqTE9tbUhoZG9NT05xa1pKYTl0YTZ4?=
 =?utf-8?B?UjZmWVlGZENVZW14dmwrRmpUSXl2ZzBCbys5bUZUZ3FDcTFINW96aUpQYXhs?=
 =?utf-8?B?ZnVtL05RTnRKVlJwWXFHbWlibkU2RUE1OTVMendnaWs1em5GemJFVld3Z1Br?=
 =?utf-8?B?SVVsSHl2cVBVUUQ1YlU0SFFWTGRuOG9nbGFVeWsrNnp3K1pHQ3ovMEZ0OUc3?=
 =?utf-8?B?YWF5SjgwSmJKSVpBM1dZWEpYRzVjYlE5VTdtWGFuZVptektNTUpYbjJPREZy?=
 =?utf-8?B?c1ZsVGVvUWZkVFMzT0I5V2d3czVDWm0rSFNSdFZFUFQyVExtTW9lU3NNYmpa?=
 =?utf-8?B?cnRZZzV5T21zM3ljelNlbmM5cCs4OER5QnNUY3BzZEZkZEJHV21oNG5mbWhH?=
 =?utf-8?B?M2x4SG5CeFBBZHh0dWFHS0twR2FuZUVZM05QbjB4c2IwT25QczYwNVdRZmll?=
 =?utf-8?B?L0hiVXREb29DR3RoTEJsOUlLcHpzeFd6MGZ5NGl4cHRmb0Z3ZERwSmtVQkZR?=
 =?utf-8?B?OXhGWEEvOFBEaHFHSk5nOVRGK09SQU4xbzBYR2hGeFJhQlRZenp2bERhL0tr?=
 =?utf-8?B?Y0tKdmhuQ2NyN3dpalExZzVCK0Y4WFFReWNCYm5rVHVhaDUveXFpaW8rR25D?=
 =?utf-8?B?WW1EWmxPaTNZVEFSdnFEUmNDRUYrRVlNWWx4dWFYbklQdUEyODdKSlA1ZGFU?=
 =?utf-8?B?bVI0T2UxeXNJa0JCQUsrUFhsc3M4bWh6T1oyY1kxTnFEWjRLWE11UE9xNC94?=
 =?utf-8?B?bDNoZksrUDl0K3praVVSZGlFcU9VNTd6S0QrOTFyZDZ1WW0ySXNzZ3pHN0x1?=
 =?utf-8?B?TlcxV1JLa3luMEF4MTRYUnErdEsvZHBIUzVLYlEwVlF4UmxzdXFuQXVwbWlo?=
 =?utf-8?Q?pfW2sT6MFZ06/DenUQg6eJ4/JXgrLQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YU91QjZUY3lEWDVBOGNMME5JaVI0N2RFRVR4aFptQ3J2djZLVGRBWHI4VVVl?=
 =?utf-8?B?cnlFdmZHVVA2enZUSGZncFdBbHpIbUxQTXdqanFRc3dpc0FyVUkySXR2dGpH?=
 =?utf-8?B?Z0VCb3JEdU5hckdFL3lHUDJ1dEdWdGZEUVhGcWtMVlZEYTgwT0x1bk9ieFBR?=
 =?utf-8?B?blVrQytjT3VsclExbGJNZ3M3SWJvV3NYbkFhR1djWlJ2a1RXdUgyVWRUdkRJ?=
 =?utf-8?B?UWRiQ1lKdEIvS3BrMlludjlIckFOTFZrV3dhVTYxZCtaVklyeFM3Ynhzb1Bq?=
 =?utf-8?B?anhQR0x0blhLcDBzTGpmaXJKYmFFc2tuT1VPMFI5bmRjenErR1NwVkxBYWRi?=
 =?utf-8?B?N1YzNEIwVDJyUVpFK0JwdHlNVk8xOUhRWlZxRDVOTnBocGFDaERRVEVqdno2?=
 =?utf-8?B?Sk0zdzIxYTMzNjZQeTFrai9EY1RHNElmMzJOTFAwb3VZZWRubys0MDRXSXpW?=
 =?utf-8?B?NXNxU3B5MTBxU2lRV0xnd1JjbjlIWllGS2xHaHpObWpEcVI0RHVKWjlCUFg0?=
 =?utf-8?B?bU1ONUM2OW5zVS9yZ1Y5ZEpnREliZ1FlZ1dEeFVJOE94cnI1MDQxQXY1VGxy?=
 =?utf-8?B?OFpScThkREQrWHlkV0FqdEcvOVdxSzNUNElhaDZCOTdrczBmY01MT3NBQXVi?=
 =?utf-8?B?YlREL3lYbkJqVlhVaWRsVHNYYnVjQVpvVjBDbTBPVWVuL1ZnQ2NoaXBaemxM?=
 =?utf-8?B?SjJkanpJdWFVZnVxaW00SGtZanNZWk5wVWNtYUlwMUJpSzIza2N6MGFwU09p?=
 =?utf-8?B?dWZ1MXVCSWlPMjIvYnJYR3o2ZksrRE42b0N4N24vQk00VTlJZ3dtVzVQbjVM?=
 =?utf-8?B?b05xY0szcFdLTGRPdmxkclRZV1pqbGwwb3gxSkJpTEp3OXE2MWM2U0lWQ0h1?=
 =?utf-8?B?NitWK0lNWWxBT3dFdnFzRTdObGVSOTZNZkU4dkNCR2NkRG41ODlVcHZzWTMw?=
 =?utf-8?B?ZlN3YmFzaldCZUFFQi9YSjQ1VzVPcVJ6ZVl6bVVoZVBMNFdxSXJWZlpGa3h0?=
 =?utf-8?B?QUg0ZjJmUUxYQ2ZTUFc4ZFYzMjRhSXFYVHozTXV2NndTaDVHbnZ4L2ZXZ1Np?=
 =?utf-8?B?bHRLSm5qME10eVR2V2d2VzgrWDNkZGNqN3YwRWQ2cHhhdCtiWjlVd0J2SmxK?=
 =?utf-8?B?NXoybTBoOHlaV3hra3ZLdlFpb212Mno1MVdQQ0FYYWZEN05UbU1qWHBMWGxz?=
 =?utf-8?B?bkZONEJPdnpmdzJxeXpnMnlVUlFYNGxQTEROYzNseVNDaFpUWVJOc0hsRENJ?=
 =?utf-8?B?dXk0eW9pU0kwUjF0eGRuVnMweXFhclNFQ3VUYVQ3UUlqZUJiTjFCYkh6S2Q1?=
 =?utf-8?B?YWlsRmRBRWRjTEZDZGNwa2R1NXVqZnBDMDBMc3ljNjR2QldXVkVZcGNFMDlP?=
 =?utf-8?B?QmM0Zi9lbjN4bUtmVlNzT2dHcXVja08yNmY0MmZOaWRGaS9kd0JVYi9JdUZo?=
 =?utf-8?B?R3MyZ0luZlJnbGVFRytnck1xTk8zZFRFSjY3VE9GakljQi9JWHBrYkEySE4w?=
 =?utf-8?B?aVBmaXRXeFE0dlZHNEZzaUZMeWJibXE5M2hremlXa2JXM3gxdkNSalBrRlVP?=
 =?utf-8?B?ZW9TdWhJbk1iR1RaRVVmcW5lWVM0Y29obG5Qdks2MW1uUU1yZ2twSVZCNVQr?=
 =?utf-8?B?MW5VT1BnTm9YOVZUbzB4dHliSUwxSU9lb3VPY2lML3hQem1QZVdkQlBLdFd5?=
 =?utf-8?B?NitKVElwS3RVSDhzNDZLMmVmbTZWRHVJaHg4akpiUE94VVhtSkN1bDR4d1JE?=
 =?utf-8?B?YUVRVm1FKzVGNFE3Y0xYa3hWdyt0ZjRDdFRtVzhaQ3RZSzJ0WVJMWlBBRE0z?=
 =?utf-8?B?UVlaWGtxdC9vRXNHbUdTWno1OC9OSWhmWTJEZTFPZ2liM0JNS0RWZC9XVEhY?=
 =?utf-8?B?b3I3N252MjAyY2gyeERYd3MvVFNWemphNXlON3J1YlZOd29GVGpUMmo4VC9j?=
 =?utf-8?B?TzVER0szblpHdG9pcjJ0NVN0cEdOMHdxTHdmUlYzTkd5VUFYd2dmdEVwUUxn?=
 =?utf-8?B?cnlzRHJjV1BPK2UxSlJiejZEaDY3L0dFWnJpT2FsVEZ4Szh0N1I0Zkc5THg4?=
 =?utf-8?B?bGRPNlYrVFh6Z29oWGlDWmhpbTNzTWQ1ek5peDZueWx3Yjg2dC8wa0paVFZi?=
 =?utf-8?B?TE1IMXRSUG8zOXZQLzZrcFZvcmdsVUR0VnhYUjJuNHgyRnpmT1pxWXVmNjN2?=
 =?utf-8?Q?/72yFF4P40KtJPIF83qfvJs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9555CDC0D64D6E4492F60F94FAD20E6D@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3728f8c6-6f1c-4bd2-6e03-08ddfc608e83
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 18:22:59.4369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7QJUAuw26VbwCyANa0XhDp6Goqvt7CCpqLSd2cRwiHfeiZ4KJSZ8IKQoENsQvxPy5OW8gfTx283bqlS7GI61Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR15MB6293
X-Authority-Analysis: v=2.4 cv=FrEF/3rq c=1 sm=1 tr=0 ts=68d58889 cx=c_pps
 a=s0vAXdo1X8BWGfCUIwR35w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=sQm4ZKOTRIVT3LX9iNsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Mygt51lc9A7E7rber-fVEfhLhsi5nm0v
X-Proofpoint-GUID: asmIaSKIgAeDoIhnHhXnmoMsCcrrIHX0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE5MDIyNCBTYWx0ZWRfX3eGqqe0CCHxw
 1gy0L3n/xgpgjSQX/CDbFB6D6g3lHoA+WpnciKtvE/afDsQkksF/ckW7yBepMZyAm11/sGzWNLP
 cuXUsSpyRRA1602ianI+OuxR+TyuAhfxZrPmtIvYMlczr5ZpdfFcQo7y/sn6Hpy7eRKk8GluUA6
 oB54juryI2e/YAZrsvVBDQEHbL5yJ+Jt7N1xX0+8uMtxqBTXd/ScKPlRHuDBDxbY9HX5Pob15Sy
 laTeeTSSBx1dkLJdvOPMuIBaU09QhBdIzY76V458l4LsBbU54AKYirmtKefl4aHDPs6iRmVHLbm
 prIH0nSMVeY2j5sLSJ2tN76HxQ2k/3sgY+43/CRG7RG8q7L5Ru2HVdt26jyw6KlmWkn7qnO9Aul
 dSlQlnVK
Subject: Re:  [PATCH v1 0/1] ceph: Fix log output race condition in osd client
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509190224

T24gVGh1LCAyMDI1LTA5LTI1IGF0IDA5OjU3ICswMjAwLCBTaW1vbiBCdXR0Z2VyZWl0IHdyb3Rl
Og0KPiBIaSBTbGF2YSwNCj4gSSBoYXZlIHVwZGF0ZWQgdGhlIGNvZGUgYWNjb3JkaW5nIHRvIG91
ciBwcmV2aW91cyBkaXNjdXNzaW9uLiBUaGUNCj4gcmVmY291bnRfcmVhZCgpIGNhbGwgbm93IG9j
Y3VycyBvbmx5IG9uY2UgcGVyIGRlYnVnIG91dHB1dCwgYW5kIHRoZQ0KPiBpbmNyZW1lbnQvZGVj
cmVtZW50IGluZm9ybWF0aW9uIGlzIGluY2x1ZGVkIGRpcmVjdGx5IGluIHRoZSBsb2cgdGV4dC4N
Cj4gSSBob3BlIHRoaXMgYWRkcmVzc2VzIGFsbCBvdXIgY29uY2VybnMuDQo+IA0KDQpVc3VhbGx5
LCB5b3UgZG9uJ3QgbmVlZCBpbiBjb3ZlciBsZXR0ZXIgZm9yIG9uZSBwYXRjaCBvbmx5LiA6KSBB
bmQgaXQncyB0aGUNCnNlY29uZCB2ZXJzaW9uIG9mIHRoZSBwYXRjaC4gOykNCg0KDQpUaGFua3Ms
DQpTbGF2YS4NCg==

