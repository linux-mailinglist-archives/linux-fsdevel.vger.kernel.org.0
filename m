Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50C2DE279F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 03:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391836AbfJXBMt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 21:12:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388218AbfJXBMt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 21:12:49 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9O1CgT3107825
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 21:12:48 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vt293yxrq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 21:12:47 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 24 Oct 2019 02:12:25 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 24 Oct 2019 02:12:23 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9O1CMGb25624626
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 01:12:22 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F18BA4051;
        Thu, 24 Oct 2019 01:12:22 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34C7CA4040;
        Thu, 24 Oct 2019 01:12:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.84.149])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 24 Oct 2019 01:12:21 +0000 (GMT)
Subject: Re: [RFC 0/5] Ext4: Add support for blocksize < pagesize for
 dioread_nolock
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org
References: <20191016073711.4141-1-riteshh@linux.ibm.com>
 <20191023232614.GB1124@mit.edu>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 24 Oct 2019 06:42:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191023232614.GB1124@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19102401-0016-0000-0000-000002BC6C76
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102401-0017-0000-0000-0000331DAEB8
Message-Id: <20191024011221.34C7CA4040@d06av23.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-24_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910240005
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Ted,

On 10/24/19 4:56 AM, Theodore Y. Ts'o wrote:
> Hi Ritesh,
> 
> I haven't had a chance to dig into the test failures yet, but FYI....
> when I ran the auto test group in xfstests, I saw failures for
> generic/219, generic 273, and generic/476 --- these errors did not
> show up when running using a standard 4k blocksize on x86, and they
> also did not show up when running dioread_nolock using a 4k blocksize.
> 

Sorry about that. Were these 3 the only tests you saw to be failing,
or there were more?


> So I tried running "generic/219 generic/273 generic/476" 30 times,
> using in a Google Compute Engine VM, using gce-xfstests, and while I
> wasn't able to get generic/219 to fail when run in isolation,
> generic/273 seems to fail quite reliably, and generic/476 about a
> third of the time.
> 
> How much testing have you done with these patches?

I did test "quick" group of xfstests & ltp/fsx tests with the posted
version. And had tested a full suite of xfstests with one of my previous 
version.
I guess I was comparing against 1K blocksize without dioread_nolock.
But as I think more about it, I may need to compare against vanilla
kernel with 1K blocksize even without dioread_nolock. Since there may
be some changes in blocksize < pagesize path with this patch.


Also I see these tests(generic/273 & generic/476) are not part
of quick group. Let me check more about these failing tests at my end.

Thanks for your inputs.

-ritesh


> 
> Thanks,
> 
> 							- Ted
> 
> TESTRUNID: tytso-20191023144956
> KERNEL:    kernel 5.4.0-rc3-xfstests-00005-g39b811602906 #1244 SMP Wed Oct 23 11:30:25 EDT 2019 x86_64
> CMDLINE:   --update-files -C 30 -c dioread_nolock_1k generic/219 generic/273 generic/476
> CPUS:      2
> MEM:       7680
> 
> ext4/dioread_nolock_1k: 90 tests, 42 failures, 10434 seconds
>    Failures: generic/273 generic/273 generic/273 generic/273
>      generic/476 generic/273 generic/476 generic/273 generic/273
>      generic/273 generic/476 generic/273 generic/476 generic/273
>      generic/476 generic/273 generic/476 generic/273 generic/273
>      generic/273 generic/273 generic/273 generic/476 generic/273
>      generic/273 generic/273 generic/273 generic/476 generic/273
>      generic/476 generic/273 generic/476 generic/273 generic/273
>      generic/273 generic/273 generic/273 generic/273 generic/273
>      generic/476 generic/273 generic/476
> Totals: 90 tests, 0 skipped, 42 failures, 0 errors, 10434s
> 

