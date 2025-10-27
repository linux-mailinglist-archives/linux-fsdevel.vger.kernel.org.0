Return-Path: <linux-fsdevel+bounces-65660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CF7C0BF49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 07:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED97D4E57B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 06:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5744A2DC34E;
	Mon, 27 Oct 2025 06:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="eVVkWQbc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazolkn19011028.outbound.protection.outlook.com [52.103.39.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8086A2D46AF;
	Mon, 27 Oct 2025 06:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.39.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761546431; cv=fail; b=nEFC6pku83zDPZnGS511mefQFfyGGhVXMFZPisTV8jNtGtpiVhjQv1GEYEc2rRPhnl0DZ+mrFcm0nr9akEyxLtkJl6K02mEi5WcKXppln47FeaCWw3J+hSw3cF0FS/orUmpcvtsEqEzUNAGOwWEk03sOdgcnH6hsSzeHlZnInME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761546431; c=relaxed/simple;
	bh=jzS0qnmKgPJMLUdA0B9ntRb8bOFImzdEDR9ALglQ8lE=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MGsV/UnjkaVa1esSZ+8rTFJqd6ksz3VheP10r7d4KaRqw1+LZ4B1Tw3S0F2Yi9iiwjnfUnpwLvb4W1vQ3zIyXFUEnHel6AEonslbGZQHpLbrty/AVo15nlwPMOZnQykckEbhT+2O1I/IQreg4qoDeL6bYHly4CwJx00WF/mrdWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=eVVkWQbc; arc=fail smtp.client-ip=52.103.39.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lmim+O7VYVAZGgHgVKY4M2YiUeUl/Dq3KZ6CaHuz+5QQT6qJ3nl7b16ZdsZZTFvs7AkLAY5n8Rf/ceGTQzOT2gQcMJkecWGm8NhmuSpySfZ3ctOK5zko7+zi/noWBdITQVfOh6BTAriaVwF5JjFb8eiSPBq+UZDiO34t73MY43a3BiaepM8EGHjf8CamFUNhJX899CXKssAkphDa+3HcVzvegI/23glqBo2OlAdFJH6dZvbBwTYunDwPTJVSa1lLQ3qHMhfGmqFm8H0k2CryD3plG9liyzAKUCMNkJ87RtLkR9bf7zEWp2SWJAVNE8WrgkzaRs9MNiMymekRxFEMiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuBHRnesUdHAOaeRE7NpO8pzyOY0SxmUp4wIdX1sBFU=;
 b=FHhmwFAlV+StEtqQgaux78/JlIKCd3c/+ip9p9ww2MZI+pD80uHz5mXj5K7iIPaQQED4jziNOgG+uzXfL6bQTf9wNaCPZjNBRGoVtDh5zcUuKwXwCKRWwXfrkKNlRuiaOZphmKTJADz4l0baZPOl3ovHX+DSi1iQGTOTrDRQvujOMrGDn3ui1LMSSAxLCFr3N8fzvqR0fRsc9tLcrj564WfH1eYFzRxQKm5jaaJA9Qsr8Te8xqx+OZt0MHA75GtdRZmiIb88uiXIhMIOPYEN8Wpix2cxK/WCSG8jj66Gj3SNh6dYXzc8KXbArkM9JGHb6qLx1XTubVnMODp5/VefKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuBHRnesUdHAOaeRE7NpO8pzyOY0SxmUp4wIdX1sBFU=;
 b=eVVkWQbcgrQQUMNqht4ubkGGTVup5ac+wDsEfmuo1Q1iXCK4rlmqOARChfwqPwVttS1b5099Y4X/g3uKEJYkqhXxJVLFkI/FUGIbTHISwXk6WmXIqje+LWabsMEfMXWNaIZSQVb4pgWMS05Jjrd0FFacHug+5hGnYdFWpSPum8VqnLEd8IrNqdFJ2IaZzfZzKbasenAq1crWDt245nxm+egK1a78GnkjYgM3J0IPmuTAz9/XbO7fpf1K/ZpbMtlz8myE8pne6RqdPQM4zWqXIveIM6nbImphxHWDrEhly1bXL7mklFVMJaRj/R1003rpiLMlg6yvDOdMOBYCOGxA6A==
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4) by GV4P195MB3096.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:150:2bb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 06:26:38 +0000
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::dde:411d:b5f2:49]) by GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::dde:411d:b5f2:49%7]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 06:26:38 +0000
Message-ID:
 <GV2PPF74270EBEEBC26A8BCBE3AB9A5240CE4FCA@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Date: Mon, 27 Oct 2025 07:26:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17] exec: Fix dead-lock in de_thread with ptrace_attach
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
 Cyrill Gorcunov <gorcunov@gmail.com>, Eric Dumazet <edumazet@google.com>
References: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0376.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::19) To GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4)
X-Microsoft-Original-Message-ID:
 <c344c958-cac8-4d1e-9741-ebc1f88e3c4d@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPF74270EBEE:EE_|GV4P195MB3096:EE_
X-MS-Office365-Filtering-Correlation-Id: b073822d-f108-40b5-0b4e-08de1521c88e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|23021999003|15080799012|19110799012|12121999013|461199028|5072599009|8060799015|6090799003|1602099012|40105399003|4302099013|440099028|3412199025|10035399007|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T21KNXhBSmZMTnl0QzVyYzRrYTBBN0tEVUJlbmsvRi9UOG1WbGJkYXhPWWdl?=
 =?utf-8?B?WnV3bUxKUitmN3l3eHlYR1ZvVWtMVjFpa21CSVFHQ3d4Tmh1VG52ZG5QNGNu?=
 =?utf-8?B?VjIxTjRkc3c5MG9GcVU1NTJPRTYyeGFNZUlaY0Vza2w5Q2VoTHBxYU1kYkZ0?=
 =?utf-8?B?dTM3QTNHNDRVUFRmUUpScEN6T2Z0akk3UmUwL0NCT2pkaUFDZXd1MHlBcTYv?=
 =?utf-8?B?eXNxRXUrdXFyMTBKZWZXR2hZR1Y1SmJFdlpkN2p5c0dxL01vTk1mc3BTdVZV?=
 =?utf-8?B?TmI4TFB2YUNabi9UbWN1b2poU2dpWktJZm1DYXE5TWE3OHNMM3BlQkdxb1JQ?=
 =?utf-8?B?WXFrQ01aeTIyWVZmWU5oTXEyQlNkNXF6eDN4VXV4cEFUSndDZUVQYXFqdE0x?=
 =?utf-8?B?WkVrY1dCcnlQQkFUdHNPcFJHanlBWUd2cDlOQVFrQ2ZTRjBERlhMS01WdUUx?=
 =?utf-8?B?eVhGS1F6K25Ec1B0U0p3d0h6bEhDYnVwRlloUUhEMzMzZ3ltLzRaWnI1azNV?=
 =?utf-8?B?MmVwTHJGZnhOZEJ5NUxDV25PZVBXR2t4SFowNWJLd0NFZGpXM3dMclN0cHht?=
 =?utf-8?B?emZ1THJwNnJlMWxtVVVTRTc2U1hLSzBlNTlkVkplTGZLNUY1ZUlRWWoyaVg4?=
 =?utf-8?B?NWJlbW0wNVJBcTA2bDdHNld3enlWTGZxaGIrWlBXTUN2aXZVSk9UNThLMTcy?=
 =?utf-8?B?ZmxMcERVandXWDM1NmFyRW96bTZZckFLMll0blFQL3ZNYXYrcmlFT0RiQkFX?=
 =?utf-8?B?UW51SnlaUnEyVVdCaktlUFFFOWdXWWlXYWRMZnRvVVpkMjlSZERxZ1JROVN4?=
 =?utf-8?B?VHpSa2VjQzFkb095WENPWSsxeGhJS3p1RGpyaG1SeUk0My9POFMvQUdGL0ZI?=
 =?utf-8?B?SDVWMWxQY1NpSndEcmtCS21PdDg2anJjREhxejhqdVR1U1lhc1d2SHJwNiti?=
 =?utf-8?B?RWJkeGR0Q1U4dnpQQzQ3UFNidUlaZEsrVnNMcjZLd1dJTnRYcng2UkRuYmMw?=
 =?utf-8?B?YkJRb1dDUXYvNjlRa214TXhhVzZaemhVaWtVT2NibG42R2ZnWFZHQWliQk1E?=
 =?utf-8?B?a1dReTNaZ09pUVZBSW1DR0EyQ3l1VkVLV0RYUXVjVHAvbHRya1J1aVZrcWxp?=
 =?utf-8?B?dDFsbzJ4d0orN09RUWxCSFVZaTVJL3llL1hMenM0MXFndEV6ZlhveFVJajMz?=
 =?utf-8?B?aGluRFg5Q1FtK3Z1TERLckxDZ1l1ampTc1hCNUQwdncxUWlKU053NXNzZ0Zv?=
 =?utf-8?B?TUNGcktkaExiWU5uMXhqYjlrc2habGhoaGhjWUh2YnRyUkt1WGcrVGNaMVAw?=
 =?utf-8?B?VVhjQXpOQ3NpeERhZXZoa3RueTdQMW1YTy9BMnJWVmVzMklSOHpYajhXdmRM?=
 =?utf-8?B?Q3FoYkRWbHNoRk1hWlhJL0RYa2NqU2xKZDFoRHVNbVhaMzEyMTNoR1M2alpF?=
 =?utf-8?B?SFVnaVlCTUUzOXQ4WU9kUHRMTlVXWFRncTFPV2RlTk44SmM1SHY2OUk5LzJU?=
 =?utf-8?B?UmVCdlkwNkVEckxSeXBIZ0hBYjB4Y3JwNW9BRkt6NnV2OEZzU1NScDIrb2gx?=
 =?utf-8?B?RnR4cmsxV0NPdVdkRjREMk5lR2wwM08xMm9DOFZvUmtWTTcxekM2ZmZjR1ZO?=
 =?utf-8?B?cE1GZ3JVaVJaOFdGblNsU2FMQWhGZktEMjRkVzVXV0tKaGU3aTRzVkJhYnhl?=
 =?utf-8?B?dHFMZUFpZEZSRGdDVjlIZGtjMEt1UU9BTVNvT210Qyt1eTB6RFNxc0E2YXly?=
 =?utf-8?B?SjJ6SWhOTFd5NUlrc243RmdLY1VmOGlIL0RZemZBajBUR2JEdjRZWW8wUkRy?=
 =?utf-8?B?VVVwVTZBdDVWVHZ6REhvOHNCaVhLU1FUeFM5NmJ5VzYzUVROWm9jWEE1OUVl?=
 =?utf-8?B?NUtaZ1hBcFhZdGlab1UxN3NqUzVUS2o3cnhXaWdDQ0w2SGc9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tjc4Rk9DUTZWMk5adVZHNmhJVkNjV0Vib3Jrc1ZKVzEzYnBqaVlZd2R0c2dv?=
 =?utf-8?B?OWNjZnpyM1hjN0QwSk44NVBzd2lTd0o1UlV4SFVyOVRvS1lvN2NEa09Nb0VY?=
 =?utf-8?B?dlRxUlg0eDB2dzVIZ0RmS1Q5WjdYRnBQdk1Pd0V0MGNvNFZsY01xWnVhNS9u?=
 =?utf-8?B?aW5NNnZhS1dhekE0Y0VqdmJKMTN4eDJyTGYyVmxScFdNNTljdXJGSEE0RnBS?=
 =?utf-8?B?R0o4Qk9TaUpvSFViaVdsWXc0NmluZEtjN3pmWEdyL0VTWTNsZ003TERUdmNE?=
 =?utf-8?B?dmFVaTVXeVpwK3Y2b0FSdnpxdi81MmNxSGE0V1BiZGc4QXRVL2hKeWZwb0V6?=
 =?utf-8?B?Njk1UThoZzR6MWYvZHFyNm5EdGVKTWlTTkwyT0J2Z1FWU084UnFIR2xkYzNJ?=
 =?utf-8?B?ajNUbEJJS0phcTYwNWFCUG9wTzZKTS9oMFB1bm41WmlVSU41M0tlUnRpcUZB?=
 =?utf-8?B?TXR1MEQ5c1AyQmlQM2FKL1g0eThJdEkzWll3Q3NtTkl2R3V3dGdJOW9VV3hs?=
 =?utf-8?B?WmNwTmY3UmwrbG94UFRUOFRQT1pCUWQyU1d4VDNJcjVIRVdNVTlzZ2doUGNC?=
 =?utf-8?B?YVEwT1ZoQ3BlQVdWWHFQTmZVWE9NdEVaa3BCTWFPYnJMT2s2UDBCN0NLRm0x?=
 =?utf-8?B?YkxvK3FZWldCTTdrNXdZRWRnMkFvdVYxcUcwenpETzRsUTF1L3l6RFNpWnlq?=
 =?utf-8?B?U3NFTHhSaWNlN0Jjazh1WXFpRVlFakRlZUdQRllQN1N0Z1hmM1NURWZJZEV6?=
 =?utf-8?B?UnpxOWRqcTBHZ1dlL0dkeGo3UFlJdXdzd2NGalBkNTB5Z09uRDJoYnUrSll1?=
 =?utf-8?B?OWNFKzRBa1N6bVNHbmh2d1gwMnE0UXZQNWk2TTc2aHZNRXRrU2hMenVNdkN4?=
 =?utf-8?B?amRINlJrZmFZb3IrSWlQMHNzTGc2WlFXaDR0Mk5KYzJXc3JuWFBxcHhLT0lx?=
 =?utf-8?B?MzNGbmtlNWRzSWV4Mk13aWh0U1ZnUWJkZHJZaStHRWtwdU1OTHdEZ3l5ZFZE?=
 =?utf-8?B?bHlkNmhlVjFZSWpBU0c0TW4rU0lYQWZyMk1XNVdDRnpEOEpTVCtLQlc4aWhq?=
 =?utf-8?B?eFh6Y0tkSVM5c3p3V0U0ZlAzNFl4ZEQ2UVUxd2k0YTVKT3ErVDNWVE40cGcx?=
 =?utf-8?B?R3Q1bHVPSG5VV0FPVCtlNG41QStBbmVsaldHZ3B0ZDk1V2Q2ZTBVWTJsaWlz?=
 =?utf-8?B?bzdSWmFTYlFDNGVGNGpXUXhOZXlJaEF5a05wS3lIbFlUNGxFWkxMYXkvVTFG?=
 =?utf-8?B?SE5DSE4yRHIvT1RCSjJZVW9jdEp2dVdlRHd0WCttTnFieEJobFhYOTRLeVI2?=
 =?utf-8?B?QzExRnZSVmRpd1lJaDRzVHJQNWFKWjhXTkp5cjdvZUF4WVRreHdFL1ZtWWxR?=
 =?utf-8?B?RUJwNWgvTHFGK0hWWHVuOVZyc052S0FnRVluTXVnWFpyaE5PcVl1TXV6UXJN?=
 =?utf-8?B?QzVmb3NKek5sckQxelZCR3JFeEs1cTdpNjN1a2ZRaWlWd0JjSHdqZlNLdllO?=
 =?utf-8?B?R3J0WWhRS1V1TmNYam91MXVGNER5NWMyMFBuVS9sMWJOU0dVcjZHOVp4Y3Fr?=
 =?utf-8?B?MDU4SlRGZDEwWGd1SFNxSEhLaXp3UzFhYko2L05PMFFEOHZsMmQ5aHFzZlBB?=
 =?utf-8?B?OWR5elFKRTVIcWxJVkdZcDVwMHRkZTZWTkkrT2RzQk9nTThZTFRqT09JVmRq?=
 =?utf-8?B?MFc4OS9WWUhqc0VoQTl0S1NWZkJWK2oyeWRTdFlGSTJveVpwWHNyd0xrMnly?=
 =?utf-8?Q?Ug1Qh+b+YVj945/ax9A+FRDQ3QcacTD45mwgESm?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-87dd8.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b073822d-f108-40b5-0b4e-08de1521c88e
X-MS-Exchange-CrossTenant-AuthSource: GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 06:26:38.1961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4P195MB3096

Hi all,

This is a friendly ping, just a gentle reminder since this series has been around a while.
FYI the patch still applies cleanly to current kernel sources, compiles correctly and
tests are still passed.


Thanks
Bernd.

On 8/21/25 19:34, Bernd Edlinger wrote:
> This introduces signal->exec_bprm, which is used to
> fix the case when at least one of the sibling threads
> is traced, and therefore the trace process may dead-lock
> in ptrace_attach, but de_thread will need to wait for the
> tracer to continue execution.
> 
> The problem happens when a tracer tries to ptrace_attach
> to a multi-threaded process, that does an execve in one of
> the threads at the same time, without doing that in a forked
> sub-process.  That means: There is a race condition, when one
> or more of the threads are already ptraced, but the thread
> that invoked the execve is not yet traced.  Now in this
> case the execve locks the cred_guard_mutex and waits for
> de_thread to complete.  But that waits for the traced
> sibling threads to exit, and those have to wait for the
> tracer to receive the exit signal, but the tracer cannot
> call wait right now, because it is waiting for the ptrace
> call to complete, and this never does not happen.
> The traced process and the tracer are now in a deadlock
> situation, and can only be killed by a fatal signal.
> 
> The solution is to detect this situation and allow
> ptrace_attach to continue by temporarily releasing the
> cred_guard_mutex, while de_thread() is still waiting for
> traced zombies to be eventually released by the tracer.
> In the case of the thread group leader we only have to wait
> for the thread to become a zombie, which may also need
> co-operation from the tracer due to PTRACE_O_TRACEEXIT.
> 
> When a tracer wants to ptrace_attach a task that already
> is in execve, we simply retry the ptrace_may_access
> check while temporarily installing the new credentials
> and dumpability which are about to be used after execve
> completes.  If the ptrace_attach happens on a thread that
> is a sibling-thread of the thread doing execve, it is
> sufficient to check against the old credentials, as this
> thread will be waited for, before the new credentials are
> installed.
> 
> Other threads die quickly since the cred_guard_mutex is
> released, but a deadly signal is already pending.  In case
> the mutex_lock_killable misses the signal, the non-zero
> current->signal->exec_bprm makes sure they release the
> mutex immediately and return with -ERESTARTNOINTR.
> 
> This means there is no API change, unlike the previous
> version of this patch which was discussed here:
> 
> https://lore.kernel.org/lkml/b6537ae6-31b1-5c50-f32b-8b8332ace882@hotmail.de/
> 
> See tools/testing/selftests/ptrace/vmaccess.c
> for a test case that gets fixed by this change.
> 
> Note that since the test case was originally designed to
> test the ptrace_attach returning an error in this situation,
> the test expectation needed to be adjusted, to allow the
> API to succeed at the first attempt.
> 
> Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
> ---
>  fs/exec.c                                 |  69 ++++++++---
>  fs/proc/base.c                            |   6 +
>  include/linux/cred.h                      |   1 +
>  include/linux/sched/signal.h              |  18 +++
>  kernel/cred.c                             |  30 ++++-
>  kernel/ptrace.c                           |  32 +++++
>  kernel/seccomp.c                          |  12 +-
>  tools/testing/selftests/ptrace/vmaccess.c | 135 ++++++++++++++++++++--
>  8 files changed, 266 insertions(+), 37 deletions(-)
> 
> v10: Changes to previous version, make the PTRACE_ATTACH
> return -EAGAIN, instead of execve return -ERESTARTSYS.
> Added some lessions learned to the description.
> 
> v11: Check old and new credentials in PTRACE_ATTACH again without
> changing the API.
> 
> Note: I got actually one response from an automatic checker to the v11 patch,
> 
> https://lore.kernel.org/lkml/202107121344.wu68hEPF-lkp@intel.com/
> 
> which is complaining about:
> 
>>>>> kernel/ptrace.c:425:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const *old_cred @@     got struct cred const [noderef] __rcu *real_cred @@
> 
>    417			struct linux_binprm *bprm = task->signal->exec_bprm;
>    418			const struct cred *old_cred;
>    419			struct mm_struct *old_mm;
>    420	
>    421			retval = down_write_killable(&task->signal->exec_update_lock);
>    422			if (retval)
>    423				goto unlock_creds;
>    424			task_lock(task);
>  > 425			old_cred = task->real_cred;
> 
> v12: Essentially identical to v11.
> 
> - Fixed a minor merge conflict in linux v5.17, and fixed the
> above mentioned nit by adding __rcu to the declaration.
> 
> - re-tested the patch with all linux versions from v5.11 to v6.6
> 
> v10 was an alternative approach which did imply an API change.
> But I would prefer to avoid such an API change.
> 
> The difficult part is getting the right dumpability flags assigned
> before de_thread starts, hope you like this version.
> If not, the v10 is of course also acceptable.
> 
> v13: Fixed duplicated Return section in function header of
> is_dumpability_changed which was reported by the kernel test robot
> 
> v14: rebased to v6.7, refreshed and retested.
> And added a more detailed description of the actual bug.
> 
> v15: rebased to v6.8-rc1, addressed some review comments.
> Split the test case vmaccess into vmaccess1 and vmaccess2
> to improve overall test coverage.
> 
> v16: rebased to 6.17-rc2, fixed some minor merge conflicts.
> 
> v17: avoid use of task->in_execve in ptrace_attach.
> 
> 
> Thanks
> Bernd.
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 2a1e5e4042a1..31c6ceaa5f69 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -905,11 +905,13 @@ static int exec_mmap(struct mm_struct *mm)
>  	return 0;
>  }
>  
> -static int de_thread(struct task_struct *tsk)
> +static int de_thread(struct task_struct *tsk, struct linux_binprm *bprm)
>  {
>  	struct signal_struct *sig = tsk->signal;
>  	struct sighand_struct *oldsighand = tsk->sighand;
>  	spinlock_t *lock = &oldsighand->siglock;
> +	struct task_struct *t;
> +	bool unsafe_execve_in_progress = false;
>  
>  	if (thread_group_empty(tsk))
>  		goto no_thread_group;
> @@ -932,6 +934,19 @@ static int de_thread(struct task_struct *tsk)
>  	if (!thread_group_leader(tsk))
>  		sig->notify_count--;
>  
> +	for_other_threads(tsk, t) {
> +		if (unlikely(t->ptrace)
> +		    && (t != tsk->group_leader || !t->exit_state))
> +			unsafe_execve_in_progress = true;
> +	}
> +
> +	if (unlikely(unsafe_execve_in_progress)) {
> +		spin_unlock_irq(lock);
> +		sig->exec_bprm = bprm;
> +		mutex_unlock(&sig->cred_guard_mutex);
> +		spin_lock_irq(lock);
> +	}
> +
>  	while (sig->notify_count) {
>  		__set_current_state(TASK_KILLABLE);
>  		spin_unlock_irq(lock);
> @@ -1021,6 +1036,11 @@ static int de_thread(struct task_struct *tsk)
>  		release_task(leader);
>  	}
>  
> +	if (unlikely(unsafe_execve_in_progress)) {
> +		mutex_lock(&sig->cred_guard_mutex);
> +		sig->exec_bprm = NULL;
> +	}
> +
>  	sig->group_exec_task = NULL;
>  	sig->notify_count = 0;
>  
> @@ -1032,6 +1052,11 @@ static int de_thread(struct task_struct *tsk)
>  	return 0;
>  
>  killed:
> +	if (unlikely(unsafe_execve_in_progress)) {
> +		mutex_lock(&sig->cred_guard_mutex);
> +		sig->exec_bprm = NULL;
> +	}
> +
>  	/* protects against exit_notify() and __exit_signal() */
>  	read_lock(&tasklist_lock);
>  	sig->group_exec_task = NULL;
> @@ -1114,13 +1139,31 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	 */
>  	trace_sched_prepare_exec(current, bprm);
>  
> +	/* If the binary is not readable then enforce mm->dumpable=0 */
> +	would_dump(bprm, bprm->file);
> +	if (bprm->have_execfd)
> +		would_dump(bprm, bprm->executable);
> +
> +	/*
> +	 * Figure out dumpability. Note that this checking only of current
> +	 * is wrong, but userspace depends on it. This should be testing
> +	 * bprm->secureexec instead.
> +	 */
> +	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
> +	    is_dumpability_changed(current_cred(), bprm->cred) ||
> +	    !(uid_eq(current_euid(), current_uid()) &&
> +	      gid_eq(current_egid(), current_gid())))
> +		set_dumpable(bprm->mm, suid_dumpable);
> +	else
> +		set_dumpable(bprm->mm, SUID_DUMP_USER);
> +
>  	/*
>  	 * Ensure all future errors are fatal.
>  	 */
>  	bprm->point_of_no_return = true;
>  
>  	/* Make this the only thread in the thread group */
> -	retval = de_thread(me);
> +	retval = de_thread(me, bprm);
>  	if (retval)
>  		goto out;
>  	/* see the comment in check_unsafe_exec() */
> @@ -1144,11 +1187,6 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	if (retval)
>  		goto out;
>  
> -	/* If the binary is not readable then enforce mm->dumpable=0 */
> -	would_dump(bprm, bprm->file);
> -	if (bprm->have_execfd)
> -		would_dump(bprm, bprm->executable);
> -
>  	/*
>  	 * Release all of the old mmap stuff
>  	 */
> @@ -1210,18 +1248,6 @@ int begin_new_exec(struct linux_binprm * bprm)
>  
>  	me->sas_ss_sp = me->sas_ss_size = 0;
>  
> -	/*
> -	 * Figure out dumpability. Note that this checking only of current
> -	 * is wrong, but userspace depends on it. This should be testing
> -	 * bprm->secureexec instead.
> -	 */
> -	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
> -	    !(uid_eq(current_euid(), current_uid()) &&
> -	      gid_eq(current_egid(), current_gid())))
> -		set_dumpable(current->mm, suid_dumpable);
> -	else
> -		set_dumpable(current->mm, SUID_DUMP_USER);
> -
>  	perf_event_exec();
>  
>  	/*
> @@ -1361,6 +1387,11 @@ static int prepare_bprm_creds(struct linux_binprm *bprm)
>  	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
>  		return -ERESTARTNOINTR;
>  
> +	if (unlikely(current->signal->exec_bprm)) {
> +		mutex_unlock(&current->signal->cred_guard_mutex);
> +		return -ERESTARTNOINTR;
> +	}
> +
>  	bprm->cred = prepare_exec_creds();
>  	if (likely(bprm->cred))
>  		return 0;
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 62d35631ba8c..e5bcf812cee0 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2838,6 +2838,12 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
>  	if (rv < 0)
>  		goto out_free;
>  
> +	if (unlikely(current->signal->exec_bprm)) {
> +		mutex_unlock(&current->signal->cred_guard_mutex);
> +		rv = -ERESTARTNOINTR;
> +		goto out_free;
> +	}
> +
>  	rv = security_setprocattr(PROC_I(inode)->op.lsmid,
>  				  file->f_path.dentry->d_name.name, page,
>  				  count);
> diff --git a/include/linux/cred.h b/include/linux/cred.h
> index a102a10f833f..fb0361911489 100644
> --- a/include/linux/cred.h
> +++ b/include/linux/cred.h
> @@ -153,6 +153,7 @@ extern const struct cred *get_task_cred(struct task_struct *);
>  extern struct cred *cred_alloc_blank(void);
>  extern struct cred *prepare_creds(void);
>  extern struct cred *prepare_exec_creds(void);
> +extern bool is_dumpability_changed(const struct cred *, const struct cred *);
>  extern int commit_creds(struct cred *);
>  extern void abort_creds(struct cred *);
>  extern struct cred *prepare_kernel_cred(struct task_struct *);
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 1ef1edbaaf79..3c47d8b55863 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -237,9 +237,27 @@ struct signal_struct {
>  	struct mm_struct *oom_mm;	/* recorded mm when the thread group got
>  					 * killed by the oom killer */
>  
> +	struct linux_binprm *exec_bprm;	/* Used to check ptrace_may_access
> +					 * against new credentials while
> +					 * de_thread is waiting for other
> +					 * traced threads to terminate.
> +					 * Set while de_thread is executing.
> +					 * The cred_guard_mutex is released
> +					 * after de_thread() has called
> +					 * zap_other_threads(), therefore
> +					 * a fatal signal is guaranteed to be
> +					 * already pending in the unlikely
> +					 * event, that
> +					 * current->signal->exec_bprm happens
> +					 * to be non-zero after the
> +					 * cred_guard_mutex was acquired.
> +					 */
> +
>  	struct mutex cred_guard_mutex;	/* guard against foreign influences on
>  					 * credential calculations
>  					 * (notably. ptrace)
> +					 * Held while execve runs, except when
> +					 * a sibling thread is being traced.
>  					 * Deprecated do not use in new code.
>  					 * Use exec_update_lock instead.
>  					 */
> diff --git a/kernel/cred.c b/kernel/cred.c
> index 9676965c0981..0b2822c762df 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -375,6 +375,30 @@ static bool cred_cap_issubset(const struct cred *set, const struct cred *subset)
>  	return false;
>  }
>  
> +/**
> + * is_dumpability_changed - Will changing creds affect dumpability?
> + * @old: The old credentials.
> + * @new: The new credentials.
> + *
> + * If the @new credentials have no elevated privileges compared to the
> + * @old credentials, the task may remain dumpable.  Otherwise we have
> + * to mark the task as undumpable to avoid information leaks from higher
> + * to lower privilege domains.
> + *
> + * Return: True if the task will become undumpable.
> + */
> +bool is_dumpability_changed(const struct cred *old, const struct cred *new)
> +{
> +	if (!uid_eq(old->euid, new->euid) ||
> +	    !gid_eq(old->egid, new->egid) ||
> +	    !uid_eq(old->fsuid, new->fsuid) ||
> +	    !gid_eq(old->fsgid, new->fsgid) ||
> +	    !cred_cap_issubset(old, new))
> +		return true;
> +
> +	return false;
> +}
> +
>  /**
>   * commit_creds - Install new credentials upon the current task
>   * @new: The credentials to be assigned
> @@ -403,11 +427,7 @@ int commit_creds(struct cred *new)
>  	get_cred(new); /* we will require a ref for the subj creds too */
>  
>  	/* dumpability changes */
> -	if (!uid_eq(old->euid, new->euid) ||
> -	    !gid_eq(old->egid, new->egid) ||
> -	    !uid_eq(old->fsuid, new->fsuid) ||
> -	    !gid_eq(old->fsgid, new->fsgid) ||
> -	    !cred_cap_issubset(old, new)) {
> +	if (is_dumpability_changed(old, new)) {
>  		if (task->mm)
>  			set_dumpable(task->mm, suid_dumpable);
>  		task->pdeath_signal = 0;
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 75a84efad40f..230298817dbf 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -20,6 +20,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/ptrace.h>
>  #include <linux/security.h>
> +#include <linux/binfmts.h>
>  #include <linux/signal.h>
>  #include <linux/uio.h>
>  #include <linux/audit.h>
> @@ -453,6 +454,28 @@ static int ptrace_attach(struct task_struct *task, long request,
>  				return retval;
>  		}
>  
> +		if (unlikely(task == task->signal->group_exec_task)) {
> +			retval = down_write_killable(&task->signal->exec_update_lock);
> +			if (retval)
> +				return retval;
> +
> +			scoped_guard (task_lock, task) {
> +				struct linux_binprm *bprm = task->signal->exec_bprm;
> +				const struct cred __rcu *old_cred = task->real_cred;
> +				struct mm_struct *old_mm = task->mm;
> +
> +				rcu_assign_pointer(task->real_cred, bprm->cred);
> +				task->mm = bprm->mm;
> +				retval = __ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS);
> +				rcu_assign_pointer(task->real_cred, old_cred);
> +				task->mm = old_mm;
> +			}
> +
> +			up_write(&task->signal->exec_update_lock);
> +			if (retval)
> +				return retval;
> +		}
> +
>  		scoped_guard (write_lock_irq, &tasklist_lock) {
>  			if (unlikely(task->exit_state))
>  				return -EPERM;
> @@ -488,6 +511,14 @@ static int ptrace_traceme(void)
>  {
>  	int ret = -EPERM;
>  
> +	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
> +		return -ERESTARTNOINTR;
> +
> +	if (unlikely(current->signal->exec_bprm)) {
> +		mutex_unlock(&current->signal->cred_guard_mutex);
> +		return -ERESTARTNOINTR;
> +	}
> +
>  	write_lock_irq(&tasklist_lock);
>  	/* Are we already being traced? */
>  	if (!current->ptrace) {
> @@ -503,6 +534,7 @@ static int ptrace_traceme(void)
>  		}
>  	}
>  	write_unlock_irq(&tasklist_lock);
> +	mutex_unlock(&current->signal->cred_guard_mutex);
>  
>  	return ret;
>  }
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 41aa761c7738..d61fc275235a 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1994,9 +1994,15 @@ static long seccomp_set_mode_filter(unsigned int flags,
>  	 * Make sure we cannot change seccomp or nnp state via TSYNC
>  	 * while another thread is in the middle of calling exec.
>  	 */
> -	if (flags & SECCOMP_FILTER_FLAG_TSYNC &&
> -	    mutex_lock_killable(&current->signal->cred_guard_mutex))
> -		goto out_put_fd;
> +	if (flags & SECCOMP_FILTER_FLAG_TSYNC) {
> +		if (mutex_lock_killable(&current->signal->cred_guard_mutex))
> +			goto out_put_fd;
> +
> +		if (unlikely(current->signal->exec_bprm)) {
> +			mutex_unlock(&current->signal->cred_guard_mutex);
> +			goto out_put_fd;
> +		}
> +	}
>  
>  	spin_lock_irq(&current->sighand->siglock);
>  
> diff --git a/tools/testing/selftests/ptrace/vmaccess.c b/tools/testing/selftests/ptrace/vmaccess.c
> index 4db327b44586..5d4a65eb5a8d 100644
> --- a/tools/testing/selftests/ptrace/vmaccess.c
> +++ b/tools/testing/selftests/ptrace/vmaccess.c
> @@ -14,6 +14,7 @@
>  #include <signal.h>
>  #include <unistd.h>
>  #include <sys/ptrace.h>
> +#include <sys/syscall.h>
>  
>  static void *thread(void *arg)
>  {
> @@ -23,7 +24,7 @@ static void *thread(void *arg)
>  
>  TEST(vmaccess)
>  {
> -	int f, pid = fork();
> +	int s, f, pid = fork();
>  	char mm[64];
>  
>  	if (!pid) {
> @@ -31,19 +32,42 @@ TEST(vmaccess)
>  
>  		pthread_create(&pt, NULL, thread, NULL);
>  		pthread_join(pt, NULL);
> -		execlp("true", "true", NULL);
> +		execlp("false", "false", NULL);
> +		return;
>  	}
>  
>  	sleep(1);
>  	sprintf(mm, "/proc/%d/mem", pid);
> +	/* deadlock did happen here */
>  	f = open(mm, O_RDONLY);
>  	ASSERT_GE(f, 0);
>  	close(f);
> -	f = kill(pid, SIGCONT);
> -	ASSERT_EQ(f, 0);
> +	f = waitpid(-1, &s, WNOHANG);
> +	ASSERT_NE(f, -1);
> +	ASSERT_NE(f, 0);
> +	ASSERT_NE(f, pid);
> +	ASSERT_EQ(WIFEXITED(s), 1);
> +	ASSERT_EQ(WEXITSTATUS(s), 0);
> +	f = waitpid(-1, &s, 0);
> +	ASSERT_EQ(f, pid);
> +	ASSERT_EQ(WIFEXITED(s), 1);
> +	ASSERT_EQ(WEXITSTATUS(s), 1);
> +	f = waitpid(-1, NULL, 0);
> +	ASSERT_EQ(f, -1);
> +	ASSERT_EQ(errno, ECHILD);
>  }
>  
> -TEST(attach)
> +/*
> + * Same test as previous, except that
> + * we try to ptrace the group leader,
> + * which is about to call execve,
> + * when the other thread is already ptraced.
> + * This exercises the code in de_thread
> + * where it is waiting inside the
> + * while (sig->notify_count) {
> + * loop.
> + */
> +TEST(attach1)
>  {
>  	int s, k, pid = fork();
>  
> @@ -52,19 +76,76 @@ TEST(attach)
>  
>  		pthread_create(&pt, NULL, thread, NULL);
>  		pthread_join(pt, NULL);
> -		execlp("sleep", "sleep", "2", NULL);
> +		execlp("false", "false", NULL);
> +		return;
>  	}
>  
>  	sleep(1);
> +	/* deadlock may happen here */
>  	k = ptrace(PTRACE_ATTACH, pid, 0L, 0L);
> -	ASSERT_EQ(errno, EAGAIN);
> -	ASSERT_EQ(k, -1);
> +	ASSERT_EQ(k, 0);
>  	k = waitpid(-1, &s, WNOHANG);
>  	ASSERT_NE(k, -1);
>  	ASSERT_NE(k, 0);
>  	ASSERT_NE(k, pid);
>  	ASSERT_EQ(WIFEXITED(s), 1);
>  	ASSERT_EQ(WEXITSTATUS(s), 0);
> +	k = waitpid(-1, &s, 0);
> +	ASSERT_EQ(k, pid);
> +	ASSERT_EQ(WIFSTOPPED(s), 1);
> +	ASSERT_EQ(WSTOPSIG(s), SIGTRAP);
> +	k = waitpid(-1, &s, WNOHANG);
> +	ASSERT_EQ(k, 0);
> +	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
> +	ASSERT_EQ(k, 0);
> +	k = waitpid(-1, &s, 0);
> +	ASSERT_EQ(k, pid);
> +	ASSERT_EQ(WIFSTOPPED(s), 1);
> +	ASSERT_EQ(WSTOPSIG(s), SIGSTOP);
> +	k = waitpid(-1, &s, WNOHANG);
> +	ASSERT_EQ(k, 0);
> +	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
> +	ASSERT_EQ(k, 0);
> +	k = waitpid(-1, &s, 0);
> +	ASSERT_EQ(k, pid);
> +	ASSERT_EQ(WIFEXITED(s), 1);
> +	ASSERT_EQ(WEXITSTATUS(s), 1);
> +	k = waitpid(-1, NULL, 0);
> +	ASSERT_EQ(k, -1);
> +	ASSERT_EQ(errno, ECHILD);
> +}
> +
> +/*
> + * Same test as previous, except that
> + * the group leader is ptraced first,
> + * but this time with PTRACE_O_TRACEEXIT,
> + * and the thread that does execve is
> + * not yet ptraced.  This exercises the
> + * code block in de_thread where the
> + * if (!thread_group_leader(tsk)) {
> + * is executed and enters a wait state.
> + */
> +static long thread2_tid;
> +static void *thread2(void *arg)
> +{
> +	thread2_tid = syscall(__NR_gettid);
> +	sleep(2);
> +	execlp("false", "false", NULL);
> +	return NULL;
> +}
> +
> +TEST(attach2)
> +{
> +	int s, k, pid = fork();
> +
> +	if (!pid) {
> +		pthread_t pt;
> +
> +		pthread_create(&pt, NULL, thread2, NULL);
> +		pthread_join(pt, NULL);
> +		return;
> +	}
> +
>  	sleep(1);
>  	k = ptrace(PTRACE_ATTACH, pid, 0L, 0L);
>  	ASSERT_EQ(k, 0);
> @@ -72,12 +153,46 @@ TEST(attach)
>  	ASSERT_EQ(k, pid);
>  	ASSERT_EQ(WIFSTOPPED(s), 1);
>  	ASSERT_EQ(WSTOPSIG(s), SIGSTOP);
> -	k = ptrace(PTRACE_DETACH, pid, 0L, 0L);
> +	k = ptrace(PTRACE_SETOPTIONS, pid, 0L, PTRACE_O_TRACEEXIT);
> +	ASSERT_EQ(k, 0);
> +	thread2_tid = ptrace(PTRACE_PEEKDATA, pid, &thread2_tid, 0L);
> +	ASSERT_NE(thread2_tid, -1);
> +	ASSERT_NE(thread2_tid, 0);
> +	ASSERT_NE(thread2_tid, pid);
> +	k = waitpid(-1, &s, WNOHANG);
> +	ASSERT_EQ(k, 0);
> +	sleep(2);
> +	/* deadlock may happen here */
> +	k = ptrace(PTRACE_ATTACH, thread2_tid, 0L, 0L);
> +	ASSERT_EQ(k, 0);
> +	k = waitpid(-1, &s, WNOHANG);
> +	ASSERT_EQ(k, pid);
> +	ASSERT_EQ(WIFSTOPPED(s), 1);
> +	ASSERT_EQ(WSTOPSIG(s), SIGTRAP);
> +	k = waitpid(-1, &s, WNOHANG);
> +	ASSERT_EQ(k, 0);
> +	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
> +	ASSERT_EQ(k, 0);
> +	k = waitpid(-1, &s, 0);
> +	ASSERT_EQ(k, pid);
> +	ASSERT_EQ(WIFSTOPPED(s), 1);
> +	ASSERT_EQ(WSTOPSIG(s), SIGTRAP);
> +	k = waitpid(-1, &s, WNOHANG);
> +	ASSERT_EQ(k, 0);
> +	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
> +	ASSERT_EQ(k, 0);
> +	k = waitpid(-1, &s, 0);
> +	ASSERT_EQ(k, pid);
> +	ASSERT_EQ(WIFSTOPPED(s), 1);
> +	ASSERT_EQ(WSTOPSIG(s), SIGSTOP);
> +	k = waitpid(-1, &s, WNOHANG);
> +	ASSERT_EQ(k, 0);
> +	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
>  	ASSERT_EQ(k, 0);
>  	k = waitpid(-1, &s, 0);
>  	ASSERT_EQ(k, pid);
>  	ASSERT_EQ(WIFEXITED(s), 1);
> -	ASSERT_EQ(WEXITSTATUS(s), 0);
> +	ASSERT_EQ(WEXITSTATUS(s), 1);
>  	k = waitpid(-1, NULL, 0);
>  	ASSERT_EQ(k, -1);
>  	ASSERT_EQ(errno, ECHILD);


