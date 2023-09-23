Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E297AC2CF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Sep 2023 16:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjIWOmF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Sep 2023 10:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjIWOmE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Sep 2023 10:42:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1CD124
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Sep 2023 07:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9hSs/6VsEwk07R0zuYpipZH5iZqRr/xmEP3TnIMzeUU=; b=FPXisrSy8vIZJv3QSFPvG4trfL
        CO0a/FQmexgQh+/hM+05uxa5iocG4RYA0F36WnLicKqB5J4new6NvcVdjQl4tP2rPEXsIasfFXwaC
        IjJhOsrFuGepjpCrcP9EeT5lKWoDZkj9K9QyDsaLiDActNnEk3FQCVOIziROlYHXdfX2W2rOSZkh5
        hR45snuFbVLAxbs/yOwpWBUXxSc1rD0Yflz5vGonA9HNCNehtJX75Tn+nrSZ7MIVO+BOMOHdPF0Zf
        PnEU8PZWW4mC7mvRI5CbVUq9AvobUjJouRSyuSn0dWf8ae71755vXzinvjecuLauc50H/Tcdqe3Yj
        VCF2t2DA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qk3pH-007V6x-Mv; Sat, 23 Sep 2023 14:41:43 +0000
Date:   Sat, 23 Sep 2023 15:41:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Reuben Hawkins <reubenhwk@gmail.com>,
        Cyril Hrubis <chrubis@suse.cz>, mszeredi@redhat.com,
        brauner@kernel.org, lkp@intel.com, linux-fsdevel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        viro@zeniv.linux.org.uk, oe-lkp@lists.linux.dev, ltp@lists.linux.it
Subject: Re: [LTP] [PATCH] vfs: fix readahead(2) on block devices
Message-ID: <ZQ75JynY8Y2DqaHD@casper.infradead.org>
References: <20230909043806.3539-1-reubenhwk@gmail.com>
 <202309191018.68ec87d7-oliver.sang@intel.com>
 <CAOQ4uxhc8q=GAuL9OPRVOr=mARDL3TExPY0Zipij1geVKknkkQ@mail.gmail.com>
 <CAD_8n+TpZF2GoE1HUeBLs0vmpSna0yR9b+hsd-VC1ZurTe41LQ@mail.gmail.com>
 <ZQ1Z_JHMPE3hrzv5@yuki>
 <CAD_8n+ShV=HJuk5v-JeYU1f+MAq1nDz9GqVmbfK9NpNThRjzSg@mail.gmail.com>
 <CAOQ4uxjnCdAeWe3W4mp=DwgL49Vwp_FVx4S_V33A3-JLtzJb-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjnCdAeWe3W4mp=DwgL49Vwp_FVx4S_V33A3-JLtzJb-g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 23, 2023 at 08:56:28AM +0300, Amir Goldstein wrote:
> We decided to deliberately try the change of behavior
> from EINVAL to ESPIPE, to align with fadvise behavior,
> so eventually the LTP test should be changed to allow both.
> 
> It was the test failure on the socket that alarmed me.
> However, if we will have to special case socket in
> readahead() after all, we may as well also special case
> pipe with it and retain the EINVAL behavior - let's see
> what your findings are and decide.

If I read it correctly, LTP is reporting that readhaead() on a socket
returned success instead of an error.  Sockets do have a_ops, right?
It's set to empty_aops in inode_init_always, I think.

It would be nice if we documented somewhere which pointers should be
checked for NULL for which cases ... it doesn't really make sense for
a socket inode to have an i_mapping since it doesn't have pagecache.
But maybe we rely on i_mapping always being set.

Irritatingly, POSIX specifies ESPIPE for pipes, but does not specify
what to do with sockets.  It's kind of a meaningless syscall for
any kind of non-seekable fd.  lseek() returns ESPIPE for sockets
as well as pipes, so I'd see this as an oversight.
https://pubs.opengroup.org/onlinepubs/9699919799/functions/posix_fadvise.html
https://pubs.opengroup.org/onlinepubs/9699919799/functions/lseek.html

Of course readahead() is a Linux-specific syscall, so we can do whatever
we want here, but I'm really tempted to just allow readahead() for
regular files and block devices.  Hmm.  Can we check FMODE_LSEEK
instead of (S_ISFILE || S_ISBLK)?
