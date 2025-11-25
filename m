Return-Path: <linux-fsdevel+bounces-69804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE36DC85F34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 17:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E2E2E352333
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 16:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E3123A566;
	Tue, 25 Nov 2025 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="KUDQhs2A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazolkn19011025.outbound.protection.outlook.com [52.103.39.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A535220E023;
	Tue, 25 Nov 2025 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.39.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087556; cv=fail; b=BZBt4oOwovzj5vwApGjOh8OmXM9elWmmhioU3JBCmJvg66XlZ+u8N3vhelptkHNcCuIzgG3wauQ9O/IK9/j9xIioxem1x+MMe5gR9rkegPQ3cCh1lgh0Ng4ZwWmbFr6EgSxQ1Eek4J3MNaO1GHdNWg7VkgywXhXiRjSg7Rjf0mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087556; c=relaxed/simple;
	bh=zzz/0GkVB3cOrdmctlmZJ2/5fALnX3tJQQ6F5nbSmcE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cNSoAEyL+cbNF5AUILyi5ZroaSVd53FakgdSMRY0ePL/GyZRykxQLYdTpyYm+FR3Hiv4uKKIYiTu50ceU/vxo4BRWrkXqgmX5iZDlfmikP8vToA/+w7AIjLy3ZYW4YfZp6+MmXIRzJFOHTnTJSWEJoA7LXzLZQsqxkYNEUD067A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=KUDQhs2A; arc=fail smtp.client-ip=52.103.39.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bb6AwI8bwxG4IJM/RBuupPVCowbRP3m6WTvuXTOgX8D6ON7gXTC8G5/zpOKApU39WuCz30ub+rTqHns20Q9/kAXy4oFbQqcuw5X240FvBJsu6a9vNDi/HqxG0nXGOhKTHsnGUt7SVIel/enUVdxHMOUm4/od4OZ5lyGtk6VDNzWVKKlxrL8uGOJABIN4fX+bBNI6zXG1pmqZUBJhE6CsETg7kYoavh+stCpaBzTruJGIgGKRv3ekJKxG20ltqAfhovGh3G1bk549nfKMBDbPIdPw5jFGH5kw6lVHXJQ+jJo1Ok+ZOjcWXu2CEfqUY2hiOUBGbDPxXyiotbWDZSBDlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmUIK5/RvAIOyCFMKm/J5TQJjxPy1iCkZWdssuoOcME=;
 b=bPetmXX3rGT4gzKvC0g/IB/W3Ap3ZuoFXcw6RSd3XHSeg4lq4dL0hqLTljG+iif1WiX2tcatMUfjs87FsNFFTIphyD3RZL1eUb7UDofxoWPrB9VEAnMdeHug6UuJ9ZGP/EhFAzgapjiy6fc6eWFbFIiB6tuKgy5c+7MAr3QBw/TCRECAbuxJKd5Rupji4isN9f9yzKJkAm5PezfHOwC+sHcVfDauOIOVmSNNlFp7+wtNUkUrykymb6zSOEEi530MXfIZCsT0r/dZvRHmF3ceXfLE5l+i0Ms42KclcgDqoEwvcnLljh8WXW1sa8FjLkJYXwh4Vh3w6mjvJ8K/5cBRdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmUIK5/RvAIOyCFMKm/J5TQJjxPy1iCkZWdssuoOcME=;
 b=KUDQhs2AKoH3GJ+YbV63xewsdDfdDsSrVChEY4SQ7zMCnw86iDdpTeDKxJ+NS5Eh/oK1PIePI/MRBMfp6e9C/jbp0mK7wzWGMtQkEUYSGetHg86vnxUYSEQBfL5n2D9zbMmh/G1rI2gLquvJzzVbb66h7vwg6iUHi9vOILI4ATvBzxNskL0FkpTUR6CCvoK+EV9ks3MV9ko6Hd99BJlbU4f0c5EoP2G3lLUyEkyX1tJfXUIjqVFXwE6VLhEwfW4w+YMWcKj6mwLhcv+eYt4FJO2smpgz2gz3HE8K1iBa98mu0o0X1PzJ20EWZwz32GjZlfmmo14Sw5GgpYFjkFD4Cw==
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4) by AM8P195MB0884.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:1e8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 16:19:09 +0000
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::dde:411d:b5f2:49]) by GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::dde:411d:b5f2:49%8]) with mapi id 15.20.9343.011; Tue, 25 Nov 2025
 16:19:09 +0000
Message-ID:
 <GV2PPF74270EBEE63737C12FBE0B07D6DDAE4D1A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Date: Tue, 25 Nov 2025 17:19:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] exec: Move cred computation under exec_update_lock
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Alexey Dobriyan <adobriyan@gmail.com>, Kees Cook <kees@kernel.org>,
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 Christian Brauner <brauner@kernel.org>,
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
References: <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEE807D016A79FE7A2F463E4D6A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <87tsyozqdu.fsf@email.froward.int.ebiederm.org>
 <87wm3ky5n9.fsf@email.froward.int.ebiederm.org>
 <87h5uoxw06.fsf_-_@email.froward.int.ebiederm.org>
 <aSNX5B9a5iSjJcM1@redhat.com> <87tsykuyf7.fsf@email.froward.int.ebiederm.org>
Content-Language: en-US
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
In-Reply-To: <87tsykuyf7.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::10) To GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4)
X-Microsoft-Original-Message-ID:
 <c45f65ea-b311-47da-a6af-e8f86aa6832c@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPF74270EBEE:EE_|AM8P195MB0884:EE_
X-MS-Office365-Filtering-Correlation-Id: 231c8fe9-cb76-4157-dbfa-08de2c3e5c74
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnqyXd+wC6mISbAMXYCOP4i7hB6VdtoeT/HvoizDWFL+912+f0b08x9xU8UqPxbv5wBy8+h2LmeonS08Zc0M0PFIwW0PoRbs3Vkitr8oX/wvUD0JT/kvqzfkwqxSqpjhq4O+HGLFZLCYZ/IT2e9KiwjLAhvz/9p/e/niID0lewj8hVETnvf0ZAb+2jLwUf7RX6P6Da3fexUDw7ddnu2GqBsAdx7z/50XCxdybCQziR/ZJ/wxx/rQfaGJPFW1Ie7gJnC5+hWl/bMOLNHtndq3hZ4Ea7dG4Xuifglw9fU5BKuP/sS/fQGxKvFxLE2mPYeVe8k4fYQjtJD/JWPYxJy7hTfN4ResatTHuF5xXbkTWPGBZWdHL344sqqrWSbo8RaeVk0bDsHpmXgYGWBYIgB0K2KdeHuVvbdQ3Tya6TJtfMdZU0BwpPzXmbCUzcHry+GBsp/48AGLLQ//wlYRjGAiTYBSd6/F5TYKjbsNc3OWj/MF8N2956YS2wTortt7ZDz0nUygBixEQVWo5Uf8PmGJ7w8gblrbv7Zt14Y2DSFnZL9dJGMF4LfMiSZz8PzRWaAeTfm4lsZ3EPRwNRHmb9rsXnUsrlg23VZw9N5P3Nr9crTyE5xMfHyrWchl790K2enrCZt+J/lFmGzBXKgfmD388yNWNC/uJ1xEwjtglNVyn1P+dsfcigPm3zTJmAzcaPVrym5nzDSqbMqhoJTKKFIC9JZ3c1Rl2UPfKYCvNCe0ESXBT489WKJ7H+sDQW2wNJkv2C4=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|15080799012|461199028|23021999003|19110799012|21061999006|12121999013|8060799015|5072599009|51005399006|6090799003|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWwrS2tmejBGcWhZcmphU1RlaTUwUFBrMlZ3ZzZ1RUxXaDBxSnBxZzgxdDhC?=
 =?utf-8?B?U01QRlZhN2ZnYlh0Vk04QkFXM0Nnb1dFN1FHMkd4Zi9FUEhXMGltZXcrZ2No?=
 =?utf-8?B?eVZZdmEzRXRGcGRHUWFxckpYVzN4N25OTHY5N281YUdBOHNhdjJncExBaktG?=
 =?utf-8?B?dlFCZ0tZMlVUL1EyU0NRNmJDaWZZbDJwQXRoVk01em9zbDVCQ2F6c3NkbGt6?=
 =?utf-8?B?cEFHTHdKRlczNUoxTkw2cXRUM3VGNzF4VDlPSWJuVFBTSERNN0xQZngxcWNn?=
 =?utf-8?B?ekk3VUtNMkt4UkowMjhxSzlhY1M5OTRadVRRVlJOTnZQdlpqN3l3NXdvWitI?=
 =?utf-8?B?WXZtVE5xZXVza2RnSUg1aGtLVFEva29sZjlBMnRpaHJSK2U0TitiVXdlQTlL?=
 =?utf-8?B?SXR3c3EwRzNOMWZBQ0FGMlJTQnNackF3L3I1WVg0S0FxVkJsb1RiMVlYOWcz?=
 =?utf-8?B?TjNrMnlOVDgxaFJtcFZ4M2JjUVl3cU1GanErbEVlQmlQZzBIZk9EVS9LQ1l2?=
 =?utf-8?B?VkwyNlB6SHY1bExPWGlybms5Sloxcmh5cTNPMWlJY1YwSVRmN1l6ekJwbHpC?=
 =?utf-8?B?V3k1eXBad2w4WlNZWDhCZmpid1ZFcEg4dFF3bTQ3UmYrYU9KbHFIcGFwaFdG?=
 =?utf-8?B?aWRjR1ZtSFNIazhzKzEyVUdkTkgwNDhTVWJCTzd5VTVYRzBZQjNzZVAwUjRI?=
 =?utf-8?B?ZE9Ca20yOWQrQVhMdDJ1R0hsZXBtNmw3THFkVUtaTjMvVFA1S0lIZjdWVjcy?=
 =?utf-8?B?VktxWWZJTEVTNEdLcmhhaGwrN2lEekdLR1k4YkVTR3VDSjlObjNkc05neHoz?=
 =?utf-8?B?Vk55QThhQXI2WHNweXRwWldab1FYdWZwYjNiQmJweEx5UGlvUnN3WFJJZlhp?=
 =?utf-8?B?dFhrRXAybXlWTTAxWGVvT2Y1WFQ4M0ZzM3pIbGNvK0pteWRab1RKZU04bEh1?=
 =?utf-8?B?RzBpR3JFMWZ5Q05vMGJGM3pHMzZRS0lueDdvN2crMkprQUhnNEgyeFNOR1hu?=
 =?utf-8?B?b1hDRW5KQjg2WnJsbHE1TnF0UGk2SU1EM2srdzdIQTUvaHlKTWRINW51alZL?=
 =?utf-8?B?WXZTMk9CT0hjVTBSdmp4bS9qQlBXY2NkakdjbXRYU0QwOFpYM21taGRjY0Nz?=
 =?utf-8?B?L1I5d1ZvSTVMMTBJOUZkeHVyYjVqVndZN05jcDBpZ3hzOHRNc3NLSEw4SW9z?=
 =?utf-8?B?ZGw0dUo3UmNGK0ZJVUpJZ3RMUFpaeXBSM3ZkZHlkMWhhVmVLblZBU3M2cEc0?=
 =?utf-8?B?RktPblJXZjBPTzN5bmZkWXVTbEdrOGg1dkphbnFFTjNiaVE2V0ZaR21RTzUy?=
 =?utf-8?B?TDdiYUF0WXo2VVkzQ0J4cnVhWVJiVDVBdlVubjRoazA4ODU1dUp5QXYzVXZY?=
 =?utf-8?B?MDd4S20vZU1ZR0lPYm9zaE5RNm1EVFdBc3N5WXZnd1d4N09MODJmV1hkbDBL?=
 =?utf-8?B?VEhFZUh4bjNwWTNrWVEwcDdsK2UvTnZCakxZQzBET0U0aUQxTDFXRE1YM1Vq?=
 =?utf-8?B?bmRsdFNoektVejQwZENJK2VtNUhKMFBacC9od3JzcEhMSThTTDJVcXkzUC83?=
 =?utf-8?B?K21xaUY2SzdsYlpZb254aXhlYmc5emY2V0Z4WXNQblJrQ2JSbUVPRG1Ra1FM?=
 =?utf-8?B?bU1UNEIyMmVLNXZwRllGdGxHZnpiS2x2NGVjSTZjRnpzU1ZRSjhJTVRhWmlI?=
 =?utf-8?B?UFFqeEQ1Z2kydGV4TkFxSWlBVXBZSGFqbkEzTmkzOUJiOVU5ZE9FaE43Rk93?=
 =?utf-8?Q?VbSaWAEE4kgPrd8vbw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVh2MlZxd1pwYytCa011M0NDaldIUFVwM1FENjdtZTlDTitUWDRrTzZKWnNx?=
 =?utf-8?B?R3hMdEljQTZlUk9UNE5GSHNJbEh3OVJzZSs5bHhVYVNQZ2JBSE5WTDhEZlJH?=
 =?utf-8?B?QngzOEh5TnZuaGZIRUxBVzlEdnJXQkxheVQvNzJkaDc1MUdQZUV2S2VoTTlF?=
 =?utf-8?B?N0x4ZW43Q3pqL3hsSmY2VS9ISis5ektMVFdoTFIzN2UrR0Z3RFprZXZHYmtV?=
 =?utf-8?B?UDJ0SnZrZUg0Vk1DaGZCV3BETVlwcFB0TVQxWFRCTU13eThmWmNlTWZpdG42?=
 =?utf-8?B?M2JhY1NvMDZDYU5PcmxtYklVWHlEa1FOdnJzRFJpMERscndQVVlBSmdKK2Ja?=
 =?utf-8?B?czE2aDJyMHdVbUV4NVBtUWEzcFAraFlyWTJ6MTlsQmpWdC85cEE0eGh2ZVBh?=
 =?utf-8?B?SjRrUS9iTGh4MTJwWUE4WnRkeWI3RXNZcEdSNW9Ncmt6MG1hU3R4c2JzTTZl?=
 =?utf-8?B?SDVXbEQrZFo5K244UEZCbVlQMENFYTlBaU1Wc1p4b202N2pINTlWa3lnZGVw?=
 =?utf-8?B?amZyS2FaKzM2NjJCdjJMWkNCMVNMWUNvWTNUVjllTVF0Ym8yaVJ3RklacGRU?=
 =?utf-8?B?Y0R4cnZ6eExkaXlzemFYWlNRYnNsV2VxaWJ6YkZ3N01pSXM4M01WOUpsV1Vs?=
 =?utf-8?B?NUt1NU5CVEFCUkNxTEh6bmdTd1FCMTExa3pKdUM4VnVKdWcxbnI2c3BDdC9N?=
 =?utf-8?B?SXh4c1hIK016cmxIL25vSUFjRUJzWERmaC94ZER1bEI0ajY5U05iQjBhWitQ?=
 =?utf-8?B?WDRiUVZIVU1NUzcrc0dma2psQzkrMnFHSTczL3ZneDB5eHZEV005eExON3F3?=
 =?utf-8?B?N0Y4MTFlUnNDcVBLSEtDRGc4NEk2M0hldnV0Z0x4eWRYUGcveFdyVDk2d0VD?=
 =?utf-8?B?R2Z1ZWdhTEdFSE8yYzBBWmc2clRZR1Ird042NkhYa1JTelV4OVcrcjZKQmFk?=
 =?utf-8?B?R3hsMDdibGduRGVTaXZGL3hBaHhIeSs2eDVHbDJuSzY4cmpyVlZBbGNQc0hn?=
 =?utf-8?B?SmFCMGQzSDFkSk1YVW5uUkYzUVFwaVovaXlLMWwrcmw3YXJndjllbmU0OWdU?=
 =?utf-8?B?cDVLT2t5TU9EWmRQYXhlMnp1QzNLMU1oVUJaT2Jwdi9Ob0x0ZUxuSkJrbjdw?=
 =?utf-8?B?U3NOU1VKaVlkeFd4dDhzZm5FVnMvb0JMM0tickg2Um54c1RSNmNHRFJTNXUz?=
 =?utf-8?B?T09vZXNtTCsyR2hEVEx2Z2o5Y0tvK0d4YVA5eTdqeG03Z1E0ZHhSNEc3aCtw?=
 =?utf-8?B?SGlBMUpDM0VHZ0hPUGVLdGxhRmZEcWFjNjcwRmpJVHpGRVllVFhQOG9iM1pK?=
 =?utf-8?B?dWo1UkFScUVkMFVTbCtXUlJlcWdQT3NZVTBHT0Z2RzFIbDFuZ2EwYUZ0Ym1r?=
 =?utf-8?B?OUJRT1pNaXpzYUlOUnFaMDN3OHRGaHFzVUptQkRreitGS05TMk5iNWtGMEsv?=
 =?utf-8?B?QmhEdVhibURiVFZoVGZSUDN0RVJrYVJ0bUVtK3RCa3l1dk03MnpEbklXbzJH?=
 =?utf-8?B?OWlaYkdJdExwTUtqN3pJc3I3N2Yya095dnEzOXA1Nm5udXBKdHNDOWU2Y0lL?=
 =?utf-8?B?SkkrL01EN1A0eGZnc0IvN2thV0RDZXhCRWlZUTR0UytrQWZDM0NKZXRWZ08x?=
 =?utf-8?B?R1FpeFJqRkNPZStZUjg2bmZtWkJIUHkyRkZxZ1MxbU41N3A1Y3hmM2JpUkRi?=
 =?utf-8?B?L3FPN0dnRlBabi9zVzh1QkRvdGF3Tk5GNDRNejBrZjB1T2p4ekZRYWVuUWNn?=
 =?utf-8?Q?QqJ4L7xYKmIl5R9UILSFkbNh2e8Z5uYCFYp8DhO?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-87dd8.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 231c8fe9-cb76-4157-dbfa-08de2c3e5c74
X-MS-Exchange-CrossTenant-AuthSource: GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 16:19:09.1410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P195MB0884

On 11/24/25 00:22, Eric W. Biederman wrote:
> Oleg Nesterov <oleg@redhat.com> writes:
> 
>> Eric,
>>
>> sorry for delay, I am on PTO, didn't read emails this week...
>>
>> On 11/20, Eric W. Biederman wrote:
>>>
>>> Instead of computing the new cred before we pass the point of no
>>> return compute the new cred just before we use it.
>>>
>>> This allows the removal of fs_struct->in_exec and cred_guard_mutex.
>>>
>>> I am not certain why we wanted to compute the cred for the new
>>> executable so early.  Perhaps I missed something but I did not see any
>>> common errors being signaled.   So I don't think we loose anything by
>>> computing the new cred later.
>>>
>>> We gain a lot.
>>
>> Yes. I LIKE your approach after a quick glance. And I swear, I thought about
>> it too ;)
>>
>> But is it correct? I don't know. I'll try to actually read your patch next
>> week (I am on PTO untill the end of November), but I am not sure I can
>> provide a valuable feedback.
>>
>> One "obvious" problem is that, after this patch, the execing process can crash
>> in a case when currently exec() returns an error...
> 
> Yes.
> 
> I have been testing and looking at it, and I have found a few issues,
> and I am trying to see if I can resolve them.
> 
> The good news is that with the advent of AT_EXECVE_CHECK we have a
> really clear API boundary between errors that must be diagnosed
> and errors of happenstance like running out of memory.
> 
> The bad news is that the implementation of AT_EXECVE_CHECK seems to been
> rather hackish especially with respect to security_bprm_creds_for_exec.
> 
> What I am hoping for is to get the 3 causes of errors of brpm->unsafe
> ( LSM_UNSAFE_SHARE, LSM_UNSAFE_PTRACE, and LSM_UNSAFE_NO_NEW_PRIVS )
> handled cleanly outside of the cred_guard_mutex, and simply
> retested when it is time to build the credentials of the new process.
> 
> In practice that should get the same failures modes as we have now
> but it would get SIGSEGV in rare instances where things changed
> during exec.  That feels acceptable.
> 
> 
> 
> I thought of one other approach that might be enough to put the issue to
> bed if cleaning up exec is too much work.  We could have ptrace_attach
> use a trylock and fail when it doesn't succeed.  That would solve the
> worst of the symptoms.
> 
> I think this would be a complete patch:
> 
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 75a84efad40f..5dd2144e5789 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -444,7 +444,7 @@ static int ptrace_attach(struct task_struct *task, long request,
>  	 * SUID, SGID and LSM creds get determined differently
>  	 * under ptrace.
>  	 */
> -	scoped_cond_guard (mutex_intr, return -ERESTARTNOINTR,
> +	scoped_cond_guard (mutex_try, return -EAGAIN,
>  			   &task->signal->cred_guard_mutex) {
>  
>  		scoped_guard (task_lock, task) {

This is very similar to my initial attempt of fixing the problem, as you
can see the test expectaion of the currently failing test in vmattach.c
is that ptrace(PTRACE_ATTACH, pid, 0L, 0L) returns -1 with errno = EAGAIN.

The disadvantage of that approach was, that it is a user-visible API-change,
but also that the debugger does not know when to retry the PTRACE_ATTACH,
in worst case it will go into an endless loop not knowing that a waitpid
and/or PTRACE_CONT is necessary to unblock the traced process.

But The main reason why I preferred the overlapping lifetime of the current
and the new credentials, is that the tracee can escape the PTRACE_ATTACH
if it is very short-lived, and indeed I had to cheat a little to make the
test case function TEST(attach) pass reliably:

The traced process does execlp("sleep", "sleep", "2", NULL);

If it did execlp("true", "true", NULL); like the first test case, it would
have failed randomly, because the debugger could not attach quickly enoguh,
and IMHO the expectaion of the debugger is probably to be able to stop the
new process at the first instruction after the execve.


Bernd.


