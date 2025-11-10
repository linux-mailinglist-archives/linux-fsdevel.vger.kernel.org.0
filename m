Return-Path: <linux-fsdevel+bounces-67633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5854CC45056
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 06:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 000AD188B76D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 05:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C192E8B95;
	Mon, 10 Nov 2025 05:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="OqbRImdC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazolkn19013077.outbound.protection.outlook.com [52.103.35.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76394214812;
	Mon, 10 Nov 2025 05:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762752550; cv=fail; b=GPjEBMjbrpZzlBi3lL1oekTJ859QaCUqWkhgbHFYLEYWAMrzPPpVGs/ZhqGJwmhh5MbzMgmSmEg5DdVuMwbZBlNtZpFZQZ4OrzvupK2naQmgJb/WOKdH9R52dcMHkWon0y/7uN0ejum1UBhli+JQ9VjMRZF5/g/PvZSwGiphmD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762752550; c=relaxed/simple;
	bh=0WFiAo6tYa4d2dj8YabouSC6I1xH7RveFIUhsnWTWbQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=doROJsnKgQcOHOtTlxrexRuakqBz/3UH8QvLHySRKp8iq6tDFB1p2ByjS3JuFMNXYyRuSHSeuEMUMLh7nIo0MYpRLBmcUiL2NkTBx3zUy+22H4ERbh7lt4mhfWT7yGlGoWj8/90Pp/3WSw0R45qXJDhtBGb9VtfJrf9CqlMHNL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=OqbRImdC; arc=fail smtp.client-ip=52.103.35.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIGDNmSeChSXbCoTZcAVFGocJDK/sDK29MpTuX3+AJP/6yBGbtkLV+HLnrUYwtO1Aj1/jIxneehEzidxl5X7a0y8pmnzy3URnG3AtQ9Zrh9ATaFWPoDNwWrAviLFAIif9zVKIH8hSoGFOoAEB7stv/3HO2YDIfl4m/cmwBexPZHcCHRdqaUYo5gCr0EohqbkCXPLSKjl4hc+xFzb6Ge6E7FM2SNNK6nCeSWmhuQf4JHYMfpfztZmtxg8J6IxQ8J3Kh/Qyoy3516/xFCArkeKB0UIfa2SF9Gkx2ZbaPQCKkbzknb180Sk8I57f+cJJY4z5Qw0JhgqaMQxw3ZXDKWPrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgt5O5YM/pDRI3HvbsMbFVab0yslO4k2WP1tlqDqj0A=;
 b=OJaPXANvIysx0LNr7nlgFrm6IZ8at+P2PxH5EroPNqAuf/eFLwyg+6/tyoUW4bAHGoouj9F8vlS9lkupDPLb8AB+Ml4bl+dTXMhvX4mhS3f0+xmafKpIGDMZd1/GDHHskA/QZk94TRNYTpF598c3MqUt3j3EPUG+QPUK0gh3KgHp3aLhetfUYh2KFaZTeycJWqKoxuNQYmvc8zBdMlXeHEyMOORDdnuG+5/yUB9b5+2CkKxrd5Fj0HnvUWzXwS45Nn0zGuR+enuZxbybndN4cTcvV0fnlmHFIFeU3rmqDzywC6BV9t+pVLsI6YyhqwyLcnhS8Yx1VzaBCVeZxYrSbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgt5O5YM/pDRI3HvbsMbFVab0yslO4k2WP1tlqDqj0A=;
 b=OqbRImdCkL2ubvRg603M4G0hMyjT69dfbNTDHlKTjnIDbIIsgAVcsFtde5YI1DaeC0xIVrjD0GqpmAeD6Fqw+GcTVb0CcEOHl0xysz6/huNnIisin0iAmwyCeiL8m8wkcfj7478FC8h5sUkaGakM/w3Vl6lTpC/csAe8LiR9ododc59V0djE+3DwDKCWILXJmLWUgGiMkPvMZEcXiYUvAZdYBnQd8/HpSK43o1FXuz1afBsHSVRSGvQKNyUAsgOytbxaxAkdJLJyf8tsoPLEdqW9feYRZZ7eDxAOCcotTwW8oW2z4dkt8STJSdMcmmI1YLxJg5g2nlpnUBJPRkFpkw==
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4) by PR3P195MB0665.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:3d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 05:29:04 +0000
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::dde:411d:b5f2:49]) by GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::dde:411d:b5f2:49%8]) with mapi id 15.20.9298.007; Mon, 10 Nov 2025
 05:29:04 +0000
Message-ID:
 <GV2PPF74270EBEE83C2CA09B945BC954FA3E4CEA@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Date: Mon, 10 Nov 2025 06:28:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] mt-exec: fix deadlock with ptrace_attach()
To: Oleg Nesterov <oleg@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Dmitry Levin <ldv@strace.io>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Alexey Dobriyan <adobriyan@gmail.com>, Kees Cook <kees@kernel.org>,
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 Christian Brauner <brauner@kernel.org>,
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
 <aRDL3HOB21pMVMWC@redhat.com>
Content-Language: en-US
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
In-Reply-To: <aRDL3HOB21pMVMWC@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::17) To GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4)
X-Microsoft-Original-Message-ID:
 <da39c4f6-871c-45e5-867e-b2b3821353e1@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPF74270EBEE:EE_|PR3P195MB0665:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f0b0cb2-5487-45a9-15c5-08de201a0ffa
X-MS-Exchange-SLBlob-MailProps:
	AZnQBsB9XmriMkceEMr8g4u6bPtbH41WZ6+DI/iLANdsPN+FBpcSl0EAeuS2m9WXw6+VzgdGSwJ6a+IPXuCkw3+JUvXZR+Bp5grjOWAPF532pZHnOQwHF3zDDUQvslg+BrVl/bNQVMy0CRI7AU1jQy9U2Ghrwp6dOORwFDMPQA3WcFPFbYH935iOkL0pMh3Ni+yVRj8iUdx78WTZ10S2CelPzMcIoL2LmnpFDTlAHQ6t6HwQBepJ08v6Nm+IG1iX5vzmWowjuDQHSPffTklQJQ+drQE5Gs3NQRzvzvfYtOflCwsJvienkUfC7qyF9AK0Da3jrIzwGXoxl4VStm+cE0wZKF8lKXH0s4hsQBQW6UExWuAN8Dr26CLjLHWfgX5njV9N+WB3sbTgBriErcnjCnoBh4tx9Ul4aeNw+lW5/v02UmdESsTQIJJRfc6Q92aIlVQcy9ZKVNJIAE8bUb0x/mlShE/XxmMh9JdJnIUYpUP4hz6fevGIfjUv3WD5EEINHAGpRWMfyPyCZDmjG1GiRNtoKigYbkyApaRqmKVL5CkxRMYMlbR93R/gzZO1JZa+Fr/nhiTwAcbo5llWKVM2Bejca70sIfLuaRH15WF8sBgLVCzNQaPzToEXLhSU1pFjIyIfagQh8YAOzoSKHlWaWuvDHZRN+h3D3G0iwjW9gcfVwjy7OwzKXc+Y/rqW6cpYsxHk2Ntm+3iv2MWoNuDTD+LYlWlkhVMkcv+ZJIe/P2KVq4erWSiw1VilZnAHN6rEDu+hAGIQcT8=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|15080799012|51005399006|461199028|19110799012|8060799015|6090799003|5072599009|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1YxSEpnS2pzUWlCc1h5UjJWVEFoQnE2R2lBZnZGUGtSbmlITkFhbjd3YVo5?=
 =?utf-8?B?QXcyNU5QZWI4UVpSTmdVYjkxTlBqSGYrNzFuRkhSNC9MekRUYWg1czdZOTF3?=
 =?utf-8?B?VENGR0psV3c0NmlKbVBVWnloUDZYVmIrR09UZnZPRzJrN3RUTWtTL1o4NEpm?=
 =?utf-8?B?U0s4dHdhN0J2akRZa053OEd1d21ueXAyU0F5c1k5R1o0WllOdm1SRjFYRXEv?=
 =?utf-8?B?U2QyYnlLZ0M0d3V6bkFpZkdwSVBqOWRWSFh3MzBabW9MOUFFdCtPY21VZlpr?=
 =?utf-8?B?WFY3Z0MzMXVBZ1dieTRqWCtBNCtteGlvSVg1bitiZXFlbWdnbUFnLzVySHIr?=
 =?utf-8?B?UjdZSktrTEZPVDh0NXhtL3BRQnJDOUVyQUN2SkFqdkVNNXRUUmk1bnZBVnpI?=
 =?utf-8?B?YktYZ2grL2JlNmFGbCtSQ3hGQStkbGIzMktRaWtUZ0ZDN09GUzMvUCtWYkNB?=
 =?utf-8?B?NGFUU2Y1OTNyYmpyZ25JblorTTZjdVNaTlhmaHhyZ3NpdzJGTmdGb1gySFhu?=
 =?utf-8?B?RmVGMFE0OHVRT0NHNDErekREMHhDY2NxV0ZhQStScE9iS1JzUlBGYmpaZ3Ni?=
 =?utf-8?B?UCtQR05LdXZKcGJtT3hIaitmM2RSQk01VVRHcFZOZG9JR3F2NVgvbkdnKzRi?=
 =?utf-8?B?aGJ3c3RVK2ZYeGMwTWtJcVRnQURUSmgwTW92U0cyQnlLUGtXWHROMk8wUHVU?=
 =?utf-8?B?Sk1GR0lDNG5Zb3EyR29IQjRRbEtCbEJhTzV5bXY4VkpxNmhqcU9CMXovYWxY?=
 =?utf-8?B?TlJ4S3hpMnRSYkpEN1B0U1NuZWo4dzVJQmY5d0NzTzJwLzBlN2tjdlVYZE9j?=
 =?utf-8?B?S01tOElRZGhBU25RQTF0ZUNTNUNUUVpDcjZOOFlhMzJTdzg2bHRVdDlYdzl1?=
 =?utf-8?B?aDhheTdzVHJBV05RZG52TDB1Q3V6cjZWSjd4amJ2MUlLdXRjcnhhNFhaUmNW?=
 =?utf-8?B?dXdCYWp6dUpZMFRDUGc3SHdOc3VEQlp0ZDdWMEJMQ3dyQk5TWWZRUkQ1cjVa?=
 =?utf-8?B?YXlkLzlScHJEN0dOVGlnZ2U2L3k0ZVJ3QnJjbE1STHBtV1U3cndNaVBpc2d6?=
 =?utf-8?B?VWhNblVCMWtQWW1YbE9zWGRWSVJJWkp2NnArb1BXOFNVbHU3cXVSSEVQUGZx?=
 =?utf-8?B?TG1XMmo5Vi9QYjg0MWhkWHB0aTNMUlpSZ1VOZlpjUXVoMnhlc0NiN3VrV3N0?=
 =?utf-8?B?QkhGWVZ1VmdFeHFSTjlUWjZhQUUrUDhoQXRzQjV6M1JPMTQrLzloOUwxZDRh?=
 =?utf-8?B?cWRGS2R4NFZnenN3ZE84dU1uZUZVZWg0dlQyZG9ma0N5dXZHc2ZXN3lYL2lD?=
 =?utf-8?B?NFp3NS9SNGQrc2dPaFFjdnpHcEkwMjdESEhzRXJna0ZXdlc3NFV0U3BHaVM1?=
 =?utf-8?B?SGtENzh5OEYzSzVURDFDUGkvMUdtQUc3elpsUm1QTjkrNDcvYkdxenhuWGlJ?=
 =?utf-8?B?TUtOY2k4c1M0OEo2Q2s3RXdFUjlzYUNMZXd6VmNnTXR0L1U4ZGN4REJxZkNP?=
 =?utf-8?B?MENOZDlPQ0xNckR3TzJkc0tZQTF5Ri9RWVZKVWJCVG1IWFA3WVdacVlIRWlZ?=
 =?utf-8?B?Q1ZsN21KYURCbFdUTE1EYnM4MkNPcWI5QXNLMmIzVEcrNlBNN3Q2c3dIcWU1?=
 =?utf-8?B?Y1RlU2EzTEFiancrbkpjMXo5dExNV2c9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUpzMU4wcXVJTTBkWU5UbHVtRytoQWh0Rjk5aURUMzMyakdFbDEvZFJuUGJZ?=
 =?utf-8?B?dU1xcGJIUXFaNGJyaVpKRUR4cm91OHNPSDBKUVR3Zng1M0ExcnU0V0lBYlNX?=
 =?utf-8?B?azBtdnlJNndibVBzVzZIRHk3TSttb1RSZW11b1FlODFEZDlRMmh1a29ubGtO?=
 =?utf-8?B?c3dGZVhSdUVZQmRtQjY1YldES29wNTRyejZZTmtIaksvMnorMDVtbUNaQm9N?=
 =?utf-8?B?T3g1V00yTXRsakU2SWZISzZVU0ZqbEJhd0JwcnFCYlZwMDR1N25RV2RCVGtx?=
 =?utf-8?B?UHpqb1pJdWwrbUM5R3RIdW55NHBCZzJwWTMzNFkzeDZoL1ovR1BjV0l3S1dy?=
 =?utf-8?B?NU5xRFdFZjFSTU1pRC9MMGR5YWk1QVM2L0x5UkRhMDRsa1d4YmVWa3UxQWRD?=
 =?utf-8?B?WmticERSSnJFc1BhUXRYVWpCNU0xVVd6OHdOdDFSZmgyL0gyYk1udEd5YUtv?=
 =?utf-8?B?OS9MRlZaYUxUUEppYWxyVXpWWjN6dm5HK3VnWGZpS3czUjVXQlFNaEpKcVRF?=
 =?utf-8?B?eXlaUVdSSXZScWwwWXRmbTFLMTVXU2dhSmxtTFhsOVgzSkNtWm1vZW43ZkNG?=
 =?utf-8?B?bXkyOWkwZzM3a25EOVhlLzJJZmZrVWkvdGgwVUMwb3hmdjN1anFoZ2J1M0RU?=
 =?utf-8?B?K3hFMUNaNkViUy91OHIyTTNCbjhibG40a2RZL1c1Y2p1YkxjQUVOVFBlYS80?=
 =?utf-8?B?Wnk4bFVMbTBBamZNUXRiU2JVOHBLYURHRDR0YjBpT3VweE1rZmZnK0xVQmlp?=
 =?utf-8?B?VndQdmxYR1ZrU3N6QlhqbUlldCtYN3NjVU9LUkNCbnhGdHN1eDRDNEIyNlpm?=
 =?utf-8?B?WGN5eFcvamYwamdkOWJCM3BlbHViUFRlanN2YzU0YjNOeTIvYlN5WFVOOUtC?=
 =?utf-8?B?N1hUYTlBWEl5S0Uva2x1L3RidC9aVDZVOUpFYXE1SkNCR3hNblFramR5azRy?=
 =?utf-8?B?MzRhekRzOEd6ck5LeFJVSTBhcXhwVzN4aEhzYnFmdFRacytiM1VGTHo5U0tE?=
 =?utf-8?B?elVIekdyTXhGSUorQysrWXFocDcvVGVvd0ZTUXpVUW1zZ0VKYUR1bTc2Mmxw?=
 =?utf-8?B?L0pGb2RkR0ZQR3JvUHM2NWJocDhNTUgxVzhjb0VnV2FubzA2QURMNnE1ZWdt?=
 =?utf-8?B?dERtK0w5L2VDdGcrelJUcU5XdXNjVVVNMEhWd1JhaGx6clFvTGVua2FJS1Iz?=
 =?utf-8?B?VG43TVRZNTZUYzFIcUh2L3VHbWtINTV4MStBQk9XOWN5cFQzb1RrcXo0Nkhu?=
 =?utf-8?B?Q1MrRHFQUjNZUjF6cy9BUkFZQUQycHp6bFhocjBjSW91NEVmRGNSakxQZ1hU?=
 =?utf-8?B?c1FldXVvQVVYNCthak1RREdmRUZOeGt0bUJrcENSdlVzQzZsQlY3NXMwcFhF?=
 =?utf-8?B?Qyt6T2E5Ry9FQVNjVG03eDlxU2ozRkRLeCtiL1orWWpUc3VvaWNnNjB6VTEv?=
 =?utf-8?B?eWxqZ2piQStvR1VxK0czc3Z2TEZYeVo0Q1ZWSFZWMWVRK2pkeTVDbkM5UUJa?=
 =?utf-8?B?SWdaTlJLS2tFdnFqdTBZS3ErcTRDSHhWYm9ybWRXZGxOMTlYY2tSK2l1Y2VE?=
 =?utf-8?B?bmV6TUpqSVVpbDdLTXdyUE9FUkNRazdFbnhiMEFWRnhqUURLZURkUkQzdFM1?=
 =?utf-8?B?MGlNTVhYb2plZ3hETFluQTMwWDRESGE5ZnlsZGVqc3pNNzlXSzFMeEl6bFlU?=
 =?utf-8?B?bGJMQTVYR3ZOTlVtZHlGb1VpbEsyVERkbHZGWk9CK2dTYzYrL0x6RFpGRm8z?=
 =?utf-8?Q?ZVkXH6KX+n5/1GwkU+M0Jmm9Jm/+cOEztAB0hj6?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-87dd8.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0b0cb2-5487-45a9-15c5-08de201a0ffa
X-MS-Exchange-CrossTenant-AuthSource: GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 05:29:04.5907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0665

Hi Oleg,

I have not been able to update my patch with your and Peter Peter Zijlstra's
kind suggestions, because I am currently too busy with my role as openssl maintainer.

Just for clarification, my patch is 10% about deadlocks, and 90% about security.
The idea is that if the de_thread is blocked, and the debugger may be trying to
ptrace the exec thread.  That must succeed or fail. So the debugger can release
the zombie threads.

The security issue is when the debugged process tries to exec a SUID process
like /usr/bin/passwd

In that case the new credentials are determined differently when the PTRACE is
already attached (i.e. non-root), than when it is not yet attached (root user).
My attempt at fixing this, determines the new credentials and the new dumpability
as root user when the debugger did not yet attach before the de_thread.
And keeps this decision.

When the debugger wants to attach the de_thread the debug-user access rights are
checked against the current user and additionally against the new user credentials.
This I did by quickly switching the user credenitals to the next user and back again,
under the cred_guard_mutex, which should make that safe.

So at this time I have only one request for you.
Could you please try out how the test case in my patch behaves with your fix?


Thanks
Bernd.

On 11/9/25 18:14, Oleg Nesterov wrote:
> Not for inclusion yet. 2/2 is untested, incomplete, possibly buggy.
> 
> But could you review at least the intent? Do you see any problem with
> this approach?
> 
> This problem is very, very old. It seems that nobody can suggest a
> simple/clean fix...
> 
> Oleg.
> ---
> 
>  fs/binfmt_elf.c         |   4 +-
>  fs/binfmt_elf_fdpic.c   |   4 +-
>  fs/binfmt_flat.c        |   4 +-
>  fs/exec.c               | 142 +++++++++++++++++++++++-------------------------
>  include/linux/binfmts.h |   2 +-
>  kernel/exit.c           |   9 +--
>  kernel/signal.c         |   6 +-
>  7 files changed, 87 insertions(+), 84 deletions(-)
> 


