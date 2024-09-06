Return-Path: <linux-fsdevel+bounces-28889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 466AE96FE0B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2024 00:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0551F219A4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 22:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E231915AAD7;
	Fri,  6 Sep 2024 22:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RuKxjMMu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nkUHHdor"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC61C1B85D8;
	Fri,  6 Sep 2024 22:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725662007; cv=fail; b=G5zS3hR5vwvPQF37XRi8XGTBusYQ8UyF0ij2ozZMCRZVs+LDZxk1nUOyuKKO9eDS4oOuXqJx6Sv/6s82bqhL7tlf6mDGage6bPHYbf4Z66lgy50h5NbEepZg5cDwPTI3p3oCgKrZMI21BqnGvUTFhCzKbDUl4kTOsD5NFTAgme0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725662007; c=relaxed/simple;
	bh=HQ7q0QTFDKT/VU1e9/8vdjtUOdftQA/bIWuoDjY6fik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rfrwOfXHXx+klMTUiOBGAkNiuY1XC+n8oR2k4pOZDSsVjqyg5iOYhKETsAKgltgq24xcLUgzpW0UGpMa1GOF13/8rqoYLXdcQOSZzboz/amOjiDvKpWJ47r1BVsAd6+LydqdGycqH7ckIq2F4DEcOXHovQ26K9h+hGY7HXX0eHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RuKxjMMu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nkUHHdor; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 486KXUMM015014;
	Fri, 6 Sep 2024 22:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=HQ7q0QTFDKT/VU1e9/8vdjtUOdftQA/bIWuoDjY6f
	ik=; b=RuKxjMMu5WKgKx70pHZ/VpzHr5ogK7dWlkMeaB7a6dhrDz+bC6lN5CjP7
	FuF2x+tIqC7qH1c+JQVuUiMXkPgJBQHz3t8mu3a3buvO0toZi6JszUmnyIF18A8K
	uKorg5+PfA/MYWToM7JpvZsTOkK270aY3H1wl22Vmee5tGGC0lzjK3lWNGWg3bTT
	Uq610e1pA4iEnrn0Ndnm2/MysSvITwQ/A6zk3EJSWpQHAmrxyf6RWgidk3g3r8iv
	ZtziC149OiThMpvvNQe1ektU+CTws98+AN31K++uZOUjZq/5Lg28iAxyaZdEybVn
	bNfqhXxTJyO22j5jPMgAkOfN65NCw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41fhwjjr2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Sep 2024 22:33:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 486K0SHN036791;
	Fri, 6 Sep 2024 22:33:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41fhygg2xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Sep 2024 22:33:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLhLE5oKpuCfdND9V7y57AlPQHBi2qcAGrBjtetKZ1haujETYn3ZZTuNiEGUipltppnxKvEQZDRATVgheYb+9tLAsZSDBgppEeMY9JRyRo3OkH+Nl32Pwk3owfQYRSMQps3/fQFcUSpgjkBOzlO1B7hxmiA15y8qU88nN33qzk+mCKvyILaszkAPnaSXaH1jNruvIq12WVHA9o12GqmgaBALYvYIWzn5+zcZQEMu1bhxxvy1b0DCx1iY2JVBu12TkdFNYANgGm1iUrEmqtkKC9cb0zhUYNfWE4trnbIueIq3+BKUMXVpU3eDYoxDI5eIMn4cwtOzZeMa8YQ8WSnYkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQ7q0QTFDKT/VU1e9/8vdjtUOdftQA/bIWuoDjY6fik=;
 b=chxwv7Pcm2pSwVjUsRdVAo3XUHOarHkYDjPg7nW8j6oOB36aDZtGWUWH6l5njxtCuOExRVR12lsFSpZKp6fHHsPg+UZ//t2jNVqxC0mQnJ0zbzl2J6chhzAVjgaVak4hu8T+4+sinqOfh+MsaQMNl/vyo9Z8eYR8+IKzK/kUSlsmnLKCjYj1vKqdzI/Xz98Fze9tlbHg/v8K6rwr5WRI0KB4Krv0ECZL24YrbAKzQyFYbKbvT8yNkELjrNo4it48QqXmxXSeaPB3F40BBt+H30g67dytDRt2EJ4EQGkQOJ3ANwPRcqskwccMJXcdWpXpd9pH4MbJV0mIOP0HDt+uXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQ7q0QTFDKT/VU1e9/8vdjtUOdftQA/bIWuoDjY6fik=;
 b=nkUHHdorr1zHh4YF1AC+W06MZPx5Qp2FdXRsaAHagEMcP2s+kkG4hJHJbSYhcLSQ7oDi94DNc4JVziDa3BwHJa+1UdW97RV4r0iLhRpXG1Al3xfmiAtFP+YXPvaQtk2nK2LRzzUdPQzr7S/CS76Uin4WDRBnrm299dDvbj1n5dM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4134.namprd10.prod.outlook.com (2603:10b6:610:a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 6 Sep
 2024 22:33:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.010; Fri, 6 Sep 2024
 22:33:07 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Linux
 NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker
	<anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v15 16/26] nfsd: add LOCALIO support
Thread-Topic: [PATCH v15 16/26] nfsd: add LOCALIO support
Thread-Index:
 AQHa+/Z8NjJpiHCGJkyIBxPv6nO2sLJGJLQAgAABzwCAAAV7gIAABX6AgAACqoCAAAhmAIAAbZ+AgABs/QCAAJLIgIABm82AgACaigCAAQPhAIAAMy8AgABAEoCAAAoaAA==
Date: Fri, 6 Sep 2024 22:33:07 +0000
Message-ID: <2D4C95CA-3398-4962-AF14-672DEBADD3EE@oracle.com>
References: <ZttE4DKrqqVa0ACn@kernel.org>
 <172565980778.4433.7347554942573335142@noble.neil.brown.name>
In-Reply-To: <172565980778.4433.7347554942573335142@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH2PR10MB4134:EE_
x-ms-office365-filtering-correlation-id: 68e78b27-c670-45ca-82aa-08dccec3e13d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WlNqNEhkU3pkSXRDZ0pEZFNyY2JuVlhXS0s0MUJ6ZVUwSC9adk1LcUsrYVEz?=
 =?utf-8?B?eTE2NDJ1YlQwaC85dGF4cHdLOFRpallqTGhEdDVMTmlHZExMdFZWMmdmK3l3?=
 =?utf-8?B?ZjN3OEFWSkc1WmlYaWZrODh2Y081NkNhRlNpVitaVWZ4YTFIR3dOSkxrcWxm?=
 =?utf-8?B?S3AwaWNxYnBjUEw1MWpoaXdWSS9zTlJ6MVV0YUl5MWZ4bHhROGZjVmZEcUFi?=
 =?utf-8?B?SUpsY3JJdnVhM3FQa3hnWk52bDJTN0hSWkRYempNdXlvbHRDNEN6eUpZUHk2?=
 =?utf-8?B?Z1dGa2wxcTBvVmJPU2hhaDRWVis2OGpXR000S0xuZ1dON1lZMUprTTJ0T2tQ?=
 =?utf-8?B?ZmFFeithbEQ5ZjgwcVp1TXBkYUVhaStJOW9WVUNUNXBWVnJRUk93elNwOGY5?=
 =?utf-8?B?eUN4clBwTEJETW5seEVLMXdaZHMvb0tESjZjMWl0TWpSL0Q5WndSbFFxd1ZG?=
 =?utf-8?B?Ump1MTZ6M1d4a2xrSER5TzlEcjdOc3hheVBOSHphWS8wVGdMTWI2dk9VdVRG?=
 =?utf-8?B?NzBoYndISFpBQTJMRncvbmU2bVFrWXJPeDZ0UmZlVUtJamM2L21lOTFiR1RF?=
 =?utf-8?B?c3I5Y044Qmc0aG4vVnZRVXdmWlZYMVZFUkZaSEdVYXRYLzl1Sml2WVE0R0JE?=
 =?utf-8?B?dytZMzZLbk1oeTNOWmVzVmJmRUdyL1dCNkZ2VzdxaUFPOWNTUzFBcDNXd3VF?=
 =?utf-8?B?dWdzT29NR0lwOGptVExnQUV2RGFtNlc3ZzV4S3dlV014Rnl0N3R5MEk4NDZR?=
 =?utf-8?B?bmVwcVdsckpBMk9oTElCWTdLenUxNEJtdGhoQmh4aU9Za2lObGpLSmk1dVV5?=
 =?utf-8?B?bFFQMEtzZDY1Z3ZzVXUvV2laT1Uya09ESjRXdlRiOVhDWHRJYTBST3NKNDEr?=
 =?utf-8?B?ZEV4NXRVRXlTWXJXUExCRXlIUXptY29WK1RFa2hPZCtHenBTUExEMnBaQUhT?=
 =?utf-8?B?STlNTEFIZzl3SkwxclJ5TkpqQmJ5dWVUcWRhT1BpNTFBbGhDQmhFSGt1SHVS?=
 =?utf-8?B?VHJiZGxHVGdGQlJ6SitTU2pGcUU2R0lOZjROM2tPZGlSRjdLQ0pMYlJJWnRF?=
 =?utf-8?B?aTV1MXZpNEp1NnpCVE16M2Zwa0VEM3ZKNTlHbzZOWi91LzhHcUFKTnF1bFR2?=
 =?utf-8?B?Z01kZCtIeTgwK2tPdzB0STFGc0lVbE1xcnd4Rktaazc5SHQ5YlFGUll4a296?=
 =?utf-8?B?TXRuZnVKMVp1SG50L2swWDk0eUR1ZWhwSHpZNDJZazlkaWlPeEZEUENoWERD?=
 =?utf-8?B?QVZoc1pIRnhEUVUyWnNzVUlURW9zNFFMQmtRTGxaODd3M1BHYkdwUDVqL1FI?=
 =?utf-8?B?VlRnaXNvMVlLSkJKMkxwYjJOck1UOVROWURXWDZscGJkZFZESTBJUUxFdkpp?=
 =?utf-8?B?WStXby90bVhlTURJNzNMbXd4aFdrcXNHTWNjWHZDMXhjTkJLQzVudTB4NG5U?=
 =?utf-8?B?TFd1M3BLVnJ3UzZEUFJ6RWczZ1FHMXFLRkQyYUtldGZKQTVDRFZydWVKanVa?=
 =?utf-8?B?aGdyTklIN3ZHSER2ZERLRE14UVJrdHBGYWNTckd1WThJN0Q4UlZPc0ZQWkw2?=
 =?utf-8?B?ZFJKZ1hneEhPazVEU0dGNE1ORkxrNExVVk4yakxyTysyZWZQM0luNmFGbnZr?=
 =?utf-8?B?WjVMcS9KUWVIV1dYR2NEenBWeEhKcjJHd005dnFWK0ZjZzhXWGVVZnF1eU5J?=
 =?utf-8?B?bStoVjB4SGxXcmFyS0VGM1dTbzFnaEtEZ2tPZUdqVGxjQzdZcnJVb2MxMG9V?=
 =?utf-8?B?MThrZFlmdlUwM2JZNnJSOXZudCtDVytqQTMvbzFJZHU2VUc5QUUreUNRT3FS?=
 =?utf-8?B?cXpSdnJxZENyUmlkcHBIZUpiQnpVd2hwWm1jYzN4Sml5anh1czQreU5sNC9n?=
 =?utf-8?B?YXNkWU4vdEt6b0dNdWd6dlcvV0xGWmpBbHZFYmJ6TkNvWXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TE9VQ01SdHFONTVwQzF4K0ptbVdoRlZkeXBkeUJnTWJHditvNnRmbU5iK2hP?=
 =?utf-8?B?S0QzMlFVdzFIRkU1MGNVWWtJekdmSS9LSUFBWk5kUFFMZ0k3Szk5K3ppUlVx?=
 =?utf-8?B?dmZTVnpvalcvL2hSRW5QR3p4WmUzNHhVbCs1QUIzejcrQyswQVRMS1hyMjcr?=
 =?utf-8?B?M290d1ZmZ1psSTR6bHJKa0Mvc0RuMmpzZ1k2UFdMc3J6aUlrZnczekVSWkd5?=
 =?utf-8?B?dHZCSTFmNmRVQ0RVZFA4Vi9qdkJrQVhySm1KMHhiRmNHMGZ3TXpOT0NsZXJr?=
 =?utf-8?B?MW01Qk1XVC9BRUxNbnBVTGcwT0tlT3FEZCs1RmhlcVhqOHQvSVNvaWt1Qjdi?=
 =?utf-8?B?T0JnRkQ1MFlIcWpoZTVJallLTnFSdDVuMnJxTmlQUEtpbGtMYlBlSDlDbXVy?=
 =?utf-8?B?djFUR2FsSzgrV1FLZ2p4Yzg3SHRRK3F2Q3hqSXhaeHkrdlhtR01JMnBLaWU5?=
 =?utf-8?B?ZjhOOENwNFlnbnlCcGZwQlZTVDNlU3JVUm5LbTU3S2xHVnExNmlIeDE1K1ZO?=
 =?utf-8?B?ckxiUnlzNW5acTVUcXpDeVd1bm1nbDhsMVYveWVhVktRQ1VGa1pnZWxPc3hk?=
 =?utf-8?B?THJoVnV1MEpkaUZESlZ5MEZ0d3pVN0t3RWx2VDRhczBEWUkxandPcy9YdTV6?=
 =?utf-8?B?enZLNmpJZnFIWFpCMlVVUk1kaXRNcE1QQ2JkRzN6N21rNTNpSUw2cnZCWm00?=
 =?utf-8?B?ODBhZ2YwVUR3bk1DV3k3V2FDSVhNeVJsWS9FSXlKY1IxRFBMUUUzZnFYWmhr?=
 =?utf-8?B?Vy9sczdjQStPbzhHMWNUcDZ4RElBdGx0cGpnWEJWZUo3L1pCOVhOcG50WjRh?=
 =?utf-8?B?RnlsbmxiNVozYzNRUlBiZHVtNGdUT3hoZHQ0NS9jWFZwNnVLUzkyN0RtWGZQ?=
 =?utf-8?B?NVQrT2pqcFYxVUxXVmhkTEY5RktFNWFJNk9RYld3NStBUjdLOGZNZkM3eTVw?=
 =?utf-8?B?RjdWK0pPSHRWKzBSNkZvS203WklYb3JYYWVPSHlTSkZlNk00aXZpVU5mYlp2?=
 =?utf-8?B?LzB4aisvSUpJeEdjWDU3NEFTeENiU0J1a3h6R0orQnZwQlRSQ3Zjc0JpYnRj?=
 =?utf-8?B?cXRYZllQSzBGcDZxVnNhb1dPaGwwMUwyS1ROYnF1Q2lUWmRVMDY4OVVoUjVs?=
 =?utf-8?B?bStEVllNanMwTkdSdXRtdmhqRU9PVmRXeXpTKzlvaXVqRTV3NGNKd2JRQmxM?=
 =?utf-8?B?ZUtySys0UWRBUG1Hby9lcjRZSitsL1NVVk1DR0RwbXlSN1h1SWJlaW1hdzdu?=
 =?utf-8?B?bnJySGJ4aFQ2NzhHWjNTV0s0WmdrZjE3STQ2L0FrVSs4R3U1ZFRNTkVPU2JO?=
 =?utf-8?B?RWd5T1Q5SnN5cEVWQmpCWm1TVlZXRUZXSHEzSWdIbjA4bXRQd091Vk1xTUNl?=
 =?utf-8?B?bjVOZEduLy9lQndDT3Y2eUIvYjdHVmkwZW9GaVVzVFpjc2dlLy9EbWZjelg0?=
 =?utf-8?B?WXVyMnIwV3VINjUvWGJpMWFZTk9sNTkzcFBoUWdmQmZMZ2pRZFNDT3JzTlZ5?=
 =?utf-8?B?MlQ0dzk3VytIcGJVWU90NHdOMnIyVW9XQ1pGSDR1VDdkRnhtOFdpY1lhOW1L?=
 =?utf-8?B?Zm9GaVRkY0gwelFjR3U0RXZLZjRSOXlMcnEzalcwQW5FbHNpVGRUeC9GSTdR?=
 =?utf-8?B?Zlg5bVZjdFQrRkVWazNqN2ZqS05VZy81ZVBlbjBVRnNxOHpSV3lKUlBpZW9F?=
 =?utf-8?B?RFh5RzJRZGVZSzV5dDc0UjdlcmJMNThMbm52Q1lDbDI0WlZUc3lVNnQzaVlN?=
 =?utf-8?B?Tk1LNUVLYzh4ZHdBbEx3Qlp2V0tPTnFCMjBRNUVvS1hRRHRtNExsdmlxbEto?=
 =?utf-8?B?WlprdGJ6b0hPYk40bFhuZ0sxOXhoUy91WTdreFpGUXhwWGlsMGpFV2dkVWFy?=
 =?utf-8?B?NmJIM2d2VU5XOFM1VE5EMWxqaFJ4TnJzUmhJT3BJdXdFTVhHVXpNcVdmaTk1?=
 =?utf-8?B?bi94dXB2MDBGTFhXOXpkczg1TEhYRU90Um0ra2xINDV2cENvNEZGaWpqdXU2?=
 =?utf-8?B?OCs1MEJVVS9zRlVlRnV6bXNNNTI4ck1OaUMxV2V4RXRqaWlVUndWUjBBS1hF?=
 =?utf-8?B?N2l6NUtiSnNHNGtIN2o4R2F1ay9KTDFkR2JOSzlVeUJGaSt3a3ZoTzROUnpV?=
 =?utf-8?B?VWdFSGZGelFML3hsSnZXRWtJemZWSzJyZmtGVHBWcFRlRlV0RFFoOEtLSEVx?=
 =?utf-8?B?cVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12808AE95F8B00448F26DF9B7B71FE6A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IuuwnH1N3bi8jqDQTzfqQ++/7v73FdNkzhp/GCzw9Ihl+YxU3gMGw2fDXJhKrW7od/BrYBsVGt3uU9d/0sYVZtfy5QSYeDusBkULmLGIersVI+xVmE8iEx7C6WNoJk8hHMlaXA+Y90p4BZuz25irlbu93mZoOaOdpl5I5gIwWxcDGcZpZcttB7ZAAE0IJFuEi2c2/+MoncIO8F3Q3n45uLLrOB3hhI2fnx8Sck/debD8F4tgFMrrLBYKbwmiGwsgc55B2pKbJ5s14R7Gj/Fqylmeif7bHox79IdCqwLRafFq4ZdJL/XMTAz4XUcA07QAEVMG/aZ+hQfxpmtMYJXFYGuizRcQ759ay7Vmm3od/u23Mm1u3BGZTEqUhDrZAwFykDG9BVLI/EwQ4ZB/g0M/L6SNjA2VIYgiAm9Aydn3XkM0NqUL+A8ixNP/H/7AzhpVAflaXxfLgPq+svsLlka5zFKGTd5U+5KBf9gWdpvgbwsEwTJlxSOpDzPsBdY0zI6EB5Oz3AGQfY7FRAZpn/icpdPxF3B5XP0tkHCMRBhOYaOPm7ScXa68vqI+EftuHW3t8fz/AeEuFiHSghz9d+DJz9Uq/nsSg9plwND/MiGMbsc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e78b27-c670-45ca-82aa-08dccec3e13d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 22:33:07.2170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eiJfF8SkTN+wob5ZitgaKXENgUAAYu2eRQKivyGMEt+8suxAx1dhJuvfmtXz5m61J1GRFPhC5p9RWVUVA8wAHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4134
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_07,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=941 adultscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409060168
X-Proofpoint-ORIG-GUID: auJEyUL-X6puk8mp5F-MY4K4zP2B2Md6
X-Proofpoint-GUID: auJEyUL-X6puk8mp5F-MY4K4zP2B2Md6

DQoNCj4gT24gU2VwIDYsIDIwMjQsIGF0IDU6NTbigK9QTSwgTmVpbEJyb3duIDxuZWlsYkBzdXNl
LmRlPiB3cm90ZToNCj4gDQo+IFdlIGNvdWxkIGFjaGlldmUgdGhlIHNhbWUgZWZmZWN0IHdpdGhv
dXQgdXNpbmcgc3ltYm9sX3JlcXVlc3QoKSAod2hpY2gNCj4gaGFyZGx5IGFueW9uZSB1c2VzKSBp
ZiB3ZSBkaWQgYSBfX21vZHVsZV9nZXQgKG9yIHRyeV9tb2R1bGVfZ2V0KSBhdCB0aGUNCj4gc2Ft
ZSBwbGFjZSB5b3UgYXJlIGNhbGxpbmcgc3ltYm9sX3JlcXVlc3QoKSwgYW5kIG1vZHVsZV9wdXQo
KSB3aGVyZSB5b3UNCj4gZG8gc3ltYm9sX3B1dCgpLg0KPiANCj4gVGhpcyB3b3VsZCBtZWFuIHRo
YXQgb25jZSBORlMgTE9DQUxJTyBoYWQgZGV0ZWN0ZWQgYSBwYXRoIHRvIHRoZSBsb2NhbA0KPiBz
ZXJ2ZXIsIGl0IHdvdWxkIGhvbGQgdGhlIG5mc2QgbW9kdWxlIHVudGlsIHRoZSBuZnMgc2VydmVy
IHdlcmUgc2h1dGRvd24NCj4gYW5kIHRoZSBuZnMgY2xpZW50IG5vdGljZWQuICBTbyB5b3Ugd291
bGRuJ3QgYmUgYWJsZSB0byB1bm1vdW50IHRoZSBuZnNkDQo+IG1vZHVsZSBpbW1lZGlhdGVseSBh
ZnRlciBzdG9wcGluZyBhbGwgbmZzZCBzZXJ2ZXJzLg0KPiANCj4gTWF5YmUgdGhhdCBkb2Vzbid0
IG1hdHRlci4gIEkgdGhpbmsgaXQgaXMgaW1wb3J0YW50IHRvIGJlIGFibGUgdG8NCj4gY29tcGxl
dGVseSBzaHV0IGRvd24gdGhlIE5GUyBzZXJ2ZXIgYXQgYW55IHRpbWUuICBJIHRoaW5rIGl0IGlz
DQo+IGltcG9ydGFudCB0byBiZSBhYmxlIHRvIGNvbXBsZXRlbHkgc2h1dGRvd24gYSBuZXR3b3Jr
IG5hbWVzcGFjZSBhdCBhbnkNCj4gdGltZS4gIEkgYW0gbGVzcyBjb25jZXJuZWQgYWJvdXQgYmVp
bmcgYWJsZSB0byBybW1vZCB0aGUgbmZzZCBtb2R1bGUNCj4gYWZ0ZXIgYWxsIG9idmlvdXMgdXNl
cnMgaGF2ZSBiZWVuIGRpc2FibGVkLg0KPiANCj4gU28gaWYgb3RoZXJzIHRoaW5rIHRoYXQgdGhl
IGltcHJvdmVtZW50cyBpbiBjb2RlIG1haW50YWluYWJpbGl0eSBhcmUNCj4gd29ydGggdGhlIGxv
c3Mgb2YgYmVpbmcgYWJsZSB0byBybW1vZCBuZnNkIHdpdGhvdXQgKHBvdGVudGlhbGx5KSBoYXZp
bmcNCj4gdG8gdW5tb3VudCBhbGwgTkZTIGZpbGVzeXN0ZW1zLCB0aGVuIEkgd29uJ3QgYXJndWUg
YWdhaW5zdCBpdC4gIEJ1dCBJDQo+IHJlYWxseSB3b3VsZCB3YW50IGl0IHRvIGJlIGdldC9wdXQg
b2YgdGhlIG1vZHVsZSwgbm90IG9mIHNvbWUgc3ltYm9sLg0KDQpUaGUgY2xpZW50IGFuZCBzZXJ2
ZXIgYXJlIHBvdGVudGlhbGx5IGluIHNlcGFyYXRlIGNvbnRhaW5lcnMsDQphZG1pbmlzdGVyZWQg
aW5kZXBlbmRlbnRseS4gQW4gTkZTIG1vdW50IHNob3VsZCBub3QgcGluIGVpdGhlcg0KdGhlIE5G
UyBzZXJ2ZXIncyBydW5uaW5nIHN0YXR1cywgaXRzIGFiaWxpdHkgdG8gdW5leHBvcnQgYQ0Kc2hh
cmVkIGZpbGUgc3lzdGVtLCB0aGUgYWJpbGl0eSBmb3IgdGhlIE5GUyBzZXJ2ZXIncw0KYWRtaW5p
c3RyYXRvciB0byBybW1vZCBuZnNkLmtvLCB0aGUgYWJpbGl0eSBmb3IgdGhlDQphZG1pbmlzdHJh
dG9yIHRvIHJtbW9kIGEgbmV0d29yayBkZXZpY2UgdGhhdCBpcyBpbiB1c2UgYnkgdGhlDQpORlMg
c2VydmVyLCBvciB0aGUgYWJpbGl0eSB0byBkZXN0cm95IHRoZSBORlMgc2VydmVyJ3MNCm5hbWVz
cGFjZSBvbmNlIE5GU0QgaGFzIHNodXQgZG93bi4NCg0KSSBkb24ndCBmZWVsIHRoYXQgdGhpcyBp
cyBhIGNvZGUgbWFpbnRhaW5hYmlsaXR5IGlzc3VlLCBidXQNCnJhdGhlciB0aGlzIGlzIGEgdXNh
YmlsaXR5IGFuZCBzZWN1cml0eSBtYW5kYXRlLiBSZW1vdGUgTkZTDQptb3VudHMgZG9uJ3QgKG9y
LCBhcmUgbm90IHN1cHBvc2VkIHRvKSBwaW4gTkZTRCdzIHJlc291cmNlcw0KaW4gYW55IHdheS4g
VGhhdCBpcyB0aGUgYmVoYXZpb3JhbCBzdGFuZGFyZCwgYW5kIGlmIHdlIGZpbmQNCnRoYXQgaXMg
bm90IHRoZSBjYXNlLCB3ZSB0cmVhdCBpdCBhcyBhIGJ1Zy4NCg0KVEw7RFI6IGl0IGRvZXMgbWF0
dGVyLiBMT0NBTElPIE5GUyBtb3VudHMgc2hvdWxkIG5vdA0KaW5kZWZpbml0ZWx5IHBpbiBORlNE
IG9yIGl0cyByZXNvdXJjZXMuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

