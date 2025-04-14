Return-Path: <linux-fsdevel+bounces-46396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED973A88700
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 17:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124FB190428E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 15:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6E124728A;
	Mon, 14 Apr 2025 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="N32zfG6j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25CC4438B
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643218; cv=fail; b=E5mU+g0MZpQ3jenHHY/Ns+Ky06SXmIxAvoSDQhiT7f5qYSUayRXplOtDORCPvhwcSPdNeMqHcyD6prWl9+MkRDDY/jebAIw6o6r7BcU8CD9+s1Wqp3zWb+CSVy8FS0Li33HDQUl2f/VydjTSlMlN6f66KN1l7OSz4W7Y9R+SOW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643218; c=relaxed/simple;
	bh=nhXh6Ztf+AwIhTfhiywZTzB73L6x3+TwIwN666Ul2FM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r34pzgjAfmf12Niw+OMrMWcOtW5PfwIK26l5sPuGEUf1CH8MAfVgTDLVbWbh7INEVI6QOv80RXbWVGr/vc3+9gF2ay/HVEitRDAnHxy2XZkPxAKZouVkemJcijRfXXbtM/p0to+oQMs/EQwlj0NBuwb2T3yxGXOva1wT/v9Vyec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=N32zfG6j; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2043.outbound.protection.outlook.com [104.47.57.43]) by mx-outbound21-234.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 14 Apr 2025 15:06:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRh9RP9P7Cg57W6gAeu+58WDJfPeeyVb5iCtHcdlwc4fSDf91fmBZOrZ45qFRyDq+TnHIatnp+dOamZv7afeZ+KkBai0gbLvZIsK+f5M4ofByYGz5/UjJ0AhOdszRv4uIh8/iweS1DR0mEi2zkLZIkzBdDb/c8lF73FPuoBRjGx6zymHyj00gKBI6ObzsdHs7CuwCSwyhttrkwZBMAFUrqOxkEvQWKUlJvUo5suuHvZ0JA3TwnSPB/U5erPO5lGC6fO8HxSLu86C/DkCUEmqz2kZE0diBXwTu+j9MytcKBVxEJpoA1X2H+nEAfiFQTvpu4BvpX9hEeoSLj1O4Qrh9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhXh6Ztf+AwIhTfhiywZTzB73L6x3+TwIwN666Ul2FM=;
 b=hPM6gs0foyukvJRK8Mm7WguoY4hhtwYSUbu5c1oK1eyDKANt4zRZy82zPzN0RvXof3ugXecsOc7V9fwElGoE6V0sCKfNhGgvhtElQxNwCeCJWyTf7XN2x+isylJ/cUptG4vPWmtg4tFNdlCzK6m4VTzGB0BgY4TNvjO8+RELYKKSizXoW57JK42VGVbH6WNy+8Z/fNwKvkOqdWeW3wWzgF1Y67zwqoyPdK8Xy1zBxW3wuj/N/V2qude6bnYUTjiqzQeixbMRDyZW0xxEoEu7RsnAqdMSTAyGqUMN2tzMB8IPU/ORyMC0uFNfANsWe7cvXhF26SotIYb5c6Aeqy+B/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhXh6Ztf+AwIhTfhiywZTzB73L6x3+TwIwN666Ul2FM=;
 b=N32zfG6jMiDxI1h8OTFwQWJa1z7yplYvsNvlybBGqoZiSVST6HjdkWenCI1LL+fvbQTROW6+W6bu/vvLGnokpxcig/nXLrb/LokGoYyRi7B/m8GIwynv7jXAj22ylJgbECCyPSrCTBgMGv5ryk2utkjlbRuaddAh/HoOM5CXO5Y=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by SJ1PR19MB6380.namprd19.prod.outlook.com (2603:10b6:a03:455::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 14:32:52 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%4]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 14:32:52 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Guang Yuan Wu <gwu@ddn.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
CC: "mszeredi@redhat.com" <mszeredi@redhat.com>
Subject: Re: [PATCH] fs/fuse: fix race between concurrent setattr from
 multiple nodes
Thread-Topic: [PATCH] fs/fuse: fix race between concurrent setattr from
 multiple nodes
Thread-Index: AQHbqVp0M67N/vLLOUi6vmMAtVcZE7Ob5/IAgACafqOABr8OgA==
Date: Mon, 14 Apr 2025 14:32:52 +0000
Message-ID: <8b6ab13d-701e-4690-a8b6-8f671f7ea57a@ddn.com>
References:
 <BN6PR19MB3187A23CBCF47675F539ADB6BEB42@BN6PR19MB3187.namprd19.prod.outlook.com>
 <91d848c6-ea64-4698-86bd-51935b68f31b@ddn.com>
 <BN6PR19MB31876925E7BC6D34E7AAD338BEB72@BN6PR19MB3187.namprd19.prod.outlook.com>
In-Reply-To:
 <BN6PR19MB31876925E7BC6D34E7AAD338BEB72@BN6PR19MB3187.namprd19.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|SJ1PR19MB6380:EE_
x-ms-office365-filtering-correlation-id: 984513ad-d5b4-467e-8f16-08dd7b613d1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RTFreDkzcmVnY0c1Yk1VUjg4NTFZZURjLzZIa2FnRHczNTE2aW03NFBiMWYv?=
 =?utf-8?B?MlpkTDZlY3V2dmpDMUZYOHB5a3NYNEhMK2tmNlFWbW5vUnc4L2x3N0JNd2R1?=
 =?utf-8?B?a1JPV2o3ZzBCY0ZBNEFIbTNuYmI3OTBnMVZCOHR5WU5Qa3JOSWxHaDdmK01Q?=
 =?utf-8?B?ZTlPVmNWeVZYVU9yRjQzWHl4MnFjZDRBWlpIT0xuTkN6bVkvOVJ2K1lFc3lu?=
 =?utf-8?B?bko5VnptaFpJZ0NjaU1aYVNQVTkyMEJpdnBOR2xJWUI0NVQyalVXSG1IcUJo?=
 =?utf-8?B?QWtQL3BmOWEzNVRibWZHRmV2TVhoVVFnVlRtRnRzNS8wazdCRlozS1plZkY2?=
 =?utf-8?B?VDhMUXZYZ2FEb1NWSkVTam4xYTlHV2t4c1lCdktIc1A4WGd4TmcwTUVndFIv?=
 =?utf-8?B?WmJDSC9BeXNPL05YZVFlZ1A0Ny8xdXlVMW9xd0ZzTWlMLytkbFJhdk9zOEUy?=
 =?utf-8?B?ak1RekNHcThPSS8xSWwxeUtUVkVVY1EwTXAvSjVQMWcyVXVjZEQ5M0s4UHBR?=
 =?utf-8?B?Wlhac0wyK3J0MGdlb0FlTmZhenNBc1E3WWhtcFgyQklzVllaKzZ6OGhzaU85?=
 =?utf-8?B?STFXeCtlRDhRUm10OUFSWG8zaXZoalo1OExxcTVIbVFaZXdLc2pBTUJ6cnh0?=
 =?utf-8?B?Y0lBZVhBS1k2K3Q2UmRmMkc4bnpOcEI3ZVFSL2JOdHY1M2RVcERUaTJnSThX?=
 =?utf-8?B?U1hUaWxCYVRHR3hKdUNqbVNoOUQ5Y01UbERZWHpjSXo1VEcwL1Z6TjJ4ekdO?=
 =?utf-8?B?VXBtamNXYWJLSnlkOC9WRmFpQklnNnRpRTR6RXhBYXZ4emFOY1kzZ3RoM3Yy?=
 =?utf-8?B?ZkNZWDJCUXZKS3JkeVAyZGlOakVwbW91Rk1VVHp6ZmdxU1N3cjUwbVVTOVRt?=
 =?utf-8?B?SVhYdHBOM1FDZUdhc3AvN0RzdXBsV0ZNSG5lQjZQdTV1NHFzdXpVNVFmclJH?=
 =?utf-8?B?VllkRWxUU1N6VjlnTk8walZBMkpINUR3ZEtmYnRlL0ttYWN5UWVlVk9qMm1X?=
 =?utf-8?B?RHJIR0NtTm0vMUh0R2w5SURncUxSOStSMG43eVdiUk4zbkJPaFk2eGRXRUs3?=
 =?utf-8?B?TU1pZjZ4SVVrZGpnSGNwZ01zUTArc0RETE5KMzh3a2ZSYVNMeVo0OTg0WDAx?=
 =?utf-8?B?dDJYOUQ1ekFiSUZFVnNXdmVHTGx2YUdnb1liRFFQTGRTa1NrWEt2RmNtS3NG?=
 =?utf-8?B?WFZiOXZ4bkZvWGNOWVQ0ejMzOEZCWmJEVzgrOXVhWjBCUW5RV0xsVndaT1U1?=
 =?utf-8?B?R3puZHpLU3RWSmNjVys3YUhwRWZibEFlcFVkZEN0UG5rUWJNMGJYK2ExUmJ1?=
 =?utf-8?B?c3V0Wk9hbFRucDN2SWpqanJpamRVcFBFaWZ6SUxYYzVYcnY1R1o2TEpxYlpN?=
 =?utf-8?B?T0hpQThsYW9PVVM5alpBbmhFZ1VZUW1ibUlweVdJTXJSeGpsbmN2R0d2STFt?=
 =?utf-8?B?UmkvRm9LWDF0Q1VsUjNyaUhmay9pMFNRU1UwS01FWFVFblloN0JMaW1NdWZR?=
 =?utf-8?B?dGhuWkdXcmRxdWFQZElOeUFXT3kvZ2xxbEJrM00vRW0wYU0rSTJLdXNqNjRW?=
 =?utf-8?B?QVREYTRPVmxzMHdCTEg4dGlVbHQwWjczYmVGTnJMUWphWWxQcnVOczRGbVo3?=
 =?utf-8?B?YVZJb0pxM2Z6MzNhbHJOM2lINUlkaVBxdkVhNUNnazF4ejh6UFY3ZnVWR0dn?=
 =?utf-8?B?ZEJ2VWh1SDMvTUVXaERhMllyTVZqaWJ4TkxUVjhLZXYySno1T2FBTE9lQmVW?=
 =?utf-8?B?SlFBTlo0VkJCclA2L2FrdU53R1d5VEdrdkRJRHlhY0tZdjNTQ2RlazFjbExI?=
 =?utf-8?B?b0Q0TENOenBiZ2F5VnBhR1FyWGdaMzBFd0YwbmhzQ2l2bjM2ZFJlUHlGWXQ1?=
 =?utf-8?B?a2xNU3F2YlFDU2tQcXAwZTRKVFFpRzNiOFFTb3MyZlhBZ3kzREVoZ1FVVU5j?=
 =?utf-8?B?TE5zT3NRYk1WcC81djdJTEZrcnZ6WE5NaUhlRFozSVhZYnhhejE4V0JiQkRK?=
 =?utf-8?B?Q3VybGsrWXRnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NzBaSTlQY1BHamg2TnhoRW1Rc2FwcVNXNWdoSmtzcDhwaEc1dlRIUVVXVjhY?=
 =?utf-8?B?K2JMZy9qMWdxNjE0TS9CbllsUnU3TmJHRTdUUFAwY1BRUXZHTlBMLy9PYm10?=
 =?utf-8?B?VWF1QmtmYy9XM0ZzTlJ0SFdTZSt1Q1VvazRERCtZRzdGby9HK09ZTGIxTThV?=
 =?utf-8?B?VXhJejh0QkljWEVSSWErbmprVEhNc1IwLzM0WjAvMUxkMHRXMnFmbUcwakVr?=
 =?utf-8?B?eEhZMnB4c2JMOGMycGRuc2RqNnpaL2FPMSs4Y0pDMktNMlN1dVRaTlRQWDIv?=
 =?utf-8?B?WWw0QVBHcnpPT2dxN29LRnF2WjR6STlRUTY0aDBKVXp2dk5wYWRkbWd5T1po?=
 =?utf-8?B?SXhXeFd2SE5PcERkRkRIMjhGVWhsOFh6R2FpUk9hQk9SN3pkQ2NIMEVXd0ZT?=
 =?utf-8?B?ZmlPOGtzV00yWjI1QVNiWmpSU28wRHB2V1lCNmFxcUhnNHlKa1Z3OWNmQ2p5?=
 =?utf-8?B?Sld4MEp0R1dmM1NMOU9tU1RJY0VFMFBQc2Z4bEhvREdzTDJDZ0tlbWdDUFQr?=
 =?utf-8?B?MWl4bmlmU2lHaXpZbjlnMzYrZnBYajhRN0RmcHRjZDZYWGlkTXBRL0lMMnlk?=
 =?utf-8?B?KzBrTlp0ME5BanR0ZEJSUnR3NjlrOFN0MUVmYmhvVTBLRXo5WTQwaFAxcEJM?=
 =?utf-8?B?ajJaQUFHWU43QWxobGhHb0NTS1FhY0w4RjJjeWRDVzFWUHhOOEprUWh4N0ZE?=
 =?utf-8?B?UEsrOVl4djJqL21VRmRqcGJuSStzU0x5MWpwRGtYVjFCUFdjTktZVERIQ2lt?=
 =?utf-8?B?Q1RaSjdxNnJNN1lKaVVnMlpJdjFaZVgwMnY3L1g3a0p2Uk8rYXkwdmRVWG5G?=
 =?utf-8?B?REtPM0dOK3dvRVJPT3J2TS9SbkY3S3g3b0FOQ0NlVkdrWmVqenU2b2V3aXVD?=
 =?utf-8?B?MnU3UG9kS3RIdUhiU0RwOVBVc2JLSjI5U3h5bnRxZHN3T01DSlZVTStWdlpV?=
 =?utf-8?B?NjJxUHFvYk50L0dmbUJOdjdpTDZkWGprMUpSckpHMEZ4T1YwSjRObW5FUW51?=
 =?utf-8?B?R01vc1Z6S1gvWnNuaU5FRXpleDVaajgvQVI3eEQ5TGcwdXVGeDBQUzFNUUor?=
 =?utf-8?B?a1Q3OTA5OElGc3FnQy9wcGYvaDVqaTNZelFwQ0tFQThMUXd0dkRReXpqZUlq?=
 =?utf-8?B?UFVnMWFxcTBnR3p3YzJQQ0JmRTN3YkdZV0xKQUVYSlIwNjRZUVRaNGovdHBM?=
 =?utf-8?B?QityejV2dkhadkN6YmIwYXBScW1EVjlZYml2Sjh3eDcxU0c3ZWFWUmNPcjBK?=
 =?utf-8?B?T1M0SW94cTVQaEozZHIwcHVMMEJlakRvaU9sdExGenhSZjRIaUMwbVdPVlpY?=
 =?utf-8?B?TDFISitFYm02ai8zbHVDdXBnbGFlUTh2L2J1YVFCVW8wb1RsYlQrVHRrRUk2?=
 =?utf-8?B?OHhiY3JyYlBmRWV4Qnp4R0taOTNkTUR1UXlMZnVzM0ZuQ0dwd2l2c1JTNVRn?=
 =?utf-8?B?K0I3dWk1MHEwaWpMNnpLMnk5ci8vOEUvSzljSDExMnRDNjk2R3gzbEdMYm4r?=
 =?utf-8?B?N24xOS85VG9IVUdZb0ZhYldsNXRJWWFubTBrS1hUSlEva2Z1dlhRRzFIREwr?=
 =?utf-8?B?bEpKNXE3UnR2TEVLVWNueitsOHBadXUyMkYvT1l5SHFKNDdFem9EVjBVaktD?=
 =?utf-8?B?VVFwemJSZ2JHSEU2M2pXdHFITHllenVUUnM3MUpKQk1GcFlKS1JudTJFUnJM?=
 =?utf-8?B?RDczRHp1Nm1wSHAvUjNvQm1aVy92U0ZKOEVzeFRsSnRZelZJRWNzYTkvcGlS?=
 =?utf-8?B?UWdkWXlmNWdDa3k0eW82YmR1S2I1cThYQWJIQzRZd2EwUjlhWU9zenN3ODRV?=
 =?utf-8?B?OHdpNm5vVnNYcHpVbk96aWRKTnRyaWZPOUNMZDhpSFFac2ZCZksybTdHNzFq?=
 =?utf-8?B?WUNibzJIMzVUeEVyUy9oS3d4V1E4NytwN25ORGZlOUgrYjVzSi95TFhYMnVa?=
 =?utf-8?B?OTA4Mkd1YXFvcjAxNE5PK2JBaHZmV0FjL2liS2xIZFhtdGxLNDFySXJkWDcy?=
 =?utf-8?B?R0M1ZGpLMGluZGg0a2UvS3cxU0NLV0ttVFN1WjI0Zzh5b1ZVS3EvN2laTFVU?=
 =?utf-8?B?NVZ3RW03YmhOUmRkMlB1ZTdhVXNtQ1NvMldzcXA3SUhNRjVUMkFMSGFseTJ3?=
 =?utf-8?B?WER6R09QbnZRcmJkZ0wrK2Y4SmZVTXVrWWd2WG9lOVUrKzVGVmtuLzlweTBp?=
 =?utf-8?Q?Ole7f+n6EYIg1qq7+iBKgZo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87F4E4C87821784DA663547038B6BD7B@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JZuq1G6TOfF+5jGxO5cLAVSLJ8ER4IxdnWW7T/fflTrojFVUBv7mjrHiuoYsveY8ezPN+ZjHDt+kXGW329c+XSc/SobvszaPUji2wkcvo8S/33DBcykNzVXb/VBGvgVyKmgqsI0SHXlzAmm3QXbwtAjabl5nF9CHQHKNo0z5sB14pB0WconxnU2Qr3CuiScR/1lBp0mrurCcOLFjl6hpqiUlb2jnBlqdc7BM1NM3VtazNx4KqfclGgiHHmWCUYhtT7NwgHluAySD5tiwREaPSCPU462mncCO8vxUGC/gd4w+xkx3OObE7TP8SVBhkzl4w/FdePXoquqlEPUAkNuhuTHqA7rB+IQesn9w0a5jGH4/ZykksSt5pQQRu7Vpkh/3f6NYcxA0wVWMD68TP8Qv/JrrMuNFkpWw9WUHUEtyNj314HIU+4v6zE/UenywKzrtY47sdU+3HzvNx2Rqh1TAfoTumt1w1hdpkwncuDCsQtPyg7JNsyPnSSsgm+23m3FvHq8s650bkUFxdHrq14x2qI540k42pa0qIyA/V2CqBrZvrTKKpsOsLLFzJ/f+gAzHZ1NUaWkOHEIJ9PlTD1OH+nIj9CjAndU/4rtQ6rknlD9AB3uM9mK/SNzvmhD1l3B3dgC5EQgO/LHILtRKgWd+kw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 984513ad-d5b4-467e-8f16-08dd7b613d1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 14:32:52.3706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ePfhqYOmc4Ok+8C+BK/nkuuo64ZteaT1hobWceRoQcfZadMsSKtvaYW3qwGv0ZOFfzqN72/Urg3QDG6USnfHbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR19MB6380
X-OriginatorOrg: ddn.com
X-BESS-ID: 1744643207-105610-8835-7731-1
X-BESS-VER: 2019.1_20250408.2322
X-BESS-Apparent-Source-IP: 104.47.57.43
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqamlmZAVgZQ0CAtNSnZwtjM3N
	jY1NLYIC3FwjDF0jjJNM3AzNLAwtJEqTYWAEcrQHlBAAAA
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.263884 [from 
	cloudscan19-60.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA_TO_FROM_DOMAIN_MATCH, BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gNC8xMC8yNSAxMDoyMSwgR3VhbmcgWXVhbiBXdSB3cm90ZToNCj4gDQo+IFJlZ2FyZHMNCj4g
R3VhbmcgWXVhbiBXdQ0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXw0KPiBGcm9tOiBCZXJuZCBTY2h1YmVydA0KPiBTZW50OiBUaHVyc2RheSwgQXByaWwgMTAs
IDIwMjUgNjoxOCBBTQ0KPiBUbzogR3VhbmcgWXVhbiBXdTsgbGludXgtZnNkZXZlbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gQ2M6IG1zemVyZWRpQHJlZGhhdC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRD
SF0gZnMvZnVzZTogZml4IHJhY2UgYmV0d2VlbiBjb25jdXJyZW50IHNldGF0dHIgZnJvbSBtdWx0
aXBsZSBub2Rlcw0KPiANCj4gDQo+IE9uIDQvOS8yNSAxNjoyNSwgR3VhbmcgWXVhbiBXdSB3cm90
ZToNCj4+IMKgZnVzZTogZml4IHJhY2UgYmV0d2VlbiBjb25jdXJyZW50IHNldGF0dHJzIGZyb20g
bXVsdGlwbGUgbm9kZXMNCj4+DQo+PiDCoCDCoCBXaGVuIG1vdW50aW5nIGEgdXNlci1zcGFjZSBm
aWxlc3lzdGVtIG9uIG11bHRpcGxlIGNsaWVudHMsIGFmdGVyDQo+PiDCoCDCoCBjb25jdXJyZW50
IC0+c2V0YXR0cigpIGNhbGxzIGZyb20gZGlmZmVyZW50IG5vZGUsIHN0YWxlIGlub2RlIGF0dHJp
YnV0ZXMNCj4+IMKgIMKgIG1heSBiZSBjYWNoZWQgaW4gc29tZSBub2RlLg0KPj4NCj4+IMKgIMKg
IFRoaXMgaXMgY2F1c2VkIGJ5IGZ1c2Vfc2V0YXR0cigpIHJhY2luZyB3aXRoIGZ1c2VfcmV2ZXJz
ZV9pbnZhbF9pbm9kZSgpLg0KPj4NCj4+IMKgIMKgIFdoZW4gZmlsZXN5c3RlbSBzZXJ2ZXIgcmVj
ZWl2ZXMgc2V0YXR0ciByZXF1ZXN0LCB0aGUgY2xpZW50IG5vZGUgd2l0aA0KPj4gwqAgwqAgdmFs
aWQgaWF0dHIgY2FjaGVkIHdpbGwgYmUgcmVxdWlyZWQgdG8gdXBkYXRlIHRoZSBmdXNlX2lub2Rl
J3MgYXR0cl92ZXJzaW9uDQo+PiDCoCDCoCBhbmQgaW52YWxpZGF0ZSB0aGUgY2FjaGUgYnkgZnVz
ZV9yZXZlcnNlX2ludmFsX2lub2RlKCksIGFuZCBhdCB0aGUgbmV4dA0KPj4gwqAgwqAgY2FsbCB0
byAtPmdldGF0dHIoKSB0aGV5IHdpbGwgYmUgZmV0Y2hlZCBmcm9tIHVzZXItc3BhY2UuDQo+Pg0K
Pj4gwqAgwqAgVGhlIHJhY2Ugc2NlbmFyaW8gaXM6DQo+PiDCoCDCoCDCoCAxLiBjbGllbnQtMSBz
ZW5kcyBzZXRhdHRyIChpYXR0ci0xKSByZXF1ZXN0IHRvIHNlcnZlcg0KPj4gwqAgwqAgwqAgMi4g
Y2xpZW50LTEgcmVjZWl2ZXMgdGhlIHJlcGx5IGZyb20gc2VydmVyDQo+PiDCoCDCoCDCoCAzLiBi
ZWZvcmUgY2xpZW50LTEgdXBkYXRlcyBpYXR0ci0xIHRvIHRoZSBjYWNoZWQgYXR0cmlidXRlcyBi
eQ0KPj4gwqAgwqAgwqAgwqAgwqBmdXNlX2NoYW5nZV9hdHRyaWJ1dGVzX2NvbW1vbigpLCBzZXJ2
ZXIgcmVjZWl2ZXMgYW5vdGhlciBzZXRhdHRyDQo+PiDCoCDCoCDCoCDCoCDCoChpYXR0ci0yKSBy
ZXF1ZXN0IGZyb20gY2xpZW50LTINCj4+IMKgIMKgIMKgIDQuIHNlcnZlciByZXF1ZXN0cyBjbGll
bnQtMSB0byB1cGRhdGUgdGhlIGlub2RlIGF0dHJfdmVyc2lvbiBhbmQNCj4+IMKgIMKgIMKgIMKg
IMKgaW52YWxpZGF0ZSB0aGUgY2FjaGVkIGlhdHRyLCBhbmQgaWF0dHItMSBiZWNvbWVzIHN0YWxl
ZA0KPj4gwqAgwqAgwqAgNS4gY2xpZW50LTIgcmVjZWl2ZXMgdGhlIHJlcGx5IGZyb20gc2VydmVy
LCBhbmQgY2FjaGVzIGlhdHRyLTINCj4+IMKgIMKgIMKgIDYuIGNvbnRpbnVlIHdpdGggc3RlcCAy
LCBjbGllbnQtMSBpbnZva2VzIGZ1c2VfY2hhbmdlX2F0dHJpYnV0ZXNfY29tbW9uKCksDQo+PiDC
oCDCoCDCoCDCoCDCoGFuZCBjYWNoZXMgaWF0dHItMQ0KPj4NCj4+IMKgIMKgIFRoZSBpc3N1ZSBo
YXMgYmVlbiBvYnNlcnZlZCBmcm9tIGNvbmN1cnJlbnQgb2YgY2htb2QsIGNob3duLCBvciB0cnVu
Y2F0ZSwNCj4+IMKgIMKgIHdoaWNoIGFsbCBpbnZva2UgLT5zZXRhdHRyKCkgY2FsbC4NCj4+DQo+
PiDCoCDCoCBUaGUgc29sdXRpb24gaXMgdG8gdXNlIGZ1c2VfaW5vZGUncyBhdHRyX3ZlcnNpb24g
dG8gY2hlY2sgd2hldGhlciB0aGUNCj4+IMKgIMKgIGF0dHJpYnV0ZXMgaGF2ZSBiZWVuIG1vZGlm
aWVkIGR1cmluZyB0aGUgc2V0YXR0ciByZXF1ZXN0J3MgbGlmZXRpbWUuIElmIHNvLA0KPj4gwqAg
wqAgbWFyayB0aGUgYXR0cmlidXRlcyBhcyBzdGFsZSBhZnRlciBmdXNlX2NoYW5nZV9hdHRyaWJ1
dGVzX2NvbW1vbigpLg0KPj4NCj4+IMKgIMKgIFNpZ25lZC1vZmYtYnk6IEd1YW5nIFl1YW4gV3Ug
PGd3dUBkZG4uY29tPg0KPj4gLS0tDQo+PiDCoGZzL2Z1c2UvZGlyLmMgfCAxMiArKysrKysrKysr
KysNCj4+IMKgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvZnMvZnVzZS9kaXIuYyBiL2ZzL2Z1c2UvZGlyLmMNCj4+IGluZGV4IGQ1OGY5NmQxZTlh
Mi4uZGYzYTZjOTk1ZGM2IDEwMDY0NA0KPj4gLS0tIGEvZnMvZnVzZS9kaXIuYw0KPj4gKysrIGIv
ZnMvZnVzZS9kaXIuYw0KPj4gQEAgLTE4ODksNiArMTg4OSw4IEBAIGludCBmdXNlX2RvX3NldGF0
dHIoc3RydWN0IGRlbnRyeSAqZGVudHJ5LCBzdHJ1Y3QgaWF0dHIgKmF0dHIsDQo+PiDCoCDCoCDC
oCDCoCBpbnQgZXJyOw0KPj4gwqAgwqAgwqAgwqAgYm9vbCB0cnVzdF9sb2NhbF9jbXRpbWUgPSBp
c193YjsNCj4+IMKgIMKgIMKgIMKgIGJvb2wgZmF1bHRfYmxvY2tlZCA9IGZhbHNlOw0KPj4gKyDC
oCDCoCDCoCBib29sIGludmFsaWRhdGVfYXR0ciA9IGZhbHNlOw0KPj4gKyDCoCDCoCDCoCB1NjQg
YXR0cl92ZXJzaW9uOw0KPj4NCj4+IMKgIMKgIMKgIMKgIGlmICghZmMtPmRlZmF1bHRfcGVybWlz
c2lvbnMpDQo+PiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBhdHRyLT5pYV92YWxpZCB8PSBBVFRS
X0ZPUkNFOw0KPj4gQEAgLTE5NzMsNiArMTk3NSw4IEBAIGludCBmdXNlX2RvX3NldGF0dHIoc3Ry
dWN0IGRlbnRyeSAqZGVudHJ5LCBzdHJ1Y3QgaWF0dHIgKmF0dHIsDQo+PiDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBpZiAoZmMtPmhhbmRsZV9raWxscHJpdl92MiAmJiAhY2FwYWJsZShDQVBfRlNF
VElEKSkNCj4+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGluYXJnLnZhbGlk
IHw9IEZBVFRSX0tJTExfU1VJREdJRDsNCj4+IMKgIMKgIMKgIMKgIH0NCj4+ICsNCj4+ICsgwqAg
wqAgwqAgYXR0cl92ZXJzaW9uID0gZnVzZV9nZXRfYXR0cl92ZXJzaW9uKGZtLT5mYyk7DQo+PiDC
oCDCoCDCoCDCoCBmdXNlX3NldGF0dHJfZmlsbChmYywgJmFyZ3MsIGlub2RlLCAmaW5hcmcsICZv
dXRhcmcpOw0KPj4gwqAgwqAgwqAgwqAgZXJyID0gZnVzZV9zaW1wbGVfcmVxdWVzdChmbSwgJmFy
Z3MpOw0KPj4gwqAgwqAgwqAgwqAgaWYgKGVycikgew0KPj4gQEAgLTE5OTgsOSArMjAwMiwxNyBA
QCBpbnQgZnVzZV9kb19zZXRhdHRyKHN0cnVjdCBkZW50cnkgKmRlbnRyeSwgc3RydWN0IGlhdHRy
ICphdHRyLA0KPj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogRklYTUU6IGNsZWFyIElfRElS
VFlfU1lOQz8gKi8NCj4+IMKgIMKgIMKgIMKgIH0NCj4+DQo+PiArIMKgIMKgIMKgIGlmICgoYXR0
cl92ZXJzaW9uICE9IDAgJiYgZmktPmF0dHJfdmVyc2lvbiA+IGF0dHJfdmVyc2lvbikgfHwNCj4+
ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdGVzdF9iaXQoRlVTRV9JX1NJWkVfVU5TVEFCTEUsICZm
aS0+c3RhdGUpKQ0KPj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpbnZhbGlkYXRlX2F0dHIgPSB0
cnVlOw0KPj4gKw0KPj4gwqAgwqAgwqAgwqAgZnVzZV9jaGFuZ2VfYXR0cmlidXRlc19jb21tb24o
aW5vZGUsICZvdXRhcmcuYXR0ciwgTlVMTCwNCj4+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEFUVFJfVElNRU9VVCgmb3V0YXJnKSwNCj4+
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGZ1c2VfZ2V0X2NhY2hlX21hc2soaW5vZGUpLCAwKTsNCj4+ICsNCj4+ICsgwqAgwqAgwqAgaWYg
KGludmFsaWRhdGVfYXR0cikNCj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZnVzZV9pbnZhbGlk
YXRlX2F0dHIoaW5vZGUpOw0KPiANCj4gVGhhbmsgeW91LCBJIHRoaW5rIHRoZSBpZGVhIGlzIHJp
Z2h0LiBKdXN0IHNvbWUgcXVlc3Rpb25zLg0KPiBJIHdvbmRlciBpZiB3ZSBuZWVkIHRvIHNldCBh
dHRyaWJ1dGVzIGF0IGFsbCwgd2hlbiBqdXN0IGludmFsaWRpbmcNCj4gdGhlbSBkaXJlY3RseSBh
ZnRlcj8gZnVzZV9jaGFuZ2VfYXR0cmlidXRlc19pKCkgaXMganVzdCBiYWlsaW5nIG91dCB0aGVu
Pw0KPiBBbHNvLCBkbyB3ZSBuZWVkIHRvIHRlc3QgZm9yIEZVU0VfSV9TSVpFX1VOU1RBQkxFIGhl
cmUgKHRydW5jYXRlIHJlbGF0ZWQsDQo+IEkgdGhpbmspIG9yIGlzIGp1c3QgdGVzdGluZyBmb3Ig
dGhlIGF0dHJpYnV0ZSB2ZXJzaW9uIGVub3VnaC4NCg0KPG1vdmVkIGNvbW1lbnRzIGlubGluZT4N
Cg0KPiBIaSBCZXJuZCwNCj4gSSB0aGluayBpbiBzdWNoIGNhc2UsIGFsdGhvdWdoIG91dGFyZy5h
dHRyIChyZXBseSBmcm9tIHNlcnZlcikgaXMgc3RhbGVkLCANCj4gYnV0IGl0IGlzIHN0aWxsIHZh
bGlkIGF0dHIgKHBhc3MgYWJvdmUgZnVzZV9pbnZhbGlkX2F0dHIoKSBjaGVjaykuDQo+IHNldCBp
dCBhbmQgdGhlbiBtYXJrIGl0IGFzIHN0YWxlLCBpcyBmb3IgZnNub3RpZnlfY2hhbmdlKCkgY29u
c2lkZXJhdGlvbg0KPiBhZnRlciAtPnNldGF0dHIoKSByZXR1cm5zLCBuZXcgYXR0ciB2YWx1ZSBt
YXkgYmUgdXNlZCBhbmQgY291bGQgY2F1c2UNCj4gcG90ZW50aWFsIGlzc3VlIGlmIG5vdCBzZXQg
aXQgYmVmb3JlIC0+c2V0YXR0cigpIHJldHVybnMuIFN1cmUsIHRoZSB2YWx1ZQ0KPiBtYXkgYmUg
c3RhbGVkIGFuZCB0aGlzIHNob3VsZCBiZSBjaGVja2VkIGJ5IGNhbGxlci4NCj4gDQo+IExhdGVy
LCBpYXR0ciBkYXRhIHdpbGwgYmUgcmV2YWxpZGF0ZWQgZnJvbSB0aGUgbmV4dCAtPmdldGF0dHIo
KSBjYWxsLg0KDQpHb29kIHBvaW50IGFib3V0IGZzbm90aWZ5X2NoYW5nZSgpLCB3b3VsZCB5b3Ug
bWluZCB0byBhZGQgYSBjb21tZW50IGFib3V0DQp0aGF0Pw0KDQorICAgICAgIGlmICgoYXR0cl92
ZXJzaW9uICE9IDAgJiYgZmktPmF0dHJfdmVyc2lvbiA+IGF0dHJfdmVyc2lvbikgfHwNCisgICAg
ICAgICAgICAgICB0ZXN0X2JpdChGVVNFX0lfU0laRV9VTlNUQUJMRSwgJmZpLT5zdGF0ZSkpIHsN
CisJCS8qIEFwcGx5aW5nIGF0dHJpYnV0ZXMsIGZvciBleGFtcGxlIGZvciBmc25vdGlmeV9jaGFu
Z2UoKSAqLw0KKyAgICAgICAgICAgICAgIGludmFsaWRhdGVfYXR0ciA9IHRydWU7DQoNCg0KPiAN
Cj4gSSBhbSB1bmNsZWFyIHdoeSBGVVNFX0lfU0laRV9VTlNUQUJMRSBzaG91bGQgYmUgY2hlY2tl
ZCBoZXJlLCBjYW4geW91DQo+IHByb3ZpZGUgbW9yZSBkZXRhaWwgPyBUaGFua3MuDQoNCg0KVGhl
IGZ1bmN0aW9uIGl0c2VsZiBpcyBzZXR0aW5nIGl0IG9uIHRydW5jYXRlIC0gd2UgY2FuIHRydXN0
IGF0dHJpYnV0ZXMNCmluIHRoYXQgY2FzZS4gSSB0aGluayBpZiB3ZSB3YW50IHRvIHRlc3QgZm9y
IEZVU0VfSV9TSVpFX1VOU1RBQkxFLCBpdCANCnNob3VsZCBjaGVjayBmb3IgDQoNCmlmICgoYXR0
cl92ZXJzaW9uICE9IDAgJiYgZmktPmF0dHJfdmVyc2lvbiA+IGF0dHJfdmVyc2lvbikgfHwNCiAg
ICAodGVzdF9iaXQoRlVTRV9JX1NJWkVfVU5TVEFCTEUsICZmaS0+c3RhdGUpKSAmJiAhdHJ1bmNh
dGUpKQ0KDQoNClRoYW5rcywNCkJlcm5kDQo=

