Return-Path: <linux-fsdevel+bounces-23202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF434928A28
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 15:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB711F21A66
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 13:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8719514D456;
	Fri,  5 Jul 2024 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nHv7kb/N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cB3JayDW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393251459E8;
	Fri,  5 Jul 2024 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187435; cv=fail; b=QwVJ4bqsSnD33401Bz0LQxsqv0bM2lAxl3Aam/oTUQZBeKaLarot0jsdlqk1vsESXZNVBQ7yiwKR5DjDw/Eq7Galya01mKQxHxO4pJmb2Ki2jRBgeEDjCQwOyb0Srp6oZ8vbA0pM7g4VmjT0BzcLRS90dwb+4GlPiqpgCcdw/GI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187435; c=relaxed/simple;
	bh=eCxpxxe30XH+JdZ2B2/8CrnXJhvsWDBI7iPCCFxXx3c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aFsU1JuZPojxU1FpHdDLkU0ajI0moHAHMB7X7/0NPEmyZtOtIm2DEH+mcpmOxtnbft6JlVQHrOD1FBEhLExPq6JH4/tZvzrYgm4QpCyeBIFAYdC4RMOUNmhZ1rSwsqeC4idGh9werSHQSS6OtZlH37sEiD6PwJN2SPxN98Z56lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nHv7kb/N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cB3JayDW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465CuI13009450;
	Fri, 5 Jul 2024 13:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=eCxpxxe30XH+JdZ2B2/8CrnXJhvsWDBI7iPCCFxXx
	3c=; b=nHv7kb/NW5siAkjtx1DzCA5NCxxD+IxrGf+yrkgHfxm6U3BTklYYjzwVv
	snZ3bF45qgVkHr3FtVRyKTXmShkQb1KLc+DZGEwl8ch6ECYeSAMT/Z/gkXD3hXzD
	N2gcrHlHbqyRJUkF2idt0wlJ0bVPqBpZvjBHqaANeXV41FQwd5GU8iL7XhmWDFF5
	vUHsmn03xffbErlUMoRj/2ICONnTiq8T5iYjXICgutMcnJ8F1uc16WNqYYvFBliI
	Gc+uk48y1hPQs61XgqhoZI8IeU+G3LrOfkwG7BYhncNy9Iu2lpCsAtH/mQE0BbT2
	fcYEY6XGFbo/uT0bge1zMbtf4czoA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4029233y1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 13:50:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465DIMYI035674;
	Fri, 5 Jul 2024 13:50:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qb5a8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 13:50:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nwa3bawDFqRpSHBjPb+7qlE1fMfnG5k1DgCuePy2SX1qnYQqt7WeAMCeo/eYkNtPA2i8KF1oj9C9o2HGTTafrpMu3NjVbW5f47T8Qb7zWQTCT76eMuKRvRjoP9j8NALabPjYCb2HsTnYAszAibkccGeF/wX6fiHUNxp2n8KtM65WKVdBNgtYOhXDD1G1RvzKfDh3vvGwjL1pSDkGHI7WI5jYc1/N3gBTENhInggQ/YeIGX3IsQHKFIyP3/cbHAnfwxjEfmA1/3FwWAOGwzV2B0Tv0XQLuPEuXwUAncohowuJOHUa3pWGW5wZbelB8QiOk/rXOIs95AXr/3A/Me4yhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCxpxxe30XH+JdZ2B2/8CrnXJhvsWDBI7iPCCFxXx3c=;
 b=jPWKV2K92JS9Gd7ID0S2IG0pTLri9dVoD21aqa2mQJBeWOg3JIvNRiTk0L9NOMCLGpEWBTLHWbKAAErKVTSYSWWD8V0UsLy5UUZNKEYQoypgKYl+fLK4/WmpgMXQ6+6J5nT7jxBRpgEIQI6ADx1+2+1b6iTQM3kdLVLlMpjK/dijNyGfIWfU2KT7xPMNue3MvkMzo6OyYpd65e1rDPLhbb6tklFL5gvcFyPfJpi8Cf6MN2POnukyT5uPmOC+KIz+yXBz+Ld/zxsAmrpu+pgg9umQI+WomQa6cZO3wVR/OlU2lnSVcirGDQLzJGcmxXJXsoLS0euQI7c7vhZkJntJMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCxpxxe30XH+JdZ2B2/8CrnXJhvsWDBI7iPCCFxXx3c=;
 b=cB3JayDWzgKttzX2lYPxTEonhbUoGTGDHaLljfl9UjtQcraBVkk1l6NcI2IqewbCeWoXZ3L7cFKK5+Z4sqX4t0g7bDzBg2RyOaRicYeBdIwKGUlTDHEm/izZ5IC9LKsFYQG2MMeRj92+xBicD3n5xufwls2rPpDDHRPr+4MA84w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB6981.namprd10.prod.outlook.com (2603:10b6:510:282::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 13:50:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7741.029; Fri, 5 Jul 2024
 13:50:20 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Christoph Hellwig <hch@infradead.org>
CC: Neil Brown <neilb@suse.de>, Mike Snitzer <snitzer@kernel.org>,
        Jeff Layton
	<jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Trond Myklebust
	<trondmy@hammerspace.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: Security issue in NFS localio
Thread-Topic: Security issue in NFS localio
Thread-Index: AQHazZfYpFT8/m8roUWxRtwkwi3C/rHm7ZsAgAE6XgCAAAFXgA==
Date: Fri, 5 Jul 2024 13:50:19 +0000
Message-ID: <297447D0-AEFF-44EB-A17B-1B66931C5AFE@oracle.com>
References: <172004548435.16071.5145237815071160040@noble.neil.brown.name>
 <23DE2D13-1E1D-4EFE-9348-5B9055B30009@oracle.com>
 <Zof48g7oQi4O4UG6@infradead.org>
In-Reply-To: <Zof48g7oQi4O4UG6@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB6981:EE_
x-ms-office365-filtering-correlation-id: 2f375d47-3fa7-486b-678d-08dc9cf968e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?bEVlODlqOUZoNFZTaFBucEVqak4rUWRRQjZ6eGNoM0QyS2VxM2dOYzMvU2N3?=
 =?utf-8?B?Z0sybjM2czZxRTg5a1dkajRYM3grTnYwYWNSakVwTXk1SEZSTGl3YlBMNnhT?=
 =?utf-8?B?eXE5RU1tVnQ2MGZ0RHhLaTI0U3A4RWp0U0pYTHRNbHNxSEsyaGlSRG5RMVpq?=
 =?utf-8?B?SE94ekF5NFd5ZHBVbWlKc2JkbWEzUE1MQTMxc1VFRlRaTkVzOGJqZnErck5s?=
 =?utf-8?B?WHZQWS9aMlB4QnpHQ29ETExmU3p5cDRMczlJRE5zRkNibVhvWUdBWUF1Tlpu?=
 =?utf-8?B?dFdob2k5RE1FL0REcHU3cHMxeVRCclRPbnFITk90MTVUUHErd2hSTkNUOVo5?=
 =?utf-8?B?bG5FRkMxV2QySld6YjYvYXpORDZrbXE1N0xMdjZpMExkUkl4Q1ZHSThJOFI4?=
 =?utf-8?B?ZS9QdGI1UVJwa1BZN2YwTmIybFI4bWNpSWVaZCtTRkxDRnljOVNkeXVwZXky?=
 =?utf-8?B?T01lVEZjWFp2TC9vSHVTZ3lEYnBaMUF6ekRya1BySm1OWjdkMFZxb05OSVZZ?=
 =?utf-8?B?RXAzVWsrMHVlT1FvejFvZVhkMXdJb3RNV1pCbThlUVlYekFBbEJPRktkWGxC?=
 =?utf-8?B?S1BXT09ycUhDd2VwcU0zMGl6K1RQdlUyWVYyQTNJcks0b0RiYWlSVmtHTUY0?=
 =?utf-8?B?ZndTMlhmOUYzYjlKZ0J4VjFYUVo3VzdhcXhwM2pNMzZFb3BDY0QwSGdwS25C?=
 =?utf-8?B?ZmpoT0NhZWp2bTFvcFhDTnJWK0w0eHNIQ2NSZ3hnVEdJamtOSjNNWDBhQ0lX?=
 =?utf-8?B?WkVWV0hYU1B5dmhxMWNkbDRZekpOcTdDblFreFdBalRXaURBU0NLK2V2RCtM?=
 =?utf-8?B?MnZyM2dIY3hIaDJjZk1ySU12QW1RR0FhVnBLTG1IRW03RkcxcFcyOFhTd21k?=
 =?utf-8?B?MnhmakNOWVhYbVZYenIxK0xLNG5vZUZNcFBhYzZTd1NTS09TRmZmbUowVjI0?=
 =?utf-8?B?ZjRTczl2SUorMFo3RUlpdGN2SE91V2FrRjVwNk8vZGFKc29tTnBuRlVYRDZH?=
 =?utf-8?B?VjVVcXY2QVpCQ2Z5T1cyYUhMU0V3b3FXVEJRS1orQ1p4QW56TFZVTlU4d2xp?=
 =?utf-8?B?RkpDTmJIQUJPbUdCcSt2NTluUXlzSlZRY3ZqRS94NUVDYWcweHdobW1FTkNC?=
 =?utf-8?B?MzV4V0NYMTJZMVpHb2JOQnZOTFNMRDNFNmUvZkMyaXVNemRYSEg5dHdFQ21P?=
 =?utf-8?B?eVRGbnVKT0JJcllaNlNCaC9SMDc1cVBaUmoxMGxyTTEvcDdyUTkrUW5ldnZa?=
 =?utf-8?B?WW14VEtWYVh5T1Q4UEMwV1M2Y3VUT1dUMmdyUUFKVXFKL085Sm1GRXZCNThV?=
 =?utf-8?B?YitlcUgzek1LS0h1aW5mZVF1UnFyMkQvVk1TME4zeDZhV05CekVzTTJuZHJL?=
 =?utf-8?B?SUgweXBxazZEQVM4REQ4NHNFc2dKcVBsVUZBQ0F3cmFhcVFneFFub3pPTVFY?=
 =?utf-8?B?Z2xFSjVFeXQ5TERseXh6bjFldjhQbWN0a09FT0NJUGYxUlFTVzhybmNyMEg1?=
 =?utf-8?B?ampvSGh2U3RoeWl3QWlrc1VkKzE1bldaWU5MRk5uS1F5N3A0L3VuTVF5WVNK?=
 =?utf-8?B?ZFpmNDlZSlU0UlpMVlhETmtQTUFBV1lNMUJuRmJEdmZ6WFNRcXhCaDB6K1Nw?=
 =?utf-8?B?MkZQZ1NJZiswNDZnZVhLc2V5OHRFWGFaUmM0WUVGTXJRL09RVlBIb29SK1ZW?=
 =?utf-8?B?RVhXRGRvMDd6eTJaTTA5S2loR2Nib01FcXJSS1pmcW1zNU9ucFQ0SWlWRElo?=
 =?utf-8?B?V2t1UGdYT3BEZFJwU01veFdUa1RrYUlDNWlQeG4rSTV3YzYvOFRXbUlOcEo5?=
 =?utf-8?B?WlNZMmhWblo2V0ZZMjVkYnROZk9zYjRQWjNHeDgyZE80ODZmTmxhelh1YnZ3?=
 =?utf-8?B?dTQvZ2xvc3c0YmN4N045NXJCaUVDWjZIckxUYjd2dHBLdEE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SzNFcjM5ZUhyWWJmMlFxU2Q1Tm0rT3NobXF6MTRzVlFmMTZ3WGZPSlFvNk5r?=
 =?utf-8?B?eEt0QmMzSEVyb09GN1ZFalN2bHBkWEdhU3VUNjdYQWNMMFlDMVN1WHNMNldI?=
 =?utf-8?B?cEJScWlYYU8wb2lOdjRMQWFxSW95Wk9ZYmpsWTFLNHBoZDJrQlJUblVYU1JW?=
 =?utf-8?B?eENuNzFxclY4cTh1VFZQYkFUelYydjRBZmhkWCs2VStTZ3lSb1B0N1dYZnRM?=
 =?utf-8?B?c2NQOTBLK3d1QTlCbjcvWk5laVlJUU5vZjNvY1pUa1dmalZOS1ZIMUNTWSsy?=
 =?utf-8?B?SlhWYVpQRVFYWmlneTBFdmRpRCtKZGhMRXRPMm1oUlpSbmhsT2J0RGRpcE5q?=
 =?utf-8?B?T1M3ODA2ODVlTkkyTUV0YWVsKzBqRDg5ekU2U2xHaHhlcG9meG12NXVudW43?=
 =?utf-8?B?b0RhKzllQlpvSG5pVFB6aVQvMW94cGRReGorMTRvaS9NS2NNaDRZNTkveEhV?=
 =?utf-8?B?MFJUMnVERUIzRG1wdlI3WVUwWkYvbUd3bmNGazlqVm5qbGhBaklSNTRvZUNo?=
 =?utf-8?B?aE5jNCthdld4MXltdmZpRlhEVzBnU0Z5cURKeWlZN2lyTUVRUXJOa3hnTWtp?=
 =?utf-8?B?eSs1U2pVL2YyZU5ENjBoZ0h1SW9YTWhYT2JzUGlaRWlzMmtYUmkwSWxlSEph?=
 =?utf-8?B?QTU0MTBhWU01bElMUEw1T1Nrdkd1ZU5SeG94andiOStsa3lkRFgzYi94UkZz?=
 =?utf-8?B?cTZ3eG40Z29Kamt6Unpyd3A1a09LSFlvcGJqMDFGTlF2Z2UrT1E2aUEzT04r?=
 =?utf-8?B?cktmOWw2dlZaWVFKMm4weFNLOG5xbGRQT0VORkYya0NETmI3NlhJQmp3UzBz?=
 =?utf-8?B?NWVsQjY0bTJDSXFVK3JtOU8rSlRVWXJtSUhLUEpadW9obG9qU3FmOXlLS2Vr?=
 =?utf-8?B?OFhLTHcvQ3U0QlVOZXhzZ0o3R3RBaW4rVVRDZXdwczBSUWI2TStXVVJEWFFO?=
 =?utf-8?B?MG5OY2o3OW9sMmQ3QWw1NGdabldKUGdjd0lFbGY5cXpYTU5vbnFuZ01wbGJJ?=
 =?utf-8?B?eFpCcVdLYXBnQ0xwc1d5U1cyWnZpZTNWbkhFdUlaTEc1MWlhYm5kNmcwTFAx?=
 =?utf-8?B?enlROEgyOGZqRzZhbEI5Z2RCM041OVRFN0lScFdIUmRHRkNXQlNIR0c5NDZG?=
 =?utf-8?B?Z3JGUWFwdXdPQzVWTE1UbVZxNDYzV1JXcXlsakdpbHVmcGI4OXhnS2UwUWZk?=
 =?utf-8?B?aUx0VnY5b0xjVkpxTkJwVWRXV3lEN0U0cnVTVzdmelNZYU5mc2k5QUpJKzBQ?=
 =?utf-8?B?Z1hPVDl5dWFxOFgzOFpqeko0NG5RZUVobmppZ3pjRU1ndmU0YnZNK1ZWM0sz?=
 =?utf-8?B?NEQreHgyYVlXZUxDZjk0MU03QWFvWlZGeThrWnZJQ1ptSnhEQ3hOUGxyYzNo?=
 =?utf-8?B?cDRvYTJoZmhRM0dTODBERUJCVzdQekdxSTAxSEJrZEh4UWdKdTNYd1kwR3E0?=
 =?utf-8?B?Rk5jdWY2aklGZUJKVndjYW05SXFZcjRTeFBjZVpCcTRzVEhnMU5QSHFnM2Ey?=
 =?utf-8?B?eUpyeStxZHR5dXE5SG82ckU5TkpmNlo3MVQ1dzVEWG1mZmNXSW5ra0V2UXNv?=
 =?utf-8?B?Rm84N1VGMTkwTWhOSVJEdHBpdDM4cGd0VnN1eW1hZk5LZ1FRbmVyQVlaYkRT?=
 =?utf-8?B?WjFEOHQwM2FqWEpxdkpUMWEwVFo2ZWFLZ1pRL3RHZmRzRGtRd2NNM0szVEt4?=
 =?utf-8?B?WEJJS3pWS0Jqa05BaHRIcUlrcDhGZ2dzRU9tSit4bUJVWnVBTVJDQk4vK2Nl?=
 =?utf-8?B?b20yVVdUc2FwaUFsbTJtRTkyekRaVDZtT0xGL3ZiU1Y5TmNCNUdPQWt5Qzh2?=
 =?utf-8?B?bGV0ZHhXMzdpZlB6ZkF5MUdVNFNJSE0vM09QeVdGekwyWnhFeUFVZzhnRjFw?=
 =?utf-8?B?ODhzaWdJL2hVSnIwNGl3cGZwL3FxVm1KN05DRU1vdDFkdHhCd25lN1dmQ1dk?=
 =?utf-8?B?Nk90RWZVbGRHa2xTQlhFWXNRUGx1cjdmQVREcEpzc21OUVZ6M3VWVWVJcFBK?=
 =?utf-8?B?QktDYVFSNnU0Z3pPVlZBc3U5SUpFaGJsYXhtUm52Q1VOeW41azRYVXpjWFZH?=
 =?utf-8?B?RjQvUmlkU3ZXZWNkKzRqbEhTeVdZVGw2cmxOemhpeHVrZzRlQWlhc0Q4eHlE?=
 =?utf-8?B?cURmL0dMV25RVFZacWQwRFZwTThneVlzR3NBVUplSVVHaDdHbVpjSGtmanB3?=
 =?utf-8?B?MUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07F99918608E8343A04CC1F818C9518E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Eg3eFbA0nlTC/vVGl6yWlD4BxY6Uqrdu2jz4l77nxddeGSxmgbwaC6jMIHH1bL3poLb6EYJ5q6BdTmN203w6T3agjwchwKoDFBFp0KnQtZupv9HO8qNZEvDI4a2wqPPFHpLm9bek6brxvAML1e/ETWmDhXBsF/i5CvERmNGZsBkU+r6VC6PTc8PF4nULugCPwwtg3CkWYRekp5Xx3NXh2yyxjBu6YrE6HryUHT6J30xeiQ4vVPTIXL8l5Y4Jx8dDlzC1EpobYFVgXnAz6d5P/kSjotSKThevYk1KyVNuTLo4m9pHuxYvk7APPHKGRPOjj5wHt19ulWgGiuIbDyWdSgsyOqKuuW2Coh1eX33+2iPN0Rl2yJZ3PUy0fJSrj6IF2/ZWsH0zi+33Wq3Frbb+ba7i+c86fNzbpfQbOauoFoBbh6m+14DTjno2TZfTdInnUQA7iZDa2JgAriOXk0ibzAvJOQc1VOcQ68dKqyNAqFPAc5lSO4cFYm62N6gR+zRAcKgROHlwPwBYV5pU7a03jRZnFcCvN5ebLIuIHtCIc7dy5/5HkXvMPuhQU8hRyzzf0EMt18QjvTdpN0ls+NCizjWaPSfh2wJ6qKSW95XRsoM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f375d47-3fa7-486b-678d-08dc9cf968e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 13:50:20.0032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BaQrtrvrZ9QF8CScK5dnR5kHMWsl70qs5Ua6sU8cmBFyE4VLhR3GmUvC+TCSwLShe07/SZpCGMvsCCtPxAoW+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407050098
X-Proofpoint-GUID: T4zaS06bo0-nsy4aejYC9CVWY96wmKbP
X-Proofpoint-ORIG-GUID: T4zaS06bo0-nsy4aejYC9CVWY96wmKbP

DQoNCj4gT24gSnVsIDUsIDIwMjQsIGF0IDk6NDXigK9BTSwgQ2hyaXN0b3BoIEhlbGx3aWcgPGhj
aEBpbmZyYWRlYWQub3JnPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgSnVsIDA0LCAyMDI0IGF0IDA3
OjAwOjIzUE0gKzAwMDAsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4+PiAzLyBUaGUgY3VycmVu
dCBjb2RlIHVzZXMgdGhlICdzdHJ1Y3QgY3JlZCcgb2YgdGhlIGFwcGxpY2F0aW9uIHRvIGxvb2sg
dXANCj4+PiAgdGhlIGZpbGUgaW4gdGhlIHNlcnZlciBjb2RlLiAgV2hlbiBhIHJlcXVlc3QgZ29l
cyBvdmVyIHRoZSB3aXJlIHRoZQ0KPj4+ICBjcmVkZW50aWFsIGlzIHRyYW5zbGF0ZWQgdG8gdWlk
L2dpZCAob3Iga3JiIGlkZW50aXR5KSBhbmQgdGhpcyBpcw0KPj4+ICBtYXBwZWQgYmFjayB0byBh
IGNyZWRlbnRpYWwgb24gdGhlIHNlcnZlciB3aGljaCBtaWdodCBiZSBpbiBhDQo+Pj4gIGRpZmZl
cmVudCB1aWQgbmFtZSBzcGFjZSAobWlnaHQgaXQ/ICBEb2VzIHRoYXQgZXZlbiB3b3JrIGZvciBu
ZnNkPykNCj4+PiANCj4+PiAgSSB0aGluayB0aGF0IGlmIHJvb3RzcXVhc2ggb3IgYWxsc3F1YXNo
IGlzIGluIGVmZmVjdCB0aGUgY29ycmVjdA0KPj4+ICBzZXJ2ZXItc2lkZSBjcmVkZW50aWFsIGlz
IHVzZWQgYnV0IG90aGVyd2lzZSB0aGUgY2xpZW50LXNpZGUNCj4+PiAgY3JlZGVudGlhbCBpcyB1
c2VkLiAgVGhhdCBpcyBsaWtlbHkgY29ycmVjdCBpbiBtYW55IGNhc2VzIGJ1dCBJJ2QNCj4+PiAg
bGlrZSB0byBiZSBjb252aW5jZWQgdGhhdCBpdCBpcyBjb3JyZWN0IGluIGFsbCBjYXNlLiAgTWF5
YmUgaXQgaXMNCj4+PiAgdGltZSB0byBnZXQgYSBkZWVwZXIgdW5kZXJzdGFuZGluZyBvZiB1aWQg
bmFtZSBzcGFjZXMuDQo+PiANCj4+IEkndmUgd29uZGVyZWQgYWJvdXQgdGhlIGlkbWFwcGluZyBp
c3N1ZXMsIGFjdHVhbGx5LiBUaGFua3MNCj4+IGZvciBicmluZ2luZyB0aGF0IHVwLiBJIHRoaW5r
IENocmlzdGlhbiBhbmQgbGludXgtZnNkZXZlbA0KPj4gbmVlZCB0byBiZSBpbnZvbHZlZCBpbiB0
aGlzIGNvbnZlcnNhdGlvbjsgYWRkZWQuDQo+IA0KPiBUaGVyZSBpcyBhIGxvdCBtb3JlIGlzc3Vl
cyB0aGFuIGp1c3QgaWRtYXBwaW5nLiAgVGhhdCdzIHdoeSBJIGRvbid0DQo+IHRoaW5rIHRoZSBj
dXJyZW50IGFwcHJvYWNoIHdoZXJlIHRoZSBvcGVuIGlzIGV4ZWN1dGVkIGluIHRoZSBjbGllbnQN
Cj4gY2FuIHdvcmsuICBUaGUgcmlnaHQgd2F5IGlzIHRvIGVuc3VyZSB0aGUgb3BlbiBhbHdheXMg
aGFwcGVucyBpbiBhbmQNCj4gbmZzZCB0aHJlYWQgY29udGV4dCB3aGljaCBqdXN0IHBhc2VzIHRo
ZSBvcGVuIGZpbGUgdG8gY2xpZW50IGZvciBkb2luZw0KPiBJL08uDQoNCkkgaGF2ZSBjb25zaWRl
cmVkIHRoYXQgYXBwcm9hY2gsIGJ1dCBJIGRvbid0IHlldCBoYXZlIGEgY2xlYXINCmVub3VnaCB1
bmRlcnN0YW5kaW5nIG9mIHRoZSBpZG1hcHBpbmcgaXNzdWVzIHRvIHNheSB3aGV0aGVyDQppdCBp
cyBnb2luZyB0byBiZSBuZWNlc3NhcnkuDQoNCkp1c3QgaW4gdGVybXMgb2YgcHJpbWl0aXZlcywg
dGhlIHNlcnZlciBoYXMgc3ZjX3dha2VfdXAoKSB3aGljaA0KY2FuIGVucXVldWUgbm9uLXRyYW5z
cG9ydCB3b3JrIG9uIGFuIG5mc2QgdGhyZWFkLiBRdWVzdGlvbiB0aGVuDQppcyB3aGF0IGlzIHRo
ZSBmb3JtIG9mIHRoZSByZXNwb25zZSAtLSBob3cgZG9lcyBpdCBnZXQgYmFjaw0KdG8gdGhlICJj
bGllbnQiIHNpZGUuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

