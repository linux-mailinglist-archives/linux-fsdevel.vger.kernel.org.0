Return-Path: <linux-fsdevel+bounces-65918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA0BC14FEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 14:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C823403DAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 13:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A58222E3E9;
	Tue, 28 Oct 2025 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="X+sWL7zy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022105.outbound.protection.outlook.com [40.107.193.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63939233149;
	Tue, 28 Oct 2025 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659436; cv=fail; b=fbb7mfFxNPfdmffmZXCmQt4iFIdseeXIWw/HdbFWkf5I67V4zG9/ok/uK9ZKp9+TD2G3m4PSX8qV7Z3AW0lOEsrqKDHBT/bbxGR1tj2HvwSxEEQnOMUOE9vIXwzvNsYwWU/B4Rjn2k/qi6abTGBCugCHyVsmG5ttNzV3e3/qjCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659436; c=relaxed/simple;
	bh=IztuQ7y9XejrNE8AIwLtwkKxZos1EuTuQsPCrttGhUI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U94s6G4WwpQjcjcXT7iEtP9y+N823tzP7en/Uqs9YJbur+gT4gqQ9oy++IUVDBODpg+rB7hD6w4kM8KZRWBiSqoS1MC5RkB966zFQqzWax3z9LG8eIwbVSJzH/Y2KweD0RI8JVCMXslDCrhZ1ry+AQOj0NfFY1unX3RnUiRIexs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=X+sWL7zy; arc=fail smtp.client-ip=40.107.193.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKWZja5RNmgCOS8T2w+Oy9zo9D5NmrzIH3fQutlvVe5Qw1hoP8tkj6XdEQfTb6dC6+yfbFIoL24UgWl5H1ctwByzYdkZ6dt0SNRtQNI/7Co35g/9sLF4PP9Qvm9XQ0YQM+E9PpHAJMsZCWFrY+MUDStUNbNEyLpIwAswy7KGLfOtSJVeikI6hlgRd8Gzo70wAYwgIA5RoO93iJVOJnMDV/ei2i3Ad1cOnSTlo9SJ190/TOjHffNk4uS40fOm+9nZqay0D6B9cS1xi/YOoEmB2A6jjn1icgAxel3fPyV/TsO7KN22PXkDBWsT1OLKzsY0gRY9IEraPJSKaOG9FbxKpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6GMyN7poxLB0mBVDMPS2eMZrP80ChSin0LQJBROe+8=;
 b=DnDf+iKTT6nrFkqWcB3gvl7ZaNIl+//Yy5d9jIzsWH3mRMz90qBHFKydd7xGm1uZ9CUvw7UdjasjYcdSbjjXshUyeRSxlHxC+PWyz6DwkLgW7EnofnaQUirv0ry5oeFSu9KQqDVAjAFvVkRJlma9dgXN193OvjsVohzWGxLgAhF2kSh+XNoKNOPLpNsHChSvTt84CrSYq79zRWuwjeKUij1oRKwa9jDsaW6Ih2hFWPL1unr77QVsjLge2eDfSBVOI6FhErsB/ePt5o7053ACAMMLJo5Y/8350AaIF9YgUuZjH1w8sNpcxRc6FXu3lHNPZf36pk/T+PHBwwIHz+yH8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6GMyN7poxLB0mBVDMPS2eMZrP80ChSin0LQJBROe+8=;
 b=X+sWL7zyZUblyorEccN0In9vGNFwfLQn+cCy0bgDf+cuZ+cGcC6cLfGNW77W4A6jd0GORjfVnnEo3iaLrDIkKdJWOqL1O2U4heHUFMEmSbHIA3R5B0ucCl/1Ud8793N6w/rMkkfrAFMAoXfbk5u51O7NMBco7Bi+hbQnG9pN9V8ze4wO29cWbROW3GZ/D9nZmW+tnEuDBXHuVkvxvOkaz3h5gQCCxpDOYXEEyK5SQByLJYKVorSYTKjsJdtxRjpKWewWWpWi9WVjG5+IST1odxHkZVRfBEVi6g+uvDuLIoI8yfN3vfqa34j/Mr4yBrvy+YVieIl6BVUmMjsYfpClPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PPFC07946807.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::581) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 13:50:30 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Tue, 28 Oct 2025
 13:50:30 +0000
Message-ID: <e71ad1c6-eb65-48a0-9292-4457905d791d@efficios.com>
Date: Tue, 28 Oct 2025 09:50:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V5 03/12] x86/uaccess: Use unsafe wrappers for ASM GOTO
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, kernel test robot <lkp@intel.com>,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
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
 <20251027083745.294359925@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251027083745.294359925@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0489.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::8) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PPFC07946807:EE_
X-MS-Office365-Filtering-Correlation-Id: 22c7f302-9b3d-47ee-3bda-08de1628f51f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUJOcFlPcUhrRUdsaVVMRDh3SUxQb0hCcFNWYmp0Rkl5M2tpVXByWGlMbEto?=
 =?utf-8?B?b3Q3MU96L2g3YndGKzBaSUZ5SGhrM0ZRbjkyc29ZVWx2Mnp4SGh3a2M5YVp4?=
 =?utf-8?B?WUlCbzh6STRqOG5qS2lCUzJaVUpqYnVUd1dpeitDMXU0WkdLM3BjMlEzTG9T?=
 =?utf-8?B?anAyM0F4bGl4LzRHcS9JT0NULzEzcStKSG5RWjNNZ2VmVVMvZHpHZVE5MjFW?=
 =?utf-8?B?Ym13Y1doYjJvOW9qYUFMU1NXbzloM2JMeEYwdXo5UFdaN09KbVV4V1BPNWhJ?=
 =?utf-8?B?ZFRjOXhLQ2FoZlpYbWEvQ3l3MTM1c1lhQmNmUkNnVWdub0pscGdEaW5YdkxS?=
 =?utf-8?B?TU1MTjZJWTNDYWNuaGZKOFdqNWo4bFd6cFBaeWw4ZzZJS2dnWkZkWm5Oaytp?=
 =?utf-8?B?bGp2UlhYUlZ0YTlmeDVFSnkzcm9heHk0VkVWaFdXeHZIdExBMTdBSmk2aVh1?=
 =?utf-8?B?YkJJZWJxaVk3WE92K3ZEVkVVQVRnc3VKa2swT1ovcUI1NWJ0dyt6TUwrdTJo?=
 =?utf-8?B?bC9zdmVLR3dUZzNTYnZOMmFPNm9iVk5KSGRoM2ZWV21ML1RWa21BbDdPMU9D?=
 =?utf-8?B?blFLVTY1Z1djcU00M3JZVVNpVStscHd1ZTNCcFhrVHZMVUVjejBlREQ5MTM5?=
 =?utf-8?B?TzFSVVNoa093UlRFNVl4bzc1N2Q2OW9pOENCbWdEQ2JVTkU3TXBNaFZvMjhi?=
 =?utf-8?B?R08rNGhMUHpKWUlYanI0S2syeHlZR2s0SE5aeDJOVVNZbjUyWXdNQkNVUnhi?=
 =?utf-8?B?cXN1ZUNjcWJTSkhhOC9GYkFHY3pJQzhjV1NyanBoQW0zV3pIa2VSbm1JM0dR?=
 =?utf-8?B?dmh4WHdFMVAxSWZ5MmEyeGFlRU9WWHFld2NCdEdqdmZvbmUwa1VmeUxVS00x?=
 =?utf-8?B?RDBYL3d4Tld2cmhYVGp1WUxqdDErbDZ2MS9aQjVPRWlwTk1SYm9KakxVUWl5?=
 =?utf-8?B?VkdlM2p6SDBYcVJvZHBuTFRhSVduUUFYR0xlTm4vckpWazllS1h5WTMxdStT?=
 =?utf-8?B?b2FnalhvSDZIWHhSTzExaDN3UkJvSWhSci9wNHNjR3o4ZHg5bitoNXZyZ2w0?=
 =?utf-8?B?RjU0ZDJPMlYzSUtYU1hDbDRkd3NFUkRId3NYL1hQc2RMMi9DWmwvM3oxcVpp?=
 =?utf-8?B?cUk0YW5LOXd4OFgxZkdoMWRJUndtTCtsRDNUK2pLdkJyejVmWE1kWGtjMUtw?=
 =?utf-8?B?VmxaMms5eUYwdW4zd2VZRDRKVTNqMk5YZWV0RE9FcWdhOW1DT1ZpdnBOcWwr?=
 =?utf-8?B?ZjdmTUdNQmxiYzR3dThnM1I2WHp4MGdVWG5qRDRUdjRoblZQWDFORmtQZExD?=
 =?utf-8?B?bWVIblZqeXdERzhCUWV1U3Q1eCtqTVVaU0ZhdTUzbEsvMDVBUzVSL3lNSzZl?=
 =?utf-8?B?L3l4VnVLWnFiTCtpZHVoSjlQTTlwS0JoaHpyOXc4TmU1eTIwOVFUcitwWExm?=
 =?utf-8?B?dFExM0l0VjN4UWd0Ylo2Z013WmJLVmdnS0pna2dzYnBFRFArdG5Cajkza3hl?=
 =?utf-8?B?OW9QWVBwczY5ekN5aDRyMEp2c3FoOXNtQ0E4bHRDaWh2bU1MZEsrd2JJL0ZE?=
 =?utf-8?B?bjlCM3hsRjJWSEZkcWtsRmRVN215WWNib0Zua3FRaXVseS83NCtqZjBDa1Zq?=
 =?utf-8?B?Y3l0cERmRDNJOXNiYVF0MEJEWGpVL2dCeCtxZnJURTRia0pLZTdiaGtFUjM3?=
 =?utf-8?B?WVlxMW9rempIQ1NuY1YrdUh0Qlo3TDRXV1FpSFVUZERybjB6akhzYmZnRnRv?=
 =?utf-8?B?ZkZra20zL0UyaEJvQ0hwdjRBY2dWNnhXVndyRkxZR3Jqd2tpVlBPdzg4Zit4?=
 =?utf-8?B?dktPRHpTYVdSMWdMeDhnVGcvSWhTQ1VWUktUK2JZT2JRYUw3K29Ncmp6bHND?=
 =?utf-8?B?SHNTREJaYnBzcDZLUVI5MmNZc0hacXNPSHRpNllYZkF4U0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0ZDUDNRMFplajZCWWpLZTlrbFQ5SkZpVWxrOFhtRXR3SlNobVE1NnV6MGc2?=
 =?utf-8?B?dEZSZEJNL2RLSmZsbEF4QW5XM3dhQnMyYXNVZFZ0TURWUUJzWm80S0ZTdUlB?=
 =?utf-8?B?RkxjWkFKa20zT2ZDNUVLK1dWeEtpUDQyZzJ5MWNwc0k0b1E4MHExSkpFaFBR?=
 =?utf-8?B?ZTBXcGRVSks3TWxrM09nSTQwT0tJd0hvMFA2WmhzRUJ0N1FMQm5oeDdRV0hr?=
 =?utf-8?B?SzdmczlNMGJ6cTFycEpJalRaTE1JeUZyakhxazVpM2V2NFBmYXBVZC9iM25i?=
 =?utf-8?B?VkdoeHpHWHRrRU9ZdVA1V3R0S2dPZDlVMVZoeEsvaEhpVFo4TjQ2Zjl2bjJD?=
 =?utf-8?B?U0thZUdMdHdQaVhjMkhSUS9OZSsvbzlMd21kdXd3RGYrQzg2QlZXT2FBS2Vr?=
 =?utf-8?B?MFMvWjBtaHZRTHdQN1I1d1VDU0tMemZSUW12Z1lqMzBhcnk2NVh0bjJKVE9Y?=
 =?utf-8?B?OCt2UmpFSm5zUDBCVDY4QjJuVXZXNXE4WFZ5aFpBMUxQLzNwNk05ZmhqempR?=
 =?utf-8?B?ckIvd0svemVJVHoyRDdTbVdkQkVFNkdxUTgzSGRVeHR4cTRjZlBXU0ZuL1V5?=
 =?utf-8?B?bHMwRlhycVFUbjFyWnBFUEx5cm1USkZ4YzBFdnVRNk5icGthemcwb0pKUURB?=
 =?utf-8?B?Q0xlYXBPWmRvNHRNak9MbkVBNitwQW1NOXd6N0dXRXJZbEtuVUx3NlFQN3lT?=
 =?utf-8?B?eWhJbTlueEFNT1JKZnZRa09EcDFwWmx3RytwWlM3RGxsSW9XYUNOejJZekdG?=
 =?utf-8?B?aW1XS3d2R0x6Y3BrVHFpK0Y3WmFSbXArMTFnUjByeFdvdHhHQVo0N1dvZENB?=
 =?utf-8?B?R0pLSFlhR0dveWhlYVdZbDY4Qmt2ZmZWYlNJVlJsY2xxL2NxMjNuYUdzWmtz?=
 =?utf-8?B?eXgzczRLYXZiQU5JNi9iMkpLajRZeU16QVJmamRIMlZUZFZrSlF3eVJRaXgy?=
 =?utf-8?B?ekx1bHRFSExFb2VJSDRucEpKam04cnh2MExkQXlFRjRMU2w1VEtQam9penRM?=
 =?utf-8?B?RXlobFRocGI3NlAwVVFlVlNXOXQvcTBEeGJzV1cxMGoxbERCUjJVbGZXT2ZU?=
 =?utf-8?B?aHR3NGxxc3ptWGtUY3p0dkszcU5hcmRrVmwvNDltWHRTTDByVXhwOGY4UHFW?=
 =?utf-8?B?dWgwWGJtb2FZajQyQnJvaS9aYlBzdW9MWXRLcUYwbnFWQUpjTmpBRXAzZ05j?=
 =?utf-8?B?ejlYNWUxNFFtWUhxdGlEZjBVZTBzcXUxU3ErRUJDTk81ZGxDazV1eW1rdlds?=
 =?utf-8?B?VVdKU3JiVHBHN3FuNDVFS2hLUUowME10amN4VkVOOGNrMnk2L3lENldVdnBQ?=
 =?utf-8?B?NWhlSlBDVmNnYW8wYXdrdkVwVDI1WmZmcHQ2U0c1bnlRdUdvaW5SU014OW82?=
 =?utf-8?B?QTdZR3VhYU5NR2poUHZIdytWV3pjYnFoYTZuOXZmUXVzNGw4b0Z2VExydVJ3?=
 =?utf-8?B?NkxQZlNqSVd2VlJtZEFMNmNaNHpaN09JM3NFb01pM0IxMTJpSDlzRW9ycU1p?=
 =?utf-8?B?LzFnTy9yRVpSVDVSK2l5akhmSWd0TDQyTndxekFYNmoyWUlkMnhiQ3gxK1Iv?=
 =?utf-8?B?WHVDVS9rbUZsT2FPbXFRdmlaa0FIT3ZoRWNQMjdoTnZSTjdqNjRQQXJRK3Mw?=
 =?utf-8?B?SjNoK0NzMkZmbHpiTkZzOWwzWUJ1N1FON3dmV0hUaWFqSkVhQWtYYWJ5anhD?=
 =?utf-8?B?NnJsbFh1VDZ4eDVnMHlxZlNoQ0h2TnRVYkt0WTkyWGpEMXpRUEdlTFZZQldE?=
 =?utf-8?B?Q2FsRmNiMG16YzBWTnVXMExTeXM4MXdXRjlScjVpZ3JRYkYwNXRsaVlDK1N5?=
 =?utf-8?B?cHAvRURjWHRDbWRTaFRJTUhyRzlvUUdhWjEwMmMzNE1jdnUxQWFseS9BQjkz?=
 =?utf-8?B?OFRpWFJoZFNWcFBuYTJxZitmR1p1UkMxTEtqaGk2SytJaDIxUzVXdTYrYUlV?=
 =?utf-8?B?ZC8wclFRNkl4cWYvc0t1N1BkUUYralB2NWVmYVpyRktwYlA4T2ZjdldNbUJW?=
 =?utf-8?B?ZTZybjYzR0FTM1dYdS9GeWdad3V0T2ZZWTRkNUYxQTQ3ZW5TTDVVVFNEOVBs?=
 =?utf-8?B?TktCamdBRDRtTE9PYmIvRmpNeUsrV1FjSUZ1VTExZmY2Z3F0TVRZYk8vQ3pW?=
 =?utf-8?B?ZmtCRFRhbC95ak5HY0p4cXFOeTFSajhCU0l1VUhPK09zWFZFR1V3Z3VkK1dk?=
 =?utf-8?Q?5ehPpX5ikFKE+LeLWZVxB68=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c7f302-9b3d-47ee-3bda-08de1628f51f
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 13:50:30.5178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NScg/AgxyugXFqAjvpvaLX7DzEHSaklUxHFiykytu+Fz/zwvBltYi6Cfv8XDuyDDNIi5wVJcIyieu6MJH/LJYB4BamLuvAG2jdWHACp8EF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPFC07946807

On 2025-10-27 04:43, Thomas Gleixner wrote:
[...]
> Rename unsafe_*_user() to arch_unsafe_*_user() which makes the generic
> uaccess header wrap it with a local label that makes both compilers emit
> correct code. Same for the kernel_nofault() variants.
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

