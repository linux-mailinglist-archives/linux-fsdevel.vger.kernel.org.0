Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DC73FF766
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 00:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239384AbhIBWuj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 18:50:39 -0400
Received: from mgw-01.mpynet.fi ([82.197.21.90]:50610 "EHLO mgw-01.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232013AbhIBWui (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 18:50:38 -0400
X-Greylist: delayed 2354 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Sep 2021 18:50:38 EDT
Received: from pps.filterd (mgw-01.mpynet.fi [127.0.0.1])
        by mgw-01.mpynet.fi (8.16.0.43/8.16.0.43) with SMTP id 182M9t3D000970;
        Fri, 3 Sep 2021 01:09:55 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-01.mpynet.fi with ESMTP id 3au6p6g0ps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 03 Sep 2021 01:09:55 +0300
Received: from tuxera.com (77.86.224.47) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Fri, 3 Sep
 2021 01:09:54 +0300
Date:   Fri, 3 Sep 2021 01:09:40 +0300
From:   Szabolcs Szakacsits <szaka@tuxera.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Theodore Ts'o <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        <zajec5@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: NTFS testing (was: [GIT PULL] vboxsf fixes for 5.14-1
In-Reply-To: <CAHk-=wiSwzrWOSN5UCrej3YcLRPmW5tViGSA5p2m-hiyKnQiMg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.2109030047330.23375@tuxera.com>
References: <4e8c0640-d781-877c-e6c5-ed5cc09443f6@gmail.com> <20210716114635.14797-1-papadakospan@gmail.com> <CAHk-=whfeq9gyPWK3yao6cCj7LKeU3vQEDGJ3rKDdcaPNVMQzQ@mail.gmail.com> <YQnHxIU+EAAxIjZA@mit.edu> <YQnU5m/ur+0D5MfJ@casper.infradead.org>
 <YQnZgq3gMKGI1Nig@mit.edu> <CAHk-=wiSwzrWOSN5UCrej3YcLRPmW5tViGSA5p2m-hiyKnQiMg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-GUID: AIsDkyzYdnO5cmGg65dSmSNKEHORpGW8
X-Proofpoint-ORIG-GUID: AIsDkyzYdnO5cmGg65dSmSNKEHORpGW8
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-02_04:2021-09-02,2021-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109020127
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Tue, 3 Aug 2021, Linus Torvalds wrote:
> On Tue, Aug 3, 2021 at 5:04 PM Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > Whenver I've ever needed to access ntfs files, I've always used the
> > ntfs-3g FUSE package.
> 
> The user-space FUSE thing does indeed work reasonably well.
> 
> It performs horribly badly if you care about things like that, though.
> 
> In fact, your own numbers kind of show that:
> 
>   ntfs/default: 670 tests, 55 failures, 211 skipped, 34783 seconds
>   ntfs3/default: 664 tests, 67 failures, 206 skipped, 8106 seconds
> 
> and that's kind of the point of ntfs3.

In all fairness, the generic/405 test case completely distorted the overall 
timing in favour of ntfs3. Neither driver was involved in that test case.

Generic/405 test is mkfs against a 1 TB thin provision device which has 1 
MB backing size. mkfs should return an error after it hits EIO. The test 
case configuration was not correct for mkntfs on behalf of ntfs-3g because 
it missed the --fast format option, so mkntfs tried to fill the 1 TB device 
with zeros, apparently on Google Cloud Platform, for almost 8 hours. This 
had absolutely nothing to do with ntfs-3g performance, it was a pure mkfs 
test:

	https://github.com/kdave/xfstests/blob/master/tests/generic/405

Meanwhile the test case ran in 1 second on behalf of ntfs3 because its mkfs 
was not found, so the test could not be run. (And the test case got 
incorrectly categorized as success because it interpreted the "command not 
found" error as a success.)

If this mkntfs test case is ignored, as it should be, then ntfs-3g's 
runtime was (34783 - 28396) = 6387 versus ntfs3's (8106 - 1) = 8105 
seconds, i.e. the user space ntfs-3g was about 21% faster overall than the 
kernel space ntfs3.

Does this mean ntfs-3g is faster than ntfs3? Of course not. Fstests is not 
a benchmark. What we know for sure is, the unknowingly configured, untuned 
versions of the software gave different times for different workloads.

File system performance is a fairly complex topic. Ntfs-3g always aimed for 
stability, features, interoperability and portability, not for best 
possible performance. There seems to be some misconceptions, 
misinterpretations, inefficient configuration and mount options (e.g. 
missing big_writes, kernel_cache, etc). Unfortunately we did our part too 
to end up here. We will set better performance defaults in future releases.

User space drivers can have major disadvantages for certain workloads 
however how relevant are those for NTFS users? Most people use NTFS for 
file transfers in which case ntfs-3g read and write speed is about 15-20% 
less compared to ext4. For example in some quick tests ext4 read was 
3.4 GB/s versus ntfs-3g 2.8 GB/s, and write was 1.3 GB/s versus 1.1 GB/s.

Additionally there are still several technical solutions which could be 
implemented to improve all kinds of user space driver performance 
significantly.

But again, we always prefer data integrity over performance. And NTFS can 
be quite tricky with the ever changing on-disk corner cases. Does anybody 
still remember when Windows 2000 changed the NTFS on-disk format which 
massively started to trash users' data?

Please don't get me wrong, I'm not saying this is the way to go (who would 
be so crazy to write anything like that on the linux-kernel list?) I'm just 
saying this is the way we chose and support. We welcome the recent interest 
in NTFS after working on it for 20 years.

------

These are from Ted's logs which he shared earlier. It's much appreciated, 
it was highly useful. Personally I also thought the very poor ntfs-3g 
timing was due to bad configuration and/or mount options instead of an 
irrelevant test case. (Btw, the driver configuration and mount options were 
indeed not right, e.g. ACL, permission, etc related cases failed which 
could have pass.)

$ egrep ^generic/405 results-ntfs*/runtests.log
results-ntfs/runtests.log:generic/405           [21:47:08] [05:40:24] 28396s
results-ntfs3/runtests.log:generic/405          [12:12:09] [12:12:10] 1s

$ cat results-ntfs/ntfs/results-default/generic/405.full
[...]
Cluster size has been automatically set to 4096 bytes.
Initializing device with zeroes: 100% - Done.
Creating NTFS volume structures.
Failed to sync device /dev/mapper/thin-vol: Input/output error
Syncing device. FAILED

$ cat results-ntfs3/ntfs3/results-default/generic/405.full
[...]
mkfs: failed to execute mkfs.ntfs3: No such file or directory

Best regards,

	Szaka
