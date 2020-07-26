Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A241A22E130
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 18:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgGZQVW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 12:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgGZQVW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 12:21:22 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D4BC0619D2;
        Sun, 26 Jul 2020 09:21:22 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzjOk-0035cA-0j; Sun, 26 Jul 2020 16:21:14 +0000
Date:   Sun, 26 Jul 2020 17:21:13 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: add file system helpers that take kernel pointers for the init
 code v3
Message-ID: <20200726162113.GR2786714@ZenIV.linux.org.uk>
References: <20200726071356.287160-1-hch@lst.de>
 <CAHk-=wgq8evViJD9Hnjugq=V0eUAn7K6ZjOP7P7qki-nOTx_jg@mail.gmail.com>
 <20200726155204.GA24103@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726155204.GA24103@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 26, 2020 at 05:52:04PM +0200, Christoph Hellwig wrote:
> On Sun, Jul 26, 2020 at 08:49:28AM -0700, Linus Torvalds wrote:
> > On Sun, Jul 26, 2020 at 12:14 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > Hi Al and Linus,
> > >
> > > currently a lot of the file system calls in the early in code (and the
> > > devtmpfs kthread) rely on the implicit set_fs(KERNEL_DS) during boot.
> > > This is one of the few last remaining places we need to deal with to kill
> > > off set_fs entirely, so this series adds new helpers that take kernel
> > > pointers.  These helpers are in init/ and marked __init and thus will
> > > be discarded after bootup.  A few also need to be duplicated in devtmpfs,
> > > though unfortunately.
> > 
> > I see nothing objectionable here.
> > 
> > The only bikeshed comment I have is that I think the "for_init.c" name
> > is ugly and pointless - I think you could just call it "fs/init.c" and
> > it's both simpler and more straightforward. It _is_ init code, it's
> > not "for" init.
> 
> That was Al's suggestion.  I personally don't care, so if between the
> two of you, you can come up with a preferred choice I'll switch to it.

I can live with either variant; the only problem with fs/init.c is that
such name would imply the init code _of_ VFS, rather than VFS helpers for
init.

Anyway, the series looks generally sane; if no other objections are raised,
I'm adding it to vfs.git#for-next
