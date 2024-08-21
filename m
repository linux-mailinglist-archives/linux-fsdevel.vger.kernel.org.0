Return-Path: <linux-fsdevel+bounces-26439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F639594C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 08:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863971C2206F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 06:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B955579CD;
	Wed, 21 Aug 2024 06:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dhSN9jGN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDEE16DC20
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 06:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222334; cv=none; b=s25V9thAjmVzG44asRB1U8youtxMoOJGtNOwdfDk3L6EsahZORM4KzGCFOSzv71FeG6/BXAXH8yPc2h3MDe9XjZEahIBbx4mNop0CZoHHfHjTrsaDTv9X+1OQA7LHJN0DbHaL43WesEUeS7F6ZSapGx93V4W0KGAz0ZMlmd8tXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222334; c=relaxed/simple;
	bh=NuNotkUpmVr5M7KLQJKFTYO5TR6/3YjlrWws6ZnLBkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oj9zC0JQe7JCrrW4hetJkwWZS+HVXHUeMNpiEB9NHakrnif/dYKxe+auJG0cbQ81ePkkmzdKh96w7VotGohM2g8kPEWRkuH8I/dYEDaVmotgzSV4m4sYK+e1KT+AgRGvbz0prudDSlf5uAP0Po4FrJV9ezv5tvCCg89whdW3oNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dhSN9jGN; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7106cf5771bso5224469b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 23:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724222332; x=1724827132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C2iigsI7hhZq9AkN6DbG2RJZY0TZnZirtCzRxJ73tUk=;
        b=dhSN9jGNP4OcsFWZ/EIWKrvNRgcFRsuv69EWIbwwPE9pCnWrYC1CI5hbcl0pRrkIvG
         fO2CdyjVT5xC8L37cMdIpr8aeL1CBJNP/jJdJ7B1dpiGftFgBb7b1kn2Y4aKk2w1UAxM
         mr0hiHbGrho1+rrssuxZ9vhvby/QO21BHMdN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724222332; x=1724827132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2iigsI7hhZq9AkN6DbG2RJZY0TZnZirtCzRxJ73tUk=;
        b=J93zJlAgzPSY+aeBB3xHWG/0DR7uNPUjQ4r7x79Da94LhFRHxYia47OFVbQbAhaIjb
         PxG64QwTqwE60g+kPir0tZrtHd++m6kr8e//zcz2WWsI6WKndv40JfBFaIvoqrDL0fAt
         UTTJt+szEygcIU6RxjmHukjYO0Bk2Dt2/RNM/0mWlE4ESXWnaiNrwv4bDz8GKH4TIQ98
         rENe5nCE8P6CSnRzRXmgaKdLMdIzA2yYepiz2JdezpvVAL7DQaoaqnQ31vb7PBuFzv1m
         WtrKg7WaxbJRyAquip7erC2RYPljpjcO9vNfZlXe9gcqdAr92GLTGvY/ojQZiKsl/1zk
         3Ypw==
X-Forwarded-Encrypted: i=1; AJvYcCWXESPDb8tjydiEHK490AY6D8zk3/wAclmG2HnpXfDezyxwXczn5dEs4vJahJxgkQYiNpdFUd8YAxsDmBEW@vger.kernel.org
X-Gm-Message-State: AOJu0YzNm7l3jM2T5NT+yaIbrtCa0+KAnkrMuYMK1pGXDdyg2zvWSbKX
	k1oR6zOpbjrpgtVtWVnr5Si97Wd5WWg9mdKbXBDDfctj7ldgiHbaS1ESF93QcV0=
X-Google-Smtp-Source: AGHT+IFRKnIKG1s4rMDH2dGf5FKh9xY5NhSyU51zLqbxWl+SRmpeERecIpIdR4LnXr2e2Ee8rNrJng==
X-Received: by 2002:a05:6a00:148a:b0:70b:1c97:bbf3 with SMTP id d2e1a72fcca58-714235ab39dmr1864318b3a.28.1724222331500;
        Tue, 20 Aug 2024 23:38:51 -0700 (PDT)
Received: from [172.20.0.208] ([218.188.70.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714200c3bdfsm990255b3a.195.2024.08.20.23.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 23:38:51 -0700 (PDT)
Message-ID: <7bf93dfd-1536-438c-9ffd-f7dcfce0b3f5@linuxfoundation.org>
Date: Wed, 21 Aug 2024 00:38:48 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [viro-vfs:work.fdtable 13/13] kernel/fork.c:3242 unshare_fd()
 warn: passing a valid pointer to 'PTR_ERR'
To: Al Viro <viro@zeniv.linux.org.uk>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, lkp@intel.com, oe-kbuild-all@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <020d5bd0-2fae-481f-bc82-88e71de1137c@stanley.mountain>
 <20240813181600.GK13701@ZenIV> <20240814010321.GL13701@ZenIV>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240814010321.GL13701@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/24 19:03, Al Viro wrote:
> On Tue, Aug 13, 2024 at 07:16:00PM +0100, Al Viro wrote:
>> On Tue, Aug 13, 2024 at 11:00:04AM +0300, Dan Carpenter wrote:
>>> 3f4b0acefd818e Al Viro           2024-08-06  3240  		if (IS_ERR(*new_fdp)) {
>>> 3f4b0acefd818e Al Viro           2024-08-06  3241  			*new_fdp = NULL;
>>> 3f4b0acefd818e Al Viro           2024-08-06 @3242  			return PTR_ERR(new_fdp);
>>>                                                                                 ^^^^^^^^^^^^^^^^
>>> 	err = PTR_ERR(*new_fdp);
>>> 	*new_fdp = NULL;
>>> 	return err;
>>
>> Argh...  Obvious braino, but what it shows is that failures of that
>> thing are not covered by anything in e.g. LTP.  Or in-kernel
>> self-tests, for that matter...
> 
> FWIW, this does exercise that codepath, but I would really like to
> have kselftest folks to comment on the damn thing - I'm pretty sure
> that it's _not_ a good style for those.

Looks good to me. Would you be able to send a patch for this new test?

> 
> diff --git a/tools/testing/selftests/core/Makefile b/tools/testing/selftests/core/Makefile
> index ce262d097269..8e99f87f5d7c 100644
> --- a/tools/testing/selftests/core/Makefile
> +++ b/tools/testing/selftests/core/Makefile
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   CFLAGS += -g $(KHDR_INCLUDES)
>   
> -TEST_GEN_PROGS := close_range_test
> +TEST_GEN_PROGS := close_range_test unshare_test
>   
>   include ../lib.mk
>   
> diff --git a/tools/testing/selftests/core/unshare_test.c b/tools/testing/selftests/core/unshare_test.c
> new file mode 100644
> index 000000000000..7fec9dfb1b0e
> --- /dev/null
> +++ b/tools/testing/selftests/core/unshare_test.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <linux/kernel.h>
> +#include <limits.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <syscall.h>
> +#include <unistd.h>
> +#include <sys/resource.h>
> +#include <linux/close_range.h>
> +
> +#include "../kselftest_harness.h"
> +#include "../clone3/clone3_selftests.h"
> +
> +TEST(unshare_EMFILE)
> +{
> +	pid_t pid;
> +	int status;
> +	struct __clone_args args = {
> +		.flags = CLONE_FILES,
> +		.exit_signal = SIGCHLD,
> +	};
> +	int fd;
> +	ssize_t n, n2;
> +	static char buf[512], buf2[512];
> +	struct rlimit rlimit;
> +	int nr_open;
> +
> +	fd = open("/proc/sys/fs/nr_open", O_RDWR);
> +	ASSERT_GE(fd, 0);
> +
> +	n = read(fd, buf, sizeof(buf));
> +	ASSERT_GT(n, 0);
> +	ASSERT_EQ(buf[n - 1], '\n');
> +
> +	ASSERT_EQ(sscanf(buf, "%d", &nr_open), 1);
> +
> +	ASSERT_EQ(0, getrlimit(RLIMIT_NOFILE, &rlimit));
> +
> +	/* bump fs.nr_open */
> +	n2 = sprintf(buf2, "%d\n", nr_open + 1024);
> +	lseek(fd, 0, SEEK_SET);
> +	write(fd, buf2, n2);
> +
> +	/* bump ulimit -n */
> +	rlimit.rlim_cur = nr_open + 1024;
> +	rlimit.rlim_max = nr_open + 1024;
> +	EXPECT_EQ(0, setrlimit(RLIMIT_NOFILE, &rlimit)) {
> +		lseek(fd, 0, SEEK_SET);
> +		write(fd, buf, n);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	/* get a descriptor past the old fs.nr_open */
> +	EXPECT_GE(dup2(2, nr_open + 64), 0) {
> +		lseek(fd, 0, SEEK_SET);
> +		write(fd, buf, n);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	/* get descriptor table shared */
> +	pid = sys_clone3(&args, sizeof(args));
> +	EXPECT_GE(pid, 0) {
> +		lseek(fd, 0, SEEK_SET);
> +		write(fd, buf, n);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	if (pid == 0) {
> +		int err;
> +
> +		/* restore fs.nr_open */
> +		lseek(fd, 0, SEEK_SET);
> +		write(fd, buf, n);
> +		/* ... and now unshare(CLONE_FILES) must fail with EMFILE */
> +		err = unshare(CLONE_FILES);
> +		EXPECT_EQ(err, -1)
> +			exit(EXIT_FAILURE);
> +		EXPECT_EQ(errno, EMFILE)
> +			exit(EXIT_FAILURE);
> +		exit(EXIT_SUCCESS);
> +	}
> +
> +	EXPECT_EQ(waitpid(pid, &status, 0), pid);
> +	EXPECT_EQ(true, WIFEXITED(status));
> +	EXPECT_EQ(0, WEXITSTATUS(status));
> +}
> +
> +TEST_HARNESS_MAIN

thanks,
-- Shuah

