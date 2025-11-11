Return-Path: <linux-fsdevel+bounces-67933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2852EC4E397
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 14:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031BC3AD89A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 13:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C52342534;
	Tue, 11 Nov 2025 13:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="knHjsv1S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn19013015.outbound.protection.outlook.com [52.103.33.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353602FB0AE;
	Tue, 11 Nov 2025 13:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868760; cv=fail; b=oB4QCuwORkzuGtwj3oK6vsaGl7lIo1FHTEskIaEi2u1UjKTBLE49bNoooQ9wCDWFVgDz0Xen5+iaG/AHj8WDnB4nlxpk2Jkmq5w0774vePwvqL54PGmrCFsQbzjnJ8Id8CksowgFTgledFufUpQkn3mGL6XBvJX8VrqywNC7psU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868760; c=relaxed/simple;
	bh=6BOkoDiNKouO9TBuOxBpGQ/uk9kTURZP9mCWioXPaRE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j4aW4/Lor9sM2yPc91VidLca3za5JOsRPCVNZpFBUux7r9LwgJ1a1KUFaZNA32Ah9dZm+zLnCP+Mu314HU8Q2e63YlYpP0ATxi0tSYcXqODAbX2A8rjq6oIfftAnmH0ewDVQDcdeOAedh8dR7SOw8TL8RtDr8Lrqc33toFKlNiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=knHjsv1S; arc=fail smtp.client-ip=52.103.33.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGQHao4d2HwRuiQULDXA5EbYI7gztscIySaJAPbjK2JnbDX2wS831+9jxVmBGTKvtW1Ncva2/8GCUorgAL9gp/h9buNztQvz2TNFNn/ldxrS4qZgAi4rqky6+SGDo1ceKGWL6eWyOu5JscmsOmD4B/++EAEQSWNFXdkyfKdXEsplJxSm9hbwHPQ4L+fzad1hu47NHPw7KH8GvYQrzS1JPUsQuuvze5bBaL5Lb4U3SeaIIUOBJPJARRZ8gnU67jSk2MMBGZ1JvhUVdMfK/10fiTqzk4nqNcNIJCGhTmKuV1gEJH8x51khvhqtgv9q0qh8oymokKGHDowCoQ3o4mJ4Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuwSnVGEkz1g41aMKQg/7O/O5yTefEOJ8q0x9JiRM1w=;
 b=n4funlopkvQxyTeZDoUde2fazL3gKUjEYi3S69gfCfBnhNhkrIAa3M9LicqSn7+qtw+rT9k1gUUtV5YqpPtB9+oRLTdqxQvm2nZD+tXMuNSupQaoQA2gp/y+M5WBTbsJ3/K9/0QVe9cD0h4IrFMbE88f27fN2jVO3kKoEwmVv328DFkrEznHbPjBO/d+Un+LV+fsJHnvZ53kmNlf/9R6OYDuA4YJorWPxnABYcRia9fiaXQBXylXv36d+6E8Do4S/jbiikRIiJd/0yWolxWS6RBDylC41KWeXsvKcAKH7V2cQle8ICdXvejnZS40Ht5sZ2MUZWkgDon9oG8XTzx05Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuwSnVGEkz1g41aMKQg/7O/O5yTefEOJ8q0x9JiRM1w=;
 b=knHjsv1Sce0P3QvKzaGKQpc0GSleHx0FGpfxtiXO8KcbGRY+9tbqQQTtt11p+QTGjjkLcuq+5qI1Rx6WSDS/36Pk8Fs05f/P9Z5SyjD0HHV9UBdpNIBZgr4PpjrSZaQOaTLgUHlzO9TIBw7sk43s1llsMrWPrXp13namU4Kc1+j0kyqXUOWe3a3pliDL0Pw/+9AtLxK/LK6OowKcSUHD8gRaGINXV27PbBBkoveHgQnW+7ZQjiKZTImcua7ZVkxTZGLBwqH8dt8GynfEz3jYESSFDfDU7RDyuH3giDyvI+j5V9rLfP5KGTrBKq45SngK+L5LRg34XyJjlaqPPL9AxA==
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4) by DB8P195MB0551.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:15a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 13:45:54 +0000
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::dde:411d:b5f2:49]) by GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::dde:411d:b5f2:49%8]) with mapi id 15.20.9298.007; Tue, 11 Nov 2025
 13:45:54 +0000
Message-ID:
 <GV2PPF74270EBEE16FE36CF873C5C2309A9E4CFA@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Date: Tue, 11 Nov 2025 14:45:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17] exec: Fix dead-lock in de_thread with ptrace_attach
Content-Language: en-US
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
 <GV2PPF74270EBEEDCF80CEE0F08891ED37BE4CFA@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <aRM2POTDTxEzeF2F@redhat.com>
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
In-Reply-To: <aRM2POTDTxEzeF2F@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0361.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::17) To GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4)
X-Microsoft-Original-Message-ID:
 <c10c17c7-b22a-4b1d-b1d7-02579c8f49a1@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPF74270EBEE:EE_|DB8P195MB0551:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a940342-c76a-4808-9571-08de2128a272
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|461199028|5072599009|19110799012|51005399006|8060799015|23021999003|15080799012|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1ZKaDFTMHoxMXZEQzI2aElweUhoUWhJb0N0eEJxSWljUHBnNWVQc08vQ2dS?=
 =?utf-8?B?RStkd3JMODNxSE9TM0lDa1dacUR5cWs1ajlmSnNJTzAvSnkrbitQaUFwb1Js?=
 =?utf-8?B?YXBHSDBoWlMrQ2VBR0hPQ0tscURrNTF4SVo3SlhvRUpZeFN6ZEdQcVFMV1Jl?=
 =?utf-8?B?a0V4V3FNNTVHRksyN2JtbW1BZjFRK05wTnlQNU51Vy9NL0ZZM3k2T1Frdnd3?=
 =?utf-8?B?dGhFVU5VSGtDdmFGME96bjhhU05Nd0ZhVXM4WnFqRU9hbXpGeTluNU5vdElp?=
 =?utf-8?B?UkJ5ZHArNm14OE81WllGMTFXUDdjYmlLZTUranlGd1NmbzRoLzVDeUpnY2hI?=
 =?utf-8?B?VGFQa3IzcDdsT0U0VlAxSTlYQW51ZGN1aTlwZUthR0tUMnluSU5MRkNSMCsx?=
 =?utf-8?B?R2lud0JhMTArczY4MVlIZXRMdkMrRVFybTZ1WWxJLzYzTWdBa1FiZzdBekpy?=
 =?utf-8?B?dzFzdXp0dEdJTU50ZVVaYldKNVErWnpxbk5kdDZxVW1VWTJYMWpMbkxOSi9x?=
 =?utf-8?B?UmV2czllZTZ6N0tzemU2MzhRSzc4aVNBZ0VTOXI5Kzc0a1JMV042aWNMZHll?=
 =?utf-8?B?WFZZWDlPUSs3eUhNRytheTd5eFhFMURkZVRFTTVVcGJlc2RGTHlUK1VHT3F3?=
 =?utf-8?B?WENaK0VodklEK0xnQjRRT1JxZUlEbTB6OTVYUDJDM051b1RDakNqTSt6d255?=
 =?utf-8?B?OFJKN2tWN0NJbmdqc2dZL1lCTHIvTE00ZUt6YkNoUWVLYWdqcjFCaXJ0QUox?=
 =?utf-8?B?aFBhZUlKbmE4Nkp3MDlLMHFMOXI1OVZUYkhHSWo5eWFTcGtESnZjL01maGJ5?=
 =?utf-8?B?YXdTQk5qVXVDaldGT1NJc0E3VkkyNERlSDErK1h6OVl4ODVPcUQ5djBSWGNl?=
 =?utf-8?B?eE1lVzhmYzl2emh3MjJaM2VLNGE1SnhSKzJzYnRPMUx3Yk1GMXUwQmw3TzJ3?=
 =?utf-8?B?K2pMY281YThIeFBSQXZxZTRra3NoTDdWMUlhMFgxNGNxRTdxWHVNenBvSFlO?=
 =?utf-8?B?ekxKZEp1eFpMaW81dFZ1MXp5MXpaeHQ4WGNScVpkUkZiNGl0bEcrMEhHNjg0?=
 =?utf-8?B?MkFZaUVGdU9hcFRqTmxCWGs1WWZvcFJmdGhFaCtXWWlpZk9ZMkRkU0xFOFor?=
 =?utf-8?B?N3dPQTAzUGkzcXBxSUkzZ3lmdTZjSnFQWEs3ZE5kbkNFSmorRHhjMDljU2lD?=
 =?utf-8?B?UjluV2hnWUs3V0lOVVlqUWIyYTVsZWczbDVWSW84ZFpIYXBtYSsxbFJiekxV?=
 =?utf-8?B?SUU2U1l6bWRzYkl1K25rZ3ZnVi9GeGlIY2hNZGhhYkdEQm9aQkpBTHZtRmQv?=
 =?utf-8?B?NSt5MkE1aklyNnZ1NzdKVkFxTzdtOTR5Z3ZJSEp2SUIwUkxUUE5pblpqZlp4?=
 =?utf-8?B?S28yYWpoWmZuNk4xQXlpNXhQOUVPaTVSVE40Z3haTHplei8wc3ZZVzhzbm1V?=
 =?utf-8?B?U3RiNjREM2lJZnI5M1NFUVZxV3JKWEdXNG9WdW5NTW1xT3huRk1qUU9iWWpT?=
 =?utf-8?B?anpRM1EyOTI3aUVCbkF2YktKTUt0aG1RZVYvZGFidnpWZ09SQy9ZRUw2Q1V4?=
 =?utf-8?B?a0lEMiszeU9lYWJwblFCNlpuSlNncFUxWjJBYkI1S2R0c0laTWcvcXRpSjYr?=
 =?utf-8?B?R2xKQVhEbmZucGVTb0ZjK05VYU85U2c9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDNpU3V6VnZmeFBNN2tCcml6c2JrWE5EY3JMVzY1KzhuNXVFUUt6T1R6K2Uv?=
 =?utf-8?B?d29VZnJOOVRaazNqOFlIS0FMcE13MFV1WmRBVVlSUGphbGFSYWtpU3B0N1J2?=
 =?utf-8?B?OHRzTEI0ai9tM3F4blgrMnpzeUptTHp0c3FlN1d6bnJtaGs0b3VTVVdLSGt2?=
 =?utf-8?B?YUJpZUJwYWFxVEU3VnJjTS9CSVdFWmV5TUJMdkZVZWtRRWJjVE1zZ1huTmt1?=
 =?utf-8?B?QitObzhiaUxIdll5TlNtSjRlaWNLY1BtbWNPNm12SnRXcXBsbjROaU5pL1Q4?=
 =?utf-8?B?RDgrL3FlQnBOL3MraFkweUJZWEJLQWhhVlppZStNN3VXbWI4bFNteXBNTTZ4?=
 =?utf-8?B?RTVnc3BLUDdodktwWE5USHpoaCtHZkVVZ2VnaElIVGhrSDdqeG9TVzdOOURh?=
 =?utf-8?B?ZzRvWkdNa0ZmcjFhMUd0dnlHRDc2SS9jZUVkSE5HSVhOdGJSek5EdGFzSU5x?=
 =?utf-8?B?YXVFekQ0N3dJdm5ZM0QvM0NSYlJTZmNmYlVNNldIMy9RWlNyZlVRRm9LSmFj?=
 =?utf-8?B?NDVWVENuOXRqbkw3Nk5QTFMwS2FVSGdpeWMxQ0FkSlQ0VkhPNmYxUHBpM1pu?=
 =?utf-8?B?N1JUekF1SS8yMGMwb1RxL2xmeTNBNFJ0c04xMnZvUjBHa2l6UVdaQ0MzTkh4?=
 =?utf-8?B?Q0ZJS2J1Q2FlQllpdTRndUUrclpkWU5hT3pNYWJMT3NOd3NpZis3RVlKNUh5?=
 =?utf-8?B?Z1FROE4rQUhKMXNYVU5qVWRvOHBWSlYyTGtaQjMzbU9FM0VPZmtDMkpTSS9r?=
 =?utf-8?B?eEM4SjF1VVFPQkpncXl0OEFiRWNQU2ZXK2J2Y1k3b2NQUFp5SnZYanBaemhK?=
 =?utf-8?B?RjVSSzFsRDMvVHMvMENSM1dRZlVRWENFSzBSUXI5ZGJXalEybTNVb1Y4Wndp?=
 =?utf-8?B?a1FLeTdmcERSSkdZR1kyWSszWndTa2FyU0llV0p4Y0NPa2l5MytqR2NEaWtx?=
 =?utf-8?B?Mi9MSkExbTFzcWs1NWxuMUJTc096dEtoUzdmMjE4MG1QMWg2clp6OFdaMTBD?=
 =?utf-8?B?YnJCbFE4RVQrR1N5V0g4Zm9ueGh1MGVmR3dmRzVObGV3bksyYlE0VGpWNGYx?=
 =?utf-8?B?RmlMeGdQRDVCNEN0T3NSYTdxOC91QWw0WTZYT25xZ2VDRnM0Y0tTSHB0aXFM?=
 =?utf-8?B?YkZiRDhSYmlIckxwajVidUlIaHFaQktnRCtCZkFuMXpOeWp0UkttV2tWRmwz?=
 =?utf-8?B?QjlocmhNK2Y4eDJybGF6aVp3VDFYdGRuTjhnQXcrZG9URm9HRFYyZ0pzZ0pL?=
 =?utf-8?B?eDJJSk1idWhJa1pXalAyYktaY2NHSnhDRFd2ajZrSklpYmM4NjZnbmxBMmZv?=
 =?utf-8?B?K0lRQ3hycGZZTDBmdG5VNFVVa2NIWFVIQXBkT0NJU3JTa2JOSGpNS2ZaT0FL?=
 =?utf-8?B?eGxWVllBbEE4c3huaVZKYlBieGFmZnJQWWlIemt4a1BOOXJsdjE5N3Z5TUhE?=
 =?utf-8?B?ZmVNalFUV1hOQ3IwV0NweUFhRmJnT2duUStzUXViNElJczVxbDNVR2crcFRs?=
 =?utf-8?B?SFltY3p5Rm1TS2JOR0ZVbzVCVDgyYlYwTitobFc3dy9vV2UweE5vS3psUXNO?=
 =?utf-8?B?S0g5WEsvc3B0dmFrRkxPUGFNQWh2bTNKNSthVVRkblVzZzdBaVhtQjVWMVNC?=
 =?utf-8?B?bGthQmdoRWRNNW5UOFkzRnhtVGhPeDYwM1N5UlczdGVWb3pSbEZkVm5FT1RD?=
 =?utf-8?B?emhlUFA3SmN6T3VqNk83Y0xEMVplTCtiK0RReUR6UzduVUk5MTllME56MWVE?=
 =?utf-8?Q?HGCR/DMwb2ksjIwMY7tQ4JWtA8lV8S0boTHLFdu?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-87dd8.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a940342-c76a-4808-9571-08de2128a272
X-MS-Exchange-CrossTenant-AuthSource: GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 13:45:54.4898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0551

On 11/11/25 14:12, Oleg Nesterov wrote:
> On 11/11, Bernd Edlinger wrote:
>>
>> On 11/11/25 10:21, Christian Brauner wrote:
>>> On Wed, Nov 05, 2025 at 03:32:10PM +0100, Oleg Nesterov wrote:
>>>>
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
>> Well when this is absolutely not acceptable then I would have to change
>> all security engines to be aware of the current and the new credentials.
> 
> Hmm... even if we find another way to avoid the deadlock? Say, the patches
> I sent...
> 

Maybe, but it looks almost too simple ;-)

   164          sleep(2);
   165          /* deadlock may happen here */
   166          k = ptrace(PTRACE_ATTACH, thread2_tid, 0L, 0L);

what happens if you change the test expectation here, that the
ptrace may fail instead of succeed?

What signals does the debugger receive after that point?
Is the debugger notified that the debugged process continues,
has the same PID, and is no longer ptraced?

Thanks
Bernd.

> Oleg.
> 


