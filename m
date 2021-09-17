Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5214640FF4E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 20:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245604AbhIQSZy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 14:25:54 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19496 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245615AbhIQSZB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 14:25:01 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18HIGuFx025129;
        Fri, 17 Sep 2021 18:23:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MyfOk0ZIL882FTdwEmD/TnnvevYA0EOZb2HXdOZpmBM=;
 b=CYnv48IwmKiLwersqVMqKVJyc2LXvBbqPb5XlMyDP3B57E463/SjS1LuB+Kq6JMqvP2X
 dsIpCgzlqLOXz48icmPw+wbS7WIQa3f3FnEtVQ1oE8JkRJv8lEmRaG2s+8PJHbIMXBEg
 l2iVDdnTaknDGlUa1r7VXWg3HHdB9xzbXb+WYQNpm0thlETEpFeNfrtDmAw7gJ2d+WTv
 msKxNiQvOSJn/1P2nVUu+ANe4FHkkRtFlPCYZFFDxiqhhm5dke0aio/+XMGo/s+0pFoh
 dzuATCwFIF/3aGB2pEiK9tETOHdK88PrKVD0XGeffz9RMUy4sDkgxnESELZvidLcVZiL MQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=MyfOk0ZIL882FTdwEmD/TnnvevYA0EOZb2HXdOZpmBM=;
 b=LfQAV0M/89IX7gWoJAmxr0e7fCiURRZkHpPjYoBdfQcsb7fo5hiFZIrl9hfUWeRrE8IZ
 mCQY+5yzuPBLZ+QiQPtnQbjDnNzF2ijyHEehKMScH0RamgLT7xErJGMc8lxsqY34akpx
 Gx9MyY7A4mdpWMvtvUKbu7LS5iy/8fb4EmC4CU+BckXkUWhG/4Bzcwr6R7SzSvnxgIqA
 nyB6gWXRcz1ZGg4B0iNBF2IhkXITYPrzt05HICwQ4zaDnQujfaEsHg3H5tS40XFCrPIK
 /fBhdkcpioFQteH8QsJ385xAaVWrwuDUkV0RC7oDrEBeA9GbLRaQm1X8vVjLGRR1oHU4 TQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b4u8ss8ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Sep 2021 18:23:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18HIFkc7039676;
        Fri, 17 Sep 2021 18:23:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by userp3020.oracle.com with ESMTP id 3b167x54jw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Sep 2021 18:23:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqkEK9VGY9AsQGQ0/thRLiT2FBmnAlYE5TyBGhsxOwhyUuwGvqgaWP4zwXcPbXdCtTpVihFWQEPc10rgjZlGr9W3vXM3C3GtoMmYk0NPZlryHheRgdWH17MUIT8Ktyi1kLR9t3CmDNMgLvQwliPbUx149T4XAVZn/fk6eEF6SmGfL3v4n0FyoC7j5EIAHNY8mB1FYlfDuBnH0BLUSdjKkPN2dijdCioGDkT+i0zYLSL6rbWrubI067WMsAFpoNyO71J6hZC4E7o6P5sKjXcpXmodilbFKvsA6CYTGNLNHWw6hdnh3YElx93J74fgXld6xSciG1+yvxDc9VKjOzdkhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MyfOk0ZIL882FTdwEmD/TnnvevYA0EOZb2HXdOZpmBM=;
 b=m0hEbqYL8s6oFI4J6m2jczteAh+Bs4frsfCnngtoCTYNTaY2iOxPHSfYHDiUfA8VJELnYtDy9f3MqpDnTcJYy+rClM4mn/7DSBTZU2CbeL/iVR7KKhEcu1IBGXUBK6n+bGWitJPU5KizhPh9bA0FeF40JMV1lKP4MyOdEJ58phipmQZhbpGh4+zPOuwo0A+Kj4rQ8KBtwmj95l/mWtKKt0Drn8JVclII7ukoi4cqucxl1HC6U59rpNiJv/g/s5msEU62n4SUI+7Q07jND7quZcFTRU6iULtCdM9W7CfrNFIL1vtvcEWecG8D/Eqq1lBCDk9ih0eYxBaVir37/9EmAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyfOk0ZIL882FTdwEmD/TnnvevYA0EOZb2HXdOZpmBM=;
 b=UxiZfmZFqwjlEPQluyThWFScgUQWTb/61OygbfNzHRNKgEQ+7iA8YS5WzgNUh5usfhP9YFp0uR4KyIlB/ly2FAScupQiEbhZjBROl6SblfdJO5scuMEVr399MIEhQbAye1Sw/FgDzjFp0ETQ3vliTS/c+oESR0c+o5lVD5TwNRE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3142.namprd10.prod.outlook.com (2603:10b6:a03:14e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Fri, 17 Sep
 2021 18:23:31 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::1c92:fda3:604:a90d]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::1c92:fda3:604:a90d%5]) with mapi id 15.20.4523.016; Fri, 17 Sep 2021
 18:23:31 +0000
Subject: Re: [PATCH v3 3/3] nfsd: back channel stuck in
 SEQ4_STATUS_CB_PATH_DOWN
From:   dai.ngo@oracle.com
To:     Bruce Fields <bfields@fieldses.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20210916182212.81608-1-dai.ngo@oracle.com>
 <20210916182212.81608-4-dai.ngo@oracle.com>
 <8EB546E2-124E-4FB5-B72B-15E0CB66798F@oracle.com>
 <20210916195546.GA32690@fieldses.org>
 <836693fe-99f6-3ef0-e100-0e5743b9ec55@oracle.com>
Message-ID: <c5b09102-c721-07c1-7219-999bd9a79394@oracle.com>
Date:   Fri, 17 Sep 2021 11:23:28 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <836693fe-99f6-3ef0-e100-0e5743b9ec55@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SA0PR11CA0117.namprd11.prod.outlook.com
 (2603:10b6:806:d1::32) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from dhcp-10-159-244-211.vpn.oracle.com (138.3.200.19) by SA0PR11CA0117.namprd11.prod.outlook.com (2603:10b6:806:d1::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 18:23:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 874f9afe-6e54-4e3c-610c-08d97a08408c
X-MS-TrafficTypeDiagnostic: BYAPR10MB3142:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3142B1F5F630A9FB438B2C0287DD9@BYAPR10MB3142.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F2xT3sLA1tVsA0qdjB5Ajg3EOrP9x3sDG6+AS2yH+Kqa0Ik7NwYrUZAlEMiQCk+IFHQFtjPrlNAwZuagVAvlPF+Effp9KfaKHIQtkWL1dGFLPdhz6yh9hKjioN4swVeWG4HMEjmcI818UuDhATN0UUiPSS+Lu/1Ii9RsqhWesVbDuPRNIPLtpR6a2WPbbf2Wcp1BGquO4SfX1litY5uzBWO2tR3UTQusHldVACZKRxO0DdtVRH3Y7sIlizooYIiZyBbnYCSa6hSY0mwu0xeut87YoNna3RL4zDRrEnhaOqgBIaTls5GYc5xcGFsRv1c0cL+zoq8yiZvo5Qz5p7IMMWgtG1z/byOeMryvOE6y7is2Ibm+uqLe9XwCQuS6HB5EvSxzTa0O1ux9FoUMnT1NJDISM+jUCfl5pOkMh7VAPrUIkQxfgeWqhTBrvhHzaaiZe9OhKRGsNxJ77474CHqkemsHxmWuJUs+EXFtX4ulgECg5UYoniT3rGUaU5COO9eHqbnKRVaFxyx9vP/MzFxxZlwFB1wKuyaj+NT0vUVHYdkCB816JyweYxvDgkXw5Mhh87DJwSFBzyy0Zxa7v3fB9zoEjqqkUZX9gjJT+07+DKhVjrtzyhEqlhVaoXzH9c4wJCDOLhSpMX6Q1fTfwzRewaTic6r7xuh7oi6C5AVmIo+EwHwF7Ps6PklzCrfDyxR67WqgBI3VGwGK9B9NcE0JZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(86362001)(66946007)(7696005)(4326008)(2906002)(31686004)(26005)(956004)(6486002)(2616005)(186003)(83380400001)(5660300002)(8676002)(110136005)(31696002)(54906003)(508600001)(66476007)(9686003)(8936002)(38100700002)(316002)(53546011)(66556008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjlBTExpRGFVVmJsWmlVbmx5b2ZscGxxdDZBS3dlT3lQRkxjbGVOYU5sSEU2?=
 =?utf-8?B?UmMxMzZMMTl3NnVTRzZiQW5McmxFWm52cURvdkp6MlZBK0J3NVRSNUZid3gw?=
 =?utf-8?B?dmdJVjUrazd3RFQxSGpaU1JsZjZRc3NCTXp6VjFrUG44U3g1ZFBUbEFzWEJJ?=
 =?utf-8?B?K05QeDFXcTZGMW1Fb29wYjhNbFVSQ1VGM0dHL1FsQzdDRUN3ajJKQ2hNdmhx?=
 =?utf-8?B?blFTYXB2VEllY1ZtbkZkRVRBZUtXVHNPclpWZlB1TUpyYnMyNm90TFFHa0Jq?=
 =?utf-8?B?aHhZM3puS2JoWjhEa2dhcWNUZ3BDWFpmbUhEd2VmK1hrbWlVdjNxRVVFR0da?=
 =?utf-8?B?Q04zM1hVQXVDMTlXc1ZoWmREOExvbFRrQStKL1YxczB0aU9UaTUxQlJFSXN4?=
 =?utf-8?B?OG9yZUFNU2ptb1hBSjZRR0lKQWZxaTMyVllhQzdaSDRTbGZ6S1RsL0U3a0xY?=
 =?utf-8?B?NTZERHRHbXN5OExTamF2NXdZSjZUUkZWRzRUcEN2UjlCR3BMQU5HREZFRnUx?=
 =?utf-8?B?UkttVWtOZDBxbktvMXMwNXhrcmNHQWlJdUJ4YjgzM0h1K3pXVTEwd2p6d2Fq?=
 =?utf-8?B?R3hTTkNXSlRhbUJPZ081QVppMUw3Z2FSVDNpZC91b1M3ZjQ4b2c2KzlRdmpW?=
 =?utf-8?B?Yk83d1pDeEplWk5YTVJla3Nnc1ZYcGdQTU8zVE9rSTBhcWFjODZkSUN6cGpw?=
 =?utf-8?B?S3lVMnFCMVZ3M0RQWGhrVDNiRUNhMlFjQm9NKzJ0cFhIYUM5Q1JKclVtaU9H?=
 =?utf-8?B?WUo1MFAzbUlCVHB5ZWZOWDlvaTZEcEFTVk5JYkdvVXlGcGdzcGRWSFB3V0Ja?=
 =?utf-8?B?dmtEZ3REbGJEd3A0MmI0RGRJeEVuYUdOVm52MnVKdmVnRTlWdnRpR0h6MklX?=
 =?utf-8?B?YnhseVo5V2RJTmVXVHhNSitJcFR1QU5ydDlvQWNYV0lJNHRXdFppN1NXeDFS?=
 =?utf-8?B?RVFaNjhueDFBSVowT0pFL0t0cit1SE9TVmxPdVlwZW9mQmRwYUNKRDZRZU1O?=
 =?utf-8?B?L29HRmI5VUtlTGpZWVYzSVc5Z2Y4WWxWTXl5LzJ1TXJsSmRxWVhPcHZlU1k5?=
 =?utf-8?B?RGw5TjhMZ0lqWTlONFk5ZE8zcGlVYTFVV0kxb2JEVXR5RVQvZ2gwYk1HQkFi?=
 =?utf-8?B?T3FCMEtyUVFNREFaeHFNYkh1b3J3NjYzaGF5T3pkY1FjU0g0R05HbnNJaHVF?=
 =?utf-8?B?MzdmVnBsVHpZVmtpTURsWTFacFFKdmtTMjlDQ3JFVkNaWmtZa21HeG1OQ0Zo?=
 =?utf-8?B?b2ZPSWpjbjVmZW05M2FQUGk0Zis2UWhsRVhBYU1scW45V1Byams5czYyZk9N?=
 =?utf-8?B?Z3FWNU9rKzFzN2YzUm93RnByZS8xU0hxTER4cmxSY0RVVDdtcWE1R0V2UGVw?=
 =?utf-8?B?enBKVWUyQWRtZHYxem1kbXczSHNSWUt2cVlFM205QS9jNUpaRkl4d2xiNlhp?=
 =?utf-8?B?Mkg1WXJ5Z2U5bkVhYVhlTTgydDA0NFlSVStqSmFOZTdhK1BMMnNObUJhbzdy?=
 =?utf-8?B?UW9FSGJTYmZXWHFrL05oSWFxaS94WGk1d3hFeC9YRU5vcVNvNXNmaUR1ZXNL?=
 =?utf-8?B?Y242S0hacHdRbW5oUG1hUVI0SkNPV21SY1BTLzNVSGJmYU0zVzVOOS9Xc2I3?=
 =?utf-8?B?K21nOWJneGVsVjdNL3ZvOFBPUHNZbnB4a3ZVeHlCWjdreEVkYTZEeVd2OE4w?=
 =?utf-8?B?dWRWeVAxZTZRdGJDVEc4Vzdha0tNOEdjamVTWUoyY2JZeVhqWS9weGh2TDBP?=
 =?utf-8?Q?vveC7P0dKqHDVpi1X2PJmqkKLstOGuwpBaI1XdA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 874f9afe-6e54-4e3c-610c-08d97a08408c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 18:23:31.4439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GG8CVj+4DPHlx3NlW72k925DNQ7vMaFguNygjRZoRlmRIkjj6cDXHiRGh0M9Sn5McVM+IyqeGnM1Mblqf5nYHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3142
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10110 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109170110
X-Proofpoint-ORIG-GUID: i9vV63_ItDI_PIE-IfdNcFW250gYNlzp
X-Proofpoint-GUID: i9vV63_ItDI_PIE-IfdNcFW250gYNlzp
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 9/16/21 1:15 PM, dai.ngo@oracle.com wrote:
>
> On 9/16/21 12:55 PM, Bruce Fields wrote:
>> On Thu, Sep 16, 2021 at 07:00:20PM +0000, Chuck Lever III wrote:
>>> Bruce, Dai -
>>>
>>>> On Sep 16, 2021, at 2:22 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>
>>>> When the back channel enters SEQ4_STATUS_CB_PATH_DOWN state, the 
>>>> client
>>>> recovers by sending BIND_CONN_TO_SESSION but the server fails to 
>>>> recover
>>>> the back channel and leaves it as NFSD4_CB_DOWN.
>>>>
>>>> Fix by enhancing nfsd4_bind_conn_to_session to probe the back channel
>>>> by calling nfsd4_probe_callback.
>>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> I'm wondering if this one is appropriate to pull into v5.15-rc.
>> I think so.
>>
>> Dai, do you have a pynfs test for this case?
>
> I don't, but I can create a pynfs test for reproduce the problem.

Here are the steps to reproduce the stuck SEQ4_STATUS_CB_PATH_DOWN
problem using 'tcpkill':

Client: 5.13.0-rc2
Server: 5.15.0-rc1

1. [root@nfsvmd07 ~]# mount -o vers=4.1 nfsvme14:/root/xfs /tmp/mnt
2. [root@nfsvmd07 ~]# tcpkill host nfsvme14 and port 2049
3. [root@nfsvmd07 ~]# ls /tmp/mnt
4. CTRL-C to stop tcpkill
5. [root@nfsvmd07 ~]# ls /tmp/mnt

The problem can be observed in the wire trace where the back channel
in stuck in SEQ4_STATUS_CB_PATH_DOWN causing the client to keep sending
BCTS.

Note: this problem can only be reproduced with client running 5.13 or
older.  Client with 5.14 or newer does not have this problem. The
reason is in 5.13, when the client re-establishes the TCP connection
it re-uses the previous port number which was destroyed by tcpkill
(client sends RST to server). This causes the server to set the state
of the back channel to SEQ4_STATUS_CB_PATH_DOWN.  In 5.14, the client
uses a new port number when re-establish the connection this results
in server returning NFS4ERR_CONN_NOT_BOUND_TO_SESSION in the reply of
the stand-alone SEQUENCE which the causes the client to send BCTS once
re-establish the back channel successfully.

I can provide the pcap files of a good and bad run of the test if
interested.

I don't have pynfs test for this case.

-Dai

>
> -Dai
>
>>
>> --b.
>>
>>>> ---
>>>> fs/nfsd/nfs4state.c | 16 +++++++++++++---
>>>> 1 file changed, 13 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index 54e5317f00f1..63b4d0e6fc29 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -3580,7 +3580,7 @@ static struct nfsd4_conn 
>>>> *__nfsd4_find_conn(struct svc_xprt *xpt, struct nfsd4_s
>>>> }
>>>>
>>>> static __be32 nfsd4_match_existing_connection(struct svc_rqst *rqst,
>>>> -                struct nfsd4_session *session, u32 req)
>>>> +        struct nfsd4_session *session, u32 req, struct nfsd4_conn 
>>>> **conn)
>>>> {
>>>>     struct nfs4_client *clp = session->se_client;
>>>>     struct svc_xprt *xpt = rqst->rq_xprt;
>>>> @@ -3603,6 +3603,8 @@ static __be32 
>>>> nfsd4_match_existing_connection(struct svc_rqst *rqst,
>>>>     else
>>>>         status = nfserr_inval;
>>>>     spin_unlock(&clp->cl_lock);
>>>> +    if (status == nfs_ok && conn)
>>>> +        *conn = c;
>>>>     return status;
>>>> }
>>>>
>>>> @@ -3627,8 +3629,16 @@ __be32 nfsd4_bind_conn_to_session(struct 
>>>> svc_rqst *rqstp,
>>>>     status = nfserr_wrong_cred;
>>>>     if (!nfsd4_mach_creds_match(session->se_client, rqstp))
>>>>         goto out;
>>>> -    status = nfsd4_match_existing_connection(rqstp, session, 
>>>> bcts->dir);
>>>> -    if (status == nfs_ok || status == nfserr_inval)
>>>> +    status = nfsd4_match_existing_connection(rqstp, session,
>>>> +            bcts->dir, &conn);
>>>> +    if (status == nfs_ok) {
>>>> +        if (bcts->dir == NFS4_CDFC4_FORE_OR_BOTH ||
>>>> +                bcts->dir == NFS4_CDFC4_BACK)
>>>> +            conn->cn_flags |= NFS4_CDFC4_BACK;
>>>> +        nfsd4_probe_callback(session->se_client);
>>>> +        goto out;
>>>> +    }
>>>> +    if (status == nfserr_inval)
>>>>         goto out;
>>>>     status = nfsd4_map_bcts_dir(&bcts->dir);
>>>>     if (status)
>>>> -- 
>>>> 2.9.5
>>>>
>>> -- 
>>> Chuck Lever
>>>
>>>
