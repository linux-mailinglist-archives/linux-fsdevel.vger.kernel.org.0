Return-Path: <linux-fsdevel+bounces-60698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20996B50230
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 18:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33DD61C61871
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 16:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3BC341AA1;
	Tue,  9 Sep 2025 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z9JeiKXg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AUbVJUrI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2020F2581;
	Tue,  9 Sep 2025 16:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757434330; cv=fail; b=Ui5zeDDTe9/F46d9lFVh8FYW3XWEPjN/HsbnnygdRHwF/rv/up42PXvzYqo/u9elKH71v8GiiUjZrkHzdt5GvbN3WuhLjx0JgSzB3gdQiNG4aXNt0AzWq5AqLMVbxCEgoYju4BmjDakL9rny4K37K/SOs0f7TFEBseznYcfTi80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757434330; c=relaxed/simple;
	bh=4Q5dJM5N24uQGGSk+P2FxrjhC4WV6d6cpwBNz7Hdc+0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m+Cv2CJ7AjJHoQyhEeQmT8iAi86MEDAKQmeUCDXy/RSG0cdLb3wTewznvDWuoN6SdlaO1Kdwi3tYpKpjoJddp+EKz/Ad9xRBuuI4BUITsYkKaChwwi5jOUdh0UJrs9H8drt5ZY/1ERgmquZ18TPqjjYbtJFyRBQuplyJ1XNnWYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z9JeiKXg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AUbVJUrI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589FtfQn020237;
	Tue, 9 Sep 2025 16:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nyvKV9TAXm8fvQGK9oS/MJXS6EsxUXWwTNxTqOAaGF8=; b=
	Z9JeiKXgw0PnQJLSbJqckQFLG5IG6UwlAFFc4ECFkoHVjHN1E2jI0CG2pVk8H9Hl
	5vJdrQzHUI9ug6dcuskmBhminqzTx5F3GVmRoQoIofta9HJCGtxbdoUscnqmP9KD
	wAvN0zDWWunQ7Q9EbzwDQq1BsnKf5/1RhrwyV1Guc/Md0hBshfF9U/+BSPL4vGtr
	BA/1z0nD0vLvMlW8eA+OZmgtEBQGAgnUYVcjOBXJjYu5xHvRrMNlg7YerK1WjGjW
	u7Xldi/XgKiSJo0xaq5HWIjG2nGgSU7FkeqQmjBdtjNnrvjqGIyVbuTxBDm8rnRg
	i0qgVhELpcREQnaX8My3OQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922sht6xu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 16:12:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589FG37O030720;
	Tue, 9 Sep 2025 16:12:02 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013021.outbound.protection.outlook.com [40.93.196.21])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd9tfqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 16:12:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gzs8adtCGM0urdjFlqaqCAu/xTVaApHCqdbV+Piab882qIZ1vwDe8q4+QR3cRxm/9ROAjLIcSzr6GbUK0nNcmEeWbO7FlzMw8DnKjXyW1IBxYHBcIzwRmAXrwd9v6yehEvhw5zJpMlim3DVtZSOFK7sZlDEbRy6K74vWpFr+1ypr9jv2f6VXuoMeEISnCihVAxBEz6U1pti9y/ycNNHqumseBLeuLJuXO9A/AkS/1LPV++JOi7AfSkF2H+fe8lkSl2rtdCOMCpqeNxr/k0rHRpCcftjv8XD7WFO9FuLH0BJFOQSvjsqy3azUFueXhgMCUpZa0ZWa3C6CEBfApIA5Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyvKV9TAXm8fvQGK9oS/MJXS6EsxUXWwTNxTqOAaGF8=;
 b=tJK9euQdtze0Tr5FD+pneEAaFUe5cCHTWGqvNamt7eSYONwmkKDueUgP3qpISMlVIxUU1SbSJMfDfl0YFHm7LJxo0YAEGnqjvhVvZxaQweMY3LBUQAL75L7iRWz0+55NSSsvHWQvRjyMN52ycyFm1zDTemrNIf+U3bAKl9st25touAbyZpnfeBC6zZQdR2Olrlmm0HK2GrshlYpU7/yQoW2VnnMY4axqgJ9s9kXjG5OEh4vVYUYFQWhnmU7S5Zieoe6SJZDa7ZOIIXWk5Hebh83lEnr+90QiMzvAVC2kNq5kCgTvywnA1ChaA/RY1M2lHrPC363WJY6oYr0Q26eR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyvKV9TAXm8fvQGK9oS/MJXS6EsxUXWwTNxTqOAaGF8=;
 b=AUbVJUrIWo//NmPNJYVnJt1cZR0xN+58CsQmiR8o2U+71kCvZq7/8ilEl7FMuih05tmMqbXbO5sIVqI5+Emx9T9L+ggQXGJMDmJxSAtogZMuEOL9miYGknaRfsGfK2bt12O1saGFxoxbb23bN4PFS+ljt9RoFma4Qwyj6michPI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4751.namprd10.prod.outlook.com (2603:10b6:a03:2db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 16:12:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 16:12:00 +0000
Message-ID: <e1ca19a0-ab61-453f-9aea-ede6537ce9da@oracle.com>
Date: Tue, 9 Sep 2025 12:11:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: NFSv4.x export options to mark export as case-insensitive,
 case-preserving? Re: LInux NFSv4.1 client and server- case insensitive
 filesystems supported?
To: Cedric Blancher <cedric.blancher@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CALXu0Ufzm66Ors3aBBrua0-8bvwqo-=RCmiK1yof9mMUxyEmCQ@mail.gmail.com>
 <CALXu0Ufgv7RK7gDOK53MJsD+7x4f0+BYYwo2xNXidigxLDeuMg@mail.gmail.com>
 <44250631-2b70-4ce8-b513-a632e70704ed@oracle.com>
 <aEZ3zza0AsDgjUKq@infradead.org>
 <e5e385fd-d58a-41c7-93d9-95ff727425dd@oracle.com>
 <aEfD3Gd0E8ykYNlL@infradead.org>
 <CALXu0UfgvZdrotUnyeS6F6qYSOspLg_xwVab8BBO6N3c9SFGfA@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CALXu0UfgvZdrotUnyeS6F6qYSOspLg_xwVab8BBO6N3c9SFGfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4751:EE_
X-MS-Office365-Filtering-Correlation-Id: 828aa887-6717-4ba0-bf55-08ddefbb9b39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Uzl2bGZBRkRseXJqSlBzampRcVZ0eldPQnVKZ0JqRCtxaHAvakxxbDBaZGYy?=
 =?utf-8?B?WXdqRlpEKzFDZVR3V1YxYWxqdzAvVUkyTXhra0tXYVY5RExuNGdOSDRIdk1p?=
 =?utf-8?B?M2J6SWdoN1k1OTRqUWpkYU1uc042V3NVbG0vcFdCVGF0ZjF4M0ZSRlRWUEg5?=
 =?utf-8?B?TmxMUU9hUkhoM1piclAvOFJtUnJYWml5TlJsaEF4bVRkWngzS2VQd1hwV08w?=
 =?utf-8?B?eHp6WWlBbkcwR0x6N3pBMjA2WHZ4Vko5Q0JLWjI1OW5WbTdqaWN4Unh1M0NO?=
 =?utf-8?B?aU44MUZ6TlBVSENwQWxBSTZTWUpMZHFTVWRxanJxeXFxb01vQXNyM2svL1Rp?=
 =?utf-8?B?QUpMbjR6K1RNT0VhUWxUUm9mSFZmckV5Wkhja0RCbUorZ1NLeDVJMGhyRGFW?=
 =?utf-8?B?K2l4d3V5TkxBVFlTNHoyNmxQckllSGIya3VEMER1V3VuL09EMzFnZHdqaUxz?=
 =?utf-8?B?TE5JbWlqc0lvcGJMMUJra2ZMcEs5dHNWRDBLSmJESlJ2bEpNRkE0bVJ2aDc2?=
 =?utf-8?B?R0R0cWtrNGpSMUZONTQ1eVRNR0kzajE3cGo5ZHJHZ3FveW4zNWlYR1F0NENU?=
 =?utf-8?B?U2trWFdRR202MzQzRlVxUlJwcnlaSHF1SDE3bUVjNklncElXWGhCcE01bU1w?=
 =?utf-8?B?VldVdi9vbUFlcTRLaXFYZ1lCNjdIYTVrc2MrM3ZUWWpZMTFWSFFKUG9yVzg5?=
 =?utf-8?B?bUZyNDNkbWViOHp0d2syc1hwYnhUY0xLWFRRdVBuSFEzdkZBSlcwb0kwd3Vv?=
 =?utf-8?B?UEUrTTM2emlRM2NGUHV1M21TNEZiVThSOU1ZakRSa3kydVZwK0ZSSVVQWnhq?=
 =?utf-8?B?WXIyeTNjdUxrM2lrM09QT2p6bGZsQjVjbHdZMVNkNzIvWWJLU0F2eWFFR3Vo?=
 =?utf-8?B?bGRVcHFsYjhMRGhZdm1EWm85RUZ1dzFGaEUrQS9mcmJ2OHA0OXYzQWFUNWZZ?=
 =?utf-8?B?NzduTXZsR1ZkM1ZGMWs1UkhaVTUzZlh2ZVBYSHpLSGdNQnBXZFl3WlFkc0RL?=
 =?utf-8?B?Tm5FZWNPS05YbEU0MmwxUUxZajhoSzFZRW55NTZwa0VGV0J5Z2VnRnV5eGcx?=
 =?utf-8?B?SEJqdUJHU0pYUWxKUExPRWZrTWZsaFQxa1hraVFjTTliMDZtQXFFZk54WXd0?=
 =?utf-8?B?ZERWNWRPaG1wMkRDUEk3TEN5UUJ0QTJJQnJmNk1YcEd4NElhT04vaUovQzBq?=
 =?utf-8?B?c1lVcXZwczIyb2hiOGw1RERPTDh2ejJVcldHYUhxeWd3ejQyeEhHTktBczE5?=
 =?utf-8?B?cVNSams0SUpWc2RvTHFkcE5IV3pzUlhlZG8rNFJsQ2EyN1RXelRCLzVTanhX?=
 =?utf-8?B?cGhvUzlZbjRNMHRFMisxeXc5R0hIWUNWRW9ISGF4TkNacWE0djVtL283dkhj?=
 =?utf-8?B?cTlsQ2N3UW9NM3BtMWZDaTZuMVBtSWpvdHBpT0JVb2dLVlVQcWJJNDNrbHNt?=
 =?utf-8?B?c0pObE9YcEVJZjRkQjF5cnIvZVlTRGxCT1VsbTN1ZTRVdHk4eGY2SDNhUmlV?=
 =?utf-8?B?OXh1VENOVHd6VzFQejZhaHpDV2ZscVF2TlNrVGRLMDVUaDdKaElZVEZxVFVu?=
 =?utf-8?B?R0RRNWZSeHRWaU16UW1KbzlZWlJEL2VMOFZuNWYyWXc1RSt1OWlQakhTbEI4?=
 =?utf-8?B?MlQxRll6eVAyV3BvdUwxUVYzR0lDVGd5SllRTlVLMkdkYTlFRm5iT2J6VHdB?=
 =?utf-8?B?QWVOTjNJK0tNZHQrS3FRaUZYdGIycUFHN0U3cEs1WEtyK3dBTFRVNTNZMDlv?=
 =?utf-8?B?QVFHVkN4QXcxM1V1dWZFSEp2S2lidWljbjhJOTBkVFhIdlRyaXBLVlk3TmxJ?=
 =?utf-8?B?SFE3RlJkTWZjOXk1WXhTVUw4YjkrbGRoQXQxcTVoUWJYM3p4dDhmaUFubTA1?=
 =?utf-8?B?Tzl0WUFFQVRmdzVVT0hwM3Y4SnV2VFdZdzhyUzRNdEFJdllpdk40M3BPRVpr?=
 =?utf-8?Q?NIS96jSkxQY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVJwUUxHbFd4aXNwSWlXbFBlU0p6b0N1WEsxeWs5NXl6M2t3cXZHdURBWUJx?=
 =?utf-8?B?N2hVeHdZcWxzeklPUzUwb2hNT21aNDErVmtLdW1PQm82ZnIrbUVnMmxuYXQr?=
 =?utf-8?B?SDBUbVR2dUxhWEpNSDhaUTFWazhYYnUzRlZNRjlEbXZmcjZpV1hQZmYrVkFp?=
 =?utf-8?B?VVoyMTJHTE5mWkdTTVFFKzhqQ0VJMkF3NVU3eDhhTjFEL3Znc2ZEZTZEYUto?=
 =?utf-8?B?eUtnRm9wOWF4WHp0bHNnZGp6ZmU4bWpubUMvZFlDcXFsTzhiTDVnWGJmcnRO?=
 =?utf-8?B?NkFEZXBDYmx1Z0Vqbm14Q1d6eVZZN0h5aWNxdWxwTklvWVFXVndEeEQwMndG?=
 =?utf-8?B?MXFHTUdsT2FBbnlRNTBldFE3djkzaFNMOXR4cHZVbThNZUhOZ1JydjY0empx?=
 =?utf-8?B?TjlpYzkwaDhidDBoTVp0MHB5YUhTTWtrKy83c1FMby9LRDlOekwxN2U1dkFi?=
 =?utf-8?B?VW5ndmU5RFNBM284RS9DYVR2SmtBdnpYTjYrT3lkYjFiZUorNkpDT2lubGNa?=
 =?utf-8?B?ZGFuMFhrRjJ4RjFmeDZESmNzYWZ4eStvaS9UQkcwaEZUekdSTHNzaURTaXR5?=
 =?utf-8?B?bitwQTJ2WHhtKy9Yb2VxZitnRDlUSkhkdm50RlJmMjl5Z3ZaSkJkUmFZaGcr?=
 =?utf-8?B?SHVYWDlzNklsTEZnOTZaRTQvZjJOVUZlTCtHSlZxcnAwMFJwV2ozRHpBQ25T?=
 =?utf-8?B?QlczT0QzUlJrbmlyMTJvaXVsb0x2OG1WVFhFaE5GaU4rVC9jeVYvaGowbTB0?=
 =?utf-8?B?cUZNYnhjbXdSUVd1S0tqR2JWRXhvNytMTE1Vc25zYTh4NWxUNUpyM1FlNmlR?=
 =?utf-8?B?SXRoaWVaODdLdmx2dzdrYmF1R21Rc2tEMUhFQkNJUjRVM1pSYU9lMFlUZ0c0?=
 =?utf-8?B?K1BuMzlWU3Z6RUpvb0FqTkViM2RlWWwwTXNCdktXZ0cxUUUycWwrK0U1VUdG?=
 =?utf-8?B?Ykg4Vkw3SG9kdGVKcGgvSlBHS1B2U1ZtL1JzZE0yRDNXZjBPOG43Y0d6WDRk?=
 =?utf-8?B?UkNiSGVzZ21veGFmR3VLaXZQV0xuSHE2aFhwTko1c1pLbUo2aXhNaEtINnlv?=
 =?utf-8?B?SXE5VUJxS1dLbUxVTFlvbThFeG1YZnB6YXd6SzMyYkV0aWxRVkt1cFloSWxP?=
 =?utf-8?B?YTF0U0xxZ2VVTUJHMjg0bjZqb3p0ZjEvZkFEcDdEeXQ0VWtPeGxHV3ZMcGJz?=
 =?utf-8?B?TXMxa3BncGQ4aUdCTU1tOG1GbHAwTHlSSHcwYkdEN1N4cC9TcmVzbjd5emlZ?=
 =?utf-8?B?V1pENHEvVHlnMURkR1NWSEZIb1B0VjZUMmNFYlpLaGJuY1ByS09BS1ZpMks3?=
 =?utf-8?B?YTNBdGFFdW5EQmFVbkRSd09vU1l5VUZwaVVTSytaeTBSTE02c01Kc2xid3A0?=
 =?utf-8?B?MkNwNnhhbytQUVN0WmU3c1ZXeDZNUWxhWUJTY0JRNG40WTIwUlZiQ1lPbnZi?=
 =?utf-8?B?OUFBVmdtc2t4ZWczc0tVNm1WNktSeGdoVm8zL3U3dzRxK1BsSFZ2eng0MUJn?=
 =?utf-8?B?WUJqUUtOMi80OCtLRW10ZWl0MVlrQlhTUmxVRkx0QXkrb1BZa1hPRXNHNG5L?=
 =?utf-8?B?WjNQQWNoK2pqWXllTno2RTRoT1hXaGtONUNndDFnK2ZWVkpwMzNRMnY4SWIw?=
 =?utf-8?B?YW5iUElkUjlWZGppOGwxdkN5UDBmekVkY05rekZkWUQxVXNPZXhscGJnUlNu?=
 =?utf-8?B?TVpGdVYwZVN6MXhVSUFua2VQekU3MUJKZGl3ZHg5TytlQXNxZVk3cTgreDV1?=
 =?utf-8?B?UU00MFpRYmlmbG41QnRPM2FDN05QQ0JQNzFIM1p2eWYzQ0pBcHRTMXIrZ1Nj?=
 =?utf-8?B?emdrRGJkRTVJaFdld29kM1hzRFBLZVIwcDBVTDljRlE4ZjM1SWNsdzhGeTZM?=
 =?utf-8?B?M1pJaitqM2pEZ3hBeUhLTS9zczlhRDBtdnpmYTNoeUhFOURiN1RVdGl6RWRB?=
 =?utf-8?B?ajRwQ2NEY1dBcjRYS2YzQ2VUVXJiTXpSVlpyc1pIOVFWdGVWR25qV1JPRU1z?=
 =?utf-8?B?WWthZjcwb0NSeTBMRDFUUGVDOC8zcjFYODhsWXJXTlhzQTI4Z1JleUgrRFly?=
 =?utf-8?B?WnN2T3RlQXU1S0oxb2x2REtIK2d2WEdtMFNhOTFGMHgyRTRwRENKUE1XcEwz?=
 =?utf-8?Q?DdJEAzpSumHmH6/La/ogJczMx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xgPyUdQbqrhlQt3FrL/MQ4iyeHIoa1kNQQTRSRQvD/I9RpLb1qRSvBCNfayNIDgVcoMEzDOVGOAf7HbwiqW1+/1CzFxxv7RFP3cl+kBl6J4ludulFLIHi5uONEGBNB3h856LzXmwdkdOeonzj/IyWX6pKiRCaFiTY6IHTbRy4SHRmvd6U2Rx5RQeVCWJ/thlyAK3XuNdDvegpxdt8cTMENA9zH+GNSI1Qc3g9jKLHaUMDAiLEchqunEYvgIu5BdaO+8IRfFbSF0sXNHvF5uHhzHaPF/Xd1DzF0B17vLmzYmvE2CX8W7hVMsF6FdpPP/gCD/VXR0/RsLd5TczLjU0VGrZmnYjAFQXdIvEq9Ab0P1Rt/wbZPSlkVrv6onY+6mbfrgsqby+I0xZtLA/r5mcn9I1dr1V3MZ1knYmlLcfDnPJ9ErzeOehytLqaOy8x6HE9hz4cdGJgmkovl8J48tVhXM7HljJIiRYoT0NiaZvw1TU+gh+nHFREn/8Zl7w5XCVtsZQ0SE9LId8M6vRQ4EAunys7Tg/A7wxbg7h6NjeWpDwpp29au9lkhkUcHUM9qi/+D7+o1nlOuiFczJAV/Nj26wWnoS0Y5SsnooR7kcXPQw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 828aa887-6717-4ba0-bf55-08ddefbb9b39
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 16:11:59.9733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tY5kuqkybUAhW7W3Ki0/k5NWWSguYqo63mPQF0lXjTj1JQCtaf6451G0MvOGif1OArD+WTojEk63u5X1a0vw6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4751
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509090159
X-Authority-Analysis: v=2.4 cv=esTfzppX c=1 sm=1 tr=0 ts=68c051d3 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=Ka5gTQsAIYSuWrxvyOEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NSBTYWx0ZWRfXxjHfsaGQ1ODe
 7C3nMLNCaHXF8xuP6uKPR1XeZDPFj+LET0vtuOkazPpim3nA4vBmUD2+icHTEsa83/ez9vRDJMr
 OdK8hWjpqv2fEHcP4XvlD96kOZzgD8luGO+5LyJU4sJ8jq22EzD/Tz1FF5AZtF791jeb7rDa8dR
 ZLlzGgwkvrSh/70Q5/+vrIMzMnxLZP+D1lRtQ2J4HK4wZRpBEBqRdECelsZCUPCG282mQ/LU7tP
 S8Zf/YiNKhcX4CN8xzyH5zs030sXWn4FsqdkDysnX604AV37M07/OV1LcWB0YJyliztO/jFpjaC
 d1WfOkV9ebrL4Ggh6Rng0lVL+jLeYanbv5haLzoIUnbQsh52TjoVf+B95p9HUpOR0hWPftfanR5
 DddVFtKj
X-Proofpoint-GUID: rXzjXV0PkH4Y724i9E9Rcj_z4_2O4RYT
X-Proofpoint-ORIG-GUID: rXzjXV0PkH4Y724i9E9Rcj_z4_2O4RYT

On 9/9/25 12:06 PM, Cedric Blancher wrote:
> Due lack of a VFS interface and the urgend use case of needing to
> export a case-insensitive filesystem via NFSv4.x, could we please get
> two /etc/exports options, one setting the case-insensitive boolean
> (true, false, get-default-from-fs) and one for case-preserving (true,
> false, get-default-from-fs)?
> 
> So far LInux nfsd does the WRONG thing here, and exports even
> case-insensitive filesystems as case-sensitive. The Windows NFSv4.1
> server does it correctly.

Hi Cedric,

Can you send a pointer to some documentation for the Windows NFSv4.1
implementation of this feature?


-- 
Chuck Lever

