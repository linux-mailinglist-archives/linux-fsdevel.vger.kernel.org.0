Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F7A7A9915
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 20:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjIUSLR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 14:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjIUSK4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:10:56 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D0C4E5E5
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 10:52:20 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7740d57e9f3so43835485a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 10:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1695318738; x=1695923538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ye6J64RdQfSH5ZZJmFPv+aIMJZXeJIeXwiDO5WjhAs=;
        b=hVQicCzOZXJDFJrY187SaP8y/50czVn3PueWqa5ZTxQGhzzIS/suGacAqyW1LM6zo+
         Pflxc3kYG6Wzkop+xO4XmP+XjkvoQz+3o4MPkkt1KvDmn6g2o917hHoArjAtqSj21ttq
         V1OyMxmxThIe85UWT2qJ8h23XYwjJ3geQ/Q1j4+gv8ym7qbLRAQZnHPJdwOVtxXne+0T
         HC2CPeiDRQ0EZKwNi5SkYEbLPZDO5YTSIA83lcEDXC/juopCVLV/IAS6zDOYyntO2SnY
         Jaew0qOzxlZLYwZh114yixpkeJcNOf311TP7lbwrfW1vIK2apvInwoYeXgTPrFvibT9S
         uoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318738; x=1695923538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ye6J64RdQfSH5ZZJmFPv+aIMJZXeJIeXwiDO5WjhAs=;
        b=NKIsO8qfbAP6ormYx6UNUbwVg5QJoTZlyoCnGEC3xtJ93sTCqu13U5tRGXAGYQOynL
         vJZ8oz3CGmw/1kHyaCuKIIaSB+rukBxaWcGFga4e4cOyIl/jVYamjcHLRoqLf/9NrOPb
         qXn3abXN5SyAQc31Cs8kIHjqzO/HlEudY9jwPz6zrcE3ZS22d7t2WBBwZNHEnenocyRL
         ClVod6PEm2kElVIOWa0Y+791l9uZvHhxOAxazf9IUF4Eu42iq5kM4SR/4hKdSQgKIvpr
         zD1mfvrTxMLVkiS53t2T6ZLssU7/8fJSJPn+BkDhVX7B9C/l+GLyzZOO84yc/LmUAgIk
         sv9w==
X-Gm-Message-State: AOJu0YzLiSGd4HndtVj/vXCzZUzUaN1KJYFHBzYZnVMwO3cq1MZsMD39
        7qZ3GPc5dEpufz6DmhTAw6IgVUqISnTtctZ2nQ8=
X-Google-Smtp-Source: AGHT+IGcNBGL+pDeHsKhkBDdteItjMWxY4MHk0vNzkLK3f+g+ciu8dm5QelRM4idTi8vuV1fdEjBtg==
X-Received: by 2002:a17:902:c3d5:b0:1c5:d1a2:c3e8 with SMTP id j21-20020a170902c3d500b001c5d1a2c3e8mr797505plj.5.1695276240297;
        Wed, 20 Sep 2023 23:04:00 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b001bda42a216bsm519473plh.100.2023.09.20.23.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 23:03:59 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qjCn6-003Xt1-1b;
        Thu, 21 Sep 2023 16:03:56 +1000
Date:   Thu, 21 Sep 2023 16:03:56 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Pankaj Raghav <p.raghav@samsung.com>,
        Pankaj Raghav <kernel@pankajraghav.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        da.gomez@samsung.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        djwong@kernel.org, linux-mm@kvack.org, chandan.babu@oracle.com,
        gost.dev@samsung.com, riteshh@linux.ibm.com
Subject: Re: [RFC 00/23] Enable block size > page size in XFS
Message-ID: <ZQvczBjY4vTLJFBp@dread.disaster.area>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
 <ZQd4IPeVI+o6M38W@dread.disaster.area>
 <ZQewKIfRYcApEYXt@bombadil.infradead.org>
 <CGME20230918050749eucas1p13c219481b4b08c1d58e90ea70ff7b9c8@eucas1p1.samsung.com>
 <ZQfbHloBUpDh+zCg@dread.disaster.area>
 <806df723-78cf-c7eb-66a6-1442c02126b3@samsung.com>
 <ZQuxvAd2lxWppyqO@bombadil.infradead.org>
 <ZQvNVAfZMjE3hgmN@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQvNVAfZMjE3hgmN@bombadil.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 20, 2023 at 09:57:56PM -0700, Luis Chamberlain wrote:
> On Wed, Sep 20, 2023 at 08:00:12PM -0700, Luis Chamberlain wrote:
> > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=large-block-linus
> > 
> > I haven't tested yet the second branch I pushed though but it applied without any changes
> > so it should be good (usual famous last words).
> 
> I have run some preliminary tests on that branch as well above using fsx
> with larger LBA formats running them all on the *same* system at the
> same time. Kernel is happy.
> 
> root@linus ~ # uname -r
> 6.6.0-rc2-large-block-linus+
> 
> root@linus ~ # mount | grep mnt
> /dev/nvme17n1 on /mnt-16k type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)
> /dev/nvme13n1 on /mnt-32k-16ks type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)
> /dev/nvme11n1 on /mnt-64k-16ks type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=64k,noquota)
> /dev/nvme18n1 on /mnt-32k type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)
> /dev/nvme14n1 on /mnt-64k-32ks type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=64k,noquota)
> /dev/nvme7n1 on /mnt-64k-512b type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)
> /dev/nvme4n1 on /mnt-32k-512 type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)
> /dev/nvme3n1 on /mnt-16k-512b type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)
> /dev/nvme9n1 on /mnt-64k-4ks type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=64k,noquota)
> /dev/nvme8n1 on /mnt-32k-4ks type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)
> /dev/nvme6n1 on /mnt-16k-4ks type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)
> /dev/nvme5n1 on /mnt-4k type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)
> /dev/nvme1n1 on /mnt-512 type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)
> 
> root@linus ~ # ps -ef| grep fsx
> root       45601   45172 44 04:02 pts/3    00:20:26 /var/lib/xfstests/ltp/fsx -q -S 0 -p 1000000 /mnt-16k/foo
> root       46207   45658 39 04:04 pts/5    00:17:18 /var/lib/xfstests/ltp/fsx -q -S 0 -p 1000000 /mnt-32k-16ks/foo
> root       46792   46289 35 04:06 pts/7    00:14:36 /var/lib/xfstests/ltp/fsx -q -S 0 -p 1000000 /mnt-64k-16ks/foo
> root       47293   46899 39 04:08 pts/9    00:15:30 /var/lib/xfstests/ltp/fsx -q -S 0 -p 1000000 /mnt-32k/foo
> root       47921   47338 34 04:10 pts/11   00:12:56 /var/lib/xfstests/ltp/fsx -q -S 0 -p 1000000 /mnt-64k-32ks/foo
> root       48898   48484 32 04:14 pts/13   00:10:56 /var/lib/xfstests/ltp/fsx -q -S 0 -p 1000000 /mnt-64k-512b/foo
> root       49313   48939 35 04:15 pts/15   00:11:38 /var/lib/xfstests/ltp/fsx -q -S 0 -p 1000000 /mnt-32k-512/foo
> root       49729   49429 40 04:17 pts/17   00:12:27 /var/lib/xfstests/ltp/fsx -q -S 0 -p 1000000 /mnt-16k-512b/foo
> root       50085   49794 33 04:18 pts/19   00:09:56 /var/lib/xfstests/ltp/fsx -q -S 0 -p 1000000 /mnt-64k-4ks/foo
> root       50449   50130 36 04:19 pts/21   00:10:28 /var/lib/xfstests/ltp/fsx -q -S 0 -p 1000000 /mnt-32k-4ks/foo
> root       50844   50517 41 04:20 pts/23   00:11:22 /var/lib/xfstests/ltp/fsx -q -S 0 -p 1000000 /mnt-16k-4ks/foo
> root       51135   50893 52 04:21 pts/25   00:13:57 /var/lib/xfstests/ltp/fsx -q -S 0 -p 1000000 /mnt-4k/foo
> root       52061   51193 49 04:25 pts/27   00:11:21 /var/lib/xfstests/ltp/fsx -q -S 0 -p 1000000 /mnt-512/foo
> root       57668   52131  0 04:48 pts/29   00:00:00 grep fsx

So I just pulled this, built it and run generic/091 as the very
first test on this:

# ./run_check.sh --mkfs-opts "-m rmapbt=1 -b size=64k" --run-opts "-s xfs_64k generic/091"
.....
meta-data=/dev/pmem0             isize=512    agcount=4, agsize=32768 blks
         =                       sectsz=4096  attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=1
         =                       reflink=1    bigtime=1 inobtcount=1 nrext64=0
data     =                       bsize=65536  blocks=131072, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=65536  ascii-ci=0, ftype=1
log      =internal log           bsize=65536  blocks=2613, version=2
         =                       sectsz=4096  sunit=1 blks, lazy-count=1
realtime =none                   extsz=65536  blocks=0, rtextents=0
....
Running: MOUNT_OPTIONS= ./check -R xunit -b -s xfs_64k generic/091
SECTION       -- xfs_64k
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 test3 6.6.0-rc2-large-block-linus-dgc+ #1906 SMP PREEMPT_DYNAMIC Thu Sep 21 15:19:47 AEST 2023
MKFS_OPTIONS  -- -f -m rmapbt=1 -b size=64k /dev/pmem1
MOUNT_OPTIONS -- -o dax=never -o context=system_u:object_r:root_t:s0 /dev/pmem1 /mnt/scratch

generic/091 10s ... [failed, exit status 1]- output mismatch (see /home/dave/src/xfstests-dev/results//xfs_64k/generic/091.out.bad)
    --- tests/generic/091.out   2022-12-21 15:53:25.467044754 +1100
    +++ /home/dave/src/xfstests-dev/results//xfs_64k/generic/091.out.bad        2023-09-21 15:47:48.222559248 +1000
    @@ -1,7 +1,113 @@
     QA output created by 091
     fsx -N 10000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
    -fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
    -fsx -N 10000 -o 32768 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
    -fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
    -fsx -N 10000 -o 32768 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
    -fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -W
    ...
    (Run 'diff -u /home/dave/src/xfstests-dev/tests/generic/091.out /home/dave/src/xfstests-dev/results//xfs_64k/generic/091.out.bad'  to see the entire diff)
Failures: generic/091
Failed 1 of 1 tests
Xunit report: /home/dave/src/xfstests-dev/results//xfs_64k/result.xml

SECTION       -- xfs_64k
=========================
Failures: generic/091
Failed 1 of 1 tests


real    0m4.214s
user    0m0.972s
sys     0m3.603s
#

For all these assertions about how none of your testing is finding
bugs in this code, It's taken me *4 seconds* of test runtime to find
the first failure.

And, well, it's the same failure as I reported for the previous
version of this code:

# cat /home/dave/src/xfstests-dev/results//xfs_64k/generic/091.out.bad
/home/dave/src/xfstests-dev/ltp/fsx -N 10000 -l 500000 -r 4096 -t 512 -w 512 -Z -R -W /mnt/test/junk
mapped writes DISABLED    
Seed set to 1
main: filesystem does not support exchange range, disabling!
fallocating to largest ever: 0x79f06
READ BAD DATA: offset = 0x18000, size = 0xf000, fname = /mnt/test/junk
OFFSET      GOOD    BAD     RANGE
0x21000     0x0000  0x9008  0x0
operation# (mod 256) for the bad data may be 144
0x21001     0x0000  0x0810  0x1
operation# (mod 256) for the bad data may be 16
0x21002     0x0000  0x1000  0x2
operation# (mod 256) for the bad data may be 16
0x21005     0x0000  0x8e00  0x3
operation# (mod 256) for the bad data unknown, check HOLE and EXTEND ops
0x21007     0x0000  0x82ff  0x4
operation# (mod 256) for the bad data may be 255
0x21008     0x0000  0xffff  0x5
operation# (mod 256) for the bad data may be 255
0x21009     0x0000  0xffff  0x6
operation# (mod 256) for the bad data may be 255
0x2100a     0x0000  0xffff  0x7
operation# (mod 256) for the bad data may be 255
0x2100b     0x0000  0xff00  0x8
operation# (mod 256) for the bad data unknown, check HOLE and EXTEND ops
0x21010     0x0000  0x700b  0x9
operation# (mod 256) for the bad data may be 112
0x21011     0x0000  0x0b10  0xa
operation# (mod 256) for the bad data may be 16
0x21012     0x0000  0x1000  0xb
operation# (mod 256) for the bad data may be 16
0x21014     0x0000  0x038e  0xc
operation# (mod 256) for the bad data may be 3
0x21015     0x0000  0x8e00  0xd
operation# (mod 256) for the bad data unknown, check HOLE and EXTEND ops
0x21017     0x0000  0x82ff  0xe
operation# (mod 256) for the bad data may be 255
0x21018     0x0000  0xffff  0xf
operation# (mod 256) for the bad data may be 255
LOG DUMP (69 total operations):
1(  1 mod 256): FALLOC   0x6ba10 thru 0x79f06   (0xe4f6 bytes) EXTENDING
2(  2 mod 256): SKIPPED (no operation)
3(  3 mod 256): SKIPPED (no operation)
4(  4 mod 256): TRUNCATE DOWN   from 0x79f06 to 0x51800
5(  5 mod 256): SKIPPED (no operation)
6(  6 mod 256): READ     0x1b000 thru 0x21fff   (0x7000 bytes)
7(  7 mod 256): PUNCH    0x2ce7a thru 0x39b9e   (0xcd25 bytes)
8(  8 mod 256): PUNCH    0x29238 thru 0x29f57   (0xd20 bytes)
9(  9 mod 256): COPY 0x3000 thru 0x9fff (0x7000 bytes) to 0x40400 thru 0x473ff
10( 10 mod 256): READ     0x16000 thru 0x21fff  (0xc000 bytes)
11( 11 mod 256): FALLOC   0x4a42b thru 0x4b8f7  (0x14cc bytes) INTERIOR
12( 12 mod 256): TRUNCATE DOWN  from 0x51800 to 0x15c00 ******WWWW
13( 13 mod 256): SKIPPED (no operation)
14( 14 mod 256): READ     0xb000 thru 0x14fff   (0xa000 bytes)
15( 15 mod 256): SKIPPED (no operation)
16( 16 mod 256): SKIPPED (no operation)
17( 17 mod 256): SKIPPED (no operation)
18( 18 mod 256): READ     0x3000 thru 0x11fff   (0xf000 bytes)
19( 19 mod 256): FALLOC   0x69b94 thru 0x6c922  (0x2d8e bytes) EXTENDING
20( 20 mod 256): SKIPPED (no operation)
21( 21 mod 256): SKIPPED (no operation)
22( 22 mod 256): WRITE    0x23000 thru 0x285ff  (0x5600 bytes)
23( 23 mod 256): SKIPPED (no operation)
24( 24 mod 256): SKIPPED (no operation)
25( 25 mod 256): SKIPPED (no operation)
26( 26 mod 256): ZERO     0x1fba0 thru 0x2c568  (0xc9c9 bytes)  ******ZZZZ
27( 27 mod 256): READ     0x4f000 thru 0x50fff  (0x2000 bytes)
28( 28 mod 256): READ     0x39000 thru 0x3afff  (0x2000 bytes)
29( 29 mod 256): WRITE    0x40200 thru 0x4cdff  (0xcc00 bytes)
30( 30 mod 256): SKIPPED (no operation)
31( 31 mod 256): WRITE    0x47e00 thru 0x547ff  (0xca00 bytes)
32( 32 mod 256): SKIPPED (no operation)
33( 33 mod 256): READ     0x28000 thru 0x29fff  (0x2000 bytes)
34( 34 mod 256): SKIPPED (no operation)
35( 35 mod 256): READ     0x69000 thru 0x6bfff  (0x3000 bytes)
36( 36 mod 256): READ     0x16000 thru 0x20fff  (0xb000 bytes)
37( 37 mod 256): ZERO     0x45150 thru 0x47e9c  (0x2d4d bytes)
38( 38 mod 256): SKIPPED (no operation)
39( 39 mod 256): SKIPPED (no operation)
40( 40 mod 256): COPY 0x10000 thru 0x11fff      (0x2000 bytes) to 0x22a00 thru 0x249ff
41( 41 mod 256): WRITE    0x29000 thru 0x2efff  (0x6000 bytes)
42( 42 mod 256): ZERO     0x59c7 thru 0x13eee   (0xe528 bytes)
43( 43 mod 256): FALLOC   0x1fdbf thru 0x2e694  (0xe8d5 bytes) INTERIOR ******FFFF
44( 44 mod 256): SKIPPED (no operation)
45( 45 mod 256): ZERO     0x740f5 thru 0x7a11f  (0x602b bytes)
46( 46 mod 256): SKIPPED (no operation)
47( 47 mod 256): WRITE    0x14200 thru 0x1e3ff  (0xa200 bytes)
48( 48 mod 256): READ     0x69000 thru 0x6bfff  (0x3000 bytes)
49( 49 mod 256): TRUNCATE DOWN  from 0x6c922 to 0x16a00 ******WWWW
50( 50 mod 256): WRITE    0x15000 thru 0x163ff  (0x1400 bytes)
51( 51 mod 256): PUNCH    0x3b5e thru 0xa2c1    (0x6764 bytes)
52( 52 mod 256): SKIPPED (no operation)
53( 53 mod 256): SKIPPED (no operation)
54( 54 mod 256): WRITE    0x34a00 thru 0x3fdff  (0xb400 bytes) HOLE     ***WWWW
55( 55 mod 256): WRITE    0x38000 thru 0x397ff  (0x1800 bytes)
56( 56 mod 256): PUNCH    0x7922 thru 0x115f0   (0x9ccf bytes)
57( 57 mod 256): SKIPPED (no operation)
58( 58 mod 256): SKIPPED (no operation)
59( 59 mod 256): SKIPPED (no operation)
60( 60 mod 256): FALLOC   0x300a8 thru 0x331d0  (0x3128 bytes) INTERIOR
61( 61 mod 256): ZERO     0x3799c thru 0x39245  (0x18aa bytes)
62( 62 mod 256): ZERO     0x62fc3 thru 0x6b630  (0x866e bytes)
63( 63 mod 256): SKIPPED (no operation)
64( 64 mod 256): ZERO     0x6110a thru 0x61dad  (0xca4 bytes)
65( 65 mod 256): FALLOC   0x1d8ca thru 0x20876  (0x2fac bytes) INTERIOR
66( 66 mod 256): COPY 0x65000 thru 0x68fff      (0x4000 bytes) to 0x22400 thru 0x263ff
67( 67 mod 256): SKIPPED (no operation)
68( 68 mod 256): WRITE    0x36a00 thru 0x415ff  (0xac00 bytes)
69( 69 mod 256): READ     0x18000 thru 0x26fff  (0xf000 bytes)  ***RRRR***
Log of operations saved to "/mnt/test/junk.fsxops"; replay with --replay-ops
Correct content saved for comparison
(maybe hexdump "/mnt/test/junk" vs "/mnt/test/junk.fsxgood")

Guess what? The fsx parameters being used means it is testing things you
aren't. Yes, the '-Z -R -W' mean it is using direct IO for reads and writes,
mmap() is disabled. Other parameters indicate that using 4k aligned reads and
512 byte aligned writes and truncates.

There is a reason there are multiple different fsx tests in fstests;
they all exercise different sets of IO behaviours and alignments,
and they exercise the IO paths differently.

So there's clearly something wrong here - it's likely that the
filesystem IO alignment parameters pulled from the underlying block
device (4k physical, 512 byte logical sector sizes) are improperly
interpreted.  i.e. for a filesystem with a sector size of 4kB,
direct IO with an alignment of 512 bytes should be rejected......

-Dave.
-- 
Dave Chinner
david@fromorbit.com
