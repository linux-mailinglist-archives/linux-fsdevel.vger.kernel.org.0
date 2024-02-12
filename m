Return-Path: <linux-fsdevel+bounces-11114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39D485133E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 13:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A108B25E43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 12:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04C239FD8;
	Mon, 12 Feb 2024 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xve4dNCI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r3zXSmaW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E38C39847;
	Mon, 12 Feb 2024 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739824; cv=fail; b=ms6fuwBiv4GEg3+3gOVG6hUVHQ7vBDBfJAHaS1gbHZhx4KvZ7K9xkeUA9KWzEewQmr//7mZxAsT4t069gvna/lt4Jyo+j55BGD8jROXThyvhNGpE1I6B/x8bqkmxvPr1cjMrHc8x3moc4KDhxKsOKdiXLV04R/wxzm3I5BJ8L34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739824; c=relaxed/simple;
	bh=YK1HwJIz/wOMLRaeSqEn9GGC0CO6xq0ZlBMAVczOGgc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K/hVyFX2I5CTTWGsHYo/+Ujd2X48yv5h0Zd60n3nDQeq9Yky6qoGNiz1ojVxIO5wTnpRZrek3XXcBrKhsnsKmTVInp9h2yk4WniuAlriFZzn6ZesHRLy9tO715jMo0tgXB5VNgGJlKL6k2JbWFJNnRE0c1gQpVLSxWUqNDTb6l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xve4dNCI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r3zXSmaW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CArUXG013395;
	Mon, 12 Feb 2024 12:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=GGZQnnnv4B112C4ZX04mm6pzGvlYxlnLwdJ1DX/W/w0=;
 b=Xve4dNCIgcOZnHEAFrn3umpUQiMNMeN2Ga7A1gTE5nZpMMXPidjkEwj1ex5htg0pDwXY
 VMKdJQi7xG/giiPc+suUUvbHwYFoB4Mx8qewoWfVgRLW68F60N9ZBS9deUDq/neFb0Ri
 K2IK5G/6rgZdkgkYMm4xHmNJod3fbFB1P59DwcPKr0I2hqT5Od0/NSOZvZq01tQ4Wktc
 HnUVi9xDfVBrr7AXahZr6RiPi0MwpjlDRm0vY8vApOsQSos94eIjjJ1WuCgJwTwh1PYy
 HHooWdM4bp7hoc4QPrnVUcAq0d4AfEt5KRaMTV8Y8e6Sarix5wUkf3uXAFpG8w4+ZBGw Dg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7hy8g46s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 12:09:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41CC3EQQ031528;
	Mon, 12 Feb 2024 12:09:54 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk5nn5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 12:09:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMeUrDtEIlLi2dMtdyD9vX2SrIRasNfidbTHo0AqUrRFgOq+8SXKUrXo0NIp+e/hb/M/Y52/Ef8NILFu7kWl4zza0MGOxXYbdgmzj8NoL4bIa7ccb7Z1+ght6HojL16W9+O7EN01Kgy+nx0sxhEcnhfD+FjtAtq2Xc0JD+R7U3CqbiQrwyfVjWrHQwgXDZ6znrzUeO7ukpQRcUD/IpHOchnePz9gwA2/rkbr+cTheofa+OyXJUgDJtDkSgX012BOCyUNXLulL8bnkD0cpqxUjSDfs02d6KWmRO9yq5u1YJR5Uh3MM42anVy8xGmOazoL1VE1kUqiwSMWg2m0F584wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGZQnnnv4B112C4ZX04mm6pzGvlYxlnLwdJ1DX/W/w0=;
 b=nFPtTCbcq6mMkeFsgXGw8noiRe/Z0bnRPty2Nqk4eo7FHa/2Xw4DcHhUhWqqrFaTA7R2OXY7kbotNklB5Pud1e/N1tjbW1iNPNV/jL7DDYr8eZFH7P5o0Fw2nv0kEnLoHF9LWEqGzxg2B/QJxKVQSuM5lBCTl15rTh32yamQ4mUyMWurSzKfyW9g1PCxUvlq8UQoFH6as/MDDAOcIxB+NHaj8U9vVDo1YNrfkKtNMu9824zbKC4L0i5dn5ytP+uZEuI5Z0AaKGT7MhVzboW3/+D/SVgVtRTUn0e/dV8InJOl6OBl6UV+/cXIl91sBx7I0hrduBRieJayLt8geNz6/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGZQnnnv4B112C4ZX04mm6pzGvlYxlnLwdJ1DX/W/w0=;
 b=r3zXSmaWOVQ/NBwmglLT79O2kpt238l7jLvjstFK7yxw4CAy0O98+/34NWi3TrDLRFQUBmfjq9WJBFAs9JBHUIub+ULUrcVUHooHlULIBbN78BJUa3WBC9c5q4KHJAFjAqjYdbq7rhU5eWoyRThlQvZ826BVdC7/goRxlL08iN0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB7853.namprd10.prod.outlook.com (2603:10b6:806:3ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Mon, 12 Feb
 2024 12:09:52 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 12:09:52 +0000
Message-ID: <b3ce860d-4a1e-4980-97d9-0e8ad381c689@oracle.com>
Date: Mon, 12 Feb 2024 12:09:46 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/15] block: Add checks to merging of atomic writes
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: axboe@kernel.dk, brauner@kernel.org, bvanassche@acm.org,
        dchinner@redhat.com, djwong@kernel.org, hch@lst.de, jack@suse.cz,
        jbongio@google.com, jejb@linux.ibm.com, kbusch@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
        martin.petersen@oracle.com, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        sagi@grimberg.me, tytso@mit.edu, viro@zeniv.linux.org.uk
References: <20240124113841.31824-10-john.g.garry@oracle.com>
 <20240212105444.43262-1-nilay@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240212105444.43262-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0494.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d34b0b3-334f-4928-6470-08dc2bc38402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Sl7cS8Q9b3bJefBCT8mR6h5JHM7O87D5YxnxMfhBxWIXaO4dNoKJZj7d+rO/w2lOUtLDPcsktqom1wOibTfd1c6MkcpvgP4CtYcnHmwmkVE6DkIt6ZMEbdDf2VCS4quwaDlp+To/NOqJ+p8pW9vGvj1TRN52e+FQ4gZOh75JzY5dwEn2/BMTMIyPIIuji0Z36uIQY0FhDhc5KcD7DnYvW8PtZFwkaLXOsdcNrvFhaEmRlJAs5TeqnQTd3m5GTVDs385KsjkbUKJzC0IVMJ9HHEDqwYujlqJYJCRDppc/z2ApDugvGQs/RUKTjUPsQRV07Didhorby54sDfJ6xM1qpctO6kg91btQnemfBsi1wF/KjwIuek6jw25r1Fc5FEmjM6mr3XuiAUDI7B7zwu1L4uSiXVgkuvagV1WVn0ZwACFAKrF9yR0jVpNLvdOtKNq1mubp+U0ZXfbeb+hovaYBW4XgNLpZN3RbITAowabRQzqDlWt/EpylaxMfNnjPh8jzj3pLZy04U3CS24TyTtqMVtIgZTtgierbny94/lKBE65Wl3f2GR5wRkbCYCqzKqEX
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(31686004)(86362001)(38100700002)(31696002)(2906002)(7416002)(5660300002)(6486002)(26005)(478600001)(53546011)(6506007)(6512007)(41300700001)(2616005)(83380400001)(36916002)(6916009)(4744005)(36756003)(6666004)(4326008)(66476007)(66946007)(316002)(66556008)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WmdkMXpwNG5ncVh0MmJlYUZ5NUVlNlNqSnJRSmpUTTEzemZGZVJTbDIyaUFO?=
 =?utf-8?B?ZnpkMUJjamJsMDd0Nm1QcUZIZGJhL3k4YnRLRVd0WlB5L1lBUGRGUm1rQUNB?=
 =?utf-8?B?T01UamZudk1PQzZOeUEwU1d5ODduVTB2UEw4UmpFWU5CUWM2SDk2bWdJS3BH?=
 =?utf-8?B?SldrZnJUb1Q1STJhZGJrTUVYT0dIdFQ5anVaOEJGbXRvR2tYS2JXV0U5ZDNs?=
 =?utf-8?B?c0dhTHJUUkRLOE5nazhiMjNhTXFQS29YcHROZHJyZG1MR2V6Sm5nQ0F6aWRo?=
 =?utf-8?B?SEFMeG5KRi80eTRGV1U3cjY5RGhENjQzSFY0N2p5SUN4eXZlOWZRRFhnM2ZC?=
 =?utf-8?B?ZG1kNDY4WmRpb0d5WU9aaXFDMFk0TkNhN210S3dTNnR1dGdyMFAvdzlFclZ5?=
 =?utf-8?B?WUFlQ2xXeFdUUUQvM1Z2Z1ZhWGhDZCtHdThXcjE3Z1R6dG1PQ08yZHg1NHRl?=
 =?utf-8?B?ZkRtd0ZNTDRsRHIvcFk5a2tLT3FkcC9HVEhxV0p2QjFXWTdWWXRaK3N5T1lv?=
 =?utf-8?B?SXFzSFJ0RkorVmZHN2F5YnFiVkpLbzBmTmZabWxlN1ZTRkdTNFBpVWF6Zndl?=
 =?utf-8?B?SHZaSDkyMCtBT3B4WXN6Lzd5OXR4RHVRdEZjUmw0Rmg2czl1TG9SaXVKYnJO?=
 =?utf-8?B?MVNnakdzckNEamlVbWRpMXFGSGVQVm82M1RFM1J2dnljT25qWHE4QjZxcnh1?=
 =?utf-8?B?NjVwRFQ2aUh5OFAyOGswdSs5ci8yMGFrcy93OXlhemFhVjRrK1p0REppYVVW?=
 =?utf-8?B?MXF3Q2ZHNDV1OFMwVWNRSE1lN0llMWQ5WnFUc1FxaWlaZVdPcHBGQkFjd2pT?=
 =?utf-8?B?RVNxL2JaM0hHQzBpSEVDUlNWUGphaHRlMEk3R2pqZWJ2ay9DYWlqQS9tcnRV?=
 =?utf-8?B?K01nVEdCTklWczlKYnpNM1FNQmUvZjVDaGFqbEtjNFZKRTFvNGcreTY3QXNY?=
 =?utf-8?B?TTE0eUI5QUJxYkwyZGk3b3JuZXpWd1Nma0xKMWZEeEs2cmZWcWhITDdZODds?=
 =?utf-8?B?UmhYVmk2V0p5Vmw4NDhUdjVkbmF6VTVIczVuUmVaSnVCUEVhdStrWUY5eGtU?=
 =?utf-8?B?OFZzL2ZWNmQzQ3VMRTI2Njhrb1RnUmUvR1FvYkhtcDhodmczR04zV292a2k5?=
 =?utf-8?B?OEM1VWY4b2IyQVYvY01MbTdaM2lybSs3d0txUElZTjYrc1RaMU9SenRtbmVj?=
 =?utf-8?B?VDRvVzFNUWJCaitGM2JMRFh5VVVsTWcwRXFxTUtIYk9TN3JqMDAzcDBqelEr?=
 =?utf-8?B?UlVuV0Vlb1g3OUxiNE9nSTFNa0EvN3UvQ2ozNmFkSlVVMHRtU1BnTkRlTFBw?=
 =?utf-8?B?cGNtRTFsOVRSZVBsUG44YWNxVk4rNEx1c2Q3SnYyTVhDZXpXSG8yK3dxZktU?=
 =?utf-8?B?Y2FpZzJUQjNzMHF2NnRBOVZZQXNhcjg3UkdFUlF5T0tTeG5EQTlCeE5QRGhJ?=
 =?utf-8?B?Mm03QmxWQ0tpWnJvMXFhTDF0bHkzRVplbkRZYWV4Qm9PcytqZWROaStaQW9j?=
 =?utf-8?B?M3NRZ3dycDNRU0R3YUhBMjIzVjlaZmtSWVl4MzRhN24xQ2VGd3BmWkRYZDlI?=
 =?utf-8?B?R0o1T01LTTlEUmk4UVczSytvSk1uTXFMaWhUYVFMNGNtSUJzNmR1aUhLRzFp?=
 =?utf-8?B?N2thMTF2QVhkSVRoWkVZelZNTWpRYklIS3ppVzJIbkxLTkNaUWx0Rm1SV1JT?=
 =?utf-8?B?a2RRYWF5SXpoZ2dKdlU0NHh2N2JlNytRTElUbG5sV0xteGcvUVp4MFJlbi9U?=
 =?utf-8?B?djJxVTM2SUZ4UStrSW9VdWhoQW0rM1VjNUs0N2JtdmR3ODR0QjFuUnV2S1lM?=
 =?utf-8?B?QW9HdkdNdjZKQlM3aTg5SHdleXVsaXd1L2taUFRDbnE1cjFRTFUyVlhScFpT?=
 =?utf-8?B?eHNncUk5S0hpeUZpbStSM2t0TjM2T2dYR0ZZaXQxU0x6OU1tdk9MK1VwWTZv?=
 =?utf-8?B?a2I4cmsyQjk3a3Y3VUxoQWtPd1YrWnhUcnAyQmduSWRwOG10NmNkOW51aUtl?=
 =?utf-8?B?NTRzZzBGMkFMd0hlQ3Q4Zm5tVWc5emtvMklPRWhQdVVhaS9jcEtPWlZWRHdS?=
 =?utf-8?B?WXVKeUp5MzBqQUhLTzdaZFVZZDAwT2ZHd1REZHgvbkQ4cEE1b1dMNTJyZVNa?=
 =?utf-8?B?ZUFleFNUeFhLRlE3R2NIVkh5amRNdVhSVndsUjU2L0tVTCsyVHVkajd6MnNi?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4FhiyqXqYmC5mN+20Yn/GyrlVP+Fp3J3BxLF4un993UxdiOEJi0gXauu3WQHEggQ8IVeLwuuxtrQZbhoEOHKhjHdWnMC0beYv+1wPYz+iVhPFU+kcGlcgspt7tRuk7RJKIJbi/MY8nC8Hb6MNcykCohFHyeDNqssSgyOetSDKtGmmerZ+zomgvoz0KAXOt+Ufw+jL/Gs799SU2BW3XQSWMlWk+Ho8zGuZAzm9oDbyr+Xx4LI1MOwIHfLCCRuWkuWveU9zMdPHZXjoDHiDYywgsbwbqp4yW4SU9IAxHXigIJwXZh+PiUrt8LJr5C5BwGTyi/vnoqesdgxhNUydtUMTzPkJPj5BPX4gb7gqNvVgU+lQPt5QMFXzYByp4hJjIu0lFkpNaf/iQH2z43GnARkP/MhE5em0SCTYQzCYAI76sU2pbVI2ZvdPFbgk1ZpjXCDsZLzjaPhrqc5ZoCibeIboBw/NghXtgvQ/buR2jGcbStWHgzfuOI0MLNx5STqlJL7oF9NNEdYjlv8oIIme4HQuZpGyfc2dYA9m4Vzhq2srPxxN7xfZceCIggSkzgldRwk465ic8IHwpxI0kvm/CHFvmx44RnWGYQ6+Z6yxsCXOFc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d34b0b3-334f-4928-6470-08dc2bc38402
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 12:09:51.6102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RIggs2HK+/gZ77EX138ZOipp+DxbayMJp7De24WTblVcsLIJFe3v7E93j/xx445TTzCikVPiaOL/aKcQ1NtOxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7853
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_09,2024-02-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402120092
X-Proofpoint-ORIG-GUID: WzDj1h6K5NERO89aoQ4W0dGUWg8xkZcF
X-Proofpoint-GUID: WzDj1h6K5NERO89aoQ4W0dGUWg8xkZcF

On 12/02/2024 10:54, Nilay Shroff wrote:
> 
> Shall we ensure here that we don't cross max limit of atomic write supported by
> 
> device? It seems that if the boundary size is not advertized by the device
> 
> (in fact, I have one NVMe drive which has boundary size zero i.e. nabo/nabspf/
> 
> nawupf are all zero but awupf is non-zero) then we (unconditionally) allow
> 
> merging.

BTW, if you don't mind, can you share awupf value and device model? I 
have been on the search for NVMe devices which support atomic writes 
(with non-zero PF reported value). All I have is a M.2 card which has a 
4KB PF atomic write value.

But if this is private info, then ok.

Thanks,
John

