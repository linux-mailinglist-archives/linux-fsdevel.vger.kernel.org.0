Return-Path: <linux-fsdevel+bounces-75260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJQ9GatRc2kDuwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 11:47:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EBD748D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 11:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 537453027B4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 10:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDC837D104;
	Fri, 23 Jan 2026 10:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lOiYmYym"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012041.outbound.protection.outlook.com [52.101.48.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D13335FF7C;
	Fri, 23 Jan 2026 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769164940; cv=fail; b=F5U7DbPHZ6nR+OJ2vj6OdflO3D09NoJu6P1YE8yAW8oFBjggfshMtS8U1ZDPpmDeVlRAvBKNa6761bcJsJrAVjsj4CCrnACiYVZS792OdlToUx1JYxktV4eXxfKLhvL/MbOz28ZQdXdxCxx4vmc9fp3Flu+J6psozdPOmefS9A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769164940; c=relaxed/simple;
	bh=TiqZNb25iZShrewQxOSX2c6jH6y7r3AcDaHT2wNDHz0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aG2Y+Bpei0XoaUa5AcXVEUoUnXj5KMIX1JnL70wmRy98haxcjOnRFXm34ABA/o70dAlTViOs0fVkMxxDU7YC8wGNZqBU1ZUKZQIusDSOHrm1s9s3bCMDBoXF3r3UcMZBbFyRyXI/4vB5WfmX8uLu0HoSm6NxCTxIKX+c3+CjGUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lOiYmYym; arc=fail smtp.client-ip=52.101.48.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6AG+3+fX0kdBoC7wTKgxSLgRVu7hQtc/k5pyG+Zlja8qAlTRXipS/oU2nb87QmvQqKYH6GA36MmM2tORV7CKx2zO5yVFhHeAn7dHLxsGlnNXzh+EbKYp1NVBB7utsCkclhbq8FzPuyHakA6Xcp+sb5n+iL3iJtmw65FNbfK/rfDRtv0sBPOr81sQcwf0duUXviVQrilGhpMKze4x15/kgzNiFlaPf9kukidbNvpn95XnSf2AnomMYsAGicrSwERXg1qbrvBROh78cy0iwS1h0hNzt4rrZqDcvflhEUpROAD6lE4Nz+6Al4UBLdiPPtz3uCK2akszGquAKQLVc+QeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMaKki7fwHydN1OZ+dLpdKZy8avQjXeHTX2OBYmmOvY=;
 b=j5H7Unrx1ru7pKnly5mtF5FupdwcIDzOpiw7+BsCr9rAEgNQuek1ya3Sk5nKD2b5JS2qsZifnhq448YC8h6/Q6l1Nn36A4lSW3gapK3Osdt+TxZVeQ8DZmO7/X016cX+Ix7PyjhEgGljFawYyu7HV91OShnNKrT40ZVvcy8mcAM9FS7VlMg7D0cU0lmPGCPB9fORD3ep8kmDtb4j2pjUojXeumJsFaIvg3VnKpvFWBwmIJxX/RdB87t46tU6U1jxfR7/Tg5EmEHSIpMSaaG+GCmBoY0Xx6/aMftN7hryiTEtXqDMbzI4pXksCCwp1KqzGPfxV5RZa4+t+cSCuayjtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMaKki7fwHydN1OZ+dLpdKZy8avQjXeHTX2OBYmmOvY=;
 b=lOiYmYym2zjI8r/siyT0OZ0hj20nOatiVDkBXIcoefykwbQvOdfVcRzvtqpL7krslhYWSM30Exz5TNaFVmlb4dZURKWOXpD4tkvJ1FA6t6KSeCzRcMHnIa5ZQRIGn4h4J6fyTA/DHyQtOONFpr+r7yxeq+tQ9rWujA+IRLH+M+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MW3PR12MB4444.namprd12.prod.outlook.com (2603:10b6:303:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 10:42:14 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 10:42:14 +0000
Message-ID: <0f0a2be8-6b09-4342-be1c-e5dca818ad93@amd.com>
Date: Fri, 23 Jan 2026 10:42:05 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] cxl/region: Skip decoder reset on detach for
 autodiscovered regions
Content-Language: en-US
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Jeff Johnson
 <jeff.johnson@oss.qualcomm.com>, Ying Huang <huang.ying.caritas@gmail.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>,
 Tomasz Wolski <tomasz.wolski@fujitsu.com>
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260122045543.218194-4-Smita.KoralahalliChannabasappa@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260122045543.218194-4-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0277.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::12) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MW3PR12MB4444:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d8d6c4-3c57-4a64-3cd8-08de5a6c11df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clNtcDR2amc2WWhrM0k2RmEwWXkwT0FoZG5uT3VvR3E4MU0xSjZnZ0RQVUR6?=
 =?utf-8?B?VDhScTBjTnFEODhXQlNMdmhKNVZhcWkwVlkrbE1kREROWGl6aVQxM2xZK2ZJ?=
 =?utf-8?B?ZnhsL0QzazBTaVFuRTVwcEhkNkhOVlBnb3MzcVlGMFhGQmtpc21kZVEyR2Fh?=
 =?utf-8?B?aktYZWUrWjFNY2E5cFZiVTA5elduMEU2WnNRb2lDYlhSZXlZQWx3UHJ2bUdE?=
 =?utf-8?B?RXdmVWc0MU9oM3Vka2xZVkpuNnRqMzRUN1RNZ2ZmcTZOS0RydkhNWTlXVnI3?=
 =?utf-8?B?UjdsQUQzamhiRU1iRUVlbmZac3cyUXArTUxSVXQ5YXRPcHIvMTZFeEtKZzhT?=
 =?utf-8?B?QWJkOHRiZXFOcEptM3AvS2RPeUdUNitRVVVJNEF3dlpzNU1Lb2FSNmxxRWVn?=
 =?utf-8?B?VjhJbmM3Z2FJY2lQaC8wL2xoQ1pZYmNHVGFOa2ZwK1FFbnpYVSswUUVudEgr?=
 =?utf-8?B?VmtsbVpVZm5oeWxoMjc4VnllSThkMjM2Yi9DNlc3ZmpDL0JxOHAvL3JUOGlu?=
 =?utf-8?B?UW5XY1k3czZQUzdjR3FJdXBwYXJiSnd1OUY3Z0ZCUVJhK1hEaHk4d0RXc0JF?=
 =?utf-8?B?Z2pRcms1YnRpcHUzcDdNRG83VUNvaitZallHT3V2SjBzSklsWGNXOUhxa2Mw?=
 =?utf-8?B?RUpQWnYxYVFuNEZYOFd1RlVjN3cyV0FRWTZKd2NpczV5REwvQk9QNEt4VmZ1?=
 =?utf-8?B?M29sZ1RURXpGcld6U3ZaS0t3MzJ1cUJQNnVpSm80RCtRRzZFY0dxaUlaU0Fl?=
 =?utf-8?B?ZUd5dFZvOUtYVi9YS00zNit1ZGFYMGNId3NxbkUyNktYRW10dHdYWStaQU9U?=
 =?utf-8?B?WHRvN3lDMXRZVXg4Yi9MZjZMUFRTelVjbHU5RVZ2aGI5YlN3bjdmZFJtSjBW?=
 =?utf-8?B?TnVVY0h4VlNGakdYZk10b25BMHlxdXVlQ1l3RmVuRDBTYlZ3K1lLVTNHWnRO?=
 =?utf-8?B?aC9GQWxJYnBMZ3ROOWY3eVYwTDdOS0s4S0NlM3RjUkdKVjRRNklGYUgvTEV5?=
 =?utf-8?B?N044V1ByU1NsTVRwL0dkNDJPcXhmSFNSMzNLek5LZTdnUXAzcGN6NXIvTTV6?=
 =?utf-8?B?YUJHemxVdkU5V211R01jZy8wc2VUckFiQW1nYUpVaERPVlhJbnlKUjJBRDJv?=
 =?utf-8?B?VWR0dGhBanRXS2RmRG1aWkduVDVpcU9oUmwyQithYmVsWlYvNWpITk16T1h4?=
 =?utf-8?B?MzI4YkErZGpSRXpWd3ZlZGFXRXQ0TExUSUtLeU9ua0RaNVpnd05VblZxSjV3?=
 =?utf-8?B?VzJuTlpKR0hMaW4wc054MzhUbHRqbEpobkZKYm1wZWc0YlA0QjFSVWk2bVNa?=
 =?utf-8?B?TVowaUNzd1AzN2x2aTVUNHpwSE5Oc0FzQW9ndWtPdVFTNk9VTVZHUW5nalFp?=
 =?utf-8?B?Qm1JNDVIc3Rsc3JjeVJYbFRza2ZPaDlQcDluSXFWZlhIUlJaMXM1RFhDOVZT?=
 =?utf-8?B?MFZRUXcxMUN1cVdwMVpldVJ1MkV1RTJBOGlOYkR1akh2Y1V3WjExWk8xcS9X?=
 =?utf-8?B?dUdXYTFSc200VnlING1sVDdPd0t6TEI1TlJyQkdxaU5PK3JJUktMRzJWdytL?=
 =?utf-8?B?N3JWWjdQZjczaXliN21DZ0plOW1WV0taN3FKdzlXV2FqazlaQ2dNN2FyQXlQ?=
 =?utf-8?B?NVYrK0dsWE5GZDVVMG1KcGlYUjdDSmdHN2JKQjZ6Y0Mwd3o3Y0Yva1NPVDRq?=
 =?utf-8?B?UFBLdWxWZ3k5Qkg3WU1PNXBnM2JvUUlWR1A0bi9BSGFkenllbDlvTFZJQW1O?=
 =?utf-8?B?Um1FRWtRUjF2WWl0MVg3b0tlRzRVVzRSVDNlNTZnbHZEMEsyQ0tSWWtrRGhD?=
 =?utf-8?B?ZW93citTWCt5UFZaV0pMWHozb2pZcHordDAwbm5DK0VPS1JWSGYyRnA0NDRI?=
 =?utf-8?B?cEdDU3FoVERuMjVPZVBmeDE4alR3aER2TElYYU45RkJyNHpiZUN1aU8vR1Nj?=
 =?utf-8?B?RUhIKzRRaVdibkVPTk55MElUYnY4STNNcnN5YU53ZGtmUkVhcjNlOXIzZDlU?=
 =?utf-8?B?bDdka1NzTlhkSXJFbVR2NjUxNlhoeE1iTms2NXRwM2hBcmtjM2V4c2J4M3Zh?=
 =?utf-8?B?YVlEOEdja25Pdy9FdE1VNzM2eDh0MGZKZXJDamFOc0R3TDA4T2Q5cHE5RlVK?=
 =?utf-8?Q?Zjwk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mm1MekI2R08rbERPRkdYYzBQdGNDNTdkNE5KRVc2dDAwNEZXRmpMNnhRb05Z?=
 =?utf-8?B?dkpTVkNvenZZNlpyMWJSWDhySDB5VVdRdXJKUmtjNEtGd1NkVW9POEkzMXBU?=
 =?utf-8?B?ZUdmTVRHTWhQbjNOOXdDMWpsUGZ5ejdZQUZoZVUxZ3M0RGtkSnhUS2w4Y1BE?=
 =?utf-8?B?YVRiWC83SUdXaDVvc2k0TThwaTRDRnNUY2RCcGlVY0ZBdUFxeDJJODU3WjZU?=
 =?utf-8?B?UWM1NFpyNVZpZ1A1WXovbFlvKzFQcFJObkh1ZDdOQTZweXdSZjdXK2IrWW00?=
 =?utf-8?B?RENYNEpENTNXSkxwOWNHdk9lNUkwaGc1cDNrdHlqZ0IwSlMyWnIwRFZoWDlo?=
 =?utf-8?B?U3BhL3hFR25EY2xzMlorZXhidkxmUDV4QXREWS9wUk1SUGt4ZnBqQkRkNDdR?=
 =?utf-8?B?WWhLdXBHUjZ2bXR1RW5odVhwRVdiaDFYWjZJSncxSU5qczAwUGVTSHZCdHpi?=
 =?utf-8?B?NzZ2THl6R2N2QXJub05qRk1RYUg2UnltMm9uSy9wTkliaDRCaGt3YlhZd3c3?=
 =?utf-8?B?OWovRFYrZTdxamhOODFkVGpJR3htd28rMTljbi9taGx0Y1BpNG9MQm9STm1r?=
 =?utf-8?B?WDBzcWgycnVzWVlVZFVOZlZvdkdGQUVERHVmdHBPYUxma2ZBT1oyN0p6dUV6?=
 =?utf-8?B?QlVMM2RRcG1Pa2kyeVMxQVo0UlR6VmU3aTJnTldMSTdPbVI3dVdZSWlzOGhW?=
 =?utf-8?B?L0FXanZJOCtBQWF6S1Jzak9HMlZINXZqc1ZLcmp6Y0w5V2I2NFlNT3l2WXJz?=
 =?utf-8?B?V2VjWWpac3VIcVBSR3VpNUFBdTQ3NXQ1dE5EUnRZek1HN3dEZnEwVmpRVEV3?=
 =?utf-8?B?NEFoWWtxUThIU3VwQytlUzRaOWdyRUE4Rjg0V09xZ2J4bFIxSXFQSkJsUDNa?=
 =?utf-8?B?TCtocFowWi95R3dEUHU0ZFVWZVptano4ZmRJaExjYThlMExwcnUrOHBDM2xQ?=
 =?utf-8?B?bnlaanJzMGZyeG5LQzR6dHBHTDFyVUc5RzhWMEVPQ2RTMUhqdm5sSkx3Z0xN?=
 =?utf-8?B?dWlRZTNRekJGTUs5VWtqdVdaY0J5Q2ZNdnpjTHN0SCtrWjlPcGZvZXQyUzMz?=
 =?utf-8?B?SkJUR1RsN2F6VnhnOEFqdVVRZllSZHdKMVNRTnFUN012azB2ZGREcThtd080?=
 =?utf-8?B?dmJjZmNWZWFndGNyNXlaMU43NjFXS1Fydm0zajRSMU9pTDZKYk9pbWpTK1NS?=
 =?utf-8?B?SnAyQTNLckZOTVE4MStiYUZQcEdxZkJRWW5nK3Fmalc1V2I5amRaMzVydXNS?=
 =?utf-8?B?Yk5sUjV0M1JLYWZaVG9CNWR4SDEwL0VadHE1MzhBcDU5d2w1VnpHcnlSRlFT?=
 =?utf-8?B?a2hLMmJEcFVhdUg3dW9sUk5FemVCMGZTVktlQWJFODZrdXBrbnNKWXROMGd4?=
 =?utf-8?B?Vk42VFY2cXhyYkd2WkJkaDZoZFgvZnlhNjBvcHdyWnBxRWlzSkZaaE9mb1dV?=
 =?utf-8?B?UXQ4U3ArYnBMQ2wwSmJPZFZ1dmxwQzI3ZUhoaDRrZnQwaGRBK3hyNThnaFEv?=
 =?utf-8?B?TkFmS21DSUZLMnJZeEdaeFVCZ0JiRGZ2allEUGo2QWh6Mk56MlRBTUExN3RR?=
 =?utf-8?B?VkgzaVkwMGphVm5uSG83enBvRkc3ek5DNDhyTHg0T3RPbHJwTTZ2a0xUU1Y2?=
 =?utf-8?B?cFR3bnNOSTgxWXFyWkpMRHEzM1JIN1k4dXdVZE91ZlRUUGNhWGJ3bUo4MFFS?=
 =?utf-8?B?TElGcldhN3dNcGQzVmZYRFhtak94dkNPQ0h4L3ptNUNOYVJiQkxkaU0xdURx?=
 =?utf-8?B?NzluZVdqMC9WOGFHUDV0TEpSek9FcmIxSkhMd0VTRkxuaG9FcUoySUxpZnli?=
 =?utf-8?B?SS9IVktrSzduU1hRaUphR1dUYkdzQXhkZ290NlZRUzNPdDc4RituZDlFUzN6?=
 =?utf-8?B?UVRkd3h6SnltbDFKMHZveXk2Z0drckk3VVdxakg3eFlkeDQzM3hxS0ZVQlJs?=
 =?utf-8?B?dWxKZWtZUWhRZTBrSVlMd2g3cElQQXg2UzdiS3NydUtJeUg0QU94TS94YTJZ?=
 =?utf-8?B?TUk2YmFNN1poRDQwZlJDTEJ5d0U0eEQ1NTFSN0RweE83MFh1R05qcTZiR1Rr?=
 =?utf-8?B?SFkvV3BhN1IrMnNNQ290SUxxNFYwRFdqbzlaMFQvZU5yc0RqbnJqQkxXU3JQ?=
 =?utf-8?B?blMrSllWb1BTY21xaGlxNFNZSEpDK2JmbThCSHBaS1d2a3VUU3M5cXhEK1ll?=
 =?utf-8?B?Q1p6MmUxYlF0S1ViYzdlMGNwYkFwNll3cEFZbkFuZHpJU0xueWZjMWN4YWdM?=
 =?utf-8?B?NWFuNkU1N2ZsTnRJeDFobUdhWUQxZE9JV2d5QVNUOHJCbno1eStKL1gyc3Q1?=
 =?utf-8?B?U3J3b091d2RIZHhFbUVoOStYbGEvaGl3SnkzTDVJeGNtblVUaEpJZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d8d6c4-3c57-4a64-3cd8-08de5a6c11df
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:42:13.9174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hf2Xzcz13hvmW+1gFOF+rrfQUZNwLkq6iQZMKPqzomas9Y106K+bmEr6oufwfVDNMAucnDQdWq5IfCKDPi1LIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4444
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75260-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8EBD748D7
X-Rspamd-Action: no action


On 1/22/26 04:55, Smita Koralahalli wrote:
> __cxl_decoder_detach() currently resets decoder programming whenever a
> region is detached if cxl_config_state is beyond CXL_CONFIG_ACTIVE. For
> autodiscovered regions, this can incorrectly tear down decoder state
> that may be relied upon by other consumers or by subsequent ownership
> decisions.
>
> Skip cxl_region_decode_reset() during detach when CXL_REGION_F_AUTO is
> set.
>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>   drivers/cxl/core/region.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ae899f68551f..45ee598daf95 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2178,7 +2178,9 @@ __cxl_decoder_detach(struct cxl_region *cxlr,
>   		cxled->part = -1;
>   
>   	if (p->state > CXL_CONFIG_ACTIVE) {
> -		cxl_region_decode_reset(cxlr, p->interleave_ways);
> +		if (!test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
> +			cxl_region_decode_reset(cxlr, p->interleave_ways);
> +
>   		p->state = CXL_CONFIG_ACTIVE;
>   	}
>   


I think for some Type2 drivers this should not be the case, and some 
kind of leverage should be implemented, but I guess this is enough with 
the current supported cases, so;


Reviewed-by: Alejandro Lucero <alucerop@amd.com>



