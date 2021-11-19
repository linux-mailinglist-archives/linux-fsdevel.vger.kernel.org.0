Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134CF456CBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 10:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhKSJx0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 04:53:26 -0500
Received: from mail-eopbgr60130.outbound.protection.outlook.com ([40.107.6.130]:20804
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229457AbhKSJx0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 04:53:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ensjpMnKgH2W8EDsvDC5UCLLLvX+eb2S4VsDfHkJOqalY8fC9c44eZ8EJ6ZGILerOwZrJHNaUh4/brk5nXwnM2hx9ysXmxxRLHX3W6wjmOQlxo30pKrJ5WGSwVRqzzqz4i40aVaJf73m08kLCzk/ozHgDTEgNROAuk4V4imqV27HOc8z/Nt68bgH4ommFDmpZJuPpwAGQQHIeXOSBWIWDEk6ehAvmmKKtcI427wI94bHyL0aCyjSRlDPQ4vY9v5mXOmM267elPo8Fx7r0hjX7U5pq97ueIsr7EIxMNelRbUOoqJDI690mXMtbrOZfysUx6z5M7RIBbBXKjD71NKnuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuLudYwPVzXExPsvnTV9EKi3cpNKf/BxqXri1gcmmUw=;
 b=YCR+LuTpk9BmepaNtNBuIECv4fd5LgWnhGL558dMNH6i6MLMbccP2IKs6bkKlCGmpYqA48AKrEP/XllJJ8HEOO9F+7n0EZDFswO7YmEaxTgidRK1B9b9nFvlas5Yk/ctFE9pNmMoiSqVw8EEhngiyO/elvvli7/i06hp/S8rP5vtiJ3MMOJsiJTR89Mqxugn5VcfU4+ZHetzC90ITljsALGp1wTFdZSV6CaSYWvtu/o2QaJ1xdmBuI2qaGBxWXh89Z/Xx28yw9xXELZElpWn6QiTk/WuVKJV0Sj9E1r0qwmsDTXQa6nu8jVaxmAJWrHP7vcusYUvZK6auxPPx4xF3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuLudYwPVzXExPsvnTV9EKi3cpNKf/BxqXri1gcmmUw=;
 b=UxTtH0glJFMvAJ+HLacgCcjdnJme4/z2e/IN9qxfLWFLoSuiPJgdHfuTTM+A6R8svPCIaE2rTz8X+k+FGNd6u+oVRdGu0TfquuRlJgG5H1fhSjuQn1xjNGNp1QxGkkGJ//hd8a46Kbqcd15LK9u1XP5ps16Ga1z807IfD126f3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DB6PR0802MB2374.eurprd08.prod.outlook.com (2603:10a6:4:8a::21)
 by DB9PR08MB6746.eurprd08.prod.outlook.com (2603:10a6:10:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Fri, 19 Nov
 2021 09:50:23 +0000
Received: from DB6PR0802MB2374.eurprd08.prod.outlook.com
 ([fe80::14cb:77c8:e84:114e]) by DB6PR0802MB2374.eurprd08.prod.outlook.com
 ([fe80::14cb:77c8:e84:114e%6]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 09:50:23 +0000
Message-ID: <40a50479-c18d-7f2a-bcb2-7c8eb5376381@virtuozzo.com>
Date:   Fri, 19 Nov 2021 12:50:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [RFC PATCH 0/4] namespacefs: Proof-of-Concept
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, mingo@redhat.com, hagen@jauu.net,
        rppt@kernel.org, James.Bottomley@HansenPartnership.com,
        akpm@linux-foundation.org, vvs@virtuozzo.com, shakeelb@google.com,
        christian.brauner@ubuntu.com, mkoutny@suse.com,
        Linux Containers <containers@lists.linux.dev>
References: <20211118181210.281359-1-y.karadz@gmail.com>
 <87a6i1xpis.fsf@email.froward.int.ebiederm.org>
 <20211118142440.31da20b3@gandalf.local.home>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
In-Reply-To: <20211118142440.31da20b3@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0161.eurprd06.prod.outlook.com
 (2603:10a6:20b:45c::11) To DB6PR0802MB2374.eurprd08.prod.outlook.com
 (2603:10a6:4:8a::21)
MIME-Version: 1.0
Received: from [192.168.1.86] (176.14.222.90) by AS9PR06CA0161.eurprd06.prod.outlook.com (2603:10a6:20b:45c::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Fri, 19 Nov 2021 09:50:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f487d91d-8506-41bf-9294-08d9ab42016a
X-MS-TrafficTypeDiagnostic: DB9PR08MB6746:
X-Microsoft-Antispam-PRVS: <DB9PR08MB674674632ED6AF70C4AEDBAFCD9C9@DB9PR08MB6746.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mIiYF5NB/7xRYJbGkGJ8rEDR6N5vs2VXVIbPoRwrCynm2ooNpAn3VOifff9o2mcQbc8raoLat0BoFVOssvXIo/qGmJ1mLAADeNorAKSn6/ZvOVt5Uzu+9VlNPeH29SP0jbSgg1Xpss/5GU8/acAHQaPWeB7HeHnf6UrmhDmD9po0uyzv14pYhvTerf35FO2SvphevjW9jCN0Qx5AeFIRHeUnoWdGxIBtxTDQ2Wa9On0IABEIgMpPmzigYumFEL5bWt3jS5qrey6ocaKFrQwalrsJ+6qfBAqOUfmJnkWjElr7AQw8ET260kUNHFa/xA2/4Wz/Qf7RNQsvBwH/3mITj0+CDb0Kq7+fHe00qU3iMdqieWm+nMhLJPWY/S0qG8VPfLyfWk0VfveLR45Pe8L6AZYZRMYK2EaSjkQVUSzypeVXTEKr4eFL+cbZ+p5EAM4M0huwaEGNpuo/loGAQZmNQPCbTOVo1D7FlYGjaQWWQueVxHmo9LdwL0n5HVvs/vSZWQcV6B5h0sUdDCN2uMM1t2B6PZJLiZx8q6j0OuFr3kAdTlyunfQBrJ8huu6LNuqWDZLUMYfPCVeN3tW7jTlSuwVTY4nxNPtkjSS0UXBJC0I08XoLulA7O4bJ+DFtDzudLh6OdCgxYaxuuuuL0K43f+G5OnuBY0Yk9EaAaEi8hz1HYHOr9G1WT2+vTPCGyGY3wF3Oum58MloPAwEpjSzkw2mOHCE86oqSJ/RKLidLNkZ+5nLksArmJHr4ETyEH3ofAKSkHohEZweB2ys4traL+7k+ZrQj2ENJ2uo7xxyRdruWL4O5GqCguT/ql/ffKe8zkeEGGreae9VwtQOvPjegg+RsldOtYRr2/SScg2pDIAE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0802MB2374.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(110136005)(66556008)(966005)(316002)(186003)(66946007)(508600001)(66476007)(53546011)(86362001)(26005)(16576012)(31696002)(4326008)(7416002)(52116002)(83380400001)(38100700002)(54906003)(6486002)(8676002)(36756003)(2616005)(5660300002)(956004)(8936002)(38350700002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGpZRDFJeDdDbTg5bC9EMmR2dUtYaXBjYlZrTHRtY3FybE9yc2o0N0RPblVt?=
 =?utf-8?B?ZEdBb25UZytyZXdFekhWYXI3OWpIWWU4Sml2bTVPM2VNZTFGQUdiS0IrMUFV?=
 =?utf-8?B?S0E5R0RFTzBBODRlM3FzTTNXd0QrVFNmK2ptcVlPZDFaZnRDZ0RkblhuNm5V?=
 =?utf-8?B?SlhQZzdHRDJhUHhCODFtZFRIamtOSnRCYkJHWERBenZiVUowTldZTWFLYmdr?=
 =?utf-8?B?Q0tPVUNsTmxMV0tvZ3hWNDRmbUQ3UXJPU1FBd0FxWGJiWmRjQzZpTTNHR1FZ?=
 =?utf-8?B?TWtIU3BGS2hyaEpqeUlxRzlHS2lISnVlQzR3SlFBSU5XZ01KTWtmemNaVjRl?=
 =?utf-8?B?SEVzbWNnSzJndGY5WDdkNmtGZkJVa2htQnY1aUdyRy9HNjJXdVVpOVo0dFZV?=
 =?utf-8?B?VzQ2clFISTJXdmFZdGFUNU0zb2xvUjJjOVp6NWIxZC93MjlPTjZJbFJVZ3pi?=
 =?utf-8?B?YS9jdFRrejBrUmY1WkJCVlVONnl6RUIyUWQxeDBTR00vRlR6d1EwREtyUW1u?=
 =?utf-8?B?ay9sd2lZTkJac1dFWTlMS293TXB4bzdhU2pLSHVjdUxGNXVqUG5nc1kwWDdQ?=
 =?utf-8?B?Z01Va0REOWFMN25DNzQwejVCL1VjSCtLSlJEemNUK3dnVnBRRUVqN2VuNzFM?=
 =?utf-8?B?RVh3L05IQnhBMlpNVkREWmM0UldsVkV0SFFkNkx5V3JPbkRrcTVqeitKNmdL?=
 =?utf-8?B?bDFMOHlIT08vRjlRbWMzRTExcy9EMi92c00zb2N2Q1pQVGFtb012SzU0U2NI?=
 =?utf-8?B?eEtkeU9jMlV2NmdkUVlWTHZrMm8vR3lwV3BMVkNWc2lBcjFtOVllS0prUzZp?=
 =?utf-8?B?YkZ4V2JCdmtDSGptQkpZV3Z2dHByNy9kUkVVTndyd0Z6Z0htdGNVQmpzZU00?=
 =?utf-8?B?U2R6L1AzL1ZidGFORTdSWVlyMjFiRFNXR2M1TENKMUpCVGYwZVlEUDc5MzRJ?=
 =?utf-8?B?V0hEaFB1cHV0S05Tdks1MmVEQnVsVWFRNEhTVUM2L0lPenZpdG53WGxLTU5z?=
 =?utf-8?B?UUs1SnZxb3BXSlB0VXR6YnBxZGNrYVpkazFTQzJmclU1dFhaVlNQNzkyVXRx?=
 =?utf-8?B?Si9wQWM0ckxaVFlrRUtSZC9TMEJ1R1d3bG01SVNNQ2dOTmErMHZBUGxpMldh?=
 =?utf-8?B?SldaRHdrQ1hCSW1nVmxrVnBxN29hclNOOEJRRTJqdkRUWUVTN2hoeTNkUU1K?=
 =?utf-8?B?MjgwaUREdi8vdWVneFR3STkwSWQwUWt2eVlSZlFMMnFBNnBhcDhpaGRuQlJz?=
 =?utf-8?B?MUJGV2JzQ3JsV1VSbXZhYkJ4NjJHV3IzMlJNVE13ZzhYL0pCZXNvMUl5OFNN?=
 =?utf-8?B?aVFUQ2RkcG1WYTZWei84ZmJWUk5XdU10ZkE2dGFCMFAxNHRWTWpKZGQydTJB?=
 =?utf-8?B?K3VWNE83d0Q2SmJDdzA3Y25TOFlQTDFXWWFkaGxDOE5OY3NUMkdDZkp0bEtR?=
 =?utf-8?B?SWV3NmRuWnpCTDFwWlJrSTIwa3NpbmNwdkdrUjFhTTlCYXJlMkRTdlhqdld1?=
 =?utf-8?B?T3h2RVlMMWlrWXY3U0h0R2tXZFFybjd4L2FCRWpNY3VvQkFtMnBRZW8yc1Fv?=
 =?utf-8?B?UGtnTmk5QnBQcDgxWXF4d2J1d1RqTjcrTVpvdk5IbGluT3h5SVpmNFlNSGdZ?=
 =?utf-8?B?a2lvZGc2Tk43ZFpjYWg3bWJ6TmNjNDUwSnJ6YW85ZFlTSWVSZmYrZkNadjhH?=
 =?utf-8?B?V2tCV0JtYzhheW9wSUJaVXdUM3lZSUFIckUzUy9mam1tc3ZldGdPNTlpZ1ll?=
 =?utf-8?B?R3JOMFN1Y1BQMU1SZjZCcWx2bGl3OTQxQkE4ZEpDVGRWYzkrbHdLUnBFb3FW?=
 =?utf-8?B?MXIxMGt4cTQ5WFNjYmJNQUVQMEQyY05ONTBqeUpHS1ZuSndHaFY5L3I1N0tt?=
 =?utf-8?B?QmRDOTBwcTltQnhFd2hTWmJEQ0g2L0N4UFU5NUltL0dyVGZFYnRUeVR2cGxI?=
 =?utf-8?B?dnU5aStpUGI4M09XNTJqQlN4b2srMkMyLzZSeXc3bTRWWWpma0tLUzNRdFVz?=
 =?utf-8?B?bkNEV005UHZKcWVkQlYxOHEvS3l2eFRmNVFnSHFCNUxMZFpXVDgraEZlS3Fo?=
 =?utf-8?B?bmdVYmhUcnk2djlwK1JBeG9QOEpQai8wQUdQeUxsVml1TzNKTUp0M2hEQk9q?=
 =?utf-8?B?VHdRK2owcHJPNWV3QTZ0emVqRlA1WjVIZ1kvZUNTUmZHb3RVaUp2bnE0enNZ?=
 =?utf-8?Q?EXCAPLhyRd/NxcRMww9uYOA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f487d91d-8506-41bf-9294-08d9ab42016a
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0802MB2374.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 09:50:23.2837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jyVzx/1t+lspp5e3eOE7KCPfskKK+LWpVaoHSsEsjW0U9n4U7MA9ffsmzhpUkxJRkgNj6wHTo7bZYqcgnw2CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6746
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 18.11.2021 22:24, Steven Rostedt wrote:
> On Thu, 18 Nov 2021 12:55:07 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
> 
>> It is not correct to use inode numbers as the actual names for
>> namespaces.
>>
>> I can not see anything else you can possibly uses as names for
>> namespaces.
> 
> This is why we used inode numbers.

The migration problem may be solved in case of the new filesystem
allows rename.

Kernel may use random UUID as initial namespace file. After the migration, 
we recreate this namespace, and it will have another UUID generated by kernel.
Then, we just rename it in correct one. 

I sent something like this for /proc fs (except rename): 

http://archive.lwn.net:8080/linux-fsdevel/97fdcff1-1cce-7eab-6449-7fe10451162d@virtuozzo.com/T/#m7579f79a6ba8422b57463049f52d2043986b5cac

>>
>> To allow container migration between machines and similar things
>> the you wind up needing a namespace for your names of namespaces.
> 
> Is this why you say inode numbers are incorrect?
> 
> There's no reason to make this into its own namespace. Ideally, this file
> system should only be for privilege containers. As the entire point of this
> file system is to monitor the other containers on the system. In other
> words, this file system is not to be used like procfs, but instead a global
> information of the containers running on the host.
> 
> At first, we were not going to let this file system be part of any
> namespace but the host itself, but because we want to wrap up tooling into
> a container that we can install on other machines as a way to monitor the
> containers on each machine, we had to open that up.
> 
>>
>> Further you talk about hierarchy and you have not added support for the
>> user namespace.  Without the user namespace there is not hierarchy with
>> any namespace but the pid namespace. There is definitely no meaningful
>> hierarchy without the user namespace.
> 
> Great, help us implement this.
> 
>>
>> As far as I can tell merging this will break CRIU and container
>> migration in general (as the namespace of namespaces problem is not
>> solved).
> 
> This is not to be a file system that is to be migrated. As the point of
> this file system is to monitor the other containers, so it does not make
> sense to migrate it.
> 
>>
>> Since you are not solving the problem of a namespace for namespaces,
>> yet implementing something that requires it.
> 
> Why is it needed?
> 
>>
>> Since you are implementing hierarchy and ignoring the user namespace
>> which gives structure and hierarchy to the namespaces.
> 
> We are not ignoring it, we are RFC'ing for advice on how to implement it.
> 
>>
>> Since this breaks existing use cases without giving a solution.
> 
> You don't understand proof-of-concepts and RFCs do you?
> 
> -- Steve
> 

