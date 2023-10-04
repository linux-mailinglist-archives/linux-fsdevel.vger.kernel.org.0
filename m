Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9337B836F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 17:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbjJDPVT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 11:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbjJDPVS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:21:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F454C1
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Oct 2023 08:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eaj1nbQztuhuKccelZ+BQOCrDtJWkbonrfoX2OcHEf8=; b=NPild/7HWayzPN9o6aB/lvZgqR
        3AAetf6Vlv18epSXaRzQgzifZMAtKNAaZnYUScKzwLkyyLYJcG5FpDUkD5Yg3kknu6K9XFJvI1Lr9
        BBmMksvCuA8jkKKlj2JcJq8LSCP+GjzT/otm1FanxBEnZ64BWzXWl9dCUKTwvmlvx3UTl3K9RyDne
        jt9MrFZkmDukHkwTRhtjPldmkAaVQkyNLHrZuapW1rl79aMSR6aKFjrqVmaxJE9sUeKhTBh2YITAL
        arG8e6R+7RKW5BU56LQqHTev+9EnRdXmjr82NtnYGr3Lvtz2q/nYXckT4Ft4QFPeFb9v89WV5BUPh
        bCxzc2hg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qo3gN-0045Fx-66; Wed, 04 Oct 2023 15:21:03 +0000
Date:   Wed, 4 Oct 2023 16:21:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     ltp@lists.linux.it, amir73il@gmail.com, mszeredi@redhat.com,
        brauner@kernel.org, viro@zeniv.linux.org.uk,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] lib: Add tst_fd_iterate()
Message-ID: <ZR2C38vzil+dy6ZO@casper.infradead.org>
References: <20231004124712.3833-1-chrubis@suse.cz>
 <20231004124712.3833-2-chrubis@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004124712.3833-2-chrubis@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 04, 2023 at 02:47:10PM +0200, Cyril Hrubis wrote:
> +enum tst_fd_type {
> +	TST_FD_FILE,
> +	TST_FD_DIR,
> +	TST_FD_DEV_ZERO,
> +	TST_FD_PROC_MAPS,
> +	TST_FD_PIPE_IN,
> +	TST_FD_PIPE_OUT,
> +	TST_FD_UNIX_SOCK,
> +	TST_FD_INET_SOCK,
> +	TST_FD_IO_URING,
> +	TST_FD_BPF_MAP,
> +	TST_FD_MAX,
> +};

This looks great!  Thanks for turning my musing into concrete code.
Some other file descriptor types that might be interesting ...

O_PATH (see openat(2); some variants on this like opening a symlink with
O_NOFOLLOW)

epoll
eventfd
signalfd
timerfd_create
pidfd_open
fanotify_init
inotify
userfaultfd
perf_event_open
fsopen
fspick
fsmount
open_tree
secretmem
memfd

(i used a variety of techniques for thinking of these, including
grepping for CLOEXEC and fd_install)
