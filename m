Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743C525699F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Aug 2020 20:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgH2SE6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 14:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgH2SE6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 14:04:58 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9094C061236
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2020 11:04:57 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kC5Dc-0077NX-5a; Sat, 29 Aug 2020 18:04:48 +0000
Date:   Sat, 29 Aug 2020 19:04:48 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Christian Schoenebeck <qemu_oss@crudebyte.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: xattr names for unprivileged stacking?
Message-ID: <20200829180448.GQ1236603@ZenIV.linux.org.uk>
References: <20200812143323.GF2810@work-vm>
 <27541158.PQPtYaGs59@silver>
 <20200816225620.GA28218@dread.disaster.area>
 <20200816230908.GI17456@casper.infradead.org>
 <20200817002930.GB28218@dread.disaster.area>
 <20200827152207.GJ14765@casper.infradead.org>
 <20200827222457.GB12096@dread.disaster.area>
 <20200829160717.GS14765@casper.infradead.org>
 <20200829161358.GP1236603@ZenIV.linux.org.uk>
 <CAJfpegu2R21CF9PEoj2Cw6x01xmJ+qsff5QTcOcY4G5KEY3R0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegu2R21CF9PEoj2Cw6x01xmJ+qsff5QTcOcY4G5KEY3R0w@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 29, 2020 at 07:51:47PM +0200, Miklos Szeredi wrote:
> On Sat, Aug 29, 2020 at 6:14 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Sat, Aug 29, 2020 at 05:07:17PM +0100, Matthew Wilcox wrote:
> >
> 
> > > > The fact that ADS inodes would not be in the dentry cache and hence
> > > > not visible to pathwalks at all then means that all of the issues
> > > > such as mounting over them, chroot, etc don't exist in the first
> > > > place...
> > >
> > > Wait, you've now switched from "this is dentry cache infrastructure"
> > > to "it should not be in the dentry cache".  So I don't understand what
> > > you're arguing for.
> >
> > Bloody wonderful, that.  So now we have struct file instances with no dentry
> > associated with them?  Which would have to be taken into account all over
> > the place...
> 
> It could have a temporary dentry allocated for the lifetime of the
> file and dropped on last dput.  I.e. there's a dentry, but no cache.
> Yeah, yeah, d_path() issues, however that one will have to be special
> cased anyway.

d_path() is the least of the problems, actually.  Directory tree structure on
those, OTOH, is a serious problem.  If you want to have getdents(2) on that
shite, you want an opened descriptor that looks like a directory.  And _that_
opens a large can of worms.  Because now you have fchdir(2) to cope with,
lookups going through /proc/self/fd/<n>/..., etc., etc.

Al, fully expecting "we'll special-case our way out of everything - how hard
could that be?" in response...
