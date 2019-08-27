Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3706E9DC33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2019 05:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbfH0D6u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 23:58:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31612 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728820AbfH0D6t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 23:58:49 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7R3v4I1106264
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2019 23:58:47 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2umvj4rv3s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2019 23:58:47 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 27 Aug 2019 04:58:45 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 27 Aug 2019 04:58:42 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7R3wfYE29294656
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 03:58:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 721F042041;
        Tue, 27 Aug 2019 03:58:41 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63EB842042;
        Tue, 27 Aug 2019 03:58:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.31.57])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Aug 2019 03:58:40 +0000 (GMT)
Subject: Re: [RFC 0/2] ext4: bmap & fiemap conversion to use iomap
To:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        tytso@mit.edu
Cc:     mbobrowski@mbobrowski.org, linux-fsdevel@vger.kernel.org
References: <20190820130634.25954-1-riteshh@linux.ibm.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 27 Aug 2019 09:28:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190820130634.25954-1-riteshh@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19082703-0020-0000-0000-0000036454BA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082703-0021-0000-0000-000021B99F38
Message-Id: <20190827035840.63EB842042@d06av24.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908270043
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Ted/Jan/Andreas,

Any review comments on this please?


One more thing which I wanted to discuss about this patch set is 
testcase generic/473 ("Hole + Data" case).
With iomap we only report extent information upto what user requested
which I think is different than previous implementation.

I see that with iomap, generic/473 test case("hole + data" case) shows 
as failed, although it reported the data extents only upto what user 
requested. Also as per Documentation/filesystems/fiemap.txt, both
outputs are proper.


i.e. for below case (generic/473)
  63 echo "Hole + Data"
  64 $XFS_IO_PROG -c "fiemap -v 0 65k" $file | _filter_fiemap

<output for both ext4(with this patchset) & XFS is this>

generic/473 3s ... - output mismatch (see 
/home/qemu/work/xfstests-dev/results//xfs_filesystem/generic/473.out.bad)
     --- tests/generic/473.out   2019-07-05 10:49:42.130902595 +0530
     +++ 
/home/qemu/work/xfstests-dev/results//xfs_filesystem/generic/473.out.bad 
        2019-08-27 09:26:20.823980693 +0530
     @@ -6,7 +6,7 @@
      1: [256..287]: hole
      Hole + Data
      0: [0..127]: hole
     -1: [128..255]: data
     +1: [128..135]: data
      Hole + Data + Hole
      0: [0..127]: hole
     ...


-ritesh

On 8/20/19 6:36 PM, Ritesh Harjani wrote:
> Hello,
> 
> These are RFC patches to get community view on converting
> ext4 bmap & fiemap to iomap infrastructure. This reduces the users
> of ext4_get_block API and thus a step towards getting rid of
> buffer_heads from ext4. Also reduces the line of code by making
> use of iomap infrastructure (ex4_iomap_begin) which is already
> used for other operations.
> 
> This gets rid of special implementation of ext4_fill_fiemap_extents
> & ext4_find_delayed_extent and thus only relies upon ext4_map_blocks
> & iomap_fiemap (ext4_iomap_begin) for mapping. It looked more logical
> thing to do, but I appreciate if anyone has any review/feedback
> comments about this part.
> 
> Didn't get any regression on some basic xfstests in tests/ext4/
> with mkfs option of "-b 4096". Please let me know if I should also test
> any special configurations?
> 
> Patches can be cleanly applied over Linux 5.3-rc5.
> 
> 
> Ritesh Harjani (2):
>    ext4: Move ext4 bmap to use iomap infrastructure.
>    ext4: Move ext4_fiemap to iomap infrastructure
> 
>   fs/ext4/extents.c | 294 +++++++---------------------------------------
>   fs/ext4/inline.c  |  41 -------
>   fs/ext4/inode.c   |  17 ++-
>   3 files changed, 53 insertions(+), 299 deletions(-)
> 

