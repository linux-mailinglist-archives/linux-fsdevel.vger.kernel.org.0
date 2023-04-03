Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A5A6D3EEB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 10:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjDCIZe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 04:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjDCIZc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:25:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BD83C25
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 01:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680510282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0FWcmCzHAgUO3hqFJcPx5rDExk6o6HKiqb/A1eQCBFg=;
        b=GGKaHsiveNeOXfOyfW00rZzJfjS34VkQ75+B5HHGEIdeJY7hTRVq7J1hThB0twm26hmS/p
        y9yTEFXI540sOjFioqvVLUewRl2t2x21g74ln4gGCmxnWi+FyLFx8mPmB+vqhwP0oo4Wd7
        eoUWVpZiVvemONNdkoVxhScC7Qv5hgw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-Lf3zeFfUNSKJEE1nEFXnrQ-1; Mon, 03 Apr 2023 04:24:41 -0400
X-MC-Unique: Lf3zeFfUNSKJEE1nEFXnrQ-1
Received: by mail-wr1-f70.google.com with SMTP id y4-20020adfc7c4000000b002d633dc129aso2996664wrg.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Apr 2023 01:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680510280;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0FWcmCzHAgUO3hqFJcPx5rDExk6o6HKiqb/A1eQCBFg=;
        b=D4mzSK6T3UxAkFg5/ZtVXhD06PifJRyaVl30dq+GeIVRzbeRcyqNjXGQoGZ+WIu4sl
         PtBm5w7QoSD+q5XlRgr6lN3oWkDvY3DZgGZB2j8CkbwNNLMmCJ0VFZc3lTbuc2pL41sA
         NDNdplJNXZqd2LnbnGtIfKbfEHjjUikdJj7OHe7sk2YCBbckkYFMsm/HLjjl+9cSndFF
         PDVPMqHRl3b81Vhrbj6rlQ4xozmgDPoO0KpI8tQwj0khrx8npnYJCEzSahqTIdNE9KO1
         kYkdlIpMMHcCz9tdxxj0ii0y+aB4Qoy+usaDBZpHdJ23Ew9w6q5ReFCe0nVr6v7OsZ7P
         /YGQ==
X-Gm-Message-State: AAQBX9dfaMk7BK4+vb4JhO5JtAnetXKCkHMZF5z7muvqqQyNM6EBIl1t
        30NcZ61hdxqt9HaNUy67iNlQvuv2cx/XtESTBFONIkwLse0clOsGvkuh68jdXg6dvjMEujrs+pw
        DucJO67lp02sBaBK/lbgTVDmp8w==
X-Received: by 2002:a7b:c001:0:b0:3f0:3d41:bda3 with SMTP id c1-20020a7bc001000000b003f03d41bda3mr8610620wmb.5.1680510280257;
        Mon, 03 Apr 2023 01:24:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZJ101z9V0fCnzfOt+5d2ege5d2bsm7iDiCgbDLQDkFM+patuJMLvgOw0mhrTzUSdRLe9tDtQ==
X-Received: by 2002:a7b:c001:0:b0:3f0:3d41:bda3 with SMTP id c1-20020a7bc001000000b003f03d41bda3mr8610605wmb.5.1680510279889;
        Mon, 03 Apr 2023 01:24:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5e00:8e78:71f3:6243:77f0? (p200300cbc7025e008e7871f3624377f0.dip0.t-ipconnect.de. [2003:cb:c702:5e00:8e78:71f3:6243:77f0])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c290200b003edc11c2ecbsm11376835wmd.4.2023.04.03.01.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 01:24:39 -0700 (PDT)
Message-ID: <9bbdc378-e66e-0a44-244b-33dffe888a2b@redhat.com>
Date:   Mon, 3 Apr 2023 10:24:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH v3 2/2] selftests: restrictedmem: Check hugepage-ness
 of shmem file backing restrictedmem fd
Content-Language: en-US
To:     Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        qemu-devel@nongnu.org
Cc:     aarcange@redhat.com, ak@linux.intel.com, akpm@linux-foundation.org,
        arnd@arndb.de, bfields@fieldses.org, bp@alien8.de,
        chao.p.peng@linux.intel.com, corbet@lwn.net, dave.hansen@intel.com,
        ddutile@redhat.com, dhildenb@redhat.com, hpa@zytor.com,
        hughd@google.com, jlayton@kernel.org, jmattson@google.com,
        joro@8bytes.org, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, linmiaohe@huawei.com,
        luto@kernel.org, mail@maciej.szmigiero.name, mhocko@suse.com,
        michael.roth@amd.com, mingo@redhat.com, naoya.horiguchi@nec.com,
        pbonzini@redhat.com, qperret@google.com, rppt@kernel.org,
        seanjc@google.com, shuah@kernel.org, steven.price@arm.com,
        tabba@google.com, tglx@linutronix.de, vannapurve@google.com,
        vbabka@suse.cz, vkuznets@redhat.com, wanpengli@tencent.com,
        wei.w.wang@intel.com, x86@kernel.org, yu.c.zhang@linux.intel.com
References: <cover.1680306489.git.ackerleytng@google.com>
 <0061b62966d34952fb9f51235d31100df0baf450.1680306489.git.ackerleytng@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <0061b62966d34952fb9f51235d31100df0baf450.1680306489.git.ackerleytng@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01.04.23 01:50, Ackerley Tng wrote:
> For memfd_restricted() calls without a userspace mount, the backing
> file should be the shmem mount in the kernel, and the size of backing
> pages should be as defined by system-wide shmem configuration.
> 
> If a userspace mount is provided, the size of backing pages should be
> as defined in the mount.
> 
> Also includes negative tests for invalid inputs, including fds
> representing read-only superblocks/mounts.
> 

When you talk about "hugepage" in this patch, do you mean THP or 
hugetlb? I suspect thp, so it might be better to spell that out. IIRC, 
there are plans to support actual huge pages in the future, at which 
point "hugepage" terminology could be misleading.

> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>   tools/testing/selftests/Makefile              |   1 +
>   .../selftests/restrictedmem/.gitignore        |   3 +
>   .../testing/selftests/restrictedmem/Makefile  |  15 +
>   .../testing/selftests/restrictedmem/common.c  |   9 +
>   .../testing/selftests/restrictedmem/common.h  |   8 +
>   .../restrictedmem_hugepage_test.c             | 486 ++++++++++++++++++
>   6 files changed, 522 insertions(+)
>   create mode 100644 tools/testing/selftests/restrictedmem/.gitignore
>   create mode 100644 tools/testing/selftests/restrictedmem/Makefile
>   create mode 100644 tools/testing/selftests/restrictedmem/common.c
>   create mode 100644 tools/testing/selftests/restrictedmem/common.h
>   create mode 100644 tools/testing/selftests/restrictedmem/restrictedmem_hugepage_test.c
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index f07aef7c592c..44078eeefb79 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -60,6 +60,7 @@ TARGETS += pstore
>   TARGETS += ptrace
>   TARGETS += openat2
>   TARGETS += resctrl
> +TARGETS += restrictedmem
>   TARGETS += rlimits
>   TARGETS += rseq
>   TARGETS += rtc
> diff --git a/tools/testing/selftests/restrictedmem/.gitignore b/tools/testing/selftests/restrictedmem/.gitignore
> new file mode 100644
> index 000000000000..2581bcc8ff29
> --- /dev/null
> +++ b/tools/testing/selftests/restrictedmem/.gitignore
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +restrictedmem_hugepage_test
> diff --git a/tools/testing/selftests/restrictedmem/Makefile b/tools/testing/selftests/restrictedmem/Makefile
> new file mode 100644
> index 000000000000..8e5378d20226
> --- /dev/null
> +++ b/tools/testing/selftests/restrictedmem/Makefile
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +CFLAGS = $(KHDR_INCLUDES)
> +CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -std=gnu99
> +
> +TEST_GEN_PROGS += restrictedmem_hugepage_test
> +
> +include ../lib.mk
> +
> +EXTRA_CLEAN = $(OUTPUT)/common.o
> +
> +$(OUTPUT)/common.o: common.c
> +	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -ffreestanding $< -o $@
> +
> +$(TEST_GEN_PROGS): $(OUTPUT)/common.o
> diff --git a/tools/testing/selftests/restrictedmem/common.c b/tools/testing/selftests/restrictedmem/common.c
> new file mode 100644
> index 000000000000..03dac843404f
> --- /dev/null
> +++ b/tools/testing/selftests/restrictedmem/common.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <sys/syscall.h>
> +#include <unistd.h>
> +
> +int memfd_restricted(unsigned int flags, int mount_fd)
> +{
> +	return syscall(__NR_memfd_restricted, flags, mount_fd);
> +}
> diff --git a/tools/testing/selftests/restrictedmem/common.h b/tools/testing/selftests/restrictedmem/common.h
> new file mode 100644
> index 000000000000..06284ed86baf
> --- /dev/null
> +++ b/tools/testing/selftests/restrictedmem/common.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef SELFTESTS_RESTRICTEDMEM_COMMON_H
> +#define SELFTESTS_RESTRICTEDMEM_COMMON_H
> +
> +int memfd_restricted(unsigned int flags, int mount_fd);
> +
> +#endif  // SELFTESTS_RESTRICTEDMEM_COMMON_H
> diff --git a/tools/testing/selftests/restrictedmem/restrictedmem_hugepage_test.c b/tools/testing/selftests/restrictedmem/restrictedmem_hugepage_test.c
> new file mode 100644
> index 000000000000..9ed319b83cb8
> --- /dev/null
> +++ b/tools/testing/selftests/restrictedmem/restrictedmem_hugepage_test.c
> @@ -0,0 +1,486 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#define _GNU_SOURCE /* for O_PATH */
> +#define _POSIX_C_SOURCE /* for PATH_MAX */
> +#include <limits.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <sys/mount.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +
> +#include "linux/restrictedmem.h"
> +
> +#include "common.h"
> +#include "../kselftest_harness.h"
> +
> +/*
> + * Expect policy to be one of always, within_size, advise, never,
> + * deny, force
> + */
> +#define POLICY_BUF_SIZE 12
> +
> +static int get_hpage_pmd_size(void)
> +{
> +	FILE *fp;
> +	char buf[100];
> +	char *ret;
> +	int size;
> +
> +	fp = fopen("/sys/kernel/mm/transparent_hugepage/hpage_pmd_size", "r");
> +	if (!fp)
> +		return -1;
> +
> +	ret = fgets(buf, 100, fp);
> +	if (ret != buf) {
> +		size = -1;
> +		goto out;
> +	}
> +
> +	if (sscanf(buf, "%d\n", &size) != 1)
> +		size = -1;
> +
> +out:
> +	fclose(fp);
> +
> +	return size;
> +}
> +
> +static bool is_valid_shmem_thp_policy(char *policy)
> +{
> +	if (strcmp(policy, "always") == 0)
> +		return true;
> +	if (strcmp(policy, "within_size") == 0)
> +		return true;
> +	if (strcmp(policy, "advise") == 0)
> +		return true;
> +	if (strcmp(policy, "never") == 0)
> +		return true;
> +	if (strcmp(policy, "deny") == 0)
> +		return true;
> +	if (strcmp(policy, "force") == 0)
> +		return true;
> +
> +	return false;
> +}
> +
> +static int get_shmem_thp_policy(char *policy)
> +{
> +	FILE *fp;
> +	char buf[100];
> +	char *left = NULL;
> +	char *right = NULL;
> +	int ret = -1;
> +
> +	fp = fopen("/sys/kernel/mm/transparent_hugepage/shmem_enabled", "r");
> +	if (!fp)
> +		return -1;
> +
> +	if (fgets(buf, 100, fp) != buf)
> +		goto out;
> +
> +	/*
> +	 * Expect shmem_enabled to be of format like "always within_size advise
> +	 * [never] deny force"
> +	 */
> +	left = memchr(buf, '[', 100);
> +	if (!left)
> +		goto out;
> +
> +	right = memchr(buf, ']', 100);
> +	if (!right)
> +		goto out;
> +
> +	memcpy(policy, left + 1, right - left - 1);
> +
> +	ret = !is_valid_shmem_thp_policy(policy);
> +
> +out:
> +	fclose(fp);
> +	return ret;
> +}
> +
> +static int write_string_to_file(const char *path, const char *string)
> +{
> +	FILE *fp;
> +	size_t len = strlen(string);
> +	int ret = -1;
> +
> +	fp = fopen(path, "w");
> +	if (!fp)
> +		return ret;
> +
> +	if (fwrite(string, 1, len, fp) != len)
> +		goto out;
> +
> +	ret = 0;
> +
> +out:
> +	fclose(fp);
> +	return ret;
> +}
> +
> +static int set_shmem_thp_policy(char *policy)
> +{
> +	int ret = -1;
> +	/* +1 for newline */
> +	char to_write[POLICY_BUF_SIZE + 1] = { 0 };
> +
> +	if (!is_valid_shmem_thp_policy(policy))
> +		return ret;
> +
> +	ret = snprintf(to_write, POLICY_BUF_SIZE + 1, "%s\n", policy);
> +	if (ret != strlen(policy) + 1)
> +		return -1;
> +
> +	ret = write_string_to_file(
> +		"/sys/kernel/mm/transparent_hugepage/shmem_enabled", to_write);
> +
> +	return ret;
> +}
> +
> +FIXTURE(reset_shmem_enabled)
> +{
> +	char shmem_enabled[POLICY_BUF_SIZE];
> +};
> +
> +FIXTURE_SETUP(reset_shmem_enabled)
> +{
> +	memset(self->shmem_enabled, 0, POLICY_BUF_SIZE);
> +	ASSERT_EQ(get_shmem_thp_policy(self->shmem_enabled), 0);
> +}
> +
> +FIXTURE_TEARDOWN(reset_shmem_enabled)
> +{
> +	ASSERT_EQ(set_shmem_thp_policy(self->shmem_enabled), 0);
> +}
> +
> +TEST_F(reset_shmem_enabled, restrictedmem_fstat_shmem_enabled_never)
> +{
> +	int fd = -1;
> +	struct stat stat;
> +
> +	ASSERT_EQ(set_shmem_thp_policy("never"), 0);
> +
> +	fd = memfd_restricted(0, -1);
> +	ASSERT_GT(fd, 0);
> +
> +	ASSERT_EQ(fstat(fd, &stat), 0);
> +
> +	/*
> +	 * st_blksize is set based on the superblock's s_blocksize_bits. For
> +	 * shmem, this is set to PAGE_SHIFT
> +	 */
> +	ASSERT_EQ(stat.st_blksize, getpagesize());
> +
> +	close(fd);
> +}
> +
> +TEST_F(reset_shmem_enabled, restrictedmem_fstat_shmem_enabled_always)
> +{
> +	int fd = -1;
> +	struct stat stat;
> +
> +	ASSERT_EQ(set_shmem_thp_policy("always"), 0);
> +
> +	fd = memfd_restricted(0, -1);
> +	ASSERT_GT(fd, 0);
> +
> +	ASSERT_EQ(fstat(fd, &stat), 0);
> +
> +	ASSERT_EQ(stat.st_blksize, get_hpage_pmd_size());
> +
> +	close(fd);
> +}
> +
> +TEST(restrictedmem_tmpfile_invalid_fd)
> +{
> +	int fd = memfd_restricted(RMFD_USERMNT, -2);
> +
> +	ASSERT_EQ(fd, -1);
> +	ASSERT_EQ(errno, EINVAL);
> +}
> +
> +TEST(restrictedmem_tmpfile_fd_not_a_mount)
> +{
> +	int fd = memfd_restricted(RMFD_USERMNT, STDOUT_FILENO);
> +
> +	ASSERT_EQ(fd, -1);
> +	ASSERT_EQ(errno, EINVAL);
> +}
> +
> +TEST(restrictedmem_tmpfile_not_tmpfs_mount)
> +{
> +	int fd = -1;
> +	int mfd = -1;
> +
> +	mfd = open("/proc", O_PATH);
> +	ASSERT_NE(mfd, -1);
> +
> +	fd = memfd_restricted(RMFD_USERMNT, mfd);
> +
> +	ASSERT_EQ(fd, -1);
> +	ASSERT_EQ(errno, EINVAL);
> +}
> +
> +FIXTURE(tmpfs_hugepage_sfd)
> +{
> +	int sfd;
> +};
> +
> +FIXTURE_SETUP(tmpfs_hugepage_sfd)
> +{
> +	self->sfd = fsopen("tmpfs", 0);
> +	ASSERT_NE(self->sfd, -1);
> +}
> +
> +FIXTURE_TEARDOWN(tmpfs_hugepage_sfd)
> +{
> +	EXPECT_EQ(close(self->sfd), 0);
> +}
> +
> +TEST_F(tmpfs_hugepage_sfd, restrictedmem_fstat_tmpfs_huge_always)
> +{
> +	int ret = -1;
> +	int fd = -1;
> +	int mfd = -1;
> +	struct stat stat;
> +
> +	fsconfig(self->sfd, FSCONFIG_SET_STRING, "huge", "always", 0);
> +	fsconfig(self->sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
> +
> +	mfd = fsmount(self->sfd, 0, 0);
> +	ASSERT_NE(mfd, -1);
> +
> +	fd = memfd_restricted(RMFD_USERMNT, mfd);
> +	ASSERT_GT(fd, 0);
> +
> +	/* User can close reference to mount */
> +	ret = close(mfd);
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = fstat(fd, &stat);
> +	ASSERT_EQ(ret, 0);
> +	ASSERT_EQ(stat.st_blksize, get_hpage_pmd_size());
> +
> +	close(fd);
> +}
> +
> +TEST_F(tmpfs_hugepage_sfd, restrictedmem_fstat_tmpfs_huge_never)
> +{
> +	int ret = -1;
> +	int fd = -1;
> +	int mfd = -1;
> +	struct stat stat;
> +
> +	fsconfig(self->sfd, FSCONFIG_SET_STRING, "huge", "never", 0);
> +	fsconfig(self->sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
> +
> +	mfd = fsmount(self->sfd, 0, 0);
> +	ASSERT_NE(mfd, -1);
> +
> +	fd = memfd_restricted(RMFD_USERMNT, mfd);
> +	ASSERT_GT(fd, 0);
> +
> +	/* User can close reference to mount */
> +	ret = close(mfd);
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = fstat(fd, &stat);
> +	ASSERT_EQ(ret, 0);
> +	ASSERT_EQ(stat.st_blksize, getpagesize());
> +
> +	close(fd);
> +}
> +
> +TEST_F(tmpfs_hugepage_sfd, restrictedmem_check_mount_flags)
> +{
> +	int ret = -1;
> +	int fd = -1;
> +	int mfd = -1;
> +
> +	fsconfig(self->sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
> +
> +	mfd = fsmount(self->sfd, 0, MOUNT_ATTR_RDONLY);
> +	ASSERT_NE(mfd, -1);
> +
> +	fd = memfd_restricted(RMFD_USERMNT, mfd);
> +	ASSERT_EQ(fd, -1);
> +	ASSERT_EQ(errno, EROFS);
> +
> +	ret = close(mfd);
> +	ASSERT_EQ(ret, 0);
> +}
> +
> +TEST_F(tmpfs_hugepage_sfd, restrictedmem_check_superblock_flags)
> +{
> +	int ret = -1;
> +	int fd = -1;
> +	int mfd = -1;
> +
> +	fsconfig(self->sfd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
> +	fsconfig(self->sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
> +
> +	mfd = fsmount(self->sfd, 0, 0);
> +	ASSERT_NE(mfd, -1);
> +
> +	fd = memfd_restricted(RMFD_USERMNT, mfd);
> +	ASSERT_EQ(fd, -1);
> +	ASSERT_EQ(errno, EROFS);
> +
> +	ret = close(mfd);
> +	ASSERT_EQ(ret, 0);
> +}
> +
> +static bool directory_exists(const char *path)
> +{
> +	struct stat sb;
> +
> +	return stat(path, &sb) == 0 && S_ISDIR(sb.st_mode);
> +}
> +
> +FIXTURE(tmpfs_hugepage_mount_path)
> +{
> +	char *mount_path;
> +};
> +
> +FIXTURE_SETUP(tmpfs_hugepage_mount_path)
> +{
> +	int ret = -1;
> +
> +	/* /tmp is an FHS-mandated world-writable directory */
> +	self->mount_path = "/tmp/restrictedmem-selftest-mnt";
> +
> +	if (!directory_exists(self->mount_path)) {
> +		ret = mkdir(self->mount_path, 0777);
> +		ASSERT_EQ(ret, 0);
> +	}
> +}
> +
> +FIXTURE_TEARDOWN(tmpfs_hugepage_mount_path)
> +{
> +	int ret = -1;
> +
> +	if (!directory_exists(self->mount_path))
> +		return;
> +
> +	ret = umount2(self->mount_path, MNT_FORCE);
> +	EXPECT_EQ(ret, 0);
> +	if (ret == -1 && errno == EINVAL)
> +		fprintf(stderr, "  %s was not mounted\n", self->mount_path);
> +
> +	ret = rmdir(self->mount_path);
> +	EXPECT_EQ(ret, 0);
> +	if (ret == -1)
> +		fprintf(stderr, "  rmdir(%s) failed: %m\n", self->mount_path);
> +}
> +
> +/*
> + * memfd_restricted() syscall can only be used with the fd of the root of the
> + * mount. When the restrictedmem's fd is open, a user should not be able to
> + * unmount or remove the mounted directory
> + */
> +TEST_F(tmpfs_hugepage_mount_path, restrictedmem_umount_rmdir_while_file_open)
> +{
> +	int ret = -1;
> +	int fd = -1;
> +	int mfd = -1;
> +	struct stat stat;
> +
> +	ret = mount("name", self->mount_path, "tmpfs", 0, "huge=always");
> +	ASSERT_EQ(ret, 0);
> +
> +	mfd = open(self->mount_path, O_PATH);
> +	ASSERT_NE(mfd, -1);
> +
> +	fd = memfd_restricted(RMFD_USERMNT, mfd);
> +	ASSERT_GT(fd, 0);
> +
> +	/* We don't need this reference to the mount anymore */
> +	ret = close(mfd);
> +	ASSERT_EQ(ret, 0);
> +
> +	/* restrictedmem's fd should still be usable */
> +	ret = fstat(fd, &stat);
> +	ASSERT_EQ(ret, 0);
> +	ASSERT_EQ(stat.st_blksize, get_hpage_pmd_size());
> +
> +	/* User should not be able to unmount directory */
> +	ret = umount2(self->mount_path, MNT_FORCE);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, EBUSY);
> +
> +	ret = rmdir(self->mount_path);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, EBUSY);
> +
> +	close(fd);
> +}
> +
> +/* The fd of a file on the mount cannot be provided as mount_fd */
> +TEST_F(tmpfs_hugepage_mount_path, restrictedmem_provide_fd_of_file)
> +{
> +	int ret = -1;
> +	int fd = -1;
> +	int ffd = -1;
> +	char tmp_file_path[PATH_MAX] = { 0 };
> +
> +	ret = mount("name", self->mount_path, "tmpfs", 0, "huge=always");
> +	ASSERT_EQ(ret, 0);
> +
> +	snprintf(tmp_file_path, PATH_MAX, "%s/tmp-file", self->mount_path);
> +	ret = write_string_to_file(tmp_file_path, "filler\n");
> +	ASSERT_EQ(ret, 0);
> +
> +	ffd = open(tmp_file_path, O_RDWR);
> +	ASSERT_GT(ffd, 0);
> +
> +	fd = memfd_restricted(RMFD_USERMNT, ffd);
> +	ASSERT_LT(fd, 0);
> +	ASSERT_EQ(errno, EINVAL);
> +
> +	ret = close(ffd);
> +	ASSERT_EQ(ret, 0);
> +
> +	close(fd);
> +	remove(tmp_file_path);
> +}
> +
> +/* The fd of files on the mount cannot be provided as mount_fd */
> +TEST_F(tmpfs_hugepage_mount_path, restrictedmem_provide_fd_of_file_in_subdir)
> +{
> +	int ret = -1;
> +	int fd = -1;
> +	int ffd = -1;
> +	char tmp_dir_path[PATH_MAX] = { 0 };
> +	char tmp_file_path[PATH_MAX] = { 0 };
> +
> +	ret = mount("name", self->mount_path, "tmpfs", 0, "huge=always");
> +	ASSERT_EQ(ret, 0);
> +
> +	snprintf(tmp_dir_path, PATH_MAX, "%s/tmp-subdir", self->mount_path);
> +	ret = mkdir(tmp_dir_path, 0777);
> +	ASSERT_EQ(ret, 0);
> +
> +	snprintf(tmp_file_path, PATH_MAX, "%s/tmp-subdir/tmp-file",
> +		 self->mount_path);
> +	ret = write_string_to_file(tmp_file_path, "filler\n");
> +	ASSERT_EQ(ret, 0);
> +
> +	ffd = open(tmp_file_path, O_RDWR);
> +	ASSERT_NE(ffd, -1);
> +
> +	fd = memfd_restricted(RMFD_USERMNT, ffd);
> +	ASSERT_LT(fd, 0);
> +	ASSERT_EQ(errno, EINVAL);
> +
> +	ret = close(ffd);
> +	ASSERT_EQ(ret, 0);
> +
> +	close(fd);
> +	remove(tmp_file_path);
> +	rmdir(tmp_dir_path);
> +}
> +
> +TEST_HARNESS_MAIN

-- 
Thanks,

David / dhildenb

