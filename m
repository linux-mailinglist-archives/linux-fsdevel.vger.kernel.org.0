Return-Path: <linux-fsdevel+bounces-69006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E529C6B25B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 19:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7D196361B8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 18:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E1D35FF63;
	Tue, 18 Nov 2025 18:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="td0OBK46"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazolkn19013076.outbound.protection.outlook.com [52.103.46.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8112D8368;
	Tue, 18 Nov 2025 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.46.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489625; cv=fail; b=OVfFKINMTav8pkVWcnJVb3gtd3uXgRh8gNMOHOYDgOKxyV1GrzPw3/KTKrI87xHo1aYORPKPN2jjFEIqj+9iRchwTwuFzn/K5QZ8SMpvBFF9eiu6FQX9vRE/QKkn7y/HGkJxqUsL7WF5dlLyJm4RESsGOMP278xX0dHsPWpuYT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489625; c=relaxed/simple;
	bh=GCXjqjXap0WA9wazTlq9zHk69gaFUiRciu1FA7jaVm0=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QKJ8e67lWsr57dB8kc+ptwLF64ibGYd0/VxSmQmoH9tzp0NpcikDLDe+0sFjehbaqqf26IErpsneP0OqlVwr0CUWrNY50fcuETWAIhPmCEYdOiiOjz/6h95zpAs4a2ZnNyT90QjrTYA4GAIJ3XdcEg8l/26sOxuRXEw22CkX6fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=td0OBK46; arc=fail smtp.client-ip=52.103.46.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHpzhCCQu1HF7fWx2FuthC0ZusWUuOhCUIIm9cQU5BEvURrm4nBdO/+AQowP5KHvhF/Q42fububW7dWtUvzNDspgcrnPPi4FfVaTlYmeDKUInOAttaj59UphnMTPI2mQJbst/lgLGLFECSBAEiOFfBl7z4l0SJQ48wgi2xn7KVwZxpqz/OCY1uVWR4sJTpD++Q1qsbG3aocCxBx1s3f6tlHos5cn3pMwfepuAerewmPMrZSdOx2u650JJ2Pwv1KVfPOxNTATWzPSQfRudDoyb/TzUkgAcpKtqJcV6acuDu1meQaeGG6NI4oy4OVl1CwTq2xtC5LLFpgv0kY53kN4MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cMP49JB4LTB/5ccIsxKvZ25GPM208mtbFWw66OtZHg=;
 b=hHybUC2wsR0TA3gbdCDGAqs/9t3AVBrEuWDq//QfbzrmPZMZzSj/6AdCD11Hl0oGXH0a9o2rWUlGOzTC3q3L+OewUy/ZHt6Fh/JimxA0chfAMPquOnuY0a375YABVPnlnekhIynVz/qRTc+ponO8ev2L9bMcOVHTXwFgXqNVDNNUirL9M4uWrWC00gupIb2Bkj2FQhD3nQKJUfX2SVv6J7DNSwLFezMQQTAgpHuThI+2sBjckw+joSUfjMnFs5OEap9EseLNz5VK90QNVs/lZ+W+/qotoNpHA3nryzUXPNsaPsrDF/gbEiV714wZW/nlpHkeuaC+VbS9P7iQtMU3dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cMP49JB4LTB/5ccIsxKvZ25GPM208mtbFWw66OtZHg=;
 b=td0OBK46xbpFlsFT8t1gEKKeFzCnKLI7ZBKfaOQNgtzbZ7RxRSAgPw0k5EZkSP0Dg3q7EKAzaCo1HdfGvrGOD0T3tlWbe7M1ehLvWVt61b0S6YXl8kEuQzj76E+tauveb+V2GRFSuDTRyRxDo4pi4khbWCVrDOiuiMZ9gbMlGrbNUZ4h1QHdBhW+iGzRrQoCZzRnQFf4LgSbwu1LCb7Pa3H7Y0XhKDnAx0+e54zZ/TZ6SBVirmBqkqecDAgDx7EUHpWXJFZ5lMxoFPAuxsdYPJnnSiW+BBlGcE+Lay6PEG1TwxaiZOy9cYZFOMLGKh+y5ixqSBSmmuxSNE3nfkHuDQ==
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4) by DB9P195MB1292.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:293::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 18:13:38 +0000
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::dde:411d:b5f2:49]) by GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::dde:411d:b5f2:49%8]) with mapi id 15.20.9320.018; Tue, 18 Nov 2025
 18:13:38 +0000
Message-ID:
 <GV2PPF74270EBEEE807D016A79FE7A2F463E4D6A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Date: Tue, 18 Nov 2025 19:13:33 +0100
User-Agent: Mozilla Thunderbird
Subject: [PATCH v18] exec: Fix dead-lock in de_thread with ptrace_attach
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
X-ClientProxiedBy: FR2P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::14) To GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4)
X-Microsoft-Original-Message-ID:
 <c569a48d-fece-441c-a588-d7d47a780da2@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPF74270EBEE:EE_|DB9P195MB1292:EE_
X-MS-Office365-Filtering-Correlation-Id: 701f150e-5b8b-4e0f-311b-08de26ce31f9
X-MS-Exchange-SLBlob-MailProps:
	obhAqMD0nT/2z34ybd2aajjvmCSBGgf7d5pUJAmJuX8tzEqHeITZkmVpsG9hp05s2nCQWbL++NzOPgW8fOCGCbsrHFAgJIbgYWuLyWCibjscEBb5ak37rDE1iZusA8UcBeUDVu0gNyxDJeXAJsgjBo1/Mwlnk1MrfLgX76jOe+t0RXNXWqS4LG0edBPuz+eBB3iRrdebtD6sSt7bsxzM79ooz0stPh/nA/LyvJekpG8uy5X62cfrCY4AFdA0CU7Rb3Ufq/iT2hkbl42WpmefuUR6WXhgnd/Oc+fEywFPQMohD2u6MzxDn+xNxhKmauEHDs6ZioKYU7Ed7xKyCF6DH5RVz4esP5DFOcoGSb+OGoYxz9qujzWwjA9yoP9z2W8RdAK3Vnz0Hs+NW6A9B8GQp28/UNhpgEPWYJEQNXn66vwUB+2Ff1i2uISI4pUuPsZ1qvfYRJOS9Z5J2/sXyYW2a2z/o6P1ojMpd3OKgXlUB3hHVvAHaO4zeJma/GSjdUtfUzwsVkTomfS8PrQ+VkeKlOcNP45uoS7yVNL5RwfWgHU6emkknvnpGrXFTRRQbm7/b7QQLDBCSiakEe4ShdoBnB0XVGGcsqqTM0tQ887wJSOEHrOVBg9Ybd7rqSlDjCyKV5Q/qJarWIzZs7Ns9yKkJrZ1KL8Lwwp2QMyHGzToDCGvUJCeb6FPAItcvO0WbQdJI3ZBWfFGEhut7fBf61pxK1AjFn6wma1KRxqrx4KEEirUDXerYeMCv2dgLOWKGg6sHUc+zdFOnY2MXgTX4aC9e/npoL0/yDIDW/0DcvCgch8yWtHrGIGV0juuvW8S9J/J
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|23021999003|12121999013|15080799012|5072599009|6090799003|19110799012|41001999006|8060799015|51005399006|1602099012|40105399003|4302099013|3412199025|440099028|10035399007|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXc0R3NSeVhCL2NQeVY3ZG5tM1lZK0hRd3psR2xBenQ4T2FQVEFFM3VDcWJP?=
 =?utf-8?B?eVpXUUhob3NLNDhKblJnRkM0b3dFUmluTi9FOTduc3VBdDhIWENRMWNoOUJQ?=
 =?utf-8?B?a0ZxUGcxMDlwOEtEaUhmS3IyWlhkR0ExUWlEVEJaVHZxKzhGM2hLM1BaeUZm?=
 =?utf-8?B?V2tZSXF0akZoUGV5VmFnUGVYZm9CQjkzVFQ0Y1lVRnlwL01GdjhKVklxZUcw?=
 =?utf-8?B?OWsyT3ZIVU5WTVh4UGhSTFBvS3ZNWko4VXJIdVpDU2R0YU5PYnJWbmptUjcv?=
 =?utf-8?B?OElFNVh6ZTBNdVNvcTBSSG5oWFA2bStEYUdWeXQxa2s0UTZTU09pTU41ZVFU?=
 =?utf-8?B?K3cwZkNEOE9Sb1lSdHFLQXNiSjhhNjZhRm55MzljUFRPUTBOcVRMZXFWTGZ2?=
 =?utf-8?B?ajNNUkY3OWd6cGpHd1Rsdjh6MHdLanBtR0dlMHJsbFUzRWs1em9hWnR5K0NK?=
 =?utf-8?B?V05SL2hDTFZxdk5XYnJTM0FzTUtxUzR0c2JZSTNCTXk2ZmlJU2dWbFdEVG8r?=
 =?utf-8?B?TW8wN3FFTzJGSHZ2c2VkWkFKK2xZNjZEZG5zVGdpSWhrMkY5NXZMVXoySGsz?=
 =?utf-8?B?TU1DREJtektMMk9xai9BVEpYQmZYLzVYbFFKY3FHMGk3ZmtlZlArWFZmK2Zh?=
 =?utf-8?B?d1VDcitTNW85S2tCM3BDMFN2cDY1THhaUHFDSnEveGVlRzI4cHJTWG5ZeVRV?=
 =?utf-8?B?WTNGK211Z3BPbE9ZcGZOSHZuRmF2Z1lab1NybkRvUkNwRTk2TnRKeTBsMHp1?=
 =?utf-8?B?MU5VSkJoM2k3ekE0YXI2YWFoQWJINmlYN2RPOGZ1NVBuSm8xT0VzdU55TjJM?=
 =?utf-8?B?dlZFemVpUGhETW1XYU1kOWdRM3BEdWQxdHlxS2NZNzd1aE15dW9YOUNncFNC?=
 =?utf-8?B?Y2pzT1lQN3RpUXRsVldIR1Bwd3Y4QmMvOFNZaDhhSDVHRXZOc0diOTltdWt3?=
 =?utf-8?B?MFRZSEN2YW5ydFFBVGxwUDZsQXpPL2VBY3gvemJSeFBkS01BQ0RpdU5ycmR1?=
 =?utf-8?B?eXhWckorcSs1cmpaWXJVWU5UZEdIQ2tnODB3U01LdU1ETUMwaXg2dkpXWVY1?=
 =?utf-8?B?L0l3TXEwbjBpc2x0WFk1SThMaXZkcnQvVlFpbVRUQnNCdmdxVncxV2pJeW0r?=
 =?utf-8?B?SjFpTkJ0Y1BzN0JSamZ5T0xBK3N1amQzaXp0WWhZM0VSOWlLejhPRlJpMC8v?=
 =?utf-8?B?WFNveTlieGVzUEJTMFlvM3VGcFIwVXNZRU91dmUvNHU1UElBZ3Z3Sk9SYVMy?=
 =?utf-8?B?ZVh2Q3BCQjZiQ2JZYklFWGNpVlpmOHFvajVpc0dpcGlPdzA4QldZd3FvVVZ4?=
 =?utf-8?B?V1pQeXpWVW02bUlNUisvZjF0V2huNnF2aXJPbWE1ekhLOW5vTjFrZjNDeFcr?=
 =?utf-8?B?SVNXeDhjb3VMUS9RdlE5ZFE4Z1BpTEgxbklSV0dYMWFUVXEvR1Y2TjF0ck43?=
 =?utf-8?B?TWUzOUJMZjJxeVhiZjlidS96TTE2T2Z6czk1QnhLSSt5WWFma3F6YXZzNjVx?=
 =?utf-8?B?dWxTVTEvRTlVUXN4ZzFxSklNZ2h4alFjRGpPRTZjd1ZMWENVV0ttRWs0T3Aw?=
 =?utf-8?B?V2x1WHl5cUtRLzc3LzdlcHczVmFYRWZwODJDM2JxeWV1MzdEU3R3by9SdG8y?=
 =?utf-8?B?OEdXWnRCOSs1QTk0SzROcHBldi93MzNrTFgzQmJuN0ZudDlRODUwNUpndVVv?=
 =?utf-8?B?aGpzNlRCMnZXWFJ4dEkzejg4MVBsRm1xTXFLdEYzeFVDQ3BaS0dGSDlRQms4?=
 =?utf-8?B?RS82eXRIYmJVYjU4UUdWWUtmdVZmSVpKRzJQcUY3aTd3TG9Za3htUlBRRnUw?=
 =?utf-8?B?RUY4dTArb2NrTmNoazBzSHVRTFZGUUloZEJrNEcwVVdLdzVqMkRnKzlMMVhJ?=
 =?utf-8?B?QlNrSzZpdDZKUUFnVzU5NVcxcThDd0hkcFRhVzlyaVdNaVNZNThYOU1rcnNT?=
 =?utf-8?Q?eei2NHkAghjQrXN8c++Elb8knwIVXdti?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTYzZ1lwbVNCTTQ4U0h2OFNGQTNrTlI3cUpNM295UVRYcCt2enJoQ2VHYzk0?=
 =?utf-8?B?UVhxdTh0TFhjVjJlTTE5em9qaHVES0pYSmcwY3YrSWVkZ0hhME1Xd2pxVGZt?=
 =?utf-8?B?VmticEdQT2U3WnpPSDNSMFpZLzFHekJCUG5hcFVaZHJ0dnMxWlpiNFYzbUlm?=
 =?utf-8?B?WEZxbXZkN1RjOXRZM2F5Yyt3d3VnZ01wclpwaVhXUWJJRitwOE94Rnd4TXVw?=
 =?utf-8?B?K3gwOEFoOCtEUTV3ZmtoZmN3dytiejJOZjlZTUkyR09EVDU2cVkvOU0wdGVa?=
 =?utf-8?B?aW5WOTdwZm5XbDdUWSs0Z2tyL3l5TmhUQ21wUzdIQ0ZNREdubWF6ZWc3NkZs?=
 =?utf-8?B?eVNLMW5kbi9zYWFVMmErNEZHRmVxa0RGTmpKVjd2SG15UzhsS2gzZGwwdGps?=
 =?utf-8?B?ZGlUbWVxREVHYlA0NUtFb3VRSTBjOFBqVEtlUVhRZlY4U1h6bW90VThLL1hE?=
 =?utf-8?B?U0ZhRFI3bXdjcmZFNm95dk8xc0hhVjcrRzgrNm4vSlBjeUUyVWpMc291cEZx?=
 =?utf-8?B?cFlvd3QyOTRzWW91N000a1VJd0oyQkZXVGNHb2NPaDdwNWcraEdCT21maElN?=
 =?utf-8?B?U1FmK2lWMGpId3oxNTJmUW9jSXcrekgxMlBpWXpBK08xdEpFSDJxaEFYWTZx?=
 =?utf-8?B?UnBJZXpxS1IrTStpd1AwWllWNTBJSm5YRDZuZEJERnUxcWRJS1luN1ZMWEV0?=
 =?utf-8?B?N1AxTGEvMjdSRXBqSm11TEVpcXNuZ05pZ05vRlI4L3JWUHlxUEZqTDRWSnVS?=
 =?utf-8?B?VHpFQ1MvRG5TbXEvZ0pQYmxEOVJ5NkcvRWF5YXRRc1d5cmJldDlYME53YzU3?=
 =?utf-8?B?MitveTZST25lMWNPSDVzcnQvc3FhZ1N2SEhCY2ZUdGxocHRFdHA1WTZlL3cv?=
 =?utf-8?B?eThEY21wcGxSQml5MHpqekN6aVFyKzBmeU1oTjVBWVVGNGFRcmlCOWhhNE02?=
 =?utf-8?B?VUxHNU01SFpmeGlSb1RUQWtEbzhqOEZsREZLazBLbEhxZ20xUThubTBKeFVh?=
 =?utf-8?B?NWVUVWl2eDVnZjg1QkhOa2U1RG5ONVBYWTB2bmxwUXVzeGRsL2xUTWZDNWhS?=
 =?utf-8?B?VXBhTVlkTE5Bd3A4d215ZTBrMVNoblpNRXZYUUFGT1ZLY2R0SU1NT1dETnZX?=
 =?utf-8?B?dElqd2xlOTRBRGxPSUtJT01HbDVpQVJnMENDeUplWHl2YlBSeWhaVHEwTlY1?=
 =?utf-8?B?TURraGJ5VktJOUhwMk5GalBlMHorQ1RzbW5XbzI4WEVjSVhLd3pObHh2YXdY?=
 =?utf-8?B?V3FCK3NqRC90RmNtVGROLyswejlpU1RGRGFyNWNWYVVhUEpRb3JZNENQdXVo?=
 =?utf-8?B?bGRMTkRRU0xxbDZLMnFtMCtIZUNrQW5SQmdsQ3QxL3BXbnJTTXAzbnJ1d1V2?=
 =?utf-8?B?SkxYelk3QUdId1hyeFE4cDNuVDB5TzFHT3pLWDR2K2E4REhrTTFHNjNiUmMy?=
 =?utf-8?B?NkxvTm1hTmlEVlQ2eXdmMWJLdk5iOUVuMm96Vmk1bzdUM3RCTm56NndRMGY2?=
 =?utf-8?B?R1NNSWU1K2tvcExKNCtPQTI2UTFJdk5aajJiNncxalRPc0hNbmd2VWg4eXVC?=
 =?utf-8?B?b2FhYy9hSGJLRGgyZGYvRzBUb1NRR1F5eVhaZW5JazJVRU8xOHFnaUdJS0Y2?=
 =?utf-8?B?RDhzaXlBVjY1T0tFaDFnNmFSOTR2bGYwYld3WFV6YnlMdzAxQ3Qyb2t6dkQ5?=
 =?utf-8?B?S1lQaUFGVmxHQkxRZjVuUTlzQlcraWdUMW1IQjV5WnF1Ky9LakVzMlBBYk11?=
 =?utf-8?Q?KdocWptILf5deuVJHC2CWTRd5zNov3NU9KOhX49?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-87dd8.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 701f150e-5b8b-4e0f-311b-08de26ce31f9
X-MS-Exchange-CrossTenant-AuthSource: GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 18:13:38.0797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1292

This introduces signal->exec_bprm, which is used to
fix the case when at least one of the sibling threads
is traced, and therefore the trace process may dead-lock
in ptrace_attach, but de_thread will need to wait for the
tracer to continue execution.

The problem happens when a tracer tries to ptrace_attach
to a multi-threaded process, that does an execve in one of
the threads at the same time, without doing that in a forked
sub-process.  That means: There is a race condition, when one
or more of the threads are already ptraced, but the thread
that invoked the execve is not yet traced.  Now in this
case the execve locks the cred_guard_mutex and waits for
de_thread to complete.  But that waits for the traced
sibling threads to exit, and those have to wait for the
tracer to receive the exit signal, but the tracer cannot
call wait right now, because it is waiting for the ptrace
call to complete, and this never does not happen.
The traced process and the tracer are now in a deadlock
situation, and can only be killed by a fatal signal.

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

See tools/testing/selftests/ptrace/vmaccess.c
for a test case that gets fixed by this change.

Note that since the test case was originally designed to
test the ptrace_attach returning an error in this situation,
the test expectation needed to be adjusted, to allow the
API to succeed at the first attempt.

Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
---
 fs/exec.c                                 |  86 +++++++++++---
 fs/proc/base.c                            |  12 ++
 include/linux/cred.h                      |   1 +
 include/linux/ptrace.h                    |   1 +
 include/linux/sched/signal.h              |  18 +++
 kernel/cred.c                             |  30 ++++-
 kernel/ptrace.c                           |  29 ++++-
 kernel/seccomp.c                          |  18 ++-
 security/apparmor/lsm.c                   |   5 +-
 security/commoncap.c                      |   5 +-
 security/landlock/task.c                  |   7 +-
 security/selinux/hooks.c                  |   7 +-
 security/smack/smack_lsm.c                |   5 +-
 security/yama/yama_lsm.c                  |  11 +-
 tools/testing/selftests/ptrace/vmaccess.c | 135 ++++++++++++++++++++--
 15 files changed, 324 insertions(+), 46 deletions(-)

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

v18: Add some more comments, avoid the temporaty impersonation of the
new credentials, and use instead a new option to ptrace_may_access.
All security engines have to handle this option, but the advantage is
that the engines could detect and maybe also deny the unsafe execve.


Thanks
Bernd.

diff --git a/fs/exec.c b/fs/exec.c
index 4298e7e08d5d..02f3e8469125 100644
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
+	 * Note that de_thread may temporarily release the cred_guard_mutex,
+	 * but the credentials are pre-determined in that case and the ptrace
+	 * access check guarantees, that the access permissions of the tracer
+	 * are sufficient to trace the task also with the new credentials.
 	 */
 	security_bprm_committed_creds(bprm);
 
@@ -1361,6 +1408,7 @@ static int prepare_bprm_creds(struct linux_binprm *bprm)
 	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
 		return -ERESTARTNOINTR;
 
+	/* It is not necessary to check current->signal->exec_bprm here. */
 	bprm->cred = prepare_exec_creds();
 	if (likely(bprm->cred))
 		return 0;
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 6299878e3d97..f554c2638ffb 100644
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
index 89ae50ad2ace..4204c19de714 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -153,6 +153,7 @@ extern const struct cred *get_task_cred(struct task_struct *);
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
index 7d6449982822..ade7d7173875 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -241,9 +241,27 @@ struct signal_struct {
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
+					 * Held while execve runs, except when
+					 * a sibling thread is being traced.
 					 * Deprecated do not use in new code.
 					 * Use exec_update_lock instead.
 					 */
diff --git a/kernel/cred.c b/kernel/cred.c
index dbf6b687dc5c..69fd0de813c0 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -375,6 +375,30 @@ static bool cred_cap_issubset(const struct cred *set, const struct cred *subset)
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
@@ -403,11 +427,7 @@ int commit_creds(struct cred *new)
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
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 75a84efad40f..ac750d1ccd04 100644
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
index b3f7a3258a2c..80c2cd968f05 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -129,7 +129,10 @@ static int apparmor_ptrace_access_check(struct task_struct *child,
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
index 6bd4adeb4795..e23a78a4514c 100644
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
index dfc22da42f30..016e21180e96 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2111,7 +2111,12 @@ static int selinux_ptrace_access_check(struct task_struct *child,
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
index af986587841d..5c2ca49baa05 100644
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
index 3d064dd4e03f..8ac9ce41d4f0 100644
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
index 4db327b44586..5d4a65eb5a8d 100644
--- a/tools/testing/selftests/ptrace/vmaccess.c
+++ b/tools/testing/selftests/ptrace/vmaccess.c
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


