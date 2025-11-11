Return-Path: <linux-fsdevel+bounces-68002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04577C50077
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 23:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CB4C4E4F10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 22:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DB82F28FF;
	Tue, 11 Nov 2025 22:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oiyiYYml"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE6024113D;
	Tue, 11 Nov 2025 22:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762901836; cv=fail; b=ZtU8v4wgv3uLZLqqs+sfF20OINIH3SVfOL3654Tm7xNM6SdmaCvguQedJt3oVIr4E/8mH7LWQPNpLHNIVluAl+OSU/yuc6jzdogbchDfkGV2oQzBeThCa1hmB5QEeHWgE2jAscC/BPYcV963IdFzr7mfMQ3sIl6XemqrnPbKnGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762901836; c=relaxed/simple;
	bh=FyXMS4G8rsL1s0kTnG6jH1Ih4//Jnj+xm2gO60frFI0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=vDPApikw94wz7/820JbzubSXqBxntJ+YJ80ltAaFjFpdmUEEd2v9GcbfqN2Dr1MgRknzkCRFrRunEjCyayRCO8+Vi30m1+mZHWTuuqT4+5GhkwQxYL961cXy/ih6ADQsBcRFGdR4FlIMPXi6mXm/sHea7FX7/Ae/jBKp4tYZOJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oiyiYYml; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABG5oc7003324;
	Tue, 11 Nov 2025 22:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=FyXMS4G8rsL1s0kTnG6jH1Ih4//Jnj+xm2gO60frFI0=; b=oiyiYYml
	eitNrTuaBLdaz5w6vp3LxbvycIUq4NRDRIOBuEcICgIWdiO8TzSpep1oGgqakORu
	oDGWYcfV9r3CfBStwOsIdoqGATezrERHKpAbmlT+419Gxh0ZhfOJxX+H9bIP1xgf
	8jvppTljSJMHNjWnogWBEsowSpO5ZZq6CIBLnYyke+PxblWq4sA4oschlAstNLAn
	PVOXCurXR163JFYPCC/h3jhUEpOMtTVriR1TiVhdbBdGZRoqhZaFqbVuW/HHAoE+
	cV/7np6KpfrLpDcrXc8NuGURM0KR8XtC7sZzAA/aiN6iGIgWZJc0HbXqmQqUjwxp
	dYxI3xGurHhcWQ==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012039.outbound.protection.outlook.com [52.101.53.39])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wc77r03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 22:56:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ayz68TfFunm3QTA8pW4ur8hrbezqpRF/R8+f1CEI21IweChnxwjB6Y1HSI9b9soRJB75/EJJWn+V+aPAOdbYQUw3lIg0r7c2RsAwIP29zuicik3Bf511JnqsLt0tvrmNeZz5+OE0GxedhjosIXzKtYJWj71LrXllIYGBn24aglJ7j4e7fgFlXou2J+ZLOqO+rovSSG4RW1r3gIOf5X5rJEs7lHDa4HP8drmAKzhfxou13aVa3vTPiLrL6FXGyrAETEYLvOSY+lPphiN6lfLTQT5t7tqKKf5UyXgnLFhNlpP+kF4t14GB0Gj123yCI44D9C8tVRaNXon8kaRo+pAWeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyXMS4G8rsL1s0kTnG6jH1Ih4//Jnj+xm2gO60frFI0=;
 b=Y+DCu9qJdZKeyCk6MdBg2Dil9SOjajxpNTw+HDMkuLMsGgpeWJr9UK7KyF3KmDofrQnQilDawQFUMpgF9bReeJTpdLfWp7wBA+2duUzCw1z0NStm4WVNiHhnTqlsTGPfwLWW+vuWM9xhkHFY4m/cnT/wL8jV+rJVuxKbpE98ByBCiak703NnTs+3D40KPPIWgdRABBBUtwUkuWZFtfCbRVpBj9nF2fmFdgnGw1l3PIFN8rSBtcjEPlQltZWmzdZMgSPCF2NCsXOJWMfVug3sxcrgOjCGpMEx4pPy2GUwcA2p6fhbzQNoX5zeBsslCP0QUpC4pT5y0cD3ZBhRKXBPUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ4PPF6D7B23F3F.namprd15.prod.outlook.com (2603:10b6:a0f:fc02::8a6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 22:56:52 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 22:56:51 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "contact@gvernon.com" <contact@gvernon.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp" <penguin-kernel@I-love.SAKURA.ne.jp>
CC: "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linux.dev"
	<linux-kernel-mentees@lists.linux.dev>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com"
	<syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v2 2/2] hfs: Update sanity check of the
 root record
Thread-Index: AQHcUpZLAPwxcKLosUu6MBLxDDnp+7Tsj/2AgAANkACAAOuCgIAAjrOA
Date: Tue, 11 Nov 2025 22:56:51 +0000
Message-ID: <f8648814071805c63a5924e1fb812f1a26e5d32f.camel@ibm.com>
References: <d2b28f73-49c8-4e30-9913-01702da4dfe4@I-love.SAKURA.ne.jp>
	 <20251104014738.131872-4-contact@gvernon.com>
	 <ef0bd6a340e0e4332e809c322186e73d9e3fdec3.camel@ibm.com>
	 <aRJvXWcwkUeal7DO@Bertha>
	 <74eae0401c7a518d1593cce875a402c0a9ded360.camel@ibm.com>
	 <aRKB8C2f1Auy0ccA@Bertha>
	 <515b148d-fe1f-4c64-afcf-1693d95e4dd0@I-love.SAKURA.ne.jp>
In-Reply-To: <515b148d-fe1f-4c64-afcf-1693d95e4dd0@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ4PPF6D7B23F3F:EE_
x-ms-office365-filtering-correlation-id: b35d36bc-e6f1-46f0-37ef-08de21759a71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?M3BXajdieEQ3MGlHSmpXTE03VWh3eGlnS1Y1THFiM1orVnNvTnNWQmt0b3lT?=
 =?utf-8?B?TmxDakYzYm9mSGRqdG1rU3FWSzBVK1E3RTFYUkZkQkZveGFaR001WFpmaldh?=
 =?utf-8?B?Z3BJa2ZuQnoyL1RMVGM3bE5IU2JzMFB1RHRRS2tJWGJUVHJReTB3Qkp0SGV2?=
 =?utf-8?B?UXdDRlNFNnlVUXJYZyt1RW45RlhvV1pvcTlOaVJsaE0rN1BFQ1Y5SkhtVTFi?=
 =?utf-8?B?T1VNL2k0ejh4aG50OTk2TVVQSS95cHVwSlFacmtxTkxVVG8zQzNnNDNFY2VO?=
 =?utf-8?B?ZGJtOEpmZ2xJMHp2cTdDc2ZzRVFnSVNITjhOL0dXT00zZjR3VmFCeVBuN2lB?=
 =?utf-8?B?Y0hwVk1NMVExN1NZd1VLWlgrUG44bEV4Skd2ZWVxNkRsRERZNmFSeTdkRzl3?=
 =?utf-8?B?WEdnSXVCTFVLeFBQQWlUbXRvT0gzaHZhNzc5Vm1qL2FUY3JJRWpUVjBab2sw?=
 =?utf-8?B?QThsbGQ0THRuaFNBQk9NcEttTWpNNUpLTWpQMEdNbE5GL090bXJaem9MMzNw?=
 =?utf-8?B?d0JWQWljejRoNm1aV05Nd05SNUpJK25DelVkZTZwOVVuL1pSSUxHdVJLZk1K?=
 =?utf-8?B?TitBMFhIbnBtaTJDMjlKK2Fvb2dVT3RhMk1ERTFPU3B3c1QrNUZCaXlXMStp?=
 =?utf-8?B?OU1HUTY0OEhqUGJOSnBpeWxYcy9KZG5OSk1IUUlUSlJmVFJ3MGhzUGNHRkpv?=
 =?utf-8?B?dEFjek5YMXU5a1UwRzlUdG1GdDdXZWxkakVXWlVlcU5NQWRtMExlaTg2SlVS?=
 =?utf-8?B?WDJzMTJMVXRHb2JxY2EyamVKN1A4YWN0aXRMc05NbmhVdUlBZjJjaUtsZDZ1?=
 =?utf-8?B?Yy8vMHlNSC91S3NOYW5pYkt4UmczNnRwNkFvRWJ6MEwwVzlvdEdERU1GNlNl?=
 =?utf-8?B?TmNoRXc3N0U2eTd5bDhQYWllakNHSE5CZkFuRjZGdEl2OFMwN1VsY1hsRUJY?=
 =?utf-8?B?U1V3U0tWTHh0YWJjOTJrV1VsNVE4dWxGMXFqeDBFYVpDQ3p1S3N3WFJMaEh0?=
 =?utf-8?B?eUQrRHk1S2dRNE9rd1pCVWJSL3VxdThCMUJXYjFtOUN2Y3IyZFNDeGVuUFB1?=
 =?utf-8?B?aFV5Vkh4cmROTTFoeXE3Z3N2djRib1lCL0RwZGVvWjlmaVpTYk00ZkNmMDcy?=
 =?utf-8?B?MFI3UG9FdVBWOEZWVWNTOG00NHNLb1hMSTRNZTdMUnFYT1Yya2p1Zkc2ZVE0?=
 =?utf-8?B?Z05MZkN0aEVGTkdIYjhyYmRTbDEvdmRXdnkzWHpCYWM0Y2krN0dCNTQzd3hq?=
 =?utf-8?B?THdUNEdnS2FvSmdZVjBYOUk3bnRSZDh1SkFBOWpPVkc2WjU0cjhkUEM2TjB6?=
 =?utf-8?B?SCtwNW83cSs0NHN0WVdlNXAwNWVEdXNXbnREUklYSmxNM3FyUG14ek9hcUJX?=
 =?utf-8?B?Ly9EVVI0cFVYdnoweHoxTWFKejFPd0RQcFQ0aDFIczllbFovT3pIZU5hWTRC?=
 =?utf-8?B?YTdEYk5tcjE0cDRuTlVrMndxT3MwcjZPeTdFVUNkTmZNNDJncEdVYWxFQlhw?=
 =?utf-8?B?Q2h6VzNoYjlWcHYvcCtKRlhzSnJPTkp6YlhGeG9vbUZtbGEralVZd1l3QU1r?=
 =?utf-8?B?cVpjeWYxUWxrZUZnelRUT0JHYU42UTl3bnFUK0RHeVg1ZmlVU2FqcnhrVU5G?=
 =?utf-8?B?aWp6MDJza05pSlY1Zml6dXZYUitRdElpV08ramZrZFNYVTdVVjROMVBVOHNo?=
 =?utf-8?B?ZWIrQXVHd0k0Q3VSeW9OeXlLZEczUkY0OFF0aHlRVDhvZ3hqeVFKTk9kZThU?=
 =?utf-8?B?dlMwQXQ4bGlTcDdueVoyeE5vYVF4UXhFWEthUGtKOEZTSkpVQllwVFE1UkRr?=
 =?utf-8?B?R2Z3K211amdrWkJYeHRrOHg3cUhSK2hTTmZNMDgxemJ0aTc3RG1rSGp6cnJS?=
 =?utf-8?B?eW9DeitzV3A5dWJmRXE4WWF4eW5yMFB0R0xLZjhsbFJ2Yks2YmUwT2VuZ21s?=
 =?utf-8?B?SzYzK3hzSmRpOVpoUy9aMVZ0VGdxaXZ4YmNzNlo2NUhWd3dsQkNqS2JvY2s3?=
 =?utf-8?B?THNqSm9KWktnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NzFxRkFTTnlUWkY3a3VLR0F1a2xOaFZWWnRZS2RWc3RLSzVkQU1DTGNiVXM2?=
 =?utf-8?B?Z0cwMDN1cDVHaVlyTWVGYVlXYXNDQkwrR2s2Si96S0drRDZBMzZDS0VaQXlU?=
 =?utf-8?B?MjdpbWt6OVEvRmZIZjU4RVFJOHplRzVjeVJDWmd5QzZsdG9IbjV1YUpPWE5U?=
 =?utf-8?B?anRlcG1Uc0NHdHA1YUtEZGZxSkZSb1ZsZTQ0Zkp1WXVPcUM2V05IeW5uNFBX?=
 =?utf-8?B?YmI4ZVcrdHRHczVhem9CQktkM2FPODhLamFnSFpicHhJY1JhN2dwUWlqTEVP?=
 =?utf-8?B?czFaZjFnV0ZVek16T2ZzaGFlZHZ6MC9NekVlVXFkUmxuRXpQWTVZQXBDaFB5?=
 =?utf-8?B?NG5iR0UyWVNubWMzSkc4SWxPaVRwRDU5OGJ1dnlHa3lGSm01d3BVYkV5YmJt?=
 =?utf-8?B?TUVFb2daWnB4VndlV0RGTnBKdk1LNUI5QVZhL0FyaW1iZW8rVy9aVFZYenFz?=
 =?utf-8?B?REZWNS9zUFZxSXBtTnZiZlYrSm5zK3NtWnV0MHZrbXlGb0oxcjNPWHNLencv?=
 =?utf-8?B?ZEtaQ09iUm1MbzU2UmMyWkU5RTlxU3JJRVpTbzJjRGtqU3BGVjlZa3o3WnpH?=
 =?utf-8?B?anpNSEpnczVoRVUwT2FNaTNHV3pOUnJGYVdQbzlhQVhZRThpRVM2aG9EZnFp?=
 =?utf-8?B?RDRESFdTb1JIVCswd0s1TlVoQmZGYVBtcnJqU0dYTDlPRzVSYWlEdU1UY2tR?=
 =?utf-8?B?TzBUQy8wa3R6djVpWkZEQVUyT3pRc3dFVnNvL29WR2NiUWVZOUgzbzJIM1lt?=
 =?utf-8?B?bFcrSG9CU1JvVmFUMVUxUVJTTkVEajltODYzeE13aGNXb3RXc2xMZmNFWXc1?=
 =?utf-8?B?bHU3ZERwZVdBNmRwdmwwcTVtUUtuQ1I0am9pMXNTdHJFdkJ5SUNuU2NqakIz?=
 =?utf-8?B?elJpWTRURkJNaU5qb2ZsLzRBTEZHL1I1enZPL3lVQi9rR0xZQmxMWXlDUksz?=
 =?utf-8?B?TFNrcEtPbEN2eG95MTgwbVlpVEplRlN1SnpIWjhuYmFzQUJkTWpqYnBZdVIy?=
 =?utf-8?B?V3Q2ZXNRM0RFcEdGbUhZS2pKVXdsM2VqbnRvYUFhdXFpM2ZqUVd4cEtzYkFy?=
 =?utf-8?B?cFQ0Z2QrV24wOXA1K2NEeEJLM2NsUDByL0tFUnVONkxCejI5QnF6U2dkM3ow?=
 =?utf-8?B?QXpiYTk3dVJEOHR2SnE2bTVRVXowc2NlRWUwOWhYa3BwT0hsZVdXVVpQUFVN?=
 =?utf-8?B?bk9mSVA2d0hPQVljWUhYeGVPNjdtZ0lDNFhaUVBJc0s5SWNrOVM4OC83TFRL?=
 =?utf-8?B?cHVNaGJ2NHBhY1daQ2VUQXhjc3QxVm5mbVd3MXV6OGxSQkVQaFdkazU0bWlR?=
 =?utf-8?B?M0FId0pXWlorSU83dnB6b3FhVFdPR3J1RDhtMkZqclBLY1BVSHpSY2xmZ1hW?=
 =?utf-8?B?T1ZpSkV4clh3RjRtWEVjeWV4T1FBMGtncTcwUGFFL1M5ZEpFSEtZek1BV21Q?=
 =?utf-8?B?QnR5WDFMSXdmWVBMQk13MWJIdlhyNFF3SEVnc05PY1d0UHZnaTdHa2RXVnJm?=
 =?utf-8?B?S29oWjVxTDBvRTNyREplRXJRTVh6MGx1QkRoeUhhY2NZbjFjTk56SzdzTG5I?=
 =?utf-8?B?ZDhMVVlOb2dKTXVUSmx1RERDeGpsakdUOEcxZ1VwNlhNQldndklpTDBubi9K?=
 =?utf-8?B?UlNPdmRtd3FEaVc4d2RHUzFuQXlZSTRoY0tFN3RuM2VDNDZya1VjakJKN3ov?=
 =?utf-8?B?MUNEemxHMHgzTGxqNjlxR2xNZWpSUlVNMi80UnE0OWdMV2U1bzhUVkNERjRx?=
 =?utf-8?B?SXRuQ1lmeTRqRTdNaExPV1lGaDZOcHprUmRrQ3BjWis1NmczeTdDSm1VVm5r?=
 =?utf-8?B?cklraUhJTk1ESUhyVGlHa1paMDh2OWozVjZYTkJ6ODJ5dFlyMGcyeHBwd1dU?=
 =?utf-8?B?aFNkMS80aGdRUVBSYlRVYXNsb0s0SWxwT2lDK0s1QVhQNHlMQ3c4cXU0WTBi?=
 =?utf-8?B?bTBxUUc1SGl2UmMvMTNsYTZjdE9oNUZiTVIxZjg0Vjl6TkNaeWVuV0N1MnZ0?=
 =?utf-8?B?WVNhS1lhWWxNY3pNR1puZXVkTGtMTFFaS1FLQjQyMElTWEtEbjVDUXhDRXdF?=
 =?utf-8?B?Q0RxRGZVdnRMZm1oNWtRZngrSGVTMXl5Z3ZhOW95VUY3ZEtaVFlXMzhuNjRh?=
 =?utf-8?B?YkY4OSszWUR5TytKMGoxRVczcjN4TWpoRUJhd2doTGh2MVZqMnVaclE1OUEv?=
 =?utf-8?Q?ZT9ESG2339+YxqdMTLi21Oo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02483F2D1105EB47871656E28866EAAA@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b35d36bc-e6f1-46f0-37ef-08de21759a71
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 22:56:51.9155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U08j2BJOwhOaIxstkmse7i7FVxndbEuIgKnXkEBEHS1icW/q0doQNwGv6hfvo6mtKGtx7iu57UL+ll6l2u+auQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPF6D7B23F3F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAxOCBTYWx0ZWRfXyf5oLqfncL7w
 rRC2Ku5QQX6fmuA4IikFNmcFd60fZlvv0t8f1hw/dpKpfnI/NyaWnfXZIrKcuebItblKgp93V4u
 n8OzhjBr5sVchfoNYPcBkjU0YhOkPMvbPS79EOCegiFJkEsrIr1/ji9kpTFh1H00z0qjafH18NC
 JdH4bu7e4zvkVYcsfc1SbYAetuAqJTkVqr1cXotBN8knV/ketwjKZMerdnXHjvMaZEtRBdhPBGm
 cud3E2NIdIw4WpyrZEiUum2z2QaBDXfEVNgYsNvtNMzU+/+Mpa9ehqCV30JnWKJLqLghNhoM1hY
 EAOzz9ku2ZojX3B3AazUj0dupJR91OvIz+8w8JD5FfJh5TBWmdntrOtpIToBObkjniPlIQe12sG
 5wMChCbDEMJ2v80OARSxIQUJB0iSAA==
X-Authority-Analysis: v=2.4 cv=GcEaXAXL c=1 sm=1 tr=0 ts=6913bf39 cx=c_pps
 a=xAd66yR1laZozgwquCAwlw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=P-IC7800AAAA:8
 a=ZsajtfcmObCV21danO8A:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: HhZCcZ_kJkOu6dIQa4zPxdzZCtCEcFvl
X-Proofpoint-ORIG-GUID: HhZCcZ_kJkOu6dIQa4zPxdzZCtCEcFvl
Subject: RE: [PATCH v2 2/2] hfs: Update sanity check of the root record
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080018

T24gVHVlLCAyMDI1LTExLTExIGF0IDIzOjI2ICswOTAwLCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+
IE9uIDIwMjUvMTEvMTEgOToyMywgR2VvcmdlIEFudGhvbnkgVmVybm9uIHdyb3RlOg0KPiA+ID4g
VGVjaG5pY2FsbHkgc3BlYWtpbmcsIHdlIGNhbiBhZG9wdCB0aGlzIGNoZWNrIHRvIGJlIGNvbXBs
ZXRlbHkgc3VyZSB0aGF0IG5vdGhpbmcNCj4gPiA+IHdpbGwgYmUgd3JvbmcgZHVyaW5nIHRoZSBt
b3VudCBvcGVyYXRpb24uIEJ1dCBJIGJlbGlldmUgdGhhdCBpc192YWxpZF9jbmlkKCkNCj4gPiA+
IHNob3VsZCBiZSBnb29kIGVub3VnaCB0byBtYW5hZ2UgdGhpcy4gUG90ZW50aWFsIGFyZ3VtZW50
IGNvdWxkIGJlIHRoYXQgdGhlIGNoZWNrDQo+ID4gPiBvZiByZWMuZGlyLkRpcklEIGNvdWxkIGJl
IGZhc3RlciBvcGVyYXRpb24gdGhhbiB0byBjYWxsIGhmc19pZ2V0KCkuIEJ1dCBtb3VudCBpcw0K
PiA+ID4gcmFyZSBhbmQgbm90IHZlcnkgZmFzdCBvcGVyYXRpb24sIGFueXdheS4gQW5kIGlmIHdl
IGZhaWwgdG8gbW91bnQsIHRoZW4gdGhlDQo+ID4gPiBzcGVlZCBvZiBtb3VudCBvcGVyYXRpb24g
aXMgbm90IHZlcnkgaW1wb3J0YW50Lg0KPiA+IA0KPiA+IEFncmVlZCB3ZSdyZSBub3Qgd29ycmll
ZCBhYm91dCBzcGVlZCB0aGF0IHRoZSBtb3VudCBvcGVyYXRpb24gY2FuIHJlYWNoDQo+ID4gZmFp
bCBjYXNlLiBUaGUgY2hlY2sgd291bGQgaGF2ZSB2YWx1ZSBpZiB0aGUgYm5vZGUgcG9wdWxhdGVk
IGluDQo+ID4gaGZzX2ZpbmRfZGF0YSBmZCBieSBoZnNfY2F0X2ZpbmRfYnJlYygpIGlzIGJhZC4g
VGhhdCB3b3VsZCBiZSB2ZXJ5DQo+ID4gZGVmZW5zaXZlLCBJJ20gbm90IHN1cmUgaXQncyBuZWNl
c3NhcnkuDQo+IA0KPiBXaXRoIG15IHBhdGNoLCBtb3VudCgpIHN5c2NhbGwgZmFpbHMgd2l0aCBF
SU8gdW5sZXNzIHJlYy5kaXIuRGlySUQgPT0gMi4NCj4gV2l0aG91dCBteSBwYXRjaCwgbW91bnQo
KSBzeXNjYWxsIHN1Y2NlZWRzIGFuZCBFSU8gaXMgbGF0ZXIgcmV0dXJuZWQgd2hlbg0KPiB0cnlp
bmcgdG8gcmVhZCB0aGUgcm9vdCBkaXJlY3Rvcnkgb2YgdGhlIG1vdW50ZWQgZmlsZXN5c3RlbS4N
Cj4gDQoNClRoZSBmaWxlIHN5c3RlbSBpcyBtb3VudGVkIG9ubHkgaWYgaGZzX2ZpbGxfc3VwZXIo
KSBjcmVhdGVkIHJvb3Qgbm9kZSBhbmQgcmV0dXJuDQowIFsxXS4gSG93ZXZlciwgaWYgaGZzX2ln
ZXQoKSByZXR1cm4gYmFkIGlub2RlIFsyXSBhbmQgd2Ugd2lsbCBjYWxsDQppc19iYWRfaW5vZGUo
KSBoZXJlIFszXToNCg0KCXJvb3RfaW5vZGUgPSBoZnNfaWdldChzYiwgJmZkLnNlYXJjaF9rZXkt
PmNhdCwgJnJlYyk7DQoJaGZzX2ZpbmRfZXhpdCgmZmQpOw0KCWlmICghcm9vdF9pbm9kZSB8fCBp
c19iYWRfaW5vZGUocm9vdF9pbm9kZSkpIDwtLSBjYWxsIHdpbGwgYmUgaGVyZQ0KCQlnb3RvIGJh
aWxfbm9fcm9vdDsNCg0KdGhlbiwgbW91bnQgd2lsbCBmYWlsLiBTbywgbm8gc3VjY2Vzc2Z1bCBt
b3VudCB3aWxsIGhhcHBlbiBiZWNhdXNlDQppc192YWxpZF9jbmlkKCkgd2lsbCBtYW5hZ2UgdGhl
IGNoZWNrIGluIGhmc19yZWFkX2lub2RlKCkuDQoNClRoYW5rcywNClNsYXZhLg0KDQo+IFRoaXMg
aXMgbm90IGEgcHJvYmxlbSBvZiBzcGVlZC4gRnV6emluZyB1bnJlYWRhYmxlIHJvb3QgZGlyZWN0
b3J5IGlzIHVzZWxlc3MuDQo+IFRoZXJlIGlzIG5vIHBvaW50IHdpdGggbWFraW5nIG1vdW50KCkg
c3lzY2FsbCBzdWNjZWVkLg0KDQoNClsxXSBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51
eC92Ni4xOC1yYzUvc291cmNlL2ZzL2hmcy9zdXBlci5jI0wzNzkNClsyXSBodHRwczovL2VsaXhp
ci5ib290bGluLmNvbS9saW51eC92Ni4xOC1yYzUvc291cmNlL2ZzL2hmcy9zdXBlci5jI0wzNjcN
ClszXSBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni4xOC1yYzUvc291cmNlL2Zz
L2hmcy9zdXBlci5jI0wzNjkNCg==

