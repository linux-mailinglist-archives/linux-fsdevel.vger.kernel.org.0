Return-Path: <linux-fsdevel+bounces-21802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5579190A7A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 09:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9C32B25452
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 07:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F07D18FC99;
	Mon, 17 Jun 2024 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FHbclSiw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wDnIOo1z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70451862B0;
	Mon, 17 Jun 2024 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718609827; cv=fail; b=Eu9b1JBltUdszHaqcLS4zW0ytIbtCvAtIM0lFdmNizy6/RckDTgRV+MZJqtnEmvTKKE7MD2SsU2+rutJVXvr/nmUGLTMOa10XrLam/Kv+pODlA2yLiOJHh24/N7sMxdrowCpmKF0jblddedp+qOtPAJDIPw/LkKNpurIjKsJntw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718609827; c=relaxed/simple;
	bh=5mRryf12iiIiLDuqbXCILiiwKqWCdpvv6pEGGZuiP/A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KJdCNkNrZorHqP1mQWUMNdl2E7MFCAOSo7AsUjp3XI0+L1z0ruKSJBUJ8oWk0ryGLqJhEhzxKe8z+7cFp5U4hxg1Z/AIyFL/aEQef8PDej4lEhpow+G16Jj7Pqy9MpK0vnDCvaKmiN6aUYxisB10EoDVAW5Cq1lBisrO5aJA9RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FHbclSiw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wDnIOo1z; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45GNPU4D012379;
	Mon, 17 Jun 2024 07:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=5ufuqHjJRvkLvVdzJciSrtInq2QuD4XTrJt8IO4e7M8=; b=
	FHbclSiw2uMQzIJZm74S7Hm4mPGakNVUmVayN+UEUHlfpq9MoLm43gz2VJ1yqk9f
	oE9foY0vciqsrEK6/rBqrI03sZ6tumgCnC+jAob36hUT2eyjcHbLIJan4uZ+03a7
	jlj/uiB093/jYN8/5P4HSamwsfkXmRbtY4zwK1EWqFMYuLEXssdHf1HSlQjK4KJN
	HgUrw+HYH314yBv5OECJH0u57z5ZnIlwmqFZIrAuR8aa0a2IFhzEtxBHP6fCulfC
	HwrFWWOXS2SyJis+b0cLnJ9aplin5VnKf/p85Sb/Sz0dJd2uRuBQ8roIEIQS5rWJ
	S98xTOEv+f0CBmLK64WEaA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys30bj19h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 07:36:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45H7Bax0015483;
	Mon, 17 Jun 2024 07:36:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1dccpn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 07:36:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GALOE8lukNmvGb/MRkoyj/C/XmPISQKu1YMmWPGQ3sSmYi92EbZiFgM3EO3n2EsFpjAcGic4EFMGpqPX5sU4MLsw6PbC2eVuto76ZtJPcd1E/a9fFQaaxso3NQMnpVqO5p2WS1OiGl5EC6GUqw54vxF0GoMtJ+2+IF5uDYLjoADYBSxbdmASAA7XHVNtq50TpQKAgAVpkjVptWjpMqWLLuIT3qO6EFZykkxxmjZz+F5dXWKjF140R56knOzScvLhYdgMRN2Ai3/ZU+pZovgqEXYUUChO0BWJ3G11lFS9rOpMw6TyA8PIQp8yFb8fyFajk4C15ziC8JwY7i+a2kZsPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ufuqHjJRvkLvVdzJciSrtInq2QuD4XTrJt8IO4e7M8=;
 b=LuTGsmz4QD0WDA0UIvmwb0cPnQGjDvwDAu3mkkfMeD9e1ZI36myW1jexmzCGbjrzniC01YxXZQfAqi/9Wmk9fP3dpLZBEjIg3xVs+4LTMikCAnEWvk818//bvbOZKdG35tfdX1MeUMrhj+qtZdezPR6p+jluDupBq6izuF42n2KRC8V0SWBl1DJtmAxXcGyIhzGzybNURdNCT1nwT8/YjEypj7HF/V3DfaIClwsthZP1HDzGuoWcE9Ua/EE4rEZI5OThEQGykkIUl0MFLTuB8y1rDVgG0NYiEhKYblHtc6MvNV5TmEaRFRN+c5GGE3wvOJeNpYuvvqTwLU93lVFZIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ufuqHjJRvkLvVdzJciSrtInq2QuD4XTrJt8IO4e7M8=;
 b=wDnIOo1z4mI4C6TrvVbOT09SktujQepRY9piaXfkQOqGLwLh4vQZdgzu037pLuEtUAkwbl9AtBpkuenWSgxGYJmSqgAXWF95QlRgacy94VOgxff1241p2+LKs3cNvkBZfcJSkwP5DjF1Cz0AOwzujmSKHI46TnhtgOOiyRfpFtM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV3PR10MB7865.namprd10.prod.outlook.com (2603:10b6:408:1b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 07:36:39 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 07:36:39 +0000
Message-ID: <019bae0e-ef9d-4678-80cf-ad9e1b42a1d8@oracle.com>
Date: Mon, 17 Jun 2024 08:36:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] statx.2: Document STATX_SUBVOL
To: Alejandro Colomar <alx@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20240311203221.2118219-1-kent.overstreet@linux.dev>
 <20240312021908.GC1182@sol.localdomain> <ZfRRaGMO2bngdFOs@debian>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZfRRaGMO2bngdFOs@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0013.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV3PR10MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: d4158940-11f7-4dcb-90bc-08dc8ea03960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UUlLeGF4ZGY5c0wzWFgwYmt2YkhiY2NkU1c4Q1hhOWR0aG5uYjdnajdsOG5U?=
 =?utf-8?B?Y1Y4dDg1TE9ZNzlSUUVDbjJGQ0lwT1kzUWZqMFY0Vjg0bVpza0JDb2trSkJ5?=
 =?utf-8?B?WEhLT1ZqK0YwZlVsN0NyK3ViSWdVNHk5dXhudkZ1ZDFWbmZhMzhGcjJSQUxQ?=
 =?utf-8?B?MWVnVFBOM05qcnE1K0g0elRxSFdUL0ZwWVRLNjU0b0czVjBIQS9NOUNJMElz?=
 =?utf-8?B?eW9SZERmZHo0U1h5aUxnV0N1MitHTmczYWZITitkWTM0cU16V3JwbkVCT3hz?=
 =?utf-8?B?MUcwOGYvbDB4QlZtNU1EUzFaUDczT3ZpTUljZVlTVGV5MVJhNVo4U2dSOXdp?=
 =?utf-8?B?eFpETmdVKzNNbFBRMlJoWFR5bkRZclROYXIxdjJVbXljNndhWnd1Y3dYUUg4?=
 =?utf-8?B?bWV6a3IzZ3k4NmJjeEM5ck5TSGJSeVJwK0djOEl1WmlCT1BXYmlvSlNzRlhu?=
 =?utf-8?B?TWpZWDl3cXdjSk9VN3FtUUVRdXlZWW45a00rWmZvTTBRUThsVTNRWVozVnVC?=
 =?utf-8?B?eTlvTlU0MjlaUDgxamw2Q1FkajVXS2tsaTZTMHpyUElIdnBNUzArM0o5TVpq?=
 =?utf-8?B?cmRBL0Zsb2ozOTZXZ1YvYTJTUUJoVU0wSllmeUlLakZReU5HcWFQcVJoUXBn?=
 =?utf-8?B?L0IxN0xlamNJWGlQUWsvRkZ5R0hPYUJSWmtRRWhSeW5lUStmeGFuT2kyTjBz?=
 =?utf-8?B?a1NKbTB1dGMxeDl3N09pcEh2UWRtZ1A3UFVSR3dhOG9xTWY1VDFqaS9Semhn?=
 =?utf-8?B?Wmp1Y2tvMURzNXZ3cWZSaHJqMitHci9rZ3VXRitQeGh6ZDlZZ2xqbS95ODZV?=
 =?utf-8?B?dXpZWFdkb0NURkgzT25yZU56OEZHQ2NrUFpoeXQ4ek9WWVF6dlgrVWl3azg5?=
 =?utf-8?B?dnZKWnl4SjhGNllsQnY2ZnVKZGFjMW53TEFQMC9QQTdNNE9Ga2VFVWxXQTcy?=
 =?utf-8?B?RTFnaW9hR0xyeDJoV1FvZUtKSUhHckZ4YlR6R2V4dUdObDdmRGtybE1KbmtV?=
 =?utf-8?B?bmlUKzdTVjJtQXkvaDJMUzBnV1hSVEhXMC91OWhXckNQN1NHbENGQndNMGlY?=
 =?utf-8?B?ckgvcnRZSDl4MUt4bjBqVlJsSm1kNjdJU1RldjVhbkRUTWNiWEtaNkNQTytL?=
 =?utf-8?B?Z2pCVkU0R0dWR0hISlJ6dFNYendYYlNqemZmbE9PZkhtTlk1SmxzamJWRVhq?=
 =?utf-8?B?T3BJWEM3L1RVUndyNFcydk1TZ1FsT3FRM3FXOWdnLzFRaVdncHRYSEpXMEx1?=
 =?utf-8?B?Wm9lbUp1WkNwTGtsKzR2MUZJcG9WcWw1N3JQZklCZk5PR3lWenh3U3EwRlZh?=
 =?utf-8?B?QTg1NElRMjlWN21rVkhxSUtrUWUreWRaMmlMTnh6NzZwdjdQekM3bEMvdUdK?=
 =?utf-8?B?c2ZYdU5XcHA1Rzk1SE1rMlFEa0s4YU0wY3RzTXBGYzZXUDZ2NU9PMklqR0pq?=
 =?utf-8?B?a0tzZWU0NXBWc3NwMFp3em1Bb3J0NHg2SXlqeStVamNYdmNRRHYvQVFoY0VO?=
 =?utf-8?B?ZEJRVjQvanBLM3R0WnVRVUxPQi9EeFc1TkJ3T0NGYmNwZUJ5VEJsdjlLS3h6?=
 =?utf-8?B?d0FNem1HWTdCNm40V3lMUzRqTEp4aUhDTXZQNENlbVlQdzJnMSthc2luTEJx?=
 =?utf-8?B?alRYZnBiK3l6U2lzR1B2Q2xCYi9UK084MThPNVkrNGdQdTR3M3pucDZVV3Ri?=
 =?utf-8?Q?x+hd1P3JqdeWUR7GRnjM?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NCtJWENkSnJ3dVhYMkJPU0dBdEtMQTJlOGZFRW5hdzJEaStGMGNMOHRHQzNU?=
 =?utf-8?B?ZTI4N1k5akw3QUVFMnJVY2Z1RFdCQVBvZFhxRmN4cDZZcW9GWkU3SkZaVk5a?=
 =?utf-8?B?aGhYajMwNy82QTZZTktRbWpWdnZ5Y2NRTWJHeXJoaW5oKzVyektDTVcwZzR1?=
 =?utf-8?B?aDVLM3ZHYjFsak5kdSs2cS9qYlFVbDFJK0lsOEkvcU1oc29KSlZubkFXRlRH?=
 =?utf-8?B?eXFUMUlnMWcxd2VWOWlkbFFDR3Y1YXJJTVJQa0xydFNReDV2Nzd1WXN1STBu?=
 =?utf-8?B?b01RZjBETUVPUDArZ01uNS9jNU8vMk8yMGJrdEdtVjF0YUVwZmNFcUxLZCsx?=
 =?utf-8?B?QUtoMUYvSnp5NFhKcitBVGdqZG5TWGU3NXVRT1FneHBTWjFXdlRiREpYQWx3?=
 =?utf-8?B?ZmFNNmZZWFN3NXN2b2h6U3JUeXlFUnVHQTdkYVdzcW5tbExGV1kxVVh0d2o4?=
 =?utf-8?B?SUlKS09XMUk4ZzRuTVdueFJzaVNjalNzZ1VVakJWUU5oQVJlZE1hZ3R0SXQ2?=
 =?utf-8?B?aWtVcm9TVWlSY0kxaXNIN2xLV3kwczhBK2hRcEdpdlErMDNhZGxYNzNFWndE?=
 =?utf-8?B?cStLVHpDQzBic2JabzVtWFg0R001aThwTFU1bS9jOFM2UjBMaE5pZzlpL2dw?=
 =?utf-8?B?dG52L0w1UDNSanZybmNweExjMjNkWGx1MDhaN1ZaNWxTTXlRc0xKaml2QS9N?=
 =?utf-8?B?VkxZNUxvTFlTcE1uWTUvK2hhazhEd0M5Q280Wjk2UHdGekhPZGVxRlB1NWcx?=
 =?utf-8?B?TXlmVUpqUk1pdjdXd2lJN1hlcVFnQkFmYXphd2ZqTmd2akR1OXN6UDNhbzF1?=
 =?utf-8?B?RE11OEZRVUNsZC92TVJnem1WcHNPU0JCWkM2SEdKbkN1K1pRQUpnQzBnOUJw?=
 =?utf-8?B?NjE0MU9CNFRxNytySlk4YUxmTnZBK3VmVVNUZjlBTkh5eDZwN2FxcUFzdFdr?=
 =?utf-8?B?Y3NFUUk3UkJOUUhmZG5xMzFubUp6TW53dVFRMUVDcTVwNUtVbUxLaHdOb3ZI?=
 =?utf-8?B?OU84YXVnNE4rRDY5bzF0R014ZVg2c1NIeVVrdk4zSFo3T0dFeDRIL2RHb0NH?=
 =?utf-8?B?dEM4aVFad0l2Y2ZzUzkzbld2cU14Qm1rcXE5QVYvOVdwYWI4a1czdGxiZHpi?=
 =?utf-8?B?bENCTk1OSWltSHh5Wk9qYjJHZzNJU3c2dDJWcC9DcGZPNUoyRk5yaEZxM0Ni?=
 =?utf-8?B?STFVcjlGd2tBZmt5UHV0d0pXUHVaL1lYMGdvZHdwNitDaVlUZlh4OFl1bXhN?=
 =?utf-8?B?V0hYSDRmSGxHZ21LK2ViN1QxT0l1TStlSWRURXlnM2JXSVVzM2VlT1FBMzYr?=
 =?utf-8?B?WGJDbjdQVXZxbzlXWlRNZHBRb0NsSUI5Tk9hODVhMUdLeitzRHFTU1BiYnA1?=
 =?utf-8?B?d054NDJIbWh4SW9qWWxFZ1lka1dpZm4rSCtjZktHdlJSQ2RsdXREZFVuWFFU?=
 =?utf-8?B?Rndlb0FsdUNxNW83YnF4MlNYQ3RrclBjKzV5TzFDelZ6dDhERURoMmJFa1Zu?=
 =?utf-8?B?c3RtWDhZWlRFb21uSmVTdmpNc1NOb0gyRzVrK1pPejJJVStGSkxkTW4wa1Fz?=
 =?utf-8?B?dW5iVm5UalpxWFFHMFJ3TjBkQmYvQ2tOTWhLMmtiNnl6ZHNEcVZvNWZmcTRz?=
 =?utf-8?B?YmU1VzljSVphbEdOcTZvcFEyUVBrOFYyS0k5eXUrekpFYzVBcVdPcUdZejhw?=
 =?utf-8?B?a0h2V2U0NmxrYXd0b0VwaFIrb09GTjA2TlpHVVZpVjhHUlVqaDg0T25IKzRp?=
 =?utf-8?B?T3kvbDI1WFR3QXVIL25Gd2dFb3d6WmE0THB0OG9mQ0Nnb2RXS05laFcxcE1P?=
 =?utf-8?B?UHV4RjVZeTVQQSs4bmVGNGFaOFFHcnFUZWtFcWRHSmRjcnlmZnZGNWd1WXNj?=
 =?utf-8?B?d2JOVE9ad2xINENBdkU4cGMrWnZDaFhQdFV0bVhLMEVSNFhZc2dBZmZ6NkZj?=
 =?utf-8?B?czZYbWpwcnA2N2tnS2FIWDZpVUEvMXgxRGZFcVJnTXF0NElveGZzQUNQRkFV?=
 =?utf-8?B?T1Awb2w3UGYvRVVLR0xMSDZoeHBvNjlYempVd2x0TEEyZXhFeUxBT1EyMFlz?=
 =?utf-8?B?eWJlZEZkcTd5WXVlWjFIekE4UTF4MURQWldrWnduejIwbzBaSjlBd2hQMFNh?=
 =?utf-8?Q?4lXcB1g4di70544JvzrLD/T3i?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aZ3SFbU4F5BeLqNWl+oX3y9BrXFRIqP0YUWAGBd1qp79cPCZG+ipskLNP2APNIfOa9WgkSRW/oATN5nu1RAJQzbl1q0PisUM1UyYaN+Jh92s+xdfZgrnvUMJNP2yCHVQACy/ickzr/ciXG1kp0Akum0NvZigK0Ly3OwzUm+oeeXmGrzuQ46MNfQHLkpPlSri9lF3lOIRTShENT7xvZPM2dQlwEJW/Ge+IpKAXLkScCesk9SMkTz1zPU9iTDkztdMDHS2rQ/bMoOsJ2iEi8uFKMeZEv/x88UGNmcWAdwoxfYE5Vm6u2s9TwjKYM+S93kZWnN5u6GEOldjjThdV/lsXcpJNmPHY5WhKudQQjGMbIOd07nn55CX/Jmr/X8xyxP1xxYWALsnUnpiu1un8CWBxBUwO1TvheQPsgBQ1E5GCEh8PVOaa8SoD14FMddFDYJdkbqI6bgaLLhk69XSH6oozQeVhp5DgffIBFuwyMdddNTxOJcVg4thv2CLw5CvIwlt/qEjhv0sBV2TSSiX9bQsBbDMYGaj0IqInsUSNOcptguAqsoG5FUmJC/N0yKsHZPnowBtxadPfPEHby6lA5mjqSmzUjikrLrjkcRlYXIC21c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4158940-11f7-4dcb-90bc-08dc8ea03960
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:36:39.4234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgdgslK/jSqd2kTRAG+sxghELhhpb4A9nsuH37PpxBb9Bln1mAa8ADBbZ92xZUiat72g8Ml8AwDVL4WlK29IxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7865
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_06,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406170057
X-Proofpoint-GUID: pKjkbvvnhY5XkyJa-p1TRZDVR-nQ-yC3
X-Proofpoint-ORIG-GUID: pKjkbvvnhY5XkyJa-p1TRZDVR-nQ-yC3

On 15/03/2024 13:47, Alejandro Colomar wrote:
> Hi!


Was there ever an updated version of this patch?

I don't see anything for this in the man pages git yet.


> 
> On Mon, Mar 11, 2024 at 07:19:08PM -0700, Eric Biggers wrote:
>> On Mon, Mar 11, 2024 at 04:31:36PM -0400, Kent Overstreet wrote:
>>> Document the new statxt.stx_subvol field.
>>>
>>> This would be clearer if we had a proper API for walking subvolumes that
>>> we could refer to, but that's still coming.
>>>
>>> Link: https://lore.kernel.org/linux-fsdevel/20240308022914.196982-1-kent.overstreet@linux.dev/
>>> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
>>> Cc: Alejandro Colomar <alx@kernel.org>
>>> Cc: linux-man@vger.kernel.org
>>> Cc: linux-fsdevel@vger.kernel.org
>>> ---
>>>   man2/statx.2 | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/man2/statx.2 b/man2/statx.2
>>> index 0dcf7e20bb1f..480e69b46a89 100644
>>> --- a/man2/statx.2
>>> +++ b/man2/statx.2
>>> @@ -68,6 +68,7 @@ struct statx {
>>>       /* Direct I/O alignment restrictions */
>>>       __u32 stx_dio_mem_align;
>>>       __u32 stx_dio_offset_align;
>>> +    __u64 stx_subvol;      /* Subvolume identifier */
>>>   };
>>>   .EE
>>>   .in
>>> @@ -255,6 +256,8 @@ STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTIME.
>>>   STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
>>>   STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_offset_align
>>>   	(since Linux 6.1; support varies by filesystem)
>>> +STATX_SUBVOL	Wants stx_subvol
>>> +	(since Linux 6.9; support varies by filesystem)
>>
>> The other ones say "Want", not "Wants".
>>
>>> +.TP
>>> +.I stx_subvolume
>>
>> It's stx_subvol, not stx_subvolume.
>>
>>> +Subvolume number of the current file.
>>> +
> 
> Also, don't use blank lines.  We use '.P' for new paragraphs.
> 
>>> +Subvolumes are fancy directories, i.e. they form a tree structure that may be walked recursively.
> 
> And please use semantic newlines (see man-pages(7)).
> 
> Have a lovely day!
> Alex
> 
>>
>> How about documenting which filesystems support it?
>>
>> - Eric
>>
> 


