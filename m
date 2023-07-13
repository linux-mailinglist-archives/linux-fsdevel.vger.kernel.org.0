Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794D97524A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 16:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbjGMOIl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 10:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbjGMOIj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:08:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0C0212D;
        Thu, 13 Jul 2023 07:08:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B7866153E;
        Thu, 13 Jul 2023 14:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FE8C433C7;
        Thu, 13 Jul 2023 14:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689257317;
        bh=M6iQ7DIWqL8Vjkb3xqZQG/pYMBGCLoNvN0tEMGDbGZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S9MMjI99SWsrm6RM/w2eQ/eOrCS+DPlN8cQ2jcQYttC8Jl2X5+vD09L7+Qlkuuiqp
         esRvmew3/jVF/7PZYVgEkowfYkPA5Q7EIYQ6FHZg6bcHZ3kJO2yrYAlUS9lUYgol1P
         uzz0XGnCGa9vlUPmglbFK18PPZbK973kLuQotM6RWx2DIu8gX2OHHRI65Gu1ulhSlF
         U9CPcu/yReL8XOLu/xeaANNJn0v+qhGFuclnvp865lJ+Tx7HKkwX7UqwSCto4F0fgS
         1aoU0pdLMAcfOfMETiR3E/UxANCHaIRpaJ6imOwgGVFVKoIDZI6kkZFuj9b3iZXYLT
         mgE+xjbSkhCNw==
Date:   Thu, 13 Jul 2023 16:08:31 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
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
Message-ID: <20230713-agenda-umlaufen-ef31df2ef1d1@brauner>
References: <20230713-unerschrocken-kutschieren-9be3c8958b5d@brauner>
 <nbzkbbahgsds4s4ujmkvno7w42xxy7gkpsrtw7lay3253uabzu@iqgtepoo4fgo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nbzkbbahgsds4s4ujmkvno7w42xxy7gkpsrtw7lay3253uabzu@iqgtepoo4fgo>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

If you wanted to add tests as a separate patch they should very likely
go into tools/testing/selftets/proc.
