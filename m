Return-Path: <linux-fsdevel+bounces-63288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C396BB4179
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 15:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59028162804
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 13:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5E931281F;
	Thu,  2 Oct 2025 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="VBFbx+Sw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022125.outbound.protection.outlook.com [40.107.193.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F3079CD;
	Thu,  2 Oct 2025 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759413216; cv=fail; b=sz9x0ny2xRomKtqhL22+E0X6FditBErbhN2CH2L+y5hzDv3WSvBPN83eBD9XGWj8guk81MnNxzXsxsQ07c6EUsmZolOzirjojcqAJHkhVWQlIF4r+2483uJJww6XDimG8dMTpr8fQMLCeWLQpmVu0k9ys3dJkQ5atVG7D8qQUFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759413216; c=relaxed/simple;
	bh=M0l3YzksD6M2xkrxIY8CnLiVy4KlVjjfHSXgZ3iGH5Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dfiqg4kpSotj5/w4NflY/c0FvgQZYKcphv9DF5hkclceOIqKTpP4lmeEEX8q+T1nCIJ1I2acHYYyG81pUNUxXeCWvFTSAMeSwy5GtPuWiYY6qzgjFggKDTVb482wg08xcjzMbYpDgVdhQUinzWQXZbdn6kD4XpNeg5pjKlQb4Yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=VBFbx+Sw; arc=fail smtp.client-ip=40.107.193.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/paLCf1FLpcxx4pEOZMkBBHLA3GswMAzq0I6k9uu5F33cqr0ZZLPxVlbIpMoYWqUVtgKvpsEZkSJ9A9jiTaf7YjyaACB/IqkWrwZvZ+8hc5nIprXF2cCDuOoMuarvNnB+oDlI/KuB9vJKGrZNewxQvXVjzcmQRWRTZtrzgX3WIkl50xNvd24wJJmfPRjV8LT3wiy2ul4VLqARs+DtDa9LccopKIthV+o6LDS7bWvQTXjO4jT+WsZwRHNRaBUILYQMK+6tRBoxZRjmi0z1mUXOrrbXLjZfumM9SIEo80vrKIPibN1KimxjtoR+4aBtv/1/e1psJrvs3B5uFy2Y3NDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxzvFlJLbR6keAr+O53LqG3GN7TgxhOWpLS+lHurZNQ=;
 b=WLmBWpcbPA9WPmu7/URWLhZTasCAsqUYBQZJFy1CZDSUZUtbSP6zGZQKSwUfnwhmmOpPBf1FiLNfIejdwlWNGYtxv5DLXJVZIqyK1pjwU6oJ30rCr1TaxsDrc44JR0oPHh53lVsamWCtnGbBcZsUgwdfKBQ5Jq62uUZpqhRrTYxHLnz2nu7BfSLAYLjKRy9fnPw3iDF1fk4XsL8aeYC85/PYRq0HILTSftXqg8SY2ZLpHYguakUGpoe0EMh8dl7gbCIyjz1FUDjNfFeSwQ4wjTBdCfnYjk+aJpRjTs6SdonK+w6ZFWbkkw+sjI+vwLfzp0htreNAjaGZs4HmJR3o9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxzvFlJLbR6keAr+O53LqG3GN7TgxhOWpLS+lHurZNQ=;
 b=VBFbx+Sw7kOu3SxTliUz4RLCmCnfgZ7+8nkdyA3aNbXZ4kFKb8I8RR0akUYogdXk5qO8ePjpWoUHjr5HQEQewR02FGtDMauHusTc5O/tSXZXT7gdmG+mRImxA6EPubigGz15h0/M8AMP09vJq3kiHCo6cN5tEEdv8aNTXJLxSFY2IB5DXzntK2CqsaFgrXQwpIPCsN6QhOYyKwZEIaMYT8fskMM2oMDauF0rOoQcqCf98zfQ85enG390zV340Sa8AFNCxm+UzRV70HwJCTTI0j8vqqMxNUdUzYd0kQKIfNO2hG/ljbPM9bvzo+HNZizmvbLyg2kcQwdv2jWP/GjT8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB11606.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:156::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.19; Thu, 2 Oct
 2025 13:53:29 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.9182.015; Thu, 2 Oct 2025
 13:53:29 +0000
Message-ID: <63034035-03e4-4184-afce-7e1a897a90e9@efficios.com>
Date: Thu, 2 Oct 2025 09:53:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 01/47] llist: move llist_{head,node} definition to
 types.h
To: Greg KH <gregkh@linuxfoundation.org>, Byungchul Park <byungchul@sk.com>
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
 linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
 linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
 will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
 joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
 duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
 willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
 kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
 mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org,
 vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com,
 dennis@kernel.org, cl@linux.com, penberg@kernel.org, rientjes@google.com,
 vbabka@suse.cz, ngupta@vflare.org, linux-block@vger.kernel.org,
 josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
 jlayton@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
 djwong@kernel.org, dri-devel@lists.freedesktop.org,
 rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
 hamohammed.sa@gmail.com, harry.yoo@oracle.com, chris.p.wilson@intel.com,
 gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
 boqun.feng@gmail.com, longman@redhat.com, yunseong.kim@ericsson.com,
 ysk@kzalloc.com, yeoreum.yun@arm.com, netdev@vger.kernel.org,
 matthew.brost@intel.com, her0gyugyu@gmail.com, corbet@lwn.net,
 catalin.marinas@arm.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, luto@kernel.org, sumit.semwal@linaro.org,
 gustavo@padovan.org, christian.koenig@amd.com, andi.shyti@kernel.org,
 arnd@arndb.de, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, surenb@google.com, mcgrof@kernel.org, petr.pavlu@suse.com,
 da.gomez@kernel.org, samitolvanen@google.com, paulmck@kernel.org,
 frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
 josh@joshtriplett.org, urezki@gmail.com, jiangshanlai@gmail.com,
 qiang.zhang@linux.dev, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, chuck.lever@oracle.com, neil@brown.name,
 okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org,
 anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de,
 clrkwllms@kernel.org, mark.rutland@arm.com, ada.coupriediaz@arm.com,
 kristina.martsenko@arm.com, wangkefeng.wang@huawei.com, broonie@kernel.org,
 kevin.brodsky@arm.com, dwmw@amazon.co.uk, shakeel.butt@linux.dev,
 ast@kernel.org, ziy@nvidia.com, yuzhao@google.com,
 baolin.wang@linux.alibaba.com, usamaarif642@gmail.com,
 joel.granados@kernel.org, richard.weiyang@gmail.com,
 geert+renesas@glider.be, tim.c.chen@linux.intel.com, linux@treblig.org,
 alexander.shishkin@linux.intel.com, lillian@star-ark.net,
 chenhuacai@kernel.org, francesco@valla.it, guoweikang.kernel@gmail.com,
 link@vivo.com, jpoimboe@kernel.org, masahiroy@kernel.org,
 brauner@kernel.org, thomas.weissschuh@linutronix.de, oleg@redhat.com,
 mjguzik@gmail.com, andrii@kernel.org, wangfushuai@baidu.com,
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-i2c@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-modules@vger.kernel.org, rcu@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20251002081247.51255-1-byungchul@sk.com>
 <20251002081247.51255-2-byungchul@sk.com>
 <2025100230-grafted-alias-22a2@gregkh>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <2025100230-grafted-alias-22a2@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::7) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB11606:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ccd2ba5-2944-4b86-28a1-08de01bb1117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NE5vYWdBRFJGVEQzOStxMWMzOFhNN290aS9pT0IxSDlSMDFBZUt3bXlZVjln?=
 =?utf-8?B?SUNvQ3VmMXBRMzNsOG95TkljaUFLREN2bWZwRXVjUXJjcDZ0VjV5alg1dit4?=
 =?utf-8?B?RmUxUDhxTHVGWjJvS2N3ckMzVUgyMy95RHVyR1hOLzJZVXFiUER5ajIvYWFt?=
 =?utf-8?B?NXlPTk5CdWZ1dWJEMk5EbHZKUExYbWZnajd4b2YybUhEdm14MGVmUE8rdVVs?=
 =?utf-8?B?T1EzbzNzNUQvYVBsYytLd3cxMDdDOUcrQkRDc3Z4em5LTmhnN2pZWmM2ZFY2?=
 =?utf-8?B?NW8zakFYWlZwQisyQjB3QnAydkdWWDJDcldFMmlacThxQUJtMXZyRDJET0xH?=
 =?utf-8?B?VkFXQjN0MnJwZ2NrZHZXc1lZWEFhdklkc0tiRjRXU1o4M1NxTGNjMjdRU21V?=
 =?utf-8?B?cEU5VUJMenVHajhSZ0F2T1BzVHdUMWZrc0t2ZVFLeW9KTVU3c25LYTVjcnZT?=
 =?utf-8?B?K2ZPbEZNWWxsSlhrWkVHSHc0b0wweUt0djk5czYvTHZLUXl5K0swQkF0YmRq?=
 =?utf-8?B?aXpWclNCS0x6WlZ1T205U3A2Wk5GZUl4QUE4Ymt2eWMxTnM2ckxiUU9nL3hu?=
 =?utf-8?B?Z2xsTk1CSjh4ZXBUT2dTUktvM2M0UmZqM2VMQkRvRWNSaWVmekNUZ0pUdTRB?=
 =?utf-8?B?bFdQSWtSWU05ZENiR0NkYzlwUks4Y3J2UXJZUlFKTXhEM2NyQnRoaE9CcWZh?=
 =?utf-8?B?S25KMUZnNCtnTVkwNWEyNXN1dnFWSnJsZnlpMVhMVmFzUXpXN0xJaEt0UkVI?=
 =?utf-8?B?WEU0eEhSUzYrM2E4VGxKMGtMenFTdEs4eDZSZDdzcEZVRzk5SC8wb211TTZF?=
 =?utf-8?B?NFVNNXAwaERtOWtybE9OTFRLekZVRWtvaUpuUGdvUG81UTZWdkVKZVU1MHFo?=
 =?utf-8?B?SDh2K3VNRW9KR0ROT294R2xUdUxsS3JHYXZKbU4vNWUxMVFXc1VTRE16OEg0?=
 =?utf-8?B?Tkk0TXF4QW84Y3YvQ0VuUGFJMTJ5UGU5SDgxNHg3UUg3dy9yR05ISTBxQVEw?=
 =?utf-8?B?cnFmY2p6TzFqNk8reG9HNU5VUkE2ZDhCRWFvcVBnOUpKcEVmeGJZZVVHSXF5?=
 =?utf-8?B?QU8xUVlBVWNmemk0V1NhekRvS210MEdkTW5RZU5GanBOcFVkUGFPdUR4dk1S?=
 =?utf-8?B?bUxSNVltL3ZuWTJqU1Rxd1JQQjVncGI2TTAzd1VZTGF3a2pXbVpzN1ZuS1VU?=
 =?utf-8?B?VVV5WWk1YTh5RE50WWo2NnZ2ekJTUlBTZ3dOdFhua3BNTGJiN0UwY2NrYXY5?=
 =?utf-8?B?QVI2aGRILzBjK0ttMG5LVStMMWs1VG9nQnBDaGlqSHNRektrcW0yM3loRVBr?=
 =?utf-8?B?MEpBZEljNzdUejIwWS9xWk0wVUhHck9Za1RDcGRJQjU3ZmYvclRlL0dJa0Nz?=
 =?utf-8?B?elBvOGc4WFpiVGkrWjlvaXV2L1NqSFB1MGRjKzBFMmdFZERHVkJOM09jdHhF?=
 =?utf-8?B?NHJaTzFRSXZsaGNleVRocUE5aXNYdmdMT09MRDhHdVZ1M1NjeTlDNWtHcDRq?=
 =?utf-8?B?eTNEN3NKQU5WRmxseU1Lc0NsNk1nZkpmekQ5WUFZN0JpQ0kyRnQ5VFVnWHMy?=
 =?utf-8?B?YjU2eXJTQTEzMHVDNG40UVp2aWpva2JNZWprWVJJZExoK0cvOGMzazJOLzRT?=
 =?utf-8?B?S0EyajlQSjBNMTUrckVtUG03eDR5SU82S3NDZG8xakVJYlZyRXZ1TTdydnVB?=
 =?utf-8?B?TWJGeUhuWTVPbUxwblR4RHlMQ2FreGptNnJXUHhmalhBQkVnL3pEM2l5SFgv?=
 =?utf-8?B?WWZvK0gyMW9ScTRRcHY2ejRhV3dSbFBpYlovbEV4akJZMmNEMGlPVnRtQ2p3?=
 =?utf-8?B?cUtxaE8wMzhuZUZ5OExIUGlaNExhaW0zL3FOOGVDYXpkaUMzU1d2dVpxUWZZ?=
 =?utf-8?B?VFlvT0UwYXFXVXNjRnNFZk56R0VFUjl6T3E1dFh3TjhuZHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YitQVG16bTlXMzZIYm1IRldLTG1WamdwZzdZRE9KYkxEUThKNEl6Y3JpNlhL?=
 =?utf-8?B?WWdvdXFpMTZRdnBMK0Nsb3U4WlBIWlhJS3hRbzJzSFk2TUJVeUZjZ0VFUml4?=
 =?utf-8?B?M1M4dnJoZFdXQytkQzBBV053STljYXFIdWU4cmFUR3N3bzkvaWtOZlZFd2V5?=
 =?utf-8?B?cjB4TG4xaW9EaEJFKzZVZG5mSkpwNlBmbStjdDByZDZqaVkvbkU0b3EwY2Zt?=
 =?utf-8?B?K0UrWFRXRi81bjN0bkplaWgzVmtETk9nTFcvYjlzaDkvZXB3REprcFU4UGk0?=
 =?utf-8?B?N0ViMnVqMWorbjh4Zk4ySko4UWErT3RMTGEyTEMvbDV3V0FJNE44QitGVWV0?=
 =?utf-8?B?VWMrOEY0bTVMVnAzTzAwU3pTQ2tlbHpiNVpPUFZmeFZhOUUycmFNTW1OY05B?=
 =?utf-8?B?a1RqZEF5bS8xRFNCK1VBbkdBSkdtSGY1WmdGYzJxTTVRMmJ2R2RnZUhmMlRs?=
 =?utf-8?B?TE1XNUQ4Z2NyYUs0QnlSM25Gc1lwRzVaRUJQd0VjcHlEMjhMMjVLc21DMHNJ?=
 =?utf-8?B?VWJEeE1tMFZGL0ZUMmpjZG1VSE1LMDdESE5jdGRHTWMzUHpNRmFaSWFEL1Zz?=
 =?utf-8?B?UFU1UWE2QkRoQUFxaVRva0tIakplRUh2UWpHalF2QkxESGx3bjhtM0N5aU4w?=
 =?utf-8?B?MFViU0hqdDQ3RTBVY2FrOXVuUGk4Znc0Y0VvSm14SFB5TnFhSGRaVSs2M0ow?=
 =?utf-8?B?Zms5R1pFamI3eW9lTDhTcjlFeG83NlBBL2ZYc1IrVkNZSDEzVWcvNnk4QnJL?=
 =?utf-8?B?OVdqQzRUMjl2RGFZaExwVG1CSlRnRkhocEVQUDBqVzhQYlFUVGMrbG5GYUdu?=
 =?utf-8?B?SFM1blRCa1VFY3EvYWtkYkJxanF2VGpTSVZRVFEvTklzZ09CeXZiU1RZVTZL?=
 =?utf-8?B?aCtSMUJ6NnFFbXlDOWVqbXROREpQcERvUTdXSkhJN0luWWZCTE1hRjBnOVQx?=
 =?utf-8?B?MVlNRVE5UHpuMWdPM3ZmN0dxOVNJVnZhM1FjY0wvMTVWYWJ0NFRCVDNEamVC?=
 =?utf-8?B?T1lwN2lFSndGcFdxanloVWhyRURoaUsxWVFnNkE2Z3hsWGQ1SEVXWUk3WDlw?=
 =?utf-8?B?UFVxTEE3clFGQlVCQWNhQkVOZkhPaWNzZnJFSEh4OURwV0hMMHl2bEtweXJu?=
 =?utf-8?B?L2NIdWk2MGVzeWVtbG1WbjIwSkZaRldQNEtmdEtweWpZWEJwNWJ3L0xSQUlY?=
 =?utf-8?B?UlNNMUJBSFlTdzU4SHo1ZnpZTXI5SGt4VGhtY2t3V1M1WHdKY1RzMUVReTlK?=
 =?utf-8?B?ZmlRNHpoVCt5WGczc3RYT2N5UlppNmREcExPR2FCTi9ZcWtZbGZSMVYxUEh1?=
 =?utf-8?B?K2FHTGZkc2lrbERNUjNpQ3pvL2U4R09HSGl6WGEzZUJWTTRtVDE2VlJCbXRm?=
 =?utf-8?B?ZUlpbk14a3lNWGI0YkJuMWorMXNWNkZhVUJjQ2tqVktha2JCemVvLzVUY2Fz?=
 =?utf-8?B?Q0Jvdi83MnhWdzRlZnRPNGM4V01lTmRLbDlpc2FpdXYrang5K3c4WHN1NE5n?=
 =?utf-8?B?UmIzVWNtMlpScW93NHgwemllVSs0SXFKMHZwUzk2YVNsOG5FeFBGMDdXZUpO?=
 =?utf-8?B?NkYzSGJHQ3VqSkYrWnJKYzkzVkUrS3VIU0c1YjBuaEhHbW9meFpneGZFc3ZD?=
 =?utf-8?B?d0xvWkZjeEtaNUJlbS9LTDRkYm50VWo1ME5RK2pWSXRoeWxSUjNPU1lqUytj?=
 =?utf-8?B?OFVLdUh0aXN4MnJYK1ZaK3NVbmpmMlV1ZU41TndtL0lDWVZWU2pzY3hxcnVy?=
 =?utf-8?B?S3M4UzdKWDRQNnF6bHZnd1pSdmNyTWxRTmFCdzVvL2VMY2t4L2ZoU0U0cDUv?=
 =?utf-8?B?NUxXZlhGT3FRalRPUmNWeXBFeHZ4WjNUZXY4bnQrQmgwMjEzeVNLdEhUZWVN?=
 =?utf-8?B?NWtjdmg3THlHeFpSQ1pxZDhtU29vR2ZDa3BOWWhVRXFXUCtpZDVSeVhIcGhi?=
 =?utf-8?B?VjZrMXlxNVQzSVlmemMxNm54VS9QK2RtMkxpZUhHS1BYb2JVQk5EVDF2T3N3?=
 =?utf-8?B?OUJtVGpucVMyYWFsZHB4Y1NBNzd5eTlaS2loU1Jaam5iQmFJRjNaU0Zsdloz?=
 =?utf-8?B?M1gyRWFVOENDVVZXVkd5ekc2ZnVtaEY0NjFLOElreDg3bG0rTnliR3NoVUJC?=
 =?utf-8?B?NWJ3TzdWRVo1RUtYMUxudXUrRnBPTmducWY1ZzFZSHM5NnJlcFhxYnBjUFlk?=
 =?utf-8?Q?WLrHG+RdhEmrF1PAdTvJ2h8=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ccd2ba5-2944-4b86-28a1-08de01bb1117
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 13:53:29.3661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KXq8xNaZwAkTCHjOPywfS2dnQuk+qkFTICb8zdIjiAC+iX/VETbiLuznN3oTYOHanZMNGNaNOnD8A6MM1x9cHAjBSjaB01sa41yTnGDEabo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB11606

On 2025-10-02 04:24, Greg KH wrote:
> On Thu, Oct 02, 2025 at 05:12:01PM +0900, Byungchul Park wrote:
>> llist_head and llist_node can be used by some other header files.  For
>> example, dept for tracking dependencies uses llist in its header.  To
>> avoid header dependency, move them to types.h.
> 
> If you need llist in your code, then include llist.h.  Don't force all
> types.h users to do so as there is not a dependency in types.h for
> llist.h.
> 
> This patch shouldn't be needed as you are hiding "header dependency" for
> other files.

I agree that moving this into a catch-all types.h is not what we should
aim for.

However, it's a good practice to move the type declarations to a
separate header file, so code that only cares about type and not
implementation of static inline functions can include just that.

Perhaps we can move struct llist_head and struct llist_node to a new
include/linux/llist_types.h instead ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

