Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C3977458F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 20:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbjHHSne (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 14:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbjHHSnP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:43:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B2D35DE3;
        Tue,  8 Aug 2023 09:37:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B2386275C;
        Tue,  8 Aug 2023 16:35:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC85C433C8;
        Tue,  8 Aug 2023 16:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691512513;
        bh=OglyjP/H8VfTOrdnqtF1YnIKOG/FDDtzYSix6hdSQFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rJZI0uTNBD7iSHrZlEGmJ74jA5wKkRQCO04tx95nGGRj9f4mHeromUu6S2WYbAJHS
         jy69sAAq9QNqCe0Pco6JoPhv2GGO2wpP8KJiBRApMaTIhoOpp0gDw5KFXXaWbtIT7P
         aDt6ZnRF9xLNq7Ieds7sNfC+J2FEj9IAAsp7vkW2x7zeLPetrXZESZ2rGK/cgye7Ir
         BN0nqzfqpNQ9oAYcme53+Y2kw8iCjOiCPpxVqAx0StEWUd+3t2AwcyMIDkr7MMiwws
         R2XwKz8fk/Hdx4RTB+dRffBM98+oMqpeRZErux9s9F/mzo+6NKOcflIbdZtFZvFb40
         PjhdIvMAo8J/g==
Date:   Tue, 8 Aug 2023 18:35:04 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+26860029a4d562566231@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in
 btrfs_open_devices
Message-ID: <20230808-wohnsiedlung-exerzierplatz-02b1257b97a2@brauner>
References: <0000000000007921d606025b6ad6@google.com>
 <000000000000094846060260e710@google.com>
 <20230808-zentimeter-kappen-5da1e70c5535@brauner>
 <20230808160141.GA15875@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230808160141.GA15875@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 08, 2023 at 06:01:41PM +0200, Christoph Hellwig wrote:
> Yes, probably.  The lifetimes looked fishy to me to start with, but
> this might have made things worse.

It looks like we should be able to just drop that patch.
Ok, are you fixing this or should I drop this patch?

> 
> On Tue, Aug 08, 2023 at 05:50:02PM +0200, Christian Brauner wrote:
> > On Mon, Aug 07, 2023 at 08:24:36PM -0700, syzbot wrote:
> > > syzbot has bisected this issue to:
> > > 
> > > commit 066d64b26a21a5b5c500a30f27f3e4b1959aac9e
> > > Author: Christoph Hellwig <hch@lst.de>
> > > Date:   Wed Aug 2 15:41:23 2023 +0000
> > > 
> > >     btrfs: open block devices after superblock creation
> > > 
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15493371a80000
> > > start commit:   f7dc24b34138 Add linux-next specific files for 20230807
> > > git tree:       linux-next
> > > final oops:     https://syzkaller.appspot.com/x/report.txt?x=17493371a80000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=13493371a80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=d7847c9dca13d6c5
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=26860029a4d562566231
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179704c9a80000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17868ba9a80000
> > > 
> > > Reported-by: syzbot+26860029a4d562566231@syzkaller.appspotmail.com
> > > Fixes: 066d64b26a21 ("btrfs: open block devices after superblock creation")
> > > 
> > > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> > 
> > I think the issue might be that before your patch the lifetime of:
> > @device was aligned with @device->s_fs_info but now that you're dropping
> > the uuid mutex after btrfs_scan_one_device() that isn't true anymore. So
> > it feels like:
> > 
> > P1                                       P2
> > lock_uuid_mutex;
> > device = btrfs_scan_one_device();
> > fs_devices = device->fs_devices;
> > unlock_uuid_mutex;
> >                                          // earlier mount that gets cleaned up
> >                                          lock_uuid_mutex; 
> > 					 btrfs_close_devices(fs_devices);
> >                                          unlock_uuid_mutex;
> > 
> > lock_uuid_mutex;
> > btrfs_open_devices(fs_devices); // UAF
> > unlock_uuid_mutex;
> > 
> > But I'm not entirely sure.
> ---end quoted text---
