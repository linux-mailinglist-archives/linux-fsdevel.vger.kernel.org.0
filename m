Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB71346D77E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 16:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbhLHP6r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 10:58:47 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:43912 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232082AbhLHP6q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:58:46 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8F9WUU025170;
        Wed, 8 Dec 2021 15:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=x6Yj0+uDQgbiyDya03piQHLYnOGCwFzQP22Lf1mQR6g=;
 b=AQC5cgOC9bMSQpV4QBPtw1H+oHvRm0lxasWo+P2orXxPZOXXJuCUM7Vg4DHIaQ7fM4MO
 Zc9yzCao5UA+o9bXBZUk+geeVKNTbWL05hyFrCCS5ZfXQo5UMS5Cngg+xcqGuxaWCc/u
 BTUBpJ5gJda4kUHKSd6LYecviodfmGopZp8MVzLbD53dFlr4TKIiM6QQVvLjHvqgVM65
 aim1JmFnbK/G+KYay/uh5wS3Mu4JZXhqho/mTUcLeV/c3Z0FiNe4keEHFDKUq/njA5UE
 ZTEj7eYzqGBD8zSNtyVUhX/W68RWhQcwuM1V2uN4HvotmmsgDkJtZKfwPHfZU9hsVwOV Eg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ctrj2s487-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Dec 2021 15:55:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B8FakdQ032825;
        Wed, 8 Dec 2021 15:55:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by userp3020.oracle.com with ESMTP id 3cr1sqwsqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Dec 2021 15:55:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SV7nShDPeGN6m+TruVMqhRNMpFD48MSIc1AOabFgwGOw22sLvgmd+gIZaa5c5BNzqg2PFkegprgCyZ377Z8HwtgVPtfoH3EgxSYsSmSWcynxTUF2WEz4vv60WvbsrXJpPejLFmkYfkkfCZrYWeWur02MV2hPswtLApjF9/X1s3ISr8qPAgPjg8Bxriud0wkl//FhTaf/iX04MsyysBgPftwBRAkTWp5RwzNqC2QCp7NTqsETMs9+mPDiHNL+TEo5ENKIHTsntJ/y2lvAgbfMAUTuuvD/wAHzvam1krZi3dB0Y0Low7dLErMUM5sP1tqH0z0jsRTQXQ3Jb1iA5lQbgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6Yj0+uDQgbiyDya03piQHLYnOGCwFzQP22Lf1mQR6g=;
 b=jvYFlh8S0iC3VGw1XSEU9AQnvrj9WL/DJU/W6oOARbd6Q98bqGPBv4hEhiA37p63TC+zZfgayN7yEJDwBc2f9B+N81OEIyUaByA7/JGsMWVIhrOLlq4EDCD0hmHUYLxaAp9xXx6mpKSoc6p8WzJBO+81lhRXyNXVif5ptQZCsj8zwKxajw0HdZ9RlfwXCT8tOhBz4wvx16ozV8ysxPHH8/zNe+tfak6tsYFewKP8xGxneJ4wEXDwDuinrJTaA7gd7Qt6j/tYQF/W/9Xg3FSEz8b/9cIL5j2SeKPiib6IJAFxgjNc+N93Q6fmW/5lZSo/zStRzE/Ift4YCw4/ptJnlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6Yj0+uDQgbiyDya03piQHLYnOGCwFzQP22Lf1mQR6g=;
 b=dOrLaG6UckYCNOKqPPTMovcN3vMBrkDyzl4ykMak76awAXFGg2rbl15XA4KUzbezve+9LGPhOq2X1lqXn59Hxal0jcs4GAd8IVmHMF/s+b3KOLXe144JXNu1Z4x3/MpnUOksBr4AeHY/7TrCYwCixt9VBXrOMe7b7Nt2licqjGE=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3383.namprd10.prod.outlook.com (2603:10b6:a03:15c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Wed, 8 Dec
 2021 15:55:09 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8198:a626:3542:2aaf]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8198:a626:3542:2aaf%3]) with mapi id 15.20.4755.022; Wed, 8 Dec 2021
 15:55:09 +0000
Message-ID: <f6d65309-6679-602a-19b8-414ce29c691a@oracle.com>
Date:   Wed, 8 Dec 2021 07:54:51 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH RFC v6 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20211206175942.47326-1-dai.ngo@oracle.com>
 <20211206175942.47326-3-dai.ngo@oracle.com>
 <4025C4F6-258F-4A2E-8715-05FD77052275@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <4025C4F6-258F-4A2E-8715-05FD77052275@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0144.namprd13.prod.outlook.com
 (2603:10b6:806:27::29) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from [10.159.149.37] (138.3.200.37) by SA9PR13CA0144.namprd13.prod.outlook.com (2603:10b6:806:27::29) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 8 Dec 2021 15:55:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbd04965-1719-4445-e18d-08d9ba631c77
X-MS-TrafficTypeDiagnostic: BYAPR10MB3383:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB33831DD3434EA5641F21A1F4876F9@BYAPR10MB3383.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TY/EYbSbDigxMb1HYw/p6ZNuiYkQLcpnaTYAKgEyQmBB7CTf7s7woa3nt8Ry2Q1jJj14Qi+sfhxuXeD1BNoDQGttU5Ene5sbxA8kldEGyWKOeIjxEMUx+dDlFQ/9bxvzmN2SNsPsJyLm3OjgsNUtUePUFlyla0stio45Qx9OWH6ibRrGeS+SZDFeH0Yc/LVV9YsE9VWoAvxfsSLU87sPS09H7o5Sn0rrpMJrvb/0n9QozMS2sDmesijdVwY9b4EXPGM45KUneRcGviwEWZNMV+4vRqyFYldxRW2PGNwoiMhANxulKA2rZW16qUZHI35feGnhRW6XqX3pNK67yh54bva9B25qOfCh6bWzZYt/ju7WcWbT6h9O9kWkMfUaYBbkfiB3v/DuPkrJNjjyLB8IAruVGzPoMze7sDDANRV9W3uN2szTC6ZLH19cDH5w2tASuDHBxMwWRkonTZOL5q+cNsDXMar11Gpopfmwm7XDd3zHXUV3wTyOCOf0FwtlRG7WinmVQnb/lqfYuPDiuU2lqL94g5KvkiE9KS2hTpSJ0JhoKueUrRAo/3dmH7EaDLk5/UdJlF/f3NT11HXhJXv36+GzBv/V4OKxNNr74LfTjhPr9VfhChFMyJyKxDL68lB+xzUS7XMVr4wY8X8ZV5SwWw702Orsn/ZgqeRipuA3q8GOnYtI4xKlzCsD6aubS4prBawT+cDW13NI7Skie/t2JQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(16576012)(5660300002)(83380400001)(316002)(4326008)(37006003)(86362001)(6862004)(6486002)(54906003)(26005)(66946007)(186003)(66476007)(66556008)(6666004)(36756003)(31686004)(8676002)(9686003)(8936002)(19627235002)(508600001)(31696002)(2906002)(956004)(2616005)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ry9BdWZ5U2xsS1FMSXB4bHNnWXl0T0l6QldPWDNCRzV2NFgrVHVkL3Jic2FK?=
 =?utf-8?B?bmZYSHFrRUE0c2RBWVh5anV1dHpsYUk2ZHdQM2t1WUV6a2IxWHMvd2l5Mk9q?=
 =?utf-8?B?NDBkb1R6bFBEbVROTDhQSUNJa2VMQWE0QmFIZ2ROOWpFRFFXckJ5Q3lUNzVM?=
 =?utf-8?B?Zm9KdWFZL1p4bWRiaTk2emJTN2FLMXpTcFVZdVcrbDZ6cnFIOVh1V1BpWmly?=
 =?utf-8?B?MllwdGp2dU4wYUdNWngrT1FyOUxud3JuVXRKK1REWC9aMnFsZ1Z6aUVzSGlr?=
 =?utf-8?B?K3RwWWJPS3JmbFdzdXFJM2V1aC80Z0Y5QlRuOFliRmVvVTJNUWV5OXlwK0VJ?=
 =?utf-8?B?QzNodmI4V0o1SzQ5ZVpmRXVDc2tBMmhkMEN3c0ZNdUMyRTFjVnV4dHFkQWJy?=
 =?utf-8?B?RElDSEh6NVlRZENjQmU3NmkzSWM0VnpZNEc4TnB0eUVwM3NPVGJyUmk3MmFN?=
 =?utf-8?B?aGhudkhvMnhDMG96Nit2WkhkT0JVdzVsWjJvbHE2QUtNV0lzUEJvWnliWlI2?=
 =?utf-8?B?V0MybzZNSUpIcjBvOFFhajgzWXBRVDJQNm85SHE1SXIvYXBmK2tNWndIb0o3?=
 =?utf-8?B?czZ2NFhhYTBOSDlkTExyZlFjV1J2cVNBYmlUQVZCREVFWXpOcDZqNnlscHZN?=
 =?utf-8?B?UnJkbndhZTN3eGlURy9kQnlVNWh6SFNaQS9yTkJUNUtpbXU5RVlSZWNUUkQz?=
 =?utf-8?B?dm9Qa2Z2M2VXVkdKeEM1QzB1SEN3bUNLeXR5eE91V0h0OE52NkhacTRyZDY2?=
 =?utf-8?B?RCtnSGU0d1pJL3JhUTlQbXUrNWhXdXJXekpIRC96cyt2alZCR3A0Wjkwd2x6?=
 =?utf-8?B?N0piUEgzSHJaSzJFdGM0ZkRYdXVxK083LzVMU212SjhjQWVUMFFuemRJZ3A2?=
 =?utf-8?B?cTJBTnp5bGNKUE1pckRFd0JObVlzekJtMmphMDFrS1VNeXV5Z2tPZ2lGVk9K?=
 =?utf-8?B?QjIwZVdUNWJhZDhYU2pMV0FnclRsa0hrL3Bpa1VETDVrMTZWUENWZEJ1S2d5?=
 =?utf-8?B?WWhEckJhblZGWk54SlRTQ1lZUGxzZzQ5MkI1YjZ3ME15MEpoR2FoVGVmeE9u?=
 =?utf-8?B?aWxGbm1TUVhpaitESlJOWEN3UUFGWEJRanJMaEREQVF0QjJVcWI2am1paW1l?=
 =?utf-8?B?ckZObHdLSUdObzE4UjYwUWh5ZWx0d0IwYWxqNEI2VHY1QndTd0dEYXY5dmR0?=
 =?utf-8?B?T3ZnNEVWU1lyU3RKMG83NjFjd2hROVYwMjBLRE1yaFUvZ3p4YW1DUnBXdUxo?=
 =?utf-8?B?d3A1ZjhyRWdoSjZ3WjJaTVBZSHB6d3JUS2dWM1A4ZWk1azhCaHd5TU5oemhU?=
 =?utf-8?B?V0JpdDJzNVh4aWhjaENmTWRQNnVFUTBsWHZmeXdTc2piYlVTNElkYk4xaHRG?=
 =?utf-8?B?RklHSnMrNGJSNHZhalZDclBHOExtWVdidG9ocUc4bFNURCs5T2FXb2ZRWUIx?=
 =?utf-8?B?cjVtVklUZVpDS25OdVFJaU01T1ZHVlRmRDQ5V0hPR2o2VUprUTdwc2hJeW9M?=
 =?utf-8?B?dnhoQjNyUHhyaDI3U3I3NTRaT1NTU0o0UW4vbEN0dEZFdHpVZnZMUHBMd2wr?=
 =?utf-8?B?RDAxZzdvQ2IyVkpPTldIaVNPQnl1OUJyeGFzRDlmaTBlN2lrNUJpUmtRblJD?=
 =?utf-8?B?ek9ZeWdLWFBOckxKRjVqOHB5T3RVdEJaUWs4cmxMdERTQVBQcHZGbm55ZFp2?=
 =?utf-8?B?OS9BOTIrQ051R1RMN3JMbk5halJmUGVYQkRwOElsMllBMFVHZTJpeTBnWlMw?=
 =?utf-8?B?L3h1c044eGtOR3VDQzZYUkUveFZxeXBOMXhjaTMremhhQ3R1WjFTZXhDWU9k?=
 =?utf-8?B?NEkzT3oyVmhISk9WUGdDRzlaZDBhZG5JMmZ3SkZuYXI0TlNrU21JbG81enZ6?=
 =?utf-8?B?bk80SkJkMDRKZE5zSk9qOXd4dHoxSDhMamp0cVJDSDFvSzFSMExBTHRzcGFK?=
 =?utf-8?B?d1ZJcEFHYTVFOFlWRzU3enlVZmZvK1pTa0k3dnJRMng4eWh4YmdQZ1pvMEE1?=
 =?utf-8?B?MGJ3QktkRVFZb3dyTWRicmNPNDh2WXJkc3liandqbFgwZDRrcTh6Sm5sUXp0?=
 =?utf-8?B?Y2RRb2o2RFRKanRnTkZuRlFLV28wOUtxekdNY3ROemZZMjBHTUhRMUpLOW5T?=
 =?utf-8?B?RWc2TEtkbVJmVTc4RE5meU9RazRFRkpiVGhMendTWTc5SndHVG9LeUhpeUdI?=
 =?utf-8?Q?So4WpLxdusebprp8fvWW0Cg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd04965-1719-4445-e18d-08d9ba631c77
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 15:55:09.2720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /L/sr8ldiDwtox8VRrXrch/AV9trUZDE84LrYLsTAaPvxX+O9Wx+f//i87MscSsRffhES+QFsVPdss3QLPViXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3383
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10192 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112080095
X-Proofpoint-ORIG-GUID: hFHqIklWh2b9ipoqByqcK_5Ba_3CifeW
X-Proofpoint-GUID: hFHqIklWh2b9ipoqByqcK_5Ba_3CifeW
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/6/21 11:55 AM, Chuck Lever III wrote:

>
>> +
>> +/*
>> + * Function to check if the nfserr_share_denied error for 'fp' resulted
>> + * from conflict with courtesy clients then release their state to resolve
>> + * the conflict.
>> + *
>> + * Function returns:
>> + *	 0 -  no conflict with courtesy clients
>> + *	>0 -  conflict with courtesy clients resolved, try access/deny check again
>> + *	-1 -  conflict with courtesy clients being resolved in background
>> + *            return nfserr_jukebox to NFS client
>> + */
>> +static int
>> +nfs4_destroy_clnts_with_sresv_conflict(struct svc_rqst *rqstp,
>> +			struct nfs4_file *fp, struct nfs4_ol_stateid *stp,
>> +			u32 access, bool share_access)
>> +{
>> +	int cnt = 0;
>> +	int async_cnt = 0;
>> +	bool no_retry = false;
>> +	struct nfs4_client *cl;
>> +	struct list_head *pos, *next, reaplist;
>> +	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>> +
>> +	INIT_LIST_HEAD(&reaplist);
>> +	spin_lock(&nn->client_lock);
>> +	list_for_each_safe(pos, next, &nn->client_lru) {
>> +		cl = list_entry(pos, struct nfs4_client, cl_lru);
>> +		/*
>> +		 * check all nfs4_ol_stateid of this client
>> +		 * for conflicts with 'access'mode.
>> +		 */
>> +		if (nfs4_check_deny_bmap(cl, fp, stp, access, share_access)) {
>> +			if (!test_bit(NFSD4_COURTESY_CLIENT, &cl->cl_flags)) {
>> +				/* conflict with non-courtesy client */
>> +				no_retry = true;
>> +				cnt = 0;
>> +				goto out;
>> +			}
>> +			/*
>> +			 * if too many to resolve synchronously
>> +			 * then do the rest in background
>> +			 */
>> +			if (cnt > 100) {
>> +				set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &cl->cl_flags);
>> +				async_cnt++;
>> +				continue;
>> +			}
>> +			if (mark_client_expired_locked(cl))
>> +				continue;
>> +			cnt++;
>> +			list_add(&cl->cl_lru, &reaplist);
>> +		}
>> +	}
> Bruce suggested simply returning NFS4ERR_DELAY for all cases.
> That would simplify this quite a bit for what is a rare edge
> case.

If we always do this asynchronously by returning NFS4ERR_DELAY
for all cases then the following pynfs tests need to be modified
to handle the error:

RENEW3   st_renew.testExpired                                     : FAILURE
LKU10    st_locku.testTimedoutUnlock                              : FAILURE
CLOSE9   st_close.testTimedoutClose2                              : FAILURE

and any new tests that opens file have to be prepared to handle
NFS4ERR_DELAY due to the lack of destroy_clientid in 4.0.

Do we still want to take this approach?

-Dai


