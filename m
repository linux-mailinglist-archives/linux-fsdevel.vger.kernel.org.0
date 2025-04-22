Return-Path: <linux-fsdevel+bounces-46887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8898DA95DC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 08:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FBC33B7D79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 06:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753BF1EFFA5;
	Tue, 22 Apr 2025 06:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bj5VY4Ct";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SbQ2jtqm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB681DE8B3;
	Tue, 22 Apr 2025 06:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745302141; cv=fail; b=csrsSF4vRFkuizgoPrQ7P1bq5jfKruxOrWajFQ/ao+c+HP4PWEVkfHqmwnnw3auAXdSLlE3PIvZMcmsnRfkP61/AEDQ2DVnZYfHFyYeIaSCqsoiN4UhOzxYd1op4RLQF0ffoHpjjzOsu8o1aGe1cglKX1J77Tn/3B7g05j0/A34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745302141; c=relaxed/simple;
	bh=Kl804iXKYIdSZI+N0qPjUiznCkshaTcWy5bRtcENHwc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nSrpzGeHDL9U1HFMNr5y0eSws/vpslYTA9hHUaJGBn+HP3VagrTxUIXXU7p9QeLeL2LONmLik5Nbh5ICLRIAsNsHg4l7j++hkes72qAhAvPFmK+4Ff4J56VzPafsoFEHKNQWeveDhD2rFL6OfyqvtyqbVF1O6XK7Kcks9RYmmEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bj5VY4Ct; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SbQ2jtqm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M0fwGD004748;
	Tue, 22 Apr 2025 06:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=OXH+F5oOH2m2FhepQeWq6gsKzHzdGMu8scHqwf4JMvw=; b=
	Bj5VY4CtwnEk+32VxbSGTWJA9YFSLTMFaHkwj/Nqh/4J1s7EwOpFF7YSKQ3tF03d
	emEnoDNCw4g4TnQqg7HdssrWzoaCO7fv3Jvjoq8zO+c6vIn3rNoMyjt71zKPxv7X
	F+1tMKS1lHK41P8uc6xGcXR9SN227Qc3gzd1PwV4chRDRRcBoF/bBN6F7MBSooiA
	eD+eMj9wsaSLrQ3yIhGGXlQwK+/nXx7BVDN0B0sjc2L8P9Cq7M8Yvt69Fxty6ugj
	9QfrGgWyePYd5Rra7p3LRz+XQ29zp/1mPVoGF60Jhn62QBhZocMCEMUNXuRmMFjI
	DEidFLPnn4+DZ+O4mBlCig==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4642m1utaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 06:08:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53M5cilm002904;
	Tue, 22 Apr 2025 06:08:40 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010007.outbound.protection.outlook.com [40.93.13.7])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 464298x7uq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 06:08:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NT+zedpIL7l0Cbo45r4lSnjCvhRVwXWVWrkN3uf4YwFFhUCJxboSo0Ti33F9BJ5Pwl8eoj9U0ys4ZMPf7d8V92yY6Ab5jsZrASoM7b5YKPfndjGXg+4e+STPF7M5okysj/NbOnCC0SxuBDcLdJiIoLFoEpBFX8IHFfxpTY7qPn/BS+phwrXYlCjozBTR4yeunofmmIkdofSgUmVOTXgaBMS+alt2fOGRfFmhnsRf4va3vBNtPDmSoQPAf+9/8kHj2AfqHqiqFe1OChCa2Y/kTOR/KwJ5jNtZA1Kyf8D1fiA4rEfx7I0tb1okOstjEnBP9MMBIHde1Os2rkR6ydF+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXH+F5oOH2m2FhepQeWq6gsKzHzdGMu8scHqwf4JMvw=;
 b=X9uD+14B81fgGWe25lq36h1oAtHQ9QYvEKwnomg2p71NI4gcP1CTHOSBn0kM+MHz/b0mfxeWcS71iTQ1u8GARFun8tepTN0mi1ylODEM1bd1kABYcqLWoQ4LhcxGdIq8R5GGiTiK67j+/C3SC+3qong9eVHMZc+iHfbU4tP2/Us7Z+Ub/9gfuA6Go5JXMRp+m/6UbTrdQrcAMxRt4Tt9m3z0O8JnmSdjmERS5g0yypcFBkrAjL9F9xSaKozMXDNMIiN8XgFr+WIwpFzGgAoKaR6bwCcwckRTmS/uId0n127fp20lIB3DuOpvvDR59CWV2bAIfhOKRfiFK1Wh+hp/8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXH+F5oOH2m2FhepQeWq6gsKzHzdGMu8scHqwf4JMvw=;
 b=SbQ2jtqmG9TiToma0WkKKVqK1ZreyG82GbeOV8KaVNe7qqUbbXVXewEbampwRMEDp4Wh9VWglW5Jm1JnfLrPCHD4SWtGB628FScAIy+Ai/MOaeZ8/mTpqsOFVHqjL49cvEjtglb+jL+7Utq5yQiHGA+2kYr01xq6waOyONLh3oI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB5785.namprd10.prod.outlook.com (2603:10b6:a03:3d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Tue, 22 Apr
 2025 06:08:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 06:08:37 +0000
Message-ID: <69302bf1-78b4-4b95-8e9b-df56dd1091c0@oracle.com>
Date: Tue, 22 Apr 2025 07:08:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/14] xfs: add xfs_file_dio_write_atomic()
To: Luis Chamberlain <mcgrof@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org, linux-fsdevel@vger.kernel.org,
        dchinner@redhat.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
        catherine.hoang@oracle.com, linux-api@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
 <20250415121425.4146847-12-john.g.garry@oracle.com>
 <aAa2HMvKcIGdbJlF@bombadil.infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aAa2HMvKcIGdbJlF@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DBBPR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:10:c0::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: fa051014-b963-4f8c-5d53-08dd81641f15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0NMWUk5VEtkRUZBb3VIbmQ4TUU2Zm1Eb1hDbzZ4d09IcENoRW5lT2xnd0hv?=
 =?utf-8?B?RkxQcEhidVBBcEIxRTZLUHgzbEZHZ2ZmMHZjT3VxZ2Jrb1FJRFhDWUhLSE5j?=
 =?utf-8?B?Snl3aHV3b3NxdExLaGJBbFJGRHdEeldBWFVHNE5BUDVJbXdKN0NHR0FVYnNa?=
 =?utf-8?B?Zkc3RE90Q1g0dmExRnJCNDZPbEpvdjdCaHZEckVyaTRONDl4QmJlM1gwVk9s?=
 =?utf-8?B?b0dlcXZNblRCL1dvbmw2SDhBcmo5SGVtdVRUSVdvaHdOa3RaazQzN3UzUVA3?=
 =?utf-8?B?T3B0ckpEaHIwc0pEcFFTRE1wdktGRllQMTg0SUxLQWUzUXdRRFJhNkQ1bENs?=
 =?utf-8?B?ckJhWkhqZHpZK0drRUt0L3JVUzdWcmV3OURJWnNTU3Bva0JUbkZUSWEwOW5B?=
 =?utf-8?B?eU1qdUtXbHBwWVJSRU0yTXVtNjJqZjJaYy8rcGE1SlRnTlozYnMyU0tWTlFx?=
 =?utf-8?B?ZkI4Q2lNd0ZXVTFlOUh6SzlUemhoa1FTeFNvR25MS3lHcEE5M0ZEOGtrWkJC?=
 =?utf-8?B?S1BMS2xPbGtRekE2OExhaTA5MGs4cTgyTW9WZkFRRzNuY3dlVGpWY1M3bWZH?=
 =?utf-8?B?K3VRQko1a3RKMWs4UldCcGJ4RTE1SVQ4NVNxZjk1NFJ6dEFQWjdKVk0vL0lD?=
 =?utf-8?B?cmNjRUZwY2pCWHQwZVFQUk5iR0hqRXgxTmlqTTdBRnFoTUI3MkFHdzBLcXY4?=
 =?utf-8?B?Q0hpOURkSWp5QjgyZmtrYkR6NG5FMldXOGtrWXZJNERhSnNsQ3ZRNTVjUE9Z?=
 =?utf-8?B?eDc1MHlDTlMyVjFCRHB4ZjZYNVVTcWdneHpkbmJVWHlJMnFTd1o0Q3lLdVFU?=
 =?utf-8?B?L0xqZllTV0RLTDc5MWxnajNQbEhDVHFWMnJYR2Fkc1lZV3IvMFUvRjVlemZ3?=
 =?utf-8?B?QXg1cDh3cXlMYWc3bFV4aG5uNWtPM2t0NWhMZUtsVHhrUXlsYm9PRUNxWXFY?=
 =?utf-8?B?RmVTQU0wSmxwOFp2YVFvcG40SEd5N3kwRjNIRzg3WXJ5amNaZ0p3SXBmdFJm?=
 =?utf-8?B?Nm1KSmVEcEVZQnFXWlIyT0tNUmcxS3F0Q0JmRHk0RStJL3BscGNzOXdLRVpX?=
 =?utf-8?B?ZkR2d2lSUUxwL1JjVFFjaXRPUXNQUkpSNmQ0WE9uaFgwUW9EZ1FPSjdEaEUx?=
 =?utf-8?B?YXFJMURKWGZhRTZ6UklCNG1Mb0d6TWxaMm5YN3hRYVpnZHNNY1Z4TU5aSnN0?=
 =?utf-8?B?L2xDTy9uaTZtUG5PZERhQ1p5Q1AzdmNWNjl1SjhybHg0MVJPd2k2aTZ2dXZ5?=
 =?utf-8?B?TkhINVh6dmpERm52VWFCZ1JSdjFGUTBrdDl2citVSHQ5Ri8yYk81WW1KUTRO?=
 =?utf-8?B?U3IxVXV5dWtGM0hTV3NFOTl1NmhmRmpsekNkOHg2VGFIRjBjZ0VkMFdSYzZj?=
 =?utf-8?B?REFjQUIvU0NCcStWZUlDNFRXTFBmZENIVVJwYjc3Mjkzd29ROTVtVXJWYzBs?=
 =?utf-8?B?alZ3NjE0RG81emhOeFArNHZBOTBFY0FSVEJodXRrVXQzVU5oQXk2OENFWmxn?=
 =?utf-8?B?SGVnMVZhRHpJQTdWWDU3QjQ0YWFIS0ZZYlQ2RHloRERVbk5icVVndmtld2JB?=
 =?utf-8?B?ZWJRdS9SZEZOa1ZQNno2VDBweURFbmRYcUJNcGt2eUhIdmdqOVZpaWcxM0hi?=
 =?utf-8?B?NWhxYnhrVGdkQWlRV0tuVXZ0THU0dzBDU016a2NsamVZTnpNaE5PMzBEd2Ro?=
 =?utf-8?B?RDhuWC9KUXlzM0xoR2FndjhJTlF5WjdTTjZTUVd4MWdwdEpXRFRoLzVJcHd5?=
 =?utf-8?B?bFRVank2YklqOEJkWFZob3hJYjBNVllobHhNb0J1M2FndFU1akl6K0VVWm1Q?=
 =?utf-8?B?QzFHOXJDUDRWNGkvRFpMbUZJMjFoZTdxbjNmK1huZXdyWE9wL1FBb2liYis4?=
 =?utf-8?B?UHNOTjM2cmNOZjRCU2JTNlFmbGFZSjVnd0VpUjRUTWtON2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWllTDFHUWRyUnlnb0xpUjBia2t2SWhhUVdnY2I0a0hLbElyRFR0TWhBdFVV?=
 =?utf-8?B?WHhNamJXSWhhZVpaL3UxQnFwenlUU0Y4OERmblNaN0IwSTNyekR4eVhhV1J4?=
 =?utf-8?B?NWFaU1dQWjFLc0lERFFhUm83TjlyMjQ4WitwNFhOdUR1Y2d3cHluVWQySk5T?=
 =?utf-8?B?SCt3QzlyWFYreW5sNWNGamZjWXdJQjBuakxlaEhyaGNZdkpvdkxSalpPT0RW?=
 =?utf-8?B?UmVNSVZQQVA3V0lHZk9TdzVDbjBUODVnVXc0enRYU2VKRkhrdGVGSkFKTitx?=
 =?utf-8?B?SkNqK3BzSGpVMkJ4Mlk3dXVtU2YzYTQ0U3JHWk1Va1Y1c1RNT2xYUjlESFND?=
 =?utf-8?B?WHVSZjhjaDI1RTh5d0U5ZGN2RWJFd3lCUU94K2FUSjBwb0hSYmZqeE1XYjBU?=
 =?utf-8?B?S2F1U2FSY0pkcjRSZDFXOGFtMW43N05oY1BaaDRlbWlkNWdoYWJCRWFuYmgz?=
 =?utf-8?B?d01ISVEya3N0TGR0ZDU2am55U2tqTkZveGxzOGkzY0YrdXFXbzJDWnJiK3E5?=
 =?utf-8?B?Z0loN29zV2g1bjkwaUhnNnlOWkx2TGhBUExLM21admtYYTV0ME1yYkMvT0F1?=
 =?utf-8?B?VUZnYis1RGR2UDhuMlQvMmpqWkxIZzdnTldrMWoxTnEvbVNKZWlZNjYzRHU2?=
 =?utf-8?B?ZjFpOTZ5OUFpaUJ2c1VVVHdab25kcUtxOUJHZnVlMmVnMHBNZHdvdVNRa2xX?=
 =?utf-8?B?WDd5T3NHRWlMTTU0aGlpOTBJUXJhL1cxL3cySFc3RExOUDhwWjdDbzgzMVJu?=
 =?utf-8?B?UElVcE9XMnRlTDVnQko5d1V4ZmR0c0I1ajNOYkMya2U3V0FHQWVpR0pZK2Vw?=
 =?utf-8?B?UW5JNGwzckNKQVVlVU15eFVpb21wdEs1c0Y0V3BJRkg4Rlp3NWZNQ3ZQRlpq?=
 =?utf-8?B?eXJKbmNLWmpZRkJ2WTArZmpYY3BhRDVXM3BwSStlQ3NMbCtGYTEwUTNPZGdv?=
 =?utf-8?B?NnYxRFErUE5Yb0c4SUwxUzZXUTFraTQzaUk3UlpQcGtHMmJDTzA1eUpXS2ZR?=
 =?utf-8?B?bHRma2tIVWRhQlo4TzRJRDVvZVFnZVJUaWZzcm5ZclNrY244ZmJYVlVzWWFj?=
 =?utf-8?B?Zk5qQTBLT3M2SnhlenVSajUvRHRwRnRwR21GUzR6NlRieWlEUUZSWXA4N09D?=
 =?utf-8?B?djdOeS9Fa0prTW8xVnBtVEVxV3A4UXh0NWpBbC84WktxOGJxaVdmR1BaZGFI?=
 =?utf-8?B?Z3JRK2NBb215R1RlcTZraFFpRVNjUGtWNGpEb2FkaVJBREg1SGpaTXREenN3?=
 =?utf-8?B?QU1MQWM4ZjdCbHBNRlMvY2JJSVJOZFZ3UE9ra1FRTWt0U1RIQzJ1WE8zNVlu?=
 =?utf-8?B?NXJYQzBvaGl2aXJPa1JoMnRCK2swRCtKZ1pYMW9Yc2RGWlhOclJDZW9hVjhO?=
 =?utf-8?B?VHEzZUlHdVFLQ0h5U0RFeXlBK2dOclFzSHdrek1nTDA0S1JmWkZ2UE52UlRt?=
 =?utf-8?B?cTBlSmViQ29NOUtiN0RlNGxNSmwzN016WE9oMHo4RXNPMjJiR3RuMWtHNzMv?=
 =?utf-8?B?ekZHWlRWNVJoYlhES3B2NTVPaHRwLzFNbWphajR5bytFUFQ3WmpodjRQTUlS?=
 =?utf-8?B?cGZpRVl2TnBVU2NMbXBuK3lOVU40MVAzSmFCSmhSdTFGWFNEd1prVHZWVEFl?=
 =?utf-8?B?Q3RJcCs5dmZEZmVuUmdCUVRFK3VjYkk3V21zYWNDQ2hva3FzbmhZRzNGSGsx?=
 =?utf-8?B?RmovWFFEMm9DVFhRVGd4OExSeWt1UGRPeTg0TjI1eEVDb1Q2Sjd2aTZpM0p6?=
 =?utf-8?B?c2ZRR2xiTlFoa3RXVjF0Y3BNSFN3UzI1cFJ4a3h1eEFuU3B5YXUwSGdXdnh5?=
 =?utf-8?B?eThIM2dyL2tqeG9xN2FvQlZNb3RTTm9XK0tvTU44ZytteDdKWGlCM1M5RGQz?=
 =?utf-8?B?M2VyMWJJeHF5RXdsOC9mUWpJcXlwK0VYeXZVbTBCUjVmVDVUYWVhS0tZZWtp?=
 =?utf-8?B?MmNlMDhRYXRJSysvVGd6aUV1R3daWjdzSWZFUlIzSHR0WFoxdTJvOXhjR2pB?=
 =?utf-8?B?TkN5bGViWUJFNTRsTzhhSFp0SFkvQnJPUVBhaVdBSUpJcWxqYzJIRUsvYkZo?=
 =?utf-8?B?dUNCYlFXaHhqV3lnTGJDQzRDNXk2L29GUCtpWm56NmtNME0wa2ErdU12THFK?=
 =?utf-8?B?SmZKZlgvTnZEb0F3a3FES2ErSUc3ZThtcGRZNjBZUnNUVFNHSUJMMHZDT0Rk?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P//0t2m/Sw8SbuF0aWbepcJViVNspJts7sgS7hctGqparR6FIQf8JJ0+piKoXIRlxGjsAPOCD06JphXQuqliIulsKPzOs8Co/vyP2Bvd3oyYdAc/ZccHZSQrPRGOoYKef9Tqzzi7uytX/RrAKkLt6Earp6GVNur9Si0H1DCmLvAIMCa0SsoeniIXCow++qho3YkVj8YUZHIaqhutGlCE8KPSWvEIAZ6TzmyLEvtgSKMKlDGHy26YKTnC5LhnmCvD21FqU9HSxPnpekJaR0nMTUoNLrlorMVAPOutPgR32K5rRSV/sFCx7R0sSuBXwj4Y51Z1ijSLoJ7yeX8yxf40NYRF1yxis6LajZS+Jm4f9/nriItNkW6pLIIwFeRYWxSQmKSqBnaqOiCpAHHb/kgaavo4ImewYY+FIQLBMoXG2FUhWERSWx7ikzjVkTIkmSAJYzhhhOiRIxO3476Bl60A5CJL4j9ptV4QbMsIfa6/t27yA9VHxWTDXacCcApW30rXDZpI0oEhJAOS/x6cZmdxUlT01ux0TI+f/IzQhPJa/yzrzsXdZe84m0S1JKv0RYwlUWPJf3BXLwY7GPOBDL92vKlrrzSQQLZo53kj8wgiofA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa051014-b963-4f8c-5d53-08dd81641f15
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 06:08:37.6813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFItYgwqMXf+Z1l/DzPpe3grEdxAzMlUl7GuCuutLVhe07bZ7l8ogJDmsashm2sxUwak8DpXxeWu9Aj62QjKAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_03,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504220045
X-Proofpoint-ORIG-GUID: QxOOJqIZC0C9WwD-edbOLYZ13gp11VQL
X-Proofpoint-GUID: QxOOJqIZC0C9WwD-edbOLYZ13gp11VQL

On 21/04/2025 22:18, Luis Chamberlain wrote:
>> /*
>> +	 * The retry mechanism is based on the ->iomap_begin method returning
>> +	 * -ENOPROTOOPT, which would be when the REQ_ATOMIC-based write is not
>> +	 * possible. The REQ_ATOMIC-based method typically not be possible if
>> +	 * the write spans multiple extents or the disk blocks are misaligned.
>> +	 */
>> +	if (ret == -ENOPROTOOPT && dops == &xfs_direct_write_iomap_ops) {
> Based on feedback from LSFMM, due to the performance variaibility this
> can introduce, it sounded like some folks would like to opt-in to not
> have a software fallback and just require an error out.
 > > Could an option be added to not allow the software fallback?

I still don't see the use in this.

So consider userspace wants to write something atomically and we fail as 
a HW-based atomic write is not possible. What is userspace going to do next?

I heard something like "if HW-based atomics are not possible, then 
something has not been configured properly for the FS" - that something 
would be extent granularity and alignment, but we don't have a method to 
ensure this. That is the whole point of having a FS fallback.

> 
> If so, then I think the next patch would also need updating.
> 
> Or are you suggesting that without the software fallback atomic writes
> greater than fs block size are not possible?

Yes, as XFS has no method to guarantee extent granularity and alignment.

