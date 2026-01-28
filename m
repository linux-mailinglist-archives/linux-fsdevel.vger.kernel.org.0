Return-Path: <linux-fsdevel+bounces-75679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEalHoZdeWnXwgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 01:51:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D5A9BC13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 01:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70CD83013A69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 00:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F2D1FECCD;
	Wed, 28 Jan 2026 00:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h8D12X26";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kTPzlvrV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FACA7A13A;
	Wed, 28 Jan 2026 00:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769561468; cv=fail; b=DehYEE69OXUrOyre6YCVdr++QQeoXCQiZMWjOenfNFtuGOC6ubcbVQjYme8fHoZhNre55pkQ7yBhJkbPEtG/hYsw2Q5cxS2f6/GrNdLhvvSkU7vVyYiB+T5OohrOqGmLOs0d+EXY/d8/RY7+VemvwA97bcJI7rRh4oozeEREHoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769561468; c=relaxed/simple;
	bh=L5pWAbm5T7E1mpt2JFolDXTnsS/iGQhaBgISoALyR2U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a+HNUg0ikL+z/A/z0uyRUOaK2WRN/0TnrG0yU4GdlxqKNtTWWW2GIamruXvQyB8VrNRx0BDZCC0PGQyzMzHV83DjjshC5ZIq1Qr/0ijrUeoxtIUu+27fIWs67JmVgpg10oZkqvG5YneOCOWnpxai77GqmYQj1AwmwgEJPWRbLXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h8D12X26; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kTPzlvrV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RNEFOD950001;
	Wed, 28 Jan 2026 00:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bGPqsHhHFyJm7z7eQLgaW9hRsHzqCFiVqwsuYoGFw6w=; b=
	h8D12X26yym7xqKgALb0DgH6Z2lpE1FQciOLpwVcetctwwIBMvkI5SylT0jyTqOG
	TIcTVSQNxgnOcuyiFdq8H1zD1g69zJa2Bo8lHyMbwp0fQmEhXaEY4CMQJl6ne+Tz
	xK+w+ZEE49CWl9Fg47qlDPWVZaBA50vrmN5LOtF5UcPRYqNsL4iRsMPTmR0RuQ32
	1l/DI4fhq1L22+xjy04k9NuW7eRcOv7bHV34edF23M7NLYUdePPmy4zxJXHBDN5C
	xmKkABBzI+dW7NSLMHpOrmZbusLLe6vDTHsyKQQbgwL3IE78G/QtNs1DbGfcveEn
	nJXffKgw3NNE00XR6G91gg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by5dj08dd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 00:50:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RMx3WB033453;
	Wed, 28 Jan 2026 00:50:44 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012037.outbound.protection.outlook.com [40.107.209.37])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmha75g2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 00:50:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPZRAt1fX42eBpVETVo+RT14dfuE181Z3taci/oeqkWxeHpzDXOl/RlNGwczWYncqc6hR0ziPAiY/RQDe8Re0Hk2jkC1dXp+mm4anGzlBf6LjnC/7nUfD/d/fAb2l67DGWgrIP4f3Werd5YgAynOzKDuM5WxyZLy5fvEEEErEof7EXbr8BtPpWDfU+miMBNubXX7OCmAEh2N9UQP741OzbhgLyXP5Bg4kD9FVUUfFYR9t5h42ldyAn+C0ASRMlprxZ8PQDUme4taWAWdCS44ijOHSwCsqKX6+kphYGiwAPVKa4mujgcMhg4CMShsoYVXTAJK99gYhSODpwCB7ybGqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGPqsHhHFyJm7z7eQLgaW9hRsHzqCFiVqwsuYoGFw6w=;
 b=JjN2LbT613Afjdmw7wJ+ZIp7xz8e5zl7m6exE66Vedek4hlC4Qcc10nXrU010l4q+ym1OdS9/nHB0EIXPt1ix97GKk9Sw7whY7FZDcinAaSa4PWh6qtWC6iteAjO6SzergWERO8BR+ZCkEpEGQWhaoHSHus1+opf/qBNnTrycT5HahxELkOGILYpPeBO6swBy5uyg92h6yXLl0beQr20phWuufcZ9OW9nAlKG6K2uKwGCqiAoHWvYY4XXUXgfHpTag0XDfRWmBCUxbgdPhgDc23hUHmhRjl8fim97WDXfsDXozAd2DP8P70Lbz1z5h4H4LinNre7gYj6pBIuoDAFTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGPqsHhHFyJm7z7eQLgaW9hRsHzqCFiVqwsuYoGFw6w=;
 b=kTPzlvrVoDh16t3Zrd6sR1ZnW1p/t75jjr/KKXKmpyPZf1uqUsveFt7FCf8KCfAxWXXrApgyBcNJqctnhyezWf0+iZ89uhpzmpBnO718LDmmh4iYNGFbFcV8ajOqC0pKGd7L7sqPf1KN6IQu25hOpVjEof+U6SEHUUKNp1WPO7o=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DS0PR10MB7090.namprd10.prod.outlook.com (2603:10b6:8:141::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 00:50:40 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 00:50:40 +0000
Message-ID: <ce920f39-42d5-4147-94f6-836cf7b1438f@oracle.com>
Date: Tue, 27 Jan 2026 16:50:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] NFSD: Enforce Timeout on Layout Recall and
 Integrate Lease Manager Fencing
To: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
        Christoph Hellwig <hch@lst.de>, Alexander Aring <alex.aring@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260127005013.552805-1-dai.ngo@oracle.com>
 <88a3edc5-4928-4235-a555-a7017d5ca502@app.fastmail.com>
 <d8040fde-ccdd-443c-928a-9bff93641294@oracle.com>
 <050225b0-1cf4-4a6c-ab49-7427db70ae7c@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <050225b0-1cf4-4a6c-ab49-7427db70ae7c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH1PEPF00013316.namprd07.prod.outlook.com
 (2603:10b6:518:1::5) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DS0PR10MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: 00aa2a56-ee5d-4a0f-8d6d-08de5e074234
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MXg1N3RreVBEQmpCUkJOT0M2QWE2bXQweXpsWnlkVFNkMVhDdFJobG5hc2JU?=
 =?utf-8?B?bFlUaU9va2VyUzFSNUhrSXFDa1FHS0dxM0lZOWMySlFxbTVqZkNvWVZSekdV?=
 =?utf-8?B?NmNHR0haZU81Yno1WnRBWjlxdVhrbUg1QVlvTHBvMlJqZC9aakdVK3NwMHBD?=
 =?utf-8?B?c3lUeXJqN1lkczBtVWd3djhaVmlRN2l4S2lQTW42ZVJhNVZ5eFgxQnU1bjZu?=
 =?utf-8?B?b1FxOVAvUFBZamQ0TmZaeUIxVnFlY2EreUFlN3pUL2JUVU9iNEg2eHdwalVL?=
 =?utf-8?B?aU1Ca0g4MlNqUDFhSnFsbys0dnpGK1VjakpTKzBqS21qQTczdldWTTB2WUtn?=
 =?utf-8?B?aHgxU0xZcUxuemhzYVhFWjVJc1h4ZkcwK0dmNlhyRXBXbWtiMlY1djVLZ0dx?=
 =?utf-8?B?eE5LM25SQTdwNHpFVU1MN1NuajE4YVFaajZ0TWdZV3lwdmR0RVJZRFhSU2tp?=
 =?utf-8?B?b3UwOGpCdTAxOE9VQ2VSalk3RTdHbUlEQjdJckV5NjVPNzhjNmVVLzcwNTJi?=
 =?utf-8?B?SDhVanI3TzFFODdEK1J5V1NTZ3R4aGp4RUdYK3ZycFIwVFpaWkJlbWFGVGsv?=
 =?utf-8?B?bFE4Y0RDU2EwNUdOcmNJZUQ4QzZFeVhrWUN3dkdoVFMvM1hFL1RwM3U2Q25p?=
 =?utf-8?B?S29Kbm8xTGdXb1pjUllsU3ZuZGNZZVR1NkdrQnZNSUNTSmtNQThOL0VZRzNV?=
 =?utf-8?B?YXhjU0EzMm5VYU1OWVYydzFERzY5N1ZDcWJrK21tOWFXZkNBbFV6ZjdiM3Fr?=
 =?utf-8?B?b0lReWszNnZWbVBUa09Za0VFRTNCSE5VMWQ5cllJS1FBaVhHS0JQR2VBUVE3?=
 =?utf-8?B?Y0ZyZ01YcEdTN0hCVEc2RzBob0JoSDRxeDBtUFRqY2lpWUdUMzgxQUZrbUlQ?=
 =?utf-8?B?c1k2b0xaUENKK1BoWXVBQUcvaHJQVjRFU3c1MEZHdXZNVGpCeGlGUXR2Mm5j?=
 =?utf-8?B?WHNZS1JWQzVORUFoU1l2eWd0KzBnQzRWMHhCZEFhbWx5dTBhd2ltZ1VwSkd2?=
 =?utf-8?B?UHhidW9BTDlNWC9DSXUzbi8vZjNVTk92NnNERTNJU2lISlJXc0d2akthQUhL?=
 =?utf-8?B?TVk5Wk80b29EK1BDMjJIREtMa1p5SVpxdlZpZmRtbU8raTc1MDZRRVdMYW9w?=
 =?utf-8?B?MGhXS1Y5dHpOQjVpaStRM2lEM1Nac0MySS9nKzNQVC9VK3NWY2RTc3RtOU40?=
 =?utf-8?B?UitzalM5ajIrUjRNdndxbjRIVC9VY3R0d2VpWmZGTU1OUHRFRDEwYW5kOXZa?=
 =?utf-8?B?d1ViNHhqZkZyd3cwRVRsZ09KUWhDbkhwbU9BNkJHNFNQb01tR3V5NHFNRXhQ?=
 =?utf-8?B?WGhyUllJUXRweElsQk9HdVZPcTYvTkx2TXJwZThETmV5WFJ6REhBbW5FQUVw?=
 =?utf-8?B?SWgydzV2cVlyUWNialplVzdLZW1KOFZjNGNYNUhXVDNkNG0xZ1k1d1c2bjUv?=
 =?utf-8?B?MXdmNC9iK0J3REFsSXVTVWIzVENuWVlSbW4xSlRXeXRwZ1F5WXludkdjMno3?=
 =?utf-8?B?MGlJMkxLU1AvRExMZmNUSFE0TktTRjNxOHFrUVZkcXoxUzE4eWtSUDh1dVFU?=
 =?utf-8?B?bEhvUTlRQ0wxL0xnaG51SHIrdXFOTmIvSmZ5SklRQUpuVmlIN3JJcWk4ZEpa?=
 =?utf-8?B?UlFscHdKUVBMeXpncS9xQVQwemNHYWFVNzBqQ08zWVZuc2h2SHcwNjMyZjFZ?=
 =?utf-8?B?bzR1c01Ia29uVEJvZno2am5HWEd3RkNPVmdiaEJuTTQxYzhHUVN3TlljNlF6?=
 =?utf-8?B?Zk45RDI4QmFOQ1lHTVBFUG1KaGJGdGRDREwyTGFlMEdIa2dDd2psQkRkK2d3?=
 =?utf-8?B?VmliR2lTZWRIZjN2NnVwNHVZRE9xTWQxNkttb3lheEY3cm02TTBmaTZra0wx?=
 =?utf-8?B?dG56aUY3UzVnTGE3QU9WQkF3RVp0WWxyb2JyRXBnbW02dkhKSTBkdnE2SklT?=
 =?utf-8?B?QTNlN2NZOGtIRUhUYnVmL3J2djVOdDhqWEtSVmtRdzE1OS8vTlpuK0p6U214?=
 =?utf-8?B?OXF3Nm5BUk9aSmtyd1RtMnhLS0U5T0FXdW1tRURsVzVrdmtEU2Z3M2xrM2kx?=
 =?utf-8?B?ZG1iNzZxVXUvT1BOMU4zbTlRZEVrRWdKdzNVWlFsWFg3QkxmZmMyYnV4TW1l?=
 =?utf-8?B?cFpHYnBjZmlkWTh3alJwcCtsU2kvbzB4b2kyejI1cDRjQVh1UU5aWUN5Ylor?=
 =?utf-8?B?ekE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?a2FQVDNEWi9rUzQ3cnpIMW9DM05kWXU4bGsvanlmempLRzc0alRDeFVIOU5w?=
 =?utf-8?B?SlYvVmJaUURxSkRFb0paOGRRR1dqRVUxdXQ1Wkw5UDBsU3RBUG9VR0FBU1dn?=
 =?utf-8?B?SWMraEZoNWN2R3lPUCtraWUwcXR2bWNYbGRUMmROSWM1M01NME1UeWdFN211?=
 =?utf-8?B?OTJuNThpMGpKV29lVU9kVFcvemMyVi82ZFFKODBnN08rMDdWR2FTbHEwaTFw?=
 =?utf-8?B?bGo0cmpUVy9xWWp4L3NtOU1KTmgvQzBjNm9hTTNRNDZRbTBaMFl2WHFraGRo?=
 =?utf-8?B?OEtjSmFGK1IzNS9GQVp6S0QvZDc2bjh6MFhsUml4R0VUMzFOMTNXNDFnZk1R?=
 =?utf-8?B?b3pkVkx4NzlvQzhnRUVjODVPbHZBYXRCczNyNTBFSGV6c3dIUlgwUFJ1R1gz?=
 =?utf-8?B?MUU3T3VqRFhhZHgyTkRoMjJ0MDhDNFF5WmtqN05HVmJ0TUlKWnl3Yi9UY1p2?=
 =?utf-8?B?ZFBETHRZeUhCREFrZnpaUjcxZ2hmMlVYcXFnbDlQQ3NDNlFIWm1vOW02cGFD?=
 =?utf-8?B?QU9GUE5xUGFCY0pTM0thMEtrMHlWcXBRSFh0V0kvOWo0MUt2Ri9HSkpDMXh2?=
 =?utf-8?B?WkZLMk9ZL24vSXA5dGdDRGJma2ZSZU1lTEx1dmoxT1JIcTVDZXJuN2hkZ2Nq?=
 =?utf-8?B?em1XU2VrTm12RE9qV3VBMUtyTHUvb1A2VHJpck04dTQvSzFXcVhwMi9TYlBo?=
 =?utf-8?B?ZThaYm1sbXV3Umx0R1VLQ0xoQnVnWjE5Z0JNOXlaN0RwUEg2alNaUVRjd1Ry?=
 =?utf-8?B?bTJrdmU2a1RZdXI3S2FrYnZQdDg4c1dFWDFvdThaa2pudStrQzJzSGRpVnpx?=
 =?utf-8?B?aTdrUjNBRlB6eHpTcVlnRGpQT3ZURlROZGZ6Y0tzZ0I5L2tRcXRCTGVvL2tE?=
 =?utf-8?B?cDFPeVpYSHlBOVhBcklHZHFjODc4L2dYRW5SZHNraDd6RExXUXNYUFFOMGhF?=
 =?utf-8?B?QVRJbnFpL1VLczBvUGRKNXVJK1o2T2RXY2h2SkQ2cUREUjRYZG03ZCtYNlln?=
 =?utf-8?B?MkZ2cVdYWjZ4L3Znb1ZPcEgzOVJzL1hmQ3AxK1pjOU1BcDQwTU43NGF2MExn?=
 =?utf-8?B?M3JPNW5zZEhpbnVRSmNJQ3VrT1lmQldlb254VEQ3MmQyeXhVMVNtQmxGdnor?=
 =?utf-8?B?Q3pCMnFUNFpEdU5JQlpFRkU1aURWU0tOQk45VVVlbVNEa2plelhwOU5WQy9N?=
 =?utf-8?B?TTc2U1BveHQ0QzJUMnhRMk02RDVwd0xqd1FhcXF0UVZNVUcvamNqQU1uWUI1?=
 =?utf-8?B?ZmR6UHE4V05Cd2pKTkVrVW91Vy90TitWWHh4aFdUamV4L21lT09pYzREWjRI?=
 =?utf-8?B?bXR1aWVRT1lzZWs4UEJ2TlVFMkF2NnZxOTQ5OGpQeDlpVzF6NUtrRDdyZ3hs?=
 =?utf-8?B?L2tmMThlU052L2M1ejFjQ1N0ZmtSakVRM0hNQlJMbDVIUnUra1pRcjJSYW1m?=
 =?utf-8?B?a1YvN1hMcWJNTlNtWWUvNFE4ZnI5OHpSMzZsTC9qSGlESVRaWFZob2F1bmcx?=
 =?utf-8?B?MlFMQm93R2cwMVZFcG16WUJrZUNnL1UrQ0s2Z2x4bU4rYWdYNWRyNm9SbHZO?=
 =?utf-8?B?dGhpdnFTWThxT1hHTkRBTWdiTFdNUHFJNHNNK1pKbFJtbE4xbElTVm1yc1ZI?=
 =?utf-8?B?Z2tGZjBkK0JLWTgySkg4Ym1WRml1am9TMURrQW5XMlViWkZ2RWpKZDBockJk?=
 =?utf-8?B?MmlzajJiMHVVVTl1SzBwMWhVUG5CSXlBa2Z6c2xka0RjbUlXRXdTL0xGbG9k?=
 =?utf-8?B?YW9FQTR2eW9OTW04ckRmQzd6b2l1NXE4R3FuWE9lZFdER2JtY1RRTUF3eFg5?=
 =?utf-8?B?Nlc3aCtxMis3M2E2NlRYL2NXV1RFZU5kVXlVb2Y0ZWdRdWQ4T2NqUnVvUlRV?=
 =?utf-8?B?VWJoTk1iRitkVkhQK0xJMnVnVHZ5WFhQMS9HWHM0aHdhVjdVU0J4a1hnMDgw?=
 =?utf-8?B?ZXBjaTZVWXIzT0JlNWJldmNNOG1RNTdtdmpmbkZDRW4zWmg2N2VHbWsvVk4r?=
 =?utf-8?B?cEVNVEV4U2NyQjRtbXNHa0VCNE1uNmxwSzN3bFN2S2F1cWxiTXpnTjlJcHJL?=
 =?utf-8?B?ZFZmQUwwWGsweGkxVGlZQTFJS3VQM1hsU2pxem9BeE50TUdycDNTWGgwL2Mv?=
 =?utf-8?B?WTBGczR4N3FKVmdhdnNneDZhYmF5SGo3YnN6OTJ2S0YrSDlJV0REV0J0Vyt6?=
 =?utf-8?B?T0QwcUFQY3l1REtEc1AyenE5K0pBQVV4TXFjVXphQnRjbHpTRHQzREVrRGJm?=
 =?utf-8?B?QWlHaEZmUXZsQ1Q4TXBqYXcvWXg1Tm5tYzBubVlkMGtxd1JhV1NTSTBnU0xa?=
 =?utf-8?B?OFB6VER3R3dxcHVzWHlLSmpBTEZ5OVpzL3lKdmpkdmdvUUs5SVY5QT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MhNkWWRZSPqPDnyw+TDpiTtw3WMyQvESDF4c7JPBwxKcVBsXRImKXOAJ66lx53ORbCSYdDj4KWXKtl6j9hTlLomv6zFufp/oID1XuIACyei6VrN7oTmGq6apdHjdGTVbtsAgKNSnR3N2IeUsLcT1W7y1qKf/aBGLGAx8Z5/P5a2cnirMMXpJHcByGssyqiiF18J+9V1+9K9ruTwQfLVblJMpYZAhEbkgKmVCDzz8bySN7BtI4DV0rCigpDpfdPxMfAh/1D7JQ7NWXyU818bHITxJ0tEAvEfDjFmR6+BicwzdfbczG3IcPJRB9+0ffp1s67U90o7R4TnjjupzxdkA4Qd1fVjMubT+0EOb3Upbw1TUHX7xErfdf9SG7n71EZIkZvSbKN1tNPXiXKQRnp3jfCJnziuDx6V/poJNddEs8GkQsoVmIsIOGRX/ZrUBrqZXqWLy0icmWoo04g4aWyhOG3ArJlcOZKN5OKDHX/KixSTAVvbAs4CJWXiK89hAom5c7RNJtvLfNk3Mw/dJEdiQJ9QWzKfvHuWrsS0ppEzTjeuxCX1A5lBpDotFMgRUjf7EQXdq0pc+XVnkiikTll31/lkoZZRMk8SD/4VIWmcBIAU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00aa2a56-ee5d-4a0f-8d6d-08de5e074234
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 00:50:40.4114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z6iJVUMbHM9xz7Li2JzkcHq9rL4AqgN6W5x+muMXWT477l2hNIBsPjGHoYpatXgBzEAd4yopmj9S2DKrsjLeWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7090
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601280005
X-Proofpoint-ORIG-GUID: -dPzHEw4PcnQ940rNnUcv7EmK2DhB4LW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDAwNSBTYWx0ZWRfX/0XCQ7Wl7GWH
 o0o4KPMX6dq2ar1MvABDjMEn06j7LTMF45Trl26UAHEYa4E/kpIAb7DQwTzoJZwG+1/jkywQdGU
 hwvNu+x/MD0Ij7iBVHJPn9dpqAuwLpQyqY3CzsalYEVyBMm/7Z3iuedLFWy3Y5D9duhTVUWcuOj
 9eBN4xldovofg69cfIaU9RZ3b1zh5B8hj1g9RP5r3Ch+6YCPEeQcvone1A7OlasWqRVedqPhEbL
 Il8YArkTgKIJ9bXdcuE1Ks7AnrQ2QjLKybtHTWMugtJt8WKlVyz2GR1tRBs9D4/3JCbZrYMMUt5
 MuIhjW6a6QZXZH9uvZcUb9yhWkQ8Z/FIWKf7RvKY4TfCk7j4hQ/Z+DBYEzEeFAasXxrmK7PK3h7
 HeYX53d4fMSlR6P9fpon5X1BIyXEnpkupf/sEMR/z0b3gE7cKHB9dqbgkLWOOjpP+kNMQL+Ybsh
 wvLRxeUE1diD3lvIecg==
X-Authority-Analysis: v=2.4 cv=IrsTsb/g c=1 sm=1 tr=0 ts=69795d65 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=pZXx_lyC_BmPbtgha9wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -dPzHEw4PcnQ940rNnUcv7EmK2DhB4LW
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75679-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E5D5A9BC13
X-Rspamd-Action: no action


On 1/27/26 1:53 PM, Chuck Lever wrote:
> On 1/27/26 3:36 PM, Dai Ngo wrote:
>> On 1/27/26 9:11 AM, Chuck Lever wrote:
>>> On Mon, Jan 26, 2026, at 7:50 PM, Dai Ngo wrote:
>>>> When a layout conflict triggers a recall, enforcing a timeout is
>>>> necessary to prevent excessive nfsd threads from being blocked in
>>>> __break_lease ensuring the server continues servicing incoming
>>>> requests efficiently.
>>>>
>>>> This patch introduces a new function to lease_manager_operations:
>>>>
>>>> lm_breaker_timedout: Invoked when a lease recall times out and is
>>>> about to be disposed of. This function enables the lease manager
>>>> to inform the caller whether the file_lease should remain on the
>>>> flc_list or be disposed of.
>>>>
>>>> For the NFSD lease manager, this function now handles layout recall
>>>> timeouts. If the layout type supports fencing and the client has not
>>>> been fenced, a fence operation is triggered to prevent the client
>>>> from accessing the block device.
>>>>
>>>> While the fencing operation is in progress, the conflicting file_lease
>>>> remains on the flc_list until fencing is complete. This guarantees
>>>> that no other clients can access the file, and the client with
>>>> exclusive access is properly blocked before disposal.
>>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>    Documentation/filesystems/locking.rst |  2 +
>>>>    fs/locks.c                            | 10 +++-
>>>>    fs/nfsd/blocklayout.c                 | 38 ++++++-------
>>>>    fs/nfsd/nfs4layouts.c                 | 79 +++++++++++++++++++++++++--
>>>>    fs/nfsd/nfs4state.c                   |  1 +
>>>>    fs/nfsd/state.h                       |  6 ++
>>>>    include/linux/filelock.h              |  1 +
>>>>    7 files changed, 110 insertions(+), 27 deletions(-)
>>>>
>>>> v2:
>>>>       . Update Subject line to include fencing operation.
>>>>       . Allow conflicting lease to remain on flc_list until fencing
>>>>         is complete.
>>>>       . Use system worker to perform fencing operation asynchronously.
>>>>       . Use nfs4_stid.sc_count to ensure layout stateid remains
>>>>         valid before starting the fencing operation, nfs4_stid.sc_count
>>>>         is released after fencing operation is complete.
>>>>       . Rework nfsd4_scsi_fence_client to:
>>>>            . wait until fencing to complete before exiting.
>>>>            . wait until fencing in progress to complete before
>>>>              checking the NFSD_MDS_PR_FENCED flag.
>>>>       . Remove lm_need_to_retry from lease_manager_operations.
>>>> v3:
>>>>       . correct locking requirement in locking.rst.
>>>>       . add max retry count to fencing operation.
>>>>       . add missing nfs4_put_stid in nfsd4_layout_fence_worker.
>>>>       . remove special-casing of FL_LAYOUT in lease_modify.
>>>>       . remove lease_want_dispose.
>>>>       . move lm_breaker_timedout call to time_out_leases.
>>>> v4:
>>>>       . only increment ls_fence_retry_cnt after successfully
>>>>         schedule new work in nfsd4_layout_lm_breaker_timedout.
>>>>
>>>> diff --git a/Documentation/filesystems/locking.rst
>>>> b/Documentation/filesystems/locking.rst
>>>> index 04c7691e50e0..a339491f02e4 100644
>>>> --- a/Documentation/filesystems/locking.rst
>>>> +++ b/Documentation/filesystems/locking.rst
>>>> @@ -403,6 +403,7 @@ prototypes::
>>>>        bool (*lm_breaker_owns_lease)(struct file_lock *);
>>>>            bool (*lm_lock_expirable)(struct file_lock *);
>>>>            void (*lm_expire_lock)(void);
>>>> +        void (*lm_breaker_timedout)(struct file_lease *);
>>>>
>>>>    locking rules:
>>>>
>>>> @@ -417,6 +418,7 @@ lm_breaker_owns_lease:    yes
>>>> no            no
>>>>    lm_lock_expirable    yes        no            no
>>>>    lm_expire_lock        no        no            yes
>>>>    lm_open_conflict    yes        no            no
>>>> +lm_breaker_timedout     yes             no                      no
>>>>    ======================    =============    =================
>>>> =========
>>>>
>>>>    buffer_head
>>>> diff --git a/fs/locks.c b/fs/locks.c
>>>> index 46f229f740c8..1b63aa704598 100644
>>>> --- a/fs/locks.c
>>>> +++ b/fs/locks.c
>>>> @@ -1524,6 +1524,7 @@ static void time_out_leases(struct inode *inode,
>>>> struct list_head *dispose)
>>>>    {
>>>>        struct file_lock_context *ctx = inode->i_flctx;
>>>>        struct file_lease *fl, *tmp;
>>>> +    bool remove = true;
>>>>
>>>>        lockdep_assert_held(&ctx->flc_lock);
>>>>
>>>> @@ -1531,8 +1532,13 @@ static void time_out_leases(struct inode *inode,
>>>> struct list_head *dispose)
>>>>            trace_time_out_leases(inode, fl);
>>>>            if (past_time(fl->fl_downgrade_time))
>>>>                lease_modify(fl, F_RDLCK, dispose);
>>>> -        if (past_time(fl->fl_break_time))
>>>> -            lease_modify(fl, F_UNLCK, dispose);
>>>> +
>>>> +        if (past_time(fl->fl_break_time)) {
>>>> +            if (fl->fl_lmops && fl->fl_lmops->lm_breaker_timedout)
>>>> +                remove = fl->fl_lmops->lm_breaker_timedout(fl);
>>>> +            if (remove)
>>>> +                lease_modify(fl, F_UNLCK, dispose);
>>>> +        }
>>>>        }
>>>>    }
>>>>
>>>> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
>>>> index 7ba9e2dd0875..69d3889df302 100644
>>>> --- a/fs/nfsd/blocklayout.c
>>>> +++ b/fs/nfsd/blocklayout.c
>>>> @@ -443,6 +443,14 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode,
>>>> struct svc_rqst *rqstp,
>>>>        return nfsd4_block_commit_blocks(inode, lcp, iomaps, nr_iomaps);
>>>>    }
>>>>
>>>> +/*
>>>> + * Perform the fence operation to prevent the client from accessing the
>>>> + * block device. If a fence operation is already in progress, wait for
>>>> + * it to complete before checking the NFSD_MDS_PR_FENCED flag. Once the
>>>> + * operation is complete, check the flag. If NFSD_MDS_PR_FENCED is set,
>>>> + * update the layout stateid by setting the ls_fenced flag to indicate
>>>> + * that the client has been fenced.
>>>> + */
>>>>    static void
>>>>    nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct
>>>> nfsd_file *file)
>>>>    {
>>>> @@ -450,31 +458,23 @@ nfsd4_scsi_fence_client(struct
>>>> nfs4_layout_stateid *ls, struct nfsd_file *file)
>>>>        struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb-
>>>>> s_bdev;
>>>>        int status;
>>>>
>>>> -    if (nfsd4_scsi_fence_set(clp, bdev->bd_dev))
>>>> +    mutex_lock(&clp->cl_fence_mutex);
>>>> +    if (nfsd4_scsi_fence_set(clp, bdev->bd_dev)) {
>>>> +        ls->ls_fenced = true;
>>>> +        mutex_unlock(&clp->cl_fence_mutex);
>>>> +        nfs4_put_stid(&ls->ls_stid);
>>>>            return;
>>>> +    }
>>>>
>>>>        status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev,
>>>> NFSD_MDS_PR_KEY,
>>>>                nfsd4_scsi_pr_key(clp),
>>>>                PR_EXCLUSIVE_ACCESS_REG_ONLY, true);
>>>> -    /*
>>>> -     * Reset to allow retry only when the command could not have
>>>> -     * reached the device. Negative status means a local error
>>>> -     * (e.g., -ENOMEM) prevented the command from being sent.
>>>> -     * PR_STS_PATH_FAILED, PR_STS_PATH_FAST_FAILED, and
>>>> -     * PR_STS_RETRY_PATH_FAILURE indicate transport path failures
>>>> -     * before device delivery.
>>>> -     *
>>>> -     * For all other errors, the command may have reached the device
>>>> -     * and the preempt may have succeeded. Avoid resetting, since
>>>> -     * retrying a successful preempt returns PR_STS_IOERR or
>>>> -     * PR_STS_RESERVATION_CONFLICT, which would cause an infinite
>>>> -     * retry loop.
>>>> -     */
>>>> -    if (status < 0 ||
>>>> -        status == PR_STS_PATH_FAILED ||
>>>> -        status == PR_STS_PATH_FAST_FAILED ||
>>>> -        status == PR_STS_RETRY_PATH_FAILURE)
>>>> +    if (status)
>>>>            nfsd4_scsi_fence_clear(clp, bdev->bd_dev);
>>>> +    else
>>>> +        ls->ls_fenced = true;
>>> The removed code distinguishes retryable errors (such as path failures)
>>> from permanent errors (PR_STS_IOERR, PR_STS_RESERVATION_CONFLICT), but
>>> the new code clears the fence on any error,
>> In v2 and v3 patch, I left the comment and the code distinguishes retryable
>> errors intact. And you commented this:
>>
>>> In nfsd4_scsi_fence_client(), when a device error occurs (e.g.,
>>> PR_STS_IOERR), ls->ls_fenced is set even though the client may
>>> still have storage access.
>> So I'm not sure how to treat permanent errors now. Please advise.
> The comment is important and explains some of the subtleties. I think
> that needs to be preserved even if we decide to set ls_fenced in every
> error case.
>
> If the correct behavior now is to leave ls_fenced clear in all error
> cases, then something in the patch needs to provide the rationale for
> making this code change and for helping us remember the design when it
> needs to be altered or fixed later.
>
> The rationale is different for permanent errors and temporary errors,
> I would think.

I restored the previous comment and treat PR_STS_IOERR and
PR_STS_RESERVATION_CONFLICT as non-error case. The rest of the errors,
temporarily and other errors; ENOMEM, as retryable error.

>
>
>>>    potentially causing infinite
>>> retry loops as warned in the removed comment.
>> Infinite loops can not happen due to the maximum retry count.
> Fine, but with the new retry escape clause, as mentioned below, the
> server and client can be left in opposite states, it looks like: One
> believes the fence succeeded, and one believes it still has full device
> access. Am I incorrect about that?

You're right, the server and client can be left in opposite states if
we still can not fence the client after so many retries.

If we want to be safe then pr_warn the admin then retry forever which
effectively prevents all other clients to access the conflict file until
it's manually resolved by the admin.

>
> This is the bane of every timeout-based scheme I know about, and why we
> have the "hard" mount option.
>
>
>>> Either the comment and error distinction should remain,
>> As mentioned above, I can put the comment and code that distinguishes
>> temporarily error codes back. Then what do we need to do for other
>> permanent errors; PR_STS_IOERR, PR_STS_RESERVATION_CONFLICT?
>>
>>>    or some rationale
>>> for removing the distinction between temporary and permanent errors
>>> should
>>> be added to the commit message.
>>>
>>>
>>>> +    mutex_unlock(&clp->cl_fence_mutex);
>>>> +    nfs4_put_stid(&ls->ls_stid);
>>>>
>>>>        trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
>>>>    }
>>>> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
>>>> index ad7af8cfcf1f..1c498f3cd059 100644
>>>> --- a/fs/nfsd/nfs4layouts.c
>>>> +++ b/fs/nfsd/nfs4layouts.c
>>>> @@ -222,6 +222,29 @@ nfsd4_layout_setlease(struct nfs4_layout_stateid
>>>> *ls)
>>>>        return 0;
>>>>    }
>>>>
>>>> +static void
>>>> +nfsd4_layout_fence_worker(struct work_struct *work)
>>>> +{
>>>> +    struct nfsd_file *nf;
>>>> +    struct delayed_work *dwork = to_delayed_work(work);
>>>> +    struct nfs4_layout_stateid *ls = container_of(dwork,
>>>> +            struct nfs4_layout_stateid, ls_fence_work);
>>>> +    u32 type;
>>>> +
>>>> +    rcu_read_lock();
>>>> +    nf = nfsd_file_get(ls->ls_file);
>>>> +    rcu_read_unlock();
>>>> +    if (!nf) {
>>>> +        nfs4_put_stid(&ls->ls_stid);
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    type = ls->ls_layout_type;
>>>> +    if (nfsd4_layout_ops[type]->fence_client)
>>>> +        nfsd4_layout_ops[type]->fence_client(ls, nf);
>>>> +    nfsd_file_put(nf);
>>>> +}
>>>> +
>>>>    static struct nfs4_layout_stateid *
>>>>    nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
>>>>            struct nfs4_stid *parent, u32 layout_type)
>>>> @@ -271,6 +294,10 @@ nfsd4_alloc_layout_stateid(struct
>>>> nfsd4_compound_state *cstate,
>>>>        list_add(&ls->ls_perfile, &fp->fi_lo_states);
>>>>        spin_unlock(&fp->fi_lock);
>>>>
>>>> +    INIT_DELAYED_WORK(&ls->ls_fence_work, nfsd4_layout_fence_worker);
>>>> +    ls->ls_fenced = false;
>>>> +    ls->ls_fence_retry_cnt = 0;
>>>> +
>>>>        trace_nfsd_layoutstate_alloc(&ls->ls_stid.sc_stateid);
>>>>        return ls;
>>>>    }
>>>> @@ -708,9 +735,10 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb,
>>>> struct rpc_task *task)
>>>>            rcu_read_unlock();
>>>>            if (fl) {
>>>>                ops = nfsd4_layout_ops[ls->ls_layout_type];
>>>> -            if (ops->fence_client)
>>>> +            if (ops->fence_client) {
>>>> +                refcount_inc(&ls->ls_stid.sc_count);
>>>>                    ops->fence_client(ls, fl);
>>>> -            else
>>>> +            } else
>>>>                    nfsd4_cb_layout_fail(ls, fl);
>>>>                nfsd_file_put(fl);
>>>>            }
>>>> @@ -747,11 +775,9 @@ static bool
>>>>    nfsd4_layout_lm_break(struct file_lease *fl)
>>>>    {
>>>>        /*
>>>> -     * We don't want the locks code to timeout the lease for us;
>>>> -     * we'll remove it ourself if a layout isn't returned
>>>> -     * in time:
>>>> +     * Enforce break lease timeout to prevent NFSD
>>>> +     * thread from hanging in __break_lease.
>>>>         */
>>>> -    fl->fl_break_time = 0;
>>>>        nfsd4_recall_file_layout(fl->c.flc_owner);
>>>>        return false;
>>>>    }
>>>> @@ -782,10 +808,51 @@ nfsd4_layout_lm_open_conflict(struct file *filp,
>>>> int arg)
>>>>        return 0;
>>>>    }
>>>>
>>>> +/**
>>>> + * nfsd4_layout_lm_breaker_timedout - The layout recall has timed out.
>>> Nit: Move the description of @fl here.
>> Fix in v5.
>>
>>>> + * If the layout type supports a fence operation, schedule a worker to
>>>> + * fence the client from accessing the block device.
>>>> + *
>>>> + * @fl: file to check
>>>> + *
>>>> + * Return true if the file lease should be disposed of by the caller;
>>>> + * otherwise, return false.
>>>> + */
>>>> +static bool
>>>> +nfsd4_layout_lm_breaker_timedout(struct file_lease *fl)
>>>> +{
>>>> +    struct nfs4_layout_stateid *ls = fl->c.flc_owner;
>>>> +    bool ret;
>>>> +
>>>> +    if (!nfsd4_layout_ops[ls->ls_layout_type]->fence_client)
>>>> +        return true;
>>>> +    if (ls->ls_fenced || ls->ls_fence_retry_cnt >= LO_MAX_FENCE_RETRY)
>>>> +        return true;
>>> Since these two variables are accessed while the fence mutex
>>> is held in other places, they need similar protection here
>>> to prevent races. You explained that the mutex cannot be
>>> taken here, so some other form of serialization will be
>>> needed to protect these fields.
>> I do not think we need protection here to access ls_fenced and
>> ls_fence_retry_cnt. For ls_fenced, it's a read operation from
>> nfsd4_layout_lm_breaker_timedout. The value is either true or
>> false, it does not matter. If it's true then the device was
>> fenced. If it's not true then nfsd4_layout_lm_breaker_timedout
>> will be called again from time_out_leases on next check.
> Fair enough for ls_fence_retry_cnt, but are you sure there isn't a
> TOCTOU issue here for ls_fenced ? Isn't there a race possible with
> the server receiving the client's callback while lm_breaker_timeout
> is running?

I will rework this logic to prevent race with LAYOUTRETURN and also
to allow nfsd4_layout_lm_breaker_timedout to release reference count
safely.

>
>
>> ls_fence_retry_cnt is incremented and checked only by
>> nfsd4_layout_lm_breaker_timedout.
> Then the kdoc comment could be clearer that only one copy of the
> callback is allowed to run concurrently. Something like "Caller
> serializes".
>
>
>>> If I'm reading this correctly, when the fence fails after all
>>> 5 retries, the client retains block device access but server
>>> believes recall succeeded ?
>> What should we do if the maximum retries is reached, perhaps a
>> warning message in the system log for the admin to take action?
> A warning doesn't seem like it would prevent data corruption. (I'm
> not against a warning, in and of itself... it just does not seem to
> me to be sufficient).
>
> I would really like this mechanism to be more data-safe. It needs to
> deal properly with network partitions and other problems. I don't have
> any magic answer yet, sorry!

I propose pr_warn the admin and retry forever for now until we can
find a better option. I expect this to be a very rare condition so
it should not effect most environments.

>
>
>>>> +
>>>> +    if (work_busy(&ls->ls_fence_work.work))
>>>> +        return false;
>>>> +    /* Schedule work to do the fence operation */
>>>> +    ret = mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, 0);
>>>> +    if (!ret) {
>>>> +        /*
>>>> +         * If there is no pending work, mod_delayed_work queues
>>>> +         * new task. While fencing is in progress, a reference
>>>> +         * count is added to the layout stateid to ensure its
>>>> +         * validity. This reference count is released once fencing
>>>> +         * has been completed.
>>>> +         */
>>>> +        refcount_inc(&ls->ls_stid.sc_count);
>>>> +        ++ls->ls_fence_retry_cnt;
>>>> +        return true;
>>>> +    }
>>> Incrementing after the mod_delayed_work() call is racy. Instead:
>>>
>>> refcount_inc(&ls->ls_stid.sc_count);
>>> ret = mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, 0);
>>> if (ret) {
>>>       refcount_dec(&ls->ls_stid.sc_count);
>>>       ....
>>> }
>> Yes, it's racy, I thought about this. But we can not just do a
>> refcount_dec here, we need to do nfs4_put_stid. But we can not
>> do nfs4_put_stid here since nfsd4_layout_lm_breaker_timedout runs
>> under the spin_lock flc_lock and nfs4_put_stid might causes the
>> flc_lock to be acquired again from generic_delete_lease if this
>> is the last reference count on stid.
>>
>> We might need to add the reference count when the file_lease is
>> inserted on the flc_list and decrement when it's removed from the
>> flc_list. I need to think about this more.
> If I may, why is flc_lock being held? That seems to be the root of
> several implementation problems.

Jeff probably has better answer, but my AFAIK time_out_leases hold
the spin lock flc_lock to prevent the flc_list from being corrupted
if the underlying code removing the file_lease by kernel_setlease
while it's working on the list.

>
>
>>>> +    return false;
>>>> +}
>>>> +
>>>>    static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
>>>>        .lm_break        = nfsd4_layout_lm_break,
>>>>        .lm_change        = nfsd4_layout_lm_change,
>>>>        .lm_open_conflict    = nfsd4_layout_lm_open_conflict,
>>>> +    .lm_breaker_timedout    = nfsd4_layout_lm_breaker_timedout,
>>>>    };
>>>>
>>>>    int
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index 583c13b5aaf3..a57fa3318362 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -2385,6 +2385,7 @@ static struct nfs4_client *alloc_client(struct
>>>> xdr_netobj name,
>>>>    #endif
>>>>    #ifdef CONFIG_NFSD_SCSILAYOUT
>>>>        xa_init(&clp->cl_dev_fences);
>>>> +    mutex_init(&clp->cl_fence_mutex);
>>>>    #endif
>>>>        INIT_LIST_HEAD(&clp->async_copies);
>>>>        spin_lock_init(&clp->async_lock);
>>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>>> index 713f55ef6554..57e54dfb406c 100644
>>>> --- a/fs/nfsd/state.h
>>>> +++ b/fs/nfsd/state.h
>>>> @@ -529,6 +529,7 @@ struct nfs4_client {
>>>>        time64_t        cl_ra_time;
>>>>    #ifdef CONFIG_NFSD_SCSILAYOUT
>>>>        struct xarray        cl_dev_fences;
>>>> +    struct mutex        cl_fence_mutex;
>>>>    #endif
>>>>    };
>>>>
>>>> @@ -738,8 +739,13 @@ struct nfs4_layout_stateid {
>>>>        stateid_t            ls_recall_sid;
>>>>        bool                ls_recalled;
>>>>        struct mutex            ls_mutex;
>>>> +    struct delayed_work        ls_fence_work;
>>> Still missing cancel_delayed_work_sync() when freeing the
>>> layout stateid.
>> I don't think the layout stateid can be freed while a fence
>> worker was scheduled due to the added reference count to the
>> stid.
> Then add a comment to that effect, or if possible, some kind of
> assertion, in nfsd4_free_layout_stateid().

Will do.

>
>
>>>> +    bool                ls_fenced;
>>>> +    int                ls_fence_retry_cnt;
>>>>    };
>>>>
>>>> +#define    LO_MAX_FENCE_RETRY        5
>>> The value of 5 needs some justification here in a comment.
>>> Actually, 5 might be too low, but I can't really tell.
>> At the minimal each retry happens after 1 sec, and it can be
>> more depending what entry is at the front of flc_list. So if
>> retry for 5 seconds (minimum) is too low then is 20 retries is
>> sufficient?
> As I said above: here's why we have the "hard" mount option for NFS. It
> might be impossible to choose a safe maximum retry count and still
> guarantee that the server and clients will eventually agree on the
> device reservation state. In that case we will need to consider some
> other mechanism for detecting and preventing infinite PR retry loops.
>
> Maybe the retry maximum could depend on the lease expiry time?

The problem with using client's lease as max retries is the client
might be healthy but the NFS server is having problem fencing the
block device. If we give up after max retries and mark the device
as fenced then there is possibility of data corruption if the
original client continue to access the block device.

I think to be on the safe side, we should retry forever while pr_warn
the admin to fix the problem.

>
>
> Just remember, I'm thinking about this and learning as I go along,
> just like you are. I know I'm possibly contradicting myself here.

I'm greatly appreciated your and Jeff's comments. We're working on
the same goal to build a reliable NFS server.

Thanks,
-Dai


