Return-Path: <linux-fsdevel+bounces-27479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E03B0961AF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 02:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0211F24649
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 00:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2718B10E0;
	Wed, 28 Aug 2024 00:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Ul0bQrfM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2130.outbound.protection.outlook.com [40.107.101.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7AE2F41;
	Wed, 28 Aug 2024 00:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724803737; cv=fail; b=Y5a1bMAA7tNeslTNbM6XGgywk/9W1+qARKEacv+DIiyYmQbIvCSnoSAoygPwAeNVFPm9LpfRMoR3hi8pSV9tl/eGZXFfIb4BzSNqU/eC2t5G3s9j8X0IcEQUt74CX3PwKnVyZP8OF58hDW1G3jaN9fFZ0/FQNCvdhWoobOQLlG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724803737; c=relaxed/simple;
	bh=qqMc/n45HV0JF9X2ipRKXKUPrzfAHHOcfJQvkwbJpS8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EtedzlszRcfSiIQh/0iA9dIAhR6jxuSs9jwrUuaVGe5hCL2IMxFKqAZcNCWWIezC6DM9endBlZhvHDDbThBT1G+VdAzV9cqQA4AKLZHUidleRmz0yZXp5y/OHr9Gj1kEwv6dX/ZNJNAjz+Lyg5XZynBaDm/hW6vrxlOTcNDsS3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Ul0bQrfM; arc=fail smtp.client-ip=40.107.101.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brEN/oZvcx+F+kaMV0u8LBkTBSPyTj3Y3hcgA4kiZIOWKbdrk+eEY7PuFOFGiv5MCZTQH2MaBPvldY23EdDzwNvFt1SeOvBkb+M9DdbcWHK5HOvo6T/hqqQa7EwCnfNQYUNvofk+Z+jFqarwUy0d5apoCCrdWn4mbp0PBT8cMq5p2Z3Btf6+kIaAu0bc/PJ+kLfft4pNWv/Q1bDZX0nEfTeRMJ3zyLRZa+5LVJCFJfCRr5BxA0dy0FHQYsGEdw82Ry6I2lClShYzGgLUmxYfe/8SAMPUoCj2F690QG0Tr6mixASA7vtH89yVdDd0KTRTJgflEOjO6rLtvTXAP0deng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqMc/n45HV0JF9X2ipRKXKUPrzfAHHOcfJQvkwbJpS8=;
 b=l8SS6zmG7Dxioct4ZTY4cUyn87JeSIR7ere5imgaBgaZqab3L3aFODMIy70iGpEWK4N8iZTrmpzwm/7WRi6aHExMhtq54U0fzF7VxRLYP8pBbc3S5fjmyG66HHQnW2Q7SoD4JBPLNkbct9qt7IV3dhDSqAZ2rC9zQ8CW599K3KRqSeC8Ncv2m6rJX4Bqj86NKVwqYtdKziuVtvaycOVO2kwO+w/H1P36ZD6f6dkLISggvF0TcZKqhe+W6cjxYodIgqi2WD14MWnfpb4uFulMbc6pohVdWB9hdobPno6pjMZliuqCiVDWqM0z8jEHiShM1/3w08rDxLvPUfQ1e2SRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqMc/n45HV0JF9X2ipRKXKUPrzfAHHOcfJQvkwbJpS8=;
 b=Ul0bQrfMFraG4wPh3iDk5dzyPliTneuo8FGBfvA4PzMZEQDN3oT5ow+enqQ6zunjx+02I3e9CJDhsb+wxwrp3xeC0NDypMiQYfFplBEYhrdty0jmlll6ZLehmG74o38hCSyPi/iY0kaGoTWX9kD5VDpP8s/U9NFkWfECvOkCTW4=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 SJ0PR13MB6037.namprd13.prod.outlook.com (2603:10b6:a03:3e2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Wed, 28 Aug 2024 00:08:52 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 00:08:51 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "neilb@suse.de" <neilb@suse.de>
CC: "anna@kernel.org" <anna@kernel.org>, "snitzer@kernel.org"
	<snitzer@kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "jlayton@kernel.org" <jlayton@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH v13 19/19] nfs: add FAQ section to
 Documentation/filesystems/nfs/localio.rst
Thread-Topic: [PATCH v13 19/19] nfs: add FAQ section to
 Documentation/filesystems/nfs/localio.rst
Thread-Index:
 AQHa9YhbSZns7TD6R0iwTEu+CeGCcLI4y2iAgADOoQCAAAl5gIACB1+AgAAJ3gCAABVagIAAB8EA
Date: Wed, 28 Aug 2024 00:08:51 +0000
Message-ID: <92a17308bbae50a4b5e172fdd972b8e174683cdd.camel@hammerspace.com>
References: <>	,
 <aec659a886f7da3beded2b0ecce452e1599f9adc.camel@hammerspace.com>
	 <172480206591.4433.15677232468943767302@noble.neil.brown.name>
In-Reply-To: <172480206591.4433.15677232468943767302@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|SJ0PR13MB6037:EE_
x-ms-office365-filtering-correlation-id: 29be76d8-5246-4fff-9594-08dcc6f5991e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VzFtTytscjdnVloxNVVIZzBvQzlWL0tFS09sSUpITjNyOVVNTEl6MVE3OEZj?=
 =?utf-8?B?dnlsc2RTN0taY1djK0Ntd3VlL0ROZ0ZNWnA1UUdlUTlvVlZUWlVYZ1g4YUp0?=
 =?utf-8?B?Q3BIVVpBb3NBcmZWY2NCNFBrV3k3SllIbWdnZE5PRk8rOVJvamFZeTcwUWhV?=
 =?utf-8?B?ZWkrMXFhRUY4VlA4cjNOOHRFdkhDOFc4czdORHpMYTdFbFk2c2Ftb2RNTUpu?=
 =?utf-8?B?dWZ6WVpIS216VWc5NVBvZS9ET29ZaTJUYTBmdXRnNkVEQlIvV24rcHNBc0N0?=
 =?utf-8?B?TVVIbnJZRDlXQVkyVkp4LzE3cGY5eFBWUHNBSDhOb2M3OEZBN0JXcXMzdEx4?=
 =?utf-8?B?SEQ4dkdyNFZFM3h6bFlBOFBJSFhuYytGMjNDOXkydGdVNVR1QVJIbG9BQ3pX?=
 =?utf-8?B?bFBlejZKZWxCUW5oajdONkI5cVpzUFMzZ01YRndPM3p1UTZhSnV6S3VsdlRn?=
 =?utf-8?B?RllETTVJenhVMXFiTWJYUk92R3MrNDg1MlEvdHB6aTExbzA0NkM3dHo5L0cw?=
 =?utf-8?B?M0s1NjZCQU94TUJYSktXQks2STY3VzdlV3ZsZGo0TUJwUUQzWWoyUG1HZlpM?=
 =?utf-8?B?UGx6bmc5WFBqamJhSDJORjBaZUhZck0xaGNXby8ySUQreXV1dUx2SXZ1cC9X?=
 =?utf-8?B?MlErQnpod2phYzEvYnJ4TzJuelhnbjBDNTgxSkpDUXpoM1FsZDZWNmUxbVpa?=
 =?utf-8?B?V1A1ZldzeUUwK3VndUt5SzMxRFdEOFh0VXIzMGVZY2k4Qm9oYnB6OGZodFBO?=
 =?utf-8?B?QnE5UXQ0V2kxTlQ4eGEzaGpoZFEvRnRZNkNIZUE5SUtwblVpckRvSWlPOVpB?=
 =?utf-8?B?Z285ZCtpRE4wMCszS2plYnJabWFaSkhMbEFIbU1kN1g2TlpQUHdQM1ZzM01H?=
 =?utf-8?B?Q2h0SUZDY0NDU3JNaW1leE52L05yNlFXaUlYd1BOclYyZy9DQjhaNVpic3U2?=
 =?utf-8?B?UVlwQkxaTmpqNVkvb1owMlVZajB2SFRsQVJDOHRhOXVrblZJczhHaUNyZ2g2?=
 =?utf-8?B?QWM2WHkwazIxUWd0UjcvSndFdU05NWFDNkVrKzBKNUdlWkxpTjIvNkRaYjdQ?=
 =?utf-8?B?anhiL1IwOFFWMEtPUjZuTE5FT3BzRlRnd3dMZi9kc0NSaHpTb3JueUJUZGdU?=
 =?utf-8?B?YnlZRDQ4bGZDTVNMZFBvY1pnT1pQRGtGaDVlbDVSNUhpL0J3VTkybU8zRXQ0?=
 =?utf-8?B?T1JuWDd3UkU3MDlpRGJxN25EeXJTWEdSSUpZY3QwcTVlVE1zVlFvM0VEOU8z?=
 =?utf-8?B?NmN0UktJZDJjKzliTWRxTWpHNUlKaU1EMmtJWllDTkdGN3hVRisvaHVaR2Mv?=
 =?utf-8?B?QlQyTVJ1ZG1zQmZ5UlZsRTlNOUc3K0IvdGw3enUxZzVRU0NENFJQVzVBaFNC?=
 =?utf-8?B?RXFESGRMa2N3S05tY0w5aGRIV0tuMFc3THpTNzAxTVVBekRqdVdjVjB3Wk9I?=
 =?utf-8?B?WkNRQW1XNDVoWkh6YVFKaVVwL1U4RVZkNVh5bzlrcGZTeEVEQXVvaGV0b29a?=
 =?utf-8?B?ZWRtcGMydVVmbnhTdjVBZzBHTE5OL2piT3pMdjZkd1FNNEpUOTlRVGJUUzFy?=
 =?utf-8?B?VDZrTDUxVnFpdE1TbG1DZmJnUHpjeHVtL1Bvb3MzMEJrU01GSldkdmIyb2gr?=
 =?utf-8?B?VnB5aVYza2FNc3FMNjZGMEs2NEZPVEQ5ZFFGa0hkQUJrVGNpWE9wcGRZUG05?=
 =?utf-8?B?QlZTUFBjUURBS1NhcEQ0WForUSt2bW1WVGh5UjR4MS9BWkdYbUwxQ3VUV2I3?=
 =?utf-8?B?MFdwYkNhbTY5SUJyWFpaNlhuSVJqdEVrUm1pQmRUOStLYkhXWS94anBZdDMr?=
 =?utf-8?B?d2NaNHpzQnNkV1lLNER3Y2NncUptZEZKa1RtQTh5K1d6NThDL2J4M3lZQ2p5?=
 =?utf-8?B?eml4Y1NZRGNjbUE2cS9EWm4wMExIeWpJeW1mL0RLV0ZKVFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SCtBQzBwL3hBbFRUd2VXbTlGTHdQOVlOeGtrRGVYMFhiV1BsUC9Tak8rRWE5?=
 =?utf-8?B?djhmTVlhakFXSkNhV21vVnZoSjJ5TUNWaTdlWmhtRE0wSHhlaU1QSWpnUktQ?=
 =?utf-8?B?SVdEUnI4cVp4eFl1SUloRkI4S0NUaGltb2sxVldzZHpzRHVHT0xrRG0xOGhv?=
 =?utf-8?B?b1ZMN1NacUEwd2twOFJoT1JCM1oxYy91d093YTd0Y2tuK3g5UmNXbHFOMkhw?=
 =?utf-8?B?L3YzcnFJQ1NTKy80THV5K2ZYRVd4M2tEeGdWbTA5Zm1IU284bmR2eUJFQXhV?=
 =?utf-8?B?YUhXZDVSL3IyMERValRmeTBRYkN5Vm1tazJYZEI1bCttenp1cTlPeDlQTGU5?=
 =?utf-8?B?UUtmTlk3MDVkWXRlcjNwOFFyRnhFYlBDSHdqcE1wRXoyN0QzYmlMZWZ2VzNx?=
 =?utf-8?B?OE83dFVoeUprZHdEcldMMEJ1cXlWNUFrK2VLUHREdVdOeHhXSTZQTmJ1QXBr?=
 =?utf-8?B?MVZYSExkMHg0R1dSbnRHQVozenRaSmNLQTdhMzBEY1M4YVFDbW1qajBJSjdL?=
 =?utf-8?B?MXRmQnFrNE82TTV4K1RrVllLSWpOYm51ZTRDKzN5Sjgyb3M0Z1FSR1ZJWkli?=
 =?utf-8?B?T01iSEowc3FOY2RjaHVyRkh2OG4yVVAydjUyWkdsSjBCZmtUdEJFbWF2eDBJ?=
 =?utf-8?B?UUZacWI4ZFNqbHZObWxHOTlFdkJJeGxva1JnTWM0TFZYa05tdUlLZ1duTGs3?=
 =?utf-8?B?UlBOd1VjbHlJVVNUczE1WDN1R21mQ1FMVWFxd0RMdG10a3ExZFFtL3dkaEZD?=
 =?utf-8?B?ZzU2VEkwc0pUWEtlWGhCR3NPdnpNQWlmUFJrUm1NQ0hDTStKdlNYZTFPU1Zp?=
 =?utf-8?B?UlF5NjUvQnkwVktXRDlrZFdXRUdJK3BlUk90Y2lFeXVlQnY1OXZoT0dPaURI?=
 =?utf-8?B?TUxPTFNtOUdhRHFPZ1pWV2NUNUM0U3FMNHZiMW9abWR5bHAxeG1veWNKZGRj?=
 =?utf-8?B?cmlaakZPZEMySm0rV3JCdTFGVHJiRU55djZUVERuN1RwTUpPVkMrVDBFTGFV?=
 =?utf-8?B?dlFjYTd6RXdtbTJrdUk1enBaa3VoanlXeW1UWWNtSUVUaTNVeTZ3NXdFaHd2?=
 =?utf-8?B?MmN1aUVPQXhqQVNVazdwZ1N0dVorcEdqK3h2SnBrOGZwSGoybDU0REVMd3dO?=
 =?utf-8?B?Ni9UUm9vTWt0Z3pYRlNmQkZ3QjZXSEY3anM2VDdqaE9YOUladnZFZnpxalJK?=
 =?utf-8?B?RW1TWUpxVXF1TE14bjAvYXlhQUJJZUlGSkFUR1VyY0Jzb3B6WnZlanlES3Er?=
 =?utf-8?B?S0NSSlBzYVpIVjFLbXNGczZNVzR2endTdFd2aG5IUjNzU2JUMW8wWFBrUjhx?=
 =?utf-8?B?azFOQWFLMFdFZXNOdk1OQW5SN0NMcWVwRXQ3cUNkeENUNUk4WTVzZXUwRUI5?=
 =?utf-8?B?RTcyYmpXNGc4cWtNR053bkR6cFBFQWlRVWdGV3BTSE5RVmJlck1EVENyMWJO?=
 =?utf-8?B?VGZUS1FQVERiSGczWEJreDZ6ZkErN3VFVUM5U2J1NEFTSWVkdGx6ZVFyNXQy?=
 =?utf-8?B?VFpHb21PTEJlTGNDeXNwK3J3d1J5bkNWZUFLdEtEdWZLc1c5QjczZHFJNkh1?=
 =?utf-8?B?YWlXS0F1M1ZheHcxNW5YcnlLM0lDTFREbGxKVktHaGtnMFFLSjRvWHdjdWpk?=
 =?utf-8?B?Y2M4SkhRVXR3WUR5N2xlZS9XekdCdU5PSzRhbTN6akhFSUVCZHQ4Y3luZDcy?=
 =?utf-8?B?aUdleHFxbXBxTjVZYW40SmgzU3pRNWExYlFFaC8xWnU2VWlQWEVDc0tUVll5?=
 =?utf-8?B?UEE3aUEwam43dkpuSnBNTWZsdnpSVFhBbEJ5T2tmT0x2ZVZqWm5rNlMwN3dM?=
 =?utf-8?B?amtRQ1BpVmpxV3FLNHNEUys4aDI1bHZwckhxUUlvOFlwTEgyenFxM1Uya1F4?=
 =?utf-8?B?NFdwQWU0byt2TWRsNkdFLzF0T254MzhabXkyZXdEWVEvT1I4N3JuQzg0R3lm?=
 =?utf-8?B?Rk1VY1ZqVWFwckpoWGMvcFE1UnJWMTJsV0gwMGhKaXBuazFTeEplQTR0ZWtG?=
 =?utf-8?B?aURmSXlGMEhNTHIzcldxY3YxbmdVM1lhVWcrQU5KaWxhNVErQWhqamYwUmdm?=
 =?utf-8?B?bFRCU09jWkdhNEEyMDlFMVZ2VU5oTDlyMkdyRXVzanVQcENtWWhYbU1CU1Vx?=
 =?utf-8?B?aVlINEdnajJkQ1JJcTQ2NHVac1hFVS9YTStRMVFOclhIUFRxOG9rd28zTDdl?=
 =?utf-8?B?TkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B935061B4B356D45A877DA3191CA21CE@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29be76d8-5246-4fff-9594-08dcc6f5991e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 00:08:51.7672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OH0ffMSTvP3blfhljMNY4Eu1iyQfOKy4UNOQzBsLgP7yAV5l7FqlWDYDnPrTRZ1o1WhJFdG1cxrKKQzr17Ar2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB6037

T24gV2VkLCAyMDI0LTA4LTI4IGF0IDA5OjQxICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFdlZCwgMjggQXVnIDIwMjQsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiBPbiBXZWQsIDIw
MjQtMDgtMjggYXQgMDc6NDkgKzEwMDAsIE5laWxCcm93biB3cm90ZToNCj4gPiA+IE9uIFR1ZSwg
MjcgQXVnIDIwMjQsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+IE9uIEF1ZyAyNSwgMjAyNCwgYXQgOTo1NuKAr1BNLCBOZWlsQnJvd24g
PG5laWxiQHN1c2UuZGU+DQo+ID4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gV2hpbGUgSSdtIG5vdCBhZHZvY2F0aW5nIGZvciBhbiBvdmVyLXRoZS13aXJlIHJlcXVl
c3QgdG8NCj4gPiA+ID4gPiA+IG1hcCBhDQo+ID4gPiA+ID4gPiBmaWxlaGFuZGxlIHRvIGEgc3Ry
dWN0IG5mc2RfZmlsZSosIEkgZG9uJ3QgdGhpbmsgeW91IGNhbg0KPiA+ID4gPiA+ID4gY29udmlu
Y2luZ2x5DQo+ID4gPiA+ID4gPiBhcmd1ZSBhZ2FpbnN0IGl0IHdpdGhvdXQgY29uY3JldGUgcGVy
Zm9ybWFuY2UgbWVhc3VyZW1lbnRzLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gV2hh
dCBpcyB0aGUgdmFsdWUgb2YgZG9pbmcgYW4gb3BlbiBvdmVyIHRoZSB3aXJlPyBXaGF0IGFyZSB5
b3UNCj4gPiA+ID4gdHJ5aW5nDQo+ID4gPiA+IHRvIGFjY29tcGxpc2ggdGhhdCBjYW4ndCBiZSBh
Y2NvbXBsaXNoZWQgd2l0aG91dCBnb2luZyBvdmVyIHRoZQ0KPiA+ID4gPiB3aXJlPw0KPiA+ID4g
DQo+ID4gPiBUaGUgYWR2YW50YWdlIG9mIGdvaW5nIG92ZXIgdGhlIHdpcmUgaXMgYXZvaWRpbmcg
Y29kZQ0KPiA+ID4gZHVwbGljYXRpb24uDQo+ID4gPiBUaGUgY29zdCBpcyBsYXRlbmN5LsKgIE9i
dmlvdXNseSB0aGUgZ29hbCBvZiBMT0NBTElPIGlzIHRvIGZpbmQNCj4gPiA+IHRob3NlDQo+ID4g
PiBwb2ludHMgd2hlcmUgdGhlIGxhdGVuY3kgc2F2aW5nIGp1c3RpZmllcyB0aGUgY29kZSBkdXBs
aWNhdGlvbi4NCj4gPiA+IA0KPiA+ID4gV2hlbiBvcGVuaW5nIHdpdGggQVVUSF9VTklYIHRoZSBj
b2RlIGR1cGxpY2F0aW9uIHRvIGRldGVybWluZSB0aGUNCj4gPiA+IGNvcnJlY3QgY3JlZGVudGlh
bCBpcyBzbWFsbCBhbmQgZWFzeSB0byByZXZpZXcuwqAgSWYgd2UgZXZlcg0KPiA+ID4gd2FudGVk
IHRvDQo+ID4gPiBzdXBwb3J0IEtSQjUgb3IgVExTIEkgd291bGQgYmUgYSBsb3QgbGVzcyBjb21m
b3J0YWJsZSBhYm91dA0KPiA+ID4gcmV2aWV3aW5nDQo+ID4gPiB0aGUgY29kZSBkdXBsaWNhdGlv
bi4NCj4gPiA+IA0KPiA+ID4gU28gSSB0aGluayBpdCBpcyB3b3J0aCBjb25zaWRlcmluZyB3aGV0
aGVyIGFuIG92ZXItdGhlLXdpcmUgb3Blbg0KPiA+ID4gaXMNCj4gPiA+IHJlYWxseSBhbGwgdGhh
dCBjb3N0bHkuwqAgQXMgSSBub3RlZCB3ZSBhbHJlYWR5IGhhdmUgYW4gb3Zlci10aGUtDQo+ID4g
PiB3aXJlDQo+ID4gPiByZXF1ZXN0IGF0IG9wZW4gdGltZS7CoCBXZSBjb3VsZCBjb25jZWl2YWJs
eSBzZW5kIHRoZSBMT0NBTElPLU9QRU4NCj4gPiA+IHJlcXVlc3QgYXQgdGhlIHNhbWUgdGltZSBz
byBhcyBub3QgdG8gYWRkIGxhdGVuY3kuwqAgV2UgY291bGQNCj4gPiA+IHJlY2VpdmUNCj4gPiA+
IHRoZQ0KPiA+ID4gcmVwbHkgdGhyb3VnaCB0aGUgaW4ta2VybmVsIGJhY2tjaGFubmVsIHNvIHRo
ZXJlIGlzIG5vIFJQQyByZXBseS4NCj4gPiA+IA0KPiA+ID4gVGhhdCBtaWdodCBhbGwgYmUgdG9v
IGNvbXBsZXggYW5kIG1pZ2h0IG5vdCBiZSBqdXN0aWZpZWQuwqAgTXkNCj4gPiA+IHBvaW50DQo+
ID4gPiBpcw0KPiA+ID4gdGhhdCBJIHRoaW5rIHRoZSB0cmFkZS1vZmZzIGFyZSBzdWJ0bGUgYW5k
IEkgdGhpbmsgdGhlIEZBUSBhbnN3ZXINCj4gPiA+IGN1dHMNCj4gPiA+IG9mZiBhbiBhdmVudWUg
dGhhdCBoYXNuJ3QgcmVhbGx5IGJlZW4gZXhwbG9yZWQuDQo+ID4gPiANCj4gPiANCj4gPiBTbywg
eW91ciBhcmd1bWVudCBpcyB0aGF0IGlmIHRoZXJlIHdhcyBhIGh5cG90aGV0aWNhbCBzaXR1YXRp
b24NCj4gPiB3aGVyZQ0KPiA+IHdlIHdhbnRlZCB0byBhZGQga3JiNSBvciBUTFMgc3VwcG9ydCwg
dGhlbiB3ZSdkIGhhdmUgbW9yZSBjb2RlIHRvDQo+ID4gcmV2aWV3Pw0KPiA+IA0KPiA+IFRoZSBj
b3VudGVyLWFyZ3VtZW50IHdvdWxkIGJlIHRoYXQgd2UndmUgYWxyZWFkeSBlc3RhYmxpc2hlZCB0
aGUNCj4gPiByaWdodA0KPiA+IG9mIHRoZSBjbGllbnQgdG8gZG8gSS9PIHRvIHRoZSBmaWxlLiBU
aGlzIHdpbGwgYWxyZWFkeSBoYXZlIGJlZW4NCj4gPiBkb25lDQo+ID4gYnkgYW4gb3Zlci10aGUt
d2lyZSBjYWxsIHRvIE9QRU4gKE5GU3Y0KSwgQUNDRVNTIChORlN2My9ORlN2NCkgb3INCj4gPiBD
UkVBVEUgKE5GU3YzKS4gVGhvc2UgY2FsbHMgd2lsbCBoYXZlIHVzZWQga3JiNSBhbmQvb3IgVExT
IHRvDQo+ID4gYXV0aGVudGljYXRlIHRoZSB1c2VyLiBBbGwgdGhhdCByZW1haW5zIHRvIGJlIGRv
bmUgaXMgcGVyZm9ybSB0aGUNCj4gPiBJL08NCj4gPiB0aGF0IHdhcyBhdXRob3Jpc2VkIGJ5IHRo
b3NlIGNhbGxzLg0KPiANCj4gVGhlIG90aGVyIHRoaW5nIHRoYXQgcmVtYWlucyBpcyB0byBnZXQg
dGhlIGNvcnJlY3QgJ3N0cnVjdCBjcmVkIConIHRvDQo+IHN0b3JlIGluIC0+Zl9jcmVkIChvciB0
byB1c2UgZm9yIGxvb2t1cCBpbiB0aGUgbmZzZCBmaWxlY2FjaGUpLg0KDQpUaGlzIHdhcyB3aHkg
dGhlIG9yaWdpbmFsIGNvZGUgY2FsbGVkIHVwIGludG8gdGhlIHN1bnJwYyBzZXJ2ZXIgZG9tYWlu
DQpjb2RlLCBhbmQgaGVuY2UgZGlkIGNvbnN1bHQgd2l0aCBtb3VudGQgd2hlbiBuZWVkZWQuIElz
IHRoZXJlIGFueQ0KcmVhc29uIHRvIGJlbGlldmUgdGhhdCB3ZSBzaG91bGRuJ3QgYmUgYWJsZSB0
byBkbyB0aGUgc2FtZSB3aXRoIGZ1dHVyZQ0Kc2VjdXJpdHkgbW9kZWxzPw0KQXMgSSBzYWlkLCB0
aGUgY2xpZW50IGhhcyBkaXJlY3QgYWNjZXNzIHRvIGFsbCB0aGUgUlBDU0VDX0dTUy9UTFMNCnNl
c3Npb24gaW5mbywgb3Igb3RoZXIgaW5mbyB0aGF0IG1pZ2h0IGJlIG5lZWRlZCB0byBsb29rIHVw
IHRoZQ0KY29ycmVzcG9uZGluZyBpbmZvcm1hdGlvbiBpbiBrbmZzZC4gSW4gdGhlIHdvcnN0IGNh
c2UsIHdlIGNvdWxkIGZhbGwNCmJhY2sgdG8gc2VuZGluZyBvbi10aGUtd2lyZSBpbmZvIHVudGls
IHRoZSByZWxldmFudCBjb250ZXh0IGluZm9ybWF0aW9uDQpoYXMgYmVlbiByZS1lc3RhYmxpc2hl
ZC4NCg0KPiANCj4gPiANCj4gPiBGdXJ0aGVybW9yZSwgd2UnZCBhbHJlYWR5IGhhdmUgZXN0YWJs
aXNoZWQgdGhhdCB0aGUgY2xpZW50IGFuZCB0aGUNCj4gPiBrbmZzZCBpbnN0YW5jZSBhcmUgcnVu
bmluZyBpbiB0aGUgc2FtZSBrZXJuZWwgc3BhY2Ugb24gdGhlIHNhbWUNCj4gPiBoYXJkd2FyZSAo
d2hldGhlciByZWFsIG9yIHZpcnR1YWxpc2VkKS4gVGhlcmUgaXMgbm8gY2hhbmNlIGZvciBhDQo+
ID4gYmFkDQo+ID4gYWN0b3IgdG8gY29tcHJvbWlzZSB0aGUgb25lIHdpdGhvdXQgYWxzbyBjb21w
cm9taXNpbmcgdGhlIG90aGVyLg0KPiA+IEhvd2V2ZXIsIGxldCdzIGFzc3VtZSB0aGF0IHNvbWVo
b3cgaXMgcG9zc2libGU6IEhvdyBkb2VzIHRocm93aW5nDQo+ID4gaW4gYW4NCj4gPiBvbi10aGUt
d2lyZSBwcm90b2NvbCB0aGF0IGlzIGluaXRpYXRlZCBieSB0aGUgb25lIGFuZCBpbnRlcnByZXRl
ZA0KPiA+IGJ5DQo+ID4gdGhlIG90aGVyIGdvaW5nIHRvIGhlbHAsIGdpdmVuIHRoYXQgYm90aCBo
YXZlIGFjY2VzcyB0byB0aGUgZXhhY3QNCj4gPiBzYW1lDQo+ID4gUlBDU0VDX0dTUy9UTFMgc2Vz
c2lvbiBhbmQgc2hhcmVkIHNlY3JldCBpbmZvcm1hdGlvbiB2aWEgc2hhcmVkDQo+ID4ga2VybmVs
DQo+ID4gbWVtb3J5Pw0KPiA+IA0KPiA+IFNvIGFnYWluLCB3aGF0IHByb2JsZW0gYXJlIHlvdSB0
cnlpbmcgdG8gZml4Pw0KPiANCj4gQ29udmVyc2VseTrCoCB3aGF0IGV4YWN0bHkgaXMgdGhpcyBG
QVEgZW50cnkgdHJ5aW5nIHRvIGFyZ3VlIGFnYWluc3Q/DQo+IA0KPiBNeSBjdXJyZW50IGltbWVk
aWF0ZSBnb2FsIGlzIGZvciB0aGUgRkFRIHRvIGJlIHVzZWZ1bC7CoCBJdCBtb3N0bHkgaXMsDQo+
IGJ1dCB0aGlzIG9uZSBxdWVzdGlvbi9hbnN3ZXIgaXNuJ3QgY2xlYXIgdG8gbWUuDQoNClRoZSBx
dWVzdGlvbiBhcm9zZSBmcm9tIHRoZSBmZWVkYmFjayB3aGVuIE1pa2Ugc3VibWl0dGVkIHRoZSBl
YXJsaWVyDQpkcmFmdHMgaW4gdGhlIGJlZ2lubmluZyBvZiBKdWx5LiBJIHdhcyBvbiB2YWNhdGlv
biBhdCB0aGUgdGltZSwgYnV0IG15DQp1bmRlcnN0YW5kaW5nIGlzIHRoYXQgc2V2ZXJhbCBwZW9w
bGUgKGluY2x1ZGluZyBzb21lIGxpc3RlZCBpbiB0aGUNCk1BSU5UQUlORVJTIGZpbGUpIHdlcmUg
YXNraW5nIHF1ZXN0aW9uYSBhYm91dCBob3cgdGhlIGNvZGUgd291bGQNCnN1cHBvcnQgUlBDU0VD
X0dTUyBhbmQgVExTLiBUaGUgRkFRIGVudHJ5IGlzIGEgZGlyZWN0IHJlc3BvbnNlIHRvIHRob3Nl
DQpxdWVzdGlvbnMuDQoNCkknbSBoYXBweSB0byBhc2sgTWlrZSB0byBkcm9wIHRoYXQgZW50cnkg
aWYgZXZlcnlvbmUgYWdyZWVzIHRoYXQgaXQgaXMNCnJlZHVuZGFudCwgYnV0IHRoZSBwb2ludCBp
cyB0aGF0IGF0IHRoZSB0aW1lLCB0aGVyZSB3YXMgYSBzZXQgb2YNCnF1ZXN0aW9ucyBhcm91bmQg
dGhpcywgYW5kIHRoZXkgd2VyZSBjbGVhcmx5IGJsb2NraW5nIHRoZSBhYmlsaXR5IHRvDQpzdWJt
aXQgdGhlIGNvZGUgZm9yIG1lcmdpbmcuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBO
RlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVy
c3BhY2UuY29tDQoNCg0K

