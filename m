Return-Path: <linux-fsdevel+bounces-39939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB77A1A5E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 15:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAFAE1885628
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 14:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F691211293;
	Thu, 23 Jan 2025 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="A9PIl5mv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA1F20F083
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737643318; cv=fail; b=M4abtBHyNsx8R2ZRVyY3ZVA0ElDUn5JkiObKRtuY/xNZSDNUCuVw/xXAZmV/v/NbamOps7BSg0LTMaScEW1bcWl/4p3314dli8/AOAaRtRues0H5n55IFUZkJA4JRHz9irISpEKLWja8OrmSu2DJSY0rCaow7zNjo9/HEnIaRf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737643318; c=relaxed/simple;
	bh=Aee7ZPaW/DgyFALPyBtBtpuLPSMzSHAEPV/0IK5zmcI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VZagPvN2Z2FGJ2I3q/pPV0R7C+wEf5yDq93GCr0o8Yc2OOx5kxDoxfr3irGniEiehK61Q9M+CKpi32dJINXVo9mQEdzwk8mUSF3/9HIL7aZwZc0QRc9g5eymtioBnYOE2yojR83NOLB5OtLlfRmMFBHqbeSNRnhPJgMqsdOMAms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=A9PIl5mv; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176]) by mx-outbound47-151.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 23 Jan 2025 14:41:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMtGA+LxirmQ8zXcrH34XuPxjdm8uxr5Mp5c5yuvRMPRkuxKB+DPvhFFmt3Iqz6FRRlQbdX90ML4N81atcNGNzZTDBXdF0Mo4Cv5NZ/cQe4PJ5vTJUGGxkyBPVLck/ZCtCd38wVoHJk4189Lj8BksR+uaJffKHlr+OXJAESrm+IurR7H6iWqxaEsUGHFohTj98h454smxVAdncbnWME/yzRKbveeXdQgN6F9GYCm3MndUgN9lrovTnPXyjsHgUzGcVWDpCwhkNEiTjYuAT+i+GcL+WBWSxRFt7jWSGgn7mLMGAYb/Fvhi8NE9tHrnEYE897icAXxiED/H/vQJZrIfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25D+8rjQGy9RxWzAm7Vmoq3U0Kt4Lftgy0d4V4WQUgs=;
 b=x4sJe40tStP3qnSznwQWxTZbJwRo1cZTvHTC/Dv7mfsDJAoQKbzNfnj080L3/2l4qGGf3cTc624FxUo5LVSfFFnRMforYEXCELapfb+hi6ih8gkm6dbOTvH7TUNH8Q8y4riIYc2PIxF/+2C8RHd7ncHp1owIX23e8osATmiVrNTIq6ZDBMOReC0qAXiKxmUGvH8+TzE2mkxP/wbh1h1w9nRgkhZfVZN0+jCr1aVhSQoN+NlPVGBE1h7q0yfs/7jkLBd96KYE/NLbPopdn5Q3Al+dx7/unT6yk8UNZ+SaMGqOguGcam7C+4yaLKKBcmEBs2Fh1BHNleY4pkTRd/x6jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25D+8rjQGy9RxWzAm7Vmoq3U0Kt4Lftgy0d4V4WQUgs=;
 b=A9PIl5mvbmOb9Se1HA+CXo0dPfWvg0iIwz/q8yQam/aNBplVfQKL2LAmiTQJNBMsoS/KIqYU7E03uw8cjEFZmk93HGfR3RpvlVxL82a1EGGc1XfN3yDpG5UcQ5uHE3kWrV1kpd+ySJhQYEmZlAtHAME1Epl7Vc0yRX3SZ4JeCD0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by PH8PR19MB7784.namprd19.prod.outlook.com (2603:10b6:510:23b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 14:41:18 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%5]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 14:41:18 +0000
Message-ID: <9248bca5-9b16-4b5c-b1b2-b88325429bbe@ddn.com>
Date: Thu, 23 Jan 2025 15:41:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/2] fuse: add default_request_timeout and
 max_request_timeout sysctls
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org,
 bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
 laoar.shao@gmail.com, jlayton@kernel.org, senozhatsky@chromium.org,
 tfiga@chromium.org, bgeffon@google.com, etmartin4313@gmail.com,
 kernel-team@meta.com, Josef Bacik <josef@toxicpanda.com>,
 Luis Henriques <luis@igalia.com>
References: <20250122215528.1270478-1-joannelkoong@gmail.com>
 <20250122215528.1270478-3-joannelkoong@gmail.com> <87ikq5x4ws.fsf@igalia.com>
 <CAJfpegtNrTrGUNrEKrcxEc-ecybetAqQ9fF60bCf7-==9n_1dg@mail.gmail.com>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegtNrTrGUNrEKrcxEc-ecybetAqQ9fF60bCf7-==9n_1dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P251CA0014.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:b5::9) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|PH8PR19MB7784:EE_
X-MS-Office365-Filtering-Correlation-Id: c56af937-b019-4e00-6601-08dd3bbbff1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajRldGtPKzZleDBkOEtwRXBydTNBRDFRNUE1M3d6Vll5eTFkeFdNOVl6QjFx?=
 =?utf-8?B?UGtvQVpDWXFCNHFCbm16Vy9nOE4yakxRWlBGTDlYck50a1EwNWM1dWVKd0FB?=
 =?utf-8?B?KzVNQmlDSnN4aTZZdHdyWDcrdW02WjBteEJzeXpyVC9DME0wWlBmaFNFZWhv?=
 =?utf-8?B?TGEyK2dqNEhmZ1dRTXBMOGVIOTZGS2NzRTNXZFI0Z3lFbjFhcWtUU1V2WTRx?=
 =?utf-8?B?emdqWTRIL20waFZVK3hBYXlwTnFyV284VTNmUVpoTmVTbkh1SDZobnJ5eDYy?=
 =?utf-8?B?UVlFM2JPQ0ErdkFZTGs0dUwwNWpqd2pPZFk0M2hJZjgzbFZSNHJsRnk2Mzdh?=
 =?utf-8?B?Y2Facks5Y0UwRGFMSG8xTXo4NWVjcFpHNkdhSmJ3QUhyNFdXVlFxNUJxc3c0?=
 =?utf-8?B?a1d3UHY5VVgxZGhNcmlkZWtkS3Nod2ZiMEd1bHBpVVpKWDE1RXNrcnU5VmI3?=
 =?utf-8?B?eUpaTXZGSkVNMkRjc0ZuL3B4Y1ZvaUxNTmhkbGwxRHZhdjlzME13Q1lVejhH?=
 =?utf-8?B?RzlxR3ZaUjAwa2c2OFFwY3U2ZlZMSXU2S2tDbUVTN0ZzcGY1QTdNZVdGYjV5?=
 =?utf-8?B?Q29uVExOMmhrUWp3SHo4cWlQVlo4ZTBpZTc5dGsvVmtWd0JHc0dnV1NpbWpE?=
 =?utf-8?B?dXFyZXF2L0o1aUNrcnlORTQ5NVFhMGdrQUlTbWFPM1RJcU1xN0lvSGF0S21q?=
 =?utf-8?B?Ym11QVJFY3BCYVF1dVhRZ0tHa0M1TWRWSlNtWUpyTU1hRFd4dDVIWTE2ZEFQ?=
 =?utf-8?B?L0tVd1pZU1VPaTJVekVSUXJBV1c1UWs0Ky94QXNUb2VQcHkxWll5UzFESTB1?=
 =?utf-8?B?a251aU5zclBMUU44M1ZlcC96SksxcUFJcFBrbmcrZmpZL0Y4WklobmRQbjlV?=
 =?utf-8?B?dVdrMzhkbThOb0FZWVA0YUVsTTdmMkZZTFpKQ1lJUUNyeUFMUllIT2pGVVdM?=
 =?utf-8?B?QmhsMkdtTnNrT0tHbHlHZDZHOW1hZG1aUnFZb01UaUZWTWhXRXBjQWZINFRF?=
 =?utf-8?B?UWhmc3BKOThqVC9seVNYdUFaYTkzb1BNampKVWIvdG1LRkxabE03NWpiOXgv?=
 =?utf-8?B?MWFhS2dFdnJIeTZCVEV3NlZ3cU56U2NCOEQ5Rk8wdVIzcW5oWEhKaEVOSFhF?=
 =?utf-8?B?SjlNeGYrZ0dnK0dJeVVYQjZYa0s2a0M4ckh6UU12UGhwOEMwVVVVTWlaV0ND?=
 =?utf-8?B?ZXU2b3dhVmFpMEFKUnUxNGlNUldMSU9BNVltUTB4VUd5dmZuYm5PblF6UnFR?=
 =?utf-8?B?a1pkNFM3NVdvY1hJKzA5MldIdGRGS01GK3E3d1h4NEw4OWkvT0N1ZUx4amZp?=
 =?utf-8?B?a0s3VzdZYVZjNVJHTkpqa1F1cUp3RGNDa1JCR2dWWmpJTDg5Q0pEbFBYY0pX?=
 =?utf-8?B?dWY4WGJ3TXE0TWF3QjhNYlJTb3UwYUp1M21OTjRJaXhLM21oYWNmZVNEN1Qy?=
 =?utf-8?B?MjZ0ZlF6bkJJdFMrVjVFWThybzdnaENMZ2JZR3BRWHJMYWdaNE1ha1BLOFlO?=
 =?utf-8?B?c09IZVltODZlZUMxeFE5UjJ2OGo4UEdnSW5ZNUtkYVp5Z2RLTkMwM0tjRHNv?=
 =?utf-8?B?aG5kMzErU2lLWkVxMXhyNkdSNUUxMFIvUWltbzVmam1VNmJ2TW5XTTJ1b2k3?=
 =?utf-8?B?TXRtVWdKY0JmdFpFRTExL3dzQkVKekpFSk1VRm56eWFJSGY3QmFHRk5SNlJU?=
 =?utf-8?B?SWxVbmduVHc0VzZUSFUzeWYvblVOL3FIUGxKMmRLRDgrRVc2eXNTaTFUa3I0?=
 =?utf-8?B?UnppdkVWZ3NtMytxNlYvWjRHZHFHMEhDek8xZCtaeG5qNGhFRFArbURtbnNI?=
 =?utf-8?B?TURZWmo3YWxRUWx3cVkwSndRMTFVM1NkbVYrNldwS2kzN2dhV1BxWWNkNjNI?=
 =?utf-8?Q?sascj8kN5l1U5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amdycjY5VTJlK3BtamZaZ2VZSVFiZEFoaVpEelpwaEpWRFRtQ2lmdXFoVzhR?=
 =?utf-8?B?RXpDNDlRcnpEazZsUFYzWnozODhmM0N1b2NVMXk1SnNsdFA3QlZleXo2Yklu?=
 =?utf-8?B?MG5ESWIxT2dOamN2MzAxNFdyaFBHMElvblBvMURoeXkrUEtlRGlaRDhUR0xS?=
 =?utf-8?B?WVg3L3oxQ0g0RUVGSlRsN0Z2R2VmU0VuUU52NHFuUmYxOG5MRUNxeFg5ZUFT?=
 =?utf-8?B?VE1qT25PSDRzNHhycXFDZVl0SVErcVdNOU8zeDJIR201KzZVQ2o1ekJlc0tV?=
 =?utf-8?B?aklmUUNoQzhSMnYrS0picUYyRUZadUxuTHM2V3d5OUcvdHlYVkJJV3AyUHdG?=
 =?utf-8?B?TnR4Z2hkb3VSQm84UWRjWkRTUDViRy8rL3BOUDdqUzNOOVBIR2tXTTdKMlVh?=
 =?utf-8?B?Ymh4WWhoUXluYThYWTBXOURRQXdSeGdNU3JHbGQxbktSMU9raEp1c09LVWNo?=
 =?utf-8?B?eWJ2YWlVcDJVL2pjb2NxMTR1TjBBV1pmSktRS25BMVVZT3pUbWwzQSs0YVVM?=
 =?utf-8?B?TXN0OGlaaXU1OEZNcHBxZmJQbG1TRmFCY1d4TnprL3pIUUhMelhURFBuL3pF?=
 =?utf-8?B?Z2F6N2FNVjFJWU5rWnZjVEErZWdmS04waTJzbFFWQU1WTFVsTHRXcVdndkdq?=
 =?utf-8?B?cWMxYkNXUUM0WHRhU1ZpbTJWMzRKWjVCeGNUMmhSNW9tYXFuM0xyY1Q1dzBx?=
 =?utf-8?B?L0JPbGtrVGQ2dk1saXdKM3hCT0E4blpPLzBsM2k5cUlwZGVrYmtLNXJxcmhY?=
 =?utf-8?B?bWpzRHRuTVlndzhCdmgwb1VYMUZxTkR6bk1DVmZJdFh4dHNuU1lsVXlPT2lF?=
 =?utf-8?B?YkIyTkJSRmk5UzNiOFdTcEg0OWVzSjJqTE5CVGNRN0VxQjBRSWRkaWRDQm52?=
 =?utf-8?B?cERGT3kxeDI3N1hrcC9aOHc4Um9DTy9HS2YzQXNtTG9TMnhQMUZHUjNYYjlD?=
 =?utf-8?B?RHoxb3Y5RGtDMG9jTUtSQWJ1eGFkQ1NneHQyWFc2MDd1c09peUZ1cDk0SW41?=
 =?utf-8?B?YTJ1ZG9RV29ZZ2RIYTQzdVBzY0ZXZDhlQzljTXdYMC9DaVFCZ1EyQURrbnNu?=
 =?utf-8?B?aXZ5RUhTMFFuZ202MUlXQTBpVnJIT3o0OUMwM2cyamRVd2Z4VXEvV3lZS3RU?=
 =?utf-8?B?NzdGbkYwTWFQaHNDRjdWNGdsZnpXVFFtZThHNzVHK2hIRnRRa054d1djUEU2?=
 =?utf-8?B?WWFuVVMvandsaXp3NVRvVWFkYmF5YUMwSGdYVVk4WC9iV1ZKRE1mVDdIWGV1?=
 =?utf-8?B?WWNDZEFHeGxZS2diaG1WYnNkOW1GR2tMVWhLRXA2UVVMWU1NMGk1eUpIT3lL?=
 =?utf-8?B?S0JtZTFVOEYyY2Nvem5DaHNEekJGMTd6QTVJNEgxNklaRHVRdjIrREVySWoy?=
 =?utf-8?B?SkU1ditsSEhsamZ0OVZ6YTVFczRsZGRNUzVnZkhyOTNhV010alE3MjEwNE15?=
 =?utf-8?B?ZzJSbjJET09tclppSTI4a3cyNU5weTVYSHBnTVpRVjBiWVUwU0xROXlSbG9u?=
 =?utf-8?B?MnErcDhSTjlnSFBZelZoNkRYdWgwMFFTMlRKUTNCbE83K1ZLbkxjTG4vdVdn?=
 =?utf-8?B?MnlDMzJVQTdUY2FqOE55RXBMTE5nNHA5bHp4ZjJncFBPTVRVMDc2cENyaFU4?=
 =?utf-8?B?LytIRVplT2p0OVZ3Zlg0ckNlNXhpUUYxM0NTa1phelZHR1IzSHBjd2FJYWtX?=
 =?utf-8?B?K3BCTFRZOXRFa2R2amgrZmRUWWNxYzl3MHE3RjAzWGo4WmY1RGtlbjZBWmNl?=
 =?utf-8?B?TFptM1RsNDB6YXVYZVA1MEtqYStwM2NhSytaTEdMU0dtb20rT1lpdGpzZnJT?=
 =?utf-8?B?eFAranBLNWJTVFgydHdWbTFlNEl3MjVORWk0Nkdwa1hFOG5NMktLRU4zRVlu?=
 =?utf-8?B?Zis4SEtudU5rV1plWTM3eUY4SmdPelM1UDM2WnBrZXE1VUVDaVhYc28zdWpm?=
 =?utf-8?B?Yk8wUHIzSVkxdlM5bFpRR29rNGNOekJVTU9POVNNeER3Q1gxaktuRk9GVzNM?=
 =?utf-8?B?QllqQ0dEWEk5ODM5MWxOK3hoZXR0d2VrN0wvaGZPeEg0RU04dThLdmc1blFW?=
 =?utf-8?B?QnQ1c1BmTURoOVVzNVRETmpRbHhvOUkxL1BrM1JGUklzMU8rUVhadU9Xbmgw?=
 =?utf-8?B?UlIzdkgzbmk4dlQzZVdleXZkaDArUUdHQ0IxbEtScGJHV0U0bXl1bmU1Qnhy?=
 =?utf-8?Q?RTqQg/Rqr/iZl5Ahaq3URSZf+R/nYSiBKmcvwEhXPrY0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DIgwbmI1rL9iRfZDfLqWemmf8qojSyPdTyr20wGS9Fr9d6cfiibTJXjjIGHGL/ReP2ggA0C0JrnrNfvzt67+0bfX0Vx3jnRnDS14VAYiBz2KtQuxj0+zehD5IruHXSEH+V3gi/aU6+ViCqJgN6YErex/el2lmXcD8iYuQk8izcWG4gDaCTC/TT1nzITjc9936LFBmng2KZvvNmUDIcB4HgJDyFKZPa7eDOUKLQg7YZeUplwT5LNE4wUsMg9myln9PA9hAkfw6g66k0biajAlK1Bezbh1FlIaE7zB13BCcdhkVwUszoNar2rpYWOVHQeEQUSssmK9TiHPlwoBQvH+b2ppMQPyzDBA9aN2qW2kt2ohMZqCZzlCgyOhbiLWpF3ge7+UB/LclpIkqrT4vq9KIgrHZIyB7APiXiWJE/bD3qvQ7wARxPEaY6Teiilejzf4l7zPE5rS4qpWUZjvs7AmswI/3n7NSHk7snWKOBf2mUIquGIpbTqyq7QXfOHGHLWhCPfW++X7GIgeHlhFwZPdh7BBX7kxd+pOr2i/JPQNalBVZtNa73YrMW8kJp50+Cjt8Cft/L/dIUoxeeDWlFQYvUnxWBKTxRHpXsBLuh9nNocK9uHz87pcrgxLTQgcpgWwwEG8MhDbpGrTixOBPF+B/w==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c56af937-b019-4e00-6601-08dd3bbbff1f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 14:41:18.3774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IV7DCFB8JCf4EHpObBkydMzMqEj+p+zffxxbKqlwH8BLLuxoPMuODG2NpCPcnwV1pXu7CJmXBXSsnURz+TiCmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB7784
X-BESS-ID: 1737643281-112183-13455-5876-1
X-BESS-VER: 2019.1_20250122.1822
X-BESS-Apparent-Source-IP: 104.47.56.176
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkbmZkZAVgZQ0MjI0Dg50TjRLM
	0i1cAwBchLNTIxtLS0MDO0TEtNTVWqjQUAxvCnEUEAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.262002 [from 
	cloudscan10-201.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 1/23/25 15:28, Miklos Szeredi wrote:
> On Thu, 23 Jan 2025 at 10:21, Luis Henriques <luis@igalia.com> wrote:
>>
>> Hi Joanne,
>>
>> On Wed, Jan 22 2025, Joanne Koong wrote:
>>
>>> Introduce two new sysctls, "default_request_timeout" and
>>> "max_request_timeout". These control how long (in seconds) a server can
>>> take to reply to a request. If the server does not reply by the timeout,
>>> then the connection will be aborted. The upper bound on these sysctl
>>> values is 65535.
>>>
>>> "default_request_timeout" sets the default timeout if no timeout is
>>> specified by the fuse server on mount. 0 (default) indicates no default
>>> timeout should be enforced. If the server did specify a timeout, then
>>> default_request_timeout will be ignored.
>>>
>>> "max_request_timeout" sets the max amount of time the server may take to
>>> reply to a request. 0 (default) indicates no maximum timeout. If
>>> max_request_timeout is set and the fuse server attempts to set a
>>> timeout greater than max_request_timeout, the system will use
>>> max_request_timeout as the timeout. Similarly, if default_request_timeout
>>> is greater than max_request_timeout, the system will use
>>> max_request_timeout as the timeout. If the server does not request a
>>> timeout and default_request_timeout is set to 0 but max_request_timeout
>>> is set, then the timeout will be max_request_timeout.
>>>
>>> Please note that these timeouts are not 100% precise. The request may
>>> take roughly an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond the set max
>>> timeout due to how it's internally implemented.
>>>
>>> $ sysctl -a | grep fuse.default_request_timeout
>>> fs.fuse.default_request_timeout = 0
>>>
>>> $ echo 65536 | sudo tee /proc/sys/fs/fuse/default_request_timeout
>>> tee: /proc/sys/fs/fuse/default_request_timeout: Invalid argument
>>>
>>> $ echo 65535 | sudo tee /proc/sys/fs/fuse/default_request_timeout
>>> 65535
>>>
>>> $ sysctl -a | grep fuse.default_request_timeout
>>> fs.fuse.default_request_timeout = 65535
>>>
>>> $ echo 0 | sudo tee /proc/sys/fs/fuse/default_request_timeout
>>> 0
>>>
>>> $ sysctl -a | grep fuse.default_request_timeout
>>> fs.fuse.default_request_timeout = 0
>>>
>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>> Reviewed-by: Bernd Schubert <bschubert@ddn.com>
>>> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>>> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> Thanks, applied and pushed with some cleanups including Luis's clamp idea.

Hi Miklos,

I don't think the timeouts do work with io-uring yet, I'm not sure
yet if I have time to work on that today or tomorrow (on something
else right now, I can try, but no promises).

How shall we handle it, if I don't manage in time?


Thanks,
Bernd


