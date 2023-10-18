Return-Path: <linux-fsdevel+bounces-659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C6C7CE06F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 16:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 652A3B2129A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 14:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774E337170;
	Wed, 18 Oct 2023 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fbcqyylw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RBHsLZhW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F334347DE
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 14:54:31 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F1094;
	Wed, 18 Oct 2023 07:54:29 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IEhq4f006984;
	Wed, 18 Oct 2023 14:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=VbM4eY1dhVpjnvwTbwgue5WrEggk2iileL0gg5hgJZM=;
 b=fbcqyylwSUKW2y9G8xj3jNb1kS//Sl181VLVwEi45ESQI+JxvpxSKkCIfz7mWFeDdAVh
 X+sf7Jw5Vl5CWwag/L1vV0xJbb3VyAjKycXgyVAAk1AxxRWvHMjUZFI85QglaV2Lip32
 Jn+6ixrnmZhv4WXeaaKe9fd/gY+a4khyb1f8/2eFRGcZtYa3iWsMqAtOBHVTFyLSZeM9
 NZbzeXlvTd9UN8u44vyYdbDePF/fLB083+qapVObNNbVlyn1PEUDAiMkPbobcL/onzOC
 HPPIBkBFRbg40znMbog5NpSbXOJVRJfjO9G+aB7+YqoMAvhafJL94zQoQOi+4SkJ8scy YQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1cys9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Oct 2023 14:53:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39IDXnDQ040672;
	Wed, 18 Oct 2023 14:53:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trfynv1mr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Oct 2023 14:53:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCqXxYvQfkyq+8wUhdgwW4aJZqUJTuceZnlDBHTyF4eyxTfBOHihSu/l3QjHl/aNX2oOEDVTGw7SI04/G07mPdJqfOBJJvwF2tjTKRdpso5a3p+pPqr+0hnSNTdLm2McyH1NBuk2YfqI72RqRdEZD9ixmFkMObe0r+4P2HMpmXATCZJzICd3cPao9LU45T7Aams+/POV0A08R6D5Az8vVF9svyZP1j5Qeq2DfvcEDdo3wZsRqkCJ/OqnW6fwSm2IVvdytbOGEajlUFBsFG68IA4xkmRObtcMUmWe4Qmt9YUnLqABszQLNEw8HUfJMFklwSnKU7E9PjrhP5NqQgS1VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbM4eY1dhVpjnvwTbwgue5WrEggk2iileL0gg5hgJZM=;
 b=iv/OtABxTzznJ/AIH1rP1arkUuHKPbBQzWJlIliZa9/DXqI9ElLtHAH5WLq0J0v9oeqoxyjOwOmxIClqSnQQpjvyjUaFGOEyXPS31AeWXBMSt33uqWtn/6+CTCMQg+CN4LwSqC5MMRQlEqyB0ZHpSlqI3iF+l+Fj3ZXNq8Zk77+6k7ym1CoMLGSgRWDk84YMjYpg9o1LGgTFxbyNJbjfPzfn0fEvl7Jv+pbIFuDecekcN/T40G9yS3QafG5SEez0bTnTG3gD3qjiydf0wD+7Pb5CcD9mtmeA7PekUksqVtl5Njv71mKwSMFFUC41UCeZsIqXl3qM1fNFUxrrJ0ArnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbM4eY1dhVpjnvwTbwgue5WrEggk2iileL0gg5hgJZM=;
 b=RBHsLZhWFGQg4ZBG1Y8h9DWXvh03hhPPoTlC5zCbe/MmwylnoOzKs3QULqgGIhdD/97hAXfBWzcpqpDqZsclDVEXWWGRTzPjNh4lW+ZZ4lfwSmFu8YIn/yDr28vWZaIE9n5aM3A+nBC7d9RcEBwhYUwBKXhN5XXIgsozye8cN7Y=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by LV3PR10MB7981.namprd10.prod.outlook.com (2603:10b6:408:21e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 14:53:36 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::a946:abb:59d6:e435]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::a946:abb:59d6:e435%4]) with mapi id 15.20.6863.043; Wed, 18 Oct 2023
 14:53:35 +0000
Message-ID: <f8fa68ec-e841-4187-a611-142f06c19e25@oracle.com>
Date: Wed, 18 Oct 2023 09:53:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] exportfs: make ->encode_fh() a mandatory method for
 NFS export
Content-Language: en-US
To: Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
        Jan Kara <jack@suse.cz>
Cc: Chuck Lever <chuck.lever@oracle.com>,
        Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki
 <salah.triki@gmail.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Steve French <sfrench@samba.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Evgeniy Dushistov <dushistov@mail.ru>
References: <20231018100000.2453965-1-amir73il@gmail.com>
 <20231018100000.2453965-4-amir73il@gmail.com>
 <b873e5f40babe559bd53fd730d13b358066942fa.camel@kernel.org>
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <b873e5f40babe559bd53fd730d13b358066942fa.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0209.namprd03.prod.outlook.com
 (2603:10b6:610:e4::34) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|LV3PR10MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 9301a63e-21fe-4a37-8719-08dbcfea018b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CKnsVr3oGE4fOWjpTe0DI5/wlTbL9cYCNrFz9v2GXE+ogsZjiihK/b4AVpwEmCU7yvluYfjaelQDqWDoYdvdaq4H7qG64Qp52VoQokWYxqA2sn9IAzlJG3wWTq7LoGcKZCnRGtGA/EWXW80I0jGbuyDKgXtCcnBpE+GoZPhMmlHyhL9rUKRHIn1iOHZcZr79QkWaIStwccf1dEogHjq8anVfIinyHP/XJP8QhQogsppvf5DTPKprQ3EaJbI2tqO4glX1KQ/OidfjbtB91+2N0YpKmdcIk8il/ICxKEdWlF6G3lshZtWdcF8b4NSHl6G1bNcF+kyhTxlYFevy3VPD0FBcYDVf+vkLJAr3Kr9sDa2mjSV/F54giGeuc9L4KVu81Amlh3vJxl4Qrplj4c0AWeH/Jt+GoCaKPKD1J4H7O9abHJ444bv02chgqy/WHb+Qggyor2rAzjOF4zDBKjwYgdkA4Q07RuHVPhxqrgh/R2NXDE58QP5xSqcyznV82rhDemsAC/7rp5HJcsuD2LMsekMkQJXxkQlcL0Ob3phLQsmWz+7Pb37fm2VB4Wcv7qk3Z69PQLOcTtCvZk4VElJDU3MV3Hegf8sdVJK0+ygIaHbxHr3Na0d8rJ6ekEsxlXQUB6ICopM4acwCJNnHV5zjbQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(36756003)(31686004)(6512007)(2616005)(54906003)(66476007)(316002)(66946007)(110136005)(66556008)(38100700002)(31696002)(86362001)(83380400001)(8936002)(26005)(4001150100001)(6666004)(6506007)(478600001)(2906002)(6486002)(30864003)(5660300002)(41300700001)(4326008)(7416002)(8676002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T2JDMXhSTVp6bndWM3pya2RqVFg0bWwwOXlJaVdQR3hIdHJKZmJSR0dKNzJH?=
 =?utf-8?B?eE8wNEt4L0pYUHFUOWpyVWNxRDM2M0t3a1VuRVEvV2JzNHRSNEFuNld1M2xM?=
 =?utf-8?B?MnluOXhBYTVJeVJ3S2YxUVZkemxncWY4VXVJVXFkc1NTbnhqbjB4eEIzQyto?=
 =?utf-8?B?QTdaZU53QlJIc3N3ZVFzeXVOSnRhaHRYNWhHS2JTTDdVUUVwdE1DMW4velJy?=
 =?utf-8?B?ODd4WmRqNVR2OWx4dW1HZGNyTkJOYTMvYnRkSW1FRTUwUUZOL0c5WXIrbW1T?=
 =?utf-8?B?Q2xiMExpTEFWY2N2c0tBNENBWno3WWt4WVNMS2hxYnpiYlZ4M0d6T2lZUlNR?=
 =?utf-8?B?bHliaDh6b1JMbkoyWDhpVkJyQi9pRHhjU3Rwck9IcEJhNSs3UmlZS2wxdWtJ?=
 =?utf-8?B?ZzhyVThBL0xiNjhIa2M3Rmt3RWo0cjFuM0I5b1lTVHlYRFljOWRWVjhsdG9Y?=
 =?utf-8?B?YW5CZlhkMFkzbzlscWw3bWxUV3gxSnVJN2wrQTZRNCs4RllnK0RpWjFuZmxl?=
 =?utf-8?B?RUxZb3JTNXNCYzVFd2VxejdqOFhpTDdRY3d1c0RMSlJOZVhBa1ZUR0x6YjRC?=
 =?utf-8?B?cHRQaG1Vb2UrcHYzS1pSZmJEeGJaeWlLa3EyVHlPYTZ3bk1JazJRbk1uRjFQ?=
 =?utf-8?B?bVhRWndKQnBuUU13ZEF3ZGM3WjliNUMyMm80eFJMSGFzWVU1SkI1dVJ0bk9E?=
 =?utf-8?B?RGNORWRGWWFhOEt4SUhaYkhaK28vVlVObmV3SXlybDZyWXA5cDZGc1R3U2ZZ?=
 =?utf-8?B?VFZ1MlRScGxxdndZZ1BlN1FGMUhtRE1wa2pjYmFLL2Q2UDZyQmpZMmJhYUpT?=
 =?utf-8?B?OXd5anIzWGhNOTBudTltU1JxVUk5SGhWK1ZvZ0VCdk4zSWEwd0RabDA0eExT?=
 =?utf-8?B?TmRqMFQzSjRmQURBbCs5N0MxRDZUeVBBK1gzSXpBRW9XMWl3aGpTUGg0R0hC?=
 =?utf-8?B?Q3ByeFZWek9DUzlDdmhjR2xSeDQvRHNSdUlXYzhQVFo2bXFxU2gvbGVoWkI1?=
 =?utf-8?B?aDUxOUVuYWNvd1lCSVdkOG9KRVd5NklTbHFhV1RaV1JPcmZSQzNsYUpzdTJn?=
 =?utf-8?B?TUpiM3ZuVEMxUVo3clNCREZIdWloMjQ0NWMvY1I0SGVpdC9Rb3dYUGZ4ZWZm?=
 =?utf-8?B?eG9vM3NReUNiRlBPeStaeEhWWUpMNzVnVG1URmk3NHZkaG1sUWxDeXNNd3lY?=
 =?utf-8?B?YzNxV2YzQVFYeGk4ZFEySEdDR2JoUHo4a1VpSmtSN0hTbzNycElnT3BwV2I3?=
 =?utf-8?B?eWQ1UkhvQmtweXJBUGQrSUtHVjN2NUN4b3pyRWw5WWVJdHVVYUZvTGtOOXhX?=
 =?utf-8?B?SGptSGYvb0VkaXdrb1d5bnlEUm5Ld0tKNjBQdXNQUzJhQWl2OTVCWGtCL1c4?=
 =?utf-8?B?dHRQVmRMTkZYZTc2NjhGL0tUcEVVS0pKcEFTeS9iSTNlMGJDc0JOR09Xd3RV?=
 =?utf-8?B?VUJVekxsSkxFM1N2MktueG52a2hEV3kzTGJuTWlrdXpyOXBDTTl6K0pKSHVF?=
 =?utf-8?B?dlRoQkNMdllKVS9RWGxVNjQ4MGdEM1B2VnppMEtDUzhPL0Q4bGkvWUxST21z?=
 =?utf-8?B?SUdzZHpKMU1YeVN5RXFXZ1VFRHFUR0duMWZsaXg2Q1ZLaEZ5VnhLTURiWGdi?=
 =?utf-8?B?Z29RaHAxMGxRak5HcWxCUnhYUkJaT0ZaV1cxQk92S1htcHJ1eHdQMzNsdWU1?=
 =?utf-8?B?M0JzeTVOeUZtRHR2cWdMeUdiL0NqWXUxWTg4aGlUTlJmOGtoNDdjUWsvVS9V?=
 =?utf-8?B?V01UVFVQZHR2MGw2bmxUbjgzZzdKSUdoTW5zMkg3MU0zbit3ZlJ1QmhVanlG?=
 =?utf-8?B?S3FmV0QwQzE0V3d2MnRITXA2TlN1MHFIZ3h0S2sxZHJQMWVha0MvSDNuejdP?=
 =?utf-8?B?SHN3RzlmTHdVNDFjUEZBQmZ6NmRKYmU5Q0NyRUw0NmZyL29SWHVTODBVRFJG?=
 =?utf-8?B?Y0JSUXhTSGxLQVRaaWdaWkdTcUo0bk9naXVEd2VHVVloT1RpQW9rc0xFWlVS?=
 =?utf-8?B?R0J0WFhaenZGL20raDZtcE8xSFViVnBMTy9yRC9KQS9qN2pTY0JBNWdxY2Zn?=
 =?utf-8?B?Z1hjTnZCVEM2QXJ0Rk9xME1qWnJZZmJuSGw3dU9FMEM5VUNwODZjdStKdEhw?=
 =?utf-8?B?ck8zRXlOaXpmRUVYMzdCbWpJWnVNbmRMVzg1Q0krQjZzU3A4SE5CNmlaY1or?=
 =?utf-8?B?WXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?NzFGTDZ2M1p1WVZNbytMWWYrQjhvOVIyQ0lCRTczZmNPRkZiV2hQb0dGMVZs?=
 =?utf-8?B?WTVGYWtXY0N0SS95NUpOMk9kZG5iOEdHMlhLN0ZtOUYzVElOekwwRWRzbkxk?=
 =?utf-8?B?ZWdFanliRDN1UElHSURsa0U2ODc1MlVxVXMvMkZUN3krbUtIVFk4bzNDa2ZU?=
 =?utf-8?B?d2tuSnlXSHBoMWNZaENUUDY2cnZZNEhtNVJCY0lJMURVZE9jYnYydWxZeVNE?=
 =?utf-8?B?aHNKUE0rc0NDaE1URS9oZGJRTkpSRGNLRXdTQWdNUkI2STFPbDQvbWlkMGF0?=
 =?utf-8?B?ZkVIdys3b3BVQm9lVy9TZ29tY2YrVlNFbnQxQWFDdXV3eFZyaDRTN2JuNk90?=
 =?utf-8?B?aFRMRTFPckVJSmpxd3VkNGdmSVZhd3h5QTY5bHVoRTNYWGwxSXYzV1BMM2dq?=
 =?utf-8?B?ckJZODdXczZpMG9EbWZsc0dJSUFrdFVBblA0RmZsTVNneFlaQit4S1BRNXpL?=
 =?utf-8?B?cGowblowZUpLdWJLU2ZNam1reUloa29tRVptT3dqNHRZeE5iNWt5dWFGVnhz?=
 =?utf-8?B?ZXFmbEg4eWJlRmkxUmhYcUFUc3ZvRmhlMExxSTZLc1hhdEw5RjJtRVM0RUgv?=
 =?utf-8?B?S1o1SzVjMkpxeDBEOXhFM0dRYkF0TzJkdU9uclNZeTlUU3p6MEw4NW10TE9i?=
 =?utf-8?B?QzVtV0FRT3JMMnpjZ1NZWDAyL2JBSkRYYnRJL3pvRWVUdGJRZDR0VjVFcGpo?=
 =?utf-8?B?amkzRUhkNTJhTnVKeU1Rb25FZnNmbW9sWnhiZlJXRVZHamtxVmtwMDd0SG5X?=
 =?utf-8?B?L0RIczY4TjVtU3ZGWXdlaUJsbUJXWjZHWUd4aHhMS2ZkQUhqSElQbE9TNFhY?=
 =?utf-8?B?NjNQZkg1dTFlM2FoeklLSnRydVMybFh6SGhrZW1pZzhmR29QNk5jSWp2Z3l3?=
 =?utf-8?B?andYSzIwby84cnoxYXlvQlU2STdlWTZFOU9KTVRKeHZJYzQ1Z2FrdnJ5WC9r?=
 =?utf-8?B?dzNEc2tMSDlVeXVsK2V1NXpuT3BqdTZFaFpobEl6Uml4VUM5cUkrNnQ0UEMw?=
 =?utf-8?B?TjRnTzFWVHliQk5xb0JwQ1RHNzNhN0JpdHFvaWZNNkNjL0E1OGxOSkdMSTR4?=
 =?utf-8?B?bzg2ZUJOYXhoandtY05jamhKUUVWWXdnNDdJWWErV1JaMjNqOGRKTXhNR3dR?=
 =?utf-8?B?MzNmbzJiZ0lzMTkwY255ZDNPaDBvQ0lFbUY5N1pqWTM4emVxMFVqaDcwOTYr?=
 =?utf-8?B?dCtVZm9nUjBXY0x0TVZjeHFMQ0ZaN01RcjUxZEFNSTVIMjVGV3FDNmFiWUhF?=
 =?utf-8?B?Y1RKci9YU09zcnpaRk1yV3ZEZVJaUlpYK2JOY1cyeDhzVi9VWmptSDlINWlF?=
 =?utf-8?B?Nlh2VWtmTXpwM0FETjlLSXpYZ0RROGpnOUpnV3JIdWxLSjFMYzhXeXVxaktW?=
 =?utf-8?B?OGM3c1Z2ZWJEeHZHU1lWYW5UMEs3VG55SUpkVzUxU2M0bTlSZmZSUm9hQzF1?=
 =?utf-8?B?aVhPVmVVVTYyYStQSjlXT0Q1SEErTXZ3eFNHeVQ3NXJtaHhmYiswVDZ6WTR1?=
 =?utf-8?B?RmtJUmxMZkhjK0hCcmNha0JWSDd3T3h0TXNGeVkzZCtqS1daSmFiQ0dSM3RY?=
 =?utf-8?Q?PXPRlCb5W1vxnY6K0haHog/OFFUvD8pXhXJcHtBLka5huk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9301a63e-21fe-4a37-8719-08dbcfea018b
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 14:53:35.9324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zx3AFkO8rCiQ/OhvibSw5HgUytLbUlFoggjr5dvePTC7Agi3DU39LJcBzoRcmGt6R1iOkNRGU/fGbqaJjt3tNdUYmXNPWLnhnhp5FYu0b5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_12,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180121
X-Proofpoint-GUID: a_J2s1HMYCSM3d7YLwRGgUOfgF3POIFp
X-Proofpoint-ORIG-GUID: a_J2s1HMYCSM3d7YLwRGgUOfgF3POIFp
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/18/23 9:16AM, Jeff Layton wrote:
> On Wed, 2023-10-18 at 12:59 +0300, Amir Goldstein wrote:
>> export_operations ->encode_fh() no longer has a default implementation to
>> encode FILEID_INO32_GEN* file handles.
>>
>> Rename the default helper for encoding FILEID_INO32_GEN* file handles to
>> generic_encode_ino32_fh() and convert the filesystems that used the
>> default implementation to use the generic helper explicitly.

Isn't it possible for some of these filesystems to be compiled without 
CONFIG_EXPORTFS set? Should exportfs.h define an null 
generic_encode_ino32_fh() in that case?

Shaggy

>>
>> This is a step towards allowing filesystems to encode non-decodeable file
>> handles for fanotify without having to implement any export_operations.
>>
>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>> ---
>>   Documentation/filesystems/nfs/exporting.rst |  7 ++-----
>>   Documentation/filesystems/porting.rst       |  9 +++++++++
>>   fs/affs/namei.c                             |  1 +
>>   fs/befs/linuxvfs.c                          |  1 +
>>   fs/efs/super.c                              |  1 +
>>   fs/erofs/super.c                            |  1 +
>>   fs/exportfs/expfs.c                         | 14 ++++++++------
>>   fs/ext2/super.c                             |  1 +
>>   fs/ext4/super.c                             |  1 +
>>   fs/f2fs/super.c                             |  1 +
>>   fs/fat/nfs.c                                |  1 +
>>   fs/jffs2/super.c                            |  1 +
>>   fs/jfs/super.c                              |  1 +
>>   fs/ntfs/namei.c                             |  1 +
>>   fs/ntfs3/super.c                            |  1 +
>>   fs/smb/client/export.c                      |  9 +++------
>>   fs/squashfs/export.c                        |  1 +
>>   fs/ufs/super.c                              |  1 +
>>   include/linux/exportfs.h                    |  4 +++-
>>   19 files changed, 39 insertions(+), 18 deletions(-)
>>
>> diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
>> index 4b30daee399a..de64d2d002a2 100644
>> --- a/Documentation/filesystems/nfs/exporting.rst
>> +++ b/Documentation/filesystems/nfs/exporting.rst
>> @@ -122,12 +122,9 @@ are exportable by setting the s_export_op field in the struct
>>   super_block.  This field must point to a "struct export_operations"
>>   struct which has the following members:
>>   
>> -  encode_fh (optional)
>> +  encode_fh (mandatory)
>>       Takes a dentry and creates a filehandle fragment which may later be used
>> -    to find or create a dentry for the same object.  The default
>> -    implementation creates a filehandle fragment that encodes a 32bit inode
>> -    and generation number for the inode encoded, and if necessary the
>> -    same information for the parent.
>> +    to find or create a dentry for the same object.
>>   
>>     fh_to_dentry (mandatory)
>>       Given a filehandle fragment, this should find the implied object and
>> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
>> index 4d05b9862451..197ef78a5014 100644
>> --- a/Documentation/filesystems/porting.rst
>> +++ b/Documentation/filesystems/porting.rst
>> @@ -1045,3 +1045,12 @@ filesystem type is now moved to a later point when the devices are closed:
>>   As this is a VFS level change it has no practical consequences for filesystems
>>   other than that all of them must use one of the provided kill_litter_super(),
>>   kill_anon_super(), or kill_block_super() helpers.
>> +
>> +---
>> +
>> +**mandatory**
>> +
>> +export_operations ->encode_fh() no longer has a default implementation to
>> +encode FILEID_INO32_GEN* file handles.
>> +Fillesystems that used the default implementation may use the generic helper
>> +generic_encode_ino32_fh() explicitly.
>> diff --git a/fs/affs/namei.c b/fs/affs/namei.c
>> index 2fe4a5832fcf..d6b9758ee23d 100644
>> --- a/fs/affs/namei.c
>> +++ b/fs/affs/namei.c
>> @@ -568,6 +568,7 @@ static struct dentry *affs_fh_to_parent(struct super_block *sb, struct fid *fid,
>>   }
>>   
>>   const struct export_operations affs_export_ops = {
>> +	.encode_fh = generic_encode_ino32_fh,
>>   	.fh_to_dentry = affs_fh_to_dentry,
>>   	.fh_to_parent = affs_fh_to_parent,
>>   	.get_parent = affs_get_parent,
>> diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
>> index 9a16a51fbb88..410dcaffd5ab 100644
>> --- a/fs/befs/linuxvfs.c
>> +++ b/fs/befs/linuxvfs.c
>> @@ -96,6 +96,7 @@ static const struct address_space_operations befs_symlink_aops = {
>>   };
>>   
>>   static const struct export_operations befs_export_operations = {
>> +	.encode_fh	= generic_encode_ino32_fh,
>>   	.fh_to_dentry	= befs_fh_to_dentry,
>>   	.fh_to_parent	= befs_fh_to_parent,
>>   	.get_parent	= befs_get_parent,
>> diff --git a/fs/efs/super.c b/fs/efs/super.c
>> index b287f47c165b..f17fdac76b2e 100644
>> --- a/fs/efs/super.c
>> +++ b/fs/efs/super.c
>> @@ -123,6 +123,7 @@ static const struct super_operations efs_superblock_operations = {
>>   };
>>   
>>   static const struct export_operations efs_export_ops = {
>> +	.encode_fh	= generic_encode_ino32_fh,
>>   	.fh_to_dentry	= efs_fh_to_dentry,
>>   	.fh_to_parent	= efs_fh_to_parent,
>>   	.get_parent	= efs_get_parent,
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 3700af9ee173..edbe07a24156 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -626,6 +626,7 @@ static struct dentry *erofs_get_parent(struct dentry *child)
>>   }
>>   
>>   static const struct export_operations erofs_export_ops = {
>> +	.encode_fh = generic_encode_ino32_fh,
>>   	.fh_to_dentry = erofs_fh_to_dentry,
>>   	.fh_to_parent = erofs_fh_to_parent,
>>   	.get_parent = erofs_get_parent,
>> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
>> index 9ee205df8fa7..30da4539e257 100644
>> --- a/fs/exportfs/expfs.c
>> +++ b/fs/exportfs/expfs.c
>> @@ -343,20 +343,21 @@ static int get_name(const struct path *path, char *name, struct dentry *child)
>>   }
>>   
>>   /**
>> - * export_encode_fh - default export_operations->encode_fh function
>> + * generic_encode_ino32_fh - generic export_operations->encode_fh function
>>    * @inode:   the object to encode
>> - * @fid:     where to store the file handle fragment
>> + * @fh:      where to store the file handle fragment
>>    * @max_len: maximum length to store there
>>    * @parent:  parent directory inode, if wanted
>>    *
>> - * This default encode_fh function assumes that the 32 inode number
>> + * This generic encode_fh function assumes that the 32 inode number
>>    * is suitable for locating an inode, and that the generation number
>>    * can be used to check that it is still valid.  It places them in the
>>    * filehandle fragment where export_decode_fh expects to find them.
>>    */
>> -static int export_encode_fh(struct inode *inode, struct fid *fid,
>> -		int *max_len, struct inode *parent)
>> +int generic_encode_ino32_fh(struct inode *inode, __u32 *fh, int *max_len,
>> +			    struct inode *parent)
>>   {
>> +	struct fid *fid = (void *)fh;
>>   	int len = *max_len;
>>   	int type = FILEID_INO32_GEN;
>>   
>> @@ -380,6 +381,7 @@ static int export_encode_fh(struct inode *inode, struct fid *fid,
>>   	*max_len = len;
>>   	return type;
>>   }
>> +EXPORT_SYMBOL_GPL(generic_encode_ino32_fh);
>>   
>>   /**
>>    * exportfs_encode_inode_fh - encode a file handle from inode
>> @@ -402,7 +404,7 @@ int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
>>   	if (nop && nop->encode_fh)
>>   		return nop->encode_fh(inode, fid->raw, max_len, parent);
>>   
>> -	return export_encode_fh(inode, fid, max_len, parent);
>> +	return -EOPNOTSUPP;
>>   }
>>   EXPORT_SYMBOL_GPL(exportfs_encode_inode_fh);
>>   
>> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
>> index aaf3e3e88cb2..b9f158a34997 100644
>> --- a/fs/ext2/super.c
>> +++ b/fs/ext2/super.c
>> @@ -397,6 +397,7 @@ static struct dentry *ext2_fh_to_parent(struct super_block *sb, struct fid *fid,
>>   }
>>   
>>   static const struct export_operations ext2_export_ops = {
>> +	.encode_fh = generic_encode_ino32_fh,
>>   	.fh_to_dentry = ext2_fh_to_dentry,
>>   	.fh_to_parent = ext2_fh_to_parent,
>>   	.get_parent = ext2_get_parent,
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index dbebd8b3127e..c44db1915437 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -1646,6 +1646,7 @@ static const struct super_operations ext4_sops = {
>>   };
>>   
>>   static const struct export_operations ext4_export_ops = {
>> +	.encode_fh = generic_encode_ino32_fh,
>>   	.fh_to_dentry = ext4_fh_to_dentry,
>>   	.fh_to_parent = ext4_fh_to_parent,
>>   	.get_parent = ext4_get_parent,
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index a8c8232852bb..60cfa11f65bf 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -3282,6 +3282,7 @@ static struct dentry *f2fs_fh_to_parent(struct super_block *sb, struct fid *fid,
>>   }
>>   
>>   static const struct export_operations f2fs_export_ops = {
>> +	.encode_fh = generic_encode_ino32_fh,
>>   	.fh_to_dentry = f2fs_fh_to_dentry,
>>   	.fh_to_parent = f2fs_fh_to_parent,
>>   	.get_parent = f2fs_get_parent,
>> diff --git a/fs/fat/nfs.c b/fs/fat/nfs.c
>> index 3626eb585a98..c52e63e10d35 100644
>> --- a/fs/fat/nfs.c
>> +++ b/fs/fat/nfs.c
>> @@ -279,6 +279,7 @@ static struct dentry *fat_get_parent(struct dentry *child_dir)
>>   }
>>   
>>   const struct export_operations fat_export_ops = {
>> +	.encode_fh	= generic_encode_ino32_fh,
>>   	.fh_to_dentry   = fat_fh_to_dentry,
>>   	.fh_to_parent   = fat_fh_to_parent,
>>   	.get_parent     = fat_get_parent,
>> diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
>> index 7ea37f49f1e1..f99591a634b4 100644
>> --- a/fs/jffs2/super.c
>> +++ b/fs/jffs2/super.c
>> @@ -150,6 +150,7 @@ static struct dentry *jffs2_get_parent(struct dentry *child)
>>   }
>>   
>>   static const struct export_operations jffs2_export_ops = {
>> +	.encode_fh = generic_encode_ino32_fh,
>>   	.get_parent = jffs2_get_parent,
>>   	.fh_to_dentry = jffs2_fh_to_dentry,
>>   	.fh_to_parent = jffs2_fh_to_parent,
>> diff --git a/fs/jfs/super.c b/fs/jfs/super.c
>> index 2e2f7f6d36a0..2cc2632f3c47 100644
>> --- a/fs/jfs/super.c
>> +++ b/fs/jfs/super.c
>> @@ -896,6 +896,7 @@ static const struct super_operations jfs_super_operations = {
>>   };
>>   
>>   static const struct export_operations jfs_export_operations = {
>> +	.encode_fh	= generic_encode_ino32_fh,
>>   	.fh_to_dentry	= jfs_fh_to_dentry,
>>   	.fh_to_parent	= jfs_fh_to_parent,
>>   	.get_parent	= jfs_get_parent,
>> diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
>> index ab44f2db533b..d7498ddc4a72 100644
>> --- a/fs/ntfs/namei.c
>> +++ b/fs/ntfs/namei.c
>> @@ -384,6 +384,7 @@ static struct dentry *ntfs_fh_to_parent(struct super_block *sb, struct fid *fid,
>>    * and due to using iget() whereas NTFS needs ntfs_iget().
>>    */
>>   const struct export_operations ntfs_export_ops = {
>> +	.encode_fh	= generic_encode_ino32_fh,
>>   	.get_parent	= ntfs_get_parent,	/* Find the parent of a given
>>   						   directory. */
>>   	.fh_to_dentry	= ntfs_fh_to_dentry,
>> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
>> index 5661a363005e..661ffb5aa1e0 100644
>> --- a/fs/ntfs3/super.c
>> +++ b/fs/ntfs3/super.c
>> @@ -789,6 +789,7 @@ static int ntfs_nfs_commit_metadata(struct inode *inode)
>>   }
>>   
>>   static const struct export_operations ntfs_export_ops = {
>> +	.encode_fh = generic_encode_ino32_fh,
>>   	.fh_to_dentry = ntfs_fh_to_dentry,
>>   	.fh_to_parent = ntfs_fh_to_parent,
>>   	.get_parent = ntfs3_get_parent,
>> diff --git a/fs/smb/client/export.c b/fs/smb/client/export.c
>> index 37c28415df1e..834e9c9197b4 100644
>> --- a/fs/smb/client/export.c
>> +++ b/fs/smb/client/export.c
>> @@ -41,13 +41,10 @@ static struct dentry *cifs_get_parent(struct dentry *dentry)
>>   }
>>   
>>   const struct export_operations cifs_export_ops = {
>> +	.encode_fh = generic_encode_ino32_fh,
>>   	.get_parent = cifs_get_parent,
>> -/*	Following five export operations are unneeded so far and can default:
>> -	.get_dentry =
>> -	.get_name =
>> -	.find_exported_dentry =
>> -	.decode_fh =
>> -	.encode_fs =  */
>> +/*	Following export operations are mandatory for NFS export support:
>> +	.fh_to_dentry = */
>>   };
>>   
>>   #endif /* CONFIG_CIFS_NFSD_EXPORT */
>> diff --git a/fs/squashfs/export.c b/fs/squashfs/export.c
>> index 723763746238..62972f0ff868 100644
>> --- a/fs/squashfs/export.c
>> +++ b/fs/squashfs/export.c
>> @@ -173,6 +173,7 @@ __le64 *squashfs_read_inode_lookup_table(struct super_block *sb,
>>   
>>   
>>   const struct export_operations squashfs_export_ops = {
>> +	.encode_fh = generic_encode_ino32_fh,
>>   	.fh_to_dentry = squashfs_fh_to_dentry,
>>   	.fh_to_parent = squashfs_fh_to_parent,
>>   	.get_parent = squashfs_get_parent
>> diff --git a/fs/ufs/super.c b/fs/ufs/super.c
>> index 23377c1baed9..a480810cd4e3 100644
>> --- a/fs/ufs/super.c
>> +++ b/fs/ufs/super.c
>> @@ -137,6 +137,7 @@ static struct dentry *ufs_get_parent(struct dentry *child)
>>   }
>>   
>>   static const struct export_operations ufs_export_ops = {
>> +	.encode_fh = generic_encode_ino32_fh,
>>   	.fh_to_dentry	= ufs_fh_to_dentry,
>>   	.fh_to_parent	= ufs_fh_to_parent,
>>   	.get_parent	= ufs_get_parent,
>> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
>> index 5b3c9f30b422..6b6e01321405 100644
>> --- a/include/linux/exportfs.h
>> +++ b/include/linux/exportfs.h
>> @@ -235,7 +235,7 @@ extern int exportfs_encode_fh(struct dentry *dentry, struct fid *fid,
>>   
>>   static inline bool exportfs_can_encode_fid(const struct export_operations *nop)
>>   {
>> -	return nop;
>> +	return nop && nop->encode_fh;
>>   }
>>   
>>   static inline bool exportfs_can_decode_fh(const struct export_operations *nop)
>> @@ -279,6 +279,8 @@ extern struct dentry *exportfs_decode_fh(struct vfsmount *mnt, struct fid *fid,
>>   /*
>>    * Generic helpers for filesystems.
>>    */
>> +int generic_encode_ino32_fh(struct inode *inode, __u32 *fh, int *max_len,
>> +			    struct inode *parent);
>>   extern struct dentry *generic_fh_to_dentry(struct super_block *sb,
>>   	struct fid *fid, int fh_len, int fh_type,
>>   	struct inode *(*get_inode) (struct super_block *sb, u64 ino, u32 gen));
> 
> Looks straightforward.
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

