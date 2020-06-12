Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CC41F7E83
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 23:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgFLVwW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 17:52:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33468 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgFLVwV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 17:52:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CLgd5l100541;
        Fri, 12 Jun 2020 21:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=YQwZ2qMk30v0exHQjGmX0+vXcO88dA/fx1P1NvxubDQ=;
 b=UPZKr/2fEBkNdNTvh4NhEAMMDWuBjbp6T0NunroaheeFbC0Ej9GCwKmsEJqWc55m9KKV
 SI/Fq9K3/J3bCDkLcgP4AK4OISAkllz9GDCTK8uNYXLrirhxWzH5hKQFjgTbrdeolBnC
 UoxYH/IuDfDnnUeRH9WIKG16Zx8RPj0TSqVoszGEEdw4Kec9CNta7DB39IMKVG1lSmYm
 VkGRXR+1SFC5SL3J8gSNr7E1lf+ZBZqW/oq/mVDC2B7zavh93Lg6Yh+20lgPhlpAi080
 wTsfWSXvTIUSmIssVM80Rn/q+FH1DNC70GNy6v4pxBc1a5YUeitKG6tOMJxM0FHt1suv 2g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31g3snf3q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 21:52:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CLluQB031217;
        Fri, 12 Jun 2020 21:52:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 31mhgjtbjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 21:51:59 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05CLptEw025958;
        Fri, 12 Jun 2020 21:51:57 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jun 2020 14:51:55 -0700
Subject: Re: [PATCH v4 1/2] hugetlb: use f_mode & FMODE_HUGETLBFS to identify
 hugetlbfs files
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Walters <walters@verbum.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <20200612004644.255692-1-mike.kravetz@oracle.com>
 <20200612015842.GC23230@ZenIV.linux.org.uk>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b1756da5-4e91-298f-32f1-e5642a680cbf@oracle.com>
Date:   Fri, 12 Jun 2020 14:51:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200612015842.GC23230@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9650 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006120161
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9650 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006120160
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/11/20 6:58 PM, Al Viro wrote:
> On Thu, Jun 11, 2020 at 05:46:43PM -0700, Mike Kravetz wrote:
>> The routine is_file_hugepages() checks f_op == hugetlbfs_file_operations
>> to determine if the file resides in hugetlbfs.  This is problematic when
>> the file is on a union or overlay.  Instead, define a new file mode
>> FMODE_HUGETLBFS which is set when a hugetlbfs file is opened.  The mode
>> can easily be copied to other 'files' derived from the original hugetlbfs
>> file.
>>
>> With this change hugetlbfs_file_operations can be static as it should be.
>>
>> There is also a (duplicate) set of shm file operations used for the routine
>> is_file_shm_hugepages().  Instead of setting/using special f_op's, just
>> propagate the FMODE_HUGETLBFS mode.  This means is_file_shm_hugepages() and
>> the duplicate f_ops can be removed.
> 
> s/HUGETLBFS/HUGEPAGES/, please.
> 
>> While cleaning things up, change the name of is_file_hugepages() to
>> is_file_hugetlbfs().  The term hugepages is a bit ambiguous.
> 
> Don't, especially since the very next patch adds such on overlayfs...

Ok. This is just something I thought might clarify things.  I seem to
recall questions about 'huge page' routines such as "is that for THP or
hugetlb huge pages"?  That was my motivation for the change.  Since this
is only about hugetlbfs, make it explicit.

> Incidentally, can a hugetlbfs be a lower layer, while the upper one
> is a normal filesystem?  What should happen on copyup?

Yes, that seems to work as expected.  When accessed for write the hugetlb
file is copied to the normal filesystem.

The BUG found by syzbot actually has a single hugetlbfs as both lower and
upper.  With the BUG 'fixed', I am not exactly sure what the expected
behavior is in this case.  I may be wrong, but I would expect any operations
that can be performed on a stand alone hugetlbfs to also be performed on
the overlay.  However, mmap() still fails.  I will look into it.

I also looked at normal filesystem lower and hugetlbfs upper.  Yes, overlayfs
allows this.  This is somewhat 'interesting' as write() is not supported in
hugetlbfs.  Writing to files in the overlay actually ended up writing to
files in the lower filesystem.  That seems wrong, but overlayfs is new to me.

Earlier in the discussion of these issues, Colin Walters asked "Is there any
actual valid use case for mounting an overlayfs on top of hugetlbfs?"  I can
not think of one.  Perhaps we should consider limiting the ways in which
hugetlbfs can be used in overlayfs?  Preventing it from being an upper
filesystem might be a good start?  Or, do people think making hugetlbfs and
overlayfs play nice together is useful?
-- 
Mike Kravetz
