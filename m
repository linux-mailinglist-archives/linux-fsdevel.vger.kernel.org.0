Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD41584F9C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jul 2022 13:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbiG2Lab (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jul 2022 07:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbiG2La3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jul 2022 07:30:29 -0400
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [IPv6:2001:1600:4:17::190a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EBA2CCBE
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Jul 2022 04:30:27 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4LvQL96TpjzMqvq2;
        Fri, 29 Jul 2022 13:30:25 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4LvQL92QcPzlqwsR;
        Fri, 29 Jul 2022 13:30:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1659094225;
        bh=6mgZ9R4TbL6/dB83+UPCkoky+fcr3XYpt6kJSlp1yoI=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=QPMri8kxBp6C4hptRc6y6IQbSRGIBf33QqnxRXe5G2ROjfBcQZXCcuH5uoLnEmlsL
         0/tY1namWUgdDufKSpBNJ52nhK/W1vhLXxVEZHHorfDeP7Pk2v2U/G3UUjaA7Xk3XL
         7XxZU3jDeqlxmKkm5OrFk8utv6k6cRTN80EiwJKw=
Message-ID: <c8964ea0-df91-da78-89c6-85fb02a6a3bc@digikod.net>
Date:   Fri, 29 Jul 2022 13:30:24 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
References: <20220707200612.132705-1-gnoack3000@gmail.com>
 <20220707200612.132705-3-gnoack3000@gmail.com>
 <f93e7b0f-8782-248f-df9a-4670ede67dae@digikod.net> <YsxPgm30TUOxJbzS@nuc>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH 2/2] landlock: Selftests for truncate(2) support.
In-Reply-To: <YsxPgm30TUOxJbzS@nuc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 11/07/2022 18:27, Günther Noack wrote:
> On Fri, Jul 08, 2022 at 01:17:46PM +0200, Mickaël Salaün wrote:

[...]

>>
>>> +		{
>>> +			.path = file1_s1d1,
>>> +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
>>> +				  LANDLOCK_ACCESS_FS_WRITE_FILE |
>>> +				  LANDLOCK_ACCESS_FS_TRUNCATE,
>>> +		},
>>> +		{
>>> +			.path = file2_s1d2,
>>> +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
>>> +				  LANDLOCK_ACCESS_FS_WRITE_FILE,
>>> +		},
>>> +		{
>>> +			.path = file1_s1d2,
>>> +			.access = LANDLOCK_ACCESS_FS_TRUNCATE,
>>> +		},
>>
>> Move this entry before file2_s1d2 to keep the paths sorted and make this
>> easier to read. You can change the access rights per path to also keep their
>> ordering though.
> 
> I've admittedly found it difficult to remember which of these files
> and subdirectories exist and how they are named and mixed up the names
> at least twice when developing these tests. To make it easier, I've now
> renamed these by including this at the top of the test:
> 
> char *file_rwt = file1_s1d1;
> char *file_rw = file2_s1s1;
> // etc
> 
> With the test using names like file_rwt, I find that easier to work
> with and found myself jumping less between the "rules" on top and the
> place where the assertions are written out.
> 
> This is admittedly a bit out of line with the other tests, but maybe
> it's worth doing? Let me know what you think.

It indeed makes things clearer.


> 
>>
>>
>>> +		{
>>> +			.path = dir_s2d3,
>>> +			.access = LANDLOCK_ACCESS_FS_TRUNCATE,
>>> +		},
>>> +		// Implicitly: No access rights for file2_s1d1.
>>
>> Comment to move after the use of file1_s1d1.
> 
> I'm understanding this as "keep the files in order according to the
> layout". I've reshuffled things a bit by renaming them, but this is
> also in the right order now.

Right.

[...]

>>> +	reg_fd = open(file1_s1d1, O_RDWR | O_CLOEXEC);
>>> +	ASSERT_LE(0, reg_fd);
>>> +	EXPECT_EQ(0, ftruncate(reg_fd, 10));
>>
>> You should not use EXPECT but ASSERT here. I use EXPECT when an error could
>> block a test or when it could stop a cleanup (i.e. teardown).
> 
> ASSERT is the variant that stops the test immediately, whereas EXPECT
> notes down the test failure and continues execution.
> 
> So in that spirit, I tried to use:
> 
>   * ASSERT for successful open() calls where the FD is still needed later
>   * ASSERT for close() (for symmetry with open())
>   * EXPECT for expected-failing open() calls where the FD is not used later
>   * EXPECT for everything else

I understand your logic, but this gymnastic adds complexity to writing 
tests (which might be difficult to explain) for not much gain. Indeed, 
all these tests should pass, except if we add a SKIP (cf. 
https://lore.kernel.org/all/20220628222941.2642917-1-jeffxu@google.com/).

In the case of an open FD, it will not be an issue to not close it if a 
test failed, which is not the same with FIXTURE_TEARDOWN where we want 
the workspace to be clean after tests, whether they succeeded or failed.


> 
> I had another pass over the tests and have started to use EXPECT for a
> few expected-failing open() calls.
> 
> The selftest framework seems inspired by the Googletest framework
> (https://google.github.io/googletest/primer.html#assertions) where
> this is described as: "Usually EXPECT_* are preferred, as they allow
> more than one failure to be reported in a test. However, you should
> use ASSERT_* if it doesn’t make sense to continue when the assertion
> in question fails."

I think this is good in theory, but in practice, at least for the 
Landlock selftests, everything should pass. Any test failure is a 
blocker because it breaks the contract with users.

I find it very difficult to write tests that would check as much as 
possible, even if some of these tests failed, without unexpected 
behaviors (e.g. blocking the whole tests, writing to unexpected 
locations…) because it changes the previous state from a known state to 
a set of potential states (e.g. when creating or removing files). Doing 
it generically increases complexity for tests which may already be 
difficult to understand. When investigating a test failure, we can still 
replace some ASSERT with EXPECT though.


> 
> I imagined that the same advice would apply to the kernel selftests?
> Please let me know if I'm overlooking subtle differences here.

I made kselftest_harness.h generally available (outside of seccomp) but 
I guess each subsystem maintainer might handle that differently.

See 
https://lore.kernel.org/all/1b043379-b6eb-d272-c9b9-25c6960e1ef1@digikod.net/ 
for similar concerns.
