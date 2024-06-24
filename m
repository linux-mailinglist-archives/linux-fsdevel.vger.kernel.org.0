Return-Path: <linux-fsdevel+bounces-22241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B657D915011
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 16:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DFA5281D77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 14:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C4E19AD6E;
	Mon, 24 Jun 2024 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B9maHx83";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k4SM1mx/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27F119AD4B;
	Mon, 24 Jun 2024 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719239837; cv=fail; b=cMGSOtxBafpinRxHSJc7RY6pQ4ZLVv/pUBS3CFEu6m5dNQnN03I6py0wxlhfA8FosnFn3/79UGMT/9PbsYDsjVQBdtj8qOIDTvZmqmpqRTSoy9uDNnBq8B5atlwCdATT5Z2WFSGf5S3FI0bQBeFifIYJwiLTMzp/k9aQBNNJh5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719239837; c=relaxed/simple;
	bh=ft7o9tG7hgmNEGRHYSQiVZZtWvuPu8nce0KyCnzv5ow=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lQGMZ26bAMtVlioaLXpqCJe43Oc6QivSR8S653pUTQhWd309inzebyU2Hgx5zknIdZi5NvCEsUO14b8fdHV+sRWrMONg1GsrVUqNZ6D44bfO/FM7RgZ1t7p3CFrP42JqhQKoyl2zm5GwqFuZRfMTiSjyaHQ56P6pK76CoalGkK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B9maHx83; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k4SM1mx/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45O7fUYw029450;
	Mon, 24 Jun 2024 14:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=AtgdmIabDD7hi/sgpAsoUy5Pth5ljcPfkZurJbUvZxM=; b=
	B9maHx831HSvkxqrRh6gbT86h+QQT5JdZIXfTIhg2fmbI26Hgy8g2jJKSulE8gqi
	K8RnxFvPBB9gyXs+AykQAQOun7j8mjLlnSD8k8jLp5m/ZAmkkWRIn+hTKbvQOz1p
	MTBb2xXEBeXHsmKskDnKT+b2yAyOPZK6Qm/92J6O6uX/ehLeHqqtlMWatSTMimhq
	XRibdzTb5RAR54lGs0A9czQCqfqhvvNnMszD+ZI7kRuQBkTSzrGws8u6YPNySEHQ
	/3B8Pw3f3KRaV5V9oljLBZQgGMjaol1voUEkhhXnaRwUqcLJuglX4iC9fPxRp4ES
	wTxSVkYhz12Vc2selvO4lA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnhatuum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 14:36:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45ODLOpK023314;
	Mon, 24 Jun 2024 14:36:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2chv9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 14:36:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJDFeb3e09FI7gdx9ZLGCSiXQnl33bK2E2rPveuwPvDwVfHW7hNV+fZJCLC8M2Si3i5l6Bb3DNfEsI04zTcyQz/3uIrin3TZNpQ3dcchVz3SaJqcSnqjuWNt8nQMUk162eTSzWEexgeQdkdvETjSNxhSoIz+isbtfNtHnqVXIkH+qsEIbhBLS0FX692iwb+9nBTBPl4B55ZLxSWmdk2nTQWsSSIJ1PVEVqpr6K9IqO4lWcTE/1/MVl0GoNqnV8jZVPpYFNx0Cob03nLhToOyYkQoq58CaMUg3o7aYIjJsXbZXhzE7JxoVlneIYe82VrJWuaduMtuz0KedbIU0J5C7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtgdmIabDD7hi/sgpAsoUy5Pth5ljcPfkZurJbUvZxM=;
 b=EDIN1/IhIHLFVF6Oc2kNZcOPcXv47jnLXT1yDRgzAXo3RS5Yr4pljEPna2d+h2145qwV0D5rsKETTesyHKXUaJtNQJ+Ja60aNKnc3WXx/40N7uhSX//8CJJT/SsK1uXZppoo3U2bWO1qnEqp4DOm1kFvaWE69R8Cw7c7Rjh/CKC5/4PT6ohjJvnWIMD5UXePOWQ5nYmuEImStDeKGXdAZ+4pjW+xTFsTSCNmYTr50DjxIh+3uHsrScpr2FxBz/kDjasAG/CDxkD3KCAG9ehqkajD/IrcOKgSPKXO/iQpioQ+umlmqK8p1JNiVAs5JObVkheASXXW1FqGnGcZ/jIjuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtgdmIabDD7hi/sgpAsoUy5Pth5ljcPfkZurJbUvZxM=;
 b=k4SM1mx/kfHMPc0CzIfQuXK4J14z7yMExHkLknfJF78flYxcJXYZk6+od75N6UWLZYP7dapRjG/lSkhQ4ugHKaYrXC6uzw6vn8a6GX627hJzQhqbJl6jUscC9q/htU4ymApGZzx48Zdzk0jwKr+HG8l1IfLrpbTtaW3d+O1j5ho=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6800.namprd10.prod.outlook.com (2603:10b6:8:13b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 14:36:45 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 14:36:45 +0000
Message-ID: <291a73af-5ad4-4077-a61a-229a6ad99f8d@oracle.com>
Date: Mon, 24 Jun 2024 15:36:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] xfs: Introduce FORCEALIGN inode flag
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com
References: <20240621100540.2976618-1-john.g.garry@oracle.com>
 <20240621100540.2976618-8-john.g.garry@oracle.com>
 <20240621190743.GM3058325@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240621190743.GM3058325@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0185.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f47ef9-0cc6-484b-9ff9-08dc945b1265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Szh2bWtoNFh5Z3dGMThrOVU2U2lDekQyUmlTMWYvODdmWHFLUFVsSlhrSk9m?=
 =?utf-8?B?Z3NRbjVyYlVENTZGcEZVamhUbnVLTHZtQmFKS3FYcDNuSW1UaWFwWEdlYnVG?=
 =?utf-8?B?RWRDanBmMzZXdlhMdTFhblR1eS9BZFNSK0dnOTdBQjA4dkhCc0tsQk1YOWcx?=
 =?utf-8?B?azdNaXdCUklpVmFlR21JT0JhK1E4c2xpT1dFam5ZdGlCNVBVd3JOSzdpT0xl?=
 =?utf-8?B?WVU1TEo4VnFVSE1NSG1Fa1FBNVc1ZVNUaWVKeC8waE5uUEIwQkt1RGw2enox?=
 =?utf-8?B?L3RRNkJ4Tis5RFJYNE05TVJMaEVtVFY4d0JvQ0dhWnhTL05XTkg2dEUzeHMr?=
 =?utf-8?B?aGltd0NzOVVUSTJFdTFxSzZsY1JXODFKTTIwMWxuaDlGMjBiYXpPSXZaK1hE?=
 =?utf-8?B?STQ0MjZYeXpHUVVGMGowTk8ydGV5ckxrQ2pGb0FSenBTT2FBQ1JKcDMvR2Fu?=
 =?utf-8?B?Umt3MlZMcFZ0ZUZYQVVnRHpEeElJQjlMcDVZelAzdk9FU3dLTTBYTkJ0US9V?=
 =?utf-8?B?eXVrU2EwTmFIRHVhMERSUTFkNnlsbkZPTHBQcEdRODY4cFNnenMrbGN4VVpO?=
 =?utf-8?B?WlNtdEVoQzN6MjVQdkcrb0ZIckc3WkFoUzU3MGpONXJCaVNubzQzUEVKSUxh?=
 =?utf-8?B?WmwrTFphbERURk53QlZ6SUZrMmdQK29CdWczdFdnMDY1OVZ2VzBwcEpNVG5W?=
 =?utf-8?B?YmpWYTMwTFg1SVlKaHBwVzQ0RE5tRThKM2ZHS2trTEdiZC9TWG1QS2pBbTVw?=
 =?utf-8?B?YWYvTHllUG5uczNlWklwTzJGWGkzNGFQQm9INEVBZ1RjYzZqME9RTEt4Yk5P?=
 =?utf-8?B?OWxFZTg1bFNMYUNDbmE2K1p5b1lOSTAwQzJNRzhlODBYdzlDQmhsMUdJRGN6?=
 =?utf-8?B?ZWNlMVdhY2cyUS9aNWYyT2xUR3g3QTRPbmV0dFlQTGdBamUvc2pVdkJQRzk0?=
 =?utf-8?B?dFFXT1BlMlhaaUZhOVJ1dWJscjNIVlE4NHAyR0ZoTWdOWkFLV1EwcTZhWCtt?=
 =?utf-8?B?VjhVRmlkbmRIaDZWMGM5K0g0cVZJMVU2SGw1Tmxkbnc2M1VZOHlpWGt4ZzBY?=
 =?utf-8?B?ZDJTQjhtdmlOSjh4MXVITndEeUhMc3lXdk8wcXhxNHdITDlVWW1JUlErc3Y1?=
 =?utf-8?B?K2oxYjgxNWxCWXFKRFh0V2FBTXlyOFhQZzFqcDZtVHVKNGN2b2d0UGlSNkZQ?=
 =?utf-8?B?RDJGdEw5UWgva2grQmFLTDZrMmhLRnh4UEpDMnIwVUYrcStMUlRVYlRhaFVU?=
 =?utf-8?B?N0p6ajJsNi9saGw4ZCsxVW85bDhrVVkxemViN2E3ZVFFcU5jaGpOT1FxNEZk?=
 =?utf-8?B?U3g0MjRuMCtjWVQ0VVdWZm0rT2ZVV0Y3YzM2UG9KRnlpdUJYcEpyTm1NRWZu?=
 =?utf-8?B?b1kyRkY0VlJDTmRNdksvTDhEeDQzbStCLzBMcHBZZVJ2WG9KUkxrbmpqbm51?=
 =?utf-8?B?bGhmK3hMNmRRb0Vtc0pUQVJvd0FHZ3Rrcm5hbDRiYmozcUxZYktWUkJLUDhD?=
 =?utf-8?B?VXpxRkU5UE5UaXpmV3daM1ZBV1hYalNlek1zWDBLbXRpOTRYdWRCZGlVeEds?=
 =?utf-8?B?aTlubmlzekxKeHBCRkVHaXpTZmdKcTF4S1dhUStDYlBGeVlDdTFUTStrbFFu?=
 =?utf-8?B?UU9YdHZZMTNkOThtZUJ3MzB6djlGWEw0bm9oN1JoZU9lWS9nVTdUWlBJekN6?=
 =?utf-8?Q?4qxIG7sVE/iWaRWpAQLb?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WnQ0SFJ3eW84TTV5SGVPcFhvUHNvenZLemtDYVBpeThCVVFXWVZHRDFkOEFV?=
 =?utf-8?B?aFBnUWRqUFpmYkVPZFJLaStjbmcrd0Vwbkh3V0xaeXF3Ti9EQ1dUcXNJaHZ6?=
 =?utf-8?B?SU9NYmZDUTFRRG0waUcyQ09UbElRUEppNUNBa1IwazluRnBBKzBac2VFeExS?=
 =?utf-8?B?SXk2aWlJV05iNGlraVRraWdqai9vTXVGZ09YMms3MmJraXV6RG92ZEhpMUN5?=
 =?utf-8?B?SG1OYi9sR1hqdFBVSlREK0FjUEl4c1BzNXpqQmw2RE5ZUnAwckNzSWRwM3dw?=
 =?utf-8?B?MTZJeE5GVlp6NlhSUTRyRkx0YWpaZ3gya0FnUVpIQjFFSEVObUtOWFFMcEdp?=
 =?utf-8?B?VFQ0eVlXQk9VUEdIT25ZR3RCRDlqMER0OXppaWx5NmcvMkZpOG5tV2lYclli?=
 =?utf-8?B?WVVtTHk5djlYTzNTQTRVc05UVGlyaVI5ajQxZGI3ZzcxaEVMbUJ1a1B2NmNr?=
 =?utf-8?B?OEd6amxMZ0wvM1hEYXlTUnZ1RGM4SmY4elpROHM4MWRQUUpYWllmNGtzZEtQ?=
 =?utf-8?B?VzhiTS9RL1NmdWFnZS84d3VmWUgwalZWK2h1M3JIYyttdS9heE1ZTzFEZlI1?=
 =?utf-8?B?T0dMVitaKzdjSkNyUFpOY2VFR2dGNFRSWFhmZytWUjVYSWp2RHpYM3BMWWpM?=
 =?utf-8?B?aGxDTG04cXJqVWhRQlJpbUJMODdML0hheG4xemJUazc1U1Jtd0xZc05rQUIw?=
 =?utf-8?B?anRNYXpXcDNJTExBUklnejY4a3cxaU5nY2VKZi9Zc1hRU1dDRkQyZGphSFJq?=
 =?utf-8?B?NFJSQXdPS1hlb2JXWVBncFo5RHlKdUN2R3VNSXI5UmcwbGVzbnJ5bkwrTnY4?=
 =?utf-8?B?RE5yN3NzR29mYWJqdHAzZzFWUTg0S2VEay9KUm1nbVpackZJa1MyamJmRHdY?=
 =?utf-8?B?NDc3SDVFb1IxOEVhSEZHYzA4cmNKMXlGVEJGQXN0bGNZcmc3dW9FVVMvQjYx?=
 =?utf-8?B?cUtObmdnZUVDSGoyc3JWb0NTYVhuYSsydnV2WHF4cWlSdk1iQXNQZ1czTjFX?=
 =?utf-8?B?MVFmdFk4Y1JlMzNRM3Z2aFQxb3d2eHIrQkhQbCtzbmFGRGxDM3hCdFpuRXcz?=
 =?utf-8?B?dlRJbGVQKzNVbWRuT3Y5RkI0YWVDb1dLSThxV284R285bkNJMVYzMDFzcjN6?=
 =?utf-8?B?RXlrbVA4Q1dVUzNMdTJtbElLZ0tBQnZsaU5yeUtqOWkyTDZ3M2d4cGx1VlF6?=
 =?utf-8?B?dDc4cjRxdjBPelc1TzE3aHRXZVUrd1k3dE1WN0E1Tk02Ym1DMWRBaW10dXk5?=
 =?utf-8?B?RGFnUDNDUHNGZmZoL1M0aUJXVVRZN1YzZTNmVlkyK1BRbm5vdGFhR1d2MTdP?=
 =?utf-8?B?SjZMZkxuSnFHN3plM3l4dVBEd3gzZXVCTHA1ZzhVU1dHWHN1UVVBZVJKN2px?=
 =?utf-8?B?MVZZTE9rYmFWa0t5WFR5RWljU1JJdlBTTmRuN1hrUTFGMlhyR1lPY0NiM2ZG?=
 =?utf-8?B?RnBIam1FOG5aa2xhbEhTK0doc0k4ZXJrQ285aFZuMW5kRXp1T2NrTHhUbU1R?=
 =?utf-8?B?TU5iclBpeG9NbzVWUi9rd3lNRDFYRjlQTXJNNTZxWDZRR1MwMVllSUEzVXFr?=
 =?utf-8?B?MFlseGluekdrYVlSamxmK28vdFlwTFdvSUtTbUVlOVoxcEllcUw5WEFEMnRF?=
 =?utf-8?B?TGd6bmdTcXRra3dydFFMVGlhaDMzVGc3M1pId1E1OE04VlR0dW9LTEJGbll0?=
 =?utf-8?B?dUs1M3BwNHY5eXFpWUV0MmpVSU43M05RbkJHWkFwenZMMjZhZGNXVCsrN0k2?=
 =?utf-8?B?czZQTytJSHFnaGhleXZjNVV0THV5MUd2Y28wT01aK01WSHZISHJPNVJ2OVlO?=
 =?utf-8?B?YllMRVVVY1pyVk9Nb0Z4bFJoRGJROUp5Y2YxTHYvQXNoSkI4RENPTXNXYWdL?=
 =?utf-8?B?K1RDMUdDUGl6MDlQendpZGYzWi9FYjZpenUzQWpoNVFxT085OGIycVBydnlC?=
 =?utf-8?B?NnVncG9OVjdMaGdSWjUvS1NlYUxDY1B2OHBQNk5WU0Z5RnZUVzU2VVZzZkN2?=
 =?utf-8?B?enNBc0wxYWRCa1d6NmMzM2IrZG4yNVZ6dUUxcUVvV0xVVHlmK00yNmRGcjU2?=
 =?utf-8?B?YUI0alVNN1p1WHNLUWNvd1lSWE93S1BGblE2Z1JpcStqTHpaU3ROamN5NExP?=
 =?utf-8?Q?DoyGbQlySplRis3oXD62Zn6vS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZGbsoU4Yw29kZNxCUYCj4VliSwsBcddguDn+5ceRVj1MIq3ikk21vfhpLzrsFQDdM5ERyecVnSRCdh3/ROA8z3rk5FFNcwY2haDyLqZVxe9GxpxWlYx7RsURoRS47O2mpLYaD5vSTleIKuzyMGMZPnTNfwD72o8pC9qW87BUY/m/BvYJQNGjSTKPtVCyBVwJwRczo0qwwZAHDwnL5lQ3cj1ZGW60KFRa4egK6MzJY07Vt2VOMI+gN9+CsfiOoKnDFIH9IKdBejZyp2syOh3SUu5z4oYfntRsL1n6VqFpuyEj58GYLgVGKOlrf80SyV09auExcuL3nZW3SChg8De5q1RLl6m+j10dtuWhFPneqgubcStgrTecB/45uwRcDK2poo/QLikCbc3kbbwdjRDJG3/NIz533IT2FpV0DdTeoYhsOrueJo9o4/TFT8OeSMFRkOLGOPbA4ktfVatw+GR3J0i6PHD5GsR1sDlBTVaUivCrto+DxC/zC5ABA0OChQA9TM5/CkF06zdowFRF5l1Sf75awWY3GFJQKRroxrqPaS/MElom5oSHbx8RjYqvbVsuT0iYsMtx88DpGr6v1c9gu3rE0gHqL/LQ7ARRrxb3aes=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f47ef9-0cc6-484b-9ff9-08dc945b1265
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:36:45.8113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXVbxD5coB4EacGR0+4auXgEnxGiC1pwmxpR6685gsN/FJNILeFs0sp4T+Fflyv1mMZZEuWG8TYkDEBKeg8rhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6800
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_11,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406240117
X-Proofpoint-GUID: wF078pAl2LkOeddHLkMPBUUXIbsGJ3zl
X-Proofpoint-ORIG-GUID: wF078pAl2LkOeddHLkMPBUUXIbsGJ3zl

On 21/06/2024 20:07, Darrick J. Wong wrote:
> On Fri, Jun 21, 2024 at 10:05:34AM +0000, John Garry wrote:
>> From: "Darrick J. Wong" <djwong@kernel.org>
>>
>> Add a new inode flag to require that all file data extent mappings must
>> be aligned (both the file offset range and the allocated space itself)
>> to the extent size hint.  Having a separate COW extent size hint is no
>> longer allowed.
> 
> It might be worth mentioning that for non-rt files, the allocated space
> will be aligned to the start of an AG, not necessary the block device,
> though the upcoming atomicwrites inode flag will also require that.

ok

> 
> Also this should clarify what happens for rt files -- do we allow
> forcealign realtime files? 

We would, but not yet. So how to handle in the kernel now?

Dave said that forcealign for RT inode is a viable on-disk format now. 
So, since we won't support forcealign for RT initailly, should we make 
the inode read-only?

> Or only for the sb_rextsize == 1 case?
> Or for any sbrextsize?

I think that any sb_rextsize is ok with forcealign, as long as 
forcealign extsize % sb_rextsize == 0. And, to support atomic writes, we 
need power-of-2 extsize.

> 
>> The goal here is to enable sysadmins and users to mandate that all space
>> mappings in a file must have a startoff/blockcount that are aligned to
>> (say) a 2MB alignment and that the startblock/blockcount will follow the
>> same alignment.
>>
>> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
>> Co-developed-by: John Garry <john.g.garry@oracle.com>

note: I really should mention that I have made big changes since you 
touched this patch

>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/libxfs/xfs_format.h    |  6 +++-
>>   fs/xfs/libxfs/xfs_inode_buf.c | 53 +++++++++++++++++++++++++++++++++++
>>   fs/xfs/libxfs/xfs_inode_buf.h |  3 ++
>>   fs/xfs/libxfs/xfs_sb.c        |  2 ++
>>   fs/xfs/xfs_inode.c            | 13 +++++++++
>>   fs/xfs/xfs_inode.h            | 20 ++++++++++++-
>>   fs/xfs/xfs_ioctl.c            | 47 +++++++++++++++++++++++++++++--
>>   fs/xfs/xfs_mount.h            |  2 ++
>>   fs/xfs/xfs_reflink.h          | 10 -------
>>   fs/xfs/xfs_super.c            |  4 +++
>>   include/uapi/linux/fs.h       |  2 ++
>>   11 files changed, 148 insertions(+), 14 deletions(-)
>>
>> diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
>> index 61f51becff4f..b48cd75d34a6 100644
>> --- a/fs/xfs/libxfs/xfs_format.h
>> +++ b/fs/xfs/libxfs/xfs_format.h
>> @@ -353,6 +353,7 @@ xfs_sb_has_compat_feature(
>>   #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
>>   #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
>>   #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
>> +#define XFS_SB_FEAT_RO_COMPAT_FORCEALIGN (1 << 30)	/* aligned file data extents */
>>   #define XFS_SB_FEAT_RO_COMPAT_ALL \
>>   		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
>>   		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
>> @@ -1094,16 +1095,19 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
>>   #define XFS_DIFLAG2_COWEXTSIZE_BIT   2  /* copy on write extent size hint */
>>   #define XFS_DIFLAG2_BIGTIME_BIT	3	/* big timestamps */
>>   #define XFS_DIFLAG2_NREXT64_BIT 4	/* large extent counters */
>> +/* data extent mappings for regular files must be aligned to extent size hint */
>> +#define XFS_DIFLAG2_FORCEALIGN_BIT 5
>>   
>>   #define XFS_DIFLAG2_DAX		(1 << XFS_DIFLAG2_DAX_BIT)
>>   #define XFS_DIFLAG2_REFLINK     (1 << XFS_DIFLAG2_REFLINK_BIT)
>>   #define XFS_DIFLAG2_COWEXTSIZE  (1 << XFS_DIFLAG2_COWEXTSIZE_BIT)
>>   #define XFS_DIFLAG2_BIGTIME	(1 << XFS_DIFLAG2_BIGTIME_BIT)
>>   #define XFS_DIFLAG2_NREXT64	(1 << XFS_DIFLAG2_NREXT64_BIT)
>> +#define XFS_DIFLAG2_FORCEALIGN	(1 << XFS_DIFLAG2_FORCEALIGN_BIT)
>>   
>>   #define XFS_DIFLAG2_ANY \
>>   	(XFS_DIFLAG2_DAX | XFS_DIFLAG2_REFLINK | XFS_DIFLAG2_COWEXTSIZE | \
>> -	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64)
>> +	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_FORCEALIGN)
>>   
>>   static inline bool xfs_dinode_has_bigtime(const struct xfs_dinode *dip)
>>   {
>> diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
>> index e7a7bfbe75b4..b2c5f466c1a9 100644
>> --- a/fs/xfs/libxfs/xfs_inode_buf.c
>> +++ b/fs/xfs/libxfs/xfs_inode_buf.c
>> @@ -644,6 +644,15 @@ xfs_dinode_verify(
>>   	    !xfs_has_bigtime(mp))
>>   		return __this_address;
>>   
>> +	if (flags2 & XFS_DIFLAG2_FORCEALIGN) {
>> +		fa = xfs_inode_validate_forcealign(mp,
>> +			be32_to_cpu(dip->di_extsize),
>> +			be32_to_cpu(dip->di_cowextsize),
>> +			mode, flags, flags2);
> 
> Needs another level of indent.

ok

> 
> 		fa = xfs_inode_validate_forcealign(mp,
> 				be32_to_cpu(dip->di_extsize),
> 				be32_to_cpu(dip->di_cowextsize),
> 				mode, flags, flags2);
> 
>> +		if (fa)
>> +			return fa;
>> +	}
>> +
>>   	return NULL;
>>   }
>>   
>> @@ -811,3 +820,47 @@ xfs_inode_validate_cowextsize(
>>   
>>   	return NULL;
>>   }
>> +
>> +/* Validate the forcealign inode flag */
>> +xfs_failaddr_t
>> +xfs_inode_validate_forcealign(
>> +	struct xfs_mount	*mp,
>> +	uint32_t		extsize,
>> +	uint32_t		cowextsize,
>> +	uint16_t		mode,
>> +	uint16_t		flags,
>> +	uint64_t		flags2)
>> +{
>> +	/* superblock rocompat feature flag */
>> +	if (!xfs_has_forcealign(mp))
>> +		return __this_address;
>> +
>> +	/* Only regular files and directories */
>> +	if (!S_ISDIR(mode) && !S_ISREG(mode))
>> +		return __this_address;
>> +
>> +	/* We require EXTSIZE or EXTSZINHERIT */
>> +	if (!(flags & (XFS_DIFLAG_EXTSIZE | XFS_DIFLAG_EXTSZINHERIT)))
>> +		return __this_address;
>> +
>> +	/* We require a non-zero extsize */
>> +	if (!extsize)
>> +		return __this_address;
>> +
>> +	/* Reflink'ed disallowed */
>> +	if (flags2 & XFS_DIFLAG2_REFLINK)
>> +		return __this_address;
> 
> This is still a significant limitation to end up encoding in the ondisk
> format.  Given that we may some day fix that limitation by teaching
> pagecache writeback how to do writeback on entire allocation units,
> I think for now you should refuse to mount any filesystem with reflink
> and forcealign enabled at the same time.

That seems pretty drastic.

> 
>> +
>> +	/* COW extsize disallowed */
>> +	if (flags2 & XFS_DIFLAG2_COWEXTSIZE)
>> +		return __this_address;
>> +
>> +	if (cowextsize)
>> +		return __this_address;
>> +
>> +	/* A RT device with sb_rextsize=1 could make use of forcealign */
>> +	if (flags & XFS_DIFLAG_REALTIME && mp->m_sb.sb_rextsize != 1)
>> +		return __this_address;
> 
> Ok, so forcealign and bigrtalloc are not compatible?  I would have
> thought they would be ok together since the rest of your code changes
> short circuit into the forcealign case before the bigrtalloc case.
> All you need here is to validate that i_extsize % sb_rextsize == 0.

See what Dave wrote at 
https://lore.kernel.org/linux-xfs/20240429174746.2132161-1-john.g.garry@oracle.com/T/#m808100f5699c3068bb5d5939297ff54ce3a3081f 
that begins with "A rt device with an extsize of 1 fsb could make use of
forced alignment just like the data device to allow larger atomic
writes to be done.". How do you read that exactly?

> 
>> +
>> +	return NULL;
> 
> You don't check that i_extsize % sb_agblocks == 0 for non-rt files
> because that is only required for atomic writes + forcealign, right?

right

> 
>> +}
>> diff --git a/fs/xfs/libxfs/xfs_inode_buf.h b/fs/xfs/libxfs/xfs_inode_buf.h
>> index 585ed5a110af..b8b65287b037 100644
>> --- a/fs/xfs/libxfs/xfs_inode_buf.h
>> +++ b/fs/xfs/libxfs/xfs_inode_buf.h
>> @@ -33,6 +33,9 @@ xfs_failaddr_t xfs_inode_validate_extsize(struct xfs_mount *mp,
>>   xfs_failaddr_t xfs_inode_validate_cowextsize(struct xfs_mount *mp,
>>   		uint32_t cowextsize, uint16_t mode, uint16_t flags,
>>   		uint64_t flags2);
>> +xfs_failaddr_t xfs_inode_validate_forcealign(struct xfs_mount *mp,
>> +		uint32_t extsize, uint32_t cowextsize, uint16_t mode,
>> +		uint16_t flags, uint64_t flags2);
>>   
>>   static inline uint64_t xfs_inode_encode_bigtime(struct timespec64 tv)
>>   {
>> diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
>> index 6b56f0f6d4c1..e56911553edd 100644
>> --- a/fs/xfs/libxfs/xfs_sb.c
>> +++ b/fs/xfs/libxfs/xfs_sb.c
>> @@ -164,6 +164,8 @@ xfs_sb_version_to_features(
>>   		features |= XFS_FEAT_REFLINK;
>>   	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
>>   		features |= XFS_FEAT_INOBTCNT;
>> +	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_FORCEALIGN)
>> +		features |= XFS_FEAT_FORCEALIGN;
>>   	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
>>   		features |= XFS_FEAT_FTYPE;
>>   	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)
>> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
>> index f36091e1e7f5..994fb7e184d9 100644
>> --- a/fs/xfs/xfs_inode.c
>> +++ b/fs/xfs/xfs_inode.c
>> @@ -608,6 +608,8 @@ xfs_ip2xflags(
>>   			flags |= FS_XFLAG_DAX;
>>   		if (ip->i_diflags2 & XFS_DIFLAG2_COWEXTSIZE)
>>   			flags |= FS_XFLAG_COWEXTSIZE;
>> +		if (ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN)
>> +			flags |= FS_XFLAG_FORCEALIGN;
>>   	}
>>   
>>   	if (xfs_inode_has_attr_fork(ip))
>> @@ -737,6 +739,8 @@ xfs_inode_inherit_flags2(
>>   	}
>>   	if (pip->i_diflags2 & XFS_DIFLAG2_DAX)
>>   		ip->i_diflags2 |= XFS_DIFLAG2_DAX;
>> +	if (pip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN)
>> +		ip->i_diflags2 |= XFS_DIFLAG2_FORCEALIGN;
>>   
>>   	/* Don't let invalid cowextsize hints propagate. */
>>   	failaddr = xfs_inode_validate_cowextsize(ip->i_mount, ip->i_cowextsize,
>> @@ -745,6 +749,15 @@ xfs_inode_inherit_flags2(
>>   		ip->i_diflags2 &= ~XFS_DIFLAG2_COWEXTSIZE;
>>   		ip->i_cowextsize = 0;
>>   	}
>> +
>> +	if (ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN) {
>> +		failaddr = xfs_inode_validate_forcealign(ip->i_mount,
>> +				ip->i_extsize, ip->i_cowextsize,
>> +				VFS_I(ip)->i_mode, ip->i_diflags,
>> +				ip->i_diflags2);
>> +		if (failaddr)
>> +			ip->i_diflags2 &= ~XFS_DIFLAG2_FORCEALIGN;
>> +	}
>>   }
>>   
>>   /*
>> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
>> index 42f999c1106c..536e646dd055 100644
>> --- a/fs/xfs/xfs_inode.h
>> +++ b/fs/xfs/xfs_inode.h
>> @@ -301,6 +301,16 @@ static inline bool xfs_inode_has_cow_data(struct xfs_inode *ip)
>>   	return ip->i_cowfp && ip->i_cowfp->if_bytes;
>>   }
>>   
>> +static inline bool xfs_is_always_cow_inode(struct xfs_inode *ip)
>> +{
>> +	return ip->i_mount->m_always_cow && xfs_has_reflink(ip->i_mount);
>> +}
>> +
>> +static inline bool xfs_is_cow_inode(struct xfs_inode *ip)
>> +{
>> +	return xfs_is_reflink_inode(ip) || xfs_is_always_cow_inode(ip);
>> +}
>> +
>>   static inline bool xfs_inode_has_bigtime(struct xfs_inode *ip)
>>   {
>>   	return ip->i_diflags2 & XFS_DIFLAG2_BIGTIME;
>> @@ -313,7 +323,15 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
>>   
>>   static inline bool xfs_inode_has_forcealign(struct xfs_inode *ip)
>>   {
>> -	return false;
>> +	if (!(ip->i_diflags & XFS_DIFLAG_EXTSIZE))
>> +		return false;
>> +	if (ip->i_extsize <= 1)
>> +		return false;
>> +	if (xfs_is_cow_inode(ip))
>> +		return false;
>> +	if (ip->i_diflags & XFS_DIFLAG_REALTIME)
>> +		return false;
>> +	return ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN;
> 
> In theory we already validated all of these fields when we loaded the
> inode, right?  In which case you only need to check diflags2.

It was suggested to have all these checks in one place to safeguard 
against some other functions not detecting invalid flags.

> 
>>   }
>>   
>>   /*
>> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
>> index f0117188f302..5eff8fd9fa3e 100644
>> --- a/fs/xfs/xfs_ioctl.c
>> +++ b/fs/xfs/xfs_ioctl.c
>> @@ -525,10 +525,48 @@ xfs_flags2diflags2(
>>   		di_flags2 |= XFS_DIFLAG2_DAX;
>>   	if (xflags & FS_XFLAG_COWEXTSIZE)
>>   		di_flags2 |= XFS_DIFLAG2_COWEXTSIZE;
>> +	if (xflags & FS_XFLAG_FORCEALIGN)
>> +		di_flags2 |= XFS_DIFLAG2_FORCEALIGN;
>>   
>>   	return di_flags2;
>>   }
>>   
>> +/*
>> + * Forcealign requires a non-zero extent size hint and a zero cow
>> + * extent size hint.  Don't allow set for RT files yet.
>> + */
>> +static int
>> +xfs_ioctl_setattr_forcealign(
>> +	struct xfs_inode	*ip,
>> +	struct fileattr		*fa)
>> +{
>> +	struct xfs_mount	*mp = ip->i_mount;
>> +
>> +	if (!xfs_has_forcealign(mp))
>> +		return -EINVAL;
>> +
>> +	if (xfs_is_reflink_inode(ip))
>> +		return -EINVAL;
>> +
>> +	if (!(fa->fsx_xflags & (FS_XFLAG_EXTSIZE |
>> +				FS_XFLAG_EXTSZINHERIT)))
>> +		return -EINVAL;
>> +
>> +	if (fa->fsx_xflags & FS_XFLAG_COWEXTSIZE)
>> +		return -EINVAL;
>> +
>> +	if (!fa->fsx_extsize)
>> +		return -EINVAL;
>> +
>> +	if (fa->fsx_cowextsize)
>> +		return -EINVAL;
>> +
>> +	if (fa->fsx_xflags & FS_XFLAG_REALTIME)
>> +		return -EINVAL;
> 
> The inode verifier allows realtime files so long as sb_rextsize is
> nonzero.

Yeah, again, I am not sure on this.

> 
>> +
>> +	return 0;
>> +}
>> +
>>   static int
>>   xfs_ioctl_setattr_xflags(
>>   	struct xfs_trans	*tp,
>> @@ -537,10 +575,12 @@ xfs_ioctl_setattr_xflags(
>>   {
>>   	struct xfs_mount	*mp = ip->i_mount;
>>   	bool			rtflag = (fa->fsx_xflags & FS_XFLAG_REALTIME);
>> +	bool			forcealign = fa->fsx_xflags & FS_XFLAG_FORCEALIGN;
>>   	uint64_t		i_flags2;
>>   
>> -	if (rtflag != XFS_IS_REALTIME_INODE(ip)) {
>> -		/* Can't change realtime flag if any extents are allocated. */
>> +	/* Can't change RT or forcealign flags if any extents are allocated. */
>> +	if (rtflag != XFS_IS_REALTIME_INODE(ip) ||
>> +	    forcealign != xfs_inode_has_forcealign(ip)) {
>>   		if (ip->i_df.if_nextents || ip->i_delayed_blks)
>>   			return -EINVAL;
>>   	}
>> @@ -561,6 +601,9 @@ xfs_ioctl_setattr_xflags(
>>   	if (i_flags2 && !xfs_has_v3inodes(mp))
>>   		return -EINVAL;
>>   
>> +	if (forcealign && (xfs_ioctl_setattr_forcealign(ip, fa) < 0))
>> +		return -EINVAL;
> 
> Either make xfs_ioctl_setattr_forcealign return a boolean, or extract
> the error code and return that; don't just squash
> xfs_ioctl_setattr_forcealign's negative errno into -EINVAL.

ok, fine

> 
>> +
>>   	ip->i_diflags = xfs_flags2diflags(ip, fa->fsx_xflags);
>>   	ip->i_diflags2 = i_flags2;
>>   
>> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
>> index d0567dfbc036..30228fea908d 100644
>> --- a/fs/xfs/xfs_mount.h
>> +++ b/fs/xfs/xfs_mount.h
>> @@ -299,6 +299,7 @@ typedef struct xfs_mount {
>>   #define XFS_FEAT_NEEDSREPAIR	(1ULL << 25)	/* needs xfs_repair */
>>   #define XFS_FEAT_NREXT64	(1ULL << 26)	/* large extent counters */
>>   #define XFS_FEAT_EXCHANGE_RANGE	(1ULL << 27)	/* exchange range */
>> +#define XFS_FEAT_FORCEALIGN	(1ULL << 28)	/* aligned file data extents */
>>   
>>   /* Mount features */
>>   #define XFS_FEAT_NOATTR2	(1ULL << 48)	/* disable attr2 creation */
>> @@ -385,6 +386,7 @@ __XFS_ADD_V4_FEAT(projid32, PROJID32)
>>   __XFS_HAS_V4_FEAT(v3inodes, V3INODES)
>>   __XFS_HAS_V4_FEAT(crc, CRC)
>>   __XFS_HAS_V4_FEAT(pquotino, PQUOTINO)
>> +__XFS_HAS_FEAT(forcealign, FORCEALIGN)
>>   
>>   /*
>>    * Mount features
>> diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
>> index 65c5dfe17ecf..fb55e4ce49fa 100644
>> --- a/fs/xfs/xfs_reflink.h
>> +++ b/fs/xfs/xfs_reflink.h
>> @@ -6,16 +6,6 @@
>>   #ifndef __XFS_REFLINK_H
>>   #define __XFS_REFLINK_H 1
>>   
>> -static inline bool xfs_is_always_cow_inode(struct xfs_inode *ip)
>> -{
>> -	return ip->i_mount->m_always_cow && xfs_has_reflink(ip->i_mount);
>> -}
>> -
>> -static inline bool xfs_is_cow_inode(struct xfs_inode *ip)
>> -{
>> -	return xfs_is_reflink_inode(ip) || xfs_is_always_cow_inode(ip);
>> -}
>> -
>>   extern int xfs_reflink_trim_around_shared(struct xfs_inode *ip,
>>   		struct xfs_bmbt_irec *irec, bool *shared);
>>   int xfs_bmap_trim_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
>> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
>> index 27e9f749c4c7..852bbfb21506 100644
>> --- a/fs/xfs/xfs_super.c
>> +++ b/fs/xfs/xfs_super.c
>> @@ -1721,6 +1721,10 @@ xfs_fs_fill_super(
>>   		mp->m_features &= ~XFS_FEAT_DISCARD;
>>   	}
>>   
>> +	if (xfs_has_forcealign(mp))
>> +		xfs_warn(mp,
>> +"EXPERIMENTAL forced data extent alignment feature in use. Use at your own risk!");
> 
> Here would be the place to fail the mount if reflink is enabled.

Right


Thanks,
John

