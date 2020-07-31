Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D27D23417F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 10:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731943AbgGaIsf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 04:48:35 -0400
Received: from mail-vi1eur05on2092.outbound.protection.outlook.com ([40.107.21.92]:45345
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731896AbgGaIsf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:48:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OI7+Yf4P6spg10V3Xy4oIhzj+ALE/vlzYsu88aY2AguXS/ucuBAkCVjJLe7dtKiy4eRtL4p5ufGjtKmc3Lmz+xbOC+Yv6lxi2gJXh0cPDAe3n3Ixrck2Mvc0PfPSQarzZ6q2ivuKrd+rS0xHKJtNZhkBLHX5LMWSd/LbdUOEaeH0CqKu2IDe4rJX+gj8zZpfCjTmVz110VYSbxcUaldxnNhz3GEz+IB/qemb13iqy8NSizO1dEf0N18lkTPf4JIU+70hux0IoNp9jqkZtBHAkSPsJoo9cOmVjcp71Qu0KNwjXNF06nkyVhC6Uv7I3dyRhH5E9dm9abcLjcWadNyiRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XLtFHFux+upYfj1vrhj33by4R6AXwg7XcsG2kDOQ4Y=;
 b=g2ygnh0rsMxyn6VNcTOQpevkCTyKKXwPVz5eYhzS4FE/XhH+1AlvFFpD1E6AU/gbJ6SUiv0EPJBew8S5G0c8Kki5cXMfO8Zh1oy+4CZdIHCqbeKgkRl0hnmC3ha8nJeyH+7Zo2mSDv6pLfAxnB8UCUlmZohlO1A9uVJFj2R88OqO80vKkoDaiZEI+184r47o+9wi3m9ofidQouVuAp2bKPvGLgvrC8BqPasfmLbGM/ovZFyyGsLE2E+VWFOU3aJM6csLXy2faC4H4Jlv3dxdkXBd7+NxnZvRFBB7WLEch9g/U9LVCE0yPWyHx09T4VqB7Qj1R8q0fCK2umOJi83wNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XLtFHFux+upYfj1vrhj33by4R6AXwg7XcsG2kDOQ4Y=;
 b=tgnSNciaD3MigDARqzqMusqAG0FybLIp1uEu+Ow+W2v1Aa74KD+TiCrfOIgbjXwO7c68fNIXJQ2IuK5IU60zDwL3gCOb1loqu1gDCFcBNrmkK0NF2OStFqZXUTh6b+n5Gf3U/7jKMISETW/Vzu3e+fRvhqcjtC4CExOdUBvg7jk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from DBBPR08MB4758.eurprd08.prod.outlook.com (2603:10a6:10:da::16)
 by DB6PR0802MB2360.eurprd08.prod.outlook.com (2603:10a6:4:8a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.19; Fri, 31 Jul
 2020 08:48:31 +0000
Received: from DBBPR08MB4758.eurprd08.prod.outlook.com
 ([fe80::5137:9a9f:c26a:7b9]) by DBBPR08MB4758.eurprd08.prod.outlook.com
 ([fe80::5137:9a9f:c26a:7b9%7]) with mapi id 15.20.3239.019; Fri, 31 Jul 2020
 08:48:31 +0000
Subject: Re: [PATCH 00/23] proc: Introduce /proc/namespaces/ directory to
 expose namespaces lineary
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        areber@redhat.com, serge@hallyn.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
 <87k0yl5axy.fsf@x220.int.ebiederm.org>
 <56928404-f194-4194-5f2a-59acb15b1a04@virtuozzo.com>
 <875za43b3w.fsf@x220.int.ebiederm.org>
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Message-ID: <97fdcff1-1cce-7eab-6449-7fe10451162d@virtuozzo.com>
Date:   Fri, 31 Jul 2020 11:48:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <875za43b3w.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR04CA0141.eurprd04.prod.outlook.com (2603:10a6:207::25)
 To DBBPR08MB4758.eurprd08.prod.outlook.com (2603:10a6:10:da::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (91.207.170.176) by AM3PR04CA0141.eurprd04.prod.outlook.com (2603:10a6:207::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 08:48:29 +0000
X-Originating-IP: [91.207.170.176]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 842573e6-0f70-4352-ec04-08d8352e8026
X-MS-TrafficTypeDiagnostic: DB6PR0802MB2360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0802MB2360D7EDEABF2038716A16AFB74E0@DB6PR0802MB2360.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hkHO0i/VFJdZF7qMGdqjEVdXDBek2W1zpcnTXDWJPIiQnd3wlpFQeR07ZDSmxUITZhA53Gc2Q7usqb+ADMoQuNAMqzOPWVQYfGaPDuHdPhZzSxu3VrEywzE6wTIrcN0QmkFjFh2Wjx6B9VSBN+ecrslOK7U8dMGYGSJt3Tu022cjvKlwO/uHyoF6Yzg0bQNo0poNFaXI3yvALC8djuvR3TTNGGRp/cCw7iO2U3ahwwG361SJWGc9mrvjqCtBw+/Bj3FCPuw4mfb+VRrKIWr4+eNNec9z8bf7ToWCYyWdUOY07gaHyphcSsNuTMIUhXC9g3dAnQyWK74Ie4fDKFGhI/k0De/HEMkiV7JmSDrpxRcR/h6dt3jTHA+Vt3pkS0Vm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4758.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(396003)(136003)(376002)(39840400004)(4326008)(31686004)(478600001)(66556008)(66476007)(16526019)(31696002)(83380400001)(2906002)(66946007)(186003)(7416002)(86362001)(8936002)(26005)(36756003)(6486002)(110136005)(53546011)(5660300002)(6636002)(16576012)(52116002)(8676002)(316002)(956004)(2616005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: JFXmnNZDlZczzUIGcnpmIHzWIEhmTY/yjgjTGyJN0avLOHQtrtWy8jj87vPT0u5bqW9kqo2jChuJBkvGjyfOzQwGekMaUKq5QNNgsMqUBbA0BR9LDheFVPai3cv3WIp/vOwYhiFGiRxJSkM0rCLqKvXx2bcZII3ZeVKmyanldU+zvJQh8Vm52Al8kKbXt0afeEYZ4zdd6m91T5cjFNy1CgCOEo/lRlPchm/4OIWZC6i6g5nGq1MaG7yWwnxd7geLRAe4A1BJRuRZ3fvt7kyWge8nBO3UHgE0he9A54TAe4yRObtyKQ0t8GmCpxrkaFCqx7zYeO45nUjtWHLkmgSvvKsNTVxNfyVr/6yFBrXAc7+dYSKS/4BHgxvgTjjwTUuwpCPlFG0ux2wa8SxRxZSYlJcoZdYn9r6vsd4pCbNAMpR5Ig3NEgTGzSiRLftB5/3xhTtYTlyCInAGfCZPstuWtHlUsJMqapj6U1RY7lnDgvW+R7G7Slxi5eGlDzgpv1wPI99qaAI8haoDDoNyH/YJL7Xtv03zAJZ/jDRGCfWM6nkcwZUgO6otE30iquc9Xo+c37bbr78AOwecfxW2SP2J+wZjt+QNuh/Dlc46QVmJoioOf8Uk+MaQHe+QWcCS9HNZkh3eVrho75UoF2agQpTshQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 842573e6-0f70-4352-ec04-08d8352e8026
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4758.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 08:48:30.9546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yACHoqgYQdRw6Cr558dYdhUgIBr1l+XKIjbsIvethYLDKuL7ME8f9kSLsE/B7kCUkBbDWsDi6jEy4wkWiSXNof9ohB5ZnxDscXCPXYid/YY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2360
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/31/20 1:13 AM, Eric W. Biederman wrote:
> Kirill Tkhai <ktkhai@virtuozzo.com> writes:
> 
>> On 30.07.2020 17:34, Eric W. Biederman wrote:
>>> Kirill Tkhai <ktkhai@virtuozzo.com> writes:
>>>
>>>> Currently, there is no a way to list or iterate all or subset of namespaces
>>>> in the system. Some namespaces are exposed in /proc/[pid]/ns/ directories,
>>>> but some also may be as open files, which are not attached to a process.
>>>> When a namespace open fd is sent over unix socket and then closed, it is
>>>> impossible to know whether the namespace exists or not.
>>>>
>>>> Also, even if namespace is exposed as attached to a process or as open file,
>>>> iteration over /proc/*/ns/* or /proc/*/fd/* namespaces is not fast, because
>>>> this multiplies at tasks and fds number.
>>>
>>> I am very dubious about this.
>>>
>>> I have been avoiding exactly this kind of interface because it can
>>> create rather fundamental problems with checkpoint restart.
>>
>> restart/restore :)
>>
>>> You do have some filtering and the filtering is not based on current.
>>> Which is good.
>>>
>>> A view that is relative to a user namespace might be ok.    It almost
>>> certainly does better as it's own little filesystem than as an extension
>>> to proc though.
>>>
>>> The big thing we want to ensure is that if you migrate you can restore
>>> everything.  I don't see how you will be able to restore these files
>>> after migration.  Anything like this without having a complete
>>> checkpoint/restore story is a non-starter.
>>
>> There is no difference between files in /proc/namespaces/ directory and /proc/[pid]/ns/.
>>
>> CRIU can restore open files in /proc/[pid]/ns, the same will be with /proc/namespaces/ files.
>> As a person who worked deeply for pid_ns and user_ns support in CRIU, I don't see any
>> problem here.
> 
> An obvious diffference is that you are adding the inode to the inode to
> the file name.  Which means that now you really do have to preserve the
> inode numbers during process migration.
> 
> Which means now we have to do all of the work to make inode number
> restoration possible.  Which means now we need to have multiple
> instances of nsfs so that we can restore inode numbers.
> 
> I think this is still possible but we have been delaying figuring out
> how to restore inode numbers long enough that may be actual technical
> problems making it happen.
> 
> Now maybe CRIU can handle the names of the files changing during
> migration but you have just increased the level of difficulty for doing
> that.

Yes adding /proc/namespaces/<ns_name>:[<ns_ino>] files may be a problem 
to CRIU.

First I would like to highlight that open files are not a problem. 
Because open file from /proc/namespaces/* are exactly the same as open 
files from /proc/<pid>/ns/<ns_name>. So when we c/r an nsfs open file fd 
on dump we readlink the fd and get <ns_name>:[<ns_ino>] and on restore 
we recreate each dumped namespace and open an fd to each, so we can 
'dup' it when restoring open file. It will be an fd to topologically 
same namespace though ns_ino would be newly generated.

But the problem I see is with readdir. What if some task is reading 
/proc/namespaces/ directory at the time of dump, after restore directory 
will contain new names for namespaces and possibly in different order, 
this way if process continues to readdir it can miss some namespaces or 
read some twice.

May be instead of multiple files in /proc/namespaces directory, we can 
leave just one file /proc/namespaces and when we open it we would return 
e.g. a unix socket filled with all the fds of all namespacess visible at 
this point. It looks like a possible solution to the above problem.

CRIU can restore unix sockets with fds inside, so we should be able to 
dump process using this functionality.

> 
>> If you have a specific worries about, let's discuss them.
> 
> I was asking and I am asking that it be described in the patch
> description how a container using this feature can be migrated
> from one machine to another.  This code is so close to being problematic
> that we need be very careful we don't fundamentally break CRIU while
> trying to make it's job simpler and easier.
> 
>> CC: Pavel Tikhomirov CRIU maintainer, who knows everything about namespaces C/R.
>>   
>>> Further by not going through the processes it looks like you are
>>> bypassing the existing permission checks.  Which has the potential
>>> to allow someone to use a namespace who would not be able to otherwise.
>>
>> I agree, and I wrote to Christian, that permissions should be more strict.
>> This just should be formalized. Let's discuss this.
>>
>>> So I think this goes one step too far but I am willing to be persuaded
>>> otherwise.
>>>
> 
> Eric
> 

-- 
Best regards, Tikhomirov Pavel
Software Developer, Virtuozzo.
