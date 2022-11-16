Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB8B62B672
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 10:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbiKPJZJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 04:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbiKPJZG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:25:06 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E01D9FEE;
        Wed, 16 Nov 2022 01:25:04 -0800 (PST)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NByLL54f3zRpMX;
        Wed, 16 Nov 2022 17:24:42 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 17:25:02 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031;
 Wed, 16 Nov 2022 17:25:02 +0800
From:   zhaogongyi <zhaogongyi@huawei.com>
To:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "wad@chromium.org" <wad@chromium.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH -next 2/2] selftests/mincore: Optimize
 TEST(check_file_mmap) accoring to filemap read around
Thread-Topic: [PATCH -next 2/2] selftests/mincore: Optimize
 TEST(check_file_mmap) accoring to filemap read around
Thread-Index: Adj5nOPwb4CsGeQMSgC5GXpGtKemnw==
Date:   Wed, 16 Nov 2022 09:25:02 +0000
Message-ID: <d221e784d1f84d1880cf88e556e9ff3a@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

> 
> TEST(check_file_mmap) will fail when we set the ra_pages through
> blockdev like:
>   /sbin/blockdev --setra 8196 /dev/sda
> 
> And, for file mmap, kernel will read 'ra_pages/2' pages of the address on
> the left hand or right hand. So, add a checking of ra_pages according to
> the ra_pages setting of the block dev.
> 
> I have tested it on my system like:
>   i=0
>   while [ $i -lt 9000 ]
>   do
>         /sbin/blockdev --setra $i /dev/openeuler/*
>         ./mincore_selftest  || { echo "$i test failed"; exit 1; }
>         let i=$i+1
>   done
> 
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>  tools/testing/selftests/kselftest_harness.h   |  2 +
>  .../selftests/mincore/mincore_selftest.c      | 74 +++++++++++++++----
>  2 files changed, 62 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h
> b/tools/testing/selftests/kselftest_harness.h
> index 25f4d54067c0..fa40c85a1099 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -781,6 +781,8 @@
>  	} \
>  }
> 
> +#define MIN(a, b)       ((a) < (b) ? (a) : (b))
> +
>  struct __test_results {
>  	char reason[1024];	/* Reason for test result */
>  };
> diff --git a/tools/testing/selftests/mincore/mincore_selftest.c
> b/tools/testing/selftests/mincore/mincore_selftest.c
> index 287351a599a2..5eace1750fef 100644
> --- a/tools/testing/selftests/mincore/mincore_selftest.c
> +++ b/tools/testing/selftests/mincore/mincore_selftest.c
> @@ -17,6 +17,7 @@
>  #include <mntent.h>
>  #include <sys/stat.h>
>  #include <linux/fs.h>
> +#include <sys/ioctl.h>
> 
>  #include "../kselftest.h"
>  #include "../kselftest_harness.h"
> @@ -218,11 +219,7 @@ static struct mntent* find_mount_point(const
> char *name)
>   * Test mincore() behavior on a file-backed page.
>   * No pages should be loaded into memory right after the mapping. Then,
>   * accessing any address in the mapping range should load the page
> - * containing the address and a number of subsequent pages
> (readahead).
> - *
> - * The actual readahead settings depend on the test environment, so we
> - * can't make a lot of assumptions about that. This test covers the most
> - * general cases.
> + * containing the address and a number of around pages (read around).
>   */
>  TEST(check_file_mmap)
>  {
> @@ -236,6 +233,10 @@ TEST(check_file_mmap)
>  	int ra_pages = 0;
>  	struct stat s;
>  	struct mntent *mount_entry;
> +	int ra_size;
> +	int exp_ra_pages;
> +	int odd = 0;
> +	int dev_ra_pages;
> 
>  	mount_entry = find_mount_point(".");
>  	ASSERT_NE(NULL, mount_entry) {
> @@ -248,11 +249,29 @@ TEST(check_file_mmap)
>  			"test is not supported");
>  	}
> 
> +	errno = 0;
> +	fd = open(mount_entry->mnt_fsname, O_RDONLY);
> +	ASSERT_LT(0, fd) {
> +		TH_LOG("Open %s failed: %s",
> +			mount_entry->mnt_fsname, strerror(errno));
> +	}
> +
> +	errno = 0;
> +	retval = ioctl(fd, BLKRAGET, &ra_size);
> +	ASSERT_EQ(0, retval) {
> +		TH_LOG("Get block readahead size failed: %s", strerror(errno));
> +	}
> +
>  	page_size = sysconf(_SC_PAGESIZE);
>  	vec_size = FILE_SIZE / page_size;
>  	if (FILE_SIZE % page_size)
>  		vec_size++;
> 
> +	dev_ra_pages = (ra_size * 512) / page_size;
> +	exp_ra_pages = MIN(vec_size / 2, dev_ra_pages / 2);
> +	if (dev_ra_pages <= vec_size)
> +		odd = dev_ra_pages % 2;
> +
>  	vec = calloc(vec_size, sizeof(unsigned char));
>  	ASSERT_NE(NULL, vec) {
>  		TH_LOG("Can't allocate array");
> @@ -296,7 +315,7 @@ TEST(check_file_mmap)
> 
>  	/*
>  	 * Touch a page in the middle of the mapping. We expect the next
> -	 * few pages (the readahead window) to be populated too.
> +	 * few pages (the read around window) to be populated too.
>  	 */
>  	addr[FILE_SIZE / 2] = 1;
>  	retval = mincore(addr, FILE_SIZE, vec); @@ -310,22 +329,49 @@
> TEST(check_file_mmap)
>  		ra_pages++;
>  		i++;
>  	}
> -	EXPECT_GT(ra_pages, 0) {
> -		TH_LOG("No read-ahead pages found in memory");
> -	}
> 
> -	EXPECT_LT(i, vec_size) {
> -		TH_LOG("Read-ahead pages reached the end of the file");
> +	if (!exp_ra_pages) {
> +		EXPECT_EQ(ra_pages, exp_ra_pages) {
> +			TH_LOG("Check read-around pages failed");
> +		}
> +	} else {
> +		EXPECT_EQ(ra_pages + (odd ? 0 : 1), exp_ra_pages) {
> +			TH_LOG("Check read-around pages failed");
> +		}
>  	}
> +
>  	/*
> -	 * End of the readahead window. The rest of the pages shouldn't
> -	 * be in memory.
> +	 * End of the read around window. The rest of the pages shouldn't
> +	 * be in memory for the right hand.
>  	 */
>  	if (i < vec_size) {
>  		while (i < vec_size && !vec[i])
>  			i++;
>  		EXPECT_EQ(vec_size, i) {
> -			TH_LOG("Unexpected page in memory beyond readahead
> window");
> +			TH_LOG("Unexpected page in memory beyond read around
> window");
> +		}
> +	}
> +
> +	i = FILE_SIZE / 2 / page_size - 1;
> +	ra_pages = 0;
> +	while (i >= 0 && vec[i]) {
> +		ra_pages++;
> +		i--;
> +	}
> +
> +	EXPECT_EQ(ra_pages, exp_ra_pages) {
> +		TH_LOG("Check read-around pages failed");
> +	}
> +
> +	/*
> +	 * End of the read around window. The rest of the pages shouldn't
> +	 * be in memory for the left hand.
> +	 */
> +	if (i >= 0) {
> +		while (i >= 0 && !vec[i])
> +			i--;
> +		EXPECT_EQ(-1, i) {
> +			TH_LOG("Unexpected page in memory beyond read around
> window");
>  		}
>  	}
> 
> --
> 2.17.1


Gentele ping.

Regards,
Gongyi

