Return-Path: <linux-fsdevel+bounces-69373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A66B6C78CCC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 12:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 877292C44C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 11:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3B6348877;
	Fri, 21 Nov 2025 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="XQgmvGC8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazolkn19013081.outbound.protection.outlook.com [52.103.51.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443E933D6CB;
	Fri, 21 Nov 2025 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.51.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763724417; cv=fail; b=QyyS4ex7NXn2ZKL9Qrpy+FgKWOmkyhbDE5xtVeGwhHDcIFEWJpCXujrColA5lLRt+TKY1/avpifgqD9zXlWKIzJFEaTJb7rYOU8akNIds1fIVbrqm6JmoaXZ6IRj8OckXR4c6PZv6b6TdpIXwkCJkWbEPiNNqv/LnQfJAiE1uw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763724417; c=relaxed/simple;
	bh=UlX0HMaktNUa2WVV3ewylg+AsbUpF+CFRaVIj9+O4lA=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FWPz/praTgeT4awIXC0Yqkn+IbFbIP1Nn0+i9QPR0K1RgqODUZst4g0qZnOseV4bKS8O6p3UTvDKtlipDiDbI4SAwu4pnIu+0Z4RhT9Prh66AY2ekMkjte3HYJf3e/lRFkpYeTemhtB1ubJmhJU0u3Z1UhgPhRwIoVGglNrHoOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=XQgmvGC8; arc=fail smtp.client-ip=52.103.51.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUY0INT/pDPmKHQgiWeynXhIpPhN5PPAC9JWqI+R/Fqt4AF1IaKGEpgSHalSz74oMCK+Q4vdGFZ8b+St4NYJLCot4ojmaYXyzzH6Dh0/jlh6tygLJFcfkEMD9TNDQbcw3c45hhkJQf+pLhHljI9AciSfMizwB4BsM2KgsQ2CeHnWiKQIAp9RCbCOq4GPB93PEnrNDPuiJrzN4pQib5clYb55Q1MK4JrKaHaBTv8HxBmIdiCsy9pQiERm5rUy+d0FBMLQRLeU99MbZedwlViIuxdKcMr8MFqA7SZQUEueNOr5hue1Zef+J2Vh8yvkeJgCPBZC7wlZTa05g0IHEsUbNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9JbpQ65D/TNfcoH4iR2VrremkZhuKTi+gKg/P60g44=;
 b=XS9AOtvBOe1tgLejo07h+ys2ihfaaiOtlstrCjt2z3Efjnln/hiWaEwSYYYIDGYJIM3YFcIiNdE3hMquO9JhvP96Vgzaw4yC/pfLAsTML7GtYe9p2gehp+b77V5IobbrApwOVjmIpqmbt3zDxxQ5/ZYyaQHzw1JTdPDMQTZAtRENzKMMb6HmxX15xOaqNTkqZsOkroDI5BAJtH80K/hyNotyqsnZEQz4KbVSB1KmfKNK3STMi3jtkZjEu2pN0O+52xeUFlmTdvo76M1YF3c1W8hSS89VU7gQXpUKnHEnEND2MPqGmIBlFW4NcLJJNqo9y4irKiySO8S+p4a8NXXajA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9JbpQ65D/TNfcoH4iR2VrremkZhuKTi+gKg/P60g44=;
 b=XQgmvGC87oQNDHgeVubqpbDG4duV6v4BXsvLuSYQpnpQwLr1pYI0e3CGeUN66zH9yGbRelMg3JAEJg8RoT5OTMplYtEp/N14x1iHSFhtZ3f7h/q4CbmUcWGsGOsMEEDlbe3/NrAMjW1Cz90jmB0EWWxgItSyx2v9fUAsAevumrJvDsZh0tzqUAzP3GCZqSw28F4u5nO6VM8XRIEWMvfpiAnn5f7dPcolb5KImYA5h9wkocVfexE2M1NPXiur53V9inqy/INa6L5qq8GqBsCmvlIU5ogre8BX4C7vnOjbwFIL181hCa+Md6PSflEGBoERmWSLtDOACd2scZUO5WTNcQ==
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4) by GVX0PF97A28093C.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::7d8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 11:26:51 +0000
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::dde:411d:b5f2:49]) by GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::dde:411d:b5f2:49%8]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 11:26:51 +0000
Message-ID:
 <GV2PPF74270EBEED0840E45459881C0EDD4E4D5A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Date: Fri, 21 Nov 2025 12:26:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] exec: Move cred computation under exec_update_lock
Content-Language: en-US
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
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
 <GV2PPF74270EBEEFA106F4EF26B087ED898E4D5A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
In-Reply-To: <GV2PPF74270EBEEFA106F4EF26B087ED898E4D5A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::19) To GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4)
X-Microsoft-Original-Message-ID:
 <8d8912d7-ca7d-455f-81e4-8b9a638a9e94@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPF74270EBEE:EE_|GVX0PF97A28093C:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b7cf753-2140-4035-c00f-08de28f0dd77
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnqtIWTVy3iGwCmLGPV7Nste/Lq1zjGdPB5r7j/0FYwBqL/3N4zb96/DYVaWA/Hzpqdd3zc1gHszSs4PcKFfAvDXV0PZNqeltmYtCj8ye1LAlGqzSoGWj2fQ5vH/OW069pPReLFXR6mSgfToi7LwHV+VYv1jAcNuOAkIXkJAlARapV6LxybXljbg3qcp0FqMRDuRT/By7LA5jLijc38xzV1v8avmO9lK6f/D3oU6mWlSuOyLwKjj5e1cvjQxiQbBtaAN731Z9euKAq53s892biTywb7qbDgXvLcJSGdLQGo+EFiRzs44VZq6fzppKAqpCi7gAK80qpYvPK6nPbK1449kJCTEI7HdaHRdEFYJfilQI/9MdVWkLANoYdYl45G+7tc3Nx4bIDn0wimQ3oGDwmcJzTgei2infYHSLHDWtDnfZzTsKaMtkPuAaPK5T5CbBMjt/aZ8FUeiX0+usWgcYj3izEL7kWvCR6qU71uT/Eg+YJZDKDQzEjS3hbNv0CGu6XcylgtahqhZtF51MmstpfNTxcw5fZ3oTCcN4tWNso+MB+A0KNLG8qqYE+yXoadIE17uKuKHIU8UW9kzay5Z5FH8SGJxtls7IX66LVNdOa7Sybj/0KHM8fuHykrAsQIlwm7ZBXtFWkcF/uxIBEuwmmHjrWnTex9m4J84EJIWcX3lVf4txs4Vzf4H9tAQP9kqY7hoPJXgA2D6+A8qmZhJFyOTjR4x29AT1XHVOhvr4XgdaaXRZtyloIsHWnhIazrIo0s=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|41001999006|21061999006|23021999003|8060799015|12121999013|15080799012|51005399006|461199028|5072599009|6090799003|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDZnTnFLSXREd1dHVlRrUTdsbDRTVnZDTnQzWEVoTm16RGZOalBxVkN2MkhJ?=
 =?utf-8?B?VzU0OGp3MDlpcWlHeFJUM1FYa1BGUm9mVDV3SkFLWWxjTVNvR2o0Z0piTW41?=
 =?utf-8?B?Uy9tWUlrV3hIUzRYRjNTNnA3R3pXMzJFUUhCWDNuamgxY3BzZ1drQmhqY3ds?=
 =?utf-8?B?c1ZHSE9OWlRRazh0Q2VGaGphWG0vUjdOam1YUGs4LzdSYW1odzlhK0tpZldx?=
 =?utf-8?B?Z0ZSNjdEcGlTT2Q4Y2RNdDNtV3BYUjFsZE55NUlKb3BLdDNKQ3gxeUx2aHZz?=
 =?utf-8?B?SmlqdXVmRmsvL3FTYTZTV0t6M1RGdndKNmpodXpqZmplZUJadzRoNGR1SnJG?=
 =?utf-8?B?ZS9RYkJIY21ENUR4WU5iTXY2bjMveGxkenNFQzJCdmgvbTU5R2FYd0lUdnJ4?=
 =?utf-8?B?c0FMNDlNQzRJN1EwS2VQNTlnQVI2bjdQS3NQSWJTQ3B6a3U5dnlRZGhjMmEr?=
 =?utf-8?B?YkpxYmVueHQ4VlJtd2JYbitPYkRGNElVc3pTSk16KzJUYkZkRHZ0c090dVhw?=
 =?utf-8?B?L3dXYTM2YllhMUVFRlZqam9NcmhBdEMza1FkQzB0NVpwaDEvMjNadkNpeEJh?=
 =?utf-8?B?TjI2ZzhaRkNxNXRZOExMTjZkQ3NkZ2Z1N3p2QmJFUWlxZkw1eTR0NU8rT3NF?=
 =?utf-8?B?N1BoUFBGQzdYaHcrTm5DWmZJT2Y5RC9hck5EVWtId3UrdzNnb2F3dzZPV3pD?=
 =?utf-8?B?NmVMbk5kcnI5UlNielZBSDF1UXpFTkZzYUQ0L3RqOVhtdHRyYnBaQyt0ZFM5?=
 =?utf-8?B?blJ6N2JrbjhWLzlwL3YydjZ5SkYzRlhhUTNjSkpnUjVBRFIrcnM3eEhZZDBE?=
 =?utf-8?B?alVtN1N0YXc3bC85MnFZMG4vNHh5TUJRVHE1TWpEY0xyVERBeWx4NXBMU2hW?=
 =?utf-8?B?WTE1SXVPZEFyMFAwNzcwZVdtU1IrMGFWMEE4UGFXYlJFVFhNVlZCZGEwbXUv?=
 =?utf-8?B?MTBRb3FiQTBnYnlUWlY5MjdsWHdwYjZSZjR1SzZuRmYwTWgzcUpoRDF3WkZS?=
 =?utf-8?B?MzQzUkg3MjE5bVZORTkxTXAwN25tK2FBYko5VnV5VE12TW01SHN5TlhmbnNk?=
 =?utf-8?B?Sk4yc3NObS96d1JRL3Y5UCt6dXUxQXRZWWUyNndpeFZtZENMY1NPd3hNNGhn?=
 =?utf-8?B?bEl6NjVBUVM5UGdUYjZqME1PS05iRzQ3TGIvdUE2dWp5M1RoNVJ3YktPbnRV?=
 =?utf-8?B?UVNNb3RzYmwremw3cjBmcjJxYktOZm0yZVdQWkhvMWNuZ0I3TExFNFpTRkFo?=
 =?utf-8?B?N3JxZ0owdTlxMS9sTDJqbldrV3BBYkVTOWxWVEcvZ2NuQWRtbVBqcDR4V3l2?=
 =?utf-8?B?OTBPdmthdTVEN1h1dFQ5QVBremxobnk4SXVZWVplRFBZWHQ2NGxoTjNRL2JU?=
 =?utf-8?B?a2FTMkh6dWVUNCsvNVk2d1VZb2RObkt6bmhwdEcxVjhrUjdMYjRlVXFDUE40?=
 =?utf-8?B?OFRqNVYyTmY5QTU5QXdEck5OUXhHZDhFamNpTmhxOWNDT2RWamx5dTJacGlu?=
 =?utf-8?B?KzFFK1YvRXgrZjJBaXhpNzdTM3NURUpqcEMxOHY4MzdDM1JlMUpBUXlReGpZ?=
 =?utf-8?B?dndpdzgzQkZqUXlSUVR6ZlcxV250bjA4RTZMK1VBM29NS2dsMXVBcXljdGZD?=
 =?utf-8?B?UzlTVmVRdlJwNldtVjZ2bXVZRUMyRXNXNDQ1bnVwRmFnd1RBTWV1KzZWUndm?=
 =?utf-8?B?SG9XbW1PczRjSkU2NUs3SEFJWmE0a2VJK0xiZmpwcVVXZnYzTFZMVWpHKzBm?=
 =?utf-8?Q?JwtW5DX8P0hESSxEkxjEleToyjYcTy9NU2Ic2Jh?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVZZMEtOUEdUSWZGd2pqNFd4STVnTjU1WDVGWFNGZHpwWndjMGJxbER3T0U2?=
 =?utf-8?B?TWRRMDZ3QUx4WXNwYkladzJoZnZCNEtWM0RSaGhpVTR2N01WaGdzNzNJcmYx?=
 =?utf-8?B?dDJPQzRidG95N0hTVngyNkh6Z3ArY1QwdmphS1VVVGt2WDdqQmo1UlRINmts?=
 =?utf-8?B?NmdoMk0rc0JCNGxVVEVYUVBjdFFpU0VBaGVrc3FXaE5CRDVlakV3bm1Nd2FS?=
 =?utf-8?B?cnZrem5HUVRrUDRQVE1jdTNTTm1tWnp6MHBBYXB2L3lXQWQxSFE5QmJTRjg4?=
 =?utf-8?B?ZEtlVUdCcDZkdFJUUUo3aUlDdHZab08zNHllMVlTQ2ZvODJWT0NsY3lXL1p5?=
 =?utf-8?B?akhYVjNDL0QyNFBmN2hhTUVMb0xtYU16bmt0WXBpaE1ibEN3TXQ2enRhS1pV?=
 =?utf-8?B?UXE3R0xxcGR2V04wWjlKYWlmaG5CU0ZwRjFIaEo0NGRUN0NaUGthMm9YSWR6?=
 =?utf-8?B?QzZYWkdKL25Tc2taMHp2Mk1TbnF4Y2pDNitYMXBVc2hlZUg0eGEvakZOSWd5?=
 =?utf-8?B?d25GMW9yckI3S0FDMVh1U0ZJTHJtdGNiRHU1ekZkZFYzUWF4UzJFdFVNMmVr?=
 =?utf-8?B?ZHRlVUlYSU9vaTZjREtIT0VxY1B2bENaYVVJNWtlMDlkaEE3eVJSdE8ySHhM?=
 =?utf-8?B?cWJOSjlrWTVGelFOeThGSjJRUCtnSTkweUhpN0xuTnVINXFFOGIvRERpcUho?=
 =?utf-8?B?TS9PSmpsenZtSmdKUm1ycUZka2JOWEpZVlR6YkNOOGFzNFcvNHFsUUtJcTBt?=
 =?utf-8?B?OHlWQnlXdHRJUTJsT1dZMVZKRGExNWc2SUJ5bzRzRlVBa0xKVnd1RFQzRkNU?=
 =?utf-8?B?Q1FOMmJoQ3FWTkx3NkRqanFtdnJWQ0drcXdRdEsvbjkxSmprU0Z5MFYxdDNE?=
 =?utf-8?B?RzlrMjhXQitYRVNKaWEwaGNkV3pnNlJwREhMSDZDV1ZpRlRBci9mRzJuSldx?=
 =?utf-8?B?c0g5b1BuMjNlbkJ4K1lkKzFjbENvaEczejNPc0k5YW5vVzJOMHA1RTYzaUZR?=
 =?utf-8?B?U3N5ZDNtZlF2U0NieVpzbDB4RGtiSEYzZm1YNnY4SW83UUFvVGI3NU02ZEFy?=
 =?utf-8?B?ZmhoSzRpcURVRytNVGoyckF0T3lEcmRycXdTa0k1ejBmUWkvRERIZHpZWlRu?=
 =?utf-8?B?ZWZJdWFOL0tNVERiOEJPS29iblk1cE5jRUdIeXRQN0NTcVpIdlJOMThCQjZ1?=
 =?utf-8?B?ZlJXR1JwOTMxQkwzWE1zSzRWWTNteWpHbWE4bEhNZzdRQXA0RlV1SjFCaUZQ?=
 =?utf-8?B?aUtiYjk4OTRobVBSY0dhcmlRZFV3Vy9TcW4wQmtlUDhySG1tRW0yZzVzTkIz?=
 =?utf-8?B?QjlCNDV3S2dlQVVIUkVldlRKcGRDZTVETENEa2ZFOWdDUlYvMW5YMTF4SnJq?=
 =?utf-8?B?NjRLSHY4Q0xwc0dhS2ZaQkIvSEg1QTROUFMvalVhOWJFbGVFN2d2cGdRVFdR?=
 =?utf-8?B?NXdBcmR2dkVHdjIwL0FPVU9rUUtaZCtZUkpWRW50WGtqWDdoaklVTTdCemFz?=
 =?utf-8?B?L2puMzBTUlh2OGx0U2NYOVhZdWpaY094bS9KSy81ckcvck9VQ0RXYXlSV1Ex?=
 =?utf-8?B?WWhxWWNVa20wS0ViV3FaMUFQR2dmR1dmeGdQZU9FdnNHaGgzUkd1Uy9vWFVw?=
 =?utf-8?B?MVUrS2FwTHE3NC9DMUU2L0xQMTdRb3BqRU82TkFXZFJtdHZhM25hWm9QT2Z5?=
 =?utf-8?B?RHZqN01LZm1VN0x5YzgzNTFFU2FWUU1qOGpwajJhWkplVS9KMjhFYmREcG1J?=
 =?utf-8?Q?RYCAdsvXaFEBHOPK7nxYc1bYfuez69VCZ6i77hQ?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-87dd8.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7cf753-2140-4035-c00f-08de28f0dd77
X-MS-Exchange-CrossTenant-AuthSource: GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 11:26:50.9820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVX0PF97A28093C

On 11/21/25 10:35, Bernd Edlinger wrote:
> On 11/21/25 08:18, Eric W. Biederman wrote:
>> Bernd Edlinger <bernd.edlinger@hotmail.de> writes:
>>
>>> Hi Eric,
>>>
>>> thanks for you valuable input on the topic.
>>>
>>> On 11/21/25 00:50, Eric W. Biederman wrote:
>>>> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>>>>
>>>>> Instead of computing the new cred before we pass the point of no
>>>>> return compute the new cred just before we use it.
>>>>>
>>>>> This allows the removal of fs_struct->in_exec and cred_guard_mutex.
>>>>>
>>>>> I am not certain why we wanted to compute the cred for the new
>>>>> executable so early.  Perhaps I missed something but I did not see any
>>>>> common errors being signaled.   So I don't think we loose anything by
>>>>> computing the new cred later.
>>>>
>>>> I should add that the permission checks happen in open_exec,
>>>> everything that follows credential wise is just about representing in
>>>> struct cred the credentials the new executable will have.
>>>>
>>>> So I am really at a loss why we have had this complicated way of
>>>> computing of computed the credentials all of these years full of
>>>> time of check to time of use problems.
>>>>
>>>
>>> Well, I think I see a problem with your patch:
>>>
>>> When the security engine gets the LSM_UNSAFE_PTRACE flag, it might
>>> e.g. return -EPERM in bprm_creds_for_exec in the apparmor, selinux
>>> or the smack security engines at least.  Previously that callback
>>> was called before the point of no return, and the return code should
>>> be returned as a return code the the caller of execve.  But if we move
>>> that check after the point of no return, the caller will get killed
>>> due to the failed security check.
>>>
>>> Or did I miss something?
>>
>> I think we definitely need to document this change in behavior.  I would
>> call ending the exec with SIGSEGV vs -EPERM a quality of implementation
>> issue.  The exec is failing one way or the other so I don't see it as a
>> correctness issue.
>>
>> In the case of ptrace in general I think it is a bug if the mere act of
>> debugging a program changes it's behavior.  So which buggy behavior
>> should we prefer?  SIGSEGV where it is totally clear that the behavior
>> has changed or -EPERM and ask the debugged program to handle it.
>> I lean towards SIGSEGV because then it is clear the code should not
>> handle it.
>>
>> In the case of LSM_UNSAFE_NO_NEW_PRIVS I believe the preferred way to
>> handle unexpected things happening is to terminate the application.
>>
>> In the case of LSM_UNSAFE_SHARE -EPERM might be better.  I don't know
>> of any good uses of any good uses of sys_clone(CLONE_FS ...) outside
>> of CLONE_THREAD.
>>
>>
>> Plus all of these things are only considerations if we are exec'ing a
>> program that transitions to a different set of credentials.  Something
>> that happens but is quite rare itself.
>>
>> In practice I don't expect there is anything that depends on the exact
>> behavior of what happens when exec'ing a suid executable to gain
>> privileges when ptraced.   The closes I can imagine is upstart and
>> I think upstart ran as root when ptracing other programs so there is no
>> gaining of privilege and thus no reason for a security module to
>> complain.
>>
>> Who knows I could be wrong, and someone could actually care.  Which is
>> hy I think we should document it.>>
> 
> 
> Well, I dont know for sure, but the security engine could deny the execution
> for any reason, not only because of being ptraced.
> Maybe there can be a policy which denies user X to execute e.g. any suid programs.
> 
> 
> Bernd.
> 

Hmm, funny..

I installed this patch on top of

commit fd95357fd8c6778ac7dea6c57a19b8b182b6e91f (HEAD -> master, origin/master, origin/HEAD)
Merge: c966813ea120 7b6216baae75
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Nov 20 11:04:37 2025 -0800

but it does panic when I try to boot:

[  0.870539]     TERM=1inux
[  0.870573] Starting init: /bin/sh exists but couldn't execute it (error -14) 0.8705751 Kernel panic- not syncing: No working init found. Try passing i mit= option to kernel. See Linux Documentation/admin-guide/init.rst for guidance
[  0.870577] CPU: UID: 0 PID: 1 Comm: sh Not tainted 6.18.0-rc6+ #1 PREEMPT(voluntary)
[  0.870579] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBo x 12/01/2006
[  0.870580] Call Trace:
[  0.870590]  <TASK>
[  0.870592]  vpanic+0x36d/0x380
[  0.870607]  ? __pfx_kernel_init+0x10/0x10
[  0.870615]  panic+0x5b/0x60
[  0.870617]  kernel_init+0x17d/0x1c0
[  0.870623]  ret_from_fork+0x124/0x150
[  0.870625}  ? __pfx_kernel_init+0x10/0x10
[  0.870627]  ret_from_fork_asm+0x1a/0x30
[  0.870632]  </TASK>
[  0.8706631 Kernel Offset: 0x3a800000 from Oxffffffff81000000 (relocation ran ge: 0xffffffff80000000-0xffffffffbfffffff)
[  0.880034] ---[ end Kernel panic - not syncing: No working init found. Try passing init option to kernel. See Linux Documentation/admin-guide/init.rst for guidance. 1---`


Is that a known problem?

Bernd.


