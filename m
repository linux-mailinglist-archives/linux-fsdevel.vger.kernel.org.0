Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3518C752485
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 16:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjGMOBO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 10:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjGMOBN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:01:13 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FECD270F;
        Thu, 13 Jul 2023 07:01:11 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4R1x8z5ySJz9sWC;
        Thu, 13 Jul 2023 16:01:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1689256867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xoZpC5tEyVOTQ6x0K7DEnPwvxgIBjqEXHKiZOKrXnL0=;
        b=RafNTYVkuSE4BxJrsjFV5sGndm3C0bTsASsDMQLpI2Ka28pNDhpxtuUXkx3/XkWDVk1aAi
        sG6wnN8oKoOuVtCXkQNev+E+2sKbWr/EC86bUTu7qqupDuxQTqeMtZFJk2kHWdLp2LAKCm
        6jpjHcDrXD0XKTaIiRlJ2wpt4NB0Q853KscPqgJpYMmmfw+RmaWRd4IaQYdBV92invW7ZO
        CcmV+nT+fx8uXL9mY7N8X9wKxv678T4PQXgJs4LtrYnmP4Dp1OJAND3MJ3XnCS5rOfim8z
        KsDLtSGJGHABmP1ByFRGIAU0nXHPNVtqqBIoVSreuzN9oKfNTI87U2eKuwB8bg==
Date:   Fri, 14 Jul 2023 00:00:51 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
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
Message-ID: <nbzkbbahgsds4s4ujmkvno7w42xxy7gkpsrtw7lay3253uabzu@iqgtepoo4fgo>
References: <20230713-unerschrocken-kutschieren-9be3c8958b5d@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713-unerschrocken-kutschieren-9be3c8958b5d@brauner>
X-Rspamd-Queue-Id: 4R1x8z5ySJz9sWC
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-07-13, Christian Brauner <brauner@kernel.org> wrote:
> > > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > > index 486334981e60..08f0969208eb 100644
> > > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > > @@ -580,6 +580,10 @@ int run_syscall(int min, int max)
> > >  		CASE_TEST(chmod_net);         EXPECT_SYSZR(proc, chmod("/proc/self/net", 0555)); break;
> > >  		CASE_TEST(chmod_self);        EXPECT_SYSER(proc, chmod("/proc/self", 0555), -1, EPERM); break;
> > >  		CASE_TEST(chown_self);        EXPECT_SYSER(proc, chown("/proc/self", 0, 0), -1, EPERM); break;
> > > +		CASE_TEST(chmod_self_comm);   EXPECT_SYSER(proc, chmod("/proc/self/comm", 0777), -1, EPERM); break;
> > > +		CASE_TEST(chmod_tid_comm);    EXPECT_SYSER(proc, chmod("/proc/thread-self/comm", 0777), -1, EPERM); break;
> > > +		CASE_TEST(chmod_self_environ);EXPECT_SYSER(proc, chmod("/proc/self/environ", 0777), -1, EPERM); break;
> > > +		CASE_TEST(chmod_tid_environ); EXPECT_SYSER(proc, chmod("/proc/thread-self/environ", 0777), -1, EPERM); break;
> 
> > 
> > I'm not a big fan of this, it abuses the nolibc testsuite to test core
> > kernel functionality.
> 
> Yes, this should be dropped.
> We need a minimal patch to fix this. This just makes backporting harder
> and any test doesn't need to be backported.

Alright, I'll drop it in v2 (though I'm not sure why there are tests for
/proc/self and /proc/self/net then).

-- 
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>
