Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CE94F9306
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 12:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbiDHKe2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 06:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbiDHKe1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:34:27 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5C935DD3;
        Fri,  8 Apr 2022 03:32:23 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nclue-0002yS-Uj; Fri, 08 Apr 2022 12:32:21 +0200
Message-ID: <9163b8a9-e852-5786-24fa-d324e3118890@leemhuis.info>
Date:   Fri, 8 Apr 2022 12:32:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [regression] 5.15 kernel triggering 100x more inode evictions
Content-Language: en-US
To:     Bruno Damasceno Freire <bdamasceno@hotmail.com.br>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <MN2PR20MB2512314446801B92562E26B5D2169@MN2PR20MB2512.namprd20.prod.outlook.com>
 <07bb78be-1d58-7d88-288b-6516790f3b5d@leemhuis.info>
 <MN2PR20MB251203B4B5445B4B0C4148C9D21D9@MN2PR20MB2512.namprd20.prod.outlook.com>
 <35b62998-e386-2032-5a7a-07e3413b3bc1@leemhuis.info>
 <MN2PR20MB251205164078C367C3FC4166D2E59@MN2PR20MB2512.namprd20.prod.outlook.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <MN2PR20MB251205164078C367C3FC4166D2E59@MN2PR20MB2512.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1649413943;5afc35f4;
X-HE-SMSGID: 1nclue-0002yS-Uj
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, this is your Linux kernel regression tracker. Top-posting for once,
to make this easily accessible to everyone.

Btrfs maintainers, what's up here? Yes, this regression report was a bit
confusing in the beginning, but Bruno worked on it. And apparently it's
already fixed in 5.16, but still in 5.15. Is this caused by a change
that is to big to backport or something?

Ciao, Thorsten

#regzbot poke

On 04.04.22 07:29, Bruno Damasceno Freire wrote:
> On 28.03.22 13:28, Thorsten Leemhuis wrote:
>> Hi Btrfs developers, this is your Linux kernel regression tracker.
>> Top-posting for once, to make this easily accessible to everyone.
>>
>> Are there any known regressions in 5.15 that cause more inode evictions?
>> There is a user reporting such problems, see the msg quoted below, which
>> is the last from this thread:
>>
>> https://lore.kernel.org/all/MN2PR20MB2512314446801B92562E26B5D2169@MN2PR20MB2512.namprd20.prod.outlook.com/
>>
>> @Bruno: sorry, you report is very hard to follow at least for me. Maybe
>> the btrfs developers have a idea what's wrong here, but if not you
>> likely need to make this easier for all us:
>>
>> Write a really simple testcase and run it on those vanilla kernels that
>> matter, which are in this case: The latest 5.17.y and 5.15.y releases to
>> check if it was already solved -- and if not, on 5.14 and 5.15. Maybe
>> you need to bisect the issue to bring us closer the the root of the
>> problem. But with a bit of luck the btrfs developers might have an idea
>> already.
>>
>> Ciao, Thosten
> 
> Hi Thorsten,
> Thanks for the feedback.
> I tried my best to make it simple this time.
> I hope it is, at least, better than before.
> Grazie, Bruno
> 
> *** Test case about high inode eviction on the 5.15 kernel ***
> 
> This regression was first observed during rpm operations with specific packages that became A LOT slower to update ranging from 4 to 30 minutes [1].
> The symptoms are: high cpu usage, high inode eviction and much slower I/O performance.
> Analyzing the rpm's strace report and making some experiments I could replace the rpm with a script that do 3 thing:
> - rename a file, unlink the renamed file and create a new file.
> 
> This test case is designed to trigger the following regression on the 5.15 kernel:
> * repeated renameat2, unlink and openat system calls reach files with btrfs compression property enable.
> * the combination of these system calls and the btrfs compression property triggers the high inode eviction.
> * the high inode eviction causes to much work for the btrfs directory logging.
> * the overloaded btrfs directory logging causes the slower I/O performance.
> 
> A simplified script is supplied.
> For a more capable script, more information and more test results please refer to my github account [2].
> 
> [1] https://bugzilla.opensuse.org/show_bug.cgi?id=1193549
> [2] https://github.com/bdamascen0/s3e
> 
> Index:
> 1.   Vanilla kernels
> 2.   k5.14.21 x k5.15.32
> 2.1. Detailed test report for compressed files
> 2.2. Comparison results for compressed files
> 2.3. Detailed test report for uncompressed files
> 2.4. Comparison results for uncompressed files
> 2.5. Cpu usage
> 3.   k5.17.1 and k5.16.15
> 3.1. Basic test report
> 4.   Simplified test script
> 
> 
> 1.   Vanilla kernels
> 
> This test case mainly covers the following vanilla kernels [3]: 5.15.32 and 5.14.21.
> The 5.15.32 vanilla kernel produced abnormal results:
> * high cpu usage, high inode eviction and much slower I/O performance for compressed files.
> * double inode eviction and slightly worse I/O performance for uncompressed files.
> The 5.14.21 vanilla kernel produced normal results and is used as a reference.
> The 5.17.1 and 5.16.15 vanilla kernels [4] produced normal results which can be found at the end.
> 
> [3] https://wiki.ubuntu.com/Kernel/MainlineBuilds 
> [4] https://software.opensuse.org/package/kernel-vanilla
> 
> 
> 2.   k5.14.21 x k5.15.32
> 
> 2.1  Detailed test report for compressed files
> 
> ubuntu jammy jellyfish -- kernel 5.14.21 --- vanilla --- (kvm)
> ...updating   50 files on /mnt/inode-ev/zstd: Job took    226 ms @inode_evictions: 51
> ...updating   50 files on /mnt/inode-ev/lzo:  Job took    222 ms @inode_evictions: 51
> ...updating  100 files on /mnt/inode-ev/zstd: Job took    384 ms @inode_evictions: 101
> ...updating  100 files on /mnt/inode-ev/lzo:  Job took    462 ms @inode_evictions: 101
> ...updating  150 files on /mnt/inode-ev/zstd: Job took    493 ms @inode_evictions: 151
> ...updating  150 files on /mnt/inode-ev/lzo:  Job took    554 ms @inode_evictions: 151
> ...updating  200 files on /mnt/inode-ev/zstd: Job took    804 ms @inode_evictions: 201
> ...updating  200 files on /mnt/inode-ev/lzo:  Job took    725 ms @inode_evictions: 201
> ...updating  250 files on /mnt/inode-ev/zstd: Job took    745 ms @inode_evictions: 251
> ...updating  250 files on /mnt/inode-ev/lzo:  Job took    758 ms @inode_evictions: 251
> ...updating 1000 files on /mnt/inode-ev/zstd: Job took   3452 ms @inode_evictions: 1001
> ...updating 1000 files on /mnt/inode-ev/lzo:  Job took   2979 ms @inode_evictions: 1001
> ubuntu jammy jellyfish -- kernel 5.15.32 --- vanilla --- (kvm)
> ...updating   50 files on /mnt/inode-ev/zstd: Job took    420 ms @inode_evictions: 1275
> ...updating   50 files on /mnt/inode-ev/lzo:  Job took    488 ms @inode_evictions: 1275
> ...updating  100 files on /mnt/inode-ev/zstd: Job took   1649 ms @inode_evictions: 5050
> ...updating  100 files on /mnt/inode-ev/lzo:  Job took   1566 ms @inode_evictions: 5050
> ...updating  150 files on /mnt/inode-ev/zstd: Job took   4448 ms @inode_evictions: 11325
> ...updating  150 files on /mnt/inode-ev/lzo:  Job took   4136 ms @inode_evictions: 11325
> ...updating  200 files on /mnt/inode-ev/zstd: Job took   9177 ms @inode_evictions: 20100
> ...updating  200 files on /mnt/inode-ev/lzo:  Job took   9070 ms @inode_evictions: 20100
> ...updating  250 files on /mnt/inode-ev/zstd: Job took  16191 ms @inode_evictions: 31375
> ...updating  250 files on /mnt/inode-ev/lzo:  Job took  16062 ms @inode_evictions: 31375
> ...updating 1000 files on /mnt/inode-ev/zstd: Job took 132865 ms @inode_evictions: 104195
> ...updating 1000 files on /mnt/inode-ev/lzo:  Job took 131979 ms @inode_evictions: 106639
> 
> 2.2. Comparison results for compressed files
> 
> k5.15.32 vanilla (compared to: k5.14.21 vanilla)
> 50   files gives aprox.  1.8 x more time and aprox.  25 x more inode evictions 
> 100  files gives aprox.  3.3 x more time and aprox.  50 x more inode evictions 
> 150  files gives aprox.  7.4 x more time and aprox.  75 x more inode evictions 
> 200  files gives aprox. 11.4 x more time and aprox. 100 x more inode evictions 
> 250  files gives aprox. 21.1 x more time and aprox. 125 x more inode evictions 
> 1000 files gives aprox. 38.4 x more time and aprox. 100 x more inode evictions 
> 
> 2.3  Detailed test report for uncompressed files
> 
> ubuntu jammy jellyfish -- kernel 5.14.21 --- vanilla --- (kvm)
> ...updating   50 files on /mnt/inode-ev/uncompressed: Job took  214 ms @inode_evictions: 51
> ...updating  100 files on /mnt/inode-ev/uncompressed: Job took  402 ms @inode_evictions: 101
> ...updating  150 files on /mnt/inode-ev/uncompressed: Job took  543 ms @inode_evictions: 151
> ...updating  200 files on /mnt/inode-ev/uncompressed: Job took  694 ms @inode_evictions: 201
> ...updating  250 files on /mnt/inode-ev/uncompressed: Job took  835 ms @inode_evictions: 251
> ...updating 1000 files on /mnt/inode-ev/uncompressed: Job took 3162 ms @inode_evictions: 1001
> ubuntu jammy jellyfish -- kernel 5.15.32 --- vanilla --- (kvm)
> ...updating   50 files on /mnt/inode-ev/uncompressed: Job took  269 ms @inode_evictions: 99
> ...updating  100 files on /mnt/inode-ev/uncompressed: Job took  359 ms @inode_evictions: 199
> ...updating  150 files on /mnt/inode-ev/uncompressed: Job took  675 ms @inode_evictions: 299
> ...updating  200 files on /mnt/inode-ev/uncompressed: Job took  752 ms @inode_evictions: 399
> ...updating  250 files on /mnt/inode-ev/uncompressed: Job took 1149 ms @inode_evictions: 499
> ...updating 1000 files on /mnt/inode-ev/uncompressed: Job took 7333 ms @inode_evictions: 1999
> 
> 2.4. Comparison results for uncompressed files
> 
> k5.15.32 vanilla (compared to: k5.14.21 vanilla)
> 50   files gives aprox. 1.2 x more time and aprox. 2 x more inode evictions 
> 100  files gives aprox. 0.8 x more time and aprox. 2 x more inode evictions 
> 150  files gives aprox. 1.2 x more time and aprox. 2 x more inode evictions 
> 200  files gives aprox. 1.0 x more time and aprox. 2 x more inode evictions 
> 250  files gives aprox. 1.3 x more time and aprox. 2 x more inode evictions 
> 1000 files gives aprox. 2.3 x more time and aprox. 2 x more inode evictions 
> 
> 2.5. Cpu usage
> 
> ubuntu jammy jellyfish -- kernel 5.15.32 --- vanilla --- (kvm)
> ...updating 1000 files on /mnt/inode-ev/zstd:         Job took 132691 ms - real 2m12,731s sys 2m 7,134s
> ...updating 1000 files on /mnt/inode-ev/lzo:          Job took 134130 ms - real 2m14,149s sys 2m 8,447s
> ...updating 1000 files on /mnt/inode-ev/uncompressed: Job took   7241 ms - real 0m 7,256s sys 0m 4,732s
> 
> 
> 3    k5.17.1 and k5.16.15
> 
> Just for the record, the 5.16 kernel never reproduced the regression.
> The real life workload to trigger the regression, the rpm package updates, were verified to work fine since 5.16~rc6 [1].
> It was expected that the synthetic workload from the script also produced normal results on the 5.16 and 5.17 kernels.
> 
> [1] https://bugzilla.opensuse.org/show_bug.cgi?id=1193549
> 
> 
> 3.1  Basic test report
> 
> opensuse tumbleweed ----- kernel 5.16.15 --- vanilla --- (kvm)
> ...updating 250 files on /mnt/inode-ev/zstd:         Job took 910 ms @inode_evictions: 250
> ...updating 250 files on /mnt/inode-ev/lzo:          Job took 740 ms @inode_evictions: 250
> ...updating 250 files on /mnt/inode-ev/uncompressed: Job took 717 ms @inode_evictions: 250
> opensuse tumbleweed ----- kernel 5.17.1 ---- vanilla --- (kvm)
> ...updating 250 files on /mnt/inode-ev/zstd:         Job took 701 ms @inode_evictions: 250
> ...updating 250 files on /mnt/inode-ev/lzo:          Job took 695 ms @inode_evictions: 250
> ...updating 250 files on /mnt/inode-ev/uncompressed: Job took 954 ms @inode_evictions: 250
> 
> 
> 4.   Simplified test script
> 
> This simplified script tries to setup, format and mount a ramdisk block device.
> It creates 3 testing folders (zstd, lzo, uncompressed) and set its btrfs compression property.
> For each time the script is executed, 3 tests are done and the bpftrace is started right before each test.
> 
> #!/bin/bash
> # s3e_t3.sh (based on s3e.sh version 4.7)
> # Simple Syscall Signature Emulator (test3)
> # test3: populate + test. test renameat2/openat + unlink syscalls w/ empty files (3x)
> # Copyright (c) 2022 Bruno Damasceno <bdamasceno@hotmail.com.br>
> # Warning: no safety checks
> 
> dir1=zstd
> dir2=lzo
> dir3=uncompressed
> DIR=zzz
> NUM_FILES=250
> DEV=/dev/ram0
> MNT=/mnt/inode-ev
> DIR_1="$MNT/$dir1"
> DIR_2="$MNT/$dir2"
> DIR_3="$MNT/$dir3"
> 
> populate() {
>     DIR=$1
>     echo "...populating 1st generation of files on $DIR:"
>     for ((i = 1; i <= $NUM_FILES; i++)); do
>         echo -n > $DIR/file_$i
>     done
>     }
> 
> run_test() {
>     DIR=$1
>     sync
>     xfs_io -c "fsync" $DIR
>     echo -e "\n...updating $NUM_FILES files on $DIR:"
>     #dumb pause so bpftrace has time to atach its probe
>     sleep 3s
>     start=$(date +%s%N)
>     for ((i = 1; i <= $NUM_FILES; i++)); do
>         mv $DIR/file_$i $DIR/file_$i-RPMDELETE
>         unlink $DIR/file_$i-RPMDELETE
>         echo -n > $DIR/file_$i
>         echo -n "_$i"
>         [ $i != $NUM_FILES ] && echo -ne "\r"
>     done
>     end=$(date +%s%N)
>     dur=$(( (end - start) / 1000000 ))
>     echo -ne "\r"
>     echo "Job took $dur milliseconds"
>     }
> 
> modprobe brd rd_size=128000 max_part=1 rd_nr=1
> mkfs.btrfs --label inode-ev --force $DEV > /dev/null
> mkdir $MNT
> mount $DEV $MNT
> mkdir $MNT/{$dir1,$dir2,$dir3}
> btrfs property set $DIR_1 compression zstd:1
> btrfs property set $DIR_2 compression lzo
> btrfs property set $DIR_3 compression none
> 
> for dir in "$DIR_1" "$DIR_2" "$DIR_3"
>     do
>         populate "$dir"
>         bpftrace -e 'kprobe:btrfs_evict_inode { @inode_evictions = count(); }' & run_test "$dir"
>         pkill bpftrace
>         #dumb pause to wait the bpftrace report
>         sleep 2s
>     done
> 
> umount $MNT
> rm --dir $MNT
> rmmod brd
> 
