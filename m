Return-Path: <linux-fsdevel+bounces-42867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F234CA4A0F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 18:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFB9B1689FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 17:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E051C1F0F;
	Fri, 28 Feb 2025 17:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CQNiVc8W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0641607AC;
	Fri, 28 Feb 2025 17:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765236; cv=fail; b=mVbUEQ1s3jxp5DIQ0T1cmQOt+HDQIll9hgoamqMAqjmpsDD21++r0VVWAAqO1omQGMH+sKEFIZpxXjOJVqerpYROmjLDEyQR3BzIkV3WawlLWIwdVdzFHzvOTW3zNOMNxrWUxQ/y1qzujZ9qmomiwGV9LjUa0LoWS5qeb+z9u8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765236; c=relaxed/simple;
	bh=/nnYILoEpgYWFNTD1PytH/kujhTd/++n5eU+2JBa1Yc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l1+Ixqy3ccIQ8atkroONIrUztV5GqiwSNHRyAiUcrK4xGHZ7Tz4DWKwI+ru+Tv2094zWAy95oTWqZ4Elh0iiUH9leHJHgsL2hQQIig1DOOP6jUDMxQ6/2N/yimJL3HNyWQipotLf40zIXCKYRDG+flTrFHeemHd5IsaloRcDhxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CQNiVc8W; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8uCaXSEUYZzndEHXdQvp9g7TwuqJ6cgMGoZ42Mq5QPvq2U4RjPKmO9wIwS8qIKzXKxT8QXuPZqBADe1Za/3s7z2x0dGiNMudEVHVPsZlWZR0yqxegGYmWQ/GR00Y+4HJ6hSItqSObXfKdrsPc8WSOQeWdZG4goCv9nWePidDF5Qk5QTO3cNNCpBIfygUwcDI3oU1GxHBI7PLEet7piAw7nZW1RQOOAOdICMstbHkiH4mhJSBMcCI/KOYQ1bs5UlqwLjVyrVLrMI8H1BArpwyJ1PMQ9D2a3RDAMSeJn1HRA9bszyqEvTY5N6bnIYqhXuz2tC/1aiBfCzPdR4SpY84g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySjDqlR+JEz7xqGVNy6yfFYinS6kDWLcvDNnN2uVWmQ=;
 b=T46h6+Mku97whOarw6c/MkQC8VL5XksR4EdP69YrvzP8wHFfQQxKnmtxr+RADAD+Yp9J9Oh2NZZt3DKxZVpuuwu7K3N2njataUABFV8F1I9OJh8f21D7hDlxh4bWfBAr+VeynZ0m7FR2w7/aL3eshjPxnyKhYZjX9AxDJTT2bpZh0Kq04031g0WfldpJ1g+VLEOZ6GdT6/s7AKq79rQQtux4NEvSZGMNrR4IWw7uGNThvcpAIm2OLfwmfkacAnRQsek7urYlTgMi0kwOFIbiHvT9rTp5pZ20ZgnNgD2FYOLUPMnj3n5MBlHVvr/KBjKVGdWDl25F9vZSA159o55MNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySjDqlR+JEz7xqGVNy6yfFYinS6kDWLcvDNnN2uVWmQ=;
 b=CQNiVc8WNhZ4evSmmJyC+QhvZbC2FQpTpdvDSDbTZ3HeXX4oruJ9riTIBeTrpjXt5zOxkd7OyViY4E+MJkW5S05JJ4IfABTpve9zlPYiJ/8lUd67eHJ8fno1PQ/x1wJJdbW9BiiFD6XtgFk9FeYg3nk4BjVxOPyunHfoJbPQxXSI2XukeBUntK9Uq8S983j+ZOLYoDdM4KcRmxDz2Wt/nNIfn/H8lz0zmecqbIVOpjNhQTPbq3sEiKW46z79yjrl8n3RRTDu8m3I234/B5VMSoUHshLeYQEgXBno4aXxduKsfRT1DUC/tpPjyqCKVci+P58c7hAgVSwl279q78RqRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 17:53:48 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8466.016; Fri, 28 Feb 2025
 17:53:48 +0000
Message-ID: <253edd1f-044b-4d7d-a718-b79015618b80@nvidia.com>
Date: Fri, 28 Feb 2025 17:53:43 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] efivarfs: add variable resync after hibernation
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Lennart Poettering <mzxreary@0pointer.de>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20250107213129.28454-1-James.Bottomley@HansenPartnership.com>
 <20250107213129.28454-3-James.Bottomley@HansenPartnership.com>
 <5205ea6a-92eb-4c3d-a135-f3c3ea3bbf1c@nvidia.com>
 <3c371af00ce12575ab11522189cd37d4167cc3aa.camel@HansenPartnership.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <3c371af00ce12575ab11522189cd37d4167cc3aa.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0583.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::13) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|CY5PR12MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 926a609d-02fb-4148-c833-08dd5820da7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2FuUHdqS1gyT1FXR3lkeGk1Rkd1eitsVU4wYUcvZFR6aE1RUHUrTUNlYlha?=
 =?utf-8?B?YTUwMVNsbktuckZrS0g5bUQrUUcxMFNDV0NGV1BRVTU0ZDRNVGhWNURRYmNO?=
 =?utf-8?B?SUZyMG8yTXFpN0dyYVkrbnhobVVBM1lZMFRrK3BVa3gzejk5Y1NHNUQrUEpP?=
 =?utf-8?B?dlNGTk8vTUhvNHI3TFFoRko1ZVBZeUZnaE9Tc1BrNEp3cFlTQ1dwdVZPeWY2?=
 =?utf-8?B?L0NXVlFrejNrTFRVdGE1MGVndVlXRU9sUnZJelJ1KzJiM1NDRE1Ea3RLNFRN?=
 =?utf-8?B?WUNCZEVnc3VUSDNPNVpkZjBCdG9Sc1RwL01ENUpaRFRNZFEzTUpyREE3MmtV?=
 =?utf-8?B?YzExU2k0cy9EYUxlTjVwK1VpVWY2ZFJDL25nYWlkTmhDU01FOThYNXI1R0N4?=
 =?utf-8?B?UjJvWmZBY0drZUU0SEdXcVUrS3Eva2EwVFhSWDFqNERmcVoxY1UrcE1jc1Bh?=
 =?utf-8?B?T1MrakIvdTBQdjhPMG1qa1h1RVI4MnhpaW0yMC9qQUZZYzFYR2thbHBqeHhq?=
 =?utf-8?B?WlYwUndudW1lWndDbFBWdTd2ZG0zZko5ZlFZK3Q0d1dTeU13R1F2YndYSXdS?=
 =?utf-8?B?dGtmd3F3QjEweGRUNE1LNGRXN01ZWlg3ZTNFcjVjL3RjQTFLR1Raa0xHNG8w?=
 =?utf-8?B?cnZidnRzSVAxNWNWa2s0YmVCcmZxajU2SjdQdGlRcDZXU25aTnVGcVY5Z1d2?=
 =?utf-8?B?Y0VMN1FhRGRIaGJIbzdxc1BXdjFENDVQbEVqUXdja2l4NHhvWFVXTHo3Skxo?=
 =?utf-8?B?cnpZK2FRVUUvbjA3QkQzalVRWkVrRGtkQXZML0gvQU42K1RuMWovVWNablFy?=
 =?utf-8?B?c1d2L3VjYTk2SDhnTGYvRmhZL1FQamJ2YmcwYWUwRlk4SDFLajYzU0Qvak13?=
 =?utf-8?B?OGFidS9xbXVsSkI4OXQwRUFvdUtCdnNkYVhMMnBSTTRxSTRUZ041QkM2bXBS?=
 =?utf-8?B?bi9LZ003eDh5K0RMMlc0a0h1RjRVOExEeGlpMXVtNUEvQXJmZWNoV2JTOVp1?=
 =?utf-8?B?UW1NWnlaTjBVZWgrSHZFaXNGWm5lS3JMN2lrUml2RlJCdTRnZ2Mwbkw3VlUy?=
 =?utf-8?B?cVhzdUY2VktrRDR6bjlFWlpsMmErUnBUdXdYQ1hTMlpJeko5d2tuNkhSUWdj?=
 =?utf-8?B?VXhMK2ZuVFVuNU9oblVWc2l3bGoxLzFZdjJmRzh4cFBZa0pLRUlPOWZsVTg2?=
 =?utf-8?B?ZUN4UFJHNXQxWW5wcUNRVG1uS3k2S1VJTUo1SkFIdThaQ0ZDangxU1lqTXpL?=
 =?utf-8?B?UGFyWnBTeVR5TjJLL2pqcUxjcWJiTmlha0h6aHdjeVJCSlhoR01sSDVWcmht?=
 =?utf-8?B?VTE3VnEzdDlMd2ZXb1BGNW1waS9xUlQ0RWdKbi80Umhsd0hMYzR4MFVETUpX?=
 =?utf-8?B?SWVmTEdUVmZOT0hueFFOTU9IN0J5SFdBeFhjd2p3ZWtCV3lkS0kxSUpyMFJ6?=
 =?utf-8?B?cmVaYng0TDRaZVRhMHcveWJHaktLTFBuOVdhNlE5ZmovUnNvVDFYcjVZRU9V?=
 =?utf-8?B?U2d2cDdpV0RwQk9Ya2V6UmJ5ZHJGL3VmcVJtOHE2R000MmhLZlM3S3NHZE9p?=
 =?utf-8?B?WlNmZVgwL3NXOWFMRk11L3dhUWxVelAyWklFT3FsK1JrTi9WQ2tObXAwdTVZ?=
 =?utf-8?B?Mm0xMHBIWFFUVEZHUmt6dUhuaEFoRWgwUEkvajg3Uktkdk1qemRVM1k1L1pn?=
 =?utf-8?B?WDhoRHRZNDR5b3RweUc4SXFsTldaT2d4QTlkNUVpSmR4T1Qza0RmcDZBQktN?=
 =?utf-8?B?dmJXd2o1d2I5ZVZKdjU4czFhWW44WTliUitlS1dJUVJsRnN0bGE0QkQyWXYr?=
 =?utf-8?B?VkxzbmtaMCs5TDJLaXlySVJjWkk0SENpbWljaXhrTWNsVVRtMlp1YmV5T05M?=
 =?utf-8?Q?fEizF3n0sQjXy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODF4YUJPNk5kRW5pazN0Zm4rWVhEeUQ1ZG9RanF4Q1FySjlqdHI2M09xU3I0?=
 =?utf-8?B?R1k2VmRWaTlDU0owcXNhUThpMUswTWdUR09HRWpNekdrdFdFN28zcFJ5Ykg3?=
 =?utf-8?B?cUNqc3hMZXk5dTVvb3JqNStuTFIwUmFtQmtUcGtmV0JpZ2p5YVRXbk9NUGVI?=
 =?utf-8?B?N01GOVBOaUFaait5WFpkOGZzSnE2VDU5Rm1VMTBpb1lDdDdQQ05ocWs2VThR?=
 =?utf-8?B?ZFhZRk1sT1hkbjhVUzNwM05DYmF3eGUvblBNTG1wb1N0Q2gzVnRLbmx4b3Ny?=
 =?utf-8?B?YUJxVkYrVC9tNWdEU1Y2WTNGYmk3WlE1YWRVZ2JHYXU5c3VubU1CcXRlZDlJ?=
 =?utf-8?B?ODN3WFFGTWFZREZSdHJPdFhPbWlFeXdTMEw4SEVSeDN3dTB5OXF6aUoxV1o3?=
 =?utf-8?B?cW1CaG1NRlFWVWRvNCtMbW5JYmVMaVNLT0hDMlo4NkhpS2tKWEl4aGxsMTI0?=
 =?utf-8?B?SFVaVE9hNDdBSEtnYTMzVnd0a0Jod1ZuZ29NaUVUOXMwQTE1a0RpNlBESmZh?=
 =?utf-8?B?ODE3YmxqbUwxM1JOeHd5QlNhVldoWmRTd1B3WmNQTU5LTnhkbDRhOFJRZFhS?=
 =?utf-8?B?dlM0U010dlpZV2hQaEQ1MkI3QitXSnl2Rnc5TVg5cmMxK2VwVERTaWFSU1ps?=
 =?utf-8?B?KzZtREljRXVwZ3hLYVJxbytZSmVJdFRka3N4UkJ2ZWpZYW5tMnNBRzBvbm9s?=
 =?utf-8?B?NVpEL0ZTb1RuT2xEcVF2bXNYa1dwMXBmM1hKTmZ0TGVUZmVEVE5qaGE1TVpu?=
 =?utf-8?B?SHpZdEVCSlluRitKRjNRa0srN1dFckVoYkQ5akJLS2dxd1NabG82S3dBQit1?=
 =?utf-8?B?MDdXSlVGZHloUndhLzNEUlF1TzQ1M1MzdWtnaXFsOVh1K0J0WlBDZVYrVDEr?=
 =?utf-8?B?ckkvNW10NnFDZ3BFdWJmaFR0TkdMVHU4RzV4VmFvRmVaV3dNUVlUVE9mTnFm?=
 =?utf-8?B?bnRuVnNBa1Bld0VHQjhpY2o0WEVJZFlIZGxlQmUwUEN6NnJmYnN0VnRHK3lV?=
 =?utf-8?B?c0c2eWR2L1FxTmNlSno4YlZPdTdmZmprV2Y1K1lrZzJEWnJSMEFsLzJRM1dM?=
 =?utf-8?B?UU10U2dFU0o2cVRjOG5UQ3N5TEYwcFFQS25HZlBTMWFsOXVCWkh5QUY3VitM?=
 =?utf-8?B?VUNaRnhueDQya3VkNDBKYUFxL0IrWm5mT3gyMzM0RW5SMmFqaDV5eTdRSDZX?=
 =?utf-8?B?R1E1YWthSzZCZTY3QkprOENNWFd6Z2hydlp6NWRYQ1NjR1R2bTN2eFRpMk93?=
 =?utf-8?B?TElGWDZSS3dFWElzekQ2VGptdk9ZdUtPL3FKVnBqTDRRU3NxTkVGR2labGgr?=
 =?utf-8?B?SDRUelFBeEpHU2ppeVRPVHhzQ3VaSlpHbll5SS9CbUt4QWpNajNXTnJpWndH?=
 =?utf-8?B?ZzR6eWxqV1VtTWRhMjZmNThyYmRBUGJmMFpzakpVRGFmbXdrVERabmppQUo3?=
 =?utf-8?B?N0VEWFZpekgwQWQwK3MvYUVlcWRvL0JIMWQyTFc0VnhRQWQva1BERGpndVhm?=
 =?utf-8?B?YnhJbVZrWnFkZXdtY2xWMnMwM1JYRWh0SEwzUjBaRFNxa2tycjhQbFQ4Z1pn?=
 =?utf-8?B?ZG5RNm45SXpBdFEwT1NyRCsrTkF3R3hCOWo1UWJoOEFEdU1HZTN1TjdaR0ti?=
 =?utf-8?B?SU1rVjRMMktEK0JRTVJGSFNLNGpIbEhGZGsxNFNtMEp0dWJtMi94UG1Cbzl0?=
 =?utf-8?B?N3J2c1YzSXROOVZ4M2Vqa3BBaE1JUkRxK2Q1cDNxLyt4ZHpLWHVBK1NiZGoz?=
 =?utf-8?B?SFVHVFVIYUxtdTgrOFlqSHJPMXhjdE50OC9UY1MxdGxkWFVxaWxJS0JHM0dB?=
 =?utf-8?B?ZjY3cGxTWkhjWkdUSTBOcElURWxkZm5ZdDRrSUw5MERKT3lNVkc0S2lLdURz?=
 =?utf-8?B?MC9zTFl1VU5QZWJyVE5oRUZWaU45RmszM2k1Nys0cGNmdUZhb2tLcWdQbzdv?=
 =?utf-8?B?SFZIcEJ1MUFFVUNhTUVDSkFTeWljYU9KUVVZM2VQck42OHZhaFZZTTdGbEl5?=
 =?utf-8?B?dldjR2dDTWFzeHJJMWxERlBMcm5RU1R4bUw0VDlIVi9NbnBaYk1CN2ZzTTV6?=
 =?utf-8?B?S2xXcHNDaHhGNExhNHVPN0lHMXFYT295Wk1zOU9CSldwQlIwRy9UdmFBdk5G?=
 =?utf-8?Q?jH8AYpFKigjgknxUfBmUUx9Al?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 926a609d-02fb-4148-c833-08dd5820da7f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 17:53:48.7148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzRN7/0aWtm6e5FvlsGKlq2DEwU7MveIUK/qBM7w3r7gBH44NEj52VlzFFdE5J7U076Sr7c1wAluMkEvM5QTyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346


On 28/02/2025 16:49, James Bottomley wrote:
> On Fri, 2025-02-28 at 16:44 +0000, Jon Hunter wrote:
>> Hi James,
>>
>> On 07/01/2025 21:31, James Bottomley wrote:
>>> Hibernation allows other OSs to boot and thus the variable state
>>> might
>>> be altered by the time the hibernation image is resumed.  Resync
>>> the
>>> variable state by looping over all the dentries and update the size
>>> (in case of alteration) delete any which no-longer exist.  Finally,
>>> loop over all efi variables creating any which don't have
>>> corresponding dentries.
>>>
>>> Signed-off-by: James Bottomley
>>> <James.Bottomley@HansenPartnership.com>
>>> ---
>>>    fs/efivarfs/internal.h |   3 +-
>>>    fs/efivarfs/super.c    | 151
>>> ++++++++++++++++++++++++++++++++++++++++-
>>>    fs/efivarfs/vars.c     |   5 +-
>>>    3 files changed, 155 insertions(+), 4 deletions(-)
>>
>> ...
>>    
>>> +static int efivarfs_pm_notify(struct notifier_block *nb, unsigned
>>> long action,
>>> +			      void *ptr)
>>> +{
>>> +	struct efivarfs_fs_info *sfi = container_of(nb, struct
>>> efivarfs_fs_info,
>>> +						    pm_nb);
>>> +	struct path path = { .mnt = NULL, .dentry = sfi->sb-
>>>> s_root, };
>>> +	struct efivarfs_ctx ectx = {
>>> +		.ctx = {
>>> +			.actor	= efivarfs_actor,
>>> +		},
>>> +		.sb = sfi->sb,
>>> +	};
>>> +	struct file *file;
>>> +	static bool rescan_done = true;
>>> +
>>> +	if (action == PM_HIBERNATION_PREPARE) {
>>> +		rescan_done = false;
>>> +		return NOTIFY_OK;
>>> +	} else if (action != PM_POST_HIBERNATION) {
>>> +		return NOTIFY_DONE;
>>> +	}
>>> +
>>> +	if (rescan_done)
>>> +		return NOTIFY_DONE;
>>> +
>>> +	pr_info("efivarfs: resyncing variable state\n");
>>> +
>>> +	/* O_NOATIME is required to prevent oops on NULL mnt */
>>> +	file = kernel_file_open(&path, O_RDONLY | O_DIRECTORY |
>>> O_NOATIME,
>>> +				current_cred());
>>> +	if (!file)
>>> +		return NOTIFY_DONE;
>>> +
>>> +	rescan_done = true;
>>> +
>>> +	/*
>>> +	 * First loop over the directory and verify each entry
>>> exists,
>>> +	 * removing it if it doesn't
>>> +	 */
>>> +	file->f_pos = 2;	/* skip . and .. */
>>> +	do {
>>> +		ectx.dentry = NULL;
>>> +		iterate_dir(file, &ectx.ctx);
>>> +		if (ectx.dentry) {
>>> +			pr_info("efivarfs: removing variable
>>> %pd\n",
>>> +				ectx.dentry);
>>> +			simple_recursive_removal(ectx.dentry,
>>> NULL);
>>> +			dput(ectx.dentry);
>>> +		}
>>> +	} while (ectx.dentry);
>>> +	fput(file);
>>> +
>>> +	/*
>>> +	 * then loop over variables, creating them if there's no
>>> matching
>>> +	 * dentry
>>> +	 */
>>> +	efivar_init(efivarfs_check_missing, sfi->sb, false);
>>> +
>>> +	return NOTIFY_OK;
>>> +}
>>
>>
>> With the current mainline I have observed the following crash when
>> testing suspend on one of our Tegra devices ...
>>
>> rtcwake: wakeup from "mem" using /dev/rtc0 at Fri Feb 28 16:25:55
>> 2025
>> [  246.593485] Unable to handle kernel NULL pointer dereference at
>> virtual address 0000000000000068
>> [  246.602601] Mem abort info:
>> [  246.602603]   ESR = 0x0000000096000004
>> [  246.602605]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [  246.602608]   SET = 0, FnV = 0
>> [  246.602610]   EA = 0, S1PTW = 0
>> [  246.602612]   FSC = 0x04: level 0 translation fault
>> [  246.602615] Data abort info:
>> [  246.602617]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>> [  246.634959]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>> [  246.634961]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>> [  246.634964] user pgtable: 4k pages, 48-bit VAs,
>> pgdp=0000000105205000
>> [  246.634967] [0000000000000068] pgd=0000000000000000,
>> p4d=0000000000000000
>> [  246.634974] Internal error: Oops: 0000000096000004 [#1] PREEMPT
>> SMP
>> [  246.665796] Modules linked in: qrtr bridge stp llc usb_f_ncm
>> usb_f_mass_storage usb_f_acm u_serial usb_f_rndis u_ether
>> libcomposite tegra_drm btusb btrtl drm_dp_aux_bus btintel cec nvme
>> btmtk nvme_core btbcm drm_display_helper bluetoot
>> h snd_soc_tegra210_admaif drm_client_lib snd_soc_tegra210_dmic
>> snd_soc_tegra186_asrc snd_soc_tegra210_mixer snd_soc_tegra_pcm
>> snd_soc_tegra210_mvc snd_soc_tegra210_ope snd_soc_tegra210_adx
>> snd_soc_tegra210_amx snd_soc_tegra210_sfc snd_soc
>> _tegra210_i2s drm_kms_helper ecdh_generic tegra_se ucsi_ccg ecc
>> snd_hda_codec_hdmi typec_ucsi snd_soc_tegra_audio_graph_card
>> snd_soc_tegra210_ahub rfkill tegra210_adma snd_hda_tegra
>> crypto_engine snd_soc_audio_graph_card typec snd_hda_cod
>> ec snd_soc_simple_card_utils tegra_aconnect arm_dsu_pmu
>> snd_soc_rt5640 snd_hda_core tegra_xudc ramoops phy_tegra194_p2u
>> snd_soc_rl6231 at24 pcie_tegra194 tegra_bpmp_thermal host1x
>> reed_solomon lm90 pwm_tegra ina3221 pwm_fan fuse drm backl
>> ight dm_mod ip_tables x_tables ipv6
>> [  246.756182] CPU: 9 UID: 0 PID: 1255 Comm: rtcwake Not tainted
>> 6.14.0-rc4-g8d538b296d56 #61
>> [  246.764677] Hardware name: NVIDIA NVIDIA Jetson AGX Orin Developer
>> Kit/Jetson, BIOS 00.0.0-dev-main_88214_5a0f5_a213e 02/26/2025
>> [  246.776569] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS
>> BTYPE=--)
>> [  246.783718] pc : efivarfs_pm_notify+0x48/0x180
>> [  246.788285] lr : blocking_notifier_call_chain_robust+0x78/0xe4
>> [  246.794286] sp : ffff800085cebb60
>> [  246.797684] x29: ffff800085cebb60 x28: ffff000093f1b480 x27:
>> 0000000000000000
>> [  246.805021] x26: 0000000000000004 x25: ffff8000828d3638 x24:
>> 0000000000000003
>> [  246.812355] x23: 0000000000000000 x22: 0000000000000005 x21:
>> 0000000000000006
>> [  246.819694] x20: ffff000087f698c0 x19: 0000000000000003 x18:
>> 000000007f19bcda
>> [  246.827029] x17: 00000000c42545a5 x16: 000000000000001c x15:
>> 000000001709e0a9
>> [  246.834372] x14: 00000000ac6b3a37 x13: 18286bf36c021b08 x12:
>> 00000039694cf81c
>> [  246.841713] x11: 00000000f1e0faad x10: 0000000000000001 x9 :
>> 000000004ff99d57
>> [  246.849046] x8 : 00000000bb51f9d6 x7 : 00000001f4d4185c x6 :
>> 00000001f4d4185c
>> [  246.856382] x5 : ffff800085cebb58 x4 : ffff800080952930 x3 :
>> ffff8000804cba44
>> [  246.863713] x2 : 0000000000000000 x1 : 0000000000000003 x0 :
>> ffff8000804cbf84
>> [  246.871045] Call trace:
>> [  246.873550]  efivarfs_pm_notify+0x48/0x180 (P)
>> [  246.878119]  blocking_notifier_call_chain_robust+0x78/0xe4
>> [  246.883753]  pm_notifier_call_chain_robust+0x28/0x48
>> [  246.888852]  pm_suspend+0x138/0x1c8
>> [  246.892438]  state_store+0x8c/0xfc
>> [  246.895931]  kobj_attr_store+0x18/0x2c
>> [  246.899791]  sysfs_kf_write+0x44/0x54
>> [  246.903553]  kernfs_fop_write_iter+0x118/0x1a8
>> [  246.908113]  vfs_write+0x2b0/0x35c
>> [  246.911608]  ksys_write+0x68/0xfc
>> [  246.915013]  __arm64_sys_write+0x1c/0x28
>> [  246.919038]  invoke_syscall+0x48/0x110
>> [  246.922897]  el0_svc_common.constprop.0+0x40/0xe8
>> [  246.927731]  do_el0_svc+0x20/0x2c
>> [  246.931127]  el0_svc+0x30/0xd0
>> [  246.934265]  el0t_64_sync_handler+0x144/0x168
>> [  246.938737]  el0t_64_sync+0x198/0x19c
>> [  246.942505] Code: f9400682 f90027ff a906ffe2 f100043f (f9403440)
>> [  246.948767] ---[ end trace 0000000000000000 ]---
>>
>>
>> Bisect is pointing to this commit. I had a quick look at this and the
>> following fixes it for me ...
> 
> Yes, this occurs because the notifier can be triggered before the
> superblock information is filled.  Ard fixed this:
> 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?h=urgent&id=cb6ae457bc6af58c84a7854df5e7e32ba1c6a715


Thanks for the quick response. I can confirm that this fixes it for me. 
Feel free to add my ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic


