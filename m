Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630E37AC9FE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Sep 2023 16:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjIXO1p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Sep 2023 10:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjIXO1o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Sep 2023 10:27:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E76CFB
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Sep 2023 07:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oREoElc5jpssB77N72uWfn2jY29hXFa5YHaPFH9Puuw=; b=IWivhL67SaSkoM1RHiUcFSYaZt
        441UcLnuKM0oMXllZKJbrhSv3pxPu3tOCw6kc+ssFgntO7gNzMdtRSFBculTNtOTN87yHxs2pu5aj
        5ijTqI1aKo6sL8KatAX/2BNKGVO/lZmBmo0peYc9Y+yYyc+bQxii56hAFFrrBwVdwPDQjmsZYMLfP
        +X1Emiemllw8W75KWaE7zKUjq1N0Js4hWNw20h9iwnpdQc1zmrRA8suwiLXAsPgLHQH2hjjTF2uQf
        SSRcOUXmwJKqnmX/ZhuBUELT1hH6LXunKITNkhkxkRc6Dlg3guHog68Va1UJZ9jHN3AMnOV++h/N+
        KKBTXUrQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qkQ4u-00DPlw-2K; Sun, 24 Sep 2023 14:27:20 +0000
Date:   Sun, 24 Sep 2023 15:27:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Reuben Hawkins <reubenhwk@gmail.com>, brauner@kernel.org,
        Cyril Hrubis <chrubis@suse.cz>, mszeredi@redhat.com,
        lkp@intel.com, linux-fsdevel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        viro@zeniv.linux.org.uk, oe-lkp@lists.linux.dev,
        ltp@lists.linux.it, Jan Kara <jack@suse.cz>
Subject: Re: [LTP] [PATCH] vfs: fix readahead(2) on block devices
Message-ID: <ZRBHSACF5NdZoQwx@casper.infradead.org>
References: <CAOQ4uxhc8q=GAuL9OPRVOr=mARDL3TExPY0Zipij1geVKknkkQ@mail.gmail.com>
 <CAD_8n+TpZF2GoE1HUeBLs0vmpSna0yR9b+hsd-VC1ZurTe41LQ@mail.gmail.com>
 <ZQ1Z_JHMPE3hrzv5@yuki>
 <CAD_8n+ShV=HJuk5v-JeYU1f+MAq1nDz9GqVmbfK9NpNThRjzSg@mail.gmail.com>
 <CAOQ4uxjnCdAeWe3W4mp=DwgL49Vwp_FVx4S_V33A3-JLtzJb-g@mail.gmail.com>
 <ZQ75JynY8Y2DqaHD@casper.infradead.org>
 <CAOQ4uxjOGqWFdS4rU8u9TuLMLJafqMUsQUD3ToY3L9bOsfGibg@mail.gmail.com>
 <CAD_8n+SNKww4VwLRsBdOg+aBc7pNzZhmW9TPcj9472_MjGhWyg@mail.gmail.com>
 <CAOQ4uxjM8YTA9DjT5nYW1RBZReLjtLV6ZS3LNOOrgCRQcR2F9A@mail.gmail.com>
 <CAOQ4uxjmyfKmOxP0MZQPfu8PL3KjLeC=HwgEACo21MJg-6rD7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjmyfKmOxP0MZQPfu8PL3KjLeC=HwgEACo21MJg-6rD7g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 24, 2023 at 02:47:42PM +0300, Amir Goldstein wrote:
> Since you joined the discussion, you have the opportunity to agree or
> disagree with our decision to change readahead() to ESPIPE.
> Judging  by your citing of lseek and posix_fadvise standard,
> I assume that you will be on board?

I'm fine with returning ESPIPE (it's like ENOTTY in a sense).  but
that's not what kbuild reported:

readahead01.c:62: TFAIL: readahead(fd[0], 0, getpagesize()) succeeded

61:	fd[0] = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
62:	TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EINVAL);

I think LTP would report 'wrong error code' rather than 'succeeded'
if it were returning ESPIPE.

I'm not OK with readahead() succeeding on a socket.  I think that should
also return ESPIPE.  I think posix_fadvise() should return ESPIPE on a
socket too, but reporting bugs to the Austin Group seems quite painful.
Perhaps somebody has been through this process and can do that for us?

