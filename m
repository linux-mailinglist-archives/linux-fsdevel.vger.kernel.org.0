Return-Path: <linux-fsdevel+bounces-23573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE4A92EAB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 16:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E5C282891
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 14:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AC4166317;
	Thu, 11 Jul 2024 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sKjanpUR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0753115AD99;
	Thu, 11 Jul 2024 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720707974; cv=fail; b=Dd9XiQzVVR1s/3MwTbW2N6wDZ1GKnz9nMFeSznoY634MkOQJLoOu1QxwE3kEXmWMCRg1BE2F3fN4Fy6IanGddNLQYzqBR70MHTLeU4NXi/jE3RlDeXPnnNnCc8tKJn+a2waEVsyBYgPl/uhOqdImyKWmur7EYKzvkmOe4/k2d/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720707974; c=relaxed/simple;
	bh=dy6MeuoBnZlgWZz8fKiZq7J+Lr3vxbxFj46e4I3SQRI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IlLYcnuxiy5Fp1iRQQPhTchIvW+hohJilm/SlVPiDTFYpvXWVLYuIrXDEV+ZjFSQybRzbZuwRMOQbgoZmxZkRIEIG4achp5OqEU371cedA/bIF6dyN/p3kxFm14U58aJEIwHKcO6NPSQE3wJPPE/kecPtbMbvvvlWBdCWLGcfjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sKjanpUR; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYs/EY74wVmW8rgXwlaV8gN1dDs4USHriMKORHVebu346rulPKT7cBcs9K7VRUHrN0AcYDpCkdpcLZYO4MlGraW1+WfX4PaouwUDK9yzcdHA4rk6ofyj3MKfuZxH/wRI9FaNLffU/4R8UlCBsLxF4Zya965zfeVfCcKsY2NsC+kpS7AxieGTpKix4uow9ErQMgjpmNbElzO/N8BENgXchgM/Lob59hds+46pk5hofVqTAVJ3b3WaIeBXtBUDn0xfyh0WaSXdRDbuv4nyWGrj+w108aGkeO9rSGH2GhD2fRlYTqtfDdTsrLboFYs0ZVNlLkcceLq7/CGew8+scFdC9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrVg6JN1rAI05l1tlksbH/6OV5Rn44XwFKcJMyLxl64=;
 b=U+hVTt5xhHRwgWXqMtVtRGqoWxLPQSVFDOpBhi9lgxD6A7EwbFXm6TU+33SJJxoEL1X8YXzOzqn+Tvku2chp6bQ/E+gVCF70cAkbpX81pdBMUKgfcG+h9w8vAHYedB5przs4x2NVeDX1ewtWr4Flto6Lrq2uhkFL4AkgWEFDXHzekLWWwvtBTdWAZKXi6YLE3uh5ye2xirSLw8NjUk/5srCL2j0qUebPyMWzpEcSWQb/nnoLFAMFqrUHH+i+JDKrTjyDOj0+amnxKt9jSJz7+FlUXyAMxsw7ILUz//FVC/rXvXQdMQrxx49fq1a+gzhDfBXIlpUwZdA4jLPeUnl1ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrVg6JN1rAI05l1tlksbH/6OV5Rn44XwFKcJMyLxl64=;
 b=sKjanpURwhteP5ZH4uY86CUI4repa1P8M/dR5bLjxKy36VHuFxJJPUnEPsTagwQGogwNJw2dEDeIaRi93KEWwB4eSi3v8BqjUpo8B7FDQmyU1kge3RSTn8pyDFusy3zRHw5ncb3Z+X9qcsXxL0soa5JKB2oKRLfRjcJjA65J1hc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 14:26:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 14:26:09 +0000
Message-ID: <63237086-223f-44fb-90a0-076a5f56dfdc@amd.com>
Date: Thu, 11 Jul 2024 16:25:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Support direct I/O read and write for memory
 allocated by dmabuf
To: "T.J. Mercier" <tjmercier@google.com>, Lei Liu <liulei.rjpt@vivo.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrei Vagin <avagin@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, Daniel Vetter <daniel@ffwll.ch>,
 "Vetter, Daniel" <daniel.vetter@intel.com>, opensource.kernel@vivo.com,
 quic_sukadev@quicinc.com, quic_cgoldswo@quicinc.com,
 Akilesh Kailash <akailash@google.com>
References: <20240710135757.25786-1-liulei.rjpt@vivo.com>
 <5e5ee5d3-8a57-478a-9ce7-b40cab60b67d@amd.com>
 <d70cf558-cf34-4909-a33e-58e3a10bbc0c@vivo.com>
 <0393cf47-3fa2-4e32-8b3d-d5d5bdece298@amd.com>
 <e8bfe5ed-130a-4f32-a95a-01477cdd98ca@vivo.com>
 <CABdmKX26f+6m9Gh34Lb+rb2yQB--wSKP3GXRRri6Nxp3Hwxavg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CABdmKX26f+6m9Gh34Lb+rb2yQB--wSKP3GXRRri6Nxp3Hwxavg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0324.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: 6afa3e9f-9cab-4dce-1c21-08dca1b56833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qm1zVlErbitRa2NxZ05XbTF1T3Y3SFZaM0lZMHgvRVAvNDhYT0FDUm5yNWtH?=
 =?utf-8?B?UmJ4TjZoYkw2YUo5cEdGZzM4Z00xTnpBSFJxMVhMSklDT3EwM1BxM1BLTThR?=
 =?utf-8?B?S0l6T0JBV1NPTVBPRzQvWEJWTGRLYXRlM3FIRkRqRmJsdU9tdkUwZ1hTUm13?=
 =?utf-8?B?VUdkOEJ0eE05cStCRWgwWjg2Q2FHZlF4OSt2THhBR0tIeEVXelp5bllma3Nr?=
 =?utf-8?B?bUpnUXZVRFJoSEdBRjkzRWdpR0Z0QW41REx1SVVtTXorNDBXaE1hUERhQmhD?=
 =?utf-8?B?djBXMnNtUXF3WGFySGVhYU4zRi9hdEEwL0tSZlB3U2l4TE9xeTlCMUcwT2Zu?=
 =?utf-8?B?dStOK0s3US9zSUVHK3RGamQ0a3plc0owKzVFMjNKMmlLYUZSZXlaMjdlVE1p?=
 =?utf-8?B?MUlVM002NDdkVFFkdnBKS1AzclM5YjZqcktnS0RDRy9CY29CRDI0WlJXQWt4?=
 =?utf-8?B?bkR4OEdJQ0NTb3JXK2ZwTVhsUkhkcXlCQS8yMlNiZUtOMHRsOFJUUFF4aXZa?=
 =?utf-8?B?czhPelUxdU8xdnpPVEVFaitVOE01TTlRVEJXNWYvK2xUalkvQmtRcHBEYlgx?=
 =?utf-8?B?bWc2VFJ2OE12SDNWM0FrNHM1Vm1QRldVT3l4czQyaDFWL2JRNWxzTkFmOFJP?=
 =?utf-8?B?SHZpMkx0Z2lIZWJYOHJaaHBPMmNIRWZCNGdzcnEvU3p1N01zdG9EcjlsOWNG?=
 =?utf-8?B?Z2IxTUxDZldzeEZBT0JXa0ZBSWs3MkJvV2pvZTU0WmZrUlV6dUxSOHNOckFx?=
 =?utf-8?B?dERvb2NPdmFPT29jNTZtWTdmNmZ0Q09sVjhNVGJ0a2N4VFBLM21HRkRwdnhu?=
 =?utf-8?B?L0FrMGFGWnZWWFBBNFBFMnl2TkJZbmNHLy9SVVRrWkFZcS9pOFRQNjhQZ3Zq?=
 =?utf-8?B?d0QzME4wNjg3TkRCZUkva3k2djVkZE82eDZyZk1LYUozTDNPM1NLcU5sVloz?=
 =?utf-8?B?emMyMXJpSVdkL0JJS3FvaDNERjhoNXVXTGVldE5xM1N5MWpOTGt5RUd3YWlm?=
 =?utf-8?B?OVNYS0NLMVNLaFl2OEFRNUJrWGJNZkhndHVIUTBrOVpNMGxnTWhxek9ubVFV?=
 =?utf-8?B?NWpIYWw4YzhqU3lpSEMvWW5zVlk5K05uUzVra01aUFdPajZIVmlCaEh0dzBT?=
 =?utf-8?B?eVZEMkhxYlBWZEk1RUpIMlEzczc4djI2Z1pzcVZ1cVFWWEc3LzlQNGp1SHdF?=
 =?utf-8?B?ak9ubW1mVnF5TmR6cDNVTHJ6N0p6Z2p3MTVYb3FUYXZOMHZsYWpTM1I0OHJv?=
 =?utf-8?B?SHRuUzZSbWZDRjVMRmFFYk1LM08yeTRRRkFTTmJ4ZDNBRHRiYUYzOXpXYld4?=
 =?utf-8?B?dk9HMzlTYW1iS2tORjRqTkdscWN1cTBDNjRnVXc4WGc0bWgzbStPWTY3SkM3?=
 =?utf-8?B?ZUlKZXMvNXFyZ3hhQU9BRURqUnQrRnZIMVZ3YzlIWWxlZXlGcUM1dEpBb255?=
 =?utf-8?B?VHg3cXlOZjMreTQwMXgxNFE3azM4cUpSdlkrWmRvSDNHbG5NYSs1UG9PeDcw?=
 =?utf-8?B?dXozYWdnWEhNbkVvdWNRazM3eTBzdVNnc0Q0L24zaVRLdXo1YVhzQW5EeG1V?=
 =?utf-8?B?OVFkc01sYTBMRlZIQjRsek9xQjNjM1dMaENodFkyZFVKLzM3S3V2YnlGRGda?=
 =?utf-8?B?N2d3VGZyTFF2Y1BqeFlkRUdEdjRUMHYzQmVYN08xTzByT0F3bXB1ZE0vUit1?=
 =?utf-8?B?QmRURkxCSTc1U3BFUWdVT3U5RmZoSHlPNjhhaXVSZUloTHNPOEVWQzkvOUVx?=
 =?utf-8?B?WG5SWUhCMmpMV3JnMUZtcGhubEJKMWY4cTBvTDIwdWd5NnVIQW01UmtFbDV4?=
 =?utf-8?B?UTZEenVNSUc5Q1BWcXFXZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmJwNFdnT0Mvam5RTE9NMkxWZkpBa2hkbVk5bjZOejNDa2NDazZHWUlUN1RM?=
 =?utf-8?B?UXRxVlJ1Zll6VlhFVzNXTTNsL2NFQkdrcmJsZkZjbS95b2EyUERKQndpNW1S?=
 =?utf-8?B?YUttWFFXSGlrT0tFVE5rSkI3d1FWZmwzQlE0eWQ5VWp6V0hMZVVMRWF6L1Bu?=
 =?utf-8?B?cW8wT3k1UUIxS0Izc1VoWmRmcmtiVXV1Q3RuVFEzOVl4SHJFbHhLd2RtbUNX?=
 =?utf-8?B?d2x0QTZIODlFbDVqYys2N2oyZysvQnUzditIM0lDS2NPUWVPVzhXUG12bXlo?=
 =?utf-8?B?TGtKS0lwOThKc2lNSjJPOTVXMndnWG1PRlVSTVRwbVc3YXRFMDZDNkw4cmpv?=
 =?utf-8?B?Zk91UTZsakZGcmhEbVVVWWNabmF6TktSSGxremlnbEoxM2N6UHhObVl4Rk81?=
 =?utf-8?B?Ky9XZFBseEVaOHVVelVOQjlSUkszR1lFN1dwS2U1RVZ6MjlLSDZ5T1g4TUg3?=
 =?utf-8?B?ZDJ3UnU1cFRoWXZkZmVldnF6dnFZcytBYlJsQnNyTEF4bXR3UHJFU2lOUlBI?=
 =?utf-8?B?OFBtK2ZBMVcxUzJMTVlFRDBvL0gydTk2SFVjWXBpQXgzdkx4dTQzNzJrZDE1?=
 =?utf-8?B?S1NhNndTRkxLamU2SEpvSytVRHFGQVZTb1ZPSXEwNllnZWZGMUloNHp5emcz?=
 =?utf-8?B?eHdRWlJNU1Q3a3FPTEt3K1BQS2tPbis5WlpLNk9scWh1d3dyQWQzUEZiSUlC?=
 =?utf-8?B?cStGekVsNXVEcThCNitTQVpyRzBNZ1dRd1JKeHdSOFZBRUF5Qzg2UzdHT0Q5?=
 =?utf-8?B?RTVIM1I3cFhqU0lUNFJQRitmeEFnU0ZXa2hncVJDQkpVdm5nYkpoYXl2RlY4?=
 =?utf-8?B?eXU0Sm43dC81ZFVSUmpaZ1hJN3dWZjA1WXl2eVN5WkhnNjRPOEsySnRaVER6?=
 =?utf-8?B?REdVRlZWaGlVWXNaQ0Ywa1VYaXAzTlByVmxXamcyM01oVEgrcms1cmRlYTBy?=
 =?utf-8?B?cGx3bWpuZVBHYUpHL2dEMjdqZ1k1T0FiVEhZZVp5U3RkckVpSDJCeEkxbnBl?=
 =?utf-8?B?NmowRVRQbEZETkxIbHFVdFVhRGZrcjJqNmRTOGRSN2ZmczE5SHJXZmkyLzZo?=
 =?utf-8?B?eTMvSWhxU2NNYitOeUpXeDFpOXhqamttKzBYbElaNTc5Y0w5QUxYL3kxanQ2?=
 =?utf-8?B?aThtdW4veGVHa3RqZWI3MG9DYmxFU0JhM2JOb2hwblBQSHNiZlRIZVBYbE1Y?=
 =?utf-8?B?Y2tmMU82MmsxT2IyTGgwN2JoMmQvNXJNVWhLWEVpMlFsb2hzdU1NK2ZtMlZH?=
 =?utf-8?B?NDZIRE9NdmN3bVU5bk5OWFpnVmVramlkU1VWN1Mvd3d4RVFoMXVzdVUxS1pU?=
 =?utf-8?B?MFpwRW42ZTZWMW56T05LNERXYnZ1RWdwQ1NNUVFMazR5QkF1MFBGZjQ4UXJD?=
 =?utf-8?B?RlFtWEszSHFjcWMyVG9GZkhWSnNwSjFqRnZoR0w1Y2RBR3BHaXlKRTB1TlpP?=
 =?utf-8?B?aFowTXZGMzlwMWMxNGZlVjZRNDlhS012Wnh2eEZMc2JFRXVla3lkZFRnUzJk?=
 =?utf-8?B?YTV4ajkxdGNvUjcvUDhRS1JHNFRRdFkzZ0pSV2UzN2FSREdnMERZdXloajI2?=
 =?utf-8?B?SkJ3YjM3Kzg4ZThPa3JhaXRGaGhQeGZtWkxDc3p0Ti8zaFhHb2o5T3ZRdEV3?=
 =?utf-8?B?S1BOeU9TK29Ya1dhQU9iRWNyQ0FmRm9veHoyZ29rSFV3dzB5Vk9kcWlIVTFk?=
 =?utf-8?B?Q0JicURDQzBDdFpvOEpHdHdhZEhITWJOcmozMjhkWHk1cmcwcGhQTXI5aS9r?=
 =?utf-8?B?V2ZKb3N6MmhBUUQ0bVB0SWNwNXpSbi9GWnBwUUFVdFdHWjd4c21Yd25ieVNI?=
 =?utf-8?B?Z0xieXNZV3pBV2svYnlmOGh1blVZSkRwR2poeVBTc1J3TWc2dEVGV0xnM1dy?=
 =?utf-8?B?MllDUGcwUndoV1pmY3hKTTZTcHJHeTAzeW9mK3crcUhMclVPeEpHb1NJK3ZZ?=
 =?utf-8?B?Nk02bjVMS25Dc1VGWWt3ZEg2Mkt6eFlBc1F6dmprV0l2MHRML3FQVlorRTVX?=
 =?utf-8?B?SnBlenFaZ3lVQlNhVmpiZnBOYWY1dk82ZEp1QmUySWF2WXRoMHZMdDhxalZ1?=
 =?utf-8?B?bVd0eTcrRjdBc2ttK1JTWlROaUJOcjVRU1hNWi9xUTE1U0tHQUhiZjZnNVV6?=
 =?utf-8?Q?JzYVFHb6MVlalcsCdvxpsGZnU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6afa3e9f-9cab-4dce-1c21-08dca1b56833
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 14:26:09.2434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGHH1HE1d8iFLz8xXvc97vEp9kKRXBe/F1DUZheoADpSnvGnBkoHn295h0sjN2pp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525

Am 10.07.24 um 18:34 schrieb T.J. Mercier:
> On Wed, Jul 10, 2024 at 8:08 AM Lei Liu <liulei.rjpt@vivo.com> wrote:
>> on 2024/7/10 22:48, Christian König wrote:
>>> Am 10.07.24 um 16:35 schrieb Lei Liu:
>>>> on 2024/7/10 22:14, Christian König wrote:
>>>>> Am 10.07.24 um 15:57 schrieb Lei Liu:
>>>>>> Use vm_insert_page to establish a mapping for the memory allocated
>>>>>> by dmabuf, thus supporting direct I/O read and write; and fix the
>>>>>> issue of incorrect memory statistics after mapping dmabuf memory.
>>>>> Well big NAK to that! Direct I/O is intentionally disabled on DMA-bufs.
>>>> Hello! Could you explain why direct_io is disabled on DMABUF? Is
>>>> there any historical reason for this?
>>> It's basically one of the most fundamental design decision of DMA-Buf.
>>> The attachment/map/fence model DMA-buf uses is not really compatible
>>> with direct I/O on the underlying pages.
>> Thank you! Is there any related documentation on this? I would like to
>> understand and learn more about the fundamental reasons for the lack of
>> support.
> Hi Lei and Christian,
>
> This is now the third request I've seen from three different companies
> who are interested in this,

Yeah, completely agree. This is a re-occurring pattern :)

Maybe we should document the preferred solution for that.

> but the others are not for reasons of read
> performance that you mention in the commit message on your first
> patch. Someone else at Google ran a comparison between a normal read()
> and a direct I/O read() into a preallocated user buffer and found that
> with large readahead (16 MB) the throughput can actually be slightly
> higher than direct I/O. If you have concerns about read performance,
> have you tried increasing the readahead size?
>
> The other motivation is to load a gajillion byte file from disk into a
> dmabuf without evicting the entire contents of pagecache while doing
> so. Something like this (which does not currently work because read()
> tries to GUP on the dmabuf memory as you mention):
>
> static int dmabuf_heap_alloc(int heap_fd, size_t len)
> {
>      struct dma_heap_allocation_data data = {
>          .len = len,
>          .fd = 0,
>          .fd_flags = O_RDWR | O_CLOEXEC,
>          .heap_flags = 0,
>      };
>      int ret = ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &data);
>      if (ret < 0)
>          return ret;
>      return data.fd;
> }
>
> int main(int, char **argv)
> {
>          const char *file_path = argv[1];
>          printf("File: %s\n", file_path);
>          int file_fd = open(file_path, O_RDONLY | O_DIRECT);
>
>          struct stat st;
>          stat(file_path, &st);
>          ssize_t file_size = st.st_size;
>          ssize_t aligned_size = (file_size + 4095) & ~4095;
>
>          printf("File size: %zd Aligned size: %zd\n", file_size, aligned_size);
>          int heap_fd = open("/dev/dma_heap/system", O_RDONLY);
>          int dmabuf_fd = dmabuf_heap_alloc(heap_fd, aligned_size);
>
>          void *vm = mmap(nullptr, aligned_size, PROT_READ | PROT_WRITE,
> MAP_SHARED, dmabuf_fd, 0);
>          printf("VM at 0x%lx\n", (unsigned long)vm);
>
>          dma_buf_sync sync_flags { DMA_BUF_SYNC_START |
> DMA_BUF_SYNC_READ | DMA_BUF_SYNC_WRITE };
>          ioctl(dmabuf_fd, DMA_BUF_IOCTL_SYNC, &sync_flags);
>
>          ssize_t rc = read(file_fd, vm, file_size);
>          printf("Read: %zd %s\n", rc, rc < 0 ? strerror(errno) : "");
>
>          sync_flags.flags = DMA_BUF_SYNC_END | DMA_BUF_SYNC_READ |
> DMA_BUF_SYNC_WRITE;
>          ioctl(dmabuf_fd, DMA_BUF_IOCTL_SYNC, &sync_flags);
> }
>
> Or replace the mmap() + read() with sendfile().

Or copy_file_range(). That's pretty much exactly what I suggested on the 
other mail thread around that topic as well.

> So I would also like to see the above code (or something else similar)
> be able to work and I understand some of the reasons why it currently
> does not, but I don't understand why we should actively prevent this
> type of behavior entirely.

+1

Regards,
Christian.

>
> Best,
> T.J.
>
>
>
>
>
>
>
>
>>>>> We already discussed enforcing that in the DMA-buf framework and
>>>>> this patch probably means that we should really do that.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>> Thank you for your response. With the application of AI large model
>>>> edgeification, we urgently need support for direct_io on DMABUF to
>>>> read some very large files. Do you have any new solutions or plans
>>>> for this?
>>> We have seen similar projects over the years and all of those turned
>>> out to be complete shipwrecks.
>>>
>>> There is currently a patch set under discussion to give the network
>>> subsystem DMA-buf support. If you are interest in network direct I/O
>>> that could help.
>> Is there a related introduction link for this patch?
>>
>>> Additional to that a lot of GPU drivers support userptr usages, e.g.
>>> to import malloced memory into the GPU driver. You can then also do
>>> direct I/O on that malloced memory and the kernel will enforce correct
>>> handling with the GPU driver through MMU notifiers.
>>>
>>> But as far as I know a general DMA-buf based solution isn't possible.
>> 1.The reason we need to use DMABUF memory here is that we need to share
>> memory between the CPU and APU. Currently, only DMABUF memory is
>> suitable for this purpose. Additionally, we need to read very large files.
>>
>> 2. Are there any other solutions for this? Also, do you have any plans
>> to support direct_io for DMABUF memory in the future?
>>
>>> Regards,
>>> Christian.
>>>
>>>> Regards,
>>>> Lei Liu.
>>>>
>>>>>> Lei Liu (2):
>>>>>>     mm: dmabuf_direct_io: Support direct_io for memory allocated by
>>>>>> dmabuf
>>>>>>     mm: dmabuf_direct_io: Fix memory statistics error for dmabuf
>>>>>> allocated
>>>>>>       memory with direct_io support
>>>>>>
>>>>>>    drivers/dma-buf/heaps/system_heap.c |  5 +++--
>>>>>>    fs/proc/task_mmu.c                  |  8 +++++++-
>>>>>>    include/linux/mm.h                  |  1 +
>>>>>>    mm/memory.c                         | 15 ++++++++++-----
>>>>>>    mm/rmap.c                           |  9 +++++----
>>>>>>    5 files changed, 26 insertions(+), 12 deletions(-)
>>>>>>


