Return-Path: <linux-fsdevel+bounces-48576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AF6AB115D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 13:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E17949C07E1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 10:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DAC28F527;
	Fri,  9 May 2025 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="w3zhrytm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2110.outbound.protection.outlook.com [40.107.20.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC5028F520
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788395; cv=fail; b=ZQlw/qcFq4BOXu6bX/kI7Hv2ZpJOnt3cDnshmuku4w3EFndhKvHT7foR4VAbBBRHhlQC4nEw2hX5dy7gZpVq80euj1MDsNeN1hgMXpa63ISsG0uxntEYstIfv76x+w7KTb8fYIQRkIahwcn+mAyh3zVreRTIvuHmr9vaqRpnxuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788395; c=relaxed/simple;
	bh=ihfX72QaxUwDlu6SfS2kzh81cP+pelqHlZj2B98Hxm4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NNwbO4cDCBV3GK+qVLmggDbRx0RpgkCYhb7z5+xpdyQPr7ztdgVrgBTXkMvt/u8IGocZh4e3xr42fWGvbz/NUZPaBqqf6logDjoxbXnwUujDtYkKaZhEMY+mpEmde5PdSN83kcF5adSzXqwPpeErUOz1/OK1CBXqwJM7YgzO8Ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=w3zhrytm; arc=fail smtp.client-ip=40.107.20.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDuq0bQw28MvUyRtU5F65Zx/qC4lz95Zi9Cxq7gu2/K8ehWsdXbw9l/G9eM/ruykN0Dj87r+z4bljQhsR/9RZbQmxezBFteJZz4ljC7qRgtw8AV5b2WuoUqH20mQ/E5oLh4L5u2VmNgzw+H29dUVzFphFVLASoawoThprK9T6xp06CZbAkREOJbcDC3k2R72HIwuNJ9c0MQ5rLGQjtvMMGtgp2Vfk6ygmSm0ySUhNcaYLzktJTG2Orm+fc7277jnHEZNVwlCIGAvXIkJEbbzbCBaomChBbxdpgfI4365Wl/ptP9crzgyRAfneYfLc5lZmhzS3Le+2d7kJqkH28Z/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJUdR/k3/K7NgWs7fspLFwK2Otj0PeaAukiocWiL81k=;
 b=U7eaJLFtaDUH5oev5IJzoGgFkCUDoaJnucPfp5bOtPsB/eSD5c+ZF4EN+Jf/84JrTzrI3CwHAdxBXWUhnM1ceQxH5LSCGeQR1AdkLtDqYceWyWA49YMl5feVcIZeaRBMPbDOWp6ZsSHo6KoS15K889o+I3L7txCwH3TPMvi0K0jp0OFxqI0j1PG00+vxl56sobopARE1am+mENAj/y4FOgx2kEKPj/QEwOielrt3DUtT+X3a+Nwup0FCdXwexCiN9KJYEijeyenc84AxMHXKB7TyQnmbYopF8+7DK402tsv8y+rTbM9AYmvq0MOWqP3L5lXXlap0+NktHmeLRFa3mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJUdR/k3/K7NgWs7fspLFwK2Otj0PeaAukiocWiL81k=;
 b=w3zhrytmkESQFAtwPZ1xwoMGtURf+BT+Nr1CSjywwu7rWvnOiZlqNK0oyXgaDZZOFcIzU0Wg1eYRVrbZjvcWQhiIFfppuZo3w6mnDBTIcU0vZvMz3VyCTyCdNilfXyAZYaJTBY3N7/Aat7OevxbkNIpVOgP9Yh3bbbZGd0r0xLR5i2Yf1P0Tz/OdsJjX/CVLBTWXMdRLRtgmkleNeYlKiep7h9J6760fxbe1wGSne1ntuylW59WYvfydt8iNKimY0RF55BFoi4+nJu5f3wClIXra9SJXEq3mzpbNSclDoOCnrGDBPfay5vsi0oapEe4N5saW9fnzojOQzfVQLDTiDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by GV1PR08MB7780.eurprd08.prod.outlook.com (2603:10a6:150:58::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 9 May
 2025 10:59:47 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce%7]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 10:59:47 +0000
Message-ID: <2c1ebff3-c840-4f68-84a6-87ae6b3b4a8e@virtuozzo.com>
Date: Fri, 9 May 2025 18:59:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] propagation graph breakage by MOVE_MOUNT_SET_GROUP
 move_mount(2)
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
References: <20250509082628.GU2023217@ZenIV> <20250509082845.GV2023217@ZenIV>
Content-Language: en-US
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <20250509082845.GV2023217@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU2P306CA0010.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:14::7) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|GV1PR08MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: 3019cdd6-66a7-4142-b8ca-08dd8ee89cfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3RvOGdMblE5bTRCc1B2V05hR1VHdlJQK2JoWHVhUEd0Q0tVWXM2RE8xUjN6?=
 =?utf-8?B?NDd3eUhvYk12WFBjMkIzdFI0ZWJFbThjanlRcXAyV21IN2RXUExWZHJZQW8y?=
 =?utf-8?B?N3c2bUZ5TXZheDFaeGh4cHY2OXIzaGR4dFlNbmtWUUI5MmR4aHM4cCtYQW53?=
 =?utf-8?B?OC9NZlNlakRlM0xEWlNVZGp6d2kwNGxrWnYvUWpzaEUvSzN6RDhqVHJScXpB?=
 =?utf-8?B?cFQ5YjVXZFEydDl3K3lESjF3N2lIYXE0aW1qNU1PR0Q1R1pUaW5hbUdKSExv?=
 =?utf-8?B?WElvU0pzcHdZSm8zbzNYVXFacStqcEpSaU9JREI0ajZIVFZGWkYwRW5EMk40?=
 =?utf-8?B?N1VpWWVrZlJYQ3VlQTcyY1B1WlhGdlVIMHNzUVpkcHcwS1hYelFON0JkU2o4?=
 =?utf-8?B?UFhDREEwNzB5UWt6Vm1MeHBVMmNkMXBBL2Z0MEpTejllcjB0NWNHQ1VFSzNr?=
 =?utf-8?B?d2FlTEtONlErZmFaQjY4RWo3Qmxwc3F5cW5rUktDVS8wU25uWGhQditUemhI?=
 =?utf-8?B?S2hMMGlKaUQ0VFJYQjBqdzY3dm9VdTFOa3Y3M3hlRCtISzFka0l5QWNCVFFk?=
 =?utf-8?B?N1dvSzgya0pIYmU4ZW1FRStWUm80SEdWTHo1Q0dIY1VTVXpHMG51WUJ5aTVx?=
 =?utf-8?B?WGprTU1xMHp3MEN2U1Yxb0dkM0lXakFXcXdDa0lYYTZ5TUxaRWhxcUlDeW5o?=
 =?utf-8?B?MVpNNUJ0WDJhN0pLTG11SXhOcG9aNlowdStwMmVMU1owOTIxRVZNeGhXNWQ2?=
 =?utf-8?B?KzlpbzFweTdFQVhSR0MyalpyVmJneEdGK0NJMVBGZTFCNzUycWxFNVlmckxk?=
 =?utf-8?B?ZFAzVGtYaExIbkgxV3pEUUNMcVdnNUhKL2NjTGdKZS96N1RIb1l3Y1h3d0N0?=
 =?utf-8?B?elJzYVl5aDRRSWN3NkhWTTg4L1R0Z3BkWHVTRkxEejhwd2ZTREhkczI4b092?=
 =?utf-8?B?bEVFbUxFQjY5QkxEMjQvVVVyWnZmamdUNU9Fa3l3Q2dNREorRE16am5ZYy9q?=
 =?utf-8?B?Y0crK3F2RS9pVkJyWmZ5MEU2MnoraDRMaUs3MEVsNndKOFlETkdDUHNVcEpl?=
 =?utf-8?B?VHRUSEg4bmRRTCtZa3V6Vllsdm9wNyttVmNxaFZJSnh5Ky9nOHMxL2tIOWlZ?=
 =?utf-8?B?Njh6cEVFcFRLZHQrb3dWRjdTbmlTbUZEUHI4NWxYTGFQYlJsbUJ2ZkhPeVBJ?=
 =?utf-8?B?NXpKZ09xakV1WGorWkppcTJLdEFvUTh2TFFrelBBUERHMU1nVnVLUWhYTW5j?=
 =?utf-8?B?WjRVa2oyTExPZmNHZjRtUzVLVzMreHdsRFArTHZ0YzMvWVpaQ1VzNHVnaE5H?=
 =?utf-8?B?QW9wV2tHYXRYOXRucENlZFlQVXYxbXlPVEdXT2dUOEZPd29rVmp1Zm1CcDRE?=
 =?utf-8?B?dmZERXJWSFo0MlptNEhsZEgzdVg2NmxHSHVsdXlhSXVmbmF4NHFXU2w3K1Er?=
 =?utf-8?B?TFFvbVA4ZDhjNCtTTXJJamJmbWVFdkZUekViZUFjOFpCVjVsQVNxcEk3RW1W?=
 =?utf-8?B?dW1ndktoaUJETFZkNGtYczRaaDlidCtFK0F2R0NERGJDU3crNUVoRUUzNkcx?=
 =?utf-8?B?QnI1THlSc0FaaGdGSVBWSVBoVHRXNUg5WkpGamJHazZvV0gwQ2t3VlZ1OVNF?=
 =?utf-8?B?cjRjVXB6MzRJb25iT2RLc2ovZy9uSUtvRUg0NUFsUFhhLzBWZnh5QUlEUUhM?=
 =?utf-8?B?MFZ4aDVHVzdBb0RTSCs0ZGZ5WTNDS3Jwa0ZlWUtibTh4dENSRHZrSDFkY0w1?=
 =?utf-8?B?YWF3a1BxTVNGNkJOUHJqWDlNdThOZTlaazJvUmFLaHlKUG1MRmtNMHJSUkl2?=
 =?utf-8?B?dXFMdFkzZllqV3h6Q3doY3p6YUlZTFBkRFZBTGIyOFRHVVBJTG5OK1AwVisy?=
 =?utf-8?B?akVqTFVlK1RqUzErU3BpQXhPVUsxTEp4K3BWeVByTzhmTXVaOHJ5a3YxallD?=
 =?utf-8?Q?aR+aCcyBSIU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjhaZ0xpREcwempOVFgxQm1PaXh0cjhGUGdJOVJWNU5WRVBScmhYWjF5ZFJj?=
 =?utf-8?B?SDFITUVVOTBjSFcrRXdYckpXUGEzSGNRS2tXNStGQkFodW5KRjcyTWdBRitH?=
 =?utf-8?B?dXlieVB6YUpuWHRuMWZXQVRHcHZGWVJmTDVOdERYOUEyK3VLMTRMblhVdmtx?=
 =?utf-8?B?WXhCNmxJcU1XRndRcHA3V3pseHZCUHVhY3Z0TzBWOTVoQ05JNytUSEtuRVk2?=
 =?utf-8?B?Tmk4SG9HQ1pWamVmVjRqLy94N2R4cFJLWnUrWnBtaGN0amovRG9pVWM2bldo?=
 =?utf-8?B?WVlTMHVsaUVyaUhpRDFienRVZkZ4VUI3VzFEWGZUd2lTa01tTmNMaXE4SjY2?=
 =?utf-8?B?amFSRnlxbkZkZkp1VGhoZC9OUm1uN2Z3MG13TFBGcURjVjFUZ202NmZpbEhK?=
 =?utf-8?B?S21PSkVlbHduSkpnNUNzQXp2QmxxcFgwWkJxYTgwaVQyRmgxQmFmTzllcm5N?=
 =?utf-8?B?bnVDTENNbC9KVzVtdFIzdlVPNUYxTzg3Rk1abmlrRHhuaFhuNmowYXhwNDlZ?=
 =?utf-8?B?SVlrOWxMR1Y5bEJ1TjhNMzBrMGNZc0M4M0ZTNWNhbTg3bGVEK1l5VldRd0hP?=
 =?utf-8?B?dit2Z2VoSnJCRDQ5T08rOU9RdzV3SU9WeTcrUC9qT0tIcmRINWh3RkNFa2x3?=
 =?utf-8?B?Q3BzaC9oekxFa1FYY2lsM0psV0tla052bWc5cUd3L0luQjZ3ZTNHbXNYaW9P?=
 =?utf-8?B?SXcwRXF4RFBjVGVQMjM1b1FRVFp4cnZJV3M2NkFOZ1RYSUIrZkpXR0JhUzlm?=
 =?utf-8?B?YTNkcEVYdUlZb3BUSXJpSkFQWGw2cllKbGJBSWV3WTB3N1pUNkxGY1ladkVU?=
 =?utf-8?B?RzEwcGlDMHVWdW5KUTR1Z2dKQVV4T2hVQTlYN2FRUm9OUkRtemNiNjIzT1ZC?=
 =?utf-8?B?ckM5VStmMW5sL1NMQW8xNDFTY3psZU9ybTIweTRQMW5wMVdTOHJrMXFwN1hO?=
 =?utf-8?B?WXFmVytmWWVFZ0phMXpmVHhtcVFGaUVFWVBJV2xNYms3VVRZRlg1bGxTUktP?=
 =?utf-8?B?MEk4NFJxN0Z1SlJzNVF3aXJhSldKNjRtM0tVZDRTcWprdWxPVWU1YTBZU09J?=
 =?utf-8?B?NDZMKzNJZFFCY3crQlJxS0xwWTZDRkxSUG1Jb2xrUCt1eS9mTGIySXlKWmNR?=
 =?utf-8?B?dFJlY2tpMTd1RnQ2bm1meXEydzhkOFpVYytqcDVXQlBza3JpY1o3aWxSejdv?=
 =?utf-8?B?dG9UajdUZ2pIQkVzeTlUNHlDWVFrR094TFd0bjVoV1NpV0lhOEFzempMV1dw?=
 =?utf-8?B?ZnhmeWR4YmZaejJybWt3djN4cHFHY2F1SzcxUENtNGg5dTR6NUd2bER3Y2Za?=
 =?utf-8?B?UFp0WmU3L1FlbmRXMHd2ait4aHAxYmx2YU40R1dINVJvQkJ3QlJYMmpXMDdj?=
 =?utf-8?B?TUp4cmZTY09sVkluVkRDOEpjUCtGNitxWnozc3dIVHJramc2MktIeXpPalpv?=
 =?utf-8?B?UEpMdTArVzJST2hxbTB4SzU4TlQwOVQxc2NQRURMcWxib3RwT21lbjdUNWN0?=
 =?utf-8?B?cFhoMDdZVkY2aFZFUjZEUlovbjgrc08rM05FMWYyaGkxQXE0ckd0NFU5bFRj?=
 =?utf-8?B?dEx2UE41a3pUL2FJR1BmWkVFWjhZMjhvYXM4QnBlOHJuY0JFSityU0N4WmhY?=
 =?utf-8?B?SHhEcWVPbGFrbC9tSlVkZnQvblpDbUduMzlwWDlqWng0cDg0VWxVVzRlTUVn?=
 =?utf-8?B?L0trNndjUG9kREE1eUYwQlZpeHlBbUFBVFZKb2xTOGtCTmdCNTJNTk9FalFH?=
 =?utf-8?B?K0M1V0tFLzUxVmF3blIyL3MvREZRK0k0OHhDUGhyS0toaW5JOHRGQWs0M09W?=
 =?utf-8?B?dWdMb2pSVHZnS3BMTzhyY1lLV1RyYzdwSjFPZTFZS3ZBQ2YvcXhrR2Z1Mnh2?=
 =?utf-8?B?WVVkN2x2OEVJaFNTU3NEek5iMjl1UHdjbktiaXdLNWYvdVRQZDdJQmQ0TWdM?=
 =?utf-8?B?N2hZb2lKYlB3SVcxcDFneXpNTUMwSVl6ODRabGhRQmowbmJEOTU1OVYrVUJz?=
 =?utf-8?B?QS9BSzVkZTVOeFErRUwwejF3MFFHMEkzbVRxTXk1UmIyeVAxUDRGV2tyYjBj?=
 =?utf-8?B?cUxjWnJUcmlaQzBzRTdHeXlxeUFHMmd4Ujcyc2FySFp5YWZzeVY4ME8wdktI?=
 =?utf-8?B?TW5sZ21VRXo2SHVZcVQvTGFCS1pPRk1RZS8ya2IyS2lqUHUvU214eThNbjFz?=
 =?utf-8?B?RDNnVkdTU0dZcUxLdXFwSjNpdlRZdmFsOU9URElKTkc1dUk4dXMyaTlqWkVk?=
 =?utf-8?B?c0ozTnlFSEF1Y3JxOUU4bjlubzhBPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3019cdd6-66a7-4142-b8ca-08dd8ee89cfa
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 10:59:47.6760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sv4j6c3Ta3WHsZ3pf5VKW0wsXs8Xmn+r10P3FelVA6Ksbudu9Cq7Ro2N5bz0m5mWJDp8Y1hkTURxTsOcN5V3Y2VbdP6kqrtMzPWo393LuII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7780



On 5/9/25 16:28, Al Viro wrote:
> On Fri, May 09, 2025 at 09:26:28AM +0100, Al Viro wrote:
>> AFAICS, 9ffb14ef61ba "move_mount: allow to add a mount into an existing
>> group" breaks assertions on ->mnt_share/->mnt_slave.  For once, the data
>> structures in question are actually documented.
>>
>> Documentation/filesystem/sharedsubtree.rst:
>>          All vfsmounts in a peer group have the same ->mnt_master.  If it is
>> 	non-NULL, they form a contiguous (ordered) segment of slave list.
>>
>> fs/pnode.c:
>>   * Note that peer groups form contiguous segments of slave lists.
>>
>> fs/namespace.c:do_set_group():
>>          if (IS_MNT_SLAVE(from)) {
>>                  struct mount *m = from->mnt_master;
>>
>>                  list_add(&to->mnt_slave, &m->mnt_slave_list);
>>                  to->mnt_master = m;
>>          }
>>
>>          if (IS_MNT_SHARED(from)) {
>>                  to->mnt_group_id = from->mnt_group_id;
>>                  list_add(&to->mnt_share, &from->mnt_share);
>>                  lock_mount_hash();
>>                  set_mnt_shared(to);
>>                  unlock_mount_hash();
>>          }
>>
>> Note that 'to' goes right after 'from' in ->mnt_share (i.e. peer group
>> list) and into the beginning of the slave list 'from' belongs to.  IOW,
>> contiguity gets broken if 'from' is both IS_MNT_SLAVE and IS_MNT_SHARED.
>> Which is what happens when the peer group 'from' is in gets propagation
>> from somewhere.

Agreed, list ordering consistency looks broken by my commit.

>>
>> It's not hard to fix - something like
>>
>>          if (IS_MNT_SHARED(from)) {
>> 		to->mnt_group_id = from->mnt_group_id;
>>                  list_add(&to->mnt_share, &from->mnt_share);
>> 		if (IS_MNT_SLAVE(from))
>> 			list_add(&to->mnt_slave, &from->mnt_slave);
>> 		to->mnt_master = from->mnt_master;
>>                  lock_mount_hash();
>>                  set_mnt_shared(to);
>>                  unlock_mount_hash();
>>          } else if (IS_MNT_SLAVE(from)) {
>> 		to->mnt_master = from->mnt_master;
>> 		list_add(&to->mnt_slave, &from->mnt_master->mnt_slave_list);
>> 	}
>>
>> ought to do it.

Yes it should work.

In case (IS_MNT_SLAVE(from) && !IS_MNT_SHARED(from)) we can probably 
also do:

list_add(&to->mnt_slave, &from->mnt_slave);

as next slave after "from" is definitely not from the same shared group 
with "from" (as it's not in a shared group) so we won't break list 
continuity.

That will allow to simplify code change to:

         if (IS_MNT_SLAVE(from)) {
                 struct mount *m = from->mnt_master;

-                list_add(&to->mnt_slave, &m->mnt_slave_list);
+                list_add(&to->mnt_slave, &from->mnt_slave);
                 to->mnt_master = m;
         }

         if (IS_MNT_SHARED(from)) {
                 to->mnt_group_id = from->mnt_group_id;
                 list_add(&to->mnt_share, &from->mnt_share);
                 lock_mount_hash();
                 set_mnt_shared(to);
                 unlock_mount_hash();
         }

If I'm not missing something (didn't test yet).

>> I'm nowhere near sufficiently awake right now to put
>> together a regression test, but unless I'm missing something subtle, it
>> should be possible to get a fairly obvious breakage of propagate_mnt()
>> out of that...

I managed to see weird behavior like that:

# rmdir /tmp/{A,B,C,D,E,Z}
# unshare -m
mkdir /tmp/{A,B,C,D,E,Z}
mount --make-rprivate /
mount -t tmpfs tmpfs /tmp/A
mount --bind /tmp/A /tmp/Z
mount --make-shared /tmp/A
mount --bind /tmp/A /tmp/B
mount --make-slave /tmp/B
mount --make-shared /tmp/B
mount --bind /tmp/B /tmp/C
mount --bind /tmp/C /tmp/D
mount --bind /tmp/D /tmp/E
./setgroup-v2 /tmp/C /tmp/Z
mkdir /tmp/A/subdir
mount -t tmpfs tmpfs /tmp/A/subdir

This creates 16 subdir mounts instead of expected 6:

cat /proc/self/mountinfo | grep /tmp/
1071 1065 0:109 / /tmp/A rw,relatime shared:556 - tmpfs tmpfs 
rw,seclabel,inode64
1073 1065 0:109 / /tmp/Z rw,relatime shared:1040 master:556 - tmpfs 
tmpfs rw,seclabel,inode64
1076 1065 0:109 / /tmp/B rw,relatime shared:1040 master:556 - tmpfs 
tmpfs rw,seclabel,inode64
1077 1065 0:109 / /tmp/C rw,relatime shared:1040 master:556 - tmpfs 
tmpfs rw,seclabel,inode64
1078 1065 0:109 / /tmp/D rw,relatime shared:1040 master:556 - tmpfs 
tmpfs rw,seclabel,inode64
1079 1065 0:109 / /tmp/E rw,relatime shared:1040 master:556 - tmpfs 
tmpfs rw,seclabel,inode64
1080 1071 0:136 / /tmp/A/subdir rw,relatime shared:1041 - tmpfs tmpfs 
rw,seclabel,inode64
1081 1073 0:136 / /tmp/Z/subdir rw,relatime shared:1042 master:1041 - 
tmpfs tmpfs rw,seclabel,inode64
1082 1078 0:136 / /tmp/D/subdir rw,relatime shared:1042 master:1041 - 
tmpfs tmpfs rw,seclabel,inode64
1083 1079 0:136 / /tmp/E/subdir rw,relatime shared:1042 master:1041 - 
tmpfs tmpfs rw,seclabel,inode64
1084 1076 0:136 / /tmp/B/subdir rw,relatime shared:1042 master:1041 - 
tmpfs tmpfs rw,seclabel,inode64
1085 1077 0:136 / /tmp/C/subdir rw,relatime shared:1042 master:1041 - 
tmpfs tmpfs rw,seclabel,inode64
1086 1084 0:136 / /tmp/B/subdir rw,relatime shared:1042 master:1041 - 
tmpfs tmpfs rw,seclabel,inode64
1087 1085 0:136 / /tmp/C/subdir rw,relatime shared:1042 master:1041 - 
tmpfs tmpfs rw,seclabel,inode64
1088 1081 0:136 / /tmp/Z/subdir rw,relatime shared:1042 master:1041 - 
tmpfs tmpfs rw,seclabel,inode64
1089 1082 0:136 / /tmp/D/subdir rw,relatime shared:1042 master:1041 - 
tmpfs tmpfs rw,seclabel,inode64
1090 1083 0:136 / /tmp/E/subdir rw,relatime shared:1042 master:1041 - 
tmpfs tmpfs rw,seclabel,inode64
1142 1089 0:136 / /tmp/D/subdir rw,relatime shared:1042 master:1041 - 
tmpfs tmpfs rw,seclabel,inode64
1143 1090 0:136 / /tmp/E/subdir rw,relatime shared:1042 master:1041 - 
tmpfs tmpfs rw,seclabel,inode64
1144 1086 0:136 / /tmp/B/subdir rw,relatime shared:1042 master:1041 - 
tmpfs tmpfs rw,seclabel,inode64
1145 1087 0:136 / /tmp/C/subdir rw,relatime shared:1042 master:1041 - 
tmpfs tmpfs rw,seclabel,inode64
1146 1088 0:136 / /tmp/Z/subdir rw,relatime shared:1042 master:1041 - 
tmpfs tmpfs rw,seclabel,inode64

Maybe that can be converted to a regression test.

> 
> Not sufficiently awake is right - wrong address on Cc...  Anyway, bedtime
> for me...



-- 
Best regards, Pavel Tikhomirov
Senior Software Developer, Virtuozzo.


