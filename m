Return-Path: <linux-fsdevel+bounces-69368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 848D1C782D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 10:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 083713454DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 09:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C7E340A4C;
	Fri, 21 Nov 2025 09:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="LFEKNRXl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19011076.outbound.protection.outlook.com [52.103.32.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED1C33F8C6;
	Fri, 21 Nov 2025 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763717726; cv=fail; b=gX3TBIikma8qSVOXXl/m1JEqyJNeR2B9b0RLu26WiU45wpVU4PmIZ0k4uM8v2vrOUpbIxNELnrgig6UvkQuRg+N0hDsSTVUEao8kflX7D09kRhskahXOgCfHLnpA3QgmtrCX8WcrfC8ecLTH9b3Z7eHPykFWyfkzCTnyMuPnSwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763717726; c=relaxed/simple;
	bh=FpTtL2WUARpnr9bYGrZgxtBFZq16VY2SKlH5JoCXtZs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ftSHtFo+gcJxfL2TK8+850DB0lIjJuZy5Oys9nkXht3UCj0fIJtdfKV9SsV0ilEfBt+Fjqkv58KmLSkcC7sJ5O4NXoSHhQZelDrPLgJFdnJ5Z0bUeRTQrwEwhuE2zeyG4F5u1kjVEPMKZbcmVSg3EyDO0iFbUxocNXNv0yJc52w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=LFEKNRXl; arc=fail smtp.client-ip=52.103.32.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXKZzHuh8ZsQvkA8Jaik7+yXaJ3sV0enFkPmL+dfeXj38QhncRzRzusSWcvnenJxwGhZRdq4aPzz9fQwsCOP0fvB1FxlYuKaUrVkUKTS+9azZeHZKRb0lVfnaVkjp0WW0ZDafcWn6K1i1lldWq5Wp44czJBAsldOGfB5uEg4yTDl39zR9s2gweHAi5GVAHGGYrfLT3BkiBLihyryfrXb5SALxBYXqA6MySK6IGhigaskxsZFk8BQP3DhsNeNbWExjVndDcntGcipzpqXiqT8bcdEwas58jTcG1D4R3o0XQVz45GyPhZAV37xocWhbPLO6cwKSO43vmcW0oMqqRMy4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PfkCFPkAGO3JAOl4wKR4vHg4WD6BtcP5GGyqd8pwrc=;
 b=sATDW9NMvf9raYl/1ub7x26jKy3Q+qeKrc+pOJaTqWpc5rvgaejI+f4ufc8o50bfX5dyufmurSPRO1auX1eZhbl6J2bCICpfUiIeF91ze4tPJXwo3s7jVuY86UwBEm5pX6yRJKvrOvdFrTs2KzhvMeokja+YNYnMt3DZdOkRjJ7LRQXcIkFqIq1eQMYU2VGGDSQ2y0/V3vuRvLV3KTSApr5bPyr+WZkVccil3tnEnLOyBlaSK4uVaVK/tWEKJUd91hwX8hDqmIQPtExlkC09Y0TZ1ki4znM6/D/FC9woYdTTYc5olW7P49kTJoqXYp9WWEnHVWZm7E4jnHpVl60DMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PfkCFPkAGO3JAOl4wKR4vHg4WD6BtcP5GGyqd8pwrc=;
 b=LFEKNRXlEUQo1BJCxWJQwnDmyPRqzAGJGDHmIFvF8wB8vfo7OnyNqrX7vRqdi4IopeMobrxnrtf0kRbWZqc8jGnfTTvckKzo4nls+uKxmGi7sYRIaErtogBzWNno6gOUR5IyRi9PVCCvsTj9cKQ4MJkggjrZYioMfYfokMOkkQTW+94SaMvMQdaHdaO95ewiwTnJ7bFO2ixd9RvcXOLBhzF4w7uypUEy2X9IfZcwY7ZNUg2SJacPxD5ZlTnMUNZAjDL5PKXt5+H8vxq8tDeChTFai9Y3R+GKqlyA3fQg9xl7eNJ1hFJ9frsDrlnfim5BGlagWMKV4R5kmtVhR0DC9A==
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4) by AM9P195MB1139.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:3ae::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 09:35:20 +0000
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::dde:411d:b5f2:49]) by GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::dde:411d:b5f2:49%8]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 09:35:20 +0000
Message-ID:
 <GV2PPF74270EBEEFA106F4EF26B087ED898E4D5A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Date: Fri, 21 Nov 2025 10:35:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] exec: Move cred computation under exec_update_lock
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Alexey Dobriyan <adobriyan@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
 Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
 Will Drewry <wad@chromium.org>, Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>,
 Serge Hallyn <serge@hallyn.com>, James Morris
 <jamorris@linux.microsoft.com>, Randy Dunlap <rdunlap@infradead.org>,
 Suren Baghdasaryan <surenb@google.com>, Yafang Shao <laoar.shao@gmail.com>,
 Helge Deller <deller@gmx.de>, Adrian Reber <areber@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
 Alexei Starovoitov <ast@kernel.org>,
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
 <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEE807D016A79FE7A2F463E4D6A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <87tsyozqdu.fsf@email.froward.int.ebiederm.org>
 <87wm3ky5n9.fsf@email.froward.int.ebiederm.org>
 <87h5uoxw06.fsf_-_@email.froward.int.ebiederm.org>
 <87a50gxo0i.fsf@email.froward.int.ebiederm.org>
 <GV2PPF74270EBEEAD4CACA124C05BE1CE45E4D5A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <87o6ovx38h.fsf@email.froward.int.ebiederm.org>
Content-Language: en-US
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
In-Reply-To: <87o6ovx38h.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0355.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::8) To GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4)
X-Microsoft-Original-Message-ID:
 <be416574-7215-4be6-8905-3f239e30c509@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPF74270EBEE:EE_|AM9P195MB1139:EE_
X-MS-Office365-Filtering-Correlation-Id: df3726ae-55c8-4238-2ac8-08de28e149a1
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnqtIWTVy3iGwCmLGPV7Nste/Lq1zjGdPB76ABusgXSZkadQbZfnE7WDtn4bVICK0+ARF/MbpilrZNm45NRKosr4WdPYUmIIRZ7d9861h1WCk4aqVce1hTSZbDH79sIvEstlcTIRctWMmrsjLA95Y7WLR3NzzFYGGSEw/sbWnwjUWuZOb9WWoOSh4HvBAViMb8maoLBsEuDlQpwS4w3hglc6Rvu3hP+Mc9eLc/hS8eogDnwf1Kj1Rokz8DiPwf6Z/EmxNonsat2yrEM4Q+m8E9FdTQHPfn65xdi1Gx9ht1oG8PEtZ5Qv+bEfajNP16I05L1kFktxTj69ZuW3jx2r3IQ178OXRHnEYa6MPGm37P6FKkEw1JL1ZcqcH5JYWRKTzgMyKrKXQsdqAcfqPC2sXA4jdg87hB9bxzQkaQZ4xi2XokDDQy7JNhZkGKBYNFyla9pVbmceIs3o1j5QLN+aRHF5w24o3pGRDH+5QJM45WgZzOTK9xzNEtx4XpS8a0Pyvlr7x6ybrrPEbKaObAO0/3uJQlsNa0unOmEMv+HFpZKWvxW5iN7J9gnER1B77CQv/rYdCqnytLXkrDOZNvkLC25+hibxaDFoi8yb7dPoCqM3Vsdw6v6kxw3XT27KCzv7gOMRNYjrOPDr6Zw61nUmcFxOnxG4QQnswSmq+fjVXcBmaCjfWkXnGdvj60Nd2KFUu/h7Vt1z1GwD3S9qxCgpcYXg+ol/n6emIZeNYKOD9lZHL92pMeKCkdPdll21LqY5OTg=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|21061999006|19110799012|41001999006|23021999003|15080799012|461199028|12121999013|5072599009|6090799003|51005399006|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amx4alI2blZYZlcyaThURFZUcHlQTGxDZFprTytqS09RM2ZVTGp3OU9ieEht?=
 =?utf-8?B?eUdFbmh4UjNuVmQ2akEza0J6OXQweHVvM1g3QUp5OEhXVHB5a00vblg3RXZs?=
 =?utf-8?B?WEN5U0JhdHJyZEYxb3Z6NlpuMHc4eXZ6SDhsMitPTlh4MTJJMnRGcVlWakxq?=
 =?utf-8?B?MW5NaERaeTRJRTAxazNnTTNSdUhoTm1FOXMydHI4MXI3OHRJazRDMlVyUDdy?=
 =?utf-8?B?VW5aV1VqWUVWZURKcUFTY0k3eHN4dzhtRVZLUTB3SG9reUNTYldiWE0yNFFV?=
 =?utf-8?B?RVZzZXpva1VQRWV0bHhyb3l4dmpQZUpObjAzd3hMcXdXS25zWVF2MllWS1dK?=
 =?utf-8?B?SEliOUdOVnFWTGowdjFKRkN2OFhncWdmSTA4ZlhYRTRTclhKUmtKVzFRRHBF?=
 =?utf-8?B?RkdxTkRLTmh0Tk41dUlIZVB6QnkxWXl6QU5NNjA0aG9aQVAyYjhBSStNTzF6?=
 =?utf-8?B?NU1CdWRiQVdrMGF3OStweEFZaWV2b1d6Z08xaDFkNXVlZkVXUWhSTlQyNEFT?=
 =?utf-8?B?S1hnME9VY3dqK0xaMy9jbjZKRno0R0NtUWJ3VVZBcVQvellKdGtuOUtjSTdJ?=
 =?utf-8?B?N2c5WkFCUlc1NG92aDU0TVJ2cFhoZUdOa0xiNmZiZDhwc2NLdDZMUEFHcFVs?=
 =?utf-8?B?R0RJT1h6L1paRVZxelJqMndOSjBkK2NKN2UzWTUwMzlkbHNoQ1Vqbk1UbUJP?=
 =?utf-8?B?L3JDQlpKRlorUlFzV3BpL2NaU29RdTVZbGI5SEdxSFZ6R2ZFL0w1a3YrbU9H?=
 =?utf-8?B?SENpeVZ1Nm0vc3YySWo1WjF0S3FkR005Sk5EOENoaEFueE1WOGVLcWUxM1J0?=
 =?utf-8?B?L3dLWmVFZDhndHYwNmkyK3ZEZks0SkZpZ1NsOEdLRFNESW5VejlaT2t5cm84?=
 =?utf-8?B?UmVHZXFtUkdTd2tZc2pPNTBmSnNoSSt6YmZEempqM09GS0REd3NVd3BSUWUw?=
 =?utf-8?B?ZUN2NFpNZE8wZXd1SEpxQ21LRW9ybXhLd3p1bDBPdXAxOVlGMm9acDBtd1Ni?=
 =?utf-8?B?WU56bkJ1UnBNZGZRV0RMTDNwc2xzTXpUb3VYdEJlWVlyb1pNamx5bUpzWHBS?=
 =?utf-8?B?RC8vdG93RlV4dFRkeFhkMCtJNExhbmRnN0NHNnJRWTlUT2xtZnFwL1pHaWJR?=
 =?utf-8?B?YlJ0U2VidHQ3ekxQVCthaHYzK092VXRhWDdHbkM2aEx6Z2VXanhzcERueHU3?=
 =?utf-8?B?MmZBMjd1MnJ3NGdGbVJKYWxrZ3lMU01pdHN2c1V0cHQ1WmlhRkhieE9oWHp2?=
 =?utf-8?B?VzFtcEdSS0NkNjNxZnhzUEoxTERoM2RwL2FkNEk1MVpXR2VwM25naVE1YmJP?=
 =?utf-8?B?eHhjRW1leHd4cGowaGcrTjVITjZ1RlIyQVl6Y0VZa0RVWWsvS0FMNTVJNVgz?=
 =?utf-8?B?eXpzczZRLzcrY3NIRnZDNUpKYk1RWm5tVEJWTXpVVHUzUllranJUdnZ5MFNM?=
 =?utf-8?B?akhqai9DbkdPeTd6RzJ5YkZVanY1M0N4T29Hc2FWeG9BRkFBSWJCYXZrTDVw?=
 =?utf-8?B?UHh2amtWeGVZNnE0REhNYW9pVzI5WUJ1US9Td3g1TUFsM0V6VzdLWEdtdC8y?=
 =?utf-8?B?WHFLbEFQa2U5WXdWSG1CRHVVcmxjejhSTkliZENwSEEvdnp4eU8rc0c1OXVC?=
 =?utf-8?B?Q2xlRDRLcjEwV0M0U3ZDazZSaTJWQlJSSWwxYTRKUE8vUGxNbk9EZE51bUlw?=
 =?utf-8?B?Y0lVSEY3TFB3WFAvWG83SWJXY2V4NHd5UmphejVEQk9xb2VtWnp1MWhwRkVR?=
 =?utf-8?Q?itK1LO7tYhGcIdXFSGKodSum3MJAEC9LXVXnMKI?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXpqV1l2WnBGbHg4Lzg5VHdkakNncko1UnA1a1VCNHF3RXdFeStGa3NaUVZw?=
 =?utf-8?B?Mi81elZ6RkxXaG0rbSt5WVNUV0JtZ2h1cVEzYnRJdUhpOGZnc3oxakpsejIr?=
 =?utf-8?B?dkREUDBkQzNDYXlhUGtsTjlaMEUvQ3c0MUd3VHVKYmJ5SC95SzhGcTZOZGlX?=
 =?utf-8?B?bWVNRGF4cm1QemJjYmtIQmQ5NGV5VmZrNnJUaTh2UW5XMmpkZG9GTEk1cTRU?=
 =?utf-8?B?ZjI0aWdKNXFleDFPV2VDYUU0N0lKVW1Vc3lYT2dtVU5wNTNHa0ZpajVyQUZn?=
 =?utf-8?B?VHJuZWRIaUJON3ZyYzR3aTFEUmYwTUdqWnpIdityM1NPVllqL0pTa3FjR054?=
 =?utf-8?B?S0J6c0dpcmlsYWZIcTEycWpYcGdweFVQa1RsNGJIQmxHOEZvUFFSdFZiU24z?=
 =?utf-8?B?eGUwRU9teVc2TjZ5SUNlSmJkVVYvMGR5enJ0cGdWU2sxNmcrRlY1WmlUM2p5?=
 =?utf-8?B?M05VUCt2K2h5L3ROZTF4YUpXV2lVVEpXRUlaM2VIMTlPV0t0cnNLSnV6OVlz?=
 =?utf-8?B?N1o4TXhDUFo1c1NvTTJENXFUbWdOQkI5d2hFSFYzbmtpRG1lbElMWlZNcU1O?=
 =?utf-8?B?bXYwMFc1RUwzY3NDNlA1U01aWXlubmFHZnJqLzloenR0cCthK2p1d0ZnRHNE?=
 =?utf-8?B?cElCVWRSOFI4N1FEc1JFYk9leWl3RTJ3U1kzL2RkU1V6K0hLekxoTGpxWHJi?=
 =?utf-8?B?ZVBtYS9xUy9oWDdVaUVmeE44Y1FtU21lTFg3NjExbElYQTdRRVcvVUdsQXo1?=
 =?utf-8?B?MmVkVTNrM3pwMU5QOFd2T1g5bGlhakVnWmZIQUV3L1NoVGRVZURENHQvQ1Zh?=
 =?utf-8?B?bUlDVHk4WVRXRmRTVUZObmNTbmhTV2hQV0VCS2dMR1Q5RUU5U0pmcUtSTVRk?=
 =?utf-8?B?SUg1c29uN0VZelNHWWlwUWtQc09jSlJjc1NnQjlRTVovZ3kxbVZhZHZtaTRK?=
 =?utf-8?B?YzhNQm9iM3E1Mm9uRndkT1BINEZrMUJURndKRkVGZ1h0WTFMVXo5L3k1TnpU?=
 =?utf-8?B?bzl1VVIwaHgySE8wVEVtNkhzQUt6ZUtaeElvNEZ5bkllR3FodEJrQ2s1ZFYv?=
 =?utf-8?B?TDV5MGY2OUVRVUlaNFg5Sk5vTTdTQjY1aFJYLzg2QzVkVmdnYklQL3ptYTE4?=
 =?utf-8?B?aWNCNGRJTUFhdUdTVE5ldEtLd25ON0Y1c0tsWW9tYW1Qd3lLaFRQSEtPRm9U?=
 =?utf-8?B?b0RRT1RCSWtWTFFtbFduZzExRVUzVEREdXBTWEFKRE5jM2gxOGlHYVhVd3FK?=
 =?utf-8?B?dFZ1RWIyZnlEakVlTWo2RXl0OUZqOHpDM3VqV2FUWDVqbWJNNmxkSlBpQm56?=
 =?utf-8?B?WlQxL0dyZ3FjYnByZGptVzRjMW5aQTJPQU8xMGY1VEJsSXJFZmJQMXhQa3ZD?=
 =?utf-8?B?QS90VWpDeTlVUy9OQ2o3Q3FTR0p5WTJZU0p2YTNJTkNwMHlLWEtpNEppY0Vv?=
 =?utf-8?B?WVNReWxaNERNUndUOFpINmlwU2ZOZkVNc2F5QXFWay9YK1lxdm5WMDlLSjdw?=
 =?utf-8?B?VjkrUVZlaWNkazlNRWxnZVBweDA1dkNROXlTVkJNMWJ6dmozbTh4K2huN3Yw?=
 =?utf-8?B?c3hKMk5odHh4UCtydVdxNmZVaW1MRTlqSjMzMHJxOTJGTHBXd2k5ZU9XcFFv?=
 =?utf-8?B?TUUvOTZHc09ZWVpJQ3h0cGU5Qndud0pDMTFOeWVFVEo4aFQ3Ykl3WG1zb0lP?=
 =?utf-8?B?VGxTOExvbmFCSjVHMDlJT0VESktMcUg0dWE2MUlaZk81b0pDekhETmRPUEVo?=
 =?utf-8?Q?ktaxUmNaA/ZkCsaoUwQfWCHY4OspbNfno3vdG1M?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-87dd8.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: df3726ae-55c8-4238-2ac8-08de28e149a1
X-MS-Exchange-CrossTenant-AuthSource: GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 09:35:20.6092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1139

On 11/21/25 08:18, Eric W. Biederman wrote:
> Bernd Edlinger <bernd.edlinger@hotmail.de> writes:
> 
>> Hi Eric,
>>
>> thanks for you valuable input on the topic.
>>
>> On 11/21/25 00:50, Eric W. Biederman wrote:
>>> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>>>
>>>> Instead of computing the new cred before we pass the point of no
>>>> return compute the new cred just before we use it.
>>>>
>>>> This allows the removal of fs_struct->in_exec and cred_guard_mutex.
>>>>
>>>> I am not certain why we wanted to compute the cred for the new
>>>> executable so early.  Perhaps I missed something but I did not see any
>>>> common errors being signaled.   So I don't think we loose anything by
>>>> computing the new cred later.
>>>
>>> I should add that the permission checks happen in open_exec,
>>> everything that follows credential wise is just about representing in
>>> struct cred the credentials the new executable will have.
>>>
>>> So I am really at a loss why we have had this complicated way of
>>> computing of computed the credentials all of these years full of
>>> time of check to time of use problems.
>>>
>>
>> Well, I think I see a problem with your patch:
>>
>> When the security engine gets the LSM_UNSAFE_PTRACE flag, it might
>> e.g. return -EPERM in bprm_creds_for_exec in the apparmor, selinux
>> or the smack security engines at least.  Previously that callback
>> was called before the point of no return, and the return code should
>> be returned as a return code the the caller of execve.  But if we move
>> that check after the point of no return, the caller will get killed
>> due to the failed security check.
>>
>> Or did I miss something?
> 
> I think we definitely need to document this change in behavior.  I would
> call ending the exec with SIGSEGV vs -EPERM a quality of implementation
> issue.  The exec is failing one way or the other so I don't see it as a
> correctness issue.
> 
> In the case of ptrace in general I think it is a bug if the mere act of
> debugging a program changes it's behavior.  So which buggy behavior
> should we prefer?  SIGSEGV where it is totally clear that the behavior
> has changed or -EPERM and ask the debugged program to handle it.
> I lean towards SIGSEGV because then it is clear the code should not
> handle it.
> 
> In the case of LSM_UNSAFE_NO_NEW_PRIVS I believe the preferred way to
> handle unexpected things happening is to terminate the application.
> 
> In the case of LSM_UNSAFE_SHARE -EPERM might be better.  I don't know
> of any good uses of any good uses of sys_clone(CLONE_FS ...) outside
> of CLONE_THREAD.
> 
> 
> Plus all of these things are only considerations if we are exec'ing a
> program that transitions to a different set of credentials.  Something
> that happens but is quite rare itself.
> 
> In practice I don't expect there is anything that depends on the exact
> behavior of what happens when exec'ing a suid executable to gain
> privileges when ptraced.   The closes I can imagine is upstart and
> I think upstart ran as root when ptracing other programs so there is no
> gaining of privilege and thus no reason for a security module to
> complain.
> 
> Who knows I could be wrong, and someone could actually care.  Which is> hy I think we should document it.
> 


Well, I dont know for sure, but the security engine could deny the execution
for any reason, not only because of being ptraced.
Maybe there can be a policy which denies user X to execute e.g. any suid programs.


Bernd.


