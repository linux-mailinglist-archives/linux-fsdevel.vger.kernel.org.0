Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4195F5A34
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Oct 2022 20:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiJES4U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Oct 2022 14:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiJES4S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:56:18 -0400
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911187FE43
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Oct 2022 11:56:17 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MjP1C6cVqzMpnYL;
        Wed,  5 Oct 2022 20:56:15 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MjP1C2zZvz3Y;
        Wed,  5 Oct 2022 20:56:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1664996175;
        bh=d1ruAk1Gz1JvcH1m4HSD0oTzB+5X03OXcIpYDYogU+A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QF0u4BE6hB7pjU+8hw0T3t1iTSf7s1n6Ed53fq/pv0gA/dRg1tGzVtb8/Ozx12JK3
         nX6oyUkIY8oGsw7qtnmu03Gsdi4EKbII8/YFnzQiNmDDU1YN3O5UMau1aInLiunL0u
         i1dv5AfsQ3F0z+gLMMJADVmi1DIViMw29KwMLB/8=
Message-ID: <e8e0ad8b-c501-64ce-a523-409d60bb05e4@digikod.net>
Date:   Wed, 5 Oct 2022 20:56:14 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v8 6/9] selftests/landlock: Test open() and ftruncate() in
 multiple scenarios
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
References: <20221001154908.49665-1-gnoack3000@gmail.com>
 <20221001154908.49665-7-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20221001154908.49665-7-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Clean test cases and complete coverage, great!

On 01/10/2022 17:49, Günther Noack wrote:
> This test uses multiple fixture variants to exercise a broader set of
> scnenarios.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>   tools/testing/selftests/landlock/fs_test.c | 96 ++++++++++++++++++++++
>   1 file changed, 96 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 718543fd3dfc..308f6f36e8c0 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -3445,6 +3445,102 @@ TEST_F_FORK(layout1, ftruncate)
>   	ASSERT_EQ(0, close(fd_layer3));
>   }
>   
> +/* clang-format off */
> +FIXTURE(ftruncate) {};
> +/* clang-format on */
> +
> +FIXTURE_SETUP(ftruncate)
> +{
> +	prepare_layout(_metadata);
> +	create_file(_metadata, file1_s1d1);
> +}
> +
> +FIXTURE_TEARDOWN(ftruncate)
> +{
> +	EXPECT_EQ(0, remove_path(file1_s1d1));
> +	cleanup_layout(_metadata);
> +}
> +
> +FIXTURE_VARIANT(ftruncate)
> +{
> +	const __u64 handled;
> +	const __u64 permitted;
> +	const int expected_open_result;
> +	const int expected_ftruncate_result;
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(ftruncate, w_w) {
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_WRITE_FILE,
> +	.permitted = LANDLOCK_ACCESS_FS_WRITE_FILE,
> +	.expected_open_result = 0,
> +	.expected_ftruncate_result = 0,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(ftruncate, t_t) {
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_TRUNCATE,
> +	.permitted = LANDLOCK_ACCESS_FS_TRUNCATE,
> +	.expected_open_result = 0,
> +	.expected_ftruncate_result = 0,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(ftruncate, wt_w) {
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_TRUNCATE,
> +	.permitted = LANDLOCK_ACCESS_FS_WRITE_FILE,
> +	.expected_open_result = 0,
> +	.expected_ftruncate_result = EACCES,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(ftruncate, wt_wt) {
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_TRUNCATE,
> +	.permitted = LANDLOCK_ACCESS_FS_WRITE_FILE |
> +		     LANDLOCK_ACCESS_FS_TRUNCATE,
> +	.expected_open_result = 0,
> +	.expected_ftruncate_result = 0,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(ftruncate, wt_t) {
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_TRUNCATE,
> +	.permitted = LANDLOCK_ACCESS_FS_TRUNCATE,
> +	.expected_open_result = EACCES,
> +};
> +
> +TEST_F_FORK(ftruncate, open_and_ftruncate)
> +{
> +	const char *const path = file1_s1d1;
> +	const struct rule rules[] = {
> +		{
> +			.path = path,
> +			.access = variant->permitted,
> +		},
> +		{},
> +	};
> +	int fd, ruleset_fd;
> +
> +	/* Enable Landlock. */
> +	ruleset_fd = create_ruleset(_metadata, variant->handled, rules);
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	fd = open(path, O_WRONLY);
> +	EXPECT_EQ(variant->expected_open_result, (fd < 0 ? errno : 0));
> +	if (fd >= 0) {
> +		EXPECT_EQ(variant->expected_ftruncate_result,
> +			  test_ftruncate(fd));
> +		ASSERT_EQ(0, close(fd));
> +	}
> +}
> +
>   /* clang-format off */
>   FIXTURE(layout1_bind) {};
>   /* clang-format on */
