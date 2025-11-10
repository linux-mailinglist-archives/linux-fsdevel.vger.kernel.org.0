Return-Path: <linux-fsdevel+bounces-67775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15116C49C5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 00:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA053AAE5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 23:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35903009C4;
	Mon, 10 Nov 2025 23:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="it4Fbgvb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A420023AB98
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 23:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762817688; cv=fail; b=QWJ1zfv9gEkC7JQt1rt9IUReSgV2ciHqnuLWvWH6UdbZpOJAwPCa5tq2ewcX/yWabNmR7IUUnygVvDv925s1QznAph+yoVFeYslXmI3qVIYgjFjuq5rfjb4FEp3gsD7psvm+mh3dG12eq8MZ7mMzrG8EqhRhdDm5Tv2KuWoCi3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762817688; c=relaxed/simple;
	bh=L6LWiOKGMY4suybo52TSgWzsS32XFR4J8pff8TvObUM=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=eQy19qpA6AeYsQaP7XKnJHymWnA4zXXGaEeexC72f7Lu7wEsWADme5REqbaSAzBk5Sf8jOuLCIbzIPvyJ2INqaxCPvIwuKeXCsiDObmCzAL4EH2qKMBocaOGHn+vztPkboDqyaB5jsf6uEkOP1eExvqYdsqE8cFI5kRBqKldpqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=it4Fbgvb; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AALQSwv019454
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 23:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=4H9bFBCwMtJFw5J3RMU0odYWoSvHl7fTaa8gf0eIuSU=; b=it4Fbgvb
	jWI1lCQ8k10aKK/0zXCpuwB2vy3ZfDErnNyqHpdfb4XTZTmHGdLBmphnqvOj/q9j
	TonqR4im3TOSDVSHKcBnecIHPhiBfPIPMjR4Vinp+rHL486UuS6B+/pUr36vPZx7
	m0dLoxWNERfdhGlf3PnbgC3W7OYL6yui1+goYAwuIWf1ptzHgnu8G6+bf7uadanI
	PN51KpqUs9py2cNwcfjRCxzT/Vf0N/CPhAvHqkpz7mXEcONcZHyFo4PEnCk7ldee
	N+m225RS+Xx9oBQDykBHHztzyOEjfqVwt4TPXdPaqGbeT26PjibGKxEi7gaxE+3h
	wL8Joq7RZ/TKTw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wgwsgcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 23:34:45 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AANYi1P002994
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 23:34:45 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wgwsgcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 23:34:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJh8hbLC3EpEA0U8zndqnCFspAL8LhTsTb5Ftn+9J6M/9bu4QiSdzqgTDAq6On5MCXj+QxKgT7SKTO6pIKguUuTyX0myeXj2+J9d/is3abU6ly2kSnCVGgPKSlv3NpSGqgz9OgL/HwOTUJEEOb2ZoaRk27WMPjR2g1z65LfmDBTa3Ey5N2saPAlGxieI8tQBKG7QcxlWTSJlkMjl1D5emlhNs/IXeafMg5/c/lF7S7m22/s517q7+OfVmzm2GuIRPtRAwooqcUnn5tJISj4tR5dT1rIqk2sgzjsGb5XwcItZ/ZvhyKsdDbZZUpQnSiHzpGYuYeLs/xrBqkK42dEWSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVVxAvTiTaNyju85tyIBMs3nVGc67IofY6mmNgClz1E=;
 b=zOpkOuVYEBqsgvBTKdm2RogKHkBgvh5KYB55QiPTJbF71tyvvc37AzR4MOm1cp9qVtDsJBPweWzTYzYOCZQRmYkBbzVmH6J2Vdp8IOa4N0Xx0icThpt1d0vS+MLhPFShkuikHW90ZvfbLoGnLI1dPCgmrg1AuWuAdyZ6nN0QB4WTv1Vn+HvumzlIT2n1I/CsvfRlsNrRFwG9/gm4K6b5xBv/yqMQPHRPNP3hu2/KJyNqHoExMLAIN+DgMMJgmyf3SbCpJP9cc6Cg1+obtcjWro+H3wLJCTBPLljeoWhTngGCVh6gAtFwO5eBBCStSj2tZkeOa5fnG09z38SfakyaXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH7PR15MB5500.namprd15.prod.outlook.com (2603:10b6:510:1f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.15; Mon, 10 Nov
 2025 23:34:40 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 23:34:39 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "contact@gvernon.com" <contact@gvernon.com>
CC: "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-kernel-mentees@lists.linux.dev"
	<linux-kernel-mentees@lists.linux.dev>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "penguin-kernel@i-love.sakura.ne.jp"
	<penguin-kernel@i-love.sakura.ne.jp>,
        "syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com"
	<syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v2 2/2] hfs: Update sanity check of the
 root record
Thread-Index: AQHcUpZLAPwxcKLosUu6MBLxDDnp+7Tsj/2A
Date: Mon, 10 Nov 2025 23:34:39 +0000
Message-ID: <74eae0401c7a518d1593cce875a402c0a9ded360.camel@ibm.com>
References: <d2b28f73-49c8-4e30-9913-01702da4dfe4@I-love.SAKURA.ne.jp>
	 <20251104014738.131872-4-contact@gvernon.com>
	 <ef0bd6a340e0e4332e809c322186e73d9e3fdec3.camel@ibm.com>
	 <aRJvXWcwkUeal7DO@Bertha>
In-Reply-To: <aRJvXWcwkUeal7DO@Bertha>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH7PR15MB5500:EE_
x-ms-office365-filtering-correlation-id: d420aa17-4ed1-4081-c8b1-08de20b1b7e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QkQ3NEhDdzNmbkEyWEJCMHJqdnJXZlpYaUdlZkJOU2hjMjFRN1UwNysrR1J2?=
 =?utf-8?B?Yk84ek1EZkhMY3B6VVR2RkgxdG56NEpPNUVIV3hJUEdyNmlvYVZlR2UwVE1h?=
 =?utf-8?B?eHIrYytyTytyYWVoVm1qOVg2aUZyenJGdVlhaDl3K3BOT3gvaTZERU82eFU4?=
 =?utf-8?B?cjZOb042MTV0MCtHMkxEK2pnQzlTdTc4L3pLNWNPcHo3c0doRDBsQzEvRVhK?=
 =?utf-8?B?UWUrZmtxRlNIL2RnWW9jeTNVOWFQaXlvbFJmYis2cElLdGtMTDN4QXVqMVVK?=
 =?utf-8?B?dXZCczY0bmNDVlFINjdoYng1aFhIR3dwVVZtRzNwTHRLMmFDRnVTa3NscDR1?=
 =?utf-8?B?OVhBSStIcjRxMlFneHlvRWg2V3JXU1JvTXRhcWtvK052am95SlY4dC85a0g3?=
 =?utf-8?B?L3Zsbms5WEpVZ3RxcnBBSmNNUnBmaWxObitCUXVHd2ZVRzhiNlVSeE9LTk1x?=
 =?utf-8?B?S2oweTJrL1lFS2F6QXdvWWI0ZFRXMURSL2VXUlJLWjNFeU8wZDUvOGVXRHo0?=
 =?utf-8?B?T3JMMDYzSWxEckd2NFZIVVhNSEV6N3cvYzkxMEJXMTBMUTM2M0JEU1U2djNG?=
 =?utf-8?B?WXF0eFZUWE5wUVcvNEltK3NsQlhxV2Y3MW9XRGpzc2cxYkxzNkEzNWx1TmEy?=
 =?utf-8?B?eDRrdVEzbnhPTnBIWkoya290UGpNbkc1Z1NDcFhBUjlpWTdHd1dvUUJaVVRC?=
 =?utf-8?B?N01IWldCSytsd1AreXg2Z0cwMUhqVUk1R2dWVHV1VDdNdXhxNFFaNjNiNFhZ?=
 =?utf-8?B?anBrYTZ0Y2huSTFHdFdoNmFBZTlDK3QrOGxwL2xVYTRxNktZZWVzbEVzTjQy?=
 =?utf-8?B?Ykh2a0s4NXBuUWloR1pCRTVPclM2aGVzamV0ZEUxeFVWNWdGazFYcER6ODIv?=
 =?utf-8?B?WXltMlg3Vk5DOEI3ZGtwUmV0R2VubVZ5WDIwcitGTFhQME1OMm4wSFBud2Vl?=
 =?utf-8?B?QVM2VnRVMzB1NmxHbkZEeTdnc3Q4ekVyY2cralZMTDNwSXRueE10YUVVazIw?=
 =?utf-8?B?UjdObmZaRC9QN00zVXBwN2I2RDlmbDVJUDZHQ0dwS2N3a2tqZ3Nrc0NHT2Z1?=
 =?utf-8?B?UTV1d0tSdkRiUUdZd292YmRvcGt0UzZSVElWVllnY01HZ3dnL1VvZ0pVdTll?=
 =?utf-8?B?a1djOHhOL2E0RnFLeXhIOXBvNUNjSHZCRlo2VjBXOXI5LzlZMWF6aXJDMEE5?=
 =?utf-8?B?emc2dzNubTdwS3dyVGNzMkw2Sng2bHpiQnFaSDVCVHZ6Zk0xV0plQkdFUU80?=
 =?utf-8?B?a0ErVVdaaCtaSmtUckZDVVdTNGxpdXhiWjVWdFBJU1d2M1BHS1lGQ1dENnda?=
 =?utf-8?B?RHR0OEhLNDZTeDliekg3SU1XTnZzYVM2RW9rVlBwS2drTlI5V2M4elUwZVVU?=
 =?utf-8?B?MmJmT2hJakJKb1FmQWJ5UDdFTW5LUm9XdHpNbXBxVmREenptZkdXNVR2eTdM?=
 =?utf-8?B?OVM0Z3h3NkUxUEFpSHVueDJVZmdwa2tsb3YvODV3Q0Y3a3U3ZFNsUGpUYnZo?=
 =?utf-8?B?eXF2dlByUnZKS2NuVXVFaEFTMzBCcEVNVysySlNXL1g2MlBJcnBzZ2taK1Zv?=
 =?utf-8?B?RlRIcVdGeHR0UiswY2lpdFo0bWhSNmNySm1iZUZpOXU1NDhESHYybXVwa3JX?=
 =?utf-8?B?dzZJNXpnOFNUQUd1YSsxVVdsMk4xQXVGZVErY2JiSkUrMTJ0NzM5QVp4Vndq?=
 =?utf-8?B?YUZBQVU5R01lK1JLU3hCcDAzb3piVk9Rb01GR3VKR0J6eFBRR3k3OG9XblVa?=
 =?utf-8?B?ZGdmbUUzMUZ1UGZGNTVCMDBUcm04elRHRVZOcnZKaTllekJob3hWaHYvRUFE?=
 =?utf-8?B?R3preCtpSURENUtTZ2p0ZzZRb1VBODQvdU5sekd4T2Y2dXpDSS8zeTdENjZL?=
 =?utf-8?B?bkxhVk9keDc4bVB6dnh1aUR4Nldwb0JaSlZrc2ZyaFdsOXZZdVRsSGJYSjBS?=
 =?utf-8?B?Q1c4ekdFZDFBb0FZMThmaHQ1cEJld3pSenRtVWsyNHM0L01mVzZIcVdIQ1hV?=
 =?utf-8?B?L0huUXFWdktnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TUFqQVM0cVRQVzYxbFBnY3d5YnlkUTI5M2lENkx3eFowUTd4WnlObXNSQlJE?=
 =?utf-8?B?OCtZMjV0NlRueHArMWYvOFZwWjNhQTBydlhzR2dSVFRpeElhOGlHTWFzR3Vr?=
 =?utf-8?B?V1poSFd6S3l2T0F5NnRIQVNzd0VtblVQWHluUHk0VXpodXhxV2sySlBNbVMx?=
 =?utf-8?B?aktxRk44ZjFZMVp0WWd3ZThNVm1SekYwd25wblcvNjVTRXB5UEd4eVExazV1?=
 =?utf-8?B?eWlTelVWaEhKbFpQU2FnZzZUd3hkaXNsWVZCYitDd2hiek01Wk1Fd0NmNUlj?=
 =?utf-8?B?K0VTbXFJRTh4YStMV1ZSeTMraHhHemp0RDB2a3haSUFDejNXNTFXN1dhN3lj?=
 =?utf-8?B?U1BJcWJFWVVaZFRzK2hFelpYdTd2WlFiL3pTOERJaGxyNm4rTHg3dXUyS0Z3?=
 =?utf-8?B?UEo5MzZiVzk4WkNKL1RCVnJFcHNidUpUOXE2dXRSU2g1cXNHemhpbzBPUEkw?=
 =?utf-8?B?cXVIOFpGNXQ3Nm1QU2xJbUVreWcza2Zxdk82b1I2TTEvdFI1THJYdjkxMDdQ?=
 =?utf-8?B?NlZOUk5MemJXWXkwakVCQ045NzR6S1dCaHUycnJVSmpPZmJ6T2FuUnROd251?=
 =?utf-8?B?TXg4cVVWeFdlK3BRWndnNjE3ZlNlaURKRDZmWStrWUI2RGZIQVRXZnQ4aW8x?=
 =?utf-8?B?ZnRta0x6YUVtZ3ROQnhSTGVpZW5QeExsS3A4ZEZWYzB0L3cxT3dXK2I1dTI1?=
 =?utf-8?B?Y1laZm9BR3ZrRENJbk9LODF5RE9EaVdIcnVSbm5LdVFUaDdHMmZIYmVXQ1R5?=
 =?utf-8?B?Y2NCUzZOK0U4eWMvQi81ZlBZYytCdmg4QTVENEp0dElDcjJ6ajVwRkIyUGZ2?=
 =?utf-8?B?aWF6WVRpNXl0V21tYUVvTmJ3UXVoVkJwVDdNSWZPQnhaMEtCUWhXN3VpdGhG?=
 =?utf-8?B?bTZ3R0NIMjNsSGEvV2VkQ0J3SExMMDhWSm4zL0JUdlFYWFd2TlFpOHZwblRr?=
 =?utf-8?B?ZHB4T2hsL1VDY21GcjB3SjVyL0NOeHl1TGJrMUsxQ1BSNm9lNlZWYU8rbE5V?=
 =?utf-8?B?b2szWlY2R0l2aVlCZU1FMitYTzA3NGpJaEpSeVU0eWxDTG10VTRhNmgxQTR3?=
 =?utf-8?B?a3hBQ2F6ZXdCSGVTRlcweXdEWmJISy8yYllhWGhhV2NRVGFCYU0rSW90UUJh?=
 =?utf-8?B?MFdjdWVMeDV0NWpkcFMvOWVnd1owZEkxcTNhbTNNNnEybmdaWURjUXVudk1H?=
 =?utf-8?B?bFQvcEFDdjFSMW5xS3NkUkZmd0svZk1UTUxIK0lzZ3JqT2xTcVJ4TG1UZ09y?=
 =?utf-8?B?OXFJRVFrdnFrWFdHU1kzcUo3alFsYTV2YlJhdmVBek5IOFBQSmphWEtCTk9Z?=
 =?utf-8?B?Y2JQKzRpMEwzanVvOUtJMUJMUGZ3WTBaVkhjYmpNZTRjWjN5VXBJekhnaXlT?=
 =?utf-8?B?ODloa1VJdXBuMGh1VmRkYlhmWk5TNWxGQnAveGR2VTNrajQwZmRqL1kvT3Rj?=
 =?utf-8?B?VkE4b0hGQjY2VytIcEM0WHI0SGNLTmNWcWxDdUtqRkx2N2w4SzA3TDRpdENi?=
 =?utf-8?B?VEpvYUFoRWJXR3FEZ01iSGFpMDgrdlpjc2tDZFY4NmRsbjhOS1JkOFdyTWtX?=
 =?utf-8?B?VUQzNUhVMmNJRWtJWnVDelQ5ak1YYitBTW9MV0hOZVlUaE03ZzRnaGpmaWVL?=
 =?utf-8?B?UzQ0UU1PRzlkV2k0Sld0Rm1HcisvWkk4R2hIbjZWVkI5M29hODNCTlpYY1pv?=
 =?utf-8?B?bFBKZ2xRTXk3UFB6SjdZRmRsMzNKM2YyQ1prTHhqMko0dUZ1UGVDeG0xdGY2?=
 =?utf-8?B?UldodHIrZ2VHcVBWYnV6TENxamxiU3NuS0VKL3ZEbmNJQStoQno4aDJvWXht?=
 =?utf-8?B?d0NGTnMrNEVzVXRUNjRTK3F6Z3ZlUk80blMxcUVoTTlXODd0N043VUFIZm83?=
 =?utf-8?B?MzVwS0EwNklIdS8zUW9MejBwTjdCaUVOZ1FMOGNRVmdLUzk1eWU3N2xBajNT?=
 =?utf-8?B?VU1zVWNmWmN1a2hnRUtZMDlBUStPamtYemFuclhRM1dHZnVhMW9BMUV1NEtw?=
 =?utf-8?B?RVRZUFc0U3pqakdUc0JiOXVSZ0pQdGJQbHJIbXYwNUppbGJQbmFXZkdmNFBs?=
 =?utf-8?B?TThXTjZKY3BXbDlCek9BK2EyZkhjaDNXRFRlZHdhOW9ldDB4aWxvUlBydEtM?=
 =?utf-8?B?R1RrQlhVb05CZTQwQm56OFQ2YkNRTU1UYlFhalhGS3ZOdCtpcHlmWUpHM2xW?=
 =?utf-8?Q?yt/IVvu3eJ6FpqDSV7QfBv8=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d420aa17-4ed1-4081-c8b1-08de20b1b7e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 23:34:39.8919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4PLHC5jjTa15e5jXku7j040kP/wApzTyy4O/pwXCnKCB/Z+kY+PBo/hn0uF/FnXqaTT3KwWATZm1ec0hU5+pcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5500
X-Proofpoint-GUID: D_MCoP-tp-ZkLEjGgHcRF7s-_7Q6N2by
X-Proofpoint-ORIG-GUID: D_MCoP-tp-ZkLEjGgHcRF7s-_7Q6N2by
X-Authority-Analysis: v=2.4 cv=VMPQXtPX c=1 sm=1 tr=0 ts=69127694 cx=c_pps
 a=St7v3kIWLLX4ycmTPR678g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8
 a=3HEcARKfAAAA:8 a=F64JPc5yldmbowZhXZEA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=fDn2Ip2BYFVysN9zRZLy:22
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=poXaRoVlC6wW9_mwW8W4:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=SsAZrZ5W_gNWK9tOzrEV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfXz3BPCUiC4BJt
 m+SpPOzdntC9JJ0dweHbZAvjeYerI4pUn8rE2iBFoEe4zj4tfOUr8WrHe0eb0FE9cUaLPAGYDS9
 xB97aUb6HfsEe6Rm/7cHLwAl8hB50f43v/PLEW+NTigLpXXUnXNndiEUWado2M7wDasusaPGdG3
 Ck799yqrs+99u/GU2t6kGlr0I62Y+azLNtyLBhqkSEYDYeI4Ykg0iADe1BoC+E3r9T0vX9pqbxi
 6e7HgFivZnff6LzGoVpWryBgA0fabssyYm98abckO5AnULFC+4/CwHo+LSa6i6XHxqw3L3FHNZl
 qUY74CBZOyTqTRO2ujETzzYSoFfPqVuJkuFB5Rh0DH4VskftqHOnl3J8eF2K/xwAaPi2DyQ6Fxs
 2q1jsL5X/msSZ+ae4y3g3pNsSGPAUQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB6C5E90C7DE0E4BA7148D4F69F720CC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v2 2/2] hfs: Update sanity check of the root record
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.19.0-2510240000
 definitions=main-2511080022

On Mon, 2025-11-10 at 23:03 +0000, George Anthony Vernon wrote:
> On Tue, Nov 04, 2025 at 11:01:31PM +0000, Viacheslav Dubeyko wrote:
> > On Tue, 2025-11-04 at 01:47 +0000, George Anthony Vernon wrote:
> > > syzbot is reporting that BUG() in hfs_write_inode() fires upon unmount
> > > operation when the inode number of the record retrieved as a result of
> > > hfs_cat_find_brec(HFS_ROOT_CNID) is not HFS_ROOT_CNID, for commit
> > > b905bafdea21 ("hfs: Sanity check the root record") checked the record
> > > size and the record type but did not check the inode number.
> > >=20
> > > Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3D97e301b4b82ae803d21=
b   =20
> > > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > > Signed-off-by: George Anthony Vernon <contact@gvernon.com>
> > > ---
> > >  fs/hfs/super.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> > > index 47f50fa555a4..a7dd20f2d743 100644
> > > --- a/fs/hfs/super.c
> > > +++ b/fs/hfs/super.c
> > > @@ -358,7 +358,7 @@ static int hfs_fill_super(struct super_block *sb,=
 struct fs_context *fc)
> > >  			goto bail_hfs_find;
> > >  		}
> > >  		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset, fd.entrylength);
> > > -		if (rec.type !=3D HFS_CDR_DIR)
> > > +		if (rec.type !=3D HFS_CDR_DIR || rec.dir.DirID !=3D cpu_to_be32(HF=
S_ROOT_CNID))
> >=20
> > This check is completely unnecessary. Because, we have hfs_iget() then =
[1]:
> >=20
> > The hfs_iget() calls iget5_locked() [2]:
> >=20
> > And iget5_locked() calls hfs_read_inode(). And hfs_read_inode() will ca=
ll
> > is_valid_cnid() after applying your patch. So, is_valid_cnid() in
> > hfs_read_inode() can completely manage the issue. This is why we don't =
need in
> > this modification after your first patch.
> >=20
>=20
> I think Tetsuo's concern is that a directory catalog record with
> cnid > 15 might be returned as a result of hfs_bnode_read, which
> is_valid_cnid() would not protect against. I've satisfied myself that
> hfs_bnode_read() in hfs_fill_super() will populate hfs_find_data fd
> correctly and crash out if it failed to find a record with root CNID so
> this path is unreachable and there is no need for the second patch.
>=20

Technically speaking, we can adopt this check to be completely sure that no=
thing
will be wrong during the mount operation. But I believe that is_valid_cnid()
should be good enough to manage this. Potential argument could be that the =
check
of rec.dir.DirID could be faster operation than to call hfs_iget(). But mou=
nt is
rare and not very fast operation, anyway. And if we fail to mount, then the
speed of mount operation is not very important.

> > But I think we need to check that root_inode is not bad inode afterward=
s:
> >=20
> > 	root_inode =3D hfs_iget(sb, &fd.search_key->cat, &rec);
> > 	hfs_find_exit(&fd);
> > 	if (!root_inode || is_bad_inode(root_inode))
> > 		goto bail_no_root;
>=20
> Agreed, I see hfs_read_inode might return a bad inode. Thanks for
> catching this. I noticed also that it returns an int but the return
> value holds no meaning; it is always zero.
>=20
>=20

I've realized that hfs_write_inode() doesn't check that inode is bad like o=
ther
file systems do. Probably, we need to have this check too.

Thanks,
Slava.

