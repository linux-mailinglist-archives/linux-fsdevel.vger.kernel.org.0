Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14A17BB41D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 11:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjJFJUM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 05:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjJFJUL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:20:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D2193;
        Fri,  6 Oct 2023 02:20:10 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3969CG8E007374;
        Fri, 6 Oct 2023 09:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=BwFcPAUobi1/r6lpMQAz7C45FTApsXQluGDyKxSPCOo=;
 b=C4ptKFdINgExquLABbc5CCuiQNBhccaM6/glFOzIFmkCM7lU3aTAqfZ8LuP3IHPhKCUI
 a8D7wfjCvCZi/fxb2SFCtdqmgwzungqMfpqdyiC54avbKTJzOSXv0OwB8PTGZkUt94md
 xexHbuGFrVJS8gIcqKJlorDUYt5MerQnoweHT6h7xDuOSwtqOM21hxeb948uK7q7VaPZ
 dUNYLhaVu9mNHHMQoiY/66nAMfMr4QnOYN+z4V8PSoyv0WhfC2WK7CQgr66nIdSV25Sl
 9ULMUgLrN6rW98CFzvs9Q1Z09XKImtDCDJI4fB/YQDjnnqNQBGuBX7jc4mpl9qX40ZJR EA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tjfd6ra51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 09:20:02 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3969Cc8D009466;
        Fri, 6 Oct 2023 09:20:01 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tjfd6ra4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 09:20:01 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3968x9M3005869;
        Fri, 6 Oct 2023 09:20:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tex0tyh1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 09:20:01 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3969Jwd217171128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Oct 2023 09:19:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B0802004B;
        Fri,  6 Oct 2023 09:19:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78FFD2005A;
        Fri,  6 Oct 2023 09:19:58 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  6 Oct 2023 09:19:58 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Test failure from "file: convert to SLAB_TYPESAFE_BY_RCU"
References: <00e5cc23-a888-46ce-8789-fc182a2131b0@sirena.org.uk>
Date:   Fri, 06 Oct 2023 11:19:58 +0200
In-Reply-To: <00e5cc23-a888-46ce-8789-fc182a2131b0@sirena.org.uk> (Mark
        Brown's message of "Fri, 6 Oct 2023 01:04:19 +0100")
Message-ID: <yt9dil7k151d.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Jel0kw8Lv9rym5kHlmWHVfpsI0hWNetK
X-Proofpoint-GUID: y06AIrTlEFOLQoBtGhfdCHDmHCRzc1h1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_06,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxlogscore=645
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310060066
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mark Brown <broonie@kernel.org> writes:

> For the past few days (I was away last week...) the fd-003-kthread.c
> test from the proc kselftests has been failing on arm64, this is an
> nfsroot system if that makes any odds.  The test output itself is:
>
>   # selftests: proc: fd-003-kthread
>   # fd-003-kthread: fd-003-kthread.c:113: test_readdir: Assertion `!de' failed.
>   # Aborted
>   not ok 3 selftests: proc: fd-003-kthread # exit=134
>
> I ran a bisect which pointed at the commit
>
>    d089d9d056c048303aedd40a7f3f26593ebd040c file: convert to SLAB_TYPESAFE_BY_RCU
>
> (I can't seem to find that on lore.) I've not done any further analysis
> of what the commit is doing or anything, though it does look like the
> bisect ran fairly smoothly and it looks at least plausibly related to
> the issue and reverting the commit on top of -next causes the test to
> start passing again.

I'm seeing the same with the strace test-suite on s390. The problem is
that /proc/*/fd now contains the file descriptors of the calling
process, and not the target process.

Old kernel:

# ls -l /proc/1/fd

total 0
lrwx------. 1 root root 64 Oct  6 11:11 0 -> /dev/null
lrwx------. 1 root root 64 Oct  6 11:11 1 -> /dev/null
lr-x------. 1 root root 64 Oct  6 11:12 10 -> /proc/1/mountinfo
lr-x------. 1 root root 64 Oct  6 11:12 11 -> anon_inode:inotify
lr-x------. 1 root root 64 Oct  6 11:12 13 -> anon_inode:inotify
lr-x------. 1 root root 64 Oct  6 11:12 14 -> /proc/swaps
lrwx------. 1 root root 64 Oct  6 11:12 15 -> 'socket:[5419]'
lrwx------. 1 root root 64 Oct  6 11:12 16 -> 'socket:[5420]'
[..]

# ls -l /proc/2/fd
total 0
#

New kernel:

# ls -l /proc/1/fd
total 0
lrwx------. 1 root root 64 Oct  6 11:14 0 -> /dev/null
lrwx------. 1 root root 64 Oct  6 11:14 1 -> /dev/null
lrwx------. 1 root root 64 Oct  6 11:14 2 -> /dev/null
lr-x------. 1 root root 64 Oct  6 11:14 3 -> /dev/kmsg

# ls -l /proc/2/fd
ls: cannot read symbolic link '/proc/2/fd/0': No such file or directory
ls: cannot read symbolic link '/proc/2/fd/1': No such file or directory
ls: cannot read symbolic link '/proc/2/fd/2': No such file or directory
ls: cannot read symbolic link '/proc/2/fd/3': No such file or directory
total 0
lrwx------. 1 root root 64 Oct  6 11:14 0
lrwx------. 1 root root 64 Oct  6 11:14 1
lrwx------. 1 root root 64 Oct  6 11:14 2
lr-x------. 1 root root 64 Oct  6 11:14 3
