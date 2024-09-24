Return-Path: <linux-fsdevel+bounces-29964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB60984288
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 11:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 860F9B26D90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 09:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24FC157468;
	Tue, 24 Sep 2024 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bgHaueFz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A521415382E;
	Tue, 24 Sep 2024 09:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170970; cv=fail; b=n9DKC0F4zsqVvJLDanj5EN7rwGqazmvLR1Jy/FKP3l67ogykj5SgeEJpJ8jgnOLIWD/obEeOah0XVZngg9LlJ7gH+3NcwPo/7GM3yhnJNiWLtQ8tQah68MmEdK2m34+x7m/qoW4C//oH+olqYrEOBvdWytb9c0MEumh5X1Xlrok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170970; c=relaxed/simple;
	bh=7Dtkpw2y234HNpDT43tcOlN1c+WAskhq47atdnXaftE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jls5k2eCi3W0EumCljxcwmYHRBdkcd6OZYGMycy3dAhgPqgxUct6H1Jbph0/JocWAQizDltJN3tq+xB1qz5L/pE7QLy0b4WffOeffOh5SOzX+XE+hOcI7iU1nJMbMzyl4cWR/+0eVxjZ+RC1Q7U+5FqszdX5+SJbU81HIGXR5Ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bgHaueFz; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHJYVyGl94MtH7fXXFpNIAeusoRrPbYJAnw0ockqS1LRxvjUioL6IjcBegh0HgSJ8e7lxkbXb8c12rlhKyqRn2kqPwcC733ntrHG9eX+YBAXuaDbSp4zMIL5/d4Tuf/dKgHS5puuft2AMyMmni4+P77Knm1uQTgDXzV9b3JGEhPx2XfIvWmMH+gcEmwLOsz7Wwn49mN/LgbSjSpOLMjs0WmyoiggokaAPr5kNyNrCcTeK3UuC4MozNcOJArfkm7y7HzYTp05zAykSZKNTfAjpSkYDL5ChdM0VdzNXd9mQryhtCZA7aBHKlOBPPm6vZ3pjmhOx/LVoUXLt8HGhPvLnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIhx+tCIweHIwenZz3pgq/1JFi7SpcX6JvdeNAklWEE=;
 b=bV6j+yO02kAZyrjyPnNFAVIVW5dw+VeMWQ8edHf3p/lygcTnz8Q+qcGwJrx7QWPhHIocK3ZHotZf8SdLgYW3XznY9Dthl6RXmZGNBd5a6R5g68NTpxmfkzeZcm4EfVYSRaYlqnWS+GgJv1zncfLnHRTpcTjwDLWl7PR08x3X5v58NK8hxSCgOjAijnHdmqePo658/ETnigNODY+K9AgXltdyjoiN7yr6aWECoCTCsdek/wcEoB6Y91zTiLjACRsc9NYQCVQ0otci2oJXki8waXKlMJCwMcBdQHjvZi3raqJuugtxzC+3zNgtJW2r1lbAI6oWHeZYtJVseHDN9fHkcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIhx+tCIweHIwenZz3pgq/1JFi7SpcX6JvdeNAklWEE=;
 b=bgHaueFzolh0nFBQYQFTXPhAUmYYdrOANcxgvJ19KvP572O1N6iMsRSZKYa9nBRBx2EEUa09YdiW7b+cV1NoWLneO91sPJIs4Rl9cQcumwMIeF9KLQirvOtUVFyA3TmLSFsJt7Y0LjYpwtwFBVApy5r3lPZzOz6itksSUyBoyzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by PH7PR12MB7355.namprd12.prod.outlook.com (2603:10b6:510:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 09:42:45 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 09:42:45 +0000
Message-ID: <47476c27-897c-4487-bcd2-7ef6ec089dd1@amd.com>
Date: Tue, 24 Sep 2024 15:12:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V2 1/3] KVM: guest_memfd: Extend creation API to
 support NUMA mempolicy
To: Chao Gao <chao.gao@intel.com>
Cc: pbonzini@redhat.com, corbet@lwn.net, akpm@linux-foundation.org,
 willy@infradead.org, acme@redhat.com, namhyung@kernel.org,
 mpe@ellerman.id.au, isaku.yamahata@intel.com, joel@jms.id.au,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, bharata@amd.com, nikunj@amd.com,
 Sean Christopherson <seanjc@google.com>
References: <20240919094438.10987-1-shivankg@amd.com>
 <20240919094438.10987-2-shivankg@amd.com> <ZvEga7srKhympQBt@intel.com>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <ZvEga7srKhympQBt@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0142.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::27) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|PH7PR12MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f7cb08-9275-40f0-6414-08dcdc7d3dc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2liTThHc0dPUEZPZUNvcVNMYVNyM0tGREo5d1ZrTkxBVkhpV3lrU3M5cWRn?=
 =?utf-8?B?Tm44RnE0YjMwbTMvZ2F6b2ZodGN3bnEzYkszc05lU2tDOWdWWUlHSW5ucElL?=
 =?utf-8?B?K084Q2VsNzVMK0hGcUtURGVFZ0M2MWwxSjdHdW4xWS80bitYczczcG0xNHZn?=
 =?utf-8?B?dHUwcy95eTd2M1g2emExaUZNVmJ4bXh2QkIya3JGNHUxa0s4WW5xVjZtdVZH?=
 =?utf-8?B?WklPL1BXbE56a3pGOXJQaXlRYitRV2dIM1g5N085Y2psZ1NyS1g1czFqcDR1?=
 =?utf-8?B?aHJVeHZWSEU0UWtCazlMSEpPeHE1YXNZZnNQVFdka2FndGpxZ0xpV21nRmVN?=
 =?utf-8?B?eHFTNFArMW9teHQvbTlwcFU3VzZ2NjQrR1V0c2lvc1RHeDlPWUduQ01rVmVN?=
 =?utf-8?B?bVlUeTJlai9iWkp2SHR0Q1dERXFGZSt1cmZWM0FEYjFoaWlGN2ZVWUFQVHFh?=
 =?utf-8?B?dFN6VkFOc0tMQkQya1EwLzNLbFNnODdvd1drZnlPSmVxUE9hZU5xOWl6a2hs?=
 =?utf-8?B?ZnpIeXYyZ1lNNUVZOWYzVUhBZ04wbVYyc2R1K3FONVFBcDVhalF6WmJreklH?=
 =?utf-8?B?d1hNbGlFckVqRkM1dVFyWk1kNGVSbGJ3ZmpMTGVLT2c4dXlraVIxYTVBYXJk?=
 =?utf-8?B?Ykc0SlJoV2RPVnFHeUY5bno4SXg5ZzRsckFwT1VMS3RKM29mQUJVUUxNWVNy?=
 =?utf-8?B?R3FlZGhBNzVXd2dkZGVHVWVUMTNULzRrcFFwbml1YXU2ZUJ4TFF4alk2OGYr?=
 =?utf-8?B?T3laVXJjR3F0dmZnNHVlckZ1Q3ovckUwWDZOaDZWbzcvaWxjMVZhdG5pdC9D?=
 =?utf-8?B?ZEZSQVJJbGxOcHhIbi9iN0ZxRm5rbjRyc2NuaDdqR0JPbmIzUCtGNEtFQmE5?=
 =?utf-8?B?TmFjT21xUjNESGhFL2lGVzhzL2dJdXNqTEdrOFplQXFvMHZYNWVjc2dKR2Vu?=
 =?utf-8?B?SURCTURrdmxHVWlRUytCaGpkSUJuaGF6cnJxOWh1WU5SU21HbDFNWGcvYUxp?=
 =?utf-8?B?VDlMZFVndFl0d1lpY2tiUlJZTTRuekh6dUN4eEE4SVNVL0NLSjludGFNKzFs?=
 =?utf-8?B?RkRzalBYZVdwNloyaFQxMkpWb3ROMVJ0dVorN1U3VnIvemk3NVNOTjZkMDdp?=
 =?utf-8?B?ZFZEYmhtZS9MOHdHOU5aUmdtNysyV2w2QXRtUTZDWFk1dTFwbDFuMDVudW1s?=
 =?utf-8?B?aXVLM0gwbW9qeWl2S1o5SGM0MTNCdUNYdlJlVWdHaWJHeTdXVTZEcmZXemcv?=
 =?utf-8?B?YmJjdk5lcWN5ZnJUb21peUNVbnVHYzBtaWZIZTBWa0Npa1krM0IzVDUyY0Nt?=
 =?utf-8?B?eTJlc3FjalgwSjdFZ2FTRkErblZ3VklnYjlvVVhBdGJsMDNmMlozaXBCTnR1?=
 =?utf-8?B?TWgvdDNObEN1aDdQL3dZVkRLTkdFcVRmU3lLZXk4NnVRQWMvc3ZKQzNLZXFI?=
 =?utf-8?B?SjhJdFl4cWhaTHhQVnJQbWptK3UzcUF5WmowbWROL24rTEFuOC9ORCtMMTlz?=
 =?utf-8?B?cXJrMGtQeFNHOXd6SXdRQXV3aldYblQ2TUxuRU1FMitNSktTQVc3ZWtFVUxV?=
 =?utf-8?B?cThUam9aR09mWm5TamFGOVdiNTZXd0tmdVQ2ZGhxYzhOd0RJOHBvdTJVb0xs?=
 =?utf-8?B?VlRXV2dod09nSFdVY05sVkJ0a2RVSld4UFpSVHpHeXpoNEFSQ21DWDhGLzZ2?=
 =?utf-8?B?WFZyYUdjYU9MdGNBS1BBZG4wNFVwUEhBWEVtTTBuNzkybDdFMnNvZTF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTd5TTVSRHNTd0FwV3pSdGk4TGduNXpITTdJeGZPVVZFRGlMdTBOK1R5b2dZ?=
 =?utf-8?B?c3gzcXEvWExvdzZQYnNPUlpWR2F5STl4dVFJWG5rSXMxd1JNNEwweUR2T3o2?=
 =?utf-8?B?YnFPaUVOd1YrQS9FRExYb0dTdkJ3S0JqQStnVlBLZjB0d2lxcDVOMlgwbEMy?=
 =?utf-8?B?MGpDYTBmVHJ1QU83TDYrZVhzd0RKUmRIcG5RN2NLbExERDN6ZnVwcFliT1JJ?=
 =?utf-8?B?L2N3eTVWZHdRdHFtN2dlQ2dVSHA3WVNnMGNFNXNqdC85bnpzOHJod01sSmlZ?=
 =?utf-8?B?UHl2d0R3SEZHN09IMFZ1Vzlicm1DMTdITUV4YWF5YXJLRzJVRWluSS9IeEZD?=
 =?utf-8?B?T2JMemdMaUNPMFVia2hycmlpUGNYZU5lbVBab2d0YUdaT2I3TXZ1QklSbkll?=
 =?utf-8?B?d0ZvVEtrV3I3TGhLWU40UytJZUwya2NoV2M1MGhaMFcyZ1cxY0hVV3RtSXRK?=
 =?utf-8?B?Y1Q3ZVVObkNsQ1M0R3VnOGpnMFI3QjhxUFFjMCtrNytNcGUwVWxTQU0yaXFV?=
 =?utf-8?B?R3BoV1MxYlozZzhGV2JIcE40OFAySm9pZktJRzh1Y1lqQ0pFWnhEazRGWTNx?=
 =?utf-8?B?QzhpY2JPNUtPT2VmcVVURlczTG5rNW52MUxDODIzWFZES3JXc05pamRjMFRl?=
 =?utf-8?B?V1hGNk43OXNHSzV6SXRubkg5ckVqekVyNmMrOFhrYXQ2SVFneFBmWXJvZDVw?=
 =?utf-8?B?QVd6c3lzZ1JZayt1c1dUMHo1WXpWOFlJaFBLRUFaM2tuZnFsTEVaNHFiU0VO?=
 =?utf-8?B?RDUwSTJ1VDJaeXBxTVJIWFhHZDBiUG8wb1o4aTM0VVRKSkxCSEIrNDFwM21I?=
 =?utf-8?B?REVrZnF1c3dyNVpnbmVrZ2JjRlF1ZXZXbEZyZGtJSnhiZTRnZjNIR3h1VFZE?=
 =?utf-8?B?Nit1VzNWN3BpTzhabzdQdzNZTmtPQnJVSEQwTGY3MkNSKzdDVGlDMzZhbnE4?=
 =?utf-8?B?a2JsOTBud3BUNWVldlU2WG5vb2N0TFBwT3F0b3NaVmNzemIrNlg0MU9iRHRt?=
 =?utf-8?B?ZjN5R29SNmFYb0ZqSGdPMEF6TnY2enk3ZE1jb2toTGhnUys3MjFkUWJoSG4z?=
 =?utf-8?B?N0pUMnM2Rjd1WmxidUIxTEk3TGtZQ0xnUzZhQnliUWRpelhadUF2U0hRK0xt?=
 =?utf-8?B?TU13R1RyL3Nuc2xSUTlBdVUvSWV3bnlPc0kvbkVaa3FrMFB2QVNjMlNERi9k?=
 =?utf-8?B?S0ZHME9TRDNhL2NlQmtqUlZvUVB1QTE1QUY2NFlNUUJ0aUo5N2Evc05ZcE11?=
 =?utf-8?B?dCtXbXFJSFJ4UHBTV2FLMFUwMHU1VXVTRkRHeURPSjV2d094bXFlWW0vd1pT?=
 =?utf-8?B?VFdSRFBtK0tmVUxLbWxJblFmQytGRnUwWk44YllBcGh4T1R5TDBNTytSN3Rw?=
 =?utf-8?B?WU50ZTV0MUM0SWRpS0FUWDZGNTJ0VDdCbzVwM2taZHIyME1kU052eGVuT1pv?=
 =?utf-8?B?Y3h6S3QxWUFka3pvdkRjUWYyMXRHbWVZcHJqdEZUV1pXb2o0dTVEU3QrSWpa?=
 =?utf-8?B?cmJtRnpoY0NHUWMvNmZucEFMSm81ZDVjKzBsb3dYY3RhbXFTYUkxYXp2L0Nn?=
 =?utf-8?B?YWlEanRQbDJQOGdPN0ZXMk03QVdWZDdrV2tKb0lFM2JNKzdqOVdFNU45MWlT?=
 =?utf-8?B?aWxocmZVVzg5UCtXZmpzS2Ivbk9hQmp2YllvNW1ubkVUdy9QZEN5Uk40UzRO?=
 =?utf-8?B?bC9RblEreDdlTjVWOE0vd3B1bVZvb0MyYXNRN1dTenFQQmxxZVZwOXNVc3F3?=
 =?utf-8?B?Ty9WOHp0QXhpa2hGSC9QRU1JT3E1Tk1oTHNldUV6V0xMcWlFR0dMYVVEdFF5?=
 =?utf-8?B?UFlxUzlBbDlFTTYvMTR4SkNLMWxwUlk0ZDZLbjZrSkJTK1dYdXV4ODE5Qkx1?=
 =?utf-8?B?d0paS3ZuejI3L1I1S2liWERjYjNCVXJONFBRSGFHZGtMbFd6RWNMOUU2eG04?=
 =?utf-8?B?alBlZWhXRUp1K284UmpVbkEwQldIVWx2SjhwR1p4K082allUemtqd2JGYkxl?=
 =?utf-8?B?K0gzOW5XbkZnS0lCSnZDQklEcXhsK1ZpeDRGOWloR1RiMXgyWm81dDN4Tjhr?=
 =?utf-8?B?WEVCMzN4ekN0aDZ1SWxDcWR5MW9JZXpOYjk0VEVOQlE5cFBMTzhLb29wMUNi?=
 =?utf-8?Q?tyoU1RerqhPeKQTWhWiGPTLtI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f7cb08-9275-40f0-6414-08dcdc7d3dc9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 09:42:45.4634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KtIFjMZdh7t4dCK7FS6upsnpxDBGOf3osLcS9nYgw5AJEbig15Yu0vXJmgC30vbI+jtkCyj4CamnFzOsw6V9fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7355



On 9/23/2024 1:31 PM, Chao Gao wrote:
> On Thu, Sep 19, 2024 at 09:44:36AM +0000, Shivank Garg wrote:

> 
> Do you need a way for the userspace to enumerate supported flags?
> 

If the flag is not supported, the VMM will get a -EINVAL during memfd creation.

> The direction was to implement a fbind() syscall [1]. I am not sure if it has
> changed. What are the benefits of this proposal compared to the fbind() syscall?
> 
> I believe one limitation of this proposal is that the policy must be set during
> the creation of the guest-memfd. i.e., the policy cannot be changed at runtime.
> is it a practical problem?
> 
> [1]: https://lore.kernel.org/kvm/ZOjpIL0SFH+E3Dj4@google.com/
> 
As the folio allocation happen via guest_memfd, this was an interesting idea for us
to implement. And the mempolicy can be contained in guest_memfd.

For changing policy at runtime, IOCTL KVM_GUEST_MEMFD_BIND can be proposed. However,
I don't seem to find the support on KVM/QEMU for changing the memory binding at runtime.

The fbind approach may pose a challenge for storing the mempolicy. Using "private" data
fields of struct file or struct inode, can conflict with other user of those structures.
And some way to inform (a new flag perhaps) the subsystem about private data is required for
fbind purpose.

Thanks,
Shivank 

