Return-Path: <linux-fsdevel+bounces-70238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53A3C9406C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 16:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C2EB3A67A4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 15:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2025430F534;
	Sat, 29 Nov 2025 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="L9Veg0zn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazolkn19013086.outbound.protection.outlook.com [52.103.46.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AA136B;
	Sat, 29 Nov 2025 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.46.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764428820; cv=fail; b=aej+GrIUaekf2fh6VXK0dkdrjNOMdeQCt4zVUhUq+b2NUsLmVOuAC0kRDA5zX9QEgbHAOgzgsl+RP8eDZaGTllWLxrJEDwBC6bc20FBy2KIxuYhYtBMbqLH3dpzLfLV97pTcnFKIn07DTjmE/mlV/vj1URfjwl6zI13odsPGtG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764428820; c=relaxed/simple;
	bh=0JhR4Iq6n4Rw9RQo6j3qbS5Yj/dBV/F6VMhZCNKW1MA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Swfogy662TvHOxDAAcZJs6MYUwm/LktT8wcQYI+u3n202pZPpWb79Tl27U5yrmKQP+J1cWNTd5VqehNIGHgLq9ynKg1Yg6P8/Zns/mcWrm4/FBUVUtMocEjkJ2V2/89oQtI7vIYi9X/fxuoFHTSh6RqiuvjCaWpmjrrHOUwvOjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=L9Veg0zn; arc=fail smtp.client-ip=52.103.46.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lProhl2XBLltTZbxxF8dswgCX5HjdjiBWgcygBojhbzWgtpRZ7HBaFFxPmF5e9bqkBwy7QRtdBUTM44XEVD+FnmUTsmbDQO8SNHjNlS95hC0u1aVXdCYxVKN8a9xnO/s8I/pfnzyFO2l3lFaGFE7i6kfDNdbFwhPaxOV7iY6DXiqFUJPHRah+872hc5mYUVSKw7mbnFcanLZbKBo5WHAWH0wQ6xQtkXEUrDBWGkK944P69xTvWYZDM+MALb26ZoGfj16wkskqxYKVcRG0Ju4OA0bMcEKogjwikFDdi2VcF4TfwYOnyr9+Tbyvb++PEmRrWpXW3I7RTWdBWU6y+/46Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FD/Akzqzu0nThG7Tk3GM5jB/WuJ8kjgjB5LxtcVF1Ms=;
 b=GHYUqMZX9C8GTl2Iu9ygFvXcb/ikJDSKUNwNBLJCX8rdHVefKnc/UGVy6rLoKk8q5TWLZnpeq+jGq4rg8zvt84T1hwMs0E4RK6OkJ3t/NsbMauHWHLrEGQURjn/1FeMw3/xgSRPSq9NAn0Qmfjr8sBBnGzLGUyCmJqC1arZk9ZWvGRYtu5iea/z5jX/wmLtu+vQ6kJN2e/kT0CoF6FfEXxOpNSKmFYQpBCCIKO83nY5M+iQ1ZWPNd1FXZDgHu7QCFIG4GB7JE1XdkXP8U3m1H8TPTbqPnFNkNuCjxzFOLkk4wOVnpiTkuqMhvFGVypr04hN6Fqh2CLkoWOH8FFhnPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FD/Akzqzu0nThG7Tk3GM5jB/WuJ8kjgjB5LxtcVF1Ms=;
 b=L9Veg0znfBf/WerHwl4oj1Ju2uxBnv53RZJIq8FRffcifTso8cccOwhXx7wliBtpdinkpInOBqtWHB/nwWv//Ty3UMtz6t4qxRobxfZAHhqwZBhrTceuFtf0R2m5UqtBEkKYe8K+nWf6sQ/WVN2io9PJs2g34mZ182caS8UENhAdcMTJm06YNBstARpq2zQMe45J2oDHAYdnYusxjcGqJ1NvFg46wXRb4cR6WXcX9XvZkL3UxC94qc8qucB8Eu8h7rSoB18Z+cKxBKT9Y5LxKnvaH1yqB3SLYnuXpqYgUNMcuwL/vq0R+P2kCVrNm8OjVMRsZhaxfOtTnBxoolwzKw==
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4) by DU7PPF6D5AD81E5.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:18:3::bd6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 15:06:54 +0000
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::dde:411d:b5f2:49]) by GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::dde:411d:b5f2:49%8]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 15:06:54 +0000
Message-ID:
 <GV2PPF74270EBEEDD43083BE45C6E26F674E4DDA@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Date: Sat, 29 Nov 2025 16:06:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17] exec: Fix dead-lock in de_thread with ptrace_attach
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
References: <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <20251105143210.GA25535@redhat.com>
 <20251111-ankreiden-augen-eadcf9bbdfaa@brauner>
 <GV2PPF74270EBEE4FE6E639B899D01D8870E4C9A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <aRs4zYDhddBQFiXZ@redhat.com>
 <GV2PPF74270EBEE6F59267B0E9F28F536D0E4C9A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <aSNTNZxiQ0txISJx@redhat.com>
Content-Language: en-US
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
In-Reply-To: <aSNTNZxiQ0txISJx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::17) To GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4)
X-Microsoft-Original-Message-ID:
 <d016b2fe-4640-4c15-8350-9eebfa067d3c@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPF74270EBEE:EE_|DU7PPF6D5AD81E5:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aa02119-ea85-4a83-0e8b-08de2f58ee86
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799012|23021999003|19110799012|8060799015|51005399006|5072599009|6090799003|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1Rhd3NxZFozclkxSkViYWJRZmEzVUR2Z2M2OUEyN3pkclVuRzdLWFhZS0RH?=
 =?utf-8?B?V2dHaFNibGZ0QVpETkdER1lINEswMk1zZWowWmR5YjZxcTVCVEIvTkYyaDJR?=
 =?utf-8?B?WkYyTFdpYjF2dFFpODlJcGp1RjlKckZFekUxU3VhZTUwUHIvM0dKbkRiZnVO?=
 =?utf-8?B?QWloakdQRjJkSkpORGp6N3VEVFltRWkyQ1VhVTlIVDVnYUlnUWV0ZFRSaXBv?=
 =?utf-8?B?bzArZ1dxZjlNWWcvQmhvajFOckhHWitFeHVjRWd4T2lTSnlFQzkyMEdjWDJF?=
 =?utf-8?B?UmdEMUxaV1ZoOVRSZnVPS0xIUWNRbnJHa1A1VGI5ajRzZDlyV205VHh6VFZR?=
 =?utf-8?B?OUlwZTQ0c1h4L1k0U1JMZDNFN1lNanZSUnNsbitFdnFPbnUrUnRIN3dWenUx?=
 =?utf-8?B?UEx0T3ladFBwZWlxRlpxVzQxWWgrRmxMNTlHZm4xOTFBM0JBMG9ySE9kM3gx?=
 =?utf-8?B?SW9yaU5kd3VtWkp6aGFteHFTdUdOdlljRHlmZkk4QTZwMGhVdTdjbFF2SUJk?=
 =?utf-8?B?WllJMGgra1I5WXdxK0MxWUVmM2MzTVFFbkh1MThGRzBLaFluMjZLVjhUVjVY?=
 =?utf-8?B?VWtSWGNGNW0zK3l1cXJKWmNwL2E2aDhYR1UvSVNlVFVVUHphZU9yOGlZOERx?=
 =?utf-8?B?OW9RQzdwTXA5UnRDRjNsazlWWVdHenk4Z2xqZGRobWJWTTBFeHdZcExOTWNN?=
 =?utf-8?B?RzZNaFBSa1dHbWJ6T2hOWVZtd3ZYS3hvV1QwZjU0Z25aNGRMbTV6YnhHeXBF?=
 =?utf-8?B?eU5uMUxsWnhxUFJSWDZpc0E5Y09CZDBOY05MRGRaOG4zS2xnZ1N6bTRCdWxL?=
 =?utf-8?B?Y1pwSER4a0lPYmhTZDErYXNjanJaamFmY2N1Rmc0SzY1UXl4ZGZvejVsZlVV?=
 =?utf-8?B?K2c0czRNempFeFQ0QnNnZWdvM3h6YUhETjc4d2xSYnBEZHZHbXNwMEVVUHFN?=
 =?utf-8?B?NVVUQlZUQW5jTmNNSXFpdGVBTG92K2g1ZHpVc3c0UmdqM25PMC85NGNtd2Fm?=
 =?utf-8?B?VTdKd2hnQllNUlZNa0tqeWpCYVJzdGZwZzJhUHhGajVlWXNxVFgxMXVXVFZV?=
 =?utf-8?B?VGlOb3lvK2hUTU1uSkVRbU1HWTVVa2tLTGl3dk9CV2s0L09Meks4WTZHS2Nl?=
 =?utf-8?B?bUNyYVkwazJRazB3WTJLdk13TExRZDN0UDU0dmtvZEd5VW1mRHFkbk9XdnBG?=
 =?utf-8?B?Q3h5MXhXdExZbURxNi8rVnFseU1IZ25uS25WcEx4bm4wN2xaK1VtZlRjYi95?=
 =?utf-8?B?STgyMHltSStQbCtqdnFja0JyVCtHRHFVWERza0RMalpSWldWWStFYzI0WVRG?=
 =?utf-8?B?TlBtRTdmM2hNQ2FVUHNhUXE5SytLVDYyT3RMSHVLS3ZmMVRCMlMvQ3hUZEpJ?=
 =?utf-8?B?bm9aYm5CS3FnV2dqbDlHWUJxTnAwY295dFkvUXIvS0RmRXdscUxLSFAvV3Ro?=
 =?utf-8?B?TUhVZXhPMUswcUovTVR4UmFEZS80OW55NTVjSG14RTE5dW5CUU4xbDIwTTk5?=
 =?utf-8?B?NitRT1VoVTNteWM5SlFqR3NhSks0UmRUaFBtMWliSXVrSUJBTXhGVno2S1Nu?=
 =?utf-8?B?Sjh2TVpLSEk1a1pSdTRSSGdjb3pqbVdSUnhHTUk0aFFKVWtsZ0RINm5sZ09h?=
 =?utf-8?B?dmlSU29ESi9veHc5V0VkUDlKbi9kWnc9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzY1RVJiMlNHWVkrRy9QOGt3WTBxNkVFcGF6cHFJa2VncWorc0VSL1llQmhW?=
 =?utf-8?B?STVFL1Ruci8yNEU4N25pSTdkTXZtei9mbmg5Y0lteHQ2UEJqOUtBQTRYcTF0?=
 =?utf-8?B?NjhDWHRGZnAzYnRoVTlTaUo0QTE0b1hTZktVQTVJQkp4Mk1nUW16VmlMNThh?=
 =?utf-8?B?dDJ5UkNPcWhkc0FhTVpqQXNrcnEvZGFMRnZPNllwVHBGVTVLRDN1WFZmTTlz?=
 =?utf-8?B?WWpnanBCR3QyZ2l4RnNyQW00UmRqL0pxMmtIa1o0QlRlVUxtYzlmMDI0K3ZX?=
 =?utf-8?B?dnJzT0JRMkZKVkszMGJQOGh3WWJSNzkrVUNjckM4eVoyODhOTDJvdUdHNVYv?=
 =?utf-8?B?K0sxS09OVmFhaGFsM1pqT1JZV0JNQTlVbVVrM0hCT1FmSUMzRm5Nb3FHZVJ2?=
 =?utf-8?B?cUVZY0xreHNjNGpSRWNlQnFlaEZSNWlsNldCaEUybnE0aFc3dHd3K1dUdmdD?=
 =?utf-8?B?dzZpSEpMT1ZzczYvMVhnNHNLRnJKa1UyVERLKzhvZG9Mc24zMlNsc250UnMv?=
 =?utf-8?B?dnpTc1BSVlJXL09sWWkycjNvRzV0d2xyR2FPOHhVL0toT1FhbmR2WnhvSGZt?=
 =?utf-8?B?U0hldnZkS2dEdHFVRnIzYmpRQ2dOVll6RHlaZ2prbmpsREltYjJIOUEzU1Jo?=
 =?utf-8?B?MWI0OGZpZ0syVk0rcXpycmlObWZlbzlkS1FXSnZsaVYyRFo3OFI4Y3R4cWp2?=
 =?utf-8?B?Y3VzK0VEQU9xZmZOeVBFK2x2eXVOaTBIaEt5azhsSFR5b2dNUFVhRlA1VE03?=
 =?utf-8?B?b29KSDJvcnI5NjZqMUhxOTR1NzFpVWg5VWhjOGlLOE5KTTR0azN2V0hOaUNE?=
 =?utf-8?B?djB0YmVBYlRUdmEvQ0NBL0Z2eUd3SmJXUW51L3EzQ0ZwZWMya0dpQ1puQkE0?=
 =?utf-8?B?cXA0YUR6em5sa0JQUHRJMHk0bWFKWjYwNG4yc28zWVd4cmhRK2NORHBJQjdL?=
 =?utf-8?B?RzlWMWgrOC9xUnlvUEVqNjNtcFVFc3BhNXNBdHNqZklRTnhRakJMQkgxTkpB?=
 =?utf-8?B?ZnZNY1M0NTFzS2NST0hyLzlqRURhUkhtZXRDNUIvTVFmNTNwSmhKSmRJblFv?=
 =?utf-8?B?RTdkNnZXMTBMVkJrQXNUYlM4ZzVPVVluVms3elViWm5iampYd2VPMWo3UGQz?=
 =?utf-8?B?K2dBQzFZQkFybTB3UUV5bFRJeWZZdHhKS3BkYUZ3cHZnNWt4NFZPMU1xUm1L?=
 =?utf-8?B?eDJ6ajF5RUtlQWFOeDVJY3ZSSi9sc2JDNXdjZDdBYWJ6a0o5T2MvK0pXSyth?=
 =?utf-8?B?cXVraEl4ODdFZ2hFVmVpV2ZDZ0RnaEtzWWtSSEt6SnBQYUhGTzB2MWM1Q2JE?=
 =?utf-8?B?eE1wZE0vNWhqSm52b2NiTEFCeVRrT3dSTkJ0TTJSTlZVLytmNGlJd29INHk3?=
 =?utf-8?B?V3ppTGxacWZrbjlyaEhDcWFDQVA3WVd0RFN5TS8yZ09yY3B6WGJIM3Z5aldj?=
 =?utf-8?B?eUw4M0dNRDBFNlE2RHp0ZW1LSWp0Wk1YVG5GamowQnBSNFZWc3hZTFl0KzhJ?=
 =?utf-8?B?TFdoU2NFY28vYUJMMlp2SUtjOWJhN01hL0RnSGhoZm9oS1hWaXAwWWk0ZVNW?=
 =?utf-8?B?ZTBLdFVRR2dKSlJHczZFcW9BaGxsUnV2aGpWZC8xSDZnaWJvTE1UR1oyanMz?=
 =?utf-8?B?RWY2UjIwcFFCRFVHVVY0MXVxNlpPNWtQb1laQmRBTFVvbUJVY0I5eHdYUFMz?=
 =?utf-8?B?dm1iRVNnOXA1angrT3UwZDVLM1dWUG1obzBOOCt6d3cxeTJZOGl1bEUrbmFV?=
 =?utf-8?Q?3Ttcpt32ll3nW8eRiOu/+7t2EmW+CRYxU6p6ka3?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-87dd8.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa02119-ea85-4a83-0e8b-08de2f58ee86
X-MS-Exchange-CrossTenant-AuthSource: GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 15:06:54.2302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PPF6D5AD81E5

On 11/23/25 19:32, Oleg Nesterov wrote:
> Hi Bernd,
> 
> sorry for delay, I am on PTO, didn't read emails this week...
> 
> On 11/17, Bernd Edlinger wrote:
>>
>> On 11/17/25 16:01, Oleg Nesterov wrote:
>>> On 11/17, Bernd Edlinger wrote:
>>>>
>>>> On 11/11/25 10:21, Christian Brauner wrote:
>>>>> On Wed, Nov 05, 2025 at 03:32:10PM +0100, Oleg Nesterov wrote:
>>>>
>>>>>> But this is minor. Why do we need "bool unsafe_execve_in_progress" ?
>>>>>> If this patch is correct, de_thread() can drop/reacquire cred_guard_mutex
>>>>>> unconditionally.
>>>>>>
>>>>
>>>> I would not like to drop the mutex when no absolutely necessary for performance reasons.
>>>
>>> OK, I won't insist... But I don't really understand how this can help to
>>> improve the performance. If nothing else, this adds another for_other_threads()
>>> loop.
>>>
>>
>> If no dead-lock is possible it is better to complete the de_thread without
>> releasing the mutex.  For the debugger it is also the better experience,
>> no matter when the ptrace_attack happens it will succeed rather quickly either
>> before the execve or after the execve.
> 
> I still disagree, I still don't understand the "performance reasons", but since I can't
> convince you I won't really argue.
> 
>>>>>>> +	if (unlikely(unsafe_execve_in_progress)) {
>>>>>>> +		spin_unlock_irq(lock);
>>>>>>> +		sig->exec_bprm = bprm;
>>>>>>> +		mutex_unlock(&sig->cred_guard_mutex);
>>>>>>> +		spin_lock_irq(lock);
>>>>>>
>>>>>> I don't think spin_unlock_irq() + spin_lock_irq() makes any sense...
>>>>>>
>>>>
>>>> Since the spin lock was acquired while holding the mutex, both should be
>>>> unlocked in reverse sequence and the spin lock re-acquired after releasing
>>>> the mutex.
>>>
>>> Why?
>>>
>>
>> It is generally more safe when each thread acquires its mutexes in order and
>> releases them in reverse order.
>> Consider this:
>> Thread A:
>> holds spin_lock_irq(siglock);
>> does mutes_unlock(cred_guard_mutex); with irq disabled.
>> task switch happens to Thread B which has irq enabled.
>> and is waiting for cred_guard_mutex.
>> Thrad B:
>> does mutex_lock(cred_guard_mutex);
>> but is interrupted this point and the interrupt handler I executes
>> now iterrupt handler I wants to take siglock and is blocked,
>> because the system one single CPU core.
> 
> I don't follow. Do you mean PREEMPT_RT ?
> 
> If yes. In this case spin_lock_irq() is rt_spin_lock() which doesn't disable irqs,
> it does rt_lock_lock() (takes rt_mutex) + migrate_disable().
> 
> I do think that spin/mutex/whatever_unlock() is always safe. In any order, and
> regardless of RT.
> 

Well, based on my experience with other embedded real-time O/S-es, I would
expect that something named spin_lock_irq locks the task-specific IRQ, and
prevents task switches due to time-slicing, while something called
mutes_unlock may cause an explicit task switch, when another task is waiting
for the mutex.

It is hard to follow how linux implements that spin_lock_irq exactly, but
to me it looks like it is done this way:

include/linux/spinlock_api_smp.h:static inline void __raw_spin_lock_irq(raw_spinlock_t *lock)
include/linux/spinlock_api_smp.h-{
include/linux/spinlock_api_smp.h-       local_irq_disable();
include/linux/spinlock_api_smp.h-       preempt_disable();
include/linux/spinlock_api_smp.h-       spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
include/linux/spinlock_api_smp.h-       LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
include/linux/spinlock_api_smp.h-}

so an explicit task switch while locka_irq_disable looks
very dangerous to me.  Do you know other places where such
a code pattern is used?

I do just ask, because a close look at those might reveal
some serious bugs, WDYT?


Thanks
Bernd.


