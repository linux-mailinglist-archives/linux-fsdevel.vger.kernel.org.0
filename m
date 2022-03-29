Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284B64EABF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 13:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbiC2LKD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 07:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbiC2LKC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:10:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231AA10E5;
        Tue, 29 Mar 2022 04:08:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2D87B815A3;
        Tue, 29 Mar 2022 11:08:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE86FC340ED;
        Tue, 29 Mar 2022 11:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648552091;
        bh=LR+SDMflhdiC4ms2kEyojNy8qc/Y76arJjBc8dfUuBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U0EiYlEHm8RPS90tc7fQQH43AlVaPxVh5rui2mY3ok18GE1qnJTNQqErOKZ7k7yCM
         j/LSXEYkxpOmMciFkt5hoRtbo1cVE1aBCNK3Kb389hOh8GZFPsVwjMPYpA804ILUIT
         w1kuTizQeimA7I+D1wAzKZNQTN00wxnO3+GxbBYx74qbrJZ2cWGGoLsHB4EmnvCkTk
         rJfnHirk21AlzkQV8MRgc5w05bsj7TKv+Xsq65EiURWRutWccsGT+DqGo05FsNkkvm
         VkRnS1330ytF7lrAPbUJynEv/r7SHluJiG5yYSDCFPnUrvNrbHpeMbFQ+eMWbGwF+d
         2uhmaVsTG/RHA==
Date:   Tue, 29 Mar 2022 13:08:06 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com, jlayton@kernel.org
Subject: Re: [PATCH v1 2/3] vfs: strip file's S_ISGID mode on vfs instead of
 on filesystem
Message-ID: <20220329110806.mgdflsavlnc4e6jr@wittgenstein>
References: <1648461389-2225-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1648461389-2225-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1648461389-2225-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 28, 2022 at 05:56:28PM +0800, Yang Xu wrote:
> Currently, vfs only passes mode argument to filesystem, then use inode_init_owner()
> to strip S_ISGID. Some filesystem(ie ext4/btrfs) will call inode_init_owner
> firstly, then posxi acl setup, but xfs uses the contrary order. It will affect
> S_ISGID clear especially umask with S_IXGRP.
> 
> Vfs has all the info it needs - it doesn't need the filesystems to do everything
> correctly with the mode and ensuring that they order things like posix acl setup
> functions correctly with inode_init_owner() to strip the SGID bit.
> 
> Just strip the SGID bit at the VFS, and then the filesystems can't get it wrong.
> 
> Also, the inode_sgid_strip() api should be used before IS_POSIXACL() because
> this api may change mode by using umask but S_ISGID clear isn't related to
> SB_POSIXACL flag.
> 
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

I think adding that helper and using it in the vfs already is a good
idea. But I wonder whether leaving this in inode_init_owner() might be
desirable as well. I don't know how likely it is but if any filesystem
is somehow internally creating a new inode without using vfs_*() helpers
and botches the job then inode_init_owner() would still correctly strip
the setgid bit currently for them.

If we think it's a rather low risk then we can simply move the
strippping completely out of inode_init_owner(). If we think that that's
too risky it might be worth adding a new inode_owner() helper that is
called from inode_init_owner() and that filesystem can be switched to
that we know are safe in that regard?
