Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2870D342842
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 22:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhCSV5u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 17:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhCSV5r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 17:57:47 -0400
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8220CC061761
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 14:57:47 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4F2HnP27SzzMq6wY;
        Fri, 19 Mar 2021 22:57:45 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4F2HnM4X8tzlh8T5;
        Fri, 19 Mar 2021 22:57:43 +0100 (CET)
Subject: Re: [PATCH v30 10/12] selftests/landlock: Add user space tests
To:     Kees Cook <keescook@chromium.org>
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
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>
References: <20210316204252.427806-1-mic@digikod.net>
 <20210316204252.427806-11-mic@digikod.net> <202103191026.D936362B@keescook>
 <e98a1f48-4c35-139d-af88-b6e65fbb5c3f@digikod.net>
 <202103191207.E12FD4E51@keescook>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <1b043379-b6eb-d272-c9b9-25c6960e1ef1@digikod.net>
Date:   Fri, 19 Mar 2021 22:57:59 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <202103191207.E12FD4E51@keescook>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 19/03/2021 20:11, Kees Cook wrote:
> On Fri, Mar 19, 2021 at 07:41:00PM +0100, Mickaël Salaün wrote:
>>
>> On 19/03/2021 18:56, Kees Cook wrote:
>>> On Tue, Mar 16, 2021 at 09:42:50PM +0100, Mickaël Salaün wrote:
>>>> From: Mickaël Salaün <mic@linux.microsoft.com>
>>>>
>>>> Test all Landlock system calls, ptrace hooks semantic and filesystem
>>>> access-control with multiple layouts.
>>>>
>>>> Test coverage for security/landlock/ is 93.6% of lines.  The code not
>>>> covered only deals with internal kernel errors (e.g. memory allocation)
>>>> and race conditions.
>>>>
>>>> Cc: James Morris <jmorris@namei.org>
>>>> Cc: Jann Horn <jannh@google.com>
>>>> Cc: Kees Cook <keescook@chromium.org>
>>>> Cc: Serge E. Hallyn <serge@hallyn.com>
>>>> Cc: Shuah Khan <shuah@kernel.org>
>>>> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
>>>> Reviewed-by: Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>
>>>> Link: https://lore.kernel.org/r/20210316204252.427806-11-mic@digikod.net
>>>
>>> This is terrific. I love the coverage. How did you measure this, BTW?
>>
>> I used gcov: https://www.kernel.org/doc/html/latest/dev-tools/gcov.html
>>
>>> To increase it into memory allocation failures, have you tried
>>> allocation fault injection:
>>> https://www.kernel.org/doc/html/latest/fault-injection/fault-injection.html
>>
>> Yes, it is used by syzkaller, but I don't know how to extract this
>> specific coverage.
>>
>>>
>>>> [...]
>>>> +TEST(inconsistent_attr) {
>>>> +	const long page_size = sysconf(_SC_PAGESIZE);
>>>> +	char *const buf = malloc(page_size + 1);
>>>> +	struct landlock_ruleset_attr *const ruleset_attr = (void *)buf;
>>>> +
>>>> +	ASSERT_NE(NULL, buf);
>>>> +
>>>> +	/* Checks copy_from_user(). */
>>>> +	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr, 0, 0));
>>>> +	/* The size if less than sizeof(struct landlock_attr_enforce). */
>>>> +	ASSERT_EQ(EINVAL, errno);
>>>> +	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr, 1, 0));
>>>> +	ASSERT_EQ(EINVAL, errno);
>>>
>>> Almost everywhere you're using ASSERT instead of EXPECT. Is this correct
>>> (in the sense than as soon as an ASSERT fails the rest of the test is
>>> skipped)? I do see you using EXPECT is some places, but I figured I'd
>>> ask about the intention here.
>>
>> I intentionally use ASSERT as much as possible, but I use EXPECT when an
>> error could block a test or when it could stop a cleanup (i.e. teardown).
> 
> Okay. Does the test suite run sanely when landlock is missing from the
> kernel?

When Landlock is disabled, the tests fail but do not hang.

> 
>>>
>>>> +/*
>>>> + * TEST_F_FORK() is useful when a test drop privileges but the corresponding
>>>> + * FIXTURE_TEARDOWN() requires them (e.g. to remove files from a directory
>>>> + * where write actions are denied).  For convenience, FIXTURE_TEARDOWN() is
>>>> + * also called when the test failed, but not when FIXTURE_SETUP() failed.  For
>>>> + * this to be possible, we must not call abort() but instead exit smoothly
>>>> + * (hence the step print).
>>>> + */
>>>
>>> Hm, interesting. I think this should be extracted into a separate patch
>>> and added to the test harness proper.
>>
>> I agree, but it may require some modifications to fit nicely in
>> kselftest_harness.h . For now, it works well for my use case. I'll send
>> patches once Landlock is merged. In fact, I already made
>> kselftest_harness.h available for other users than seccomp. ;)
> 
> Fair points.
> 
>>>
>>> Could this be solved with TEARDOWN being called on SETUP failure?
>>
>> The goal of this helper is to still be able to call TEARDOWN when TEST
>> failed, not SETUP.
>>
>>>
>>>> +#define TEST_F_FORK(fixture_name, test_name) \
>>>> +	static void fixture_name##_##test_name##_child( \
>>>> +		struct __test_metadata *_metadata, \
>>>> +		FIXTURE_DATA(fixture_name) *self, \
>>>> +		const FIXTURE_VARIANT(fixture_name) *variant); \
>>>> +	TEST_F(fixture_name, test_name) \
>>>> +	{ \
>>>> +		int status; \
>>>> +		const pid_t child = fork(); \
>>>> +		if (child < 0) \
>>>> +			abort(); \
>>>> +		if (child == 0) { \
>>>> +			_metadata->no_print = 1; \
>>>> +			fixture_name##_##test_name##_child(_metadata, self, variant); \
>>>> +			if (_metadata->skip) \
>>>> +				_exit(255); \
>>>> +			if (_metadata->passed) \
>>>> +				_exit(0); \
>>>> +			_exit(_metadata->step); \
>>>> +		} \
>>>> +		if (child != waitpid(child, &status, 0)) \
>>>> +			abort(); \
>>>> +		if (WIFSIGNALED(status) || !WIFEXITED(status)) { \
>>>> +			_metadata->passed = 0; \
>>>> +			_metadata->step = 1; \
>>>> +			return; \
>>>> +		} \
>>>> +		switch (WEXITSTATUS(status)) { \
>>>> +		case 0: \
>>>> +			_metadata->passed = 1; \
>>>> +			break; \
>>>> +		case 255: \
>>>> +			_metadata->passed = 1; \
>>>> +			_metadata->skip = 1; \
>>>> +			break; \
>>>> +		default: \
>>>> +			_metadata->passed = 0; \
>>>> +			_metadata->step = WEXITSTATUS(status); \
>>>> +			break; \
>>>> +		} \
>>>> +	} \
>>>
>>> This looks like a subset of __wait_for_test()? Could __TEST_F_IMPL() be
>>> updated instead to do this? (Though the fork overhead might not be great
>>> for everyone.)
>>
>> Yes, it will probably be my approach to update kselftest_harness.h .
> 
> It seems like this would be named better as TEST_DROPS_PRIVS or something,
> which describes the reason for the fork.

Yeah, maybe, we could discuss about that in a dedicated patch series. :)
