Return-Path: <linux-fsdevel+bounces-21506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0DC904C04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 08:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87869B20E01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 06:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB7A16B753;
	Wed, 12 Jun 2024 06:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oFWkLFDK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hgfB83iJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380DE12B170;
	Wed, 12 Jun 2024 06:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718175371; cv=fail; b=cOrmv+oXEwQzU6ALQm1XNxy+WkpHB5KdpVQ4thtmYE3twGN+ukA2sYfkdmDmdZVFpgO4NNkIAcRX1MW8HdU2Ga5XFjFvxo+JZJzDDRMV83ROtRQbcJT+WeTFJQJHroWEcrWRjyy9tBTXPzz6uEisLZz/evJMIgWHZtjUbfIA/KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718175371; c=relaxed/simple;
	bh=MbvVVv8NM1xC76Mo0LUbWr4AWypDLtKqcQOC+Cvx1Tg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pEJcAgCyBFMEgWyNUJR7PNvyhcDyxdFFHru6INxWKULYLNSP8w8z/Ar/OGulNs2SBtS5ItyezNXF6ECYyRhN4VTi0lj8Ub0DU9eEI/33NZlBtRCgGsxmvnq3rFVmlEIMcyxYIfSBnDL9dUXD6+9ql8Jw3WWSurakCGoSu+PKL5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oFWkLFDK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hgfB83iJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C1tQNj012353;
	Wed, 12 Jun 2024 06:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=ZOOrxM44mDH08eyCUAcowONNr11STiq8tlkmV5IqHqI=; b=
	oFWkLFDKDU19jZlDt2DWfLv4IdkMNtSOwDd8ltSOW+VMoYBKWoEZaeyroJQgILHh
	J31QlrI/wu4PZeuxpUmBssogKj1RaGNIF/JNUNWHE6lviEaXrXtiz3ZcwoZfAkwR
	NJpLyLj1dMFEB+hS9t9XRLi/pAuy8rArvnRofHrih8NAtDAAx9BcJgB01wdk00hA
	52NjSiOUUfbc/o5bzCKwIGJaKrQkUbltkol6xtt8FgWWDr/SAs3IIbVYPFKNZDK4
	YsbfEkVtH/460QaEEBB80xNHIkolT5AZjL2FVL15sMhGA02GawFWv1/8mCf9icoW
	RL9Sg+HbqyzDEsOxAkPvaQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh7dpg9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 06:55:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45C6eBA3036661;
	Wed, 12 Jun 2024 06:55:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncdxbs2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 06:55:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvgFuJuDHNx62TzH5c+nW7Im1MYP3zgJgrVXmr4dqg7HgXx7C9FN7HDDEFH5ks8I0l28tfU/jEDGei4TOHKSW3mrPMjepcukEIB24X48DpeKlO5VUlUSNiJA4kU+kVyXzMqK4B32QGIq1g83Z5vwVHuKYrmIIEMN24qx0ml8mRAKZA1aSiH88TRy95aJmMJdgPUih5S5TYOthgML7speSCoLaOQT25TOuDHNE8Qm8RpdP5DT1ZOJ33dACbhdmvT/onbLhryiDYS8fTFLUsNH280vl3r6UwdehoZXp7+KZft5wxvnoAln9VEClyig2SZbXZKZ+ZiIKzV9+HspxHgrhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOOrxM44mDH08eyCUAcowONNr11STiq8tlkmV5IqHqI=;
 b=IVkKsRk5G8WTlMmd0PrTWtQ2FAfpkCV+T6B4OBmMRaNvRqUJxafVDQ56KvRwK/QNpzQbl2lltd9ltJIzekyQ2XuVjSiRkEYjTvEI6QiuYHfq99G0s/2t80UnroqYfrzHfIkqwFNFGAu1vpVGk99aD9NDqKSIEXPHXQ0bKvg9g/ylcAdC7G5LP+NZYqoAg8rN1eij8ajtdPtznWtZYuNeRO0TE2ljQjzyMF7e5oJK4RjfVObuY9Y5fhzvk+7i33VU8x4EHl/JlZgedSHVfYJhUiUM7NhPhL+WjKojSAxdxzdnvv465ViNuAdxFp9Z7fkDOJmP+Tlu89JBdv+ZFNn3yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOOrxM44mDH08eyCUAcowONNr11STiq8tlkmV5IqHqI=;
 b=hgfB83iJ6/V5tCvoZHBdGvBUgJ/hzFW8nf78B2AaWLGfjWGmRmuLOjqQvnQhGA/GZcryjJWxQszdqMQCK60bYhv6fsk1AT4cxpRX3C/7T/djHQaKNAZsr1NxgQFvr3tnBADdLM2Ajj6+ax5Z0lgvNyIxEN+hn3aSgtwapufw0JA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB7814.namprd10.prod.outlook.com (2603:10b6:806:3a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 06:55:39 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 06:55:39 +0000
Message-ID: <82269717-ab49-4a02-aaad-e25a01f15768@oracle.com>
Date: Wed, 12 Jun 2024 07:55:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/21] xfs: Introduce FORCEALIGN inode flag
To: Long Li <leo.lilong@huawei.com>, david@fromorbit.com, djwong@kernel.org,
        hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        chandan.babu@oracle.com, willy@infradead.org
Cc: axboe@kernel.dk, martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com, mcgrof@kernel.org,
        p.raghav@samsung.com, linux-xfs@vger.kernel.org,
        catherine.hoang@oracle.com
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-9-john.g.garry@oracle.com>
 <20240612021058.GA729527@ceph-admin>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240612021058.GA729527@ceph-admin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0418.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: 65329672-6d43-4cc2-4eb2-08dc8aacab2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|7416006|366008|1800799016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eFBneWRPNVdKWkNIeWFQUTBzNkpFTG9rOW9leXA1d3gwalhrQ0hDRXRkUTRK?=
 =?utf-8?B?Wmp0Z3JyVWZMeDQyckQvcS9ZTlN4NjlKVUxJeEpTaDJFMjFIa2dtNVhYcjFr?=
 =?utf-8?B?SDJrSEhrejNIODhYNis4OXBKZ0dhT2FwRjhqM2VaVzRwUDRXM1JlZ2NwSHMv?=
 =?utf-8?B?Nk5xK1VpUkQ0cDBxMnBZTFpYZUY0OUtDRnFUazAwZ2FIbnFkRkQ2VmNmNDNi?=
 =?utf-8?B?bUg3WExiQjl6SlQrL2MxWFlJUDZnckduekVHMmJueGU4UEcvbVFvMHA2SER4?=
 =?utf-8?B?b0lZQVFmRUxWRVpyUGZzK2hYblgxVXgydEdJMWRKRG4vWmprNDdXL213bEpw?=
 =?utf-8?B?eTRRNTV4S2FFdkcvc3Ezeng3R0srVEF4aktmdUxCekJJZURYZlM1UVdjbnpV?=
 =?utf-8?B?ZTQ4S2JTdmhaMXZEZDg4OHhvU3JiMytIZFB6OUYyNk5SUjhHQWpOdTdLbUhG?=
 =?utf-8?B?cUtuV2FzLzRKNGlLS0NBcGp2TTRUZ1Zud2diM3I4aDB2elVDOE02QzU0UFBk?=
 =?utf-8?B?MVY5eVVaNnVNRDdXbXNEOFdJQU1rWmxCd2ROVlF1WEp3aSt3STFDaVJDcll3?=
 =?utf-8?B?RHFUUUsvZTlrcmtmMVdKZjdKNGtjTjc2QWRKMGI2eTB3M01GTFY2WnRCYkRH?=
 =?utf-8?B?enZ6Wkx5b0paZVJOV0JwWXVhbkJZbWdHSXQvSkhiOTgzWklmdnBJV1NnM1A5?=
 =?utf-8?B?MEMwVXFvaGFSMHNPZUVIUGRmanZhbTVqcjd4RVNKREU4ZEhsbkgwLysyYkZP?=
 =?utf-8?B?YWVTTnpUWWFzRjk4YmZSTWdQMkxnRXQ3eG9QbHp0c0Q2UG1FSmFhZlpSVC9s?=
 =?utf-8?B?VTduZzljb0VFV3FzeUdHVmVPdE95dzZwVlJ4S0pRdWw4TDFkRldlUVJIZnE3?=
 =?utf-8?B?R2wxRTFCNDlQVnBjRThvK0dPM3plbElyL2V4RXQ2TjJ6V0dEM3Q4YXliaDdU?=
 =?utf-8?B?d1VRSmxaWmU2NFhjVnE0ZkNDZkM2Q1ROL1VWYmJzRitPMlFKTjluWCtsZ0Zl?=
 =?utf-8?B?V0hGMVdGSnpxZGNQekNFemtRRXV4WVkrOTdPSiswcHVzWWlab0w3VlVrd2o3?=
 =?utf-8?B?WEN6c1N2VG1sQVA2MVhGdGpYMzRzcWxPNmgxcVZnRTkrdlJzMkNjVWM2ZENK?=
 =?utf-8?B?eDJtWmZwdWhsSldIOVg0aGVSaG9OT3FlUkdsTHFHWlYreXVHaXc4RGwrc1hG?=
 =?utf-8?B?TTFnZU8zSWNvZzcycDg4RzR6ZUd5UW5HQ2RNUS9CSU13REZFQ3NxZEZDQU4r?=
 =?utf-8?B?M05RMWVIdzBHZ0dwd2htanBzTGYzVUtscXF2Sk9BRElEZVBtZllWd3BONnBE?=
 =?utf-8?B?VnpsU08rbFR3MU0yK2VlUkM3VXg3OU51d2tYbHlGcWhtMHdnZHJQREptcndi?=
 =?utf-8?B?Mk5kR2tYS09PeCtObERzbm5BZURUQlJNSXNjWVFkeWZndUY4TytIRXRUbFRr?=
 =?utf-8?B?c0FKZTlUWDI0UWZydjFLRXR1SENhY2RPdmFOZ21KNVUyemt6eEpVZUlWSVFT?=
 =?utf-8?B?eFBxajN2RjJxRjVJQ1ZmMXpxeTI5UTAxNk1JMXJseUpCK1RVS0dQK2xLU0ZJ?=
 =?utf-8?B?bnU3UUpIdkVGQ0hITE0vMFM4VlB6Y1hUVnR3am8weTFwd2FTUlY0VEpUdmpx?=
 =?utf-8?B?b2JuN2tXaklQV3JRZVU5TlF6cmFPSmp5eWtwWndEeVR0bURUU0xKeHdPR2w5?=
 =?utf-8?B?bWRLSTA5aXZDNE51alpkY3NoMldwVUdTZDhZS0x3dkxpQlVOREtHTHZBWlhs?=
 =?utf-8?Q?Nv5q5BcJ7kU/D/ri8HJMXiu5HzDzAtpME1YLv5t?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(7416006)(366008)(1800799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q1BxQmRXUWc1T3Zzc2pHdlhZMFFJdU5iSWhlbnZuZnFGbVB0dWxtOWdZWWRz?=
 =?utf-8?B?TWd6VWdyL1lHVlNHVDRCbll5RXpIbnByQmlXamtSeS9UNnI1Y0Y1OHhTZnpP?=
 =?utf-8?B?SzNpWDdjMFRoVm0wT1JkVTREaURhSkJmVjN3VXo1QytzWG80OUd3UHFkR1Ex?=
 =?utf-8?B?aG5TRU41R2Z5dzlwaGtIUzB2dlA4dzlia2I3cGhVaHpkaHh4bU9Ga2NhTGxk?=
 =?utf-8?B?dDVGS1lhM3kwbGFQQnUzM1lrYzRCUG9HWkNzb3gxM1RLNjJyckl2VHlBd2Vi?=
 =?utf-8?B?RVBSSHdydDFHa3k5UCtadHhFYlBLd3J1dHp5RVlsaWpMdngrOVpIM2VPZ0dQ?=
 =?utf-8?B?S2lUb3lRSWdjZ0hobk9iekNXMkNEUVA5ckh2azljeVFnd2wvOWc3KzZsVXIr?=
 =?utf-8?B?Vlp3WVAzN1VYODdtTW1zODIzMW03UjdIWXJ2UGNiZzg1R1lxdVFCczBna2Ri?=
 =?utf-8?B?ckEzSUlJR2plRVJwbGpoMWtGNC9weHhSNTJOREN2TjhYU0FCdjJkRzV5UjhZ?=
 =?utf-8?B?TFUvRmpKWTlOSDM0WTNSZlhQR0RWQ1F2NDJKOUZsTzgvQXBFNUVhU2RYeHBs?=
 =?utf-8?B?eUdpQ2pNQUgyME53WG01WVMwYUVESlNwbldIQk5IWm4zbGliZHEvRThLMkFp?=
 =?utf-8?B?U2I0R0VaejlDTTdUZFNHbFI0NTZMdlNRTTRub1lzTXZPdkR5aE5OaTY4YTg2?=
 =?utf-8?B?Tm4wdDB0aVNsQTBoRlpMMEhIa0hQdWJzL2taamNydXEwTVNLZzdkUGMvUllT?=
 =?utf-8?B?ZkRJWGtHejZjMktBU1FNN2tIQW14ZGFSd0VxdHZxTnlKS2NaNGhJM01kZ2RB?=
 =?utf-8?B?Vm5GWGtwS0tyZ3Vjcm13NEFkVW1kMlc5a2V0aSttd3RSaE5laTBNZGVnSkE5?=
 =?utf-8?B?MjZXVEpLNHpUSE9LSCtUWm1lcndVcFU1YXNGZTVXcTZVT0ZTUlZ6R0dTb0po?=
 =?utf-8?B?clJSYlBnbkROL3U4RnRGWkdjZElCOGU1TzZCd3VPNWc3TFIzdnhCTllkd2VG?=
 =?utf-8?B?WjExOTNVS2pYRVVFNm9aYkdiRnBBWlpicDVlUnJxKzE1Q2xUOFkwQ3BuakI5?=
 =?utf-8?B?Y2lScjhKYkF5UGQrYTJGNzBIMUh2NGc1bS95Nkh0M3RWaElVNmI3cTFRSEdX?=
 =?utf-8?B?T0VFMzdLbG10TlBjUkxhaWU3NDNDTjhMMTJHaU53YnhGamZnYkpETVJOdWJE?=
 =?utf-8?B?UDZPOEFmd3UvL1ZLWGZJNG15WUhtaTZPbkFzMTVhRW5lb050MU9QMUZxUnFh?=
 =?utf-8?B?SnJCN0R5dFVxZmVrNEw5TytrMXhRSmUyMnRHbWtSak9hWGJrZkJ5ZU9zWEpr?=
 =?utf-8?B?NVR5U0hRR0RaWDRsMzhoVWs1NU85ZUIzQWlJVEpJclFLQ2JNOWdxUWFoZnk1?=
 =?utf-8?B?SjRac2p4NUlQR091MU1NazFKbWw4TjE2MnEwRE9rSDBUZmZRTVRIWHBNbkFi?=
 =?utf-8?B?cjU2UGxucjNjYU1SWE1Eem9QVUVDWDlDY3RReEI5aGdDVXMyUmEzdUEva0lt?=
 =?utf-8?B?KzJmM2RXOFFNQUUvcmQ3RFZmRDU1MzkrWkZLcWJaZFZBV0RubVdEeldMRzdT?=
 =?utf-8?B?OEJwWFN4VjhkNlNTcWFobGdFaER3VS9seUZJOWYxek9NVmFCNXdpMjZSNjR3?=
 =?utf-8?B?UE5YRzR0QlUrMTdzYkJxVkpZeHRxMFhZNjZxNmorNWNHa0VoMEpmcE0vODhU?=
 =?utf-8?B?aGZFQUY0UEh5eHQwTWFhZDg0eUUxNnk5N2pma0VIa2oyVnhtNVdyek5uWHRj?=
 =?utf-8?B?R3h6OEo4TXc0c2liZ1hsWVAwcG9iTUZnUXdldFhkSjFBNzNlVjZ5M2RJbVNa?=
 =?utf-8?B?QnlWbXN1aVVOdWNEcVNzNkprZVJ4OVRtVXdrbDJ5SlY4dklNd1hydzhiS3BI?=
 =?utf-8?B?cVlSaHQ5K05wc1AzekZFbnlFRDQ5NEZpWWs2QTdMUTdyekFsZlR1KzJJVjZQ?=
 =?utf-8?B?bkpUZG01ZjF2TUZ0eUd3OG5JSlhxelhnbDJ4bGRDR3Qwa3p3cno5ZFBwQytt?=
 =?utf-8?B?WkxrV3E2Q2t5bG1JWFFIMHpuTHhGbWhWTUE1YWhwMnpWbzdXVWkwdlF5SXBJ?=
 =?utf-8?B?WHJ3ZzdDdnJlTGdpdXpDdGxEckZ0Q29EUHBpTldHQWltb3ZUcVdKVEtaSzIw?=
 =?utf-8?Q?0ucjAZwnF4h1y4QizsxN1S/tN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IGlUE1afmpFl+8U0trItYDc6OA0BnUUG5nWGlTo9bKl5oAF7yTWN9z/W6RJ47n/SG0ieUPWZl5iht2NLWp7Cbj+tincGr3spol0LDEp9iJ1cjYSslrVz7lgmGMUeZ0MZgVuzw80ATkn6LUuFU8JViY/1xtjAkdUxYKONk3a7Hxk/I0RVtDf3XUkqE+dc/VFCgz4z7IXBowa6mRYrsX81RW3KVMCmQIOOYMNf6hkYARCqpZuh7fste7jUL5GWAW59bkpaQ3JNrPS9kIU4wDNvjHzM+wCtD6Z3Gr69P1Dn3cEZVQVPImT3eA6SXhcewFsLjBlnz3iPg3icgTssbCDJZT0G131TiQmkN+DFNCXPdn+bddQ1bk/Zs8yHp8CH2xSGw1+UUUesburNN25f4l+eAWcnHtLv4fmQugQmQ22a0KWWWYvJ/xtqLDsWkR0TD11LAH48xPVljQ8DZP/KAob5EhvFnsfXDqjhZyUKbXE8hiy5v4QpboH2OHn3/I883SyqBOqm7Zvz2pwR2odVjHzFezl1pMAikUbRrTPZOgjR7t19j0Qat/tFiCGZ/9+DdoO3zSahMFojVwO3572ZK9zkDI9wEJWVl7niu2F2rf4k530=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65329672-6d43-4cc2-4eb2-08dc8aacab2d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 06:55:39.2613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64moRg7xdco8EbH6vnAz5VVbgXf4GL3VsOAZBLTBdnSeNNjOYzZ+YkUsspxhN5Na6jKInZKFgiIpXf3lwntgPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_03,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406120048
X-Proofpoint-GUID: Vbzg51UC_qqaiQJMSe_EjL7nXo47JuHF
X-Proofpoint-ORIG-GUID: Vbzg51UC_qqaiQJMSe_EjL7nXo47JuHF

On 12/06/2024 03:10, Long Li wrote:
> On Mon, Apr 29, 2024 at 05:47:33PM +0000, John Garry wrote:
>> From: "Darrick J. Wong"<djwong@kernel.org>
>>
>> Add a new inode flag to require that all file data extent mappings must
>> be aligned (both the file offset range and the allocated space itself)
>> to the extent size hint.  Having a separate COW extent size hint is no
>> longer allowed.
>>
>> The goal here is to enable sysadmins and users to mandate that all space
>> mappings in a file must have a startoff/blockcount that are aligned to
>> (say) a 2MB alignment and that the startblock/blockcount will follow the
>> same alignment.
>>
>> jpg: Enforce extsize is a power-of-2 and aligned with afgsize + stripe
>>       alignment for forcealign
>> Signed-off-by: "Darrick J. Wong"<djwong@kernel.org>
>> Co-developed-by: John Garry<john.g.garry@oracle.com>
>> Signed-off-by: John Garry<john.g.garry@oracle.com>
>> ---
>>   fs/xfs/libxfs/xfs_format.h    |  6 ++++-
>>   fs/xfs/libxfs/xfs_inode_buf.c | 50 +++++++++++++++++++++++++++++++++++
>>   fs/xfs/libxfs/xfs_inode_buf.h |  3 +++
>>   fs/xfs/libxfs/xfs_sb.c        |  2 ++
>>   fs/xfs/xfs_inode.c            | 12 +++++++++
>>   fs/xfs/xfs_inode.h            |  2 +-
>>   fs/xfs/xfs_ioctl.c            | 34 +++++++++++++++++++++++-
>>   fs/xfs/xfs_mount.h            |  2 ++
>>   fs/xfs/xfs_super.c            |  4 +++
>>   include/uapi/linux/fs.h       |  2 ++
>>   10 files changed, 114 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
>> index 2b2f9050fbfb..4dd295b047f8 100644
>> --- a/fs/xfs/libxfs/xfs_format.h
>> +++ b/fs/xfs/libxfs/xfs_format.h
>> @@ -353,6 +353,7 @@ xfs_sb_has_compat_feature(
>>   #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
>>   #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
>>   #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
>> +#define XFS_SB_FEAT_RO_COMPAT_FORCEALIGN (1 << 30)	/* aligned file data extents */
>   
> Hi, John
> 
> You know I've been using and testing your atomic writes patch series recently,
> and I'm particularly interested in the changes to the on-disk format. I noticed
> that XFS_SB_FEAT_RO_COMPAT_FORCEALIGN uses bit 30 instead of bit 4, which would
> be the next available bit in sequence.
> 
> I'm wondering if using bit 30 is just a temporary solution to avoid conflicts,
> and if the plan is to eventually use bits sequentially, for example, using bit 4?
> I'm looking forward to your explanation.

I really don't know. I'm looking through the history and it has been 
like that this the start of my source control records.

Maybe it was a copy-and-paste error from XFS_FEAT_FORCEALIGN, whose 
value has changed since.

Anyway, I'll ask a bit more internally, and I'll look to change to (1 << 
4) if ok.

Thanks,
John

