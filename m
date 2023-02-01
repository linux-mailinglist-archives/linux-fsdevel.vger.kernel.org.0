Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EE4685E70
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 05:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjBAE2W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 23:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBAE2V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 23:28:21 -0500
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003FDA275;
        Tue, 31 Jan 2023 20:28:18 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Vab8v7H_1675225695;
Received: from 30.221.131.106(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vab8v7H_1675225695)
          by smtp.aliyun-inc.com;
          Wed, 01 Feb 2023 12:28:16 +0800
Message-ID: <51d9d1b3-2b2a-9b58-2f7f-f3a56c9e04ac@linux.alibaba.com>
Date:   Wed, 1 Feb 2023 12:28:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Alexander Larsson <alexl@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>, gscrivan@redhat.com,
        brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, viro@zeniv.linux.org.uk,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
References: <cover.1674227308.git.alexl@redhat.com>
 <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
 <1ea88c8d1e666b85342374ed7c0ddf7d661e0ee1.camel@redhat.com>
 <CAOQ4uxinsBB-LpGh4h44m6Afv0VT5yWRveDG7sNvE2uJyEGOkg@mail.gmail.com>
 <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
 <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
 <b8601c976d6e5d3eccf6ef489da9768ad72f9571.camel@redhat.com>
 <e840d413-c1a7-d047-1a63-468b42571846@linux.alibaba.com>
 <2ef122849d6f35712b56ffbcc95805672980e185.camel@redhat.com>
 <8ffa28f5-77f6-6bde-5645-5fb799019bca@linux.alibaba.com>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <8ffa28f5-77f6-6bde-5645-5fb799019bca@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

There are some updated performance statistics with different
combinations on my test environment if you are interested.


On 1/27/23 6:24 PM, Gao Xiang wrote:
> ...
> 
> I've made a version and did some test, it can be fetched from:
> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b
> experimental
> 

Setup
======
CPU: x86_64 Intel(R) Xeon(R) Platinum 8269CY CPU @ 2.50GHz
Disk: 6800 IOPS upper limit
OS: Linux v6.2 (with composefs v3 patchset)

I build erofs/squashfs images following the scripts attached on [1],
with each file in the rootfs tagged with "metacopy" and "redirect" xattr.

The source rootfs is from the docker image of tensorflow [2].

The erofs images are built with mkfs.erofs with support for sparse file
added [3].

[1]
https://lore.kernel.org/linux-fsdevel/5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com/
[2]
https://hub.docker.com/layers/tensorflow/tensorflow/2.10.0/images/sha256-7f9f23ce2473eb52d17fe1b465c79c3a3604047343e23acc036296f512071bc9?context=explore
[3]
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?h=experimental&id=7c49e8b195ad90f6ca9dfccce9f6e3e39a8676f6



Image size
===========
6.4M large.composefs
5.7M large.composefs.w/o.digest (w/o --compute-digest)
6.2M large.erofs
5.2M large.erofs.T0 (with -T0, i.e. w/o nanosecond timestamp)
1.7M large.squashfs
5.8M large.squashfs.uncompressed (with -noI -noD -noF -noX)

(large.erofs.T0 is built without nanosecond timestamp, so that we get
smaller disk inode size (same with squashfs).)


Runtime Perf
=============

The "uncached" column is tested with:
hyperfine -p "echo 3 > /proc/sys/vm/drop_caches" "ls -lR $MNTPOINT"


While the "cached" column is tested with:
hyperfine -w 1 "ls -lR $MNTPOINT"


erofs and squashfs are mounted with loopback device.


				  | uncached(ms)| cached(ms)
----------------------------------|-------------|-----------
composefs (with digest)		  | 326		| 135
erofs (w/o -T0)			  | 264		| 172
erofs (w/o -T0) + overlayfs	  | 651		| 238
squashfs (compressed)		  | 538		| 211
squashfs (compressed) + overlayfs | 968		| 302
squashfs (uncompressed)		  | 406		| 172
squashfs (uncompressed)+overlayfs | 833		| 264





Following on are the detailed test statistics:

composefs(with digest) - uncached
Benchmark 1: ls -lR /mnt/cps
  Time (mean ± σ):     326.0 ms ±   6.1 ms    [User: 64.1 ms, System:
126.0 ms]
  Range (min … max):   316.3 ms … 334.5 ms    10 runs

composefs(with digest) - cached
Benchmark 1: ls -lR /mnt/cps
  Time (mean ± σ):     135.5 ms ±   4.1 ms    [User: 59.9 ms, System:
74.8 ms]
  Range (min … max):   129.5 ms … 144.8 ms    21 runs



loopback erofs(w/o -T0) - uncached
Benchmark 1: ls -lR /mnt/bootstrap
  Time (mean ± σ):     264.1 ms ±   2.1 ms    [User: 66.7 ms, System:
166.2 ms]
  Range (min … max):   261.0 ms … 267.5 ms    10 runs

loopback erofs(w/o -T0) - cached
Benchmark 1: ls -lR /mnt/bootstrap
  Time (mean ± σ):     172.3 ms ±   3.9 ms    [User: 59.3 ms, System:
112.2 ms]
  Range (min … max):   166.5 ms … 180.8 ms    17 runs


overlayfs + loopback erofs(w/o -T0) - uncached
Benchmark 1: ls -lR /mnt/ovl/mntdir
  Time (mean ± σ):     651.8 ms ±   8.8 ms    [User: 74.2 ms, System:
391.1 ms]
  Range (min … max):   632.6 ms … 665.8 ms    10 runs

overlayfs + loopback erofs(w/o -T0) - cached
Benchmark 1: ls -lR /mnt/ovl/mntdir
  Time (mean ± σ):     238.1 ms ±   7.7 ms    [User: 63.4 ms, System:
173.4 ms]
  Range (min … max):   226.7 ms … 251.2 ms    12 runs



loopback squashfs (compressed) - uncached
Benchmark 1: ls -lR /mnt/squashfs-compressed/bootstrap
  Time (mean ± σ):     538.4 ms ±   2.4 ms    [User: 67.8 ms, System:
410.3 ms]
  Range (min … max):   535.6 ms … 543.6 ms    10 runs

loopback squashfs (compressed) - cached
Benchmark 1: ls -lR /mnt/squashfs-compressed/bootstrap
  Time (mean ± σ):     211.3 ms ±   2.9 ms    [User: 61.2 ms, System:
141.3 ms]
  Range (min … max):   206.5 ms … 216.1 ms    13 runs


overlayfs + loopback squashfs (compressed) - uncached
Benchmark 1: ls -lR /mnt/squashfs-compressed/mntdir
  Time (mean ± σ):     968.0 ms ±   7.1 ms    [User: 78.4 ms, System:
675.7 ms]
  Range (min … max):   956.4 ms … 977.2 ms    10 runs

overlayfs + loopback squashfs (compressed) - cached
Benchmark 1: ls -lR /mnt/squashfs-compressed/mntdir
  Time (mean ± σ):     302.6 ms ±   6.7 ms    [User: 67.3 ms, System:
225.6 ms]
  Range (min … max):   292.4 ms … 312.3 ms    10 runs



loopback squashfs (uncompressed) - uncached
Benchmark 1: ls -lR /mnt/squashfs-uncompressed/bootstrap
  Time (mean ± σ):     406.6 ms ±   3.9 ms    [User: 69.2 ms, System:
273.3 ms]
  Range (min … max):   400.3 ms … 414.2 ms    10 runs

loopback squashfs (uncompressed) - cached
Benchmark 1: ls -lR /mnt/squashfs-uncompressed/bootstrap
  Time (mean ± σ):     172.8 ms ±   3.2 ms    [User: 61.9 ms, System:
101.6 ms]
  Range (min … max):   168.6 ms … 178.9 ms    16 runs


overlayfs + loopback squashfs (uncompressed) - uncached
Benchmark 1: ls -lR /mnt/squashfs-uncompressed/mntdir
  Time (mean ± σ):     833.4 ms ±   8.0 ms    [User: 74.1 ms, System:
539.7 ms]
  Range (min … max):   820.7 ms … 844.3 ms    10 runs

overlayfs + loopback squashfs (uncompressed) - cached
Benchmark 1: ls -lR /mnt/squashfs-uncompressed/mntdir
  Time (mean ± σ):     264.4 ms ±   7.2 ms    [User: 68.2 ms, System:
186.2 ms]
  Range (min … max):   256.5 ms … 277.1 ms    10 runs



-- 
Thanks,
Jingbo
