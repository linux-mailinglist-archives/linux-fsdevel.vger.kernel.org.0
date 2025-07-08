Return-Path: <linux-fsdevel+bounces-54229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6B8AFC4C0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 09:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33D031741FC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 07:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEB929B776;
	Tue,  8 Jul 2025 07:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pfWRhbny"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD76F221282;
	Tue,  8 Jul 2025 07:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961312; cv=fail; b=KJT3PPlPnPgTyTgyZtuIdexypj8fGIvG2kq6dgR0fPupV+wix+K9pOQnJUew+cZwdDd315iygLZ+BpSQUGObo/EHFMzLPMpqPD+9GHrYx6CspR4ISKDIOeoXRpQgHQwP8uKyZQpeTbr3tNFSAYF5wxPpwRMu7huWxDBTzc1rFCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961312; c=relaxed/simple;
	bh=tKZJW5GHNFa7t+9aVBgysLIzducnYO6kZ09X+e3JKk4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bz3llBYeesoM4jqQ+7h+u+lM9IA2qjqrEKSS80WaGp2GNUQhudSztPX6ZreoU1w8n2LWTtHXEMehlADiFPfGCX9Lu0LjmZ/S5i1CSRdX6W/bSFnKeKBgH0hKEEGW3fQ1Q8DxGeGt1pVLkHfp5dqFN3YiF7RlU+CAsIcnWQxL478=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pfWRhbny; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbILc29QP87V6uGlidCe7lnfzAk8xeH5Rrc3JgPxp4j2spqvLd+Auyast9bcu2HYYYuZZ7CqP62iHSbsAM3AvOlBdXp7SFLP/zLhecLVKKQIeO/1kZGLHNvbA2lRqTem9TFWr4y5EVs12U0gR3wtiuCGhi5lSCqiEjAGyRqdcR1tmodope/pNr4dIQC8fnmooIKSWZQDT3OFZek5Bx168EU9g8Lky5LrVfMEJDeCxtN8bl8A8d+wNRG+Kpcln/XFettOtNNYP51qVKQwKe9UrGFx3IU2fHaphIyC50e/WEUpDKTv4blzwNpAWVyQm3Yf51KGBEpDrUcEPq+jsNWYYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcOzfSIjjR52/L5D7hjCLCbJbNVpkhYR6KW5/6VTu3g=;
 b=mIkcKhW2Xh2TPipiHPbb5uANshf2PXl7rlwFzf72uIbXjpy/sKY9JWUMmGCi2o7fX7+rmAXn8qaIeQ1GbeFdleZzUj5e1smwSzLrU/aTav30agloRbFLG3OLlXWjmrGIocBfE9BUn5xtYSg6tPRcQmxLrwhkqwbA4iTv6dGD2rON4rTRbmmLKnMs0DQc7Czg5SNQIm4sfluiIh4PidUG4qwU/YU6N2UgctiGS2DgvZFPlBBE3VCK+Kup3ePrDoakYS1MURSlX2y3Yirn6dGc10E9RfwmBw1VSccrNE2Mz92FTkM7woaePnxC1FYJsCJAAz8GxysWOU7W9g/hceuZ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcOzfSIjjR52/L5D7hjCLCbJbNVpkhYR6KW5/6VTu3g=;
 b=pfWRhbnyZGDYVSdHn6iDAviSuACOqogtTRCqGWATW55P43ieLKE3lFMmMAnb+sNdlfxNdSvusb6My8jOsZV4p+ejlWuQDM5jSazpOydzr3yn/tgoWRCn8rns6IfgvplzmQLmpHDbzonU2fpVJnd99F0z71lb16n9dOs3NnLZYvQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa) by CYXPR12MB9279.namprd12.prod.outlook.com
 (2603:10b6:930:d5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 07:55:07 +0000
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf]) by SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf%8]) with mapi id 15.20.8722.031; Tue, 8 Jul 2025
 07:55:07 +0000
Message-ID: <d18973b8-3b52-4786-b5ab-94208495c8b0@amd.com>
Date: Tue, 8 Jul 2025 13:24:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] module: Restrict module namespace access to in-tree
 modules
To: Vlastimil Babka <vbabka@suse.cz>, Matthias Maennich
 <maennich@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
 Peter Zijlstra <peterz@infradead.org>, David Hildenbrand <david@redhat.com>,
 "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20250708-export_modules-v1-0-fbf7a282d23f@suse.cz>
 <20250708-export_modules-v1-1-fbf7a282d23f@suse.cz>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <20250708-export_modules-v1-1-fbf7a282d23f@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0144.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::29) To SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFF6E64BC2C:EE_|CYXPR12MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff0de01-b0f6-4bca-8836-08ddbdf4c179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWlxK1ZZWHdoRTViNFljRytTQlZjU1A3RDVwREQ2Wk1wNUxyYm5mY1BLYjZI?=
 =?utf-8?B?UXFzVGZBMXBPMWJJVlVEOU01YWxpbzNTRkllb0ptWVZHckVjVy91SG9EeTVS?=
 =?utf-8?B?cDVaTlM3S2hHWUVQbktqRjJvMHVUK3dJNUFSZUs2RWRlUlRkVzVtOTVhV3VS?=
 =?utf-8?B?dEZPdzZGU0xJZzR4d2l6a3BuOFdpMEtpMEQ1clhiekJtRC9KWGwwL3V5VTVS?=
 =?utf-8?B?WGdrQ2piaEl3TUkrajk3VS9WR29QZFlVemlWdndXVy9xM0o4SXRhY1J1ZGIx?=
 =?utf-8?B?VE9rTXVBZVJIakQva0xyUTRHdFRlNFNlSGRoRDZ5SEcxL2tKai9JK3ZiQnpY?=
 =?utf-8?B?OHZZMmIvMm10TG1zaWYzTFBoMUZDMndtRWNnUm43a3R3Z29WVVhDVFhSeDNu?=
 =?utf-8?B?YmNaaTBQMVhkZGtDcEpRL1ZMQUdSdytTTDdlWFVHVElzODZBdWNGSnAwZkxB?=
 =?utf-8?B?cldzVDhGSmRLS3JYVzVjRmszNm5STnU4UmFoVENtQTBQOUJYc3ZEQk4zbkJm?=
 =?utf-8?B?OHFYKzFhamhBMzY0RGkvK1haZGsrN0E4dTdKdVlldkpGazlEdi9DeDVxaWJV?=
 =?utf-8?B?TlIrMGttZ1R0TVFMZWdwMHFTNSswYnEvTExKNnJqR1QwK0dsSUt2dzkzVEtE?=
 =?utf-8?B?Nlo1clR3Qi9VMUpzaDRPOWpEdE9haGRVTm8vWDA1a3JxVnl2T1FOeFVBTnpU?=
 =?utf-8?B?bnkvZ1pyVVByWlRFVTg5eFZXQmJJTEc0VGxYQnNHQlFOeU1ldFZpYUtXV1Y1?=
 =?utf-8?B?Y3FlaFRpbWlaSFV4d2dCMk5CLzRXbCtsRDVWQjRpMEFrRnNEajhTbTRhYVo4?=
 =?utf-8?B?VmQwb3JIdWo5Q0dyU3RkK1pqQk1HeDdoNGdiZDZqQzd3YmJ2b2NQZHM3cEZv?=
 =?utf-8?B?QWkxcFMwRVB2YzNvZWRYZ095b3JHU2ZjdVRCL2xNeW4vSTgxbWhyU255eXVw?=
 =?utf-8?B?V2Joc2JmaUZQOXVlQitoT2dkNFVkcXZ1SXRCZU1HemFjaW5PZUJYLzlXR3hq?=
 =?utf-8?B?ZDJSbmhmanhPc2M4WXJqdGRNeGw2Q3V6dXRiNTFMeEZBb0RGcmNsVmZqSUZG?=
 =?utf-8?B?U0RSczYyQjJaTUo3Q252QmIrcGkrOVlNcWg5ZjBOM0hzUTJQdW1xN2tXbDJX?=
 =?utf-8?B?ZHIvMWRDeUdLTFpSQ1R5Y3dzeVZVaHVRRkdqTEFiTDUxUWN4Y1FhS2NZVEw5?=
 =?utf-8?B?Vm1JdExUZTJHWStBWjF0c2I3Z0xsWkVyeDRMVTdvNkJrWW1tSDZGdGxOdWR4?=
 =?utf-8?B?ejZHKzdkRUFTUWQxS3VqcW1XZVlOZk1OVFd1bDkwdkpTbUpVaktmUG1lNnBa?=
 =?utf-8?B?R3pneFhROWt3Y2Y1dmNacTVFYUtqL3BMc1lYTGQ2S0RCK3UwaGpKOHltTXdT?=
 =?utf-8?B?T1RTOCtNL2JwSGMrckVpaThqdWdFU001d3l5U0lZbnlIYW1kaWJUc0ZmTGtG?=
 =?utf-8?B?bm45bVVoam5HWWJzWWpkVlROWitTbkZ6OXI5VzRMYjdQRmpnN0RQVWVTcEky?=
 =?utf-8?B?S2o0MStTUzZUbXBUeWJRdGdKcXF3U0NUSis1MkRqampmYzJ4YXNFM0NYeUxq?=
 =?utf-8?B?K0lhdEdOdHpRNWo0MlZSMXBXY3d1NGV4aFdCbTVpdWhpcFNnT2dqYjMvM09o?=
 =?utf-8?B?ZUFnT2FVa1JWeWdVSGwwNFJ3Y2hocjN3Q0ZrcUpzcXVjU0lXa1BneWQxY0pM?=
 =?utf-8?B?VnNrNEtUKzJKQzlHZEx5V2xyRzZtdEJKKy9WU3pjZ1lqWFo5cmtLbTN5RFcz?=
 =?utf-8?B?VUdacFZ3Z3o0dUtZcVVtcStTTmNJRlRON09NUnNseVRYWmNWdHBlejNjRTZ2?=
 =?utf-8?B?MWo0SktqKzRnSVRQbjdTRVlrcXdIbjRuMUd5WmJMNGg0RktINXJnTm4yMFF3?=
 =?utf-8?B?VXBJdUl6Z0Z3eUZGL295Y1J2SGFkWkl2QUFMQ3NNYnlGY1NmYVcySW42MGxy?=
 =?utf-8?B?WTFKakt2byt3ZUJ6dldQMjExN1BUQm1hcm9JQXNNaWpsaU1RcnBETHRJbVVE?=
 =?utf-8?B?ek1RQW1vZnFBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPFF6E64BC2C.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0hzUVZsRUxKYnRoVzhNSmVITWwvQ1p4U2JlV05ESkdqVThrYlRsSFk3a0Q1?=
 =?utf-8?B?T0hJVGVMTWR5Yk84aTVXamxiMGk4Qlhmd2txVFVUblAvdEN2VGkzeng2Z2Z6?=
 =?utf-8?B?c3VqWmtuYVkzQjZZMzMza1NWWm1qNUc2T25QTmtGaEsyUnJGNktlSWNzY2tn?=
 =?utf-8?B?Nk81amdlL1UwR3ZUQzF3N1pJQTFYZ1d4eXdCbHkxcVdDV3VDblRTekNRTXhX?=
 =?utf-8?B?WDBDa2Rmc3dqa0xnZVRRd296R0dGTVQxOTlCYk9pcUNXMHJ3VDFIUXBPM0Qr?=
 =?utf-8?B?blF1TlpmY0E0TjNUZFU2NVRJS2hNYXUrYTRuZkZLYXIyVHZzODNvZ2laQS9Z?=
 =?utf-8?B?RERPRDk0YmZoYjdmeHlRS1EyaUZwdE5SUzY1WkVNblpYSHVCN2NiTEprLzBC?=
 =?utf-8?B?M3U2VytnSUJRVXl3VDB5Wi8vSmRPR1NTYnZsaUZacVhuNVhEWlJ0Q1lmOTlX?=
 =?utf-8?B?SnJaMU53b0VZQk1pNHBwckU0RUZsWFhhZWw0SGVraWJzcHB2WGp6V2FqTFRs?=
 =?utf-8?B?bHN0NG5yNHBxZzVuTHdNOHVwSlRoSVFCVWpxRSt3YVo1T1RSWTUzSzY4VTFZ?=
 =?utf-8?B?TUdjWlBHL2hKdjNDMW5vWVhWZ0dBdUU0YTZaN2JRY1BVcnZtNEVZR1I4ZVNS?=
 =?utf-8?B?QzdpQ3lXTXdjdXlBTlFGWUJsK3JpWTZGQ1lqSUpVenVqZ0lubTAyeisvNWcy?=
 =?utf-8?B?eklaRUNsN3lnODVYQW5sSmxVYjRmVFUycEk3NHdhTURvQlhLMVBwcEZtWGpZ?=
 =?utf-8?B?RFlXNVROM3h0VEYwYmp6eXZFQ3QyaEJnbFJCQWp3cU1xWkxvWGI3SHZNbnFy?=
 =?utf-8?B?czhQc3NIYklDbytZcnJuWVM1RjB5WExaVlFwYkp2OWpEbjJMQXZRb0VtMFY1?=
 =?utf-8?B?ZEROWXlWN1dzRlk1L0c1M29VNVlkY1l0MmVVOHpFQTdCK3Evb1hrR3I4dWRm?=
 =?utf-8?B?R3NIY0pVd0pkNGhHWlRORXV2YzV3LzNaMDI4M2s1SkhDRDZrcTNKNjd0STJZ?=
 =?utf-8?B?SGlOUEVHM1lkN0pKQXdtMnVyZG5Ma2JDcXRzNE1hb08rNC9HTGo4dmlHOElG?=
 =?utf-8?B?N2tDUkhZSTRHalNYVXNaTy94Y1lGUVd4R1d3Rk80YjFvVWVMS2pjaHBGNk84?=
 =?utf-8?B?YXVtUnI5WWVBZDBJTEdBbmNPZDJ1c0RzNXkzQWdRK0RHQmpZYTV0VThrMkxW?=
 =?utf-8?B?UU4ySjVTUzFhbUExVlVrRjh1MkxDQ0Z6UDIzVlhFbFE1UmhUM1VOZDMrckhD?=
 =?utf-8?B?Sy95TkVKU2tlbFZrcUlZNEtwellMUjZSTVJ2Z2dHaEhpRUNJSnJDWXVpY3I0?=
 =?utf-8?B?MWVuMHBaSXEweXY1ek01RlNUZ3cyNnJUeExmR3VDR0RLdmxTd1hlN25MZXZN?=
 =?utf-8?B?alIrbFVsOEZyc3dMTEh3TkdZSGdUUVZQclNNMXVzV1JlNzN0RnExUUFrYTlq?=
 =?utf-8?B?VWoxMGxQRkNuT2dTT0o3TlF6Mndub1pJckZGblJ2VU9vSnlFa3dqa0JnOXNZ?=
 =?utf-8?B?RjRBalBGc0FnRklYdDR4QkxKYVZ4bElia2pmbHM4bkFzc0Q3dVM0VzRRV3Zl?=
 =?utf-8?B?ODJ2V0g3OEJuVGpnSVZmYlJZVnYwWi9mbDRqQUlGeEJJK05MNHU3Nmw5OEFu?=
 =?utf-8?B?K3lGWmlaTWlVb3FlblJjN1JTQVgvOTNyMGQ5MUhOVjRjKzZ2UUFWMStTcWJP?=
 =?utf-8?B?SUhRMHU1OXNJQkc0UjRnTVk5TGVubkxqNFJNcDVQR2hYeUVYMW90OG1iemIw?=
 =?utf-8?B?dHl3bU5xY3pjN0tIbDA5ejdvbVlldHl6cHoyVDVrSnNxTjdLL01tYk16eWNY?=
 =?utf-8?B?cVdWRjlLeTdDNlBJeWc2VUx1MG5BU20vVzNsTFFuRTlGSVJ1bWFnYVdRcGth?=
 =?utf-8?B?WTZPN2Y5dzlieXRMa2g5a0pITjBpTmhLWUxaeVNFdmUwSjlncVlpNEF6U05j?=
 =?utf-8?B?UGtOc0tBTkJXUlJTQ2NlOWNHQ2pCbEd6cWRERm5BcFcyOHh6Ty9vUDFUdUg5?=
 =?utf-8?B?UlZBcVZNdmxJWXB5SjlJK1BYVWt0K0I5RFJlZ3crMFhPeWtvQXFxMzExWE44?=
 =?utf-8?B?L0c3KzZUTS9TaEtWakgzMXB0RjFwOFZyZ3dFa1V6V3FoV1RodHg1cVIvMU5Z?=
 =?utf-8?Q?Xy6ibP2kNv6L3zOFHAQO5FVdM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff0de01-b0f6-4bca-8836-08ddbdf4c179
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 07:55:07.5197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZXxozacwi8L4cbcj77x90OftT7jZgrij2dDNCKKJuq3F1tKpKsGPrsJvzp69b9kMPNMTxNWvTNr2moWALElJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9279



On 7/8/2025 12:58 PM, Vlastimil Babka wrote:
> The module namespace support has been introduced to allow restricting
> exports to specific modules only, and intended for in-tree modules such
> as kvm. Make this intention explicit by disallowing out of tree modules
> both for the module loader and modpost.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  Documentation/core-api/symbol-namespaces.rst | 5 +++--
>  kernel/module/main.c                         | 3 ++-
>  scripts/mod/modpost.c                        | 6 +++++-
>  3 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/core-api/symbol-namespaces.rst b/Documentation/core-api/symbol-namespaces.rst
> index 32fc73dc5529e8844c2ce2580987155bcd13cd09..dc228ac738a5cdc49cc736c29170ca96df6a28dc 100644
> --- a/Documentation/core-api/symbol-namespaces.rst
> +++ b/Documentation/core-api/symbol-namespaces.rst
> @@ -83,13 +83,14 @@ Symbols exported using this macro are put into a module namespace. This
>  namespace cannot be imported.
>  
>  The macro takes a comma separated list of module names, allowing only those
> -modules to access this symbol. Simple tail-globs are supported.
> +modules to access this symbol. The access is restricted to in-tree modules.
> +Simple tail-globs are supported.
>  
>  For example::
>  
>    EXPORT_SYMBOL_GPL_FOR_MODULES(preempt_notifier_inc, "kvm,kvm-*")
>  
> -will limit usage of this symbol to modules whoes name matches the given
> +will limit usage of this symbol to in-tree modules whoes name matches the given
>  patterns.
>  
>  How to use Symbols exported in Namespaces
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 413ac6ea37021bc8ae260f624ca2745ed85333fc..ec7d8daa0347e3b65713396d6b6d14c2cb0270d3 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1157,7 +1157,8 @@ static int verify_namespace_is_imported(const struct load_info *info,
>  	namespace = kernel_symbol_namespace(sym);
>  	if (namespace && namespace[0]) {
>  
> -		if (verify_module_namespace(namespace, mod->name))
> +		if (get_modinfo(info, "intree") &&
> +		    verify_module_namespace(namespace, mod->name))
>  			return 0;
>  
>  		for_each_modinfo_entry(imported_namespace, info, "import_ns") {
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 5ca7c268294ebb65acb0ba52a671eddca9279c61..d78be9834ed75f4b6ddb9af02a300a9bcc9234cc 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1695,7 +1695,8 @@ void buf_write(struct buffer *buf, const char *s, int len)
>   * @modname: module name
>   *
>   * If @namespace is prefixed with "module:" to indicate it is a module namespace
> - * then test if @modname matches any of the comma separated patterns.
> + * then test if @modname matches any of the comma separated patterns. Access to
> + * module namespaces is restricted to in-tree modules only.
>   *
>   * The patterns only support tail-glob.
>   */
> @@ -1706,6 +1707,9 @@ static bool verify_module_namespace(const char *namespace, const char *modname)
>  	const char *sep;
>  	bool glob;
>  
> +	if (external_module)
> +		return false;
> +
>  	if (!strstarts(namespace, prefix))
>  		return false;
>  
> 

Reviewed-by: Shivank Garg <shivankg@amd.com>

Thanks,
Shivank

