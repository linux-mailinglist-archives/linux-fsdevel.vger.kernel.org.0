Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8B39E93B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 00:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfJ2Xcb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Oct 2019 19:32:31 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35102 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726084AbfJ2Xcb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Oct 2019 19:32:31 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9TNW0jP011248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Oct 2019 19:32:01 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 87346420456; Tue, 29 Oct 2019 19:31:59 -0400 (EDT)
Date:   Tue, 29 Oct 2019 19:31:59 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     jack@suse.cz, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v6 00/11] ext4: port direct I/O to iomap infrastructure
Message-ID: <20191029233159.GA8537@mit.edu>
References: <cover.1572255424.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572255424.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew, it looks like there are a number of problems with this
patch series when using the ext3 backwards compatibility mode (e.g.,
no extents enabled).

So the following configurations are failing:

kvm-xfstests -c ext3   generic/091 generic/240 generic/263

It looks like the main issue is related to fsx failing.  On v5.4-rc3
the following command:

fsx -N 10000 -l 500000 -r 4096 -t 512 -w 512 -Z -R -W /vdd/junk

... has the following result:

root@kvm-xfstests:~# mount /vdd
[    9.366568] EXT4-fs (vdd): mounting ext3 file system using the ext4 subsystem
[    9.385537] EXT4-fs (vdd): recovery complete
[    9.389219] EXT4-fs (vdd): mounted filesystem with ordered data mode. Opts: (null)
root@kvm-xfstests:~# fsx -N 10000 -l 500000 -r 4096 -t 512 -w 512 -Z -R -W /vdd/junk
mapped writes DISABLED
Seed set to 1
main: filesystem does not support fallocate mode 0, disabling!
main: filesystem does not support fallocate mode FALLOC_FL_KEEP_SIZE, disabling!
main: filesystem does not support fallocate mode FALLOC_FL_ZERO_RANGE, disabling!
main: filesystem does not support fallocate mode FALLOC_FL_COLLAPSE_RANGE, disabling!
main: filesystem does not support fallocate mode FALLOC_FL_INSERT_RANGE, disabling!
main: filesystem does not support clone range, disabling!
main: filesystem does not support dedupe range, disabling!
truncating to largest ever: 0xe400
copying to largest ever: 0x6de00
copying to largest ever: 0x76a00
copying to largest ever: 0x78200
copying to largest ever: 0x78400
copying to largest ever: 0x78c00
truncating to largest ever: 0x79200
truncating to largest ever: 0x79600
copying to largest ever: 0x79800
All 10000 operations completed A-OK!
root@kvm-xfstests:~# 

However, with this patch series applied, the fsx command fails with a
"short write":

root@kvm-xfstests:~# mount /vdd
[    7.854352] EXT4-fs (vdd): mounting ext3 file system using the ext4 subsystem
[    7.892418] EXT4-fs (vdd): recovery complete
[    7.896480] EXT4-fs (vdd): mounted filesystem with ordered data mode. Opts: (null)
root@kvm-xfstests:~# fsx -N 10000 -l 500000 -r 4096 -t 512 -w 512 -Z -R -W /vdd/junk
mapped writes DISABLED
Seed set to 1
main: filesystem does not support fallocate mode 0, disabling!
main: filesystem does not support fallocate mode FALLOC_FL_KEEP_SIZE, disabling!
main: filesystem does not support fallocate mode FALLOC_FL_ZERO_RANGE, disabling!
main: filesystem does not support fallocate mode FALLOC_FL_COLLAPSE_RANGE, disabling!
main: filesystem does not support fallocate mode FALLOC_FL_INSERT_RANGE, disabling!
main: filesystem does not support clone range, disabling!
main: filesystem does not support dedupe range, disabling!
truncating to largest ever: 0xe400
copying to largest ever: 0x6de00
copying to largest ever: 0x76a00
short write: 0xc00 bytes instead of 0x9c00
LOG DUMP (60 total operations):
1(  1 mod 256): SKIPPED (no operation)
2(  2 mod 256): SKIPPED (no operation)
3(  3 mod 256): SKIPPED (no operation)
4(  4 mod 256): TRUNCATE UP	from 0x0 to 0xe400
5(  5 mod 256): SKIPPED (no operation)
6(  6 mod 256): SKIPPED (no operation)
7(  7 mod 256): SKIPPED (no operation)
8(  8 mod 256): WRITE    0x65a00 thru 0x665ff	(0xc00 bytes) HOLE
9(  9 mod 256): WRITE    0x17400 thru 0x1e7ff	(0x7400 bytes)
10( 10 mod 256): SKIPPED (no operation)
11( 11 mod 256): WRITE    0xa200 thru 0x12bff	(0x8a00 bytes)
12( 12 mod 256): SKIPPED (no operation)
13( 13 mod 256): SKIPPED (no operation)
14( 14 mod 256): SKIPPED (no operation)
15( 15 mod 256): SKIPPED (no operation)
16( 16 mod 256): SKIPPED (no operation)
17( 17 mod 256): SKIPPED (no operation)
18( 18 mod 256): COPY 0x8000 thru 0x13fff	(0xc000 bytes) to 0x61e00 thru 0x6ddff
19( 19 mod 256): SKIPPED (no operation)
20( 20 mod 256): COPY 0x3a000 thru 0x46fff	(0xd000 bytes) to 0x69a00 thru 0x769ff
21( 21 mod 256): READ     0x34000 thru 0x3efff	(0xb000 bytes)
22( 22 mod 256): WRITE    0x1f200 thru 0x2cbff	(0xda00 bytes)
23( 23 mod 256): READ     0x55000 thru 0x5bfff	(0x7000 bytes)
24( 24 mod 256): WRITE    0x23000 thru 0x285ff	(0x5600 bytes)
25( 25 mod 256): WRITE    0x47800 thru 0x4b1ff	(0x3a00 bytes)
26( 26 mod 256): SKIPPED (no operation)
27( 27 mod 256): READ     0x16000 thru 0x1afff	(0x5000 bytes)
28( 28 mod 256): SKIPPED (no operation)
29( 29 mod 256): SKIPPED (no operation)
30( 30 mod 256): SKIPPED (no operation)
31( 31 mod 256): SKIPPED (no operation)
32( 32 mod 256): SKIPPED (no operation)
33( 33 mod 256): SKIPPED (no operation)
34( 34 mod 256): SKIPPED (no operation)
35( 35 mod 256): READ     0x23000 thru 0x2afff	(0x8000 bytes)
36( 36 mod 256): SKIPPED (no operation)
37( 37 mod 256): PUNCH    0x11100 thru 0x18049	(0x6f4a bytes)
38( 38 mod 256): READ     0x3000 thru 0x5fff	(0x3000 bytes)
39( 39 mod 256): SKIPPED (no operation)
40( 40 mod 256): COPY 0x5b000 thru 0x65fff	(0xb000 bytes) to 0x66600 thru 0x715ff
41( 41 mod 256): SKIPPED (no operation)
42( 42 mod 256): WRITE    0x36c00 thru 0x3fdff	(0x9200 bytes)
43( 43 mod 256): SKIPPED (no operation)
44( 44 mod 256): PUNCH    0x3199d thru 0x3feaf	(0xe513 bytes)
45( 45 mod 256): SKIPPED (no operation)
46( 46 mod 256): SKIPPED (no operation)
47( 47 mod 256): COPY 0x71000 thru 0x75fff	(0x5000 bytes) to 0x38800 thru 0x3d7ff
48( 48 mod 256): SKIPPED (no operation)
49( 49 mod 256): SKIPPED (no operation)
50( 50 mod 256): SKIPPED (no operation)
51( 51 mod 256): READ     0x3a000 thru 0x43fff	(0xa000 bytes)
52( 52 mod 256): SKIPPED (no operation)
53( 53 mod 256): READ     0x10000 thru 0x16fff	(0x7000 bytes)
54( 54 mod 256): SKIPPED (no operation)
55( 55 mod 256): SKIPPED (no operation)
56( 56 mod 256): PUNCH    0x8a16 thru 0x1845d	(0xfa48 bytes)
57( 57 mod 256): WRITE    0x12800 thru 0x207ff	(0xe000 bytes)
58( 58 mod 256): SKIPPED (no operation)
59( 59 mod 256): COPY 0x28000 thru 0x36fff	(0xf000 bytes) to 0x9600 thru 0x185ff
60( 60 mod 256): WRITE    0x24000 thru 0x2dbff	(0x9c00 bytes)
Log of operations saved to "/vdd/junk.fsxops"; replay with --replay-ops
Correct content saved for comparison
(maybe hexdump "/vdd/junk" vs "/vdd/junk.fsxgood")

Could you take a look?  Thanks!!

						- Ted
