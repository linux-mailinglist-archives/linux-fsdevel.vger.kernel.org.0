Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 569BECEC9B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 21:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbfJGTTV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 15:19:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbfJGTTV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:19:21 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FCE92070B;
        Mon,  7 Oct 2019 19:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570475960;
        bh=efUUidLReXlgZH1SzPTDouesSbtgzzkvWDaHCE2GJOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SthwJhFld0F1fA0uA2kRrAX2XVsQ4Y4S2F2Ers2HXtFDNh0L/OKq7AsxSI16RKWYd
         WKmmm/GxLS0Auzgqn3sNNZuiLDjaTyb9mA5sB9bhah0wmOs6BTDuUr3y0OT4sl38vP
         s0DjYWr13zz2HaJ2od7wIeAmMJT3bdqZp6QGDh1Q=
Date:   Mon, 7 Oct 2019 12:19:19 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+3031f712c7ad5dd4d926@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: WARNING in filldir64
Message-ID: <20191007191918.GD16653@gmail.com>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+3031f712c7ad5dd4d926@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <0000000000006b7bfb059452e314@google.com>
 <20191007190747.GA16653@gmail.com>
 <CAHk-=whtA4bWH=8xY8TAejDR4XyHDux0xH7_y-0jzft0XkvMfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whtA4bWH=8xY8TAejDR4XyHDux0xH7_y-0jzft0XkvMfw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 07, 2019 at 12:14:33PM -0700, Linus Torvalds wrote:
> On Mon, Oct 7, 2019 at 12:07 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > Seems this indicates a corrupt filesystem rather than a kernel bug, so using
> > WARN_ON is not appropriate.  It should either use pr_warn_once(), or be silent.
> 
> I was going to silence it for the actual 5.4 release, but I wanted to
> see if anybody actually triggers it.
> 
> I didn't really _expect_ it to be triggered, to be honest, so it's
> interesting that it did. What is syzbot doing?
> 
> If this is syzbot doing filesystem image randomization, then it falls
> under "ok, expected, ignore it, we'll silence it for 5.4"
> 
> But if it's syzbot doing something else, then it would be interesting
> to hear what it's up to.
> 

It got there via fat_readdir(), and in the console log there is:

syz_mount_image$vfat(&(0x7f0000000540)='vfat\x00', &(0x7f00000002c0)='./file0\x00', 0x800000000e004, 0x1, &(0x7f0000000140)=[{&(0x7f0000010000)="eb3c906d6b66732e666174000204010002000270fff8", 0x16}], 0x0, 0x0)

So it seems to have generated a corrupt filesystem image and tried to mount it.

- Eric
