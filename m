Return-Path: <linux-fsdevel+bounces-68783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D40B6C66115
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 21:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C127A4E35B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 20:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054BD32ED34;
	Mon, 17 Nov 2025 20:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="Farw5vSL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn19013084.outbound.protection.outlook.com [52.103.33.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFC8281368;
	Mon, 17 Nov 2025 20:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763410145; cv=fail; b=tk6I0Zz99v6ckUhmRJlVUWDldL5sAd4B1fmImbn7uSo2vh4Q05Ejog535uBkhJvUo4xiJmGjKg4AkUyiPR7zct8+NeYknt7i+llZSCyvgrAd/WoArk141T1ezM4JVM/zf6OKt39mlWP9FCyccZPm1d3QI+MKcPyi5euym2IwGOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763410145; c=relaxed/simple;
	bh=QxGC2Lhs3Xk/bnKq+n1YmGQC+h/HW1CHGVhlUBxNydE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gnon7/016p6N04iAn++4xyi/rAbtBAwXHKGkzg5rYlgYcivXKsU0Iz/CIDC1FgKcMfzSupxyX9EUNqCOjRy6qAi3nVrPlDzI3BdbiMoNekZqrgsu4AhCvv3L5ezpuRMlOHXMK6Dn3P5J0d5e3cRSbfYefzJ4uoMIAsEqvk8exsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=Farw5vSL; arc=fail smtp.client-ip=52.103.33.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3QCT1c7pvvbyH6J6+l32TFLNv+3XCfsf1yRmni5IpTtQjUlCrbBXQhrkXHJ/6/fzKBG1zJyPs2EZKl1Adxd57w6zrVW0aM0QUG2stn0DuIk2sua5YMSVP3iAZ1ESo3zu2zd4c1qLQqMiLPHHjgjhcUBCnKoWddSNI2ciUkkv9SiHSOQnJaeSYlp9MTNdWKrp/KH5tXE6jAjlirLdjyqIbhtpn4i4h5tDPUU2EMlePsWf0b6vCxcSwINTxD3TAW7bSePoS53wYgfuRhSDfCpP5EUnK29G8Tbto+5UzPoAEUiPhx5DYb2czZMZLMyVSEHxmCaiKX2pJL+wiYI8N4NPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/S2P9DOPp/LcMN6Qj5WF0H5QUUzsyb1d2Jydc4p6mA=;
 b=rN6z+0wDUJ/u3eVrAeGU/js0FINiWhgzMgGlp3NuqUlfokws5rIhJkl1+xWEeDCk4z3g4YcDYEpdKbD3fHTTD5i7Lgl0gso7u+mqGr5MffLzfujbr2Qok3yJQIpyz14EDGPZvYMLqMQM/Ifd60gEnUkB8//2oSA//qVUWF8h9wQrd++cfmG0AoRkGVWiG5RPPNNJVOFXfY+De5yA6WyyuB4xOwcmabZFD/iMXyGIMW/D0hjOvwqMeIPlZSWsVCDVK67l9a2cCNqFXaCa2gXAKI9K1XGP9eFSefvifvQNaKbl9cbuIb7UB7RKAc8ARYc4JIqkugdtW806N2JCmbNrAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/S2P9DOPp/LcMN6Qj5WF0H5QUUzsyb1d2Jydc4p6mA=;
 b=Farw5vSLnaQ7K2JSRYFVS9a8fZwTwPdNtQC0BTc+oEAbiLIxoAhTUrMAdGYFNeuExpi3XGpi7ii8NvZanyiCLg7OYPbw0DlFTu5BdmAbRnbkDwhmvmtvwXGZ6+Om+8cTrJSx5WT9+ehjRYNvcZ3ykA6NJRPJbLFIr7Pitwy1LE7B7AbHH8DPmgYWcdhFu/9N6aymyBsPB3SGLNoGDQnnQBGeEa17WETcmu3iEiiM5+H3V8gOMu4qnEggdeAnT+hAi5nKArdCQ6qImx8rfrpewq8tWSgVuRGCvoWdd8EZUN+JIWhQ0V6KiWVWiIXvv63Agsk1gaw6C3SxHfmuXIZp2Q==
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4) by AS4P195MB1407.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4c2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Mon, 17 Nov
 2025 20:08:59 +0000
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::dde:411d:b5f2:49]) by GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::dde:411d:b5f2:49%8]) with mapi id 15.20.9320.018; Mon, 17 Nov 2025
 20:08:59 +0000
Message-ID:
 <GV2PPF74270EBEE6F59267B0E9F28F536D0E4C9A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Date: Mon, 17 Nov 2025 21:08:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17] exec: Fix dead-lock in de_thread with ptrace_attach
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
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
References: <AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <20251105143210.GA25535@redhat.com>
 <20251111-ankreiden-augen-eadcf9bbdfaa@brauner>
 <GV2PPF74270EBEE4FE6E639B899D01D8870E4C9A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <aRs4zYDhddBQFiXZ@redhat.com>
Content-Language: en-US
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
In-Reply-To: <aRs4zYDhddBQFiXZ@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0189.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::14) To GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4)
X-Microsoft-Original-Message-ID:
 <dae0c6c6-fcbd-4960-a718-01349caddf49@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPF74270EBEE:EE_|AS4P195MB1407:EE_
X-MS-Office365-Filtering-Correlation-Id: c5494584-6c47-4ea4-7a65-08de26152526
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|5072599009|12121999013|19110799012|41001999006|15080799012|6090799003|8060799015|461199028|51005399006|40105399003|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bElxOXVNQWdrc0libTFnbnNacDFIZDNROWRTV0k2eC9yNWRtWDlkTWhDTHpm?=
 =?utf-8?B?TVZCWExMNEVFNDh2UkpDMU4rbGdObENVU1hiU1Z3WTlHTDA0bENmMWZuTk5I?=
 =?utf-8?B?L1NIdnY3aUdudktnL2Yrd0ZCdWl6N0poWVJpUEF0M1g4QXNIMnBnS2EyUmZI?=
 =?utf-8?B?OUt6eUZHbU9tdlUraWsvVXJycUZoTTZDQVRPeVNnOUVYakhQa0ZKcjJvWURj?=
 =?utf-8?B?THVzbWUzdEVGOHNaQXZDbnBldWR2K2xVV3pvZVpjU3BLV083dWpYQ1I1dENr?=
 =?utf-8?B?WlFHbEVBWHlDMmFiYUZwa2QxT2I2a0dZSDRNT25WU1ZuMys2YldNSHlnazUz?=
 =?utf-8?B?UDViaUdCdFZPZjJYbFVFdTM4VHlmemtJOWhhMDhhMFB4Zmx1TUhOMVBoMDJG?=
 =?utf-8?B?VjRxNmFEc2xhMXdpcmVNWFlVWFJrWE1OSzVNK3luM0N0Q0xSK3p0N2V1cXkw?=
 =?utf-8?B?V0QrTXhJWjZtaUtxM3doaVUrKzM1YmU0RXRXREtUWUphTXlUWWRyTWd2dnlH?=
 =?utf-8?B?YlBMbEw5bHNXZDBxcFg5L0Y4YkgwbkF4M2ludXVldG5odUVhN1BLbmpZWmhq?=
 =?utf-8?B?WnlBaTlTV3UxbTZ4T2hZSWtjMmIrc1hNSHpoelNsbHloQkZjTVZDR3lVV2N3?=
 =?utf-8?B?c3d1L3J0OGRQbzFOMEsrR0tYN3djNHNRaVNPWlYrbWxLQkVsN1hISjhMbERa?=
 =?utf-8?B?K1hCc1FaVmZ4a0gwSk5TTDhHYjZscnpTVEIyaDREZHlZQU5zMUllNUFMaFRO?=
 =?utf-8?B?MDEzalFTbVZQb2VZZ3pNU2hrVlNVME1lUVZRcE0xaHE4UDVJMktaUWM5QndB?=
 =?utf-8?B?ZmRRMmRpN0liaWJnV2ZSSGpxdHJWM1BRaVFWemFLSExDZzJVdnA0SS90SkdE?=
 =?utf-8?B?RDdKUnhkdnNxTUFQVWtSQllHeTNTTFFSMjhaL0ExWXBscWJLOTcxdThNRnBh?=
 =?utf-8?B?WnJMZXpPcGVlVEVTM1JuU3V3bkEzNmgyY01sSm5sNlhhYWltTG5tbnR4MVoy?=
 =?utf-8?B?S0NheW9adGFuUmo2QXBTYzY3Z3VDZUNnc21aaytIaGZTVFRmdDI3T3ZyZkl0?=
 =?utf-8?B?d0hzYmdTRk9OcVk4dStGalFFajJxU05aZ0thelFOWmpnZnF1eElCQ3FlZFZn?=
 =?utf-8?B?Qm1yWjl0RTNHSGpLWE9QTkJHSjJCTkI5bTQwZzZidVpLdW02TjRobzhtWHZR?=
 =?utf-8?B?djd0NWFsTTgwMG00ZEI1NFIzSkZSR29nVmt0SFRROHlZN29CMHVPT2VtQmJL?=
 =?utf-8?B?ZWtld25QNmFoRDRiS3pCbUJYYVJXUW1CamdnaWxFblFGUFBjQWMwU3NJRmRm?=
 =?utf-8?B?bU52c2FUVmpQZmlOMnZwTHdjZE5jTnRVcTZDbExUTml3RnJON1dVMVR1SzRr?=
 =?utf-8?B?dGNlNGFzNDBTcHRqT2RIbjlpOXFFTjJVM1hwY1pxWEZmRERsSWFReXFuUXE1?=
 =?utf-8?B?SExEWTBhU0pzNjRFS01Ic1JEYlFEQzBPWm9TM3FHQkxFY1lDUmxCVUdlT0JZ?=
 =?utf-8?B?YWFSRW5Xa2U1WVJkTEpLNE11VHFFUVNGcTJVWHMveE9icVBhNzBjamtIbmFK?=
 =?utf-8?B?V2drSUh4R28rTnZMKzRRUVgrb2ptQmFKTDJ4bFFHRTVMY2N2bExVQ3pDdkJU?=
 =?utf-8?B?cmQySG9McUZhRStHaHkwdGlrZmlrbEZOQktaM3VLc2JPem1sQlJZTTdUWGFq?=
 =?utf-8?B?UE8vUzJ2bkwwcElDdDB0YUNRQnh5Z0EzeXpnVElpWm5JSE04Ylk0NHVHZEt5?=
 =?utf-8?Q?T/xACKqOadOGGWqEyylGh/3cGe2EcoKr6XJNh45?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjlRZFMyM3BkQ0NpSDEwWGlpTjlLUlZrd05saHowMU40L00ySy9kczJlWWVQ?=
 =?utf-8?B?Y3lhTDF3WXFwK1ovaTNyNzJRR0ROSlBLdDJOemoxcE5NZGdHYzFQQ2Z6cmpF?=
 =?utf-8?B?T2JZWjh6NzN2WDBNcWZ0bllwOWlGeWl3QURlNmdqM3AxdkI2Rm9NblVIMUti?=
 =?utf-8?B?MlhYOXI0QVVqK0tZaUZ5QUlTNTNOaWVRUFJRWHZQWGpKeEswNXNpUllOUmRi?=
 =?utf-8?B?NnJROXpndVA4NFdaRS9BYW1HZWFSZDVLeVV2cUw2Ujl6dEpWNDA5QUtpVnhN?=
 =?utf-8?B?Q1laMjBhYlU4M21CNUpxWXZFVlRwY0c1NWM3Q0hMbFlnRzZPTHJhRTl0RSt4?=
 =?utf-8?B?aE1PcnlDSnpwN2xiUDBoaWxxYVMvVkM3eTBVRUZYQTlkNmJPY3h0anFqejU5?=
 =?utf-8?B?U1d1NG5Rakx5ckxVNjdaejdhR2pZVXZIQ3haQU9rK0JsbVpsbTk2NGJrZGk3?=
 =?utf-8?B?WDE5cGNSWTFuWTU3RVF0ZlY2dHk4MEhRV1RGM0FkUnNlVE5Ic1RiZWd6cTRl?=
 =?utf-8?B?NVh5ejNadUZIWUEzRHJCNTM0bExQNzkvSWxzSU5FUVo5YkRNb1hPem0vcWFt?=
 =?utf-8?B?a0p2NVV0WmdIVUR2SjYxaXg5L2EyRnVhYy9KbGpUWXNnM0pjcW9oNHhSMmo0?=
 =?utf-8?B?bGFNcEk3Vlp1VDRYUHJJWDhUY1hhdWFTaldTVGUrdzF4R1djbHVpRFRQbG5P?=
 =?utf-8?B?WkJ4VmUzWFgvR3J3dU43ZEw4UVhpQnhVVVhUdnE1YXpMaVI3TGRlVGphN2lT?=
 =?utf-8?B?cWFGbWRLL3dsS3ViSHBwN29xaW4yaHpRaE5mcDdKTWNUVUcxUlpLQnliQU9H?=
 =?utf-8?B?QVNEZjdOMEtJRWZ5bm9DYmZFNFR5aW1LWUJFdjVOQlBKVWYyWDQ0MHhCY0VH?=
 =?utf-8?B?MVJ5NzVpT3Q3L2wyRUxaRXl3WHJ6dGpyYXArQ3laaE1lUkhWd2lQM2xRTlU5?=
 =?utf-8?B?NVBFK2dnK3d2S3owLzNMN05DWE9VcnNINU5DcE02ZkFOT1phbkZPN1Q3eDVT?=
 =?utf-8?B?QmNQWWN5OHlXUU9ET3dzQVRGV1NWb2o4WkZYMkNUY2taZ094OWRQRDVnVnBZ?=
 =?utf-8?B?a1VHcE5ScXFRVjkrNXpSMGVtbnh4S3BVRW9jVk81OVNsZEZBR0orRVF1OFVp?=
 =?utf-8?B?bkV5NzFuY3NDOE83bmc3d0FpTHcrRHJMN0dPbzNXOG5Pcm12UXhxQXNpYWUz?=
 =?utf-8?B?M0lnQWZYc3ZkSlE1TkdYejF3akl2REo4Zjd3djEvNUMrNG0xVzdTdnlPNU1G?=
 =?utf-8?B?cVFyUGpENGNHSkFLT1VuODFJcGZPWmdNYWNLVVc5Q014cWFlSG15K1VvT0Zo?=
 =?utf-8?B?ZXJZTlp0ZFEvVGhlZlpVQmhvd1loNFk1KzROME5DNGNtK2hJS2cvRkVJL2l0?=
 =?utf-8?B?eEtveXJ6N1pYcDNaVHhEWFBKZ1hvMVF5UzBGVzBCSG1IZW4rSzNhVkxJdjBu?=
 =?utf-8?B?amsyVHRlOENFVjNPNXd6eDIxbFFLcEdwZkt3V0RWaVdUN0VoVlF4UGlneS8r?=
 =?utf-8?B?Uy85VFlMY2FMallmK2EweXAxd2ZuWjRQS3BCRTZyaGNESEdJZkR4VHI3NSt2?=
 =?utf-8?B?Wi9IVTYzaHZVSURUM3J1bHNISXZjQ0ZOZDk2ZzhhM09aNFAva0h3d1N2elIv?=
 =?utf-8?B?NEhtdEVzUThTdEZ6dUkzeFVBWHd1azI4TVh1Mmd1c1BUWGMyd0hvL2JpVWZF?=
 =?utf-8?B?YnJlRHBJUDA1NEU4STRYQXFnNVVxNHRzbXJWME9zUHJYcXBQaUs1NVFvVnF0?=
 =?utf-8?Q?Iibdqd0jHC5QxiKfWAClgoTDC0V+KgPQedhwO4/?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-87dd8.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c5494584-6c47-4ea4-7a65-08de26152526
X-MS-Exchange-CrossTenant-AuthSource: GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 20:08:59.5629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1407

On 11/17/25 16:01, Oleg Nesterov wrote:
> On 11/17, Bernd Edlinger wrote:
>>
>> On 11/11/25 10:21, Christian Brauner wrote:
>>> On Wed, Nov 05, 2025 at 03:32:10PM +0100, Oleg Nesterov wrote:
>>
>>>> But this is minor. Why do we need "bool unsafe_execve_in_progress" ?
>>>> If this patch is correct, de_thread() can drop/reacquire cred_guard_mutex
>>>> unconditionally.
>>>>
>>
>> I would not like to drop the mutex when no absolutely necessary for performance reasons.
> 
> OK, I won't insist... But I don't really understand how this can help to
> improve the performance. If nothing else, this adds another for_other_threads()
> loop.
> 

If no dead-lock is possible it is better to complete the de_thread without
releasing the mutex.  For the debugger it is also the better experience,
no matter when the ptrace_attack happens it will succeed rather quickly either
before the execve or after the execve.

> And again, the unsafe_execve_in_progress == T case is unlikely. I'm afraid this
> case (de_thread() without cred_guard_mutex) won't have enough testing.
> 

Same is the case of a multi-threaded application that does execve while other threads
are still alive.  But I have test cases, they are pretty good at reproducing the
dead-locks.

> In any case, why you dislike the suggestion to add this unsafe_execve_in_progress
> logic in a separate patch?
> 

I do not want to regress use cases where there is no dead-lock possible.
The saying "if it ain't broke, don't fix it" means you shouldn't try to change something
that is already working well, because meddling with it could potentially make it worse.

>>>>> +	if (unlikely(unsafe_execve_in_progress)) {
>>>>> +		spin_unlock_irq(lock);
>>>>> +		sig->exec_bprm = bprm;
>>>>> +		mutex_unlock(&sig->cred_guard_mutex);
>>>>> +		spin_lock_irq(lock);
>>>>
>>>> I don't think spin_unlock_irq() + spin_lock_irq() makes any sense...
>>>>
>>
>> Since the spin lock was acquired while holding the mutex, both should be
>> unlocked in reverse sequence and the spin lock re-acquired after releasing
>> the mutex.
> 
> Why?
> 

It is generally more safe when each thread acquires its mutexes in order and
releases them in reverse order.
Consider this:
Thread A:
holds spin_lock_irq(siglock);
does mutes_unlock(cred_guard_mutex); with irq disabled.
task switch happens to Thread B which has irq enabled.
and is waiting for cred_guard_mutex.
Thrad B:
does mutex_lock(cred_guard_mutex);
but is interrupted this point and the interrupt handler I executes
now iterrupt handler I wants to take siglock and is blocked,
because the system one single CPU core.


>> I'd expect the scheduler to do a task switch after the cred_guard_mutex is
>> unlocked, at least in the RT-linux variant, while the spin lock is not yet
>> unlocked.
> 
> I must have missed something, but I still don't understand why this would
> be wrong...
> 
>>>>> @@ -1114,13 +1139,31 @@ int begin_new_exec(struct linux_binprm * bprm)
>>>>>  	 */
>>>>>  	trace_sched_prepare_exec(current, bprm);
>>>>>
>>>>> +	/* If the binary is not readable then enforce mm->dumpable=0 */
>>>>> +	would_dump(bprm, bprm->file);
>>>>> +	if (bprm->have_execfd)
>>>>> +		would_dump(bprm, bprm->executable);
>>>>> +
>>>>> +	/*
>>>>> +	 * Figure out dumpability. Note that this checking only of current
>>>>> +	 * is wrong, but userspace depends on it. This should be testing
>>>>> +	 * bprm->secureexec instead.
>>>>> +	 */
>>>>> +	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
>>>>> +	    is_dumpability_changed(current_cred(), bprm->cred) ||
>>>>> +	    !(uid_eq(current_euid(), current_uid()) &&
>>>>> +	      gid_eq(current_egid(), current_gid())))
>>>>> +		set_dumpable(bprm->mm, suid_dumpable);
>>>>> +	else
>>>>> +		set_dumpable(bprm->mm, SUID_DUMP_USER);
>>>>> +
>>>>
>>>> OK, we need to do this before de_thread() drops cred_guard_mutex.
>>>> But imo this too should be done in a separate patch, the changelog should
>>>> explain this change.
>>>>
>>
>> The dumpability need to be determined before de_thread, because ptrace_may_access
>> needs this information to determine if the tracer is allowed to ptrace. That is
>> part of the core of the patch, it would not work without that.
> 
> Yes,
> 
>> I will add more comments to make that more easy to understand.
> 
> But again, why this change can't come in a separate patch? Before the patch which
> drops cred_guard_mutex in de_thread().
> 

I did this mistake already, the end result was that a patch was split in 8 different
parts, but one of them was not accepted, and therefore we have now the test failure
in the vmaccess since 5 years now, because the test was designed to test the complete
puzzle, but one puzzle part was missing...

>>>> 	int lock_current_cgm(void)
>>>> 	{
>>>> 		if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
>>>> 			return -ERESTARTNOINTR;
>>>>
>>>> 		if (!current->signal->group_exec_task)
>>>> 			return 0;
>>>>
>>>> 		WARN_ON(!fatal_signal_pending(current));
>>>> 		mutex_unlock(&current->signal->cred_guard_mutex);
>>>> 		return -ERESTARTNOINTR;
>>>> 	}
>>>>
>>>> ?
>>>>
>>
>> Some use mutex_lock_interruptible and some use mutex_lock_killable here,
>> so it wont work for all of them.  I would not consider this a new kind
>> of dead-lock free mutex, but just an open-coded state machine, handling
>> the state that the tasks have whild de_thread is running.
> 
> OK. and we don't have mutex_lock_state(). I think that all users could
> use mutex_lock_killable(), but you are right anyway, and this is minor.
> 
>>>> Note that it checks ->group_exec_task, not ->exec_bprm. So this change can
>>>> come in a separate patch too, but I won't insist.
> 
> Yes. Although this is minor too ;)
> 
>>>> This is the most problematic change which I can't review...
>>>>
>>>> Firstly, it changes task->mm/real_cred for __ptrace_may_access() and this
>>>> looks dangerous to me.
>>>
>>> Yeah, that is not ok. This is effectively override_creds for real_cred
>>> and that is not a pattern I want to see us establish at all! Temporary
>>> credential overrides for the subjective credentials is already terrible
>>> but at least we have the explicit split between real_cred and cred
>>> expressely for that. So no, that's not an acceptable solution.
>>>
>>
>> Okay I understand your point.
>> I did this originally just to avoid to have to change the interface to all
>> the security engines, but instead I could add a flag PTRACE_MODE_BPRMCREDS to
>> the ptrace_may_access which must be handled in all security engines, to use
>> child->signal->exec_bprm->creds instead of __task_cred(child).
> 
> Can't comment... I don't understand your idea, but this is my fault. I guess
> this needs more changes, in particular __ptrace_may_access_mm_cred(), but
> most probably I misunderstood your idea.
> 
>>
>>>> Or. check_unsafe_exec() sets LSM_UNSAFE_PTRACE if ptrace. Is it safe to
>>>> ptrace the execing task after that? I have no idea what the security hooks
>>>> can do...
>>
>> That means the tracee is already ptraced before the execve, and SUID-bits
>> do not work as usual, and are more or less ignored.  But in this patch
>> the tracee is not yet ptraced.
> 
> Well. I meant that if LSM_UNSAFE_PTRACE is not set, then currently (say)
> security_bprm_committing_creds() has all rights to assume that the execing
> task is not ptraced. Yes, I don't see any potential problem right now, but
> still.
> 
> And just in case... Lets look at this code
> 
> 	+                               rcu_assign_pointer(task->real_cred, bprm->cred);
> 	+                               task->mm = bprm->mm;
> 	+                               retval = __ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS);
> 	+                               rcu_assign_pointer(task->real_cred, old_cred);
> 	+                               task->mm = old_mm;
> 
> again.
> 
> This is mostly theoretical, but what if begin_new_exec() fails after de_thread()
> and before exec_mmap() and/or commit_creds(bprm->cred) ? In this case the execing
> thread will report SIGSEGV to debugger which can (say) read old_mm.
> 
> No?
> 

Yes, and that is the reason why the debugger has to prove the possession of access rights
to the process before the execve which are necessary in case exeve fails, yes the debugger
may inspect the result, and as well the debugger's access rights must be also sufficient
to ptrace the process after execve succeeds, moreover the debugged process shall stop
right at the first instruction where the new process starts.

> I am starting to think that ptrace_attach() should simply fail with -EWOULDBLOCK
> if it detects "unsafe_execve_in_progress" ... And perhaps this is what you already
> tried to do in the past, I can't recall :/
> 

This was indeed the previous attempt, but I changed my mind in the mean time,
as the return code -EAGAIN from the ptrace_attach is not documented, and is therefore
an API change, but also the debugger might misunderstand that hint, and try the same
ptrace_attach in a loop, instead of calling wait for the pending SIGCHILD signal.

I know Linus pointed out that the tracer would better use a signal hander, to avoid
the problem, but I think that no debugger wants to implement the state machine that
handles the ptrace events in a signal handler.


Thanks
Bernd.

> Oleg.
> 


