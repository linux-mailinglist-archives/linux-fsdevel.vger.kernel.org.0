Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03040E81F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2019 08:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfJ2HTd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Oct 2019 03:19:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41724 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726222AbfJ2HTd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Oct 2019 03:19:33 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9T7FVUl141690
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2019 03:19:32 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vxcdqqfpj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2019 03:19:31 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 29 Oct 2019 07:19:29 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 29 Oct 2019 07:19:27 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9T7JQvq38600774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 07:19:26 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C81DA4062;
        Tue, 29 Oct 2019 07:19:26 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60AABA405B;
        Tue, 29 Oct 2019 07:19:25 +0000 (GMT)
Received: from [9.199.158.60] (unknown [9.199.158.60])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Oct 2019 07:19:25 +0000 (GMT)
Subject: Re: [RFC 0/5] Ext4: Add support for blocksize < pagesize for
 dioread_nolock
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, jack@suse.cz
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        mbobrowski@mbobrowski.org
References: <20191016073711.4141-1-riteshh@linux.ibm.com>
 <20191023232614.GB1124@mit.edu>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 29 Oct 2019 12:49:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191023232614.GB1124@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19102907-0020-0000-0000-00000380812B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102907-0021-0000-0000-000021D68846
Message-Id: <20191029071925.60AABA405B@b06wcsmtp001.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-29_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910290075
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Ted,

I tried reproducing issue generic/273 & generic/476 on vanilla 5.4-rc4.
I could see that both of these could be very well reproduced with same
symptoms on vanilla 5.4-rc4 as well with 1K blocksize on x86
(i.e. without this patch series).

Although when I tried reproducing generic/273 & generic/476 on ppc64le
(64K pagesize & 4K blocksize) both with & without these patches,
I could not reproduce this issue on this platform.

As of now, I haven't gone deep into analyzing failure for generic/476,
but generic/273 seems to be failing with 1K blocksize because of
"No space left in device". This is happening, since the free inode count
is exhausted (mostly only with 1K blocksize).
I will have to look into this on whether it needs any xfstest fixing or 
if there is something else going on.


So it looks like these failed tests does not seem to be because of this
patch series. But these are broken in general for at least 1K blocksize.

Also as an FYI, it seems generic/388 is also broken for blocksize <
pagesize for both platforms. So I will be planning to look into these 
failures (generic/273 generic/388 generic/476) in parallel.


Do you think we can work on these failing tests separately, since it 
does not look to be failing because of these patches and go ahead in
reviewing this current patch series?


-ritesh


On 10/24/19 4:56 AM, Theodore Y. Ts'o wrote:
> Hi Ritesh,
> 
> I haven't had a chance to dig into the test failures yet, but FYI....
> when I ran the auto test group in xfstests, I saw failures for
> generic/219, generic 273, and generic/476 --- these errors did not
> show up when running using a standard 4k blocksize on x86, and they
> also did not show up when running dioread_nolock using a 4k blocksize.
> 
> So I tried running "generic/219 generic/273 generic/476" 30 time
> using in a Google Compute Engine VM, using gce-xfstests, and while I
> wasn't able to get generic/219 to fail when run in isolation,
> generic/273 seems to fail quite reliably, and generic/476 about a
> third of the time.
> 
> How much testing have you done with these patches?
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

