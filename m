Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1E47912E9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 10:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbjIDIHO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 04:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjIDIHN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:07:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C8CF4;
        Mon,  4 Sep 2023 01:07:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9E7A1CE0E16;
        Mon,  4 Sep 2023 08:07:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D87CC433C7;
        Mon,  4 Sep 2023 08:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693814827;
        bh=18aR+82MNPgu4R0MFGlM/ZazYmgxYtjMznyLEpgnBOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KZUU3avOxbQjNPqpQkVdQi70JSw1kIYFMfR1XJ+J+ys3xbEVAWjYA5Jmd0rCBbgKU
         7PwHyzYYlbvmk+k0L9WQA5qNYWuJ3J4w26Fdsiz/RRoAK0SOPQmxxIhKLZ9Dplp3H+
         86R/D+OJeA3+PtDaN8TlVshHiKj+4jWflohoAm7yW7ZYX2RQ7MdgFZ8EW4a9/E/tWf
         Au0WJfdkat70lzUrmwzLb76e9B3SoOS8+AXTiUNXSij8Nwbw2v8hML55sSLmQ+X1C0
         bZ9pOl46lBG9lPjjLKFICM+h4UEI6YND7htQjwNeZUkTJoF/m2ttfi6uZSCy/2uuoI
         W66GAKuWaWOVw==
Date:   Mon, 4 Sep 2023 10:07:02 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     syzbot <syzbot+629c4f1a4cefe03f8985@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com, jack@suse.cz, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        marc.dionne@auristor.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [afs?] KASAN: slab-use-after-free Read in
 afs_dynroot_test_super
Message-ID: <20230904-sichel-elend-554e68a96d93@brauner>
References: <0000000000003849fc0604607941@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0000000000003849fc0604607941@google.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 02, 2023 at 06:44:17AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1c59d383390f Merge tag 'linux-kselftest-nolibc-6.6-rc1' of..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=13f80797a80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4940ad7c14cda5c7
> dashboard link: https://syzkaller.appspot.com/bug?extid=629c4f1a4cefe03f8985
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115b0c70680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170267b7a80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b6c588f544ac/disk-1c59d383.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/bab40745ca7b/vmlinux-1c59d383.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9a8f42a5537c/bzImage-1c59d383.xz

#syz fix: super: ensure valid info
