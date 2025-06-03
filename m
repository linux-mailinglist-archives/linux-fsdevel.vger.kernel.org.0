Return-Path: <linux-fsdevel+bounces-50460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65836ACC773
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 15:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 244D13A3735
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 13:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3608D231828;
	Tue,  3 Jun 2025 13:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FYfJztyU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4242745E;
	Tue,  3 Jun 2025 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748956475; cv=fail; b=MLYG2ZDVr3RqnzmCw0iwHxypYz8o9KqBCy1yVhk+YOP3ujNN+mnf5jSfv1OGr7iBA5jngmFwRcO+2yLAVi+AV0sd/Xqo+okidtawef00SDyUNtFgmXzakE63nd6I/Yv/l65MeJRf0S5Um1rXk4FB6ehv7vSzgTwZKeRDGQMRgF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748956475; c=relaxed/simple;
	bh=En6AGPtyFjWM4aYP4JCkaLKR+pzawGvsuAMawnotXyE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sY3V4Akwp49KkeUTq33huqtiun8IYI5pXK8Dulf2/fafqfGeTt8NoMeFYBZ+eMx5N2DRL684Zj3l35Io+Wrmj5aGjJqkNwQmQ5BL2UzH2T9/sNFBljWTE7H7RtvuyoKbxdOQyl9PGm+8oVbZKmRMnS6JPpl96Edg+snhEw2xBBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FYfJztyU; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVAPbsIB11hKik1v2R3KMxYTWUEQ9kURDb0TVJiIdmCn68sh6rKfs1kxA2KF72x3UkW8Twil2n48sIyADvbxZjwPeEQQ+g6SJI9X4CTdf/BsOlfYCxojNhQg892P1jmt/u6gboR267an6CYW4BPWuxFLJnzhEuy2pPXmrYW1Uu0FEx5Y3KvbYpua9ukvWpcA7TRK4gM7ctFfwaeh/SWk4MTrkScSRxess+ryNuHFl0motttXQwQM11dDlRzc+WnPL60vTatUNQQSCVVpZ2hNqaHoPSUZQKFq1v55dNfTcwD9TU0HOKswwjAU+xwWTSkcJsPagsyHqyrSAasLHUHT9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBhfXodOL7h15vvVZagqWS/XWainCxsU+agCmvCZrOw=;
 b=uh+SyFdZ8JXDFUJRjxcs2oi8NH9yQ8yVNVymeNMpZpvhzBnQt91/A7iqDShTSadHLEK0AxrVm1D2MA3G4pXi21JVh/82nL8n9WLvObug+JhnaW+arx2TCR6WYrJq65mA9q0vR3ZZsfAfUn8BMC36d5s9Kw1g36L4hQ6TogFeySun/Lqltm2NcWjpNt6johPoYyu4KExdLd3U5YbVzOR13sda1yHg+SIOAv/RgS0TZODrc0ocYe5dwMID0vZLICXtwf6tBcdhBgQZtZNWDkJZ5SBaPs0avUEWo0mOrTo0I7KJQeCYEMA9iDeZyCrZM+bZzyLjb4kzr+r9Ef6F6LyDEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBhfXodOL7h15vvVZagqWS/XWainCxsU+agCmvCZrOw=;
 b=FYfJztyUv9fe0V7i6pTdf9dMdIeKlmBD2is/GOwUkI3wPJhz7aSMRoYzC/AA2jGXUd2uguxhU3aI/vkV6dGhgJdSBlkut+EwQ4P0sZHBksYUJfObZQ3x2IXv1dsisd5kTIzvVXPN2wyPvHp0mzD7hxrRV2/iQr9mRJlZfnJKh7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 13:14:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Tue, 3 Jun 2025
 13:14:31 +0000
Message-ID: <09c8fb7c-a337-4813-9f44-3a538c4ee8b1@amd.com>
Date: Tue, 3 Jun 2025 15:14:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Implement dmabuf direct I/O via copy_file_range
To: Christoph Hellwig <hch@infradead.org>, wangtao <tao.wangtao@honor.com>
Cc: sumit.semwal@linaro.org, kraxel@redhat.com, vivek.kasireddy@intel.com,
 viro@zeniv.linux.org.uk, brauner@kernel.org, hughd@google.com,
 akpm@linux-foundation.org, amir73il@gmail.com,
 benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com,
 tjmercier@google.com, jack@suse.cz, baolin.wang@linux.alibaba.com,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, bintian.wang@honor.com,
 yipengxiang@honor.com, liulu.liu@honor.com, feng.han@honor.com
References: <20250603095245.17478-1-tao.wangtao@honor.com>
 <aD7x_b0hVyvZDUsl@infradead.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <aD7x_b0hVyvZDUsl@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0032.prod.exchangelabs.com (2603:10b6:208:10c::45)
 To PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: ba518060-3538-4a70-bb3a-08dda2a093af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SytZSFNuNHpqbWc3QngzYmh5U0Q4dnhjS094d2doWWRIL0NPeVh3TEVaeCtx?=
 =?utf-8?B?ZFhUWnFvNjVHYzZMUlNQa0t5N3RZOHV2NnQ2S01SWGhEUEd1bWJmTEdqZ1F5?=
 =?utf-8?B?Uk9ZTzVobURUb05NSTJtMXpPV3VKNkpzUktiMHRmdFRZRzVzVmZ4OTV6MVpi?=
 =?utf-8?B?WXdnYzJEbDhqVkkrUWsvdXZ1QXBTVHR0SDdCa2gvRDVHbEE2UUZFQmxsMktC?=
 =?utf-8?B?QzQzdElnNnhNdWl1a0VHNnc0Y09xVGJoK0t6WGR4TUs1SkdHTDZkS3JGQmxq?=
 =?utf-8?B?a1RxeHNwU1B4bXhRMGU1TGFDcm00bUgzT1dsT0MvcytXMHpReS93WVlOVDVn?=
 =?utf-8?B?L0dpaG1WOGw4M1k4MWViV3RucUtuZXRqUzZ0YTdCVHJneFYrMUR0RWgwMmxC?=
 =?utf-8?B?NXRLcU9tZEV3a0ZrRlRuOVZqcGJlR1FIN3FWUmtaWkxDU2RzTktYNUpkTlha?=
 =?utf-8?B?Zm93MTg1QjdRU2I4VHNTL2NLN290NW5xQUF1U1c5RVlqTmVjamNIZzRwdWpT?=
 =?utf-8?B?d08wdVNzbXVkUjN0V0JMMnB2RjU4M2dYMXg5WTNibEV0WDZSK0NucUJyK1lZ?=
 =?utf-8?B?S0kvOExHeFRkZ2tQUW5KcmNEeTlsN0RmTlFidDBWZGhIMjR4VXd5OHdPRlBU?=
 =?utf-8?B?aldhTHo0Z0psWXVJSkg5MC9DRzZFQVFKY3ZFVUtRSGNLN2lycHpxSFRlNzI0?=
 =?utf-8?B?TE5uWjdBSVlpWTd0cWVSLzJKUEpORzVSRVYwSFZneVl6L1hMeHhtMGZkMmUr?=
 =?utf-8?B?clZHMThDOWQyV3dLMkFkMmZHVHoxVlRrUFVrRzRXd0lqOGZDeU1kTkIxTEIz?=
 =?utf-8?B?ZkR6ckgyOExyajlGRGFCV3Jkc1JTMXgzWXptcjNUOVdHbm9kMkVpZWFmaXNo?=
 =?utf-8?B?YTkwdEkyRzRsa1I2REQ2ZlFhRzl4cXBDRW9WNkp2WWozaXFrcUtvYnNuWVhp?=
 =?utf-8?B?K2NTV1lCM2lHWnhxSjJBREJCcFkxVG9jdWkxcWE5OXpsdlNSQ1Rtakp3TnFE?=
 =?utf-8?B?NHJpZXFFbDBLV1NsTi9zZVg3dmx6aFlWWXNFdEdmMUphWVZtTlY5OGpiYVNO?=
 =?utf-8?B?ZjArYjB3UG9Gbk5qNTdLQjJGMktGWnZvVC9WellMaC9PcFNyOUlyNkxZaFhi?=
 =?utf-8?B?SE4yTzdhckg2Y0ZOZ09OS3FreG9qbTNoSGhxZDlPMStoOFdqKzNnSUYxNmZT?=
 =?utf-8?B?L0N4WlNMNFBGT043N2hPQ2g5cWZHYVpuL1pCL2FaL2EraGs5K3ZTbUZzcjd3?=
 =?utf-8?B?QlFRR0RvSkx5N2ZnWVl4OHNLdzBoTGFFYUI1S3RYK0JqWjFFazJWMWd2MVl4?=
 =?utf-8?B?eENrQ1lBckVPWHVXVzRBMFhSZlpGRk9EVUFPRE5xTnd3VlFjczRZWGhlTHMy?=
 =?utf-8?B?Y1YrUnhCaEppTTlydHF6Sm9PYUVkUkZtcUVYa0lLYWUzZ3NHTmRDMHBGUkhs?=
 =?utf-8?B?dGJMS1M3UlJicEVaU2ZWVmtKTWN5SmF0aEJoN1VwbjhlMU1wd3RiUld3S2ZY?=
 =?utf-8?B?QjROQm15RHJYeUcvMlQ4cjNMM01YbE1qZ1F5eSsxMjZBbXNFa0MyYXFvaytJ?=
 =?utf-8?B?UmZlMndFcFpWUzZKdnpocWNJOE1udStIbitFcWNjZFNmYnF1dk1YTDlwemhq?=
 =?utf-8?B?U0pPTTBjM3JuQndaWVN3cFRSNEMrcVlkb3E1VmJEc1pqeWIvUUlUaGlFYXhV?=
 =?utf-8?B?ZFY4cCtWcDhDRnBzYTEyR3hHQ1BNaWZoQXRWdGh5ZU9ZZjJTYU1RejlSdlBh?=
 =?utf-8?B?VFMvQkUrQlQ3b0ZSVmswUGE3VUpHVHUweTJYQmNDUjJ4aFJ3RkI0c3dxTWhq?=
 =?utf-8?B?NlhkVzBlZnJkT0NjdFFhdGEyMmZLV3VMOHFYU0h6QjNBUnhWamVpMklNcXVt?=
 =?utf-8?B?YjdYQXk2Yk50OGlXWUFJcmlvbFFlUDFuak1JdW5KbFhkWW5MN3FnT0RsNXhC?=
 =?utf-8?Q?mg+YnhcHuH4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTdJRGhMSVJhUjNWR0hFdDhzdmJpUlVLUDNrblAyVXUrV09pZGFnUEx5VDVs?=
 =?utf-8?B?cHhEZVhZS3piREVVOWdxRi9QcEhXdUdJNzZ3VkhrWlpmYXI0TWhONFJ4MXVC?=
 =?utf-8?B?UmZOZXU3cEpPT0FKSmNLL2JOWTJFc0RQSUs2M2x5cDdQWFhacUtVeWVYTnk5?=
 =?utf-8?B?T1R5RUZQVnFucTdmYktoaDZoSENhbmVsdjh2bHlxd1o1VWIzMWhKbmprb0Jt?=
 =?utf-8?B?QnV2SUpPM2l4bCsvVUh1UUc1UGdXNmVhdDAzd3Y5NHRSSHkxWi8yWEFUb0dl?=
 =?utf-8?B?dnNBKzRIYXhFZTFjaEVVK1YweGlMeDNvaHpCcUY2WTNySytFNUZKc2lkVUxu?=
 =?utf-8?B?TXBXek5kRlRNODdUdnNjdW9FalkycUw1cjBiN0JaMFlYZHh4dWc0SkFHRC96?=
 =?utf-8?B?K3pEM0VJVWJMZzRSNTk4MWYwOFpmSEpVUW1uK1NOd0I1Ni9Ybkt2ZDB3MWFl?=
 =?utf-8?B?M3JDdXJFeUlzZWh6ZlNsaU5sUFBsSXhmckxBaWpXR2JOSjNEdGRVY3psSy8w?=
 =?utf-8?B?ZEhUeDh3Y2R4dkMxS0F1WFg2MXRSOW1MK1FGOFh1T3dJaHE1dFFsTmNtL0Zl?=
 =?utf-8?B?NFhjZ2VndGJuNmxRMFRITHk1UE0yTFZQM2ZJWEEyUTYvR2NJelJoUFdzUWZ0?=
 =?utf-8?B?a1Z1ZGRHYlFMdTBBQUcyM0EwN3ZSOVNZa3FoVy9sd0Nqb0hCZFJRSGpUU2do?=
 =?utf-8?B?a2xNczlEUjRkZnJ6Vzg2SC9vVDdka3RyUGhReHJlU2h3WFM5ZHBKUDBEOEtn?=
 =?utf-8?B?TWF0Q0ZET0pkdzBqelRPMnBtTTA3Z3BVT0lsY3VYN29TdC8wWndNUUlDR1Ux?=
 =?utf-8?B?SGdnYmF0Ti9XWnVXKzdsdlhrZk1ZeUo2c3gxYUxuMUFkdm51UGZzVlpWVWpq?=
 =?utf-8?B?Q1MyT2ZwOGs4RldvblVsZHlUQW1ZcDFncmY3Znp3eXo5cnk2Zm5HRm1ZeDRF?=
 =?utf-8?B?RlQ3aEZ6cDUyb1ZJV1FlcTJMUlgyZkxRdGlJS3h5UWJWbTN2amxkaGUxTUNz?=
 =?utf-8?B?YTJSNXpPWG9kdnQ4czFWc1FoNmNlekNhbUxGUXZwdzhQVlhZMU83WGhua0ky?=
 =?utf-8?B?UXhjaDRDYSsxY0E2S1RYeVBVRjE5UzRDRFhwVU9sMm1kQmh2dHk4TWgxUmdl?=
 =?utf-8?B?clV5T0FDM0tua2VNeFlHU08xa29PdEVzT081U1dEbUg0NWU1RVFudjlid0E3?=
 =?utf-8?B?ZElvVTdHd3o5TVRNMTZFNDRPdm5HTzVwMmRiL3FJdXJkdzl2V3ZQUlRWclB6?=
 =?utf-8?B?dEdUdHF4dlpIUTc3akora1pSU3RrL284M3V4RlgzRU1abllqWUFFVFNxOHM0?=
 =?utf-8?B?dzFUYUIzZ2N5OXFGUmY5Ny9uK0NiaXZ5cGVWYXBVdStFZW9BM3I1R0dlV3Ax?=
 =?utf-8?B?aUFnanluS3VnOTE5aTRWcDV1dHQvbTVBTjdrY3NWSEgwUkZLSWwwS1lHUVAx?=
 =?utf-8?B?bmt6K3cyaXF5U3lhdjdheEJ2ZVlnVnUzY2hGZFd0QVNxN1o3YmtDeWtSTUxW?=
 =?utf-8?B?bEJCSDg3VFJrbmpOZTVGbHZSVDBHdm85T0dsT0ZrOUVWZk1BWllqQ05nNUQ5?=
 =?utf-8?B?T2JSVndFb2NUVC82MlNHRTRXbVNzdElEbnErcVY2OUp3RUVaWkVTYkpZRitm?=
 =?utf-8?B?d2FCZDNubVlPMTFVYzFIeHorR1hJZWFlRzRtM3hyYW94VmhjcVE1TzRBbDhC?=
 =?utf-8?B?clFrK3NjVmVnWVhlMEVpcHlQTlFQbU5Hbmw3c1BZT0F4bmYxKzhDVlpjbkhQ?=
 =?utf-8?B?bXFqTmphUWljR01sK1NKN1NRTjhQdEJNWmdIMERZQ0V6ajliTjZWdzRRN2dU?=
 =?utf-8?B?ZlJGS0lodDVxME9UWUo3cWRlK2hNanMyYUk4Q01Rc0pyM2dQUjZ0YmVHUDBD?=
 =?utf-8?B?ZnRwWHY3VjN0anl5Q21VZEdmQW8wUHdoU2JRZjV4VDlDUG1VdHZ0ZzRuVGNW?=
 =?utf-8?B?N2J0c1lYREhPQUVKNEUxYXR3WmdNeUY3SGpNcG54ejJNWS9ZL1BibWtPKzJB?=
 =?utf-8?B?WTgweThrandmR1ljd1FZcW94RUU4bHl3NFFJWXpWbjU0NG9nSnE3MFFMU21H?=
 =?utf-8?B?LzVna1pnQ0xtMmZUK2ZzR0QxMExGQXdPZ1BtR1V3K2c0cWpwUVhMNC9oTzNU?=
 =?utf-8?Q?4RcbKRxH5ydcYO9mopi6w51t6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba518060-3538-4a70-bb3a-08dda2a093af
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 13:14:31.4988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wrO5h+eTeMPV3z0qd3TMzjzxJiiSKblQiE35C/ihnNcd/MLmC1gIwHnc3wXkLYqi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732

On 6/3/25 15:00, Christoph Hellwig wrote:
> This is a really weird interface.  No one has yet to explain why dmabuf
> is so special that we can't support direct I/O to it when we can support
> it to otherwise exotic mappings like PCI P2P ones.

With udmabuf you can do direct I/O, it's just inefficient to walk the page tables for it when you already have an array of all the folios.

Regards,
Christian.

