Return-Path: <linux-fsdevel+bounces-6487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584698187B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 13:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF35A1F246E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 12:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6F218AE9;
	Tue, 19 Dec 2023 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V8HagzeD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I/B+mFcF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155C2182BD;
	Tue, 19 Dec 2023 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ9x62L019470;
	Tue, 19 Dec 2023 12:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=m0AjNTLHpbAxWdbLfA6ZTKTFLeJPVX2P1ECzSEZVcvw=;
 b=V8HagzeD33KTKaO+lKkld4FpSbAKlKdzMRPvrfH4oS0u7i5N/9VAK0fGQVqD0NmMQZIC
 QDqs+cPem/yV0fod6kvvf6DIZsehcxRq4XkhnOUHwweS+wdNSD60kCjie7eEUU9DSzPN
 4RTybR2yrlZfQ/om49lBVpGdmaYQuTvpHSCmBuImsfPDhNcQ8CQrGhq9V4Yb15djoK3L
 AIlzyOnwdk5ctV/qCH6oOOgEg1eMWCnyTHOEw+BcJ9PJZtM2j6FGAdQw0Ynyh6Qdeb99
 n6CSunoknuT86QLG7HN7+ypbh8zYHsYfa9hY2PzJMUvEef4QDqg5WCkwSySGpxCZKriA nA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v14evdq3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 12:41:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJAwbWC020893;
	Tue, 19 Dec 2023 12:41:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b6y9ys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 12:41:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXr9F0T+MOnfUu4KwlKr6rsgqLXlsrbFSeoO0qWvx0yTw49ji5yhmAA9z0tNXaTc+gwXwG0OWCem9FiKRNPynU7vn+GN0kIVgwr3Ul6VtlMKa38CeyBFrY45iAo0ZkYHIl5jZY27/U9xrkYPyofHnJ/SrFocrL2baV/zEBfXyD7eOlOVSwA2+ugZoEO0YO2kQjmD4fj+Wovk8Tbt5MbypL5gwE8x3369ANKgEgLlGA1++P2cCGLHIHR5TZ/kgnk51cMrZ3trSiDjzH6dmMiAILUA7PzhqPymIEWGMicmXjSCdCmInsAqvwYtS/q8XlPrFOuLf2V/yhvm7nlietnDhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0AjNTLHpbAxWdbLfA6ZTKTFLeJPVX2P1ECzSEZVcvw=;
 b=e/4GdWvrgyAkSAB0U46xTR0RTeJ0S62irBZty9PZg3W8Bk9rFvsd+75yIfwezxpmVPysj/ewl64ODygWCUYEDaQ3ktp0Gm+OTMQNXft5naKVotNoIVz9b9vx0cBWNg+Dn/06rL6Z1kRHpSuSyM2tnmzyhGU7N3u/q7n4U+qCPi6UGhJ1q8vII5sGoLQWwz3QJBduT54XSEspA37RCjdeYpOVXWbsAQO7Epp89b28kBIrhH7/byzEq6dBHietFV6xQiYP9O8K+c9rBOnf56ppUwJpP0KGFnQTzTLj0Q8F5TZu+pdh1/TE9Fq+KrhcPW9o5GmZsF8jFOttWZkwqLNIpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0AjNTLHpbAxWdbLfA6ZTKTFLeJPVX2P1ECzSEZVcvw=;
 b=I/B+mFcFpjsIh/Ej4WESUH5OPSAcW0fizE5/zta26yEOq+tvsTXX/aqdh7eUnuH98Nv91Xn/0H15IJCT5JH57pnVz92nyn2a3E5P7n4WFsLLVVhniRr80tCDL3RImI+x7kwA5r7qBoUYxoc2CRzSAFlPYIaFKu6XCmKgUXsvmKs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV8PR10MB7917.namprd10.prod.outlook.com (2603:10b6:408:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Tue, 19 Dec
 2023 12:41:42 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 12:41:42 +0000
Message-ID: <76c85021-dd9e-49e3-80e3-25a17c7ca455@oracle.com>
Date: Tue, 19 Dec 2023 12:41:37 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] block atomic writes
To: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
        martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, jaswin@linux.ibm.com,
        bvanassche@acm.org
References: <20231212110844.19698-1-john.g.garry@oracle.com>
 <20231212163246.GA24594@lst.de>
 <b8b0a9d7-88d2-45a9-877a-ecc5e0f1e645@oracle.com>
 <20231213154409.GA7724@lst.de>
 <c729b03c-b1d1-4458-9983-113f8cd752cd@oracle.com>
 <20231219051456.GB3964019@frogsfrogsfrogs> <20231219052121.GA338@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231219052121.GA338@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0255.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV8PR10MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: 41b95cf6-70a1-4de6-7e2c-08dc008fda5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	82gelfbR1MGoIIldrTrluo9wzDfwekqe1oNYITWt1Ju9lYmvQKeoFgByXsJ3hWIQLBtMCoI4rT8SsE7s6VEUGlQHUNd4zFGRnudwRuH8FPBmGeKfRg/dh94+fVGf0oaEyZIF5g4b+rcK/9cNCueDhYZepW/nDZ4OzbAjH2+D1Gwg53vhFy+qzoi2HpHWMRzsWZUzwIooXiVgODRWXF/QpTTci8lUskTZw43IpZB21q5nxSfgjwby2duAqJFv0uL7zj5JjtmHdTtQLqK+v6gHq6roCKJZnQJa+1ep+2SBVSRz8KVHjkIwkY/lCB67w4tlGDRg+VZonTCgj5QknGTJ7nd42CxjnF3UblvzOAT7MdaNO0Mvl/m0wBFo7XNhCGPE4QsnWSB4sxyq3YbHXvaX4xw9faQF7N/cfUwXvK1XDOz0PXFQTC9Sg7F+ENUU0/9f2RziPBhQsQ9+M1CSy+qf1jRMnBw6FMCur9el97DvBQs0soumIc5iWYcsX6DECHpAFPP7/NzleDROQYLHT0vRs47XIuWIRZL7b+rmnXwvplAgxKdFKaoHjEL6/Ka65dyZ+AuZt04CY8l83oN9DDdMVAcOKBZnt7AyQDRmVqJfTEEzBiJAuSv1+Axf2606Fa9i2CevuWjn5GcSOfTCdMsAIA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(396003)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(86362001)(31696002)(36756003)(66946007)(53546011)(36916002)(6666004)(6512007)(6506007)(66476007)(6486002)(66556008)(26005)(38100700002)(2616005)(83380400001)(41300700001)(5660300002)(2906002)(7416002)(8936002)(8676002)(478600001)(110136005)(316002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WjM3NGtJUzRuN3RkazBTL0pESG8vOHN6dlNRODBuUTRuZDRFTW1Oa1JqVk5s?=
 =?utf-8?B?emRaYlNuNmg1Z1UrdVZza05ZV3B2V3RZWHVjcndpdUJMTk5IZHdISnc1Zkxq?=
 =?utf-8?B?dE84V0hJaGlDL2xHci90MTUvQlVQU2hEdW5uYkxXZXNXdWlXWnNCdlN1YlAr?=
 =?utf-8?B?NzJQSnp0ZDNmOGE0d1VsQ1A0V3Z4SjNyckRTLzJTUmJNWkdZL29yMlcrbzBC?=
 =?utf-8?B?SGM5SG5MdXJBeDl0TGlVQjFoYU9hMHphcmh3SWVxWU9hRVl2UHplSDdyMGFG?=
 =?utf-8?B?VXFTcnRJUVJ3Q05XRTU1OEU3UmNydXhKSUprc09TUXNzMTh2all3WW16em1B?=
 =?utf-8?B?U015bEE1d0JLZ3c5ZVRZUkVzNGF4TFBRMktHa3VxWi9DeVhMRjdEWHhrQXBs?=
 =?utf-8?B?VFcvMjh5V001bnRtMWRQM1FnUVdtd2YwdTJEM1dsOElpdnhiWlhaeTM2RFV6?=
 =?utf-8?B?V3UxNVh0TXNoaGZqbFAra3JmcU1iVlVYYXh3SE1GY1ZPWG4xYkxKNGZQQ2ov?=
 =?utf-8?B?alYxRzF2MUFVaTZ0MlQ0elNBTXRKSXlnejROb1JNUkhHZUFVMXZmcUQ4Q1Q0?=
 =?utf-8?B?ckNZdE4xYVRTYjZYVW9mZHMxYkUvRVl1SW9ib2pzY0IxMjcxUkMreTRxbEpy?=
 =?utf-8?B?M2FGWms2MmZMNnRmcE1LK1QvSDhZMnZINVlOYUt2SEllaTd6NXVXT0NOUy91?=
 =?utf-8?B?bFV3WEtRdWhnOTcwTnZKaklnT1NENFZ3SGcxaElJRXV0emxNOUFhbzZ3ZTRB?=
 =?utf-8?B?RU5aeGNjTDJ5MXFsWWIwZTZzQ1lzTjZsakJDbzMrWlJ6RnhPT1hRTkJDL202?=
 =?utf-8?B?VzgvYldoRldiSDFWUTU2YTM0TXJreHl0SVZmMjA2NmJHR093ak9RbWNha2Zn?=
 =?utf-8?B?WnN2YnFoQnQ2UUM1ZXdxYkE2RmF0NjVvdldDdndlM3Q4SUlKNVp5dS93dnFK?=
 =?utf-8?B?cnFveDlTSnNMWGxjRlg2WUtmVEd6S2FTTzJDN1Q0M3ZUWmNDZUk5SW9zZHFo?=
 =?utf-8?B?TW9BVHdnTTJ2Y0lIZDRFYUhZaG1FcFRDdmNQUWJWblZKU3ZPWVpqMTU2S3Vx?=
 =?utf-8?B?alRTUVZHMittelgzNHh6L2t0SnFKWmdxWGpnMmExNnJtaXVyWkh5dnBnNVcv?=
 =?utf-8?B?ZUhVSDVTODZPM2J4QTJ6KzkxaGVNTmU0Y2kzQVVHY2ZieC9sSE1JcWVwU2oz?=
 =?utf-8?B?WGVUeDZ5bFNoRHFDREhwbGhNc3R5MnIzbldvOHFwazZpTTU3UUV3Z2xuVkU4?=
 =?utf-8?B?aDIxMHBTb3lkekF6cmtONnNXTnlOTDkwK2hFMVBTRU0vd0lvVnNTNUNlR1hQ?=
 =?utf-8?B?WGpCK3MxWkNtQkgySFc5YXdjTmZvZG9lWWIwZ09pVDJLZ2lPNmEvenpLU2RN?=
 =?utf-8?B?eXFBM29wTWZiUURscUNsNVU3RDR6N3oxWkxUc05MejdtOUhOWU9nZGtCVTNU?=
 =?utf-8?B?TzNkZE1nZkYyQnpDNkJRUHppVXQ4d0VOMmh3SXFkSkZFTVZLREh6OUowd2Qx?=
 =?utf-8?B?dStLc3pGOXR6amc3TkwxTjhrdmwwNVVGdmhIa0FJK25Sc0QzSTMzZzZBT2FS?=
 =?utf-8?B?QWNrREtoUnlmNnNjc1ZtNFl2NzlRY2tya2g0d0ZIYkVsejlERWpSemd4UHFr?=
 =?utf-8?B?NW50TDBBSVdYWXYxcGV2cWwrYkhkMjNJQXFvcnd6cEFBMEZHdDFvVXZPUHBr?=
 =?utf-8?B?S1RZOWZ3UlVvaU5BU29JZXJGL2s3MzNCa3duSEhMT05Kd1NxR1JRaFI1bEp3?=
 =?utf-8?B?dU5wVjJqeENIUTQwOHlYV2pXRVhYQkd5SmRQT1JZdVJsME5EZytEZ2tleXdC?=
 =?utf-8?B?VGxWdlpkeEx4cjFPVndBUXI1eldRMHoycUZlcThUR1g3TkhnSUl2SXJ3MUo0?=
 =?utf-8?B?RXhwZHZMVWcxb2x0aXRVRmdZcW1WeGkrYWJSVlQzZXFSQnNyTDllQ1BobGd5?=
 =?utf-8?B?Qlk4bjZPc2ROSmVsMzlUUzdML3BSRDZJOC9iakRUdW5CMkdwcFllZzlMMHJp?=
 =?utf-8?B?VlIyRWo4Z01TNlFzSDhnTnA5cC9IdVE2ODFjbjdjeHp3YWFKZW9rMkcwNHBo?=
 =?utf-8?B?WUVuVmVlTVFldlh2cmptMTQyMWFydDh1T1U3WFZDTWhrZm9PQ3cwMGZQcDRM?=
 =?utf-8?Q?IzcCTukZzd5d5NB3xbnVQkyFi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xNQoJhgQS6WbbLy4YZrJJ3jYz7yCjGI/ghloXUzfkXUMHSazFIJn5BHXQaE7ZRyg0by+KF/soikraIIn7gtD8BEJ3bfrvsP0K8ZXdE7b5GnMJKWT8ERDDPrz+a0eFmc7myl+IOMJ4Pw9Xibp30hMiDVE1UuRPttL1yzNiT8ZaGvYTn6hk9Le0RIoCDs42+ct/xF2So4r3BHKuNWHo/T1a7KV6NXbdJ3ItDQWkZ/+CY8aewYToK7PGGgDc7r18kwjpmtHKPjW4WOQhyKbLeLbIa9UmHkRDEEuBtynTasWgMeAE2GtLg73qNHxklsqMsTIF2GdaEnum21l+YVMsETtwr3QluYh3OxQW1MvZdGwuETh2lc6Nxff7PHKQkYWRiv/BMngiBZnUyIFwphm6uRL2huG0mie6yFjpwnxOxrp89c/g2sDRjsRKGWcmpf6hPiIBa7nqVJ1cQOW5E/t4+4Ab/XpCvzVZgIu/sk4ZxGFeHQbrtDeyrRBxKHvH+K+BAdAPEQGO+o2MYPCyTJxwjwisIB0hRfR9qUyVD+aDbtEEzWRCSivKyCenvnS03kCQSSaOevgc731k94qBAuxXaINEMLxp54Yp6k/hRJX5X6/Ku4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b95cf6-70a1-4de6-7e2c-08dc008fda5e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 12:41:42.6146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkg5UKTFwleZBeAhwhjD8/Jnm4c6OpU3crYMEX2S9ia839JBaDOzgxRh0pjvw9wGaBYKSPQS/pT+V2vXThjavA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7917
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_07,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312190094
X-Proofpoint-ORIG-GUID: 16ywSFLrKwLUcu9918SKbWgXkkiI32AQ
X-Proofpoint-GUID: 16ywSFLrKwLUcu9918SKbWgXkkiI32AQ

On 19/12/2023 05:21, Christoph Hellwig wrote:
> On Mon, Dec 18, 2023 at 09:14:56PM -0800, Darrick J. Wong wrote:
>> /me stumbles back in with plenty of covidbrain to go around.
>>
>> So ... Christoph, you're asking for a common API for
>> sysadmins/applications to signal to the filesystem that they want all
>> data allocations aligned to a given value, right?
>>
>> e.g. if a nvme device advertises a capability for untorn writes between
>> $lbasize and 64k, then we need a way to set up each untorn-file with
>> some alignment between $lbasize and 64k?
>>
>> or if cxl storage becomes not ung-dly expensive, then we'd want a way to
>> set up files with an alignment of 2M (x86) or 512M (arm64lol) to take
>> advantage of PMD mmap mappings?
> 
> The most important point is to not mix these up.
> 
> If we want to use a file for atomic writes I should tell the fs about
> it, and preferably in a way that does not require me to know about weird
> internal implementation details of every file system.  I really just
> want to use atomic writes.  Preferably I'd just start using them after
> asking for the limits.  But that's obviously not going to work for
> file systems that use the hardware offload and don't otherwise align
> to the limit (which would suck for very small files anyway :))
> 
> So as a compromise I tell the file system before writing or otherwise
> adding any data [1] to file that I want to use atomic writes so that
> the fs can take the right decisions.
> 
> [1] reflinking data into a such marked file will be ... interesting.
> 

How about something based on fcntl, like below? We will prob also 
require some per-FS flag for enabling atomic writes without HW support. 
That flag might be also useful for XFS for differentiating forcealign 
for atomic writes with just forcealign.

---8<----

diff --git a/fs/fcntl.c b/fs/fcntl.c
index c80a6acad742..d4a50655565a 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -313,6 +313,15 @@ static long fcntl_rw_hint(struct file *file, 
unsigned int cmd,
  	}
  }

+static long fcntl_atomic_write(struct file *file, unsigned int cmd,
+			  unsigned long arg)
+{
+	if (file->f_op->enable_atomic_writes)
+		return file->f_op->enable_atomic_writes(file, arg);
+
+	return -EOPNOTSUPP;
+}
+
  static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
  		struct file *filp)
  {
@@ -419,6 +428,9 @@ static long do_fcntl(int fd, unsigned int cmd, 
unsigned long arg,
  	case F_SET_RW_HINT:
  		err = fcntl_rw_hint(filp, cmd, arg);
  		break;
+	case F_SET_ATOMIC_WRITE_SIZE:
+		err = fcntl_atomic_write(filp, cmd, arg);
+		break;
  	default:
  		break;
  	}
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index e33e5e13b95f..dba206cbe1ab 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1478,6 +1478,46 @@ xfs_file_mmap(
  	return 0;
  }

+STATIC int
+xfs_enable_atomic_writes(
+	struct file	*file,
+	unsigned int unit_max)
+{
+	struct xfs_inode *ip = XFS_I(file_inode(file));
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
+	struct dentry *dentry = file->f_path.dentry;
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+	struct block_device	*bdev = target->bt_bdev;
+	struct request_queue	*q = bdev->bd_queue;
+	struct inode		*inode = &ip->i_vnode;
+
+	if (queue_atomic_write_unit_max_bytes(q) == 0) {
+		if (unit_max != 0) {
+			/* We expect unbounded CoW size if no HW support */
+			return -ENOTBLK;
+		}
+		/* Do something for CoW support ... */
+
+		return 0;
+	}
+
+	if (!unit_max)
+		return -EINVAL;
+
+	/* bodge alert */
+	if (inode->i_op->fileattr_set) {
+		struct fileattr fa = {
+			.fsx_extsize = unit_max,
+			.fsx_xflags = FS_XFLAG_EXTSIZE | FS_XFLAG_FORCEALIGN,
+			.fsx_valid = 1,
+		};
+
+		return inode->i_op->fileattr_set(idmap, dentry, &fa);
+	}
+
+	return -EOPNOTSUPP;
+}
+
  const struct file_operations xfs_file_operations = {
  	.llseek		= xfs_file_llseek,
  	.read_iter	= xfs_file_read_iter,
@@ -1498,6 +1538,7 @@ const struct file_operations xfs_file_operations = {
  	.fallocate	= xfs_file_fallocate,
  	.fadvise	= xfs_file_fadvise,
  	.remap_file_range = xfs_file_remap_range,
+	.enable_atomic_writes = xfs_enable_atomic_writes,
  };

  const struct file_operations xfs_dir_file_operations = {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98b7a7a8c42e..a715f98057b8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1956,6 +1956,7 @@ struct file_operations {
  	int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
  	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
  				unsigned int poll_flags);
+	int (*enable_atomic_writes)(struct file *, unsigned int unit_max);
  } __randomize_layout;

  /* Wrap a directory iterator that needs exclusive inode access */
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 6c80f96049bd..69780c49622e 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -56,6 +56,8 @@
  #define F_GET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 13)
  #define F_SET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 14)

+#define F_SET_ATOMIC_WRITE_SIZE  (F_LINUX_SPECIFIC_BASE + 15)
+
  /*
   * Valid hint values for F_{GET,SET}_RW_HINT. 0 is "not set", or can be
   * used to clear any hints previously set.
-- 


--->8----

