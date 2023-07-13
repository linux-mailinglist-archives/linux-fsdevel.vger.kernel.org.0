Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5E57524D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 16:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbjGMOOw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 10:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbjGMOOb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:14:31 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCD902722;
        Thu, 13 Jul 2023 07:14:27 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 36DEDqmj028510;
        Thu, 13 Jul 2023 16:13:52 +0200
Date:   Thu, 13 Jul 2023 16:13:52 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
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
Message-ID: <ZLAGoNkVyYHOtJSA@1wt.eu>
References: <20230713-unerschrocken-kutschieren-9be3c8958b5d@brauner>
 <nbzkbbahgsds4s4ujmkvno7w42xxy7gkpsrtw7lay3253uabzu@iqgtepoo4fgo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nbzkbbahgsds4s4ujmkvno7w42xxy7gkpsrtw7lay3253uabzu@iqgtepoo4fgo>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 14, 2023 at 12:00:51AM +1000, Aleksa Sarai wrote:
> On 2023-07-13, Christian Brauner <brauner@kernel.org> wrote:
> > > > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > > > index 486334981e60..08f0969208eb 100644
> > > > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > > > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > > > @@ -580,6 +580,10 @@ int run_syscall(int min, int max)
> > > >  		CASE_TEST(chmod_net);         EXPECT_SYSZR(proc, chmod("/proc/self/net", 0555)); break;
> > > >  		CASE_TEST(chmod_self);        EXPECT_SYSER(proc, chmod("/proc/self", 0555), -1, EPERM); break;
> > > >  		CASE_TEST(chown_self);        EXPECT_SYSER(proc, chown("/proc/self", 0, 0), -1, EPERM); break;
> > > > +		CASE_TEST(chmod_self_comm);   EXPECT_SYSER(proc, chmod("/proc/self/comm", 0777), -1, EPERM); break;
> > > > +		CASE_TEST(chmod_tid_comm);    EXPECT_SYSER(proc, chmod("/proc/thread-self/comm", 0777), -1, EPERM); break;
> > > > +		CASE_TEST(chmod_self_environ);EXPECT_SYSER(proc, chmod("/proc/self/environ", 0777), -1, EPERM); break;
> > > > +		CASE_TEST(chmod_tid_environ); EXPECT_SYSER(proc, chmod("/proc/thread-self/environ", 0777), -1, EPERM); break;
> > 
> > > 
> > > I'm not a big fan of this, it abuses the nolibc testsuite to test core
> > > kernel functionality.
> > 
> > Yes, this should be dropped.
> > We need a minimal patch to fix this. This just makes backporting harder
> > and any test doesn't need to be backported.
> 
> Alright, I'll drop it in v2 (though I'm not sure why there are tests for
> /proc/self and /proc/self/net then).

In fact the goal was to rely on existing entries that were certain to
return certain errors, as we are testing nolibc syscalls in limited
environments, such as not being able to create a new file due to another
syscall not being available yet. /proc is convenient to make a number
of syscalls fail. That's how the problem was detected by the way :-)

I personally don't mind that much that tests would be added, provided
they really test a new syscall+error combination each. As Thomas said,
here we already have other tests for chmod+EPERM so these ones do not
bring value here for the purpose of this specific test.

With that in mind, if there is some perceived value in adding such
tests, that's something we could discuss, either in this file as another
category or (preferably) in a separate one, because the framework makes
this easy. We could for example have a "proc-test" sub-project forked
from this one to run various tests on /proc file permissions. This would
respect a clean split, with nolibc-test assuming a valid kernel to test
a libc, and proc-test assuming a valid libc to test the kernel. Just an
idea.

Regards,
willy
