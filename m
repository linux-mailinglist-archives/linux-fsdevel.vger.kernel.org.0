Return-Path: <linux-fsdevel+bounces-61457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0021B5873B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450CD1AA85E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 22:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50842C029D;
	Mon, 15 Sep 2025 22:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cu0iNLRG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B392BF3DB
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 22:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757974459; cv=fail; b=hBV2h0EFGyOPpaI58SnIi0OPr9HJxzGJoRlD3ugf/myFVMFv2kmUMBaM3qluvnFpyPrz9WQV+4W3OsHB7dQ2gW/XbbfDkO/pCShs/jPDx+pi2wc23aEjbMFAav4bnOWjivgKYsucYyhF389oU40MV/j0kplau5lEiwz8+1KkT0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757974459; c=relaxed/simple;
	bh=JRQR/NkwndFdlGwkpjoEDm68V57LcgPzwjt0Vz157m0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=PPvDXFbwv4Ygxfo4/ji4mlNtnvw29lAia9LONklxXcRr6JFJ1E/bVN58dcpr0zIMfEKekGvlD4LAyTqrwnJmprf0rxf7NCs3DX5STOHBsjZfdXj3lYEm4FKf6Zi5RUiR96Loa/ISQja9AN4EBe7qrakfhwwY0OsyTGWk9g7ctxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Cu0iNLRG; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FIX2pB017421
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 22:14:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=N2BEK8oQsGG64T8OJELud+hC+Kq4gLtngoJPrOQXxdg=; b=Cu0iNLRG
	RtXlhZVme0R/lqHoHJ6zfdPPR+UYDYAQuvcZFLOHShlvhbFKvQHGMXKpuyYQJDwH
	2Rc4sCCOBrOcgthql7Ngq9eq3B23knU/Phy4uoLyRwAKcvPSrVOkBr9rjtu+/j8H
	+jYbox8ZvLzugK3SdzaRXyN+fxISADmVCe+ZKMGZ0Q7lIynG4FXGgFHl/ufgVQ/O
	E5wdqYd64JmQaJwjoUm3m+vf+EWbtOyHLFYlraTN2wVtMSPvSwYndFFqzTV6csOh
	5ATW8zTqkI8AqdA9zvIZ4RRKhQenNsfXQkNEEU5ZKliKHrc5FaZJo9IpGQHcDBp/
	yPNEpgk90VcjCw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496g533q3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 22:14:16 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58FMEGrK007563
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 22:14:16 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496g533q3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 22:14:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbB41AHKls6eNzm5t+06h5fIMl9rC9xb5R6M13LrCQV2QtMBRNCPal3lvrdeF2CXSaKxrq9VXN4yLX0hy8+nKi7qoUmKD9ikgciE3XpnOy8xquIsmK6B1XyOy26Pa5iUlHYEB6xlpZeItqBJV1dHwt3JASrqO55wFnhZ6rlFekb5KeH/TsLNcHCJfpqT71c1jcp7ywE0ScjTCS/6apUKhCDfasip1TLI68jiGVYmX+FrLKkkpdnEAIu80ipDyvL05mvEvSmO2XTzSfm9qdz/YdqBX++xdp5BT7UBMsR+BrHn95mydmrWTXxrF3q15kh3Q/hfZeHiyeio/dRd1b/nMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77nnV2SAThqNVP8VObFQcxo6GaviToQZS1xcAJQ1nKA=;
 b=PWxtabAKECy+SJaC4GG/a//bfLCNvc0yZKLMVG2RcHbDTKXFhXvzew7i1KpYjFLm1QHU2T8zbKD2P68BEtsZ0g8c8zwUnPns+L/aq3rMzkBYwzzZdxwSXNd0p2/9Se0uWfa4A9Ass9CmKLpJliSJ6UXI14qoUr4tal3e7FX+RBQYJ+o0zZoHf6N6RBrZ8oKgMGpHZLe6POiZSRUi3rkemeUICb9m31FRLYP27SO1EpSnfkGqM3ePkcD75219NaKGi8tWewUTVXB8rk6PXOOdVrfLvO+MZbOeWHj0AsFHVQ/Kc3WwPMiiV2qIwe4XfGfvFGNbsGUDrRCYU93yd0Z3kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CO1PR15MB4939.namprd15.prod.outlook.com (2603:10b6:303:e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 22:14:13 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%3]) with mapi id 15.20.9094.021; Mon, 15 Sep 2025
 22:14:13 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
	<penguin-kernel@I-love.SAKURA.ne.jp>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v5] hfs: update sanity check of the root
 record
Thread-Index: AQHcI/XeXEDm/gdwRUOWk4mzIuu6PbSU1DUA
Date: Mon, 15 Sep 2025 22:14:12 +0000
Message-ID: <0dc4e0a9888b7b772e8093fc40c2d44a22f49daf.camel@ibm.com>
References: <56dd2ace-7e72-424d-a51a-67c48ae58686@I-love.SAKURA.ne.jp>
In-Reply-To: <56dd2ace-7e72-424d-a51a-67c48ae58686@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CO1PR15MB4939:EE_
x-ms-office365-filtering-correlation-id: f4626b54-caa4-4f66-837c-08ddf4a533a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YUZLdUVoQ2xNZW5xSDlEeDNxU0Rnc09kcVhYWjA4VjhkUkVXeXFVeTFrdWtt?=
 =?utf-8?B?V3VHa1N0eFIreEFQd3MzWUNpdGpuZ09FK25nM3lpYjQ2OEt5c2xzWEJPQ2w0?=
 =?utf-8?B?eWJFWGh6QVJkMmRodVhvdEh5eDU0WllYbVVhZzNYWGwzcGRBMFI4dnZraXpk?=
 =?utf-8?B?clJCNFJzWjFvSGd0U05pRTNPUnRDRlhFQnc4RVJhQktGcVlzejZuQ3NGNUMx?=
 =?utf-8?B?cnJTR0tadEVmSE5QV2FOTlpMUjBJeG95TGJ6aklHQm1ESkFOYzZTbkZ0c21Z?=
 =?utf-8?B?bFJyOHRZQ1Flb3FyeUJVd0N4UXVmQThZb1pjeTVQTTBUU2dFbDhjT256Q3hC?=
 =?utf-8?B?YWI1UXRCYm11czhMaWVBUVpRNXRrZk4vcWJicnRkcjRTYmFpZGhndkJETDZP?=
 =?utf-8?B?Tjk1RnY1bjg1Unk1dnFlTWZvdkwxY1Izd1h6SkpzUDA3SGV0VHAzTFk5b3JE?=
 =?utf-8?B?Z1JmNVFqZ2RrbXB3dkdIVHFzbFdDUVRSNTBFTUJ4VnVtN3g2Nm05YmFnZlgx?=
 =?utf-8?B?bEFIQ0NWM01TbGVyT2ZIbHBHSU5KVkExT2I1cm13NmZNQUtrMDdwVkZzcGZJ?=
 =?utf-8?B?NllBT3gvSmdqU084RXZNam1vWWxFM2hqR0FLYkcwWHJ3UzBIS3AxV04zRis4?=
 =?utf-8?B?b2lHODR5WW9wOE44NGk4NW11aHk5MWpQa25yV0JycHo1R0ZTQ0h2YVFRWlky?=
 =?utf-8?B?RzRsUlE3NWlTbmhneTlIcHltWHhMUS9mR3NPN3pJbnBYTGtlSkNLWVZ5d3R0?=
 =?utf-8?B?WHVzVXV2OGFxWFU4NE52Zng0MnRXTnVwVURLWHAyVnhSK3V2OEd4Z3g0b0pi?=
 =?utf-8?B?WXdveGRGNGsxZVhzdUg1SE1nS3NndyszZEF0c1paZHBtd2E3QlNWRnp4WnlG?=
 =?utf-8?B?eFdvb0UwZk56SDhGYldCT1VzcERtQk9FWTBuOHJoU0hWT2dkcHFmUFh6MzlY?=
 =?utf-8?B?T1crSmN1azZVbkk2K1haOEt5NGc2ZW1XZlJqMi9BK0V3eC8rcDBvczQ4OW5Z?=
 =?utf-8?B?cUdtVExLMmgrTldmNmtDNGdQMk5YODU0NUJNaFNjcnFzVUt5NFR1NFZmTmxj?=
 =?utf-8?B?YjVFUXZNZFY4WVZpY3ZRd2lIUUppeVRhK1FPQ2hTeVRRTnpHQ1lGUm16N1E0?=
 =?utf-8?B?Z1dHcTNFV3dvcXNVejduTEZidW1PNHg3MXRyMDI3eTNJNHJHdVBjT3RoZ28z?=
 =?utf-8?B?Vlp0bTViWFZWakFsRU52eTR0eUVDK1huWStrT2xFTVIwczVDSE9KUk1oZGhy?=
 =?utf-8?B?WnZmNXY4ZDVBSGNya0ljZy9SaC9ubjU2TEJ3dWNzaVF0U1h6WHR5SFNmNU04?=
 =?utf-8?B?eUJWS3V5cFFzb2hCc1R1K2VDTmxndmwwMk9Gb1lGdEswYkNndC8zYUwxeDhr?=
 =?utf-8?B?QnJNTEZRRVpRZU1BQ1Q4OTVkNjA3ZUI5ZnZQSGFEZ20xTXQ3eEVFN0NvV25w?=
 =?utf-8?B?c05UampkVnB5Q3RyT215MlBncjJ6UllibHhXVmlDeDJnRGNjcFpRTHdxeGJl?=
 =?utf-8?B?eTB0bUtJbFN3TFBod2xDTVpYbHhySjA4Y3REU21qUWtTcWVNYkp0em1zbGdH?=
 =?utf-8?B?dURzTkh1dXZETml5Q1hsbVVsNkVsaGN5YjM5bW1aMkxNa3ZidFlPdjlRTHpz?=
 =?utf-8?B?T01lUkpYZEVGVjBZRkRMQ1JDb0NvNHNENkdEcUFSQ3VLdDZ4L0ZMa3NkdWdK?=
 =?utf-8?B?WTBBZ0dtRTlML2lDK0I5dHZHNy9HaUJSbG4xMUlKUUNINmoxL0VqcGRBQnBW?=
 =?utf-8?B?Q3grWkx4Nlp4VUlWMjR2OFpCaDhzNER0Z25MUGNYTDE0bm5wVWtxa3VoNEFq?=
 =?utf-8?B?ZDBmYWNQT0dVbU1YMFdOTXJsZjkrMXFkZEhJRllpRUZwWWVWQ29LbTZuR0Qz?=
 =?utf-8?B?enkvZGNHRHcvcVZybnBwODhWYkNNRnhZdFFHWm1zUENPb1dPaFVBUHpMNWxj?=
 =?utf-8?Q?JrVyaov44UY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YVR5eGdIdmt0RFRpMTNIa0wrVWhiOEFuWWhUUTFKM3N1QjFDYVMyTFdKYzJP?=
 =?utf-8?B?RDNRYlpCQ24vaWdRZS8ydk9vNGRWMnBxR2RLaDJnYXhTQ2Y5NkhZbEFqVW8z?=
 =?utf-8?B?NUExK1Q3bjl0bEZDamt5dFNkZVl0ajFYM25IQ01vWURzL3R4R3Q4aFNqYmdF?=
 =?utf-8?B?RVM1d1I5VmtkUVJWN1Y1UW1kNE1ReGZnakNWdlRQL0gwbEtsbFkrVHdYb0lr?=
 =?utf-8?B?WUUrYnhudlFJa1FLQk1iVWFsVDRSSWtIeWJnOG15V01sZFBieWdEUWRiYlFU?=
 =?utf-8?B?U1ZDTS9qZW9NNXJuYXBvZG1IWHZIS3RCVmJPREdLOWRnVTBtL0Jpa1hEVkFp?=
 =?utf-8?B?bFAxQXpKbUszVWtZekdadmhnOFgzaDJpMVdTa21xQURQQlFjUkFoZWdvWVZa?=
 =?utf-8?B?SisreHYwV1NRcnUxT2hYMG9vL1dnV2FGNVhPS2JZWk5IbnVrSFA5Ykt2RVM4?=
 =?utf-8?B?My9nbWZiaUl6WWp4RWU5RFhoNmd4UjIyQTJHS2J1WHNkbHkybHJmNjBPUGIw?=
 =?utf-8?B?NjRqaS9DY0d1TU0wZFZpN3liZHAwdDNBUGRFNkFZN0VTNGhTTmZxUzhIZnRj?=
 =?utf-8?B?NlAvYUg5UDJ5YjZldWY5VWtRL2llRSt1a3d2d1E1cE5rUFhlL2duK0xBTVg2?=
 =?utf-8?B?Y21Fa0xpQlUyUDRmRVB5KzZhRkd3SklPWFRXRHh5Q3NxUDZwazNZayt5dnJk?=
 =?utf-8?B?MTYrdExQemFWeU1ZWVZPZTRBVDQvc0JzQWJFK0RjcWRtWnJWYzlVeHlVa3ln?=
 =?utf-8?B?dEVlYkhIR0taSFZGUnRqVlZVZXJLbUhaUDBsTms3cFNSclR1K0V3SlZpOU4w?=
 =?utf-8?B?NlBtM3Y2ekRGdmlIOExxYzdmNjFKbVJCdGd0UmdkSkZzajZjWm5sQ1Z3UFVP?=
 =?utf-8?B?RUpNMlljeUdyVzZ1eEorLzJGVVlpQUpHY1VWdFN2c0dIMHBsWlRJTnN2L2sv?=
 =?utf-8?B?a0M3ME1HVVRHdjM5ZmVldlRmL2JiZEM1ODNvMnFGNXZjRzNJa1ZiUmpQNm02?=
 =?utf-8?B?VE1uSC82aWFGeWNPUFFtcnFTT3I5amQ0WGU3bUkwNGMxL0NVa1hQQkduNHB4?=
 =?utf-8?B?Mlp2aDNuKytJQ3BlVDRwSjJHYmZZcTEwY3NmODhxZjAzUEFsdTRKL29qRnkw?=
 =?utf-8?B?MjJFbkpRT25NMHc2UDRWUzVvVFRucjdiUDlqWFk3MU56bGZ5SEp5UTFJVGFE?=
 =?utf-8?B?dW4wcjF5b0tEcEFTYXNqMnlRdzdRYk9HdWwxRnFDRm9QSGVIc0lXZEEvc1NT?=
 =?utf-8?B?VERNa2p5TkZPeC9FU2pIV3hEVE54Mk1jOUNUMjlFRjZRMnJRMjdVUjRuM21Z?=
 =?utf-8?B?ellDaCsxdnhQa1d4WFA1MkFwUlJza3ptSnFBY1Izb2xkb043N2cxNEdKK0x0?=
 =?utf-8?B?OTcrcW03MlIwT2NrUGRWWU1tVEg3Ukt6UmJWZUh6L3o2SUkwLzJWWHR6cDF4?=
 =?utf-8?B?R1pMRS9yakxKN0s3cC9ST2hUTHBGUm05aTFVMnM2WTNsd3hXQmtiNjFUekc2?=
 =?utf-8?B?ZGZaZlVTcmFReTBSTDNwekNEbUcvK0Ztb0NJS0R5aTFTa3czSGwxdENlc0Zr?=
 =?utf-8?B?RisreGw2MXRES2J4VkFuYmhvVWdzQkhyTXlVdGsxendoZ1dvVmJwS29reXF2?=
 =?utf-8?B?dkYrdkE0eTVBdGRiank5WFExM1F3YjhXeUFBaTFEMWV2b1JjMy9jd2d1TVcv?=
 =?utf-8?B?bG9UckZiWmJkNytmZ25pd1h6TDBoZ0R3OTVUSHp2RGVKWThtYVUveG1HTnJm?=
 =?utf-8?B?ZjdBNFY1dnZFR0FrU2RHRG94M2kxQWJZZGJQaE5OTThRZnowVTlIMEZrakpI?=
 =?utf-8?B?M1NxeWUzWEt0Uk1GNzZma0U4ZlZNYnZBalJ4Y3hqSi83UmhnM0JqRy9ibENt?=
 =?utf-8?B?YkJMWkpQKzg3UVB6Y2NUN2dNbmdSa2IyTmppcER3S1g1dURRTkd4YzJZV3Bq?=
 =?utf-8?B?alB6VUE3M29WZmVzWHc0bDhIYSt5N0hhTmNXSjhMS3NpUk9Na0liQ0ZBb0FT?=
 =?utf-8?B?Q3liMTlYOUZXazliRHA4bG9TUnJMK3FMRDgrQklMTm9OVXRGcFE2dTZETWtm?=
 =?utf-8?B?VWF1cmgxbHIrYTZncDZVSTludDlkQTA0RjNuY1RPZHU5QTdLbmpTTTBrQ2Vn?=
 =?utf-8?B?alhCYlVZWW93WWZ4UVhwUU1zVGVCenJrTVl4Ykw0bUhyYkdoek4yVG9pTkRo?=
 =?utf-8?Q?Ulb83qFisnX9KvDokIWDVPI=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4626b54-caa4-4f66-837c-08ddf4a533a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 22:14:12.9223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6YbH8F74RoDj9ElCVrHay0lJQhWV5oxfSHQ1+zgQIiQUrI9EnNmVHsQD8m5ZVPzTSjJjF5BJI+s73wwN2m7R6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4939
X-Proofpoint-GUID: ygBcY3kQyp_3gQoIMLT5x6gIm6RA2GhQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NiBTYWx0ZWRfXzTTtZAR4TfLZ
 EU19FINrob6p+lTONU3Cy6vSYjOoCni1wisG6SJLGynV22iCgHN3OenjcA0178873SLl60gs6dK
 nsiFTleav9oH1ZdIpoT0xMgvFlr2VbE0rHuUQhoOxS/vITPv/sMhFMe6Y2+zHADPmoGUwg8cvml
 +9MiwPDUFB5bUfdLsRR6qvAiPT1nNxAYzkR4263MpmNCIvVLdxUgXxJPswP+brIRSBv6Hrcpqzk
 o0hd6EzCZdzb0ty/jN4PkRhLXx7ZTE63ogy6ojfhJDbDtEurcIEcVc+8Zf1Vtj7CSDar8mSjZZk
 QY2otTYoZX8i7ofSvVxr+wRDuQlwIh+TbwxpbjF3jmAT3nI8Xz/aFwETrOqSg/2vtovxazV20Od
 5OakepjV
X-Proofpoint-ORIG-GUID: ygBcY3kQyp_3gQoIMLT5x6gIm6RA2GhQ
X-Authority-Analysis: v=2.4 cv=UJ7dHDfy c=1 sm=1 tr=0 ts=68c88fb7 cx=c_pps
 a=ACYjI9XXP2BzzpCpjpIAbA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=hSkVLCK3AAAA:8 a=hIWAVwbQq9IpcjLUlZYA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
Content-Type: text/plain; charset="utf-8"
Content-ID: <53081BB26251634F8F8474541BC94581@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [PATCH v5] hfs: update sanity check of the root record
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2507300000 definitions=main-2509150086

On Fri, 2025-09-12 at 23:59 +0900, Tetsuo Handa wrote:
> syzbot is reporting that BUG() in hfs_write_inode() fires upon unmount
> operation when the inode number of the record retrieved as a result of
> hfs_cat_find_brec(HFS_ROOT_CNID) is not HFS_ROOT_CNID, for
> commit b905bafdea21 ("hfs: Sanity check the root record") checked
> the record size and the record type but did not check the inode number.
>=20
> Viacheslav Dubeyko considers that the fix should be in hfs_read_inode()
> but Viacheslav has no time for proposing the fix [1]. Also, we can't
> guarantee that the inode number of the record retrieved as a result of
> hfs_cat_find_brec(HFS_ROOT_CNID) is HFS_ROOT_CNID if we validate only in
> hfs_read_inode(). Therefore, while what Viacheslav would propose might
> partially overwrap with my proposal, let's fix an 1000+ days old bug by
> adding a sanity check in hfs_fill_super().
>=20

I cannot accept any fix with such comment. The commit message should explai=
n the
issue and fix nature.

We are not in a hurry. We should fix the reason of the issue even if it is
"1000+ days old bug".

Thanks,
Slava.

> Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D97e301b4b82ae803d21b =20
> Link: https://lkml.kernel.org/r/a3d1464ee40df7f072ea1c19e1ccf533e34554ca.=
camel@ibm.com   [1]
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  fs/hfs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index 388a318297ec..ae6dbc4bb813 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -354,7 +354,7 @@ static int hfs_fill_super(struct super_block *sb, str=
uct fs_context *fc)
>  			goto bail_hfs_find;
>  		}
>  		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset, fd.entrylength);
> -		if (rec.type !=3D HFS_CDR_DIR)
> +		if (rec.type !=3D HFS_CDR_DIR || rec.dir.DirID !=3D cpu_to_be32(HFS_RO=
OT_CNID))
>  			res =3D -EIO;
>  	}
>  	if (res)

