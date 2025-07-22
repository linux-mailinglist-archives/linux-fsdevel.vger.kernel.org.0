Return-Path: <linux-fsdevel+bounces-55648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3890B0D3ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 09:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167103A442C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 07:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2532E28C5B7;
	Tue, 22 Jul 2025 07:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ETz2r7iD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013001.outbound.protection.outlook.com [40.107.44.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A702367CE
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 07:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753170655; cv=fail; b=PYEiBjd/u6mc2B2ztiSW/nQ16c/jVwAVM35eQ8Iw4nSNiQ3jpzqMyiugb4/0HUSkhZhWCVtq98zE3ADSxreNeXJtOlXUp6n6yMwy2JBjMkOsUor+lZ5XoKiMeILF7HtFkSjG3B4n58wAoKnXEcgYGjNEKFuEBs8F9bC1WqXBAMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753170655; c=relaxed/simple;
	bh=NX/Z7m2XhSAXtfPS5E29QPk9V32OZdkrDIZAT562knA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gScE/uGfh9spBikKUUbzHTlyhXkj1a8b3H39EVI/u++FmNy75Sp5k5QFM6OR3iPcFe0Kbfs0UZLEOXLN8alI+0DBg0GFmGlxF4WG3Yb+P5Cu49uEFE1TIoTfiUQrMpn6NhWvXzLCbvkUq3E7BUf8pNp3DIW23kckaF+OWqIWAdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ETz2r7iD; arc=fail smtp.client-ip=40.107.44.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUMGRtWNHiPxE5ncZM9tJ/yHYX8RZSZrMwdG2EaKUNqbisdNu91yrWGPm7510TgAgQtelgGAkDvvEBn/H9iAi0XRzv7WyWx5zDAQ8eG10/rfVtSJCyyk8R9fLJd6L51v72ye2upodcQFmTwHz9lcVlfQyYZXdVyc7PWj/gCHDI8o/lllQ0CJg8Vxh+VbKDxZaW5RpwqXKAhSVVO0MjHnViB8cg+0255jjv4s7LxCMWaSasMl+4wYGCXp1lDha12tDY6XNuDyG4JrVZ+ki6jQDKcH/1ws0JSMG1cOAq1jMNITQb7pcN5NnT3i0acioW06Vlqh0h9L9cqa+mHNXEyC8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWN4X/LKPJvJyFlvCpLU83nrlu8e02B4nD4CgFS4gaM=;
 b=Xe2dJ7E4eROkJUMq7fXItBLIoIaRf9OopKI05yFqalV2eqbLZgAvFlRfq4JKM8Hmy6cQgeLihhF+j+ZEmBGqoAdRTY7BJqvyJsVD8mTWQDLFftY2FihbzToDHKQyspcgj+hzW4jLl4l2nfF1aSCXNqDB0SpCtv3YngOcpotyGmK+AxzGN8OOy2V91sa3OK3z1+mCeleTyCwWWFr3L5Mk+ypAzkS05qAaSYWE9tMJbKSUTFrkp3Dck+uE4cnXoV0xBrcVmiEpldTtTKtFvBsjCzseu7kAyfb1OJcsNM/XTPjQ8+Nz9vFLWbR6DsZU62hKf2xmFR8JR9wTsAQpA6H2tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWN4X/LKPJvJyFlvCpLU83nrlu8e02B4nD4CgFS4gaM=;
 b=ETz2r7iDxSuLPSzYKaol2xPYjsmkahdkKzsvqg6AvtYcz0l5i/0zeKcFqb+yXFVnH0t6za3Xk9kVbuDAN8hOHEKtDQymE5M70z9fQjB+R6/O2rPqfClemwXaMgyGxjbxWP2voynkpbmwY1txcr36BhdAvpfJSZNUcbBgUil7aZBBmKJ4ct29Yu9h77GXgcnCy81jp4KCROusc2WRPpi/zr8w7Gz62RNEsUdMyld7KixlyB57SMK6+/0Tp2q9ZqLIi757ow9y8D5Dl63Qlp1QAhNW5G6W2R/Gx3XByiYIQCXni2sVkZXjCsAeK2AgRy78XjAMFAORW3hXhi6maXkEBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SE3PR06MB8046.apcprd06.prod.outlook.com (2603:1096:101:2df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 07:50:47 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 07:50:47 +0000
Message-ID: <4c8bc1e6-7f40-43c0-941a-87c7e9f86730@vivo.com>
Date: Tue, 22 Jul 2025 15:50:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hfs/hfsplus: rework debug output subsystem
To: Viacheslav Dubeyko <slava@dubeyko.com>, glaubitz@physik.fu-berlin.de,
 linux-fsdevel@vger.kernel.org, Johannes.Thumshirn@wdc.com
Cc: Slava.Dubeyko@ibm.com
References: <20250710221600.109153-1-slava@dubeyko.com>
 <a52e690c-ba13-40c5-b2c5-4f871e737f72@vivo.com>
 <9f9489e0577f7162cfe4f44670114cec357be873.camel@dubeyko.com>
Content-Language: en-US
From: Yangtao Li <frank.li@vivo.com>
In-Reply-To: <9f9489e0577f7162cfe4f44670114cec357be873.camel@dubeyko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SE3PR06MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd3abcd-886c-4e3d-4f30-08ddc8f47856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmtvZjRuK2lGZU5Jb1MwTGFSdml5VG5XNFJZWUlsWDFxZ0Y1K3YzTEtNMWI2?=
 =?utf-8?B?OU44QzNxQS9SWTJkRER3aG5iRVl6QVMyY2N1c1p2RUdQUWJIeTIybVFIbEdj?=
 =?utf-8?B?dXVlakFVUDJ3Y0FORjBEU2p3NldmeWc1RkdWZXlUN2NOa3owWGxoR2VFaHRz?=
 =?utf-8?B?dWI0TGovbEd5TmZzOWNyL3BCZ1pYbzlrSmVsbzNKdVhqZjZBb1lsMGgrSnZS?=
 =?utf-8?B?TUNLckdreEl0VzBBeWYxTzZmMlA1azFSdVZ6c0tnRE50TGdvaE5rZ0FOKzIz?=
 =?utf-8?B?YmZxeDlKRFlObmpYR25lZWp0ZWtMUDg3dHBHN0U1a3ZRdmZKbjBRekl3K1k3?=
 =?utf-8?B?Tlo4MGxRTTJmNXBiMU5hRVlsT2lqaXhkT21jemZBZU9NZjlya0RCZ2FZR25m?=
 =?utf-8?B?Zi9QQ1FreUhaK0htVjhFRDZ1OE51cGUvMnhtTmZJRE9ubUFLbTFLa0c0WTF5?=
 =?utf-8?B?SlVmbzZOdUlQblRyM0k0MGQrTEJFTFE1QkE3eHNTb0oxdXIxV2hodGtPakRQ?=
 =?utf-8?B?MUN2KzJiYS9WQTAvZUlnNzBhaUZOQzVNVklFM0lxMVZLVUMwUjdELzRUNGU3?=
 =?utf-8?B?TFVTWE8vS3NLUVFRRSsvbUJJbFVFNkl5SGF1YitxRzlrNVBaOEFrREg5Q3dN?=
 =?utf-8?B?cG9vSmxWT2k2YlplcFJ3andqZ1JXUUZ3OFJpeGR5Y29jTFlFbDdCUXpvSUZP?=
 =?utf-8?B?bDViYzYwWDhENEIvRW1KL3RwQjRQdEV0aG9Sa1RFdEJBMy9Ra0hkWmpsNyti?=
 =?utf-8?B?WUllbzczMk9JZ3M3d3Y1bEtpRGdFRmcwNFVzYXBNbUM3aE5ScWJxK3dnelJL?=
 =?utf-8?B?cjRTajdRYk9CdHR6dEpwcWtzV05rdk84TkZRbVppa0s2SnU0WUhkL0J6RDJE?=
 =?utf-8?B?UmxKUWR5WTg3L3lweHdOeUR6Y1dkQWlOWDU3MnYzUW82TFNFM0kvdDcrZ1FB?=
 =?utf-8?B?aDh1YzJkZTJrQjBEU2xjK0Y3R3VhVTVadjRVS0FRMmhZRTQ0dDZ3VUw3NnFs?=
 =?utf-8?B?SHV5TStlSXRzYklyM1ZpNzlsNytBMmd0b241N1ZqMzdtdDhubGJCd2JJZVhi?=
 =?utf-8?B?OGJlWVFUb3RRN2hNcFN5UTFvRFQyT1QvMXlQd09FdXNhdk9tZFgxaG1jSHpq?=
 =?utf-8?B?T3l1KzUra2ttUURYc0RRNG9PbURzdnk4Yk9qSzFrNzJZMjRxZFFWK296NVJh?=
 =?utf-8?B?bHZYYWJuVG1QY0hJNVdEd1RZekNTMURJWGxZTkF2dGdPSmJGMzgyYloxdTk1?=
 =?utf-8?B?REo1OTB2UERPR2NHeUx0RGQ0Q0tVdU5PVjdORVlXVVpCZVh5bGRyWk9UYXg0?=
 =?utf-8?B?UFgxcDhHSC9naFp1a1dqQndNTjlQay9IN3FuOE1Ka1NZQ2x3d3JKcUErekFE?=
 =?utf-8?B?SUdmdGRiYnV4SEthY1ZsdklRWFNEK3RhZTRSNHh5cEFTWFUzZlVrUEx0TE1D?=
 =?utf-8?B?dmlUSzBPdlhodXhXUzJENU9XVHREZ0paSlpvazljeThYNzFjb2I3MkVKMHV0?=
 =?utf-8?B?MENYeTRrUlhXNEMvanFTSDZ0Sis4WU5oNHpUcm9SbFRpa0ppNjhkWWhjZ1dN?=
 =?utf-8?B?Z2ZsVWNMV0l1YjRxYVpiWTlWa25Fa3VYb3k3RHJQN3dYd2NHOEZENWQ0N25n?=
 =?utf-8?B?a1UvdGNjdXZ4c3pHOFh3WXVkQ1NtOU5FUXRnVzJOb0pUNmhLTXBYNUZwdnI3?=
 =?utf-8?B?VXZGRlJua25ib3NySE9tMVFzRjlTK1ZBU2xPclNhaStLbkZuSkVLamhWVGN0?=
 =?utf-8?B?S3BVRTc2TEtNRjVyTmJGRElLVEpyZU5OT0dIc1U3ZVkwdE80MWNyNFdiazNJ?=
 =?utf-8?B?ejVlQVRWWnpxVytQZ2c1R3lRMDJrRUxIQzhhMStBYi92QVFGVkdteTdReGR0?=
 =?utf-8?B?K1hjMEdRYmExLzJIZlhQemhRRTRXbWtsS2Q1VVVTbm5ia0ZHZjJBUnNwR0Rs?=
 =?utf-8?Q?gzqsnsgKufw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEpoRFNxT205TjkwcFNKTGo0OWJnODN1SVpabGQ2cVdtYW92UTloVFJsc0FK?=
 =?utf-8?B?bzZqQnNUUGY3V2hpRXBnMkNYZFNPcnJZMlhmMVhMeWVKNjZzMVFZWUw1RWhP?=
 =?utf-8?B?VUV1dXRXcFovdGpuR2NhQzZkMGVmSWNaZEtlL1pGOG1kdGwwUXltaXBhRExE?=
 =?utf-8?B?d25YTUdrcGlqc0dqUDh5cVZ1KzVwb3IvYlNjWmh2eDBMeURadjNKdGFoMUxF?=
 =?utf-8?B?a1pLbjRYZGJacnlOTFJrYkt1eHJqdGh6Z0xOaCs3a1VoTldNRjNHTXdVUmU5?=
 =?utf-8?B?VGxQb0hJUm54WVFQYmU0U1VUQXg5SFViTVQyR0NVMWpjRFpLMGRTdDl4Mmtq?=
 =?utf-8?B?ZHVta0p1bGt1RXhiVXlmeFBWcXlGWG5hU0NtQ1hlN0RRaFJlcnN4UFJSNzRo?=
 =?utf-8?B?OUgyRHZRQlpsWWdzbVo4NnF1OFVGQnppbmZiK3ltQXpDYTU3WEcwaHc1Vkt0?=
 =?utf-8?B?d0Z3UHZ3bXRCU1hjTGZVZFVEek9FalFYVmRYanZ1WGIvUlJRZjU2b0ZvTDIy?=
 =?utf-8?B?cEdYckxacHV1MEIzdlBwSUJYTDRXYUFoa2E4Sjg5alY4WmhvOXM4MzZRWGZI?=
 =?utf-8?B?cElTRXdtS1IvMlhNWDZuQmdpWnF6dGplTG5IdG5DMUdBR2hHc1poUnBIZzNp?=
 =?utf-8?B?aEJqUVJxSFlhU0dpUGVkNjdMdXpZdVluc28xWTZiK0ltMGoyMlp4Y3FWMWhs?=
 =?utf-8?B?cU5MNGhxcTRqazhjTTNyajFYa3RobTRLQW9yVWYzZkdRZFd1ajdpOHF0VUMz?=
 =?utf-8?B?Y0pWSkdhS1hab1N0RkdVMUxCMWVKOVI2Zm5GbDBNWCs4OWlabGxvTXoxaVdm?=
 =?utf-8?B?eExzQklneHZVTDB2c2E1R3B5WlRBODdlSTdncEdvVmt5bmhUTUlLVy9Jazkw?=
 =?utf-8?B?bHNPVk5lRW13dXB0NmZEWEVDc1N6a0c0L0JvZE5OK3NDMG9MOUxiT3BVeFdl?=
 =?utf-8?B?ZEY3TDhxOEI5cnMydER0NFk2bU0ySUcrR1Y5K3ZCVDBEd2dTWDdRTjJWL29p?=
 =?utf-8?B?MCtKQ2VIRmRjTkUxWUNzK2hYdUJqKytHbXBDQTVnWVdqeG9XNmVtTlpVbEtv?=
 =?utf-8?B?TjJuYmMrYlFJb3JnZVRrTFIzTmljQW5pVjlzR1FsM1VkRlhLcXExSFNTUk15?=
 =?utf-8?B?Y0x0RWMwWmVzOG4xaEhBYnVMSEh6Y0owVEhmZWUvbjA4aGZqN09SazBuUDFq?=
 =?utf-8?B?Mi9nVkprMlFrUHVuMkxCamxKMnRoWFNvR3c1Y0NuN0loempZUGhmdWtJeUd6?=
 =?utf-8?B?N09qZnBpVlExNWduQUxvWkRON1QyQU1oSHppaUQ0QTFzQUh5enplMEhBb1By?=
 =?utf-8?B?SVNrazVSTTBPNGF1eVVJODJDNy8yaFFYaXF0cExVeWlLWTdkRGZqQXUwT0th?=
 =?utf-8?B?djhuM3daM3pKbHp3VWcxS0dWdHFBWnlYSjF0R3RLcGFpV1ZKT3dqS1FPVVlm?=
 =?utf-8?B?WjYzVmhsNHFiWkdsUnhlc0VHc1ZrSDJLaU5OTFZnSHRpL2JJcCt3ZU9BaFZm?=
 =?utf-8?B?WFl5YjhCSkUvZGpTWWVIOVUySmJqeEQ4aGlQUGxaL1FOZjYvSGhBQ1dSMVc4?=
 =?utf-8?B?bFlJMXNxSnpDZTh5QXhUaCtVaG9aQ0xnS1JvOC9CcFRVWXROb2lvOExHMHI1?=
 =?utf-8?B?WTY3cGJjVEluUmdTbTFwdk5yRlpPVlNsbmp5RUlYeUZMY0N1akRXVTNNazU0?=
 =?utf-8?B?QWI3TGluRGIrVk45OW5MOGxpcDJIVklZamVrV3NyWCtMQUw0N0NRMnVHaUpC?=
 =?utf-8?B?ZmlNZTBNUjJjT0prMFNjRGVZQTM1Y1N6TDJDMFQzS3JCMmtYTm1xQzZMY3l4?=
 =?utf-8?B?Vnd1K3czOXphcUx0WkdrSXpaenYwaE9HK2JyM0lxN2c1YkZkOEVsTE1SOGY0?=
 =?utf-8?B?aEdhVU5uQjg0V2Rud3dFN3BnbGZFQ1ZFUjErOFQ5ZDlWcks3WnEvbFVPZ3JH?=
 =?utf-8?B?ZkoyV3RJSWdqZTF6NXFUOENmdm1Sd01DL1ZrbFJEQ2pxb0NOTjl2N3ZRU3J5?=
 =?utf-8?B?TTFOa1RjcW1uNUJUdmFoZUFNZmROMFJVKzBVN3B5SVdGUVNTaWxqYkZJTjht?=
 =?utf-8?B?WmM3WjBuNWZwQWtRT0RzWER5VjdHZGRDbkN2WTNrek5rRnYvZW5sa0RDV3lm?=
 =?utf-8?Q?grM4fi+yBD+6Eueybfzs+/eCz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd3abcd-886c-4e3d-4f30-08ddc8f47856
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 07:50:47.6150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUL5HOmzWP9JFHx5E+0FlE2BDRaUDdbmvGA4J1UjVMKZx7WkseY81zfmOLpcJo5wrliifk/l7MCMPdA1PPzmGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8046

Hi Slava,

在 2025/7/12 01:24, Viacheslav Dubeyko 写道:
> On Fri, 2025-07-11 at 10:41 +0800, Yangtao Li wrote:
>> Hi Slava,
>>
>> 在 2025/7/11 06:16, Viacheslav Dubeyko 写道:
>>> Currently, HFS/HFS+ has very obsolete and inconvenient
>>> debug output subsystem. Also, the code is duplicated
>>> in HFS and HFS+ driver. This patch introduces
>>> linux/hfs_common.h for gathering common declarations,
>>> inline functions, and common short methods. Currently,
>>> this file contains only hfs_dbg() function that
>>> employs pr_debug() with the goal to print a debug-level
>>> messages conditionally.
>>>
>>> So, now, it is possible to enable the debug output
>>> by means of:
>>>
>>> echo 'file extent.c +p' > /proc/dynamic_debug/control
>>> echo 'func hfsplus_evict_inode +p' > /proc/dynamic_debug/control
>>>
>>> And debug output looks like this:
>>>
>>> hfs: pid 5831:fs/hfs/catalog.c:228 hfs_cat_delete(): delete_cat:
>>> m00,48
>>> hfs: pid 5831:fs/hfs/extent.c:484 hfs_file_truncate(): truncate:
>>> 48, 409600 -> 0
>>> hfs: pid 5831:fs/hfs/extent.c:212 hfs_dump_extent():
>>> hfs: pid 5831:fs/hfs/extent.c:214 hfs_dump_extent():  78:4
>>> hfs: pid 5831:fs/hfs/extent.c:214 hfs_dump_extent():  0:0
>>> hfs: pid 5831:fs/hfs/extent.c:214 hfs_dump_extent():  0:0
>>>
>>> Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
>>> cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>>> cc: Yangtao Li <frank.li@vivo.com>
>>> cc: linux-fsdevel@vger.kernel.org
>>> cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
>>> ---
>>>    fs/hfs/bfind.c             |  4 ++--
>>>    fs/hfs/bitmap.c            |  4 ++--
>>>    fs/hfs/bnode.c             | 28 ++++++++++++++--------------
>>>    fs/hfs/brec.c              |  8 ++++----
>>>    fs/hfs/btree.c             |  2 +-
>>>    fs/hfs/catalog.c           |  6 +++---
>>>    fs/hfs/extent.c            | 18 +++++++++---------
>>>    fs/hfs/hfs_fs.h            | 33 +--------------------------------
>>>    fs/hfs/inode.c             |  4 ++--
>>>    fs/hfsplus/attributes.c    |  8 ++++----
>>>    fs/hfsplus/bfind.c         |  4 ++--
>>>    fs/hfsplus/bitmap.c        | 10 +++++-----
>>>    fs/hfsplus/bnode.c         | 28 ++++++++++++++--------------
>>>    fs/hfsplus/brec.c          | 10 +++++-----
>>>    fs/hfsplus/btree.c         |  4 ++--
>>>    fs/hfsplus/catalog.c       |  6 +++---
>>>    fs/hfsplus/extents.c       | 24 ++++++++++++------------
>>>    fs/hfsplus/hfsplus_fs.h    | 35 +--------------------------------
>>> --
>>>    fs/hfsplus/super.c         |  8 ++++----
>>>    fs/hfsplus/xattr.c         |  4 ++--
>>>    include/linux/hfs_common.h | 20 ++++++++++++++++++++
>>
>> For include/linux/hfs_common.h, it seems like to be a good start to
>> seperate common stuff for hfs&hfsplus.
>>
>> Colud we rework msg to add value description?
>> There're too much values to identify what it is.
>>
> 
> What do you mean by value description?

For example:

	hfs_dbg(BNODE_MOD, "%d, %d, %d, %d, %d\n",
  		be32_to_cpu(desc.next), be32_to_cpu(desc.prev),
  		desc.type, desc.height, be16_to_cpu(desc.num_recs));

There are 5 %d. It's hard to recognize what it is. Changing it to 
following style w/ description might be a bit more clear?

	hfs_dbg(BNODE_MOD, "next:%d prev:%d, type:%s, height:%d 	 
num_recs:%d\n", be32_to_cpu(desc.next), be32_to_cpu(desc.prev),
hfs_node_type(desc.type), desc.height, be16_to_cpu(desc.num_recs));

> 
>> You ignore those msg type, maybe we don't need it?
> 
> Could you please explain what do you mean here? :)

-#define DBG_BNODE_REFS	0x00000001
-#define DBG_BNODE_MOD	0x00000002
-#define DBG_CAT_MOD	0x00000004
-#define DBG_INODE	0x00000008
-#define DBG_SUPER	0x00000010
-#define DBG_EXTENT	0x00000020
-#define DBG_BITMAP	0x00000040

I'm not sure whether we should keep those dbg type.

Thx,
Yangtao


