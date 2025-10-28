Return-Path: <linux-fsdevel+bounces-65915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600A2C14EEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 14:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674B85E7C68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 13:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7DD32D438;
	Tue, 28 Oct 2025 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="JhpQ5Ms/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020141.outbound.protection.outlook.com [52.101.191.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C2034CDD;
	Tue, 28 Oct 2025 13:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658514; cv=fail; b=ccnYzpQ36GkQO3kZHaj+lOc5bHqCjMhoHlZ6IJSUIBXSD54sUg3nVF6zKxeFlwrZliX1qwO4jVaWkAnFqXveJhOC8RwXqeqzUHN8oVSXUIiEIRJYnbapLH3OotRYipi2rsHQCFBcRtsdRu2ZYovbjn3e6eBX737ZOg2soBJaBE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658514; c=relaxed/simple;
	bh=EFKG1o+1tEKSlW7QaJ68021m+z0lwwmbj27hyHzPqq0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H+nBl4ZfaxwVs9lUYvsSP/lAYa+M6nnjhP24jVL3ImjON9vxfTp+I2EQtxpenOofZRoyn9Yk4D9ScT7yhOdEpFMkWafNOuTgjCPyruh3thxuoFHSeqGIbWLxVyh2beinIV/X3Y1hdUC+N5Ww7rNMbEJv3RcVEpHwlrtOnOII0PE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=JhpQ5Ms/; arc=fail smtp.client-ip=52.101.191.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=po4qdZWDd4xouSRppaG4JtS60cSoL9b05ac82E4ZkNY70RDk47bwx/iIMw0075InQEd6tN2sIYlmpl7YSNm28hCntaHo/VUgB1sEU0kyspqdpEcWqCI6ESNyM6wt465M0D4rU0TSgB4hPhreR5tr3sEdlZIN0wOPETq6aLJaXfiRvXyaH5OIsIXZGzqnPqvx1pe34LkXaaFwkCBryKR/EmV1wwpkZhHJ9TvBiYC196MYrC54NnB7d1JyGZO8bgUD/xnsxd76J1AHVEdRknKio2xuh5xIs4H8mLo4Wf3D0VyhNg08RADUjGHopQjEQ6hpUkFb6EQ83B1AFgpJCscPJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8KDwnUXuOzCxlMVVRXvbcEUnahNKJayk2qWL8UaU7U=;
 b=JcUq+AUkSSvZLopjFaLtfuM6vQykcG0Q8h0coN/XusRZaMBCzR4bvVmoaXY9s3mls+B/+dFItySG/4a6iubs9Q7PcmYycZ4Pe798UzKSM8SSxfwkncIb2gqC9NKwhZdOtYvDYhGMeGzQPTpNaavyfN/ZE01snXziREZQOr2N9GTQuam1TdYOx0BCtejOLLRKGHFhmxP9XsT57IZ4QVDe0OitjNQtE4Nfr1QvZQ2tpEubV+mtQzjJKnVw/Bd0Y3EtMCPXf50dI8TTGex4hShZO7nQ5itYJeCeiSe3S1ScO5ZQDXuMI9f0fVq7Id+KS3oMdAmDNpCbvNIqLrirFCjcLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8KDwnUXuOzCxlMVVRXvbcEUnahNKJayk2qWL8UaU7U=;
 b=JhpQ5Ms/jkNiLnDxW3G4B7Ks7H5bXIDOD0EKWUeAhbQTA3d+6OoUxbbsLcvnJASW6kRhl0vUUQllhGFmo0qto4PAIdBdWzFFUXwhk6bTQnAsvnoLVdFPeIG81u9IGHpQo9mveAk2nsMbzuDlXLlAmh/JBMa6PVgxCk+9jPAVcGgZDndhmBsbDBh6/sdu9VApK2GL7DNuBEZBwF05xnI9lpEqQyoz6ykLWrudUDvcdWXDrqwwschgVGacLWUGbkKSm5E2xI3ZX7tunQiC8Bp7BlYUJb5icJnMesBQoFKzXdG96ec3ifrM7HPjuTkXqT92wlR/8xihQQc4lQTyCrJb0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PPF4A90670E9.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::439) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Tue, 28 Oct
 2025 13:35:05 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Tue, 28 Oct 2025
 13:35:05 +0000
Message-ID: <afc2d92c-bace-4128-b3c8-106e81cfd420@efficios.com>
Date: Tue, 28 Oct 2025 09:35:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V5 01/12] ARM: uaccess: Implement missing
 __get_user_asm_dword()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 David Laight <david.laight.linux@gmail.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
References: <20251027083700.573016505@linutronix.de>
 <20251027083745.168468637@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251027083745.168468637@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0083.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::11) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PPF4A90670E9:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ec36c05-6704-439f-f453-08de1626cd9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkF3S3RZbUdsLy9zc2R3SFZSM0VMQ3R3MHBjckVPRUczNXRFWHlnREVaL1FB?=
 =?utf-8?B?RVRuamR4dWoraFFXOUlybHlKVnE3MzllVkYvaVFqNjI4bTdnOVM1WWdEcEpR?=
 =?utf-8?B?N01zQ2p3QXpFSzJ6SDVnd2piaDZDaGdFekFKMmN6MVNzbEZ5Z0txTk1MdENu?=
 =?utf-8?B?dkRTWlMxUGlxMWJCNkJZclREd3U3RTVpZDkrcHllMWROZEY2LzRPdUw2Q1R4?=
 =?utf-8?B?UCtJMHN5cEV5KzlPSEZTSU5KR1FwT2dQcjl2dVFsUnp0YjJCWG03Ylp0ZFp3?=
 =?utf-8?B?MzRROVQ5NEpVYU56UG1LNmpNZGlKaEc1MlZkbDhPN1hPOEJDeWZDSzR4ak1x?=
 =?utf-8?B?Q0JrN21EblBLUGtnY2dXYTJsRjNPV0g4bS9UK3pXcEJFa3loR0RreEdLWUcr?=
 =?utf-8?B?eElTRC9XQ1piQ0dsSUZJSmZsaEZRcFNiT2JDVk5IM3JOWXdoL3F0VmJCYVdW?=
 =?utf-8?B?eStNWEt3WnBVWXF1bkNjL2wzZis2OFltdEI1RldIZVk1Rk9aUjRGYVpnYjFN?=
 =?utf-8?B?TXgxOHBqdlV0NERJYTBld2llV3NHa295SkVWSkp2U2ZXZ1BWbUFGMGNBdFVz?=
 =?utf-8?B?TWYzNkE4cVdQazkwVG1NcGxsRE1EYkJvTDNUR2hpTVpaWU0rODExZWxUWnh1?=
 =?utf-8?B?akhXWHdJK2RGZGxwMFZVV2ZTK2hjV2tGUEJWNit2aTNJYjlmZWdLTXh4ZUU1?=
 =?utf-8?B?UHJNcEFwK2pqV25lQ1pVV3dOVlJ4cEVhQ3J5K3ovMVZ3QmxxZEFNTW1qdWQw?=
 =?utf-8?B?ODNNSm9UTm1NTEhZaUF3QUdTZnFRWFpQam16RUM2N3pVcWZHOXhmeC9WSEdl?=
 =?utf-8?B?Q01GdVlrVFlMVGtoaWdHQUFwajRxWFpCSTNuNGtUQzZpVDZuOWcweHY1V2tq?=
 =?utf-8?B?S3ZYUDlBdE5aRTcvcEJxZmIzc0tFcERKZjdHNm9yOGdTM0JFL0xScE9PUzVv?=
 =?utf-8?B?UWtHSnJnK0wzTG5KN2tRL21rQWZVNTByWnVDeDB1L2c1SHRhRnRna3ZWNGJ5?=
 =?utf-8?B?enpla1BjU0hheFZIdmU1MmNjKy8waERoVU5VbjVXZlFMTVZaL0htblg3ZEFn?=
 =?utf-8?B?ajBHS3VVRTg5RGdQWjNWdFZIRk12Zld4VzVhNVdNK1MvYUduelBOS3VnY2xv?=
 =?utf-8?B?TFdIdzV6SjBleVBkb1IyY1ZZVHpHR2VIZk0xS0lsdGNlekFiSGxhOFdyWjhk?=
 =?utf-8?B?UmlZRlpYOFRlK0NuK2lqVVRXZWVkc1liNEVSQ2Vic1BvT2lzakZ6c2dvcEM5?=
 =?utf-8?B?Y1VoTFB3MmhvVy9iMUR2eWZacUtmdWZZSGRPYTU4eVQybmhhOXdKTDJnTmZY?=
 =?utf-8?B?UERPNUl0RzFwZGJkU0lOZ3VrMUNiUVdESmhkbnhhVGZCcTkrRmRtYWM5Tkp5?=
 =?utf-8?B?RTc5TFI4VndaMml6KzdzOWdTZkpWKzFnenRGdGFNNnd6OUlndmF0UURkcVZw?=
 =?utf-8?B?dmFiSlZjVGlYMTNMT3N2azlVU20wRFp0SmhMTnNOa1FSa0VITlljZS9KVmI1?=
 =?utf-8?B?Q3FFcVhFTmFzZTlPRkJ3c2Fkc25LU1g4UTRzdGVMOHJaZE9mSnBibHNqZUdm?=
 =?utf-8?B?N3M1K1RZc1EzdFpteXpSeTdNS1Q3UU5qTmJPL1g5VEROQU54bXFzc3N0V2tn?=
 =?utf-8?B?MjM1VEVZZGU1ZE1Wcjh2SEx0QWltY3NlZWZOdU9UcTB3U0RLbTZmV3g4RHpR?=
 =?utf-8?B?cEdUS0o2NnA1clBTVkRmaGNNdFdKbU41TlV5cUx5QUExSmkySHlwNzlaZjMz?=
 =?utf-8?B?Z2t3cTd6dk1TL1VJZkEzSEt0S3VteTlncWlPUXFSNCt0NHFrWDBGZFpOcGxI?=
 =?utf-8?B?bHJHaVZaYkJuTWFDRVVhVmVSRGtzOC94cVZxNG5oQnlsRmE3Wk43NndaMzVt?=
 =?utf-8?B?a1ZaNmRVcEI2Q21sOE5odDA4MXpSa25IcDlzWVppbjZuUEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2hsb20wekdFWDZNK1JmK0JDcjBKMEN1ZmptbTNqZCtEVDZ6enNyQTNYVkl5?=
 =?utf-8?B?Y040VTZUQXdwU0RIazJIclBxUXRRWC9YaEdQUzRUKzYwWXExalB4am9JOEF3?=
 =?utf-8?B?R0pEeE85TTkyZnc0Nnd6NVRiYTg4SDV6ZHB6WEU1RDM2cjdZY2dGbjVabk5v?=
 =?utf-8?B?aCtOSEhNeE9ka3NFQzYyWHAyUXZuUWRGM0FXSnlmbjZHYUVXRDdEaTh0ZDg0?=
 =?utf-8?B?bG5NNWJaOHVnR3R3SXpsb3g2eTBnbGpqVi9WMXBtT3ZvWit5Q3UvM3RJTk0x?=
 =?utf-8?B?SnRYcWtWWnFLbkxIVjc5TS9PWFY1OTVVWjZ2MUJzeDlTeUVwYnZzaXd3aURP?=
 =?utf-8?B?RFdsMlc2VEZNR3gxSWxmb1VMUnVIU3pQUzNUMnRHSlZ4NWpJT2pjdjdNT2Qz?=
 =?utf-8?B?ZHpZOGE2eWNPUjV3d0l5KzBwdXpJNVdmc2h5VGVQRDBaN2trdnlERzB4S3Z3?=
 =?utf-8?B?U0lVNkVYbTducysycUpFNDJBc3orcHVPNGk0dlhnR1NmWG1XVzJWOUNZdkJS?=
 =?utf-8?B?NUJSMFpBMWpRcjhQa2phSjhHRHdmamwzZk1TU082SDA4aDE3K09mTlRqWElY?=
 =?utf-8?B?SUpYQVV4UkRRT0FxcWpURzEwWjQ4WE5zQjVBVDNCR0ZPNmpCUG43R2JBN2dP?=
 =?utf-8?B?Q055SVlWY0ZYZ25LeTlZRVgvUDhUNVh4VmthZ1BsUTE0TGRQWXdqYWxOSHJY?=
 =?utf-8?B?TUNtMTF6bFdyMmRPSUFVTWpRZXdxRmFuRjBZSWhFNXBpV1VMRG1SQ0hrcDV4?=
 =?utf-8?B?dzdJK05zK1lYdUI0bEMrVzYwbFlXUE1VMUJ0d1NWc215TmZpUGMxRWxMcDZE?=
 =?utf-8?B?eXRLUXRoWVhXOEc0TFlhRWFRaTczUXhyTzhmMXBuUTVKem5ManozNjF1MUtx?=
 =?utf-8?B?MjBCcWNzdUUrZDNSZU5INGk2Z2lJWm9Xc08vS3ZKbE1ZY1dNcDJYUlcvMzlS?=
 =?utf-8?B?N2ZpczAyMGI5MGdxZWErNGxoY1FSeEp1a3RtNkZiTkVjNzNPOXlJNnVGcGVO?=
 =?utf-8?B?OFA4SVZPNk5vK213bzdSL0kyVDdSSHd6ZGEvTFVwclE5V2JVRXhFYlFnbmZi?=
 =?utf-8?B?bHZqdlFjRTZaRWNxaU1ndmsvMXUxZUVLR0ZrZkUvc3hYeStUVitaTGxOQ3h6?=
 =?utf-8?B?Tk40OEFWZWtsbnlVWThuYllIM3dwVFJXenlIR2ppZDZzaFQ0OVdtalZzWVhi?=
 =?utf-8?B?clIvbEhIYkNCZFVReGp2dFdON3h1cnU1ZXlreEFacTlHT1QvYjhlMTczY2JC?=
 =?utf-8?B?M0ZGZ3FZdUJQM2Jlc2pCdzZYQ3MzM1Q5YXd1SVJlSVZaVm9UbUZnUlN2UmQx?=
 =?utf-8?B?Wmp5RGlSWjIvdEpxd2pmazRyaGs5NzM3Wk9yemo1RXplbzgxamlXa21CQ21Q?=
 =?utf-8?B?UWlmRGdScnp2M3lHZ0xPNGZES0QwMjRsS3YrZkxSMUlHWWlpSWprRXlIS1VW?=
 =?utf-8?B?cXNxYmh6VFZkZDE5T2dxa0M4ejJzL0dUQkVTNmo1MWhBMmt1VEcxdFYzbWxp?=
 =?utf-8?B?b3hTbGdaaUFvek1ZZFpHRC95aHpmdlR2ZzF3ZHo1TlArZGo1YkpPdWNOa29r?=
 =?utf-8?B?YkRSMHdyUHJkT2R1YVF6emROdTJZdUxRQi9IQWJ6dWtnY2NkV3VCWTlFa0d4?=
 =?utf-8?B?azVHeklvNUl1ZS9yaUVuTit0OFppS1lVclZLVlE0by9FTTQzbDZhSkRoVHEy?=
 =?utf-8?B?Y1hraFFydU9ESkxlejlkM1h2VTFzc1dkTEZrUUJtblNnSkFoLzVtS2VoOG15?=
 =?utf-8?B?UHBGcE1CL05JMWZiaWJWZWFmNlpGTXhibWFZR0Y5RHpHWDhIUDA5dUZZUTVy?=
 =?utf-8?B?bHpqSVYyNDh1Z051Y0RKQVFpTTlGR3JrQ2NyLzhDaXZzMlJhQ2RBU1BaYjJS?=
 =?utf-8?B?akFKaDk5VzI3U0UyWnF6MUlQb2NoQ3hZcThENnJicS9GbFBCTnlvdXlRZlZ2?=
 =?utf-8?B?K1Z4dGppbWF4bHdTeGZQVDl4YURQc2JRbkJXNEptcFZjYVJXWUxqTms3WW5R?=
 =?utf-8?B?RlVkQm1WZTZlVDFFOVVMMHpQK1pPcWhoNEM4RDV6RXBnZ2h4K1UweE1UVDly?=
 =?utf-8?B?MkNVNTZxNTFhZTBGWE9ZVCttd1Bna0JycHNFc0lueWJ6YytDY2VZTll2bWtY?=
 =?utf-8?B?RVZVeWFiN01LeFhlMWtUbTlGL0pnWDQ4cHVyWEVFbjZ6ZGNqYXFmaEZYM1Qv?=
 =?utf-8?Q?rAVBe4jYTzTnYNb3xpF64+Q=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec36c05-6704-439f-f453-08de1626cd9f
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 13:35:05.0773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wP09yp6S+orkLte9S9UPeLZTzV5lqKu/M4OvcaenOaYvP92IZ3cIVNxSzNzBizHwF0txA3V1dK//CaXkUOpcjdzQKELtMpkc24gTvjziHYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PPF4A90670E9

On 2025-10-27 04:43, Thomas Gleixner wrote:
> When CONFIG_CPU_SPECTRE=n then get_user() is missing the 8 byte ASM variant
> for no real good reason. This prevents using get_user(u64) in generic code.
> 
> Implement it as a sequence of two 4-byte reads with LE/BE awareness and
> make the unsigned long (or long long) type for the intermediate variable to
> read into dependend on the the target type.
> 
> The __long_type() macro and idea was lifted from PowerPC. Thanks to
> Christophe for pointing it out.

[...]

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

