Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33607740A4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 19:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjHHRHa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 13:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbjHHRGb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:06:31 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430085F860;
        Tue,  8 Aug 2023 09:02:44 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CBBB967373; Tue,  8 Aug 2023 18:01:41 +0200 (CEST)
Date:   Tue, 8 Aug 2023 18:01:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     hch@lst.de, clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+26860029a4d562566231@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in
 btrfs_open_devices
Message-ID: <20230808160141.GA15875@lst.de>
References: <0000000000007921d606025b6ad6@google.com> <000000000000094846060260e710@google.com> <20230808-zentimeter-kappen-5da1e70c5535@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808-zentimeter-kappen-5da1e70c5535@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,GB_FAKE_RF_SHORT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Yes, probably.  The lifetimes looked fishy to me to start with, but
this might have made things worse.

On Tue, Aug 08, 2023 at 05:50:02PM +0200, Christian Brauner wrote:
> On Mon, Aug 07, 2023 at 08:24:36PM -0700, syzbot wrote:
> > syzbot has bisected this issue to:
> > 
> > commit 066d64b26a21a5b5c500a30f27f3e4b1959aac9e
> > Author: Christoph Hellwig <hch@lst.de>
> > Date:   Wed Aug 2 15:41:23 2023 +0000
> > 
> >     btrfs: open block devices after superblock creation
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15493371a80000
> > start commit:   f7dc24b34138 Add linux-next specific files for 20230807
> > git tree:       linux-next
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=17493371a80000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13493371a80000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=d7847c9dca13d6c5
> > dashboard link: https://syzkaller.appspot.com/bug?extid=26860029a4d562566231
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179704c9a80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17868ba9a80000
> > 
> > Reported-by: syzbot+26860029a4d562566231@syzkaller.appspotmail.com
> > Fixes: 066d64b26a21 ("btrfs: open block devices after superblock creation")
> > 
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> I think the issue might be that before your patch the lifetime of:
> @device was aligned with @device->s_fs_info but now that you're dropping
> the uuid mutex after btrfs_scan_one_device() that isn't true anymore. So
> it feels like:
> 
> P1                                       P2
> lock_uuid_mutex;
> device = btrfs_scan_one_device();
> fs_devices = device->fs_devices;
> unlock_uuid_mutex;
>                                          // earlier mount that gets cleaned up
>                                          lock_uuid_mutex; 
> 					 btrfs_close_devices(fs_devices);
>                                          unlock_uuid_mutex;
> 
> lock_uuid_mutex;
> btrfs_open_devices(fs_devices); // UAF
> unlock_uuid_mutex;
> 
> But I'm not entirely sure.
---end quoted text---
