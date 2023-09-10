Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E455C799D96
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Sep 2023 12:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343755AbjIJKC3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Sep 2023 06:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjIJKC2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Sep 2023 06:02:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CFECD1
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Sep 2023 03:02:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11634C433C8;
        Sun, 10 Sep 2023 10:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694340144;
        bh=FZhPppxGlogIbF+Za5wY/vs5wkvbGB/Ebl4fNOOTzWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DMqhQbZCzg55YLHVgkdZBKRegTVJKJfQ3HBXoDNYLi0qehGbi4vX2jg37F25856m6
         i0c6ny7qVt1t3YCa9JLR/uG9sITxHzutj63gNtwjdYVrYp/bnpr9b5d7Fge3Tsb0mB
         tpDFd9B5+Ln28vBTdCsyeSQyeqK2r40ltg4fh0xDHLZN5xGsbqg1r/JDx8fbtPS0hz
         Ssu7IABS4j+Y5SzoZK3Yf3HxQ3HibaF1Q4SrFWQUeLQIfq5eKQQYuyq9Es0LBRMMmZ
         uFNDDYGV6qi+2twZjTAw+d3ScnfMV1n44C7ZPoEuvF/m+t+6VsLaa7HwOqIcRvSfok
         Q+FvQC+Xg4Ajg==
Date:   Sun, 10 Sep 2023 12:02:19 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Reuben Hawkins <reubenhwk@gmail.com>,
        linux-fsdevel@vger.kernel.org, mszeredi@redhat.com,
        willy@infradead.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] vfs: fix readahead(2) on block devices
Message-ID: <20230910-werken-sololauf-df32fb5dcddc@brauner>
References: <20230909043806.3539-1-reubenhwk@gmail.com>
 <CAOQ4uxiEmJjWQV=cbrmwXF0N1vyRi8sej9ZqbieUUct4_uWuEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiEmJjWQV=cbrmwXF0N1vyRi8sej9ZqbieUUct4_uWuEw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 09, 2023 at 09:36:10AM +0300, Amir Goldstein wrote:
> On Sat, Sep 9, 2023 at 7:39 AM Reuben Hawkins <reubenhwk@gmail.com> wrote:
> >
> > Readahead was factored to call generic_fadvise.  That refactor broke
> > readahead on block devices.
> 
> More accurately: That refactor added a S_ISREG restriction to the syscall
> that broke readahead on block devices.
> 
> >
> > The fix is to check F_ISFIFO rather than F_ISREG.  It would also work to
> > not check and let generic_fadvise to do the checking, but then the
> > generic_fadvise return value would have to be checked and changed from
> > -ESPIPE to -EINVAL to comply with the readahead(2) man-pages.
> >
> 
> We do not treat the man-pages as a holy script :)
> 
> It is quite likely that the code needs to change and the man-page will
> also be changed to reflect the fact that ESPIPE is a possible return value.
> In fact, see what the man page says about posix_fadvise(2):
> 
>        ESPIPE The specified file descriptor refers to a pipe or FIFO.
> (ESPIPE is the error specified by POSIX, but before kernel version
> 2.6.16, Linux returned EINVAL in this case.)
> 
> My opinion is that we should drop the ISREG/ISFIFO altogether,
> let the error code change to ESPIPE, and send a patch to man-pages
> to reflect that change (after it was merged and released),
> but I would like to hear what other people think.

Probably fine with the understanding that if we get regression reports
it needs to be reverted quickly and the two of you are around to take
care of that... ;) 
