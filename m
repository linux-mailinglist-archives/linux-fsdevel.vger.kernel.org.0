Return-Path: <linux-fsdevel+bounces-38917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F53A09CCE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 22:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86A416886F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 21:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD48208983;
	Fri, 10 Jan 2025 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WAzRjjeS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AB62080F2;
	Fri, 10 Jan 2025 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736543296; cv=fail; b=FJ59nLDdPRJbpB6u8MHY6oWdnqAFtEZ8qfvJ7eXa72Z1fJHfaRELiFlzSRe6Jya4sXKAmC0Mbnv16aXwqgQ9p5VpVEsmfv5MiaHNACGE09VRe+a0Wdtmp4QYi7lzqK0whX/CpjhePfzykrbL2JwT1CfKU/dGdCvIlYrXuqykEj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736543296; c=relaxed/simple;
	bh=DGq12vO80zkMD+7Xs2jCVqt4wUdnbLAExZv5791ObLM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L6x3TSSLgnWOVxRQ5vlRm1yIGucho1iHhMVfZyT4GvJ0tQeik2L4lGu9UQU+QwApgQpUDzhs42aaokx9RS6elqVVPZ7Wzkin4L1AsQ20HmUUYWskVuHFa9quNjjhVTokWKWca1/Kt86wnHr9377SZPB4ViBBIHlUnmVc5LuYRX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WAzRjjeS; arc=fail smtp.client-ip=40.107.237.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDzx+a/fqoHgELri40DtecZb5+dUcjiCAo/r1wcxESp7IY9YWxgQUB8JjrRpttRqCDAEQmYXia/n+pxrVUQCcZx3JO9cIKx5BQ5jS6SmKp3s1ATCOn2PwnRFe+ETQHqxN6GzqFvYHk7nsRgdynBP8+1zIBMI0MyNEEhed0G41M6Qkv1fiyqKReDxNHM5AsAAlwbWvzyJomx/9nizXtlU9HKVbA8kp+UUAdFa3agrmgSVyxc4j+9TuPUm0iUEAmWgR7w4MWCdnIbgBNuBZ//30BuWzCNudWAYSUG4OOP5mx2DgQGr2BXzse6Y84cLLaALoGIG4L8cygimT+wuXeiA5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSfg84KfS2/DuFe8JuJZo5twuYnNeLPGmVj+vl9Es2c=;
 b=YXzQBXWsJJ5X2toqZT3CoJHo6OWELaAlj9OhBha43EGoF5y6OQf9dG3gG2n9Qrt7RV1e8v4M2wzzZAJFvEkOSc/b+sto0K73IW9bAsvCnEDsl6ebJW0veSpKNh+3TyaTxK5uN+cPmbmoq7yRGZ1J9T/Ob+HjLdbexWkb7ywmeiwi9gHuj05iTzUmt4c0KTNdX3mA7rMoJ7eGl14Eqdgz2aWCl7GshH4d6HkcUJx8ExZipQZr3g2DlprUtPbrJOvO73lbs77mlhuMszk5LNi1XZq4EgNrGPlo+UF5HHP7N52QOe4+3hk4ulykGe+1Fu+2UoEf+gQnHcn+MYuKsE3KfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSfg84KfS2/DuFe8JuJZo5twuYnNeLPGmVj+vl9Es2c=;
 b=WAzRjjeS1kIAP0E5p16pH5QbLhJfbtxSYOlsW4z5lH6NyqDTB17LNvxRwmtF7Rp5lEVnOTtyugRvmCNJj57qLoCswGMM5Sh93BY4tZIrfFxMqnvm5vlmj2cXNpMvCxxN7A1ey/xa28F/GqWn5irkQgBZdSjxMqWyUX6/2YmNkuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB5672.namprd12.prod.outlook.com (2603:10b6:806:23c::5)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.10; Fri, 10 Jan 2025 21:08:12 +0000
Received: from SA1PR12MB5672.namprd12.prod.outlook.com
 ([fe80::60f:5e8d:f0da:4eca]) by SA1PR12MB5672.namprd12.prod.outlook.com
 ([fe80::60f:5e8d:f0da:4eca%4]) with mapi id 15.20.8335.010; Fri, 10 Jan 2025
 21:08:12 +0000
Message-ID: <7cf9f0fd-279e-4e4d-99ac-966a752090a2@amd.com>
Date: Fri, 10 Jan 2025 15:08:08 -0600
User-Agent: Mozilla Thunderbird
Reply-To: michael.day@amd.com
Subject: Re: [RFC PATCH 2/2] KVM: guest_memfd: use filemap_grab_folios in
 write
To: Nikita Kalyazin <kalyazin@amazon.com>, willy@infradead.org,
 pbonzini@redhat.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: david@redhat.com, jthoughton@google.com, michael.roth@amd.com,
 ackerleytng@google.com, graf@amazon.de, jgowans@amazon.com,
 roypat@amazon.co.uk, derekmn@amazon.com, nsaenz@amazon.es,
 xmarcalx@amazon.com
References: <20250110154659.95464-1-kalyazin@amazon.com>
 <20250110154659.95464-3-kalyazin@amazon.com>
From: Mike Day <michael.day@amd.com>
Content-Language: en-US
In-Reply-To: <20250110154659.95464-3-kalyazin@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0045.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::22) To SA1PR12MB5672.namprd12.prod.outlook.com
 (2603:10b6:806:23c::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB5672:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c2d9731-3f37-4fa6-fed3-08dd31bae431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUFyaGhMM0ZMMUNmS2drQjhJWW5MSGQ0WDZ6QitZS2NZUVVrL2tXbHYydEcy?=
 =?utf-8?B?bUZBS3JlRDZhbUtmay9TRWs5dk9TS29FMmVPZjE4UlJBV0gzQ3owdnRMaEQ4?=
 =?utf-8?B?ZHJydTlSQ2VacGJHclJQYnU2K2hVKzJwK29pMXlsUzFMbjJaUDMzTFk0WVkx?=
 =?utf-8?B?aG1NTlIveHRaVEh0dDV3ODJzQm5lYUI2eEt6OEQzSVA4QUUwQVcrblREYVpl?=
 =?utf-8?B?T1g3Q1dPTWxCVmlKT3VIYXV0OEI3em9zd242TXR4aTg4bGpXaGFDWFFaaUVu?=
 =?utf-8?B?WFpYWFY0VUVhUDZ6cUgrckJWYXZUZzYzRS9OdnRzTGl0YVlMT0FFcjlPd3dB?=
 =?utf-8?B?a3B4K1RrMjB2K0JPSjM5ZnZNTkNSemNhUnNTb2w4b0JkdXAzak1RWHZjdTVj?=
 =?utf-8?B?RHZtYXZNT21teXZPZ0ZjVnc0MHM3WE01SUxnRUhLYkJndE9zRHJVTmlGT05N?=
 =?utf-8?B?QUxOMVRndVJaUXJLaHNUNXNpbkgxWUp6T0ZkM3J3VUtnL29MZ1JTS05xMktj?=
 =?utf-8?B?M1dWMDdpdUtEaE9hT1Y1d2FtZlUwbVV1ODdoTjNHT0N1Wkk2V1haWjFocWRZ?=
 =?utf-8?B?UnFnYzdYUGRkVG5qLzBiZ0Z2dHEzU21hMEpNbEdXMXdqNXh3dHZ0c1dQTGs1?=
 =?utf-8?B?eHdkaS83TkNjUklyYVdnTnRsTTBkaE9MNEk2d3JXUXVQdUF1RmJmZjRWcmd4?=
 =?utf-8?B?Z0VnNFE2a3V6YzdXNkxpeUo3RExERUZRSHRmUVdwdXlmZkFZWWlBZ2NhdXZZ?=
 =?utf-8?B?cTVmYlEveUEwcG1YV0pkZHc0d0lya3BzVXMra3dDZ3NZL1M2N2g4Mno4elUy?=
 =?utf-8?B?N3JPZklqYWF2em9NZWRjL2pNNzVDWXlBRnZZWWcrYlloeCtEbTk4a1ZoVGhI?=
 =?utf-8?B?RFZaK0UrUnlPQ1hnem1nWS9zVlAwd2t4a09Vb1RVK2Q4aGtFSEx6aDExTjFH?=
 =?utf-8?B?SlNNWEtQM3Q0RjFjd21DSGIweld0Q1Nsek40cjdURGNGejc0UDNaMXNYK1ZT?=
 =?utf-8?B?cFRVRklscUtCTi9JVzJNV05uRGxtUCtTR0VuMlNLVWRod0k0Wk4yb1poK2VO?=
 =?utf-8?B?OW96OWlUZkZPRFVaYUEyYjJlai9OTTZuREJZNnRzYXgxTk5McU9kbDR0YllK?=
 =?utf-8?B?RERzSjczK2lhdDU5dEtFaDl1aU0zRmN3dDJKUHljU2o4TnZPV1F3K3ZVSS80?=
 =?utf-8?B?ajB0Rmc0b28zcWo0SldkT1p6Slc5SkZZUUsvMkdxVUNvNDZRRXhTOXIvd2xu?=
 =?utf-8?B?cG42cUtJUFUwUFBKakFBakE5QUdGcy9RQ3puc1BHeGZIamVxcFNHZFZ4SkNr?=
 =?utf-8?B?OEl2NTVlc2FMVnlRM1VxbGlNSWFHOTBWY29yZUU1eXduNGdmWnBPa1VBZkxC?=
 =?utf-8?B?L0NOQmhQTXpObEM2Y0dxWnVCYTRxbCtUMDRmOTVSR3V5NzI2NWRWRmdXWFFM?=
 =?utf-8?B?YWM4enFBajhjQ29kSmIrS0dnL3NhOUMwald5Q0tublUxMXNpSDJKU0p3RmJu?=
 =?utf-8?B?SGZ4U25iODdqTW9QSDlkNWRNZ0QzRXZtTmhldTZoZ0kvVC9aS1FHR2tCVnJZ?=
 =?utf-8?B?UDVLVTYxNkhQeUhFZFBtMklUK3dtaVFVSytwek1VZ2tYTndVZDU5YUhKb051?=
 =?utf-8?B?T2VvenRWTUYwNGJDeFF1S1ZiUFkxWVlLQllHbEN3b3E5cHZJNk4xSjVpT2Jo?=
 =?utf-8?B?WHdoSGdNQThJSWg3ekdKWkw1S096TzQwQUcrbVlwWEZpQnpMRUhmb2xHKzB3?=
 =?utf-8?B?NDRsTE5UbVlVdE04bldaa3R1WEVjbkNJUUZ5L28waEVkcWZGb1AvRTg0eU14?=
 =?utf-8?B?RzBDejJOcTRsZGV5cE5lY2dEa25UYWlLNXcrSmxTNUc1a1pqZXkxWHRXVllK?=
 =?utf-8?Q?0YVSSIfDUdqHe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB5672.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVoxck1lbWx1NVdhOTg0VTU0UGU1cnVBeVdTUDFFUUxBL1VRZVloK1Q5MUhu?=
 =?utf-8?B?VzZTQlZZRUxvc0lVcEVrdUZXbW9vY1hqK2lXazZ5L0VaVzdaY3BIS2VYUGZn?=
 =?utf-8?B?Y0xvSi9od2NVQmUvT3VJVXVzelEvYWszVHJiS1h5RmJrYlZRZFJvbitNS0ow?=
 =?utf-8?B?OTBmcGZzaHFFNi82cmV4czhmYmVkdlVidHR2enpBajlYa2xjLzdTbUFsUUJ3?=
 =?utf-8?B?YXJTTXRoVjZLbFd3SUhrbGlTeXFydDF6ei8raHlJU2NDaERnMHBla0pwV0Zx?=
 =?utf-8?B?K1pQWTFEbGp2K0I5YXNnSXNnTUU0Ym9SZWZPYlNQY0FldCs0eEpJMytVUWV0?=
 =?utf-8?B?UzN4MmhRMWxaRWNtNk9RSGZyZEZqeDgzWlU1V0ZIc3h0ZkpOQlBwT3NZVWZJ?=
 =?utf-8?B?WHFJMVV3QkdKaW9vT1pwWWkrV2JKQUNxc0N1UDdUVS9HUlMvS3A1TEF6TUxO?=
 =?utf-8?B?ZFAvV25JclcraHRrb3dZUWxVakNmVXFEaVNNbWw4UEwvTit5dms2dmRwRlFF?=
 =?utf-8?B?RGxGaktkWGlRNld0WXVmSFJKWWZKakdybFBod3NET0Z4Sjgwb3c1Z3R6Njdl?=
 =?utf-8?B?NXNGNUZac0Y2b2t0OWMrMTR1NmpWWWQwemlFelA4S1gxcEM0azlsM28rNlA2?=
 =?utf-8?B?ck8rS2ZOU241TXh6WEkyT0I3d3dzamZDcElnUFdvY0ZCSDVUTEZFY0Q0MGlI?=
 =?utf-8?B?U1R2NHlLZFQvN1FHQXE5RDY0RUFUUmZ6bVByU21zY2lrRFZVS1I4UFpCNGpT?=
 =?utf-8?B?SmoxTXBqTmdYaitWTEJPeU9ocmhVVmw3UEM4eHlXZXQycVlFQzNLSFQwanY4?=
 =?utf-8?B?L2JrMlJwdHlhOS9aRGZobEhTdHF1dHRVWngzSGxBQjJudlRIanZUdzdXdDhz?=
 =?utf-8?B?WHExYTBSdDZMRlI2d1lCcWJSaU9tZWZMSGlUOFpGQVhiRC9wK1lCSDRrcTV6?=
 =?utf-8?B?VmxqMklnZi9OQmxkY1k4ZjdCNU5FaGJJQVpwblBhc2tuQnlTbldxZ0Y5VWRW?=
 =?utf-8?B?dUNORXZCYVBZMTVaeHNZTFgrWE5lbHlCenMrdUc1c0dXbVFNTUVFeDFVdytW?=
 =?utf-8?B?eUtzaHozNThQcGc0WkVKb2NjS2F5bE5UUWcxT2lVNmlMYzMybERTWGZjaGEy?=
 =?utf-8?B?WFZaZ2tvTVgyYmpVUithVmxHQVk1VWtBV3h2Y3NVakJ2K1JsMmtnSktmMXRR?=
 =?utf-8?B?aUp4U0c4UGtOL1NoNUZFcXF0UU03YzFMWDdUOW13V0VmRm5TUnF1UUV5dGlN?=
 =?utf-8?B?ejJKa3pmdTBPOVduS3llTGNTYlUxb0l4TzVYbEYyWVYzQ01XdUNQLytVWGg2?=
 =?utf-8?B?aENxOGNTbTVQdkFWN3RoNGNiNk1ua0U1enhoN1lUbCtLd0NXSW4xUytLWWdm?=
 =?utf-8?B?cXMrUE93WUZPd29zR3JWRUFDN29Mb2hpYUFyTVZpZWJFM0FWdmFkbFdlUkoz?=
 =?utf-8?B?UG9aKzFoUVM1NHozTEdoaTRlMU1NdkdqQzR2Y3oxMlZWVzZKcjdlejlQZnM3?=
 =?utf-8?B?VzBodjBsa0lhQWZGMTQ4V2hTQXgvZkdJTHJna2pWK0o2WmhkTXBGRmsrMExq?=
 =?utf-8?B?cEJINnc4cGRCMnlIdjdlZGtGRXNaOWluYWVPUkUzQW02OUdYUGVrL1N6ajZy?=
 =?utf-8?B?VmMrS2tIZ043TzNzR2dVNEVsRjhYcHJGTDVsMGIrVFVXZnlIdHZDTUJBQzZk?=
 =?utf-8?B?WStWaDJNaGQrcGRqS1AwTGNrMWlyU2pQaHpEOTVDaFNSY0lDSzhsako4UHgx?=
 =?utf-8?B?a3psWjFYOEQ3YlZveVArbW5NK0YzVURHNHd1Qlg1UDhvd29PSDB3S3lZNzdq?=
 =?utf-8?B?MnJxUjAzeXRTZmxkY0hlSUVYcE5QZ24xeGFNaFFZUkpuNkgyaW5pZmdSTGk3?=
 =?utf-8?B?T3ROUDhNZGFOMGt4RU9haVJ6SFo3Sm84Szd4d3crYXRCZzI0R1RHNkVjcmoz?=
 =?utf-8?B?L2I1Y2VOWEN5ejhOcWdQSHF5OEhxU203eFhFZzJtYk1aL3VtZGk0Zitzc291?=
 =?utf-8?B?QXlUaUFIME4zZHMvMU4zRmh0RmNNdEtpREpqY1dIRUVXS21VVUVMcG9jbWVG?=
 =?utf-8?B?VmFCSXVpZ0ZxUjVRalhINmMxaXQ4eFV6RmJHaXY2WHBTTU5ZSzU3S2VEWVQ4?=
 =?utf-8?Q?/FtOmlTRqm8wS7skVfiBmfRxF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2d9731-3f37-4fa6-fed3-08dd31bae431
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5672.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 21:08:11.9798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWyiRRRN7VRGr8g52A2dguFz3mb9QmRYHem129aFpJZRKh7HFlnv9QK27ys6/IXEvcx+4DwB4OeakPSkgnTBlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963



On 1/10/25 09:46, Nikita Kalyazin wrote:
> The write syscall on guest_memfd makes use of filemap_grab_folios to
> grab folios in batches.  This speeds up population by 8.3% due to the
> reduction in locking and tree walking when adding folios to the
> pagecache.
> 
> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
> ---
>   virt/kvm/guest_memfd.c | 176 +++++++++++++++++++++++++++++++++--------
>   1 file changed, 143 insertions(+), 33 deletions(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index e80566ef56e9..ccfadc3a7389 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -102,17 +102,134 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>   	return filemap_grab_folio(inode->i_mapping, index);
>   }
>   
> +/*
> + * Returns locked folios on success.  The caller is responsible for
> + * setting the up-to-date flag before the memory is mapped into the guest.
> + * There is no backing storage for the memory, so the folios will remain
> + * up-to-date until they're removed.
> + *
> + * Ignore accessed, referenced, and dirty flags.  The memory is
> + * unevictable and there is no storage to write back to.
> + */
> +static int kvm_gmem_get_folios(struct inode *inode, pgoff_t index,
> +			       struct folio **folios, int num)
> +{
> +	return filemap_grab_folios(inode->i_mapping, index, folios, num);
> +}
> +
>   #if defined(CONFIG_KVM_GENERIC_PRIVATE_MEM) && !defined(CONFIG_KVM_AMD_SEV)
> +static int kvm_kmem_gmem_write_inner(struct inode *inode, pgoff_t index,
> +				     const void __user *buf,
> +                                     struct folio **folios, int num)
> +{
> +	int ret, i, num_grabbed, num_written;
> +
> +	num_grabbed = kvm_gmem_get_folios(inode, index, folios, num);
> +	if (num_grabbed < 0)
> +		return num_grabbed;
> +
> +	for (i = 0; i < num_grabbed; i++) {
> +		struct folio *folio = folios[i];
> +		void *vaddr;
> +
> +		if (folio_test_hwpoison(folio)) {
> +			folio_unlock(folio);
> +			folio_put(folio);
> +			ret = -EFAULT;
> +			break;
> +		}
> +
> +		if (folio_test_uptodate(folio)) {
> +			folio_unlock(folio);
> +			folio_put(folio);
> +			ret = -ENOSPC;
> +			break;
> +		}
> +
> +		folio_unlock(folio);
> +
> +		vaddr = kmap_local_folio(folio, 0);
> +		ret = copy_from_user(vaddr, buf + (i << PAGE_SHIFT), PAGE_SIZE);
> +		if (ret)
> +			ret = -EINVAL;
> +		kunmap_local(vaddr);
> +
> +		if (ret) {
> +			folio_put(folio);
> +			break;
> +		} else {
> +			kvm_gmem_mark_prepared(folio);
> +			folio_put(folio);
> +		}
> +	}
> +
> +	num_written = i;
> +
> +	for (i = num_written; i < num_grabbed; i++) {
> +		folio_unlock(folios[i]);
> +		folio_put(folios[i]);
> +	}
> +
> +	return num_written ?: ret;
> +}
> +
> +static struct folio *kvm_kmem_gmem_write_folio(struct inode *inode, pgoff_t index,
> +					       const char __user *buf)
> 

This could probably be rewritten as:

	struct folio *p_folio;
	int ret;

	ret = kvm_kmem_gmem_write_inner(inode, index, buf, &p_folio, 1);
	
	if (ret == 1)
		return p_folio;
	else
		return ERR_PTR(ret);

Would remove a few lines of duplicated code and use only one prototype.

Mike

+{
> +	struct folio *folio;
> +	void *vaddr;
> +	int ret = 0;
> +
> +	folio = kvm_gmem_get_folio(inode, index);
> +	if (IS_ERR(folio))
> +		return ERR_PTR(-EFAULT);
> +
> +	if (folio_test_hwpoison(folio)) {
> +		ret = -EFAULT;
> +		goto out_unlock_put;
> +	}
> +
> +	if (folio_test_uptodate(folio)) {
> +		ret = -ENOSPC;
> +		goto out_unlock_put;
> +	}
> +
> +	folio_unlock(folio);
> +
> +	vaddr = kmap_local_folio(folio, 0);
> +	ret = copy_from_user(vaddr, buf, PAGE_SIZE);
> +	if (ret)
> +		ret = -EINVAL;
> +	kunmap_local(vaddr);
> +
> +	if (ret) {
> +		folio_put(folio);
> +		kvm_gmem_mark_prepared(folio);
> +		goto out_err;
> +	}
> +
> +	folio_put(folio);
> +
> +	return folio;
> +
> +out_unlock_put:
> +	folio_unlock(folio);
> +	folio_put(folio);
> +out_err:
> +	return ERR_PTR(ret);
> +}
> +
>   static ssize_t kvm_kmem_gmem_write(struct file *file, const char __user *buf,
>   				   size_t count, loff_t *offset)
>   {
> +	struct inode *inode = file_inode(file);
> +	int ret = 0, batch_size = FILEMAP_GET_FOLIOS_BATCH_SIZE;
>   	pgoff_t start, end, index;
> -	ssize_t ret = 0;
>   
>   	if (!PAGE_ALIGNED(*offset) || !PAGE_ALIGNED(count))
>   		return -EINVAL;
>   
> -	if (*offset + count > i_size_read(file_inode(file)))
> +	if (*offset + count > i_size_read(inode))
>   		return -EINVAL;
>   
>   	if (!buf)
> @@ -123,9 +240,8 @@ static ssize_t kvm_kmem_gmem_write(struct file *file, const char __user *buf,
>   
>   	filemap_invalidate_lock(file->f_mapping);
>   
> -	for (index = start; index < end; ) {
> -		struct folio *folio;
> -		void *vaddr;
> +	for (index = start; index + batch_size - 1 < end; ) {
> +		struct folio *folios[FILEMAP_GET_FOLIOS_BATCH_SIZE] = { NULL };
>   		pgoff_t buf_offset = (index - start) << PAGE_SHIFT;
>   
>   		if (signal_pending(current)) {
> @@ -133,46 +249,40 @@ static ssize_t kvm_kmem_gmem_write(struct file *file, const char __user *buf,
>   			goto out;
>   		}
>   
> -		folio = kvm_gmem_get_folio(file_inode(file), index);
> -		if (IS_ERR(folio)) {
> -			ret = -EFAULT;
> +		ret = kvm_kmem_gmem_write_inner(inode, index, buf + buf_offset, folios, batch_size);
> +		if (ret < 0)
>   			goto out;
> -		}
>   
> -		if (folio_test_hwpoison(folio)) {
> -			folio_unlock(folio);
> -			folio_put(folio);
> -			ret = -EFAULT;
> +		index += ret;
> +		if (ret < batch_size)
> +			break;
> +	}
> +
> +	for (; index < end; index++) {
> +		struct folio *folio;
> +		pgoff_t buf_offset = (index - start) << PAGE_SHIFT;
> +
> +		if (signal_pending(current)) {
> +			ret = -EINTR;
>   			goto out;
>   		}
>   
> -		if (folio_test_uptodate(folio)) {
> -			folio_unlock(folio);
> -			folio_put(folio);
> -			ret = -ENOSPC;
> +		folio = kvm_kmem_gmem_write_folio(inode, index,
> +						  buf + buf_offset);
> +		if (IS_ERR(folio)) {
> +			ret = PTR_ERR(folio);
>   			goto out;
>   		}
> -
> -		folio_unlock(folio);
> -
> -		vaddr = kmap_local_folio(folio, 0);
> -		ret = copy_from_user(vaddr, buf + buf_offset, PAGE_SIZE);
> -		if (ret)
> -			ret = -EINVAL;
> -		kunmap_local(vaddr);
> -
> -		kvm_gmem_mark_prepared(folio);
> -		folio_put(folio);
> -
> -		index = folio_next_index(folio);
> -		*offset += PAGE_SIZE;
>   	}
>   
>   out:
>   	filemap_invalidate_unlock(file->f_mapping);
> +	if (index > start) {
> +		*offset += (index - start) << PAGE_SHIFT;
> +		return (index - start) << PAGE_SHIFT;
> +	}
>   
> -	return ret && start == (*offset >> PAGE_SHIFT) ?
> -		ret : *offset - (start << PAGE_SHIFT);
> +	return ret;
>   }
>   #endif
>   

