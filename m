Return-Path: <linux-fsdevel+bounces-48450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC72AAF4AA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 09:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 349891BC4AED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 07:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9F821D596;
	Thu,  8 May 2025 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YZUJG/Mv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C320C288A8
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 07:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746689474; cv=fail; b=cvghCxu6rmqm1jqc5YzPA/KdYjQgC5dOs+wyTc6RhyXV7kfnIoKB+2E4rQrw7Z06dZySE2ODZ25xqcizsV4Pe+ZzXltLRLL5ZAM2w/MYvgRQggQj61WMfMxUsuPWm4ncwT9WQeQRHc5egp20uuLBLlpGmSTVfyB/XQzSwHW7KiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746689474; c=relaxed/simple;
	bh=Yknz5OXm2+7GH2Xvimq0/xKSCAwDGmwrokj9163YsgE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZJ0Da6bRzB3ULi7j10tBs1qDOnm6LcdlkhWj2hBR5mLvirFj7KJrssogPJkaDxUfGRXLghX4MeQrR9S+RIFPTlz8w9eFfFsoylVqKalwjoln6TnGa88AtNG1wFM5nSuhbQkprc0Sl+6O6V9D8WdqkDdM4GlNjy15jHtIhprnCUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YZUJG/Mv; arc=fail smtp.client-ip=40.107.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bsQgY3OGjzFbQYrSooSuumBz75wfuMTIlmjgnqntghjBbIP+NcRrx2GLKn+1LTJcNHGAlJAZV4yQf3pw7MLhCQBb88ruYHKh17KxxKqepcga+X5J0zEOT83Lpr7ERpFJ3tXwA/4GQ/QgjEYNAtsoStxYa1W0Aq1bUGA19nJnhic44TEbOk+C0BxjTgQoKehnZsd6gYc5xdE3R559wmrlV8SWyS3+zHY73VH1tsqFAQP8i8RZlUhYTl2YeY0hLdM5/OX9koDwFRumBEhTlFhEoIPEIEEJiOPBthgJzNywvFHCQXj81NKuvlasbwrs0Gsd0CjflR8WfrDbMnbo9xZMBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJaoE/PUC4L0uFovdgzmEZZ79vrrtJZAryVukV6QlGQ=;
 b=IafC6J6Dd3jhYJv+hOtcNJYs0/t6zr8gmlbkqCG5TVZH3pL2Tx79qK7xdzBy5KlT2tFpOBjSsZfEhR2RcAF/mm5Mxrxlq4G1gLILObinPhzrfoPpCfy/IStFesdJa78EqGo4DYVfJvwEe49dcwjdk8lMnZc9QRGRj54aVp6MLKgAaQeYRCzdh8W4DXsim6MExIQKFQmnZRT1KgMDj3KYQK6T0r9uxhMcs9s2Uo8z+GqQ4mMfXi9hegbT5MJ9qlzKlnp4R29aYXS0I9WfIu+liUQ/Pe9oYTP4sLduGAwVGo2zkyPPk2JijkS5TImmqqUa8rBZ/APBSLoUYJb2nWFd4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJaoE/PUC4L0uFovdgzmEZZ79vrrtJZAryVukV6QlGQ=;
 b=YZUJG/Mv5YhfpN+zp8uRkMYMeGgjb/umQMGSL8/htQWU2glUhEHzHM7Lv0252tjwFKYBrBkw2EFhr2cM6MpZPASkzxzv29kzGO5VEu7vjgW5gcoTSzPoZ7qo4Aeg8q9CHgtgR7M4SG2ynVc24WltSEulKubtaTuekkBGrMVqEoM3f8PXLtwDsbHiKQ250HcPha+uDgh1JyyrkbPA02mv1xjUyYeURoiHUsThaNM6eOlzTKnb1TjwzA0xLDDytANSLQvFeiY3uiS6mfsXkjcDa+9VxebniO/QysgJAGzEW6nVj6fb0N8vvKKrK6+S7LcoYTtxI9IXsmbtHVqYuozn3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by CH3PR12MB8354.namprd12.prod.outlook.com (2603:10b6:610:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 07:31:01 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%7]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 07:31:00 +0000
Message-ID: <ad3c6713-1b4b-47e4-983b-d5f3903de4d0@nvidia.com>
Date: Thu, 8 May 2025 00:30:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] selftests/fs/statmount: build with tools include dir
To: Amir Goldstein <amir73il@gmail.com>,
 Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org
References: <20250507204302.460913-1-amir73il@gmail.com>
 <20250507204302.460913-3-amir73il@gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20250507204302.460913-3-amir73il@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:a03:180::21) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|CH3PR12MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e2cbe8b-47ca-46fb-023c-08dd8e02481d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzlWTUp3dUhmRUdzNzNKRUxleThpM3JhN0VQdG4wMXJndkRRcmIyTi9ZVVRo?=
 =?utf-8?B?N3daeTdoOUJ1eHp4aWNOUElLeG5CVkpONTFYM3BrY2hxV1BTY3lWMlZBZHNh?=
 =?utf-8?B?dy92RHZ5Tmp2QUZXc1JhSE80emxkUFFCT1ZhRmlyQWxsbkFGU2hnOGg1WUxw?=
 =?utf-8?B?VnRmSE9oSTFUWjkyQjYyVXVQMENQYlFyMU9nSGlpbXcyOTkvSmVZaEFpdVFR?=
 =?utf-8?B?NGsrYVJIZGp6c2VNSDVWZVgyaGlEakJZR3dMRU5EWm03MHA1Qm9vZmEzSnRv?=
 =?utf-8?B?MjZ6czBlLzVjVnVKUzJJZW54ZzY2RTV5d2xscUhTWWszaFJNS2hieE9TQ2hJ?=
 =?utf-8?B?WFoxaXBwczBXRmppWkpkaHFZRC8yNHEzd3FjenVaai9mR2ZNc3RsNmxzMlMx?=
 =?utf-8?B?aVcwLzRxeVliRDJ3dS9rNS9laWtxOHdSOWFvRXZPRmJBZnNJUSs0aXRIVEJM?=
 =?utf-8?B?a1FEWEVnYVZJSnZodklYOEt3MnpLUnhGSm56bjl5dHE1cmxEZk92bWFzeVpk?=
 =?utf-8?B?UGlRb1R4MjMrRmo3SHFEc1U3WmRueWNlYmhuRm0vL095ZjRGTjNtckdUbVRz?=
 =?utf-8?B?cHFyZmZJN1RiMUNpOE9QVktLd2lCVExQYVBPdFg1RmZBT0ZXVStIVUdnRHBG?=
 =?utf-8?B?Q09yVFM0M2sxaXhwdi81ODUxbXBzemdzSXl1N1dHa3hMaGVKcHllVzF4Y1Az?=
 =?utf-8?B?K0xKNTY2SncxUHZXN21jWWllTE5iM0haa0x2OFMybStrb0tvZ09JK0dydE82?=
 =?utf-8?B?bHNlODZaa0JXdHRsVEdlb3YrNmJGVXB0WStMMWZWdTlSL0hUa20vdVlkK09C?=
 =?utf-8?B?cGpUN1I1aXg2MkJkSmxNSjd4TGZqMzdpN0tMY1FwK0E5N3FjVjBjaVFGYytI?=
 =?utf-8?B?cmIyWDBLMlUzM2Y5TXhUVmtzb1V4N1pwV1NEZU5mQkhQSUF4M0d0MzIxejBW?=
 =?utf-8?B?TUJEem5JVUExelBKamFJanVKd0ZrS0c3bUJvczZVU1cycSs4MmlqZmo4a3Jz?=
 =?utf-8?B?ZDBMZjZ5b2RlRVUrLzNOTm5CeFBKaGdsNHRFeEI1Vk9FUXdYanVvMVczbjZE?=
 =?utf-8?B?SGZ6MlVLR2daY1RnTWpKSVpadXh4SVNVUUJNVVAvMkVtSjJiUEdBbWdzazls?=
 =?utf-8?B?WkNWcUt5SnQrVy9DOUhURmIrSmVweVBJcEhVZm1OaG1Pb2d1bm4rTTFPamNs?=
 =?utf-8?B?cnc1WW41bXphR3g5WXNUemtrcnFJUCtMZmhYMWhVNm5EdktneDkyMzhYQm5i?=
 =?utf-8?B?eUJpaHRIbmh3NVNlZ09ydlNKcFpXMXI0T2JxN3NSVVU4MVhBVTc4bGZMMi8w?=
 =?utf-8?B?MjZ3czNNSzQ0TytBdFBmQ09rQ3VBL2FDZlhDZXlJSExEK3o3bzdFRHgrbEM5?=
 =?utf-8?B?MGY0UkNRNHZzRmZ1bXpWd1Jib2lmcFlSMWVhdXc1KzFOMzluLytUQ1p6bWQz?=
 =?utf-8?B?NWlaRjNRTEFmV2JMZkpJeUlFVGEyQ3pQSkVXT2JJemNwdk53eGFGMHpsWS9O?=
 =?utf-8?B?UDg0aElSZ0dZUFN3eFVIQmhNejJTSzZGVEJ4MnFFMkxXOTJwTGZIZ04waDR3?=
 =?utf-8?B?NFhQSnNEbXdMaUNiNkNFc21qQlJjbmI3MnhNaFNFVUVVWlN1MU5ObE5zYmEw?=
 =?utf-8?B?ZXRvWFJtYXJFdHRzcHB1WlRpNVVCbERSK0Vqbno4MjNEWWJzdFBpbTFGbnoz?=
 =?utf-8?B?NE81S0h0OVFjZ0pEK2xnbzUxZzJQTDllczdKdHRIWkUwSGduVzh2Z0VCMisv?=
 =?utf-8?B?Y2c4UExuWENOb1Vla3N4dXhxWWxSL0h5SDNkZ1phWS9COFdkWUFhUUxIL0JK?=
 =?utf-8?B?RXhQb2xGN2ZLb3QxYS9QRmNzOEdSS2MvUVJ6RFI1Z3MxeVBkOFd5RUdrdldj?=
 =?utf-8?B?Nm51UVZCcVhPYUNGVFhQaUQwTVpRNStKNGh4OXVEZHM0UWEzS0V6UVk3aE1S?=
 =?utf-8?Q?5MqBCYBglxg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1JGMVRURUo3M0wrb3VSY2pOWUgzbHI1dXl1cEN2ZDBFS3ZMQ01XaUd6bW9V?=
 =?utf-8?B?bHdNMkNiNy94TWNqRGE0M1dtU21XKzNNNG0zT1lKN2dHcVlyUWhUZnVhZmsv?=
 =?utf-8?B?MjRuWjc2YmNIM0NQWFFIY0hPNkE2R2kzNlpIS08xMUluRDF4WVE4QzlhbWFs?=
 =?utf-8?B?ZGl2azcvbU10MXF3MUZRenJQdytMM1MwNlRFd0V3TGFCQUFzSWU0M0x6QjlD?=
 =?utf-8?B?cTBteTI5RmFDeDBMVytPTzhyUDVWSXgyRVdFajkvYVAwMkVyU29jcmhteHd4?=
 =?utf-8?B?TEZaRVNrRW44YWgyeWY0SXVaL0VuZytOM2djdGVhbzJOTzdyOXpvRlhPeUdn?=
 =?utf-8?B?TnFBT3pXMzlZWUNzL3BJMlZQNDRXR1NsbFZIandtUER2aEJCS1cxMHRKM2tu?=
 =?utf-8?B?c1duRzl1YVlTVkJuRU55RE9mNExWUDlUU0FUZXFEaUI2VWpqQzQ0enoyYWQw?=
 =?utf-8?B?S3FxNEQ5eWhhNWFDN3oySE5mWjFIUGFmVGFQZDVadU93UEpzOXJrSkVkN29Q?=
 =?utf-8?B?cTl4K09HQWI2aGh5VjQvOGxNZys0a3VSamU2VUZBc002U3FWOUtwOU4zRlV2?=
 =?utf-8?B?NXI3anRUWjV1MDFMZkhqRXkxSCtGV2xwT0ZlS09sWVY1Yy8xRlVZU3gzd2Vz?=
 =?utf-8?B?S1hrT3ZXSDlkb2U2dDFzTHJIZEg4ZlFMQmd2NzVnRGY0UUtXL21HNFBwejJ3?=
 =?utf-8?B?NVhUWXR2aHk4SEJ1YkpDcWFVRm5sd1FVb0FYWWkvMmRtMndLaWJIbXhpVHAx?=
 =?utf-8?B?c1VzcnJ6b3ZyZVB1cGsrd3A5WmsyNHJuSDdmNDFDT2Z1bkNxaEhsVEJ0UFJD?=
 =?utf-8?B?WmtDeUVQRWVNdy9ERkd1NVAzUHZYMW1lbjJsSVRHNHR1T3B4ZFU4R0hFUTF4?=
 =?utf-8?B?RW1oeXZ3QWpaTlVWbCtQMVFVbmFOeEs0MVNSeWF1TkZFRUZyWkVtV2oydFBZ?=
 =?utf-8?B?bVNZdytvRUdJdWFySG15TE55U0xqYkFIYk1DZXRHSi9ORWxmOHlTQ3Nib3JS?=
 =?utf-8?B?WnZmTzliU2JqZ2dvL0JSaXc4SkdWbU9WL3NRcmR0aDNYUE03M0N3RlRrUTl6?=
 =?utf-8?B?R2RmTXRqazVFNDJHdytBaGF0Y2lmaThqRTNacnFhTWVYUkRoQ1BSTjJTMzFO?=
 =?utf-8?B?QitBSUJEclMvcDkxTmlvNURBWnF1dkV3eGdCb1YrckE5a04vNG40WURwelpo?=
 =?utf-8?B?QXhiejNZcFhPMTZsVFp1V0lpdVRmY2xXejQ5Mk1ORmk4UXVtQW1NcnQxbmJp?=
 =?utf-8?B?RDhGUTBKWFZHWG5zM2twUGVJSDYrU1RaQ1NHK3VSTWVrbVVxbjVzSTZQSmZx?=
 =?utf-8?B?WGRESkUvbE5ST1dJV0xyc3l2bENPQnUzYUxRNm5Ocnl3UlVjOSttSmVOd0di?=
 =?utf-8?B?WmVVaHc1RjRTMjhEOXloNURCaEE1WHc2ckhTa0ZJL003OUUrVVkyQ2wyUE40?=
 =?utf-8?B?TmxTNzVjck1xcDlra25jdjFSM09ZK1EraWIyS2dhaEU5RzNyajFDQ1lDaTBB?=
 =?utf-8?B?Rm9reWpyUXYrSkkyVlh2c2I1aU81VGx0bUJSR1VwdFRIODFkSENzYXFHTisx?=
 =?utf-8?B?UXlsczNKWXFNWDB4UDNndEhFZTJkOE1UMUpYdmxrbEMvN2Zlb0NSMU56aG9F?=
 =?utf-8?B?dmNTNlVZelBMakszbUIyRTJERHA0b0diZ2lNMmpZb1VOWW53c25WV2lrTCs1?=
 =?utf-8?B?VUFHbFNRWTRYUi9RbjJYb2VPMWdYekF3YUJ4OGpCcUFuT3VlZlR0a0pKcFds?=
 =?utf-8?B?ZFV3TkxqNmwxaCs5MTZaUmtEeFFOK3RqZXh1TW1mUy9QY20yQ0FMY2JXbVRz?=
 =?utf-8?B?S2lGQTI1dDVpMkJWTXh5VUVKODVkVkpZZzlDVUJLZDBOSjNYTkFUY2w0SXlK?=
 =?utf-8?B?M1pQejhaU091SStXYWp6Rlg2aFJYSlI5Ni9qd0gxOC9XR2FUZTNtWmxaVUxL?=
 =?utf-8?B?RHQxeGpxVWhSUDlTRVpGMTlJejdwTWZaQnoxNkJFRXAwdSsvMTVzako2dWJu?=
 =?utf-8?B?dlk2bnZIWDAvd0ptMzdMS0FLL3NXblBnb2U3bGt5ZzYxZWFCWG54emJqRVlH?=
 =?utf-8?B?Y3JjTlhUWm85cUZobklHUHN3ZzVtZ1hDRlN2STdMcDgyaG9nWEpFMTNGZm1D?=
 =?utf-8?B?Q0VCOUhvK01Xb3l6N3JYMFVRVSsydWxSUUZsMFhTZ0YzSU9qVUVTbmtlS1ln?=
 =?utf-8?B?SHc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2cbe8b-47ca-46fb-023c-08dd8e02481d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 07:31:00.8718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ap7J0rckRe1HN6ZErZmfbby0dHReUaYAQvNveG2hupmxx28/reuUJ9S07wC7ixO6otqufq+HML+QAKh0szkkfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8354

On 5/7/25 1:42 PM, Amir Goldstein wrote:
> Copy the required headers files (mount.h, nsfs.h) to the
> tools include dir and define the statmount/listmount syscalls
> for x86_64 to decouple dependency with headers_install for the
> common case.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>   tools/include/uapi/linux/mount.h              | 235 ++++++++++++++++++
>   tools/include/uapi/linux/nsfs.h               |  45 ++++
>   .../selftests/filesystems/statmount/Makefile  |   3 +-
>   .../filesystems/statmount/statmount.h         |  12 +
>   4 files changed, 294 insertions(+), 1 deletion(-)
>   create mode 100644 tools/include/uapi/linux/mount.h
>   create mode 100644 tools/include/uapi/linux/nsfs.h
> 
> diff --git a/tools/include/uapi/linux/mount.h b/tools/include/uapi/linux/mount.h
> new file mode 100644
> index 000000000000..7fa67c2031a5
> --- /dev/null
> +++ b/tools/include/uapi/linux/mount.h
> @@ -0,0 +1,235 @@
> +#ifndef _UAPI_LINUX_MOUNT_H
> +#define _UAPI_LINUX_MOUNT_H
> +
> +#include <linux/types.h>
> +
> +/*
> + * These are the fs-independent mount-flags: up to 32 flags are supported
> + *
> + * Usage of these is restricted within the kernel to core mount(2) code and
> + * callers of sys_mount() only.  Filesystems should be using the SB_*
> + * equivalent instead.
> + */
> +#define MS_RDONLY	 1	/* Mount read-only */
> +#define MS_NOSUID	 2	/* Ignore suid and sgid bits */
> +#define MS_NODEV	 4	/* Disallow access to device special files */
> +#define MS_NOEXEC	 8	/* Disallow program execution */
> +#define MS_SYNCHRONOUS	16	/* Writes are synced at once */
> +#define MS_REMOUNT	32	/* Alter flags of a mounted FS */
> +#define MS_MANDLOCK	64	/* Allow mandatory locks on an FS */
> +#define MS_DIRSYNC	128	/* Directory modifications are synchronous */
> +#define MS_NOSYMFOLLOW	256	/* Do not follow symlinks */
> +#define MS_NOATIME	1024	/* Do not update access times. */
> +#define MS_NODIRATIME	2048	/* Do not update directory access times */
> +#define MS_BIND		4096
> +#define MS_MOVE		8192
> +#define MS_REC		16384
> +#define MS_VERBOSE	32768	/* War is peace. Verbosity is silence.
> +				   MS_VERBOSE is deprecated. */
> +#define MS_SILENT	32768
> +#define MS_POSIXACL	(1<<16)	/* VFS does not apply the umask */
> +#define MS_UNBINDABLE	(1<<17)	/* change to unbindable */
> +#define MS_PRIVATE	(1<<18)	/* change to private */
> +#define MS_SLAVE	(1<<19)	/* change to slave */
> +#define MS_SHARED	(1<<20)	/* change to shared */
> +#define MS_RELATIME	(1<<21)	/* Update atime relative to mtime/ctime. */
> +#define MS_KERNMOUNT	(1<<22) /* this is a kern_mount call */
> +#define MS_I_VERSION	(1<<23) /* Update inode I_version field */
> +#define MS_STRICTATIME	(1<<24) /* Always perform atime updates */
> +#define MS_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
> +
> +/* These sb flags are internal to the kernel */
> +#define MS_SUBMOUNT     (1<<26)
> +#define MS_NOREMOTELOCK	(1<<27)
> +#define MS_NOSEC	(1<<28)
> +#define MS_BORN		(1<<29)
> +#define MS_ACTIVE	(1<<30)
> +#define MS_NOUSER	(1<<31)
> +
> +/*
> + * Superblock flags that can be altered by MS_REMOUNT
> + */
> +#define MS_RMT_MASK	(MS_RDONLY|MS_SYNCHRONOUS|MS_MANDLOCK|MS_I_VERSION|\
> +			 MS_LAZYTIME)
> +
> +/*
> + * Old magic mount flag and mask
> + */
> +#define MS_MGC_VAL 0xC0ED0000
> +#define MS_MGC_MSK 0xffff0000
> +
> +/*
> + * open_tree() flags.
> + */
> +#define OPEN_TREE_CLONE		1		/* Clone the target tree and attach the clone */
> +#define OPEN_TREE_CLOEXEC	O_CLOEXEC	/* Close the file on execve() */
> +
> +/*
> + * move_mount() flags.
> + */
> +#define MOVE_MOUNT_F_SYMLINKS		0x00000001 /* Follow symlinks on from path */
> +#define MOVE_MOUNT_F_AUTOMOUNTS		0x00000002 /* Follow automounts on from path */
> +#define MOVE_MOUNT_F_EMPTY_PATH		0x00000004 /* Empty from path permitted */
> +#define MOVE_MOUNT_T_SYMLINKS		0x00000010 /* Follow symlinks on to path */
> +#define MOVE_MOUNT_T_AUTOMOUNTS		0x00000020 /* Follow automounts on to path */
> +#define MOVE_MOUNT_T_EMPTY_PATH		0x00000040 /* Empty to path permitted */
> +#define MOVE_MOUNT_SET_GROUP		0x00000100 /* Set sharing group instead */
> +#define MOVE_MOUNT_BENEATH		0x00000200 /* Mount beneath top mount */
> +#define MOVE_MOUNT__MASK		0x00000377
> +
> +/*
> + * fsopen() flags.
> + */
> +#define FSOPEN_CLOEXEC		0x00000001
> +
> +/*
> + * fspick() flags.
> + */
> +#define FSPICK_CLOEXEC		0x00000001
> +#define FSPICK_SYMLINK_NOFOLLOW	0x00000002
> +#define FSPICK_NO_AUTOMOUNT	0x00000004
> +#define FSPICK_EMPTY_PATH	0x00000008
> +
> +/*
> + * The type of fsconfig() call made.
> + */
> +enum fsconfig_command {
> +	FSCONFIG_SET_FLAG	= 0,	/* Set parameter, supplying no value */
> +	FSCONFIG_SET_STRING	= 1,	/* Set parameter, supplying a string value */
> +	FSCONFIG_SET_BINARY	= 2,	/* Set parameter, supplying a binary blob value */
> +	FSCONFIG_SET_PATH	= 3,	/* Set parameter, supplying an object by path */
> +	FSCONFIG_SET_PATH_EMPTY	= 4,	/* Set parameter, supplying an object by (empty) path */
> +	FSCONFIG_SET_FD		= 5,	/* Set parameter, supplying an object by fd */
> +	FSCONFIG_CMD_CREATE	= 6,	/* Create new or reuse existing superblock */
> +	FSCONFIG_CMD_RECONFIGURE = 7,	/* Invoke superblock reconfiguration */
> +	FSCONFIG_CMD_CREATE_EXCL = 8,	/* Create new superblock, fail if reusing existing superblock */
> +};
> +
> +/*
> + * fsmount() flags.
> + */
> +#define FSMOUNT_CLOEXEC		0x00000001
> +
> +/*
> + * Mount attributes.
> + */
> +#define MOUNT_ATTR_RDONLY	0x00000001 /* Mount read-only */
> +#define MOUNT_ATTR_NOSUID	0x00000002 /* Ignore suid and sgid bits */
> +#define MOUNT_ATTR_NODEV	0x00000004 /* Disallow access to device special files */
> +#define MOUNT_ATTR_NOEXEC	0x00000008 /* Disallow program execution */
> +#define MOUNT_ATTR__ATIME	0x00000070 /* Setting on how atime should be updated */
> +#define MOUNT_ATTR_RELATIME	0x00000000 /* - Update atime relative to mtime/ctime. */
> +#define MOUNT_ATTR_NOATIME	0x00000010 /* - Do not update access times. */
> +#define MOUNT_ATTR_STRICTATIME	0x00000020 /* - Always perform atime updates */
> +#define MOUNT_ATTR_NODIRATIME	0x00000080 /* Do not update directory access times */
> +#define MOUNT_ATTR_IDMAP	0x00100000 /* Idmap mount to @userns_fd in struct mount_attr. */
> +#define MOUNT_ATTR_NOSYMFOLLOW	0x00200000 /* Do not follow symlinks */
> +
> +/*
> + * mount_setattr()
> + */
> +struct mount_attr {
> +	__u64 attr_set;
> +	__u64 attr_clr;
> +	__u64 propagation;
> +	__u64 userns_fd;
> +};
> +
> +/* List of all mount_attr versions. */
> +#define MOUNT_ATTR_SIZE_VER0	32 /* sizeof first published struct */
> +
> +
> +/*
> + * Structure for getting mount/superblock/filesystem info with statmount(2).
> + *
> + * The interface is similar to statx(2): individual fields or groups can be
> + * selected with the @mask argument of statmount().  Kernel will set the @mask
> + * field according to the supported fields.
> + *
> + * If string fields are selected, then the caller needs to pass a buffer that
> + * has space after the fixed part of the structure.  Nul terminated strings are
> + * copied there and offsets relative to @str are stored in the relevant fields.
> + * If the buffer is too small, then EOVERFLOW is returned.  The actually used
> + * size is returned in @size.
> + */
> +struct statmount {
> +	__u32 size;		/* Total size, including strings */
> +	__u32 mnt_opts;		/* [str] Options (comma separated, escaped) */
> +	__u64 mask;		/* What results were written */
> +	__u32 sb_dev_major;	/* Device ID */
> +	__u32 sb_dev_minor;
> +	__u64 sb_magic;		/* ..._SUPER_MAGIC */
> +	__u32 sb_flags;		/* SB_{RDONLY,SYNCHRONOUS,DIRSYNC,LAZYTIME} */
> +	__u32 fs_type;		/* [str] Filesystem type */
> +	__u64 mnt_id;		/* Unique ID of mount */
> +	__u64 mnt_parent_id;	/* Unique ID of parent (for root == mnt_id) */
> +	__u32 mnt_id_old;	/* Reused IDs used in proc/.../mountinfo */
> +	__u32 mnt_parent_id_old;
> +	__u64 mnt_attr;		/* MOUNT_ATTR_... */
> +	__u64 mnt_propagation;	/* MS_{SHARED,SLAVE,PRIVATE,UNBINDABLE} */
> +	__u64 mnt_peer_group;	/* ID of shared peer group */
> +	__u64 mnt_master;	/* Mount receives propagation from this ID */
> +	__u64 propagate_from;	/* Propagation from in current namespace */
> +	__u32 mnt_root;		/* [str] Root of mount relative to root of fs */
> +	__u32 mnt_point;	/* [str] Mountpoint relative to current root */
> +	__u64 mnt_ns_id;	/* ID of the mount namespace */
> +	__u32 fs_subtype;	/* [str] Subtype of fs_type (if any) */
> +	__u32 sb_source;	/* [str] Source string of the mount */
> +	__u32 opt_num;		/* Number of fs options */
> +	__u32 opt_array;	/* [str] Array of nul terminated fs options */
> +	__u32 opt_sec_num;	/* Number of security options */
> +	__u32 opt_sec_array;	/* [str] Array of nul terminated security options */
> +	__u64 supported_mask;	/* Mask flags that this kernel supports */
> +	__u32 mnt_uidmap_num;	/* Number of uid mappings */
> +	__u32 mnt_uidmap;	/* [str] Array of uid mappings (as seen from callers namespace) */
> +	__u32 mnt_gidmap_num;	/* Number of gid mappings */
> +	__u32 mnt_gidmap;	/* [str] Array of gid mappings (as seen from callers namespace) */
> +	__u64 __spare2[43];
> +	char str[];		/* Variable size part containing strings */
> +};
> +
> +/*
> + * Structure for passing mount ID and miscellaneous parameters to statmount(2)
> + * and listmount(2).
> + *
> + * For statmount(2) @param represents the request mask.
> + * For listmount(2) @param represents the last listed mount id (or zero).
> + */
> +struct mnt_id_req {
> +	__u32 size;
> +	__u32 spare;
> +	__u64 mnt_id;
> +	__u64 param;
> +	__u64 mnt_ns_id;
> +};
> +
> +/* List of all mnt_id_req versions. */
> +#define MNT_ID_REQ_SIZE_VER0	24 /* sizeof first published struct */
> +#define MNT_ID_REQ_SIZE_VER1	32 /* sizeof second published struct */
> +
> +/*
> + * @mask bits for statmount(2)
> + */
> +#define STATMOUNT_SB_BASIC		0x00000001U     /* Want/got sb_... */
> +#define STATMOUNT_MNT_BASIC		0x00000002U	/* Want/got mnt_... */
> +#define STATMOUNT_PROPAGATE_FROM	0x00000004U	/* Want/got propagate_from */
> +#define STATMOUNT_MNT_ROOT		0x00000008U	/* Want/got mnt_root  */
> +#define STATMOUNT_MNT_POINT		0x00000010U	/* Want/got mnt_point */
> +#define STATMOUNT_FS_TYPE		0x00000020U	/* Want/got fs_type */
> +#define STATMOUNT_MNT_NS_ID		0x00000040U	/* Want/got mnt_ns_id */
> +#define STATMOUNT_MNT_OPTS		0x00000080U	/* Want/got mnt_opts */
> +#define STATMOUNT_FS_SUBTYPE		0x00000100U	/* Want/got fs_subtype */
> +#define STATMOUNT_SB_SOURCE		0x00000200U	/* Want/got sb_source */
> +#define STATMOUNT_OPT_ARRAY		0x00000400U	/* Want/got opt_... */
> +#define STATMOUNT_OPT_SEC_ARRAY		0x00000800U	/* Want/got opt_sec... */
> +#define STATMOUNT_SUPPORTED_MASK	0x00001000U	/* Want/got supported mask flags */
> +#define STATMOUNT_MNT_UIDMAP		0x00002000U	/* Want/got uidmap... */
> +#define STATMOUNT_MNT_GIDMAP		0x00004000U	/* Want/got gidmap... */
> +
> +/*
> + * Special @mnt_id values that can be passed to listmount
> + */
> +#define LSMT_ROOT		0xffffffffffffffff	/* root mount */
> +#define LISTMOUNT_REVERSE	(1 << 0) /* List later mounts first */
> +
> +#endif /* _UAPI_LINUX_MOUNT_H */
> diff --git a/tools/include/uapi/linux/nsfs.h b/tools/include/uapi/linux/nsfs.h
> new file mode 100644
> index 000000000000..34127653fd00
> --- /dev/null
> +++ b/tools/include/uapi/linux/nsfs.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef __LINUX_NSFS_H
> +#define __LINUX_NSFS_H
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +#define NSIO	0xb7
> +
> +/* Returns a file descriptor that refers to an owning user namespace */
> +#define NS_GET_USERNS		_IO(NSIO, 0x1)
> +/* Returns a file descriptor that refers to a parent namespace */
> +#define NS_GET_PARENT		_IO(NSIO, 0x2)
> +/* Returns the type of namespace (CLONE_NEW* value) referred to by
> +   file descriptor */
> +#define NS_GET_NSTYPE		_IO(NSIO, 0x3)
> +/* Get owner UID (in the caller's user namespace) for a user namespace */
> +#define NS_GET_OWNER_UID	_IO(NSIO, 0x4)
> +/* Get the id for a mount namespace */
> +#define NS_GET_MNTNS_ID		_IOR(NSIO, 0x5, __u64)
> +/* Translate pid from target pid namespace into the caller's pid namespace. */
> +#define NS_GET_PID_FROM_PIDNS	_IOR(NSIO, 0x6, int)
> +/* Return thread-group leader id of pid in the callers pid namespace. */
> +#define NS_GET_TGID_FROM_PIDNS	_IOR(NSIO, 0x7, int)
> +/* Translate pid from caller's pid namespace into a target pid namespace. */
> +#define NS_GET_PID_IN_PIDNS	_IOR(NSIO, 0x8, int)
> +/* Return thread-group leader id of pid in the target pid namespace. */
> +#define NS_GET_TGID_IN_PIDNS	_IOR(NSIO, 0x9, int)
> +
> +struct mnt_ns_info {
> +	__u32 size;
> +	__u32 nr_mounts;
> +	__u64 mnt_ns_id;
> +};
> +
> +#define MNT_NS_INFO_SIZE_VER0 16 /* size of first published struct */
> +
> +/* Get information about namespace. */
> +#define NS_MNT_GET_INFO		_IOR(NSIO, 10, struct mnt_ns_info)
> +/* Get next namespace. */
> +#define NS_MNT_GET_NEXT		_IOR(NSIO, 11, struct mnt_ns_info)
> +/* Get previous namespace. */
> +#define NS_MNT_GET_PREV		_IOR(NSIO, 12, struct mnt_ns_info)
> +
> +#endif /* __LINUX_NSFS_H */
> diff --git a/tools/testing/selftests/filesystems/statmount/Makefile b/tools/testing/selftests/filesystems/statmount/Makefile
> index 14ee91a41650..19adebfc2620 100644
> --- a/tools/testing/selftests/filesystems/statmount/Makefile
> +++ b/tools/testing/selftests/filesystems/statmount/Makefile
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   
> -CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
> +CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)

Yes. :)

> +
>   TEST_GEN_PROGS := statmount_test statmount_test_ns listmount_test
>   
>   include ../../lib.mk
> diff --git a/tools/testing/selftests/filesystems/statmount/statmount.h b/tools/testing/selftests/filesystems/statmount/statmount.h
> index a7a5289ddae9..e84d47fadd0b 100644
> --- a/tools/testing/selftests/filesystems/statmount/statmount.h
> +++ b/tools/testing/selftests/filesystems/statmount/statmount.h
> @@ -7,6 +7,18 @@
>   #include <linux/mount.h>
>   #include <asm/unistd.h>
>   
> +#ifndef __NR_statmount
> +#if defined(__x86_64__)
> +#define __NR_statmount	457
> +#endif
> +#endif
> +
> +#ifndef __NR_listmount
> +#if defined(__x86_64__)
> +#define __NR_listmount	458
> +#endif
> +#endif

Yes, syscalls are the weak point for this approach, and the above is
reasonable, given the situation, which is: we are not set up to recreate
per-arch syscall tables for kselftests to use. But this does leave the
other big arch out in the cold: arm64.

It's easy to add, though, if and when someone wants it.

> +
>   static inline int statmount(uint64_t mnt_id, uint64_t mnt_ns_id, uint64_t mask,
>   			    struct statmount *buf, size_t bufsize,
>   			    unsigned int flags)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard


