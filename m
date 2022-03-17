Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C9A4DCAE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 17:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbiCQQNa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 12:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiCQQN3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 12:13:29 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B05214F95;
        Thu, 17 Mar 2022 09:12:13 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22HGA7Mb001466;
        Thu, 17 Mar 2022 16:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : content-type :
 mime-version; s=pp1; bh=p25VD7f9NEbYVMjA8oW0QFkZVMeTUhG3CnH7cS//y/k=;
 b=X9yFhI44zN/g5Djdk7CUVe3XnJ2j55gpP8zMApLg81dXRdugfttKvk7dcCMrAOISaezK
 Vag3hzezdHuU9lV6FuhPd8E1aaBkjdMqJY6UjedClTXjBOLZvfKFPwKfIt7RfLNIgFPk
 ou9lOq7QRacw+dpgEh7JaVZ8O6sv5mY75j8VJetIN1+WkPtWw0yz5fsuhZgJh2QB/394
 +QB/iZu4DGng16LIQzti5X8jM5psouV0fMi05tXl8ARsXeGXA6ZcCY1ZsIw+xqUWWU8+
 E0oznKOxI8ngGlQF4HR1qUvNIX7twIKPZ6Eq3kI6nE9HJNlu9Z8NSqqSJgmpbZ5C1C8d Sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ev1vq0grp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 16:11:49 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22HGAAco001870;
        Thu, 17 Mar 2022 16:11:49 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ev1vq0gqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 16:11:49 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22HFx27Q003925;
        Thu, 17 Mar 2022 16:11:46 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3erk593r4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 16:11:46 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22HGBhpe29164004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 16:11:43 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E0B0A405B;
        Thu, 17 Mar 2022 16:11:43 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD193A4054;
        Thu, 17 Mar 2022 16:11:42 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 17 Mar 2022 16:11:42 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org, hca@linux.ibm.com
Subject: Re: [PATCHv3 02/10] ext4: Fix ext4_fc_stats trace point
References: <cover.1647057583.git.riteshh@linux.ibm.com>
        <b4b9691414c35c62e570b723e661c80674169f9a.1647057583.git.riteshh@linux.ibm.com>
        <yt9dr1706b4i.fsf@linux.ibm.com>
        <20220317145008.73nm7hqtccyjy353@riteshh-domain>
Date:   Thu, 17 Mar 2022 17:11:42 +0100
In-Reply-To: <20220317145008.73nm7hqtccyjy353@riteshh-domain> (Ritesh
        Harjani's message of "Thu, 17 Mar 2022 20:20:08 +0530")
Message-ID: <yt9d1qz05zk1.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uOqWNEA3DQxmNIk6-ZvU0e3rRTxJ6Cya
X-Proofpoint-ORIG-GUID: cEKF-wgx2ytzbbcc3RIkPT8_WeRzuC-x
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-17_06,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 mlxlogscore=874 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203170092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
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
>>
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
> Although I did test the patch and didn't see such a crash on my qemu box [3].
>
> [2]: https://lore.kernel.org/linux-ext4/20220310233234.4418186a@gandalf.local.home/
> [3]: https://lore.kernel.org/linux-ext4/20220311051249.ltgqbjjothbrkbno@riteshh-domain/
>
> @Steven,
> Sorry to bother. But does this crash strike anything obvious to you?

Looking at the oops output again made me realizes that the snprintf
tries to write into pages that are mapped RO. Talking to Heiko he
mentioned that s390 maps rodata/text RO when setting up the initial
mapping while x86 has a RW mapping in the beginning and changes that
later to RO. I haven't verified that, but that might be a reason why it
works on x86.

Thanks
Sven
