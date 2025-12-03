Return-Path: <linux-fsdevel+bounces-70554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A116C9F1AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 14:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47D9E4E259D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 13:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308EB2D836A;
	Wed,  3 Dec 2025 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="gSucX2MR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazolkn19011030.outbound.protection.outlook.com [52.103.39.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180802F658E;
	Wed,  3 Dec 2025 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.39.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764767791; cv=fail; b=a0Eptf7tXHsVsAJt2mIv9S/KyJJchR6j0j2rficdGsHW5Qcuktw8sIaJ2lh5UcZ4XE1FfEwilcX+ItRmaXfqJ7brrb4IkXTN7FNUI3ub1GrCQiAE1I+tXK327IvjWeRQGEtTkvDdnTyE1LqmfBYg5Bb+DKjQ5f3CZ/bzkANTejM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764767791; c=relaxed/simple;
	bh=Zi7y8kDtX52guMpdGxHjW54QPQJ/P1cc9zypXyOYFpw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fvsvOpLk1/quokMbI/6EmBLnuMdpNl4z6nDX1CJtILED6Pu4uIdxb8oF6Y+izc0fG296rZQMmEZJ3OLPBY2HgxgMLFa+l65kNYuHz7oI0LjVCqmpk2yQanXF3ejddz/I6VSNHc5mO0sYclSPqZOkJQTThrCwsRJYq0MkFxxNnms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=gSucX2MR; arc=fail smtp.client-ip=52.103.39.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClWTOdMT9eH9okRCP6FEQ6HVp1uy3cUB1mC7ByifoepXGtsyPpvWGJ9kD45OPKZXnZyQS73M9RT2HtHs2+h9TYHLzTxNMrqCQN+7tBrnlbO2F1bRAmikbeaHE8QjMMLa3rt2G4zpPtdpJd0EDwBJA7xEIkSDIkwHbp7i5obTbxXHGUKsqsxTjB+ttGeC3kINCVMmlkCPJCPuPCEYWJe1lsm16GzIIp3T5bw5Cipf4dPae47Yc5ND0z3LETrQOtlSTz5vCSCP89bjURjMbwhz+yRwRc9wdXge7cIWOXypGTbeDPJrcPYeVEazFmoyky9GAs2Vkf6i4sUPPSd5UNcdNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boD+kR2RQRyalADD+eHD0JGp7yqNBUec15stCQBFrdo=;
 b=Cmq4OqvUaMh/5PptoNOf89K5uG3CVv1W/MsvDsHF4RYkEQVfpP9vbdPMhmUDY1M0Cv6xQrp8Z1T40K36XvTGOMLVVfP2qxkHT5EwiJhCjCGVAgXGAoSvpUXBn8R87JkdIHsjloG+YQDXzT84n7MoYdjc5lLiIoOnCwc+Yu/7ogeeKEqv145ejtmB2IIPgbz6bc9X3qrEvDm/RCJ12xgbxjH4izvvqbrS1pZyX5HqegI6FvJ6sBiJF7yZZy0/ayb7QolCTFPFMbDwY9fYN47svVwkxPLOf+ZzbhmDGpH9Nr7OrXDVWRd5ZLzfxSSDUi6qZYIdN6iiK4+znjzz2N249g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boD+kR2RQRyalADD+eHD0JGp7yqNBUec15stCQBFrdo=;
 b=gSucX2MRGlxdVnXjtJ8I4eEdAGu7+pgjG6ypYWyMyMoXkQFDmTQvVWVSfv2hZqKA1ZF/bs8aZrl5JdhIg9POk0gZxeGmyJU1hhPAERlOxOyJ+ZVmae0ExFrUkEqKIhVTi9Am99D8gxUOCG7bE0NjpWkzu4jZw1zJXvkNOnyIHol9UeK5rEzb82IGx6T4JCb/jHHSzBFYbHc5+AdUh7JPvkwfMfc+kW/mH85RZgAE3RY3zPDdSD83mQFWCFA55/TTPMSzN2TyD6pAOzMJn5YS6nbSErFkdZIzB1vbKjfRQZuM1/Q/4UKXKEq6mmHo52V9UxsX+0MKN7caXNoj4HPkJQ==
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4) by VI6PPFFEEBABE75.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:808:1::12b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 13:16:23 +0000
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::dde:411d:b5f2:49]) by GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::dde:411d:b5f2:49%8]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 13:16:22 +0000
Message-ID:
 <GV2PPF74270EBEE90CDCD964F69E806EF58E4D9A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Date: Wed, 3 Dec 2025 14:16:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Are setuid shell scripts safe? (Implied by
 security_bprm_creds_for_exec)
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>
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
 Cyrill Gorcunov <gorcunov@gmail.com>, Eric Dumazet <edumazet@google.com>,
 zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
 Ryan Lee <ryan.lee@canonical.com>, apparmor <apparmor@lists.ubuntu.com>
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
 <6dc556a0a93c18fffec71322bf97441c74b3134e.camel@huaweicloud.com>
 <87v7iqtcev.fsf_-_@email.froward.int.ebiederm.org>
 <dca0f01500f9d6705dccf3b3ef616468b1f53f57.camel@huaweicloud.com>
 <87ms42rq3t.fsf@email.froward.int.ebiederm.org>
Content-Language: en-US
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
In-Reply-To: <87ms42rq3t.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0302.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::8) To GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4)
X-Microsoft-Original-Message-ID:
 <48c3abf9-d80b-489a-a1e3-7593e6c91ba3@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPF74270EBEE:EE_|VI6PPFFEEBABE75:EE_
X-MS-Office365-Filtering-Correlation-Id: 96121e53-5579-4465-da0e-08de326e2789
X-MS-Exchange-SLBlob-MailProps:
	cn60g5V53KM8AUe7PDnmNTykf4/SI5O5glPfIsjkZKAY0cUQJLkoKk6j6edDrT1KvFGUTV+svOJSBZhSn/dUD0hodMKLSAAywQHQpkk3lBcmJ7A6YrRP+1LTR21+5o6D+mXD4d94tgq4xKsk+fpSsA6xMCHkXTNodrCvZOury01SZpXushURizCLWG2sJICnMQMfRvJVTZkl+YIm6dMMuF8KS3y/c6ZVBTlSt52NVex7E0Ks4+u4poLKazVi+nnvf0Whv95X5WQNooVLDQ1/tTGGAIW6Jwf0mOcdvt+FR9HlAnD2F/0MMgVrLz8zp+5C2mfRO1LuvewCJnHpUq4E5rMdiqCZkINZ2T03w5qQUBNLcXEV8rfh0zUdN3JAnvrll7/UVGYIUxacRFIYeLQMib2TG3GRi0ALEmGdkItWjlmoJILr3q9JmiuKLE6SWB1IEwhssCF9B9I4kPIzyCsDk5YMzus3QAU4IbdSE7OGUfJj+vgf5m/2pb91mqO+t4NE/XZ3M78dq8cyV/r7HqtBrnDqnm2yHizDoOKq2CWyyeEPLusDiYfqKk0EzUJIpuuX7kRNhQTAQP4IK7a2tpyEK5kLBBVXrmwAuEFBYMg/COubeidHyWaTvBmeqs1YMHkZ9iVdyFHp65FHJkQE3zYuZUcCauHVy4zrnboZWrNlazgPbSsAmWvX7IaXoxpl75w2VjO3Wj7xI1EtcRvCc3V5iJyJ1mVwJN6XgLe4KTZYZfgMg85z5kg8sQf4+WU0ktJNkUs+LkVBgHb3oMZ6a98wmLrex45Gzhu6QazPAtR277l4Sep5VpaVkVz9mKAUyTW/xqrcLwfSLW9S553H4mtBkkvQRyV+/9zTHJwhEFZojnUngeGjY/kDgQ==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|6090799003|5072599009|51005399006|15080799012|461199028|41001999006|19110799012|21061999006|8060799015|10092599007|12121999013|440099028|3412199025|10035399007|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlhNZkVmN3N1aGd3ZlJoNytJc2NsdCtwN0hoaWErTGswOXdmVmdIUUVuSTVL?=
 =?utf-8?B?WUdUZ2ZmVFN5Q2NPU1NYVXFPRmpRcVIvT1JaZ1BNVjFrdm1jeDI5L0lGaTVX?=
 =?utf-8?B?aDJSaldhand5NmtwbUN5WWpqK1NzeE0vUlJrUVdDcE8ybndYWDErd2NHOThF?=
 =?utf-8?B?anZNRnV5bEpOcFBleEVPN2Rpb0xxTkljWEJhRXRma1ZEaEd2eG5ELzJSZ09l?=
 =?utf-8?B?ZFRWQjBsRkZ0Nkk3MnpNT2ljbWJvYXcrUis0aVB6eHh5aGFVYkNRdlBkaUds?=
 =?utf-8?B?VWY4c3BUTnVGa2JKazM2bnpEL2xLbGZmOVF0ZHFhcnNhQzlOTFkydWFIejQr?=
 =?utf-8?B?M3pYN1RqRlQwL1V6OTdFSWR6TjFGaGowaWRBa2RvZ2RCWUlOc0JJaFBxNjdY?=
 =?utf-8?B?WXZzcG9IRXNDbHF0OHBYandSZll6dUxWWWdtc1poRWFhOSt2cEVnd2V1OWVo?=
 =?utf-8?B?NE90WEhDbXBLcitiNTZMYjNxN2dXZDJzamlCRzdvZERhWmVPVVRMenpCZzBx?=
 =?utf-8?B?SlZHQjc0Q2pjSTMxOFpNWjFSN1NkZ3VNcTlCaDdGVVMybHNERWl6d3NQOHBI?=
 =?utf-8?B?MFNDR2FDQ1lwaldWTW05cHl6bHlnNkZuMTdEc1dsM1hCQklITWlJVkFDcURw?=
 =?utf-8?B?dDNjWUJPbURKRUs4UDRiclBNcnZCaWgvWUsxS000NmkxalFrTWo4K2pVblVy?=
 =?utf-8?B?TERUdzBvaDRhNjVQdDBLYUZNZlJrSHZKemE5aGp1TjFMWmpxVHk2N0lYTG1m?=
 =?utf-8?B?K0tZZEw3NUhuVW9RNU5qVEt5MWdWMlhVaXFSeS9mN0JrZXJ2MWpMRXNsaGY2?=
 =?utf-8?B?QUw1TytQdEJDdDAwMCt2ZXVpTUtyWUN6bHNkbWpIekVta0RwZmxHOUNoZzlZ?=
 =?utf-8?B?VUU2SHZqSUd5ck54cWhVQVFGQlRpOWhTL0oreU9qajJsK25nMUpYdU9ZQnVX?=
 =?utf-8?B?S0lCQ3NudEVBYzNTYVpWaWxFdXdBUkxkMEplVnpiWXhIKzZ4ellaWnNKWTVh?=
 =?utf-8?B?ZzE0M2Y1cHIwWXFibUlZNVVMSlk4TWpCVDJ3N3FuUFVmcStKU0ZqdGQvczNk?=
 =?utf-8?B?SnEzakdqR2FPLy9mNXlsSGdGc2k5YzAxZTJWNVRNVFdRQ3dnYlE1c0pXUjV5?=
 =?utf-8?B?RFhBSUw1Y1NPeVRCb3Bmc2VKNlVJWitoUGZHVEZ3V1Q3SVIwMm91YjJKRUZt?=
 =?utf-8?B?N21NZTU4QU43ZTZVVEwveS9HUmtaQjcyaFUxYTh4Mk9hMUJIdjVnRXR4ZEly?=
 =?utf-8?B?bXlScHNtTnE2MThzdC9RRDJOUFYvRmZ1eTBob2ZkWExOdzlvZ0srTEJTelZs?=
 =?utf-8?B?emZ0dElyR3VicHZIYW5oNkh4SDN4SjdXWmxXTm8yazdGeE5Ib3NCOGJUTXpv?=
 =?utf-8?B?blJTVndSSlpWTDZaYUhLTzk2bU9wd2s4VTBKcEoxUmNHT0l1YkZHSzI1QmFj?=
 =?utf-8?B?QmROM2tROWhKWnVreWRTWjZYeWJnK0JXWEJVM2E2YTVwWmJRS1dKVDQ3ZDQz?=
 =?utf-8?B?NTdYSHhOeGRpOHAwM0Q0MThPUjd5M2NtNVhLOXBabE55UWFTWUo2S1Fkb3Vl?=
 =?utf-8?B?WUU3aTBMNG5uanlkWFZaQW1XMy92UmYxWSt5YXUwU0lUYklQY3IybnNHM1BH?=
 =?utf-8?B?Sy9zaUdaUnYyTjh0RU0rZ01LaHBxL0I5dis5WEkvazE1Sk5HNGlESHBOZUNM?=
 =?utf-8?B?cldkdnJSTEQxb0NnRHdHRHVmSDBuNU41RC9hYjBnbUw3cDFxTlZzemR6dXg1?=
 =?utf-8?B?c3MzS3M1QXpZUHNJRDU0blhzS3JzWk9QVEdVYnE5Zk9TZ21od2s4eWFYS0hE?=
 =?utf-8?Q?TVziMJzpKozTywDixVtEFCzOqF4mXhsPedVf0=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VW05SlYzZ0EwRTNpZ01sV3lyaTNSellBdGJTY3hBdVQzVkNhY2s0QzA5dFM0?=
 =?utf-8?B?NUhjaGJxUE1lTGRGblFpaUxHUmF1V2NjSSt2QXdDZE5SRS96YUd0ZzBoUWZm?=
 =?utf-8?B?L1dLb2VYSHVYTkhnclFVZklacmFpdjVOV2o4Yjg4a0ZSRmdIVTZod1lYWWk2?=
 =?utf-8?B?OEVDc3h4YWlsMVl6Vno3MjViZzdkcjlXOG90UlNta0N1cEVyeXR0MVBFeXo5?=
 =?utf-8?B?U2lQQjZ4NUtqdXZuQ3NaZlpiR2M0bHhadHNoOHl1ZkdyaEQrMGJCUVlIK2N4?=
 =?utf-8?B?MHNLbjZqNUxaNFhFVXRjbHRyL2kyMjZ0WlJlWlVpVkZzRjBVN0lxbCtHQ0p2?=
 =?utf-8?B?RDJ1WVRzWTJtS0Q0bG96UXplSUhmM1VFOGFORkRkVWM1aTBEaEZGeUNYRE53?=
 =?utf-8?B?YU1kUU1Ycm1PYVFnTXdINVRCZ3RBOFZuZU1hMGc5V216WmwzZzZOcjVOK0dm?=
 =?utf-8?B?aDhHeHVIbEZPa0dHRzhkQXVhMFk5WjRhUGRpRGZEVm9NN3Nac2JGak9FaE5X?=
 =?utf-8?B?b2xiSHNZWmdXMVovZmIvWGhodjltTXo2azlxTkcwNTVDVEVvZ3doV2R4NCtJ?=
 =?utf-8?B?RzFvZzBCbzQ3TlB0eWZ1UVpwL09lM3V6UjBqV2N4aDlNYm9haEFFTGpHRVh2?=
 =?utf-8?B?Vi9QeHhhUUc3OFpGTTl1MitoMytQbVplQ002UkJNMStscDlaK3J6ZkovdkY2?=
 =?utf-8?B?L2VGVGtLNmFuS1RKWHBnbUVtQ1dBc09NZldDdjhIeWVZMno2K2xmaXZXYnBy?=
 =?utf-8?B?VDJkejBnUWNYc250VjJWVnByOXBWOEpzcnRORXZsS1EzRzB5dllUMUpCRTQ1?=
 =?utf-8?B?K1VrNGZ2RnQ0MlJXaXQ4RzhGNEdnVWM5dUQ0aEdTZW5lb0R1RVJZRFdHdkFq?=
 =?utf-8?B?L3gyZ1o0Rktlb3Z6STJSVDVTR2R4Q2kvZ1ZEWjdBblE3b0RCTFJCOU80Y0lV?=
 =?utf-8?B?YkFNdElKYlZ2TkpqQTV5elFnTHViVTFBOS9HdWM2aTZqTWVueWlPQ1BLbHZo?=
 =?utf-8?B?alIzcC9PcTdxT0FDbTFIT2FKUXl6TDlWVzJBSVBYcmprL2U5L0g5NG5MUDc3?=
 =?utf-8?B?clJUSm1aT1UyNlYrQ2lkbW5oR1M2NENIL1VHWHphSENYV0RhUmJZZjVTMVlu?=
 =?utf-8?B?NXE4MmNuWDdweWc4ZG1SOVBkbVJCVlAvblRYVHlUemJWU3RhOTkyd3RnTFh1?=
 =?utf-8?B?V3EyRXJ3NWR0dklCb2RpT0wvSGhiUVp5NnlwdllrU0JFTEtjVlZ0bjBOclpk?=
 =?utf-8?B?REl3YTN6QTVxYU4wWUFUNTc2cmFkRHZ3Yy9TYVBBeExVOEhJRWxsMFVPYmJj?=
 =?utf-8?B?cXVUSm95MzRKYStuWDRpejVhZlNkRmwzcWhiQXBEQWE2b01NYkY4akIwUits?=
 =?utf-8?B?TGE0a3FPeHFhMldOQU9LQ1VaSGl1M01oVnJkalV3Ykl4NnZ5R3lTZlREbnAw?=
 =?utf-8?B?TkJCcDh6akRIS3lyZnZSbExxVzR2NnNWTU9lQnVnOFF5WnUwbDNmdExzaXht?=
 =?utf-8?B?ZGd5M2gyL2pKa2RRdTgxSnRGZCtkUDJKVUdKaGhmT0VuVmVmWnJwaFptZGp1?=
 =?utf-8?B?ZGR0WUhsQUtadnJ4eXZrWkh5ZW1XbnVySjRTV1pSNzlZbS96UGhZd0pGVEcw?=
 =?utf-8?B?OGJUT2pkZGFzTytSV2MvME9uS2VqMlFJLytWUVliWUZNeXBDRE5XYzVJNit3?=
 =?utf-8?B?aGNlcUVmdmppMzBMNGpKTG85V2Zjd2g4eXhqL2RsN3JXcDNyYXBBcDZxUGVX?=
 =?utf-8?Q?zXyL09SBBtAdU8qvI7VN0wevaGruRcPh2/qmkTB?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-87dd8.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 96121e53-5579-4465-da0e-08de326e2789
X-MS-Exchange-CrossTenant-AuthSource: GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 13:16:22.7968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI6PPFFEEBABE75

On 12/1/25 19:53, Eric W. Biederman wrote:
> Roberto Sassu <roberto.sassu@huaweicloud.com> writes:
> 
>> On Mon, 2025-12-01 at 10:06 -0600, Eric W. Biederman wrote:
>>> Roberto Sassu <roberto.sassu@huaweicloud.com> writes:
>>>
>>>> + Mimi, linux-integrity (would be nice if we are in CC when linux-
>>>> security-module is in CC).
>>>>
>>>> Apologies for not answering earlier, it seems I don't receive the
>>>> emails from the linux-security-module mailing list (thanks Serge for
>>>> letting me know!).
>>>>
>>>> I see two main effects of this patch. First, the bprm_check_security
>>>> hook implementations will not see bprm->cred populated. That was a
>>>> problem before we made this patch:
>>>>
>>>> https://patchew.org/linux/20251008113503.2433343-1-roberto.sassu@huaweicloud.com/
>>>
>>> Thanks, that is definitely needed.
>>>
>>> Does calling process_measurement(CREDS_CHECK) on only the final file
>>> pass review?  Do you know of any cases where that will break things?
>>
>> We intentionally changed the behavior of CREDS_CHECK to be invoked only
>> for the final file. We are monitoring for bug reports, if we receive
>> complains from people that the patch breaks their expectation we will
>> revisit the issue.
>>
>> Any LSM implementing bprm_check_security looking for brpm->cred would
>> be affected by recalculating the DAC credentials for the final binary.
>>
>>> As it stands I don't think it should be assumed that any LSM has
>>> computed it's final creds until bprm_creds_from_file.  Not just the
>>> uid and gid.
>>
>> Uhm, I can be wrong, but most LSMs calculate their state change in
>> bprm_creds_for_exec (git grep bprm_creds_for_exec|grep LSM_HOOK_INIT).
>>
>>> If the patch you posted for review works that helps sort that mess out.
>>
>> Well, it works because we changed the expectation :)
> 
> I just haven't seen that code land in Linus's tree yet so I am a bit
> cautious in adopting that.  It is definitely needed as the behavior
> of IMA as v6.18 simply does not work in general.
> 
>>>> to work around the problem of not calculating the final DAC credentials
>>>> early enough (well, we actually had to change our CREDS_CHECK hook
>>>> behavior).
>>>>
>>>> The second, I could not check. If I remember well, unlike the
>>>> capability LSM, SELinux/Apparmor/SMACK calculate the final credentials
>>>> based on the first file being executed (thus the script, not the
>>>> interpreter). Is this patch keeping the same behavior despite preparing
>>>> the credentials when the final binary is found?
>>>
>>> The patch I posted was.
>>>
>>> My brain is still reeling from the realization that our security modules
>>> have the implicit assumption that it is safe to calculate their security
>>> information from shell scripts.
>>
>> If I'm interpreting this behavior correctly (please any LSM maintainer
>> could comment on it), the intent is just to transition to a different
>> security context where a different set of rules could apply (since we
>> are executing a script).
>>
>> Imagine if for every script, the security transition is based on the
>> interpreter, it would be hard to differentiate between scripts and
>> associate to the respective processes different security labels.
>>
>>> In the first half of the 90's I remember there was lots of effort to try
>>> and make setuid shell scripts and setuid perl scripts work, and the
>>> final conclusion was it was a lost cause.
>>
>> Definitely I lack a lot of context...
> 
> From the usenet comp.unix.faq that was probably updated in 1994:
>     http://www.faqs.org/faqs/unix-faq/faq/part4/section-7.html
> 
> I have been trying to remember enough details by looking it up, but the
> short version is that one of the big problems is there is a race between
> the kernel doing it's thing and the shell opening the shell script.
> 
> Clever people have been able to take advantage of that race and insert
> arbitrary code in that window for the shell to execute.  All you have to
> do is google for how to find a reproducer if the one in the link above
> is not enough.
> 
>>> Now I look at security_bprm_creds_for_exec and security_bprm_check which
>>> both have the implicit assumption that it is indeed safe to compute the
>>> credentials from a shell script.
>>>
>>> When passing a file descriptor to execat we have
>>> BINPRM_FLAGS_PATH_INACCESSIBLE and use /dev/fd/NNN as the filename
>>> which reduces some of the races.
>>>
>>> However when just plain executing a shell script we pass the filename of
>>> the shell script as a command line argument, and expect the shell to
>>> open the filename again.  This has been a time of check to time of use
>>> race for decades, and one of the reasons we don't have setuid shell
>>> scripts.
>>
>> Yes, it would be really nice to fix it!
> 
> After 30 years I really don't expect that is even a reasonable request.
> 
> I think we are solidly into "Don't do that then", and the LSM security
> hooks are definitely doing that.
> 
> There is the partial solution of passing /dev/fd instead of passing the
> name of the script.  I suspect that would break things.  I don't
> remember why that was never adopted.
> 
> I think even with the TOCTOU race fixed there were other serious issues.
> 
> I really think it behooves any security module people who want to use
> the shell script as the basis of their security decisions to research
> all of the old well known issues and describe how they don't apply.
> 
> All I have energy for is to point out it is broken as is and to start
> moving code down into bprm_creds_from_file to avoid the race.
> 
> Right now as far as I can tell anything based upon the script itself
> is worthless junk so changing that would not be breaking anything that
> wasn't already broken.
> 
>>> Yet the IMA implementation (without the above mentioned patch) assumes
>>> the final creds will be calculated before security_bprm_check is called,
>>> and security_bprm_creds_for_exec busily calculate the final creds.
>>>
>>> For some of the security modules I believe anyone can set any label they
>>> want on a file and they remain secure (At which point I don't understand
>>> the point of having labels on files).  I don't believe that is the case
>>> for selinux, or in general.
>>
>> A simple example for SELinux. Suppose that the parent process has type
>> initrc_t, then the SELinux policy configures the following transitions
>> based on the label of the first file executed (sesearch -T -s initrc_t
>> -c process):
>>
>> type_transition initrc_t NetworkManager_dispatcher_exec_t:process NetworkManager_dispatcher_t;
>> type_transition initrc_t NetworkManager_exec_t:process NetworkManager_t;
>> type_transition initrc_t NetworkManager_initrc_exec_t:process initrc_t;
>> type_transition initrc_t NetworkManager_priv_helper_exec_t:process NetworkManager_priv_helper_t;
>> type_transition initrc_t abrt_dump_oops_exec_t:process abrt_dump_oops_t;
>> type_transition initrc_t abrt_exec_t:process abrt_t;
>> [...]
>>
>> (there are 747 rules in my system).
>>
>> If the transition would be based on the interpreter label, it would be
>> hard to express with rules.
> 
> Which is a problem for the people making the rules engine.  Because
> 30 years of experience with this problem says basing anything on the
> script is already broken.
> 
> I understand the frustration, but it requires a new way of launching
> shell scripts to even begin to make it secure.
> 
>> If the transition does not occur for any reason the parent process
>> policy would still apply, but maybe it would not have the necessary
>> permissions for the execution of the script.
> 
> Yep.
> 
>>> So just to remove the TOCTOU race the security_bprm_creds_for_exec
>>> and security_bprm_check hooks need to be removed, after moving their
>>> code into something like security_bprm_creds_from_file.
>>>
>>> Or am I missing something and even with the TOCTOU race are setuid shell
>>> scripts somehow safe now?
>>
>> Take this with a looot of salt, if there is a TOCTOU race, the script
>> will be executed with a security context that does not belong to it.
>> But the transition already happened. Not sure if it is safe.
> 
> Historically it hasn't been safe.
> 
>> I also don't know how the TOCTOU race could be solved, but I also would
>> like it to be fixed. I'm available to comment on any proposal!
> 
> I am hoping someone who helped put these security hooks where they are
> will speak up, and tell me what I am missing.
> 
> All I have the energy for right now is to point out security policies
> based upon shell scripts appear to be security policies that only
> protect you from well behaved programs.
> 

Hmm, yes, that looks like an issue.

I would have expected the security engine to look at bprm->filenanme
especially in the case, when bprm->interp != bprm->filename,
and check that it is not a sym-link with write-access for the
current user and of course also that the bprm->file is not a regular file
which is writable by the current user, if that is the case I would have expected
the secuity engine to enforce non-new-privs on a SUID executable somehow.


Bernd.


