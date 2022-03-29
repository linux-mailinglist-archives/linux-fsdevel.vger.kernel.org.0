Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A2B4EB56E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 23:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbiC2VrZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 17:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbiC2VrY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 17:47:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C43558804;
        Tue, 29 Mar 2022 14:45:41 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22TKmjhP001224;
        Tue, 29 Mar 2022 21:45:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qAmU4ahboaDoQyXDLmQPmPrl5Z/6UGZUJzgy2vEnywE=;
 b=TgTck1ocXzFCe6Wp+y92gsrQmGEHNLKMEIVh2tdg2p9CtVoBK4FZbHMomCupoW02S7lH
 xG5j/YAoRfPS/HI9WQb4V7VotYb+K6uPlWgAkiOn9w8Iqkk7Ph/W/jeQtt69LFHyFPnc
 XlZggK7RkB38m5IFvwSfdMeLJlOHh538zFSA9v9Bz84CBWYIJ/RJmTDviulBi8TvxIrX
 DycdVC1WjQopU39QdRjCQ2RcCtrNQhu4FjDG90kCqsJIJBGQ/9Gjkjn2+UkjcNQWYb8u
 LzCMlXa84JoWtAjFrKUeSF2xSpSFROe5VJoCJlwpto7FLPS8WJztBMHiY5wCqzmkOTSy Kg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1s8cqq75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 21:45:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22TLg0a5105629;
        Tue, 29 Mar 2022 21:45:36 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3020.oracle.com with ESMTP id 3f1v9fj7gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 21:45:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+NEKCDRzLfGNk0iqUW0vxSf/CzNWN2wvFRuJlXLDBEZgRjltF5vAKBeJRM6Nfkigt7iXrHkJcuQMy934aaWP3pve09L2/Jry9CJESeb4QlZfsLp8XIRIM7JZELBwNcLGLxxamuxOPeMOBBzPh+0o35gM36VmQ0EDSCypr/VkgZPSlHxyx+sZ8spYbLDOnBWSCXLu03eyqgsNrp/BunVXj9z6dMxUkBur4kbQ4s/x7c8C21sO3qhCB50dHcpqlek2jDugthbc+V3aU6pxazI0pLyudOs2ivpKWSniL9I/HdSFW+gvKzHum7byWz+Toz+zX8SPOHAKMC6NIEh8tEHeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAmU4ahboaDoQyXDLmQPmPrl5Z/6UGZUJzgy2vEnywE=;
 b=RhUw3WC9fARkTg0X2A+sifL7n8Vj+vILB2XkcydpJVBLUcRoplD+gTkKZesbVpI1m135+l0F8p7wWRoZqIlRm+vVVjsFkr497vvxyLDNTl7vLAs7Nb7gnf88+pHgYRwMv39ymUcJzoepIpvbrns1Ke9Pr4olruLwexankZW2XfCWZEBZ/Ewrx3Y4LgVqRCKimosWpkocebtVYb4Tl0P++oJh/AejP+zpwexMcrjwAtAiyomr+tYGTmNz+Gy9BfBJyWKDzkSg1cgkMn9n9eeRxeGAZloGrFB3Ao3uE1p6DX8YqWdgMbwmyrJNk+Y4Gu7O4mMx1yBr7h+GEVfmnltb6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAmU4ahboaDoQyXDLmQPmPrl5Z/6UGZUJzgy2vEnywE=;
 b=bjh2xw2rUI6gdLOTzvX3EINGwv3HO3pxSfTFn/82sbc782yh+fX1CpkYlvAw/MdkkmrP8RCiO+UdXOyHOGtEKld8yc5vPLAp7l3rjIUii1Dy/qQ1Dj3GeLXYOEZ8axT/4O19oiL0i4hYuE4cRhBJWyo7OUk1fU7na9/oPut5GPs=
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by CO6PR10MB5394.namprd10.prod.outlook.com (2603:10b6:5:35d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Tue, 29 Mar
 2022 21:45:32 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::ec41:df7c:ccb0:22b4]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::ec41:df7c:ccb0:22b4%7]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 21:45:31 +0000
Message-ID: <593317f2-b4d6-eac1-7886-48a7271871e8@oracle.com>
Date:   Tue, 29 Mar 2022 14:45:28 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH RFC v18 02/11] NFSD: Add courtesy client state, macro and
 spinlock to support courteous server
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1648182891-32599-1-git-send-email-dai.ngo@oracle.com>
 <1648182891-32599-3-git-send-email-dai.ngo@oracle.com>
 <20220329154750.GE29634@fieldses.org>
 <612ef738-20f6-55f0-1677-cc035ba2fd0d@oracle.com>
 <20220329163011.GG29634@fieldses.org>
 <5cddab8d-dd92-6863-78fd-a4608a722927@oracle.com>
 <20220329183916.GC32217@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220329183916.GC32217@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0044.namprd11.prod.outlook.com
 (2603:10b6:806:d0::19) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5817eafa-6d4d-4ab3-6c16-08da11cd72a1
X-MS-TrafficTypeDiagnostic: CO6PR10MB5394:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB53945ADC6CB5BB68E6498191871E9@CO6PR10MB5394.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zq3h5r4Yytjy5NfuswOT85kg4VOmx5y5bjZ9ciIacA99kX4RHQAalFRLJvd/NUQ1aGFQdfo9ixT7Ir+7jnmasq4p4HpwqrLqY47v4W8VoSAg5rj8mDNsoSQduePXKPw9l/SO+0WfR604cEBtVMt186k/4H2KA7agHBj2nfcmtC2IlU87Sj5JuX09RZ+3rWMOpu/ZuSTx2t5sQQTxFYTy3japAjkHleAQ7CPWGMS5ETK+Mu8+9a/Db1LUf2RIIobIHEfA1+59O3B0N+Na7bKzCAO0y1F1K+lAuVvQgyYxPXt7cOmJYZk6PuQa4okCJ9TkhBEueF9VrM8hFfC8tyyYsdjt+uI/3ZjSVTslDM9FcqcGLJKE5fBSuTlq/AymlqxDNpVaoM/8gpNFgGiya+mBVigmGir582rYW+FlHxsYYalc2lmRAI0dpByRcZWG3zNec8LvBT7xD9L2tsmpvibhTSIObFcRXoqARsGxE1xQTM6LId8dPdViEH161GvH3lesaSHMYsBo+usd+y0digWOMHtdC9qDBlvyp3SQ8SY6PusuT9MXKuC6t6+1AcOrEfeAlzho847F8fgzrOxJINFiMLANCeE8FZQhm+LFDfQ1PQPv8bDRHyhd/Igl0PAs6/nay+N37iQLwFZmhJDJtCOA5QBl8+S2t6oWFRLgUmWlj2Nxms3p760f5KIgKLmfZ31KLqRHKd+QATooOIeZBT9LmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(86362001)(53546011)(8936002)(66556008)(6506007)(4326008)(8676002)(66946007)(83380400001)(5660300002)(66476007)(6916009)(2616005)(6512007)(186003)(316002)(31686004)(26005)(508600001)(36756003)(6486002)(31696002)(2906002)(38100700002)(9686003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1JqZ0J1a2NiNGlrZkkxSm03MFY2ZVBXYnVIa3NyT3NBcWpLNHUwM2JFOGlm?=
 =?utf-8?B?WTRKbnZhTUo4ZzlvSWttekpPMjlVc2svVjF2RW54SXNCWDlra0Ftb2ltRkg0?=
 =?utf-8?B?bnFLVmZpZjM4SXZTZ29FTldBNHI3SmFRY1FiNk56RmIzK3VPUTRoMVVMTFVz?=
 =?utf-8?B?L2MxU0VuU1VpYndlVXdiSUx5MG45OU8zZEhaWnRQTlBFZ0JaNXE1UUhLdGt1?=
 =?utf-8?B?d2NmS3NOVWxWTWErK3BpcFRmN2VpeGF5Sk5PTG5NM0JVTHZ0UWRxQjlaaEta?=
 =?utf-8?B?cUxXU29pai9OVXlQaE9wbUVCV0VscDNYQ2xkempXNENvUTNqaXdOc09MODAw?=
 =?utf-8?B?RHp5UGVvUjhlazluNHR5TzlJTmIyanc2c29aWkljeUEwZWs3dkxkWnVSZU1l?=
 =?utf-8?B?ajF4MWo1Q1llUDlMRnZVWVJaRnV2SDFxTmNiVWFjUzVIeTlEbWJNL0JIdFh1?=
 =?utf-8?B?dE5zZUMxVUtnSklsZ2pybEZyUXV4b3F4WW5uTTVlTFV0U3Mvd2dmZVJXVlBy?=
 =?utf-8?B?OWFtMlNIaTZpRGNJRHQ1cjVsVWhSWTNSRHowbjBVZmpySE5yeUhvUmdJQkFS?=
 =?utf-8?B?SHpzcHlBMkkrQmh5djl5RWg1ZUYyZWlPWm1ub3NZdWdzOWhTZk9rV0dHZDNl?=
 =?utf-8?B?SlBueWNqNGE3ZzZFYmsxRDVKOHZMek5Jb1hnWFgwSEI1YTZaUlJNcHdsb0NJ?=
 =?utf-8?B?T2JpSGtLNTFnTjJocTByM3VIeGRxZm9MMWtMYVhHZXRwSytWd3BMb0dEdDBZ?=
 =?utf-8?B?NmVxQU1ya1EvNm5oM2o4WUIrQ3JxMVc2MHgydDBVb0poLzNTczR0QWFJaSt1?=
 =?utf-8?B?Q1Y3NlYrWkh1VTlBZkhBOXZCQkIrMFVnZWtDZVhVQkwrSjgrTzZVV0tNV2xM?=
 =?utf-8?B?V0dyTVRrbnRJQnRQMlpQLzh2RUJlRG01Q3dScktXOXJ3SS9qbTYxbEFzMXB5?=
 =?utf-8?B?bFJNZUQ2Y2hLVjVObllWSU5yZ21Wa2ZqOENvZ3hMZldHQS9YcENoZ2JxZVN1?=
 =?utf-8?B?TzdhSVBlUlRSZEZ0UTFjOVpWQ3dXQUN3Yi9Id2hGbWtMa1VkWkFaTkYzN1Vl?=
 =?utf-8?B?MEtFQ1lzQk1xd29vajBnTGR2czI1YkdSNHYwcE1aZm4yUDBSSTZhb2I5NTIz?=
 =?utf-8?B?S2JxbTZGUEI4clZTeHp4QWxzR0FJQkFVR2tZVFMwYUVBa0ROR2dNYVNBSVZJ?=
 =?utf-8?B?N2hjN0Q4TzlBLzc0dFhsNXBka2pQaFpoWW9oOEx0NXFuR2FrdFdFRW5ZWXZY?=
 =?utf-8?B?NFF4cVNnQllCM0VKdTRDamFmcHpkR3JQcWlwbSt6N1NpUXJCdE5CTnZNMWVR?=
 =?utf-8?B?N0Q1QThGTi9DSUV5Y2srTzN4anc4WlQzZEhCdGROY1hOc0hYd0g0Yi9nWGJN?=
 =?utf-8?B?dnoyZ1diV0dGekd5NUdSeGhPN1BiNmVsMFA0Z0lUT2xCTUlRMVdKVzRrYVpF?=
 =?utf-8?B?bmZvb0o5eUhXbTFhZVFPQ3o3QWxFNXNmc3FOTldJMzgzc1ZqQjhDTUZxR0Zn?=
 =?utf-8?B?eWpQQTUxUEpsQ0lueERDOXZWM1FjY2dsK1JpK1VPVlQ4cFJoa2pjbWlWSlBh?=
 =?utf-8?B?ZFgxS1FSUXBjZjMzZlBnaFJxbkUxdDdQTEtKNWNSMm5Jd0dTL2M2eWMrOEMv?=
 =?utf-8?B?MWZOby8zV2JnOEVteFVSRDEramx4VU5jNERvSXgwVzdURFJQU3lmbnBobXBh?=
 =?utf-8?B?cWF5cWE0YVB2bFJyc1VyZmdmcGd3LytLUk9LN25OSnhteGU2Ny9VanFTM2Vx?=
 =?utf-8?B?UnMxR1NwYUZxckQzcjdCdTJZbloycXIySVp4ZjI5M29EYmRZMmVqOElNSlhI?=
 =?utf-8?B?WXFTMmFXcnRrakE3VzJWOG9iU2NBMngrVnVoK3hJQStRd1JyMENCUWxKOHNv?=
 =?utf-8?B?TnIwRzdOd1BicVJ0bzZCNnBZa0NBWERReDhVcnRqdWFqa2VqeWtzTzF0d3Ax?=
 =?utf-8?B?RjFrcU1va014dTg3VkhoODVKUXhzTzBEVVlHZGpGWmdCNEMwbEdQMUZKWFVq?=
 =?utf-8?B?QnhNcDczQlhiZ0hPR2g4eUl2SktjdGpFelo2TjJFb2J4WDBEcW4vWXlmRDRu?=
 =?utf-8?B?d2o3UW9XYzRFTksxMjZVT2VyeG5DOVNRR21xNkRwdCtYNmZ6ajZzaHpxUmcv?=
 =?utf-8?B?ZDAvUjhKWEVFd2huRWdoUHh4N3JLc2NEdHhEZFpKUnlTZDNzaDREOUhDK2RY?=
 =?utf-8?B?RFdya1dGcHFNZVBqdzVyMTY3K2F4NkhRYnBIenJMNTkvbFVqdk1WMG96N0Fk?=
 =?utf-8?B?RHRYN1phSnlBajRudTg5WmdSYmVIS0JyQzErVWNTSGJFNFcvbkEvRy8zOEhy?=
 =?utf-8?B?MVE0REJCRGlBTkdRZnp5alVVZ250ZnZrUU1vVTNJZy9FcTRHdTdEQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5817eafa-6d4d-4ab3-6c16-08da11cd72a1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 21:45:31.6745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfkVHHM+H6uFqyFtD8aNoU/LihwXPYfuE2zFKcICm7OjaP8HqN+y/MVoD5KtBE8+V0Qknyum7Ad8gJL9IAXxsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5394
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203290117
X-Proofpoint-GUID: Bi54lfmWdfbPr0SgZnrfAMo-ZzMgQKLz
X-Proofpoint-ORIG-GUID: Bi54lfmWdfbPr0SgZnrfAMo-ZzMgQKLz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 3/29/22 11:39 AM, J. Bruce Fields wrote:
> On Tue, Mar 29, 2022 at 11:19:51AM -0700, dai.ngo@oracle.com wrote:
>> On 3/29/22 9:30 AM, J. Bruce Fields wrote:
>>> On Tue, Mar 29, 2022 at 09:20:02AM -0700, dai.ngo@oracle.com wrote:
>>>> On 3/29/22 8:47 AM, J. Bruce Fields wrote:
>>>>> On Thu, Mar 24, 2022 at 09:34:42PM -0700, Dai Ngo wrote:
>>>>>> Update nfs4_client to add:
>>>>>>   . cl_cs_client_state: courtesy client state
>>>>>>   . cl_cs_lock: spinlock to synchronize access to cl_cs_client_state
>>>>>>   . cl_cs_list: list used by laundromat to process courtesy clients
>>>>>>
>>>>>> Modify alloc_client to initialize these fields.
>>>>>>
>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>> ---
>>>>>>   fs/nfsd/nfs4state.c |  2 ++
>>>>>>   fs/nfsd/nfsd.h      |  1 +
>>>>>>   fs/nfsd/state.h     | 33 +++++++++++++++++++++++++++++++++
>>>>>>   3 files changed, 36 insertions(+)
>>>>>>
>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>>> index 234e852fcdfa..a65d59510681 100644
>>>>>> --- a/fs/nfsd/nfs4state.c
>>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>>> @@ -2009,12 +2009,14 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
>>>>>>   	INIT_LIST_HEAD(&clp->cl_delegations);
>>>>>>   	INIT_LIST_HEAD(&clp->cl_lru);
>>>>>>   	INIT_LIST_HEAD(&clp->cl_revoked);
>>>>>> +	INIT_LIST_HEAD(&clp->cl_cs_list);
>>>>>>   #ifdef CONFIG_NFSD_PNFS
>>>>>>   	INIT_LIST_HEAD(&clp->cl_lo_states);
>>>>>>   #endif
>>>>>>   	INIT_LIST_HEAD(&clp->async_copies);
>>>>>>   	spin_lock_init(&clp->async_lock);
>>>>>>   	spin_lock_init(&clp->cl_lock);
>>>>>> +	spin_lock_init(&clp->cl_cs_lock);
>>>>>>   	rpc_init_wait_queue(&clp->cl_cb_waitq, "Backchannel slot table");
>>>>>>   	return clp;
>>>>>>   err_no_hashtbl:
>>>>>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>>>>>> index 4fc1fd639527..23996c6ca75e 100644
>>>>>> --- a/fs/nfsd/nfsd.h
>>>>>> +++ b/fs/nfsd/nfsd.h
>>>>>> @@ -336,6 +336,7 @@ void		nfsd_lockd_shutdown(void);
>>>>>>   #define COMPOUND_ERR_SLACK_SPACE	16     /* OP_SETATTR */
>>>>>>   #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
>>>>>> +#define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
>>>>>>   /*
>>>>>>    * The following attributes are currently not supported by the NFSv4 server:
>>>>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>>>>> index 95457cfd37fc..40e390abc842 100644
>>>>>> --- a/fs/nfsd/state.h
>>>>>> +++ b/fs/nfsd/state.h
>>>>>> @@ -283,6 +283,35 @@ struct nfsd4_sessionid {
>>>>>>   #define HEXDIR_LEN     33 /* hex version of 16 byte md5 of cl_name plus '\0' */
>>>>>>   /*
>>>>>> + * CLIENT_  CLIENT_ CLIENT_
>>>>>> + * COURTESY EXPIRED RECONNECTED      Meaning                  Where set
>>>>>> + * -----------------------------------------------------------------------------
>>>>>> + * | false | false | false | Confirmed, active    | Default                    |
>>>>>> + * |---------------------------------------------------------------------------|
>>>>>> + * | true  | false | false | Courtesy state.      | nfs4_get_client_reaplist   |
>>>>>> + * |       |       |       | Lease/lock/share     |                            |
>>>>>> + * |       |       |       | reservation conflict |                            |
>>>>>> + * |       |       |       | can cause Courtesy   |                            |
>>>>>> + * |       |       |       | client to be expired |                            |
>>>>>> + * |---------------------------------------------------------------------------|
>>>>>> + * | false | true  | false | Courtesy client to be| nfs4_laundromat            |
>>>>>> + * |       |       |       | expired by Laundromat| nfsd4_lm_lock_expired      |
>>>>>> + * |       |       |       | due to conflict     | nfsd4_discard_courtesy_clnt |
>>>>>> + * |       |       |       |                      | nfsd4_expire_courtesy_clnt |
>>>>>> + * |---------------------------------------------------------------------------|
>>>>>> + * | false | false | true  | Courtesy client      | nfsd4_courtesy_clnt_expired|
>>>>>> + * |       |       |       | reconnected,         |                            |
>>>>>> + * |       |       |       | becoming active      |                            |
>>>>>> + * -----------------------------------------------------------------------------
>>> By the way, where is a client returned to the normal (0) state?  That
>>> has to happen at some point.
>> For 4.1 courtesy client reconnects is detected in nfsd4_sequence,
>> nfsd4_bind_conn_to_session.
> Those are the places where NFSD54_CLIENT_RECONNECTED is set, which isn't
> the question I asked.
>>> Why are RECONNECTED clients discarded in so many cases?  (E.g. whenever
>>> a bind_conn_to_session fails).
>> find_in_sessionid_hashtbl: we discard the courtesy client when it
>> reconnects and there is error from nfsd4_get_session_locked. This
>> should be a rare condition so rather than reverting the client
>> state back to courtesy, it is simpler just to discard it.
> That may be a rare situation, but I don't believe the behavior of
> discarding the client in this case is correct.
>
>> nfsd4_create_session/find_confirmed_client: I think the only time
>> the courtesy client sends CREATE_SESSION, before sending the SEQUENCE
>> to reconnect after missing its leases, is when it wants to do clientid
>> trunking. This should be a rare condition so instead of dealing
>> with it we just do not allow it and discard the client for now.
> We can't wave away incorrect behavior with "but it's rare".  Users with
> heavy and/or unusual workloads hit rare conditions.  Clients may change
> their behavior over time.  (E.g., trunking may become more common.)

This does not prevent the courtesy client from doing trunking in all
cases. It is only prevent the courtesy client from doing trunking without
first reconnect to the server.

I think this behavior is the same as if the server does not support courtesy
client; the server can expire the courtesy anytime it wants. If the
courtesy client reconnected successfully then by the time nfsd4_create_session/
find_confirmed_client is called the client already becomes active
so the server will process the request normally.

Also to handle cases when the courtesy client reconnects after it was in
EXPIRED state, we want to force the client to recover its state starting
with EXCHANGE_ID so we have to return BAD_SESSION on CREATE_SESSION request.

-Dai

