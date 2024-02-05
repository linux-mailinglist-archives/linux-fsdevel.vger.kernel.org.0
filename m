Return-Path: <linux-fsdevel+bounces-10257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E068497BD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 11:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33CB2283F3A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 10:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47830171C7;
	Mon,  5 Feb 2024 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lih1SYYx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZS8OV/Dz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1872171AD;
	Mon,  5 Feb 2024 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128832; cv=fail; b=PsgupuXQUzryqL71qM8s+jv/Se/LTJps/M4yjPSqurnKmg4+px0/J4NaQ7WKaKFfirDKQ016ei1PbqvlwrhyPr6GbIc8vipthnw7lEFb0CEJX7NePcfAOcdR/y7xh8xhM6OquJc0XAqInjQQw7ZooSjEfUL1wx1+8YiOZ9P49po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128832; c=relaxed/simple;
	bh=O1RLXysFlMOJXpb5XDTv85ZYjDM9qq+NSQTiXbrIpQ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T+9NM3Esdt4ZNDHUgcR6FjIdsQz2nlao4nMfzOyvA/cCo2hdgmBrV/iEhWy38DRyDbfXb6uUO3Ia6i6HaF4GGaolQGaalcLxaks3FZDRRjlGt9RBt03ttMX21oveVHpgygUoYw7iMaMWkna3KqNOwgKlVdRklgaZCU/CeKurLro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lih1SYYx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZS8OV/Dz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4159Ofqm016502;
	Mon, 5 Feb 2024 10:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Zn1cR5VlCGaR/kE6RG7X2FXXD1jde+Rg/iajPnARGJo=;
 b=lih1SYYx4Cxh0wRdN74X3FuHJnhefZO+CZ9L54XC7yNrBJ5zcVpn3PmDDTjZjmQWboBM
 2UUDP+r00xbr1HpDoMcV8ft3xfuGRs6Bm8loo6ABA4PgoylBLlTtfZoNGeslhL0cM78D
 uCnvpLgCSPsOtisnfWHb6FwaE86gb9Te5Nd1POwhzI4VvJ9UJdck3cAewTOJdvg0nj7v
 pAA9Q6SRZKGbf2/9ChrAX/EuVOgWjQAJg7JEWmLmMuuRT+otQ8ltgQ7F0i6XKm+lEGWf
 bUlWkSnEV5x1rp2pgZCvoNxBho3tESJ5GByOdDelAjKJJy4hEO9RjxWyvu6/QrMc0tWA Vg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dcbbfxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 10:26:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 415A0aPm039482;
	Mon, 5 Feb 2024 10:26:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx592es-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 10:26:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QM0vDZ4ebiTuEoIBFsyLRjbqYt9QNxQoHfXUMWCb15c2xcgnW8+XkYpir45EvaNdAJOsghAx8hDF9FyfUcjTfDi/4O1MNYtfg1+vsZUlnN4SI0BHu1Wsu5XuC57P85YormYDHj3FFUpj521ca7uvQFoWruaBeL8vomzd4LAO6cT/iCSft3zxT63NnEar0dP3qfud6YHS21RD+c61YLPfcFBZ/8iKa9orNys/asO8I4lXxbHJ2RJ5mftr1NKkbhqNkZFTH3IU08ZgpKaS52ZPpemFfQavHUBDJ9+uT/wnmkEd0HhNfZ36QbJfc8hMqnX51eZZG3OiA2JYj1O4nmayhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zn1cR5VlCGaR/kE6RG7X2FXXD1jde+Rg/iajPnARGJo=;
 b=H+mkB6z38vLFoZ4OPrSlcXzU1mr3I+7lEA8IUB3LmZVVLmdoVQ6J/7WOyNK3Z3MNxpibmb0oKnbVDLPOugTH+P2hhwt/7fu+nXTMS8dr0JqD9emYhnZIVa+4Q5ArXEtOhZBQWiZZdkFpS15bpKjMDy0CMcYx2BxhKjQ4f9W6Ef+5sCS0sCFf80tnuw2W7ZXO/NbA9e7G7GFTsSV850U5L2V9YDP82qFQ10X/zbmSOUfelQeegGTrq74Juzf9b/Etkem22RRLKuBFFxQYVla6c87EuSmKAt315lPrnuShNNvRCocfwmpd6yDfWz1k96QZv+8O8Gx88EcRhaxwzg12kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zn1cR5VlCGaR/kE6RG7X2FXXD1jde+Rg/iajPnARGJo=;
 b=ZS8OV/Dzb1Zge2Tgjy47Mo133elC0Ip0Zz4cj2yaPmx6nqYgfhksIENCNwtIK8SoojQIv0/z3lNYJxUyiFGDbkPEFlpEJNGRrIJvXhOIKDA3nxET3aJU3oTy5/BjCE3wo+/by/eX2JcvIWuf6feTKv8oiwyaWnUzPoeq9Ki3SoI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BLAPR10MB5171.namprd10.prod.outlook.com (2603:10b6:208:325::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Mon, 5 Feb
 2024 10:26:48 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 10:26:48 +0000
Message-ID: <7e3b9556-f083-4c14-a48f-46242d1c744b@oracle.com>
Date: Mon, 5 Feb 2024 10:26:43 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] fs: xfs: Set FMODE_CAN_ATOMIC_WRITE for
 FS_XFLAG_ATOMICWRITES set
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-7-john.g.garry@oracle.com>
 <20240202180619.GK6184@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240202180619.GK6184@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP123CA0003.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BLAPR10MB5171:EE_
X-MS-Office365-Filtering-Correlation-Id: cd39446e-c863-4085-4f30-08dc2634f573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1tHSv6sGNCYe3V10ry99GC37DNVnL2B7Ye4X8aWqQgebp8yKZLg+cV3RhW23jy2ZnyIHvNL1CHyWLvYDtp0libkh79B+cPItQxNWr1lA8XvHypgWuQ60Ryr9tC6lTZ5pmyS3CnnXz/DOfvI9ukpbaSygyMW+/CHY0tMCl86jZVDStmRXAedrJ/dCDegcGxCfu1pNcmDv+ntcL2KLOf7hb7v2EB2UrhrP4r4V8wxPMafBOqM2y8H8nwmTvK3IWM6u2qUQUvNQOtht7cn6Nm9bu2S8lSMwX+u/QagQ3jmPy0aA9XcoeIKipPcyGeOBPxtg5cSIhdGu/3TOUf1Cx7yjGntdT6R5o8+cXnjlJOTAvgxctUoJVY+OpiaQBfXTjsAVHBD7V6Vvr2MfPvcH6uOlXjAB/HH+53+NfKRrQWCWOHW+Y7ImEqR+CenpIDyVCngwLFNDdcoZpA5RrKok2ZKZnp0yTWja06OdK+y5ljFsH4XbKPi3me/sjU1XS2azsZW6yPBwg6MUO7Xi5y+d3VM6NFCL1MgjNNeCeYo61rJd5FI/ar/MJzMA8OYUu4GkoAejNmb0hmegvoFPw8W1SbrMz/NR9+iKXSgCHzQgofiGPTz9K8+/m08LmfNjJ8mcp1gnkP0l/N+3bXZk3THSp332Jw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(366004)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(38100700002)(6506007)(6666004)(53546011)(36916002)(83380400001)(26005)(41300700001)(2616005)(86362001)(31696002)(6512007)(36756003)(4326008)(8676002)(8936002)(2906002)(478600001)(6486002)(7416002)(5660300002)(6916009)(316002)(66476007)(66946007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b3cvUGRaZ1V4ODk0QiswejFNVmNhRVBQaFVsejVxSUp5cWxwN2xpNXNMaFp5?=
 =?utf-8?B?ZWdqRXdxYU45NHU5Q2FJMUxHMC85RnpiVWNIejlhS3RaYnFvYXhhNGE2S2Np?=
 =?utf-8?B?TUFVR3dWd3hybzRXcC9aTTRTZ0FDU1ozck84NytkbU1CV2g4Zld3QzkyZ01M?=
 =?utf-8?B?N0J1cVEwNE5iOXlGTlM0Y1ZQL3V5dm9QZkkrMWtzUmlJSXpNSmQwanFmN2U4?=
 =?utf-8?B?R0xZOUpzRFhCTm5DbStXQzFkM0xxeFRCdWJoN2IrdEwzYitUd3lKRzNiMDUv?=
 =?utf-8?B?emxHRDR1OU5BZWtlMk9tVEVyb1J0YnpCSksrQzNHYWhCN3ViRkpzVVIyQmsz?=
 =?utf-8?B?VDNEY0ZWVUJQNmh4N0NuUGxJWU5rOXdSc0JCc0FjZmlFQm5ONWpQdFlrcjN6?=
 =?utf-8?B?VzA2U0x6K3BYMVM1Ujk1SExReC83SzZseWo3Q1lOYk92UUx0UEVSbDNuUkpM?=
 =?utf-8?B?NS9OWFh3N1pobldKWmtFSkYzR0dKSmZhK2xQS2V1YXhzOFNwN1JGVThnZVYz?=
 =?utf-8?B?cGxIa2JJYllnTG56amk0cWdhK0VaZDJSUHVKWld6WHducHZDeHNFZW14bWF1?=
 =?utf-8?B?bG8zSW90dm8rbWYwb3NSVWlyclpwK0t4SHMyMi9JZmdJTEF5dS9RQVg0YjF5?=
 =?utf-8?B?MGpsaExBZXQvRXA0ZWp3Wk50Q1VTVXRxcGZYMzlZNnoyZWpOMktiTnJsS0lM?=
 =?utf-8?B?elZ4alBIRStKb3Yrbzd6d09LRlh5alFsbWFuQXRpeTlCb0YrdXpNUDhlTExM?=
 =?utf-8?B?ZW13S3hmUGJqMjZLTklULysxVWJlUUxtL1FvelZCL2wzWWxOZ3owM0Nua2R2?=
 =?utf-8?B?eVV4WXZReVd1S0hXYkRmMGpqaFU4Yys4SFdkVzJUNlJHa2FydEd4VFNZNm5z?=
 =?utf-8?B?Y2FybzVNdk9PN1ArdnpUeGFsWUVmSXFyNXBMTzlDU3d1MG4vUVRDbkJhZ0tV?=
 =?utf-8?B?WTlPZXBKZEszTnBHTkhYS3pLUlF5WVlFUXlNSGJBMlVCK1A1MmV0dnNhQXZY?=
 =?utf-8?B?UXN2T25QZEdKNlFCYUtWMFRsOGtuVUtqWU81eGxzZVlHNUkzT2tOMG01bU1u?=
 =?utf-8?B?czVIV2pTdlFwa2pEMU1yd056Y0JXM2xCKzJiMVNvYXZMS0QxRWlOSzdhTW5i?=
 =?utf-8?B?RWJ5ak5KRVViQUorS2hoVHcwTEh0TDZFNHhSWkYrbzBkbnlBazB5Ykp4bHM4?=
 =?utf-8?B?amYxdmVpaTliaSt4ZVpaSHUxanROcUs4dzc0SEg5Q1Yrc2RLTENzLzM0TmRF?=
 =?utf-8?B?V0lrV0NNaFRZQURUbUZtNitJRSttSUhWOGNKeDQ1WXpuc2o0VGZYVjhPZ20w?=
 =?utf-8?B?VkFRZHZSYkZ3TnNITFFQZTFrZTJvUnhpc0gzVXhKd29GOE9CWjNZL0xXMWlj?=
 =?utf-8?B?cEd2OHVDZGprZ3NJeDFRVkFodTkrUGlmemhxWkFWeXNzQWJJeWRqeW43UEU1?=
 =?utf-8?B?dk9UUU1BWVdQVDVQZ3hWdTBYU25hczRaaE40bmN2TUt3Sm1IS05EUW9Ia2hO?=
 =?utf-8?B?NUMyQU9lU2dQL2dQVWJnWnA4SFNVam95ejh0amJlenFPdStaM0duNEh3b1ZM?=
 =?utf-8?B?eDNPS2g0ZGRCUVFXWnJDOXgzaFRMUFpaUUtSa0ZPTjlCOTN3WGxlNW50bUha?=
 =?utf-8?B?M25pdUZSVFp4OVFWaitBSUkvSE10YXYycWVmT2JLd2xtSEM4ODlFc0NkU1lu?=
 =?utf-8?B?amN2eDBhQ2VxdTV5YllLd2RvV2RKWXlENDdxNFFWMlRxNlozSmxndHNtdlBz?=
 =?utf-8?B?OS9ETVFZZkZDMGc1YzBUNmJVUDNoRVJWL3JRb2VYTUg3alBpOXhKVGhFMmVk?=
 =?utf-8?B?WkphSHpiUUFvdEVDUURsdHpLMWwvYi9uN2pPbTJuYnBDZEhaOXZzZ2wyS0kv?=
 =?utf-8?B?R095bjJUR3Q5N2N4aXRJODhtYjJIcjlSc2tJaTNZbDE5enVybjhHM2tQdk5E?=
 =?utf-8?B?dHlMVEtpUlJvUmFJcVYvNUwwV1VJZ1lIdVI3VGpOK01ETDVKdy83cHVOY21H?=
 =?utf-8?B?TEhFRGR2YnduUUs0MzNnT3NNZkNWYXVqbndpUUFGWDcwaG4wOWpBU3A4UGhp?=
 =?utf-8?B?eHl5NXhFUmhrbjNsbzhSaUVkbzkzcXFlUjNQRnJ3Z3ViNzRDRHdWRFVoazNF?=
 =?utf-8?B?TGhlNHVBdHBlQjVHZUp2SnZ0SXZDYXRNRGtwVnZ6UFZPcUs1eURhaHNBZnZW?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mpwi0a5ZEjYadHSg4F6j/hg6S1wsNyTeQE1OMS9oqnRyKC/BnN0S6bMuvkxKHZFJA4SFHg7ZAWAr9b9SA/5UUOTXNwOMopKaNhdGBG7n5n8atB/Qf8vMxIYJHLfypMDgrSNwnnmCcRuzNf1QnMXweXJEbTcnepLLv5kR3lk88b9T9auPdy8h2M6i1kfruObsKD/HdPk7zf0D2GlzRz2RM/d8CBY7NTnHl6UwDSoKuh0yuc4av0XGhg4sRmDX6wHslPdHCQ4vkTziVopaGSppI2eqdM918TYerAPaacUDkDv5+njW4oznBJZXZ0CDwyjtR4fedyAPMTqynoGeu9VEJYckQjCfKnTDcTLQk4bPdHeMwXdXoBPGS60u13YO4EstKc7t1KcRBEg0xxVFBh2KjrizvDbQwU0ORosTYkIG81POUEUCBF83Y07Hfy28bd6tVgwCkFv8uWxE7UXs87zwXdZZ3Yj3v+bMk4x0F29iNuDhO3pN26MUcoAeJwVxYoh/pVOrS87z0FZa1K20QM5iv3uHqE/OPY4e48wVJ4k1LYlZES7fC0IKYFCyn/VMTQwY6esLIOpVBIUU7T9GokEpX5mktfRsFhnKyUge6H4LNt8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd39446e-c863-4085-4f30-08dc2634f573
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 10:26:48.0588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2oHfumdA02f0Spd8jbxBE1usFdW12DFUPirWUJNpF45qP1jKFgqxLVde7BMWF+wkJMsqm0YmjiAvEQcyZccq8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402050079
X-Proofpoint-GUID: FFDN67C2HZzaof5OfGkmSMJrtuKBNTcR
X-Proofpoint-ORIG-GUID: FFDN67C2HZzaof5OfGkmSMJrtuKBNTcR

On 02/02/2024 18:06, Darrick J. Wong wrote:
> On Wed, Jan 24, 2024 at 02:26:45PM +0000, John Garry wrote:
>> For when an inode is enabled for atomic writes, set FMODE_CAN_ATOMIC_WRITE
>> flag.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/xfs_file.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
>> index e33e5e13b95f..1375d0089806 100644
>> --- a/fs/xfs/xfs_file.c
>> +++ b/fs/xfs/xfs_file.c
>> @@ -1232,6 +1232,8 @@ xfs_file_open(
>>   		return -EIO;
>>   	file->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC | FMODE_BUF_WASYNC |
>>   			FMODE_DIO_PARALLEL_WRITE | FMODE_CAN_ODIRECT;
>> +	if (xfs_inode_atomicwrites(XFS_I(inode)))

Note to self: This should also check if O_DIRECT is set

> 
> Shouldn't we check that the device supports AWU at all before turning on
> the FMODE flag?

Can we easily get this sort of bdev info here?

Currently if we do try to issue an atomic write and AWU for the bdev is 
zero, then XFS iomap code will reject it.

Thanks,
John

> 
> --D
> 
>> +		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
>>   	return generic_file_open(inode, file);
>>   }
>>   
>> -- 
>> 2.31.1
>>
>>


