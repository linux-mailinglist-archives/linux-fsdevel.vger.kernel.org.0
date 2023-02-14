Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935F2696EAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 21:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjBNUqD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 15:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjBNUqC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 15:46:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB4E25293;
        Tue, 14 Feb 2023 12:46:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49C73618C1;
        Tue, 14 Feb 2023 20:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80545C433D2;
        Tue, 14 Feb 2023 20:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676407560;
        bh=nSGCvMOkVjv6R7oFAFpPRC17JDrtEfGiBOfnIbHMl/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fkR703z4bcshjOnTM9mtac3lz9vPzZ5zxt/xpUrhiAV3kxq5sCnxtivXWe+Wy6zxW
         ewBFksPJT4f/RoCzV0rn0Lf5tpUK2XmHmLokaNihmBBmM1bO2U4CZj7kdQzlm21V0W
         PLRtSDkY8lfpzJXAfFaHEAeIBraZVnmzOyIP8Q+wee7oQgsaWyM9KYDuXG9ElvNct0
         1GTDJF7Qh8lWmJ6Uop3KMLbb18XbP+GVT+E0PI0K9LV36PsgTtOWdi1IljvAr0l9t5
         cOTTlF2Rheq4Vm73shLsZ8S/BWeXg4a0BdrvD0NRD7/6qdJ1v2/ICFwSXqapKPnuqG
         zdtM+27gkeU3g==
Date:   Tue, 14 Feb 2023 14:45:59 -0600
From:   Seth Forshee <sforshee@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mount_setattr: fix redefine struct mount_attr
 build error
Message-ID: <Y+vzB1OTXr+zTCV7@do-x1extreme>
References: <20230213183149.231779-1-skhan@linuxfoundation.org>
 <Y+rMtlvx31w7eWCA@do-x1extreme>
 <f536ecc2-1889-6df6-43d3-1a04dc8f1b14@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f536ecc2-1889-6df6-43d3-1a04dc8f1b14@linuxfoundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 14, 2023 at 10:10:00AM -0700, Shuah Khan wrote:
> On 2/13/23 16:50, Seth Forshee wrote:
> > On Mon, Feb 13, 2023 at 11:31:49AM -0700, Shuah Khan wrote:
> > > Fix the following build error due to redefining struct mount_attr by
> > > removing duplicate define from mount_setattr_test.c
> > > 
> > > gcc -g -isystem .../tools/testing/selftests/../../../usr/include -Wall -O2 -pthread     mount_setattr_test.c  -o .../tools/testing/selftests/mount_setattr/mount_setattr_test
> > > mount_setattr_test.c:107:8: error: redefinition of ‘struct mount_attr’
> > >    107 | struct mount_attr {
> > >        |        ^~~~~~~~~~
> > > In file included from /usr/include/x86_64-linux-gnu/sys/mount.h:32,
> > >                   from mount_setattr_test.c:10:
> > > .../usr/include/linux/mount.h:129:8: note: originally defined here
> > >    129 | struct mount_attr {
> > >        |        ^~~~~~~~~~
> > > make: *** [../lib.mk:145: .../tools/testing/selftests/mount_setattr/mount_setattr_test] Error 1
> > > 
> > > Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> > > ---
> > >   tools/testing/selftests/mount_setattr/mount_setattr_test.c | 7 -------
> > >   1 file changed, 7 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> > > index 8c5fea68ae67..582669ca38e9 100644
> > > --- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> > > +++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> > > @@ -103,13 +103,6 @@
> > >   	#else
> > >   		#define __NR_mount_setattr 442
> > >   	#endif
> > > -
> > > -struct mount_attr {
> > > -	__u64 attr_set;
> > > -	__u64 attr_clr;
> > > -	__u64 propagation;
> > > -	__u64 userns_fd;
> > > -};
> > >   #endif
> > 
> > The difficulty with this is that whether or not you need this definition
> > depends on your system headers. My laptop doesn't have definitions for
> > either __NR_mount_setattr or struct mount_attr, so for me the build
> > works without this patch but fails with it.
> > 
> 
> The header search looks up system headers followed by installed headers in
> the repo (both in-tree and out-of-tree builds). kselftest builds do depend
> on headers_install. Did you building after running headers_install?

I wasn't aware they depend on headers_install. Why doesn't
Documentation/dev-tools/kselftest.rst mention this in the section that
describes how to run tests?

It seems what I really need to fix the build is to include
linux/mount.h, which works for me with or without headers_install,
because I have the struct in /usr/include/linux/mount.h. And I suppose
the makefile should use KHDR_INCLUDES. So maybe the changes below should
also be included.

However I know Christian has said that there are challenges with
including the mount headers. He wrote this test, so I'd like to hear his
thoughts about adding the include. He's on vacation this week though.

> > I suppose we could fix this universally by using a different name for
> > the struct in the test, e.g.:
> > 
> 
> This is not a good way to for a couple of reasons. This masks any problems
> due to incompatibility between these defines.

Agreed that this isn't ideal.

Thanks,
Seth


diff --git a/tools/testing/selftests/mount_setattr/Makefile b/tools/testing/selftests/mount_setattr/Makefile
index 2250f7dcb81e..fde72df01b11 100644
--- a/tools/testing/selftests/mount_setattr/Makefile
+++ b/tools/testing/selftests/mount_setattr/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for mount selftests.
-CFLAGS = -g -I../../../../usr/include/ -Wall -O2 -pthread
+CFLAGS = -g $(KHDR_INCLUDES) -Wall -O2 -pthread
 
 TEST_GEN_FILES += mount_setattr_test
 
diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index 8c5fea68ae67..969647228817 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -18,6 +18,7 @@
 #include <grp.h>
 #include <stdbool.h>
 #include <stdarg.h>
+#include <linux/mount.h>
 
 #include "../kselftest_harness.h"
 

