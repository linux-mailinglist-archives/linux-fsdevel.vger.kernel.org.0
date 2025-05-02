Return-Path: <linux-fsdevel+bounces-47899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C25AA6C08
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 09:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B541F7ACBAC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 07:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193F2267709;
	Fri,  2 May 2025 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zvBaGafd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F0120C02D;
	Fri,  2 May 2025 07:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746172203; cv=fail; b=XY4gjIB8LPgoFwOnq63hFW/Zv8l/JYGoMQ6/4GicTd0Nil4W81jy0sZIT7sDdqDsYOmTmWN2pkbPPMi8H5Y2DXKDZ1ThK3iFMFi08Zg4Bn4dsTbpFqIZG1AEC/hgWFs7hk0Mzt2cLSa/2XGkhuux19ahBLyUtVpVzHo3k74f4/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746172203; c=relaxed/simple;
	bh=GOyB4i9BLqrjMaHx8nxlFQqMVEvoI+0gIRprYeDOYds=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IZQ639LkCVm9zqCmQTUbMc1wu8rVI9172G00LzmLBs3lJYjzjULtCa5/A9vkfW0KcF2SsZVLstZxEFbIVBWc3nP6S/UWG07jFR30S+l3YrsoNJECyP20uKFo4usdz9SHtex1i1nhFa/blyYN5pXBK9BRYhqZiyiOmzoj5e5BBUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zvBaGafd; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/PpXkSAOhyrAHMkgMWZMnZo0gDuQ4RvSTJnX2XUrqCirSNOxmSstQynkwxBbSYgLQ6NKPdP9e3wmUEqc97KA6cjyA70++JiTsRZffpYh8IK2JTuk2Wa9o9mU2gdsqi75njiIOomITGJ0xzypEcenABvVlxkDROvGooAgZfvaZswy1yYm11BK/2wz6BmtwtRBwlix9VHANLtZor9YsRy5IUiuARgxGSezH3x8m80b5s078DjOF7/knh0KzqzkOwMvP56gwa5xntmW9ppUbAXLIWEgdUAU+ATio3WokMLoEgbmJyZJP2h0e3FXG+l52kXU9WAnQGSWscY0j1ApY9pvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iKyMnR0ns1Sz1FtOgMHPfnf8jUJVUkXamPdg8NuT2w=;
 b=AtGfuNqdTcLmcJabVtYaguqjLUX3A8sdcE2uioFGdJwV2lfYyLpauTGPPT8FFJwWT5qOqWGqVAkDdOU7KdiCNZY+5E0hB1HOtrvn0kpWVMqQp4b/kwUDD9ECRLKCan8gEGksDSAjYFBOB4QKitX1nT+3zTudyEjOiZdsrMKOIwSRZVeDYvov9twTGKkawE1SBMmmz4ve7xcJbak9yUfLug3ysR7AzrDMAzuRikHV98Ap1+hWsp2N7hSaEGiMymyO/l6FwXIkrAfGTaBaDDZhfrgQSInKtqZ3DkvNcfe++8EVrzOkmUqesuSzvw/wy4nlJF/2jG4HGxbMCG1w94XwIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iKyMnR0ns1Sz1FtOgMHPfnf8jUJVUkXamPdg8NuT2w=;
 b=zvBaGafdxgc0pou2qArovgeXdT2M73/sHEpYZe6eGWDF6FOEtxokQc22NpcfLtGwBWp57hRBxKZ7uehqJPM/LyCdhCL1+YmLZnn60m/lRHfmzmqQFicXuDqyJapmWnUQ29XML2Z3ICcy+T0b9N8AnooIptR6BjlQ7qB14kaHYUw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY1PR12MB9674.namprd12.prod.outlook.com (2603:10b6:930:106::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 2 May
 2025 07:49:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Fri, 2 May 2025
 07:49:58 +0000
Message-ID: <da694af6-1a9a-4cee-86b7-1da97e1e91de@amd.com>
Date: Fri, 2 May 2025 09:49:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/ttm: Silence randstruct warning about casting
 struct file
To: Al Viro <viro@zeniv.linux.org.uk>, Matthew Brost <matthew.brost@intel.com>
Cc: Kees Cook <kees@kernel.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
References: <20250502002437.it.851-kees@kernel.org>
 <aBQqOCQZrHBBbPbL@lstrano-desk.jf.intel.com> <20250502023447.GV2023217@ZenIV>
 <aBRJcXfBuK29mVP+@lstrano-desk.jf.intel.com> <20250502043149.GW2023217@ZenIV>
 <aBRPeLVgG5J5P8SL@lstrano-desk.jf.intel.com> <20250502053303.GX2023217@ZenIV>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250502053303.GX2023217@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0283.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY1PR12MB9674:EE_
X-MS-Office365-Filtering-Correlation-Id: bb6a652c-52a5-4fde-d1f3-08dd894def4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXoxNlNNU00zRVZMaFRRVlJyNWZENzFhWGdQa2FpZUlXY2l4dkxqZDdUaHdX?=
 =?utf-8?B?eW5sZHRYVkM2bnV0OHhOQnlrTWFJMFpLQ0pEL0Rtc21qZ1k1dVRmUVp1Snk4?=
 =?utf-8?B?N3krVy9tNnR4OVJSZm1nNDlxR1BmVmZlemFpbWNHMlBlSnNQWnJueTZYMFBX?=
 =?utf-8?B?eldLUHdmcTUrbXdCaTBXOVVhMVNSenE3QjhpNDAydXNwTEkzakNscmp6TGtZ?=
 =?utf-8?B?b3FTVUIzTmlSbEErbGVWMHU5dUxadUxxZ2loSDhJdDVtZWdJc1RMZmlQTi8r?=
 =?utf-8?B?SzJrcStFU0FvbzNvWGxIUk4ydHYyUDlMeElCTHYvdklwTFl5TVRRZUw4OWZR?=
 =?utf-8?B?ZFZHcTdHZUZQbEE5b0QyTWJRalQrYXJMNFh5RG1YVnZuVVBLSHNRT1RnZGk3?=
 =?utf-8?B?eE96YytJeWdBcFZMMDNwb0ZONXc0SXZNNFUwMWpkYjdEajFlM1dlSFpuOHZX?=
 =?utf-8?B?TFdWQi82SjJrRk5jdjhQbEExemZLK01zbm1sb0tFYm1wZVhpTmFqN1ZhSFVP?=
 =?utf-8?B?WlV1cVVjTm12dUlEK2VleXZ3MVZ6em9tR2FxdE11ODRvcGpLT1J2eWc4QVdV?=
 =?utf-8?B?QUhUUks1UkhGeVQrQ0ZENHJMWmhJd0ZIS0w4Nm9ZY09FZ0NMTGxOUGNVTkcx?=
 =?utf-8?B?eHdyZkhyL2dnK2pIeUxzcnpWc28wZWtLZ1FEVWVMVXVpNVh4MjhKOHpIdXV4?=
 =?utf-8?B?aEpiUk1ZT05ETG5Scy9obDhleVE4RDByN3oyUWVqemFpTzlFbU5BUmloT3dI?=
 =?utf-8?B?VnVhbVJ0ejIzVWtMbUdSVUl6S1NhQW1od01pY25ndVVnL2NtVXZwMTBnTVh4?=
 =?utf-8?B?WFg0VUIvYk1uY2JRUytBSy90R1ZIKy8zdGZQYmIrT1R1aHpsVEpVd1c0Y25G?=
 =?utf-8?B?Q1g4MVVIVXVlb1AzUkJHTFNJWlVXVkRIZTlXSmpFWUlkZmwwYU9qUndkTlpr?=
 =?utf-8?B?YzF2NUFyWnRHbkpaU0VaY1VBTmhUdDc4M1BNay92TjNOU3g5eDV2ZmlDVmtS?=
 =?utf-8?B?b1BTZXVOREpRNWxYODhiWjBVT0t1emR4STBPLzhZUmV2bGNGVkNtM2E0WVBW?=
 =?utf-8?B?MDRycGFTT2NpelVyK0kxRXJiWHJQVG1xSDZDb20vT1g3RjQ3VXoydzlCaVhp?=
 =?utf-8?B?MWxSbWR1VkdMUW1GUFZXVkJCaXQ5NFRxV0h4Ujh5OTZESlFuYlRQOS96Wmo0?=
 =?utf-8?B?cGpNUEhnTXJxcnROdGxnZWxNSWZNNHpRYUFEMU1VcEZNRlo2Uy9NMVBFZTRh?=
 =?utf-8?B?RE5sRGkzNVM2dGMzZFlXa3BIeXVpUUlwajRQOVRlNDdOZHVqd3VicUpMVGp5?=
 =?utf-8?B?SzFxVE9jYWZ6RjRaYU1LSzZlSWtQVkRuWlpBY2NLemRJcTdaWkNobTRhdFpO?=
 =?utf-8?B?Z2VaK3piVDRSVTVIcDkraXQydGwweWVmc29WbkNsdnhIc1YreTN1VmdWeUF5?=
 =?utf-8?B?d1JBRFpDMGt3LzVYTzZlMHYxRXdYd1h4cEpSZ3ZiamRvZHcrUm9vZ1Nma1JY?=
 =?utf-8?B?Unh2cFRubDlYbjRMWGFramhBb2o1N1JzUGIrcTBUWVBjTnVMZ3NZMUx5MTJW?=
 =?utf-8?B?U3ZSOHMzUWJKR1dpRzcxRWhRQmxOTG1JNFdXMjNmbnlCUmFVQjVnVDMvVHF1?=
 =?utf-8?B?QVlqQ1dPSjFwUDJFQTdkNW9TV2xxSy96anNzb3NQWDc0V05DL3g4WW1QczdN?=
 =?utf-8?B?RE9JUzYvTzJBR3BlZkY5TXdwYzN2T0lPMHROb1RHNmhwcDNMWTN1N2VoLzJk?=
 =?utf-8?B?cGRFTm1oTHBjcG11SWpNTUczS0JjU2dRa0RRTUNLNjJYckdEWEUyZXBwTHh5?=
 =?utf-8?B?YjM5bXJLNzZSYkJUYXd4ZlFQVUJXdVg0Q3FTSktJUlJjcEtQK0tNRVFrc044?=
 =?utf-8?B?bW9vVjU3TXZoNkNPUDZPeXEvaTZlVHNtWWpCVHZCVHJwdlcxVlFIZzE5UXF1?=
 =?utf-8?Q?vYU4/y6MVAg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnlIK1NzalhsbFJFSEluS0RHeHhodzhmTU95R0lhQWNPdmRRckNyT1dlcERG?=
 =?utf-8?B?V3lkSWZGZVBjU0ZaUTh6VmdwMjA5c1JlRFZmeHQ4OElDOVN2b2YvekNxd1Iv?=
 =?utf-8?B?UFZXN0NmYzNVOVpoclJqM091aUp0akUzUUhoczhCMnRBM0FrdUJjdVh5NVlk?=
 =?utf-8?B?NUtxZDBBclVOcUlJUG9TYXM2dVZLVlViNUQ4MXhId3hEWCtnUlh2b0MzN0Yv?=
 =?utf-8?B?djJoL2ZmOGRqVE5SQ0Z3b1JxdkJaaktBUVFJT3hWSi9Td2RTSDZ6dkROdmlE?=
 =?utf-8?B?VzFMSytwREN3RWhML1NINnNsdlNKbFVZcForWkRjQUZUeTdVeGV1QVVpbnB4?=
 =?utf-8?B?Zlk4RC9YZThjaVUxb0NzTWN2TUJYNTJDTFhTYjBON3lBd0laL1pmRC8vaXRW?=
 =?utf-8?B?eUo0UVBxYWRKd0dFVjBvU1Rkc3VnTzduQitUNDF1Q2JQeUhqa213WGhTWGhD?=
 =?utf-8?B?b1JTZitDWUVIdU8reHIrSzlDS01HMWsrNlF5ZmJ1RldJL29zQWUwY2hEU1dN?=
 =?utf-8?B?Y2NNbVJGSVpnR1pxS1JSeVdVcmZ6cTBjSGZ1aDJINm85VHJ6Q0dqOW14MGNY?=
 =?utf-8?B?Z3o0WWNCVkRoVDY2S3FhaThzUjZQSXRiNnRyQ1U5d0RDTTByWGozRDN5WmNR?=
 =?utf-8?B?MUtVczZTSHN2R3lpNElFRXJjTk1vaFg5SWxIY0ZjWERmaWkxVFpMUmpwMEV5?=
 =?utf-8?B?cllzQldSRVhYbXo3WTMraWpiQWRLRlNhUUpmSitDaVNuelNVSVViR2lXWXRs?=
 =?utf-8?B?ZTNJSHNOaEpRcS9PclRIcTUrQmtEUjZzL3VGNmVJNWVWMEhmSEt2VnNPZ09J?=
 =?utf-8?B?L0hram5XSEI5SVpyaDRhcGwvaUV4eGNNNm1QZEZvbnlQT1l0akVKOGNxM0RR?=
 =?utf-8?B?YVdXeVpKVm9qWStxdXhNWXVDc1ltTkFIQVBHbDFYck9XWUJNQURDeFk3QTVk?=
 =?utf-8?B?WWlZdEwwYkxGMnJCT0dpUFowMEZCQTZIRkU1VE5Sd3JPWmppQkY1OFlHQmQ5?=
 =?utf-8?B?bDJCTmJxdlgvT2ErMzBBeXlQaFJsb1hnWVdkSnhsajZGWDhDa3JldEtNRmov?=
 =?utf-8?B?ZVRMQlNWMDlBM3BkRUJLRVdHNnBrNEx5RTBSbExROEZpdk02SE5BL3RRWnNU?=
 =?utf-8?B?RlNoMGRXM3gzamRCK0cwdTl6bWtTU1liQXVWQWRXd0lJZCs3M0hhUDdqWUxJ?=
 =?utf-8?B?UHNZU1p1U08rZXBvL1pkTmFjOFBlLy9wY0xxUHFzb1d4amlRZHUrQUxTYXRz?=
 =?utf-8?B?b3dOSTVIQmRRdWdHNFpkbTlveHMrSXhDYm1iTUN4cXR2UnVTV1dZK09WRktK?=
 =?utf-8?B?cGQzSUhRTE9SYjNMN1NGOStITmd1ODNWd2lSMEdnelord0hLWW0zTjFWNFJP?=
 =?utf-8?B?akJLTXBua0FTcjBqUjdlbDlRZG1PTjFROVhpRzF1OTJ6Z0VxNTRka3pzaUl1?=
 =?utf-8?B?ZlErdGlmdjZBZm8zaDVpWS9mcHZBajBHMy95MHdFVm0vZHgzeEFmdHNDcmIx?=
 =?utf-8?B?aVRzRDhXQno4WW1HSmg2MnFwbGJ5QUo1MnEzcWVYeUJIc1VUUlcwMVVRNG5u?=
 =?utf-8?B?KzlINHU5Vmc3YVR5SzkxRFJGMEpYdDl3dHhZZTUySXJDR2hKbzV3dXhoR0F1?=
 =?utf-8?B?b2h6dzJ3MHhZd2dFL3VGWjlSdGpJZk9DbmdkdmRnY3hXamtrcDU4UHFzQm43?=
 =?utf-8?B?N0E4eWpHMTFjL3U1SG11V0ZIdnFqSW41d2cxRWhMUjJBdzViaUhtdUowSUVz?=
 =?utf-8?B?anNLU3pyb21qTk1zUmdQMEg4clQxR1pBUjU1UjU4VWEvcmYzTU5SZ2M1UDRK?=
 =?utf-8?B?YVRBV0xaMFFYRUs5ZlUrNGUvYXJGR1A0cGl2M01sdTRDYXBiUEtBekdYbjlC?=
 =?utf-8?B?VXNMdlhEenJyTFVqenJpN2d5bWY2ak9PNGxSejR4U0hmVldINmEzSUQvNlgz?=
 =?utf-8?B?aEhNS3VnaHZGMzgwdXNBekNLM2VVYnpEOXVSNkFvYU1nMnVDaW9xVEFRbndo?=
 =?utf-8?B?eDNnZkxGb2ViTXh1a0JhUXpNY2hJNmMrcTFUYmVJckpIUHRlZWdGTkVEV1lo?=
 =?utf-8?B?WU4rQlovMXp4czZHcEJjTHZKaU1CcUtlVkxidXE4cGpPRWs0cVBqa2lXZTZO?=
 =?utf-8?Q?lpJU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6a652c-52a5-4fde-d1f3-08dd894def4d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 07:49:58.0245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+9tVKNwq4qZgDDCTFqGAmaZ9vvTc5uKceRRZQ3nG2PpUWkrfwh9B1fatkW/pcAO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9674

On 5/2/25 07:33, Al Viro wrote:
> On Thu, May 01, 2025 at 09:52:08PM -0700, Matthew Brost wrote:
>> On Fri, May 02, 2025 at 05:31:49AM +0100, Al Viro wrote:
>>> On Thu, May 01, 2025 at 09:26:25PM -0700, Matthew Brost wrote:
> 
>>> And what is the lifecycle of that thing?  E.g. what is guaranteed about
>>> ttm_backup_fini() vs. functions accessing the damn thing?  Are they
>>> serialized on something/tied to lifecycle stages of struct ttm_tt?
>>
>> I believe the life cycle is when ttm_tt is destroyed or api allows
>> overriding the old backup with a new one (currently unused).
> 
> Umm...  So can ttm_tt_setup_backup() be called in the middle of
> e.g. ttm_backup_drop() or ttm_backup_{copy,backup}_page(), etc.?
> 
> I mean, if they had been called by ttm_backup.c internals, it would
> be an internal business of specific implementation, with all
> serialization, etc. warranties being its responsibility;
> but if it's called by other code that is supposed to be isolated
> from details of what ->backup is pointing to...
> 
> Sorry for asking dumb questions, but I hadn't seen the original
> threads.  Basically, what prevents the underlying shmem file getting
> torn apart while another operation is using it?  It might very well
> be simple, but I had enough "it's because of... oh, bugger" moments
> on the receiving end of such questions...

It's the outside logic which makes sure that the backup structure stays around as long as the BO or the device which needs it is around.

But putting that aside I was not very keen about the whole idea of never defining the ttm_backup structure and just casting it to a file in the backend either.

So I would just completely nuke that unnecessary abstraction and just use a pointer to a file all around.

Regards,
Christian.

