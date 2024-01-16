Return-Path: <linux-fsdevel+bounces-8056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A6182EDD7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 12:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047CA282CA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 11:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD641B94C;
	Tue, 16 Jan 2024 11:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y9bNiVGU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mVB0+RAy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535E71B806;
	Tue, 16 Jan 2024 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40G6i4V6015483;
	Tue, 16 Jan 2024 11:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=a6L1huJju7kKuWvpfdhmNYBtYJqO64C5OQUqW/tWZnc=;
 b=Y9bNiVGUeyVdsbJg3wqQ8qVyPR4+B2J0L3RZ1zxaS1PFxb61KIXVWTb1HNyKbhUIZx1I
 NeNv5PHCHdt42LOmkTd2cUp9BJUULH215ZA+Hk1aOuj7EPlZ/EcOw3ON+UUae5xuGR+t
 Z/z8mx5itVFtVj61S+9reQtmREOa7KPBIapm4hGaeayLZ/ZtiCxpCmDjJA+4vxpeRa3M
 Bqmqo84fmdrge+xSUfI3vtctb0joYfLS/INQONB4yhhR7EhgRT/VTMTelj6IXicrn1OF
 ToWqTgl3fTV2cJKnsktt7k1IPUrLIi6dZ799uwqt68qMbhPLqdGjNJ5bKrXyPYqCh4yV dA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkha3cnjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jan 2024 11:35:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40GArNf0005328;
	Tue, 16 Jan 2024 11:35:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgydtm5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jan 2024 11:35:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ma1GQZTUT8GYwoZw5NgeM9H8w7dqeyhu6ym7VpBpJ9Pye7aGtgTmJrgyKt6w9oBEx4yTiEOwSp9s6Co5VyYlWgObcnpL7jXuph8Ubg0LIXAmYYfK5Tur731qeTU9R+gjrVyRbqpqf8D4LxrAeaFuQzxlLq2et67tbWdGaX9lW1fBOHaW/GDC7jhJDH6Fp8dsvHzvKIYYs7J+JpxXn8HQdby/Zt4VMzf6Uv36ljl2Tk78u1BOF0n49lQYJAno5o6W8eF1D8YoEBE3Kv/aKfm4lllNKZj9fuCiUZY3HpvuKvHFruZ/9LU1V7I8zNwfyAR817SWl/o+l1sZkF6VfqM6dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6L1huJju7kKuWvpfdhmNYBtYJqO64C5OQUqW/tWZnc=;
 b=c9xRS9UbSilB87Vz78Lpm27qSl3BHlL7rlANA2BfiT7Z0ZIir8eXeYhWyuqjVl4P/2XYRXztqO9q5PXJPjXAZHuGRGKfN2GkMbeWvXuc4ECidsaPYI8fTJ+TxA/E0id2V8yB8oOi2KrJtEBN24DK5ZJe+BPmq1cKWwcsfdRaOrglA0dbQQ8Ae2u+PWlIcBHBlFCXVJvnbGDcyRWJJAb2yXbuypcsgSiRqV+nKTm1G3XgjikXRAlDSWY17C6V1znjtxyvqABPUsiDr/M/Fh++MPtf4n9a+wUYPFla1WpNRXkOslyk3IKN0uk8BKPGBIxk7fYKzTefhX7YboNaBNFxEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6L1huJju7kKuWvpfdhmNYBtYJqO64C5OQUqW/tWZnc=;
 b=mVB0+RAyuesJnigpJYkCk91xFd1ksxgerw5zm2F1wKQeEXcWRKDfEQpgqxvlymjuq7p+pz54QhWmOd6RdQM5846QzfpTsz2DQEewiZ9yEwnlCpdltbxsY08a+hXTECWVHja4hwagE8IewYZjhcBVPvBarxfZx5LefXPPo+d1StU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH2PR10MB4215.namprd10.prod.outlook.com (2603:10b6:610:7e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 16 Jan
 2024 11:35:53 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5d80:6614:f988:172a]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5d80:6614:f988:172a%4]) with mapi id 15.20.7181.022; Tue, 16 Jan 2024
 11:35:52 +0000
Message-ID: <6135eab3-50ce-4669-a692-b4221773bb20@oracle.com>
Date: Tue, 16 Jan 2024 11:35:47 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] block atomic writes
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, axboe@kernel.dk, kbusch@kernel.org,
        sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
        ming.lei@redhat.com, jaswin@linux.ibm.com, bvanassche@acm.org
References: <20231219052121.GA338@lst.de>
 <76c85021-dd9e-49e3-80e3-25a17c7ca455@oracle.com>
 <20231219151759.GA4468@lst.de>
 <fff50006-ccd2-4944-ba32-84cbb2dbd1f4@oracle.com>
 <20231221065031.GA25778@lst.de>
 <b60e39ce-04bf-4ff9-8879-d9e0cf5d84bd@oracle.com>
 <20231221121925.GB17956@lst.de>
 <df2b6c6e-6415-489d-be19-7e2217f79098@oracle.com>
 <20231221125713.GA24013@lst.de>
 <9bee0c1c-e657-4201-beb2-f8163bc945c6@oracle.com>
 <20231221132236.GB26817@lst.de>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231221132236.GB26817@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0481.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH2PR10MB4215:EE_
X-MS-Office365-Filtering-Correlation-Id: 696bf6d0-0bce-4f3b-17fa-08dc16874bb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OBSBrgFjkPYnJ8kbF2kK0B1wJJxmkr+bhj0wuR2KQYjyVHnXe3qtT5ZcqgyhSnrPx3EHfx4U+l+OYCp5nW8lo9ZMuY4hfUep0D+9lO2mwS3P3rS+hjUprDeewZAOGPMxghoTHttMHvjuJeJWGGj/5GDeuEMGSp/AcNEyhX5NZQ8DUt4N9VAk1y8NLmwNi5JalXuZ9ZJW7ZZcCBQ+AvM5FJKV+dsEyIiubmkAJ0LdbaoIbc0ziAj0l82UqRJ/n1SqoYUxSHDoIT9zMewvN7BIRX2x/OM1u/Pn1U2bhlHYHL/qytjE7LkRPHiUVU1cL/S3a0PMsxqKohRP8NsSMH1UgKmbb6nCL6S5QWRdtN6ENlNs4t9gDRrZN57+MjvJG6S29jaOj/s5aE8Dd/CLNWduDOKVGcBHoBnzMh5duUr9UiJpKVvyzpJHbP4MlkpaJk5cmWFgeY9V9KCZDzUAbdmMpDJLnd1bCFl5iEOMkZ3MP0+kvpOh2G4GP2ouL1Xp+BmhAS3vz44o9V6WE/YfZ7DBky7/9c3blammcvhgYjlreDvofV0rsZhpTZaq67i+PKg4tGYStKF5VSxNl77HIwyH8yPZcKQhAIhsZ/MjJnEf6iYYTzIFIamxWUwz92ny19d2pSS2Sl5Df9ISYLsliTGQpw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(39860400002)(136003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(31696002)(36756003)(86362001)(2906002)(38100700002)(36916002)(53546011)(6506007)(66946007)(6916009)(8676002)(316002)(8936002)(6666004)(6486002)(6512007)(66476007)(66556008)(7416002)(478600001)(83380400001)(5660300002)(4326008)(2616005)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZTY3RVFwbzNuazllZVR4NCtlTDBFZHlPcTNPcmZ6a1V1eDZUNjVHdmw0a0x2?=
 =?utf-8?B?YkxFdStOWjlaeFVDSFJXdi9YQ2QrSGZEbXpSY2NPbldnQURxQWRRVHRZTjZo?=
 =?utf-8?B?MFpOK01TMndhaGhENUpWZnIweTVPOGlFdU5oSXRUS2E0YWdlbzFKUE1DbDNh?=
 =?utf-8?B?RW93c3E5SktjTFc0STdjTU5GakRpd2JLK0h2d2V6d0FvYzdKVXU3MjN0RDho?=
 =?utf-8?B?TlpmUzltTXo2TU5GTUFSeTY5SGVvd3Q2eDlTZE1BRllSS1laek1yOWxhZEdy?=
 =?utf-8?B?SDV1MHRtR09JWGtpWEZybEc1azZ4SEdEd2c4amNHVFRHdjdtanc2UDdEVjJO?=
 =?utf-8?B?eTFzbzR5ZGp4U0N0THNIdTQ5YXBaOS90dEtuWUt1clJQalFydVFOR2FDcTBs?=
 =?utf-8?B?RnRwVHMrNm1DZGxMR2phNTBibUFKSFFqT3RxUlNTbDA0VnpMUk1id1Yzc1d6?=
 =?utf-8?B?N3Q1ZWhRZVd6eFJQTGozNWRPWm5vT0F2YUIwWWd4cXd2OW5zNnVPN09kZ28v?=
 =?utf-8?B?N3FjKzNtaFlkbmFqTVl4ek9GRkcrclpSZ3pCYnpnbGprdzBwc3FGQklJUk5J?=
 =?utf-8?B?TzRPemtVS3ZOWjI2bkZyVmovVVltc2FxQmIzQmZTME9SYW5rQXhwSmorRkN6?=
 =?utf-8?B?OGxFc3dONnJ4VW9LVlVFanloUFJuTTBuZ1NaSFpYcnVMdDUxQzZ6UjJrSFJr?=
 =?utf-8?B?R2tEMUxrU0tFcSt3VzdCV0lhVTFSR1hFeGRRY29Ra0hLcVJJN0U5ZlpHbUh3?=
 =?utf-8?B?SHRDU0RIK2JPVzdXWkxuakE0RDByWWdETWpFYTdDNUpwcER6blhsM1lFeitS?=
 =?utf-8?B?d2YxOEZDQUFtZmJkNU9pYjljTmRqaFRwOHQrWW1FdUE5WHNUMEh2amRGM2lM?=
 =?utf-8?B?eDdNMC9sK3dtT3JrcnM2d0FvbGhubEZyWW9uWXByVEpTTCtoZzRKcGpZSlU2?=
 =?utf-8?B?RWRHNE9pNjFxbVkrWFJpTEtVTDZCRzNLd3NuYXJqZGJMOE0zcUM3djZnRGpF?=
 =?utf-8?B?THhwdmt1QVRqdGNEUXJ5cDJVa3BXbC9RckQ2RWxvazlPWVdITlgxN0pYQ08y?=
 =?utf-8?B?L3pMRW9DQzZ2T01OQTBDRk9RcytPdXREWnA2LzRmQ0FqSFRvM0RTb2U2TGdh?=
 =?utf-8?B?Z1BvL3ZaM3RGeWw0SjMzR1VMem03S0NFSWJqMm5aQ0E0eTRHY3pzbmcrdG5s?=
 =?utf-8?B?SU1NeE56UENqVkdabW5neUdnblYxVjdONUJTRHNEb2U3c0ZyL1g5Skw0MktL?=
 =?utf-8?B?MDhsZGY1Zk4rYUhKc2RqWXV3VGhHWFlpcXVRQ3o2VHM5Y3JsZTdUR1BBNUFE?=
 =?utf-8?B?cFJGNzllWFQ1eDBFQWNPVTFidjVtdnI2R0lBQkExYS8rMHFuSnhmVU1XM0Ra?=
 =?utf-8?B?MGNSV1ErV25MN01TT1pjTjkrRTVnMjdBTXBjUExWZXlrVlQzOWV3eGlJSXFD?=
 =?utf-8?B?VWJPeGE4SExGN0FWb1JHRCttdEJtU0xEZTFnOG96YjlRVDhKelMvVzZNOXhu?=
 =?utf-8?B?M3dFRHA3QVJDWFNoVVludmtzZ1UwZkR5NUxmcUFxY202SG5PWkpFOHhEMjBv?=
 =?utf-8?B?TjdFNkQvdlgxQUZZRXgxTUljL1p1ME5rbDV3NFVBNlRmYWdBQ0FHSkhVR1hK?=
 =?utf-8?B?MXZYZCtqc1RJZ1Z6OVhubXNwVUY0ZmlmYVJ1SjF3dzVsMGZyUTBxdlNnandW?=
 =?utf-8?B?TGdaVjF0MVhaTEUzZkVrQlJxTVZlS25iazFjcXV4bFpIK0hCTTM4Y3JvUm16?=
 =?utf-8?B?ZWJoaDRCTythS2tjMjhpVXNGWmJUTTRzYlBKRUYzMTFyblhtbHRkczRXV3cz?=
 =?utf-8?B?OE9kWVBXcWNkSWVGR3BWUVU0QXFWZFNTUXBiVnNnRVE3VjJTTCtYb2ZpYW8w?=
 =?utf-8?B?bUY2ZlFYczdFZzg2dHdWRXdXYytleVlDdDlqYWJZc2R3Yy9mdWYyQTk5ZDk3?=
 =?utf-8?B?WVExWlA2cmZkY25JQzNxK3ZQRXlzaXlUZzV6S3huNWU5SWthTVFCbm1nMlpy?=
 =?utf-8?B?QmVtYXpZUjNVTmttVStVQ3RjcEwxZkdIRzBCOG9YbStkRjhLNFJkMWdNRkxq?=
 =?utf-8?B?ZXdPbSt2dnlLOEpWd1JBdS85ZndYL1BXVll5Q09nVjN2Ty8rek15VG1GV3Ry?=
 =?utf-8?B?NzRaM05nYXRjVHR5dnlDQjlTdC9kWVJ4RWVPczBrand4MlMxZXZEMGk0Q1ZL?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+4vhl6PCoeihrJ4a4Ory2UHMQVJ6EBjnt0j+TARAYurM24w77W+CbKdGDEEkyjnWsWievVhzck7NrE86xIwy70ouG//3yAClnnzHk3bUUwxSN384nLaIdTafTCNfbLJPHZkjXNxwWbrRV9IW+yRZKAU3/SxBkzjJVFA8WYN4AQnIRSiZCIYMb0HF4JvEQkPi5qZzl3BESqADfN/G5PjUokF7SSzjT7zhrHzkQysGxQwQvGHOF+iBFEKofV60lsTjhEhhactlZrk36jyecAU9K/UMmNQOvTr7SYaSSDd7vIKWWEFq1vKRuhQgXgauBThU184KEtUSDUd+xXyuVyx+rE+w5I8T7uVVl7s+Ks34Sc2VPWIm6pBFiM+NyUcyobrBZZHY0vVxteri6d87Xxh+NNWAmytVaVTnyocX9dTrD7Po5UmXgmE77IMPzeJxrgOPBTdvSHddMcsKSjq2/FP1p3cd94lq9BCBaIIpz/yGIGXpKLxf1I1AG6l4TH0KXGk0rhzpHsrWTxpYBK3bEmWAJ5/00iQiUrlXw2VCH+eEeYsGquHO43KSzTMqg9SCfxAPKnhgenloTCdbB6IDro9m/0Hdc/F8YIIvPApYEb/vi6s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 696bf6d0-0bce-4f3b-17fa-08dc16874bb6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 11:35:52.8925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wrBH/KELxJT55aqJnpACP+7i2KwLEqOiGJ1KHpd9iBs2L8W4Kr8WyX8Iep2APO7kki5E9hlGQYTLOaLtJBCHwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4215
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_06,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401160092
X-Proofpoint-GUID: dzVr8JCeIb6nShxQxK1GFdRmtRdNh6Au
X-Proofpoint-ORIG-GUID: dzVr8JCeIb6nShxQxK1GFdRmtRdNh6Au

On 21/12/2023 13:22, Christoph Hellwig wrote:
> On Thu, Dec 21, 2023 at 01:18:33PM +0000, John Garry wrote:
>>> For SGL-capable devices that would be
>>> BIO_MAX_VECS, otherwise 1.
>> ok, but we would need to advertise that or whatever segment limit. A statx
>> field just for that seems a bit inefficient in terms of space.
> I'd rather not hard code BIO_MAX_VECS in the ABI, which suggest we
> want to export is as a field.  Network file systems also might have
> their own limits for one reason or another.

Hi Christoph,

I have been looking at this issue again and I am not sure if telling the 
user the max number of segments allowed is the best option. I’m worried 
that resultant atomic write unit max will be too small.

The background again is that we want to tell the user what the maximum 
atomic write unit size is, such that we can always guarantee to fit the 
write in a single bio. And there would be no iovec length or alignment 
rules.

The max segments value advertised would be min(queue max segments, 
BIO_MAX_VECS), so it would be 256 when the request queue is not limiting.

The worst case scenario for iovec layout (most inefficient) which the 
user could provide would be like .iov_base = 0x...0E00 and .iov_length = 
0x400, which would mean that we would have 2x pages and 2x DMA sg elems 
required for each 1024B-length iovec. I am assuming that we will still 
use the direct IO rule of LBS length and alignment.

As such, we then need to set atomic write unit max = min(queue max 
segments, BIO_MAX_VECS) * LBS. That would mean atomic write unit max 256 
* 512 = 128K (for 512B LBS). For a DMA controller of max segments 64, 
for example, then we would have 32K. These seem too low.

Alternative I'm thinking that we should just limit to 1x iovec always, 
and then atomic write unit max = (min(queue max segments, BIO_MAX_VECS) 
- 1) * PAGE_SIZE [ignoring first/last iovec contents]. It also makes 
support for non-enterprise NVMe drives more straightforward. If someone 
wants, they can introduce support for multi-iovec later, but it would 
prob require some more iovec length/alignment rules.

Please let me know your thoughts.

Thanks,
John


