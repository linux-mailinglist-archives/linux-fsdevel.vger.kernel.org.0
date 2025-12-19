Return-Path: <linux-fsdevel+bounces-71720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A09CFCCEF56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 09:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 398A13036CA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 08:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138DC274676;
	Fri, 19 Dec 2025 08:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="MU3pcDE7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazolkn19011038.outbound.protection.outlook.com [52.103.39.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73FE25F798;
	Fri, 19 Dec 2025 08:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.39.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766132119; cv=fail; b=NydIIRIbzUyj7phl3XLIKY4R/8PF0f/IJq0B19O7RUkvFNbYecv1zBdeuZy4ZwHabfa2SWzwmjoY/fy1Bu+OiGNLU0M5gjrPNxu005jg09AWu7PkuLXCFXmVXvyJlOGZsHm1szRRRVM+exTZCS/dW9Tx4XSvNPa7go9iHTWVz+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766132119; c=relaxed/simple;
	bh=/rbWr77B4DgoxJAiTEpFOB9j9F+4H/74HeYJHDT0DZE=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rfelnDV+4dzvkz5OX9noM8BDINAWYIYpcd1VuPhgzlv82+5qhARH6BUdZfQNr6NUVUrkzFd5qc6+FjCRBzmPcFIBucappZZt0WiNQoElTmDxEf7Z0sNmphX0ilJ1wIA3LwZvTSw7k+PyNhON8KO1/rh8kM7hjHtcAoeFIBXBgq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=MU3pcDE7; arc=fail smtp.client-ip=52.103.39.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5un68sqzadeqEMZ99n2n/ozLFb/htx08p/K3SuIEnexAjinVPDV0EQ2ZZaZKssOgHpS4N8yAHuGBCaXabNIjhUjM5AGCW9cSUQbUQbmkap7LYgQ5QMZtPFS91kkSVkG6HgkYXOLN2OU56R/7et86sM7ABOwTzUUulqcS+10mGDn2a5eYZzwHB/YRNPZPEvMcHhRs2Op/R+L7sx/FvA4aerRP35VobZgs7RcUcl+S40WbjRN70jsvDQiL9SCzq9tmy6jcrmRsbUlEfKWzaaXSAj7YE6d3V/7bm/Z8umyF8GA/dd3aRwKNaF4przqVGaJg5iGGeYGxqJMtKzliowifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJIZLfFYEqHjPTkVMmtS+kJPIsyq+NV/J3caRCmVYUY=;
 b=Roi45uSVM2LIqmhAdTVdk1nTtN+V0Qi8trxdCYXQGj/C84S3Gvri34ZD5Vcx6rhRfhZqcvL67uKl1xj6fJmLan9GP7Y1vHboyNvP8grQHZfvUyllAl944rhzeQeAydHOvO13HA+8jSRZhp86OSP8v8T5ejqimxCGSnoFW08SmPZWcJYJQr1CWmTtLGgLcvmTLbTXHkYGHR1dHbBLTP0bjI9vUDBbOs0Eke/vKhqhW1K1QD6nu7mxi8leGixkTzG0Mcjd0qlOWXcCajiUGlyOd6j3e/M+Kzgfez/vV5x0rxgRxfcaw22ddMcbl4okbaOoGCxs59NUhILtjdOffdPJzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJIZLfFYEqHjPTkVMmtS+kJPIsyq+NV/J3caRCmVYUY=;
 b=MU3pcDE7/to1AW6K5cWuD1bBUPX+Ejui0czBzybV6PB4Hyq8fQ72V2SkDIOWeabMtoCpFZaf4INtFN2+UuJaJBVrD9JFwQmA7NvAi2BfKKEWf9bIlNevar8P/sOw8UeqHdCt1xbyQWNISVMjirGXEkCLqMy0Wwe117G4Uvivq14wNq723VdpPvGaX4bETCYJCjfmFsBeDDEEr50XteT9FshaiWzQ6f0opqRDY71lSxjjdLxBTk+FSlU3pTxuSOPC2hOa56LBLyEBoV5AQqFK0F7mSDO511rE4HWLwcaa++jb0nqOXfFoRZpT7fsBcCbsxvKEgShmXSTIuuBhfS2zHQ==
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4) by VI0P195MB2760.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:2c5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Fri, 19 Dec
 2025 08:15:11 +0000
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::dde:411d:b5f2:49]) by GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::dde:411d:b5f2:49%8]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 08:15:11 +0000
Message-ID:
 <GV2PPF74270EBEEF1962CC34BF2D1858DAAE4A9A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Date: Fri, 19 Dec 2025 09:15:27 +0100
User-Agent: Mozilla Thunderbird
Subject: [PATCH v19] exec: Fix dead-lock in de_thread with ptrace_attach
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
 Alexey Dobriyan <adobriyan@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
 Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
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
 Shuah Khan <shuah@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>,
 Jens Axboe <axboe@kernel.dk>, Paul Moore <paul@paul-moore.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 David Windsor <dwindsor@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>,
 YueHaibing <yuehaibing@huawei.com>, Ard Biesheuvel <ardb@kernel.org>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Hans Liljestrand <ishkamiel@gmail.com>, tiozhang <tiozhang@didiglobal.com>,
 Penglei Jiang <superman.xpt@gmail.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Adrian Ratiu <adrian.ratiu@collabora.com>, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Cyrill Gorcunov <gorcunov@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Ryan Lee <ryan.lee@canonical.com>, apparmor@lists.ubuntu.com,
 selinux@vger.kernel.org
References: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEE807D016A79FE7A2F463E4D6A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <GV2PPF74270EBEEE807D016A79FE7A2F463E4D6A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::8) To GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4)
X-Microsoft-Original-Message-ID:
 <94afd610-6bd8-431c-b205-66bcf93c8752@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPF74270EBEE:EE_|VI0P195MB2760:EE_
X-MS-Office365-Filtering-Correlation-Id: 59ad954f-f1dd-4ab5-3f25-08de3ed6b9d0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|6090799003|8060799015|51005399006|12121999013|23021999003|41001999006|19110799012|15080799012|4302099013|440099028|3412199025|10035399007|40105399003|12091999003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmJvN05ra09teFJPMHVpZnNXdDJXSC8xSDF1YUpzRGc5Ly9aUlBhN0xWL0pL?=
 =?utf-8?B?R01LS2VYOEpHTHBxSEhwSGRCTEw2UzFkVGFpNlFuY2lyZnU1ZGVsMSsrVEl3?=
 =?utf-8?B?Zkh5dHp2NG8wa0s3b0Q3TGpNYXBwUEVLYnk3RDF3Mk1OUENnejlMM2E4eXc0?=
 =?utf-8?B?eWppMmI4Q1dDMnBOS1VEUnlNeDZHME9jVmJ5OFAvSXZIYnRBZXUvUDMzOWM0?=
 =?utf-8?B?UkZrVVpNcDkzQWFpUVNTellxSkFXelJSS3UwaU4xUHN1ekhEOXloNUlJUldu?=
 =?utf-8?B?Z0srSk5qSmo1WWhzOTJTNFBTT0ZyOHNPZ1FTayt3bDV0Sk1SYWFtT2lHU3NX?=
 =?utf-8?B?eFhLWWczd2w5dmxxM1V5VjlpT1lGUE13OXo4TkNKdEVOS3JTQ1BDRmtkamp1?=
 =?utf-8?B?TmtMWUhxNVpzUjlqWE9QYWxlSVFOV1ZlQmRqN081TXBuUVJnUENHZENFMCtV?=
 =?utf-8?B?anhKRHFyNTMxN2RZdWVUbk9aaHB3bzBRSUdpNHVER0ZZemc0cHdUR2ZFcS8z?=
 =?utf-8?B?c2NPK2VFZGxuRHdWSHdYY0M5SmsrN3MrOFA0eHpsMzNSazFEYmRRSXhrZHBr?=
 =?utf-8?B?Z3BkM0M3VVIwTVRXSk1GMWlxRTNuL0phOVl2VWhkR0J1cGJzWEY3U3BsbnBk?=
 =?utf-8?B?d3FJYi9qV2gvWE43REV1TGRoWXIrY3NMT3lZUFRtSVhyejFLQ1VSN3ZuMFAr?=
 =?utf-8?B?cG4wbFBvcWtXQlpHcG80Qm95Mjd4azQrSW9XK3JlVmM4Q3hRMXJ3bzRXSy9L?=
 =?utf-8?B?eUZ5K2V3MGl5dkUvL29JUkxnWlRVa1liRi9JS1diSk9YTE5YeXordE43alhm?=
 =?utf-8?B?L1RkWEZhWGlnOGxRTEd6bHcwd1dUbG9UamtYOC9QN2pZNE1lK1hJVlFOQ3pU?=
 =?utf-8?B?SUsrbHFYTDc3dEtvVnd2eTNqbmRXTXR1Z1Y1N0prS1p3dWVBME5WdHc5eVFr?=
 =?utf-8?B?emFWYVZaU3I2NFhoejVNNHNnRGJCS2VpdklweTFXZmt4RVdFdVdXWU1KOTJv?=
 =?utf-8?B?a1FNRWh2bHBHOGdBTGhRREhHa1doR2RDMEVHT1F6WFlMM2JUekpFTTNIRkly?=
 =?utf-8?B?WVBPTnVtekwzUDdHcHRKb2Z1SGdRRTVLVkIwbC9GTFNwNkJJV0NUclpJclRN?=
 =?utf-8?B?bXNHZkp2YTE1Mk1VNGVtNVE4S3dneEV4T1JIcjUyMFU4cEZVdTAxUjR6Yk5N?=
 =?utf-8?B?Y1pBdTZiakpyQ0FKSFF6cm9tOUhuZDVpR3lrWTB3cHNWTlVhV3BYdTI5TVR3?=
 =?utf-8?B?YjZSeGZxNjRBRXh4dnZQTHlIN1dOUUR4UEYvc3hXWjZnTml4U2VrSGZDa1Zi?=
 =?utf-8?B?alVEdklOaXJJLzFTbVdZK28rRXdEaWdmUjhjeVlVakhYODNLeG4valc2N0Rq?=
 =?utf-8?B?OEh5MmU0K3ZJUEdzMi95WktpZ1dXc3YvM1VlT0FWUUt1YnFLT0JVdFhBa2V5?=
 =?utf-8?B?blFZQVBJRi91SGRVQ0hyTW5WczFlcGVWVGMwb01FcGNiSEx3TndBQ3VScUhj?=
 =?utf-8?B?MWU5elY3QXkvTHR3cUJHREN2OHRaREZsaXVqVkZqSWpiN2QxSTgvV0d3UHdC?=
 =?utf-8?B?RCtOQVRKb01XRkI4aXpuMFQyREFTcXRFSkhTa3BveVBCblpzWCtzNyt2L1lv?=
 =?utf-8?B?dXFKY2hja3AyRTNPbVF4M1lsWkZtOEZhQU13ZUg3b1pmcHAwUkE5T0hrc3J4?=
 =?utf-8?B?MDExYjJuSWl6cnZRb1kxQnp1OE9QeXFhNjAxQlNJYVMyVWcxdEZyTnBWMlpN?=
 =?utf-8?B?T0JFUjBjTUh1dStVVDZsZXRQaVFPM2dVV1JTdGRoaGtRTyt3cnBFTHZhQUN3?=
 =?utf-8?B?aWdoUnY1NHRwZGFOZ3N3YjZJTGwvZDhRTEJnZ2pSYVh5VEVCRkRZcjlsMUNv?=
 =?utf-8?B?U1VGa3duRnBMaE13bVVlK2dYNkx1V0hXNFRyb3pZMU9OQVVlNjFqREQxVGdq?=
 =?utf-8?Q?sqWVeKPT+fD6pWV12QZT8EWFigfVEUc3?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFF2eDlVM3pwa0dQNGhpSy9FQWdVSXFTU3ZkNkU3TnFyMU9IbW9zUS9LMjRR?=
 =?utf-8?B?a0MvL0lNM09JeEhwWFd5RlZNSlZIeEZ4cGFVYVZkbDZOcVFyeDEvZXpROHVo?=
 =?utf-8?B?S2trc293OHVKK0pSZktYN21nRDA3Z2R0K2s0Njc1MVRJOUJLUXhMSnJHSEFl?=
 =?utf-8?B?azZhUm8rMHlIbFVSVC93Q2FUaFVyUEtsR2lHMUVpOVdSdWQ1RGZQc2R5bk5X?=
 =?utf-8?B?aCtrT1NTNjZ4cEpRUGxNcW1kQ1VkZkZwYVEzYXhRaDVDNDk3eVZzd3kyVnhG?=
 =?utf-8?B?MkpoNHhhcDNQL0lwL3ZPdllMazlSbThKTjgvMmRhb09FWVNGb1h0QmVCa0Ra?=
 =?utf-8?B?NmpuUUJWc2pCNzhZQ3NFWDh3eXRLRjREOVVBZWRPRTNXNW1kYzVURFZqYXEr?=
 =?utf-8?B?UGQ4Wm1zdHpqVzN5YWMrM2NzeGR4RVJuNlJ1Vk52b3ZLR0R2QWZpbEYzbnc2?=
 =?utf-8?B?ZTI5WXZKSXExVGY4bTlhVUFoV1cxSE9RQVA3bDlaclA3endTZWRNaGRYb3E2?=
 =?utf-8?B?b0ppY2U2bFBKSGtDdUVyK21BNXB1ZmRwV0dUeGh4UERLcnlKaklaS1JvS0R5?=
 =?utf-8?B?OUpmMkk5T016YkVwUW5GOWN5RHcyR0dwZVFqK2dEdW5hTFc0TkJaZ2oyMXNj?=
 =?utf-8?B?QTJJYWZyRDNVMDEzQlZ2aVQrb3BlR1RCeXFFTms5UlkzUjduK2RJSzlFL0hL?=
 =?utf-8?B?OTMrZEYyZHEvMlMxK1hrZFlLcUZob0lNUlpkcUQ4YWxMZjBIRXhZbjBtWGpI?=
 =?utf-8?B?SVAxRE9pN2RpMVZkV211WDV1bEpFS3FWb3hEaTdKRGlpYzFYR3krY2xPZnk0?=
 =?utf-8?B?UGZJMmJFRkM3UjBKbGtuVXJTYk83SlM4ZmVEOURVU2syNFB5T3N2b1NXeGZo?=
 =?utf-8?B?WUUrSFl2NGdJSWlnSU1VeWk5UFdzb2l0TWZ1Ny9RSFc4TnRhakpUZjc3dFVW?=
 =?utf-8?B?b1N4T3RXRnQ0WHpNWU1NQmRISlFmNnVqeFQ3aHNuVHZlYUxxVHpERld1eE9H?=
 =?utf-8?B?OGFLSnY1akxhUjg1T0d1L3Jaek51ZVNKRnJuMVlacjlXWHJqVEVhMERLUVVz?=
 =?utf-8?B?SlhST1crOTFzSk1rdjNacmFUdnhKcEoxVkJ4dE02UFZSZ0xRZXZCS1dhL2Vx?=
 =?utf-8?B?eTRWbUdOQjlXNnlsQnB3R0VnWGZYZ1N6QnMxM1ZkMGExVi9xK3p1cmM3TFBm?=
 =?utf-8?B?T1oxdGxmNlFrN0ZnT1pUY251WFdQV3FobVJZRGRmaUZqTGVaTGQrcjNrcnJM?=
 =?utf-8?B?SklVeUN5MEg3ZFFWYStPTGRRMlJudmhmU2dBS0hjSzkvelRXcWhoSlpmdkZG?=
 =?utf-8?B?ZnJmclo4VEZWdDhsY2I2TVpRSlVkSjFpcU00WW1YYzZKSlE1REd4aFBIRzNO?=
 =?utf-8?B?V01zMnVDZ0dxSDA5NEYwWDRidUZXS2c3cGE3Mkp0MlZSaThnVlNXbloxZXhv?=
 =?utf-8?B?dUNTeGh3VWoyeEYwUy9ia1BhQ0V0ZWJ3UkJ3Z3BuZ3ovcVpPUHorejRMWnJk?=
 =?utf-8?B?c0tObkErUlUwNzJGdWFuV3hFcFBOeEZzMmpIbGRNeHFMamM2ekl2Z3JydmpK?=
 =?utf-8?B?SFNESXliT3V6djRLSXZqS1dYRUwreEdhZWdveFd3K0U5N0QvVU43TCs1MUtq?=
 =?utf-8?B?WnJDUXY4UlRMY2pKd3BWckxPZmZhZWx2Q3hWQmQ3RXFhQmRmb3FPQmJ1VkdR?=
 =?utf-8?B?WXg1anE3QXdEdXAweEQ1UFF3Tnc5N09zellNbERXSG55YWx1MlFGd3ZvK016?=
 =?utf-8?Q?wSeeLzXgVTUyXOze3iNlhWnarULB6y0Cauuu5Nk?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-068e0.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ad954f-f1dd-4ab5-3f25-08de3ed6b9d0
X-MS-Exchange-CrossTenant-AuthSource: GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 08:15:10.7992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P195MB2760

This introduces signal->exec_bprm, which is used to
fix the case when at least one of the sibling threads
is traced, and therefore the trace process may be blocked
in ptrace_attach, but de_thread() will need to wait for the
tracer to continue execution.

Furthermore this introduces the new ptrace_may_access flag
PTRACE_MODE_BPRMCREDS, which informs the security engines
that the credentials in child->signal->exec_bprm shall be
checked in the ptrace_access_check callback.

The problem happens when a tracer tries to ptrace_attach
to a multi-threaded process, that does an execve in one of
the threads at the same time, without doing that in a forked
sub-process.  That means: There is a race condition, when one
or more of the threads are already ptraced, but the thread
that invoked the execve is not yet traced.  Now in this
case the execve locks the cred_guard_mutex and waits for
de_thread() to complete.  But that waits for the traced
sibling threads to exit, and those have to wait for the
tracer to receive the exit signal, but the tracer cannot
call wait right now, because it is waiting for the ptrace
call to complete, and this will probably never happen.
The traced process and the tracer are now in a deadlock
situation, and can only be killed when this happens.

The solution is to detect this situation and allow
ptrace_attach to continue by temporarily releasing the
cred_guard_mutex, while de_thread() is still waiting for
traced zombies to be eventually released by the tracer.
In the case of the thread group leader we only have to wait
for the thread to become a zombie, which may also need
co-operation from the tracer due to PTRACE_O_TRACEEXIT.

When a tracer wants to ptrace_attach a task that already
is in execve, we simply retry the ptrace_may_access
check with the new PTRACE_MODE_BPRMCREDS flag to check
that the tracer has permission to trace the new credentials
and dumpability which are about to be used after execve
completes.  If the ptrace_attach happens on a thread that
is a sibling-thread of the thread doing execve, it is
sufficient to check against the old credentials, as this
thread will be waited for, before the new credentials are
installed.

Other threads die quickly since the cred_guard_mutex is
released, but a deadly signal is already pending.  In case
the mutex_lock_killable misses the signal, the non-zero
current->signal->exec_bprm makes sure they release the
mutex immediately and return with -ERESTARTNOINTR.

This means there is no API change, unlike the previous
version of this patch which was discussed here:

https://lore.kernel.org/lkml/b6537ae6-31b1-5c50-f32b-8b8332ace882@hotmail.de/

The disadvantage of that approach was, that it is a
user-visible API-change, but also that the debugger does
not know when to retry the PTRACE_ATTACH, in worst case
it will go into an endless loop, not knowing that a
waitpid and/or PTRACE_CONT is necessary to unblock the
traced process.

But the main reason why the overlapping lifetime of the
current and the new credentials is an improvement over the
previous version, is that the tracee could have escaped the
PTRACE_ATTACH if it is very short-lived, while now from
the tracer's perspective, everything looks as if the
PTRACE_ATTACH happened immediatly after the new executable
is loaded and just after the new credentials are committed.

See tools/testing/selftests/ptrace/vmaccess.c
for a test case that gets fixed by this change.

Note that since the test case was originally designed to
test the ptrace_attach returning an error in this situation,
the test expectation needed to be adjusted, to allow the
API to succeed at the first attempt.

Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
---
 fs/exec.c                                 |  89 +++++++++++---
 fs/proc/base.c                            |  12 ++
 include/linux/cred.h                      |   1 +
 include/linux/ptrace.h                    |   1 +
 include/linux/sched/signal.h              |  20 +++-
 kernel/cred.c                             |  30 ++++-
 kernel/fork.c                             |   2 +-
 kernel/ptrace.c                           |  29 ++++-
 kernel/seccomp.c                          |  18 ++-
 security/apparmor/lsm.c                   |   5 +-
 security/commoncap.c                      |   5 +-
 security/landlock/task.c                  |   7 +-
 security/selinux/hooks.c                  |   7 +-
 security/smack/smack_lsm.c                |   5 +-
 security/yama/yama_lsm.c                  |  11 +-
 tools/testing/selftests/ptrace/vmaccess.c | 137 ++++++++++++++++++++--
 16 files changed, 330 insertions(+), 49 deletions(-)

v10: Changes to previous version, make the PTRACE_ATTACH
return -EAGAIN, instead of execve return -ERESTARTSYS.
Added some lessions learned to the description.

v11: Check old and new credentials in PTRACE_ATTACH again without
changing the API.

Note: I got actually one response from an automatic checker to the v11 patch,

https://lore.kernel.org/lkml/202107121344.wu68hEPF-lkp@intel.com/

which is complaining about:

>> >> kernel/ptrace.c:425:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const *old_cred @@     got struct cred const [noderef] __rcu *real_cred @@

   417			struct linux_binprm *bprm = task->signal->exec_bprm;
   418			const struct cred *old_cred;
   419			struct mm_struct *old_mm;
   420	
   421			retval = down_write_killable(&task->signal->exec_update_lock);
   422			if (retval)
   423				goto unlock_creds;
   424			task_lock(task);
 > 425			old_cred = task->real_cred;

v12: Essentially identical to v11.

- Fixed a minor merge conflict in linux v5.17, and fixed the
above mentioned nit by adding __rcu to the declaration.

- re-tested the patch with all linux versions from v5.11 to v6.6

v10 was an alternative approach which did imply an API change.
But I would prefer to avoid such an API change.

The difficult part is getting the right dumpability flags assigned
before de_thread starts, hope you like this version.
If not, the v10 is of course also acceptable.

v13: Fixed duplicated Return section in function header of
is_dumpability_changed which was reported by the kernel test robot

v14: rebased to v6.7, refreshed and retested.
And added a more detailed description of the actual bug.

v15: rebased to v6.8-rc1, addressed some review comments.
Split the test case vmaccess into vmaccess1 and vmaccess2
to improve overall test coverage.

v16: rebased to 6.17-rc2, fixed some minor merge conflicts.

v17: avoid use of task->in_execve in ptrace_attach.

v18: Add some more comments, avoid the temporary impersonation of the
new credentials, and use instead a new option to ptrace_may_access.
All security engines have to handle this option, but the advantage is
that the engines could detect and maybe also deny the unsafe execve.

v19: This mainly improves the commit message and updates some comments.
Rebased and re-tested on v6.19-rc1.


Thanks
Bernd.

diff --git a/fs/exec.c b/fs/exec.c
index 9d5ebc9d15b0..db5c3b10c48a 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -905,11 +905,13 @@ static int exec_mmap(struct mm_struct *mm)
 	return 0;
 }
 
-static int de_thread(struct task_struct *tsk)
+static int de_thread(struct task_struct *tsk, struct linux_binprm *bprm)
 {
 	struct signal_struct *sig = tsk->signal;
 	struct sighand_struct *oldsighand = tsk->sighand;
 	spinlock_t *lock = &oldsighand->siglock;
+	struct task_struct *t;
+	bool unsafe_execve_in_progress = false;
 
 	if (thread_group_empty(tsk))
 		goto no_thread_group;
@@ -932,6 +934,36 @@ static int de_thread(struct task_struct *tsk)
 	if (!thread_group_leader(tsk))
 		sig->notify_count--;
 
+	for_other_threads(tsk, t) {
+		if (unlikely(t->ptrace) &&
+		    (t != tsk->group_leader || !t->exit_state)) {
+			unsafe_execve_in_progress = true;
+			break;
+		}
+	}
+
+	if (unlikely(unsafe_execve_in_progress)) {
+		/*
+		 * Since the spin lock was acquired while holding the
+		 * mutex, both should be unlocked in reverse sequence and
+		 * the spin lock re-acquired after releasing the mutex.
+		 */
+		spin_unlock_irq(lock);
+		/*
+		 * Sibling threads are notified by the non-zero exec_bprm,
+		 * that they have just been zapped, and the cred_guard_mutex
+		 * is to be released by them immediately.
+		 * The caller of ptrace_attach on the other hand is allowed
+		 * to ptrace any additional sibling threads that may not yet
+		 * have ben ptraced, but if the group_exec_task is being
+		 * ptraced, an additional check has to be performed, that the
+		 * tracer is allowed to ptrace the new exec credentials.
+		 */
+		sig->exec_bprm = bprm;
+		mutex_unlock(&sig->cred_guard_mutex);
+		spin_lock_irq(lock);
+	}
+
 	while (sig->notify_count) {
 		__set_current_state(TASK_KILLABLE);
 		spin_unlock_irq(lock);
@@ -1021,6 +1053,11 @@ static int de_thread(struct task_struct *tsk)
 		release_task(leader);
 	}
 
+	if (unlikely(unsafe_execve_in_progress)) {
+		mutex_lock(&sig->cred_guard_mutex);
+		sig->exec_bprm = NULL;
+	}
+
 	sig->group_exec_task = NULL;
 	sig->notify_count = 0;
 
@@ -1032,6 +1069,11 @@ static int de_thread(struct task_struct *tsk)
 	return 0;
 
 killed:
+	if (unlikely(unsafe_execve_in_progress)) {
+		mutex_lock(&sig->cred_guard_mutex);
+		sig->exec_bprm = NULL;
+	}
+
 	/* protects against exit_notify() and __exit_signal() */
 	read_lock(&tasklist_lock);
 	sig->group_exec_task = NULL;
@@ -1114,13 +1156,31 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 */
 	trace_sched_prepare_exec(current, bprm);
 
+	/* If the binary is not readable then enforce mm->dumpable=0 */
+	would_dump(bprm, bprm->file);
+	if (bprm->have_execfd)
+		would_dump(bprm, bprm->executable);
+
+	/*
+	 * Figure out dumpability. Note that this checking only of current
+	 * is wrong, but userspace depends on it. This should be testing
+	 * bprm->secureexec instead.
+	 */
+	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
+	    is_dumpability_changed(current_cred(), bprm->cred) ||
+	    !(uid_eq(current_euid(), current_uid()) &&
+	      gid_eq(current_egid(), current_gid())))
+		set_dumpable(bprm->mm, suid_dumpable);
+	else
+		set_dumpable(bprm->mm, SUID_DUMP_USER);
+
 	/*
 	 * Ensure all future errors are fatal.
 	 */
 	bprm->point_of_no_return = true;
 
 	/* Make this the only thread in the thread group */
-	retval = de_thread(me);
+	retval = de_thread(me, bprm);
 	if (retval)
 		goto out;
 	/* see the comment in check_unsafe_exec() */
@@ -1144,11 +1204,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (retval)
 		goto out;
 
-	/* If the binary is not readable then enforce mm->dumpable=0 */
-	would_dump(bprm, bprm->file);
-	if (bprm->have_execfd)
-		would_dump(bprm, bprm->executable);
-
 	/*
 	 * Release all of the old mmap stuff
 	 */
@@ -1210,18 +1265,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 
 	me->sas_ss_sp = me->sas_ss_size = 0;
 
-	/*
-	 * Figure out dumpability. Note that this checking only of current
-	 * is wrong, but userspace depends on it. This should be testing
-	 * bprm->secureexec instead.
-	 */
-	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
-	    !(uid_eq(current_euid(), current_uid()) &&
-	      gid_eq(current_egid(), current_gid())))
-		set_dumpable(current->mm, suid_dumpable);
-	else
-		set_dumpable(current->mm, SUID_DUMP_USER);
-
 	perf_event_exec();
 
 	/*
@@ -1275,6 +1318,10 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 * cred_guard_mutex must be held at least to this point to prevent
 	 * ptrace_attach() from altering our determination of the task's
 	 * credentials; any time after this it may be unlocked.
+	 * Note that de_thread() may temporarily release the cred_guard_mutex,
+	 * but the credentials are pre-determined in that case and the ptrace
+	 * access check guarantees, that the access permissions of the tracer
+	 * are sufficient to trace the task also with the new credentials.
 	 */
 	security_bprm_committed_creds(bprm);
 
@@ -1360,6 +1407,10 @@ static int prepare_bprm_creds(struct linux_binprm *bprm)
 	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
 		return -ERESTARTNOINTR;
 
+	/*
+	 * It is not necessary to check current->signal->exec_bprm here,
+	 * because de_thread() has already an equivalent check.
+	 */
 	bprm->cred = prepare_exec_creds();
 	if (likely(bprm->cred))
 		return 0;
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 4eec684baca9..84a525ca9e5b 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2838,6 +2838,18 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
 	if (rv < 0)
 		goto out_free;
 
+	/*
+	 * A fatal signal is guaranteed to be already pending in the
+	 * unlikely event, that current->signal->exec_bprm happens
+	 * to be non-zero here, so just release the mutex again
+	 * and continue as if mutex_lock_interruptible did fail.
+	 */
+	if (unlikely(current->signal->exec_bprm)) {
+		mutex_unlock(&current->signal->cred_guard_mutex);
+		rv = -ERESTARTNOINTR;
+		goto out_free;
+	}
+
 	rv = security_setprocattr(PROC_I(inode)->op.lsmid,
 				  file->f_path.dentry->d_name.name, page,
 				  count);
diff --git a/include/linux/cred.h b/include/linux/cred.h
index 343a140a6ba2..b243223cd24b 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -155,6 +155,7 @@ extern const struct cred *get_task_cred(struct task_struct *);
 extern struct cred *cred_alloc_blank(void);
 extern struct cred *prepare_creds(void);
 extern struct cred *prepare_exec_creds(void);
+extern bool is_dumpability_changed(const struct cred *, const struct cred *);
 extern int commit_creds(struct cred *);
 extern void abort_creds(struct cred *);
 extern struct cred *prepare_kernel_cred(struct task_struct *);
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 90507d4afcd6..dbd58a4807bc 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -64,6 +64,7 @@ extern void exit_ptrace(struct task_struct *tracer, struct list_head *dead);
 #define PTRACE_MODE_NOAUDIT	0x04
 #define PTRACE_MODE_FSCREDS	0x08
 #define PTRACE_MODE_REALCREDS	0x10
+#define PTRACE_MODE_BPRMCREDS	0x20
 
 /* shorthands for READ/ATTACH and FSCREDS/REALCREDS combinations */
 #define PTRACE_MODE_READ_FSCREDS (PTRACE_MODE_READ | PTRACE_MODE_FSCREDS)
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 7d6449982822..6850e971dfff 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -241,10 +241,28 @@ struct signal_struct {
 	struct mm_struct *oom_mm;	/* recorded mm when the thread group got
 					 * killed by the oom killer */
 
+	struct linux_binprm *exec_bprm;	/* Used to check ptrace_may_access
+					 * against new credentials while
+					 * de_thread is waiting for other
+					 * traced threads to terminate.
+					 * Set while de_thread is executing.
+					 * The cred_guard_mutex is released
+					 * after de_thread() has called
+					 * zap_other_threads(), therefore
+					 * a fatal signal is guaranteed to be
+					 * already pending in the unlikely
+					 * event, that
+					 * current->signal->exec_bprm happens
+					 * to be non-zero after the
+					 * cred_guard_mutex was acquired.
+					 */
+
 	struct mutex cred_guard_mutex;	/* guard against foreign influences on
 					 * credential calculations
 					 * (notably. ptrace)
-					 * Deprecated do not use in new code.
+					 * Held while execve runs, except when
+					 * a sibling thread is being traced.
+					 * Not recommended to use in new code.
 					 * Use exec_update_lock instead.
 					 */
 	struct rw_semaphore exec_update_lock;	/* Held while task_struct is
diff --git a/kernel/cred.c b/kernel/cred.c
index a6f686b30da1..08e73a6fc123 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -351,6 +351,30 @@ static bool cred_cap_issubset(const struct cred *set, const struct cred *subset)
 	return false;
 }
 
+/**
+ * is_dumpability_changed - Will changing creds affect dumpability?
+ * @old: The old credentials.
+ * @new: The new credentials.
+ *
+ * If the @new credentials have no elevated privileges compared to the
+ * @old credentials, the task may remain dumpable.  Otherwise we have
+ * to mark the task as undumpable to avoid information leaks from higher
+ * to lower privilege domains.
+ *
+ * Return: True if the task will become undumpable.
+ */
+bool is_dumpability_changed(const struct cred *old, const struct cred *new)
+{
+	if (!uid_eq(old->euid, new->euid) ||
+	    !gid_eq(old->egid, new->egid) ||
+	    !uid_eq(old->fsuid, new->fsuid) ||
+	    !gid_eq(old->fsgid, new->fsgid) ||
+	    !cred_cap_issubset(old, new))
+		return true;
+
+	return false;
+}
+
 /**
  * commit_creds - Install new credentials upon the current task
  * @new: The credentials to be assigned
@@ -379,11 +403,7 @@ int commit_creds(struct cred *new)
 	get_cred(new); /* we will require a ref for the subj creds too */
 
 	/* dumpability changes */
-	if (!uid_eq(old->euid, new->euid) ||
-	    !gid_eq(old->egid, new->egid) ||
-	    !uid_eq(old->fsuid, new->fsuid) ||
-	    !gid_eq(old->fsgid, new->fsgid) ||
-	    !cred_cap_issubset(old, new)) {
+	if (is_dumpability_changed(old, new)) {
 		if (task->mm)
 			set_dumpable(task->mm, suid_dumpable);
 		task->pdeath_signal = 0;
diff --git a/kernel/fork.c b/kernel/fork.c
index b1f3915d5f8e..aa06aa7051b2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1393,7 +1393,7 @@ struct mm_struct *mm_access(struct task_struct *task, unsigned int mode)
 	struct mm_struct *mm;
 	int err;
 
-	err =  down_read_killable(&task->signal->exec_update_lock);
+	err = down_read_killable(&task->signal->exec_update_lock);
 	if (err)
 		return ERR_PTR(err);
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 392ec2f75f01..be8bdcc71d08 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -20,6 +20,7 @@
 #include <linux/pagemap.h>
 #include <linux/ptrace.h>
 #include <linux/security.h>
+#include <linux/binfmts.h>
 #include <linux/signal.h>
 #include <linux/uio.h>
 #include <linux/audit.h>
@@ -285,6 +286,11 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
 		return -EPERM;
 	}
 
+	if ((mode & PTRACE_MODE_BPRMCREDS) && !task->signal->exec_bprm) {
+		WARN(1, "denying ptrace access check with PTRACE_MODE_BPRMCREDS\n");
+		return -EPERM;
+	}
+
 	/* May we inspect the given task?
 	 * This check is used both for attaching with ptrace
 	 * and for allowing access to sensitive information in /proc.
@@ -313,7 +319,10 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
 		caller_uid = cred->uid;
 		caller_gid = cred->gid;
 	}
-	tcred = __task_cred(task);
+	if (mode & PTRACE_MODE_BPRMCREDS)
+		tcred = task->signal->exec_bprm->cred;
+	else
+		tcred = __task_cred(task);
 	if (uid_eq(caller_uid, tcred->euid) &&
 	    uid_eq(caller_uid, tcred->suid) &&
 	    uid_eq(caller_uid, tcred->uid)  &&
@@ -337,7 +346,10 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
 	 * Pairs with a write barrier in commit_creds().
 	 */
 	smp_rmb();
-	mm = task->mm;
+	if (mode & PTRACE_MODE_BPRMCREDS)
+		mm = task->signal->exec_bprm->mm;
+	else
+		mm = task->mm;
 	if (mm &&
 	    ((get_dumpable(mm) != SUID_DUMP_USER) &&
 	     !ptrace_has_cap(mm->user_ns, mode)))
@@ -451,6 +463,14 @@ static int ptrace_attach(struct task_struct *task, long request,
 			retval = __ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS);
 			if (retval)
 				return retval;
+
+			if (unlikely(task == task->signal->group_exec_task)) {
+				retval = __ptrace_may_access(task,
+							     PTRACE_MODE_ATTACH_REALCREDS |
+							     PTRACE_MODE_BPRMCREDS);
+				if (retval)
+					return retval;
+			}
 		}
 
 		scoped_guard (write_lock_irq, &tasklist_lock) {
@@ -488,6 +508,10 @@ static int ptrace_traceme(void)
 {
 	int ret = -EPERM;
 
+	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
+		return -ERESTARTNOINTR;
+
+	/* It is not necessary to check current->signal->exec_bprm here. */
 	write_lock_irq(&tasklist_lock);
 	/* Are we already being traced? */
 	if (!current->ptrace) {
@@ -503,6 +527,7 @@ static int ptrace_traceme(void)
 		}
 	}
 	write_unlock_irq(&tasklist_lock);
+	mutex_unlock(&current->signal->cred_guard_mutex);
 
 	return ret;
 }
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 25f62867a16d..6e4ff108faa0 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -2010,9 +2010,21 @@ static long seccomp_set_mode_filter(unsigned int flags,
 	 * Make sure we cannot change seccomp or nnp state via TSYNC
 	 * while another thread is in the middle of calling exec.
 	 */
-	if (flags & SECCOMP_FILTER_FLAG_TSYNC &&
-	    mutex_lock_killable(&current->signal->cred_guard_mutex))
-		goto out_put_fd;
+	if (flags & SECCOMP_FILTER_FLAG_TSYNC) {
+		if (mutex_lock_killable(&current->signal->cred_guard_mutex))
+			goto out_put_fd;
+
+		/*
+		 * A fatal signal is guaranteed to be already pending in the
+		 * unlikely event, that current->signal->exec_bprm happens
+		 * to be non-zero here, so just release the mutex again
+		 * and continue as if mutex_lock_killable did fail.
+		 */
+		if (unlikely(current->signal->exec_bprm)) {
+			mutex_unlock(&current->signal->cred_guard_mutex);
+			goto out_put_fd;
+		}
+	}
 
 	spin_lock_irq(&current->sighand->siglock);
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index a87cd60ed206..12da76db0bab 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -130,7 +130,10 @@ static int apparmor_ptrace_access_check(struct task_struct *child,
 	int error;
 	bool needput;
 
-	cred = get_task_cred(child);
+	if (mode & PTRACE_MODE_BPRMCREDS)
+		cred = get_cred(child->signal->exec_bprm->cred);
+	else
+		cred = get_task_cred(child);
 	tracee = cred_label(cred);	/* ref count on cred */
 	tracer = __begin_current_label_crit_section(&needput);
 	error = aa_may_ptrace(current_cred(), tracer, cred, tracee,
diff --git a/security/commoncap.c b/security/commoncap.c
index 8a23dfab7fac..b97368ba9669 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -169,7 +169,10 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
 
 	rcu_read_lock();
 	cred = current_cred();
-	child_cred = __task_cred(child);
+	if (mode & PTRACE_MODE_BPRMCREDS)
+		child_cred = child->signal->exec_bprm->cred;
+	else
+		child_cred = __task_cred(child);
 	if (mode & PTRACE_MODE_FSCREDS)
 		caller_caps = &cred->cap_effective;
 	else
diff --git a/security/landlock/task.c b/security/landlock/task.c
index 2385017418ca..46ce9b6e4728 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -17,6 +17,7 @@
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
 #include <linux/sched/signal.h>
+#include <linux/binfmts.h>
 #include <net/af_unix.h>
 #include <net/sock.h>
 
@@ -96,7 +97,11 @@ static int hook_ptrace_access_check(struct task_struct *const child,
 
 	scoped_guard(rcu)
 	{
-		child_dom = landlock_get_task_domain(child);
+		if (mode & PTRACE_MODE_BPRMCREDS)
+			child_dom = landlock_cred(child->signal->
+						  exec_bprm->cred)->domain;
+		else
+			child_dom = landlock_get_task_domain(child);
 		err = domain_ptrace(parent_subject->domain, child_dom);
 	}
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d053ce562370..fb46c309c31f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2113,7 +2113,12 @@ static int selinux_ptrace_access_check(struct task_struct *child,
 				       unsigned int mode)
 {
 	u32 sid = current_sid();
-	u32 csid = task_sid_obj(child);
+	u32 csid;
+
+	if (mode & PTRACE_MODE_BPRMCREDS)
+		csid = cred_sid(child->signal->exec_bprm->cred);
+	else
+		csid = task_sid_obj(child);
 
 	if (mode & PTRACE_MODE_READ)
 		return avc_has_perm(sid, csid, SECCLASS_FILE, FILE__READ,
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a0bd4919a9d9..347df3c7445e 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -476,7 +476,10 @@ static int smack_ptrace_access_check(struct task_struct *ctp, unsigned int mode)
 {
 	struct smack_known *skp;
 
-	skp = smk_of_task_struct_obj(ctp);
+	if (mode & PTRACE_MODE_BPRMCREDS)
+		skp = smk_of_task(smack_cred(ctp->signal->exec_bprm->cred));
+	else
+		skp = smk_of_task_struct_obj(ctp);
 
 	return smk_ptrace_rule_check(current, skp, mode, __func__);
 }
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 38b21ee0c560..dddc6eccfc9b 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -11,6 +11,7 @@
 #include <linux/lsm_hooks.h>
 #include <linux/sysctl.h>
 #include <linux/ptrace.h>
+#include <linux/binfmts.h>
 #include <linux/prctl.h>
 #include <linux/ratelimit.h>
 #include <linux/workqueue.h>
@@ -363,13 +364,19 @@ static int yama_ptrace_access_check(struct task_struct *child,
 				rc = -EPERM;
 			if (!rc && !task_is_descendant(current, child) &&
 			    !ptracer_exception_found(current, child) &&
-			    !ns_capable(__task_cred(child)->user_ns, CAP_SYS_PTRACE))
+			    !ns_capable(mode & PTRACE_MODE_BPRMCREDS ?
+					child->signal->exec_bprm->cred->user_ns :
+					__task_cred(child)->user_ns,
+					CAP_SYS_PTRACE))
 				rc = -EPERM;
 			rcu_read_unlock();
 			break;
 		case YAMA_SCOPE_CAPABILITY:
 			rcu_read_lock();
-			if (!ns_capable(__task_cred(child)->user_ns, CAP_SYS_PTRACE))
+			if (!ns_capable(mode & PTRACE_MODE_BPRMCREDS ?
+					child->signal->exec_bprm->cred->user_ns :
+					__task_cred(child)->user_ns,
+					CAP_SYS_PTRACE))
 				rc = -EPERM;
 			rcu_read_unlock();
 			break;
diff --git a/tools/testing/selftests/ptrace/vmaccess.c b/tools/testing/selftests/ptrace/vmaccess.c
index 3801b5831527..7fa39be16827 100644
--- a/tools/testing/selftests/ptrace/vmaccess.c
+++ b/tools/testing/selftests/ptrace/vmaccess.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (c) 2020 Bernd Edlinger <bernd.edlinger@hotmail.de>
+ * Copyright (c) 2020-2025 Bernd Edlinger <bernd.edlinger@hotmail.de>
  * All rights reserved.
  *
  * Check whether /proc/$pid/mem can be accessed without causing deadlocks
@@ -14,6 +14,7 @@
 #include <signal.h>
 #include <unistd.h>
 #include <sys/ptrace.h>
+#include <sys/syscall.h>
 
 static void *thread(void *arg)
 {
@@ -23,7 +24,7 @@ static void *thread(void *arg)
 
 TEST(vmaccess)
 {
-	int f, pid = fork();
+	int s, f, pid = fork();
 	char mm[64];
 
 	if (!pid) {
@@ -31,19 +32,42 @@ TEST(vmaccess)
 
 		pthread_create(&pt, NULL, thread, NULL);
 		pthread_join(pt, NULL);
-		execlp("true", "true", NULL);
+		execlp("false", "false", NULL);
+		return;
 	}
 
 	sleep(1);
 	sprintf(mm, "/proc/%d/mem", pid);
+	/* deadlock did happen here */
 	f = open(mm, O_RDONLY);
 	ASSERT_GE(f, 0);
 	close(f);
-	f = kill(pid, SIGCONT);
-	ASSERT_EQ(f, 0);
+	f = waitpid(-1, &s, WNOHANG);
+	ASSERT_NE(f, -1);
+	ASSERT_NE(f, 0);
+	ASSERT_NE(f, pid);
+	ASSERT_EQ(WIFEXITED(s), 1);
+	ASSERT_EQ(WEXITSTATUS(s), 0);
+	f = waitpid(-1, &s, 0);
+	ASSERT_EQ(f, pid);
+	ASSERT_EQ(WIFEXITED(s), 1);
+	ASSERT_EQ(WEXITSTATUS(s), 1);
+	f = waitpid(-1, NULL, 0);
+	ASSERT_EQ(f, -1);
+	ASSERT_EQ(errno, ECHILD);
 }
 
-TEST(attach)
+/*
+ * Same test as previous, except that
+ * we try to ptrace the group leader,
+ * which is about to call execve,
+ * when the other thread is already ptraced.
+ * This exercises the code in de_thread
+ * where it is waiting inside the
+ * while (sig->notify_count) {
+ * loop.
+ */
+TEST(attach1)
 {
 	int s, k, pid = fork();
 
@@ -52,19 +76,76 @@ TEST(attach)
 
 		pthread_create(&pt, NULL, thread, NULL);
 		pthread_join(pt, NULL);
-		execlp("sleep", "sleep", "2", NULL);
+		execlp("false", "false", NULL);
+		return;
 	}
 
 	sleep(1);
+	/* deadlock may happen here */
 	k = ptrace(PTRACE_ATTACH, pid, 0L, 0L);
-	ASSERT_EQ(errno, EAGAIN);
-	ASSERT_EQ(k, -1);
+	ASSERT_EQ(k, 0);
 	k = waitpid(-1, &s, WNOHANG);
 	ASSERT_NE(k, -1);
 	ASSERT_NE(k, 0);
 	ASSERT_NE(k, pid);
 	ASSERT_EQ(WIFEXITED(s), 1);
 	ASSERT_EQ(WEXITSTATUS(s), 0);
+	k = waitpid(-1, &s, 0);
+	ASSERT_EQ(k, pid);
+	ASSERT_EQ(WIFSTOPPED(s), 1);
+	ASSERT_EQ(WSTOPSIG(s), SIGTRAP);
+	k = waitpid(-1, &s, WNOHANG);
+	ASSERT_EQ(k, 0);
+	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
+	ASSERT_EQ(k, 0);
+	k = waitpid(-1, &s, 0);
+	ASSERT_EQ(k, pid);
+	ASSERT_EQ(WIFSTOPPED(s), 1);
+	ASSERT_EQ(WSTOPSIG(s), SIGSTOP);
+	k = waitpid(-1, &s, WNOHANG);
+	ASSERT_EQ(k, 0);
+	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
+	ASSERT_EQ(k, 0);
+	k = waitpid(-1, &s, 0);
+	ASSERT_EQ(k, pid);
+	ASSERT_EQ(WIFEXITED(s), 1);
+	ASSERT_EQ(WEXITSTATUS(s), 1);
+	k = waitpid(-1, NULL, 0);
+	ASSERT_EQ(k, -1);
+	ASSERT_EQ(errno, ECHILD);
+}
+
+/*
+ * Same test as previous, except that
+ * the group leader is ptraced first,
+ * but this time with PTRACE_O_TRACEEXIT,
+ * and the thread that does execve is
+ * not yet ptraced.  This exercises the
+ * code block in de_thread where the
+ * if (!thread_group_leader(tsk)) {
+ * is executed and enters a wait state.
+ */
+static long thread2_tid;
+static void *thread2(void *arg)
+{
+	thread2_tid = syscall(__NR_gettid);
+	sleep(2);
+	execlp("false", "false", NULL);
+	return NULL;
+}
+
+TEST(attach2)
+{
+	int s, k, pid = fork();
+
+	if (!pid) {
+		pthread_t pt;
+
+		pthread_create(&pt, NULL, thread2, NULL);
+		pthread_join(pt, NULL);
+		return;
+	}
+
 	sleep(1);
 	k = ptrace(PTRACE_ATTACH, pid, 0L, 0L);
 	ASSERT_EQ(k, 0);
@@ -72,12 +153,46 @@ TEST(attach)
 	ASSERT_EQ(k, pid);
 	ASSERT_EQ(WIFSTOPPED(s), 1);
 	ASSERT_EQ(WSTOPSIG(s), SIGSTOP);
-	k = ptrace(PTRACE_DETACH, pid, 0L, 0L);
+	k = ptrace(PTRACE_SETOPTIONS, pid, 0L, PTRACE_O_TRACEEXIT);
+	ASSERT_EQ(k, 0);
+	thread2_tid = ptrace(PTRACE_PEEKDATA, pid, &thread2_tid, 0L);
+	ASSERT_NE(thread2_tid, -1);
+	ASSERT_NE(thread2_tid, 0);
+	ASSERT_NE(thread2_tid, pid);
+	k = waitpid(-1, &s, WNOHANG);
+	ASSERT_EQ(k, 0);
+	sleep(2);
+	/* deadlock may happen here */
+	k = ptrace(PTRACE_ATTACH, thread2_tid, 0L, 0L);
+	ASSERT_EQ(k, 0);
+	k = waitpid(-1, &s, WNOHANG);
+	ASSERT_EQ(k, pid);
+	ASSERT_EQ(WIFSTOPPED(s), 1);
+	ASSERT_EQ(WSTOPSIG(s), SIGTRAP);
+	k = waitpid(-1, &s, WNOHANG);
+	ASSERT_EQ(k, 0);
+	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
+	ASSERT_EQ(k, 0);
+	k = waitpid(-1, &s, 0);
+	ASSERT_EQ(k, pid);
+	ASSERT_EQ(WIFSTOPPED(s), 1);
+	ASSERT_EQ(WSTOPSIG(s), SIGTRAP);
+	k = waitpid(-1, &s, WNOHANG);
+	ASSERT_EQ(k, 0);
+	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
+	ASSERT_EQ(k, 0);
+	k = waitpid(-1, &s, 0);
+	ASSERT_EQ(k, pid);
+	ASSERT_EQ(WIFSTOPPED(s), 1);
+	ASSERT_EQ(WSTOPSIG(s), SIGSTOP);
+	k = waitpid(-1, &s, WNOHANG);
+	ASSERT_EQ(k, 0);
+	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
 	ASSERT_EQ(k, 0);
 	k = waitpid(-1, &s, 0);
 	ASSERT_EQ(k, pid);
 	ASSERT_EQ(WIFEXITED(s), 1);
-	ASSERT_EQ(WEXITSTATUS(s), 0);
+	ASSERT_EQ(WEXITSTATUS(s), 1);
 	k = waitpid(-1, NULL, 0);
 	ASSERT_EQ(k, -1);
 	ASSERT_EQ(errno, ECHILD);
-- 
2.39.5


