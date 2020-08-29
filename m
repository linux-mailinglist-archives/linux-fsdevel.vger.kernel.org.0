Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FD32569AF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Aug 2020 20:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgH2SW3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 14:22:29 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:60337 "EHLO
        lizzy.crudebyte.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgH2SWW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 14:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=RBT0jy45C4CxuJ7VmhILa98UnWCiZPik8JEnoIEEsgo=; b=C7Fekp7AnpK49B/XSKUPK9lQMn
        TalJ2kBqXqtGh9uAhv1iyaQkp6BM0WV5p545nJZDLqxfBZY5eFUWYkrW88jCJMtu2knjeZ+h5K6oN
        XREH9zh1Ux15+lmRLsFzxOuO0f9EkfSi3GUut3eRlg39h81/FGf5fTAoD3++rbjjz1cMoN8BfMWNw
        GYrmdVpTTAYmB4L1/IjxSwh87Fr8DZqFh6iZ3nXxqFi4KP06ksqC+OIEix/nlUlStIxlT4WcHJB9f
        jcgrX8A24q8ut6PQa4u6dx3mHfCsag0jQVoO1coHpiOKibpjcu1vkLwMyqP9/x7mjfSr3DHyL0Fyy
        lYZfGWhQ==;
From:   Christian Schoenebeck <qemu_oss@crudebyte.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: xattr names for unprivileged stacking?
Date:   Sat, 29 Aug 2020 20:22:09 +0200
Message-ID: <2468509.22xg9qcgnq@silver>
In-Reply-To: <20200829180448.GQ1236603@ZenIV.linux.org.uk>
References: <20200812143323.GF2810@work-vm> <CAJfpegu2R21CF9PEoj2Cw6x01xmJ+qsff5QTcOcY4G5KEY3R0w@mail.gmail.com> <20200829180448.GQ1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Samstag, 29. August 2020 20:04:48 CEST Al Viro wrote:
> On Sat, Aug 29, 2020 at 07:51:47PM +0200, Miklos Szeredi wrote:
> > On Sat, Aug 29, 2020 at 6:14 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > On Sat, Aug 29, 2020 at 05:07:17PM +0100, Matthew Wilcox wrote:
> > > > > The fact that ADS inodes would not be in the dentry cache and hence
> > > > > not visible to pathwalks at all then means that all of the issues
> > > > > such as mounting over them, chroot, etc don't exist in the first
> > > > > place...
> > > > 
> > > > Wait, you've now switched from "this is dentry cache infrastructure"
> > > > to "it should not be in the dentry cache".  So I don't understand what
> > > > you're arguing for.
> > > 
> > > Bloody wonderful, that.  So now we have struct file instances with no
> > > dentry associated with them?  Which would have to be taken into account
> > > all over the place...
> > 
> > It could have a temporary dentry allocated for the lifetime of the
> > file and dropped on last dput.  I.e. there's a dentry, but no cache.
> > Yeah, yeah, d_path() issues, however that one will have to be special
> > cased anyway.
> 
> d_path() is the least of the problems, actually.  Directory tree structure
> on those, OTOH, is a serious problem.  If you want to have getdents(2) on
> that shite, you want an opened descriptor that looks like a directory.  And
> _that_ opens a large can of worms.  Because now you have fchdir(2) to cope
> with, lookups going through /proc/self/fd/<n>/..., etc., etc.
> 
> Al, fully expecting "we'll special-case our way out of everything - how hard
> could that be?" in response...

Independent of what and how all this is presented to user space, I think all 
this will only ever land if it does not deviate too much from the existing 
unified VFS model.

The most relevant change that I see is that (probably similar to Miklos) that 
a user visible file(/dir) kernel internally links a dedicated directory which 
contains the streams, but as far as the kernel is concerned, that's a 
directory, streams are files, they are still inodes, and they are still part 
of the dentry cache, etc.

Starting to handle ADS streams as some completely separate new thing in the 
model will most certainly just end up with much more code and problems than 
adding filters here and there for making certain things inaccessible from user 
space (e.g. prohibiting chdir() into that special directory, prevent mounting 
things onto ADS files, ot whatever other presentation measures might be 
desired for security reasons).

And no: stat(mainfile) must still return the block count of the main stream 
only, not any aggregated data, otherwise it will break user space. Thinks like 
'du' must explicitly be made ADS aware instead.

Best regards,
Christian Schoenebeck


