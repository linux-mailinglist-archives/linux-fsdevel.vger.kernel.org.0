Return-Path: <linux-fsdevel+bounces-40450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E064A2370E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 23:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BDD2164A75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 22:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5098C1B4244;
	Thu, 30 Jan 2025 22:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="aDVYJB3z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F682F30
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 22:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738274776; cv=fail; b=MTCGroVHqOXW3xONkw710NwhFrOsCjwbdbNicglQXQ7vIsWKgjbRRe7iSVD7EPh5RSvoPTHZQDJiSqF89HxmbMUKq2Yzi/WJOw8SJnBslOx4kTi5ElDOFw+vLhFmhFXfC9QxIwcG8Cv16ERrdlULDHEn1VYFXIprqNJM7+P+rwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738274776; c=relaxed/simple;
	bh=O6EjPxzWnETS1HLfm8oISOaJpLTcmDz+2QfRkfWEWi8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QlceA5pzSC3a6bDThjnijIFKxUx25ROliGY0i71FOASTPCv1WPQnDJKCSy8a2V4V1iOs/h0EUQVlv85JotHV5Rax9rcLFDkVBK5XQfw5Hd6t4SqfW+AhGpPZtdUh1Jo0bDy8jRe3eoSrEeJvRku5MvUZvCH28DeV1OiNAQDg2AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=aDVYJB3z; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170]) by mx-outbound14-148.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 30 Jan 2025 22:05:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5ofhDbqtdOY4H3omhL9eC6Tlu5qJLBp5lBW/q3KDU5y3Tuhgh8IMBmLbgpe4EsNiQthx086s8ABSxvGK3gWW5eY4f4hoJaAcnhtaixLYMW3zPfCpD+54iQmPp7tAkRk9LtdtR52Kk+4Y4TuDIPyjzfKS+k6r0bD9WfCZo51CS0KNBhskFcJCXhOzcs2+120eydxtfqld08hQ2hHpLF6fj4/GYCVMyJOYwuQUayX6UhOvtG9BT/ll/Tk42xATYrCaETJQ9EKPt7PCFO5bfUVkXQPMh55t73onzRB7uTRYPi+wvCHuU9yPj+rM/SD6YbohaeKAqZnopeFjKQ2lyPl6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6EjPxzWnETS1HLfm8oISOaJpLTcmDz+2QfRkfWEWi8=;
 b=aYzAeiL24eJaqfJyQbB30f4Fkmyf72PVHD0o0NXpf31K/SphOVMlvE25bd1SsdYnhF2VZZQvJ3GcmRsL4SFjtlbdUtFkHUTTUJ3y7vm+WqqoBb6tw/yR8DW8Xog4/ZXVwITYInoUQ71KIO+msu6t8egHwJeEO47f6I6dCQ6QdANH9tlo5hMFHU48Dv7ZIw9LkfCuR3MOPf+fNuzj4YEzdkrhgRehv2cSTfrfyyQvH01bDudaqBjKm1o1NNWPSkd7Vk6elXNF9YBRSZFgbF+2ZgHKjO9gXcmQiRPWzz9e95RdHQyV/lbXy5d7dt4nJ/DVHwEYfqg/jIWrXFRBd3hUXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6EjPxzWnETS1HLfm8oISOaJpLTcmDz+2QfRkfWEWi8=;
 b=aDVYJB3ziC2NSpZEzOWx/GxzXi5Hv3Wc00vtXKPCJNBbc2qigf2a9Svj4AQji4haC6phZa3vqJ0rRF4tUdaOmFQArepAHdh4PnhPNGnmVaWX0DZvYKCmBrCLdw3JGsjTJbyozVdPpOan8n8xkRjGlGn1hJSrX8N2GPogpKuMTp8=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by CO6PR19MB5418.namprd19.prod.outlook.com (2603:10b6:303:14d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Thu, 30 Jan
 2025 22:05:53 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%6]) with mapi id 15.20.8398.018; Thu, 30 Jan 2025
 22:05:53 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: David Wei <dw@davidwei.uk>, "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Keith
 Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>, Jens Axboe
	<axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, Joanne Koong
	<joannelkoong@gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] FUSE io_uring zero copy
Thread-Topic: [LSF/MM/BPF TOPIC] FUSE io_uring zero copy
Thread-Index: AQHbc139lwLy1Wg1Ckic+6STDZZzz7Mv34QA
Date: Thu, 30 Jan 2025 22:05:53 +0000
Message-ID: <a3741a38-967c-44ad-9e73-64628048027e@ddn.com>
References: <dc3a5c7d-b254-48ea-9749-2c464bfd3931@davidwei.uk>
In-Reply-To: <dc3a5c7d-b254-48ea-9749-2c464bfd3931@davidwei.uk>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|CO6PR19MB5418:EE_
x-ms-office365-filtering-correlation-id: b84c6190-1a41-49bb-4c8d-08dd417a43ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eGVrN2VsK0xHRSt3bUxSeUVZMytPMURvWWFrUzd4Z3gxVDF5emF3WWJhYm83?=
 =?utf-8?B?Y0trQUNXL1NRVmRGbjUyS0l4eHJlUXNiVi80ZzRqMnNObzJIYWp4bTFBUWxy?=
 =?utf-8?B?ak96R0doRFR5dVRpa3pFYS9RNW5NcFA4aGdJa1hhZFRXK2ppZENwWVgxNS80?=
 =?utf-8?B?RFZZWnh0NzgrS05MVHUzY2ZJaGRpRCsrY1JYMWt0VkpIUnpLNlRCc1d5MWpo?=
 =?utf-8?B?R1BRZTFMd0xHeGZxY00xSVJvSHZPQjhPTUtmamQrcy94UHFRZ0xNMGw1K214?=
 =?utf-8?B?NHBneTU3TU1Objl0K1RVOStadlNnaWVXT01STTJKOWIwU2VEZlNGeTRDTDEx?=
 =?utf-8?B?M21YcW51M2RSTFJ3c2pnWHJrbCtBaFhKMWp2b2U0bWpzbTZuU1JhZFA1RkNW?=
 =?utf-8?B?QWV3NDdRQ3FVNXFiTFZvVHRucy82aXJIdzZYV3dSOFRzN0lOcUNnakhDL0Vs?=
 =?utf-8?B?akhrSktLcEg2NHB1dnBlNGFHL1ltdldTOEFwckVjSlEzSmNoYUpmeWttN3JJ?=
 =?utf-8?B?UlEyWFlCN2JIdlFCUlNSTDBGSEtoSmlqa2lqOFFNUTk2M0NKK29pYnJnQStK?=
 =?utf-8?B?ZGpLRVY4U3FRRWRhZWR5dk9QUGxoUlQ0aE05aFFwM2U0TGhUekN0cTVYVDla?=
 =?utf-8?B?ZXZMQXI2VXRDbnoxVjJpSmM2VTFnNjBvQ3Y2TTM3Y2FPUjFIZDQvd2NMWk1o?=
 =?utf-8?B?RVlmKzFsaDNmYlJNak9CbGtNd0FucHpGcGMwL01zUWhLaHB4eXd0WFpKSFIr?=
 =?utf-8?B?Y2l4eTFoNEM5dzAyQ3doWEFoeW5FQ2NUUnpVakJGeHVoeHZFL25iRUNnK25i?=
 =?utf-8?B?SnBpcVZxZ2hCRWJ3NDFrSzNDSXRhdkVLSU9odUdlTEh3Z1pmdW1wR1lZTjNE?=
 =?utf-8?B?MEZOZUtGYzZ3Nnh5U1ZWUGlHYUFMRVlhQ1NxQ3BvVG85aWVxbWc1cDF1K3BV?=
 =?utf-8?B?Z0l6dVVSa3FyRDBHaXVFT0hzOGVTOW9SenZzYVNSQTJXQWFTZzZYdmNPSVlR?=
 =?utf-8?B?MWxNMEN5Q1J6VVY5SktobUtWdm1lb0h6UUpIUUVtWVgrY3FLQkRyOGJRTitq?=
 =?utf-8?B?TzZrM1ZjNFEzZnJvLzllbXhXVVVZbjZZVUcvY1N0WTZJa2ljdTI4T29yNFpa?=
 =?utf-8?B?NGJDbHhSVFpoc2JQQmN6eXdqZkxPNnVSeStVNmJMNjZ2QmFVKzlTTzNVYWtk?=
 =?utf-8?B?NU9wZ3pnVnMyV1plVDRiOVhUSVRJT0JFUkVIV1ZEbTY4Ry9oTll5dlVuckRJ?=
 =?utf-8?B?ckJSMWZGWE5VUCtlOVFESzFLaC80citwWUF0VURSNW5CTnNkekdValBKaWsr?=
 =?utf-8?B?VWtLU2NkZDZYUnpjOHFrUS9zZVJGcnFDZFpRanQ5Vy9oY3NaRUlXMVpaR2w5?=
 =?utf-8?B?MWZsbHVUWCtsUGM0R1RmdU8vdldPV28yOVV5Q3QxWkd4ZDZWVUNhc0lvZUtC?=
 =?utf-8?B?S28wSzk0dWEwdEVqWXY0a1V6UEoyQmViZWhwWlA0RXIrQk9vaW96OG9vaTZ4?=
 =?utf-8?B?UmxGbzBYdVdTY241SGFmNkNNNmdUZUJkTnhGSXBsckVxODRPam1qanFOV1Fm?=
 =?utf-8?B?ZEM0L2gvY3JJOVVwbWU2Q3pnN3NJUk9UdDFRSy9Qc3FXai9yUmd2SWc4OTBB?=
 =?utf-8?B?NGw1LzBGazVUYXdzU25ta1RwUER4M1FPaWh0WmtzRk42c3JCUFIxQVJEcTlW?=
 =?utf-8?B?eWFweklCWDdvOW9zajdnUytkV3VuMFRaa0xZWWhmUmpiN01vaFhNeHY1NUlO?=
 =?utf-8?B?eExacFplZ3lYeE53VGplV3FkYlNKNjhrdFBReGlaN09LKzBrZnFmcE1WWmFV?=
 =?utf-8?B?eGIra2pNZ3RWcjRxV05NMmFmOEFGYTAyZmVLRjFLVXVjc1FxaytSZ3RGK1BD?=
 =?utf-8?B?L1l2QVg2QzRQcllmTklJZ1ZSMmRpeFFQL2x2QlVNMHNGclF6K1ovYlg1Yjgr?=
 =?utf-8?Q?9B/SyvjYe9pRNEizBV2BL5O/3JzpAJ5J?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eUJ1ZVRwN3g0V29YRTMrdDNJNkhxQUVYOGQxSUpTZWZDeVA2RTZ5WnhVeWVV?=
 =?utf-8?B?a3U4SlN2RUtWODhVaS9KTE0yT3B4TkNGMHRmU2R5VHlPcDNZTlFEZzZrYm9y?=
 =?utf-8?B?dEticnUvUm5Lb2FLcGJQbmIzZzVKemRMM05WMGd6eWxQRnhQaGJhcUhlUThR?=
 =?utf-8?B?c1BRSVgrdlp5cVdOVTJiMjYxSEREb21uUkFMWFN6MUxmbHNWREFOaVZoZjk0?=
 =?utf-8?B?enV6NTFHT0VRTEdGdGplZFpOOU5GY2NKVkVKVzJOaTJmYW8ycVNncjFUdkVu?=
 =?utf-8?B?Qit2UnZNRkEzZHFVcFBoN2dORTRPekhRMVdEaDZBMm10VzdHWlY2SHQ0S2wr?=
 =?utf-8?B?Y2dtVnBtVytwVnVqTmVpVncvVUc2VTRwS2M5MVlXbkpMQjlaM3FmcjlOcytM?=
 =?utf-8?B?MU5XWXdwWEZNUmxsYXQ1eGNZTG1tR3AxNURCb3QyZmp6a2J4Yk9kWkt5ckFM?=
 =?utf-8?B?KzlreVMvNGtBL3R3cUJzQzA0RTdBeUYvZEs0ekFubzlkdUhIVlJaMVhWZUVI?=
 =?utf-8?B?MDdqd3NyUWtXTm14SDltRFc1U2NNY0dLUXRWMWdZb2c1VVU2ZXRNU3hJK085?=
 =?utf-8?B?OEswcHJ6SHhXcDMrbm44Z1dtd2VvU01WOU53YVFXWWh2NElCY1BmVCtOZ0sr?=
 =?utf-8?B?elplbXV3ZVJNYUNlNlZINnNqc3JxTjEwSDRQM2YxVjMxUTlaRUdpVUxwNjRa?=
 =?utf-8?B?MFpxL1Q5dlgzL0c3VEtQbDd5NlZFY1EvanFnS3QwZW1Cdmk5VXh2YzV6MTlq?=
 =?utf-8?B?K0RiT01acmhjUDhsUzVhay9QeWI0S1JYTUtrSytCZmtFMlF2ekRwMUlKT3hu?=
 =?utf-8?B?OUdUd3VqcmNnaDBBelZHQXBGVGVyNWd6YVAwLzhtMCt6TTZOSnNoTXZVSEs4?=
 =?utf-8?B?b3l4VE02djRFNVI3QlVwaDQyeXBRdkNETjQ0eFg1U1d3bHJiZzFkZGRmRzZ6?=
 =?utf-8?B?eG1sbnZPNnB0ak5MZzdZMnJoOXVMSnk0U1E4emlSWUp3UXNvVjAxUXJTNjln?=
 =?utf-8?B?ZldkT0FhYVNLeFA3WnBXUnIyUnVTOTlBMUNmZGxzdUhZbFl5MzJEYkhuZHg0?=
 =?utf-8?B?c3ZWU281YnlDMkFtalpRcFp2S1J4N0xBamcrNGFRTWJCRHc1SFF0aVpqZ3FR?=
 =?utf-8?B?TGdqMkZLVGlNMEJyOE15SUlMS3d4RlRZc1Z1OG0xb3U5NlBsWURTeHJ3djZQ?=
 =?utf-8?B?eFZqdlA5SURyTXM3eU9EN0daWlNGemJZbGFLVWpMOVBva0k5UmJTWFBCUWFJ?=
 =?utf-8?B?ak9QRzgrS3Zxa1g0OHhsc09FUFJZbWFheFJEZnN2MlVaUUZpOUE3dGpCQzNU?=
 =?utf-8?B?SjBjdGQ3Y0NEK2Nya2VHeWhtQzRQY1N1UUlXb2lMY2RUVVE5QVBpbzNrVnRN?=
 =?utf-8?B?eFNOWGNtSzZoY0dNZjRHTy8rd3RJRWsrUWZSWHlXbkJIV0pHa2l4WHY2REhw?=
 =?utf-8?B?bytEVWU3UEtRMk5uWit4RGdVT3Z3QUhMYzBvVUVlZFFpMDBwQjZTRVFwVGQr?=
 =?utf-8?B?bEI2RGRxSkRiME8vSW5CT0ZuNm5nUEVKZjl3NittQ1AxeENmdWxTM2lTWlY0?=
 =?utf-8?B?NzE5MnVXcHIvUG1DZm9EbTRleHF1OSsyS2hkempRZ3lvOUZ3YVhPQlJrTS9n?=
 =?utf-8?B?UEpPS1UwTnAxN1NzVGJmOFlQbmFOUHRZZ295L3ZDK0RiL0c5SGk4SytOL1I1?=
 =?utf-8?B?ZThJN1o2c0J6ZktZOXlxbEJURmVCcjBiSEExS0xxaW90RWNPUGkra2FQT2pq?=
 =?utf-8?B?Qk5MZDdxWmEwY21HaG93RzZieWF3NldwYXk4U216UCtaSzJ2aDJEMTNCa2xX?=
 =?utf-8?B?dUJnUGhUNUJSdWg0TDNUMGV2K0c5cVpCMHJuUXRJRnJKSGhSOEpkQ3hSellO?=
 =?utf-8?B?U0Fvek5hb21PVzBYYVpYdjlCRW40OHJGMnkrMHJpKzQxZHJqZkVYdjdQTHFV?=
 =?utf-8?B?NzlSTVR4cm04N3AydmtnRlJscUlrdFpkZ1dNblZRNVJzc0JpUFk0cGMvSmZH?=
 =?utf-8?B?UUxUZmJ5Ym9jUFM3VU9iV1ZORzNRR3ZIYzJ1WFZraTY2cHMrWDdkdnhtbFJZ?=
 =?utf-8?B?a202QkVhbXA3RUR3WmtvV1Via2kzNVpPbHVFV3o2UHlwSzBzVkMxOXpEZEhM?=
 =?utf-8?B?dmpVWmp2V3BIblBMVjZxbjgrSjFWQUFndFFXNzM1ZVA2VHBLQXN2SjB4VHpp?=
 =?utf-8?Q?npwlTsFfoY/y83onl5YuN+w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3DC386586AE0A4295ADC5DCBCB65C64@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8OQX7JjSBdfEpF5wGY0/3LGjJ9PW5zARl+BbHcHTnPhxDDdNLeASVGxuRS1Az+Sh4SxVVimdGOlZj762rcWpmcDy9dia1Fh5rugEr7h2vcE1+bmh+JzU1P7F54zU9kIRvrwwErkXoOgyaE8dDgRAL3OnRHD8htWJ70ftdnyf44aLt15iehB8cK0YNQIz7GIlJjBheYKbjJJKl2zwxvP9pA+cNRIYXuw5w8Y4ejW+ZqZ72D/CX62LqIXjHfYJfYKkiOKGU/lagjJQ6uXU7Di94c286Nzi55zfPtM+Lci8np6fL3yYynJXGIBBDtrNQY01v3AD+c6XUasGs3JK7uGIFKy0D0NMiYlNjEneE0hYYwgSoRXyFSqFXMRgXoz3MljkE+iXFVItiRex4o8K0HNCiUS0+0P+pcLmsYIYH71DK2KaZQk/M5fv4erNYsf0dCQ87OwIYRljdoTvizFrf9g4I53sm5w4Sc3K+pZ38+OPU1JrJ62Hqc1LZ6LsXdYrCy+kmxFDPtvm5ub952NcUVA8uPbsrq+XyICxs+RZC4H9XTnjCz4d2Bwfp4x9XxAh+j3q8n+yQRYh+GGS/Wzn6EXgDHncL7zyB5L6mIdPtRLXoPgf3z42FiNRow1K4VRDCLyVs6xlu766TpeulbfPOJA1og==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b84c6190-1a41-49bb-4c8d-08dd417a43ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 22:05:53.3655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fUJtW7D7/WoOJuP7Ts8ltbnW1CAfgzhiA73aWSWYFVRN3BMHyjqHDeVoa/qE9ZFHLF1qO5ziEiAvvV8FqZRc7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR19MB5418
X-BESS-ID: 1738274755-103732-7522-5279-1
X-BESS-VER: 2019.1_20250123.1616
X-BESS-Apparent-Source-IP: 104.47.55.170
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaWhoZAVgZQMNXAyNjQ2DzNyM
	DY0jDRKMU42STJODEl2TjVNNU81dJCqTYWACO/Cm1BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.262175 [from 
	cloudscan19-80.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

SGkgRGF2aWQsDQoNCkkgd291bGQgbG92ZSB0byBwYXJ0aWNpcGF0ZSBpbiB0aGlzIGRpc2N1c3Np
b24gYW5kIHRoZSBwYWdlDQptaWdyYXRpb24vdG1wLXBhZ2UgZGlzY3Vzc2lvbnMsIGJ1dCBJIGRv
bid0IHRoaW5rIEkgY2FuIG1ha2UgdG8gdG8gTFNGL01NLg0KDQpPbiAxLzMwLzI1IDIyOjI4LCBE
YXZpZCBXZWkgd3JvdGU6DQo+IEhpIGZvbGtzLCBJIHdhbnQgdG8gcHJvcG9zZSBhIGRpc2N1c3Np
b24gb24gYWRkaW5nIHplcm8gY29weSB0byBGVVNFDQo+IGlvX3VyaW5nIGluIHRoZSBrZXJuZWwu
IFRoZSBzb3VyY2UgaXMgc29tZSB1c2Vyc3BhY2UgYnVmZmVyIG9yIGRldmljZQ0KPiBtZW1vcnkg
ZS5nLiBHUFUgVlJBTS4gVGhlIGRlc3RpbmF0aW9uIGlzIEZVU0Ugc2VydmVyIGluIHVzZXJzcGFj
ZSwgd2hpY2gNCj4gd2lsbCB0aGVuIGVpdGhlciBmb3J3YXJkIGl0IG92ZXIgdGhlIG5ldHdvcmsg
b3IgdG8gYW4gdW5kZXJseWluZw0KPiBGUy9ibG9jayBkZXZpY2UuIFRoZSBGVVNFIHNlcnZlciBt
YXkgd2FudCB0byByZWFkIHRoZSBkYXRhLg0KPiANCj4gTXkgZ29hbCBpcyB0byBlbGltaW5hdGUg
Y29waWVzIGluIHRoaXMgZW50aXJlIGRhdGEgcGF0aCwgaW5jbHVkaW5nIHRoZQ0KPiBpbml0aWFs
IGhvcCBiZXR3ZWVuIHRoZSB1c2Vyc3BhY2UgY2xpZW50IGFuZCB0aGUga2VybmVsLiBJIGtub3cg
TWluZyBhbmQNCj4gS2VpdGggYXJlIHdvcmtpbmcgb24gYWRkaW5nIHVibGsgemVybyBjb3B5IGJ1
dCBpdCBkb2VzIG5vdCBjb3ZlciB0aGlzDQo+IGluaXRpYWwgaG9wIGFuZCBpdCBkb2VzIG5vdCBh
bGxvdyB0aGUgdWJsay9GVVNFIHNlcnZlciB0byByZWFkIHRoZSBkYXRhLg0KPiANCj4gTXkgaWRl
YSBpcyB0byB1c2Ugc2hhcmVkIG1lbW9yeSBvciBkbWEtYnVmLCBpLmUuIHRoZSBzb3VyY2UgZGF0
YSBpcw0KPiBlbmNhcHN1bGF0ZWQgaW4gYW4gbW1hcCgpYWJsZSBmZC4gVGhlIGNsaWVudCBhbmQg
RlVTRSBzZXJ2ZXIgZXhjaGFuZ2UNCj4gdGhpcyBmZCB0aHJvdWdoIGEgYmFjayBjaGFubmVsIHdp
dGggbm8ga2VybmVsIGludm9sdmVtZW50LiBUaGUgRlVTRQ0KPiBzZXJ2ZXIgbWFwcyB0aGUgZmQg
aW50byBpdHMgYWRkcmVzcyBzcGFjZSBhbmQgcmVnaXN0ZXJzIHRoZSBmZCB3aXRoDQo+IGlvX3Vy
aW5nIHZpYSB0aGUgaW9fdXJpbmdfcmVnaXN0ZXIoKSBpbmZyYS4gV2hlbiB0aGUgY2xpZW50IGRv
ZXMgZS5nLiBhDQo+IERJTyB3cml0ZSwgdGhlIHBhZ2VzIGFyZSBwaW5uZWQgYW5kIGZvcndhcmRl
ZCB0byBGVVNFIGtlcm5lbCwgd2hpY2ggZG9lcw0KPiBhIGxvb2t1cCBhbmQgdW5kZXJzdGFuZHMg
dGhhdCB0aGUgcGFnZXMgYmVsb25nIHRvIHRoZSBmZCB0aGF0IHdhcw0KPiByZWdpc3RlcmVkIGZy
b20gdGhlIEZVU0Ugc2VydmVyLiBUaGVuIGlvX3VyaW5nIHRlbGxzIHRoZSBGVVNFIHNlcnZlcg0K
PiB0aGF0IHRoZSBkYXRhIGlzIGluIHRoZSBmZCBpdCByZWdpc3RlcmVkLCBzbyB0aGVyZSBpcyBu
byBuZWVkIHRvIGNvcHkNCj4gYW55dGhpbmcgYXQgYWxsLg0KDQpGb3Igc3BlY2lmaWMgYXBwbGlj
YXRpb25zIHRoYXQga25vdyB0aGUgcHJvdG9jb2wgdGhhdCBzaG91bGQuDQoNCj4gDQo+IEkgd291
bGQgbGlrZSB0byBkaXNjdXNzIHRoaXMgYW5kIGdldCBmZWVkYmFjayBmcm9tIHRoZSBjb21tdW5p
dHkuIE15IHRvcA0KPiBxdWVzdGlvbiBpcyB3aHkgZG8gdGhpcyBpbiB0aGUga2VybmVsIGF0IGFs
bD8gSXQgaXMgZW50aXJlbHkgcG9zc2libGUgdG8NCj4gYnlwYXNzIHRoZSBrZXJuZWwgZW50aXJl
bHkgYnkgaGF2aW5nIHRoZSBjbGllbnQgYW5kIEZVU0Ugc2VydmVyIGV4Y2hhbmdlDQo+IHRoZSBm
ZCBhbmQgdGhlbiBkbyB0aGUgSS9PIHB1cmVseSB0aHJvdWdoIElQQy4NCg0KQmVjYXVzZSB3ZSBs
ZWF2ZSBwb3NpeCBhbmQgaXQgaXMgcmF0aGVyIGZ1c2Ugc3BlY2lmaWMgdGhlbi4NCg0KDQpUaGFu
a3MsDQpCZXJuZA0KDQoNCg==

