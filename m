Return-Path: <linux-fsdevel+bounces-23150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2221927D69
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 21:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23CB71F24A62
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 19:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434DF131E2D;
	Thu,  4 Jul 2024 19:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WwWDiU7Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NhFekf57"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A930F6CDA1;
	Thu,  4 Jul 2024 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720119647; cv=fail; b=t6gliRCJo7Yc0NvPHpZU7tcmrIUVHxfcClgrTXT907M5f/ExcgZSMm+fN4aV8sjnwE6L13Ed+wIOpumKHviUJS0/prC49M5FTCNnvDQNJ5OTBAqYHK41siNRwSTDC7GFxBMbt0oSUuFz5C4gtWBFVhv0Oxs5U6kis9XbvJowXaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720119647; c=relaxed/simple;
	bh=1ryz9MCLuF+OQohqNm1KyNQFg6w4NRSXXcNJ1O2AX/w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cpqoRuulgyNke9tgIe3Jwn0K1sCCJL/zURhHZojhWN8x8I9jJgyWHPtLvJwSUXAK2fY0he2KvImVYMR60qwW60agLdj9NPSYU2R6hHQ0Ve6ABntB42YGVDfEqVT5QQeQRYpgSwZf5jOeCkRdYfapjOssUr1eGGp3ury/fE/9CBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WwWDiU7Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NhFekf57; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464DLwfr031054;
	Thu, 4 Jul 2024 19:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=1ryz9MCLuF+OQohqNm1KyNQFg6w4NRSXXcNJ1O2AX
	/w=; b=WwWDiU7ZyTj9g0vuTPOuM9l9vI8JLBsNBgpcbbtoGVtHv+D/ipq1aIRAT
	GY9JFUfHxyRxu98HUfpKZi961gxmzTc8Sv5o+KLZsduNe239jJX0szAlM+ecVyv4
	cjiAFfV6hMtwIBZHhv+BGfU8uxqTt/OIj1zXsQrTFAvIL/P9i4uhva5rnlFBHrLw
	CVonDGlTMdRn/AXtsFNQhfNoRi5aK3YpKMxqrFtabRDeDIYayU64HRZi1Rh4Cx2r
	DOpAYF89sQDS46hr29wr7JOzFwd1Zb21xf6Jt9XTo0E4PNX9Xni40s97xIuR5+Sm
	TD4VYgYC3p04Evl+mNecewShMjDpw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402aacjtvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 19:00:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 464Fxl91024927;
	Thu, 4 Jul 2024 19:00:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n11m8ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 19:00:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXiEIF1N3oS1nbKxijM2neljjBsEC+11DkV3pumrHowtwUVvAuQz0ftEg21p3MYdWvxYT1rTXXRSbRAYyS+x/dgCY2kMcKF6C24qXz2cJi9pX+3OTf7o30SsuOSByq78qDUJm0opL7H6R+vUWHtw5xqYhaEMV8+X69t4WX3qJSwC5WSqz+kvMOPbj9TdbCdkzJGxxjjsriAWaK6s+7uhqEc9+XaRtPqRxTEH2qFqIwVfC4tp76ZftO5g5IZy0EIQj7DWz62XzVdUZdQchEqkb+rnG9X6eDRuSGOPbKbInOnOUuh75Sd5Lk8ku/BKZcRqvYJLy9zrBk6LmsJgNlvV4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ryz9MCLuF+OQohqNm1KyNQFg6w4NRSXXcNJ1O2AX/w=;
 b=bfDRk587PjC+JKJN5weUvrAvkN53Yq+vcqcfGOEp8xcCCF9B9NIyKWI8D4/g+u/A+bgDnAEqXepNwtEqm6mNh7iQT/M0Kg7RQmvwFBvOqz+CcGIStbS0i+GnVkxwx6IDD5zGGCTFMdBCXQpr7TNAiJwL/vAZMaw+sWkQe6qWMPZJwMOUBlVgG8R/ogYk8UpBedWyNMTTxIUE4lXVaQarciWa5WTrAOLWbL4CFRLxYIUGB0h5KoPQIa4ULCfsX/X3d3RenlGQP/TtA6B1S5TSyrrhV6essa3IQTvCcifGdwGU8xoJllKKenvnpTlNXIXSPrTqE3r3CLzeBhZzGxhoZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ryz9MCLuF+OQohqNm1KyNQFg6w4NRSXXcNJ1O2AX/w=;
 b=NhFekf578kenAnWqLtyw2EcGdQewgiy88H2DR1UUWCIQ1TFdneuXgYquuf1DIQb+vwb0/yW35356MGINm4V6QomkWdCAuVVvDfoTob/XCIFtAnPx5oMuGH9puJU0fLBQJXPUdDBBxa0iynvKZQcurWbH/M7fRvy+sk9iDXXM4VQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7275.namprd10.prod.outlook.com (2603:10b6:208:3de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Thu, 4 Jul
 2024 19:00:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7741.029; Thu, 4 Jul 2024
 19:00:23 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Anna
 Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Christoph Hellwig <hch@infradead.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: Security issue in NFS localio
Thread-Topic: Security issue in NFS localio
Thread-Index: AQHazZfYpFT8/m8roUWxRtwkwi3C/rHm7ZsA
Date: Thu, 4 Jul 2024 19:00:23 +0000
Message-ID: <23DE2D13-1E1D-4EFE-9348-5B9055B30009@oracle.com>
References: <172004548435.16071.5145237815071160040@noble.neil.brown.name>
In-Reply-To: <172004548435.16071.5145237815071160040@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA0PR10MB7275:EE_
x-ms-office365-filtering-correlation-id: 17675f13-33b1-4d61-320e-08dc9c5b8efe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?c2pOVHd1bHBwMWF6SUQzZjZNQUh6aTdWZ0ZVcGoySFdlUTFOdUdLTkRoTnhY?=
 =?utf-8?B?TXlBTENyYVZhRFVIZTVUZW1jSERQQ1I0bE9DUEhiRXVqQVhxaUNzUzFhWUFj?=
 =?utf-8?B?ZmdOMU1kYkdDYzc3WlpSWm1UOGRKR08xWm55MitlSVlKbVUxNS9lMDFZSklJ?=
 =?utf-8?B?a3VHNHRWeldudlN5elk0S3FLbG1IblpsYnp3R0VWNUxEK013T2gxOWRJUWxH?=
 =?utf-8?B?a01CamZMR29EdW84Ri9uRTdqQUVNK3V2djNmbUdSWE56Q2VIQnhJQVJVMWNx?=
 =?utf-8?B?cHU0NzZ5eDFFWTdIaVgwUDZQWm9qdTcvZmNqdWdrNDZCdWNYNitFMWJQWkdC?=
 =?utf-8?B?ZWswS3FTcFR1M3FsVndBNmxHb0VrOGtmMVNYN1hCVDBXOVlqZDFJWXgrVU9s?=
 =?utf-8?B?SDljL1htUlYxWmcvb3dic3VvdVR0UXVxS0VzRVAxMDFMREFsOEFsRjVRUTJr?=
 =?utf-8?B?cWhGalZQM2s1M1VvQ3VSN0lYejQ5NFBuRFJZVmEyRGwzRktnaXU2aTE4a1NO?=
 =?utf-8?B?emZFNnA5UU1MNmcxMFI5d1pIaWVvMFFlTE1pdlA0c3d0VDNibnN1QWo3OHJK?=
 =?utf-8?B?SUdRcVpEZWthTVFra1dWL1Vib0FQRWxRWlpTYnowUExET2p1dGU2OWVuWTMy?=
 =?utf-8?B?azNKbmVwTzBVajQ0bG9VQ0Y1RUxGZXhsSnJ3c0M2ajhLelA0ZHQ5bTVmRFAx?=
 =?utf-8?B?YmpwL0h6cCs2QlBQd0NUeUdScTYvYytWdkFTNWRrT2gxcEZrZE9zRmtueTd5?=
 =?utf-8?B?K3p4L3VKOUNnZW4yRmlMOXJFb3JGMG5GdW1SUXZNdmwvaXNtazhyeFllWWxY?=
 =?utf-8?B?TTR1QmlEcDU4RzVxKzM5V0hzR0lNWGZQM2ZMZVNvUnBrdkwvbkVQUGJncTdB?=
 =?utf-8?B?SzkxU2JUbTFlTXhwa0UwS0phajkycWttalVVL3pFRUY3eU94d2lqY0VwL3Zi?=
 =?utf-8?B?NlRrMTAzV0JjUmhZRWh4UHF4OVFFTndiQkVNVFBiSm5xaGJyNDlSY1hpcTdI?=
 =?utf-8?B?cmdNdFJJTUMySndVajJNK29oRjYreS9DTEV2bHM5QSs4d3dYTzFtQm4zdkQw?=
 =?utf-8?B?dm0xcm9QbEhQWDZsMHowb1pRUTc5V21aTzNnY1BhWW43TGZ2a1RoL3FpRzR1?=
 =?utf-8?B?eXZrdXRVSVlleW5BSzlmQWlZWGhyVm8rVTMzcjlyQ3lqUEVUNWtWaDhsMVR5?=
 =?utf-8?B?SUpUdFVsRlFwM2Vsam82dklYR3Joc0RsUGdNU1NaYWZlcFV5NS93dFNaOVNj?=
 =?utf-8?B?ZExQU2g3Y29mZ0NvSVFrRUZzZHNmY2RmQm1zZHFQYXBidzI3OWlNNzdLWmhQ?=
 =?utf-8?B?WVRmUnUrZ0lvbUxoRkp5Y1l6eCtBREZDRDRUeHg3Q1NKUjZJQ25QQ0pwU0hl?=
 =?utf-8?B?MjFCdlBKWkpYcU9uRWh3NU5nWGlBSFlHZi8yNTZGZGUzRHpnM0R1UnlKQXN6?=
 =?utf-8?B?elEybUtpcE5vemQ4SnRvTEFmMzYzN2N6QkJIeXVvSWZnLzQ4K0JiK2I0azQ4?=
 =?utf-8?B?K1l4UXByVFpzSFFubXBncUdDUlVxTVBmd0lDYUxNQ3NQM2ZkSzZsb1JnYWZ4?=
 =?utf-8?B?MHZ5Y2tvQ1ZYZ2dtc3ZhaWZLTDBBeWFlRFBneU0ySC90aC9JTlhIZTB3L0hP?=
 =?utf-8?B?L2YvSFYveFBXalNNbnZwOEd0WXpYcmJ5eWhBK3hCcFhjWVdhYktXbGQvSmV6?=
 =?utf-8?B?NVdmd1dWL3RuOHBxb3ZhbVIyamswck1ib2U2NjlYREVQdUxtSFBtYW1jMDNl?=
 =?utf-8?B?VlFpWHdhY09KV1JuQmt5dy83eDhGUnYxNy9FQVQ5VUxNVG5wVjZZV05RT2xG?=
 =?utf-8?B?aHhTbVNURWZGZFM0SzIzOTBMekwxU0tBMTd0emR4MDVnYXp5M2V1akxuc1l5?=
 =?utf-8?B?bHdlcmEzREVMeUM4Q3VzeGJtanRGNDM5cmxIc0IzbzhrQVE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?T08yYlBxaWFpc3h3U2pxTTZ2RFA0akJ5Z1lLMi9pSjhDdk1HQTg5NThyYzB3?=
 =?utf-8?B?NHhZMEFwdDZQa3VtdzAvY1hxbjhCbENaeDl6M2FyWnJsTVFjSlRQY3MvNnEy?=
 =?utf-8?B?amJSdHd3VTZqemFmZVZsMHMyT0NQQXQralVrVzRUanpqNzk5OWVaUnRHUGJV?=
 =?utf-8?B?TjdMMUd5YWN6N0J3VW0rUHYvSVFHT2NhU1hZalFXaHVORXU4a0JlSG9wYk56?=
 =?utf-8?B?SmNkQktZRjRRby8vUVJ3Y3hBY2p5a1c3Zmlmc2xLYTdua28vOXlHYmdmTTM3?=
 =?utf-8?B?SjR2dk05Tk91UkhVNXJGZkRLQnFYZUxkeUx6ZFJJWThxYi9YVzhmR2tDUU80?=
 =?utf-8?B?MWxQS1JRa3F3UUR3TktRU2t1bkdTQnNBZjFUOFo5ZzJ0cWpVSU9obmJPajdH?=
 =?utf-8?B?YThPRDhabCtkRVNNdmpjOU92KytIK0ZyaldITEwxdkZnOEROQ3BSVUpnamQ4?=
 =?utf-8?B?emJBQVNJejlxckl0Q1JIZ0F6VkhnTE1PYWJLK3JvM2dUbmlPN3NUUmNNWUlR?=
 =?utf-8?B?RnJnN2ZKOW1HdnJaVE9FellEbzJFNnlvcHNNUFF5dWRtNHlZa0crOHdaMWFB?=
 =?utf-8?B?ZFF2T1NUOFdaL2pibnhhdTVIYnFHMlVIbVptSEVWM1lrQVNWMExzLzFFSHli?=
 =?utf-8?B?ajhDT0tQTjE1SlhTYUpCelpmYnlYK1JSL010WHJESkFnTk11NGZNaGtqSEs1?=
 =?utf-8?B?Q0QzYUpzbUtINWdvbzdrM1IzSDFGeHgwZGROcnh2TWJLVHFzbkVaNURXYTVG?=
 =?utf-8?B?aU9TMkpaMTVuRk9hSFN2QWVMbzNhMUlsVCtnMXlVQmp6TmtQVUFtbVhsZjN0?=
 =?utf-8?B?SVgzRk04S3NNaWVoTkdjYjYrU1Q2ZGw3TUNmNXpUb0hzQSs2aXg5aVgzbWEv?=
 =?utf-8?B?ZDZNZklYd2JBZGdueFp3cFN0N2t4TlNZSmJScm1yK2FNQ2ZIdzUzV09BT2ZJ?=
 =?utf-8?B?ZDRjUUoyRmtyQkJjQ1VOL0luU1NvcU5HYjB5R0dSU0owalZVaGtqenc3RlFG?=
 =?utf-8?B?OFI2N1Z3aWFkWVE0ZnlXa3VGa2Fxa0t5d3k3WFBXN2VMRXQ3Wmk3aXJjaVp1?=
 =?utf-8?B?YTVER094cWlRU0FzTDJSZ1RWVjZNV1dndGhIMzlWS0xqR3habXA3WHBTcFVU?=
 =?utf-8?B?aDFTVmNqV1VGVEQxSFVpcnBWb002ekRQcHJMN1hEMWUyY1hPMk54Yjcyeko0?=
 =?utf-8?B?NHN1eUNaMS9OWXI3bWh1V0loODc4RHVOd2VMOFVaVW44eWpPZUpNUlQvak04?=
 =?utf-8?B?d1FsR2tVTjR1MGV1djBEdCt2aDM0eWpyVHU2RTQvV0RLaUNEbm5kdzZvb1FG?=
 =?utf-8?B?MlVFQlVhcUt0cG80U05KZnRUSDZMQ2dtb2x5UzVyVUVNU3BnVkw1MDVhNXUv?=
 =?utf-8?B?d0toY2tBR2ZZb3BzQXF4VjBJNXBoOU0vQnpaZWZRNkIwYzlQa0lDZEhGMFAw?=
 =?utf-8?B?eDRtRDlVbi9oL3N1aUlOUy9lc1BmdXNjbVZtZ0I5SjVGTHpwV1lGUkhXMDBG?=
 =?utf-8?B?N0xrRmRrYVVSaUphMmxYSE5iUVFJaVU5TnhYVm83UmdtYzZ2QzVvbFNSdVQ1?=
 =?utf-8?B?cEI1MzhhdkFiQk1uN09Ed3lGdDNJRlNWNWZMVm5MWExNd3FPT1dLanlRT2J6?=
 =?utf-8?B?U3I5eTFVTWtFM2RpTHhabWJrd2NabzBLMWdHYmJWaWxTTXhnVG1sN2cvUW0z?=
 =?utf-8?B?a0lxYVJyWjV5Z1YzYnNON29SRXI2VjV0NTVlVTlCb05MeVBYVGRlU245Q2xr?=
 =?utf-8?B?YnM3eERJK0NhbXlCbHBrZFpWa0xpTU93NGhCZXIxWXcyQUJFUGFybUQrKytX?=
 =?utf-8?B?M0l1TVp1ajNDeW4rdndxWC85REFad3ZPZmozSHQ0bHNFRUc2MWJsMEtSdmE0?=
 =?utf-8?B?S2t0VUNGTFgwZGdidGczYWFRWkVkMUZrV1o1SHBKbkJ0bjBtcmJHOW9nVEND?=
 =?utf-8?B?Nzd1ZE1acm9JQ2JNWEUyaDc1dkYzT241cHBaUFhnSXVQT2ZVK2srTDlHRXlF?=
 =?utf-8?B?Lzk5Z21tQlljc0tZSE5kc3RoN292Yit2dk8wcDBmbHpaa2czUy9LOFU2QnJq?=
 =?utf-8?B?WmdRMSttQjFQYXp6d0VXbkt0UFFZNk1oR3Q4b3BISFMxdEN2TkpxM09VVFh1?=
 =?utf-8?B?NnVIL2R5K01SY09UYjNpV1pBOEFWVXJGMWx6QUg5NnR0WWpDSUxyZTUxbDRD?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4C88E01C52FC74FAEC6B794E2AEE290@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Y5OxQpy2wqT3BmmxqDpIs9lVLZb7xeE69Rb01IPuCeHrW/Qidy6Hlx7OmEtfYmhOiwy4mTVfSlXbfVSXD7FAVDNHWdhbA4i78Xqa2B2KXOzL+gFZRiKEEFMppdrvxhF5DXzhlwx26VsBvjuyNKhPzYsBA4WJbu3if3Za2kCCQd5bVS8XohmYffwuvIXZCnuzoGBXOvIv+tSpXoCwNITwlivfuntap5Jltngy+r4MiLzjaDZs8v9TKavpRio+1cvh0Z6KElATDA07NOXXxQJ4IRgyXzlpAVAxbCZlwKgaNpva3TJNsPfAFu8kMRZn8/o1qi5pRxn4oWyyU5ldMwlMk0r2RFBqqWph1mZVFQJOWXavKRhk6tJ+K3cpSp6PIe+L+efwB4rQgwgyPQi8cvKbRwZRtG8mVpb/FrHZ3LD0syUTDG2zufYGZWlaXeH6QowylNd98dMIhp5ACZgAyNR8AqwlaLreOHv3emEcXH/lzMeUmRsZBUBDXvea0EU4Bze76kUR2xcxEi/qfWJIhNbxg5cOmLSW2xAeShm5pcCHPKwGU1RcePon1vFw0Bf5LnDOYcO+3F65qNTWD7a9ia948Os7gRiV3ifvJJE2j6F5BPQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17675f13-33b1-4d61-320e-08dc9c5b8efe
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 19:00:23.4216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XpMaWvvxgFvR59/UEOwTQPfflglstdQhCMN7xvapJBwsoyqjNjogypnD2ChWtFd4DKqLFNhl+K65ouMgBqUjKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7275
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_15,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407040136
X-Proofpoint-GUID: INjiH8Ap0nnvL9U4mM_apAdHbQpx0fbg
X-Proofpoint-ORIG-GUID: INjiH8Ap0nnvL9U4mM_apAdHbQpx0fbg

DQoNCj4gT24gSnVsIDMsIDIwMjQsIGF0IDY6MjTigK9QTSwgTmVpbEJyb3duIDxuZWlsYkBzdXNl
LmRlPiB3cm90ZToNCj4gDQo+IA0KPiBJJ3ZlIGJlZW4gcG9uZGVyaW5nIHNlY3VyaXR5IHF1ZXN0
aW9ucyB3aXRoIGxvY2FsaW8gLSBwYXJ0aWN1bGFybHkNCj4gd29uZGVyaW5nIHdoYXQgcXVlc3Rp
b25zIEkgbmVlZCB0byBhc2suICBJJ3ZlIGZvdW5kIHRocmVlIGZvY2FsIHBvaW50cw0KPiB3aGlj
aCBvdmVybGFwIGJ1dCBoZWxwIG1lIG9yZ2FuaXNlIG15IHRob3VnaHRzOg0KPiAxLSB0aGUgTE9D
QUxJTyBSUEMgcHJvdG9jb2wNCj4gMi0gdGhlICdhdXRoX2RvbWFpbicgdGhhdCBuZnNkIHVzZXMg
dG8gYXV0aG9yaXNlIGFjY2Vzcw0KPiAzLSB0aGUgY3JlZGVudGlhbCB0aGF0IGlzIHVzZWQgdG8g
YWNjZXNzIHRoZSBmaWxlDQo+IA0KPiAxLyBJdCBvY2N1cnMgdG8gbWUgdGhhdCBJIGNvdWxkIGZp
bmQgb3V0IHRoZSBVVUlEIHJlcG9ydGVkIGJ5IGEgZ2l2ZW4NCj4gbG9jYWwgc2VydmVyIChqdXN0
IGFzayBpdCBvdmVyIHRoZSBSUEMgY29ubmVjdGlvbiksIGZpbmQgb3V0IHRoZQ0KPiBmaWxlaGFu
ZGxlIGZvciBzb21lIGZpbGUgdGhhdCBJIGRvbid0IGhhdmUgd3JpdGUgYWNjZXNzIHRvIChub3Qg
dG9vDQo+IGhhcmQpLCBhbmQgY3JlYXRlIGEgcHJpdmF0ZSBORlMgc2VydmVyIChoYWNraW5nIG5m
cy1nYW5hc2hhPykgd2hpY2gNCj4gcmVwb3J0cyB0aGUgc2FtZSB1dWlkIGFuZCByZXBvcnRzIHRo
YXQgSSBoYXZlIGFjY2VzcyB0byBhIGZpbGUgd2l0aA0KPiB0aGF0IGZpbGVoYW5kbGUuICBJZiBJ
IHRoZW4gbW91bnQgZnJvbSB0aGF0IHNlcnZlciBpbnNpZGUgYSBwcml2YXRlDQo+IGNvbnRhaW5l
ciBvbiB0aGUgc2FtZSBob3N0IHRoYXQgaXMgcnVubmluZyB0aGUgbG9jYWwgc2VydmVyLCBJIHdv
dWxkIGdldA0KPiBsb2NhbGlvIGFjY2VzcyB0byB0aGUgdGFyZ2V0IGZpbGUuDQo+IA0KPiBJIG1p
Z2h0IG5vdCBiZSBhYmxlIHRvIHdyaXRlIHRvIGl0IGJlY2F1c2Ugb2YgY3JlZGVudGlhbCBjaGVj
a2luZywgYnV0IEkNCj4gdGhpbmsgdGhhdCBpcyBnZXR0aW5nIGEgbG90IGNsb3NlciB0byB1bmF1
dGhvcmlzZWQgYWNjZXNzIHRoYW4gSSB3b3VsZA0KPiBsaWtlLg0KPiANCj4gSSB3b3VsZCBtdWNo
IHByZWZlciBpdCBpZiB0aGVyZSB3YXMgbm8gY3JlZGlibGUgd2F5IHRvIHN1YnZlcnQgdGhlDQo+
IExPQ0FMSU8gcHJvdG9jb2wuDQo+IA0KPiBNeSBjdXJyZW50IGlkZWEgZ29lcyBsaWtlIHRoaXM6
DQo+IC0gTkZTIGNsaWVudCB0ZWxscyBuZnNfY29tbW9uIGl0IGlzIGdvaW5nIHRvIHByb2JlIGZv
ciBsb2NhbGlvDQo+ICAgYW5kIGdldHMgYmFjayBhIG5vbmNlLiAgbmZzX2NvbW1vbiByZWNvcmRz
IHRoYXQgdGhpcyBwcm9iZSBpcyBoYXBwZW5pbmcNCj4gLSBORlMgY2xpZW50IHNlbmRzIHRoZSBu
b25jZSB0byB0aGUgc2VydmVyIG92ZXIgTE9DQUxJTy4NCj4gLSBzZXJ2ZXIgdGVsbHMgbmZzX2Nv
bW1vbiAiSSBqdXN0IGdvdCB0aGlzIG5vbmNlIC0gZG9lcyBpdCBtZWFuDQo+ICAgYW55dGhpbmc/
Ii4gIElmIGl0IGRvZXMsIHRoZSBzZXJ2ZXIgZ2V0cyBjb25uZWN0ZWQgd2l0aCB0aGUgY2xpZW50
DQo+ICAgdGhyb3VnaCBuZnNfY29tbW9uLiAgVGhlIHNlcnZlciByZXBvcnRzIHN1Y2Nlc3Mgb3Zl
ciBMT0NBTElPLg0KPiAgIElmIGl0IGRvZXNuJ3QgdGhlIHNlcnZlciByZXBvcnRzIGZhaWx1cmUg
b2YgTE9DQUxJTy4NCj4gLSBORlMgY2xpZW50IGdldHMgdGhlIHJlcGx5IGFuZCB0ZWxscyBuZnNf
Y29tbW9uIHRoYXQgaXQgaGFzIGEgcmVwbHkNCj4gICBzbyB0aGUgbm9uY2UgaXMgaW52YWxpZGF0
ZWQuICBJZiB0aGUgcmVwbHkgd2FzIHN1Y2Nlc3MgYW5kIG5mc19sb2NhbA0KPiAgIGNvbmZpcm1z
IHRoZXJlIGlzIGEgY29ubmVjdGlvbiwgdGhlbiB0aGUgdHdvIHN0YXkgY29ubmVjdGVkLg0KPiAN
Cj4gSSB0aGluayB0aGF0IGhhdmluZyBhIG5vbmNlIChzaW5nbGUtdXNlIHV1aWQpIGlzIGJldHRl
ciB0aGFuIHVzaW5nIHRoZQ0KPiBzYW1lIHV1aWQgZm9yIHRoZSBsaWZlIG9mIHRoZSBzZXJ2ZXIs
IGFuZCBJIHRoaW5rIHRoYXQgc2VuZGluZyBpdA0KPiBwcm9hY3RpdmVseSBieSBjbGllbnQgcmF0
aGVyIHRoYW4gcmVhY3RpdmVseSBieSB0aGUgc2VydmVyIGlzIGFsc28NCj4gc2FmZXIuDQoNClRo
aXMgZWNob2VzIHR5cGljYWwgc2VjdXJpdHkgYXBwcm9hY2hlcywgYW5kIEkgdGhpbmsgaXQNCndv
dWxkIGJlIHZlcnkgZWFzeSB0byBjb252ZXJ0IHRoZSBjdXJyZW50IExPQ0FMSU8gcHJvdG9jb2wN
CnRvIG9wZXJhdGUgdGhpcyB3YXkuDQoNCg0KPiAyLyBUaGUgbG9jYWxpbyBhY2Nlc3Mgc2hvdWxk
IHVzZSBleGFjdGx5IHRoZSBzYW1lIGF1dGhfZG9tYWluIGFzIHRoZQ0KPiAgIG5ldHdvcmsgYWNj
ZXNzIHVzZXMuICBUaGlzIGVuc3VyZSB0aGUgY3JlZGVudGlhbHMgaW1wbGllZCBieQ0KPiAgIHJv
b3RzcXVhc2ggYW5kIGFsbHNxdWFzaCBhcmUgdXNlZCBjb3JyZWN0bHkuICBJIHRoaW5rIHRoZSBj
dXJyZW50DQo+ICAgY29kZSBoYXMgdGhlIGNsaWVudCBndWVzc2luZyB3aGF0IElQIGFkZHJlc3Mg
dGhlIHNlcnZlciB3aWxsIHNlZSBhbmQNCj4gICBmaW5kaW5nIGFuIGF1dGhfZG9tYWluIGJhc2Vk
IG9uIHRoYXQuICBJJ20gbm90IGNvbWZvcnRhYmxlIHdpdGggdGhhdC4NCj4gDQo+ICAgSW4gdGhl
IG5ldyBMT0NBTElPIHByb3RvY29sIEkgc3VnZ2VzdCBhYm92ZSwgdGhlIHNlcnZlciByZWdpc3Rl
cnMNCj4gICB3aXRoIG5mc19jb21tb24gYXQgdGhlIG1vbWVudCBpdCByZWNlaXZlcyBhbiBSUEMg
cmVxdWVzdC4gIEF0IHRoYXQNCj4gICBtb21lbnQgaXQga25vd3MgdGhlIGNoYXJhY3RlcmlzdGlj
cyBvZiB0aGUgY29ubmVjdGlvbiAtIHJlbW90ZSBJUD8NCj4gICBrcmI1PyAgdGxzPyAgLSBhbmQg
Y2FuIGRldGVybWluZSBhbiBhdXRoX2RvbWFpbiBhbmQgZ2l2ZSBpdCB0bw0KPiAgIG5mc19jb21t
b24gYW5kIHNvIG1ha2UgaXQgYXZhaWxhYmxlIHRvIHRoZSBjbGllbnQuDQoNCkkgd2Fzbid0IHN1
cmUgYWJvdXQgdGhlICJjb3B5IHRoZSBJUCBhZGRyZXNzIiBsb2dpYy4gSXQgZG9lc24ndA0Kc2Vl
bSBsaWtlIGl0IHdvdWxkIHByb3ZpZGUgYWRlcXVhdGUgc2VjdXJpdHkgYWNyb3NzIG5ldHdvcmsN
Cm5hbWVzcGFjZXMgb24gdGhlIHNhbWUgcGh5c2ljYWwgaG9zdCwgYnV0IEkgaGF2ZW4ndCBzdHVk
aWVkIGl0DQpjbG9zZWx5Lg0KDQpNeSBzZW5zZSBpcyBhbiBhZG1pbmlzdHJhdG9yIHdvdWxkIHdh
bnQgYXV0aG9yaXphdGlvbiBmb3IgbG9jYWxJTw0KdG8gYmVoYXZlIGp1c3QgbGlrZSBpdCB3b3Vs
ZCBpZiB0aGlzIHdlcmUgYSBub3JtYWwgTkZTIGFjY2Vzcy4NClNvIHRoZSBleHBvcnQncyBJUCBh
ZGRyZXNzIHNldHRpbmdzLCBzZWN1cmUvaW5zZWN1cmUsIEdTUywgVExTLA0KYW5kIHNxdWFzaGlu
ZyBvcHRpb25zIHNob3VsZCBhbGwgYmUgZWZmZWN0aXZlIGFuZCB3b3JrIGV4YWN0bHkNCnRoZSBz
YW1lIHdpdGhvdXQgcmVnYXJkIHRvIHRoZSBJL08gbWV0aG9kLg0KDQphdXRoX2RvbWFpbnMgYXJl
IGFuIGFyZWEgSSBzdGlsbCBkb24ndCBrbm93IG11Y2ggYWJvdXQsIGJ1dCB0aGF0DQpzZWVtcyBs
aWtlIGl0IHdvdWxkIGdldCB1cyBjbG9zZXIgdG8gaGF2aW5nIGFjY2VzcyBhdXRob3JpemF0aW9u
DQpiZWhhdmUgdGhlIHNhbWUgaW4gYm90aCBjYXNlcy4gSXQgbG9va2VkIGxpa2UgeW91ciBfX2Zo
X3ZlcmlmeSgpDQpjbGVhbi11cCB3YXMgaGVhZGVkIGluIHRoYXQgZGlyZWN0aW9uLg0KDQoNCj4g
ICBKZWZmIHdvbmRlcmVkIGFib3V0IGFuIGV4cG9ydCBvcHRpb24gdG8gZXhwbGljaXRseSBlbmFi
bGUgTE9DQUxJTy4gIEkNCj4gICBoYWQgd29uZGVyZWQgYWJvdXQgdGhhdCB0b28uICBCdXQgSSB0
aGluayB0aGF0IGlmIHdlIGZpcm1seSB0aWUgdGhlDQo+ICAgbG9jYWxpbyBhdXRoX2RvbWFpbiB0
byB0aGUgY29ubmVjdGlvbiBhcyBhYm92ZSwgdGhhdCBzaG91bGRuJ3QgYmUgbmVlZGVkLg0KPiAN
Cj4gMy8gVGhlIGN1cnJlbnQgY29kZSB1c2VzIHRoZSAnc3RydWN0IGNyZWQnIG9mIHRoZSBhcHBs
aWNhdGlvbiB0byBsb29rIHVwDQo+ICAgdGhlIGZpbGUgaW4gdGhlIHNlcnZlciBjb2RlLiAgV2hl
biBhIHJlcXVlc3QgZ29lcyBvdmVyIHRoZSB3aXJlIHRoZQ0KPiAgIGNyZWRlbnRpYWwgaXMgdHJh
bnNsYXRlZCB0byB1aWQvZ2lkIChvciBrcmIgaWRlbnRpdHkpIGFuZCB0aGlzIGlzDQo+ICAgbWFw
cGVkIGJhY2sgdG8gYSBjcmVkZW50aWFsIG9uIHRoZSBzZXJ2ZXIgd2hpY2ggbWlnaHQgYmUgaW4g
YQ0KPiAgIGRpZmZlcmVudCB1aWQgbmFtZSBzcGFjZSAobWlnaHQgaXQ/ICBEb2VzIHRoYXQgZXZl
biB3b3JrIGZvciBuZnNkPykNCj4gDQo+ICAgSSB0aGluayB0aGF0IGlmIHJvb3RzcXVhc2ggb3Ig
YWxsc3F1YXNoIGlzIGluIGVmZmVjdCB0aGUgY29ycmVjdA0KPiAgIHNlcnZlci1zaWRlIGNyZWRl
bnRpYWwgaXMgdXNlZCBidXQgb3RoZXJ3aXNlIHRoZSBjbGllbnQtc2lkZQ0KPiAgIGNyZWRlbnRp
YWwgaXMgdXNlZC4gIFRoYXQgaXMgbGlrZWx5IGNvcnJlY3QgaW4gbWFueSBjYXNlcyBidXQgSSdk
DQo+ICAgbGlrZSB0byBiZSBjb252aW5jZWQgdGhhdCBpdCBpcyBjb3JyZWN0IGluIGFsbCBjYXNl
LiAgTWF5YmUgaXQgaXMNCj4gICB0aW1lIHRvIGdldCBhIGRlZXBlciB1bmRlcnN0YW5kaW5nIG9m
IHVpZCBuYW1lIHNwYWNlcy4NCg0KSSd2ZSB3b25kZXJlZCBhYm91dCB0aGUgaWRtYXBwaW5nIGlz
c3VlcywgYWN0dWFsbHkuIFRoYW5rcw0KZm9yIGJyaW5naW5nIHRoYXQgdXAuIEkgdGhpbmsgQ2hy
aXN0aWFuIGFuZCBsaW51eC1mc2RldmVsDQpuZWVkIHRvIGJlIGludm9sdmVkIGluIHRoaXMgY29u
dmVyc2F0aW9uOyBhZGRlZC4NCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

