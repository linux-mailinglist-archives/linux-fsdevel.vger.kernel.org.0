Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B56127BD75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Sep 2020 08:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgI2G4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Sep 2020 02:56:04 -0400
Received: from verein.lst.de ([213.95.11.211]:38389 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgI2G4E (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Sep 2020 02:56:04 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 68CB46736F; Tue, 29 Sep 2020 08:56:01 +0200 (CEST)
Date:   Tue, 29 Sep 2020 08:56:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        David Laight <David.Laight@aculab.com>,
        syzbot+51177e4144d764827c45@syzkaller.appspotmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: WARNING in __kernel_read (2)
Message-ID: <20200929065601.GA2095@lst.de>
References: <000000000000da992305b02e9a51@google.com> <3b3de066852d4e30bd9d85bd28023100@AcuMS.aculab.com> <642ed0b4810d44ab97a7832ccb8b3e44@AcuMS.aculab.com> <20200928221441.GF1340@sol.localdomain> <20200929063815.GB1839@lst.de> <20200929064648.GA238449@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929064648.GA238449@sol.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 28, 2020 at 11:46:48PM -0700, Eric Biggers wrote:
> > Linus asked for it.  What is the call chain that we hit it with?
> 
> Call Trace:
>  kernel_read+0x52/0x70 fs/read_write.c:471
>  kernel_read_file fs/exec.c:989 [inline]
>  kernel_read_file+0x2e5/0x620 fs/exec.c:952
>  kernel_read_file_from_fd+0x56/0xa0 fs/exec.c:1076
>  __do_sys_finit_module+0xe6/0x190 kernel/module.c:4066
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> See the email from syzbot for the full details:
> https://lkml.kernel.org/linux-fsdevel/000000000000da992305b02e9a51@google.com

Passing a fs without read permissions definitively looks bogus for
the finit_module syscall.  So I think all we need is an extra check
to validate the fd.
