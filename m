Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F441C204C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 May 2020 00:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgEAWEz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 18:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAWEy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 18:04:54 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D516C061A0C;
        Fri,  1 May 2020 15:04:54 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUdm5-00GG8t-Ej; Fri, 01 May 2020 22:04:49 +0000
Date:   Fri, 1 May 2020 23:04:49 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] exec: open code copy_string_kernel
Message-ID: <20200501220449.GQ23230@ZenIV.linux.org.uk>
References: <20200501104105.2621149-1-hch@lst.de>
 <20200501104105.2621149-3-hch@lst.de>
 <20200501141903.5f7b1f81fdd38ae372d91f0e@linux-foundation.org>
 <20200501213048.GO23230@ZenIV.linux.org.uk>
 <20200501144013.be5bf036ab7f2d2303676bce@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501144013.be5bf036ab7f2d2303676bce@linux-foundation.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 01, 2020 at 02:40:13PM -0700, Andrew Morton wrote:
> On Fri, 1 May 2020 22:30:48 +0100 Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > On Fri, May 01, 2020 at 02:19:03PM -0700, Andrew Morton wrote:
> > > On Fri,  1 May 2020 12:41:05 +0200 Christoph Hellwig <hch@lst.de> wrote:
> > > 
> > > > Currently copy_string_kernel is just a wrapper around copy_strings that
> > > > simplifies the calling conventions and uses set_fs to allow passing a
> > > > kernel pointer.  But due to the fact the we only need to handle a single
> > > > kernel argument pointer, the logic can be sigificantly simplified while
> > > > getting rid of the set_fs.
> > > > 
> > > 
> > > I don't get why this is better?  copy_strings() is still there and
> > > won't be going away - what's wrong with simply reusing it in this
> > > fashion?
> > > 
> > > I guess set_fs() is a bit hacky, but there's the benefit of not having
> > > to maintain two largely similar bits of code?
> > 
> > Killing set_fs() would be a very good thing...
> 
> Why is that?  And is there a project afoot to do this?

Long story - basically, it's been a source of massive headache too many times.
No formal project, but there are several people (me, Arnd, Christoph) who'd
been reducing its use.  For more than a decade now, I think...

FWIW, I doubt that it will be entirely killable; Christoph appears to be
more optimistic.  In any case, its use has been greatly reduced and having
it narrowed down to even fewer places would be a good thing.

In the same direction: use_mm()/unuse_mm() regularization wrt set_fs(), getting
rid of it in coredump code, some movements towards killing ioctl_by_bdev();
not sure if I've spotted everything - Christoph?
