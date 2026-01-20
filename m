Return-Path: <linux-fsdevel+bounces-74737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uI7OHFcDcGmUUgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 23:36:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9DC4D0E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 23:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EDD896C50A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 21:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907783AE712;
	Tue, 20 Jan 2026 21:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GuPSdPZN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yu4wC04V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DA42E9EBB;
	Tue, 20 Jan 2026 21:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768944149; cv=fail; b=G9W2SvyFkj65CFNoJmDrVx8qEi3jHqukqY7/JaBXDfvs6/KyAd3OZbMbBFW8rqxUl9jB3fDJZEGQXEwhaebEJW+KmH/Tn+eLlhe2UZ5cB18PmhCXiUUEXAkNG3a3c3YBn1ELr7ibfXtdrucU/VKOGCZ/QkKLDDZsgwTZgROYYok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768944149; c=relaxed/simple;
	bh=S7Tp9E2TKpnERtakZQ/WJeYoAuD8t+oHggheHHT4cgY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jcKsHXNXhbnVXV7wI/tRutcZy0QeqhmSrLTRlAtzKcJsNTs/xRJ4k89zb7VcVvI6rHmqMrmSdHWxN9qFzYHwqQhlejmK8JrkVjGU2cu54VsEUzKaSDANB2rXK1111brGzIsNDt6sd/MJZ40Kz/+ZvW7yayQSigdyPmIxVnu0KhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GuPSdPZN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yu4wC04V; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60KIRhfb3264873;
	Tue, 20 Jan 2026 21:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xnphLD+Jrbh1IyTJTWAjqqVzpue7PvaY+hjodXo6zV0=; b=
	GuPSdPZN4/ZdWPvgyi8n2H4clAVPq/+eFkaGeTCIYsHPc1Xt72tfg4Yp1NiXiXhq
	ehb04yzN5W7GcduQIMFMppjWjhlmtmZLI9geEfAePtzHZHYfa226GflsV7jajdpk
	MEW+eH44J7UFk19cUvx1zFgSIDBtLFHIOcINeREcNZrE2PXCo2hFGb/l5p9/sah6
	cnESGGFyZAfrCw3oJLHj6+O6KhQSclTcNnOU2pBA4hLs3I3HIUySrDPtxBekKt+a
	jAd2hvQgxbuj0b9PoPftsSkRKKRO8tazpYeQSvdsBTx1Y52B0sq4/TvbWbfFaIxL
	12yokwXCjeIPM1QvsBu0Cg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br1b8cjcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 21:22:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60KLM4BC019076;
	Tue, 20 Jan 2026 21:22:15 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bsyrr39pt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 21:22:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmDQN7uE0LdoWTrnmoQlL42JRMUoHDIpOghaU0+kKKDNKBRdOxaH7YAw+oJK9AYJrjUp2cdWAw7Hk5hGrn6h+HpZ5dvmYtSMpSO5wBS1kQxRA05hNPtJyRNDPWg1issyo7xgS0JCENPLQAZtEBAJJ//yM31Ge4OyhUj6zWtQWwW6/8AKs622mDXhuC39u3HWUrx/VupUg8jkQCSpB3gZRbZVhc/aq/fVkD1Xve44TZnk+9xT7cVrDOQttu67roLKIN37kmKWplsLIoW1Aa2O9tk191a2UlO645WU1k6srKrnBtISKAhXqImHeZdbZFHqfWVpc//5L5TWTiC0WrZlyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnphLD+Jrbh1IyTJTWAjqqVzpue7PvaY+hjodXo6zV0=;
 b=DDvxFEIpwWtA7Va7gXe2XI3vZ3xSlRf2oN6SFjYagcDVkrFD7vQuch48plIrCQGZZnN4WrX9MAPYSXmkQxhA/cbBqIaQe+/B8M/Uvx/0wOUVM1EZ2I7z+xeqn6Y9tusMsy1YFoE3vmNANp4dYn6zkVtx2mCQFptZiJK2TLctIDOOtz/xSaJum70JHuhmYzFy632aM63OmmVE3tgM9ZBWZzOBL23VAknpafVh115q1nMKVLXKpLC+lavS2UNP8i8eK5YgwbV/PntYhfiOFNRB924GMlSRdJHzxf1bz13BAVOVyGQ/Yjl1BOKNyApoFBNSlVhVNltccs8i7/uQYf/lXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnphLD+Jrbh1IyTJTWAjqqVzpue7PvaY+hjodXo6zV0=;
 b=yu4wC04VcVAC7f6F31759d869ItmVAoXcmeX6t7uQ6Glno+ydrVoX1BG0LJ9eBhhH2m0MyCh6Ri6SENN6Co8yhbRqfMFBsiTdBBhH4dSJ0PJnNGeOBjWZK6tN2MTjPh+6BTAhiO5vZOiu6hp/SSGmY45uJ0w+sIC14b/mqjpMUQ=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by BL3PR10MB6114.namprd10.prod.outlook.com (2603:10b6:208:3b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 21:22:09 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 21:22:08 +0000
Message-ID: <a1dc8306-6422-45c8-a5b0-8d10a4d89279@oracle.com>
Date: Tue, 20 Jan 2026 13:22:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: Enforce recall timeout for layout conflict
To: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com, neil@brown.name,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260119174737.3619599-1-dai.ngo@oracle.com>
 <f02d32dc80e1a51f4a91c5e3ce2a5fe10680e4ea.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <f02d32dc80e1a51f4a91c5e3ce2a5fe10680e4ea.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0096.namprd03.prod.outlook.com
 (2603:10b6:a03:333::11) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|BL3PR10MB6114:EE_
X-MS-Office365-Filtering-Correlation-Id: a6965208-54ab-4450-4d10-08de5869f7cb
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NDVUMUwvUWN0czVRZHdOQVBsQ1BqTitwK3AvQWlpUWhCRS9CYjRXQitBK2xI?=
 =?utf-8?B?Q0Jqdm1Gb1lPUXFjU3o1MVRjV045K1I3RFR6NGJXSTA1V0hGdHhtYU5pRzE5?=
 =?utf-8?B?SnhqMHJnUHlwM3JuOEFOaFdkUmowRmVqd1VNMHRscGZ3cVlSc3Myem5Ua0tX?=
 =?utf-8?B?eGI2R1dRNUMvNWV5cWN6WWFramEwMmU2YW5aUXkzdEZKMW9Qbi9KcjFxQ1BN?=
 =?utf-8?B?alBNRTIwY3F3ZHdqVGZkTHZRZWNVWDFKMW5iQzBZZXkxZXdGSDArQytTdWxY?=
 =?utf-8?B?OCt0TGtBSDcyQVMyQnkycFpXUmhtai80YlhwMmN1Nk1rSzU4MmlWTzFhRzFL?=
 =?utf-8?B?VGRoSnRJbDVweURITXFlUEdVVGNlSUtVcEpBMUU5RllmRzU3VFBYMDRUM3No?=
 =?utf-8?B?MlBTRWNyYUJuemw0bkxlRzg0NTk1MHZ0ek9kK0pURThaK3RmWmJiRHJTbklT?=
 =?utf-8?B?b0lIZFJyM1RDem5pVkUrQ01VNHJMcTNXWVlvVXFkNlpUTGpLWHQ2SVErNVFJ?=
 =?utf-8?B?RnFvemJsWmpjTFpuSVlRMXNMQnpoY21zM1hlNkZYekl1dlFKMHg0OHZqK3cx?=
 =?utf-8?B?K09Cd2RJL0xmQzhRVngyelAvTVhtelExYy9jekt0TVVib3ZKMDI1RHFRQThu?=
 =?utf-8?B?dzBtSEtZVEJBSnJCZ2s2Z1NFNzhiL2RMVlp5Qy9YcDFxRDNTVmtza0lFeG9r?=
 =?utf-8?B?RFYzdHBaZzYrODJNei96OXNFdjVYYmtJd3dIN1NLWjFiN1pDTXBiaTF4bG9H?=
 =?utf-8?B?cTRTOE1jaXMxU2JEeXdUYkdocXI3Z2p4QTY1YVg3ZkFqci9yb29QT3p0a3Qw?=
 =?utf-8?B?YjhkUjNvTHc5ekhJbmVmY1RoMWJ2UlpNZDN2WnZQdEUzN3dmUEwxQ2s3Rnp4?=
 =?utf-8?B?QU54QnhhaXBkejhCSWxyaXA0ZUVvU3FySlJBMVd3ZUMwSmZ5UVVQR1BWdHor?=
 =?utf-8?B?cXZJZWlKREh2dUlYanRSd1RYMi9EaGxwN3d2ZEN2NUR4RTVTaDZ1R2hERDdB?=
 =?utf-8?B?dzE0dVRrSkk4T28zVWhSZElXNUJHQ3hJeVU5SWc5VmFRVVdIem5iQXgzODZj?=
 =?utf-8?B?NURuZTduTFhhWHJzaURBeVQ3R0s1cTFObWQraWVlZCtha0VHbWR4NWNlK2hK?=
 =?utf-8?B?NDc4dHArellXSDNhOEUxQm51SWRpMzRqYjZUbC9BZ1pRNXNKMDBLUUZ1bHJ4?=
 =?utf-8?B?cU1XOGhEZDlrcGw3Um9GdUpvRWZVZE9zRDBkc0QwaFdKZ2F1cG1WbGtyMXgy?=
 =?utf-8?B?M1RacmVNYkZFRnJVTVZGS1dPUW5qM0o4dzVicGU3K3hTUG9LZzRBUkx2VE05?=
 =?utf-8?B?ZkhEUXJlT25FZnE3UVRTMVhMQ25HdkJPd09OcnRIM05SOXVOZEIzR2s1YlM3?=
 =?utf-8?B?NGY0NFR3elM2aGNVenFwZzNVZEpiZDhQZ1ZlcmtyYkt6L1RjZ2ltRFlNOGNR?=
 =?utf-8?B?b0oxbUp3aHVzbm5QOTFpWmFIWS9rRDJxL1pYREtncnBwVVlaU3piVTByTG9k?=
 =?utf-8?B?NDFIWkl1cHg1L2dGRGFUc2d0WVlDWG1FRXlxdU1mMFQyUEVvZFU5aXRTaXNw?=
 =?utf-8?B?WTdyOUlTeWl2MmFXS3dINlBVK1F1eDl3K1NVdVVIZnlhVHBaREFuMkFTbXh2?=
 =?utf-8?B?R2NQVDRNRTFQUEU5OTZnc1MyVmpMTmVTSTZ5UUhobDYvVjFqNnMwR3hxbWxh?=
 =?utf-8?B?K1ZURjR0UmlsQVp4R24xRFhqZzM1aC9nNzJoclpEa3cvQ1ZHcE16cGFWRDNs?=
 =?utf-8?B?QklwL0x3NS9OWlVxRDJMT1JvMnRvZm1BcS83VGlLNE5uTlUxeHFCS2dMd3ZO?=
 =?utf-8?B?RnZ1ZHdJMk9Tdm5acjBwWkdYaXdtdEZRVmJFclZ4UEVINlBvYXUxZnNpVTh1?=
 =?utf-8?B?MFdNdWVKYVQvR2RsWTQxS3FhYTZzZFVia084STBnMktKakdGR05yTlAzZS9m?=
 =?utf-8?B?OWtxVFlIS2Z6T0NDanNxZFhtSlFSRE8vTitGeUVyb1AzTGJZSVhLL3JXL2xC?=
 =?utf-8?B?RWdnYS9Cd2xhaThUNGNiZDRYZXBPd3gyQ0lraGFidVNSQ2ZmQ05pendUdEgy?=
 =?utf-8?B?ZzMwV1o5NjBwLzhDQXR2ZHRDVWROSnpYdWdaSjlwRm5NQXFJMGl3NjdTdVcx?=
 =?utf-8?Q?a8ng=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?amZoSkVYNWlRTmxKYUZwbGNnbFpKK0RZTHRRWFJPcSsxa2NNcVlhaEEvVGZK?=
 =?utf-8?B?d0ZTeEN0dWNHQUpzWkJUUXo2WVdqSmh4SmM5OXRZQ2xTYzNKbWlibFZ2U2xl?=
 =?utf-8?B?LzBnN3YrdkNRY0cyZXBWRVdZL0xRaXAvN0VlUThNanEveTdjeHR0Z3ZSRmlR?=
 =?utf-8?B?NTBFc1FIZmhHUDhpZTFyVmQrdnhuT3dSL1VUSmFCYXh4SCtLc2ZIK2hTNmRi?=
 =?utf-8?B?MHg3TStyemhhMjR6czN2MEFyU3drTkV5cFF6TW1JUnd4TlFsTjErZWdHS3pE?=
 =?utf-8?B?b09ta3plcmViV2lMQUxrOUVyTkJXODdaUkhVaVgwcXVEa3dubjVncTkrR0d1?=
 =?utf-8?B?YkhldGFodDhMSlBObG1PWHcvVFI0QVVTSFRnY045d2NtV2piNEhSNVlRMDhY?=
 =?utf-8?B?YUdoTzZyK3Q5SDEzazFvbDRNMjA4c3Vpd1RuWmlqRVNqbjYzUDVWa001MEJT?=
 =?utf-8?B?U0s2TjFJYkY0Qm5FcTBoaDFlN0xxTEt4K1o2Z3h3cDRyS3U3QUxaTndkWm5L?=
 =?utf-8?B?U0FqazVHdG4vZERJN2ZBNWhvL0RBQk1vNjRGdWdPNTRkekR5MXh0V3BWUjhZ?=
 =?utf-8?B?cHQweFNRb1JJMkY5ZEU0WjczRVFlYTlRTFBEVU1EWG5sZ1AwUWZvdmN6ZjhN?=
 =?utf-8?B?T2JidzRsZm5PZllTNFQ4YkFLbitTdEloZXBFNDlreFZOT21VT3RRWGV1dnRv?=
 =?utf-8?B?aXlzYnRBL0NtaU83cUtHeFhyYVo2WnF6YkdOOU1IcXV5SlpjSDZXNEJDSjI0?=
 =?utf-8?B?U25kQVB6d3pacy94MmJDL3VSQ2xLTnZVdWNiNGIwOEhrSXRnUjB4WjE3U2g1?=
 =?utf-8?B?VnBITUdyTFFUYS9HN3RZQ1ZOTUdUenllTGd1dGlLVEtQWWhnRno1Ukt3QkFC?=
 =?utf-8?B?T3VGQ2VVbSthSHFESkpnSTN4aWV4b2FFMVNuMk1wSU5ybmxOdGtESFBnY2pj?=
 =?utf-8?B?dGJ4L0VQVHRiUVVoeFlhTVJ2ejhnc3RubkNBaEtmVnc0bnN6cE9wR2FNUGhK?=
 =?utf-8?B?YTJHWkZOYm9ZRTdHTC9hSWJIeU9wSFo5eXMxcGF1UjdlamlKRi9VZ05oRzlm?=
 =?utf-8?B?SFVmZE9PcG1hb1VQZGtibWdTQ24xMnpUTDB3UEMwM254em02RTloWkgwMU9D?=
 =?utf-8?B?L0pYbDZjQThPK2lSakIvM0krVWR4R3U0U0VZQlBhM2loTTlTYW54MVhFQkJU?=
 =?utf-8?B?S2txR3ZHZHp1cDJVWUJPSFdlYnh5UlZockpMTGJwY09BRU13dm84UFR2bXdh?=
 =?utf-8?B?d1h0VGRBZW5iaTFHL3hTeFBmMTkxc3BTWGUxK05XVVhDK3c0ZS92aFpENEdx?=
 =?utf-8?B?cStDN1BxQWovWUxiRW1TcTBsVmpiSnMzcnMxMU5XbjRwVVkzc3VuTWpmT0Fz?=
 =?utf-8?B?Z25jcEhiTkpkd0k0cWEwU0QwU3JBdlZXeGlwQzdYTW1TQTh2Q3dRVHRSOFVY?=
 =?utf-8?B?bFRiU0c1M0NqaHpDTjFkQXRWU3cxZjIyV2JzQ1k2YWlTRGI3a0ZGclQrVUF2?=
 =?utf-8?B?NDF3MXNqVjRGZXJyVEJTNXFyNjlzUmh5QnFjMTZuY3JESGc3b0orY1lFMHBw?=
 =?utf-8?B?bGpRT1Z0dHYvenlYUjdZSThqRjBwcFoyUzFBcXBNbC96UUI0L0ExQ003cWxn?=
 =?utf-8?B?NkovL0tza1RCOWpUQ01PUDJ4YmUydFA2ci9OYjUzZzd2cUF4ZWJKQU14WnpE?=
 =?utf-8?B?YXlKdWIwQ2ZjN09WV2l5SFUwNi9udmRqc2hZRllqMkFESE54MGFNNWhoVzVp?=
 =?utf-8?B?WjJoOXIzY1BvZGUwSGdPV1hKMzB3QmFNOEx6SzR5TkppSDFQbFRjc2VjQS80?=
 =?utf-8?B?c2xmODdhMFdJU3gvejVydjdraW93YlNEWXNVa2pjRTRwTEJDaStRbGFvd1pB?=
 =?utf-8?B?V2lFK1cyYkV3UUYvZ0hMS0Fua3NQWk9mRFhiRWJVK2JwaXFuRitGTVRTbzJn?=
 =?utf-8?B?SnNmVlJpYkE2QXVHb0dQYlZ2OEc3MldMa1NCOFVXc1BsbXlMRTlIU0luMHpr?=
 =?utf-8?B?RUxSNzFKTHVJRE1XajZwbnVmQVFQRGRBMCtYOVV5VUxIeGYrU3hDRFoxQVRo?=
 =?utf-8?B?V0ZzYWRUaXYya2YzMXJ1STExcDltelpvVzNkMGZHaTZWaFU3YkhJWHpvOGQy?=
 =?utf-8?B?ZzJodnNEdllOV0NOL3d6QWhTMVpZaTdheUxpb0ZKdk9HOUhVWDhFS0NVekVS?=
 =?utf-8?B?VHRibndaUGdKZW9ReW4yR0ZOck5XdDVVdUpJOGdGa1Exb2VYeWplcXFyOEFV?=
 =?utf-8?B?UmR6OXhiYWVKdkF1R0tqT2w3cjdrUnZzdFFPZ3c2eUR0VWZDUGJNSFhJS01Q?=
 =?utf-8?B?cEtVT3ZFS082SENPaEN1VDJnWUlkRWtVblFuaEIySy9Pb1hnNlpRUT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NQNVcZjapBUFVrXgiB0r8828uM4Ainu62e7j3lPHIeshNxfc4BHubMn/hpjQJBJbne5J8lEtwhHenVliIDDZ6JBJ3sqrt6oe5qe3MWNvMTQdueExgXdrxN4Fsub64D1gqBywizxLX8Q6t6mmig/4bpwbYq6VbHCRP12/XRMt2OdxGgrbMsqRNw5T609AjPcuodNjK12m90NKqw3HQrd34CTEdU1Sqd93NnglWkn22WcXZDHsOQaAC1dNa611LLgximFCL3GNqEsRC9u7Jl1+n8NcURQoWEPEViswDlf3OyRV3U6w+zEhmjVeVZgkVtLM8WaQPdRjCcvUn1FY3TfVZTkyD0T5s/BAeb0LNPeUTtcXe7RTG9rGDq7BFEzqD39v/QzZ+x3FWzUhxC6RM9XglAnFaTjmXDKP9GaKK3WkleL6I6rHnVzZCwmAJjSQsBkHDZwISgUka7Uo82fpN+z3ZIATW9hj925Q/wMmu0G2uQ4YTYXhWy71aq1SRyhfa1h+v7yechoX+uoit/ETQFCNkS5yA8CQbwkp2t3Mbb5mVDGem62rj3WIbHKwsRSbDSVFb8aHWWxHRLhbxEcXnC7XwXGYMbkYN/ZRMIHSpxkArKk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6965208-54ab-4450-4d10-08de5869f7cb
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 21:22:08.7683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Om1Sb2GcF8B8+ckZvjCNHY7fV2pFTJeKglin0ZAgHfKvMkAN3lV/AZVJgzz9Fwt/rWN0T3C4x3sjzrd+FhCuUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6114
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_05,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601200178
X-Authority-Analysis: v=2.4 cv=WbcBqkhX c=1 sm=1 tr=0 ts=696ff208 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=7vTQLkfx9EDuAWaR7fAA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12104
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDE3OSBTYWx0ZWRfX1thqStE8237x
 cqyRReNv8Rmrg0V/PkTwKd9jt/RuDBpRAFXB/ewEinAg0I6Eo5n9doIC3aNVgDwTHgDgBnbIojE
 zisONinHuiZk97wd1mkOYc+uJ6uCMwleQ3bfboaAksryzOdD9svteUPBRbRZHi71Oov9gZrr8nb
 wvDOlscXU/Ip3rJTF856vhtQ65qeJAaZMXsF13XEB7b4fO/uFbai0WVcIWjJdWQNf3tntNxtELS
 6gPQ0vceJQNvHqr+kHF3E+LNrjoS2goYvOZ6JrG/0cvJAF+1p580rOWgZuPvsSn+aynrKrDqLN/
 CFG4NcEr20TKz40N+8S3jdDyW3unNbri4RPfRfywnSR3q7s+kLn4LgMfQ66NhDWOoIR34NaRYms
 MZA/t03JuMEmp8Lv0ta9RIi4/KchZPrecozES7VRXv96SWAp7xkU44BAinXFWY4DG5Rk1p+27Sa
 4qWbEQfuJUQC3iBXIR3ay1T3C/KAbKu/imKPdjqM=
X-Proofpoint-ORIG-GUID: _9YSWRiBIEcXSJ9XE1u1PEZIeKUPuEBR
X-Proofpoint-GUID: _9YSWRiBIEcXSJ9XE1u1PEZIeKUPuEBR
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[oracle.com,reject];
	TAGGED_FROM(0.00)[bounces-74737-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,lst.de,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,oracle.onmicrosoft.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DA9DC4D0E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 1/20/26 12:41 PM, Jeff Layton wrote:
> On Mon, 2026-01-19 at 09:47 -0800, Dai Ngo wrote:
>> When a layout conflict triggers a recall, enforcing a timeout
>> is necessary to prevent excessive nfsd threads from being tied
>> up in __break_lease and ensure the server can continue servicing
>> incoming requests efficiently.
>>
>> This patch introduces two new functions in lease_manager_operations:
>>
>> 1. lm_breaker_timedout: Invoked when a lease recall times out,
>>     allowing the lease manager to take appropriate action.
>>
>>     The NFSD lease manager uses this to handle layout recall
>>     timeouts. If the layout type supports fencing, a fence
>>     operation is issued to prevent the client from accessing
>>     the block device.
>>
>> 2. lm_need_to_retry: Invoked when there is a lease conflict.
>>     This allows the lease manager to instruct __break_lease
>>     to return an error to the caller, prompting a retry of
>>     the conflicting operation.
>>
>>     The NFSD lease manager uses this to avoid excessive nfsd
>>     from being blocked in __break_lease, which could hinder
>>     the server's ability to service incoming requests.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   Documentation/filesystems/locking.rst |  4 ++
>>   fs/locks.c                            | 29 +++++++++++-
>>   fs/nfsd/nfs4layouts.c                 | 65 +++++++++++++++++++++++++--
>>   include/linux/filelock.h              |  7 +++
>>   4 files changed, 100 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
>> index 04c7691e50e0..ae9a1b207b95 100644
>> --- a/Documentation/filesystems/locking.rst
>> +++ b/Documentation/filesystems/locking.rst
>> @@ -403,6 +403,8 @@ prototypes::
>>   	bool (*lm_breaker_owns_lease)(struct file_lock *);
>>           bool (*lm_lock_expirable)(struct file_lock *);
>>           void (*lm_expire_lock)(void);
>> +        void (*lm_breaker_timedout)(struct file_lease *);
>> +        bool (*lm_need_to_retry)(struct file_lease *, struct file_lock_context *);
>>   
>>   locking rules:
>>   
>> @@ -417,6 +419,8 @@ lm_breaker_owns_lease:	yes     	no			no
>>   lm_lock_expirable	yes		no			no
>>   lm_expire_lock		no		no			yes
>>   lm_open_conflict	yes		no			no
>> +lm_breaker_timedout     no              no                      yes
>> +lm_need_to_retry        yes             no                      no
>>   ======================	=============	=================	=========
>>   
>>   buffer_head
>> diff --git a/fs/locks.c b/fs/locks.c
>> index 46f229f740c8..cd08642ab8bb 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -381,6 +381,14 @@ lease_dispose_list(struct list_head *dispose)
>>   	while (!list_empty(dispose)) {
>>   		flc = list_first_entry(dispose, struct file_lock_core, flc_list);
>>   		list_del_init(&flc->flc_list);
>> +		if (flc->flc_flags & FL_BREAKER_TIMEDOUT) {
>> +			struct file_lease *fl;
>> +
>> +			fl = file_lease(flc);
>> +			if (fl->fl_lmops &&
>> +					fl->fl_lmops->lm_breaker_timedout)
>> +				fl->fl_lmops->lm_breaker_timedout(fl);
>> +		}
>>   		locks_free_lease(file_lease(flc));
>>   	}
>>   }
>> @@ -1531,8 +1539,10 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
>>   		trace_time_out_leases(inode, fl);
>>   		if (past_time(fl->fl_downgrade_time))
>>   			lease_modify(fl, F_RDLCK, dispose);
>> -		if (past_time(fl->fl_break_time))
>> +		if (past_time(fl->fl_break_time)) {
>>   			lease_modify(fl, F_UNLCK, dispose);
>> +			fl->c.flc_flags |= FL_BREAKER_TIMEDOUT;
>> +		}
> When the lease times out, you go ahead and remove it but then mark it
> with FL_BREAKER_TIMEDOUT. Then later, you call ->lm_breaker_timedout if
> that's set.
>
> That means that when this happens, there is a window of time where
> there is no lease, but the rogue client isn't yet fenced. That sounds
> like a problem as you could allow competing access.

I have to think more about the implication of competing access. Since
the thread that detects the conflict is in the process of fencing the
other client and has not accessed the file data yet, I don't see the
problem of allowing the other client to continue access the file until
fence operation completed.

>
> I think you'll have to do this in reverse order: fence the client and
> then remove the lease.
>
>>   	}
>>   }
>>   
>> @@ -1633,6 +1643,8 @@ int __break_lease(struct inode *inode, unsigned int flags)
>>   	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, c.flc_list) {
>>   		if (!leases_conflict(&fl->c, &new_fl->c))
>>   			continue;
>> +		if (new_fl->fl_lmops != fl->fl_lmops)
>> +			new_fl->fl_lmops = fl->fl_lmops;
>>   		if (want_write) {
>>   			if (fl->c.flc_flags & FL_UNLOCK_PENDING)
>>   				continue;
>> @@ -1657,6 +1669,18 @@ int __break_lease(struct inode *inode, unsigned int flags)
>>   		goto out;
>>   	}
>>   
>> +	/*
>> +	 * Check whether the lease manager wants the operation
>> +	 * causing the conflict to be retried.
>> +	 */
>> +	if (new_fl->fl_lmops && new_fl->fl_lmops->lm_need_to_retry &&
>> +			new_fl->fl_lmops->lm_need_to_retry(new_fl, ctx)) {
>> +		trace_break_lease_noblock(inode, new_fl);
>> +		error = -ERESTARTSYS;
>> +		goto out;
>> +	}
>> +	ctx->flc_in_conflict = true;
>> +
> I guess flc_in_conflict is supposed to indicate "hey, we're already
> doing a layout break on this inode". That seems reasonable, if a little
> klunky.
>
> It would be nice if you could track this flag inside of nfsd's data
> structures instead (since only it cares about the flag), but I don't
> think it has any convenient per-inode structures to set this in.

Can we move this flag in to nfsd_file? set the flag there and clear
the flag when fencing completed.

>
>>   restart:
>>   	fl = list_first_entry(&ctx->flc_lease, struct file_lease, c.flc_list);
>>   	break_time = fl->fl_break_time;
>> @@ -1693,6 +1717,9 @@ int __break_lease(struct inode *inode, unsigned int flags)
>>   	spin_unlock(&ctx->flc_lock);
>>   	percpu_up_read(&file_rwsem);
>>   	lease_dispose_list(&dispose);
>> +	spin_lock(&ctx->flc_lock);
>> +	ctx->flc_in_conflict = false;
>> +	spin_unlock(&ctx->flc_lock);
>>   free_lock:
>>   	locks_free_lease(new_fl);
>>   	return error;
>> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
>> index ad7af8cfcf1f..e7777d6ee8d0 100644
>> --- a/fs/nfsd/nfs4layouts.c
>> +++ b/fs/nfsd/nfs4layouts.c
>> @@ -747,11 +747,9 @@ static bool
>>   nfsd4_layout_lm_break(struct file_lease *fl)
>>   {
>>   	/*
>> -	 * We don't want the locks code to timeout the lease for us;
>> -	 * we'll remove it ourself if a layout isn't returned
>> -	 * in time:
>> +	 * Enforce break lease timeout to prevent NFSD
>> +	 * thread from hanging in __break_lease.
>>   	 */
>> -	fl->fl_break_time = 0;
>>   	nfsd4_recall_file_layout(fl->c.flc_owner);
>>   	return false;
>>   }
>> @@ -782,10 +780,69 @@ nfsd4_layout_lm_open_conflict(struct file *filp, int arg)
>>   	return 0;
>>   }
>>   
>> +/**
>> + * nfsd_layout_breaker_timedout - The layout recall has timed out.
> Please fix this kdoc header.

I noticed this too, will fix in v2.

>
>> + * If the layout type supports fence operation then do it to stop
>> + * the client from accessing the block device.
>> + *
>> + * @fl: file to check
>> + *
>> + * Return value: None.
>> + */
>> +static void
>> +nfsd4_layout_lm_breaker_timedout(struct file_lease *fl)
>> +{
>> +	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
>> +	struct nfsd_file *nf;
>> +	u32 type;
>> +
>> +	rcu_read_lock();
>> +	nf = nfsd_file_get(ls->ls_file);
>> +	rcu_read_unlock();
>> +	if (!nf)
>> +		return;
>> +	type = ls->ls_layout_type;
>> +	if (nfsd4_layout_ops[type]->fence_client)
>> +		nfsd4_layout_ops[type]->fence_client(ls, nf);
>> +	nfsd_file_put(nf);
>> +}
>> +
>> +/**
>> + * nfsd4_layout_lm_conflict - Handle multiple conflicts in the same file.
> kdoc header is wrong here. This should be for nfsd4_layout_lm_retry().

I noticed this too, will fix in v2. Kernel test robot also
complains about this.

>
>> + *
>> + * This function is called from __break_lease when a conflict occurs.
>> + * For layout conflicts on the same file, each conflict triggers a
>> + * layout  recall. Only the thread handling the first conflict needs
>> + * to remain in __break_lease to manage the timeout for these recalls;
>> + * subsequent threads should not wait in __break_lease.
>> + *
>> + * This is done to prevent excessive nfsd threads from becoming tied up
>> + * in __break_lease, which could hinder the server's ability to service
>> + * incoming requests.
>> + *
>> + * Return true if thread should not wait in __break_lease else return
>> + * false.
>> + */
>> +static bool
>> +nfsd4_layout_lm_retry(struct file_lease *fl,
>> +				struct file_lock_context *ctx)
>> +{
>> +	struct svc_rqst *rqstp;
>> +
>> +	rqstp = nfsd_current_rqst();
>> +	if (!rqstp)
>> +		return false;
>> +	if ((fl->c.flc_flags & FL_LAYOUT) && ctx->flc_in_conflict)
> This should never be called for anything but a FL_LAYOUT lease, since
> you're only setting this in nfsd4_layouts_lm_ops.

I will remove the check for FL_LAYOUT in v2.

Thanks,
-Dai

>
>> +		return true;
>> +	return false;
>> +}
>> +
>>   static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
>>   	.lm_break		= nfsd4_layout_lm_break,
>>   	.lm_change		= nfsd4_layout_lm_change,
>>   	.lm_open_conflict	= nfsd4_layout_lm_open_conflict,
>> +	.lm_breaker_timedout	= nfsd4_layout_lm_breaker_timedout,
>> +	.lm_need_to_retry	= nfsd4_layout_lm_retry,
>>   };
>>   
>>   int
>> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
>> index 2f5e5588ee07..6967af8b7fd2 100644
>> --- a/include/linux/filelock.h
>> +++ b/include/linux/filelock.h
>> @@ -17,6 +17,7 @@
>>   #define FL_OFDLCK	1024	/* lock is "owned" by struct file */
>>   #define FL_LAYOUT	2048	/* outstanding pNFS layout */
>>   #define FL_RECLAIM	4096	/* reclaiming from a reboot server */
>> +#define	FL_BREAKER_TIMEDOUT	8192	/* lease breaker timed out */
>>   
>>   #define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
>>   
>> @@ -50,6 +51,9 @@ struct lease_manager_operations {
>>   	void (*lm_setup)(struct file_lease *, void **);
>>   	bool (*lm_breaker_owns_lease)(struct file_lease *);
>>   	int (*lm_open_conflict)(struct file *, int);
>> +	void (*lm_breaker_timedout)(struct file_lease *fl);
>> +	bool (*lm_need_to_retry)(struct file_lease *fl,
>> +			struct file_lock_context *ctx);
>>   };
>>   
>>   struct lock_manager {
>> @@ -145,6 +149,9 @@ struct file_lock_context {
>>   	struct list_head	flc_flock;
>>   	struct list_head	flc_posix;
>>   	struct list_head	flc_lease;
>> +
>> +	/* for FL_LAYOUT */
>> +	bool			flc_in_conflict;
>>   };
>>   
>>   #ifdef CONFIG_FILE_LOCKING

