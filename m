Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7162258F7C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 08:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbiHKGjJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 02:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbiHKGik (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 02:38:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FB38B98F;
        Wed, 10 Aug 2022 23:38:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38E18B81F67;
        Thu, 11 Aug 2022 06:38:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6267C433C1;
        Thu, 11 Aug 2022 06:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660199916;
        bh=ObzsSq38QhjJU3z9SqVp2kx02GMsyLY2WQQT993Pc+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=njvqmbiGzoNIjuVSOqkbMmQXPwsNf4qbHglOb0DqRez0oHLKxezK59yxDcXtSLkE8
         BShZe7RFI9nNwUVZBW2zo6LRfS+NqX84QPAyWK7Tvcn7D0km3A8d/l3/UmUUjKpK2O
         TO7HyQvqje10CqvI9R5gvBEU+ws99Drat/UiKlWXyshHX7kIQMRBRhV50ZxpJiaw6m
         UDLrwmoTK4Hh3i8waITK8u/FH107WMDeJCwsEccdu8AqoAtCAtNoREGDVqX/QpY9sD
         Mw9/d93T9etlwOLp6BzzENjEPWYF0UyJ4WSzebHcbiujkSsrN0jpADKVGEeuFXknPS
         ognTVfT2DiqcQ==
Date:   Thu, 11 Aug 2022 09:38:18 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 3/5] userfaultfd: selftests: modify selftest to use
 /dev/userfaultfd
Message-ID: <YvSj2h7WgV1xd2Ht@kernel.org>
References: <20220808175614.3885028-1-axelrasmussen@google.com>
 <20220808175614.3885028-4-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808175614.3885028-4-axelrasmussen@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 08, 2022 at 10:56:12AM -0700, Axel Rasmussen wrote:
> We clearly want to ensure both userfaultfd(2) and /dev/userfaultfd keep
> working into the future, so just run the test twice, using each
> interface.
> 
> Instead of always testing both userfaultfd(2) and /dev/userfaultfd,
> let the user choose which to test.
> 
> As with other test features, change the behavior based on a new
> command line flag. Introduce the idea of "test mods", which are
> generic (not specific to a test type) modifications to the behavior of
> the test. This is sort of borrowed from this RFC patch series [1], but
> simplified a bit.
> 
> The benefit is, in "typical" configurations this test is somewhat slow
> (say, 30sec or something). Testing both clearly doubles it, so it may
> not always be desirable, as users are likely to use one or the other,
> but never both, in the "real world".
> 
> [1]: https://patchwork.kernel.org/project/linux-mm/patch/20201129004548.1619714-14-namit@vmware.com/
> 
> Acked-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

With a few nits below

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  tools/testing/selftests/vm/userfaultfd.c | 69 ++++++++++++++++++++----
>  1 file changed, 60 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index 7c3f1b0ab468..cae72867c173 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -77,6 +77,11 @@ static int bounces;
>  #define TEST_SHMEM	3
>  static int test_type;
>  
> +#define UFFD_FLAGS	(O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY)
> +
> +/* test using /dev/userfaultfd, instead of userfaultfd(2) */
> +static bool test_dev_userfaultfd;
> +
>  /* exercise the test_uffdio_*_eexist every ALARM_INTERVAL_SECS */
>  #define ALARM_INTERVAL_SECS 10
>  static volatile bool test_uffdio_copy_eexist = true;
> @@ -125,6 +130,8 @@ struct uffd_stats {
>  const char *examples =
>      "# Run anonymous memory test on 100MiB region with 99999 bounces:\n"
>      "./userfaultfd anon 100 99999\n\n"
> +    "# Run the same anonymous memory test, but using /dev/userfaultfd:\n"
> +    "./userfaultfd anon:dev 100 99999\n\n"
>      "# Run share memory test on 1GiB region with 99 bounces:\n"
>      "./userfaultfd shmem 1000 99\n\n"
>      "# Run hugetlb memory test on 256MiB region with 50 bounces:\n"
> @@ -141,6 +148,14 @@ static void usage(void)
>  		"[hugetlbfs_file]\n\n");
>  	fprintf(stderr, "Supported <test type>: anon, hugetlb, "
>  		"hugetlb_shared, shmem\n\n");
> +	fprintf(stderr, "'Test mods' can be joined to the test type string with a ':'. "
> +		"Supported mods:\n");
> +	fprintf(stderr, "\tsyscall - Use userfaultfd(2) (default)\n");
> +	fprintf(stderr, "\tdev - Use /dev/userfaultfd instead of userfaultfd(2)\n");
> +	fprintf(stderr, "\nExample test mod usage:\n");
> +	fprintf(stderr, "# Run anonymous memory test with /dev/userfaultfd:\n");
> +	fprintf(stderr, "./userfaultfd anon:dev 100 99999\n\n");
> +
>  	fprintf(stderr, "Examples:\n\n");
>  	fprintf(stderr, "%s", examples);
>  	exit(1);
> @@ -154,12 +169,14 @@ static void usage(void)
>  			ret, __LINE__);				\
>  	} while (0)
>  
> -#define err(fmt, ...)				\
> +#define errexit(exitcode, fmt, ...)		\
>  	do {					\
>  		_err(fmt, ##__VA_ARGS__);	\
> -		exit(1);			\
> +		exit(exitcode);			\
>  	} while (0)
>  
> +#define err(fmt, ...) errexit(1, fmt, ##__VA_ARGS__)
> +
>  static void uffd_stats_reset(struct uffd_stats *uffd_stats,
>  			     unsigned long n_cpus)
>  {
> @@ -383,13 +400,29 @@ static void assert_expected_ioctls_present(uint64_t mode, uint64_t ioctls)
>  	}
>  }
>  
> +static int __userfaultfd_open_dev(void)
> +{
> +	int fd, _uffd = -1;

Nit: the initialization here is not necessary, _uffd is always set from
ioctl() return value.

> +
> +	fd = open("/dev/userfaultfd", O_RDWR | O_CLOEXEC);
> +	if (fd < 0)
> +		return -1;
> +
> +	_uffd = ioctl(fd, USERFAULTFD_IOC_NEW, UFFD_FLAGS);
> +	close(fd);
> +	return _uffd;
> +}
> +
>  static void userfaultfd_open(uint64_t *features)
>  {
>  	struct uffdio_api uffdio_api;
>  
> -	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
> +	if (test_dev_userfaultfd)
> +		uffd = __userfaultfd_open_dev();
> +	else
> +		uffd = syscall(__NR_userfaultfd, UFFD_FLAGS);
>  	if (uffd < 0)
> -		err("userfaultfd syscall not available in this kernel");
> +		errexit(KSFT_SKIP, "creating userfaultfd failed");

I'm not sure if this should be KSFT_SKIP. If creation of uffd failed
because anything except ENOSYS I'd consider the test failing. 

>  	uffd_flags = fcntl(uffd, F_GETFD, NULL);
>  
>  	uffdio_api.api = UFFD_API;
> @@ -1584,8 +1617,6 @@ unsigned long default_huge_page_size(void)
>  
>  static void set_test_type(const char *type)
>  {
> -	uint64_t features = UFFD_API_FEATURES;
> -
>  	if (!strcmp(type, "anon")) {
>  		test_type = TEST_ANON;
>  		uffd_test_ops = &anon_uffd_test_ops;
> @@ -1603,9 +1634,29 @@ static void set_test_type(const char *type)
>  		test_type = TEST_SHMEM;
>  		uffd_test_ops = &shmem_uffd_test_ops;
>  		test_uffdio_minor = true;
> -	} else {
> -		err("Unknown test type: %s", type);
>  	}
> +}
> +
> +static void parse_test_type_arg(const char *raw_type)
> +{
> +	char *buf = strdup(raw_type);
> +	uint64_t features = UFFD_API_FEATURES;
> +
> +	while (buf) {
> +		const char *token = strsep(&buf, ":");
> +
> +		if (!test_type)
> +			set_test_type(token);
> +		else if (!strcmp(token, "dev"))
> +			test_dev_userfaultfd = true;
> +		else if (!strcmp(token, "syscall"))
> +			test_dev_userfaultfd = false;
> +		else
> +			err("unrecognized test mod '%s'", token);
> +	}
> +
> +	if (!test_type)
> +		err("failed to parse test type argument: '%s'", raw_type);
>  
>  	if (test_type == TEST_HUGETLB)
>  		page_size = default_huge_page_size();
> @@ -1653,7 +1704,7 @@ int main(int argc, char **argv)
>  		err("failed to arm SIGALRM");
>  	alarm(ALARM_INTERVAL_SECS);
>  
> -	set_test_type(argv[1]);
> +	parse_test_type_arg(argv[1]);
>  
>  	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
>  	nr_pages_per_cpu = atol(argv[2]) * 1024*1024 / page_size /
> -- 
> 2.37.1.559.g78731f0fdb-goog
> 

-- 
Sincerely yours,
Mike.
