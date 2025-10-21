Return-Path: <linux-fsdevel+bounces-64981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF79BF7CC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 18:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47FD18C0154
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 16:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2A934C9BB;
	Tue, 21 Oct 2025 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dbv3aZJq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0100346E6B;
	Tue, 21 Oct 2025 16:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065796; cv=fail; b=cfYk6tMQD7FDRun7cZl9BePJbcqdMxQKra2HYVOigrY3WgYWUteZCjI2xm24KCs88pWJuDvoEZR7op0+RI3TPkY/MpV20lkiDU8chEJKPNyzE8m/jrWXhq1f8LI3zZL18dz/8fJKWEROxyeyyJyVVz5iXF1lbNZ/5DwkgndOAXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065796; c=relaxed/simple;
	bh=9WxzczWAorr3eV7Blh+x+j6bMqlSuRp33bzos0LMQZU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PWmQsovG9+Y/QyU5bWKG+3Fe4Ke50yjw/M4HO2HlfpyonhWvx7TLw1OVw6fHlqEzJmVHY8JG/b7UduQ71hCj+HQQ8jfHm2o0iZXhO6pHRxTJ0gj0TiyzrDrxVTiufr1B8ClWf6OXt1eioPN+tp2GUN8cLG49MBn8R1mlMQqQTjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dbv3aZJq; arc=fail smtp.client-ip=52.101.85.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=reu1C2uy6kIyKVc4heu9vrqR2u9yFdquwruHHLqIa5x6Fl8EGpIDMNuahXFa8W/MRhFWKaZ70yZhcxmax1jhBcqYp4yoWoZSa7rD3rC9pLyMi6zCf5mLYuhSP6dDwCc5SjTEHrka56Ysc0aNLelD6RqWy/RkMkJ9JN3nFkze3bnjbUgU/UGnv89BZFcmpHYc5NTCI7272cnbhv6S9qTt/Y/MBdvcK/4pcagXeJ+QErjJBVoWLYUbwkxtKWAZ+hHDJFqp7uMz/+wbYttwlGVGWd08e6qS2T7oqv4L2ChJ8pyR6pXQkU4przki1aatKlFxgQ0C7wN2upA23ZEky4ge3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfSQ3KYN9Svf1LKsvKaupMe2fIDEPd1NzoMitly2NLo=;
 b=vrFe2qpNNE7yFmItc8XpZ23TOrxPRKut0P10DYsWU8S9Td8JMUfh+JHIkR0GkN91zJheykRKmBLxG+ZMugRCMWVBPEpMyp4gBkf7l9O34+Xk32THU3ZHeVqywH/9VQb7llVlQHrPcSltMzEkAcqUqFdwOYgnXgyYDQiP9kR6zi1NKNupdiphjBpB/yso630u7srx4z7g7tyn++8VWizL3dpcv76XE20ha5P2Xf9qfRxV2H2vV7nBw5zOijFFD9VbIBE3JCzuvAYvmyUrj/FNRvpd6gzEa3gae2wmdVekQ5nIv84gLKrXljOeUXDPGgurVprRFXFvh1T/1jY+YPvXIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfSQ3KYN9Svf1LKsvKaupMe2fIDEPd1NzoMitly2NLo=;
 b=dbv3aZJqGoeDC6dVhryGHf5VMFhMC/bZ1SnnfnKAkV4rzc62rT5jh9L6vjs4IOgbntfCb3sxfm7Hnv6r9cvohOI+LARkjaTu/RXjcXGAt5SwmvohG2Z1ijdkNXPnh5FiYszLItFZtU+eiXAn3k/ikRi3k8aJDGW+l9S5rG5gZ5SYyycjIjM4+dGRgvfFErRRuyEv1fSeLh0YCObmVmHfxrAiXbtEP075O9x6hq1cmRiGFMjTTBlbDJsEzfyUQGgNTh4qmCLGKLWlDMp1UCNgdn5M+xqIt537PIb5rA+k3RVjVxl1wvx4Cet4nCT+vs34ZTM+gH0IZGinqa32PBKPPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by DS0PR12MB8269.namprd12.prod.outlook.com (2603:10b6:8:fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 16:56:32 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 16:56:32 +0000
Message-ID: <b4ee24a3-0706-47aa-b2ad-0f60f90793ee@nvidia.com>
Date: Tue, 21 Oct 2025 09:56:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: O_DIRECT vs BLK_FEAT_STABLE_WRITES, was Re: [PATCH] btrfs: never
 trust the bio from direct IO
To: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org, martin.petersen@oracle.com, jack@suse.com
References: <1ee861df6fbd8bf45ab42154f429a31819294352.1760951886.git.wqu@suse.com>
 <aPYIS5rDfXhNNDHP@infradead.org>
 <56o3re2wspflt32t6mrfg66dec4hneuixheroax2lmo2ilcgay@zehhm5yaupav>
 <aPYgm3ey4eiFB4_o@infradead.org>
 <mciqzktudhier5d2wvjmh4odwqdszvbtcixbthiuuwrufrw3cj@5s2ffnffu4gc>
 <aPZOO3dFv61blHBz@casper.infradead.org>
 <xc2orfhavfqaxrmxtsbf4kepglfujjodvhfzhzfawwaxlyrhlb@gammchkzoh2m>
 <a1cffdbd-ba98-4e24-bbb6-298eba40a11e@nvidia.com>
 <6hedspdzoxjtdim7nruoeh5m4mx3xecubf7einzl67jzjmi3er@o54b7v5njwk5>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <6hedspdzoxjtdim7nruoeh5m4mx3xecubf7einzl67jzjmi3er@o54b7v5njwk5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::6) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|DS0PR12MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b08a5f0-b3ab-4acc-dfce-08de10c2c959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUo0d1hUOHRWbmJNR2ZQM1F0OTZseUVNV016MVRtZkFlME03bkhiNlhxYUxM?=
 =?utf-8?B?TnptQ1c3dGVLNE52U1RJd01kTVBNMW0wWHdDK0lRWVdjcmw1OUpqS0NlRm1i?=
 =?utf-8?B?WmI4aFMxRmV1cUlRekN2OElsdnJQNTFpTUlMM2FzaDB1TjErMk5uS1ptYVB3?=
 =?utf-8?B?elc3dmhacHlMV1RVTDJxU0tRd1MvbStvVmkxdGNCVUFJekd0RWVKenlIdDdm?=
 =?utf-8?B?T3BpTWpPajF4VllRaGw1eDRNRWYrbjJxUnllVEpycHhXY3NtY0Y5ajJ6UUho?=
 =?utf-8?B?dHliVW9CTUh0RnZEcXI1bGphbGsxZy9BMW5lN0MveVEzK05STDZnTlh0UVVx?=
 =?utf-8?B?R29ERDhpRzhIR1VxbHByRTNjRDNSZE1INVJuaWZGY2pFYVFXaGU5M2lhejha?=
 =?utf-8?B?MTgrd3FrV00xRmoyZVlLQ3JMa2ZCbExGVTlHMkRmeU1CTGVDbFpLM2dYSjZa?=
 =?utf-8?B?dFRqcUdnU1RBaTY4dmhlbEJMelVlN2JRSGZBenBXZGRCQmhnbC9tYWgxbHkr?=
 =?utf-8?B?MVJSdTdNRHJVVUkzQ2VzSFh3NWtFRHk0dWREd2JiSjVnSmg0eEFpblZ5ZzJv?=
 =?utf-8?B?M1dMMUFXaDZZa2JUMlRGRDN2UmpKeityK2hXQnFwK095enlxYmIrb2pWYkt3?=
 =?utf-8?B?eEU4dWRZaXpnZ2xoUHhNQ0t2Vmh0SjFob0xCOUpsL28xQ1JsaCtSU2tTbjJV?=
 =?utf-8?B?ZGY0cmVmNHpORFFSVHgxY0hPZHJOSFFqNG52dXg5Y1puVVFJTFVybVV5ZzRt?=
 =?utf-8?B?VVlla0JJMlZMbWo2T1J4M1IydXlMUUx5bUhXdHZtbE1tbmxsR09zbytBSkJM?=
 =?utf-8?B?YUVmZ2l3MGVDT3h3UTBWbHVGaFBieDFMRE1yMEErNlFQZFN3QzEyYnN3RDA2?=
 =?utf-8?B?K2xTY2gyNzRqc2ZudnE4eEpJYVhxREtRU3NLc0E0UzV0QnBwMXllMTY0Z2tM?=
 =?utf-8?B?YS8xQmJaQ2lVUlZjc3FvYUJaNUNKRVlCUFhieGhlNG0xNzRvSWpNTHFTdmtu?=
 =?utf-8?B?OUZGR0x4QjNpKzZWV21rWFBBK2hyNE9EQnMrWk14U3lHWndKSWJOT0ozMEFH?=
 =?utf-8?B?d2l2OVhwTitqVmtxUTUxZmZFY1Q0bCtvbCtzTnFhbWtkTXFYcnFacnYwVjVi?=
 =?utf-8?B?ZlZyQ2ZhWnVVTDQxYU11U1ZrR0ZqK0ZFK2hWZWIwN29GZm5OSGZIL0tEQmxl?=
 =?utf-8?B?SmJaSS9ucVAwNFUyeERuWUpDUzhGZmZJYlFOWHNkRzFuVCt2aUFVbDA3TjZN?=
 =?utf-8?B?TTBoQUM5WGpPSFJ5SlBBM2VMSWtHak04em5ZekpQblI4WGl5VDREYlNHVjVM?=
 =?utf-8?B?NkNEaVFCdzdlQTFJMGtKc1NtQVZSbGd3RHN0aUhPZlJ5T1BmVGp6Z2pIc2s0?=
 =?utf-8?B?WTNvMWovVEZYbGxtUUlXVmhqRmpXT2V1M2lJVXo4WVo5TXRXZDR6R0sydjNB?=
 =?utf-8?B?V0RrRHhBRnlKemtXTHYwaEVzSElkQ3hhSEhtVUNJdzkyVmVEOWw2Z2dTZ29P?=
 =?utf-8?B?WW5zVkg3NjYvZkVwcmM0dGlPdE9nQllUMFhwTDBndk5Wd05ESmtJMmZXVzFY?=
 =?utf-8?B?eGQ2SFlBeEhaUFBxOFhtb2VNbEpnNlkzMTBJUW9rUStyZVJnZVM3UWNDZWhJ?=
 =?utf-8?B?Zk5BMitQSzZKNUhrM3NZVkthZGlRQTQ5ZUVFeEpaZFVBc1JTejB2OWFwYmdn?=
 =?utf-8?B?L3dyZTV6b1F3eVZNbnJlTG40bFRkUlplN1JaV2lCdmxZaDlBeXovWTAyeVBD?=
 =?utf-8?B?NkFWZUoyeHc3c1Q2bXZBNTJQRlVDOGh3N2hsSFA5YXprbTNZcnFRVDlLWkc1?=
 =?utf-8?B?NlMzNVJVUWhZZjFxbDFEd0wwRWt6aFkxbTc0d3hXbVhaY2krQWR2WVdvc1NE?=
 =?utf-8?B?b1VEQVBKNDJaVkRzSFc3WkFtdmVVaDRZN2ZGdkhnZjJiSjBuV1VlUDY4aXhx?=
 =?utf-8?Q?UTkZ57GqhLeDGXgAysbguHFPcFyl8AFP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXI1cFVLTVpqQmRtbmVLYmdxbFZJRHFOd2lidCs3Mm5BelRvT3c0bndMczNB?=
 =?utf-8?B?L3dDNjlwakZYUGdzUmFQeVluTUw2clFyOXdOTUlsQ3VWSTZVNFEyeFZDcnYw?=
 =?utf-8?B?YVNva2RQVE5PaTJ5LzE1QXVUcEhFMWVNdU5WYVV5Y253T2VmMVA3ZzJPUDRx?=
 =?utf-8?B?Q1RpbVVqR2ZvbFRRZ1RzcWdPMTFCdlFuSkJ5TDlvamFiZnNjNTRwSHo4SndK?=
 =?utf-8?B?N1gxS2owTHM0anhGVngwQStTcUxwTWoxUUI5V3dIMDVPdE03c0Ftc2QzdnE5?=
 =?utf-8?B?MUtWaXlSVFFySTdwdXhaemlGdGdzbVUxTzREWmd3WGlzaE5oVlZDODVPaFg3?=
 =?utf-8?B?SHhiUmF2aktJR2FreGJHNzI3ZmJOOXJYSnF0Q2N3QnRxK2I5djNuR3o3eW9F?=
 =?utf-8?B?NkJYNXhHUC9TV3RIbFRwU1p4WHUzKy9FS3pVek9jTDZmb2Y5OE5wNmp1TlhQ?=
 =?utf-8?B?djdBQmdaOVpLbDVObW5MOGpBZnlrZWE5UWRkWVFCZlcxbWJva3RxUFJSNGQw?=
 =?utf-8?B?aENaUWZhMEhpQlpZRU5IWTZseHFpZGdTYTMycGo1WEQvVDFDaXh1b0ZibVFT?=
 =?utf-8?B?ZnBoeUhIMEg2czE1ZkFtZ1BlZjZHQU9JeUVQTnZmNm5mblpKR1RFQW9rcm9G?=
 =?utf-8?B?RnhOdlpFTzBJVmZkd1VUL2RMc2dZR3k5ZTZSN3gydHhLbXdxSXRIL0JqL1lz?=
 =?utf-8?B?YVRLSXZnWlhGa3RZZTlvaXhZNE10aTRCOVpBQTIvdzQvZnVET0w0S3hSbzJQ?=
 =?utf-8?B?T2ttZTNuSThTYkxhbGIwRnl1Q25JUThYOU9EcEQ1cm1odmc2N0pmLzVUbVRu?=
 =?utf-8?B?Q3ZMbTVGY1ZiZHhSWCtWSnI4dVdIMUl4MjZPcDlXanJyUUtpaXdZcTVIaWsv?=
 =?utf-8?B?Y0dUcHcrQjZvRHFESXJiOElOK2Z4QVRqNzlkVVJFTHpCVURWcUJNV3dXQjZy?=
 =?utf-8?B?cWFIcVVZa0lxV2lZbjVoajkwV2hzZmdJcFFZTTU5S09lejM2T2QvMzV2cWhB?=
 =?utf-8?B?VlNuOFlCT2lYa05rKzhVVitJbHF3dGo2KzdweU8yRW1yMEZ4Ujk2NWw4MUxQ?=
 =?utf-8?B?bmlrSGRQem9jdjZQZ2oxdTdReVo5QmdkdXM2SmI5czU3SEZkc2swUWlkZGFa?=
 =?utf-8?B?WElDeE5FQzJOUnhDa1dSaTVtOUlBdU9oWW9PYTVOUk9DK01haGVLc0xNd1h5?=
 =?utf-8?B?ZXJ5aWVadEFkV0VBWEY4aEM2NkNWOXNNMk1xZ0sxTTkvaGFPejR3bDRpZFRE?=
 =?utf-8?B?NlFKM0MwdHcydmlFL1ZIYlcrYW5wWmdDRGQ2SXduR3JpcWZJUU1SWmNWbUEz?=
 =?utf-8?B?K3JNREUzY2p6SGszOVkvRlU4WVVqeUdkclRpTUV3Nm1VaUVoN2RhNWcwVG1h?=
 =?utf-8?B?MHVnY2dsNDNoeTZERG9veU82N3JacDlDWE1OZThacThHQVZIWC9yTUFHOTVF?=
 =?utf-8?B?TmI0Znc0c0xzc2gwbkEzU1RDTU5OWXZOWExjZHF1Qmo4WmplR2dXeWZUa2tM?=
 =?utf-8?B?VDNpck9HenFxZ1l6Zk43SFRkTnc3a1E1YWE1TWVYL0Ixa1Rna09qaHBTMUFv?=
 =?utf-8?B?Sm5TczNrem1oeXlkTDdvV0QzVVpTaWtZc3BHN3pacW41T1Y0U2t0bGJJbEx4?=
 =?utf-8?B?TkI4NytlR2dKbmhGMktETjcwaVV2ZEZ4M0J6YjhyN2xCRlovNjIwSjF6S0hY?=
 =?utf-8?B?TDR0NjNwdDBEOVJjTE9aRmx2NXNaa2Zzb2lRV2srTlNvQU44elJ4S1dVYkg5?=
 =?utf-8?B?UWtHZ0pDbEdVL3NmSUY2d0xYTk5iaE5TQWd0c0wyYzRKKzJGSnUyQW5HM0s1?=
 =?utf-8?B?L3c1MHlWb0t5NzE4SG4wM2pTUzZ6aWxpWXJQRDhPc25MSDJuVzBab0JkUzlL?=
 =?utf-8?B?UlFaQkoxQk1uUmNicXpSZzJVRlkxRGpscVBlbmFGMDhkVVFtT0xTMjYxS3h0?=
 =?utf-8?B?cXZJanlrUWZzNzBHWjVSRDVZYlk4VlBzR1VtYW10ZWQzRjZtUmJWVnZBazlP?=
 =?utf-8?B?dXExZkRabC8zUTdLYUVaSHNleW9mcHV3T2NGYlRnTDNMak5tTlVwZllOYUJj?=
 =?utf-8?B?L05GcXEzMWdvYkZlVEYvZHRmYlNlV0hTdmo5c24xTTZmcTEva3lGMktCMmx2?=
 =?utf-8?Q?GnC5mC3zrtmN9CRWeiDR2VTLh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b08a5f0-b3ab-4acc-dfce-08de10c2c959
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 16:56:32.2490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zArwNjirOciO0eme4YIyrrByAyT06FwRoqTpfINiW3KQR2jUwUuVtf0DWd9irBxQrGqSdlmP+Bh8jtmfekKGmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8269

On 10/21/25 1:27 AM, Jan Kara wrote:
> On Mon 20-10-25 10:55:06, John Hubbard wrote:
>> On 10/20/25 8:58 AM, Jan Kara wrote:
>>> On Mon 20-10-25 15:59:07, Matthew Wilcox wrote:
>>>> On Mon, Oct 20, 2025 at 03:59:33PM +0200, Jan Kara wrote:
>>>>> The idea was to bounce buffer the page we are writing back in case we spot
>>>>> a long-term pin we cannot just wait for - hence bouncing should be rare.
>>>>> But in this more general setting it is challenging to not bounce buffer for
>>>>> every IO (in which case you'd be basically at performance of RWF_DONTCACHE
>>>>> IO or perhaps worse so why bother?). Essentially if you hand out the real
>>>>> page underlying the buffer for the IO, all other attemps to do IO to that
>>>>> page have to block - bouncing is no longer an option because even with
>>>>> bouncing the second IO we could still corrupt data of the first IO once we
>>>>> copy to the final buffer. And if we'd block waiting for the first IO to
>>>>> complete, userspace could construct deadlock cycles - like racing IO to
>>>>> pages A, B with IO to pages B, A. So far I'm not sure about a sane way out
>>>>> of this...
>>>>
>>>> There isn't one.  We might have DMA-mapped this page earlier, and so a
>>>> device could write to it at any time.  Even if we remove PTE write
>>>> permissions ...
>>>
>>> True but writes through DMA to the page are guarded by holding a page pin
>>> these days so we could in theory block getting another page pin or mapping
>>
>> Do you mean, "setting up to do DMA is guarded by holding a FOLL_LONGTERM
>> page pin"? Or something else (that's new to me)?
> 
> I meant to say that users that end up setting up DMA to a page also hold a
> page pin (either longterm for RDMA and similar users or shortterm for
> direct IO). Do you disagree?
> 
> 								Honza

Completely agree. I see what you have in mind now. I was hung up on
the "page pins won't prevent DMA from happening, once it is set up"
point, but your idea is to detect that that is already set up, and
make decisions from there...that part I get now.


thanks,
-- 
John Hubbard


