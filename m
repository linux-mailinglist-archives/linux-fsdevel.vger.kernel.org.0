Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1EF725C315
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 16:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbgICOoB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 10:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729344AbgICOgg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:36:36 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189C3C061244;
        Thu,  3 Sep 2020 07:36:36 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDqLl-009rJq-3l; Thu, 03 Sep 2020 14:36:29 +0000
Date:   Thu, 3 Sep 2020 15:36:29 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: remove the last set_fs() in common code, and remove it for x86
 and powerpc v3
Message-ID: <20200903143629.GN1236603@ZenIV.linux.org.uk>
References: <20200903142242.925828-1-hch@lst.de>
 <20200903142803.GM1236603@ZenIV.linux.org.uk>
 <20200903143003.GA17260@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903143003.GA17260@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 03, 2020 at 04:30:03PM +0200, Christoph Hellwig wrote:
> On Thu, Sep 03, 2020 at 03:28:03PM +0100, Al Viro wrote:
> > On Thu, Sep 03, 2020 at 04:22:28PM +0200, Christoph Hellwig wrote:
> > 
> > > Besides x86 and powerpc I plan to eventually convert all other
> > > architectures, although this will be a slow process, starting with the
> > > easier ones once the infrastructure is merged.  The process to convert
> > > architectures is roughtly:
> > > 
> > >  (1) ensure there is no set_fs(KERNEL_DS) left in arch specific code
> > >  (2) implement __get_kernel_nofault and __put_kernel_nofault
> > >  (3) remove the arch specific address limitation functionality
> > 
> > The one to really watch out for is sparc; I have something in that
> > direction, will resurrect as soon as I'm done with eventpoll analysis...
> > 
> > I can live with this series; do you want that in vfs.git#for-next?
> 
> Either that or a separate tree is fine with me.  It would be good to
> eventually have a non-rebased stable tree so that other arch trees
> can work from it, though.

FWIW, vfs.git#for-next is always a merge of independent branches; I don't
put stuff directly into #for-next - too easy to lose that way.

IOW, that would be something like #base.set_fs, included into #for-next
merge set.  And I've no problem with never-rebased branches...

Where in the mainline are the most recent prereqs of this series?
