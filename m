Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B76769765
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 15:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjGaNWi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 09:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjGaNWg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:22:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAB410DF;
        Mon, 31 Jul 2023 06:22:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C847461138;
        Mon, 31 Jul 2023 13:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EC2C433C7;
        Mon, 31 Jul 2023 13:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690809754;
        bh=W88KIO1EGaih8WBv3amMc7NCSgZQDPxMZgc6sGJqxMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JDO1ONd6KSm0JmgLpI+0me23J0iuXRF6IR/rPcbY6loYRsnutr1iAqtzj/fv7cN0r
         RQjqW/oFiOX5qgUaaHNLFmgfDDde/sDVD0P+6fVpJeb3NROz48QOKmqT0AVJuUGrda
         ygN7MEzS6dzS7BPF3qo1q1F3gb2APHQbHjq4zIDnNfy8mHwTVxkbz0OXP+bpM0yRrk
         qvVOBDXCSEPGpJCSB/Tn2sabXgJrr/e6reXkemMlLRZKP8UgUa8Cof+i6YblOhdEzG
         VzxeI23zgoc4FEEwKQR1cUf1Au+e0y1B9GPGepFPaTH5/kn/mGJ95h5RuFHYt3TN5r
         4Caq9hPCJesgQ==
Date:   Mon, 31 Jul 2023 15:22:28 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        syzbot <syzbot+69c477e882e44ce41ad9@syzkaller.appspotmail.com>,
        chao@kernel.org, huyue2@coolpad.com, jack@suse.cz,
        jefflexu@linux.alibaba.com, linkinjeon@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com, xiang@kernel.org
Subject: Re: [syzbot] [erofs?] [fat?] WARNING in erofs_kill_sb
Message-ID: <20230731-unbeirrbar-kochen-761422d57ffc@brauner>
References: <000000000000f43cab0601c3c902@google.com>
 <20230731093744.GA1788@lst.de>
 <9b57e5f7-62b6-fd65-4dac-a71c9dc08abc@linux.alibaba.com>
 <20230731111622.GA3511@lst.de>
 <20230731-augapfel-penibel-196c3453f809@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230731-augapfel-penibel-196c3453f809@brauner>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 31, 2023 at 02:43:39PM +0200, Christian Brauner wrote:
> On Mon, Jul 31, 2023 at 01:16:22PM +0200, Christoph Hellwig wrote:
> > On Mon, Jul 31, 2023 at 06:58:14PM +0800, Gao Xiang wrote:
> > > Previously, deactivate_locked_super() or .kill_sb() will only be
> > > called after fill_super is called, and .s_magic will be set at
> > > the very beginning of erofs_fc_fill_super().
> > >
> > > After ("fs: open block device after superblock creation"), such
> > > convension is changed now.  Yet at a quick glance,
> > >
> > > WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
> > >
> > > in erofs_kill_sb() can be removed since deactivate_locked_super()
> > > will also be called if setup_bdev_super() is falled.  I'd suggest
> > > that removing this WARN_ON() in the related commit, or as
> > > a following commit of the related branch of the pull request if
> > > possible.
> > 
> > Agreed.  I wonder if we should really call into ->kill_sb before
> > calling into fill_super, but I need to carefull look into the
> > details.
> 
> I think checking for s_magic in erofs kill sb is wrong as it introduces
> a dependency on both fill_super() having been called and that s_magic is
> initialized first. If someone reorders erofs_kill_sb() such that s_magic
> is only filled in once everything else succeeded it would cause the same
> bug. That doesn't sound nice to me.
> 
> I think ->fill_super() should only be called after successfull
> superblock allocation and after the device has been successfully opened.
> Just as this code does now. So ->kill_sb() should only be called after
> we're guaranteed that ->fill_super() has been called.
> 
> We already mostly express that logic through the fs_context object.
> Anything that's allocated in fs_context->init_fs_context() is freed in
> fs_context->free() before fill_super() is called. After ->fill_super()
> is called fs_context->s_fs_info will have been transferred to
> sb->s_fs_info and will have to be killed via ->kill_sb().
> 
> Does that make sense?

Uh, no. I vasty underestimated how sensitive that change would be. Plus
arguably ->kill_sb() really should be callable once the sb is visible.

Are you looking into this or do you want me to, Christoph?
