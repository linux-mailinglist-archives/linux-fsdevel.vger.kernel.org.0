Return-Path: <linux-fsdevel+bounces-64489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73714BE8941
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 14:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE9E43BFCF3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 12:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7107E3164AF;
	Fri, 17 Oct 2025 12:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="gzgL/a94"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020085.outbound.protection.outlook.com [52.101.191.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F1B1B3937;
	Fri, 17 Oct 2025 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760703907; cv=fail; b=aR1Zs4nSyWm8HlzYV6/LXAti1o921X4ONZJvecTCX+VJxMHBV7AJzXqJRii6Hb9wK1z84AYost5S86TDJah7d5JBwboQlBAGht2YUggRywiRsUkykLJHUIs50DYz7eG2WwvOMy4csTALEUh9xw7v1bhXVy2+8g+Aot5H3A/HxmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760703907; c=relaxed/simple;
	bh=c46VOM4wqaagdH01/lesbqFeSBW1oP8CNOqBP3PN22A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qML7CCutHcjg3T5C5bEt/jICPwVkSKfiFyEQA1XsuXKvOxhWOnzm76TM5SyfgtMqOsdDvGExBKUHGsK7h5EGTV8smKtNS6EWI7IRBfk0F4FXBBVbI0retGkiXYJB721nnS9d9y67iHhfT8Okn4UyNrMnYXX5/tOWRRrMcb8ITZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=gzgL/a94; arc=fail smtp.client-ip=52.101.191.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Djo9K3ZXpCSMnJ+aRBnNbS9X+WqgATpUF4WwCeyp2DdFdvm1J5gAK+dZfF5TFyIK1zYVEdbQXVLCJvED/4zxLCyJtnRNdam+IIU3rJTkMt04yTfAiYCqG7oC1dzwdER8SpKeSziqJ8d9DycTw3gENczcwmUlj0mDowvDFqWZvlazclMSBnWaIP1U211OpmuKjjag5V0zOh3ZFTG4Jdt9SHqmbxgY5Yo+XrnLXxhtW1y183RFDiaKGVlgCOL12u62BA7CfS/VX/rtXS3jZKgrtsA7FAoXZWYFJkbvgeiwYra4vIJWpln+xktMsFNx6RkDaKjoykZUPQRmMJGMXFJCLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kR01a+ZdzG0MgE2rp7hdekzGWEsSJ6PCmmUxupacaiM=;
 b=r0DnX0Qxl22pJ5oFj2fjVpV3TE5KabVaxQPD5DWFSnX+iJUTkX4i5mJcbOGiN018StdqoSrEvmzppJsagR/tG/Due0CqFF75B6ev6tsqfUYCDvlKZ0Q2ZqB6sqJHZJ01qv0XLI4l3H9cPsMfvX/jvEyi2KE38v7r0Jt38KB6qeSJKiOP6AL4BYaOIUEMERnE2u7Cjtpqe4keNm8/uQvHRXXONOVbjKnecqxMXAGZUH6xJzv2jni4Ur3yWmorSX6HHps90guZGmsxTr+fxQkxQ+fplcgxPZBPOJWQUonkRRJWnXbezQTizrsQ397chvSNOcmYH39emln/xrbhIVh0+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kR01a+ZdzG0MgE2rp7hdekzGWEsSJ6PCmmUxupacaiM=;
 b=gzgL/a943xesuplt8tZt87u4RTOBdwMBqbKhTzGw+FofLfzYDIUlQNogNUV+3mjqpQWkS7rgro0nodgTiSsDFXwcsSX4jpU27Jcu2m0VFOgguIkjkqIA7ZwD7BBVHOCD75xNzubpERQMqCMm2gTtdCQnpGVCMfL1xRY8MIIluIICy0smW5fGhai7O2nznxrz/6L6ytNKPrw7MEtlOJ3xi0AFkzoWlv1CKCQHxd6E6dmrbcqo3OyX0XFE32ZQM4hYUswBmHKNFc79HuCOX06HLE/z+Br7LohcVOSzpLcSNKetfVtoV9hZp/C4vdgtONxC/dLesC6S14dAxrcJ5PZf7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PR01MB9018.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 12:25:02 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 12:25:01 +0000
Message-ID: <3a4c9133-0296-4996-b8a9-46350d6b5f66@efficios.com>
Date: Fri, 17 Oct 2025 08:25:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 00/12] uaccess: Provide and use scopes for user masked
 access
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
References: <20251017085938.150569636@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251017085938.150569636@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::14) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PR01MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: 71eb4084-b67a-45be-23c3-08de0d7831da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXJ5ZmlXazBndEpXYWgrM0V6NTdsRllQbUNmd2x3NDJlbHR0ZFlkUUJ3aitF?=
 =?utf-8?B?bncxUzc1VVJxQ29hdjhaRXU0WW9nd1RVeTdXUFk2VHBHekJSNm5tS3NiSXBJ?=
 =?utf-8?B?NmRwRnk3VWhTRmdnWjBkcGVmci94dUp5M0hWL3Ewa1g5SkRnMytlUjlSd011?=
 =?utf-8?B?enI1ZTJGMDdXbTFxWFcremJScHRUd09rbERaNjgzdHM5N20vb0FSc25UYlpT?=
 =?utf-8?B?REllUnJZOXR3c3ZpZTJFN2V4NjFRYng0RDJWSUJWcmpoT3pYOU9HcVdVckZo?=
 =?utf-8?B?enIxRW5pMW1nRlY3TnNiVENKTlpDZnVZakMxUHJwU0g4N3pTd0h6QkpCUko5?=
 =?utf-8?B?c0Uwdlp0dFFNZkRJSWlUTlVGanloSlk4aXozckRYRFhja2lmUGdSQnd1V1BJ?=
 =?utf-8?B?WW1FSTloNXpFaFJsOHA4bENHZTJ5eHR2OEJ6L01DcXdRZ1d4NjFhdlE0V0Yv?=
 =?utf-8?B?YjRqWjgwR21oNHB2bUI2ZWErN0V2TTZINkhocmtZdDZaNFZLWTEvcjY0aU1H?=
 =?utf-8?B?Z3JhY2JjNEJ4bTRhMXl1RERWTkxHY0RZTFFtVTdWR25tNlNQc3ZJRTlvTlc3?=
 =?utf-8?B?VDFzMHMzRkNiL0NiR3Jud0ppYWh2b0tJSTQ1Y2s5MEwrZlJ4Tnd5Wk85N0la?=
 =?utf-8?B?RS9wS1JJbHVlOCtQSFVMeCtLbUhicktRSGdpTHhXTTBHRlpaQXpGcXJ0UjJi?=
 =?utf-8?B?dGZqNFRrRXYzZnlGbkREbVpiS2UzakpOMSswU1hwblNUc1lQdDhWK3B2aith?=
 =?utf-8?B?ZUVYYnRFSlRiNWZTUlVYV0F5Smx6VHZleldQbjZZbWhWRjJKTENBeDZROEZ0?=
 =?utf-8?B?SFUveVhJbW5qeFVXZERBencwMTNpSWlSek9IeTRnM21ZUXN0clVWL3lYM0tY?=
 =?utf-8?B?YXFrVE5vamZqMjhteW5VOFJxUmpVMEhkQ1R3RXZtWEtZWXdvb093aXhVMzdt?=
 =?utf-8?B?WUVXbUl6QUZJR0NjTWVDdUFVbmUwdEdLN2Fuc0hzeGRjNHJjU2RGRmRSeEtC?=
 =?utf-8?B?SVVHMytoWlV0VEEyQkNCYUtuZEZaRGs1VmZzUzhUZjZTcWFzRkJ0YWUzQSty?=
 =?utf-8?B?QmJYZEtueVpxK2VyeTdQQWxSUHBIcHVCZ2toSis5VEdnTWNHeDBRUlVrWlJx?=
 =?utf-8?B?VU5pVEJoMVQrUlducWxEUHovR1ZwQm51T1cxODdRK2R4d0ZoWmkwVGF3V2JU?=
 =?utf-8?B?NVZtbGRqSy9EV0JhWW9tRmR5c3JNYVBSN3BwbnQwanJRMlNHVWtjazFtRmJT?=
 =?utf-8?B?QkFqLzFOVDRSMFJsU05sVzkvWEtKckxxa1pva1RuTHowTXV2UGRQZjN2QTht?=
 =?utf-8?B?NHVmR2FwVU1VbkE2aVNPWjhHbUlmeVhqSVB5MDhFb1llc1FZeG5waXlVdk5D?=
 =?utf-8?B?cGFYZlF4YTNIOFpnanU2Y3lqUFA0UnV2YTdBYlUxbFhraW0vRVRteFE5bFlp?=
 =?utf-8?B?NDBwdStBWTB2Z3M1VFBwZ3FaU09YU3pPVE40dnNDMDIyL1pHVVdQOXprelhJ?=
 =?utf-8?B?NnBXaUpGbDFQeXJRQnp6Vkd2YWlNTWdDOGNaVUJMSE1SOENLcEhnWnl4K3RL?=
 =?utf-8?B?Zmh2REJyeCthR0dVVlhXWUpnTW8veEJEYXZTeXB4MjA3enp3bDN4NE9McXc0?=
 =?utf-8?B?a2V2a2FXaWxpUDAxRXFuc1BXL0NzZGpiK3lsYVpqenJjdFV0cmRrdjEzOXVr?=
 =?utf-8?B?cys3ZG4xYVorZEhOeURlTzUzaU0vNkFVOFhrNEdMQjBDdzBPdVFVa3hNWkhJ?=
 =?utf-8?B?Um9sV0V5M0kwNzZCVzMvbG1FVnNJTkp1YVdaTUZ3cVBxNEVFODNNZnlpdXBu?=
 =?utf-8?B?a1J2K3VZaCs3T1Jick9LdDRkdW14T0phYWdtNlF1d080MU5ZWHdicHptRENU?=
 =?utf-8?B?UGlJU0ZLU29EeUZTQXp2bmsrcjIvL2h4ckVibE9KalgrY2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wmc2aWR1dTd6bjN1WHYrNDI0MzV0RE9zZUxtaEdadHJxVE9OOElIcldmSmh3?=
 =?utf-8?B?ZVVVeUtLdXI2N2lkekY1cVo0RGRhMFFOek5QL3ZJVy9zRFhMZWVpWnl2N2dL?=
 =?utf-8?B?dU9JaUIrYnFsdjhNeWR6N3dtdGxwdVVIdk9DbmR5azVLcVkxNE43bjYwdnhR?=
 =?utf-8?B?cE0rVjF5Yll4eExYT3BWNkN4RVlEN0xHSTlBMUNSZUtyTnA5UTAxZGFGWmMx?=
 =?utf-8?B?RkdCeDhOVkN5ZkorblhMaGlUcXFSNjFPNStQNzZNOHVTNy9CbmJwblFEWDAr?=
 =?utf-8?B?NEpIVVNLSGc4UlJiTlBMb3FjSGpoMlptZnlvOEJkVzMyd1RwckdUZUYwQXJV?=
 =?utf-8?B?di9uNGNQeDlkbmlUcUxHbTZuRWZMYTdua21UcStFUnpYWEY1cHFGOFFzUzVr?=
 =?utf-8?B?TVlvL2RaM0ZjdGJpMjRRNXRFRS8yY1ZDWk0wWUtSL1VIQkw2NmxDMVBEaDhW?=
 =?utf-8?B?R2h6dXZ1eHBKQzlyUk9Sa1kyQzAzQloyMnpWcjgyUWVJbVFsbDBDNjlhMGJV?=
 =?utf-8?B?UHIxdjd2NWtxRUVWQjJSRUgyU1JITGNhelpTMmJ2dnNXRy9nVEFsQjhiSlN5?=
 =?utf-8?B?Z2VPMUdtV3RXRTVGQkp5QlFQd01CYUJJeVNMZ2JNQ2I2Q3JwNmJhSWNXaUps?=
 =?utf-8?B?T0psNjBMczRJMEJyakNmODIxZUt4RW9HamtKcithczIremh1Tmhad1ZmajFm?=
 =?utf-8?B?enI5RnBybUZGdkV6WndtV3ljSlFZUkk5dElSZ05SMmZlTzB5ckpJa2ZvSUsy?=
 =?utf-8?B?VWZxSTdYVlYrTk9FeTYxdm1vdXdkbW1tSkRhM1BGUXNGdjltQmpxVXk2ZXNG?=
 =?utf-8?B?NnhMbnVOMnRmQzZwU3RncEVWYlFDMUgyajNtd1o3UHpDYXlFa2Mzb2kyQWN0?=
 =?utf-8?B?c01vSy9yMXRIdmM3UGh4Q3NTTjVobXNrQWtzbDdnV3pYVDlBYzdqOFdTV2pU?=
 =?utf-8?B?dHQvZXJJTzNyMjlGb3BzVXB1bmNkOU0zU0lVTGVZQ21WQjhzeHNSUmVJNnJE?=
 =?utf-8?B?MXQrMXVqT1Nrc0JpWU1VTC9VdUZrOTNrbk9RN3VUeThpNCtrRGRkbnVJb2dT?=
 =?utf-8?B?NEJuSlRaei9sSFdRMFhOUHBoWk50R2JlV0xqZEJNVWxDWFBseGVBbFhvblhq?=
 =?utf-8?B?anEweEpEZVovYjhLWGlNRkFOMEVNbXh4RXpXZjBtZ1NJSE0vU0c1enRnb3Uv?=
 =?utf-8?B?Yk5XTkpVemxSdWNkaStxK0JsNG8wdWxOYUtOZ1YzczVGT1VJTnRNMHZtMVFr?=
 =?utf-8?B?RktiNVVWTVBud0owNlo0R3k2emlIeFJ1YVZVK2V5WFh4T2kwUW42NXBvNXdT?=
 =?utf-8?B?Q1Q2UlJDZ1gzL05ta1AzYVUybUhPc05JekhLa2pkTm4zRnlYS0ZFTU00cDhK?=
 =?utf-8?B?bXBua2V2MGpPZ1BBN01ieHRET2NXUWxLbUVOZ2t1bU5QQmxadEJEcHlqamRC?=
 =?utf-8?B?S25qamlxUTFDdVRXck5aM0FoTWtUWUZsdkhiSms2UmVCVXp6K3FFUVpFTTZx?=
 =?utf-8?B?N3FhL3NsRVo4bnNXQ0ozWlZOSk11RjVER2ExWXZZMDBJVndBQVdzaS8yWTJy?=
 =?utf-8?B?am9RUmxKWk9zQmJMeEh5VHNLMmw4WnpiZkthdTlmVjcvT0pkSVZDbHQxNS9p?=
 =?utf-8?B?RFNMc1dRZVp2Q3NLS2w4d2Q4WTBNZlJ2c3UyWEtJajVlUDJmU0g5RERWaDFP?=
 =?utf-8?B?c3UwMlE1UGVjMVdGZmZ0ano2K1Jocmw3QzZ4NVJYRFBCejRMZ3Rsam5JeVUz?=
 =?utf-8?B?WVVUZkNvRk9talRyc0NEZG5jdmpkcTNKcnNrcVdUMUg4NWdlTWZ3VEhDM2tT?=
 =?utf-8?B?YmxCcGR4QTNqRXh5RXE4eXRwQXZ1SGE3YmNueFQ5d2NQUXlMRFFtWkdQbEhC?=
 =?utf-8?B?VjRkRjhkcXlhc3U1dWJaSmFJUnQzRC9WcHhoQUhpdlFzMys0QndpeEJxT25h?=
 =?utf-8?B?SHVTVmtIa2dZMGJPVE9LRXliMVFETUdzTDI0cGR3TGdVSzVhN2JTcHNFWFpD?=
 =?utf-8?B?cGswVm5OWEJqSlUyWGxSQTY5Y1dCV0tpT05DNUNvbmREYWRQdmJDcnFuTFVC?=
 =?utf-8?B?TWlpeFNnelZGaW1FU0xkYW50SldObCtmbkNBdUZERzM5OWx4TUM5amtMYkZz?=
 =?utf-8?B?NElaSWZKWUF6V1hNRUhtZ0d6QzBqOUwzWThZUU13cExtQTQzT2F2MWQ3eFBn?=
 =?utf-8?Q?H/4M141eFKvCqBv2iTlCLzc=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71eb4084-b67a-45be-23c3-08de0d7831da
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 12:25:01.8491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pwLCdkEgKxgJGtvZO8Tsmwm9RKgc6rWg8dg+DUo3EtDH5A8jS+DDUqiVtAt9/O2fkUMzCHwPU5yTbEWpyLPC/77YS4IVXS1hAE1CbC3XplQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB9018

On 2025-10-17 06:08, Thomas Gleixner wrote:
> This is a follow up on the V2 feedback:
> 
>     https://lore.kernel.org/20250916163004.674341701@linutronix.de
> 
> The main concern over the V2 implementation was the requirement to have
> the code within the macro itself.
> 
> The main reason for that was the issue with ASM GOTO within a auto cleanup
> scope. Clang refuses to build when the ASM GOTO label is outside of the
> scope and GCC silently miscompiles the code and misses the cleanup.
> 
> After some back and forth discussion Linus suggested to put the local label
> workaround into the user access functions themself.
> 
> The second reason for having this construct was to make the potential
> modification of the pointer (when the architecture supports masking) scope
> local, as that preserves the original pointer for the failure path.
> 
> Andrew thankfully pointed me to nested for() loops and after some head
> scratching I managed to get all of it hidden in that construct.
> 
> So now the scoped access looks like this:
> 
> 	scoped_masked_user_read_access(ptr, efault) {
> 	        // @ptr is aliased. An eventual mask modification is scope local
> 		unsafe_get_user(val, ptr, efault);
> 		...
> 	}

Now we're talking! It indeed looks much more like C now. I'll go review
the implementation.

Thanks,

Mathieu


> 	return 0;
> efault:
>          // @ptr is unmodified
> 	do_stuff(ptr);
> 	return -EFAULT;
> 
> 
> Changes vs. V2:
> 
>      - Fix the unsigned long long pointer issue in ARM get_user() -
>        Christophe, Russell
> 
>      - Provide a generic workaround for the ASM GOTO issue and convert the
>        affected architecture code over - Linus
> 
>      - Reimplement the scoped cleanup magic with nested for() loops - Andrew
> 
>      - Provide variants with size provided by the caller - Mathieu
> 
>      - Add get/put_user_masked() helpers for single read/write access
> 
>      - Fixup the usage in futex, x86. select
> 
>      - A clumsy attempt to implement a coccinelle checker which catches
>        access mismatches, e.g. unsafe_put_user() inside a
>        scoped_masked_user_read_access() region. That needs more thought and
>        more coccinelle foo and is just there for discussion.
> 
> The series is based on v6.18-rc1 and also available from git:
> 
>      git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git uaccess/masked
> 
> Thanks,
> 
> 	tglx
> ---
> Thomas Gleixner (12):
>        ARM: uaccess: Implement missing __get_user_asm_dword()
>        uaccess: Provide ASM GOTO safe wrappers for unsafe_*_user()
>        x86/uaccess: Use unsafe wrappers for ASM GOTO
>        powerpc/uaccess: Use unsafe wrappers for ASM GOTO
>        riscv/uaccess: Use unsafe wrappers for ASM GOTO
>        s390/uaccess: Use unsafe wrappers for ASM GOTO
>        uaccess: Provide scoped masked user access regions
>        uaccess: Provide put/get_user_masked()
>        coccinelle: misc: Add scoped_masked_$MODE_access() checker script
>        futex: Convert to scoped masked user access
>        x86/futex: Convert to scoped masked user access
>        select: Convert to scoped masked user access
> 
> ---
>   arch/arm/include/asm/uaccess.h               |   26 ++
>   arch/powerpc/include/asm/uaccess.h           |    8
>   arch/riscv/include/asm/uaccess.h             |    8
>   arch/s390/include/asm/uaccess.h              |    4
>   arch/x86/include/asm/futex.h                 |   75 ++----
>   arch/x86/include/asm/uaccess.h               |   12 -
>   fs/select.c                                  |   12 -
>   include/linux/uaccess.h                      |  313 ++++++++++++++++++++++++++-
>   kernel/futex/futex.h                         |   37 ---
>   scripts/coccinelle/misc/scoped_uaccess.cocci |  108 +++++++++
>   10 files changed, 497 insertions(+), 106 deletions(-)


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

