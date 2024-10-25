Return-Path: <linux-fsdevel+bounces-32930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EA99B0DA2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 20:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0397DB24A7B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 18:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAC120EA3C;
	Fri, 25 Oct 2024 18:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BfeC9gv4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4DD20D50B;
	Fri, 25 Oct 2024 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881882; cv=fail; b=bB08wQtqOqumODXQWcj9QurwmgBpALuNbbvAIPnLFMa8Csv3S5RDHSzCcTU/3DLuENLjPdKj2Jw9zn28jJ3AcP7kW4dBS7gblhxXyckbtScqUVgXMcD3v1RwQLp2Gf8MXi9YlHv4ylnnt3lLXC8vDgFzcoNZh+MylBQ9/7J0rXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881882; c=relaxed/simple;
	bh=l4YpvgufrPo8FfhxnC/FL3c9/zSR3VKhXOJ+eZmPmLY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HZDi1gjW0mVyJNzRr4CKrgFNKAtH9oUOJWQpL6AmrxCuP9HkDB19jWdGdrilwIC8UPfHJ14agvKh+vgiOFLD6sQxsE3tj8Xn1sXv+uo14RK8S2VuLJyMrre/yLeBMtYWJXJ0n0fuu/xoFc0BWPKODdN2FLFROJFwRGYm0n/+UCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BfeC9gv4; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uz+T4qQ3/APvKTsaCJFQvHtsTbC0e8irCz1eRiyRtiIpNZSbFS0xIoYAL5qzCr9cjmzMk/WrxMbFCxLConxyQc+XiN9LbOe2uEUDLjDmzyTvGkf4Kc1yksUHkL2VafsCc+GIzTfGPW6sMuff44ogIQb/KC3gBa0VcSre7tHk6bPYpbQ0y0fiBKYebHD7qD3IZCvcSNA0DQ6gCa6JINCWOFsGZcS0PP5rEO3XdJTjez2b1zi0eSfocTisyqDWNrbmqv26L2+PWkBoRJCxmS0d/BlCBcPBmkqqVKPFHEQ935EtGK8grUx6JO67AWyp4skaCQ47fz75WdBX2+JMmR3Glw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Zskf4+W5rgPPnKkp+0VhXzR1LSwJ0Mgh0C+oSU+Zz0=;
 b=t/T3oWSQgODJsuGz7q/B7NTBV1jEB0+dGCqhjGx2nJxPbXNmesfkbxx0DRp9OBMveSUa26cvxD/HizlHlF5p7UxpC1Ie8LAksQAutWNK/YfD0QdLBld0vipnPP1a5r5REDQrfD9rwVBrcTcjU1ejFoiW5h9Z4Rj/omK/buDgNVdf1q0/RUuWtZFNfIl6nVysipfPkepHmF/YLEg4/W6cl/3s6w9SBb6Zgf11q2ycyuLoNMsuwhq/TBWttv/ylY0D4B11QyivfnE7GhIOddnoTpdpWGd9hXH+Sbsf/EraOLJlniWwO+8SUVOVukxjYSiPWaQGoaliCLO0cT/4mRq2wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Zskf4+W5rgPPnKkp+0VhXzR1LSwJ0Mgh0C+oSU+Zz0=;
 b=BfeC9gv4JJh/5dz2R6pcqzHWJ1N4QILFuJQY6+Eg8cDjtJNNfGpjQ3ZRTq95lsHFdfcpY4Mzng8M7jmIN9nJdP9mSIqAuqmDtrnMkng8xkY5e71ksZ3s5OJgprQt3m6fYIU/1OjtMoSInNbQs003mfnIbSPaZHh9Wcj1ehpIfvW0FwlV66YSPOSuoa47jKYAta2YsWIA+ex3XsM5KiYIWYFWtQ4Otxft4dWaP2L0ULlOAJc6Na/NNVYv8ZkIZ3eXDl/eyd3n7fH0gf1TN7JPrnwH+Lg0hEnkfkJdoAJJpd3vVdCRF1l0raPybp0nl2Ni+ZFPN+aFq5H6MCKQRirUJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 18:44:35 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%6]) with mapi id 15.20.8093.021; Fri, 25 Oct 2024
 18:44:35 +0000
Message-ID: <e5ac648b-88d7-4fa6-8eb4-d061a4b2baac@nvidia.com>
Date: Fri, 25 Oct 2024 11:44:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] pidfd: add PIDFD_SELF_* sentinels to refer to own
 thread/process
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>
References: <cover.1729848252.git.lorenzo.stoakes@oracle.com>
 <788fdfcc9ef602b408951d68097918d6ae379395.1729848252.git.lorenzo.stoakes@oracle.com>
 <CAKbZUD2ZB+U3GKJftfRH_2ejNja26v38OLVE2Lbfn_1KSOKhNQ@mail.gmail.com>
 <828674d9-e862-4438-86b6-61977f4cf3b5@nvidia.com>
 <CAKbZUD0fxczjSJo34MnWRNT4M6HTfWN0DRXr9CFe_+cKJW_mog@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAKbZUD0fxczjSJo34MnWRNT4M6HTfWN0DRXr9CFe_+cKJW_mog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0089.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::34) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|BY5PR12MB4211:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e0775b-9df3-4f43-8020-08dcf5251229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXJCcm5kTE5OcHBPeXhrN3lDQnZZQUt4WVNCM2hZSWxXenllbWV2eFNrMFZI?=
 =?utf-8?B?YWh5Snh6ay9KMkc5RUhrUjJ0Vm5zZlJ3UTZwMngyZ3pVRGxkT0ZTeEFqOHh2?=
 =?utf-8?B?T2V5N0lPYitrVEg4Tnk3UGQ2ekV2SnVLMiswMy9Tdlk4TWZXOVZFTjl5MzFX?=
 =?utf-8?B?eVJLRkplVGVOYUpRQ3NxZHpZT3d2RXhLTE81TFFXekM3TWJQbmFNNXdEZlUz?=
 =?utf-8?B?ZFVWUGVjUGx3azlCWFdlT2dMYkU1VnhaWmlib2RCd0puQzFzNWtFblhOcVRz?=
 =?utf-8?B?enM1YnU4MlRMeW1pd3pHK3E0TTNtRy9yRFdhMmpUN0xIQ3dObEZFK3U0SWkx?=
 =?utf-8?B?WTMzNXZqMkxQOHg2VGpxSlpFQW01dFZKaGU5dXlBa2IyMG9ZYUl3MEVmLzFz?=
 =?utf-8?B?OHZacGRFVHprWXFDQlpUcndXTHZSQ0ZVZmJKTCtiL0thTWFyZHhUMEFaOWpk?=
 =?utf-8?B?K0ltNHlWN0pyY3VTMU9CTmljY3NEZHZZKzlJWmtTS000ZCt2ckY4TGV1Nm5R?=
 =?utf-8?B?U0xqT1M2UXlDZEtFK29JUXJFc2xqL2p2OVJScEJDQTVzTFlCN1o2Qi8rQmow?=
 =?utf-8?B?djByK0ZBWmxVUnJBZ08xOE9mTGNFRjNkY0lYK2lTZkFIbDBUNm15K0xaRit3?=
 =?utf-8?B?K3hLc1Z2cGkzLzBLcE54MmdzQ3BEUnl6Ly95enpuWW1LL3ZWeHBRQzdFL2N6?=
 =?utf-8?B?YVo3MndXUHdmS0dOQktlenF3dmZaSmhBYnJlcGFHV1dDamlVWTZrZG1waHNa?=
 =?utf-8?B?SGVYNlZoSmtidnBtTzdSRzh2SklmcXZzRVJEU2JyZFRtTTVsZytxTmxlN1k0?=
 =?utf-8?B?SlVJS3pkNUM1MVo4dUNkL1FseTJSTXpldkZQYVFQSjRzRnp3WG9PQW1FZ1h3?=
 =?utf-8?B?Q0EwV1hYZzgrdFBJRXRTSEpyalo1TG9DMHpnbEMyTkI3M3VicjBWVVpHQjN0?=
 =?utf-8?B?UHQyeVhobE9sR3N0RzhiN3NvL1RpMkwxb3RiTmlFbUgvQkcyWVVyZDAwSStL?=
 =?utf-8?B?NTkzUW5aa2pxb09pQy9naG1MQmlKQmZ1Sy9WZi9DOTZCVjJYaHJKelRkNGZp?=
 =?utf-8?B?WGJjQ25pTjVsTFlVbmJCVGJ3M0JWMG5oQmpueFZLN0ErdWlNNGMycHFzckVQ?=
 =?utf-8?B?V28zYTFOVjVEaVNXQ2tOM2E3UFlxdHg5UnQ5dVkxMlVQblZGOGJGZWNHc1FR?=
 =?utf-8?B?YkR3aVd3ZjFKMVhFQWx0SGdmTVNwOVI2M2tVWmxBZVpWenprZkJkZ08vV0Rm?=
 =?utf-8?B?c0dWbS9UUFFxcXBFV3NrcUdJRDVoWm5UOS9MRnVKTlI0NnQ2THU0YXJmdzNy?=
 =?utf-8?B?NjlaQ2ZmcXU4MmZkNHNzODJRemRsN1JRSGZUeEV1UlZJbm9FRDZPNjlPZmZm?=
 =?utf-8?B?MXZ0QWNuSXVPampXVXUxSW9SQnk3NTZZWDJVRk9ISnZxQnJnanU4L0xhQk1v?=
 =?utf-8?B?bXFTKytiSUJKclhqMENjQklMVG93SmhpQkE1MXpEbTVKR1hQWG51Y2pkQktk?=
 =?utf-8?B?azFiSzI4L3RaTmswYXg0bU1sd29JOWU0SjczK0tjYWMwbDRKeXFwRWNDWVRk?=
 =?utf-8?B?RUNQRzdsUnFHZzFTMmQ5QlVsNWJoVkY5SXpSNnJFcHpSMVAyV1BockJQQ3Rv?=
 =?utf-8?B?UXhGQUdiSVFLYVduWjB3YjVyeExRVnM0bU9LODlVYkZYSGxnWVNteTZzZVh0?=
 =?utf-8?B?TmtrZGRZUEdYejJZdU93ZHVLaEZ2bk1ZMnZ4OXlYV2dFYXJFR2J6Wnc2VTFS?=
 =?utf-8?Q?ajI18O4/T88ReJM1AjTqOfrhQwQXRWg1KfSvJJq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkphcDU3ZnJ2K1ozeE96akZVbERoS1QyWHcwTkI0d04zZHFhelQxOTFjaXNS?=
 =?utf-8?B?eEo2QlUvRVg0clpiU2tXaUFVZTBheFY3K1ZmNFQ2Sjg4ZEVGUW5PMWtFTE95?=
 =?utf-8?B?L2lRTXoySWdoaXFRRE41VDFYclN2cGt2bzU4RnRDRWRDSDRBSS8ycDBYUm42?=
 =?utf-8?B?bzJZeTBFaExTMnhTWWVtU3FRakc4TlBjUXI2eFIxSFQwbHgxSVNrOFZ4TWNF?=
 =?utf-8?B?VUpKVysvM011d2kwNTdBcFE1WTZpMXpwd0NMc3ZXbE9oWFZXZEg2Wm8wbTRx?=
 =?utf-8?B?cTF2Z2FkMWtYUWxxb2YwVFRCYSt4L0JIU1JyKzJmSzZtUkFraEYwWFUyWk1r?=
 =?utf-8?B?NXdpclIrSTcwOEpCbUZvWW8zc2srOVFmMytCU3pIa0RCWDZMUmpLbkdxMmRo?=
 =?utf-8?B?NXh2dVgxcEZQMHRNeXBXN09yc1ZvTnFvcGhCYjduSVpzZVBEZUpoeHZjeDZm?=
 =?utf-8?B?bE1PRnBsb1MzalhjRkQ1aEpxTXl0UE1iMmd4bXRpM2tpRTMwTDhka1lOREM0?=
 =?utf-8?B?U0V5OVNtSkpjdDF6Z2NqOHovZUhkMTgrcW50MnFnRnd6RHRwV1FUSENHUTVU?=
 =?utf-8?B?azh5RmhCY1FYMFlzOWlpTGczNHFYY1c2ZFlCd0ltd0huazJEbUIwZXJBQ2JW?=
 =?utf-8?B?dS9SSWtqa05vWnplMzE4WXVZVk9HRUpGUWttKy9GNDcrTEcyRXlxVUFJckdJ?=
 =?utf-8?B?ZVc2ZEovYjBVQWZHbGtiQzdiS2l1c21CQlBSMlVIOCtIMEZGd0IxOFFyU1Na?=
 =?utf-8?B?VnIzakRlN3JJTFRRL29qM0pQQlhYTzdwRG5oa2w1S3ljNGxobEhzUnE0b1FL?=
 =?utf-8?B?ZHdXQ3ovWTErTHJtTWx2cWhvOXZKay9TdGczT3MvVzJ2V25sUnVlNm16eXZ2?=
 =?utf-8?B?OG1GdWFZUitWWEQwbXRSVjBZdWlRMGppRjhmNW9iQ3BlVUFoZWVuSW5hWlJk?=
 =?utf-8?B?UVA3dXpseEcxblA3eUFuR2VqdldNMTZRK0xXRkhnQ0FZeUpESXBzRXNyM0dN?=
 =?utf-8?B?alVML3g4RWplYjM1QkhtUGZrbUR2dDNqSUZjd25rZU1QVk9CeE9GRm1IaDEz?=
 =?utf-8?B?YjhkTkNheGxXUE9nUHZ0ajBUS1I3NWxzaVlGOHpVWVhvdUE0ckdRc1FxNC9x?=
 =?utf-8?B?YnBsOW5GbGJsWFhhMzU3VmRsdm9KSWpsd0tDMDZLZ3JEa0puWi9vakRWcGdt?=
 =?utf-8?B?U3dvaVlOTmJCeWNYemo1LzlFczFyL3lsVEZyYkIyNVF5ajdvNEY1NkNHMlE4?=
 =?utf-8?B?V2MvZXpGVW1zbFpjblZudS9PK0FWOTRFbXJpaTVVUjZqTnFQNzdzUDA4YVYy?=
 =?utf-8?B?RnFaazZsVmtrZkZNRFovb2s1OVFlTGtaUWlVOHVFSjV2ZkR6VXVnemtQc3lo?=
 =?utf-8?B?OHMybklCUGNjWnFOYVJZZ1lYRWVSdHNCK2FCa1VVZWp6cHdrc0NYUDRPZTMw?=
 =?utf-8?B?YXRGVzhDdVJqNVQ2cFFxb0VNWGd5c1JFNVZHMWFzUHpxeE1LUHhtRFZ5cHIr?=
 =?utf-8?B?VkNxcXJOcjd1VXd6WFVBOWttUldEcjYzUDVMcmFFYWIxUEF1S1hCemlkNXRD?=
 =?utf-8?B?KzRtaUVEMDFCWE9hTHBDd2hIVzlXN2RLRWMzS3c5VllXTXNvM0wxcEVBVWRI?=
 =?utf-8?B?Q2RRc0JTMGJORi9UTEVHYzVjdnhTa3k3V0tuMU9TbXZmZ1RHYzRoSzhzNExj?=
 =?utf-8?B?bHBCdTdWZjhVc2hSTWpycnBTbkNxMHd2ejNjUDZjejh6RFFLTkJqUXgzcmtC?=
 =?utf-8?B?Mk5BeFBzSXRod2xNTERta2swRHh5QjFkQXZJNWNsdm9iQ3pDOHRHZHRMcEV5?=
 =?utf-8?B?eUpGeWhnYXQ4bjVFM1JtUkNGL2c3bW9hYTVXejNEUExDNUUxcWNqZEdUWG52?=
 =?utf-8?B?dUsvVjZ6azdWOUJVTzBQQTZXdFYxNUR1QUk0LzNkVW9HdzJwdHJOTE1STkp1?=
 =?utf-8?B?dWMyN3pQdkZXN1hka1ZxbjdpaHRSVnl3UUdwSTk1bFg5ajJhbDZvdzI2ZmJK?=
 =?utf-8?B?eC9rcExwZTc5VzMzczUvMU1vdHRSVTY2NGNtZml2M0JMb3RXNnAwMEN4Vzd6?=
 =?utf-8?B?QUUzZm9xZkxaazQvUlRBWEtOY1lBRkZDSEc0SGlXcit1cWR0R2wrZUJzeEg1?=
 =?utf-8?B?RlhhRzdqNnAxbE1zOXdjTzRTZWlvVGlKYlVwdDB2dkh2RVlDOXBRRFNVNkxR?=
 =?utf-8?B?aWc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e0775b-9df3-4f43-8020-08dcf5251229
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 18:44:34.8708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLCJRt3HFggn0Qsi1i4iP8FH4M3s+8t/t7B8mhQ80QJpYjKrNNki3gZK1VEPEe3IFEkbndyzdUH17nnfvS7OJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4211

On 10/25/24 11:38 AM, Pedro Falcato wrote:
> On Fri, Oct 25, 2024 at 6:41 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> On 10/25/24 5:50 AM, Pedro Falcato wrote:
>>> On Fri, Oct 25, 2024 at 10:41 AM Lorenzo Stoakes
>>> <lorenzo.stoakes@oracle.com> wrote:
>> ...
>>>> +static inline int pidfd_is_self_sentinel(pid_t pid)
>>>> +{
>>>> +       return pid == PIDFD_SELF_THREAD || pid == PIDFD_SELF_THREAD_GROUP;
>>>> +}
>>>
>>> Do we want this in the uapi header? Even if this is useful, it might
>>> come with several drawbacks such as breaking scripts that parse kernel
>>> headers (and a quick git grep suggests we do have static inlines in
>>> headers, but in rather obscure ones) and breaking C89:
>>>
>>
>> Let's please not say "C89" anymore, we've moved on! :)
>>
>> The notes in [1], which is now nearly 2.5 years old, discuss the move to
>> C11, and specifically how to handle the inline keyword.
> 
> That seems to only apply to the kernel internally, uapi headers are

Yes.

> included from userspace too (-std=c89 -pedantic doesn't know what a
> gnu extension is). And uapi headers _generally_ keep to defining
> constants and structs, nothing more.

OK

> I don't know what the guidelines for uapi headers are nowadays, but we
> generally want to not break userspace.
> 
>>
>> I think it's quite clear at this point, that we should not hold up new
>> work, based on concerns about handling the inline keyword, nor about
>> C89.
> 
> Right, but the correct solution is probably to move
> pidfd_is_self_sentinel to some other place, since it's not even
> supposed to be used by userspace (it's semantically useless to
> userspace, and it's only two users are in the kernel, kernel/pid.c and
> exit.c).
> 

Yes, if userspace absolutely doesn't need nor want this, then putting
it in a non-uapi header does sound like the right move.


thanks,
-- 
John Hubbard


