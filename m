Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701EA6E1558
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 21:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjDMTnx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 15:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDMTnw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 15:43:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647DB61BD;
        Thu, 13 Apr 2023 12:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MCRGnPrlhG3WOEibxsQNuMHU+s/XzuGTAEvw6cYVVKg=; b=DTmMOcMC650npxPcpvLFqNNIeE
        d8Btku3t82aCbWeCAWsyy1+PtYyA9gUa6PYOsr7YCPkr0ae3xDuOCl714QTWMMay0QwwvEhCq8ebG
        fBr2XrU1xIRrbmpvlJkqrV37uKowNEE8NSQfkHdTmEolzVLMEQVgvlVhYYFjwB+8NhzfPNbx5ytye
        zJce/4+rXC0rK4fFpBvlwjHNkMD3iv9APjEzMNflibWcZv7U4kyPW2LM8N543OEaNbw5RD/CisCWi
        TrIi9339ZwG/8mGtns+tLm2uy2x5/98HiTC2Magghn3d7+QPtl2MSZKnWzLeF8B0DIpfBoGqcWHnA
        bt54FkLw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pn2rC-00722L-02;
        Thu, 13 Apr 2023 19:43:46 +0000
Date:   Thu, 13 Apr 2023 12:43:45 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: fix sysctls.c built
Message-ID: <ZDhbcRRDlCN9Dk6Y@bombadil.infradead.org>
References: <20230331084502.155284-1-wangkefeng.wang@huawei.com>
 <66c0e8b6-64d1-5be6-cd4d-9700d84e1b84@huawei.com>
 <20230412-sympathie-haltbar-da2d2183067b@brauner>
 <ZDg2m/U1NasHfK4j@bombadil.infradead.org>
 <ZDhOAKZK+P4IFDJp@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDhOAKZK+P4IFDJp@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 13, 2023 at 11:46:24AM -0700, Luis Chamberlain wrote:
> On Thu, Apr 13, 2023 at 10:06:35AM -0700, Luis Chamberlain wrote:
> > On Wed, Apr 12, 2023 at 11:19:56AM +0200, Christian Brauner wrote:
> > > On Tue, Apr 11, 2023 at 12:14:44PM +0800, Kefeng Wang wrote:
> > > > /proc/sys/fs/overflowuid and overflowgid  will be lost without
> > > > building this file, kindly ping, any comments, thanks.
> > > > 
> > > > 
> > > > On 2023/3/31 16:45, Kefeng Wang wrote:
> > > > > 'obj-$(CONFIG_SYSCTL) += sysctls.o' must be moved after "obj-y :=",
> > > > > or it won't be built as it is overwrited.
> > > > > 
> > > > > Fixes: ab171b952c6e ("fs: move namespace sysctls and declare fs base directory")
> > > > > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > > > > ---
> > > > >   fs/Makefile | 3 +--
> > > > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/fs/Makefile b/fs/Makefile
> > > > > index 05f89b5c962f..8d4736fcc766 100644
> > > > > --- a/fs/Makefile
> > > > > +++ b/fs/Makefile
> > > > > @@ -6,7 +6,6 @@
> > > > >   # Rewritten to use lists instead of if-statements.
> > > > >   #
> > > > > -obj-$(CONFIG_SYSCTL)		+= sysctls.o
> > > > >   obj-y :=	open.o read_write.o file_table.o super.o \
> > > > >   		char_dev.o stat.o exec.o pipe.o namei.o fcntl.o \
> > > > > @@ -50,7 +49,7 @@ obj-$(CONFIG_FS_MBCACHE)	+= mbcache.o
> > > > >   obj-$(CONFIG_FS_POSIX_ACL)	+= posix_acl.o
> > > > >   obj-$(CONFIG_NFS_COMMON)	+= nfs_common/
> > > > >   obj-$(CONFIG_COREDUMP)		+= coredump.o
> > > > > -obj-$(CONFIG_SYSCTL)		+= drop_caches.o
> > > > > +obj-$(CONFIG_SYSCTL)		+= drop_caches.o sysctls.o
> > > > >   obj-$(CONFIG_FHANDLE)		+= fhandle.o
> > > > >   obj-y				+= iomap/
> > > 
> > > Given the description in
> > > ab171b952c6e ("fs: move namespace sysctls and declare fs base directory")
> > > you probably want to move this earlier.
> > 
> > I was being *way* too cautious and I was wrong, so I'll take Kefang's patch as
> > I can verify now that order does not matter and his patch is correct.
> > I've corrected the documentation and clarified this on sysctl-next and
> > so reflected on linux-next too with these two patches:
> > 
> > sysctl: clarify register_sysctl_init() base directory order
> > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?h=sysctl-next-20230413&id=8ae59580f2b0529b6dd1a1cda6b838cfb268cb87
> > 
> > proc_sysctl: move helper which creates required subdirectories
> > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?h=sysctl-next-20230413&id=f4c09b14073513efd581459520a01c4c88cb24d7
> > 
> > proc_sysctl: update docs for __register_sysctl_table()
> > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?h=sysctl-next-20230413&id=d59d91edd67ec4cef62f26249510fe08b291ae72
> > 
> > proc_sysctl: enhance documentation
> > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?h=sysctl-next-20230413&id=eb472aa0678fd03321093bffeb9c7fd7f5035844
> > 
> > And so something we can do eventually is do away with all the base stuff.
> > For now it's fine, it's not creating an issue.
> 
> Come to think of it all the above patches except the one that moves code
> ("proc_sysctl: move helper which creates required subdirectories") are
> stable fix candidates prior to Kefeng's patch. I'll also update Kefeng's
> patch to mention stable down to v5.17 and update the other patches with
> the respective stable tag as well.

OK pushed to sysctl-next and updated the patches above also to refer to
stable and Cc you guys. Finally, a good reason or value to having Cc on
the commit log. It just tmeans you (Christian and Kefeng) will be be CC'd
once this trickles to stable kernel trees too.

  Luis
