Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E3B286A49
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 23:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgJGVdD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 17:33:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728854AbgJGVcz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 17:32:55 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0434B2083B;
        Wed,  7 Oct 2020 21:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602106375;
        bh=/x/sTo/eJjSQ296lRma1jF5McQ8+RG2igB6SGcnoNr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WOY3O+TrN+cvDQ/hm3RFovBwbNfMijWaOZqhkdXkTxTk3tjnXhgYbL4P6ngbHbFOy
         6cciT4lsiwQl02cBTh93+KLCmNjgJW5N8vvkZyOP3J84CN9/AEtZ86GjpdoG1Z+7M2
         e7RsH7vVKWcK4ICsUNhGBRG8ZVzDjKuu3DzHtzdY=
Date:   Wed, 7 Oct 2020 14:32:53 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        syzbot+ee250ac8137be41d7b13@syzkaller.appspotmail.com
Subject: [f2fs bug] infinite loop in f2fs_get_meta_page_nofail()
Message-ID: <20201007213253.GD1530638@gmail.com>
References: <000000000000432c5405b1113296@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000432c5405b1113296@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[moved linux-fsdevel to Bcc]

On Wed, Oct 07, 2020 at 02:18:19AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a804ab08 Add linux-next specific files for 20201006
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17fe30bf900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=26c1b4cc4a62ccb
> dashboard link: https://syzkaller.appspot.com/bug?extid=ee250ac8137be41d7b13
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1336413b900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f7392b900000
> 
> The issue was bisected to:
> 
> commit eede846af512572b1f30b34f9889d7df64c017d4
> Author: Jaegeuk Kim <jaegeuk@kernel.org>
> Date:   Fri Oct 2 21:17:35 2020 +0000
> 
>     f2fs: f2fs_get_meta_page_nofail should not be failed
> 

Jaegeuk, it looks like the loop you added in the above commit doesn't terminate
if the requested page is beyond the end of the device.

- Eric
