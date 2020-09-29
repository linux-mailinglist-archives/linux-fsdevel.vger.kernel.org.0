Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687B527BD3C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Sep 2020 08:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgI2GiR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Sep 2020 02:38:17 -0400
Received: from verein.lst.de ([213.95.11.211]:38344 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgI2GiR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Sep 2020 02:38:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 47E336736F; Tue, 29 Sep 2020 08:38:15 +0200 (CEST)
Date:   Tue, 29 Sep 2020 08:38:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        David Laight <David.Laight@aculab.com>,
        syzbot+51177e4144d764827c45@syzkaller.appspotmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: WARNING in __kernel_read (2)
Message-ID: <20200929063815.GB1839@lst.de>
References: <000000000000da992305b02e9a51@google.com> <3b3de066852d4e30bd9d85bd28023100@AcuMS.aculab.com> <642ed0b4810d44ab97a7832ccb8b3e44@AcuMS.aculab.com> <20200928221441.GF1340@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928221441.GF1340@sol.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 28, 2020 at 03:14:41PM -0700, Eric Biggers wrote:
> On Sat, Sep 26, 2020 at 01:17:04PM +0000, David Laight wrote:
> > From: David Laight
> > > Sent: 26 September 2020 12:16
> > > To: 'syzbot' <syzbot+51177e4144d764827c45@syzkaller.appspotmail.com>; linux-fsdevel@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; syzkaller-bugs@googlegroups.com; viro@zeniv.linux.org.uk
> > > Subject: RE: WARNING in __kernel_read (2)
> > > 
> > > > From: syzbot <syzbot+51177e4144d764827c45@syzkaller.appspotmail.com>
> > > > Sent: 26 September 2020 03:58
> > > > To: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; syzkaller-bugs@googlegroups.com;
> > > > viro@zeniv.linux.org.uk
> > > > Subject: WARNING in __kernel_read (2)
> > > 
> > > I suspect this is calling finit_module() on an fd
> > > that doesn't have read permissions.
> > 
> > Code inspection also seems to imply that the check means
> > the exec() also requires read permissions on the file.
> > 
> > This isn't traditionally true.
> > suid #! scripts are particularly odd without 'owner read'
> > (everyone except the owner can run them!).
> 
> Christoph, any thoughts here?  You added this WARN_ON_ONCE in:
> 
> 	commit 61a707c543e2afe3aa7e88f87267c5dafa4b5afa
> 	Author: Christoph Hellwig <hch@lst.de>
> 	Date:   Fri May 8 08:54:16 2020 +0200
> 
> 	    fs: add a __kernel_read helper

Linus asked for it.  What is the call chain that we hit it with?
