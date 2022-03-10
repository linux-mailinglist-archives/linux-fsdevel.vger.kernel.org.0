Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9514D3F90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 04:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbiCJDNJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 22:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238884AbiCJDNI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 22:13:08 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920BC128665;
        Wed,  9 Mar 2022 19:12:08 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22A1AjKJ009111;
        Thu, 10 Mar 2022 03:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Wsyt4XPO+xfhd2r8hh7eIRnpfdHX2NKOJY5tQbeycHw=;
 b=OLPxxqkwcbe8TDuwg1Xoa5sBzVt5Ic8eA/GGrj/VL9p7meEULJg21OXlic7LLuf4r3kk
 gAR2wr6+RrpxHXBwoglzolfxxGaeySiBgrsY9KhX6vw8ao0vPISJyTstb9EwsNQ79y6o
 mlS4TlkRm9NUiv2L4V4T3q/p2PD8e6ssiM6k2x3cWP7c9c/o978zGL1P1uUbiavRKd7L
 8z3zxorJ8MFbrs40Vl9P59SgBwVbpWV4NUboBRO3xMuejxAF5+39NPliMy5KMeqeXLsO
 Uy66UG5XC5SB5dGsi0kwXt7p+kaPQxwFGT8p+ZtTc9MZqias1/fTCq2hP2B18rySq3wh lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxn2m3a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 03:12:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22A3ARjo144036;
        Thu, 10 Mar 2022 03:12:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by userp3030.oracle.com with ESMTP id 3ekvywbu17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 03:12:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7zYxagIEIJ0Ip1oLXgVYVBuFikg6wMFZG+RspATdcscDkLCB3gz0ly90WHdAW0b59Ydl+lJWWSEzfzwjcFoyvV84I0qk0Hs8rMUQdGWfknsdbU5LaAVvhavWMuKOdV/QSzYAc/E4f1lcNFfnWYooJdbFO2ryvpj+E4wPb+ka36IbZWQ01cszGn9Mn+pRu6G0egQgevaS0Xtld/ESHtu+UfSgBcZhMwyPLvv+1MG817GUstThbOIJgWaJTUMF8W7VFeUe95L5+dbhYVERTaWQh3xGJWFbT2tBFGt0vvnEYLDbsYutM+HBtrI6+r5ugwvt8eXKUKVM+9N7kO9Yg1nbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wsyt4XPO+xfhd2r8hh7eIRnpfdHX2NKOJY5tQbeycHw=;
 b=BRwu4+CRyqUmpVRV+BqUqCKIyI4OmAA3D9hx5Qh8LV4CFp3VjHZW6gVtYBuWlJa89xhv12xCIXYavKh5t9/nDcvNs6Xx+koirnX8/Yg7Co48zy9qmedkywRlmr1NHgwQA+rCviYXy1YWhl0wWOOyqEH6aMjgNI35QJpcAYbALBexaQkTGC/Ar36hyaIkpY3NVDXaTBwmOD38Iq+WGN5Sn0B9ERfDWeklKToQQ6s72uCJlWDZRYPqqv8R7BPbihC/2s9Y2hMNHKzqDKW5y6nfZuDrJ6fZLmyvm6jNZSWT+y6DSf3VboG4PW3zrtlCrDLH3kHMaSB7BSg2QJRWxAnCRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wsyt4XPO+xfhd2r8hh7eIRnpfdHX2NKOJY5tQbeycHw=;
 b=QP8GURom4yQMVodPGDA0Tjsn9AXgAX4wQzxM5EUAqE8f+E2WwqgCv48Am2WIHsAdSUCQih9v8qaeQqIL10l7y/DS54v60JPeIpSAPRIxeOwPC9XtbNtRjVqbzi6Qg5f29myMUNdyJuoFZA3Dhe4G0xoZjgkVtIWbkMTeiYbEfrM=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CH2PR10MB4053.namprd10.prod.outlook.com (2603:10b6:610:a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.20; Thu, 10 Mar
 2022 03:12:02 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572%9]) with mapi id 15.20.5061.021; Thu, 10 Mar 2022
 03:12:02 +0000
Message-ID: <89b85e56-dee9-da2a-55f2-c0134a109f07@oracle.com>
Date:   Wed, 9 Mar 2022 19:12:01 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH RFC v15 07/11] NFSD: Update find_in_sessionid_hashtbl() to
 handle courtesy clients
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
 <1646440633-3542-8-git-send-email-dai.ngo@oracle.com>
 <E3F16183-1407-430F-B408-A298D4C29401@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <E3F16183-1407-430F-B408-A298D4C29401@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::10) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89363f48-f280-4e56-1f0e-08da0243bf7b
X-MS-TrafficTypeDiagnostic: CH2PR10MB4053:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB4053E82FF108E412D24D5D20870B9@CH2PR10MB4053.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sr74gWQfTQRiK5mvUwThpkloGpAjSPWnfyI/MZeOShpmefFmehCeAplSd8HCYc3Pif/UIuIN2eyfVsOiflyL6Vb4zP6WaLhx5okPV+XdkzCw2A2jPUg2MD4BJhp2wa8uWkEQTvf+iogRdHnMUWKAptBEmR/dvhnTFXX0uFKHwzX57FwaXMuaDzrToLRud2FFsB0nyjqzPYor/W2fMD4kdOokegch79Yu3cPeO9299hplW0s7GNpiVpPctdiVpwHElzhvjJBSIsqk1DJwZRtCnqeNY7CFaEKdw5pnS1TRRRzUl+vQaL/Wp5MZmHACkUPCPiEUJEZFhrkC+8ImY0egPybMcg8giql2uG6McSyqqYOaiJGBCP92i51dvVvIl8nySxlarDbtkYzfPlusjI4IggToL5ySISIj0QoR0sd8DPl8Uue1hq7deXNIxcs8/LvGyTBqS+zft3CZ1BtGd384/g3QXJY4HFoPbGU4skwgAi93NbQt9Xq6pfgQ4GCT5KaLCLpuEIrUYK296PUVeb+k4L7SuUx8pzWyXlVgYSkfO1wUh/u46fSu2Flh5WdaG48uL0ptKIlmd9ytRCtfLAxZgrrvQv2mwJl1IuTwmBv+ewVeORg2+arG90yZHMXSEv+QWRQXHHB7sJN2oOmRoyk94/vX1zzBBI5w3J0TGh8jX5lQsVLS59/4jBE8mBfU0WIqy+HYmyMbvwVs9TwSbheReQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(4326008)(5660300002)(8936002)(37006003)(54906003)(6486002)(8676002)(66556008)(66476007)(66946007)(6862004)(316002)(2616005)(26005)(186003)(15650500001)(508600001)(53546011)(6512007)(9686003)(2906002)(6506007)(31686004)(31696002)(36756003)(86362001)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTIzZHh1VXIvOEdRcDl3bmtaZ2J2RzdacTBVSys3MVlFYVlTeWc5S1VKZlNy?=
 =?utf-8?B?dU5OYWk3ZUdQRGZqNUNkdkgyaUZBQ1hTUStONUxEM3BSd0srRGN4Y050TzBz?=
 =?utf-8?B?Z1VtN0NxTThCenRlc0hUekVxZ0dKOFFwOGhiWjFvU3lMQUo4NzNsejdVam9m?=
 =?utf-8?B?K3NyQW1SY1Q0YzJRckRnNUt4ZCtMdXdUdmptejQzZFZQbGhGdTRIa0lkK0NR?=
 =?utf-8?B?SUNPS3dJRkI5aW81eGIvM3crMlhCMmsvellVdFNNdVQ3eFdMNjZBRGpPd2tH?=
 =?utf-8?B?Y01OdmVHK1hobFNWK29oYVJ2RVVZckJaUHRzaVRaRDV5Y1cxT3lBZFFQYmJk?=
 =?utf-8?B?d2I4OVJWclk0TVVUdm1KS3M1OE85Z3ZoeUZhcTJDMlphV2ovcDdGMHVzSkJU?=
 =?utf-8?B?Sy94K2dQQm1pZmYzUW51MWlvaUhnREZlWEF5bjFtd0hjYVkzaGprTk1wMjk3?=
 =?utf-8?B?Q2ZwMUQ0QVpZMmhBdnAwRWFMbEs5aytMUGhQTktKVGNqUEJ5bDZFRFBjeXRL?=
 =?utf-8?B?R1U5dmVmdVlQc091SW95T0xkRG53cHNRSkNWK2oxOUNxQ3BDU0J6NkpWWFpa?=
 =?utf-8?B?ekt6MGhiUWZBQW1KY1RIRVZoNDBobDd0b0lyK3BTaHFQUFR3WFhzQjgra0RW?=
 =?utf-8?B?ZXJvRGJ5SitXMGp5S1lzYnlzdEhxQUlBUWZsbFVYdmUyaFhDMW11c3l6UFBp?=
 =?utf-8?B?WVZ3eXhscEx4UzJuSDlJYUpCa3ZURWlsTnZZTEd3M0J5NE1QV2MxRWc1Q28v?=
 =?utf-8?B?WGI1TnZEYnpWSVBndUVqSkYvZVNhaWJlLzFWZ0wrM0swS0ZpMVF4ekZGQi8r?=
 =?utf-8?B?U0JEaDkwcjZXbG8zcE1Nb08zS0RIaHZWZXJuT0UrUDlFbmx5bHM1elNndzJ2?=
 =?utf-8?B?ZzdPVHhYU3ZJRTBGMkxlcVVRdXRoNnVuOUkra09MVVFUUXpUcnN1RVJEWk8y?=
 =?utf-8?B?aDd2OGVaN0RHRTlINExmdkFzakhQYjdUSmo0ZmhVZEFQbFR1SllsQTZsYWVa?=
 =?utf-8?B?bzVUa2d6TGZNVUsrcVNNZWZRV0Y2LzRGTGlMdEJwc2FsWTN5Q250RlFjTjZv?=
 =?utf-8?B?YTZNM2NGTHp3R2tCcjhEY1BvcWxrby96SjFLcVBnOHNFNk5OcVlsYitPdHVz?=
 =?utf-8?B?N3NRWnZCdldsNjFiQVRVbER6bUtLSWh0d1ZUV0lVL2RqdUtzcVpIeFJGRi92?=
 =?utf-8?B?MitxYjBtdmNlbGpoZCtNaVdUM0djVXBrVVZram5IRG55SDhYelBUdTZhTktZ?=
 =?utf-8?B?UnQ1VGNoSUdhdWx3VDd1QThTQ1RYNnV2VzVCb1luUGQ0SnBNdEk3M0JFV2dt?=
 =?utf-8?B?S2hQa1V6SDVnVzZkUHMxUWxwd3p5YnlON0F1VkMweTEzenhMbjFzcWMxSXVQ?=
 =?utf-8?B?NzZJVFVHRHNBNWF4Mjd5YlZlYTF2bnBBNnQvUEFZQmJENk5GNVh4QzFFQStM?=
 =?utf-8?B?a0p5THB1QXQ2cUlwdktZNEVtRFY2bXFkK08zaG1EaHY4S0ZaNkRQdHdaeEho?=
 =?utf-8?B?WW9aZkJ2YU1kTmdwd3ZtWWFqWTRPSUtobklQMWJpOWdKcG5TNWdmSnlxaHF6?=
 =?utf-8?B?YmhMT0Vob3I5S2l0YlZUVi9XV0VxMWdtOHRPRnRVSEQxdlQwSURIcGh3alUz?=
 =?utf-8?B?bVQxc3ZDR0VreVFZbEludWhzTERRT3ZhdGZ4NzRYWkRLb0RWVXZGNDNBMlRs?=
 =?utf-8?B?UlN4SlNqd2F0WVBkeTB6YTVQSzErRXpycWhzNXcyZkpsZXd5Z2dRQnNPVUhB?=
 =?utf-8?B?N3gwZVh4cWN1cmFDVGFiU1hLZFc5blZiRURSenpRajVqUThCYWR6Z3BYblJX?=
 =?utf-8?B?OU4yTzhjVXFOeGRUSDIwVUtaNmpoNlhjbFJGZkhkbzZrV0g3bUVCaDMwNHhT?=
 =?utf-8?B?aFZLeERWcTBuYjJhWWN4bFZNVytFR1ZIZW5aeENxY2FiVTdaK2dQT3pXUVpj?=
 =?utf-8?B?Y01qUTczaVV3ZVpSbWcvbUZPYlNFOTFFeW1LUkZuQkl2YnA2U1lUbjJ5bUtu?=
 =?utf-8?B?MTFyc3NocGlSbkJFakF6WERpT3cwaWlDTjdkemVhWlZ5U0JJcTE4VDJxUmti?=
 =?utf-8?B?VWVtZlhHZmhsN0FJcXJibkpHcFhzdWthbWdTa01aTUhMSHNUcDgvSExyNjBt?=
 =?utf-8?B?Mitkb0hQak0wQWM4ZDZ1cFZFQUVPRFRuOExHdldDcmZNMzBGR0hrZzd1MGQ5?=
 =?utf-8?Q?1oAMfBsVicPf8UIoEcUFy5c=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89363f48-f280-4e56-1f0e-08da0243bf7b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 03:12:02.5865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tzqFlUbrlcZUoyKngbpg3ZzZfbnpcVI1qsnBHwGQhOx+LW5Ls3x9EKpPKQg9xD4/KRfaJQ8Z/iBNpW7KU71cTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4053
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100014
X-Proofpoint-ORIG-GUID: KHMcXy03GPUf2CctIWmak3hJhL-xuCSH
X-Proofpoint-GUID: KHMcXy03GPUf2CctIWmak3hJhL-xuCSH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 3/9/22 2:42 PM, Chuck Lever III wrote:
>
>> On Mar 4, 2022, at 7:37 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> Update find_in_sessionid_hashtbl to:
>> . skip client with CLIENT_EXPIRED flag; discarded courtesy client.
>> . if courtesy client was found then clear CLIENT_COURTESY and
>>    set CLIENT_RECONNECTED so callers can take appropriate action.
>>
>> Update nfsd4_sequence and nfsd4_bind_conn_to_session to create client
>> record for client with CLIENT_RECONNECTED set.
>>
>> Update nfsd4_destroy_session to discard client with CLIENT_RECONNECTED
>> set.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/nfsd/nfs4state.c | 34 ++++++++++++++++++++++++++++++++--
>> 1 file changed, 32 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index f42d72a8f5ca..34a59c6f446c 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -1963,13 +1963,22 @@ find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *net,
>> {
>> 	struct nfsd4_session *session;
>> 	__be32 status = nfserr_badsession;
>> +	struct nfs4_client *clp;
>>
>> 	session = __find_in_sessionid_hashtbl(sessionid, net);
>> 	if (!session)
>> 		goto out;
>> +	clp = session->se_client;
>> +	if (clp && nfs4_is_courtesy_client_expired(clp)) {
>> +		session = NULL;
>> +		goto out;
>> +	}
>> 	status = nfsd4_get_session_locked(session);
>> -	if (status)
>> +	if (status) {
>> 		session = NULL;
>> +		if (clp && test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags))
>> +			nfsd4_discard_courtesy_clnt(clp);
>> +	}
> Here and above: I'm not seeing how @clp can be NULL, but I'm kind
> of new to fs/nfsd/nfs4state.c.

it seems like @clp can not be NULL since existing code does not
check for it. I will remove it to avoid any confusion. Can this
be done a a separate clean up patch?

Thanks,
-Dai

>
>
> --
> Chuck Lever
>
>
>
