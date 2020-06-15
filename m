Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C221FA4BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 01:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgFOXpc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 19:45:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49536 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgFOXpb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:45:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05FNbKsh195782;
        Mon, 15 Jun 2020 23:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=fw2YQNRsCXZ/+0DlDkdWyVER1owgVj4DgmgamWytQwU=;
 b=PJPj0mokQoAcHv/verR3n7AJYAuvim9atucaoTzp4yt27Vrnpu0wlkq4brbF1ULP++aE
 NXwVAtw1XjeJpOEQW3jtn1fqtrFqQ31mTW8/qFuE2qFu7p6wmlknF0KiRZLLwFuxzg06
 WMvlZBsUMTNX9RKGyDCUBdVg5EZ6l+yWSA93QGD4gqBfqVoQBU1A+6ulmRbDGKsZUP2U
 5E2o68d97UCOZfQn83nrCngjmrDrE8OM0bM+pYB48LmZUxg6TmDb+I6oAwaqUQkBaLuw
 Q27VHNItk8sxz+B+ZzMRalD3T8uJ8bpstNe331C5L8oGeHUQnBUG6Ru9O1QHrWGSkKcK jQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 31p6e5uqmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Jun 2020 23:45:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05FNdMiX122398;
        Mon, 15 Jun 2020 23:45:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 31p6dby30x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jun 2020 23:45:14 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05FNjB2l026727;
        Mon, 15 Jun 2020 23:45:12 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Jun 2020 16:45:10 -0700
Subject: Re: [PATCH v4 1/2] hugetlb: use f_mode & FMODE_HUGETLBFS to identify
 hugetlbfs files
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Walters <walters@verbum.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <20200612004644.255692-1-mike.kravetz@oracle.com>
 <20200612015842.GC23230@ZenIV.linux.org.uk>
 <b1756da5-4e91-298f-32f1-e5642a680cbf@oracle.com>
 <CAOQ4uxg=o2SVbfUiz0nOg-XHG8irvAsnXzFWjExjubk2v_6c_A@mail.gmail.com>
 <6e8924b0-bfc4-eaf5-1775-54f506cdf623@oracle.com>
 <CAJfpegsugobr8LnJ7e3D1+QFHCdYkW1swtSZ_hKouf_uhZreMg@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <80f869aa-810d-ef6c-8888-b46cee135907@oracle.com>
Date:   Mon, 15 Jun 2020 16:45:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegsugobr8LnJ7e3D1+QFHCdYkW1swtSZ_hKouf_uhZreMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9653 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006150169
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9653 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006150169
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/15/20 12:53 AM, Miklos Szeredi wrote:
> On Sat, Jun 13, 2020 at 9:12 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>> On 6/12/20 11:53 PM, Amir Goldstein wrote:
>>>
>>> The simplest thing for you to do in order to shush syzbot is what procfs does:
>>>         /*
>>>          * procfs isn't actually a stacking filesystem; however, there is
>>>          * too much magic going on inside it to permit stacking things on
>>>          * top of it
>>>          */
>>>         s->s_stack_depth = FILESYSTEM_MAX_STACK_DEPTH;
>>>
>>> Currently, the only in-tree stacking fs are overlayfs and ecryptfs, but there
>>> are some out of tree implementations as well (shiftfs).
>>> So you may only take that option if you do not care about the combination
>>> of hugetlbfs with any of the above.
>>>
>>> overlayfs support of mmap is not as good as one might hope.
>>> overlayfs.rst says:
>>> "If a file residing on a lower layer is opened for read-only and then
>>>  memory mapped with MAP_SHARED, then subsequent changes to
>>>  the file are not reflected in the memory mapping."
>>>
>>> So if I were you, I wouldn't go trying to fix overlayfs-huguetlb interop...
>>
>> Thanks again,
>>
>> I'll look at something as simple as s_stack_depth.
> 
> Agree.

Apologies again for in the incorrect information about writing to lower
filesystem.

Stacking ecryptfs on hugetlbfs does not work either.  Here is what happens
when trying to create a new file.

[ 1188.863425] ecryptfs_write_metadata_to_contents: Error attempting to write header information to lower file; rc = [-22]
[ 1188.865469] ecryptfs_write_metadata: Error writing metadata out to lower file; rc = [-22]
[ 1188.867022] Error writing headers; rc = [-22]

I like Amir's idea of just setting s_stack_depth in hugetlbfs to prevent
stacking.

From 0fbed66b37c18919ea7edd47b113c97644f49362 Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Mon, 15 Jun 2020 14:37:52 -0700
Subject: [PATCH] hugetlbfs: prevent filesystem stacking of hugetlbfs

syzbot found issues with having hugetlbfs on a union/overlay as reported
in [1].  Due to the limitations (no write) and special functionality of
hugetlbfs, it does not work well in filesystem stacking.  There are no
know use cases for hugetlbfs stacking.  Rather than making modifications
to get hugetlbfs working in such environments, simply prevent stacking.

[1] https://lore.kernel.org/linux-mm/000000000000b4684e05a2968ca6@google.com/

Reported-by: syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com
Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 991c60c7ffe0..f32759c8e84d 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1313,6 +1313,12 @@ hugetlbfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_magic = HUGETLBFS_MAGIC;
 	sb->s_op = &hugetlbfs_ops;
 	sb->s_time_gran = 1;
+
+	/*
+	 * Due to the special and limited functionality of hugetlbfs, it does
+	 * not work well as a stacking filesystem.
+	 */
+	sb->s_stack_depth = FILESYSTEM_MAX_STACK_DEPTH;
 	sb->s_root = d_make_root(hugetlbfs_get_root(sb, ctx));
 	if (!sb->s_root)
 		goto out_free;
-- 
2.25.4

