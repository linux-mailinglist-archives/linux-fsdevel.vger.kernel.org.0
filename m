Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAEA4DC569
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 13:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbiCQMDi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 08:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiCQMDh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:03:37 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97F61E95CE;
        Thu, 17 Mar 2022 05:02:20 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22H9cmH9008529;
        Thu, 17 Mar 2022 12:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=vfIXFVzBYVYCGJ9paDohUySVCQL2EjCszKhxvr9T5hE=;
 b=A3kvDZtIURAt7ojq1h4+YH63/I04UlyKABS0CI3gcgaRaWnKgM/QSHr7NduPQGiED1Ks
 Ily+r7RTDKSQm02cv1lTUEXIdHDBnl4HdRBb6vCOf+5T4NFQnCKFwWtEpspQz6un6Ndd
 JXvkDyc3CfXRbcDijhsox5sH6g8g2xdIPspCB2DlQSPxy/vIfHKDmG3JlazoYVjoLQHp
 wHclXgN/LRqts5UhFw0Gk1zKKNG8M1zTZnyrkA6BMDLEhTSjjs+0xPL5jmDkJKurCASX
 6FnDj9wT+RUtDak00Y1mxeixPcHhw+0cYtMkTzW7KVWwLH49rP/EDSC9pAT5O+9FxALj ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ev0m5vkrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 12:01:55 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22HBtrQJ021011;
        Thu, 17 Mar 2022 12:01:55 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ev0m5vkqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 12:01:54 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22HBqkhb004603;
        Thu, 17 Mar 2022 12:01:53 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3erjshskwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 12:01:52 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22HC1oci45875640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 12:01:50 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85360A405D;
        Thu, 17 Mar 2022 12:01:50 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A537A4053;
        Thu, 17 Mar 2022 12:01:50 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 17 Mar 2022 12:01:50 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCHv3 02/10] ext4: Fix ext4_fc_stats trace point
References: <cover.1647057583.git.riteshh@linux.ibm.com>
        <b4b9691414c35c62e570b723e661c80674169f9a.1647057583.git.riteshh@linux.ibm.com>
Date:   Thu, 17 Mar 2022 13:01:49 +0100
In-Reply-To: <b4b9691414c35c62e570b723e661c80674169f9a.1647057583.git.riteshh@linux.ibm.com>
        (Ritesh Harjani's message of "Sat, 12 Mar 2022 11:09:47 +0530")
Message-ID: <yt9dr1706b4i.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I05qBJXbb_wl6wSZAWMPX25f2BRaoFU1
X-Proofpoint-ORIG-GUID: Rpr6UriCIbwTRJQf1XkiMSwaP8I7My-O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-17_04,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=991 adultscore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 clxscore=1011 impostorscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203170070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ritesh Harjani <riteshh@linux.ibm.com> writes:

> ftrace's __print_symbolic() requires that any enum values used in the
> symbol to string translation table be wrapped in a TRACE_DEFINE_ENUM
> so that the enum value can be decoded from the ftrace ring buffer by
> user space tooling.
>
> This patch also fixes few other problems found in this trace point.
> e.g. dereferencing structures in TP_printk which should not be done
> at any cost.
>
> Also to avoid checkpatch warnings, this patch removes those
> whitespaces/tab stops issues.
>
> Cc: stable@kernel.org
> Fixes: commit aa75f4d3daae ("ext4: main fast-commit commit path")
> Reported-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> ---
>  include/trace/events/ext4.h | 78 +++++++++++++++++++++++--------------
>  1 file changed, 49 insertions(+), 29 deletions(-)
>
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index 19e957b7f941..1a0b7030f72a 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -95,6 +95,17 @@ TRACE_DEFINE_ENUM(ES_REFERENCED_B);
>  	{ FALLOC_FL_COLLAPSE_RANGE,	"COLLAPSE_RANGE"},	\
>  	{ FALLOC_FL_ZERO_RANGE,		"ZERO_RANGE"})
>
> +TRACE_DEFINE_ENUM(EXT4_FC_REASON_XATTR);
> +TRACE_DEFINE_ENUM(EXT4_FC_REASON_CROSS_RENAME);
> +TRACE_DEFINE_ENUM(EXT4_FC_REASON_JOURNAL_FLAG_CHANGE);
> +TRACE_DEFINE_ENUM(EXT4_FC_REASON_NOMEM);
> +TRACE_DEFINE_ENUM(EXT4_FC_REASON_SWAP_BOOT);
> +TRACE_DEFINE_ENUM(EXT4_FC_REASON_RESIZE);
> +TRACE_DEFINE_ENUM(EXT4_FC_REASON_RENAME_DIR);
> +TRACE_DEFINE_ENUM(EXT4_FC_REASON_FALLOC_RANGE);
> +TRACE_DEFINE_ENUM(EXT4_FC_REASON_INODE_JOURNAL_DATA);
> +TRACE_DEFINE_ENUM(EXT4_FC_REASON_MAX);

I'm getting the following oops with that patch:

[    0.937455] VFS: Disk quotas dquot_6.6.0
[    0.937474] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.958347] Unable to handle kernel pointer dereference in virtual kernel address space
[    0.958350] Failing address: 00000000010de000 TEID: 00000000010de407
[    0.958353] Fault in home space mode while using kernel ASCE.
[    0.958357] AS:0000000001ed0007 R3:00000002ffff0007 S:0000000001003701
[    0.958388] Oops: 0004 ilc:3 [#1] SMP
[    0.958393] Modules linked in:
[    0.958398] CPU: 0 PID: 8 Comm: kworker/u128:0 Not tainted 5.17.0-rc8-next-20220317 #396
[    0.958403] Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)
[    0.958407] Workqueue: eval_map_wq eval_map_work_func

[    0.958446] Krnl PSW : 0704e00180000000 000000000090a9d6 (number+0x25e/0x3c0)
[    0.958456]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
[    0.958461] Krnl GPRS: 0000000000000058 00000000010de0ac 0000000000000001 00000000fffffffc
[    0.958467]            0000038000047b80 0affffff010de0ab 0000000000000000 0000000000000000
[    0.958481]            0000000000000020 0000038000000000 00000000010de0ad 00000000010de0ab
[    0.958484]            0000000080312100 0000000000e68910 0000038000047b50 0000038000047ab8
[    0.958494] Krnl Code: 000000000090a9c6: f0c84112b001        srp     274(13,%r4),1(%r11),8
[    0.958494]            000000000090a9cc: 41202001            la      %r2,1(%r2)
[    0.958494]           #000000000090a9d0: ecab0006c065        clgrj   %r10,%r11,12,000000000090a9dc
[    0.958494]           >000000000090a9d6: d200b0004000        mvc     0(1,%r11),0(%r4)
[    0.958494]            000000000090a9dc: 41b0b001            la      %r11,1(%r11)
[    0.958494]            000000000090a9e0: a74bffff
            aghi    %r4,-1
[    0.958494]            000000000090a9e4: a727fff6            brctg   %r2,000000000090a9d0
[    0.958494]            000000000090a9e8: a73affff            ahi     %r3,-1
[    0.958575] Call Trace:
[    0.958580]  [<000000000090a9d6>] number+0x25e/0x3c0
[    0.958594] ([<0000000000289516>] update_event_printk+0xde/0x200)
[    0.958602]  [<0000000000910020>] vsnprintf+0x4b0/0x7c8
[    0.958606]  [<00000000009103e8>] snprintf+0x40/0x50
[    0.958610]  [<00000000002893d2>] eval_replace+0x62/0xc8
[    0.958614]  [<000000000028e2fe>] trace_event_eval_update+0x206/0x248
[    0.958619]  [<0000000000171bba>] process_one_work+0x1fa/0x460
[    0.958625]  [<000000000017234c>] worker_thread+0x64/0x468
[    0.958629]  [<000000000017af90>] kthread+0x108/0x110
[    0.958634]  [<00000000001032ec>] __ret_from_fork+0x3c/0x58
[    0.958640]  [<0000000000cce43a>] ret_from_fork+0xa/0x40
[    0.958648] Last Breaking-Event-Address:
[    0.958652]  [<000000000090a99c>] number+0x224/0x3c0
[    0.958661] Kernel panic - not syncing: Fatal exception: panic_on_oops

I haven't really checked what TRACE_DEFINE_ENUM() does, but removing the
last line ("TRACE_DEFINE_ENUM(EXT4_FC_REASON_MAX);") makes the oops go
away. Looking at all the other defines looks like the _MAX enum
shouldn't be added there?

Thanks
Sven
