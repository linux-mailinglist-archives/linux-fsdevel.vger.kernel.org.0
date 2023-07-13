Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C3C7524BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 16:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbjGMONZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 10:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjGMONX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:13:23 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C892D47;
        Thu, 13 Jul 2023 07:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1689257564; bh=qZgsVhnTtsEJGDdMA3cJGw+neVfrXoMO8XmxTUb5MDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i4Nc2GOG0+wNZt3ZVaDZ57KSOpB7PHoTDDjspb65sFMBRb2wvJqs+k22H3sClMuO/
         iguarEuNyCwmbYFHBf6QNHbz/Hndw0vr4hlP6yMJldtsRgxmMn4//xj357jeGCMG8T
         ErDIYGIiOV52nOMc1GCGWP6TJHrRqld8QR/zQTB4=
Date:   Thu, 13 Jul 2023 16:12:43 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Christian Brauner <brauner@kernel.org>, Willy Tarreau <w@1wt.eu>,
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
Message-ID: <01abc05f-07ac-484d-90af-73b3e6ca7c83@t-8ch.de>
References: <20230713-unerschrocken-kutschieren-9be3c8958b5d@brauner>
 <nbzkbbahgsds4s4ujmkvno7w42xxy7gkpsrtw7lay3253uabzu@iqgtepoo4fgo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nbzkbbahgsds4s4ujmkvno7w42xxy7gkpsrtw7lay3253uabzu@iqgtepoo4fgo>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-07-14 00:00:51+1000, Aleksa Sarai wrote:
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

To test the functionality of the implementations of chown() and chmod()
in nolibc. procfs is used used as a test fixture to provide diverse file
and directories that are (nearly) always available.

The system under test is nolibc, not the kernel itself.

Thomas
