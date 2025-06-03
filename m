Return-Path: <linux-fsdevel+bounces-50494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F84ACC8EA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 16:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124D916B940
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 14:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93589239E79;
	Tue,  3 Jun 2025 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uO9J/oUs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6274A22A4E8;
	Tue,  3 Jun 2025 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748960319; cv=fail; b=sLwtSRDdDZecancRdQC1MxjdEck5j/kf0ymVbsl5u5H/y4LUe1Wjei/7K5uaCVpOV4O1sfgGZTHGzYBzql8AtdJyJMzdQAJXWyFblVRdlnn2QzD706RB1csbl7SoKV/1iEP8Cvyu+dm8aSfnf/uJuxzDfeQyqbD0s3/nbgmLfag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748960319; c=relaxed/simple;
	bh=yQJfVJYZyx37FhmZ4mzSyB/nfNkxW/ggnuI1xlUREqA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kP+mW6W0qBtEsOkQQPNnPopzIxLP+9cHHmhy+tbgkk5zs+WTXuPhSRX7DuJhuC+z2p13Yx0gESSGxySM7KXvUymWXCcsRcjnkEJszqW7r1NWr/Pkd07sYcJuh76KHrQj2z7eFrt4X9VyUfhLMHvqirDvKZ6YBnKD9C1/Vpcje6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uO9J/oUs; arc=fail smtp.client-ip=40.107.102.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZb0YeeJTIF2ZNa3H4GjN7yOEJ/DHOzMwvSKGz/W4MEDGL5ahl6JEAyXwIirSMgdhHAKb+9+NQAKcgPuDKeAOaf7zjwu+iSaUmxdHTDFmreAXp1WVKcXAlTNruBU6EAH7TxsJGwl0dNfcSFRod5QGr26sercV9iRHFj4tn4f1IbFmb9AkHJA2wTdWeQrO/pU809ECj8P4SuEXPZqzuSJ0FUvrg4xzFFc1JJKxrcm6Za1QzMPnoq5Ocdisdjav8KmbUpvJHXXEtkfQoyIQrZnJs7+FFV0Z2xbBG62mZB3wBqrOw6FEmO4ufvRJt4wHq4dnb/SzosCd/EOUBEIkZPRzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRkfjBJwjz9F33JbcWXxiaXaXaBniiCUMF4JZmjhrwo=;
 b=aW1U7sa84vs9HGjDM7jby1LLd7Ao95I7b0uTuJM+eYo3Fsxrcea3KZ68a/T5cxeRpXO2OUJu3lKLkXCHnBp6XZj5ZgudPWLIaLikKGBrT3v15R7eAUjIoNHLJFjd56GUc16t18K6o8YcB+wLT0bfLcZVCLUjOXTHuAUUdtc0WJvKXlW59A3R7uOSLcXYyWeh4WdrKtuHwg8/5nPqnT8ldP37wb72YGGgOWocqxqVNSsLR2m3M9z38Z88tkTUPHUVxgZF2Oe4op1ZBUAfHea7p9BzyhYSZYvMM0zxdiWWWtkMtj8UZAanS7JZgniiCcT4e7qxniq1DWT46t+YrhMWDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRkfjBJwjz9F33JbcWXxiaXaXaBniiCUMF4JZmjhrwo=;
 b=uO9J/oUsnNvd7hnSI+OtLmOobpsEyWp8O/d7IbaupzqkHE86VafJHddU1MYjXZ2VTVApf/q7PMLKH+D4Nl/1pUCrt9cfMJU7nxp+aZDc586JJadZYHqRo204EE+92hs23fAYDMKL+q1tEYR00ki5hsv//vVFOozLNeYPS4vxWd8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7169.namprd12.prod.outlook.com (2603:10b6:930:5e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 3 Jun
 2025 14:18:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Tue, 3 Jun 2025
 14:18:32 +0000
Message-ID: <924ac01f-b86b-4a03-b563-878fa7736712@amd.com>
Date: Tue, 3 Jun 2025 16:18:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Implement dmabuf direct I/O via copy_file_range
To: Christoph Hellwig <hch@infradead.org>
Cc: wangtao <tao.wangtao@honor.com>, sumit.semwal@linaro.org,
 kraxel@redhat.com, vivek.kasireddy@intel.com, viro@zeniv.linux.org.uk,
 brauner@kernel.org, hughd@google.com, akpm@linux-foundation.org,
 amir73il@gmail.com, benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
 jstultz@google.com, tjmercier@google.com, jack@suse.cz,
 baolin.wang@linux.alibaba.com, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, bintian.wang@honor.com, yipengxiang@honor.com,
 liulu.liu@honor.com, feng.han@honor.com
References: <20250603095245.17478-1-tao.wangtao@honor.com>
 <aD7x_b0hVyvZDUsl@infradead.org>
 <09c8fb7c-a337-4813-9f44-3a538c4ee8b1@amd.com>
 <aD72alIxu718uri4@infradead.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <aD72alIxu718uri4@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: b21eb87b-d161-464c-073e-08dda2a984e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXEyTzI0M2MvaXZYV3FDdFRMVEZsb3hmS09RczA0TmJZdzdjTjA3UWVIMWI5?=
 =?utf-8?B?M0dQaHhmckZqSzhGdkdoeUdzczBtc1k1K0tvMitFWnRYUlZ2OGhxOTA1MzN1?=
 =?utf-8?B?eldLSTVyd3BsNVlxZDFobDQ2TitROEFwc3pCMEYvdjlOdzl4c09zRmF4dlhW?=
 =?utf-8?B?NkdTWWVjN3JGUlVYRU94K2Vhc2dZS2tsekh3c1pLdk5QSG5CVWZtbmhUcm9T?=
 =?utf-8?B?MDcvMDQ3TFMwZDVQWksvV2tFMkNDd2VBU0JBV1VWUklQdyt4aUdMWG0xdnEw?=
 =?utf-8?B?QXozb2FZNWRKL0VhRERYMmNtL3VDYXRLT0VqVmJpQUg2em5mS1crcXBiZkRi?=
 =?utf-8?B?c2M1UFNIamZvL3JpN2NWK1h5N3VENXUrSFBoQXpmOFJvbEpUcVN6SEdQM3F0?=
 =?utf-8?B?cU40MDNRRjFKNjZmcHlZMktrdjNncjNGQ1BFMytlS2h1ZkdOTTlzRCt0K3Rs?=
 =?utf-8?B?THZRNnlIZmR3anFYbjRxNEJFcGJwbHVnMWV6dm5IY0NSMXdXdUM1M2xCd0tG?=
 =?utf-8?B?YXhnNGcyMWtRTVlhck5vODd6Q05iejM1amVuMDg2YmRQSFZoSTdjRWhqZHBp?=
 =?utf-8?B?VUl1dWh3WGxCMXAvRFpYUXJZcjhwdGw3aCtWMWo4b205d0MwTWFtMHozeDh2?=
 =?utf-8?B?Tk5HSytiOXl2R0hCRDkyZzc2S3oxMmpFUDBqYWtjaXI4VzdHV0RSVnNKZUdJ?=
 =?utf-8?B?S0d3MzBWbS84a2U0VG1QSWRjbER2b2RJTGRvSllWZHVSNlZKMFhFT1VvMlZK?=
 =?utf-8?B?ZW9nRitwNjZmeitQaDdvd3JaRXJpWTVXTWdRVytrbW5VNjQ3L1ZMN1R6M2NU?=
 =?utf-8?B?S1gvbVJwR3RPQzF0QnBCL3ZuVGZnVkNxM0YxaUEzTXZSdTY1czN1ZmdpeS9k?=
 =?utf-8?B?OWo1eUh1TVZRNkNzVHlJMHRLK3RUUjduSDhpTVNXL0U5M3B4Nk9ZYWlZYnVj?=
 =?utf-8?B?OHoxM21Ia1kzekdTWklnQ1R1SlZQdUJ3SjNyU1RRWEluaXFLc1BzNzdTRkt6?=
 =?utf-8?B?ZTRlU0FybWc1QlVjUmo1UUQ4bTRnU1FPdUhaTG5BUDM2OE9wdXVCdU0rRHFz?=
 =?utf-8?B?UDZ2S3JsN014RXJucXFQemdrMTc3WEp4eVRKaTRidDhXZnUwSjZJVU41bkpK?=
 =?utf-8?B?SHczOGFlYTVZT1lzUHRxN2lMRmwwckRFdmllQVhKKzBiQjhDUCsraUFmeGdK?=
 =?utf-8?B?VUdrczFMNWhJNll0SDhlMWxSUzM3MXN0ekFlYnpWWXhXZmZrVVdnY3ZtT2xC?=
 =?utf-8?B?dkJzOW1rWlJoSGFySTF6K0VDR1BnWWU2cFFmTDV4SGlDL0xVb2pBODZNeUVu?=
 =?utf-8?B?QlRsMHhVVDUzaFdMNXVFNnVzcmdzeFdZaDhjUzlPUWZYbndqZ2ZkZEF6YWkz?=
 =?utf-8?B?RXUxb1FHb0ZkS2x6MWU2VGdlMmZQVUJFSHBxRzlFQkNzMUFBVjdDSjRsajJs?=
 =?utf-8?B?YTYzT2ZKR1NtV1Q0dVRQNzJiU0FLRFhDcndaTVFpSmtvZ2lTOUdJM0dST044?=
 =?utf-8?B?T1Y0YjFKM2txWmFwRVEwSFhsS21LSmJ4bVJiRGhQcTh5NnJ0M2xLaS9tdS9r?=
 =?utf-8?B?K3U5L3o5SFRBc3NwbkdLbjdwUDVaVXB4VUhLS1ZLNkhEK09TQ2ppL0NJOHdU?=
 =?utf-8?B?RzFjUm4zMVRFSVFFSjVjQjJDcThlVnBTMm56OVBsTVovSitVOVN0RGs2Tnoz?=
 =?utf-8?B?U3BkcEZIS1JVTEdHYVB0YmZVTlIwNURZQWZkTFlISE9kMXgvc0ZrWXpoUHIx?=
 =?utf-8?B?WmpEU29vSUhIYU81dE4wRG9ybmNzWnd1MHE0aVh6RE56VkFOejJRMUVtanU5?=
 =?utf-8?B?Smdiam9GNG1NSkxYV2JuMTlFUVZzYjdDMnRvU2tYZ1FJMlhPNTJnM1dmYUpl?=
 =?utf-8?B?TC9xWVAzKzFoc09BRWVOVW1TZmNlWVRYYnZuUElObFZFNkhreExYaHhEQVRX?=
 =?utf-8?Q?al5l/n6gLGM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUF1SHp5S3FBT2FZWmtDaUZXcE9kNzI0R2JvT1hhKytQdzVwSEtvdmtZNEN2?=
 =?utf-8?B?VERNWnE3SitFcUxCNFlSMzJzL1c2WTJBMDg2QlNqTlBNTjNWanZMVTFZUlg5?=
 =?utf-8?B?cy9RWVk2RlkrTE1KRUVUeG9sbVJLY2dFRFM1S1RScnpnUENkZTNxYkJCY2x2?=
 =?utf-8?B?c3ZiTVRPZGdyYS9EQzF3RFhkNVcxUzlkbDlEK3Z0WU1KbHoxeGtkaStrZlpa?=
 =?utf-8?B?VVkyeVBER0dPM0lvOXNqQ3EyeDBqdy9VVUU2S1lEcE94ckNYRnZkOGFlL2cr?=
 =?utf-8?B?enpGS2orb1ZSTUNpU2tTaCtQR21UdUJKbVZseThJV1hzNkRTNjZteDRNQ3lu?=
 =?utf-8?B?RE5XdzU4M2VGVXFnSnZYTjVDaGUzZlN0VU9nRTljTlNTTGJxMVBSOFdYZitV?=
 =?utf-8?B?dHh1YW9BRW9DS21DekYxYTNqL3FHRTdaOXpsa0xHRHNlOGwyWDAramtnZUk3?=
 =?utf-8?B?cnc4YnY0ajM4aXhvVm8vSys1cjFqdkFtUmhoQVBYMCtIdFpVZzJYZHRZQVlO?=
 =?utf-8?B?R21GYUdMNTF5NVNnMWI3Q3B3U25CRllDOU50MnJ6VjZsZXlWMkNQT2hYV1ZX?=
 =?utf-8?B?Vzk3emdHZ2orY2xMNGRkWmFHbGlpck5oaFNoaUFBdU5zUUZNanhsWjhYNVM3?=
 =?utf-8?B?L1ZoT253V3pwaXB3L3dhVzFUdVUzQ0xDNTh0TTZkMVhlMmp6NGlnTGg1Z2RV?=
 =?utf-8?B?UkVRVyt5ZlZYOWI2cnU2cU4yUFZHUnpPMzFrWDRyU1BsYjRRWjR5aVNIcU4z?=
 =?utf-8?B?ZEZLcFV5dzBzdzVOcHgrWStIbnRUREx3YWE0T05pbFQ4eVhwS1JhbnROV3k5?=
 =?utf-8?B?NkxTcHkwb3ZIWldQd1lGTnl5ZW90VkhKQnVoanV3Q0tBZ3V4TVRONTN3T05v?=
 =?utf-8?B?UGZidjlBV0kwWjNkZnhlb3BhTHlidnU1cUpPdVZGSVIrYzhQZEs3Mk5hanJW?=
 =?utf-8?B?U3g3ZVU1b0M3LzhiOWRLUldkWVNFU2h4VTlZUnN4WEQvRzN1VlpCYWh5aU54?=
 =?utf-8?B?TDMvVUZITkRHcGszSDhFc3phNlArZUEvTlgwTUlSMzdjeDJoNzdDeitwVUhm?=
 =?utf-8?B?NWNOUkZDUk56ZEYweHFJci9OeWRWNC9LY2NzeVZlcG1PMnpIMTFxT3FwVnBv?=
 =?utf-8?B?UUlPWEtsc0w0bW9Va2s3cHMvQm1aa2w3SUNZdHNLUE5McFB0MlJ3cCtGNmdX?=
 =?utf-8?B?SWsyZnk0dkV3RzEyV3ZJeE10Um1PZFZIRytxajBMK3l0MDBwZEdCOUlHTzNx?=
 =?utf-8?B?TGEvbzF3RThhdENVMm13L25PY0tKRGd0UE01QURQdVZmbUtHakQyUXJ3bkEv?=
 =?utf-8?B?U1FyUlA5bXg4MnAxU21SV0JaOTNwc3NMcVAyRFFKZTVBUitDYTZQbWcvSjRz?=
 =?utf-8?B?ZW1oQ1ZaMnNKZk8rTHdCbUN1VDJpdzBtQWp6WW5EK1BNWkhEQ1FYRWZMMTlC?=
 =?utf-8?B?K20wZ004c21GSEhBSU54UVpha0QvUDZ3bXRWM2dDdVdWcFZHVDV1REUreVo2?=
 =?utf-8?B?dW50NG9JVmNIREVhM1QxaDZvNnVZdzhwSmNyTmw0ZWt2eURidlkyOXhMeS8v?=
 =?utf-8?B?elluMktsWEd4K0JFL2tRdWR5OGlySEp2bXQxd0pUVWt3QlVRd280UmkwY1Ra?=
 =?utf-8?B?QjY0OGRGZzEvQVN4YUpBei8xVGd2RGx1Mk1DL2o1SSt1WlVLV2Z1TWc0cEZa?=
 =?utf-8?B?NXJoZTNyVGkrb1BpcjlMWWdBa3FtU0s5TEZYTTRaaXVvWElBejJGays4cldn?=
 =?utf-8?B?YTNIaFNzTWpaeU4xYStTOE9uUHp3WjY2a0pIbEtMQlp3RCs0ZXlKSkg0VEJW?=
 =?utf-8?B?RG5HRHBudDZoU25MSU1MdWhrdTRjQ0lONHZ6VUlrdVZjSjlIYXJzaW12SFJD?=
 =?utf-8?B?M3UyOVZ3eHhEejhyU2g3eWxmQjF5RmZZZm51eHc4cTZ1d3pvaUJPZnFEQW1G?=
 =?utf-8?B?OG9QM1hid1RnTEFLN1ZhdFBTZmNuSTZWVTBFekI0YVZ5TVYwV2VPRWZiQVNz?=
 =?utf-8?B?N042OEE5VUgwTGNqdTlKQnZ0SGxkOS8xSEdnTUpHN3dGM0hlWW1LY2JERlBw?=
 =?utf-8?B?bmdFajN2ZENtWVVtdmQvalluN01EdEFuTXdhN2IrNW5iSG53ZnJmN01SaG52?=
 =?utf-8?Q?Xh0GjNL4271TuVLIlDQ/CzExj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b21eb87b-d161-464c-073e-08dda2a984e2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 14:18:32.1143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzF5dHKajhuYKpFRNVGV5h6pyFlLiIXvRXSlrOibDxLykN0vhRtNlYWhRGqh+FLb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7169

On 6/3/25 15:19, Christoph Hellwig wrote:
> On Tue, Jun 03, 2025 at 03:14:20PM +0200, Christian König wrote:
>> On 6/3/25 15:00, Christoph Hellwig wrote:
>>> This is a really weird interface.  No one has yet to explain why dmabuf
>>> is so special that we can't support direct I/O to it when we can support
>>> it to otherwise exotic mappings like PCI P2P ones.
>>
>> With udmabuf you can do direct I/O, it's just inefficient to walk the
>> page tables for it when you already have an array of all the folios.
> 
> Does it matter compared to the I/O in this case?

It unfortunately does, see the numbers on patch 3 and 4.

I'm not very keen about it either, but I don't see much other way to do this.

> Either way there has been talk (in case of networking implementations)
> that use a dmabuf as a first class container for lower level I/O.
> I'd much rather do that than adding odd side interfaces.  I.e. have
> a version of splice that doesn't bother with the pipe, but instead
> just uses in-kernel direct I/O on one side and dmabuf-provided folios
> on the other.

That would work for me as well. But if splice or copy_file_range is used is not that important to me.

My question is rather if it's ok to call f_op->write_iter() and f_op->read_iter() with pages allocated by alloc_pages(), e.g. where drivers potentially ignore the page count and just re-use pages as they like?

Regards,
Christian.


