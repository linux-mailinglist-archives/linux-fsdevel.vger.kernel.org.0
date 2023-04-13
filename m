Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7496E148A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 20:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjDMSqz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 14:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjDMSqv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 14:46:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC62683EA;
        Thu, 13 Apr 2023 11:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dNYYdWzt693K1oVPkn64MLZkTv/0b4QDDWrgcRmK/W8=; b=nx1OYDQ2wU4A4zRgwRtLMy53o3
        cvAkp9M5xekmrXZ3ad3IwsxnCFyHZoyMW0UwB8qfdUDuiuYK5uvQK+gjvWY1eO1ChG8F7No5D7JXY
        Xl0NZTe3OmPh6qKyNcRWYRrNmakyjOPYyC/b9UZpcyVUXoUaU2TskEaf8S58GSSk8a2cRi5qV0DWw
        eJBDYdylagr+wjrFfXBUVajaSlGdigZcg5EYt2JHAqkaY4uTAbHkseN8OKsyGvQwo1nLxpMKpowOK
        5OhqL05u/uuDqUyKH6+bRHR6wzg126M67IUXTjjq3UsSRu8EIGchkCCwHvNhKV/FqeKFQaT1Jr9Ll
        M/k9SjfQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pn1xg-006wPr-0c;
        Thu, 13 Apr 2023 18:46:24 +0000
Date:   Thu, 13 Apr 2023 11:46:24 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: fix sysctls.c built
Message-ID: <ZDhOAKZK+P4IFDJp@bombadil.infradead.org>
References: <20230331084502.155284-1-wangkefeng.wang@huawei.com>
 <66c0e8b6-64d1-5be6-cd4d-9700d84e1b84@huawei.com>
 <20230412-sympathie-haltbar-da2d2183067b@brauner>
 <ZDg2m/U1NasHfK4j@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDg2m/U1NasHfK4j@bombadil.infradead.org>
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

On Thu, Apr 13, 2023 at 10:06:35AM -0700, Luis Chamberlain wrote:
> On Wed, Apr 12, 2023 at 11:19:56AM +0200, Christian Brauner wrote:
> > On Tue, Apr 11, 2023 at 12:14:44PM +0800, Kefeng Wang wrote:
> > > /proc/sys/fs/overflowuid and overflowgid  will be lost without
> > > building this file, kindly ping, any comments, thanks.
> > > 
> > > 
> > > On 2023/3/31 16:45, Kefeng Wang wrote:
> > > > 'obj-$(CONFIG_SYSCTL) += sysctls.o' must be moved after "obj-y :=",
> > > > or it won't be built as it is overwrited.
> > > > 
> > > > Fixes: ab171b952c6e ("fs: move namespace sysctls and declare fs base directory")
> > > > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > > > ---
> > > >   fs/Makefile | 3 +--
> > > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > > > 
> > > > diff --git a/fs/Makefile b/fs/Makefile
> > > > index 05f89b5c962f..8d4736fcc766 100644
> > > > --- a/fs/Makefile
> > > > +++ b/fs/Makefile
> > > > @@ -6,7 +6,6 @@
> > > >   # Rewritten to use lists instead of if-statements.
> > > >   #
> > > > -obj-$(CONFIG_SYSCTL)		+= sysctls.o
> > > >   obj-y :=	open.o read_write.o file_table.o super.o \
> > > >   		char_dev.o stat.o exec.o pipe.o namei.o fcntl.o \
> > > > @@ -50,7 +49,7 @@ obj-$(CONFIG_FS_MBCACHE)	+= mbcache.o
> > > >   obj-$(CONFIG_FS_POSIX_ACL)	+= posix_acl.o
> > > >   obj-$(CONFIG_NFS_COMMON)	+= nfs_common/
> > > >   obj-$(CONFIG_COREDUMP)		+= coredump.o
> > > > -obj-$(CONFIG_SYSCTL)		+= drop_caches.o
> > > > +obj-$(CONFIG_SYSCTL)		+= drop_caches.o sysctls.o
> > > >   obj-$(CONFIG_FHANDLE)		+= fhandle.o
> > > >   obj-y				+= iomap/
> > 
> > Given the description in
> > ab171b952c6e ("fs: move namespace sysctls and declare fs base directory")
> > you probably want to move this earlier.
> 
> I was being *way* too cautious and I was wrong, so I'll take Kefang's patch as
> I can verify now that order does not matter and his patch is correct.
> I've corrected the documentation and clarified this on sysctl-next and
> so reflected on linux-next too with these two patches:
> 
> sysctl: clarify register_sysctl_init() base directory order
> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?h=sysctl-next-20230413&id=8ae59580f2b0529b6dd1a1cda6b838cfb268cb87
> 
> proc_sysctl: move helper which creates required subdirectories
> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?h=sysctl-next-20230413&id=f4c09b14073513efd581459520a01c4c88cb24d7
> 
> proc_sysctl: update docs for __register_sysctl_table()
> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?h=sysctl-next-20230413&id=d59d91edd67ec4cef62f26249510fe08b291ae72
> 
> proc_sysctl: enhance documentation
> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?h=sysctl-next-20230413&id=eb472aa0678fd03321093bffeb9c7fd7f5035844
> 
> And so something we can do eventually is do away with all the base stuff.
> For now it's fine, it's not creating an issue.

Come to think of it all the above patches except the one that moves code
("proc_sysctl: move helper which creates required subdirectories") are
stable fix candidates prior to Kefeng's patch. I'll also update Kefeng's
patch to mention stable down to v5.17 and update the other patches with
the respective stable tag as well.

  Luis
