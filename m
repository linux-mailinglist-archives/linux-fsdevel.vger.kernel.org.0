Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF08D773E1D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 18:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjHHQZ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 12:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjHHQYk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:24:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E69AD1E;
        Tue,  8 Aug 2023 08:50:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67E6462554;
        Tue,  8 Aug 2023 15:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3ADC433C9;
        Tue,  8 Aug 2023 15:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691509807;
        bh=JZiMsyoPwkFmMhtttIsSy3AUmzZ28k2bu8qoF+PP5sA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ScW4SI63uadc6rKvRMJkRyDckC1GCJLBsTijjCG3hyr2JKq6Q3LdTLFtyhTD2v6fT
         hPUy1I3bY598V25Gc6EShna72C6B1gh1KkITueveEfkPlRnG5UObiWm+5Yx2WE44qM
         76x9uxLIWxIa7gF9et9UxuSMMVdcmpDt5FgklWV1Ppg/lehKZJMrWJO1Cstxq28PR+
         ZTci3ykY3u5qMJr0ASzw207P14+tjdmbhPsw6pd+OGaZOotZz3StANUhrRx+ioIdae
         Bqa9PHR8zF6sAZ7PcYzNOhMG7wszOrbM/Om2OTjUo1RxaGVe7HQntTB5rcKV5i+Q5l
         khruvzoBVpnug==
Date:   Tue, 8 Aug 2023 17:50:02 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     hch@lst.de
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+26860029a4d562566231@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in
 btrfs_open_devices
Message-ID: <20230808-zentimeter-kappen-5da1e70c5535@brauner>
References: <0000000000007921d606025b6ad6@google.com>
 <000000000000094846060260e710@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000094846060260e710@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 07, 2023 at 08:24:36PM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 066d64b26a21a5b5c500a30f27f3e4b1959aac9e
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Wed Aug 2 15:41:23 2023 +0000
> 
>     btrfs: open block devices after superblock creation
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15493371a80000
> start commit:   f7dc24b34138 Add linux-next specific files for 20230807
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=17493371a80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=13493371a80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d7847c9dca13d6c5
> dashboard link: https://syzkaller.appspot.com/bug?extid=26860029a4d562566231
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179704c9a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17868ba9a80000
> 
> Reported-by: syzbot+26860029a4d562566231@syzkaller.appspotmail.com
> Fixes: 066d64b26a21 ("btrfs: open block devices after superblock creation")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

I think the issue might be that before your patch the lifetime of:
@device was aligned with @device->s_fs_info but now that you're dropping
the uuid mutex after btrfs_scan_one_device() that isn't true anymore. So
it feels like:

P1                                       P2
lock_uuid_mutex;
device = btrfs_scan_one_device();
fs_devices = device->fs_devices;
unlock_uuid_mutex;
                                         // earlier mount that gets cleaned up
                                         lock_uuid_mutex; 
					 btrfs_close_devices(fs_devices);
                                         unlock_uuid_mutex;

lock_uuid_mutex;
btrfs_open_devices(fs_devices); // UAF
unlock_uuid_mutex;

But I'm not entirely sure.
