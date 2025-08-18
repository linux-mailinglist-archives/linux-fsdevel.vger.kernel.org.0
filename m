Return-Path: <linux-fsdevel+bounces-58118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670CDB2994B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 08:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC66D7A4A4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 06:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4466270EAB;
	Mon, 18 Aug 2025 06:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C8rsJmjM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20AB17A300;
	Mon, 18 Aug 2025 06:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755497092; cv=fail; b=k0hnwDFFdFeARAiI0zbxGpG/zhGIWdDjAizmvKanvz3rhT2eVUAQGcMO1zerLGBzV/GQG35nM236AHB9uR8Aj1hAWxuQjBv6ydgkABN6hV9GFO6kpR0t33BigZcvvDAzERQnjRMc26AOpsDE+NsM1WQQNeueK2OmOULxFtZwnOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755497092; c=relaxed/simple;
	bh=KemBu90u5+SmO7SjrrizF39tz06l624a557EbylKYsw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZfnG3AAVOZvggwtOLoMzZ3jD+M7bbe7HowgubNGneCmwEbSHBnJDnbeVnnNy+rZxmhwLU5yA1zLarxSG56PR3Hl4FWvq8nTTf5Vrkr8NssUEMytEE33MYWxk5kRUZhWt04XMknbx5gMiD7RCe+VsCFLVn3EN6TbcmAafL5fQKkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C8rsJmjM; arc=fail smtp.client-ip=40.107.96.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcT0jm2WvIdwZdxsItOJ5sxkdG4Eq9TR/rg5XGq5yP6urxiK9Tp1oLqrda2VdPRoXS+5EaoGvaXNcIvy0e+MiiGw8R+TwjQvZKiXxeUcDtwi8SEb/8QLUqExoMtNkEQ6nPZovOmI1t6MtO+t3xDtIzG/Low7UTlgt/edgWQaHvLd2ujKYKGuRpvdB9yPakrjV+eav3Sjcd2F653iZKDJXgPq+Cu8xM/WH7/qY5/FIzQAKpBfYnvNs77YCtZReuS4P8OPkiImb674D63v4brqEdUR0tq/ily5CXSYYoNlWlYLu3PIK5NWgSnNMY6SHGQGJ2ulOe+D2lIm2/eqBFMyyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGJjqlAgd5bUd3iAIX+NtRnD1Vrovcf8+RM0qletz6k=;
 b=aSu7gGNVO2AiuiaM8wOihz4RMi91bFuLsR033yTjWfLGtc2VFRZbSprZ2mmMTsWHvsfu/3cgXoDE/qFLLpxoZ6WbLfcHCqnOw1xvkYpTHrbFzkXExGNujVbIRAiRKzIb/3aYy0ER0/MkSOgS2l3l/eCevoCSyw6Yhw5bfANMpwaIp59jBBHd8tLU9ilri7joxwX3FjAVRp7keu0RDrIlD3cxW9qVU5eH5fdckTYzGxiuJ99mAVXDVZsuwpQj+YzWjOc1AeHH6DQpP+vtC+/42O3NxHhPFEHJ4cgBLrtlXoNbXiTnR+WkcXG7SHgLNZt1eUY3pYI12JK+F/1bL+HPFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGJjqlAgd5bUd3iAIX+NtRnD1Vrovcf8+RM0qletz6k=;
 b=C8rsJmjMOwdqH8FrERUw9K++APud/rl9lnXVvSOjXMt4X0nFU4iB2hT6maX7WL4lVvc0PVU78yk+8cOrqSf59mPBBS7dpxdbCKHXdnSD8SSZEN5/awTPGXdvfgo6DlfxLdpq4Mvru0AulZsSr+qqxZqvOHkbSK0IEQkJklQuZkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6111.namprd12.prod.outlook.com (2603:10b6:8:ac::21) by
 DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Mon, 18 Aug 2025 06:04:44 +0000
Received: from DM4PR12MB6111.namprd12.prod.outlook.com
 ([fe80::f950:35e1:bd25:224d]) by DM4PR12MB6111.namprd12.prod.outlook.com
 ([fe80::f950:35e1:bd25:224d%7]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 06:04:44 +0000
Message-ID: <93db1417-cf3c-4316-a194-9c41001f10cf@amd.com>
Date: Mon, 18 Aug 2025 11:34:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15] exec: Fix dead-lock in de_thread with ptrace_attach
To: Bernd Edlinger <bernd.edlinger@hotmail.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Alexey Dobriyan <adobriyan@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
 Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>,
 Will Drewry <wad@chromium.org>, Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>,
 Serge Hallyn <serge@hallyn.com>, James Morris
 <jamorris@linux.microsoft.com>, Randy Dunlap <rdunlap@infradead.org>,
 Suren Baghdasaryan <surenb@google.com>, Yafang Shao <laoar.shao@gmail.com>,
 Helge Deller <deller@gmx.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
 Adrian Reber <areber@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Jens Axboe <axboe@kernel.dk>, Alexei Starovoitov <ast@kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 tiozhang <tiozhang@didiglobal.com>, Luis Chamberlain <mcgrof@kernel.org>,
 "Paulo Alcantara (SUSE)" <pc@manguebit.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Frederic Weisbecker <frederic@kernel.org>, YueHaibing
 <yuehaibing@huawei.com>, Paul Moore <paul@paul-moore.com>,
 Aleksa Sarai <cyphar@cyphar.com>, Stefan Roesch <shr@devkernel.io>,
 Chao Yu <chao@kernel.org>, xu xin <xu.xin16@zte.com.cn>,
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
 David Hildenbrand <david@redhat.com>, Dave Chinner <dchinner@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Zheng Yejian <zhengyejian1@huawei.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 David Windsor <dwindsor@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>,
 Ard Biesheuvel <ardb@kernel.org>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Hans Liljestrand <ishkamiel@gmail.com>, Naveen N Rao <naveen.rao@amd.com>
References: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Content-Language: en-US
From: "Jain, Ayush" <ayushjai@amd.com>
In-Reply-To: <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26c::6) To DM4PR12MB6111.namprd12.prod.outlook.com
 (2603:10b6:8:ac::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6111:EE_|DM6PR12MB4337:EE_
X-MS-Office365-Filtering-Correlation-Id: 2accafad-1ce4-4b38-8e56-08ddde1d20c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHN2R2w5S0FtWkpzWjBNOWs1a2lQSnVLeTAyRExyQ09jRHN5UnRXVUpYV3lV?=
 =?utf-8?B?WjBjMURBRUk4RmtQRGIwcElOOXR3cmZSalBCMXpPRkVObERsR01DUnd1RGNr?=
 =?utf-8?B?OEg4WCtObit5YkNUbCt3Q2xyWHpGb0pOZmpLb2xYY2ZHbUN6NU9ZN3ZlTjlH?=
 =?utf-8?B?djBhTy9ZWTE3aGxlV0VodS9jczJqL2dHaW1wY21HR3VqakxHOWF4RU5tMFht?=
 =?utf-8?B?RENaczdlV3ZZVmNUUE1aMk5IMEtYMkZDcTB4RmRic1dqaXFHbWROYXhZeXo3?=
 =?utf-8?B?YlFLQ1Z1Q2pJVTdxMjBxbE1lcXFuaS9kQlBnSk81TnptM1IwUlE4c0NvdXZM?=
 =?utf-8?B?YnNhYmVselVvb2tXcEJsenJlWGVmOTRTWnNWL2ZzTnpzOFNsYVZmeGFHVjdm?=
 =?utf-8?B?b3YveW43eXVOY2lXWk5CWnFkWXBkVStZV1FQRkpaWFA3cDNZWklEZkdON2xt?=
 =?utf-8?B?MUlsQmQ5Y2gwWnQ3QmVXK0krbUJuT29Ya1JNL0FZRm43elFRZWdqaXpYeVBS?=
 =?utf-8?B?Rk1pREN3N0xHMFRBOS9kMUtZNkhEWEs3OEh5ejE2U01jazQzK0JEbE9LOEZH?=
 =?utf-8?B?QUk5WjRJamlKV1NoVGc4WkhiMFd2RU5McGN3aVVrSlFidWdKdHNFVDBGZkNC?=
 =?utf-8?B?U3JoSTVuMU9raFplUmdoNWc5RU5zL0FNQnZnOCtwOXMrWGpWUk5MbTQwRlEw?=
 =?utf-8?B?bktUWE02QXM1UXZJQUNOdE1PMTRuV0hLQkRnakxNWDlEY1JHUXgrWGdFR21u?=
 =?utf-8?B?RGQ5VTVmazZDMk9qRWs1QUFYSUJ3aXJRYUZmc3FZWGNIY3pNZkhvdmg3akhU?=
 =?utf-8?B?TUNBalZGcEppYmN0U2xOVXlaMk0vRi9SV0RNZ3llRW9RaUo1N2c2UldvYWky?=
 =?utf-8?B?R0tzQnJmVFhDQ2p2cjVOaU4rNnRDQ0grU1ZsTUwxbWNDSFBTZ0Y3cEVuUDUw?=
 =?utf-8?B?V3k2YWVQaExpRHU3cUhuYUdUbHZja1VaQk9KN0FSQStSSklXTlozdDJDZ0Rr?=
 =?utf-8?B?b1JMcUora1lNUU92dWV4WEhmQUlJSFluV1NKVGNIaU43VTJzU1lkRWJUdHVZ?=
 =?utf-8?B?VlBZU3MxRnZFdkhQcWFjdlZncnJzL1Z0Y1FrSnpESjNQZFU1dUJoTmFabHVn?=
 =?utf-8?B?NXVkejZvMGFPdE5vL0NKTnU0SEhjR09rd3NiNk5MUTFOZ2duaUZyakxxYU8v?=
 =?utf-8?B?cGRlaFc0TUlubnlobDM3ZTY4elVmRG5iemx3aHIrQzIrYVo2TGhnTXl4NURU?=
 =?utf-8?B?Q1lXSEVZandKWEQ5SjhqL2hUbVlsUHRvQzVjQSs1YTk1dVZKbkFDaHh3OHNh?=
 =?utf-8?B?MmpYb3g0TkRaQmZjYzVPVWQ1RkJ6bkNlR2crYURmb2M3elR6YWpzdGhxcW5L?=
 =?utf-8?B?RUg1ZkVUOXlnSS9EbTJUTXlHc29BMTdmdDFzbVFybXVBckUrZllCV081MXhL?=
 =?utf-8?B?bzdLZFU1Mkt4OWhDWlFSYlRIYktMSWlPZFE5eERLdlFWYm1DOWJsaXA3STA0?=
 =?utf-8?B?QlJadmZJV2VXNHVuejJuWVBhYlBxbDBXcFp1RVR2dThoaWdyYnowTFhhclBs?=
 =?utf-8?B?ZkVYbWpGZktraE83Y2tNai8vWk96Y3d4NDRqV3JoN0tJVTl2QW5LOHlTRlFs?=
 =?utf-8?B?YnFtY2dXRmZSWVdmSUh4elRJZ3lobkxTWWIwYTg3NHB3OFlKcmZOTXFIanVY?=
 =?utf-8?B?N3dqemRBL2NUVzNOT2hCQ2Eyc3cvSVVjZ1Y3eHZ0YkhzY2dCZjhiTnBIT29P?=
 =?utf-8?B?T2pLbEs5MFozcmRIa0RiYTlJMWFtQnc1Z2QzeXRFd2pJYnE5MzQ3S241Y3RD?=
 =?utf-8?B?WE90TmozNE93aUM5WW1RbWY3RCt6aXpSVElISUwvWGVVci9vLzM5WlZjdnZy?=
 =?utf-8?B?VnVPT3hpM2VhMm9PbzlQenhxMVZ2UklUV2tYRjZZTmovejNLUTVEcnltWVAx?=
 =?utf-8?Q?XmXpvxdPaJY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6111.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEVCY1hTaWhId1hrdnN3WmVpTEhzbkZCeVJiQ29nK1EyWmFGK2VQRDNiWmJU?=
 =?utf-8?B?ZkprQ1VxYzQxdDJ6Z212OE5VVjhKVGVRcnJNRXFrYWJiMlYzT0xvb0YwS2lN?=
 =?utf-8?B?bUhHbmM4UUdtM0xJU0kzVHRIWFkvOWVPQ2RxZVBGZGRHUno0Y3lrZjF5cWFH?=
 =?utf-8?B?T0oxNWdsQ251K2tDcDVrOU1zZ09KdTBCdFlpRTEyUjUyRmlvendsZFpOR0I5?=
 =?utf-8?B?RitkbDNJdEdQQXpRRHo5OWthbDBVcnE2d0wxYVM0VVI1OFF4cWd2aHRHbnpm?=
 =?utf-8?B?dHZGaXZob3hneWFWRmpXU09JSVE4eUZpNHA3alRac3psWW1pRVBJeWkvYlQr?=
 =?utf-8?B?QmEyRnNEVEd1ajFZcXBIQjRCTFkxL3pPVWlWSmZLaE1YT3gzbFM1NklvdUpS?=
 =?utf-8?B?a2RFSVV6ZCtoNTRBdCtRbHUyVmpsRUE2b3RPeXpNVlJPNE1FdXBLa0NqSU1o?=
 =?utf-8?B?ejArQUdGWUE2RGJvN2plTHBCTWRoc3hHejlHVmd4MGRiL0YzU1FWZ0pYeUh6?=
 =?utf-8?B?RUN2b3ExWTZJRGltbklLUUcrekdQWThlQXRCSktSZ1RCalJMSGlrZ1VoVGJv?=
 =?utf-8?B?U3JnMXYvM3dYYXF4eUd4WExKZTR5V2N6QnYzK285MGVzbHkxQkhLVVd4NEQ5?=
 =?utf-8?B?NUZLTjJoNkFubHpBT1Bha2pZZUs3ajdRK1ljd0RJaTZ6NFA0NTEybFR0ZzhG?=
 =?utf-8?B?NDQ5S3F1VVpHRnpDR0RWc3R5OHdpMXp4ODJkY3BrcEZEcGJoUmo5eU1KcG9T?=
 =?utf-8?B?OVdIMDBQZkpZMW5pUXBJeEU1RHFXVlpCeHhOT2JCWWdTalhSdlRHQzk4Uks0?=
 =?utf-8?B?Rm82VlorZy9oOGxBWFpKcElrbGtJd1BoUGJCVlg2cGpqMnNxSUpaVEdXT1p4?=
 =?utf-8?B?Ykc0QVV3aTN4ZVJZQnhhVk5PRTY0QmtyY0JGTnR5cC85c3RHRHJpM0p5Rk56?=
 =?utf-8?B?UXdSSmNrYTBMaHlDeDJtVVdNbGJnY3NUeS81a0RTNWUwWWNjV2ZuSzNXZFNt?=
 =?utf-8?B?ZFIxR1hITy9ockNTSUhDL2tIaW9JZ2NUdDlkNm0zK0VqTm51MlZsZkdjbFM4?=
 =?utf-8?B?VUt1UTJKbDhVb2NBT3AyZG4wZWRQdzNXdWFBK2xHbHMwTGEvc01iOGJPN0Z3?=
 =?utf-8?B?VkJ2OGpSelpCVXptNnp6QmJaUWROQTl1aXowNHovaFBkZTlzK2YzTW9wWWg2?=
 =?utf-8?B?Vm9vcVN2QnRPRjg1VEU1WUtNcEw2NnY0YStyY2VZcHVUSmRrVnh0VzlHUnp4?=
 =?utf-8?B?R1RXdUJqVWhqaFNHTmwwazNpdHJIUGJrTmFlaHJmZi9IWElBSFVJaG5hKzQ4?=
 =?utf-8?B?Tm4rYlE4SkJwbi9BWTdBV1E0U2U3UUZMbVo0OUplR3JxU3R3TWcwYSt4WHY2?=
 =?utf-8?B?WlEvK1JDYlh6MXZkYXlyek1obHlZVGdwOXgzY1Jxc0IvTDYyaDZWK2NGNFZT?=
 =?utf-8?B?TFRaZWhCYTFGSUtVM24rUmdPTFR0ejBDd0hMcVBQRjVLNWZMWFB0VlZ3VStY?=
 =?utf-8?B?VnRNU2h2djVHNWE0bDRDUWp4SjFrOTVpcDE3OGQvN2w0R2tzSnVnbUJxcDU3?=
 =?utf-8?B?WS9pMnRIR2lvOCs2WVBjUWNGaXBzbHVRNEdBS0g4ajFWWVlVQ21SL1c3Tmtw?=
 =?utf-8?B?WGI2VkwrMmxmdDI4N0hsYUpaeW52U01pL3A2SWtyR0c5TkhWNXdua09ILzc5?=
 =?utf-8?B?VUZmNXg4VGMxaEl4Sk5TdnQwMm5FenZqREVmQW5oU0tBWUE1UzM4ZnlBSTZk?=
 =?utf-8?B?Rms5aEd0VHpxU090VUF2QjlJekl1dnk4WkE0VE9UQTBORSsxNS81R08zN2tW?=
 =?utf-8?B?Rkk3RUV0RFV3Z1lOeFJiT1RLcXBQUnFFbVlsa25MaytJR0RTS1VHdlNGOXAv?=
 =?utf-8?B?VmxReFZDcWJUK0IvdStORzdGeG0yTmhsRG5CWHAwb3dYQWlHeWtqNXVqTjZ0?=
 =?utf-8?B?QVdycVU4VzNTbFgyWjhCU2srdldXaklrdnFFTEJRYTd6cXdFZHUwWE9Kb3dM?=
 =?utf-8?B?cGd4cFVabGwzZzVBQlBHbDVkVlVHUXVtazExWFR1VGpYQjJUWEFQZXl1K0Iv?=
 =?utf-8?B?Q2o1c2V0MWI0Nis2Q2g1bzRoOGZWYWJKdHpCSzhnc09LZGN0ZUpGSm82cDg0?=
 =?utf-8?Q?fFvoWUVUzxDtUbCiiwD/4UiSf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2accafad-1ce4-4b38-8e56-08ddde1d20c5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6111.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 06:04:44.7399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCKDM6m31ipsWlLz4NGCVFmBhEnnsN70q1uuugezLYnpX02Ab7iSsBZQ9UoWUagAsHfiDVz2FRQ4IhrqKTAI1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337

Hello Bernd,
As it's been a long standing issue, and test still fails.

Will you be working on fixing it again in future?
or it might be better to remove the testcase?

  $ ./vmaccess
  TAP version 13
  1..2
  # Starting 2 tests from 1 test cases.
  #  RUN           global.vmaccess ...
  #            OK  global.vmaccess
  ok 1 global.vmaccess
  #  RUN           global.attach ...
  # attach: Test terminated by timeout
  #          FAIL  global.attach
  not ok 2 global.attach
  # FAILED: 1 / 2 tests passed.
  # Totals: pass:1 fail:1 xfail:0 xpass:0 skip:0 error:0

Thanks,
Ayush

On 1/23/2024 12:01 AM, Bernd Edlinger wrote:
> This introduces signal->exec_bprm, which is used to
> fix the case when at least one of the sibling threads
> is traced, and therefore the trace process may dead-lock
> in ptrace_attach, but de_thread will need to wait for the
> tracer to continue execution.
> 
> The problem happens when a tracer tries to ptrace_attach
> to a multi-threaded process, that does an execve in one of
> the threads at the same time, without doing that in a forked
> sub-process.  That means: There is a race condition, when one
> or more of the threads are already ptraced, but the thread
> that invoked the execve is not yet traced.  Now in this
> case the execve locks the cred_guard_mutex and waits for
> de_thread to complete.  But that waits for the traced
> sibling threads to exit, and those have to wait for the
> tracer to receive the exit signal, but the tracer cannot
> call wait right now, because it is waiting for the ptrace
> call to complete, and this never does not happen.
> The traced process and the tracer are now in a deadlock
> situation, and can only be killed by a fatal signal.
> 
> The solution is to detect this situation and allow
> ptrace_attach to continue by temporarily releasing the
> cred_guard_mutex, while de_thread() is still waiting for
> traced zombies to be eventually released by the tracer.
> In the case of the thread group leader we only have to wait
> for the thread to become a zombie, which may also need
> co-operation from the tracer due to PTRACE_O_TRACEEXIT.
> 
> When a tracer wants to ptrace_attach a task that already
> is in execve, we simply retry the ptrace_may_access
> check while temporarily installing the new credentials
> and dumpability which are about to be used after execve
> completes.  If the ptrace_attach happens on a thread that
> is a sibling-thread of the thread doing execve, it is
> sufficient to check against the old credentials, as this
> thread will be waited for, before the new credentials are
> installed.
> 
> Other threads die quickly since the cred_guard_mutex is
> released, but a deadly signal is already pending.  In case
> the mutex_lock_killable misses the signal, the non-zero
> current->signal->exec_bprm makes sure they release the
> mutex immediately and return with -ERESTARTNOINTR.
> 
> This means there is no API change, unlike the previous
> version of this patch which was discussed here:
> 
> https://lore.kernel.org/lkml/b6537ae6-31b1-5c50-f32b-8b8332ace882@hotmail.de/
> 
> See tools/testing/selftests/ptrace/vmaccess.c
> for a test case that gets fixed by this change.
> 
> Note that since the test case was originally designed to
> test the ptrace_attach returning an error in this situation,
> the test expectation needed to be adjusted, to allow the
> API to succeed at the first attempt.
> 
> Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
> ---
>  fs/exec.c                                 |  69 ++++++++---
>  fs/proc/base.c                            |   6 +
>  include/linux/cred.h                      |   1 +
>  include/linux/sched/signal.h              |  18 +++
>  kernel/cred.c                             |  30 ++++-
>  kernel/ptrace.c                           |  31 +++++
>  kernel/seccomp.c                          |  12 +-
>  tools/testing/selftests/ptrace/vmaccess.c | 135 ++++++++++++++++++++--
>  8 files changed, 265 insertions(+), 37 deletions(-)
> 
> v10: Changes to previous version, make the PTRACE_ATTACH
> return -EAGAIN, instead of execve return -ERESTARTSYS.
> Added some lessions learned to the description.
> 
> v11: Check old and new credentials in PTRACE_ATTACH again without
> changing the API.
> 
> Note: I got actually one response from an automatic checker to the v11 patch,
> 
> https://lore.kernel.org/lkml/202107121344.wu68hEPF-lkp@intel.com/
> 
> which is complaining about:
> 
>>>>> kernel/ptrace.c:425:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const *old_cred @@     got struct cred const [noderef] __rcu *real_cred @@
> 
>    417			struct linux_binprm *bprm = task->signal->exec_bprm;
>    418			const struct cred *old_cred;
>    419			struct mm_struct *old_mm;
>    420	
>    421			retval = down_write_killable(&task->signal->exec_update_lock);
>    422			if (retval)
>    423				goto unlock_creds;
>    424			task_lock(task);
>  > 425			old_cred = task->real_cred;
> 
> v12: Essentially identical to v11.
> 
> - Fixed a minor merge conflict in linux v5.17, and fixed the
> above mentioned nit by adding __rcu to the declaration.
> 
> - re-tested the patch with all linux versions from v5.11 to v6.6
> 
> v10 was an alternative approach which did imply an API change.
> But I would prefer to avoid such an API change.
> 
> The difficult part is getting the right dumpability flags assigned
> before de_thread starts, hope you like this version.
> If not, the v10 is of course also acceptable.
> 
> v13: Fixed duplicated Return section in function header of
> is_dumpability_changed which was reported by the kernel test robot
> 
> v14: rebased to v6.7, refreshed and retested.
> And added a more detailed description of the actual bug.
> 
> v15: rebased to v6.8-rc1, addressed some review comments.
> Split the test case vmaccess into vmaccess1 and vmaccess2
> to improve overall test coverage.
> 
> 
> Thanks
> Bernd.
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index e88249a1ce07..499380d74899 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1040,11 +1040,13 @@ static int exec_mmap(struct mm_struct *mm)
>  	return 0;
>  }
>  
> -static int de_thread(struct task_struct *tsk)
> +static int de_thread(struct task_struct *tsk, struct linux_binprm *bprm)
>  {
>  	struct signal_struct *sig = tsk->signal;
>  	struct sighand_struct *oldsighand = tsk->sighand;
>  	spinlock_t *lock = &oldsighand->siglock;
> +	struct task_struct *t;
> +	bool unsafe_execve_in_progress = false;
>  
>  	if (thread_group_empty(tsk))
>  		goto no_thread_group;
> @@ -1067,6 +1069,19 @@ static int de_thread(struct task_struct *tsk)
>  	if (!thread_group_leader(tsk))
>  		sig->notify_count--;
>  
> +	for_other_threads(tsk, t) {
> +		if (unlikely(t->ptrace)
> +		    && (t != tsk->group_leader || !t->exit_state))
> +			unsafe_execve_in_progress = true;
> +	}
> +
> +	if (unlikely(unsafe_execve_in_progress)) {
> +		spin_unlock_irq(lock);
> +		sig->exec_bprm = bprm;
> +		mutex_unlock(&sig->cred_guard_mutex);
> +		spin_lock_irq(lock);
> +	}
> +
>  	while (sig->notify_count) {
>  		__set_current_state(TASK_KILLABLE);
>  		spin_unlock_irq(lock);
> @@ -1157,6 +1172,11 @@ static int de_thread(struct task_struct *tsk)
>  		release_task(leader);
>  	}
>  
> +	if (unlikely(unsafe_execve_in_progress)) {
> +		mutex_lock(&sig->cred_guard_mutex);
> +		sig->exec_bprm = NULL;
> +	}
> +
>  	sig->group_exec_task = NULL;
>  	sig->notify_count = 0;
>  
> @@ -1168,6 +1188,11 @@ static int de_thread(struct task_struct *tsk)
>  	return 0;
>  
>  killed:
> +	if (unlikely(unsafe_execve_in_progress)) {
> +		mutex_lock(&sig->cred_guard_mutex);
> +		sig->exec_bprm = NULL;
> +	}
> +
>  	/* protects against exit_notify() and __exit_signal() */
>  	read_lock(&tasklist_lock);
>  	sig->group_exec_task = NULL;
> @@ -1252,6 +1277,24 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	if (retval)
>  		return retval;
>  
> +	/* If the binary is not readable then enforce mm->dumpable=0 */
> +	would_dump(bprm, bprm->file);
> +	if (bprm->have_execfd)
> +		would_dump(bprm, bprm->executable);
> +
> +	/*
> +	 * Figure out dumpability. Note that this checking only of current
> +	 * is wrong, but userspace depends on it. This should be testing
> +	 * bprm->secureexec instead.
> +	 */
> +	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
> +	    is_dumpability_changed(current_cred(), bprm->cred) ||
> +	    !(uid_eq(current_euid(), current_uid()) &&
> +	      gid_eq(current_egid(), current_gid())))
> +		set_dumpable(bprm->mm, suid_dumpable);
> +	else
> +		set_dumpable(bprm->mm, SUID_DUMP_USER);
> +
>  	/*
>  	 * Ensure all future errors are fatal.
>  	 */
> @@ -1260,7 +1303,7 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	/*
>  	 * Make this the only thread in the thread group.
>  	 */
> -	retval = de_thread(me);
> +	retval = de_thread(me, bprm);
>  	if (retval)
>  		goto out;
>  
> @@ -1283,11 +1326,6 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	if (retval)
>  		goto out;
>  
> -	/* If the binary is not readable then enforce mm->dumpable=0 */
> -	would_dump(bprm, bprm->file);
> -	if (bprm->have_execfd)
> -		would_dump(bprm, bprm->executable);
> -
>  	/*
>  	 * Release all of the old mmap stuff
>  	 */
> @@ -1349,18 +1387,6 @@ int begin_new_exec(struct linux_binprm * bprm)
>  
>  	me->sas_ss_sp = me->sas_ss_size = 0;
>  
> -	/*
> -	 * Figure out dumpability. Note that this checking only of current
> -	 * is wrong, but userspace depends on it. This should be testing
> -	 * bprm->secureexec instead.
> -	 */
> -	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
> -	    !(uid_eq(current_euid(), current_uid()) &&
> -	      gid_eq(current_egid(), current_gid())))
> -		set_dumpable(current->mm, suid_dumpable);
> -	else
> -		set_dumpable(current->mm, SUID_DUMP_USER);
> -
>  	perf_event_exec();
>  	__set_task_comm(me, kbasename(bprm->filename), true);
>  
> @@ -1479,6 +1505,11 @@ static int prepare_bprm_creds(struct linux_binprm *bprm)
>  	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
>  		return -ERESTARTNOINTR;
>  
> +	if (unlikely(current->signal->exec_bprm)) {
> +		mutex_unlock(&current->signal->cred_guard_mutex);
> +		return -ERESTARTNOINTR;
> +	}
> +
>  	bprm->cred = prepare_exec_creds();
>  	if (likely(bprm->cred))
>  		return 0;
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 98a031ac2648..eab3461e4da7 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2785,6 +2785,12 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
>  	if (rv < 0)
>  		goto out_free;
>  
> +	if (unlikely(current->signal->exec_bprm)) {
> +		mutex_unlock(&current->signal->cred_guard_mutex);
> +		rv = -ERESTARTNOINTR;
> +		goto out_free;
> +	}
> +
>  	rv = security_setprocattr(PROC_I(inode)->op.lsmid,
>  				  file->f_path.dentry->d_name.name, page,
>  				  count);
> diff --git a/include/linux/cred.h b/include/linux/cred.h
> index 2976f534a7a3..a1a1ac38f749 100644
> --- a/include/linux/cred.h
> +++ b/include/linux/cred.h
> @@ -153,6 +153,7 @@ extern const struct cred *get_task_cred(struct task_struct *);
>  extern struct cred *cred_alloc_blank(void);
>  extern struct cred *prepare_creds(void);
>  extern struct cred *prepare_exec_creds(void);
> +extern bool is_dumpability_changed(const struct cred *, const struct cred *);
>  extern int commit_creds(struct cred *);
>  extern void abort_creds(struct cred *);
>  extern const struct cred *override_creds(const struct cred *);
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 4b7664c56208..6364e115e9e9 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -235,9 +235,27 @@ struct signal_struct {
>  	struct mm_struct *oom_mm;	/* recorded mm when the thread group got
>  					 * killed by the oom killer */
>  
> +	struct linux_binprm *exec_bprm;	/* Used to check ptrace_may_access
> +					 * against new credentials while
> +					 * de_thread is waiting for other
> +					 * traced threads to terminate.
> +					 * Set while de_thread is executing.
> +					 * The cred_guard_mutex is released
> +					 * after de_thread() has called
> +					 * zap_other_threads(), therefore
> +					 * a fatal signal is guaranteed to be
> +					 * already pending in the unlikely
> +					 * event, that
> +					 * current->signal->exec_bprm happens
> +					 * to be non-zero after the
> +					 * cred_guard_mutex was acquired.
> +					 */
> +
>  	struct mutex cred_guard_mutex;	/* guard against foreign influences on
>  					 * credential calculations
>  					 * (notably. ptrace)
> +					 * Held while execve runs, except when
> +					 * a sibling thread is being traced.
>  					 * Deprecated do not use in new code.
>  					 * Use exec_update_lock instead.
>  					 */
> diff --git a/kernel/cred.c b/kernel/cred.c
> index c033a201c808..0066b5b0f052 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -375,6 +375,30 @@ static bool cred_cap_issubset(const struct cred *set, const struct cred *subset)
>  	return false;
>  }
>  
> +/**
> + * is_dumpability_changed - Will changing creds affect dumpability?
> + * @old: The old credentials.
> + * @new: The new credentials.
> + *
> + * If the @new credentials have no elevated privileges compared to the
> + * @old credentials, the task may remain dumpable.  Otherwise we have
> + * to mark the task as undumpable to avoid information leaks from higher
> + * to lower privilege domains.
> + *
> + * Return: True if the task will become undumpable.
> + */
> +bool is_dumpability_changed(const struct cred *old, const struct cred *new)
> +{
> +	if (!uid_eq(old->euid, new->euid) ||
> +	    !gid_eq(old->egid, new->egid) ||
> +	    !uid_eq(old->fsuid, new->fsuid) ||
> +	    !gid_eq(old->fsgid, new->fsgid) ||
> +	    !cred_cap_issubset(old, new))
> +		return true;
> +
> +	return false;
> +}
> +
>  /**
>   * commit_creds - Install new credentials upon the current task
>   * @new: The credentials to be assigned
> @@ -403,11 +427,7 @@ int commit_creds(struct cred *new)
>  	get_cred(new); /* we will require a ref for the subj creds too */
>  
>  	/* dumpability changes */
> -	if (!uid_eq(old->euid, new->euid) ||
> -	    !gid_eq(old->egid, new->egid) ||
> -	    !uid_eq(old->fsuid, new->fsuid) ||
> -	    !gid_eq(old->fsgid, new->fsgid) ||
> -	    !cred_cap_issubset(old, new)) {
> +	if (is_dumpability_changed(old, new)) {
>  		if (task->mm)
>  			set_dumpable(task->mm, suid_dumpable);
>  		task->pdeath_signal = 0;
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 2fabd497d659..4b9a951b38f1 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -20,6 +20,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/ptrace.h>
>  #include <linux/security.h>
> +#include <linux/binfmts.h>
>  #include <linux/signal.h>
>  #include <linux/uio.h>
>  #include <linux/audit.h>
> @@ -450,6 +451,27 @@ static int ptrace_attach(struct task_struct *task, long request,
>  				return retval;
>  		}
>  
> +		if (unlikely(task->in_execve)) {
> +			retval = down_write_killable(&task->signal->exec_update_lock);
> +			if (retval)
> +				return retval;
> +
> +			scoped_guard (task_lock, task) {
> +				struct linux_binprm *bprm = task->signal->exec_bprm;
> +				const struct cred __rcu *old_cred = task->real_cred;
> +				struct mm_struct *old_mm = task->mm;
> +				rcu_assign_pointer(task->real_cred, bprm->cred);
> +				task->mm = bprm->mm;
> +				retval = __ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS);
> +				rcu_assign_pointer(task->real_cred, old_cred);
> +				task->mm = old_mm;
> +			}
> +
> +			up_write(&task->signal->exec_update_lock);
> +			if (retval)
> +				return retval;
> +		}
> +
>  		scoped_guard (write_lock_irq, &tasklist_lock) {
>  			if (unlikely(task->exit_state))
>  				return -EPERM;
> @@ -491,6 +513,14 @@ static int ptrace_traceme(void)
>  {
>  	int ret = -EPERM;
>  
> +	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
> +		return -ERESTARTNOINTR;
> +
> +	if (unlikely(current->signal->exec_bprm)) {
> +		mutex_unlock(&current->signal->cred_guard_mutex);
> +		return -ERESTARTNOINTR;
> +	}
> +
>  	write_lock_irq(&tasklist_lock);
>  	/* Are we already being traced? */
>  	if (!current->ptrace) {
> @@ -506,6 +536,7 @@ static int ptrace_traceme(void)
>  		}
>  	}
>  	write_unlock_irq(&tasklist_lock);
> +	mutex_unlock(&current->signal->cred_guard_mutex);
>  
>  	return ret;
>  }
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index aca7b437882e..32ed0da5939a 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1955,9 +1955,15 @@ static long seccomp_set_mode_filter(unsigned int flags,
>  	 * Make sure we cannot change seccomp or nnp state via TSYNC
>  	 * while another thread is in the middle of calling exec.
>  	 */
> -	if (flags & SECCOMP_FILTER_FLAG_TSYNC &&
> -	    mutex_lock_killable(&current->signal->cred_guard_mutex))
> -		goto out_put_fd;
> +	if (flags & SECCOMP_FILTER_FLAG_TSYNC) {
> +		if (mutex_lock_killable(&current->signal->cred_guard_mutex))
> +			goto out_put_fd;
> +
> +		if (unlikely(current->signal->exec_bprm)) {
> +			mutex_unlock(&current->signal->cred_guard_mutex);
> +			goto out_put_fd;
> +		}
> +	}
>  
>  	spin_lock_irq(&current->sighand->siglock);
>  
> diff --git a/tools/testing/selftests/ptrace/vmaccess.c b/tools/testing/selftests/ptrace/vmaccess.c
> index 4db327b44586..5d4a65eb5a8d 100644
> --- a/tools/testing/selftests/ptrace/vmaccess.c
> +++ b/tools/testing/selftests/ptrace/vmaccess.c
> @@ -14,6 +14,7 @@
>  #include <signal.h>
>  #include <unistd.h>
>  #include <sys/ptrace.h>
> +#include <sys/syscall.h>
>  
>  static void *thread(void *arg)
>  {
> @@ -23,7 +24,7 @@ static void *thread(void *arg)
>  
>  TEST(vmaccess)
>  {
> -	int f, pid = fork();
> +	int s, f, pid = fork();
>  	char mm[64];
>  
>  	if (!pid) {
> @@ -31,19 +32,42 @@ TEST(vmaccess)
>  
>  		pthread_create(&pt, NULL, thread, NULL);
>  		pthread_join(pt, NULL);
> -		execlp("true", "true", NULL);
> +		execlp("false", "false", NULL);
> +		return;
>  	}
>  
>  	sleep(1);
>  	sprintf(mm, "/proc/%d/mem", pid);
> +	/* deadlock did happen here */
>  	f = open(mm, O_RDONLY);
>  	ASSERT_GE(f, 0);
>  	close(f);
> -	f = kill(pid, SIGCONT);
> -	ASSERT_EQ(f, 0);
> +	f = waitpid(-1, &s, WNOHANG);
> +	ASSERT_NE(f, -1);
> +	ASSERT_NE(f, 0);
> +	ASSERT_NE(f, pid);
> +	ASSERT_EQ(WIFEXITED(s), 1);
> +	ASSERT_EQ(WEXITSTATUS(s), 0);
> +	f = waitpid(-1, &s, 0);
> +	ASSERT_EQ(f, pid);
> +	ASSERT_EQ(WIFEXITED(s), 1);
> +	ASSERT_EQ(WEXITSTATUS(s), 1);
> +	f = waitpid(-1, NULL, 0);
> +	ASSERT_EQ(f, -1);
> +	ASSERT_EQ(errno, ECHILD);
>  }
>  
> -TEST(attach)
> +/*
> + * Same test as previous, except that
> + * we try to ptrace the group leader,
> + * which is about to call execve,
> + * when the other thread is already ptraced.
> + * This exercises the code in de_thread
> + * where it is waiting inside the
> + * while (sig->notify_count) {
> + * loop.
> + */
> +TEST(attach1)
>  {
>  	int s, k, pid = fork();
>  
> @@ -52,19 +76,76 @@ TEST(attach)
>  
>  		pthread_create(&pt, NULL, thread, NULL);
>  		pthread_join(pt, NULL);
> -		execlp("sleep", "sleep", "2", NULL);
> +		execlp("false", "false", NULL);
> +		return;
>  	}
>  
>  	sleep(1);
> +	/* deadlock may happen here */
>  	k = ptrace(PTRACE_ATTACH, pid, 0L, 0L);
> -	ASSERT_EQ(errno, EAGAIN);
> -	ASSERT_EQ(k, -1);
> +	ASSERT_EQ(k, 0);
>  	k = waitpid(-1, &s, WNOHANG);
>  	ASSERT_NE(k, -1);
>  	ASSERT_NE(k, 0);
>  	ASSERT_NE(k, pid);
>  	ASSERT_EQ(WIFEXITED(s), 1);
>  	ASSERT_EQ(WEXITSTATUS(s), 0);
> +	k = waitpid(-1, &s, 0);
> +	ASSERT_EQ(k, pid);
> +	ASSERT_EQ(WIFSTOPPED(s), 1);
> +	ASSERT_EQ(WSTOPSIG(s), SIGTRAP);
> +	k = waitpid(-1, &s, WNOHANG);
> +	ASSERT_EQ(k, 0);
> +	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
> +	ASSERT_EQ(k, 0);
> +	k = waitpid(-1, &s, 0);
> +	ASSERT_EQ(k, pid);
> +	ASSERT_EQ(WIFSTOPPED(s), 1);
> +	ASSERT_EQ(WSTOPSIG(s), SIGSTOP);
> +	k = waitpid(-1, &s, WNOHANG);
> +	ASSERT_EQ(k, 0);
> +	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
> +	ASSERT_EQ(k, 0);
> +	k = waitpid(-1, &s, 0);
> +	ASSERT_EQ(k, pid);
> +	ASSERT_EQ(WIFEXITED(s), 1);
> +	ASSERT_EQ(WEXITSTATUS(s), 1);
> +	k = waitpid(-1, NULL, 0);
> +	ASSERT_EQ(k, -1);
> +	ASSERT_EQ(errno, ECHILD);
> +}
> +
> +/*
> + * Same test as previous, except that
> + * the group leader is ptraced first,
> + * but this time with PTRACE_O_TRACEEXIT,
> + * and the thread that does execve is
> + * not yet ptraced.  This exercises the
> + * code block in de_thread where the
> + * if (!thread_group_leader(tsk)) {
> + * is executed and enters a wait state.
> + */
> +static long thread2_tid;
> +static void *thread2(void *arg)
> +{
> +	thread2_tid = syscall(__NR_gettid);
> +	sleep(2);
> +	execlp("false", "false", NULL);
> +	return NULL;
> +}
> +
> +TEST(attach2)
> +{
> +	int s, k, pid = fork();
> +
> +	if (!pid) {
> +		pthread_t pt;
> +
> +		pthread_create(&pt, NULL, thread2, NULL);
> +		pthread_join(pt, NULL);
> +		return;
> +	}
> +
>  	sleep(1);
>  	k = ptrace(PTRACE_ATTACH, pid, 0L, 0L);
>  	ASSERT_EQ(k, 0);
> @@ -72,12 +153,46 @@ TEST(attach)
>  	ASSERT_EQ(k, pid);
>  	ASSERT_EQ(WIFSTOPPED(s), 1);
>  	ASSERT_EQ(WSTOPSIG(s), SIGSTOP);
> -	k = ptrace(PTRACE_DETACH, pid, 0L, 0L);
> +	k = ptrace(PTRACE_SETOPTIONS, pid, 0L, PTRACE_O_TRACEEXIT);
> +	ASSERT_EQ(k, 0);
> +	thread2_tid = ptrace(PTRACE_PEEKDATA, pid, &thread2_tid, 0L);
> +	ASSERT_NE(thread2_tid, -1);
> +	ASSERT_NE(thread2_tid, 0);
> +	ASSERT_NE(thread2_tid, pid);
> +	k = waitpid(-1, &s, WNOHANG);
> +	ASSERT_EQ(k, 0);
> +	sleep(2);
> +	/* deadlock may happen here */
> +	k = ptrace(PTRACE_ATTACH, thread2_tid, 0L, 0L);
> +	ASSERT_EQ(k, 0);
> +	k = waitpid(-1, &s, WNOHANG);
> +	ASSERT_EQ(k, pid);
> +	ASSERT_EQ(WIFSTOPPED(s), 1);
> +	ASSERT_EQ(WSTOPSIG(s), SIGTRAP);
> +	k = waitpid(-1, &s, WNOHANG);
> +	ASSERT_EQ(k, 0);
> +	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
> +	ASSERT_EQ(k, 0);
> +	k = waitpid(-1, &s, 0);
> +	ASSERT_EQ(k, pid);
> +	ASSERT_EQ(WIFSTOPPED(s), 1);
> +	ASSERT_EQ(WSTOPSIG(s), SIGTRAP);
> +	k = waitpid(-1, &s, WNOHANG);
> +	ASSERT_EQ(k, 0);
> +	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
> +	ASSERT_EQ(k, 0);
> +	k = waitpid(-1, &s, 0);
> +	ASSERT_EQ(k, pid);
> +	ASSERT_EQ(WIFSTOPPED(s), 1);
> +	ASSERT_EQ(WSTOPSIG(s), SIGSTOP);
> +	k = waitpid(-1, &s, WNOHANG);
> +	ASSERT_EQ(k, 0);
> +	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
>  	ASSERT_EQ(k, 0);
>  	k = waitpid(-1, &s, 0);
>  	ASSERT_EQ(k, pid);
>  	ASSERT_EQ(WIFEXITED(s), 1);
> -	ASSERT_EQ(WEXITSTATUS(s), 0);
> +	ASSERT_EQ(WEXITSTATUS(s), 1);
>  	k = waitpid(-1, NULL, 0);
>  	ASSERT_EQ(k, -1);
>  	ASSERT_EQ(errno, ECHILD);


