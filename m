Return-Path: <linux-fsdevel+bounces-67911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A2AC4D4E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 12:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 11C7734F7E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 11:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0251735470F;
	Tue, 11 Nov 2025 11:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="b/9FQu5G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011031.outbound.protection.outlook.com [52.103.33.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989602F7AA6;
	Tue, 11 Nov 2025 11:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762859276; cv=fail; b=F6MIjF5r2cxRS1zrt1crfwA/GIR+H1VWGtN0LdcKdXqXiqMMLqDZXb7x1kdn2lGBsM2jbG7+qd8vPb0ir2VZesN48j2BNvTqeT/+sZ4B0LzO2E6wNu/1g1QzUyWx8powXnmPv4AkWtMRzhOwVIrprcJAlYOMQu+sos8wcvHpm2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762859276; c=relaxed/simple;
	bh=FsMOi5i77cQ3GPJoTwHdD0y87Ov3KFg7fElNQt9Z/Mk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Avg7ckFSzCAfPvFjA1StqchqOiYKb2BqatQwEi7uBTCVNgL84bR7TdmoHYaBJjf3UJH6lpMCUmWL0Jblyzn8pkVYaQB8lV6+AwhCrN0knfD8JeUR7qwHPeGycC5N8fLcNAT4i0Hw418n5nonbLRGydsjMyOGdXMTdz5q3p1yfHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=b/9FQu5G; arc=fail smtp.client-ip=52.103.33.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdiER4FX4NKFNeq1yZODLf7Vjtw6lPydgPqIJGsZ3GmNNgY67FlW2lNuTJaM0LA6987VP7zosjY1YODcoj6q3GGHNI3D6VCZwl/H2GvVDX/Yibbk7JcjNMLLzYNtcNRgk3AotbRBz/+Rufh/Ya2ItbYN7U4P0i2ZU3tK1NxO5iRz/mgHM0WvXhE5NVrKw/1kfYYXgb1qkExc4tS0o6XrOy24R0OGV15eendOKEU74740pKOWQc9ORgLOztt6yK3MAlL6BjFlFTjEFym9fXkyZ2PTNNuc92pj8M3ooigUoUcKbXZzdkNI0E8+C8v87QkRtox7/oIF5XXSUT13xtTifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUNenhQhlCOx3VL7piVBsfQhhog8UCi73UWST9oscEI=;
 b=qaw1tt2eNVE14ES6mniYnNDGSIZjS+gMBxDkvpWLEiTlAgans2FvTCOmc8Ln8XX7oY4ewBRNGTJ3R3A8nEnqcL0EKrBGb7jb4s+lMB1Dcv8zdUuwvDSFJZAWnDgUyKf3I8PUhpzXSwvMgAzwIGOsSorJ3bRXcBWj8qmHMi3XvSUH3rOiCFoMBFwll0tOHZ/bNo9TupyoGmPjLFC4Q/APWOS1O3ytKNF3hKcEKrQ+f4/uOvWG/RdqB5MTjOedIOfaco1gRYQWDiGm97NkyC2nVQzowaKdBHELBkvlQ7uobyBMrkBErcOI16u25RZjxgC3NLFu0Zh3yEOV+3pt8dAbRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUNenhQhlCOx3VL7piVBsfQhhog8UCi73UWST9oscEI=;
 b=b/9FQu5GvYggMtIRW2oEzuQym7NU4EE0zDjjOdWySw6kBpMGPA5r91MFzHWQNyGS1UzrYMYDHYjdOwX4VRHmiCEHq3gvyNicbxKhO0QXD94uSoV3Z122nNtgdiGzEdG1gEuBEenLRrKXRQeEIPSB4cNZFR7B0Ho+dah9AQ/GvaXdgPQO8HCAGfF4r73pGkefJc3EM6/i2T4Do+zNkGz7mHmOZtnjkDb5BtDoM4ziFBdlQtf87KIYme1No/t8pARlQZinftpJPiI2HEvNNMZ2pqxPhT0ZdjE/S3ovmt0/5/C/zdl4ILQ3ZDwKS/57Ggh4ZXPye7KEZtlhtUEVEl2jpw==
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4) by VI0P195MB3290.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:2d4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 11:07:49 +0000
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::dde:411d:b5f2:49]) by GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::dde:411d:b5f2:49%8]) with mapi id 15.20.9298.007; Tue, 11 Nov 2025
 11:07:49 +0000
Message-ID:
 <GV2PPF74270EBEEDCF80CEE0F08891ED37BE4CFA@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Date: Tue, 11 Nov 2025 12:07:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17] exec: Fix dead-lock in de_thread with ptrace_attach
To: Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Alexey Dobriyan <adobriyan@gmail.com>, Kees Cook <kees@kernel.org>,
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
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
 linux-security-module@vger.kernel.org, tiozhang <tiozhang@didiglobal.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 "Paulo Alcantara (SUSE)" <pc@manguebit.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Frederic Weisbecker <frederic@kernel.org>, YueHaibing
 <yuehaibing@huawei.com>, Paul Moore <paul@paul-moore.com>,
 Aleksa Sarai <cyphar@cyphar.com>, Stefan Roesch <shr@devkernel.io>,
 Chao Yu <chao@kernel.org>, xu xin <xu.xin16@zte.com.cn>,
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
 David Hildenbrand <david@redhat.com>, Dave Chinner <dchinner@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Elena Reshetova <elena.reshetova@intel.com>,
 David Windsor <dwindsor@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>,
 Ard Biesheuvel <ardb@kernel.org>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Hans Liljestrand <ishkamiel@gmail.com>,
 Penglei Jiang <superman.xpt@gmail.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Adrian Ratiu <adrian.ratiu@collabora.com>, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Cyrill Gorcunov <gorcunov@gmail.com>, Eric Dumazet <edumazet@google.com>
References: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <20251105143210.GA25535@redhat.com>
 <20251111-ankreiden-augen-eadcf9bbdfaa@brauner>
Content-Language: en-US
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
In-Reply-To: <20251111-ankreiden-augen-eadcf9bbdfaa@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0407.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::16) To GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4)
X-Microsoft-Original-Message-ID:
 <a3ac126a-4e5a-4ba7-b3dc-2284c58ada9a@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPF74270EBEE:EE_|VI0P195MB3290:EE_
X-MS-Office365-Filtering-Correlation-Id: e79ebff6-40ed-409c-0203-08de21128cc4
X-MS-Exchange-SLBlob-MailProps:
	9IecXKUgicBJ8NNsyPoVvrHIv5xlNgd3DClhicMbZQGQScwPSSUB4wtX+IKcX8H5ch33TMqBacURcGqnTQ7S4GsR91tRmQcgeP/Ywgg6phjXdIH5JVALj0y6lZ4ojz6sD6z1TwChJe+b0+GwZw5V7S589G7IKipf2H9+dicTHVyJ/0LBfng6jHpeWGBUZy+uT/r5edtMWHEl18wmHlqTLxeHXknOE21I/88bf6h0dLptgnzw/9xCT5U0EfbLYF0V73JVUkUvUpm9UD4B//M2fo18R3CoRBl9fdSegjcSC9wzcfdAKPumyrF6u9eVKTE384q4iISmZwfYBe6Uw0aeMA9CJkkoicYt+QFrIYqF6aZy/smwopYSnObrXcpPs472xTVHyXc4/NhB/LJVGvFdG2tIGIXMEcgxd5rTFwYbKbtQ/gGCn/hjGZ/N9mX30bwFZmGQoksGcbF2KsXuBC4rYpqC/6mDZYC9FN2fEadkM2E2p28LMg1WRuk6aI16E2zWvXCU3ZtEmvv9t6sCayIz8BdEmwMutlGzBdbsDx/8WaBREna0lbhx6xWUtR/wyWhfSlMivKOo1w3BGNm3o25iNmzrxTeYRHMDgNbhpono40QPG1YPdBr/YvISmaAPnT1EYoHHrl7rTKhWfFMo19SEy/Kj25Y+rv+swXRiqnNr+RFm7AlXAXaoYopv9TuFGHLyvEzbIU73WVwWlLxgCoHNXlp1Ix2HqWZt6d2rAmnMeW32v7zBSyQMiw==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799012|8060799015|41001999006|6090799003|15080799012|12121999013|461199028|23021999003|51005399006|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZW9EK1VrRm5qbE45STJmK3BnaVBKcVR1d0c1TitBakJNRXBUakVMdEJmMzZt?=
 =?utf-8?B?Zmpsb0NUa2IrV3JBbTd6eTJmWkIwd1BLcVExdmpTN1R3ZG9aSGl5RnVCWlhh?=
 =?utf-8?B?Q29pQzgwSDBaZlY3RzZabDFPUm55YXlYUSt3WEpVMTUxQzZ6SzZTdmN2MCtr?=
 =?utf-8?B?bW5ORERWcmttWnB5alFjdVRZNFFNWWZNUG5iSlo4WTZFZHlHazFxVU5iRWVP?=
 =?utf-8?B?NXFwcHZRVVFqWm1LVCt1SVdFemdaWmdzdTkzNGdFK05oWi85bGpWeFYrc3pM?=
 =?utf-8?B?dXM0S2RMS0l5b1htLzNCbzg0a3BqQ3Z1WFhmeUlwdWZvQkI4U3cxL25Bb3gw?=
 =?utf-8?B?bTQwdEEyWmt4by9nc2pBWmVsUXFqa2lFSE9HMDZ4b0VWV28rK0xsOGI3eVkz?=
 =?utf-8?B?SXF4eC9OQ05uamUzWlZ1SUF3N1h6bHNPeUZJMGtNK1U3QlozcjkvaE9DUnc0?=
 =?utf-8?B?aXZmbGlhVjVYN0NiY0JIQUxtckdSb2w1VjhRQiszK3Y4VUREVzhNb1czMElV?=
 =?utf-8?B?T3E5L0s5QVlqUHZJcHpzUWxuTDB1Zm1xeFJobFpVeVZmSDRZSjEwR1BoQlIx?=
 =?utf-8?B?elZCd2VGaVBJQ1lhbGFPVXJpVUY0SVdRZmNOdWcwdmw0RWU1KzIxbDVjSXJN?=
 =?utf-8?B?bjE3dSs4WFU1WVhYL2tCWE15N0VUZGdCTDd6Rk9UNkF3bU1XaDc2OFdnbS96?=
 =?utf-8?B?WnZVd0VXeDVSODNmdUNWZ0pxcnRnL2djNCtCT0tqZ0M5UXlOcytDY3B2bWpl?=
 =?utf-8?B?dFdKb3RaSFFtYlpzUlMwdnRYSEg4dHVPbTlYbE9TMjZJL3EzSGRnREJ5VVRX?=
 =?utf-8?B?VWl6ZWVtZmpxaG5BdHdkMG80QVdYUHhrQmp6ejdVaThzc1IycVNZRzB3Y2RS?=
 =?utf-8?B?N2gvZzByZ25XMDlNMkFiZG9BSENibnpZeHNVVDhxdUsvOHp2QXdBQTVuclM5?=
 =?utf-8?B?U2kxZFBsUVlrVGV0OFRyK2RlVTdJWXM3aUlYalJJVGxRVWplUmtvalhHMDg4?=
 =?utf-8?B?Wmh0NmVrejgyVTg4OGtrVHh0WUZxMlY1ckZIc3dIYkk0bmFCWXh4YitLSmJq?=
 =?utf-8?B?OXZhbDJqSGw1VWhzNEZEK3hnVkZlZFRzeDJTazRmRFgxRHAxY1FCVkVLUVow?=
 =?utf-8?B?R09GWVA1VXc4L3hnVVExR1JVNUhBaDV4cUtLOS9VeHh3T3I0Sm11OGFkSGs1?=
 =?utf-8?B?cWRaZVlQMVFzOHU4b1h5MHRHSDVoSFluWmdmUkRuaEpoNVhFOFJpU0FqTmxF?=
 =?utf-8?B?M3YyaVFwRUFWTm1vY2llNGtvNFNZTE5jYUNIUjc0bmlybDI4cnZOcW5kYUN3?=
 =?utf-8?B?cE5HYklWeEpSOFJqcmpiMXE1bVVtcytMenJNeGRTWmd6R0lPRkxjYnF6TmhF?=
 =?utf-8?B?dng0RmJQOEVhRWs4Y0JaKytjazZFaDRHQ1hFSkN1eDhtTk1QTnFUakorTUpT?=
 =?utf-8?B?TURkaENVSEtpUVJRdUtFbjVyUzdQQkZLOTg1N3FsTXFxRTlWOVRpTEhoNWRG?=
 =?utf-8?B?ZXFVbGhWS1pCTUhTR2dIbjZiZlcxdU5PVmpHa1MvaytXVVhMZ0hZVkJvRmdi?=
 =?utf-8?B?RVhXQ3pJc1l0STVibnFjL3Bsd0xOT2tpL2xIaEpHdmRMdXhmVXhFRVVCYm95?=
 =?utf-8?B?VkpOTUVOclE1TGRSbDRvc25sMGUwSTNXWUl6MHRsR29UOWFGd0R2azRaZWto?=
 =?utf-8?B?YXBGLzR3UGd4elBpUE51SVRGR2lwRWhPUnVPTXF0RjVXSkUrNUR0SWdBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDJ6Qk1BR1hVRkxXbGlOelJnTWlTNW9XUnQyOEpYZEY5MnJDV2lSL3Z2MXht?=
 =?utf-8?B?eDNiNThkQ1ZDRUFoZ255czcyaWRKVmU3VisvY1pSVHVKMnF5eDFEd1pwalZj?=
 =?utf-8?B?REpHTXJMSS9NMXBuN3Azcnp0a2xhWHBFUysydjNyNnVocXZIOUlGU3MrTTRu?=
 =?utf-8?B?Q2lXOWRIWWhhSGtQUWhUT0pCWjFzQ3FZTEViSFBXWkJ5QVpCTFBwYm5UVXpK?=
 =?utf-8?B?RnRDdGRqSE5zUlB1QkRGNURFVHU4eWdCdUNML2xld1JnSGNad2NPZWYvY1Ew?=
 =?utf-8?B?amV4NFlhQ0lOV0MwRlgzSDQ1V2YzRUlHWFVaK00xWWVyWExIUlBCYXFVdm9h?=
 =?utf-8?B?R1gxZ0xCaVNFRHRWOFByVWtlSmcxdWlTUGVybWlBRDNsUG43THEzOXJBVWNS?=
 =?utf-8?B?SE9nSEpUOGZnZWFqNVNMdnBwTnl3MVhGU2NzOVdjNlJiMmVXQ3hxUUh4R21F?=
 =?utf-8?B?cWh2RERJUXpsME1QUEhxY0l3b05BWkJENjg1ZmMyKyszTEZ4RXRYSW1kVHVy?=
 =?utf-8?B?a2lrcE5RZTk2b2NZV3hOVVhtbnIrNktsb0RqUTFqQk5iaFZ5VXVlMlMwenVn?=
 =?utf-8?B?L0ozZ0x1b2M5MURYcUNobzhqdnptWEE5a3VscGhNR1h3RG1Ua2FiekM2UjlG?=
 =?utf-8?B?YUhxV1RCYnBTTmcrOVdmQUFRQkdHL3c4cVU4NHdwN2xQVXpHa1Jld0tqUHBE?=
 =?utf-8?B?c2U2cnRZSWRmQnZCa0NCZ0ZKckZiNlVnTGRkcmI4cVVaaEh6WklocUNNK0Jh?=
 =?utf-8?B?TnlaSGw1YkFmMnNsZDFCdmQ5d25QenkyNkNUWEg5VVd0aE5PK2VqVjBsZExD?=
 =?utf-8?B?ekY4eGt4eVFDSHRFaUtwT3c4MlRyOUUzdEVPbDlTd0dmaFVaVnU5alR4ZG55?=
 =?utf-8?B?QUpLZmxtOEFsbHgyOVFmcVd5TEt6d3FONVA4M0cycWZhQlhtbzNvMnArRmI0?=
 =?utf-8?B?WkdoaElDaVNOZEVvdm05OWdTQ3dsZzJRbU1xaE1Ba29yMW1UZlcrMnRQVm1R?=
 =?utf-8?B?TnhVTXVOU1psL2hmN2RrdGkwT0paYkZxRHdsdWIxckcrbnRIK3JjOHpyQkR5?=
 =?utf-8?B?NnpIc1hscHYrdTFyYXI5MU5nMDFKNGJRSDg5MXlQUitZTHcwcXp5RFNLUzNJ?=
 =?utf-8?B?ZlIwTjd2em5QWjF5aFVDZjd4MHBBVnlHQ1NzSktrSWNlTDBrVmU0T2hGcnZ4?=
 =?utf-8?B?bnA2YWdrOTRteVVBalFORFo1cVoyYzVLOWkxSGxhRm1vSnBhbTFlSmpIb3Zn?=
 =?utf-8?B?aDFMREtVTUxMVnRUcVZhN29MbGt0MlpWeGI4djZUR0pSVW11SXJ6RUQ2ZzZp?=
 =?utf-8?B?THhiTS9qSHYxYmh3TWpaazJlcDJuVHhOQVNjUVB1NXIyQWtHdk1McmNOWlVV?=
 =?utf-8?B?UGxkTXFoVUMrQXhFZmxUUVhTR21PUlZBOTBlb0llZlpTQnVldDB1MW55d1gx?=
 =?utf-8?B?anN1ZzU0VldCcm1HMnRFaUNNaHQ2QW9IREFhOEIwYkJBSUdzRy9Da3dzcnJn?=
 =?utf-8?B?TFNXWmxJUCtSR3F4QlN3QVE2L1VmODV3OTF3RjJWc2xyTEpZUllOT1d3UXpq?=
 =?utf-8?B?cGpiN0Q3TkdnVlc5dE1ubmN4NUd4cVBuYUNmY25vL0g1YTJKSHUyVWJnK0Rp?=
 =?utf-8?B?eHVzQ205R1ZrcU41VW9WOWtGM2FZK212R0FRVnpPVDFoMFIwRzJMYnVZTWZQ?=
 =?utf-8?B?UzBWUXIrNGEveW5zcmQvblh4WGpHb1FKRGZOYmdPVTQ4U3o3aWEwT3FDOTdQ?=
 =?utf-8?Q?kQYLNqW+/oPyUL6C021DbNAIVbm0iEdt0oltAmP?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-87dd8.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e79ebff6-40ed-409c-0203-08de21128cc4
X-MS-Exchange-CrossTenant-AuthSource: GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 11:07:49.3292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P195MB3290

On 11/11/25 10:21, Christian Brauner wrote:
> On Wed, Nov 05, 2025 at 03:32:10PM +0100, Oleg Nesterov wrote:
>> I am still thinking about another approach, will write another email.
>> But let me take a closer look at your patch.
>>
>> First of all, can you split it? See below.
>>
>> On 08/21, Bernd Edlinger wrote:
>>>
>>> -static int de_thread(struct task_struct *tsk)
>>> +static int de_thread(struct task_struct *tsk, struct linux_binprm *bprm)
>>>  {
>>>  	struct signal_struct *sig = tsk->signal;
>>>  	struct sighand_struct *oldsighand = tsk->sighand;
>>>  	spinlock_t *lock = &oldsighand->siglock;
>>> +	struct task_struct *t;
>>> +	bool unsafe_execve_in_progress = false;
>>>
>>>  	if (thread_group_empty(tsk))
>>>  		goto no_thread_group;
>>> @@ -932,6 +934,19 @@ static int de_thread(struct task_struct *tsk)
>>>  	if (!thread_group_leader(tsk))
>>>  		sig->notify_count--;
>>>
>>> +	for_other_threads(tsk, t) {
>>> +		if (unlikely(t->ptrace)
>>> +		    && (t != tsk->group_leader || !t->exit_state))
>>> +			unsafe_execve_in_progress = true;
>>
>> you can add "break" into the "if ()" block...
>>
>> But this is minor. Why do we need "bool unsafe_execve_in_progress" ?
>> If this patch is correct, de_thread() can drop/reacquire cred_guard_mutex
>> unconditionally.
>>
>> If you really think it makes sense, please make another patch with the
>> changelog.
>>
>> I'd certainly prefer to avoid this boolean at least for the start. If nothing
>> else to catch the potential problems earlier.
>>
>>> +	if (unlikely(unsafe_execve_in_progress)) {
>>> +		spin_unlock_irq(lock);
>>> +		sig->exec_bprm = bprm;
>>> +		mutex_unlock(&sig->cred_guard_mutex);
>>> +		spin_lock_irq(lock);
>>
>> I don't think spin_unlock_irq() + spin_lock_irq() makes any sense...
>>
>>> @@ -1114,13 +1139,31 @@ int begin_new_exec(struct linux_binprm * bprm)
>>>  	 */
>>>  	trace_sched_prepare_exec(current, bprm);
>>>
>>> +	/* If the binary is not readable then enforce mm->dumpable=0 */
>>> +	would_dump(bprm, bprm->file);
>>> +	if (bprm->have_execfd)
>>> +		would_dump(bprm, bprm->executable);
>>> +
>>> +	/*
>>> +	 * Figure out dumpability. Note that this checking only of current
>>> +	 * is wrong, but userspace depends on it. This should be testing
>>> +	 * bprm->secureexec instead.
>>> +	 */
>>> +	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
>>> +	    is_dumpability_changed(current_cred(), bprm->cred) ||
>>> +	    !(uid_eq(current_euid(), current_uid()) &&
>>> +	      gid_eq(current_egid(), current_gid())))
>>> +		set_dumpable(bprm->mm, suid_dumpable);
>>> +	else
>>> +		set_dumpable(bprm->mm, SUID_DUMP_USER);
>>> +
>>
>> OK, we need to do this before de_thread() drops cred_guard_mutex.
>> But imo this too should be done in a separate patch, the changelog should
>> explain this change.
>>
>>> @@ -1361,6 +1387,11 @@ static int prepare_bprm_creds(struct linux_binprm *bprm)
>>>  	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
>>>  		return -ERESTARTNOINTR;
>>>
>>> +	if (unlikely(current->signal->exec_bprm)) {
>>> +		mutex_unlock(&current->signal->cred_guard_mutex);
>>> +		return -ERESTARTNOINTR;
>>> +	}
>>
>> OK, if signal->exec_bprm != NULL, then current is already killed. But
>> proc_pid_attr_write() and ptrace_traceme() do the same. So how about
>> something like
>>
>> 	int lock_current_cgm(void)
>> 	{
>> 		if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
>> 			return -ERESTARTNOINTR;
>>
>> 		if (!current->signal->group_exec_task)
>> 			return 0;
>>
>> 		WARN_ON(!fatal_signal_pending(current));
>> 		mutex_unlock(&current->signal->cred_guard_mutex);
>> 		return -ERESTARTNOINTR;
>> 	}
>>
>> ?
>>
>> Note that it checks ->group_exec_task, not ->exec_bprm. So this change can
>> come in a separate patch too, but I won't insist.
>>
>>> @@ -453,6 +454,28 @@ static int ptrace_attach(struct task_struct *task, long request,
>>>  				return retval;
>>>  		}
>>>
>>> +		if (unlikely(task == task->signal->group_exec_task)) {
>>> +			retval = down_write_killable(&task->signal->exec_update_lock);
>>> +			if (retval)
>>> +				return retval;
>>> +
>>> +			scoped_guard (task_lock, task) {
>>> +				struct linux_binprm *bprm = task->signal->exec_bprm;
>>> +				const struct cred __rcu *old_cred = task->real_cred;
>>> +				struct mm_struct *old_mm = task->mm;
>>> +
>>> +				rcu_assign_pointer(task->real_cred, bprm->cred);
>>> +				task->mm = bprm->mm;
>>> +				retval = __ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS);
>>> +				rcu_assign_pointer(task->real_cred, old_cred);
>>> +				task->mm = old_mm;
>>> +			}
>>
>> This is the most problematic change which I can't review...
>>
>> Firstly, it changes task->mm/real_cred for __ptrace_may_access() and this
>> looks dangerous to me.
> 
> Yeah, that is not ok. This is effectively override_creds for real_cred
> and that is not a pattern I want to see us establish at all! Temporary
> credential overrides for the subjective credentials is already terrible
> but at least we have the explicit split between real_cred and cred
> expressely for that. So no, that's not an acceptable solution.
> 

Well when this is absolutely not acceptable then I would have to change
all security engines to be aware of the current and the new credentials.
That may be as well be possible but would be a rather big change.
Of course that was only meant as a big exception, and somehow safe
as long as it is protected under the right mutexes: cred_guard_mutex,
exec_update_lock and task_lock at least.

>>
>> Say, current_is_single_threaded() called by another CLONE_VM process can
>> miss group_exec_task and falsely return true. Probably not that bad, in
>> this case old_mm should go away soon, but still...
>>
>> And I don't know if this can fool the users of task_cred_xxx/__task_cred
>> somehow.
>>
>> Or. check_unsafe_exec() sets LSM_UNSAFE_PTRACE if ptrace. Is it safe to
>> ptrace the execing task after that? I have no idea what the security hooks
>> can do...
>>
>> Again, can't review this part.
>>

Never mind, your review was really helpful.  At the very least it pointed
out some places where better comments are needed.

Thanks
Bernd.

>> Oleg.
>>


