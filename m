Return-Path: <linux-fsdevel+bounces-18910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263208BE6D3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 17:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48EEB1C235FD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 15:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B19816130A;
	Tue,  7 May 2024 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ANbqKu8G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1106815FD0E;
	Tue,  7 May 2024 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094144; cv=fail; b=cIQXJaqb9FzUmUF0CqBX+3C//jV+yN3kYGMfvyMnwbxStcOh5gE1AVz9RxNiPFR+5s7YgbxqT/V+gE7dCVKSZzEuQQONgw/ol405dFEceZtKEVybNXkOm+qkRwKy3P4NJx/tbEzHPFBIXsv1PQnDo/Rxn4Uo5XaLQcX1mo1fZ7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094144; c=relaxed/simple;
	bh=V5WTXGPTQQtE3Ukdhxz34MjyMhHpXTWY0GslWgxScG4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NiqU2Z2Ti+x3nDcUMHLHJmxEuyFJ4TdazbCq20cgDZe9epG8Tga+wceTOwm8HKnZFHi4R5xhVr3Vn+hGbEFWkrJofZWfW/PmxmiHBW9OIjyjZyEyt9QR7JlEL0EuNe8acbtAzKln0T6rK7o0gFcyJahxwukhY0AbhjFrzlwfRWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ANbqKu8G; arc=fail smtp.client-ip=40.107.95.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LU/XqoKkQjl/wrWGlbcDaOpiq68GO9AfGMiTu2LAt7ZDL250ZWLFaO7WtpSMYcP0i7LvaN3vt1BgjseuQQP7a/VX6NN2NZ/j1Bemp7MZyga97Mhz/1rAfWjbVH5/8RBZ2z7NE2miCoyzcIJQOj+agTOBxYrNAuqOpqLAZM3UNMycPX1NnGUi1e+0AIgRxe0WHkfO2lfQuf2garqmlX285faeLjFhBe2LH2HKX0iQmeBDT94Ackt5rzpMyjxSDK+4dYWFCZD27O2WcQXVGMA2nM4ff8epFPapPZdVGOAKUcoA1mctGpOcfnfyRr94GzG9CiIOYtBdif+y3hA6NTjw9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfSZw9COqzXobHiGHM8JsNTcvYmtkLFXCbzwb59VraI=;
 b=OedtWQa420qElTtDPE6FDJJpCmxSoeAQ0YHvb+rHBIMPvWddggkzpQ6WPeLUTT9mQ1ij1NLfcWTTpwXfSIflZisARG1N7Cf6OVm16oGi3qhY0MXseT7tlFpnwRc/iRvHvsUVBC/xGCynJBbu2nonEvCZ1koShBOLaLHxT45Mn+VTPir9Y5wnVfaz4MZtHWnwFL502mq7oZvatzOnTrNngyhJEYlP8X29auWSIge4R508Yo7Md7SX75tSWLeSXRcyUXbUdZXwo/gMn7YA4dPyyJplFZHSTSG4P2+4mMKwDlhGILYtlGY7Zf8+3tdT1BtxxXpXBKxWTzYOl3/oBGbaIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfSZw9COqzXobHiGHM8JsNTcvYmtkLFXCbzwb59VraI=;
 b=ANbqKu8Gs8/BYoZ4I8tz481k0mf8WwSweK+1JWQ9ugoA2u1kFjPm58YcTkMFfBTWXMGUAcdQ57EYcFxjjwf7hHVygJ6CGwnG+D7DSdjiw+DlxPmsy4DUlLtlkpfM39L2mEkjI3paoDfNuLLPWW11xjNWYm0Hc4Wvpp/KUzbNHiY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6615.namprd12.prod.outlook.com (2603:10b6:8:8d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.42; Tue, 7 May 2024 15:02:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 15:02:10 +0000
Message-ID: <fca9ea1e-8e42-43a1-b49d-4a5b929be30d@amd.com>
Date: Tue, 7 May 2024 17:02:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [lvc-project] [PATCH] [RFC] dma-buf: fix race condition between
 poll and close
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>, Dmitry Antipov
 <dmantipov@yandex.ru>, lvc-project@linuxtesting.org,
 dri-devel@lists.freedesktop.org, "T.J. Mercier" <tjmercier@google.com>,
 syzbot+5d4cb6b4409edfd18646@syzkaller.appspotmail.com,
 linux-fsdevel@vger.kernel.org, Zhiguo Jiang <justinjiang@vivo.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
References: <20240423191310.19437-1-dmantipov@yandex.ru>
 <85b476cd-3afd-4781-9168-ecc88b6cc837@amd.com>
 <3a7d0f38-13b9-4e98-a5fa-9a0d775bcf81@yandex.ru>
 <72f5f1b8-ca5b-4207-9ac9-95b60c607f3a@amd.com>
 <d5866bd9-299c-45be-93ac-98960de1c91e@yandex.ru>
 <a87d7ef8-2c59-4dc5-ba0a-b821d1effc72@amd.com>
 <5c8345ee-011a-4fa7-8326-84f40daf2f2c@yandex.ru>
 <20240506-6128db77520dbf887927bd4d-pchelkin@ispras.ru>
 <eb46f1e3-14ec-491d-b617-086dae1f576c@amd.com>
 <ZjoFOwPt2vTP1X-x@phenom.ffwll.local>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <ZjoFOwPt2vTP1X-x@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ee3d10-51ab-40a8-9e92-08dc6ea6abd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnhlNS8yTFNzUXhXZm4zNDlJSXVWTmRRWW56QzI0RFRtMFlldjdFWXdpSTFv?=
 =?utf-8?B?ZUdlTVd1K2NnZkpXeDhyUjNoaWxpTkp1OXYzV1pjdkFla3FFREVCdm9KWG9S?=
 =?utf-8?B?NThJZ0F0b0lnY3l1Y3Z3NnBzT2Y2bXFkaDVIWHROdmkzSFBSVm11UENtWEVL?=
 =?utf-8?B?OWhKUjBTS2FMVmJKbDR4eEN1S1FLMlZSb0dvbEhocHJpMlNSN3hUc1VnbGdm?=
 =?utf-8?B?R2E5aDdnVWxrbGVrTFJ6eEx2S0hEWkgwZnJGN3c5a1QzRy9Ed2VhMTN5RTlM?=
 =?utf-8?B?MFNrTmVIck5YbnBQaXJYVzZRMGNmL0pHcFpmZjNud1l6anhtalNMdHV6eXJz?=
 =?utf-8?B?OTdycUpLNVcwczRPTWdQVmF1QlR4WmdMM0hOZGNKT0Q3VjFCUkN3NUpvUml0?=
 =?utf-8?B?M2d6a1ZmQm1IKzhQcUF6bWR4SHZXcS9RZGw4RExTN3o2NHVrUUFySy9CUzlx?=
 =?utf-8?B?V0pER3hnNDB0TnVsSGpnalk3NzJNZDdFYWZEQ3A2YnNteTJ2T0hjOG13QkVz?=
 =?utf-8?B?V2lYV3ZpNkc3QkFOeWZhMW55Q3Zidk9YWktUVkt5U1g5YVVrRFFna24wbDR2?=
 =?utf-8?B?QTJ3OFhDWUJJM0xmZ2pGMlBpQnViZGtRUys1dE03WGVxdXNzNXhNMmZLNm5J?=
 =?utf-8?B?SHMvc1NWYjJwOVNJZWpxZ0Q1RFNOMWl2cGJmZTRCdXV6bHhxdWxGRURBM1NG?=
 =?utf-8?B?ZWV0dWRwbXZzSlZoUk51SG1pdE9oaWZWZUxZMU02dHN5cExKTWhuc2VPczBT?=
 =?utf-8?B?Rm9QK3VNQjFuQ0tDMVM0QjVHR3V0ZWRtc00zWFhkVlBQOEtLSkVGM0pmY3du?=
 =?utf-8?B?YUd3ZmtISEJnM2NvUUtjVUhZK0xMU0NLUUJ6NDF0ZDB3Wno1bmx4RDNiNnFV?=
 =?utf-8?B?UGk3aVN1VTR1aXZyVnFTbTF3Y2UwNUdiWkd6bDFCaEQ4djIxVkI1T05vTTVJ?=
 =?utf-8?B?Z1dhcVUxdm14VTBuSWFUS0FZZW5XOGJZWmE5WFdQV2ZMd1BhR2RjM2hhdGts?=
 =?utf-8?B?Z0lsS3BsSTloR2k2b3RrcXNIREtMUm1KdHBMdHpuOFJ5aGpUVlZaSHkxSG4r?=
 =?utf-8?B?SkRCMVM0cjc2OGEvVGpZREtsZkt0U2FsTEY4eWJyM0NWMnNnWHlzZklqZzdH?=
 =?utf-8?B?aGN3dTFGS0dvSlVOM3l4bHBYZHp1V3lHRDIvZ3l0L1JQNTRVNGIvLzMxUUJQ?=
 =?utf-8?B?SVg2QkJQSUc3bkRESkZ4TFVVQjZzS1BvdjB2TzR1STVsRzB4Q3AxN0E3SWZ6?=
 =?utf-8?B?WkdiWjJxNnNNZDIxSlpDaVdReExtOVEwdWJwMEFIWG1ONVB4Z0ZScGszY0VR?=
 =?utf-8?B?K09GWjlVME9MRlN0TGl6ZHZ5UE9CeTlIU2dseEp2V0FGRDNEaEZLbm1ybDhl?=
 =?utf-8?B?b0Y2RTVDeUZiajVsM0xmYnpzWlAyZENvNlVQY1o2Qnk1RWRQQ1c2VzFoY01s?=
 =?utf-8?B?TnMxRVkyUEc2cnBZcEtKUFpoMkZveG54MWdhWVoyaTkra21JWGFHdVFQU2E0?=
 =?utf-8?B?bS9qZjVzS1ZweEIzWkg2MWpYZ0lmcDU2dGtYMjVmUGNLSGJ3b1FVdFA2RFcv?=
 =?utf-8?B?UjY4VzlhZ3BCbnRtM2NhamdxRTlzcjJuRWF2cEJPNWMrMmllUHFpOG5ydzdu?=
 =?utf-8?Q?qIAyHDp6MYVsXbtJwU9uIZdBpAwtRCxddBnbkX0SE2Pk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTN4a0NhQUt3YWZ4cE5rbTgvZGxmeXJ2dzBnMUhhSGtIalVmUFhjMFVUa2kz?=
 =?utf-8?B?d2VoK0JlZEREM0VlMXl3dkJvTkJyQVpoRFA2WGpvbkRId08vNys1VW1jWWZR?=
 =?utf-8?B?WFNQN25iRVp4RTdEUWFZbHc2dk01UVNVQXUxZlIzMHo3VUJVUkNzdFBKQ3M2?=
 =?utf-8?B?bjloWmRlbjNSNzhCQTdlSisvWHBWRmtpQ3pSUFRNd004bm5yWEpvQkxuNlhW?=
 =?utf-8?B?d3JZb3ZuOFZ0RzQwdXZ2enVuRE96K29pVEtqUEtJNHdtYjArUGppeU5kQnJl?=
 =?utf-8?B?cGE2bEszRU42ZVFYODRHSmEwdTZlUDF6UnljTWpOaGx0RTJHRk5NQi9Celgw?=
 =?utf-8?B?dGE2UE92K3hlUEJMWktDZnNsR1ZhZHFXWHFJMXpySjVvY0d0a1dBYkJUWkxH?=
 =?utf-8?B?MVZlZmQ4bnN5SlNHelAwMy85cmo2YlZ5bkUzQTQ1RjJIa1VQSHJyVFJTVzRM?=
 =?utf-8?B?ZXBZcTZyaEd1ZFNLcEtTay93cm5xRktmRHl5UTRpMWo5L2tkQzRZM1dnT1V5?=
 =?utf-8?B?TXgvaVJFTFFFbC9paUxNT293dENBamVkaVhmS2tkT3A4RkZVYWh2MDRQSHFN?=
 =?utf-8?B?bUtlTUJKekVISUlCWGFpVVJZVE5xcW9xa0FkelNPQmZPRUdlUkhyUXFVOWRs?=
 =?utf-8?B?K2lUOWRZOGNDcHVuZnp3cGdLdEJ4Z2FKVkVnam5sNjE1b3BKQ1gxL2E1M1RJ?=
 =?utf-8?B?TVRzU2o1R0RlNjFROUdSZjdsOVIvOHY5cTJDdFZUc1RCMi9lK2NWQUpVSm1Q?=
 =?utf-8?B?SGRaQXFjNjFrT2Mya3ZVVFJISG51bEp3dElSeE1sN0x3UnZKZ2w4TWFpell5?=
 =?utf-8?B?RmpoU0lyUGw3ZkRoZmorMU8rS0RZVkhMV1hENHNVaXBCaGk0eWRKblM1Q2pO?=
 =?utf-8?B?WjlrQWRlLzZBZE9YNWZZZmVJb1oyaU9ab0RFUXRvRXBSN2hWbTRwdnlKdWJ6?=
 =?utf-8?B?ejFsQVVWVkdTREtTVkVTK0ovMDdtMUlRNEY2N1pIbHBYdlZQNDN6UEN2Zzhi?=
 =?utf-8?B?bTczT1lwL0hoNXlCWlJWZTF2dXVJK2R3NWlSTHo4dnR3MS9LUTFWaCswb3g2?=
 =?utf-8?B?dWR2ZG9vVWd3WFhDekhsUVBRaHZCUzA3SVdqV1pKQ0hGaWJlamJZaWtvMGZY?=
 =?utf-8?B?WDc2bzU4RWdTRGNYRiticVZkQWRjV0VCQmNhcnpldlNTdnowQVN1VkVzY0Rm?=
 =?utf-8?B?c0xpSjR5MjQvQm1UUDI4MGxJWU10MFQxaXhjemFFNXBtMWNEZS9WTnpFVDBj?=
 =?utf-8?B?L1dIdW01YkN1alRJM2VDc1dPUGRaQ3U4b2FidndKS0xzTFJCWkZ5UUdXYS9r?=
 =?utf-8?B?SmRqbW9XdUh1NkxpcDBISzZiWGprbERDdWJkUm1keDJNNmcwN2FFVFZQc2Zt?=
 =?utf-8?B?ek5VSzcxTFVyMVo3Qml4dS9GcGxDeEM4RlN0azZsd3QxY05vVCtROW8wZmhn?=
 =?utf-8?B?QWN0dVlickdsK25FWWxWRHowaVgzSUVpVmFiVTkycHg0ZlU4UkpTRGlsNzVu?=
 =?utf-8?B?Yk5Ja0YzVloxY1FoZzJMUkF0M0c5WDdKZm9kU2VBM0lHVHZ2UHoyczU2b0JD?=
 =?utf-8?B?OGZkNTBBZHB1UDJSdnZvRWNyc3FIaURWclQrQ2lUZ1RLaXdXdHNsL1RRWE91?=
 =?utf-8?B?QnlETzZ2NFVXcG04cWYvMjJ2WGV4bmdrNUxRWm53bFlWU21vbC9abml1cmtp?=
 =?utf-8?B?QkpUNmNwV25ZTWhpQ0NtUlhqTmhSTDZHaW5FTm9GWVlGMGFCdC91R21hVlpn?=
 =?utf-8?B?QjJxcmdiNk55TkxmWGpGYlFjMXJabXFsblE2VmJsZElnbXlERDJFMlNRK1Zx?=
 =?utf-8?B?M0hmSFVQbDVBWEh6NkU0NXdqYkwwTnZqTWZRYjc3MzJkdkF1bnFiZ0hrYlVI?=
 =?utf-8?B?M1F2VWovUHBkZHBZMHJodkFFWmdnRGUyenF4MGRVR2doODlsN1hFWTVEclcv?=
 =?utf-8?B?MHpDdHhVR2dxWW5hQ3pRVUd4NGx2NXdRa2UwWGtCYW1qZGpUSjg5YWpDUUw0?=
 =?utf-8?B?dzdoUmNzanc4NmQ1eEp5R1E0RU5PaHJ4cHBKN2E0NHF6RFBNZ1ErcEFRemFD?=
 =?utf-8?B?NklNQ0RhTDJTdWtzYkdIR3J4Z0NrK1MyUEJ2MXJRTXQwKzZqalU0d0pVeEY3?=
 =?utf-8?Q?PLUkWd10taNbHTeScwuyJR1/Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ee3d10-51ab-40a8-9e92-08dc6ea6abd3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 15:02:10.8085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kXKXoIjg24wByA1XU2Bg6kqf7um22NDpygESVJbkVqK5gZKghZ78NG078kVwVzy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6615

Am 07.05.24 um 12:40 schrieb Daniel Vetter:
> On Tue, May 07, 2024 at 11:58:33AM +0200, Christian König wrote:
>> Am 06.05.24 um 08:52 schrieb Fedor Pchelkin:
>>> On Fri, 03. May 14:08, Dmitry Antipov wrote:
>>>> On 5/3/24 11:18 AM, Christian König wrote:
>>>>
>>>>> Attached is a compile only tested patch, please verify if it fixes your problem.
>>>> LGTM, and this is similar to get_file() in __pollwait() and fput() in
>>>> free_poll_entry() used in implementation of poll(). Please resubmit to
>>>> linux-fsdevel@ including the following:
>>>>
>>>> Reported-by: syzbot+5d4cb6b4409edfd18646@syzkaller.appspotmail.com
>>>> Closes: https://syzkaller.appspot.com/bug?extid=5d4cb6b4409edfd18646
>>>> Tested-by: Dmitry Antipov <dmantipov@yandex.ru>
>>> I guess the problem is addressed by commit 4efaa5acf0a1 ("epoll: be better
>>> about file lifetimes") which was pushed upstream just before v6.9-rc7.
>>>
>>> Link: https://lore.kernel.org/lkml/0000000000002d631f0615918f1e@google.com/
>> Yeah, Linus took care of that after convincing Al that this is really a bug.
>>
>> They key missing information was that we have a mutex which makes sure that
>> fput() blocks for epoll to stop the polling.
>>
>> It also means that you should probably re-consider using epoll together with
>> shared DMA-bufs. Background is that when both client and display server try
>> to use epoll the kernel will return an error because there can only be one
>> user of epoll.
> I think for dma-buf implicit sync the best is to use the new fence export
> ioctl, which has the added benefit that you get a snapshot and so no funny
> livelock issues if someone keeps submitting rendering to a shared buffer.

+1

>
> That aside, why can you not use the same file with multiple epoll files in
> different processes? Afaik from a quick look, all the tracking structures
> are per epoll file, so both client and compositor using it should work?
>
> I haven't tried, so I just might be extremely blind ...

I've misunderstood one of the comments in the discussion.

You can't add the same file with the same file descriptor number to the 
same epoll file descriptor, but you can add it to different epoll file 
descriptors.

So using epoll in both client and server should actually work.

Sorry for the noise,
Christian.

> -Sima


