Return-Path: <linux-fsdevel+bounces-17869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 375A98B31EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 10:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3011C2210C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 08:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB5A13C903;
	Fri, 26 Apr 2024 08:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dD3Q/gCZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P9CPTj3X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EBC1E885;
	Fri, 26 Apr 2024 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714118628; cv=fail; b=VdX53BFiT/hrjsP3vMY8Me01obnn7yn0JJht32DOHcfaT0IsHGWpUS+UjUdowjXwsvDRMoDmrkbQHiJ4VUQ3+v9XzD8n34hMzerH17bMum6jQYnfyj8IxdY2gw8uF9ImZUEA7tVQBhnLNTDNuhb5FRvQAUklAGptkBmWkl7Hp6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714118628; c=relaxed/simple;
	bh=kWpU1Fr7M5S/jVdOoQ22QodjbkM45XiBg2en4k1ef3A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pidcaeQ6ltwBjABEkD442H8jpprTrfciT6fz1WZuD/NAbl/l/3eWuc2S63LaNshuubReSGwHZmM4h4vTuZrJ6myxD0NERfgWuzWb2r3pouHFLExTKlbfdqIWddLw5EXDdsriA2RB0Kt24c6q8tUS2md3CzbW0cHCF+V6zaSzVGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dD3Q/gCZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P9CPTj3X; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q46KVK015972;
	Fri, 26 Apr 2024 08:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=egJb7nlS0xZLT1ITlSU6S13nAtyKKlyicSu+hR4jq6o=;
 b=dD3Q/gCZWoceuit/f0/MZqCJZMJJUSDWNMeluw5BKRQ3rKVPHjTJn48peqfzeSYJriaj
 eMmh1/rx/BvQVY5svr/M16QYf8M8qbLYtFFwiCkRsP9OI8OUKZwuuSpgg7zRSSWAvycm
 OBpH41RLlszqYTNWfz8u40soRtz5esN1lka5yVJYOyfkQd6nfeb52pHlTqU6bfkO+MW2
 soV5T6A5IJq/1fq+7HC0K43hpf/E+q5E5S8Vixm/hfxXvx44m7dQL/Qd9NkhNsC6vzLi
 ruV7phhEUj/gpercCoZDi4sbBLcaJQrziSapRObOVJkABai2oEk/Mvj5e2U7jEgTNUeJ 5w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4mddkhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 08:02:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q7gEAr019720;
	Fri, 26 Apr 2024 08:02:41 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xpbf7e3wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 08:02:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agjiU3EAJLXCeYP1LBbffNSUYyUqB6Bqm5NzznOo/J6kPaNQg7QtvqCZynt4kGo354Ab+E34bm16BASY4Ku7ix6Uz0QJx/YfH0D4cNU6IDovH0GxfldoxQN5wI4zI/L7oI5pvVulTFnmWHbac8esWDlrvNZUrNS2uqq012DEQ2/wuQtdoHnkFAmyivCBhtuRH2ktya6OxsL6tOPxHoksp183uMc/58mruZ93BcF+Lu3bu6wctGyWuH2+alMQja3aHas0Gela+9LLvy69ESrhK5fNtYQlRe/s2ojHJCVpbUdEootpgB34kGvsxgpZBuUYQ6dyejqaFxO9h3cDYTNuzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egJb7nlS0xZLT1ITlSU6S13nAtyKKlyicSu+hR4jq6o=;
 b=MnNja4K3Rtj078UrtONbkViuuBF8qNh2ifTTbFhfOfi2GF2ZnCZfQpdAPcdo1R/qro7rr2qmpsozze6yngfiUSYil4yRPXF4CpQ2PpC2wQyZV754IqrP0t/4NlNTZaZ4uM3Dfarq8mt4/tfH7XA/f/cLcsRirvPy6GvTS/zj46M3BfJKLJ+Tp3S/3F1buPjL8i43m7q7WO0/8mHgP+XGGUvyx0NnC6SU+me5TwOjDJqQXIy8MZH7tn5P5zNklWFviQh96OpEiyVVjx8VVuyU4zJ0pdKmSJTzIAdQS/N8INhxMGBZy8lN7HVkSTahLHSVoRLaBxNtBGlspN9CbgD/sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egJb7nlS0xZLT1ITlSU6S13nAtyKKlyicSu+hR4jq6o=;
 b=P9CPTj3Xr/VvcG4d1XQIOW4b02Tsb40R5Z/LX2AzyQR3d+Hr9TrtqTL/Jaq1kGEbpt6HteQLf64d4WX8z78iK+QbtAxaoCdcXLQKvM06tvqUxItMnvywhWojv5PNc6VNUF5bsAIPAwWxZeccKkp5ut/htkzvmiRh5h4dfLNfBi8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6155.namprd10.prod.outlook.com (2603:10b6:510:1f4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 08:02:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 08:02:37 +0000
Message-ID: <db87a92d-9813-4fdd-bea5-e3d8a6838b30@oracle.com>
Date: Fri, 26 Apr 2024 09:02:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/7] filemap: Change mapping_set_folio_min_order() ->
 mapping_set_folio_orders()
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, akpm@linux-foundation.org,
        willy@infradead.org, dchinner@redhat.com, tytso@mit.edu, hch@lst.de,
        martin.petersen@oracle.com, nilay@linux.ibm.com, ritesh.list@gmail.com,
        mcgrof@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        ojaswin@linux.ibm.com, p.raghav@samsung.com, jbongio@google.com,
        okiselev@amazon.com
References: <20240422143923.3927601-1-john.g.garry@oracle.com>
 <20240422143923.3927601-3-john.g.garry@oracle.com>
 <20240425144741.houv6uoflhwmcc2u@quentin>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240425144741.houv6uoflhwmcc2u@quentin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0144.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cf0b7de-2f66-4b6b-263e-08dc65c73cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SExjWjZWT0FsOFJsR3RGZWpHL3JNcUt2RTBjbUNad2JLejUzekxyV3VBaWJs?=
 =?utf-8?B?dFZtOFBBQ09IVzlseERON2hVc29jeHNuaHB6aTgxb0w0MWNvMVo1U3NVejB2?=
 =?utf-8?B?ckU2TmYwcmVxRGwrQ1ZiTXJjTEVwTzBxYjA0MTQ5KzVNM2RuT1M0ZWZxQnF3?=
 =?utf-8?B?WEJYVC8xZDloR0Z1aW5zVVFnT0tMV3pxTlo4T2NkVXFTSDRqK1V6TjN2QzFw?=
 =?utf-8?B?RTFEeTZ2cCtxRWNYNHlvamd1disvN0R2SjFRZm0xeFd5S1BtWkxQaDhrL2l6?=
 =?utf-8?B?bFZFU01oUnZmUHU2UzdQSlgybDZyaFRtU1QrTWJrcFRoUWRyTkUrKzk2R25l?=
 =?utf-8?B?M3o2UldVNnpFbDdHWmJDTFpCaWVZU1o5RUUzREZqcFhoVWdxVWdPaGxMU2Vk?=
 =?utf-8?B?RHh1a2puZkI5SHR3YzNsa3ZiL3ZqYmxJZDFZSGI4c1IrdXJPcWVCWXZQcXpD?=
 =?utf-8?B?Vmowd0ZDTTY1eXNTVFJseXBSWjc3d3hwU2NXcGVLWXZMVmpQYXFjSWdXczBE?=
 =?utf-8?B?bThPcXdZcG1HOXV4ZWhBSmdHNnN4YnhUY3diUFowcXR3Nm1UdWVocUtoN0kr?=
 =?utf-8?B?VzR3SlFHNzdIVi9iSVJISDRpVUtOdmxMUW1peDdUMmVrWlZJdDFpSTZvSktq?=
 =?utf-8?B?V216ZUwrRjNHMzRVeEtLT0lxckVmN0RkV2pBdzB5dnppWVJwTUdNakhRdHY0?=
 =?utf-8?B?cVJHL1ZwdWlEcEpEY2s2N0t6WGkxMlhUb3l6ZEYxZjFUYnUxT2dia0xmcFFE?=
 =?utf-8?B?c0ZkWDBTOUNCTHdiWHJsa1AyMEh0Tm1ESWFOVDFPT0tQY2VVMG43OXJ6NkQz?=
 =?utf-8?B?Z0JsVm9Wb3plUlpsbml2ZXNNMzJLQ2U2NFRWOXB6YUdQWUFMTVlneEpwRmwx?=
 =?utf-8?B?K0lTdE5WaHR3T2tDVURCYmwyQnFadnJQeWw5dlp6enpGcmprOXFXdHU3d2I0?=
 =?utf-8?B?U0JGZGdZY21SekR2NWpkQjNGdG1MVXNNRnJUcVVEa0ZsL0hOSXFRZVZzQms2?=
 =?utf-8?B?WnlzaDhHQlFybEJKaFVLWGtkOFY5NDkrM0ZMN3kvczlPRW5sSFNCWEQzTW5l?=
 =?utf-8?B?UVAvTXJKMWx1MytlMFZHcXY1aHZHWkk3VnB4TWJRK3pyYzRPY01YZUJuWDNI?=
 =?utf-8?B?TVVNQlp5WnpESEY2Q2YyellFRmZTQ3ozMWh5L1ZVeGFYb2QxS0ZhYUtQbDg3?=
 =?utf-8?B?YVhTYkNNOERDcThTNUlrZUdNeVFIUSt0RHJTR2lla1hqOUg0eWJNRmh3bUtt?=
 =?utf-8?B?TEw2OFkxRjFERGV1cE9GNEdVelBGTVdlRHdabWFhblRiS2NaUGlrZzU0Q2l6?=
 =?utf-8?B?Q1Z5NnJOREcvUDM5TmJETnU5REpuOHJyZHZOMmRTOEVaR1R1OGZzOGFzRkhv?=
 =?utf-8?B?UEFPZklsUDFxTjVFRFpIN1ZTMFp5UnhTUkpIVjUyQzMxN2NxUk1IOEFTWTN6?=
 =?utf-8?B?dllQMmtlanBTcll6L1o2T1dzV2RRVmpYUzBhdnZRaERXT1I1VmMzWGZYMFBY?=
 =?utf-8?B?RTlKdm50LytSbVFIZ3FCckM0RVBtbTFCMlZ6WjAyMkNnQldmaFplU21WSjBG?=
 =?utf-8?B?SUFPR1IveENsNkNuWDBYMllicm0xbTRNQW1NZzVrdnVodHJsQmZXcU9OTjZi?=
 =?utf-8?B?eGd1NUhSbWlwbWFLNVFqT3JPSjFSYmNBbHg3Yi93TEVhNnF1ZEtLQkdCaGhh?=
 =?utf-8?B?TjRVQTFmZUhBQmlualh4TTJQSkdJRmtZS3ZrcDNpNWpZZnBMaVJOV1dBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QU1rOVh0U09TRG1CSSt0OENCQVkwVmFGR1RTUWRUcngvM0JDSktkeXZTKy8v?=
 =?utf-8?B?cWlOMDNlWFZhMFBLWTVETWlLa2hwUHVwK0NaTFZRL0ZZVHFMUEl5eTdFS2ox?=
 =?utf-8?B?aHR3L0J2eXRJQnhOZndBekxhRVYyeGxMUlhnRGZnS0tPby9rNkphSW8rSitq?=
 =?utf-8?B?cXJkWHJNMVFScjZsYUVIMHovWE56bWYrdXZFam0zM3h0alVmTjI0NGEwY0pm?=
 =?utf-8?B?Q0VmSDZjT3lNSmFZaGhqOEhzMnRnOURvUmNWVnRUclVEbitIWVhzekxSUGY0?=
 =?utf-8?B?anVJS0JpZnlmaEtXVU1hMFIxYWZqR2xCMHZIZmgvZk02d1c5azg5a0NuUEx2?=
 =?utf-8?B?aHlTRStMejZjUUxYMVc4dmM2TzhielpCbkRtREJRT2VFMUNPVVdQNmg5QlEw?=
 =?utf-8?B?blIycHhSZysvWDVsMjUyTmVPRC92dFhDZlJyejhudmkwZ3J5b2l6LzRsYklw?=
 =?utf-8?B?V05DcHMvZGt4T1R5b09qU0tHWXNFclhUajFhUU9oUlBQSzRCQkdBeVc3dmVx?=
 =?utf-8?B?b2Vjc2tqSFdBa3d3ay9IUStWamZNT0t1cy9tTk5wOXVCQWVqL3Q4Wkc3TlQ2?=
 =?utf-8?B?ckUyU1NueUNRM1VDaXBPSmJCekxxQnBBSHF5WXBHaklEelVGemFPZ1Vud1Fv?=
 =?utf-8?B?YUJWS2doa2I2WWNybUlTWXRlZVlsNkp5cnR4UUNscHBadmVjdDRIcUxROVJF?=
 =?utf-8?B?SXpvZG5SRHdiZDFlOFFPZmM1d01iNjhUVjB1QlJWZDJEay91VkxGVmYvdVQv?=
 =?utf-8?B?RVZiQm5kZjFxT3pHaFU1VjVzcDlJNFZoUGRGMVMybUZGYjRrMVRoNmFJNDBT?=
 =?utf-8?B?MW9ibDRBRVRmZlFwOE0vWm14TE1yMFlsWWxaQnF5RGhxRk5USXFLbkU5Qjhw?=
 =?utf-8?B?cDlWZGNFR0JUaG9TMGF2d1ZSNENMN0pJWTNuU29BcDNjbFdaS0dSS05HcUM0?=
 =?utf-8?B?ZTNlR1k4U2JoaU1wNFJCa29aN0tKWE43WnltdzVvNzBtbXVZaW91OUlTOUpj?=
 =?utf-8?B?cjN3V3A5ZXZldzJsY1RsTjhpOU9UL2N5c21Yam1SeTdRTHNHeHhMV0JnVzk2?=
 =?utf-8?B?b0xpTEdsc1V5ZldsaFplTEgzVmtZZ1VzTUE2b0FhVVhZbTNNQUN6S0ZjODZm?=
 =?utf-8?B?RXRrTnhjQTNIaXE4VVNNaUE3SVE1VDNXU2JVQ09kZXNxRHFxdTBoWWxZYzNH?=
 =?utf-8?B?STFLLzIxeWpEUnZNSWVUVE0wS0ZrU0pET3RiS2lFTlpiR0l2czhwZ0ZVOTNQ?=
 =?utf-8?B?Y29UL3RVMHBmUFVXUG0wMVNrMVF0cVFScUNLcmNGaUlBNFBDV1Q1MzgyN2FI?=
 =?utf-8?B?T0FFTkN1RFo3WWEzWUNBakhUUTBKck4walpsWEt0VTM1UWFYbFlPM3dUbE40?=
 =?utf-8?B?MUVURjhTMEE1ckZ2NnRDMzlhb0RlK1B6QUFEc3FLcWtKbXVqUmZkSStRRHFv?=
 =?utf-8?B?U1M4eXRNdzFZdjdzRllLNVFjdW9IenRzM3F2emNSRFRwU0RTTUJpeitKaU1G?=
 =?utf-8?B?VFkyK2c3R3F0M0MvVHY0Smcwa2dKY3p0T0FXSkZFZEF1Ulo5YmZSdlFkbFh0?=
 =?utf-8?B?MnBpSWFMUTZtYUtKbmhsdUxvVzlCSkFLMVIxTmp0eUg1eFBHeGFFanl2Z0VB?=
 =?utf-8?B?MC9NMXJ2WVRMNVVYVk1RQUFaMXpjRFdGSDNkK3E3NmNSMUZQdjdRT3FuaGdx?=
 =?utf-8?B?L0l2NkdIRXErZUx5QnQ4aG1lMG1aOEJTU2JvR0g2S2s1aHY0enp6R2ZCbDY1?=
 =?utf-8?B?QXpXN3dlQXI5WWZPZXgrK2VTNm5TK3hjRFFqRklkVXJmMUx1eG1hSjB5cWZ6?=
 =?utf-8?B?Mng5bVZJNDhXcTltQmFyaGNWOERJL2tZQ2R1Ym44MXRJSU50ZmltTDVRakNu?=
 =?utf-8?B?QUdINklmdTV4aEdoL0c3VTZCbW8zS0Evd1VpdEwvczlBMm1oVGxMUGFaeEdj?=
 =?utf-8?B?anBPNFIyTVdMQ0ZZbkU5UEJwYXVEbU1CMnVhVFd5emRXb1FEQTJBZlBmMDVo?=
 =?utf-8?B?eWt3dk5UOG95NHJlcTdNWlFBamU0UUNWbEdldGtYVVVkazk5NzQ4QzZFUHJT?=
 =?utf-8?B?YlNyZ0ZqUVFpakZMeDRiM1grQnJ5YXl2YXErZDA1Mnh0VHFLZ2Z5TDlZcXV1?=
 =?utf-8?B?eENld0pzaXVLNENHTDNCNktOVVFCaHJWVjVBNTVyelpQYWFIUGxXNGZLNnor?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CGlfwlcpMy5ecsGyI1NNnFl6028onGWafui1Yrwrxat4EkuITOUl6371OhQdAzq1W33D+YewPr4hfpgS3tPm6TIHc8gmLDGaRBfRn04/wBJlv8MQuHMLbb01SOuxiqwGoTt2g3vSQAZe0Jspm2sTlRFlSRnh5KshLehsEsxKsZCuuwYl61VH+/7/OYNy09eKcPgzv6rjzSAwK8bA5sh9lr2K40GK+cAzbiVKVlLpziOSw1iL3p55vpyfLwiZ2NHUA4pqBI+Thz/rJFYmUxYbOYAVQTxbcFx9rJSnFjooueOIC0/DhF0dnYusq3CD4U41tsbPNeM79Z563WOicwIhJwn9OA/ixVp+yJrREy2qmZ04UV2kAXR2ln6FOIz5Afxp9NRUbKftAtUnTFdGUFDNdZCa5dkRUlvfdG5FxjlexzU1TP/IJoUIy09bdVAA3oFB3qr3dTDS8kMPuwayZ9yCy/2h37DJly4tptm6qMo4WQdXJuS3d2qBfOVFonZDWuXCz9hPvQWyiB5momDfwCCfEg+mSLgyWt5l+axFN6cdM1wka2vhnOmD+4vrKFQGj+CnXjIcaGphMQHaWK+OWawtpAO9ajHok15mcviigMnRGVU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf0b7de-2f66-4b6b-263e-08dc65c73cc9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 08:02:37.5319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATLs+PdzljorOortdv/q7bpdlKVU/nWnxKrdJkcnNM/7sJyPV1kAoX6fXnsUUTWyZu+MlNMlYuSZeiFDKjHuNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6155
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_07,2024-04-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260050
X-Proofpoint-ORIG-GUID: 9CWikY-ymdwDVl5JWCpqLn62IR1_rjlG
X-Proofpoint-GUID: 9CWikY-ymdwDVl5JWCpqLn62IR1_rjlG

On 25/04/2024 15:47, Pankaj Raghav (Samsung) wrote:
> On Mon, Apr 22, 2024 at 02:39:18PM +0000, John Garry wrote:
>> Borrowed from:
>>
>> https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/20240213093713.1753368-2-kernel@pankajraghav.com/__;!!ACWV5N9M2RV99hQ!LvajFab0xQx8oBWDlDtVY8duiLDjOKX91G4YqadoCu6gqatA2H0FzBUvdSC69dqXNoe2QvStSwrxIZ142MXOKk8$
>> (credit given in due course)
>>
>> We will need to be able to only use a single folio order for buffered
>> atomic writes, so allow the mapping folio order min and max be set.
> 
>>
>> We still have the restriction of not being able to support order-1
>> folios - it will be required to lift this limit at some stage.
> 
> This is already supported upstream for file-backed folios:
> commit: 8897277acfef7f70fdecc054073bea2542fc7a1b

ok

> 
>> index fc8eb9c94e9c..c22455fa28a1 100644
>> --- a/include/linux/pagemap.h
>> +++ b/include/linux/pagemap.h
>> @@ -363,9 +363,10 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
>>   #endif
>>   
>>   /*
>> - * mapping_set_folio_min_order() - Set the minimum folio order
>> + * mapping_set_folio_orders() - Set the minimum and max folio order
> 
> In the new series (sorry forgot to CC you),

no worries, I saw it

> I added a new helper called
> mapping_set_folio_order_range() which does something similar to avoid
> confusion based on willy's suggestion:
> https://urldefense.com/v3/__https://lore.kernel.org/linux-xfs/20240425113746.335530-3-kernel@pankajraghav.com/__;!!ACWV5N9M2RV99hQ!LvajFab0xQx8oBWDlDtVY8duiLDjOKX91G4YqadoCu6gqatA2H0FzBUvdSC69dqXNoe2QvStSwrxIZ14opzAoso$
> 

Fine, I can include that

> mapping_set_folio_min_order() also sets max folio order to be
> MAX_PAGECACHE_ORDER order anyway. So no need of explicitly calling it
> here?
> 

Here mapping_set_folio_min_order() is being replaced with 
mapping_set_folio_order_range(), so not sure why you mention that. 
Regardless, I'll use your mapping_set_folio_order_range().

>>   /**
>> @@ -400,7 +406,7 @@ static inline void mapping_set_folio_min_order(struct address_space *mapping,
>>    */
>>   static inline void mapping_set_large_folios(struct address_space *mapping)
>>   {
>> -	mapping_set_folio_min_order(mapping, 0);
>> +	mapping_set_folio_orders(mapping, 0, MAX_PAGECACHE_ORDER);
>>   }
>>   
>>   static inline unsigned int mapping_max_folio_order(struct address_space *mapping)
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index d81530b0aac0..d5effe50ddcb 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -1898,9 +1898,15 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>>   no_page:
>>   	if (!folio && (fgp_flags & FGP_CREAT)) {
>>   		unsigned int min_order = mapping_min_folio_order(mapping);
>> -		unsigned int order = max(min_order, FGF_GET_ORDER(fgp_flags));
>> +		unsigned int max_order = mapping_max_folio_order(mapping);
>> +		unsigned int order = FGF_GET_ORDER(fgp_flags);
>>   		int err;
>>   
>> +		if (order > max_order)
>> +			order = max_order;
>> +		else if (order < min_order)
>> +			order = max_order;
> 
> order = min_order; ?

right

Thanks,
John

