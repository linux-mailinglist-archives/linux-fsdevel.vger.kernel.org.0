Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA935E846E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 22:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiIWUzI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 16:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbiIWUzB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 16:55:01 -0400
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669F050524
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Sep 2022 13:54:58 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MZ4Ch60ZMzMqpZ1;
        Fri, 23 Sep 2022 22:54:56 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4MZ4Cg5q7MzMpqBP;
        Fri, 23 Sep 2022 22:54:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1663966496;
        bh=lIgDO8/tqI86dlPLEX5uql/AhNN7ffMK8T3OeVzote0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bNg0zdsTCW+chaxy8cGseP3vC0TuBq7nUO0crzcZqfurAVQzgxV2mkuvQo/IhZovA
         bT5Sw+QLEydWkeQ7l3Uuirs2ShRXMUs6y/whqGz1au+7m0iv4GKjnm9J/bzra/K/X8
         mXPjFxye9/vn7KZJllFZAJXsuuFdfBiqxkUK1on0=
Message-ID: <5233611f-1dba-3ecb-670f-fff61820e9d6@digikod.net>
Date:   Fri, 23 Sep 2022 22:54:55 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v6 3/5] selftests/landlock: Selftests for file truncation
 support
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
References: <20220908195805.128252-1-gnoack3000@gmail.com>
 <20220908195805.128252-4-gnoack3000@gmail.com>
 <3f3b7798-c3e1-e257-5094-0033e7605062@digikod.net> <Yy3x3b3+CrD/rb0J@nuc>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <Yy3x3b3+CrD/rb0J@nuc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 23/09/2022 19:50, Günther Noack wrote:
> On Fri, Sep 16, 2022 at 07:05:44PM +0200, Mickaël Salaün wrote:
>> I'd like to have tests similar to base_test.c:ruleset_fd_transfer to check
>> ftruncate with different kind of file descriptors and not-sandboxed
>> processes. That would require some code refactoring to reuse the FD passing
>> code.
> 
> Done. I factored out the FD sending and receiving into helper function in common.h.

Please use a dedicated patch for this refactoring.

> 
>> On 08/09/2022 21:58, Günther Noack wrote:
>>> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
>>> index 87b28d14a1aa..ddc8c7e57e86 100644
>>> --- a/tools/testing/selftests/landlock/fs_test.c
>>> +++ b/tools/testing/selftests/landlock/fs_test.c
>>> ...
>>> +TEST_F_FORK(layout1, truncate)
>>> +{
>>> +	const char *const file_rwt = file1_s1d1;
>>> +	const char *const file_rw = file2_s1d1;
>>> +	const char *const file_rt = file1_s1d2;
>>> +	const char *const file_t = file2_s1d2;
>>> +	const char *const file_none = file1_s1d3;
>>> +	const char *const dir_t = dir_s2d1;
>>> +	const char *const file_in_dir_t = file1_s2d1;
>>> +	const char *const dir_w = dir_s3d1;
>>> +	const char *const file_in_dir_w = file1_s3d1;
>>> +	int file_rwt_fd, file_rw_fd;
>>
>> These variables are unused now.
> 
> Good catch, done.
> 
>>> +TEST_F_FORK(layout1, ftruncate)
>>
>> Great!
>>
>>> +{
>>> +	/*
>>> +	 * This test opens a new file descriptor at different stages of
>>> +	 * Landlock restriction:
>>> +	 *
>>> +	 * without restriction:                    ftruncate works
>>> +	 * something else but truncate restricted: ftruncate works
>>> +	 * truncate restricted and permitted:      ftruncate works
>>> +	 * truncate restricted and not permitted:  ftruncate fails
>>> +	 *
>>> +	 * Whether this works or not is expected to depend on the time when the
>>> +	 * FD was opened, not to depend on the time when ftruncate() was
>>> +	 * called.
>>> +	 */
>>> +	const char *const path = file1_s1d1;
>>> +	int fd0, fd1, fd2, fd3;
>>
>> You can rename them fd_layer0, fd_layer1…
> 
> Done.
> 
>>> +	fd0 = open(path, O_WRONLY);
>>> +	EXPECT_EQ(0, test_ftruncate(fd0));
>>> +
>>> +	landlock_single_path(_metadata, path,
>>> +			     LANDLOCK_ACCESS_FS_READ_FILE |
>>> +				     LANDLOCK_ACCESS_FS_WRITE_FILE,
>>> +			     LANDLOCK_ACCESS_FS_WRITE_FILE);
>>
>> I'd prefer to follow the current way to write rule layers: write all struct
>> rule at first and then call each enforcement steps. It is a bit more verbose
>> but easier to understand errors. The list of test_ftruncate checks are
>> straightforward to follow.
> 
> Done.
> 
> 
>>> +	fd1 = open(path, O_WRONLY);
>>> +	EXPECT_EQ(0, test_ftruncate(fd0));
>>> +	EXPECT_EQ(0, test_ftruncate(fd1));
>>> +
>>> +	landlock_single_path(_metadata, path, LANDLOCK_ACCESS_FS_TRUNCATE,
>>> +			     LANDLOCK_ACCESS_FS_TRUNCATE);
>>> +
>>> +	fd2 = open(path, O_WRONLY);
>>> +	EXPECT_EQ(0, test_ftruncate(fd0));
>>> +	EXPECT_EQ(0, test_ftruncate(fd1));
>>> +	EXPECT_EQ(0, test_ftruncate(fd2));
>>> +
>>> +	landlock_single_path(_metadata, path,
>>> +			     LANDLOCK_ACCESS_FS_TRUNCATE |
>>> +				     LANDLOCK_ACCESS_FS_WRITE_FILE,
>>> +			     LANDLOCK_ACCESS_FS_WRITE_FILE);
>>> +
>>> +	fd3 = open(path, O_WRONLY);
>>> +	EXPECT_EQ(0, test_ftruncate(fd0));
>>> +	EXPECT_EQ(0, test_ftruncate(fd1));
>>> +	EXPECT_EQ(0, test_ftruncate(fd2));
>>> +	EXPECT_EQ(EACCES, test_ftruncate(fd3));
>>> +
>>> +	ASSERT_EQ(0, close(fd0));
>>> +	ASSERT_EQ(0, close(fd1));
>>> +	ASSERT_EQ(0, close(fd2));
>>> +	ASSERT_EQ(0, close(fd3));
>>> +}
>>> +
>>>    /* clang-format off */
>>>    FIXTURE(layout1_bind) {};
>>>    /* clang-format on */
> 
