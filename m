Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6986427A50
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Oct 2021 14:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhJIMyF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Oct 2021 08:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhJIMyE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Oct 2021 08:54:04 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E786CC061570;
        Sat,  9 Oct 2021 05:52:07 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id d9so22944791edh.5;
        Sat, 09 Oct 2021 05:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=975/0lKre2jbukZyrsOHoZ3KIJn08g0A4cVpQ8XD8kI=;
        b=hVcr+o1302lP3dfkILDlV1SWMYeqJQl7pYfgbS3boQXLZweylwSzlGJGLLJwQNk8Kh
         CwL7ZYgMcu859cwij3WRju+M/6IBw1l5qVyv2sqs6vEeLyQuIkqRBOLAvpHG2flk3GUu
         tn0JJzxP25bxoKIzhRhoiWy9CUZiPDduVKRLOFHRfOkYUOyLurBQIqcI3eVAOA/JbRy2
         URi2wY4/k/7uTuVYTbc7wFkTe2AuqPP9pdDjOKvn430JKAXbvj/JUkCfUmvxV47WBwOb
         Mj3LP/fA8TkfpmWrugYinFcFGixuwTX3+KlDePQpccjqsQkgWcVl0e5M7KhxZopGYHU0
         f0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=975/0lKre2jbukZyrsOHoZ3KIJn08g0A4cVpQ8XD8kI=;
        b=58bRgh0YaApsf9ucmbdBUrwwnu1g2tFopow5ehNT7NW94QMrRzcmLItk2H/kFz3+mY
         XwF2sELqV8jQ1CXDwarwvo4La6X5Eujv9cCj9tAtqskh+bmyKYtKHgYdBoKWGSKRR8FH
         NTGZ78bUZ03A0lOfOGEui5NGDLWavOV0HNzQwqzHsc47Cqe43Bkmoyfs7a69XU0azDtY
         ZH6w+0Lk7CrjSJCksaEtw1sM3DSKNNcLt1/Jr2UoncN2VlC09vPYUGZa8xfqIRG3INHq
         mOYw5ZdlytbhIh9FNlt6eTGLY8/LVRL1sQPgNAVsj0qHMJnAhsFVUWxnKpPfeKnTh23/
         q/lw==
X-Gm-Message-State: AOAM532aokajDtWcxh8tk8E55SWI3Lws098OzbiEPI8hEr58pY9114MT
        RfIC26JzHIZE6YUjsIiGiQ==
X-Google-Smtp-Source: ABdhPJwyfUp4OaPU6ugKRCPVVsevXJUZSC5gxhhEWZth3zrYETY0kH108F0bm4pu2qMTrK4qsPlwXg==
X-Received: by 2002:a17:906:7848:: with SMTP id p8mr11404695ejm.212.1633783926493;
        Sat, 09 Oct 2021 05:52:06 -0700 (PDT)
Received: from localhost.localdomain ([46.53.249.82])
        by smtp.gmail.com with ESMTPSA id l23sm967292ejn.15.2021.10.09.05.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 05:52:06 -0700 (PDT)
Date:   Sat, 9 Oct 2021 15:52:02 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>, jannh@google.com,
        vcaputo@pengaru.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, christian.brauner@ubuntu.com,
        amistry@google.com, Kenta.Tada@sony.com, legion@kernel.org,
        michael.weiss@aisec.fraunhofer.de, mhocko@suse.com, deller@gmx.de,
        zhengqi.arch@bytedance.com, me@tobin.cc, tycho@tycho.pizza,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, axboe@kernel.dk,
        metze@samba.org, laijs@linux.alibaba.com, luto@kernel.org,
        dave.hansen@linux.intel.com, ebiederm@xmission.com,
        ohoono.kwon@samsung.com, kaleshsingh@google.com,
        yifeifz2@illinois.edu, linux-arch@vger.kernel.org,
        vgupta@kernel.org, linux@armlinux.org.uk, will@kernel.org,
        guoren@kernel.org, bcain@codeaurora.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        jonas@southpole.se, mpe@ellerman.id.au, paul.walmsley@sifive.com,
        hca@linux.ibm.com, ysato@users.sourceforge.jp, davem@davemloft.net,
        chris@zankel.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] selftests: proc: Make sure wchan works when it exists
Message-ID: <YWGQckkJuKB4yAfg@localhost.localdomain>
References: <20211008235504.2957528-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211008235504.2957528-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 08, 2021 at 04:55:04PM -0700, Kees Cook wrote:
> This makes sure that wchan contains a sensible symbol when a process is
> blocked.

> Specifically this calls the sleep() syscall, and expects the
> architecture to have called schedule() from a function that has "sleep"
> somewhere in its name.

This exposes internal kernel symbol to userspace.
Why would want to test that?

Doing s/sleep/SLEEP/g doesn't change kernel but now the test is broken.

> For example, on the architectures I tested
> (x86_64, arm64, arm, mips, and powerpc) this is "hrtimer_nanosleep":

> +/*
> + * Make sure that wchan returns a reasonable symbol when blocked.
> + */

Test should be "contains C identifier" then?

> +int main(void)
> +{
> +	char buf[64];
> +	pid_t child;
> +	int sync[2], fd;
> +
> +	if (pipe(sync) < 0)
> +		perror_exit("pipe");
> +
> +	child = fork();
> +	if (child < 0)
> +		perror_exit("fork");
> +	if (child == 0) {
> +		/* Child */
> +		if (close(sync[0]) < 0)
> +			perror_exit("child close sync[0]");
> +		if (close(sync[1]) < 0)
> +			perror_exit("child close sync[1]");

Redundant close().

> +		sleep(10);
> +		_exit(0);
> +	}
> +	/* Parent */
> +	if (close(sync[1]) < 0)
> +		perror_exit("parent close sync[1]");

Redundant close().

> +	if (read(sync[0], buf, 1) != 0)
> +		perror_exit("parent read sync[0]");

Racy if child is scheduled out after first close in the child.

> +	snprintf(buf, sizeof(buf), "/proc/%d/wchan", child);
> +	fd = open(buf, O_RDONLY);
> +	if (fd < 0) {
> +		if (errno == ENOENT)
> +			return 4;
> +		perror_exit(buf);
> +	}
> +
> +	memset(buf, 0, sizeof(buf));
> +	if (read(fd, buf, sizeof(buf) - 1) < 1)
> +		perror_exit(buf);
> +	if (strstr(buf, "sleep") == NULL) {
> +		fprintf(stderr, "FAIL: did not find 'sleep' in wchan '%s'\n", buf);
> +		return 1;
> +	}
> +	printf("ok: found 'sleep' in wchan '%s'\n", buf);
> +
> +	if (kill(child, SIGKILL) < 0)
> +		perror_exit("kill");
> +	if (waitpid(child, NULL, 0) != child) {
> +		fprintf(stderr, "waitpid: got the wrong child!?\n");
> +		return 1;
> +	}
> +
> +	return 0;
> +}
