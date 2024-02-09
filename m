Return-Path: <linux-fsdevel+bounces-10883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B6184F234
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D17F28305A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 09:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339C36773D;
	Fri,  9 Feb 2024 09:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ENf8T6o5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yz5Rj/9J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFD666B55;
	Fri,  9 Feb 2024 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707470565; cv=fail; b=XPQIYOJmAAJY0a2F3OUehqC84uoGMySezUa8p2cKqOq8EdtCXUjpkohYpSUe6rfxe2XR3AkThkWs7OgvXxDNERpaYqh37ScGE+YusdLJmX8Y4AOiBQSuAmDKTJB3Fg/wWW9D4xiumvWBYc5sNIwj5fhjqushtQ/aEwJkNLRUfvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707470565; c=relaxed/simple;
	bh=P0vfz/9Rd7XEvoY0TxBWDIVYcamHs6/RkITv5JzD3xo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Uc8WxHWaFZxkJq33cE60rv624MY5fLMb1I3tmLVam85PZ+a43eh9d3yp3ruqAlxP4RjBbNzxN8JXM35aOnDgtSIuuS5yhAXWrt11sOoaHZsch+hNdwgNtnb5ERkM0r2theUVIAhtRM66egU4kc7aUUxK/Ts0oaw5auVMxzqLINE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ENf8T6o5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yz5Rj/9J; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4194wgr1031876;
	Fri, 9 Feb 2024 09:22:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=s4LO1UxsgVmusYPHuz/g1LH5y289cqlm0iUlBY4KFfo=;
 b=ENf8T6o5Hg525nqqZNO07g3phzT+0VadfJELIB6kOzaBP8r8riJwtJJGU7SSdhu76Zdc
 ZIZzoD57Owhyp08H6UTmTQdXQUbJg/ynOz4Hb/ZJSJODJWC9YnOfSpzs7N61VShUgWQL
 WnWYJwC2A/IWG0vFKmJsUHCc0/qRC5iBaegGwkW1AQDhohyAieY4CxbB1g05lkCzqPua
 wNnZKhZTeSbPJjReu5L2UJuVj4c7lvwTPG6EqqRk5ILzRQ2Isk9mdaxNmGBzlufOMgWo
 2cEfNyCs+vO7FMcufrxLFxTnafhNHuoPfY11akJE/6um8XZ7/lTUrVrmyYSS6TXEhXBI Vw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dhdq1t5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 09:22:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41993cjf039467;
	Fri, 9 Feb 2024 09:22:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxbmthn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 09:22:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZsWHnrUJnR7aWFVxymu7AHCEBxrNcoYp8mHmB4p3xDhgeoURqbui57lM1oTh0hDl3s34mzsIuGc5eTc+SrlHjmp9DsrgLl+bD+A+z8fJptUGcIIv65WJRo6x7ubzRCtYR8t1B8j0lhPPI6avDSLLVNpPbNKMDT5Z7451PKDNm4Dhp36cHVrxpnpCaPRo90v/dCtL+XQE2jrz3jTST1QiwRIiOY8rfTT76sJTn6etlN3sUdnPS9BpkCnpLN61mfh2icnuTNKFPokDUM2mvlFoBm5uKt50bol4+S+R/0fY5KUscY/JUSuQ1AAFgVztuQg8cHgBziaZylhyGEP5jrA5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4LO1UxsgVmusYPHuz/g1LH5y289cqlm0iUlBY4KFfo=;
 b=a72zb0Y/2cDcQfQxGHioVRZpR/8DaQXlQqpT5/RqMEklGwoVRqGi3c2uRKPUZtYklCNIxhnmF1HneSE1K9KFzvD6KMJiIdRfpHqO2u1uszzx65lQ0wpywvJ53edp3m6zgVYLcK3CFfn1BESLzUBwTmBbNNU0k6oSEOYiI3q2PUwShQxNe9es5gzjKnCRnzQ+t5gDmrpoe07JUqgZj0z3YKFoauXgswah8BHU8aEnv/fFrNImHyEqyicWZYxy6QA0RT3PqR/kBPBsWWm1YV2XtXIR3GopDVrF0Y+k7ueKt+3h3CVCRrWJAezllkiYhnWfCDVluzmrET0Jv4NYByssOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4LO1UxsgVmusYPHuz/g1LH5y289cqlm0iUlBY4KFfo=;
 b=yz5Rj/9J9XiZnWA3+jjS1zSuNMJUDt8Hw9TOCfM3Rd0nCzFC3F8hclR6jTilhAGmaH6gh0qsUOPuCgHkv0etwGhwRKFixi9tj/p5EFhq67F1kufYbfLpHmmu+Cx5bvUYNNLnOuTJ0dVpGB4ZHnbbmzdMN8eCCiVLfCvlDn5TV/I=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5926.namprd10.prod.outlook.com (2603:10b6:8:86::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Fri, 9 Feb
 2024 09:22:24 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 09:22:24 +0000
Message-ID: <66e0b76e-c1aa-4e65-9372-07a1fccaeb6b@oracle.com>
Date: Fri, 9 Feb 2024 09:22:20 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] block atomic writes for XFS
Content-Language: en-US
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: hch@lst.de, djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <ZcXQ879zXGFOfDaL@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZcXQ879zXGFOfDaL@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0181.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: fa5fc83d-3288-4474-55bd-08dc2950a059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0FrLJGLfVPZpLnQHVtSTgg4Q1N1S25ZMVF9ULu9572Am5Dtvs7MSlyuRyqO+ZgHkJzkzjPOo5xgQNFOhgvYvhUYZwGt121zRs52E+O8nSJKONVCVrJHtbBJoi9dd7pckWlzvuhb8IHq5svhNK7MfCABSqwa1rDkU9hNnIpxVl+r1x8A7yZcePMHH5TF79Pe3+W11oPipLTvXNLUfpFceqcwI1UV7MTnnJgUz8HhE8fc7X/WbPpM1domeVFKZhHG1EEd/iOg3REwWuKH2S1SpGu6zp5LE6rqr+4eYHst/VtQG0OfIY+HXTV2MzAMnZN/TU1mGJOnQMrPLxoG8SAkUotxLKhqBVFHsklGdknMuR7Xoi43SIUcDKwAJdEEm8LtIJtmqeqs30Zkb+FEI4Hbyjo/YDEE91Qngf/1k/vDvI2hANeYyEGH4wP6OIjho+kHPCVpDCsR0hxWYnaFeR2SMabLoBP++vWF/8cbc/DO+MRBpAYnewaXDwX9eJXKCD6i9m6mI6mWZ3qUlgZ55sw+DKz12lb2aB+egCoMpw++OVSWrUJvwbrxqR+KBkAHG5NNq
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(36916002)(6666004)(31686004)(2906002)(5660300002)(7416002)(316002)(41300700001)(66946007)(66556008)(66476007)(6486002)(53546011)(6512007)(478600001)(6506007)(8676002)(4326008)(8936002)(6916009)(83380400001)(2616005)(86362001)(38100700002)(31696002)(36756003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TEZUd2Q3NHlJanBtaG9kd201OUxhMEo1Qmo4eXNqQVJiUnBxR0JKVUlkTzNH?=
 =?utf-8?B?TUdIeEFzOGpyYlhsT3ltVTJEeHduYkdpbEN6am9NQlN4TjlzcUtuNklmNldF?=
 =?utf-8?B?cnhFL0lOZzk1dTgwb0ZUTDVyZ2tldmhhZG0ybXBFQlkrQVo5RE1RWGFxa0pM?=
 =?utf-8?B?R3kzS0Z6UUZJYUNJdy9lT3NpU3VkUmNGVVE4S3RzY09BZzNFSjZJMlZDc1l4?=
 =?utf-8?B?T3drcGNrWEJia21BYUozY2pYVE85S1EwRWlIY0d1OE1rOEZXRW11THpvU1RG?=
 =?utf-8?B?SHdEbldWcFkyZkpRcGcraFhBLzVSTWsxUDBUQ2RnNnlMMUhvUzJ3eSt2NGhD?=
 =?utf-8?B?M0Q4OFN4bXAvU0gzbnZSK0RzWTJITEZjc0k1b1B3dldCQjBSK0ZabHpmaVBm?=
 =?utf-8?B?OHJJSUIyMDJEOUNzTFlPL3N0dW9Pa2VhZGw4dlQ2Ui9ubWU5dXhSaUo4eDRG?=
 =?utf-8?B?a0lJTVU3Z0Z1Mzk0UmVKQy8ycmN2YXdiRkZLTG4rOEJpOUFwV2p2NDBTYjla?=
 =?utf-8?B?WTRiaHpuWDJnbHFoSktJUWZ6SGdrQWFic3BFYVpLa29OSHUyUEJIL0pLQ2FC?=
 =?utf-8?B?WTQyM3NCc3hNSXZnYXdxWDZSckYrR0hiNnJuUUxkTXVvaGNBS2ZiR280emVu?=
 =?utf-8?B?N0xIbWFRYVFZSDdZTjRnOHNDRnpsejgwOHZOdmhxMEMraCt4ekl4V0xKVzNG?=
 =?utf-8?B?WXAxQldXekd2Y0E0b2lGa0k5VU84RFN0WFc0d2Iwa09Jczg2em1QdDMxcDNJ?=
 =?utf-8?B?RlFPQUx6b0dhNWU5dlV0Zis2MXNMUmFVcjh0RWFvM2ZRWnpVQmE2cDVGM1Ar?=
 =?utf-8?B?QmVqOXFZa1VDd0NFc0ZLenhBMldIU3RQUlJ6VUxKZ1pCdzc5aXFGc2pHOWVk?=
 =?utf-8?B?RVE5ZXQvK3ZEVFdjYkF1bTIwWGhjM1R3VzVaSE42SUxmL1F3a0kxYnlUVWdL?=
 =?utf-8?B?SllzaDkxT2o0YVFNNXVndWp4SlF0N3IwZ1QvSHpEeEtmQTBoVXVmeEVJN0cw?=
 =?utf-8?B?cnFGUFFZZG1uZjU1d29sWFlwbkU3QzZZS01zUVE4djh6L2RGQmY4dTFLUG1W?=
 =?utf-8?B?QzlCR3pmNVBMeDQ4QkRUUFJaVHpYZUFrRmc2cWRpT1J5WERDU20rU1FZYlNy?=
 =?utf-8?B?Y0hzWE95T1BsVk9yYWRHSG1wMmt5S0dRU2NaMHJMVldIVDAvZXJoUTRWMXd2?=
 =?utf-8?B?Z05RSm13ajREY3AyYVJkYzJVeWpoaGlNL0Q3SmV1LzdqcTU4OHNpUnJZaVdl?=
 =?utf-8?B?K3k1U0FCUnZMWE9TOVJ6elF6Sm5uWnpEd3lOUFM0bFZtbXBvWmhFbjhOM01X?=
 =?utf-8?B?Sk11cllKcEVuWkRqajRlZ1loYkE5QitSSCtlaFF4NkhPbG9teGZlUDhwaHlU?=
 =?utf-8?B?SnNrZGN6aVhqakdFSGRSZDA4M1A3WDhuVXI3TzFOWnpBNjJKYWlnbHUvNzVj?=
 =?utf-8?B?d1pISjQ3aldrNGNvTDNraWMrU3VtSDI1OXdDQXJNS0FqcklkT0lDNnp1ZHNR?=
 =?utf-8?B?MTQ5TVlDUzQvYlFiNm5keFIzZU5PcXV6RUtUOCt0REl5NFpHckkyVHA3cVlJ?=
 =?utf-8?B?Z1pkdUVUZWxrSmRQaXFPUGtyMmZFci9UV01MdHE2N2lFQklYK0FtNmJGazZV?=
 =?utf-8?B?aDZ2eHZRbm1WNTB0U0F4WVdNdklpS1I0dU1HWTVQVkJnNENoVzJGbjlSd2hp?=
 =?utf-8?B?OGtSUUVXU2dIdjE5akFtTWZPaWhVTWk1U1NyWXB3NGxmd2YzOThVaUluOVp1?=
 =?utf-8?B?OGg4ZXN2WmJBZUl1WHZ4TXR6ZjlCa2Q2Q1ozREFpaldBanZYRVV5bXhLdTNL?=
 =?utf-8?B?TDNyMTJzYS9KdDJRV054ZUViMEpTUURsbFlYNGJ2SWRVZnpCSVVxL0xTTWtL?=
 =?utf-8?B?N1BSRGkrMEhEeVdaOU5uSmhRcFUvbUt0WVJGLzIxM25MQUVVaDhMZUxURnlR?=
 =?utf-8?B?VHpMQi9vN2FJL1hYOVFCUC9kcVo0bnprZHhBWW1PQngvUzYxaFlvMWRMalhn?=
 =?utf-8?B?aU14YUlCYldyTmtBNExKbmxnb1RQNU9oSXlvRHk1VkZRRDdHblpqem5IamZJ?=
 =?utf-8?B?akN3VWswQ2RZL1JVSnNqbngremdqNWpHM3RPdWFpZmdzeUxsc0J5aFZiSis4?=
 =?utf-8?B?VDNOcVlraG5aanRNZG9aY2RXRUpUaDFqZlNJd1NZV21jY0poQWhaWmJFTWc0?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	iFqKX/4DIkO3rkIL1pMcnOaBlt8mWblYEcZE3ldYFwpILnhH7txEYr+76F/YjKY5IeLHWScYfjX6f3EIqLbrpa5H7OwxSqQj4b9i9QuPUyzJlYujwipvm76ght0sM85LEibt+0MrKjMWkSrQlZzP5vmbUT4/B5HbDa4baTLzAQqtuGsZuDoMx7SLAX/zlGC8sR04kMKaLrEmQn2H+TPMKWXLAf6NtDQarDBQJHNQr1svXukMFgWnkSgZqknNv6XHNIFxo+4D7GG0cbUN3o2yEImV+WzuVdYKdN5S93Fhh4hKPCyfbNtoqXY1moZQPhn4zgLvolesjVQxZb/QVWkbkvksFoa7SNA2aYGuPFjRomh1ajbNec7p8LclyBbWj+uIQkkTpRZEeCWuqqMIcxDLuPT0gGc3WLp2rH/ndYw8z0gj1bqEBQsrUYJGGniUIW5Y/mbugr02xPvRfrzr2jI/NkMOLL/4HyAbXI64IbJz3JgppQJnqSvKr3eytNFiLy0LszxGUbbHB13utKsxknQQtPXNLwKdnmva06qqt/QNiLvGZVJu11eU5SjAwkH7YdpKpEm8RK0rIfbzAhxT0Dr9mqOcN/wbfMS4le2y1m8J9kQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5fc83d-3288-4474-55bd-08dc2950a059
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 09:22:24.6399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4Y9Y+fHC16BJGeEjZdj2IAhM0yUBsIaNXAzRA4wALYYI/J657q+rJbYFi3LNDTdzBWytKoKqNzGVSZqvoDrQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5926
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_06,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402090066
X-Proofpoint-GUID: KPVbK_al2N2QWZSl1FthBpqJDA0RYRBe
X-Proofpoint-ORIG-GUID: KPVbK_al2N2QWZSl1FthBpqJDA0RYRBe

On 09/02/2024 07:14, Ojaswin Mujoo wrote:
> On Wed, Jan 24, 2024 at 02:26:39PM +0000, John Garry wrote:
>> This series expands atomic write support to filesystems, specifically
>> XFS. Since XFS rtvol supports extent alignment already, support will
>> initially be added there. When XFS forcealign feature is merged, then we
>> can similarly support atomic writes for a non-rtvol filesystem.
> 
> Hi John,
> 
> Along with rtvol check, we can also have a simple check to see if the
> FS blocksize itself is big enough to satisfy the atomic requirements.
> For eg on machines with 64K page, we can have say 16k or 64k block sizes
> which should be able to provide required allocation behavior for atomic
> writes. In such cases we don't need rtvol.
>
I suppose we could do, but I would rather just concentrate on rtvol 
support initially, and there we do report atomic write unit min = FS 
block size (even if rt extsize is unset).

In addition, I plan to initially just support atomic write unit min = FS 
block size (for both rtvol and !rtvol).

Thanks,
John

