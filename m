Return-Path: <linux-fsdevel+bounces-58628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD800B3012A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 19:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2975C26B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 17:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836632E6104;
	Thu, 21 Aug 2025 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="bKIHd8d7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2026.outbound.protection.outlook.com [40.92.58.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A7A2E0404;
	Thu, 21 Aug 2025 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.58.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755797599; cv=fail; b=dcv24nHWWkfTQlgxA7I0OPC5EKchMek5mv5kgnqcRTl7lk2RPrf7nH01yHLBcK5uyom9NuT4ZW+hNTzipuei2biv7FncLz3tEzmN5+idQcWmWr0XzMFkoe+L7w18rhCkqftppBObN9ZmyFRA6SJZZePwqFfQ5F/8WcFv5lOK3qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755797599; c=relaxed/simple;
	bh=y/H3PB/wiVg6DVes0t9A9+tjFakc0UNP2p32PJREY/8=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kWpajq++pESwhfIINE1tjOHwh8BKh5WHyN8daF+mQUYxbH1n9GXG+MqjVzVRjvDR1FKF2BdqEbAZLEYt8b3twE0t5263nSVpJPw92mURCuOBwPipPgsww2XyQvGrDt/Ugrzdkmu70ZEgMz1IRTs9WGfGcLaPX9ZP429TPV5z+mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=bKIHd8d7; arc=fail smtp.client-ip=40.92.58.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asUG2hmjXdYlwpSXHoxFPdw70l8jOvEto1v3dgtGkPCuM7fSA3eWHXS1RMwiZl0halo5mlNQML5R6weGNmtmKNjieos/03BfZLcx6JYrh+juBI96rplz8L4vIMFicP1qNp3guezKdNFVryLpS9KSwOaHwSoZQeCZl5BFxkxTvO4vRn4hzzLXCii4dSWx3SMYq7ACoNI8UKI7E9mX37VuweEY/qfJzTAo38cOFaySJUO7QDqozPZMnzUrtAlyfglabkfbKQPfhha+OnrmCQXCkElp2ijEYAy8hII670ivk4oovQErIArrba2HkY7tWJci6Lach0FylzO2Ebj7WVN52g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qxrpAhvnVsxy7PHMva9Da2NropxqZWNGhYodGsEYzM=;
 b=Drk2xqU+nBEBkKHG0xT/E4tt+RZDFMFInZBuvIMmuYxnJitDx2DEMFVU0W4+WXXFv3n9SdwWl9bj/29gDy/0tcpXKgxTDWdb3rHpfLu32KR5dcY8jP53/t6rNhcvcX/T4p9mo11Y7HAV0p1zthFHzttpOOxnUI0IVFze/qWQeRqPUSpvXajEJukfIb5lGZ0MDn2AOOiZ2VwT241jxdFmToAe6VCmzIMtwHIYGsFMDkvp/4kum8ty3WMOqHOVO1jS0o7ZMaZBxc6WHqdCKsTVB6Ovb9Jkd2S0RMMfNo8DoV63zThopBL3CE4fwf3C8I2TK3S7GThyFGVUYWpeuY9gYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qxrpAhvnVsxy7PHMva9Da2NropxqZWNGhYodGsEYzM=;
 b=bKIHd8d76EQgBVMpF7VxA7JPXiAWQcgd8ns4kHfYzm1Q+iCoOchQjghFWgx3FHisXQ1GrCYS73vYymgINbuB3Z/7Pj47+M8TcWFTArGSw1KKZ2QoktY3Z6Slc6qLy+x7WsnAAjyewd/EI7CqZTu7JUBY9VSrtTLrdoCOP+re1I6A160NBZ/SFTGcw9VMTzrI49YUqSukbDdUiMDif3fNWWgVXhamfzKY8vcu/qgO35l5PqRTmcRro1kUUYeeB9PB0oEx9wp8PAMqsg2ZwJLKHm/wZfPRG7Y97PlamSYEkuUSmrGRgZ71Nd2JCSx2urAcW7qw1yffZb4jY0QUn1+bcQ==
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4) by DU0P195MB1522.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:34e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 17:33:13 +0000
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::b175:8fa1:21bd:f192]) by GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::b175:8fa1:21bd:f192%6]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 17:33:13 +0000
Message-ID:
 <GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Date: Thu, 21 Aug 2025 19:34:58 +0200
User-Agent: Mozilla Thunderbird
Subject: [PATCH v17] exec: Fix dead-lock in de_thread with ptrace_attach
Content-Language: en-US
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
In-Reply-To: <GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::13) To GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4)
X-Microsoft-Original-Message-ID:
 <651f4596-37c2-4161-839a-aebb70ab23f5@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPF74270EBEE:EE_|DU0P195MB1522:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1a94e5-c8cd-4b4f-c5c2-08dde0d8cd83
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|41001999006|461199028|8060799015|5072599009|19110799012|23021999003|15080799012|10035399007|4302099013|3412199025|440099028|40105399003|51005399003|12091999003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1I3UmZFRDNURElYNlF5V1I2QmlkUGc5ZU54S0RUQjAxUXNGcE05T2dTWDd1?=
 =?utf-8?B?QkR3ZTZLYm54VTJ3aGFnenVNalkxMUlwVXdPZUJVdHFSdU93bFFyY0VHVEtR?=
 =?utf-8?B?K3ltM2QrbUxyTVpJNTZkc3IrQm1ZYWtYOXl5dU1DWHJqeXhyNisxbVM5VnJU?=
 =?utf-8?B?RzFwcXRpM1pUNmV1TmM0RlpHV1lsS2oreGd3MTFjUk9MSTQyNW05UERqL3Np?=
 =?utf-8?B?a1FkNWRFNGZUR0pLM2hFTnQxRm9XeGN5U05hM3JBZnRSRnEyRzJwS1hrMkVX?=
 =?utf-8?B?eGcyK3VhaTkyOUZYbUFiZlRjVDBCZ2lnRVFINS9YYkJjclcvaWNTUE9RTVRl?=
 =?utf-8?B?YkVGTFdDcklLZ1Uvb3JTOHVvUngzYXlKTHNuem5WenQ0Z2RrNVQvVFFkUkN4?=
 =?utf-8?B?OTZic2RxQ2ZHZk5ZSHFjMWlzcVQvWWY4Wk5ZTjlLKytaOFRKY0xnbWdZNHAz?=
 =?utf-8?B?aHN5RGZIUFJ3SVpHZi9PcmxybE1wRmhUYTBwQTBpSG9JcFFsemhzeTVaZnpq?=
 =?utf-8?B?QmhtTkprdFJLb0FyR1ZKOGhjL2RCZkFvWm1DS2lraHRkd1o0N21pUUlYWCtv?=
 =?utf-8?B?Snd3aXJBSXBOb1hFUk1tYkM1YUhkaHd4SUxWU2hhVG03Z1hadVRUY2IzMWJD?=
 =?utf-8?B?ZXc3Q1hkZE5TR28xd0VtcnN2ek1ubllUdGw1bFIzWlBSaUtPdmp0SFJRS2p2?=
 =?utf-8?B?RWRZa1h2Yi9wb0RhTDNPQ0x6TzBIZVhkSmFWdk84WTk5NDZoOUlxQXJoano5?=
 =?utf-8?B?MkJ6aFJRQlB5U0hGc3lYNzRjZ0JhS2wrTW1VODlTMzJkNFZmYi9QZTJiaTV3?=
 =?utf-8?B?Q3pKVW5RNldmcGg1KzZoQW1PdnZIaHd0TTErQmpYb29vclY4SWp6N3B4RUpS?=
 =?utf-8?B?eGpuOHlCdmFtdXRQM203VXdwN1Z0QjNjalZsQnRqdWxEWUJieUdoSEYzKzBk?=
 =?utf-8?B?NTYrSUUxZGVqR0ZGYnNUcDRDL2oxd2dwOEg3SVZHazBCWDBkTVd6V0Q3UzNW?=
 =?utf-8?B?cHBaYm9pbGkrdENOK2YyZ0lUaERiT2JyWDlRK2xVc0V4QjcxcGFjTHhyNjZ3?=
 =?utf-8?B?T0VSamUwZ2ovUUpaRk9UMmp3dm91Y2o0aFNqMi8zQysvVXQvZENnanh0OHI1?=
 =?utf-8?B?R0dXR25vdm5RTGkwQjFGMUoxTjdSYUtkbndZaEZYYkJYNkx2S3A3NERYcW5t?=
 =?utf-8?B?WHFXYWYyQXozcDJZRjJvaDBaRVFqK3RRaEw3cmFaS01rNGpjcTRIZUlIeGp5?=
 =?utf-8?B?bWN4R0ZNd3VrVkJUMzRnRVkrS3N0YTRSV0ZqU2tROEJFcEdHbHNRaTlmVmhB?=
 =?utf-8?B?dktmSEhwYTBwMVdxV3VjdWowZmNsMFNLY0NlR2NUclA2Qm5CUHJOaTVQY1Rj?=
 =?utf-8?B?QzREd2ZZWXBJUi82OVg3THlLUVRPcGxWQXIrU0lEUWhpQmlXUjFUalRFMmx3?=
 =?utf-8?B?dGV5QUtOenVuVG05NE8xUFRJWm02ZmVUM0VHaXVMd0lxTGZVYVM0ZFpBbU41?=
 =?utf-8?B?eWFrbFBESlNLVGwzUCtpMVhaN2xyVExNWFNab2YrVlc3ZXBZTW02RVBUN05y?=
 =?utf-8?B?c0RJSFl6YlIyWkI1Y0hCTkVmV0pzc3FENzJVVnk2UzNFeFZoUGFqRlZ5WGhj?=
 =?utf-8?B?Y0wwS1ArN0kzT2NvYlBmemI3clJBQjh6MXM0eXU4VUU3OGRsTjBrNzcwVE9y?=
 =?utf-8?B?RXQ0RkpXMVppZUNLTUVmdnJFK05iTW54RE5ldGhneTJoT0xRalIzWG5zMlBp?=
 =?utf-8?B?TjNaSlZIWTlDRjh5NUI2d0VKOGVyckNsMFRHTXZHc3BPY2RjNUYzaWFhTjRk?=
 =?utf-8?B?ckwyZnFlblFOK2FRdHB0R08rd21NUE5hbkZ6dkJYRk9rRytSQkZUVE5tSFRv?=
 =?utf-8?B?OEZ5OVk1TWFydWR0Z2lqOXVxME55d2ZkdFFqQkdKaDFVa0E9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkFkODVXa01HTnZUakVQeVUwZXg3UktlakUxbDZzQjNLVHQ2WUl1QUhCVTE0?=
 =?utf-8?B?WmFpaUwya3AxRlVzTWdqV0R5Rmd5Z0NOSy9jU3lJcVMwcUh0aGhSSmJOTS9v?=
 =?utf-8?B?Rm92WWcyeVhpOUVUcFZzclpOMnJuSk9nOW50VEZDMDFGbDkzVmoxTlF4Z0pV?=
 =?utf-8?B?NXZ5Q0xsdEdTQUNFekRrZDNCZ1pnOU9YU2lwa1VEcWpKYlJheUhvOThnYWM1?=
 =?utf-8?B?M04wejFtNEU2cjgvaGxtTlZMczVGZVBhTTE4cUNhYThVN0g2QjlPbVpsYU1z?=
 =?utf-8?B?bzEzc2twS1k0WVlnenAxQXJmaUFZbHFTNllUY2VIUW9ER2huSEtyNlNzalhN?=
 =?utf-8?B?SVFiQjNWUmF2Y1R2SENvcFhYSnNpdlUvemoyaC9DQlJLcWJxZGhHYTA4cDQw?=
 =?utf-8?B?enBjZHkwKzhEZTJqckV0U3Q5NlBJVll4SXZRWXBrQ0p5bG8yamRlU0s5YTl4?=
 =?utf-8?B?bG1YVS8xdnVIZTFYYUo5SHJTNEpiOGF3akthb2xjeWlOSDQvc3o3Y2pCT1U2?=
 =?utf-8?B?bC9IWjJqOG5XVmVkNmtYT25KYk5VVW4rUmpZdnorVWpaWnl6M21JSGdKU0N6?=
 =?utf-8?B?aklUdml5L2Y2WVpXOEVySEpVM214MHVyRE9XbGFHdTJuVUJCTHBtOVpEamdI?=
 =?utf-8?B?SURJSmJiM25jdCtXTWJwQ1F3VWptMnM3Ni9lQXpmSkNnTEZwclNXU1k4TWoz?=
 =?utf-8?B?alpxWWZVaUQ2N0F6ZGtKWVE5R2dsckVjbDNRdFdORmFGV1lveTl6SkJTdE5Z?=
 =?utf-8?B?MGE4dnpaYnZVYUNIemdCdXZ6MHBEU3NjMWdQb1lZQkxlUjNpR0lhZ056T2tB?=
 =?utf-8?B?bTBvZnBSZkYzYURTTGFHRDc5VllrQ2NEbWxiU05XQWRBbWJKeURYaW0yQnQ1?=
 =?utf-8?B?cHEzZkxGeGNJYk43OWNvOGFzUUthOGNRUVFDc1U4aXdzUHVpblVSUHZtSVhy?=
 =?utf-8?B?M29iZnRWSjZqQUJWeENRb01zZUV1SitYNTl1NzAwRFVJcmhIb0dINFgwZkxp?=
 =?utf-8?B?ZVJJdHBZSlpsTy92UlRtbktMSWZDSmRDcENJZzcrdy9DU05Md0pUSXdvMUx4?=
 =?utf-8?B?TW83d3ZCU0tiSmtUdGxTRE9DMndZZWtoczNVSmFCZ1MyRkM0SW96REF2ZUJr?=
 =?utf-8?B?RlVWOXRzdzdXOGNiWEVPZDRiUEVTOFQvNVVXOFlsTVNxMXlLWmRHaWR5bTJo?=
 =?utf-8?B?SmtYelg1djFMWWZpRllHM1VzME9EbjdxQVdNVmxieE1KeitqbFdlYUhlZmt3?=
 =?utf-8?B?SXZ1bmQ3RUcvWWdoVHNIS0NNWU9UcFM2OHEyUTlPWHNSR05jUzRveFNIeWxX?=
 =?utf-8?B?TndwZHhTczdFa0J0UmhhVVE3Rit3QTRSSExORlFJWEVwOXc0alQ4c3Y1ZGZB?=
 =?utf-8?B?OHdNY2ZmdTIxaUYyTitOTllpMVpRU2FHcHlVeWpqYzZTK29WUGxGMnBYRzE4?=
 =?utf-8?B?cHQzL1JkeUFpNjR2alRTNVd0NEtoa1p6cktSaXhsSEVDUFBybVBFTUZmMjEv?=
 =?utf-8?B?S0d6LzZJcDdmTXFNS3pFRzhjaUhwNEVkYjFneHBveEF3SjYrcWVHMjJxY0RK?=
 =?utf-8?B?Yy9ZcFNER1pXVHZSZnVIdzczbGIyYXE0OFdXMEhOL0cxRit3b1VJTmVXVnE2?=
 =?utf-8?B?VnJqR05VZkR3UnB6bmdoTzl1ajh6cHlMbGpKcHJsRnFQQXlDanVNV04vT0tv?=
 =?utf-8?B?UFlpb0o4cHhPbXd0b0RwZTRVSDMrdVBIbFRFNENSVVpVNW5LNVFwREE2Sytx?=
 =?utf-8?Q?QvxPt6oCkfe33/ihZbTm2tswn0eMWki/58++eGZ?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-87dd8.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1a94e5-c8cd-4b4f-c5c2-08dde0d8cd83
X-MS-Exchange-CrossTenant-AuthSource: GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 17:33:13.0935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P195MB1522

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
check while temporarily installing the new credentials
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
 fs/exec.c                                 |  69 ++++++++---
 fs/proc/base.c                            |   6 +
 include/linux/cred.h                      |   1 +
 include/linux/sched/signal.h              |  18 +++
 kernel/cred.c                             |  30 ++++-
 kernel/ptrace.c                           |  32 +++++
 kernel/seccomp.c                          |  12 +-
 tools/testing/selftests/ptrace/vmaccess.c | 135 ++++++++++++++++++++--
 8 files changed, 266 insertions(+), 37 deletions(-)

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


Thanks
Bernd.

diff --git a/fs/exec.c b/fs/exec.c
index 2a1e5e4042a1..31c6ceaa5f69 100644
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
@@ -932,6 +934,19 @@ static int de_thread(struct task_struct *tsk)
 	if (!thread_group_leader(tsk))
 		sig->notify_count--;
 
+	for_other_threads(tsk, t) {
+		if (unlikely(t->ptrace)
+		    && (t != tsk->group_leader || !t->exit_state))
+			unsafe_execve_in_progress = true;
+	}
+
+	if (unlikely(unsafe_execve_in_progress)) {
+		spin_unlock_irq(lock);
+		sig->exec_bprm = bprm;
+		mutex_unlock(&sig->cred_guard_mutex);
+		spin_lock_irq(lock);
+	}
+
 	while (sig->notify_count) {
 		__set_current_state(TASK_KILLABLE);
 		spin_unlock_irq(lock);
@@ -1021,6 +1036,11 @@ static int de_thread(struct task_struct *tsk)
 		release_task(leader);
 	}
 
+	if (unlikely(unsafe_execve_in_progress)) {
+		mutex_lock(&sig->cred_guard_mutex);
+		sig->exec_bprm = NULL;
+	}
+
 	sig->group_exec_task = NULL;
 	sig->notify_count = 0;
 
@@ -1032,6 +1052,11 @@ static int de_thread(struct task_struct *tsk)
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
@@ -1114,13 +1139,31 @@ int begin_new_exec(struct linux_binprm * bprm)
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
@@ -1144,11 +1187,6 @@ int begin_new_exec(struct linux_binprm * bprm)
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
@@ -1210,18 +1248,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 
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
@@ -1361,6 +1387,11 @@ static int prepare_bprm_creds(struct linux_binprm *bprm)
 	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
 		return -ERESTARTNOINTR;
 
+	if (unlikely(current->signal->exec_bprm)) {
+		mutex_unlock(&current->signal->cred_guard_mutex);
+		return -ERESTARTNOINTR;
+	}
+
 	bprm->cred = prepare_exec_creds();
 	if (likely(bprm->cred))
 		return 0;
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 62d35631ba8c..e5bcf812cee0 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2838,6 +2838,12 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
 	if (rv < 0)
 		goto out_free;
 
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
index a102a10f833f..fb0361911489 100644
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
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 1ef1edbaaf79..3c47d8b55863 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -237,9 +237,27 @@ struct signal_struct {
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
index 9676965c0981..0b2822c762df 100644
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
index 75a84efad40f..230298817dbf 100644
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
@@ -453,6 +454,28 @@ static int ptrace_attach(struct task_struct *task, long request,
 				return retval;
 		}
 
+		if (unlikely(task == task->signal->group_exec_task)) {
+			retval = down_write_killable(&task->signal->exec_update_lock);
+			if (retval)
+				return retval;
+
+			scoped_guard (task_lock, task) {
+				struct linux_binprm *bprm = task->signal->exec_bprm;
+				const struct cred __rcu *old_cred = task->real_cred;
+				struct mm_struct *old_mm = task->mm;
+
+				rcu_assign_pointer(task->real_cred, bprm->cred);
+				task->mm = bprm->mm;
+				retval = __ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS);
+				rcu_assign_pointer(task->real_cred, old_cred);
+				task->mm = old_mm;
+			}
+
+			up_write(&task->signal->exec_update_lock);
+			if (retval)
+				return retval;
+		}
+
 		scoped_guard (write_lock_irq, &tasklist_lock) {
 			if (unlikely(task->exit_state))
 				return -EPERM;
@@ -488,6 +511,14 @@ static int ptrace_traceme(void)
 {
 	int ret = -EPERM;
 
+	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
+		return -ERESTARTNOINTR;
+
+	if (unlikely(current->signal->exec_bprm)) {
+		mutex_unlock(&current->signal->cred_guard_mutex);
+		return -ERESTARTNOINTR;
+	}
+
 	write_lock_irq(&tasklist_lock);
 	/* Are we already being traced? */
 	if (!current->ptrace) {
@@ -503,6 +534,7 @@ static int ptrace_traceme(void)
 		}
 	}
 	write_unlock_irq(&tasklist_lock);
+	mutex_unlock(&current->signal->cred_guard_mutex);
 
 	return ret;
 }
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 41aa761c7738..d61fc275235a 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1994,9 +1994,15 @@ static long seccomp_set_mode_filter(unsigned int flags,
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
+		if (unlikely(current->signal->exec_bprm)) {
+			mutex_unlock(&current->signal->cred_guard_mutex);
+			goto out_put_fd;
+		}
+	}
 
 	spin_lock_irq(&current->sighand->siglock);
 
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


