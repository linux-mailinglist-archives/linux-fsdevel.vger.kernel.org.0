Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9926233D26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 04:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbgGaCOb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 22:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730904AbgGaCOb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 22:14:31 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0715DC061574;
        Thu, 30 Jul 2020 19:14:30 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1KYy-006321-If; Fri, 31 Jul 2020 02:14:24 +0000
Date:   Fri, 31 Jul 2020 03:14:24 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: add file system helpers that take kernel pointers for the init
 code v4
Message-ID: <20200731021424.GG1236603@ZenIV.linux.org.uk>
References: <20200728163416.556521-1-hch@lst.de>
 <20200729195117.GE951209@ZenIV.linux.org.uk>
 <20200730062524.GA17980@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730062524.GA17980@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 30, 2020 at 08:25:24AM +0200, Christoph Hellwig wrote:
> On Wed, Jul 29, 2020 at 08:51:17PM +0100, Al Viro wrote:
> > On Tue, Jul 28, 2020 at 06:33:53PM +0200, Christoph Hellwig wrote:
> > > Hi Al and Linus,
> > > 
> > > currently a lot of the file system calls in the early in code (and the
> > > devtmpfs kthread) rely on the implicit set_fs(KERNEL_DS) during boot.
> > > This is one of the few last remaining places we need to deal with to kill
> > > off set_fs entirely, so this series adds new helpers that take kernel
> > > pointers.  These helpers are in init/ and marked __init and thus will
> > > be discarded after bootup.  A few also need to be duplicated in devtmpfs,
> > > though unfortunately.
> > >
> > > The series sits on top of my previous
> > > 
> > >   "decruft the early init / initrd / initramfs code v2"
> > 
> > Could you fold the fixes in the parent branch to avoid the bisect hazards?
> > As it is, you have e.g. "initd: pass a non-f_pos offset to kernel_read/kernel_write"
> > that ought to go into "initrd: switch initrd loading to struct file based APIs"...
> 
> I'm not a huge fan of rebasing after it has been out for a long time and
> with pending other patches on top of it.  But at your request I've now
> folded the fixes and force pushed it.

Um...

Christoph Hellwig (28):
[snip]
      initramfs: switch initramfs unpacking to struct file based APIs
      initramfs: switch initramfs unpacking to struct file based APIs
[snip]

It's not a bisect hazard, of course, but if you don't fold those
together, you might at least want to give the second one a different
commit summary...  I hadn't been able to find an analogue of #init_path on
top of that either.

As it is, #init-user-pointers is fine (aside of that SNAFU with unfolded
pair of commits), and so's the contents of #init_path part following what
used to be #init-user-pointers, but it'll be an awful mess on merge in
the current shape.

I can sort it out myself, if you don't mind that; again, I'm OK with
the contents and I've no problem with doing reordering/folding.
