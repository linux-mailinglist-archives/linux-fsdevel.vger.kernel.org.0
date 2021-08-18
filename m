Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CA63EFA4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 07:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237752AbhHRFo6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 01:44:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39790 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237588AbhHRFo4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 01:44:56 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17I5g9Au000916;
        Wed, 18 Aug 2021 05:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5p/OVnxTx6PpxDh5it5p4fn5ZR0cXIqzMZeW/aCETiM=;
 b=uzsFF180MQGewYIKumz2GK39XOL2meimtK1vhi5BVP5VvY2xmVB08+oo2OklaEOsqGpX
 QG1xLKpYAc71tcI8u0dI/L29pcpVn4qkkkgsStIBPSQhezBDpnTuVhSP/XOft+G+6UK1
 2Ay7bkWkHES2r+dVfTHkaW8wt9X8uqyglUtGElHQjzlu/8zZ6gQXf3qJrjDFtgvpxH6z
 7c5ZoNxOAHpYnA0dz1MICOHaslCoxsa7AJzHTH1Hr5hauSZxVVIpaJ//+dMW8IfSsaGO
 aodLg8wfb7Kg/s8tKKSm21p3EG1OCzJHL0aXrKFqjexVr4bZYKjpy0d1O9cUvigZJz6Q mQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=5p/OVnxTx6PpxDh5it5p4fn5ZR0cXIqzMZeW/aCETiM=;
 b=LJivFJaP9QRY6//gAi0b1+DPTDDvhngkbrCgGne/jaMM+xhlaY9Pc0SEZhNTm3j+UJr7
 Sv5w1o7sJp/sdD1e/7xWFpsfyw0/Fr7zcrXmdXgigbNqUY1eo+caiWS77C7dl4B0UghP
 c15N5lwDrBPUmaPP7Asobol5AQFdUSKtEVBQM62e3TFMjA1qgPa3Gja/p8OGFatiC1mq
 Cnt1WWZ0YhzhigwYTG1JEq9N8KwsPDLkiZ3M2cRVn+knea9arFe7B9lj2DkzfVAToQMB
 oWwx/8MpVnbCzBOeyg0hgOHJTuYSIQxkpz2KjlQSNO+6578SHdpn7Ke5Z/o+qwRPr45V JQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agu24g3dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 05:44:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17I5eoOd150680;
        Wed, 18 Aug 2021 05:44:01 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by aserp3020.oracle.com with ESMTP id 3ae5n8u99p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 05:44:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gs/5dxPU1lPYXWJTihxQGmbr7G8Q69Xsc4gSLxfb15yPldji8Z9s6SlspoWVe1rekyTwMBSzS2y6lqVeNlL1BtNPbnXoYSziPbAwUlywN3K4+Vq5uHY5h/pnXNRaQmBnP4G11pfUOn6ZdFKS2CRJ6hhE21Z9R/S6zzFqfqHS898hLZxJITQrtmb8e9SjnhFlJ3XeSS+dbzx7Gcx84MJAOA2KQvgKyHpgSWUXkByOjRzPLT+QyAMMqUGG6XH3/DMWuzlVZ4Ojg+oLqy48fNALHXj5BYKl1o5QUEbH9JXdu9CJYPG/TNOtDVboKjrL00cdNF6KqGInNt+fzELGywK0rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5p/OVnxTx6PpxDh5it5p4fn5ZR0cXIqzMZeW/aCETiM=;
 b=mOeEyO6g+svqLdq/007lnrX3883ti1dnfLhB5Do7ScyWv6A4DTDvalsf5iZYT+xz4k7QTNKeO5rKfRgMoTFpWyUVS1omw1AX7g1rOxTm458I4iEpDn/jyv7ut6JjDFZV6qKDb1rQgzkU0/+QIHmLoFWrIr633tAe0ha3UE7UjeZsN+JyHzTo0QemLtfoQvvAk1VrGzdxxw6SnmD/W/WR23ihsUmE1h9mH3hnRycWA/MFF5eyB8N/mbundBtbMJ3ummGc37AeAIA0tFl0BTcpEiPH2VP0vNj511KbeO+52B4OQP0732GPL3PSfjxfVBn1uwtlSBWQdyIQGlz5/na/fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5p/OVnxTx6PpxDh5it5p4fn5ZR0cXIqzMZeW/aCETiM=;
 b=Ry9o5uL7al9tmiZQfOaYIlAvaZxYBP24uxp+DPAoH3ggsQbPLyF7iAh8JsZBb5vcWkV+U4Zh6XpCbkgCE4OMEYUOsVFy1SYST31YgWLOnkI+fT2r7WM1PCVLYZKnV9AinHowDV5XCOdz7k/buyl85wLdvZwuHu59X3rGEYjJD4A=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ0PR10MB4813.namprd10.prod.outlook.com (2603:10b6:a03:2d2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Wed, 18 Aug
 2021 05:43:59 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::bc10:efd4:f1f4:31c7]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::bc10:efd4:f1f4:31c7%5]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 05:43:59 +0000
Subject: Re: [PATCH RESEND v6 1/9] pagemap: Introduce ->memory_failure()
From:   Jane Chu <jane.chu@oracle.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com
Cc:     djwong@kernel.org, dan.j.williams@intel.com, david@fromorbit.com,
        hch@lst.de, agk@redhat.com, snitzer@redhat.com
References: <20210730100158.3117319-1-ruansy.fnst@fujitsu.com>
 <20210730100158.3117319-2-ruansy.fnst@fujitsu.com>
 <1d286104-28f4-d442-efed-4344eb8fa5a1@oracle.com>
 <de19af2a-e9e6-0d43-8b14-c13b9ec38a9d@oracle.com>
Organization: Oracle Corporation
Message-ID: <beee643c-0fd9-b0f7-5330-0d64bde499d3@oracle.com>
Date:   Tue, 17 Aug 2021 22:43:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <de19af2a-e9e6-0d43-8b14-c13b9ec38a9d@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0230.namprd04.prod.outlook.com
 (2603:10b6:806:127::25) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.159.249.154] (138.3.200.26) by SN7PR04CA0230.namprd04.prod.outlook.com (2603:10b6:806:127::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 18 Aug 2021 05:43:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34471138-98fb-4935-d0c9-08d9620b2cd9
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4813:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB481369FEC0E11BBC4FAF28BAF3FF9@SJ0PR10MB4813.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AhcUfsrfu3GBc20c/M0FejxayUFFCCeWvwmwNAIuvy42zHW/tAlXDMTgpVMNemrnlsOixp8Cx1ajNI6z/71F/JG81It3kdvqLVp+ug/cQZUOHmPLrTmFVQaLW7se+0Am/ATJ8I4MeU57+fWTNRS2aKGPYYBuX5Ni6CdvJ+d7Nl0z2dJweeQBvA4UTNJuKn+eZKc/n1y4pdJmyZQXWZSjwpZyLAwBHNEpMWyg98T/fl2Ikrp0enFf9o8fk/q3jQcKxGpdFLO3bzDVTb4x5Y40SWCUHMrMm5fjuskCtLL88ls2m+TdffxjTxcZsyD77FMKzggoE/E8XkeAZuY8tYcAYKTAXKLR0g/cNHXp5BKrxFLxqR75QZbRAk9Tcp1aZeXbUQjrvy+S0n0lsjZA1imbbagv2Xs0C8LrqcwoIm3TH58LpczRJZMPTI0zOBRJhWSFFiiCRDBsRDXGGXsFaern5XW05T3tRhg3+HqqmZAmbofpOYTVuYD4hetZJbybyzu9WlfI9tOWDO2OLilbtyVhV9VFtvWWfvvmOk+k8isW2U1nMG8X3kSR/qFu/ZkahNvU2rqeyNCp8PwMAQL4ZXnkoUpCx5KVMmnplBkmjc81HKHnCZJNcRwtZUce0d52I4JqXiyUX8dItZiADUgFbg2AgJt7S3LS4gv2FpU/VhycH1WlzsdWsOq4skr0cX+aM0GiH7SWUbP0aN5jbewZxqc9JLZEgYQRkp6zX8Qr8X9MNv8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(376002)(39860400002)(136003)(8676002)(53546011)(36916002)(66946007)(2906002)(66476007)(8936002)(86362001)(83380400001)(36756003)(38100700002)(478600001)(66556008)(7416002)(4326008)(26005)(31686004)(956004)(6666004)(31696002)(5660300002)(16576012)(6486002)(44832011)(2616005)(186003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjZML0dINXFWajRoZUNkOXJsbWFyem8zMkJMWnhjOEdiR0Y0bXZnSlk0QmhN?=
 =?utf-8?B?ZTBlczhJd0p3OExPY3BYQldWUTJ0aWEvQ2JhclBmWEo3L21qdm4veUY2a1Z1?=
 =?utf-8?B?d091UE4zMGcyVjluOGZkUEdpUkhldlMzQUo1eWpKVVZJREwxVUt2dTdhcnJN?=
 =?utf-8?B?MnlYRnJ3c0hFR2NWNFpaODFvWEorL0JHYUVHTkJqa1pZZ1ExTit4cjhhemJ5?=
 =?utf-8?B?bER1K0dxbi9OTFRBaG1rR2RMNHdJaGdodGh4eGdCUnduZUdMUHFtS2phUmQ5?=
 =?utf-8?B?L0kxaW9aTndrR1JGYkFNZFp6cHkwc2RPT3AvdXJZaEp5RklZRXRkaUh2TnZm?=
 =?utf-8?B?N3c0MWFQL3VucWtwbkJKQ3NEWnMzcy9pZngvYUFMMFdQbnIzUkFHOHJPcmhJ?=
 =?utf-8?B?bW9HMk44SGJhT05JaFFTSVhRZWN1dU5lMnpmVnlJWHRwdk00V0JtNmVNRlM4?=
 =?utf-8?B?MndWVFNoOGloVGJxbXBDYkJJdTFGR2FRRGhqZEorR1U0NXJpT3RtWU5CZW91?=
 =?utf-8?B?YUJwRzl6ZXo5MUU2dnFwSjRpT0IvcGhwVVRXMzRNU2ZjMjV3YXE1UE1KaW5y?=
 =?utf-8?B?OU5ualdLUUdNcWllcHJMa1BkZmFJWThIdXNZcXpXUUFYTEJhM01iVkxTKytm?=
 =?utf-8?B?Tk5semQ0NUYwVWFHeDhGSTRJdCs5RFVHMEMwdExrZjlQT21jbVdDWHFuZHN2?=
 =?utf-8?B?Y3hCMFIxa2lqV0JwTTA5Y2h1eXIxRzFnZTFmV0Jqb1hDOWdJbWhsN2NJYkgw?=
 =?utf-8?B?R0pIVnlMcjBlVkFkSi9iRGU5SmUyUWNBTHd0a2VEa0hqWFhJQlppcjdWYjEr?=
 =?utf-8?B?L2NXYkg4QmZZTk84aVpXYTBTWUlzRDljKzRLb3lvN3JzNEhzdXZPRVBJVnFI?=
 =?utf-8?B?U0pha3BiSjQ2emcyeFFXUGhpWGJpNFRNVXp2VURNTjBHMk8xYTY4N0crVzZn?=
 =?utf-8?B?Nm5mOVVFVU9tL3lsSWI0YVZwNHk3b2U4cTlUajZ6V2E1czBIb3lvcVJRN0Mv?=
 =?utf-8?B?emlpT3U2UCtNYWxLdnJPektzNHVldkNmcHJxVThiTkxYTkhlemFBWHBTaFBW?=
 =?utf-8?B?N0F2cTdyVm5NT1BadEpyZ0h2RmNzYy9kZXp5UmtQNzY2Tll1R21KZ2Fxb2lH?=
 =?utf-8?B?U3ZPbEt0Wmc5elJlSTBkbUFUODQwU0FJWmlaMFI4VmZESzFBS0VkOUlsSUVP?=
 =?utf-8?B?R3dzek5ETFZNVUh3WHhVY0xoY1lCdGVTVnVjM2UyamFjMWFDTGpTMzZ0amVl?=
 =?utf-8?B?WGZDWkR0RTY4Y1dsM2JhS0xWbTlzb0ppMHZ1MlJrcjJwM1FWMVR2Z1hyay9C?=
 =?utf-8?B?RHFlL0tHaTNiakxGMFlEQzV1SVlKSExTUzh4cnhjdGpOYjJhbDQ0bW9hT3ZJ?=
 =?utf-8?B?UmU2QUFwU0dOSjZla0FpY0syWXhCaE02K3kwVFV4WjByMk9XMUpXdW1rNEQw?=
 =?utf-8?B?VkNBQ1pBamxRcFBQcTBXWk9WMUNrVHRrZGc0MTFNUnhKekpzTTFsR3g4Ymow?=
 =?utf-8?B?VkJqNklxaVNWM3BPc0lacTlSZ3YzMjExc2RaWGZVd2FtUmtiY1kyUzNWd01r?=
 =?utf-8?B?MlNxai9Vck9ZazkrNmhBY2ZYS2RkYllBTWpMdGJrZFhxY3daeE9oS0gxVWxk?=
 =?utf-8?B?QzF0SjZaclk1cVJQWnFUUzRTSG1YWk9tYTJHWDMzN0I5Tndhc3RiWllXUGt5?=
 =?utf-8?B?NjEydHhvZnE3WHg0MnQ1OEJxaUg0TTZidk95ZVlkVTRFUmt5QlNkLzNaTksr?=
 =?utf-8?Q?7UtdhNT5SL6OtvkPYqPtH6hjsE8Xu6iRywidxHu?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34471138-98fb-4935-d0c9-08d9620b2cd9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 05:43:58.9107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJIDL0oAHbnk68nM23JVP6kLfv1o2aMEEaWOgrff6JFRomzxz+CzMCrK/Pe2OxEZYtcZUwtdB3C9EtZ/con0Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4813
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108180035
X-Proofpoint-GUID: _g0KuBJjGJrbh39sATFznJ9HFw1qCnrv
X-Proofpoint-ORIG-GUID: _g0KuBJjGJrbh39sATFznJ9HFw1qCnrv
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

More information -

On 8/16/2021 10:20 AM, Jane Chu wrote:
> Hi, ShiYang,
> 
> So I applied the v6 patch series to my 5.14-rc3 as it's what you 
> indicated is what v6 was based at, and injected a hardware poison.
> 
> I'm seeing the same problem that was reported a while ago after the
> poison was consumed - in the SIGBUS payload, the si_addr is missing:
> 
> ** SIGBUS(7): canjmp=1, whichstep=0, **
> ** si_addr(0x(nil)), si_lsb(0xC), si_code(0x4, BUS_MCEERR_AR) **
> 
> The si_addr ought to be 0x7f6568000000 - the vaddr of the first page
> in this case.

The failure came from here :

[PATCH RESEND v6 6/9] xfs: Implement ->notify_failure() for XFS

+static int
+xfs_dax_notify_failure(
...
+	if (!xfs_sb_version_hasrmapbt(&mp->m_sb)) {
+		xfs_warn(mp, "notify_failure() needs rmapbt enabled!");
+		return -EOPNOTSUPP;
+	}

I am not familiar with XFS, but I have a few questions I hope to get 
answers -

1) What does it take and cost to make
    xfs_sb_version_hasrmapbt(&mp->m_sb) to return true?

2) For a running environment that fails the above check, is it
    okay to leave the poison handle in limbo and why?

3) If the above regression is not acceptable, any potential remedy?

thanks!
-jane


> 
> Something is not right...
> 
> thanks,
> -jane
> 
> 
> On 8/5/2021 6:17 PM, Jane Chu wrote:
>> The filesystem part of the pmem failure handling is at minimum built
>> on PAGE_SIZE granularity - an inheritance from general memory_failure 
>> handling.  However, with Intel's DCPMEM technology, the error blast
>> radius is no more than 256bytes, and might get smaller with future
>> hardware generation, also advanced atomic 64B write to clear the poison.
>> But I don't see any of that could be incorporated in, given that the
>> filesystem is notified a corruption with pfn, rather than an exact
>> address.
>>
>> So I guess this question is also for Dan: how to avoid unnecessarily
>> repairing a PMD range for a 256B corrupt range going forward?
>>
>> thanks,
>> -jane
>>
>>
>> On 7/30/2021 3:01 AM, Shiyang Ruan wrote:
>>> When memory-failure occurs, we call this function which is implemented
>>> by each kind of devices.  For the fsdax case, pmem device driver
>>> implements it.  Pmem device driver will find out the filesystem in which
>>> the corrupted page located in.  And finally call filesystem handler to
>>> deal with this error.
>>>
>>> The filesystem will try to recover the corrupted data if necessary.
>>
> 
