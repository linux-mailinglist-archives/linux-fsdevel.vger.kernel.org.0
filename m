Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE1C3423D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 18:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhCSR5F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 13:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhCSR4e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:56:34 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B316EC061762
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 10:56:34 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id u19so4199386pgh.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 10:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+q/3pbtU4KRBeCiClf1jVde3rqJff5tAE3G/yUO/twY=;
        b=Px46bBJ7mvrljx8ek9g5SOvd1jKb2iflgcqeVZiVe5xUV+ssBoFXrkhepVOQKvAu0W
         wc544ZAyTrYKxp4eU7wneG31VhgV2pG4OO8vR/OUGy+eT4tlva1ClajEyl5BGBpqNmzG
         hunNRfv4R9KjhPsKcrcyZbynh9VC1EqLCPhJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+q/3pbtU4KRBeCiClf1jVde3rqJff5tAE3G/yUO/twY=;
        b=YxeG1oq0I3mL/WM9QF7SWn7wSN31LCjqdGsaBXbJcbK0fv2P0tcBr2T+KEYfwth6Yt
         vRm8UrW086xwxEYQxpQaJIFbWZxPTEMuCaya4+ec0H3Zk1z+vi9pCcLZYEIIidx0FmZt
         F9U/xTq+9lyZ0FAkIfQEcJm5U70fN6ZF2ey2DCRLFO1eAzEebp7T07LaXXhCzivnstGL
         6x5QuxO0hMdAAj3Rv8tf9kVxcSbUbrPK/I7K2MK/ux0rAgPMpgBEpxuerQ756KfLEzJ5
         dfcrUYjsjFoOke/RHjm64J9r/v+kefDtFtfiysr6JtmgBQG0CVc+vDxC0RtzI5Qc2QtK
         gsBg==
X-Gm-Message-State: AOAM530Rnhff6zr73xvBmLkxpYrljaRf07ooMxfi2zPbwRgvpEYlNJ5p
        QCgXowhdaZh76j9L+XeTtVEtRA==
X-Google-Smtp-Source: ABdhPJx6hzgtsuXfb3wb8ZxJRkArVpobtGIGuejpGbWx0f2z95FZcMrh5SMDfiqjnPliwFHzGPG83w==
X-Received: by 2002:aa7:8493:0:b029:1ee:75b2:2865 with SMTP id u19-20020aa784930000b02901ee75b22865mr10002946pfn.61.1616176594196;
        Fri, 19 Mar 2021 10:56:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t1sm6114696pfc.173.2021.03.19.10.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 10:56:33 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:56:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v30 10/12] selftests/landlock: Add user space tests
Message-ID: <202103191026.D936362B@keescook>
References: <20210316204252.427806-1-mic@digikod.net>
 <20210316204252.427806-11-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210316204252.427806-11-mic@digikod.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 16, 2021 at 09:42:50PM +0100, Mickaël Salaün wrote:
> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> Test all Landlock system calls, ptrace hooks semantic and filesystem
> access-control with multiple layouts.
> 
> Test coverage for security/landlock/ is 93.6% of lines.  The code not
> covered only deals with internal kernel errors (e.g. memory allocation)
> and race conditions.
> 
> Cc: James Morris <jmorris@namei.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> Reviewed-by: Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>
> Link: https://lore.kernel.org/r/20210316204252.427806-11-mic@digikod.net

This is terrific. I love the coverage. How did you measure this, BTW?
To increase it into memory allocation failures, have you tried
allocation fault injection:
https://www.kernel.org/doc/html/latest/fault-injection/fault-injection.html

> [...]
> +TEST(inconsistent_attr) {
> +	const long page_size = sysconf(_SC_PAGESIZE);
> +	char *const buf = malloc(page_size + 1);
> +	struct landlock_ruleset_attr *const ruleset_attr = (void *)buf;
> +
> +	ASSERT_NE(NULL, buf);
> +
> +	/* Checks copy_from_user(). */
> +	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr, 0, 0));
> +	/* The size if less than sizeof(struct landlock_attr_enforce). */
> +	ASSERT_EQ(EINVAL, errno);
> +	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr, 1, 0));
> +	ASSERT_EQ(EINVAL, errno);

Almost everywhere you're using ASSERT instead of EXPECT. Is this correct
(in the sense than as soon as an ASSERT fails the rest of the test is
skipped)? I do see you using EXPECT is some places, but I figured I'd
ask about the intention here.

> +/*
> + * TEST_F_FORK() is useful when a test drop privileges but the corresponding
> + * FIXTURE_TEARDOWN() requires them (e.g. to remove files from a directory
> + * where write actions are denied).  For convenience, FIXTURE_TEARDOWN() is
> + * also called when the test failed, but not when FIXTURE_SETUP() failed.  For
> + * this to be possible, we must not call abort() but instead exit smoothly
> + * (hence the step print).
> + */

Hm, interesting. I think this should be extracted into a separate patch
and added to the test harness proper.

Could this be solved with TEARDOWN being called on SETUP failure?

> +#define TEST_F_FORK(fixture_name, test_name) \
> +	static void fixture_name##_##test_name##_child( \
> +		struct __test_metadata *_metadata, \
> +		FIXTURE_DATA(fixture_name) *self, \
> +		const FIXTURE_VARIANT(fixture_name) *variant); \
> +	TEST_F(fixture_name, test_name) \
> +	{ \
> +		int status; \
> +		const pid_t child = fork(); \
> +		if (child < 0) \
> +			abort(); \
> +		if (child == 0) { \
> +			_metadata->no_print = 1; \
> +			fixture_name##_##test_name##_child(_metadata, self, variant); \
> +			if (_metadata->skip) \
> +				_exit(255); \
> +			if (_metadata->passed) \
> +				_exit(0); \
> +			_exit(_metadata->step); \
> +		} \
> +		if (child != waitpid(child, &status, 0)) \
> +			abort(); \
> +		if (WIFSIGNALED(status) || !WIFEXITED(status)) { \
> +			_metadata->passed = 0; \
> +			_metadata->step = 1; \
> +			return; \
> +		} \
> +		switch (WEXITSTATUS(status)) { \
> +		case 0: \
> +			_metadata->passed = 1; \
> +			break; \
> +		case 255: \
> +			_metadata->passed = 1; \
> +			_metadata->skip = 1; \
> +			break; \
> +		default: \
> +			_metadata->passed = 0; \
> +			_metadata->step = WEXITSTATUS(status); \
> +			break; \
> +		} \
> +	} \

This looks like a subset of __wait_for_test()? Could __TEST_F_IMPL() be
updated instead to do this? (Though the fork overhead might not be great
for everyone.)

-- 
Kees Cook
