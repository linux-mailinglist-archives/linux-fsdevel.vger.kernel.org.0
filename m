Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CCE7BF84C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 12:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjJJKQH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 06:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjJJKQD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 06:16:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DF5A9
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 03:15:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 15CD91F45E;
        Tue, 10 Oct 2023 10:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1696932957;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JQtlowriA+YahhOUT6zQdsZAtOZFgXeWZ5jWHYtFuhE=;
        b=H/KumeFhsdD7hIZ8Doqb3rPnwutGTmy6sYi1/UJqICfC4+qrLU9eFhqoZhbiNB5x7zimYE
        RP7nZxJfc721nbUOjgDSMAfwEQE5BVgwLcAKpb2NO1KSG3Nu44uvQjCPeZR4c8/EKZxwMx
        9MYNq03fLmUpRYE1HBDy/kgaIPKeLYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1696932957;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JQtlowriA+YahhOUT6zQdsZAtOZFgXeWZ5jWHYtFuhE=;
        b=XJGY1hlLr89DS8IcwCxSq8aB3kjqI9XPbV9NwUQ3FPIs+HE326TucDNu6QAnjR9wK7SUUa
        anawRj7DpHhKWkDg==
Received: from g78 (unknown [10.163.25.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 851BB2C3F7;
        Tue, 10 Oct 2023 10:15:56 +0000 (UTC)
References: <20231004124712.3833-1-chrubis@suse.cz>
User-agent: mu4e 1.10.7; emacs 29.1
From:   Richard Palethorpe <rpalethorpe@suse.de>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [LTP] [PATCH 0/3] Add tst_iterate_fd()
Date:   Tue, 10 Oct 2023 11:13:59 +0100
Organization: Linux Private Site
Reply-To: rpalethorpe@suse.de
In-reply-to: <20231004124712.3833-1-chrubis@suse.cz>
Message-ID: <87o7h6zsth.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

>  - adds tst_iterate_fd() functionality
>  - make use of tst_iterate_fd() in readahead01
>  - add accept03 test which uses tst_iterate_fd()
>
> This is a prototype for how the functionality to iterate over different
> file descriptors should look like it converts one tests and adds
> another. There is plenty of other syscalls that can use this kind of
> testing, e.g. all fooat() syscalls where we can pass invalid dir_fd, the
> plan is to add these if/once we agree on the API.

I imagine the results of using this with splice could be very interesting.

>
> Cyril Hrubis (3):
>   lib: Add tst_fd_iterate()
>   syscalls/readahead01: Make use of tst_fd_iterate()
>   syscalls: accept: Add tst_fd_iterate() test
>
>  include/tst_fd.h                              |  39 ++++++
>  include/tst_test.h                            |   1 +
>  lib/tst_fd.c                                  | 116 ++++++++++++++++++
>  runtest/syscalls                              |   1 +
>  testcases/kernel/syscalls/accept/.gitignore   |   1 +
>  testcases/kernel/syscalls/accept/accept01.c   |   8 --
>  testcases/kernel/syscalls/accept/accept03.c   |  46 +++++++
>  .../kernel/syscalls/readahead/readahead01.c   |  46 +++----
>  8 files changed, 224 insertions(+), 34 deletions(-)
>  create mode 100644 include/tst_fd.h
>  create mode 100644 lib/tst_fd.c
>  create mode 100644 testcases/kernel/syscalls/accept/accept03.c
>
> -- 
> 2.41.0


-- 
Thank you,
Richard.
