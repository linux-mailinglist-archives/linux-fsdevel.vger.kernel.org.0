Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00DC241C16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 16:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgHKOIo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 10:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgHKOIm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 10:08:42 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2557CC06174A;
        Tue, 11 Aug 2020 07:08:42 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5Ux7-00DbzY-IB; Tue, 11 Aug 2020 14:08:33 +0000
Date:   Tue, 11 Aug 2020 15:08:33 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: file metadata via fs API  (was: [GIT PULL] Filesystem
 Information)
Message-ID: <20200811140833.GH1236603@ZenIV.linux.org.uk>
References: <1842689.1596468469@warthog.procyon.org.uk>
 <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811135419.GA1263716@miu.piliscsaba.redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 11, 2020 at 03:54:19PM +0200, Miklos Szeredi wrote:
> On Wed, Aug 05, 2020 at 10:24:23AM +0200, Miklos Szeredi wrote:
> > On Tue, Aug 4, 2020 at 4:36 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > 
> > > I think we already lost that with the xattr API, that should have been
> > > done in a way that fits this philosophy.  But given that we  have "/"
> > > as the only special purpose char in filenames, and even repetitions
> > > are allowed, it's hard to think of a good way to do that.  Pity.
> > 
> > One way this could be solved is to allow opting into an alternative
> > path resolution mode.
> > 
> > E.g.
> >   openat(AT_FDCWD, "foo/bar//mnt/info", O_RDONLY | O_ALT);
> 
> Proof of concept patch and test program below.
> 
> Opted for triple slash in the hope that just maybe we could add a global
> /proc/sys/fs/resolve_alt knob to optionally turn on alternative (non-POSIX) path
> resolution without breaking too many things.  Will try that later...
> 
> Comments?

Hell, NO.  This is unspeakably tasteless.  And full of lovely corner cases wrt
symlink bodies, etc.

Consider that one NAKed.  I'm seriously unhappy with the entire fsinfo thing
in general, but this one is really over the top.
