Return-Path: <linux-fsdevel+bounces-72608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C48CCFD492
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 11:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 241BE30492B7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 10:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84466324B17;
	Wed,  7 Jan 2026 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DQDa4r1k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uKqarqwN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D902E03E4;
	Wed,  7 Jan 2026 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767783093; cv=fail; b=tZxSBM+yoIesQbW4evpA2QWlNm3EVjwfHzGsT9Anm1d9biiFlwmoDOWMXSnpWwRxRnnkoWcXtVdwavc4HkutLrKvU9QTBi6imvvjOrck5ctRogqlVxaVwPRswQNUZjRCEdRMdnoIx3wsrgRaJnIg4o8CGkJpGjAm9GPXihqGt+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767783093; c=relaxed/simple;
	bh=Lp+3Cy2qgK/VMn2UUi34aHRinz9Fef8kWk/wRw2eTbc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sz8ST2xwQBif0kXni5xW7fHrIVmPiUflPMareDyHYAIG+iMFj7e1xX9B3rcktcS9j9eAYPdeD23dJnTD+351vHg4feiKKKqOj7vSzJAv9f5ppvcXwxwEenwn67ZOW483pbic/AzZcWdS9zj1QxjN9Ul4dzJT58tKeL5d9xNxsNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DQDa4r1k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uKqarqwN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 607AYmuq1512589;
	Wed, 7 Jan 2026 10:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=I9ZyvhgpDhKbHfSUpwc7rAO0BYU01TWBokS0S3C5tJ4=; b=
	DQDa4r1kzx6adfJONoPrrJkePLmsIfZtLTr0PvcHpxADcFXub1xNWcMfX/K75GMi
	axwhKUUbjm6+/TacdYHgqzuiWadUfBmD2do+7/HNyphl/ZNoGxzSAD9HJWugu25v
	fqM/ezSLDhEa6cL39D4BI9LOBXvgYOw+9TnjYYU6i//GKRxA4hSzsqY8Ivoeap6T
	d59Zrg+l4BDfJxvTU6sPGAtubua7Fb9A+IYrhmN2MFqyPQTIeN9Nq/JEPQno4IkG
	HmIdMrjZOPNegBjm869X3zGa0qtP5YLx+GBOrc8X6vu87YMXxpOx1Mzq4vWdJ8ss
	gWJPKOnRe12P3KVd9LLk0A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bhnuy00g6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 10:51:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 607AFjnN027437;
	Wed, 7 Jan 2026 10:51:20 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012014.outbound.protection.outlook.com [40.107.209.14])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besj9f7rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 10:51:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1TDnfKidq59mYfRJlndTUHkZ9YGUqUNKavYrqz++Gs1KQUChJqYaoDKrdwR7tbB1JhWX7pTh8Xkr0iB+EzYk1fWeDg/IdgFpy9thwJ8Od0zhIzXLK8CX+6t+yDrDRD8OzWm1czyJDqHbvZmaCw/K+Wz+JEsDPCgsF2QwJFpMt64EFW4JoQCYotfgEt4ExNLAgrveyQpLSLJcbAIttNAh3WBsc2q0uiHr0+pvdVdKe2gZQWBg07U7KmJjRollePd11b0E7LR4rCfiOLWb9/Kjalgqh+y/jPXFjg6pjcTGV7vKImOe3tjH+49BMx/yhDsjlMC1Ko6RSca98L56HOQdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9ZyvhgpDhKbHfSUpwc7rAO0BYU01TWBokS0S3C5tJ4=;
 b=a+4SOe9wcXzgOaCxFt5t0DKWxOiprzSNC8S1UBqOjiDT9cypniSEO/HYWTNsfJCpyR2kxY/QE0bt2zLs3DkGeIIsKFNRcJvTXL3um7umnjisgi6P/9J5M/WbGyZrGUfZYydFNv/LDgyiaTskztf5BIpTrkdt7mU98mfFGEPtHKy/YMzqyDQuFsi6Odjww1md8ibXJuE5XPU7SsOXTw5i+SiA4On622gfg8arI/W0kzm6ZNx1a8T9xJl8/b3WV78vvMpR67e2soXmOKjA3ZLsqKrMf1UgP8euHse0CU2rQ8EsHC5plrncv8gjWHatvWyompZPpPbmW2TO+A332DIe5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9ZyvhgpDhKbHfSUpwc7rAO0BYU01TWBokS0S3C5tJ4=;
 b=uKqarqwNL73oWe6u9OXaV6oDD1/T1MpjCZJK215ZdZoiaeEnm6ynZB4UX5VEX0KkL64XX9UDnZdMZm16BxdhTimGO82eVB9UA5FDx15tKimoTBSisJzqLDuCNa5/lYmIJFXmjmGdOFwz/hRb0+WfB+UqWu9/olQc3Xd1t8mw3v0=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by CY8PR10MB6635.namprd10.prod.outlook.com
 (2603:10b6:930:55::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 10:51:16 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%8]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 10:51:16 +0000
Message-ID: <704e5d2a-1b37-43c5-8ad6-bda47a4e7fc6@oracle.com>
Date: Wed, 7 Jan 2026 10:51:13 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write
 restrictions
To: Vitaliy Filippov <vitalifster@gmail.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
References: <20251224115312.27036-1-vitalifster@gmail.com>
 <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
 <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com>
 <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com>
 <CAPqjcqpPQMhTOd3hHTsZxKuLwZB-QJdHqOyac2vyZ+AeDYWC6g@mail.gmail.com>
 <6cd50989-2cae-4535-9581-63b6a297d183@oracle.com>
 <CAPqjcqo=A45mK01h+o3avOUaSSSX6g_y3FfvCFLRoO7YEwUddw@mail.gmail.com>
 <58a89dc4-1bc9-4b38-a8cc-d0097ee74b29@oracle.com>
 <CAPqjcqq+DFc4TwAPDZodZ61b5pRrt4i+moy3K1dkzGhH9r-2Rw@mail.gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAPqjcqq+DFc4TwAPDZodZ61b5pRrt4i+moy3K1dkzGhH9r-2Rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0566.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::16) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|CY8PR10MB6635:EE_
X-MS-Office365-Filtering-Correlation-Id: 10398b16-bab2-4822-6287-08de4ddaae85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UU13ODNGWTMyamV1K2l0UkRadWJ2b2lyQnVYamNPcjBZRzlyL0lha1BvT0lN?=
 =?utf-8?B?akd3OUsxdlZIalNpUHFOYUhCbUsvL290NVkyamNFam80K3FYSzZJNS9FWVpO?=
 =?utf-8?B?MW9PdUIxQ2xpcTR5R3B0dGxtbmY1aFkzTExrcEVIUE1ZaS9tSzAzY0RzN2o4?=
 =?utf-8?B?OWlhOEt0dWRhcStacjB6a3lMMVhEU3Q2bUZ1Z1kyYjMzVGh0L1FlZ1ExQ0ts?=
 =?utf-8?B?WGVXQStmQkIvSkRBVzBWUlZ2MUxBWWE0NE1CdU16cVZkS3Yvem9HQmkyMzZj?=
 =?utf-8?B?b0h5MnpRRUl3T0oxQTI5aExCZ0VVZ1RyZTdONEpCQ0pvSUZwbmduSWx0dnB2?=
 =?utf-8?B?MEc2TFhpWkt6OFRtRC8waExub1pxSllxeXNUNDl0MWxKQ0JVZi9HdnJnSTZM?=
 =?utf-8?B?aVRKWlBqdEtTb3FVanRUVDlxOVptWjFaamo5Wk5xT3lOMisrbzVHUFpod2Rk?=
 =?utf-8?B?SU9RQzl3OFhkbnlSeURXbVBnYkJrYVI3UUdKbDlwQTVZRWZ2K1Foa1VhbkFB?=
 =?utf-8?B?aHl4Y1pvb1FTUG5mT0NLb2dRRUF5cmxQaVhGMjgyNDJPaWg1ZVlzMENKZ3ZW?=
 =?utf-8?B?Um9qRndBWGw1b0J6L3VuN0xRSjFwZmZpTEZIazVjcTc1R2JDNVFUZXR1dXd2?=
 =?utf-8?B?dEhIQlpDcmJldXR2TlpBR3VBdG9LN2pCelhyWEd3YTl6VG1xZjdqWEt1MDd2?=
 =?utf-8?B?cmZ3TEQ5UThDRGFiUWlJaEdLcmk4ZHc1WXgzTFdNTVNya0lPUWRlaHFNV1pr?=
 =?utf-8?B?bGxqY3N5OE5Gdjk1WmQwVTNTbCtrdC9wMG1KVWZtMUhrY1dPNy80b3EwU3dZ?=
 =?utf-8?B?cnF1eGJJbm9sUDhmQjRaRlBjaGtGTUhmanV0bUtGb0pmQmFPMS9adW5BZXQ4?=
 =?utf-8?B?QlFGbEQ5QTloY0JEMTdqZ2l4MHE5TU0rQ2RPa0ordUpudXViVnZQODRQOUVE?=
 =?utf-8?B?TGJRWVI5ZEF0eGZKam9BVXJmVkw0cnNnVWcybTN6REx1NkRJeklkOWh6dVJh?=
 =?utf-8?B?czY1dnd1eTdHTFNneEphUFh6NmhMbWZYQ0Zwam9SMDRITVcySWREM1Y3cVhm?=
 =?utf-8?B?UmdOd0xPeHlBSFdjcHQzc0FROVVTZE8xcmVLZVZsdlE3THJvTmlzamlKZHJV?=
 =?utf-8?B?N3c4NnBrcWZqa2pqc1VVTm1obEFGb2c3NXA1dHlLa2R6NmdhelhvMkpXTk5v?=
 =?utf-8?B?K1NnbjdhaUYvRFVVV3VEZlpFb3Z5QWNNajl0czFMMjRIZHdhMWlzMnVtc2R5?=
 =?utf-8?B?bFFtNGNtbmpTa2tzTi9SWFZHWU1jcDhwa3dpRnJ2UW01ZkFvL0w4Z05XOXFo?=
 =?utf-8?B?ZngxOXN5R255Q3lISEg4Z09IM0UvYVE5SFlsVnZwaWE1UWNHNXRoS3NOMWw5?=
 =?utf-8?B?NitHRXo3dllVVGs2dlFVQWlzQ1ZQTkV5dEkzdElSNWVRU0FmV0VmOVpVUC94?=
 =?utf-8?B?RnVLQ0wzWnE1UFhyMC9vOU40TzZTT2M3K0hXc3NFaHNUVFdGTmFoTC9vak5w?=
 =?utf-8?B?cmFMRU54cVA2dXZkL3A4eTVzYzBmbGpnUHNsQmJXNFNyYTYwaDlOMmxnTHkx?=
 =?utf-8?B?dEhPNmJSanc2S0QxbVN3ajVscHNoRHUrZ1d1RnNtQ3VUeE9DUTl5OWFRQjZ1?=
 =?utf-8?B?NTVIRmdCdU5TY1dPNnAxSXZia3QvVnp2ekRKWGU1ZGdwVHBUQTZaQno5VlNp?=
 =?utf-8?B?M1RqYUdxRHE2ZG8xVUNGb1hTZ3pwTjQ4Zm01eUJxeWxDYW5kUXhUQ1kwU2Fz?=
 =?utf-8?B?clJMT2lVVE5EMk5NaDFacy9WUG5pTEF0TlB2bGFIdmUxdG5FWDVlc0VTTW5J?=
 =?utf-8?B?YmxtT3grQ3hJVHd0Ry9xR21JWnJZQ2luVWVRYVd5cUw4dUZLaWJoeWgyeW00?=
 =?utf-8?B?SmVxUG82dytScFZ6UjlNb2VkZmpNYk5sU2Y3Y1RIVUdnanU4eUNRKzQrSHov?=
 =?utf-8?Q?Ge0iBA9cnOYOOUoo6W3DPOOIxGW3+Xn+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTh2TTVBWnAyMmpXMEcwNjVyZWZNQkdtV2c0dWdqakU4OXkyMElNcUtvUEVa?=
 =?utf-8?B?cEdWaEdQQy94eWFkeko1ZCtUclZEZDU1TzVFcWdNdnU4QlUzYllid2l5Uk9H?=
 =?utf-8?B?Q1VyZkpmb3lPcTlmeTB2Z0R1Uk03anNiamx5a2ZOcEhjVTA3SWEwckFjcjZC?=
 =?utf-8?B?VkJoUWFoc1F2Q3kwbEo0YXYwWVd4Z3ZQR0ZxdGZvTWhMQ2g5cHZFK1RjZUl6?=
 =?utf-8?B?VlZQZitXYTMzYlRaM3BNajUxek9haWt4dFJrVmd2NCttVTF6d0dzeHlKeVM2?=
 =?utf-8?B?NG1Id0hvbDg4dFIyeHlsb3U4eCtuNllKSWptdWNCK255MG5BWlZOelJFTkhJ?=
 =?utf-8?B?aGZsYWJtSzJKSUF1UlNCOHZiSGNVYzhwRDE1Sy9hRW9Lbm5kUzBGZFNrcUdT?=
 =?utf-8?B?TEkxWW4wZ2JQbkRsYlNleWovanU2OVhmNm1CbERsZkFCTGJhY0hnMXkrRlVo?=
 =?utf-8?B?dlZ6anE1QktubFJZTldYTlZkUW45OFJLQzNxcWR2T2JrOXN2bDJuemE0Ly9O?=
 =?utf-8?B?ZEFIUGxpamxVNW5SaDVaYUZ6RWZ2VS9OVVlYanR6S3B5ejVzV1M2OEJzdzM4?=
 =?utf-8?B?NDV0bDdHQ0N5NmRua1lFV2FqT1Z5WkN1N1c1RUhWL2hrUHFWZGsrMHhhSXVM?=
 =?utf-8?B?ZkVqTUdJVFBCSWh4LyszUU9JYVorS1Jzd2tDbEFlSWdzL1UrQ2Nzd21QZW54?=
 =?utf-8?B?eTNINDZoL05DYkRJKzNzUURtQXZDMG9YUzFka200YytFeHNHMnRBeUJ1ODhJ?=
 =?utf-8?B?VTEzYWdES3BldmdtOU9oZHM3SGk0eXJJTUgzcXNaUGZvalY2YVRQbENhcjJL?=
 =?utf-8?B?T0lLOVFtbThmRURwTTFoWUVjNlNVZTZabVE0SzdoZjltb1RvUkpFQjNPeWNK?=
 =?utf-8?B?cjYxZG5KV1RZb3NXeVcvUEphL2Y2Zk9LdkdlTDBrVS91amI5TDF2eGI2QzIy?=
 =?utf-8?B?djNuUkJqQ3dYSVpqY3F6a0VOSlhKTjhNN2IrYTdQc1pWQVh1K0RGdmFDckta?=
 =?utf-8?B?OWg2bTN0WkZWalZtR3c5WEJuUCt5dnpnTURFSlgzNDRGSXNzZm94eXFQNkxL?=
 =?utf-8?B?eDV5U29WdDZLdVhGczhLbkFZekZ2NVBEK0Q2T2w5Mm5FdHVlSkcvL2hYWWF5?=
 =?utf-8?B?Z3hyM2FYZFBscFppdVR2K29zTVRxUUZRdDdUb0JvbXQ0NXBLaU9QZ1ZwRDhB?=
 =?utf-8?B?TXlVSktVM3NPQ3N1S0o2M3JiV2dnZnlHdEtpeGRmcmVkS0ltRFE2YnYvUld4?=
 =?utf-8?B?SzFneW9Pak5EVkVvVlBjbW9ObzJrRDIzeWg3TjNGQ25rYmZNaVhuUStUaVd4?=
 =?utf-8?B?ZGtVUC9taUEwWmM4YzNaL1ZUVmZ6a2RIZnlKVXVRSjZCY251NHhxcmNSck9a?=
 =?utf-8?B?MXlpSW5xK0g0LzkyK0dwaWZHZFRKbGhubUwxZ2NBc0pKWDhlN3J2dUtRbTMz?=
 =?utf-8?B?Q05hZUVoL2hTTTQxUnVld1Q5ZUdscVdaSEtqZXI3R2pZMmlGbTdIZUJKZlp3?=
 =?utf-8?B?S3M3Z0RqK3NacmIraW9xRklwUWVWa281cjNTV01WRG9GcUhQNktmWkQ5dzlV?=
 =?utf-8?B?MDBvQSs0V2FBZHhXRkVhK2hGY2tVOVN0bUgyS1RzVC9KUDl5YVVCclNQTEhi?=
 =?utf-8?B?WnlnYXc3VkliRXM5NGlLNTJPOEhVSHJxaCt1a1JEOXZ1dWl2RlFueGxWb3or?=
 =?utf-8?B?elJHcyt4eEs1TWxKOW1HcFlYWmp2cUFnNDQya1p3d0hPVjFkMGhHblJPS3d6?=
 =?utf-8?B?WXl6V3JkVm9ScVFOUStsYS9oVmVsTllIbzMzS3lDR0pwbFhjNlFYdFpKVkI5?=
 =?utf-8?B?NW1xUVUvNUtQYnZLWUVpVi9uV3ZjT3pMWmFscHRJTDMrcnV3SG5MOVdoVFRX?=
 =?utf-8?B?YWxFVE14K25ST0c2V1c2VlY3OFZHVTJTNW9JMnNBZTcwZVkxaVUxWVZ2ckw5?=
 =?utf-8?B?M2xQMHI1a0ZWalYrclVsRWdlZXZZVWNWamRBMXdxb0RVQ2Z3NVZQcUEzdDd2?=
 =?utf-8?B?TUFjMWlQSXNuUVYwcW82NUpqOGRzN2k4YWlQc1dneEpQQS95dEZWVUZiMS91?=
 =?utf-8?B?bHRzd21vM3Jqd241V1VObEpLc2N5WUhISml3VGp1bGsvS2pURVZxQ2lPQnBB?=
 =?utf-8?B?Wk5mT0FjSmdYd0t0M2Q4NU11UE1RYjFXbDZzVlRoMElVREZlRXUzRXlvaUR5?=
 =?utf-8?B?VVptMGZGclFoemdZK2RSUC9kZnM0RWN1bE8zQjhxazRweDJaYjVqSW9tTTFu?=
 =?utf-8?B?V3R3K2xLMUV3YW00cktWYjZFSDd1R2YwRmxhQTV1SUQyUDkyMDJ6aER1UGxp?=
 =?utf-8?B?V3lVTmRPMnBFRmtuTlZOUGxYZ0loSUdSRlpUcmVXRzFydlo1TXNIdXhITzJw?=
 =?utf-8?Q?IN43M4u1vlGFgTkE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3kgOCO8PLPIXFB98TpbwL+eua+Ojk5WQSVtKDFwhQZWU7/sPFBZwbP1orSi4dPqOI0Hd0p/SaI0SgwUB4xg9/s1nWomKHH09XLKkvAK0pVh5znL5pkP89Bv0rLiq5p0xwg7kvVskEJb/dWLDQnh2RcLTKsbd9JWjIygn5uBveXO8+umJGe138Sb2oEFOmzL8ywwoIp4fONJgRMQkrh2vUjVxzIJCST/57fo1l7PyjUdkfDYbH6Kg4sHyh5gLwPmkw267UyjE0FucNlmyipNbgpCcxmgBU5jXHwlmwiH6hZlgpnSrg70/VMkbxP+5Fzg7jKmHeTXgpwHO960FfmpPYlIJ+2nWjZkcT5XdgKAdh8go+cCJ4SLuLoRVPpAniEIdhKdAIECf78QXxtc7Sc1cMUiKK/S+7Mj2KpIaLNInnHDIGGXPINuZgfjtOJDGk0N+dCg19afHZwU1CUKR6Ynt8qC/LvrtruTIDpFZKXHrzldmSq4tlGTcYw0b5LsQfDZ9YAujuKtqKoDBk3VVmztawr/45IyZl1cF+kvk29Mag0fNQiL0Nnw9Cxa5DkKIqh1KIMIYPjxOTnEr5wy6kTSY233se8xdGcY/Po5APHOvi8I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10398b16-bab2-4822-6287-08de4ddaae85
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 10:51:16.1363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tiG2NPivjAb07QWcuxq/bX8NjU1hlKblAI+eQAyT2oFy2+rgp9y3Crgg1MYdH8ZsgEJvgohFHUv42POvGJFA8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6635
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601070088
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA4OCBTYWx0ZWRfX6RQH6kXXXv1r
 jp6BAW4371qYuxNeyYz55iUGEniJhxtQAAWVGqugaAt8eVMnT5JT0RypsQbWBTDalWO3/lV2ayp
 V58GhDzRePewDWNpu17RjkT+vZ6kadUyREXZJGSMh6Rc+eyTom3MLaHyjeGzuIzxqzKBCO75Zq8
 VZJOqLllsbbf6oLjEOqQzpMg7BV50c8PTjHQubhpS6I8R1VzMNVN9vR+yOcpjlQQ0BhQP1PuWDA
 ghXrL9/2LL4hG+KrWWdexlcAA6ZB4mvY0GPdjYOgQue+HzkdjjQt3vUhB7wE0UrrJAyQLhoK761
 y4xggSPJJ14Gay+iFT61upJjy9ixW73DFnA35gKcM3xQgEWmqgc20mBIJS3O9QF4475GX0u+c7s
 lX8BZRXCMk/+KD/ouq/n1WhmutO8ZCx/yDkP/hCfQjaVQkW3ZvXu9svuiyNE2gFxjeNxnPXSpBU
 bI4rvyXdjjHPWD4pO1g==
X-Proofpoint-GUID: auKmM_-U17Gev1VO5ssoe7HciSmtrAA5
X-Proofpoint-ORIG-GUID: auKmM_-U17Gev1VO5ssoe7HciSmtrAA5
X-Authority-Analysis: v=2.4 cv=PJUCOPqC c=1 sm=1 tr=0 ts=695e3aa8 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ORhbs3clemUywgjE-IAA:9 a=QEXdDO2ut3YA:10

On 06/01/2026 13:08, Vitaliy Filippov wrote:
>> For ext4, the maximum atomic write size is limited to the bigalloc
>> cluster size. Disk blocks are allocated to this cluster size granularity
>> and alignment. As such, a properly aligned atomic write <= cluster size
>> can never span discontiguous disk blocks.
> 
> Ok, thank you for the explanation.
> 
> But it seems that it's an internal implementation detail of ext4,
> right?

I think that it is fair to say that alignment constraints of atomic 
write HW should mean specific alignment and granularity of FS disk blocks.

> So this check should be done inside ext4 code. And in fact I
> suspect it's actually already done there because generic checks which
> I suggest to remove can't take ext4 cluster size into account, so at
> least some atomic write validation is already done inside ext4. The
> only thing that's left is to move the write alignment check there too.
> 
> Another thing that suggests that it's an internal implementation
> detail is that a CoW filesystem like ZFS or btrfs can probably provide
> atomic write guarantees for unaligned writes too, and probably even
> without hardware atomic write support.

Yes, xfs already does this.

> 
> Can my change be limited to raw block devices then? 

The atomic write API is based on:
a. doing statx to find atomic write min and max limits.
b. issuing a write with RWF_ATOMIC means that the write should be 
naturally aligned and fit within the size limits.

That is the same for both raw block devices and regular FS files. And 
any atomic write boundary is not part of the API.

>Thanks to your
> explanation now I understand the motivation for these checks with
> ext4, but they still make no sense for the raw NVMe disk.
> 
> I mean, can you approve my change if I rework it to only lift 2^N and
> alignment checks for raw block devices and not for file systems? For
> example if I move these checks directly to the related ext4 and xfs
> code? I think it's the right place to do them.

What is the actual usecase you are trying to solve? You mentioned "avoid 
journaling", which does not explain what you want to achieve.

You could arrange your data so that it suits the rules.



