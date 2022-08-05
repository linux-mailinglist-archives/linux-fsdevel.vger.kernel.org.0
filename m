Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED89058AB66
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 15:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237742AbiHENL4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 09:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236378AbiHENLz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 09:11:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 210021ADA2
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Aug 2022 06:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659705113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AyPKB0mAxCNUUWTYUlhhyb+rMbnmnQZaMJrhaPpuC5o=;
        b=Th5lltrkc3gPBQUqZcvIz0Rob7W3MypvgwhD5VonYPrZyEIss8VUlWbU2C9IENXRSccwNK
        MielicDMy7kyFWEOmAnZ2hF52nE7oiYD/6iJEDYaJpeCIsJjA6E3gIt3X3EPatB4PAvPUq
        HpDM4+mK1Yg0mvSR+rPC41zvjUgmhHM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-Ck9YN_QAMDetoHxVkWJ8VQ-1; Fri, 05 Aug 2022 09:11:51 -0400
X-MC-Unique: Ck9YN_QAMDetoHxVkWJ8VQ-1
Received: by mail-wm1-f70.google.com with SMTP id d10-20020a05600c34ca00b003a4f0932ec3so4210694wmq.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Aug 2022 06:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=AyPKB0mAxCNUUWTYUlhhyb+rMbnmnQZaMJrhaPpuC5o=;
        b=D4tGG7X3B/kfB0Q63TjMc8enomaG1bXdW6Q0wNtIwZl9LSdA/5+ldlUH3Nfr4ndNdX
         Srp3zt+pfzSWQUIvC3p244/98albJOt+FZVZ9KZICeYR7JVuNkuRfDCdQjwYw+0YCXwn
         gYEzV8n/74CdPYwUYV82IQNktKbBCZxMk80vm6DRfwLp3TXxuEoo/7/brDLinytarjIg
         g6I7JFdGIidMSxyR2Aml1VeGeAgvceYXy8RhvlW9LNG8CClbeXI5uSNLBJPWXAeswYeo
         i+0M6b1sUOYXwgOldZyk2Y8lMatIcsrSuTJ9pdwl9duGqQSHG0TDfITzxXtZ489NHfsl
         DfpQ==
X-Gm-Message-State: ACgBeo0YKGRV3rMZU6pYfkL0UDWnHpVOYIwYmxeZxH61PfS0RjitiIPX
        oLrKy3WuHKYIufRlS79WuvuEujbqGjS9ASgOB/KROYgruGj5ohg3n7D+Q1TdaYSZfEhiZlQP/Xi
        y0i1t7BPs7dIPxE8W8FKGl+77Dw==
X-Received: by 2002:a05:600c:22d8:b0:3a5:1450:669e with SMTP id 24-20020a05600c22d800b003a51450669emr4266321wmg.102.1659705109372;
        Fri, 05 Aug 2022 06:11:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4maTuPBUIPkvn2YU8/xJs1p/whDw6HWacNW7NECuUlgU3tCxwmiRypaxnYb/j68PL3fr0dTA==
X-Received: by 2002:a05:600c:22d8:b0:3a5:1450:669e with SMTP id 24-20020a05600c22d800b003a51450669emr4266282wmg.102.1659705109038;
        Fri, 05 Aug 2022 06:11:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:fb00:f5c3:24b2:3d03:9d52? (p200300cbc706fb00f5c324b23d039d52.dip0.t-ipconnect.de. [2003:cb:c706:fb00:f5c3:24b2:3d03:9d52])
        by smtp.gmail.com with ESMTPSA id b21-20020a05600c06d500b0039c5ab7167dsm8505998wmn.48.2022.08.05.06.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 06:11:48 -0700 (PDT)
Message-ID: <c0c10ef9-b811-f259-9117-f056612c8bd1@redhat.com>
Date:   Fri, 5 Aug 2022 15:11:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-3-chao.p.peng@linux.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v7 02/14] selftests/memfd: Add tests for
 F_SEAL_AUTO_ALLOCATE
In-Reply-To: <20220706082016.2603916-3-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06.07.22 10:20, Chao Peng wrote:
> Add tests to verify sealing memfds with the F_SEAL_AUTO_ALLOCATE works
> as expected.
> 
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  tools/testing/selftests/memfd/memfd_test.c | 166 +++++++++++++++++++++
>  1 file changed, 166 insertions(+)
> 
> diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
> index 94df2692e6e4..b849ece295fd 100644
> --- a/tools/testing/selftests/memfd/memfd_test.c
> +++ b/tools/testing/selftests/memfd/memfd_test.c
> @@ -9,6 +9,7 @@
>  #include <fcntl.h>
>  #include <linux/memfd.h>
>  #include <sched.h>
> +#include <setjmp.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <signal.h>
> @@ -232,6 +233,31 @@ static void mfd_fail_open(int fd, int flags, mode_t mode)
>  	}
>  }
>  
> +static void mfd_assert_fallocate(int fd)
> +{
> +	int r;
> +
> +	r = fallocate(fd, 0, 0, mfd_def_size);
> +	if (r < 0) {
> +		printf("fallocate(ALLOC) failed: %m\n");
> +		abort();
> +	}
> +}
> +
> +static void mfd_assert_punch_hole(int fd)
> +{
> +	int r;
> +
> +	r = fallocate(fd,
> +		      FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> +		      0,
> +		      mfd_def_size);
> +	if (r < 0) {
> +		printf("fallocate(PUNCH_HOLE) failed: %m\n");
> +		abort();
> +	}
> +}
> +
>  static void mfd_assert_read(int fd)
>  {
>  	char buf[16];
> @@ -594,6 +620,94 @@ static void mfd_fail_grow_write(int fd)
>  	}
>  }
>  
> +static void mfd_assert_hole_write(int fd)
> +{
> +	ssize_t l;
> +	void *p;
> +	char *p1;
> +
> +	/*
> +	 * huegtlbfs does not support write, but we want to
> +	 * verify everything else here.
> +	 */
> +	if (!hugetlbfs_test) {
> +		/* verify direct write() succeeds */
> +		l = write(fd, "\0\0\0\0", 4);
> +		if (l != 4) {
> +			printf("write() failed: %m\n");
> +			abort();
> +		}
> +	}
> +
> +	/* verify mmaped write succeeds */
> +	p = mmap(NULL,
> +		 mfd_def_size,
> +		 PROT_READ | PROT_WRITE,
> +		 MAP_SHARED,
> +		 fd,
> +		 0);
> +	if (p == MAP_FAILED) {
> +		printf("mmap() failed: %m\n");
> +		abort();
> +	}
> +	p1 = (char *)p + mfd_def_size - 1;
> +	*p1 = 'H';
> +	if (*p1 != 'H') {
> +		printf("mmaped write failed: %m\n");
> +		abort();
> +
> +	}
> +	munmap(p, mfd_def_size);
> +}
> +
> +sigjmp_buf jbuf, *sigbuf;
> +static void sig_handler(int sig, siginfo_t *siginfo, void *ptr)
> +{
> +	if (sig == SIGBUS) {
> +		if (sigbuf)
> +			siglongjmp(*sigbuf, 1);
> +		abort();
> +	}
> +}
> +
> +static void mfd_fail_hole_write(int fd)
> +{
> +	ssize_t l;
> +	void *p;
> +	char *p1;
> +
> +	/* verify direct write() fails */
> +	l = write(fd, "data", 4);
> +	if (l > 0) {
> +		printf("expected failure on write(), but got %d: %m\n", (int)l);
> +		abort();
> +	}
> +
> +	/* verify mmaped write fails */
> +	p = mmap(NULL,
> +		 mfd_def_size,
> +		 PROT_READ | PROT_WRITE,
> +		 MAP_SHARED,
> +		 fd,
> +		 0);
> +	if (p == MAP_FAILED) {
> +		printf("mmap() failed: %m\n");
> +		abort();
> +	}
> +
> +	sigbuf = &jbuf;
> +	if (sigsetjmp(*sigbuf, 1))
> +		goto out;
> +
> +	/* Below write should trigger SIGBUS signal */
> +	p1 = (char *)p + mfd_def_size - 1;
> +	*p1 = 'H';

Maybe you want to verify separately, that bothj

> +	printf("failed to receive SIGBUS for mmaped write: %m\n");
> +	abort();
> +out:
> +	munmap(p, mfd_def_size);
> +}
> +
>  static int idle_thread_fn(void *arg)
>  {
>  	sigset_t set;
> @@ -880,6 +994,57 @@ static void test_seal_resize(void)
>  	close(fd);
>  }
>  
> +/*
> + * Test F_SEAL_AUTO_ALLOCATE
> + * Test whether F_SEAL_AUTO_ALLOCATE actually prevents allocation.
> + */
> +static void test_seal_auto_allocate(void)
> +{
> +	struct sigaction act;
> +	int fd;
> +
> +	printf("%s SEAL-AUTO-ALLOCATE\n", memfd_str);
> +
> +	memset(&act, 0, sizeof(act));
> +	act.sa_sigaction = sig_handler;
> +	act.sa_flags = SA_SIGINFO;
> +	if (sigaction(SIGBUS, &act, 0)) {
> +		printf("sigaction() failed: %m\n");
> +		abort();
> +	}
> +
> +	fd = mfd_assert_new("kern_memfd_seal_auto_allocate",
> +			    mfd_def_size,
> +			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
> +
> +	/* read/write should pass if F_SEAL_AUTO_ALLOCATE not set */
> +	mfd_assert_read(fd);
> +	mfd_assert_hole_write(fd);
> +
> +	mfd_assert_has_seals(fd, 0);
> +	mfd_assert_add_seals(fd, F_SEAL_AUTO_ALLOCATE);
> +	mfd_assert_has_seals(fd, F_SEAL_AUTO_ALLOCATE);
> +
> +	/* read/write should pass for pre-allocated area */
> +	mfd_assert_read(fd);
> +	mfd_assert_hole_write(fd);
> +
> +	mfd_assert_punch_hole(fd);
> +
> +	/* read should pass, write should fail in hole */
> +	mfd_assert_read(fd);
> +	mfd_fail_hole_write(fd);
> +
> +	mfd_assert_fallocate(fd);
> +
> +	/* read/write should pass after fallocate */
> +	mfd_assert_read(fd);
> +	mfd_assert_hole_write(fd);
> +
> +	close(fd);
> +}

What might make sense is to verify for the following operations:
* read()
* write()
* read via mmap
* write via mmap

After sealing on a hole, that there is *still* a hole and that only the
read() might succeed, with a comment stating that shmem optimized for
read on holes by reading from the shared zeropage.

I'd suggest decoupling hole_write from hole_mmap_write and similarly
have hole_read and hole_mmap_read.

You should be able to use fstat() to obtain the number of allocated
blocks to check that fairly easily.

-- 
Thanks,

David / dhildenb

