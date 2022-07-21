Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EFA57C8D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jul 2022 12:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbiGUKUO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 06:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbiGUKUN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:20:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E90BE10;
        Thu, 21 Jul 2022 03:20:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B969D615A3;
        Thu, 21 Jul 2022 10:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9180AC3411E;
        Thu, 21 Jul 2022 10:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658398808;
        bh=IOs+THemhodaTZ8Z0WYZrdJi08Ff46+DRyp6inkfY5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cK07/kyJP3C/Bq90bAQDkWR3qZ7v4DTgHY3NaVI+1oewc03Bdm2/Cpvsb7D9NBFLD
         rOt47U7YxoPgky6/6ofAgZPOMyvSXcTFTaKLiBr3Ha+fGfQXHUw4R4+xncQyLrCDBu
         Q4qJhLPbAVmFK6gowtXOvHh0EGbbXljdoDOiS0eyRn/fX1I+HVHDPWcAnZVcccF+ds
         qeIauP0he9UsKs+034H1Fc6x5iMq+ZSLGLXuDC+a+1zGAzduE4FPDKhrUQ+Dh/1dR8
         pSd2lQi5qf32f8zxCbMkZ+fBz5TxtpNUaILLXBsePwYV7mTi78UtfHG7q0SNwZngwS
         V8OjrS1qa/GbA==
Date:   Thu, 21 Jul 2022 12:20:02 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com, djwong@kernel.org,
        willy@infradead.org, jlayton@kernel.org, pvorel@suse.cz,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v10 1/4] fs: add mode_strip_sgid() helper
Message-ID: <20220721102002.cgufvxxtv7zk4yhk@wittgenstein>
References: <1657779088-2242-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220714125620.iwww4eivtbytzlgg@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220714125620.iwww4eivtbytzlgg@wittgenstein>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 14, 2022 at 02:56:26PM +0200, Christian Brauner wrote:
> On Thu, Jul 14, 2022 at 02:11:25PM +0800, Yang Xu wrote:
> > Add a dedicated helper to handle the setgid bit when creating a new file
> > in a setgid directory. This is a preparatory patch for moving setgid
> > stripping into the vfs. The patch contains no functional changes.
> > 
> > Currently the setgid stripping logic is open-coded directly in
> > inode_init_owner() and the individual filesystems are responsible for
> > handling setgid inheritance. Since this has proven to be brittle as
> > evidenced by old issues we uncovered over the last months (see [1] to
> > [3] below) we will try to move this logic into the vfs.
> > 
> > Link: e014f37db1a2 ("xfs: use setattr_copy to set vfs inode attributes") [1]
> > Link: 01ea173e103e ("xfs: fix up non-directory creation in SGID directories") [2]
> > Link: fd84bfdddd16 ("ceph: fix up non-directory creation in SGID directories") [3]
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > Reviewed-and-Tested-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> > ---
> 
> Fyi, I'm on vacation this week and will review this when I get back and
> if things look sane plan to pick it up for the next mw.

Getting back I immediately got a massive summer cold so I'm fairly slow
at picking things back up. Sorry for the delays.

So I rewrote parts of the commit message and specifically added more
details to explicitly point out what regression risks exists. But
overall I don't see any big issues with this anymore. A full xfstests
run for both xfs and ext4 didn't show any regressions. The full LTP
testsuite also didn't find anything to complain about. Still doesn't
mean we won't have people yell but hey it's a start.

I think the benefits of moving S_ISGID handling into the VFS are fairly
obvious and described in detail in [3/4]. Weighing benefits vs
regression risks it seems that we are inclined to try this approach. We
might just fall flat on our face with this but then we'll just have to
revert.

As always, if someone else wants to get their fingers burned by
proposing this during the next mw I'll happily drop it.

[1/4] fs: add mode_strip_sgid() helper
      commit: 2b3416ceff5e6bd4922f6d1c61fb68113dd82302
[2/4] fs: Add missing umask strip in vfs_tmpfile
      commit: ac6800e279a22b28f4fc21439843025a0d5bf03e
[3/4] fs: move S_ISGID stripping into the vfs_*() helpers
      commit: 1639a49ccdce58ea248841ed9b23babcce6dbb0b
[4/4] ceph: rely on vfs for setgid stripping
      commit: 5fadbd992996e9dda7ebcb62f5352866057bd619

Thanks!
Christian
