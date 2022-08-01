Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B64D587238
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 22:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbiHAURR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 16:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbiHAURP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:17:15 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCA3F3;
        Mon,  1 Aug 2022 13:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=MihrIX9xxvINQlzJRyOqidEAph+Kwa/bRg0s8UIamnE=; b=mxhnwtvgx+0+syKlnHdO8Z3zpr
        VNwIanjB6XZoSEYWbltm6x08K41JRuPBN5YzAEr6gsnYu/omqIUDHE4xeF6tFixGgGX//IdDO8CM2
        gt0Ph7VCZz/2RqENLfJSGfFQtMco7AkcfRoZif0SRHVXhAOQbb37NCxWRWWHLn5KAR96AiuVw6j9U
        CqwUGpGOfGqWtNBx4iDNDKbZx/bCkepbnFJ0Y7R/oN00KkeHUWxk83nM6vi9bDidXMSyegQ7IHPQQ
        qIurF0EpHxm8RHdHWJb5TxHQfTdFPNhuiNyEvg2dNUAQZYD8E1+kYhzSPfo1FuEtTXE+jxWgx05Ze
        zN0iLC7w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oIbqh-000P26-2F;
        Mon, 01 Aug 2022 20:17:11 +0000
Date:   Mon, 1 Aug 2022 21:17:11 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] vfs.git pile 1 - namei stuff
Message-ID: <Yug0x5GvaInf3opV@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-work.namei

for you to fetch changes up to 3bd8bc897161730042051cd5f9c6ed1e94cb5453:

  step_into(): move fetching ->d_inode past handle_mounts() (2022-07-06 13:16:07 -0400)

----------------------------------------------------------------
	RCU pathwalk cleanups.  Storing sampled ->d_seq of
the next dentry in nameidata simplifies life considerably,
especially if we delay fetching ->d_inode until step_into().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (10):
      __follow_mount_rcu(): verify that mount_lock remains unchanged
      namei: get rid of pointless unlikely(read_seqcount_retry(...))
      follow_dotdot{,_rcu}(): change calling conventions
      switch try_to_unlazy_next() to __legitimize_mnt()
      namei: move clearing LOOKUP_RCU towards rcu_read_unlock()
      namei: stash the sampled ->d_seq into nameidata
      step_into(): lose inode argument
      follow_dotdot{,_rcu}(): don't bother with inode
      lookup_fast(): don't bother with inode
      step_into(): move fetching ->d_inode past handle_mounts()

 fs/mount.h     |   1 -
 fs/namei.c     | 191 +++++++++++++++++++++++++--------------------------------
 fs/namespace.c |   2 +-
 3 files changed, 86 insertions(+), 108 deletions(-)
