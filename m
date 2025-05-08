Return-Path: <linux-fsdevel+bounces-48502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9BFAB03BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 21:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3CDD1C40DEA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 19:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D26528A713;
	Thu,  8 May 2025 19:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ATzuoJPC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B3721D581
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 19:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746732955; cv=fail; b=On+mWpAcC2QCoaVd46pdY5dCPS0rAoymClMxbUQzhVD82XICYUCzsRIZ/YHomAtA/e3KBFZIbgF1NN/EXSJ3SiHdGNuZdIM4/zZqXS0N/zo84szn/P84Xxj6fL2naj0dSJXBycEil5+suUe6b/Lk/z5FQfMJwlwqQg97rPAJXkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746732955; c=relaxed/simple;
	bh=bpyyLxlQc+kUKXaRZmNmmDJMrhLoFmnM3sU12bNS8go=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VrZ6PmpF8XNhKWFhCHR7Jzw9sYa0c3PIP7idRFx+msPORfHt0+eztWQ0Z9k96W1Y97Oee2xYeclQSsvt9muEJZqvSm9/F1Vtxu+BIGIIaUt82rm+I9uFlpDMdCDzBd1vL2WxtDjWsW79FK5ou10l6yt6fH4UVRK5Tp5eTHig5O4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ATzuoJPC; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urPUr8nWjN4t/S4zM5Xw2/ENwVqrIMmfplOsMKMYUnJ/FAmbXev5IPWVCPpqweTlcmDnSdwNgOkKLGkuwmqsnCklFt7Oiy+ayyJbtrV8A26pFRsKo5JHY1f3bK7/Wi+ySmfVHV4MT4JWtFJac/PzsfTfLPEZQH0ofoQ08JQc1wv8zwq79hivGOn5VffYWsAQ27Ef0QIMcBofRBssAIEfp9NDVPY2+IllqbGh6nMjMoQuW8T52eCthV6wGWyxur4jflLWy5z0s8oyndPoqoIQI5+H0AYXt4uVMwA+4J7TTJIk0dZZKeYHCBvrwKJFxoKNwaVbmXED3XS+avnx5qVW5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JK0kf5uNivKLroQ6xPXiHS4CP6paCaa9EliVbpt590=;
 b=SsCsfQytoNb3KYMnQg1R1xRTdBE+3xpoDrYG7X6wsVQBUNVFaZ6iQhfG4kKNKoRPJbehIh4Qxl+oS4CsW5PcMZYvXyT8K0M23oZGDqUDdmpgsiLZFpgBg7QMAgUn7zirwf0/tGCdk/9U1l/Sgtt6eHyzjMjU9pTWOQvbahN3HPwKSy052n7LoVBP1XubrP4/zfGDUBpdVR9xme+aPJKdN935+Wnjx+Tbp2iKlg7q5OY3S6SDnMMjZV+l+tTN60D5IYtjMgpatIgm/1U+hAmTNmE7iuPgyYZOHZqsGLmU0T5ZLYJg5cHtoQLVWmTYTxu0jTiP3dn1G4iYcmOf8EPXTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JK0kf5uNivKLroQ6xPXiHS4CP6paCaa9EliVbpt590=;
 b=ATzuoJPCuAKMk3NhCoTZVllypuAh2oJ897Jwecnn4YSSLzS8W5jhBOWZy7dn6gYaobB+WlhoMz+sEud1PZa2HRohpWQz0c7nNrEkkcZpgXj9emA+gnpLCvD4qhJ6PCFUJAjqdfBvNViM2LAsBnx2uGBthesj/lSmEjhRVBBNisLzWrXZq/IUsB+Zo74QxB64R5h7wjo497gEQse+y2Gy4yJnFtqcuXfAAxubFsQ9ZH6HICs1oL98JJZ2pATiDbUJMrRqGDd1Ov/yJNxBJ8LKS+hlmy1OrmGT8xCa1VZeG9UO7VhI/PZ27fCHSx7GtKQ5iE8t7vUGKKrOKpOLF+AT/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by DM6PR12MB4139.namprd12.prod.outlook.com (2603:10b6:5:214::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Thu, 8 May
 2025 19:35:46 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%7]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 19:35:45 +0000
Message-ID: <a5f97646-379c-4146-9dd3-93dab9f6ba91@nvidia.com>
Date: Thu, 8 May 2025 12:35:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] selftests/filesystems: create get_unique_mnt_id()
 helper
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
 Miklos Szeredi <miklos@szeredi.hu>
References: <20250507204302.460913-1-amir73il@gmail.com>
 <20250507204302.460913-5-amir73il@gmail.com>
 <3d19e405-314d-4a8f-9e89-e62b071c3778@nvidia.com>
 <CAOQ4uxidUg+C=+_zTx+E58V4KH9-sDchsWKrMJn-g2WeoXV0wg@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAOQ4uxidUg+C=+_zTx+E58V4KH9-sDchsWKrMJn-g2WeoXV0wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR16CA0007.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::20) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|DM6PR12MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: fc12567a-7f73-41ba-5c6c-08dd8e6786e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1R3NFVHNlJ3dGFWYWlFK0U3RnppYlFvcEVyTmVIMm84V3FjbFd5V3Biekt1?=
 =?utf-8?B?ODhEVXg1T1BiZkh2eFU5UzczVDRqSE5RL2VMdkRHZTRWRDQzQkFNMUxBZWli?=
 =?utf-8?B?Yjl5Q0I1TTQ0bkRld0xhVThwNyt4eGc4OGlER1djWXBKWCtpQUlMTGV5QVZl?=
 =?utf-8?B?VCtJUHE1ZUp4L0Nnb1hhVGFkdVh6OFQxZzJ3ZEpmUEhSSi9Ca3c1cVJvTjJt?=
 =?utf-8?B?aGRTbjlXeElGMkpzZjBnd2M5ZzBjY1VMenBtdEM5YXNmeVpnSW9iZHRkTnVN?=
 =?utf-8?B?Y2JIYzJyeUIzaDhlNGNtQWFpc2UvUWd4aGpWR3VKL09tZ21hMng1dGs1dWNU?=
 =?utf-8?B?dDJLVEpub01td1hBSEJIZjBOK2FNR1gwaE9qK0FNM1Bib2lRZ2V4R3d2STd5?=
 =?utf-8?B?VDgyakdtNFFUbEVNSy9UZ05YM3Z1Q0lrcklnNE5Yb0haR3FSUVNTMXcrYmU3?=
 =?utf-8?B?Zi9ESmYzRndMM2h3bUZkQW5uM21CckIxM2wwbDVWVXgxUmtreEd4Sk1lYW05?=
 =?utf-8?B?OTUvSWYwaTc1bXdrNDZrM24rUDAzZ3MvRVZmcVBuZ2NyVU9LaTR3ZldtUnZX?=
 =?utf-8?B?R3c4R0dPQ0IwSGZIQTZOeDJBOEVzMlVucGh4QVhpbHdXajVsc1BnMEtJQ2Fq?=
 =?utf-8?B?QmcraE9iQy9rdmVKK20wSGN6NFBHeDNXNWdUQWg2WlBoUVNUbG85WFNkbDVN?=
 =?utf-8?B?b21jTnNOKy9tZjVybzI3Ym90bW90K281TXozSFVMSzFRSGpJZElaS1VhRTVK?=
 =?utf-8?B?NW5PblU2alJ5cmdua1VZYUpEYnQxaDNJM3ZJTjVFcUJ1UlFCdFpTbExCK1ZL?=
 =?utf-8?B?ZlhqM0kyakQwSGVmUUxaK3RNb0NhK3Y1RGdZVHY5ZFVvMnEwRWRndlN5dURL?=
 =?utf-8?B?RzZFS2VQK3FGTG8vVTdDV1JwTTRZa29CMEJNbjFHWWZoS05ENGJmM2s4eGZC?=
 =?utf-8?B?SGpsTEdrNFBFQUtxZEtjT3plSFpvODRvREZEWnVsc2RUV1ZwcFk0TFA4anZa?=
 =?utf-8?B?dzlvNUFWcmhacE4rS0pFaWJZVUh5WUNPTERrMGxSczdQMjFpOVJ6OW4vaW12?=
 =?utf-8?B?TXYvK3BVY2FBM29PdFlFUUFFR0d5L3pzSGQ3UmM0SHhMSExkQlEyVjc0Y3l3?=
 =?utf-8?B?SG5nMVdDb3lJNm84c1RTKzdIelBkZXY0T0lYMzBHTzM2cGVTMXo3WmREQzlB?=
 =?utf-8?B?K1Q2bkxjU0hoUDRsekdFaHlLR1MxUkZJVWpFeEhaNTdmZDZmcVlJenhHS2lv?=
 =?utf-8?B?OWNmZU40amJ6TzBUS3NJS3cwbXhrZ0hzZ0VhOHhtWDA4SWUvZ1Z2Nmw1bVZ3?=
 =?utf-8?B?NTFrKzdTY0R4QUJOSHU1dnBmWVllYVRwUWIyZGo4MXlqR3puZG1oaGlGRXc3?=
 =?utf-8?B?bUZTRjNLVktlRDlMT1c1d2h1ck5kWStCZENHRFV4cmtRRlNhRDd2R0hzMitE?=
 =?utf-8?B?NjZOZ2tYYWFLZGZDdnZHMWF4a1Z2K1M2ZDhWWEFNaEFvdU13SmlJckt6OVh3?=
 =?utf-8?B?TWdFWjRPWTNWUUozTmIrdCtva1hRajZXMDEyTElvWVdQRDJJK29MVW9Kbm4w?=
 =?utf-8?B?QXpJeFVKVEpJQ1VtS0xNTEZGMW1Fb2JiMmFQRzZaTzQ5T3pJY0kxdzJPdTV1?=
 =?utf-8?B?bkRCTXJMalFSbU1EZGxlaExkVmx3YjM1clhUdHJKSWk0SVFSaXpRQ3dFR1cz?=
 =?utf-8?B?UVEyTUc0Ris1eEsvTWJQcm84Z25hZDRMYjFseGdHeVhUN2Nsa2swYnFRZUM4?=
 =?utf-8?B?cW52Mk50bkRFZ3dSZ1VEQ2JXSnpEaHZ3VDlkNTVBWUxZNWszN0dFUnd2WHpq?=
 =?utf-8?B?SzdnSGhFMTRRZ0pqOHNCM1ZYZ0QzNmY0NVNsaUlTSlFKVTRzMTdpdTF4YklO?=
 =?utf-8?B?a203R01MbkVzMC9ZbS9OTkE5SlordUxOUVVYUjN3T1Y2TXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGxQTW1iYzJISldmbmdvSXJBVTM2UFdHQTRBZUcvem1GMS9Ca1N5NHVYK3lt?=
 =?utf-8?B?WUlXR2lrWGJqN21uSU90QmtjeS9zRlV6Qk9yNEhuSFVPcnB0aXpSVlNmVE1L?=
 =?utf-8?B?VWVsMmFTbzdSSjdWMWdvYS9FYWFHUzlma0tILzFhZlNIK2lzd1ZHUWZUZ0l5?=
 =?utf-8?B?SEFCOWQwSnJhWitxajJuajZ2MUpaZXppaHBOemQ2VU0zVWZxLzd2MGZHd1Fq?=
 =?utf-8?B?Y3UrVHl2VXhDK2lhVWNrMXlHcngvOHlzRTc3UE5xaTVwenNBOGtpcnFWRVhW?=
 =?utf-8?B?YThOd2Vpa2Qyb2xFb1F6TkJTV2hYUHJsVDhmY1NqY3NhTzdwUSs2QXlJTFJo?=
 =?utf-8?B?YzhML2JDNmpvWUtqTHUybVkyT3NBM2szSU1sZXhlTzFRVktJenBsa3p0UEoy?=
 =?utf-8?B?ZTJiT0ZCVzZyRWJyZEJ1QUZzdE13TGlic3dmY2oxbm45SUF4RGRXU1l1eXhG?=
 =?utf-8?B?Rlh6UVBWWURZS2RrUlYyNzhsKzBtamFmdTRKQTh0Mzl1Ui9SQjBTa054aE9i?=
 =?utf-8?B?dlEyeVRzUnpSM0M3ME1qRXJqTGtpM0NOTVZ4WXhDYmdnd2JsbkdpbWFxbjR4?=
 =?utf-8?B?SUZkMS9mRnVVd3AwTStYeWFITXhUL1pLVnVNbmsxQmxybFFNWGhSM2hweDJ4?=
 =?utf-8?B?N05HdlVJV2twRy9uQnJtTTBnQkhnMnVEenhzWXVFTUNFQ1ljLzAxRlA1Y1ky?=
 =?utf-8?B?K2p4TEJxTS9UTkNSd0lDSm9QZE9ZU2ZqMkMzb2NmSjBIdnVURTBsZENwdTN2?=
 =?utf-8?B?eXE2QlAxcUJHcXRQQ0pSV2d5dDV5VytqUENieW9tY3FHQkZENnpjbGw3Wlo1?=
 =?utf-8?B?VFAwRzB1cTFQNC9zNUk4Z0tEZGc0UHFzOHdvL0IySzJqUTdHR1FTbDdTUHRT?=
 =?utf-8?B?dS9qUUtzNEd6M0VKS3ZQNkNXOW9TZkc0cjloQkVCSWJVV3JMdkoyRkFHZThQ?=
 =?utf-8?B?V0YwUlNqWU9MNlN5eUR6WUZ6NVJVS2twV0R5UzZCaTBiZTAydnNvNGFqTkda?=
 =?utf-8?B?bEVURlNpbGZuK3ZPTlhIdFV4UGtyalB5ZXNIVXdwYTdibnM3RkNsY0M4TlhH?=
 =?utf-8?B?OXRkWXE1TThSeXNCcTF5YU5hK0NYUVpaUkY2NnZtVjVOeE9tNUVLaEhuODdu?=
 =?utf-8?B?OU5JYktOWFY0NFlDS2xHM2tEajhzNC9xYkFuUURDNmphaWhKU3kwc1pRNTcz?=
 =?utf-8?B?VDVKV250Mkx3dU5IemtTcnl6Q1NFYmVHanFFazNqZ08zK3lRUGNDVzVHR3RX?=
 =?utf-8?B?VWxoWnlmK1VxclpBdVBQd0cyNXlwd0o0dGhQNWZEYXZYdkF4Uml5eWR0bGdN?=
 =?utf-8?B?bVMwVDBSVm9mRlpRTWhlVFRkRytObzRXeVlpWDE0eS9VK0tjc0QrQzJaZFNU?=
 =?utf-8?B?bGtzMFJ3UEgwYkNrRlU3TGh4YTF3OWQwbnMxZlhtaUNHWjFhK0pZZjRoajlp?=
 =?utf-8?B?OXBJcENhMWRRWi9nUDhqbW5sSkdtOWxoSnl5Vm1rVzJxYUpIK0NGanJFNWJp?=
 =?utf-8?B?SU82M1hvWjBkbXNrcTVtUjc5VSs2K0VtUHRORnFCeUdtR0xVNFFueGphS01l?=
 =?utf-8?B?cGRSN3EwMTFWdlZDUzNZZ2JTekVuN2ZKMFdkbFMzdnluWXF6T3JIVjJaZW9w?=
 =?utf-8?B?RHRiTHI5MVJzUUxPM0VaWnZSbktVU25HZVpaRG16S3FjZmtnMzE4alQ2UW1O?=
 =?utf-8?B?cEdDZDFFWkNTZWhKMjc5azlnVm5hWDJSTDBRU2hTQWw4WmlCNDdadU56VzB5?=
 =?utf-8?B?Y0FVVjFIWStGTHNYaE1zTmg0TVRZdXZ3WU95RWh6QTgrMmc5clBsY1VJdjdv?=
 =?utf-8?B?WU5VbGlsWU5rUk02alBpK1hoVC8rNC9pRmYrMEFKRUltbGgrU3JWTDhlZTVq?=
 =?utf-8?B?bTJlUVhxSTV5b2djbDd6ZzBqdUYvVGpIZ3oxc05CTVB2czFyUnl4NXNMdE10?=
 =?utf-8?B?SUxwaDYwdk0wZkRDSVU1eENkc3RHdVlGYS81QVo0NVBBeURuVlpZSUQrQzN2?=
 =?utf-8?B?TjFaYldSbTF5bk8rNXVabWFXR3Zpa0VKYXFkekEvbnFML0dkTkgwTjEwVDlP?=
 =?utf-8?B?Q29zYjJHNWtnRlRodGNXZGdsRDdiWUdjVjRrYURUK1VhdTF6NUZCSUdCVkhR?=
 =?utf-8?Q?qDnkuR8YZom0qiNTfhRNM9XZ5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc12567a-7f73-41ba-5c6c-08dd8e6786e4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 19:35:45.4197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOYPxyoAs8HgdVCS5n59LXLBedRL/qluwyAkol1kp1duOLJoKBv4LVBD58OllwghlrTKKHcJIaiLsaQ1L+24sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139

On 5/8/25 4:44 AM, Amir Goldstein wrote:
> On Thu, May 8, 2025 at 9:43 AM John Hubbard <jhubbard@nvidia.com> wrote:
>> On 5/7/25 1:43 PM, Amir Goldstein wrote:
...
>>>   CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
>>> +LDLIBS += -lcap
>>
>> This addition of -lcap goes completely unmentioned in the commit log.
>> I'm guessing you are fixing things up to build, so this definitely
>> deserves an explanation there.
>>
> 
> This is needed because we are linking with utils.c code.
> See below.

I'll look into this.

> I guess we could have built a filesystems selftests utils library,
> but that seems like an operkill?

Definitely maximum overkill, and that's not where I was going, agreed. :)

Below...

...
>>> +$(OUTPUT)/statmount_test_ns: ../utils.c
>>
>> This is surprising: a new Makefile target, without removing an old one.
>> And it's still listed in TEST_GEN_PROGS...
>>
>> Why did you feel the need to add this target?
> 
> I am not a makefile expert, but this states that statmount_test_ns
> needs to link with utils.c code.
> 
> I copied it from overlayfs/Makefile.
> 
> Is there a different way to express this build dependency?
> 

Yes, but first I need to reload the kselftest build story back into
my head. I *almost* remember the answer offhand, but not quite! I'll
pull down your branch, just a sec.

thanks,
-- 
John Hubbard


