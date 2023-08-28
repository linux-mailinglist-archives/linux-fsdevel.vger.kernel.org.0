Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6554878B27D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 16:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjH1ODQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 10:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjH1ODM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:03:12 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C396F7
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 07:03:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5A8326732A; Mon, 28 Aug 2023 16:03:07 +0200 (CEST)
Date:   Mon, 28 Aug 2023 16:03:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org,
        syzbot+5b64180f8d9e39d3f061@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/2] super: ensure valid info
Message-ID: <20230828140307.GB19777@lst.de>
References: <20230828-vfs-super-fixes-v1-0-b37a4a04a88f@kernel.org> <20230828-vfs-super-fixes-v1-2-b37a4a04a88f@kernel.org> <20230828120418.GB10189@lst.de> <20230828-farbkombinationen-gedruckt-6da10079c586@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828-farbkombinationen-gedruckt-6da10079c586@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 28, 2023 at 02:28:48PM +0200, Christian Brauner wrote:
> > Maybe I didn't read the commit log carefully enough, but why do we
> > need to call kill_super_notify before free_anon_bdev and any potential
> > action in ->kill_sb after calling kill_anon_super here given that
> > we already add a call to kill_super_notify after ->kill_sb?
> 
> Yeah, the commit log explains this. We leave the superblock on fs_supers
> past sb->kill_sb() and notify after device closure. For block based
> filesystems that's the correct thing. They don't rely on sb->s_fs_info
> and we need to ensure that all devices are closed.
> 
> But for filesystems like kernfs that rely on get_keyed_super() they rely
> on sb->s_fs_info to recycle sbs. sb->s_fs_info is currently always freed
> in sb->kill_sb()
> 
> kernfs_kill_sb()
> -> kill_anon_super()
>    -> kfree(info)
> 
> For such fses sb->s_fs_info is freed with the superblock still on
> fs_supers which means we get a UAF when the sb is still found on the
> list. So for such filesystems we need to remove and notify before
> sb->s_fs_info is freed. That's done in kill_anon_super(). For such
> filesystems the call in deactivate_locked_super() is a nop.

Ok, so I did fail to parse the commit log.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
