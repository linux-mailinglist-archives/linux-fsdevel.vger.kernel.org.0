Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9263E2048
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 02:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240237AbhHFAvC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 20:51:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32046 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232902AbhHFAvB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 20:51:01 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1760jxTm025844;
        Fri, 6 Aug 2021 00:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=OKQ+fMYTUdLOU5rh+elZw3F/z7NLHtCDHX6vii0lqJQ=;
 b=DFtrcgYybgPHJ8jladuu30fnFjQughLgHns5Y8PNIN6F3wiarUBzhaVfqnzzrd0PSBKb
 Ivvok3wzho5YCJ9euGWM90QYV/VNwzYyV7NjNFspmAO6w6zpQgoeRhSqBolyFltPXsAn
 jhJZX0atJqsDHSjRz5Yu9Sae/Kxa+dRAbGflTzHoqzvZc0WnEnfdXT2IknBcAwd8C6kG
 xr+t3A3nz2hAy1lnrF0YKIeDdUiL6arRhd6AugJtTD5K4OakUmGcR06OWX/ffb1hKJd1
 yfix67M/P7tnpksSZpel+4FaObhIzjqiQXDaVjrnV5jBwzMJAa0UfUIPKtzzYqtB2Wds ig== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=OKQ+fMYTUdLOU5rh+elZw3F/z7NLHtCDHX6vii0lqJQ=;
 b=sO7IidVJRHrqKh0t4qPvN/8a33krMTkhAws4ZB4QOrh9IhtgS4se7LSO5j6YqtmG5V0e
 ykUVnMaljoI+thtQGi9+1sIcTvukq218S3eIY8HAx9XUai2OwxtaXMVhUHWCnJS3HQIA
 7r5wp3TN1YqLcG/AYFSy81q6K5ulDZqltxtJdIj91npmke5+7JfdsTdY4KXuU8hOXj8d
 Dm3O5EBrbL0J7lGrj2NdTSURD1oeJuY2qfTFcaGi+qQTNoXcQGyxmxp3qjuCG1EocTMI
 QSE76+EeHz2xogwTx3sukJo4m4i6rV7Y9Z4B7xOz2pZozrSCItt+gQkwfRcAhL675Tv3 nw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7aq0e21m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 00:50:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1760nXTi002811;
        Fri, 6 Aug 2021 00:50:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by userp3020.oracle.com with ESMTP id 3a5ga18031-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 00:50:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TInc5hY2NUkdegDXPHuUv1RnsuasLyP+0H2p4DAA//ctqF/BJeNpT0W+Kqfc8VHm8E26mG5+89qE17t95dqBFrOcSfykgMLXiZ5gU+1JgZkDAlFubaOmrSoNZXRuPo8Y/iyLYnxn1jSONcI5CfnNDiPgCpSaj/3B/TtoVOBL9RCgB5CJbYZIVJ/ZF3RnSQQMR2rXzOHsbiheklsCqmUjm9gcQXC9fJGQDlxR0tVgjE12nXC6wBsrCjvSM9pYc40aAJhMn5MNMsmDyR8gwVd1CUuxq4ZfMT6fcYuj/OqDEHoB6xHE7fge41JikxFw+9QAUKYvqENsxMPu7Cg6D4U91g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKQ+fMYTUdLOU5rh+elZw3F/z7NLHtCDHX6vii0lqJQ=;
 b=Gfktw0v9Xkaznk/g3OuI/Pn47bToxAGAlUl/3FvlDAKlQSE5YIW4nnZOPHK2Ap+zrgtm3KRPCrXuYldzukh6m328pn08WXa9z6Sb9f+w1Pc99cVd+25hvz/x9/QkTLMDjGlNoEVad8dlZseAyOS+TfTrnMTN2/o6iYAU3DuslQFFvrs5c2cNHKkPb1OtWOuV7XeWaHzXJ1KENTXefyaokLUrPEiNaGdclmhfydFGAS/zForVrnoudN+/Opu5EzYSFDfSmgrePU6FYbgVemFsAgtlimkTpnfGY8qVC03nRyaRuy5T/rFk4YKKbjR4RhdRwYu2Jcz5xAGH3N3jO9SrrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKQ+fMYTUdLOU5rh+elZw3F/z7NLHtCDHX6vii0lqJQ=;
 b=WhSr75OkBhHh4IsuUBWDyJwU/Q2U4/ywuMI1y0K8u1w0nRsDNgB8xAopZou10Ls1q9e+F04NwH73MO9D3qzoSzBy4Bsrtpncp9catgDuTnVRldJyvXGiheYLpFH3eHQ1V3UGIeN4uEwTY70AQgpEMpMaK96uKsSDQd2nzlvLEww=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BY5PR10MB3825.namprd10.prod.outlook.com (2603:10b6:a03:1f6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Fri, 6 Aug
 2021 00:50:29 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::51f7:787e:80e5:6434]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::51f7:787e:80e5:6434%3]) with mapi id 15.20.4373.027; Fri, 6 Aug 2021
 00:50:29 +0000
Subject: Re: [PATCH RESEND v6 6/9] xfs: Implement ->notify_failure() for XFS
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com
Cc:     djwong@kernel.org, dan.j.williams@intel.com, david@fromorbit.com,
        hch@lst.de, agk@redhat.com, snitzer@redhat.com
References: <20210730100158.3117319-1-ruansy.fnst@fujitsu.com>
 <20210730100158.3117319-7-ruansy.fnst@fujitsu.com>
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <ec5dd047-a420-8e17-d803-729e052b2377@oracle.com>
Date:   Thu, 5 Aug 2021 17:50:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210730100158.3117319-7-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::7) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.70] (108.226.113.12) by SJ0PR03CA0032.namprd03.prod.outlook.com (2603:10b6:a03:33e::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend Transport; Fri, 6 Aug 2021 00:50:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64d03e6e-6f3a-4063-6bd6-08d95874300f
X-MS-TrafficTypeDiagnostic: BY5PR10MB3825:
X-Microsoft-Antispam-PRVS: <BY5PR10MB38251ED3DEEF36DF8A87BC76F3F39@BY5PR10MB3825.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 30dpxfRHXlewOhog/H7iocZcue7V4sd5lh/SZtlb9b0j0mjQVhKavtNoV8X/BMvNoYqKAgJO/xFxPbcEaql9q1F88S1c+FODimOhXDdauDtfHoK6rdsbt8/4q/3UrpcdKLsyxc3cSIE6vFCaS1wvu9D7XjCXvF/WKqpvnPxl/Of/iEpkLfKqvWagyHxMajKroG/ZJKUzS7hh3fYL9QUWPuUOmYZZh5nrHjalxrvfDIRDFSE0+Fc2bDySblGgnslfLUSGsItsTsYuhY13z7PJLecgIJyqXidrbTkCoFCkMJs4JNgWcwgbIai8hKF38OVe+jbVgHlkkVsdVMScN/afDa7Va+1mSrVqolm7gNf6R2rnvghOxpGzLvYUi9UMgTxAJmZmW8Cruk2YLNQEH9MI70YCS9JGxXCW0wDR9eftcdoXL00d7gI72pbgeO+i6TRNgMkRtKzeHR/DI9dNKl+7ImYZJ+jZ9fe9W8GL0Ixilwgu3QVjTXOqOKxBpEIBxmYf7s34v1L4K6/DTZsG+pasjFueRGJ6ZMaoxMqKK/TatXEfHn/TEPx5BfZ7mPsAHzWxru3rYS8YqIsYtHtFfZIsy1NKzP0hnxwmzCE6/ONlNdGOLyWKeuuF7B3BOUau1/Ya+wisadGjmZDk+lcVuoYO3VQuPV3glUZbNblXzdUMssFb8MC3mKiE2a6teghYMYTiYr7UeGqyL+bKSFnTvZjH1//X41GLf8owbi2GoQaQjnU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(346002)(376002)(396003)(136003)(6486002)(36756003)(4744005)(66556008)(7416002)(2906002)(86362001)(66476007)(66946007)(31696002)(83380400001)(31686004)(316002)(44832011)(4326008)(36916002)(8676002)(478600001)(2616005)(956004)(8936002)(186003)(16576012)(38100700002)(26005)(53546011)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0llY2xUVFhMcjFPQWVlNGhNcFA3TWhnU1pLRG1IakMvaVFsdTdLdDZWdUJm?=
 =?utf-8?B?NFAxWmZBSm92eHphRVZlMDNxT1NDU3UzbDllRUhpQU82TnF2QTBCSG1Oemth?=
 =?utf-8?B?OExkUVR2ZktWN2Y1N2I4dERKVzE4eDZqWGRqa21pc0R4ZTJkWFVaUHRxNTVi?=
 =?utf-8?B?VWxDdEN6ZmRGWUtMY2NKS2MxVThVeHA3VWdpd0p2NWZOMzhlT05WcmkrRktu?=
 =?utf-8?B?b2FpWXVPM3hlY1gyb3EySlhZcmtseVRqMVI0dFIyVzE5c0V1ajMxQlBQaEZD?=
 =?utf-8?B?a0ovbXl0NnlZdzNkTFdLTUUzdmJrWTlhcXdvd3NwenJMeXM3amE2YXpBRnAx?=
 =?utf-8?B?QWxmSmVkZmFzUGZUcGRKdUJsQldQY2UxYUR4ZjBDdGFOQ2RsWE5PU1lLSko0?=
 =?utf-8?B?ZTZDZFEwbWRYRWF1dDFFQ3NiRWltUS90bHJETHZ0SVFYOEpYMklLcG5MNHVm?=
 =?utf-8?B?WVlIRTdUL0taMmVlVlNtZUJuUHd2YytjK2pnS0hoWHp3cXFQNHphMTRETmdZ?=
 =?utf-8?B?aXV6amVreVEzYktoK3A5T2MveVZ5QUsrN1VQemJvUXVJZ3FFY3Qvd2NmSnFF?=
 =?utf-8?B?cEpWSWp6QnJja1lHdnhwNzVrZy9MYk5ZVjRzaFVWVkpnK3YrZi9IclYyeloz?=
 =?utf-8?B?MHdCVG9ZeVZLVmJnZmorM0hlNnNLc3VZam9kaVFHdmhXcXBmeWU4Z05FeXJv?=
 =?utf-8?B?RFhzcEJCcStZMkp6SkdmK2VibW1NT2E1cEkvcUZUYUd6ejZETHF3bkNETTMx?=
 =?utf-8?B?L1pUYWFrMlZldFhORUlkeGFGRGMzVnVvYUJWblY1SnJ1OFp4M0FtbmtXQm82?=
 =?utf-8?B?RGFJSlBpSGhNYWtJS3hIbnlTU08zb2ZiNEJzOXg1VVFiWFAvalFjWXRFejIy?=
 =?utf-8?B?YXhlS0dVcnJCc3FOY2RjYTZPVmdiRVdwSlBubkFQamdtUWxqMlQ3aGxxMkk2?=
 =?utf-8?B?UzNVemtLU1pCWlcxOGd3WHZQdDJuRHl3amNMY2M5d01UWE5HNDRhUGhJVFFY?=
 =?utf-8?B?L2JUMHpJYjZ0bHg3elJtZFoyM2VnUmZpOUtpMThHWThHY3FFMUlRUW5kckNa?=
 =?utf-8?B?OVhtcUY5MWtqMnJkeGtuTHF5OVA2ZnVjVTNkUDhZbmFrRlI1QjVoT3dGNFpp?=
 =?utf-8?B?dHQvdEJYOStUdFZqVzZsUG1LRng2VWh3RjBUcnVTS1A0QmJLdi9OMm5DWFdJ?=
 =?utf-8?B?UlFFcHZZSGE3a1d0bHY0T0FiQ25hZ2JMZk0zUklPZTVIcndNMlN6b0k3eitD?=
 =?utf-8?B?UG9kMFdPckc1UFd2T0Y3TUs0U2VkY0ErZ3VQYThoNVY5YVJEa2xEZ3NLOFA1?=
 =?utf-8?B?elRsWENBaU01Y1FtNkZwNnZ6UEFubVdteWRwT0hxbFV0bktCNTEzRXlvQnB3?=
 =?utf-8?B?MFV2bzFHR0RCSnZkdi9uZTRvaTArNVZMOWJ5bVIxZHRmNnJRblAwc0hHeFlo?=
 =?utf-8?B?R1d1dHRkSWZHbEZzb1dlWEo0S01ZeTZYa3JzRWFBSFhoSkVTSDhZRWFCS2xQ?=
 =?utf-8?B?S0FTRVFrbjhBaUhjSmVnR0NjVjVwTi9yazcvSHMzc2RldFNESWVLTWlVZ1dq?=
 =?utf-8?B?WjFIU2MycXVSalRBdTlXZlpUK2VmQ2FoRm9JaHpJcTVuVjZjc1l5TDlXSjB1?=
 =?utf-8?B?RVBDdGgxWFM1TENncGVUYm9yYlA2cDhLSE5RaktjVmIxemdLOWMrOHRaeEh4?=
 =?utf-8?B?THMxNlpnakQ2MlFNUkNoOEZJdXlWVEhoWThOdS9FNjVkNGFpTCt1MnRjOUlX?=
 =?utf-8?Q?zCyFeyiLFOFHqjwwamzLBHMgbjl9CL2pnxJFzrP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d03e6e-6f3a-4063-6bd6-08d95874300f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 00:50:29.7743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O2zjtJsr/AUdhMXYdYAwCG9aQN/CQkeNOiuqoYtVXaQB0c5zbAnIOO+ZU7rYk8Y0SJXNSpAuzClSy72pPhXKBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3825
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10067 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108060003
X-Proofpoint-ORIG-GUID: S53qrv18NH5aN2vJq07z6mcXDJ3Bf6W6
X-Proofpoint-GUID: S53qrv18NH5aN2vJq07z6mcXDJ3Bf6W6
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 7/30/2021 3:01 AM, Shiyang Ruan wrote:
> +	mapping = VFS_I(ip)->i_mapping;
> +	if (IS_ENABLED(CONFIG_MEMORY_FAILURE)) {
> +		for (i = 0; i < rec->rm_blockcount; i++) {
> +			error = mf_dax_kill_procs(mapping, rec->rm_offset + i,
> +						  *flags);
> +			if (error)
> +				break;
> +		}
> +	}

If a poison is injected to a PMD dax page, after consuming the poison,
how many SIGBUS signals are expected to be sent to the process?

thanks,
-jane
