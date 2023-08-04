Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F649770162
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 15:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjHDNYF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 09:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjHDNWp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:22:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEB059FA;
        Fri,  4 Aug 2023 06:21:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0BDD61FD0;
        Fri,  4 Aug 2023 13:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD21C433C8;
        Fri,  4 Aug 2023 13:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691155250;
        bh=FNQzWR1EmyB4sM/Ep/jQ04mYJeLIQNADZPFxaAXkUng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xmt9NmujMlPq+o5h/h45BzLQAIy0cHS+35NvEwOwHGDVMuUBzFEb9cCEXbjxcA8mu
         tc+VxynSlto+VfAbHaqJg81/bfDni6MNogtJ/4ZHzlHkKLSyzX5lBamnAQE3fix7Gl
         OgPzOPYt19jlQ7rip7qovbyV99I6MIldSnvx/BMZeSPsq6ILFsFj9s3iVFO5MCzP2y
         4OtHn7qEt42+D/NATXIjWTNLMPZBtSteJuhjueGo0bfIuxghyskcZ3SB4SYNbLut3t
         QjIqQhemLCgxo52TdtePBlFfppKiSHnA6pVXHOn0lyRT8Ski0V4oKM+tmXJ7GpK2GL
         iFTkgx7TJeZZg==
Date:   Fri, 4 Aug 2023 15:20:45 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     syzbot <syzbot+2faac0423fdc9692822b@syzkaller.appspotmail.com>,
        jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in
 test_bdev_super_fc
Message-ID: <20230804-abstieg-behilflich-eda2ce9c2c0f@brauner>
References: <00000000000058d58e06020c1cab@google.com>
 <20230804101408.GA23274@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230804101408.GA23274@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 04, 2023 at 12:14:08PM +0200, Christoph Hellwig wrote:
> FYI, I can reproduce this trivially locally, but even after spending a
> significant time with the trace I'm still puzzled at what is going
> on.  I've started trying to make sense of the lockdep report about
> returning to userspace with s_umount held, originall locked in
> get_tree_bdev and am still missing how it could happen.

So in the old scheme:

s = alloc_super()
-> down_write_nested(&s->s_umount, SINGLE_DEPTH_NESTING);

and assume you're not finding an old one immediately afterwards you'd

-> spin_lock(&sb_lock)

static int set_bdev_super(struct super_block *s, void *data)
{
        s->s_bdev = data;
        s->s_dev = s->s_bdev->bd_dev;
        s->s_bdi = bdi_get(s->s_bdev->bd_disk->bdi);

        if (bdev_stable_writes(s->s_bdev))
                s->s_iflags |= SB_I_STABLE_WRITES;
        return 0;
}

-> spin_unlock(&sb_lock)

in the new scheme you're doing:

s = alloc_super()
-> down_write_nested(&s->s_umount, SINGLE_DEPTH_NESTING);

and assume you're not finding an old one immediately afterwards you'd

up_write(&s->s_umount);

error = setup_bdev_super(s, fc->sb_flags, fc);
-> spin_lock(&sb_lock);
   sb->s_bdev = bdev;
   sb->s_bdi = bdi_get(bdev->bd_disk->bdi);
   if (bdev_stable_writes(bdev))
           sb->s_iflags |= SB_I_STABLE_WRITES;
-> spin_unlock(&sb_lock);

down_write(&s->s_umount);

Which looks like the lock ordering here is changed?
