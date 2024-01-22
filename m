Return-Path: <linux-fsdevel+bounces-8397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EF2835CA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 09:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DB7A1F2199F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 08:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FCA38F94;
	Mon, 22 Jan 2024 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CAAU8ZOl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NkJM3Whj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68F036120;
	Mon, 22 Jan 2024 08:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912253; cv=fail; b=pmt81luxflaK/bxGz+GbC3hljTcalYHEAbfpC+ra7bem8AMMp++s6zDE6ikzrVGttMoq99aUn+WF/HAd2r7k6oP6Nie6t017AGhc0wVnr1dsvoztWJJiaDlbrkVI0k9p4DjWil2rMtrpEn8C9mEeQ+Wzu+hGvEiHdvuC3JIY0V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912253; c=relaxed/simple;
	bh=pyM/WiJIcuA5IzKZWhbZzIN+OcJnfdo5TPtpJsZKJ6Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T3p6uNqXwaDJfETxtjX2wbnsa6BxpJsHZfBky3NpMNwLdIGj3UTia99KEResi4IyViWKkHr9OHu0OOWyFeXk0bijrLiBmrrU6g0laqSmNHZZz4nq5cPon4y8Mh+ElqgCYlvITDtQK+gYeo6xVAa84UECCPWUJrxCFZnvu6jdYxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CAAU8ZOl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NkJM3Whj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40M7g1mY008112;
	Mon, 22 Jan 2024 08:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=7p9q4Otjtl84UgQiGJyjQ1R9f/Z8EbiZYT4EZTUX0nI=;
 b=CAAU8ZOlctxNIg2pC11gkRgOn5tpf3e8x9WUJJ391+mKqYfSnbSlH1pvuavZ8U0U5QUR
 lgu8BXGivbL/2ODZF5ajgX+ySbpIczoaq/XDLl0wY8/DpRk+tRLjmcgVzwU0E+Xa0mO1
 0IYffaRmSHUVsVz/+VM06DwRIWLonThtUS/xi0cQ9m1mUTnOjRztaj1g8E9FNs9vlQ+R
 Qw7T21DoiJpdBgb9QN9nIm3sQUkf7DGoCRZcXfranySoNChl1wkKmDW2ptpmYaFbN6pL
 9dm9J4x5mlDXZi+tQ047ssS1s3kXaOAzWisyCFexoHOTr+tBAxPmOg9Ee0muIYXoeMJm IQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cxtukr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 08:29:36 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40M8Fg4d039337;
	Mon, 22 Jan 2024 08:29:35 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs36yatm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 08:29:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYAF1BDde2P78aGvV1UIGDz8ZC5PfFNL8WEaJPV7RyGZkzMLXeji3KAiWmGXIphUPteKvk/3JFgQy2uMDkMKZjeL3rar9rwcXNZbFhH6fMZVlI+fH3TZXXoQXyA0PUkGDOnuKJ09vXZGT3qAAk0ZVNnytAgcuyTN3xyw3CVWLziRMvG1A5+N5DOO3uaif5Tcg54MDLyoE23VISb26BAuADSzr8BTeqpFJhqF3KMFN0Jvq59gC73PN0c5pNJLyGU+VU6rlC87K6N9mWjFJgyFWmbVkzJKZJ8o0kjIuh8HV14v7VAQ4aJ+8s1hRUTpXSlVMcMxB1cqAdmy6YCMj2cs5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7p9q4Otjtl84UgQiGJyjQ1R9f/Z8EbiZYT4EZTUX0nI=;
 b=mwAEIxltpowflhCIKVWaO/63HApHT4w3ItoIl+wdsx0ZzeLxZCKvpQmOL1fpURIpOP61AzzkJ+ljIfwfI6fCcp0paajVNF4+Q7lbgwljjUPoVDMHSMR3uBayCnudpL+fzRbkX2l1mTL8APj1LriSV0t+TVUdvVzh+OjEWoZ0dzqrVw2N0Wgjwjl0DpJP2yqnzCiLvlmL5Vi72SmCLrCbBSUZvZxphBj1GG2za9ogtWWe/geIwJdhwK9eD3YZjhKXIEICkOZTmuQG7g+wZqo/NvK7aPrK56UMDhZDAcxfF4oxqw3ncJ+00xwiZdE76bJj5vglrYCWXdJACJSEu9zF4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7p9q4Otjtl84UgQiGJyjQ1R9f/Z8EbiZYT4EZTUX0nI=;
 b=NkJM3WhjFhgNndl9JXm2t9IUozHE7JuyOQdE8uwYcTzsTt60ysvRRqyow4KlFl+mPylYS2KYTT9XAVf932E7DalVSwuBnJwtxhqFmCWvfM9sqo8fJ3GxB0K9RwDkq00Xh8G3u3RqOk+czZEEBkvaxVTvAt6G3FRiQcRz5J5fuSg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6692.namprd10.prod.outlook.com (2603:10b6:610:148::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 08:29:33 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%4]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 08:29:33 +0000
Message-ID: <6c1c9cf1-9202-4cab-9ca7-404c2116b21a@oracle.com>
Date: Mon, 22 Jan 2024 08:29:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/16] fs: Add RWF_ATOMIC and IOCB_ATOMIC flags for
 atomic write support
Content-Language: en-US
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        bvanassche@acm.org, Prasad Singamsetty <prasad.singamsetty@oracle.com>,
        dchinner@redhat.com, djwong@kernel.org, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
        martin.petersen@oracle.com
References: <20231212110844.19698-1-john.g.garry@oracle.com>
 <20231212110844.19698-6-john.g.garry@oracle.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231212110844.19698-6-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0235.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6692:EE_
X-MS-Office365-Filtering-Correlation-Id: c70fe653-62de-4f92-69d8-08dc1b24428e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UHjBsGkwBy5EPISJCiwDsJqNY+2GfSbMaOQQB+o0nH2oyWAhG15I4EtlMsWEcmvwoqxJeRzpsxtzOekWqfhnkgZ7ZsyERDmVTgK2wUgMpmfL6KQueI3a8QYU/VCn8scHWhr6dMweL1sM7+C1/7ixdSzccEtjImTesDaGS+zBMmyAm6mK7N6eMwOo7+SPYn1kp4aD34AcIkKmSlOt/0yOiHc1oefLdxMdnGXE/FGvx0gj2fxkEmJbi+PglvQ+v8M8DDGrxhvUGFYFCliqZxoVJt/IaAafHT3LfsEzbigFLdgAXXmRSecGlPinNxz930jU/njXjE/9TrWgyVG78QeE51z4RXH78RcCEoIDd0PF4PE/Xa9z0JmpQ9o1vDPTzuDWJnRL2ctZRiOgwUCx+BUusk3jjD09zFQ5mipOBZ4sHpInkOJ3AQAxfVs2b7qd84tanM/vlulFLqtwTAyqtirx+9lNcQrOhTV4vjAI4Vygzz1cI0xP0kuyRpQ6YSRSc/c6CTHs3ytPQm8L139Myrink22xHWPKqGCAoIY7RxlXgqmX1Q9eol3FAaKPeFDZfKtW7YIwfBUad5k4ZwU6s2KMN3RtGhcvklAUYVrKFu0iq+pyAgoc/vPI1K4zVxEgYelv
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(36756003)(41300700001)(31696002)(86362001)(38100700002)(6512007)(478600001)(6666004)(36916002)(8676002)(8936002)(4326008)(6486002)(6506007)(66476007)(66946007)(966005)(7416002)(66556008)(26005)(2906002)(4744005)(316002)(107886003)(2616005)(53546011)(5660300002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SHZwY2ZuWndYS0RSSENTcDdyUmxaTW9LOVBpSWNBbkxzQ0FpSi9NNUppU0lv?=
 =?utf-8?B?SktuNGdDTGdSQXphSzZMbjlsN3Irb3RJYzdOWWVjRmxqcDAzbFVJd3Iwdk5N?=
 =?utf-8?B?U0ROb0xMVnB1dXI0OWhKOUVKS1ptVGNYQWJwRnhuUlhJT3k0OG1xeEd1WXdp?=
 =?utf-8?B?U0ZDUzJRRTFUQkR5UjZ3a2lnTUtSTjVYTUplczVwYVdmUzY0SmJkenNzWEI1?=
 =?utf-8?B?aXJEZGJhR0UrZGZvdU5WR0VKRXRDUWt5b2Y5eGkvVDJDalNQWmlmUlNTcHpv?=
 =?utf-8?B?UHE2eXd0MUg1ZFpkREJJelQvSTVKWmJlMS9jVWFVVWc2bDdZZnRBYXQ2MEdS?=
 =?utf-8?B?dCtKY2R3TTJCUmtXS3lrT1E3a0FmZkFxYS9wZ25zZFVycjBMeTRZYkhqZ0Vn?=
 =?utf-8?B?UmJRdzVMZFdoMTBQTURyaVkxbWpCY1YzVUdjRmtQZjVpWmw3ZW5ISXNaWFFj?=
 =?utf-8?B?MEhrSEZtbmFzN0NIc0dFL09lN3pwdlNtbzMxMUFTeVhQU2ZERjZTaUE0encw?=
 =?utf-8?B?M05VMWlpR2RJdFlzTXRzUGdvTkRNempVZUNta2lsNGsvRHZaT0dkSEtvbzhC?=
 =?utf-8?B?a3FWYmIvaFNJZmh0aE1VZmRKVno3UmQzNy9EZTVpWjNzOTNpcW9CZFRLMlFn?=
 =?utf-8?B?N09DbFZMK2d3eFFSa2MzdTJVaDBocjBoVVEvdHhtTXMreU1TVnIzRnAwcWZn?=
 =?utf-8?B?RkFCU3dHd0xhWWpyWEs5UnJMQ1ZSMFVJNHdjSWN5NzFieGFuZlpoSDdJcStH?=
 =?utf-8?B?a3Q3dnBYMmcySXUrMmkxa29VRHFHR2VSK3VZZUtldjM4TDY0SDhyUE9nUXJO?=
 =?utf-8?B?Z041cXZtczBFUDhVNjhBQzNMMFF0dk1LK0ExcEE2OCtFMm1vZ1dpWk9UeXdr?=
 =?utf-8?B?MFlqZzArWFdaMit2b3FTalluNjRxTmd0dEt0MEZPRGpjODRXWjhhZ1o3UHFT?=
 =?utf-8?B?dzNMejlLK2Ztbjh6a0VsYVNFWlc2RS9EcWx5ZE9DVHNPOUtXVDc1MjQxK0N5?=
 =?utf-8?B?UC9sYzhoWlhLaDZUaTFoZGpxZndWWDhUMlBBRzI0MG84bTVKdVd0Ym5QOTZ0?=
 =?utf-8?B?dE04U3AvMDhTTGU4VCtZYU0vRitCVE9EZ3dEdTJtNnpwMExXUVpyR2JhajBH?=
 =?utf-8?B?UXg3UG5LcEFacUF6QmhDNnlvbjlxOWx3WWZOM0R4UmxwaUJ4YkhNWWRrbTlD?=
 =?utf-8?B?V1JnMmsrdy9tZjdoSkljRTA1NUM0MVM3MVJrUDBvY3MwdDRmUmVackkwTnNM?=
 =?utf-8?B?STE1MG1POGlITkxpQktUTkxDdElPUTV6UWEyeE5TZlE0ekpQNE41TnNPcmZY?=
 =?utf-8?B?STB2c3lUQTVMaVJkeXVxRFJqLzlpYUZFR3lya0xTdGcxMlhZNHdRRHAzbUNT?=
 =?utf-8?B?UWdmVjdUbnFmSWtudkJUNnd4blhJR0UwWE85MUJ5bThEQzZHWXU4dlVKSkpx?=
 =?utf-8?B?eUF4MmV3SVVIU015NlhKL1U5QUhwMWdvbWl2MHRBUWYyL0JOOHY1cVltT05L?=
 =?utf-8?B?cVRXVCtON1hQUlF4dEVJbFd0S0dOdWZWZzczRk1Vbzl3Y2hOM0NMUEdnOVoz?=
 =?utf-8?B?dWc3MlA1NnVkSDBwQXhubk9IV3ZKWUQwUFM3Z3ZBUTJQeWJHSS9kT0kwSld2?=
 =?utf-8?B?SXFFcld0RUxKMmthMFpZQTBwb29YcnhpQkV0bVRPVHlaMUFQWFI3ZzY0OTRP?=
 =?utf-8?B?YTg5ZS9GM0FveVBudnJjakR4bW1pb2doWUtDaDdKanFmejZhVmljZUJzN3dI?=
 =?utf-8?B?ay9IcDA0Q0NBWUpWbGVOVUprLzk1M2xxSXJkZHFnTnVJbG0rekNUMVV1dzhD?=
 =?utf-8?B?Y09vTE5GMDIvMFJNZlB3UUNkQytUQUVUdlF0dFBYRmlEcnEwS0ZObndrUHli?=
 =?utf-8?B?aHd1cXhUSWVhaVBZdVdhV1FBa3BUeWk3U1V2a1A3OTFCb0FyakNJclZ0Y0lo?=
 =?utf-8?B?VlNIcmgxNGE4aG1NdGRsN1I4R3VOWlN2L0ZpUm5lbUxnM0h4M0RZakc4UGo3?=
 =?utf-8?B?eWhTTzBwR1dQVWxqZVd5V0pRYmo2WHpET2NMMHpFTVJEOVhOK1lQT204L3NJ?=
 =?utf-8?B?dEViTE9TU3R6cVd6aDU3cmgvb1kya09iSTZMQ0xORlozQldyaFRRZ2lCVFlv?=
 =?utf-8?B?dTBFUzZ2MnZlRDZBblZGNXI4YnRLOWRjN3dqY3M4R3lJeU15ZGtBMCtJKzFT?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	A0gj8r23v04k126YlQke4gv5wlJ0cJBW89IB08PNfvwvr8ZH7jgnz6otWcpVFwakEjPOiYyh/tyEdrO6TozFSf4QnLHIUoIvvH0ZD5cdZWJoKJaHAkgKNfTkp5K9AFNNXkF+lLvREVccwnmEajCRG/L0cpQzOcf/NrQlYtqZjnNI81H5TkIgM1SuriaxlVbHsb1vx9JYTb6t2Vd0zOcL4ahgZuW6f1/xSeL+0MR8+tl6wb4Wr563EqK17Nkm0ETH4F2Q8F59Zn8MIgsF+//22kYMZi3uFAHPCGSdeFZNF6BUZpat94EZJfuqq+uyg8ebyklFGlEpA2NsHzYBvp+/RdV/eUtc/wrO3LaetrDwd+evb8z7lJIyXsoOMKVJawEM0Ox3uSaDNeKcRQlx75PnBpUHgGuiwFmDvw7HsAebGkyP7tNH1n4sagtIUKwX094xKLiFiLFBswS2Q7vN0zpecCcAhDvQkfocHHn1WWXFYQWgMXM4y82hdqA7l+J65fvSihSPlWNoHp+ITUEMPxsX5E8W0nk2U36HjV0HWZcA51roYonU4jmk2Ou1LsFADqKafFJdqecJUoByzOdJYWMpIQIkKZFbKz99YLIVFfU3o/U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70fe653-62de-4f92-69d8-08dc1b24428e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 08:29:33.1321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dEz0WwsTAJOFOdJ4kLLpNWFNvjxRlDYEcsTnvz+aj6lsBhfGhW2q+65FItUQgFxdU8Plh/DfQpx6K20qhuI6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6692
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-21_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=986
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401220060
X-Proofpoint-ORIG-GUID: HXuY2HiYWUCfvmkb27FDlT3rsYJ0yJ0P
X-Proofpoint-GUID: HXuY2HiYWUCfvmkb27FDlT3rsYJ0yJ0P

On 12/12/2023 11:08, John Garry wrote:
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -301,9 +301,12 @@ typedef int __bitwise __kernel_rwf_t;
>   /* per-IO O_APPEND */
>   #define RWF_APPEND	((__force __kernel_rwf_t)0x00000010)
>   
> +/* Atomic Write */
> +#define RWF_ATOMIC	((__force __kernel_rwf_t)0x00000020)
> +

vfs maintainers, due to 
https://lore.kernel.org/linux-fsdevel/20240119191053.GT22081@brightrain.aerifal.cx/T/#t, 
I now plan to change this value to 0x40.

Thanks,
John

