Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 034305C06F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 17:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfGAPkH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 11:40:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33034 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbfGAPkH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 11:40:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61Fcvma125611;
        Mon, 1 Jul 2019 15:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=p0DCt1q/ZMpIlHGt/HBYzqj55kMUOfGcmwx5EwTf+6I=;
 b=RdA4UUGMLkvgAsNSjpmWKjyxdvb8OUMQzz3EXxsiK/bjBvWRWYt2aJLee3Fngz2mHPRH
 coV/a6fRCMdN68hNz4v+mgko6Fu/cJ4+BsM9iwThkud8DmeHlqnIPlZv5WqSXoRpJJgB
 Ot5YcJUsyomOfD+3upfxf6MjHIKzsN5aN/0D6keudnb4prFxvvymxAXBAq8nzg1KY3Ya
 IYFnArnjWhABrYfn61PpDCdhRdzzB2NBRi5MRZCo7FHRX97sWS/r+y6rkfH8UpPITvE3
 +SCPbvPRA0Lyr+J+wbPW7jPre6UQUKClX4d1HVu2LHM4SkLWPQxkO4bYS8b0FcAPymZ1 TA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2te61dxdxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 15:39:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61FcESD007300;
        Mon, 1 Jul 2019 15:39:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2tebktradc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 15:39:28 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x61FdQjX014454;
        Mon, 1 Jul 2019 15:39:26 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jul 2019 08:39:26 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 00/16] Cache open file descriptors in knfsd
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <98d5ef75d1fa2b8775f52d378ca7d8dd1a542ae1.camel@hammerspace.com>
Date:   Mon, 1 Jul 2019 11:39:25 -0400
Cc:     Jeff Layton <jlayton@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Bruce Fields <bfields@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2A2E890C-8AD2-482D-A51C-AB6D254B9DB0@oracle.com>
References: <20190630135240.7490-1-trond.myklebust@hammerspace.com>
 <F1C28446-51F0-4999-AAA6-4FEA9371E36A@oracle.com>
 <98d5ef75d1fa2b8775f52d378ca7d8dd1a542ae1.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907010188
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907010188
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jul 1, 2019, at 11:17 AM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>=20
> On Mon, 2019-07-01 at 11:02 -0400, Chuck Lever wrote:
>> Interesting work! Kudos to you and Jeff.
>>=20
>>=20
>>> On Jun 30, 2019, at 9:52 AM, Trond Myklebust <trondmy@gmail.com>
>>> wrote:
>>>=20
>>> When a NFSv3 READ or WRITE request comes in, the first thing knfsd
>>> has
>>> to do is open a new file descriptor. While this is often a
>>> relatively
>>> inexpensive thing to do for most local filesystems, it is usually
>>> less
>>> so for FUSE, clustered or networked filesystems that are being
>>> exported
>>> by knfsd.
>>=20
>> True, I haven't measured much effect if any of open and close on
>> local
>> file systems. It would be valuable if the cover letter provided a
>> more
>> quantified assessment of the cost for these other use cases. It
>> sounds
>> plausible to me that they would be more expensive, but I'm wondering
>> if
>> the additional complexity of an open file cache is warranted and
>> effective. Do you have any benchmark results to share?
>>=20
>> Are there particular workloads where you believe open caching will be
>> especially beneficial?
>=20
> I'd expect pretty much anything with a nontrivial open() method. i.e.:
> FUSE, GFS2, OCFS2, CEPH, etc. to benefit.
>=20
> I've seen no slowdowns so far with traditional filesystems: i.e. ext4
> and xfs.
>=20
> Note that the removal of the raparms cache does in many way compensate
> for the new need to lookup the struct file.
>=20
>>> This set of patches attempts to reduce some of that cost by caching
>>> open file descriptors so that they may be reused by other incoming
>>> READ/WRITE requests for the same file.
>>=20
>> Is the open file cache a single cache per server? Wondering if there
>> can be significant interference (eg lock contention or cache
>> sloshing)
>> between separate workloads on different exports, for example.
>=20
> The file cache is global. Cache lookups are lockless (i.e. RCU
> protected), so there is little contention for the case where there is
> already an entry. For the case where we have to add an entry, there is
> a mutex that might get contended in the case of workloads with lots of
> small file open+closes.

>> Do you have any benchmark results that show that removing the raparms
>> cache is harmless?
>=20
> The same information is carried in struct file. The whole raparms =
cache
> was just a hack in order to allow us to port the readahead information
> across struct file instances. Now that we are caching the struct file
> itself, the raparms hack is unnecessary.

OK. I see the patch description of 11/16 mentions something about "stop
fiddling with raparms" but IMO the patch description for 13/16 should be
changed to make the above clear. Thanks!


> IOW: I haven't seen any slowdowns so far, however I don't have access
> to a bleeding edge networking setup that would push this further.
>=20
>>> One danger when doing this, is that knfsd may end up caching file
>>> descriptors for files that have been unlinked. In order to deal
>>> with
>>> this issue, we use fsnotify to monitor the files, and have hooks to
>>> evict those descriptors from the file cache if the i_nlink value
>>> goes to 0.
>>>=20
>>> Jeff Layton (12):
>>> sunrpc: add a new cache_detail operation for when a cache is
>>> flushed
>>> locks: create a new notifier chain for lease attempts
>>> nfsd: add a new struct file caching facility to nfsd
>>> nfsd: hook up nfsd_write to the new nfsd_file cache
>>> nfsd: hook up nfsd_read to the nfsd_file cache
>>> nfsd: hook nfsd_commit up to the nfsd_file cache
>>> nfsd: convert nfs4_file->fi_fds array to use nfsd_files
>>> nfsd: convert fi_deleg_file and ls_file fields to nfsd_file
>>> nfsd: hook up nfs4_preprocess_stateid_op to the nfsd_file cache
>>> nfsd: have nfsd_test_lock use the nfsd_file cache
>>> nfsd: rip out the raparms cache
>>> nfsd: close cached files prior to a REMOVE or RENAME that would
>>>   replace target
>>>=20
>>> Trond Myklebust (4):
>>> notify: export symbols for use by the knfsd file cache
>>> vfs: Export flush_delayed_fput for use by knfsd.
>>> nfsd: Fix up some unused variable warnings
>>> nfsd: Fix the documentation for svcxdr_tmpalloc()
>>>=20
>>> fs/file_table.c                  |   1 +
>>> fs/locks.c                       |  62 +++
>>> fs/nfsd/Kconfig                  |   1 +
>>> fs/nfsd/Makefile                 |   3 +-
>>> fs/nfsd/blocklayout.c            |   3 +-
>>> fs/nfsd/export.c                 |  13 +
>>> fs/nfsd/filecache.c              | 885
>>> +++++++++++++++++++++++++++++++
>>> fs/nfsd/filecache.h              |  60 +++
>>> fs/nfsd/nfs4layouts.c            |  12 +-
>>> fs/nfsd/nfs4proc.c               |  83 +--
>>> fs/nfsd/nfs4state.c              | 183 ++++---
>>> fs/nfsd/nfs4xdr.c                |  31 +-
>>> fs/nfsd/nfssvc.c                 |  16 +-
>>> fs/nfsd/state.h                  |  10 +-
>>> fs/nfsd/trace.h                  | 140 +++++
>>> fs/nfsd/vfs.c                    | 295 ++++-------
>>> fs/nfsd/vfs.h                    |   9 +-
>>> fs/nfsd/xdr4.h                   |  19 +-
>>> fs/notify/fsnotify.h             |   2 -
>>> fs/notify/group.c                |   2 +
>>> fs/notify/mark.c                 |   6 +
>>> include/linux/fs.h               |   5 +
>>> include/linux/fsnotify_backend.h |   2 +
>>> include/linux/sunrpc/cache.h     |   1 +
>>> net/sunrpc/cache.c               |   3 +
>>> 25 files changed, 1465 insertions(+), 382 deletions(-)
>>> create mode 100644 fs/nfsd/filecache.c
>>> create mode 100644 fs/nfsd/filecache.h
>>>=20
>>> --=20
>>> 2.21.0
>>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--
Chuck Lever



