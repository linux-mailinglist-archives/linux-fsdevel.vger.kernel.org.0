Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AB54DC9C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 16:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbiCQPXz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 11:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiCQPXy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:23:54 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07436204CBB;
        Thu, 17 Mar 2022 08:22:37 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22HEQXUS019786;
        Thu, 17 Mar 2022 15:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : content-type :
 mime-version; s=pp1; bh=o5tYtAYH9ZLRvKcAuo+UUHJSCQ2sWyYgcu96LXqzj6g=;
 b=Wu5aeTMjcgo7+9TYR47yNtrL/h70MzJgHVkXlyLgMTo2ByO3mEV4WC59ej1fAD9uf07r
 yZtlH9kObFqTgRt9A8EDyjjKg+wc2jbXOL7+7xMc48VDO5ayUoLujXUqaja6RsUOOXjD
 PkWjp+l29E30Ddx4f+TmoiOZBPUtn9biIbH4Hp04uslpi9RE89YJQV/jG0RSHE8TDRMd
 ZUjJNtNyn4tjruRMBtc61vGCKABkmO+vKnuk4OZpu1s51Iol1Tbuektt71PRxWVLMVwd
 fIkXm5yHwSkKbYm0rLKqNvVEcvK1jcMtgUi4mkidN3X2cwxYUuULqcgEsXSG3gsLZ0oW 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3euwuhm118-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 15:22:13 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22HEmMRi022114;
        Thu, 17 Mar 2022 15:22:13 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3euwuhm10r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 15:22:13 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22HFIsEO030039;
        Thu, 17 Mar 2022 15:22:11 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3euc6r35sj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 15:22:11 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22HFM92Z46662014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 15:22:09 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A1A55204E;
        Thu, 17 Mar 2022 15:22:09 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id B2D6D52050;
        Thu, 17 Mar 2022 15:22:08 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org
Subject: Re: [PATCHv3 02/10] ext4: Fix ext4_fc_stats trace point
References: <cover.1647057583.git.riteshh@linux.ibm.com>
        <b4b9691414c35c62e570b723e661c80674169f9a.1647057583.git.riteshh@linux.ibm.com>
        <yt9dr1706b4i.fsf@linux.ibm.com>
        <20220317145008.73nm7hqtccyjy353@riteshh-domain>
Date:   Thu, 17 Mar 2022 16:22:08 +0100
In-Reply-To: <20220317145008.73nm7hqtccyjy353@riteshh-domain> (Ritesh
        Harjani's message of "Thu, 17 Mar 2022 20:20:08 +0530")
Message-ID: <yt9dee3061un.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: evvHnrFyu6NCdeG_d3g4uSJ9oQP78KAe
X-Proofpoint-GUID: zw6WPDayHorAsJtTfPc1xMQsxA0J-I5y
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-17_06,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 mlxlogscore=799 phishscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203170085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Ritesh Harjani <riteshh@linux.ibm.com> writes:

> On 22/03/17 01:01PM, Sven Schnelle wrote:
>> Ritesh Harjani <riteshh@linux.ibm.com> writes:
>> I'm getting the following oops with that patch:
>>
>> [    0.937455] VFS: Disk quotas dquot_6.6.0
>> [    0.937474] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
>> [    0.958347] Unable to handle kernel pointer dereference in virtual kernel address space
>> [    0.958350] Failing address: 00000000010de000 TEID: 00000000010de407
>> [    0.958353] Fault in home space mode while using kernel ASCE.
>> [    0.958357] AS:0000000001ed0007 R3:00000002ffff0007 S:0000000001003701
>> [    0.958388] Oops: 0004 ilc:3 [#1] SMP
>> [    0.958393] Modules linked in:
>> [    0.958398] CPU: 0 PID: 8 Comm: kworker/u128:0 Not tainted 5.17.0-rc8-next-20220317 #396
>
> I tried running this master branch of linux-next from here [1].
> But I started facing build failures with it.
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>
>> [    0.958403] Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)
>> [    0.958407] Workqueue: eval_map_wq eval_map_work_func
>>
>> [    0.958446] Krnl PSW : 0704e00180000000 000000000090a9d6 (number+0x25e/0x3c0)
>> [    0.958456]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
>> [    0.958461] Krnl GPRS: 0000000000000058 00000000010de0ac 0000000000000001 00000000fffffffc
>> [    0.958467]            0000038000047b80 0affffff010de0ab 0000000000000000 0000000000000000
>> [    0.958481]            0000000000000020 0000038000000000 00000000010de0ad 00000000010de0ab
>> [    0.958484]            0000000080312100 0000000000e68910 0000038000047b50 0000038000047ab8
>> [    0.958494] Krnl Code: 000000000090a9c6: f0c84112b001        srp     274(13,%r4),1(%r11),8
>> [    0.958494]            000000000090a9cc: 41202001            la      %r2,1(%r2)
>> [    0.958494]           #000000000090a9d0: ecab0006c065        clgrj   %r10,%r11,12,000000000090a9dc
>> [    0.958494]           >000000000090a9d6: d200b0004000        mvc     0(1,%r11),0(%r4)
>> [    0.958494]            000000000090a9dc: 41b0b001            la      %r11,1(%r11)
>> [    0.958494]            000000000090a9e0: a74bffff
>>             aghi    %r4,-1
>> [    0.958494]            000000000090a9e4: a727fff6            brctg   %r2,000000000090a9d0
>> [    0.958494]            000000000090a9e8: a73affff            ahi     %r3,-1
>> [    0.958575] Call Trace:
>> [    0.958580]  [<000000000090a9d6>] number+0x25e/0x3c0
>> [    0.958594] ([<0000000000289516>] update_event_printk+0xde/0x200)
>> [    0.958602]  [<0000000000910020>] vsnprintf+0x4b0/0x7c8
>> [    0.958606]  [<00000000009103e8>] snprintf+0x40/0x50
>> [    0.958610]  [<00000000002893d2>] eval_replace+0x62/0xc8
>> [    0.958614]  [<000000000028e2fe>] trace_event_eval_update+0x206/0x248
>
> This looks like you must have this patch from Steven as well [2].

Yes, i used vanilla linux-next from 20220317. So i have that one as well.
Looking at that patch it looks like TRACE_DEFINE_ENUM(EXT4_FC_REASON_MAX);
is indeed wanted. Lets wait wether Steve knows what's going on,
otherwise i have to dig into the code and figure out what the problem is.

Thanks
Sven
