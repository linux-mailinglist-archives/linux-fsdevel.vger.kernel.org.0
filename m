Return-Path: <linux-fsdevel+bounces-53399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AA4AEE79B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 21:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4A1F3AE481
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 19:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A192E716B;
	Mon, 30 Jun 2025 19:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Nmk6j2eQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDC5289833
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 19:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751312195; cv=fail; b=CZYeT8i06NcnhlYA5zRIkjzTTzs29w3UNykZOUSqCot+tDtCEKP6WD8cBAWebk8Cxfwxz1x/ArHSK51E4GxCwYAICaAqFUsoSg6+FAAi8IRQumJkK0M0SjjLecVgYysgDwTLb+6rtf7fO0B5O/vb1v7D7cSeGQFXXkMlj9E5Czk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751312195; c=relaxed/simple;
	bh=Rvxn94sCXsxLwVWEcaLkT4IOqoNDA4Wt+mp1v8zOuBs=;
	h=From:To:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Vfpzcfs11ZY98BboKfBu8PIwmIybzBFZDnEbGZn91iUcbeZ9fp/gr8+EzUygMzq7BwEpdN54hIBcOvCm2Nlae+ZKCMSXeNWS2Iefy0I7FiyznX8bhGr2c9QZ7cOTmrvJz/nyKKAkoY4WVQQum14jueGBC26nEVxGwxRJz2PjwrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Nmk6j2eQ; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UCLfFr009905;
	Mon, 30 Jun 2025 19:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=Rvxn94sCXsxLwVWEcaLkT4IOqoNDA4Wt+mp1v8zOuBs=; b=Nmk6j2eQ
	9/QCBoy8Juk4DQe7w3VPB5ds8FnUHyzfjBEtwW+HAvz2+s8tUwGGn/fiz7xLerIr
	wtR2YaxGco1Do7eU/2u/W0cbZf6/J2dC0YQEcK2xmGY2H5hWYzeipuV8kzFZk3Sy
	XusrhtiPefVe85Pj2lcfPiFdASMlKZ3HhHpkL6aA5lHWDKAOU4lGFTtQQyLhv4iZ
	TBh9EcVgXv8PGWutb7j60xhRjaTGfln+erhgUeybzSBh/yrPINgO8ku9bi4dk+nQ
	jKyMRBLfyOqZjUZbxSan8aWzTSq+93jjk6lJDZzxs2cikuDqPJtXmlGkBRI+tx4H
	bs2V+5Sg5Ngfjw==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j5tt3nkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 19:36:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MK8ey4QKQ60lyFP2WbGCX1ucJBl3cQgSpN8iG/e8IywDvnMADwYT+1h5ESW4w+WeXTvj4VyD/yRbcYf+KpFk86tXb34d8cOlpXNoNq9nQo7R5CCEXGNsYRdrbNcvkqGUt1TVcminxObU26M6UxV9AYCFvbfdNt8FSHlhcMChsc6CejHl/0zsCbIqgxDzApCiwsT9jXLrKQx6MGDO6AyWKDCIo3x9375mXFKpLcclY6X2aBTHHJxHlmY+GG0bZtx8RUzJksgDwrPp9bO8bDre6i/HZIpKFZt4HTFquFXemrvKbr/A+ocxQTBcZWgEm7egTG+Qwc6nxuV5HZ8FovjzXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rvxn94sCXsxLwVWEcaLkT4IOqoNDA4Wt+mp1v8zOuBs=;
 b=k2ydIWSAQehgO1MPS0zkyGKzmgtsZc4aKetTkNsOdgg2+5fy2OqLEF7c97DYi2SW/k9oDpBui/BP790ftVo1sODlYqC8mV/xzsW1R+r7BjJyPKAQBcHwOEmaj3Y7mwv6YShV482slYCWwrD4Kqewto7xATfRF47810cqsWMf+Lf6J+0NzkDdXGeGiVF7O4EEKdclhHxDOUxL4cJ8T/tcyyaL61TyyLn0gWyK4xKZ55Cahp+tCZkZ+Gruh0OujtLURWVWzexyuxCP02lYiTZ4dZ7V+wQ62ZRp5iydrEfluxO4Pdm13iVNgq3/giZF0GboqTR/tlCq1gA0Rr6OsnUiLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by LV8PR15MB6611.namprd15.prod.outlook.com (2603:10b6:408:264::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Mon, 30 Jun
 2025 19:36:25 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8880.026; Mon, 30 Jun 2025
 19:36:25 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] hfs: add logic of correcting a next
 unused CNID
Thread-Index: AQHb5m3j4i7L1Q6SX0COo3N/Ll0IuLQcH6sA
Date: Mon, 30 Jun 2025 19:36:25 +0000
Message-ID: <3025bb40a113737b71d43d2da028fdc47e4ca940.camel@ibm.com>
References: <20250610231609.551930-1-slava@dubeyko.com>
	 <6c3edb07-7e3d-4113-8e57-395cfb0c0798@vivo.com>
In-Reply-To: <6c3edb07-7e3d-4113-8e57-395cfb0c0798@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|LV8PR15MB6611:EE_
x-ms-office365-filtering-correlation-id: c9977355-e6f2-4172-8103-08ddb80d669a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MTBYWFE3Y1FWYVUrRGtobTM2VkNYSkkxMlNLWHZlelo1aDdzbTJxcmEwVFZ6?=
 =?utf-8?B?Skt3c2U3SXRYK3JrNnE1U3EwdVFPTDZyODJFUmF6a1o2YjlsdUhVWHFBTHRx?=
 =?utf-8?B?ZGFHUG9Ud2FjNUkwdUlJa1NFSXJkaFROUzVabmVuZDFCYXRzRzM3c1NjWDFt?=
 =?utf-8?B?TUhyRmh3R05zRVRFMTlYS0ZQK0VnQ0prSmtvS1p5ZzAvQXlLbHZZbXFFaGxT?=
 =?utf-8?B?R3F1Y1NIeHRZVkFQSVREMlRlVUFnSnRacVNOM1l0QmVmcHNmakNsQnBTUS91?=
 =?utf-8?B?WHFrN2pwVWZ1SkoramYvM2ovV2l6czlMWlRLZGNQWTFvOCtudHUzbDNKYm9v?=
 =?utf-8?B?RGhkdEhpUUlIb2Z6S0ZmOXBKT2phNHR5dTJXa3k3OE9HUEZaVXNHNThtTG8v?=
 =?utf-8?B?am4zNHJpSUEvQjB3YUpzQ3M2bTJkcWRFQ0sxaVJkaURMbzQ4M3RBZVh3YVVG?=
 =?utf-8?B?Zm1UL2QyRG1xSzhXYityK2ZpUkg3QjJVZWFicW5XUGR4N3FWRlFWeSt2ckFK?=
 =?utf-8?B?b2xVWStERzhNOXBkZ1ZwRHg1NlUrZjZlcFppS09IYVErMjFPbm9pSU44aE9a?=
 =?utf-8?B?bXFaTUlieG02bnZNVTZ5VUNycHRwcVpJeTBzZURrV1lrdFFqZVgwYUZ4M3c5?=
 =?utf-8?B?YUIzcUJJZEhhekRUQVkwMjlQM1ZZZnBqVFp4ZXQxdFhMSWZQUm9rMGdmNitR?=
 =?utf-8?B?TWFzVmhxcEgrODhBbFAxU1lEbnFzQ1hWcVdmMUxXYzdBWUUzdXBha2xnTmxM?=
 =?utf-8?B?bnRyVVdyMjY0bGw0bW1GSWU0NjhIa1NvdjkvM1lsOHdHR04xalBIeDIxR2xD?=
 =?utf-8?B?Mlc3ZDA4L0lCbUg3R1k4VU16UDd5TjJWL1BPcG5Sb1Z4ZjdBK1BpbnhvNVNM?=
 =?utf-8?B?SlRXTGhPM01lQUdjWVBGRnRvSEVZcDJmaG1Nb2grMmZvZzYxK3IxTTl3MnV0?=
 =?utf-8?B?dnQxTGRoY1ZQOU92WGdZM0Z0eTlUekdPaFk2bCtVd1pOVERWTndKejU2aWlX?=
 =?utf-8?B?eSt0Q1hWcWFNcW02MHJHYlVhYWNmZ3RGV0s1NE1lNlhuY29EbitaNnVkTDly?=
 =?utf-8?B?L0NHWVI4WHJpY2ZrZlNlZDR0UGE2a3JpakREdDhOMXpBdkVYOUhObEtxSDd0?=
 =?utf-8?B?Zk9ZNlA5T3lKQkFnV2EyYlZhaDJVZVN6WWZUQ0hvUHg3RUlTU1MreHpibkFO?=
 =?utf-8?B?VTV5c3FnSjNPSG1sODQ1bVd6UjJWQWo0M3hjNkVWejJ5bEFIQWQ4a2dDVHZQ?=
 =?utf-8?B?OG5QNVEyUjNLYzFQMkdkUmdPSWZWUjI5T0tRUHlQUk1veXlNUnJtcldNNkZp?=
 =?utf-8?B?b3dWcEt2TC9NekkwRi83L291TjgvVm93QmFFOXZQYlBYb1Y2MWRXd2F5Q1dT?=
 =?utf-8?B?RUJCQUlBUmd1bVI1NnZ0cUU3VkdmZEx3M2FBQVBSRGhvRU9HeHNlMlc4ZEZM?=
 =?utf-8?B?akVmQWRFbENtL3AzM2tSSnVxeDVBNmdQUkp3TjhmQnY1VGJJTnM2NCt3b1Qx?=
 =?utf-8?B?VFJNQnBKeld2TDdYbk43WWxSQnhYaFJoNGZDcStOMDZXYkRSakRkanljalVi?=
 =?utf-8?B?a0lSV05xaUQ0TjFJd3hwczBuL1p6cldhZmw2T09INnFmVGswMFkvSHNDRHFn?=
 =?utf-8?B?WHoxNEwwTXFhS1JpSjRFOUVoZTA2cGFsNTc5TmJWZmJxRnNTdk9LelV3d3hp?=
 =?utf-8?B?ZE0zS3gzTlNJRXloWFRwaFZjcmw2eHZSWVB5a0haSERZamFybkdtQi9yWStM?=
 =?utf-8?B?M1N5NlJ1R0huRzd3UXVYd2hOY3l5VVU1THdGV2RlUU5PSkFBS0JMQkx0SG4z?=
 =?utf-8?B?TGR0V2E3MUE3UzVkWVlUTU9DYVUxb0lQRzJoYjhSaU5PWmRyNGZxcEp6azVL?=
 =?utf-8?B?cWl0akMyKzU1OGhJTXJUcy8vaDBvY1JqQVV5SWV6bTlocWY0NzRzT2FiQ3Nx?=
 =?utf-8?B?YWFRRit1SkdhWDJMM29OclNvVlpQaE9iM3JXL1BnUitjbzUrVzRtYTJQZkxz?=
 =?utf-8?B?MWlMUlU0QXlRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L2l4Z240cmxXM0xvTGMvREhrUk4zM3NXMHYyRWpXY1p2cC9ZWGpJVmwybU1T?=
 =?utf-8?B?bGJBU3BjMDh3MEdMSFB4M3hzQzBxanpXSnZ3Zmo5VVkrYlRyMTQ2YU5VUGsy?=
 =?utf-8?B?OVFLZ1BTWERsVkd0NEZPQmJLN0FpMDFTSUdObWZITGEyMEsvTU1zS0hpZzBp?=
 =?utf-8?B?SDNUaDZiOTFIbmxBTzVzMVpVRzVKQi92S08wQzlQc0RGeW1iTzNXWm9KS3o0?=
 =?utf-8?B?OVM4MDQybk9sYnA1S0ZWUklySWtqN1hxSVI3Rkt6azZENU1YdGJYQkYxMnk0?=
 =?utf-8?B?YWFjZzhmT1R5ciszR2MvclJQa3EzQWJQYTdpWjMxTkVGNVNnMjZWcmNCaU92?=
 =?utf-8?B?a3BuSmZ4S1VSWTB5Q0F5RzJadGwxNExUTEM2MlltMDE5bFk1MjN1QU5FUmto?=
 =?utf-8?B?RU5rNGJPZVhUWjFRNWU0NG51azNiT2t4ZjZJMklzWTdZd0Q0cnBLeXU4QXZz?=
 =?utf-8?B?cS9wWW5oK1B6UEh0OHpXdVhLMi95L2ZLd0hWTmFRK3d2bVhDRTZPY015bTUv?=
 =?utf-8?B?NzZEdTNrMk9yYk5RREtlN014NG9RbTkvYldyWEMrbzI3UlduVWI1cTNUd2pZ?=
 =?utf-8?B?Nkl2SFB0YzZDemVlN0kvN05qeDlySGVGdWtidU9ObGRUZHlFODhycFZDUGtY?=
 =?utf-8?B?TEhkVGJjcEQ5WWtqQnFsZXpGSFNtL0JOYi93S1VKNmlKYUlLMHExYXIwMlNs?=
 =?utf-8?B?dFlPcTFlMmR2NWRNWk8ycXZBNWRpNXh1Q3ovcm5Xck93SVBnNkU3KzFwSVFt?=
 =?utf-8?B?R0M0aFE2YWNKWm9IaVR2TEQwUEc0d0RnN2hlYzg0N0VYQjRzdDdHcFVib2x2?=
 =?utf-8?B?em0wUzM1Q0xmd3JzaDRkbDVuUk5oL1hzQVl1enZvSDFadjB3cS9xS3FBdDIx?=
 =?utf-8?B?ZVZTcm9XdE42UnNNSVFGV3FZRVF6TEl3NENnV05ubW9NYW1xbDB5a3Q1eGs4?=
 =?utf-8?B?MlRDQVorTTNrcDhUbTI1bEkwUEdzQnZsUCtvdlFZcmFkMG5vT1RjVjhnL2FH?=
 =?utf-8?B?SDNhUUR3WFg2REVybXNzRXhUNmVTQWVBQWsyOUVVR0R1L2FDcFcwaUlOUzZ2?=
 =?utf-8?B?cUIvVXV4bHEzQTMvbHNkYTl0WkpaTzlhYlNrMFhIM0drcHAzbFNuSnQvQlVW?=
 =?utf-8?B?cDdTUCtqTWpJY2VBd2cwN3NSQTlndGlLUHdrTGlVNzlxUStNTFZkSmY4Mitz?=
 =?utf-8?B?My93b0VSbG80MVBuOFp4YnNMOXQwSDdUaGoyNTRWMFNnQzFxNGxLREd0V0ti?=
 =?utf-8?B?N2UvdHIzRDE3c1NqQTFDZDcxMzkzQ3J5cWttTkk2SzN0MVhhZkI4a2gxTDRa?=
 =?utf-8?B?WFRNSXBtS0NsQ0hhakxLSm9Qd09nY3F1NU9zNnJncXl6cVROczVTKzQvMHN0?=
 =?utf-8?B?SmpRTTFmeHAzRS8vckJ5eW85RjZkMVVUK2g4MDRVclMzTFUvaXpiQWtxUmV3?=
 =?utf-8?B?eHFObHVIbThiQXZrYzJ2NWdLck9Tc1RMcGtjaUJtSkgwSU1veklYRS8waTVJ?=
 =?utf-8?B?L3NrTU9QVmFFamlUd0xlaEVjcktsRTVVN0xXYjBmTzEzQm9tWCtWaHZ4cmNx?=
 =?utf-8?B?TWNyajd5WmpsQndXTTNCdFVObkFzTld0dGw3R0pCVlp4MDIwZkFvU0gzUVZF?=
 =?utf-8?B?Qmh1eVQ4QklOODN6dXhvVE8wcFFPdDJJUVRlVWFXdHl0MW1qTCtmOXBuM09G?=
 =?utf-8?B?dTViR1pMSHRoUVFBc0pjZ245UEdJeTY1VU9wMTdjWStjSERWT09NaHdYL0pr?=
 =?utf-8?B?eVpTc0lTbnROUzBvaDd0MHFWYWg4S1BuZTB1em1aaEg3UnVWRmU2NXFnYlEx?=
 =?utf-8?B?bTExL1dCVThySTNudkU1dkdRTXViTzZLTkhRUjJhOXVJcUpzTVNMcnhvOEhC?=
 =?utf-8?B?RDdXcXU0cy9pV2dqaHFxMVlnTVNTbU4rVDUyQXYxbjgvbmxneEI2MXcvVDJM?=
 =?utf-8?B?VXZHRUxzWk9VT3l1M0t3KzdBQWU1c0Z2QWNQOEh4Q3QraGw5ZVJSSUxobldp?=
 =?utf-8?B?VUlFMTNuZFVWMUFONGtSNUxSWkVMUzdJZ29wQkx4Wmt0V3NRbWJiZ2FUSnM1?=
 =?utf-8?B?aGlHZllicWR0cjR3MjdobHBIaExvb1JydzRMbms5TDFQbmFXbGtYQkxBYVQx?=
 =?utf-8?B?R1JlQjdtTDFINWRsYjlNTkV6cS83RkY4TmFITDBBMmc5UHkxRDJ1UGdtNnNH?=
 =?utf-8?Q?et7UMGsZVA/FU86tUV34dkE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31109F0F30DAE94596834B28B5A0FD81@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c9977355-e6f2-4172-8103-08ddb80d669a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 19:36:25.1440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pGEk/aJ3I+uhNyrHuhgFA/gKprcgDV5zfeZ6lw7mjH50Triyw+3T2JqDwu7hydQ/f0vTniaZXSoN44uaG8wR3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR15MB6611
X-Proofpoint-GUID: CifSMrzEaOosvwJYSaPc-ALa_OZyk_LI
X-Authority-Analysis: v=2.4 cv=UtNjN/wB c=1 sm=1 tr=0 ts=6862e73b cx=c_pps a=n6opPnSa4QjJkQ1MU9ihXg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=haTTvYT_8pnQgB1nQnQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: CifSMrzEaOosvwJYSaPc-ALa_OZyk_LI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDE1NyBTYWx0ZWRfX6zOZJxsBpQqt EWWTZM4rFndTx5bXupy3xNIV3Mk8mlkJcZlnxbqcjgNZxCgc8QJSkvmr+q4ivjdLb+OTuLztkNL SIYVkEeHVwFLwEDp8qGVGlKJOlkt61GKnC1yK4F17ySqq0buqVUuxGdatV2Nn8Bcy8Jp0RF8oeX
 4CMXjw9JE5cJrrYig8GLJTRlri7IWpWvAxKvY32yV1GkEtnxzrCXI6Q0WOhvx3b7cKMV8zkhuYo 8DT0WEkeO9NAZYaGPLZwGtZkHBD4mZRiS7Ou+6dsGnjZgbyYPw67/T5KRaN4MNut+x2gB3n0f1T CjIWCFtwSkKZIgpzmJMfgOhnjycf/CkpS6MmqcJE60BC7sT9KC7i/gBSBJqu1fsqwiTY2TedDVb
 TuBiK05Q7J42ngJsdI/zKjgspDmU00iIFg/7nalYeXxoKux9c+W6HyCwKjPpmM/CGirpWt5H
Subject: RE: [PATCH] hfs: add logic of correcting a next unused CNID
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_04,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300157

SGkgWWFuZ3RhbywNCg0KT24gVGh1LCAyMDI1LTA2LTI2IGF0IDE1OjQyICswODAwLCBZYW5ndGFv
IExpIHdyb3RlOg0KPiBIaSBTbGF2YSwNCj4gDQo+IOWcqCAyMDI1LzYvMTEgMDc6MTYsIFZpYWNo
ZXNsYXYgRHViZXlrbyDlhpnpgZM6DQo+ID4gVGhlIGdlbmVyaWMvNzM2IHhmc3Rlc3QgZmFpbHMg
Zm9yIEhGUyBjYXNlOg0KPiA+IA0KPiA+IEJFR0lOIFRFU1QgZGVmYXVsdCAoMSB0ZXN0KTogaGZz
IE1vbiBNYXkgNSAwMzoxODozMiBVVEMgMjAyNQ0KPiA+IERFVklDRTogL2Rldi92ZGINCj4gPiBI
RlNfTUtGU19PUFRJT05TOg0KPiA+IE1PVU5UX09QVElPTlM6IE1PVU5UX09QVElPTlMNCj4gPiBG
U1RZUCAtLSBoZnMNCj4gPiBQTEFURk9STSAtLSBMaW51eC94ODZfNjQga3ZtLXhmc3Rlc3RzIDYu
MTUuMC1yYzQteGZzdGVzdHMtZzAwYjgyN2YwY2ZmYSAjMSBTTVAgUFJFRU1QVF9EWU5BTUlDIEZy
aSBNYXkgMjUNCj4gPiBNS0ZTX09QVElPTlMgLS0gL2Rldi92ZGMNCj4gPiBNT1VOVF9PUFRJT05T
IC0tIC9kZXYvdmRjIC92ZGMNCj4gPiANCj4gPiBnZW5lcmljLzczNiBbMDM6MTg6MzNdWyAzLjUx
MDI1NV0gcnVuIGZzdGVzdHMgZ2VuZXJpYy83MzYgYXQgMjAyNS0wNS0wNSAwMzoxODozMw0KPiA+
IF9jaGVja19nZW5lcmljX2ZpbGVzeXN0ZW06IGZpbGVzeXN0ZW0gb24gL2Rldi92ZGIgaXMgaW5j
b25zaXN0ZW50DQo+ID4gKHNlZSAvcmVzdWx0cy9oZnMvcmVzdWx0cy1kZWZhdWx0L2dlbmVyaWMv
NzM2LmZ1bGwgZm9yIGRldGFpbHMpDQo+ID4gUmFuOiBnZW5lcmljLzczNg0KPiA+IEZhaWx1cmVz
OiBnZW5lcmljLzczNg0KPiA+IEZhaWxlZCAxIG9mIDEgdGVzdHMNCj4gPiANCj4gPiBUaGUgSEZT
IHZvbHVtZSBiZWNvbWVzIGNvcnJ1cHRlZCBhZnRlciB0aGUgdGVzdCBydW46DQo+ID4gDQo+ID4g
c3VkbyBmc2NrLmhmcyAtZCAvZGV2L2xvb3A1MA0KPiA+ICoqIC9kZXYvbG9vcDUwDQo+ID4gVXNp
bmcgY2FjaGVCbG9ja1NpemU9MzJLIGNhY2hlVG90YWxCbG9jaz0xMDI0IGNhY2hlU2l6ZT0zMjc2
OEsuDQo+ID4gRXhlY3V0aW5nIGZzY2tfaGZzICh2ZXJzaW9uIDU0MC4xLUxpbnV4KS4NCj4gPiAq
KiBDaGVja2luZyBIRlMgdm9sdW1lLg0KPiA+IFRoZSB2b2x1bWUgbmFtZSBpcyB1bnRpdGxlZA0K
PiA+ICoqIENoZWNraW5nIGV4dGVudHMgb3ZlcmZsb3cgZmlsZS4NCj4gPiAqKiBDaGVja2luZyBj
YXRhbG9nIGZpbGUuDQo+ID4gKiogQ2hlY2tpbmcgY2F0YWxvZyBoaWVyYXJjaHkuDQo+ID4gKiog
Q2hlY2tpbmcgdm9sdW1lIGJpdG1hcC4NCj4gPiAqKiBDaGVja2luZyB2b2x1bWUgaW5mb3JtYXRp
b24uDQo+ID4gaW52YWxpZCBNREIgZHJOeHRDTklEDQo+ID4gTWFzdGVyIERpcmVjdG9yeSBCbG9j
ayBuZWVkcyBtaW5vciByZXBhaXINCj4gPiAoMSwgMCkNCj4gPiBWZXJpZnkgU3RhdHVzOiBWSVN0
YXQgPSAweDgwMDAsIEFCVFN0YXQgPSAweDAwMDAgRUJUU3RhdCA9IDB4MDAwMA0KPiA+IENCVFN0
YXQgPSAweDAwMDAgQ2F0U3RhdCA9IDB4MDAwMDAwMDANCj4gPiAqKiBSZXBhaXJpbmcgdm9sdW1l
Lg0KPiA+ICoqIFJlY2hlY2tpbmcgdm9sdW1lLg0KPiA+ICoqIENoZWNraW5nIEhGUyB2b2x1bWUu
DQo+ID4gVGhlIHZvbHVtZSBuYW1lIGlzIHVudGl0bGVkDQo+ID4gKiogQ2hlY2tpbmcgZXh0ZW50
cyBvdmVyZmxvdyBmaWxlLg0KPiA+ICoqIENoZWNraW5nIGNhdGFsb2cgZmlsZS4NCj4gPiAqKiBD
aGVja2luZyBjYXRhbG9nIGhpZXJhcmNoeS4NCj4gPiAqKiBDaGVja2luZyB2b2x1bWUgYml0bWFw
Lg0KPiA+ICoqIENoZWNraW5nIHZvbHVtZSBpbmZvcm1hdGlvbi4NCj4gPiAqKiBUaGUgdm9sdW1l
IHVudGl0bGVkIHdhcyByZXBhaXJlZCBzdWNjZXNzZnVsbHkuDQo+ID4gDQo+ID4gVGhlIG1haW4g
cmVhc29uIG9mIHRoZSBpc3N1ZSBpcyB0aGUgYWJzZW5jZSBvZiBsb2dpYyB0aGF0DQo+ID4gY29y
cmVjdHMgbWRiLT5kck54dENOSUQvSEZTX1NCKHNiKS0+bmV4dF9pZCAobmV4dCB1bnVzZWQNCj4g
PiBDTklEKSBhZnRlciBkZWxldGluZyBhIHJlY29yZCBpbiBDYXRhbG9nIEZpbGUuIFRoaXMgcGF0
Y2gNCj4gPiBpbnRyb2R1Y2VzIGEgaGZzX2NvcnJlY3RfbmV4dF91bnVzZWRfQ05JRCgpIG1ldGhv
ZCB0aGF0DQo+ID4gaW1wbGVtZW50cyB0aGUgbmVjZXNzYXJ5IGxvZ2ljLiBJbiB0aGUgY2FzZSBv
ZiBDYXRhbG9nIEZpbGUncw0KPiA+IHJlY29yZCBkZWxldGUgb3BlcmF0aW9uLCB0aGUgZnVuY3Rp
b24gbG9naWMgY2hlY2tzIHRoYXQNCj4gPiAoZGVsZXRlZF9DTklEICsgMSkgPT0gbmV4dF91bnVz
ZWRfQ05JRCBhbmQgaXQgZmluZHMvc2V0cyB0aGUgbmV3DQo+ID4gdmFsdWUgb2YgbmV4dF91bnVz
ZWRfQ05JRC4NCj4gDQo+IFNvcnJ5IGZvciB0aGUgbGF0ZSByZXBseS4NCj4gDQo+IEkgZ290IHlv
dSBub3csIGFuZCBJIGRpZCBzb21lIHJlc2VhcmNoLiBBbmQgSXQncyBhIHByb2JsZW0gb2YgQ05J
RCANCj4gdXNhZ2UuIENhdGFsb2cgdHJlZSBpZGVudGlmaWNhdGlvbiBudW1iZXIgaXMgYSB0eXBl
IG9mIHUzMi4NCj4gDQo+IEFuZCB0aGVyZSdyZSBzb21lIHdheXMgdG8gcmV1c2UgY25pZC4NCj4g
SWYgY25pZCByZWFjaHMgVTMyX01BWCwga0hGU0NhdGFsb2dOb2RlSURzUmV1c2VkTWFzayhhcHBs
ZSBvcGVuIHNvdXJjZSANCj4gY29kZSkgaXMgbWFya2VkIHRvIHJldXNlIHVudXNlZCBjbmlkLg0K
PiBBbmQgd2UgY2FuIHVzZSBIRlNJT0NfQ0hBTkdFX05FWFRDTklEIGlvY3RsIHRvIG1ha2UgdXNl
IG9mIHVudXNlZCBjbmlkLg0KPiANCj4gDQo+IFdoYXQgY29uZnVzZWQgbWUgaXMgdGhhdCBmc2Nr
IGZvciBoZnNwbHVzIGlnbm9yZSB0aG9zZSB1bnVzZWQgY25pZFsxXSwgDQo+IGJ1dCBmc2NrIGZv
ciBoZnMgb25seSBpZ25vcmUgdGhvc2UgdW51c2VkIGNuaWQgaWYgbWRiUC0+ZHJOeHRDTklEIDw9
IA0KPiAodmNiLT52Y2JOZXh0Q2F0YWxvZ0lEICsgNDA5Nih3aGljaCBtZWFucyBvdmVyIDQwOTYg
dW51c2VkIGNuaWQpWzJdPw0KPiANCj4gQW5kIEkgZGlkbid0IGZpbmQgY29kZSBsb2dpYyBvZiBj
aGFuZ2luZCBjbmlkIGluIGFwcGxlIHNvdXJjZSBjb2RlIHdoZW4NCj4gcm9tb3ZlIGZpbGUuDQo+
IA0KPiBTbyBJIHRoaW5rIHlvdXIgaWRlYSBpcyBnb29kLCBidXQgaXQgbG9va3MgbGlrZSB0aGF0
J3Mgbm90IHdoYXQgdGhlIA0KPiBvcmlnaW5hbCBjb2RlIGRpZD8gSWYgSSdtIHdyb25nLCBwbGVh
c2UgY29ycmVjdCBtZS4NCj4gDQo+IA0KDQpJIHRoaW5rIHlvdSBtaXNzZWQgd2hhdCBpcyB0aGUg
cHJvYmxlbSBoZXJlLiBJdCdzIG5vdCBhYm91dCByZWFjaGluZyBVMzJfTUFYDQp0aHJlc2hvbGQu
IFRoZSBnZW5lcmljLzczNiB0ZXN0IHNpbXBseSBjcmVhdGVzIHNvbWUgbnVtYmVyIG9mIGZpbGVz
IGFuZCwgdGhlbiwNCmRlbGV0ZXMgaXQuIFdlIGluY3JlbWVudCBtZGItPmRyTnh0Q05JRC9IRlNf
U0Ioc2IpLT5uZXh0X2lkIG9uIGV2ZXJ5IGNyZWF0aW9uIG9mDQpmaWxlIG9yIGZvbGRlciBiZWNh
dXNlIHdlIGFzc2lnbiB0aGUgbmV4dCB1bnVzZWQgQ05JRCB0byB0aGUgY3JlYXRlZCBmaWxlIG9y
DQpmb2xkZXIuIEJ1dCB3aGVuIHdlIGRlbGV0ZSB0aGUgZmlsZSBvciBmb2xkZXIsIHRoZW4gd2Ug
bmV2ZXIgY29ycmVjdCB0aGUgbWRiLQ0KPmRyTnh0Q05JRC9IRlNfU0Ioc2IpLT5uZXh0X2lkLiBB
bmQgZnNjayB0b29sIGV4cGVjdHMgdGhhdCBuZXh0IHVudXNlZCBDTklEDQpzaG91bGQgYmUgZXF1
YWwgdG8gdGhlIGxhc3QgYWxsb2NhdGVkL3VzZWQgQ05JRCArIDEuIExldCdzIGltYWdpbmUgdGhh
dCB3ZQ0KY3JlYXRlIGZvdXIgZmlsZXMsIHRoZW4gZmlsZTEgaGFzIENOSUQgMTYsIGZpbGUyIGhh
cyBDTklEIDE3LCBmaWxlMyBoYXMgQ05JRCAxOCwNCmZpbGU0IGhhcyBDTklEIDE5LCBhbmQgbmV4
dCB1bnVzZWQgQ05JRCBzaG91bGQgYmUgMjAuIElmIHdlIGRlbGV0ZSBmaWxlMSwgdGhlbg0KbmV4
dCB1bnVzZWQgQ05JRCBzaG91bGQgYmUgMjAgYmVjYXVzZSBmaWxlNCBzdGlsbCBleGlzdHMuIEFu
ZCBpZiB3ZSBkZWxldGVkIGFsbA0KZmlsZXMsIHRoZW4gbmV4dCB1bnVzZWQgQ05JRCBzaG91bGQg
YmUgMTYgYWdhaW4uIFRoaXMgaXMgd2hhdCBmc2NrIHRvb2wgZXhwZWN0cw0KdG8gc2VlLg0KDQpU
aGFua3MsDQpTbGF2YS4gIA0K

