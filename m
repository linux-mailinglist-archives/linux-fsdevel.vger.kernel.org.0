Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA056E0902
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 10:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjDMIfg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 04:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjDMIff (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:35:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A31974A;
        Thu, 13 Apr 2023 01:35:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CACAE61330;
        Thu, 13 Apr 2023 08:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEFDC433D2;
        Thu, 13 Apr 2023 08:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681374924;
        bh=6XyAh0pAa5/U3o8RmwkLViJEBMG2Z80E16mGNXFsjFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lhFpLyE4u0KZ+ao1upYPqpKZr7IxgVLUBuYgRRP/dIvWVMY29yyMnoPPS7oWqc1OV
         /Lw3+mmCfLLvY0dmRq36uecuEcvmgibOqPNcGqz+axZtcSOCka6XxZLRI6TvDhNpwB
         q8KCGFZCuRIMZABeZx8yZCAd0/ICgfzbZAPj1ne8SbVf6aLWd7gzlOh6QA8SRkkCq2
         AEyKf7Xc0ApVT6NgYQmn/fbgMPByFKL4JY1iPNPhmB6h0QviIBQNJ0YqvAg7Nrkmrv
         cigXh6dWC2e9T7haPTdSRpzbQn9jcwEUoRYsqVr3jQB9da+v6HTvsIMOLM5Bxer2TI
         dRthIwzFkYseA==
Date:   Thu, 13 Apr 2023 10:35:18 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: fix sysctls.c built
Message-ID: <20230413-kufen-infekt-02c7eb2a9adc@brauner>
References: <20230331084502.155284-1-wangkefeng.wang@huawei.com>
 <66c0e8b6-64d1-5be6-cd4d-9700d84e1b84@huawei.com>
 <20230412-sympathie-haltbar-da2d2183067b@brauner>
 <a01a789c-8965-d1dc-cb45-ea9901a9af34@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a01a789c-8965-d1dc-cb45-ea9901a9af34@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 13, 2023 at 09:34:54AM +0800, Kefeng Wang wrote:
> 
> 
> On 2023/4/12 17:19, Christian Brauner wrote:
> > On Tue, Apr 11, 2023 at 12:14:44PM +0800, Kefeng Wang wrote:
> > > /proc/sys/fs/overflowuid and overflowgid  will be lost without
> > > building this file, kindly ping, any comments, thanks.
> > > 
> > > 
> > > On 2023/3/31 16:45, Kefeng Wang wrote:
> > > > 'obj-$(CONFIG_SYSCTL) += sysctls.o' must be moved after "obj-y :=",
> > > > or it won't be built as it is overwrited.
> 
> ...
> 
> > Given the description in
> > ab171b952c6e ("fs: move namespace sysctls and declare fs base directory")
> > you probably want to move this earlier.
> 
> Oh, missing that part, but the /proc/sys/fs/overflowuid and overflowgid are
> lost after it, is it expected? Luis, could you take a look? thanks.

No, /proc/sys/fs/overflow{g,u}id need to be there of course. What I mean
is something like the following (similar to how net/core/ does it):

UNTESTED
---
 fs/Makefile | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/Makefile b/fs/Makefile
index 05f89b5c962f..dfaea8a28d92 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -6,17 +6,19 @@
 # Rewritten to use lists instead of if-statements.
 #

-obj-$(CONFIG_SYSCTL)           += sysctls.o
-
-obj-y :=       open.o read_write.o file_table.o super.o \
-               char_dev.o stat.o exec.o pipe.o namei.o fcntl.o \
-               ioctl.o readdir.o select.o dcache.o inode.o \
-               attr.o bad_inode.o file.o filesystems.o namespace.o \
-               seq_file.o xattr.o libfs.o fs-writeback.o \
-               pnode.o splice.o sync.o utimes.o d_path.o \
-               stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
-               fs_types.o fs_context.o fs_parser.o fsopen.o init.o \
-               kernel_read_file.o mnt_idmapping.o remap_range.o
+obj-y                  := fs_types.o
+obj-$(CONFIG_SYSCTL)   += sysctls.o
+obj-y                  += open.o read_write.o file_table.o super.o \
+                          char_dev.o stat.o exec.o pipe.o namei.o \
+                          fcntl.o ioctl.o readdir.o select.o dcache.o \
+                          inode.o attr.o bad_inode.o file.o \
+                          filesystems.o namespace.o seq_file.o \
+                          xattr.o libfs.o fs-writeback.o pnode.o \
+                          splice.o sync.o utimes.o d_path.o stack.o \
+                          fs_struct.o statfs.o fs_pin.o nsfs.o \
+                          fs_types.o fs_context.o fs_parser.o \
+                          fsopen.o init.o kernel_read_file.o \
+                          mnt_idmapping.o remap_range.o

 ifeq ($(CONFIG_BLOCK),y)
 obj-y +=       buffer.o mpage.o
--
2.34.1

