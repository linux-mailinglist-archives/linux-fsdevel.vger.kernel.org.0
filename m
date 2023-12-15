Return-Path: <linux-fsdevel+bounces-6177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 836AF81487A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 13:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A031C233DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 12:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9765B2DB6A;
	Fri, 15 Dec 2023 12:52:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7D82D059;
	Fri, 15 Dec 2023 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 695F2C15;
	Fri, 15 Dec 2023 04:53:07 -0800 (PST)
Received: from [10.57.3.36] (unknown [10.57.3.36])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A4DA3F738;
	Fri, 15 Dec 2023 04:52:20 -0800 (PST)
Message-ID: <11cdac1e-e96c-405f-63e8-35b0e2926337@arm.com>
Date: Fri, 15 Dec 2023 12:52:19 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v8 5/9] selftests/landlock: Test IOCTL support
To: =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack@google.com>,
 linux-security-module@vger.kernel.org, =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?=
 <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>,
 Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>,
 Paul Moore <paul@paul-moore.com>,
 Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
 Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>
References: <20231208155121.1943775-1-gnoack@google.com>
 <20231208155121.1943775-6-gnoack@google.com>
Content-Language: en-US
From: Aishwarya TCV <aishwarya.tcv@arm.com>
In-Reply-To: <20231208155121.1943775-6-gnoack@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 08/12/2023 15:51, Günther Noack wrote:
> Exercises Landlock's IOCTL feature in different combinations of
> handling and permitting the rights LANDLOCK_ACCESS_FS_IOCTL,
> LANDLOCK_ACCESS_FS_READ_FILE, LANDLOCK_ACCESS_FS_WRITE_FILE and
> LANDLOCK_ACCESS_FS_READ_DIR, and in different combinations of using
> files and directories.
> 
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 431 ++++++++++++++++++++-

Hi Günther,

When building kselftest against next-master the below build error is
observed. A bisect (full log
below) identified this patch as introducing the failure.

Full log from a failure:
https://storage.kernelci.org/next/master/next-20231215/arm64/defconfig+kselftest/gcc-10/logs/kselftest.log

-----
make[4]: Entering directory
'/tmp/kci/linux/tools/testing/selftests/landlock'
aarch64-linux-gnu-gcc -Wall -O2 -isystem
/tmp/kci/linux/build/usr/include     base_test.c -lcap -o
/tmp/kci/linux/build/kselftest/landlock/base_test
aarch64-linux-gnu-gcc -Wall -O2 -isystem
/tmp/kci/linux/build/usr/include     fs_test.c -lcap -o
/tmp/kci/linux/build/kselftest/landlock/fs_test
In file included from /tmp/kci/linux/build/usr/include/linux/fs.h:19,
                 from fs_test.c:12:
/usr/include/aarch64-linux-gnu/sys/mount.h:35:3: error: expected
identifier before numeric constant
   35 |   MS_RDONLY = 1,  /* Mount read-only.  */
      |   ^~~~~~~~~
In file included from common.h:19,
                 from fs_test.c:27:
fs_test.c: In function ‘prepare_layout_opt’:
fs_test.c:281:42: error: ‘MS_PRIVATE’ undeclared (first use in this
function)
  281 |  ASSERT_EQ(0, mount(NULL, TMP_DIR, NULL, MS_PRIVATE | MS_REC,
NULL));
      |                                          ^~~~~~~~~~
../kselftest_harness.h:707:13: note: in definition of macro ‘__EXPECT’
  707 |  __typeof__(_seen) __seen = (_seen); \
      |             ^~~~~
fs_test.c:281:2: note: in expansion of macro ‘ASSERT_EQ’
  281 |  ASSERT_EQ(0, mount(NULL, TMP_DIR, NULL, MS_PRIVATE | MS_REC,
NULL));
      |  ^~~~~~~~~
fs_test.c:281:42: note: each undeclared identifier is reported only once
for each function it appears in
  281 |  ASSERT_EQ(0, mount(NULL, TMP_DIR, NULL, MS_PRIVATE | MS_REC,
NULL));
      |                                          ^~~~~~~~~~
../kselftest_harness.h:707:13: note: in definition of macro ‘__EXPECT’
  707 |  __typeof__(_seen) __seen = (_seen); \
      |             ^~~~~
fs_test.c:281:2: note: in expansion of macro ‘ASSERT_EQ’
  281 |  ASSERT_EQ(0, mount(NULL, TMP_DIR, NULL, MS_PRIVATE | MS_REC,
NULL));
      |  ^~~~~~~~~
fs_test.c:281:55: error: ‘MS_REC’ undeclared (first use in this function)
  281 |  ASSERT_EQ(0, mount(NULL, TMP_DIR, NULL, MS_PRIVATE | MS_REC,
NULL));
      |                                                       ^~~~~~
../kselftest_harness.h:707:13: note: in definition of macro ‘__EXPECT’
  707 |  __typeof__(_seen) __seen = (_seen); \
      |             ^~~~~
fs_test.c:281:2: note: in expansion of macro ‘ASSERT_EQ’
  281 |  ASSERT_EQ(0, mount(NULL, TMP_DIR, NULL, MS_PRIVATE | MS_REC,
NULL));
      |  ^~~~~~~~~
fs_test.c: In function ‘layout1_mount_and_pivot_child’:
fs_test.c:1653:44: error: ‘MS_RDONLY’ undeclared (first use in this
function)
 1653 |  ASSERT_EQ(-1, mount(NULL, dir_s3d2, NULL, MS_RDONLY, NULL));
      |                                            ^~~~~~~~~
../kselftest_harness.h:707:13: note: in definition of macro ‘__EXPECT’
  707 |  __typeof__(_seen) __seen = (_seen); \
      |             ^~~~~
fs_test.c:1653:2: note: in expansion of macro ‘ASSERT_EQ’
 1653 |  ASSERT_EQ(-1, mount(NULL, dir_s3d2, NULL, MS_RDONLY, NULL));
      |  ^~~~~~~~~
fs_test.c: In function ‘layout1_topology_changes_with_net_only_child’:
fs_test.c:1712:43: error: ‘MS_PRIVATE’ undeclared (first use in this
function)
 1712 |  ASSERT_EQ(0, mount(NULL, dir_s1d2, NULL, MS_PRIVATE | MS_REC,
NULL));
      |                                           ^~~~~~~~~~
../kselftest_harness.h:707:13: note: in definition of macro ‘__EXPECT’
  707 |  __typeof__(_seen) __seen = (_seen); \
      |             ^~~~~
fs_test.c:1712:2: note: in expansion of macro ‘ASSERT_EQ’
 1712 |  ASSERT_EQ(0, mount(NULL, dir_s1d2, NULL, MS_PRIVATE | MS_REC,
NULL));
      |  ^~~~~~~~~
fs_test.c:1712:56: error: ‘MS_REC’ undeclared (first use in this function)
 1712 |  ASSERT_EQ(0, mount(NULL, dir_s1d2, NULL, MS_PRIVATE | MS_REC,
NULL));
      |                                                        ^~~~~~
../kselftest_harness.h:707:13: note: in definition of macro ‘__EXPECT’
  707 |  __typeof__(_seen) __seen = (_seen); \
      |             ^~~~~
fs_test.c:1712:2: note: in expansion of macro ‘ASSERT_EQ’
 1712 |  ASSERT_EQ(0, mount(NULL, dir_s1d2, NULL, MS_PRIVATE | MS_REC,
NULL));
      |  ^~~~~~~~~
fs_test.c: In function ‘layout1_topology_changes_with_net_and_fs_child’:
fs_test.c:1741:44: error: ‘MS_PRIVATE’ undeclared (first use in this
function)
 1741 |  ASSERT_EQ(-1, mount(NULL, dir_s3d2, NULL, MS_PRIVATE | MS_REC,
NULL));
      |                                            ^~~~~~~~~~
../kselftest_harness.h:707:13: note: in definition of macro ‘__EXPECT’
  707 |  __typeof__(_seen) __seen = (_seen); \
      |             ^~~~~
fs_test.c:1741:2: note: in expansion of macro ‘ASSERT_EQ’
 1741 |  ASSERT_EQ(-1, mount(NULL, dir_s3d2, NULL, MS_PRIVATE | MS_REC,
NULL));
      |  ^~~~~~~~~
fs_test.c:1741:57: error: ‘MS_REC’ undeclared (first use in this function)
 1741 |  ASSERT_EQ(-1, mount(NULL, dir_s3d2, NULL, MS_PRIVATE | MS_REC,
NULL));
      |                                                         ^~~~~~
../kselftest_harness.h:707:13: note: in definition of macro ‘__EXPECT’
  707 |  __typeof__(_seen) __seen = (_seen); \
      |             ^~~~~
fs_test.c:1741:2: note: in expansion of macro ‘ASSERT_EQ’
 1741 |  ASSERT_EQ(-1, mount(NULL, dir_s3d2, NULL, MS_PRIVATE | MS_REC,
NULL));
      |  ^~~~~~~~~
fs_test.c: In function ‘layout1_bind_setup’:
fs_test.c:4340:47: error: ‘MS_BIND’ undeclared (first use in this function)
 4340 |  ASSERT_EQ(0, mount(dir_s1d2, dir_s2d2, NULL, MS_BIND, NULL));
      |                                               ^~~~~~~
../kselftest_harness.h:707:13: note: in definition of macro ‘__EXPECT’
  707 |  __typeof__(_seen) __seen = (_seen); \
      |             ^~~~~
fs_test.c:4340:2: note: in expansion of macro ‘ASSERT_EQ’
 4340 |  ASSERT_EQ(0, mount(dir_s1d2, dir_s2d2, NULL, MS_BIND, NULL));
      |  ^~~~~~~~~
In file included from fs_test.c:19:
fs_test.c: At top level:
fs_test.c:5155:12: error: ‘MS_BIND’ undeclared here (not in a function)
 5155 |   .flags = MS_BIND,
      |            ^~~~~~~
make[4]: *** [../lib.mk:147:
/tmp/kci/linux/build/kselftest/landlock/fs_test] Error 1
make[4]: Leaving directory '/tmp/kci/linux/tools/testing/selftests/landlock'
-----


Bisect log:

-----
git bisect start
# good: [a39b6ac3781d46ba18193c9dbb2110f31e9bffe9] Linux 6.7-rc5
git bisect good a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
# bad: [11651f8cb2e88372d4ed523d909514dc9a613ea3] Add linux-next
specific files for 20231214
git bisect bad 11651f8cb2e88372d4ed523d909514dc9a613ea3
# good: [436cc0377e881784e5d12a863db037ad7d56b700] Merge branch 'main'
of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect good 436cc0377e881784e5d12a863db037ad7d56b700
# good: [4acaf686fcfee1d2ce0770a1d7505cd0e66400f0] Merge branch 'next'
of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
git bisect good 4acaf686fcfee1d2ce0770a1d7505cd0e66400f0
# good: [81d6c0949c93b9fb46ddd53819bc1dd69b161fb5] Merge branch
'tty-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
git bisect good 81d6c0949c93b9fb46ddd53819bc1dd69b161fb5
# good: [21298ae90dfc30823d4b3e8c28b536b94816a625] Merge branch
'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git
git bisect good 21298ae90dfc30823d4b3e8c28b536b94816a625
# good: [f2cd1cb9acacb72cab0f90d2d648659fda209f75] Merge branch 'kunit'
of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
git bisect good f2cd1cb9acacb72cab0f90d2d648659fda209f75
# good: [a3cd576f9a3d15f7697764a9439b91fd1acb603c] Merge branch
'slab/for-next' of
git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git
git bisect good a3cd576f9a3d15f7697764a9439b91fd1acb603c
# bad: [79b6e5e0cf1a746e40d87053db55dce76d1fd718] Merge branch
'for-next/kspp' of
git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
git bisect bad 79b6e5e0cf1a746e40d87053db55dce76d1fd718
# bad: [7098a5baeb1014c676b9e86025afd274807900a7] Merge branch
'sysctl-next' of
git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
git bisect bad 7098a5baeb1014c676b9e86025afd274807900a7
# bad: [9b4e8cb962dfcc7d5919b0ca383ff3df7f88f7cb] Merge branch 'next' of
git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git
git bisect bad 9b4e8cb962dfcc7d5919b0ca383ff3df7f88f7cb
# good: [2d2016fefb8edd11a87053caab3a9044dbd7093e] landlock: Add IOCTL
access right
git bisect good 2d2016fefb8edd11a87053caab3a9044dbd7093e
# bad: [86d25e41081ec6359c75e2e873b085de03f3cd34] selftests/landlock:
Test ioctl(2) and ftruncate(2) with open(O_PATH)
git bisect bad 86d25e41081ec6359c75e2e873b085de03f3cd34
# bad: [a725134eca88b930bc2c5947297ccf72238a8149] selftests/landlock:
Test IOCTL with memfds
git bisect bad a725134eca88b930bc2c5947297ccf72238a8149
# bad: [e0bf2e60f9c35ab3fa13ff33fb3e0088fe2248c2] selftests/landlock:
Test IOCTL support
git bisect bad e0bf2e60f9c35ab3fa13ff33fb3e0088fe2248c2
# first bad commit: [e0bf2e60f9c35ab3fa13ff33fb3e0088fe2248c2]
selftests/landlock: Test IOCTL support
-----

Thanks,
Aishwarya

