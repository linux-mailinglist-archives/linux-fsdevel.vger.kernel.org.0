Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF14E6DF026
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 11:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjDLJUE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 05:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDLJUD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:20:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC046EAE;
        Wed, 12 Apr 2023 02:20:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F09F63145;
        Wed, 12 Apr 2023 09:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617D1C433D2;
        Wed, 12 Apr 2023 09:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681291201;
        bh=Wl8EToeONddCkJlYNi+bIXDPpeyQMnzc28iy+VsV/6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mO4PQ0c/BBOsynBdBXBT0cu/swFC10YtWAEYX2TK36LSSJDp0Idi+uN7ok7phCoUX
         1N80H9Wlh/G+Gdyb9FEJJoOvK6UCELVs6BalUK65gvoBjiu3Wz2u531oRRrortaueP
         FL00QFvdnSC6Z4TF9IuuepdxfBdhSMRfMKr4AVsxWsXjAdJLdLqbmle9NAl+rZ6+hZ
         xw9CvqK8Z4XlWhYMyXunhEIIo6q+Z7aLOogOP3KCk0XeU8RKEpaYxhCu0uCTcBITmh
         YLdHMOssh+sUwWYoMTvsPV7Zu7d+PGj7QL9dFwfm2xpS61GghvbCXD0rDBEub3z4aR
         55OxI9LH+8g1g==
Date:   Wed, 12 Apr 2023 11:19:56 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: fix sysctls.c built
Message-ID: <20230412-sympathie-haltbar-da2d2183067b@brauner>
References: <20230331084502.155284-1-wangkefeng.wang@huawei.com>
 <66c0e8b6-64d1-5be6-cd4d-9700d84e1b84@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <66c0e8b6-64d1-5be6-cd4d-9700d84e1b84@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 11, 2023 at 12:14:44PM +0800, Kefeng Wang wrote:
> /proc/sys/fs/overflowuid and overflowgid  will be lost without
> building this file, kindly ping, any comments, thanks.
> 
> 
> On 2023/3/31 16:45, Kefeng Wang wrote:
> > 'obj-$(CONFIG_SYSCTL) += sysctls.o' must be moved after "obj-y :=",
> > or it won't be built as it is overwrited.
> > 
> > Fixes: ab171b952c6e ("fs: move namespace sysctls and declare fs base directory")
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > ---
> >   fs/Makefile | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/fs/Makefile b/fs/Makefile
> > index 05f89b5c962f..8d4736fcc766 100644
> > --- a/fs/Makefile
> > +++ b/fs/Makefile
> > @@ -6,7 +6,6 @@
> >   # Rewritten to use lists instead of if-statements.
> >   #
> > -obj-$(CONFIG_SYSCTL)		+= sysctls.o
> >   obj-y :=	open.o read_write.o file_table.o super.o \
> >   		char_dev.o stat.o exec.o pipe.o namei.o fcntl.o \
> > @@ -50,7 +49,7 @@ obj-$(CONFIG_FS_MBCACHE)	+= mbcache.o
> >   obj-$(CONFIG_FS_POSIX_ACL)	+= posix_acl.o
> >   obj-$(CONFIG_NFS_COMMON)	+= nfs_common/
> >   obj-$(CONFIG_COREDUMP)		+= coredump.o
> > -obj-$(CONFIG_SYSCTL)		+= drop_caches.o
> > +obj-$(CONFIG_SYSCTL)		+= drop_caches.o sysctls.o
> >   obj-$(CONFIG_FHANDLE)		+= fhandle.o
> >   obj-y				+= iomap/

Given the description in
ab171b952c6e ("fs: move namespace sysctls and declare fs base directory")
you probably want to move this earlier.

