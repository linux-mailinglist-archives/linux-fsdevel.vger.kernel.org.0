Return-Path: <linux-fsdevel+bounces-10259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A15D98498E0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129EC1F234B7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 11:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914411AADF;
	Mon,  5 Feb 2024 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zkd+OqII";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Dzzqp0cN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6648E1AAB1;
	Mon,  5 Feb 2024 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707132628; cv=fail; b=aZOl8hkAocb0IChsCnH/dhNWMbdYGMyf2YYWkUKIob7ptkg7CABPwhjXuta1UzTTy7l5dcSdPvNAOSYwQPCzIvI+tISlvsgGRX6RhH2UA9VW8PR2zba+HvJXNGANuNkQajPPDt4GF29rqmrOz2dReoHN1g6hRDSiOwVjDI05Mdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707132628; c=relaxed/simple;
	bh=+rfWIfl5bj4LEPAlIBqm5+67T9du0/9u20DwTzKZQJk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WJoyxWojONTnK3lHIoFYNpmdbqPNBeBzaeHrkrOUZoM666sDgWq6GuzIc+LA0KEicBEt7+votO3BPAJI3ct45VyRPwhaRv6343McUM065eoprqYma4eGupBkZn4DtLlyS70G+FeQKZqkI/oXsFBY3fSnb/1e4DKHl3SUv+ZCEO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zkd+OqII; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Dzzqp0cN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4159P5av012466;
	Mon, 5 Feb 2024 11:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Z+4vNLkh7dApZthJM8wNNfevIYVpi/AonuSavfqSQ1k=;
 b=Zkd+OqIICzzFwMscPO2B5XP+vPj1iDI2aqTN04LU18xQ2BEz4Xjd54kUEhOjoUzo4i4e
 ZObDme6r8irR11G8RtCrCGmNJ23k2NVr+xi2+UdhYusw4TlG3veVMFmck/Jla+vcWr75
 nIU0TBraH0/JbBxexUvaDUyceJDBYtCO6zm4cck6jAZ/2lir4Pjou/OdWodT0VUFaC3H
 bXzFht57OaO9ltRat9E9e79bkSgs7xAsEHqNSHfrOH0nEQeNupSkhgVpUEXjxkE6BoEw
 jkWIwe8mAZvVyyCXaaOvXCKWfL2wTqg/HXHKK4UxE/y7H++L1ge3OgG65an9XJxorp/d tQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1e1v3krp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 11:30:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 415BPFnV039462;
	Mon, 5 Feb 2024 11:30:03 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx5b1ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 11:30:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEoaifzqRZ6MUrji8KXykm/mTp2ncQEeYgUdW7QDJfGeF+ABMW72zY9YMZA1qDdQ9+Y8267X9E0pGoXJ4PGz5/SSw8wy+7CTJC6Y3JYIKetASqRfZsthByqurAph+laL+lLQcFPbNxo/JlxU8fdo8YmZFro1eyW6zntBGVAFqjaMAFvXtC+fUPKbdoCmIIeFl2oiKNAqxTtnNDzQ2dP4PnsL3OR9n/Yav+FQ+prxE+Mab26OxxquCSgjmcfGSHAjPpTaMe/y3GpxGWrocT07h01YUM2Iq7BlM2Qzqk7K+xUXSr8DlxLJ5fvHhotDhYLjEm5YT6hSwcivTUiVqel3Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+4vNLkh7dApZthJM8wNNfevIYVpi/AonuSavfqSQ1k=;
 b=oWL74SVJd2hZ96ZYxixiqubQxoyMLYJH+/3ZAcrFC1kZrLeIz/L0Sfjm2dcZsNfBRadPGVXUCuClA/N3d4FOVHsmg9+BFfcjVvY87PTpkhPzAJBnucClB8yk57YShLRgL2020DMbK/Ex+yswJon1yy6v4mH9dqqzMjv1aFeeOsC2UV5QZPhBbQFBFvbCIpnB2cecxOVJcTlzzga+b3crW38QrY6/3URjFCMqROr2lLJ5rvC2IZDwOkIZhvY3W9OtCaRxLrgns+LfmIC4pejTgSKfAcEI35khOSvRg+aM5c4gUiPZ/U45ZrXbikvLaf96yCEGtCGno6Qi+Mf1BJWyjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+4vNLkh7dApZthJM8wNNfevIYVpi/AonuSavfqSQ1k=;
 b=Dzzqp0cNn4zuQUrL07YrHb/+FPp5FVB+f/eot+jQ8UfqiVMJ3YfPQ19HW2G4XYyysZduOsNEQybbbVCi4TDAyM0tq1v7iNm85dsGjy/ri1p5NCxdRaVBHn9+7tlnkkuME9F1ig+hMcKq/Mef+qH78QBorvUNRDLsYjIcRMFNyc8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH2PR10MB4230.namprd10.prod.outlook.com (2603:10b6:610:a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Mon, 5 Feb
 2024 11:30:01 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 11:30:01 +0000
Message-ID: <2f91a71e-413b-47b6-8bc9-a60c86ed6f6b@oracle.com>
Date: Mon, 5 Feb 2024 11:29:57 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] fs: iomap: Atomic write support
Content-Language: en-US
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-2-john.g.garry@oracle.com>
 <20240202172513.GZ6226@frogsfrogsfrogs>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240202172513.GZ6226@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0169.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH2PR10MB4230:EE_
X-MS-Office365-Filtering-Correlation-Id: fe170ace-236e-42fc-8774-08dc263dca7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xGjAjyDParYUKX56Xvj8Ay8lcDOjclTYTwbLdSsx1OO9dTE0O1sMUjuPGOlOHbQHcAdlKwubZ/Ake0zrAF75oXgVbTC6meb92KeeYEPoqGLlh0u73w9iHyDKYrOMpmzvd4GqDeG9Seg2Onj7OYEQsGzaNlPV/cBKR4ZFNTKHb7zmOlXocmwU/goOJCiPWEcugtxKE5DOF8DXRZUO9JxRWUfU/lUJzC/6EgEBlzwZCY5tET6ONoDkGXfzQWWmqZJv4AaW/Iwf9FF80SW8+ficWpLyCXEVF8mOOWtmsm6U/X+SRC7XTegPC0ZH7bnH2yaPnWTxPkqri1x56zPtfyhjBAx4gKs+FRN8sy+YKBqIUc5eKDZzo+euNUFOar5ndJGoLDOfW/Usal1nzXMY0n6px+ai8fJr3eiz6K1dIOcxLnzEAMTPj19VPb1z8kLM6yMVZlufp7AXze/Bf9VvhtRgrAdMz4UXn3VmZwZ2QgGZhZAqJbKRQPieqhYlWGFP2vHFbRU+i9iG9DpHe61ujVEXZ7vG2rpvnHaa6kUMkcMxDh2uF+Jq+12J9VyyOW8CBsZtk2UVhmaxKripnNKf63VKEAVpWshWkxjARCb1n+5mPr7qMm9tMKtFhsnkGKFE6hN/ljfFUese50C9IlgQDFLHWw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(66556008)(41300700001)(4326008)(8936002)(8676002)(86362001)(5660300002)(2906002)(31696002)(7416002)(66476007)(83380400001)(6916009)(478600001)(316002)(6486002)(66946007)(38100700002)(36756003)(6512007)(36916002)(6666004)(966005)(6506007)(53546011)(2616005)(31686004)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VG5IekpwVHBoNTdMTG9vampIeng5YTRGQ1BLWHVSMHR0Mk80Qlh6dnpJRE1G?=
 =?utf-8?B?bFJVeWxGTFMyV1NRb1I3MWlZUTNHUG8rVGJKSE5pMU1henR0eHpqdUFQRkth?=
 =?utf-8?B?K2Z6eE14c0YxdWxyZHFJVFF2WEd1cnQyaitiMVZNMU42WmdNbzgxbUtlczlE?=
 =?utf-8?B?RDdUNmxJc05iTS9YaDJDRGxxQytRTTJWRFVKUm1pcDVjSFB3TXRsVSswcHF5?=
 =?utf-8?B?T01zL1ZjbEMyWSsxZWVYays4ZmF6ZU9neGZIQ3VMcnAxcXZLSUpKQVl0Vk9Y?=
 =?utf-8?B?dkt0d0pvblgwQnJvM21PRDhLUWdoOG9tSE9VS0dNWTh4RFVqNGcwMURFaHlx?=
 =?utf-8?B?Y1FZdTJZN0dvM25jdW92UTF2MDNqUEdSNlBoVEJJSFlMcm0rTER1MlYzNjBm?=
 =?utf-8?B?Q0VOUkhCNjBvdndweTl3N2FZTGFRdHVUdXNuRFlzNDloYTA0UWR6VytUVkdl?=
 =?utf-8?B?WjFDdlJieXZxZytQdlVFaEh0U2RjeENpeHZZaFFSL2dYM2MxMVhYSnV6c3Nj?=
 =?utf-8?B?M0tLRG9ieFNCbnNZNGxmVmo0ekFDUzJxa3BTakFJUkF3djAvZHRTbnlJRlZs?=
 =?utf-8?B?WnpOeWYzZWlwdCtuSXc5QngwZ3RqbEtHRnh4MCt3MThVMk82ck5hQ0dmRW9P?=
 =?utf-8?B?N1k2aVpnNWt4L08rejZuTkMyV0kxVXFaYlhhSDlQcWNadnljamxFbmczYVM4?=
 =?utf-8?B?cTAzRnhkU010ZS9QaEx0ODNGQXYwNHkwS3FWU0hUQncwaXZSVXp5TncvNjYw?=
 =?utf-8?B?eXJkSWxYZ1kxbHVqN3pmb25JWWVYTTgyTXJpMVNkWlQvYmZqNUtnT3ZQcWhx?=
 =?utf-8?B?MlRTOVFrTEZSTG5LNkVYS2Fuc3RrWmtOL2h1amxHclJzSmVuUGJGYk5ZZlA0?=
 =?utf-8?B?bTlOSWlqaUhXWDBiNU1ZdDN0dDlpV213Ri9MY2RvYlFZY1NQcWhPRzV5VmJq?=
 =?utf-8?B?OXh5aUZlQmEyRlBjZHAyaVdFb1p4WXdhUkNsSjdGcEgyamRZMkY5OUt5SFFC?=
 =?utf-8?B?NFJGMytJUWl3L1l5RGxtc3cyR1VMZWh5VExuYVc3Uko1SkY4UjVvMEZucUhh?=
 =?utf-8?B?bU85S1pLaWVsTzFkd0E1MFkvM1lvLy91a0NySjU5K1o3SlpDMkNRaDFpa0tG?=
 =?utf-8?B?THNUVkdBZDcyWmcvTGhaKzdwNDZiV2VNaDY2SHpDVGorbmp3bjNSK0xnNnpi?=
 =?utf-8?B?bTdSRVVRR25IRTlZaUxiZi9pSGgveUdkeFNwMnhUWHdvYkpCeTlramNpTkdN?=
 =?utf-8?B?WWZseHZjM0d4RjQ2T08rUEVrWlFXajBGTjhXQVNidHlVdkRhY3UyRno0Skdz?=
 =?utf-8?B?c0tLL253U3l3Z2p6ODByYXpTRDg5Z2wzTGdVc2NYQUs2UG1OdlIwYzJMUlRm?=
 =?utf-8?B?bUptV1BYWGZpbDJrZGJ3L010L0Jxdit5NkhDN0I4bTEzdGtQUkV1dG9oVVQ5?=
 =?utf-8?B?b3dVd3BiYWpyZUJiNjlRaHJlbGI5RzBPVXhYWmFlaDB1UXhDMkRkRitwUHcy?=
 =?utf-8?B?SzJmSGZUcUFaU2trZEc0UXJpemRyR3dKMEkzWkdENkZZYi9FU0FuWmtCVlBG?=
 =?utf-8?B?dzZPRnVOb2JlOEl4U2QyRlh2UXhmdmduemlMTmtHMWhRK1dRZC9XdndKVmtj?=
 =?utf-8?B?Z2h6dnBna3g1YTFTcTVSdEV5dEYycUVZTXZBNG5TQndHczBUai81UkxCSWhi?=
 =?utf-8?B?RWYrVW1vYlRIVGE0c2M2SnNZYVl0anNXU0dLYUMwckxKNy9EK01WbnhqWEoz?=
 =?utf-8?B?T0p2MithMENSUWNhTW1kb1dMeUlxL3R5NHVRbDlzZVpEUmhsNnArZnZjZXlV?=
 =?utf-8?B?OHFkckkvZmU4V0MxT1hLSkNSbjFTSk52TCtUOGRrVkM2bDB2NVNxQVNUK3B3?=
 =?utf-8?B?Z3Q1MytJRFF0WTdQbU8xU25xVUk4N1JJN2RSTlVjaHRJb0pHS3RoTys5NnZn?=
 =?utf-8?B?eWQ3UUJLTkZpWi92amNHT2ErajZmT1hPeE1Dbmxua09wSzYzM3o5eFdTWUNw?=
 =?utf-8?B?WnlpYlcvZitOdmxyeFIwcFpjMmJyeFJMRFgxVS9zci80WUwyZHYxOU8wMmdT?=
 =?utf-8?B?ZDBseU9mL3F1VS9KMVlmazEya2hsZ0N6UHVyMDJKNUhpKzAzQjIvL0M1b0VG?=
 =?utf-8?B?MW1QdVUzTWFoMDgwZ3VYUnZRUTEwMHNLc24yS2hWWC81aTQ0SFZwNmxXUWFS?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	u+ZnKvd7JFlATIMb26ZMOpdIPmLdIa0dKZCCSn4vf30MCfb1LvbnzpGGeSWEZ1P1fCuBOtWNOrMCghNctjb9jfjZCM5iUf4qnURVVT1ezTK4EfzRkO0x4wKVAvhEWAbuVyIdWGlharG12P96pVcNbyW+0oHbPivbNIN7OhEyRHWPh6Vl2rrzxMkmlJdqjpUfYRI95LOiP+S3Etgzs4v8ffZwr/94h/bEKWiWtEHrT87hLm1gWw4brDvCoga5VTyTVcwjn+6kG8YN0LvKBIcQ7eDTCRNEX3tlUzKsyPuJD/5tNW3fvVk9G6d7R/EKypO5wU709eVGpBGK+QJdgav2wTSmDBF3m51w5prdSd8B+98AS1Pml+ASRUPUQNNBsqYlBk88uVJmZ6AmgQECxIBOls5CHKfcf4Gnq+4QGVcN0YMDL3dx3xHQhQnP3GkV+fbWHhkiu+Uj4/DUFDGZOr8r63SKrsnWDtjNGoL8EhC2yppYe6XeueeXDx5Qjyeu2mdqrdz0MKJVjjQAAvPM40eUgRkN7a7qilKzs8qaDjnRXT1JdmxJpigxcGGGt6sFymQTuzI/PxwKhLp0kLCfq0Wm+bwozK50lG0gDSAJxmrQ1J0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe170ace-236e-42fc-8774-08dc263dca7f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 11:30:01.4066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3NUfUnvMyHfCMwBZBXzqYv4aKNHABr9a7OFf9YcF7fLQ4W5SIhB6uErCL/IcAuLMO5Bjg4zLz21T8F3Vg1Q9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4230
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402050087
X-Proofpoint-GUID: NkCjtPbBfvxoQquxOI7ps6DcWmI7PKRB
X-Proofpoint-ORIG-GUID: NkCjtPbBfvxoQquxOI7ps6DcWmI7PKRB

On 02/02/2024 17:25, Darrick J. Wong wrote:
> On Wed, Jan 24, 2024 at 02:26:40PM +0000, John Garry wrote:
>> Add flag IOMAP_ATOMIC_WRITE to indicate to the FS that an atomic write
>> bio is being created and all the rules there need to be followed.
>>
>> It is the task of the FS iomap iter callbacks to ensure that the mapping
>> created adheres to those rules, like size is power-of-2, is at a
>> naturally-aligned offset, etc. However, checking for a single iovec, i.e.
>> iter type is ubuf, is done in __iomap_dio_rw().
>>
>> A write should only produce a single bio, so error when it doesn't.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/iomap/direct-io.c  | 21 ++++++++++++++++++++-
>>   fs/iomap/trace.h      |  3 ++-
>>   include/linux/iomap.h |  1 +
>>   3 files changed, 23 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
>> index bcd3f8cf5ea4..25736d01b857 100644
>> --- a/fs/iomap/direct-io.c
>> +++ b/fs/iomap/direct-io.c
>> @@ -275,10 +275,12 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
>>   static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>   		struct iomap_dio *dio)
>>   {
>> +	bool atomic_write = iter->flags & IOMAP_ATOMIC;
>>   	const struct iomap *iomap = &iter->iomap;
>>   	struct inode *inode = iter->inode;
>>   	unsigned int fs_block_size = i_blocksize(inode), pad;
>>   	loff_t length = iomap_length(iter);
>> +	const size_t iter_len = iter->len;
>>   	loff_t pos = iter->pos;
>>   	blk_opf_t bio_opf;
>>   	struct bio *bio;
>> @@ -381,6 +383,9 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>   					  GFP_KERNEL);
>>   		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
>>   		bio->bi_ioprio = dio->iocb->ki_ioprio;
>> +		if (atomic_write)
>> +			bio->bi_opf |= REQ_ATOMIC;
> 
> This really ought to be in iomap_dio_bio_opflags.  Unless you can't pass
> REQ_ATOMIC to bio_alloc*, in which case there ought to be a comment
> about why.

I think that should be ok

> 
> Also, what's the meaning of REQ_OP_READ | REQ_ATOMIC? 

REQ_ATOMIC will be ignored for REQ_OP_READ. I'm following the same 
policy as something like RWF_SYNC for a read.

However, if FMODE_CAN_ATOMIC_WRITE is unset, then REQ_ATOMIC will be 
rejected for both REQ_OP_READ and REQ_OP_WRITE.

> Does that
> actually work?  I don't know what that means, and "block: Add REQ_ATOMIC
> flag" says that's not a valid combination.  I'll complain about this
> more below.

Please note that I do mention that this flag is only meaningful for 
pwritev2(), like RWF_SYNC, here:
https://lore.kernel.org/linux-api/20240124112731.28579-3-john.g.garry@oracle.com/

> 
>> +
>>   		bio->bi_private = dio;
>>   		bio->bi_end_io = iomap_dio_bio_end_io;
>>   
>> @@ -397,6 +402,12 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>   		}
>>   
>>   		n = bio->bi_iter.bi_size;
>> +		if (atomic_write && n != iter_len) {
> 
> s/iter_len/orig_len/ ?

ok, I can change the name if you prefer

> 
>> +			/* This bio should have covered the complete length */
>> +			ret = -EINVAL;
>> +			bio_put(bio);
>> +			goto out;
>> +		}
>>   		if (dio->flags & IOMAP_DIO_WRITE) {
>>   			task_io_account_write(n);
>>   		} else {
>> @@ -554,12 +565,17 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>>   	struct blk_plug plug;
>>   	struct iomap_dio *dio;
>>   	loff_t ret = 0;
>> +	bool is_read = iov_iter_rw(iter) == READ;
>> +	bool atomic_write = (iocb->ki_flags & IOCB_ATOMIC) && !is_read;
> 
> Hrmm.  So if the caller passes in an IOCB_ATOMIC iocb with a READ iter,
> we'll silently drop IOCB_ATOMIC and do the read anyway?  That seems like
> a nonsense combination, but is that ok for some reason?

Please see above

> 
>>   	trace_iomap_dio_rw_begin(iocb, iter, dio_flags, done_before);
>>   
>>   	if (!iomi.len)
>>   		return NULL;
>>   
>> +	if (atomic_write && !iter_is_ubuf(iter))
>> +		return ERR_PTR(-EINVAL);
> 
> Does !iter_is_ubuf actually happen? 

Sure, if someone uses iovcnt > 1 for pwritev2

Please see __import_iovec(), where only if iovcnt == 1 we create 
iter_type == ITER_UBUF, if > 1 then we have iter_type == ITER_IOVEC

> Why don't we support any of the
> other ITER_ types?  Is it because hardware doesn't want vectored
> buffers?
It's related how we can determine atomic_write_unit_max for the bdev.

We want to give a definitive max write value which we can guarantee to 
always fit in a BIO, but not mandate any extra special iovec 
length/alignment rules.

Without any iovec length or alignment rules (apart from direct IO rules 
that an iovec needs to be bdev logical block size and length aligned) , 
if a user provides many iovecs, then we may only be able to only fit 
bdev LBS of data (typically 512B) in each BIO vector, and thus we need 
to give a pessimistically low atomic_write_unit_max value.

If we say that iovcnt max == 1, then we know that we can fit PAGE size 
of data in each BIO vector (ignoring first/last vectors), and this will 
give a reasonably large atomic_write_unit_max value.

Note that we do now provide this iovcnt max value via statx, but always 
return 1 for now. This was agreed with Christoph, please see:
https://lore.kernel.org/linux-nvme/20240117150200.GA30112@lst.de/

> 
> I really wish there was more commenting on /why/ we do things here:
> 
> 	if (iocb->ki_flags & IOCB_ATOMIC) {
> 		/* atomic reads do not make sense */
> 		if (iov_iter_rw(iter) == READ)
> 			return ERR_PTR(-EINVAL);
> 
> 		/*
> 		 * block layer doesn't want to handle handle vectors of
> 		 * buffers when performing an atomic write i guess?
> 		 */
> 		if (!iter_is_ubuf(iter))
> 			return ERR_PTR(-EINVAL);
> 
> 		iomi.flags |= IOMAP_ATOMIC;
> 	}

ok, I can make this more clear.

Note: It would be nice if we could check this in 
xfs_iomap_write_direct() or a common VFS helper (which 
xfs_iomap_write_direct() calls), but iter is not available there.

I could just check iter_is_ubuf() on its own in the vfs rw path, but I 
would like to keep the checks as close together as possible.

Thanks,
John

