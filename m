Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5686856B87D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 13:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbiGHL1K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 07:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237828AbiGHL1J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:27:09 -0400
X-Greylist: delayed 556 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Jul 2022 04:27:07 PDT
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [IPv6:2001:1600:3:17::42ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F1E904DB
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jul 2022 04:27:07 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4LfW3H4qgzzMqHdR;
        Fri,  8 Jul 2022 13:17:47 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4LfW3H2Mrvzlnbvj;
        Fri,  8 Jul 2022 13:17:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1657279067;
        bh=7dqdAxJ7RvF3bGI2QXjZLiSa9HnLDOMhdwRre/1wwEc=;
        h=Date:To:References:From:Cc:Subject:In-Reply-To:From;
        b=ZsTXSLLEVYqq3QPou1QVcFXUt37puJiCQSdX2uf66U+mvKLAfWsoDWoLdausCB6gf
         HHouCkF1Ew8U55ocyPznDAsG7+QlEDZDr5nnbLZwQbflv8VEXzFPALUbf5tMfSmPMJ
         Z8jEEYohr5Zoca1qg2sICs0pVuIdwCZGYzsb7i78=
Message-ID: <f93e7b0f-8782-248f-df9a-4670ede67dae@digikod.net>
Date:   Fri, 8 Jul 2022 13:17:46 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
References: <20220707200612.132705-1-gnoack3000@gmail.com>
 <20220707200612.132705-3-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Cc:     linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH 2/2] landlock: Selftests for truncate(2) support.
In-Reply-To: <20220707200612.132705-3-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Please use "selftests/landlock:" as subject prefix and without a final dot.


On 07/07/2022 22:06, Günther Noack wrote:
> These tests exercise the following scenarios:
> 
> * File with Read, Write, Truncate rights.

Should we use a capital for access right names or does it come from Go? ;)


> * File with Read, Write rights.
> * File with Truncate rights.
> * File with no rights.
> * Directory with Truncate rights.
> 
> For each of the scenarios, both truncate() and the open() +
> ftruncate() syscalls get exercised and their results checked.
> 
> In particular, the test demonstrates that opening a file for writing
> is not enough to call truncate().

Looks good! According to my previous comment, O_TRUNC should be tested 
if it is checked by the kernel.


> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>   tools/testing/selftests/landlock/fs_test.c | 80 ++++++++++++++++++++++
>   1 file changed, 80 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index cb77eaa01c91..c3e48fd12b2b 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -2237,6 +2237,86 @@ TEST_F_FORK(layout1, reparent_rename)
>   	ASSERT_EQ(EXDEV, errno);
>   }
>   
> +TEST_F_FORK(layout1, truncate)

Please move this test after the proc_pipe one.


> +{
> +	const struct rule rules[] = {

You can add a first layer of rules to check truncate and ftruncate with 
a ruleset not handling LANDLOCK_ACCESS_FS_TRUNCATE.


> +		{
> +			.path = file1_s1d1,
> +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
> +				  LANDLOCK_ACCESS_FS_WRITE_FILE |
> +				  LANDLOCK_ACCESS_FS_TRUNCATE,
> +		},
> +		{
> +			.path = file2_s1d2,
> +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
> +				  LANDLOCK_ACCESS_FS_WRITE_FILE,
> +		},
> +		{
> +			.path = file1_s1d2,
> +			.access = LANDLOCK_ACCESS_FS_TRUNCATE,
> +		},

Move this entry before file2_s1d2 to keep the paths sorted and make this 
easier to read. You can change the access rights per path to also keep 
their ordering though.


> +		{
> +			.path = dir_s2d3,
> +			.access = LANDLOCK_ACCESS_FS_TRUNCATE,
> +		},
> +		// Implicitly: No access rights for file2_s1d1.

Comment to move after the use of file1_s1d1.

> +		{},
> +	};
> +	const int ruleset_fd = create_ruleset(_metadata, ACCESS_ALL, rules);

Don't use ACCESS_ALL because it will change over time and we want tests 
to be deterministic. You can use rules[0].access instead.


> +	int reg_fd;
> +
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	/* Read, write and truncate permissions => truncate and ftruncate work. */

It would be nice to have consistent comments such as: "Checks read, 
write and truncate access rights: truncate and ftruncate work."


> +	reg_fd = open(file1_s1d1, O_RDWR | O_CLOEXEC);
> +	ASSERT_LE(0, reg_fd);
> +	EXPECT_EQ(0, ftruncate(reg_fd, 10));

You should not use EXPECT but ASSERT here. I use EXPECT when an error 
could block a test or when it could stop a cleanup (i.e. teardown).


> +	EXPECT_EQ(0, ftruncate64(reg_fd, 20));
> +	ASSERT_EQ(0, close(reg_fd));
> +
> +	EXPECT_EQ(0, truncate(file1_s1d1, 10));
> +	EXPECT_EQ(0, truncate64(file1_s1d1, 20));
> +
> +	/* Just read and write permissions => no truncate variant works. */
> +	reg_fd = open(file2_s1d2, O_RDWR | O_CLOEXEC);
> +	ASSERT_LE(0, reg_fd);
> +	EXPECT_EQ(-1, ftruncate(reg_fd, 10));
> +	EXPECT_EQ(EACCES, errno);
> +	EXPECT_EQ(-1, ftruncate64(reg_fd, 20));
> +	EXPECT_EQ(EACCES, errno);
> +	ASSERT_EQ(0, close(reg_fd));
> +
> +	EXPECT_EQ(-1, truncate(file2_s1d2, 10));
> +	EXPECT_EQ(EACCES, errno);
> +	EXPECT_EQ(-1, truncate64(file2_s1d2, 20));
> +	EXPECT_EQ(EACCES, errno);
> +
> +	/* Just truncate permissions => truncate(64) works, but can't open file. */
> +	ASSERT_EQ(-1, open(file1_s1d2, O_RDWR | O_CLOEXEC));
> +	ASSERT_EQ(EACCES, errno);
> +
> +	EXPECT_EQ(0, truncate(file1_s1d2, 10));
> +	EXPECT_EQ(0, truncate64(file1_s1d2, 20));
> +
> +	/* Just truncate permission on directory => truncate(64) works, but can't open file. */
> +	ASSERT_EQ(-1, open(file1_s2d3, O_RDWR | O_CLOEXEC));
> +	ASSERT_EQ(EACCES, errno);
> +
> +	EXPECT_EQ(0, truncate(file1_s2d3, 10));
> +	EXPECT_EQ(0, truncate64(file1_s2d3, 20));
> +
> +	/* No permissions => Neither truncate nor ftruncate work. */
> +	ASSERT_EQ(-1, open(file2_s1d1, O_RDWR | O_CLOEXEC));
> +	ASSERT_EQ(EACCES, errno);
> +
> +	EXPECT_EQ(-1, truncate(file2_s1d1, 10));
> +	EXPECT_EQ(EACCES, errno);
> +	EXPECT_EQ(-1, truncate64(file2_s1d1, 20));
> +	EXPECT_EQ(EACCES, errno);

These tests are good!

> +}
> +
>   static void
>   reparent_exdev_layers_enforce1(struct __test_metadata *const _metadata)
>   {
