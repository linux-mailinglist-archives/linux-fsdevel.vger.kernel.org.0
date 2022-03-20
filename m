Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B8B4E1BD1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Mar 2022 14:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245139AbiCTNQp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Mar 2022 09:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236759AbiCTNQp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Mar 2022 09:16:45 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B7B3192F;
        Sun, 20 Mar 2022 06:15:22 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22K8NxdQ029675;
        Sun, 20 Mar 2022 13:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : content-type :
 mime-version; s=pp1; bh=cFVIwF9yYVTiRJkYUmq32sKgvro0yz9kJgAFCojfzyE=;
 b=so/Uaj6ZCzt4OFV6op3z5XC0Aniqmm5+98hrVGILSgLA/UlXYfVnwvyE7BfWfXNYyoan
 MGQlo+y7r46oWYgDGCfswciOe+3oBHIdiWJKrN6IsCwAoa6SwxehqfkffQMRu7EzkmWi
 IWz1YzJ7fys6j1Z1hcgiYJEZyObi4I5yIOwpbFnbxjccrV7kf+FQgLSHlgWtNyYdS5qr
 qYXJTyI2Zy6NUlttro2YbqFKsyQ7aS2glAcYF8U3cRUv1tOI25CQ18oxcGhrerhKe1OI
 BMF39Mkylr3tEaCABUxM4RQ09IZKXESFyk5byGNjG/GJth5WXW60xghTtZvJPtAEveqL Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ewrtkqjew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 20 Mar 2022 13:14:52 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22KDEpfq003716;
        Sun, 20 Mar 2022 13:14:51 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ewrtkqjem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 20 Mar 2022 13:14:51 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22KDACFt007130;
        Sun, 20 Mar 2022 13:14:49 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3ew6t8t1hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 20 Mar 2022 13:14:49 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22KDElB739715298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 20 Mar 2022 13:14:47 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 506CE42042;
        Sun, 20 Mar 2022 13:14:47 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 048414203F;
        Sun, 20 Mar 2022 13:14:47 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 20 Mar 2022 13:14:46 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCH] tracing: Have type enum modifications copy the strings
References: <20220318153432.3984b871@gandalf.local.home>
Date:   Sun, 20 Mar 2022 14:14:46 +0100
In-Reply-To: <20220318153432.3984b871@gandalf.local.home> (Steven Rostedt's
        message of "Fri, 18 Mar 2022 15:34:32 -0400")
Message-ID: <yt9d5yo8rcjd.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uJEVLYBGmTLnaGnqHzkeM2KjkP3M5DtT
X-Proofpoint-ORIG-GUID: XAsz1rZJpP9cI-IyYaa037Z8NuzOM3RY
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-20_04,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 clxscore=1011 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203200097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Steve,

Steven Rostedt <rostedt@goodmis.org> writes:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> When an enum is used in the visible parts of a trace event that is
> exported to user space, the user space applications like perf and
> trace-cmd do not have a way to know what the value of the enum is. To
> solve this, at boot up (or module load) the printk formats are modified to
> replace the enum with their numeric value in the string output.
>
> Array fields of the event are defined by [<nr-elements>] in the type
> portion of the format file so that the user space parsers can correctly
> parse the array into the appropriate size chunks. But in some trace
> events, an enum is used in defining the size of the array, which once
> again breaks the parsing of user space tooling.
>
> This was solved the same way as the print formats were, but it modified
> the type strings of the trace event. This caused crashes in some
> architectures because, as supposed to the print string, is a const string
> value. This was not detected on x86, as it appears that const strings are
> still writable (at least in boot up), but other architectures this is not
> the case, and writing to a const string will cause a kernel fault.
>
> To fix this, use kstrdup() to copy the type before modifying it. If the
> trace event is for the core kernel there's no need to free it because the
> string will be in use for the life of the machine being on line. For
> modules, create a link list to store all the strings being allocated for
> modules and when the module is removed, free them.
>
> Link: https://lore.kernel.org/all/yt9dr1706b4i.fsf@linux.ibm.com/
>
> Fixes: b3bc8547d3be ("tracing: Have TRACE_DEFINE_ENUM affect trace event types as well")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

This fixes the crash seen on s390. Thanks!

Tested-by: Sven Schnelle <svens@linux.ibm.com>
