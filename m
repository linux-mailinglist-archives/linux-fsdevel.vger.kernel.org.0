Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F657523A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 15:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbjGMNYe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 09:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbjGMNYR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:24:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478E03C01;
        Thu, 13 Jul 2023 06:23:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8557C612FC;
        Thu, 13 Jul 2023 13:22:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C62C433C7;
        Thu, 13 Jul 2023 13:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689254550;
        bh=bOUAPzYMXtdmmDSu2PZbdjTsWvkvo0nimQiCAPr8Yhw=;
        h=Date:From:To:Cc:Subject:From;
        b=JhOxNiBdFSDCF2V9/Owve15T7sqX4XOaeLrOvcgSNwS3EOX8VGPBTRWhuKoRbgBd6
         UZFYLGBzQhDg3neOr3DuwW0ysPNNI3j+3TqncYXQx5UByAPqlrSR9FNQA9+GAO5LFF
         y0krZvqDmQ5nsqpEiy0GeMLmk+sjw1pb6NYckaT6eXLvP7V99Bmw8ctkemXlii6Yzb
         LjhV08DNKdnVDxVeYlcOFk53tsOZU4+Jo52jzg8OzM36DdGHFjIQHeCqY+8H+mRPpa
         fGonogsNanTUNMQAXXtHV+wsT033vaVk2i34k/TuiaojjLu7D980TKd4GHtOwPNXA1
         kcr1qYNL3l4Gg==
Date:   Thu, 13 Jul 2023 15:22:24 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     Aleksa Sarai <cyphar@cyphar.com>, Willy Tarreau <w@1wt.eu>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        xu xin <cgel.zte@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Stefan Roesch <shr@devkernel.io>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Janis Danisevskis <jdanis@google.com>,
        Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] procfs: block chmod on /proc/thread-self/comm
Message-ID: <20230713-unerschrocken-kutschieren-9be3c8958b5d@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > index 486334981e60..08f0969208eb 100644
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > @@ -580,6 +580,10 @@ int run_syscall(int min, int max)
> >  		CASE_TEST(chmod_net);         EXPECT_SYSZR(proc, chmod("/proc/self/net", 0555)); break;
> >  		CASE_TEST(chmod_self);        EXPECT_SYSER(proc, chmod("/proc/self", 0555), -1, EPERM); break;
> >  		CASE_TEST(chown_self);        EXPECT_SYSER(proc, chown("/proc/self", 0, 0), -1, EPERM); break;
> > +		CASE_TEST(chmod_self_comm);   EXPECT_SYSER(proc, chmod("/proc/self/comm", 0777), -1, EPERM); break;
> > +		CASE_TEST(chmod_tid_comm);    EXPECT_SYSER(proc, chmod("/proc/thread-self/comm", 0777), -1, EPERM); break;
> > +		CASE_TEST(chmod_self_environ);EXPECT_SYSER(proc, chmod("/proc/self/environ", 0777), -1, EPERM); break;
> > +		CASE_TEST(chmod_tid_environ); EXPECT_SYSER(proc, chmod("/proc/thread-self/environ", 0777), -1, EPERM); break;

> 
> I'm not a big fan of this, it abuses the nolibc testsuite to test core
> kernel functionality.

Yes, this should be dropped.
We need a minimal patch to fix this. This just makes backporting harder
and any test doesn't need to be backported.
