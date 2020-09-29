Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748F727BD45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Sep 2020 08:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbgI2Gqv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Sep 2020 02:46:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbgI2Gqu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Sep 2020 02:46:50 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 198AC20C09;
        Tue, 29 Sep 2020 06:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601362010;
        bh=z1PlfEDRDNoBC/EsAjqTakw7ooTqgEMmSkPYuYZv2pM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yJjvRLOBFLJxQfCjd5cyQuj05zAFGdn1bvzW/JZrxAB4k2LUn3sbWGAV23LAyIstn
         eiMSvPkiz9LCD774QF64FHIghd8sPQaVcaqrpb64QsL8zZw32cyuvyefdbLS2qImuk
         bEANYEu+rpLOGeCOVFGZGNg4K7RGo30bVqxAXf74=
Date:   Mon, 28 Sep 2020 23:46:48 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Laight <David.Laight@aculab.com>,
        syzbot+51177e4144d764827c45@syzkaller.appspotmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: WARNING in __kernel_read (2)
Message-ID: <20200929064648.GA238449@sol.localdomain>
References: <000000000000da992305b02e9a51@google.com>
 <3b3de066852d4e30bd9d85bd28023100@AcuMS.aculab.com>
 <642ed0b4810d44ab97a7832ccb8b3e44@AcuMS.aculab.com>
 <20200928221441.GF1340@sol.localdomain>
 <20200929063815.GB1839@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929063815.GB1839@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 29, 2020 at 08:38:15AM +0200, Christoph Hellwig wrote:
> On Mon, Sep 28, 2020 at 03:14:41PM -0700, Eric Biggers wrote:
> > On Sat, Sep 26, 2020 at 01:17:04PM +0000, David Laight wrote:
> > > From: David Laight
> > > > Sent: 26 September 2020 12:16
> > > > To: 'syzbot' <syzbot+51177e4144d764827c45@syzkaller.appspotmail.com>; linux-fsdevel@vger.kernel.org;
> > > > linux-kernel@vger.kernel.org; syzkaller-bugs@googlegroups.com; viro@zeniv.linux.org.uk
> > > > Subject: RE: WARNING in __kernel_read (2)
> > > > 
> > > > > From: syzbot <syzbot+51177e4144d764827c45@syzkaller.appspotmail.com>
> > > > > Sent: 26 September 2020 03:58
> > > > > To: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; syzkaller-bugs@googlegroups.com;
> > > > > viro@zeniv.linux.org.uk
> > > > > Subject: WARNING in __kernel_read (2)
> > > > 
> > > > I suspect this is calling finit_module() on an fd
> > > > that doesn't have read permissions.
> > > 
> > > Code inspection also seems to imply that the check means
> > > the exec() also requires read permissions on the file.
> > > 
> > > This isn't traditionally true.
> > > suid #! scripts are particularly odd without 'owner read'
> > > (everyone except the owner can run them!).
> > 
> > Christoph, any thoughts here?  You added this WARN_ON_ONCE in:
> > 
> > 	commit 61a707c543e2afe3aa7e88f87267c5dafa4b5afa
> > 	Author: Christoph Hellwig <hch@lst.de>
> > 	Date:   Fri May 8 08:54:16 2020 +0200
> > 
> > 	    fs: add a __kernel_read helper
> 
> Linus asked for it.  What is the call chain that we hit it with?

Call Trace:
 kernel_read+0x52/0x70 fs/read_write.c:471
 kernel_read_file fs/exec.c:989 [inline]
 kernel_read_file+0x2e5/0x620 fs/exec.c:952
 kernel_read_file_from_fd+0x56/0xa0 fs/exec.c:1076
 __do_sys_finit_module+0xe6/0x190 kernel/module.c:4066
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

See the email from syzbot for the full details:
https://lkml.kernel.org/linux-fsdevel/000000000000da992305b02e9a51@google.com
