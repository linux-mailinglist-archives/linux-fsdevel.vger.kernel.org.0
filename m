Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4AE75053F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 12:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjGLKzw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 06:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbjGLKzv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:55:51 -0400
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87454E77
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 03:55:50 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4R1F5d0l0bzMqJhT;
        Wed, 12 Jul 2023 10:55:49 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4R1F5c1FSMzMppwB;
        Wed, 12 Jul 2023 12:55:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1689159348;
        bh=Cd6UqDX2YshUZZpNGU2D7q3v1VSzrxqjwDknoUIXV1Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O+USgyCyOYnUVfyfuHxfskMy9U0iNIeDmj9HbbM0uy55mWbJXpoZ1e4lL7rJSXLwX
         cPVHXEGybBDGqkUJqWHSKCzIR5tD/OQbfrsd6tRak3Df/32dqtHtQ8pAxzkGHqx3iZ
         t8k4CMiQ9OXlmgnwn4UI1AVfZnosQtEGz9dzji0g=
Message-ID: <1316b856-2df8-24d3-ede5-b029870a1b1a@digikod.net>
Date:   Wed, 12 Jul 2023 12:55:47 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v2 4/6] selftests/landlock: Test ioctl with memfds
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack@google.com>,
        linux-security-module@vger.kernel.org
Cc:     Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-fsdevel@vger.kernel.org
References: <20230623144329.136541-1-gnoack@google.com>
 <20230623144329.136541-5-gnoack@google.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230623144329.136541-5-gnoack@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 23/06/2023 16:43, Günther Noack wrote:
> Because the ioctl right is associated with the opened file,
> we expect that it will work with files which are opened by means
> other than open(2).
> 
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>   tools/testing/selftests/landlock/fs_test.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 0f0899768fe7..ebd93e895775 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -3716,18 +3716,20 @@ TEST_F_FORK(ftruncate, open_and_ftruncate_in_different_processes)
>   	ASSERT_EQ(0, close(socket_fds[1]));
>   }
>   
> -TEST(memfd_ftruncate)
> +TEST(memfd_ftruncate_and_ioctl)

You could create memfd fixture/teardown with TEST_F(memfd, ftruncate) 
and TEST_F(memfd, ioctl) to cleanly differentiate these tests.


>   {
> -	int fd;
> +	int fd, n;
>   
>   	fd = memfd_create("name", MFD_CLOEXEC);
>   	ASSERT_LE(0, fd);
>   
>   	/*
> -	 * Checks that ftruncate is permitted on file descriptors that are
> -	 * created in ways other than open(2).
> +	 * Checks that operations associated with the opened file
> +	 * (ftruncate, ioctl) are permitted on file descriptors that
> +	 * are created in ways other than open(2).
>   	 */
>   	EXPECT_EQ(0, test_ftruncate(fd));

I previously missed it but this test should check ftruncate with and 
without FS sandboxing to be sure that the resulting behavior is the 
same. Ditto for the IOCTL test.


> +	EXPECT_EQ(0, ioctl(fd, FIONREAD, &n));
>   
>   	ASSERT_EQ(0, close(fd));

EXPECT_EQ() for close() should be enough right?

>   }
