Return-Path: <linux-fsdevel+bounces-53396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3C2AEE593
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 19:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BCA917A6E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 17:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF656293469;
	Mon, 30 Jun 2025 17:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YQgg0zUb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E74291C30
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303905; cv=fail; b=XSrQXHxfMUnCtm0Nv5MvSU4bU3TAcxnmlUt3forXN6ArrANpDHRU4SC+SQL+GYiZ8UvIVvGDjB0XSWGCcDS3Pcl27xC9PkG/b6QSF0xMDxeItDORErjfh99mLsAYwqoK6af50x1gsfmZSFu7fbAHqqwRGSuG6xmnzux7QStbrTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303905; c=relaxed/simple;
	bh=dgC4AV5j9dwn7r1vCCHWUYQ8AorHpfzGLIgrDOjnBd0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=e9xtklSRqoeMeGvMQaq502qxzQsl0h/fcLIjmLTO04mSQj7oxa766jKJYMfvg/4eQarki6M8CcY37H94iJoZ7IoLNKjzfSmFMWVdMU/1seeIGil7/21yN3/43GZcJS8L7KV2f7O96BLDjlHA/O9xZ1+z/dc2KJEdDIvSvC+mPOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YQgg0zUb; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UAncFS000329
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 17:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=PSUEfczLatjsHSvgiQRrQd5CtcUYh4FUoK129EwVZeE=; b=YQgg0zUb
	UwVT5V88GflvQPeXM75bXNeKcjiRKWYpdDubCyqOlLF2pfZ8ltkewxYX7X851v7k
	Exb85yDQKM1nuntyUrcjDVEkijtIa80B2QyHHfKhjdKuVD4NNqBCsjN7k4VttH3s
	dV/qw5G+mUXj4Jt2t3oPRIdrg8VdaUtaJYZMEL+aKakrrhYSP9qoC9/PDCRRVeEj
	OjlFz6p66jS15XlLEUj5YvWsooWTivwfvoqiZJ1ePM7gJi/sJbVOmnvXG79nfq/7
	Q7LxON4tcZmeYOvweTkSF/34YAAEzS4QKasvUndlKOST45pgTK0Jd1xHxryWvZ4Z
	nl9FzSxJgN/3uQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j7wrat53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 17:18:23 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55UHEIQ1014409
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 17:18:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j7wrat4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 17:18:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5BUAUFGRLFJBKPWaIQbcdN0V8v76sRmkDSaZptK8NAkp+2QzyyhG0BbzkeaNRBNXLsLJ3tusxqGvJHyVBxywQr/SA6n5m+areWlAZUdgvlkTiwhDmHF8dBO0wxZyrBoJplqlacIiDvFPzEzcfVFNrkwnZnu8pKM7AveCPZffkSOU73aaUrWnWNwjXzIXhazpPQ6cPAqnGgc9DhOxJsZYhVmtF1RwwmkWSyef0Fnre5c/y5M4HyTORsDHnheZw/uua9yymZ6sQDKC1668TS/02NxMXLDmcMFybmU1L+46mnMBzQ9sxp8DhVlcMm4+0iVM+Puj7I51mVg9ygNybvGhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnBT2kjaf1Mwtac9dkF+1eJFoM77G6Kma1a3FEMMah8=;
 b=vbRnKCg4QzoqEnFiGq9iXqwbOJ22/LvRi+CchSv+lUQgKMVo9A46R0IjMi1C9O4Q9cBvvImzdvhRDX+bXkLnB5VrcfiQuwI69kDmYz2ggqZ2D8rpOFOdvMf/7IrgG50VMh/kBbM+NduDQ1vn+7L1fhnZ8Jog5nU3SObQRMNgbzMkmaUmppyWg9dlHPL+sGbNnzr6Eej1B37KO7YdaIoZ9N1RIhmTX9f/QIzqntCYTsbN4Cy7AaVfscxdozcZaB85MI38TgIsb0XrtdNtl5B84JnbzYx/S66GIEs/rO+1pPiynB5lIdfbyv7jR3bqX7Cj8d0gjCr11/VxoaWaTkUo2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW4PR15MB5160.namprd15.prod.outlook.com (2603:10b6:303:187::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Mon, 30 Jun
 2025 17:18:19 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8880.026; Mon, 30 Jun 2025
 17:18:19 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
	<penguin-kernel@I-love.SAKURA.ne.jp>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] hfsplus: don't use BUG_ON() in
 hfsplus_create_attributes_file()
Thread-Index: AQHb5bnTSwuRH84MSkOexdLUPHIderQb+n6A
Date: Mon, 30 Jun 2025 17:18:19 +0000
Message-ID: <4ce5a57c7b00bbd77d7ad6c23f0dcc55f99c3d1a.camel@ibm.com>
References: <54358ab7-4525-48ba-a1e5-595f6b107cc6@I-love.SAKURA.ne.jp>
In-Reply-To: <54358ab7-4525-48ba-a1e5-595f6b107cc6@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW4PR15MB5160:EE_
x-ms-office365-filtering-correlation-id: 37aef1cf-4c27-4911-bec4-08ddb7fa1c09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QzAyZjdRQkRiYm14eUttZ09QK0hHZEFKMTZ2TkFndzNSQTBPcEVLZ3RPZ0c3?=
 =?utf-8?B?TVM5NlZ6d2Qxa1Y2L09PSTVjN1RBcHJDejlsaFkyNUl3dzhjQlNoTVlLbVl1?=
 =?utf-8?B?WkhLeGtGZjZXOHpCQVRaaGFUOTRpMDN4ZXRrcnRTL3F0OXltZzJlb2ozRU92?=
 =?utf-8?B?aWc1S25hZGQxYVNQQkplMVhpMFFWV21ERjdGVnMrMUFubG52TERNY25oVGNw?=
 =?utf-8?B?NXdNSnRDY2RKSTI1OTVhNHdWWmxrbXlyWWQwdXRUbjh6Tm9JdjhTNVhjM1Az?=
 =?utf-8?B?VEh6R3dEem9ETCsySzNjQW9oRmo0MXpsaUdpcStDUkFKSWNQM25scUZ5Qng4?=
 =?utf-8?B?UGo4QTFFSHdKTk1JaDdxdkwvRDNzeURNV1MxVW94VlhoK1ViV0p3aEU1cWhU?=
 =?utf-8?B?SmZ1MmpwdlBTNDMwWWl5QXVBbmptQXo5M1pRVXUzQ2wvWUxGRjJncjRhSmFV?=
 =?utf-8?B?cVV3NHQxMlJ4UER1dHJOemMrYWZkU3V3Y2hFenFuKzBjQyszZ25ERkR4b0dC?=
 =?utf-8?B?L053cTJGejQvQUE4cnYyYkdJOFN1S2pjOU9kRGNyc21aU2ZaZ1k4RDMweXNh?=
 =?utf-8?B?dXh5dmxVN0ZONG9KRGw2OUppVUtCS1lJVXZVd2tCMnZFWnQyY3hBczh4YlFJ?=
 =?utf-8?B?RjN3SGM5ZkNOWkhRYkhUb0ZSWWduN2o5SW9CL0Iyd01DRnJYVlpvN24yd3BO?=
 =?utf-8?B?RkZoUkplT2ZqaG9kWVppRm5ncTEvMlFzUld5K0kveTA5TGd1Z3BKci9pVnE4?=
 =?utf-8?B?Z05RM2xsNHIrWVhOZlVzK2NKY3VRbEhLK3JUKzBJbitsbEdNbzJHdm1SWlVa?=
 =?utf-8?B?Z2JqYkhyLzRqb3NtL1NNcTFxbHF3RDJqMUVWbzFtN1BuOCtBRWx0dS9DTVhk?=
 =?utf-8?B?aGd0RE9McXkxQ0lydnRlMTZUeUk3MFlxOFdZekNMeG8vREEvUzBzSCtHdlhi?=
 =?utf-8?B?c3BOZ0EzZ04xNnVoakhDeTF4VkJNa29UejJFdjc1SHI2KytiN0tGdVNqZFMy?=
 =?utf-8?B?YksyQmt3cWVyREdwQkh0RkpjR25OTTA0RXR5QWQ4S1RzejJTL3pBZlBpU2xk?=
 =?utf-8?B?VERHQnE2S0JXUmEvMlZVTjZrZExZUXlrK1BYd2Q4aTBSSWxXYTBQbWlXMzVt?=
 =?utf-8?B?aTZMaXRkdHhXdHdDNlR5UjVtd1dWMzMxT3ZvU05kcm1EOFpRQkxqMnFCb1BO?=
 =?utf-8?B?d0lYcFA0VDZhUDB4NEs0aG1KSjcvYUdpMTlrbEpmYTNVTTc2T1Bla2F2cTVr?=
 =?utf-8?B?clNQVzFjZmZYOWxTTVdDbDJ0U0pxM2Nqa2lBLytWcnhqRzBFOFhlOWFEK2E3?=
 =?utf-8?B?alAxUnB5cnlNNTQweG1kNmx6TnljR0hoSnRTODFtaGp6ZDErRnpIaGNQcWJw?=
 =?utf-8?B?N3U2cU56YTVGSUJJa0phc3JoUzBTQTluN21idlZtcG5zQTM4ZGY4aGV2Q1pG?=
 =?utf-8?B?TWtld245UmtwTkVIcGxQanZUeTM1Zjh5cEQvU3pCbEF1S2owNVJWMFFXSk9L?=
 =?utf-8?B?VlZ5aCswelNjMEFRb043RUQ4VlByZ0lacWxpZ1BNR21tY2hrbURWUm8vUC9j?=
 =?utf-8?B?NW0rcDZIa3lUeEVZU01zUWUyMlNubnFBbnBZNnBJWllyeVFmQ0JacDJXUlZV?=
 =?utf-8?B?QlNUN1lCWFpCeXhERG8wY2phc1Fqb0ZiNlJacEF6cEVQS2VVVTRRc1VMMjFi?=
 =?utf-8?B?Y0VjU3JPVVR2NmcxOWNUcllJZTJkREJ3RkdkbENDOHZYRFAzM0FrM2x2T2Jh?=
 =?utf-8?B?Y1lYQS9TODVWYVBnVWt0K0owa3Evdlc3N3FSL2ZHTmdnSEJMV1JNMWFSTjJJ?=
 =?utf-8?B?TWNKTzN1WWJDOUc5TWJKZXhCZXQ2ak9SMmpoc0ZZaERZRjNtQW9ycHh5cHVy?=
 =?utf-8?B?UkRvbmdWaWdIb1ltK0JBekpJWWlkUXQ5MzJsMm1nOEtVOWFFejBhZDZIdk9z?=
 =?utf-8?Q?uDl/0X8n/aE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ekhtS2xTZUlsTWZ3N2w0Zm1qZ1ZSN2lJWGJJdnNlclQ1MHBhVExoNGViSmFY?=
 =?utf-8?B?R2J4eHlpaE1RN3RLWXg1WWh4TWlqeUVjUVA4bmVkSzBwSnFTYjBHYkJpbGlz?=
 =?utf-8?B?Nnc1a2xBb0xxWkRFRkpsQUtlVElTYmxPWDhmamkwRDFacGh3Mm5KV3NMNFAy?=
 =?utf-8?B?eldUU0Y4YmZlK3p5Z2VzUTEzSklVUWJXaTJsZTJ4MVA0YkpCR3VGQXpTMzNV?=
 =?utf-8?B?OWZEMmZvYndPMGJXY2hBN1B5ZFZIazI1Yk1sTU5zKzFZMjkvRjVFdk12b2Jr?=
 =?utf-8?B?RnBzMmZsL0VlWUJwZnF4NEFXeXNSYTJDSkY2alIzOW16QmlFSlpzMk9JYTFB?=
 =?utf-8?B?UjRHUmhOZzRHYUZpWVFwUzdrQVhXa1lQVzMvQjV1Qit3MDVLemt5bVIvWUJq?=
 =?utf-8?B?ajlxSGdjTVdMWTB6elZWaHFmWnNMbkZxOUNNRHVWVVdQdTZvd3lIN0pqRTZa?=
 =?utf-8?B?MWI3ZW9zWVBiUGNKL0FZdEF2bHVqcE14RnBCMDZ4ZGJnSHpyVmFSb2F1YUk3?=
 =?utf-8?B?UkRUWk5OdEhoWFJOU3J2b0NKZUExYUVJMXV4WGhJTWtvQlp0cnhKZmtTVzlq?=
 =?utf-8?B?M21Oc0JGaWp4SjZUZWlWN21CSXJEc2IwSGNQelNNcTVoZmFNVkdxR1lWYm5L?=
 =?utf-8?B?VjZackJCU3h0N3dBeGp6TnlaVVlROGtVT1I1NW1HelNYQk5LTGFOcmlqNHBo?=
 =?utf-8?B?S2pjWHVub0ZacFR2cUpFb0ZWQ0l0V3BvQW9MNUI5UWFWMWZQdHBHSnczY1h1?=
 =?utf-8?B?TDBHTU5FaWJPOEkrSGYwcm1TUU83ek1uU3IyVXdLclFGZllRV3ZwQStMQklR?=
 =?utf-8?B?K25IQWt4YjRqZ3dTbys2OUU0bEVQSlRyUDBYL2IrNk12WFNnQzg1K00wL2RV?=
 =?utf-8?B?akVOMEJSVDk4M2RxSlBhK1p3MGZVQm1kTTlqZUZLaGVhbTBaZm1nbGJzMm5r?=
 =?utf-8?B?MkN3Zkc3ZnhUcGhLSHJwSUlxcU51N2RoVTd0N3gwbmNTdW9vRi9PMHZJVm4w?=
 =?utf-8?B?OEhrSW1DMDhmSCtSQzA3N2dlUlJITWhXVUlFT2F4NnJVVERJdGx5NTlucFBX?=
 =?utf-8?B?VWJUUVpwaVpETzhkaGV6enR3NUdsMlpqN0daYmtyMjgwN2lLMlNwaVhCUHov?=
 =?utf-8?B?eUxaK1FId3RVdlFsYW9lL20rREx3Ritwb2F3Nlh1WjdIMGp4S2tSNG5oVm1I?=
 =?utf-8?B?aFFtZ2JzTEYxRkQxWWhEYTFyMUdkaFhZcGRSbGg4eVV3TXFBekZGTDBwMjNT?=
 =?utf-8?B?c3NNQ3BLdkFLMXo0SXVReGllSVRscUx4R2pyN1VtRExXN01jbCtUSURKZFR3?=
 =?utf-8?B?MW1zMnFtSkNWMVNtOXh5WERNZXhvblEwQnFKbmd1dEFBMDRRVDJqZytCOGp3?=
 =?utf-8?B?UExHUDBNczRwOGlrakJhRmV6QUdmVjFOTlBHQWtEc1Q0bXhKWXVic3k5WlYz?=
 =?utf-8?B?RGdZeXhOajlZTzBXTXM0b1czT29nbHlGS0NvdlJES21ZeDE3aHVtQmF1TEcy?=
 =?utf-8?B?ZWUxNGVRanFtVjEzUlczbWJJcnJhUkZJbjZST0JUendDdU1YQmhqTXZYM25n?=
 =?utf-8?B?NWRNNW9RQkNRRExEN1F4Mm42R2NXNEV0VjNualAwTzNhTHVpVkhiVHJ4UFlJ?=
 =?utf-8?B?ZFlQdzVBbmU1bW85a2Z5QXdhZkptSHVHdE90OG1wcXF3QWtqZnJFdkUzc291?=
 =?utf-8?B?MUpEbm5vTG16VFd0aUM0RFBiL3YwS28ycnhWV0dOb284ZGNBRUhCQVBMUEhm?=
 =?utf-8?B?WXZqb1pkY2ZkOHRTc1RreElXNGlkMWttVThyVTdzUXhsUGZXVUxJK0VQeXVJ?=
 =?utf-8?B?dkdsRG5VaEFpOVAvcjFTZ0FlUjNYQ0NSQ0ZjTUpqZEZudDlrcG9FUm9ubG9V?=
 =?utf-8?B?RzNKUytCMGVmazNHVXlzNjFuOUtqQVdZa3p5bXBKaWFzZEgrQXNDTW4yWSt4?=
 =?utf-8?B?dFN4T1Z2elhqc05vL3MvRVh5TVpSRzY5aEN1cXVHbVZHR2JVZnJ0VmJCSkFk?=
 =?utf-8?B?SVFjbkVPMElCbXhWeHR5bXA5cXoxVUhGNmNaRHBxcENnL3RwSEd4dDdJMExv?=
 =?utf-8?B?aURCSXBReUl0WStscVB4b2xocUw5OS8xdVN2ZzMzVEkvcVhhQjFMRzdsUjU4?=
 =?utf-8?B?TVFna1lQUDFlUXpOVWY0aTBCWVIvWWpZRFh5NFFLUXBEVXVMcTFxYjB2dTNi?=
 =?utf-8?Q?LooecSAa8w1OWEWLuN0cAbs=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37aef1cf-4c27-4911-bec4-08ddb7fa1c09
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 17:18:19.6387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XWQAvpkwUY+1OPmfHW/mvsUbE8qsJW2PPO7kUNprpuGitzM62/A4Dr/NBUaoVMAM6CgxFSoUvZ6PF5UvGTsFTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB5160
X-Authority-Analysis: v=2.4 cv=E/PNpbdl c=1 sm=1 tr=0 ts=6862c6de cx=c_pps p=wCmvBT1CAAAA:8 a=Qjkm4aj0RJiPRcXiTwxp+Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=kNrUgG5CCNHpktYaxwcA:9 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-GUID: 69M5UUYLVrj_CS3FCHxCw5TOuwyNGwxF
X-Proofpoint-ORIG-GUID: 69M5UUYLVrj_CS3FCHxCw5TOuwyNGwxF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDE0MiBTYWx0ZWRfX3cDFASqKWie6 iSFROhDD8hu6JTCc+EvMfU36Q27SZd2FtnS9d2Zf8RxIIU366Mw36udW/xQCG6LmJTWUZo+qJiz SIEj6H5kOX+nfdxmZy1ES6OSxiT467Q96nxN+343y9hou3uuuu/AbRnrAzd3PjAaiBTAYpFwVSa
 2Nn90FdEY2ULNB1jdjMAcX0s4bYT+Tl0HUabCSboTFj15YDFqPm44DVGqnfQqWo1ksS9pZWUaKI VeXfGlxrSvEALhPQejmANNHt29s3y3Pq88hxbGehlnHHObPqlgG+ggN9vYiiNztT5hXSvs9+0Sw AR1CQZSU/K5Xyk5aGiApU6AW7Oy1yQsXZBeXiqbycLPGy7ITZUNTj6AOKKGJoGxD2Oa7PSrLtYa
 020uI3DhKeeqkyCPnWjJU8gmN1tq8HcdQwb/l7CoFO68Iz62LWTLrBfVwewkvG4pKpiVp0Mh
Content-Type: text/plain; charset="utf-8"
Content-ID: <D55C76C81E80E945BB221A8FA7A3A557@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [PATCH] hfsplus: don't use BUG_ON() in
 hfsplus_create_attributes_file()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_04,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 clxscore=1011 adultscore=0 impostorscore=0
 classifier=spam authscore=99 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2505280000
 definitions=main-2506300142

On Wed, 2025-06-25 at 19:10 +0900, Tetsuo Handa wrote:
> syzkaller can mount crafted filesystem images.
> Don't crash the kernel when we can continue.
>=20
> Reported-by: syzbot <syzbot+1107451c16b9eb9d29e6@syzkaller.appspotmail.co=
m>
> Closes: https://syzkaller.appspot.com/bug?extid=3D1107451c16b9eb9d29e6 =20
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  fs/hfsplus/xattr.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index 9a1a93e3888b..191767d4cf78 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -172,7 +172,11 @@ static int hfsplus_create_attributes_file(struct sup=
er_block *sb)
>  		return PTR_ERR(attr_file);
>  	}
> =20
> -	BUG_ON(i_size_read(attr_file) !=3D 0);

So, it's something like unexpected situation here. Why do we have
i_size_read(attr_file) !=3D 0 here? It looks like hfsplus_create_attributes=
_file()
was called in incorrect context. Probably, it's not the whole fix. Any idea=
s?

> +	if (i_size_read(attr_file) !=3D 0) {
> +		err =3D -EIO;
> +		pr_err("failed to load attributes file\n");
> +		goto end_attr_file_creation;
> +	}
> =20
>  	hip =3D HFSPLUS_I(attr_file);
> =20

Makes sense to me. Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.

