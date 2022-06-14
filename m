Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860E754BA7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 21:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242156AbiFNTZN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 15:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbiFNTZM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 15:25:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A92B192B2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 12:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655234710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m1JgHuVxzVW3EUm2DTV344V5KoB3ftgRF+8dYijCj7E=;
        b=OZSMXpNwul8OyzzikAUgP8nvfEMDx9/luvbGxQhC2p6G21Sfg9Kc8x4Sb7MZ726ERGVVlM
        dxd0eKCBUgeXLuz27/a7tm+EVua6KqXQx8t6CE4qEnzIzhnvuAzzqv82kSCAwB6pX++OMq
        CZ86jSxehk1Q2PHyQ8MTgPPz6t2Bqmo=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-9KT1h5lvNv-ebsgGXWzPzQ-1; Tue, 14 Jun 2022 15:25:09 -0400
X-MC-Unique: 9KT1h5lvNv-ebsgGXWzPzQ-1
Received: by mail-io1-f71.google.com with SMTP id l7-20020a6b7007000000b00669b2a0d497so4857961ioc.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 12:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m1JgHuVxzVW3EUm2DTV344V5KoB3ftgRF+8dYijCj7E=;
        b=ZRrVQkqQXeIJCi0BmnuJb/pN8DjpmgNtzKW02csOnZqzNzuU4aGtIAd7xeoBFtklKS
         P4oItRj43p37BS+rtlMHPWj7aJSe3j9IIBqDXk0vz3oQ6RWnKPqdan0UIrAIWO0w8JX4
         0mL3p1gyBnQiQ0fy6TNrixaO1bvxaD38WsG/Bng4l3CGnn+p+/jZ0c0PZY9JtySqaYIp
         nV0YwJmFs5h5qrMLdd2oN+l+SPurFhl856jHMAxuSn0Ln57b6mG9xyt2x/dprzql5nz8
         4VBwcmx84lTytMFeYMhCssJGWE+nJlmNwTrgif7/LBMOBZQkXdXKsZMqlV5tcaaCtz/7
         iiJg==
X-Gm-Message-State: AJIora8L7eRMFmMLUh0Yz2Lc83HN82/l/wcPgmnl75AW2bkevkSVYshZ
        ugjZtdVQx/Id0Q79v+URoQvqOfT+6Mu5sSfmRcn2sHiF1PmeA8HCft4v+1EbataHDboxhOP98vI
        YsgeU7clyTXWkzIIOK4XIDtLTRQ==
X-Received: by 2002:a05:6e02:156e:b0:2d1:c265:964f with SMTP id k14-20020a056e02156e00b002d1c265964fmr3980759ilu.153.1655234708490;
        Tue, 14 Jun 2022 12:25:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vTulct6ZXQrXPJZkpnJj5uihhZfw46xRlX5sgpH1UyYv+ABqvggEeyigrm4fGfeHXqmfuynA==
X-Received: by 2002:a05:6e02:156e:b0:2d1:c265:964f with SMTP id k14-20020a056e02156e00b002d1c265964fmr3980749ilu.153.1655234708266;
        Tue, 14 Jun 2022 12:25:08 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id y11-20020a02904b000000b0032e6f0d3796sm5206324jaf.145.2022.06.14.12.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 12:25:07 -0700 (PDT)
Date:   Tue, 14 Jun 2022 15:25:04 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/6] userfaultfd: selftests: modify selftest to use
 /dev/userfaultfd
Message-ID: <YqjgkKGrS89kiZWS@xz-m1.local>
References: <20220601210951.3916598-1-axelrasmussen@google.com>
 <20220601210951.3916598-4-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220601210951.3916598-4-axelrasmussen@google.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 01, 2022 at 02:09:48PM -0700, Axel Rasmussen wrote:
> We clearly want to ensure both userfaultfd(2) and /dev/userfaultfd keep
> working into the future, so just run the test twice, using each
> interface.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  tools/testing/selftests/vm/userfaultfd.c | 37 +++++++++++++++++++++---
>  1 file changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index 0bdfc1955229..1badb5d31bf9 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -77,6 +77,9 @@ static int bounces;
>  #define TEST_SHMEM	3
>  static int test_type;
>  
> +/* test using /dev/userfaultfd, instead of userfaultfd(2) */
> +static bool test_dev_userfaultfd;
> +
>  /* exercise the test_uffdio_*_eexist every ALARM_INTERVAL_SECS */
>  #define ALARM_INTERVAL_SECS 10
>  static volatile bool test_uffdio_copy_eexist = true;
> @@ -154,12 +157,14 @@ static void usage(void)
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
> @@ -383,13 +388,31 @@ static void assert_expected_ioctls_present(uint64_t mode, uint64_t ioctls)
>  	}
>  }
>  
> +static void __userfaultfd_open_dev(void)
> +{
> +	int fd;
> +
> +	uffd = -1;
> +	fd = open("/dev/userfaultfd", O_RDWR | O_CLOEXEC);
> +	if (fd < 0)
> +		return;
> +
> +	uffd = ioctl(fd, USERFAULTFD_IOC_NEW,
> +		     O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
> +	close(fd);
> +}
> +
>  static void userfaultfd_open(uint64_t *features)
>  {
>  	struct uffdio_api uffdio_api;
>  
> -	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
> +	if (test_dev_userfaultfd)
> +		__userfaultfd_open_dev();

I can understand uffd is a global var, but still AFAICT that's trivially
easy to do the return to match the syscall case..

                uffd = __userfaultfd_open_dev();

And since at it, it'll be great to make a macro:

#define  UFFD_FLAGS  (O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY)

Thanks,

> +	else
> +		uffd = syscall(__NR_userfaultfd,
> +			       O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
>  	if (uffd < 0)
> -		err("userfaultfd syscall not available in this kernel");
> +		errexit(KSFT_SKIP, "creating userfaultfd failed");
>  	uffd_flags = fcntl(uffd, F_GETFD, NULL);
>  
>  	uffdio_api.api = UFFD_API;
> @@ -1691,6 +1714,12 @@ int main(int argc, char **argv)
>  	}
>  	printf("nr_pages: %lu, nr_pages_per_cpu: %lu\n",
>  	       nr_pages, nr_pages_per_cpu);
> +
> +	test_dev_userfaultfd = false;
> +	if (userfaultfd_stress())
> +		return 1;
> +
> +	test_dev_userfaultfd = true;
>  	return userfaultfd_stress();
>  }
>  
> -- 
> 2.36.1.255.ge46751e96f-goog
> 

-- 
Peter Xu

