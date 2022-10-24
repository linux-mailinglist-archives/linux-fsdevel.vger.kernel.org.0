Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABE460983F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 04:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJXCf5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Oct 2022 22:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiJXCfz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Oct 2022 22:35:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C6058149;
        Sun, 23 Oct 2022 19:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1+M0C9J3MwcVvah0KT62unV/jmKo053Y3vHawSUO1dA=; b=M0hL9qCULr4VeykagKNZElQTHv
        hkJTUkL1dEcHfGYKuqw9Q/AFSEqcb4IWWbqJ9dXaBOS9pFc6aSDMcHcxuqM8Ul8nruYKOE31IfBHm
        3JLVKEVTI2Ay4RlrDnHEzzfUc8hLJ9bK7v3EjnbfgPAliT75I4pqUL9L5BO4UIkRKn9Edvr5jAkEy
        mob+SrZGBS4ZwL5V9bGgWSDrPey2NgJmfpcEkQ4gJabJi8aOCx3HUFGRYG0aDWfHkcajYLUpEXSaJ
        cj+Cisu6XmLZoj0EG8oehvgaKEUGpC61FPW93hQfOLR1W063pFoRpQYA3/rZOCjdA+AuLgQ07WhZB
        eoYxHhMw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1omnJh-00F7ys-Co; Mon, 24 Oct 2022 02:35:53 +0000
Date:   Mon, 24 Oct 2022 03:35:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+9c8140e9162432b9eb20@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] inconsistent lock state in _atomic_dec_and_lock
Message-ID: <Y1X6CY0ZoM9/HuNf@casper.infradead.org>
References: <000000000000cd8af105ebb7e570@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000cd8af105ebb7e570@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 23, 2022 at 11:32:30AM -0700, syzbot wrote:
> ================================
> WARNING: inconsistent lock state
> 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0 Not tainted
> --------------------------------
> inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> syz-executor.3/9712 [HC0[0]:SC0[0]:HE1:SE1] takes:
> ffff0000d10c2577 (&folio_wait_table[i]){?.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
> ffff0000d10c2577 (&folio_wait_table[i]){?.-.}-{2:2}, at: _atomic_dec_and_lock+0xc8/0x130 lib/dec_and_lock.c:28
> {IN-HARDIRQ-W} state was registered at:
>   lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
>   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>   _raw_spin_lock_irqsave+0x6c/0xb4 kernel/locking/spinlock.c:162
>   folio_wake_bit+0x88/0x254 mm/filemap.c:1143

This is clearly complete garbage.  If we're using spin_lock_irqsave(),
then we can't have a {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} problem.

> stack backtrace:
> CPU: 1 PID: 9712 Comm: syz-executor.3 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
> Call trace:
>  dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
>  show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
>  dump_stack+0x1c/0x58 lib/dump_stack.c:113
>  print_usage_bug+0x39c/0x3cc kernel/locking/lockdep.c:3961
>  mark_lock_irq+0x4a8/0x4b4
>  mark_lock+0x154/0x1b4 kernel/locking/lockdep.c:4632
>  mark_usage kernel/locking/lockdep.c:4541 [inline]
>  __lock_acquire+0x5f8/0x30a4 kernel/locking/lockdep.c:5007
>  lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
>  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>  _raw_spin_lock+0x54/0x6c kernel/locking/spinlock.c:154
>  spin_lock include/linux/spinlock.h:349 [inline]
>  _atomic_dec_and_lock+0xc8/0x130 lib/dec_and_lock.c:28
>  iput+0x50/0x324 fs/inode.c:1766
>  ntfs_fill_super+0x1254/0x14a4 fs/ntfs3/super.c:1190

Oh.  ntfs probably corrupted the lockdep state.  Also, this is
a completely different lock from the first one.  So I'm going to
ignore this report.
