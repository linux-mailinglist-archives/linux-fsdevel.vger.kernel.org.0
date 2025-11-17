Return-Path: <linux-fsdevel+bounces-68636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 247BBC62859
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 07:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1044D3600DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 06:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E68231576D;
	Mon, 17 Nov 2025 06:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="hI2/hDHK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazolkn19011033.outbound.protection.outlook.com [52.103.39.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CA71B4257;
	Mon, 17 Nov 2025 06:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.39.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763361078; cv=fail; b=STkh0NodZpB1Q54kvALFVpftgEoHBPJ1tAF5s1ZSzNl8+TAISf9hfjUyHcweehYOOMUR2Y6cGfVBDvW6I2PiQ5Dl4/RWxNX/+E9lQinmAiADDYHXE5MvvHTxo72bebYy0bmYknBcfBzohYvg3/R9UrHO1Ejo/gHsggJlpuzIAGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763361078; c=relaxed/simple;
	bh=gcCpqyNEYJKG5rKf2McGnRSWGL9sZsz/AkWZR4jdd6A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aM5LM1VriCw7I4BAtHCkAgxn9zzGQLgtdnvcjLcRU0pMcTLFx8qkEZSim7wfdt8fmpLQnSOODyNBN3+SOZ0/KM5bSfC2BDbCGwMLeS3q7CLONfBAnu/kjib0he93wwXzhFaduRMAYnkhabcVcNTyLovK1H/qzj707ixaDi9Swdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=hI2/hDHK; arc=fail smtp.client-ip=52.103.39.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/QAEUjioH+/EvcuUvRXf1DCVL7gk5cpckTWkNC3BK7Iq6roEZwhNVIcFgUCtfA7SCXGkHcMURTrwIftBXYKoLRF+3YaTY8T++Ir97mgFjM2ug/gAoEJnSKu/tjrFjVEgO41hNILJa17+ZXVpNL3T0dfn4LahKK2g4ld0LthdGTfsW8BPvoRzZUmwPiIX8iJxLVFspCnIc+Zyf7+NdX3sdqhsf6QvXuLEKXodtqX51Kiw2GAgwnUkJoTgh4D0iF6Fcoc2AgeABHIjlRot0tsiVQfS1moEXOQ3vfYVlCeAWGtIuHXnKZ4C/XXEgX2xjKSoRuA/F12Y1YnRgJYLSGqTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GILaEO4Zbmg4SMuEfg+2dAClAD5v53IwVJ5Gi8LwMdY=;
 b=iwEaA5C8ZEUFwj/EWNT3c5lvHuvtvjjKqMGg2HhU5jGUQbeWnO58JB/CM9D7YWzo7D0SVukyTc5ag2D8Fl6bHIpezDdJ4qG/JzAgYBljl0UVFJzzAZW5oMopsQfXviGhZhRuMz0qVUGU7pPN1u6h7rNSEvL9nXTmTpiyOY9k558aBTyriRJc9ZCdAsazR6UA1JenrTPvetTZ7xf7IqwStCxnotu9PoWlehJDx2Lo38majUogvRseROb1F7Q2DE3KO6eZvk8yczYNQfzgki1FBkYk3abnabZqCawvhKs5+LEjmC2p7P4VjXuTYp0AQs/Wb11gYQ6rW+BJ4ie3FxeE1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GILaEO4Zbmg4SMuEfg+2dAClAD5v53IwVJ5Gi8LwMdY=;
 b=hI2/hDHKBqFdR0KDasoFEfnMETF3tK4uBZ/A0biy875N7xXMVVWmomqlLg3whXnKl8tPaesEYauxzMioeheYfObaNdZ5BCwqouBerREZAR6KIiTeNyD2qHPVKWuJJ/frwXz+Xj1H3ZHl84y7QwHRHYlIkCtIrU+NERXZRW665XNGZk/SXIR0ABgyopaUbI4OK6S7lmN5UWjNyl4i6QqXyXCHt3hePWXtZyNzo/dqneec7SwhwTnll7K2St0oxoGIEUfcYa5U//gbDW9cgKSkLffmYxN0bq0ehQRBGtpgmCSpZupvI6TuRy9lnHH4HaaQKnPKBnIdinDelNMiizabjA==
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4) by VI0P195MB3083.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:2d7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Mon, 17 Nov
 2025 06:31:12 +0000
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::dde:411d:b5f2:49]) by GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::dde:411d:b5f2:49%8]) with mapi id 15.20.9320.018; Mon, 17 Nov 2025
 06:31:12 +0000
Message-ID:
 <GV2PPF74270EBEE4FE6E639B899D01D8870E4C9A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Date: Mon, 17 Nov 2025 07:31:06 +0100
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
X-ClientProxiedBy: FR4P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::14) To GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4)
X-Microsoft-Original-Message-ID:
 <c6b80b7d-9efc-4d81-98b6-d7ab716ca2ed@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPF74270EBEE:EE_|VI0P195MB3083:EE_
X-MS-Office365-Filtering-Correlation-Id: 254bf897-bd44-4b4d-43aa-08de25a2e6bd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999013|15080799012|19110799012|461199028|23021999003|51005399006|8060799015|41001999006|5072599009|6090799003|40105399003|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGNVaTJzazZ1TUJkcTZ1ejUycVNucUp6N2dORDU0L0QvdUJwZ1YvODRzSjFG?=
 =?utf-8?B?RjhjdkQxUGFCRjhVSkFvUThVQkg1OXd4VlJQd1dMQThhVE5ETGNlbnBUWEVv?=
 =?utf-8?B?NlpsUVVEMHFaMFdOeGJnWlE2VFZXTkJNNThZWXNSYkthSVYvc3VJS3h3OVVL?=
 =?utf-8?B?emkzV0F3VWhXc0FUaGx5VTFQOC9vQkowSkhtUVhsTkFxRU13ZVB1dmdlL0pH?=
 =?utf-8?B?aG1pTktXZmhTajBCcjNYeEtZSEhiS2hETjJ5WmNEOFE4ckpuaGVBRmpRMXk3?=
 =?utf-8?B?eEF4b3gzQWFjSmhXY1B3NHQ0WXNUUWNLTFBUOENyS0ozbi9SelJuYzZvQWZx?=
 =?utf-8?B?cVRWWGliZDRGRFZlV1poeGdHeWU4MFJEVXNmTVN2ZmpzTVZja3ZnTWVPNzBU?=
 =?utf-8?B?dWt4VXhUeW54Q2NiTXdBN250cGlrTm80YnNoNi9aZXRjZWZJcUpaWkdpWWUr?=
 =?utf-8?B?VlorRU9JamozWVVvYzVSbWcvZzJPYVl2UitNQzk2T2JUV1h3OFc5c1AyZmtZ?=
 =?utf-8?B?RUswbW5VZHZQNTJDODRZSG5wV3FqVkt4aUpyc0xrYlVJOEJjWGhhemtwTUty?=
 =?utf-8?B?VjhhZVNGTG91dkJnb2ZVRTRZemJNNlNTWGhFNFdjWWUraEdrcFRmdlpqNm41?=
 =?utf-8?B?KzI3aVg2eEpPYitreURGaHlxeG5hZ1lvR3UwOGVZeE9qU0U1dStYZGdXUmJz?=
 =?utf-8?B?YnpNbm94WmFHTzc2STU3SFZOTGFYVVY3ZkRleHV3UytkYVlIQjZtNUNkUFhu?=
 =?utf-8?B?NnpoSDFoK0ZjeXpnazYwR0FCcDBzMk5Gc0ZnMWhLTEs5S2YrRHp5b3FqVHZk?=
 =?utf-8?B?bVB3ZzN6cVNRQjFhaXpFTmFicWFuQVNnNU1WOGVVcFIwYThhNjV3WXR6SG14?=
 =?utf-8?B?WTRBbXphQmJVV25YVnZKYVU2Y1R1dm1LSDJ5SHZlUXl4RDFuQmxJbmRDUWxV?=
 =?utf-8?B?aVdrT2pMSFlJT0JUU0g4dkttcWE3Zk5BY2thZWNiM1VWRFE2MDBKSlp3UGh3?=
 =?utf-8?B?UUVGY0w5anQzcEZmdjI4RXZOZmRjb2F4Qjdybm14R0pZNWloWXZJc3BYOVYr?=
 =?utf-8?B?dXBLaUpsckhXZjBEVnFwZDZRdGJHdXhpcnArcVpvNnptUUdSaGhvem94NExJ?=
 =?utf-8?B?djlwRFNiWnpVSlBhdW8vSHJKeUVxVWwrL3pnOFEwSzJCeUYrbWsvN1IxaTg1?=
 =?utf-8?B?Y0V3bC8rTkRCRUd6OEZIRmsvN3MyZ2FuYWZZd3V0MFlHUGdEVG83TUtKNkJQ?=
 =?utf-8?B?V0lhTnZyaEEzL2NxNkp4ZjMrMUdOd3hzbUNuNlJyOVByd2QrQzhadjEyQytm?=
 =?utf-8?B?V0dCU05UbWpTUUhGUmJ2YW5QT1pYeG5SVnFPdjBHNmpKZFZUTm5zL014ZmxF?=
 =?utf-8?B?MUFnRFJJSUJjRVdlVmo0dlZZNzNPOVlHU2hlNWhRRWRaeXRrbFBFN2xIbjF2?=
 =?utf-8?B?T1VJakI0QzRFNUlLcVFtUGRBV3hnOFoxYmkrUmFNY1huZlppV01LNHgrQlpL?=
 =?utf-8?B?NXE0TzNMZzFYOTFNMVpCR2NhSkNLQ0pLRGRib3BuSTZoc1JLSzMrMWtXb2Nt?=
 =?utf-8?B?R2JoaE81NXdXdURWdGNYRUZEaW4ySjhNZEUzL3M1aDZZejhUTzlZUTZad1ZQ?=
 =?utf-8?B?MkNLZzhNREx6Q0R1bG5oa2JQZk8rUnpjaDIwOGFIRUdpUVhDRHAyaVB0bTdL?=
 =?utf-8?B?SjhEZVUyUURTVEtFTGJxUURxTVJobjRDekt3dUJHM1N1cnlKOURqUk9VNmR1?=
 =?utf-8?Q?OV4tYGSYFwnIYrBOUokWtKHUig1HhlCE62fE7GL?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXc1QWdIbVg3bUJSZTJzWGVHQlF2RnFPamNMT3J3Ui9oaHZ4Y2E1VDRUcUZs?=
 =?utf-8?B?alB0ZWVkbjFsdEpDV2ZkUTU1NTdiZ1JTTHpic0dRckxTY0Y5a1NrbEFBRm5W?=
 =?utf-8?B?ZlAwbWw3L1ExNzdBNERZVU84cU16a2gyWkR1S1ZRZzJ3MXRvMG1lTFd3U3hR?=
 =?utf-8?B?S0grbFQ3L1Zqd0tUMjFCQlM5ZEZDVDBGcll6Z0VXSGRYRGgzYVU0bTRPT0Ix?=
 =?utf-8?B?ZFdKQ1lqcUI5ZGNIWEZMU3F0YUVZaXNiNDFWQ0pqVkJWSTN4NG5kWiswSE05?=
 =?utf-8?B?UlZ1eTMraDhMQ2thdGxGazdPZmxGbExTTTJuaWhJTnpReDUrUTQrcVRPOTk0?=
 =?utf-8?B?MDhNZlJRVUVhWVJaZi80RkVpUTFiWThYTU5TL0JKOXZLc0txWm5aZUxrQlFW?=
 =?utf-8?B?eU1ub0wyNmJEaWI4UUdjN0IrVjJYZDE0QXlVMElpZkxzK0hJS2VwVU5TMTFR?=
 =?utf-8?B?YWY5czlXZk96TnVDQkFNcm5vL1RjNUx6YUxlY1JqaGZtZTNSQ01oZTlEcitI?=
 =?utf-8?B?NkdkSC9VQ2ZseDZ4VGtiODJ6Y0dpSjBIUjk1R0xCemhQMDFUbi9RcXhzN25t?=
 =?utf-8?B?RUlxNm02NHhUSnI3SVc4WnA5VzZrM2pGZ2xsQVNFaVFhMHpiVTZqeWlSZ2t2?=
 =?utf-8?B?SEk0YXVUa25pMGVnK3EwVjFHVDNIcSs1YjQwSGh0SnlpZnhIZGRaRVZyVlUw?=
 =?utf-8?B?bkZ5cjNYcGx3ZGxQT0syamw3b2JrQ2NGd293NysvUWIrYUNyWWdQcDJ5dnNq?=
 =?utf-8?B?aXlnaUV3UnRaeUVSdTVvcmp6TGFYR3I4SlE5VHpYVGlYMERHUk9od0dKc2tZ?=
 =?utf-8?B?WTBxUEdDNzViRERzMjFsS3RsN2M3REFxWVVoek5IOWsrdFRhcmtYUVYvL1cz?=
 =?utf-8?B?ZjJsUGFPZG1ZZStKMHV6Y3VoZ1I4bUZMU2U1ZHgvL0x0Z1Z6MVNvaGdla1Fn?=
 =?utf-8?B?dVU4amJiMUx2TkZ2YzVRVTV1VXJXVVNCR010VEY1eWtqYjlMR29KZHpaSUtU?=
 =?utf-8?B?Q1d2aUV1SWRzRXF2UkhqNGdBZkNub3pwWGdkbisxajBVL2hSeTFTL29DcHBw?=
 =?utf-8?B?OFM5RE8xTDVXQnZWNGZDdmx0OWJoMDREMjljYi8vaGNTLzRySEg3MVplR0Ju?=
 =?utf-8?B?aWoyU0xJQ0NkNHRxTU9PKytCV3Q5ZVRHV1BjOWU4MjF2OEtGUzJIZ25LQTVZ?=
 =?utf-8?B?dkdQNWNScEorZVh1Mk9jZXJOTWlYTkNueHhVZkxvdFh0eDRoMFVWYUh1dDJP?=
 =?utf-8?B?c3FqY29MalhlNy9QbXZnVFpkZTIxL1prdVBwZE1qTGRqQ1BDcy9Ra2Jrd1VP?=
 =?utf-8?B?alo1bWxwRkViUHFZdUlyd3l2bmZvTi95d3R1RjVaRjYxMzNEUnNWUHBHQzBI?=
 =?utf-8?B?Sm1uN2UxTTFYc1ZRaEgwaDU5cmVpWjd3M2FNUEp6RkYyQVkzMDVPS3dNczdX?=
 =?utf-8?B?OUVoWVlKcmJnZytIVUs5aUZIcjQ3eFl1UzRsVlI2WDFYNEJha1FiNnI0SGRh?=
 =?utf-8?B?TnJnazBLRG5QR1pmWkZZbFZIbXNGdldsWHUyVEtpNWRSZkljcFBxRVBwTi9U?=
 =?utf-8?B?VFdGSXNLZDIwN2ZUU2ZCRTBVM3cyY1ljSnFsdVkwT1k3YlV4c0hGSDRqMjI2?=
 =?utf-8?B?clAvSk5JbFIzUVpEL2dBQW1HRnVnZzRIcGpQbFFIV01zeEdUdEJRWkdqalFj?=
 =?utf-8?B?QlhhK2NjbUhzQ2Jmb3crNUVKK3duTFA5R0hkL3F3Zit6RkxGZkMyYkIwNUp6?=
 =?utf-8?Q?wPCT5r0N07H7KjVEZBJ1pe7ie/oQ0Z0Kh7aNY7b?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-87dd8.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 254bf897-bd44-4b4d-43aa-08de25a2e6bd
X-MS-Exchange-CrossTenant-AuthSource: GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 06:31:12.3732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P195MB3083

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

ok.

>> But this is minor. Why do we need "bool unsafe_execve_in_progress" ?
>> If this patch is correct, de_thread() can drop/reacquire cred_guard_mutex
>> unconditionally.
>>

I would not like to drop the mutex when no absolutely necessary for performance reasons.
But I can at least try out if something crashes immedately if that is always done.

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

Since the spin lock was acquired while holding the mutex, both should be
unlocked in reverse sequence and the spin lock re-acquired after releasing
the mutex.
I'd expect the scheduler to do a task switch after the cred_guard_mutex is
unlocked, at least in the RT-linux variant, while the spin lock is not yet
unlocked.

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

The dumpability need to be determined before de_thread, because ptrace_may_access
needs this information to determine if the tracer is allowed to ptrace. That is
part of the core of the patch, it would not work without that.
I will add more comments to make that more easy to understand. 

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

Some use mutex_lock_interruptible and some use mutex_lock_killable here,
so it wont work for all of them.  I would not consider this a new kind
of dead-lock free mutex, but just an open-coded state machine, handling
the state that the tasks have whild de_thread is running.

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

Okay I understand your point.
I did this originally just to avoid to have to change the interface to all
the security engines, but instead I could add a flag PTRACE_MODE_BPRMCREDS to
the ptrace_may_access which must be handled in all security engines, to use
child->signal->exec_bprm->creds instead of __task_cred(child).

>>
>> Say, current_is_single_threaded() called by another CLONE_VM process can
>> miss group_exec_task and falsely return true. Probably not that bad, in
>> this case old_mm should go away soon, but still...
>>

Oh, that's nice, I was not aware of that one.
Access to current are not a problem, since the task is trapped in de_thread,
however by code review I found also other places where task credentials are
checked and then used without holdning any lock, e.g. in rdtgroup_task_write_permission
and in quite similar code in __cgroup1_procs_write, I dont know if that is a
security problem.

>> And I don't know if this can fool the users of task_cred_xxx/__task_cred
>> somehow.
>>
>> Or. check_unsafe_exec() sets LSM_UNSAFE_PTRACE if ptrace. Is it safe to
>> ptrace the execing task after that? I have no idea what the security hooks
>> can do...

That means the tracee is already ptraced before the execve, and SUID-bits
do not work as usual, and are more or less ignored.  But in this patch
the tracee is not yet ptraced.  Only some sibling threads.  But they will
either be zapped and go away or the tracer wants to attach to the main thread,
and in that case the tracer is only able to ptrace the main thread if he has
also access permissions for the credentials that are in effect after the execve
completes.

>>
>> Again, can't review this part.
>>
>> Oleg.
>>

Thanks
Bernd.


