Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C2830E506
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 22:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhBCVgg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 16:36:36 -0500
Received: from mail-eopbgr150103.outbound.protection.outlook.com ([40.107.15.103]:40236
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230033AbhBCVge (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 16:36:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVzggzi770gycqqdEuXS+c1tNNFOAe9IQbWkeo/WnErb0Mf0jIFDCMZX90j6A88vT/Cwc7IOxFnNILa6N+12gKydhy8g+Zkak7Odbbol/4ZcIbWB82tl2NpA9hlzrXiwpo3xEjwx79+jJKaMaP0j70lWwkWX2HA8uSfX5PktpIwJGAhoiIUFsQzyorpJQi7RH1v60WMjDu3C7t2zHqHFCWX6X59iWEQ5QXlIqSFC9iOqx8ZEzhsz1uMIdeUev99OkwuluiGG8RQBDjUuHLMFT0njx4A8KOaUEnJwAIYwMBda1lrHAwgpvEzfetX1NYe12zYJgf2gvcaaMNNTC9IkoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKus5YAF6Cq2lrInE5tz+qGWZwZxBoxYMRuanAzwDtw=;
 b=DiGewgINp2be33U2tqe/TcZQX5B/B4s39NqLmq3g20OPrSOABzIdaYJO0y2G4NxjksoWQlkDir5rB6z5qQrEullIrXiSpNzWuHZd1QulSo4lAMtjSy3DHpK5I11Ab4wF7+AJPltVUzQCojh4oK0BFqvhFIRuD4azRvaM5Aa18jDMTs/l7JY+0JCNEex8GE19s2l7wrKAS5r5aEScnjC2HuupsvgW4issfCB3XUFS5SR9wekbHW+bgX650yjzRJuCr3p1UGskH4+/1ZojftNrirLEojHpcY5Eto1cGKIW20ZH5KVu6ykb88Dqe8rplyq0v2dhL5A2iZAF7PglAqDHqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKus5YAF6Cq2lrInE5tz+qGWZwZxBoxYMRuanAzwDtw=;
 b=Vjl1jWvFy9V3aYruxReDndGphvB2k9AE3w8aGDDjTFmlkxnmPkoHXNmYPyaeJLCdYd1NfEGcvHzb1AI0qvxyiqxf8/uoFG7sFF8b0A5vwxaaUn5DxmTWgnrxHoQIoQMeweMpdF0alpoS3RHQU6tzW7ZHlX+YF6ThZ4X7UXnLXIU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by VE1PR08MB4990.eurprd08.prod.outlook.com (2603:10a6:803:112::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Wed, 3 Feb
 2021 21:35:44 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::61e0:7654:24b6:9159]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::61e0:7654:24b6:9159%6]) with mapi id 15.20.3825.017; Wed, 3 Feb 2021
 21:35:44 +0000
Subject: Re: [PATCH] fcntl: make F_GETOWN(EX) return 0 on dead owner task
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Jeff Layton <jlayton@poochiereds.net>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>
References: <20210203124156.425775-1-ptikhomirov@virtuozzo.com>
 <20210203193201.GD2172@grain>
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Message-ID: <88739f26-63b0-be1d-4e6d-def01633323e@virtuozzo.com>
Date:   Thu, 4 Feb 2021 00:35:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20210203193201.GD2172@grain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [81.200.17.122]
X-ClientProxiedBy: AM3PR07CA0071.eurprd07.prod.outlook.com
 (2603:10a6:207:4::29) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.192] (81.200.17.122) by AM3PR07CA0071.eurprd07.prod.outlook.com (2603:10a6:207:4::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Wed, 3 Feb 2021 21:35:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c704da06-ac8d-462d-6eac-08d8c88ba994
X-MS-TrafficTypeDiagnostic: VE1PR08MB4990:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-Microsoft-Antispam-PRVS: <VE1PR08MB49902A0B2BDB808AAEA7FF2DB7B49@VE1PR08MB4990.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V46xHCUV+eEuBoF535skCY+dRFvm9tFlgIyj6qblxpecevotjhYvkXcjnAt60Qp9Z3esDbTkVeWWcdZv4AHuFU3/VyVVO5qQ9GtciMhL4/PyVr1l3jpg6Lg50gCqq0TMhU3BwGAlGBfrxsRZthAwzSim3nS5c5C5qYfAyUW19K9+PV8DgppAN4dPiA8hozyt4k+8VcIEEb+s25qyzHNBqif9wR/xtaqB4YjQtqk1zHG52ksmJiQEcnh6H00hobp8LrjdvkFKiSuSqJrgIizQMLIO6uOcoYSV+BvZhvLm3/ehy9HqtbVbaZlcSGNQKKw6NnXRRb50xL9xuCXL70FABRJa598yfNIexeupemKERDF1f10IZrYTGTqYmYLIlhid7vPC5z4cszKHWUYx9amOhBMStNMeDqTpfqVXgWYbjadeoM719btVVsPKqpn8M4bbq7Z1tTYx9jcJf2Z/ODE0IXAdpoJcYaYO4NQ2djhkQ/IzbHEuQwW4yYK1c5iTrpzW8ay3OLQknKjzklxrhrlZCojZ8rrny/JLXNFSUjXM6CxSitCDZYTHE2h36LhdL9XT3mH6y8WhWKGlu5RLEBVeB6vEcgyHPPG72+9GsHr5ZJa3zrtzL46aj3uaZ3aACk04QQx25QVXvEC2KwOp0f6rS01OvIQoBuTsvYUj4oW8tuAiYPn3ONOCLf7p93vdr39q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(136003)(396003)(376002)(366004)(346002)(8676002)(66476007)(66946007)(4326008)(66556008)(5660300002)(31696002)(16576012)(316002)(54906003)(36756003)(6486002)(16526019)(186003)(2616005)(86362001)(83380400001)(956004)(53546011)(31686004)(478600001)(26005)(6916009)(52116002)(2906002)(966005)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V0lGRTljTnY0VDBzT3pNSTYyTlgzYnZqamVOWXBBcmgxaitzSW9uZXQ4cG84?=
 =?utf-8?B?dlpxYzR6MHNBclRqKy90SmozVGFWTkRjd0xJR2VPNjFILzlsZjFDVW94dkJE?=
 =?utf-8?B?Q2lLZEE1QytBSGRNbmFoMzhIN1MrdFI4VkdmejZNWHVXekZKek56M3ZMRjRt?=
 =?utf-8?B?aTZ1cU5jRWhEcUpiaXZobncrT1BHeUV4RGl2TUF5cWRiQkZKUXMrQWlUVFJq?=
 =?utf-8?B?MGZYakl4UnE4SXprSFYyb0JOalhGQkxLQ09WTWZ3bGlLa3Z4YVlaaE1aV1Jt?=
 =?utf-8?B?WElmN2ExTUJuNzNYbnZpYi85NHNTMmRNR3FVbXc2UFRsdWhweUhHM09CVnBU?=
 =?utf-8?B?ditPNFpMMU1Od2t6NWU3ZDc5WldiaGJFZE9iNVFsQk5PdGlnVkZzTU04S05X?=
 =?utf-8?B?OFY0SjE3ejRJNWUvU2Z1NEh6NUo0MEZWNDl3YldmSWJnbDhKZ3VSc1pCQ0p0?=
 =?utf-8?B?akJwSUlzeGliVXZUOXJhYTcrSkk3c1Vkdm1ud25VeWt6QS9rVC94RERNcVcz?=
 =?utf-8?B?b29UOGMycDNPUmJyVnNaeVdmZHRuSitNUmNWYlhRL3QwQ0pkcXlQMy9oanJH?=
 =?utf-8?B?RTN3L1ViVXNGaTBsTWxyUjhXdlJVSzdCdjBiSEdVUEpwM1kzbzhwTjIzMHNx?=
 =?utf-8?B?U1NBS3p0b0xIeVB6dHJ1ZEJFbkRaVSszN1VFbTNXUG15blo2aURQSTBaSktv?=
 =?utf-8?B?T1pJWGY2ZGN3Z1k1UzRRcG9jZlFsV2dzT1k0OHNFL0JSSUVoUXJVMXpnN0Nz?=
 =?utf-8?B?eE5RSTBOejN1eEgyMUI5RDFXZy9JTkZhekhaL1RDMUxmY0JSMFJRUFNHY0tl?=
 =?utf-8?B?Wklleng0VlhqU0hSTTE3Rlg0Sk1lZkk2anNLNmZsenByemhuMzB6L1hMUFZk?=
 =?utf-8?B?ZTBrNVNhRDJ3SGVsSXhHMWo5NFpMOVRvYXJrMzZlZEhZbGZBVndIcGdxL1Zw?=
 =?utf-8?B?QlVMMnlsMThrTkx3K2FGb3VhbGZ3TklFUHZ0am1lUm5WZktPR1JUYU5iVEh6?=
 =?utf-8?B?MURlWEpRVmZTWG1YRkhRbStNVzBYeFNqR1ZIUkJ0ZTJiSnJNR0FDb0FBTTUy?=
 =?utf-8?B?Mk1xU2hqazJWUmsyLzV1VTNQVlJDYWRJM2gyMllNYUhKaDRrcnV3TGx6L2hC?=
 =?utf-8?B?cTNSYmQ2ZzFtNWoyRjc2OUlKR0YrRmxlczg0ZUZxOEdyZVhkRUlSQU9rTVYv?=
 =?utf-8?B?S3BZaDA0WDBtSERxRlhVTTJ3WUZhdTUzZ3VnWk96aFRaQnNaL2ljTS9pYVlD?=
 =?utf-8?B?a1RRVFRIekVBNzEvcnJZOHEvU0dNVzhMK1o0SkJxVmtWTmpaVVVESUt0OXRx?=
 =?utf-8?B?NGdXOHZVVWxkWVhmQVlRV25Ed0lJVlJRSDdNalNhTGlSVGlXNnN1WWtmNElS?=
 =?utf-8?B?ZlhjcEFpbFErZWxLVVY1M1RuVy9aZHBwbUQvbFU2eCtOeW5iRThyOVVMZWNt?=
 =?utf-8?Q?bkw/qRGl?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c704da06-ac8d-462d-6eac-08d8c88ba994
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 21:35:44.6560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QoH6j1UPVpJNHdPMSqX42HErYTQr2n8lXrLlSkSY5zJPjZnRP5/OeTdremVf/h/6cMihmd+LA6yVD6ovNblZfi/zk+FbJCiM3xLOwCFbUn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4990
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/3/21 10:32 PM, Cyrill Gorcunov wrote:
> On Wed, Feb 03, 2021 at 03:41:56PM +0300, Pavel Tikhomirov wrote:
>> Currently there is no way to differentiate the file with alive owner
>> from the file with dead owner but pid of the owner reused. That's why
>> CRIU can't actually know if it needs to restore file owner or not,
>> because if it restores owner but actual owner was dead, this can
>> introduce unexpected signals to the "false"-owner (which reused the
>> pid).
> 
> Hi! Thanks for the patch. You know I manage to forget the fowner internals.
> Could you please enlighten me -- when owner is set with some pid we do
> 
> f_setown_ex
>    __f_setown
>      f_modown
>        filp->f_owner.pid = get_pid(pid);
> 
> Thus pid get refcount incremented.

Hi, and yes you are right about refcount is held.

  Then the owner exits but refcounter
> should be still up and running and pid should not be reused, no? Or
> I miss something obvious?

AFAICS if pid is held only by 1) fowner refcount and by 2) single 
process (without threads, group and session for simplicity), on process 
exit we go through:

do_exit
   exit_notify
     release_task
       __exit_signal
         __unhash_process
           detach_pid
             __change_pid
               free_pid
                 idr_remove

So pid is removed from idr, and after that alloc_pid can reuse pid 
numbers even if old pid structure is still alive and is still held by 
fowner.

Also I've added criu-zdtm test which reproduces the problem:

https://src.openvz.org/projects/OVZ/repos/criu/commits/e25904c35dbc535f6837e55da58ca0f5a5caf4b3#test/zdtm/static/file_fown_reuse.c

Hope this answers your question, Thanks!

> 
> The patch itself looks ok on a first glance.
> 

-- 
Best regards, Tikhomirov Pavel
Software Developer, Virtuozzo.
