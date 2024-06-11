Return-Path: <linux-fsdevel+bounces-21384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E51439033E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 09:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E79CA1C22792
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 07:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BCD172793;
	Tue, 11 Jun 2024 07:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oeWg8p0T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DFH3BOmp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112FA1E52F;
	Tue, 11 Jun 2024 07:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718091568; cv=fail; b=UVLLDqIGjkBPhKtkJdX+u7bUpe2B1L3V/5PsSF4kZjpyVP9Fnn2Z492C84oDnvbylEvK8stPuiduws0aGFWyPnVhoImSma+5l/H82wNUY3h96CJV2Ic432Y6lcjmlPCvek5wqqDJWxOaKvtcerrw5yYyX/9J7wCeO/WGA5jf568=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718091568; c=relaxed/simple;
	bh=vWE0mrHm9qZJZ13H1Ddl1h1X9iiSb6sfmib0dYSOCrc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U1KFGmeLe2tVwfz9LK0DliK0LDZdG35VpHSNphTb4JucF8EygVY3DV40lRDnyrNbdCd5Kg9f/qh1WqsLQhVVqp51tCZRo0tp8peJtOcQ0zF5VCrr121AbA5IQH1AqA1uoiQfzs4QyB81r4q5yrkWr1JG1Kphc2P5iajbIpcj8qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oeWg8p0T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DFH3BOmp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45AMfsko029329;
	Tue, 11 Jun 2024 07:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=L5mOqZ2Arh1HfJoh224l3JNYyS9lYPxaGAVPISyO8zw=; b=
	oeWg8p0TjOEONP7/W97u4KBT2zA7mtNs0I9jGE/VRqqGMNlxqbjrQx12Dj8ziTam
	ZU5jQRam1NnqSxaSaG3Pa6woIMjSDyR9PGTpIF+9tOKpiwPJiFYorUFIH/6Zf7p4
	mwZ5XUth0Op6+TKlXT1cAnSc1FdOrevAZGPiR65qhvC/yp2O5ygeKnSWvK9ThKGx
	atkl6N41iwZBcKAIreaTvvg8Hrpgl3K7Xz7LfsndMFv7hgKP8k2GmHJsFUAQNbqn
	uC2/ZOEcQku5VBKsvn57Lq/EtqmJxyH8EtpvDAW1MXOu9kvkHKvCuwvNAJL2xJTh
	yHqjvl7cXHY/qbE6X4AVKg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh7dm6ha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 07:38:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45B6b7af013241;
	Tue, 11 Jun 2024 07:38:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ync9wew0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 07:38:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7mFXeWWkP03FwAN/MaSHwssHwRzV93LpLhXA0O8XYrMT90gU+KevHohFvknU68QjfkAMMHOUG2klTDunqischOO17pCwHDh1L4c8QdMK5bllxKyFefJPdn2UmeoNkNT32MHN4ilWZMJg9Itp3jjquP8MkbgSDx8zBoPXoIQxnaEUe4MC9YMmXKfY/McC9H/khsya4bOK3CHJPsz5sSLxBtGy2Y15NZNmotf855m8mSW2PGA02mMmMZuZqNmaOh5wmjHsUeLNC/JvqGT2LMXdj7I95DbR4T3cQHb5UzD6Xk1V5Ey/ohxRgcH8icTKhO/yJYObX1pYN1dN15TPPdPkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5mOqZ2Arh1HfJoh224l3JNYyS9lYPxaGAVPISyO8zw=;
 b=MjAt1PNhweCVRDvcdQFV8Lunh9eGkKzCj7DfUh/4UDCc2ymUehdFPbnOE8I6zCwkEYmimYtaB43cG7ikwtO5dOAHSDFZY1OP5CA86IF2+7x1sKCPNTThCCVk0Iey77FobE1CogDa4GAxKaPO4MESSc/GK6mVJ1sF36yA9B18q7IJhNCmCxfbbPwPfKUoLB16+Zosh5HFLZVfqYYiYuXbAbAv0PNAMvI6syFPj0h4Z2ZWXooeiTl0/Cqy6Z8WSyDj/ZtmrrjMPmBZVkii2iDXEURv6wjQ7dezxd035OuR6vTDpnmDv99+oIC52R40EuI/7djwKBnJjwtwHmepjhtRDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5mOqZ2Arh1HfJoh224l3JNYyS9lYPxaGAVPISyO8zw=;
 b=DFH3BOmpcEvH73oR5/9e9U9FyCjrJSayZmRwMEMLE5/oSNlo+AYB73gQvpwV/J1EfNSW8v3lqjhwZLwcoQgFImWKk3Ve/pqfxxMoHtQhUSyE2X8CobcjuvahN4KvQ3VIEoW9ZjvLbg73RqbOb/wyRtJWhOBnD4Z9ci42ZBsdnpc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA0PR10MB6724.namprd10.prod.outlook.com (2603:10b6:208:43e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 07:38:41 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 07:38:41 +0000
Message-ID: <4c6e092d-5580-42c8-9932-b42995e914be@oracle.com>
Date: Tue, 11 Jun 2024 08:38:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/11] iomap: fix iomap_dio_zero() for fs bs > system
 page size
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, david@fromorbit.com,
        djwong@kernel.org, chandan.babu@oracle.com, brauner@kernel.org,
        akpm@linux-foundation.org, willy@infradead.org
Cc: mcgrof@kernel.org, linux-mm@kvack.org, hare@suse.de,
        linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
        Zi Yan <zi.yan@sent.com>, linux-xfs@vger.kernel.org,
        p.raghav@samsung.com, linux-fsdevel@vger.kernel.org, hch@lst.de,
        gost.dev@samsung.com, cl@os.amperecomputing.com
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-8-kernel@pankajraghav.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240607145902.1137853-8-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0122.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA0PR10MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: be15e079-b49f-472c-81b4-08dc89e98395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OEdZNHkwMVF3QzRLWXFoWVoxV1hPOU53N3pyZG1kVExMUFd4S2dLUUw3alVy?=
 =?utf-8?B?SWVFQkduVjZKNWhoaE5CZ1ByaWtUcVdFUVptOTJ4QmpIOFQ4VUVwN09uSzhM?=
 =?utf-8?B?c0Vha2pBWE9FRkowamxDVEVtZFJrMUdNcEdHYWZSVjF6Y0Q4RlR3c1ZGbmt6?=
 =?utf-8?B?K2d5aWJYanp5d09Yby84WUMvQzBZUFJWK3d5SWY4K2ZORWpHcXN0L2xjUHJQ?=
 =?utf-8?B?Y05uTHUrdHk0SnlsemhNOFl3SFViZHFPeGwwR0dwTUNNdER2aldmNEQyOFVC?=
 =?utf-8?B?UU9Cekl6QXgyVGtGbXl4NkQyS1N2OTloSUFHRmhwU1lLMG1BY0IwZVIya2hh?=
 =?utf-8?B?bW03MzIxM3I5RGpFTTRqOGZQbDhFNHV6czlpV1hicDBFZ3ZQWHdibTlHeVE1?=
 =?utf-8?B?eE1HVjh3N290R2hSWWduUnprN2R3RGVmSjRWV2ZBQ3dEemdjRzJXak1oYmcx?=
 =?utf-8?B?OFA5dzVmYzZYV1B1blNhRjJSSHREK2lVRTBwemhhN3paaGxYYSt1bWxBZDNH?=
 =?utf-8?B?a0NMU25rS0wybERaRitkdGlqZW9pUUhHQlcrKytKRi9PMDJYQm83VGd3N1dX?=
 =?utf-8?B?ME9nL3Ivdkl0a3ArVGNMRjBJUkNyanV0OWtWTWpDa2lwQUVmbnR0OStwWHFI?=
 =?utf-8?B?ZFlHRE5SQVBRbUlBL3duZlRYOUlodjJTcGEwdWgwa1E1RWtiMlFnNGxDRWp4?=
 =?utf-8?B?aURWYVJzRUVrc2Z5K21NTG9aUC9tRjVPK2ZPV3A3Rmd1eDE4cnZkYlFieGRx?=
 =?utf-8?B?RVp5VUpPVVVENHhPYURwZXNEZWhpem1PcmpEY0M0Sjh0aGNoRFJ6blhMU0dV?=
 =?utf-8?B?QWpPd1J6cVpUdlM1Rm5kWjF6cFJkc29vdVBHT2pJaWx3eEMyS2hUQ0J2RUVk?=
 =?utf-8?B?UnNiajRiSlo1aWROVndDK2JyUW9LZFFQQ05XOWVCalRnUTdzSVd3U2h0dUpE?=
 =?utf-8?B?Wkt5V04xN0orTjNKZ1pJc3hIV1dpZ2wvekswSGxDZm83MHJTRXhWZEE5TTZ2?=
 =?utf-8?B?bm5idEhqcVIvcmJSNzFXL1BjTmk1N1Bjc1djSkFLUllsU2l2VWZmcmxCcVlu?=
 =?utf-8?B?SDJGRVgvN3dUZWN4cklSMHFYcmZmWkxMbXNiRlcrK3JQV0pMTmllMU9nZW9B?=
 =?utf-8?B?MUVUTEtBQStWY2lSQjJYYnJBVXhGKzdkVnZLb3F4ZlhsMW9Gb3pIWHUyRG5M?=
 =?utf-8?B?WHVBMCtJdXlxd1hjUEFsOUpXaGNlSDZhazJlUG5TQTlEbTlKUlhCb0hZQXM0?=
 =?utf-8?B?bzVycDMwTzVFUzJCUUtUdnhvL2IyTGROY1kzQkR6YzVaREVhMTN6V0syK3BX?=
 =?utf-8?B?ZHVhWVQ3ZXd6OHRnaS9jRFpKTm4xV1NOSGZqR0xWbTBGemxrVTA5YVlXV09i?=
 =?utf-8?B?MzZNNEQ3QzFVZ1hnNnQwZ2d1cG8xUWJjaG8rNmFRa0MzckpNWkZKdVpZWTNQ?=
 =?utf-8?B?VkwybkR1WGNGZlYwTys5aHNkdnFiVmMzU3ZKVXdUTHY1bXJTenNGazc4N0h4?=
 =?utf-8?B?b0xld1ZETElObWFCbTdlaXM4TkxId21HTVlEUjQ3V2lEemo1dlltNzZOSkRR?=
 =?utf-8?B?U3NIZEdIQlFyQmhmNUdaYmEwTFRnaGlFaS9pSkhBL2VLQmY2bTAydFlHV0hl?=
 =?utf-8?B?N3kzRDBYZFYyajhaM2Uxa1ZzbitvNHhhRlZ3Q0NUU0lKRDAza29mMUlUR0ZE?=
 =?utf-8?Q?lou+hikjcadiqzcYQBnv?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?akNXSGVRZEZTRkRPS3RkR0xUTCs3ZmQ1aHdLM1A5ZjRpc3hIT0c1TVBLRXk4?=
 =?utf-8?B?YlRXNU02QnZUWERpVEJSb1g5Qjk3SGg2Wk5jLzhIT0VBdE9ueENsQm1HWEdn?=
 =?utf-8?B?MSsvM2ErZW5jMklBRXRNZUVPRGgxbkJSeUFqeDQ5dzZkWUlFYkRsbk0zc3JC?=
 =?utf-8?B?cWZRTHZZRGpxWm01Lzl5b0hzajE5VjNwMDA4RXBLYnNWcTdYWmZxS3hOYzNj?=
 =?utf-8?B?dVJIZVBiUUFDMHlOUEcrYUIwOXpyVjlUcWQ3YkNSN2tjbi9CY0p2ZERTUzR5?=
 =?utf-8?B?bjRZdjVwWWcvOC9CRGh5dDBlU2lFaDVVYWhKMWE5R3ZyUXdEaUM3QnVrL3V2?=
 =?utf-8?B?UjNZd3JIZ0JpUVhCUEFRQkxxYXVrZkZBZnhMeklrQy9DTjdib2dYWkJLL3Zx?=
 =?utf-8?B?N0wyK0tZazVmQlo5TUpFWHlEQjJPekJUNCtId1RDc2gzQnVkaEJRYjhpM3kv?=
 =?utf-8?B?dnVHYjBtKzJpZnJKOGpxbTNVM2VUY0hGN09Dd2FhL3AwNVFrVDd1aWFJTmZm?=
 =?utf-8?B?aVlmL0dWOGlhbGpmRWRlejJaM1pGOU50U2VuMG52bDZBWDZSQ1ZkSmtCejhG?=
 =?utf-8?B?bmRNa3o1RlBzUmtXUkd0dWhaSVMvV3pRa3cwcjhoelBaVGkyRUNCUVJNcVVh?=
 =?utf-8?B?d1p5RE1iQXRvTXkrd2ppeGVVTlViWmdxdUlSckNyR0c5djBoN0hsN3JDbkdm?=
 =?utf-8?B?Z2dkWDBYeitCc09IbndkRVRKWTgwZmJQVXdOVFg1REx0cFQxdEhSWG1tTnJr?=
 =?utf-8?B?S2pmS2tiMXpmUDREMDVuSzU5SUZWYTZVakdibHgwTTZWdWFnRG4wT0dyM1hH?=
 =?utf-8?B?MUoxSml3SlRpUUpWUkZkM3lrUkhXWDBqUmg4dXE3R1lsbkQvbzBKOWFxN2pH?=
 =?utf-8?B?N2hBMWhRZS9RcGRacUcvd2lLVzlMbTZESFRMc21FSDV4ZGxmdU5CRXpDWGYw?=
 =?utf-8?B?TlYzOE5RS1krRWh2VnpYR2ZONzRvazJmVS9rZHBldWFncThEc0RvVisvVSts?=
 =?utf-8?B?YytlTmVWb3FkZWdocDlleGJ0N0w0dXdUaFUzN01pcThNMHdMTjZUVEVMbzdC?=
 =?utf-8?B?dVJCdml4c0pUUDY1bDlxWDNpd2VYY2JMV2RnQ0ltS3RFRnpWaFRUNk53MnBr?=
 =?utf-8?B?MFg2OGdaQ1oxS0pMZWpINHI4VHdBeFZ2ZkVWV29KVlV6Rm1mdlpiM2VMbk5R?=
 =?utf-8?B?dTF1eVJScEQ0cnp2MHNOZGdpTWlSYXl3Rmg1Ri8rclBacFZWQmhFK2Q5YmVX?=
 =?utf-8?B?dktiTmx6bTdRRzdDbUFWOUF2L2lTY0M5MlZ5WmdJZGxUVjVzMCtDaTF2STVJ?=
 =?utf-8?B?TTExSmg3TzJFVExVbDFKYkQzSFhUK0ZCa3pZaUJtRGlDU24zWTNudUY5R1JT?=
 =?utf-8?B?UDhsZWhPeHE1b3FXa080NjdaSUNBc0dQcEdYSzNPc2pWU3VDZ3FRM3dIbDlD?=
 =?utf-8?B?SFVUSmJoQVJEN3dlK0hhRG5jSm9HaGo2R2xyanNNMWVvQi9jU2h3dENmK1Ju?=
 =?utf-8?B?YlhyU1FrK0FzSDRwSXI3Sm5NS2RMVFIrQjZvUFNRb1VLK3lUaU9WZlZCT1NX?=
 =?utf-8?B?WmMvTUpkYy9lUzRVSlc0NGU4cHJrK0RMN0d2dStlU3dFbnc0a3lhVzkvdkZn?=
 =?utf-8?B?clR5ZWZzRithdUlmcFVTTzkyaEtlK1piVy9FUlVaWGdPTXhiNUtnL3RHc2th?=
 =?utf-8?B?RUtQdXFuYVhVNG1JT1JwY2xqOW1SYW5CRzV2YWc4djJQdDd1YUFURTQydE52?=
 =?utf-8?B?MnBHbjRwVlk1MENlOTQ2ZGlaemw4QzUxaTExT3dLMEhBT0F4T2xLeS9CTnZC?=
 =?utf-8?B?cjlqSU9XNDNTZVN3K3QrSnhiWVRCUmFhc1lpRW0zOUNRNDhaWTZnaXQxZFk0?=
 =?utf-8?B?VzAzbTJBYlJSUDlLR1pMNUFjWVhseWtXS2c4cXJYZDN3STY4RDluVXRUMUVQ?=
 =?utf-8?B?L25lM2dLc2RIdmI4VkdHMDNwUjZGekRLRDlqVGFybUhBb2JTSHFlbTRvcjY0?=
 =?utf-8?B?cDBLMWczRlFHVlNlb3RBL2h6NWxDbllxRThMZW9mM21ReGdhSlZMN1JhckJx?=
 =?utf-8?B?elg0UmFEVDcvbG1VbFdYclhiVitWNFJPQnVmNHo5NXZwdWFwOTFRM2x0bWph?=
 =?utf-8?B?S2o0aVM0aXhzNDR6WDY0N3NuTTNmWFAyL3VjQzZCOExVTDlkMlRHKzJPekZw?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	F23HdRsyyMB9vBUafCJhBRMipqile18VsetuReBMZxOX+kYThGaAt4v9lwSx8PrB5mgbYqLDQgPJDIUUjW7jeWh/TB26iW7fHoCbBtecSu6Kl39K75W0HWKRXu6N0z1vyRNH+/o+ofgy/E8JS0XJLsBsdR0a1fc51/nq8UZYLrpae1JBKZc8YJUbdrydkYA5RKQT2gGVttRD6lvWiReeRSqkOZi1803zsqbMLFZmZjXPYIR2bRMtnEcOY/u0KhFW7aPj4fuxChk427mUHSmV8OxH67mWLBzNZyFphbETh5+O9qYAg/JK0Hm2U9KOhLuV2rEb6Y1FipmlvkdrspWZDSQGiLLArMk5eXS2qrIHXO3b4KwRSpVg/wsvrUBvr2vh0S7lcDrKWQQKwe90OrV+zmz7K/XdVX+xTkx8DPY4zN5KO3APb8PQgvt/gcW8hiKVmOYUEShOAVAICXTvYMlj7cUp1zJE70fHs6y92fzHYtiYaLYnAN0Eb3mq7pYh7trIzX3TE3U8r3nggxh3+YmkPevTBc8vqpuJF78VPAMrRrPzlzd9kRaWQ/4Bo3wDwz9PLAJyckEzdOAB29xyY6mTWt7DQkg8cG9+KllseWyizsM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be15e079-b49f-472c-81b4-08dc89e98395
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 07:38:41.0100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S7oRZL/L4aPPi1DsdLOClsqLGAAMtJqgzQWoGAC51YealfNH0R/2RAlV3Mzqcy59fLbuCT9tYGcPLnUuBiTJBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6724
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_03,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406110057
X-Proofpoint-GUID: 9vxlTjxvw2_YPl273lL4CRZtp7o-e0_Y
X-Proofpoint-ORIG-GUID: 9vxlTjxvw2_YPl273lL4CRZtp7o-e0_Y

On 07/06/2024 15:58, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> iomap_dio_zero() will pad a fs block with zeroes if the direct IO size
> < fs block size. iomap_dio_zero() has an implicit assumption that fs block
> size < page_size. This is true for most filesystems at the moment.
> 
> If the block size > page size, this will send the contents of the page
> next to zero page(as len > PAGE_SIZE) to the underlying block device,
> causing FS corruption.
> 
> iomap is a generic infrastructure and it should not make any assumptions
> about the fs block size and the page size of the system.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>   fs/internal.h          |  5 +++++
>   fs/iomap/buffered-io.c |  6 ++++++
>   fs/iomap/direct-io.c   | 26 ++++++++++++++++++++++++--
>   3 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/internal.h b/fs/internal.h
> index 84f371193f74..30217f0ff4c6 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -35,6 +35,11 @@ static inline void bdev_cache_init(void)
>   int __block_write_begin_int(struct folio *folio, loff_t pos, unsigned len,
>   		get_block_t *get_block, const struct iomap *iomap);
>   
> +/*
> + * iomap/direct-io.c
> + */
> +int iomap_dio_init(void);
> +
>   /*
>    * char_dev.c
>    */
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 49938419fcc7..9f791db473e4 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1990,6 +1990,12 @@ EXPORT_SYMBOL_GPL(iomap_writepages);
>   
>   static int __init iomap_init(void)
>   {
> +	int ret;
> +
> +	ret = iomap_dio_init();
> +	if (ret)
> +		return ret;
> +
>   	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
>   			   offsetof(struct iomap_ioend, io_bio),
>   			   BIOSET_NEED_BVECS);

I suppose that it does not matter that zero_fs_block is leaked if this 
fails (or is it even leaked?), as I don't think that failing that 
bioset_init() call is handled at all.

> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index f3b43d223a46..b95600b254a3 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -27,6 +27,13 @@
>   #define IOMAP_DIO_WRITE		(1U << 30)
>   #define IOMAP_DIO_DIRTY		(1U << 31)
>   
> +/*
> + * Used for sub block zeroing in iomap_dio_zero()
> + */
> +#define ZERO_FSB_SIZE (65536)
> +#define ZERO_FSB_ORDER (get_order(ZERO_FSB_SIZE))
> +static struct page *zero_fs_block;
> +
>   struct iomap_dio {
>   	struct kiocb		*iocb;
>   	const struct iomap_dio_ops *dops;
> @@ -52,6 +59,16 @@ struct iomap_dio {
>   	};
>   };
>   
> +int iomap_dio_init(void)
> +{
> +	zero_fs_block = alloc_pages(GFP_KERNEL | __GFP_ZERO, ZERO_FSB_ORDER);
> +
> +	if (!zero_fs_block)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
>   static struct bio *iomap_dio_alloc_bio(const struct iomap_iter *iter,
>   		struct iomap_dio *dio, unsigned short nr_vecs, blk_opf_t opf)
>   {
> @@ -236,17 +253,22 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>   		loff_t pos, unsigned len)
>   {
>   	struct inode *inode = file_inode(dio->iocb->ki_filp);
> -	struct page *page = ZERO_PAGE(0);
>   	struct bio *bio;
>   
> +	/*
> +	 * Max block size supported is 64k
> +	 */
> +	WARN_ON_ONCE(len > ZERO_FSB_SIZE);

JFYI, As mentioned in 
https://lore.kernel.org/linux-xfs/20240429174746.2132161-1-john.g.garry@oracle.com/T/#m5354e2b2531a5552a8b8acd4a95342ed4d7500f2, 
we would like to support an arbitrary size. Maybe I will need to loop 
for zeroing sizes > 64K.

> +
>   	bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
>   	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
>   				  GFP_KERNEL);
> +
>   	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
>   	bio->bi_private = dio;
>   	bio->bi_end_io = iomap_dio_bio_end_io;
>   
> -	__bio_add_page(bio, page, len, 0);
> +	__bio_add_page(bio, zero_fs_block, len, 0);
>   	iomap_dio_submit_bio(iter, dio, bio, pos);
>   }
>   


