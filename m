Return-Path: <linux-fsdevel+bounces-47409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A70D9A9D1F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 21:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1290F4C5912
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 19:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D0D224882;
	Fri, 25 Apr 2025 19:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="WZjcMHIg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012023.outbound.protection.outlook.com [40.107.75.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A8221C189
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 19:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609819; cv=fail; b=Rc5uOxeDztCCOqdaRUIOC8jkluw29PYCA82/Oq7UAsbUYXYZPvdyFq77lEDJ7dQUtL+sSqxM8MJYdQHVPVFdctFSO70L9E5Vt1hppIXsnLR+apZCgto6hlF+XTMsmpnXkdJ1EFArNsujTT78EuODCQS81miNA5BrUblVPzPCSVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609819; c=relaxed/simple;
	bh=5+1gIb59c92BuhWTar+zRO6GhyWnFta/NAzZF6Jk9Bw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g/0MJfcMBc5ch+UfmGMqNe3ITn9EeSunkZMW9EnHxj0IMfFXch2a+XhqzfOhvDt5Hen7xjYNNNDNwRr5vn7LAJ2oXM0otT3CF7S4fee0HFv2ddEi1X3sFh7htt3JZWnxMdxSNn/61W1rCQnH+mjmys3CQ7Hr4OnYXltrpueg0eY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=WZjcMHIg; arc=fail smtp.client-ip=40.107.75.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4LhwtoZDkifkguFIpXMRQOVB15Ipvow1XCiYInqecUK7egzNC6dFgEnlE39GORzs8Kx3GOrBWLNvHY+uQ8rbGTEvG50qJ5RbPDbSRKD9JGJlPN3YqtCUYj9v1JgECByStzDosyJQ+Frr9KKUkoC5U5IeZn3MSLSZZuqmwgUKtA27jmgxPh0Ycu0RV38fAOv1NJfVm18HUlwKN6IQa6AedQxpBs93iHXlOoWcHQX7LrHVeEGpxvelqPFDG6BVsbNxQOB9DMV1cCR7YyZh8rkDT1ntd20y2b72RBRzORsyMbKLLJ/fBHKPe7wDkRXJWxfqVmAcySCb6+LUNqHzpJ7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+1gIb59c92BuhWTar+zRO6GhyWnFta/NAzZF6Jk9Bw=;
 b=ADGecoYxDzwWoxe14gfM4JZGxW7PdV9GvbTe2CDmkZOWvj1zz4Qp/MY6vg7hdetJHSpG8HAsECzKQNZ6j6y0gVQG5PLCfpxTMa4wa1ATJHzOhzP7CeEQTH7g6f5JUQ+PYbmn2XE/VqUt9xwzlpLjLTpLNnDrzCGqAfunQzpjDPUAorl+PAZmpOkA5AT108E71L6eJ++LTEfpqWvCGUhB8u9VMeyMu3KNiuqsNBvMSy8eJLgLx3rVJGHXsiztkmxwN6lGPSGT5SSajZlON1axahRyXK8z170x/npuEGOsi7FVt4Db0WcbJQyFnFjaLg4eX5HUlU43T4H3gJuUE1FH8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+1gIb59c92BuhWTar+zRO6GhyWnFta/NAzZF6Jk9Bw=;
 b=WZjcMHIg8CJwBwJ+3tPCZAmr50Hblvk5ypZ8SpLEXKYuJBjvSRu7QZhpItXmFeSI9S6XQ8NYHpgBBgjOl+nOSv+LMgde3ayKUrumzmDO6wBWPGbyCsrYfPbhVhOrbgTqm9vzbDaIcDckfNXP61WvJnwXIyz/dDGvoMEKA5nU3ahTwvI8x1e3B+86TSCOu2SdGgOlUJg/6vysF5FGZWGNF2TaGtp1wQO7LqdDKJGe1SAEUU9RjlsaOk5NsbqMcyPndTyKhxBgRKosLkLMsp/yk5EXFy4JnSJvhg4MGFHEizx79QI08dTG3sMXFYSb8IQuqtDzgfbpkq7a6clyqyaxsg==
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6336.apcprd06.prod.outlook.com (2603:1096:101:122::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 19:36:49 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 19:36:49 +0000
From: =?utf-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>, "slava@dubeyko.com"
	<slava@dubeyko.com>
Subject:
 =?utf-8?B?5Zue5aSNOiAg5Zue5aSNOiDlm57lpI06IEhGUy9IRlMrIG1haW50YWluZXJz?=
 =?utf-8?Q?hip_action_items?=
Thread-Topic:
 =?utf-8?B?IOWbnuWkjTog5Zue5aSNOiBIRlMvSEZTKyBtYWludGFpbmVyc2hpcCBhY3Rp?=
 =?utf-8?Q?on_items?=
Thread-Index:
 AQHbswekna2OCwxWoE2e/XeZ/ACbe7Ovn+GAgACQiQCAAAnhgIAAAEsAgANb3oCAAJkF0IAAFf8AgAAA2+CAAHKYAIAAEYKw
Date: Fri, 25 Apr 2025 19:36:49 +0000
Message-ID:
 <SEZPR06MB5269BB960025304C687D6270E8842@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <f06f324d5e91eb25b42aea188d60def17093c2c7.camel@ibm.com>
						 <2a7218cdc136359c5315342cef5e3fa2a9bf0e69.camel@physik.fu-berlin.de>
					 <1d543ef5e5d925484179aca7a5aa1ebe2ff66b3e.camel@ibm.com>
				 <d4e0f37aa8d4daf83aa2eb352415cf110c846101.camel@physik.fu-berlin.de>
			 <7f81ec6af1c0f89596713e144abd89d486d9d986.camel@physik.fu-berlin.de>
		 <787a6449b3ba3dce8c163b6e5b9c3d1ec1b302e4.camel@ibm.com>
		 <TYZPR06MB527574C2A8265BF6912994E6E8842@TYZPR06MB5275.apcprd06.prod.outlook.com>
	 <84ebd3fb27957d926fc145a28b38c1ac737c5953.camel@physik.fu-berlin.de>
	 <SEZPR06MB5269CBE385E73704B368001AE8842@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <d35a7b6e8fce1e894e74133d7e2fbe0461c2d0a5.camel@ibm.com>
In-Reply-To: <d35a7b6e8fce1e894e74133d7e2fbe0461c2d0a5.camel@ibm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB5269:EE_|SEYPR06MB6336:EE_
x-ms-office365-filtering-correlation-id: 41a20992-d832-41b1-5f14-08dd843085a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RkRJajhzUVdYNVUzWHlqMGhmc2Q1RjRiVklYaVk0bThvQ0pGL1g1MWtySWNt?=
 =?utf-8?B?VU9RNHY0S1JVSkg0QWhJRFlPa3dvbmUvZ0VJOXVIWlVqcW01KzQ3U29ycjFW?=
 =?utf-8?B?WkZPR3NudmNOMnJMNEc4aER1N2g0bnpsejBodGpnTmxaVjlSQXlEemtlMGNq?=
 =?utf-8?B?djhVNHhNUG1NM20xaDVNTHlraVQ5ZlR4cjF6azkzMDRFQ3hOUnhXTkxncVJt?=
 =?utf-8?B?cjV4RzA2MytpWno2VkIyNlNTRUdkcXhVS2tYR0ZESjNtRXZadURLWG4wb09V?=
 =?utf-8?B?Q1N2Q1pCdmpVZDM3aVZtRlh3S3hGbWM2ZFFYVHdQakN3MnU2dldhUUMzYWp1?=
 =?utf-8?B?bWZPWUVwSFZ3SGVNYUphU3UvZkkyaE9Pby84NW11S0tzZE41cWFWN2JkajVS?=
 =?utf-8?B?VE9Jd0dvVWQzMmw4TTJDMy9aUzNjRXJiVEdXaXJ3RnV4bFh5UDYvUFZUVkJD?=
 =?utf-8?B?eEd4bHZnZ1RiMmd3cHd0ZzJOSDZERVU4Yk1meG5tTTQxUVdvTTR1Z2tMREg1?=
 =?utf-8?B?cWZ0QVRPc3FMK1FKeENJWS9OMkhiMHo5enBQbUh5YzNxNmlncm5TSmMwUFh2?=
 =?utf-8?B?ZFl2NGNFS3pZSFJYTld1YUl0cFV3MWh1TmxvbWpER2tQSnZ0dGozQnVzWG81?=
 =?utf-8?B?ZEZTK3Focy9IcTZRd2dwckFTZmZHODhlZjluV2NpZE5vTjdqc1Q3bk05ckJi?=
 =?utf-8?B?WFJ1OVpHNEoraHNHZ0pNczZnRDMrVlZrSlNaakkyQUFXR2lDeWJqWk9iRVM3?=
 =?utf-8?B?RjZYQ0ZXbWJQTFhjV3FlTHYzSUlSU3NoZjYxTGJpZFcrbnAyNkdGMENySkg1?=
 =?utf-8?B?eDlBaC9aNDJmamE3MEhNZ0ZaOWZ6ZzhQKzJrODE4V0FsNTE4SWRZc1Y5K3lN?=
 =?utf-8?B?RmQ4VE1XMGxodjlYbWNBeEFwRUNCa0ZDblMwQTBIS0RoYVhqT0dObEkxY3FO?=
 =?utf-8?B?b3N6a1JHYTlOdjJvZGc0ZXluQnpnMWZTWVhiTzl4L2JPazg4c3UwVU4yZHhN?=
 =?utf-8?B?Z3lndm16T2ZjNDRLS1A1ZXRIaGVpbThRMmdOaExleWpHT3ZPYUFPZVc0Si9X?=
 =?utf-8?B?bUxVZWo3VDd6WGhqQ0c0TTFqa1M2TnZ2YjN5a1NibFI4aGFvdmJod0VEcXdN?=
 =?utf-8?B?ZFhBQ3ZmM2pXanlxeWZMdUxRR2pXb0tybkF0MTRCdCt2WnBPd1ZxZ29KKy9G?=
 =?utf-8?B?enM2d2c4Z21KVlVSM2NraXlYcTgxaTZBQUFjdVdmUnNxVWZlZ1lQWEEvc01E?=
 =?utf-8?B?YWc2WnRCZXlCWFRUV1psd1FjWElZdUhZM2o0NnV2azVpWElRNnh0Wk9KRGVN?=
 =?utf-8?B?elVpQTFSeGlTd1A0RlErMlpGeXNJNFF0blNMekdydWYweVVTT3VJdWZYbEM3?=
 =?utf-8?B?Vy9nTTBrRzVnQlJ3UHEwRXU4S20wMHE5eEg3SWl1YjRpcmx0dU5uaGJnNU1a?=
 =?utf-8?B?SnlDcXZvRkJXQWEwS2NHdWRTQnMySWV5UTZUSUF6dW9SRjkyMjlINEIxYldp?=
 =?utf-8?B?cGJXVnZETnBnK3FqZW5IaWN0WldWSE5xRDByV2JoNFVIenQ1VjBXZU9MdFJq?=
 =?utf-8?B?cEV1YlpqZDV1SUUzdEtSS2NqNTVJaHBDMEp1QzQ0SklQUVNpZHV3Sk1uRzky?=
 =?utf-8?B?amsrUmZxRHFVTmlWdGYvUWplb2ZXRkphcVRDWWdMR2xtR1IzY2lZaGpKT1BK?=
 =?utf-8?B?WTNnVVlUK1dsRmJZV2tGV1g4ZDdNVS8vdlkxdk95UmpNZDF5OEhMdkZ2L0Fk?=
 =?utf-8?B?eERGUkRCWmw5ZFlYaXRJU0RDeTRFQnFzWUlBNnkzL1FWQUlRZlgxeHg2eGRX?=
 =?utf-8?B?M3RFM1BnSTF6cGRtNUg3Ym9Nc0wyeEI2dkM0NUp2ZmEyai8wTzhPaEY5T0NE?=
 =?utf-8?B?bHA0R0xJbEJpc29qWGp4L3JxenNnNHdUV2dDQ0k1UGlYZWFDZ1YxTDdaTEVr?=
 =?utf-8?B?aWxFb21IdkdRZjd2UXdLakpObG15SE55YW1aZDJZcnI1MThjVzZHbWE5eTR6?=
 =?utf-8?B?djljb0sxeDl3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NDJqK3NoanNNWXNlRCtwYkNGQXVBUElTNkxvS0U4Y1RlanN3aDlveFE0Q3JQ?=
 =?utf-8?B?NklzZlZKSGFEWUcyQkFvT0h4emNvc0JhRkFobUhHTTl1QzR6ZWthVVMwRGV2?=
 =?utf-8?B?czdNNUVRTTlzZmR6UXpYNjFFNUFGRmo5cm44T1ZXRmMzbGFlNmpZOThNc3k3?=
 =?utf-8?B?QTdHWXJiLzl2dHNEdElvRFlWdXEzNjFmZ3l0ZDRCTTB2T3dtbitKa0xUNlg2?=
 =?utf-8?B?Nzk5aEdqV2tUbkdEbE5oVURYUWNjK21JRXpyTm5MSDRSM2FRRFJxK1hQM3lX?=
 =?utf-8?B?K1Fwek8yY1hTcGlBdm1BS0dONmMwczNubnlxcEFNaGh1QW1lbndCMElrOWNZ?=
 =?utf-8?B?eGNubnFna3orOTVEcElLZkhvU2tFVXBwRzVnczJVdGcydTRsY2NTZS92eC9y?=
 =?utf-8?B?WW1JN3RWUU5McDZCT1VETFhwZDRqUEw1dHJQMzZvQ3B0VVlGS2MwK2FTc2xQ?=
 =?utf-8?B?b2NrOXZTSjNOVWdYZlZoMWVPc1pHdkdMN0RpVEJVTHYyTWxjb29aZkRzUHQ4?=
 =?utf-8?B?a3YyaUQxV2xlREJ3alphbnluZEtWcld1R2FUNE9TMmw0eUpRL3NHYnpwS09y?=
 =?utf-8?B?NEkxS2xjVFloNjh6RDRnMFBRYnF3dlEvYUxVUWhJaThtMWVOV0J2d0dVdkhS?=
 =?utf-8?B?SE1GQTJOWTBSbkFCK3lPMW1TM0JhYnB2Wk1KYzBBTnpRREFHaW9SQW1JZnE1?=
 =?utf-8?B?QXFucU4xalVTWjVLbHAxMUh0MzQ4blc5UkZoRkp0ZUZ1OW1HRWMzNTFzSVlG?=
 =?utf-8?B?QkRTN2EvSFNmaEZlWWd2K21KWXNtRVVnRmcxR3dDV0J1aThGSWhjZEpsS2NZ?=
 =?utf-8?B?R1pnR0VCYnI4SjB3Rjh5Q0M2eWdldGNVVTBmODVIbHhtWkJLUFo5eFdubWd0?=
 =?utf-8?B?UkpWRlIyK2I4Q2llKzJxcXpqNVRwS2g5aWNObW0vNFphaktCME51WHJrZjVa?=
 =?utf-8?B?NVZSc0xDdjlyOUlJR2wvS3J3MGgvMTdKekd2TGtjbEl1UEsxdzNOTGpCc2VN?=
 =?utf-8?B?cHJYS0x0cXFackxDK1dQN3B5Z0JGQitreUNlMG9sK3JBdUEwQStGNHBYVnJs?=
 =?utf-8?B?dU5NT3c5bm9teUp6alVHZmNjTUNyRG1XWUMxTGg3V2R2WGg1cFVYNkpYK1Rq?=
 =?utf-8?B?TUpDQXU3bHBjRmVNQ1RBbUpGOHl5bytXRkI5cThFVHJ1TlVQSnYyYnF0bzg3?=
 =?utf-8?B?bWpmQ2tpMFhVTTlwamwrRUdEa3ZWSUoxQzdNWHVVbnVHczZmQkp5bUNYQU1F?=
 =?utf-8?B?SU5xUmo4KzZRczBKdlBPMEVEQk5aczMwRW9ja01JZVpEUjZMWEZ3aTkydG1z?=
 =?utf-8?B?UjNvM1RxdDc2VWxMeUh1dlpuQ0JjNWdqQjhPQlFadkxaNk1xMXdzTU4xem9K?=
 =?utf-8?B?UHRpM3FRaWhhNitkM3R6b290MjF4Ui9UTHNTTzU0UzBQejdaTDF0V2tlTldX?=
 =?utf-8?B?bVduN201YzAxSWpmVlFOcGIwUG8wVmgxb0ZIcWxITUg2L1FUUTBtRmNsWUpv?=
 =?utf-8?B?M2Z1ZFRDbXcyQUZZb1d5aTlqWlRyWGhVMnFsUjZNZm81OGFOa3M4QTMyd3di?=
 =?utf-8?B?dUZ6T1BMZjJta3dFNjhWc3d4eVp0SkxBZnRPUVNtVTdmOTV1REhqdVFGQUor?=
 =?utf-8?B?bDh1TUd4RVdBdC8yMy9aNnBMN3hNcUk0akNOQ21wZmpmSStFSEp6ZjA4ek1a?=
 =?utf-8?B?QTlMZjFlVWkzclhQRXFhZTBLUGI3dUFBMXdnSmNyemt5VmMxaHVtQUVDOHFC?=
 =?utf-8?B?b25uY0ZPMUVZWjJrQ1JNdVhKOThaUmpHbEs4bjRwM2Rnb2JCS2h6OW1ydGpr?=
 =?utf-8?B?ZStHeDcyTUx4Qy93dG1UeEEzUnNQRlFLVUFUc2JvMFh3SUF3bW5NdTdpL0RP?=
 =?utf-8?B?akpRdWhtdmtMQUo0ZGtnOGwxR1NWWDkyKy9HMlFkZDcyYnRYUm5yRlJXYVph?=
 =?utf-8?B?SHlKbWFaanNHZDB6TzY2UTRnUW03eXlwWExTUDJLcFNCN3BRcGtBR3hNUTgz?=
 =?utf-8?B?eG12dDFvSXZDMGlMT2FYaFdjNm5xTVRoM0RZMGtFL0RkVHZERVlKYkxHeDlL?=
 =?utf-8?B?NlJIWExuZVZhVmpxSUlxSC9zVGpKY3ZFd2kzZTk3TEh4NTExeVJvQUNFMTB4?=
 =?utf-8?Q?x4CM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a20992-d832-41b1-5f14-08dd843085a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 19:36:49.1750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rGWwqI8VUu7VDi4h1fBCK5ta7RHRTAz6ByAGbfQh1+2XkD8GotSi9eH63T+d+npJHQszIXoMw9xjZObSam0DdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6336

SGkgU2xhdmEsDQoNCj4gSWYgeW91IHdpbGwgaGF2ZSBzb21lIHRyb3VibGVzLCBwbGVhc2UsIGxl
dCBtZSBrbm93IGFuZCBJIHdpbGwgdHJ5IHRvIGhlbHAuIDopDQoNClRoZXJlIGFyZSBzb21lIHN0
cmFuZ2UgaXNzdWVzIGluZGVlZCwuIDogKQ0KDQpPbmUgaGFzIGJlZW4gc29sdmVkLCBhbmQgdGhl
IG90aGVyIG1heSBiZSBzb2x2ZWQgYnkgY2hhbmdpbmcgdGhlIGVudmlyb25tZW50Lg0KDQoxKS4g
SGVhZGVyIGZpbGVzIGluc3RhbGxlZCwgYnV0IGxpbnV4L2Jsa2Rldi5oIGlzIHN0aWxsIG1pc3Np
bmcuDQoNCkN1cnJlbnRseSBJIGNvcGllZCB0aGUgaGVhZGVyIGZpbGVzIG1hbnVhbGx5IGFuZCBp
dCB3b3Jrcy4NCg0KL3Vzci9pbmNsdWRlL2xpYnVyaW5nL2NvbXBhdC5oOjExOjEwOiBmYXRhbCBl
cnJvcjogbGludXgvYmxrZGV2Lmg6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkNCiAgIDExIHwg
I2luY2x1ZGUgPGxpbnV4L2Jsa2Rldi5oPg0KICAgICAgfCAgICAgICAgICBefn5+fn5+fn5+fn5+
fn5+DQpjb21waWxhdGlvbiB0ZXJtaW5hdGVkLg0KbWFrZVszXTogKioqIFtNYWtlZmlsZTo1MTog
ZnNzdHJlc3NdIEVycm9yIDENCm1ha2VbMl06ICoqKiBbaW5jbHVkZS9idWlsZHJ1bGVzOjMxOiBs
dHBdIEVycm9yIDINCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6NjU6IGRlZmF1bHRdIEVycm9yIDIN
Cm1ha2U6ICoqKiBbTWFrZWZpbGU6NjM6IGRlZmF1bHRdIEVycm9yIDINCg0KMikuIEFyY2ggTGlu
dXggaGFzIHRoZSBoZnNwcm9ncyBpbnN0YWxsYXRpb24gcGFja2FnZSwgYnV0IGFmdGVyIGluc3Rh
bGxhdGlvbiB0aGVyZSBpcyBvbmx5IG1rZnMuaGZzcGx1cywgbWlzc2luZyBta2ZzLmhmcw0KDQpJ
IHRoaW5rIGlmIEkgc3dpdGNoIHRvIFVidW50dSBvciBzb21ldGhpbmcsIHRoaXMgcHJvYmxlbSBz
aG91bGQgZ28gYXdheS4NCg0KSSB1c2VkIHRoZSBmb2xsb3dpbmcgY29tbWFuZCB0byB0ZXN0IGFu
ZCBnb3QgdGhlc2UgZmFpbHVyZSBjYXNlcy4NCg0Kc3VkbyAuL2NoZWNrIC1nIHF1aWNrDQoNCkZh
aWx1cmVzOiBnZW5lcmljLzAwMSBnZW5lcmljLzAwMiBnZW5lcmljLzAwMyBnZW5lcmljLzAwNSBn
ZW5lcmljLzAwNiBnZW5lcmljLzAwNyBnZW5lcmljLzAxMSBnZW5lcmljLzAxMyBnZW5lcmljLzAy
MCBnZW5lcmljLzAyMyBnZW5lcmljLzAyNCBnZW5lcmljLzAyOCBnZW5lcmljLzAyOSBnZW5lcmlj
LzAzMCBnZW5lcmljLzAzNSBnZW5lcmljLzAzNyBnZW5lcmljLzA2MiBnZW5lcmljLzA2NyBnZW5l
cmljLzA2OSBnZW5lcmljLzA3MCBnZW5lcmljLzA3NSBnZW5lcmljLzA3NiBnZW5lcmljLzA3OSBn
ZW5lcmljLzA4MCBnZW5lcmljLzA4NCBnZW5lcmljLzA4NyBnZW5lcmljLzA4OCBnZW5lcmljLzA5
MSBnZW5lcmljLzA5NSBnZW5lcmljLzA5NyBnZW5lcmljLzA5OCBnZW5lcmljLzExMiBnZW5lcmlj
LzExMyBnZW5lcmljLzExNyBnZW5lcmljLzEyMCBnZW5lcmljLzEyNCBnZW5lcmljLzEyNiBnZW5l
cmljLzEzMSBnZW5lcmljLzEzNSBnZW5lcmljLzE0MSBnZW5lcmljLzE2OSBnZW5lcmljLzE4NCBn
ZW5lcmljLzE5OCBnZW5lcmljLzIwNyBnZW5lcmljLzIxMCBnZW5lcmljLzIxMSBnZW5lcmljLzIx
MiBnZW5lcmljLzIxNSBnZW5lcmljLzIyMSBnZW5lcmljLzIzNiBnZW5lcmljLzI0NSBnZW5lcmlj
LzI0NiBnZW5lcmljLzI0NyBnZW5lcmljLzI0OCBnZW5lcmljLzI0OSBnZW5lcmljLzI1NyBnZW5l
cmljLzI1OCBnZW5lcmljLzI2MyBnZW5lcmljLzI5NCBnZW5lcmljLzMwNiBnZW5lcmljLzMwOCBn
ZW5lcmljLzMwOSBnZW5lcmljLzMxMyBnZW5lcmljLzMzNyBnZW5lcmljLzMzOCBnZW5lcmljLzM0
NiBnZW5lcmljLzM2MCBnZW5lcmljLzM2MiBnZW5lcmljLzM2NCBnZW5lcmljLzM2NiBnZW5lcmlj
LzM3NyBnZW5lcmljLzM5MyBnZW5lcmljLzM5NCBnZW5lcmljLzQwMSBnZW5lcmljLzQwMyBnZW5l
cmljLzQwNiBnZW5lcmljLzQwOSBnZW5lcmljLzQxMCBnZW5lcmljLzQxMSBnZW5lcmljLzQxMiBn
ZW5lcmljLzQyMyBnZW5lcmljLzQyNCBnZW5lcmljLzQyOCBnZW5lcmljLzQzNyBnZW5lcmljLzQ0
MSBnZW5lcmljLzQ0MyBnZW5lcmljLzQ0OCBnZW5lcmljLzQ1MCBnZW5lcmljLzQ1MSBnZW5lcmlj
LzQ1MiBnZW5lcmljLzQ2MCBnZW5lcmljLzQ2NSBnZW5lcmljLzQ3MSBnZW5lcmljLzQ3MiBnZW5l
cmljLzQ3OCBnZW5lcmljLzQ4NCBnZW5lcmljLzQ4NiBnZW5lcmljLzQ5MCBnZW5lcmljLzUwNCBn
ZW5lcmljLzUxOSBnZW5lcmljLzUyMyBnZW5lcmljLzUyNCBnZW5lcmljLzUyNSBnZW5lcmljLzUy
OCBnZW5lcmljLzUzMiBnZW5lcmljLzUzMyBnZW5lcmljLzUzOCBnZW5lcmljLzU0NSBnZW5lcmlj
LzU1NSBnZW5lcmljLzU3MSBnZW5lcmljLzU5MSBnZW5lcmljLzYwNCBnZW5lcmljLzYwOSBnZW5l
cmljLzYxMSBnZW5lcmljLzYxNSBnZW5lcmljLzYxOCBnZW5lcmljLzYzMiBnZW5lcmljLzYzNCBn
ZW5lcmljLzYzNiBnZW5lcmljLzYzNyBnZW5lcmljLzYzOCBnZW5lcmljLzYzOSBnZW5lcmljLzY0
NyBnZW5lcmljLzY3NiBnZW5lcmljLzcwNiBnZW5lcmljLzcwOCBnZW5lcmljLzcyOCBnZW5lcmlj
LzcyOSBnZW5lcmljLzczMiBnZW5lcmljLzczNiBnZW5lcmljLzc0MCBnZW5lcmljLzc1NSBnZW5l
cmljLzc1OSBnZW5lcmljLzc2MCBnZW5lcmljLzc2MSBnZW5lcmljLzc2Mw0KRmFpbGVkIDEzNiBv
ZiA2MTQgdGVzdHMNCg0KSSBoYXZlIHRvIGdvIHRvIGJlZCByaWdodCBub3cuIDogKQ0KDQpUaGFu
a3MsDQpZYW5ndGFvDQo=

