Return-Path: <linux-fsdevel+bounces-26782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1495E95B9F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F53DB24738
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E34F1C9EA9;
	Thu, 22 Aug 2024 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fHYEJBcP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fMgNX2yQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23233CF51;
	Thu, 22 Aug 2024 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339949; cv=fail; b=Ze3+VZZlcLzxZSqujThWkfmuKsdHrabhfPeTC1KxwNCDFhGHXuufBemqrZ5RdrcThCtSlIClckEFVzB86AgnFp51q7BpsXICCk5NbvEtA5v505qT59VneOo/8UKzdUmiuykHAowejvwqwbWe5HRhFtFNqI+jtVIa1y/QZqIqiLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339949; c=relaxed/simple;
	bh=f7Iuch2x3AdZh0vJcOuA/N1fyXBdUObrTkrR0TvFpQU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PCxBRfMwIOpK2lDoY7MF0cgrhTOHjWCwM3W+I0nR4+kQTWG5gtfnOoF4ecd+oHmWX+VLnp5mvzc179B+cmRkCb80fUK++pGknxv7eRt499fEmIzsd/h+Zcx7y02Dcxkf1mYcS3dE7uH816ik07UTNzhgRZCpWzF7VcO/zQCNOf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fHYEJBcP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fMgNX2yQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MEQeiF008219;
	Thu, 22 Aug 2024 15:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=f7Iuch2x3AdZh0vJcOuA/N1fyXBdUObrTkrR0TvFp
	QU=; b=fHYEJBcPJOAN7v5RU+iO5N5Mqx6P9avJO4s02S74gDMOXJYxkfoGdu9a/
	g85ZTHkcGU0Vm7pov3iUc3JdiMJEpIAqWCTyy04ifrOS6KE22lwwcdEtHf+K4UDx
	YBJPkFpL7/j4e9JZarSiULeIpx+vShaVZyhjIRYsJbyYHtneAWQDpNuuxu83uMPq
	NjY4ofljx1E2Dv8Qi1jtMan4113qfyXJySIDEP+N4UyErKX2nbDrfyZl58LxO002
	Fx0YtU0OHgrM2dCUyIseENJRguAzpb8vm8ss751scSQoBnP0jZ/m878NI5BmY8+O
	CmuCoe134coac/WcYjP2HFx//ygbQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412mdt29mx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 15:19:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MExVrj039907;
	Thu, 22 Aug 2024 15:18:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4167k390y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 15:18:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBXueh8JUq95zYsxYgPB2DsQDQLlmPXE99//n9cjiYu9WwM0RUQzCpkRwo4cRaLgznPufeVeN4VpdoCO0LMZyG3FP7qbmrsqwmki/K2R4LEV6uKqvt0P/xbr+JKDEkx71CjlxYeccnqDTM8zAbenIOISSuKPU89HtW14zciNvlsx0iex9u6h0p+eXXWiZnkbphHxx0QDQS4u84fJpIeoCxVs8ILwTWAbgp5KEEe494bFxKhAepGXqUopOU6vfNtD3pAs5zJfw5Smmi+8Y/VkU8c5mswcU3heMAg10Tkw41sPxgL7fA5GdJwfe61KJAtKO5m1dqmypewkPdUFNap87Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7Iuch2x3AdZh0vJcOuA/N1fyXBdUObrTkrR0TvFpQU=;
 b=PxTFut5Qb1AY34Z03FEn1aazktMuL+3YbbUyM+qt49+tMmPILmL2EoDsV1BgVAPwJtlnV99KUIuBxUq5SXEjsZfpqv/4ivL+EjQwXIoORRqQtNgrFJZX9Bv22ZQ+ACaQCas4aILMQIn59rFlQ9rdIweBWFIwSUCwjkqdq4MK+er48BZ1qjKuItDzb86btATxKH6mPSOr13+yny5iG3KrZ0zwv6znLVvkXIzsy3BRLu4cXmiXLdBc+KqUzuCRphcLmWvGSodWkNS+5CeV+ffhY+XYWxZHVGawysrXY4Am1bYESndO9/plHk+JL7zEcB8XcLGHhJp3lLIFpeQ3k4zPJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7Iuch2x3AdZh0vJcOuA/N1fyXBdUObrTkrR0TvFpQU=;
 b=fMgNX2yQhfEEJeX3m5hgPPCC/D6Gu89rzPgc+FT4/tonRT6RHgvrbVkaPIHTI7HndgWBBi8/Q4+OIdac3wWEWGbomDPWixOeTvQE0TcwfC6B4KRC0McO6JPRXix9ghTpINfuNN3iNMPHa61BVDvg/wImwhq+3WtcjVlhECbdEBc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB7723.namprd10.prod.outlook.com (2603:10b6:408:1b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Thu, 22 Aug
 2024 15:18:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 15:18:56 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
CC: Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond
 Myklebust <trondmy@hammerspace.com>, Neil Brown <neilb@suse.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v12 00/24] nfs/nfsd: add support for localio
Thread-Topic: [PATCH v12 00/24] nfs/nfsd: add support for localio
Thread-Index: AQHa8mQtiiugcfJoD0qX1Hb11FX5MbIyGbSAgABvnQCAAN8cAA==
Date: Thu, 22 Aug 2024 15:18:56 +0000
Message-ID: <F07C319B-2B87-4C5C-850C-4B68C57AA6D6@oracle.com>
References: <20240819181750.70570-1-snitzer@kernel.org>
 <9dc7ec9b3d8a9a722046be2626b2d05fa714c8e6.camel@kernel.org>
 <ZsabuLQPj4BJzYqF@kernel.org>
In-Reply-To: <ZsabuLQPj4BJzYqF@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|LV3PR10MB7723:EE_
x-ms-office365-filtering-correlation-id: 57b0f083-5718-45c4-02fe-08dcc2bdbdd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MkJxSjZTV3NtYXFkNHhEVVREN0JuLzkvREtrbVo1K1dBYTRUUVUrRHRJTzZt?=
 =?utf-8?B?THFlTHFHZTZVRzlTaVk0LzZUOWdVZnhRWEtpY1hyRGV2MEZFeE1nTG1wT0Jy?=
 =?utf-8?B?QW1xL04zOXVxcHRmSkRDbHZJMUhjdVZxRHIvQ0RWdERpa28weDV2TEpHcGw5?=
 =?utf-8?B?eC92SjlQUDA1LzZSWVVUNDBmQTZITnY5cnlyR2lhbEZucW1jS1Q0UWhJM0FU?=
 =?utf-8?B?WWhIYWt0OGo2K0Q1a3ZWMFJoSDdtN2lRbXovR3FjMndFWm5VK2RCTHlwZHZ1?=
 =?utf-8?B?RGJFNzZwbWlmdnpmaXc2d2I1UVJuajFROFR4UnZHUVJNZXdReHlYaUY4RG5z?=
 =?utf-8?B?bnJjd0xvTkFIQWppM2FoaFJ2OVBPNDcySDV0VEs0RldudFNSSk1QWXpSeU9m?=
 =?utf-8?B?VnZVM2trVDFWYnBwWmNpN3pleTdFOCtEN1RNOW9LdFgzV08vMm1NeG9GVFZm?=
 =?utf-8?B?cmVucU13Y0VYVWU5NEYzaGhjdVFIaHdmR3Z1R3BNK3o0TVQ3aDJGRXBncXI2?=
 =?utf-8?B?K1hsRU4xb0ZqK2RsUXFlTklmcVNzNDlDSjBpUFhLM2ZIQmdGa2lBS1BwNTBK?=
 =?utf-8?B?bUhCR05pVDdLcnRpaml4MnB3Y2pJTURQTllYMlVVN2JOTnFidnQ4TVQrTDZq?=
 =?utf-8?B?TUhlSjJkMWxsL1BkS0R6cXBmcFphaSs2SS9ZMXhyWDU3Y0JvbTBydzFka0pr?=
 =?utf-8?B?aFBpZnRNc3lqR3JtSG5MR3hKZGVUVHYzMmFCV1lmZTQ0VjdyS3ZVc1hMRkcx?=
 =?utf-8?B?ZGVuZUpPK2F0SjRtVXZkTWFHVnk3dGJqSGQ2SGtsZVNvS1NVMlRNY25mWU15?=
 =?utf-8?B?cm05TXhVWXh0ZkJYYW1OZGZNV0xQSkw3NE9vN2k2aTNGeXYwTGtnZmtJcE5D?=
 =?utf-8?B?TzVwZ1ZsanNUdzAvWnlJMmwzYnV1aVFZV0xPaFNIbHVMMmN0bHJQRlNJZ1Mw?=
 =?utf-8?B?UGNFcGtqT2lySnB6a05uRzdxeFJoeGxqNm1sMnViTmVmY1lXSUtGaWZ1cUFK?=
 =?utf-8?B?a2dha2d1NjhDRnJhVFN2dFNyN1czeGxEYVFFYVhER0h2Ukk0R3AxTkJ5dDFP?=
 =?utf-8?B?SzE1SWlSa1BUanJnL3h0bC9Da2t3ZTNKRmNyamIrNWRiKzB1UW9aUzlPdWtt?=
 =?utf-8?B?WFFQY1ZIbXNxMDhZZTk1M09NV0I1WGlBT0JsVE4vS1FVS1hEN3h0MWM2eExa?=
 =?utf-8?B?U3NpbGlLdUtON2FRSTl4NFVxSEpNNmdMZVVvL3JqdDBITGxjM2tEUGxvbEd0?=
 =?utf-8?B?RnRVeU5IeWZHWG9zK2lDdnZKS3VEN2l5dTc3UURHV3ZhWXppQW1sVWtqQk8x?=
 =?utf-8?B?ZStHdEJQRTYrTit3RDZ2ejBCd0ticlRtd0phZlFQOXd6ejFSSHJ3Lzg2MXU4?=
 =?utf-8?B?QW92bVpXYURjdSs5YlZpcUtibWRSbDVNbXBwUkpKOWFST0pUZituamhqYnNj?=
 =?utf-8?B?c3BvdVFIOExxbENPbkN3K1dnZHVsM0FiQ2s4SFhPN2dkY3NQUTFSZHJ4VXlo?=
 =?utf-8?B?Sm43ZmtQbENaTEh3QmhmRnVrUEhTc3ZCS0RhZW1WUkloMHA4ZWVQbE1FSVJj?=
 =?utf-8?B?WXk0Y2tESWt5dWVQRjJUMUJybXVUWFRlRTBlQzJNRkJZZ2NRdC94NkJiVGU5?=
 =?utf-8?B?WWN3VEhRR1k3dDIzbXBpVmdCT1E2WUg1MEMzZzV6TCtWRlBVaDRJV1dyNTB2?=
 =?utf-8?B?bEJibVB0VTdsUlYvckUzZUM2RXZxU01iK0FybUtXU21UQUVHd0VUWi93K01p?=
 =?utf-8?B?em85UWxhUU1NYWUyM0Fpb2ZUUUwxVXVMejE0V2xFRSsvRTNQaERWa1VVb1dZ?=
 =?utf-8?B?L3hlWHkrQmlRVDY1dHprOC9WcS9Xd1JLeUQ4cU83UzNkdWlWK2hTUHEzTk5I?=
 =?utf-8?B?ZXRMVG13MzJ6VzcwWHpGbGtCQXZvdU4xWXBXOW54R203R3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dG11bFhOK1M3OUxRUml5d0NRK2hnK1JieXJtYXdSUWZtT09xTE04VjBESW9J?=
 =?utf-8?B?YmxPQ3dmMEVibldCc3RCU0t1a2xIMEJLMVZ5ZjgvQklBcVZOR1RCYit1VnRD?=
 =?utf-8?B?MU9SKzE1a0JEcG5MYmNQNnF4NUdJRFhxV1h3Q0J5ZmpubkpaQVF6OHdIczE5?=
 =?utf-8?B?Z2VocmtIRXZOeko2R2MwQVFSS0Y1U2taOEhTUW4vaVRiaGgraUJlWnZDeXBu?=
 =?utf-8?B?SVZqTnowZ2p6bzVtQkxjb01NS21nUnczck9NVEw5eE1JY0Y4eGxLZ3JBT1ZW?=
 =?utf-8?B?R2w1eGNoYitZd3pLWG8zNzJUUFpTdGV6L25Dd1NreWxWY1RUTHZkSFY1T0dw?=
 =?utf-8?B?Q0RPazJERG9rc08rWUtaaUIvYXJlSFVyOHBzeGo2K2VSajVkN3JKaEM4aGRV?=
 =?utf-8?B?c0xqR3RFZ29rVHhremdsZTltQ3BkVmJXeTFVTVhZTDJoLzJuV3BLT0NyTXQ3?=
 =?utf-8?B?aGRyYXpyWEs0dHpVUHVoeWs1a2p4MXZTU1Q0ODRvQ09lMnNKNE52aE90TUlO?=
 =?utf-8?B?NnZKeCtiZDkxcElyeXFjVThOTElvSHhDU2lPYk9SV0NseFlCNk9LQ2lpRjZ2?=
 =?utf-8?B?ZDlhZTdpRFVKK1hTeEdQOGFHKzFIVk0zdFVRT3l1UGhWdjVmUlBFOWg1Mm16?=
 =?utf-8?B?d292SlFCNnk4enJQeTg0SkMxekl3Nm0wdXR6SVJ3am9lK0U1WjU5WSs5aUd6?=
 =?utf-8?B?c01PT05vUmorQ2RGamVDcmdJRlhxK0VXeXNzQTgyUkdVd1FEaVo3NiszWkhU?=
 =?utf-8?B?dktBM1haOEVkR0xBQVNEdStxY1MrZ00yNi9Jd2VjYi9DQkVIVG1vbXdrbFNO?=
 =?utf-8?B?Umg1YUhVUWpkWWlTWGVyZ1NqUVZxcjNJeFRUZm9SbUYvNEU1QlptLzJ1MXFY?=
 =?utf-8?B?RXRyTUl2Z3JTTWlzUEFudFVsdDJoUGhiNm42QmlSK0tGYmZ6QS9MUmQ0anFw?=
 =?utf-8?B?SmV3aFBCczVFK3BOQXBydU91bWQvRSs4dmo2RGFsc2cxSjEwMU1jR24wVlcx?=
 =?utf-8?B?YVFKemlEV1BzYlMyRzV0TkZBWDZjdVdDd2FuU09hbTlOblRRZHpkQ0pvYWRJ?=
 =?utf-8?B?VlF1bGYvZnNocG0yZTdodWJZQ1ZjWXlHVWR0alVaVDVCbUFHaEFxSzg3MzNm?=
 =?utf-8?B?bUVtWHFrUWRNaXo1enVzemZFSDBuc1d5cXBvQVo0bEZMWlkyT3N3dGhxSnVQ?=
 =?utf-8?B?L3hrRGU0MS9Qc2NlRXVzVUZ4cUFpaGlNYXVTR3FweTRVSVkrUFdJOHBhckxy?=
 =?utf-8?B?dnRLZmpVemZSSDU2eXplTG8yQ3Ezbk41ZHBIYlFtNmtqNkxqbm5DQVpSd2xX?=
 =?utf-8?B?bHgwcjhXcU8waHluZ2ZMZlcwc1FNUzlwUERkamJLb0xhUC9JWEV6UlBGd3A5?=
 =?utf-8?B?V2dTalpwMFovZ0ZHQkZzMzRCMkovakdqTDBVelVZelBCNFYrOXdzUHNpMGZ6?=
 =?utf-8?B?Q1VJWWk0Q1dGZVFuU3RNaHkwZnFsVkl5dlY1VFBCWWtWdXpqSG1pYUNQcXkz?=
 =?utf-8?B?Nmd3V1VjZVlsMTNEN1RLZ0toZGpWNmVWYmRvOFYralZvVzZuWUFkVjRQNnhU?=
 =?utf-8?B?eCtrVHlNVUh3clRVM3EycXFlVi9aWlpzUklhdmd2cFh2M01lWDRHeERnS0pI?=
 =?utf-8?B?YlVnbHBib00xekxUallGMmxBVncvT0thQm4yV3N5czZLMTlzemlUTTY1S1BB?=
 =?utf-8?B?Tkk3T2hMeFlTTm1CdlkzQVFmdkNMRTIwM2E2SWc3a1FNWFZJTGJqeXpzR0Q1?=
 =?utf-8?B?M05Pb0JUOE1hMWN5M2N5ZkRmRHBQK3g5QzdOOFVoRWJmMzEyaVFDSEpENktt?=
 =?utf-8?B?KzdZNkI5MThTTjhjMzkrMmlJYmRJUFl1bmZTR2tvZERhNlk0bWVTbmMzL2dY?=
 =?utf-8?B?bjB6c28yZjZaMGRHU1BTTlJTYmFNWjE5QjhQdmNPTjRmMVVhdm90NENBNHZr?=
 =?utf-8?B?VVIvbWV6MnVHbDdxcmxaQjVyQ3dXZHhUVW1lR2ZkT2w5dEJGelkzaXkyOGM4?=
 =?utf-8?B?aGlObjFHdEd4ZWI0UFZERmx2aVc5U0xrRENlZ1Y1dW5adGdvR0VLOGR2aUV4?=
 =?utf-8?B?dHVCVGRFYWo1YjI0b2Zua2dPeTRURXFsVXhNcnJEandjS2kyUStJclJnMEM1?=
 =?utf-8?B?WTM1VE5abVV4Ulo5VXJkREdGMVJzZXdwcm1EWk1IdjFtT0NWZmYrY3Nhb1N1?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <059511D03197E54D808B21DB8E6BF329@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z9OZqEt74P4UWL2T3XX1BpeFhLrZcTT7j1Hixmd++ShQHxldllxRJmigKcWPduO/GM+DmKO77uh8g6HwS9YFL1IRGyNlQN1GCjpZn8+c9PmUmHOJa2YX5ykEmUtx6Lvc2eogT7hg9NUC3RE884XDogVR6w4Nqe+gj/GCZ7L9K3NWq6c/AyCTutNcaIkpwuUo7VxChezzF/0sGES2PCTb6T9LqEus7XMSf4WZyykeb69/EbvHpxqAwECFGUrQfLpzrJm3nsRzFMEiQbJ+54akSerlIttQxnGwSG9qRCeOM6LunE48IZ0RI0TrupTA7BcU+SdVjHc6HIFPGys5RLsmw69HRKX/WWRuTCQS3JdbPB1ILG9OvZWT957yZEYQSeavKCZYx58UAWXivSN1YDNJOB9VlrkEpiwX5EiT9alp1sMkNfyQTBeCj+xES5cEl3NY5fN2pjApPNEKQZ08F3jG6DToYXq88kQhWD+WyqU7HF08PWnF1CA26hhWpEIF93dkFfpX4mrtonhyoV35dpWmoy8KAoI6btdC5woU9npbTA4QnwasYeIUobXv2lH9budvhsVBVwfUL+jtsSWqEJkEX31Srz45+VGqhLIaiyb0cwM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b0f083-5718-45c4-02fe-08dcc2bdbdd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 15:18:56.8703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uYLAVGdjWaWWjcu1M0jHYa3pmV+6LkXwhgMd8X3qCoNwfrrw1uceCMwBbZRSXpeK1WzKKKeEu+equTCQ+6Q9Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7723
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_08,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408220115
X-Proofpoint-ORIG-GUID: 6-sCmw_JPDuUJjoPQEePse0EOBO3IRz5
X-Proofpoint-GUID: 6-sCmw_JPDuUJjoPQEePse0EOBO3IRz5

DQoNCj4gT24gQXVnIDIxLCAyMDI0LCBhdCAxMDowMOKAr1BNLCBNaWtlIFNuaXR6ZXIgPHNuaXR6
ZXJAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBIZXkgSmVmZiwNCj4gDQo+IE9uIFdlZCwgQXVn
IDIxLCAyMDI0IGF0IDAzOjIwOjU1UE0gLTA0MDAsIEplZmYgTGF5dG9uIHdyb3RlOg0KPj4gDQo+
PiBUaGlzIGxvb2tzIG11Y2ggaW1wcm92ZWQuIEkgZGlkbid0IHNlZSBhbnl0aGluZyB0aGF0IHN0
b29kIG91dCBhdCBtZSBhcw0KPj4gYmVpbmcgcHJvYmxlbWF0aWMgY29kZS13aXNlIHdpdGggdGhl
IGRlc2lnbiBvciBmaW5hbCBwcm9kdWN0LCBhc2lkZQ0KPj4gZnJvbSBhIGNvdXBsZSBvZiBtaW5v
ciB0aGluZ3MuDQo+IA0KPiBCVFcsIHRoYW5rcyBmb3IgdGhpcyBmZWVkYmFjaywgbXVjaCBhcHBy
ZWNpYXRlZCENCj4gDQo+PiBCdXQuLi50aGlzIHBhdGNoc2V0IGlzIGhhcmQgdG8gcmV2aWV3LiBN
eSBtYWluIGdyaXBlIGlzIHRoYXQgdGhlcmUgaXMgYQ0KPj4gbG90IG9mICJjaHVybiIgLS0gcGxh
Y2VzIHdoZXJlIHlvdSBhZGQgY29kZSwganVzdCB0byByZXdvcmsgaXQgaW4gYSBuZXcNCj4+IHdh
eSBpbiBhIGxhdGVyIHBhdGNoLg0KPj4gDQo+PiBGb3IgaW5zdGFuY2UsIHRoZSBuZnNkX2ZpbGUg
Y29udmVyc2lvbiBzaG91bGQgYmUgaW50ZWdyYXRlZCBpbnRvIHRoZQ0KPj4gbmV3IGluZnJhc3Ry
dWN0dXJlIG11Y2ggZWFybGllciBpbnN0ZWFkIG9mIGhhdmluZyBhIHBhdGNoIHRoYXQgbGF0ZXIN
Cj4+IGRvZXMgdGhhdCBjb252ZXJzaW9uLiBUaG9zZSBraW5kcyBleHRyYW5lb3VzIGNoYW5nZXMg
bWFrZSB0aGlzIG11Y2gNCj4+IGhhcmRlciB0byByZXZpZXcgdGhhbiBpdCB3b3VsZCBiZSBpZiB0
aGlzIHdlcmUgZG9uZSBpbiBhIHdheSB0aGF0DQo+PiBhdm9pZGVkIHRoYXQgY2h1cm4uDQo+IA0K
PiBJIHRoaW5rIEkndmUgYWRkcmVzc2VkIGFsbCB5b3VyIHYxMiByZXZpZXcgY29tbWVudHMgZnJv
bSBlYXJsaWVyDQo+IHRvZGF5LiAgSSd2ZSBwdXNoZWQgdGhlIG5ldyBzZXJpZXMgb3V0IHRvIG15
IGdpdCByZXBvIGhlcmU6DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L3NuaXR6ZXIvbGludXguZ2l0L2xvZy8/aD1uZnMtbG9jYWxpby1mb3ItbmV4dA0K
PiANCj4gTm8gY29kZSBjaGFuZ2VzLCBwdXJlbHkgYSBidW5jaCBvZiByZWJhc2luZyB0byBjbGVh
biB1cCBsaWtlIHlvdQ0KPiBzdWdnZXN0ZWQuICBPbmx5IG91dHN0YW5kaW5nIHRoaW5nIGlzIHRo
ZSBuZnNkIHRyYWNlcG9pbnRzIGhhbmRsaW5nIG9mDQo+IE5VTEwgcnFzdHAgKHdvdWxkIGxpa2Ug
dG8gZ2V0IENodWNrJ3MgZXhwZXJ0IGZlZWRiYWNrIG9uIHRoYXQgcG9pbnQpLg0KPiANCj4gUGxl
YXNlIGZlZWwgZnJlZSB0byBoYXZlIGEgbG9vayBhdCBteSBicmFuY2ggd2hpbGUgSSB3YWl0IGZv
ciBhbnkNCj4gb3RoZXIgdjEyIGZlZWRiYWNrIGZyb20gQ2h1Y2sgYW5kL29yIG90aGVycyBiZWZv
cmUgSSBzZW5kIG91dCB2MTMuDQo+IEknZCBsaWtlIHRvIGF2b2lkIHNwYW1taW5nIHRoZSBsaXN0
IGxpa2UgSSBkaWQgaW4gdGhlIHBhc3QgOykNCg0KV2FzIGxvb2tpbmcgZm9yIGFuIGFwcHJvcHJp
YXRlIHBsYWNlIHRvIHJlcGx5IHdpdGggdGhpcyBxdWVzdGlvbiwNCmJ1dCBkaWRuJ3Qgc2VlIG9u
ZS4gU28gaGVyZSBnb2VzOg0KDQpPbmUgb2YgdGhlIGlzc3VlcyBOZWlsIG1lbnRpb25lZCB3YXMg
ZGVhbGluZyB3aXRoIHRoZSBjYXNlIHdoZXJlDQphIHNlcnZlciBmaWxlIHN5c3RlbSBpcyB1bmV4
cG9ydGVkIGFuZCBwZXJoYXBzIHVubW91bnRlZCB3aGlsZQ0KdGhlcmUgaXMgTE9DQUxJTyBvbmdv
aW5nLg0KDQpDYW4geW91IGRlc2NyaWJlIHdoYXQgdGhlIGNsaWVudCBhbmQgYXBwbGljYXRpb24g
c2VlIGluIHRoaXMNCmNhc2U/IERvIHlvdSBoYXZlIHRlc3QgY2FzZXMgZm9yIHRoaXMgc2NlbmFy
aW8/IE9idmlvdXNseSB3ZQ0KZG9uJ3Qgd2FudCBhIGNyYXNoIG9yIGRlYWRsb2NrLCBidXQgSSB3
b3VsZCBndWVzcyB0aGUNCmNsaWVudC9hcHAgc2hvdWxkIGJlaGF2ZSBqdXN0IGxpa2UgcmVtb3Rl
IE5GU3YzIC0tIHRoZXJlLCB0aGUNCnNlcnZlciByZXR1cm5zIEVTVEFMRSBvbiBhIFJFQUQgb3Ig
V1JJVEUsIGFuZCByZWFkKDIpIG9yIHdyaXRlKDIpDQpvbiB0aGUgY2xpZW50IHJldHVybnMgRUlP
LiBJZSwgYmVoYXZpb3Igc2hvdWxkIGJlIGRldGVybWluaXN0aWMuDQoNCg0KLS0NCkNodWNrIExl
dmVyDQoNCg0K

