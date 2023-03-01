Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BE76A66C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 04:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjCADsX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 22:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjCADsW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 22:48:22 -0500
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47007699
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 19:47:58 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VcmXNVl_1677642432;
Received: from 30.221.130.94(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VcmXNVl_1677642432)
          by smtp.aliyun-inc.com;
          Wed, 01 Mar 2023 11:47:13 +0800
Message-ID: <83829005-3f12-afac-9d05-8ba721a80b4d@linux.alibaba.com>
Date:   Wed, 1 Mar 2023 11:47:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [LSF/MM/BFP TOPIC] Composefs vs erofs+overlay
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Alexander Larsson <alexl@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org
References: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
 <5958ef1a-b635-96f8-7840-0752138e75e8@linux.alibaba.com>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <5958ef1a-b635-96f8-7840-0752138e75e8@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

On 2/27/23 6:45 PM, Gao Xiang wrote:
> 
> (+cc Jingbo Xu and Christian Brauner)
> 
> On 2023/2/27 17:22, Alexander Larsson wrote:
>> Hello,
>>
>> Recently Giuseppe Scrivano and I have worked on[1] and proposed[2] the
>> Composefs filesystem. It is an opportunistically sharing, validating
>> image-based filesystem, targeting usecases like validated ostree
>> rootfs:es, validated container images that share common files, as well
>> as other image based usecases.
>>
>> During the discussions in the composefs proposal (as seen on LWN[3])
>> is has been proposed that (with some changes to overlayfs), similar
>> behaviour can be achieved by combining the overlayfs
>> "overlay.redirect" xattr with an read-only filesystem such as erofs.
>>
>> There are pros and cons to both these approaches, and the discussion
>> about their respective value has sometimes been heated. We would like
>> to have an in-person discussion at the summit, ideally also involving
>> more of the filesystem development community, so that we can reach
>> some consensus on what is the best apporach.
>>
>> Good participants would be at least: Alexander Larsson, Giuseppe
>> Scrivano, Amir Goldstein, David Chinner, Gao Xiang, Miklos Szeredi,
>> Jingbo Xu
> I'd be happy to discuss this at LSF/MM/BPF this year. Also we've addressed
> the root cause of the performance gap is that
> 
> composefs read some data symlink-like payload data by using
> cfs_read_vdata_path() which involves kernel_read() and trigger heuristic
> readahead of dir data (which is also landed in composefs vdata area
> together with payload), so that most composefs dir I/O is already done
> in advance by heuristic  readahead.  And we think almost all exist
> in-kernel local fses doesn't have such heuristic readahead and if we add
> the similar stuff, EROFS could do better than composefs.
> 
> Also we've tried random stat()s about 500~1000 files in the tree you shared
> (rather than just "ls -lR") and EROFS did almost the same or better than
> composefs.  I guess further analysis (including blktrace) could be shown by
> Jingbo later.
> 

The link path string and dirents are mix stored in a so-called vdata
(variable data) section[1] in composefs, sometimes even in the same
block (figured out by dumping the composefs image).  When doing lookup,
composefs will resolve the link path.  It will read the link path string
from vdata section through kernel_read(), along which those dirents in
the following blocks are also read in by the heuristic readahead
algorithm in kernel_read().  I believe this will much benefit the
performance in the workload like "ls -lR".



Test on Subset of Files
=======================

I also tested the performance of running stat(1) on a random subset of
these files in the tested image[2] generated by "find
<root_directory_of_tested_image> -type f -printf "%p\n" | sort -R | head
-n <lines>".

					      | uncached| cached
					      |  (ms)	|  (ms)
----------------------------------------------|---------|--------
(1900 files)
composefs				      | 352	| 15
erofs (raw disk) 			      | 355 	| 16
erofs (DIRECT loop) 			      | 367 	| 16
erofs (DIRECT loop) + overlayfs(lazyfollowup) | 379 	| 16
erofs (BUFFER loop) 			      | 85 	| 16
erofs (BUFFER loop) + overlayfs(lazyfollowup) | 96 	| 16

(1000 files)
composefs				      | 311	| 9
erofs (DIRECT loop)			      | 260	| 9
erofs (raw disk) 			      | 255 	| 9
erofs (DIRECT loop) + overlayfs(lazyfollowup) | 262 	| 9.7
erofs (BUFFER loop) 			      | 71 	| 9
erofs (BUFFER loop) + overlayfs(lazyfollowup) | 77 	| 9.4

(500 files)
composefs				      | 258	| 5.5
erofs (DIRECT loop)			      | 180	| 5.5
erofs (raw disk) 			      | 179 	| 5.5
erofs (DIRECT loop) + overlayfs(lazyfollowup) | 182 	| 5.9
erofs (BUFFER loop) 			      | 55 	| 5.7
erofs (BUFFER loop) + overlayfs(lazyfollowup) | 60 	| 5.8


Here I tested erofs solely (without overlayfs) and erofs+overlayfs.  The
code base of tested erofs is the same as the latest upstream without any
optimization.

It can be seen that, as the number of stated files decreases, erofs
gradually behaves better than composefs.  It indicates that the
heuristic readahead in kernel_read() plays an important role in the
final performance statistics of this workload.



blktrace Log
============

To further verify that the heuristic readahead in kernel_read() will
readahead dirents for composefs, I dumped the blktrace log when
composefs is accessing the manifest file.

Composefs is mounted on "/mnt/cps", and then I ran the following three
commands sequentially.

```
# ls -l /mnt/cps/etc/NetworkManager
# ls -l /mnt/cps/etc/pki
# strace ls /mnt/cps/etc/pki/pesign-rh-test
```


The blktrace log for the above three commands is shown respectively:

```
# blktrace output for "ls -l /mnt/cps/etc/NetworkManager"
  7,0   66        1     0.000000000     0  C   R 9136 + 8 [0]
  7,0   66        2     0.000302905     0  C   R 8 + 8 [0]
  7,0   66        3     0.000506568     0  C   R 9144 + 8 [0]
  7,0   66        4     0.000968212     0  C   R 9152 + 8 [0]
  7,0   66        5     0.001054728     0  C   R 48 + 8 [0]
  7,0   66        6     0.001422439     0  C  RA 9296 + 32 [0]
  7,0   66        7     0.002019686     0  C  RA 9328 + 128 [0]
  7,0   53        4     0.000006260  9052  Q   R 8 + 8 [ls]
  7,0   53        5     0.000006699  9052  G   R 8 + 8 [ls]
  7,0   53        6     0.000006892  9052  D   R 8 + 8 [ls]
  7,0   53        7     0.000308009  9052  Q   R 9144 + 8 [ls]
  7,0   53        8     0.000308552  9052  G   R 9144 + 8 [ls]
  7,0   53        9     0.000308780  9052  D   R 9144 + 8 [ls]
  7,0   53       10     0.000893060  9052  Q   R 9152 + 8 [ls]
  7,0   53       11     0.000893604  9052  G   R 9152 + 8 [ls]
  7,0   53       12     0.000893964  9052  D   R 9152 + 8 [ls]
  7,0   53       13     0.000975783  9052  Q   R 48 + 8 [ls]
  7,0   53       14     0.000976134  9052  G   R 48 + 8 [ls]
  7,0   53       15     0.000976286  9052  D   R 48 + 8 [ls]
  7,0   53       16     0.001061486  9052  Q  RA 9296 + 32 [ls]
  7,0   53       17     0.001061892  9052  G  RA 9296 + 32 [ls]
  7,0   53       18     0.001062066  9052  P   N [ls]
  7,0   53       19     0.001062282  9052  D  RA 9296 + 32 [ls]
  7,0   53       20     0.001433106  9052  Q  RA 9328 + 128 [ls]
<--readahead dirents of "/mnt/cps/etc/pki/pesign-rh-test" directory
  7,0   53       21     0.001433613  9052  G  RA 9328 + 128 [ls]
  7,0   53       22     0.001433742  9052  P   N [ls]
  7,0   53       23     0.001433888  9052  D  RA 9328 + 128 [ls]

# blktrace output for "ls -l /mnt/cps/etc/pki"
  7,0   66        8    56.301287076     0  C   R 32 + 8 [0]
  7,0   66        9    56.301580752     0  C   R 9160 + 8 [0]
  7,0   66       10    56.301666669     0  C   R 96 + 8 [0]
  7,0   53       24    56.300902079  9065  Q   R 32 + 8 [ls]
  7,0   53       25    56.300904047  9065  G   R 32 + 8 [ls]
  7,0   53       26    56.300904720  9065  D   R 32 + 8 [ls]
  7,0   53       27    56.301478055  9065  Q   R 9160 + 8 [ls]
  7,0   53       28    56.301478831  9065  G   R 9160 + 8 [ls]
  7,0   53       29    56.301479147  9065  D   R 9160 + 8 [ls]
  7,0   53       30    56.301588701  9065  Q   R 96 + 8 [ls]
  7,0   53       31    56.301589461  9065  G   R 96 + 8 [ls]
  7,0   53       32    56.301589836  9065  D   R 96 + 8 [ls]

# no output for "strace ls /mnt/cps/etc/pki/pesign-rh-test"
```

I found that there's respective blktrace log printed out when running
the first two commands, i.e. "ls -l /mnt/cps/etc/NetworkManager" and "ls
-l /mnt/cps/etc/pki", while there's no blktrace log when running the
last command, i.e. "strace ls /mnt/cps/etc/pki/pesign-rh-test".

Let's look at the blktrace log for the first command, i.e. "ls -l
/mnt/cps/etc/NetworkManager".  There's a readahead on sector 9328 with a
length of 128 sectors.


It can be seen from the filefrag of the manifest file i.e.
large.composefs that, the manifest file is stored on the disk starting
at sector 8, and thus the readahead range starts at sector 9320 (9328 -
8) of the manifest file.

```
# filefrag -v -b512 large.composefs
File size of large.composefs is 8998590 (17576 blocks of 512 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..   17567:          8..     17575:  17568:
   1:  8994816.. 8998589:          0..      3773:   3774:    8998912:
last,not_aligned,inline,eof
large.composefs: 2 extents found
```


I dumped the manifest file with tool from [3], with an enhancement of
printing the sector address of the vdata section for each file.  For
directories, the corresponding vdata section is used to place dirents.

```
|---pesign-rh-test, block 9320(1)/  <-- dirents in pesign-rh-test
|----cert9.db [etc/pki/pesign-rh-test/cert9.db], block 9769(1)
|----key4.db [etc/pki/pesign-rh-test/key4.db], block 9769(1)
|----pkcs11.txt [etc/pki/pesign-rh-test/pkcs11.txt], block 9769(1)
```

It can be seen that the dirents of "/mnt/cps/etc/pki/pesign-rh-test"
directory are placed at sector 9320 starting from the manifest file,
which has already been read ahead when running "ls -l
/mnt/cps/etc/NetworkManager".  It explains why there's no IO submitted
when reading dirents of "/mnt/cps/etc/pki/pesign-rh-test" directory.



[1]
https://lore.kernel.org/lkml/20baca7da01c285b2a77c815c9d4b3080ce4b279.1674227308.git.alexl@redhat.com/
[2] https://my.owndrive.com/index.php/s/irHJXRpZHtT3a5i
[3] https://github.com/containers/composefs

-- 
Thanks,
Jingbo
